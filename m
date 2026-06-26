Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCB3F4849
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 12:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476741; cv=pass; b=WKDszpLML9LQO6es8ZcfApPxQOt0z2YWRo8Yd4HEweT4O1gMZC+XZrs5IYz9JaMNc6DhbY8Tv6gjkAkQKj4UF21WE4VsaXrLZ1RIwrOZg/4wSBgbiEAvBgDiu2AQKosKo+dBR0B6HlTxpq169Ynzngp5HjqrVUkswHI2R3heGpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476741; c=relaxed/simple;
	bh=wcAW23DeNB+Geuqt+1Y4dPn5SMIhXoqynsUcFLY8Rz8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPelTMJLrhfVoB6rzlGAIUPA5/dSJ2UySdgbyNsbxvzsBKzZxeqCO0nPMKKcWmJts0Qw3NvFqfV30Fx8wmk8kDbr95My3ZdWOKV0UHJlu4DzJnUuVCjQe01Q8bfEhMudjEqMT0QFRo30Xxg1BIhACHqeMXqiZJsHIEy7IzTKF+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHWFwgpH; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHWFwgpH"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso820684e87.3
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 05:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782476738; cv=none;
        d=google.com; s=arc-20260327;
        b=fca/EevPDkubCM6f+tz0I2ZI/mAA42b8BH6cI7o+q6R01pYieR0l4hu7s6o2X5qRfj
         L4KXpolqHWTHw3iBz/2BskmI1QkdlgFBTyCKKsiF3ARNBOJrLCnRUwc+ABH1JUr1J/NM
         Ba2+V/thMnH/DTY7n7oCvozCrq83pFdBReGZebxLfKC4SjFdy56Iutr9iFx0fqFBtRPT
         DGfNxBtM3pslOtH6US0MPipVWO6/omZ9KhbRTBsMMZySHa3zOXaxdrssJxXyRGZNdV0M
         P1gN1r7ebdd+tyZS7pUTdgnuc59TIdRgNDcdl7146qqeJ82OaymjFD0LgJfpX3LX2aKK
         VGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Th1VvDD9Oki0IThJKp3H3ZhWOYcyT4z98kEdO2PovU=;
        fh=VGfPHyUP34AwO0L/gjQfovb7XgZ4qsIOiLGV5YQL3zg=;
        b=Cx2UNgQRNUuzl0b0qTHbCcSm+pko1PahyW48zvIyeC0wMgdlI8GXBdUzVYJN2CY0Hy
         RFGVrYeeYJJdYa1anuLSRQH//2DcvyGdmNooqCLRGz7N/kXsPhxhOx+hM5fxlhuX9pVT
         yxDLK07mQOT5VGhzIMzl0VXOdL0p9vmGrDYJVZw8NxpAGG6+nxgRQB1v3U94ir/5zCFb
         PinbqTv3Z3yRFZCTFJDBSHfh7k5Ja2cVYCwZ9CoW5ba/ypX4mxbXcWRTUI9NUiFR2aHS
         dBTBnR/lCbK/7iljh4dSxYss+s4/Ok2qo+rA3J8Cl522sMm1rFT3Kp0Z8mfEi/sqb63n
         mmHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782476738; x=1783081538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Th1VvDD9Oki0IThJKp3H3ZhWOYcyT4z98kEdO2PovU=;
        b=AHWFwgpHcVxfWC447JVo0H/qtJ3AbxHS+sHoBlRSwZRMERt9G9gBn247REsuxaau2y
         u2VjboIuTOIWM5UHD3RFJxXOazL65O4GZy+5BU+Z2rc6pGd6gEqGJR0ICHncbmamGalp
         sKwZFTvQy6Ate6iYXN0SlmrgTpeLRxr4IW6nypBREF/5Y/YJnQjqYxUsR4CTrquxmVRw
         /+NAnD1DfYHHaihUBChrQYDHhaIacvyl2lnNb6RR/iCjCjvzp9yRwllPoLVottUuuhn1
         kt0/o9bS99/8kt1MAxPh04+plPlXzmtNw3oYoPfeYrMuJj3mS64aY1j+KYkTS8cQ3PQQ
         J+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476738; x=1783081538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Th1VvDD9Oki0IThJKp3H3ZhWOYcyT4z98kEdO2PovU=;
        b=KV0X7tKJa+bgCCv+mp/OsCWtcSjxJ6igYP20lUlzpPpNXTcoN/QoQpScyENJeaLOHA
         n9RumYuaAzb6/HXlKp6fDX4pL7zQufSO+/8iMfIMcfWVZ1O1YfY1AIvd0nj4cDepynZZ
         rdklJjMa98XD3FVNdI5wXTAJCzt3vj3Y3sLFHATUNVXQ0k1qjiTpvXaBKZewCw/bs1gN
         u3MSsPgCHNkdhICnjgYtgd0XX/wdBJEQvcrHdZUPa7kkJ4k/6Indppl2gnm+HO5kNTbV
         s0SNcGOkwmkgsB94Lunjjl3eGyEaeGynPCrPWAtY7fqosVl6RH4DZKM2z69MgFXtIsgA
         LT0Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro0qd5xZnI6wNwgKB9boKWxWd4dpfYqWlM8kqUT+riVtO+Ig+zuohpbB5+GuZt2J+2j6wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxkKev42tmRohYD3nhDshh+8iEJNT9QG4RUzsp4a1o9KwcgaX5
	PrKuefcS0JFlbP0Tmp2Bd4SxHu9Yo5Apy0BdPhcSJ1nln14EnXz/+tsXlGKaAR4fEOZ8sWbdZhY
	N53uZb+7cCKPph39TVNTQF5Hmp4tco/E=
