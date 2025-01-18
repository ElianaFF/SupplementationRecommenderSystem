%--Factos--

% Caracterizar uma pessoa

pessoa(lucas, 21, daltonismo, santarem, estudante, natacao).
pessoa(beatriz, 48, insonias, bergen, motorista, ler).
pessoa(rodolfo, 26, alopecia, funchal, osteopata, anime).
pessoa(clara, 29, gravidez, sintra, contabilista, jardinagem).
pessoa(pedro, 45, fumador, gaia, treinador, ginasio).
pessoa(joaquim, 74, alzheimer, maia, reformado, puzzles).
pessoa(simao, 15, adolescencia, gaia, estudante, videojogos).
pessoa(luisa, 36, amamentacao, gaia, medica, fotografia).
pessoa(vera, 50, falhas_de_memoria, mealhada, psicologa, tenis).
pessoa(tiago, 43, fadiga_cerebral, coimbra, designer, fotografia).
pessoa(maria, 66, confusao_mental, celas, reformada, arraiolos).
pessoa(augusto, 68, glaucoma, celas, reformado, agricultura).
pessoa(eduardo, 57, diabetes, cascais, engenheiro_mecanico, bricolagem).
pessoa(francisca, 32, gravidez, tromso, engenheira_quimica, meditar).
pessoa(gabriela, 31, infecao_respiratoria, tromso, publicitaria, yoga).
pessoa(tomas, 22, depressao, amsterdao, estudante, escrever).
pessoa(antonio, 49, miopia, setubal, dentista, ciclismo).
pessoa(alice, 50, menopausa, setubal, florista, acampar).
pessoa(ines, 19, gripe, setubal, estudante, arborismo).

% Relações Familiares

pai(joaquim, pedro).
pai(pedro, simao).
pai(augusto, vera).
pai(augusto, tiago).
pai(eduardo, francisca).
pai(eduardo, gabriela).
pai(antonio, tomas).
pai(antonio, ines).

mae(luisa, simao).
mae(maria, vera).
mae(maria, tiago).
mae(alice, tomas).
mae(alice, ines).

% Suplemetos e condições para os quais são benéficos

suplemento(oleo_de_peixe, alzheimer).    
suplemento(oleo_de_peixe, falhas_de_memoria).
suplemento(oleo_de_peixe, demencia).
suplemento(omega3, alzheimer).
suplemento(omega3, falhas_de_memoria).
suplemento(omega3, demencia).
suplemento(omega3, funcionamento_cerebral).
suplemento(omega3, gravidez).
suplemento(omega3, amamentacao).
suplemento(melatonina, alzheimer).
suplemento(melatonina, perturbacoes_de_sono).
suplemento(vitaminab6, funcionamento_cerebral).
suplemento(vitaminab6, gravidez).
suplemento(vitaminab6, falta_de_luz_solar).
suplemento(magnesio, funcionamento_cerebral).
suplemento(magnesio, diabetes).
suplemento(acidos_gordos, funcionamento_cerebral).
suplemento(acidos_gordos, gravidez).
suplemento(acidos_gordos, amamentacao).
suplemento(ginseng, funcionamento_cerebral).
suplemento(ginseng, menopausa).
suplemento(cromio, diabetes).
suplemento(acido_alfa-lipoico, diabetes).
suplemento(zinco, gravidez).
suplemento(zinco, saude_ocular).
suplemento(zinco, sistema_imunitario).
suplemento(zinco, alopecia).
suplemento(ferro, gravidez).
suplemento(ferro, amamentacao).
suplemento(calcio, gravidez).
suplemento(cafeina, performance_desportiva).
suplemento(creatina, performance_desportiva). 
suplemento(vitaminac, saude_ocular).
suplemento(vitaminac, sistema_imunitario).
suplemento(vitaminac, adicao_nicotina).
suplemento(vitaminae, saude_ocular).
suplemento(vitaminae, sistema_imunitario).
suplemento(vitaminae, menopausa).
suplemento(vitaminaa, sistema_imunitario).
suplemento(vitaminaa, adicao_nicotina).
suplemento(vitaminad, sistema_imunitario).
suplemento(vitaminad, depressao).
suplemento(vitaminad, falta_de_luz_solar).
suplemento(selenio, sistema_imunitario).
suplemento(selenio, alopecia).
suplemento(linhaca, menopausa).
suplemento(acido_folico, depressao).
suplemento(vitaminab12, depressao).
suplemento(vitaminab12, fadiga_cerebral).

