Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4B30B521;
	Tue,  3 Feb 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111511; cv=none; b=Dl44wsxLt37qn3vGCXyMeYTEx8Xcb18SRY6bm5Ar+4o/hY8wbIU0pQaJ/bIp41qOTXvyBjWghDXSoZzwlSEVsmAblLXofnN0oZL00/aB5ZUFpB9KkjtxOxQQvwqSJ0i//TP6AQu2GijgdjGHSGXuJNmY0NKF6LIXYwAWnvzjU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111511; c=relaxed/simple;
	bh=KvflHZ9Jm1u7tKYWl5t14lcchR2ayzYTXIz/R0RGwXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MP9Ilq6p1O0/XmmAywTnSySnwq7lWTeivYURS6HCdA1QR59bvWpQv1UbhJlMLs76f6uSE7SLy9kiiftGvBw3N6dgkz5nXOuHXeCSNmqzBWuXuxn0rMUzIw/MXSgcGTWWOFHZ0gGRPNw/zdL6N5/teEOZvWmGW0mSTCmS50ROv2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJCg0kv5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJCg0kv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4323C19422;
	Tue,  3 Feb 2026 09:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111511;
	bh=KvflHZ9Jm1u7tKYWl5t14lcchR2ayzYTXIz/R0RGwXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=oJCg0kv5VVnTFmPh7g0ZOeYfHpHjI+5wjazB6lO+6tELA/STGS470IAmu3xQIQ2nU
	 71E4GF57O4SApvNAGN4+YW2uXGiDViD5ntwsCql+zM2RLEYBlci8gzJsb+Vsj3q2Cg
	 X4zq707M2AoHuaO9KRDL2HoIJMqsyaWQ+jUlw09uFClVf3LQWy+88ujjIqJEaPL/54
	 UCx4GhAWso4oTNsfE9FgUNGpLKkDil1W2G+WWh4RHSZ/nDkMUTrQckSFbXmuvXamb8
	 H6X1wW0H18R3QS7kjtUagxKF9zOA0oJ0ffFIVaHn13oW7LgHvRbdUPSEP+zC0LCvTL
	 dS66xh//W/5/w==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [RFC bpf-next 00/12] bpf: tracing_multi link
Date: Tue,  3 Feb 2026 10:38:07 +0100
Message-ID: <20260203093819.2105105-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
as an option to Meglong's change [1] I'm sending proposal for tracing_multi
link that does not add static trampoline but attaches program to all needed
trampolines.

This approach keeps the same performance but has some drawbacks:

 - when attaching 20k functions we allocate and attach 20k trampolines
 - during attachment we hold each trampoline mutex, so for above
   20k functions we will hold 20k mutexes during the attachment,
   should be very prone to deadlock, but haven't hit it yet

I was hoping we'd find some common solution, but it looks like it's either
static trampoline with performance penalty or having troubles described
above but keeping the current trampoline performance.

It looks the trampoline allocations/generation might not be big a problem
and I'll try to find a solution for holding that many mutexes. If there's
no better solution I think having one read/write mutex for tracing multi
link attach/detach should work.

We'd like to use trampolines instead of kprobes for the performance gains,
so naturally we want to keep the same performance even when it's attached
through tracing multi link.

thoughts? thanks,
jirka


[1] https://lore.kernel.org/bpf/20250703121521.1874196-1-dongml2@chinatelecom.cn/
---
Jiri Olsa (12):
      ftrace: Add ftrace_hash_count function
      bpf: Add struct bpf_trampoline_ops object
      bpf: Add struct bpf_struct_ops_tramp_link object
      bpf: Add struct bpf_tramp_node object
      bpf: Add multi tracing attach types
      bpf: Add bpf_trampoline_multi_attach/detach functions
      bpf: Add support to create tracing multi link
      libbpf: Add btf__find_by_glob_kind function
      libbpf: Add support to create tracing multi link
      selftests/bpf: Add fentry tracing multi func test
      selftests/bpf: Add fentry intersected tracing multi func test
      selftests/bpf: Add tracing multi benchmark test

 arch/arm64/net/bpf_jit_comp.c                            |  58 +++++++--------
 arch/s390/net/bpf_jit_comp.c                             |  42 +++++------
 arch/x86/net/bpf_jit_comp.c                              |  54 +++++++-------
 include/linux/bpf.h                                      |  74 +++++++++++++------
 include/linux/ftrace.h                                   |   1 +
 include/linux/trace_events.h                             |   6 ++
 include/uapi/linux/bpf.h                                 |   7 ++
 kernel/bpf/bpf_struct_ops.c                              |  39 +++++-----
 kernel/bpf/syscall.c                                     |  62 +++++++++++-----
 kernel/bpf/trampoline.c                                  | 340 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 kernel/bpf/verifier.c                                    |   8 ++-
 kernel/trace/bpf_trace.c                                 | 105 +++++++++++++++++++++++++++
 kernel/trace/ftrace.c                                    |  14 ++--
 net/bpf/bpf_dummy_struct_ops.c                           |  23 +++---
 net/bpf/test_run.c                                       |   2 +
 tools/include/uapi/linux/bpf.h                           |   7 ++
 tools/lib/bpf/bpf.c                                      |   7 ++
 tools/lib/bpf/bpf.h                                      |   4 ++
 tools/lib/bpf/btf.c                                      |  41 +++++++++++
 tools/lib/bpf/btf.h                                      |   3 +
 tools/lib/bpf/libbpf.c                                   |  87 +++++++++++++++++++++++
 tools/lib/bpf/libbpf.h                                   |  14 ++++
 tools/lib/bpf/libbpf.map                                 |   1 +
 tools/testing/selftests/bpf/Makefile                     |   3 +-
 tools/testing/selftests/bpf/prog_tests/tracing_multi.c   | 363 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_check.c  | 132 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/tracing_multi_fentry.c |  39 ++++++++++
 27 files changed, 1319 insertions(+), 217 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
