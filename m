Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE1345CAB
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759978; cv=none; b=HutRqHgYrLzX7LPhDBGfImm6B9OWiaMgTcvRFiaNN1yN76VYhwEqRSgAIkVf78M/yj4YkQRXIpue4ODchRHbRGIOGydhvKENOMqMkYlec/3+QDaD/cokX7fADmS12qHJO11+/hu+cWdfw7X26hHoIt1WdfL4YdlESCmLp73bmos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759978; c=relaxed/simple;
	bh=XoD/NZW7XtXzI0hokIamqs8MkoyaBfl+FxFbwYeVTKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqb7m9K+afrO/tCZQ0fvDIfff789arQELLAWYyKI+fKY9NSIM6tDZ6cncOgxIHtuRFZKq4PRAX8HLDDmQIW1i0jhy64KjbzWOH+mIsUq8EMQHIrwAsJHDHMh/zXUZkkaWUqGa3a+jgPL9jJ26pl0J5sIYExFSyP1htoyjCzeTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6jvQvoA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6jvQvoA"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b9328c4aso3736525ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781759977; x=1782364777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cyZsa6yfA2KBE9paf08CHDyp6TRikZM/OSQG+OyKWdU=;
        b=D6jvQvoA+mZXSvFL2yVTMXvCS39eLPQ+1CkosAduYu19+Lc4nTq8ZaBnQ8nSfYt+Z+
         Azipsw4fo6VmOHu0Gh+8TaJyC9O8MeLMAGUsxXg3mKB3/AjCHGssmGjpWdplbBSgbtTF
         XXe+IiUnrJYt/oYk8bRSZZJgZ7rnni1SkWlr+pdMeWW5df0cCS5RYoD7AirnzG6k+sxm
         Z9o0OOxCJc/eG2wyl1FsO2DdFUegGLsqotxqFDGF3nfw218iY9mHiAvZrfZwfh06H1hh
         O3MtJtyH3+gjEgOHgq+hZfquod09lDdTgbVHJ64IxswZKTnClKtcWC8AF/ZV1TaDSnXm
         BI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781759977; x=1782364777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyZsa6yfA2KBE9paf08CHDyp6TRikZM/OSQG+OyKWdU=;
        b=j5dqTvXMvw7WcmtlO21TIFMz09kyUdzmMvEp1istCG/vdf9bfuFh/PLXKraA9r9R3s
         fu7B8ciXBquJW+39bN/dIL/x+HDbWwRwFITHzlAe0kWDSWutBMVEMytTOD3WuWstaNe3
         qUplVOrydIwzO2iQ3khc6Eaj74PI1F6/a4+LfeXcOBfjQZFpB76pN0aHhQfh4zM8vL1A
         Lt6MLy4K6DHYH/0IT59wyyHnZ6aPoUhrN2WaiXMV2O1V705bQehIQKoebViBwOaohwU6
         +m01rUOw7UvP+8mFw2HzIfyYC8zTuhvpHkjCdmw3SBmSfZsPQKKFP3X6JtZKmcXvhjE0
         8TWw==
X-Forwarded-Encrypted: i=1; AFNElJ9I4jkWIlCx3vj1+5yHpj7fB3BxzdVsTHG4toOEgvekcNmqiq7CxccVzlPZ6D1AluHJo3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgGGWtPDh4QTeBnlcQMgxebaV8Q8g/ejJyIUh47NsSDpROTSoY
	D3qSURa5HrmnJ9aEm6mID9exjhSvyRGJpYkS81fmmAq+dFL5oxjXV79C
X-Gm-Gg: AfdE7clFbFpgWwCTFdUyLCQ6c3M33a/5oIJYrwHPSw1HGlw1eBVbv4/zkmcLTvKRFmg
	Y20U2TBuGYBfPmmvsPZrz86G3vnufZy0Vw6PrggW+ADi7/lxAh86uRBDB1rX5KcMQmwmhyYXuyD
	UVOrNYE8Ss0Klz6QP4zJFJLRz3nyXwh44Wgxgg04LsfXOQfsuo2PKxE50tSN7zDFk3r9UvrtYMd
	StZz+f7GGGdqJbo1ARykpukg5nqrGqodf73rH48Je5L2qWbuI09UFNrEkLjKMZ4r75k4KYTh6xN
	u1e7DHFkyWri7GCI2QBBHvtvWBrLsARaFY5wY2P6jc3GLeUJrv2RvZUHoT3jFPACccxMtCgU9Su
	1sVVigUeEziMBBVPjuC+A2NJlr4wJbfho6KPeZBNkIlUp/Sp6CauDgJCQcZaztcNJUME0o+8hR/
	2WfxgNidnpAEz8DixrWKduzESyuy9tCNr/Y35vdRbjzzCUUFNs
