Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283762F8E8D
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959037; cv=none; b=CWEHoAUmxcBa/Li0Mw6yxklT05RDFJoMacZj5Ij6TXQE2vUFsoTPs0wz9BeZh+VrrBPhQBf+h/2shMB4J8DfYVIWcnDrMnG0oL5MKBFqWqZ78gwVp1NMvXHYghVPNULePqDA6koMhyPj0y5UNQqZ6YaGoawNcDJGnKuIpqysAZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959037; c=relaxed/simple;
	bh=yplBL66WLmZGYDHw0TI7wnH5gX+F/2Udmn6htXB7G18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCVIBf8VXAsxZTPIdBzeO4FhrKC+dSP8IS0pRFM4DJRW7jeMGZXGmrcdxgFnT2/K+AyFrNr7SBXCJi7ELEYrJscloYP/0Hpw9Nv8yIuc/DdTicwwZkGMbTHCpdtZPlGJs0vgnBh+JtWrpUbVWfOciLtNGfENShQ/8/L0LDEar/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJDpm7Gb; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJDpm7Gb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782959023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cX5Z8YeR97ZszPR6LJ2fsh+c2SruApAoDhLXDRoFhzg=;
	b=vJDpm7Gbx5bIZSlrN1GTZ7oArsFFkvQIONWe+nDfAQqEFZb0XBgyEEcjEsUi56Y2ZXZXk6
	qyXj0xOkeHVpS28LrPAwoEN9fsq1a01pfnHybIlKIPmYYecZ5qGhD/UvRFu5GzO4hBef3B
	icGDQrh+QlS9S8IteqSvdFaRkUig5Lo=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	George Guo <guodongtai@kylinos.cn>,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 00/11] LoongArch: BPF: arena features, exceptions, private stack and may_goto
Date: Thu,  2 Jul 2026 10:23:11 +0800
Message-Id: <20260702022322.51033-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds the remaining LoongArch BPF JIT features and enables the
matching selftests:

  - internal-only MOV for per-CPU address resolution
  - timed may_goto
  - per-program private stacks
  - exceptions (bpf_throw)
  - sign-extending loads from arena (PROBE_MEM32SX)
  - atomics on arena pointers (PROBE_ATOMIC)
  - selftests: struct_ops private stack, arena LDSX, arena atomics, and a
    LoongArch deny list

Patch 1 ("LoongArch: BPF: Fix tail call count pointer offset for arena
programs") is the same fix already posted separately for the bpf tree;
several patches in this series (notably exceptions, patch 5) build on
top of the helper it introduces, so it is included here, unchanged, to
keep the series self-contained and applicable on bpf-next. It can be
dropped once it lands via the bpf tree.

  LoongArch: BPF: Fix tail call count pointer offset for arena programs
  https://lore.kernel.org/all/20260629085511.359546-1-dongtai.guo@linux.dev

Based on 7.2-rc1.

v2:
 - Included the tail call count pointer offset fix as patch 1/11 (see
   above) instead of only referencing it, so the series applies cleanly
   on bpf-next without waiting on the bpf tree; the empty prog_array
   off-by-one was fixed independently upstream by commit 0379d10f09bc
   ("LoongArch: BPF: Fix off-by-one error in tail call"), now in 7.2-rc1.
 - timed may_goto: store $ra at the ORC-mandated .ra_offset = -8 slot in
   the trampoline (it was stored at the wrong slot in v1), per Tiezhu
   Yang's review.
 - Consolidated the earlier per-CPU MOV / timed may_goto and arena gating
   postings into one series; rebased on 7.2-rc1.
 - selftests: use the upstream __arch_loongarch / "LOONGARCH" test_loader
   support now in 7.2-rc1 instead of introducing it.
 - Prior postings:
   https://lore.kernel.org/all/20260609041407.122384-1-dongtai.guo@linux.dev
   https://lore.kernel.org/all/20260618033809.98253-1-dongtai.guo@linux.dev

George Guo (11):
  LoongArch: BPF: Fix tail call count pointer offset for arena programs
  LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
  LoongArch: BPF: Add timed may_goto support
  LoongArch: BPF: Add private stack support
  LoongArch: BPF: Add exceptions (bpf_throw) support
  LoongArch: BPF: Support sign-extending loads from arena
  LoongArch: BPF: Support atomics on arena pointers
  selftests/bpf: Enable struct_ops private stack test for LoongArch
  selftests/bpf: Enable arena LDSX tests on LoongArch
  selftests/bpf: Enable arena atomics tests on LoongArch
  selftests/bpf: Add LoongArch deny list

 arch/loongarch/include/asm/inst.h             |   1 +
 arch/loongarch/kernel/stacktrace.c            |  52 +++
 arch/loongarch/net/Makefile                   |   2 +-
 arch/loongarch/net/bpf_jit.c                  | 397 ++++++++++++++++--
 arch/loongarch/net/bpf_jit.h                  |   1 +
 arch/loongarch/net/bpf_timed_may_goto.S       |  47 +++
 .../testing/selftests/bpf/DENYLIST.loongarch  |   1 +
 .../bpf/prog_tests/struct_ops_private_stack.c |   2 +-
 .../selftests/bpf/progs/arena_atomics.c       |   3 +
 .../selftests/bpf/progs/verifier_ldsx.c       |  17 +
 10 files changed, 485 insertions(+), 38 deletions(-)
 create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.loongarch

-- 
2.25.1

