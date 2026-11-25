Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617121;
	b=Zm6Y798X6SfUDSK6oFiGr846oXW4XLcfVmUfVE5t4uTk1pv2R4JW2JXh+5ic647qOklR
	 KhNuQtrx2jQScGZICcnY5f39IYqsBEmzDfkkUwcdfE/hnPf/JsqnDgcQiWpWKZuYyp+/t
	 wr+YLBlS16rYrMl2qtXoISMulE0ig0wrMokBxmGYSsskEC5oQEgwfh3I0OY+FxUN+jh8N
	 bh7QXR4bylRvWKPszjT945cHZRXE+jL5FezePKGLX0kWHoYUEVfZiYk+9CT+N8SsDHXGR
	 +egwo/PSTdrF/jhqvEXYq5GzngENE17mFCCd5HliXxER+WfnXFXNWPWhYmw/mGIXXgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617121;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=W9vKBkuf9EfCK/eG7T7fyygPvv7SG3tP86gxBxZ2fjY=;
	b=V9K5rjJq77dxXIc3tJgccJGV/UG+0xhpqeU07o8eax61ElJ/4Lbj/S9YpB7v/VIsAp2d
	 R+cApEWcnYwxCqWYbSmf505+PxqydjPoz0FqTpx1c3OGD2s/cFoU34hKtk+/0i1QX53eJ
	 0Lr7/WeBzREY41eGZeMN8TYebDRaL+0yY33hRINQt7wWfZd5ar6QvYveraYI4mX4Dy+P2
	 cu6aW9BAxRzLq/mgQZxjG4NSie1ut5NzahFe+qHrmhimJvAQnOvOcgWynv+EMk+U0NTBJ
	 WBYrudPVuvzPxEtXKugIr+rbXMvgL9K+7xnIM4UqXqkk/fy99zdiM11zx8N5KR8A7sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BYoKa5HF;
	arc=none smtp.remote-ip=95.215.58.152
Received: from mta1.migadu.com (out-152.mta1.migadu.com [95.215.58.152])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF02606A332
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 14:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEF02606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BYoKa5HF
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XKKXO3M5xHnltq0mNRZ0f54bFSZ0rb5xvZeNSjm/bpw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795617117; v=1; x=1796221917;
 b=BYoKa5HF3cO2wpf3Q55gkeZHM9JZR495dSzvCQD3W2PQK+Kmp9QuYPfJJIA/zwBoVC4vH15y
 Ppbh0+HEKnX+bZwJEVSSXi1bw5HVzqtwZ/8q2t1V8CmpRN802Jm5Fpxj9DmhLRuEp38vKuSXk8U
 MAOUDC+fNubNVpT9+kE6mSCY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aab6a3ba64b69de4;
	Wed, 25 Nov 2026 14:31:57 +0000
X-Mizu-Trace-ID: aab6a3ba64b69de4
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <matt@bobrowski.net>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 0/6] bpf: Add log support for tracing link_create
Date: Wed, 25 Nov 2026 22:31:32 +0800
Message-ID: <20261125143138.47174-1-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm planning to add syscall common attrs support for LINK_CREATE cmd.

This is the second series for the plan, that adds syscall common attrs
support for LINK_CREATE of tracing prog and cgroup prog.

BTW, address Andrii's review [1] in patch 5:
1. Change if (!OPTS_ZEROED(opts, iter_info_len)) to if
   (!OPTS_ZEROED(opts, log_opts)).
2. Add comment to iter_info and iter_info_len that they are
   deprecated, and use iter.info and iter.len instead.

Links:
[1] https://lore.kernel.org/bpf/CAEf4BzbW4zwL-9j8e2B6KNXVNwsfWyMSAo_RsGCqv-nu_yGhTg@mail.gmail.com/

Changes:
v3 -> v4:
* Collect Acked-by tag from Jiri, thanks.
* Change 'tgt_fd' to 'target_fd' in patch 1. (Sashiko)
* Trim tests to 4 tests for tracing, tracing_multi, iter and cgroup links.
  (Alexei)
* v3: https://lore.kernel.org/bpf/20261123152743.19629-1-leon.hwang@linux.dev/

v2 -> v3:
* Add log support for bpf_check_attach_btf_id_multi().
* Add more selftests to cover more logs for link creation failures.
* Update some log messages in patch 1. (Alexei)
* Add log for dst attach type check in bpf_check_attach_target(). (Alexei)
* Update some log messages in patch 2. (Alexei)
* Pass 'log' to btf_attach_func_proto() and btf_distill_func_proto() in
  bpf_check_attach_btf_id_multi(). (Alexei)
* Add a log msg in check_dup_ids() when dup ids. (Alexei)
* Add a log msg in bpf_tracing_multi_attach() when it returns
  -EOPNOTSUPP. (Alexei)
* Swap function names between iter_info and iter_info_len selftests.
  (Sashiko)
* v2: https://lore.kernel.org/bpf/20261114150610.84507-1-leon.hwang@linux.dev/

v1 -> v2:
* Add log_opts support for bpf_program__attach_iter() API in libbpf.
* Add test to verify the log for freplace max_ctx_offset case.
* Update a subtest to verify the log_opts in bpf_program__attach_iter()
  API.
* Add log for freplace max_ctx_offset case. (bot+bpf-ci)
* Drop unnecessary bpf_verifier.h include. (bot+bpf-ci)
* Change log to "Invalid tracing attach_type.\n" when the link
  attach_type is not prog->expected_attach_type. (bot+bpf-ci)
* Change BPF_XDP to BPF_TRACE_FEXIT in tracing link_create test.
  (bot+bpf-ci)
* Drop dead iter.len check in libbpf. (bot+bpf-ci, Sashiko)
* Add OPTS_ZEROED(opts, iter) check. (bot+bpf-ci, Sashiko)
* Swap log positions of iter_info and iter_info_len. (Sashiko)
* Update bpf_program__attach_iter() to use iter.info and iter.len.
  (Sashiko)
* v1: https://lore.kernel.org/bpf/20261109140816.5196-1-leon.hwang@linux.dev/

Leon Hwang (6):
  bpf: Add log support for tracing link_create
  bpf: Add log support for tracing_multi link_create
  bpf: Add log support for iter link_create
  bpf: Add log support for cgroup prog link_create
  libbpf: Add log_opts support for BPF_TRACE_ITER
  selftests/bpf: Test tracing and cgroup link creation logs

 include/linux/bpf-cgroup.h                    |  6 +-
 include/linux/bpf.h                           |  9 +-
 include/linux/bpf_verifier.h                  |  3 +-
 include/linux/trace_events.h                  |  7 +-
 kernel/bpf/bpf_iter.c                         | 27 ++++--
 kernel/bpf/cgroup.c                           | 76 ++++++++++++-----
 kernel/bpf/syscall.c                          | 30 +++++--
 kernel/bpf/trampoline.c                       |  5 +-
 kernel/bpf/verifier.c                         | 51 ++++++++---
 kernel/trace/bpf_trace.c                      | 27 ++++--
 tools/lib/bpf/bpf.c                           | 23 +++--
 tools/lib/bpf/bpf.h                           |  8 ++
 tools/lib/bpf/libbpf.c                        |  5 +-
 tools/lib/bpf/libbpf.h                        |  3 +-
 .../selftests/bpf/prog_tests/link_log.c       | 85 +++++++++++++++++++
 15 files changed, 290 insertions(+), 75 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/link_log.c

-- 
2.55.0

