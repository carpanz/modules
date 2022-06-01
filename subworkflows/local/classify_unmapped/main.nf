
include { SAMTOOLS_VIEW   as SAMTOOLS_VIEW_SINGLE     } from '../../../modules/samtools/view/main.nf'
include { SAMTOOLS_VIEW   as SAMTOOLS_VIEW_BOTH       } from '../../../modules/samtools/view/main.nf'
include { SAMTOOLS_FASTQ  as SAMTOOLS_FASTQ_SINGLE    } from '../../../modules/samtools/fastq/main.nf'
include { SAMTOOLS_FASTQ  as SAMTOOLS_FASTQ_BOTH      } from '../../../modules/samtools/fastq/main.nf'
include { KRAKEN2_KRAKEN2 as KRAKEN2_SINGLE           } from '../../../modules/kraken2/kraken2/main.nf'
include { KRAKEN2_KRAKEN2 as KRAKEN2_BOTH             } from '../../../modules/kraken2/kraken2/main.nf'
include { PARSEOUTPUTS                                } from '../../../modules/local/parseoutputs/main.nf'

workflow CLASSIFY_UNMAPPED {

    take:
    bam   // channel: [ val(meta), [ bam ] ]

    main:

    ch_versions = Channel.empty()

    SAMTOOLS_VIEW_SINGLE ( bam, [] )
    ch_versions = ch_versions.mix(SAMTOOLS_VIEW_SINGLE.out.versions)

    SAMTOOLS_VIEW_BOTH ( bam, [] )
    ch_versions = ch_versions.mix(SAMTOOLS_VIEW_BOTH.out.versions)

    PARSEOUTPUTS ( SAMTOOLS_VIEW_SINGLE.out.bam )
    ch_versions = ch_versions.mix(PARSEOUTPUTS.out.versions)

    SAMTOOLS_FASTQ_SINGLE ( SAMTOOLS_VIEW_SINGLE.out.bam )
    ch_versions = ch_versions.mix(SAMTOOLS_FASTQ_SINGLE.out.versions)

    SAMTOOLS_FASTQ_BOTH ( SAMTOOLS_VIEW_BOTH.out.bam )
    ch_versions = ch_versions.mix(SAMTOOLS_FASTQ_BOTH.out.versions)

    KRAKEN2_SINGLE ( SAMTOOLS_FASTQ_SINGLE.out.fastq )
    ch_versions = ch_versions.mix(KRAKEN2_SINGLE.out.versions)

    KRAKEN2_BOTH ( SAMTOOLS_FASTQ_BOTH.out.fastq )
    ch_versions = ch_versions.mix(KRAKEN2_BOTH.out.versions)

    emit:
    classified_single        = KRAKEN2_SINGLE.out.classified_reads_assignment
    classified_both          = KRAKEN2_BOTH.out.classified_reads_assignment
    candidate_integrations   = PARSEOUTPUTS.out.integration_sites
    versions                 = ch_versions            // channel: [ versions.yml ]

}
