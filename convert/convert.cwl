cwlVersion: v1.0
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.0.0
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: xceconvert-1
    label: xcengine notebook
    doc: xcengine notebook
    requirements: []
    inputs:
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
          size: size
          fn: fn
          url: url
        out:
          - results
  - class: CommandLineTool
    id: xce_script
    requirements:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcenginetest:1
    hints:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcenginetest:1
    baseCommand:
      - /usr/local/bin/_entrypoint.sh
      - python
      - /home/mambauser/execute.py
    arguments:
      - --batch
      - --eoap
    inputs:
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
