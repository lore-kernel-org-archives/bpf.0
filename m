Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702A1E5B9A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732736; cv=pass; b=R602/rXNFwvJXOjxmTw8mOeuheP0YsOKryOpNugwa+HqBGMvehCIUktFbxCz6dH9yvzn8f6fdh+UEo4yXBdrDqAGd8bO9yNfJBb++I7mKq1nSVkUu9jtQHQcNeojP1X8GNYJafY79N1+vIOfEfiO7BdAIaBMwE7PNeT0dKjIkV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732736; c=relaxed/simple;
	bh=ilgZvMWhTP8TuR2D837xRb5YUp/BqfQS+mT4OqZApHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErkdZfwSd+9X1eKa4RF5L2aYnYm0IM6D+LosIH5Xj1MO5nStSo4b7baItF/U1TaQJDChRsKwftzVomDH3eeuEKVn8TzExtf18/6z25dHO+qTEoiCeuURJkRPBhu25bmPZD2Z4LzDDjYy79NV6/jA7TgJRPQ/YxCVRWGNr19ANwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epoiVO3G; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epoiVO3G"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a3fcb2c718so3070948e87.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 17:52:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732733; cv=none;
        d=google.com; s=arc-20240605;
        b=gNvlkEm7jCAhPiwVJKcmE64Cb8J7tIDWDWt2mEvOtdIGMEvnywso7FccPtLp6pRgur
         ORCby3iNiSm4kR2GdLrhjm8QTORVDi9jjrzWtaNsuhM4VrKEktNNpo3OfF+Gji1Vo542
         rwmALBlSpY5jV/v+nKgaJ17LkpREY1MCXkDVzborGqqcWnd7HdQmTXjbzBMkQVcixAzX
         XxoFjyZTOUrDXLxtPCEmBHcCKi0CAndq/fTexKsavhrYNAlRNb4d7QpdRPYf/iBx1Lxg
         zu7jArFBMGzH/+w46kDuG53wwYc4XX5XudGXNJDZNRY1joGYA5YVfRmz74+Z1H772PUG
         xBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ciNUsYZGg5OOsZxV9U8O6SdkAhWyByMHojw4SCqb2k=;
        fh=ufUKeSpCrM7UZhECS00Uov6qBYdMktaAxuA3HGXOKqc=;
        b=eXcboK01EFFQ9mBKLFAEFTLecTp6XTtLj5Eruq0nA9Xn7J/70rT/2A6AxXsAahRB98
         Tri7mC1vn3Ba0KvdCqGWvWokXnbM4CedjpmupO/r0gOXKYX1Y/LRrYLP3pp2IlfutuP8
         RU1s8rUkkdqGzzA5VAF28IA0i2+RQUH1rTT5t0gDJKbvBTNL0FsSeeXeazIS8Ok9Cy8p
         /ig8Qv8RdU+TaNJzP82PpVBW9xi5DD7IxxnomAhO/RTdfVvl4q0ZihTpelUTEW0e5XKg
         d33HvEA4RdrnaMnw+hnPUbpV593tQhxcFrcmxQ45+KP61DKUZPU/AjdLQFVhqj8PZmn4
         br7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776732733; x=1777337533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ciNUsYZGg5OOsZxV9U8O6SdkAhWyByMHojw4SCqb2k=;
        b=epoiVO3GX+lgl8cwWHQehQeReGdigsOvVDw6thyyXofA4O0cTHOIYGbDUG0VHfg+tP
         6ypfivYdgY0lAmOiL8vFsF2ypU1qAJHNP/howkT08orEes9qYJP3auq/uEaaGpGjoMHA
         0s9EaRHIBdDhSlIezQ6OYRfjYpLNSZlZMVYY6JyXJG25usiaICV496iiNgrudwspdfPT
         glZgQamK0iF1zPQxbrOWPrAkw1vZWAGEhfjSeK97MWH8JAOoKFhaO2LNh+sylUPTHP0g
         YqALE0G1ETLo/Aq4181hsCZUDH39eiCEXD395ylq+vgx02pBtP4ZAG0gzJJ977ki0Bg1
         WGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776732733; x=1777337533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ciNUsYZGg5OOsZxV9U8O6SdkAhWyByMHojw4SCqb2k=;
        b=SST9WH8LlSm4pafud+Uft+H+hVEMGWs2CIWkq2FcmKIKt95srQPdoesSOyaRqyifQo
         VcmGvJbc4Pc7IOsqcuyXDe6e8svCuKHLehB81o9lCshWWpK+rW+2grCtNNMsotthAKPQ
         KhJqLbs+eKH1Ls+nQc715qEtpnnLqEMFSaMcc4sf9vgN7OyNW+mW4TwWap3AChrKN1a2
         K4O7uMLmsRpKJstzaXyv20gasbVazIN8mZDrltjC79LffRJ+VVcfyyISWdpA+vbSJaQ+
         IC534XlC9eiJU11fI3F3+61rmTVQcqlr3+7tkguD42LaqldqrPAMN7iw/ppyWh1Vjbf5
         9U4Q==
