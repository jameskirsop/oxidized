class ZoneDirector < Oxidized::Model

    prompt /^ruckus(>|#) $/
    
    cmd :all do |cfg|
        cfg = cfg.gsub /\r\r/, '\r'
    end

    cmd :secret do |cfg|
        cfg.gsub! /(Passphrase).*/, 'Passphrase <password removed>'
        cfg.gsub! /(Password=).*/, 'Password= <password removed>'
    end

    cmd 'show config'

    cfg :ssh do
        username /^Please\slogin:/
        password /^Password:/

        post_login do
            send "enable\n"
        end

        pre_logout do
            send "exit\n"
        end
    end
end