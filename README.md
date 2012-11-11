GEVA_Data_Collation
===================

A ruby program to get the mean and standard deviation, in csv form, from output data from the GEVA, a grammatical evolution program

### Usage:

```bash
ruby collate_results.rb -m *.dat
```

To get the mean of each cell in the file in csv format

```bash    
ruby collate_results.rb -sd *.dat
```

To get the standard deviation of each cell in the file in csv format


For those of you who don't use the command line much. Here is how to put the output into a file
```bash
ruby collate_results.rb -m *.dat > mean.csv
```

##### Warning: Don't use with miss matched output data ie. runs with different amounts of generations

### License:

* This software is MIT licensed see link for details

* http://www.opensource.org/licenses/MIT