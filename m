Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE02F549F
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543092; cv=none; b=fe/VoDgAp3VdznTTAxXS/RhX0hvLMwWsq5IQyRqsfImjdJVbkTycyPniX5p0OZKBHZDksjT7sMtj93ywn9+tKti4Yyohi1eSr+T/9pEf7ockIMCsPMzfAOVvZqTMiU7D83U3G+tsuxW27qOKexw/3QGGH8eR68W5imNSZdvtTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543092; c=relaxed/simple;
	bh=ZQZICDYgbRgiUxmzpxgAJ9erLVWkdQLc9nJ8avEn+Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mijDupebkGpOFJMDR+yCDOeP59EN4NBBLfoCGLcXAQ0lg59gxrG/IjxWalCl6MKfSgMd+SN81Ann0HvqN44uwv/i0E6HxDY/m1z7OW7dSfA0aSE/8SBgwamUa+DEsrO8IDVgnS7ikNv/h2Vav/VZTcE/tMtUf4CI6mQ2HrM2KKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=vg5IcwTi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="vg5IcwTi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4955adb04e8so7568095e9.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 03:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1784543089; x=1785147889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zd72l0RJ8ftcCUHhUbD81aNG9YQZtgyyjQP2cHWS9d4=;
        b=vg5IcwTim6+mko0v5reuGZG8ZIxKuY1jOOnPyegZZKYzqPyESW98Bgse4+tZfyjsUH
         BbDmk4bVMjgg5CUux2RYjSz5Wn27waC+NHp03PutvJNlJFCjKawqL3ijk3ub29LTAb/6
         42l4ly/okxkVmher7uYz/dIQo3upJKc+8jgjpR3jwbweagqO+nRqSWZcHmc3i3BVD9yz
         q1TrdfydVJOjMs2X+ki17sOllSYUumDeDL59nuwir1oahVIPQnRaBDA5bgAk+4yr9Vbh
         /2pj1R6+BPN/HQAkDAV2hrGxMyMxCvVb/GpxNMOp9lC5lq7d+OpfQTa8vab3BZFthzQ5
         vXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543089; x=1785147889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zd72l0RJ8ftcCUHhUbD81aNG9YQZtgyyjQP2cHWS9d4=;
        b=fg3JEsNY1JXB224OQujGKrPH2usyPBWRPBSncdx4wPtq3+6S38vKcodBVRRwz65Ymu
         K9B2o5JDbWlbIeWjF6P7fXKb63MDVXjtZmmcSEX3MhGp0377b7rB9zMQK1/UG2CWzIxQ
         a2qpGT0AfWS4RGjpLxYV0KCv2I07zlSznVS9Cvr6XGjJpNdWinL93hH7Yr8HZmwaJ9Gf
         gReJXZuz99u6SdJp6oQL14aPnazEvTI4zY2yO2LypcVghJZvWHmp0bA8NcX03Kj6XeJ5
         j39y/dS5JgIbHGYjBzg6EgMlclCs3E8Di5ZZH4EVcXuqPxzbEhzXHKmIV8rmiRLUvLLc
         0AIQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPi2+UNC0KBEj8dbvzXeAg0RCo/tiwPKtnrjkduoPviP/anJSTjppzwg84nEKV4wu7Wp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYfKfttWoi5WT4WYGs1A00NessryE5Nty85RE5c6xXk2mZ6dq
	NUm1Ljmz7yWrMz38bhMeCS09m4GzdB2Gbhy+5EHf/9cjSQLQvYMqAzqo0x3k+axgLnE=
