%fileName = "eulerTests.Riemann1V";
%fileName = "conservationLaws.advectionCos";
fileName = "conservationLaws.advectionStep";
varName = "u[";
xName = "x[";
exactSol = str2func(strrep(fileName,'.','_'));
load([fileName "_res.mat"]);
nameT = transpose(name);
indexesV = [];
indexesX = [];
for i = 1:size(name,2)
  if isequal(varName,nameT(i,1:size(varName,2)))
	  indexesV = [indexesV i];
  end;
  if isequal(xName,nameT(i,1:size(xName,2)))
	  indexesX = [indexesX i];
  end;
end;
if size(indexesV) != size(indexesX) 
  error("different sizes of X and variable")
end;
size(dataInfo);
ar = dataInfo(1,indexesX) != 1;
if ar
  error("some X isnt in data_1")
end;
ar = dataInfo(1,indexesV) != 2;
if ar
  error("some var isnt in data_2")
end;
indexesX1 = dataInfo(2,indexesX);
indexesV1 = dataInfo(2,indexesV);
size(data_1)
X = data_1(indexesX1,1);
nSteps = size(data_2,2)
nPlots = 5;
h = figure();



for i = 1:nPlots
 nFrame = round(1 + (nSteps-1)/(nPlots-1)*(i-1) ) ;
 time = data_2(1,nFrame);
 var = data_2(indexesV,nFrame);
 varE = feval(exactSol,time,X);
 plot(X,var,X,varE);
 pause(0.1);
end;
saveas(h,[fileName ".png"],"png");
m = max(varE);
err = sum(abs((varE - var)./max(m/100,varE).*(varE>m/100)))


