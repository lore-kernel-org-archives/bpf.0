Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D42737E3
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872849; cv=none; b=QCR6D3yLi7/Ks5Wj3/DsYtMDmvl9Qdq+WRfx1fECrFu9slxcgcwRVq8vzA3a1grlzM1MCiawR3J58UjWVQXviDJgP9fuPyRIaS5MkvMYHHJ6dI5n6M1IDVSTzsoJEG21VWgm4BIY9525rtfnwQWyLwRFs6P/kH0BwGKyCv90pTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872849; c=relaxed/simple;
	bh=Peitl/EGooQwjNnqWzbr3bdufGA8nKEFapG62eF0qzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gYGT0yqNDusDN8QBRdbciMEW2bvt9Sn+dr3/xXJTdc+uM1htuErqviYIeNcTR5WrlVlhHHfpq0knenxPNaPQm+zdM4TNPq5XdNky+83eZLNhMRx55F14t8LCajy+OGeIdEflKqpAFZIpQbmZ4UJYk0NwvfttF3UFY6QxciX5170=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wBHbKZ_7ehpV5amAA--.3356S3;
	Wed, 22 Apr 2026 23:47:12 +0800 (CST)
Received: from [10.162.163.215] (unknown [10.162.163.215])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn18x_7ehp_efPAA--.63533S3;
	Wed, 22 Apr 2026 23:47:11 +0800 (CST)
Message-ID: <ac3fda86-909b-420c-9d80-282554669371@zju.edu.cn>
Date: Wed, 22 Apr 2026 23:47:11 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 3/3] selftests/bpf: Add test for large offset
 bpf-to-bpf call
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260421144504.823756-4-tangyazhou@zju.edu.cn>
 <20260421210253.5AB2AC2BCB0@smtp.kernel.org>
Content-Language: en-US
From: Yazhou Tang <tangyazhou@zju.edu.cn>
In-Reply-To: <20260421210253.5AB2AC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zC_KCgBn18x_7ehp_efPAA--.63533S3
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgsJCmnn0w2TlAAAsZ
X-CM-DELIVERINFO: =?B?1daGiwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9LL0UKc+KPB+cdozqO9FXghDKs6RqwUMWuNE/GkeA1S3GRTHctHm9be4OCXM9WHNS/V6
	Ory4tMEQEqlP18yZxIfUY2x6B7umbjykKbFJmiPRZG8c+brQvM0+232J8bbLjQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxZr15ZF17Wr13XryUJw48KrX_yoW5WrW8pF
	yfta45KF4xGFW7Krn7Z3yDWFySvwsrAa4jkFn5Jr98A3s8Xr1Ikrs3Kw4Uua42kr4ku3WS
	vF4jgasI9w1kAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UUUUU==



On 4/22/26 5:02 AM, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The selftest causes a kernel panic on unfixed kernels (when JIT is disabled), which disrupts CI pipelines and bisection workflows.
> --
> 
> commit c0593c5f6291ee1a846f9c17858890ded3cd8ea4
> Author: Yazhou Tang <tangyazhou518@outlook.com>
> 
> selftests/bpf: Add test for large offset bpf-to-bpf call
> 
> This commit adds a BPF selftest to verify that the verifier and JIT correctly
> handle bpf-to-bpf calls with relative jump offsets exceeding the s16 boundary.
> It uses a large inline assembly block to force the verifier to process a jump
> exceeding the standard limit.
> 
>> - Before the fix, the verifier rewrites the call instruction with a truncated
>>    offset (here 32768 -> -32768) and lets it pass. When the program is executed,
>>    the call instruction causes a kernel panic due to an invalid jump target.
> 
> Is it safe to introduce a test that causes a kernel panic on unpatched kernels?
> 
> While reproducing the bug is the test's goal, crashing the kernel is highly
> disruptive for CI systems and git bisect workflows that run the testsuite on
> older or unpatched kernel trees.

This point is valid. Although the upstream CI typically runs with JIT enabled,
causing a kernel panic when JIT is disabled is definitely something we should avoid.

>> diff --git a/tools/testing/selftests/bpf/progs/call_large_imm.c b/tools/testing/selftests/bpf/progs/call_large_imm.c
>> new file mode 100644
>> index 0000000000000..7cdf1e6d80d8d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/call_large_imm.c
> 
> [ ... ]
> 
>> +static __attribute__((noinline)) void padding_subprog(void)
>> +{
>> +	asm volatile ("					\
>> +		r0 = 0;					\
>> +		.rept 32765;				\
>> +		r0 += 0;				\
>> +		.endr;					\
>> +	" ::: "r0");
>> +}
>> +
>> +static __attribute__((noinline)) int target_subprog(void)
>> +{
>> +	/* A volatile variable is used here to prevent optimization. */
>> +	volatile int magic_ret = 3;
>> +	return magic_ret;
>> +}
>> +
>> +SEC("syscall")
>> +int call_large_imm_test(void *ctx)
>> +{
>> +	if (zero)
>> +		padding_subprog();
>> +	return target_subprog();
>> +}
> 
> Could the test be redesigned to fail gracefully?
> 
> If the large padding block were placed before the call instruction, the
> call site would be at a large positive offset. A truncated negative jump
> (-32768) would then land safely inside the valid padding instructions instead
> of jumping out of bounds of the program.
> 
> The execution would then fall through and return an incorrect value, causing
> ASSERT_EQ(opts.retval, 3) in the runner to cleanly fail without bringing down
> the system.
> 

This approach is indeed more elegant and safer. I will redesign the selftest
as suggested for next version.

