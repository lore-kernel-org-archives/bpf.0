Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614F4370AF3
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781206718; cv=pass; b=Q5U6p5+kjM2KorH7tO36J6sR+aG2lBsXEn6R6RskdZbuLrzKm0Owd7SOTCNjMJPmV4rT5hxgorTuLq4KIuLFfTfqVJkC5Pk4ldXDI2QbQHvr+IaYV5bF30Dg8x7CCxalJFesemlrutjOHe50Z7loJdokBSN8pNX/qN8pAUKKMlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781206718; c=relaxed/simple;
	bh=TXQ9Q0AXLMcsu6soSrnyJebo3jB+Q8dJl2t6DbRHBEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJlwJP/kczDUccC6Q++2YS0jZi+0X4RmzFWPeFncsqnTcveGsAaU6hTM+Pad5urGl9dJYyMqtFd+S+8rZnUlqLD71YCj1zvuYYJnjwU/Lv2sHJx3DcQzqJOMUqWpNp4UDJ5jsS3voIC2Cm+Ns9FXOvHBjup7WetLCD9RUyj5OqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqopTY5s; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqopTY5s"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5177945a279so1793591cf.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781206714; cv=none;
        d=google.com; s=arc-20240605;
        b=ir3G7vjMM3C+XH0kXI2GgWApIsBlhy0aQcQCBUv030j2epalyt7jE625MdaPe7M1I7
         V5CGTPNO31dHdXFSRniBcoLzvtXhBIwSTi8xqZAQq1sFkxP0RvpT2NDxuCFmrBviyIiv
         BOMoJjQxOkV6sSqwU0jJgoUnTsrQAOXx3jIfNTtnqReJLe10yRfK4TK0jd6briAbK4Ot
         zlQkLRp52Gs39k7ChjCcEjcOosPKU4nnaIeFSz2mLoCy50UBGJv3gt+dS5Cov82E/vKL
         Z3STx1oUJnijk4Kt7ML/DC8E0M028MtsQTnCe1rXB6ZTSflkRCfkPL7fOxnztQpyPQTW
         mNkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xCB9Yx4jM3FP2NFVOcL/EBwC0kyy5VsznsqCTvi1d1Q=;
        fh=eMBE40Rj9MJNCKpOHDCUPc2kK80qUp1LRRyJXJuZnx0=;
        b=bzG/nYEyp7U7U2sr4FAnkY85XNh+PFyZEu0Gu7Z/4CJPP70mon5XOB5JbUu76L6MuP
         swsaNQhi0TtJHhcZXFzk2NgP6ESFYLnK8DiGG306WdmJDky6oo0cU8nPWXKpEU7lcW0D
         9kJKsb8D7LVEkMuIaAjXZKiYeSlMir+Ek23M2NFIGJudI3vkm53eF70FE2khz4slzbbB
         qeOezOIaF56ywrlQzSewnQE5bogd3aM9qdawGcS9xCnIf56cebDiXURpGI4Bvcv1lcG9
         zY5ZIVjoqeZFT34MIyYKd7E+BxYarFn8bmBHVxJLU37Lw4KHUzO2DiqQ0PUtXfcMOweS
         5egw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781206714; x=1781811514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCB9Yx4jM3FP2NFVOcL/EBwC0kyy5VsznsqCTvi1d1Q=;
        b=cqopTY5s4/LoZ05b/FMCPc/72A2AL17OqMzbZhp9MR+abJMjqTTdmKMl3YbkFQySeU
         6tVMISJVFRFqR+hH1irpos/8NVaTETC3oFho3KUkUKSsxNR4P5bKdpwWnZbHMR6UB6R0
         Mjk5P6KgfwKhn1riMAgGshH1AVsWCr3TskyAUHoVOzztdBqeFLPfXlQox3dm9WsbABRK
         mrEC/6IMmGA6bOEUeaGLMlFVwu1+LGPstpWxxJXt7w8bIWOmAg8wtE0t9DeyGOrnefzF
         uwYiI4+SmMWFZ55WFDzr/os7k+9yJKot68H0JC3bl1UCKwlsYhRqs169I4G9KmeGgezd
         qZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781206714; x=1781811514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xCB9Yx4jM3FP2NFVOcL/EBwC0kyy5VsznsqCTvi1d1Q=;
        b=j33BbmOoylb1YQ3uD1O9wt2hzkbbkbdoOtGShWpu8q4x+fz5RK2+rh+jY2Fvi++znt
         EyTqGaV1mimk9fHytpbbX/jTliB4qRwskGPmMVx7RHcG+Y8eEpC7BHHUHzSYnq4aaxaV
         J6pqBJ4kLTxHDNH/ibPZkD5okAqUV89W0qxOQsJu6y6iyLB8UooyS0YVmVH7JAiuayzT
         pylLAifuqLTNl32Ffy8VMtjuLzuK0iNgh45mCdvAC0ap91A8WQ93bz/TEyVUuIvXgwd7
         dkn7UaT7ebiJsuAKOr0Wi1OhTRP6R8vw5Pj+nnIbQ1CdHaR6/cjEMulGVRvy8Sq0ptpn
         Ofdw==
