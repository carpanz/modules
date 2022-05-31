
incude { CLASSIFY_UNMAPPED } from '../../../../subworkflows/local/classify_unmapped/main.nf'

workflow test_classify_unmapped {

    bam = [ [ id:'test', single_end:false ], // meta map
                file("/home/shared_projects/tesi_simone_carpanzano/output_test_prepare_reads/bwamem1/test.bam", checkIfExists: true)
            ]

    CLASSIFY_UNMAPPED ( bam )

}
