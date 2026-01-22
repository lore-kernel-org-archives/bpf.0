Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E3296BDB
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769063512; cv=none; b=lIftFkGIyHZHrVFaE5j6rrfnl6E2pYvhC15CGs3xTGsSvP0eiomtZ9HWDmhnJJQU5IqrzKSm8+Md2vSu7FKzDogxpLdjS21uZ8MSwP5xsl/gBLLziTIi6vLMq3ZwJ8GxqoZAwu8kdwHtaSsqfM6xL7s77RkNuH4GCrY+eKlEv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769063512; c=relaxed/simple;
	bh=UVebHt/E+DA5iZ0DZTRhL/FoWbADwv9Xit4ZWej4sJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dn5tXiHe3UwP/9hnVCIlBRaJjwYWkV/PBVpEtFMUXL96Bwz/Uknso+ixrCTvYMBWMnNmeSs7kXrNYWBBK8/fsOAQRqAD8YF4/DQs+7F149jCt8zKOId2cUDcoSwaIMFoqdArWhCYj7RjbgNz3h8nG5C/zJw/cbntxxAKdMB3WqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zHQ1hoLe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nWTW6aKN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zHQ1hoLe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nWTW6aKN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zHQ1hoLe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWTW6aKN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zHQ1hoLe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nWTW6aKN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69642336E2;
	Thu, 22 Jan 2026 06:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769063508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snlThi6xEbyLHgpAGreIAptLTtIG/sStzORilk3J78o=;
	b=zHQ1hoLeC/5cavLYx5OvU/D0QEQ93VhR9okhUNc8zOoL9mFrwy+2E8MuO6W4049oNippOq
	kNE76fHFsYXFhNJqEefS+X0P4wt2sDQrAeU1HNFOc0i5Ex7WPrE03Eb0eu6HTGhUyLqqHa
	BW6/aej7Xpacb7wmCnFsaSvz32nz/VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769063508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snlThi6xEbyLHgpAGreIAptLTtIG/sStzORilk3J78o=;
	b=nWTW6aKNwwJQmhH48v0849Ik2lAcm0Xizdf4ZwIRn3sq1gkN0fQm8HbkbMoJiFHeUQwtbS
	0oghjhdTxItgZTCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769063508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snlThi6xEbyLHgpAGreIAptLTtIG/sStzORilk3J78o=;
	b=zHQ1hoLeC/5cavLYx5OvU/D0QEQ93VhR9okhUNc8zOoL9mFrwy+2E8MuO6W4049oNippOq
	kNE76fHFsYXFhNJqEefS+X0P4wt2sDQrAeU1HNFOc0i5Ex7WPrE03Eb0eu6HTGhUyLqqHa
	BW6/aej7Xpacb7wmCnFsaSvz32nz/VM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769063508;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=snlThi6xEbyLHgpAGreIAptLTtIG/sStzORilk3J78o=;
	b=nWTW6aKNwwJQmhH48v0849Ik2lAcm0Xizdf4ZwIRn3sq1gkN0fQm8HbkbMoJiFHeUQwtbS
	0oghjhdTxItgZTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46BC63EA63;
	Thu, 22 Jan 2026 06:31:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vbnsEFTEcWnTdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 22 Jan 2026 06:31:48 +0000
Message-ID: <6b48cc0f-f006-4d4c-af76-55f86f4267e3@suse.cz>
Date: Thu, 22 Jan 2026 07:31:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/21] slab: remove frozen slab checks from
 __slab_free()
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-19-5595cb000772@suse.cz>
 <CAJuCfpHggP+iefwGTOWnSxDma5U=uMROYNs8KS0A=u2w=1rq_w@mail.gmail.com>
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
In-Reply-To: <CAJuCfpHggP+iefwGTOWnSxDma5U=uMROYNs8KS0A=u2w=1rq_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/22/26 01:54, Suren Baghdasaryan wrote:
> On Fri, Jan 16, 2026 at 2:41 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Currently slabs are only frozen after consistency checks failed. This
>> can happen only in caches with debugging enabled, and those use
>> free_to_partial_list() for freeing. The non-debug operation of
>> __slab_free() can thus stop considering the frozen field, and we can
>> remove the FREE_FROZEN stat.
>>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Functionally looks fine to me. Do we need to do something about the
> UAPI breakage that removal of a sysfs node might cause?

