Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7694A23
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776818235; cv=none; b=Kr55cT2x98Bf7fsixhCvCMIhbG/LoStLocDJjG3gxNgEAmfag6R6olWddiv/MA3iLVE++BGdsdL9xE/p/GK5Yte21uTqybFk+BmjU8nfg51/20XjR/ctwPcACKA2UqHBJdekIg2v4HJMlu+RUPUT/BaL4OW6+JlM8PrvV/l1OnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776818235; c=relaxed/simple;
	bh=S0bgAF/BC4LtFKCNoJav+AY3kg+CSP+UmHqIH17YNT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kdKt1G6C+M5qPn7AoIXgby1VqNA3bGQoU9xFfNAUNb0ue12tkQXHBU77EvYlt7dqA57fvWzgt981add+4tKtlQTX3ib8ShqLIL4FiZ30BrUrFa1HxB5flQ4hwKGCn+AlXshyMXGbr41V96qNJFRlCtOboAjboGk7327wXTyQVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9HOUXSn; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9HOUXSn"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dc35728a57so3757569a34.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 17:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776818233; x=1777423033; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t42vao7prAWZRvc3iYTFg0aNvRNt4V9Bhvuj7dkiTCE=;
        b=N9HOUXSnEOYvouplACFJmb/e5sdHidv6qrxlH8jDdWi+LdjFDatBYr60Y2egZvvMox
         Bcf8HZQp56HBLDJN4nGJ9xHIENE0A2OzU3owOq+Ww2TRu3yNN/yULBLhY1bF+ByWybH+
         vLLxZCW6lF5kLBL1S3RqHeUPj5wNcuO8f7kBIEp7LW+y7Kt4TveoM0enoZLj5Ab3VlCf
         omSGMYeK47bU7VR1dD3PSqlmUVr3C8etd2louYg92akczXKUzX6qsvIFBdXFv0HvCyx2
         0PZZtRyeRJF4LTbnNEnyfUEFK0lCKXhZFAwkXAp4Vssd11RgzrGQrNjdsnJckduF71Sc
         exgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776818233; x=1777423033;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t42vao7prAWZRvc3iYTFg0aNvRNt4V9Bhvuj7dkiTCE=;
        b=WZyqIaM89vzLQvtF+YERzHdXHPm4bHw6jKMqk6uM00ltzbzWUtRGpd/ErV5ZU2+Ld+
         ui81ceyi4JfcHVEo86oMqrloZAgKmmksj7Cy3oLxec7PSX2tZKC2bdJQdJCA0aMXmBR5
         pSc83QZEmDNAXw+fpIv+0arlCwCne1Rym0neJhR6hQx4bms2DEvjR0GXrSrpg31voOKW
         dsnYKxOH8g3PNAknhXD37COfqmSpO3VAN4HN8mZHrdjoSuBHhCZ6lENfs1NtW+laEoBF
         Hj2IlJz+M/daNyeGneRt+uXDksfo0cBmkgahZmlvdZG/8dSXDJ6v6UbpGHAWo1GhIX0/
         FLeg==
X-Forwarded-Encrypted: i=1; AFNElJ9gvM5sb63DWwbR4oPjRTuKdG9F1lCBZOH9LRou5mJdl6q30Lyn7dws5syrCFy9jAyt7qE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycxmHEgH3fvU81T+wLJav4e0OQKN/ElngI1RkBRogGBNq9iFqN
	Wj3aoJo916iBpkGu+/Z3yVLW1159LXe06K8103TmF4MJnjbARw1vi0rxN+mFDA==
