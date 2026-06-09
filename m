Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931674ADDA6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781029318; cv=none; b=dkRiT/L7anT8YERc6LyrlJhqAIvwVlDSsi//gLkWhMEmIZAhgfTlB994vJKkPmWnofJzVY+ki2fSjycOohA28HcvzeZ7bTpOiP387p2UNF4iNxP4jGfcw0+Bx1kXa0zZ/u0jhO2pNGK4Oa6Wv59bH2xal5uuHJ0tjS63Gtl9gmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781029318; c=relaxed/simple;
	bh=MDqw6E1NFQvJRAPqDEem1t57vShB0cBoV13q5Qxc330=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKG0o9Xd6vnM0b77Bib3EmIGfSduyd6+B4CRwsDUuvsVEKYms3axcG+Sar49wyQbmuatUSPzBiNKbg88TJdaCqCevndScfR3MwhHY4E0DP1VzXYsseyu4NgUXImSMyHYEAQxfUJEYNH1UQeCha5XK+F/cQ62o5dv5UmuOslusK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RawhVVrO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RawhVVrO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso5848083a91.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781029315; x=1781634115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcqjUQA9kv2/3qirEOddNlpBhe6IWcklo76jpxd9AfA=;
        b=RawhVVrOg/OQSQo4NeNprd+5IGEaO6LrXYvqyLhcdMI1qX8tsw7ujp20lc2/evpMFv
         Af8HzSQKo5wbE5yP7giG040BEh4VsgoXFF5eyBu4zctf8fAOhNwpIIxI30vPOFtPyapG
         OyDEV0ezgmRmVDj671vbbzmMxRqVUx9Gd39OmT0WU7DktyUqDpwYfg5YxnB1wssIDQv+
         UxynomBMz4uqNJVG7IUY/a4hcuq2MhA04fHbVfaIfJrv8kLPMzWizLpGxGl3KMtEEShJ
         sPl/5n2gRaSB5r/RTQ0DloP8xmbxrB9IYTTQ7zC068rdwk/Gz0MkaHq/Rex9jobGNBIJ
         1TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781029315; x=1781634115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcqjUQA9kv2/3qirEOddNlpBhe6IWcklo76jpxd9AfA=;
        b=EUAh2weYrsJCx2gSFhUpHz/Ech0bvNgUI6HlWf/5VKdtb3Q9WJ6xJJUGSrjS6J42co
         eoC8hK2sH/WQ6vBfI6MELhLx6ZAIso178uiLZes3hKQn2WRIpj+4DrtRubrBIbkDVyH1
         DhrNt7TH16vi7LQRY9nWDbJP6hL41gCgAEXu9sVzV3MF/tGEgBj8AHAArLnCwmH8LhGi
         b7dzP5pAhSy+2u/2U4zKOwJnyX8KZtwjMialmsJz47lPnPonRhDUBSoou2gZ3emW17aC
         MB6yRARXxHIx5oxDY7G6LVh+hdIE01GnXjPKiGdiFLJfDXf7Kq/YcfxNQByalxoMC1pX
         R5GA==
X-Forwarded-Encrypted: i=1; AFNElJ+dNze7HKS+ioHHUGi+qW+/VCBAT+DOwxCOSumd6MNkkNscp+xUQy1y1+5SQ7s6vc8lzyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfD5/5B5EQ8w/KD4VYLfDgupmYzZuBTwD+RU+GwR6QzgK9DVaZ
	ZPUBUY5RIYIbcw3g5oHacUb/KGWZFMHJEvvI65zZyTlL2ZV/Gg8QOXgj
X-Gm-Gg: Acq92OGsEw8PNi/AowGuRuwr539f9ebdgW9lYGbJptyhK5PQS+HMxt3lGHVUbsITAMa
	CWDDmbZuKjOkZHOLwmtAe8nobrmp6d35QwPssONYNUQGiyTSOu2woj3IxAnDnpOokuHxbHU2MMz
	FXxYm3QBHri67pwc6/FD7h++WGsfov2XMSx3DY+lkwMBOT3JqMpUpSgHLfdXwWJR2RH8XXsQ8iP
	eXDMjyKBWRNTj28CzSK9VGIbpbdrnUXiClFR7b8l93w64vaKehwWaynkVgZh4NF7DEqOQfC3gAs
	Xq3lzwa3r3H9mvpP4K2fNIvNJBh6FOoIOH97hhebIqScObNmPHPzLFY2KRF38iiqbQo9lqtrXt6
	Z+b7oK6ijl/QAuBGSPr/DzQrHYU+igf7p4knyImzozJzKiCmr8Xbmznt89mAyZ78hV4E7VohDbE
	M4lRY4+UUM4u9JqE6kh3Olss16Wk7967yIYbUMfoVz4mXI5XdCtc6BldNaz+X9d1ub
X-Received: by 2002:a17:90b:5109:b0:372:94b9:76d8 with SMTP id 98e67ed59e1d1-37294b97715mr15579831a91.6.1781029314769;
        Tue, 09 Jun 2026 11:21:54 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa072asm218684505ad.34.2026.06.09.11.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:21:54 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:21:52 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <aihZtYXz8CbxRo0L@devvm29614.prn0.facebook.com>
