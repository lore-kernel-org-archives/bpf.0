Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143E3CE48F
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587592; cv=none; b=cMoFkwJiaIDTKIIue0UP11BBYq+Oz2wxi52xSkjVUEjndCL/LZZlaSQuJdvvKQuyZUZ+CfkF+Tdb+1StJ/7REYE155WsXVWLljbY9lnPFrNMqXKCATAdXXnmHVZi1QBwMJocRF+QXPchiFJusi7gQQDAzaP5HKpyBJ76bbS2udM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587592; c=relaxed/simple;
	bh=p/tHk3Ki7ukILe77/bmVvcIMX8dUCZhWCuNG0mGDJjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IP6ljZPd90z+nclkduJfWonozDs4jwWz3RcWJkHIFBXirL3JaoPwQRsA8eRhqyIGd8VssDGCYCVQViE6rVDpa8llvWGJBO2d70tLRkVX/nGO2YR3nmwjZzBjRKZ1VB32TnjjVJuoGLFC9XZ/kT5LvU/0E3eIi1Xjo1PGPXAOlgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I+M8YmPX; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I+M8YmPX"
Message-ID: <1e3e5461-76cb-4e69-81f8-fb2220bf797c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778587577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ap2nfY1WZm6T5NE1j7FvcA+Rbuv0o1NHLF2th8iyNUI=;
	b=I+M8YmPXQjQDW/l4DymajI9lHONPQvH/p43t4tlzHtFeU9DBE5bi0PJBgeo3tVXpo2Xvwz
	3PvQKsUX01TNh9+d6MawmNdT2f+P83j3QgbFOsKIOYLE3UH3kJ3SmlKEc6ZLXeWhtIK7rv
	2F6A2S2YBrcbnM8zP8J+n8o0Nlm0z58=
Date: Tue, 12 May 2026 20:05:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND bpf-next v10 5/8] bpf: Add bpf_list_add to insert
 node after a given list node
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
References: <20260512055919.95716-6-kaitao.cheng@linux.dev>
 <f573f7e0a5140fe6254d2ddfd3f69add455fa25c67c020c0312e2c2ceeca7c69@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <f573f7e0a5140fe6254d2ddfd3f69add455fa25c67c020c0312e2c2ceeca7c69@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/5/12 14:41, bot+bpf-ci@kernel.org 写道:
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
> 
> The commit message states that 'prev' must already be in the list. How can a
> BPF program obtain such a reference and pass it to this kfunc?
> 
> A node already in the list is tracked by the verifier as a non-owning
> reference (PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF with ref_obj_id == 0).
> The typical way to obtain this is via bpf_list_front() or bpf_list_back(),
> which return non-owning references.
> 
> However, check_kfunc_args() in kernel/bpf/verifier.c handles
> KF_ARG_PTR_TO_LIST_NODE by requiring owning references and rejects non-owning
> references.
> 
> Without a similar distinction for KF_ARG_PTR_TO_LIST_NODE (as exists for
> KF_ARG_PTR_TO_RB_NODE), is there any valid BPF register state that satisfies
> both the verifier check and the runtime semantics stated in the commit
> message?
> 
> The BPF CI bot reported this issue in v10. The author responded that this was
> fixed in [PATCH bpf-next v10 7/8], which introduces the __nonown_allowed
> annotation and corresponding verifier logic. However, patch 7/8 is not
> present in this commit (feed006fb969), so the parameter lacks the
> __nonown_allowed suffix and the verifier lacks the is_kfunc_arg_nonown_allowed()
> check.

If this is an issue that must be fixed, I will move [PATCH bpf-next v10 7/8]
earlier in the next version.

> Reference: https://lore.kernel.org/bpf/cb7368c6062232b6ad5f9ab1c6a97bc8530566a8b3db5c4deefdd5ea63d31538@mail.kernel.org/
> 
>> +{
>> +	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev;
>> +	struct list_head *prev_ptr = &p->list_head;
>> +
>> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
>> +}
>> +
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
>> @@ -19235,8 +19238,11 @@ struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
>>  		int struct_meta_reg = BPF_REG_3;
>>  		int node_offset_reg = BPF_REG_4;
>>
>> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
>> -		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
>> +		/* list_add/rbtree_add have an extra arg (prev/less),
>> +		 * so args-to-fixup are in diff regs.
>> +		 */
> 
> This isn't a bug, but the multi-line comment format doesn't follow the BPF
> subsystem style. The preferred form in kernel/bpf/ has the opening /* on its
> own line:
> 
>     /*
>      * list_add/rbtree_add have an extra arg (prev/less),
>      * so args-to-fixup are in diff regs.
>      */
> 
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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25716874656

-- 
Thanks
Kaitao Cheng

