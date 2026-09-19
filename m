Received: from out-2z4y-a153.jellyfish.systems (out-2z4y-a153.jellyfish.systems [198.54.127.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828518AE3
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816384; cv=none; b=e77ZxxSitC12ldW3RZ0fef0jesTowp5rJ2wtAKvXlVN0SFI6Cjfokj755+5Oy4/77bY4ey6OSKpEx48PjBSX5fn/1U19JM/5Mgw5fHnsPI6vUhfPNCG8tGkQ9gV1B6BAz1kkjk8TBYi6oSQ35KAITyLzMmrQnIoCen/9MIP9YS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816384; c=relaxed/simple;
	bh=EhzIVbJUm2xb2MzRo9Hv6hBL8wRVhiQSI+kqFk8Vi/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxSYTcpoFZdKnf/gxk6j/l/5tXiABJHr3uOK2FrPHglF4qybcOEgzl7uS4fUxW2HA4gpZFAD2iWycQLlYuzdCrCXUy/Eux3nKNSl5MulE+ALUfRmrxNHQ+O1PVKKA0B5//aCRfnRNV+5cPHmRbt0WMPitP0rrs75nT2xXESLWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=GjDa6i/b; arc=none smtp.client-ip=198.54.127.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="GjDa6i/b"
Received: from fedora (unknown [39.144.124.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hn6CP0qm4z8sWP;
	Sat, 19 Sep 2026 11:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789816052;
	bh=hT16bSRdNpDa3lNze4b5HShwtsymD12EkC6GmiM8Y8k=;
	h=From:To:Cc:Subject:Date:From;
	b=GjDa6i/b/QwOxmj1rED/54urvdK/e/F0YKPdbxb4NbBP1VANmNdIzerEJI4C9+V9x
	 Ub9jLHY3v87gC4o5bRqLAXZveArpFoSKE0n1riHmc87NWJiFv8EH2dpMNkoR1Kg2dj
	 MsBxxB5gMDwiu3hd34cUfvp8iYVAEfIZoCsyZbVxF11OMQ09NCjY02qkVV2Iu9XC8J
	 RSdNdHiNvHFUgDvdFNQng8GyZ7CnelhS1ExGsWedZLJ3rbviVm+bIAXXjmcmByrJW+
	 VeG1IYHlY2G9hoqqI61D+HOCez0qfRt16kD5drcpTQLGuVtMtxMQ1jmGX/mVjGjIzH
	 ZM1nsEWsNTvdA==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpftool: Consume ring buffer maps with event_pipe
Date: Sat, 19 Sep 2026 19:07:19 +0800
Message-ID: <20260919110721.1230756-1-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Extend map event_pipe to consume BPF ring buffer records, with plain and
JSON output and focused tests for records, shutdown and invalid arguments.

Changes in v4, addressing Quentin's review:
- Accept multiple map types in the completion helpers.
- Preserve the normal diagnostic for unknown arguments.
- Use p_err() for errors and drop the redundant ownership comment.
- Reuse detect_bpftool_path() and check the exec-error write result.
- Add a JSON regression for unknown arguments.

Rebased on current bpf-next. All 18 ringbuf subtests pass in an x86-64 VM,
including the existing perf event array path. Completion matching and
plain/JSON polling-error output were also checked.

v3: https://lore.kernel.org/r/20260911025114.190899-1-diannaaav@gmail.com

Tianyi Chen (2):
  bpftool: Read ring buffer maps with event_pipe
  selftests/bpf: Cover bpftool ring buffer event_pipe

 .../bpf/bpftool/Documentation/bpftool-map.rst |  14 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  53 ++-
 tools/bpf/bpftool/map_perf_ring.c             |  87 +++-
 tools/testing/selftests/bpf/bpftool_helpers.c |   2 +-
 tools/testing/selftests/bpf/bpftool_helpers.h |   1 +
 .../bpf/prog_tests/bpftool_ringbuf.c          | 417 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_ringbuf.c     |  47 ++
 7 files changed, 574 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_ringbuf.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_ringbuf.c


base-commit: 559b90b855ce535572e743ed79a59f728ac30fb0
-- 
2.55.0

