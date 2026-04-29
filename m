Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB63CA4A0
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 19:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489385; cv=pass; b=u0HEMykLLFwXDmIqkI701GdfP/zctTCO0O1jQbz8YRkb4L/U4rH+tTMI3aoFHidKvP+smRkrUrxHp1deOQ3VWtkZ/3ymRwYIfWCl/NtspdgzQmof1IroPH6nQXy3a0jdnvZKfOIVpGSj2/F4xiuyDGPTQ4M7Su0fk57VLJAuWZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489385; c=relaxed/simple;
	bh=5nTtgSqfFoVNpfqepgSsx4hdfpDEIoZNJZwx0GctVp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4xcYkycQD4X2Px2wGBU2Qkte2LLYQKLQWus/n+oMi+JgXxO0KwVfeAl5vqYgtez2i8Jjgp4eFTxJlAevXrF+2hMzAtnpJ+fA1Xs5XgBrADuSl5tHt7j2ueJ+qy12h2AGaShTns+9yC0Ox1I3Dg6jatfVkgo9Zukt6BoU4HfyZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXczAXS0; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXczAXS0"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59e4a04f059so77519e87.2
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 12:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777489381; cv=none;
        d=google.com; s=arc-20240605;
        b=T4Fi/TyY3cQWcEzsD1F0gFwQY13SzMJaBj5doF1HXc7YgLtBf6Oc47zMxdkeYAAdzh
         5He0T+Q/xoBzFgtLJR+sAICQhB/4it6pxsr29P41ldmIYmQQeDgX2kYaKR6AFYmIOJqB
         ctkYYtZdAcf6RuUd98AAdrwW/JVNfLuwBwhYUkyW80hYerp4wkyCS4/gH5OWMMTNIT4z
         Gbuuda9OPUf6PQlnCbbSft5iwDmoqAOa7k4wcYE7fqmGoHlezbEs5u3AsCrO2fNMY4E0
         s30dCepaaoNGofcJS0PmORJpIfWyxSdf1Xm/SHb1yxj7bD+elExG5Im6wVqpkNN1VF5w
         o4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xo041R5MieCcoDpSjd4k9u0LJQ8ZHIpKG4t+NUGoKJo=;
        fh=8Xrih5f4t4Vux/Aykna4s5+AXrg/SOqRFTWht2jdbog=;
        b=a+vGAMlvRFABIbFZOVcNcfMR05xt5EGb15Y4CpqDlhpkWS/fNKabjYnvQFsxhTL9UT
         SIr59xOj8DOTFgJWsJjUJjpJkF9Luz0EEbJ+zjUE7SYPfAT7+CzeEjroiu+ZOSg8OAXN
         zfVFwaz4ul9kNjDrglqHRefKfrWBer7wZ4haD9PncVJ/N/VBLRX7VDUO4cvzpGbI6iPd
         yvtN0Rt/upo8g+PAH5PQ5T9PYWFPcZZYYlP20sGqKigNviLuskceKzHqLC375u8+jf05
         YH52bpOJHN5Tpush2bZT3kJZY7C9TjTwwMjDgwT3boB6RNLsDfvc0VqHy06cr1nX/h0G
         x1jQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777489381; x=1778094181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo041R5MieCcoDpSjd4k9u0LJQ8ZHIpKG4t+NUGoKJo=;
        b=LXczAXS0O62tyNHWmiBNZPWDfoZAsdz8+ykLXqhcTlmg7W2SRoCzcIyT2SzhLMYnsw
         e2pXZvxS5i0fHjdtZ30xJwJAlA2LiJfm3yBaiZrUSUhIZTP19ACwYDWfzdCIuV1EHN2L
         BDBCTvxn3tUJtr86YXmJVPE4OXFRGbzjcjxkpw/GQMxzk+VEufTfs4n4ek3jOrwIf4QK
         8fnaEX4tioW74b19O3tFK8L9HIoO6S47DPYtAKs73wYH8B/6ralSw9WJOVr2T9RVlF0+
         V1MwoMNon31Rq3/JroEuMh4xhbZvoeAoggedDHT3VZPdY9t5UtcjlvBzzMUr1d84+CHR
         KR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489381; x=1778094181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xo041R5MieCcoDpSjd4k9u0LJQ8ZHIpKG4t+NUGoKJo=;
        b=obT7947B3wG8Q4gxPIpM+wlGlSNXyv9pSz37FJJa+7vU6rSMTx8xqxT8CmrZrP7B5g
         SGdMcMIadjDAB+yF7tDUAeeP80LobRNBRvJ64tRRX8/suwVVO6VKzcfL7i1JPmygmoau
         WUal1xgH0ZFfeVVMfzWKZDkRtJlNOTAE8ZzVwk10HWXi4bIw3HPu0bikboRj1MukaBcV
         1RZEQcs06qxET+6F/mnLcI40RX9x7wgiMALx6/ozvDjO8DKzCqmk+Jj/2s+eSsHz2+5H
         X83Pl83yUqOlpjsdchDYY6SRI+rO65SDnS2wjW83wpjW01pA+LVYF5d0DGynoiBXHnzH
         GM5A==
