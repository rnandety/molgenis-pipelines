#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=03:00:00

#Parameter mapping

#string projectResultsDir
#string project
#string intermediateDir
#string projectLogsDir
#string projectQcDir
#string scriptDir
#list externalSampleID
#string contact
#string qcMatricsList
#string gcPlotList
#string seqType
#string RVersion
#string wkhtmltopdfVersion
#string fastqcVersion
#string samtoolsVersion
#string picardVersion
#string anacondaVersion
#string starVersion
#string genome

#genarate qcMatricsList

rm -f ${qcMatricsList}
rm -f ${gcPlotList}
 
for sample in "${externalSampleID[@]}" 
do
        echo -e "$intermediateDir/${sample}.total.qc.metrics.table" >> ${qcMatricsList}
done

#genarate gcPlotList
 
for sample in "${externalSampleID[@]}"
do
        echo -e "$intermediateDir/${sample}.GC.png" >> ${gcPlotList}
done


cat > ${intermediateDir}/${project}_QCReport.rhtml <<'_EOF'
<html>
<head>
  <title>${project} QCReport</title>
</head>
<style type="text/css">
      div.page {
	page-break-after: always;
      	padding-top: 60px;
	padding-left: 40px;
      }
</style>
<body style="font-family: monospace;">

<div class="page" style="text-align:center;">
<font STYLE="font-size: 45pt;">
<br>
<br>
<br>
<br>
<br>
<br>
  <b>Next Generation Sequencing report</b>
</font>
<font STYLE="font-size: 30pt;">
<br>
<br>
<br>
<br>
  Genome Analysis Facility (GAF), Genomics Coordination Centre (GCC)
<br>
<br>

  University Medical Centre Groningen
<script language="javascript">
	var month=new Array(12);
	month[0]="January";
	month[1]="February";
	month[2]="March";
	month[3]="April";
	month[4]="May";
	month[5]="June";
	month[6]="July";
	month[7]="August";
	month[8]="September";
	month[9]="October";
	month[10]="November";
	month[11]="December";
	var currentTime = new Date()
	var month =month[currentTime.getMonth()]
	var day = currentTime.getDate()
	var year = currentTime.getFullYear()
  document.write(month + " " + day + ", " + year)
</script>

<div style="text-align:left;">
<br>
<br>
<br>
<br>
<table align=center STYLE="font-size: 30pt;">
	<tr>
		<td><b>Report</b></td>
	</tr>
	<tr>	
		<td>Created on</td>
		<td>
<script language="javascript">
        var month=new Array(12);
        month[0]="January";
        month[1]="February";
        month[2]="March";
        month[3]="April";
        month[4]="May";
        month[5]="June";
        month[6]="July";
        month[7]="August";
        month[8]="September";
        month[9]="October";
        month[10]="November";
        month[11]="December";
        var currentTime = new Date()
        var month =month[currentTime.getMonth()]
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()
  document.write(month + " " + day + ", " + year)
</script>
		</td>
	</tr>
	<tr>	
		<td>Generated by</td><td>MOLGENIS Compute</td>
	</tr>
	<tr></tr><td></td>
	<tr>
		<td><b>Project</b></td>
	</tr>
	<tr>
		<td>Project name</td><td>${project}</td>
	</tr>
	<tr>
		<td>Number of samples</td>
	</tr>
	<tr></tr><td></td>
	<tr>
		<td><b>Contact</b></td>
	</tr>
	<tr>
		<td>Name</td><td>${contact}</td>
	</tr>
	<tr>
		<td>E-mail</td><td>${contact}</td>
	</tr>				
</table>
</div>
</div>
</p>

<div class="page">
<p>
<h1>Introduction</h1>
<br>
<br>
This report describes a series of statistics about your sequencing data. Together with this 
report you'll receive alignment files and geneCount tables. If you, in addition, also want 
the raw data, then please notify us via e-mail. In any case we'll delete the raw data, 
three months after <script language="javascript">
        var month=new Array(12);
        month[0]="January";
        month[1]="February";
        month[2]="March";
        month[3]="April";
        month[4]="May";
        month[5]="June";
        month[6]="July";
        month[7]="August";
        month[8]="September";
        month[9]="October";
        month[10]="November";
        month[11]="December";
        var currentTime = new Date()
        var month =month[currentTime.getMonth()]
        var day = currentTime.getDate()
        var year = currentTime.getFullYear()
  document.write(month + " " + day + ", " + year)
</script>

Description of the RNA Isolation, Sample Preparation and sequencing and different steps used in the RNA analysis pipeline

