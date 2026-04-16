Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512E73BA248
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350370; cv=none; b=ayTTqHQR45aI5dnEQU5HhQGsdiP+5yIPVtQzrmaToMHBtBxIUi5VD/2OA3hSPXphqAvHHFCHuyZenaZ0eU6SMYS8ipeCq5flR7rOOYkk9CyXmfTpE01U2mSuCgLB2qd1P9hJc27yavxlKvcv9yAc6R+Z06rfmKddhhnr1JUt4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350370; c=relaxed/simple;
	bh=0n3TgSeJpuxnKqt4AwYtkRLrUV2c3rn39UVb/oC8Cl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/yCabHR7x7ncESKNJTXzYNH6z3IP+aIyyQSwAsjnK6zdgbHXXO+MJjEdhC5C9mJy+tEOB6aEvN2cl3IikN0R3wAC0KOmS6katzLZeYpgMoB9TY3oGPHJRVOLHLLsSdI2VZtyGblbO5FRJNbs3Q7XhiNINHRo6YjfWvS8uZ9YbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QkZ55DIK; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QkZ55DIK"
Message-ID: <b144edf8-ad46-4382-8563-4fd90ac5b2c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776350366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wgCGnxAM0ScScvqyD1+YA0QNPU2ULs2COW80gUR6oaE=;
	b=QkZ55DIKqU2sdLMx2eqMSDl6M3UW5WMxejbAVe3pKWJV5Kx2uoMRyKE9/liAXcEO70adQt
	i2p2iVmnmihgLK+E9Jt0p7PT9fnRvswWLHHx6Zq2B789XzWS3i7EUxZtKq5AykH7habdbE
	4QPpQtdBY1VNs1nkWKgwf2MrrwMIjqQ=
Date: Thu, 16 Apr 2026 07:39:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 06/18] bpf: Use argument index instead of
 register index in kfunc verifier logs
Content-Language: en-GB
To: Amery Hung <ameryhung@meta.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
 <20260412045857.256260-1-yonghong.song@linux.dev>
 <CAADnVQ+0JgQDosS5=+h=mUJM_Dn=bK-XBpiq1LfamUHTSTOEZA@mail.gmail.com>
 <CAP17u3PdGDRfE09g7rDqTaMZG_Q_Py1zVb3xKaVQUccUMVN5zw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAP17u3PdGDRfE09g7rDqTaMZG_Q_Py1zVb3xKaVQUccUMVN5zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/15/26 4:23 PM, Amery Hung wrote:
