using Preferences: @load_preference, @set_preferences!, @delete_preferences!

export pwx, phx, q2rx, matdynx, dynmatx, getpath, setpath, unsetpath

@enum Executable pwx bandsx dosx phx q2rx matdynx dynmatx

function getpath(exec::Executable)
    if exec == pwx
        return @load_preference("pw.x path", "pw.x")
    elseif exec == bandsx
        return @load_preference("bands.x path", "bands.x")
    elseif exec == dosx
        return @load_preference("dos.x path", "dos.x")
    elseif exec == phx
        return @load_preference("ph.x path", "ph.x")
    elseif exec == q2rx
        return @load_preference("q2r.x path", "q2r.x")
    elseif exec == matdynx
        return @load_preference("matdyn.x path", "matdyn.x")
    elseif exec == dynmatx
        return @load_preference("dynmat.x path", "dynmat.x")
    else
        error("this should not happen!")
    end
end

function setpath(exec::Executable, path::String)
    @assert ispath(path)
    if exec == pwx
        @set_preferences!("pw.x path" => path)
    elseif exec == bandsx
        @set_preferences!("bands.x path" => path)
    elseif exec == dosx
        @set_preferences!("dos.x path" => path)
    elseif exec == phx
        @set_preferences!("ph.x path" => path)
    elseif exec == q2rx
        @set_preferences!("q2r.x path" => path)
    elseif exec == matdynx
        @set_preferences!("matdyn.x path" => path)
    elseif exec == dynmatx
        @set_preferences!("dynmat.x path" => path)
    else
        error("this should not happen!")
    end
end

function unsetpath(exec::Executable)
    if exec == pwx
        @delete_preferences!("pw.x path")
    elseif exec == bandsx
        @delete_preferences!("bands.x path")
    elseif exec == dosx
        @delete_preferences!("dos.x path")
    elseif exec == phx
        @delete_preferences!("ph.x path")
    elseif exec == q2rx
        @delete_preferences!("q2r.x path")
    elseif exec == matdynx
        @delete_preferences!("matdyn.x path")
    elseif exec == dynmatx
        @delete_preferences!("dynmat.x path")
    else
        error("this should not happen!")
    end
end
