Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8AE219E0
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712039595; cv=none; b=FQqqK/10oo42fEk+bPpc+QztN3XvrK0mbWPgzT4yoIDxYIp+EfIiA0bxti3q4hGWJ72JDxO+cF/pLX8OQkeAnqfhnmct+7i/1k//aUtJJj9Er/31P947QELz73Nr8r/qx6O4vJ1T590Pgmyv20NDazRW1ou4pJYA3aHSq5HWqz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712039595; c=relaxed/simple;
	bh=xuheQCybNadu8Z+Y3sPmXXSmjJ/5R0DaqQ1rSC9zoSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZp7N6HhQEz7VVeKZVtnsUlPbIVI0ihc9jCp2RdgS6vm81o5YikbcQz3S/U4wzX8D+h3m/E4AdzQkaq7Bh+69N+CbJtVnVoBSRKeDp1an9nz1q/rY37axMmtp24tXnmwW7CmjqfgOC7FHk6wu0lRhRdyVYdZRQZLik4HdKn9Vq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V7yjz2sVYz4f3kKH
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:32:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 975B11A0EAD
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:32:59 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgAXNQ6apgtmIQs+Iw--.38096S2;
	Tue, 02 Apr 2024 14:32:59 +0800 (CST)
Message-ID: <d81b6915-e469-4927-80b4-7987579f6656@huaweicloud.com>
Date: Tue, 2 Apr 2024 14:32:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip test when perf_event_open
 returns EOPNOTSUPP
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
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
 <bea168a3-23a5-46df-91a1-28b3abfa1fc2@linux.dev>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <bea168a3-23a5-46df-91a1-28b3abfa1fc2@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAXNQ6apgtmIQs+Iw--.38096S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw15Cr1xCw4fKry3Cw13twb_yoWruFW5p3
	ykta4qkFyrtrn7tF12vr1UXrWYqr4Dtw4UGr15JF1UZr4DXryaqF42gF4YgFn5XrWrX345
	Zr40qrn3ur1DAwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/4/2 14:16, Yonghong Song wrote:
> 
> On 4/1/24 7:22 PM, Pu Lehui wrote:
>>
>>
>> On 2024/4/1 23:29, Yonghong Song wrote:
>>>
>>> On 4/1/24 5:33 AM, Pu Lehui wrote:
>>>> From: Pu Lehui <pulehui@huawei.com>
>>>>
>>>> For the bpf selftest, the semantics of perf_event_open returning ENOENT
>>>> and EOPNOTSUPP imply that continuing the test is meaningless. Let’s 
>>>> skip
>>>> test when perf_event_open returns EOPNOTSUPP, which has already been
>>>> skipped in other test cases.
>>>
>>> Could you explain when EOPNOTSUPP is returned for these two tests?
>>> Is this riscv specific? If the EOPNOTSUPP is returned due to missing
>>> config in tools/testing/selftests/bpf/config, we should add that to
>>> ensure the test can execute properly.
>>>
>>
>> Hello Yonghong, I tested on riscv but it is not unique to riscv. When 
>> the perf driver does not support sampling events, perf_event_open will 
>> return EOPNOTSUPP, that is, PERF_PMU_CAP_NO_INTERRUPT is set to the 
>> pmu capabilities. This is no problem with riscv with sscofpmf 
>> extension and sbi pmu driver. I found that PERF_PMU_CAP_NO_INTERRUPT 
>> is set not only in the riscv-related perf driver. At the same time, it 
>> is possible to return EOPNOTSUPP about PERF_PMU_CAP_AUX_OUTPUT on the 
>> path of perf_event_open. I think it resonable to skip such use cases 
>> for functions not supported by non-bpf modules, what do you think?
> 
> Thanks for explanation. I checked kernel/events/core.c and arch/x86/.... 
> I agree that if hardware has capabilities PERF_PMU_CAP_NO_INTERRUPT
> or PERF_PMU_CAP_AUX_OUTPUT, EOPNOTSUPP could be returned, although I 
> think this should be extremely rare for x86 cpu's (probably only really 
> old ones).
> Several other arch's also have hardware which has capability 
> PERF_PMU_CAP_NO_INTERRUPT, so may indeed hit this issue.
> 
> In bpf-next/arch/riscv, I didn't find usage of PERF_PMU_CAP_NO_INTERRUPT 
> though.
> 

The riscv pmu driver is located in drivers/perf/riscv_pmu*. Sampling 
events are not supported in legacy mode, nor in sbi mode without the 
sscofpmf extension.

> Your patch looks good to me. Since you hit the issue with riscv so 
> please describe how EOPNOTSUPP could be returned in your test. It would 
> be a good
> justification for your patch.

Alright, I will patch that in next version.

> 
>>
>>>>
>>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>>> ---
>>>> tools/testing/selftests/bpf/prog_tests/send_signal.c | 2 +-
>>>> .../testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c | 2 +-
>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c 
>>>> b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>> index b15b343ebb6b..920aee41bd58 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>>>> @@ -179,7 +179,7 @@ static void test_send_signal_nmi(bool 
>>>> signal_thread)
>>>>       pmu_fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */,
>>>>                -1 /* cpu */, -1 /* group_fd */, 0 /* flags */);
>>>>       if (pmu_fd == -1) {
>>>> -        if (errno == ENOENT) {
>>>> +        if (errno == ENOENT || errno == EOPNOTSUPP) {
>>>>               printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
>>>>                      __func__);
>>>>               test__skip();
>>>> diff --git 
>>>> a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c 
>>>> b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>>>> index 5db9eec24b5b..0832fd787457 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>>>> @@ -35,7 +35,7 @@ void test_stacktrace_build_id_nmi(void)
>>>>       pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
>>>>                0 /* cpu 0 */, -1 /* group id */,
>>>>                0 /* flags */);
>>>> -    if (pmu_fd < 0 && errno == ENOENT) {
>>>> +    if (pmu_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
>>>>           printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>>>           test__skip();
>>>>           goto cleanup;
>>

