Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D683914FA
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784689829; cv=pass; b=sZKMyHz0zqyEbqzA91ZhhjYM6mnaZlu8DptcMw+uW0sW1jNFrRsa9Ol5AuTLfmwIUVqspq+S7PbCw/VReTnGULYjeVNV1b25IzeVyDC/JVNaZTt2a5t0GyDXZHOmK4CH7YmuxqeRNhqRgCBrq/bc71eOEuhB3kfsmgpL3Lp5pzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784689829; c=relaxed/simple;
	bh=rSJ4JhGT2i9pWgoDCAyKiTWUaxtvZfPMEJc1VjDf72w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEPaX/zbT/xoc6Nigp+UPRscVidfYSqvPGv9mN6KK1Bsn0zPaNaoRROpEnvDawm63cTy1JHZvnR6taIuwa3lMNE7NSSp9wm+2AJ53PTcugH+erRiJKGcvnFjTGYqsutVoiREDT3iFkERqVnMyTpW5/Oilk/qXR/I2Z+uqEZVsUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxZXGZdF; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxZXGZdF"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c9452244aso108346571fa.3
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 20:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784689823; cv=none;
        d=google.com; s=arc-20260327;
        b=CkDK1hBh5bDdbqS4MHbNC4MeaH6XWKUHyn0p2UQk5q5nHK7LY+X1hWh18L0U1xt5BK
         5hHubxNtKO0LYBsGfqWQ/5btH+9riMNLqnqECjaU9PksmxjWdy5nAezUjDnG4tU3uPEv
         aERq98j3f2sPj75dbOvw2lDA1xxPcaGmIJ9pZIyWY1BshgqXMrM8qLMaILe5J3X6frRR
         22wusCk6KSvK1bdQuwOWARSvy84vjedsNiTMWPaym6Fs+1aSgSu6XV/imRIiKqSiKVhq
         i2QPYK35tRBtvPybv02Qv8eeiFGHPDQ0nAkaIC/7lTrT57meiySJO//B4KmwViRWDRCr
         64jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNrgMg4GNSIlLYWZQtT9cmP6suBBeyAA/JY5ArowlCw=;
        fh=DyhD57EUqjTDd4F7iAjVZ0ekJ9ZqTeH9X/IAFNm3vQ8=;
        b=QbIn7CX9vxMec/W0pwui5T0ciX+LpguqoxSsxjhspEAvFFLYqp2oE+YklNmo99Pp53
         9s5ubstty5kZdObG1B8kVD8pa1FOmpPRApvZEl0MtFDHYZojI9nl6KWeMRkiaPg6jhyF
         G72I0Ego1QaIKhvLcjfKQI/wKldq67qW7Lv6QPkvHVSZAgkbrWkqvM24RAEvEeV33FO9
         iYGE/natn3yAZ61l2py8ZRTihDBRIffynB5vFka/HN8KJDD9XQ0O/MkWAmwpstJVTUmI
         mvXetA0dO/jWDqE0qPDOT0hK7tq8lBmPvBJ9Lz8maucCXAhRetoMHGcrKLIWC+6mH+Kq
         d3VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784689823; x=1785294623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hNrgMg4GNSIlLYWZQtT9cmP6suBBeyAA/JY5ArowlCw=;
        b=OxZXGZdF4r1FrczJ2xHgv9ldfssxU3bMS6HpmoOXRE0fLmei6YSW53XlmqmjvblYQi
         h1doV9lB/DCFYC6QkDO9TWjP0ZA3HIFfV+9Wsh7MJJW6YZavSLa/aVHnNidrBTzDjYNH
         HmHKpz0Z5Q44qNV4+soDL8KTwf4xxMsgtC1yyuhuFCTKVA2GdfV31PvINxhCVxLm89DE
         4OF+Kl4aUvrctYNQuqhrVeEnmVtK14OUdn1GyrdTr+34FCdWv+VrL2m3irZUcnZDzrvT
         mVHFsebKtu6I6MMk/6W/TPvwUALylue8bIMINPT1B7v1quY92Yr6NOQAYZjQvsM9goEZ
         ZHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784689823; x=1785294623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hNrgMg4GNSIlLYWZQtT9cmP6suBBeyAA/JY5ArowlCw=;
        b=ND6jROqAgA2w1FyZu4SEmmX64hSFmlPHGiBNkBFxnQe/SrSTMrrmAnyDH0LgZnnP9z
         mx7AMILIf3gKY5EOGhmY4ZJiFpp9HnlKERmJW7iwfxtF/JPXOffJ1o+VyqsFzJUdtT6x
         YMyKH00hF4rrTRMGBujyKirDGc/rXXA/n5mduxPBU6SNz6XBZgD+u/BCJNn6eFS+9L+B
         iGiTpHvrJT270TrylqVecRCRCssYOOYkRas42z5VfExH0mVClET0FAIyYMb+7d4DzzFJ
         Jr3fW4dWsXPuvht3YX1gXTcnazciWpdiilPvA9dCWYq8MNjxlZPatI8CZI0wEOsgwfnZ
         Zdjg==
