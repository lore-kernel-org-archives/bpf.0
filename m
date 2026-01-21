Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F366C48C40A
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769001736; cv=none; b=mM6+Nvzq43sWUBHPUp2E3gW5T2SnK202BYukZrPshh3XZmUm61tuqj2QzoeBvLMkEJtVt21KS8313e5Vx6IXe0FtCQeg1zCFweWL+AfyoGl/g3DNvtG21FWWT5p2J4mBVwqS6sOnjvzAFcRFqHSOHCxxagAGUkp1Dqh+2eU4B9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769001736; c=relaxed/simple;
	bh=CqyKOgPt5AwsmJeo+tNQPG5M/otSFkIG4/HCiwaER3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0nhjX6iuNeKNDCQ+oUZQvwe3XfBfCkP/pQwEbnHH14Dg3t9vqAIhqx5TZ/Z4q8eHu4NkMfDCsHOHA5iC3LdjIhPwu6IfcQid+C4br77+zAk3qQylBI4v/HmNcK8leyhkpgdXUYbEclg3peRl9KvIKOjHHDoPR6qsiPnVZjZrBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKZTLDQ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xv57NFaS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CKZTLDQ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xv57NFaS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKZTLDQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xv57NFaS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CKZTLDQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xv57NFaS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A28D336A1;
	Wed, 21 Jan 2026 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769001733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=shsGpPkdTpgh2O3TvGdc0KosuzZDmGShHqMUn9wd7Ck=;
	b=CKZTLDQ1olFsUiLxebYBI7V7mqZzU9LM1uJMj3grHOiSbNV27PM1IIzJ/9uFAsiS8xD+t4
	TczVrUN7LQwilvQNBIwtNFDevjw0tLA0PZkm5n4BJpyoiLGSexPY3EIZ0x4LuXi4qiaf9n
	000iLRd9HHqu58Tr3jHnZycO2FO7gwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769001733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=shsGpPkdTpgh2O3TvGdc0KosuzZDmGShHqMUn9wd7Ck=;
	b=Xv57NFaSo4zZ4KWnFbrVkQE7lTQSvPtDV5GDVBA5fzIURjLG0ttHHRW6Xd/npyaNDUx/dn
	mLMsthjhfg8eLvAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CKZTLDQ1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xv57NFaS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769001733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=shsGpPkdTpgh2O3TvGdc0KosuzZDmGShHqMUn9wd7Ck=;
	b=CKZTLDQ1olFsUiLxebYBI7V7mqZzU9LM1uJMj3grHOiSbNV27PM1IIzJ/9uFAsiS8xD+t4
	TczVrUN7LQwilvQNBIwtNFDevjw0tLA0PZkm5n4BJpyoiLGSexPY3EIZ0x4LuXi4qiaf9n
	000iLRd9HHqu58Tr3jHnZycO2FO7gwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769001733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=shsGpPkdTpgh2O3TvGdc0KosuzZDmGShHqMUn9wd7Ck=;
	b=Xv57NFaSo4zZ4KWnFbrVkQE7lTQSvPtDV5GDVBA5fzIURjLG0ttHHRW6Xd/npyaNDUx/dn
	mLMsthjhfg8eLvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A6F83EA63;
	Wed, 21 Jan 2026 13:22:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OTCoGQTTcGlWKAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 21 Jan 2026 13:22:12 +0000
Message-ID: <fec4ed92-32e1-4618-99d6-0eac77da1ff3@suse.cz>
Date: Wed, 21 Jan 2026 14:22:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
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
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
 <CAJuCfpErRjMi2aCCThHiS1F_LvaXjkVQvX9kJjqrpw8YnXoNBA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAJuCfpErRjMi2aCCThHiS1F_LvaXjkVQvX9kJjqrpw8YnXoNBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 1A28D336A1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On 1/20/26 18:19, Suren Baghdasaryan wrote:
> On Fri, Jan 16, 2026 at 2:40 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> At this point we have sheaves enabled for all caches, but their refill
>> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
>> slabs - now a redundant caching layer that we are about to remove.
>>
>> The refill will thus be done from slabs on the node partial list.
>> Introduce new functions that can do that in an optimized way as it's
>> easier than modifying the __kmem_cache_alloc_bulk() call chain.
>>
>> Extend struct partial_context so it can return a list of slabs from the
>> partial list with the sum of free objects in them within the requested
>> min and max.
>>
>> Introduce get_partial_node_bulk() that removes the slabs from freelist
>> and returns them in the list.
>>
>> Introduce get_freelist_nofreeze() which grabs the freelist without
>> freezing the slab.
>>
>> Introduce alloc_from_new_slab() which can allocate multiple objects from
>> a newly allocated slab where we don't need to synchronize with freeing.
>> In some aspects it's similar to alloc_single_from_new_slab() but assumes
>> the cache is a non-debug one so it can avoid some actions.
>>
>> Introduce __refill_objects() that uses the functions above to fill an
>> array of objects. It has to handle the possibility that the slabs will
>> contain more objects that were requested, due to concurrent freeing of
>> objects to those slabs. When no more slabs on partial lists are
>> available, it will allocate new slabs. It is intended to be only used
>> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
>>
>> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
>> only refilled from contexts that allow spinning, or even blocking.
>>
> 
> Some nits, but otherwise LGTM.
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks.

> 
> From the above code it seems like you are trying to get at least
> pc->min_objects and as close as possible to the pc->max_objects
> without exceeding it (with a possibility that we will exceed both
> min_objects and max_objects in one step). Is that indeed the intent?
> Because otherwise could could simplify these conditions to stop once
> you crossed pc->min_objects.

Yeah see my reply to Harry, it's for future tuning.
 
>> +       if (slab->freelist) {
> 
> nit: It's a bit subtle that the checks for slab->freelist here and the
> earlier one for ((slab->objects - slab->inuse) > count) are
> effectively equivalent. That's because this is a new slab and objects
> can't be freed into it concurrently. I would feel better if both
> checks were explicitly the same, like having "bool extra_objs =
> (slab->objects - slab->inuse) > count;" and use it for both checks.
> But this is minor, so feel free to ignore.

OK, doing this for your and Hao Li's comment:

diff --git a/mm/slub.c b/mm/slub.c
index d6fde1d60ae9..015bdef11eb6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4505,7 +4505,7 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
  * Assumes the slab is isolated from node partial list and not frozen.
  *
  * Assumes this is performed only for caches without debugging so we
- * don't need to worry about adding the slab to the full list
+ * don't need to worry about adding the slab to the full list.
  */
 static inline void *get_freelist_nofreeze(struct kmem_cache *s, struct slab *slab)
 {
@@ -4569,10 +4569,17 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 {
        unsigned int allocated = 0;
        struct kmem_cache_node *n;
+       bool needs_add_partial;
        unsigned long flags;
        void *object;
 
-       if (!allow_spin && (slab->objects - slab->inuse) > count) {
+       /*
+        * Are we going to put the slab on the partial list?
+        * Note slab->inuse is 0 on a new slab.
+        */
+       needs_add_partial = (slab->objects > count);
+
+       if (!allow_spin && needs_add_partial) {
 
                n = get_node(s, slab_nid(slab));
 
@@ -4594,7 +4601,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
        }
        slab->freelist = object;
 
-       if (slab->freelist) {
+       if (needs_add_partial) {
 
                if (allow_spin) {
                        n = get_node(s, slab_nid(slab));

