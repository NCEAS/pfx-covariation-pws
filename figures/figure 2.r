

X = seq(1980,2010)

EVOS.pulse = rep(0, length(X))
EVOS.pulse[which(X==1989)]=-1
EVOS.press = rep(0, length(X))
EVOS.press[which(X>=1989)]=-1
EVOS.pressRecovery = rep(0, length(X))
EVOS.pressRecovery[which(X>=1989 & X <= 2008)]=seq(-1, 0, length.out=length(which(X>=1989 & X <= 2008)))

pdf("Figure 02 Illustrating EVOS impacts.pdf")
par(mfrow =c(2,2), mai = c(0.5,0.5,0.3,0.1))
plot(X, EVOS.pulse, xlab = "", ylab = "Impact",
     main = "Pulse",col="grey30",lwd=3,type="l")
plot(X, EVOS.press, xlab = "", ylab = "Impact",
     main = "Press",col="grey30",lwd=3,type="l")
plot(X, EVOS.pressRecovery, xlab = "", ylab = "Impact",
     main = "Pulse/recovery",col="grey30",lwd=3,type="l")

dev.off()