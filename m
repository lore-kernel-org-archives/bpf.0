Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288A26AF4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645681; cv=none; b=uLlOc1ThJDZcRxOd3bhyvZapDakBKwQR2vfqpcRmqTe4Yk9YMVCgmVULiC7cwt9yWp7v+zdVwS74VgoznwLIYvKesodHYEG3RknJ5s50pX0NDwpe46Me0Z7bX98LweJMs4fXr3DSzFbC3mMAU0TXLmS2CNiYyIpqOt7QlLdshjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645681; c=relaxed/simple;
	bh=WXG3+BrOI+N5CV7R28WwGCMtQME+ab6SdjkeDvvNqLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BEr46CAkl6QtEhQMSeBm/B0pDlE6qjNiPYqI4/puQ/8Pw1khOLrU+8Gn5bWl1INgwgj/X0mpsyfPbUlYpGRzQaudep/dPGfBFbPhMel3UzlVuby0uW8Uv5dnwqzmj67NWMCJVd8PGtqalDaysqmR5ofvRATXkD5a94ZHL+lFgIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OD+DkSJY; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD+DkSJY"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4b396d2fb9bso1024471b6e.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645679; x=1789250479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJbizGfGLCavtWGkaZNvY/H16OzV5KXuGJTj/0KvI8I=;
        b=OD+DkSJYLNUIS6aIySwcZ+gCjike/1eyzoHqG3VcxoVSvIgl5l1nKmXFU2rYsnh0fj
         HOWxuR2RvlZaj7y36XCVwoQGVDZPun95RGuRGxulMPotIGDCkWkr9AN87Zs/nTaBPRHg
         7tbJVlIVaoVM8nuZQ4VYA49BnSaq6R1MPi8Z8t+X14TCHnGcmBUkqGvvPqPfAEDDE3Ra
         Y3mvpkLthCUZ3BYZ/KR09Cwg1N2mR3OouhcFqU7EAY8Vu9wxbyf2ifEsG3MgHfei+LMZ
         HGPGR9SIvwAyNbHInTmveK1vQZDJImtIGaCfg+roAD97ozSColtPis/kJ0EU8UR7pC16
         OZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645679; x=1789250479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJbizGfGLCavtWGkaZNvY/H16OzV5KXuGJTj/0KvI8I=;
        b=CP1yZg43kLuXpg5i815RkOMtdL/SV1VGft/awH/ol8MuswdTQodkIp3BWJXmbfa48A
         DmnLVYtOfZhYmXmi7UkqFZvYNxAtsauT+kmjIZwtyK4v/pZoyf/mX4qc4mgV22kT6ZMa
         3cwgDdChVcHTFWjze5riuWQkfPc2iT1LoknHOlf7apTwMCuCOUlhn457JhOLWMAWpHyY
         QZpN+On+GQ2KLa3mm1liM+RewO502zIvtA9hv9DFybBfVpmJxjY7pd2X1PLDXE4tsO2v
         T+TJEAQLBI/5xW1RCgxAaXM2FVNI+jTvJc0JKQ97v4YLCatyLkmr6exJQiQF4B45c4Ov
         sqag==
X-Gm-Message-State: AFuF++nIQfa/mUb3Z9L8ZqbIQxZH2s3k82pNMnCx9+f1OyeQC4isFqiz
	eBDbjRzScI7WO5q9vc/QoMaAPOeEwHbTPwFF8QuuV79vyVXPQhPE+ROvi4iGug==
X-Gm-Gg: AYBFou0fJfbvzrn9ahZhEDQwxlMLiAUvvBJesDa5tPRWuDTisrfFRThmIT4ojcwgC/3
	veWObZ5wDPfnAfrlrfGzpYnpEcwX9W0jjT79qYjGpWiBXcJrVng9u9OrDP5Ri/nTCtVfqDeoZV9
	gM3A/mRvNMy6CVbv2JZiogDPdi1SXNhEBTbU8JmBDJ1LroRN7Fz+X53jhHKaZEkqqJ7cpQe9/rH
	cIK67vrPP4TKuZKqz7vE0Jv8qx9vB+IWkZYUt9GdYhBcxFFohn9dIdm7QBlshnG/UGoldvyziuy
	oFkaT5dIYwUQ5Vhl/I+Gn3JZIOE6oBVDy+XI1WVmrqawkv6m28g56l22F2FhGGqCGV7pnvIWSoq
	aKYODaV4qP75dbkQajhbR45nuCPC14ySRWmncxh75dhb6i7FgUv9u8/lOwKZ+U74fNWlJgG/E2T
	Pqdm4KZDNETePmJU36V7Lp160icbPDuMR6SrJX9V9RuEsU4jI7AT7/xAe9erAz
X-Received: by 2002:a05:6808:d50:b0:4b3:880a:f08a with SMTP id 5614622812f47-4b967518c03mr9045467b6e.15.1788645678903;
        Sat, 05 Sep 2026 15:01:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b971aa12cesm6610526b6e.16.2026.09.05.15.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:18 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/22] bpf: Unify helper and kfunc argument checks
Date: Sat,  5 Sep 2026 15:00:55 -0700
Message-ID: <20260905220117.922028-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the 3rd and final patchset unifying helepr and kfunc checks.

Helper and kfunc calls currently validate arguments through separate
loops despite enforcing many of the same contracts. This duplicates
type admission, nullability, memory, BTF, packet-access, and resource
ownership handling.

This series complete the generation of helper-style argument metadata
for kfuncs and then routes both call kinds through check_func_args().
Call-specific behavior remains selected through call metadata where the
helper and kfunc contracts intentionally differ.

The series is organized as follows:

- Patches 1-8 prepare shared call metadata, argument indexing, and
  argument kinds.

