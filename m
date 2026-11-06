Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793935724;
	b=5hz1dDh6bEMIu9QYrs8yzP7OqEW9BmURPKJ60ICHaQtlS3k3qx1gKEta38nOfgLITlPN
	 NpEXKF61H6IHfBU8epMqWIpT7Vnxd2hTQ3CrezHsfRFgKnI/wz4enccoNmXJNNSvgH6B8
	 JL+cK91btZUq1fl5QOrF8gjpxNwm2PNsFklIYu12xO4/521M37Nf+tT2m8n8mxUkYYtIc
	 MNtvpf7JbYldUeQOCva8RVvsbC32SFIneoUDOvmhpP/aLvOVng+tvENZQgG+1otmVDcg/
	 z0aECvFgVwGXO6UxwKwXig0Q0RR5MXgMtFNUH5LETBVaTGjlUr1nUM2lGasIDF0NGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793935724;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 CC:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=yRj7ZrhzBHolO44PFJNnKugjKH5+LOHE1/UFniKyUQY=;
	b=2R/E4lnPjfq9P7ehYRgVUH4ZiYot+YuY58Hj5OnNh8HE/lxPnCiRfASm9Uo0NftpyoSo
	 OEXqLiZ7qZa/pNz+WA4GQorRNQgJ/ijDX/51lW/hKLVKjFoy30eYRLubX5WDHd4Jemb1y
	 UiGsWLWuOINXliB3f4DyBVnOLCDlKqwEE6ERDn2oVRw2cfYktfgNZKVaebtj+qt2XJ5Js
	 ipDZnXTFUDjgZHBbh81A9Gfd/BNQTrskbP22mAJvCP8/KnUSvy4KOZPCeOkQ5B4/VOFGy
	 J4DXefxTbpNcslOeDttfgJpvHXO75feFBuv7zySjlYsB4hhD8xo3T+VaSrw2dKyNx3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="jv8ea/1t";
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F213606A31B;
	Fri,  6 Nov 2026 03:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F213606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=jv8ea/1t
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yRj7ZrhzBHolO44PFJNnKugjKH5+LOHE1/UFniKyUQY=;
	b=jv8ea/1t+7GDxMkO/TG3/UWTtGPBNQ6ibf/JeZCMazQPymy7zcQ+TFP0KsiIdGIbY+tl/V9fQ
	8VKOrujrg2wjxM6/rmLzLaSK+nRRyaurlFFfBcE0vQwc524SBcqZ/B0LPMKdmC8HXyfJvsCDKfr
	iTrSpowedX9GssJxSSasRT0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jLPlG0QVdz1T4gG;
	Fri,  6 Nov 2026 11:28:10 +0800 (CST)
