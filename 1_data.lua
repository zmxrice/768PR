----------------------------------------------------------------------
-- This script demonstrates how to load the (SVHN) House Numbers 
-- training data, and pre-process it to facilitate learning.
--
-- The SVHN is a typicaly example of supervised training dataset. 
-- The problem to solve is a 10-class classification problem, similar
-- to the quite known MNIST challenge.
--
-- It's a good idea to run this script with the interactive mode:
-- $ torch -i 1_data.lua
-- this will give you a Torch interpreter at the end, that you
-- can use to analyze/visualize the data you've just loaded.
--
-- Clement Farabet
----------------------------------------------------------------------
--require('mobdebug').start()
require 'torch'   -- torch
require 'nn'      -- provides a normalization operator
require 'preprocess.lua'
----------------------------------------------------------------------
-- parse command line arguments

----------------------------------------------------------------------
print '==> load data'

-- Here we download dataset files. 

-- Note: files were converted from their original Matlab format
-- to Torch's internal format using the mattorch package. The
-- mattorch package allows 1-to-1 conversion between Torch and Matlab
-- files.

-- The SVHN dataset contains 3 files:
--    + train: training data
--    + test:  test data
--    + extra: extra training data

-- By default, we don't use the extra training data, as it is much 
-- more time consuming


-- Note: the data, in X, is 4-d: the 1st dim indexes the samples, the 2nd
-- dim indexes the color channels (RGB), and the last two dims index the
-- height and width of the samples.

train,test = preprocess()
trsize=(#train.X)[1]
trainData = {
   data = train.X,
   labels = train.y[1],
   size = function() return trsize  end
}

-- If extra data is used, we load the extra file, and then
-- concatenate the two training sets.

-- Torch's slicing syntax can be a little bit frightening. I've
-- provided a little tutorial on this, in this same directory:
-- A_slicing.lua


-- Finally we load the test data.
tesize=(#test.X)[1]
testData = {
   data = test.X,
   labels = test.y[1],
   size = function() return tesize end
}

----------------------------------------------------------------------

-- Preprocessing requires a floating point representation (the original
-- data is stored on bytes). Types can be easily converted in Torch, 
-- in general by doing: dst = src:type('torch.TypeTensor'), 
-- where Type=='Float','Double','Byte','Int',... Shortcuts are provided
-- for simplicity (float(),double(),cuda(),...):

trainData.data = trainData.data:float()
testData.data = testData.data:float()