- Patches 9-13 populate kfunc argument flags, BTF IDs, and fixed sizes
  while generating the kfunc prototype.

- Patches 14-18 consolidate runtime type resolution, nullability, BTF
  matching, and register admission.

- Patches 19-21 consolidate packet-access and release validation, with
  coverage for kfunc packet writes.

- Patch 22 replaces the duplicate helper and kfunc loops with the
  common check_func_args() path.

[1/3] https://lore.kernel.org/bpf/20260715064047.1793790-1-ameryhung@gmail.com/
[2/3] https://lore.kernel.org/bpf/20260801074633.1595644-1-ameryhung@gmail.com/


Amery Hung (22):
  bpf: Pass call metadata through shared argument checks
  bpf: Address check_func_arg() arguments by argno
  bpf: Only compare func_id against BPF_FUNC_* for helper calls
  bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
  bpf: Rename ambiguous function argument types
  bpf: Unify kfunc argument kinds with enum bpf_arg_type
  bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
  bpf: Classify kfunc arguments the verifier ignores
  bpf: Set OBJ_RELEASE when generating kfunc argument types
  bpf: Set MEM_UNINIT and dynptr subtypes when generating kfunc arg
    types
  bpf: Set MEM_RCU when generating kfunc argument types
  bpf: Resolve BTF ID of ARG_PTR_TO_BTF_ID in kfunc bpf_func_proto
  bpf: Resolve ARG_PTR_TO_MEM | MEM_FIXED_SIZE size in kfunc
    bpf_func_proto
  bpf: Consolidate runtime argument type resolution
  bpf: Consolidate nullable argument validation
  bpf: Drop redundant BTF pointer helper write rejection
  bpf: Consolidate helper and kfunc PTR_TO_BTF_ID argument matching
  bpf: Admit kfunc argument registers through check_reg_type()
  selftests/bpf: Test kfunc packet memory direct writes
  bpf: Consolidate function call pkt_access validation
  bpf: Consolidate release argument validation
  bpf: Check helper and kfunc arguments in one path

 drivers/media/rc/bpf-lirc.c                   |   10 +-
 include/linux/bpf.h                           |   32 +-
 include/linux/bpf_verifier.h                  |    1 -
 kernel/bpf/backtrack.c                        |    2 +-
 kernel/bpf/bpf_cgrp_storage.c                 |    2 +-
 kernel/bpf/bpf_inode_storage.c                |    2 +-
 kernel/bpf/bpf_iter.c                         |    6 +-
 kernel/bpf/bpf_lsm.c                          |    2 +-
 kernel/bpf/bpf_task_storage.c                 |    2 +-
 kernel/bpf/btf.c                              |    6 +-
 kernel/bpf/cgroup.c                           |    6 +-
 kernel/bpf/core.c                             |    2 +-
 kernel/bpf/diagnostics.c                      |   29 +
 kernel/bpf/diagnostics.h                      |    1 +
 kernel/bpf/fixups.c                           |    5 +-
 kernel/bpf/helpers.c                          |   47 +-
 kernel/bpf/ringbuf.c                          |   20 +-
 kernel/bpf/stackmap.c                         |   14 +-
 kernel/bpf/syscall.c                          |    6 +-
 kernel/bpf/task_iter.c                        |    4 +-
 kernel/bpf/verifier.c                         | 2032 ++++++++---------
 kernel/trace/bpf_trace.c                      |   46 +-
 net/core/bpf_sk_storage.c                     |    6 +-
 net/core/filter.c                             |  302 +--
 net/core/sock_map.c                           |   16 +-
 net/ipv4/bpf_tcp_ca.c                         |    2 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   14 +-
 .../selftests/bpf/prog_tests/cb_refs.c        |    4 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |    2 +-
 .../selftests/bpf/prog_tests/verifier.c       |    2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c |    2 +-
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |    8 +-
 .../selftests/bpf/progs/cpumask_failure.c     |    4 +-
 tools/testing/selftests/bpf/progs/irq.c       |    4 +-
 tools/testing/selftests/bpf/progs/iters.c     |    6 +-
 .../selftests/bpf/progs/iters_testmod.c       |    7 +-
 .../selftests/bpf/progs/map_kptr_fail.c       |   10 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |    3 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |    4 +-
 .../bpf/progs/refcounted_kptr_fail.c          |    4 +-
 .../selftests/bpf/progs/res_spin_lock_fail.c  |    2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |    2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   10 +-
 .../selftests/bpf/progs/task_work_fail.c      |    2 +-
 .../bpf/progs/test_kfunc_dynptr_param.c       |    2 +-
 .../selftests/bpf/progs/verifier_ctx.c        |    2 +-
 .../bpf/progs/verifier_global_ptr_args.c      |    2 +-
 .../progs/verifier_helper_access_var_len.c    |    4 +-
 .../bpf/progs/verifier_helper_packet_access.c |    4 +-
 .../bpf/progs/verifier_kfunc_packet_access.c  |   47 +
 .../selftests/bpf/progs/verifier_live_stack.c |    2 +-
 .../selftests/bpf/progs/verifier_map_in_map.c |    3 +-
 .../bpf/progs/verifier_map_lookup_refine.c    |    2 +-
 .../bpf/progs/verifier_ref_tracking.c         |    6 +-
 .../selftests/bpf/progs/verifier_sock.c       |   10 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |    6 +-
 .../selftests/bpf/progs/wakeup_source_fail.c  |    2 +-
 .../testing/selftests/bpf/progs/wq_failures.c |    4 +-
 tools/testing/selftests/bpf/verifier/calls.c  |    4 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |    4 +-
 60 files changed, 1380 insertions(+), 1417 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c

-- 
2.52.0

