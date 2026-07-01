Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050644A23;
	Wed,  1 Jul 2026 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913528; cv=none; b=SnBu1gzDRdUgOPbuLJALKOdLSW5nOjIQBOGcKPQIwZCdjSr4XKNa1y4avl2qXfdIYpLVXNod2cnxSRCxxH6BKnGTBfNapCWRR7TLb6WBfTLuaaYTufN5tVluMnDqwbdC7iCCVQ0BFHkUD/RH9JZeF3uBoyY7UYSGuGgjgckEpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913528; c=relaxed/simple;
	bh=v6M4Xb/tHGwsRi5PWTqFRQjsSaQzChcYcXeGM3wo+Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9Tn4kmwuWBIXYXYc+vao1lkstpOl2FJrFkYW6lJEO2s1jfoGzYHt1o6fbN2cNPWWy8OlH+kcf8UlSfjpo+pjW9oS8azNj5o1Jqy3/sV1Gj8vgnPKRU9ylLemVr1FGQm72KaSr1wu4VU+5wqmW8AXB3jJ2LCl9n+e3html6vSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL05XOvl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL05XOvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974F21F000E9;
	Wed,  1 Jul 2026 13:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913526;
	bh=ULlz2behX2dvW8YaBABbvdY9P7AD1dn7xjwDomVMAoQ=;
	h=From:To:Cc:Subject:Date;
	b=QL05XOvlCivV4WTWP0JvSJrHhgNdaW2mXadWLzlGTEwCr82cqc7+0SgoQnenNEzCk
	 ERS0d4hfzcUIsUFCSPhxvIzr2OeIYb5HwAJf/DKHahh6FE0Y+WOD468wEnrE5Ooxlw
	 xoMqpbOYTvtvhEDlzOrgmBpP3nG3aWKCioVkfUBnvr1b3mykN21tTB3QNHnKH7Cmr6
	 S5plTt3pmiuOf8kImPN7W8O4JD1qRHjl+XTLbNgGryzZgfhJs+EW0BECi4jGrSRP8I
	 r9OOJCPvWOsnRymA/+EwIuelUK3QHjqVJmHGyNwSekXuH3m1eNBtMfptuk985Lm8qu
	 W8J0F6dYZr5pQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 0/4] tracing/probes: Optimize fetcharg with BPF
Date: Wed,  1 Jul 2026 22:45:22 +0900
Message-ID: <178291352217.1566898.14481561093843379745.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

I investigated the feasibility of optimizing `fetcharg` in probe events
using BPF conversion. The result looks promising. It can reduce about
30% of overhead (and maybe more if we have more than 3 arguments.)

I actually thought there was not such a big difference because I guessed
major overhead source is unsafe pointer dereferencing (e.g.
copy_from_kernel_nofault()). Actually without CONFIG_BPF_JIT, the overhead
is more than double. But with the JIT compiler it showed better performance.

The basic concept is quite simple. The process remains the same up until
the point where user input is converted into `fetcharg` code. It is
possible to convert some of the fundamental `fetcharg` operations into
an equivalent sequence of BPF instructions. This creates a single
`bpf_prog` for each probe event (rather than one per argument).
This program executes within the event handler, reads `pt_regs` directly,
and stores the results in the ftrace ring buffer, just as `fetcharg`
does.

So here are the benchmark results on qemu (KVM) on Intel Core i7-8565U.

When enabling BPF with JIT:
--------------------------------------------------------------------------------
Configuration      0 Fetchargs       1 Fetcharg        2 Fetchargs        3 Fetchargs
--------------------------------------------------------------------------------
Baseline                 298882359               -                  -                  - loops/sec
                                 -               -                  -                  - overhead
Kprobe                     9740841         8664195            7944956            7608274 loops/sec
                          99.31 ns        12.76 ns           23.21 ns           28.78 ns overhead
Fprobe                    10827749         9220918            7992512            7683757 loops/sec
                          89.01 ns        16.09 ns           32.76 ns           37.79 ns overhead
