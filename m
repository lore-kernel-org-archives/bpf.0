Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAE3AE6F4
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050690; cv=none; b=JWgNwRQa0q3CMXYCG8EPWEExmUpbJnfpQT1vdSNA4xvpAThlSs6jlr6c6xd8PsDEL6j7CeICjRRSxeF2UuPZixzazfutzdZUEXXdRA6+T0uoy/Ia1iFI3LOkG0EkzkM5T3gkvqALKiE4aadCOLi5+HIuyEr0Cy4RgywQfkhmtUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050690; c=relaxed/simple;
	bh=olCiUBNgfm867BXuLMc7Xxxz5VXK6aNPTsafgePzaWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgGwO1IAg8CVnJngNq/JwhRkkNLNTVQTB5Ihb2i64zGXNtJjKG0XZyyQXMu5Jmj1TK5yTuFYKKuOT1zriD6JZFFwbisq5Y+lPGQZDKiOFU31KkimsRnGJ8DCaTENPoUX6w/Y/tUEkcS1hxnZd+KNOTYx2A1ESiqmuZ4kEL5EnWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d/WWawX0; arc=none smtp.client-ip=95.215.58.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d/WWawX0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=olCiUBNgfm867BXuLMc7Xxxz5VXK6aNPTsafgePzaWI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790050680; v=1; x=1790655480;
 b=d/WWawX0Q615fbYpHsChbV1Ik6jCg7/IFeFSOiBxWsYMyn1TGP83EjCYHHwrDbkHv0lTCR7I
 kv38kzSlFZ/sziPrihRPZFoTPcQzBJ7Y1p7KBQutyiz8H2YxOtxoMbsNZVxJl+ICAZZnTl51inf
 yLSChbHfiu0y7AniHzHOLShs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 39cdfd2b46b6240e;
	Tue, 22 Sep 2026 04:18:00 +0000
X-Mizu-Trace-ID: 39cdfd2b46b6240e
X-Migadu-Flow: FLOW_OUT
Message-ID: <1ad53bbc-817d-4ac4-ba6d-72333df99c05@linux.dev>
Date: Mon, 21 Sep 2026 21:17:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 08/20] bpf: Walk the exception unwind in the
 verifier
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210114.1720196-1-yonghong.song@linux.dev>
 <20260921214019.5C01F1F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260921214019.5C01F1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 2:40 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] bpf: BPF_EXIT in exception cleanup pads bypasses runtime unwinding
> - [High] bpf: nested bpf_throw() in landing pads causes kernel NULL pointer dereference
> - [Medium] bpf: R0 precision tracking is not cleared across exception edges
> --
>
> commit cdb6004b5b8821aea00d57d94b9ac5bcf916b6a4
> Author: Yonghong Song <yonghong.song@linux.dev>
> Subject: bpf: Walk the exception unwind in the verifier
>
> This commit updates the BPF verifier to walk the exception unwinding path
> step for step when bpf_throw() is called. This aligns the verifier with
> the runtime unwinder to properly handle landing pads for exception cleanup.
>
>> diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
>> index 507a366dffa47..bf5e7e6ab78f3 100644
>> --- a/kernel/bpf/backtrack.c
>> +++ b/kernel/bpf/backtrack.c
> [ ... ]
>> @@ -909,6 +913,14 @@ int bpf_mark_chain_precision(struct bpf_verifier_env *env,
>>   				 */
>>   				return 0;
>>   			subseq_idx = i;
>> +			/* This insn is a landing pad the unwind reached from
>> +			 * a throw or a resume hist->unwind_frames frames
>> +			 * deeper. No insn stands between the two, so enter
>> +			 * those frames here, the way BPF_EXIT enters one.
>> +			 */
>> +			for (fr = 0; hist && fr < hist->unwind_frames; fr++)
>> +				if (bt_subprog_enter(bt))
>> +					return -EFAULT;
>>   			i = get_prev_insn_idx(st, i, &history);
>>   			if (i == -ENOENT)
>>   				break;
> [Severity: Medium]
> When traversing the exception edge here, does the backtrack correctly clear
> the precision tracking for R0 in the pad's frame?
>
> When returning from a throw to a landing pad, R0 is initialized to
> BPF_PAD_ENTRY_R0 by the kernel unwinder. Since its precision might be
> tracked if used in a conditional jump in the pad, this backtrack loop uses
> bt_subprog_enter(bt) but does not appear to clear R0's precision mask in
> the pad's frame.
>
> This could leave R0 erroneously tracked in the pad's frame as the backtrack
> proceeds, eventually reaching the program entry and triggering a
> verifier_bug() that rejects valid BPF programs with -EFAULT.

Good point. We should clear R0 to prevent backtracking using value 1.

>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 680ae191aa3f5..2bc08c18ebc89 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -14585,7 +14588,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>   		env->prog->call_session_cookie = true;
>>   
>>   	if (bpf_is_throw_kfunc(insn))
>> -		return process_bpf_exit_full(env, NULL, true);
>> +		return unwind_step(env, insn_idx, &env->insn_idx);
>>   
>>   	return 0;
>>   }
> [Severity: High]
> Is there anything preventing a nested exception from being thrown here?
>
> There doesn't seem to be a check for env->cur_state->unwinding before
> processing bpf_throw(), which allows a program to throw an exception from
> within a landing pad.
>
> At runtime, the landing pad is executed via arch_bpf_run_cleanup_pad(),
> placing kernel frames on the call stack above the BPF frames. A nested call
> to bpf_throw() would invoke arch_bpf_stack_walk().
>
> Since it would encounter the non-BPF frame for arch_bpf_run_cleanup_pad(),
> bpf_prog_ksym_find() returns NULL. With ctx->cnt being non-zero, the walk
> halts prematurely, causing a blind dereference of ctx.aux->bpf_exception_cb
> and leading to a kernel NULL pointer dereference.

