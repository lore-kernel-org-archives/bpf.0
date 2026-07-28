Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB8F13AF2
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197311; cv=pass; b=PfgIghcTRlM4QyAwEFJpVVt4TGxe2ppKHZmgTlieAaTY0p7IiHMpE4jPdwlTcktDNBBrDztyVEseLrxGmRL8FAPFq6jJbUfEZbDhe2iMXrZ9Y0IaaJOIyRoBvZcN3BtTBZOeGCWHn2fTD16RwrNJLci9AnPMYGpI3QXSU43OPlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197311; c=relaxed/simple;
	bh=YNlF8a1o3epmZetRCjgDF5EO3Z7GUHs0IcIUsRJBabA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBcvlEA9tfMwG7BMLsH+UMjUHQfJOdRMCeCoT/pF5gAl+nYaDxQFQXEWneapSQ5USYuqIjZYl18a4eCoQQWreShDiqFRP6g6Kzo918hrKk0V6Bk1pcF9RjUI28yp7hkFpSO1rgQ6FCnCvR7b9NzaCFxhmvjg64wEc3N2BsVCkfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2YAcAWo; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2YAcAWo"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39c62764c7cso3402331fa.0
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785197306; cv=none;
        d=google.com; s=arc-20260327;
        b=S+bQqHqXcosyNjsvkg1abtvxyeIVd9hkdymarRs7mFL80NbMQ/xgsa2sSx3URVvv2L
         f02xr1ua//Kk3ZSh9Tcx7GpX8Fggj00OQs+qfSDdU1h5EPGrWf74RC1JvBJ1IQLXRuWv
         mlJdTM+Pjsf2gfDI4nKzZemHbIMq1Lu58j5Evcag5DtQQ+dZyJ4cD1HJv+7tVKat+8LS
         rR/aDI9lJUb8rAmF6HS+4gtQ4e/w9tkUeWIsToiB8siD/UMEDVo1Lr4faV8i/LvjQuDh
         V59j3DuC5WS+pDLw9rnYJRisxNQBHPy5bNOou1qmohxqxWwpmTrV02A+DF+JVx12o0Js
         gHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OX5+Xiyuuua7ItSBWY1/1bwrYmd2boubaHGKa84wHQ0=;
        fh=Ya005VydBAXggpEquUNhTIiTxaS0F7/YMzwdNXRoFMk=;
        b=TP+a1W0ZsP54Y26tw/xgzQ8p5ezET8RW9gHA7zIsSn5n8X4nVEghZBnLpsqyZ8G3+W
         LaNu4G5ZcueILtIlOwHXNPxLvpC39lhzTcrh6yS8qaI2mYhy0f8OYf//qbT731xrpxaV
         qI9RWZnGIjFMS79Ef0P2u88x2dPLeik2vesjAlsM8dTsi6MDvWlbJtkYhyeHaTZ3rlcQ
         RonqNeWFG8ifqT7DwA3Mvefx+rx5xb/I4TVvsn2lQ2urY5EaXEs7bCF6TNCe25jAseYg
         +mHlkRPBkZKJZfdmRYHQ+CZd31PKDVTLwL73sQjyCf4l/tmYEL3WeJMnzYUN7EvHwD0a
         bSYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785197306; x=1785802106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OX5+Xiyuuua7ItSBWY1/1bwrYmd2boubaHGKa84wHQ0=;
        b=g2YAcAWouoovhZFVFtWesBYYlsyWXZKVJcnQjR63aqShyrW0VVQWmPDHG5Oxpxv60G
         foUMe3AJ6VnlJYbQ6tMcQXGfd1ZUwS2axug86i5TD6t7RNgz+w7RQLy/xSKwt8hin+FX
         g+rM0fkqhZ46/SZVkZHBP6KUPftqgMlrIpgFP8wblq5i7FomicfwUoTp9dffX45bprWi
         iS4P6HD0XMsGUsSKanu6gmikpfJumyv3fec8PAQDIH9rnm9APN2GJjL0+WHQ6F/LEBif
         Xpms515PC7OART4z3tA0PhExW2fYn/TpWPOEv8fHHRoZZ6fK4pWjmSw/Ju/oZlpGwNNB
         SpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785197306; x=1785802106;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OX5+Xiyuuua7ItSBWY1/1bwrYmd2boubaHGKa84wHQ0=;
        b=Pc14MH62sJ4dsuGWwxlSsH1GeBD7WuYUk75QSZ9ZOCitdQQ9NPBsrFE+QoZrCpeF4A
         ki1FGXBaC79L9kXp7Pm+gNJlV4r8rdLa/Kyk+Be3boXYnxyKNXVe0ftOvMhZpuFOHjOq
         xn8gExXmBGtK8a4OpEge0NEBqTuhZk+R+iwu057LKs5YoKAqoRm7h5fMmErtDPAGCXrI
         Jsao8jgPiidMiLEFYz+b+Tq2tI6x1Bww5QL9PayHbvQ/EMPXXwbVFDFuQtgsMpcU5Vrz
         cRiXA8T8JEZu7wU1Qgyqx7EsVyHeVEtvfEFXFwzaryzmR6la553caJ9BHRfb1gwmYEN+
         OYmw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0A2xxhNwlo5j/DXgRUOMjyDVj1JfrKFx4RQyVSFXwHlGhEFG3Gowpi4Lynr53+nqn5Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1BESjBQMONYnjRHRHRh9Ki+0QCIMGZHtRrhQbzYng7jCJPnC
	7g/ZghWu93j/ADdAQFkrjNfDkf8lhTpdjttUyP3CnLMkUVEMn/cv+t+w2rWosduOl94tGfIR9eW
	S/ZVsaBYaGyB3E34ngPgkaLWb6XNUHrk=
