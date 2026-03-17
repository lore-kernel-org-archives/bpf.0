Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439828314E
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 03:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716754; cv=none; b=TqXo70YhK2gfaw3sKcvuVxHHIpb9lCm+X4rQtbE9/8yR276HEIU7B9KNpG6Vzy96FWzMszBXXh0tIjV3fuZcVSD29R6lMw22Lkrxyk1XJqC6foFWv8UNAFGri7yv+k0V7JO4cvfszODrucHj4kQUjwk1WtHJ3xsx4qDUPHSwNsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716754; c=relaxed/simple;
	bh=EVNUqhUDWzGyVjEV9QO0rvVN6bcK5wFqP96BNBHl4Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIFWenbh165JpJmNe6D+0ustLdxPY+71XvbixCCP1sWs7q4N2QR7HdJt/1JqhcQFD7QdTNAnYXx4B219EnllaeisKf3s1RNKrVHa2UMj9NAv4H4/72Mf8STL39usloihzTlalGZxiXwK2XPgBlHFRhJWuhS/Zdm89sqF+CCDgsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hm7D5r82; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hm7D5r82"
Message-ID: <63fa6255-8682-495d-abe1-d30d72a7ece9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773716741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKkfDxE1gmpWY989mj+fPlSG7Le6DlgZvqj7ln7Hqhc=;
	b=hm7D5r82ea7UUZrEVHLbcJ9Ovaq0Uy/9dg8Nby1DIzetBx+K+vSlLd8lLGUU1mmcHhy7yO
	WGNU96L8CtSIDx6tBnQSSFaAxWq1yojvqHLfr9XBB3cczO1af0XXk3b4+8ujap/aX0iMWm
	hdUpz1pq26l/tHDhFmE2X/UmnVGpQ7A=
Date: Tue, 17 Mar 2026 11:05:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 19/24] selftests/bpf: Add tracing multi
 intersect tests
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@kernel.org>
References: <20260316075138.465430-1-jolsa@kernel.org>
 <20260316075138.465430-20-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260316075138.465430-20-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/3/26 15:51, Jiri Olsa wrote:
