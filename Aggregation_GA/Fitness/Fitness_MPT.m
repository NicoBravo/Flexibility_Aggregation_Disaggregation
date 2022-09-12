function y=Fitness_MPT(Ainq,binq)

    P=Polyhedron(Ainq,binq);
    y=P.volume;
    
end