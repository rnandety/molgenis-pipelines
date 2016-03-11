#MOLGENIS walltime=23:59:00 mem=8gb nodes=1 ppn=2

### variables to help adding to database (have to use weave)
#string sampleName
#string project
###
#string stage
#string checkStage

#string WORKDIR
#string projectDir
#string genotypedChrVcfGLDir
#string genotypedChrVcfGL
#string vcf
#string pythonVersion
#string genotypedChrVcfGL

echo "## "$(date)" Start $0"

getFile ${vcf}

${stage} Python/${pythonVersion}
${checkStage}

mkdir -p ${genotypedChrVcfGLDir}

#Run conversion script beagle vcf to shapeit format
if python /groups/umcg-bios/tmp04/users/umcg-aclaringbould/genotyping_pipeline/PL_to_GL/PL_to_GL_reorder.py \
    --vcf ${vcf} \
    --out ${genotypedChrVcfGL}

then
 echo "returncode: $?";
 putFile ${genotypedChrVcfGL}
 cd ${genotypedChrVcfGLDir}
 bname=$(basename ${genotypedChrVcfGL})
 md5sum ${bname} > ${bname}.md5
 cd -
 echo "succes moving files";
else
 echo "returncode: $?";
 echo "fail";
fi

echo "## "$(date)" ##  $0 Done "

