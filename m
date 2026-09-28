Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30303C1A
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790568290; cv=none; b=LHWGqBbNCZpW4P0s/uqcSkaiv6Z7OmQ70Q2GImZmztd1tlYrMhmLHmZC24mLdeiyPEXAEY8GDpgM4fiNvQgaDIA5WaqzF+gd9TYS8aORnLCJQq+os0zCk/QfKSIR5vo3OraReT9HB+OMKBe+mRFeXpNc7wCbosE0Nyad6cEjBq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790568290; c=relaxed/simple;
	bh=f2hA7jAmLV7XbYeLt4OqHY4KyV0WBqqd1WFlrkR9HvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YaNJ0K2Ipux/qzTQyYc+afal1vK19lw4FtyIQls5U4WV0OsnQ+s7sp4THPMRZb0ett6qaXa3JVD+wxTkcyd5wszlgu63jL+9pHuVNzoGCFwAuR8n6ORxlj8NWP9HGsMo5SFHIOWxinCJwr3lQyrAYcMVIFebV0q1VAYEaBmI2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pmQszuNy; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pmQszuNy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xmmfJt8Fri6SygHQUx8wez57zlozfz0v6WvcH+ZaWGQ=;
	b=pmQszuNyaETt6hESFZGoH1ZKrU0enlAOv4qq4pT179Ae4RSxeE2eAyCojBZdIvPiCvAjW1nDg
	Bz5SEfrQRKGHNnT6zgqbK1T0rpS8GorN+jg8Cn74YgFQIqhKhfSp6xvf8t6deaK2DapOBRCwjF/
	csJdldAON+Dzujh3xnIF+6M=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4htS7R55RSz1K9Ck;
	Mon, 28 Sep 2026 11:52:35 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 339D140572;
	Mon, 28 Sep 2026 12:04:44 +0800 (CST)
Received: from [10.67.110.68] (10.67.110.68) by kwepemf100007.china.huawei.com
 (7.202.181.221) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 12:04:43 +0800
Message-ID: <d4591f24-a3fa-48b2-82db-bc78f933d516@huawei.com>
Date: Mon, 28 Sep 2026 12:04:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Enable gotox tests for
 riscv64
Content-Language: en-US
To: <sashiko-reviews@lists.linux.dev>, Chen Pei <cp0613@linux.alibaba.com>
CC: <bpf@vger.kernel.org>
References: <20260928022109.1093-1-cp0613@linux.alibaba.com>
 <20260928022109.1093-3-cp0613@linux.alibaba.com>
 <20260928023109.5C1B21F000FF@smtp.kernel.org>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20260928023109.5C1B21F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2026/9/28 10:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] bpf: missing architecture guards for riscv64 gotox tests
> --
> 
> commit 1d33b2e23d145afdb7fdcec7bed2452e5b940956
> Author: Chen Pei <cp0613@linux.alibaba.com>
> 
> selftests/bpf: Enable gotox tests for riscv64
> 
> This commit adds riscv64 to the architecture whitelist in verifier_gotox.c
> because the JIT now supports the gotox instruction and jump tables.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
>> index f5a9878c7b8d4..96a9d914930ee 100644
>> --- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
>> +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
>> @@ -6,7 +6,9 @@
>>   #include "bpf_misc.h"
>>   #include "../../../include/linux/filter.h"
>>   
>> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_powerpc)
>> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
>> +	defined(__TARGET_ARCH_powerpc) || \
>> +	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
> 
> [Severity: Low]
> Are there other files that need their architecture guards updated for riscv64
> gotox tests to prevent a regression in test coverage?
> 
> For example, tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c has:
> 
> #if defined(__x86_64__) || defined(__powerpc__) || defined(__aarch64__)
> static int map_create(__u32 map_type, __u32 max_entries)
> {
>      ...
> 
> This skips the bpf_insn_array test suite on riscv64, which heavily exercises
> the gotox jump table logic.
> 
> Similarly, tools/testing/selftests/bpf/progs/compute_live_registers.c has:
> 
> #if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> 
> SEC("socket")
> __log_level(2)
> __msg("2: .1........ (07) r1 += 8")
> __msg("3: .1........ (79) r2 = *(u64 *)(r1 +0)")
> __msg("4: ..2....... (b7) r3 = 1")
> __msg("5: ..23...... (b7) r4 = 2")
> __msg("6: ..234..... (0d) gotox r2")
> ...
> 
> This prevents the gotox liveness tracking tests from being compiled and run
> on riscv64.
> 
> Should these architecture guards also be updated to ensure comprehensive test
> coverage for the newly introduced JIT feature on riscv64?
> 
> [ ... ]
> 

yah, should go with bpf_insn_array and compute_live_registers testcases
