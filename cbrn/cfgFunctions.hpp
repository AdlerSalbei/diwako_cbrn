  
#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class cbrn{
    tag="cbrn";
    class functions{
        file = MODULES_DIRECTORY\cbrn\functions;
        class init{postInit=1;};
        class startOxygen{};
        class addZone{};
        class createZone{};
        class threatPFH{};
        class handleDamage{};
        class toggleShower{};
        class setUpDeconShower{};
        class getFatigue{};
    };
};