Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8CC443307;
	Mon, 28 Sep 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790579944; cv=none; b=qyj6r93IpTLU9AHpt6w20QHndEqYq5On8nFDkLj2FdieuQnavgTfR3ReMXBpYzItBZDXR8+5Bsj2ZvrBBMvkbeHRJ6tNzVgmM0RpCLJ/j8Z/5NNFxN2OR2yfa5cls3ql+aiDZ1W5kYk+5cruqe+7WJRyeAKcb5xWXdQOCAX3v4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790579944; c=relaxed/simple;
	bh=uWOg7sprtv/tG9MHGQ7VjpWVLWj6VJ6pZRapRcnTU4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=STNc6RXZXiu1t69NtehT1fEmjR9WKcusroiK4LHjOvjRD6HcUPuuD6c8TtLgyEdaFVR4hkQOUFFMGjmIMtdSIulHcLNOJCLQETLRkzCDnDTLK4qPx55e18ogHCTHCAZCRwGz3dFMVXlgH5Mk/NQwDiglK0B6gpp3+bpJRDNL8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uhuKJxND; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uhuKJxND"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790579932; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=otGvhaMgyAjabjWj/NKnLV8cn4GGHC38pvR1Q5TALtk=;
	b=uhuKJxNDZdFt2XXGQeUUONVYVuuXd4/+MQkSJb5WIKFVxPXUyTWcJL0E9I/rfvqsztm7nYz5WjPI5IlFWXjRlZzkJVStJcLISme7W3lIB9x7BG4pvm7v04JdRX9DC9tpZmbeUaKK8bDIMuu7amU4SZ+bPKVfLaU5KnxRWEdeBSE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBjcVMW_1790579926;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBjcVMW_1790579926 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 15:18:51 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/4] bpf, riscv: Add support for indirect jumps
Date: Mon, 28 Sep 2026 15:18:41 +0800
Message-ID: <20260928071845.2432-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The indirect jump instruction (BPF_JMP | BPF_JA | BPF_X, "gotox") and the
BPF_MAP_TYPE_INSN_ARRAY jump tables it consumes are core features: the
verifier accepts them on every architecture, and the x86-64, arm64 and
powerpc JITs implement them. On riscv64 a program using gotox passes
verification and then fails to load, because the JIT does not know the
opcode and CONFIG_BPF_JIT_ALWAYS_ON leaves no interpreter to fall back
onto.

This series adds the riscv64 support and turns the existing selftests on
for that architecture.

Patch 1 emits "jalr zero, rd, 0" for gotox and publishes the xlated to
jitted offsets through bpf_prog_update_insn_ptrs(), which is what fills
in the jump table addresses. Patches 2 to 4 widen the arch guards in
verifier_gotox.c, compute_live_registers.c and bpf_insn_array.c to
riscv64, the same way the other architectures were enabled.

Changes since v2:
- Pick up Pu Lehui's Reviewed-by on patch 1.
- Enable two more gotox test files for riscv64: compute_live_registers.c
  and bpf_insn_array.c.

Changes since v1:
- Rebased onto bpf-next.
- Patch 1: reword the code comment to say "shift ctx->offset[] by one".
- Patch 2: collapse the multi-line #endif marker to a single line.
- Added Reviewed-by/Acked-by from Björn Töpel.

Testing
=======

Environment: QEMU virt rv64, with CONFIG_BPF_JIT=y,
CONFIG_BPF_JIT_ALWAYS_ON=y, CONFIG_DEBUG_INFO_BTF=y; selftests
cross-built with clang 23.

- test_progs -t verifier_gotox: 33/33 subtests pass.
- test_progs -t bpf_insn_array: 20/20 subtests pass.
- test_progs -t compute_live_registers: 20/20 subtests pass, including
  the gotox liveness subtest.
- test_progs-cpuv4 -t bpf_gotox: 14/14 subtests pass.

Chen Pei (4):
  bpf, riscv: Add support for indirect jumps
  selftests/bpf: Enable gotox tests for riscv64
  selftests/bpf: Enable gotox liveness test for riscv64
  selftests/bpf: Enable instruction array test for riscv64

 arch/riscv/net/bpf_jit_comp64.c                  |  5 +++++
 arch/riscv/net/bpf_jit_core.c                    | 16 ++++++++++++++--
 .../selftests/bpf/prog_tests/bpf_insn_array.c    |  3 ++-
 .../selftests/bpf/progs/compute_live_registers.c |  5 +++--
 .../testing/selftests/bpf/progs/verifier_gotox.c |  6 ++++--
 5 files changed, 28 insertions(+), 7 deletions(-)

-- 
2.50.1

