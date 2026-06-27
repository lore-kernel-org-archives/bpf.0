Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E825175A75
	for <bpf@vger.kernel.org>; Sat, 27 Jun 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782520636; cv=pass; b=KpqiyoBKAh8IhBJSW7PQV5lpXIpdmX6wppzT+8UWwp4sfDqoigt9nQhsBWk/XYsYIiMK8qV+uyyIAnDk970qLoiOaWSHFzwT7Nkxjs7/iw9XTJWNgT6YlGfLQWTxVUumki56qIX2/788NcRk8k8i5vFfLjsaWcrLhDXuxKGW9/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782520636; c=relaxed/simple;
	bh=LsUaRFmdz/PSpFuv9MCZTAI8th0AS1wcvMyHgaWY/KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYTFYqE+0/h0bk+eduhLnBg2fxQ3Kqkjpp1GbTO1N23ogtBpmmCHWzrdqZ5Msqu8hr5hnl8V4uxIlNUdm+xKeJr0FX28hIWfjt1FNhn9FDSs0D8qzGcr+It9XUIXprH4sl7O6FmPe8SFE3O82rxpEWYNLluFv64PIRXCH1Jhskk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuHBlwib; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuHBlwib"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aea7e6220aso1038766e87.0
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 17:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782520633; cv=none;
        d=google.com; s=arc-20260327;
        b=sZ8Qkbc4lDIbi+kkFYsFsTSJEc9FAFJ8J0ya9adF6dH50qUSKK3mhc+wuxRROdWzkG
         L8cCxQQQeM6rbabt45wNNxpxLr7z7VCll89Kc1BeZTphEgW8MslOFXgDkD6C3Aa5BY48
         hHYvSZeWjdBc8zlW2D0pO8p/ydwH1aLMR2BSo9ewx/CDqwF7JXxrffMMu0oKmUpP+yIh
         JKld5na9+BcSJA+ph+PPPoDX1H88zVQQ42zLffx3HSvK51sEQH39nKBkNtrByPoVQa6M
         wWnXL7Eq9YFSnwW4wO4ZAVi4ZuMkJnH5RENQwCvQGES9eEmJD8MC0Sb2IURpqsIDaf/W
         0Zgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRctBiwHak3TEjMfcTZZ+O2QEFJOYwmchGqXk/RduXo=;
        fh=7LhQqyHwkevEqtCMTpL12CnjmJ9q32WGEtRdiH1OeZI=;
        b=RpU6+ttQieeOqux3FSCtX6msQzRilmMrNtTInBEG+25AlCjUNoOJiiG+S97pzGjt9r
         VMPzKcweAi9RzYlqtP0/PY1ZCeHBZHqLZs3wwpsbDbARigGgNh4x6ZtdHoYK3bhfndzy
         WHWb3JYtejqT0BYgjXR1vDjkCBNL82BGx+sAdrbO47eJIvkQ6NFUU373t2O4rSc2xqA1
         5Qi0foTvfxqnevmAU8iFyx7pF5eTg2FUrJXqYOXnUV6HTOdfRTy2YGIYUCIBRvhwGp+N
         5Q0QCBtBQbY6kPdE51F27jb1dSKbOSnjS/qtdotETDLWrW1IxdK/rpK6pcDjTTcvR6co
         uiDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782520633; x=1783125433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRctBiwHak3TEjMfcTZZ+O2QEFJOYwmchGqXk/RduXo=;
        b=PuHBlwibcfpXDd3l06RRFz+kPEUt8ugSv2J4Gy24lAd6++bHYhmYbVblB9j3gAIQgb
         Lslp0SzxIwtEsknydJtkt8xCVPX4QMGfaQlThAMnboxU9UgQ9MFMiI8PwmwTwlfyrzB+
         xqrziIKf/JnRqaLBNIOdfs7abHJmiVTGaQj+nNxSUg+2RJyy1dY5tQckiVj6+PviFyLD
         lHAz/3Nz1Aa73FpuvD8sPJcJrLeMFEq1YtvZJty/0roVvIgCPNotKHe89+rWHzNf2vCC
         uCYmi9DvSPULTg83RAx1CV0g+Jktj/U72TfY2DXwPx85jvJt/6mrwSXgxbnnCLT2HaWS
         o5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782520633; x=1783125433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRctBiwHak3TEjMfcTZZ+O2QEFJOYwmchGqXk/RduXo=;
        b=NxoUnFeMqmwsuPb1mS3f3d/DSSI1b/4gXYLvmLF6AOB/C2D/PfDj2QpFxfekjbPKtg
         Y6bcn4fGlPxgVb5ycgPGJqaFHrV34uE+Fe/Rx7Wt0sNsh8u1dOrOpFD7kyDMzdXu9Wlb
         9QVTZR4pORpBE32aIF09tkmshctEy0zIqGJjoY6ikvoUuRxXJvU50WZLhg8XmwPc6MCd
         bVIafc3D7E/LtZLy1aNKbvqCIY8nl0GGsJLKM5eSgX9JSrVApNMZ1cMMnMppl8CY8PsO
         VZWN20n+90awMgzH0g7IBEBd0ZTJV9WauetUtcwxfEiSONeiKx0x2+V5QyaLFrL/1ghc
         +R8A==
