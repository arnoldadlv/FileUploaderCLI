
FileUploaderCLI

Description:
A bash-based CLI tool that uploads files into an Azure storage account. This tool provides a simple way to manage file uploads by interacting with Azure's API and using the Azure CLI for authentication and file handling.

Features:
- Upload files to a specified Azure storage account.
- Check if a storage account exists before attempting an upload.
- Prompts for missing information interactively.
- Supports command-line arguments for non-interactive use.

Prerequisites:
- Bash (for running the script)
- Azure CLI installed and logged in (`az login`)
- `jq` installed (for JSON parsing)
- Valid Azure subscription and access to Azure storage accounts

Installation:
1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/FileUploaderCLI.git
    cd FileUploaderCLI
    ```

2. Ensure that the Azure CLI is installed:
    ```bash
    # Check if Azure CLI is installed
    az --version
    ```

3. Install `jq` for JSON parsing:
    ```bash
    # For Debian/Ubuntu systems
    sudo apt-get install jq
    
    # For MacOS (using Homebrew)
    brew install jq
    ```

Usage:
Run the script with appropriate command-line arguments or interactively enter the required details.

Command-line Arguments:
- `--help`: Display usage instructions.
- `--file-name [name]`: Specify the name of the file to upload.
- `--storage-account [name]`: Specify the Azure storage account name.
- `--container [name]`: Specify the name of the container within the storage account.

Example Commands:

1. Upload a file using command-line arguments:
    ```bash
    ./stfileupload.sh --file-name example.txt --storage-account mystorageaccount --container mycontainer
    ```

2. Run interactively (if no arguments are provided):
    ```bash
    ./stfileupload.sh
    ```

3. Display help information:**
    ```bash
    ./stfileupload.sh --help
    ```

 Workflow:
1. Checks for Required Arguments:
   The script checks if the required arguments (`--file-name`, `--storage-account`, and `--container`) are provided. If not, it prompts the user to enter the missing information.

2. Check if Storage Account Exists:
   The script uses Azure's API to check if the specified storage account exists. If the account does not exist, it exits with an error message.

3. Upload File to Azure Storage:
   If the storage account exists, the script logs into Azure and uploads the specified file to the defined storage account and container.

Notes:
- Ensure you are logged in to Azure using `az login` before running the script.
- The storage account and container must exist in your Azure subscription.



