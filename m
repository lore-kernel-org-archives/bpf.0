Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51871286891
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522520; cv=none; b=BzfQW6voMZV31FYVHnS1hgWxLGZA7vnW/P9IPqv3BiZD24rWZw70HxyO420rcTkR7RVdt4q6Pm1fvTaYuepP5hfeupqVXylln/3+l6u5d2mHiPPWw2IuPyjo33mhrkO2CjtgcIlMzPPQEfkyLHj++bj/m9ofXc/25UX/CUxq0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522520; c=relaxed/simple;
	bh=IMcIwATO0c/YbswiSKsnof/fHz6ABngivURgiBT4T2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uY8QJPD/hMzGjTkCHL3zishSiyKCBhvOqZRztlsMSUenecyIXT3Cdn+poa3B/iTO9L8r4L/ZfmyRViGKHEmprIvFQwfLxP+0y6+dgE89RNuCLKtYTQ/uBDmN4rVd3XWXVgXAD8xKtJyxgGYsn04pIjjYJZNorJAEK3BZSii5/zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFVeF1Rr; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFVeF1Rr"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso1163168eec.0
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771522518; x=1772127318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCzrqIXVU6cpafAWoNSJaXXt7IQz2vtG7LMDMkXPm9A=;
        b=nFVeF1Rr4tG5C38rmYvyGKD7tw9rm43RpBGKWgtanxukl2U12+NmRdWcIXdQakzdRG
         525KOGjZQ/k2m7Hvj7AK/INQ2ci+iBU10x3htefKQRSRJ3D3R6KahIDylbUFmHzK9g34
         1P7XhnaZtUvElCUEKpJ+tGfVA4t87Qcyrs/nBnObGlBXug02+kE8F0o4eoSVQDjz9V5m
         Of9zdU1OG9sUn9BCI/vTHfDIiBP7BC1sevVDmr2XGkr49H8YgId5r45vi2VrVIodcT6j
         QLLIvHPYHB6/p4rkJqgaDM5ppymptbkBiLOZ0j8doZorXdBwMoOdVRdCnN3NbriQfTtH
         4EXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522518; x=1772127318;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCzrqIXVU6cpafAWoNSJaXXt7IQz2vtG7LMDMkXPm9A=;
        b=Wn6xMGc2QIvCw3Lj6EHRZd9o1fqXu8LSrATxUnIaktBqORMPBU1/Dl8hehlEsFJDCp
         sNTeWsRv4LJUey6HZ7xTj8gLEx1qkbGM65ndYCCnccK4fI4VuvrEintEuZuFGeOB9web
         ZUiRUDIaupWYYLCH9Do4f42b1UDCAKjKKo17abOkCzGdL5/Ej+91kLLDrWmWMXU/qOaa
         LUkGf51fyGpFU9mfsbOV8ANfDFZBD2vLMeHIcFI7c5Q0Ycj+xgBHyqQVsJNsKZdyHbzz
         kzTdawo/hglrVS1pUFxp1vXFHpawBVV8pTBU131TVnSRJ4/5quLuTctdDG/k3NsgKij9
         bJRA==
X-Gm-Message-State: AOJu0YxAqDqTc9FMbpCbShJ1ve0cSbngpjQLlZzxthp3Ew/0bYAZf7C4
	4MLfONESrjXk5LWWGpGKIfDrzuLS6GjIfbEZtv87EkWCgYIMlOTSh1F0
X-Gm-Gg: AZuq6aJGvNaV2EHKTf7k7TM/vS+LGvVUCJEhBUBtekww0HCy2jJqPP5EdKSjdGZs6b4
	vCSFYd9rJkBOqqAuHNWYL3Pzv23a3ZGcHysPenc9lAG52vn3lMvmS8gR7Rkp21rdCkuINv4LUb2
	buAMW6nFRor7+2wTH7+H7Q/bo0ZqJKn7g7H9Bi3Y3kbh/6sFPV5YrpR7EVEEcOfdWlX4StmHrbs
	RlfW196Rbrh8F3nBb5PFRhIZ/h0E6ypHiAACr9P9xUURJSjsE98WKvQaqUTowrB4ltichodP+Qb
	OUv6Z4c7C0EK3Mx7PQcEG/QjmlBvg0DOXYMOnWYb5jAkj3oSo2z0hGHSmH+Sz8aVBGEEBAVNV6b
	MgpyUmbX28+xi4xwH5C4nA+94vDcjSguzIHSl/Zh07JGZ2blvFoLaCZ4hrTwJuKzlqPzLu7lgM0
	88g5R19z9iODfqdsMJdIGrfr9JBBlpANUE0mMpRhmFcWel4I1BgrMBEaHV+/S2jkdk+pV8h90FU
	u3tGdpXcjc4SBi9n4nOplR/rMWRQOMm/Mi4irqABQs5Ug==
