Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B0637997E
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341967; cv=pass; b=JcIDfyBgQMgAX3hV9khcqCYgDd1k22roXQV6JMg3xTu6UcBUFlRNCDsYel74jNHbBqh7gKvmkuHmSXkyUADei8lGw7vnQge83dU7IduUEm2c/TctaifWQ3xpRl60tDzitX7pszk0fmbEBfGyeQSY8LvhOdQ5pPoPNIUpavNVvSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341967; c=relaxed/simple;
	bh=tUtN6Xxl6/8ZUOe0081FLqroxi56blaLuoccETQ6u14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kw2wcxrl6TruvicaXIT4DiWiSjgbg3qJNg/hNUvdJO+uXzE4jw5/z4fzPxTCzL8tTv2m/tFs9UWjUWXIuyoVHpY32CqOGvurktcMGatAgXTN7rD2j7BOP71f60cfYfoqthpbV2gcUQab8DYVJ6cyLn+DnYV2wWlOfWC3NkKsVo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiREAZhb; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiREAZhb"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so10675482e87.0
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 05:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776341964; cv=none;
        d=google.com; s=arc-20240605;
        b=HW/0NThZ40KanRV4oQ99/jn5Gw71Ujah45z9rNu3O4blyBmBSkJC45SHpecCFWvVtd
         XdR403NSndiCihldnMCb7pj8+gmShVqqViyady7BZdOcAq22UoCMaY3rWWZcE+5t4x08
         VIerW8dFc5vVBAi3fSrecXjsKs0GDLE7O+wOIsHzhHSrGo/yxTifQ/pD/hqQBAkgpPGz
         JsQ9TYiWWBij94PJF3MloeUAekK8v4MOUO9/KBW0lWXtoaB+OxoMRTN5ygAiO8mm5pPi
         ltFUecK1dK1eMj5WzoZVwA701aMdL5cbI5cy3TEDLVm7TyNkojaD3R4BxisMFS8gMl1y
         H5CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ILKzf2TXIFnuxQeSOZRYDomaIK5WqLDrf3a3oWRfbEo=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=WSIT9N2q77xge1lXKyu6gaMiASvyRb0jZorWs+H5pEkAgmQpqRfKcYvON/no2s4GSl
         tnLsjDQsrgYcoCLfwPX/VUL0y3o/w7WqqwNyNGOLOIMnNP71jEQe/946wZFBV2mRxfIH
         nMN/riurmqgDUBT4seSBjFhVC0iE5+mXwXmjRrOoLQXs8OWFCx1jNxULoGdr/luwNvrG
         7ujBgoCNX67Ig4rVQ+aVRP9D/zgWkcRLt/By3WzLCYMo3xePYx+fXPML5e5sJOLO1QFi
         pCblTGb0tYYKj/8cMKK+/4y/vSLrAOYEzwIJbTgP+k+wC8cRV9uolH2VAxxqOx6+/Gen
         Q7UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776341964; x=1776946764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILKzf2TXIFnuxQeSOZRYDomaIK5WqLDrf3a3oWRfbEo=;
        b=BiREAZhbkW+8bOdZ3xFO3Isc6V+A5bTUqqZ6s0vvU0k2KW/yTIfxgXgF/iQMmAUoo9
         BWj/ePcm5qLGfLCILTNpLHVnIZF50VqhZfAxrj2/ZyOTGxEK8Q6O44HKCxbA/JTNlAR5
         0O0zIJmdnCThHCbSBZKrkjZhaSPXGeL4Y2QyT6SfR1QhLPpybrQxN0KSO+G+nIK1YIC4
         T7crnYEhbMFV91s5li2xHpwPL8sTQtRmmGq9ud8bgwFfizcFVkD3VVtXdipElQBjuL77
         nOlOzfgThgXzW+yuJ9Kj3gJKBDw37Je+d6yfcoZgaIzVMeBqfLKS5949SxizGai82jRy
         XrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341964; x=1776946764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILKzf2TXIFnuxQeSOZRYDomaIK5WqLDrf3a3oWRfbEo=;
        b=DuFqfdM3f5Nu/EyccJITOQRKAgkuv5nWmjbPFJExkdYiwT0dcZySeqSaPUuvMRupLn
         TvR5gAiajRsLgs6pWVYS2e1Cuf8JG9sjh8qTNksXRsYC8Gb2XKMAxUNZ5BOo1FI1Fg5N
         dvSqV0gpAdiQgJiElOazHvqQvN9jPVdhoNwHal5IAS9yO03IPFNXHzldk1pMb/q7aUbc
         uxJLk6ksFAAQu2sGIkdfSsGalavnxKT8vcF+/zLvuvc8mXQ8N6hYqly6S8BZU4OkwcRv
         Nnzj64rSDIFmtRGiwmjcAcjWZ8kV4H+KSPeOKj20h56lpzDbqXVoNk5BcT1oeXOBHYha
         vDiw==
X-Gm-Message-State: AOJu0YyaXpw+D9ONgyn5+6tfsDccJftqhMTes1dzm5VK0MTj3g0Xyqlw
	jT7HN3fBPZC7KxDLJsHBvEuHcqFr77stuVgOkzhLgf5iZN0JLf1eA6m4xTdzrYScXRlgqxr8wHb
	k33aLjkkGwRafs4xtF4OuhJ1Atfh5zaYRBWwBJ+Y=
