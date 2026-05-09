Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80918A92F
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778331951; cv=none; b=XeC43gxmci3afk8gm0Cy57HedPOZZDJdrxSTptYpX2DixgGUCWMP4BUzzSSwkyqr2yo/JWcUQHVMh2SeK0KKMuSeeCdTB31ePmCGMBp4tgEVzMqhvZ04mXW15ALpAQerDTDtOUa1cv30PNO+yK91Zijn1nV7YWm1INyDBGkxeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778331951; c=relaxed/simple;
	bh=5+JQX+Nx0S/0lvAldsxMOKhnVEpCTrRuQ44oVAMz+iQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyLeXCRRi3hueRWc7m+v3KFNhORHPQD1bwFBWjGd/AmjqvEHzHX2eXlh8D0UCs5w+2qNsev0JEPH87UO88AwAhw1YPUN90HMMFtwE00HRgDry7LHrLT9JGcaqn/vSYeBo5yscZHddvTuUe3obHeTl+djBihZspJI4nj8TcbucSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ak6C/7Fq; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ak6C/7Fq"
Message-ID: <ab015da5-86ef-40f9-b696-c17154c8375b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778331947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rdkSLsWTJXVnDJIQSiC1LjWIPQkohQyMBBOQAJzvjvU=;
	b=Ak6C/7Fq2CDm+jcIypWtsViVYOZm2ASoeDzD/z1a8jDGBnUDWj7ERxd0iu9wbZFJsv6wfx
	V/S6yP51xixwPm0JmBhbCiluOMuwGwJyNsDxXDORkJaYYaCok9bBpKCufzkWQIKTaWiZfS
	SMHhsJHbfo1rESusJaVylby80jCT2mU=
Date: Sat, 9 May 2026 14:05:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 04/23] bpf: Set sub->arg_cnt earlier in
 btf_prepare_func_args()
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260507213003.1125144-1-yonghong.song@linux.dev>
 <25d29e25e7715da21371ee7d4a7b5445cd8c8eca4dad9ff2d3e34d39fb68c906@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <25d29e25e7715da21371ee7d4a7b5445cd8c8eca4dad9ff2d3e34d39fb68c906@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/7/26 12:11 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 77af44d8a3ad..a33a5b4122f8 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -7880,6 +7880,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   	}
>>   	args = (const struct btf_param *)(t + 1);
>>   	nargs = btf_type_vlen(t);
>> +	sub->arg_cnt = nargs;
>>   	if (nargs > MAX_BPF_FUNC_REG_ARGS) {
>>   		if (!is_global)
>>   			return -EINVAL;
>> @@ -8067,7 +8068,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>>   		return -EINVAL;
>>   	}
>>
>> -	sub->arg_cnt = nargs;
>>   	sub->args_cached = true;
>>
>>   	return 0;
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.

sub->arg_cnt is used in two places:

First, function btf_check_func_arg_match():

static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
                                     const struct btf *btf,
                                     struct bpf_reg_state *regs)
{
         struct bpf_subprog_info *sub = subprog_info(env, subprog);
         struct bpf_func_state *caller = cur_func(env);
         struct bpf_verifier_log *log = &env->log;
         u32 i;
         int ret;

         ret = btf_prepare_func_args(env, subprog);
         if (ret)
                 return ret;

         ret = check_outgoing_stack_args(env, caller, sub->arg_cnt);
         if (ret)
                 return ret;

         /* check that BTF function arguments match actual types that the
          * verifier sees.
          */
         for (i = 0; i < sub->arg_cnt; i++) {
		...
	}
	...
}

In this case, btf_prepare_func_args return failure and sub->arg_cnt will
not be used any more. So for this case, the patch won't make a difference.

