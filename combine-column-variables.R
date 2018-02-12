# ----- Combine column variables

# Combine the columns with sums
combined <- as.data.frame(lapply( split(seq_len(ncol(gids_matrix)), colnames(gids_matrix)), function(x) rowSums(gids_matrix[x]) ))
