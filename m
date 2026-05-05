Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1AB271441
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778009617; cv=pass; b=IZlGYOenX7yrJ7p4IQVQ8Wig3onf3yiixYg8BzxGr9qRR5F7J5WMnnn2MydcK7geOvTXMrN6dezEdORATmKDF8Z8iKQp+v7Qaxqvl9CASfaWLhec/muuYQbnk+2K87UB/w8xg0Zv4m3+Ge5GeQUEuexD3zdspXFk6MceSnKwCh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778009617; c=relaxed/simple;
	bh=6hQpRAVZET/RhGbGB4BG8p3CqbP6CtHoy5WXKlwPY/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbKMDxREqFsF4qrY0GhOQUDWqNjCyrj9K5oQjX5ut360jSdC0Bz+L/ANQerAikhYTOgfxxST+7Ee2YVJWWr+NX/aJtjmGoT96VNy/giIk2OVcFNRMutJTKkfJ/wsJFmoWLZgbyps1GTJBPsH/Op51ObDDHBu9ExM69ojWyZ0U+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlnjvKU2; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlnjvKU2"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40502e63bso5788460e87.0
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778009614; cv=none;
        d=google.com; s=arc-20240605;
        b=IOgrB1mqyE41dLnS+IKaMPgO0LQPMyQuWKWXsYjH1At50LUJ0d+Gc5VLnoVmglNz3p
         bCHf21rqPP/qqFjrs5gMxFdbRSxn/k1ySp8RimezrDLAhChpKOCfgL2HMzHYnElpIjk4
         +clCkoT3vLOusVqzfF9Ce1f+Yl+kxCL8gWl4Ig1vzMaeCvMCwqcpfOcNUdNhkZKgrAnE
         F+NDQybtPeOXsXjnwrt1RRKTI0nQYNW1OILJ2cpPU+q78eFzy5XpdsZlNlRjpetLfb4b
         gtspuVnyAoz4H69GKFiXviqCNabIMheBSM7ZAiGinS73Xi7+z3JqzOfQq078GTiHHD/f
         NZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iFN4aIkGIz3vOcI87It1Of+5hlBzbaB7CC9s68mzn90=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=j8gd6G/BEJae+M6+tVlTKnyQixTfZHd3Yga+9kRUzaHpcF7efqA60Vk5XC8Gjaa6Iy
         iwP3+3arj4PRA7wEiBO1B31DzbEDKtlRPfnSB3ujm/6jjfSoXc194kAKNyIAR+OzN0V5
         PmWEeKl6DPxBlu71YneRundH7aYmJxMQQSOa9jAzlvHxImDAorPJqgK1QbnDKu3SnJ3z
         Uw56n1QCtNE8GNDSpzgeK6RLSVTJtSOp/MKanC1v3j2OmrkEob0fl+/w+2z8+8H95DFO
         H0v1vFKqaSMsJYs6ENPVWcyZLqwqZ9VHFR3UqxLHpSiH6ALqSUeAidHRDl30CUMo2SO+
         HtCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778009614; x=1778614414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFN4aIkGIz3vOcI87It1Of+5hlBzbaB7CC9s68mzn90=;
        b=UlnjvKU2/nQ4hP0L5pTcDOtR/cP8eXIcuQ+Vqk1r/4O0JO7xE8tl+Y2RSLTU5w0SJX
         wd00Za+zvWFj/AhGTX3hOD+lwc8zgQVIrpRYFkkTRtA88bJ4I9NSk+ENi58TXOQo5s9K
         LcBMLL3in5xiGFU82tTgW/ZB2tyXBmRub7EIojEc2wOc51VKfzgYefar1EwoYxOacrQ5
         o4uWWdeUmtrD5TichaianLtoki5SCmT06nKLtVDZJds+UUtmvh4ixj3TcCcSPUXfvcAk
         3jdy9fuObCO21+nSwCkf30UBqqBe5PWW8s4dtxGh3B0BJsCyWXDFhgJ+H/CN09sGJFR8
         BaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778009614; x=1778614414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFN4aIkGIz3vOcI87It1Of+5hlBzbaB7CC9s68mzn90=;
        b=cjIq7LstfObPaUo8Euz5eaqXtCwTIP+AayGJogfE92xyYxQanDoqdNceFHzZdGzlEC
         rSOTei8Uzk51QBaanhbteRqxQkeHenODsNNsuUBfMWIWI4WS0/0ja5dVDMi3YmPqp0FP
         JR9xs+Vkqj93jtd4AIXpXgBUzC4Kllj00LeH1b59npQngIPO8WSeD1Gjm0/AEobewiLE
         91QErFZP/zf2L/bZX8xrf+JVWJsdEQju/6wWTf/R52nwNqAr8nSspNN7iL8Y4ZKvYedH
         Yh0zuGRPpwRU9dTvK1WPyM6jJNvBiakHbRzwtaeQUtSt5Ibdq8RMmBkQ2hYTKjOgovXZ
         rzFQ==
X-Gm-Message-State: AOJu0YzsPtspdugVFQ0uA/pY6pvwh8UdvxhJZxO1FUEh1JrTfY2xKoBV
	Qtw/0G/az7dSLZWs1mffIWF6jmRACX5TPgDsYlOUT2c+1AzfYo5H0mMi1mqrnVPaSF+LAMKDzc2
	ZqYqynPDCpeLOy/JpLJ2Im/ch9b2M/g4=
