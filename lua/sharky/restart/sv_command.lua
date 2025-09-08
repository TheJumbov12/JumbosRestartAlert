
util.AddNetworkString("DisplayTopMessage")

concommand.Add("restartimer", function(ply, cmd, args)
    if IsValid(ply) and not ply:IsAdmin() then return end

    local msg = "THE NUKE IS DROPPING IN:"
    local duration = 300

    net.Start("DisplayTopMessage")
        net.WriteString(msg)
        net.WriteFloat(duration)
    net.Broadcast()
end)