Only if someone complains. Just this week it has been reiterated by Linus:
https://lore.kernel.org/all/CAHk-%3Dwga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9%2BfMCLkKg@mail.gmail.com/

Given this is behing a config no distro enables, I think chances are good
noone will complain:

https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=SLUB_STATS

> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> 
>> ---
>>  mm/slub.c | 22 ++++------------------
>>  1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 476a279f1a94..7ec7049c0ca5 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -333,7 +333,6 @@ enum stat_item {
>>         FREE_RCU_SHEAF_FAIL,    /* Failed to free to a rcu_free sheaf */
>>         FREE_FASTPATH,          /* Free to cpu slab */
>>         FREE_SLOWPATH,          /* Freeing not to cpu slab */
>> -       FREE_FROZEN,            /* Freeing to frozen slab */
>>         FREE_ADD_PARTIAL,       /* Freeing moves slab to partial list */
>>         FREE_REMOVE_PARTIAL,    /* Freeing removes last object */
>>         ALLOC_FROM_PARTIAL,     /* Cpu slab acquired from node partial list */
>> @@ -5103,7 +5102,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>                         unsigned long addr)
>>
>>  {
>> -       bool was_frozen, was_full;
>> +       bool was_full;
>>         struct freelist_counters old, new;
>>         struct kmem_cache_node *n = NULL;
>>         unsigned long flags;
>> @@ -5126,7 +5125,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>                 old.counters = slab->counters;
>>
>>                 was_full = (old.freelist == NULL);
>> -               was_frozen = old.frozen;
>>
>>                 set_freepointer(s, tail, old.freelist);
>>
>> @@ -5139,7 +5137,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>                  * to (due to not being full anymore) the partial list.
>>                  * Unless it's frozen.
>>                  */
>> -               if ((!new.inuse || was_full) && !was_frozen) {
>> +               if (!new.inuse || was_full) {
>>
>>                         n = get_node(s, slab_nid(slab));
>>                         /*
>> @@ -5158,20 +5156,10 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>         } while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"));
>>
>>         if (likely(!n)) {
>> -
>> -               if (likely(was_frozen)) {
>> -                       /*
>> -                        * The list lock was not taken therefore no list
>> -                        * activity can be necessary.
>> -                        */
>> -                       stat(s, FREE_FROZEN);
>> -               }
>> -
>>                 /*
>> -                * In other cases we didn't take the list_lock because the slab
>> -                * was already on the partial list and will remain there.
>> +                * We didn't take the list_lock because the slab was already on
>> +                * the partial list and will remain there.
>>                  */
>> -
>>                 return;
>>         }
>>
>> @@ -8721,7 +8709,6 @@ STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
>>  STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
>>  STAT_ATTR(FREE_FASTPATH, free_fastpath);
>>  STAT_ATTR(FREE_SLOWPATH, free_slowpath);
>> -STAT_ATTR(FREE_FROZEN, free_frozen);
>>  STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
>>  STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
>>  STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
>> @@ -8826,7 +8813,6 @@ static struct attribute *slab_attrs[] = {
>>         &free_rcu_sheaf_fail_attr.attr,
>>         &free_fastpath_attr.attr,
>>         &free_slowpath_attr.attr,
>> -       &free_frozen_attr.attr,
>>         &free_add_partial_attr.attr,
>>         &free_remove_partial_attr.attr,
>>         &alloc_from_partial_attr.attr,
>>
>> --
>> 2.52.0
>>

