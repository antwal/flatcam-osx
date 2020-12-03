    set script_path to POSIX path of ((path to me as text) & "::") & "FlatCAM"
    do shell script script_path
