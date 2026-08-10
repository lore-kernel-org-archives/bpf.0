Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B150B3E5A2F
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379802; cv=none; b=YnaULqfzaxaEtQXvC2n8CGgRmZA5HsF8gSgOUR5x+SMUUVlQ4YFOW6UsnM7eAYvHujqwGOSGOlT8XIa438UXWWW5kn8wzyDQnfTEV/+n3tf0gKrExgIY4kmGlBu7J2ipZAIFJuwIT5tdOQDejkLzzn/mA9IBr53WC4ciW6u5bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379802; c=relaxed/simple;
	bh=f0hg9Bhx+8d5BYdtUQ4HO2HH5hQAbnaFTrdruOQV1rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luSMOQ6ZglDZiJ25/E6+PXxPVJXWSYb6uOuhEwMt3GtJtHZnOuZAKmuOFozGLnwR827JBzuKzQlePB8aDMsc7oZlDtTBXkJBe1QqO3Pk4W9FDtpO8nNjQ2WVAE0X6ifxkKuMQ6iaimKhdN74/5GCOU7vZro5Mwr9hYDWiC7ztWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZHpIkLkX; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZHpIkLkX"
Message-ID: <0e6fd62e-0f69-4ae8-9335-85a139870d81@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786379787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bZOTfz5mWPoXkp9RI9KOFVy6F1zIbcdWH3Kj73wQTU=;
	b=ZHpIkLkX5tO65ScodTOkje33kozXjHjnOUViSj7avTXihcVm5PjFEJYWKFT8dZRvOWt4dZ
	k4TpGqSMfELR6WzjP6AKz3+DWKbLOMBGef9QCdZKoJ4yek2agr8qJOhr/8tGwwpcFv2qAk
	m6HloWEfdStN+RhMXu2j0MlDKeSnSz0=
Date: Mon, 10 Aug 2026 09:36:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 06/13] bpf: Reject callbacks returning more
 than 8 bytes
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
 <20260808190353.1899379-1-yonghong.song@linux.dev>
 <20260808194539.1418B1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260808194539.1418B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/8/26 12:45 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] check_global_subprog_return_code() fails to validate BPF_REG_2 for global subprograms returning > 8 bytes, allowing kernel pointer leaks.
> - [High] BPF-to-BPF calls returning 16-byte values are broken because prepare_func_exit() only copies R0 to the caller, leaving R2 uninitialized.
> - [High] BPF programs cannot use 16-byte returns from kfuncs because check_kfunc_call() fails to initialize BPF_REG_2.
> --
>
> --- Patch [6]: [PATCH bpf-next v3 06/13] bpf: Reject callbacks returning more than 8 bytes ---
> commit d03b8255604638dcb72d6dda989b79be64af9fa4
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Reject callbacks returning more than 8 bytes
>
> This patch prevents BPF callbacks passed to helpers, kfuncs, or as exception
> callbacks from returning more than 8 bytes. Since the callback prototypes
> yield a single u64 in R0, returning a 16-byte value would cause the upper
> half to be silently dropped. The verifier now rejects such callbacks at
> load time in check_ld_imm() and do_check_common().
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16306,6 +16306,11 @@ static int check_ld_imm(struct bpf_verifier_env *env, struct bpf_insn *insn)
>>   			verbose(env, "callback function not static\n");
>>   			return -EINVAL;
>>   		}
>> +		if (bpf_ret_reg_pair(env, subprogno)) {
>> +			verbose(env,
>> +				"callback function with >8-byte return value is not supported\n");
>> +			return -EINVAL;
>> +		}
>>   
>>   		dst_reg->type = PTR_TO_FUNC;
>>   		dst_reg->subprogno = subprogno;
> [ ... ]
>
>> @@ -18528,6 +18533,12 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
>>   				ret = -EINVAL;
>>   				goto out;
>>   			}
>> +			if (bpf_ret_reg_pair(env, subprog)) {
>> +				verbose(env,
>> +					"exception cb cannot return value larger than 8 bytes\n");
>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>>   
>>   			/* Also ensure the callback only has a single scalar argument. */
>>   			if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_ANYTHING) {
>
> While reviewing the support for 16-byte return values, I noticed a few other
> places in kernel/bpf/verifier.c that might need updates:
>
> In kernel/bpf/verifier.c:check_global_subprog_return_code():
>
>> 	return check_global_ret_scalar_reg(env, BPF_REG_0);
> [Severity: High]
> Does check_global_subprog_return_code() fail to validate BPF_REG_2 for global
> subprograms returning more than 8 bytes?
>
> A global subprogram returning a 16-byte value (e.g. __int128) could place a
> kernel pointer in BPF_REG_2 and exit without the verifier rejecting it,
> bypassing the verifier's pointer leak prevention.
>
> Although currently unexploitable because callers have R2 marked uninitialized
> due to another issue, if the caller issue is fixed, or if the kernel reads
> the return value directly (e.g. via BPF trampoline), can this missing
> validation become an exploitable KASLR bypass or pointer leak?
>
>
> In kernel/bpf/verifier.c:prepare_func_exit():
>
>> 	/* return to the caller whatever r0 had in the callee */
>> 	caller->regs[BPF_REG_0] = *r0;
> [Severity: High]
> Are BPF-to-BPF calls returning 16-byte values broken here?
>
> This only copies R0 to the caller, leaving R2 uninitialized in the caller's
> frame. BPF programs calling static subprograms that return 16-byte values
> cannot use the upper 64 bits of the return value, as the verifier will reject
> the program with an uninitialized register error.
>
> Additionally, precision backtracking logic added for R2 on static subprog exit
> appears to be rendered unreachable dead code because R2 can never be marked
> precise by the caller.
>
>
> In kernel/bpf/verifier.c:check_kfunc_call():
>
>> 	if (btf_type_is_scalar(t)) {
>> 		mark_reg_unknown(env, regs, BPF_REG_0);
> [Severity: High]
> Can BPF programs actually use 16-byte returns from kfuncs?
>
> This handles scalar return types from kfuncs but only initializes R0, leaving
> R2 uninitialized.
>
> Since caller-saved registers (including R2) are cleared before the call, any
> BPF program attempting to use this new feature will be rejected by the
> verifier when attempting to read R2. Should this also mark R2 as initialized
> for 16-byte scalar returns?

This patch is a preparation patch, in the next commit, proper verifier support
(with returning R2) will be implemented.

