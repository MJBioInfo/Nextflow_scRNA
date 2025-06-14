🔬 Single-Cell RNA-seq Workflow using Nextflow + Docker
A reproducible pipeline for analyzing single-cell RNA sequencing (scRNA-seq) data using Nextflow and Docker, featuring Seurat for data processing.

📁 Project Structure

Nextflow_scRNA/
├── main.nf                # Main Nextflow workflow
├── nextflow.config       # Docker/Conda configurations
├── modules/             # Workflow modules
├── data/               # Input data
│   ├── control/
│   └── stim_treatment/
├── results/           # Output files
├── logs/             # Log files
└── README.md

🧰 Prerequisites
1. Install Homebrew

````

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

````

2. Install Nextflow


````
# Using Homebrew
brew install nextflow

# Or using SDKMAN
curl -s https://get.sdkman.io | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install nextflow

````

3. Docker Desktop Setup
Download from Docker Desktop for Mac
Configure shared paths:
Open Docker Desktop → Settings → Resources → File Sharing
Add: Nextflow_scRNA
🚀 Running the Pipeline
Navigate to Project


````

cd /Users/majeedjamakhani/MJ-IMM/Personal/Learn-update/Workflow-learn/Nextflow_scRNA

````


4. Execute Workflow

`````

# Using Docker (Apple Silicon)
nextflow run main.nf -profile docker --docker-options "--platform linux/amd64"

# Using Conda
nextflow run main.nf -profile conda

`````

5. ⚙️ Configuration Details
Docker Settings
Image: majeedjamakhani/sc_gimm_nxt:sc--9805fdd00427d207
Seurat: satijalab/seurat:5.0.0
Conda Settings
Environment: my_r_env
Enabled Features
conda.enabled = true
docker.enabled = true
🧪 Troubleshooting


6. Mount Issues

````

# Error: "Mounts denied: The path ... is not shared from the host"
# Solution: Add path in Docker Desktop → Settings → Resources → File Sharing

````

7. Platform Compatibility

````
# Warning: Platform mismatch (linux/amd64 vs linux/arm64/v8)
# Solution: Use platform flag
nextflow run main.nf -profile docker --docker-options "--platform linux/amd64"

````

👨‍🔬 Author
Dr. Majeed Jamakhani
GIMM Research, Portugal

📄 License
Academic/research use only. Contact author for other uses.