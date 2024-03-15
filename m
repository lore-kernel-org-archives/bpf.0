Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960517C6F
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493826; cv=none; b=r3lJbTbF9KUJSw2MUfjiol5o1wMmmWlK6VYcts+E/7/WYknf1+dAK2XkAEDWDkWd1y1qNS9GJ572a5TNm6iWV//bV50hkvftoa5kknyMUIe7YspxIU9UfB/HCRToS7IMuTLthIFuivJgmvTMOR03oxJwT+cWsUzbejY0Guld2TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493826; c=relaxed/simple;
	bh=RDGZk3cV/oUzuTxm6vSerZ6xrdaEYodqn1vX1JcRojo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0OU7bCYA4BEZBaaiBpD56vBKPY5tQEJ/q30DHC0aXyJ3Ztz5UZvGVP406hcB4lGltXO7atdirA2OYJPBwoa1VIplt0Cca5iBNMKHDkBzfBUEBGRTQsQQ1vSmJ3UtPonaY+39g8LDcRSdw6tNidGGLPcdyBKVs4nqjrO0t2FyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNg4MZgB; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNg4MZgB"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a461c50deccso220584566b.0
        for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710493823; x=1711098623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RzV94VLEnxkwGI8wfsVlokVZ4E6+TuaB/PDB6FR34YM=;
        b=DNg4MZgBFyZ/v+Vn4kVt7MS2eQWnxkmJSVSw7+KnvbhXmLMuX7b1MLwBNC1CteiGjT
         YuVGQ3b++dpsYHizBoMAufJD+ofzq5BszUOPS45nS8xs83CGzJRgCVal1HOJ7CF27BIi
         sMxU/BgBDr+MLCdCShnqyltKZOCcDfJ3O7ZYXIMvE5yQCnVWEV4zrQadwp5x6fja0Rau
         3ZgCgy12hN1dDp2usHdQxn0/fVq0s1owYBDWEyCaMXqjdXMf5/X1fGxbtVquAuy7ii6b
         Co7TXydgZgr507XVHnToRkIZu+s7bRPZO2yvYovwKWZHbDk9S3HQYbhwp355VwsH8Ucu
         7r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710493823; x=1711098623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzV94VLEnxkwGI8wfsVlokVZ4E6+TuaB/PDB6FR34YM=;
        b=FIgByRz71nfdnaZcXUEIUFwgHhZRKK6PNaprqFgYqZG59O19fv5rrVHhjFbQlDDK+3
         Wfub8SjgIvH5M2g/dhYYyXfNkECZ8EMfPmhrRB/PDWCfIXpu74xaAd2+c8nBRydX6a1M
         kMJrezl+xU9T5PKHJalCsu5OOo1OcMsm/2NzQN1uQIzjQaypbm/NKdlbt7Yov81ThwOD
         to7uST9SPdBYPZpo+85xUAtKB70vG7prwYW8W+G/O6kTO7rAHVRbKIZzSLU0BRuEmAB9
         WL6PW1br3SQpdtm1psd6/pf3n4Xe0kwKLGlQFVm6DZPKKDlFBuYGQAqONUP77VzBZuy/
         2VFQ==
X-Gm-Message-State: AOJu0YwmUR38rtmgDOy11aTIhrbkI8uUnW5PiUpzca4Ad39uUwO3Mr3v
	G3EX57khKgSvJDIRc/XVRI6otzk7Bz9MDqklROT8Aoqzlnik0TUvIyRqG0/N
X-Google-Smtp-Source: AGHT+IFSb6QOrRX+5bDI9GJGODbW4MBojf8XKkCkapnouQhccpUhPAOBSh8JmUSnfPYQUHfprlBAFA==
X-Received: by 2002:a17:906:3105:b0:a46:13a9:b78e with SMTP id 5-20020a170906310500b00a4613a9b78emr2971980ejx.2.1710493822589;
        Fri, 15 Mar 2024 02:10:22 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a11-20020a170906190b00b00a44e2f3024bsm1505548eje.68.2024.03.15.02.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:10:21 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Mar 2024 10:10:19 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add fast mostly in-kernel
 BPF triggering benchmarks
Message-ID: <ZfQQeyPu6gi4Bx9V@krava>
References: <20240315051813.1320559-1-andrii@kernel.org>
 <20240315051813.1320559-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315051813.1320559-2-andrii@kernel.org>

