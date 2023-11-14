# Read the content from the provided 
$vulns = "path\to\your\.yml"
$fileContent = Get-Content -Path $vulns -Raw

# Split the content into chunks based on "- cvssv3" delimiter
$chunks = $fileContent -split "- cvssv3" | Where-Object { $_ -match '\S' }

# Iterate through each chunk and organize them into separate files
foreach ($chunk in $chunks) {
    # Extract the category from the chunk
    $categoryLine = $chunk -split "`r`n" | Where-Object { $_ -match "category\s*:\s*(.+)" }
    
    # Extract the category value
    if ($categoryLine) {
        $category = $matches[1].Trim()
        
        # Create or append to the corresponding category file
        $categoryFileName = "$category.yml"
        Add-Content -Path $categoryFileName -Value "- cvssv3$chunk"
    }
}

Write-Host "Files created successfully."