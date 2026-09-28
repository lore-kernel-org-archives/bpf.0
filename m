Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2A43F0AF
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790553723; cv=none; b=HF0SMX2cdfjn+vKnjcBIjAfXXDEyoyjMoPl2i7IpmeggRIzD25id9v1+Q6w2VXXUlKfBxrLa4OjNh7K7ZCHBcYf6ySFVayqE7+E6k1qP58p1mGIsrhb7gP+RJ+GzNZnI6Sv6ersk/Tym++ptjmX+/QaVUaKPAUwteBtFsE+lQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790553723; c=relaxed/simple;
	bh=8asdfgqxUi/pE3lNJ6ya5RoNu2GxhRyUtIZ64UkxeQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=daAb0UahtTvlX8VVb1tPQpzCfyfugwDaa1FNyn+/i7ljC0n1WEZEwqfBdaGl0BemMYiSmZTIHa+3EI7G0vNB43GExF+43+IhqHhkMoU21EUWzJggGHAs2/lARsYakSDz23KNwIvFH9pLrub4g7C4NfMKAkTOqgox5xUORl21alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uHuTU4wN; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uHuTU4wN"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8asdfgqxUi/pE3lNJ6ya5RoNu2GxhRyUtIZ64UkxeQE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790553713; v=1; x=1791158513;
 b=uHuTU4wNdBuPar9V2ailZz4Ks2gr/rLEk7CT5FU8tfpq7EquwoXs0tl+BCyxrOnnZOlPLrXK
 kHjb+16u0lmkfRc7agUm0a9qeQcYni8rmpOA/5SJ7UEB9LnQyGtEJ4g3RaEbmsEefEHmL1ttkX2
 jzfyPY9cAKKGId7KGUYkdBrI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 31d38cd38316ebd3;
	Mon, 28 Sep 2026 00:01:42 +0000
X-Mizu-Trace-ID: 31d38cd38316ebd3
X-Migadu-Flow: FLOW_OUT
Message-ID: <5bd74138-bff9-4a67-9c7b-2fff892e1dbe@linux.dev>
Date: Sun, 27 Sep 2026 17:01:38 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 05/21] bpf: Prepare for an exception cleanup
 table before the CFG walk
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260926050032.2215748-1-yonghong.song@linux.dev>
 <02f30a5337e07a9178f7211368e1a23e44ee278ea6b1073f68a42601c56ef48e@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <02f30a5337e07a9178f7211368e1a23e44ee278ea6b1073f68a42601c56ef48e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/27/26 1:39 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index e42eccb0990e..972b3ed2a51d 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -1248,6 +1248,7 @@ bool bpf_jit_supports_stack_args(void);
>>   bool bpf_jit_supports_arena_args(void);
>>   bool bpf_jit_supports_far_kfunc_call(void);
>>   bool bpf_jit_supports_exceptions(void);
>> +bool bpf_jit_supports_cleanup_pads(void);
>>   bool bpf_jit_supports_ptr_xchg(void);
>>   bool bpf_jit_supports_arena(void);
>>   bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
> [ ... ]
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index b19fcbf49b7e..1ed0370a171b 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -7,9 +7,56 @@
>>   #include <linux/filter.h>
>>   #include "exception.h"
>>
>> +#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
>> +
>>   BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
>>   BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
>>
>> +static void mark_call_sites(struct bpf_verifier_env *env)
>> +{
>> +	u32 i, j;
>> +
>> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
>> +		struct bpf_cleanup_info *rec = &env->cleanup_info[i];
>> +
>> +		for (j = rec->begin_off; j < rec->end_off; j++) {
>> +			struct bpf_insn *insn = &env->prog->insnsi[j];
>> +
>> +			if (!bpf_pseudo_call(insn) && !bpf_is_unwind_kfunc(insn))
>> +				continue;
>> +			env->insn_aux_data[j].cleanup_pad = rec->landing_pad_off + 1;
>> +		}
>> +	}
>> +}
> Does mark_call_sites() handle indirect BPF-to-BPF calls? The function
> marks only direct calls (bpf_pseudo_call) and bpf_unwind(), but skips
> callx instructions (BPF_JMP|BPF_CALL|BPF_X).

I missed newly support callx in verifier. I will add it in the next revision.

>
> check_func_callx() in the verifier takes a PTR_TO_FUNC to a static
> subprog and verifies it through check_static_func_call(), the same path
> as direct calls. Nothing prevents that callee from calling bpf_unwind()
> since bpf_exc_check_callback() only runs for helper/kfunc callbacks, not
> static subprogs.
>
> The commit message states cleanup_pad is recorded "for every call that
> can unwind -- a BPF-to-BPF call or bpf_unwind()" but a callx inside the
> [begin_off, end_off) range keeps cleanup_pad == 0.
>
> The infrastructure that consumes cleanup_pad already handles callx:
>
> kernel/bpf/verifier.c:
> visit_func_call_insn() and push_cleanup_pad_branch() run for every
> BPF_CALL instruction, including callx. If cleanup_pad is not set, they
> treat the call as unable to unwind.
>
> This means:
> - visit_cleanup_pad_edge() -> bpf_exc_pad_of_call() returns -1, so no
>    CFG edge is created to the landing pad
> - push_cleanup_pad_branch() returns 0 before check_func_callx() runs, so
>    the verifier never explores the landing pad state
> - bpf_unwind_rewrite() finds no cleanup range for the frame and sets
>    *ra = prog->aux->epilogue_ip
>
> Concrete scenario: a C++ or Rust program makes a virtual or trait call
> (lowered to callx) inside a scope whose drop glue sits in a landing pad.
> If the callee unwinds, the caller frame goes to its epilogue and the
> drop glue never runs. If that drop glue releases a kernel reference or
> kptr, the release is skipped. Meanwhile the verifier modeled the
> callee's resume as a normal return to callx+1.
>
> Should the test be widened to include bpf_is_callx(), or should cleanup
> tables that cover a callx be rejected?
>
>> +
>> +int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
>> +{
>> +	if (!env->cleanup_info_cnt)
>> +		return 0;
>> +
>> +	if (bpf_prog_is_offloaded(env->prog->aux)) {
>> +		verbose(env,
>> +			"exception cleanup is not supported for offloaded programs\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!bpf_jit_supports_cleanup_pads() || !env->prog->jit_requested) {
>> +		verbose(env,
>> +			"exception cleanup needs a JIT that can dispatch landing pads\n");
>> +		return -EOPNOTSUPP;
>> +	}
>> +	env->prog->jit_required = 1;
>> +
>> +	if (env->exception_callback_subprog) {
>> +		verbose(env,
>> +			"exception cleanup table cannot be combined with an exception callback\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mark_call_sites(env);
>> +	return 0;
>> +}
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36346422430

