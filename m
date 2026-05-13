Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529B8382283
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686679; cv=none; b=kxVRKz0yFjJzwFG9NTETllcfZYIzMV3lZ/A28pOUUXo0UUHefabyqh9NqW44t3e/7tePExWWA5G9Wg69HNESmxZRS6+ptt1lvjHvLWH5vLJ980Phtzfeph3F+/FrIBNAH0Xn4BIcrGGNflchlgDSEWPNHChguzMttM2d7JfXlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686679; c=relaxed/simple;
	bh=8GGIgCX+zAQPtwUyy9GgPJRYW2fewUZJH8NYGs7OIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1OLfm+prgL99a6ZGJFby2tgjVMXNkX+lpj/pdn0G0HiSre/U2MZeo6jOFZl6bThJmGGQCA4n2D6f0TnoTWFfHG1ZvJkTAzoTJOj5FfHxncOComLdxxYU6nJ29A7ipuhIy4UHfYbydJ4bdi5OWfkthEg4pSPG3YE9A2rTLZgSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpLbaUIm; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpLbaUIm"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2ba856db1c0so47434895ad.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686677; x=1779291477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zEBKF7C4xRw4g2kc1/IUvgMJHt3gkAWQ6iC67xzyWuY=;
        b=QpLbaUImdLzDGrUvaykku3djPTK4Mdq8LYCDQZW9FEJxckK6G7W9IgbNFUr4eDfi3s
         dSjzsOV6Hi95hBwwaMT06mwYu6rE4vSqc8QI/Oa23nJ95lgmFypH2+hO3AJItSQO2HLS
         cVkDvFiOaJ7XGxqpQx2KGcibJWAfQeFPaFbvDZ46LgWQyxxGFzQ7bYbwgAYXWhsDhLKG
         Eil1WQZf/emh90NN8OJ9oGt6IDjiNVRcoCmKtDAX7vS4ggYy5PDKPJ9BZ3rsIkeJuKaU
         B8X2EwufoDAUpZZUaVRStiIo2b+JmKCVAqOQIAf+YODgQ4v9cqYMqpyyfYJd5YSgFy1C
         YKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686677; x=1779291477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEBKF7C4xRw4g2kc1/IUvgMJHt3gkAWQ6iC67xzyWuY=;
        b=pzByuMLAbxWSMNFSc4iUN+25I/awNScESkh6/qfi20PgJ45qjxTFXIDZlzD7q1uRIh
         15kRC4OI4fGdkmdqgPVV7pUvc37smFliWFfk2PonWdJb/vw+DaTcmrKvmjJsRPBuCgh5
         alI+5P5M4VHbAXf4U5YxAxKs08g7Q7Tib0i5Db8T0J+qNLX1N4W0U01BbHuTEZcoBkUn
         ZrW9lYj+q5JhlAojUW1lSBgHy4REGfr6Hj0NvzwnJcVPgHhZNbJT/OSHCwB4k0im5qUE
         b9BUuaxtwEtkmXNlG3MSfoqd2SY7xiCekHQoy3YsVzdI8qQQcuRciZr6WOUBUcJNo5+T
         9DMA==
X-Forwarded-Encrypted: i=1; AFNElJ+zUCKkLUbmd6ijtTGJBDrcqoZzlEAIAk6GYzxLrhM5uz/ehj/5uYeqfgfhVKahLsV5hvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2uuDZQ78kKFmRCVFP+SQtaRqLUDrqoVP/AaT8tVXXc55du4LG
	SmVRDxcjdLviZNAh13K0ZXpdAmJAK6Kb3zMLj8T303M+TH93OcgaP60t
X-Gm-Gg: Acq92OHD7Zv1LPvsn0DOcfYSfB+gzVcl3PC0e+3uD+nizcFYREEIFYCET+xaFEgquYU
	3tOiDWGBRy3kj8WYyWowAfS2xAPnWHsjWXKJN9uk41oic23D/srIFrioWbUAfdWPpwqm5L8MxRB
	35qwkzyKS4RrcqzmULxqvNVzZhpyyWhBaecsw4AKIBEL86aS4CHG91rBvjX3jjITJe4qzzGqLmI
	sxfDbXJeXqWAbBAsjteY1+EWIV+gCfzY8cWfCYNo9xmpT9Vkpj+wEx3vD2TnqRvAJ9SmtPRZSuH
	wmVDpKsKJiVRS5JsVWsMGkP7Hkc37sHpAiwlNuOh1/FL5+17+bw5G2LILwqUjdT0zHsiaSortya
	dFGMv/m3HVgBWQu0EMxxK59LZpvOj6v2bylol/iLnk6vmFv6bYE2EXANDh363B/XYxEwY+MEKbv
	geg/2DWc/oPD6ouGDOhRqeKeNrgVA=
