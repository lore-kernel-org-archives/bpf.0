Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224A386552
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343937; cv=none; b=VVjAVKfxb40o3NErqYGNA+AEDjOD9xlBY6iit/9Ejn3wiKtgzdoiUYwnekSV32X/+Cf/pXkktyl22fg/0va7jM2jr+OdRjUOXdBc0HjS3W1k+YtMDcJ/k/RL/VCYK+UJ2gBPNM/Mh3Jrs9GIk54o9xFgJrhm0zHqpHRE0zXHWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343937; c=relaxed/simple;
	bh=raJPW6sw8ZqcjtVnpcCSp1V1gkoDLFL4/+bdI3yisUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saQJ9DbYKZ9W8uIO33RSj1zO/CUazxHHPVxcqp05a3MhBOuANwCXHQAr8LNiixdpT5PPyljETFfZmD4kQ+65oLpDq7CmbhhLZy7kexDIz6tXIKe4bEKuU+WXOId4N7an+kN5DzXdnswWjxR2sl0qZm6hzr027PF11I7iAA7jKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DIrSViX/; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DIrSViX/"
Message-ID: <23c93af8-c025-4c39-b0df-b84562756c30@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779343921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=255yUP+COzLOATJHIQiHzRErI8DeSF7IuKku14LXU6E=;
	b=DIrSViX/rFnHdNbP/64T9lzCRyQNNW2cqY+H2hzDLr/ejTGDKR+eC/zWIPIBwEGj2cGDl2
	2Jt5AqcCgcg9sdaVLXAm/SPVucWyuJNH2eAQWIBBCbZRwVQRFc0LcoDNl5zqOi1wqqDRbi
	/FctbRwZdBcZjSnRncfTkBV0GWuXxz0=
Date: Thu, 21 May 2026 14:11:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/8] bpf: clear list node owner and unlink
 before drop
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260521032306.97118-3-kaitao.cheng@linux.dev>
 <20260521043023.A0BD71F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260521043023.A0BD71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/21 12:30, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Potentially unbounded O(N) list traversal with interrupts disabled in `bpf_list_head_free()`.
> 
> Pre-existing issues:
> - [High] The patch fixes the stale `node->owner` issue for `bpf_list_head_free()` but fails to apply the equivalent fix for `bpf_rb_root_free()`, leaving `bpf_rbtree_remove()` vulnerable to the same memory corruption.
> --
> 
> commit 59439e3ee3f8d57af8635b521393d245d26bbdf4
> Author: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> bpf: clear list node owner and unlink before drop
> 
> This commit fixes an issue where refcounted BPF list nodes can outlive their
> list head and retain a stale owner pointer. To prevent memory corruption if a
> new list is allocated at the same address, it moves nodes to a private drain
> list under the spinlock, poisons their owner pointers, and unlinks them
> before dropping the objects.
> 
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 094457c3e6d37..59855b434f0b2 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> 
> [ ... ]
> 
>> @@ -2261,20 +2262,30 @@ void bpf_list_head_free(const struct btf_field *field, void *list_head,
>>  	__bpf_spin_lock_irqsave(spin_lock);
>>  	if (!head->next || list_empty(head))
>>  		goto unlock;
>> -	head = head->next;
>> +	list_for_each_safe(pos, n, head) {
>> +		struct bpf_list_node_kern *node;
>> +
>> +		node = container_of(pos, struct bpf_list_node_kern, list_head);
>> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
>> +		list_move_tail(pos, &drain);
>> +	}
> 
> [Severity: High]
> Could this new loop potentially cause a long CPU stall?
> 
> Since __bpf_spin_lock_irqsave() disables local interrupts, this O(N) list
> traversal executes with interrupts disabled.
> 
> BPF lists do not have a hard size limit, so if a program accumulates a
> very large number of elements in a single list, could iterating over them
> here trigger the NMI watchdog or cause severe latency spikes?

This is merely address-taking and assignment, so it is almost negligible
in cost, and the likelihood of causing a soft lockup is very low.

>>  unlock:
>> -	INIT_LIST_HEAD(orig_head);
>> +	INIT_LIST_HEAD(head);
>>  	__bpf_spin_unlock_irqrestore(spin_lock);
>>  
>> -	while (head != orig_head) {
>> -		void *obj = head;
>> +	while (!list_empty(&drain)) {
>> +		struct bpf_list_node_kern *node;
>>  
>> -		obj -= field->graph_root.node_offset;
>> -		head = head->next;
>> +		pos = drain.next;
>> +		node = container_of(pos, struct bpf_list_node_kern, list_head);
>> +		list_del_init(pos);
>> +		/* Ensure __bpf_list_add() sees the node as unlinked. */
>> +		smp_store_release(&node->owner, NULL);
>>  		/* The contained type can also have resources, including a
>>  		 * bpf_list_head which needs to be freed.
>>  		 */
>> -		__bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>> +		__bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
>> +				    field->graph_root.value_rec, false);
>>  	}
>>  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does bpf_rb_root_free() need
> the exact same fix?
> 
> When draining an rbtree, bpf_rb_root_free() calls __bpf_obj_drop_impl() on
> each node without clearing the node_internal->owner or unlinking the nodes.
> 
> If a surviving refcounted rb-node retains a pointer to the freed rb_root,
> and a new bpf_rb_root is allocated at the old address, wouldn't a call to
> bpf_rbtree_remove(new_root, stale_node) erroneously bypass the ownership
> check and invoke rb_erase_cached() with stale tree pointers?

I will probably send a separate fix patch later; this issue does not need
to be addressed in this patch series.

-- 
Thanks
Kaitao Cheng

