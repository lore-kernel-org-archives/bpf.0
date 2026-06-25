Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D045360745
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782418778; cv=none; b=p955Q3ITzFvRME4Ruxcv+eysg+8siNQ5Q646qSGgaZzN/LNDfwm73VYqLK4IpcJmh8h6kCN53ZLM2TUrjvYwASIhdEMavIqc9T7NT15cFg5izjy49NzFm7M27INFaYCp/iLLcBymSWnIBvcV9Oo+4h+UlGD9wa4ep0YeXx6hhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782418778; c=relaxed/simple;
	bh=CdkZiu95Ju3zRZKCZInYDz0DhZoKpH+gzbfejaMqk2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXXHH8vmJS0zIAnuiGPJqaSO2paX+T296qlnnXMzGhGaPwSe4PK7xNq7rlEBgtGeiG0imO53PsiBN9O5nGhO2v5VoCZopq1+h29aNF7Me43Ef77n2Yh3e1aC64DWMAZN9dqw5QZAR13jHzi1UF2DBLqW2z8CljyXdfvDFK5DPfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OElTnFzL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OElTnFzL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c89fa656ea1so83681a12.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782418776; x=1783023576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTizzMYsvK+QXxwaUCsIvsB96HTa7qAoU7wdsBC1yiA=;
        b=OElTnFzLMjVqX9mArbtkpzO7U5bp0pltrttCFpvMN7UaBE+nzu0OZCRuwo513me7ef
         urndJsQSpytIR45y3LH5HPBIsRZMq8DIFj/5T68UM7QDA0UPR0+brTfgYEbh2Y/k7mXC
         vr9Yun4a2XgY1EVjKBX6xQCoChWrkRB4lliQEgbxvIKAUs5Ijqfjkwb5bAo+9fJ1VR0s
         fJlN1HyEd1DdGEn52e5qi/3yKSxb/9oHgj/dFEBL8Da92it2d71B2H6QOHCl3CgPweP1
         qLzbjVNlT3sMMR7OFEKcq7H8NUrl/RHYM/W2BnLcJoX2/eGvn5HyU6APMNtn8+tcCHtA
         UeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782418776; x=1783023576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTizzMYsvK+QXxwaUCsIvsB96HTa7qAoU7wdsBC1yiA=;
        b=H8pNJlaWxPdThdxWSgK532+B4wKXHQ6aOKcklaD1pK3cUkxYfop6bLYZnT6dqO2DBj
         Kacsqpx85jt/PGymy/DTRwmgIxSfhsgu/bgHX0VMJt7575N/JqOSYQAjg//j09hnbBBK
         YSfV0gcK8ITgyv1gb+GMWdOJffFQG9+YpL1mT9geyQc2MoH6vGsnFP/6Z5AT9uEWj1mO
         nDQDCUKqRMof4DEiprbmDwTPXCHE5zVpMgpBp55rW7wHmlja9lD682soPrmMs5y436Kx
         zABFy3YkrlQJWqpmhAaoZD4DqVtSgE7aQ8yK4lMFLl6aUvL8Xx4ZPUGxXfoZHCCNnorx
         dFiA==
X-Gm-Message-State: AOJu0YwgjRz7CjE1ObAWFw0fZZ1RvSipeK+FQQmuDqyOiSt+j4es5O3g
	cI47OaCHp+ZjwKxa466U5xWV/5MDqqqHVNk+p3HhCAPOKzq+djIIESEN
X-Gm-Gg: AfdE7cmqw/QFFO4Fnd5vVZbQLfEq0v9thXL3rxMOkaOP9iHlzPt2Lq5PQA7rPhYEskx
	gfKhI6E/A2dckJ4uvBN9GWSu3nxgrXohGHE6EgVyx7jctikJ5T5Ckpdvy41J5shPsMoJxanpxmN
	hyps9BP1SDDL6vx/rIdorfK5Xs2M0XYgQYE1z3XIsdq4tMRvpNRd9SzOuMDPjkDCkivkN3oSUv8
	SRnBouu3dFjNrAjkYG0eQxcJ00+gfsLJlzrORtXRNTfIrc9Zs8UGkhY3eff+tKxrgyAcvhX3ef7
	PqT7DVYUhY2soPOvZsY0kJ98NSmKTI4BHTw5+wQQltSQ3lyXO/OBXbG8OTekbSglnF7d935WrAe
	mFuZ3HoGS8Aih9LZJmiUCoksiPP8en+ZJ3EY3yshA+/PQXYaUOMuq0OxsQ1RXHKW0EaJ/a1MGBS
	iC8HuM3zKu/drCFTfFd4lI7eXgZWvfZucCMPvZKvPwe1WTP4A/IyG8x/cAHhAFboTKqdIsfqjn/
	63TdQsrqfDe+6TO+AkYOdlDgdi7eQ==
X-Received: by 2002:a17:902:e744:b0:2c7:9b17:6676 with SMTP id d9443c01a7336-2c7fc75a664mr41820975ad.23.1782418776214;
        Thu, 25 Jun 2026 13:19:36 -0700 (PDT)
