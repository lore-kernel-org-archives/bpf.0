Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F1F5478D
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776607809; cv=pass; b=CpuZQhe1dHd6MJgW8NE3VRoRgLvMxMe1zXgtwupC4gg71UbbuWbTByv9bvw5YjT4kPySN4Gu2GY68p/k+q48hYYUgEPz6n3RX5h8QKTYTvpP+rfttYGNA7L1av0dBU9oUN1YbQSy2Hj3RpEEHSvtOcnvsuLMPpXHVYAB1IblFms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776607809; c=relaxed/simple;
	bh=FTki9bCzEbIWjDU0LcxyaxfwDRIFHTIRbOOJ3Rc3s+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQBllPLMhmG4KJRd09vdCc4AmHtPW7AOwKxBWKec46SC8ZaeB3zGrW0004AbfHEm26A3gSWkZWaMBUY7qcyuw1mjGHKLFUPxIZLdqFL4mRUucFoqrfTtANm0LPcyzONGn0Rt/5XUApZpmI3PMwrHBP8q8M6i3CXbGs9ysCXo7Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJmQib6T; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJmQib6T"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a3cc771c26so1808897e87.3
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 07:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776607806; cv=none;
        d=google.com; s=arc-20240605;
        b=dlcs1eVkpv84GCEDee3PVOcZAgKZ3DRV6gkM6iu8o+6KBvBL8R47RgUsv9gac0g5pw
         7Ui8Mim36PbgA+I3S/pXL5xRiK2F+EzpuIMefr3xf1cu1LA71tgSkYCzzAqjIHbtLNAd
         a3EEOplQBxENefElU5ST/C+0mAGEGEsWkCx882rNxMNMsmf+B004AEnALOHmgHYpAXag
         tDpnJVylk6nVPMI+N/Q9Yun2m3Hi0htCZx9a3eYFKSwKhWWHJD2UMxxQdQ3CZN5JZnSc
         fs0PpRuGAkotGodSpqMHOOyW/A32o2miJrB5j5tPKPbITuCrsezRbiikcf8I8GsA5exA
         N4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7lkofk80y5ASD7Y3pVbAIezkpP2DV7oPOOMIxhfpcw=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=e1Y5k9KL4yMhDj6sGJiAy2b1Rq16wO65cwarKyrK/hGOw8jWS0dO3xwI6dUURr4/6G
         8+3zDa+mX4dzhJZdzorAz5gXdrb5eO8STkSH4AiTrDGTjrV+cL17wzaLQWILWPqVN7Xf
         zvn8cXcRpPT7Pg7RcqBCSACo9xrZdXCERcDbSenfzfshBoDo5ZVUeAX4Qfsfa8yrDDOX
         hMoa3bgmT2O50J+BrAjsgAkDV3yJ4soLrs9+yjhbjLlpHZZtbBtuIA/nYCuUKHdyCCel
         wPux2cRM4A+jQj7YQIu9GSiDVaEjiMRj9hpysu2D0dG6c+1iIipfaLjW+J3LhfqMAZ9x
         RPsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776607806; x=1777212606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7lkofk80y5ASD7Y3pVbAIezkpP2DV7oPOOMIxhfpcw=;
        b=eJmQib6TqEaUYt+SfRwfrilmlM0LC4D2K5/TQsNYBOin77VTkOECwjVrzTck4qM9Dv
         NLyv+tYyGgDb3/GtWzPH5eSK2PXBX/CYJq7yJCqBwsG3SErWU2FlQkPU/Nok/e0P/H77
         1NwWJxKCl49PVhthLrGlhat8wzn5UQ2YYVcoDb/FnvMb3GDAPxj3UQ2+a4qzoWFxsWeU
         UtSeh5+se7SzRnXzez6kyFECMHPpNdt5cjM3qpnfIbGjeponUz82k/2z6BrTtrX2W0X9
         Jw07MPSYwc7kRoDCrjKmx1+wrALqT6r13l+QCgoYLqjgec6w9ncSR+KihSFmAUeTj8y6
         wzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776607806; x=1777212606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7lkofk80y5ASD7Y3pVbAIezkpP2DV7oPOOMIxhfpcw=;
        b=SFmgJM6tOBEYw6BBERpmI/1bWBmZ4uEBm8oCHgTJhc+20IKo9xB5irU+T9m+iqxuyv
         3dvep0c/QnB9qAs4SjxbvInPX3+Pg72IfdLxjV1dlLI4VVUPBmkbszOkdU3eekxBXVfH
         scTmVUcSe4nYw29EAcyKn4YYytw35Z3wWsFycO2ZjuawoCfqaL8qnEBqWHA+XQNYzIxn
         BHnPSUSnFwjsYeRifiWbDb7VmRPZfIggLqd291FnsAlcYwSRwfj0vm5nqylg6WH0ArcF
         f+O5F9dDWPmDVYfQGRdbFDZMIWo2u9H80k25uWh4OVjU17/oHAvcs5ShED6w8LKwB9F5
         TvKA==
X-Gm-Message-State: AOJu0Yyp7YviIRrNT+y30X/lV5PGvMIBahsef75O7IW4AFWrDh/0oC2Q
	C+XNGJzvmyvSWlPZZ+xRT1OodtRLNRaUDpEq2oXgpIwPG6+GrSQplOE2PAlc20kxbAPXOdkE08z
	KRy1myJEpRER3brP5NsCrPvZT+QKUiUX9H5NMCYX7XA==
