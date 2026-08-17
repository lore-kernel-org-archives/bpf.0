Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225EA26AC3
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 03:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786938474; cv=none; b=uuN3aQeJ++Ut8CFy1su75N7nRZCcD0LRAxvpr4ablacVFGgNImNMQumjG49MuODfbQiydh7kkC7tAEp3T1Daalf2bgDJ7DULWKtVss0q+OIeVV3Yjv6MonobDPaP18CJvYzKNIsYMWKoPdhGDWwycvYNz5dmrt5xQEcaxI0fwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786938474; c=relaxed/simple;
	bh=qeO/R3xkHm6znEAOrbD6VGSrbYRcSO0Ff8fLE9cy0rA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqns6ra47dJGcrBgVnvK1CUc88C8ultiEonw7iE2o/nu1rsrZGB+6OZNdKKipSRr/JVqbB8mCAsr24UjJVuf5HNC/ku9fJcdpQ5V2NgYzzcfO+svqMf8YRSYh+9tYtZM5krmhd4NQwV8eG/quEPdSBR2bX//GjHsM9IJCAOQPN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ID+PytZC; arc=none smtp.client-ip=91.218.175.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ID+PytZC"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qeO/R3xkHm6znEAOrbD6VGSrbYRcSO0Ff8fLE9cy0rA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786938470; v=1; x=1787543270;
 b=ID+PytZCgOczfs0ccIywtyhJMUlGtIyeoHyix6NgGZpd6AQpR5ngWFLIZ73CTaNjG6JL9lXi
 gUuJGFxEgHVVhgF0CjDT2eWSlDMZeC0yAhYg4ZNiSIZXHrL0lN/Ui08zho/Iv96LzYu1JVGVufk
 WQm6qoAXlom2CuMREs6cYg6k=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2600:382:861c:7f36:14e1:cf55:e233:293b] (2600:382:861c:7f36:14e1:cf55:e233:293b)
	by smtp.migadu.com with ESMTPS id 6adc7392da8b03fa;
	Mon, 17 Aug 2026 03:47:50 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <ac9bda02-46ad-468f-86b8-11b781804849@linux.dev>
Date: Sun, 16 Aug 2026 20:47:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 08/11] bpf: Reject register-pair returns when
 the subprog BTF is unreliable
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260813200250.1996395-1-yonghong.song@linux.dev>
 <1ce46a68f49276d02c4085b05dedb72549b0cdebf33ff4576d670b5bd1e6069f@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <1ce46a68f49276d02c4085b05dedb72549b0cdebf33ff4576d670b5bd1e6069f@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/26 1:49 PM, bot+bpf-ci@kernel.org wrote:
