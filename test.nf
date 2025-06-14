#!/usr/bin/env nextflow

process sayHello {
    output:
    stdout

    """
    echo '🎉 Hello from Nextflow!'
    """
}
