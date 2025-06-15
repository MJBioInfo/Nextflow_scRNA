process DEG_ANALYSIS {
    tag "DEG analysis using Seurat"

    publishDir params.objects, mode: 'copy', pattern: '*.rds'
    publishDir params.figure_dir, mode: 'copy', pattern: '*.png'

    input:
    path preprocessed_object

    output:
    path("*")
    

    path("pb_markers.rds") 
    path("pb_top10_heatmap.png")

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    library(tidyverse)

    # Load preprocessed Seurat object
    seurat_obj <- readRDS("${preprocessed_object}")

    seurat_obj <- JoinLayers(seurat_obj)
    
    # Find markers
    pb_markers_2 <- FindMarkers(seurat_obj, ident.1 = 2)


    # Save marker table
    saveRDS(pb_markers_2, "pb_markers.rds")

    # Add gene column from rownames
    top10 <- pb_markers_2 %>%
    rownames_to_column(var = "gene") %>%
    group_by(cluster) %>%
    filter(avg_log2FC > 1) %>%
    slice_head(n = 10) %>%
    ungroup()

    # Generate heatmap
    heatmap_plot_cluster2 <- DoHeatmap(seurat_obj, features = top10\$gene) + NoLegend()
    ggsave("pb_top10_heatmap_cluster2.png", plot = heatmap_plot_cluster2)

    """

}
