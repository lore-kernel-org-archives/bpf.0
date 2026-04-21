Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956A273F9
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 04:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776744385; cv=none; b=Z6Bd90+aHFk5cvMN5zrg3mh/dXRr/6Zg0oPvMl+01Ic5Ed+sG0xPk7GXzET9x6DsecVm90ji6d2tiS5XUajq/JzYCe3rIGgzo9V3p+KBtcYmtD3THRggDWMWxgnBT2ELTJscuMNspSXFCNZTJfrmk1tbH9Cr/3GQpWWUuJwN6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776744385; c=relaxed/simple;
	bh=1BLw/UOF2pBPvH7rPzMM1PF1czzGJZxrCzw5byVJtk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nl5548Q7q4YrT0aZGn79DtVhk76Og8z+c7Lz4hj0PJmuqe99ay7RdDj/yxTN5bWCDDvmBgJDKfo5m55mj1mOvfo7IwryGIYiGKRgpl3fq6nYI5CyP5lUyB3mjdNDAVI8kRTpYcCi9OQCbQ+oHaOLJeyiwSgoqrvWEOZ/JXM+Krc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sVr3Wsxx; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sVr3Wsxx"
Message-ID: <c32885d2-28d4-4d3f-aa53-18d9643bd800@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776744382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uiU560LowgKOvMaVlPmJy8huzoZVmjO6O6gU/GE1hE=;
	b=sVr3Wsxx/E7flAkjF1CsRBPZdWNYHLsrgFjHJZh0oh93e/l8RBAAmQaIm4rEafaRj1WPWg
	GtvPVjrW3RATQ9OGiBSA/nxszJd3RZqPi07sSrXdKe5RUGCK/lVphnLgPodb4zwZ1mKOsm
	NvkgG8GHpj2exDwoO3RWS5UxQGFvnBY=
Date: Mon, 20 Apr 2026 21:06:14 -0700
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

Okay.

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

Sure. Will try to simplify things...

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

Okay.

