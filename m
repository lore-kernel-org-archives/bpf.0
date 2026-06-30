Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDC25742F;
	Tue, 30 Jun 2026 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789065; cv=none; b=cKXB2zNLr6g5l0sTsFp05SmvT/EQbAFyjCiVGKdu/MQ1i+8wJ7VYJjS9qtURLUX0m5csNQvmhmoQSQjIj9hPy50Dswjtzeo6D7I35I/UtpUHpJ6Aldkf2YK6V7gshi8b0IXk8kBjyy+hgO1Zk3svYz5sGCDaU8YGcPTDRVrnAjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789065; c=relaxed/simple;
	bh=B1nMRf2on4vze8kmJVFyrqIQgrF4tE2ZTm7Mmlk+LyI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L4RENwJtj9m+lp5FGFDGkCC2JtEtu7LxND6N2VH3skFfbchI5TStF7IFPmaWAURFdQ3yyIHE7ohywDrT61OmQjYPmI8n4alS3UhtWsd7RwtNl8YOkdaTkwUMrUeOXlKzrgj1eK3dN7Ta1GsOG1xuAyYt8M87Sj3sKLrC5FC1nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6vr4lqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6vr4lqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A091C1F00A3D;
	Tue, 30 Jun 2026 03:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782789063;
	bh=W0gn1NJRudDjHk8gSxS5NTA5NbX5IBxyR60m2RuTsN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F6vr4lqsxYLVKVQDEDWhvIpm9B/ygGAdCu/zStBH3ZOFprkAcprdhBR6NnQsCe/ii
	 2Chk315WYADr2gMpAQl+puvyUufqBOoO+uKGiHVn02VNhP/aNZp/74YcMRQc7ogxqm
	 2YCdSwPl2KeU+4izgRwDNDY2RLRLJq/g3Y0R3qoFf68jvvK72Ud3E3G17dsPgEY15h
	 4HWuZNBKWuA5O5cdN2/Q8GvkSWhoHzdavnAgJDYtwJtd6J6uGo3qFKPrTGh87jd0Nk
	 Bs1f66T4Jqp3Ur/UiTtpz8tkVeHw6lABJ3ObZ4FceGFIrYMRa/WMGPkfAgqxJbpUZs
	 3uPPaHwBnWRSQ==
Content-Type: multipart/mixed; boundary="===============5081759315822687536=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d31368b258945685c4ae5018157a6327233a45a35b4e19352d9830a216b881e6@mail.kernel.org>
In-Reply-To: <20260630022306.10017-1-yangtiezhu@loongson.cn>
References: <20260630022306.10017-1-yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add benchmark for tail call performance
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,andrii@kernel.org,eddyz87@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 30 Jun 2026 03:11:03 +0000 (UTC)

--===============5081759315822687536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh b/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
> new file mode 100755
> index 000000000000..c687f34455e8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_tailcall.sh
> @@ -0,0 +1,18 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# 1. Load the official common benchmark utilities
> +source ./benchs/run_common.sh
> +
> +# 2. Strict error handling configurations
> +set -eufo pipefail
> +
> +# 3. Use default bench binary path if not exported by the framework
> +BENCH_BIN=${BENCH:-./bench}
> +
> +# 4. Run with strict core affinity and isolation for reliable profiling
> +RUN_BENCH="numactl --physcpubind=0,2 --membind=0 nice -n -20 $BENCH_BIN -w5 -d20 -a"
> +
> +# 5. Capture the output string and pass it straight into summarize_ops
> +# This satisfies the framework's internal parameter bounds without triggering set -u.
> +summarize_ops "tailcall" "$($RUN_BENCH tailcall)"

This isn't a bug, but could the numbered step comments (# 1. .. # 5.) be
trimmed?  Several of them restate the line right below them, for example:

	# 1. Load the official common benchmark utilities
	source ./benchs/run_common.sh

The neighbouring run_bench_*.sh scripts here tend to be a couple of lines
with little commentary, so the running narration stands out.  Keeping only
the comments that explain a non-obvious choice (such as the cpu-affinity
flags) might fit the directory better.

> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bench.c b/tools/testing/selftests/bpf/progs/tailcall_bench.c
> new file mode 100644
> index 000000000000..68a50c7b1d06
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tailcall_bench.c

[ ... ]

> +/* High-performance Per-CPU Array Map to eliminate global lock variance */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, __u64);
> +} pcpu_hits_map SEC(".maps");

[ ... ]

> +static __always_inline void increment_pcpu_counter(void)
> +{
> +	__u32 key = 0;
> +	__u64 *val;
> +
> +	val = bpf_map_lookup_elem(&pcpu_hits_map, &key);
> +	if (val) {
> +		/* Lockless and stable per-CPU increment without cacheline bounce */
> +		(*val)++;
> +	}
> +}

This isn't a bug, but do the "high-performance / lockless / no cacheline
bounce" comments add anything beyond what the per-CPU map type already
conveys?  The increment comment in particular sits directly above a plain
(*val)++;.  Could these be dropped?

The commit message has a similar question.  Quoting it in full:

> Add a dedicated benchmark to measure the runtime performance and overhead
> of tail calls. This helps developers detect performance regressions across
> different kernel versions and optimization phases.
>
> The benchmark sets up a standard tracepoint to intercept syscalls triggered
> by a dedicated producer thread running a dead loop. The execution path is
> strictly bounded by the tail call depth limit, safely preventing any core
> lockup or infinite recursion risks.
>
> To eliminate cacheline bouncing and global locking variance, Per-CPU array
> maps are utilized to track execution hits across multiple cores.
>
> To evaluate the JIT compiler architecture under complex control flows, it
> interleaves direct tail calls with bpf2bpf tail calls.
>
> This forces the tracking context at the target program's entry prologue to
> toggle dynamically between a scalar count (0 to 33) and a massive kernel
> pointer address, providing a robust micro-architectural stress test which
> consists of:
>
> 1. tailcall_bench_main: The entry program filtering processes by PID, and
>    introducing a high-frequency alternating execution path via the syscall
>    arguments to switch between a direct tail call and a bpf2bpf tail call.
> 2. tailcall_bench_target: The final target destination hop which safely
>    terminates the mixed execution flow and increments the step counter.
>
> All functions utilize explicit "struct tracepoint_raw_syscalls_sys_enter"
> context types to ensure strict type alignment and clear pointer provenance
> for the BPF verifier.
>
> Additionally, provide a test script run_bench_tailcall.sh to automate the
> execution under strict core affinity and isolation for reliable profiling,
> formatting the captured metrics directly into the performance report.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This isn't a bug, but could the changelog focus more on why a dedicated
tail-call throughput benchmark is needed over the existing infrastructure?

The text mostly walks through what each program does, and uses phrasing like
"robust micro-architectural stress test", "massive kernel pointer address",
and "strict type alignment and clear pointer provenance".  A reviewer comes
away knowing what the two programs are, but less about the load-bearing
design rationale.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28416687457
--===============5081759315822687536==--
