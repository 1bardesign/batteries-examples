--
--	interactive intersection example for batteries
--

require("common")

--generate some circle objects
local gen_area = vec2(300, 500)
local function random_point_in_area()
	return vec2(love.math.random(), love.math.random()):vmuli(gen_area)
end
local circles = functional.generate(20, function()
	local c = {
		--circle geometry
		pos = random_point_in_area(),
		rad = love.math.random(5, 20),
		--movement
		vel = vec2(love.math.randomNormal() * 10, love.math.randomNormal() * 10),
	}
	return c
end)

--generate some random "world" lines
local lines = functional.stitch(
	functional.generate(5, random_point_in_area),
	function(start_pos)
		local chain = {}
		local current_pos = start_pos
		local dir = vec2(1, 0):rotatei(math.tau * love.math.random())
		for i = 1, love.math.random(4, 7) do
			table.insert(chain, current_pos)
			current_pos = current_pos:fma(dir, love.math.random(30, 50))
			dir = dir:rotatei(love.math.randomNormal())
		end
		chain = functional.cycle(chain, function(a, b)
			return {a, b}
		end)
		--break loop randomly or if too far (likely to be a bad looking poly)
		local last_link = table.back(chain)
		if 
			love.math.random() < 0.5
			or last_link[1]:distance(last_link[2]) > 100
		then
			table.remove(chain)
		end
		return chain
	end
)

return {
	update = function(self, dt)
		--integrate
		for _, v in ipairs(circles) do
			v.pos:fmai(v.vel, dt)

			-- pull inside world
			local push = 100 * dt
			if OUTPUT_SIZE then
				if v.pos.x < 0 then v.vel:saddi(push, 0) end
				if v.pos.y < 0 then v.vel:saddi(0, push) end
				if v.pos.x > OUTPUT_SIZE.x then v.vel:saddi(-push, 0) end
				if v.pos.y > OUTPUT_SIZE.y then v.vel:saddi(0, -push) end
			end
		end
		-- collide
		-- (reuse this vector)
		local separating_vector = vec2()
		for i = 1, #circles do
			local a = circles[i]
			--collide against other circles
			for j = i+1, #circles do
				local b = circles[j]
				if intersect.circle_circle_collide(
					a.pos, a.rad,
					b.pos, b.rad,
					separating_vector
				) then
					--resolve collision
					a.pos:fmai(separating_vector, 0.5)
					b.pos:fmai(separating_vector, -0.5)

					--reuse the separating vector as the normal
					local normal = separating_vector:normalisei()

					--transfer velocities
					local old_a_vel = a.vel
					local old_b_vel = b.vel
					a.vel = old_a_vel:vrej(normal)
					b.vel = old_b_vel:vrej(normal)
					local a_remaining = old_a_vel:vsub(a.vel)
					local b_remaining = old_b_vel:vsub(b.vel)
					a.vel:vaddi(b_remaining)
					b.vel:vaddi(a_remaining)
				end
			end

			--collide against lines
			for _, line in ipairs(lines) do
				if intersect.line_circle_collide(
					line[1], line[2], 0,
					a.pos, a.rad,
					separating_vector
				) then
					a.pos:fmai(separating_vector, -1)
					intersect.bounce_off(a.vel, separating_vector:normalisei())
				end
			end
		end
	end,
	draw = function(self)
		for _, v in ipairs(circles) do
			love.graphics.circle("fill", v.pos.x, v.pos.y, v.rad)
		end
		local g = 0.7
		love.graphics.setColor(g, g, g, 1)
		for _, v in ipairs(lines) do
			love.graphics.line(v[1].x, v[1].y, v[2].x, v[2].y)
		end
	end,
}

