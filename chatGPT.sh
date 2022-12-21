#!/bin/bash

# Display a menu for passing arguments to qpdf
args=$(yad --form --separator='' \
    --field='Input File:FL' \
    --field='Output File:FL' \
    --field='Password:H' \
    --field='Encryption Algorithm:CB' 'AES-128' 'AES-256' 'None' \
    --field='Encrypt Metadata:CHK' \
    --field='Compress Streams:CHK' \
    --field='Linearize:CHK' \
    --field='Additional Options:TXT' \
    --title='qpdf Options' --width=500 --height=300)

# Split the arguments into an array
IFS='|' read -ra arg_array <<< "$args"

# Set variables for each argument
input_file=${arg_array[0]}
output_file=${arg_array[1]}
password=${arg_array[2]}
encryption_algorithm=${arg_array[3]}
encrypt_metadata=${arg_array[4]}
compress_streams=${arg_array[5]}
linearize=${arg_array[6]}
additional_options=${arg_array[7]}

# Build the qpdf command
command="qpdf"

# Add the input file argument
if [ ! -z "$input_file" ]; then
    command="$command --input-file $input_file"
fi

# Add the output file argument
if [ ! -z "$output_file" ]; then
    command="$command --output-file $output_file"
fi

# Add the password argument
if [ ! -z "$password" ]; then
    command="$command --encrypt $password $password"
fi

# Add the encryption algorithm argument
if [ "$encryption_algorithm" != "None" ]; then
    command="$command --encrypt-metadata=n $encryption_algorithm"
fi

# Add the encrypt metadata argument
if [ "$encrypt_metadata" = "TRUE" ]; then
    command="$command --encrypt-metadata=y"
fi

# Add the compress streams argument
if [ "$compress_streams" = "TRUE" ]; then
    command="$command --compress-streams"
fi

# Add the linearize argument
if [ "$linearize" = "TRUE" ]; then
    command="$command --linearize"
fi

# Add any additional options
if [ ! -z "$additional_options" ]; then
    command="$command $additional_options"
fi

# Execute the qpdf command
$command
