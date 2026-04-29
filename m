Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DEC352C4E
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 03:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434824; cv=pass; b=GWH3CVWcKr2FflfS+VdQg10qzYmvqXk+PVd6hHyVLtkab4Q0U7+liNpof8v/pqVG/IA1yXIfYOi9UX6uYsNgUYM34UjIGy/T+M8ppWxmNTz3SooEYitUOnEH4r8Auzf00cOiF/UkjnfehREgiqE/ziXv1glp8mMUR4GuVLqe2Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434824; c=relaxed/simple;
	bh=jr7BKBbh5jGTvbi7zkBQ34Cs1BnVSkpfW2B2SZZ/daA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lS859fUB6JIZqszpNoHDt+8iGzsygdgZG801PFye1Y6Os83lXczeeTPkZI4dwWRaxpuRJb0RlPadlkgZF/0bnwLho6TJBR69VRDaXEN7gGYFIzeVLHb1awUDtQP6Swto1laOSozgQfspQ96lnUqqs8C8gz8LIKSyVIewxcP1itA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQEXfko8; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQEXfko8"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so922767e87.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777434821; cv=none;
        d=google.com; s=arc-20240605;
        b=S1oo1zmpT7ZfQeYeLmBLyo4kmwgybmv+3FYth6GuIua7sGHXSK324rcdB9MYNPhqw9
         euYu9A1ATcTb8TArl97VAiwAPraVfLyoruTlzoug/8QmJVGf5R+zyHvyzz/yVoD32V6o
         o8ouAag0ZKEJjb5c4LAJSd3DJCYJJ3FLzGZqqpYT/j+ksbCZ7zgc2GtVf3n6ZouprFvx
         rTUxYVwxMdl85oyZsXmKcuxqPQnKC+eyxEpVAEjpqPWoWQGdQ66N4BbT0n4r4JqQHjmF
         YC5xy33cRdpczijX8Ua/wbeBfXQS1MyjhemKYw39w+83Y8uAr2uJc506fEjxq2qngKJq
         UVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnDN8j6rFwURVGMb90DGBXP2v8xXDb7wYPxZty6APdo=;
        fh=0Thjk79fXzYw46TfcPlK85krYMRa9fF7Y4p8K3OZgpQ=;
        b=BbmyVPZnOHWL8Y0M+tS+7lceQ2W/k4TSc8m5Ci5iPuqmgjbGfFAxBjPYg1uHeWQ8rD
         S1lI7+XMyKs25pNiKf/NWMIH41AdaHT72jsLnqLlFjIFeRf75Hufj0OyVRSO9hnCf9Zz
         XJfA2rUqjPRuHzKt4kNW47p52WSSaVroveBqmCtxDfdTDQMr3QSu5muWuUHT9Vo99ZzW
         1k70aI9JgSqSlSrJDGKnN2o9HOPq12LHx4IUpPFymGP2mjjotLYpJz2EDI4U/HNYKUyG
         +/Mp4LSY69qIlNnwE2tVf2IrbUTzxHAGn4Sr5SRAToMNrIhHsDIc4ydKpPmaLi8QVdzO
         8//g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777434821; x=1778039621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnDN8j6rFwURVGMb90DGBXP2v8xXDb7wYPxZty6APdo=;
        b=IQEXfko8FmdLFhHNN+KIPakK11HImgdBpwUcOiPG7Kgx3JrPGTY5xDKBFUwF17jBFu
         z3D8E6MIUhDeZ37TqdRM2DKr5JHvMD/ncJZaS22cWFs+6d9UxW2A+BZP2yav5v9vnP1p
         Iq0fEqXAC35aq2emWJ55HhtNyd5ybILiNVvC4dWcny1I7zzBYx2UXMGj+kRjFU8MRcdb
         y9gq6Tdz4l+zCYgzpR9W6loAPpcQstkh0rHBw80W0H1UZ2OBIAaoTxlQ0kbv6Fs9zYzE
         DVf5h4u+afs0lSqF5PJSoRnd6cSEAMKdi5VIgQ++fN7nuNaKyP6nZJnnYIlxLLMN2496
         0gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777434821; x=1778039621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnDN8j6rFwURVGMb90DGBXP2v8xXDb7wYPxZty6APdo=;
        b=jIJpz8NZNu2585oljOV+0CwFNLjyPH9oR5BLNe0NeIE/rXfGQVgm79PVGYYcuAQlQu
         nzMsnLY8wMt8hTtL2uiskGrjJ+dSlodHtzkYnIl3aR6DjWowNnvH/wS7wV3fZisXK/vN
         lOulevpCXdEUY9r/z6Xe1UjDjJ97a4m23QMrr4dJK3fQq/ms2oyFyn4JT7ThoAj7ixpk
         yt/eaJC88YqRpo0v/aPs8UjGvsE4ysR+4EE4X9/ayhVD2TO9Pecf2MHhapN8XePcbOtW
         nZZDlpmrVsKIbMCN//N6mwBsyA4bFmjrNNWv1JBDtnNsh8jaU5HMb81eiF1fSDnigx8S
         Rfvw==
X-Forwarded-Encrypted: i=1; AFNElJ96vxVIUB0CFZGMsVIL/MmXYkxfNUvWhw+cfJres3VdeyZhEsj+p1O1zVw81C2d9puUS/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GZXOMue4dj+FCivcCz7h2z/ettUMhnXQthvQm/fnlj5jkLFl
	3yiYo0evEbPNwltAwcZFP+BXTJlBRgemHRyM2R6IUfzRw2PHJyJB02kGdIit3v+BJK85DhBro2P
	DBqrHDcWMfBHJSw7a0CKY+ixvKDzV4bs=
