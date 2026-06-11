Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D87376483
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168535; cv=pass; b=VJS45rMKnVbQeviyhplwKLwoktWIkuk4nOZw72yYOcfETl/rl+2i0JuQFjkL3D2qsTxHE0fL/1BqVs+lEokHqn4O3kYXRJo0j6ouAUUFJmzYUswtgrd83fqpo42bdq2sF0OJ+0Lgg2QPN1omKHNVZnfpTwUajU7bZzf1MTdFe4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168535; c=relaxed/simple;
	bh=Q1PsgtMA+I3Pe0Hr6XqziPGeccF4AlHt2HLLuWMgILU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxhf8NBahe2WrB7U6dGDYFTinGFeDM5LMjaeQr3DQ6uml+XE/Cj5r7i33ze7M31z+QR26oBYj7psQnw2ItvIWB97GdAKjBbAx0FBeXC2zF9I1ucTOWmTf5/8msnCS9PLw65FhmGNhJlYVg2rjvslgoWtG8ZQ1s09GR3gfGZA4vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCGaCUu4; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCGaCUu4"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6626cd98209so216074d50.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 02:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781168532; cv=none;
        d=google.com; s=arc-20240605;
        b=RNg5/v/MFzfYt/lsKceH+mnTuwVWEvLJD+L7ydzJ1vZU/jYV6pYMHwk2Nf+p01XhfD
         laLAt722B/VMCeL1mau3MC9uNpMm2pa9NEibthIPP3bfOTXSr/VsV1dMI1izliNEgdFl
         6Hp87nXay9eCIaSD8xT9GpUR3bWG5mlbN8zAsITt7c8yhvA703+bfOqnz9bg58ss/ZOX
         VWz1lPxw8nlBOjxzcWuNIMldFUhO6IR4i71hfh/d5vktmRkM0pjvp5/ftJLXNd2YA4MQ
         7s9xHL10ORWJVIvVqsQRB/cQrEnhTbKJRlAiARrrFpU5MeVrgQkhFG1Wuk/kvXzenCCu
         1ojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jwgGnyW8OZXRqBLUH9knN6tol2cVMvAKSmD8wOWynoc=;
        fh=VJXWVwrReZtgeJiUnfL7ujEb+s5IEz/pGErmzloTzK4=;
        b=IxVctcwIz5HBsDey8wiLIqd6Ve+r5eXzm8HjyIYuXu4IzWjzR4JtkCkqW5VwWmTz9K
         L20Hnk+Vxvsn+fm5fqW2Q8+Gnimi4kgtzHXdFZ3TgpTVAx4pEAsjswWIPlEW/4rz0Zj4
         ataAfafeFcqGy1BZf8dFRCbqxOOXYcCFttfbTUxh3d8bLBdJvSBE5hrT+sS6tAzfEifu
         sTfD3hagxgAIJnLqbRd1WZIXPe0/Ko9ZQlQwmzv1clEBjTW52x0Ig84zAJX+YXnCqeou
         bCy0tMpkWiCgDqZADAVX2TafcJ8+jUn24aQdI6+u/ffwaz7Zxh3lXLwHQcJdgAT8yEa7
         Qypg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168532; x=1781773332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwgGnyW8OZXRqBLUH9knN6tol2cVMvAKSmD8wOWynoc=;
        b=OCGaCUu4Ub0Iozx6xOL6F/dl3Eg1b7rpzo1ZDasQvD+ZQWkggaxZmg7Y5/hW52hOFs
         Lg01MkAvSugVoGBJvm3NRDnoBUWyd+NPkr3GezdgT/r723iGQTLJ0KB8gxRI6T3lRDiX
         ZNXC9FJiyeXUDQ7+KQ6XRJWC864Vp7NfmwpT6lrGwBh1YPuWNDkjHY0jC7fdneq2480N
         4hkjCJGIu9gQiIKkTfO4bOWqRcOl4hDAXd4r5ePG6WXzRLXEwhTPrlkeWVNiUIyTQWxc
         oiMkH0oJiK+JRBIHuvR2r2mZMNbs+Z5wmol1CmTqlCvnUZsUPmORm8aX6l5UCUHO8S65
         MBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168532; x=1781773332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jwgGnyW8OZXRqBLUH9knN6tol2cVMvAKSmD8wOWynoc=;
        b=qcwlSZe26VkmWRghoGxIQ5fcqjltnUfSmcYF1oNbPwjPgIkhp4ztHneJLU6mPb6ZtN
         pNzXD7X16eTPqAOQ2OhsmULAfGo48aCLJ/X1nY5qFFW9kpjFUHFJPeqb0GTH373KZAEa
         PppppHwPC8Tes3RBcpjd63n7dl8815CwfRC68dVj5OI6PNdUtwRdiguunVBXl49NfRjE
         AbUfEnSABtbOCY55+aXxzpScictBmDwHt7O0eCyu1LorZqbjhBu3POUoupDKls1tx6uw
         4hIf9nc9jz+sspwNFiAlfnU4DYH3p2HKc/4r3XH/tazOAKHubmcpreEaRFR72NnTpAor
         FsWg==
