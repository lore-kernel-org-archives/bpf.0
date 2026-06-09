Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C637DEB6
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978495; cv=none; b=JH1boIB2CRvZxJS3wAt6dsnfQA/hVgP6mGe9LgcdAJvrOjZZKgTr+amZYbi9yyGctXfFrgLgd+DnvIWehky5d56Paox1XPq7NXcm683gCCR/i61XCvrCdhRew3gZd9W+kc+5TUT3tIjJ+eAPzB3JbRZSKKEsUXOMEDXNQCofjSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978495; c=relaxed/simple;
	bh=8Wl88CclZtch4nFfuUNMQS4T7FDqQRjTAtiKzMLmziw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tGX/o0GK3ABdn1acL635PcG6oCYBPYYtPnF10kaYOuBZPMeSsZSe7xE8GHpcH8L8P92lkeRw8Oy8CnWklKf6x9gjXrsU/IZrvFYVUjzBNmel3Ka9L96oTDp74N/pWgK1jy71z1hc9th+UWteFS+KZe9GTx5P8New7kVumHXuRVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pD/n8qaO; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pD/n8qaO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780978482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VMcNNm4RCSgJt1bQ6oDXVyCxKXi893wGdEJh0R6dYu8=;
	b=pD/n8qaOfbat1/eDN92nQMxkAXo7q4XYuT3J7mG7AKaYzTcqbeKyux5r9T3P+NRrciyVbh
	RiNMM/xc6gPLHkdXGOAUiUEJhScYMkY7gOxq/WPP0/1vEfVNY0cwPNI5B47gn+Ac+TY2NH
	/KpNhPTTSUhux+/mgFy9FMfgau8VEIA=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH v1 0/2] LoongArch: BPF: per-CPU addr MOV and timed may_goto
Date: Tue,  9 Jun 2026 12:14:05 +0800
Message-Id: <20260609041407.122384-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

This series enables two independent BPF JIT features on LoongArch, each
advertised to the verifier via the corresponding bpf_jit_supports_*()
hook:

Patch 1 implements the internal-only BPF_MOV that resolves a per-CPU
address from its per-CPU offset. LoongArch keeps the current CPU's
per-CPU offset in $r21 (__my_cpu_offset), so the resolution is a single
add of $r21 to the source register. This is used by verifier/JIT
inlining (e.g. bpf_get_smp_processor_id() and per-CPU map lookups) and
is not exposed to BPF users.

Patch 2 implements arch_bpf_timed_may_goto() (in a small assembly stub
with a custom calling convention passing the count/timestamp slot offset
in BPF_REG_AX) and advertises it, so the verifier lowers may_goto into
the timed, wall-clock-bounded variant instead of a fixed iteration
counter.

Tested on a LoongArch (Loongson-3A5000) QEMU/KVM guest with
CONFIG_PAGE_SIZE_16KB and CONFIG_UNWINDER_ORC:
 - patch 1: test_progs cpumask and percpu map cases pass;
 - patch 2: test_progs iters (incl. the cond_break / may_goto loop
   cases) all pass.

George Guo (2):
  LoongArch: BPF: Support internal-only MOV to resolve per-CPU addrs
  LoongArch: BPF: Add timed may_goto support

 arch/loongarch/include/asm/inst.h       |  1 +
 arch/loongarch/net/Makefile             |  2 +-
 arch/loongarch/net/bpf_jit.c            | 27 ++++++++++++++-
 arch/loongarch/net/bpf_timed_may_goto.S | 44 +++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/net/bpf_timed_may_goto.S

-- 
2.25.1

