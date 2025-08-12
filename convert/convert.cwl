cwlVersion: v1.0
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.0.0
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: xceconvert-9
    label: xcengine notebook
    doc: xcengine notebook
    requirements: []
    inputs:
      fn:
        label: fn
        doc: fn
        type: string
        default: resize
      size:
        label: size
        doc: size
        type: string
        default: 50%
      url:
        label: url
        doc: url
        type: string
        default: https://eoepca.org/media_portal/images/logo6_med.original.png
    outputs:
      - id: stac_catalog
        type: Directory
        outputSource:
          - run_script/results
    steps:
      run_script:
        run: '#xce_script'
        in:
          fn: fn
          size: size
          url: url
        out:
          - results
  - class: CommandLineTool
    id: xce_script
    requirements:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcetest-convert:9
    hints:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcetest-convert:9
    baseCommand:
      - /usr/local/bin/_entrypoint.sh
      - python
      - /home/mambauser/execute.py
    arguments:
      - --batch
      - --eoap
    inputs:
      fn:
        label: fn
        doc: fn
        type: string
        default: resize
        inputBinding:
          prefix: --fn
      size:
        label: size
        doc: size
        type: string
        default: 50%
        inputBinding:
          prefix: --size
      url:
        label: url
        doc: url
        type: string
        default: https://eoepca.org/media_portal/images/logo6_med.original.png
        inputBinding:
          prefix: --url
    outputs:
      results:
        type: Directory
        outputBinding:
          glob: .
