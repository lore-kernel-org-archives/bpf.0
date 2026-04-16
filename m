Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB361EEE6
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 02:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776307600; cv=pass; b=lXxA7vRRxtWmOV1061QsNC2IVVG4AGKCRT9X53/bfWHMqdyMsdQBMScMjzRb8fsSVLmC3YXGB8liUBxar/8n/2l06F87TgLKmbsVpjG/AZ94axKTyO3etUI6YJ+IB5he/6SvdRmsD9SAfK5UXT3Ijn5M2vMXF0Ypp7TzD/hqyrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776307600; c=relaxed/simple;
	bh=jzqWozEUYYFZPS/6kekndzo0Rcu/slzAa6UDlc4bz6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St6g8HtMZopFUOpdu2bUwZUPcHTd6A04nxaV0GYqnhpNjVPfRi+IX26LWzv0ipnCHepcl6AO6jo5DxnoGCSxlOCsDlhAaIJ7InD90/CzMocnlVFy0K+S6g/9h9q3xq7/kjBhqR6KGln9txmYob4YWgol2IAnmYXrx7oK5HdzwSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJQ+YOyP; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJQ+YOyP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40b2d26a1so996742e87.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:46:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776307597; cv=none;
        d=google.com; s=arc-20240605;
        b=HZeMavWLnEpiHS2end+5V6UFwzja82/+ppG7wV5NRJiwhjLMp0hfPBGxTVECnP5E86
         mMfbEH0yUerdTHPVEpqzr6qF50FRBC14kdrorEAg9u7WX/6ZqVABuSmuNXECnadpk+Cd
         0KyEWz6kVqvcTejHGF0DGLXqT7swlCZ3tdFPVkfz4yEk6Ny8uYayW3xfWdweN3refk+T
         gqKDEPqM7xK8Pw74hrt+eZq1Fa2agnx31fHggfcKy+y7jotho3KuL8a1xm8LgA8fHzht
         HSLztPSNIwODkKRPAV2jaANjTfYZ2Fh2mtZ/bK0bLUY+z2FLt+iQfU5F2tjeiBIxLv4G
         QcKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bMpAi1WfcnB71WumSoAXkBgMlLV2naKm0UdS2vprTuk=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=dddDcY6vvGSzJtLD130tHryUBF9w/f5nupFRzatDpIP4Os429nuZSXjxxuA0soUpXV
         vTTdw+sWaa2trCA7Yuedk7JgcadlflqzAazPNKuSg/n+DpKTc8zeZ0pHIEw0SaOVKHcb
         O6k4xQmsKZHga1kqYd4oSqNoaXB0o9IycG+7H/dav/cxrAUkNFlohe8p14KO6S7v7+L8
         39MCIJCpAW9eXBHMmfkqDrKvg9tHWnhnUd/7oR03lpd0x+h74IvMRaLj9Xm0Q/JmB2Yr
         lvyQ6eBBXO3sUqq/N6/gkeUQGIA+7h4DY4anOncQc/J8uJ/FU9MWjCRPTo8v0IeamSSJ
         WVpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776307597; x=1776912397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMpAi1WfcnB71WumSoAXkBgMlLV2naKm0UdS2vprTuk=;
        b=bJQ+YOyP49qJ6MoIz1HbTGe4fdwF2vLWbKy1xelymbaP37IggzjNeqE1TLWdkedmXm
         SpYIebHQN3LNNqSGDibeQhnTXi2h9DqoUn9cuHR5gCdXQo8VCNe2mDGMQ6oKvneo5q0c
         GG76gPxrnBJFyHsxn63m+R5Ef1GUtwu42OICTRGg0T6aok/XHn5uqbnknW0ukfrCq54c
         B0PLPEOp2EadY6Ax/6aisplR88vjq11rCymqttEmJDtRf9+qdb6khKon8Knj0uXix2I2
         GWFHaoAzz3YDqSQJLRjsWmfws5KUN8jbecaAy+P9UuACq74knYcHS1UPJZPL19Hz19DG
         Iy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776307597; x=1776912397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bMpAi1WfcnB71WumSoAXkBgMlLV2naKm0UdS2vprTuk=;
        b=DIqaq6WyqpmoEr1uE4xKIQIzPrxFYxphlpKxEb6CS9EzfMM0fh7ym49KoS3KkO5O2l
         4HR9LIFYyufBUev3UJbbiMJLnHe2vbJqhBEUU+lLDd0OB5uP7c2LE0U//iCdQDKpwbly
         /XDGlBbitIHybIP0/ACC/+rVTuZp6WtMCBqsDPS4uZ0rn6aqSp1RoyLmpIJ/elGAtkJH
         6r9OPxdvpPPXCx2O0yIRDYd+r5IVcp3SFHMR91LUeuPpAW6tIUXZw3XgJQ6XLI38J32A
         dcmvt9whGi2vj16OUz9ISSOqnu7DaBX5EttOGLv5F2z/uJ0Puzh+/9CN1S6XlQwTaFZT
         nwfw==
