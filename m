Received: from mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7F415B7F
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969485; cv=none; b=ZMSv2ybfphgha6Naqomym3eXfpPwsPV/TOFsmosP1ggVXyyOAxnIGpcRiCujRxpbkXHvqIWZW6HRGiVkDS6lTlonndGZoofQ0gDbYR0AWMK0X7XBE1Vb9+/vAuWXLpqliYl0foTQZNxNOaDZ6jzTuE8ZD9KbMB47LhEtd5Wlu5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969485; c=relaxed/simple;
	bh=JJuniNom+Fw1ahPNnyFOqIw4fr13xMk4CIJNhpunTEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6UnmAPSPx3h4iIo7HxJrA28iemzbEHExIZEjh+vKOSB0Pl8pu+4W9+Dt/HISMNqLKcxrf6HSpy5C0slXO321pw0yrykJvXjvcVWbgMay8odWOiNAS/hyi8xpu6UG3VV5IisoEv4E6aAQgNZhe8K/JiY7dE894d7hrdXy8oF7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N70aTAJT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N70aTAJT"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JJuniNom+Fw1ahPNnyFOqIw4fr13xMk4CIJNhpunTEY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790969479; v=1; x=1791574279;
 b=N70aTAJTd2Rb41o+tSMVz2h5P5dN0uAbuhqpFQCzbPkV01jmOVjfzpsoOcJaRceVeRroicDD
 9vblthSMXZS10lnt3zYc22a2OIsB2bOPz8RQ/o92xvJcMZYQPt0u0pKZ0AjrC353gL+MNbmjeZm
 bNBhtUqvYcgvi1dn2/m3UNco=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7e2376942eea0f24;
	Fri, 02 Oct 2026 19:31:19 +0000
X-Mizu-Trace-ID: 7e2376942eea0f24
X-Migadu-Flow: FLOW_OUT
Message-ID: <e4059411-8cc4-4bdf-90ca-513ba84c2c90@linux.dev>
Date: Fri, 2 Oct 2026 20:31:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 07/22] bpf: Follow an unwind to its landing
 pad in the verifier
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
 <20261001133042.1339539-1-yonghong.song@linux.dev>
 <20261001135024.39F561F00898@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20261001135024.39F561F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/1/26 6:50 AM, sashiko-bot@kernel.org wrote:
> Subject: bpf: Follow an unwind to its landing pad in the verifier
>
> This patch updates the BPF verifier to follow unwind operations to their
> landing pads. It handles how an unwind rewrites return addresses of frames
> and evaluates the proper precision backtracking.
>
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
> [ ... ]
>> @@ -19126,6 +19145,127 @@ enum {
>>   	INSN_IDX_UPDATED = 2,
>>   };
>>   
>> +/*
>> + * The current frame is leaving through an unwind. Its caller's saved return
>> + * address now points at the pad covering the call, or, with none, at the
>> + * caller's epilogue, and so on down. Follow that from the state the frame
>> + * leaves in -- anything it wrote into its callers' stacks included -- to the
>> + * first pad, or to the main program's frame returning.
>> + */
>> +static int unwind_frames(struct bpf_verifier_env *env, bool *do_print_state)
>> +{
>> +	struct bpf_verifier_state *state = env->cur_state;
>> +	u32 frameno = state->curframe;
>> +	struct bpf_func_state *callee, *caller;
>> +	int err, pad;
>> +
>> +	while (state->curframe) {
>> +		callee = cur_func(env);
>> +		caller = state->frame[state->curframe - 1];
>> +		pad = bpf_exc_pad_of_call(env, callee->callsite);
>> +		/* The caller is at its call now, not at this frame's insn. */
>> +		state->insn_idx = callee->callsite;
>> +		account_processed_insns(env, callee, caller);
>> +		free_func_state(callee);
>> +		state->frame[state->curframe--] = NULL;
>> +		invalidate_outgoing_stack_args(env, caller);
>> +		if (pad < 0)
>> +			continue;
> [Severity: Critical]
> If a callback subprogram (such as one passed to bpf_loop()) calls
> bpf_unwind(), does this loop incorrectly pop frames in the verifier state past
> the C helper?
>
> It appears bpf_unwind() and bpf_unwind_resume() lack the callback restriction
> that bpf_throw() has in do_check_subprogs().
>
> At runtime, the exception unwinder stops unwinding when it encounters the
> non-BPF C helper frame and returns. The callback returns 0, the C helper
> resumes, and it returns normally to the BPF program.
>
> However, if the verifier simulates an unwind through the C helper to the
> caller's landing pad, it marks the normal execution path as dead code
> and replaces it with a ja -1.
>
> Could this divergence between verifier state and runtime execution cause an
> infinite loop and hang the kernel?

This won'd happen. See

int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog)
{
         if (!env->subprog_info[subprog].might_unwind)
                 return 0;
                 
         verbose(env, "subprog %d may unwind and is used as a callback\n", subprog);
         return -EINVAL;
}

If any callback function may be might_unwind which implies some callee(s)
or further down callee(s) must be a bpf_unwind(), then bpf_exc_check_callback()
will fail.

>
> [ ... ]
>> @@ -19380,13 +19520,32 @@ static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_state)
>>   					return -EINVAL;
>>   				}
>>   			}
>> +			if (bpf_is_unwind_kfunc(insn) || bpf_is_unwind_resume_kfunc(insn)) {
>> +				err = check_kfunc_allowed_only(env, insn, env->insn_idx);
>> +				if (err)
>> +					return err;
>> +				if (bpf_is_unwind_kfunc(insn))
>> +					return process_bpf_unwind(env, &env->insn_idx,
>> +								  do_print_state);
>> +				/*
>> +				 * The fixups lower this to 'r0 = 0; exit', and
>> +				 * the unwind goes on below this frame.
>> +				 */
>> +				return unwind_frames(env, do_print_state);
>> +			}
>>   			mark_reg_scratched(env, BPF_REG_0);
>>   			if (bpf_in_stack_arg_cnt(&env->subprog_info[cur_func(env)->subprogno]))
>>   				cur_func(env)->no_stack_arg_load = true;
>>   			if (bpf_is_callx(insn))
>>   				return check_func_callx(env, insn, &env->insn_idx);
>> -			if (insn->src_reg == BPF_PSEUDO_CALL)
>> -				return check_func_call(env, insn, &env->insn_idx);
>> +			if (insn->src_reg == BPF_PSEUDO_CALL) {
>> +				int call_idx = env->insn_idx;
>> +
>> +				err = check_func_call(env, insn, &env->insn_idx);
>> +				if (err)
>> +					return err;
>> +				return unwind_out_of_global_call(env, call_idx, do_print_state);
>> +			}
> [Severity: Critical]
> If check_func_call() processes a global subprogram that is marked with both
> might_throw and might_unwind, it evaluates might_throw, calls
> process_bpf_exit_full(), and returns PROCESS_BPF_EXIT.

The global subprog is marked with both might_throw and might_unwind. The previous
suggested like

         if (env->cleanup_info_cnt || bpf_prog_may_unwind(env)) {
                 ret = bpf_exc_check_prog(env);
                 if (ret)
                         goto skip_full_check;
         }

and we have

bool bpf_prog_may_unwind(const struct bpf_verifier_env *env)
{
         u32 i;

         for (i = 0; i < env->subprog_cnt; i++)
                 if (env->subprog_info[i].might_unwind)
                         return true;
         return false;
}

so bpf_exc_check_prog() will fail if prog has both might_throw and might_unwind.


>
> Does this cause do_check_insn() to return early here with err = 1, completely
> bypassing the unwind_out_of_global_call() logic?
>
> If bypassed, the landing pad associated with the call is never verified and
> is replaced with a ja -1 (dead code). At runtime, if the global subprogram
> calls bpf_unwind(), the exception unwinder routes execution to this unverified
> landing pad.
>
> Can this result in hitting the ja -1 infinite loop and hanging the kernel?