> On Sun, Apr 12, 2026 at 3:01 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Sat, Apr 11, 2026 at 9:59 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> For kfunc argument checking, use the argument index (arg#0, arg#1, ...)
>>> instead of the register index (R1, R2, ...) in verifier log messages.
>>> This is a preparation for future stack-based arguments where kfuncs can
>>> accept more than 5 arguments. Stack arguments won't have a corresponding
>>> register, so using argument index is more appropriate.
>>>
>>> Since some functions like check_mem_access(), check_stack_read_var_off(),
>>> and check_stack_range_initialized() are shared between kfunc argument
>>> checking (check_kfunc_args) and other paths (check_func_arg, do_check_insn, ...),
>>> introduce a `reg_or_arg` encoding: a non-negative value represents a register
>>> index, while a negative value encodes an argument index as -(argno + 1).
>>> The helper reg_arg_name() decodes this to produce either "R%d" or
>>> "arg#%d" for log messages.
>>>
>>> For check_func_arg() callers, in certain cases, the register index is
>>> preserved so existing helper function logs remain unchanged (e.g., "R1", "R2").
>>>
>>> Update selftests to expect the new "arg#N" format in kfunc error
>>> messages.
>>>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/linux/bpf_verifier.h                  |   1 +
>>>   kernel/bpf/verifier.c                         | 466 +++++++++---------
>>>   .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>>>   .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>>>   .../selftests/bpf/progs/cpumask_failure.c     |   4 +-
>>>   .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
>>>   .../selftests/bpf/progs/iters_testmod.c       |   6 +-
>>>   .../bpf/progs/local_kptr_stash_fail.c         |   2 +-
>>>   .../selftests/bpf/progs/map_kptr_fail.c       |   4 +-
>>>   .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
>>>   .../bpf/progs/nested_trust_failure.c          |   2 +-
>>>   .../selftests/bpf/progs/res_spin_lock_fail.c  |   2 +-
>>>   .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>>>   .../selftests/bpf/progs/task_kfunc_failure.c  |   4 +-
>>>   .../bpf/progs/verifier_cgroup_storage.c       |   4 +-
>>>   .../selftests/bpf/progs/verifier_ctx.c        |   2 +-
>>>   .../bpf/progs/verifier_ref_tracking.c         |   2 +-
>>>   .../selftests/bpf/progs/verifier_sock.c       |   6 +-
>>>   .../selftests/bpf/progs/verifier_unpriv.c     |   4 +-
>>>   .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>>>   .../testing/selftests/bpf/progs/wq_failures.c |   4 +-
>>>   tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
>>>   .../testing/selftests/bpf/verifier/map_kptr.c |  10 +-
>>>   23 files changed, 286 insertions(+), 267 deletions(-)
>>>
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>>> index 05b9fe98b8f8..291f11ddd176 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -910,6 +910,7 @@ struct bpf_verifier_env {
>>>           * e.g., in reg_type_str() to generate reg_type string
>>>           */
>>>          char tmp_str_buf[TMP_STR_BUF_LEN];
>>> +       char tmp_reg_arg_name_buf[16];
>>>          struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>>          struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>>          struct bpf_scc_callchain callchain_buf;
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 54296d818d35..01df990f841a 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -2179,6 +2179,18 @@ static struct bpf_verifier_state *push_stack(struct bpf_verifier_env *env,
>>>          return &elem->st;
>>>   }
>>>
>>> +static const char *reg_arg_name(struct bpf_verifier_env *env, int reg_or_arg)
>>> +{
>>> +       char *buf = env->tmp_reg_arg_name_buf;
>>> +       int len = sizeof(env->tmp_reg_arg_name_buf);
>>> +
>>> +       if (reg_or_arg >= 0)
>>> +               snprintf(buf, len, "R%d", reg_or_arg);
>>> +       else
>>> +               snprintf(buf, len, "arg#%d", -(reg_or_arg + 1));
>>> +       return buf;
>>> +}
>> The patches 1-4 make sense, but 5, 6 are too hacky.
>>
>> -       { "incorrect_head_var_off1", "R1 doesn't have constant offset" },
>> +       { "incorrect_head_var_off1", "arg#0 doesn't have constant offset" },
>>
>> This just sucks.
>> It degrades output for no good reason.
>>
>> Instead of inband negative vs positive signalling rename all
>> 'regno' to 'argno' and always pass whatever argno you need 1,2,..5,6, etc
> +1 to avoid using a negative/positive range to signal a stack argument
> or not, and to eliminate passing regno/argno.

This is what I plan to do.

>
>> Pass ptr_reg and size_reg as bpf_reg_state the way patches 1-4 are doing.
>> If argno <= 5 keep 'R%d' output, so all selftest don't change.
>> For argno >= 6 print '*(R12-xx)' where xx is where that arg lives.
>> Printing arg# is too cryptic. Humans/agents need to do mental
>> gymnastics to understand what it means.
>> The output must be easy to consume by agents.
>>
>> I was also thinking whether we can get rid of this 'argno' too.
>> cur_regs - reg is that number for <= 5 and
>> some spilled_ptr - reg for >= 6.
>> Technically we can
>>
>> u32 argno = cur_regs - reg;
>> if (argno <= 5) use it
>> else
>>     argno = spilled_ptr - reg.
>>
>> Feels a bit hacky. Need to sleep on it.
> The else case is actually even less pretty:
>      argno = spilled_ptr - constainer_of(reg, struct
> bpf_stack_arg_state, spilled_ptr);
>
> How about dropping slot_type since it is always STACK_SPILL or
> STACK_MISC and that can be inferred anytime by just calling
> is_spillable_regtype():
> -struct bpf_stack_arg_state *stack_arg_slots;
> +bpf_reg_state *stackarg_regs;

This is what I planned to use
    bpf_reg_state *stack_args;
in bpf_func_state.
But looks like stackarg_regs should be a better name.

>
> Then:
> argno = reg - (reg < stackargs_regs) ? cur_regs :  stackarg_regs;

This is a little bit tricky. In bpf_verifier.h, I see

struct bpf_stack_state {
         struct bpf_reg_state spilled_ptr;   <=== for stack state
         u8 slot_type[BPF_REG_SIZE];
};

struct bpf_verifier_env {
	...
	struct bpf_reg_state fake_reg[1];
	...
	struct bpf_reg_state true_reg1, true_reg2, false_reg1, false_reg2;
}

In kernel/bpf/states.h, we have
	static struct bpf_reg_state unbound_reg;

Maybe others, I didn't check.
This will make things complicated.

I would prefer the previous approach to have a nonnegative number
to represent regno and argno (for stack arguments purpose).

>
>> pw-bot: cr

