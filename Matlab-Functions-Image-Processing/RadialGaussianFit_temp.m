function [ fitres, fitdat, fitfun, chi2 ] = RadialGaussianFit( rads, dat, makeplot, makedisp, begrad )
    
    % [Amp, Offset, sigma]
    lower = [0,-0.2,0];
    guess = [0.1,0,10];
    upper = [2,0.2,100];
    begind = find(rads >= begrad,1);
    tols = 1e-16;
    options = optimset(...
        'Display','off',...
        'MaxFunEvals',5e2,...
        'MaxIter',5e2,...
        'TolX',tols,...
        'TolFun',tols,...
        'TolCon',tols ,...
        'UseParallel','always');
    fitres = lsqcurvefit(@gauss1D, guess, rads(begind:end), dat(begind:end), lower, upper, options);
    fitdat = gauss1D(fitres, rads);
    chi2 = sum((dat(begind:end) - fitdat(begind:end)).^2) / length(dat(begind:end));
    if makeplot
        figure;
        radsplot = 0:0.1:rads(end);
        plot(rads,dat,'b.',radsplot,gauss1D(fitres,radsplot),'g');
    end
    if makedisp
        disp(['Results: Sigma:',num2str(fitres(3)),', Amp:',num2str(fitres(1)),', offset:',num2str(fitres(2))]);
    end
    
    fitfun = @(A,x) A(2) + A(1) * exp( - (x).^2 ./ (2*(A(3))^2) );
end

function z = gauss1D(A,x)
    z = A(2) + A(1) * exp( - (x).^2 ./ (2*(A(3))^2) );
end