Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1763C17BBA
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038584; cv=none; b=lX4gbEdhf8Uud365XxmYMsUNOFYVrh7931WtRqmo/4S4ooEOuxIMZbhmN8ffILU39oRWAqYpEYDK0jUJJEcpFtRZwz27FlVG3MRDsrawFhGIRatpOufrSZpmlDi9YnmyNYY5DTO1M7HZLllFgWHB6U4rmBGyjFtUfQ4vjyZ99Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038584; c=relaxed/simple;
	bh=/xDSY7aAPA4ByTEhRjeRdQ+EP8j53/iXfpDzdq1wosI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFiCNZrpOtoaDdukRq9XSe0uCOYV5mk/LMETpllpuWs8ewcCExE/IdL+6oY37Zl5REOL8T5IbVHwpIX/WM/tqvnV05f6TAohuRtlAoaQkHUw3Pv4YbISegm8QuXbDbP81a7WKXtIyCV4/ULi946itIULinpYyF6vKgMRXjnSZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NRScVCjP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NRScVCjP"
Message-ID: <bea168a3-23a5-46df-91a1-28b3abfa1fc2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712038579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPCfL5fGTs85st+XgLfmtoiU03kXLEoERZ1kWDGEXPQ=;
	b=NRScVCjPQuNUosvvV9o5TmSXErDjVHewrDv4GJhQ49B63JoT3XBzyqx0L7t8uv2IngPRAX
	OcZWqWxeEAuvztUomBubMcyflj4T7EdKb7u3tpNJYrz4PzsBq1TokpTqTToYOK6cu6LbNv
	gmVBuybNS3DjU9zXbt9oMDG9jfsFsII=
Date: Mon, 1 Apr 2024 23:16:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip test when perf_event_open
 returns EOPNOTSUPP
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240401123336.1124715-1-pulehui@huaweicloud.com>
 <e4ff18ca-bf80-4209-a032-28916ed2feda@linux.dev>
 <fd8503f0-d3b4-46a2-a078-ef65aa79f7b6@huaweicloud.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <fd8503f0-d3b4-46a2-a078-ef65aa79f7b6@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 4/1/24 7:22 PM, Pu Lehui wrote:
>
>
> On 2024/4/1 23:29, Yonghong Song wrote:
>>
>> On 4/1/24 5:33 AM, Pu Lehui wrote:
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> For the bpf selftest, the semantics of perf_event_open returning ENOENT
>>> and EOPNOTSUPP imply that continuing the test is meaningless. Let’s 
>>> skip
>>> test when perf_event_open returns EOPNOTSUPP, which has already been
>>> skipped in other test cases.
>>
>> Could you explain when EOPNOTSUPP is returned for these two tests?
>> Is this riscv specific? If the EOPNOTSUPP is returned due to missing
>> config in tools/testing/selftests/bpf/config, we should add that to
>> ensure the test can execute properly.
>>
>
> Hello Yonghong, I tested on riscv but it is not unique to riscv. When 
> the perf driver does not support sampling events, perf_event_open will 
> return EOPNOTSUPP, that is, PERF_PMU_CAP_NO_INTERRUPT is set to the 
> pmu capabilities. This is no problem with riscv with sscofpmf 
> extension and sbi pmu driver. I found that PERF_PMU_CAP_NO_INTERRUPT 
> is set not only in the riscv-related perf driver. At the same time, it 
> is possible to return EOPNOTSUPP about PERF_PMU_CAP_AUX_OUTPUT on the 
> path of perf_event_open. I think it resonable to skip such use cases 
> for functions not supported by non-bpf modules, what do you think?

Thanks for explanation. I checked kernel/events/core.c and arch/x86/.... I agree that if hardware has capabilities PERF_PMU_CAP_NO_INTERRUPT
or PERF_PMU_CAP_AUX_OUTPUT, EOPNOTSUPP could be returned, although I think this should be extremely rare for x86 cpu's (probably only really old ones).
Several other arch's also have hardware which has capability PERF_PMU_CAP_NO_INTERRUPT, so may indeed hit this issue.

In bpf-next/arch/riscv, I didn't find usage of PERF_PMU_CAP_NO_INTERRUPT though.

Your patch looks good to me. Since you hit the issue with riscv so please describe how EOPNOTSUPP could be returned in your test. It would be a good
justification for your patch.

>
>>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>> tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
>>> .../testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c 
>>> b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>> index b15b343ebb6b..920aee41bd58 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>> @@ -179,7 +179,7 @@ static void test_send_signal_nmi(bool 
>>> signal_thread)
>>>       pmu_fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */,
>>>                -1 /* cpu */, -1 /* group_fd */, 0 /* flags */);
>>>       if (pmu_fd == -1) {
>>> -        if (errno == ENOENT) {
>>> +        if (errno == ENOENT || errno == EOPNOTSUPP) {
>>>               printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
>>>                      __func__);
>>>               test__skip();
>>> diff --git 
>>> a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c 
>>> b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>>> index 5db9eec24b5b..0832fd787457 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>>> @@ -35,7 +35,7 @@ void test_stacktrace_build_id_nmi(void)
>>>       pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
>>>                0 /* cpu 0 */, -1 /* group id */,
>>>                0 /* flags */);
>>> -    if (pmu_fd < 0 && errno == ENOENT) {
>>> +    if (pmu_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
>>>           printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>>           test__skip();
>>>           goto cleanup;
>
