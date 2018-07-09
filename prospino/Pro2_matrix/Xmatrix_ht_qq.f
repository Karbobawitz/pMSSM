cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c                                                                      c
c     THE SCALING FUNCTIONS                                            c
c                                                                      c
c     HT_QQH(MASSIN,C)                                                 c
c                                                                      c
c     INPUT :                                                          c
c                                                                      c
c       MASSIN(1)  = s                                                 c
c       MASSIN(2)  = t2                                                c
c       MASSIN(3)  = s4                                                c
c       MASSIN(6)  = m1                                                c
c       MASSIN(7)  = m2                                                c
c       MASSIN(9)  = mt                                                c
c       MASSIN(11) = ms                                                c
c       MASSIN(12) = qr                                                c
c       MASSIN(13) = qf                                                c
c       MASSIN(4-5,8,10,13-30) not needed                              c
c                                                                      c
c                                                                      c
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

c --------------------------------------------------------------------
      real*8 function HT_QQH(massin,h_l,h_r,lumi)

      implicit none 

      real*8     massin(1:30),lumi(1:3),Pi,Nc,Cf,h_l,h_r,h_l2,h_r2
     &          ,qf,log_qf,log_all,s,s4,m1,m2,m12,t2,u2,t2t,u2t
     &          ,hardfac,alphas
     &          ,MM_qq_4,ANG_fin(0:9,0:9,-2:2,-2:2)
     &          ,qb,bq,bb

      Pi = 4.D0*atan(1.D0)
      Nc = 3.D0 
      Cf = 4.D0/3.D0

      h_l2 = h_l**2
      h_r2 = h_r**2

      s   = massin(1)
      t2  = massin(2)
      s4  = massin(3)
      m1  = massin(6)
      m2  = massin(7)

c               real kinematics built in
      u2  = s4 - s - t2 - m2**2 + m1**2 

      m12 = m1**2
      t2t = t2 + m2**2 - m1**2 
      u2t = u2 + m2**2 - m1**2 
ctp      s4j = s4 + m1**2 - m2**2

      hardfac = 1.D0
ctp      mjs2 = m2**2 - m1**2

c               the angular functions 
      call ANGULAR_ARRAY_HT_QQ(massin,ANG_fin)

c               the factorization/renormalization scale 
      qf = massin(13) 
      log_qf  = log(qf**2/m1**2)
      log_all = log_qf - log(s4/m1**2) + log(1.D0+m1**2/s4)

c               gs**2=4*pi*alpha_s is cut, re-appears as nlo later 
      alphas = 1.D0

