Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCD33260D
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254232; cv=pass; b=WYkcc/fmM9BTkP5/nWeOWdOCZTP987XrQRmJqufxKY7m1RbW+2L3xpcJJmP9zayhu1LRHSszP57mMTVmcrZN5JPCgufipMGJ9IKhvtTTcnb04c1yralNKaVQRveNH2TUfqtIsOkUAqmvjvMN942x0zLeXXBQG2wIHKwDTkNo/OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254232; c=relaxed/simple;
	bh=VVCbKvsmjk6id7uWVSdO3uG0pAo/eCGoqqxKPArWQ2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHlT+xi1IWCY4ANBNNOTNX/Kc9u+S8bQR6Nwh6DBHP0PO9blBmHi1olE+m+TuSZZ1BEZyGBptpFJBRtyefEunzV8G63k++at3Ycx1BpOj9ig+e0rCECiGbDC4C0XUkHG6JFXH6QTUNhxiv7LpBRWF1Q7oX4OK15RarHDfMqPg7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7Q4tPUY; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Q4tPUY"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e0688b859so5583b3a.0
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 08:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254230; cv=none;
        d=google.com; s=arc-20260327;
        b=WWMQQKrmkDaP3BsX6+fsAakWjKYvH9rVPvAguamM45HPkTESI49GJi2y8yIU7g8n4N
         sSoCmwV+Ado1PT7IV+1OuuMqpT2mvbTPPy1Uauo6W8YnRaxKqtKN5OIkpqsjtSPjU9Ci
         d7aFo6ZBvX2Yn4c/wRzfrul54AnY8zhrXvd7ndWPT37KrU7QSVOSyCuZ6ZlN2tmWPuPs
         w/z/B4SSxhe+uWuZFAM/ThgrcO79GDtks9qA0ts5i0ddikSFASQZI7FeyBKoiAzPryUC
         KjSsp7Vfe2/2Fl6DZCMkbTFZ8Q4kTkIjazbCfPqpR9qwqlJ/+FDGgfDtFO+wJ0L2aZ/C
         +UDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RCkGUPLTw0iX7/Bv4CC6JLU73ogCsqI9ZTdAApu5C6I=;
        fh=7eoyOfXUpehVHh0e6FcQCsD9SMN+Vtenv0RH2SBGXXs=;
        b=pTicZdHS/GYA7iALGE9UzXokZKHxw4NqqEkr5906aw18lZwjrWJ1Wsf6ORannx5mvK
         Qx1ZZauKUfB9R5YOC1UoQ9Ludxsb/O0yg34LCKGFaOogDVFkmfhmltCyi1WLIyDltSeT
         xGHO2FNzetUw7S/8XO63mlUF9wXVMHPV03V0G5DNgdD+BJiHMbiYLw3nl3ZQpRFlSheo
         kQspkw30JlVp4GhDtd64Wv+2UIWOq+xhdlNlmSRTFhrdvNuAEWXZt9J32vuWdrmeI9Zl
         K4lotEj9BN1i1xvYwJeGcM4daqMToFCG4hGElWakIPsbsnpMcdzGqnnUtzi0oXQDupDe
         VUSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785254230; x=1785859030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RCkGUPLTw0iX7/Bv4CC6JLU73ogCsqI9ZTdAApu5C6I=;
        b=L7Q4tPUYAcLxOgqYNdcU2ElXb4xfi19p2it6wMmMo5DI0NmS9obKb1vs2NM2AL92oZ
         mD0/X17QK0GOzLGTEITM+A/VdIzlnnPdeHYCWnfk/9tInn/VKeg7dcwzIB4PXP/tLjQl
         DeleoC5ENJvDhc/mK28VJ6zEZ6ut1pDYxhrc3kBmv9WOdAcDdOW3eeO/Xu380QLvAg0z
         fnYYrd2DooUyMn1wnnrcigvtkmZDpnzGUe2pziCK5Sreh86nsWeWZ0S3XR7dlht4pDpw
         B2LCCICn9pGKjuSM71Aounchoq48xfqSt5Fg1rtHHsoRYhYRoDHzaAYX22ifS4n48Dzz
         eFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254230; x=1785859030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RCkGUPLTw0iX7/Bv4CC6JLU73ogCsqI9ZTdAApu5C6I=;
        b=pDSDH4cVIgEqkW+2v9BeFC56vdku2j5KRF7YRVO5o54acSH/2fe3me8v/7f/hVZV2p
         FxID6Vd15eokkg+UuMkxUTKGCM5+qm/+++vvMV9mRd1R+kC58+VscEL2vjOcJ7x2icD3
         KD0HNQNjdTu4OyeVpjiTJw9LtAf30X4h28Jmekfnk7Y7r3Qw/V+0ElKmyv7TrYdROVkK
         +dOw/bV5/p6DUuodUCo4xmCI8BkoaN8WjpwREPXb0gRDcPWo1Q4YJ5Bct+dwu9/0ORn+
         jWh7zNnLZIyhyWKpCAd1/57I45mGbRk055fsRJ/2OnNRpzzdZsnPxnM0ND4ozJzGNrY8
         D+KA==