On Thu, Mar 14, 2024 at 10:18:13PM -0700, Andrii Nakryiko wrote:
> Existing kprobe/fentry triggering benchmarks have 1-to-1 mapping between
> one syscall execution and BPF program run. While we use a fast
> get_pgid() syscall, syscall overhead can still be non-trivial.
> 
> This patch adds kprobe/fentry set of benchmarks significantly amortizing
> the cost of syscall vs actual BPF triggering overhead. We do this by
> employing BPF_PROG_TEST_RUN command to trigger "driver" raw_tp program
> which does a tight parameterized loop calling cheap BPF helper
> (bpf_get_smp_processor_id()), to which kprobe/fentry programs are
> attached for benchmarking.
> 
> This way 1 bpf() syscall causes N executions of BPF program being
> benchmarked. N defaults to 100, but can be adjusted with
> --trig-batch-iters CLI argument.
> 
> Results speak for themselves:
> 
> $ ./run_bench_trigger.sh
> uprobe-base         :  138.054 ± 0.556M/s
> base                :   16.650 ± 0.123M/s
> tp                  :   11.068 ± 0.100M/s
> rawtp               :   14.087 ± 0.511M/s
> kprobe              :    9.641 ± 0.027M/s
> kprobe-multi        :   10.263 ± 0.061M/s
> kretprobe           :    5.475 ± 0.028M/s
> kretprobe-multi     :    5.703 ± 0.036M/s
> fentry              :   14.544 ± 0.112M/s
> fexit               :   10.637 ± 0.073M/s
> fmodret             :   11.357 ± 0.061M/s
> kprobe-fast         :   14.286 ± 0.377M/s
> kprobe-multi-fast   :   14.999 ± 0.204M/s
> kretprobe-fast      :    7.646 ± 0.084M/s
> kretprobe-multi-fast:    4.354 ± 0.066M/s
> fentry-fast         :   31.475 ± 0.254M/s
> fexit-fast          :   17.379 ± 0.195M/s
> 
> Note how xxx-fast variants are measured with significantly higher
> throughput, even though it's exactly the same in-kernel overhead:
> 
> fentry              :   14.544 ± 0.112M/s
> fentry-fast         :   31.475 ± 0.254M/s
> 
> kprobe-multi        :   10.263 ± 0.061M/s
> kprobe-multi-fast   :   14.999 ± 0.204M/s
> 
> One huge and not yet explained deviation is a slowdown of
> kretprobe-multi, we should look into that separately.
> 
> kretprobe           :    5.475 ± 0.028M/s
> kretprobe-multi     :    5.703 ± 0.036M/s
> kretprobe-fast      :    7.646 ± 0.084M/s
> kretprobe-multi-fast:    4.354 ± 0.066M/s
> 
> Kprobe cases don't seem to have this illogical slowdown:
> 
> kprobe              :    9.641 ± 0.027M/s
> kprobe-multi        :   10.263 ± 0.061M/s
> kprobe-fast         :   14.286 ± 0.377M/s
> kprobe-multi-fast   :   14.999 ± 0.204M/s

hum, I see that as well:

uprobe-base         :  230.624 ± 0.527M/s 
base                :   16.320 ± 0.087M/s 
tp                  :   10.057 ± 0.122M/s 
rawtp               :   14.851 ± 0.300M/s 
kprobe              :   10.993 ± 0.104M/s 
kprobe-multi        :   11.053 ± 0.038M/s 
kretprobe           :    6.679 ± 0.015M/s 
kretprobe-multi     :    6.466 ± 0.015M/s 
fentry              :   14.949 ± 0.064M/s 
fexit               :   10.530 ± 1.275M/s 
fmodret             :   11.145 ± 0.245M/s 
kprobe-fast         :   20.080 ± 0.468M/s 
kprobe-multi-fast   :   17.603 ± 0.102M/s 
kretprobe-fast      :    9.943 ± 0.056M/s 
kretprobe-multi-fast:    5.185 ± 0.022M/s 
fentry-fast         :   46.697 ± 0.260M/s 
fexit-fast          :   19.250 ± 0.108M/s 


I even see decline in kprobe-multi-fast:

  kprobe-fast         :   20.080 ± 0.468M/s 
  kprobe-multi-fast   :   17.603 ± 0.102M/s 

  kretprobe-fast      :    9.943 ± 0.056M/s 
  kretprobe-multi-fast:    5.185 ± 0.022M/s 


