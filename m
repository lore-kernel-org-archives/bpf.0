Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51326C3B0
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511428; cv=none; b=qnB7yU51BgBuwF2Ntj9ao7rjrpjre2sxfUSv7sP3GSty3ATgJYCbqZvWBJVSUzpmoUSrXFTke0FaEbTruqBojLHJ7azy3zsnZIbSzOT+CV7BqCcWtEUtiCvYoYz3SLcv9z/h8lqHLOHAKTlL1wQ5jqjvP7XSq1o3DaK/0fcXZBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511428; c=relaxed/simple;
	bh=CG2uCtipwOOt8HU/0TWfy6Fc9mWxrM+FVH2EaxMB+0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UxRn4et3wrRAeERfFRi1nR8pCWXZc/OTzziSFu6x712eXUejPVvTm3P9+c1FAERlFdpuEAoAbhjwz6UDqUL+8aYnNMYVzKilwgmM4Cl8ySATy97Sscyrzz6njV3PsSOdjvWQ3Yy3FoJTyqRVM7AAvU0SbJwiZiyyfHv4KacH2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lR2culyr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lR2culyr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771511415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LRtR7BaGNupDWJtUJ58LFj4w6zAqDSzxcIixhPEboME=;
	b=lR2culyrTuf+k/z/wvJ7a4TUVJtUKioslDuE04IeFiNfDyawkkQoEMJkVNpSWGmNExEPFF
	Zzz9Cu/xfdoAwYIVGaS/KJNhqdaV5GF/Ud+dTmgeV5uAC/UIabDJL1FUIHTlOxvi0sV8O9
	J8IYCsIie3aBLLg+bK95zRLvhIVzVaM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Peilin Ye <yepeilin@google.com>,
	Luis Gerhorst <luis.gerhorst@fau.de>,
	Viktor Malik <vmalik@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v2 0/6] bpf: Introduce 64-bit bitops kfuncs
Date: Thu, 19 Feb 2026 22:29:22 +0800
Message-ID: <20260219142933.13904-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds generic 64-bit bitops kfuncs and JIT inlining support
on x86_64 and arm64.

The new kfuncs are:

* bpf_clz64(): Count leading zeros.
* bpf_ctz64(): Count trailing zeros.
* bpf_ffs64(): Find first set bit, 1-based index, returns 0 when input is 0.
* bpf_fls64(): Find last set bit, 1-based index.
* bpf_bitrev64(): Reverse bits.
* bpf_popcnt64(): Population count.
* bpf_rol64(): Rotate left.
* bpf_ror64(): Rotate right.

Defined zero-input behavior:

* bpf_clz64(0) = 64
* bpf_ctz64(0) = 64
* bpf_ffs64(0) = 0
* bpf_fls64(0) = 0

bpf_ffs64() was previously discussed in
"bpf: Add generic kfunc bpf_ffs64()" [1].

The main concern in that discussion was ABI overhead: a regular kfunc call
follows the BPF calling convention and can introduce extra spill/fill compared
to dedicated instructions.

This series keeps the user-facing API as kfuncs while avoiding that overhead
on hot paths. When the JIT/backend and CPU support it, calls are inlined into
native instructions; otherwise they fall back to regular function calls.

Links:
[1] https://lore.kernel.org/bpf/20240131155607.51157-1-hffilwlqm@gmail.com/

Changes:
v1 -> v2:
* Drop RFC.
* Add __cpu_feature annotation for CPU-feature-gated tests.
* Add JIT disassembly tests for 64-bit bitops kfuncs
* Address comments from Alexei:
  * Drop KF_MUST_INLINE.
  * Drop internal BPF_ALU64 opcode BPF_BITOPS.
  * Mark all of the kfuncs as fastcall and do push/pop in JIT when necessary.
* v1: https://lore.kernel.org/bpf/20260209155919.19015-1-leon.hwang@linux.dev/

Leon Hwang (6):
  bpf: Introduce 64-bit bitops kfuncs
  bpf, x86: Add 64-bit bitops kfuncs support for x86_64
  bpf, arm64: Add 64-bit bitops kfuncs support
  selftests/bpf: Add tests for 64-bit bitops kfuncs
  selftests/bpf: Add __cpu_feature annotation for CPU-feature-gated
    tests
  selftests/bpf: Add JIT disassembly tests for 64-bit bitops kfuncs

 arch/arm64/net/bpf_jit_comp.c                 | 123 ++++++++++++
 arch/x86/net/bpf_jit_comp.c                   | 141 +++++++++++++
 include/linux/filter.h                        |  10 +
 kernel/bpf/core.c                             |   6 +
 kernel/bpf/helpers.c                          |  50 +++++
 kernel/bpf/verifier.c                         |  53 ++++-
 .../testing/selftests/bpf/bpf_experimental.h  |   9 +
 .../testing/selftests/bpf/prog_tests/bitops.c | 188 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bitops.c    |  68 +++++++
 .../testing/selftests/bpf/progs/bitops_jit.c  | 153 ++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   7 +
 tools/testing/selftests/bpf/test_loader.c     | 150 ++++++++++++++
 12 files changed, 957 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bitops_jit.c

-- 
2.52.0

