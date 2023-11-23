#!/usr/bin/env cwl-runner

class: CommandLineTool
id: bcftools-filter-MAC
label: bcftools-filter-MAC
cwlVersion: v1.1

$namespaces:
  cwltool: http://commonwl.org/cwltool#

requirements:
  DockerRequirement:
    dockerPull: quay.io/biocontainers/bcftools:1.18--h8b25389_0
  ShellCommandRequirement: {}

baseCommand: [ bcftools, filter, -Oz ]

inputs:
  input_vcf:
    type: File
    doc: input VCF file
    inputBinding:
      position: 3

  mac:
    type: float
    doc: cut-off of MAC

  prefix:
    type: string
    doc: Output file prefix

outputs:
  output_vcf:
    type: File
    outputBinding:
      glob: $(inputs.prefix).vcf.gz

arguments:
  - position: 1
    prefix: -o
    valueFrom: $(inputs.prefix).vcf.gz
  - position: 2
    prefix: --exclude
    valueFrom: INFO/MAC<$(inputs.mac)