Received: from ast-mac ([2601:600:837f:c470:ce8:a3e7:263:95a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b2bc8sm25834345ad.39.2026.06.25.13.19.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 13:19:35 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [GIT PULL] BPF fixes for 7.2-rc1
Date: Thu, 25 Jun 2026 13:19:32 -0700
Message-ID: <20260625201934.54233-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit ef0c9f75a19532d7675384708fc8621e10850104:

  lib: Add stale 'raid6' directory to .gitignore file (2026-06-21 14:09:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to 12091470c6b4c1c14b2de12dcbae2ada6cb6d20b:

  bpf: Disable xfrm_decode_session hook attachment (2026-06-22 20:08:37 -0700)

----------------------------------------------------------------
- Fix effective prog array index with BPF_F_PREORDER (Amery Hung)

- Zero-initialize the fib lookup flow struct (Avinash Duduskar)

- Disable xfrm_decode_session hook attachment (Bradley Morgan)

- Allow type tag BTF records to succeed other modifier records
  (Emil Tsalapatis)

- Fix build_id caching in stack_map_get_build_id_offset() (Ihor Solodrai)

- Add missing access_ok call to copy_user_syms (Jiri Olsa)

- Fix stack slot index in nospec checks (Nuoqi Gui)

- Preserve pointer spill metadata during half-slot cleanup (Nuoqi Gui)

- Fix partial copy of non-linear test_run output (Sun Jian)

- Fix BPF_PROG_ASSOC_STRUCT_OPS last field check (Thiébaud Weksteen)

- Reset register bounds before narrowing retval range (Tristan Madani)

- Fix vmlinux BTF leak in bpftool cgroup commands (Yichong Chen)

- Guard error writes in conntrack kfuncs (Yiyang Chen)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Alexei Starovoitov (5):
      Merge branch 'bpf-fix-stack-slot-index-for-spectre-v4-nospec-checks'
      bpf: Emit verbose message when prog-specific btf_struct_access rejects a write
      Merge branch 'fix-effective-prog-array-indexing-with-bpf_f_preorder'
      Merge branch 'bpf-guard-conntrack-opts-error-writes'
      Merge branch 'fix-stale-register-bounds-on-lsm-retval-context-load'

Amery Hung (2):
      bpf: Fix effective prog array index with BPF_F_PREORDER
      selftests/bpf: Test cgroup link replace with BPF_F_PREORDER

Avinash Duduskar (1):
      bpf: zero-initialize the fib lookup flow struct

Bradley Morgan (1):
      bpf: Disable xfrm_decode_session hook attachment

Emil Tsalapatis (1):
      bpf: Allow type tag BTF records to succeed other modifier records

Ihor Solodrai (1):
      bpf: Fix build_id caching in stack_map_get_build_id_offset()

Jiri Olsa (1):
      bpf: Add missing access_ok call to copy_user_syms

Nuoqi Gui (4):
      bpf: Fix stack slot index in nospec checks
      selftests/bpf: Cover stack nospec slot indexing
      bpf: Preserve pointer spill metadata during half-slot cleanup
      selftests/bpf: Cover half-slot cleanup of pointer spills

Sun Jian (1):
      bpf: Fix partial copy of non-linear test_run output

Thiébaud Weksteen (1):
      bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check

Tristan Madani (2):
      bpf: Reset register bounds before narrowing retval range in check_mem_access()
      selftests/bpf: Add test for stale bounds on LSM retval context load

Yichong Chen (1):
      bpftool: Fix vmlinux BTF leak in cgroup commands

Yiyang Chen (2):
      bpf: Guard conntrack opts error writes
      selftests/bpf: Cover small conntrack opts error writes

 kernel/bpf/bpf_lsm.c                               |   3 +
 kernel/bpf/btf.c                                   | 209 ++++++++++++---------
 kernel/bpf/cgroup.c                                | 108 ++++++-----
 kernel/bpf/stackmap.c                              | 183 ++++++++++++------
 kernel/bpf/states.c                                |  13 +-
 kernel/bpf/syscall.c                               |   2 +-
 kernel/bpf/verifier.c                              |   8 +-
 kernel/trace/bpf_trace.c                           |  11 +-
 net/bpf/test_run.c                                 |   8 +-
 net/core/filter.c                                  |   4 +-
 net/netfilter/nf_conntrack_bpf.c                   |  35 ++--
 tools/bpf/bpftool/cgroup.c                         |  14 +-
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c    |   6 +
 tools/testing/selftests/bpf/prog_tests/btf.c       |  12 +-
 .../selftests/bpf/prog_tests/cgroup_preorder.c     |  77 ++++++++
 tools/testing/selftests/bpf/progs/test_bpf_nf.c    |  26 +++
 tools/testing/selftests/bpf/progs/verifier_lsm.c   |  15 ++
 .../selftests/bpf/progs/verifier_spill_fill.c      |  18 ++
 .../testing/selftests/bpf/progs/verifier_unpriv.c  |  22 +++
 19 files changed, 535 insertions(+), 239 deletions(-)
