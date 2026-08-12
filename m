Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84568377EC5
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566417; cv=none; b=um9iCq5d0nvqSAINvm4aVihzOFKa1x///0QZiFFkmvKAKrPpSABdJqekd1pcupandAgEcXcFXD3UfA1gCAfx9Sui0IK1vF/llDhzSc9HWKgHGSGpG6yzmfm02XqTzkMXAfOXFPyZxbTmt1PRd9fW7xvZK5k1BX8qqXccvPEBCDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566417; c=relaxed/simple;
	bh=/9SizqfP7/uO9XtpzIWMjNjug4oSCQWXkFREOz5EXvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukyW7hK2ozkhJmPPOtvVt2cK9RpPF5pXuM1NQCVu0QbwPOXhyg6z5Hj2dDfgB0+W12BqX8fZZ5KiON7hCP9e//YkRLz440EnUxJK8KFQNEISYATJEbtW+AI/8cDYe+bN76n1g46QFt18y8MoxI7ii3s9yoH+CFSFyIL5pnDqaRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBSioIfQ; arc=none smtp.client-ip=91.218.175.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBSioIfQ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/9SizqfP7/uO9XtpzIWMjNjug4oSCQWXkFREOz5EXvs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786566412; v=1; x=1787171212;
 b=kBSioIfQUcv67gikeRGKPddKas4oZfqRXHWYEtxw2HI77Vpl+DdrvoDxHHjQjp79vIlEWeQE
 KJf0yG0CtG1lz8uyRqdqs8DTDVHw7CdpONoJuVfWuSqofRaxnafQ41weX2wONytayerNWuy7tU7
 x4SLIVfBIn6MhJkiBqj5Wk6c=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:cd95)
	by smtp.migadu.com with ESMTPS id 6c768c1e667da558;
	Wed, 12 Aug 2026 20:26:52 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <780f14d1-b752-40d9-98e6-8218077bfdf2@linux.dev>
Date: Wed, 12 Aug 2026 13:26:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 08/13] bpf: Reject register-pair returns when
 the subprog BTF is unreliable
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260811000952.2382568-1-yonghong.song@linux.dev>
 <b0796c556995285a17bc51b371fb413f000498e0d78d5a040ef8dba50010726d@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <b0796c556995285a17bc51b371fb413f000498e0d78d5a040ef8dba50010726d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/26 6:24 PM, bot+bpf-ci@kernel.org wrote:
>> commit cb2551cf6e866ae6692739f7cbb75ff97e2d1a3b
>> Author: Yonghong Song <yonghong.song@linux.dev>
>> Date:   Mon Aug 10 17:09:52 2026 -0700
>>
>>      bpf: Reject register-pair returns when the subprog BTF is unreliable
>>
>>      The R0:R2 return convention is derived from the BTF function prototype:
>>      bpf_compute_subprog_ret_regs() inspects the return type of every
>>      subprogram and records whether its value comes back in a register pair.
>>
>>      btf_check_subprog_call() can decide, at a call site, that this BTF is
>>      not to be trusted and mark the subprogram unreliable, which happens when
>>      compiler optimizations remove arguments from a static function or when a
>>      mismatched type is passed to a global one. From that point on the
>>      verifier falls back to conservative, R0-only, semantics for the
>>      subprogram, while the compiled code keeps returning a pair and leaves
>>      the upper half in R2 behind the verifier's back.
>>
>>      Rather than silently mistracking R2, reject a return value larger than
>>      8 bytes as soon as the prototype it was derived from becomes unreliable.
>>      Add subprog_ret_pair_unreliable() and test it at the two places that can
>>      observe the flag: check_func_call(), for the call itself, and
>>      prepare_func_exit(), for the return from an inlined static subprogram.
>>
>>      Note that the main program needs no such check: a >8 byte return from
>>      subprog 0 is rejected at BPF_EXIT regardless of whether its BTF is
>>      reliable. Callbacks need none either: a callback address only becomes a
>>      PTR_TO_FUNC through check_ld_imm(), which already rejects any callback
>>      returning more than 8 bytes.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix for register-pair return support. Should this
> include:
>
>    Fixes: d280e9c973c5 ("bpf: Add verifier support for 16-byte returns in R0:R2")

