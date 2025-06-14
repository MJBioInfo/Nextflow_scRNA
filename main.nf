
/*
=================================================================================================
Title : Nextflow workflow on Single cell analysis
=================================================================================================

Author : Dr. Majeed Jamakhani
=================================================================================================
*/


/*
=================================================================================================
Input Directories
=================================================================================================

*/

params.data_dir = 'data'
params.control_dir = "data/control"
params.treatment_dir = "data/stim_treatment"



/*
=================================================================================================
Ouput Directories
=================================================================================================

*/

params.objects = 'objects'
params.results = 'results'
params.output_dir = 'results'
params.figure_dir = 'results/figures'
params.log_dir = 'logs'
params.tables = 'tables'


/*
=================================================================================================
Channels
=================================================================================================

*/

data_ch = Channel.fromPath(params.data_dir , checkIfExists: true)

control_ch = Channel.fromPath(params.control_dir, checkIfExists: true)
treatment_ch = Channel.fromPath(params.treatment_dir, checkIfExists: true)



/*
=================================================================================================
Include Modules
=================================================================================================
*/

include {OBJECT_CREATION_SS} from './modules/object_creation_ss'
include {OBJECT_CREATION_MS} from './modules/object_creation_ms'
include {PREPROCESS} from './modules/preprocess'



/*
=================================================================================================
                                    Workflow 
=================================================================================================

*/

workflow {
    
    OBJECT_CREATION_MS( data_ch )
    PREPROCESS( OBJECT_CREATION_MS.out.merged_object )


        }