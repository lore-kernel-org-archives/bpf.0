Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290972E400
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787240; cv=none; b=CmpInA5TNRQwTwrswHIn0sgKNZyEAASoLDtgvLtfPMBc8rKtIz6iLNVqqS0+EBZq1629rpfJeIigfv2QhH1f2bp2S9r6L+uAOPFE97UFMg8ZcmNoLfhTFtwxeWkILvdFZma8shB7Ljgux3tp3foaKeZ27x1CHz6LG8ootB/qsOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787240; c=relaxed/simple;
	bh=pvQvJAka8X5x84Ei5v5G031/Ffjx7sKygBO+UBVzahY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elYnUdeMPqrkxbIFajUDB3DprzBxXGSYKYASgU50C3GvlmE6jyPufWfXI0XCL+ZcDq7QzKTKFM21WIraMoVtPKwAHjtdYwpe69O1XlpOrzqVVImNPyq0t6fkJn1NL+2lGIniutitVC+knB0PC6s3XoO7DBbDu2isZBUkX6Hs5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRO/GEBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRO/GEBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6327CC43394;
	Mon, 18 Mar 2024 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710787239;
	bh=pvQvJAka8X5x84Ei5v5G031/Ffjx7sKygBO+UBVzahY=;
	h=From:To:Cc:Subject:Date:From;
	b=IRO/GEBPERm9Fbb1Gd+mahrBJO0cF09FPYP8LBks93WCOEK3lTU9FMQBaKuq0Wpod
	 YT6ST9kuyQ7z2bYZulY1Oc/snnFkFychW4VgpD7Ejlb1JqgvKPKBTY3t39quwWHLhf
	 4fosDIYqT2/EB5l0zuH96eptWjdU2AKzCma2SLsUMfjRAm2SUeIa5xCEYU7JmogNtH
	 aqrCb2Be25fgPkm8NmC6qan1hGo7UaOj97zpK4yYy4uFaYiGf60vlAzbsLHsqBzFxM
	 8eZdGa4sr53bgb7s9w1OtgOAulUzKkPF+D43RhCcqZt9EEpqOkWz+ZAHrbSOrWmPKp
	 4HtyG5+SQSjag==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 0/5] BPF raw tracepoint support for BPF cookie
Date: Mon, 18 Mar 2024 11:40:32 -0700
Message-ID: <20240318184037.3209242-1-andrii@kernel.org>
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

