Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5689E1A01BE
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776091075; cv=none; b=lwcpewL+EPySN1UBF7PweTXddOkLeg//VQvjsLVin5ft0pBSxhVEYdNZJDIlqTqooJzeuAGtBwNpEuKm0dw3kNlP1e+2qkRDrGsXr/Z+evuvH4yu747AKXt/ctUC65ZjuolyT5oaHKyU0AcLvFZ+JscVpD48SnkzQxDTcNSepMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776091075; c=relaxed/simple;
	bh=f4jK2nASKEiDtzh7WF6xZllwHVszbKRtFQbR51gWlPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xk4ynCg2j6f5+vfsh/OURnBbxE4uYh8ohi1P1PGlbbR5B+aRwjz0M5Qm2C/OJoQUKejgVriBdrJH+bu/V70sXTfPcram9IDEcBiSQdC30/F3gBA482oXByZdTgNkxdWCtrgmyTB3Vu2F0+6/FmhnyRjWrjB+ASmaU8B7gaD79/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gZFaA/5z; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZFaA/5z"
Message-ID: <86359a13-6b1e-4393-8ade-c660e47e7d8b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776091071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRTZTF/KGECPZncSYFLLQQ207SB2Bv+APN1X5XKxDxI=;
	b=gZFaA/5zIlveSAtPdhsqof5b+K6YaFv8yrzTDv6LYvxCE5/Hn5lUq58Ny7rCLv8FjVeuXL
	1M68Ai5WGRP5fHlL6z6+DVrhlWdsUpPvg5VmdXHEqcFizKt1lvQQzb1kani05a4D6h4uKy
	IS61B7Oi2remxzJX/43gFaEmqET2CPo=
Date: Mon, 13 Apr 2026 07:37:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 06/18] bpf: Use argument index instead of
 register index in kfunc verifier logs
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260412045857.256260-1-yonghong.song@linux.dev>
 <2783e4c4632337ff1a09e3ece084c8bce5f1672a0ec5bacf093e497ee66107a8@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2783e4c4632337ff1a09e3ece084c8bce5f1672a0ec5bacf093e497ee66107a8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/11/26 10:43 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 54296d818d35..01df990f841a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>
>> @@ -8592,12 +8609,12 @@ static int check_helper_mem_access(...)
>>    */
>>   static int check_mem_size_reg(struct bpf_verifier_env *env,
>>   			      struct bpf_reg_state *mem_reg,
>> -			      struct bpf_reg_state *size_reg, int mem_regno,
>> +			      struct bpf_reg_state *size_reg, int reg_or_arg,
>>   			      enum bpf_access_type access_type,
>>   			      bool zero_size_allowed,
>>   			      struct bpf_call_arg_meta *meta)
>>   {
>> -	int size_regno = mem_regno + 1;
>> +	int size_reg_or_arg = (reg_or_arg >= 0) ? reg_or_arg + 1 : reg_or_arg - 1;
> [ ... ]
>
>> -	err = check_helper_mem_access(env, mem_reg, mem_regno, size_reg->umax_value,
>> +	err = check_helper_mem_access(env, mem_reg, reg_or_arg, size_reg->umax_value,
>>   				      access_type, zero_size_allowed, meta);
>> -	if (!err)
>> -		err = mark_chain_precision(env, size_regno);
>> +	if (!err && size_reg_or_arg > 0)
>> +		err = mark_chain_precision(env, size_reg_or_arg);
>>   	return err;
>>   }
> When called from the kfunc path via check_kfunc_mem_size_reg(),
> reg_or_arg is always negative (-(mem_argno + 1)), which makes
> size_reg_or_arg also negative (reg_or_arg - 1). The condition
> "size_reg_or_arg > 0" is then always false, so mark_chain_precision()
> is never called for kfunc mem+size argument pairs.
>
> The old code unconditionally called mark_chain_precision(env,
> size_regno) with the actual register number. With the new encoding,
> precision tracking is skipped entirely on the kfunc path.
>
> For reference, check_kfunc_mem_size_reg() constructs the negative
> encoding:
>
>> @@ -8674,14 +8691,15 @@ static int check_mem_reg(...)
>>   static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env,
>>                                      struct bpf_reg_state *mem_reg,
>> 				    struct bpf_reg_state *size_reg,
>> -				    u32 mem_regno)
>> +				    u32 mem_argno)
>>   {
>> +	int reg_or_arg = -(int)(mem_argno + 1);
> [ ... ]
>
>> -	err = check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_READ, true, &meta);
>> -	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, mem_regno, BPF_WRITE, true, &meta);
>> +	err = check_mem_size_reg(env, mem_reg, size_reg, reg_or_arg, BPF_READ, true, &meta);
>> +	err = err ?: check_mem_size_reg(env, mem_reg, size_reg, reg_or_arg, BPF_WRITE, true, &meta);
> Should check_mem_size_reg() still call mark_chain_precision() with
> the actual register number for the kfunc path? It looks like the
> precision marking was unintentionally dropped rather than being
> intentionally skipped. The later commit 2d66a554f1b5 ("bpf: Support
> stack arguments for kfunc calls") adds "if (regno > 0)" guards for
> mark_chain_precision in check_kfunc_args() but does not address
> this case in check_mem_size_reg().

Ack, yes. mark_chain_precision() should be done for -2 to -5 as well.
Alexei suggested to use argno which should avoid such an issue.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24299298635

