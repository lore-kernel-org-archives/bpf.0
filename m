Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DB3BADB2
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622230; cv=none; b=pm9/XqVf8s20FczrJZ31hbD1v4v9kPEhlLltT510OIHL5RzmU+KxII9I+HO0LgMCb4O1eCW/9cBpMhLM+fSynn4W4lr7MRneoQbabZbJCwUA2wuOk84btpdrjoqfKyHv2SMadSyvQybdAkGD/HwEoklk8KR3tdfTq7UcO+kF40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622230; c=relaxed/simple;
	bh=5SRbkp8NUeur7rCEjEC45m4GLQtcb0VNmjOT6IGm1zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ji6PnFTtzXMlwGW8HAt95t/otwMsCflWTpJXQ4zvhHqagO4GLTUExmdS66pAAG57MCVQIBHjHGz3ozrp5oyt89Nv7+RS2vBruAnR3M3auI0I+W/uM31z9BQsXVYgRhD1DuLjETsm21copYgqE3H2340DxRuA3GfoREH6R1SJKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLP3W0LhwzYQvXg
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:56:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B32AC4058F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:57:01 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAXBkUNsX1qWJ2oCA--.26280S2;
	Thu, 13 Aug 2026 19:57:01 +0800 (CST)
Message-ID: <8f8e4b1a-4b4e-4d42-8038-fc7755f76e73@huaweicloud.com>
Date: Thu, 13 Aug 2026 19:57:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: Enable __arena argument tests
 on arm64
Content-Language: en-US
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20260810190922.3408757-1-puranjay@kernel.org>
 <20260810190922.3408757-7-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-7-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXBkUNsX1qWJ2oCA--.26280S2
X-Coremail-Antispam: 1UD129KBjvJXoWxury3Cr1DGw1kJryxJr1UKFg_yoWrZrykp3
	WUC3WYkrWrtw4UCFyrWw17ZF4ruws3JrW5Gr1rJ348AFsrZrnxtr4rKa45twn0kr1fuw4Y
	9340yr929w4UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrs
	qXDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
> The arena kfunc and struct_ops argument tests were restricted to x86-64
> because it was the only JIT that implemented the conversions. arm64 does
> now, so let them run there too: tag every program in arena_kfunc.c with
> __arch_arm64 in addition to __arch_x86_64, and widen the __x86_64__
> guards in the struct_ops arena test.
> 
> Without this the tests report SKIP on arm64 rather than exercising the
> newly added JIT support.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   .../selftests/bpf/prog_tests/test_struct_ops_arena.c   | 10 +++++-----
>   tools/testing/selftests/bpf/progs/arena_kfunc.c        |  9 +++++++++
>   2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> index 940ec2cda0d52..7f9f54ba3fbe5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
> @@ -6,7 +6,7 @@
>   #include "struct_ops_arena_attach.skel.h"
>   #include "struct_ops_arena_fail.skel.h"
>   
> -#if defined(__x86_64__)
> +#if defined(__x86_64__) || defined(__aarch64__)
>   /*
>    * Attach callbacks with __arena and __arena__nullable arguments and drive
>    * them through the bpf_testmod_ops3_call_test_arena*() kfuncs.
> @@ -111,11 +111,11 @@ static void arena_arg_attach(void)
>   void serial_test_struct_ops_arena(void)
>   {
>   	/*
> -	 * Arena struct_ops arguments need JIT support, currently x86-64 only.
> -	 * Elsewhere verification fails with "JIT does not support arena
> -	 * arguments", so the programs cannot even load.
> +	 * Arena struct_ops arguments need JIT support, currently x86-64 and
> +	 * arm64 only. Elsewhere verification fails with "JIT does not support
> +	 * arena arguments", so the programs cannot even load.
>   	 */
> -#if defined(__x86_64__)
> +#if defined(__x86_64__) || defined(__aarch64__)
>   	if (test__start_subtest("arena_arg"))
>   		arena_arg();
>   	if (test__start_subtest("arena_arg_fail"))
> diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc.c b/tools/testing/selftests/bpf/progs/arena_kfunc.c
> index cdcea889da586..bf0d304e0e59c 100644
> --- a/tools/testing/selftests/bpf/progs/arena_kfunc.c
> +++ b/tools/testing/selftests/bpf/progs/arena_kfunc.c
> @@ -27,6 +27,7 @@ volatile u64 stash;
>   
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __success __retval(0)
>   int arena_arg_forms(void *ctx)
>   {
> @@ -70,6 +71,7 @@ int arena_arg_forms(void *ctx)
>    */
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __success __retval(0)
>   int arena_arg_rebase(void *ctx)
>   {
> @@ -111,6 +113,7 @@ int arena_arg_rebase(void *ctx)
>   
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __success __retval(0)
>   int arena_args5(void *ctx)
>   {
> @@ -142,6 +145,7 @@ int arena_args5(void *ctx)
>   
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __success __retval(0)
>   int arena_arg_mixed(void *ctx)
>   {
> @@ -169,6 +173,7 @@ int arena_arg_mixed(void *ctx)
>   /* kernel-side faults on unpopulated pages recover via the scratch page */
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __success __retval(0)
>   int arena_arg_unpopulated(void *ctx)
>   {
> @@ -189,6 +194,7 @@ int arena_arg_unpopulated(void *ctx)
>   
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __failure __msg("arena pointer requires a program with an associated arena")
>   int arena_arg_no_arena(void *ctx)
>   {
> @@ -198,6 +204,7 @@ int arena_arg_no_arena(void *ctx)
>   
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __failure __msg("is not a pointer to arena or scalar")
>   int arena_arg_bad_reg(void *ctx)
>   {
> @@ -213,6 +220,7 @@ int arena_arg_bad_reg(void *ctx)
>   	defined(__BPF_FEATURE_STACK_ARGUMENT)
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __failure __msg("arena pointer cannot be a stack argument")
>   int arena_arg_stack(void *ctx)
>   {
> @@ -223,6 +231,7 @@ int arena_arg_stack(void *ctx)
>   #else
>   SEC("syscall")
>   __arch_x86_64
> +__arch_arm64
>   __description("arena_arg_stack: not supported, dummy test")
>   __success
>   int arena_arg_stack(void *ctx)

Acked-by: Xu Kuohai <xukuohai@huawei.com>

