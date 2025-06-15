process DEG_ANALYSIS {
    tag "DEG analysis using Seurat"

    publishDir params.objects, mode: 'copy', pattern: '*.rds'
    publishDir params.figure_dir, mode: 'copy', pattern: '*.png'

    input:
    path preprocessed_object

    output:
    path("*")
    

    path("pb_markers.rds") , emit : pb_markers
    path("pb_top10_heatmap.png")

    script:
    """
    #!/usr/bin/env Rscript
    library(Seurat)
    library(tidyverse)

    # Load preprocessed Seurat object
    seurat_obj <- readRDS("${preprocessed_object}")

    # Find markers
    pb_markers <- FindAllMarkers(seurat_obj, only.pos = TRUE, test.use = "wilcox")

    # Save marker table
    saveRDS(pb_markers, "pb_markers.rds")

    # Add gene column from rownames
    top10 <- pb_markers %>%
    rownames_to_column(var = "gene") %>%
    group_by(cluster) %>%
    filter(avg_log2FC > 1) %>%
    slice_head(n = 10) %>%
    ungroup()

    # Generate heatmap
    heatmap_plot <- DoHeatmap(seurat_obj, features = top10\$gene) + NoLegend()
    ggsave("pb_top10_heatmap.png", plot = heatmap_plot)

    """

}
