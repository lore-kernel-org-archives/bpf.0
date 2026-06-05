Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B16A378D9C
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653157; cv=none; b=PqugjwGwPLosuLLYxaw6jO7crdiRLxcg/hVh85it9lbsBsrLeaSPk4EywrazrXH2iUDnXZUwufh6ge+j8fISC3VDg9k9UnDsPrQY92uw4qrbQdlhi9B4R15sG6hKuUCgsFgeid+ZbhfuXMDe4GGH4LsYwMSDWb3sFcdyglL+qKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653157; c=relaxed/simple;
	bh=mWvbqrsYbkeE/cm3zd7xqwq3rdSJGn7PVPi5gPAXh+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfkTNf8TZA+SNtvay1Rne+LbkHH53pchsQZYqaVEs4CnHIf6j6RcfCRojFdFO2L22afI36gEXYOYtQ7OsvlsJxrf7Kiw6v+JhjHexAZqlA7vlt62LwYEzS2VxlaCqyKJZ6mUJQT81h7NxGYRtbkXTAiUR9bh27zd7TTr3J2XQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gu+xJf0l; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gu+xJf0l"
Message-ID: <85fced77-a911-420c-b74b-443b5be8c87b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780653143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JP0YqRZUrS2FmrDEVhPxO1T4Yh/mAM9jr0+jM5wghAM=;
	b=Gu+xJf0lFndxnrbk3du1O79Om0H5K40A3LRjDZmFs9ccAtito0/X/sCqvTUAtiUMW14OGK
	zSLBESxeAbVy3LTZWdr5HA4XmGSNsCcqbLJQuz0rcYql0nDANzq7w31sQV3xpm3F6qHcFf
	+VMt1pVoztTLUmT9JLsQofAXT7q+zaM=
Date: Fri, 5 Jun 2026 17:51:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Clear rb node linkage when freeing bpf_rb_root
To: Yonghong Song <yonghong.song@linux.dev>
Cc: davemarchevsky@fb.com, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, Kaitao Cheng <chengkaitao@kylinos.cn>
References: <20260601055859.13888-1-kaitao.cheng@linux.dev>
 <5e4e8089-6eb7-4eec-8ad2-820d99368a55@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <5e4e8089-6eb7-4eec-8ad2-820d99368a55@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/6/2 02:06, Yonghong Song 写道:
> 
> 
> On 5/31/26 10:58 PM, Kaitao Cheng wrote:
>> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>>
>> bpf_rb_root_free() detaches the root by copying the current rb_root_cached
>> and then replacing the live root with RB_ROOT_CACHED. It then walks the
>> copied root and drops each object contained in the tree.
>>
>> This leaves the rb node state intact while dropping the object. If the
>> object is refcounted and survives the drop, its bpf_rb_node_kern still
>> contains an owner pointer to the freed root and stale rb tree linkage. If
>> a later bpf_rb_root allocation reuses the same address, bpf_rbtree_remove()
>> can incorrectly pass the owner check and call rb_erase_cached() on a node
>> whose rb pointers belong to the old tree.
>>
>> Mirror the list draining behavior by marking nodes as busy while the root
>> is being detached, then clear the rb node and release the owner before
>> dropping the containing object. This makes surviving nodes unowned and
>> safe to reject from remove or accept for a later add.
>>
>> Fixes: 9c395c1b99bd ("bpf: Add basic bpf_rb_{root,node} support")
>> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> 
> Please use [PATCH bpf] tag so CI can test it. Do we need a selftest?

The bug fixed by this patch has fairly strict reproduction conditions,
so it is difficult to find a stable reproducer.

I have addressed the other feedback. Thanks for your review.
please see v2 for details.
https://lore.kernel.org/all/20260605094143.5509-1-kaitao.cheng@linux.dev/

> LGTM with a few nits below.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 
>> ---
>>   kernel/bpf/helpers.c | 18 +++++++++++++-----
>>   1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 9ca195104667..46e8eada463b 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2307,22 +2307,30 @@ void bpf_rb_root_free(const struct btf_field *field, void *rb_root,
>>   {
>>       struct rb_root_cached orig_root, *root = rb_root;
>>       struct rb_node *pos, *n;
>> -    void *obj;
>>         BUILD_BUG_ON(sizeof(struct rb_root_cached) > sizeof(struct bpf_rb_root));
>>       BUILD_BUG_ON(__alignof__(struct rb_root_cached) > __alignof__(struct bpf_rb_root));
>>         __bpf_spin_lock_irqsave(spin_lock);
>>       orig_root = *root;
>> +    bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
>> +        struct bpf_rb_node_kern *node;
> 
> Move 'struct bpf_rb_node_kern *node;' and the below to the top function declaration.
> This will make code simpler.
> 
>> +
>> +        node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
>> +        WRITE_ONCE(node->owner, BPF_PTR_POISON);
>> +    }
>>       *root = RB_ROOT_CACHED;
>>       __bpf_spin_unlock_irqrestore(spin_lock);
>>         bpf_rbtree_postorder_for_each_entry_safe(pos, n, &orig_root.rb_root) {
>> -        obj = pos;
>> -        obj -= field->graph_root.node_offset;
> 
> We can keep this two ...
> 
>> +        struct bpf_rb_node_kern *node;
>>   -
>> -        __bpf_obj_drop_impl(obj, field->graph_root.value_rec, false);
>> +        node = rb_entry(pos, struct bpf_rb_node_kern, rb_node);
>> +        RB_CLEAR_NODE(pos);
>> +        /* Ensure __bpf_rbtree_add() sees the node as unlinked. */
>> +        smp_store_release(&node->owner, NULL);
>> +        __bpf_obj_drop_impl((char *)pos - field->graph_root.node_offset,
>> +                    field->graph_root.value_rec, false);
> 
> and then __bpf_obj_drop_impl(...) will not change.
> 
>>       }
>>   }
>>   
> 

-- 
Thanks
Kaitao Cheng

