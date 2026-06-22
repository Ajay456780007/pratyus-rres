function UE = Initialize_Users(NumUsers)

UE.ID = 1:NumUsers;

UE.X = rand(1,NumUsers)*1000;

UE.Y = rand(1,NumUsers)*1000;

UE.Speed = 10 + 20*rand(1,NumUsers);

end