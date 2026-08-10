Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71412E1746;
	Mon, 10 Aug 2026 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347890; cv=none; b=T712nPwyfQqIy3AfphX1W8/77XRlUnk7k51kvmpyuf1t/yPxGSJvjAA1sKZF1TlAZR0LMGQM2Npej93rBIfgI/SE2Mf784MJDrNldY/K7arNkUWwCmAIzp+OGJBTNmQ6cNFi8CNOebm8wm3ZGD1rJ4RzzIEdq8tAfD0D1lsUl7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347890; c=relaxed/simple;
	bh=1wb7Cf02LCWeiPlolXjnWVYxXT8O2WMADH6hi7KOxUw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Owe9bcKA6EolmNKrpvHwuS+A5wM4d7kvWDYbz/jMZCF7YU/mtgq7TOG+7xGiHNcJSoauY+Nt7qZvZQTTL+DH+p3if/N4DEFul+iDenraMIkcsdR1dwMUTJtqogM774UA/XmQchVOujmZRECj1H55hk2RycKL60+m21D/AL6rMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsRbcc2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsRbcc2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898951F000E9;
	Mon, 10 Aug 2026 07:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786347888;
	bh=tJ7eKx0iJr2rvTOygQR5LhDZ7PkCW/kB1UHfv12h8v4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MsRbcc2AocCHdbttjw53ER9ijXVYMv4LCQRrI/qdzpd+ZNbh4XbH57P8v59eEDqrf
	 x43MyBiAxMLHVRK1achYhEysTDupCjCzYgUGVraby0O7HCUHnyD+9E9HcZid1sDx/8
	 yCJo8EnwCTar6tDaaPI7Y1ytwBVsB7bE1UGhfW8uNdBxFx2SkW7TaM3pCF2K32hv23
	 ZkrDnTSbn4ozzQ/+ItNiunpIO6fifLfSYHJl7yyDzQFUUDnHL7dSc787CAuZxBpSMe
	 XfOxi3eaNqHwEAkOBF+JFRWudXtKhkqTo2Tw0OlQuB7WXw5LVa4oCRfsO/UJAqXApU
	 nuazPWwcgRqpw==
Content-Type: multipart/mixed; boundary="===============2480451235356564507=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8a1536c653af9eb59c0f6e30adfc9911f72dc08d87026c9ae89b32f329026c3b@mail.kernel.org>
In-Reply-To: <20260810055709.729203-1-chenguang.zhao@linux.dev>
References: <20260810055709.729203-1-chenguang.zhao@linux.dev>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add kptr-xchg benchmark
From: bot+bpf-ci@kernel.org
To: chenguang.zhao@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,shuah@kernel.org
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,chenguang.zhao@liux.dev,zhaochenguang@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 07:44:47 +0000 (UTC)

--===============2480451235356564507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index d3655a706482..76782b442aa9 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile

[ ... ]

> diff --git a/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c b/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
> new file mode 100644
> index 000000000000..b8a0d346fda6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_kptr_xchg.c
> @@ -0,0 +1,96 @@

[ ... ]

