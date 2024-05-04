function enseq = lz77Enc(seq, ws, lab)
    % Вычисление буфера поиска (sb)
    sb = ws - lab;
    % Индекса диапазона поиска
    sr = [1, sb]; 
    
    % Исходная закодированная последовательность
    enseq = '';
    for cur = sr(1):sr(2)
        enseq = strcat(enseq, '<', num2str(0), ',', num2str(0), ...
                        ',', seq(cur), '>');
    end
    % Исходная позиция курсора
    cur = sb + 1; 
    L = length(seq);
    while cur <= L
        % Начальная максимальная длина и смещение
        maxLen = 0;
        of = 0;
    
        for j = sr(2):-1:sr(1)
            % Поиск смещения seq(i) в буфере поиска
            if seq(j) == seq(cur)
                ofTemp = sr(2) - j + 1;
                len = getLength(seq, ofTemp, cur);
                % Нахождение максимальной длины
                if maxLen < len
                    maxLen = len;
                    of = ofTemp;
                end
            end
        end
        % Перемещение курсора в новую позицию
        cur = cur + maxLen + 1;
        % Изменение диапазона буфера поиска
        sr = sr + maxLen + 1; 
        enseq = strcat(enseq, '<', num2str(of), ',', num2str(maxLen), ...
                        ',', seq(cur-1), '>');
    end
end