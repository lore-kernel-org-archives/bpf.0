Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0993BA241
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297024; cv=none; b=Y9MsbvTcX7d6Krm+ZJXMvttjiuehCg0AGCkZZmOKvbzt9X7iPBmdych0eRiHvFLinU9W/bcKlsdRJ6i1PXlBEYS4BTZ3epHXc+VvGcnJ6kP+eNaDnrZ66k/Lhb86l3cdv7+TqjqBBah3VwigZgkmYRTSoUveKKu0yjk96NQJe40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297024; c=relaxed/simple;
	bh=A2kEZA/mUAX+IKe4bxE9lYGihE46+gDIYGkZlLhFZVM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fcWMP1NkYwBIsAXwn5mf9Z9RXVfjdH9EAijq3rOxvIq9V6+IjdIkKtRfEGWsL3CmzKf45CapbOweK10+UMsns6Ib5IEq5BWC90GsCMCi3ZkHBBVvuWcF5mjFdDpQYtA1HWmHx6YzSNmFjGpzrQ3A6Fi+jcX2tpzLEggDfv//DiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFseX4vo; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFseX4vo"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d03db7f87so7040362f8f.3
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777297021; x=1777901821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iO+oY1egBOAvuRjfbGOHHFDWrDQrN8K7iEqFSlKJEq4=;
        b=bFseX4voQMozNbvTI+lAXOaRIyk35/kzGSBfQy7amEEWeAS6F2u5dfLbpm7o8W7mn0
         YD8MAnFaDJG8s6PfRVZtLHBzfVSDsISN2e2rUTwVBZQG6ghY6+FxXpcBqurf1eF//cI4
         qirSGuy6vshtqlzBvPyWLwMesbW+0RHBu+2Xz8VugpfBc/w6bVxZmgpg1AjIq9lCWPhG
         4TRu9PaazDx4W3BEj/O4nYmZvhoob/f70aD1WxNYozyMcXpnYh30jMgNTE4yvF9siYvG
         6XrfyQGlzYjVyOVgGZGZE44/8M3YYph5a9Vy5BEKJIZLCy0sW7A0r8DVdogzvMJ/n6+z
         kJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297021; x=1777901821;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO+oY1egBOAvuRjfbGOHHFDWrDQrN8K7iEqFSlKJEq4=;
        b=hMNTpjJ/ofOhj7TmYnWfQT/v+pnVBvD68DgSz1ot4btLLCIHCW3V5H05JaRTarmWLi
         o1AsA6TjsKlyNlV97BEoDOTT1Fv219VF+wDoumh5RGpuiefwgpaBVyr/ZaMsyRTma5st
         wgbDANHbWc8k/bYbzcfkIvXmRdn5d4KU1+cl2ppIqY2aWvBwybTm34WjDUJy/ODabejG
         RVt6rjeXEFA6tMeXkD3tb8zii1NmShn3YXY/BIGx/O5MsFwTKRLteu+ous1IKeFAwjqZ
         0nnaCT196Ft1FvcThH/X5wMK+GaHSh74JC0WaIL2+vCQ36VkLwYZ1acitV83qS7FH6x/
         wudw==
X-Gm-Message-State: AOJu0Yy52ZmBHTsQrKtumy8gVMZyQNLLVgT0JiCYaioxi02re14DVbdE
	74l93WxHoSuhdeVb04Xx+QwdjIEMVhuEXE6p+1SdGsjBnreByo3xBzOB
X-Gm-Gg: AeBDiesrV1gsKcb5WmbJO21tGMfuwts0NUFWU4zbiT4fTg4PgjiFDPUVqoNwacYXYVG
	p1znVvYurRz5xuez7IoMuRAfZHa1UOl6ziB7hOq5NYfX/mgeO+llBlkfl6Lq8q2TRRtSdfMBgBv
	KMosM4lG2nX2f+FO8T4XeKsbLgc9YMCnveQSlTzmXWbpIPdo0VPtg69LzZ3TuJH26701wZFHwRK
	bXj2NDPNmcp64yYI+JZQnLkHUNOBsGiXrcIrmMpqsBixH6zEFL7ucaxR9ZnTWIusNQdFm35yjLD
	jAAKIv8+DE3fNFMvU+TLe+QCtwPN+UAoK5ALivUckxyJFpdYcodhxYya7oMx3LXxiXh6WnkHwuD
	tLBhLdXlIg7XGvwzFmyJErRK7KHRG3DU0hdgqGLIlFj5lWQrC6J2igqDfYatKfwajrLYNhRyWpo
	6ebOzyxBPPVWfkpn80BX0jvD31fXejE/tt6/lruBjT3h15tkqn3pYtcZLG9AjxN9WXOJR+AA==
