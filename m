Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA23310620
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869849; cv=none; b=eCUTte0bkLKulxRvZHgwHNatRRL46kmshLex7h1bV5ctkYkt5tds84wqqLf37094qTv8+SCLI/5eNwVtBgGP6nDqCBoAUY7y1V62DO4+TfWu6+YgjBi9YSidTh5LqzEPZuNwLeUhKbCG6qaUbaVgGZyCjDVEEv4BWSEBD1QZip0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869849; c=relaxed/simple;
	bh=VFtKqFd6Ub1V3kCKBpEOpiLP69I9pbP0iva0+QbJyC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ee2OaqMoG1vCnlLrCGDIe8JDQG+x9BF8EWFCqKz08NjwyRaqT0OpN5EbSjPcbq6fwQKaudTzVykS1yeNhERLFpIjpigzHhehfwtv352sex7wx2Pat4G/Gr6aNRTjKuAHoUokNUVEOfKMJHa5HrDvAzmc7egYhO/OhSOfFYV4Wss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ANB5xVNY; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ANB5xVNY"
Message-ID: <715fcb76-c1ba-44e2-9b6f-e3133f2a5610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776869845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0xjKL43Hp2skj73MTE9oMAaW5ZJR8jpa26CJqVQKFw=;
	b=ANB5xVNYe+IL+HCfn8hjGQQG2v6qxHNiwAh6yvx27Agw7iiubrTSnlilpY3kcXhPyp9QA6
	gVhXyPI2bfa9ywGERjk6Mh1BkGX9k98yGuJKkOLNzbNZ0zzqXKrnPjN0DZwa3mBaPNEeXw
	zGj8xXdrpugZE4xZ8Uus6WXSUPvVeg8=
Date: Wed, 22 Apr 2026 07:57:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 7/9] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260422054224.3127905-1-yonghong.song@linux.dev>
 <25c10a6b1a6f9703f2b2c943ab42245cb9de30d2004eb301d85d9de0ca6ca7b3@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <25c10a6b1a6f9703f2b2c943ab42245cb9de30d2004eb301d85d9de0ca6ca7b3@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 11:25 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index b148f816f25b..d5b4303315dd 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>   	 * e.g., in reg_type_str() to generate reg_type string