> Adding tracing multi tests for intersecting attached functions.
> 
> Using bits from (from 1 to 16 values) to specify (up to 4) attached
> programs, and randomly choosing bpf_fentry_test* functions they are
> attached to.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |  4 +-
>  .../selftests/bpf/prog_tests/tracing_multi.c  | 99 +++++++++++++++++++
>  .../progs/tracing_multi_intersect_attach.c    | 42 ++++++++
>  3 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index cf01a11d7803..e56e213441d8 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -486,7 +486,8 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
>  		linked_vars.skel.h linked_maps.skel.h 			\
>  		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
>  		test_usdt.skel.h tracing_multi.skel.h			\
> -		tracing_multi_module.skel.h
> +		tracing_multi_module.skel.h				\
> +		tracing_multi_intersect.skel.h
>  
>  LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
>  	core_kern.c core_kern_overflow.c test_ringbuf.c			\
> @@ -514,6 +515,7 @@ xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
>  xdp_features.skel.h-deps := xdp_features.bpf.o
>  tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
>  tracing_multi_module.skel.h-deps := tracing_multi_attach_module.bpf.o tracing_multi_check.bpf.o
> +tracing_multi_intersect.skel.h-deps := tracing_multi_intersect_attach.bpf.o tracing_multi_check.bpf.o
>  
>  LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
>  LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> index e9042d8d4760..b7818f438d6e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
> @@ -6,6 +6,7 @@
>  #include "bpf/libbpf_internal.h"
>  #include "tracing_multi.skel.h"
>  #include "tracing_multi_module.skel.h"
> +#include "tracing_multi_intersect.skel.h"
>  #include "trace_helpers.h"
>  
>  static const char * const bpf_fentry_test[] = {
> @@ -31,6 +32,20 @@ static const char * const bpf_testmod_fentry_test[] = {
>  
>  #define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
>  
> +static int get_random_funcs(const char **funcs)
> +{
> +	int i, cnt = 0;
> +
> +	for (i = 0; i < FUNCS_CNT; i++) {
> +		if (rand() % 2)
                    ^ srand() is missing for rand() ?

> +			funcs[cnt++] = bpf_fentry_test[i];
> +	}
> +	/* we always need at least one.. */
> +	if (!cnt)
> +		funcs[cnt++] = bpf_fentry_test[rand() % FUNCS_CNT];
> +	return cnt;
> +}
> +
>  static int compare(const void *ppa, const void *ppb)
>  {
>  	const char *pa = *(const char **) ppa;
> @@ -328,6 +343,88 @@ static void test_module_link_api_ids(void)
>  	free(ids);
>  }
>  
> +static bool is_set(__u32 mask, __u32 bit)
> +{
> +	return (1 << bit) & mask;
> +}
> +
> +static void __test_intersect(__u32 mask, const struct bpf_program *progs[4], __u64 *test_results[4])
> +{
> +	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct bpf_link *links[4] = { NULL };
> +	const char *funcs[FUNCS_CNT];
> +	__u64 expected[4];
> +	__u32 *ids, i;
> +	int err, cnt;
> +
> +	/*
> +	 * We have 4 programs in progs and the mask bits pick which
> +	 * of them gets attached to randomly chosen functions.
> +	 */
> +	for (i = 0; i < 4; i++) {
> +		if (!is_set(mask, i))
> +			continue;
> +
> +		cnt = get_random_funcs(funcs);
> +		ids = get_ids(funcs, cnt, NULL);
> +		if (!ASSERT_OK_PTR(ids, "get_ids"))
> +			goto cleanup;
> +
> +		opts.ids = ids;
> +		opts.cnt = cnt;
> +		links[i] = bpf_program__attach_tracing_multi(progs[i], NULL, &opts);
> +		free(ids);
> +
> +		if (!ASSERT_OK_PTR(links[i], "bpf_program__attach_tracing_multi"))
> +			goto cleanup;
> +
> +		expected[i] = *test_results[i] + cnt;
> +	}
> +
> +	err = bpf_prog_test_run_opts(bpf_program__fd(progs[0]), &topts);
> +	ASSERT_OK(err, "test_run");
> +
> +	for (i = 0; i < 4; i++) {
> +		if (!is_set(mask, i))
> +			continue;
> +		ASSERT_EQ(*test_results[i], expected[i], "test_results");
> +	}
> +
> +cleanup:
> +	for (i = 0; i < 4; i++)
> +		bpf_link__destroy(links[i]);
> +}
> +
> +static void test_intersect(void)
> +{
> +	struct tracing_multi_intersect *skel;
> +	const struct bpf_program *progs[4];
> +	__u64 *test_results[4];
> +	__u32 i;
> +
> +	skel = tracing_multi_intersect__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "tracing_multi_intersect__open_and_load"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	progs[0] = skel->progs.fentry_1;
> +	progs[1] = skel->progs.fexit_1;
> +	progs[2] = skel->progs.fentry_2;
> +	progs[3] = skel->progs.fexit_2;
> +
> +	test_results[0] = &skel->bss->test_result_fentry_1;
> +	test_results[1] = &skel->bss->test_result_fexit_1;
> +	test_results[2] = &skel->bss->test_result_fentry_2;
> +	test_results[3] = &skel->bss->test_result_fexit_2;
> +
> +	for (i = 1; i < 16; i++)
> +		__test_intersect(i, progs, test_results);
> +
> +	tracing_multi_intersect__destroy(skel);
> +}
> +
>  void test_tracing_multi_test(void)
>  {
>  #ifndef __x86_64__
> @@ -347,4 +444,6 @@ void test_tracing_multi_test(void)
>  		test_module_link_api_pattern();
>  	if (test__start_subtest("module_link_api_ids"))
>  		test_module_link_api_ids();
> +	if (test__start_subtest("intersect"))
> +		test_intersect();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> new file mode 100644
> index 000000000000..b8aecbf44093
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <linux/bpf.h>
NIT:         ^ vmlinux.h is better than stdbool.h + bpf.h.

Thanks,
Leon

> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__hidden extern void tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return);
> +
> +__u64 test_result_fentry_1 = 0;
> +__u64 test_result_fentry_2 = 0;
> +__u64 test_result_fexit_1 = 0;
> +__u64 test_result_fexit_2 = 0;
> +
> +SEC("fentry.multi")
> +int BPF_PROG(fentry_1)
> +{
> +	tracing_multi_arg_check(ctx, &test_result_fentry_1, false);
> +	return 0;
> +}
> +
> +SEC("fentry.multi")
> +int BPF_PROG(fentry_2)
> +{
> +	tracing_multi_arg_check(ctx, &test_result_fentry_2, false);
> +	return 0;
> +}
> +
> +SEC("fexit.multi")
> +int BPF_PROG(fexit_1)
> +{
> +	tracing_multi_arg_check(ctx, &test_result_fexit_1, true);
> +	return 0;
> +}
> +
> +SEC("fexit.multi")
> +int BPF_PROG(fexit_2)
> +{
> +	tracing_multi_arg_check(ctx, &test_result_fexit_2, true);
> +	return 0;
> +}

