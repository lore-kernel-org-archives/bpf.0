Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E078241665
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776820839; cv=none; b=nJhc/Kf4JEcRwv85G6RqG9h40jk2yCYTiLRmIfblPM/gGivRAvAXhxSPVEzPk9Wyn8OUhDKpmZvQQ2K6aXr1IN150JG5ljrSmZU84w9bHPRUwP8YpY6dVI2koSxompn1hXf/l58NEp1QpRG+kU3VUHhcsNkmSB6bZFiqsVZtgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776820839; c=relaxed/simple;
	bh=i3iQkNr7b0mUyGEYrACqwWYhfSlWP5n+7O6iEIZ+QQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE4RIElDhw5TpO644XSeKuPxFcV44d7q7DDr6VTh4XVUjb2c/wmAkF1QcVU8xkKPU+o3dUYQOlflI4OTXuMPhuJLXDyjoiditsD+W0yvPLY8fr3VqWC0fi2KGKy5XQPXm47MmtqX1UNW6cZxddnJuf9/t0w+9oS6BJBAtfKySn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mlaDWCG6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mlaDWCG6"
Message-ID: <48627842-4916-4bab-a2ff-6eb83692d1da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776820836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6gpykNARuBChvI1oRQ5kcm8FsR3nKKfz4MUCbPRtWg=;
	b=mlaDWCG65GqjKVIh6/K+nR1fQ1VUW3GxOEz5Uyyq2fK4Z9+wBuBfUbg7B+zuAXl9GwwtmU
	7m/1dToSJFGLcEgmRC/F1XjH7eIK3MQ/toIdrJ5EFBoEmxiPgZeualYjxK+maxXFJezjQi
	Ya6Ei6qvqOaEZPigA/TDRepddix1WoE=
Date: Tue, 21 Apr 2026 18:20:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 7/9] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172002.3510514-1-yonghong.song@linux.dev>
 <DHZ6BHVW9CVO.1MNKDGSAXI76Z@gmail.com>
 <b9809b44-aef2-4ffc-945e-b5cac1dbdbbd@linux.dev>
 <DHZ9HV5M7UDQ.3U5A4J1VJ7H75@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DHZ9HV5M7UDQ.3U5A4J1VJ7H75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/21/26 5:37 PM, Alexei Starovoitov wrote:
