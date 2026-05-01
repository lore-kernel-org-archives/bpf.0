Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149332DCC04
	for <bpf@vger.kernel.org>; Fri,  1 May 2026 03:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777606178; cv=none; b=lwf5TySShdrMZv5s11NLjNaenrtJprotEtOK9++ASTdB4tYWRn/awvXlLKCqvmJ4QnCOhz34BBNtQ/UH3jpo1dEgTOUKBYeCEvfScjiXDEpECXEEDu5/jQh192nKTd1t17aJJw209n/4gCBXcCJYb9f+wr7duYyqew4u1euxOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777606178; c=relaxed/simple;
	bh=cZfTMIMKNTtYHRa010I665NFQ7IXtH/nYQmAfdK3zls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0he3dztMO7heFYyXyncQ4UW0j2EAUor7E4cyPPIbTlFYS9OKTOuhb4+Zo/OFaUOSBVUF6HJYA9GydujX5cYrOEMktShGsJPvAgg5U5IHhuWTChFKa1+GCaSiTc20ho1VjEWFMKAZV48C9pdRM2G5Wszj2ubx5GrBw2GjVTYRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxbkzECo; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxbkzECo"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2aaed195901so6545455ad.0
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 20:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777606176; x=1778210976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y5pMq+0ztTJey3vt9ZG8NcMewBWSWt2n8Zyo2B0ipWk=;
        b=AxbkzECovBsRtT+F4Ka9KfuDYyw///lwX3k+k5SJfDwSeY5ZY/40+AitWG0OAsbFRG
         TsWvemnNmbl1ZWbgKcOg33kn1c7n9vkIjcliB0TyXzAgbYJHZsY7yxrohix0qhiO/1v+
         hB/OeH1Deu0MQKow1/1C5eptpAPz2tIAvDI8wqjHNz/312y88YQkDrDaGTuSTi0ux2iJ
         lbEz6lpI9WlMay3GsgVc80WE8hP31my5CRUdRmxqC7+sWIJ738RbGm2gCC8qCzZO9/oP
         OrMjqpAkrpzK+tA15Crl/A6uLp2UiFai7LSvuLZbMnNsFnQ7d64yg0KboWlUcbWVT909
         4L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777606176; x=1778210976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5pMq+0ztTJey3vt9ZG8NcMewBWSWt2n8Zyo2B0ipWk=;
        b=a5fsXJFDzj0rhSXeA0Y08BzA4lVzCkf8Uxq9tJktvZFJatbcLXxHBGYGV1SlOxRk1i
         yHgj2d/jKhKrEM0BhpOhvHNxI0RFDMPuP961et0gLBLijl8eS6ED5yhgvBz8l/0EOObT
         Om21JUslNRtPH5RpYWBU9CQC//Thf2Ocdq/EyJhqkE9/Zz/yjzSqKDOXGJLmopdak8I7
         R/XlG88SYYtEgdPz5qnRYzUkpHcfyNauP1U8PG++5KWL4gvIYxMEIT7lCwLgTf9fIblZ
         M7EjtDnhN2JsuxesGMO41i2rkguxbBjBzf+NhDkPsK14FQ9y+Uhh1MAuMfhZjJQ30RQ3
         jLbw==
X-Forwarded-Encrypted: i=1; AFNElJ8sUlKfyB0E8643u/MHjL16AsJsnKqgSGhpk9/defQGg5398N6uutRKxwaAZL9tF9iFXsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8vqDJiJwJnB7Y5Jt/mES2lgvjUUwa1BiLb3NTjEAAgK/GUsiY
	Wso16b9k3n/39yvCqBoJCJppMAHrUrgKfKKzkOE+nnc+xvjnTyz+13aH
X-Gm-Gg: AeBDiesvZXdRnYFn7uY6CrC4gSukXpPK/0IYR1Y24BmzFFUkJsnA6F400FrJ/37/G86
	kSsmrS8Gr6bdcxgGjqbKqUQW7NEB45nQKPoZVudn5EuJnx/6B365w8TXMztr8qfCAIgtJPkehIR
	T1Wg3oIePRjTei02rRdgeZHpQWaxfhRc+MgbvPh8qp3+xGaauZtDIPvFkuCBVSaG/vcNMXKAdtf
	UUGtq5xRzrzldHM8jgWk9+7jkHtTGN3WZwtlcmbUt/uhT/lrWXLp4pYTU+wiDmb4ZVLAonLKRwH
	+HqkzOECmx/qYEBNzNygaYD8Xgg7/aG43uVl9R748T7WR3kh2NHs3N/12epmk5X8/RVKDBkKgFD
	2PLVoSIz3ZMTc6imLKWtUd6/GFEFwywSSYnX6KTvxloyBg4tQ1YDxmHo4WvEenD90XTgrA5G9WW
	lsxJGGgNbyGvjuWiSD+ybJXF7D+cw=
X-Received: by 2002:a17:902:9a81:b0:2b2:a267:784a with SMTP id d9443c01a7336-2b9d442a93bmr7345535ad.24.1777606176324;
        Thu, 30 Apr 2026 20:29:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ee38sm9906495ad.16.2026.04.30.20.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 20:29:35 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:29:35 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v4 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <afQdzWlMzjgpAUq7@devvm7509.cco0.facebook.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com>
 <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
 <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
 <afIeuwJNfwVmk9Pn@devvm7509.cco0.facebook.com>
 <CAL+tcoBTO9QGM220EO=m1TdiXwod7QzG59j7vQL3qoVSrb2QEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBTO9QGM220EO=m1TdiXwod7QzG59j7vQL3qoVSrb2QEw@mail.gmail.com>

