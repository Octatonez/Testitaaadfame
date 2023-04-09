<Cabbage>
image bounds(0,0,800,500) channel("image1"), file("reapperssss.png")
form caption("Reapper") size(800, 500), guiMode("queue"), pluginId("def1")

signaldisplay bounds(590, 240, 170, 140),   colour("white"), displayType("waveform"),     signalVariable("aOutput")
;signaldisplay bounds(590, 240, 170, 140),  colour("red"), displayType("spectroscope"), signalVariable("aOutput")

keyboard bounds(20, 405, 750, 75)

label bounds(20, 30, 400, 15) text("Effects") colour("Grey") fontColour(255, 255, 255, 225)

rslider bounds(20, 60, 65, 65)   channel("vol")  range(0, 1, 0.5, 1, 0.001)           text("Volume")  , filmstrip("knobyellow.png",201)
rslider bounds(90, 60, 65, 65)  channel("att")  range(0.001, 0.25, 0.02, 1, 0.001)   text("Attack")  , filmstrip("knobyellow.png",201)
rslider bounds(160, 60, 65, 65)  channel("dec")  range(0.001, 0.25, 0.01, 1, 0.01)    text("Decay")  , filmstrip("knobyellow.png",201) 
rslider bounds(230, 60, 65, 65)  channel("sus")  range(0, 1, 0.7, 1, 0.001)           text("Sustain") , filmstrip("knobyellow.png",201)
rslider bounds(300, 60, 65, 65)  channel("rel")  range(0, 1, 0.1, 1, 0.001)           text("Release") , filmstrip("knobyellow.png",201)

label bounds(20, 150, 400, 15) text("Carrier") colour("Grey") fontColour(255, 255, 255, 225)

rslider bounds(20, 180, 65, 65)  channel("csin") range(0.001, 1, 0.2, 1, 0.001)  text("Sine")   , filmstrip("knobyellow.png",201)   
rslider bounds(90, 180, 65, 65) channel("csaw") range(0.001, 1, 0.2, 1, 0.001)  text("Saw")      , filmstrip("knobyellow.png",201)
rslider bounds(160, 180, 65, 65) channel("csqu") range(0.001, 1, 0.2, 1, 0.001)  text("Square")   , filmstrip("knobyellow.png",201)
rslider bounds(230, 180, 65, 65) channel("ctri") range(0.001, 1, 0.2, 1, 0.001)  text("Triangle") , filmstrip("knobyellow.png",201)
rslider bounds(300, 180, 65, 65) channel("cimp") range(0.001, 1, 0.2, 1, 0.001)  text("Impulse")  , filmstrip("knobyellow.png",201)

label bounds(20, 270, 400, 15) text("Modulator") colour("Grey") fontColour(255, 255, 255, 225)

rslider bounds(20, 300, 65, 65)  channel("msin") range(0.001, 1, 0.2, 1, 0.001)  text("Sine")    , filmstrip("knobyellow.png",201) 
rslider bounds(90, 300, 65, 65) channel("msaw") range(0.001, 1, 0.2, 1, 0.001)  text("Saw")     , filmstrip("knobyellow.png",201) 
rslider bounds(160, 300, 65, 65) channel("msqu") range(0.001, 1, 0.2, 1, 0.001)  text("Square")   , filmstrip("knobyellow.png",201)
rslider bounds(230, 300, 65, 65) channel("mtri") range(0.001, 1, 0.2, 1, 0.001)  text("Triangle") , filmstrip("knobyellow.png",201)
rslider bounds(300, 300, 65, 65) channel("mimp") range(0.001, 1, 0.2, 1, 0.001)  text("Impulse")  , filmstrip("knobyellow.png",201)

rslider bounds(440, 60, 65, 65)  channel("modind")  range(0, 1000, 500, 1, 0.001)   text("Mod. index")  , filmstrip("knobyellow.png",201)
rslider bounds(440, 180, 65, 65) channel("freqrat") range(0, 5, 1, 1, 0.001)        text("Freq. ratio") , filmstrip("knobyellow.png",201)
rslider bounds(440, 300, 65, 65) channel("fintun")  range(-0.1, 0.1, 0, 1, 0.001)   text("Fine-tuning")  , filmstrip("knobyellow.png",201)

</Cabbage>


<CsoundSynthesizer>

<CsOptions>
-m0d -n -+rtmidi=NULL -M0 --midi-key-cps=4 --midi-velocity-amp=5 --displays 
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

instr 1
  giSin ftgen 0, 0, 2^10, 10, 1
  giSaw ftgen 0, 0, 2^10, 10, 1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7, 1/8, 1/9
  giSqu ftgen 0, 0, 2^10, 10, 1, 0, 1/3, 0, 1/5, 0, 1/7, 0, 1/9
  giTri ftgen 0, 0, 2^10, 10, 1, 0, -1/9, 0, 1/25, 0, -1/49, 0, 1/81
  giImp ftgen 0, 0, 2^10, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1

  kVol chnget "vol"
  iAtt chnget "att"
  iDec chnget "dec"
  iSus chnget "sus"
  iRel chnget "rel"
      
  kCSin chnget "csin"
  kCSaw chnget "csaw"
  kCSqu chnget "csqu"
  kCTri chnget "ctri"
  kCImp chnget "cimp"
  
  kMSin chnget "msin"
  kMSaw chnget "msaw"
  kMSqu chnget "msqu"
  kMTri chnget "mtri"
  kMImp chnget "mimp"

  kModind  chnget "modind"
  kFreqrat chnget "freqrat"
  kFintun  chnget "fintun"

  kRat = kFreqrat + kFintun
  aModulatorSin poscil p5, p4*kRat, giSin
  aModulatorSaw poscil p5, p4*kRat, giSaw
  aModulatorSqu poscil p5, p4*kRat, giSqu
  aModulatorTri poscil p5, p4*kRat, giTri
  aModulatorImp poscil p5, p4*kRat, giImp
  
  kSumM = kMSin + kMSaw + kMSqu + kMTri + kMImp
  aModulator = (kMSin*aModulatorSin + kMSaw*aModulatorSaw + kMSqu*aModulatorSqu + kMTri*aModulatorTri + kMImp*aModulatorImp)/kSumM

  aCarrierSin poscil p5, p4 + kModind*aModulator, giSin
  aCarrierSaw poscil p5, p4 + kModind*aModulator, giSaw 
  aCarrierSqu poscil p5, p4 + kModind*aModulator, giSqu
  aCarrierTri poscil p5, p4 + kModind*aModulator, giTri
  aCarrierImp poscil p5, p4 + kModind*aModulator, giImp
 
  kADSR madsr iAtt, iDec, iSus, iRel
  kSumC =  kCSin + kCSaw + kCSqu + kCTri + kCImp
  aOutput = kADSR*kVol*(kCSin*aCarrierSin + kCSaw*aCarrierSaw + kCSqu*aCarrierSqu + kCTri*aCarrierTri + kCImp*aCarrierImp)/kSumC 

  out aOutput, aOutput
  display aOutput, .1, 1 
  dispfft aOutput, .1, 1024
endin

</CsInstruments>

<CsScore>
;causes Csound to run for about 7000 years...
f0 z
</CsScore> 

</CsoundSynthesizer>