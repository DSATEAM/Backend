DROP DATABASE IF EXISTS LastSurvivor;
CREATE DATABASE LastSurvivor;

USE LastSurvivor;

CREATE TABLE item (id VARCHAR(32) UNIQUE, name VARCHAR(255), type VARCHAR(255), rarity VARCHAR(255), description VARCHAR(255),credit INT, offense INT, defense INT,hitRange FLOAT(6),attackCooldown FLOAT(6), avatar MEDIUMTEXT); 
CREATE TABLE player (id VARCHAR(32) UNIQUE, username VARCHAR(255), password VARCHAR(255),avatar MEDIUMTEXT,gamesPlayed INT,kills INT ,experience INT, credits INT, maxFloor INT);
CREATE TABLE forum (id VARCHAR(32) UNIQUE, admin VARCHAR(32),name VARCHAR(255),avatar MEDIUMTEXT );
CREATE TABLE message (id VARCHAR(32) UNIQUE, parentId VARCHAR(32) , username VARCHAR(32),avatar MEDIUMTEXT,message VARCHAR(255) );
CREATE TABLE enemy (id VARCHAR(32) UNIQUE, name VARCHAR(255),description VARCHAR(8000),avatar MEDIUMTEXT,experience INT,damage INT ,health INT);
CREATE TABLE map (id VARCHAR(32) UNIQUE, name VARCHAR(255),level INT,type1Map VARCHAR(8000),type2Objects VARCHAR(8000));
CREATE TABLE transaction(id VARCHAR(32) UNIQUE, itemId VARCHAR(32), playerId VARCHAR(32));

INSERT INTO item (id, name, type, rarity, description, credit,offense, defense,hitRange,attackCooldown,avatar) VALUES  ("#1", "Knight Sword" , "Melee" , " Epic" , "Custom built from the orders of king" ,1750, 10, 8,1.25,0.7, "iVBORw0KGgoAAAANSUhEUgAAAAoAAAAdCAYAAACT4f2eAAAAhUlEQVR4nGNgQANKSkr/lZSU/qOLYyjadvr8/7/f32IoZkJWNGXlWrjE7aunGZAVMzEQCUYV0lkhCiAqrom2mmqJYgDdyEIof8DlYe6CZSp0DJNjgelEthYbYEQxHge4d+8eI4Z7iA4edx05hp1XHmGYiqFw55VHDO46coQV4jIRA+AqewC2/2avEo1upwAAAABJRU5ErkJggg==");
INSERT INTO Item (id, name, type, rarity, description, credit, offense, defense, hitRange, attackCooldown,avatar) VALUES  ("#2", "Axe" , "Melee" , " Rare" , "Ogre return gift in exchange of a kiss, though still not sure if worth it!" ,1500,7, 4,0.85,1.0,"iVBORw0KGgoAAAANSUhEUgAAAAkAAAAVCAYAAACUhcTwAAAAh0lEQVR4nGNkYGBgUFJS+s+ABO7du8eIzGeCMRbbMTPkyrEzYAOM6KZgAywMDAwMAVvWYEh0K8ozMDAwMKhqmyKswweIUsTCwMDAsMEnBEUQ3XommHeRfYeuCat19+7dY1TVNiXsJmSFeB0OcwpB3927d4+ReuE0vBWxwBixh/4yMDD8xaoIAAkCIPre7NnqAAAAAElFTkSuQmCC");
INSERT INTO Item (id, name, type, rarity, description, credit,offense, defense ,hitRange,attackCooldown,avatar) VALUES  ("#3", "Katana" , "Melee" , "Legendary" , "Sent from Hell to kill the Angels" ,5000,15, 12,2,0.45,"iVBORw0KGgoAAAANSUhEUgAAAAYAAAAdCAYAAACJ3R0QAAAAdElEQVR4nGNgYGBgUFJS+q+kpPSfAQkwwRgBW9YwIEsyIau6ffU0XBJFAqtRoxKDW4IRPRHAAAsDAwODmF0UiuCrQ8sYGBkYGBjQdd27d48RbodxWxFDwJY1mJbL6lkxPL50DFPi8aVjDLJ6VoR1wAF6+gUA8O0hAIVIEBgAAAAASUVORK5CYII=");
INSERT INTO Item (id, name, type, rarity, description, credit,offense, defense,hitRange,attackCooldown,avatar ) VALUES  ("#4", "Baton with Spikes" , "Melee" , "Common" , "Obtained from Beggar on street" ,500,3 , 1,0.75,0.85,"iVBORw0KGgoAAAANSUhEUgAAAAoAAAAWCAYAAAD5Jg1dAAAAxklEQVR4nGNkQAJKSkr/kfn37t1jhLFZkBXlyrEzMDAwMJgp/GFgYGBgiGVQ+g9TzIJuCi7AwsDAwBCwZQ3D40vHGI4xMDBYzZiKVSEjstswrD70F66QCd3RMDDBI5/BuK2IIWDLGoiJyG7EZeK9e/cYCboRZhvcSqzBg+RGFgYcYIJHPoOxBwODrJ4VwwafEBq4keXevXuMG3xCUMIRG8AZjlgVEgPgCu/du8c4+dFPuETsob8oNpFu4iBWiAGUlJT+Y8seAFotXviF0dUaAAAAAElFTkSuQmCC");
INSERT INTO Item (id, name, type, rarity, description, credit,offense, defense,hitRange,attackCooldown,avatar ) VALUES  ("#5", "Big Hammer" , "Melee" , "Uncommon" , "A Big Hammer of ancient origin. The grip is covered with strange ornamentations, which may make it valuable to historians and other scholarly-minded individuals",1000,5,2,2,1.25,"iVBORw0KGgoAAAANSUhEUgAAAAoAAAAlCAYAAAB7yHheAAAAdElEQVR4nGNkQAJKSkr/kfn37t1jhLGZGNBArhw7w2I7ZnRhBkZ0U3ABFgYGBobbV0/jVaSqbQpRWHr/IUETMdyICxDtRkZkjpKS0v9cOXYGM4U/DLGH/uIPHordOKpwVOGowlGFhAELusDkRz8ZGB5hKgQAB04ZEm+S/pEAAAAASUVORK5CYII=");