X-Forwarded-Encrypted: i=1; AHgh+Rr5egiDHS8EbtYAlLZSTMAFqxDG3k5HMAcGzFplxVHSoizaMDDr09GzsOEINSOqXM0vWSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGZguV/Pj3IPRT/UHKEjqrHWUD59EQJUyCSD65ooqC3Rtvw4M
	2JoAToWx71RmO66Fhjcn3/1LWQP7MFQ63h0TAegHy+48zWagdhCLFhDtMkvPlzKsPJ+GK/5BQsf
	7LJznKX/hcXa2Dquh+jYmEovr2vXyOuw=
X-Gm-Gg: AfdE7cnOgM9qXoGuKqKLq1+G7mz4F77sr99m6Rjs1oC1lAR3k20x6Ij2x4+88f0GEia
	aElnsh9+2ex8ryn1/HA8q43yO2ZZmkgBn5ofewhxgjYc6AGHuyeThexPOVU8eMqL+mbmZV3hNQ2
	hsBmvSg4nS/AWdtuNAqBldG1jbWh9NTDE8F/5y+pDTxeQMnLiaULF0W5+95vmD6Iflsbk8Hc/LQ
	aY0KT14xajY3cJELJA++0IzILDFtuKC2wdRHdqN68IvIdOSidbl6UNFX+5DQFDuy4lUGdrIThaN
	Cfe/JJYnUZXLq00wEdVBUqx3yED3C9h46uFrzl4W7Wl25JMvo8uYXdqJb+od3SLRyFrLOonW3MT
	q6rOgIXyrEg==
X-Received: by 2002:a05:6512:2607:b0:5aa:6f5d:ee09 with SMTP id
 2adb3069b0e04-5aea1f2d737mr2242536e87.14.1782520632585; Fri, 26 Jun 2026
 17:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
 <20260623133240.1048434-2-maciej.fijalkowski@intel.com> <aj5egH5eDwfsY30-@soc-5CG4396X81.clients.intel.com>
 <CAL+tcoBCsn+b5bY-XAhbEw6wvceMNQwkyry0_NUun1AcR0b6Ag@mail.gmail.com> <IA1PR11MB60978AF3799FD895C53A860882EB2@IA1PR11MB6097.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB60978AF3799FD895C53A860882EB2@IA1PR11MB6097.namprd11.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Jun 2026 08:36:34 +0800
X-Gm-Features: AVVi8Cc9CO4LV9MdWtySaQn6G4drH6It2k5fdC5KsK4enM0jJvPxWnqkLv-4J4A
Message-ID: <CAL+tcoD0sNmRKP+4SGT9C5eZPyc4vU4E3XHs7JV7rgJ_SmgzLg@mail.gmail.com>
Subject: Re: [PATCH net 1/7] xsk: fix buffer leak in xsk_drop_skb() for AF_XDP
 multi-buffer Tx
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: "Zaremba, Larysa" <larysa.zaremba@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, "stfomichev@gmail.com" <stfomichev@gmail.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"horms@kernel.org" <horms@kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 9:43=E2=80=AFPM Fijalkowski, Maciej
<maciej.fijalkowski@intel.com> wrote:
>
> >
> > On Fri, Jun 26, 2026 at 7:12=E2=80=AFPM Larysa Zaremba <larysa.zaremba@=
intel.com>
> > wrote:
> > >
> > > On Tue, Jun 23, 2026 at 03:32:34PM +0200, Maciej Fijalkowski wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch is inspired by the check[1] from sashiko. It says when
> > > > overflow happens, the address of cq to be published is invalid.
> > > > Actually the severer thing is the whole process of publishing the
> > > > address of cq in this particular case is not right: it should truel=
y
> > > > publish the address and advance the cached_prod in cq as long as it
> > > > reads descriptors from txq.
> > > >
> > > > The following is the full analysis.
> > > > xsk_drop_skb() is called in three places, which all discard a parti=
ally
> > > > built multi-buffer skb:
> > > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds
> > MAX_SKB_FRAGS
> > > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> > > >    the TX ring prevents the partial packet from completing
> > > > 3) xsk_release(): socket close while xs->skb holds an incomplete pa=
cket
> > > >
> > > > In all three cases, the TX descriptors for the already-processed fr=
ags
> > > > have been consumed from the TX ring (xskq_cons_release), and CQ slo=
ts
> > > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > > > the buffer addresses never appear in the completion queue, userspac=
e
> > > > permanently loses track of these buffers.
> > > >
> > > > Fix this by letting consume_skb() trigger the existing xsk_destruct=
_skb
> > > > destructor, which already submits buffer addresses to the CQ via
> > > > xsk_cq_submit_addr_locked().
> > > >
> > > > Note that cancelling the descriptors back to the TX ring (via
> > > > xskq_cons_cancel_n) is not a appropriate option because an oversize=
d
> > > > packet that always exceeds MAX_SKB_FRAGS would be retried indefinit=
ely,
> > > > which is an obviously deadlock bug in the TX path.
> > > >
> > > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > > overflow check so that the current descriptor's address is recorded
> > > > before a potential -EOVERFLOW jump to free_err, consistent with the
> > > > zerocopy path in xsk_build_skb_zerocopy().
> > > >
> > > > [1]:
> > https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > >
> > > This change looks good, but overflow case with only 1 descriptor worr=
ies
> > me.
> >
> > I presume you referred to xsk_build_skb_zerocopy()?
> >
> > > In such cases, once we get to following code, kfree_skb() has already
> > happened:
> > >
> > >         if (err =3D=3D -EOVERFLOW) {
> > >                 if (xs->skb) {
> > >                         /* Drop the packet */
> > >                         xsk_inc_num_desc(xs->skb);
> > >                         xsk_drop_skb(xs->skb);
> > >                 } else {
> > >                         xsk_cq_cancel_locked(xs->pool, 1);
> > >                         xs->tx->invalid_descs++;
> > >                 }
> > >                 xskq_cons_release(xs->tx);
> > >         }
> > >
> > > kfree_skb() should have resulted in submission of the single fat desc=
riptor to
> > > xsk_cq_submit_addr_locked() via xsk_destruct_skb(), so far consistent=
 with
