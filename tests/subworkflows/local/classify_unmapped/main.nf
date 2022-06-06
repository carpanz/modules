#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CLASSIFY_UNMAPPED } from '../../../../subworkflows/local/classify_unmapped/main.nf'

workflow test_classify_unmapped {

    input = Channel.from(
            [ [ id:'SRR13106578', single_end:false ], // meta map
                file("/home/shared_projects/tesi_simone_carpanzano/fastqFile/analysis/bwamem1/SRR13106578.bam", checkIfExists: true)
            ],
            [ [ id:'SRR13106582', single_end:false ], // meta map
                file("/home/shared_projects/tesi_simone_carpanzano/fastqFile/analysis/bwamem1/SRR13106582.bam", checkIfExists: true)
            ]
            )
    db = Channel.fromPath("/home/shared_projects/REFS/kraken_db")

    CLASSIFY_UNMAPPED ( input, db )

}
