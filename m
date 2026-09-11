Received: from mail-oo2-f13.google.com (mail-oo2-f13.google.com [74.125.231.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAB353A6B
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164260; cv=none; b=IMaeJ/a+E8JaJ6lqVf6xi7T/JYRS+Jn+sr4hyx5puju5ZA+LmO78qlKwKlyZ+blVoTui40WDbaqkrt+rZWa2cEzSdXW7W1EyBqj74ktYmdeEv65PQtUgTvSM3fIGKkgpHsVxx/vdSOfJc48cKZ1vY910ezR3N4xYbccP1P0hPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164260; c=relaxed/simple;
	bh=lMDYe7mgqALozpCB2Gn6Nam6Uc9ZIARC0KA6Ni7MmGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dj48c+wQxbjkd9BkHfIOtRr16n1uCsAlbaNt1Tc7EA5Vz+oEvDfZaPspe65MQoJTzC7H8e6PuF/OgDmYvecDgwc535MDOL3dI4Pfmtmd5gPhrIymkJVPQLlBSXLHxX4CYRFp/mvv3pqGdubMPQUEYCpymF0b6X02nkiwWaWxoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzWHTTQK; arc=none smtp.client-ip=74.125.231.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzWHTTQK"
Received: by mail-oo2-f13.google.com with SMTP id 006d021491bc7-6b1ae7089c0so49349eaf.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164257; x=1789769057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zDLK2X5DK/KFAyyXLcFE8gw22FvSyzoSaGBGuQcBfQU=;
        b=fzWHTTQKxiy7MsDtlOBt+uWE5Sv9f92J/TyatpoOmxxIVF4Dhx0yVQD4XeZD2jM/1c
         wLcLF330A359tuEp1oyz0bSC4BbxizFzSXGMbhircQLK5hTOhFk57IdyNtj0uEtFz0sx
         gl/qgBSPCeyavqNwhs6/QHKbvkGf4i4QIZ03iTXsPqORbd1YyFk6pn8Ox47fkSFpWPIs
         Vj8F4OF5YqTzsb1GjzJYzlm3TD0vFc7b1acl/WqGkUAq39zdZ08PMd43H+uLfc14P7Ax
         4+3p41NjiCNX8Z4seMic9JVWh+0Fil+0eHcNREKVselKDiq3+zYswegwoRTTxdUOaaSw
         mZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164257; x=1789769057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zDLK2X5DK/KFAyyXLcFE8gw22FvSyzoSaGBGuQcBfQU=;
        b=AgQIDUEeIqBxsq92gDBMiZtrUNYnPPJmiVxGJqsYNnfAOvDT6+TMn6bkMoDN9oPOpP
         lX1DM+dh5SwOUv+RRcwmev6S35vbhf2PrhWl2EPpSNPF3Sk/jOHY9zAlhIsbaT3ScSyy
         2nVlmF644gtGfHHd5kH30sHBddcLxuZ76SNd0v4CwKhS4Nj6LFrMT/6nil3dr6aQfPCt
         AKlB7N4jA8C94gELZyiqtt6uq7ujqeZugmwcCSBpCGaN2QuTOpi1W4o5fCL7CM373icg
         Ui8I5FvNqMV50hM231lrIBbPtImqd4Sd7WzdLRK6i4+zMBeKaER5NYH6min23CBtOVbg
         KstQ==
X-Gm-Message-State: AFuF++kMJ67xANfyYs3ylwueggwD2KM+KTdLlfTnxOMKSAGqF97cb53+
	ITCJrEWVPseIy2ffiukQknUnlJinkBoLOgpGrd0NKXzwPWfDfmVqNMGf4F5gbA==
X-Gm-Gg: AYBFou3PGOcWR1aVbBfyVQuNdbfBV8NKqm6se7txeJZ2EUP/K3DzMRaQWt0JxazW8C7
	ahGsInpd0M9kqT/TqE6Zul+o3Q3tZaaxi3tDFPVVJut6d9H9p7p2wnIuVuV+OXOoYoP/zGoj4zO
	WODMVEUgNzHxnuFg5lJ6k4URn/KokkoP6gIPEzqlSYbd2S/scRVbG5IMv0FS3z74ekfqiENqdOh
	oqzWUa8kFTPwI/+hgVDCPOetetVT3C1ZGl6ATmyJPqCNH4Zoz5i6SmtedDiooTxvKw4xwxp0KEF
	RTJd7lgkL4hHSIBh9PE5MwZsbLnMZIKDfEdGtURjOGpl6dAxMT22Kjy5lYgXtkS6EcM7SwfSI93
	lQ7Y52uAebbe+0S5f7eN5qep7k5l4zQId9lmEI+niW2N+bse7zxbjP4x1cNaTfviLGJHSfxwg0Y
	u52AhAhAjB8CCpClIlMhWWpwbrqxP7dXnBA+SJeuDqCQhpR+LM9mXpsiWQav8v8g==
X-Received: by 2002:a05:6820:60e:b0:6ae:ab01:9199 with SMTP id 006d021491bc7-6c24ec5b1camr280973eaf.34.1789164257240;
        Fri, 11 Sep 2026 15:04:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90f5b1asm3168606fac.11.2026.09.11.15.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:04:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/23] Unify helper and kfunc argument checks
Date: Fri, 11 Sep 2026 15:03:52 -0700
Message-ID: <20260911220415.1396439-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is the third and final patchset unifying helper and kfunc checks.

Helper and kfunc calls currently validate arguments through separate
loops despite enforcing many of the same contracts. This duplicates
type admission, nullability, memory, BTF, packet-access, and resource
ownership handling.

This series completes the generation of helper-style argument metadata
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

- Patches 19-22 consolidate packet-access and release validation, with
  coverage for kfunc packet writes and nullable per-CPU kptr identity.

- Patch 23 replaces the duplicate helper and kfunc loops with the
  common check_func_args() path.

[1/3] https://lore.kernel.org/bpf/20260715064047.1793790-1-ameryhung@gmail.com/
[2/3] https://lore.kernel.org/bpf/20260801074633.1595644-1-ameryhung@gmail.com/


Changelog:

v1 -> v2
  - Rebased onto the latest bpf-next
  - Reordered and folded patches for bisectability
  - Fixed kfunc memory admission and nullable per-CPU kptr identity
  - Tweaked style to reduce indent (Alexei)
  - Fixed minor wording error in comments and commit msgs (AI)
  Link: https://lore.kernel.org/bpf/20260905220117.922028-1-ameryhung@gmail.com/

Amery Hung (23):
  bpf: Pass call metadata through shared argument checks
  bpf: Address check_func_arg() arguments by argno
  bpf: Only compare func_id against BPF_FUNC_* for helper calls
  bpf: Only compare func_id against kfunc BTF IDs for kfunc calls
  bpf: Clarify unused and scalar function argument types
  bpf: Unify kfunc argument kinds with enum bpf_arg_type
  bpf: Classify kfunc arguments the verifier ignores
  bpf: Align helper and kfunc ARG_PTR_TO_PROG_AUX handling
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
  bpf: Consolidate function call pkt_access validation
  selftests/bpf: Test kfunc packet memory direct writes
  bpf: Consolidate release argument validation
  selftests/bpf: Test nullable per-CPU kptr identity after exchange
  bpf: Check helper and kfunc arguments in one path

 include/linux/bpf.h                           |   30 +-
 include/linux/bpf_verifier.h                  |    3 +-
 kernel/bpf/btf.c                              |    2 +-
 kernel/bpf/diagnostics.c                      |   29 +
 kernel/bpf/diagnostics.h                      |    1 +
 kernel/bpf/fixups.c                           |    5 +-
 kernel/bpf/helpers.c                          |    1 +
 kernel/bpf/verifier.c                         | 2056 ++++++++---------
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
 .../selftests/bpf/progs/percpu_alloc_fail.c   |   35 +
 .../testing/selftests/bpf/progs/rbtree_fail.c |    4 +-
 .../bpf/progs/refcounted_kptr_fail.c          |    9 +-
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
 tools/testing/selftests/bpf/verifier/calls.c  |   10 +-
 .../testing/selftests/bpf/verifier/map_kptr.c |    4 +-
 43 files changed, 1182 insertions(+), 1185 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c

-- 
2.52.0
