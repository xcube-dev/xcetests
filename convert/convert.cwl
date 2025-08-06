cwlVersion: v1.0
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.0.0
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: xcengine_ap
    label: xcengine notebook
    doc: xcengine notebook
    requirements: []
    inputs:
      url:
        label: url
        doc: url
        type: string
        default: https://eoepca.org/media_portal/images/logo6_med.original.png
      size:
        label: size
        doc: size
        type: string
        default: 50%
      fn:
        label: fn
        doc: fn
        type: string
        default: resize
    outputs:
      - id: stac_catalog
        type: Directory
        outputSource:
          - run_script/results
    steps:
      run_script:
        run: '#xce_script'
        in:
          url: url
          size: size
          fn: fn
        out:
          - results
  - class: CommandLineTool
    id: xce_script
    requirements:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcetest-convert:1.2
    hints:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcetest-convert:1.2
    baseCommand:
      - /usr/local/bin/_entrypoint.sh
      - python
      - /home/mambauser/execute.py
    arguments:
      - --batch
      - --eoap
    inputs:
      url:
        label: url
        doc: url
        type: string
        default: https://eoepca.org/media_portal/images/logo6_med.original.png
        inputBinding:
          prefix: --url
      size:
        label: size
        doc: size
        type: string
        default: 50%
        inputBinding:
          prefix: --size
      fn:
        label: fn
        doc: fn
        type: string
        default: resize
        inputBinding:
          prefix: --fn
    outputs:
      results:
        type: Directory
        outputBinding:
          glob: .
