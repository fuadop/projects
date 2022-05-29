root_dir=$(pwd)
failed_tests=()

for path in $(find projects/ -depth);
  do 
    if [ -e $path/package.json ];
      then
        echo -e "\nRunning test for $path"
        cd $path
        npm run test:solutions
        exit_code=$?

        if [ $exit_code -ne 0 ];
          then
            failed_tests+=( "$path" )
        fi
        cd $root_dir
    fi
done

echo ""
for path in ${failed_tests[@]};
  do
    echo "Tests failed at $path"
done

if [ ${#failed_tests[@]} -gt 0 ];
  then 
    exit 1
  else
    exit 0
fi
