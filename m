Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9B2F691F
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 08:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416974; cv=none; b=keVKq1ICafCo7PO+yXdqDMWY6ZwYSmbNIKwJka+zQIF8GE2echr1tmtZ7ZDhzkgfvm3wYPYmrwiXSGDa32mFUPuMw88PLaEeXr4tSGR6K57Yxt+H6j1H1oGiBzqy7/jRrF7mmI+MfhCQPYrLilYTmi6LAPrWWQBmSTWTH7493r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416974; c=relaxed/simple;
	bh=tJ1VAnZS2fPGBmoY19VOgWu3fpTD1Fepy15kPSM83v0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MsCkf8Jex5W2Q8Op1C/CtYWhr1G3zHsOFgmuEfedwGfzqa8dBAWHsSrmntP7Tkf8fwfA+v6SWVaQzFmGjTkAeEc90lcM+TD65+z0oaHL6oWXWmGddPIlvhY9faC8KcK1AqSss90vbaGnJGzeqV/DdrYOlw2VH9ulOltejtFAaI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODTiACZL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3eoJyxz6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/cm50UY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=syvRJnAc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODTiACZL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3eoJyxz6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/cm50UY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="syvRJnAc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F3005BCD6;
	Mon, 26 Jan 2026 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769416971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sgs+T/VXcMnUbDMuJnWkmVFhshs/1VjbTRgWWbUlNSI=;
	b=ODTiACZLdjWU/NKFrVlZTOd78tm2M6equbgI88o8GJOcS1WYMGRRX7Y+GFDun+5IVQh1Kn
	FamPiV7y4vbfQF7lnhTOZ4ePJHuwIql5n8R98FxxxA0kRsJ1tVcYxBFUIStXHX7k1EtPd1
	eDyQcwggibt/FIy2GyDsnXo3983alW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769416971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sgs+T/VXcMnUbDMuJnWkmVFhshs/1VjbTRgWWbUlNSI=;
	b=3eoJyxz6xwVZMAgQiNRAxWq6PH42RpoDbabjX+VoIWWUJmH1wfkTO1PnaJIF6JTiNf38kF
	rYS870eTgWJiO9AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769416970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sgs+T/VXcMnUbDMuJnWkmVFhshs/1VjbTRgWWbUlNSI=;
	b=Q/cm50UYhKvzCvdLmnBKU8IiLLdHlGalaEVaTVBsUfPf1vbsMYU3dT3BduUL2AcarGg88R
	059V/6OyIn3Wsokd/PvZTmYuq+Ycr44EblqlAk97ltbRq50lqyIpby0AXWbjJuVvCxnHbo
	5XDclO2BRX+RSAhSAN9X9ePx8tSeIKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769416970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Sgs+T/VXcMnUbDMuJnWkmVFhshs/1VjbTRgWWbUlNSI=;
	b=syvRJnAckSZKqDLh6yNNSYu1u2O+hYTxnWToo71MaVS1n2AjMIY2lIwdiDGfk/6qOJH5L9
	Oi86gPnzwJMETSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEAB139F0;
	Mon, 26 Jan 2026 08:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J4x7Agopd2ltKwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Jan 2026 08:42:50 +0000
Message-ID: <0c337f99-98b3-4955-b9aa-6a5e9bacb041@suse.cz>
Date: Mon, 26 Jan 2026 09:42:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/22] slab: introduce percpu sheaves bootstrap
Content-Language: en-US
To: Hao Li <hao.li@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260123-sheaves-for-all-v4-0-041323d506f7@suse.cz>
 <20260123-sheaves-for-all-v4-7-041323d506f7@suse.cz>
 <qrekwm7js5t4kmahu3toqnrepnvk7ve5h624f6hm262mmybvtx@rewwd4rbvf3b>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <qrekwm7js5t4kmahu3toqnrepnvk7ve5h624f6hm262mmybvtx@rewwd4rbvf3b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/26/26 07:13, Hao Li wrote:
> On Fri, Jan 23, 2026 at 07:52:45AM +0100, Vlastimil Babka wrote:
>> Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
>> sheaves enabled. Since we want to enable them for almost all caches,
>> it's suboptimal to test the pointer in the fast paths, so instead
>> allocate it for all caches in do_kmem_cache_create(). Instead of testing
>> the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
>> kmem_cache->sheaf_capacity for being 0, where needed, using a new
>> cache_has_sheaves() helper.
>> 
>> However, for the fast paths sake we also assume that the main sheaf
>> always exists (pcs->main is !NULL), and during bootstrap we cannot
>> allocate sheaves yet.
>> 
>> Solve this by introducing a single static bootstrap_sheaf that's
>> assigned as pcs->main during bootstrap. It has a size of 0, so during
>> allocations, the fast path will find it's empty. Since the size of 0
>> matches sheaf_capacity of 0, the freeing fast paths will find it's
>> "full". In the slow path handlers, we use cache_has_sheaves() to
>> recognize that the cache doesn't (yet) have real sheaves, and fall back.
>> Thus sharing the single bootstrap sheaf like this for multiple caches
>> and cpus is safe.
>> 
>> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slab.h        |  12 ++++++
>>  mm/slab_common.c |   2 +-
>>  mm/slub.c        | 123 ++++++++++++++++++++++++++++++++++++-------------------
>>  3 files changed, 95 insertions(+), 42 deletions(-)
> 
> Tiny consistency nit: in kfree_rcu_sheaf(), there's a remaining "if
> (s->cpu_sheaves)" that could be replaced with "if (cache_has_sheaves(s))" for

Ah thanks.

> consistency. It's trivial, so no need to respin - happy to have it addressed
> opportunistically.

Actually we should remove it completely from the fastpath per the design, as
__kfree_rcu_sheaf() checks that. Will do.

> The rest looks great to me!
> 
> Reviewed-by: Hao Li <hao.li@linux.dev>

Thanks!

