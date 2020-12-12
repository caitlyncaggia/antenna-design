function [state, options, changed] = gaoutfun(options, state, flag)

persistent history
optchanged = false;
switch flag
    case 'iter'
        % Update history every n generations
        if rem(state.Generation,1) == 0
            ss = size(history,3);
            history(:,:,ss+1) = state.Population;
            assignin('base','gapopulationhistory',history)
        end
end

end