X-Gm-Gg: AfdE7cnIQSCNWF+fDdlCjOg/y61kawpy9KjFv6leYhYj8y8uLENmmCJC1FQyoLBV4fD
	H3L7wwdpOW/vQhy2CX3avRK8G8GhbZNCmM5AovAKBd5Dc69GsgRwTiGT6tBE+qNCx+bOzqwdmQD
	FZ9A8FIDTFTn9LcY/wNilhUPWyubfRiRJ7zA7GeLPVaT1ZBrW6ipWX64cgNwOQYWlW5P7hcW9gf
	RQMWYMe0i2gAOco+2ft6BA6g4V/kPeqPd7NksztDnFVlKJJZLOauch7wZ+vnaCGAdL7k54yei1V
	F02ZMyxDUoL3k1Tdcjm1Eis4ErDL+Vslduhb4h9Op50Bq+2lLOY2g+FU/wgDdTk9rf2ebKn6KnV
	6nZNQaQnQtQ==
X-Received: by 2002:a05:6512:6281:b0:5ae:9ea1:a19c with SMTP id
 2adb3069b0e04-5aea1f28f57mr2292390e87.3.1782476737433; Fri, 26 Jun 2026
 05:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-2-maciej.fijalkowski@intel.com> <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 26 Jun 2026 20:24:58 +0800
