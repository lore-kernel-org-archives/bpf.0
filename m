Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C85348C5C
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812238; cv=none; b=UUCiNFg4w1Rz5LvYk1DNoWAoJu0GVecp5kmsA/h2XXsWYmWldv8aN4ta2nPZV1u4Ilz5mrt9WU2GsgiJMZJw8PLtuGWugAewzFCuUlJ4m9zYO/cuLFtTSkCCau9BzeAk2NQiMwLKA7PzIhXi8sS34xEagKKUOyeyqgCkYU2umrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812238; c=relaxed/simple;
	bh=MtcC8H6gnKP/qVrRV+9wL+F8R12huHHrB42oFo+PegY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIxs+o/Owk03W8Rxj12krkN9iBehygpIsFMsG4sJ/OzqjYRZsnWN1QuGtptydHq/yjpYgGh1Dix105tcDR6wRrEqxZ/gB7qWpm4I+ykiBB7RM1DjNWcuyI2zmnzP78LCVodhyOb3FnfVGAKvhfFIdIAYAZJDwcsGLK5TjIXyo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgS5xP9q; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgS5xP9q"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-826f17cdc9cso1056596a34.1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812235; x=1792417035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=x/JqU+X3FqNaWPnxOdRPjaoxxw8LKlvTpzlOnvrZj20=;
        b=jgS5xP9q2JfpzEZAXF2cAmmZXLwZ40V+Okcvc4P37JTmHmTK/Le/E0BGUvBenNlh4c
         awWdIRvwCM8bBcfS47tz2xZoPSN8uKW7VPXd7Qzz/6rIpA/SPxU6gyx0EyNaiK7imqDI
         SXfPjklQQFNYL/ms3OizxHvT1jRPiPnt2hc8xDlYt75x6fhOa8wlTu8ptcL7ZcqUyp86
         4WrvPTTuHaN0Wg5MePyXGgB1GRohiqzxr921pxDTbqX3R93e4gKUtySFhrn6bTAK/MG6
         0BLu+OLCQ6ESxZWvy8Flpxf/juebb7Xb/2jGoCsDvThho4LFwfMUj1QZgM0cTpxNHixM
         dvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812235; x=1792417035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/JqU+X3FqNaWPnxOdRPjaoxxw8LKlvTpzlOnvrZj20=;
        b=pgWlQJYwzSI4EYb2uqHS8VDFao5erMUVnt9WtXffrzBBXXaT+39tjzXcExcsnS+Ljg
         zPapj9oi+Qs4LOdubJfyEs2zJsA7ct9nt7+uGXvAr3p1PdBHcVXrHPbD5nbMCHPrbmtX
         uuiZwVuh+yjoeA79d5J2Kso3UEoY4Xko5DGvNQMbt0Lvz0U7HRJdwWiu1UIiVO+h4b2X
         FJ5nqekdCP67PTyZ1lUQkwN6LfAQaghbpIKlTl1NOZJWOrHyMf8SjljefEEzL/KcxRnn
         ZIl0XVOeeGPd/kOs0dxS5P7b6JGrEBxUEJ1uDELfgxPk9Y1YMPVRyGvK6p62t2hVzHZZ
         vMEA==
X-Gm-Message-State: AFq9FYJmWEUDs2J7IE91lDWENiL9YV/CR3AzIh4RWRD6kaqcBTthbNJw
	shuMhr1MaxDSXwdb6fDXRR7mWP91lkdYthwodCo+h2guzEYbnvqv3ShbPnzTxRF6h2U=
X-Gm-Gg: AYBFou2n+LTwbOBJx++UbaKlqJgrq57xV07wsnM+ZqfyCO7NVXvwoxrqksVHa9NMZ0m
	VlCH/8VuNmLZDJdaE5U6miZFu/ndXpJnxY1AA239kzYyWHy6/f+qpSxKltdjskJLScV7Hv1c0HN
	zvkeWoHjdjkihGb2zpop++BJ+UNb3PkZ5Xj40GqsZXwA5pTMZJtpNg5eQew7A8/ND17S+X2E20E
	ExoY/2PfvLq/NN2HIGhGl5z0vd49xaA/3mONKKW1OFYXBZzrbP+uiRTuvA7EieB0ytugtehQqM5
	arRFpCimDlKq+Fx+oL3q4/suSxbvYqB6KuhA7X5230ADWLzeoKGT7X9BargXMg7B5K4YU3643dH
	rMyr9uPVuEa37Zr0JyYHgvFl0/WoobzVM+pALtGP2t0qgwt/zinRXPoe0FauyJ8i76qwNG6Nnf5
	qq9SPf6ocbAoLevvgumCGSunFxQWMctvhBfnTAPUpBFyUxqpegYlyiAJHow0oVYRVPo8QAqRy0E
	c6YXRkMN7lZg0gr6BI+q6sLlj5o+FX5+PlN4MEEh99w80oUxdQEBtzMz7HAOA7t8X/veP8Sqdb2
	CwC+DQ==
X-Received: by 2002:a05:6820:a07:b0:6f8:fcce:a410 with SMTP id 006d021491bc7-6f8fccec5e7mr41285eaf.55.1791812235576;
        Mon, 12 Oct 2026 06:37:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6eef6e22b46sm9338859eaf.0.2026.10.12.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:13 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/10] Fix some arena paper cuts
