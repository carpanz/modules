#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { RANALYSIS } from '../../../modules/ranalysis/main.nf'

workflow test_ranalysis {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    RANALYSIS ( input )
}
