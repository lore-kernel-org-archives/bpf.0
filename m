Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A044369216
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873677; cv=none; b=RfK0ZSMigHOW5AIThNXAd4bJfgrp/hU9Z9NV8mziE2dn3t9KSG/ZGL94xrk9CmEPaYqsylUjJ7RoMr9InIRbDqPKAoyd4b2b1BNIy612oRXRZbDjkRf3vtqfl0PXx7m80Zjp9sYoP9/5O9F6p4njLR03pRUSQjtmGji9fBxSuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873677; c=relaxed/simple;
	bh=BfQoMTQmk6Gix/4PAU+IKi+T+apkNEa9jaC4e30EJLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCyizYFJhbkrwytQuo8pPEJ8TlL0/2smi2q2nrgmxWmBteEKKCVQ1GGWn0Ylfuop1kZD+UO00dWkdo4ESXS/L7Qmsd/399C+iQWFpLGDM7p2Rs2fsCgEZeL8st0e6mFIN0vDKqMzE4OK2sXr3yNvW0FSvHnkva6QcL4SgPLc8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OHapdMKc; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OHapdMKc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LAUDXIchVbH1skRajklMeB3JqUeYZ5onT5pRPNpzJ/A=;
	b=OHapdMKcEv7ExpYrFdeEDGYrkjvYMwv6tQIh12z13ML+ScGP1tTuX9KHSHLTUjoQVQ4RD0
	LXv3byfEL8cnrgfBHBW2U192IZ8zB/dmUfwIuiqLLGFJwMMh1qy957ntm6FntBwoCIoqUw
	wokZDeqnsNdxYBBXSl0CQuwc5MIv2eI=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v4 00/20] selftests/bpf: Fixes for userspace ASAN
Date: Mon, 23 Feb 2026 11:07:16 -0800
Message-ID: <20260223190736.649171-1-ihor.solodrai@linux.dev>
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

The first five patches add a simplified implementation of strscpy() to
selftests/bpf and then replace strcpy/strncpy usages across the tests
with it. See relevant discussions [1][2].

Patch #6 fixes the selftests/bpf/test_progs build with:

    SAN_CFLAGS="-fsanitize=address -fno-omit-frame-pointer"

The subsequent patches fix bugs reported by the address sanitizer on
attempt to run the tests.

[1] https://lore.kernel.org/bpf/CAADnVQ+9uw2_o388j43EWiAPdMB=3FLx2jq-9zRSvqrv-wgRag@mail.gmail.com/
[2] https://lore.kernel.org/bpf/20260220182011.802116-1-ihor.solodrai@linux.dev/

---

v3->v4:
  - combine strscpy and ASAN series into one (Alexei)
  - make the count arg of strscpy() optional via macro and fixup
    relevant call sites (Alexei)
  - remove strscpy_cat() from this series (Alexei)

v3: https://lore.kernel.org/bpf/20260220222604.1155148-1-ihor.solodrai@linux.dev/

