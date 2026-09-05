Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544E03F3273
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601579; cv=none; b=lKrSGMq+XgxLReeD3e/odFoF5PjEN/DkzAVwm2O7S2M8PP9pRXEk4znjfX7h7mhkvDesS5HPsk79wfaTwpMQZZsAahY4fDvoGXRIj5Nj5vvWLT2H1pk0Ef0VldrkSepCgO5dmJjQVPu6g9rfASzvcNo7Gus/zqXlrOD3jWHi1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601579; c=relaxed/simple;
	bh=MXQ7rl3JHAQwFwoh2PrhfX9nnBGmvCND2HTbyba7Gyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=COjIGgMjBKJNUXYfZBqAVUdVpeVMdGiL/ww2pj/5QcEuMXiXBDJ5Z5l17UjU++g0QOZBcXLJ896XlNwjqh6B0pgRv8DBCfHL56eCMt9gs5GNO+3oudk0Aha4Zhvl/TbKukthpKSzmHNF0wz75kS+LFsANLIoGnRbVs+SgskDH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcT2y4CyNzKHMf3
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 17:45:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 506A04058C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 17:46:11 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXgpDi5JtqK2NcAw--.803S2;
	Sat, 05 Sep 2026 17:46:11 +0800 (CST)
Message-ID: <261a042d-6f52-4a55-83cb-bebacc3c786f@huaweicloud.com>
Date: Sat, 5 Sep 2026 17:46:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Enable stack argument
 tests for RV64
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260905085857.14143-1-pulehui@huaweicloud.com>
 <20260905085857.14143-4-pulehui@huaweicloud.com>
 <20260905090320.8AA9E1F00A3D@smtp.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20260905090320.8AA9E1F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXgpDi5JtqK2NcAw--.803S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8Jr1DCrWfuFW7tw47Jwb_yoW8trW7pa
	ykua43KryfKF42qF17JrWjqr4rGr4kAr45CFs2qry7Z3Zrtry8JF1fKFZ8tas8WrZYv398
	Z3Z2qwnxZw48A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/9/5 17:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing architecture guard update for stack arguments in `tools/testing/selftests/bpf/progs/exceptions.c`.
> --
> 
> commit 7ea892ecb0a3b4c34ad8033c7d6de54aaa01a98d
> Author: Feng Jiang <jiangfeng@kylinos.cn>
> 
> selftests/bpf: Enable stack argument tests for RV64
> 
> Enable the stack argument selftests for RV64. The riscv guard is
> restricted to __riscv_xlen == 64 since stack arguments are only
> supported by the RV64 JIT. Keep the __BPF_FEATURE_STACK_ARGUMENT
> gate, defined by clang with BPF stack argument support [1].
> 
> [1] https://github.com/llvm/llvm-project/pull/189060
> 
>> diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testing/selftests/bpf/progs/stack_arg.c
>> index 944e3bb603e7e..3e9ed37c57bb9 100644
>> --- a/tools/testing/selftests/bpf/progs/stack_arg.c
>> +++ b/tools/testing/selftests/bpf/progs/stack_arg.c
>> @@ -21,7 +21,8 @@ struct {
>>   
>>   int timer_result;
>>   
>> -#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
>> +#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
>> +	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
>>   	defined(__BPF_FEATURE_STACK_ARGUMENT)
>>   
>>   const volatile bool has_stack_arg = true;
> 
> [Severity: Low]
> Does tools/testing/selftests/bpf/progs/exceptions.c also need this architecture
> guard update?
> 
> The has_stack_arg macro in exceptions.c enables stack-argument-specific
> exception tests. The RV64 architecture check seems to be omitted from that file
> during this refactoring:
> 
> tools/testing/selftests/bpf/progs/exceptions.c:
> #if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) \
> 	&& defined(__BPF_FEATURE_STACK_ARGUMENT)
> 
> const volatile bool has_stack_arg = true;
> 
> When exception support is eventually added for the RV64 JIT, the stack argument
> portions of the exceptions selftest will silently fail to enable, reducing test
> coverage.
> 

bpf exception not support for rv64 yet.

