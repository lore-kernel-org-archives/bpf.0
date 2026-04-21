Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849EF79CD
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729712; cv=pass; b=HTUUbinm7CMI3s7jpJrOwm0D977oUAN3pbncBcnc2GX9bN4e3U3+iKxkLn+IuXjasBdt2X4wdAG4gfZrzXCIu+g29xttsj+imXm0JJwLM+fVTSgJ5uFuOaBTT1fm9Ma8ORv31P2sYPNe4WmO/Z/gOnhmUpXIzeX3JtPc3kXBkp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729712; c=relaxed/simple;
	bh=QpWJKareNO5H98YyLb0quk17q7qr2NRU4LvzMmwho5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq804SQWNEOLmNwCojpuVI28dwovBgR2vtII0mpx6vznNPSyeUYaT+PeGMw4MZqejOVjvSpGOiRzbwLZIX1WyTN0CbN2l4+F0ZnyNVQylA+nne/Y5jyrh1T5GlT9Zj2rgHgDG0bdL5dWhJ1bMz+DEr1KWhQYt+kWaNoFBXWnl3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P00mYAWS; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P00mYAWS"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so3610431e87.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776729708; cv=none;
        d=google.com; s=arc-20240605;
        b=PFk/kOEQI8/YO3wa0AKxbx1FOXGQop7cCdii5DhFTYrST+VL2Dc4ZPJuYmZcvsBb1+
         n8s43i4/9+b0/QidBrLwXtYzeTVDaQ+tpNwrh7VfWAAHej13dICeVJt3pVj21PMTsPKT
         1EcNBRDKz7vlRmUT+oFvuCil6+UZlisqqgx8tZnHuAFXKmeYrunBrRJZ+qlbbdntsxnn
         9AfTnw2vixrHmYc/6HzbELnjxdUroeqgHgWasNGAuJ1sufCMAX5wgciDU41iIK+iHbDV
         AsvHqymuNB1dg0+BIz6wFNrSkuTA/+7AihX8kE8e3skuvU/Gz52aDGERRLfuYmsvF2dp
         YHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GwqYBk6NXXSPHGyD5sybR1eylulA18+2Dt3czptKcJA=;
        fh=ufUKeSpCrM7UZhECS00Uov6qBYdMktaAxuA3HGXOKqc=;
        b=JwsDevkcgCKovugAYEpqgassL1oCN5TA2h9HB2As0tCE1jmCpm37Wm/hPEOJ+uf8kS
         DvSCibOLSGnb3GD8YEjmleqPVOVFuoRoIPUQxeOtBWvpyHvQO+C/Q32ce8a2VIUFZzZD
         su3rBUG17uA3HJLS02pRegDP2eXGW38qGLXWPJl1iSBBxoex98a9QjZs7pOVdcZ/TtRh
         O+lzIoDju5DPfnI0Zq16JI1OYsH8UEXnv/8apiPvLUoz/PECz/PGlru0htVDa8guAOs1
         whwbCN+E4vwUEsSIbQxpR5xCuyeKgZTR5uY7fXA+O1k+EZ8oY22AiygpellPnyMwQj85
         HkNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776729708; x=1777334508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwqYBk6NXXSPHGyD5sybR1eylulA18+2Dt3czptKcJA=;
        b=P00mYAWSCW7EzwgWm5Bvbso8+LU+ieLtpFMc4+WjMpkLCfbmCWlRoKmkIFRT9uuu1L
         9MG1OP/0HVH6HzzEClC+qpZIz5Uz5+nH/bxW27IynDJR53kWJsDkSpLC6m9KkhhtJaub
         d5/Tn9e2wZ1JT5DD553cMkH8Q10g3SlFpie8CBLXccs6o4JlOk5Yz6aZCbdQ8AUO+KPZ
         0MnXpmW54N6uaEnv8qBhyAPmtbN9YhQCy0Cn2u3jgePJvpwCokBLDEWMDLcFdUI0dK5B
         j9PZbqtsHlIcP+6NBGXxorlWfnDLHKBBN4ZcDSl8skPAdF08MaBHBZS9rNO5bYLF2e88
         y6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729708; x=1777334508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwqYBk6NXXSPHGyD5sybR1eylulA18+2Dt3czptKcJA=;
        b=J7Wv2JoLSTJS0WGmzOY7Ub/g3DmITBZpox2TQjeNn6MKWanUAL0ke2YeW5LJeCviWg
         klqgDmtBUzccwZUUaoLOYRp3wqbrRF68p4qCq1/WWf01A7fsbI2VC8/4+f0mj/pyWMEj
         VuHexx0AYpRthuo+nIqtXZfYP7NH/zID/21wu814AmyLnOVLIkfsNpazuzb0zGXXJOsg
         FKgm9Irk9HxFZ5vVFJDJORyscoJdBtFYTSWv8iwwvCArKZtxXnYnQbcsktC1kTpkcVCd
         Bh6F1DRn0lEL355DMqE7DOmRDxcP/+8Vu2Yh+HTnkHJudaZCnfclVHC0DQx0T9/D/f2x
         eG+Q==
