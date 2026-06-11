Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAC3B42CA
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161847; cv=pass; b=nCbZmB2gQh3VRJgPQXBGyMu1SAFjsViX82/oMVBZiq4P7/XwoK002ByFPI6EzdcGib4mybN3xD9zKiO9AxtqQZHuP2/AZ7zU5JEk3myPoAWQeGEQCL0vEGRHT12TpiWrOLCQmPInBu84R/TD2FCoh9XvC/bVbZ4+eyzUWHvqK+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161847; c=relaxed/simple;
	bh=SDrj9QLyrkFNYM/bIRWCwbK7r7eFm1ZtCfLFN6N91Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFAe5sbF27j9mJ5y2atcIhQCWFuIGo+qiTeQlUuhHj4M2hty3dIg8Ej36axc0ezeHKfpkp4aLALA+RLxC9h1csEvGGrC0fTZWItkyfOAvvVYy3ZILMmrjMix40C/PH9JjxXDEFK4pVkjyVyH0T1Zb9dicv7jj3rpfF7srRc3uHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBWPSSPp; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBWPSSPp"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66062a414fcso8471664d50.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 00:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781161845; cv=none;
        d=google.com; s=arc-20240605;
        b=XW1ZUFE3gbDrvFw0+z1jSKZxZCVzNUt0xybkmD9iZxokPoh5L1eccnim9WTxQCHbit
         bkGfxf87h3tXtSXujqBvdogojfLQvJuoPscA/81FVk5lYy5dLHhVwDIcTptUjdfIyNpR
         e4LTJWq0kM+SiHUi6nUl3RzuNBb0/hJdLfMjN9G9bW18XiQY9rS112NpPZ2pIMDxRHdm
         S2s2O+0ykAUhLlA+uDH6GeSEUQqCM/T+TAMJPNFThR5QeCVdryOifxpXr+o+eo8ECdAL
         uMfciXbzBmgZsyl/BfXHcebCbDscx6o0Tc9qBzxHfBb5ENwYfuhCKWOgzdCXuAD6N3YS
         gzDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/lURB3/LzIdITeZ1AKaYes4tHMeiGZ75b15AvCb6ZJ4=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=hrMaoM1GAasj35nkTUtLa5YyuOwuKqeoG3oYWGdRwCHfuY0fB3rpcNkRnj+0qgad5K
         psQYmGK3h9e8jO2+/Uca+94WLpwJ2bkixZJ8yMKSCrGQzaWVLteT1ZjuQabWkfWSFQSS
         xGq8RXl3ri5jmbPkL9f5bh4xWDO33aAPSNAg31puwaXSxWwMI+Aih1iCkoafzvuhWdgX
         Rmehw1QWRcrdmK9oIHPRdag6uxhroNLJJa5bVZX1voMcVMZ/EawLp3TwpdnydB0Z/HIt
         LoExgEP7CeT3m0AAX0a1xZYZFpp196sMd8EcDsDndWdexZYRphxymGoa64MdkL8Tn0Ad
         pp3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781161845; x=1781766645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lURB3/LzIdITeZ1AKaYes4tHMeiGZ75b15AvCb6ZJ4=;
        b=QBWPSSPpbjQhGdEnL9Uw+qVGDx9eWkv9K/y3fVoC242SdJWhsOkToAtsyoejbk6t/m
         xyzJLpMArG8LxO13R1WbRfX7Brh+ZJOZK3SPttulmdorOGVtnIVpvkrjJfM8eRGwTdkN
         t2hXf+SzjlMiuNMyD5jBvRlK5BAC8Bkq+tIFvPP0axk5q1ERiL4HeBBuGZ2VIhJj4GU6
         hwEGp2imDfnODNK4FFqTIc8Gc4Saj8sUUmKpQYWHIFOqdSgeX+G4M7Jh7eJ4vO8L4kTM
         WF2XDibX95guduvxv3huifDhhZ2UUeltrPFQHTBPXuhHG0lQqlmqEOLTb/+OjlS8KnAJ
         JSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161845; x=1781766645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/lURB3/LzIdITeZ1AKaYes4tHMeiGZ75b15AvCb6ZJ4=;
        b=kvuLBLkeR44utFEgUnHgKaPV/1Ol0S+yLxXAp/UW5Bmw+3crfxBmZVmW0E17upvE4V
         qyUJ6b9rEKBtGREAbPkef1j2dHNqNGXlUm+FzJIRhW3l5D59MuzYSDbNvEsmdtMnuY4a
         YWp4XQh2gG3XsBkqjDphtIF1A6K7if/AYftnJy83ZWNVkzwgx7jKVn6RFwStmSFK2Gsr
         E7fERlKNheYtkPAgvdbAfcIGW2qXm+cjk8C6x5+HVOgYJlAdRg+k6wfJrpu61LixsgKv
         Hk7nAgPKkmYVTz6aPo1z2Snf5zpk5S/zaXsNiUpEdZluiUuT3KHXC868xj3icXuYsasT
         YYEw==
