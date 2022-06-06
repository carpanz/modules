#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { CAT } from '../../../../modules/local/cat/main.nf'

workflow test_local_cat {

    input = Channel.from([
        [id: "test1", single_end: false],
        file("file/kraken_reads1", checkIfExists: true)
    ],
    [
        [id: "test2", single_end: false],
        file("file/kraken_reads2", checkIfExists: true)
    ]
    )

    kraken_results = input.collect{it[1]} // [meta, counts]: Collect the second element (classified reads) in the channel across all samples

    CAT ( kraken_results )
}
