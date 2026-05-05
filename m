Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7323BFE2E
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009359; cv=pass; b=sPf+iezmg5r75VhvIeOJripft/2lrOGZly1n7/SKxjzu4L8sr7iUK8xEqYMbxQYsZvWAsmQK3xA3/lllCJu/FKEtbsyKHiKyU132higaMvwhpnfxkTlz7C7DCCdy4M0XErWbgYNn2xg7fRdATCYsRNBaMGgsMLynbLjsDKXYRhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009359; c=relaxed/simple;
	bh=MaS6G6QMr8iufTVyCEqfjnn6L+b/M/zJdMJcnI3bCqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HISorjCBzEvh4p0Hs/NA0jwZn3/9fPPka2SkbygvvH63I6yZ7FrrQNH83jUOxjWEQL48GYHECfxicQ/eZAGoNjnxKm52vRe57endQgAzcB7gktyW1aTr4KmmN01ARiKpztYuQEk5FGzpZrvajpPpX1EgQqw3oewN23wytaM3k/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLaV9yH3; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLaV9yH3"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so6527126e87.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778009356; cv=none;
        d=google.com; s=arc-20240605;
        b=hbYH5CGPRr0Lx8pMbQeVey7RDaL9eADpfIdxBj1Rhu7mY148DL5mSwag/chgVcx4ef
         eIBYXOBBgM6ZF1tK1CVtiVcJJyqYPuDXaYp4sJLq2QwfBaGkwv32QOPIkepnWBEh8ZQE
         hUMqyqSuRwINMqWNSFwHdHNV36+5o4tKy4xm3hTC4AxKkYlozFMAqwCjzJn2t2AGzvOU
         2HpPrleY3gJEDAT8+SdmnLe3Q+bzgwEwCe+bjAMvjQ8SmRUi8DVo5c3WzTluNRuPu3vC
         1nuh3BkXUCZWj2gE+MDGo3rrIYKrUlBjXCZQb7g5kC8wnxEdiIic+bEjB48kY87bvl+J
         4/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCpz08/sZPNZFx4FQ1Kj6Lyi+Lgvsbd/LrhdJVqAP6E=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=X0U7sr6Z91nI8gwiASdPstBNQ2pPCPuPEGo6K2D/tb48oGJA7tFyZIVvitgn5soSAf
         f49rffVU3W0ztPZMdoS8oFdZdnD06Bw41yrmGVyB5MKPmdUKSl125usUxFO9OY7Xylxa
         knYv/w8mpdL/g14i/AVRGzMmSRAVfJfuAYncBRkp4U5nI7yk4tLfxsuxkvIZ/yzjblZF
         hmKbAkHIOi+8Hay3xKHPvNHDqmRKXqnmDjNYwc3zXUXSS1UbXcksq8XBuDzIMDRzUJKh
         tCT20OYw9I3wTlf45DPUgvfK3oYb0UosGjpw3ZkOqZs6dTLWtdwO5PfRSJSkBmStotwZ
         2BGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009356; x=1778614156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCpz08/sZPNZFx4FQ1Kj6Lyi+Lgvsbd/LrhdJVqAP6E=;
        b=QLaV9yH3Jj7hP14h574vjNIurg7M3FqTpm5LeBihT+b+9P1g+OYY8QNt3T+5deXif8
         R8hoF4HwkWXnI4G9j0Y/mbCsyxD6Zgolmz5WzyKHjoVbmLCXthra/om+PhTiAeWvmUDW
         tM0Dbvp3tokm1Y9mOtihO68z0Y907E8JOP63Twb9eiFMe7JjfY5aZh/eTD5Dv7ajEHk8
         D3SvHq+723FqroDS5YGziabkzIaeSJDhInP/OkYqw55rUamEVmqtHkUCr11X+1eJYaLl
         gsMT0islUJNW4CwrehePDzBY21DqNZ+1dLGwfnDqRn5XAOYCKjUauVjGUIGXyBv11GXG
         bA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009356; x=1778614156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCpz08/sZPNZFx4FQ1Kj6Lyi+Lgvsbd/LrhdJVqAP6E=;
        b=IvVAJR7Dbl7PgsxA2Yj9zXxC/bR+nJDeMIfPbiZ9E5sRIFCwGX5Pmg8N3qQeObvGrM
         atDiU8mLuDxd3TFzzC/BW4hl7ozM62O/masEpPv7Qu0cJrivz4WLdiJRXGjW16bzvIwi
         wrixiErnXiWzHsU7xuqaFcAfOhhD5E88uLN/1JNKMyVwKsgiA0+YgxXYdONtzfsanHTZ
         WhdE0otXBMmzGQAooACorKz7eORSik+yjZsz+RWGXxB4dKZ/kYqq708gJ2W6VZepsAH2
         vS0P7K9IpWkNQweCJ06Fn65Gw3r4zYUIlpc1IIdWFJ8QQ8wdbsfxCsM6H3SPZFCOKIK9
         n34g==
