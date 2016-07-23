#!/usr/bin/env python2.7

import os
import subprocess
import unittest


class TestADAMPipeline(unittest.TestCase):

    def test_docker_call(self):

        # get working directory
        pwd = os.getcwd()
        outfile = '%s/test/small.processed.bam' % pwd

        # check for output file in ./test and clean if necessary
        if os.path.exists(outfile):
            os.remove(outfile)

        # build commandline
        tool = ['quay.io/ucsc_cgl/adam-pipeline']
        base = ['docker', 'run']
        args = ['python', '/opt/adam-pipeline/wrapper.py',
                '--sample', '/%s/test/small.sam' % pwd,
                '--known-sites', '/%s/test/small.vcf' % pwd,
                '--output', '/%s/test/small.processed.bam' % pwd,
                '--memory', '1']
        mounts = ['-v', '/%s/test:/%s/test' % (pwd, pwd)]

        # Check base call for help menu
        out = subprocess.check_output(base + tool)
        self.assertTrue('Please see the complete documentation' in out)

        # run full command on sample inputs and check for existence of output file
        cmd = base + mounts + tool + args
        import sys
        print >> sys.stderr, cmd
        print >> sys.stderr, " ".join(cmd)
        out = subprocess.check_output(base + mounts + tool + [" ".join(args)])
        print >> sys.stderr, out
        self.assertTrue(os.path.exists(outfile))


    @unittest.skipIf("CROMWELL_HOME" not in os.environ,
                     "Path to cromwell not defined by $CROMWELL_HOME")
    def test_wdl_call():

        # get working directory
        pwd = os.getcwd()
        outfile = '%s/test/outdir/small.processed.bam' % pwd

        # check for output file in ./test and clean if necessary
        if os.path.exists(outfile):
            os.remove(outfile)

        # set up cromwell args
        cmd = ["%s/cromwell" % os.environ["CROMWELL_HOME"],
               "run",
               "%s/workflow.wdl" % pwd,
               "%s/workflow.json" % pwd]

        # run cromwell
        subprocess.check_call(cmd)
        self.assertTrue(os.path.exists(outfile))
        

if __name__ == '__main__':
    unittest.main()
