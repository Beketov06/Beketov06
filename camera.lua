ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Camera"
ENT.Author = "Your Name Here"
ENT.Category = "Security"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_BOTH

ENT.CameraPos = Vector(0,0,0) -- camera position relative to camera entity
ENT.CameraAng = Angle(0,0,0) -- the angle at which the camera is oriented
ENT.Range = 256 -- maximum camera range 

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsActive")
end

function ENT:Initialize()
    self:SetModel("models/props_combine/combine_camera001.mdl")
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    if SERVER then
        self:SetTrigger(true)
    end

    if CLIENT then
        self.CamMat = Material("models/weapons/v_toolgun/screen")
    end
end

if SERVER then
    function ENT:Touch(activator)
        if IsValid(activator) and activator:IsPlayer() then
            self:SetIsActive(true)

            local plyname = activator:Nick()
            if not plyname or plyname == "" then
                plyname = "Unknown"
            end

            -- add the player's name to the database (here is the code to add to the database)

            self:EmitSound("buttons/button14.wav")
        end
    end

    function ENT:Think()
        local targets = player.GetAll()
        local pos = self:GetPos() + self:GetForward() * 10 -- the position from which the camera is looking
        local ang = self:GetAngles()
        ang:RotateAroundAxis(ang:Up(), 180) -- rotate the camera 180 degrees (otherwise the picture will be inverted)

        for _, ply in ipairs(targets) do
            if IsValid(ply) and ply:IsPlayer() and ply:GetPos():Distance(self:GetPos()) <= self.Range then
                local view = {}
                view.origin = pos
                view.angles = ang
                view.drawviewer = true

                ply:SetViewEntity(self)
                ply:SetEyeAngles(self.CameraAng)
                ply:DrawViewModel(false)

                render.PushRenderTarget(self:GetRenderTarget())
                render.Clear(0, 0, 0, 255)
                cam.Start3D(pos, ang, 70, 0, 0, self:GetRenderTarget():GetWidth(), self:GetRenderTarget():GetHeight())
                render.SuppressEngineLighting(true)
                render.SetLightingMode(2)

                -- here is the code to render the image from the camera (using the render.Draw* function)

                render.SuppressEngineLighting(false)
                cam.End3D()
                render.PopRenderTarget()

                self:SetCameraPos(pos)
                self:SetCameraAng(ang)

                break -- exit the loop so as not to use the camera on several players at once
            end