X-Gm-Gg: AR+sD104wJ4Fy1iuuh40cum+2C2XbvKYAFzUHyyxyXaZ3soO4kuSVAyM56MRvXFbO+Z
	+24F4+eoq52M/nqqhdD5bZMRjpvAIeTtQZDQKyrUoi2uDFuo3qUxVDGJ8QDIGS3MNueCI/wj8tS
	SlCXsKC2p4CPVQL6QPZ7AM/rcEcwK90mVGsfkGaoyfU/aWp3nJBqQAsIDYdHzhp43do9finHEq7
	7hF9+E6LipN4Ciu+bQmKiKAjmrIeT8T2fXv1iwrgDae/VbYZfHmpHyWmc6VyZKSM1KLjeFnt2uj
	QhXMNc33Kh0RHGyfQE8EDoBVTU+7xvE/SOnwwZFlhStecA+geuFKczKFIZ4hJdXUKaCX5WG8crY
	=
X-Received: by 2002:a05:6512:b83:b0:5b0:1108:c58b with SMTP id
 2adb3069b0e04-5b2d0251425mr11802e87.15.1785197305751; Mon, 27 Jul 2026
 17:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725034246.192091-1-blbllhy@gmail.com> <amdJgi0V3YwWE7oL@boxer>
In-Reply-To: <amdJgi0V3YwWE7oL@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 28 Jul 2026 08:07:48 +0800
X-Gm-Features: AUfX_my7CVZAWJ_zY3gsLevRMQ883H5RL2tkawbZLRybomyRZyxwgSo7Orudwho
Message-ID: <CAL+tcoA8KPn7z3p7KymQLT4apwcaCy1Yi8P0S5KD-f91jxmwhw@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, magnus.karlsson@intel.com, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