X-Gm-Message-State: AOJu0YyhdAdHvN5j2o1TNkHxsBE2Wa8/BroD5fRAfqYpuQTKzXm8bXfs
	YLNOEPcVv0Ymp3YqP4qw6o5AW7wYwi1mdEB32d4ABOR7TQQxsfuG2pZI9fx8HVQcQr+584n8rb3
	MVSUTUyM+LfR3xq9AAklGP0839Is5MVQ=
X-Gm-Gg: Acq92OGDEikOFXetmqaJqNBQqsf+ZljIjszDWRPNH8zRbikWuCm+k7/qZqSU+AR/gnA
	2PL6oayuF/gP21iVwmMVD4hG9QT6bTU2G73M2fINLgti2zrQ0jRZxN7RotGc7lanONHoglqzzUq
	JXX9X+s5m6njsde32fBIPERwbD6lgH/NW3Q1JG5LpBYaE5YOgpMzDRpEG+3XRpyLn7k0IDC1yC/
	EEC6zFTpIdqy9+9XZ9+C9ZJPo4zCxsArGMr204R0n0Otf4HLDxF5zt+9BzdkXXtzo8AhgX6Rz07
	gjMu1XD0eXRgxOHqUT5jjuuLOmOpT2ezUvAMJwNSphOpPIh7QFQCddXauNK4BBK546FPRw==
X-Received: by 2002:a05:690e:bc5:b0:65c:7129:5c66 with SMTP id
 956f58d0204a3-6626d1487c4mr392669d50.41.1781161845515; Thu, 11 Jun 2026
 00:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611043317.512843-2-sun.jian.kdev@gmail.com> <20260611045842.7A5B71F00898@smtp.kernel.org>
In-Reply-To: <20260611045842.7A5B71F00898@smtp.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 11 Jun 2026 15:10:34 +0800
X-Gm-Features: AVVi8CdiSOLVCehH25tG7w7TBAKHBVE1AWI-I4Fj09Gt1yRAE0iIiUg_XBa2Gaw
Message-ID: <CABFUUZFQXxYVdi_QqhGG8WTTf=F1BqOmroYj50mv0w70Acf5Bw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Run generic devmap egress prog on private skb
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] A maliciously crafted or buggy BPF devmap egress program can=
 cause a double free of an skb by returning an action code that implicitly =
