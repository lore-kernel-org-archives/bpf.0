Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302C366554
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611637; cv=none; b=rLXtPDr5BgVmEgz28FKSY1Wc0aVQLzmK7nwEZD0TeUxa945n4B4KtlEyOtITBsvdNan97WTGWUwmX2UjHqWa0rQdSyN1ipjnyYmhxyiBl41kNalHGvu+H2/iUVXZWMyYbFXvWnfO0Gw4Q9oY5rN3nhZIfBt0F04K6R75JfPAu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611637; c=relaxed/simple;
	bh=pOaVrw8+5oC6k2mZr/j02FhI/Smdw+rTnjm8g/m0Mno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RLcEDj559nELEU9f9okLqE9MCE7npdeGDHNWS6M/52YDbuMhitxnqJB/xWVakURqgvlJHkJLOrRuYnb6eZJvCqPl4o10v8OzmPUDLqLTRT0kTkczxaa+g6ObOFPNMjsZOfi4EzlWVGonpzuFH9kTEUPC63h3zFG2FN/dqIQ+9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dlLvcXB6; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dlLvcXB6"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hXWat7QWqayoWoVBxptxmCVQwWpUHDKy1evf0zwwBoE=;
	b=dlLvcXB62mINmDPJqZnYDTL+EfWzBO+xYbCjFAfGeHsh5D5NJ1sxz0U6sGcOkYXQ39nXtF
	XR1NGCQIjiO3VA4KaqX/gPNqtviYKHIzUhOPANCTrgI45j75eBR9dSHmppnjkburuvH+X6
	LA95UGLHjGg+UIhU9zesspt41nLoe38=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/7] selftests/bpf: Add and use strscpy()
Date: Fri, 20 Feb 2026 10:20:04 -0800
Message-ID: <20260220182011.802116-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series introduces a simplified implementation of strscpy() to
selftests/bpf and then replaces strcpy/strncpy usages across the tests
with it.

For context see a discussion that prompted this series [1].

[1] https://lore.kernel.org/bpf/CAADnVQ+9uw2_o388j43EWiAPdMB=3FLx2jq-9zRSvqrv-wgRag@mail.gmail.com/

Suggested-by: Alexei Starovoitov <ast@kernel.org>

Ihor Solodrai (7):
  selftests/bpf: Add simple strscpy() implementation
  selftests/bpf: Add strscpy_cat()
  selftests/bpf: Replace strcpy() calls with strscpy()
  selftests/bpf: Replace strncpy() with strscpy()
  selftests/bpf: Use strscpy_cat() in the test_loader
  selftests/bpf: Use strscpy in bpftool_helpers.c
  selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies

 tools/testing/selftests/bpf/bpf_util.h        | 66 +++++++++++++++----
 tools/testing/selftests/bpf/bpftool_helpers.c | 16 +++--
 tools/testing/selftests/bpf/cgroup_helpers.c  |  2 +-
 tools/testing/selftests/bpf/network_helpers.c |  5 +-
 .../testing/selftests/bpf/prog_tests/align.c  |  2 +-
 .../selftests/bpf/prog_tests/bpf_iter.c       |  3 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  6 +-
 .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
 .../bpf/prog_tests/queue_stack_map.c          |  4 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c |  2 +-
 .../bpf/prog_tests/skc_to_unix_sock.c         |  2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
 .../bpf/prog_tests/task_local_data.h          |  2 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |  2 +-
 .../selftests/bpf/prog_tests/test_veristat.c  |  4 +-
 tools/testing/selftests/bpf/test_loader.c     |  8 +--
 tools/testing/selftests/bpf/test_progs.c      |  2 +-
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/xdp_features.c    |  3 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  4 +-
 21 files changed, 93 insertions(+), 50 deletions(-)

-- 
2.53.0

