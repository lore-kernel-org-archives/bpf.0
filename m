Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F61DE2D8
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 00:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773102168; cv=none; b=tpKcmC7cfWest83HCQLqoc0eb7B7Khj+p/tFTTkNhPETDq2dWY8GS39YctIssw81LYhF0bs3GdIUQ0EiNGn8Wyh7o5bX8umyOyUJcSyu/9rN3VueW1dIvPrWI/clFnBLVRW9Z2p3Pqr9V/KSfgyFtkRKQsh9M064lWV/v/ILizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773102168; c=relaxed/simple;
	bh=LwvPhY+O11aU0yDloZX9a+LcN6u8mYVq6XEZD3LUGqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naSnmo/2wsJaG/tCdNNZZI01FGilqITBjitknLTFRk5vcmeeL7HW+Gce6bsKR1efNcGvdRGKAi80aDqbZVotf0fJmvkE8oG7WqhpOSSiaHm518xn2OfyG4UyfSQeqoLMqXIwtlZxJoBcUFP3VQ+h0mXINIIwCDFwqWqovTyFZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bW9WCFrm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW9WCFrm"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48534e9076fso13691015e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 17:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773102165; x=1773706965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJiMOodXKQsqMKppGPYQQ1Zow6iMmG+ykc4yjkIuY5o=;
        b=bW9WCFrmTzVh1z7B10Bk/Oaa/x4gqKVkM8FCeSVtCGYxZJB9ZgPm8e2+XofcLwyoGE
         hu1SKYnj+dwjlxLSnDq+mIXhcKjSWX2xDLlVGpPypd4/LRhM9Td8U8mdQaIOC+bEIE+O
         ML9jn3FyoBHMgPKBAV2KslEDEJI8gUnyMWSp1t6gVjy7KUnvnl2h1kM1Aj0TRGXy4+s7
         m2aZnyD8+6SeypjY+83UyjTOMw85UU1VNfELZBzyF3/TyBpbtU7sZuCp8a3+iRrVf9d/
         doKra5kafArkmpU1a22dy5f3JsoH+jSxweCR7eTkHZt/rvqJspfCOddNWdQDBqJ18cTV
         ynJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773102165; x=1773706965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJiMOodXKQsqMKppGPYQQ1Zow6iMmG+ykc4yjkIuY5o=;
        b=luhRqaQ52ShRkazcbClYO19tNderX8Jf3IY4b5AK8pLxYhqUh1AJz8GibpaON/K3z2
         n4HetWadzwJBwxaUbyeolGuhzRPAzksLXc41BQBN32ockEuhO/zEHp1UX3sClOw63ZyI
         esxZtDlW/S92n1dnnV3mi0qCudzZZo1stkGz3x9AlT7MK8NvfXUvG3aqJASSvNbiGmtM
         eJtnjmLkNYNQM3oDILbWbYm8bZg/vX4IqkWmgGozfgVpUHr4fwKh3f2CROxp2ACyTiRH
         +a5wGXndbIOyp5m1Nk5SJ57wiKMBzKSvz6NL6YmlPQy1Sdz0U+yto8hoIztQfCKn5yA8
         AcVA==
X-Gm-Message-State: AOJu0Yycqm0Uh3ng+Cex2hLqxXXUZuwnUg3NQy4JmAx9V1FOORaFHgjR
	izQV0qqDA2+shYofet3xysRNM7MnAlS29YWPO6PdGSOjJFprRR6wx+QjxHUlfA==