On Mon, Jul 27, 2026 at 8:09=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Jul 24, 2026 at 11:42:46PM -0400, Cen Zhang (Microsoft) wrote:
> > In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> > loop without checking its return value. xsk_buff_can_alloc() only
> > counts fill queue entries without validating their addresses, so it
> > can succeed while xsk_buff_alloc() rejects all remaining entries and
> > returns NULL.
> >
> >   Oops: general protection fault, probably for non-canonical address
> >    0xdffffc0000000000
> >   KASAN: null-ptr-deref in range
> >    [0x0000000000000000-0x0000000000000007]
> >   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
> >   Call Trace:
> >    xsk_generic_rcv+0x26d/0x5f0
> >    xdp_do_generic_redirect+0x3c5/0xcf0
> >    do_xdp_generic+0x92f/0xe70
> >    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> >
> > Fix this with a two-stage transaction. First allocate and stage all
> > buffers required for the packet, recycling all staged buffers with
> > xsk_buff_free() if any allocation fails. Only after this stage
> > succeeds, copy the data, reserve the RX descriptors, and release the
> > buffers in an error-free loop.
> >
> > Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx pa=
th")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> > ---
> > v2:
> >  - Allocate all packet buffers before reserving RX descriptors.
> >  - Recycle partially allocated buffers instead of only cancelling the
> >   RX producer reservations.
> > Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gma=
il.com
> >
> >  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index f906d51b6699..383fc2b1de48 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct x=
dp_buff *xdp, u32 len)
> >       u32 frame_size =3D __xsk_pool_get_rx_frame_size(xs->pool);
> >       void *copy_from =3D xsk_copy_xdp_start(xdp), *copy_to;
> >       u32 from_len, meta_len, rem, num_desc;
> > -     struct xdp_buff_xsk *xskb;
> > +     struct xdp_buff_xsk *xskb, *tmp;
> >       struct xdp_buff *xsk_xdp;
> > +     LIST_HEAD(xsk_buffs);
> >       skb_frag_t *frag;
> > +     u32 i;
> >
> >       from_len =3D xdp->data_end - copy_from;
> >       meta_len =3D xdp->data - copy_from;
> > @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct =
xdp_buff *xdp, u32 len)
> >               frag =3D  &sinfo->frags[0];
> >       }
> >
> > +     for (i =3D 0; i < num_desc; i++) {
> > +             xsk_xdp =3D xsk_buff_alloc(xs->pool);
> > +             if (!xsk_xdp)
> > +                     goto err_alloc;
> > +
> > +             xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > +             if (unlikely(!list_empty(&xskb->list_node)))
> > +                     goto err_alloc;
> > +             list_add_tail(&xskb->list_node, &xsk_buffs);
>
> could we use existing xsk_buff_add_frag() ?
> then I presume xsk_buff_free() would understand list and walk through
> xdp_buff's and free it ?

Good suggestion, but xsk_buff_add_frag() will add more irrelevant
stuff like nr_frags, xdp_frags_size, xdp_frags_truesize... They are
all happening in the softirq context. Refactoring the helper would
bring more work here.

Honestly, I like the local array which seems simpler/cleaner to understand =
:)

Thanks,
Jason

>
> I believe we could reuse pool's xskb_list instead of fabricating the
> on-stack variant here.
>
> > +     }
> > +
> >       do {
> >               u32 to_len =3D frame_size + meta_len;
> >               u32 copied;
> >
> > -             xsk_xdp =3D xsk_buff_alloc(xs->pool);
> > +             xskb =3D list_first_entry(&xsk_buffs, struct xdp_buff_xsk=
,
> > +                                     list_node);
> > +             list_del_init(&xskb->list_node);
> > +             xsk_xdp =3D &xskb->xdp;
> >               copy_to =3D xsk_xdp->data - meta_len;
> >
> >               copied =3D xsk_copy_xdp(copy_to, &copy_from, to_len, &fro=
m_len, &frag, rem);
> >               rem -=3D copied;
> >
> > -             xskb =3D container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> >               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> >                                 rem ? XDP_PKT_CONTD : 0);
> >               meta_len =3D 0;
> >       } while (rem);
> >
> >       return 0;
> > +
> > +err_alloc:
> > +     list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> > +             list_del_init(&xskb->list_node);
> > +             xsk_buff_free(&xskb->xdp);
> > +     }
> > +     xs->rx_dropped++;
> > +     return -ENOMEM;
> >  }
> >
> >  static bool xsk_tx_writeable(struct xdp_sock *xs)
> > --
> > 2.53.0
> >
>
