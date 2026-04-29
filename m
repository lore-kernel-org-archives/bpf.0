Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82D2032D
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777434106; cv=pass; b=KEVYwHPymjF/+CNTZDCpmPRr2FWuhQuGqmVFxt/0x5mOhAHLaZPic3AzIFsdJgA0UF7/vZDIAbE4YfNJZG2ypNW7tExnfZtXv7kwZMiEZ4CKZVo7uaIhABuLaGdAvCXpcUO2J1tgA0XSONv9J+38OgPdaeMgeGBbw3fdjhFKuxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777434106; c=relaxed/simple;
	bh=1AgJ/iZ+yxVyTBccrjIytFwrSGBWeASY4/uRssTvWak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJB9Ca4USI/NMLNHxLt1rLQDRooYRJ79YqdxHTu+I2+2Pw2uiz48T0PoVQUEY/LJWmffwYFokagQ1pY5zSVxWPAEDC6IIFlLclcb4MDIFY7GgSbDk69cgGLNyCXdnQjCs6bXMcZm3M2AQ1hOWxjU05bPhwAXB8hFNcZg7Y3biKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyUYd35E; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyUYd35E"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2c500750dso13784817e87.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 20:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777434103; cv=none;
        d=google.com; s=arc-20240605;
        b=V2aZpYNDhCEZbUqmEUKyVGjz+nshp0Jo0waKUNvvhtDv1W8Hwo9HqDFrIDosHFh5Ij
         TteZYmyPbj+/YimZQKXLyrgOVNPfkMUsaAojBVqk6zIEEXqlyxPEGN1AOSDWNGaPZRXk
         bYO/hg7VjBsw2fy0mBwKZ3om4s1RSxbSO5DVuGoaIOB/jHwzUyNlTID75wg1CIJMoWiR
         hF0o4SO+wGUMLqMefE9NU6kRAgBcHMrWTSQUDps+C098jxeTqyX7MrlPvJjD3HmYnJO3
         cWE/ALkh1pQsBNDqun4Ia/G6OGgx356j/OyXtFFL/TS3HB69SMQSHk5GCN866ixhcSq8
         DGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Ruk6MIfAq6RGeIbwYOky+24mFcxVrwW7kYRMU64s0I=;
        fh=siJe1L9a5bbpRS6iYrvYHJArMVzJAGHn9U8UIK2DC2I=;
        b=hXbLcz/dzfxwfets22UOAi/cW/Q1cthuVhpnaE53fPRqc3ZAKWJ66ywwFOX226mCET
         kQqadcG+qdMcpEeD2crCRGxkiWinY7WCVgMCRFQpVmeFrZ/h3L1M1kQhwr1g+ArNh0x3
         ffW9q2UQEr11q1dyn6b+N2QBUQsHLEW/mvv1spTuK2OspXrHv8QxAlIgmrVsBtFClCKM
         BCn5N0rWB9CNxsuokZfYP5guWRoekMRFm0yCeqlLL7A5gdOox6rsEaf88aYVbehKZkxW
         j62HqISTIy7bG72BOlrLpKflxjOWBoRxp8YPF/hMpUIHbsrH29CcQCIsg7lhsNXvLflO
         1f0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777434103; x=1778038903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ruk6MIfAq6RGeIbwYOky+24mFcxVrwW7kYRMU64s0I=;
        b=QyUYd35ETYIrBF9kk0eq2RX5Q6bvETdL1xZ4UW+aC8xpNA9HGy4D3/Fta62a18Cbuk
         CM9W6CmEXaHF6R19a4oTk0EUy/ANSe1zsOJoRRWwOpryLenvYYd/jvbgZXiLqfAvPs2Q
         svAv+5PWyz8UA54cp9qLTkLjhsPKb41SGaT3coPvlULLuYHZu+f9h8Y6tO1IGlrdPXmp
         zCjpBQK9x7IgKEAtE8LQ4Elu9hbhHNGaDQymKQ9TQM8StG8TUsZl8dTP03sWNaSXluj7
         YGSzgagUnZIk19YQ6erjySVH0mqdn1OhscY9gUQV45J/ED0CjzwN4K/U4lg51MtDFtRd
         um4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777434103; x=1778038903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Ruk6MIfAq6RGeIbwYOky+24mFcxVrwW7kYRMU64s0I=;
        b=VJuh/0Cgs/g/H55Vy3/G0NyXDvO1GGM/9i8jjjB6mqvVuR0tYIA8JTKMgDmeS0vjNQ
         CsfMj4ZvMkDtPS4Ywl/0zx8a2r3A6aLRDDjdR8lK/POxZXd2+O200IUND49i/voYliyo
         MFmIAQFOOw+p1WQubW3Lu7p4sAqG33ycgZM+G0aziEGq698L0hYSgOfM0vp8bAkU8zaB
         6kSCVwSyqe0Hjgre3CnKgfaxd/cWwv9OHrfVSgT8x5d5AKCK33sTXtsg585/Z9nQv19s
         btTfwDZgj5f0892UCR0KlFejqrbgsJuI1qe+6wt4aBgtb6cxNLoLhx6LD86rr0xYZrSf
         U+2A==
