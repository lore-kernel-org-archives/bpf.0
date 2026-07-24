Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A03D38F922
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920097; cv=none; b=sm5RdtzXLYhKeRBhfFi3bpOu09lfUD8mM9sXPdE8IP5lVld9O8dQCQ/v0eMF2K6OM1zPUOLZRHRBKiu8D8VGExm5PCTZpTFwS0smreRoFr7FFJlwa4q82ka/84E2N3e6GKFIRpYdjAOEjf3lY+jmbHXnqQ5+3lhF2k0LZ8taAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920097; c=relaxed/simple;
	bh=g+Y94M1thQv+NUIzbz8T1mggUO73tSxeKv/4kF2n8nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nacoIsVo4hXTF70tp3PS4aGyxgfAsCQm7pJ3ErjurUJR8LYU/MNzDp0VQidgZqLnVgCg/TOaK+H6teb3GA/0mKeVlLjeQei8VHKh53shrgu2k9o0PtBgSHGGJhtz992OrD3pYqxqClaEsflCstxshRsFOgZqcNTGrOYGDxbCtco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sv5BBYPv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sv5BBYPv"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso9341415ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920095; x=1785524895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=USm3P8sb8PO4YeOcOYFaykTQL0o65vDAqUwjNi53bJo=;
        b=Sv5BBYPvyMSLFd9xENZZ4+w0unKypqX82tZybtawenQZC2yeCHavtyMuUuvQp1xjOH
         3qhXf7rKfkM1pDAeomkh1Lh9zsUSEIIitHOodk6RnLTATSPasKgmslWyDFwYc3bnTH24
         71v1pXYrUXIxoX6PXhU4bnwpLEHFxvJ3V39f3Kbi6OqehxGCd8V+/4eJ6ACN2QTuF5Yk
         JjOA4izR9bbx3j0qReST0CNWNqRkqgWj77m6DwCkL4kiWeyu/94CerL9v1WkRRq3a/j6
         fTJgYJ0yNzbGA508UZyjIZl3vbwMToQnb/AwvkPPg0463wVs1CL/cufl4FKMsF7KD2H0
         5zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920095; x=1785524895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=USm3P8sb8PO4YeOcOYFaykTQL0o65vDAqUwjNi53bJo=;
        b=TBdHwjYe2CeGImphLW0xMXtK4N5Gai98F17Rj0cLoSmhPK5OIOVUA59rE4LoBBV/hE
         hn1hEIZy63nHmNDV8AFmAx5RbNrwxM+pSnQ3fySEXkYHDp6bIDTs7jYA3kI2vDsMcWsN
         NE5ipA+OcmJZ4ze4jsqkTFWMKmaf3HLpyBIp4JUvjVo133Kmaq1rpiPVw1Vk4yjO4ioX
         AYmB+r9jl7vbhTaL5Str88D9TuGyjUrKmbLo1a84vB7tTIP3R6WTQhnbZ6iEtysArYss
         ftNBF8wTW2nGLuQSC86D23Ui/ksKfFgFtfRWTIwRY1Pn3vniEzRfW3saDzR4Gfr9nTjo
         xTTg==
X-Gm-Message-State: AOJu0YwGHNQw+QPvNXLwJ+eW3ZsC/iciv5d5U3S4nyiCoKmQY2/7bVJI
	nuPO9iIZS7HhE5oO2220Y0we0mJuuG3AWb344T7YigWvpc/PjdAcVc/MIskHNQ==
X-Gm-Gg: AR+sD13cRCfDYOkpuFNOHeAL89wumAn29l5lTnqqAxXpHmhCYxWtfBH+gAlnYnHAxwq
	gpjjCwQIG/hlcqstAZIDaN7xYtpJfgZHRPtXOzSGP5eLVXs/zNpWFQU/jfIa9pBgHzoyrAW05UI
	S7cCOHRJWU4ARxqNND3ZPKmyaOdiuMlu2kwLKfectpMFJ8imq6rNGUu9Wj8mU4tF5cv2KL4cj4G
	pwMnjyh9wiwt4+BtwLE0MEewQJwJXQA9f8Ti7AGdo0hBiS0cJ2TIxlWYX0FD14pXHww0DUeiAxv
	FsdjtLvdqd7hm00Fn4amghsX4XUsLY3t7l7UYQwdPHhK7snqcMD9+VXG34OV2Wu8yEQEQDD/S9u
	ClvPFxTWEB439x3l6dx2tpBbhWSz/jDd8uFIn4fpP4vszNOkSeILBjKPmot4e5yMEiumNg3BqpY
	Lhkw==