X-Gm-Gg: ATEYQzzwz35r5yQHgwSLksn/1byohzft4NUtx2RA2GDGtICpleRtBoKHsr/L5s/cwpj
	m/fOP+MJppRPQ52lT8eOZj0PY+IK3BVYagH+qEZMMtkI+rVflS0fgXlFBOKpSEBZ0u/s+CNC6QN
	CYvEpnF2DOjFoXAyou50O+4HGZCTFCdAdB76eNHRMab/JUwkwDbtd7C985kuhH2JLvZHKT6+rw1
	7HthPzrkp3/b0smbwQaItjcheOj6lHg2N+ts/1jRc9/UVADJvhhQ4XFOUp59fLfHgXNcmu5knO/
	1e0fk3/i73SXyF8XBekqFMrlskQ62i8bRB4jzMR7LhXSeDnTngxxic64DKlIsNYH8l9mk+Ew+bi
	kqO1QY6XeBQFe2hP88j/AVy6QM1bThAU0TOP4yDp0eR6dHHOM/Bx0tNqizEhaq5B4aSyR3984ot
	uR8oeVpRnPgxZp1ibE9M2p56wquoKM45NsfDMllfVRrcuYivVz8TWzF4fqdWcnwjgezr960SvEt
	wxLeCXE2KPGJwQEA8fj83kCmA==
X-Received: by 2002:a05:600c:a12:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-485269648fcmr199707765e9.23.1773102165315;
        Mon, 09 Mar 2026 17:22:45 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aacd81sm27015225e9.14.2026.03.09.17.22.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 17:22:44 -0700 (PDT)
Message-ID: <ab7da349-e828-4402-908f-c5eb60733a33@gmail.com>
Date: Tue, 10 Mar 2026 00:22:40 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 6/6] selftests/bpf: Add tests for sleepable
 raw tracepoint programs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260225-sleepable_tracepoints-v2-0-0330dafd650f@meta.com>
 <20260225-sleepable_tracepoints-v2-6-0330dafd650f@meta.com>
 <aa83cJrghkxkIs9A@krava>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aa83cJrghkxkIs9A@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 9:11 PM, Jiri Olsa wrote:
