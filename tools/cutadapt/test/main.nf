#!/usr/bin/env nextflow

// Define DSL2
nextflow.preview.dsl=2

// Log
log.info ("Starting tests for cutadapt...")

/*------------------------------------------------------------------------------------*/
/* Define params
--------------------------------------------------------------------------------------*/

params.cutadapt_args = ""
params.verbose = true

/*------------------------------------------------------------------------------------*/
/* Module inclusions
--------------------------------------------------------------------------------------*/

include cutadapt from '../main.nf' 

/*------------------------------------------------------------------------------------*/
/* Define input channels
--------------------------------------------------------------------------------------*/

testData = [
    ['Sample1', "$baseDir/input/readfile1.fq.gz"],
    ['Sample2', "$baseDir/input/readfile2.fq.gz"],
    ['Sample3', "$baseDir/input/readfile3.fq.gz"],
    ['Sample4', "$baseDir/input/readfile4.fq.gz"],
    ['Sample5', "$baseDir/input/readfile5.fq.gz"],
    ['Sample6', "$baseDir/input/readfile6.fq.gz"]
]

//Define test data input channel
  Channel
  .from(testData)
  .map { row -> [ row[0], file(row[1], checkIfExists: true) ] }
  .set {ch_fastq}

/*------------------------------------------------------------------------------------*/
/* Run tests
--------------------------------------------------------------------------------------*/
  
workflow {
    // Run cutadapt
    cutadapt ( ch_fastq )

    // Collect file names and view output
    cutadapt.out.trimmedReads | view

}