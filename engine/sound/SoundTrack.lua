
SoundTrack = {
    source = nil
}

SoundTrack.__index = SoundTrack

function SoundTrack:new(path)
    local this = setmetatable({}, self)

    this.source = love.audio.newSource(path)

    return this
end

function SoundTrack:play()
    love.audio.play(self.source)
end

function SoundTrack:pause()
    love.audio.pause(self.source)
end

function SoundTrack:stop()
    love.audio.stop(self.source)
end
  