c               the three luminosities 
      qb = lumi(1)
      bq = lumi(2)
      bb = lumi(3)

      MM_qq_4 = 0.D0

      MM_qq_4 =
     +  + bb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*alphas**2*hardfac*
     + (log_all-1.D0) * ( 32*(s+t2)**(-2)*m1**2*s*u2t**(-1) + 32*
     +    (s+t2)**(-2)*m1**2*t2*u2t**(-1) - 32*(s+t2)**(-2)*m2**2*s*
     +    u2t**(-1) - 32*(s+t2)**(-2)*m2**2*t2*u2t**(-1) + 32*
     +    (s+t2)**(-2)*t2 - 64*(s+t2)**(-1)*m1**2*m2**2*u2t**(-2) + 64*
     +    (s+t2)**(-1)*m1**2*s**(-1)*t2*u2t**(-1) + 64*(s+t2)**(-1)*
     +    m1**2*s*u2t**(-2) + 64*(s+t2)**(-1)*m1**2*t2*u2t**(-2) + 96*
     +    (s+t2)**(-1)*m1**2*u2t**(-1) + 64*(s+t2)**(-1)*m1**4*
     +    u2t**(-2) - 64*(s+t2)**(-1)*m2**2*s**(-1)*t2*u2t**(-1) - 64*
     +    (s+t2)**(-1)*m2**2*s*u2t**(-2) - 64*(s+t2)**(-1)*m2**2*t2*
     +    u2t**(-2) - 96*(s+t2)**(-1)*m2**2*u2t**(-1) + 32*(s+t2)**(-1)
     +    *s**(-1)*t2 + 64*(s+t2)**(-1)*t2*u2t**(-1) + 64*(s+t2)**(-1)
     +     + 32*(s+u2)**(-2)*m1**2*s*t2t**(-1) + 32*(s+u2)**(-2)*m1**2*
     +    u2*t2t**(-1) - 32*(s+u2)**(-2)*m2**2*s*t2t**(-1) - 32*
     +    (s+u2)**(-2)*m2**2*u2*t2t**(-1) + 32*(s+u2)**(-2)*u2 - 64*
     +    (s+u2)**(-1)*m1**2*m2**2*t2t**(-2) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 64*(s+u2)**(-1)*m1**2*
     +    s**(-1)*u2*t2t**(-1) + 64*(s+u2)**(-1)*m1**2*s*t2t**(-2) + 64
     +    *(s+u2)**(-1)*m1**2*u2*t2t**(-2) + 96*(s+u2)**(-1)*m1**2*
     +    t2t**(-1) + 64*(s+u2)**(-1)*m1**4*t2t**(-2) - 64*(s+u2)**(-1)
     +    *m2**2*s**(-1)*u2*t2t**(-1) - 64*(s+u2)**(-1)*m2**2*s*
     +    t2t**(-2) - 64*(s+u2)**(-1)*m2**2*u2*t2t**(-2) - 96*
     +    (s+u2)**(-1)*m2**2*t2t**(-1) + 32*(s+u2)**(-1)*s**(-1)*u2 + 
     +    64*(s+u2)**(-1)*u2*t2t**(-1) + 64*(s+u2)**(-1) + 256*m1**2*
     +    m2**2*s**(-1)*t2*u2t**(-3) + 256*m1**2*m2**2*s**(-1)*t2**2*
     +    u2t**(-4) + 256*m1**2*m2**2*s**(-1)*u2*t2t**(-3) + 256*m1**2*
     +    m2**2*s**(-1)*u2**2*t2t**(-4) + 128*m1**2*m2**2*s**(-1)*
     +    u2t**(-2) + 128*m1**2*m2**2*s**(-1)*t2t**(-2) + 128*m1**2*
     +    m2**2*s*u2t**(-4) + 128*m1**2*m2**2*s*t2t**(-4) + 384*m1**2*
     +    m2**2*t2*u2t**(-4) + 384*m1**2*m2**2*u2*t2t**(-4) + 128*m1**2
     +    *m2**2*u2t**(-3) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 128*m1**2*m2**2*t2t**(-3)
     +     - 128*m1**2*s**(-1)*t2*u2t**(-2) - 128*m1**2*s**(-1)*t2**2*
     +    u2t**(-3) - 128*m1**2*s**(-1)*u2*t2t**(-2) - 128*m1**2*
     +    s**(-1)*u2**2*t2t**(-3) - 128*m1**2*s**(-1)*u2t**(-1) - 128*
     +    m1**2*s**(-1)*t2t**(-1) - 128*m1**2*t2*u2t**(-3) - 128*m1**2*
     +    u2*t2t**(-3) - 64*m1**2*u2t**(-2) - 64*m1**2*t2t**(-2) - 128*
     +    m1**4*s**(-1)*t2*u2t**(-3) - 128*m1**4*s**(-1)*t2**2*
     +    u2t**(-4) - 128*m1**4*s**(-1)*u2*t2t**(-3) - 128*m1**4*
     +    s**(-1)*u2**2*t2t**(-4) - 64*m1**4*s**(-1)*u2t**(-2) - 64*
     +    m1**4*s**(-1)*t2t**(-2) - 128*m1**4*t2*u2t**(-4) - 128*m1**4*
     +    u2*t2t**(-4) + 128*m2**2*s**(-1)*t2*u2t**(-2) + 128*m2**2*
     +    s**(-1)*t2**2*u2t**(-3) + 128*m2**2*s**(-1)*u2*t2t**(-2) + 
     +    128*m2**2*s**(-1)*u2**2*t2t**(-3) + 128*m2**2*s**(-1)*
     +    u2t**(-1) + 128*m2**2*s**(-1)*t2t**(-1) + 128*m2**2*t2*
     +    u2t**(-3) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 128*m2**2*u2*t2t**(-3) + 64
     +    *m2**2*u2t**(-2) + 64*m2**2*t2t**(-2) - 128*m2**4*s**(-1)*t2*
     +    u2t**(-3) - 128*m2**4*s**(-1)*t2**2*u2t**(-4) - 128*m2**4*
     +    s**(-1)*u2*t2t**(-3) - 128*m2**4*s**(-1)*u2**2*t2t**(-4) - 64
     +    *m2**4*s**(-1)*u2t**(-2) - 64*m2**4*s**(-1)*t2t**(-2) - 128*
     +    m2**4*s*u2t**(-4) - 128*m2**4*s*t2t**(-4) - 256*m2**4*t2*
     +    u2t**(-4) - 256*m2**4*u2*t2t**(-4) - 128*m2**4*u2t**(-3) - 
     +    128*m2**4*t2t**(-3) - 64*s**(-1)*t2*u2t**(-1) - 64*s**(-1)*
     +    t2**2*u2t**(-2) - 64*s**(-1)*u2*t2t**(-1) - 64*s**(-1)*u2**2*
     +    t2t**(-2) - 128*s**(-1) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac * ( 32*(s+t2)**(-2)*m1**2*t2*u2t**(-1) - 32*
     +    (s+t2)**(-2)*m2**2*t2*u2t**(-1) - 32*(s+t2)**(-2)*t2*u2*
     +    u2t**(-1) + 32*(s+t2)**(-2)*t2 + 64*(s+t2)**(-1)*m1**2*s*
     +    u2t**(-2) + 64*(s+t2)**(-1)*m1**2*t2*u2t**(-2) + 64*
     +    (s+t2)**(-1)*m1**2*u2t**(-1) - 64*(s+t2)**(-1)*m2**2*s*
     +    u2t**(-2) - 64*(s+t2)**(-1)*m2**2*t2*u2t**(-2) - 64*
     +    (s+t2)**(-1)*m2**2*u2t**(-1) - 32*(s+t2)**(-1)*s**(-1)*t2 + 
     +    32*(s+t2)**(-1)*s*u2t**(-1) + 96*(s+t2)**(-1)*t2*u2t**(-1) - 
     +    64*(s+t2)**(-1)*u2*u2t**(-1) + 32*(s+t2)**(-1) - 32*
     +    (s+u2)**(-2)*s*u2*t2t**(-1) - 32*(s+u2)**(-2)*u2**2*t2t**(-1)
     +     + 64*(s+u2)**(-1)*m1**2*s*t2t**(-2) + 64*(s+u2)**(-1)*m1**2*
     +    u2*t2t**(-2) - 32*(s+u2)**(-1)*m1**2*t2t**(-1) - 64*
     +    (s+u2)**(-1)*m2**2*s*t2t**(-2) - 64*(s+u2)**(-1)*m2**2*u2*
     +    t2t**(-2) + 32*(s+u2)**(-1)*m2**2*t2t**(-1) - 32*(s+u2)**(-1)
     +    *s**(-1)*u2 )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac * ( 32*(s+u2)**(-1)*t2*t2t**(-1) + 96*
     +    (s+u2)**(-1)*u2*t2t**(-1) - 64*(s+u2)**(-1) - 64*m1**2*
     +    u2t**(-2) - 64*m1**2*t2t**(-2) + 64*m2**2*u2t**(-2) + 64*
     +    m2**2*t2t**(-2) - 64*s**(-1)*t2*u2t**(-1) - 64*s**(-1)*t2**2*
     +    u2t**(-2) - 64*s**(-1)*u2*t2t**(-1) - 64*s**(-1)*u2**2*
     +    t2t**(-2) + 64*s**(-1) - 32*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Cf*Pi**3*alphas**2*
     + hardfac * ( 32*(s+t2)**(-2)*m1**2*s*t2*u2t**(-1)*t2t**(-1) + 32*
     +    (s+t2)**(-2)*m1**2*s**2*u2t**(-1)*t2t**(-1) - 32*(s+t2)**(-2)
     +    *m2**2*s*t2*u2t**(-1)*t2t**(-1) - 32*(s+t2)**(-2)*m2**2*s**2*
     +    u2t**(-1)*t2t**(-1) + 32*(s+t2)**(-2)*s*t2*u2*u2t**(-1)*
     +    t2t**(-1) + 32*(s+t2)**(-2)*t2**2*u2*u2t**(-1)*t2t**(-1) - 64
     +    *(s+t2)**(-1)*m1**2*s*u2t**(-1)*t2t**(-1) - 64*(s+t2)**(-1)*
     +    m1**2*t2*u2t**(-1)*t2t**(-1) + 64*(s+t2)**(-1)*m2**2*s*
     +    u2t**(-1)*t2t**(-1) + 64*(s+t2)**(-1)*m2**2*t2*u2t**(-1)*
     +    t2t**(-1) + 64*(s+t2)**(-1)*s*u2*u2t**(-1)*t2t**(-1) + 32*
     +    (s+t2)**(-1)*s*u2t**(-1) + 64*(s+t2)**(-1)*t2*u2*u2t**(-1)*
     +    t2t**(-1) + 32*(s+t2)**(-1)*t2*u2t**(-1) - 32*(s+t2)**(-1)*t2
     +    *t2t**(-1) + 64*(s+u2)**(-2)*m1**2*s*u2*u2t**(-1)*t2t**(-1)
     +     + 32*(s+u2)**(-2)*m1**2*s**2*u2t**(-1)*t2t**(-1) + 32*
     +    (s+u2)**(-2)*m1**2*u2**2*u2t**(-1)*t2t**(-1) - 64*
     +    (s+u2)**(-2)*m2**2*s*u2*u2t**(-1)*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Cf*Pi**3*alphas**2*
     + hardfac * (  - 32*(s+u2)**(-2)*m2**2*s**2*u2t**(-1)*t2t**(-1) - 
     +    32*(s+u2)**(-2)*m2**2*u2**2*u2t**(-1)*t2t**(-1) + 32*
     +    (s+u2)**(-2)*s*t2*u2*u2t**(-1)*t2t**(-1) + 32*(s+u2)**(-2)*s*
     +    u2*t2t**(-1) + 32*(s+u2)**(-2)*s*u2**2*u2t**(-1)*t2t**(-1) + 
     +    32*(s+u2)**(-2)*s**2*u2*u2t**(-1)*t2t**(-1) + 32*(s+u2)**(-2)
     +    *t2*u2**2*u2t**(-1)*t2t**(-1) + 32*(s+u2)**(-2)*u2**2*
     +    t2t**(-1) + 32*(s+u2)**(-1)*s*t2*u2t**(-1)*t2t**(-1) + 32*
     +    (s+u2)**(-1)*s*u2t**(-1) + 64*(s+u2)**(-1)*s*t2t**(-1) + 32*
     +    (s+u2)**(-1)*s**2*u2t**(-1)*t2t**(-1) + 64*(s+u2)**(-1)*t2*u2
     +    *u2t**(-1)*t2t**(-1) - 32*(s+u2)**(-1)*u2*u2t**(-1) + 96*
     +    (s+u2)**(-1)*u2*t2t**(-1) - 64*(s+u2)**(-1)*u2**2*u2t**(-1)*
     +    t2t**(-1) - 64*s**(-1)*t2*u2*u2t**(-1)*t2t**(-1) - 32*s**(-1)
     +    *t2*u2t**(-1) + 32*s**(-1)*t2*t2t**(-1) + 32*s**(-1)*t2**2*
     +    u2t**(-1)*t2t**(-1) + 32*s**(-1)*u2*u2t**(-1) - 32*s**(-1)*u2
     +    *t2t**(-1) )
      MM_qq_4 = MM_qq_4 + bb*(1+m12/s4)*(h_r2+h_l2)*Cf*Pi**3*alphas**2*
     + hardfac * ( 32*s**(-1)*u2**2*u2t**(-1)*t2t**(-1) - 32*s*
     +    u2t**(-1)*t2t**(-1) - 32*t2*u2t**(-1)*t2t**(-1) - 64*u2*
     +    u2t**(-1)*t2t**(-1) - 64*u2t**(-1) - 64*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + bq*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 32*(s+t2)**(-2)*m1**2*s*
     +    u2t**(-1) + 32*(s+t2)**(-2)*m1**2*t2*u2t**(-1) - 32*
     +    (s+t2)**(-2)*m2**2*s*u2t**(-1) - 32*(s+t2)**(-2)*m2**2*t2*
     +    u2t**(-1) + 32*(s+t2)**(-2)*t2 - 64*(s+t2)**(-1)*m1**2*m2**2*
     +    u2t**(-2) + 64*(s+t2)**(-1)*m1**2*s**(-1)*t2*u2t**(-1) + 64*
     +    (s+t2)**(-1)*m1**2*s*u2t**(-2) + 64*(s+t2)**(-1)*m1**2*t2*
     +    u2t**(-2) + 96*(s+t2)**(-1)*m1**2*u2t**(-1) + 64*(s+t2)**(-1)
     +    *m1**4*u2t**(-2) - 64*(s+t2)**(-1)*m2**2*s**(-1)*t2*u2t**(-1)
     +     - 64*(s+t2)**(-1)*m2**2*s*u2t**(-2) - 64*(s+t2)**(-1)*m2**2*
     +    t2*u2t**(-2) - 96*(s+t2)**(-1)*m2**2*u2t**(-1) + 32*
     +    (s+t2)**(-1)*s**(-1)*t2 + 64*(s+t2)**(-1)*t2*u2t**(-1) + 64*
     +    (s+t2)**(-1) + 256*m1**2*m2**2*s**(-1)*t2*u2t**(-3) + 256*
     +    m1**2*m2**2*s**(-1)*t2**2*u2t**(-4) + 128*m1**2*m2**2*s**(-1)
     +    *u2t**(-2) + 128*m1**2*m2**2*s*u2t**(-4) + 384*m1**2*m2**2*t2
     +    *u2t**(-4) )
      MM_qq_4 = MM_qq_4 + bq*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 128*m1**2*m2**2*u2t**(-3)
     +     - 128*m1**2*s**(-1)*t2*u2t**(-2) - 128*m1**2*s**(-1)*t2**2*
     +    u2t**(-3) - 128*m1**2*s**(-1)*u2t**(-1) - 128*m1**2*t2*
     +    u2t**(-3) - 64*m1**2*u2t**(-2) - 128*m1**4*s**(-1)*t2*
     +    u2t**(-3) - 128*m1**4*s**(-1)*t2**2*u2t**(-4) - 64*m1**4*
     +    s**(-1)*u2t**(-2) - 128*m1**4*t2*u2t**(-4) + 128*m2**2*
     +    s**(-1)*t2*u2t**(-2) + 128*m2**2*s**(-1)*t2**2*u2t**(-3) + 
     +    128*m2**2*s**(-1)*u2t**(-1) + 128*m2**2*t2*u2t**(-3) + 64*
     +    m2**2*u2t**(-2) - 128*m2**4*s**(-1)*t2*u2t**(-3) - 128*m2**4*
     +    s**(-1)*t2**2*u2t**(-4) - 64*m2**4*s**(-1)*u2t**(-2) - 128*
     +    m2**4*s*u2t**(-4) - 256*m2**4*t2*u2t**(-4) - 128*m2**4*
     +    u2t**(-3) - 64*s**(-1)*t2*u2t**(-1) - 64*s**(-1)*t2**2*
     +    u2t**(-2) - 64*s**(-1) )
      MM_qq_4 = MM_qq_4 + bq*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac * ( 32*(s+t2)**(-2)*m1**2*t2*u2t**(-1) - 32*
     +    (s+t2)**(-2)*m2**2*t2*u2t**(-1) - 32*(s+t2)**(-2)*t2*u2*
     +    u2t**(-1) + 32*(s+t2)**(-2)*t2 + 64*(s+t2)**(-1)*m1**2*s*
     +    u2t**(-2) + 64*(s+t2)**(-1)*m1**2*t2*u2t**(-2) + 64*
     +    (s+t2)**(-1)*m1**2*u2t**(-1) - 64*(s+t2)**(-1)*m2**2*s*
     +    u2t**(-2) - 64*(s+t2)**(-1)*m2**2*t2*u2t**(-2) - 64*
     +    (s+t2)**(-1)*m2**2*u2t**(-1) - 32*(s+t2)**(-1)*s**(-1)*t2 + 
     +    32*(s+t2)**(-1)*s*u2t**(-1) + 96*(s+t2)**(-1)*t2*u2t**(-1) - 
     +    64*(s+t2)**(-1)*u2*u2t**(-1) + 32*(s+t2)**(-1) - 64*m1**2*
     +    u2t**(-2) + 64*m2**2*u2t**(-2) - 64*s**(-1)*t2*u2t**(-1) - 64
     +    *s**(-1)*t2**2*u2t**(-2) + 32*s**(-1) - 32*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + qb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 32*(s+u2)**(-2)*m1**2*s*
     +    t2t**(-1) + 32*(s+u2)**(-2)*m1**2*u2*t2t**(-1) - 32*
     +    (s+u2)**(-2)*m2**2*s*t2t**(-1) - 32*(s+u2)**(-2)*m2**2*u2*
     +    t2t**(-1) + 32*(s+u2)**(-2)*u2 - 64*(s+u2)**(-1)*m1**2*m2**2*
     +    t2t**(-2) + 64*(s+u2)**(-1)*m1**2*s**(-1)*u2*t2t**(-1) + 64*
     +    (s+u2)**(-1)*m1**2*s*t2t**(-2) + 64*(s+u2)**(-1)*m1**2*u2*
     +    t2t**(-2) + 96*(s+u2)**(-1)*m1**2*t2t**(-1) + 64*(s+u2)**(-1)
     +    *m1**4*t2t**(-2) - 64*(s+u2)**(-1)*m2**2*s**(-1)*u2*t2t**(-1)
     +     - 64*(s+u2)**(-1)*m2**2*s*t2t**(-2) - 64*(s+u2)**(-1)*m2**2*
     +    u2*t2t**(-2) - 96*(s+u2)**(-1)*m2**2*t2t**(-1) + 32*
     +    (s+u2)**(-1)*s**(-1)*u2 + 64*(s+u2)**(-1)*u2*t2t**(-1) + 64*
     +    (s+u2)**(-1) + 256*m1**2*m2**2*s**(-1)*u2*t2t**(-3) + 256*
     +    m1**2*m2**2*s**(-1)*u2**2*t2t**(-4) + 128*m1**2*m2**2*s**(-1)
     +    *t2t**(-2) + 128*m1**2*m2**2*s*t2t**(-4) + 384*m1**2*m2**2*u2
     +    *t2t**(-4) )
      MM_qq_4 = MM_qq_4 + qb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac*(log_all-1.D0) * ( 128*m1**2*m2**2*t2t**(-3)
     +     - 128*m1**2*s**(-1)*u2*t2t**(-2) - 128*m1**2*s**(-1)*u2**2*
     +    t2t**(-3) - 128*m1**2*s**(-1)*t2t**(-1) - 128*m1**2*u2*
     +    t2t**(-3) - 64*m1**2*t2t**(-2) - 128*m1**4*s**(-1)*u2*
     +    t2t**(-3) - 128*m1**4*s**(-1)*u2**2*t2t**(-4) - 64*m1**4*
     +    s**(-1)*t2t**(-2) - 128*m1**4*u2*t2t**(-4) + 128*m2**2*
     +    s**(-1)*u2*t2t**(-2) + 128*m2**2*s**(-1)*u2**2*t2t**(-3) + 
     +    128*m2**2*s**(-1)*t2t**(-1) + 128*m2**2*u2*t2t**(-3) + 64*
     +    m2**2*t2t**(-2) - 128*m2**4*s**(-1)*u2*t2t**(-3) - 128*m2**4*
     +    s**(-1)*u2**2*t2t**(-4) - 64*m2**4*s**(-1)*t2t**(-2) - 128*
     +    m2**4*s*t2t**(-4) - 256*m2**4*u2*t2t**(-4) - 128*m2**4*
     +    t2t**(-3) - 64*s**(-1)*u2*t2t**(-1) - 64*s**(-1)*u2**2*
     +    t2t**(-2) - 64*s**(-1) )
      MM_qq_4 = MM_qq_4 + qb*(1+m12/s4)*(h_r2+h_l2)*Nc*Cf*Pi**3*
     + alphas**2*hardfac * (  - 32*(s+u2)**(-2)*s*u2*t2t**(-1) - 32*
     +    (s+u2)**(-2)*u2**2*t2t**(-1) + 64*(s+u2)**(-1)*m1**2*s*
     +    t2t**(-2) + 64*(s+u2)**(-1)*m1**2*u2*t2t**(-2) - 32*
     +    (s+u2)**(-1)*m1**2*t2t**(-1) - 64*(s+u2)**(-1)*m2**2*s*
     +    t2t**(-2) - 64*(s+u2)**(-1)*m2**2*u2*t2t**(-2) + 32*
     +    (s+u2)**(-1)*m2**2*t2t**(-1) - 32*(s+u2)**(-1)*s**(-1)*u2 + 
     +    32*(s+u2)**(-1)*t2*t2t**(-1) + 96*(s+u2)**(-1)*u2*t2t**(-1)
     +     - 64*(s+u2)**(-1) - 64*m1**2*t2t**(-2) + 64*m2**2*t2t**(-2)
     +     - 64*s**(-1)*u2*t2t**(-1) - 64*s**(-1)*u2**2*t2t**(-2) + 32*
     +    s**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(0,0,0,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*m1**2*u2t**(-2) - 16*m2**2*u2t**(-2) + 
     +    16*t2*t2t**(-2) - 16*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(0,0,0,0)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * (  - 32*m1**2*u2t**(-1)*t2t**(-1) + 32*u2*
     +    u2t**(-1)*t2t**(-1) - 32*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(0,0,0,0)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*m1**2*u2t**(-2) - 16*m2**2*u2t**(-2) )
      MM_qq_4 = MM_qq_4 + ANG_fin(0,0,0,0)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*t2*t2t**(-2) - 16*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,0,-2,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 64*m1**2*s*t2*u2t**(-2) + 32*m1**2*s**2*
     +    u2t**(-2) + 32*m1**2*t2**2*u2t**(-2) - 64*m2**2*s*t2*
     +    u2t**(-2) - 32*m2**2*s**2*u2t**(-2) - 32*m2**2*t2**2*
     +    u2t**(-2) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,0,-2,0)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 64*m1**2*s*t2*u2t**(-2) + 32*m1**2*s**2*
     +    u2t**(-2) + 32*m1**2*t2**2*u2t**(-2) - 64*m2**2*s*t2*
     +    u2t**(-2) - 32*m2**2*s**2*u2t**(-2) - 32*m2**2*t2**2*
     +    u2t**(-2) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,0,-1,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 48 - 32*m1**2*m2**2*u2t**(-2) + 32*
     +    m1**2*s*u2t**(-2) + 32*m1**2*t2*u2t**(-2) - 48*m1**2*
     +    u2t**(-1) + 32*m1**4*u2t**(-2) - 32*m2**2*s*u2t**(-2) - 32*
     +    m2**2*t2*u2t**(-2) + 48*m2**2*u2t**(-1) - 16*s*u2t**(-1) + 16
     +    *t2*u2t**(-1) + 64*u2*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,0,-1,0)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*m1**2*s*u2t**(-1)*t2t**(-1) + 16*m1**2*
     +    t2*u2t**(-1)*t2t**(-1) - 32*m2**2*s*u2t**(-1)*t2t**(-1) - 32*
     +    m2**2*t2*u2t**(-1)*t2t**(-1) - 32*s*u2*u2t**(-1)*t2t**(-1) - 
     +    16*s*u2t**(-1) - 32*t2*u2*u2t**(-1)*t2t**(-1) - 16*t2*
     +    u2t**(-1) + 16*t2*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,0,-1,0)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 48 - 32*m1**2*m2**2*u2t**(-2) + 32*
     +    m1**2*s*u2t**(-2) + 32*m1**2*t2*u2t**(-2) - 48*m1**2*
     +    u2t**(-1) + 32*m1**4*u2t**(-2) - 32*m2**2*s*u2t**(-2) - 32*
     +    m2**2*t2*u2t**(-2) + 48*m2**2*u2t**(-1) - 16*s*u2t**(-1) + 16
     +    *t2*u2t**(-1) + 64*u2*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,2,-1,-1)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*m1**2*s*t2*u2t**(-1)*t2t**(-1) + 16*
     +    m1**2*s*t2t**(-1) + 16*m1**2*s**2*u2t**(-1)*t2t**(-1) - 48*s*
     +    t2*u2*u2t**(-1)*t2t**(-1) - 32*s*t2*u2t**(-1) - 16*s*t2**2*
     +    u2t**(-1)*t2t**(-1) + 16*s*u2*u2t**(-1) - 48*s*u2*t2t**(-1)
     +     - 32*s - 32*s**2*t2*u2t**(-1)*t2t**(-1) - 16*s**2*u2*
     +    u2t**(-1)*t2t**(-1) - 16*s**2*u2t**(-1) - 32*s**2*t2t**(-1)
     +     - 16*s**3*u2t**(-1)*t2t**(-1) + 16*t2*u2*u2t**(-1) - 16*t2*
     +    u2*t2t**(-1) - 32*t2**2*u2*u2t**(-1)*t2t**(-1) - 16*t2**2*
     +    u2t**(-1) - 16*u2**2*t2t**(-1) - 32*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-2,-2)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s**2*t2 + 32*s**2*u2 - 32*s**2*s4 + 32
     +    *s**3 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-2,-2)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s**2*t2 + 32*s**2*u2 - 32*s**2*s4 + 32
     +    *s**3 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-2,-1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*t2*u2*u2t**(-1) - 64*s*t2 + 64*s**2*
     +    u2*u2t**(-1) - 64*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-2,-1)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*t2*u2*u2t**(-1) - 64*s*t2 + 64*s**2*
     +    u2*u2t**(-1) - 64*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-1,-2)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s*t2 + 32*s*u2 - 32*s*s4 + 32*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-1,-2)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * (  - 32*s*t2 - 32*s*u2 + 32*s*s4 - 32*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-1,-2)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s*t2 + 32*s*u2 - 32*s*s4 + 32*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-1,-1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*u2*u2t**(-1) - 80*s + 32*t2*u2*
     +    u2t**(-1) - 16*t2 + 32*t2**2*u2t**(-1) - 32*u2 + 32*u2**2*
     +    u2t**(-1) + 16*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-1,-1)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * (  - 32*m1**2*s*t2t**(-1) - 32*s*u2*
     +    u2t**(-1) - 32*t2*u2*u2t**(-1) + 16*t2**2*t2t**(-1) + 16*
     +    u2**2*t2t**(-1) + 32*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,5,-1,-1)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*u2*u2t**(-1) - 80*s + 32*t2*u2*
     +    u2t**(-1) - 16*t2 + 32*t2**2*u2t**(-1) - 32*u2 + 32*u2**2*
     +    u2t**(-1) + 16*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,6,-1,1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,6,-1,1)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*s*u2t**(-1)*t2t**(-1) + 16*t2*u2t**(-1)
     +    *t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,6,-1,1)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,7,-1,1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,7,-1,1)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*s*u2t**(-1)*t2t**(-1) + 16*t2*u2t**(-1)
     +    *t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(1,7,-1,1)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,0,-2,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 64*s*t2*u2*t2t**(-2) - 64*s*u2*t2t**(-1)
     +     + 32*s**2*t2*t2t**(-2) - 32*s**2*t2t**(-1) + 32*t2*u2**2*
     +    t2t**(-2) - 32*u2**2*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,0,-2,0)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 64*s*t2*u2*t2t**(-2) - 64*s*u2*t2t**(-1)
     +     + 32*s**2*t2*t2t**(-2) - 32*s**2*t2t**(-1) + 32*t2*u2**2*
     +    t2t**(-2) - 32*u2**2*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,0,-1,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 32*m1**2*t2*t2t**(-2) - 32*m1**2*t2t**(-1)
     +     + 32*s*t2*t2t**(-2) - 32*s*t2t**(-1) + 32*t2*u2*t2t**(-2) + 
     +    16*t2*t2t**(-1) - 16*u2*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,0,-1,0)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*m1**2*s*u2t**(-1)*t2t**(-1) - 16*
     +    m1**2*u2*u2t**(-1)*t2t**(-1) - 16*s*t2*u2t**(-1)*t2t**(-1) - 
     +    16*s*u2t**(-1) - 32*s*t2t**(-1) - 16*s**2*u2t**(-1)*t2t**(-1)
     +     - 32*t2*u2*u2t**(-1)*t2t**(-1) + 16*u2*u2t**(-1) - 48*u2*
     +    t2t**(-1) + 32*u2**2*u2t**(-1)*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,0,-1,0)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 32*m1**2*t2*t2t**(-2) - 32*m1**2*t2t**(-1)
     +     + 32*s*t2*t2t**(-2) - 32*s*t2t**(-1) + 32*t2*u2*t2t**(-2) + 
     +    16*t2*t2t**(-1) - 16*u2*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-2,-2)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s**2*t2 + 32*s**2*u2 - 32*s**2*s4 + 32
     +    *s**3 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-2,-2)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s**2*t2 + 32*s**2*u2 - 32*s**2*s4 + 32
     +    *s**3 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-2,-1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*t2*u2*t2t**(-1) - 64*s*u2 + 64*s**2*
     +    t2*t2t**(-1) - 64*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-2,-1)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*t2*u2*t2t**(-1) - 64*s*u2 + 64*s**2*
     +    t2*t2t**(-1) - 64*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-1,-2)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s*t2 + 32*s*u2 - 32*s*s4 + 32*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-1,-2)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * (  - 32*s*t2 - 32*s*u2 + 32*s*s4 - 32*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-1,-2)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 32*s*t2 + 32*s*u2 - 32*s*s4 + 32*s**2 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-1,-1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*t2*t2t**(-1) - 80*s + 32*t2*u2*
     +    t2t**(-1) - 32*t2 + 32*t2**2*t2t**(-1) - 16*u2 + 32*u2**2*
     +    t2t**(-1) + 16*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-1,-1)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * (  - 32*m1**2*s*u2t**(-1) - 32*s*t2*
     +    t2t**(-1) - 32*t2*u2*t2t**(-1) + 16*t2**2*u2t**(-1) + 16*
     +    u2**2*u2t**(-1) + 32*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,5,-1,-1)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2
     + *alphas**2*hardfac * ( 64*s*t2*t2t**(-1) - 80*s + 32*t2*u2*
     +    t2t**(-1) - 32*t2 + 32*t2**2*t2t**(-1) - 16*u2 + 32*u2**2*
     +    t2t**(-1) + 16*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,8,-1,1)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,8,-1,1)*bb*(h_r2+h_l2)*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*s*u2t**(-1)*t2t**(-1) + 16*u2*u2t**(-1)
     +    *t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(2,8,-1,1)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * (  - 16*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(5,0,-2,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 32*s + 32*t2 + 32*u2 - 32*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(5,0,-2,0)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*s + 16*t2 + 16*u2 - 16*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(5,0,-2,0)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 16*s + 16*t2 + 16*u2 - 16*s4 )
      MM_qq_4 = MM_qq_4 + ANG_fin(5,0,-1,0)*bb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 32*m1**2*u2t**(-1) + 32*m1**2*t2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(5,0,-1,0)*bq*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 32*m1**2*u2t**(-1) )
      MM_qq_4 = MM_qq_4 + ANG_fin(5,0,-1,0)*qb*(h_r2+h_l2)*Nc*Cf*Pi**2*
     + alphas**2*hardfac * ( 32*m1**2*t2t**(-1) )

c               the phase space except for 1/s**2 
      HT_QQH = MM_qq_4 / ( 16.D0 * pi**2 )**2 / 2.D0 * s4/(s4+m1**2)

c               the averaging factors
      HT_QQH = HT_QQH /4.D0 /Nc**2

      return
      end