Second, function do_check_common():

         if (subprog || env->prog->type == BPF_PROG_TYPE_EXT) {
                 const char *sub_name = subprog_name(env, subprog);
                 struct bpf_subprog_arg_info *arg;
                 struct bpf_reg_state *reg;

                 if (env->log.level & BPF_LOG_LEVEL)
                         verbose(env, "Validating %s() func#%d...\n", sub_name, subprog);
                 ret = btf_prepare_func_args(env, subprog);
                 if (ret)
                         goto out;

                 if (subprog_is_exc_cb(env, subprog)) {
                         state->frame[0]->in_exception_callback_fn = true;
                 
                         /*
                          * Global functions are scalar or void, make sure
                          * we return a scalar.
                          * we return a scalar.
                          */
                         if (subprog_returns_void(env, subprog)) {
                                 verbose(env, "exception cb cannot return void\n");
                                 ret = -EINVAL;
                                 goto out;
                         }

                         /* Also ensure the callback only has a single scalar argument. */
                         if (sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_ANYTHING) {
                                 verbose(env, "exception cb only supports single integer argument\n");
                                 ret = -EINVAL;
                                 goto out;
                         }
                 }
                 for (i = BPF_REG_1; i <= min_t(u32, sub->arg_cnt, MAX_BPF_FUNC_REG_ARGS); i++) {
                         arg = &sub->args[i - BPF_REG_1];
                         reg = &regs[i];

                         if (arg->arg_type == ARG_PTR_TO_CTX) {
                                 reg->type = PTR_TO_CTX;
                                 mark_reg_known_zero(env, regs, i);
                         } else if (arg->arg_type == ARG_ANYTHING) {
                                 reg->type = SCALAR_VALUE;
                                 mark_reg_unknown(env, regs, i);
                         } else if (arg->arg_type == ARG_PTR_TO_DYNPTR) {
                                 /* assume unspecial LOCAL dynptr type */
                                 __mark_dynptr_reg(reg, BPF_DYNPTR_TYPE_LOCAL, true, ++env->id_gen);
                         } else if (base_type(arg->arg_type) == ARG_PTR_TO_MEM) {
                                 reg->type = PTR_TO_MEM;
                                 reg->type |= arg->arg_type &
                                              (PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_RDONLY);
                                 mark_reg_known_zero(env, regs, i);
                                 reg->mem_size = arg->mem_size;
                                 if (arg->arg_type & PTR_MAYBE_NULL)
                                         reg->id = ++env->id_gen;
                         } else if (base_type(arg->arg_type) == ARG_PTR_TO_BTF_ID) {
                                 reg->type = PTR_TO_BTF_ID;
                                 if (arg->arg_type & PTR_MAYBE_NULL)
                                         reg->type |= PTR_MAYBE_NULL;
                                 if (arg->arg_type & PTR_UNTRUSTED)
                                         reg->type |= PTR_UNTRUSTED;
                                 if (arg->arg_type & PTR_TRUSTED)
                                         reg->type |= PTR_TRUSTED;
                                 mark_reg_known_zero(env, regs, i);
                                 reg->btf = bpf_get_btf_vmlinux(); /* can't fail at this point */
                                 reg->btf_id = arg->btf_id;
                                 reg->id = ++env->id_gen;
                         } else if (base_type(arg->arg_type) == ARG_PTR_TO_ARENA) {
                                 /* caller can pass either PTR_TO_ARENA or SCALAR */
                                 mark_reg_unknown(env, regs, i);
                         } else {
                                 verifier_bug(env, "unhandled arg#%d type %d",
                                              i - BPF_REG_1 + 1, arg->arg_type);
                                 ret = -EFAULT;
                                 goto out;
                         }
                 }
                 if (env->prog->type == BPF_PROG_TYPE_EXT && sub->arg_cnt > MAX_BPF_FUNC_REG_ARGS) {
                         verbose(env, "freplace programs with >%d args not supported yet\n",
                                 MAX_BPF_FUNC_REG_ARGS);
                         ret = -EINVAL;
                         goto out;
                 }
         } else {
                 /* if main BPF program has associated BTF info, validate that
                  * it's matching expected signature, and otherwise mark BTF
                  * info for main program as unreliable
                  */
                 if (env->prog->aux->func_info_aux) {
                         ret = btf_prepare_func_args(env, 0);
                         if (ret || sub->arg_cnt != 1 || sub->args[0].arg_type != ARG_PTR_TO_CTX)
                                 env->prog->aux->func_info_aux[0].unreliable = true;
                 }

                 /* 1st arg to a function */
                 regs[BPF_REG_1].type = PTR_TO_CTX;
                 mark_reg_known_zero(env, regs, BPF_REG_1);
         }

For the then brach of 'if (subprog || env->prog->type == BPF_PROG_TYPE_EXT)',
if btf_prepare_func_args() fails, the error will return.

But the else branch of 'if (subprog || env->prog->type == BPF_PROG_TYPE_EXT)',
if btf_prepare_func_args() fails, the verification will still continue.
So it makes sense to get sub->arg_cnt earlier in btf_prepare_func_args()
since sub->arg_cnt is needed later on.

> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25523765323

