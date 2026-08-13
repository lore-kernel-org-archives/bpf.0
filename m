Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C435C6BB
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622857; cv=none; b=YgFIeT50Ogy3UZo8G1nT2J38ZoG9QLfdNIXGD4pSr4sa7tAOrEJso4S240+oU97thx9FeRPUvmUms+WoGJ6YP5BWm1hDWFrc+a/Kvdngb7faB5HCkz8G4OF4UQq3uaPJy43K0Qt8B4Z2A49mk7wXyFgmSkgUxNl93cbZymwJN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622857; c=relaxed/simple;
	bh=Pj2TObfA8UylNVAeBV8UurltJ3ey3QIws3S0QUS+UC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcHlY1h36svVAUZM/DLMa6pLu8OkaJMZHJjX6a0zjOnAQPsl1uZnraXm76OupY6QvfgyudZxMAYr1beZZ1zn78/deHdC+taqFS3xYtbKWDX+jqkH1NVQZsVqHs7Nx2QYBwTK0SLRsVuqDSarZOy0y7g0IALgPGZV/pBu1d0SR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLPHL1XnkzKHMjY
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:07:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 79CDA4063F
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:07:29 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCnEIiAs31qLeC1CA--.52902S2;
	Thu, 13 Aug 2026 20:07:29 +0800 (CST)
Message-ID: <3a73a91f-ff21-4a72-9a63-a351c3120b8e@huaweicloud.com>
Date: Thu, 13 Aug 2026 20:07:28 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: Test a multi-slot argument
 before a struct_ops arena argument
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
 <20260810190922.3408757-8-puranjay@kernel.org>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <20260810190922.3408757-8-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnEIiAs31qLeC1CA--.52902S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW3tF1UKFy5KFWUGFWUtwb_yoWxAw4UpF
	WxAw1YkF4xJr4UZF13Wa1UXr4FkwsxXr4UGFW7Jr95Zr93Xa4DJFW8KF1Fyrn5GrWrZ3WY
	ywn2krZ8Ga10qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UG-eOUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 8/11/2026 3:09 AM, Puranjay Mohan wrote:
> The trampoline reads the __arena flag from the btf_func_model per
> argument but stores the ctx one register slot at a time, so the two only
> line up if every preceding argument occupies exactly one slot. Every
> arena-bearing member of bpf_testmod_ops3 takes single-slot arguments, so
> nothing exercises the mapping and a mis-indexed arg_flags lookup would
> go unnoticed on any architecture.
> 
> Add test_arena_multislot(), whose first argument is a 16-byte struct
> passed by value. It fills ctx[0] and ctx[1], putting the arena pointer
> at argument index one but slot two. The callback checks both halves of
> the struct before dereferencing ctx[2], so a JIT that walks registers
> instead of arguments converts the wrong slot and fails the test.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>   .../selftests/bpf/progs/struct_ops_arena.c    | 24 +++++++++++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 ++++++++++++
>   .../selftests/bpf/test_kmods/bpf_testmod.h    |  8 +++++++
>   .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
>   4 files changed, 48 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
> index ba04c73d8d967..8aa8639df91f0 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
> @@ -59,11 +59,28 @@ int test_arena_stack_cb(unsigned long long *ctx)
>   	return 0;
>   }
>   
> +SEC("struct_ops/test_arena_multislot")
> +int test_arena_multislot_cb(unsigned long long *ctx)
> +{
> +	u64 __arena *ptr = (u64 __arena *)ctx[2];
> +
> +	arena_touch++;
> +	/*
> +	 * The 16-byte struct occupies ctx[0] and ctx[1], so @ptr is argument
> +	 * one but slot two. Getting that wrong hands the callback a scalar.
> +	 */
> +	if (ctx[0] != 11 || ctx[1] != 22)
> +		return 0xbad;
> +	*ptr += 1;
> +	return 0;
> +}
> +
>   SEC(".struct_ops.link")
>   struct bpf_testmod_ops3 testmod_arena = {
>   	.test_arena = (void *)test_arena_cb,
>   	.test_arena_nullable = (void *)test_arena_nullable_cb,
>   	.test_arena_stack = (void *)test_arena_stack_cb,
> +	.test_arena_multislot = (void *)test_arena_multislot_cb,
>   };
>   
>   SEC("syscall")
> @@ -109,6 +126,13 @@ int trigger(void *ctx)
>   	if (*val != 44)
>   		return 9;
>   
> +	/* a multi-slot arg precedes the arena pointer here */
> +	ret = bpf_testmod_ops3_call_test_arena_multislot((u64 *)val);
> +	if (ret)
> +		return 10;
> +	if (*val != 45)
> +		return 11;
> +
>   	bpf_arena_free_pages(&arena, (void __arena *)val, 1);
>   #endif
>   	return 0;
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index a6133f7521f34..9366a3c578f13 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -402,12 +402,19 @@ static int bpf_testmod_ops3__test_arena_stack(u64 a, u64 b, u64 c, u64 d,
>   	return 0;
>   }
>   
> +static int bpf_testmod_ops3__test_arena_multislot(struct bpf_testmod_arena_pair p,
> +						  u64 *ptr__arena)
> +{
> +	return 0;
> +}
> +
>   static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
>   	.test_1 = bpf_testmod_test_3,
>   	.test_2 = bpf_testmod_test_4,
>   	.test_arena = bpf_testmod_ops3__test_arena,
>   	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
>   	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
> +	.test_arena_multislot = bpf_testmod_ops3__test_arena_multislot,
>   };
>   
>   static void bpf_testmod_test_struct_ops3(void)
> @@ -441,6 +448,13 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_stack(u64 *ptr__arena)
>   	return st_ops3->test_arena_stack(1, 2, 3, 4, 5, 6, 7, 8, ptr__arena);
>   }
>   
> +__bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
> +{
> +	struct bpf_testmod_arena_pair p = { .a = 11, .b = 22 };
> +
> +	return st_ops3->test_arena_multislot(p, ptr__arena);
> +}
> +
>   struct bpf_testmod_btf_type_tag_1 {
>   	int a;
>   };
> @@ -852,6 +866,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_2)
>   BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
>   BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
>   BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
> +BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
>   BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
>   BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
>   BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> index 33f2af5b70857..210b919290cc2 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
> @@ -103,6 +103,12 @@ struct bpf_testmod_ops2 {
>   	int (*test_1)(void);
>   };
>   
> +/* 16 bytes, so it takes two argument slots when passed by value */
> +struct bpf_testmod_arena_pair {
> +	u64 a;
> +	u64 b;
> +};
> +
>   struct bpf_testmod_ops3 {
>   	int (*test_1)(void);
>   	int (*test_2)(void);
> @@ -112,6 +118,8 @@ struct bpf_testmod_ops3 {
>   	/* enough leading args to force @ptr onto the stack on x86 and arm64 */
>   	int (*test_arena_stack)(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f,
>   				u64 g, u64 h, u64 *ptr);
> +	/* a multi-slot leading arg, so @ptr is not at the slot its arg index suggests */
> +	int (*test_arena_multislot)(struct bpf_testmod_arena_pair p, u64 *ptr);
>   };
>   
>   struct st_ops_args {
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> index c4383acb53c11..7d81070eefe7f 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
> @@ -123,6 +123,7 @@ void bpf_testmod_test_mod_kfunc(int i) __ksym;
>   int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
>   int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
>   int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
> +int bpf_testmod_ops3_call_test_arena_multislot(__u64 *ptr__arena) __ksym;
>   
>   __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
>   				__u32 c, __u64 d) __ksym;

Acked-by: Xu Kuohai <xukuohai@huawei.com>

