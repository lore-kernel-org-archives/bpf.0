Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE1139D6C9
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334197; cv=pass; b=JpalSlve3HWjD5sCMmKFMGYG+tgI/Oc0kjs4SAd3nRtl02h23SBbCxb6VeKqzzfcfqn/x0Ql4mbnMwatmKF0YIUVaWHT3gcUbRGOuvioh9k2HA7o/Xa0cYUFoBest83HSmLeifp8c2xri4ry2QR2stvXVfrX8THfnOuf97tq8aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334197; c=relaxed/simple;
	bh=V5RGcaWEQIL5doImkPYBf6NSUr8b19d+JjOqnGw7u5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vq72OAP9RoXBf0wLEqJkYZRA1IQASXCzhDHpwL0HTIGHeSUKeCoiHkWFnrL8WUS/+Hh7J9RLR/f/zN5eDKropsbYCKdcprnT7o8MZmAoU8KZkzJBTsnIGTLPpPD6L+/bX9YV1bJ7sKZQZXXCSmMlAEQtTWu99MsnGCVSD4aXJXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYx6KarH; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYx6KarH"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so7984826e87.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 03:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334194; cv=none;
        d=google.com; s=arc-20240605;
        b=I7+2sdBm+T3cRctrfT37QWcy5XrH0rJ1ffmYAN5X7bN8a3/waJ0EgCmuNTw2BL60Ye
         QDM9euKLnQG31FagjyoxzoQCUyfpxCNgu9Kbta/jzh24KtpL3t/Lt9Tf+5SuyU4tchei
         R2yvarTOf0OogEgvfk1LNjh/Njtm4Fd7K1XXfUf8Z6iGXexIyJgRA0tarI/UWY3Z6rvj
         2yGnQiEXoUg7WFbgWAey/Pga8OXRlraZpSbybhj4qsTKUr3uFPEwOCccImPCoLgEcwEY
         MWZmqe5h50mLTXHWvH/BW2n7IEaKIJMJTSyxM1D/0k9pde9QL3bB5QfRDlaOskhWihMp
         fbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FVWfRblvx3Z4ePRIGccQORQmFn391UgUUAHT2x9HlvQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=EKvm7QDqbgVY09vAnU+xaDngzTF5mJP6iyKaXN2V7GPKjhtGBKTyWyhELfEzahqu+5
         5qStupuFhS8fDqwIxMRKlQUxvONeb8Ac5sAICS0HCVPUNPtLS4knMbOMOUYMaBYzEnay
         /IU1dleLArt423UbXr9KA/eE6JA1cxQNz3LNizCt3bvNfQb9auF49HiSepBnGtiFFZkX
         wl0GSuNA+EajCqWEbHaKYpxeWYKUnoFPpG4ChK4gq3x2iLv9Ep3/SzTIhFkpNDu7sSRi
         qFEiEGOEU/3QvXxtcwXjlfJZZs82Coy25/zPFVk1gkvzIS3AA4EcUYFnu8wS6OXGjSiN
         UYCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776334194; x=1776938994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVWfRblvx3Z4ePRIGccQORQmFn391UgUUAHT2x9HlvQ=;
        b=lYx6KarHLB6OSxLZN73w752HXVMaJWqX2MIhY0LNfjW2j0bc2G9NFm/TSNfYZEoNJG
         mt5/S8YrJ5y3FuZLlFhmr30wsdk9k8k91x982TyUPgW/L9iZVsCFux6YwmCaz43XW7S5
         poOZPnCDU5ujMBBwgdyouOX3R4zromI2lJ63QYOw395oLXMXyZs9KKrdbjixvnIRKm6E
         lpJZk9DSahUn2XJVWM6II9Lh2Y5wmIOc0uzCDE4OAoPqrSC2/stq+J1mAxfibuC5tutl
         ukOvT/4mlx2i9VIrbxfSjMZAfbM/mNtHbu3UK1a0fQo4ON9VJZ+C96Jjh8hLljSVJeex
         6ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334194; x=1776938994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FVWfRblvx3Z4ePRIGccQORQmFn391UgUUAHT2x9HlvQ=;
        b=WWVAwH9LcnkNhP/UUC7HeVqDxLPx4i9RdY8RxL1rL0cQM8Gx82n9soLWd9HiwCQLMi
         XMnqLxaBnTMsxBj9xOA8PrR+EOLjjDAgTMAFasjsmHnKL9OTm254+vi5G/HfZCO4sI16
         TkmJ8lGd8vtQeMAQ3oZCsix77MuYO+D6gXk8czAuiRnJgfzE7nJbYSwSkkVUO5yTWXwF
         I57nk2ZTu3hcCVT73NNMyOa17aYdYZ5LusBkFHllF1+FE81evrrUaVqB4WDLIjw30ofS
         6alf9JQVXl3EV969YBtyu3YBKzB2l2IX5gw33yIvP5LqKpA1XyN4+5+XG0kSxh8DCbzT
         W11A==
