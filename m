Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665C62264D9
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517774; cv=none; b=NEhdQQfV+BT+0V8gCNn/5Ykoxqk2oN5lRbTeSTYX0gqaPiXjV+2HtfItyicBN1OY9PKKRs+Ghzkk09pBcfQU/XD8as5yFKR7Np1xHNPGmCPdvz0rWz7DVhs4pTehnC3w0IYKZQqAn2PZ0N3DvefNAg+MtJMZkzHm2yCrq5uxmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517774; c=relaxed/simple;
	bh=L0JLQiCqljAdd92Xek+YGBz5PoT2e+iLMM/rhC7Hyjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiagLPDTlelEmCp6C4DVZM4aiPgZOxbsLMfn48R/t3Ap75QTUFSlj4/ANrXzDLhnnVYMMjXKcwbifSNdHZbJRU8PphGzY8RWdhC+SjeNzyn41PW/1X2S6XfAW+G6yPQpvnVXMNFfT0gCcizjk4Q4Xut1Tt+AcSuI1ugAvw0AVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Aq8f1TUr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Aq8f1TUr"
Message-ID: <34cf5402-a168-45ba-8d71-b33130da2bc7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778517770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qzPaq9MZYYthlRZAP+HPe3FSIV48OdTUgOB0FPiNTmU=;
	b=Aq8f1TUrN3TY1Lzrzv+URpViMXMnGlP/S+Y5LR5fl68NHOxqTeX5K5AsALHEMCMuqNbM8z
	C5lhej3LYveZz95jsOoIN640sldH0Mp1OvMjdNkgDPwo73WDGEfFWgy6xDixVeOq26S5U5
	a+496NqAKizF0jcmT4s3cvLW6rlVWJE=
Date: Mon, 11 May 2026 09:42:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 10/24] bpf: Reject stack arguments in
 non-JITed programs
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053353.1885466-1-yonghong.song@linux.dev>
 <7cbf61dc320a82fb5fa7e60ca9422b59c2d679468a17288ca0d35c0e8e5fc11a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7cbf61dc320a82fb5fa7e60ca9422b59c2d679468a17288ca0d35c0e8e5fc11a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Reject stack arguments in non-JITed programs
> This isn't a bug, but should this commit include a Fixes: tag? This
> appears to be fixing an issue introduced by commit 3330ee8db989
> ("bpf: Support stack arguments for bpf functions").

There is no need for fix tag. At this point, r11 based
insns are rejected by verifier. So nothing to fix.

>
>> The interpreter does not understand the bpf register r11
>> (BPF_REG_PARAMS) used for stack arguments. So reject interpreter
>> usage if stack arguments are used either in the main program or
>> any subprogram.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
>> index ae10b9ca018d..958d86f0beac 100644
>> --- a/kernel/bpf/core.c
>> +++ b/kernel/bpf/core.c
>> @@ -2599,7 +2599,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf_verifier_env *env, struct
>>   		goto finalize;
>>
>>   	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
>> -	    bpf_prog_has_kfunc_call(fp))
>> +	    bpf_prog_has_kfunc_call(fp) || (env && env->subprog_info[0].stack_arg_cnt))
>>   		jit_needed = true;
>>
>>   	if (!bpf_prog_select_interpreter(fp))
>> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
>> index ba86039789fd..19056016eed8 100644
>> --- a/kernel/bpf/fixups.c
>> +++ b/kernel/bpf/fixups.c
>> @@ -1407,6 +1407,12 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
>>   		verbose(env, "calling kernel functions are not allowed in non-JITed programs\n");
>>   		return -EINVAL;
>>   	}
>> +	for (i = 1; i < env->subprog_cnt; i++) {
>> +		if (bpf_in_stack_arg_cnt(&env->subprog_info[i])) {
>> +			verbose(env, "stack args are not supported in non-JITed programs\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>>   	if (env->subprog_cnt > 1 && env->prog->aux->tail_call_reachable) {
>>   		/* When JIT fails the progs with bpf2bpf calls and tail_calls
>>   		 * have to be rejected, since interpreter doesn't support them yet.
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25652623893

