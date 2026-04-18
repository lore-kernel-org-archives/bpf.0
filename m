Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703FF2C0F81
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776535495; cv=none; b=o7l9azV7aQDvugYc+YJsftac+L2xsNIGdkSv8iGyRAdon5uRCvLaXo/+pvPNUFLoEfh1+CtLboX5q3xAbbXuxXOMqKT4H5WhSuH5KxsgwF/O+YwkDET+7zOYGYfDGXIcGSrI5Asb+OsE2Vjss+gD1BQcWkSL+Q1XxwsfwOT/+l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776535495; c=relaxed/simple;
	bh=Np4LgwQ5hhU16/T1cpqbVti1yeyrR61KbbHp5g6Hp/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E49fP4AV+g9dbyHe5YqmGEgV8/2XJJd5uZ7T27E63lBfXslUfVqg8DWrir6SDXDBfMyNxecLfnY8Wzp8rvjmtX6PP8QDLMkjUJ7ycuSnPq3uDzu7bOp4BaJHLQthepeH9K4sgpMvDqfopuNWi2SLtNc8u9vi046Rp2FA9vR9RdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NCYKDlOy; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NCYKDlOy"
Message-ID: <0c5bbdea-a1be-4ab0-973b-197a3b15d959@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776535491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QS1uEd/ViBeu8C7L6l/XwPB7XS6L7OjGx65iPeyc/Ms=;
	b=NCYKDlOyTWksTBCshONk16v17nC1gcQDnnbZKf+DHcJQ060AGNdF/9Ngh7PWCqkHnEke9N
	5xOhT4CC6MNq7WBOMhjniStvrhxzUSiN7+BPQqEa2gFrby5U/U+5u6fEZTqc3Yl90DBmvD
	ub6zhWRRElzPP9u2ObJ2X6hQoghDthI=
Date: Sat, 18 Apr 2026 11:04:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 11/16] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260417034754.2630932-1-yonghong.song@linux.dev>
 <9ed0516c340a9717f644ca8d69a474f94774ddbdf4cb39b0b932029612871d35@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9ed0516c340a9717f644ca8d69a474f94774ddbdf4cb39b0b932029612871d35@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/17/26 6:04 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -11653,6 +11659,19 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
>> +static struct bpf_reg_state *get_kfunc_arg_reg(struct bpf_verifier_env *env, int argno)
>> +{
>> +	struct bpf_func_state *caller;
>> +	int spi;
>> +
>> +	if (argno < MAX_BPF_FUNC_REG_ARGS)
>> +		return &cur_regs(env)[argno + 1];
>> +
>> +	caller = cur_func(env);
>> +	spi = out_arg_spi(caller, argno - MAX_BPF_FUNC_REG_ARGS);
>> +	return &caller->stack_arg_regs[spi];
>> +}
> Can the verifier crash here?  Looking at get_kfunc_arg_reg, when
> argno >= MAX_BPF_FUNC_REG_ARGS, the function returns
> &caller->stack_arg_regs[spi] without checking whether stack_arg_regs
> is NULL.
>
> The stack_arg_regs array is only allocated by grow_stack_arg_slots,
> which is called from check_stack_arg_write when the program writes
> outgoing stack args via r11.  If a malformed BPF program invokes a
> kfunc without emitting any stack stores beforehand, stack_arg_regs
> will remain NULL.
>
> Consider get_kfunc_ptr_arg_type calling get_kfunc_arg_reg to peek at
> argument i+1 when checking for buffer+__sz pairs:
>
> kernel/bpf/verifier.c:get_kfunc_ptr_arg_type() {
>      if (argno + 1 < nargs &&
>          (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1],
>                                  get_kfunc_arg_reg(env, argno + 1)) ||
>           ...
> }
>
> When argno=4 (pointer in r5) and argno+1=5 (size in first stack slot),
> get_kfunc_arg_reg(env, 5) enters the stack-arg branch and dereferences
> caller->stack_arg_regs even though it may be NULL.  If the arg type is
> a scalar (which __sz/__szk suffixes imply), is_kfunc_arg_mem_size will
> try to read reg->type, causing a NULL pointer dereference.
>
> The is_stack_arg_slot_initialized gate you added in check_kfunc_args
> only fires when the loop reaches i=5; by then the peek at i=4 has
> already dereferenced the NULL pointer.
>
> Should get_kfunc_arg_reg verify that stack_arg_regs is non-NULL and
> spi < stack_arg_depth/BPF_REG_SIZE before returning the pointer?
> Alternatively, should check_kfunc_call add an out_stack_arg_mask
> pre-check mirroring the bpf-to-bpf gate that prevents
> check_func_arg_reg_off from reading uninitialized stack slots?