>>   	 */
>>   	char tmp_str_buf[TMP_STR_BUF_LEN];
>> +	char tmp_arg_name[32];
>>   	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>   	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>   	struct bpf_scc_callchain callchain_buf;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c777a294302a..e7f5f0bb499b 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -261,6 +261,30 @@ struct bpf_kfunc_meta {
>>
>>   struct btf *btf_vmlinux;
>>
>> +typedef struct argno {
>> +	int argno;
>> +} argno_t;
>> +
>> +static argno_t argno_from_reg(u32 regno)
>> +{
>> +	return (argno_t){ .argno = regno };
>> +}
>> +
>> +static argno_t argno_from_arg(u32 arg)
>> +{
>> +	return (argno_t){ .argno = -arg };
>> +}
>> +
>> +static int reg_from_argno(argno_t a)
>> +{
>> +	return a.argno >= 0 ? a.argno : -1;
>> +}
>> +
>> +static int arg_from_argno(argno_t a)
>> +{
>> +	return a.argno < 0 ? -a.argno : -1;
>> +}
> [ ... ]
>
>> @@ -7026,8 +7068,8 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, struct bpf_reg_
>>    */
>>   static int check_mem_size_reg(struct bpf_verifier_env *env,
>>   			      struct bpf_reg_state *mem_reg,
>> -			      struct bpf_reg_state *size_reg, u32 mem_regno,
>> -			      u32 size_regno, enum bpf_access_type access_type,
>> +			      struct bpf_reg_state *size_reg, argno_t mem_argno,
>> +			      argno_t size_argno, enum bpf_access_type access_type,
>>   			      bool zero_size_allowed,
>>   			      struct bpf_call_arg_meta *meta)
>>   {
> [ ... ]
>
>> @@ -7052,31 +7094,31 @@ static int check_mem_size_reg(struct bpf_verifier_env *env,
>>   		meta = NULL;
>>
>>   	if (size_reg->smin_value < 0) {
>> -		verbose(env, "R%d min value is negative, either use unsigned or 'var &= const'\n",
>> -			size_regno);
>> +		verbose(env, "%s min value is negative, either use unsigned or 'var &= const'\n",
>> +			reg_arg_name(env, size_argno));
>>   		return -EACCES;
>>   	}
>>
>>   	if (size_reg->umin_value == 0 && !zero_size_allowed) {
>> -		verbose(env, "R%d invalid zero-sized read: u64=[%lld,%lld]\n",
>> -			size_regno, size_reg->umin_value, size_reg->umax_value);
>> +		verbose(env, "%s invalid zero-sized read: u64=[%lld,%lld]\n",
>> +			reg_arg_name(env, size_argno), size_reg->umin_value, size_reg->umax_value);
>>   		return -EACCES;
>>   	}
>>
>>   	if (size_reg->umax_value >= BPF_MAX_VAR_SIZ) {
>> -		verbose(env, "R%d unbounded memory access, use 'var &= const' or 'if (var < const)'\n",
>> -			size_regno);
>> +		verbose(env, "%s unbounded memory access, use 'var &= const' or 'if (var < const)'\n",
>> +			reg_arg_name(env, size_argno));
>>   		return -EACCES;
>>   	}
>> -	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
>> +	err = check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax_value,
>>   				      access_type, zero_size_allowed, meta);
>>   	if (!err)
>> -		err = mark_chain_precision(env, size_regno);
>> +		err = mark_chain_precision(env, reg_from_argno(size_argno));
>>   	return err;
>>   }
>                                       ^^^^^^^
>
> Does mark_chain_precision(env, reg_from_argno(size_argno)) properly handle
> kfunc size arguments?
>
> Before this patch, check_mem_size_reg() was called with size_regno being a
> u32 register number. For kfuncs with KF_ARG_PTR_TO_MEM_SIZE, the pre-patch
> call at check_kfunc_args was check_kfunc_mem_size_reg(env, reg, size_reg,
> regno, regno+1), passing real register numbers like R2..R5.
>
> After this patch, check_kfunc_args constructs size_argno via
> argno_from_arg(i+2) for the size parameter of a KF_ARG_PTR_TO_MEM_SIZE
> pair. The argno_from_arg() helper creates a negative encoding (-.argno).
> When reg_from_argno(size_argno) is called, it checks a.argno >= 0 and
> returns -1 for negative values.
>
> mark_chain_precision(env, -1) then reaches bpf_mark_chain_precision in
> backtrack.c, where the "if (regno >= 0)" guard causes it to skip marking
> the register, and the subsequent "if (bt_empty(bt)) return 0;" silently
> returns success without doing any precision tracking.
>
> For helpers, this works correctly because check_func_arg calls
> check_mem_size_reg with argno_from_reg(regno), which produces a non-negative
> encoding that reg_from_argno() correctly extracts back to the register
> number.
>
> Can you verify whether the loss of precision tracking for kfunc size
> registers might cause programs that previously verified to hit the
> BPF_COMPLEXITY_LIMIT_INSNS threshold? Kfuncs with __sz/__szk size
> arguments are widely used in-tree.

This is indeed a problem.
Function check_mem_size_reg() is the one which does
    mark_chain_precision(env, reg_from_argno(size_argno))


There are two callers for check_mem_size_reg():
    - check_kfunc_mem_size_reg() <- check_kfunc_args
      so arg_from_argno() should be used here to get the value
    - check_func_arg() <- check_helper_call()
      in this case, since helper_call is fixed at most 5 registers,
      so argno_from_reg() is used in check_func_arg(), so later
      on it should use reg_from_argno() should be used to get value.

There are two options to fix:
  1. do proper check like
     int reg_val = reg_from_argno(size_regno);
     if (reg_val >= 0)
       mark_chain_precision(env, reg_val);
     else
       mark_chain_precision(env, arg_from_argno(size_regno));

2. for arguments in check_helper_call(), we also use
    arg_from_argno() instead of reg_from_argno().
    This way, we can just do
       mark_chain_precision(env, arg_from_argno(size_regno));

Not sure which is preferred or there are some other better alternatives.

>
>>   static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>> -			 u32 regno, u32 mem_size)
>> +			 argno_t argno, u32 mem_size)
>>   {
> [ ... ]
>
>> @@ -7157,7 +7199,7 @@ enum {
>>    * env->cur_state->active_locks remembers which map value element or allocated
>>    * object got locked and clears it after bpf_spin_unlock.
>>    */
>> -static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, int regno, int flags)
>> +static int process_spin_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg, argno_t argno, int flags)
>>   {
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24762480405

