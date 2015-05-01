require 'torch'
do
    local map=torch.class('map')
    function map:__init()
        self.size=92
        self.code=torch.zeros(1,256)
        self.min=32
    end
    function map:init()
        file=torch.DiskFile('final.txt','r')
        file:quiet()
        char=file:readChar()
        --[[while char~=0 do
            self.code[{1,char}]=self.code[{1,char}]+1
            char=file:readChar()
        end
        count=0
        self.min=256
        max=1
        for i=1, (#self.code)[2] do
            if self.code[{1,i}]>0  then
                if i>max then
                    max=i
                end
                if i<self.min then
                    self.min=i
                end
            end
        end
        self.min=32
        self.size=max-self.min+1;--]]
    end
    function map:char(char)
        binary=torch.zeros(1,self.size)
        binary[{1,char:byte()-self.min+1}]=1
        return binary
    end
end