X-Gm-Gg: AeBDieulFHIqUbeXPYsjl1F9crNhKSxkEN2UWgJnHwTZQFRjoPsifN+dqvUmUhDrR9X
	xOGRDFerCKVLU4XuQ1fKWyT05ZSMcLL+c/sD/3XqYMPhQEKa0rOnqrZd8OYdlNnuT6cwlLUgIXw
	a2tdJ26xyV/MEYcd+i93K9ahEXWXuRbxU/tGCcqGHOzp9kBLaOCu0YwbASn3Tbt1Zislrt13BVQ
	1p7sT7nR/YdF13wVSiA5Ew17DYz4BPJnohW3A1ebXNrnrb4liwBhecURY91bPt5O1MzBaU/nvPy
	IlO1+cd9f5FIakwHxkLF3yorFm7utqzXcMeIk9djziiDpPuE
X-Received: by 2002:a05:6512:6cf:b0:5a8:5276:f0db with SMTP id
 2adb3069b0e04-5a887ae5607mr33173e87.15.1778009613522; Tue, 05 May 2026
 12:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-5-kerneljasonxing@gmail.com> <20260503200925.DEF06C2BCC4@smtp.kernel.org>
In-Reply-To: <20260503200925.DEF06C2BCC4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:32:54 +0300
X-Gm-Features: AVHnY4KwMxKAZRkQzWU0JnQfzYE12w2IOibSYPNW7_E2hrHzFe7dqbrGkHLppuU
Message-ID: <CAL+tcoALJcEgPNuTXHESTkZxU8y2ASixW5Ccd7jd7vp9O2PWdw@mail.gmail.com>
Subject: Re: [PATCH net v5 4/8] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Memory leak of SKB in xsk_build_skb_zerocopy() when TX metadata =
processing fails.
> - [High] Memory leak of xsk_addr array when an SKB fragment allocation fa=
ils and the packet is subsequently dropped.
> - [High] Double completion and Completion Queue (CQ) state desynchronizat=
ion when xsk_skb_metadata() fails.
> --
>
> commit 7c8b265d19cf8eaa2671c3f79683f55810dfc68a
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
>
> When xsk_build_skb() processes multi-buffer packets in copy mode, the
> first descriptor stores data into the skb linear area without adding
> any frags, so nr_frags stays at 0. The caller then sets xs->skb =3D skb
> to accumulate subsequent descriptors.
>
> Fix by using a !xs->skb check to handle first frag situation, ensuring
> we only free skbs that were freshly allocated in this call.
>
> Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxin=
g@gmail.com/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 06ee260f3afc..55378c3855d5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -972,7 +972,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       return skb;
> >
> >  free_err:
> > -     if (skb && !skb_shinfo(skb)->nr_frags)
> > +     if (skb && !xs->skb)
>
> Does this code leak the SKB if xsk_build_skb_zerocopy() allocations fail
> during TX metadata processing?
>
> If xsk_build_skb_zerocopy() allocates a new SKB using sock_alloc_send_skb=
()
> but metadata parsing fails (e.g., xsk_skb_metadata() returns an error), i=
t
> returns ERR_PTR(err). The caller xsk_build_skb() explicitly overwrites it=
s
> local pointer with skb =3D NULL before jumping to free_err:
>
>         skb =3D xsk_build_skb_zerocopy(xs, desc);
>         if (IS_ERR(skb)) {
>                 err =3D PTR_ERR(skb);
>                 skb =3D NULL;
>                 goto free_err;
>         }
>
> Since skb is NULL, this check is bypassed, and the newly allocated SKB an=
d
> its associated socket write memory quota are leaked.
>
> I understand this is fixed later in the patch series by commit "xsk: avoi=
d
> skb leak in XDP_TX_METADATA case".
>
> Does this code leak the xsk_addr array when an SKB fragment allocation
> fails and the packet is subsequently dropped?
>
> When appending a fragment to an in-progress packet (xs->skb !=3D NULL), t=
he
> code identifies an inline address tag and replaces it by allocating an
> xsk_addr array via kmem_cache_zalloc(), initializing xsk_addr->num_descs
> to 1.
>
> If alloc_page() subsequently fails, the code returns -EAGAIN to retry lat=
er,
> leaving xs->skb intact.
>
> If the packet is dropped before a successful retry (e.g., socket close
> triggering xsk_release() and xsk_drop_skb()), xsk_consume_skb() attempts =
to
> clean up the array. However, xsk_consume_skb() uses the check
> if (unlikely(num_descs > 1)) to determine if it should call
> kmem_cache_free().
>
> Since num_descs is exactly 1, the check evaluates to false, and the xsk_a=
ddrs
> allocation is leaked.
>
> I see this is fixed later in the patch series by commit "xsk: fix xsk_add=
rs
> slab leak on multi-buffer error path".
>
> >               kfree_skb(skb);
>
> Can this kfree_skb() call lead to a double completion and Completion Queu=
e
> (CQ) state desynchronization if xsk_skb_metadata() fails?
>
> In xsk_build_skb() copy mode, xsk_skb_init_misc() sets
> skb->destructor =3D xsk_destruct_skb. Immediately after, if xsk_skb_metad=
ata()
> fails, execution jumps to free_err and triggers this kfree_skb(skb).
>
> This executes the SKB destructor, which unconditionally submits the faile=
d
> descriptor to the Completion Queue by advancing the user-visible
> ring->producer pointer.
>
> Immediately following the free, the free_err handler calls
> xsk_cq_cancel_locked(), which decrements the internally cached cached_pro=
d
> reservation counter. This desynchronizes the internal reservation counter=
 from
> the user-visible ring pointer and falsely pushes a completion event to us=
er
> space for a descriptor that failed transmission.
>
> I note this is fixed later in the patch series by commit "xsk: prevent CQ
> desync when freeing half-built skbs in xsk_build_skb()".

Those three points you brought up are all handled in the series.
Again, the order of this series is designed deliberately to avoid
new/severe problems.

Thanks,
Jason

>
> >
> >       if (err =3D=3D -EOVERFLOW) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D4
