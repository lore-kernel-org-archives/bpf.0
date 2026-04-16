Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4515395257
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335644; cv=pass; b=P6LQLrbL208x40iLEjEBHS23XtkH4b1iN9HRsSuBDbPrO0Zz3bTBYJLS0NRwwTfa4d4oZTbUmw18U5nPpkN2PrLLEmloTH0lh8nw58ZXD/V8e6oLCheurv/Rx3B2/+4W6RNXgJZXpKjDuWrTRCa3GzcK2xrH2Wa7tdNjX1FJFvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335644; c=relaxed/simple;
	bh=CoEngbfGThM6voXC2Ve/EKJHUDpgR67a6sZvEMOPkEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lg4zsP6EEGO0mz6c2hOdByN75nXgeN2ddH+u31z+Alhdx/TftloOUguvsLFxsDKZ6R66k8feNmOOzsV3gGP+eGX0YKVApVDGrRzOhH9QjESgWldI1bF8FosDwoW31co1TWP9g8048wQRfONqczzo14iFWRN2iIvUoEpgAJBwJKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQ5Gk/Zf; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ5Gk/Zf"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38e9653b580so23355811fa.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 03:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776335638; cv=none;
        d=google.com; s=arc-20240605;
        b=MAHopaAWUu/g2fgUhGASSlEnjAMsIg8eE11yW1Pg522bnhDmCUs68XEaehfIXYJ/GN
         2v5xVq2pyA/5uFf9EXdFvsxVLtVycVWE2m6mcBjrdI/+Adv5YsotsjTgAveqg+v/y3rp
         TjLmzfyFZCROjlRNPSlfHneWA/5OY5xcbK9YhPDKz8s7rlQ9tdRPJMn4s1652lcflXv5
         oHhjyFR18DsCCzrdcujbCuEQLotArTefGXKo7qUjvzm9J7E84bX7zxxT9xbLAdkmtcrq
         1w8gYzQIn7jJzW7TQLG6gXupa6S2+SssB09E7M64nrU6cv2YLuzJdWQihbQLhHNHwYLB
         tl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0nTgQLwO4XWmQrOPU9AIkASPB/0Kzhu0tPVLZll0cdU=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=hpmnVyXOnuygiDpmkI/LMN46ceoattjFhcu1abYHYUiEm9d1FKkohjIs34AEzmyZGI
         Zsh3pmS2I1Sj7NnuIxuWSbFvHA/biNmUuFqGqMcCW/nuh74wcmzFPVGz8bFbp58H89dO
         WE/hJcIIoAn4QzVP66XtF25HWpGqjAoVKGjq7wp7b6p6RbqfbLF5P4L1myuBtVF+Hbu/
         zbNmz+HBMtM2XmxzDt/DqbCuiSgH7CKotX9zcG/3S+Do4vs+e+LTGwFENgcjAlf+CBMy
         AGxdo8+SsTlC6qcWMDY2OKLjtmpotCsyerZICD2w98nmpWuEA/ZGpNbU3SUeQH7ukj3f
         5pwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776335638; x=1776940438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nTgQLwO4XWmQrOPU9AIkASPB/0Kzhu0tPVLZll0cdU=;
        b=rQ5Gk/ZfLW+TGnCCip1QsGRYGmu03j/HJgnxsHahG0GVbYDxM0MqtQZ+muE952pO5h
         BVB8lwZkhZwbV2ZUNPwCQADTrPnTrxR0GwTSMRu0lJimEcfvYs71S7Kq2Ne7wGvOvNDD
         IhAls8b7mW7PZGT7lRQJMrY4IBqPH9Tt7ISEft97tLIkLwd41Hpt40GhHHXxm1BZ8KwE
         ThDw8fLTEcjq4R2H5v9JanbzvJNaqk/rBcugaZ/7V5eiyNUpYh+X8LfSPWV0p8i5YNb7
         TK4lFYAfGkwZEu3nR0+Dtsqr95lLlMAdK9KjXyT9DihJPO3McYyWqloHBcyP0wdWmLgn
         UKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776335638; x=1776940438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0nTgQLwO4XWmQrOPU9AIkASPB/0Kzhu0tPVLZll0cdU=;
        b=bzN1fMIcNzUAKgQtpNtJn22lLfaE2R4ji2xf+92kaVlXnz0YIntKEU1rwrWTqhPFTB
         0n5ZDYa6WvH8LHVLgRGsl0GH+C+ocN9zKgtJpYjYfKgO8UMoiROh3EC3Z393hR+7yBGU
         Mg5U8IXq1MH47GEdiu5D9iWIYilVeJtsn3nuKBSOx+7ROrWwz4vw4qeGdPcYQ9X7CQKs
         04VzHjr4H40wlcIqrE4CezeAK4yO6Uk6cbElLVg4uSrOFXhzd4QAyS920dcXP8SvjkTa
         cKSI+W/lYdJCV5ePli7O1YmM/JOzz5ZRcCX96i0KJrdH0PBADSNFPw1+YzV+8dhPNMJe
         pOGw==
