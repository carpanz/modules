#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { PREPARE_READS } from '../../../../subworkflows/local/reads_preprocess/main'

workflow test_reads_preprocess_mem1 {
    reads = [
        [ id:'test', single_end:false ], // meta map
        [
            file("path/to/_1.fastq.gz", checkIfExists: true),
            file("path/to/_2.fastq.gz", checkIfExists: true)
        ]
    ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_fasta'],            checkIfExists: true)

    PREPARE_READS ( reads, fasta, "bwa-mem" )
}

workflow test_reads_preprocess_mem2 {
    reads = [
        [ id:'test', single_end:false ], // meta map
        [
            file("path/to/_1.fastq.gz", checkIfExists: true),
            file("path/to/_2.fastq.gz", checkIfExists: true)
        ]
    ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_21_fasta'],            checkIfExists: true)

    PREPARE_READS ( reads, fasta, "bwa-mem2" )
}
