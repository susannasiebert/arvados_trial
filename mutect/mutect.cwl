#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
label: "mutect2 (GATK 3.6)"
baseCommand: ["/usr/local/bin/jdk1.8.0_45/bin/java", "-jar", "/usr/local/bin/GATK3.6/GenomeAnalysisTK.jar", "-T", "MuTect2"]
requirements:
    - class: DockerRequirement
      dockerPull: "dbmi/gatk-docker:latest@sha256:7e7d7911d51b0109cd1db1b5ac824287c7af013da29fe28022289ff62940f0be" #GATK 3.6 at a specific container revision
arguments:
    ["-o", { valueFrom: $(runtime.outdir)/output.vcf.gz }]
inputs:
    reference:
        type: File
        inputBinding:
            prefix: "-R"
            position: 1
        secondaryFiles: [".fai", "^.dict"]
    tumor_bam:
        type: File
        inputBinding:
            prefix: "-I:tumor"
            position: 2
        secondaryFiles: .bai
    normal_bam:
        type: File
        inputBinding:
            prefix: "-I:normal"
            position: 3
        secondaryFiles: .bai
    interval_list:
        type: File
        inputBinding:
            prefix: "-L"
            position: 4
outputs:
    vcf:
        type: File
        outputBinding:
            glob: "output.vcf.gz"
