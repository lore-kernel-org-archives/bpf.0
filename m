Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8F1A680E;
	Sat,  5 Sep 2026 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595551; cv=none; b=UYXNVfSbIlD04KW0uN9Daghi0DmxpazEKszeWLkXej27ZiqGLquPmkVMf1GfCS16i9j5xqKrLt05nMBOQkRyJkk20VKosStPDdKRIQcNXHgzwoTXQsqdxX+KvXwwT6nLIQ9/Wq94EIw6Ql2J8m13+8kMb2voiM3ho61h/ObyRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595551; c=relaxed/simple;
	bh=yZmh9BGaqd/iD97x8EJ1FTGDo5l9FfdqmyNjdC/jU/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvvSQlZs4rQHlZWHvljA/rX0YR7YnvoScN7QH0/0AzTeks4G4a/XnRk9CXGqRlPlGn2K33X8QJjevoBQeuVRuSz8fO8SSEwof95BnCb4mUDzxW9dXjfjNCc0KyP+wIgkO6IUAGANHWZe1UidNC7oMtWpDrpErP+3t2akW7u+lQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hcQqH22BKzYQv2s;
	Sat,  5 Sep 2026 16:04:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 453E14057E;
	Sat,  5 Sep 2026 16:05:45 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDHKZdXzZtqAJxTAw--.64717S2;
	Sat, 05 Sep 2026 16:05:44 +0800 (CST)
Message-ID: <c379e0a9-191d-4d3c-9d92-837b58b29409@huaweicloud.com>
Date: Sat, 5 Sep 2026 16:05:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Enable stack argument
 tests for RV64
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 jiangfeng@kylinos.cn
Cc: bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, alex@ghiti.fr,
 pulehui@huawei.com, martin.lau@kernel.org, mason@kernel.org
References: <20260905070409.4141522-4-pulehui@huaweicloud.com>
 <5e50a375b8cc6ff27c370db71783041b6ceebdf6a014a008bb2ecbfb2dca88ca@mail.kernel.org>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <5e50a375b8cc6ff27c370db71783041b6ceebdf6a014a008bb2ecbfb2dca88ca@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHKZdXzZtqAJxTAw--.64717S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUZF1kKrW8GrykuryUWrg_yoW5CF4Upa
	1kCF1akrWvvw4jqry29rn0gr45Wan5JryUGr1DXw1rZFy5K3WkGr4fKay7Aa4DWry3ua4D
	Zrs0vrnagw4kAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/9/5 15:45, bot+bpf-ci@kernel.org wrote:
>> Enable the stack argument selftests for RV64. The riscv guard is
>> restricted to __riscv_xlen == 64 since stack arguments are only
>> supported by the RV64 JIT.
>>
>> Keep the __BPF_FEATURE_STACK_ARGUMENT gate, defined by clang with
>> BPF stack argument support [1].
>>
>> [1] https://github.com/llvm/llvm-project/pull/189060
>>
>> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
> 
> The changelog says "Enable the stack argument selftests for RV64", but
> one arch-gated stack-argument test remains on x86_64/arm64 only.
> 
> Exhaustive list of every arch-gated stack-argument test in
> tools/testing/selftests/bpf:
> 
>    progs/btf__stack_arg_precision.c        updated by this patch
>    progs/btf__verifier_stack_arg_order.c   updated by this patch
>    progs/stack_arg.c                       updated by this patch
>    progs/stack_arg_kfunc.c                 updated by this patch
>    progs/stack_arg_precision.c             updated by this patch
>    progs/verifier_stack_arg.c              updated by this patch
>    progs/verifier_stack_arg_order.c        updated by this patch
>    progs/stack_arg_fail.c                  no arch gate - already runs
>    progs/exceptions.c:383                  intentionally left alone
>    progs/arena_kfunc.c:219-230             not updated, not explained
> 
> progs/exceptions.c is correctly left alone: DENYLIST.riscv64 lists
> 'exceptions' with the comment "JIT does not support exceptions", and
> arch/riscv/net/ implements no bpf_jit_supports_exceptions().
> 
> progs/arena_kfunc.c is not explained. It gates its stack-argument test
> with test_loader arch annotations rather than a preprocessor guard:
> 
>    #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
>            defined(__BPF_FEATURE_STACK_ARGUMENT)
>    SEC("syscall")
>    __arch_x86_64
>    __arch_arm64
>    __failure __msg("arena pointer cannot be a stack argument")
>    int arena_arg_stack(void *ctx)
> 
> test_loader.c skips any test whose arch mask does not contain the running
> arch, so arena_arg_stack stays skipped on RV64 after this patch.
> 
> Does anything block it from running on RV64?  bpf_jit_supports_arena()
> returns true on riscv64, DENYLIST.riscv64 contains only 'exceptions', and
> arena_arg_stack is a __failure test so it only needs the verifier to reach
> the "arena pointer cannot be a stack argument" check - which now happens
> on RV64 because the preceding commit makes bpf_jit_supports_stack_args()
> return true.
> 
> Should __arch_riscv64 be added to progs/arena_kfunc.c's arena_arg_stack
> (and the #else dummy_test, which carries the same two annotations), or is
> there a reason it should stay on x86_64/arm64 only?

not yet support bpf_jit_supports_arena_args and Kumar have been worked 
on this [0].

[0] https://lore.kernel.org/bpf/20260821233516.3426127-4-memxor@gmail.com/

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952202002

