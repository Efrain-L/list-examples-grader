CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

if [[ ! -f student-submission/ListExamples.java ]]; then
    echo 'File ListExamples.java could not be found.'
    exit 1
fi

cd student-submission
cp ../TestListExamples.java ./
cp -r ../lib ./
javac -cp $CPATH *.java
if [[ $? -ne 0 ]]; then
    echo 'Could not compile your code'
    exit 1
fi
echo 'Compiled Successfully.'
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples &>junit.txt

TESTS=$(sed '2q;d' junit.txt | grep -o '.' | wc -l)
echo $TESTS

#FAILS=$(grep "failure" ./junit.txt | grep -o -E '[0-9]+')
#echo $FAILS

    