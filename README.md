# Testing the nextflow cache and resume with succeeded retries

This repo contains a small test workflow which should demonstrate the behaviour of the `-resume` option with failed jobs/retries.

There is some unclear behaviour where the `-resume` functionality does not seem to behave as one would expect. 



## Demonstrating the behaviour

The behaviour can be reproduced using the following steps:

- clone this repo
- ensure `docker` daemon is not running (quit docker desktop)
- run the pipeline with `docker` profile: `nextflow run main.nf -profile docker`
- ensure `docker` daemon is running
- rerun with `-resume`: `nextflow run main.nf -profile docker -resume`
- rerun again: `nextflow run main.nf -profile docker -resume`
- remove the `work` directory: `rm -r work`
- rerun with `-resume`: `nextflow run main.nf -profile docker -resume`
- rerun again `-resume`: `nextflow run main.nf -profile docker -resume`


### What is observed:

First run:
```
Launching `main.nf` [confident_noether] DSL2 - revision: 914c9f6501

executor >  local (12)
[96/140ada] PRINTMEM (1)  [100%] 6 of 6, failed: 6, retries: 3 ✘
[0b/6bb13d] PRINTMEM2 (1) [100%] 6 of 6, failed: 6, retries: 3 ✘
Execution cancelled -- Finishing pending tasks before exit
[4c/945b3f] NOTE: Process `PRINTMEM2 (3)` terminated with an error exit status (125) -- Execution is retried (1)
[48/ef0c6f] NOTE: Process `PRINTMEM (3)` terminated with an error exit status (125) -- Execution is retried (1)
[5d/8021e4] NOTE: Process `PRINTMEM2 (2)` terminated with an error exit status (125) -- Execution is retried (1)
[dc/eccbd4] NOTE: Process `PRINTMEM (2)` terminated with an error exit status (125) -- Execution is retried (1)
[17/a4f13c] NOTE: Process `PRINTMEM2 (1)` terminated with an error exit status (125) -- Execution is retried (1)
[78/b9f6fd] NOTE: Process `PRINTMEM (1)` terminated with an error exit status (125) -- Execution is retried (1)
Error executing process > 'PRINTMEM (3)'

Caused by:
  Process `PRINTMEM (3)` terminated with an error exit status (125)


Command executed:

  echo "2 GB" > logfile.3.txt

Command exit status:
  125

Command output:
  (empty)

Command error:
  docker: Cannot connect to the Docker daemon at unix:///Users/arthurgymer/.docker/run/docker.sock. Is the docker daemon running?.
  See 'docker run --help'.

Work dir:
  /Users/arthurgymer/workbench/nextflow/directive_invalid_cache/work/52/89b9afbd4cea331fcdee343e6156a2

Container:
  ubuntu:22.04

Tip: you can try to figure out what's wrong by changing to the process work dir and showing the script file named `.command.sh`
```

Second run:
```
Launching `main.nf` [mad_venter] DSL2 - revision: 914c9f6501

executor >  local (12)
[ee/168d4f] PRINTMEM (3)  [100%] 6 of 6, failed: 3, retries: 3 ✔
[ea/7e1c66] PRINTMEM2 (1) [100%] 6 of 6, failed: 3, retries: 3 ✔
[4e/290fa0] NOTE: Process `PRINTMEM (2)` terminated with an error exit status (1) -- Execution is retried (1)
[04/003792] NOTE: Process `PRINTMEM2 (2)` terminated with an error exit status (1) -- Execution is retried (1)
[f9/ff8be0] NOTE: Process `PRINTMEM (1)` terminated with an error exit status (1) -- Execution is retried (1)
[36/8edc7e] NOTE: Process `PRINTMEM (3)` terminated with an error exit status (1) -- Execution is retried (1)
[9d/dd9ae7] NOTE: Process `PRINTMEM2 (3)` terminated with an error exit status (1) -- Execution is retried (1)
[a5/c6f697] NOTE: Process `PRINTMEM2 (1)` terminated with an error exit status (1) -- Execution is retried (1)
```

Third run:
```
Launching `main.nf` [sad_mendel] DSL2 - revision: 914c9f6501

executor >  local (12)
[6d/40cf32] PRINTMEM (2)  [100%] 6 of 6, failed: 3, retries: 3 ✔
[76/4bb04a] PRINTMEM2 (3) [100%] 6 of 6, failed: 3, retries: 3 ✔
[6c/20fdd9] NOTE: Process `PRINTMEM (1)` terminated with an error exit status (1) -- Execution is retried (1)
[62/761606] NOTE: Process `PRINTMEM2 (1)` terminated with an error exit status (1) -- Execution is retried (1)
[69/4e4789] NOTE: Process `PRINTMEM2 (2)` terminated with an error exit status (1) -- Execution is retried (1)
[cb/a27892] NOTE: Process `PRINTMEM (2)` terminated with an error exit status (1) -- Execution is retried (1)
[be/302664] NOTE: Process `PRINTMEM (3)` terminated with an error exit status (1) -- Execution is retried (1)
[80/36d358] NOTE: Process `PRINTMEM2 (3)` terminated with an error exit status (1) -- Execution is retried (1)
```

Fourth run:
```
Launching `main.nf` [voluminous_bernard] DSL2 - revision: 914c9f6501

executor >  local (12)
[11/0cf247] PRINTMEM (2)  [100%] 6 of 6, failed: 3, retries: 3 ✔
[44/545c32] PRINTMEM2 (1) [100%] 6 of 6, failed: 3, retries: 3 ✔
[dc/f9f285] NOTE: Process `PRINTMEM2 (1)` terminated with an error exit status (1) -- Execution is retried (1)
[e2/96b242] NOTE: Process `PRINTMEM (3)` terminated with an error exit status (1) -- Execution is retried (1)
[e0/793a6b] NOTE: Process `PRINTMEM2 (2)` terminated with an error exit status (1) -- Execution is retried (1)
[c3/f42cd1] NOTE: Process `PRINTMEM2 (3)` terminated with an error exit status (1) -- Execution is retried (1)
[9a/55e767] NOTE: Process `PRINTMEM (2)` terminated with an error exit status (1) -- Execution is retried (1)
[fe/fd5d49] NOTE: Process `PRINTMEM (1)` terminated with an error exit status (1) -- Execution is retried (1)
```

Fifth run:
```
Launching `main.nf` [loving_volhard] DSL2 - revision: 914c9f6501

[3d/4b4532] PRINTMEM (3)  [100%] 3 of 3, cached: 3 ✔
[66/438371] PRINTMEM2 (3) [100%] 3 of 3, cached: 3 ✔
```

If you follow this set of similar steps you will find that you do not need to remove the work dir to achieve expected caching behaviour, but simply removing `-resume` will help:

- ensure `docker` daemon is not running (quit docker desktop)
- run the pipeline with `docker` profile: `nextflow run main.nf -profile docker`
- ensure `docker` daemon is running
- rerun with `-resume`: `nextflow run main.nf -profile docker -resume`
- rerun again: `nextflow run main.nf -profile docker`
- rerun again with: `nextflow run main.nf -profile docker -resume`

Here you will see that the last run is properly cached without needing to reset the work dir.

System:

- MacOS: 13.5.1 on Intel Mac 
- nextflow: 24.10.2