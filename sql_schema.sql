-- @block
DROP TABLE IF EXISTS Players, Demos, Damages,
Weapon, Rounds, Map, 
Player_in_Demo, Player_in_Round;

-- @block
CREATE TABLE Players(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Map(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Image VARCHAR(255) NOT NULL,
    Dimensions_x INT NOT NULL,
    Dimensions_y INT NOT NULL
);

CREATE TABLE Weapon(
    id INT UNSIGNED NOT NULL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    Magazine_size INT NOT NULL,
    Damage_per_bullet INT NOT NULL,
    Bullet_per_seconde INT NOT NULL
);

CREATE TABLE Demos(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    FK_Map INT UNSIGNED NOT NULL,
    FOREIGN KEY (FK_Map) REFERENCES Map(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Rounds(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tick_start INT NOT NULL,
    winner VARCHAR(2) NOT NULL,
    FK_demo INT UNSIGNED NOT NULL,

    FOREIGN KEY(FK_demo) REFERENCES Demos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Player_in_Demo(
    FK_Player INT UNSIGNED NOT NULL,
    FK_Demo INT UNSIGNED NOT NULL,
    PRIMARY KEY (FK_Player, FK_Demo),

    FOREIGN KEY(FK_Player) REFERENCES Players(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(FK_Demo) REFERENCES Demos(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Player_in_Round(
    FK_Round INT UNSIGNED NOT NULL,
    FK_Player INT UNSIGNED NOT NULL,
    PRIMARY KEY (FK_Round, FK_Player),

    FOREIGN KEY(FK_Round) REFERENCES Rounds(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(FK_Player) REFERENCES Players(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Damages(
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tick INT NOT NULL,
    HS TINYINT(1) NOT NULL,
    damages INT NOT NULL,
    killed TINYINT(1) NOT NULL,
    k_pos_x INT NOT NULL,
    k_pos_y INT NOT NULL,
    v_pos_x INT NOT NULL,
    v_pos_y INT NOT NULL,
    FK_round INT UNSIGNED NOT NULL,
    FK_killer INT UNSIGNED NOT NULL,
    FK_Killed_with_weapon INT UNSIGNED NOT NULL,
    FK_victim INT UNSIGNED NOT NULL,

    FOREIGN KEY(FK_round) REFERENCES Rounds(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(FK_Killed_with_weapon) REFERENCES Weapon(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(FK_killer) REFERENCES Players(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY(FK_victim) REFERENCES Players(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