> On Wed, Feb 25, 2026 at 08:23:54AM -0800, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add two subtests:
>> - success: Attach a sleepable BPF program to the faultable sys_enter
>>    tracepoint (tp_btf.s/sys_enter). Verify the program is triggered by
>>    a syscall.
>> - reject_non_faultable: Attempt to attach a sleepable BPF program to
>>    a non-faultable tracepoint (tp_btf.s/sched_switch). Verify that
>>    attachment is rejected.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   .../selftests/bpf/prog_tests/sleepable_raw_tp.c    | 56 ++++++++++++++++++++++
>>   .../selftests/bpf/progs/test_sleepable_raw_tp.c    | 43 +++++++++++++++++
>>   .../bpf/progs/test_sleepable_raw_tp_fail.c         | 16 +++++++
>>   tools/testing/selftests/bpf/verifier/sleepable.c   |  5 +-
>>   4 files changed, 117 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
>> new file mode 100644
>> index 000000000000..9b0ec7cc4cac
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/sleepable_raw_tp.c
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <test_progs.h>
>> +#include <time.h>
>> +#include "test_sleepable_raw_tp.skel.h"
>> +#include "test_sleepable_raw_tp_fail.skel.h"
>> +
>> +static void test_sleepable_raw_tp_success(void)
>> +{
>> +	struct test_sleepable_raw_tp *skel;
>> +	int err;
>> +
>> +	skel = test_sleepable_raw_tp__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
>> +		return;
>> +
>> +	skel->bss->target_pid = getpid();
>> +
>> +	err = test_sleepable_raw_tp__attach(skel);
>> +	if (!ASSERT_OK(err, "skel_attach"))
>> +		goto cleanup;
>> +
>> +	syscall(__NR_nanosleep, &(struct timespec){ .tv_nsec = 555 }, NULL);
>> +
>> +	ASSERT_EQ(skel->bss->triggered, 1, "triggered");
>> +	ASSERT_EQ(skel->bss->err, 0, "err");
>> +	ASSERT_EQ(skel->bss->copied_tv_nsec, 555, "copied_tv_nsec");
>> +
>> +cleanup:
>> +	test_sleepable_raw_tp__destroy(skel);
>> +}
>> +
>> +static void test_sleepable_raw_tp_reject(void)
>> +{
>> +	struct test_sleepable_raw_tp_fail *skel;
>> +	int err;
>> +
>> +	skel = test_sleepable_raw_tp_fail__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
>> +		goto cleanup;
>> +
>> +	err = test_sleepable_raw_tp_fail__attach(skel);
>> +	ASSERT_ERR(err, "skel_attach_should_fail");
> 
> would it be better to call RUN_TESTS(test_sleepable_raw_tp_fail) instead?
> you could also check the verifier output
> 
> jirka
yes, definitely, thanks!
> 
> 
>> +
>> +cleanup:
>> +	test_sleepable_raw_tp_fail__destroy(skel);
>> +}
>> +
>> +void test_sleepable_raw_tp(void)
>> +{
>> +	if (test__start_subtest("success"))
>> +		test_sleepable_raw_tp_success();
>> +	if (test__start_subtest("reject_non_faultable"))
>> +		test_sleepable_raw_tp_reject();
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
>> new file mode 100644
>> index 000000000000..ebacc766df57
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp.c
>> @@ -0,0 +1,43 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <vmlinux.h>
>> +#include <asm/unistd.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_core_read.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int target_pid;
>> +int triggered;
>> +long err;
>> +long copied_tv_nsec;
>> +
>> +SEC("tp_btf.s/sys_enter")
>> +int BPF_PROG(test_sleepable_sys_enter, struct pt_regs *regs, long id)
>> +{
>> +	struct task_struct *task = bpf_get_current_task_btf();
>> +	struct __kernel_timespec *ts;
>> +	long tv_nsec;
>> +
>> +	if (task->pid != target_pid)
>> +		return 0;
>> +
>> +	if (id != __NR_nanosleep)
>> +		return 0;
>> +
>> +	ts = (void *)PT_REGS_PARM1_CORE_SYSCALL(regs);
>> +
>> +	/*
>> +	 * Use bpf_copy_from_user() - a sleepable helper - to read user memory.
>> +	 * This exercises the sleepable execution path of raw tracepoints.
>> +	 */
>> +	err = bpf_copy_from_user(&tv_nsec, sizeof(tv_nsec), &ts->tv_nsec);
>> +	if (err)
>> +		return err;
>> +
>> +	copied_tv_nsec = tv_nsec;
>> +	triggered = 1;
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
>> new file mode 100644
>> index 000000000000..ef5dc3888df6
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_sleepable_raw_tp_fail.c
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> +
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +/* Sleepable program on a non-faultable tracepoint should fail at attach */
>> +SEC("tp_btf.s/sched_switch")
>> +int BPF_PROG(test_sleepable_sched_switch, bool preempt,
>> +	     struct task_struct *prev, struct task_struct *next)
>> +{
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/bpf/verifier/sleepable.c b/tools/testing/selftests/bpf/verifier/sleepable.c
>> index 1f0d2bdc673f..39522b7cd317 100644
>> --- a/tools/testing/selftests/bpf/verifier/sleepable.c
>> +++ b/tools/testing/selftests/bpf/verifier/sleepable.c
>> @@ -76,7 +76,7 @@
>>   	.runs = -1,
>>   },
>>   {
>> -	"sleepable raw tracepoint reject",
>> +	"sleepable raw tracepoint accept",
>>   	.insns = {
>>   	BPF_MOV64_IMM(BPF_REG_0, 0),
>>   	BPF_EXIT_INSN(),
>> @@ -84,8 +84,7 @@
>>   	.prog_type = BPF_PROG_TYPE_TRACING,
>>   	.expected_attach_type = BPF_TRACE_RAW_TP,
>>   	.kfunc = "sched_switch",
>> -	.result = REJECT,
>> -	.errstr = "Only fentry/fexit/fmod_ret, lsm, iter, uprobe, and struct_ops programs can be sleepable",
>> +	.result = ACCEPT,
>>   	.flags = BPF_F_SLEEPABLE,
>>   	.runs = -1,
>>   },
>>
>> -- 
>> 2.47.3
>>
>>

