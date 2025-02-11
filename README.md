# Shoulder model

- model obsahuje 137 svalovych elementu
- 3 sfericke klouby
    - **SC**: Sternoklavikularni kloub (mezi hrudnikem a klicni kosti)
    - **AC**: Akromioklavikularni kloub (mezi klicni kosti a lopatkou)
    - **GH**: Glenohumeralni kloub (mezi lopatkou a pazni kosti)
- 1 rotacni kloub:
    - **Elbow**: loketni kloub
- Klouzani lopatky po hrudniku je modelovano pomoci 2 kontaktnich bodu na lopatce (kontaktni teleso je hrudnik modelovany jako elipsoid)

## Slozka `Python`
- `equations.py`
  - hlavni soubor se scripty pro odvozovani vsech rovnic ve tvaru $M(q)\dot{u} = f_{ext}(q,u)$, kde $q$ jsou souradnice a $u$ jsou rychlosti.
  - `create_eoms_eul` (radek 1043) vytvori rovnice, kde sfericke klouby jsou popsany popsany pomoci Eulerovych uhlu
  - `create_eoms_quat` (radek 680) vytvori rovnice, kde sfericke klouby jsou popsany popsany pomoci quaternionu 
- `gen_matlab_functions.ipynb`
  - Jupyter notebook soubor, ktery pousti prislusne funkce pro odvozeni rovnic
  - Rovnice jsou vygenerovany jako Matlabovske funkce ve slozce `equations_of_motion`

## `das3.osim`
  - OpenSim model ramene

## `shoulder_simulink.slx`
  - V Simscapu vytvoreny odpovidajici model (beze svalu) pro 'overeni' rovnic
  - forward dynamics simulace - model s Eulerovy uhly, quaterniony a Simscape model, chyba vyslednych trajektorii mezi rovnicemi a Simscapem modelem je v radu 10e-5 (Simscape pouziva Composite-rigid-body metodu)
