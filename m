Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B022B263C7F
	for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915279; cv=none; b=g8oNWMyxNFsPlsunlIoQr5KbZCGz++tRwdh7RB+dQNhJ5hyXcszMLGgEKQ9MML+P/3mHOzh2icaROizizVYj/e95pAyiCAFC5r2COqHfNI+J5seEzxrwOmYE7JtWuQjE21hOXcgAtFPMViznNbop9UKAj6hG8Qlm3R8uWpzOoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915279; c=relaxed/simple;
	bh=yTd4q7I30KXpV97Eihka4fOWawzSGig5FkOSwGuSFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sIYltsCh9HcX+fAOO7UMrrHXgA/R0YWNnLC5QQcjnL+97UivlqU+YiMPqInUaCQL9bfrs4Ys/P8hxn5FYuE+VeD3dnbjhOLk5pQUWWCpyxxOXjahDX0S2/ZtHwtr537xG6o1mV+eGKcCoFg7wNomAuxC9SiXCzTIfV8E8bhiH2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B9ECB45844AAC; Wed, 22 Apr 2026 20:34:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 0/9] bpf: Prepare to support stack arguments
Date: Wed, 22 Apr 2026 20:34:25 -0700
Message-ID: <20260423033425.2536883-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The patch set prepares to support stack arguments for bpf functions
and kfuncs. The major changes include:
  - Avoid redundant calculation of bpf_reg_state. For stack
    arguments, there exists no corresponding register number.
  - Refactor check_kfunc_mem_size_reg() to have bpf_reg_state's
    for both mem_reg and size_reg.
  - Allow verifier logs to print stack arguments if there is no
    corresponding register.

Please see individual patches for details.

Changelogs:
  v2 -> v3:
    - v2: https://lore.kernel.org/bpf/20260422054149.3124342-1-yonghong.s=
ong@linux.dev/
    - Fix a mark_chain_precision issue by rewriting helper reg_from_argno=
().
  v1 -> v2:
    - v1: https://lore.kernel.org/bpf/20260421171927.3507554-1-yonghong.s=
ong@linux.dev/
    - Major change to patch 7. In v1, the argno has type u32 to
      represent registers and arguments. This works but error prone
      as u32 is too easy to mess and leak. This version uses a struct
      type to represent argno which makes things more explicit and easy
      to reason.

Yonghong Song (9):
  bpf: Remove unused parameter from check_map_kptr_access()
  bpf: Fix tail_call_reachable leak
  bpf: Remove WARN_ON_ONCE in check_kfunc_mem_size_reg()
  bpf: Refactor to avoid redundant calculation of bpf_reg_state
  bpf: Refactor to handle memory and size together
  bpf: Rename existing argno to arg
  bpf: Prepare verifier logs for upcoming kfunc stack arguments
  bpf: Introduce bpf register BPF_REG_PARAMS
  bpf: Reuse MAX_BPF_FUNC_ARGS for maximum number of arguments

 include/linux/bpf.h                           |   5 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/filter.h                        |   5 +-
 kernel/bpf/core.c                             |   4 +-
 kernel/bpf/verifier.c                         | 843 ++++++++++--------
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  22 +-
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/ctx_rewrite.c    |  14 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |   2 +-
 .../selftests/bpf/prog_tests/linked_list.c    |   4 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |  14 +-
 .../selftests/bpf/progs/cpumask_failure.c     |  10 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |  22 +-
 .../selftests/bpf/progs/file_reader_fail.c    |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       |   4 +-
 tools/testing/selftests/bpf/progs/iters.c     |   6 +-
 .../selftests/bpf/progs/iters_state_safety.c  |  14 +-
 .../selftests/bpf/progs/iters_testmod.c       |   4 +-
 .../selftests/bpf/progs/iters_testmod_seq.c   |   4 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   2 +-
 .../selftests/bpf/progs/percpu_alloc_fail.c   |   4 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   6 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |  18 +-
 .../selftests/bpf/progs/task_work_fail.c      |   6 +-
 .../selftests/bpf/progs/test_bpf_nf_fail.c    |   8 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |   2 +-
 .../bpf/progs/test_kfunc_param_nullable.c     |   2 +-
 .../selftests/bpf/progs/verifier_bits_iter.c  |   4 +-
 .../bpf/progs/verifier_bpf_fastcall.c         |  24 +-
 .../selftests/bpf/progs/verifier_may_goto_1.c |  12 +-
 .../bpf/progs/verifier_ref_tracking.c         |   6 +-
 .../selftests/bpf/progs/verifier_sdiv.c       |  64 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   8 +-
 .../testing/selftests/bpf/progs/wq_failures.c |   2 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  14 +-
 37 files changed, 625 insertions(+), 545 deletions(-)

--=20
2.52.0

