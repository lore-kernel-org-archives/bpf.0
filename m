Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6F3D55D
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710891535; cv=none; b=FZ/5WWaRzL8IDnunFojT8IcTcbeuFS6gX+F/2ePlnD/DnTSX79uBKeCbqBrQWnHEPh2QC5sq4fW2zSftkc5NMJ7YJp9OTrLRaWojlYpM4sZ8TwCmwMpuZlXCC+phWrXSac8tht3TD6Jp6NAkJBUsLdfjCxDU/wkesk2zgQgxMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710891535; c=relaxed/simple;
	bh=Rh38fmwghZmZvWoD0B51E56U8z4tmA2TU/mzjgMnwfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hUYXOK/JoP2kQ1dMhN61wvlhtRxnPauTSAQ7qNh65qSkfuE+zHJP/o1G91352mcIN9LzSeNN2IAA5tcC4vgnJ7OC05uhZUYv6Ls07hLJcfri3cW2HVp4AjggPEPwA1a7a5lboZbQ4bwztxzqx1zqGd7hR6BYbYF2YMXEGwO3/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQTL3Eam; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQTL3Eam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D79BC433C7;
	Tue, 19 Mar 2024 23:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710891535;
	bh=Rh38fmwghZmZvWoD0B51E56U8z4tmA2TU/mzjgMnwfE=;
	h=From:To:Cc:Subject:Date:From;
	b=fQTL3EamTdBkzTBpcEfwgGqc+rG+0VkSNJIB0+XJtYBooGYdxTew/rOxdI6CBQct2
	 WCGSgdH73d8CUgzqTuoeo/hh5uQ3Rh9Lpr5b69HnQM12PVUui3ZegyyM89GcvEKeuD
	 c+le0+KW8FXBzPLeMEoatpXHzu82YnshmOPXXrEe1gVvF34Yds/jCbKQOMR09rpA/I
	 //8Yd2jCSRNz2twPyFXF7wFh78T04z8xebgF0plnKGbtjLv98OO+RqK+nIwABLfCuO
	 u/UfScnnIDwuOP8K+UfYzf6rX1AsCmVU6W1bzPhJgWqmnNDfpCfBebYfnduPz8cmSC
	 BQHQ8IyiMhYxA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 0/5] BPF raw tracepoint support for BPF cookie
Date: Tue, 19 Mar 2024 16:38:47 -0700
Message-ID: <20240319233852.1977493-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to specify and retrieve BPF cookie for raw tracepoint programs.
Both BTF-aware (SEC("tp_btf")) and non-BTF-aware (SEC("raw_tp")) are
supported, as they are exactly the same at runtime.

This issue recently came up in production use cases, where custom tried to
switch from slower classic tracepoints to raw tracepoints and ran into this
limitation. Luckily, it's not that hard to support this for raw_tp programs.

v2->v3:
  - s/bpf_raw_tp_open/bpf_raw_tracepoint_open_opts/ (Alexei, Eduard);
v1->v2:
  - fixed type definition for stubs of bpf_probe_{register,unregister};
  - added __u32 :u32 and aligned raw_tp fields (Jiri);
  - added Stanislav's ack.

Andrii Nakryiko (5):
  bpf: flatten bpf_probe_register call chain
  bpf: pass whole link instead of prog when triggering raw tracepoint
  bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs
  libbpf: add support for BPF cookie for raw_tp/tp_btf programs
  selftests/bpf: add raw_tp/tp_btf BPF cookie subtests

 include/linux/bpf.h                           |   6 +
 include/linux/trace_events.h                  |  36 +++---
 include/trace/bpf_probe.h                     |   3 +-
 include/uapi/linux/bpf.h                      |   6 +-
 kernel/bpf/syscall.c                          |  22 ++--
 kernel/trace/bpf_trace.c                      |  36 ++++--
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |  16 ++-
 tools/lib/bpf/bpf.h                           |   9 ++
 tools/lib/bpf/libbpf.c                        |  20 ++-
 tools/lib/bpf/libbpf.h                        |  11 ++
 tools/lib/bpf/libbpf.map                      |   2 +
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 114 +++++++++++++++++-
 .../selftests/bpf/progs/test_bpf_cookie.c     |  16 +++
 14 files changed, 248 insertions(+), 50 deletions(-)

-- 
2.43.0