> On Tue Apr 21, 2026 at 4:56 PM PDT, Yonghong Song wrote:
>>
>> On 4/21/26 3:07 PM, Alexei Starovoitov wrote:
>>> On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
>>>> This change prepares verifier log reporting for upcoming kfunc stack
>>>> argument support.
>>>>
>>>> Today verifier log code mostly assumes that an argument can be described
>>>> directly by a register number. That works for arguments passed in `R1`
>>>> to `R5`, but it does not work once kfunc arguments can also be
>>>> passed on the stack.
>>>>
>>>> Introduce an internal `argno` representation such that register-passed
>>>> arguments keep using their real register numbers, while stack-passed
>>>> arguments use an encoded value above a dedicated base.
>>>> `reg_arg_name()` converts this representation into either `R%d` or
>>>> `*(R11-off)` when emitting verifier logs. If a particular `argno`
>>>> is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
>>>> print `R%d`. Here R11 presents the base of stack arguments.
>>>>
>>>> This keeps existing logs readable for register arguments and allows the
>>>> same log sites to handle future stack arguments without open-coding
>>>> special cases.
>>>>
>>>> Update selftests accordingly.
>>>>
>>>> Acked-by: Puranjay Mohan <puranjay@kernel.org>
>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>> ---
>>>>    include/linux/bpf_verifier.h                  |   1 +
>>>>    kernel/bpf/verifier.c                         | 640 ++++++++++--------
>>>>    .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
>>>>    .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>>>>    .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
>>>>    .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>>>>    .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
>>>>    .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
>>>>    .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
>>>>    .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
>>>>    tools/testing/selftests/bpf/progs/irq.c       |   4 +-
>>>>    tools/testing/selftests/bpf/progs/iters.c     |   6 +-
>>>>    .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
>>>>    .../selftests/bpf/progs/iters_testmod.c       |   4 +-
>>>>    .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
>>>>    .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
>>>>    .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
>>>>    .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
>>>>    .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
>>>>    .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>>>>    .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
>>>>    .../selftests/bpf/progs/task_work_fail.c      |   6 +-
>>>>    .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
>>>>    .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
>>>>    .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
>>>>    .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
>>>>    .../bpf/progs/verifier_ref_tracking.c         |   6 +-
>>>>    .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>>>>    .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
>>>>    tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
>>>>    30 files changed, 464 insertions(+), 375 deletions(-)
>>>>
>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>>> index b148f816f25b..d5b4303315dd 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>>>    	 * e.g., in reg_type_str() to generate reg_type string
>>>>    	 */
>>>>    	char tmp_str_buf[TMP_STR_BUF_LEN];
>>>> +	char tmp_arg_name[32];
>>>>    	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>>>    	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>>>    	struct bpf_scc_callchain callchain_buf;
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 18ab92581452..82568a427211 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -1742,6 +1742,44 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
>>>>    	return &elem->st;
>>>>    }
>>>>    
>>>> +#define STACK_ARGNO_BASE 100
>>>> +
>>>> +static bool is_stack_argno(int argno)
>>>> +{
>>>> +	return argno > STACK_ARGNO_BASE;
>>>> +}
>>>> +
>>>> +/* arg starts at 1 */
>>>> +static u32 make_argno(u32 arg)
>>>> +{
>>>> +	if (arg <= MAX_BPF_FUNC_REG_ARGS)
>>>> +		return arg;
>>>> +	return STACK_ARGNO_BASE + arg;
>>>> +}
>>> You can remove this and simplify everything further by
>>>
>>> static bool is_stack_argno(int argno)
>>> {
>>> 	return argno > MAX_BPF_FUNC_REG_ARGS;
>>> }
>>>
>>>> +
>>>> +static u32 arg_from_argno(int argno)
>>>> +{
>>>> +	if (is_stack_argno(argno))
>>>> +		return argno - STACK_ARGNO_BASE;
>>>> +	return argno;
>>>> +}
>>> remove as well.
>>>
>>> and a comment like:
>>>
>>> /*
>>>    * switch (argno) {
>>>    * case 1: R1
>>>    * case 5: R5
>>>    * case 6: *(u64 *)(R11 +- 8)
>>>    * case 7: *(u64 *)(R11 +- 16)
>>>    */
>> This doesn't work. Let us see the following example:
>>
>> check_kfunc_args
>>     process_dynptr_func (argno)
>>       check_mem_access (argno, 4th argument)
>>         check_packet_access (argno)
>>           check_mem_region_access (argno)
>>             __check_mem_access (argno)
>>               <== verbose log with argno
>>
>> do_check
>>     do_check_insn (env)
>>       check_load_mem (insn)
>>         check_mem_access (insn->src_reg, 4th argument)
>>           check_packet_access (...)
>>             check_mem_region_access (...)
>>               __check_mem_access (insn->src_reg or argno)
> Ohh. Silent conversion. That's quite error prone.
>
> let's do
> typedef struct argno {
>      int argno;
> } argno_t;
>
> and make sure this callchain passes arg_t unmodified:
>
>      process_dynptr_func (argno)
>        check_mem_access (argno, 4th argument)
>          check_packet_access (argno) ...
>
> while here:
>
>        check_load_mem (insn)
>          check_mem_access (argno_from_reg(insn->src_reg), 4th argument)
>
> static argno_t argno_from_reg(u32 regno)
> {
>      return (argno_t){ .argno = regno };
> }
>
> static argno_t argno_from_arg(u32 arg)
> {
>      return (argno_t){ .argno = -arg };
> }
>
> static const char *reg_arg_name(struct bpf_verifier_env *env, argno_t argno)
>
> When positive vs negative is an internal implemenation of argno_t
> it's fine. It's better than shift by 100, but when negative was
> used as a signal everywhere it leaked details to caller.

This approach is kind of similar to what I proposed earlier with
an int variable, non-negative for reg and negative for arg (value -1/-2/...).
    https://lore.kernel.org/bpf/20260412045857.256260-1-yonghong.song@linux.dev/

But it is not explicit except the name 'reg_or_arg'.
Here, argno_t type makes it more explicit and should better.

For printing, I guess we still want to print 'R#' whenever possible
including positive registers and negative argno (1-5), and print
'*(R11-off)' for negative argno (6->...)?

