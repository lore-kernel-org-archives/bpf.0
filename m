Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC1372B59
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475695; cv=none; b=R79mvdpiyzzgTfz411Ot5bvW+WNHblwq4v6d34zqvLtGzyhTnkt9ovdNPFKZxh0ncX2/uT7UZrSQwvn5e2dZWBRQDFxwhxV8nKMPyNTsmi0JaXlnfuj2cnXw291zCc7p/LovACSC4parRG5n6O07drMXSMp3Ct6Y9vN2z2Svex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475695; c=relaxed/simple;
	bh=BspWGzgP3VHgFLMwTG1WzVTslDlWt4FlN7uDeE0blwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bykvLm3gXKuHHQG2hWH5mrPqa8FwTes+HBefSEO3IOArD57wlXgl7G9WoqF3FDubSioi4+yfXwKfwYHYNa90Werl+NYwNWS1YUu/EpqsyQ0lrld3uSs2XhL3yba3V+rZ11JlLJR+QZzzmXEft5rPAKgGu+4m9VBdBoeWmPWdhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5YphzTv; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5YphzTv"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab39b111b9so53036525ad.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475693; x=1778080493; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QNh9rYU4XM3OVhht+9ImRatweLA/+G0hxT8HEvEZ5js=;
        b=I5YphzTvgsN2wPoHDBqO37QmSObWCe+xTyzjuHrTkCU1PbzcJSBOUkxvrEqXiZewNc
         7Nb3sem1tYe1vPFoh3OZvKwHRFH0Gkj07Svt7uleya4Dzh87p6ST6O2l6Qi3I3uh3OvM
         0+e+Pe8uK+MR22EOMZBnvn6QqQDpOMDmmDIGm0tVCQhOuNOZiDc5GESgrIrVCkpA8vAh
         mtnkijpokOFvbVir/pyfV2p55HqPX5q6dculjCH/71IGbQReWh6LyvBHiTcbqqu0OJ/A
         fiPEFS0fHBO6AcUd4HVfXBfI5djZzm6mlJYVPXvQ/4sU/+jKwVdBVIk/FBPSST0FbCQR
         lMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475693; x=1778080493;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNh9rYU4XM3OVhht+9ImRatweLA/+G0hxT8HEvEZ5js=;
        b=Itjle+XudkcRzORdaaGeRb3K9uyb06Q/gfJfg99JpjiB26a7U4PQx2eT9fpRtIpaC4
         m+y9bn/yZiA9qrmtkYaBYgRF5c2WVjlfk0t4B0i/BrE73saW7L9wpmSu/W5eru1dU4dn
         UT5iFAIi/RHFfQxATnj6owvEbMG3Jpur0FGnmn9d9Dxa566cr/BgvcMOtA/8bV4Xd1dH
         gdVUtLlEQgiQaWkWpJRuPSkETiDSb3YdlMixNqa/z6TXpi4qOwi+KSR9Zl0zQW3TkJYs
         YlTrES/3EFGvNQqrVc+LJCuGnpXZVQpiY/8uO/xFS3pnSEAd3SEfm+yOYnX8MEhFKab8
         CiVg==
X-Forwarded-Encrypted: i=1; AFNElJ92v2ZRy7BQHr1LGtoX1m9+WsY8K9pewBf3YlO6x4XxmUo4+aEnHxHOWbx2P9P6bLWQ7MI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LhiNrg6zEd686UWwy3tE5OCsd7fqYsqam/5HfPNZppSlydh7
	SNE40cOUrHlv7Cf2BYFYw6KSq5dg4H1zZTiLelDl0tW24jVt4oAH7c8C
X-Gm-Gg: AeBDietan1nvpmwo1r3GkvxjPEDY/REeBsxL+Q83fJHbGyX9mRN4ZcVn3oh1gzPB0DM
	YJfJ+f/m73ICvFV2aUGFDUXKD1vncwSySdCTg7e6FL3obADvQL3sqeN8QkAfElcG+47nLVPsx9s
	kvOJRAvo5iR6LA81RVh42jTVaVhk7EQd09Dk6XoVdytktmvLRN1vJadXrXB8EVZIy/iTuUwwWOb
	hXBOyyRVpvaPE4Ih104Dwprx5hD/9uoNgbK1dyV/G89VHjlWKDn+DCny2c3q8Nvft/f7iiQRQu3
	S/tqUoG8SoinaHTXNkiDgIVh3x1GSlsND8DfaY1I7DJ6xlq9DVT/mZTJKKOceTzDApAPi3wtYej
	WGkdxHiiNM++snoA6zUJ9nFVZqA8zV/0DpcnJiipYIk7wtoPj0NGgImO0gIE65AKiwkqHTVPyRs
	JdHTB5KXGa63bGmJ/tujvopUQ=