X-Gm-Gg: AeBDievsiBUtgPeweKQSKXM2q0h0Losln7sY6+5gN5QMJHo+Py+/Kh9/P9fNkjDBYs8
	LFFzhSRQUuSA9S1ow72BOWbS+0sT5JIj6QBKoblb/unM9vmlx6TsIB3jSjxYzI/Xyrdo/Y+DKhR
	u0K++g8umRFKGAYpqmVctsSwG6LawBFVCh13/BVZ9hWu40eqTc+V1Obi/YiLzi3aJVagLhu9xtd
	grHEBjFn7V8fTTHCLjR9cP64tJpubWuJmNd1b39vcQYo49M+b6q/vglRyzVnWaR851tgVgAHTkf
	fthyP7zwLktDUauXJfExyXmTWgEJ6bZ1WkaOrEMVQGFZC24=
X-Received: by 2002:a05:6512:3ca1:b0:5a3:f305:a50f with SMTP id
 2adb3069b0e04-5a749d22580mr788918e87.30.1777434820120; Tue, 28 Apr 2026
 20:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-3-kerneljasonxing@gmail.com> <20260428113333.1296663-3-horms@kernel.org>
In-Reply-To: <20260428113333.1296663-3-horms@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Apr 2026 06:53:01 +0300
X-Gm-Features: AVHnY4KRV0mHqqn8VKUS87OczdQmNsFbECenfmLn4La6QOdlu1I-B2kxFABo5kQ
Message-ID: <CAL+tcoBvDWKemw7hrf0J8zZwKTrHw+0H8rd1aCgtjgEKQVFhSw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/8] xsk: handle NULL dereference of the skb
 without frags issue
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, kernelxing@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 2:35=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
>
> Simon says:
>
> Hi Jason,
>
> I'm providing this for informational purposes.
> My unedrstanding is that the problem flagged below
> is not present with the full 8 patches of the series
> applied.

Hi simon,

Thanks for letting me know:)

Yes, it will disappear after applying the whole series.

>
> ---
> xsk: handle NULL dereference of the skb without frags issue
>
> This change guards the existing xsk_inc_num_desc()/xsk_drop_skb() calls
> in xsk_build_skb()'s free_err path with an xs->skb check, and adds a new
> else branch that cancels the reserved CQ slot and bumps invalid_descs
> when xs->skb is NULL.
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 887abed25466..54d4895fc11e 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -973,9 +973,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_so=
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
> > +                     xs->tx->invalid_descs++;
> > +             }
>
> The changelog states:
>
>     In this series, the skb is already freed by kfree_skb() inside
>     xsk_build_skb_zerocopy for the first-descriptor case, so we only need
>     to do the bookkeeping: cancel the one reserved CQ slot and account
>     for the single invalid descriptor.
>
> Is that accurate for this commit?

The commit says "in this series,..." which might confuse the AI reviewer.
>
> Looking at xsk_build_skb_zerocopy() as it stands here, neither of its
> error returns actually frees the skb:
>
>     if (!skb) {
>             ...
>             skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
>             if (unlikely(!skb))
>                     return ERR_PTR(err);
>
>             skb_reserve(skb, hr);
>
>             xsk_skb_init_misc(skb, xs, desc->addr);
>             if (desc->options & XDP_TX_METADATA) {
>                     err =3D xsk_skb_metadata(skb, buffer, desc, pool, hr)=
;
>                     if (unlikely(err))
>                             return ERR_PTR(err);
>             }
>     }
>     ...
>     for (copied =3D 0, i =3D skb_shinfo(skb)->nr_frags; copied < len; i++=
) {
>             if (unlikely(i >=3D MAX_SKB_FRAGS))
>                     return ERR_PTR(-EOVERFLOW);
>
>             page =3D pool->umem->pgs[addr >> PAGE_SHIFT];
>             get_page(page);
>             ...
>             skb_fill_page_desc(skb, i, page, offset, copy);
>             ...
>     }
>
> So on the first-descriptor -EOVERFLOW path (xs->skb =3D=3D NULL,
> IFF_TX_SKB_NO_LINEAR device), doesn't xsk_build_skb_zerocopy() return
> with the skb still allocated, up to MAX_SKB_FRAGS pages pinned via
> get_page() and attached through skb_fill_page_desc(), and an
> sk_wmem_alloc charge held by xsk_destruct_skb (installed by
> xsk_skb_init_misc)?
>
> Control then returns to xsk_build_skb():
>
>     skb =3D xsk_build_skb_zerocopy(xs, desc);
>     if (IS_ERR(skb)) {
>             err =3D PTR_ERR(skb);
>             skb =3D NULL;
>             goto free_err;
>     }
>     ...
> free_err:
>     if (skb && !skb_shinfo(skb)->nr_frags)
>             kfree_skb(skb);
>
> Since the local skb has been set to NULL, the kfree_skb() guard is
> skipped, and the new else-branch only performs the CQ cancel and
> invalid_descs bump.
>
> Doesn't that leak the sk_buff, the attached frag pages, and the
> sk_wmem_alloc charge every time a first descriptor hits the i >=3D
> MAX_SKB_FRAGS condition (or the xsk_skb_metadata failure)?

This is the issue that I fixed in the subsequent patches.

>
> A later patch in the series, "xsk: free the skb when hitting the upper
> bound MAX_SKB_FRAGS", adds an "if (!xs->skb) kfree_skb(skb);" inside
> xsk_build_skb_zerocopy() before the -EOVERFLOW return, which seems to
> confirm the skb is not freed at this commit. Should the changelog's
> premise be reworked, or the free added here so each patch in the series
> stands on its own?

It's only about the description of the patch and the whole series
IIUC. If a new version is needed, I will send a v5 then :)

Thanks,
Jason