X-Gm-Gg: AeBDievVHMwrW7JwvDFmAswz917/vV6/TYixFrYHDV4/7cJYdlEfthqiUIyTKnnwQ9h
	UrDKoH2ZPh2Q6i6IEfzFbgbVeqYd1JV+HrvjLntp7lLCBN7ibXeNlbB1/hJo+pwLemEgAVUtI8+
	8aH6Q+LEdfYJ4X0eBd81pCVCiA5sYpI2+pU3p0Oat6FX1kRLg7Z0bZVmJG1iy7Ayp608SyOgiBp
	gqBPO3KxjdIUP9c+Zn4ijmC+Sdhe4ENNeweG+1v/zrTiELVDDYzfMDAeLXjFbW/WY0HS6iSnth4
	p5sQ1KSgE3stqQqdsCtxpqe1/a/Vo2JOhbD2YW4GBtm9zyF+Pe/CjLQKW7Dsv1OYbNvODKFzYy9
	dCCUp+lCICHpewgcZooHVkWru+EQAKW1pAyYtu0AW1PGZjVaNX1wfg0UflrhS3mtLygxTUfyTxI
	6NTEzwY4xltODbRwe1DYRnOTWBdHBZBktYVzB+E1UIJ2O0J6XH2ZQLtwr8zCk4Q+vTzm3H8OOJM
	c7a9JJhX6HQua5sXMPcUXIakT/2
X-Received: by 2002:a05:6830:dc5:b0:7dc:dd58:50ab with SMTP id 46e09a7af769-7dcdd587d88mr2591437a34.14.1776818233306;
        Tue, 21 Apr 2026 17:37:13 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975033acsm12453648a34.1.2026.04.21.17.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 17:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 17:37:11 -0700
Message-Id: <DHZ9HV5M7UDQ.3U5A4J1VJ7H75@gmail.com>
Subject: Re: [PATCH bpf-next 7/9] bpf: Prepare verifier logs for upcoming
 kfunc stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Jose E .
 Marchesi" <jose.marchesi@oracle.com>, <kernel-team@fb.com>, "Martin KaFai
 Lau" <martin.lau@kernel.org>, "Puranjay Mohan" <puranjay@kernel.org>
X-Mailer: aerc
References: <20260421171927.3507554-1-yonghong.song@linux.dev>
 <20260421172002.3510514-1-yonghong.song@linux.dev>
 <DHZ6BHVW9CVO.1MNKDGSAXI76Z@gmail.com>
 <b9809b44-aef2-4ffc-945e-b5cac1dbdbbd@linux.dev>
In-Reply-To: <b9809b44-aef2-4ffc-945e-b5cac1dbdbbd@linux.dev>

