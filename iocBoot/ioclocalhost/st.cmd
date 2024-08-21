#!../../bin/linux-x86_64/omegaCNi32

## You may have to change omegaCNi32 to something else
## everywhere it appears in this file

< envPaths

epicsEnvSet("LOCATION", "XF:27IDA{RG:A1}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:A2}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:D1}")
#epicsEnvSet("LOCATION", "XF:27IDA{RG:D2}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:F1}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:F2}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:F3}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:F4}")
epicsEnvSet("LOCATION", "XF:27IDA{RG:F5}")

epicsEnvSet("EPICS","/usr/lib/epics")
epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST","NO")
#epicsEnvSet("EPICS_CA_ADDR_LIST","10.66.210.255")
epicsEnvSet("EPICS_CA_ADDR_LIST","192.168.127.255")

cd ${TOP}

## Register all support components
dbLoadDatabase("dbd/omegaCNi32.dbd",0,0)
omegaCNi32_registerRecordDeviceDriver(pdbbase) 

## Streamdevice Protocol Path

epicsEnvSet ("STREAM_PROTOCOL_PATH", "protocols")

drvAsynIPPortConfigure("tsrv2-p1","192.168.127.254:4001")

asynSetTraceMask("tsrv2-p1",0,0x09)
asynSetTraceIOMask("tsrv2-p1",0,0x02)

## Load record instances
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:A1},Chan=01,N_T=,N_GAIN=,PORT=tsrv1-p1")
dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:A2},Chan=01,N_T=,N_GAIN=,PORT=tsrv2-p1")
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:D1},Chan=01,N_T=,N_GAIN=,PORT=tsrv3-p1")
##dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:D2},Chan=01,N_T=,N_GAIN=,PORT=tsrv9-p1")
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:F1},Chan=01,N_T=,N_GAIN=,PORT=tsrv4-p1")
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:F2},Chan=01,N_T=,N_GAIN=,PORT=tsrv5-p1")
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:F3},Chan=01,N_T=,N_GAIN=,PORT=tsrv6-p1")
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:F4},Chan=01,N_T=,N_GAIN=,PORT=tsrv7-p1")
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:27ID1-CT,Dev={RG:F5},Chan=01,N_T=,N_GAIN=,PORT=tsrv8-p1")

dbLoadRecords("db/asynRecord.db", "P=XF:27ID1-CT,R={RG:A2}Asyn,PORT=tsrv2-p1,ADDR=0,IMAX=256,OMAX=256")

#dbLoadRecords("$(EPICS)/db/asynRecord.db", "P=XF:27ID1-CT,R={RG:F2}Asyn,PORT=tsrv5-p1,ADDR=0,IMAX=256,OMAX=256")
# N_T and N_GAIN macros used if there are multiple temperature controllers in a rack. Leading ':' required on N_T, no leading ':' required on N_GAIN.
#dbLoadRecords("db/omegaCNi32_temp.db","Sys=XF:xxIDA-CT,Dev={RG:A1},Chan=01,N_T=:1,N_GAIN=1,PORT=tsrv1-p1")

iocInit()

dbl > ${TOP}/records.dbl
#system "cp ${TOP}/records.dbl /cf-update/$HOSTNAME.$IOCNAME.dbl"

