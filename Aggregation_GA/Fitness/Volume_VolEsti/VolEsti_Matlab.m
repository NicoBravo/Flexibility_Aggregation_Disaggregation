function Vol_computation=VolEsti_Matlab(Amat,b)



nrow=size(Amat,1); ncol=size(Amat,2);
A=reshape(Amat,[],1);  
pathname='D:\WorkSpace\Aggregation_GA\Fitness\Volume_VolEsti\';
filename='Polytope_info.mat';
save([pathname,filename],'A','b','nrow','ncol')

Rpath = 'C:\Applications\R_project\R-4.2.1\bin'; 
RscriptFileName = 'D:\WorkSpace\Aggregation_GA\Fitness\Volume_VolEsti\VolEsti_R.R'; 
RunRcode(RscriptFileName, Rpath); 

clc
Vol_value=load(['D:\WorkSpace\Aggregation_GA\Fitness\Volume_VolEsti\Vol_result.mat']);
Vol_computation = Vol_value.vol;



end

