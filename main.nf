
process PRINTMEM {
    container "ubuntu:22.04"

    input:
    val x

    output:
    path('logfile.*.txt')

    script:
    if(task.attempt == 1){
        """
        echo 'first attempt'
        exit 1
        """
    }
    else {
        """
        echo "${task.memory}" > logfile.${x}.txt 
        """
    }
}


process PRINTMEM2 {
    container "ubuntu:22.04"

    input:
    val x

    output:
    path('logfile.*.txt')

    script:
    y = "${task.memory}-${x}"
    if(task.attempt == 1){
        """
        echo 'first attempt'
        exit 1
        """
    }
    else {
        """
        echo "${y}" > logfile.${x}.txt 
        """
    }
}


workflow {

    ch_in = Channel.of(1, 2, 3)
    
    PRINTMEM(ch_in)
    PRINTMEM2(ch_in)

}