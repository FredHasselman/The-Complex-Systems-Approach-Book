function sda_values
%Compute standardized dispersion statistic at each bin size
%Assumes series is an integer power of 2 in length.
%Based on Relative Dispersion Statistic described in
%Bassingthwaighte, J. B., Liebovitch, L. S., & West, B. J.  (1994).
%    Fractal physiology.  New York: Oxford University Press.
%see
%Holden, J. G. (2005).  Gauging the fractal dimension of response times from cognitive tasks.
%    In M. A. Riley & G.  C. Van Orden (Eds.), Contemporary nonlinear methods for behavioral
%    scientists: A webbook tutorial, 267-318. At http://www.nsf.gov/sbe/bcs/pac/nmbs/nmbs.pdf
%Jay Holden, 7/2006
%% File Loading, and Saving propts here:

    [FileName,PathName] = uigetfile('*.txt','Select a file');
    %Change / to \ for PC
    z=load([PathName '\' FileName]);
    %Output file stuff here:
    [OutFileName,OutPathName] = uiputfile('*.txt','Specify an output file name');
    
    if isequal(OutFileName,0) || isequal(OutPathName,0)
        
       %quit if no outfile is specified
        error('Canceled')
        
    elseif isequal([OutPathName OutFileName],[PathName FileName])
        
       %quit if infile and outfile are the same
        error('Infile and Outfile have the same name.')
        
    else
    end
    
%% Error Checking, Verify single column of data

    [zr,zc] = size(z);
    if zr > 1 && zc > 1
        
         error('Matrix Input: Assumes a single column of data.')
         
    elseif zr==1
        
        z = z';
        warning('Row Input: Assumes a single column of data.')
        
    else   
    end

%% Verify data is an integer power of 2 in length

    len_p2=log2(length(z));  % find out how long it is
    
    if mod(len_p2,1)~=0 %Integer test, make sure no decimal remainder after dividing by 1
        
        error('Series must be an integer power of 2 in length.')
        
    else
    end

%% Verify Z-score format, if not fix.

    if abs(mean(z))>=1e-6 || std(z,1)~=1
        
        mu=mean(z); sigma=std(z,1);
        z = (z - mu)./ sigma;
        disp('Data was normalized for analysis.')
        
    else
    end
    
%% Begin Standardized Dispersion

dispersion=zeros(len_p2,1); % This initalizes the dispersion vector

             for j=1:(len_p2-1)
                % computes bin size for each scale
                
                bin_size=length(z)/pow2(j);
                k = fix(length(z)/bin_size);
                start=1;
                segment_means=zeros(k,1);
                    
                    for i=1:k  %Compute mean for each bin
                        
                        segment_means(i,1)=mean(z(start:start+bin_size-1,1));
                        start=start+bin_size;
                    end
                    
                %Compute std (population formula) across the bins
                dispersion(j,1)=std(segment_means,1);
                
             end
            
           %Get the standard deviation of all points, (bins of 1 data
           %point). Should equal 1, so round to emiminate e-15 output
           dispersion(len_p2,1)=round(std(z,1));    

%% Finish up
%create the bin size vector 
 bin_sz=(0:len_p2-1)';
 
 % flip vector since it was done from large to small samples and
 % is ploted from small to large samples.
 
 disper=flipud(log2(dispersion));
 output=[bin_sz disper]';
 
 %put in the outfile
 
 FileHeader1=['Log2(Bin Size)'];
 FileHeader2=['Log2(Std Disp)'];
 
 %Change / to \ for PC
 fid=fopen([OutPathName '\' OutFileName],'wt');
 fprintf(fid,'%s\t%s\r\n',FileHeader1,FileHeader2);
 fprintf(fid,'%1.0f\t %1.4f\r\n',output);
 fclose(fid);


 
            