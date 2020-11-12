#!/usr/bin/env nextflow

// Specify DSL2
nextflow.enable.dsl=2

/*------------------------------------------------------------------------------------*/
/* Processes
--------------------------------------------------------------------------------------*/

process default_resources {
    output:
      val task.cpus, emit: cpus
      val task.memory, emit: memory
    script:
      message = "default - cpus=" + task.cpus
      message += " mem=" + task.memory.toString().replace(' ', '')
      log.info message
      """
      echo ${message}
      """
}

/*------------------------------------------------------------------------------------*/
/* Workflows
--------------------------------------------------------------------------------------*/

// Check the resource allocation models for different profiles and configurations
workflow assert_resource_allocation_models {
    main:
        default_resources()

        // Doesnt really work as we can only access the cpu and mem variables. Have to resort to manual testing on the cluster
        // default_expected_cpu = 2
        // default_resources.out.cpus.subscribe{
        //         if(it != default_expected_cpu) {
        //             throw new Exception("Default resources CPU count is " + it + " when is should be " + default_expected_cpu);
        //         }
        // }
}