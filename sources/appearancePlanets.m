function [] = appearancePlanets(AmbSun, AmbPlanets, DiffStrPlanets)

    material dull               %planet reflects more diffuse light and has no specular highlights
    shading interp              %surfaces of planets won't be pixelated
    
    sun.AmbientStrength = AmbSun;
    
    mercury.AmbientStrength = AmbPlanets;
    mercury.DiffuseStrength = DiffStrPlanets;
    
    venus.AmbientStrength = AmbPlanets;
    venus.DiffuseStrength = DiffStrPlanets;
    
    earth.AmbientStrength = AmbPlanets;
    earth.DiffuseStrength = DiffStrPlanets;
    
    moon.AmbientStrength = AmbPlanets;
    moon.DiffuseStrength = DiffStrPlanets;
    
    mars.AmbientStrength = AmbPlanets;
    mars.DiffuseStrength = DiffStrPlanets;
    
    jupiter.AmbientStrength = AmbPlanets;
    jupiter.DiffuseStrength = DiffStrPlanets;
    
    saturn.AmbientStrength = AmbPlanets;
    saturn.DiffuseStrength = DiffStrPlanets;
    
    uranus.AmbientStrength = AmbPlanets;
    uranus.DiffuseStrength = DiffStrPlanets;
    
    neptune.AmbientStrength = AmbPlanets;
    neptune.DiffuseStrength = DiffStrPlanets;

end