X-Received: by 2002:a17:903:f87:b0:2b2:57df:264d with SMTP id d9443c01a7336-2b97c4dcbf5mr76447745ad.33.1777475692960;
        Wed, 29 Apr 2026 08:14:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988989d67sm25869385ad.76.2026.04.29.08.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:14:52 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:14:51 -0700
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
Message-ID: <afIeuwJNfwVmk9Pn@devvm7509.cco0.facebook.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com>
 <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
 <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>

On 04/29, Jason Xing wrote:
> On Wed, Apr 29, 2026 at 2:11 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 04/24, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > > uintptr_t cast:
> > >
> > >     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > >
> > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > > the descriptor address are silently dropped. In unaligned mode the chunk
> > > offset is encoded in bits 48-63 of the descriptor address
> > > (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is lost
> > > entirely. The completion queue then returns a truncated address to
> > > userspace, making buffer recycling impossible.
> > >
> > > Fix this by handling the 32-bit case in the destructor_arg helpers:
> > >
> > > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> > >   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
> > >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> > >   xsk_inc_num_desc() brings it to the correct count of 1.
> > >
> > > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
> > >   when destructor_arg is NULL (not yet set), false when it points to
> > >   an xsk_addrs struct.
> > >
> > > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> > >   before touching any other skb fields; on failure return early so
> > >   the skb destructor is never changed from sock_wfree.
> > >
> > > The existing xsk_consume_skb() already handles 32-bit correctly after
> > > these changes: xsk_skb_destructor_is_addr() returns false for any
> > > allocated xsk_addrs, so the kmem_cache_free path is always taken.
> > >
> > > The overhead is one extra kmem_cache_zalloc per first descriptor on
> > > 32-bit only; 64-bit builds are completely unchanged.
> > >
> > > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> > > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> > >  1 file changed, 31 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index ed96f6ec8ff2..fe88f47741b5 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_pool *pool)
> > >
> > >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> > >  {
> > > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > +     if (IS_ENABLED(CONFIG_64BIT))
> > > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > > +     else
> > > +             return !skb_shinfo(skb)->destructor_arg;
> >
> > Don't understand why we need to special case CONFIG_64BIT here?
> > Shouldn't the same existing condition work on 32bit?
> 
> Because 0x1UL is the particular semantic applied on a 64-bit arch.
> xsk_skb_destructor_set_addr() sets it while
> xsk_skb_destructor_is_addr() recognizes it. They are a pair.
> 
> As you noticed, one liner works but is not that appropriate: on a
> 32-bit arch, this member should be either a NULL point or a valid
> pointer pointing to a memory region. Testing if it's NULL can be
> helpful as to the long term maintenance because of its readability and
> robustness/safety.
> 
> The error path in allocation of skb is really complex, which is why
> I'm so cautious to take care of it :)

Let's cleanup the error path instead of adding more complexity? Similar to what
you do with your "xsk: fix xsk_addrs slab leak on multi-buffer error path",
but maybe add a few NULL checks?

Instead of 32 vs 64, I'd like to reason about whether destructor_arg
is an address or an allocated array (not whether we have 1 or >1
descriptors). And we special case 32 bit by always allocating it.

Haven't checked, but maybe this is all you need (besides your _set_addr
changes)?

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6149f6a79897..03f217e85d31 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -589,6 +589,8 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
 		return 1;
 
 	xsk_addr = (struct xsk_addrs *)skb_shinfo(skb)->destructor_arg;
+	if (!xsk_addr)
+		return 0;
 
 	return xsk_addr->num_descs;
 }

> I've noticed the status has been changed to 'changes requested'. Does
> that mean one way or another I have to post a new version?

That wasn't me :-) From my POW, patches 1-7 are good to go..

> >
> > >  }
> > >
> > >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL);
> > >  }
> > >
> > > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > >  {
> >
> > [..]
> >
> > > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > > +             struct xsk_addrs *xsk_addr;
> > > +
> > > +             xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> > > +             if (!xsk_addr)
> > > +                     return -ENOMEM;
> > > +             xsk_addr->addrs[0] = addr;
> > > +             skb_shinfo(skb)->destructor_arg = (void *)xsk_addr;
> > > +             return 0;
> > > +     }
> > > +
> > >       skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > > +     return 0;
> >
> > I think this is gonna be a 3rd copy paste of the same logic? Let's
> > move to a new helper and replace existing kmem_cache_zalloc places?
> >
> > xsk_skb_destructor_alloc_list(prev_addr) ?

Any comments on this?