X-Forwarded-Encrypted: i=1; AFNElJ8xYLKHliGGV2mAqYqauLxYP9XWYnzoPvZemx98HGlI8BNRwWb5qVKjoReSWHdgMpeTas0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExp9rjFSwx8tZS15G9kTQvRwqY7osih1r/Zp686ELNItLg6ln
	j+uBjRJ2b3TSmzSiJU4ayEmRIy9v6/e4keBOeDAIfKq//ujCfT6hnzSxadZU9HUwH2zsEq75CKv
	tKdB4R5w1Cfywy9ZQpByVHv6nMOuqHeo=
X-Gm-Gg: AeBDiesEruIjGXld/6WZSYjNLkOY8O+/P6sRE2EncecoJMFZH+gdqrdudk9bTcXsHvn
	WdT9VCZPw4+OhPRVcD7DPOQH2OLZr8VboG3GVXCGypro6CKnNUZftDcp+zEkYknVZqq5K0ZFnqV
	vOP/K7n4UP4ZDZj00P9LEGRO9YKZyV88d16ASKN3JzXRFg865GaGnrANQXFlM59VLKERBXIhltp
	a1KkhP4YIcIWhDuvYn4wc6TtIecYSs4n1krFENfHkXW7mPoRtg89sAXYCub2jlAaQXM4NEUdbr3
	Ex0S5F+GY84KoCIN2YxkxIPgzWG2qpNCub1qo2jXmk8PxTM=
X-Received: by 2002:a05:6512:114c:b0:5a3:ccae:c650 with SMTP id
 2adb3069b0e04-5a74660ed58mr2159980e87.26.1777434102764; Tue, 28 Apr 2026
 20:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
 <20260424053816.27965-9-kerneljasonxing@gmail.com> <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
In-Reply-To: <afE7EFYdrNg1u_g2@devvm7509.cco0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Apr 2026 06:41:05 +0300
X-Gm-Features: AVHnY4KK9bx9x3EL_qgNLT4hjlw0wtoxviJnnLnGHp1l0EefBQZ5qSnKZ_YCOio
Message-ID: <CAL+tcoA0j+tHOPr-DLyW26_EF1JhwqV+no0Lcx335FtKRbwUAw@mail.gmail.com>
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

