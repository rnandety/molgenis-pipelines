#MOLGENIS nodes=1 ppn=10 mem=8gb walltime=10:00:00

#string stage
#string checkStage
#string rRNAdustVersion
#string WORKDIR
#string projectDir
#string rRNAfilteredDir
#string reads1FqGz
#string reads2FqGz
#string sampleName
#string rRNArefSeq

#getFile ${reads1FqGz}

${stage} rRNAdust/${rRNAdustVersion}
${checkStage}

echo "## "$(date)" ##  $0 Started "

mkdir -p ${rRNAfilteredDir}
echo ${rRNAfilteredDir}/${reads1FqGz##*/} 
if rRNAdust ${rRNArefSeq}  ${reads1FqGz} > ${rRNAfilteredDir}/${reads1FqGz##*/}
then
    if [ ${#reads2FqGz} -eq 1 ];
    then
        echo 'paired end'
        if rRNAdust ${rRNArefSeq}  ${reads2FqGz} > ${rRNAfilteredDir}/${reads2FqGz##*/}
        then
            echo "returncode: 0";
            #putFile ${rRNAfilteredDir}/${reads1FqGz##*/}
            #putFile ${rRNAfilteredDir}/${reads2FqGz##*/}
            echo "succes moving files";
        else
            echo "returncode: $?";
            echo "fail";
        fi
    else
        echo "returncode: 0";
        echo ${rRNAfilteredDir}/${reads1FqGz##*/}
        #putFile ${rRNAfilteredDir}/${reads1FqGz##*/}
        echo "succes moving files";
    fi
else
    echo "returncode: $?";
    echo "fail";
fi

echo "## "$(date)" ##  $0 Done "