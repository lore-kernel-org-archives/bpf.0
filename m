Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF99368D77
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570397; cv=none; b=BsajeJloOl3hZXDCnEZ6JQ5eex1ghtB5QjfHtmgMo5+cQOnTFcg3Dxdq1Lxoj5mQd4dfD6Pb5kHdOMLlJJCgWae4DejhpK29bzH9sAFcPOmiuYOFjG5iRLXRGs/oZn7W0iW1jymnRoHBKZ+zdS7LmKZ3iMDHcsz5oIA7OjgF2XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570397; c=relaxed/simple;
	bh=tQSvnLWWUOryEyrc8hXwxzvabc7lJ+K4EA1NPdIxK4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1jPWTFqDBlRb902aOtfcmMxEeif5L9O8hsVQi1D05rYDVnN5qF5t+MmEe4zbvZa2uwn2Rikk8C2XsEtF++KQqSJFVl134VonRAtSPUXKCAvR4Drd3vpRpQj5A7ZUY6+DaTa0IoGUmhk4agi1f+dVz0EOVlIGVQGW94ycThdvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1vZekg+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1vZekg+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84a2dcede83so2573128b3a.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570396; x=1786175196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZw4nIzdHIckredH7aGM0VMLQoQFkf8fWuN6zvirYTw=;
        b=C1vZekg+VJFO3PtY3suLLBKrMGjtS3htHUkkoOrRjJ1YkwMLFAMs45F0srUaoNVn0U
         dmp+hVKxWalK5GT4J+p2qk8dfMZ/IZ9tM3nW2mjXblwOAN0lRX27t6PsYD2zqsrZbfTA
         pAprGuWk2KEfd6Ub8djw5Zwico6QKHyXOGAYriMk2HpSSquqM6PoqS9eVmh6kTqVB2oo
         +OKnAstbqb0vLuZB8LOwNHfWbEh5ruHCN2XFEQfyO/HAuyz0UhUVL0psuit6/YrIOd0J
         LW3IBqeDVPSsDyXxjJYSuB2U9uOPZ/tYmrSmdSGOgF70hR3wcY8jhWwuh1Op2A8hcJRN
         HC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570396; x=1786175196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZw4nIzdHIckredH7aGM0VMLQoQFkf8fWuN6zvirYTw=;
        b=sg/nE3KwAaexxWU2U7oeIXoqf51LG/gHGX20ks6IWtWDBCUW2zF5si8VnykA2nh+Gg
         N+zMeh/bzQek/P0s71mL6Wlz8Je9rJlPrjuyeQUT3fUBFZ+r5k9gYRrTaqyiNUMYWQPH
         QsOc1X5JZITs/9fjIW3ibQr36szW7PSzgZScQB9wfHp9wm7tOwOQZ7yq/u6I9z6I/QUS
         /sXRVH+AB6cyGpye96mxyy4MVo6+dxdHJeMb6/W/r4QmxODtZnijhbpTf92THF5uOlA0
         cUMgZ+pRyYwuTyGRE6QL7WAWaO7qPkHoVNA5E4K1hceRXYPliSp2IyXzJepIIPFvh6z1
         xFKw==
X-Gm-Message-State: AOJu0Yzfe7lW8fkLnaoIktye/TvxdUEvUJ8WEjepmM6AQS8P1Q6v5wGm
	2nPBEKp1u/fNCFgYnSzqAYUTbWIBmsZhnv7/5cPCSGUK02c48sHIQZmRXB1Pxw==
X-Gm-Gg: AR+sD10f0cxLIG00Y+/2nxyVuHpgrB1fKrB89FFy29LvwwCJgNQD3F2ul7yuBzPL6WZ
	bx6sDr4oD4l9kSgVpGbt66064phMhSGzY3+lxdNS88o4rx8QX8imPGfOiox9nNCW8YrJejEbXXD
	ubfvv4zs8X1zlEA1LpMsETR5AnZWs9ktusaVVrDPcD8D0ZSV9y4pq1EKTLaRHhGwH59m8K3WHpp
	4UL59DrlHJFepiDhrhG5+mWhpTYHiukvwGNkJG0rBKoOmE1o7ipi7UCb2gof9ReBS0u9H54c8Uo
	eZVMTfDAPixH3jAvSO67KEuM9a5OYyzGJzW1g0FkiTwpFH7BPWxsSm8Oc6olmssUkVVAnyJQijn
	NX8k+6TFF5Ad8Kvmpid21XT2y5UBYv9wwFinKV3A/nNy1gFICTB03EYmaCkdzXg4m0egh+SiAHk
	W1Mxcm/2VRICx8pIG9nry7kMVYaqWrktIN4TRZeynxLDAAfYabufY=
