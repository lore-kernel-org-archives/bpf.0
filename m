Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FD2DDA9
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 02:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712024582; cv=none; b=JevfTmjIYXABucsuTEDYwRKo9gFTygnvuo95uqXRo2dlot5/Yln3lrMDAg7AOxBhT5x0whSdxwuztHCqkVpnwo2PtG172wwAJZP1ZAv4oVHgJ36eNXhG2Q0JjXpJMuE3l+DkAvrz6EDEUe8AnOCvUyzwDYW1sOISXlnj6KsWBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712024582; c=relaxed/simple;
	bh=FNg88en0T1wqyCLTPQIFxiBmzWeq+g5L4krUO6Mt65w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/DHvZhqNBe1FktK0p2OHmB30TAS28Wvp3ZWB128bUpGNE9CfPY8JiiBIcgoeGWoqeW3Qt3/XdbBpqQSrSdElSqME6wwVqeQW/QpYosfCTwiVsXa029Xk32tRbvaElFkGfCGSf2nz7elW3Wn4mHiNLL5wG1ni/59KTzy7+gaKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V7s9J5zslz4f3jHs
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 10:22:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4D1EC1A016E
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 10:22:51 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgAXaGr5awtmLXHHIw--.22034S2;
	Tue, 02 Apr 2024 10:22:51 +0800 (CST)
Message-ID: <fd8503f0-d3b4-46a2-a078-ef65aa79f7b6@huaweicloud.com>
Date: Tue, 2 Apr 2024 10:22:49 +0800
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
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <e4ff18ca-bf80-4209-a032-28916ed2feda@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXaGr5awtmLXHHIw--.22034S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy5tFy3Zr1xKw4kKF1rZwb_yoW5trW3p3
	ykJ34Ykry8trn7Jr17Ar1UXrW5Gr4DXa1qkr1rJF1UAr4UXryaqF42gF4YgF1rXrW8Z3y5
	Aw40qrn5ur1DAr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/4/1 23:29, Yonghong Song wrote:
> 
> On 4/1/24 5:33 AM, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> For the bpf selftest, the semantics of perf_event_open returning ENOENT
>> and EOPNOTSUPP imply that continuing the test is meaningless. Let’s skip
>> test when perf_event_open returns EOPNOTSUPP, which has already been
>> skipped in other test cases.
> 
> Could you explain when EOPNOTSUPP is returned for these two tests?
> Is this riscv specific? If the EOPNOTSUPP is returned due to missing
> config in tools/testing/selftests/bpf/config, we should add that to
> ensure the test can execute properly.
> 

Hello Yonghong, I tested on riscv but it is not unique to riscv. When 
the perf driver does not support sampling events, perf_event_open will 
return EOPNOTSUPP, that is, PERF_PMU_CAP_NO_INTERRUPT is set to the pmu 
capabilities. This is no problem with riscv with sscofpmf extension and 
sbi pmu driver. I found that PERF_PMU_CAP_NO_INTERRUPT is set not only 
in the riscv-related perf driver. At the same time, it is possible to 
return EOPNOTSUPP about PERF_PMU_CAP_AUX_OUTPUT on the path of 
perf_event_open. I think it resonable to skip such use cases for 
functions not supported by non-bpf modules, what do you think?

>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/send_signal.c            | 2 +-
>>   .../testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c  | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c 
>> b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> index b15b343ebb6b..920aee41bd58 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
>> @@ -179,7 +179,7 @@ static void test_send_signal_nmi(bool signal_thread)
>>       pmu_fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */,
>>                -1 /* cpu */, -1 /* group_fd */, 0 /* flags */);
>>       if (pmu_fd == -1) {
>> -        if (errno == ENOENT) {
>> +        if (errno == ENOENT || errno == EOPNOTSUPP) {
>>               printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n",
>>                      __func__);
>>               test__skip();
>> diff --git 
>> a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c 
>> b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>> index 5db9eec24b5b..0832fd787457 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
>> @@ -35,7 +35,7 @@ void test_stacktrace_build_id_nmi(void)
>>       pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
>>                0 /* cpu 0 */, -1 /* group id */,
>>                0 /* flags */);
>> -    if (pmu_fd < 0 && errno == ENOENT) {
>> +    if (pmu_fd < 0 && (errno == ENOENT || errno == EOPNOTSUPP)) {
>>           printf("%s:SKIP:no PERF_COUNT_HW_CPU_CYCLES\n", __func__);
>>           test__skip();
>>           goto cleanup;

