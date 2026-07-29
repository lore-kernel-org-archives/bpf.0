Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA05381E95
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 21:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361815; cv=none; b=Btb8B71vv/2L4gsCXd0YjHeVYvjq2wSwrE7DPTQRZQKG5ouFXWAujH9gX5W2cOtg6XGU0OJtbRyYsp1cdyq2TmChAc6mLBZpgJqS7KgjWaH58+Rw9uCSJGtc6zcxVESCgFcg3LgLvvQ9toq8HPq6R641rrKkUyrxQLbU2Be2O0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361815; c=relaxed/simple;
	bh=o1ASn4or1x9BmC3+KhogLZj4uDsNK2whfGrV1uJgxfA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=V5djFCXzrYvkk+fxPP4Df7cxidK+dwVGgQuUWS1VKRSYB8BqM4u68d3McJeS1jlQT8kC4xtNo7T7ypoGbQsU2McrMZfnL85FBSFLLEpl++30fhyiY+rbGplqA3P2XGy8J8oYqC7zsLh1NOBMEYjl8A2E+kagMAsZNViLLLuQ6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwyU78jz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwyU78jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04861F000E9;
	Wed, 29 Jul 2026 21:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785361813;
	bh=tGTndeRh2UwtB78dmC0gYEM4cR9FQHA5jEH8LKsY9yU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TwyU78jzN8jUR+/iABkOTUO1nUhDRx19mYyhtY2EQWvrN4L4+T9xIMFFBdi2Q02M+
	 r29YeEpFg9tlrq6w2PMiov0b7QgM4q4CSMTNvHP/BL+5ehHOwPwg0ZbFMiNIS0NUh0
	 mDUC/ZdiL+D5VPSaTqrDjS77Uxry1H6ET0uTmhRm7/2AUyqT2UqoO6XYDA8tjdPjkv
	 EEBqOzhgwgjY3t8ADbVITy74j71MLAKb73gmEvJ+H3Dy/m7Rv4MODibbQ1z/SPhwi6
	 5OCfRh1Vv1c4eYhyz9kMMUO30ub3pmY7h0FbFYmiMHvehuv15909FqtEHdvdwNLGOL
	 cpoTGTzPPxM0g==
Content-Type: multipart/mixed; boundary="===============8256229396692884881=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a2da86806725e3336c52a8251c7ee976c1ceba9eb9812e7328dd963b9e04ffd4@mail.kernel.org>
In-Reply-To: <20260729203633.213973-7-puranjay@kernel.org>
References: <20260729203633.213973-7-puranjay@kernel.org>
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: Add bpf_for() benchmark
From: bot+bpf-ci@kernel.org
To: puranjay@kernel.org,bpf@vger.kernel.org
Cc: puranjay@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 29 Jul 2026 21:50:12 +0000 (UTC)

--===============8256229396692884881==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_for.c b/tools/testing/selftests/bpf/benchs/bench_bpf_for.c
> new file mode 100644
> index 000000000000..730c51ad2dec
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bpf_for.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include <argp.h>
> +#include "bench.h"
> +#include "bpf_for_bench.skel.h"
> +
> +/* BPF triggering benchmarks */
> +static struct ctx {
> +	struct bpf_for_bench *skel;
> +} ctx;
> +
> +static struct {
> +	__u32 nr_loops;
> +} args = {
> +	/*
> +	 * Default to a large loop count so the per-iteration bpf_iter_num_next() cost dominates
> +	 * the one-time bpf_iter_num_new()/destroy() setup and teardown.
> +	 */
> +	.nr_loops = 1000,
> +};

[ ... ]

> +static void *producer(void *input)
> +{
> +	while (true)
> +		/* trigger the bpf program */
> +		syscall(__NR_getpgid);
> +
> +	return NULL;
> +}
> +
> +static void measure(struct bench_res *res)
> +{
> +	res->hits = atomic_swap(&ctx.skel->bss->hits, 0);
> +}
> +
> +static void setup(void)
> +{
> +	struct bpf_link *link;
> +
> +	setup_libbpf();
> +
> +	ctx.skel = bpf_for_bench__open_and_load();
> +	if (!ctx.skel) {
> +		fprintf(stderr, "failed to open skeleton\n");
> +		exit(1);
> +	}
> +
> +	link = bpf_program__attach(ctx.skel->progs.benchmark);
> +	if (!link) {
> +		fprintf(stderr, "failed to attach program!\n");
> +		exit(1);
> +	}
> +
> +	ctx.skel->bss->nr_loops = args.nr_loops;
> +}

This isn't a bug, but since this ends up identical to bench_bpf_loop.c
apart from the skeleton name and the nr_loops default, would it be worth
sharing the argp/validate/producer/measure scaffolding between the two,
or is a standalone file per benchmark the preferred shape for benchs/?

> diff --git a/tools/testing/selftests/bpf/progs/bpf_for_bench.c b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
> new file mode 100644
> index 000000000000..f9c723051fc7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_for_bench.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int nr_loops;
> +long hits;
> +
> +static int outer_loop(__u32 index, void *data)
> +{
> +	int i;
> +
> +	/*
> +	 * Empty body: the work being measured is the open-coded numeric iterator itself
> +	 * (bpf_iter_num_new/next/destroy behind bpf_for()).
> +	 */
> +	bpf_for(i, 0, nr_loops)
> +		;

This isn't a bug, but would a shorter note here - just that the loop
body is intentionally empty - read closer to bpf_loop_bench.c, given the
changelog already explains what is being measured?

> +	__sync_add_and_fetch(&hits, nr_loops);
> +	return 0;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int benchmark(void *ctx)
> +{
> +	bpf_loop(1000, outer_loop, NULL, 0);
> +	return 0;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30490674177
--===============8256229396692884881==--
