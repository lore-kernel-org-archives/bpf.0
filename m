Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070D6347C6
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822731; cv=none; b=OfH+AOxJOlxqJiFy/+6hwxsJmk+CE+XO+jvpBEuTj5qk0uYeGoMxMtC9mGRErqjkhOU+POjP2jzqlLkkzh2SaCzTOTEgZl0Fa9iVN59z44vWTZu4h4PXlTP+SZjKx3Kuqx+Hk33DaQ23toAfuiu5Gk0z9YUahJQwkUVsp4+Ec/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822731; c=relaxed/simple;
	bh=9lizlac84WN7wpKiTB9fN0ViXyIPZ444vZphpCFIFRU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=gHHHfBa5UIqmFQEj68gVz4bMugctIu2k834lf1o5hJhb9BhThIBqgaxvbXI5RpDB+1k//kDJ9vf/BIMHdPpe1Ux5JYClxyiAuy3NuIaHwmPWtsClTKWn+iBlnMV2lqMqpVKH1UiKaJQXs1Zzz5Bi3I5uyTclegTUlIuyJi9Llys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6NWjJSM; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6NWjJSM"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcd9061b1aso1181595a34.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776822729; x=1777427529; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWbz9hjphfZPB43dHSFrOAiax7r2DYQklC94NytVIVE=;
        b=Z6NWjJSMfrKirFV5kn2skzq11bnAesEa5A52/dc4maPMPE4kEU35KSWwhr8exesL8+
         8F1Hwx+GqZTwrVmr0IbQXggna4H+Sm5fNdfvjST3Zjotm8uWSI0CuZdDSHlVi5jW2Atb
         rUV3VoqOoma2ur6iDms5dC2y0x5Lh+9mL7aA/POzesdlu0uuowc0asjJCA30potjuSAP
         idkdOPngU91l4kTzi3th0afVggna/BUm0V0Q0W95qSnrDoGE7BYM4cJD2VjPpw1hwQs7
         V8lase8R65vvS3hHQERlKYt4ZgQdas7/SjMdgptDFu37VoT4hXN7UpzyHVPQ6TqzleWm
         9K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776822729; x=1777427529;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWbz9hjphfZPB43dHSFrOAiax7r2DYQklC94NytVIVE=;
        b=oDmKE9CVtaUS/s1rZXDkXcRc9QomkpoHTfMYzx3U7lDh1CbaZ2f46iIpcW1YBaZuFn
         70gEnDwVQhdR0UR8XAjv0EugZenJ0iG1sX9flsWUtZ2fQ74edwZnrE1JCOMy5nso6IgY
         Qy1Bt0QZdye53q0ypeAiRe41r6/NZ3Dk2uZktm0GJKXt/DImk1U4j/GUrKbZt8k0uiFf
         zgc7gE7OW4btB512erHZmZxTWkG0MlaTbgvRtcWowXqLMzq7bTFrMRcOLcblp/juntTu
         9Ad8zxVLz34UyeHjAyCiNcPIvVY/rB9APw324ZXSQ7HkjF1MwPAxndoomwOY2edA4Imh
         zQug==
X-Forwarded-Encrypted: i=1; AFNElJ+G9DTAUlYTfHZXyA1uKs7jZS/IPxFvmxevOYYOOg7x0VeoYNhHMwOiTT/NUOCZLKM8xBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy+DsjByi5VxpX9UD+vY2ntzKrgrt1jVNpRjjRUC9uFEHOdce3
	M7nalQCiVHPWQ2hatupm3qvULr04NXMQUWc4/z76GJbzU2gXVqVnRXYR
X-Gm-Gg: AeBDietGL2rbg+FsUeGgjANjrE37rDbNph/ShEbKoxB6Xt/k7QG2nF35EegIk3xg0tp
	W1oKnROYGa+qr6OXuLqpBZQoLfhimPiSmoOsN88jVLM0YobWQiOiAl6KmLZtViNUC1usTUgKWmX
	Cjudvnu9G0e8mxdHGVW+hauLl7PCX3E3XU8AvbZLUsrdHBv4YXTDVRhoajfc95N3aCzYLDaMnOW
	sk+zh3CTWyFF2gds8knu1OSJbo/ilsqGUn1nP8+1+K9BujF6hESuehgLPNhRF/vrOTjNhj6t/q4
	jzob82OGmBzniisMcozlO4bm0yRf6kHnAz/OTySCOe8sofFkHagWJH/8nQ7PQlpswKgvNnQg5e9
	rggQnva1oN2EXNNDROLamDgzUV7hsGkYUQ9Yr77g9+kADw/6Lp3jk2CIf6aEXNeEoYBNg/M2VED
	m8NnUiXWR9Scnb8lF6iVYcBW1GaaXY2sEByzGNs3q9HkMsROSZ72Jm0dJTbVcK4wMK43HJYwIyr
	YcqKU0AWpqSq+NZnZPlcRfLISo=
