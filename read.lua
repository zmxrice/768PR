#!/home/easycui/torch/install/bin/luajit
require 'torch'
function loadData()
    local file = torch.DiskFile('final.txt','r')

    local line=file:readString("*l")
    local traindata={}
    local testdata={}
    local train={}
    local test={}
    local trainlabel={}
    local testlabel={}
    tranum=50000
    tesnum=3000
    sampleNum=0
    pnum=1
    nnum=1
    while sampleNum<=tranum do
        len=line:len()
        
        if line:sub(1,1)=='f' then
            if pnum<=tranum/2 then
                sampleNum=sampleNum+1
                trainlabel[sampleNum]=1
                local data={}
                for i=7,len do
                    char=line:sub(i,i)
                    data[i-6]=char
                end
                --print(data)
                traindata[sampleNum]=data
                pnum=pnum+1
            end
        else
            if nnum<=tranum/2 then
                sampleNum=sampleNum+1
                trainlabel[sampleNum]=0
                local data={}
                for i=8,len do
                    char=line:sub(i,i)
                    data[i-7]=char
                end
                traindata[sampleNum]=data
                nnum=nnum+1
            end
        end

        line=file:readString("*l")
        if sampleNum==tranum then
            break
        end
    end
    sampleNum=0
    pnum=1
    nnum=1
    while sampleNum<=tesnum do
        len=line:len()

        if line:sub(1,1)=='f' then
            if pnum<=tesnum/2 then
                sampleNum=sampleNum+1
                testlabel[sampleNum]=1
                local data={}
                for i=7,len do
                    char=line:sub(i,i)
                    data[i-6]=char
                end
                testdata[sampleNum]=data
                pnum=pnum+1
            end

        else
            if nnum<=tesnum/2 then
                sampleNum=sampleNum+1
                testlabel[sampleNum]=0
                local data={}
                for i=8,len do
                    char=line:sub(i,i)
                    data[i-7]=char
                end
                testdata[sampleNum]=data
                nnum=nnum+1
            end

        end
        line=file:readString("*l")
        if sampleNum==tesnum then
            break
        end

        --print(len)
    end
    --store the data like
    --train[1] is the data,train[1][1] is the first training sample
    --train[2] is the label. train[2][1] is the label of first training sample
    train.data=traindata
    train.label=trainlabel
    test.data=testdata
    test.label=testlabel
    return train,test
end
--for word in string.gmatch(char, "%a+") do print(word) end
