Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795381365;
	b=gyS7yzDbN5meNJtQOBNrHL9OUTzYPmUckksc3NehZqOw9GeFYVoyGy1ZFg1clx/h7g7h
	 QPMsYYxoCsPBb8BDfU5A052uZmiSgYFG/LHLhSCkZrHA1rT9f58iwpSbczopP3Cq9+HG6
	 NFThwrITQARU4qhtKhFtzTRz03pEyHqSbmovTTxCm+lfpMo3F5/BlFpM6NaDL9LqM4UHO
	 v4e2yT6JG4/zL1K2o5BTUzUmZYJPYXtI9QG6i4ZLDQnWq8pdXRrj6o9Ehc6+J6gp3yo7Z
	 wg9pBACRPJ4X6NeU5Qxc7HRTIfNnQzht5dxw9MeTqZp6ZqdgUFVr2A4RJRtlIoCXhFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
	b=0odj4B2PoE5IDTo3N3UWFByU2SMygQVqW4nPpYdTq4CMSIY6mv8AdX6OW7kyopFVeqQZ
	 YeCfeGP63yCjJB/pMbFPVyw6bDbNXG/rfufDG/mqd2BS/pUL2ZJjjr2ZxgrlAtgGWnevx
	 Ojcj0a7CFIKHrmLOk1Y78YjVtvNuxMq6W+ZlulcEfm+mv0SInnkulGn3uhwMaKsLFaPRO
	 DspD5E+/gRTldazc4696woU4DjSxkW01/F928sNG2V5wBeHPamFOM6k5VTQaNEQyHxOMv
	 5pwu594doxFmaKk03cYQ5zYGWlddnAuhm6asUbYSSSu4qz28dG3mCeQYZgJsQW833Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zlsBYq18;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87163606A327
	for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 21:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87163606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zlsBYq18
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso1209708a91.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 13:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795381364; cv=none;
        d=google.com; s=arc-20260327;
        b=R87PuyxIQZjQfu8/xl+oCdU/NSr+3DOUKCVtwbrAFDgeNu+fC/bjbmxVFiu/SmvE9V
         WvAeBSoh3Dy7WFNEuIMNQKk/49Hg2+DJxYJ0nmLRu4XCD9PYGBILk6KePa5wnHYBMstQ
         4zMeyXE0eiqhEbHMhIuxUgFw1Y3BxwfXMacp1JWzzzM+ogCRMqxbk3pVxFXTXTA46jVm
         KIrXv1/jh/3PrTE2kYH2QraAlERzE623q+LIyTITz9bMjfIcHyz7IgPcm0fX0PJtMf+b
         IdFSRoIndy/lD+dtSwoNlTa6CuKy2ElR9J0GDgk3uVNPl262Ysk50wt8vCgDojtuw+ru
         hJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
        fh=9ePwhvbvCZio2XfnEmZlM0jhe3hfh8dLRKfkPMwZOmU=;
        b=OEcc306AHTMxbS+vCgGCFPJHsPTfS+2Nal9lzc9Whc/8K2aYGkIrvmEwUwS2Zfm8cZ
         UnfX96Aflr3MIFP0j+eKYd7+W///b7CDe80P0o1uZYGRf9uchGISQo3M0bXGrByUe0G1
         tfeNkDS/sQuELw0+Vm1Vvt2XLVMZEr9erBLfsruKVdddv7A1CYFjn75Ig9pwXBO43T9G
         oNo41sJHHmQyM6jeDSGbsQ/aLewSs2NGSq4eLQUgdecHHdobHbfnu7556Ys8QOdUrLoD
         lyhAFOVfrRibrvz8vXbE76NGtoqioqCanZqZp/85Cpo5wNnEJd4lCDIQeg7bTi7WAt9i
         Zs/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795381364; x=1795986164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
        b=zlsBYq183P2jR915rVTxFxauPzMtvP/3QFSR94XstIUIk1+DQECZlj7+o2TCBTwO4Q
         OQ+ry/tgUEUfXH7JkwtfbQgmYmGWP+sWmdEcSi47N1Tf9NGyLKDKI6NiEk/Q7/eG18UF
         uovr7R4wYDgZC5HeOyVSSh6XTUW0oK4TTmdRi7p+bx2HychGJFIz3H99RjLd9/MX+YGH
         rOayRZIQj3i7bi+YFqt16rsfPngcVCvVhFZEC5s1UY/sU+1MrNWV3E2DSk8yo4uV3N8H
         EZug8sN4NQE4GBGoBtLRyflLwIrBc9/DDBx4x9SO7ZWe54jl2xq3Ob7I70FvrohJNZdU
         dkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795381364; x=1795986164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
        b=1vh/wzWfvVs93gzGaI/aWKwmB+Men3Zu9NUWZNfgW2HhKF5rVkaDtfFdlOTfTUNqKx
         eB2yuL/7HdZgNr82AKdw8qPe75Dh/JxyXPWTRt+e8f/UZ2wBy3ecwyMpksc1WnEnSG2e
         yiRO+FWjV+T+TcO349bdK1nHNiRR4jKS2g4VWrWBUmR9AZPLopGevuXWLwH6wtzfqgOk
         isj/yrYWSV7S+qm4su5JnaI5IxMJzUJwJNZICg1rZuUDSbJw59Yw6T1TLuKj4jMwD4VQ
         xlGQ10wMmpgxgi3wLnR7ArMZDuG/IZCspUDwkcGkBJbvRpVjFo0hg5OHBWftbBiqmM3e
         GGHA==
