Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AA17BAE
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 20:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535527; cv=none; b=OroxIv7l8uJkZX2wX8CBHz06/dRPNu0nK670ctR0KnnHF5MmErcR0ap6p5ztDWqr3eHstbXMMMbIxskiNSHB2Z3VEyzNGlnOceV/HYY12Fq6XlR0nAwRZnx4pofM3VLW1WdthJdneUw7eHP4R0upD1Bl7fx5YJ0WVcrxR0w/laM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535527; c=relaxed/simple;
	bh=q7c44bBfInkEF9rQQLVn4vvoPXD8EWn1C5PV7Bwb5M8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SiDa8QUIkZLEkwDJtmW/X1J9Ze5kWZDJIAyflG3GzH4cnmuYBO/fmkvgEI89Rmb07cqUQilIt0wbb8xl/742zfitb7ZUYMFYs90R5OQAX9hPnwHrDSCPSjUeMfHwbTBS8knSI8XfkTPASuNqQjyQq4KM9qLZPKFCYadlcuOV9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7Awtd8e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7Awtd8e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDDC433F1;
	Fri, 15 Mar 2024 20:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535526;
	bh=q7c44bBfInkEF9rQQLVn4vvoPXD8EWn1C5PV7Bwb5M8=;
	h=From:To:Cc:Subject:Date:From;
	b=l7Awtd8efIdeg4i+v53JYuSWABXXHss5jX38SlKQV3oAt1hhcX4Fq8eq0z5Qwv9TZ
	 6gYEqhgcZVMsCOMWKb7gRxckfj5TNNKbgnaoYAehqxzoyx9lqSM/bCNZ+YUDABtYvv
	 9IepQ5LsuWo1Grc6E39oERKU+3r0IXYmZZu/FLzBmjOy/iuT5ZnYf9anXHP+pc/G3M
	 ufPc/Lu6nEbhvnM3VO9cPMieHPmWPOBhpJCk1XeOfv4eEb6m3OBpQTnGH2Ud57voU2
	 aEvreHqy/Z5HBGS/No2IfoGQ73O2ZiklgX4jgJrn5hJQAyf6gnl6wAxP0OSlc1Cc9H
	 Xec7F4GPrBxxQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/5] BPF raw tracepoint support for BPF cookie
Date: Fri, 15 Mar 2024 13:45:19 -0700
Message-ID: <20240315204524.967664-1-andrii@kernel.org>
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

Andrii Nakryiko (5):
  bpf: flatten bpf_probe_register call chain
  bpf: pass whole link instead of prog when triggering raw tracepoint
  bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs
  libbpf: add support for BPF cookie for raw_tp/tp_btf programs
  selftests/bpf: add raw_tp/tp_btf BPF cookie subtests

 include/linux/bpf.h                           |   6 +
 include/linux/trace_events.h                  |  31 ++---
 include/trace/bpf_probe.h                     |   3 +-
 include/uapi/linux/bpf.h                      |   1 +
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
 14 files changed, 242 insertions(+), 46 deletions(-)

-- 
2.43.0