X-Received: by 2002:a17:903:2f8c:b0:2c2:8659:da2c with SMTP id d9443c01a7336-2c6f3426da5mr10545865ad.14.1781759976809;
        Wed, 17 Jun 2026 22:19:36 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4328a4c14sm173356975ad.43.2026.06.17.22.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 22:19:36 -0700 (PDT)
Date: Thu, 18 Jun 2026 05:19:27 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <tskrt2wgan754bbjag7zwn6jjx32kupde32yoyqo6nydmwmiea@p2fjro3cv7wv>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
 <04931588-e708-40d8-a1b7-3700a1a3b376@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04931588-e708-40d8-a1b7-3700a1a3b376@linux.dev>

On Thu, Jun 18, 2026 at 10:45:02AM +0800, Jiayuan Chen wrote:
>
>On 6/12/26 8:35 PM, Sechang Lim wrote:
>>sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>>to find the length of the next message. strparser assembles a message out
>>of several received skbs by chaining them onto the head's frag_list and
>>recording where to append the next one in strp->skb_nextp:
>>
>>	*strp->skb_nextp = skb;
>>	strp->skb_nextp = &skb->next;
>>
>>and then calls the parser on the head:
>>
>>	len = (*strp->cb.parse_msg)(strp, head);
>>
>>The parser is only meant to inspect the skb, but the program may call
>>bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
>>bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
>>Once the head carries a frag_list these go
>>
>>	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
>>
>>and __pskb_pull_tail() frees the frag_list skbs that strparser still
>>tracks through skb_nextp:
>>
>>	while ((list = skb_shinfo(skb)->frag_list) != insp) {
>>		skb_shinfo(skb)->frag_list = list->next;
>>		consume_skb(list);
>>	}
>>
>>strp->skb_nextp now points into a freed sk_buff. The next segment of
>>the same message arrives in __strp_recv(), which links it with
>>*strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
>>and the write happen in different __strp_recv() calls, so the message
>>has to span at least three segments before it triggers.
>>
>>   BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
>>   Write of size 8 at addr ffff88810db86140 by task repro/349
>>
>>   Call Trace:
>>    <IRQ>
>>    __strp_recv+0x447/0xda0
>>    __tcp_read_sock+0x13d/0x590
>>    tcp_bpf_strp_read_sock+0x195/0x320
>>    strp_data_ready+0x267/0x340
>>    sk_psock_strp_data_ready+0x1ce/0x350
>>    tcp_data_queue+0x1364/0x2fd0
>>    tcp_rcv_established+0xe07/0x1640
>>    [...]
>>
>>   Allocated by task 349:
>>    skb_clone+0x17b/0x210
>>    __strp_recv+0x2c3/0xda0
>>    __tcp_read_sock+0x13d/0x590
>>    [...]
>>
>>   Freed by task 349:
>>    kmem_cache_free+0x150/0x570
>>    __pskb_pull_tail+0x57b/0xc20
>>    skb_ensure_writable+0x236/0x260
>>    __bpf_skb_change_tail+0x1d4/0x590
>>    sk_skb_change_tail+0x2a/0x40
>>    bpf_prog_1b285dcd6c41373e+0x27/0x30
>>    bpf_prog_run_pin_on_cpu+0xf3/0x260
>>    sk_psock_strp_parse+0x118/0x1e0
>>    __strp_recv+0x4f6/0xda0
>>    [...]
>>
>>The same resize also leaves the head's length inconsistent with its
>>frags, so a later __pskb_pull_tail() can instead hit the
>>BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.
>>
>>Run the parser on a private clone of the head when the message spans more
>>than one skb and the program can modify the packet
>>(prog->aux->changes_pkt_data), so a resizing helper can only touch the
>>clone and strparser's head and skb_nextp stay valid. Single-skb messages
>>have no frag_list and read-only parsers cannot resize, so both are still
>>parsed in place. If the clone cannot be allocated, return 0 so the caller
>>retries on the next read rather than failing the parser.
>>
>>Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
>
>
>Please consider Kuniyuki Iwashima's suggestion.
>
>But it only covers the ATTACH path; the other two paths should be 
>covered as well:
>
>- BPF_PROG_ATTACH → sock_map_get_from_fd → sock_map_prog_update
>- BPF_LINK_CREATE → sock_map_link_create → sock_map_prog_update
>- replace prog → sock_map_link_update_prog
>
>A new helper for this check is probably needed, called from both
>
>sock_map_prog_update() and sock_map_link_update_prog().
>

Thanks, agreed. v3 will cover prog attach, link create and link update.

>
>Since this rejects the program at attach time rather than fixing a 
>runtime crash,
>
>I'm not sure a Fixes tag is appropriate here - thoughts?
>

I'd keep it. skb_change_tail reached SK_SKB in current Fixes tag, so
that is where the UAF became reachable. Happy to drop it if you prefer.

Best,
Sechang
