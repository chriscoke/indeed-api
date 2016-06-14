
## Install packages
if (!require("PythonInR", character.only=T, quietly=T)) {
  install.packages("PythonInR", repos="http://cran.us.r-project.org")
  library("PythonInR", character.only=T)
}

## User Inputs

# Search Parameters 1
# e.g. a tuple of (30,1) means that the query will retrieve all job postings that are 0-1, then 0-2, then 0-3...0-30 days old
max_age_param = 30 #maximum age of job postings to retrieve
by_age_param = 1 #increment of job postings ages to retrieve

# Search Parameters 2
zips = c(94114,10011) # zipcodes to search
qs = c('construction','scientist','') # jobtiles to search

# Path locations
fileName = "indeed_api_query.py"
pypath = "C:\\Python34\\python.exe" #this must be the location of your local python executable file

# Indeed API Publisher Account Number (needs to be numeric)
acct = [ ]

## Establish Python connection
pyConnect(pythonExePath = pypath)


## Function: Read in Python file and execute
py.exec.fn = function(fileName, max_age_param, by_age_param, zip_code, title){
  pStr1 = readLines(fileName)
  pStr2 = paste(pStr1,collapse="\n")
  pStr3 = gsub("<max_age_param>",max_age_param,pStr2)
  pStr4 = gsub("<by_age_param>",by_age_param,pStr3)
  pStr5 = gsub("<zip_code>",zip_code,pStr4)
  pStr6 = gsub("<query>",title,pStr5)
  pStr7 = gsub("<acct>",acct,pStr6)
  pResult = pyExecg(pStr7)
  tbl = data.frame(ages=pResult$ages, counts=pResult$counts)
  return(tbl)
}

### retrieve Indeed search totals

# create all combinations of zipcodes and titles to search over

grid = expand.grid(zips,qs)
names(grid) = c("zip","q")
grid["uid"] = apply(grid, 1, function(x) paste(x,collapse="-"))
tbl = list(NULL)
cd = matrix(data=NA, nrow=max_age_param, ncol=nrow(grid))

# loop through all combinations

for (i in 1:nrow(grid)){
  tbl[[i]] = py.exec.fn(fileName, max_age_param, by_age_param, zip_code=grid$zip[i], title = grid$q[i])
  cd[,i] = tbl[[i]]$counts/max(tbl[[i]]$counts)
  print(i)
}

# plot cumulative distribution functions

cols = seq(1,nrow(grid),by=1)
plot(cd[,1]~tbl[[1]]$ages,
     type="l",
     ylab="cumulative % of total",
     xlab="age of job postings",
     main="Cumulative Distribution of Job Posting Ages",
     sub="comparing zipcodes and job titles",
     cex.main = 0.75,
     col=cols[1])
for (j in 2:nrow(grid)){
  lines(cd[,j]~tbl[[j]]$ages,col=cols[j]) 
}
legend("bottomright",lty=rep(1,nrow(grid)),col=cols,c(grid$uid),cex=0.5)
