Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA772C3255
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010412; cv=pass; b=ieeMfpUCYXeZ4qtpJnpBVcD8pDWsuomYtha9YN91V9GR7us4bBZSQtWmUUtLyDsGPnUp9i+qKWe+PTcRWu6sJNT5PXfwP99Yh3OMUZA9+1aMovGDPNawUyAaKNtp5InRXha2mD1TIF4l+rUHdzdwJxOOu9Tmd9KMDBZpiHQRUjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010412; c=relaxed/simple;
	bh=E357EEz6wA12TgsMkENSmkoFH2QFS+9tNac78U2KDko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onE51AqLjP+bpJbquIRtq3eS5BQrAvj7I+/W/YkH5ERXQ8YVsC4LjEOfZ2U+OH/hniFzBYihdSAq57sX/3W0dt8KcTpcykdvUXoS7yZHfCHtUsv30Iv7mAv+sC4XbFq5HBU5DNqU26c7NS/4WDFMpJPg9Ksj9UR6bmI4r2fr/hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arVqomPI; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arVqomPI"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dcdf60427so5306494e87.3
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:46:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778010409; cv=none;
        d=google.com; s=arc-20240605;
        b=SEWtKvjrXsfuTN0tkWrMORLpOXCl2kDtwBinlAZyiSRDps80wwNYjprTwFGdV+JGDO
         5bCoWItyz+B2A6fZBa3rZ22JZUYgpjWXfzQQfI7afi/LptwXBGYylqJlLDzDskIKl3z1
         jSVxUxI7NH1g2H4C8nlEI9ITcIlUm7t6xemKXT9DWj2XdOa2/NbFCF/xJSPh7Z1WBrRQ
         G3oOq3B2wlObl+6+eGg4d/LWEe3TYoA1Ol9UeJJclZoE6sTS/wI9Ldeqk49VX3+qY79m
         309c/+F57bqkm2StMlA2PVTIoDp7xxNWhCQDFjrPT5nt6FEAiQb2v0xew3A+AEtbIg3t
         m3xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWU9rOpaHZ1DhhXMYqH7oDqxMjcohg/E8GRcu0AFpqo=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=TsrTalJGgo8lfpj8J8kl8df9F3SiDiPDvLUlG5c/Iv4p30jcz33XMX4lPGOOcm38HQ
         vZXYBDtytHUvb2L85aZzPbpC1hoslPhk+JnHme8fgApuQkQFTViK5yXe2kSM6VecYdnz
         jmXanJHapss1Vdlsm7pPhmySxBUDdmz3nnlAvaDSKLZCDMWJJKXYgTiXw3rZK7jt1Lx2
         1XFtxn+lRlBL+aWXa2rI8HPBIby2yCDaH28lEwyzdS50GDT8eLzvvq9a64Vr90vC3ReS
         wVq59ZTNOOo8//zQl0IIXvF4+cv0fpK/QOQ1Z5BgvtwMN/9dohAYCetGm9A8ms/xtWO8
         l5Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778010409; x=1778615209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWU9rOpaHZ1DhhXMYqH7oDqxMjcohg/E8GRcu0AFpqo=;
        b=arVqomPIlB0ltYXA8cWAAFcRffibWWr2quHMggTe/AO80DHWs4uVc8grzON5lQVSsf
         Ksp0/SXnlVupZ75IsJEB8eTqjrAAPmplF3ZqcydVsTq6j9K5CknJR8cmg9nj/FGANa9w
         rV7lQX6vXj69i80pBaPirw4Z+CcscwvjX1ZVbELTx3vP971L1VPxwD7MNjYTkhAnh0wO
         Wtz/gRoNfQxQI/8NKF12pt2ES++bUV9FOLuMUWZba0kikLT1hp1wYcDiY+QBvo3uptRM
         yAwiYc3O+oReawdUlUurvZTvZgPNVe9D/iFypqcIkEyIWbAljBVyWit3EAyOuiCwu9Vt
         1LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010409; x=1778615209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWU9rOpaHZ1DhhXMYqH7oDqxMjcohg/E8GRcu0AFpqo=;
        b=fdgFbCLlTKkKQVWqCUe9a3WfNJKfJw9lj25uu7be48JHdHGmQcZaPyYOmohIGeM67s
         eCKlrTjCGZ7Zr5wOcnpt7Td3d8lz+fo4cxzf46eV/OiGDwTFAkFjZk4Q7A59WdNvJvOZ
         afcjsmA+4oCTh0gclg4WZFllspB3P4FIGtshLWZZHg/V88loyYanftzr9TdpJ+gzsqbO
         2pMmxuqOEmlcicdNUGmHHCBW8XaR/pSWWl/CSQX7gPcOz8L3jjlRkBqzJXW0czGoizL8
         xzOUkHmoE3GKElDMuYUeRG4wctoZrDACtnolg4NZqjmwMNJKO+EHLzGOepLnP0DP0VcR
         dHpg==
X-Gm-Message-State: AOJu0YwQ/7L7A1YApZTR1vUMgfKvzuqr5eQs/0yPz6ZeQ//9VCbw1KsL
	NDI1XA7TkF4//jjb4woYr+8UkwRciVb5Di30HAfYVNaEvU/aiBTB4IkFUpZ7zL/dLCH3fhwoFhu
	uyIV/mVJCnRFLlrBMA7ped2KjX3h3bVgLqFSJGYWjKA==
