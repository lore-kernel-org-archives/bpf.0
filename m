Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9D27A123
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814975; cv=none; b=lK5AKMdfa6ve8OiJM+XfgP54DPJvOpC7bt4cruwK3kRTkBRyq/FzE48kczsMgGm1K9bHe8X1SNQ5aRjytrvlgl9XP7yW4HRWqpfRG0Dixp5HJGzPwiplHRgZ15uUBlI+dcQAoTh4deYtY5HCQuYCPSqoAR98nNCQcAz9zi5Jlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814975; c=relaxed/simple;
	bh=G9uKSTwxoGWpEAsNrrlhZxWkothi0XRl9IHardu3Hlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LisB3T+ImhLOxJ0SNR7wbDyuWLy7M7J9wc0oX4G33WwTj/WymC+J5O8JP9ki4jdRWrGs8hbvdCRj3ykvgClHGGC1DA6JdcEs37upHishZVWUYKGH3Xi6951f8sVNixBPyWd0gY8sLm670z+4bjN30Ghsi2IR178rI/VqsQtPeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ktuqwUtQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ktuqwUtQ"
Message-ID: <08436c41-f8ff-43ea-b0d5-f2a1dd3aff92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776814966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vfU6AkqOUlM9jy9wWSzTHP2vMaaDUKtlJSFbKJkQ08=;
	b=ktuqwUtQrNOaYMpYO9DGolIiqqfdZTI9KAl0Ptp3qipcazMwAiuie4O51GV+4L2kxs0rLD
	qknBhzPb4Ek1kSU1UYyHIIelL7xcU/cylpSe0njbPuVL/PoHGflt80Txb30Hr9RRMfxLby
	IK450gZq6I71fOa501wejAfj0DE7/sk=
Date: Tue, 21 Apr 2026 16:42:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/9] bpf: Refactor to avoid redundant calculation
 of bpf_reg_state
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421171947.3509118-1-yonghong.song@linux.dev>
 <CAMB2axNsVNX2hRp0wMJvSfhpryH-vEFB23ACk0x8T8hcFE7VdQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axNsVNX2hRp0wMJvSfhpryH-vEFB23ACk0x8T8hcFE7VdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 2:40 PM, Amery Hung wrote:
