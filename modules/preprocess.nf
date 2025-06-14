/*
=================================================================================================
            Preprocess seurat object
=================================================================================================

*/

process PREPROCESS {

    tag {"Preprocess of Seurat object"}
    publishDir params.objects , mode: 'copy' , pattern: '*.rds'
    publishDir params.tables , mode: 'copy' , pattern: '*.csv'
    publishDir params.figure_dir , mode: 'copy' , pattern: '*.png'

    
    input:
    
    path(merged_object )

    output:

    path("*")
    path("preprocessed_object.rds") , emit : preprocessed_object

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    library(tidyverse)
    
    
    preprocessed_object <- readRDS("${merged_object}")

    # Preprocessing of Seurat object

    preprocessed_object[["novelty_score"]] <- log10(preprocessed_object[["nFeature_RNA"]]) / log10(preprocessed_object[["nCount_RNA"]]) 

    preprocessed_object <- preprocessed_object %>% NormalizeData() %>% FindVariableFeatures() %>% ScaleData() %>% RunPCA() %>% FindNeighbors() %>% FindClusters() %>% RunUMAP(dims = 1:10)
    
    # Add some metadata

    preprocessed_object[["cells"]] <- preprocessed_object[["orig.ident"]]


    # Plot accroding to UMAP with orig.ident or sample name

    samplewise_umap = DimPlot(preprocessed_object , reduction = "umap", group.by = "orig.ident")
    ggsave("samplewise_umap.png", samplewise_umap )
                       
    
    # Save the preprocessed object
    saveRDS(preprocessed_object , "preprocessed_object.rds")

    # Add metadata to preprocessed object
    metadata_qc = preprocessed_object@meta.data
    write_csv(metadata_qc, "metadata_qc.csv")
    

    """

}