Typically we don't do 'Fixes' within the same series.

>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 944f0721086bd..8f0c4aed0781f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -438,6 +438,21 @@ static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>>   	}
>>   }
>>
>> +/*
>> + * A >8 byte BPF return changes the calling convention to R0:R2, so the
>> + * verifier can only allow it while the subprogram's prototype remains
>> + * reliable. Once BTF is marked unreliable, reject the feature instead of
>> + * silently falling back to R0-only semantics.
>> + */
> Does the verifier actually fall back to R0-only semantics? The return
> convention is read through bpf_ret_reg_pair():
>
>    include/linux/bpf_verifier.h:
>    static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
>    {
>            return subprog_info(env, subprog)->ret_reg_pair;
>    }
>
> and ret_reg_pair is computed once in bpf_compute_subprog_ret_regs() from
> the BTF return type. It is never recomputed or cleared when unreliable
> becomes true.
>
> Grepping every reader of func_info_aux[].unreliable finds exactly three,
> none of which touches the return convention:
>
>    - btf_check_subprog_call(): returns -EINVAL early on a later call site
>    - btf_prepare_func_args(): verifier_bug() + -EFAULT
>    - bpf_check_attach_target(): sets 'conservative' for fentry/fexit
>
> So when unreliable becomes true, prepare_func_exit() still computes
> nregs = 2 and still models R2. For a static subprogram the verifier walks
> the callee, prepare_func_exit() propagates the callee's real R0/R2, and
> clear_caller_saved_regs() marks R0-R5 NOT_INIT at every call, so a caller
> that reads R2 without the callee having written it gets 'R2 !read_ok'.
>
> Worth either citing the concrete path where R2 is mistracked, or dropping
> the claim and stating the real motivation (unreliable BTF means the
> prototype the convention was derived from cannot be trusted at all)?

I will change to mean that for unreliable BTF, the convention was
derived from the prototype cannot be trusted.

