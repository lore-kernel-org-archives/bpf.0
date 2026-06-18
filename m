Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93C14884C
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753933; cv=none; b=gMs0yUL3z01xHypBYNT2tbb2XGjQgJ3XdlH3pi0OjxSFjAz4gioqL40P8dvyGdme2/OyDFcZ5YbHZxHhMGj3q0X8zOR3C0ZgVP9w9gp9n1nplqdKJVM8vEvoyuQtkStUZZ6ht5J6bGyvFG39pd33O/ke351sazMB2uUWxVXtqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753933; c=relaxed/simple;
	bh=anaz+9ZZxyfRKUcRTPbX7Ph3HodpI6dtwKZOS0roqnc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5MZY4OTd+6wVVt90GwnCd+Jdsbq6G8RdWsKCp8Rz0Z6aT0EgaRuIcElpN/8AFoM7oQSJDfWBxPm4MLpHANhZfHPAOWVuwTXo/8Xiq14ufXTu8xop20HH1bVoTdElB8iIEk1LdCf4ceQykofd2hSfCQxWvEF7mQJ/ZcfSnipumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QKubptTE; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKubptTE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781753919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGvmfKekfBpASW5+N5hmq6REiUIEtZPpTONmmCc5MJg=;
	b=QKubptTEFnxfHcl43nVdAdwAMqz2UCSrozLyUD3gutlWhEu2VmlbnNb8uHOvaRrHgK00Lr
	BKV+CGKsO7IuXZIsVnmXFjUOc9H5sXm4/K27BIvBlkxX3owyWoXwmlHD1V1ARLVJkhBELz
	5OhvzMpPD+17UC94ipDa4lDVTknMqQE=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com
Cc: kernel@xen0n.name,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 0/5] LoongArch: BPF: arena instruction gating, private stack and exceptions
Date: Thu, 18 Jun 2026 11:38:04 +0800
Message-Id: <20260618033809.98253-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

This series adds three LoongArch BPF JIT features, plus the accompanying
selftest changes:

  1. Gate the arena instructions the JIT does not implement (atomics and
     sign-extending loads on arena pointers) via bpf_jit_supports_insn(),
     so the verifier rejects such programs early with a clear message
     instead of letting them fail late in the JIT.
  2. Per-program private stack (bpf_jit_supports_private_stack()): the BPF
     stack of deep/recursive tracing programs is moved off the kernel
     stack into a per-CPU allocation bracketed by overflow/underflow
     guards that are checked on teardown.
  3. Exceptions / bpf_throw (bpf_jit_supports_exceptions()): unwind to the
     exception boundary program via arch_bpf_stack_walk() (built on the
     ORC unwinder) and reuse its frame in the exception callback. Gated on
     CONFIG_UNWINDER_ORC.

Patches 4-5 are the selftests side: a LoongArch deny list (arena_atomics,
which patch 1 deliberately rejects) and enabling the struct_ops private
stack test on LoongArch. They touch tools/testing/selftests/bpf, hence the
bpf@vger / linux-kselftest Cc.

The series is independent of the earlier "LoongArch: BPF: Support
internal-only MOV to resolve per-CPU addrs" / "Add timed may_goto support"
patches [1] (no functional or apply dependency) and targets the LoongArch
tree.

Testing on a LoongArch board (test_progs):
  - exceptions:               117 subtests, 0 failed
  - struct_ops_private_stack: private_stack / _fail / _recur, 0 failed
  - arena list/htab/strsearch and verifier_arena*: pass
  - arena_atomics: rejected by the verifier as expected
      ("BPF_ATOMIC stores into Rn arena is not allowed"), hence the
      deny-list entry in patch 4

[1] <https://lore.kernel.org/all/20260609041407.122384-1-dongtai.guo@linux.dev/>

George Guo (5):
  LoongArch: BPF: Gate unsupported arena instructions via
    bpf_jit_supports_insn()
  LoongArch: BPF: Add private stack support
  LoongArch: BPF: Add exceptions (bpf_throw) support
  selftests/bpf: Add LoongArch deny list
  selftests/bpf: Enable struct_ops private stack test for LoongArch

 arch/loongarch/kernel/stacktrace.c            |  52 ++++++
 arch/loongarch/net/bpf_jit.c                  | 172 +++++++++++++++++-
 arch/loongarch/net/bpf_jit.h                  |   1 +
 .../testing/selftests/bpf/DENYLIST.loongarch  |   2 +
 .../bpf/prog_tests/struct_ops_private_stack.c |   2 +-
 5 files changed, 222 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.loongarch


base-commit: 186d3c4e92242351afc24d9784f31cb4cd08a4b7
-- 
2.25.1