X-Forwarded-Encrypted: i=1; AFNElJ/g/owmcXQWKRxZg3Gdmw1EHv3xiNUUmUexmrKzag/EV3lTLbeO5rmo/eEVAPOyHcLLtnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlac3MvVm8GltvjfkYrB9GGxMxKPzfXHmxdf6vjyvNc1qEjeGy
	oO4WdYkbW2CrkVSwC+R8bxZZPTmogkdz8UNf/oL+lkxm824N+QnfWHungLbBBABTBwpCarXXFKu
	da28qNKdD5Pe3eNqDxSbR+KzYxpmV/Gw=
X-Gm-Gg: AeBDiesl8BUhA6QiJrwahuR3/Bpt5roLyzHJYoZBhJZrM3P8qlEvWJ65vo/pPHZrw8N
	CwO84lSag68jqEh+QpWU0rWUnqshRg1JnnXVfWnTbZhOBM8lCO6rTvWNGtQryp2fv/Cm+OV8aFd
	vljSoXjY4AoxI5Eub+YETGm1Y72UAxorPjmooKO29KA+BEoJ8YzVTqMhQX1i9dGezMVVXnYp3VL
	QVk+BcaYniac+JOdgLv7IYoNI6S5Ok1fq57QDDkWm5dvXtDfWtPm3Hpmv4fnc+I5VY4dpliKYw8
	Uvj0YS1n5mfh/zt0mI29L5N8VnETkwEXNkSr9GHo9gcZ2t/p
X-Received: by 2002:a05:6512:2381:b0:5a2:a13e:9082 with SMTP id
 2adb3069b0e04-5a74662a7a2mr3961810e87.35.1777489381092; Wed, 29 Apr 2026
 12:03:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com> <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
 <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com> <afIeuwJNfwVmk9Pn@devvm7509.cco0.facebook.com>
