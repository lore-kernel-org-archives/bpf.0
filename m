Received: from mta1.migadu.com (out-130.mta1.migadu.com [95.215.58.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34353366045
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048402; cv=none; b=bDh2GvvAawYNEXCuXT1YMogz8glkikDRsy1qBRcRrA3kQTa+QDHUkV0+z0Z3wbuJWtqKIrzMGIpcF/XjeQxxdbdLu5vYqgMWwoEWloHo35QXG5AXcVDcbZBbmIIOWiRRKWqoY1RIH+D6pTexzGTn48U3iNgxkPvbrjX9MSGX2z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048402; c=relaxed/simple;
	bh=OHRKFvRCPl7CWghI1aZvrZv4JFj95s425kTIVePhcvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hIxqmIH7XNtsfzSOOjJKE+7Tb1IHr+r7y0YHQNrncR0gqIW1NRvVmp8+IRx0b2DLWfdcyOVQfrw0HBoFwS2b5Q3vY9OvT+7ucCGsB9ouz8KXwn+rT50nmkFxO+pz5FXiJozpcNUxpMMaLlL+Cqg77ddubueAOyL5s3Tu+QQgYCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGM1Fj7T; arc=none smtp.client-ip=95.215.58.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGM1Fj7T"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=OHRKFvRCPl7CWghI1aZvrZv4JFj95s425kTIVePhcvU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790048398; v=1; x=1790653198;
 b=fGM1Fj7TLl1Pdfk41/Wj0kUqwGD3d9sucQV5EvduhLxT1VX3MPgCk0vNaTZOvM39usuoPphp
 BzYqeinE4bApeWQSBNNMCc/4Z6dDvPXsgLcwFQ/kfc5NoqG6ygu5raDIsIW/vlPzUiA7CTU5bYH
 eqj+/9wNl9l0aNLXGggj5o+s=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9ff7cc0b32d0b1f8;
	Tue, 22 Sep 2026 03:39:58 +0000
X-Mizu-Trace-ID: 9ff7cc0b32d0b1f8
X-Migadu-Flow: FLOW_OUT
Message-ID: <243d2bb2-d619-46c9-bf1b-da4afd63537c@linux.dev>
Date: Mon, 21 Sep 2026 20:39:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 07/20] bpf: Refuse exception cleanup shapes
 bpf_throw() cannot dispatch
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210109.1719713-1-yonghong.song@linux.dev>
 <20260921212057.D23021F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260921212057.D23021F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 2:20 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] bpf: kernel stack leak via >5 arg BPF-to-BPF calls in exception pads