X-Gm-Gg: AeBDieuW1rjfu+EcZvvtqCDhVfvE7lblSG2wsr0WRrk0+Fq+VP15QwybtNlbfIWSuBA
	HvrIixAd/C1Y9DH+zs9ZcnjBlaeaqXeE1BU+/iABBAmlZI7ftfrkkYQYeyLqEajS4mCulcYqrQV
	Lo1TtrLW3aNYpF72Qh+itonw0qkjfdLbx/lYREbKmqvVyuz+uwmO+q8QFDMgYeE1lyethYzVyO+
	aIGyB8HfJErJeFFk4V7idFqQvtyIAMDStQ7SO9Pwa6EHe+MylAuOHvBnsape7dOC9/MumiOER0T
	rxShQuOk1TgJTjkeE/OZ7686Z+N0VsgkvDIbO/Wu7WqLGYKq
X-Received: by 2002:a05:6512:3a8e:b0:5a7:49ed:8aa with SMTP id
 2adb3069b0e04-5a887adfc1bmr58626e87.11.1778010409350; Tue, 05 May 2026
 12:46:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-9-kerneljasonxing@gmail.com> <20260503200928.5988DC2BCB4@smtp.kernel.org>
In-Reply-To: <20260503200928.5988DC2BCB4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:46:05 +0300
X-Gm-Features: AVHnY4LBojguOcRNc5OxJ3xvYVr8nJ5tvHPQKuM4JG_dxX64kfAOGRi4oc5nZsw
Message-ID: <CAL+tcoAK-X3Tn-7Gc4X6UjW1FUBSKquqsKOFF1UBBLGeGWMSRQ@mail.gmail.com>
Subject: Re: [PATCH net v5 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] In the copy-mode TX path (`xsk_build_skb`), if a multi-buffer fr=
agment exceeds the `MAX_SKB_FRAGS` limit, the buffer's address is leaked to=
 userspace because `0` is erroneously submitted to the completion queue.
> --
>
> commit 4a776aefc60aa4d3123e7e63fd8f927f3748d008
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: fix u64 descriptor address truncation on 32-bit architectures
>
> This commit fixes a 32-bit truncation issue when storing 64-bit descripto=
r
> addresses in the SKB destructor argument by allocating an xsk_addrs struc=
t.
> It consolidates the allocation logic into xsk_addrs_alloc() and uses it i=
n
> both zerocopy and copy modes.
>
> Link: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.=
org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 079abd4bcb69..5e5786cd9af5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
>
> [ ... ]
>
> > @@ -929,19 +959,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_s=
ock *xs,
> >                       struct page *page;
> >                       u8 *vaddr;
> >
> > -                     if (xsk_skb_destructor_is_addr(skb)) {
> > -                             xsk_addr =3D kmem_cache_zalloc(xsk_tx_gen=
eric_cache,
> > -                                                          GFP_KERNEL);
> > -                             if (!xsk_addr) {
> > -                                     err =3D -ENOMEM;
> > -                                     goto free_err;
> > -                             }
> > -
> > -                             xsk_addr->num_descs =3D 1;
> > -                             xsk_addr->addrs[0] =3D xsk_skb_destructor=
_get_addr(skb);
> > -                             skb_shinfo(skb)->destructor_arg =3D (void=
 *)xsk_addr;
> > -                     } else {
> > -                             xsk_addr =3D (struct xsk_addrs *)skb_shin=
fo(skb)->destructor_arg;
> > +                     xsk_addr =3D xsk_addrs_alloc(skb);
> > +                     if (!xsk_addr) {
> > +                             err =3D -ENOMEM;
> > +                             goto free_err;
> >                       }
> >
> >                       if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS - 1) =
&& xp_mb_desc(desc))) {
>
> This isn't a regression introduced by this patch, but while looking at th=
e
> modified code, does this error handling path leak the buffer's address to
> userspace?
>
> If this overflow check evaluates to true, the code sets err =3D -EOVERFLO=
W and
> jumps to the free_err label before assigning desc->addr to
> xsk_addr->addrs[xsk_addr->num_descs].
>
> In the free_err block, it handles -EOVERFLOW by calling
> xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb). This increments
> num_descs to account for the dropped descriptor and eventually calls
> xsk_destruct_skb() which calls xsk_cq_submit_addr_locked().
>
> Since xsk_addr->addrs was never initialized with desc->addr for this
> descriptor, does this mean it submits 0 (from kmem_cache_zalloc) to the
> completion queue instead of the actual buffer address, causing userspace
> to permanently lose track of the buffer?
>
> By comparison, xsk_build_skb_zerocopy() assigns desc->addr to the array
> before checking the fragment limit:
>
> net/xdp/xsk.c:xsk_build_skb_zerocopy() {
>     ...
>                 xsk_addr =3D xsk_addrs_alloc(skb);
>                 if (!xsk_addr)
>                         return ERR_PTR(-ENOMEM);
>
>                 /* in case of -EOVERFLOW that could happen below,
>                  * xsk_consume_skb() will release this node as whole skb
>                  * would be dropped, which implies freeing all list eleme=
nts
>                  */
>                 xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
>         }
>
>         len =3D desc->len;
>     ...
> }
>
> Should xsk_build_skb() also record the descriptor address before checking
> the -EOVERFLOW condition?

It has already been uncovered by you, maybe in v4 or v3 :) Sure, it
will be fixed after this patch gets merged.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D8