Good points. Indeed we should check validity of spi in
   spi = out_arg_spi(caller, argno - MAX_BPF_FUNC_REG_ARGS)

Will fix.

>
>> @@ -11660,8 +11679,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>   		       const char *ref_tname, const struct btf_param *args,
>>   		       int argno, int nargs, struct bpf_reg_state *reg)
>>   {
>> -	u32 regno = argno + 1;
>> -	struct bpf_reg_state *regs = cur_regs(env);
>>   	bool arg_mem_size = false;
>>
>>   	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
>> @@ -11670,8 +11687,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
>>   		return KF_ARG_PTR_TO_CTX;
>>
>>   	if (argno + 1 < nargs &&
>> -	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1]) ||
>> -	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], &regs[regno + 1])))
>> +	    (is_kfunc_arg_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1)) ||
>> +	     is_kfunc_arg_const_mem_size(meta->btf, &args[argno + 1], get_kfunc_arg_reg(env, argno + 1))))
>>   		arg_mem_size = true;
> [ ... ]
>
>> @@ -20145,6 +20209,16 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	if (!bpf_jit_supports_far_kfunc_call())
>>   		insn->imm = BPF_CALL_IMM(desc->addr);
>>
>> +	/*
>> +	 * After resolving the kfunc address, insn->off is no longer needed
>> +	 * for BTF fd index. Repurpose it to store the number of stack args
>> +	 * so the JIT can marshal them.
>> +	 */
>> +	if (desc->func_model.nr_args > MAX_BPF_FUNC_REG_ARGS)
>> +		insn->off = desc->func_model.nr_args - MAX_BPF_FUNC_REG_ARGS;
>> +	else
>> +		insn->off = 0;
>> +
> This concern was raised by the bpf-ci bot and sashiko-bot in the v5
> review thread but does not appear to have been addressed.
>
> Overwriting insn->off destroys the BTF file descriptor index required
> by bpf_jit_find_kfunc_model() for module kfunc lookups.  Looking at
> the bsearch in kernel/bpf/fixups.c, it uses (insn->imm, insn->off) as
> the key:
>
> kernel/bpf/fixups.c:bpf_jit_find_kfunc_model() {
>      key.addr = insn->imm;
>      key.offset = insn->off;
>      entry = bsearch(&key, tab, tab_count, sizeof(*tab), kfunc_addr_cmp);
> }
>
> For module kfuncs, insn->off stores a non-zero btf_fd_idx set during
> find_kfunc_desc.  After this patch overwrites it with the stack arg
> count (or 0), the bsearch will fail to find descriptors that were
> stored with offset=btf_fd_idx.
>
> This breaks module kfunc calls on architectures using JIT far calls
> (s390x, loongarch, powerpc) for any module kfunc with 5 or fewer args
> (insn->off zeroed) or with more than 5 args (insn->off now contains
> the stack arg count instead of btf_fd_idx, still mismatching
> desc->offset).  Vmlinux kfuncs with more than 5 args also get a
> nonzero insn->off that no longer matches desc->offset=0.
>
> Can the stack arg count be communicated to the JIT without clobbering
> the btf_fd_idx that bsearch still keys on?
>
> The original concern was raised here:
> https://lore.kernel.org/bpf/e5a6e801c10994cc2e03b0cd57e76152eb234493a6b7395a9859feade4a6575b@mail.kernel.org/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24592562564

