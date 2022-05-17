nextflow.enable.dsl = 2

include { PARSEOUTPUTS } from '../../../../modules/local/parseoutputs/main.nf'

workflow test_local_parseoutputs {

    input = [
        [ id:'test', single_end:false ], // meta map
        file("/home/shared_projects/tesi_simone_carpanzano/file_plot/test_nfcore/SRR17085829_singleUnmapped.bam", checkIfExists: true)
    ]

    kraken_results = file("/home/shared_projects/tesi_simone_carpanzano/file_plot/test_nfcore/SRR17085829_singleUnmapped_classified.txt", checkIfExists: true)

    PARSEOUTPUTS ( input , kraken_results )
}