> +enum {
> +	ARG_NR_LOOPS = 7000,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "nr_loops", ARG_NR_LOOPS, "nr_loops", 0,
> +	  "Set number of bpf_kptr_xchg() calls per trigger"},
> +	{},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	switch (key) {
> +	case ARG_NR_LOOPS:
> +		args.nr_loops = strtol(arg, NULL, 10);
> +		break;

Should parse_arg() validate the nr_loops value here? Looking at the BPF
program, the loop is capped at MAX_XCHG_LOOPS (4096):

tools/testing/selftests/bpf/progs/kptr_xchg_bench.c:benchmark() {
	for (i = 0; i < MAX_XCHG_LOOPS; i++) {
		if (i >= nr_loops)
			break;
		...
	}
}

So passing --nr_loops 100000 silently benchmarks only 4096 iterations,
and --nr_loops -1 (which strtol accepts and wraps to 4294967295 when
assigned to __u32) also silently runs 4096. The user gets throughput
numbers for a different workload than requested.

bench_trigger.c already handles this by rejecting out-of-range values at
parse time:

	ret = strtol(arg, NULL, 10);
	if (ret < 1 || ret > MAX_TRIG_BATCH_ITERS) {
		fprintf(stderr, "invalid --trig-batch-iters value ...\n");
		argp_usage(state);
	}

Could bench_kptr_xchg.c add the same range check against MAX_XCHG_LOOPS
to make the cap visible rather than silent?

> +static const struct argp bench_kptr_xchg_argp = {
> +	.options = opts,
> +	.parser = parse_arg,
> +};

Is bench_kptr_xchg_argp intended to be static? All other benches export
their argp non-static (bench_bpf_loop_argp, bench_xdp_lb_argp,
bench_sockmap_argp, etc.) and register them in two places:

1. bench.c declares extern struct argp bench_*_argp
2. bench.c adds them to the static bench_parsers[] child list

This patch adds neither. Consequences:

`./bench --help` never shows the "kptr-xchg" option group or --nr_loops,
because --help is served from the first-pass child list.

--nr_loops only works today because bench_bpf_loop_argp and
bench_bpf_for_argp (both already in bench_parsers[]) also declare a
long option named "nr_loops", so the first pass consumes the argument
into an unrelated bench's args struct rather than erroring out. The
second pass then parses it again with the correct parser, so the
documented invocation happens to work. Any option name unique to this
bench would make the first pass abort with "unrecognized option".

Should bench_kptr_xchg_argp drop static, get an extern declaration in
bench.c, and be added to bench_parsers[] alongside the other benches?

> diff --git a/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c
> new file mode 100644
> index 000000000000..363883073e2c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/kptr_xchg_bench.c

[ ... ]

> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int benchmark(void *ctx)
> +{
> +	struct bin_data *old;
> +	u32 i;
> +
> +	for (i = 0; i < MAX_XCHG_LOOPS; i++) {
> +		if (i >= nr_loops)
> +			break;
> +
> +		old = bpf_kptr_xchg(&ptr, NULL);
> +		if (old)
> +			bpf_obj_drop(old);
> +	}
> +
> +	__sync_add_and_fetch(&hits, i);
> +	return 0;
> +}
> +
> +/*
> + * BTF FUNC records are not generated for kfuncs referenced only through
> + * optimized paths. Keep bpf_obj_drop() visible to libbpf's kfunc linker.
> + */
> +void __btf_root(void)
> +{
> +	bpf_obj_drop(NULL);
> +}

Is __btf_root() needed in this file? The workaround was copied from
kptr_xchg_inline.c, but that file actually requires it because the only
reference to bpf_obj_drop is inside a __naked function's inline assembly
via __imm(bpf_obj_drop), so clang never sees a C-level call and emits no
BTF FUNC record. That file's own comment says exactly that: "BTF FUNC
records are not generated for kfuncs referenced from inline assembly."

kptr_xchg_bench.c has no inline assembly. benchmark() calls the kfunc
with a plain C call:

	old = bpf_kptr_xchg(&ptr, NULL);
	if (old)
		bpf_obj_drop(old);

clang cannot prove old is always NULL (bpf_kptr_xchg is an opaque helper
call), so the call site survives -O2 and a BTF FUNC record for
bpf_obj_drop is emitted normally. This is confirmed by twenty other
programs in progs/ that call bpf_obj_drop() from ordinary C and define
no such helper: linked_list.c, refcounted_kptr.c, irq.c,
local_kptr_stash.c, rbtree_search.c, bpf_qdisc_fifo.c, etc.
kptr_xchg_inline.c is the only file in the tree that actually needs the
hack.

The rewritten comment also generalises the original's precise claim
("from inline assembly") into "referenced only through optimized paths",
which is not a real libbpf/clang behaviour and does not describe
anything happening in this file.

The function is never loaded (it is unreferenced, non-SEC() .text, so
libbpf never appends it as a subprog, which is why the bpf_obj_drop(NULL)
inside it never reaches the verifier's KF_RELEASE check), so there is no
load failure. But it is dead code carrying an incorrect technical
rationale that invites copying into future programs.

Should both the function and the comment be removed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31362294949
--===============2480451235356564507==--
