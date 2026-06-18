Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BB42A82
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762342; cv=none; b=u4v0gbuvNFOhLGUJC2dj2a+OcHgzbSgW+7Lddci5+ubdjmXqbqPEGtdrCKBCYkyGo20ZzZ4Et0BwXntODbNEMNtNP9y0vkbIeVcnRmlV1o5fqCLuOr+NTzHHlMOF8U0wb9xLkROP3oIqiaRST3Qmw5QK8syGoPC4JCH1t2MYRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762342; c=relaxed/simple;
	bh=iQbVSzd7tnO4nYGUSF0Pk2cDZv/94rbzxaeiO7N+I2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXr1z8M2XnIhNpx1Sr6aVXCIcWI6fgu+k6258UozLomgChYLRHZUWq3wEqr3eAxKHhWv6QI3kYeCYx+lQSctRyTW2CviZYrsS8Jfqx6ydoKRcITRhuCJYmT3Ql8Ge7eT63G2pLKZEMrR1kDdQbj+YuUcamudw2oSZVY67ooIkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3X+NARa; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3X+NARa"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso165424a91.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781762339; x=1782367139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SR/WhacBke+0XBQV9bbtMLPIxfhPwGewr2SwDro1Yc=;
        b=o3X+NARaVIqIAyLYEW1kguD3oLkEufcUu/lX35mKGE/UUSJY2R/dh+6tuozziJ56HZ
         0oCcpp/+bjkOs8pyb3OBs3cB9CchvpLJzOcGmPg6V3YSWpGZFI5Q9DOtjHbZOiiw4PSm
         pBYCtC/mDFg/TH7AsgBd6oAYqz4ivsegJm4BIfRBbKsC0YeM/x59Aym0qZ8gmFFQemsy
         UhJrxQpSyZr6w8DLigPr8Wo+eXs/TLLIn6Jb5USBPV2GKXNAKiDyuGMLsBEZHj2jbJKq
         ocVFnmz4//O0h6eRDwaLg4Ss2lz/y2XPlXIY12lzTz5YODgbSkU6yJfMczKfTpeXSnfT
         J0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781762339; x=1782367139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SR/WhacBke+0XBQV9bbtMLPIxfhPwGewr2SwDro1Yc=;
        b=qy4RS3cl5omN91XITXlxUUCAmeXhWXjiiACutlAJAVzI6v6kr+uufvMQVDCnSlWSSG
         euQeA5em9h42ne7v4AeMrbUKcXKK2P9uD8v1UDU8q4vYXeSW5N+fBtYgYD8VtF6CTtO+
         KBwNAId6Xt9oyJ02TetMyXS7I2q9PQ/unHZl1lIRHbd5xApeEwFarp80nfrQ+Zk4mfx1
         JFCgcPcKkEYYGu1KjWOcMCY59kMx+MzYFb4jHgF5jJSErtEj25Nz8sedqwN4AtJbW2Oh
         Q3jQnkX3BShtjl1VNsXdw+CxL4vpJ8tuVlCRcc11CS7awW3Ga0az+VENyKi5Oy/ZWc07
         R+nQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zTvOKB2ppoo3eJfGPqRoaIs+gqVw5v+OR8NPa/L8LHisd6ti7C13UrG5CBfNQLtDzRHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxd5K9Rd5GE9Q0dgEDSaDDcl+ToQmdyQYtbh+nO19AuoAtP+UI
	43ERXkwn+9qpKx+C/wr8skfjmwWmiD+BkQhahKqE9Ol1F0jgQHND7CnI
X-Gm-Gg: AfdE7cmAZXJ2B3+2pXwxKK0Yd2lbtMe6vCIVeRjGl7n1poXRvz7mfepeTb4fCEkn4fn
	3gTeBLpxHQBy58HdlxfSKZBT2IS7LxaqtH42A8DRonM+tIIZ9H+7tavRA4nz1TaknEJNl030P4F
	GHMvF4PpFSHhptmMDGI/gHUFYI7rFT/iD9P96yfUfOJcFEJDoOCxpxwLPNN/I9fh3HjhyJu3oTu
	eRBeqm7lL5eefvxmhW5N1lKSsQfq+d/mwJfYeGXBTztopRhAFsveu9tluQwKCoiqpgtJ/MW8O5f
	zVIU0d7YX4iYXbUVkGMt0+n2mJ9vHvjIA09s4lCTXutC6PDICuH1d0hymhdmfawr8rVcvG6vds7
	8UYmK27RKlCK1vlLDiSviHLKNyKK6mcKZyjLGI48YzXJMzM5eEmkPs2YBKGsHZZ9iHcAOVxtCWV
	PkNJHNPu/mV7dFmVl/0jzSSQ2UQQJWTcKB84siKj6WAc0U6DBq
X-Received: by 2002:a17:90b:3943:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-37c9daa09cemr6028482a91.8.1781762339033;
        Wed, 17 Jun 2026 22:58:59 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c930d7f81sm5660421a91.6.2026.06.17.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 22:58:58 -0700 (PDT)
Date: Thu, 18 Jun 2026 05:58:51 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2] bpf, sockmap: fix use-after-free when the stream
 parser resizes the skb
Message-ID: <grxvgzpgewyn7dscgjamrxxiekxkb7gjm7cspuvz534m3fs5o7@suidtis7kcvi>
References: <20260612123553.2724240-1-rhkrqnwk98@gmail.com>
 <ajMhV7O5YfYbwQzE@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ajMhV7O5YfYbwQzE@devvm29614.prn0.facebook.com>