X-Received: by 2002:a05:7300:d517:b0:2b8:64ad:ad4c with SMTP id 5a478bee46e88-2bac97cab51mr7772891eec.31.1771522518197;
        Thu, 19 Feb 2026 09:35:18 -0800 (PST)
Received: from ast-mac.corp.tfbnw.net ([2620:10d:c090:500::2:fd2c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658fc4sm25038363eec.22.2026.02.19.09.35.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Feb 2026 09:35:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 7.0-rc1
Date: Thu, 19 Feb 2026 09:35:15 -0800
Message-ID: <20260219173515.51586-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 44331bd6a6107a33f8082521b227ffa4ec063a40:

  Merge tag 'mm-hotfixes-stable-2026-02-13-07-14' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2026-02-13 12:13:27 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 1e5c009126952f673ffa2427acbd69e57493f0d2:

  selftests/bpf: Remove hexdump dependency (2026-02-18 15:11:20 -0800)

----------------------------------------------------------------
- Fix invalid write loop logic in libbpf's bpf_linker__add_buf() (Amery Hung)

- Fix a potential use-after-free of BTF object (Anton Protopopov)

- Add feature detection to libbpf and avoid moving arena global
  variables on older kernels (Emil Tsalapatis)

- Remove extern declaration of bpf_stream_vprintk() from libbpf headers
  (Ihor Solodrai)

- Fix truncated netlink dumps in bpftool (Jakub Kicinski)

- Fix map_kptr grace period wait in bpf selftests (Kumar Kartikeya Dwivedi)

- Remove hexdump dependency while building bpf selftests (Matthieu Baerts)

- Complete fsession support in BPF trampolines on riscv (Menglong Dong)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (2):
      Merge branch 'bpf-fsession-support-for-riscv'
      Merge branch 'libbpf-remove-extern-declaration-of-bpf_stream_vprintk'

Amery Hung (1):
      libbpf: Fix invalid write loop logic in bpf_linker__add_buf()

Andrii Nakryiko (1):
      Merge branch 'libbpf-fix-perm-errors-for-ldimm_64_full_range_off'

Anton Protopopov (2):
      bpf: Fix a potential use-after-free of BTF object
      bpf: Add a map/btf from a fd array more consistently

Emil Tsalapatis (3):
      libbpf: Add gating for arena globals relocation feature
      libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
      libbpf: Delay feature gate check until object prepare time

Ihor Solodrai (3):
      selftests/bpf: Adjust selftest due to function rename
      selftests/bpf: Use vmlinux.h in test_xdp_meta
      libbpf: Remove extern declaration of bpf_stream_vprintk()

Jakub Kicinski (1):
      bpftool: Fix truncated netlink dumps

Kumar Kartikeya Dwivedi (1):
      selftests/bpf: Fix map_kptr grace period wait

Matthieu Baerts (NGI0) (1):
      selftests/bpf: Remove hexdump dependency

Menglong Dong (3):
      bpf, riscv: introduce emit_store_stack_imm64() for trampoline
      bpf, riscv: add fsession support for trampolines
      selftests/bpf: enable fsession_test on riscv64

 arch/riscv/net/bpf_jit_comp64.c                    | 97 +++++++++++++++++-----
 kernel/bpf/verifier.c                              | 48 ++++++-----
 tools/bpf/bpftool/net.c                            |  5 +-
 tools/lib/bpf/bpf_helpers.h                        |  3 -
 tools/lib/bpf/features.c                           | 65 +++++++++++++++
 tools/lib/bpf/libbpf.c                             | 17 +++-
 tools/lib/bpf/libbpf_internal.h                    |  2 +
 tools/lib/bpf/linker.c                             |  2 +-
 tools/lib/bpf/netlink.c                            |  4 +-
 tools/testing/selftests/bpf/Makefile               |  2 +-
 tools/testing/selftests/bpf/prog_tests/map_kptr.c  | 15 ++--
 .../selftests/bpf/progs/get_func_args_test.c       |  2 +-
 .../testing/selftests/bpf/progs/get_func_ip_test.c |  2 +-
 tools/testing/selftests/bpf/progs/profiler.h       |  2 +-
 tools/testing/selftests/bpf/progs/profiler.inc.h   |  6 +-
 .../selftests/bpf/progs/rcu_tasks_trace_gp.c       | 30 +------
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 12 +--
 .../testing/selftests/bpf/test_kmods/bpf_testmod.c | 28 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |  1 +
 19 files changed, 242 insertions(+), 101 deletions(-)