X-Gm-Message-State: AOJu0YxSXQlFA9cZVnpPqOv6En34mU4c6FTiBScW5O/xh4sm/5/v95j9
	sDn9PrmYo/Od8Y+0Ah3SQ+pPD2capnkJFf+tbXKBz8yAqCk1xoiqgK0BWfN1wDUM3qWfvfZmgLo
	Ukdo8gRiFCIQ2EYAoqCHy76opTSDh5Gg=
X-Gm-Gg: AR+sD11y4a36yqn63fvOzuZ12mydUKFEdvHGR7+KTu9j65G2+pAaymWSfA2KPkh6/P0
	YY8Zy5WEZ2wdz95dvGpuZ+NmFxBuSwZ2YakREPvyUq6DU9cxrefJPyH46WPG2D7gR9tLrFEBGLJ
	gdlSKUu+rb9FUqIpsEz6dmSyBwEzOB+E6tRiHYJ+TvUstv63XexdgG32TvzamYFK54Mf+hV1FZT
	SEfmUFlbW5h61Vzn8cVlfENejmBby+6Ur41a32TjIqCrV5SH0+dPPPHUjscWyGEcL+amxTgSPat
	8m5RFzZ4Fy5L49JUmqVpVZLMng8Hx/8cFvJub65uVJWyO5OKx1zCB1sG4jY=
X-Received: by 2002:a05:6a00:44c9:b0:84e:2290:9647 with SMTP id
 d2e1a72fcca58-84e9335f889mr3139166b3a.60.1785254230197; Tue, 28 Jul 2026
 08:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722132424.450230-1-puranjay@kernel.org> <20260722132424.450230-7-puranjay@kernel.org>