X-Gm-Gg: AeBDiev6oeyIkjPGEP9OhCcn9nwEqauNrh1D8nx3W2UMzLRRwYuFpFQqL5lzMb6wrKL
	NlA/SvyYjFPnaF/8ygBrrrP8HCuzr9qzs2WDuQwoZ6hmG5UJONBgJ2U2ZKratZWakpAU70I8CfT
	GiCf/WMa0JBYAPF+Lr6iOznJ4xOY7q3DiT36EljlTmOrPxIoyCVhn46XlFB7oAR2Bka9N6PZnhE
	zI8la4ClQ9idnd4XruGsPo/+OcmAuyhzFAP58eGq0vmraS3DgDrOdGTAMWIx0NgKKQpEDz16ZRp
	ICUJrqJrzWUrnh5tCrQFfeeGYGNwew==
X-Received: by 2002:a05:6512:3192:b0:5a2:bb8e:d4f4 with SMTP id
 2adb3069b0e04-5a3ef906681mr8036490e87.15.1776341963805; Thu, 16 Apr 2026
 05:19:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-5-kerneljasonxing@gmail.com>
 <20260415093822.79A76C19424@smtp.kernel.org> <CAL+tcoDbMq9s5tQkpBQfjWZGajUtJxhYzxJ9vD-hpq7uU3RYNQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDbMq9s5tQkpBQfjWZGajUtJxhYzxJ9vD-hpq7uU3RYNQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 20:18:46 +0800
X-Gm-Features: AQROBzDX6UeNBNYFxkf6uUL0MhYAcF7vDabM4TqiAgTIdXevyhyLpwRjeOgewnE
Message-ID: <CAL+tcoAvMFo848fHqgCbTxrA_mt71DcRAuD9WEfSsBgdR7jrvA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 04/14] xsk: cache data buffers to avoid
 frequently calling kmalloc_reserve
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 10:45=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Wed, Apr 15, 2026 at 5:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Sashiko AI review found 2 potential issue(s):
> > - [High] Cached data buffers are consumed without validating current al=
location flags, potentially violating memory placement constraints.
> > - [Medium] Meaningful code and commit message mismatch regarding cache =
refill logic.
> > --
> >
> > commit 5a442e9c44f0a64a147908843084cffe5e2fed9f
> > Author: Jason Xing <kernelxing@tencent.com>
> >
> > xsk: cache data buffers to avoid frequently calling kmalloc_reserve
> >
> > This commit introduces a per-socket data buffer cache for small packets
> > to reduce kmalloc_reserve() overhead. It adds bulk allocation from
> > skb_small_head_cache and persists unused buffers across batch cycles.
> >
> > >     Inside the Phase-1 per-descriptor loop, when a small packet needs=
 a
> > >     data buffer and the cache is empty, a single kmem_cache_alloc_bul=
k()
> > >     refills it with generic_xmit_batch objects. Subsequent small pack=
ets
> > >     pop directly from the cache. Large packets bypass the cache entir=
ely
> > >     and fall back to kmalloc_reserve(). Unused buffers remain in the
> > >     cache for the next batch.
> >
> > Is this description accurate? Looking at the implementation below, the =
bulk
> > allocation happens outside the Phase-1 loop. If the cache runs empty du=
ring
> > the loop, it appears to fall back to kmalloc_reserve() for each subsequ=
ent
> > packet rather than refilling the cache via kmem_cache_alloc_bulk(). Cou=
ld
> > the commit message be updated to match the actual execution flow?
>
> Will update it.
>
> >
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index c7e42c2966cdd..3b3969adfd23f 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > [ ... ]
> > > @@ -709,10 +718,17 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u3=
2 nb_pkts, u32 nb_descs, int *err
> > >
> > >                       skb =3D skbs[skb_count - 1 - i];
> > >                       skbuff_clear(skb);
> > > -                     data =3D kmalloc_reserve(&size, gfp_mask, node,=
 skb);
> > > -                     if (unlikely(!data)) {
> > > -                             *err =3D -ENOBUFS;
> > > -                             break;
> > > +                     if (dc_count &&
> > > +                         SKB_HEAD_ALIGN(size) <=3D SKB_SMALL_HEAD_CA=
CHE_SIZE) {
> >
> > If the socket's sk_allocation (which populates gfp_mask) was modified t=
o
> > require restricted memory placement (e.g. __GFP_DMA), could this code u=
se a
> > standard memory buffer left over from a previous batch?
> >
> > While the bulk allocation check before the loop correctly avoids alloca=
ting
> > from skb_small_head_cache if KMALLOC_NOT_NORMAL_BITS is set, the
> > consumption path here only checks dc_count. Does this need to validate
> > gfp_mask against KMALLOC_NOT_NORMAL_BITS before consuming from the cach=
e,
> > to ensure memory placement constraints are not bypassed?
>
> I can add the check but it seems meaningless to me. In the whole
> implementation of xsk, there is no place where sk_allocation can be
> set to a different value other than GPF_KERNEL.

After a few rounds of investigation, I finally gave up the idea of
using KMALLOC_NOT_NORMAL_BITS. The reason has been explained.

Thanks,
Jason
