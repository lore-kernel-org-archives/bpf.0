Received: from mta0.migadu.com (out-239.mta0.migadu.com [91.218.175.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2508F3C1F4F
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790048705; cv=none; b=rKJ50NTxba1laghLx1xvC7BhZgPcORbiafeFoEVM6NuRHqz7P2SWXRPdh0xLVqbsxHoA/20T1c8993cDaAjDjAf5tN9/M885CzPebELp+P5TNxIcYiXOVvGkMGKSFfNbi/wTc/lMN4DcTgXn6xo8NeU+GWGlzrHw+dkYOp2cUHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790048705; c=relaxed/simple;
	bh=yxYiS9qInZpkjPTqv7yFfiQsK3nk+l1f189X+e0XLwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=by+oDIGXcXoO75Y8Hui1vqd3Ne/Cu1Hf+IVqKofr+42uz47lfhXLcQgLs1tePN8D3C5bOBauiVcfsvkMG82Zi7jEKSP3GYe/k9D2Wo+y8iY+usW9ZRy4q8BMyH3cAJRXuUq/dk7KAZR/ScRQRPohJkIqGvLxCmTZv5wti/ADPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p55HFQXb; arc=none smtp.client-ip=91.218.175.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p55HFQXb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yxYiS9qInZpkjPTqv7yFfiQsK3nk+l1f189X+e0XLwQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790048700; v=1; x=1790653500;
 b=p55HFQXbiUaVOY9FUk+bMfx4B7ldnUsJVwiDInKS0REH9llhvsx/8Ax8P/kLqt5ZXWMSms/e
 1sTljQ54LPpbAX3qxws8aruSX6YmJB6B8KIXPgwrpxeTwKuUfBeTcjg4kt50DLocju73CrDg8R6
 NNRmJtgdzcIQwlTP85Kl9lfs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id daa0abb66b89ed79;
	Tue, 22 Sep 2026 03:45:00 +0000
X-Mizu-Trace-ID: daa0abb66b89ed79
X-Migadu-Flow: FLOW_OUT
Message-ID: <f4636777-3792-4897-9e1c-6ed74cdc85ed@linux.dev>
Date: Mon, 21 Sep 2026 20:44:55 -0700
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
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org,
 mason@kernel.org, ihor.solodrai@linux.dev
References: <20260921210109.1719713-1-yonghong.song@linux.dev>
 <8e41c978495f9f21b81d1dcb6815e1ab5ba4a1485e544715e9baa1815eb64b82@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <8e41c978495f9f21b81d1dcb6815e1ab5ba4a1485e544715e9baa1815eb64b82@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/26 2:56 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
>> index 67af78baa558..da8fa6eb7e4b 100644
>> --- a/kernel/bpf/exception.c
>> +++ b/kernel/bpf/exception.c
>> @@ -3,12 +3,24 @@
>>   #include <linux/bpf.h>
>>   #include <linux/bpf_verifier.h>
>>   #include <linux/btf.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/filter.h>
>>   #include <linux/slab.h>
>> +#include <linux/sort.h>
> This isn't a bug, but is <linux/sort.h> used by anything in this patch,
> or would it sit better in the later patch that adds the sort() call?
>
> A scan of exception.c and exception.h at this commit finds no sort(),
> sort_r(), cmp_func_t, cmp_r_func_t or swap_func_t. The first sort() call
> in the file arrives three commits later, in 07c93d6858af ("bpf: Dispatch
> exception cleanup pads from bpf_throw()"), which adds sort(at, cnt,
> sizeof(*at), cmp_u32, NULL) without needing to touch the include block
> because this patch already added the header.

Okay, will do. But I will try Eduard's suggestion to see whether
this is necessary.

>
> [ ... ]
>
>> @@ -29,12 +154,260 @@ static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
>> +static int cleanup_mark_pad_bodies(struct cleanup_ctx *ctx)
>> +{
>> +	struct bpf_verifier_env *env = ctx->env;
>> +	u32 i, sp = 0;
>> +	int ret;
>> +
>> +	for (i = 0; i < env->cleanup_info_cnt; i++) {
>> +		u32 pad = env->cleanup_info[i].landing_pad_off;
>> +
>> +		if (in_pad(env, pad))
>> +			continue;
>> +
>> +		ret = cleanup_pad_is_catch(ctx, pad);
>> +		if (ret < 0)
>> +			return ret;
>> +		if (ret) {
>> +			verbose(env,
>> +				"catch landing pad %u is not supported yet, only cleanup pads that resume\n",
>> +				pad);
>> +			return -EOPNOTSUPP;
>> +		}
>> +		env->insn_aux_data[pad].in_cleanup_pad = true;
>> +		ctx->stack[sp++] = pad;
>> +	}
>> +
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
> This isn't a bug, but the comment credits the wrong verifier pass.
>
> check_subprogs() (kernel/bpf/verifier.c:3081-3146) does not register or
> validate call targets at all - it explicitly skips them:
>
>      if (BPF_OP(code) == BPF_CALL)
>              goto next;
>
> Its only jobs are setting has_tail_call/has_ld_abs/exit_idx and checking
> that jump targets stay inside the containing subprog. The guarantee the
> comment is reaching for actually comes from add_subprogs()
> (verifier.c:2985-3053), which does
>
>      ret = add_subprog(env, i + insn->imm + 1);
>
> for every bpf_pseudo_call() insn, with add_subprog() rejecting off < 0 ||
> off >= insn_cnt. That is what makes cleanup_subprog_of() unable to return
> -1 here, so the code is correct - only the comment is wrong.
>
> A reader who follows the comment to check_subprogs() finds the opposite of
> what it claims, which is worse than no comment, since this is the
> documented reason an array index is left unchecked. Could the comment say
> "add_subprogs() registered every call target" instead?

Sure, we can do.

>
>> +
>> +			if (env->subprog_info[callee].might_throw) {
>> +				verbose(env,
>> +					"cleanup landing pad calls subprog %d at insn %u, which can throw while an exception is in flight\n",
>> +					callee, j);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +
>> +		if (next >= 0 && !in_pad(env, next)) {
>> +			env->insn_aux_data[next].in_cleanup_pad = true;
>> +			ctx->stack[sp++] = next;
>> +		}
>> +		if (target >= 0 && !in_pad(env, target)) {
>> +			env->insn_aux_data[target].in_cleanup_pad = true;
>> +			ctx->stack[sp++] = target;
>> +		}
>> +	}
>> +	return 0;
>> +}
> [ ... ]
>
>> @@ -154,12 +448,43 @@ int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
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
>> +			verbose(env,
>> +				"insn %u passes an on-stack call argument in an exception cleanup landing pad\n",
>> +				i);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	return 0;
>> +}
> This isn't a bug, but would it be clearer to funnel both on-stack-argument
> branches through a single labelled exit, or to differentiate the two
> messages (e.g. mention the kfunc argument spill in the second one) so the
> log says which shape was rejected?

I think it is okay.

>
> Because the two messages are identical, the log does not distinguish which
> of the two shapes was rejected, and a future edit to the wording has to be
> applied in both places.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35656368472

