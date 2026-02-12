Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD41C68F
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770858858; cv=none; b=G5KIwPTcDlmUpEonXr+EeIMnpndcs+O70OQ3K6hzlE0Ful4qixomnVqUFzlKwgf8zrP63hH/p1RL8OfQESZ7CZriKZ18g36J+EE0wEjaFQVxEyEwrf0oJlKVgpjjsAtkQvTH3wdEuMsIIXM4/FZoTYOU1dXM0g9lxX1zCol8x3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770858858; c=relaxed/simple;
	bh=FpkRjo2UxL5e/FZAW59Y7JAOxBi9HFB/8gYr/YIf7yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FrQ+2uRrlJzE3c/UBReJ+XEdyxod3NN6Z6YwdHzOtPUSwcLAMGrhwfytadg4WEjT3IPnJIooQql7TDvha423e/QAT1WWe5UYe/KNL7BK/HQGD4kyrv7Ye2Nr9Q7OXqTqWwy90zzjUehR5Ue4bl5LR3bfB+hDFJtHLTCeXsK9834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f4REltFq; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f4REltFq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770858853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/X23ti+vOhwD3+0c762hDa4cAXCOJA8a78e78JOcyuk=;
	b=f4REltFqn79WNOUGq+K2L0YSJWbUoo1bSxt6dF58GRvOifikVx/kc1+9u5kmn2G7oAb0Un
	3D/jfTLakJeMe5ADjPpO9HdGpJ3CGMlPbq4UblchKZ1zONVEJx3uqxS0XiPAB84/CDdIwp
	v7Cc+nWvhjnkj9q3fJ1L9cmKrlJRfA4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/14] selftests/bpf: Fixes for userspace ASAN
Date: Wed, 11 Feb 2026 17:13:42 -0800
Message-ID: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series includes various fixes aiming to enable test_progs run
with userspace address sanitizer on BPF CI.

The first patch fixes the selftests/bpf/test_progs build with:

    SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"

The subsequent patches fix bugs reported by the address sanitizer on
attempt to run the tests.

The series is a pre-requisite for enabling "test_progs with ASAN"
workflow on BPF CI.

Ihor Solodrai (14):
  selftests/bpf: Pass through build flags to bpftool and resolve_btfids
  resolve_btfids: Fix memory leaks reported by ASAN
  selftests/bpf: Add DENYLIST.asan
  selftests/bpf: Refactor bpf_get_ksyms() trace helper
  selftests/bpf: Fix memory leaks in tests
  selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
  veristat: Fix a memory leak for preset ENUMERATOR
  selftests/bpf: Fix use-after-free in xdp_metadata test
  selftests/bpf: Fix double thread join in uprobe_multi_test
  selftests/bpf: Fix resource leaks caused by missing cleanups
  selftests/bpf: Free bpf_object in test_sysctl
  selftests/bpf: Fix array bounds warning in jit_disasm_helpers
  selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
  selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()

 tools/bpf/resolve_btfids/Makefile             |  7 +-
 tools/bpf/resolve_btfids/main.c               | 78 ++++++++++++-------
 tools/testing/selftests/bpf/DENYLIST.asan     |  3 +
 tools/testing/selftests/bpf/Makefile          |  9 ++-
 .../selftests/bpf/benchs/bench_trigger.c      |  9 +--
 tools/testing/selftests/bpf/bpftool_helpers.c | 12 ++-
 .../selftests/bpf/jit_disasm_helpers.c        | 18 ++---
 .../bpf/prog_tests/cgrp_local_storage.c       |  4 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  5 +-
 .../selftests/bpf/prog_tests/fd_array.c       |  4 +-
 .../selftests/bpf/prog_tests/htab_update.c    |  1 +
 .../bpf/prog_tests/kmem_cache_iter.c          |  7 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 12 ++-
 .../selftests/bpf/prog_tests/lwt_seg6local.c  |  2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 18 +++--
 .../selftests/bpf/prog_tests/sockmap_listen.c |  2 +-
 .../bpf/prog_tests/struct_ops_private_stack.c |  1 +
 .../selftests/bpf/prog_tests/tc_opts.c        |  1 +
 .../selftests/bpf/prog_tests/test_sysctl.c    | 22 ++++--
 .../selftests/bpf/prog_tests/test_tc_tunnel.c |  5 +-
 .../selftests/bpf/prog_tests/test_xsk.c       |  2 +
 .../bpf/prog_tests/uprobe_multi_test.c        |  4 +-
 .../selftests/bpf/prog_tests/verifier_log.c   |  2 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  4 +-
 tools/testing/selftests/bpf/testing_helpers.c |  1 +
 tools/testing/selftests/bpf/trace_helpers.c   | 23 +++---
 tools/testing/selftests/bpf/trace_helpers.h   | 11 ++-
 tools/testing/selftests/bpf/veristat.c        |  2 +
 28 files changed, 170 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.asan

-- 
2.53.0