RNA Isolation, Sample Preparation and sequencing
Initial quality check of and RNA quantification of the samples was performed by capillary
electrophoresis using the LabChip GX (Perkin Elmer). Non-degraded RNA-samples were
selected for subsequent sequencing analysis.
Sequence libraries were generated using the TruSeq RNA sample preparation kits (Illumina)
using the Sciclone NGS Liquid Handler (Perkin Elmer). In case of contamination of adapter-
duplexes an extra purification of the libraries was performed with the automated agarose
gel separation system Labchip XT (PerkinElmer). The obtained cDNA fragment libraries were
sequenced on an Illumina HiSeq2500 using default parameters (single read 1x50bp or Paired
End 2 x 100 bp) in pools of multiple samples.

Gene expression quantification
The trimmed fastQ files where aligned to build ${genome} human reference genome using STAR
${starVersion} [1] allowing for 2 mismatches. Before gene quantification
SAMtools ${samtoolsVersion} [2] was used to sort the aligned reads.
The gene level quantification was performed by HTSeq in Anaconda ${anacondaVersion} [3] using --mode=union
--stranded=no and, Ensembl version 71 was used as gene annotation database which is included
 in folder expression/.

Calculate QC metrics on raw and aligned data
Quality control (QC) metrics are calculated for the raw sequencing data. This is done using
the tool FastQC ${fastqcVersion} [4]. QC metrics are calculated for the aligned reads using
Picard-tools ${picardVersion} [5] CollectRnaSeqMetrics, MarkDuplicates, CollectInsertSize-
Metrics and SAMtools ${samtoolsVersion} flagstat.

These QC metrics form the basis in this  final QC report. 


1. Dobin A, Davis C a, Schlesinger F, Drenkow J, Zaleski C, Jha S, Batut P, Chaisson M,
Gingeras TR: STAR: ultrafast universal RNA-seq aligner. Bioinformatics 2013, 29:15–21.
2. Li H, Handsaker B, Wysoker A, Fennell T, Ruan J, Homer N, Marth G, Abecasis G, Durbin R,
Subgroup 1000 Genome Project Data Processing: The Sequence Alignment/Map format and SAMtools.
Bioinforma 2009, 25 (16):2078–2079.
3. Anders S, Pyl PT, Huber W: HTSeq – A Python framework to work with high-throughput sequencing data
HTSeq – A Python framework to work with high-throughput sequencing data. 2014:0–5.
4. Andrews, S. (2010). FastQC a Quality Control Tool for High Throughput Sequence Data [Online].
Available online at: http://www.bioinformatics.babraham.ac.uk/projects/fastqc/ ${samtoolsVersion}
5. Picard Sourceforge Web site. http://picard.sourceforge.net/ ${picardVersion}


</p>
</div>
</div>

<div>
<!--begin.rcode, engine='python', echo=FALSE, comment=NA, warning=FALSE, message=FALSE , results='asis'
# print out tables with QC stats based on the qcMatricsList

import csv

with open("${qcMatricsList}") as f:
    files = f.read().splitlines()

titles = []
arrayValues = []
isFirst = 'true'

for file in files:
    
    with open(file,'r') as f:
        reader = csv.reader(f, delimiter='\t')

        values = []

        for row in reader:
            if(len(row) > 1):
                if(isFirst == 'true'):
                    titles.append(row[0])
                values.append(row[1])

        arrayValues.append(values)
        isFirst = 'false'

filesNumber = len(arrayValues)
index = len(titles)

arrayResults = []

tableNumbers = int(len(arrayValues) /3)

count = 0

for j in range(0, filesNumber):
    if(count == 0):
        results = []
        for i in range(0, index):
            results.append('')
    for i in range(0, index):
        results[i] += arrayValues[j][i].ljust(30)
    count += 1
    if(count == 3):
        count = 0
        arrayResults.append(results)
    elif(j == filesNumber - 1):
        arrayResults.append(results)

arraySize = len(arrayResults)

print('<h1>Project analysis results</h1>')

for j in range (0, arraySize):
    print('<div class="page"><h2 style="text-align:center">Table ' + str(j+1) +': Overview statistics</h2></br>')
    ress = arrayResults[j]
    for i in range(0, index):
        print(titles[i].ljust(60) + ress[i].ljust(30))
    print('</div>') 

end.rcode-->
</div>