On 04/29, Jason Xing wrote:
> On Wed, Apr 29, 2026 at 6:14 PM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 04/29, Jason Xing wrote:
> > > On Wed, Apr 29, 2026 at 2:11 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 04/24, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > > > > uintptr_t cast:
> > > > >
> > > > >     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > > > >
> > > > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > > > > the descriptor address are silently dropped. In unaligned mode the chunk
> > > > > offset is encoded in bits 48-63 of the descriptor address
> > > > > (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
> > > > > entirely. The completion queue then returns a truncated address to
> > > > > userspace, making buffer recycling impossible.
> > > > >
> > > > > Fix this by handling the 32-bit case in the destructor_arg helpers:
> > > > >
> > > > > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> > > > >   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
> > > > >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> > > > >   xsk_inc_num_desc() brings it to the correct count of 1.
> > > > >
> > > > > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
> > > > >   when destructor_arg is NULL (not yet set), false when it points to
> > > > >   an xsk_addrs struct.
> > > > >
> > > > > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> > > > >   before touching any other skb fields; on failure return early so
> > > > >   the skb destructor is never changed from sock_wfree.
> > > > >
> > > > > The existing xsk_consume_skb() already handles 32-bit correctly after
> > > > > these changes: xsk_skb_destructor_is_addr() returns false for any
> > > > > allocated xsk_addrs, so the kmem_cache_free path is always taken.
> > > > >
> > > > > The overhead is one extra kmem_cache_zalloc per first descriptor on
> > > > > 32-bit only; 64-bit builds are completely unchanged.
> > > > >
> > > > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> > > > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> > > > >  1 file changed, 31 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index ed96f6ec8ff2..fe88f47741b5 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > > > >
> > > > >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> > > > >  {
> > > > > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > > > +     if (IS_ENABLED(CONFIG_64BIT))
> > > > > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > > > +     else
> > > > > +             return !skb_shinfo(skb)->destructor_arg;
> > > >
> > > > Don't understand why we need to special case CONFIG_64BIT here?
> > > > Shouldn't the same existing condition work on 32bit?
> > >
> > > Because 0x1UL is the particular semantic applied on a 64-bit arch.
> > > xsk_skb_destructor_set_addr() sets it while
> > > xsk_skb_destructor_is_addr() recognizes it. They are a pair.
> > >
> > > As you noticed, one liner works but is not that appropriate: on a
> > > 32-bit arch, this member should be either a NULL point or a valid
> > > pointer pointing to a memory region. Testing if it's NULL can be
> > > helpful as to the long term maintenance because of its readability and
> > > robustness/safety.
> > >
> > > The error path in allocation of skb is really complex, which is why
> > > I'm so cautious to take care of it :)
> >
> > Let's cleanup the error path instead of adding more complexity? Similar to what
> > you do with your "xsk: fix xsk_addrs slab leak on multi-buffer error path",
> > but maybe add a few NULL checks?
> 
> Good suggestion. I think I can cook a follow up patch to do such a
> thing targetting net-next tree. This patch 8 belongs to net material
> which means it will be backported to the older stable kernel as soon
> as it gets merged. IIUC, the better way is to make it as simple as
> possible?
> 
> >
> > Instead of 32 vs 64, I'd like to reason about whether destructor_arg
> > is an address or an allocated array (not whether we have 1 or >1
> > descriptors). And we special case 32 bit by always allocating it.
> >
> > Haven't checked, but maybe this is all you need (besides your _set_addr
> > changes)?
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 6149f6a79897..03f217e85d31 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -589,6 +589,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
> >                 return 1;
> >
> >         xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
> > +       if (!xsk_addr)
> > +               return 0;
> >
> >         return xsk_addr->num_descs;
> >  }
> 
> Right, as I mentioned, how about posting a new cleanup patch with your
> suggested-by tag?
> 
> >
> > > I've noticed the status has been changed to 'changes requested'. Does
> > > that mean one way or another I have to post a new version?
> >
> > That wasn't me :-) From my POW, patches 1-7 are good to go..
> 
> Great! Thanks for the review. My hope is to get this series merged
> soon in the net tree.
> 
> >
> > > >
> > > > >  }
> > > > >
> > > > >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > > > > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > > > >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> > > > >  }
> > > > >
> > > > > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > > > > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > > > >  {
> > > >
> > > > [..]
> > > >
> > > > > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > > > > +             struct xsk_addrs *xsk_addr;
> > > > > +
> > > > > +             xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > > > +             if (!xsk_addr)
> > > > > +                     return -ENOMEM;
> > > > > +             xsk_addr->addrs[0] = addr;
> > > > > +             skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> > > > > +             return 0;
> > > > > +     }
> > > > > +
> > > > >       skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > > > > +     return 0;
> > > >
> > > > I think this is gonna be a 3rd copy paste of the same logic? Let's
> > > > move to a new helper and replace existing kmem_cache_zalloc places?
> > > >
> > > > xsk_skb_destructor_alloc_list(prev_addr) ?
> >
> > Any comments on this?
> 
> I didn't comment on this because I thought I was not that sure if we
> needed to wrap it up in the stable kernels :)
> 
> Of course, it would be easier for me to work on the net-next tree to
> make the code look
> more neat and elegant.

Are you concerned that you're gonna break something in the net tree? Why not
do it properly from the start? If you want, you can post 1-7 patches
separately and we follow up with this one but still into net?
