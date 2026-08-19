Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3235DA7B;
	Wed, 19 Aug 2026 12:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141375; cv=none; b=Cpfo/jOYI15DZN1eOrG8hCTtBbUXEkOCXE0yEsMF63ETIB0E28dVovNHNYIew3ypbZf5PWJEB/+llkuUy7Fbr/6VtY6COjJMMZfaS4IgaO4gCPrftHwuRKkFiceCZSsNEo6QeJ6faA8vL3QofeOKMjRKlN8mPaVZ0YT333JCFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141375; c=relaxed/simple;
	bh=J71bAFzfJq93Oq11doXt66mxSi8uojrdzfe/qmFMiwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAS48xZt6rgvXGa6EVHR4G3tPpJCPSZzaPPlNXjeQYvrHJptlW25rOXnMvl4N/tqnIcQVzqVouNkyAOxBiPAlV7casRP/0NXG71Ktj9LJUCX5mkpTW8ujd9ahSx5qkM2MtEHGvSwcxnS9MqnfStTWXX6M2OZTYLoOSo+AXBRXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XQC7jCFh; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XQC7jCFh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787141370; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nsrQsrvNgsc1Q4hzl9K1PyRWt6ItnxGRc2gHDULbnBI=;
	b=XQC7jCFhmnnYoC1darh3p7K7UfEYc4lwgtBDd8s51UMZpIW6aGJiF17nnEfxt5hHWA6FnYgE7JeN3L0hlVx4VbiNA38e1DN6y1EHZo3wbxBqvDOGxJISPExmHKd4EVSOR5odS82VfYTAHvjg1VdIukVD00JhjPGOokA3kipvoLI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0X9GeFT9_1787141365;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9GeFT9_1787141365 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 20:09:29 +0800
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
Subject: [PATCH bpf-next v3 0/2] bpf, riscv: Add support for signed arena loads
Date: Wed, 19 Aug 2026 20:09:22 +0800
Message-ID: <cover.1787140923.git.cp0613@linux.alibaba.com>
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

Changes in v3:
- Restore the pseudo-code form of the PROBE_MEM32SX case comment.

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

