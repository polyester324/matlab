function dict = huffmanDict(symbols, probability)
    for i = 1:length(probability)
       encWord{i} = '';
       letter{i} = i;
    end
    
    while(probability < 1)
         % Вероятности сортировки (по возрастанию) и возврата позиций
         [~, array] = sort(probability);
        
         % Получение наименьшего и второго наименьшего элемента из отсортированного массива 
         last = array(1);
         next = array(2);
        
         % Получение букв, соответствующих указанным выше элементам
         rightLeaf = letter{last};
         leftLeaf = letter{next};
        
         % Получение количества их вхождений
         rightProbability = probability(last);
         leftProbability = probability(next);
        
         % создание нового узла с суммой вхождений
         node = [rightLeaf leftLeaf];
         sum = rightProbability + leftProbability;
        
         % Удаление из массива буквы и обновление дерева
         letter(array(1:2)) = '';
         probability(array(1:2))= ''; 
         letter = [letter node];
         probability = [probability sum];
    
         encWord = concatEncoded(encWord,rightLeaf,'1');
         encWord = concatEncoded(encWord,leftLeaf,'0');
    end
    dict.symbol = symbols; dict.output = encWord;

    % Объединение закодированного ключевого слова для каждого листа
    function encWord = concatEncoded(encWord,leaf,key)
        for j = 1:length(leaf)
            encWord{leaf(j)} = strcat(key,encWord{leaf(j)});      
        end
    end
end