References: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609112316.3685738-1-rhkrqnwk98@gmail.com>

On Tue, Jun 09, 2026 at 11:23:03AM +0000, Sechang Lim wrote:
> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program to
> find the length of the next message. strparser assembles a message out of
> several received skbs by chaining them onto the head's frag_list and recording
> where to append the next one in strp->skb_nextp:
> 
> 	*strp->skb_nextp = skb;
> 	strp->skb_nextp = &skb->next;
> 
> and then calls the parser on the head:
> 
> 	len = (*strp->cb.parse_msg)(strp, head);
> 
> The parser is only meant to inspect the skb, but the program may call
> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB. Once the
> head carries a frag_list these go
> 
> 	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
> 
> and __pskb_pull_tail() frees the frag_list skbs that strparser still tracks
> through skb_nextp:
> 
> 	while ((list = skb_shinfo(skb)->frag_list) != insp) {
> 		skb_shinfo(skb)->frag_list = list->next;
> 		consume_skb(list);
> 	}
> 
> strp->skb_nextp now points into a freed sk_buff. The next segment of the same
> message arrives in __strp_recv(), which links it with *strp->skb_nextp = skb,
> an 8-byte write into the freed skb. The free and the write happen in different
> __strp_recv() calls, so the message has to span at least three segments before
> it triggers.
> 
>   BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
>   Write of size 8 at addr ffff88810db86140 by task repro/349
> 
>   Call Trace:
>    <IRQ>
>    __strp_recv+0x447/0xda0
>    __tcp_read_sock+0x13d/0x590
>    tcp_bpf_strp_read_sock+0x195/0x320
>    strp_data_ready+0x267/0x340
>    sk_psock_strp_data_ready+0x1ce/0x350
>    tcp_data_queue+0x1364/0x2fd0
>    tcp_rcv_established+0xe07/0x1640
>    [...]
> 
>   Allocated by task 349:
>    skb_clone+0x17b/0x210
>    __strp_recv+0x2c3/0xda0
>    __tcp_read_sock+0x13d/0x590
>    [...]
> 
>   Freed by task 349:
>    kmem_cache_free+0x150/0x570
>    __pskb_pull_tail+0x57b/0xc20
>    skb_ensure_writable+0x236/0x260
>    __bpf_skb_change_tail+0x1d4/0x590
>    sk_skb_change_tail+0x2a/0x40
>    bpf_prog_1b285dcd6c41373e+0x27/0x30
>    bpf_prog_run_pin_on_cpu+0xf3/0x260
>    sk_psock_strp_parse+0x118/0x1e0
>    __strp_recv+0x4f6/0xda0
>    [...]
> 
> The same resize also leaves the head's length inconsistent with its frags, so
> a later __pskb_pull_tail() can instead hit the BUG_ON(skb_copy_bits(...)) in
> net/core/skbuff.c.
> 
> Run the parser on a private clone of the head whenever the message spans more
> than one skb, so a resizing helper can only touch the clone and strparser's
> head and skb_nextp stay valid. Single-skb messages have no frag_list and are
> still parsed in place.
> 
> Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/core/skmsg.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71..d5b10f9b0ba8 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1146,14 +1146,30 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>  	struct bpf_prog *prog;
>  	int ret = skb->len;
>  
> -	rcu_read_lock();
> +	guard(rcu)();

I'd probably not mix this rcu change into this patch, though I
understand it drops an unlock() call in the new err return.

>  	prog = READ_ONCE(psock->progs.stream_parser);
>  	if (likely(prog)) {
> -		skb->sk = psock->sk;
> -		ret = bpf_prog_run_pin_on_cpu(prog, skb);
> -		skb->sk = NULL;
> +		struct sk_buff *parse_skb = skb;
> +
> +		/*
> +		 * strparser chains the message skbs through skb->frag_list and
> +		 * keeps a pointer into that list in strp->skb_nextp.  The parser
> +		 * program may call bpf_skb_change_tail() and friends, which go
> +		 * through __pskb_pull_tail() and free the frag_list skbs that
> +		 * strparser still tracks.  Run the program on a clone when a
> +		 * frag_list is present so it cannot drop frags strparser owns.
> +		 */
> +		if (skb_has_frag_list(skb)) {
> +			parse_skb = skb_clone(skb, GFP_ATOMIC);
> +			if (!parse_skb)
> +				return -ENOMEM;

I wonder if this could be further gated by prog->aux->changes_pkt_data?

One possible issue with adding an allocation here and returning -ENOMEM
is that this will shutdown stream parsing permanently for this sk when
under memory pressure, which is new behavior. Maybe, if we return 0, it
looks like the caller's accounting stays true by taking the "needs more
header" path, and then we can try again from the same place on the next
data_ready, and so be resilient even under memory pressure? I guess the
trade-off being that their may not come another data_ready to cause
progress... not sure which is better. Maybe strp_start_timer could be
used here too?

Best,
Bobby
