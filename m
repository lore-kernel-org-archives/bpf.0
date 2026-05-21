Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF92D0615
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779349046; cv=none; b=O+SA2CTpNHSNkc6C04zDjDLvvv1KUhOYfEWNxZ7zrDlJNrprQr7FXru8TmFsf7BBM/56uZDpTgU8fIgvlZJL4cag+U5MtKWcBv5DaHrt15UEKSdG4fKz98ZXDq1KfhJ5LrmA8B4CoxJWQ9iamx5VbHn4jefvquHJhVUS7qzBb6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779349046; c=relaxed/simple;
	bh=R8pP1d8ekCrIzeVrljMRYUBnWOGmUkz6ksI2SX7JeBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tskgEEOtyD+HYgh9kRYwT2Fnw9pE5EM1XWLGjz7gLuXkVA80DrCFnjIPoORysC7dKll3u5t0g321v4hrezfjQPtQOhkn7U/AAJcArpCtVxkYzScdPuaACXLNcamQYprD0V1lyGm1IZZJLjPKQbHHzlsPtY6cV+Dfd8R3sRHVOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iRpekRVh; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iRpekRVh"
Message-ID: <db0be5c8-13cb-4007-be06-bee3e1cbafbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779349022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M14ZvRYGbbDChleEwMkrlZeua+SBBNOi/r7kAJG70c4=;
	b=iRpekRVh0ABAaNsYeytGvVAJzme6ykXDAKtDQU/Su+oZ4UrsAVvvjxLYYC0VmKW96eDF6p
	qFnQ21/Jar59VsHhrpKgp8J//prkhveEhiyZazjVin9D9FRH2LJ1nByaQAOHnPKb4J2Wmv
	EiK2cm3aPnDbHwp3/xcdCxlvt0n+GRY=
Date: Thu, 21 May 2026 15:35:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 6/8] bpf: Add bpf_list_add to insert node
 after a given list node
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
References: <20260521032306.97118-7-kaitao.cheng@linux.dev>
 <61871735d9151729b3092d42209dad08b1e38fa930bc1c9e452645240efbc40e@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kaitao Cheng <kaitao.cheng@linux.dev>
In-Reply-To: <61871735d9151729b3092d42209dad08b1e38fa930bc1c9e452645240efbc40e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/5/21 12:08, bot+bpf-ci@kernel.org 写道:
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 1c69476c8a09..89579165ef4d 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2577,6 +2577,16 @@ __bpf_kfunc int bpf_list_push_back_impl(struct bpf_list_head *head,
>>  	return bpf_list_push_back(head, node, meta__ign, off);
>>  }
>>
>> +__bpf_kfunc int bpf_list_add(struct bpf_list_head *head, struct bpf_list_node *new,
>> +			     struct bpf_list_node *prev__nonown_allowed,
>> +			     struct btf_struct_meta *meta, u64 off)
>> +{
>> +	struct bpf_list_node_kern *n = (void *)new, *p = (void *)prev__nonown_allowed;
>> +	struct list_head *prev_ptr = &p->list_head;
>> +
>> +	return __bpf_list_add(n, head, &prev_ptr, meta ? meta->record : NULL, off);
>> +}
> 
> If __bpf_list_add() fails at runtime (e.g., because prev is not in the
> list indicated by head), it drops the 'new' node via __bpf_obj_drop_impl
> in the fail path.
> 
> However, the verifier unconditionally converts 'new' into a non-owning
> reference during check_kfunc_call(). If __bpf_list_add() fails, the BPF
> program retains this non-owning reference to a freed node.
> 
> Could this allow the program to trigger a use-after-free within the lock
> critical section?
> 
> (sashiko-bot@kernel.org, v10 RESEND)
> https://lore.kernel.org/bpf/20260513204420.2BB22C19425@smtp.kernel.org/

This should be an acceptable case within the current design framework.

>>  static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head,
>>  					    struct list_head *n)
> 
> [ ... ]
> 
>> @@ -4756,6 +4766,7 @@ BTF_ID_FLAGS(func, bpf_list_push_front, KF_IMPLICIT_ARGS)
>>  BTF_ID_FLAGS(func, bpf_list_push_front_impl)
>>  BTF_ID_FLAGS(func, bpf_list_push_back, KF_IMPLICIT_ARGS)
>>  BTF_ID_FLAGS(func, bpf_list_push_back_impl)
>> +BTF_ID_FLAGS(func, bpf_list_add, KF_IMPLICIT_ARGS)
> 
> Since bpf_list_add is marked with KF_IMPLICIT_ARGS, won't the verifier
> look for a bpf_list_add_impl counterpart during program load?
> 
> Without defining and registering a bpf_list_add_impl function,
> find_kfunc_impl_proto() will fail to find the required _impl suffix in
> the vmlinux BTF.
> 
> Will this cause the verifier to unconditionally reject the kfunc?
> 
> (sashiko-bot@kernel.org, v10 RESEND)
> https://lore.kernel.org/bpf/20260513204420.2BB22C19425@smtp.kernel.org/

The target prototype with the _impl suffix has already been deprecated.

>>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_del, KF_ACQUIRE | KF_RET_NULL)
> 
> [ ... ]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 35eebb5e7769..662ad7312697 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
>> @@ -19524,8 +19527,11 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  		int struct_meta_reg = BPF_REG_3;
>>  		int node_offset_reg = BPF_REG_4;
>>
>> -		/* rbtree_add has extra 'less' arg, so args-to-fixup are in diff regs */
>> -		if (is_bpf_rbtree_add_kfunc(desc->func_id)) {
>> +		/* list_add/rbtree_add have an extra arg (prev/less),
>> +		 * so args-to-fixup are in diff regs.
>> +		 */
> 
> This isn't a bug, but the multi-line comment format doesn't follow the
> BPF subsystem style. The preferred form in kernel/bpf/ has the opening
> /* on its own line.
> 
> Additionally, consider adding an is_bpf_list_add_kfunc() helper instead
> of direct comparison with special_kfunc_list[KF_bpf_list_add].
> 
> (bot+bpf-ci@kernel.org and Eduard Zingerman, v10 RESEND)
> https://lore.kernel.org/bpf/f573f7e0a5140fe6254d2ddfd3f69add455fa25c67c020c0312e2c2ceeca7c69@mail.kernel.org/

I provided a more detailed explanation in the link below.
https://lore.kernel.org/all/9e300669-8793-41a2-84a1-98fb8195e263@linux.dev/

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
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015

-- 
Thanks
Kaitao Cheng