So we do have nested exception checking:

+               if (kind == CLEANUP_INSN_CALL) {
+                       /* check_subprogs() registered every call target. */
+                       int callee = cleanup_subprog_of(env, j + env->prog->insnsi[j].imm + 1);
+
+                       if (env->subprog_info[callee].might_throw) {
+                               verbose(env,
+                                       "cleanup landing pad calls subprog %d at insn %u, which can throw while an ex
ception is in flight\n",
+                                       callee, j);
+                               return -EINVAL;
+                       }
+               }

and

+       if (reach & CLEANUP_REACH_THROW) {
+               verbose(ctx->env,
+                       "cleanup landing pad %u can throw while an exception is in flight\n",
+                       pad);
+               return -EINVAL;
+       }

We probably will be okay. The above two cases should capture nested throw's.

>
> [ ... ]
>> @@ -18522,25 +18624,11 @@ static int process_bpf_exit_full(struct bpf_verifier_env *env,
>>   	 * for which reference_state must match caller reference
>>   	 * state when it exits.
>>   	 */
>> -	int err = check_resource_leak(env, exception_exit,
>> -				      exception_exit || !env->cur_state->curframe,
>> -				      exception_exit ? "bpf_throw" :
>> +	int err = check_resource_leak(env, false, !env->cur_state->curframe,
>>   				      "BPF_EXIT instruction in main prog");
>>   	if (err)
>>   		return err;
>>   
>> -	/* The side effect of the prepare_func_exit which is
>> -	 * being skipped is that it frees bpf_func_state.
>> -	 * Typically, process_bpf_exit will only be hit with
>> -	 * outermost exit. copy_verifier_state in pop_stack will
>> -	 * handle freeing of any extra bpf_func_state left over
>> -	 * from not processing all nested function exits. We
>> -	 * also skip return code checks as they are not needed
>> -	 * for exceptional exits.
>> -	 */
>> -	if (exception_exit)
>> -		return PROCESS_BPF_EXIT;
>> -
>>   	if (env->cur_state->curframe) {
>>   		/* exit from nested function */
>>   		err = prepare_func_exit(env, &env->insn_idx);
> [ ... ]
>> @@ -18747,7 +18837,7 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   				env->insn_idx += insn->imm + 1;
>>   			return INSN_IDX_UPDATED;
>>   		} else if (opcode == BPF_EXIT) {
>> -			return process_bpf_exit_full(env, do_print_state, false);
>> +			return process_bpf_exit_full(env, do_print_state);
>>   		}
>>   		return check_cond_jmp_op(env, insn, &env->insn_idx);
>>   	}
> [Severity: High]
> Are we correctly handling BPF_EXIT when an exception is in flight?
>
> Because process_bpf_exit_full() is called unconditionally without checking
> if env->cur_state->unwinding is true, the verifier treats BPF_EXIT from a
> landing pad as a normal subprogram return (when curframe > 0).
>
> It pops the frame and continues verifying the caller's instructions, where
> an attacker might place lock releases to satisfy check_resource_leak().
>
> At runtime, BPF_EXIT emits a bare 'ret' instruction. When executed from
> arch_bpf_run_cleanup_pad(), it behaves like bpf_unwind_resume() by
> returning control to the kernel unwinder, which silently discards the
> caller frame without executing it.
>
> This discrepancy could allow BPF programs to bypass verifier resource
> checks and leak locks or references at runtime.

Similar to above.

>

