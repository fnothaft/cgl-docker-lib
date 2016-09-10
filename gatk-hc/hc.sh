#!/bin/bash

set -e
set -x
set -o pipefail

cd ~

# Set $RAM to use for all java processes
gb_mem=$1
RAM=-Xmx200g

# Set number of threads to the number of cores/machine for speed optimization
THREADS=16

# Set the dir for the reference files and input bam
dir=$2

# Set the reference fasta
ref=$3

# Create Variable for input file
INPUT1=$4
SUFFIX=$5

#choose how to log time
Time=/usr/bin/time

# generate a gvcf
$Time java $RAM \
    -jar /opt/gatk/gatk.jar \
    -nct $THREADS \
    -R ${dir}/${ref} \
    -T HaplotypeCaller \
    --genotyping_mode DISCOVERY \
    --emitRefConfidence GVCF \
    -I ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.bam \
    -o ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.g.vcf \
    -stand_emit_conf 10.0 \
    -stand_call_conf 30.0 \
    -variant_index_type LINEAR \
    -variant_index_parameter 128000 \
    --annotation QualByDepth \
    --annotation FisherStrand \
    --annotation StrandOddsRatio \
    --annotation ReadPosRankSumTest \
    --annotation MappingQualityRankSumTest \
    --annotation RMSMappingQuality \
    --annotation InbreedingCoeff

# genotype the gvcf
$Time java $RAM \
    -jar /opt/gatk/gatk.jar \
    -nt $THREADS \
    -R ${dir}/${ref} \
    -T GenotypeGVCFs \
    --variant ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.g.vcf \
    --out ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.vcf \
    -stand_emit_conf 10.0 \
    -stand_call_conf 30.0

# these are our hard filters
# there are many like them, but these are ours
snp_filter="QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0"
indel_filter="QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0"

# select snps
$Time java $RAM \
    -jar /opt/gatk/gatk.jar \
    -nt $THREADS \
    -R ${dir}/${ref} \
    -T SelectVariants \
    -V ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.vcf \
    -o ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.snps.unfiltered.vcf \
    -selectType SNP

# filter snps
$Time java $RAM \
    -jar /opt/gatk/gatk.jar \
    -nt $THREADS \
    -R ${dir}/${ref} \
    -T FilterVariants \
    -V ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.snps.unfiltered.vcf \
    -o ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.snps.vcf \
    --filterExpression ${snp_filter} \
    --filterName SNP_HARD_FILTER

# select indels
$Time java $RAM \
    -jar /opt/gatk/gatk.jar \
    -nt $THREADS \
    -R ${dir}/${ref} \
    -T SelectVariants \
    -V ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.vcf \
    -o ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.indels.unfiltered.vcf \
    -selectType INDEL

# filter indels
$Time java $RAM \
    -jar /opt/gatk/gatk.jar \
    -nt $THREADS \
    -R ${dir}/${ref} \
    -T FilterVariants \
    -V ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.indels.unfiltered.vcf \
    -o ${dir}/${project}/analysis/${INPUT1}${SUFFIX}.indels.vcf \
    --filterExpression ${indel_filter} \
    --filterName INDEL_HARD_FILTER