#!/usr/bin/env bash

tfSourceDir=(
    $PWD'/provider/'
    $PWD'/data-sources/'
    $PWD'/resources/'
    $PWD'/vars/'
    $PWD'/tfstate/'
)

workingDir=$PWD'/terraformWorkDir/'

# generates the working dir based on Terraform source dir array var
generate_working_dir(){
    clean_working_dir

    printf "Creating Terraform working directory...\n\n"

    mkdir ${workingDir}

    print_line

    for dir in "${tfSourceDir[@]}"
        do
            ln -s ${dir}*.tf* ${workingDir}

            printf "    symlink created to ${dir}\n"

            sleep 0.1
        done

    print_line
}

# Removes the working directory
clean_working_dir(){
    rm -rf ${workingDir}
}

# Print a line with a bunch of "="
print_line(){
    for n in {1..85}
        do
            printf "="
            sleep 0.01

            if [ ${n} == 85 ]; then
                printf "\n"
            fi
        done

}

###################################################################################
################################ Main program #####################################
###################################################################################

if [ "$#" -ne 1 ] || [ $1 == "-h" ]; then
    printf "Usage ./run [option]\n  Options:\n  --generate-work-dir     Generates the terraform working dir, if you want execute terraform commands mannually.\n  --clean-work-dir      Clean an existing working dir.\n  --provision        Automatically provision infrastructure"
    exit 0;
fi

OPTION=$1;

if [ ${OPTION} == "--generate-work-dir"  ]; then
    generate_working_dir
elif [ ${OPTION} == "--clean-work-dir" ]; then
    if [ ! -d ${workingDir} ]; then
        printf "It was not possible to clean the working directory because it does not exist."
        exit 1;
    fi

    clean_working_dir
    printf "Working directory successfully deleted."

elif [ ${OPTION} == "--provision" ]; then
    generate_working_dir

    cd ${workingDir};

    # Performs Terraform initialization
    terraform init;

    # Performs Terraform provision plan
    terraform plan;

    # Performs Terraform plan apply

    clean_working_dir
fi


