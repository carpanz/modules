#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CLASSIFY_UNMAPPED } from '../../../../subworkflows/local/classify_unmapped/main.nf'

workflow test_classify_unmapped {

    input = [ [ id:'test', single_end:false ], // meta map
                file("/home/shared_projects/tesi_simone_carpanzano/output_test_prepare_reads/bwamem1/test.bam", checkIfExists: true)
            ]
    db = [ path("/home/shared_projects/REFS/kraken_db") ]
    CLASSIFY_UNMAPPED ( input, db )

}
