
# graph-matrix-and-combinatorics
Graph from table to matrix and combinatorics

This repository contains R functions that help users transform network data from Excel files into directed adjacency matrices and generate all possible combinations of directed and adjacency matrices for a given network. These tools can be useful for those who want to analyze network data, study network dynamics, or implement mathematical models on complex networks.

The main functions provided in this repository are:

- `matrixfromtable`: Processes network data stored in an Excel file and creates a directed adjacency matrix based on a given action number.
- `graphcombinatorics`: Generates all possible combinations of directed and adjacency matrices for a given network based on the number of "unknown" nodes.

## matrixfromtable.R
The function `matrixfromtable` is designed to process network data stored in an Excel file and create a directed adjacency matrix based on the given `actionNumber`. The adjacency matrix is a square matrix used to represent a finite graph, with rows and columns labeled by the graph's vertices. In the directed adjacency matrix, the entry in the ith row and jth column is 1 if there is an edge from vertex i to vertex j, and 0 otherwise.

In this code, the input Excel file is expected to have columns named nodeout, nodein, and action. The actionNumber parameter filters the data to consider only rows where the action value is equal to the specified actionNumber. The filtered data is then used to create the directed adjacency matrix.

The adjacency matrix, in the form of a data frame, is saved to an output Excel file with the name specified by the outputName parameter. Additionally, the function returns a list containing the directed adjacency matrix data frame and the sorted node names.

To use this function, you would need to provide the input Excel file with the network data, specify the desired actionNumber, and provide the name of the output Excel file. The function will then process the data and create the directed adjacency matrix based on the given action number.

For example, to use this function, you can call it like this:

result <- matrixfromtable("input_data.xlsx", 1, "output_data.xlsx")

This will read the network data from input_data.xlsx, create a directed adjacency matrix for the action number 1, save the resulting matrix to output_data.xlsx, and store the output data frame and sorted node names in the result variable.
  
## graphcombinatorics.R [Outdated]
The function `graphcombinatorics` is used to generate all possible combinations of directed and adjacency matrices for a given network, based on the number of "unknown" nodes (nodes with unknown connections). The function uses the previously explained `matrixfromtable` function to create the directed adjacency matrix.

To use this function, you would need to provide the input Excel file with the network data and specify the number of "unknown" nodes. The function will then generate all possible combinations of directed and adjacency matrices for the given network and save them to the "combinations" directory.

For example, to use this function, you can call it like this:

result <- graphcombinatorics("input_data.xlsx", 6)

This will read the network data from input_data.xlsx, generate all possible combinations of directed and adjacency matrices for the network with 6 nodes, save the resulting matrices to separate Excel files in the "combinations" directory, and store the output data in the result variable.

## Applications
These functions can be applied to a wide range of network analysis tasks, such as:

- Biological networks: Analyze gene regulatory networks or protein-protein interaction networks by transforming the network data into adjacency matrices.
- Social network analysis: Investigate the structure and dynamics of social networks by creating adjacency matrices to represent the connections between individuals.
- Other problems concerning networks

## Dependencies
To use the functions in this repository, you will need the following R packages:

- `dplyr`
- `readxl`
- `writexl`

Make sure to install and load these packages before using the functions provided in this repository.

## Contributing
If you have any suggestions, improvements, or bug fixes, please feel free to submit a pull request or open an issue.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.