On Tue Apr 21, 2026 at 4:56 PM PDT, Yonghong Song wrote:
>
>
> On 4/21/26 3:07 PM, Alexei Starovoitov wrote:
>> On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
>>> This change prepares verifier log reporting for upcoming kfunc stack
>>> argument support.
>>>
>>> Today verifier log code mostly assumes that an argument can be describe=
d
>>> directly by a register number. That works for arguments passed in `R1`
>>> to `R5`, but it does not work once kfunc arguments can also be
>>> passed on the stack.
>>>
>>> Introduce an internal `argno` representation such that register-passed
>>> arguments keep using their real register numbers, while stack-passed
>>> arguments use an encoded value above a dedicated base.
>>> `reg_arg_name()` converts this representation into either `R%d` or
>>> `*(R11-off)` when emitting verifier logs. If a particular `argno`
>>> is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
>>> print `R%d`. Here R11 presents the base of stack arguments.
>>>
>>> This keeps existing logs readable for register arguments and allows the
>>> same log sites to handle future stack arguments without open-coding
>>> special cases.
>>>
>>> Update selftests accordingly.
>>>
>>> Acked-by: Puranjay Mohan <puranjay@kernel.org>
>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>   include/linux/bpf_verifier.h                  |   1 +
>>>   kernel/bpf/verifier.c                         | 640 ++++++++++-------=
-
>>>   .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
>>>   .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>>>   .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
>>>   .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>>>   .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
>>>   .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
>>>   .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
>>>   .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
>>>   tools/testing/selftests/bpf/progs/irq.c       |   4 +-
>>>   tools/testing/selftests/bpf/progs/iters.c     |   6 +-
>>>   .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
>>>   .../selftests/bpf/progs/iters_testmod.c       |   4 +-
>>>   .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
>>>   .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
>>>   .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
>>>   .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
>>>   .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
>>>   .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>>>   .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
>>>   .../selftests/bpf/progs/task_work_fail.c      |   6 +-
>>>   .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
>>>   .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
>>>   .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
>>>   .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
>>>   .../bpf/progs/verifier_ref_tracking.c         |   6 +-
>>>   .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>>>   .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
>>>   tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
>>>   30 files changed, 464 insertions(+), 375 deletions(-)
>>>
>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
>>> index b148f816f25b..d5b4303315dd 100644
>>> --- a/include/linux/bpf_verifier.h
>>> +++ b/include/linux/bpf_verifier.h
>>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>>   	 * e.g., in reg_type_str() to generate reg_type string
>>>   	 */
>>>   	char tmp_str_buf[TMP_STR_BUF_LEN];
>>> +	char tmp_arg_name[32];
>>>   	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>>   	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>>   	struct bpf_scc_callchain callchain_buf;
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index 18ab92581452..82568a427211 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -1742,6 +1742,44 @@ static struct bpf_verifier_state *push_stack(str=
uct bpf_verifier_env *env,
>>>   	return &elem->st;
>>>   }
>>>  =20
>>> +#define STACK_ARGNO_BASE 100
>>> +
>>> +static bool is_stack_argno(int argno)
>>> +{
>>> +	return argno > STACK_ARGNO_BASE;
>>> +}
>>> +
>>> +/* arg starts at 1 */
>>> +static u32 make_argno(u32 arg)
>>> +{
>>> +	if (arg <=3D MAX_BPF_FUNC_REG_ARGS)
>>> +		return arg;
>>> +	return STACK_ARGNO_BASE + arg;
>>> +}
>> You can remove this and simplify everything further by
>>
>> static bool is_stack_argno(int argno)
>> {
>> 	return argno > MAX_BPF_FUNC_REG_ARGS;
>> }
>>
>>> +
>>> +static u32 arg_from_argno(int argno)
>>> +{
>>> +	if (is_stack_argno(argno))
>>> +		return argno - STACK_ARGNO_BASE;
>>> +	return argno;
>>> +}
>> remove as well.
>>
>> and a comment like:
>>
>> /*
>>   * switch (argno) {
>>   * case 1: R1
>>   * case 5: R5
>>   * case 6: *(u64 *)(R11 +- 8)
>>   * case 7: *(u64 *)(R11 +- 16)
>>   */
>
> This=C2=A0doesn't work. Let us see the following example:
>
> check_kfunc_args
>    process_dynptr_func (argno)
>      check_mem_access (argno, 4th argument)
>        check_packet_access (argno)
>          check_mem_region_access (argno)
>            __check_mem_access (argno)
>              <=3D=3D verbose log with argno
>
> do_check
>    do_check_insn (env)
>      check_load_mem (insn)
>        check_mem_access (insn->src_reg, 4th argument)
>          check_packet_access (...)
>            check_mem_region_access (...)
>              __check_mem_access (insn->src_reg or argno)

Ohh. Silent conversion. That's quite error prone.

let's do
typedef struct argno {
    int argno;
} argno_t;

and make sure this callchain passes arg_t unmodified:

    process_dynptr_func (argno)
      check_mem_access (argno, 4th argument)
        check_packet_access (argno) ...

while here:

      check_load_mem (insn)
        check_mem_access (argno_from_reg(insn->src_reg), 4th argument)

static argno_t argno_from_reg(u32 regno)
{
    return (argno_t){ .argno =3D regno };
}

static argno_t argno_from_arg(u32 arg)
{
    return (argno_t){ .argno =3D -arg };
}

static const char *reg_arg_name(struct bpf_verifier_env *env, argno_t argno=
)

When positive vs negative is an internal implemenation of argno_t
it's fine. It's better than shift by 100, but when negative was
used as a signal everywhere it leaked details to caller.