X-Received: by 2002:a05:6a00:6088:b0:845:d284:9e14 with SMTP id d2e1a72fcca58-84ee4956428mr2282291b3a.59.1785570395605;
        Sat, 01 Aug 2026 00:46:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:47::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edc29e6f0sm1390335b3a.39.2026.08.01.00.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:34 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 00/18] Generate bpf_func_proto for kfunc
Date: Sat,  1 Aug 2026 00:46:15 -0700
Message-ID: <20260801074633.1595644-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the second of three patch sets to unify kfunc and helper
argument verification. It:

  1) further aligns the kfunc and helper argument checks,
  2) makes kfunc argument type classification depend solely on BTF, and
  3) generates a bpf_func_proto for each kfunc.

With classification now a pure function of the kfunc's BTF, it is computed
once at add-call time and cached in the generated bpf_func_proto, rather
than re-derived on every verification of the call. Along the way it also
fixes a few issues.

The next patch set will align the argument register compatibility checks
and route helper and kfunc argument verification through a single shared
function.


[1/3] https://lore.kernel.org/bpf/20260715064047.1793790-1-ameryhung@gmail.com/


Changelog

v2 -> v3:
 - Drop a patch that introduces SCALAR_MAYBE_ZERO (Eduard)
 - Drop patch make helper handle mem+size at mem arg, and instead make
   kfunc also handle mem+size at size
 - patch 5: New patch replacing temporary mark_ptr_not_null_reg hack
   with refine_ptr_not_null_reg (Eduard)
 - patch 8: Only allow global subprog to read poisoned stack slots
   (Eduard)
 - patch 11: Test a precision gap when passing NULL to nullable-mem +
   size arg (Eduard)
 - patch 15: Reorganize BTF_ID, MEM, MEM+SIZE classification for
   clarity (Eduard)
 - patch 18: Emded bpf_func_proto in bpf_kfunc_desc and dynamically
   resize bpf_kfunc_desc_tab; Record saved_dst_prog_type early in
   bpf_prog_load to avoid introducing a fallback logic in
   resolve_prog_type (Eduard)

   Link: https://lore.kernel.org/bpf/20260724190813.1458271-1-ameryhung@gmail.com/

v1 -> v2:
 - patch 2: use reg_arg_name() for the map-mismatch message; derive the
   object register correctly on both helper and kfunc paths
 - patch 3: reject non-CONST_PTR_TO_MAP regs (base_type check) to fix
   map-value type confusion
 - patch 15: also reject referenced regs with unsafe modifiers (e.g.
   MEM_PERCPU)
 - patch 17: reject non-SCALAR_VALUE for KF_ARG_MEM_SIZE 


Amery Hung (17):
  bpf: Drop process_timer_func wrappers
  bpf: Unify const map ptr argument checking for helpers and kfuncs
  bpf: Split kfunc map argument into __const_map and __map
  bpf: Pass kfunc meta to mem and mem_size check
  bpf: Check helper and kfunc mem+size arguments identically
  selftests/bpf: Test map lookup result refinement
  bpf: Check fixed-size mem args of helpers and kfuncs the same way
  bpf: Rename ARG_CONST_SIZE{,_OR_ZERO} to ARG_MEM_SIZE{,_OR_ZERO}
  bpf: Fold __szk const size handling into the scalar arg path
  selftests/bpf: Test __szk precision with a NULL nullable buffer
  bpf: Classify kfunc mem_size args from BTF without register state
  bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
  bpf: Distinguish fixed- and variable-size kfunc mem args with
    MEM_FIXED_SIZE
  bpf: Classify kfunc pointer arguments from BTF, resolve type against
    the register
  bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
  bpf: Classify scalar kfunc arguments from BTF
  bpf: Generate kfunc argument prototype at add-call time

Eduard Zingerman (1):
  bpf: Resolve map lookup result type at lookup time

 Documentation/bpf/kfuncs.rst                  |  30 +-
 include/linux/bpf.h                           |  40 +-
 include/linux/bpf_verifier.h                  |  22 +-
 kernel/bpf/backtrack.c                        |   2 +-
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/cgroup.c                           |   8 +-
 kernel/bpf/helpers.c                          |  42 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/stackmap.c                         |  10 +-
 kernel/bpf/syscall.c                          |   8 +-
 kernel/bpf/verifier.c                         | 830 ++++++++++--------
 kernel/trace/bpf_trace.c                      |  62 +-
 net/core/filter.c                             | 116 +--
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   2 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../progs/verifier_helper_access_var_len.c    |   6 +-
 .../bpf/progs/verifier_helper_value_access.c  |   2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |   2 +-
 .../bpf/progs/verifier_map_lookup_refine.c    |  73 ++
 .../bpf/progs/verifier_mem_size_reg.c         |  28 +
 .../selftests/bpf/progs/verifier_vfs_reject.c |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 27 files changed, 766 insertions(+), 549 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_map_lookup_refine.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c

-- 
2.52.0