Date: Mon, 12 Oct 2026 15:36:57 +0200
Message-ID: <20261012133711.4030594-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5933; h=from:subject; bh=MtcC8H6gnKP/qVrRV+9wL+F8R12huHHrB42oFo+PegY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMwzX+i295t3ebz9QrvrMoSONFaxjTpHnPbd+2bXu3S7Em ZXVzRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACai48vwV2TydvX4lptqB+VXLtXXl5 3YMfvG5lPpm0QlJ/LHhuTLijD89/d0NOgoKhBw+dqUrOOx7v9Xr4wjR6xlr7QeZ5TRSn3JAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Kernel code that shares arena memory with BPF programs runs into two
paper cuts, both visible in sched_ext's cid-form schedulers today.

A kernel struct cannot publish an arena pointer: a pointer member reaches
the program typed as a kernel pointer, so sched_ext hands out a plain u64
holding a pre-translated arena address and every program casts it before
use. __arena and __nullable become BTF type tags like __user and __rcu.
A load through an __arena member of a kernel struct yields PTR_TO_ARENA:
the member holds the kernel address and the fixup pass appends the
conversion to the arena pointer form that the struct_ops trampoline
applies to __arena arguments, with a NULL test for __nullable members.
A __nullable member on its own keeps PTR_MAYBE_NULL on trusted and RCU
pointers, where NULL would otherwise be assumed away. libbpf renders the
arena tag with its address space, so the member arrives in a program
built against vmlinux.h ready to use, without a cast.

A program only has an arena when one of its insns refers to the arena
map, yet the kernel hands programs arena pointers through struct_ops
arguments, tagged members and kfunc return values, and a struct_ops
callback that touches nothing but its arguments fails verification until
it refers to the arena artificially. libbpf binds the arena of an object
to every program loaded from it, through a continuous fd_array. So that
programs which never touch the arena pay nothing for it, the verifier
records which functions have insns that work with the arena base and the
JITs set it up only for those.

Tested with sched_ext for-next as well: a typed cmask member next to the
existing cmask_arena_addr in struct scx_enable_args passes the
enable_cmask selftest read straight from the member, without a cast and
without the asm volatile arena reference.

See commit logs for details.

Kumar Kartikeya Dwivedi (10):
  compiler_types: Add __arena and __nullable BTF type tag qualifiers
  bpf: Recognize __nullable on pointer members of kernel structs
  bpf: Turn loads of __arena pointer members into arena pointers
  selftests/bpf: Test __nullable pointer members
  selftests/bpf: Test __arena pointer members
  libbpf: Bind the arena of an object to every program in it
  selftests/bpf: Test arena binding by libbpf
  bpf: Set up the arena base only in functions that use it
  libbpf: Render the arena type tag with its address space
  selftests/bpf: Test the address space rendering of the arena type tag

 arch/arm64/net/bpf_jit_comp.c                 |   6 +-
 arch/loongarch/net/bpf_jit.c                  |   6 +-
 arch/powerpc/net/bpf_jit_comp.c               |   6 +-
 arch/riscv/net/bpf_jit_core.c                 |   6 +-
 arch/s390/net/bpf_jit_comp.c                  |   7 +-
 arch/x86/net/bpf_jit_comp.c                   |  14 ++-
 include/linux/bpf.h                           |   2 +
 include/linux/bpf_verifier.h                  |  10 ++
 include/linux/compiler_types.h                |  10 ++
 include/linux/filter.h                        |  11 ++
 kernel/bpf/btf.c                              |  48 +++++++-
 kernel/bpf/fixups.c                           |  51 +++++++-
 kernel/bpf/verifier.c                         |  67 +++++++++++
 tools/lib/bpf/btf_dump.c                      |   3 +
 tools/lib/bpf/features.c                      |  40 +++++++
 tools/lib/bpf/libbpf.c                        |  37 ++++++
 tools/lib/bpf/libbpf_internal.h               |   2 +
 .../selftests/bpf/prog_tests/btf_dump.c       |  16 ++-
 .../bpf/prog_tests/test_struct_ops_arena.c    | 111 ++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_nullable.c |  43 +++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../testing/selftests/bpf/progs/arena_kfunc.c |  10 --
 .../selftests/bpf/progs/arena_noarena.c       |  39 ++++++
 .../bpf/progs/struct_ops_arena_autobind.c     |  64 ++++++++++
 .../bpf/progs/struct_ops_arena_member.c       |  92 +++++++++++++++
 .../struct_ops_arena_member_fail__load_acq.c  |  38 ++++++
 .../struct_ops_arena_member_fail__mismatch.c  |  45 +++++++
 .../struct_ops_arena_member_fail__no_arena.c  |  23 ++++
 .../struct_ops_arena_member_fail__union.c     |  34 ++++++
 .../struct_ops_arena_member_fail__write.c     |  32 +++++
 .../progs/struct_ops_arena_member_render.c    |  82 +++++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c |  45 +++++++
 .../bpf/progs/struct_ops_nullable_fail.c      |  28 +++++
 .../bpf/progs/verifier_arena_scalar.c         |  13 --
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  53 +++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  46 ++++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   2 +
 37 files changed, 1095 insertions(+), 49 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_noarena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__load_acq.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__mismatch.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__no_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__union.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_fail__write.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c


base-commit: 0d5e3fc78a6f2522e6339743b8e5ecc02351a9dd
-- 
2.53.0-Meta