v2->v3:
  - rebase on top of "selftests/bpf: Add and use strscpy()"
    - https://lore.kernel.org/bpf/20260220182011.802116-1-ihor.solodrai@linux.dev/
  - uprobe_multi_test.c: memset static struct child at the beginning
    of a test *and* zero out child->thread in release_child (patch #9,
    Mykyta)
  - nits in test_sysctl.c (patch #11, Eduard)
  - bpftool_helpers.c: update to use strscpy (patch #14, Alexei)
  - add __asan_on_error handler to still dump test logs even with ASAN
    build (patch #15, Mykyta)

v2: https://lore.kernel.org/bpf/20260218003041.1156774-1-ihor.solodrai@linux.dev/

v1->v2:
  - rebase on bpf (v1 was targeting bpf-next)
  - add ASAN flag handling in selftests/bpf/Makefile (Eduard)
  - don't override SIGSEGV handler in test_progs with ASAN (Eduard)
  - add error messages in detect_bpftool_path (Mykyta)
  - various nits (Eduard, Jiri, Mykyta, Alexis)

v1: https://lore.kernel.org/bpf/20260212011356.3266753-1-ihor.solodrai@linux.dev/

---

Ihor Solodrai (20):
  selftests/bpf: Add simple strscpy() implementation
  selftests/bpf: Replace strcpy() calls with strscpy()
  selftests/bpf: Replace strncpy() with strscpy()
  selftests/bpf: Use strscpy in bpftool_helpers.c
  selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
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
  selftests/bpf: Don't override SIGSEGV handler with ASAN

 tools/bpf/resolve_btfids/Makefile             |  7 +-
 tools/bpf/resolve_btfids/main.c               | 81 ++++++++++++-------
 tools/include/linux/args.h                    |  4 +
 tools/testing/selftests/bpf/DENYLIST.asan     |  3 +
 tools/testing/selftests/bpf/Makefile          | 13 ++-
 .../selftests/bpf/benchs/bench_trigger.c      | 14 ++--
 tools/testing/selftests/bpf/bpf_util.h        | 45 ++++++++---
 tools/testing/selftests/bpf/bpftool_helpers.c | 25 ++++--
 tools/testing/selftests/bpf/cgroup_helpers.c  |  2 +-
 .../selftests/bpf/jit_disasm_helpers.c        | 18 ++---
 tools/testing/selftests/bpf/network_helpers.c |  5 +-
 .../testing/selftests/bpf/prog_tests/align.c  |  2 +-
 .../selftests/bpf/prog_tests/bpf_iter.c       |  3 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../bpf/prog_tests/cgrp_local_storage.c       |  4 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  6 +-
 .../testing/selftests/bpf/prog_tests/dynptr.c |  5 +-
 .../selftests/bpf/prog_tests/fd_array.c       |  4 +-
 .../selftests/bpf/prog_tests/flow_dissector.c |  4 +-
 .../selftests/bpf/prog_tests/htab_update.c    |  1 +
 .../bpf/prog_tests/kmem_cache_iter.c          |  7 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 12 ++-
 .../selftests/bpf/prog_tests/lwt_seg6local.c  |  2 +-
 .../bpf/prog_tests/queue_stack_map.c          |  4 +-
 .../selftests/bpf/prog_tests/setget_sockopt.c |  2 +-
 .../bpf/prog_tests/skc_to_unix_sock.c         |  2 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 28 +++----
 .../selftests/bpf/prog_tests/sockmap_listen.c |  2 +-
 .../selftests/bpf/prog_tests/sockopt_sk.c     |  2 +-
 .../bpf/prog_tests/struct_ops_private_stack.c |  4 +-
 .../bpf/prog_tests/task_local_data.h          |  2 +-
 .../selftests/bpf/prog_tests/tc_opts.c        |  6 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |  2 +-
 .../selftests/bpf/prog_tests/test_sysctl.c    |  3 +
 .../selftests/bpf/prog_tests/test_tc_tunnel.c |  5 +-
 .../selftests/bpf/prog_tests/test_veristat.c  |  4 +-
 .../selftests/bpf/prog_tests/test_xsk.c       | 24 +++++-
 .../bpf/prog_tests/uprobe_multi_test.c        |  6 +-
 .../selftests/bpf/prog_tests/verifier_log.c   |  2 +-
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  4 +-
 tools/testing/selftests/bpf/test_progs.c      | 38 ++++++---
 tools/testing/selftests/bpf/test_verifier.c   |  2 +-
 tools/testing/selftests/bpf/testing_helpers.c |  1 +
 tools/testing/selftests/bpf/trace_helpers.c   | 23 +++---
 tools/testing/selftests/bpf/trace_helpers.h   | 11 ++-
 tools/testing/selftests/bpf/veristat.c        |  2 +
 tools/testing/selftests/bpf/xdp_features.c    |  3 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  4 +-
 48 files changed, 291 insertions(+), 164 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.asan

-- 
2.53.0