X-Gm-Gg: AfdE7cmgTe6L6kKy+WrJxH2kNOIWO6R96vGLpiLWnMrU8umwrAW16Uo7uinUP5fkIg7
	bsxPM31FoRujYtCxeHQAvztOHwTzI8mRl7JVlCPahW5I8A+rh25+7tBuI+SzKxwveVXHuLPr6aN
	hbk6NJcjewBIk5Hzi3qLDj+zGhtZyGXXntOx6p/hzISD7D3pPDSouICsBtZzgZd4/7tY7Htk9xC
	bIb2X06WOET+LH+nUP9lPikOmlZSPGb7fzXT3LyFxeUBtRMFQf/90ebhXDZcIq+grNb1tZAdlge
	0k96BtMCeuvRbIay5rR5eODgGC1xu9N5XYGkSUx/nKos+LTjyGokxscBvjn/ssKtfOc+BytRrKo
	Wu+CLFzl+FWThHF8BUaIxijLJXsr418mimQT1B9ylT3uQW+wn2T+AgudEPCfQuoUZ
X-Received: by 2002:a05:600c:4f09:b0:495:5b32:df72 with SMTP id 5b1f17b1804b1-4955b32e0c7mr61903515e9.35.1784543088526;
        Mon, 20 Jul 2026 03:24:48 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1cdc::2e0:ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c96fecsm318116205e9.11.2026.07.20.03.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:24:47 -0700 (PDT)
Date: Mon, 20 Jul 2026 11:24:47 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, kernel-team@cloudflare.com, 
	Matt Fleming <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf] veth: convert frag_list skbs before running XDP
Message-ID: <al3oXdjTYM_PziJp@matt-Precision-5490>
References: <20260716100605.939654-1-matt@readmodwrite.com>
 <87jyquj5wm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyquj5wm.fsf@toke.dk>

On Fri, Jul 17, 2026 at 11:56:41AM +0200, Toke Høiland-Jørgensen wrote:
> Matt Fleming <matt@readmodwrite.com> writes:
> 
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 1c5142149175..efb24aae1f26 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -756,7 +756,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  	u32 frame_sz;
> >  
> >  	if (skb_shared(skb) || skb_head_is_locked(skb) ||
> > -	    skb_shinfo(skb)->nr_frags ||
> > +	    skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb) ||
> 
> Isn't 'skb_shinfo(skb)->nr_frags || skb_has_frag_list(skb)' basically
> the same as 'skb_is_nonlinear(skb)'? Which, incidentally, is what
> generic XDP uses in the check that guards calling into the
> skb_pp_cow_data() path.
 
Yeah, you're right. I tested that expression and it still fixes the
bug. I'll update v2 to use skb_is_nonlinear().

> Looking at those two places, generic XDP checks for 'skb_cloned(skb)',
> while veth checks 'skb_shared(skb) || skb_head_is_locked(skb)'. AFAICT,
> the latter is stricter; should we update the generic XDP check?
 
Possibly, but the surrounding code isn't set up to deal with
skb_shared() SKBs so that'd be a larger change. I can take a look at
that too but I'm going to need more time to get my head around making
that change correctly given that there's different fallback rules than
veth.

> >  	    skb_headroom(skb) < XDP_PACKET_HEADROOM) {
> >  		if (skb_pp_cow_data(rq->page_pool, pskb, XDP_PACKET_HEADROOM))
> >  			goto drop;
> > @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> >  			 skb_headlen(skb), true);
> >  
> > -	if (skb_is_nonlinear(skb)) {
> > +	if (skb_shinfo(skb)->nr_frags) {
> >  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> >  		xdp_buff_set_frags_flag(xdp);
> >  	} else {
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 18dabb4e9cfa..1e837d01a908 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -936,12 +936,11 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
> >  	int err, i, head_off;
> >  	void *data;
> >  
> > -	/* XDP does not support fraglist so we need to linearize
> > -	 * the skb.
> > +	/*
> > +	 * skb_copy_bits() handles both frags[] and frag_list input. If the
> > +	 * copied skb remains non-linear, it uses frags[], which is the
> > +	 * representation used by XDP multi-buffer.
> >  	 */
> 
> This comment sorta reads like a function documentation comment, but it
> ends up sitting weirdly in the middle of the function body. The comment
> you're replacing was tied to the statement below, but this one isn't,
> really. Should we turn it into an actual function doc comment instead?

Good point. I'll make this a function doc comment.

Thanks,
Matt