I've got some IBT related code showing up in the perf profile
and when I disabled it I got better results for kprobe-multi-fast
but kretprobe-multi-fast is still bad


uprobe-base         :  234.024 ± 0.225M/s 
base                :   16.383 ± 0.029M/s 
tp                  :    9.973 ± 0.017M/s 
rawtp               :   14.889 ± 0.047M/s 
kprobe              :   10.970 ± 0.011M/s 
kprobe-multi        :   11.640 ± 0.009M/s 
kretprobe           :    6.667 ± 0.005M/s 
kretprobe-multi     :    6.704 ± 0.005M/s 
fentry              :   14.968 ± 0.024M/s 
fexit               :   11.860 ± 0.012M/s 
fmodret             :   12.656 ± 0.036M/s 
kprobe-fast         :   20.340 ± 0.043M/s 
kprobe-multi-fast   :   21.203 ± 0.019M/s 
kretprobe-fast      :    9.956 ± 0.021M/s 
kretprobe-multi-fast:    5.611 ± 0.006M/s 
fentry-fast         :   46.825 ± 0.041M/s 
fexit-fast          :   19.746 ± 0.024M/s 

slightly better:

  kprobe-fast         :   20.340 ± 0.043M/s 
  kprobe-multi-fast   :   21.203 ± 0.019M/s 

still almost half perf:
  kretprobe-fast      :    9.956 ± 0.021M/s 
  kretprobe-multi-fast:    5.611 ± 0.006M/s 

jirka

> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           |  18 +++
>  .../selftests/bpf/benchs/bench_trigger.c      | 123 +++++++++++++++++-
>  .../selftests/bpf/benchs/run_bench_trigger.sh |   8 +-
>  .../selftests/bpf/progs/trigger_bench.c       |  56 +++++++-
>  4 files changed, 201 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index b2b4c391eb0a..67212b89f876 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -280,6 +280,7 @@ extern struct argp bench_strncmp_argp;
>  extern struct argp bench_hashmap_lookup_argp;
>  extern struct argp bench_local_storage_create_argp;
>  extern struct argp bench_htab_mem_argp;
> +extern struct argp bench_trigger_fast_argp;
>  
>  static const struct argp_child bench_parsers[] = {
>  	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
> @@ -292,6 +293,7 @@ static const struct argp_child bench_parsers[] = {
>  	{ &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
>  	{ &bench_local_storage_create_argp, 0, "local-storage-create benchmark", 0 },
>  	{ &bench_htab_mem_argp, 0, "hash map memory benchmark", 0 },
> +	{ &bench_trigger_fast_argp, 0, "BPF triggering benchmark", 0 },
>  	{},
>  };
>  
> @@ -502,6 +504,12 @@ extern const struct bench bench_trig_fentry;
>  extern const struct bench bench_trig_fexit;
>  extern const struct bench bench_trig_fentry_sleep;
>  extern const struct bench bench_trig_fmodret;
> +extern const struct bench bench_trig_kprobe_fast;
> +extern const struct bench bench_trig_kretprobe_fast;
> +extern const struct bench bench_trig_kprobe_multi_fast;
> +extern const struct bench bench_trig_kretprobe_multi_fast;
> +extern const struct bench bench_trig_fentry_fast;
> +extern const struct bench bench_trig_fexit_fast;
>  extern const struct bench bench_trig_uprobe_base;
>  extern const struct bench bench_trig_uprobe_nop;
>  extern const struct bench bench_trig_uretprobe_nop;
> @@ -539,6 +547,7 @@ static const struct bench *benchs[] = {
>  	&bench_rename_rawtp,
>  	&bench_rename_fentry,
>  	&bench_rename_fexit,
> +	/* syscall-driven triggering benchmarks */
>  	&bench_trig_base,
>  	&bench_trig_tp,
>  	&bench_trig_rawtp,
> @@ -550,6 +559,14 @@ static const struct bench *benchs[] = {
>  	&bench_trig_fexit,
>  	&bench_trig_fentry_sleep,
>  	&bench_trig_fmodret,
> +	/* fast, mostly in-kernel triggers */
> +	&bench_trig_kprobe_fast,
> +	&bench_trig_kretprobe_fast,
> +	&bench_trig_kprobe_multi_fast,
> +	&bench_trig_kretprobe_multi_fast,
> +	&bench_trig_fentry_fast,
> +	&bench_trig_fexit_fast,
> +	/* uprobes */
>  	&bench_trig_uprobe_base,
>  	&bench_trig_uprobe_nop,
>  	&bench_trig_uretprobe_nop,
> @@ -557,6 +574,7 @@ static const struct bench *benchs[] = {
>  	&bench_trig_uretprobe_push,
>  	&bench_trig_uprobe_ret,
>  	&bench_trig_uretprobe_ret,
> +	/* ringbuf/perfbuf benchmarks */
>  	&bench_rb_libbpf,
>  	&bench_rb_custom,
>  	&bench_pb_libbpf,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> index 8fbc78d5f8a4..d6c87180c887 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
> @@ -1,11 +1,54 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
>  #define _GNU_SOURCE
> +#include <argp.h>
>  #include <unistd.h>
> +#include <stdint.h>
>  #include "bench.h"
>  #include "trigger_bench.skel.h"
>  #include "trace_helpers.h"
>  
> +static struct {
> +	__u32 batch_iters;
> +} args = {
> +	.batch_iters = 100,
> +};
> +
> +enum {
> +	ARG_TRIG_BATCH_ITERS = 7000,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "trig-batch-iters", ARG_TRIG_BATCH_ITERS, "BATCH_ITER_CNT", 0,
> +		"Number of in-kernel iterations per one driver test run"},
> +	{},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	long ret;
> +
> +	switch (key) {
> +	case ARG_TRIG_BATCH_ITERS:
> +		ret = strtol(arg, NULL, 10);
> +		if (ret < 1 || ret > UINT_MAX) {
> +			fprintf(stderr, "invalid --trig-batch-iters value");
> +			argp_usage(state);
> +		}
> +		args.batch_iters = ret;
> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +const struct argp bench_trigger_fast_argp = {
> +	.options = opts,
> +	.parser = parse_arg,
> +};
> +
>  /* adjust slot shift in inc_hits() if changing */
>  #define MAX_BUCKETS 256
>  
> @@ -70,6 +113,16 @@ static void *trigger_producer(void *input)
>  	return NULL;
>  }
>  
> +static void *trigger_producer_fast(void *input)
> +{
> +	int fd = bpf_program__fd(ctx.skel->progs.trigger_driver);
> +
> +	while (true)
> +		bpf_prog_test_run_opts(fd, NULL);
> +
> +	return NULL;
> +}
> +
>  static void trigger_measure(struct bench_res *res)
>  {
>  	res->hits = sum_and_reset_counters(ctx.skel->bss->hits);
> @@ -77,13 +130,23 @@ static void trigger_measure(struct bench_res *res)
>  
>  static void setup_ctx(void)
>  {
> +	int err;
> +
>  	setup_libbpf();
>  
> -	ctx.skel = trigger_bench__open_and_load();
> +	ctx.skel = trigger_bench__open();
>  	if (!ctx.skel) {
>  		fprintf(stderr, "failed to open skeleton\n");
>  		exit(1);
>  	}
> +
> +	ctx.skel->rodata->batch_iters = args.batch_iters;
> +
> +	err = trigger_bench__load(ctx.skel);
> +	if (err) {
> +		fprintf(stderr, "failed to open skeleton\n");
> +		exit(1);
> +	}
>  }
>  
>  static void attach_bpf(struct bpf_program *prog)
> @@ -157,6 +220,44 @@ static void trigger_fmodret_setup(void)
>  	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
>  }
>  
> +/* Fast, mostly in-kernel triggering setups */
> +
> +static void trigger_kprobe_fast_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_fast);
> +}
> +
> +static void trigger_kretprobe_fast_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_fast);
> +}
> +
> +static void trigger_kprobe_multi_fast_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_kprobe_multi_fast);
> +}
> +
> +static void trigger_kretprobe_multi_fast_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_kretprobe_multi_fast);
> +}
> +
> +static void trigger_fentry_fast_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_fentry_fast);
> +}
> +
> +static void trigger_fexit_fast_setup(void)
> +{
> +	setup_ctx();
> +	attach_bpf(ctx.skel->progs.bench_trigger_fexit_fast);
> +}
> +
>  /* make sure call is not inlined and not avoided by compiler, so __weak and
>   * inline asm volatile in the body of the function
>   *
> @@ -385,6 +486,26 @@ const struct bench bench_trig_fmodret = {
>  	.report_final = hits_drops_report_final,
>  };
>  
> +/* fast (staying mostly in kernel) kprobe/fentry benchmarks */
> +#define BENCH_TRIG_FAST(KIND, NAME)					\
> +const struct bench bench_trig_##KIND = {				\
> +	.name = "trig-" NAME,						\
> +	.setup = trigger_##KIND##_setup,				\
> +	.producer_thread = trigger_producer_fast,			\
> +	.measure = trigger_measure,					\
> +	.report_progress = hits_drops_report_progress,			\
> +	.report_final = hits_drops_report_final,			\
> +	.argp = &bench_trigger_fast_argp,				\
> +}
> +
> +BENCH_TRIG_FAST(kprobe_fast, "kprobe-fast");
> +BENCH_TRIG_FAST(kretprobe_fast, "kretprobe-fast");
> +BENCH_TRIG_FAST(kprobe_multi_fast, "kprobe-multi-fast");
> +BENCH_TRIG_FAST(kretprobe_multi_fast, "kretprobe-multi-fast");
> +BENCH_TRIG_FAST(fentry_fast, "fentry-fast");
> +BENCH_TRIG_FAST(fexit_fast, "fexit-fast");
> +
> +/* uprobe benchmarks */
>  const struct bench bench_trig_uprobe_base = {
>  	.name = "trig-uprobe-base",
>  	.setup = NULL, /* no uprobe/uretprobe is attached */
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
> index 78e83f243294..fee069ac930b 100755
> --- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
> @@ -2,8 +2,12 @@
>  
>  set -eufo pipefail
>  
> -for i in base tp rawtp kprobe fentry fmodret
> +for i in uprobe-base base tp rawtp \
> +	 kprobe kprobe-multi kretprobe kretprobe-multi \
> +	 fentry fexit fmodret \
> +	 kprobe-fast kprobe-multi-fast kretprobe-fast kretprobe-multi-fast \
> +	 fentry-fast fexit-fast
>  do
>  	summary=$(sudo ./bench -w2 -d5 -a trig-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
> -	printf "%-10s: %s\n" $i "$summary"
> +	printf "%-20s: %s\n" $i "$summary"
>  done
> diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
> index 42ec202015ed..2886c2cb3570 100644
> --- a/tools/testing/selftests/bpf/progs/trigger_bench.c
> +++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Copyright (c) 2020 Facebook
> -
>  #include <linux/bpf.h>
>  #include <asm/unistd.h>
>  #include <bpf/bpf_helpers.h>
> @@ -103,3 +102,58 @@ int bench_trigger_uprobe(void *ctx)
>  	inc_counter();
>  	return 0;
>  }
> +
> +const volatile int batch_iters = 0;
> +
> +SEC("raw_tp")
> +int trigger_driver(void *ctx)
> +{
> +	int i;
> +
> +	for (i = 0; i < batch_iters; i++)
> +		(void)bpf_get_smp_processor_id(); /* attach here to benchmark */
> +
> +	return 0;
> +}
> +
> +SEC("kprobe/bpf_get_smp_processor_id")
> +int bench_trigger_kprobe_fast(void *ctx)
> +{
> +	inc_counter();
> +	return 0;
> +}
> +
> +SEC("kretprobe/bpf_get_smp_processor_id")
> +int bench_trigger_kretprobe_fast(void *ctx)
> +{
> +	inc_counter();
> +	return 0;
> +}
> +
> +SEC("kprobe.multi/bpf_get_smp_processor_id")
> +int bench_trigger_kprobe_multi_fast(void *ctx)
> +{
> +	inc_counter();
> +	return 0;
> +}
> +
> +SEC("kretprobe.multi/bpf_get_smp_processor_id")
> +int bench_trigger_kretprobe_multi_fast(void *ctx)
> +{
> +	inc_counter();
> +	return 0;
> +}
> +
> +SEC("fentry/bpf_get_smp_processor_id")
> +int bench_trigger_fentry_fast(void *ctx)
> +{
> +	inc_counter();
> +	return 0;
> +}
> +
> +SEC("fexit/bpf_get_smp_processor_id")
> +int bench_trigger_fexit_fast(void *ctx)
> +{
> +	inc_counter();
> +	return 0;
> +}
> -- 
> 2.43.0
> 