On Wed, Jun 17, 2026 at 03:36:07PM -0700, Bobby Eshleman wrote:
>On Fri, Jun 12, 2026 at 12:35:51PM +0000, Sechang Lim wrote:
>> sk_psock_strp_parse() runs the BPF_PROG_TYPE_SK_SKB stream-parser program
>> to find the length of the next message. strparser assembles a message out
>> of several received skbs by chaining them onto the head's frag_list and
>> recording where to append the next one in strp->skb_nextp:
>>
>> 	*strp->skb_nextp = skb;
>> 	strp->skb_nextp = &skb->next;
>>
>> and then calls the parser on the head:
>>
>> 	len = (*strp->cb.parse_msg)(strp, head);
>>
>> The parser is only meant to inspect the skb, but the program may call
>> bpf_skb_change_tail() -- or the sibling bpf_skb_pull_data(),
>> bpf_skb_change_head(), bpf_skb_adjust_room(), all allowed for SK_SKB.
>> Once the head carries a frag_list these go
>>
>> 	... -> skb_ensure_writable -> pskb_may_pull -> __pskb_pull_tail
>>
>> and __pskb_pull_tail() frees the frag_list skbs that strparser still
>> tracks through skb_nextp:
>>
>> 	while ((list = skb_shinfo(skb)->frag_list) != insp) {
>> 		skb_shinfo(skb)->frag_list = list->next;
>> 		consume_skb(list);
>> 	}
>>
>> strp->skb_nextp now points into a freed sk_buff. The next segment of
>> the same message arrives in __strp_recv(), which links it with
>> *strp->skb_nextp = skb, an 8-byte write into the freed skb. The free
>> and the write happen in different __strp_recv() calls, so the message
>> has to span at least three segments before it triggers.
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
>> The same resize also leaves the head's length inconsistent with its
>> frags, so a later __pskb_pull_tail() can instead hit the
>> BUG_ON(skb_copy_bits(...)) in net/core/skbuff.c.
>>
>> Run the parser on a private clone of the head when the message spans more
>> than one skb and the program can modify the packet
>> (prog->aux->changes_pkt_data), so a resizing helper can only touch the
>> clone and strparser's head and skb_nextp stay valid. Single-skb messages
>> have no frag_list and read-only parsers cannot resize, so both are still
>> parsed in place. If the clone cannot be allocated, return 0 so the caller
>> retries on the next read rather than failing the parser.
>>
>> Fixes: 8a31db561566 ("bpf: add access to sock fields and pkt data from sk_skb programs")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>> v2:
>>  - clone only when prog->aux->changes_pkt_data (Bobby Eshleman)
>>  - return 0 on clone failure instead of -ENOMEM (Bobby Eshleman)
>>  - free the clone with consume_skb() instead of kfree_skb()
>>  - drop the unrelated guard(rcu)() change (Bobby Eshleman)
>>
>> v1:
>>  - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/
>>
>>  net/core/skmsg.c | 26 +++++++++++++++++++++++---
>>  1 file changed, 23 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index e1850caf1a71..97e5bc5f38c3 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -1149,9 +1149,29 @@ static int sk_psock_strp_parse(struct strparser *strp, struct sk_buff *skb)
>>  	rcu_read_lock();
>>  	prog = READ_ONCE(psock->progs.stream_parser);
>>  	if (likely(prog)) {
>> -		skb->sk = psock->sk;
>> -		ret = bpf_prog_run_pin_on_cpu(prog, skb);
>> -		skb->sk = NULL;
>> +		struct sk_buff *parse_skb = skb;
>> +
>> +		/*
>> +		 * strparser chains the message skbs through skb->frag_list and
>> +		 * keeps a pointer into that list in strp->skb_nextp.  The parser
>> +		 * program may call bpf_skb_change_tail() and friends, which go
>> +		 * through __pskb_pull_tail() and free the frag_list skbs that
>> +		 * strparser still tracks.  Run the program on a clone when the head
>> +		 * has a frag_list and the program can modify the packet, so it
>> +		 * cannot drop frags strparser owns.
>> +		 */
>> +		if (skb_has_frag_list(skb) && prog->aux->changes_pkt_data) {
>> +			parse_skb = skb_clone(skb, GFP_ATOMIC);
>> +			if (!parse_skb) {
>> +				rcu_read_unlock();
>> +				return 0;
>> +			}
>> +		}
>> +		parse_skb->sk = psock->sk;
>> +		ret = bpf_prog_run_pin_on_cpu(prog, parse_skb);
>> +		parse_skb->sk = NULL;
>> +		if (parse_skb != skb)
>> +			consume_skb(parse_skb);
>>  	}
>>  	rcu_read_unlock();
>>  	return ret;
>> --
>> 2.43.0
>>
>I'm still on the fence about "return 0" vs ENOMEM. I hate to flip-flop
>on you here, but now I'm not sure if it is worth the complication to
>return 0 since we're really only buying a single timer interval in which
>we need 1) suddenly more memory to alloc the clone, and 2) another data
>ready event to cause the stream parsing to pick up again. If any one
>doesn't happen, the end result is the same. Not sure its a good
>trade-off for the complexity of basically tricking the caller with the
>zero return. Maybe let's go back to ENOMEM?
>

Per Kuniyuki's and Jiayuan's suggestion, v3 will reject a packet-modifying
stream parser at attach time instead of runtime, so the return-0 vs
ENOMEM question goes away with that code.

>BTW, based on the comm name "repro", it sounds like you have a decent
>reproducer for this. I wonder if it is possible to add something to the
>selftests to catch this?
>

I will add an selftest in v3.

Best,
Sechang
