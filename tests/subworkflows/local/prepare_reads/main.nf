#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

// params NOT coded in ext.args
params.clip_r1 = null
params.clip_r2 = null
params.three_prime_clip_r1 = null
params.three_prime_clip_r2 = null


include { PREPARE_READS } from '../../../../subworkflows/local/prepare_reads/main.nf'


workflow test_prepare_reads_mem1 {
    reads = [
        [ id:'test', single_end:false ], // meta map
        [
            file(params.test_data['homo_sapiens']['illumina']['test_umi_1_fastq_gz'], checkIfExists: true),
            file(params.test_data['homo_sapiens']['illumina']['test_umi_2_fastq_gz'], checkIfExists: true)
        ]
    ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_21_fasta'],            checkIfExists: true)

    PREPARE_READS ( reads, fasta, "bwa-mem" )
}

workflow test_prepare_reads_mem2 {
    reads = [
        [ id:'test', single_end:false ], // meta map
        [
            file(params.test_data['homo_sapiens']['illumina']['test_umi_1_fastq_gz'], checkIfExists: true),
            file(params.test_data['homo_sapiens']['illumina']['test_umi_2_fastq_gz'], checkIfExists: true)
        ]
    ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_21_fasta'],            checkIfExists: true)

    PREPARE_READS ( reads, fasta, "bwa-mem2" )
}
