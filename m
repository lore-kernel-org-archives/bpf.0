Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF43803F7
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735775; cv=none; b=M+BE3nmpR6kHcy2K6rJcXPJ68GAHF/uhpEBVl+B+GfQmAhKCj5+mybASUOhetIFPu0WtsBZj5ue+FUdwtcueBRhrbe4U3l6GoIPRcCAqUX/LK0Iu5rHxKrQKQjC5L1zAGrlmRX1fq/wwPyUXvOxjULLXTadVbTE6xVkDJMQr7D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735775; c=relaxed/simple;
	bh=XSYMRQH32F/uJP3xw7iXXHgT1MTNlHZM4pqtPNnSFw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGd3cD7GRcLFDf0QKOUskDku8aBSmPgzb+gTRivQW7R5i/cL+K4k/XXzUmM3cdVED+AXfu+d5zuOUveJF3E1UDSdoV6+bDZwPXJ2FDPIUR2LCiYY9mYMUlmuao5gylVJhtHZZqCc3vvsWWcxkhon7tWjZbBlzw0po/TQB67aThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmIj67xG; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmIj67xG"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6e9408e30so247518a34.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 15:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781735772; x=1782340572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BbZx62gInfdUQ9qJT2MwuFY2u0tYb8N/NOScZmlg1w=;
        b=GmIj67xG2iEkGEObMj3pRobNUgRHnAtLzWunb92JWrJnSE1SDMVOGN58YBARRlKWXP
         cItZfhg0NB/QWEeU6FcZUMP0PfrWs1HRwcM4JCH9qvza2BLuEWxOWOk1RcXBzeUCX+Q/
         aEi29uZIllAsyddV8F49BiFe0/VPUk/eICXBk9aJs9YMdPDC6McwNJJ4tCIzwHBje6JT
         f2kfV2getYsX009nLGe2VPoO9vAqZN0WUYv2CWXiiLL7i3s0Zo5KWZKeC8qG4ET1oq9r
         Amdf0+flIusaTXU2oDsd7qCWeROJSXwI88nSPGtbA9Ut1aGZ74beu6x+RAKfeEtk3A0C
         a86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781735772; x=1782340572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BbZx62gInfdUQ9qJT2MwuFY2u0tYb8N/NOScZmlg1w=;
        b=JEL3w5sOF245LhbOMKtepki2aAgmgXvujX7YRaHdhSkyQWUgTIuUC3/BJAOGgB4rBm
         kH4mQz5UDwIlUf9T2CAbxI3EiEEXcopn1LDY4Dh/TEdxevreO5uN2ceaX8hT14lFeKMh
         4abkYxhakvuzrOZpRwyrOXmmAjBVeI/E5vTR3RRkJ71A+CDnkoJPV42zZDYqE6K9+NXC
         /hCZpeQ/9ZxiBRdi5bQSXVoRW8WlT/19DOfmEd0c+FLc3qvoxRDy/n7v5bavPMUdHOem
         U/bvAoBfFvqqKKRXNcS0G9S7zWWzwLB0GLLbzNshdLEhmmGo1SSQq7QPybX/EfnqCb98
         qgHg==
X-Forwarded-Encrypted: i=1; AFNElJ8vTIjkpC4AgDrBjlWEard9PR6seMENjgSB4/88/baSGZ00lQ20sbbmyua8UVq7iNlVuvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2mDV8OTQe5ICOmI31IK0w40Gtjn5zgu8DpjBH2cRFAPBJcZi
	MWm+kqmrEobBomj1YIXi7Z9LYcP3ggmfq4TqwjUz66sQRLQGQmRuocAS
X-Gm-Gg: Acq92OFZT7r+tIFpPekGnODIyzNXZDEHscBUdidXzIy17QuESAb7VzhenSf9rOXd5kB
	z7IapzrCvhZNnQeGih0NdXbSOwQNQccFiOwX0gFq4PvScuANw0EeSbItc7LPQ4OmO1XjwXPYAPU
	QJldjmhR7zKaJp25kcsczNtdBKljK/YOCzUl5vXy3H0fAiVPysmXkB1R4YPJC+cUInWjiK2nyX6
	uBa1qbA2TI/M17fiVVXDjr+6PC1q0RyP5dj8yIzuVtVEsnss/nBCTGKiajUYQ1JRuhF9WfC1kvH
	MbWKmkcUNnGZKrhy8t+AB4tzwN1AvoaG9hMXw71FphShIOjIRlpHIyj5/onWEv0gjK2O+eFq3vT
	wqkypBqgRflcjrrlgxZXrlnzbyt6hLf0yKa3z94B47CRvqYJYP0WvxeiCxuAPr2+p9k09wwCZtQ
	x+i7kV0U6zpIFzrMhNmNLlEi9p1JeC3EmhXAn9XYwYnXU=
X-Received: by 2002:a05:6808:1526:b0:479:f9df:ab35 with SMTP id 5614622812f47-489570fb68dmr1054405b6e.42.1781735771665;
        Wed, 17 Jun 2026 15:36:11 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda5f7csm7043629b6e.1.2026.06.17.15.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:36:10 -0700 (PDT)
Date: Wed, 17 Jun 2026 15:36:07 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <ajMhV7O5YfYbwQzE@devvm29614.prn0.facebook.com>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>

On Fri, Jun 12, 2026 at 12:35:51PM +0000, Sechang Lim wrote:
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
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>  - clone only when prog->aux->changes_pkt_data (Bobby Eshleman)
>  - return 0 on clone failure instead of -ENOMEM (Bobby Eshleman)
>  - free the clone with consume_skb() instead of kfree_skb()
>  - drop the unrelated guard(rcu)() change (Bobby Eshleman)
> 
> v1:
>  - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/
> 
>  net/core/skmsg.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index e1850caf1a71..97e5bc5f38c3 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1149,9 +1149,29 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>  	rcu_read_lock();
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
> +		 * strparser still tracks.  Run the program on a clone when the head
> +		 * has a frag_list and the program can modify the packet, so it
> +		 * cannot drop frags strparser owns.
> +		 */
> +		if (skb_has_frag_list(skb) && prog->aux->changes_pkt_data) {
> +			parse_skb = skb_clone(skb, GFP_ATOMIC);
> +			if (!parse_skb) {
> +				rcu_read_unlock();
> +				return 0;
> +			}
> +		}
> +		parse_skb->sk = psock->sk;
> +		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
> +		parse_skb->sk = NULL;
> +		if (parse_skb != skb)
> +			consume_skb(parse_skb);
>  	}
>  	rcu_read_unlock();
>  	return ret;
> -- 
> 2.43.0
> 

Hey Sechang,

I'm still on the fence about "return 0" vs ENOMEM. I hate to flip-flop
on you here, but now I'm not sure if it is worth the complication to
return 0 since we're really only buying a single timer interval in which
we need 1) suddenly more memory to alloc the clone, and 2) another data
ready event to cause the stream parsing to pick up again. If any one
doesn't happen, the end result is the same. Not sure its a good
trade-off for the complexity of basically tricking the caller with the
zero return. Maybe let's go back to ENOMEM?

BTW, based on the comm name "repro", it sounds like you have a decent
reproducer for this. I wonder if it is possible to add something to the
selftests to catch this?

Best,
Bobby