Eprobe                     6746389         6245994            5319037            4845406 loops/sec
                         144.88 ns        11.88 ns           39.78 ns           58.15 ns overhead
--------------------------------------------------------------------------------

When enabling BPF without JIT:
-----------------------------------------------------------------------------------------------
Configuration      0 Fetchargs       1 Fetcharg        2 Fetchargs        3 Fetchargs
-----------------------------------------------------------------------------------------------
Baseline                  84067374               -                  -                  - loops/sec
                                 -               -                  -                  - overhead
Kprobe                     7092949         5834913            3848776            3443408 loops/sec
                         129.09 ns        30.40 ns          118.84 ns          149.42 ns overhead
Fprobe                     9426302         6441734            4350313            3710814 loops/sec
                          94.19 ns        49.15 ns          123.78 ns          163.40 ns overhead
Eprobe                     5681716         4958113            3940999            3953434 loops/sec
                         164.11 ns        25.69 ns           77.74 ns           76.94 ns overhead
-----------------------------------------------------------------------------------------------

When disabling BPF (legacy fetcharg)
--------------------------------------------------------------------------------
Configuration      0 Fetchargs       1 Fetcharg        2 Fetchargs        3 Fetchargs
--------------------------------------------------------------------------------
Baseline                 245433525               -                  -                  - loops/sec
                                 -               -                  -                  - overhead
Kprobe                     9055348         8488351            7219595            6453928 loops/sec
                         106.36 ns         7.38 ns           28.08 ns           44.51 ns overhead
Fprobe                    10859326         9288801            7492518            6607046 loops/sec
                          88.01 ns        15.57 ns           41.38 ns           59.27 ns overhead
Eprobe                     6987128         5114526            5055084            4803759 loops/sec
                         139.05 ns        52.40 ns           54.70 ns           65.05 ns overhead
--------------------------------------------------------------------------------

The number is still unstable (because of the benchmark problem) but the
trend shows the BPF+JIT is the winner. 

TODOs:
 - Add a new Kconfig which depends on CONFIG_BPF_JIT=y.
 - Even if a single dereference operation fails, processing of subsequent
   arguments continues.
 - Allow mixing with unsupported FETCH_OPs on the same event.

Thank you,

---
base-commit: c0c56fe6fb52cfb28419242cfa6235125f818f94

Masami Hiramatsu (Google) (4):
      tools/tracing: Add fetcharg performance micro-benchmark
      tracing/probes: Compile all fetchargs into a single BPF program per event
      tracing: Add disable_bpf trace option to ignore eBPF for fetchargs
      selftests/ftrace: Add a test for eBPF compiled fetchargs


 kernel/trace/trace.c                               |    7 +
 kernel/trace/trace.h                               |    8 +
 kernel/trace/trace_probe.c                         |  249 ++++++++++++++++++++
 kernel/trace/trace_probe.h                         |   15 +
 kernel/trace/trace_probe_tmpl.h                    |   13 +
 .../ftrace/test.d/dynevent/test_bpf_fetchargs.tc   |   51 ++++
 tools/tracing/benchmark/Kbuild                     |    3 
 tools/tracing/benchmark/Makefile                   |   12 +
 tools/tracing/benchmark/bench_fetcharg.sh          |  195 ++++++++++++++++
 tools/tracing/benchmark/fetcharg_bench.c           |   98 ++++++++
 tools/tracing/benchmark/fetcharg_bench_trace.h     |   37 +++
 11 files changed, 684 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/test_bpf_fetchargs.tc
 create mode 100644 tools/tracing/benchmark/Kbuild
 create mode 100644 tools/tracing/benchmark/Makefile
 create mode 100755 tools/tracing/benchmark/bench_fetcharg.sh
 create mode 100644 tools/tracing/benchmark/fetcharg_bench.c
 create mode 100644 tools/tracing/benchmark/fetcharg_bench_trace.h

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