<div class="page">
<p>
<h1>Distribution of GC percentage</h1>
<br>
The following figures show the GC distribution per sample.
<br>
<br>
<!--begin.rcode, engine='bash', echo=FALSE, comment=NA, warning=FALSE, message=FALSE, results='asis'
#prints a table with GC percentage plots, 3 per row.

declare -a LIST=("${externalSampleID[@]}")

ROWS=${#LIST[@]}
COLS=3
COUNT=0

echo "<table>"
for ((RI=0; RI<=$ROWS-1; RI++))
do
  echo "<tr>"
  for ((CI=0; CI<=$COLS-1; CI++))
  do
    
    if [[ "$COUNT" -eq ${#LIST[@]} ]]
    then
    	ROWS=${#LIST[@]}
    	break
    else
    	echo "<td><img src="images/${LIST[$COUNT]}.GC.png" alt="images/${LIST[$COUNT]}.GC.png" width="600" height="600"></td>"
    	COUNT=$COUNT+1
    fi
  done
  echo "</tr>"
done
echo "</table>"

end.rcode-->
</div>
<div class="page">
<p>
<h1>Normalized position vs. coverage</h1>
<br>
The following figures show the a plot of normalized position vs. coverage. 
<br>
<!--begin.rcode, engine='bash', echo=FALSE, comment=NA, warning=FALSE, message=FALSE, results='asis'
#prints a table with coverage plots, 3 per row.
declare -a LIST=("${externalSampleID[@]}")

ROWS=${#LIST[@]}
COLS=3
COUNT=0

echo "<table>"
for ((RI=0; RI<=$ROWS-1; RI++))
do
  echo "<tr>"
  for ((CI=0; CI<=$COLS-1; CI++))
  do

    if [[ "$COUNT" -eq ${#LIST[@]} ]]
    then
        ROWS=${#LIST[@]}
        break
    else
        echo "<td><img src="images/${LIST[$COUNT]}.collectrnaseqmetrics.png" alt="images/${LIST[$COUNT]}.collectrnaseqmetrics.png" width="700" height="700"></td>"
        COUNT=$COUNT+1
    fi
  done
  echo "</tr>"
done
echo "</table>"

end.rcode-->
</div>

<!--begin.rcode, engine='bash', echo=FALSE, comment=NA, warning=FALSE, message=FALSE, results='asis'
#when seqType is PE,prints a table with insertsize plots, 3 per row.

if [ ${seqType} == "PE" ]
then

  echo "<div class="page">"
  echo "<p>"
  echo "<h1>Insert size distribution</h1>"
  echo "<br>"
  echo "The following figures show the insert size distribution per sample. Insert refers to the base pairs that are ligated between the adapters."
  echo "<br>"


  declare -a LIST=("${externalSampleID[@]}")

  ROWS=${#LIST[@]}
  COLS=3
  COUNT=0

  echo "<table>"
  for ((RI=0; RI<=$ROWS-1; RI++))
  do
  echo "<tr>"
  for ((CI=0; CI<=$COLS-1; CI++))
  do

      if [[ "$COUNT" -eq ${#LIST[@]} ]]
      then
          ROWS=${#LIST[@]}
          break
      else
          echo "<td><img src="images/${LIST[$COUNT]}.insertsizemetrics.png" alt="images/${LIST[$COUNT]}.insertsizemetrics.png" width="700" height="700"></td>"
          COUNT=$COUNT+1
      fi
    done
    echo "</tr>"
  done
  echo "</table>"
  echo "</div>"

fi

end.rcode-->

</div>
</font>
</html>
_EOF

module load ${RVersion}
module load ${wkhtmltopdfVersion}
module list

echo "generate QC report."
# generate HTML page using KnitR
R -e 'library(knitr);knit("${intermediateDir}/${project}_QCReport.rhtml","${projectQcDir}/${project}_QCReport.html")'

#remove border
sed -i 's/border:solid 1px #F7F7F7/border:solid 0px #F7F7F7/g' ${projectQcDir}/${project}_QCReport.html

# Copy images to imagefolder
mkdir -p ${projectQcDir}/images
cp ${intermediateDir}/*.collectrnaseqmetrics.png ${projectQcDir}/images
cp ${intermediateDir}/*.GC.png ${projectQcDir}/images

#only available with PE
if [ -f "${intermediateDir}/*.insertsizemetrics.pdf" ]
then
	cp ${intermediateDir}/*.insertsizemetrics.png ${projectQcDir}/images
fi

#convert to pdf

wkhtmltopdf-amd64 --page-size A0 ${projectQcDir}/${project}_QCReport.html ${projectQcDir}/${project}_QCReport.pdf