X-Forwarded-Encrypted: i=1; AFNElJ+h+rBKZ3D/ZZtW0cJNojrJXYi672LMvVwE/sO1Qt87rOWOOcuyoTpDtQq0m3CpM6Z3Cr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUTdy7m7xXBzigWFfuZC1JNSaUiSg8ClSXYuz9qwxxle4XWj5I
	bNIU7ZqDSqaZFrCMwThUBLHeyorkhz6ke3b9yjVmrQCo5dAMgTFymgQkMye4zXO8HYi0S0+0Ow/
	r4CzAffG2g9g9T4h0ujSVN0cjDqx0FqOoSsMXV9LozO5ViFI8LB5fPix+
X-Gm-Gg: Acq92OG3XIc+DzC0MKfxLjZJ9N92KWLo0i+j14CG0VI5AaeQTYcrtqXkXFRtvF/JRGe
	6CMcnUoCD2QUiq81RANocFRWUf0gqD0gsm4XljarrJrE3xbF6ZLqwOm6T8BRwd0ij1dHCVTVnhh
	zH/BsESQFI4wEVdFFjODBYOPTFLn7UW7Oqt6iUf9Ur5i/9Ge42pEHvzdMzuhjtu1t+MGmVXngc5
	pUTGsHL4si7j6Ggh8nJdR9ad4S2uCy/fS8FceLuPXPb7GcD4m6NrymTuJJXF4NOwf8OGFLCrDn1
	vPykSDUgvst3jfopY1D63IeaZxD4IKv2ga55Ne7LSR/xczcB7Lg1mworiKH84wBHpeQgScpSTW2
	xmA5FTKLfVCxc8tgm6YY=
X-Received: by 2002:a05:622a:1ba9:b0:517:96f0:5663 with SMTP id
 d75a77b69052e-517ee1c3dfamr60249151cf.36.1781206713473; Thu, 11 Jun 2026
 12:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611161504.228319-1-chia-yu.chang@nokia-bell-labs.com>
 <20260611161504.228319-4-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKkPJqOM=0KV8O8=2zWrZObj+E+VJoLztp4sUi7Vj0aQg@mail.gmail.com>
 <CADVnQyk+sOAKU_WtPja7_hgiXw8he9U1g6AY7iEm5q3F3R-Hag@mail.gmail.com> <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984D14DA66C0E4B89BA1D4BA31B2@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 12:38:21 -0700
X-Gm-Features: AVVi8CdU_EG-yCXFA-WFp-6T8-9IGsEt-wVTqw-kDS_eUrm1C9Lm6n8n5lfLMZY
Message-ID: <CANn89i+dS_h8_FH9KdO4NPu46VSi3uFZ3yGnA6AKD1UzMzySKg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback for TCP Prague
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: Neal Cardwell <ncardwell@google.com>, "horms@kernel.org" <horms@kernel.org>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:33=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Neal Cardwell <ncardwell@google.com>
> > Sent: Thursday, June 11, 2026 9:27 PM
> > To: Eric Dumazet <edumazet@google.com>
> > Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; horms@ke=
rnel.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vger.kernel.org; =
pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumbe=
r.org; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com;=
 kuniyu@google.com; ij@kernel.org; Koen De Schepper (Nokia) <koen.de_schepp=
