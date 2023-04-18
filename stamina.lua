if SERVER then -- код на стороне сервера
    local PLAYER = FindMetaTable("Player") -- получаем таблицу методов игрока
    
    function PLAYER:SetStamina(stamina) -- функция установки выносливости
        self:SetNWInt("Stamina", stamina) -- устанавливаем значение выносливости для данного игрока
    end
    
    function PLAYER:GetStamina() -- функция получения текущей выносливости
        return self:GetNWInt("Stamina", 100) -- возвращаем значение выносливости, если оно не установлено, то значение по умолчанию - 100
    end
    
    function PLAYER:UseStamina(amount) -- функция использования выносливости
        local current_stamina = self:GetStamina() -- получаем текущую выносливость
        local new_stamina = current_stamina - amount -- вычитаем из текущей выносливости значение, которое нужно потратить
        
        if new_stamina < 0 then -- если после вычета выносливости стала меньше нуля, то выставляем ее в ноль
            new_stamina = 0
        end
        
        self:SetStamina(new_stamina) -- устанавливаем новое значение выносливости для данного игрока
    end
    
    function PLAYER:RegenerateStamina(amount) -- функция восстановления выносливости
        local current_stamina = self:GetStamina() -- получаем текущую выносливость
        local max_stamina = 100 -- максимальное значение выносливости
        
        if current_stamina < max_stamina then -- если текущая выносливость меньше максимальной, то увеличиваем ее на указанное количество
            local new_stamina = current_stamina + amount
            
            if new_stamina > max_stamina then -- если после увеличения выносливости она стала больше максимальной, то выставляем ее в максимальное значение
                new_stamina = max_stamina
            end
            
            self:SetStamina(new_stamina) -- устанавливаем новое значение выносливости для данного игрока
        end
    end
    
    function PLAYER:Think() -- функция, вызываемая каждый тик
        if self:Alive() then -- если игрок жив
            local current_stamina = self:GetStamina() -- получаем текущую выносливость
            
            if current_stamina < 100 then -- если текущая выносливость меньше максимальной
                self:RegenerateStamina(1) -- то восстанавливаем ее каждый тик на 1
            end
        end
    end
    hook.Add("PlayerTick", "StaminaThink", function(ply) ply:Think() end) -- подключаем функцию Think() к хуку PlayerTick
end

if CLIENT then -- код на стороне клиента
    local stamina_bar = Material("materials/stamina_bar.png") --