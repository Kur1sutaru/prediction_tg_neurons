expr_table <- read.csv("neuronstg.csv", check.names = FALSE)
rownames(expr_table) <- make.unique(as.character(expr_table[[1]]))
expr_table <- expr_table[, -1]  # Remove the gene name column now in rownames


# Define genes of interest
genes_of_interest <- c(
  "Adra2a", "Atf3", "Bmpr1b", "Cadps2", "Calb1", "Calca", "Chrna7", "Hpca",
  "Jun", "Kit", "Lpar3", "Mrgpra3", "Mrgprb4", "Mrgprd", "Nefh", "Nppb",
  "Ntrk2", "Ntrk3", "Oprk1", "S100a6", "Scn11a", "Smr2", "Sst", "Sstr2",
  "Tafa4", "Th"
)

# Load CSV with gene names in first column
expr_table <- read.csv("neuronstg.csv", check.names = FALSE, row.names = 1)

# Check how your rownames look
cat("First few rownames:\n")
print(head(rownames(expr_table)))

# Match only genes that actually exist
matching_genes <- intersect(genes_of_interest, rownames(expr_table))
cat("Matching genes:\n")
print(matching_genes)

# Subset expression table
subset_expr <- expr_table[matching_genes, , drop = FALSE]

# Make sure we still have columns
if (ncol(subset_expr) > 0) {
  for (colname in colnames(subset_expr)) {
    sample_data <- subset_expr[, colname, drop = FALSE]
    write.csv(sample_data, paste0(gsub("[^A-Za-z0-9]", "_", colname), "_subset_genes.csv"), quote = FALSE)
  }
} else {
  stop("No columns found in the expression matrix. Please check your table format.")
}
