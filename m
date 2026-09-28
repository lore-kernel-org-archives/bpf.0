Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709F360ED0;
	Mon, 28 Sep 2026 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790562097; cv=none; b=jVAQAtqvDlU9IoYoXUe/4+5dQ44CdAevu7+r1/4fAhknaE1281NI0JsgLuvPSk9OcNEi59T0dnKx5Dh/IAkmvJE2H8gZCUr8b5JKP/i5Zxoq1NuwPcn3pcpW269AUredjceVbbFRyqOzcrkkArVawxjjCpCNtozJO0JlbV6rbg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790562097; c=relaxed/simple;
	bh=Yg36/Y/xieRMTCy2TymSr88MYM7p0irsU849vmkCnT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyfy84Jw1r8/nnmqRmsnbYO7icV4GEHNMBC6ymrWcmHEiewwetcMOJwfhmTcKF2guvUZWvLHHR5IcEjF4YAys6z518Awn4MT2nvZezA63VwnEPvDwJj9qc4cW2hReKam+984pq1sXksYosN2I3t8XpQNvoBGFIRrd/DM8UK4BJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NOuwkCdG; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NOuwkCdG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790562091; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=uO5TIYKBfsawqPiNAsCntfjYc2ZcPToZ1eaI1Kfnyk4=;
	b=NOuwkCdGSVOCHvMRK90fuLnlA9UUXwxW9OhRlpfVuHvUkH/Kd29X6WVq5g4ARoAWrtRYGES4bV3srwpGuxA90ueyFKD5M06k32QLUsmowo3SUd579cV1uLL4F7O5nnEOrOGWgn96w0y6N3ijE6uVU1tcrtNTCa+fID1yByQ1ZZQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBgzgGN_1790562069;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBgzgGN_1790562069 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 10:21:30 +0800
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
Subject: [PATCH bpf-next v2 0/2] bpf, riscv: Add support for indirect jumps
Date: Mon, 28 Sep 2026 10:21:07 +0800
Message-ID: <20260928022109.1093-1-cp0613@linux.alibaba.com>
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
in the jump table addresses. Patch 2 widens the arch guard in
verifier_gotox.c to riscv64, the same way arm64 and powerpc were enabled.

Changes since v1:
- Rebased onto bpf-next.
- Patch 1: reword the code comment to say "shift ctx->offset[] by one".
- Patch 2: collapse the multi-line #endif marker to a single line.
- Added Reviewed-by/Acked-by from Björn Töpel.

Testing
=======

Environment: QEMU virt rv64, with CONFIG_BPF_JIT=y,
CONFIG_BPF_JIT_ALWAYS_ON=y, CONFIG_DEBUG_INFO_BTF=y; selftests
cross-built with clang 22.

- test_progs -t verifier_gotox: 27/27 subtests pass on bpf-next, 13 of
  them executed through BPF_PROG_TEST_RUN.
- test_progs-cpuv4 -t bpf_gotox: 14/14 subtests pass, none skipped.
  The cpuv4 flavor is needed here because bpf_gotox gates its subtests
  on __BPF_FEATURE_GOTOX, which clang only defines for -mcpu=v4.

Chen Pei (2):
  bpf, riscv: Add support for indirect jumps
  selftests/bpf: Enable gotox tests for riscv64

 arch/riscv/net/bpf_jit_comp64.c                  |  5 +++++
 arch/riscv/net/bpf_jit_core.c                    | 16 ++++++++++++++--
 .../testing/selftests/bpf/progs/verifier_gotox.c |  6 ++++--
 3 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.50.1

