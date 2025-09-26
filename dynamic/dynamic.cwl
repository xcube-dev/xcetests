cwlVersion: v1.0
$namespaces:
  s: https://schema.org/
s:softwareVersion: 1.0.0
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: dynamic
    label: xcengine notebook
    doc: xcengine notebook
    requirements: []
    inputs:
      periods:
        label: periods
        doc: periods
        type: long
        default: 10
    outputs:
      - id: stac_catalog
        type: Directory
        outputSource:
          - run_script/results
    steps:
      run_script:
        run: '#xce_script'
        in:
          periods: periods
        out:
          - results
  - class: CommandLineTool
    id: xce_script
    requirements:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcetest-dyn:1
    hints:
      DockerRequirement:
        dockerPull: quay.io/bcdev/xcetest-dyn:1
    baseCommand:
      - /usr/local/bin/_entrypoint.sh
      - python
      - /home/mambauser/execute.py
    arguments:
      - --batch
      - --eoap
    inputs:
      periods:
        label: periods
        doc: periods
        type: long
        default: 10
        inputBinding:
          prefix: --periods
    outputs:
      results:
        type: Directory
        outputBinding:
          glob: .