X-Gm-Message-State: AOJu0YwaKFaZ6Zr0J8XEvm5qpmS8YrM8PtNXe+Aa0k0FIkAyRP9kaEQo
	XO7OpDkDQ1cKGp4Fwz1eZEv167pSXYCOta1Sc94pwlFdmnMRW/NwWahaSxoz8JY35+TNr238/iu
	X+p4zw5sze8btfwrMHHro2FOpclz2mOQlRXY/3Ik=
X-Gm-Gg: AeBDieuQX5VwrM84LzgcSTfm3dmVzAD1k8ZJBFjwp45sGboV+psr3w8mmcxcxhBhoqs
	t+zB2SSXCh6haGMtoGTcwpZw7JtrJZR5USJuz7MfL+cf8wpb6Y+Oy4AG951HNRuj9xqZw4g9juf
	1uqO4tsh8fEFty+30MjDrO8yRBTHraH+wEmp/H/sNaeqmGnbX6fmWxL1qVdQA6ANNXxGjxdklJP
	TEEO+YqcJRZm7PwiBTlmTuReiK9tZ92fYQrl8oQuorObZWPcFvyfA0WWXbYQERyW1LKSQ3+C0Cp
	ppbsYAoGmSgqO0hMp84=
X-Received: by 2002:a05:6512:318d:b0:5a2:b3dd:7a74 with SMTP id
 2adb3069b0e04-5a3efd80785mr7750378e87.33.1776334193996; Thu, 16 Apr 2026
 03:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-13-kerneljasonxing@gmail.com> <20260415092053.72D0CC19424@smtp.kernel.org>
In-Reply-To: <20260415092053.72D0CC19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 18:09:14 +0800
X-Gm-Features: AQROBzBBDqxdhhkKTcZFySjG129qLX13HxyAcVjcvEObyfW9fJCS_Xie0-Tfgck
Message-ID: <CAL+tcoDJBH76L_b3NGGhaLMAEMLP2SqEgNBYtqRz006naBoX0w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 12/14] xsk: separate read-mostly and
 write-heavy fields in xsk_buff_pool
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] The patch groups NAPI RX write-heavy fields and NAPI TX write-he=
avy fields into the exact same cacheline, introducing severe false sharing =
between RX and TX CPUs.
> --
>
> commit cf39ff4311089098b2e57c37ba6e85e7a36ac4a8
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: separate read-mostly and write-heavy fields in xsk_buff_pool
>
> This commit separates read-mostly pool geometry fields from write-heavy
> fields in struct xsk_buff_pool by adding cacheline alignment. This is
> intended to eliminate false sharing between the sendmsg CPU and the NAPI
> TX-completion CPU.
>
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index 0b1abdb99c9ea..0376bd4cc95b0 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
>
> [ ... ]
>
> > @@ -73,23 +73,27 @@ struct xsk_buff_pool {
>
> [ ... ]
>
> >       void *addrs;
> > +
> > +     /* Write-heavy fields */
> >       /* Mutual exclusion of the completion ring in the SKB mode.
> >        * Protect: NAPI TX thread and sendmsg error paths in the SKB
> >        * destructor callback.
> >        */
> > -     spinlock_t cq_prod_lock;
> > +     spinlock_t cq_prod_lock ____cacheline_aligned_in_smp;
> > +     u8 cached_need_wakeup;
> > +     u32 free_heads_cnt;
> >       struct xdp_buff_xsk *free_heads[];
> >  };
>
> Could placing these four fields together in the same aligned cacheline
> introduce new false sharing between the NAPI RX and TX CPUs?
>
> The fields cq_prod_lock and cached_need_wakeup are updated by the TX
> completion path.
>
> However, free_heads_cnt and the free_heads flexible array are heavily
> mutated by the RX path during buffer allocation and release.
>
> Because cq_prod_lock (spinlock_t) and cached_need_wakeup (u8) only consum=
e
> a fraction of the 64-byte cacheline, free_heads_cnt and the first several
> elements of the free_heads array will pack into this exact same cacheline=
.
>
> If a deployment pins RX and TX interrupts to different CPU cores, it look=
s
> like this might cause continuous cacheline bouncing between the RX CPU an=
d
> the TX CPU for every packet processed.

It's not introduced by this patch. Previously those counters were put
in the same cacheline.

But the suggestion is good, which inspires me to separate the tx and
rx counters at the expense of adding more bits of the whole structure.

Now the problem is gone:
spinlock_t cq_prod_lock ____cacheline_aligned_in_smp;
u8 cached_need_wakeup;
u32 free_heads_cnt ____cacheline_aligned_in_smp;
struct xdp_buff_xsk *free_heads[];

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D12
