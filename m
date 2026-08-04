Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21746EF79
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858380; cv=none; b=eNCzIKYQ0A+N9otnrZEjZzerTBzr0nAeNiwGf4tMARcddFFHypVa2HIqhBWF3D1q/RccDKmtijy+OeZpBPQM6mL7siaIV051hlIN0Xi3VnDV2VP5Y40Dx1epjuurFZlzYnNj8dNtSPuu+pmrLG8fZ/9jwEHN+ZqwtwqUQh6yQEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858380; c=relaxed/simple;
	bh=nJFzd+F+G5tRxVPylPz5UKp4EjTg+zGE87rtMnRS9iU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=il/eo6n78RVNBBeD3hkOZzzqwrzJU/gsaic/kSLPkJVNY7Rovi0vUeKZ9gd61eAXrWcrcgdGRF9Nty4YSfRhQJyCxU+H/akaqOSW1KcNC+KWOiTJg5oravTI7CGkjyX/reIOe/oQGpaOysgUnHNUxdaGM78u3MyidGvB02Zzxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdWLom7I; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdWLom7I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785858376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xKg7CzqahB1AxtniHPBuBrCNyBYROeJyzCI1lIiHen8=;
	b=WdWLom7Id0Mnu2dx8qclhVH16B/uElwCXpdRoQazKZsDBOD+1dkGKJt0PLqItCF6seIu0i
	rerpLvJwfPI3tEJaTX0ohrzFEZI+Bt/SpbOBoj+PeSSmWyb3FX3IUTJNbg5SnNmV5Nsvj3
	OlZeafv/o0mtyqpHXRjsulGSgvcMEoY=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	hengqi.chen@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: kernel@xen0n.name,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] LoongArch: BPF: per-CPU address resolution and timed may_goto
Date: Tue,  4 Aug 2026 23:39:36 +0800
Message-ID: <20260804153938.16129-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

These are the first two patches of the LoongArch BPF JIT feature work,
sent on their own to make review easier. The remaining pieces
(per-program private stacks, exceptions/bpf_throw, sign-extending loads
and atomics on arena pointers, and the matching selftests) will follow in
a later series.

Both patches are independent of each other. They apply on top of Chenguang
Zhao's "LoongArch bpf kptr xchg inline support" v4 series:

  https://lore.kernel.org/all/20260729022837.355549-1-chenguang.zhao@linux.dev/

Patch 1 adds the internal-only BPF MOV that resolves a per-CPU offset to
the current CPU's address, advertised through
bpf_jit_supports_percpu_insn(). LoongArch keeps the current CPU's per-CPU
base in $r21 (__my_cpu_offset), so the resolution is a single add.
Exercised by the cpumask and percpu_alloc selftests.

Patch 2 implements arch_bpf_timed_may_goto() and advertises it, so the
verifier lowers may_goto to its timed variant, which bounds the loop by a
wall-clock timeout kept in a per-loop stack slot. It uses a custom calling
convention: the count/timestamp stack offset is passed in BPF_REG_AX and
returned there, so the JIT call path skips the usual "BPF_REG_0 = return
value" move for this helper. Exercised by the iters selftests.

Selftest results (all PASS):

  Feature                          Test(s)
  --------------------------------------------------------------
  1  internal-only MOV (percpu)     cpumask, percpu_alloc
  2  timed may_goto                 iters

$ sudo ./test_progs -t cpumask
...
Summary: 1/35 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t percpu_alloc
...
Summary: 1/18 PASSED, 0 SKIPPED, 0 FAILED

$ sudo ./test_progs -t iters
...
Summary: 1/93 PASSED, 0 SKIPPED, 0 FAILED

Based on loongarch-next:
  https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git/log/?h=loongarch-next

These two patches are split from the full v2 series (11 patches):
  https://lore.kernel.org/all/20260702022322.51033-1-dongtai.guo@linux.dev/

George Guo (2):
  LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
  LoongArch: BPF: Add timed may_goto support

 arch/loongarch/include/asm/inst.h       |  1 +
 arch/loongarch/net/Makefile             |  2 +-
 arch/loongarch/net/bpf_jit.c            | 27 +++++++++++++-
 arch/loongarch/net/bpf_timed_may_goto.S | 47 +++++++++++++++++++++++++
 4 files changed, 75 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S

-- 
2.53.0

