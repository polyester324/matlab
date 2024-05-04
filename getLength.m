function len = getLength(seq, of, cur)
    % последовательное преобразование смещения в индекс
    ind = cur - of;
    len = 0; % initial length
    while (len+cur < length(seq)) && (seq(ind+len) == seq(cur+len))
        len = len + 1;
    end
end