function w = POCS_upt(v, affine_A, affine_y, l)

    tol = 1e-5;
    
    while(1)
        % project to l1 ball
        w = project2l1_ball(v, l);

        % project to affine set
        w = project2affine(w, affine_A, affine_y);

        % check converge
        if(norm(w-v)<tol)
            break;
        else
            v = w;
        end
    end
end