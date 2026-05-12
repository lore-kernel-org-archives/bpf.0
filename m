Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE339A047
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578625; cv=none; b=fAwWBXdlB+2DeBOBl9QTj0ZpVyilusXXOc4K9LXqDvVQrdQOgcnlgC1a64LWeeL6lnvLsua2Br+KSdIam1jJ+oF1G5QDyx1wUS1KcZnHnd6tevep51doATg3rSMq/yHEQ7yoPEkosnWK7kNmaN8Ar1LmNDyrHKorVNWimKSHSAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578625; c=relaxed/simple;
	bh=h1c7WlF0eO4XFsRi+bXuKWCQloLuvGFJm5M3Yr7QuFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPnubXSB3XHbCyWp9Eki2w60qHCgbtBTA1Nt9Mq8+GY/fMM2WtrzqISo7NwU9UnsEuYTKjbW7CczclPpo5zf7RtSBW0bJ8E8wpgVaV5k/pHe+SRcduCW20Whhr+I2W51awEsilMTWgMMsvYzbvw885373l9DSjZXv/vJI/O2sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=avQvWjHi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="avQvWjHi"
Message-ID: <6cf003cb-f39c-4362-9b24-e479b988ecd3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778578610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T20NslB0IYADqB7NaB6OdKMLIjFa/Li1Y4ec0dAtHc4=;
	b=avQvWjHigzU7HCJ8Pa09LGj+MI4xauLUbWi8dFaZc97TpLhA1cXTC2VwTRjLyqkvI1/6wV
	ZMUkhZ/oKcP9HMcHl8naUkL2gD4JGSPnUbmBFgAoZ7eN+a1njaZ+l1m3Ijs/NIODAP4U36
	Z6VOJraCL731kL6vV+Htq1duzAWoYYg=
Date: Tue, 12 May 2026 17:36:07 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v10 3/8] bpf: Introduce the bpf_list_del
 kfunc.
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
 martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 chengkaitao@kylinos.cn, skhan@linuxfoundation.org, memxor@gmail.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260512055919.95716-4-kaitao.cheng@linux.dev>
 <297a19ac8fb5fc8ab279a932137bf39604f2f3637521ff6d7d4b39c364a52e07@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <297a19ac8fb5fc8ab279a932137bf39604f2f3637521ff6d7d4b39c364a52e07@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I have clarified this issue in the [PATCH bpf-next v10 3/8] patch,
with the link provided below:

https://lore.kernel.org/bpf/0637c1ce-0e73-4505-8a0c-e77339f4aefb@linux.dev/

在 2026/5/12 14:41, bot+bpf-ci@kernel.org 写道:
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
>> +
> 
> Looking at bpf_list_pop_front() and bpf_list_pop_back() in the same
> file, both functions read from the list_head (h->next or h->prev)
> before passing it to __bpf_list_del(). If the list is uninitialized,
> they end up passing potentially invalid pointer values to __bpf_list_del(),
> which then has to handle this by initializing the list and returning NULL.
> 
> While __bpf_list_del() handles this correctly, would it be clearer to
> move the initialization check into the top-level kfuncs (like
> bpf_list_pop_front/back) so that __bpf_list_del() always receives a
> valid list_head pointer rather than potentially garbage values that
> get ignored later?
> 
> Reference: https://lore.kernel.org/bpf/af50d188f6bc2de81fe3c321b26a645a9425ba9f2644cb6f8525d5bb637385f9@mail.kernel.org/
> 
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
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 11054ad89c14..a6bcbe68cd72 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10744,6 +10744,7 @@ enum special_kfunc_type {
>>  	KF_bpf_list_push_back,
>>  	KF_bpf_list_pop_front,
>>  	KF_bpf_list_pop_back,
>> +	KF_bpf_list_del,
>>  	KF_bpf_list_front,
>>  	KF_bpf_list_back,
>>  	KF_bpf_cast_to_kern_ctx,
> 
> [ ... ]
> 
>> @@ -11456,7 +11459,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>>
>>  	switch (node_field_type) {
>>  	case BPF_LIST_NODE:
>> -		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
>> +		ret = is_bpf_list_push_kfunc(kfunc_btf_id) ||
>> +		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del];
>>  		break;
>>  	case BPF_RB_NODE:
>>  		ret = (is_bpf_rbtree_add_kfunc(kfunc_btf_id) ||
> 
> Can bpf_list_del actually be called from BPF programs? Looking at the
> verifier's handling of KF_ARG_PTR_TO_LIST_NODE arguments in
> check_kfunc_args():
> 
> 	case KF_ARG_PTR_TO_LIST_NODE:
> 		...
> 		if (!reg->ref_obj_id) {
> 			verbose(env, "allocated object must be referenced\n");
> 			return -EINVAL;
> 		}
> 
> This code path unconditionally requires an owning reference (ref_obj_id
> must be non-zero). However, once a node is added to the list via
> bpf_list_push_front/back, the owning reference is converted to a
> non-owning reference (ref_obj_id becomes 0). This means bpf_list_del
> cannot be called on nodes that are actually in the list.
> 
> The sister kfunc bpf_rbtree_remove handles this by having a special
> branch in check_kfunc_args() that accepts non-owning references for
> that specific kfunc. Does bpf_list_del need similar handling to allow
> removing nodes that are actually in the list?
> 
> Reference: https://lore.kernel.org/bpf/294242698d576e4fedf243ab055c6f9a984e55033933a9bd09808f62a7018e9d@mail.kernel.org/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25716874656

-- 
Thanks
Kaitao Cheng