X-Received: by 2002:a17:902:f60c:b0:2ce:6d4a:5b8a with SMTP id d9443c01a7336-2cfa71ab5b8mr94812175ad.38.1784920094428;
        Fri, 24 Jul 2026 12:08:14 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:3::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e7a83sm57961125ad.42.2026.07.24.12.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:13 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 00/18] Generate bpf_func_proto for kfunc
Date: Fri, 24 Jul 2026 12:07:54 -0700
Message-ID: <20260724190813.1458271-1-ameryhung@gmail.com>
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

v1 -> v2:
 - patch 2: use reg_arg_name() for the map-mismatch message; derive the
   object register correctly on both helper and kfunc paths
 - patch 3: reject non-CONST_PTR_TO_MAP regs (base_type check) to fix
   map-value type confusion
 - patch 15: also reject referenced regs with unsafe modifiers (e.g.
   MEM_PERCPU)
 - patch 17: reject non-SCALAR_VALUE for KF_ARG_MEM_SIZE 


Amery Hung (18):
  bpf: Drop process_timer_func wrappers
  bpf: Unify const map ptr argument checking for helpers and kfuncs
  bpf: Split kfunc map argument into __const_map and __map
  bpf: Pass kfunc meta to mem and mem_size check
  bpf: Check helper and kfunc mem+size arguments identically
  selftests/bpf: Add tests for helper and kfunc mem+size arguments
  bpf: Check fixed-size mem args of helpers and kfuncs the same way
  bpf: Express ARG_CONST_SIZE_OR_ZERO as ARG_CONST_SIZE |
    SCALAR_MAYBE_ZERO
  bpf: Rename ARG_CONST_SIZE{,_OR_ZERO} to ARG_MEM_SIZE{,_OR_ZERO}
  bpf: Fold __szk const size handling into the scalar arg path
  bpf: Classify kfunc mem_size args from BTF without register state
  bpf: Handle NULL kfunc pointer args without a KF_ARG_PTR_TO_NULL type
  bpf: Distinguish fixed- and variable-size kfunc mem args with
    MEM_FIXED_SIZE
  bpf: Check helper mem+size in ARG_PTR_TO_MEM case
  bpf: Classify kfunc pointer arguments from BTF, resolve type against
    the register
  bpf: Tag nullable kfunc pointer args with PTR_MAYBE_NULL
  bpf: Classify scalar kfunc arguments from BTF
  bpf: Generate kfunc argument prototype at add-call time

 Documentation/bpf/kfuncs.rst                  |  30 +-
 include/linux/bpf.h                           |  42 +-
 include/linux/bpf_verifier.h                  |  31 +-
 kernel/bpf/backtrack.c                        |   2 +-
 kernel/bpf/bpf_lsm.c                          |   4 +-
 kernel/bpf/btf.c                              |   2 +-
 kernel/bpf/cgroup.c                           |   8 +-
 kernel/bpf/core.c                             |   4 +-
 kernel/bpf/helpers.c                          |  42 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/stackmap.c                         |  10 +-
 kernel/bpf/syscall.c                          |   6 +-
 kernel/bpf/verifier.c                         | 786 ++++++++++--------
 kernel/trace/bpf_trace.c                      |  62 +-
 net/core/filter.c                             | 116 +--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../bpf/progs/mem_rdonly_untrusted.c          |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |   2 +-
 .../progs/verifier_helper_access_var_len.c    |   6 +-
 .../bpf/progs/verifier_helper_value_access.c  |   2 +-
 .../bpf/progs/verifier_mem_size_reg.c         |  60 ++
 .../selftests/bpf/progs/verifier_vfs_reject.c |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 25 files changed, 711 insertions(+), 526 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c

-- 
2.52.0