> On Tue, Apr 21, 2026 at 10:20 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> In many cases, once a bpf_reg_state is defined, it can pass to
>> callee's. Otherwise, callee will need to get bpf_reg_state again
>> based on regno. More importantly, this is needed for later stack
>> arguments for kfuncs since the register state for stack arguments does
>> not have a corresponding regno. So it makes sense to pass reg state
>> for callee's.
>>
>> The following is the only change to avoid compilation warning:
>>     static int sanitize_check_bounds(struct bpf_verifier_env *env,
>>                                     const struct bpf_insn *insn,
>>    -                                const struct bpf_reg_state *dst_reg)
>>    +                                struct bpf_reg_state *dst_reg)
>>
>> Acked-by: Puranjay Mohan <puranjay@kernel.org>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 213 ++++++++++++++++++------------------------
>>   1 file changed, 93 insertions(+), 120 deletions(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ed04fef49f6c..b56a11fc3856 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3929,13 +3929,13 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>   static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>                                       /* func where register points to */
>>                                       struct bpf_func_state *state,
>> -                                    int ptr_regno, int off, int size,
>> +                                    struct bpf_reg_state *ptr_reg, int off, int size,
>>                                       int value_regno, int insn_idx)
>>   {
> The comment needs to be updated.
>
>>          struct bpf_func_state *cur; /* state of the current function */
>>          int min_off, max_off;
>>          int i, err;
>> -       struct bpf_reg_state *ptr_reg = NULL, *value_reg = NULL;
>> +       struct bpf_reg_state *value_reg = NULL;
>>          struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
>>          bool writing_zero = false;
>>          /* set if the fact that we're writing a zero is used to let any
>> @@ -3944,7 +3944,6 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>          bool zero_used = false;
>>
>>          cur = env->cur_state->frame[env->cur_state->curframe];
>> -       ptr_reg = &cur->regs[ptr_regno];
>>          min_off = ptr_reg->smin_value + off;
>>          max_off = ptr_reg->smax_value + off + size;
>>          if (value_regno >= 0)
>> @@ -4241,7 +4240,7 @@ enum bpf_access_src {
>>          ACCESS_HELPER = 2,  /* the access is performed by a helper */
>>   };
>>
>> -static int check_stack_range_initialized(struct bpf_verifier_env *env,
>> +static int check_stack_range_initialized(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>>                                           int regno, int off, int access_size,
>>                                           bool zero_size_allowed,
>>                                           enum bpf_access_type type,
>> @@ -4265,18 +4264,16 @@ static struct bpf_reg_state *reg_state(struct bpf_verifier_env *env, int regno)
>>    * offset; for a fixed offset check_stack_read_fixed_off should be used
>>    * instead.
>>    */
> Same here
>
>> -static int check_stack_read_var_off(struct bpf_verifier_env *env,
>> +static int check_stack_read_var_off(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>>                                      int ptr_regno, int off, int size, int dst_regno)
>>   {
>> -       /* The state of the source register. */
>> -       struct bpf_reg_state *reg = reg_state(env, ptr_regno);
>>          struct bpf_func_state *ptr_state = bpf_func(env, reg);
>>          int err;
>>          int min_off, max_off;
>>
>>          /* Note that we pass a NULL meta, so raw access will not be permitted.
>>           */
>> -       err = check_stack_range_initialized(env, ptr_regno, off, size,
>> +       err = check_stack_range_initialized(env, reg, ptr_regno, off, size,
>>                                              false, BPF_READ, NULL);
>>          if (err)
>>                  return err;
>> @@ -4298,10 +4295,9 @@ static int check_stack_read_var_off(struct bpf_verifier_env *env,
>>    * can be -1, meaning that the read value is not going to a register.
>>    */
>>   static int check_stack_read(struct bpf_verifier_env *env,
>> -                           int ptr_regno, int off, int size,
>> +                           struct bpf_reg_state *reg, int ptr_regno, int off, int size,
>>                              int dst_regno)
>>   {
>> -       struct bpf_reg_state *reg = reg_state(env, ptr_regno);
>>          struct bpf_func_state *state = bpf_func(env, reg);
>>          int err;
>>          /* Some accesses are only permitted with a static offset. */
>> @@ -4337,7 +4333,7 @@ static int check_stack_read(struct bpf_verifier_env *env,
>>                   * than fixed offset ones. Note that dst_regno >= 0 on this
>>                   * branch.
>>                   */
>> -               err = check_stack_read_var_off(env, ptr_regno, off, size,
>> +               err = check_stack_read_var_off(env, reg, ptr_regno, off, size,
>>                                                 dst_regno);
>>          }
>>          return err;
>> @@ -4354,10 +4350,9 @@ static int check_stack_read(struct bpf_verifier_env *env,
>>    * The caller must ensure that the offset falls within the maximum stack size.
>>    */
> Ditto

Ack. Will fix all the above in comments.

>
>>   static int check_stack_write(struct bpf_verifier_env *env,
>> -                            int ptr_regno, int off, int size,
>> +                            struct bpf_reg_state *reg, int off, int size,
>>                               int value_regno, int insn_idx)
>>   {
>> -       struct bpf_reg_state *reg = reg_state(env, ptr_regno);
>>          struct bpf_func_state *state = bpf_func(env, reg);
>>          int err;
>>
>> @@ -4370,16 +4365,15 @@ static int check_stack_write(struct bpf_verifier_env *env,
>>                   * than fixed offset ones.
>>                   */
>>                  err = check_stack_write_var_off(env, state,
>> -                                               ptr_regno, off, size,
>> +                                               reg, off, size,
>>                                                  value_regno, insn_idx);
>>          }
>>          return err;
>>   }
>>
> Otherwise looks good to me.
>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>