On Wed, Apr 29, 2026 at 2:11=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 04/24, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > uintptr_t cast:
> >
> >     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1U=
L);
> >
> > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > the descriptor address are silently dropped. In unaligned mode the chun=
k
> > offset is encoded in bits 48-63 of the descriptor address
> > (XSK_UNALIGNED_BUF_OFFSET_SHIFT =3D 48), meaning the offset is lost
> > entirely. The completion queue then returns a truncated address to
> > userspace, making buffer recycling impossible.
> >
> > Fix this by handling the 32-bit case in the destructor_arg helpers:
> >
> > - xsk_skb_destructor_set_addr(): on !CONFIG_64BIT, allocate an
> >   xsk_addrs struct via kmem_cache_zalloc() to store the full u64
> >   address. Leave num_descs as 0 (zalloc) so that the subsequent
> >   xsk_inc_num_desc() brings it to the correct count of 1.
> >
> > - xsk_skb_destructor_is_addr(): on !CONFIG_64BIT, return true only
> >   when destructor_arg is NULL (not yet set), false when it points to
> >   an xsk_addrs struct.
> >
> > - xsk_skb_init_misc(): call xsk_skb_destructor_set_addr() first
> >   before touching any other skb fields; on failure return early so
> >   the skb destructor is never changed from sock_wfree.
> >
> > The existing xsk_consume_skb() already handles 32-bit correctly after
> > these changes: xsk_skb_destructor_is_addr() returns false for any
> > allocated xsk_addrs, so the kmem_cache_free path is always taken.
> >
> > The overhead is one extra kmem_cache_zalloc per first descriptor on
> > 32-bit only; 64-bit builds are completely unchanged.
> >
> > Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.ker=
nel.org/
> > Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor numbe=
r")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk.c | 38 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index ed96f6ec8ff2..fe88f47741b5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -558,7 +558,10 @@ static int xsk_cq_reserve_locked(struct xsk_buff_p=
ool *pool)
> >
> >  static bool xsk_skb_destructor_is_addr(struct sk_buff *skb)
> >  {
> > -     return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL;
> > +     if (IS_ENABLED(CONFIG_64BIT))
> > +             return (uintptr_t)skb_shinfo(skb)->destructor_arg & 0x1UL=
;
> > +     else
> > +             return !skb_shinfo(skb)->destructor_arg;
>
> Don't understand why we need to special case CONFIG_64BIT here?
> Shouldn't the same existing condition work on 32bit?

Because 0x1UL is the particular semantic applied on a 64-bit arch.
xsk_skb_destructor_set_addr() sets it while
xsk_skb_destructor_is_addr() recognizes it. They are a pair.

As you noticed, one liner works but is not that appropriate: on a
32-bit arch, this member should be either a NULL point or a valid
pointer pointing to a memory region. Testing if it's NULL can be
helpful as to the long term maintenance because of its readability and
robustness/safety.

The error path in allocation of skb is really complex, which is why
I'm so cautious to take care of it :)

I've noticed the status has been changed to 'changes requested'. Does
that mean one way or another I have to post a new version?

Thanks,
Jason


>
> >  }
> >
> >  static u64 xsk_skb_destructor_get_addr(struct sk_buff *skb)
> > @@ -566,9 +569,21 @@ static u64 xsk_skb_destructor_get_addr(struct sk_b=
uff *skb)
> >       return (u64)((uintptr_t)skb_shinfo(skb)->destructor_arg & ~0x1UL)=
;
> >  }
> >
> > -static void xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> > +static int xsk_skb_destructor_set_addr(struct sk_buff *skb, u64 addr)
> >  {
>
> [..]
>
> > +     if (!IS_ENABLED(CONFIG_64BIT)) {
> > +             struct xsk_addrs *xsk_addr;
> > +
> > +             xsk_addr =3D kmem_cache_zalloc(xsk_tx_generic_cache, GFP_=
KERNEL);
> > +             if (!xsk_addr)
> > +                     return -ENOMEM;
> > +             xsk_addr->addrs[0] =3D addr;
> > +             skb_shinfo(skb)->destructor_arg =3D (void *)xsk_addr;
> > +             return 0;
> > +     }
> > +
> >       skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x=
1UL);
> > +     return 0;
>
> I think this is gonna be a 3rd copy paste of the same logic? Let's
> move to a new helper and replace existing kmem_cache_zalloc places?
>
> xsk_skb_destructor_alloc_list(prev_addr) ?