X-Forwarded-Encrypted: i=1; AHgh+RpZDiZGRuxsk6bjcZ7X5y5wuPGD3mTJOyc9BvfxyZIGnBST5NHmJ2+Lh1FDKRU9AXCYEDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlgb4I8Uug9Cs+vSlL+67gfU58XrEPXkC539PN3XryLZSieugX
	HIgpGmB+Ss52ujbXqbKbTzPUrTbatd16K53nrsh5RRMfchUBrUxm5eUcZO9avRzfHyj0XsX2jHP
	FxYPIIsQ719aJFub1WPFUF/MM+X+5D9w=
X-Gm-Gg: AR+sD117VzfzIAPAzoYnDl9QwDzm5Jh8LIM/fC+ygP5Y71yKDd/f92+WD657RoUAjyq
	ApfKmhqabB3Ua7foNp7QMeafjN/WkqqmZNX56xITu9gvMNq5UBnLFuMspa74XWLfT8o56uvcWPL
	FrG0kg6AciFD0EThsHLSntRoCWV1EbQgBOLv1JJFH4FNlstN3EVBy+Rv1xk+Py7Enqkw2D0Gm7a
	gylslhWuLwGNwdbHAcvDfxgxAzxW57Z3xTBzS8rb3T2s7pgcTnhrSq5R55dQmRIZW1HzHw3vC1H
	mDqsPZvZkUkjUIoxy/LWCGoCzRRFC3d3apfi8iebI3rvhTuilg8CXI+AloZvIq3jCY4S4E49oip
	1qTeFQdCKYlw=
X-Received: by 2002:a05:6512:3d94:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b28f860563mr5091151e87.16.1784689822950; Tue, 21 Jul 2026
 20:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719135609.147823-1-maciej.fijalkowski@intel.com>
 <20260719135609.147823-3-maciej.fijalkowski@intel.com> <al+0qKu1U7kutrih@boxer>
In-Reply-To: <al+0qKu1U7kutrih@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 22 Jul 2026 11:09:45 +0800
X-Gm-Features: AUfX_mywjWKhxzJ0RPBRLeCufjckBSpbOpC9LTmGM0R_8s2qFem1UPGsQwuLYCI
Message-ID: <CAL+tcoAqt7kG9jq0Z8+2Ft9dtXY6_xcykjsC6Jrktm5Av9gCfg@mail.gmail.com>
Subject: Re: [PATCH v4 net 2/6] xsk: drain continuation descs after overflow
 in xsk_build_skb()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 2:04=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jul 19, 2026 at 03:56:05PM +0200, Maciej Fijalkowski wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Fix generic xmit path multi-buffer logic when packets are either too bi=