X-Gm-Message-State: AOJu0Yxs7HzTs0gCytPxHZiJ5snn14v2I7pCzy81Snx5YtJ2DCR4F94A
	o1yx01PTiuJwazfyAErPvSzcNttvvgrKPPbIfZSV8REt/8ZTFEmkwc9Lwjm39spc5aJ8/2J1rMG
	rixSM8+vlDSCmw/4QyShNGzEkma/CWgQ=
X-Gm-Gg: AeBDieto0g0O3cknGHNGRf3zjWFACnZubCogOEFrhVPQBnMu7tqAe79KTHfkxbugiLv
	ZSf0nTu9Vrq/lE1GuLJvTJ8ul5aE+tAbEgbbTd8RopiwUv8h5LqbVm6FA7X07xpnbdpUz4Y9qRu
	Yh04+1BNirZRyzTSpc2r4i/75aQObLo7L7thrsa0aryw/so5kxKrVAx8R0qADErv1UfJZl6Piyp
	IYN23W+tgnt+XUgWT8LhvAykgLkncjEdzyseqee9xBeBSrsBlLJWlnNyb90yebBWby+J4mXcNG8
	51ILvIv9Xi02XO1Uoek=
X-Received: by 2002:a05:6512:33ca:b0:5a4:6f5:6c4e with SMTP id
 2adb3069b0e04-5a406f56e25mr3030132e87.19.1776335638365; Thu, 16 Apr 2026
 03:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-14-kerneljasonxing@gmail.com> <20260415091844.D4344C19424@smtp.kernel.org>
In-Reply-To: <20260415091844.D4344C19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 18:33:20 +0800
X-Gm-Features: AQROBzAy1ikrX9HTmdqDFHnMTttP_utyWxP8-57oVu99OuknjT1EKSH2prAam6U
Message-ID: <CAL+tcoC7_UA7SQaufDkFV2APJW2UtaX0j66N=sYF0nNZJ2zASA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 13/14] xsk: retire old xmit path in copy mode
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:18=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 3 potential issue(s):
> - [Critical] Time-of-Check to Time-of-Use (TOCTOU) Use-After-Free (UAF) v=
ulnerability on `batch->desc_cache`.
> - [High] Leaked socket structure on error path in `xsk_create()`.
> - [High] Unbounded `kmalloc` size for user-controlled batch size triggers=
 `WARN_ON` and potential panic.
