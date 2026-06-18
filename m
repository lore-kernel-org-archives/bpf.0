Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333215665C
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750717; cv=none; b=Yjt8AuOeaG/8X4TN9pyTXXxoC4S5woUy/u/bL1TPxlNf/pD0IuXUGaA/vO39q9DuAMwXLuHvTsux09iIWmsHYC72hJ3jkTIRBYJcnUsE9pOoigfM8loYEd7/X5r6PQw/wLJKWfaJpQOHKP+e9gQJcmO8oU32K/ICNXzcxn0S3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750717; c=relaxed/simple;
	bh=qSaukmowGj++JxcMa/yHy6Yr3sKPTxuk6LlldTdeOqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSFqvRO2bL7sGgl7p19ujw7K4wF7FQEmczsPOsSwqXuZXEd7rVXljX86muEG/yaAkFZwPb38QLS9+3QQwYPMYnEWWAckNhLQ2BcT9EjYw0drPYSvo3rOYjYFitF5IGQ4QCVPJOmG2U0RVp4iLklonh+k6qYW5nBJQDYJPDjbEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C3puk66i; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C3puk66i"
Message-ID: <04931588-e708-40d8-a1b7-3700a1a3b376@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781750713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8TDN8bzEOcGiFm8DZoqtUUF8TKfOf/eHYPCDbduM40=;
	b=C3puk66iITvSMQ0yJqQY//K6d78xs+4OlkhtRCs3u2ZER4a33+m7J5CkbUrXltia3osEri
	NmGrrtNCc3pUMqQhpfh3Tb0XVSMpJXXQWzD7wV/ToE2EN8O8uRxWynlYRyEHwGdoQqK1do
	ZSaCZu985ysGspmmZcgTBP7zdqplX+w=
Date: Thu, 18 Jun 2026 10:45:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
To: Sechang Lim <rhkrqnwk98@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Bobby Eshleman
 <bobbyeshleman@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/12/26 8:35 PM, Sechang Lim wrote:
> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
> to find the length of the next message. strparser assembles a message out
> of several received skbs by chaining them onto the head's frag_list and
> recording where to append the next one in strp->skb_nextp:
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
> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
> Once the head carries a frag_list these go
>
> 	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
>
> and __pskb_pull_tail() frees the frag_list skbs that strparser still
> tracks through skb_nextp:
>
> 	while ((list = skb_shinfo(skb)->frag_list) != insp) {
> 		skb_shinfo(skb)->frag_list = list->next;
> 		consume_skb(list);
> 	}
>
> strp->skb_nextp now points into a freed sk_buff. The next segment of
> the same message arrives in __strp_recv(), which links it with
> *strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
> and the write happen in different __strp_recv() calls, so the message
> has to span at least three segments before it triggers.
>
>    BUG: KASAN: slab-use-after-free in __strp_recv+0x447/0xda0
>    Write of size 8 at addr ffff88810db86140 by task repro/349
>
>    Call Trace:
>     <IRQ>
>     __strp_recv+0x447/0xda0
>     __tcp_read_sock+0x13d/0x590
>     tcp_bpf_strp_read_sock+0x195/0x320
>     strp_data_ready+0x267/0x340
>     sk_psock_strp_data_ready+0x1ce/0x350
>     tcp_data_queue+0x1364/0x2fd0
>     tcp_rcv_established+0xe07/0x1640
>     [...]
>
>    Allocated by task 349:
>     skb_clone+0x17b/0x210
>     __strp_recv+0x2c3/0xda0
>     __tcp_read_sock+0x13d/0x590
>     [...]
>
>    Freed by task 349:
>     kmem_cache_free+0x150/0x570
>     __pskb_pull_tail+0x57b/0xc20
>     skb_ensure_writable+0x236/0x260
>     __bpf_skb_change_tail+0x1d4/0x590
>     sk_skb_change_tail+0x2a/0x40
>     bpf_prog_1b285dcd6c41373e+0x27/0x30
>     bpf_prog_run_pin_on_cpu+0xf3/0x260
>     sk_psock_strp_parse+0x118/0x1e0
>     __strp_recv+0x4f6/0xda0
>     [...]
>
> The same resize also leaves the head's length inconsistent with its
> frags, so a later __pskb_pull_tail() can instead hit the
> BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.
>
> Run the parser on a private clone of the head when the message spans more
> than one skb and the program can modify the packet
> (prog->aux->changes_pkt_data), so a resizing helper can only touch the
> clone and strparser's head and skb_nextp stay valid. Single-skb messages
> have no frag_list and read-only parsers cannot resize, so both are still
> parsed in place. If the clone cannot be allocated, return 0 so the caller
> retries on the next read rather than failing the parser.
>
> Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")


Please consider Kuniyuki Iwashima's suggestion.

But it only covers the ATTACH path; the other two paths should be 
covered as well:

- BPF_PROG_ATTACH → sock_map_get_from_fd → sock_map_prog_update
- BPF_LINK_CREATE → sock_map_link_create → sock_map_prog_update
- replace prog → sock_map_link_update_prog

A new helper for this check is probably needed, called from both

sock_map_prog_update() and sock_map_link_update_prog().


Since this rejects the program at attach time rather than fixing a 
runtime crash,

I'm not sure a Fixes tag is appropriate here - thoughts?

