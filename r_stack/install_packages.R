# Set CRAN mirror
options(repos="http://ftp.yz.yamagata-u.ac.jp/pub/cran/")

# Install packages
install.packages(c('data.table',
                   'dplyr',
                   'tidyr',
                   'reshape2',
                   'stringi',
                   'ggplot2',
                   'RMySQL',
                   'RPostgreSQL'
                   ))

# IRKernel
install.packages(c('rzmq', 'repr', 'IRkernel', 'IRdisplay'),
                 repos = c('http://irkernel.github.io/', getOption('repos')),
                 type = 'source')
IRkernel::installspec()
