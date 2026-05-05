Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3830DECE
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009228; cv=pass; b=CcM7S6AvqsGgFQfAl4PmQujEZULNu0mfSaj5fUrlm4+zKBwmfBka7g2W7uDn149Mzw0DUKbYpVVKANvkvovxZdEbMLoKqa7Rb3rJ9u4zNHTmdE7ipQmccro413iZomJt0qlEASKEkKfo/H0QKsLegZfi+nK5DxoMbh+oVt52rsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009228; c=relaxed/simple;
	bh=8e0G55xL7HvEe7Whpe/9RNUYBx4esqcy97V/NGtaNmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMdQ/EzD0gBMe4iI4pC5r0na8KGEWLrtI5GxCeG2UYvFMmlsK2j3gDL2i8spUPvx00ICkYzXLoOUpR3QWSClrhinNgBm9YXkz1bWdRkoYzioZlLtKAaP4+Dln4yDa1N8UoNS7o3BdDjAmP9o0KzxHuS8lHqaHL9bjSdESgQ321U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q+URabIX; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+URabIX"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a860667fabso4584113e87.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:27:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778009224; cv=none;
        d=google.com; s=arc-20240605;
        b=Ws21ZZ8tj/rpdYC+yHkdh6fS62GpSCZ/5TiS2eHcNosTOBMWmJbUxJXXFi3PHBJWO5
         qQ602yPZlW7fZoZeLc4ifK/KfCfmdG9HzJRvqUKn8AoMKDEzHw75zdd6Z6gwvu3OsAzN
         TNiAEvQf03lTT4/Kk45m55uregHbbEzuSJG1Z+XvwR4UzZU4n/3cCi9xaGgHinHEGv3h
         wGWDd6XqMxMtc8kNwyV0f+wXbrZJOfm2yuDwuqdtiQ5zdmLpY0EJEZOBDp4b63ubSSNX
         TJkBVpxlb4nMcU6OFVgVkYTOAjZxJ7naO6f4Wic6h63gmqXGTUrD6pPj4QoSUlzGSXvk
         2Xvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YrlYF5xXPgCryFWDSMdpLq3EQMd37IvsrKIsSlr1DBQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=IXoO1/5ZGf3RTSnE8gySCYS5FsXDEXnNrV/kHIrLekPWFhtMvxi0xTs5XMFxT9phBd
         2K7kFgXKWE+C/ZbyprrkaRfOQ+xP0OkNR8vxnW4hwWpo9z3oO9uSWPBenExMD19lkEd2
         D4cLyqTAs3RALNsiW6v9SyqGcqxcllsrtAD0ZQccq37aRvXVNutH4478wEfyWSRNgWIK
         l2oW+vjXsbA0EYPBIjuHy4pbRf3kH5qTiLQ4vQd3hDkhwbcp24AYvgbUTwzT2JNRdrAV
         zaj9OV8zHzD9bu3px0UoWMzCzTZHOequrUhG6toqkZRY0pMiCs3a221SU6JCC5O8J2N3
         ZLgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009224; x=1778614024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrlYF5xXPgCryFWDSMdpLq3EQMd37IvsrKIsSlr1DBQ=;
        b=q+URabIXqaZBvpcrTYR6pPxThe3Te/5GOITLtx6bP0BrL8URvE8p+8o6nuvxM5VS+T
         a3kA7JvSvla5jQOSVGa2258XFFQ1GIaOtcifH+5nQqe1m/X65q/HIwJ7dt2egWSdUwvM
         CnZUmRIJBeiJp3dI2WYYcbBwjmtt3XbcuYfMVCyq+RBvVfsFsVkhsT1evBhsUoJqVCsZ
         HQcnkbg6mOzop9xU18tASx7wPSPQsoZ30IoJECeAgJD/zHpVUjN2tXKgamhYqibo9ymi
         xivQnseh8UauMnEZcxTLPqFMFrPrBVTyAvVlg9NSbQxv49tMFYWgh2rCdws/XpY1DW6x
         MYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009224; x=1778614024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YrlYF5xXPgCryFWDSMdpLq3EQMd37IvsrKIsSlr1DBQ=;
        b=A+S7NELq8QzoqUqfdwgItP2ZRvy7iqJOmLB4bLDCvXLCBMDuNxlsDIRNTJ1tzpnCrZ
         dCLbEU0p1wGpFPSztohqE4J6cpZDFr2BMoXt2zKbtutxz4NglRrPr0amoC9NOh9wJ6tp
         ea3wfVb9l2WHiM60YPWFBvr0sY/PD51P8uaomDS6ceRx2o/Uyoavq1nTPVDA2ohu+BXs
         eWz888hvKZF7N9Awm4ZzLiwzjZ3AcS0ZuGOCQp9qeTMT3z04rVM3gY/aqSjQLMibimxl
         6N8xci5Z2jSjgipPhWnJ1eUTbQ4XEi2yirfnGo2nTJ+2Vnj8BZ4ZcO3MWJ6v0UV/ursK
         X81A==
