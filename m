Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4548662A
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832430; cv=none; b=LDwUmaNIMcSr8k6JBbXlT+5fICFKiRBq3dYr1F6pDryuV8fmH7ll7NhsyJ5cMh1YLWvaKnvjun5yQueuqUlTYBF5BifNnwf7KR/1r9cR38UD7UXIdk8nDj7UamXPLXwMK27Ur5g5b4oj+QfB20DO4EhvDM2htuIakf7f+dZH+1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832430; c=relaxed/simple;
	bh=eV686oZSFXfYX9lko4QvERY3kRM5atE4u3ZoGyd/5nA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpmHXGABu5RFDGJuVzs1g5akKz9mErU7kFmedrqI32BTyF1zc6V9LLULNX6ZAHSftkSUifTEIVCmpTvP6RQzDqCFE4Qnh4i0F9KdgIFerjKySj3xl2Oqb4ND9ZQY0DtRXKIyZfthHEGbuw18lkglsGbk6nLGzhejilcqwqIGbgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9utSw2n; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9utSw2n"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de0093c42so856684f8f.3
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 11:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832416; x=1785437216; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZRj2TxGqPbIXEWqlsTuwmiRAXzyCbQsmiOwCoAXblI=;
        b=l9utSw2nMeFlaE8lwSLxMmDSvtsPbxuCo3K6donaWkxUEVsY7RXSxrs4n8AOqoVpbX
         JjCNZOi0weC7pkwVu2Piav4zESQtJynO769hQROPb1FFw0/t+1k38EQcsjYESjPj4S28
         rTMd4rT3BLgwxiQ5VyXpEXbh5mIHT602rgZ87sHQYPbq718EM5fF3Lb421QXwSc/rN5v
         bjcO03szDWRYv3ZpXhdXj3x4eWhnTTHsZmnWb6TuD1KnEDpvRe49ROYmN874f3NfugFZ
         ymcVGNrdpYbIhpV4XU0J7sz4f309BrNq0QXeCAvNybAqGZhjCO2+gqU93TMn3LGIVCH0
         hg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832416; x=1785437216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZRj2TxGqPbIXEWqlsTuwmiRAXzyCbQsmiOwCoAXblI=;
        b=U9UbbtVzdf1ajU5x87GjdDxtl8MLJ8UkCFEK8BkqjjuSbvsxlo/fTeHp812bre3kZt
         8/M394ydArLwvPd0LOXhQCtULH415cRnmYzvJQ7SCCMRw+edrwZvslf6yjzxys8rl+gB
         dEl6TXCjpyyHhbgUcp3iA+4aoyCzqTygVbxwxuVFg0aEVvDBUa9vWomayyx9jBxjygld
         SKe8uiMGmDieFqp10Ws+T1lQgbbnnCeqyeJOsRDTqjxu1UtAMVMlI0BVDFx8ful0jjzF
         pAtk0c4Ry8Dc+Wg00gVnczMLeTM++HeGR7HLcHPblhIUO8a3KYSk46p/Pnr4rS+zcFdU
         jOIA==
X-Gm-Message-State: AOJu0YwNM4xi5ALXe3QSTX008cBkxNpzsNrIdspf8tOIgZ/o5PFwbVfs
	l4qPQvfbhBWPwyJqy7FXsMkt6HU1lPM8EqkpaGV3bpXpg0SUTwnNpLwD
X-Gm-Gg: AR+sD10sa2G6iVWKm14IWr2BaLtyNizXiul86RrpJXr3LjhW8puuNu7tRzdyv4TCyqK
	0VdcP5K24nstSmPGEN6otcwmpnZzv0vtaOTE9YQH+TcVD0XXpCoJq62Ig/cYKT0MlGq1EyxgO6S
	JTwAHbfU4aUMIr0oDI5aQB3s0K8ln4N2QZq45KJWnTg6MH8mcyMcbAMZzBkXypZxaakBvScmreC
	qsQs+AWchqH+d5qxH3ynSZ6q/hOY8V3+6Xb7yCuQ9PVyaJAMCfRBQ3xclaOrRiJlj6KfSBgJCnL
	ImuzqwToaxX3+7IX0xuLSPl0DB4LBWDuGYphhsmye1OqgGzzAXvl3ntb34U1tDvMTk+Ezd8r/Cl
	f875St0tJa03j48o280sh9rTcswGk72pe5jgFRH7Gpg7zrgykzjFP7duIEOcEWEIYfA==