>> btf_check_subprog_call() can decide, at a call site, that this BTF is not
>> to be trusted and mark the subprogram unreliable, which happens when
>> compiler optimizations remove arguments from a static function or when a
>> mismatched type is passed to a global one. Verification carries on, but
>> the prototype the return convention was read from is one the verifier has
>> already declared not to describe the compiled code.
>>
>> Rather than keep tracking R2 on the strength of a discarded signature,
>> reject a return value larger than 8 bytes as soon as the prototype it was
>> derived from becomes unreliable. Add subprog_ret_pair_unreliable() and
>> test it in check_func_call() on the path to a static subprogram, which is
>> where the flag can be observed while the call still proceeds. For a static
>> callee this only triggers on a genuine argument mismatch, since the
>> previous patch stopped btf_validate_return_type() from marking a local
>> function unreliable for returning an aggregate.
>>
>> No check is needed anywhere else:
>>   - a global subprogram is already rejected by the existing "Caller passes
>>     invalid args into func#N" path, because btf_check_subprog_call()
>>     returns an error both when it marks the BTF unreliable and on every
>>     later call;
>>   - the main program does not use the convention at all: its return value
>>     is the program's exit code, read out of R0, so nothing looks at R2
>>     there;
> Does this enumeration cover all call sites? btf_check_subprog_call() has
> two callers: check_func_call() and push_callback_call() in verifier.c.
>
> push_callback_call() also swallows every non-EFAULT error:
>
>      err = btf_check_subprog_call(env, subprog, caller->regs);
>      if (err == -EFAULT)
>              return err;
>
> so a callback subprogram's BTF can be marked unreliable while the call
> still proceeds, exactly the situation described above for the static
> check_func_call() path. The two bullets given (global subprogram, main
> program) do not cover it.
>
> It interacts with the sticky nature of the flag: a subprogram marked
> unreliable by a callback call site will subsequently be rejected by the
> new check at an unrelated direct call site whose own arguments were fine,
> since btf_check_subprog_call() returns -EINVAL for every later call once
> the flag is set (the early return in btf_check_subprog_call()).
>
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index b23be0fa95af..0ffb3bed1649 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -441,6 +441,23 @@ static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
>>   	}
>>   }
>>
>> +/*
>> + * A >8 byte BPF return changes the calling convention to R0:R2, and the
>> + * verifier derives that convention from the subprogram's BTF prototype
>> + * alone. Once that prototype is marked unreliable it is known not to
>> + * describe the compiled code, so the convention read from it cannot be
>> + * trusted either: reject the call rather than keep tracking R2 on the
>> + * strength of a signature the verifier has already discarded.
>> + */
>> +static bool subprog_ret_pair_unreliable(struct bpf_verifier_env *env, int subprog)
>> +{
>> +	struct bpf_prog_aux *aux = env->prog->aux;
>> +
>> +	return bpf_ret_reg_pair(env, subprog) &&
>> +	       aux->func_info_aux &&
>> +	       aux->func_info_aux[subprog].unreliable;
>> +}
>> +
> [ ... ]
>> @@ -9527,6 +9544,12 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		return 0;
>>   	}
>>
>> +	if (subprog_ret_pair_unreliable(env, subprog)) {
>> +		verbose(env, "Func#%d ('%s') returns >8 bytes, which requires reliable BTF\n",
>> +			subprog, subprog_name(env, subprog));
>> +		return -EINVAL;
>> +	}
>> +
> Can this gate reject valid programs? For a static callee, func_info_aux[]
> .unreliable is set for reasons that have nothing to do with an argument
> mismatch.
>
> The path is: do_check_insn() calls check_func_call(), which calls
> btf_check_subprog_call(), which calls btf_check_func_arg_match().
>
> btf_check_func_arg_match() in kernel/bpf/verifier.c starts with:
>
>      ret = btf_prepare_func_args(env, subprog);
>      if (ret) {
>              if (bpf_in_stack_arg_cnt(sub) > 0) ...
>              return ret;
>      }
>
> Then btf_check_subprog_call() does unconditionally on any non-zero err:
>
>      if (err)
>              prog->aux->func_info_aux[subprog].unreliable = true;
>
> btf_prepare_func_args() returns -EINVAL for a non-global subprogram in the
> ordinary case of an untagged pointer argument. In the argument loop
> (kernel/bpf/btf.c), a pointer arg that is not the prog ctx type, not a
> dynptr, and carries no __arg_trusted/__arg_untrusted/__arg_arena tag skips
> the generic-user-data-pointer branch and falls through to:
>
>    skip_pointer:
>          if (tags) { ... return -EINVAL; }
>          if (btf_type_is_int(t) || btf_is_any_enum(t)) { ... }
>          if (!is_global)
>                  return -EINVAL;
>
> A by-value struct argument takes the same exit. This is expected,
> documented behaviour for static callees since btf_prepare_func_args() even
> comments "not fatal for static funcs" at kernel/bpf/btf.c, because a
> static subprogram is verified inline so the verifier never needs a usable
> BTF argument model for it.
>
> Concrete example that verifies fine at the parent commit but is now
> rejected:
>
>      struct pair { __u64 a, b; };
>
>      static __noinline struct pair make_pair(__u64 *p)
>      {
>              struct pair r = { *p, 1 };
>              return r;
>      }
>
>      SEC("tc") int prog(struct __sk_buff *ctx)
>      {
>              __u64 v = 1;
>              struct pair p = make_pair(&v);
>              return p.a + p.b;
>      }
>
> This program is rejected: "Func#1 ('make_pair') returns >8 bytes, which
> requires reliable BTF".
>
> The flow is: bpf_compute_subprog_ret_regs() sees struct pair, size 16,
> and sets ret_reg_pair = true. btf_validate_return_type() accepts it via
> the local_func path. The argument loop then returns -EINVAL for __u64 *p,
> setting unreliable = true. The new check fires.
>
> The rejection is also unnecessary for soundness on this path: a static
> callee is verified inline, so prepare_func_exit() copies the callee's
> actual tracked R0 and R2 into the caller. R2 tracking does not rest on the
> BTF prototype the way it does for a global callee.
>
> The commit message premise appears incorrect: "For a static callee this
> only triggers on a genuine argument mismatch, since the previous patch
> stopped btf_validate_return_type() from marking a local function
> unreliable for returning an aggregate." Relaxing btf_validate_return_type()
> removed only one of two independent -EINVAL exits inside
> btf_prepare_func_args(); the argument-conversion exit at kernel/bpf/btf.c
> is untouched and is the common one. The new comment in verifier.c encodes
> the same premise: "Once that prototype is marked unreliable it is known
> not to describe the compiled code" - but the flag also means merely "the
> verifier cannot express these argument types".
>
> Should the gate be restricted to cases where the return convention itself
> is untrustworthy, rather than whenever any argument cannot be expressed in
> BTF?

Good point. Let us remove this patch as it is too conservative.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31740414277