In-Reply-To: <20260722132424.450230-7-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Jul 2026 08:56:56 -0700
X-Gm-Features: AUfX_myUEiFO2EZoPJgOXm05Rluo3ZWVmQItM2gINPp2PKlox9CiPMSf46nEtlc
Message-ID: <CAEf4BzauG4hh7F49rjoYs24Gh+xTY1K5yj4pA7j=VkcpD0Shcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: Add bpf_for() benchmark
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 6:24=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> The bpf_for() macro builds on the numeric open-coded iterator kfuncs
> bpf_iter_num_{new,next,destroy}(). Add a benchmark, modelled on the
> existing bpf_loop benchmark, that repeatedly runs a bpf_for() loop so the
> per-iteration cost of the iterator can be measured, e.g. to quantify the
> effect of inlining the iterator kfuncs in the verifier.
>
> The BPF program runs an inner bpf_for(i, 0, nr_loops) loop with an empty
> body 1000 times per trigger and accounts nr_loops hits per outer
> iteration, mirroring bench_bpf_loop so the two are directly comparable.
>
> nr_loops defaults to 1000 so that the per-iteration bpf_iter_num_next()
> cost, rather than the one-time bpf_iter_num_new()/destroy() setup and
> teardown, dominates the reported numbers:
>
>   $ ./bench -p 1 --nr_loops 1000 bpf-for
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |   4 +
>  .../selftests/bpf/benchs/bench_bpf_for.c      | 104 ++++++++++++++++++
>  .../selftests/bpf/benchs/run_bench_bpf_for.sh |  15 +++
>  .../selftests/bpf/progs/bpf_for_bench.c       |  32 ++++++
>  5 files changed, 157 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_bpf_for.c
>  create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bpf_for.=
sh
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_for_bench.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 55d394438705a..3174c2f18e715 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -965,6 +965,7 @@ $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.s=
kel.h \
>                             $(OUTPUT)/perfbuf_bench.skel.h
>  $(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
>  $(OUTPUT)/bench_bpf_loop.o: $(OUTPUT)/bpf_loop_bench.skel.h
> +$(OUTPUT)/bench_bpf_for.o: $(OUTPUT)/bpf_for_bench.skel.h
>  $(OUTPUT)/bench_strncmp.o: $(OUTPUT)/strncmp_bench.skel.h
>  $(OUTPUT)/bench_bpf_hashmap_full_update.o: $(OUTPUT)/bpf_hashmap_full_up=
date_bench.skel.h
>  $(OUTPUT)/bench_local_storage.o: $(OUTPUT)/local_storage_bench.skel.h
> @@ -990,6 +991,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>                  $(OUTPUT)/bench_ringbufs.o \
>                  $(OUTPUT)/bench_bloom_filter_map.o \
>                  $(OUTPUT)/bench_bpf_loop.o \
> +                $(OUTPUT)/bench_bpf_for.o \
>                  $(OUTPUT)/bench_strncmp.o \
>                  $(OUTPUT)/bench_bpf_hashmap_full_update.o \
>                  $(OUTPUT)/bench_local_storage.o \
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index 3d9d2cd7764bd..b86b73456d3ca 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -276,6 +276,7 @@ static const struct argp_option opts[] =3D {
>  extern struct argp bench_ringbufs_argp;
>  extern struct argp bench_bloom_map_argp;
>  extern struct argp bench_bpf_loop_argp;
> +extern struct argp bench_bpf_for_argp;
>  extern struct argp bench_local_storage_argp;
>  extern struct argp bench_local_storage_rcu_tasks_trace_argp;
>  extern struct argp bench_strncmp_argp;
> @@ -292,6 +293,7 @@ static const struct argp_child bench_parsers[] =3D {
>         { &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
>         { &bench_bloom_map_argp, 0, "Bloom filter map benchmark", 0 },
>         { &bench_bpf_loop_argp, 0, "bpf_loop helper benchmark", 0 },
> +       { &bench_bpf_for_argp, 0, "bpf_for loop benchmark", 0 },
>         { &bench_local_storage_argp, 0, "local_storage benchmark", 0 },
>         { &bench_strncmp_argp, 0, "bpf_strncmp helper benchmark", 0 },
>         { &bench_local_storage_rcu_tasks_trace_argp, 0,
> @@ -557,6 +559,7 @@ extern const struct bench bench_bloom_false_positive;
>  extern const struct bench bench_hashmap_without_bloom;
>  extern const struct bench bench_hashmap_with_bloom;
>  extern const struct bench bench_bpf_loop;
> +extern const struct bench bench_bpf_for;
>  extern const struct bench bench_strncmp_no_helper;
>  extern const struct bench bench_strncmp_helper;
>  extern const struct bench bench_bpf_hashmap_full_update;
> @@ -640,6 +643,7 @@ static const struct bench *benchs[] =3D {
>         &bench_hashmap_without_bloom,
>         &bench_hashmap_with_bloom,
>         &bench_bpf_loop,
> +       &bench_bpf_for,
>         &bench_strncmp_no_helper,
>         &bench_strncmp_helper,
>         &bench_bpf_hashmap_full_update,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_bpf_for.c b/tools/t=
esting/selftests/bpf/benchs/bench_bpf_for.c
> new file mode 100644
> index 0000000000000..730c51ad2dec3
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
> +       struct bpf_for_bench *skel;
> +} ctx;
> +
> +static struct {
> +       __u32 nr_loops;
> +} args =3D {
> +       /*
> +        * Default to a large loop count so the per-iteration bpf_iter_nu=
m_next() cost dominates
> +        * the one-time bpf_iter_num_new()/destroy() setup and teardown.
> +        */
> +       .nr_loops =3D 1000,
> +};
> +
> +enum {
> +       ARG_NR_LOOPS =3D 4000,
> +};
> +
> +static const struct argp_option opts[] =3D {
> +       { "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
> +               "Set number of iterations for the bpf_for() loop"},
> +       {},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +       switch (key) {
> +       case ARG_NR_LOOPS:
> +               args.nr_loops =3D strtol(arg, NULL, 10);
> +               break;
> +       default:
> +               return ARGP_ERR_UNKNOWN;
> +       }
> +
> +       return 0;
> +}
> +
> +/* exported into benchmark runner */
> +const struct argp bench_bpf_for_argp =3D {
> +       .options =3D opts,
> +       .parser =3D parse_arg,
> +};
> +
> +static void validate(void)
> +{
> +       if (env.consumer_cnt !=3D 0) {
> +               fprintf(stderr, "benchmark doesn't support consumer!\n");
> +               exit(1);
> +       }
> +}
> +
> +static void *producer(void *input)
> +{
> +       while (true)
> +               /* trigger the bpf program */
> +               syscall(__NR_getpgid);
> +
> +       return NULL;
> +}
> +
> +static void measure(struct bench_res *res)
> +{
> +       res->hits =3D atomic_swap(&ctx.skel->bss->hits, 0);
> +}
> +
> +static void setup(void)
> +{
> +       struct bpf_link *link;
> +
> +       setup_libbpf();
> +
> +       ctx.skel =3D bpf_for_bench__open_and_load();
> +       if (!ctx.skel) {
> +               fprintf(stderr, "failed to open skeleton\n");
> +               exit(1);
> +       }
> +
> +       link =3D bpf_program__attach(ctx.skel->progs.benchmark);
> +       if (!link) {
> +               fprintf(stderr, "failed to attach program!\n");
> +               exit(1);
> +       }
> +
> +       ctx.skel->bss->nr_loops =3D args.nr_loops;
> +}
> +
> +const struct bench bench_bpf_for =3D {
> +       .name =3D "bpf-for",
> +       .argp =3D &bench_bpf_for_argp,
> +       .validate =3D validate,
> +       .setup =3D setup,
> +       .producer_thread =3D producer,
> +       .measure =3D measure,
> +       .report_progress =3D ops_report_progress,
> +       .report_final =3D ops_report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh b/to=
ols/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
> new file mode 100755
> index 0000000000000..7da6453920dab
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_bpf_for.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./benchs/run_common.sh
> +
> +set -eufo pipefail
> +
> +for t in 1 4 8 12 16; do
> +for i in 10 100 500 1000 5000 10000 50000 100000 500000 1000000; do
> +subtitle "nr_loops: $i, nr_threads: $t"
> +       summarize_ops "bpf_for: " \
> +           "$($RUN_BENCH -p $t --nr_loops $i bpf-for)"
> +       printf "\n"
> +done
> +done
> diff --git a/tools/testing/selftests/bpf/progs/bpf_for_bench.c b/tools/te=
sting/selftests/bpf/progs/bpf_for_bench.c
> new file mode 100644
> index 0000000000000..2752de5c44f57
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
> +char _license[] SEC("license") =3D "GPL";
> +
> +u32 nr_loops;

minor nit: nr_loops should be int, that's what bpf_for() expects



> +long hits;
> +
> +static int outer_loop(__u32 index, void *data)
> +{
> +       int i;
> +
> +       /*
> +        * Empty body: the work being measured is the open-coded numeric =
iterator itself
> +        * (bpf_iter_num_new/next/destroy behind bpf_for()).
> +        */
> +       bpf_for(i, 0, nr_loops)
> +               ;
> +       __sync_add_and_fetch(&hits, nr_loops);
> +       return 0;
> +}
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int benchmark(void *ctx)
> +{
> +       bpf_loop(1000, outer_loop, NULL, 0);
> +       return 0;
> +}
> --
> 2.53.0-Meta
>