> > the
> >
> > At least, in the NO_LINEAR case, xsk_skb_init_misc() is not called
> > since the OVERFLOW skips this function, which means kfree_skb()
> > doesn't invoke xsk_destruct_skb() to publish it in the CQ. So it's
> > safe to cancel the cq reservation (in xsk_cq_cancel_locked(xs->pool,
> > 1)).
>
> (responding from outlook so apologies for any broken formatting)
>
> Yes, I have the same understanding here. However, how technically
> possible would it be to produce > MAX_SKB_FRAGS from a single
> AF_XDP descriptor?

Very unlikely. But my viewpoint might change after a wide deployment
internally in the second half of the year.

>
> I know Sashiko has pointed this out and you came up with previous
> fix, but for valid descriptor it is simply not possible. And invalid
> descs wouldn't reach this function.

Yep.

>
> I wouldn't like to stir up the pot too much so let us keep this
> code, but is there any way to give Sashiko additional context?
> I mean, for case where we would say *this can't happen*, will
> It be able to carry this information onwards?

I don't know about how sashiko works, sorry. Maybe @Roman Gushchin has
unique insights on this?

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > > multi-descriptor bevaior you are proposing here.
> > >
> > > But what happens when we cancel a submitted CQ slot via
> > > xsk_cq_cancel_locked(xs->pool, 1) in the above code?
> > >
> > > >
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on T=
x
> > path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/xsk.c | 13 ++++++++-----
> > > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index b970f30ea9b9..a7a83dc4546a 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -794,8 +794,11 @@ static void xsk_consume_skb(struct sk_buff
> > *skb)
> > > >
> > > >  static void xsk_drop_skb(struct sk_buff *skb)
> > > >  {
> > > > -     xdp_sk(skb->sk)->tx->invalid_descs +=3D xsk_get_num_desc(skb)=
;
> > > > -     xsk_consume_skb(skb);
> > > > +     struct xdp_sock *xs =3D xdp_sk(skb->sk);
> > > > +
> > > > +     xs->tx->invalid_descs +=3D xsk_get_num_desc(skb);
> > > > +     consume_skb(skb);
> > > > +     xs->skb =3D NULL;
> > > >  }
> > > >
> > > >  static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > > > @@ -877,7 +880,7 @@ static struct sk_buff
> > *xsk_build_skb_zerocopy(struct xdp_sock *xs,
> > > >                       return ERR_PTR(-ENOMEM);
> > > >
> > > >               /* in case of -EOVERFLOW that could happen below,
> > > > -              * xsk_consume_skb() will release this node as whole =
skb
> > > > +              * xsk_drop_skb() will release this node as whole skb
> > > >                * would be dropped, which implies freeing all list e=
lements
> > > >                */
> > > >               xsk_addr->addrs[xsk_addr->num_descs] =3D desc->addr;
> > > > @@ -969,6 +972,8 @@ static struct sk_buff *xsk_build_skb(struct
> > xdp_sock *xs,
> > > >                               goto free_err;
> > > >                       }
> > > >
> > > > +                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc=
->addr;
> > > > +
> > > >                       if (unlikely(nr_frags =3D=3D (MAX_SKB_FRAGS -=
 1) &&
> > xp_mb_desc(desc))) {
> > > >                               err =3D -EOVERFLOW;
> > > >                               goto free_err;
> > > > @@ -986,8 +991,6 @@ static struct sk_buff *xsk_build_skb(struct
> > xdp_sock *xs,
> > > >
> > > >                       skb_add_rx_frag(skb, nr_frags, page, 0, len, =
PAGE_SIZE);
> > > >                       refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc=
);
> > > > -
> > > > -                     xsk_addr->addrs[xsk_addr->num_descs] =3D desc=
->addr;
> > > >               }
> > > >       }
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > > >
