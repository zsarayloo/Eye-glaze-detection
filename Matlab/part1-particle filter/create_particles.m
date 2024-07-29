function X = create_particles(bbox, Npop_particles)
bboxPoints = bbox2points(bbox(1, :));


X1 = randi(bbox(1, 4), 1, Npop_particles)+bbox(1, 2);
X2 = randi(bbox(1, 3), 1, Npop_particles)+bbox(1, 1);
X3 = zeros(2, Npop_particles);

X = [X1; X2; X3];