% Condições hereditárias

hereditario(hereditario, alzheimer).
hereditario(hereditario, diabetes).
hereditario(hereditario, saude_ocular).
hereditario(hereditario, depressao).
hereditario(hereditario, alopecia).

% Cidades com falta de luz solar

escuro(escuro, bergen).
escuro(escuro, tromso).

% Atividades desportivas

desporto(desporto, natacao).
desporto(desporto, ginasio).
desporto(desporto, yoga).
desporto(desporto, ciclismo).
desporto(desporto, tenis).

% Condições relacionadas com funcionamento cerebral

cerebral(cerebral, falhas_de_memoria).
cerebral(cerebral, fadiga_cerebral).
cerebral(cerebral, confusao_mental).

% Condições relacionadas com a saúde ocular

ocular(ocular, glaucoma).
ocular(ocular, miopia).
ocular(ocular, daltonismo).

% Fortalecer sistema imunitário

imunitario(imunitario, gripe).
imunitario(imunitario, infecao_respiratoria).


%--Regras--

% Regra para recomendar suplemento por condição

suplemento_condicao(Nome, Suplemento) :-
    pessoa(Nome, _, Condicao, _, _, _),
    suplemento(Suplemento, Condicao).


% Regras para definir descendência

% Descendente direto

descendente(Ascendente, Descendente) :- 
    (pai(Ascendente, Descendente); mae(Ascendente, Descendente)).

% Descendente indireto - recursividade

descendente(Ascendente, Descendente) :- 
    (pai(Ascendente, Filho); mae(Ascendente, Filho)),
    descendente(Filho, Descendente).


% Regra para aplicar hereditariedade à suplementação em condições hereditárias

suplemento_hereditariedade(Ascendente, Descendente, Suplemento) :-
    hereditario(_, Condicao),
    pessoa(Ascendente, _, Condicao, _, _, _),
    suplemento(Suplemento, Condicao),
    descendente(Ascendente, Descendente).


% Regra para suplementar quem vive em cidades escuras

suplemento_escuridao(Nome, Cidade, Suplemento) :-
    pessoa(Nome, _, _, Cidade, _, _),
    escuro(escuro, Cidade),
    suplemento(Suplemento, falta_de_luz_solar).


% Regra para suplementar quem pratica desporto

suplemento_desporto(Nome, Desporto, Suplemento) :-
    pessoa(Nome, _, _, _, _, Desporto),
    desporto(desporto, Desporto),
    suplemento(Suplemento, performance_desportiva).


% Regra para suplementar funcionamento cerebral

suplemento_cerebral(Nome, Condicao, Suplemento) :-
    pessoa(Nome, _, Condicao, _, _, _),
    cerebral(cerebral, Condicao),
    suplemento(Suplemento, funcionamento_cerebral).


% Regra para suplementar estudantes

suplemento_estudantil(Nome, estudante, Suplemento) :-
    pessoa(Nome, _, _, _, estudante, _),
    suplemento(Suplemento, funcionamento_cerebral).


% Regra para suplementar saúde ocular

suplemento_ocular(Nome, Condicao, Suplemento) :-
    pessoa(Nome, _, Condicao, _, _, _),
    ocular(ocular, Condicao),
    suplemento(Suplemento, saude_ocular).

% Regra para suplementar imunidade

suplemento_imunitario(Nome, Condicao, Suplemento) :-
    pessoa(Nome, _, Condicao, _, _, _),
    imunitario(imunitario, Condicao),
    suplemento(Suplemento, sistema_imunitario).


% Regra para juntar todas as suplementações relevantes para uma pessoa

todas_suplementacoes(Nome, Suplemento) :-
    (suplemento_condicao(Nome, Suplemento);
    suplemento_hereditariedade(_, Nome, Suplemento);
    suplemento_escuridao(Nome, _, Suplemento);
    suplemento_desporto(Nome, _, Suplemento);
    suplemento_cerebral(Nome, _, Suplemento);
    suplemento_estudantil(Nome, _, Suplemento);
    suplemento_ocular(Nome, _, Suplemento);
    suplemento_imunitario(Nome, _, Suplemento)).








