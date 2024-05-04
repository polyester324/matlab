function decodedStr = lz77Dec(offsetArray, lengthArray, lettersArray)
    % Инициализация переменной для хранения раскодированной строки
    seq = '';
    for i = 1:length(offsetArray)
        disp(offsetArray(i));
        disp(lengthArray(i));
        if offsetArray(i) == 0 && lengthArray(i) == 0
            disp('start alghoritm with 0')
            seq = [seq, lettersArray{i}];
            disp(seq);
        else
            disp('start alghoritm')
            seqLength = length(seq);
            startLength = seqLength - offsetArray(i) + 1 ;
            endLength = startLength + lengthArray(i) - 1;
            disp(seqLength);
            disp(startLength);
            disp(endLength);
            
            % Проход массивом от start_length до end_length и добавление значений в 
            if startLength == endLength
                seq = [seq, seq(startLength)];
                seq = [seq, lettersArray{i}];
                disp(seq);
            else
                for j = startLength:endLength
                    seq = [seq, seq(j)];
                    if j == seqLength 
                        j = startLength;       
                    end   
                    
                end
                if i <= length(lettersArray)
                     seq = [seq, lettersArray{i}];
                end
                disp(i);
                disp(seq);
            end
        end
    end
    disp(seq);
    decodedStr = seq;
end
