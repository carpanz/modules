process PARSEOUTPUTS {
    tag "$meta.id"
    label 'process_low'

    conda (params.enable_conda ? "mulled-v2-8dd8177cf5b9476288c149088f4340b576b866e3" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/mulled-v2-8dd8177cf5b9476288c149088f4340b576b866e3:0e17efd831b210a161d3b4b93fd9dab3479446ba-0':
        'quay.io/biocontainers/mulled-v2-8dd8177cf5b9476288c149088f4340b576b866e3:0e17efd831b210a161d3b4b93fd9dab3479446ba-0' }"

    input:
    tuple val(meta), path(bam)
    path kraken_results

    output:
    tuple val(meta), path("*_parsed_kraken.txt"), emit: kraken_parsed
    tuple val(meta), path("*_parsed_integration_sites.txt"), emit: integration_sites
    path "versions.yml"           , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    samtools \\
        view \\
        $args \\
        -@ $task.cpus \\
        -T $prefix \\
        $bam | cut -f 1,3,8 > ${prefix}_parsed_integration_sites.txt

    awk -vOFS='\t' 'match(\$0, /\\(taxid (.+)\)/, a) {print \$2, a[1]}' $kraken_results > ${prefix}_parsed_kraken.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        local: \$(echo \$(samtools --version 2>&1) | sed 's/^.*samtools //; s/Using.*\$//' ))
    END_VERSIONS
    """
}
