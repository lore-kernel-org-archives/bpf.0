Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257752D8364
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098657; cv=none; b=irNnVBZP2uL4mRVtU/c4NFK8iQZTbNZcWDwPQWIJBsm/5YPcZzWPH12t1db+Gzk1xml3a4tohTZbC9g+l6QMxFRrAAHd66J/Dqg3pc6YneSSw6t62SEgEw5weUq31ubk8Pwm4DIRDUMXuYuJ/JUkkH3N98TmlFCHZp37sW3zn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098657; c=relaxed/simple;
	bh=j9rhmLE+1OXqin6XnEyQUXUs2ZqVecjYGJfyt1mpgfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4RCJKSKLiLCFqIbfGvZH/55luBSPj7RXyfS7fnfbU5rcGxTjkEBZ7mRQLvjnJ/7n3NnJZYmOj5ZzAC8jV5JPQpUG5GNmsBVjg8cZs3a177xW6nT2s61NSejHYlStox49o31fFHq36GKstL4kfntYRpjSXSuqn5jsK444QhD4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dmJR/dn4; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dmJR/dn4"
Message-ID: <43e60f5c-e0af-40bd-9b3a-8b73c5e9f42f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776098653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6lnnU+ypVZ6y34vHrx4VF0DwsHC1djJrL83BBiNg2Y=;
	b=dmJR/dn441JmMhi0Rrrk/H2RhgJDNBczk0EVQM/nVEQ/cBmIPdScrJgGpvK+ND4Zb59wgA
	RL6wBN+9ho6M01JY7w7Ufa1MCwg41Mw84O/q8+RCeK8Sn2d0cxm42jCo9olZq6s78OwiMb
	HfZ+LxQ2f3tnhc9dF4Gc5UADvnGI97U=
Date: Mon, 13 Apr 2026 09:43:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 13/18] bpf: Support stack arguments for kfunc
 calls
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412050015.267072-1-yonghong.song@linux.dev>
 <cb0c281e177d56f45d5dee727f92c62031aab6553deeaeb544e5f44f20968bcf@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cb0c281e177d56f45d5dee727f92c62031aab6553deeaeb544e5f44f20968bcf@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:43 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 45987041bb2a..206ffbd9596d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -13848,9 +13858,9 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>
>>   	args = (const struct btf_param *)(meta->func_proto + 1);
>>   	nargs = btf_type_vlen(meta->func_proto);
>> -	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>> +	if (nargs > MAX_BPF_FUNC_ARGS) {
>>   		verbose(env, "Function %s has %d > %d args\n", func_name, nargs,
>> -			MAX_BPF_FUNC_REG_ARGS);
>> +			MAX_BPF_FUNC_ARGS);
>>   		return -EINVAL;
>>   	}
> [ ... ]
>
>> @@ -15152,6 +15198,16 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   			mark_btf_func_reg_size(env, regno, t->size);
>>   	}
> With nargs now allowed up to MAX_BPF_FUNC_ARGS (12), the existing
> mark_btf_func_reg_size loop in check_kfunc_call() iterates beyond
> register arguments:
>
>      for (i = 0; i < nargs; i++) {
>          u32 regno = i + 1;
>          ...
>          mark_btf_func_reg_size(env, regno, t->size);
>      }
>
> This calls __mark_btf_func_reg_size() with &regs[regno] where
> regs is bpf_func_state.regs[MAX_BPF_REG] and MAX_BPF_REG is 11.
>
> For nargs 6-10, the loop incorrectly calls mark_insn_zext() on
> callee-saved registers R6-R9 or the frame pointer R10. These
> registers are not cleared by the caller-saved register loop above,
> so if the BPF program wrote a 32-bit value to R6 before the kfunc
> call, mark_insn_zext() would set zext_dst on that unrelated
> instruction and clear the register's subreg_def.
>
> For nargs >= 11 (MAX_BPF_FUNC_ARGS is 12), regs[11] is an
> out-of-bounds access that overlaps bpf_func_state.callsite.

Thanks for pointing out. The for loop stays as is. What need to
do is change 'regno' to 'reg' which is a pointer to bpf_reg_state.
Will fix.

>
> Should this loop be bounded to register args only, similar to what
> v1 of this patch had?
>
>      for (i = 0; i < nargs && i < MAX_BPF_FUNC_REG_ARGS; i++) {
>
>> +	/* Track outgoing stack arg depth for kfuncs with >5 args */
>> +	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>> +		struct bpf_func_state *caller = cur_func(env);
>> +		struct bpf_subprog_info *caller_info = &env->subprog_info[caller->subprogno];
>> +		u16 kfunc_stack_arg_depth = (nargs - MAX_BPF_FUNC_REG_ARGS) * BPF_REG_SIZE;
>> +
>> +		if (kfunc_stack_arg_depth > caller_info->outgoing_stack_arg_depth)
>> +			caller_info->outgoing_stack_arg_depth = kfunc_stack_arg_depth;
>> +	}
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