>
>> +static bool subprog_ret_pair_unreliable(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	struct bpf_prog_aux *aux = env->prog->aux;
>> +
>> +	return bpf_ret_reg_pair(env, subprog) &&
>> +	       aux->func_info_aux &&
>> +	       aux->func_info_aux[subprog].unreliable;
>> +}
>> +
>>   static const char *subprog_name(const struct bpf_verifier_env *env, int subprog)
>>   {
>>   	struct bpf_func_info *info;
>> @@ -9459,6 +9474,11 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   	err = btf_check_subprog_call(env, subprog, caller->regs);
>>   	if (err == -EFAULT)
>>   		return err;
>> +	if (subprog_ret_pair_unreliable(env, subprog)) {
>> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable BTF\n",
>> +			subprog, subprog_name(env, subprog));
>> +		return -EINVAL;
>> +	}
> Does this break git bisect? At this commit the new check makes every
> static (local) subprogram that returns a 9..16 byte struct or union
> unloadable, which the parent commit d280e9c973c59 accepted.
>
> The two conditions in subprog_ret_pair_unreliable() are guaranteed to be
> true together for such a subprogram at this point in the series:
>
> 1. bpf_compute_subprog_ret_regs() at verifier.c:429 sets ret_reg_pair
>     from the BTF return type for structs as well as scalars:
>
>       if (type && (btf_type_is_struct(type) || btf_type_is_scalar(type)))
>               subprog_info(env, subprog)->ret_reg_pair = ret_regs_cnt(type->size) > 1;
>
>     so a 16-byte struct return gets ret_reg_pair = 1.
>
> 2. btf_validate_return_type() in kernel/bpf/btf.c still ends with 'return
>     -EOPNOTSUPP;' for anything that is not void/int/enum (or an arena
>     pointer), i.e. for every struct/union return. That -EOPNOTSUPP
>     propagates through btf_prepare_func_args() and btf_check_func_arg_match()
>     to btf_check_subprog_call(), which sets
>     prog->aux->func_info_aux[subprog].unreliable = true precisely because it
>     deliberately swallows any error other than -EFAULT for static
>     subprograms.
>
> So btf_check_subprog_call() marks the subprogram unreliable, returns
> -EOPNOTSUPP (not -EFAULT, so the early return above does not fire), and
> the new check then rejects the call with 'Func#N (...) returns >8 bytes,
> which requires reliable BTF'. Before this patch the swallowed error was
> harmless: the verifier walked into the static callee and prepare_func_exit()
> copied the real R0 and R2 state back to the caller.
>
> The series' own selftest proves the intended behaviour. The file
> tools/testing/selftests/bpf/progs/aggregate_ret_func.c (added later in the
> series by f40812d018cc3) has:
>
>    static __naked __noinline struct ptr_pair static_ret_ptr_pair(void)  /* 16 bytes */
>    ...
>    SEC("tc") __success __retval(0)
>    __naked int aggregate_ret_static_ptr_pair(void)
>
> tagged __success, with the comment 'A static subprogram is verified inline,
> so prepare_func_exit() hands the caller the callee's actual R0:R2 register
> state ... which is why btf_validate_return_type() does not apply the
> scalar-only restriction to a local function.' Built at this commit that
> program would be rejected.
>
> The later commit b12c58bbc5e59 'bpf: Enable aggregate return types up to
> 16 bytes' relaxes btf_validate_return_type() to accept a struct of size
> <= 16 for a local function, and its own comment states the reason: 'What it
> avoids is needlessly marking the subprogram's BTF unreliable.' Only
> __int128 returns are unaffected (int passes btf_validate_return_type()).
>
> Consider reordering so the return-type relaxation lands before this
> rejection, or noting the dependency in this commit's changelog?
I will do reordering between patch 8 and patch 9.
>
>> @@ -9832,6 +9852,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>>
>>   	callee = state->frame[state->curframe];
>>   	r0 = &callee->regs[BPF_REG_0];
>> +	if (subprog_ret_pair_unreliable(env, callee->subprogno)) {
>> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable BTF\n",
>> +			callee->subprogno, subprog_name(env, callee->subprogno));
>> +		return -EINVAL;
>> +	}
> Can this check ever fire? The changelog claims it is needed 'for the
> return from an inlined static subprogram', but the check appears to be
> unreachable.
>
> unreliable is monotonic (only ever set to true) and has exactly two
> writers:
>
>    - btf_check_subprog_call() at verifier.c:9357, called from
>      check_func_call() and push_callback_call()
>    - do_check_common() at verifier.c:18591, which sets
>      func_info_aux[0].unreliable for subprog 0 only
>
> For a frame to reach prepare_func_exit() it must have been pushed by
> setup_func_entry() via one of these paths:
>
>    - check_func_call(): the new hunk above runs immediately after
>      btf_check_subprog_call() and before setup_func_entry(), so a subprog
>      that just became unreliable is rejected there and never gets a frame.
>      Since the flag cannot be set later for that subprog without going through
>      check_func_call() again (which would reject again), the exit check can
>      never see it true.
>
>    - push_callback_call(): check_ld_imm() is the only producer of
>      PTR_TO_FUNC and already rejects bpf_ret_reg_pair() callbacks ('callback
>      function with >8-byte return value is not supported'), so a callback
>      frame never has ret_reg_pair set.
>
>    - subprog 0 is frame 0 and is never a callee frame; check_cfg() rejects
>      a call back into subprog 0.
>
> The two other callers of prepare_func_exit() are equally excluded: the
> tail-call path at verifier.c:10797 and the LD_ABS path at verifier.c:16533
> can only run in a subprog whose BTF return type is a small int, because
> check_btf_func() in kernel/bpf/check_btf.c rejects BPF_LD_ABS and tail
> calls in any subprog that fails btf_type_is_small_int() (int of size <= 8),
> which excludes every ret_reg_pair subprog.
>
> If the check is intended as defence in depth for a future caller of
> btf_check_subprog_call(), saying so in the changelog would help; otherwise
> the hunk can be dropped?

Thanks. I will drop this.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31446101762