X-Received: by 2002:a05:6000:2dc2:b0:441:2473:c30a with SMTP id ffacd0b85a97d-4412473c325mr36907508f8f.31.1777297020570;
        Mon, 27 Apr 2026 06:37:00 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:41c:7d40:6eb8:2571? ([2620:10d:c092:500::4:d898])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4daf2sm78164747f8f.33.2026.04.27.06.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 06:37:00 -0700 (PDT)
Message-ID: <f884c8f3-8516-4852-9460-57fbf806fc86@gmail.com>
Date: Mon, 27 Apr 2026 14:36:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 04/10] bpf: Implement batch ops and iterators
 for resizable hashtab
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260424-rhash-v3-4-d0fa0ce4379b@meta.com>
 <20260424202858.7DD0FC19425@smtp.kernel.org>
 <dd0057c1-e0b2-4559-afe9-2bf19760f68b@gmail.com>
Content-Language: en-US
In-Reply-To: <dd0057c1-e0b2-4559-afe9-2bf19760f68b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/25/26 10:24 PM, Mykyta Yatsenko wrote:
> 
> 
> On 4/24/26 9:28 PM, sashiko-bot@kernel.org wrote:
>> Sashiko AI review found 4 potential issue(s):
>> - [High] Cursor invalidation in batch and seq_file iterators causes O(N^2) complexity and infinite loops.
>> - [High] Unbounded RCU read lock duration in batch operations allows user-triggered RCU stalls.
>> - [High] Map iterators and seq_file dumps spuriously abort during normal background resizes.
>> - [High] Deadlock risk in `bpf_each_rhash_elem` due to acquiring `spin_lock` from atomic contexts.
>> --
>>
>> commit 9f7ce51619eb27e8a4a65df12f862e12e34bc285
>> Author: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> bpf: Implement batch ops and iterators for resizable hashtab
>>
>> This commit adds batch operations for resizable hashtab maps, using
>> rhashtable_walk_enter_from() to resume iteration. It also wires up
>> seq_file BPF iterators and implements rhtab_map_mem_usage().
>>
>>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>>> index d37f3d548d3658..000caa2c7f4cd9 100644
>>> --- a/kernel/bpf/hashtab.c
>>> +++ b/kernel/bpf/hashtab.c
>>
>> [ ... ]
>>
>>> @@ -3066,64 +3066,330 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
>>> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>>> +				void *callback_ctx, u64 flags)
>>> +{
>>
>> [ ... ]
>>
>>> +	/*
>>> +	 * The rhashtable walk API uses spin_lock in rhashtable_walk_start/stop,
>>> +	 * which is not safe in NMI or soft/hard IRQ context.
>>> +	 */
>>> +	if (in_nmi() || in_hardirq() || in_softirq())
>>> +		return -EOPNOTSUPP;
>>> +
>>> +	rhashtable_walk_enter(&rhtab->ht, &iter);
>>
>> Does this adequately protect against deadlocks when called from kprobes or
>> tracepoints in process context with preemption disabled?
>>
>> If a thread currently holding ht->lock (e.g., during map insertion) is
>> interrupted by a kprobe that runs this BPF program, attempting to acquire
>> the same spin_lock inside rhashtable_walk_enter() might cause a deadlock.
>>
>>> +	rhashtable_walk_start(&iter);
>>> +
>>> +	while ((elem = rhashtable_walk_next(&iter))) {
>>> +		/* rhashtable_walk_next returns -EAGAIN on resize, abort */
>>> +		if (IS_ERR(elem)) {
>>> +			num_elems = -EBUSY;
>>> +			break;
>>> +		}
>>
>> Is it expected to abort the entire iteration if a background map resize
>> occurs? 
>>
>> rhashtable_walk_next() returns -EAGAIN to indicate the table was resized and
>> the iterator was rewound. Since resizable hashtabs automatically resize
>> during normal workloads, returning -EBUSY here could cause
>> bpf_for_each_map_elem() and bpftool map dumps to randomly fail.
>>
>> Should this handle -EAGAIN by retrying or continuing the walk instead?
> 
> No, resize is not handled automatically.
> 
>>
>> [ ... ]
>>
>>> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
>>> +					       const union bpf_attr *attr,
>>> +					       union bpf_attr __user *uattr,
>>> +					       bool do_delete)
>>> +{
>>
>> [ ... ]
>>
>>> +	/*
>>> +	 * Use the last key from the previous batch as cursor.
>>> +	 * enter_from positions at that key's bucket, walk_next
>>> +	 * returns the successor in O(1).
>>> +	 * First call (ubatch == NULL): starts from bucket 0.
>>> +	 */
>>> +	if (ubatch) {
>>> +		buf = kmalloc(key_size, GFP_USER | __GFP_NOWARN);
>>> +		if (!buf) {
>>> +			ret = -ENOMEM;
>>> +			goto free;
>>> +		}
>>> +		if (copy_from_user(buf, ubatch, key_size)) {
>>> +			ret = -EFAULT;
>>> +			goto free;
>>> +		}
>>> +	}
>>> +
>>> +	scoped_guard(rcu) {
>>> +		rhashtable_walk_enter_from(&rhtab->ht, &iter, buf, rhtab->params);
>>> +		rhashtable_walk_start(&iter);
>>> +	}
>>
>> If the key stored in buf was already deleted, will this iteration restart
>> from the beginning of the map?
>>
> 
>  
> yes, if cursor is deleted, iteration is restarted.
> 
>> Looking at rhashtable_walk_enter_from(), if it fails to find the key, it
>> leaves iter->slot at 0. Then rhashtable_walk_start() and walk_next() will
>> start from bucket 0 instead of where the previous batch left off.
>>
>> Since lookup_and_delete_batch deletes the elements returned in the previous
>> batch, the cursor key will always be deleted. Could this cause the iterator
>> to repeatedly scan over all emptied buckets, resulting in an expensive
>> traversal?
>>
> 
> If too many elements are deleted, the table will be resized, so the
> number of empty buckets traversed should not be very big. But this is a
> good point, we may not need to store the cursor at all.

Probably a safer fix would be just to use the next element as a cursor.

> 
>> Similarly, for lookup_batch and seq_file dumps, if the cursor is
>> concurrently deleted, could this trap userspace in an infinite loop of
>> duplicate elements?
>>
> 
> This should not cause infinite loop, if cursor is deleted every time,
> we'll run out of elements. Table resize exposes any iterators to the risk
> of duplicate elements, it's up to user to make sure table is in steady
> state when iterating.
> 
>>> +
>>> +	dst_key = keys;
>>> +	dst_val = values;
>>> +	total = 0;
>>> +
>>> +	while (total < max_count) {
>>> +		elem = rhtab_iter_next(&iter);
>>> +		if (!elem)
>>> +			break;
>>
>> Can this loop cause RCU stalls or soft lockups if max_count is very large? 
>>
>> The max_count parameter is controlled by userspace. Since
>> rhashtable_walk_start() acquires the RCU read-side critical section, this
>> loop might iterate, copy memory, and process millions of elements without
>> ever dropping the RCU lock or calling cond_resched().
>>
>  
> Existing htab does handle this situation; maybe splitting big batch into
> smaller chunks with 
> ```
> rcu_read_unlock();
> bpf_enable_instrumentation();
> ```
> in between will help.
> 
>> [ ... ]
>>
>>> +static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>>> +	__acquires(RCU)
>>> +{
>>
>> [ ... ]
>>
>>> +	elem = rhashtable_walk_next(&info->iter);
>>> +	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
>>> +	if (IS_ERR(elem))
>>> +		return ERR_PTR(-EBUSY);
>>
>> Similar to bpf_each_rhash_elem, will returning -EBUSY here on normal hash
>> table resizes cause userspace map dumps to fail spuriously?
>>
>  
> This is by design.
> 
>> [ ... ]
>>
>>> +static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>> +{
>>
>> [ ... ]
>>
>>> +	elem = rhashtable_walk_next(&info->iter);
>>> +	/* rhashtable_walk_next returns -EAGAIN on resize, abort */
>>> +	if (IS_ERR(elem))
>>> +		return ERR_PTR(-EBUSY);
>>> +
>>> +	return elem;
>>> +}
>>
>> Again, aborting on -EAGAIN here might interrupt the map dump when a resize
>> happens in the background. Is there a way to handle -EAGAIN without failing
>> the entire sequence?
>>
> 

