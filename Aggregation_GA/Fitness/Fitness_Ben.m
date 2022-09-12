function y=Fitness_Ben(Ainq,binq)
    
    P.A=Ainq;
    P.b=binq;
    P.A_eq=[];
    P.b_eq=[];
    l=size(Ainq,2);
    P.p=zeros(l,1);
%     P=preprocess(P);
    [vol,T,steps] = Volume(P,[],0.1);
    y=vol;

    
end