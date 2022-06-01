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
            file("/home/shared_projects/tesi_simone_carpanzano/CODP_infection/final_grep_SRR17085829/SRR17085829_chr21_grep_1.fastq.gz", checkIfExists: true),
            file("/home/shared_projects/tesi_simone_carpanzano/CODP_infection/final_grep_SRR17085829/SRR17085829_chr21_grep_2.fastq.gz", checkIfExists: true)
        ]
    ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_21_fasta'],            checkIfExists: true)

    PREPARE_READS ( reads, fasta, "bwa-mem" )
}

workflow test_prepare_reads_mem2 {
    reads = [
        [ id:'test', single_end:false ], // meta map
        [
            file("/home/shared_projects/tesi_simone_carpanzano/CODP_infection/final_grep_SRR17085829/SRR17085829_chr21_grep_1.fastq.gz", checkIfExists: true),
            file("/home/shared_projects/tesi_simone_carpanzano/CODP_infection/final_grep_SRR17085829/SRR17085829_chr21_grep_2.fastq.gz", checkIfExists: true)
        ]
    ]
    fasta = file(params.test_data['homo_sapiens']['genome']['genome_21_fasta'],            checkIfExists: true)

    PREPARE_READS ( reads, fasta, "bwa-mem2" )
}
