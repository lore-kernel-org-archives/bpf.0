Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B474779AF
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983160; cv=none; b=ukjNbpTw/pksUFUbn3QmDo+/jomFgSon9pZKIYnXFnM5u5/qCndZUQLxWlF4FTKAYKfaXysoXNpp4+0wg4OA9VbrRYj4fuDg1kSaXlV7Glsgcq87AvobuS4zK/xzVGURGe6mT33+4tY5dTZqT9DXS0WBT2cqWQSdQ5B4hrHbjyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983160; c=relaxed/simple;
	bh=sg7YiqwFvHUXurjytI8iPbP69GuCmcsbe1kwGBH4IR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnC3xZ0dxbj4G7r90jDZWdJBmh8Q43uVHuAUBtIs6z7wCInyDq3Px6ffH2Dhazv1cz1vrSYyH5GQMNnveN9TU+f+ooSZVAJHK7PkrAzGSKFy8Jg+Ns8UlH+IUAVpDjz7rz/Gb0FnxUjUDtaRWZfjOhmh+HrmqtElnUsxAU/1Xo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kqJ/CP+P; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YvJgkb5U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ienWLs4A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q5L4a/06; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kqJ/CP+P";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YvJgkb5U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ienWLs4A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q5L4a/06"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46A9933689;
	Wed, 21 Jan 2026 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768983155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oU749SDo5J3PWFW4FxuIHDE7h+Fsbj9bTexCfG3H1s=;
	b=kqJ/CP+Pktx6e602m6cvlKbPgAVg9VP9RrujSSl+jZqMT3VMQfZ8qfEulidEVwkLVA2y5+
	mA/kLM9hwKszqPKMyaGHRRKoVJyEX7AxeY43I8V4NxZx+6H00JguOMTbb2/h7avwtrm5Rh
	8mkThsKwJ3xItMwsv+7gUogQ0oJo8q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768983155;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oU749SDo5J3PWFW4FxuIHDE7h+Fsbj9bTexCfG3H1s=;
	b=YvJgkb5UXrfzIg+6PQt8h4uOcE57/eAeQPFVrh3veDutRvH5WJUCBv20XMk2UUhjnkXTZN
	Vb1dNV2GZAFWaVDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ienWLs4A;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Q5L4a/06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768983154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oU749SDo5J3PWFW4FxuIHDE7h+Fsbj9bTexCfG3H1s=;
	b=ienWLs4At+iLfuIx84Gz88i5wdkz4QOzFeWfZGVtu0d3kyJRqFlTOouISNtq23x3AFkBC9
	YBilL56bYYVsokkVlO/Y6p6AB67ufm6MpY1aGdZ3/JhmKpa42lUqWHXg5FS6Ewtidou+L/
	hUz63gRsfCV82OqI30pf7GO1/SNLHn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768983154;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9oU749SDo5J3PWFW4FxuIHDE7h+Fsbj9bTexCfG3H1s=;
	b=Q5L4a/06+3mu6X8TEe2kRFn2tOnQtTAsGGPoPy4/uVqJYnCP2h7o3OXUHe+VMrWHumL4zZ
	WEMZaow4O7jlcyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D5983EA63;
	Wed, 21 Jan 2026 08:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LzYMBnKKcGlibgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Jan 2026 08:12:34 +0000
Message-ID: <89a3304d-ee46-4498-8a04-fe48d4644b75@suse.cz>
Date: Wed, 21 Jan 2026 09:12:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/21] slab: add sheaves to most caches
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-5-5595cb000772@suse.cz>
 <aW_NK2NXVgtuzCVH@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aW_NK2NXVgtuzCVH@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 46A9933689
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/20/26 19:47, Breno Leitao wrote:
> Hello Vlastimil,
> 
> On Fri, Jan 16, 2026 at 03:40:25PM +0100, Vlastimil Babka wrote:
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -7863,6 +7863,48 @@ static void set_cpu_partial(struct kmem_cache *s)
>>  #endif
>>  }
>>  
>> +static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
>> +					     struct kmem_cache_args *args)
>> +
>> +{
>> +	unsigned int capacity;
>> +	size_t size;
>> +
>> +
>> +	if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
>> +		return 0;
>> +
>> +	/* bootstrap caches can't have sheaves for now */
>> +	if (s->flags & SLAB_NO_OBJ_EXT)
>> +		return 0;
> 
> I've been testing this on my arm64 environment with some debug patches,
> and the machine became unbootable.
> 
> I am wondering if you should avoid SLAB_NOLEAKTRACE as well. I got the
> impression it is hitting this infinite loop:
> 
>         -> slab allocation
>           -> kmemleak_alloc()
>             -> kmem_cache_alloc(object_cache)
>               -> alloc_from_pcs() / __pcs_replace_empty_main()
>                 -> alloc_full_sheaf() -> kzalloc()
>                   -> kmemleak_alloc()
>                     -> ... (infinite recursion)
> 

Oops.

> What about something as:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 26804859821a..0a6481aaa744 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -7445,8 +7445,13 @@ static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
>         if (IS_ENABLED(CONFIG_SLUB_TINY) || s->flags & SLAB_DEBUG_FLAGS)
>                 return 0;
> 
> -       /* bootstrap caches can't have sheaves for now */
> -       if (s->flags & SLAB_NO_OBJ_EXT)
> +       /*
> +        * bootstrap caches can't have sheaves for now (SLAB_NO_OBJ_EXT).
> +        * SLAB_NOLEAKTRACE caches (e.g., kmemleak's object_cache) must not
> +        * have sheaves to avoid recursion when sheaf allocation triggers
> +        * kmemleak tracking.
> +        */
> +       if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
>                 return 0;

Yeah that should work, will do. Thanks a lot!
