Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC938283C89
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197990; cv=none; b=YrKwlmv11mJAE9Hbm+phoC0oiYBWzBcl7yO9pAbQLGtj7hEQBlwAutTOCpa88nRMDPQ5Ux23Sw0y6KW+ongrlrvH6FXjjoSj6o0An/JBrq1qJr1Ywc0kLePl7TmK2aNf7jfK0ph8w8GV8TBaUkrggNRyiqwCMJTxA/Pvm23Q260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197990; c=relaxed/simple;
	bh=6JVMMNbY7k+1p4GCnl9F9vYCn7F0/qH8X9Y41xX+wmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRKLcwYTRWqehGb6xjAgl2sF6XDzpBu8yagfD1jg2D1dAj9Ye30AjjsHPR+6mbZ15qFyb7b2pRfLgl5Eqc3SGPcgVjqsVWT5YgP4JtsC3tHsLbJJB9qujzR/8YeDvUUAVG+v5PH8QMgIg6OpXug2BIva4jI96ZYZ7a/XzVgvL6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jz7jyq2r; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jz7jyq2r"
Message-ID: <46ec8a73-e827-40ec-b23b-e56d454c89d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773197986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZT2Tm8XggD8n1lORTH0V4G5zU4ACmmRTZ7Ve8jBPXo=;
	b=jz7jyq2rLiYzGEcW6+fgWYJs8WZdXSOrRJRzsfl89U1anJUTn+XandeS4RdyJDn3xBgdCR
	BbY5XRlACHqe7N15kU6elbrF9pXwt1JbIRgKokkLL2ja22MXXqp6HIc1ai7WFdwmdMLIM1
	4gMTRZO5p483SyNvikzl1D+Zf7UB0N0=
Date: Tue, 10 Mar 2026 19:59:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add deep call stack selftests
Content-Language: en-GB
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, martin.lau@kernel.org, memxor@gmail.com, song@kernel.org
References: <20260309204430.201219-1-emil@etsalapatis.com>
 <20260309204430.201219-3-emil@etsalapatis.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260309204430.201219-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/9/26 1:44 PM, Emil Tsalapatis wrote:
> Add tests that demonstrate the verifier support for deep call stacks
> while still enforcing maximum stack size limits.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

In subject, please use 'selftests/bpf: ...' instead of 'bpf: ...'.

> ---
>   .../bpf/prog_tests/test_global_funcs.c        |  2 +
>   .../bpf/progs/test_global_func_deep_stack.c   | 83 +++++++++++++++++++
>   2 files changed, 85 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> index e905cbaf6b3d..500446808908 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
> @@ -18,6 +18,7 @@
>   #include "test_global_func15.skel.h"
>   #include "test_global_func16.skel.h"
>   #include "test_global_func17.skel.h"
> +#include "test_global_func_deep_stack.skel.h"
>   #include "test_global_func_ctx_args.skel.h"
>   
>   #include "bpf/libbpf_internal.h"
> @@ -155,6 +156,7 @@ void test_test_global_funcs(void)
>   	RUN_TESTS(test_global_func15);
>   	RUN_TESTS(test_global_func16);
>   	RUN_TESTS(test_global_func17);
> +	RUN_TESTS(test_global_func_deep_stack);
>   	RUN_TESTS(test_global_func_ctx_args);
>   
>   	if (test__start_subtest("ctx_arg_rewrite"))
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
> new file mode 100644
> index 000000000000..733c3334b7b1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2026 Meta Platforms, Inc and affiliates. */
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +/*
> + * Macro tricks to tersely define for long non-recursive call chains. Add
> + * computation to the functions prevent tail recursion from reducing the
> + * stack size to 0.
> + */
> +
> +#define CAT(a, b) a ## b
> +#define XCAT(a, b) CAT(a, b)
> +
> +#define F_0 \
> +__attribute__((noinline)) \
> +int f0(unsigned long a) { volatile long b = a + 16; if (a == 0) return 0; return b; }
> +
> +#define FN(n, prev) \
> +__attribute__((noinline)) \
> +int XCAT(f, n)(unsigned long a) { volatile long b = XCAT(f, prev)(a - 1); if (!b) return 0; return b + 1; }
> +
> +/* Call chain 33 levels deep. */
> +#define F_1 F_0		FN(1, 0)
> +#define F_2 F_1   	FN(2, 1)

The above two misaligned.

> +#define F_3 F_2   	FN(3, 2)
> +#define F_4 F_3   	FN(4, 3)
> +#define F_5 F_4   	FN(5, 4)
> +#define F_6 F_5   	FN(6, 5)
> +#define F_7 F_6   	FN(7, 6)
> +#define F_8 F_7   	FN(8, 7)
> +#define F_9 F_8   	FN(9, 8)
> +#define F_10 F_9	FN(10, 9)
> +#define F_11 F_10	FN(11, 10)
> +#define F_12 F_11   	FN(12, 11)
> +#define F_13 F_12   	FN(13, 12)
> +#define F_14 F_13   	FN(14, 13)
> +#define F_15 F_14   	FN(15, 14)
> +#define F_16 F_15   	FN(16, 15)
> +#define F_17 F_16   	FN(17, 16)
> +#define F_18 F_17   	FN(18, 17)
> +#define F_19 F_18   	FN(19, 18)
> +#define F_20 F_19	FN(20, 19)
> +#define F_21 F_20	FN(21, 20)
> +#define F_22 F_21   	FN(22, 21)
> +#define F_23 F_22   	FN(23, 22)
> +#define F_24 F_23   	FN(24, 23)
> +#define F_25 F_24   	FN(25, 24)
> +#define F_26 F_25   	FN(26, 25)
> +#define F_27 F_26   	FN(27, 26)
> +#define F_28 F_27   	FN(28, 27)
> +#define F_29 F_28   	FN(29, 28)
> +#define F_30 F_29	FN(30, 29)
> +#define F_31 F_30	FN(31, 30)
> +#define F_32 F_31   	FN(32, 31)
> +
> +#define CAT2(a, b) a ## b
> +#define XCAT2(a, b) CAT2(a, b)
> +
> +#define F(n) XCAT2(F_, n)
> +
> +F(32)
> +
> +/* Ensure that even 32 levels deep, the function verifies. */
> +SEC("syscall")
> +__success
> +int global_func_deep_stack_success(struct __sk_buff *skb)
> +{
> +	return f31(55);
> +}
> +
> +/*
> + * Check we actually honor stack limits (33 * 16 = 528 > 512 = MAX_STACK_DEPTH).

In the above two lines, there are trailing empty space. Use scripts/checkpatch.pl
to check style issues.

> + * The stack depth is 16 because the verifier calls round_up_stack_depth() on
> + * the size.
> + */
> +SEC("syscall")
> +__failure __msg("combined stack size of 34 calls")
> +int global_func_deep_stack_fail(struct __sk_buff *skb)
> +{
> +	return f32(123);
> +}

