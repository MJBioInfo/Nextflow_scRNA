/*
=================================================================================================
            Create - Seurat Object - for - Multiple - Samples
=================================================================================================

*/

process OBJECT_CREATION_MS {

    tag {"Creation of Seurat object for Multiple samples"}
    publishDir params.objects , mode: 'copy' , pattern: '*.rds'
    publishDir params.tables , mode: 'copy' , pattern: '*.csv'

    input:
    
    path(data_ch)
    

    output:

    path("*")
    path("merged_seurat.rds") , emit : merged_object

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    library(tidyverse)
    
    
    # Create seurat object for each sample using for loop

    for (file in c("control", "stim_treatment")) {
        seurat_data <- Read10X(data.dir = paste0("${data_ch}/", file))
        seurat_obj <- CreateSeuratObject(counts = seurat_data, 
                                         min.features = 100, 
                                         project = file)
        assign(file, seurat_obj)
    }

    merged_seurat <- merge(x = control, y = stim_treatment, 
                       add.cell.id = c("ctrl", "stim"))
                       
    
    
    saveRDS(merged_seurat, "merged_seurat.rds")

    metadata = merged_seurat@meta.data
    write_csv(metadata, "metadata.csv")
    

    """

}