X-Gm-Message-State: AOJu0YzwK4NEwdm2vd3kdKP+EmYfDkGbbtdLkTRsqyWSodx3Xt4gAi9X
	jiwN3cIOHk8ce/eFk6oKqsjPiOsLQK+fdXxJHwF+Fkihy/buRgYhNygmt//UP6fAAXTYBzdho98
	gVh8RiiMYhh/WJOsG0icUclhOiUva6F0=
X-Gm-Gg: AeBDiet1YMnuAPuZs+dbJ+Ft7uxTnQCDBmN7VG7hNCPLpKElNqQakB83DhtRBZyq44u
	A9DxNIB9lcuHf5KVSrwdYLKm03L2u+qhLRGKR3FUztQAM6MxwSCGxo1lLYCmX51rJ34AzDGRwTz
	mEErrJe7ZnUACvFrzgk/XephVDYuqg6XQnBox7DTP+Km9ggd7fXc4H1FbB/jw+QArqp/EILfjb2
	A6AhoVy1ONxodRZlFWYZkG39pzb5qXoh+B7PIx1Cp0jrXbvg25ab0NfVuMnSfD19UURBeVKzB3u
	LmRZgroR10Quzpgj7JSEfna9NL8NR7+dEVtNpU9N6GCEkIb3tX9XmeOjRCw=
X-Received: by 2002:a05:6512:2309:b0:5a4:b2d:25c0 with SMTP id
 2adb3069b0e04-5a887ad8c13mr32293e87.3.1778009224323; Tue, 05 May 2026
 12:27:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-3-kerneljasonxing@gmail.com> <20260503200924.4EE32C2BCF4@smtp.kernel.org>