X-Gm-Message-State: AOJu0YxpiyrP7J946yfJCf/C4jYA3navJJ1lvBjM1R6ciz1DYjZbKyTF
	Ild+gjS+6s5KLTmyrRTsLhkNMSmAfKFcAepmc+N4D3mawEAIwVD5XTon0S7bW2A9E0SGZ5cjPqI
	g5Lpg0xnlcOW6Qe4H4/wDdgnmJMttnXg=
X-Gm-Gg: AeBDieur6Z3KIcN+PiLGuxw6QgERVgGpPWUXo9pL7Ircz1XPKCOUyaNEEiQ4SIg063Q
	X4Z9tQHvJjael+J1frKbEbYZKxjMhwBoaKvJsfyagCUZZYzax6Qm4D7ioUfdATB/b9GRt5lJNJz
	XT+NlH6jpsVYnpVDlE5ItAWoQZuNn0g0SZAi67hV0dKQ/8o9nsQ46mkD2HB0l+Qqka2ISJIvwzj
	zl4eVfsWC9+oIWH2MYi4+1Y511bc6xb8qWwnN59egR2P+Rx5/NNa34TPEoeR/518x2zngPfkCMx
	VjDFZt2jIdBHziDtinY=
X-Received: by 2002:a05:6512:a91:b0:5a3:ff60:b72e with SMTP id
 2adb3069b0e04-5a3ff60c455mr4177412e87.39.1776307596793; Wed, 15 Apr 2026
 19:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-5-kerneljasonxing@gmail.com> <20260415093822.79A76C19424@smtp.kernel.org>
In-Reply-To: <20260415093822.79A76C19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 10:45:58 +0800
X-Gm-Features: AQROBzAef71r8tiUdyeZgUJhpnVKcyP5ZGIv1I1HR-iZo_mj3Web780eg-zTQnU
Message-ID: <CAL+tcoDbMq9s5tQkpBQfjWZGajUtJxhYzxJ9vD-hpq7uU3RYNQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 04/14] xsk: cache data buffers to avoid
 frequently calling kmalloc_reserve
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:38=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] Cached data buffers are consumed without validating current allo=
cation flags, potentially violating memory placement constraints.
> - [Medium] Meaningful code and commit message mismatch regarding cache re=
fill logic.
> --
>
> commit 5a442e9c44f0a64a147908843084cffe5e2fed9f
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: cache data buffers to avoid frequently calling kmalloc_reserve
>
> This commit introduces a per-socket data buffer cache for small packets
> to reduce kmalloc_reserve() overhead. It adds bulk allocation from
> skb_small_head_cache and persists unused buffers across batch cycles.
>
> >     Inside the Phase-1 per-descriptor loop, when a small packet needs a
> >     data buffer and the cache is empty, a single kmem_cache_alloc_bulk(=
)
> >     refills it with generic_xmit_batch objects. Subsequent small packet=
s
> >     pop directly from the cache. Large packets bypass the cache entirel=
y
> >     and fall back to kmalloc_reserve(). Unused buffers remain in the
> >     cache for the next batch.
>
> Is this description accurate? Looking at the implementation below, the bu=
lk
> allocation happens outside the Phase-1 loop. If the cache runs empty duri=
ng
> the loop, it appears to fall back to kmalloc_reserve() for each subsequen=
t
> packet rather than refilling the cache via kmem_cache_alloc_bulk(). Could
> the commit message be updated to match the actual execution flow?

Will update it.

>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index c7e42c2966cdd..3b3969adfd23f 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> [ ... ]
> > @@ -709,10 +718,17 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 =
nb_pkts, u32 nb_descs, int *err
> >
> >                       skb =3D skbs[skb_count - 1 - i];
> >                       skbuff_clear(skb);
> > -                     data =3D kmalloc_reserve(&size, gfp_mask, node, s=
kb);
> > -                     if (unlikely(!data)) {
> > -                             *err =3D -ENOBUFS;
> > -                             break;
> > +                     if (dc_count &&
> > +                         SKB_HEAD_ALIGN(size) <=3D SKB_SMALL_HEAD_CACH=
E_SIZE) {
>
> If the socket's sk_allocation (which populates gfp_mask) was modified to
> require restricted memory placement (e.g. __GFP_DMA), could this code use=
 a
> standard memory buffer left over from a previous batch?
>
> While the bulk allocation check before the loop correctly avoids allocati=
ng
> from skb_small_head_cache if KMALLOC_NOT_NORMAL_BITS is set, the
> consumption path here only checks dc_count. Does this need to validate
> gfp_mask against KMALLOC_NOT_NORMAL_BITS before consuming from the cache,
> to ensure memory placement constraints are not bypassed?

I can add the check but it seems meaningless to me. In the whole
implementation of xsk, there is no place where sk_allocation can be
set to a different value other than GPF_KERNEL.

Thanks,
Jason

>
> > +                             data =3D dc[--dc_count];
> > +                             size =3D SKB_SMALL_HEAD_CACHE_SIZE;
> > +                     } else {
> > +                             data =3D kmalloc_reserve(&size, gfp_mask,
> > +                                                    node, skb);
> > +                             if (unlikely(!data)) {
> > +                                     *err =3D -ENOBUFS;
> > +                                     break;
> > +                             }
> >                       }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D4