X-Received: by 2002:a05:6830:2806:b0:7d7:ccc7:c546 with SMTP id 46e09a7af769-7dc95252ae8mr13570000a34.23.1776822728800;
        Tue, 21 Apr 2026 18:52:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dce5c346adsm844468a34.27.2026.04.21.18.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 18:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 18:52:06 -0700
Message-Id: <DHZB3851LRVR.3FCS97ALVURY0@gmail.com>
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
 <DHZ9HV5M7UDQ.3U5A4J1VJ7H75@gmail.com>
 <48627842-4916-4bab-a2ff-6eb83692d1da@linux.dev>
In-Reply-To: <48627842-4916-4bab-a2ff-6eb83692d1da@linux.dev>

On Tue Apr 21, 2026 at 6:20 PM PDT, Yonghong Song wrote:
>
>
> On 4/21/26 5:37 PM, Alexei Starovoitov wrote:
>> On Tue Apr 21, 2026 at 4:56 PM PDT, Yonghong Song wrote:
>>>
>>> On 4/21/26 3:07 PM, Alexei Starovoitov wrote:
>>>> On Tue Apr 21, 2026 at 10:20 AM PDT, Yonghong Song wrote:
>>>>> This change prepares verifier log reporting for upcoming kfunc stack
>>>>> argument support.
>>>>>
>>>>> Today verifier log code mostly assumes that an argument can be descri=
bed
>>>>> directly by a register number. That works for arguments passed in `R1=
`
>>>>> to `R5`, but it does not work once kfunc arguments can also be
>>>>> passed on the stack.
>>>>>
>>>>> Introduce an internal `argno` representation such that register-passe=
d
>>>>> arguments keep using their real register numbers, while stack-passed
>>>>> arguments use an encoded value above a dedicated base.
>>>>> `reg_arg_name()` converts this representation into either `R%d` or
>>>>> `*(R11-off)` when emitting verifier logs. If a particular `argno`
>>>>> is corresponding to a stack argument, print `*(R11-off)`. Otherwise,
>>>>> print `R%d`. Here R11 presents the base of stack arguments.
>>>>>
>>>>> This keeps existing logs readable for register arguments and allows t=
he
>>>>> same log sites to handle future stack arguments without open-coding
>>>>> special cases.
>>>>>
>>>>> Update selftests accordingly.
>>>>>
>>>>> Acked-by: Puranjay Mohan <puranjay@kernel.org>
>>>>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>>>>> ---
>>>>>    include/linux/bpf_verifier.h                  |   1 +
>>>>>    kernel/bpf/verifier.c                         | 640 ++++++++++----=
----
>>>>>    .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
>>>>>    .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
>>>>>    .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
>>>>>    .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
>>>>>    .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
>>>>>    .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
>>>>>    .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
>>>>>    .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
>>>>>    tools/testing/selftests/bpf/progs/irq.c       |   4 +-
>>>>>    tools/testing/selftests/bpf/progs/iters.c     |   6 +-
>>>>>    .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
>>>>>    .../selftests/bpf/progs/iters_testmod.c       |   4 +-
>>>>>    .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
>>>>>    .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
>>>>>    .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
>>>>>    .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
>>>>>    .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
>>>>>    .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
>>>>>    .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
>>>>>    .../selftests/bpf/progs/task_work_fail.c      |   6 +-
>>>>>    .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
>>>>>    .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
>>>>>    .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
>>>>>    .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
>>>>>    .../bpf/progs/verifier_ref_tracking.c         |   6 +-
>>>>>    .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
>>>>>    .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
>>>>>    tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
>>>>>    30 files changed, 464 insertions(+), 375 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
>>>>> index b148f816f25b..d5b4303315dd 100644
>>>>> --- a/include/linux/bpf_verifier.h
>>>>> +++ b/include/linux/bpf_verifier.h
>>>>> @@ -913,6 +913,7 @@ struct bpf_verifier_env {
>>>>>    	 * e.g., in reg_type_str() to generate reg_type string
>>>>>    	 */
>>>>>    	char tmp_str_buf[TMP_STR_BUF_LEN];
>>>>> +	char tmp_arg_name[32];
>>>>>    	struct bpf_insn insn_buf[INSN_BUF_SIZE];
>>>>>    	struct bpf_insn epilogue_buf[INSN_BUF_SIZE];
>>>>>    	struct bpf_scc_callchain callchain_buf;
>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>> index 18ab92581452..82568a427211 100644
>>>>> --- a/kernel/bpf/verifier.c
>>>>> +++ b/kernel/bpf/verifier.c
>>>>> @@ -1742,6 +1742,44 @@ static struct bpf_verifier_state *push_stack(s=
truct bpf_verifier_env *env,
>>>>>    	return &elem->st;
>>>>>    }
>>>>>   =20
>>>>> +#define STACK_ARGNO_BASE 100
>>>>> +
>>>>> +static bool is_stack_argno(int argno)
>>>>> +{
>>>>> +	return argno > STACK_ARGNO_BASE;
>>>>> +}
>>>>> +
>>>>> +/* arg starts at 1 */
>>>>> +static u32 make_argno(u32 arg)
>>>>> +{
>>>>> +	if (arg <=3D MAX_BPF_FUNC_REG_ARGS)
>>>>> +		return arg;
>>>>> +	return STACK_ARGNO_BASE + arg;
>>>>> +}
>>>> You can remove this and simplify everything further by
>>>>
>>>> static bool is_stack_argno(int argno)
>>>> {
>>>> 	return argno > MAX_BPF_FUNC_REG_ARGS;
>>>> }
>>>>
>>>>> +
>>>>> +static u32 arg_from_argno(int argno)
>>>>> +{
>>>>> +	if (is_stack_argno(argno))
>>>>> +		return argno - STACK_ARGNO_BASE;
>>>>> +	return argno;
>>>>> +}
>>>> remove as well.
>>>>
>>>> and a comment like:
>>>>
>>>> /*
>>>>    * switch (argno) {
>>>>    * case 1: R1
>>>>    * case 5: R5
>>>>    * case 6: *(u64 *)(R11 +- 8)
>>>>    * case 7: *(u64 *)(R11 +- 16)
>>>>    */
>>> This=C2=A0doesn't work. Let us see the following example:
>>>
>>> check_kfunc_args
>>>     process_dynptr_func (argno)
>>>       check_mem_access (argno, 4th argument)
>>>         check_packet_access (argno)
>>>           check_mem_region_access (argno)
>>>             __check_mem_access (argno)
>>>               <=3D=3D verbose log with argno
>>>
>>> do_check
>>>     do_check_insn (env)
>>>       check_load_mem (insn)
>>>         check_mem_access (insn->src_reg, 4th argument)
>>>           check_packet_access (...)
>>>             check_mem_region_access (...)
>>>               __check_mem_access (insn->src_reg or argno)
>> Ohh. Silent conversion. That's quite error prone.
>>
>> let's do
>> typedef struct argno {
>>      int argno;
>> } argno_t;
>>
>> and make sure this callchain passes arg_t unmodified:
>>
>>      process_dynptr_func (argno)
>>        check_mem_access (argno, 4th argument)
>>          check_packet_access (argno) ...
>>
>> while here:
>>
>>        check_load_mem (insn)
>>          check_mem_access (argno_from_reg(insn->src_reg), 4th argument)
>>
>> static argno_t argno_from_reg(u32 regno)
>> {
>>      return (argno_t){ .argno =3D regno };
>> }
>>
>> static argno_t argno_from_arg(u32 arg)
>> {
>>      return (argno_t){ .argno =3D -arg };
>> }
>>
>> static const char *reg_arg_name(struct bpf_verifier_env *env, argno_t ar=
gno)
>>
>> When positive vs negative is an internal implemenation of argno_t
>> it's fine. It's better than shift by 100, but when negative was
>> used as a signal everywhere it leaked details to caller.
>
> This approach is kind of similar to=C2=A0what I proposed earlier with
> an int variable, non-negative for reg and negative for arg (value -1/-2/.=
..).
>     https://lore.kernel.org/bpf/20260412045857.256260-1-yonghong.song@lin=
ux.dev/

Of course. It's your proposal. I just relayed it back.
My objection for inband signaling was that it leaks into the caller
and you "fixed" with make_argno() plus "shift-by-100"
while I was objecting to "leaks to caller" part.

In band signaling almost always sucks, but when it's there
to save extra word of being passed around by value,
it's worth doing. But only if it's hidden behind api.

> But it is not explicit except the name 'reg_or_arg'.
> Here, argno_t type makes it more explicit and should better.

"not explicit" is the key.
When it's abstracted it can change into "shift-by-100"
or extra bit without affecting callers or callees.

> For printing, I guess we still want to print 'R#' whenever possible
> including positive registers and negative argno (1-5), and print
> '*(R11-off)' for negative argno (6->...)?

Yes, because that's what verifier log just before the error
message has. 'arg#' is disconnected from verifier output
that immediately preceding that error message. It's bad
for humans and especially bad for agents that cannot
connect the dots. r1=3D..; arg#0 is invalid because ...;
How agent suppose to infer that arg#0 is the same as r1 ?
It can if it thinks "effort xhigh", but it shouldn't need to do that.

