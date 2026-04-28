Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF5E37D13D
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386835; cv=none; b=nMDo1SHBfbhm0iPFZH/oraegPJDpLFVYJpPF+X1DxMzhNFsBa4czwJdQKBt23XR20VgSAWPqJkCx1hUe8Fpc4WcQ8xGZ/NJ4FZgd1r6XJWWsYlHh5GQPJ4BuGk9KuBK2oxw1uUcbnP2GUfOcEq6MSI5ut/7wDCer0MSrTZ4k13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386835; c=relaxed/simple;
	bh=wZZTmXEwqvHVwIMKt7eoq7RwPscLgYLqhRUoY2lMqdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBdTnUOtSh2cFHecekCADuvpe8fu0g9hLUCgjncPM66ooUWlVfkBRcyEuIJOlnv4JfYFMJH7dEVc8zMGCqFjHAEZTZPBTDYhb7cwbqfgUq5J4C6RG0y+Bixopwmgw5K18Xv4ry3TWwHs8Csw8tuQJ/r9guQR8HVH/FY+Qp+N5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=whLKSZX2; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="whLKSZX2"
Message-ID: <0637c1ce-0e73-4505-8a0c-e77339f4aefb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777386821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiJ/ZUEvItEQ3cSHWBNKREX0o/wRj01XKfkM10DRZ1M=;
	b=whLKSZX2y86J55Bdxsc4XRg/aSgFUiaGxyVzJQUisjB7Jwn+LMXKPFlbUxfv+agKh05KbV
	CAdVfb7o67U04BCRK2n28zCj5HFXnnmSlgF7DxvJBbdPfMeq2zLbsMPp7X+4UgdQ1JdnaA
	DBs2pNIFgqocxjNpxkVnOxG5HtqtdMA=
Date: Tue, 28 Apr 2026 22:32:56 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Introduce the bpf_list_del kfunc.
To: bot+bpf-ci@kernel.org
Cc: martin.lau@linux.dev, john.fastabend@gmail.com, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, linux-kselftest@vger.kernel.org, chengkaitao@kylinos.cn,
 shuah@kernel.org, jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260427165906.84420-4-kaitao.cheng@linux.dev>
 <294242698d576e4fedf243ab055c6f9a984e55033933a9bd09808f62a7018e9d@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <294242698d576e4fedf243ab055c6f9a984e55033933a9bd09808f62a7018e9d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/4/28 02:43, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 1e8754877dd1..51b6ea4bb8cb 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2593,6 +2593,15 @@ __bpf_kfunc struct bpf_list_node *bpf_list_pop_back(struct bpf_list_head *head)
>>  	return __bpf_list_del(head, h->prev);
>>  }
>>
>> +__bpf_kfunc struct bpf_list_node *bpf_list_del(struct bpf_list_head *head,
>> +					       struct bpf_list_node *node)
>> +{
>> +	struct bpf_list_node_kern *kn = (void *)node;
>> +
>> +	/* verifier guarantees node is a list node rather than list head */
>> +	return __bpf_list_del(head, &kn->list_head);
>> +}
> 
> Can this kfunc actually be called from any BPF program? Looking at the
> verifier's handling of KF_ARG_PTR_TO_LIST_NODE arguments in
> check_kfunc_args():
> 
>     case KF_ARG_PTR_TO_LIST_NODE:
>         if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>             verbose(env, "%s expected pointer to allocated object\n", ...);
>             return -EINVAL;
>         }
>         if (!reg->ref_obj_id) {
>             verbose(env, "allocated object must be referenced\n");
>             return -EINVAL;
>         }
> 
> This code path unconditionally requires an owning reference (ref_obj_id
> must be non-zero).
> 
> However, once a node is added to the list via bpf_list_push_front/back,
> the owning reference is converted to a non-owning reference
> (ref_obj_id becomes 0) via ref_convert_owning_non_owning() and the
> original owning reference is released. Any subsequent access to that
> in-list node (including via bpf_list_front/back) only provides
> non-owning references with ref_obj_id == 0.
> 
> This means:
>   - Passing a non-owning ref to bpf_list_del() fails the verifier's
>     "!reg->ref_obj_id" check with "allocated object must be referenced"
>   - Passing an owning ref to a node not yet in the list passes the
>     verifier check, but __bpf_list_del() will return NULL because
>     node_kern->owner != head
> 
> The sister kfunc bpf_rbtree_remove handles this by having a special
> branch in check_kfunc_args() that accepts non-owning references for
> that specific kfunc. Does bpf_list_del need similar handling?

I have already fixed this issue in [PATCH bpf-next v10 7/8].

> Looking at __bpf_list_del() in kernel/bpf/helpers.c:
> 
> 	node = container_of(n, struct bpf_list_node_kern, list_head);
> 	if (unlikely(READ_ONCE(node->owner) != head))
> 		return NULL;
> 
> Emil Tsalapatis and the Sashiko review bot raised concerns about
> removing the WARN_ON_ONCE that was in v8 of this series. The original
> WARN_ON_ONCE helped detect list corruption by triggering a kernel
> warning when owner != head. The current unlikely() check silently
> returns NULL instead.
> 
> Should this check trigger a warning for debugging list corruption issues?

In previous discussions, people generally advised against keeping
warnings on this kind of path that can be triggered by BPF programs.
 
> Additionally, the Sashiko review noted a reuse bug: when
> bpf_list_head_free() is called on a list that still contains elements,
> those elements remain allocated but their owner field still points to
> the now-freed head. Since the owner field is checked but never cleared,
> could this lead to dangling pointer issues if nodes aren't freed
> properly during list cleanup?

I have already fixed this issue in [PATCH bpf-next v10 2/8].

>> @@ -4725,6 +4734,7 @@ BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_front, KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_back, KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25009536772

-- 
Thanks
Kaitao Cheng

