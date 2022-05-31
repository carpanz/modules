
incude { CLASSIFY_UNMAPPED } from '../../../../subworkflows/local/classify_unmapped/main.nf'

workflow test_classify_unmapped {

    bam = [ [ id:'test', single_end:false ], // meta map
                file("path/to/test.bam", checkIfExists: true)
            ]

    CLASSIFY_UNMAPPED ( bam )

}
