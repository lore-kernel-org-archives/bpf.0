Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D8942668E;
	Wed, 19 Aug 2026 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129616; cv=none; b=ihhBkg4TLcnJRt7IRZVpJN1o4Uy5LsIxUc4kN9mYeHa9LnmGTzqyZJizK1Kk9w1vmoRFRr9D00JtBE/KMbLHEl/OcEsdn5Q+lzwysYtg/9BunNzA+FelQb70ipCnCoT53zsstXhbTmNUwQ3ztqZeUMOvvcxxgf9nfaCTqFcgGdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129616; c=relaxed/simple;
	bh=z4qu9ITS5DjFlVxMeNp7lLBTANPXTEpWlx4CGv3enX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thpF3Q4/Ir/qOo/5i/sbr+t0S/J6zQahEbkCsb3/1NqRxEvX2han0MEHvNhZrjDyhBnBzjCMGvFjIN6Mwy0EbmRoBgdw8tuErnKGidETEYcIhQytiqHI3T7f2s/MOqj+1zE2F447nzO1Zc7Zbn5fdjqQM0KEJ7K0QsevJmJxbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w9Ey133Z; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w9Ey133Z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787129602; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vwRIgS0ZX4qbni7pPQJUb6lvUnek4jkb6g4oifEGSpk=;
	b=w9Ey133Z+1sMImyZ/e4/L0yNoCA+Ezz4jyiKdS9H316aLSxDs3HLWFr6kdbtNyNvGE5ev35sv77SjeoWDkTJCrzIrEkY97MIEweHmq2u/28ts0ZIze9E2OxyXPrlemUpS85qu10aY4/g/WjU2ab5TI6LVw0h/Z/9q4O3QJzBvRM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9G1fxu_1787129597;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9G1fxu_1787129597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 16:53:21 +0800
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
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] bpf, riscv: Add support for signed arena loads
Date: Wed, 19 Aug 2026 16:53:14 +0800
Message-ID: <cover.1787128322.git.cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Signed loads from arena memory are currently unsupported on riscv64:
bpf_jit_supports_insn() rejects BPF_MEMSX loads when in_arena is set,
so the verifier fails such programs with "sign extending loads from
arena are not supported yet". The x86 and arm64 JITs gained support
for them in v6.18 (a91ae3c89311, eab2a71f3a6a). Since compilers are
free to generate signed loads into arena memory (e.g. GCC-14 was
reported to do so), otherwise valid BPF programs fail to load on
riscv64.

This series adds BPF_PROBE_MEM32SX support to the RV64 JIT and
enables the corresponding selftests on riscv64:

1 implements signed arena loads in the RV64 JIT. The verifier
  already converts MEMSX loads from PTR_TO_ARENA to
  BPF_PROBE_MEM32SX once bpf_jit_supports_insn() allows them, so
  the JIT reuses the existing arena handling: the arena base
  (RV_REG_ARENA) is added to the source register and the load is
  emitted with sign extension (lb/lh/lw). BPF_PROBE_MEM32SX is also
  added to the add_exception_handler() mode gate so faulting loads
  register an exception table entry that clears the destination
  register and resumes execution.

2 enables the arena LDSX tests on riscv64: JIT disassembly
  assertions are added to arena_ldsx_disasm, and
  arena_ldsx_exception/s8/s16/s32 are now run on riscv64.

The series was verified on riscv64 with QEMU (-M virt): all five
arena_ldsx tests pass, including the exception path (load from
unallocated arena memory returns 0) and the sign-extension values
(s8/s16/s32 tests return -1 as expected). The arena_atomics test
suite also loads and runs cleanly.

Changes in v2:
- Fix an extable entry overflow breaking the arena_atomics load.
- Collect Reviewed-by on patch 2.

Note: the __jited assertions in patch 2 were derived from the JIT
register allocation (R0->a5, R1->a0, R8->s3, R9->s4, arena base in
s7) and the emit_ldx() code paths; happy to adjust them if a
disassembler output detail differs.

Thanks,
Pei

Chen Pei (2):
  bpf, riscv: Add support for signed arena loads
  selftests/bpf: Enable arena LDSX tests for riscv64

 arch/riscv/net/bpf_jit_comp64.c                 | 16 ++++++++++------
 .../testing/selftests/bpf/progs/verifier_ldsx.c | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.50.1