X-Gm-Message-State: AOJu0Yy9h2KMwfRlAlM24Xt413KnVHKtJ6enzZLtBl5ZsRMfQjl8VklM
	HMG/uLbwRt6qTk1agP64rAMYC90jiFfreSmO7jDcN91yMB5jKE5ysZq7WiHCCjEgal8+gMfaJ/q
	zog3ER1Uyr8aezYaC6hfuhqLskawQLNs=
X-Gm-Gg: Acq92OEdD1smTI3vCph4s2SqyQ0Slhxi1y2m8zC0O3GJ1nPoRzzpL+6OA4nTR1tlLx6
	2h74FkIK0fl2UNPl+up00n2Tcf553C4wWblZPoJgiyWt7GPUJo/WnjzuYql+Mys/pWlW/EDkaF9
	mpP88eCGKuwX1TbgfPaHgGWQ1aGytP4hFqK7vW/cqsb6eRwZklkhxMqEC/booMiNQfvjBJowCdn
	cLb3QcAOgvF8bXeSKO87OJPWiCu5VboooO5tn6k6phCThOVvl1nu3PMjue4XGROI2of6luuxGwA
	hgn7Khbhpk9G3bKwwy9dcB3cu+rM4fFzmPkAli9bhhn1SM6OzdWlRt76tojEdOggJ94y8w==
X-Received: by 2002:a05:690e:1289:b0:65e:40ef:dc8f with SMTP id
 956f58d0204a3-662699d47e2mr1333630d50.51.1781168532418; Thu, 11 Jun 2026
 02:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
 <20260611080850.536996-2-sun.jian.kdev@gmail.com> <87se6t8ono.fsf@toke.dk>
In-Reply-To: <87se6t8ono.fsf@toke.dk>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 11 Jun 2026 17:02:01 +0800
X-Gm-Features: AVVi8Cf37KuwlUK8Z0rVVPD6yzLkCu6ujOmcxJpQ3mVeHP2o2QssOHKpn8udIUs
Message-ID: <CABFUUZHMomSb0_goXcWvamVhuRCrft-L18UgJ2TowEXiptsQqw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Run generic devmap egress prog on private skb
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, davem@davemloft.net, kuba@kernel.org, 
	hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	jiayuan.chen@linux.dev, menglong.dong@linux.dev, emil@etsalapatis.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 4:30=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Sun Jian <sun.jian.kdev@gmail.com> writes:
>
> > Generic XDP devmap multi redirect uses skb_clone() for intermediate
> > destinations and sends the last destination with the original skb. This
> > can leave multiple destinations sharing the same packet data.
> >
> > This becomes visible after generic devmap egress-program support was
> > added: a devmap egress program may mutate packet data, and another
> > destination sharing the same data can observe that mutation.
> >
> > Native XDP broadcast redirect does not have this issue because
> > xdpf_clone() copies the frame data for each destination. Generic XDP
> > should provide the same per-destination isolation before running a
> > devmap egress program.
> >
> > Fix this by making cloned skbs private before running the generic devma=
p
> > egress program. Use skb_copy() instead of skb_unshare() so allocation
> > failure does not consume the skb and the existing caller error paths ke=
ep
> > their ownership semantics.
> >
> > Fixes: 2ea5eabaf04a ("bpf: devmap: Implement devmap prog execution for =
generic XDP")
> > Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> > ---
> >  kernel/bpf/devmap.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index cc0a43ebab6b..a3d6c60dbddb 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -512,35 +512,52 @@ static inline int __xdp_enqueue(struct net_device=
 *dev, struct xdp_frame *xdpf,
> >       return 0;
> >  }
> >
> > -static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dt=
ab_netdev *dst)
> > +static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
> > +                                 struct bpf_dtab_netdev *dst,
> > +                                 u32 *act)
> >  {
> > +     struct sk_buff *skb =3D *pskb;
> >       struct xdp_txq_info txq =3D { .dev =3D dst->dev };
> >       struct xdp_buff xdp;
> > -     u32 act;
> >
> > -     if (!dst->xdp_prog)
> > -             return XDP_PASS;
> > +     if (!dst->xdp_prog) {
> > +             *act =3D XDP_PASS;
> > +             return 0;
> > +     }
> > +
> > +     if (skb_cloned(skb)) {
> > +             struct sk_buff *nskb;
> > +
> > +             nskb =3D skb_copy(skb, GFP_ATOMIC);
> > +             if (!nskb)
> > +                     return -ENOMEM;
> > +
> > +             nskb->mac_len =3D skb->mac_len;
> > +             consume_skb(skb);
> > +             skb =3D nskb;
> > +             *pskb =3D nskb;
> > +     }
>
> So with all this pointer soup and back and forth, the version you had in
> v2 (with the check and skb_copy() in dev_map_generic_redirect()) was
> much cleaner :/
>
> -Toke
>
Hi Toke,

Thanks, that makes sense. I agree that v4 made the helper interface less
clean.

I'll wait for more feedback before respinning.

Sun Jian