X-Gm-Features: AVVi8CdDyYaMDmGq0_7GM0EWKJw7dAH07LolOuKsGHa4cV7x5oKjlA_nn1_fMcQ
Message-ID: <CAL+tcoBCsn+b5bY-XAhbEw6wvceMNQwkyry0_NUun1AcR0b6Ag@mail.gmail.com>
Subject: Re: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP
 multi-buffer Tx
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 7:12=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Tue, Jun 23, 2026 at 03:32:34PM +0200, Maciej Fijalkowski wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch is inspired by the check[1] from sashiko. It says when
> > overflow happens, the address of cq to be published is invalid.
> > Actually the severer thing is the whole process of publishing the
> > address of cq in this particular case is not right: it should truely
> > publish the address and advance the cached_prod in cq as long as it
> > reads descriptors from txq.
> >
> > The following is the full analysis.
> > xsk_drop_skb() is called in three places, which all discard a partially
> > built multi-buffer skb:
> > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> >    the TX ring prevents the partial packet from completing
> > 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> >
> > In all three cases, the TX descriptors for the already-processed frags
> > have been consumed from the TX ring (xskq_cons_release), and CQ slots
> > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > the buffer addresses never appear in the completion queue, userspace
> > permanently loses track of these buffers.
> >
> > Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> > destructor, which already submits buffer addresses to the CQ via
> > xsk_cq_submit_addr_locked().
> >
> > Note that cancelling the descriptors back to the TX ring (via
> > xskq_cons_cancel_n) is not a appropriate option because an oversized
> > packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> > which is an obviously deadlock bug in the TX path.
> >
> > Also move the desc->addr assignment in xsk_build_skb() above the
> > overflow check so that the current descriptor's address is recorded
> > before a potential -EOVERFLOW jump to free_err, consistent with the
> > zerocopy path in xsk_build_skb_zerocopy().
> >
> > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel=
.org/
>
> This change looks good, but overflow case with only 1 descriptor worries =
me.

I presume you referred to xsk_build_skb_zerocopy()?

> In such cases, once we get to following code, kfree_skb() has already hap=
pened:
>
>         if (err =3D=3D -EOVERFLOW) {
>                 if (xs->skb) {
>                         /* Drop the packet */
>                         xsk_inc_num_desc(xs->skb);
>                         xsk_drop_skb(xs->skb);
>                 } else {
>                         xsk_cq_cancel_locked(xs->pool, 1);
>                         xs->tx->invalid_descs++;
>                 }
>                 xskq_cons_release(xs->tx);
>         }
>
> kfree_skb() should have resulted in submission of the single fat descript=
or to
> xsk_cq_submit_addr_locked() via xsk_destruct_skb(), so far consistent wit=
h the

At least, in the NO_LINEAR case, xsk_skb_init_misc() is not called
since the OVERFLOW skips this function, which means kfree_skb()
doesn't invoke xsk_destruct_skb() to publish it in the CQ. So it's
safe to cancel the cq reservation (in xsk_cq_cancel_locked(xs->pool,
1)).

Thanks,
Jason

> multi-descriptor bevaior you are proposing here.
>
> But what happens when we cancel a submitted CQ slot via
> xsk_cq_cancel_locked(xs->pool, 1) in the above code?
>
> >
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx pa=
th")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index b970f30ea9b9..a7a83dc4546a 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -794,8 +794,11 @@ static void xsk_consume_skb(struct sk_buff *skb)
> >
> >  static void xsk_drop_skb(struct sk_buff *skb)
> >  {
> > -     xdp_sk(skb->sk)->tx->invalid_descs +=3D xsk_get_num_desc(skb);
> > -     xsk_consume_skb(skb);
> > +     struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > +
> > +     xs->tx->invalid_descs +=3D xsk_get_num_desc(skb);
> > +     consume_skb(skb);
> > +     xs->skb =3D NULL;
> >  }
> >
> >  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > @@ -877,7 +880,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struc=
t xdp_sock *xs,
> >                       return ERR_PTR(-ENOMEM);
> >
> >               /* in case of -EOVERFLOW that could happen below,
> > -              * xsk_consume_skb() will release this node as whole skb
> > +              * xsk_drop_skb() will release this node as whole skb
> >                * would be dropped, which implies freeing all list eleme=
nts
> >                */
> >               xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
> > @@ -969,6 +972,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >                               goto free_err;
> >                       }
> >
> > +                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc->ad=
dr;
> > +
> >                       if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS - 1) =
&& xp_mb_desc(desc))) {
> >                               err =3D -EOVERFLOW;
> >                               goto free_err;
> > @@ -986,8 +991,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >
> >                       skb_add_rx_frag(skb, nr_frags, page, 0, len, PAGE=
_SIZE);
> >                       refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
> > -
> > -                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc->ad=
dr;
> >               }
> >       }
> >
> > --
> > 2.43.0
> >
> >