X-Received: by 2002:a05:6000:2484:b0:47f:8c73:aa7c with SMTP id ffacd0b85a97d-47f8d76c5a8mr5835302f8f.52.1784832415490;
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f939c1465sm3741405f8f.26.2026.07.23.11.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Jul 2026 20:46:53 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark
 for array maps
Message-ID: <amJhnbom_expRgN2@krava>
References: <20260722065308.4116186-1-song@kernel.org>
 <20260722065308.4116186-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722065308.4116186-3-song@kernel.org>

On Tue, Jul 21, 2026 at 11:53:08PM -0700, Song Liu wrote:
> Add a benchmark that repeatedly mmap()s and munmap()s an mmap-able BPF
> array map (BPF_F_MMAPABLE) from a configurable number of threads. Both
> the number of worker threads and the size of the map are tunable via
> --nr-threads and --map-size, defaulting to 16 threads and 8MiB.
> 
> The benchmark is useful to observe how the cost of mmap()/munmap()
> scales with the mapping size, e.g. eager vs lazy page-table population.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../bpf/benchs/bench_arraymap_mmap.c          | 146 ++++++++++++++++++
>  .../bpf/benchs/run_bench_arraymap_mmap.sh     |  15 ++
>  4 files changed, 166 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 55d394438705..b6593fb1135b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1003,6 +1003,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>  		 $(OUTPUT)/bench_bpf_timing.o \
>  		 $(OUTPUT)/bench_bpf_nop.o \
>  		 $(OUTPUT)/bench_xdp_lb.o \
> +		 $(OUTPUT)/bench_arraymap_mmap.o \
>  		 $(OUTPUT)/usdt_1.o \
>  		 $(OUTPUT)/usdt_2.o \
>  		 #
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 3d9d2cd7764b..192d5fcb7a74 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -287,6 +287,7 @@ extern struct argp bench_crypto_argp;
>  extern struct argp bench_sockmap_argp;
>  extern struct argp bench_lpm_trie_map_argp;
>  extern struct argp bench_xdp_lb_argp;
> +extern struct argp bench_arraymap_mmap_argp;
>  
>  static const struct argp_child bench_parsers[] = {
>  	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
> @@ -304,6 +305,7 @@ static const struct argp_child bench_parsers[] = {
>  	{ &bench_sockmap_argp, 0, "bpf sockmap benchmark", 0 },
>  	{ &bench_lpm_trie_map_argp, 0, "LPM trie map benchmark", 0 },
>  	{ &bench_xdp_lb_argp, 0, "XDP load-balancer benchmark", 0 },
> +	{ &bench_arraymap_mmap_argp, 0, "arraymap-mmap benchmark", 0 },
>  	{},
>  };
>  
> @@ -582,6 +584,7 @@ extern const struct bench bench_lpm_trie_delete;
>  extern const struct bench bench_lpm_trie_free;
>  extern const struct bench bench_bpf_nop;
>  extern const struct bench bench_xdp_lb;
> +extern const struct bench bench_arraymap_mmap;
>  
>  static const struct bench *benchs[] = {
>  	&bench_count_global,
> @@ -665,6 +668,7 @@ static const struct bench *benchs[] = {
>  	&bench_lpm_trie_free,
>  	&bench_bpf_nop,
>  	&bench_xdp_lb,
> +	&bench_arraymap_mmap,
>  };
>  
>  static void find_benchmark(void)
> diff --git a/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c b/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
> new file mode 100644
> index 000000000000..356d80a85cf0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_arraymap_mmap.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. */
> +#include <argp.h>
> +#include <sys/mman.h>
> +#include "bench.h"
> +
> +/* Benchmark mmap()/munmap() of an mmap-able BPF array map from N threads. */
> +
> +static struct ctx {
> +	int map_fd;
> +	size_t mmap_sz;
> +} ctx;
> +
> +static struct {
> +	__u32 nr_threads;
> +	__u64 map_size;
> +} args = {
> +	.nr_threads = 16,
> +	.map_size = 8 * 1024 * 1024, /* 8 MiB */
> +};
> +
> +enum {
> +	ARG_NR_THREADS = 5000,
> +	ARG_MAP_SIZE = 5001,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "nr-threads", ARG_NR_THREADS, "NR_THREADS", 0,
> +		"Number of threads that mmap/munmap the map (default 16)" },
> +	{ "map-size", ARG_MAP_SIZE, "BYTES", 0,
> +		"Size of the BPF array map in bytes (default 8388608)" },
> +	{},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	switch (key) {
> +	case ARG_NR_THREADS:
> +		args.nr_threads = strtoul(arg, NULL, 0);
> +		if (args.nr_threads == 0) {
> +			fprintf(stderr, "Invalid nr-threads: %s\n", arg);
> +			argp_usage(state);
> +		}
> +		break;
> +	case ARG_MAP_SIZE:
> +		args.map_size = strtoull(arg, NULL, 0);
> +		if (args.map_size == 0) {
> +			fprintf(stderr, "Invalid map-size: %s\n", arg);
> +			argp_usage(state);
> +		}
> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +/* exported into benchmark runner */
> +const struct argp bench_arraymap_mmap_argp = {
> +	.options = opts,
> +	.parser = parse_arg,
> +};
> +
> +static void validate(void)
> +{
> +	if (env.consumer_cnt != 0) {
> +		fprintf(stderr, "benchmark doesn't support consumer!\n");
> +		exit(1);
> +	}
> +
> +	/*
> +	 * The number of worker threads is controlled by --nr-threads and
> +	 * drives the framework's producer machinery, so per-producer stats
> +	 * are reported correctly.
> +	 */
> +	env.producer_cnt = args.nr_threads;
> +}
> +
> +static long hits;
> +
> +static void *producer(void *input)
> +{
> +	while (true) {
> +		void *addr;
> +
> +		addr = mmap(NULL, ctx.mmap_sz, PROT_READ | PROT_WRITE,
> +			    MAP_SHARED, ctx.map_fd, 0);
> +		if (addr == MAP_FAILED) {
> +			fprintf(stderr, "mmap failed: %d\n", -errno);
> +			exit(1);
> +		}

hi,
so now pages are populated only when accessed, benchmark shows
this nicely:

before:
		nr_threads: 1, map_size: 1048576
	arraymap-mmap:       throughput: 0.006 ± 0.000 M ops/s, latency: 172703.437 ns/op

after:
		nr_threads: 1, map_size: 1048576
	arraymap-mmap:       throughput: 0.082 ± 0.002 M ops/s, latency: 12212.778 ns/op


would it make sense to add some map access in here (each page I guess)
enabled by new option and measure the impact for accessed map ?
I assume latency should be equal in such case

jirka


> +		if (munmap(addr, ctx.mmap_sz)) {
> +			fprintf(stderr, "munmap failed: %d\n", -errno);
> +			exit(1);
> +		}
> +		atomic_inc(&hits);
> +	}
> +
> +	return NULL;
> +}
> +
> +static void measure(struct bench_res *res)
> +{
> +	res->hits = atomic_swap(&hits, 0);
> +}
> +
> +static void setup(void)
> +{
> +	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
> +	long page_sz = sysconf(_SC_PAGESIZE);
> +	__u32 value_size = sizeof(__u64);
> +	__u32 max_entries;
> +
> +	setup_libbpf();
> +
> +	/*
> +	 * mmap-able array maps round the value size up to 8 bytes and expose
> +	 * PAGE_ALIGN(max_entries * elem_size) bytes to user space.
> +	 */
> +	max_entries = (args.map_size + value_size - 1) / value_size;
> +	ctx.mmap_sz = ((__u64)max_entries * value_size + page_sz - 1) &
> +		      ~(page_sz - 1);
> +
> +	ctx.map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "mmap_array",
> +				    sizeof(__u32), value_size, max_entries,
> +				    &opts);
> +	if (ctx.map_fd < 0) {
> +		fprintf(stderr, "failed to create map: %d\n", -errno);
> +		exit(1);
> +	}
> +
> +	printf("array map: %u entries, mmap size %zu bytes, %u threads\n",
> +	       max_entries, ctx.mmap_sz, args.nr_threads);
> +}
> +
> +const struct bench bench_arraymap_mmap = {
> +	.name = "arraymap-mmap",
> +	.argp = &bench_arraymap_mmap_argp,
> +	.validate = validate,
> +	.setup = setup,
> +	.producer_thread = producer,
> +	.measure = measure,
> +	.report_progress = ops_report_progress,
> +	.report_final = ops_report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh b/tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh
> new file mode 100755
> index 000000000000..3efd441cd653
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_arraymap_mmap.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./benchs/run_common.sh
> +
> +set -eufo pipefail
> +
> +for t in 1 4 8 16; do
> +for s in 1048576 8388608 67108864; do
> +subtitle "nr_threads: $t, map_size: $s"
> +	summarize_ops "arraymap-mmap: " \
> +	    "$($RUN_BENCH --nr-threads $t --map-size $s arraymap-mmap)"
> +	printf "\n"
> +done
> +done
> -- 
> 2.53.0-Meta
> 
> 
