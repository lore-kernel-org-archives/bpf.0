Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02326ED5D
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777328416; cv=none; b=Mpa5hWXmnUae3NzM0ooqPdDRI/LCBHw7LfBNEyG93lkc/4afLnr/NnHGBL6yh0EwolpuGcdAU88sdpqIVKOMGiNkveC8vmb/QGx+szaFU0w4gGlC35QZotNl3DkZEFWaPr5suWPJbF3BWW4uUN7vUlM+kSooW13pTDLkqbhy+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777328416; c=relaxed/simple;
	bh=zQY1Ihl95rbJoD5Pls+d6pgq5/lc9rlQNQ7ivWYBUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBrZYckuIxB4g7Cjy4fqaFEahtBZ4QZFJnjaGTYIo6fRX+R6do4pxTGeHs6QgOkyW6mrXDoalZ4bPOyAsWgbLJwzxAk16r2BSLgtMu7SEi8i+2686fav2l6zZGtC6akONgKUZEiLKa9CIR5+cPgy8Rv+eTnAx97PxLZ5iQO5hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pRHQSdrA; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pRHQSdrA"
Date: Mon, 27 Apr 2026 15:19:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777328402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ng1WXyLPPjx7rAj1wQviBH2PP9whqvsrITu7SO6o16M=;
	b=pRHQSdrAbf/h1BDS/0yaVND9jPyTo1tiflzD9xE134bK3ZSxrmREwRwYb4l5Bl1ZMsnno7
	f4U0+K9k6pU1Mm2Rp9UKw9zPcgIdIrsvt2NEgxdhhZGpBwxJzu6aXtckMJoAgDva+7Vte1
	ohckSY8BSSLR+ifiEXhleWu+iqTCrko=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: nhudson@akamai.com
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	willemb@google.com, mtottenh@akamai.com, aglasgal@akamai.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v5 5/6] bpf: clear decap tunnel GSO state in
 skb_adjust_room
Message-ID: <2026427201356.-eYM.martin.lau@linux.dev>
References: <20260420104051.1528843-6-nhudson@akamai.com>
 <82df2b6834553e3f2da26e5ee1f1b880f8a1af073e6fd88894a4839c66b7b121@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82df2b6834553e3f2da26e5ee1f1b880f8a1af073e6fd88894a4839c66b7b121@mail.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Apr 20, 2026 at 11:19:31AM +0000, bot+bpf-ci@kernel.org wrote:
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> > +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> > +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> > +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> > +					      SKB_GSO_UDP_TUNNEL_CSUM);
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> > +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> > +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> > +					      SKB_GSO_GRE_CSUM);
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> > +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> > +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> > +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> > +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> > +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
> > +
> > +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> > +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> > +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {
> > +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> > +						  SKB_GSO_UDP_TUNNEL_CSUM |
> > +						  SKB_GSO_GRE |
> > +						  SKB_GSO_GRE_CSUM |
> > +						  SKB_GSO_IPXIP4 |
> > +						  SKB_GSO_IPXIP6 |
> > +						  SKB_GSO_ESP)))
> > +				if (skb->encapsulation)
> > +					skb->encapsulation = 0;
> > +		}
> 
> All of this new GSO flag clearing logic is added inside the if (skb_is_gso(skb))
> block in bpf_skb_net_shrink(). Does this mean non-GSO packets bypass the
> decapsulation state clearing?
> 
> BPF programs can call bpf_skb_adjust_room() to decapsulate non-GSO packets
> as well. If a non-GSO packet undergoes decapsulation with the tunnel headers
> stripped, but skb->encapsulation remains set, could this cause downstream
> network stack components to misinterpret the packet as still being
> encapsulated?

It has been asked multiple times by different AI review agents but has been
ignored afaik. Please reply/address it so they won't reiterate. From
a quick look, bpf_skb_net_grow() sets the encapsulation regardless
of skb_is_gso.