X-Gm-Message-State: AOJu0YzmB05IIbiIleGocSWGIgkYpdzdx5jHDuAUMRpJRCAPwpR9SYNo
	ljdnBYv3XuO0NeTd+jatPKrGOpc0HHRFSZoGlXDaDYusm3wBlj7W00RDr+oDpe9kBzBx1Bp4Mqb
	s0BT2B4BNUNXZpXUj6IjWOqrAG1a6vsvICos4BSTAww==
X-Gm-Gg: AeBDietLDkQn4FomsvBdvd9b8Gj6ZTpHK65raqCZz/gWOAGF4qYSoXBM0H5nAWh6mqJ
	+0HbwFVAUV1Ra9jJfW4ZSnUfCVkTT4FytLsGA5Lig1deVBe+2cVTFZjnIGaooA8DGHbb3R6j+kR
	bU3fm/tbFyReV/m8whW834QvAc6567bZBaD2FCxzV9Ej2LYNEG/vS1ALanRTwq0dKMnGx3hLx+I
	0FD0Dl6MgUNICuRd1nerCqodbEhzr/oXtBMN0ifj0yxsM2kn1PCMj5N7sQpEZKfa65set4RGhX3
	vNhBcVqfKSF7LohqGYXDhiiygVRyYKuxKumZPBujEzfNDs0Uo13l+83F5LI=
X-Received: by 2002:a05:6512:1393:b0:5a4:1133:c30c with SMTP id
 2adb3069b0e04-5a887ce6168mr22854e87.28.1778009355336; Tue, 05 May 2026
 12:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-4-kerneljasonxing@gmail.com> <20260503200925.1AD38C2BCB4@smtp.kernel.org>
In-Reply-To: <20260503200925.1AD38C2BCB4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:28:34 +0300
X-Gm-Features: AVHnY4KMeGDD8WweymcVYm-GlzqgazHmgRb3taJk12TsKeTT6A7WVqgXP3F06Co
Message-ID: <CAL+tcoCYgJsgmxvHCJj_-2R=UcV61TRT_ghS87eZV5H8154cYw@mail.gmail.com>
Subject: Re: [PATCH net v5 3/8] xsk: handle NULL dereference of the skb
 without frags issue
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Completion Queue (CQ) state corruption when handling -EOVERFLOW =
for the first descriptor.
> --
>
> commit 819a57cd3753db9f503ac093f83dccc180da574d
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: handle NULL dereference of the skb without frags issue
>
> This commit fixes a NULL pointer dereference when a first descriptor
> triggers -EOVERFLOW in xsk_build_skb_zerocopy() by adding a check for
> xs->skb. It handles the first-descriptor case by manually canceling the C=
Q
> slot and incrementing invalid_descs.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -976,9 +976,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
ck *xs,
> >               kfree_skb(skb);
> >
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
>
> Does this cause a Completion Queue (CQ) state corruption?
>
> When a first descriptor triggers -EOVERFLOW in xsk_build_skb_zerocopy(), =
the
> free_err path first calls kfree_skb(skb) just above this code. Because
> xsk_skb_init_misc() was called earlier, the SKB's destructor is set to
> xsk_destruct_skb(). The kfree_skb() call invokes this destructor, which
> submits a completion and increments the ring's producer index.
>
> If we then call xsk_cq_cancel_locked() here, it decrements the reservatio=
n
> index while the producer index was already incremented, breaking the core
> invariant cached_prod >=3D ring->producer.
>
> This causes space calculations to underflow and can overwrite unconsumed
> entries in the CQ.
>
> I see this was addressed later in the series by commit 88b75ff1d12b ("xsk=
:
> prevent CQ desync when freeing half-built skbs in xsk_build_skb()").

Yep, it has been resolved in the series.

Thanks,
Jason

>
> > +                     xs->tx->invalid_descs++;
> > +             }
> >               xskq_cons_release(xs->tx);
> >       } else {
> >               /* Let application retry */
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D3