Insert into Enemy (id, name, description, avatar, experience, damage, health) values ('#1', 'Chort', 'Born in hell', 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAYCAYAAADzoH0MAAAA20lEQVR4nO1SMQ6CQBAciAk/oHcJlddq4wd8h51vMFS+hgeQ+AErWqhIeAAJNbEgZyPJwe4iUlk4zV525ub2dhf44wdBRHY1T0S271qriSTel4RVmbOXiMhWZc60m9Xlagbxbg8AuJuQiQfOBftCEhjxsmta17WnGnwL1SBKM0RpxnKLDZZCncL5cAEAXLc8p4KIrLssWnTveJLJ3CPuBAChB1PBJ44ZzFUgcf5UMOy7Fvuu1XtARDYJDI5xoxWBU9GMviKO8VGFuD2LUS4JzPs0NmcVDOdpwzTuBcUDcHpTUF6vAAAAAElFTkSuQmCC','20','1','10');
Insert into Enemy (id, name, description, avatar, experience, damage, health) values ('#2', 'IceZombie', 'Cold-blooded like an assassin', 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAm0lEQVR4nGNkQANKSkr/0cWQwb179xiR+SzYFMn7pTMYprliiG/wCcEQY8JnGzFgEBuwwScExc/Y/E9bF9y+eprh9tXTKHz6uoBYwIhNUElJ6b+8XzqK2MNNMzFSIQMDjpQIA8ip8eGmmVjV4PQCsubzs3bjtATDSUpKSv8DtqzBqniDTwhxmen8rN0YTkYPE7wugLFhtmETgwEAge0zsLVvA7kAAAAASUVORK5CYII=','20','1','10');
Insert into Enemy (id, name, description, avatar, experience, damage, health) values ('#3', 'Slime', 'Sluggish but lethal', 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAwklEQVQ4jdWSoQ7CMBRFT5cmCMIH4MFiJhBLwPI5c3zDHL80gZjAzG4eN0PI0mRJUW1etzVMYLiqeX3n9jXvwt9LRep2af+4YAHSPGO93QQX7+eLx+0+4aSBTfMMYAJLE8AZKWlg516NSUyj1BjeHfYAtHWzyCSRIy+FJaNlsa0bTNdHoaooATgVF19L3MF0fQBXRemBsWSfdv/RKz3bLHW8nv3ZbSTYAvDVaDADQLAFJx+imMlghkmY5qIci3EA/kwfSXBOWWLl+AQAAAAASUVORK5CYII=','20','20','10');
Insert into Enemy (id, name, description, avatar, experience, damage, health) values ('#4', 'Skeleton', 'Risen from their graves to eat flesh', 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAqElEQVR4nGNgGGjAiMxRUlL6T4yme/fuwfWxoEtunNvOoGXhglOzqrYpCp+JGBvxAZwGqGqbYtiGzqetCzbObWfYOLcdxWYYHxlgBCIMIAfk7aunkcQqiXMBsQBvOoA52T8Z1VbkdIATKCkp/f/7/e3/v9/f/seXwLB6AZsGXIZgGABTCAs4ZDZRSV1JSen/5f0r/yspKaFgmBi6eozAQFYECyxsYjAAABi7RdOrKMILAAAAAElFTkSuQmCC','50','3','20');


INSERT INTO Map (id,name,level,type1Map,type2Objects) VALUES  ("#0" ,"Beta Dungeon" ,0,"EEEEEEEEEEEEEEEXEEEEEEEE;EFFFFFFFFFFFFFFFFFFFFFFE;EFFFFFMMFMFFFFFFFFFFFFFE;EFFFFFMFFMFFFFFFFFEEEEEE;EFFMMMFQMMMFFFFFFFE;EFFFFMMFFMMMMFFFFFE;EFFFFFFFFFFFFFQFFFE;EFFFFFFFFFFFFFFFFFEEEEE;EFFFFFFMMFFFFFFFFFFFFFE;EEEEEEEEEEEEEEEEEEEEEEE" ,"P,1,1;C,3,7,5,5,10;I,2,8,10,8,20;S,3,4,4,3,5;N,2,4;L,2,6;L,3,3;L,2,3;L,1,3;K,7,6;T,15,8,1;T,10,7;b,13,8,4,4,6.5,10;h,3,9,10;h,2,4,5;c,3,6,25;c,8,6,50");
INSERT INTO Map (id,name,level,type1Map,type2Objects) VALUES  ("#2" ,"Grim Desert" ,0,"CCCCCXCCCCCCCCCC;CLLLLLLLLLLLLLLC;CLLLRRLLLLLLLLLC;CLLLLLLLLLLLRLLC;CLLLLLLLLLLLRLLC;CLLLLLRRLLLLRLLC;CLLLLLLLLLLLLLLC;CLLLLLLLLLLLLLLC;CLLLLLLLLLLLLLLC;CLLRRRRLLRRLLLLC;CLLLLLLLLLLLLLLC;CCCCCCCCCCCCCCCC" ,"P,2,2;C,3,7,15,5,10;T,14,8,1;b,12,10,4,4,1.5,10;h,6,8,10;h,3,4,5;c,10,6,25;c,8,6,50;x,8,10;K,7,6");
INSERT INTO Map (id,name,level,type1Map,type2Objects) VALUES  ("#3" ,"Massacre Swampy" ,0,"SSSSSSSSSSSSSSSS;SAAAAAAWWWAAAAAS;SAAAAAAWWWAAAAAS;SAAAAAAAAAAAAAAS;SAAAAAAAAAAAAAAS;XAAWWWWAAAAWWAAS;SAAWWWWAAAAWAAAS;SAAAAAAAAAAAAAAS;SAAAAAAAWWAAAAAS;SAAAAAAAWWAAAAAS;SAAAAAAAAAAAAAAS;SSSSSSSSSSSSSSSS" ,"P,1,2;S,3,4,4,3,5;T,2,11,1;b,13,8,4,4,6.5,10;K,7,6;h,3,9,10;h,2,4,5;c,3,6,25;c,13,6,50;t,2,10;l,12,5");
INSERT INTO Map (id,name,level,type1Map,type2Objects) VALUES  ("#1" ,"Kiramar" ,0,"                                            CCCCCCCCCCCCCCCCCC;                                           CLLLLLLLLLLLLXCCCC;                            CCCCCCCC         CLLLLLLCCLLLLLLCCC;                     CCCCCCCLLLLLLLLC        CLLLLLLLLLLLLLLLLC;                     CLLLLLLLLLLLLLLC        CLLLLLLCCCCCCCCCCC;                     CLCCCCCCCCCCCCLC        CLLLLLLLLCCC;CCCCCCCCCCCCCCCCCCCCCCLCC         CLC       CLLLCCCCCCC;CLLLLLCCCCCCLLLLCCCCCCLCC         CLC       CLLLC;CLLCCCCLLLLLLCCCLLLLLLLLC         CLC       CLLLCCCCCCCCCCCCCCCCCCCCC;CLCCCCCCCLLLCCCCCCLLLCCCC         CLC       CLLLLLLLLLLLLLLLLLLLLLLLC;CLLLCCCCLLLCCCCCCCLLCCCCC         CLC       CLLLCCCCCCCCCCCCCCCCCCCCC;CLLCCCLLLCCLLLLCCLLLLLCCC         CLC       CLLLC;   CLCCLLCCCLLLCCCLLCCCCCCCC        CLC       CLLLC;    CLLLLCCLLLCCLLLLCCCCLLLCCCCCCCCCCCLCCCCCCCLLLCCCCCC; CLLCCCLLCCCLLLCCCLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLCCC;CLLLLCCLLCCLLLCCLCLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLCCCC;CLLCCCLLLCCCLLCCLCLLCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;CLLLCCCLLLCCCLLCLCCLLLCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC; CLLLCCCLLLLCLLLLCLLLCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC; CLLCCLLLLCCLLLCCCLLCCCCCC; CLLLLLLLLLLLLLLLLLLCCCC; CCCCCLLLLLLLLLLLLLLLCCC; CLLLLLCCLLLCCCCLLLCCCCCCCCCCCCCCC; CLLLLLLLLLLCCCCLLLLLLLLLLLLLLLLLC; CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC","P,31,1;C,16,1,5,5,10;T,3,2,10;K,2,2;K,34,20;C,35,20;N,35,21;T,30,20;x,31,21;K,67,15;C,66,15;N,63,15;h,60,15;x,46,17;C,45,16;C,45,13;K,52,21;c,39,9,25;c,42,9,13;K,37,9;L,35,14;L,10,7;L,9,7;L,8,7;K,4,17;h,14,13;C,2,11;N,18,16;x,13,7;T,13,10;h,13,17;L,31,9;L,31,10;N,56,21;x,47,21;C,25,9;h,53,23");
INSERT INTO Map (id,name,level,type1Map,type2Objects) VALUES  ("#4" ,"Deathly Dungeon" ,1,"EEEEEEEEEEEEEEEEEEEEEEEEEEEEE                     EEEEEXEEEEEEEEE;EFFFFFFFFFFFFFFFFFFFFFFFFFFFE                     EFFFFFFFFFFFFFE;EFFFFFMMMMMMMFFMMFFFFFFMMFFFE                     EFFFFFFFFFFFFFE;EFFFFFMFFFFFFFFFFFFFFMMMFFFFE              EEEEEEEEFFEEEEEEEEEEEE;EFMMMMMFMMMFMFFFFFFFFFFFFFFFE              EFFFFFFFFFFFFFMFMMMFFFEEEEEEEEEEEE;EFMFFFFFFFMFMFFFFFFFMMMMMMFFE              EFFFFFFFMMMFFFFFFFFFFFFFFFFFFFFFFE;EFMFFMMMFFMFFFFFFFFMMFFFFFFFEEEEEEEEEEEEEEEEFFFFMMMMFFFFFFFFFFFMFFFFFFMFFFFFE;EFMFFFFFFFFFFFFFFFFMFFFFFFMFFFFFFFFFFFFFFFFFFFFFMFFFFFMFFMFFFFFMFFFFFMMMFFFFE;EFMFFMMMMMMFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFMFFMFFFMFMFFFMFFFMFFFFE;EFMFFFFFFFFFFFFFFFFFFFFFMMFFEEEEEEEEEEEEEEEFFFFFEEEEEEEEEEEEEEEEEEEEEEEEEEEEE;EFMMMMFFFFFMMMMMMFMFFMFFFFFFE              EFFFFE;EFFMMMMFFFFMMMMMMFFMFMFFFFFFE               EFFFFE;EMFMFFMFFFFMMFFFMMMMFMMMMMMFE                EFFFFE;EFFMFFMMFFFFMFFFFFFFFFFFFFFFE                 EFFFFEEEEEEEEEEEEEEEEEEEEEEE;EEFFMFMFFFMFMFMFMMMMFFMFFMMFE                  EEEFFFFFFFFFFFFFMFFFFFMFFFE;EEEFFFFFFFFFFFFFMMFFFFMFFFFFE                   EEFFFFFFFFFFFFFFFFFMFFFMFE;EEEEEEEEEEEEEEEEEEEEEEEEEEEEE                    EEEEEEEEEEEEEEEEEEEEEEEEE" ,"P,3,1;I,1,3;C,14,1;S,24,1;I,21,3;C,17,6;S,21,9;S,21,12;S,22,12;S,23,21;C,36,8;C,36,9;I,60,2;I,62,1;I,72,2;c,1,3,10;c,16,3,10;c,26,1,10;c,23,3,10;c,16,8,10;c,21,9,10;c,21,12,10;c,22,12,10;c,23,21,10;c,36,8,10;c,36,9,10;c,60,2,10;c,64,1,10;c,72,2,10;Q,12,4;Q,23,7;Q,24,7;Q,34,8;L,24,11;L,17,14;L,18,14;L,19,14;L,54,1;L,19,14;L,19,14;T,1,14;T,71,2;K,1,8;K,17,14;K,19,6;K,27,14;K,7,15;K,67,2;T,74,10;K,72,8;C,50,8;S,61,10;I,68,11;c,57,14,10;c,61,15,10;c,62,14,10");