In-Reply-To: <20260503200924.4EE32C2BCF4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:26:24 +0300
X-Gm-Features: AVHnY4LbIaAP9el5vDm6d-RIfE6mVNp52XjYBafC8ZxDY6o9lGAyPNzX7cLkfwU
Message-ID: <CAL+tcoBPNghJT-RTrWSHr9HYvr0QG1p=sL0u+Gm18YU4UE2PvA@mail.gmail.com>
Subject: Re: [PATCH net v5 2/8] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] This problem wasn't introduced by this patch, but returning =
-EOVERFLOW when xs->skb is NULL leads to an unconditional NULL pointer dere=
ference in the caller's error path.
> - [High] Calling kfree_skb(skb) directly on a partially built SKB trigger=
s the custom XSK destructor, which incorrectly submits the failed descripto=
r to the AF_XDP completion queue.
> - [High] This problem wasn't introduced by this patch, but an identical S=
KB memory leak exists when xsk_skb_metadata() fails.
> --
>
> commit cf402952a5ccf9981b4749df15227be947716b0d
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
>
> This patch explicitly adds kfree_skb() before returning -EOVERFLOW to
> its caller when hitting the MAX_SKB_FRAGS limit on a newly allocated
> SKB. This prevents the SKB from being permanently leaked.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 887abed25466..d706b1e0bf60 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -856,8 +856,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >       addr =3D buffer - pool->addrs;
> >
> >       for (copied =3D 0, i =3D skb_shinfo(skb)->nr_frags; copied < len;=
 i++) {
> > -             if (unlikely(i >=3D MAX_SKB_FRAGS))
> > +             if (unlikely(i >=3D MAX_SKB_FRAGS)) {
> > +                     if (!xs->skb)
> > +                             kfree_skb(skb);
>
> Does calling kfree_skb() directly here incorrectly trigger the custom
> XSK destructor for a dropped packet?
>
> Earlier in xsk_build_skb_zerocopy(), the newly allocated SKB is initializ=
ed
> via xsk_skb_init_misc(), which explicitly sets skb->destructor =3D
> xsk_destruct_skb.
>
> When xsk_destruct_skb() runs, it calls xsk_cq_submit_addr_locked(), which
> erroneously generates a spurious TX completion for userspace and bypasses
> the queue's cached_prod reservation state, corrupting the completion queu=
e
> logic.
>
> Should the destructor be cleared first to safely discard the partially
> built SKB?
>
> Note that this regression was fixed later in the patch series by commit
> 88b75ff1d12b ("xsk: prevent CQ desync when freeing half-built skbs in
> xsk_build_skb()").
>
> This problem wasn't introduced by this patch, but can returning -EOVERFLO=
W
> when xs->skb is NULL cause a NULL pointer dereference in the caller's err=
or
> path?

It's a very carefully designed order of this series. Without this
patch the skb is unconditionally leaked (permanent memory loss), which
is strictly worse than a single spurious CQ completion that userspace
can handle. Patch 5/8 then eliminates the destructor issue by
postponing xsk_skb_init_misc() past all error paths.

This is why I move this patch ahead in this version.

>
> In the caller xsk_build_skb(), the local skb pointer is set to NULL, and
> execution jumps to the free_err label. Because err =3D=3D -EOVERFLOW, the=
 error
> handler unconditionally calls:
>
>         xsk_inc_num_desc(xs->skb);
>         xsk_drop_skb(xs->skb);
>
> Since xs->skb is strictly NULL, these functions will immediately derefere=
nce
> the NULL pointer via skb_shinfo(NULL) inside xsk_skb_destructor_is_addr()=
,
> causing a panic.
>
> Note that this regression was fixed later in the patch series by commit
> 819a57cd3753 ("xsk: handle NULL dereference of the skb without frags
> issue").
>
> This problem wasn't introduced by this patch either, but is there an
> identical SKB memory leak earlier in this function when xsk_skb_metadata(=
)
> fails?

As you noticed, this patch doesn't introduce new bugs at all and the
following patches take care of it.

>
> If desc->options & XDP_TX_METADATA is set and xsk_skb_metadata() fails,
> the function returns ERR_PTR(err) directly without freeing the newly
> allocated skb:
>
>         xsk_skb_init_misc(skb, xs, desc->addr);
>         if (desc->options & XDP_TX_METADATA) {
>                 err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr);
>                 if (unlikely(err))
>                         return ERR_PTR(err);
>         }
>
> The caller xsk_build_skb() explicitly overrides its local skb pointer to
> NULL before jumping to free_err, causing this SKB to be permanently leake=
d.
>
> An unprivileged user could trigger this leak by providing malformed
> metadata, leading to memory exhaustion.
>
> Note that this regression was fixed later in the patch series by commit
> f1079e939977 ("xsk: avoid skb leak in XDP_TX_METADATA case").

Right, it has been fixed...

No action needs to be taken so far.

Thanks,
Jason

>
> >                       return ERR_PTR(-EOVERFLOW);
> > +             }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D2
