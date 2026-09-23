Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B73329E6C;
	Wed, 23 Sep 2026 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168980; cv=none; b=mwYzC2djytR4OcAtidevhhdVqrjYTeX1Q/grSZCPWc+omgesG9eFrKNAtTdhWaGuK1rFiLyAOZIDlqnCJA1vuzQAxcvZewzRxKX0huG/YNVaDf7rVet5F7/LC7jSpr4cLeW1Qo7FL4I5LMNMneQ7+OhZXEpdIuBRDxSK16JET2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168980; c=relaxed/simple;
	bh=LQ9k+WQNRVpOruFMteZlfUVv7ex2UbNfF1vhuzFymEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1SoOfl134TOmxHbhYVOTQKs8omtYcC08aAXff7mHt4TijIQx39mgk9vv17A1MDeNZCKjniNixZDCumITyq78TZ0doR1ppsWDP08yj050BCmGDE8FGqVHDKveKIJS7+NpASsMN0FLiO0fT/upXuq0BG91KrU4m7sm+5fKFHwDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WcIJi0Dl; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WcIJi0Dl"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790168967; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dVPfmbTv+JM2jarPBZCBYnAw22AyOzA3cOqy6hp9N2c=;
	b=WcIJi0Dl9LrYUV5ZHM9LD/3h+tVkQKHVWYceECyZGMK112Ommf6P7qq/kFzEj6vM3tNd51N9Em2mBIg2NzXOtHvW++7wJYhH1edS5aRfqPSs4GQGd1CAompsLvE10PUPo492SHTo88hGJVfzG/+MFGX1a9f9GdLfeqdZXRm5K40=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XBX4ZCL_1790168937;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XBX4ZCL_1790168937 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 21:09:26 +0800
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
Subject: [PATCH bpf-next 0/2] bpf, riscv: Add support for indirect jumps
Date: Wed, 23 Sep 2026 21:08:54 +0800
Message-ID: <20260923130856.1157-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 .../testing/selftests/bpf/progs/verifier_gotox.c |  8 ++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.50.1

