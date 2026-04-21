Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12B327FB0E
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751680; cv=none; b=Udrn0BHCqOBH2asuEkOX1rglduWpVx3yrU+m/ey8D8t4kdwghnVJ083VduK9WAg2ZhWr69h8NuyshXnjTVcq2wIOf7nANIb7td3ayPfxoOkgZamwnynZIAF+/nTdkISQ8XA+i2JP+W6e9GvcuhmV6lqPy6XCsllaUuexu++OgV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751680; c=relaxed/simple;
	bh=vAu5e88cOSMLLCB5Jz8IkVoYXVx5krPpPw/ky2DgDsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le6IQMnGLFc8CqSdDCcdzEcHES7bPEhfxEJPk7JeMjwOSqbyaiZe/6vGkpH+4/n583QCOGfTEELgwZx1REPe9z3Fb4+fOUU8smr+IIuo5hIUUI9ib088c3IjG2EyPZx7PswW6l8CcrZeCjNRx/mWGh4ed+BBwpqXyrQHSiIl33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=innlbLo7; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="innlbLo7"
Message-ID: <2259b511-ca71-46a5-a416-8ea6ff0785b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776751675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ggHNtOXxApQi73zH8Y9lEl/96x78N2hft4uFDTyGIPQ=;
	b=innlbLo7yXixPaEWF9TxS1OPFp/WbO8UoT3WsbmiaH24MaVuWYe+6Zs7BNOW5mVKj0I1cG
	d14RUYt1J5tKgnpkWwsg6X1IuXqqw60MDCu9XxG52+EHEHhtJQNIw7JDShJe74LknSyQ/q
	qArR1L89/Zu3g8gyrc/iJ7ituLX05MA=
Date: Mon, 20 Apr 2026 23:07:45 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 04/17] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163336.733654-1-yonghong.song@linux.dev>
 <DHYE574ZW4D7.2RNZPHN9QHT8@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHYE574ZW4D7.2RNZPHN9QHT8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/20/26 5:03 PM, Alexei Starovoitov wrote:
> On Sun Apr 19, 2026 at 9:33 AM PDT, Yonghong Song wrote:
>> This change prepares verifier log reporting for upcoming kfunc stack
>> argument support.
>>
>> Today verifier log code mostly assumes that an argument can be described
>> directly by a register number. That works for arguments passed in `R1`
>> to `R5`, but it does not work once kfunc arguments can also be
>> passed on the stack.
>>
>> Introduce an internal `argno` representation such that register-passed
>> arguments keep using their real register numbers, while stack-passed
>> arguments use an encoded value above a dedicated base.
>> `reg_arg_name()` converts this representation into either `R%d` or
>> `*(R11-off)` when emitting verifier logs. If a particular `argno`
>> is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
>> print `R%d`. Here R11 presents the base of stack arguments.
>>
>> This keeps existing logs readable for register arguments and allows the
>> same log sites to handle future stack arguments without open-coding
>> special cases.
>>
>> Update selftests accordingly.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf_verifier.h                  |   1 +
>>   kernel/bpf/verifier.c                         | 649 ++++++++++--------
>>   .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
>>   .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>>   .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
>>   .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>>   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
>>   .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
>>   .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
>>   .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
>>   tools/testing/selftests/bpf/progs/irq.c       |   4 +-
>>   tools/testing/selftests/bpf/progs/iters.c     |   6 +-
>>   .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
>>   .../selftests/bpf/progs/iters_testmod.c       |   4 +-
>>   .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
>>   .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
>>   .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
>>   .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
>>   .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
>>   .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>>   .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
>>   .../selftests/bpf/progs/task_work_fail.c      |   6 +-
>>   .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
>>   .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
>>   .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
>>   .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
>>   .../bpf/progs/verifier_ref_tracking.c         |   6 +-
>>   .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>>   .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
>>   tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
>>   30 files changed, 474 insertions(+), 374 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index b148f816f25b..9fbbddc40d21 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>   	 * e.g., in reg_type_str() to generate reg_type string
>>   	 */
>>   	char tmp_str_buf[TMP_STR_BUF_LEN];
>> +	char tmp_reg_arg_name_buf[32];
> the name is too long.
> Just tmp_arg_name ?
>
>>   	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>   	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>   	struct bpf_scc_callchain callchain_buf;
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 3716d9688d00..6aa4dc161a56 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1751,6 +1751,55 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
>>   	return &elem->st;
>>   }
>>   
>> +/*
>> + * Unified argument number encoding for verifier log messages.
>> + * Register args (arg_idx 0-4) use their register number (R1-R5).
>> + * Stack args (arg_idx 5+) are encoded as STACK_ARGNO_BASE + arg_idx
>> + * to avoid collision with register numbers. reg_arg_name() decodes
>> + * this back to a human-readable string like "*(R11-8)" for logs.
>> + */
>> +#define STACK_ARGNO_BASE 100
>> +
>> +static bool is_stack_argno(int argno)
>> +{
>> +	return argno >= STACK_ARGNO_BASE;
>> +}
>> +
>> +static u32 make_argno(u32 arg_idx)
>> +{
>> +	if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
>> +		return BPF_REG_1 + arg_idx;
>> +	return STACK_ARGNO_BASE + arg_idx;
>> +}
>> +
>> +static u32 arg_idx_from_argno(int argno)
>> +{
>> +	if (is_stack_argno(argno))
>> +		return argno - STACK_ARGNO_BASE;
>> +	return argno - BPF_REG_1;
>> +}
>> +
>> +static int next_argno(int argno)
>> +{
>> +	return make_argno(arg_idx_from_argno(argno) + 1);
>> +}
> I don't like this +1, -1 dance all around. Makes the whole thing
> hard to follow.
> Keep argno starting at 1. So old regno == argno.

The above make_argno() returns an argno having regno == argno
for regno 1-5.

I think we do not need next_argno(). It is a special case for
KF_ARG_PTR_TO_MEM_SIZE. We can do something like
make_argno(i) and maek_argno(i + 1) for current and next argno.

>
>>   		/* Check if local kptr in src arg matches kptr in dst arg */
>> -		if (meta->func_id == BPF_FUNC_kptr_xchg && regno == BPF_REG_2) {
>> -			if (map_kptr_match_type(env, meta->kptr_field, reg, regno))
>> +		if (meta->func_id == BPF_FUNC_kptr_xchg &&
>> +		    !is_stack_argno(argno) && argno == BPF_REG_2) {
>> +			if (map_kptr_match_type(env, meta->kptr_field, reg, argno))
> And then this argno == BPF_REG_2 will look fine.
> With argno base 0 the above looks broken.
> Also is_stack_argno() looks like defensive programming. remove it.
>