X-Gm-Gg: AeBDiesG2oaVrdujoOBeDYmVkvChOgiYppbgWCxwvkp5vQFFtf5Qk83em5Zn95yJur+
	yqMJ56tAeVJNGM0R8/+TvN/R7lTTl/as2XGtxetxXqXw2Oq5ioK7EOUSCuFg1AtKib0PgBrvwEc
	fj1WnAy1pM5PP13nkM+fjUQrfXIPURe+xTfoST6sYJhbImVkC1ptFzzTchP8PJLa7E0sEEravx/
	9ASmZV7Ss5kxWs4SImYf7o4Fx3uacKwnGiCWE9PdAYwW9kzgkDCXWcCjNLz7NgUKdtqt7H7HJIp
	2OR7hNDtXYrmPO2pkg==
X-Received: by 2002:a05:6512:6c7:b0:5a2:c766:13bb with SMTP id
 2adb3069b0e04-5a4172cc01dmr3031631e87.18.1776607805655; Sun, 19 Apr 2026
 07:10:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418045644.28612-4-kerneljasonxing@gmail.com> <20260419045824.0402FC2BCAF@smtp.kernel.org>
In-Reply-To: <20260419045824.0402FC2BCAF@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Apr 2026 22:09:28 +0800
X-Gm-Features: AQROBzAj5QfNvzo4HfvcWfY23xgvR6EoL_oTEqTN7mHZ9WtLplKGMNuQ-ks4tVk
Message-ID: <CAL+tcoBoKKDXKgMJucehEZnRkXOZm9EgR6RqQ2pH3SNzWDDHDQ@mail.gmail.com>
Subject: Re: [PATCH net 3/4] xsk: handle NULL dereference of the skb without
 frags issue
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [Critical] Calling `kfree_skb(skb)` without clearing the SKB destructor=
 causes Completion Queue (CQ) ring corruption and false completions.
> - [High] Use-after-free of `xs->skb` in the continuation path when an err=
or like `-EAGAIN` occurs.
> --
>
> commit 1c728000f884ce0a536d9c1fd763eb0c560ada51
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: handle NULL dereference of the skb without frags issue
>
> This commit addresses a NULL pointer dereference in the error path of
> xsk_build_skb_zerocopy() by checking if xs->skb is valid before
> dereferencing it during -EOVERFLOW handling. It also adds an alternative
> branch to handle bookkeeping for the first-descriptor case.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 3d6c6caa7ff82..2f00f188533c1 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -978,9 +978,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >               kfree_skb(skb);
>
> Can this lead to a use-after-free on xs->skb?
>
> In the non-zerocopy path, if the first descriptor is linear, nr_frags rem=
ains
> 0 and the caller __xsk_generic_xmit() stores the SKB in xs->skb.

Patch 4 already handles this.

>
> During the next iteration for a continuation descriptor, if an error like
> -EAGAIN occurs (e.g., from alloc_page()), the code jumps to the free_err
> label. The cleanup logic if (skb && !skb_shinfo(skb)->nr_frags) would
> evaluate to true, freeing the entire SKB.
>
> The function then returns -EAGAIN, leaving the freed SKB pointer in xs->s=
kb.
> On the next application retry, the code could dereference the freed xs->s=
kb.
>
> Note that this regression is fixed later in the patch series by commit 'x=
sk:
> fix use-after-free of xs->skb in xsk_build_skb() free_err path'.
>
> Also, could calling kfree_skb(skb) without clearing the SKB destructor ca=
use
> Completion Queue (CQ) ring corruption and false completions?
>
> In xsk_build_skb_zerocopy(), xsk_skb_init_misc() sets
> skb->destructor =3D xsk_destruct_skb. When an error occurs on the first
> descriptor (e.g., xsk_skb_metadata() returning -EINVAL), kfree_skb(skb) i=
s
> called.
>
> Because the destructor is not overridden with sock_wfree (like
> xsk_consume_skb() does), kfree_skb(skb) triggers xsk_destruct_skb(), whic=
h
> submits the descriptor to the CQ and increments q->ring->producer.
>
> >       if (err =3D=3D -EOVERFLOW) {
> > -             /* Drop the packet */
> > -             xsk_inc_num_desc(xs->skb);
> > -             xsk_drop_skb(xs->skb);
> > +             if (xs->skb) {
> > +                     /* Drop the packet */
> > +                     xsk_inc_num_desc(xs->skb);
> > +                     xsk_drop_skb(xs->skb);
> > +             } else {
> > +                     xsk_cq_cancel_locked(xs->pool, 1);
> > +                     xs->tx->invalid_descs++;
> > +             }
> >               xskq_cons_release(xs->tx);
> >       } else {
> >               /* Let application retry */
> >               xsk_cq_cancel_locked(xs->pool, 1);
> >       }
>
> The error handling paths then call xsk_cq_cancel_locked(), which decremen=
ts
> the reservation counter q->cached_prod.
>
> Does decrementing the reservation while the actual producer pointer has
> advanced break queue accounting?
>
> The kernel calculates available space using cached_prod; this artificial
> underflow could cause the queue to over-report free space, allowing the
> producer to silently overwrite unread user-space CQ entries.
>
> Furthermore, in the -EINVAL path, does the invalid descriptor generate a
> false completion to user space without being released from the TX ring? W=
hen
> the application reuses the completed buffer, could the kernel retransmit =
the
> same descriptor on retry, causing a use-after-free and data corruption?

For the above two issues, yes, we've discussed in the previous patch :)

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.28=
612-1-kerneljasonxing@gmail.com?part=3D3
