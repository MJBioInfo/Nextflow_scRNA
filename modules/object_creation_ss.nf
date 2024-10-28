/*
=================================================================================================
                        Create - Seurat Object
=================================================================================================

*/

process OBJECT_CREATION_SS {

    tag {"Creation of Seurat object"}
    publishDir params.objects , mode: 'copy' , pattern: '*.rds'
    publishDir params.tables , mode: 'copy' , pattern: '*.csv'

    input:
    
    path(control_ch)

    output:

    path("*")

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    library(tidyverse)
    
    

    control.data = Read10X(data.dir = "${control_ch}")
    control.object = CreateSeuratObject(counts = control.data, project = "control", min.cells = 3, min.features = 100)

    saveRDS(control.object, "control_object.rds")

    metadata = control.object@meta.data
    write_csv(metadata, "control_metadata.csv")
    

    """

}