X-Gm-Message-State: AOJu0YyBo43haMsifH0mFV0FR5qFk9AOSaeeeox9vZ1XYhMJFk9974BG
	75yVPJR9E7Qt5bmPojES1dQI6PCvu08+G6H5I2I6WEKgh/xqoDSCT1Mq4fEU0ebdvFKd67Y+Jf5
	FLfViTR+f5XkiRBc+xJT9fnJdrB2OLUM=
X-Gm-Gg: AeBDieuoxr4lasP7TNIycE2LZaSIDsjzvsVg7tULM31vl4rS8vE+ucmSCEUlzlalz/L
	rl8+qr/NMq6hYqmungALHtXFRG3XV50/au/8T80NKHnorN2br4qGfoHFmhFVaRaGS47f38KFMAB
	hXxYXe2n7aeo8cvxg5PTJ/v3bJzj+QruX9qCoaBFNQMYDve6CyGCUlQVVcnUzNAtypa2UDnncCm
	MhUeNeQKXZhFQ0t+aPImTacq7TgnmQMu24R3ij1uf04kQVrJqZPl0UMx6pEyAUUCpaUYr6rSA1C
	RunwXSYaC26BIcTWGQdqyQyuE9jN
X-Received: by 2002:a05:6512:39c8:b0:5a2:babe:3da0 with SMTP id
 2adb3069b0e04-5a4172ba72emr4754212e87.9.1776729708289; Mon, 20 Apr 2026
 17:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-4-kerneljasonxing@gmail.com> <eef5d62d475b0aeb93f6f84585f36972.sdf.kernel@gmail.com>
In-Reply-To: <eef5d62d475b0aeb93f6f84585f36972.sdf.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:01:08 +0800
X-Gm-Features: AQROBzAmCeHn5V3FByry0y6t-4lLb9mei_UE75lqdN7bsNqPuXgNHUB8tIgfdyo
Message-ID: <CAL+tcoCFiTsze+bb7V8XwX-ELSwnG8h6errtoJMB3MY9-HKSuA@mail.gmail.com>
Subject: Re: [PATCH net v2 3/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 3:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When xsk_build_skb() processes multi-buffer packets in copy mode, the
> > first descriptor stores data into the skb linear area without adding
> > any frags, so nr_frags stays at 0. The caller then sets xs->skb =3D skb
> > to accumulate subsequent descriptors.
> >
> > If a continuation descriptor fails (e.g. alloc_page returns NULL with
> > -EAGAIN), we jump to free_err where the condition:
> >
> >   if (skb && !skb_shinfo(skb)->nr_frags)
> >       kfree_skb(skb);
> >
> > evaluates to true because nr_frags is still 0 (the first descriptor
> > used the linear area, not frags). This frees the skb while xs->skb
> > still points to it, creating a dangling pointer. On the next transmit
> > attempt or socket close, xs->skb is dereferenced, causing a
> > use-after-free or double-free.
> >
> > Fix by adding a !xs->skb check to the condition, ensuring we only free
> > skbs that were freshly allocated in this call (xs->skb is NULL) and
> > never free an in-progress multi-buffer skb that the caller still
> > references.
> >
> > Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonx=
ing@gmail.com/
> > Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 6521604f8d42..4fdd1a45a9bd 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       return skb;
> >
> >  free_err:
> > -     if (skb && !skb_shinfo(skb)->nr_frags)
> > +     if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> >               kfree_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
> > --
> > 2.41.3
>
> Now "!skb_shinfo(skb)->nr_frags" feels redundant? It's either
> "skb && !xs->skb" and we own the kfree. or "xs->skb !=3D NULL" and we
> want xsk_drop_skb? Or am I missing something?

Your feeling about being redundant is right. I'm removing it now:)

At this stage, the job of this if statement is to find out the first
skb, so !xs->skb is a clear indicator as you said.

Thanks,
Jason
