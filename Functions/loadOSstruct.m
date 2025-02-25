function [muscle_struct] = loadOSstruct(OS_struct)
model = load(OS_struct);
muscles = model.model.muscles;
num_muscles = length(muscles);
for imus = 1:num_muscles
    muscle_struct.polys{imus}.fmax = muscles{imus}.fmax;
    muscle_struct.polys{imus}.lceopt = muscles{imus}.lceopt;
    muscle_struct.polys{imus}.lslack = muscles{imus}.lslack;
    muscle_struct.polys{imus}.dof_indeces = muscles{imus}.dof_indeces-3;
    muscle_struct.polys{imus}.lcoefs = muscles{imus}.Quaternion.lcoefs;
    muscle_struct.polys{imus}.lparams = muscles{imus}.Quaternion.lparams;
    muscle_struct.polys{imus}.lparam_count = muscles{imus}.Quaternion.lparam_count;

    muscle_struct.fmax(imus,1) = muscles{imus}.fmax;
    muscle_struct.lceopt(imus,1) = muscles{imus}.lceopt;
    muscle_struct.lslack(imus,1) = muscles{imus}.lslack;
end

end