X-Received: by 2002:a17:903:3c70:b0:2b7:88f9:9c3d with SMTP id d9443c01a7336-2bd273aaae9mr40364395ad.12.1778686676561;
        Wed, 13 May 2026 08:37:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm165648865ad.44.2026.05.13.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:37:56 -0700 (PDT)
Date: Wed, 13 May 2026 08:37:55 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <agSaZtBh-v6isF_8@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com>
 <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
 <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
 <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>

On 05/13, Jason Xing wrote:
> On Wed, May 13, 2026 at 6:34 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/12, Jason Xing wrote:
> > > On Mon, May 11, 2026 at 11:03 PM Stanislav Fomichev
> > > <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 05/10, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The TX metadata area resides in the UMEM buffer which is memory-mapped
> > > > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > > > csum_start and csum_offset are read from shared memory for bounds
> > > > > validation, then read again for skb assignment. A malicious userspace
> > > > > application can race to overwrite these values between the two reads,
> > > > > bypassing the bounds check and causing out-of-bounds memory access
> > > > > during checksum computation in the transmit path.
> > > > >
> > > > > Fix this by reading csum_start and csum_offset into local variables
> > > > > once, then using the local copies for both validation and assignment.
> > > > >
> > > > > Note that other metadata fields (flags, launch_time) and the cached
> > > > > csum fields may be mutually inconsistent due to concurrent userspace
> > > > > writes, but this is benign: the only security-critical invariant is
> > > > > that each field's validated value is the same one used, which local
> > > > > caching guarantees.
> > > > >
> > > > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> > > > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/xdp/xsk.c | 11 +++++++----
> > > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index 6bcd77068e52..cd039e397018 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > > > >                           u32 hr)
> > > > >  {
> > > > >       struct xsk_tx_metadata *meta = NULL;
> > > > > +     u16 csum_start, csum_offset;
> > > > >
> > > > >       if (unlikely(pool->tx_metadata_len == 0))
> > > > >               return -EINVAL;
> > > > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > > > >               return -EINVAL;
> > > > >
> > > > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > > > -             if (unlikely(meta->request.csum_start +
> > > > > -                          meta->request.csum_offset +
> > > > > +             csum_start = meta->request.csum_start;
> > > > > +             csum_offset = meta->request.csum_offset;
> > > >
> > > > Wondering if it's better to READ_ONCE(x) these?
> > >
> > > I still chose not to use it after reading the suggestion from local
> > > AI. The reason is there is no WRITE_ONCE pair to make sure everything
> > > is no data-race. I also checked some existing implementations around
> > > the shared buffer (between userspace and kernel) and didn't manage to
> > > see the usage of XXXX_ONCE(). Does it make any sense to you :) ?
> >
> > Without READ_ONCE your patch relies on the compiler honoring exactly the
> > loads and stores as written. Which I don't think it does (hence that
> > whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
> > the same code (and read csum_start twice) even with your patch applied. Happy
> > to argue with your local AI if you give me the output :-D
> >
> > I grepped io_uring/ and I see similar pattern for reading user supplied
> > entries (via READ_ONCE).
> 
> I roughly understand what your meaning is here. My thought is the
> data-race condition in this case still happens even with the
> READ_ONCE() protection (because no such corresponding operation is
> performed on the writer side).
> 
> Actually the local AI said use READ_ONCE instead.
> 
> I can change this as you suggested for sure. Maybe related fields can
> be protected in the same way in another patch.

In general, feels like we should be doing READ_ONCE on all user-supplied
descriptors (to make it more apparent that those can be concurrently changed
by the userspace). In practice, probably too late and too much churn to update
everything at this point, so let's only fix the ones that can lead to
TOCTOU.
