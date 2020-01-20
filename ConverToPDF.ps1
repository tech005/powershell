# delete/move the pdf and run again if you want to update

# creating an array with the paths i want included
$schoolDrives = 'C:\Users\ryans\OneDrive - Nova Scotia Community College',`
                'C:\Users\ryans\OneDrive - Nova Scotia Community College\CyberOps',`
                'C:\Users\ryans\OneDrive - Nova Scotia Community College\Capstone',`
                'C:\Users\ryans\OneDrive - Nova Scotia Community College\Comm4700'

#looping through the array
foreach ($path in $schoolDrives) {

#setting the word app
$word_app = New-Object -ComObject Word.Application

# getting all files with doc or docx and opening them with word saving as pdf with .pdf extention then quitting word
Get-ChildItem -Path $path -Filter *.doc? | ForEach-Object {

    $document = $word_app.Documents.Open($_.FullName)

    $pdf_filename = "$($_.DirectoryName)\$($_.BaseName).pdf"

    $document.SaveAs([ref] $pdf_filename, [ref] 17)

    $document.Close()
}
$word_app.Quit()
}