g
> > (count of descriptors exceed MAX_SKB_FRAGS) or an invalid descriptor is
> > included in fragmented packet. Introduce xdp_sock::drain_cont and act
> > upon this flag - when it is set, keep on consuming descriptors from
> > AF_XDP Tx ring and put them directly onto Cq. Previously these
> > descriptors were silently lost and could never be reached again.
> >
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx pa=
th")
> > Closes: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.ker=
nel.org/
> > Reviewed-by: Jason Xing <kernelxing@tencent.com>
> > Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # wr=
apped cq addr submission onto routine
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/net/xdp_sock.h |  1 +
> >  net/xdp/xsk.c          | 45 +++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 43 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> > index ebac60a3d8a1..8b51876efbed 100644
> > --- a/include/net/xdp_sock.h
> > +++ b/include/net/xdp_sock.h
> > @@ -80,6 +80,7 @@ struct xdp_sock {
> >        * call of __xsk_generic_xmit().
> >        */
> >       struct sk_buff *skb;
> > +     bool drain_cont;
> >
> >       struct list_head map_list;
> >       /* Protects map_list */
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index a7a83dc4546a..12a845d012f6 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -737,6 +737,19 @@ static void xsk_cq_submit_addr_locked(struct xsk_b=
uff_pool *pool,
> >       spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
> >  }
> >
> > +static void xsk_cq_submit_addr_single_locked(struct xsk_buff_pool *poo=
l,
> > +                                          struct xdp_desc *desc)
> > +{
> > +     unsigned long flags;
> > +     u32 idx;
> > +
> > +     spin_lock_irqsave(&pool->cq_prod_lock, flags);
> > +     idx =3D xskq_get_prod(pool->cq);
> > +     xskq_prod_write_addr(pool->cq, idx, desc->addr);
> > +     xskq_prod_submit_n(pool->cq, 1);
> > +     spin_unlock_irqrestore(&pool->cq_prod_lock, flags);
> > +}
> > +
> >  static void xsk_cq_cancel_locked(struct xsk_buff_pool *pool, u32 n)
> >  {
> >       spin_lock(&pool->cq->cq_cached_prod_lock);
> > @@ -1028,13 +1041,14 @@ static struct sk_buff *xsk_build_skb(struct xdp=
_sock *xs,
> >  static int __xsk_generic_xmit(struct sock *sk)
> >  {
> >       struct xdp_sock *xs =3D xdp_sk(sk);
> > -     bool sent_frame =3D false;
> >       struct xdp_desc desc;
> >       struct sk_buff *skb;
> > +     u32 cached_cons;
> >       u32 max_batch;
> >       int err =3D 0;
> >
> >       mutex_lock(&xs->mutex);
> > +     cached_cons =3D xs->tx->cached_cons;
> >
> >       /* Since we dropped the RCU read lock, the socket state might hav=
e changed. */
> >       if (unlikely(!xsk_is_bound(xs))) {
> > @@ -1063,11 +1077,21 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > +             if (unlikely(xs->drain_cont)) {
> > +                     xsk_cq_submit_addr_single_locked(xs->pool, &desc)=
;
> > +                     xs->tx->invalid_descs++;
> > +                     xskq_cons_release(xs->tx);
> > +                     xs->drain_cont =3D xp_mb_desc(&desc);
> > +                     continue;
> > +             }
> > +
> >               skb =3D xsk_build_skb(xs, &desc);
> >               if (IS_ERR(skb)) {
> >                       err =3D PTR_ERR(skb);
> >                       if (err !=3D -EOVERFLOW)
> >                               goto out;
> > +                     if (xp_mb_desc(&desc))
> > +                             xs->drain_cont =3D true;
> >                       err =3D 0;
> >                       continue;
> >               }
> > @@ -1096,18 +1120,33 @@ static int __xsk_generic_xmit(struct sock *sk)
> >                       goto out;
> >               }
> >
> > -             sent_frame =3D true;
> >               xs->skb =3D NULL;
> >       }
> >
> >       if (xskq_has_descs(xs->tx)) {
> > +             bool drain =3D xs->skb || xs->drain_cont || xp_mb_desc(&d=
esc);
> > +
> > +             err =3D xsk_cq_reserve_locked(xs->pool);
> > +             if (err) {
> > +                     xs->tx->invalid_descs--;
> > +                     if (xs->skb)
> > +                             xsk_drop_skb(xs->skb);
> > +                     xs->drain_cont =3D drain;
> > +                     err =3D -EAGAIN;
> > +                     goto out;
> > +             }
> > +
> >               if (xs->skb)
> >                       xsk_drop_skb(xs->skb);
> > +
> > +             xsk_cq_submit_addr_single_locked(xs->pool, &desc);
> > +
> >               xskq_cons_release(xs->tx);
> > +             xs->drain_cont =3D xp_mb_desc(&desc);
> >       }
> >
> >  out:
> > -     if (sent_frame)
> > +     if (xs->tx->cached_cons !=3D cached_cons)
>
> Sashiko says:
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this change to the
> release condition expose a pre-existing issue where rolling back a partia=
l
> multi-buffer packet corrupts the Tx ring?
>
> During multi-buffer packet assembly, if the max_batch limit is reached,
> __xsk_generic_xmit() exits and commits the partially consumed descriptors
> to ring->consumer. User-space observes this and may overwrite those slots=
.
>
> On the next call to __xsk_generic_xmit(), packet assembly resumes. If
> __dev_direct_xmit() subsequently returns NETDEV_TX_BUSY, the code calls
> xskq_cons_cancel_n() to rewind the local cached_cons by the full packet
> length:
>
>         if (err =3D=3D NETDEV_TX_BUSY) {
>                 /* Tell MAC device to consume more and retry later. */
>                 xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb));
>                 ...
>
> Because cached_cons is rewound by the full length (including fragments
> consumed in the previous call), it becomes smaller than the cached_cons
> saved at the start of this current call.
>
> Will this new condition (xs->tx->cached_cons !=3D cached_cons) then evalu=
ate
> to true and commit the rewound index to the globally visible ring->consum=
er?
>
> If ring->consumer jumps backwards, wouldn't the kernel fetch descriptors
> that user-space may have already overwritten with new data upon retry?
>
> Maciej says:
>
> So generic xmit is still not bullet-proof, sigh. It's a problem that was
> present even when `sent_frame` based consumer pointer update was used, so
> sashiko correctly classified it as pre-existing issue.
>
> I think this can be addressed after current set lands, as no new bugs are
> introduced and seems it got acks from Stan and Jason.

I do agree. Don't bother iterating the series, IMHO.

Thanks,
Jason

>
> >               __xsk_tx_release(xs);
> >
> >       mutex_unlock(&xs->mutex);
> > --
> > 2.43.0
> >
