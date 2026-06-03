Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACBD43D4F6
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 08:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780476201; cv=none; b=hSD/lr3rvCnyouTpT4Dc9TnS/6aLLGKAJWDJAhhBWGd2x8U/R1j/fS52PavqQu1kx7DVJp+nOpwfyw/SV0DyL3mHazM5ty+9P5INAoF0jcIGgp1UDIri2dWhVaF+HT2ottSWhQKnWAQBE27YhG2D2h0xYjJMhINooUUXvcIbkXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780476201; c=relaxed/simple;
	bh=neRdMmqsu+xeIevkABFuVkJfsDh+Fvk+6xUxtHdyj7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nv634kRN+jBlZTfIaSOQhY8LB3vmYO2IGYRR6fjHa0MCqgz3ixRx5AH2IyYMwxH4uqwd7V0c3Am4r9M5mN2FDPXinXxb+2cSEEBsdiX5WBr7aGHfX4l2OGDe7scvDiVmVwiDjeKB5+PgdvZqJiulnpulRoQ58Ema/WC1uL5zgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oPhkfvP0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oPhkfvP0"
Message-ID: <fc9077f5-ec68-43d9-a874-c110e38b2530@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780476197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmtTBGssJBnFw/NUoGfjkfUe7XkUJMyaR/OPnVmUDg0=;
	b=oPhkfvP0N/Cxa9Rh4GvRJf401qh6UGMeuT57y2jlP5N7U4fqZwsGHqVzkGUxA5nTNkkEmr
	V8llpMakmz5ojzIeScDuk2z4sUjO/q/CQ1D/cs0XRVsQDN4CqDdtnn9Ypzy+uqRNlTYzla
	qQ0NJN11dCO8GxNzJQ3Ru0jNf23iDF0=
Date: Wed, 3 Jun 2026 16:42:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Clear rb node linkage when freeing bpf_rb_root
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, davemarchevsky@fb.com, linux-kernel@vger.kernel.org,
 chengkaitao@kylinos.cn, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260601055859.13888-1-kaitao.cheng@linux.dev>
 <20260601061503.EFD881F00898@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <20260601061503.EFD881F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/6/1 14:15, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] Unbounded O(N) red-black tree traversal inside an IRQ-disabled spinlock critical section introduces latency spikes, potential soft/hard lockups, and deadlocks.
> 
> Pre-existing issues:
> - [High] Nodes added to a deleted map element's rbtree after `bpf_obj_free_fields` are permanently leaked.
> --
> 
> commit 867fefb5dd2755c5bd12c9f3bd37d5367c6793f3
> Author: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> bpf: Clear rb node linkage when freeing bpf_rb_root
> 
> This commit modifies bpf_rb_root_free to clear red-black node linkage when
> freeing a root. It mirrors list draining behavior by marking nodes as busy
> while detaching the root, clearing the linkage, and releasing the owner
> before dropping the containing object.
> 
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index b5314c9fed3cf..c7f26336984f0 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2296,22 +2296,30 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>>  {
>>  	struct rb_root_cached orig_root, *root = rb_root;
>>  	struct rb_node *pos, *n;
>> -	void *obj;
>>  
>>  	BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
>>  	BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
>>  
>>  	__bpf_spin_lock_irqsave(spin_lock);
>>  	orig_root = *root;
>> +	bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
>> +		struct bpf_rb_node_kern *node;
>> +
>> +		node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
>> +		WRITE_ONCE(node->owner, BPF_PTR_POISON);
>> +	}
> 
> [Severity: High]
> Since there is no verifier-enforced limit on the number of nodes in a BPF
> rbtree, could this O(N) post-order traversal trigger latency spikes, RCU
> stalls, or NMI watchdog lockups?
> 
> This loop runs inside the __bpf_spin_lock_irqsave() critical section, which
> disables local interrupts.

The critical sections protected by the bpf_spin_lock are very small.
They only do simple pointer/value assignments and do not perform
any expensive operation, so I do not think they should introduce
noticeable latency by themselves.

> Additionally, since rb_first_postorder() and rb_next_postorder() are
> exported and traceable, if an fentry/fexit BPF program is attached to them
> and attempts to acquire the same bpf_spin_lock, will it cause a hard deadlock?

I am not entirely sure whether this needs to be changed. I would like
to hear others' opinions on this. If we do want to avoid calling
rb_first_postorder()/rb_next_postorder() here, the straightforward
fix would be to duplicate these two helpers with exactly the same
implementation but under different names, and use the renamed versions
locally. That feels somewhat redundant to me, though.

>>  	*root = RB_ROOT_CACHED;
>>  	__bpf_spin_unlock_irqrestore(spin_lock);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this pattern permanently
> leak memory if a concurrent BPF program adds a node after the tree is emptied?
> 
> When a map element is replaced or deleted, bpf_obj_free_fields() detaches
> the tree here and sets *root = RB_ROOT_CACHED. However, a concurrent BPF
> program running inside an RCU critical section might still hold a pointer
> to the map element.
> 
> If that program takes the spinlock and calls bpf_rbtree_add(), it will
> successfully add a new node to the now-emptied tree.
> 
> After the RCU grace period ends, bpf_mem_free_rcu() frees the map element,
> but bpf_obj_free_fields() is never called again. Will the newly added node
> be left behind and leaked?

This looks like a more general pre-existing issue. I am not sure whether
we should fix it in this series, and would like to hear others' opinions.

If we do want to fix it here, maybe we need to distinguish map_free/delete
from in-place map_update. For map_free/delete, a concurrent bpf_rbtree_add()
after the tree is detached should fail and drop the node. For in-place
map_update, the root should still be reset so that it remains usable.

-- 
Thanks
Kaitao Cheng