er@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsso=
n.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; J=
ason_Livingood@comcast.com; vidhi_goel@apple.com
> > Subject: Re: [PATCH v1 net-next 3/4] tcp: Add tso_segs() CC callback fo=
r TCP Prague
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > On Thu, Jun 11, 2026 at 1:01=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Jun 11, 2026 at 9:15=E2=80=AFAM <chia-yu.chang@nokia-bell-lab=
s.com> wrote:
> > > >
> > > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > >
> > > > This patch adds tso_segs() CC callbak for CC algorithm to provides
> > > > explicit tso segment number of each data burst and overrides
> > > > tcp_tso_autosize().
> > > >
> > > > No functional change.
> > > >
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > > ---
> > > >  include/net/tcp.h     | 3 +++
> > > >  net/ipv4/tcp_output.c | 4 +++-
> > > >  2 files changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h index
> > > > e8090f542f7c..3b415c9dcc54 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -1366,6 +1366,9 @@ struct tcp_congestion_ops {
> > > >         /* override sysctl_tcp_min_tso_segs (optional) */
> > > >         u32 (*min_tso_segs)(struct sock *sk);
> > > >
> > > > +       /* override tcp_tso_autosize */
> > > > +       u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> > > > +
> > > >         /* new value of cwnd after loss (required) */
> > > >         u32  (*undo_cwnd)(struct sock *sk);
> > > >         /* returns the multiplier used in tcp_sndbuf_expand
> > > > (optional) */ diff --git a/net/ipv4/tcp_output.c
> > > > b/net/ipv4/tcp_output.c index fe725d94a225..a7206fa61957 100644
> > > > --- a/net/ipv4/tcp_output.c
> > > > +++ b/net/ipv4/tcp_output.c
> > > > @@ -2274,7 +2274,9 @@ static u32 tcp_tso_segs(struct sock *sk, unsi=
gned int mss_now)
> > > >                         ca_ops->min_tso_segs(sk) :
> > > >
> > > > READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> > > >
> > > > -       tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> > > > +       tso_segs =3D ca_ops->tso_segs ?
> > > > +                       ca_ops->tso_segs(sk, mss_now) :
> > > > +                       tcp_tso_autosize(sk, mss_now, min_tso);
> > > >         return min_t(u32, tso_segs, sk->sk_gso_max_segs);  }
> > >
> > > Can you explain why min_tso_segs() is not enough?
> > >
> > > We do not need two different mechanisms.
> >
> > I'm pretty sure this was proposed to meet Prague's goal of having TSO b=
ursts be sized to be at most 250 usec worth packets, rather than the defaul=
t Linux TCP TSO autosizing approach of 1ms worth of packets:
> >
> > https://datatracker.ietf.org/doc/html/draft-briscoe-iccrg-prague-conges=
tion-control-04#name-segmentation-offload
> >
> > Where "MAX_BURST_DELAY" is defined as "Maximum allowed bottleneck queui=
ng delay due to segmentation offload bursts [s] (default 0.25 ms for the pu=
blic Internet)".
> >
> > AFAICT this proposed patch is no longer needed now that
> > tcp_tso_autosize() uses a parameterized approach for :
> >
> >    bytes =3D READ_ONCE(sk->sk_pacing_rate) >> READ_ONCE(sk->sk_pacing_s=
hift);
> >
> > AFAICT tcp_prague can simply set sk->sk_pacing_shift to be 12 for its p=
urposes, looking at:
> >
> >    https://github.com/L4STeam/linux/blob/8ac01b97ffd993b1fed93a015ec30d=
d085857e8b/net/ipv4/tcp_prague.c#L144
> >
> >    static u32 prague_burst_shift __read_mostly =3D 12; /* 1/2^12 sec ~=
=3D.25ms */
> >
> > Then probably this patch is not needed.
> >
> > neal
>
> Hi Neal and Eric,
>
> IMO, we still need Prague to maintain its pacing rate, because AFAIK tcp_=
tso_autosize also based on min_rtt to decide the bytes to fill in.
> And it tends to create large packets when min_RTT is very small via `byte=
s +=3D sk->sk_gso_max_size >> min_rtt;`
>
> While, in TCP Prague, we do not bsaed on min_rtt to further enlarge TSO s=
ize.

You will have to remove min_tso_segs() and replace it with tso_segs()
which seems enough (stronger)