X-Forwarded-Encrypted: i=1; AL+hErH33WuKtCBG8alIlsZs3AYOdedRGNhJNxDYpI3m5LcxMxlf3p1T2TBbcZQuuxueBeNoSn4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8OMivbRDZpNagy1By3LmJ7v46XLU859KxJkyIS6CsLcEp2eSNf
	FuQdq5Q3uEybnW3mmRsIRREWlLdV75fzpRnrSn5qYr0SH6Vb13xx3Ixj+0AfhbMC5HdmZwa51qr
	q+4OTgiSYIbOHCBUXQZVZsPAOlatErEs=
X-Gm-Gg: AZFdTZe71cmuFi+SCZMzXIXm+0vSuxgI355J6BKBjY3/voPM8WnWKyzMsKUYuiJ+tIP
	qYuezXKfu5SShIUDtXF9fpm6RtGfy0FENfq64onr/zHO/nYpHe0OFeynU9d1o+0LjPLeWoQurG+
	R9syFj9cvVuRpEjkkY3HUgdz/p4YAkbAUV8dxb6YBo19IfsIMPKWIj2F8I51+AMLW8QLtdse5CB
	2RNVcvyNoCiUkYGgxPO7ETna4L1XqR47eCjgYq4Ke4gfEajfJRN5j23Dfqwn06h4Da5e+BEOi2n
	/mGOwPbpSc49VmVbYEDhzNZ+jjizWdUK86WuvevvIKRUV68Bbm7rABAz8/2bu9qKPjydJWyk5HI
	6nNzxp2XcmoAn0FsM4lsOWLTHDiRoBwRFHkeUKnDGD0ic5Gxc6D7KkReGCFpIos4hHN0X0Q==
X-Received: by 2002:a17:90b:554e:b0:3ac:860e:1af9 with SMTP id
 98e67ed59e1d1-3b41c981a67mr6077104a91.41.1795381363876; Sun, 22 Nov 2026
 13:02:43 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de> <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
In-Reply-To: <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 22 Nov 2026 13:02:31 -0800
X-Gm-Features: Aa3M54oHW1FHI6GaA1OK0id-oEs8UcKMQfeywYsbJpKdYciL2E1UJ9KIq7wOQ5I
Message-ID: <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>, 
	stable@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 12:20=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> w=
rote:
>
> On Sun, Nov 22, 2026 at 10:01=E2=80=AFAM Nicolai Buchwitz <nb@tipi-net.de=
> wrote:
> >
> > Hi Anandu
> >
> > On 20.11.2026 08:49, Anandu Padinhare wrote:
> >
> > > [...]
> >
> > > @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_stru=
ct
> > > *napi, int budget)
> > >       u64_stats_update_end(&rxq_stats->napi_syncp);
> > >
> > >       work_done =3D stmmac_rx(priv, budget, chan);
> > > +     if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> > > +             stmmac_rx_refill_timer_arm(ch);
> >
> > After a successful retry, doesn't this leave the last received frame in
> > the ring until the next RX irq? Could the poll refill first?
>
> Do you mean "first as well" or "first instead"? Because "instead" can
> cause avoidable packet loss:
> 1) Initially, network is idle and ring is full of empty DMA buffers
> 2) A burst of exactly one ring's worth of packets arrives
> 3) The RX irq fires and stmmac_rx() attempts its refill-first (none
> needed) then depletes the ring to the maximally-dirty state; the
> refill timer is armed

Thinking about it more: the "unreachable packet" problem happens at
this point too, even with the "first as well" behavior.

Maybe the best way to resolve it is to adopt stmmac_rx_zc()'s behavior
of refilling during the loop?

> 4) During the 10ms timer period, more traffic arrives
> 5) The RX irq doesn't fire again because no additional DMA is
> happening: there are no usable buffers in the ring. So we're forced to
> wait out the timer.
> 6) Any packets during this time (beyond the RxFIFO's capacity) are
> discarded by the hardware
>
> But, "first as well" sounds good to me: before entering the main loop,
> refill 1 buffer (if possible) just to ensure either the IRQ fires
> again immediately (if the FIFO is holding onto another packet for us),
> or the inaccessible ring slot is clean (if the FIFO is empty).
>
> Cheers,
> Sam
>
> >
> > > [...]
> >
> > Regards,
> > Nicolai
