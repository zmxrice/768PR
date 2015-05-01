require 'torch'
require 'read.lua'
require 'map.lua'
function preprocess()
    Size=150
    map=map()
    map:init()
    local data={}
    local traindata={}
    local testdata={}
    local train, test=loadData()
    local y=torch.zeros(1,#train.data)
    --X: 10000x1x92x200
    local X=torch.CharTensor(#train.data,1,map.size,Size)
    print(#train.data)
    for i=1,#train.data do
        y[{1,i}]=train.label[i]+1
        for j=1,Size do
            if j<=#train.data[i] then
                X[{i,1,{},j}]=map:char(train.data[i][j])
            else
                X[{i,1,{},j}]=map:char(' ')
            end
        end
    end
    traindata.X=X
    traindata.y=y
    y=torch.zeros(1,#test.data)
    X=torch.CharTensor(#test.data,1,map.size,Size)

    for i=1,#test.data do
        y[{1,i}]=test.label[i]+1
        for j=1,Size do
            if j<=#test.data[i] then
                X[{i,1,{},j}]=map:char(test.data[i][j])
            else
                X[{i,1,{},j}]=map:char(' ')
            end
        end

    end
    testdata.X=X
    testdata.y=y
    return traindata,testdata
end
