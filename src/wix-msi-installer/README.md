# wix-msi-installer README.md

# WiX MSI Installer Project

This project demonstrates how to create an MSI installer using the WiX Toolset and PowerShell scripting.

## Project Structure

- `src/scripts/build-installer.ps1`: PowerShell script that defines the build process for generating the MSI installer using WiX.
- `src/wix/sample.wxs`: WiX configuration file that defines the structure of the MSI installer, including product information, installation directories, components, and features.
- `README.md`: Documentation for the project, including setup instructions and usage.
- `.gitignore`: List of files and directories to be ignored by Git, typically including build artifacts and temporary files.

## Setup Instructions

1. Ensure you have the WiX Toolset installed on your machine.
2. Clone this repository to your local machine.
3. Open a PowerShell terminal and navigate to the project directory.
4. Run the build script to generate the MSI installer:
   ```powershell
   .\src\scripts\build-installer.ps1
   ```

## Usage

After running the build script, you will find the generated MSI installer in the output directory specified in the `build-installer.ps1` script. You can then use this installer to install the application on target machines.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.