Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65E1C8604
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959440; cv=pass; b=RMRA4Pfg89X2KW+SwxNrQ+57dlvTSBN5/EbPMiN88Gz+Cc1pLAXM0uAma07BkSXesOm8EjzyTXAQFQRidWkYwUVe5zn4re19VgnuBdYdaOdkmSvCkhltBQ9lEm1gtFQt6gNFaGmeuQ/jLpgk2/W32tPAgstMyTpSiU3bMnruphA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959440; c=relaxed/simple;
	bh=trL7gv/06X0DWcZrzv48qbCKgjJgo5n7C3gZtkyEUC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usHxSbKg7Zhf4hnumNvrYcPy7bJMqTuHGsygeX5ihu1/IOxodWDsY4tzt859GeNbhwLFlxJwpH/TEMNvQRFpvbuSxo8yHUgC5mhzSxqsXupckJMg/IbHYZnBJutbVvrS1Vf8E7mKABih4bLhaF4k1hr1w4GXWHeRtiEtZlFTsMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iz2pC30D; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iz2pC30D"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12dbd0f7ecaso10845102c88.0
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 22:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959438; cv=none;
        d=google.com; s=arc-20240605;
        b=WgysDr58hwXyNWqWMqC1Gj5JHPQHwLRjaRyWNN5a81hNghavqU+xzs7+Ln5IIKVfHZ
         H22+K2cMb+rE1cDSiTlyYZ/ZSP9ibooRALCuuyT+dQM85mNcBlzcs9ByhJmv3uAzi/SV
         0wBNZBrLN1XHUYTEjnvSyfVtUoFwYg77DKYWgsCsX31xMR6M9GF7Dx2m1Fp7MTLfFzn6
         1Zm/LpTXuZJGp2zxjfVDCBE/cPzDtwpJtHijjMfspemAd62Aio75oA8lZe5EzFEOm3IB
         X5FZlMd658Ulynahuhc0hx1GWXiMMOTQ4YgnJKgj1l97HuB0ps0GO8upkImpreTUR3Na
         ABnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1TR/1cP9UKMBNleo9JuFC/3AaaYuVoaEqpxuVZ8Zj/8=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=auvNBEtPcUYPAQ3KDwvyK+hq6243VjD3o58KyktBSJ/NTMlL+/Cqri+AEEfJ+vaBYP
         D/yZIsrHUSGfGTVHw2mSAce5YipofvCYL27ad7J+oflp1QCtga1DdcqzqSn/0NA7bvL7
         HduEjjrzc5x68yHnhIVnlHGcaiJoIIXyTnCfyXNYMpNqTr+mazARevcG5GHFnRIvPny4
         Hbce0DVJ1y6CoJpwQZSISJw/sRll+qtXHbrYM2N8e6KD0/1gIWEm6wrR629Q2mKHAOuj
         3slw7X0EcOFOjMllU+ek2nDCENgPyfLtVYAQN+XC3zuszdhud21jAvqkubP0ZYsqrl2Y
         mACw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777959438; x=1778564238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TR/1cP9UKMBNleo9JuFC/3AaaYuVoaEqpxuVZ8Zj/8=;
        b=Iz2pC30Dzbie2eMP9r/D627iS4JqQHzk0wY8Ow/hc/a0WYgifV5jcLgYhdyE8Szt2/
         Q4kzc+fj2Hbha41sTQkddgfSVRaYwpJxArusiEpD85Wem+jL52p1eC1pmmznUtGmGLJE
         AlUP8Sxeo4iIGDOPi8+VVKClrTQduws0wr8za0Hm5byEQFXj5FyzKf1nAwtfEP1RL9GN
         Tz0LNL870IhEU3tVclyPWVsh0SLHgGdrbJ4Zz0tldL+ACF9Srve9vKInWcnwTZYxiUcE
         RpV6wAhnTUxADs5GP34Vn8INg/vQmGNZig/3BodkhtHejBcr7SWLxPrTjGMekaRTdx23
         7/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777959438; x=1778564238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TR/1cP9UKMBNleo9JuFC/3AaaYuVoaEqpxuVZ8Zj/8=;
        b=JoAvDl70JIJOCX0LNT8eJKiRKNxnzeI0H6rYymNmUWy58zkUMf4gsQVraYruWLmtka
         c0ZiHRJN6CG/N6vIOIU+aw0wlce0RU5XWnEh14S6OFup769Q7gOIutr9llg+KUEnCapY
         IZu0p73nEXGKtJGfyqMMFoUamQ0eNq/GqMq/Sq4PDZ2STHfMQP92LYGwgC3AS+VJXRdM
         ebBnpE3s/KKt2S2i1Mdvr4lZ8Z2waAXn+T2Ypph+oqWLiVXIq71E1SNB/QrfDYZ8P3Ls
         OlNODa377VL/bOxvTpsetbkPV9EgH+wU4dxKXS4GnoU0EgpQH2CqhL2Hg3RCOSuDrdXC
         UBFQ==
