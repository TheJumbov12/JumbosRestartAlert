local activeMessage = nil
local messageEndTime = 0
local spinAngle = 0


Sharky.GetImgur("XqQLhSL", function(data) spinnerMaterial2 = data end)
-- local spinMat = Material(spinnerMaterial2)

net.Receive("DisplayTopMessage", function()
    local msg = net.ReadString()
    local duration = net.ReadFloat()
    surface.PlaySound("ambient/alarms/manhack_alert_pass1.wav")
    activeMessage = msg
    messageEndTime = CurTime() + duration
    spinAngle = 0
end)
-- F
hook.Add("HUDPaint", "DrawTopMessage", function()
    if not activeMessage then return end

    local timeLeft = math.max(0, messageEndTime - CurTime())
    if timeLeft <= 0 then
        activeMessage = "The nuke has dropped."
        if timeLeft <= -5 then
            activeMessage = nil
            return
        end
    end

    spinAngle = (spinAngle + FrameTime() * 90) % 360

    local centerX, centerY = ScrW() / 2, 70
    local imgSize = 128 

    
    surface.SetDrawColor(255, 255, 255, 200)
    surface.SetMaterial(spinnerMaterial2)
    surface.DrawTexturedRectRotated(centerX, centerY, imgSize, imgSize, spinAngle)

    draw.SimpleText(
        activeMessage,
        "Sharky.25",
        ScrW() / 2,
        50,
        Color(255, 255, 255, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_TOP
    )

    draw.SimpleText(
        string.FormattedTime(timeLeft, "%02i:%02i:%02i"),
        "Sharky.25",
        ScrW() / 2,
        90,
        Color(255, 200, 200, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_TOP
    )
end)
