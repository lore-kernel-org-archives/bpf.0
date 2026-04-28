Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6109C42EEDD
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385994; cv=none; b=WRlBoRKS0k7jeVPGBPGgagWKGA4C8QM/yZcf5fOQaQnLHNhKryvhYbXjSIRAXjDW3EZFVBjfICtXXcjselp3bYvxC/14cHydijt3jB1vsOa4yAoRKClplDTH7t9tMSYSGbDCXtbK0pghq9beTrYEd4VFlvRltumwi7O+xL/FP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385994; c=relaxed/simple;
	bh=4ASok6lZsg8BbYwwx5JAKN7hkwWCOPXgCGyAno0/1u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKSpoQGWnJU8S9nsoXrcIfFXL7vrNMLxjnwEPurJEL4QokNzQAxwlZ+1/wLYaYzjPLIon5AxxXZZPgkLAKKLGmxGOWERQe7+AtglZcmKZ9O9isS9p2L4K+1p6c3dWGcktvlNu8Xf1Uxg9VR40lVLmJmMAIW7LAVNVBlqYPAkvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTnON61R; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTnON61R"
Message-ID: <7bfe13e1-9baa-4b87-b2f8-0fdbe002ef62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777385965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wqkGepTdjcdK5W36MUziMZ3vfTsGiTDn4Y5pGbzjW8=;
	b=VTnON61ROhbf/tEIGjaAq4b75jqVxSRWq3UtNvUZqE9vneNAYHPp0Z2xyZiORSPxkFPyPW
	2jlWhIbEWVLLALCfBUJpJq6prSh6tOdzGOGTM8M+Y2234HygyY97vnQpojnlZOHM4bvX8S
	1DwMMj+ChsbBIcK6xyxJ9lrdNl9Zdxs=
Date: Tue, 28 Apr 2026 22:18:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 5/8] bpf: Add bpf_list_add to insert node
 after a given list node
To: bot+bpf-ci@kernel.org
Cc: shuah@kernel.org, john.fastabend@gmail.com, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, martin.lau@linux.dev, haoluo@google.com, sdf@fomichev.me,
 kpsingh@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev,
 jolsa@kernel.org, chengkaitao@kylinos.cn, linux-kselftest@vger.kernel.org
References: <20260427165906.84420-6-kaitao.cheng@linux.dev>
 <cb7368c6062232b6ad5f9ab1c6a97bc8530566a8b3db5c4deefdd5ea63d31538@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <cb7368c6062232b6ad5f9ab1c6a97bc8530566a8b3db5c4deefdd5ea63d31538@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/4/28 02:43, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2570,6 +2570,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>>  	return bpf_list_push_back(head, node, meta__ign, off);
>>  }
>>
>> +__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
>> +			     struct bpf_list_node *prev, struct btf_struct_meta *meta,
>> +			     u64 off)
>> +{
>> +	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev;
>> +	struct list_head *prev_ptr = &p->list_head;
>> +
>> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
>> +}
>> +
> 
> The 'prev' argument is described in the commit message as "must already be
> in the list." How can a BPF program obtain such a reference and pass it to
> this kfunc?
> 
> A node already in the list is tracked by the verifier as a non-owning
> reference (PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0).
> The typical way to obtain this is via bpf_list_front() or bpf_list_back(),
> which return non-owning references.
> 
> However, check_kfunc_args() in kernel/bpf/verifier.c handles
> KF_ARG_PTR_TO_LIST_NODE by requiring:
> 
>     if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
>         verbose(env, "%s expected pointer to allocated object\n", ...);
>         return -EINVAL;
>     }
>     if (!reg->ref_obj_id) {
>         verbose(env, "allocated object must be referenced\n");
>         return -EINVAL;
>     }
> 
> This check rejects non-owning references. The 'prev' argument in R3 is
> typed as struct bpf_list_node *, so the verifier classifies it as
> KF_ARG_PTR_TO_LIST_NODE and applies this validation.
> 
> Compare with KF_ARG_PTR_TO_RB_NODE, which distinguishes between insertion
> (requires owning ref) and other operations (allows non-owning refs):
> 
>     case KF_ARG_PTR_TO_RB_NODE:
>         if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
>             /* owning ref required */
>         } else {
>             /* non-owning or refcounted allowed */
>         }
> 
> Without a similar distinction for KF_ARG_PTR_TO_LIST_NODE, is there any
> valid BPF register state that satisfies both the verifier check and the
> runtime semantics stated in the commit message?
> 
> It appears the API only works when 'prev' is an owning reference to a
> refcounted object still in the list. This is the pattern used in the
> selftests, but it limits the kfunc to a narrow use case that the commit
> message does not describe.

I have already fixed this issue in [PATCH bpf-next v10 7/8].

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -10742,6 +10742,7 @@ enum special_kfunc_type {
>>  	KF_bpf_list_push_front,
>>  	KF_bpf_list_push_back_impl,
>>  	KF_bpf_list_push_back,
>> +	KF_bpf_list_add,
>>  	KF_bpf_list_pop_front,
>>  	KF_bpf_list_pop_back,
>>  	KF_bpf_list_del,
> 
> [ ... ]
> 
>> @@ -10923,7 +10925,8 @@ static bool is_bpf_list_push_kfunc(u32 func_id)
>>  	return func_id == special_kfunc_list[KF_bpf_list_push_front] ||
>>  	       func_id == special_kfunc_list[KF_bpf_list_push_front_impl] ||
>>  	       func_id == special_kfunc_list[KF_bpf_list_push_back] ||
>> -	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl];
>> +	       func_id == special_kfunc_list[KF_bpf_list_push_back_impl] ||
>> +	       func_id == special_kfunc_list[KF_bpf_list_add];
>>  }
>>
>>  static bool is_bpf_rbtree_add_kfunc(u32 func_id)
>> @@ -19228,8 +19231,11 @@ struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>>  		int struct_meta_reg = BPF_REG_3;
>>  		int node_offset_reg = BPF_REG_4;
>>
>> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
>> -		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
>> +		/* list_add/rbtree_add have an extra arg (prev/less),
>> +		 * so args-to-fixup are in diff regs.
>> +		 */
>> +		if (desc->func_id == special_kfunc_list[KF_bpf_list_add] ||
>> +		    is_bpf_rbtree_add_kfunc(desc->func_id)) {
>>  			struct_meta_reg = BPF_REG_4;
>>  			node_offset_reg = BPF_REG_5;
>>  		}
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

