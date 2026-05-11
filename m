Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2136D3D6479
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519976; cv=none; b=Q57r1BzYhSwmp+5Zwq+kGrso3utWI6NZr9D/Hp4uyxlg0xpCtyBftaUFsB/jHJg11dqi+AHW+FHN5SNdn+3Hmf4lnrvrUif48ALYuLiVAN1WTOvFNWdLcc2VqwQyQUapupT1CvX1/4ykshsEACOVjc2XwofUPHcfCVK6ByqiUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519976; c=relaxed/simple;
	bh=v5jA8CMZnjGitxPwZyztDmF76oyavDh/d6Z4vfQ1VLk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qinAn+x+9Q+vFXxWIAXir2hRx46ab2xpQYvnWMP2L6nWUdJ0J7DpC6NQ3siCu42eZIxwrAG+YKqoQJcRki37/NcLhdbsIzHiZ8/tGl1uJ05KzrDFAt8O3e+XBlWp9sKlUPHpRwyaIucwaTm/Wc1tKeKMYPPty5vfrtgPDYDuG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r2kuQ8T8; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r2kuQ8T8"
Message-ID: <c22a8082-2ac3-453c-90bc-b685b847e1ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778519972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2zGM5E6vu4PRLShnIzrypWaE5YZtbhfX8lsiBJnyq8=;
	b=r2kuQ8T8Uwp7N1ZrEetYk4pTSgdmprsFQ32HOj3MRJSe8tCaC7QahprqN3PmNEA5tIRKdH
	sXQR40k6esDv0vfJgoVq8hTe78SX/U0pTbpzRomdcW+OdBMwu1xSZLY7oCE1VHVfaPXJqb
	TtuwmKAnoPp6qsP8qfaBAgkVMbOI/6w=
Date: Mon, 11 May 2026 10:18:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 04/24] bpf: Set sub->arg_cnt earlier in
 btf_prepare_func_args()
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260511053322.1883474-1-yonghong.song@linux.dev>
 <9807060ec039594f53533aceaf5808b667bbceed625575fa146871e3a05a4634@mail.kernel.org>
 <d84a5f9b-f7be-43b8-9c1c-a452c8318d46@linux.dev>
In-Reply-To: <d84a5f9b-f7be-43b8-9c1c-a452c8318d46@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/11/26 6:29 PM, Yonghong Song wrote:
>
>
> On 5/11/26 8:19 AM, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 77af44d8a3ad..a33a5b4122f8 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -7880,6 +7880,7 @@ int btf_prepare_func_args(struct 
>>> bpf_verifier_env *env, int subprog)
>>>       }
>>>       args = (const struct btf_param *)(t + 1);
>>>       nargs = btf_type_vlen(t);
>>> +    sub->arg_cnt = nargs;
>>>       if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>>>           if (!is_global)
>>>               return -EINVAL;
>>> @@ -8067,7 +8068,6 @@ int btf_prepare_func_args(struct 
>>> bpf_verifier_env *env, int subprog)
>>>           return -EINVAL;
>>>       }
>>>
>>> -    sub->arg_cnt = nargs;
>>>       sub->args_cached = true;
>>>
>>>       return 0;
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's 
>> not a bug.
>
> In v3, for the *main* program, we have the following:
>
>                 /* if main BPF program has associated BTF info, 
> validate that
>                  * it's matching expected signature, and otherwise 
> mark BTF
>                  * info for main program as unreliable
>                  */
>                 if (env->prog->aux->func_info_aux) {
>                         ret = btf_prepare_func_args(env, 0);
>                         if (ret || sub->arg_cnt != 1 || 
> sub->args[0].arg_type != ARG_PTR_TO_CTX) {
> env->prog->aux->func_info_aux[0].unreliable = true;
>                                 sub->arg_cnt = 1;
>                                 sub->stack_arg_cnt = 0;
>                         }
>                 }
>
> Since sub->arg_cnt and sub->stack_arg_cnt is set here for the main 
> program,
> patch #4 is not needed any more.

Okay, actually, this patch still needed.

In function btf_check_func_arg_match(), we have

         ret = btf_prepare_func_args(env, subprog);
         if (ret)
                 return ret;

and its caller:

static int btf_check_subprog_call(struct bpf_verifier_env *env, int subprog,
                                   struct bpf_reg_state *regs)
{
         struct bpf_prog *prog = env->prog;
         struct btf *btf = prog->aux->btf;
         u32 btf_id;
         int err;
         
         if (!prog->aux->func_info)
                 return -EINVAL;
         
         btf_id = prog->aux->func_info[subprog].type_id;
         if (!btf_id)
                 return -EFAULT;
         
         if (prog->aux->func_info_aux[subprog].unreliable)
                 return -EINVAL;

         err = btf_check_func_arg_match(env, subprog, btf, regs);
         /* Compiler optimizations can remove arguments from static functions
          * or mismatched type can be passed into a global function.
          * In such cases mark the function as unreliable from BTF point of view.
          */
         if (err)
                 prog->aux->func_info_aux[subprog].unreliable = true;
         return err;
}

static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
                               int insn_idx, int subprog,
                               set_callee_state_fn set_callee_state_cb)
{
         struct bpf_verifier_state *state = env->cur_state, *callback_state;
         struct bpf_func_state *caller, *callee;
         int err;

         caller = state->frame[state->curframe];
         err = btf_check_subprog_call(env, subprog, caller->regs);
         if (err == -EFAULT)
                 return err;

         /* set_callee_state is used for direct subprog calls, but we are
          * interested in validating only BPF helpers that can call subprogs as
          * callbacks
          */
         env->subprog_info[subprog].is_cb = true;

	...
}

So in this case, we still need sub->arg_cnt is set earlier so
it can be used to checking incoming argument cnt.


>
>
>> See: 
>> https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: 
>> https://github.com/kernel-patches/bpf/actions/runs/25652623893
>
>