> --
>
> commit 961251cb485953d7f6bd99ead3712d0e8268b8eb
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch
>
> This commit adds verification logic to reject specific control flow shapes
> that bpf_throw() and the exception cleanup handling cannot safely dispatch.
> It performs post-CFG checks using bpf_check_cleanup_exceptions() to inspect
> pad reachability, catch pads, and unwinding safety.
>
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 67af78baa558d..da8fa6eb7e4b9 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
> [ ... ]
>
>> +static int cleanup_check_pad_insn(struct bpf_verifier_env *env, u32 i)
>> +{
>> +	struct bpf_insn *insn = &env->prog->insnsi[i];
>> +
>> +	if (bpf_helper_call(insn) && insn->imm == BPF_FUNC_tail_call) {
>> +		verbose(env,
>> +			"bpf_tail_call() at insn %u is in an exception cleanup landing pad\n",
>> +			i);
>> +		return -EINVAL;
>> +	}
>> +	/* A BPF_LD_[ABS|IND] can leave the frame through its epilogue. */
>> +	if (BPF_CLASS(insn->code) == BPF_LD &&
>> +	    (BPF_MODE(insn->code) == BPF_ABS || BPF_MODE(insn->code) == BPF_IND)) {
>> +		verbose(env,
>> +			"BPF_LD_[ABS|IND] at insn %u is in an exception cleanup landing pad\n",
>> +			i);
>> +		return -EINVAL;
>> +	}
>> +	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
>> +		verbose(env,
>> +			"insn %u passes an on-stack call argument in an exception cleanup landing pad\n",
>> +			i);
>> +		return -EINVAL;
>> +	}
>> +	if (bpf_pseudo_kfunc_call(insn)) {
>> +		struct bpf_call_summary cs;
>> +
>> +		if (bpf_get_call_summary(env, insn, &cs) &&
>> +		    cs.arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {
> [Severity: High]
> Does this omit checking BPF-to-BPF calls (bpf_pseudo_call) for on-stack
> arguments?
>
> The JIT executes exception cleanup landing pads on the unwinder's stack (rsp),
> while rbp points to the BPF frame. This check restricts kfuncs from passing
> arguments on the stack, but seems to miss BPF subprograms because
> bpf_get_call_summary() returns false for them.
>
> If a pad calls a BPF subprogram requiring more than 5 arguments, could the
> callee read uninitialized kernel stack memory belonging to the unwinder's
> caller?

We should be okay here. As the code explains, if the number of reg-level argument slots
more than 5, verifier will reject.

>> +			verbose(env,
>> +				"insn %u passes an on-stack call argument in an exception cleanup landing pad\n",
>> +				i);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	return 0;
>> +}
> [ ... ]
>
>> +static int cleanup_mark_pad_bodies(struct cleanup_ctx *ctx)
>> +{
>> +	struct bpf_verifier_env *env = ctx->env;
>> +	u32 i, sp = 0;
>> +	int ret;
> [ ... ]
>
>> +	while (sp) {
>> +		u32 j = ctx->stack[--sp];
>> +		enum cleanup_insn_kind kind;
>> +		int next, target, sub;
>> +		u32 start, end;
>> +
>> +		ret = cleanup_check_pad_insn(env, j);
>> +		if (ret)
>> +			return ret;
>> +
>> +		sub = cleanup_subprog_of(env, j);
>> +		start = env->subprog_info[sub].start;
>> +		end = env->subprog_info[sub + 1].start;
>> +		kind = cleanup_succ(env, j, start, end, &next, &target);
>> +
>> +		if (kind == CLEANUP_INSN_CALL) {
>> +			/* check_subprogs() registered every call target. */
>> +			int callee = cleanup_subprog_of(env, j + env->prog->insnsi[j].imm + 1);
>> +
>> +			if (env->subprog_info[callee].might_throw) {
> [Severity: High]
> Since cleanup_mark_pad_bodies() allows BPF-to-BPF calls in landing pads as
> long as they don't throw, should it also verify that the callee does not
> take on-stack arguments?
>
> For example, by checking if env->subprog_info[callee].arg_slot_cnt <=
> MAX_BPF_FUNC_REG_ARGS?
>
> Without this check, a subprogram requiring more than 5 arguments could be
> called, potentially leading to the kernel stack data leak mentioned above.

We should be okay here. Commit "bpf: Walk the exception unwind in the verifier",
we have

+static u32 unwind_pop_frame(struct bpf_verifier_env *env)
+{
+       struct bpf_verifier_state *state = env->cur_state;
+       struct bpf_func_state *callee = state->frame[state->curframe];
+       u32 callsite = callee->callsite;
+       struct bpf_func_state *caller;
+
+       caller = state->frame[state->curframe - 1];
+       account_processed_insns(env, callee, caller);
+       free_func_state(callee);
+       state->frame[state->curframe--] = NULL;
+       invalidate_outgoing_stack_args(env, caller);
+       return callsite;
+}

stack arguments will be invlidated, so once pop frame and go to
landing_pad code section, verification will fail due to un-initialized
stack arguments.

>
>> +				verbose(env,
>> +					"cleanup landing pad calls subprog %d at insn %u, which can throw while an exception is in flight\n",
>> +					callee, j);
>> +				return -EINVAL;
>> +			}
>> +		}
> [ ... ]
>