In-Reply-To: <afIeuwJNfwVmk9Pn@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Apr 2026 22:02:22 +0300
X-Gm-Features: AVHnY4KmgWuhp5WgftHZ3GgAU4eUEIeLgS0_cetfcVVTWyHZR3sBrC477Rs-0ao
Message-ID: <CAL+tcoBTO9QGM220EO=m1TdiXwod7QzG59j7vQL3qoVSrb2QEw@mail.gmail.com>
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, aleksander.lobakin@intel.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 6:14=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/29, Jason Xing wrote:
> > On Wed, Apr 29, 2026 at 2:11=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > On 04/24, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) vi=
a a
> > > > uintptr_t cast:
> > > >
> > > >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | =
0x1UL);
> > > >
> > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits =
of
> > > > the descriptor address are silently dropped. In unaligned mode the =
chunk
> > > > offset is encoded in bits 48-63 of the descriptor address
> > > > (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is lost
> > > > entirely. The completion queue then returns a truncated address to
> > > > userspace, making buffer recycling impossible.
> > > >
> > > > Fix this by handling the 32-bit case in the destructor_arg helpers:
> > > >
> > > > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> > > >   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
> > > >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> > > >   xsk_inc_num_desc() brings it to the correct count of 1.
> > > >
> > > > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
> > > >   when destructor_arg is NULL (not yet set), false when it points t=
o
> > > >   an xsk_addrs struct.
> > > >
> > > > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> > > >   before touching any other skb fields; on failure return early so
> > > >   the skb destructor is never changed from sock_wfree.
> > > >
> > > > The existing xsk_consume_skb() already handles 32-bit correctly aft=
er
> > > > these changes: xsk_skb_destructor_is_addr() returns false for any
> > > > allocated xsk_addrs, so the kmem_cache_free path is always taken.
> > > >
> > > > The overhead is one extra kmem_cache_zalloc per first descriptor on
> > > > 32-bit only; 64-bit builds are completely unchanged.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp=
.kernel.org/
> > > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor n=
umber")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> > > >  1 file changed, 31 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index ed96f6ec8ff2..fe88f47741b5 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_bu=
ff_pool *pool)
> > > >
> > > >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> > > >  {
> > > > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > > +     if (IS_ENABLED(CONFIG_64BIT))
> > > > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0=
x1UL;
> > > > +     else
> > > > +             return !skb_shinfo(skb)->destructor_arg;
> > >
> > > Don't understand why we need to special case CONFIG_64BIT here?
> > > Shouldn't the same existing condition work on 32bit?
> >
> > Because 0x1UL is the particular semantic applied on a 64-bit arch.
> > xsk_skb_destructor_set_addr() sets it while
> > xsk_skb_destructor_is_addr() recognizes it. They are a pair.
> >
> > As you noticed, one liner works but is not that appropriate: on a
> > 32-bit arch, this member should be either a NULL point or a valid
> > pointer pointing to a memory region. Testing if it's NULL can be
> > helpful as to the long term maintenance because of its readability and
> > robustness/safety.
> >
> > The error path in allocation of skb is really complex, which is why
> > I'm so cautious to take care of it :)
>
> Let's cleanup the error path instead of adding more complexity? Similar t=
o what
> you do with your "xsk: fix xsk_addrs slab leak on multi-buffer error path=
",
> but maybe add a few NULL checks?

Good suggestion. I think I can cook a follow up patch to do such a
thing targetting net-next tree. This patch 8 belongs to net material
which means it will be backported to the older stable kernel as soon
as it gets merged. IIUC, the better way is to make it as simple as
possible?

>
> Instead of 32 vs 64, I'd like to reason about whether destructor_arg
> is an address or an allocated array (not whether we have 1 or >1
> descriptors). And we special case 32 bit by always allocating it.
>
> Haven't checked, but maybe this is all you need (besides your _set_addr
> changes)?
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6149f6a79897..03f217e85d31 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -589,6 +589,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
>                 return 1;
>
>         xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> +       if (!xsk_addr)
> +               return 0;
>
>         return xsk_addr->num_descs;
>  }

Right, as I mentioned, how about posting a new cleanup patch with your
suggested-by tag?

>
> > I've noticed the status has been changed to 'changes requested'. Does
> > that mean one way or another I have to post a new version?
>
> That wasn't me :-) From my POW, patches 1-7 are good to go..

Great! Thanks for the review. My hope is to get this series merged
soon in the net tree.

>
> > >
> > > >  }
> > > >
> > > >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > > > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct =
sk_buff *skb)
> > > >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x=
1UL);
> > > >  }
> > > >
> > > > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 a=
ddr)
> > > > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 ad=
dr)
> > > >  {
> > >
> > > [..]
> > >
> > > > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > > > +             struct xsk_addrs *xsk_addr;
> > > > +
> > > > +             xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, =
GFP_KERNEL);
> > > > +             if (!xsk_addr)
> > > > +                     return -ENOMEM;
> > > > +             xsk_addr->addrs[0] =3D addr;
> > > > +             skb_shinfo(skb)->destructor_arg =3D (void *)xsk_addr;
> > > > +             return 0;
> > > > +     }
> > > > +
> > > >       skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr =
| 0x1UL);
> > > > +     return 0;
> > >
> > > I think this is gonna be a 3rd copy paste of the same logic? Let's
> > > move to a new helper and replace existing kmem_cache_zalloc places?
> > >
> > > xsk_skb_destructor_alloc_list(prev_addr) ?
>
> Any comments on this?

I didn't comment on this because I thought I was not that sure if we
needed to wrap it up in the stable kernels :)

Of course, it would be easier for me to work on the net-next tree to
make the code look
more neat and elegant.

Thanks,
Jason