casts to a negative integer.
> - [High] skb_copy() zeroes out skb->mac_len, causing generic XDP to opera=
te on the wrong skb->data offset and potentially read garbage from uninitia=
lized headroom.
> --
>
> commit b95ebb55a25ce44657b1e9ee2add3b1177f06853
> Author: Sun Jian <sun.jian.kdev@gmail.com>
>
> bpf: Run generic devmap egress prog on private skb
>
> This commit introduces a fix to prevent multiple destinations from sharin=
g
> the same packet data in generic devmap egress programs by copying cloned
> skbs before running the program.
>
> > diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> > index cc0a43ebab6b9..14506834345aa 100644
> > --- a/kernel/bpf/devmap.c
> > +++ b/kernel/bpf/devmap.c
> > @@ -512,8 +512,10 @@ static inline int __xdp_enqueue(struct net_device =
*dev, struct xdp_frame *xdpf,
> >       return 0;
> >  }
> >
> > -static u32 dev_map_bpf_prog_run_skb(struct sk_buff *skb, struct bpf_dt=
ab_netdev *dst)
> > +static int dev_map_bpf_prog_run_skb(struct sk_buff **pskb,
> > +                                 struct bpf_dtab_netdev *dst)
>
> [Severity: Critical]
> The return type here was changed from u32 to int. Because xdp action code=
s
> returned by bpf programs are unconstrained 32-bit unsigned integers, what
> happens if a program returns a value with the highest bit set?
>
> Could this arbitrary unsigned action code be implicitly cast to a negativ=
e
> integer, causing callers to mistakenly interpret it as a kernel error?
>
> >  {
> > +     struct sk_buff *skb =3D *pskb;
> >       struct xdp_txq_info txq =3D { .dev =3D dst->dev };
> >       struct xdp_buff xdp;
>
> [ ... ]
>
> > @@ -521,6 +523,18 @@ static u32 dev_map_bpf_prog_run_skb(struct sk_buff=
 *skb, struct bpf_dtab_netdev
> >       if (!dst->xdp_prog)
> >               return XDP_PASS;
> >
> > +     if (skb_cloned(skb)) {
> > +             struct sk_buff *nskb;
> > +
> > +             nskb =3D skb_copy(skb, GFP_ATOMIC);
>
> [Severity: High]
> Does skb_copy preserve the mac_len field?
>
> Because skb_copy allocates a new skb and zeroes out the structure up to t=
he
> headers, mac_len is left as 0.
>
> > +             if (!nskb)
> > +                     return -ENOMEM;
> > +
> > +             consume_skb(skb);
> > +             skb =3D nskb;
> > +             *pskb =3D nskb;
> > +     }
> > +
> >       __skb_pull(skb, skb->mac_len);
>
> [Severity: High]
> Following up on the skb_copy question above, if mac_len is 0, will this
> pull 0 bytes instead of the expected header length?
>
> If so, the data pointer would remain at the mac header instead of the
> network header. If an egress program later modifies the ethernet header
> and triggers the mac update path, could this push the data pointer
> backwards into uninitialized headroom, leading to protocol corruption
> or leaked kernel memory?
>
> [ ... ]
>
> > @@ -710,7 +724,10 @@ int dev_map_generic_redirect(struct bpf_dtab_netde=
v *dst, struct sk_buff *skb,
> >        * return 0 even if packet is dropped. Helper below takes care of
> >        * freeing skb.
> >        */
> > -     if (dev_map_bpf_prog_run_skb(skb, dst) !=3D XDP_PASS)
> > +     err =3D dev_map_bpf_prog_run_skb(&skb, dst);
> > +     if (err < 0)
> > +             return err;
>
> [Severity: Critical]
> If dev_map_bpf_prog_run_skb returns a negative integer due to an implicit=
ly
> cast unsigned action code as mentioned above, will it hit this error path=
?
>
> If dev_map_bpf_prog_run_skb already dropped the packet via kfree_skb, wil=
l
> propagating this negative value cause higher level callers to execute the=
ir
> own error paths and free the identical skb a second time?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611043317.51=
2843-1-sun.jian.kdev@gmail.com?part=3D1

Thanks for the review.

I checked the skb_copy() path and this concern is valid. skb_copy()
calls skb_copy_header(), which does not copy mac_len. I will preserve
mac_len explicitly after skb_copy() in v4.

I will also avoid mixing errno and XDP action values in the helper return
value. The helper will return only errno and pass the XDP action back
through an output argument, so invalid action values cannot be interpreted
as negative errors by the caller.

Thanks,
sun jian