Received: from dggpemr100013.china.huawei.com (unknown [7.185.36.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 4532C4056E;
	Fri,  6 Nov 2026 11:28:32 +0800 (CST)
Received: from whupemq100006.china.huawei.com (7.152.184.206) by
 dggpemr100013.china.huawei.com (7.185.36.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 11:28:32 +0800
Received: from [10.67.110.154] (10.67.110.154) by
 whupemq100006.china.huawei.com (7.152.184.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 6 Nov 2026 11:28:29 +0800
Message-ID: <ffc28af6-ab99-4006-a827-c3006dba096e@huawei.com>
Date: Fri, 6 Nov 2026 11:28:28 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/3] selftests/bpf: Enable private stack tests
 for riscv64
Content-Language: en-US
To: Chen Pei <cp0613@linux.alibaba.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<bjorn@kernel.org>, <puranjay@kernel.org>
CC: <eddyz87@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<ihor.solodrai@linux.dev>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <luke.r.nels@gmail.com>,
	<xi.wang@gmail.com>, <shuah@kernel.org>, <rgbi3307@gmail.com>,
	<guoren@kernel.org>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20261104100411.997-1-cp0613@linux.alibaba.com>
 <20261104100411.997-3-cp0613@linux.alibaba.com>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20261104100411.997-3-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemq100006.china.huawei.com (7.152.184.206)



On 2026/11/4 18:04, Chen Pei wrote:
> The RV64 JIT now supports the private stack. Allow the existing
> verifier and struct_ops private-stack tests to run on riscv64 and add
> the expected RV64 JITed instruction patterns.
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>   .../bpf/prog_tests/struct_ops_private_stack.c |  3 +-
>   .../bpf/progs/verifier_private_stack.c        | 41 ++++++++++++++++++-
>   2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> index 2b3ec2b79091..103179ff8733 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> @@ -6,7 +6,8 @@
>   #include "struct_ops_private_stack_recur.skel.h"
>   #include "struct_ops_private_stack_large.skel.h"
>   
> -#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__)
> +#if defined(__x86_64__) || defined(__aarch64__) || defined(__powerpc64__) || \
> +	(defined(__riscv) && __riscv_xlen == 64)
>   static void test_private_stack(void)
>   {
>   	struct struct_ops_private_stack *skel;
> diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> index bbc09f516d92..4df06a82dd04 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> @@ -8,7 +8,8 @@
>   /* From include/linux/filter.h */
>   #define MAX_BPF_STACK    512
>   
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> +#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
> +	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
>   
>   struct elem {
>   	struct bpf_timer t;
> @@ -42,6 +43,14 @@ __jited("	mov	x0, #0x2a")
>   __jited("	str	x0, [x27]")
>   __jited("...")
>   __jited("	ldp	x25, x27, [sp], {{.*}}")
> +__arch_riscv64
> +__jited("	addi	sp, sp, -0x20")
> +__jited("...")
> +__jited("	sd	s5, 0x10(sp)")
> +__jited("...")
> +__jited("	sd	a0, -0x100(s5)")
> +__jited("...")
> +__jited("	ld	s5, 0x10(sp)")
>   __naked void private_stack_single_prog(void)
>   {
>   	asm volatile ("			\
> @@ -60,6 +69,10 @@ __jited("	subq	$0x8, %rsp")
>   __arch_arm64
>   __jited("	mov	x25, sp")
>   __jited("	sub	sp, sp, #0x10")
> +__arch_riscv64
> +__jited("	addi	sp, sp, -0x30")
> +__jited("...")
> +__jited("	addi	s5, sp, 0x10")
>   __naked void no_private_stack_nested(void)
>   {
>   	asm volatile ("			\
> @@ -113,6 +126,14 @@ __jited("	str	x0, [x27]")
>   __jited("	bl	{{.*}}")
>   __jited("...")
>   __jited("	ldp	x25, x27, [sp], {{.*}}")
> +__arch_riscv64
> +__jited("	addi	sp, sp, -0x20")
> +__jited("...")
> +__jited("	sd	s5, 0x8(sp)")
> +__jited("...")
> +__jited("	sd	a0, -0x200(s5)")
> +__jited("...")
> +__jited("	ld	s5, 0x8(sp)")
>   __naked void private_stack_nested_1(void)
>   {
>   	asm volatile ("				\
> @@ -183,6 +204,16 @@ __jited("	bl	0x{{.*}}")
>   __jited("	mov	x8, x0")
>   __jited("	mov	x8, #0x0")
>   __jited("	ldp	x25, x27, [sp], {{.*}}")
> +__arch_riscv64
> +__jited("func #1")
> +__jited("...")
> +__jited("	addi	sp, sp, -0x20")
> +__jited("...")
> +__jited("	sd	s5, 0x8(sp)")
> +__jited("...")
> +__jited("	sd	a0, -0x200(s5)")
> +__jited("...")
> +__jited("	ld	s5, 0x8(sp)")
>   __naked void private_stack_callback(void)
>   {
>   	asm volatile ("			\
> @@ -412,6 +443,10 @@ __arch_arm64
>   __jited("	mrs	x10, TPIDR_EL{{[0-1]}}")
>   __jited("	add	x27, x27, x10")
>   __jited("	add	x25, x27, {{.*}}")
> +__arch_riscv64
> +__jited("	addi	sp, sp, -0x20")
> +__jited("...")
> +__jited("	sd	s5, 0x8(sp)")
>   int private_stack_async_callback_1(void)
>   {
>   	struct bpf_timer *arr_timer;
> @@ -441,6 +476,10 @@ __arch_x86_64
>   __jited("	subq	$0x100, %rsp")
>   __arch_arm64
>   __jited("	sub	sp, sp, #0x100")
> +__arch_riscv64
> +__jited("	addi	sp, sp, -0x120")
> +__jited("...")
> +__jited("	addi	s5, sp, 0x100")
>   int private_stack_async_callback_2(void)
>   {
>   	struct bpf_timer *arr_timer;

Apart from not yet supporting exception handling, everything else is fine.

Reviewed-by: Pu Lehui <pulehui@huawei.com>
