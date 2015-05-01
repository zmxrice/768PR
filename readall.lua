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
    maxSize=200
    sampleNum=0
    while sampleNum<148993 do
        len=line:len()
        sampleNum=sampleNum+1

        if line:sub(1,1)=='f' then
            if sampleNum<140001 then
                trainlabel[sampleNum]=1
                local data={}
                for i=7,len do
                    char=line:sub(i,i)
                    data[i-6]=char
                end
                --print(data)
                traindata[sampleNum]=data
            else
                testlabel[sampleNum-140000]=1
                local data={}
                for i=7,len do
                    char=line:sub(i,i)
                    data[i-6]=char
                end
                testdata[sampleNum-140000]=data

            end
        else
            if sampleNum<140001 then
                trainlabel[sampleNum]=0
                local data={}
                for i=8,len do
                    char=line:sub(i,i)
                    data[i-7]=char
                end
                traindata[sampleNum]=data

            else
                testlabel[sampleNum-140000]=0
                local data={}
                for i=8,len do
                    char=line:sub(i,i)
                    data[i-7]=char
                end
                testdata[sampleNum-140000]=data

            end


        end
        line=file:readString("*l")

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