X-Gm-Message-State: AOJu0YyTlwksI1RsEdK3lZ+7HHCsEMS7gdKqCHgRq4bYSg6t6jI7ApFP
	V9UaL07RIlwXfBaIt4WkpiHyuIlA5Alnrw1QBLFDtpCcirM1jibJU/7cmecBov6WZyO0hxJ309I
	7dEBGiuQcZOSSl2/+19ZIAp0KEGueBLaJipmlap8=
X-Gm-Gg: AeBDiesEmefNvmPf2WwQBb9AZgnFu5hYv+ukp8FAQhAX6qmy/Bnd26wgomFldc7bCHm
	9/xjzp8EPOKd2KAAuKIqsqCgZeKLdNUsEh9tGiuMyzTq3kXONiQK5XudF04kvonXQ/Nq9xJ7xKP
	Ju4J5B7bRunvIHGcRNU23cAUifaKaZuT5mu5NLPxnu2r9vuFM4Ro6UduOTd9bopKvS/7GT/1OoV
	c4MAK8nICry879dDRBeQE+xaMzU8JkCDKwpNwkUwx6GCWX/ssEReT2OUFQjE+pgiPM4igSNgudJ
	TdcPlUxvYWemD+7Ujg==
X-Received: by 2002:a05:6512:239d:b0:5a4:505:f62f with SMTP id
 2adb3069b0e04-5a4172ca7fbmr4550210e87.6.1776732732509; Mon, 20 Apr 2026
 17:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-5-kerneljasonxing@gmail.com> <7f15844902d6dcee6ba070b0f3002b20.sdf.kernel@gmail.com>
In-Reply-To: <7f15844902d6dcee6ba070b0f3002b20.sdf.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:51:33 +0800
X-Gm-Features: AQROBzAy09mKiSjSVzCffG-8u0Ouuj3XshZ6nG46XKvls7xHD9P_Hpu1q0JerqE
Message-ID: <CAL+tcoBZMictQwO0WyaXGT3-2uanO1wz5bDip6=YB4RCn61JEw@mail.gmail.com>
Subject: Re: [PATCH net v2 4/8] xsk: prevent CQ desync when freeing half-built
 skbs in xsk_build_skb()
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
> > Once xsk_skb_init_misc() has been called on an skb, its destructor is
> > set to xsk_destruct_skb(), which submits the descriptor address(es) to
> > the completion queue and advances the CQ producer. If such an skb is
> > subsequently freed via kfree_skb() along an error path - before the
> > skb has ever been handed to the driver - the destructor still runs and
> > submits a bogus, half-initialized address to the CQ.
> >
> > Introduce a new common helper to fix the issue. That function will be
> > used by the subsequent patches soon.
> >
> > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.ker=
nel.org/
> > Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffe=
r traffic")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 4fdd1a45a9bd..614e7bd1252b 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -717,6 +717,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
> >       return 0;
> >  }
> >
> > +static void xsk_drop_untrans_skb(struct sk_buff *skb)
> > +{
> > +     skb->destructor =3D sock_wfree;
> > +     kfree_skb(skb);
> > +}
> > +
> >  static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> >                                             struct xdp_desc *desc)
> >  {
> > @@ -890,7 +896,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >
> >  free_err:
> >       if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> > -             kfree_skb(skb);
> > +             xsk_drop_untrans_skb(skb);
> >
> >       if (err =3D=3D -EOVERFLOW) {
> >               if (xs->skb) {
> > --
> > 2.41.3
> >
>
> Have you considered the alternative where we postpone `skb->destructor =
=3D
> xsk_destruct_skb` to a later point? Will this be less messy than
> undoing that descriptor in a few curated places?

Thanks. It does make sense. Adding the following code seems fine:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 887abed25466..02e723ca3080 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -820,7 +820,6 @@ static struct sk_buff
*xsk_build_skb_zerocopy(struct xdp_sock *xs,

                skb_reserve(skb, hr);

-               xsk_skb_init_misc(skb, xs, desc->addr);
                if (desc->options & XDP_TX_METADATA) {
                        err =3D xsk_skb_metadata(skb, buffer, desc, pool, h=
r);
                        if (unlikely(err))
@@ -914,7 +913,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *x=
s,
                        if (unlikely(err))
                                goto free_err;

-                       xsk_skb_init_misc(skb, xs, desc->addr);
                        if (desc->options & XDP_TX_METADATA) {
                                err =3D xsk_skb_metadata(skb, buffer, desc,
                                                       xs->pool, hr);
@@ -964,6 +962,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *x=
s,
                }
        }

+       if (!xs->skb)
+               xsk_skb_init_misc(skb, xs, desc->addr);
        xsk_inc_num_desc(skb);

        return skb;

Thanks,
Jason