X-Gm-Message-State: AOJu0YxgM47ZAJIfaIZ4dkJrHPspWUHuY+Znr32+/DbWEwF/y6VJh5t6
	6Ab2Bs/HVKB2lpypgUz6MmvUpazMiLZq6i0oK0AXYdNH8w0SSjv2FGuwNnR17UtZEtjZ2WG7iw/
	lR7GTpWf6BjPzl1LoXOQXt9meyDxtMl5BKJZ9Di9w
X-Gm-Gg: AeBDietgc/Eq3BnjKtN5upfjLaWde7GmnSZyjQ5RCD7gxqBX4ZVCHPs3TM/nRyiEYdC
	OOjvf9aMq/pBTGjD1sgVZGaOTlFFwBJfIJYOzxYRCEWFo3PSvSREWjOyHzxN06sbrnDvzfgEpM9
	uwuzStlgOXNc2woL9OFZrZRTrcl1NF0njsKmTYJSq5CNggkutkMsGqiCvNiHtTytQrzCBQQcNZ9
	OSl7vyqzrrlW5VabE85WtRP+r/8uPgITpb3ZuYiwycVa7sb/Hl00EgmNDMb8sEn8pw9eHgQSaVc
	vUtM2NqiIuHpGTW7LeUFAxILSnbFFdATWhRFCxG4PmXSu3R+ay4Ww+53NzNMIINKtOlcFrLV2Nz
	AJ1N1eWNs7V4dBZYnHhnX9LVLlqsRZhgSK1+jwo3+9EVM9MBzxtexroknD3//W1ATbCyGed4Ksg
	==
X-Received: by 2002:a05:7022:5f12:b0:130:9f2d:ff99 with SMTP id
 a92af1059eb24-1309f2e02bemr1360811c88.20.1777959437563; Mon, 04 May 2026
 22:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504210610.180150-2-kuniyu@google.com> <20260505041432.BD566C2BCB4@smtp.kernel.org>
In-Reply-To: <20260505041432.BD566C2BCB4@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 4 May 2026 22:37:06 -0700
X-Gm-Features: AVHnY4Le8fD02CVorGOIqsvyJ6pRtpfz-lTFevvtgy2GYkjbLMI67HlAkB7mgWY
Message-ID: <CAAVpQUCdncvMnuuUfSRMkgE=YO=kF-6nP7MFEf0j6VrhSxFmuw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/6] bpf: tcp: Fix type confusion in bpf_tcp_sock().
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 9:14=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] The OpenVPN (ovpn) driver contains a critical type confusion=
 vulnerability due to insufficient socket type checking, leading to out-of-=
bounds slab writes.
> --
>
> commit 3e93f247feecc891b15b8d713331586af9371dfd
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Fix type confusion in bpf_tcp_sock().
>
> This commit fixes an out-of-bounds slab access bug in BPF by using sk_is_=
tcp()
> instead of just checking sk_protocol for IPPROTO_TCP. This prevents raw s=
ockets
> created with IPPROTO_TCP from bypassing the type check.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e03..cd88633f8dc14 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_acce=
ss_type type,
> >
> >  BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
> >  {
> > -     if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> > +     if (sk_fullsock(sk) && sk_is_tcp(sk))
>
> This correctly prevents a type confusion where a raw socket can bypass th=
e
> protocol check. Does the OpenVPN (ovpn) driver need a similar fix for thi=
s
> exact same pattern?
>
> In drivers/net/ovpn/netlink.c, the driver accepts an arbitrary socket fil=
e
> descriptor from userspace and determines the socket type using only sk_pr=
otocol
> without verifying sk_type.

Not related to BPF.  The point sounds valid, but I'd let
ovpn folks follow up.