> --
>
> commit 5f2cebbff2efe715b882067f337741749751ac65
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: retire old xmit path in copy mode
>
> This commit adds a new helper xsk_init_batch() with a default value of 1,
> and obsoletes __xsk_generic_xmit() by substituting it with
> __xsk_generic_xmit_batch() in the generic transmit path.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 16e47f6fc30ec..232e7bf96b342 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> [ ... ]
> > @@ -1030,101 +1030,14 @@ static int __xsk_generic_xmit_batch(struct xdp=
_sock *xs)
> >       return err;
> >  }
> >
> [ ... ]
> >  static int xsk_generic_xmit(struct sock *sk)
> >  {
> > +     struct xdp_sock *xs =3D xdp_sk(sk);
> >       int ret;
> >
> >       /* Drop the RCU lock since the SKB path might sleep. */
> >       rcu_read_unlock();
> > -     ret =3D __xsk_generic_xmit(sk);
> > +     ret =3D __xsk_generic_xmit_batch(xs);
>
> By switching to __xsk_generic_xmit_batch(), does this expose a
> use-after-free race with xsk_setsockopt()?
>
> In __xsk_generic_xmit_batch(), the local pointer descs is assigned
> batch->desc_cache before acquiring xs->mutex.
>
> Concurrently, a user can call setsockopt(..., XDP_GENERIC_XMIT_BATCH),
> which acquires xs->mutex and updates the batch size via xsk_init_batch().
> This safely frees the old desc_cache array using kvfree() in
> xsk_batch_reset() because the setsockopt path does not check for
> xs->state !=3D XSK_READY.
>
> Once setsockopt drops the mutex, the blocked __xsk_generic_xmit_batch()
> thread acquires the mutex and proceeds to use its stale descs pointer.
> Can this lead to a use-after-free write into the freed descriptor array?

Ack. This is the issue we've discussed previously. I will move those
read operations underneath the mutex lock in
__xsk_generic_xmit_batch().

>
> >       /* Reaquire RCU lock before going into common code. */
> >       rcu_read_lock();
> [ ... ]
> > @@ -1620,6 +1533,34 @@ struct xdp_umem_reg_v1 {
> >       __u32 headroom;
> >  };
> >
> > +static int xsk_init_batch(struct xsk_batch *batch, unsigned int size)
> > +{
> > +     struct xdp_desc *descs;
> > +     struct sk_buff **skbs;
> > +     void **data;
> > +
> > +     skbs =3D kmalloc(size * sizeof(struct sk_buff *), GFP_KERNEL);
>
> Can this trigger a WARN_ON_ONCE in the page allocator if a user requests
> a very large batch size?
>
> The size parameter is controlled by userspace via the XDP_GENERIC_XMIT_BA=
TCH
> setsockopt and is bounded by the TX ring size (xs->max_tx_budget), which
> can be quite large.
>
> Since these pointer arrays can exceed KMALLOC_MAX_SIZE, should this be
> allocated using kvmalloc_array() similar to how the descs array is
> allocated below?

This is also what you pointed out. Even though I thought it's trivial,
I decided to use the _array() to keep safe.

>
> > +     if (!skbs)
> > +             return -ENOMEM;
> > +
> > +     data =3D kmalloc_array(size, sizeof(void *), GFP_KERNEL);
> > +     if (!data) {
> > +             kfree(skbs);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     descs =3D kvcalloc(size, sizeof(struct xdp_desc), GFP_KERNEL);
> [ ... ]
> > @@ -2065,6 +1984,11 @@ static int xsk_create(struct net *net, struct so=
cket *sock, int protocol,
> >       if (!sk)
> >               return -ENOBUFS;
> >
> > +     xs =3D xdp_sk(sk);
> > +     ret =3D xsk_init_batch(&xs->batch, 1);
> > +     if (ret)
> > +             return ret;
> > +
>
> Does this leak the sk object if xsk_init_batch() fails?
>
> If xsk_init_batch() returns an error here, the function returns early
> without calling sk_free(sk).

My bad. I should have noticed this....

I'm totally getting lost in so many checks and conditions while
refactoring the xmit path...

Thanks,
Jason


>
> Because sock_init_data() has not been executed yet to link the sk to the
> sock structure, the VFS socket layer will not free the socket memory when
> tearing down the failed creation. Should this path clean up the allocated
> socket before returning?
>
> >       sock->ops =3D &xsk_proto_ops;
> >
> >       sock_init_data(sock, sk);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D13
