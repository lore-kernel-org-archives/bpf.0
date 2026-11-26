Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795664455;
	b=HmgtYC6mO+yNqqJtiHOAqAUjMP5eDXu+s2RryuRGlkAtPcbmRW2qj5DEfOeH+i9W/jbl
	 q4DM7PdN62KpKTAUmFytadCGHwkkv7WoWM9GujAhRPuFR9FJU29S7JNnKV8QBhWGybeIG
	 ObKUGpNtlW4JZRr0yVgIm0PVextwwHsaJLmUgZiqWeN8RxSPfSy5oeglvJyNq/qR1Li7K
	 8dygA+ILs6JNziymgZ5ahgvZbbIVPQHMx/V9obtMFA6p08LBG1YKd7lDv0ijN2M5Hozdr
	 QLhXvMUs3R1VB5CkAe3K0Q764cX0nS0khjXXWWfXRkWHAAWnkUbQ7BasMhT539gholA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795664455;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gArFDwX8F1ZKFuEtJo/mKeuuQAwTF3/hfhRHsBkxe14=;
	b=IwYmTw0lhlLtndgeWd4FUg1o0bMJr+JC269gxIbtdv2btM4x73N30FeVNjpH/hWBH27W
	 X2xeXXwOC9iGivw+ICZi/JwDYyU3dnpTnTTA1jT8qe09WYQ/ztNlEtTfeyrr2lOG1+IG5
	 kfIK4G826jlpoqV3sjVcM4etWSz+T/PBml05wQEU9AwgCs4gV4cfDCYHXsJXK2mze1r2c
	 zDqQbCNUfoXRCjzhkL93JIL2fIphvc0H1Bb0Vo/a6ln0iiLIxpqV/7a9wmDHdLd9BNGxe
	 xESNPRVdMGQDWnhb9RqulanRL3WR2yKnSE9BUg6fSK4ZVbGFYLn4Pces5VGF8a+pJog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="cA45a/GP";
	arc=none smtp.remote-ip=95.215.58.215
Received: from mta1.migadu.com (out-215.mta1.migadu.com [95.215.58.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D270606A32A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 03:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D270606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cA45a/GP
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2mQrwVec4mBUIh1UvZd6SVhlMXO5Z7932el8cKLMyWc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795664453; v=1; x=1796269253;
 b=cA45a/GPeNtob3E1DZ6v6zvPtaHSJ2zV+2ZGwxFdPDVWjGvlYKDXFJN2KenV5/QxMFKJpqHK
 PLHDhQ0jZvG918CwdwUXX8EeenfnumAXg8SdcF4on30zVflgfGG2xAKLFrYyzbqlRQlXQMXAHKY
 ZXgZZE7EGTIKIuiPd5qGEOTk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eca903fa5c9c47af;
	Thu, 26 Nov 2026 03:40:53 +0000
X-Mizu-Trace-ID: eca903fa5c9c47af
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn
Cc: hengqi.chen@gmail.com,
	guodongtai@kylinos.cn,
	bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] LoongArch: BPF: Add private stack, exceptions, large stack and arena support
Date: Thu, 26 Nov 2026 12:40:42 +0900
Message-ID: <20261126034048.7370-1-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: George Guo <guodongtai@kylinos.cn>

This series adds the following features to the LoongArch BPF JIT:

  - private stack
  - exceptions (bpf_throw)
  - 2 KiB of stack for programs, the same as on x86-64 and arm64
  - sign-extending loads from arena (BPF_PROBE_MEM32SX)
  - atomics on arena pointers (BPF_PROBE_ATOMIC)

The series is based on 7.4-rc4 with the following patches applied:

  1. My 1 fix patch:
     LoongArch: BPF: Fix the offset of stptr.w and stptr.d stores
     https://lore.kernel.org/loongarch/20261118071444.10258-1-dongtai.guo@linux.dev/

  2. Tiezhu's 1 optimization patch:
     LoongArch: BPF: Optimize doubleword loads with ld.d and ldptr.d
     https://lore.kernel.org/loongarch/20261118081201.10498-1-yangtiezhu@loongson.cn/

  3. Tiezhu's 4 feature patches:
     LoongArch: BPF: Support instructions array, indirect jumps and calls
     https://lore.kernel.org/loongarch/20261123043907.20225-1-yangtiezhu@loongson.cn/

"LoongArch: BPF: Allow programs 2 KiB of stack" needs the stptr fix:
stack stores beyond the signed 12-bit offset range use stptr.{w/d}.

With this series, the following tests passed on a LoongArch VM (Fedora
43, clang 22.1.8):

  $ sudo ./test_progs -t exceptions
  Summary: 1/119 PASSED, 0 SKIPPED, 0/0 FAILED

  $ sudo ./test_progs -a verifier_large_stack
  Summary: 1/17 PASSED, 1 SKIPPED, 0/0 FAILED

  $ sudo ./test_progs -t tailcalls
  Summary: 1/43 PASSED, 0 SKIPPED, 0/0 FAILED

  $ sudo ./test_progs -t struct_ops_private_stack
  Summary: 1/4 PASSED, 0 SKIPPED, 0/0 FAILED

The skipped verifier_large_stack test only runs without large stack
support.

  $ sudo ./test_progs -t verifier_ldsx | tail -1
  Summary: 1/24 PASSED, 0 SKIPPED, 0/0 FAILED

  $ sudo ./test_progs -t arena_atomics | tail -1
  Summary: 1/11 PASSED, 0 SKIPPED, 0/0 FAILED

  $ sudo ./test_progs -t libarena | tail -1
  Summary: 2/43 PASSED, 0 SKIPPED, 0/0 FAILED

libarena also needs commit 27f2cf406a35 ("selftests/bpf: libarena: Raise
arena spinlock CPU limits") from bpf-next, since CONFIG_NR_CPUS is 2048
by default on LoongArch.

The struct_ops_private_stack, arena_atomics load-acquire/store-release
and libarena parallel tests, the arena tests in verifier_ldsx and the
"private stack: two frames of 2048 bytes" test in verifier_large_stack
are enabled for LoongArch by a separate selftests series for bpf-next,
which was applied for these runs.

Changes since v2:
  - Drop v2 patches 1-3: "Support internal-only MOV to resolve per-CPU
    addrs" and "Add timed may_goto support" are in mainline, and "Fix
    tail call count pointer offset for arena programs" is superseded by
    commit cd7e356b07a2 ("LoongArch: BPF: Move arena register slot below
    TCC context").
  - Patch 2: arch_bpf_stack_walk() went into mainline on its own as
    commit e7103e5e3bde ("LoongArch: BPF: Add arch_bpf_stack_walk()
    implementation"), so this patch only changes bpf_jit.c now.
  - New patch 3: allow programs 2 KiB of stack.
  - Patch 4: add bpf_jit_supports_insn() without the atomics rejection
    that patch 5 used to remove (Tiezhu).
  - Patch 5: on a fault, clear the register that the instruction loads
    into instead of leaving it stale (Sashiko).
  - Patch 5: emit cmpxchg on arena as a single amcas_db.{w/d}, only when
    the CPU has LAMCAS, since the sc of an ll/sc loop can fault too
    (Sashiko). Pass the new value in a temporary register, since rd of
    amcas_db must differ from rk.
  - Patch 5: drop the __add_exception_handler() split, which only the
    ll/sc entry needed.
  - Drop "selftests/bpf: Add LoongArch deny list" (Tiezhu).
  - Move the selftests patches to a separate series for bpf-next,
    "selftests/bpf: Enable private stack, large stack and arena tests
    for LoongArch".
  - Reword the subjects and commit messages following Tiezhu's style.
  - Rebase onto 7.4-rc4 and the patches listed above.

v2: https://lore.kernel.org/loongarch/20260702022322.51033-1-dongtai.guo@linux.dev/

George Guo (5):
  LoongArch: BPF: Add support for private stack
  LoongArch: BPF: Add support for exceptions
  LoongArch: BPF: Allow programs 2 KiB of stack
  LoongArch: BPF: Add support for signed arena loads
  LoongArch: BPF: Add support for arena atomics

 Documentation/bpf/bpf_design_QA.rst |  13 +-
 arch/loongarch/include/asm/inst.h   |   4 +
 arch/loongarch/net/bpf_jit.c        | 391 ++++++++++++++++++++++++----
 arch/loongarch/net/bpf_jit.h        |   1 +
 4 files changed, 355 insertions(+), 54 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
prerequisite-patch-id: ee451ad20d651112f42e66d7ba6fa4242b124fb4
prerequisite-patch-id: 403cb992a7f660379bedce79e3068f1bc6facf05
prerequisite-patch-id: 221fa3fc56a55b9a7462ae7b21330a660240c8d2
prerequisite-patch-id: 08e033b51cefbf1d41f2e5325d591ff900ab81ef
prerequisite-patch-id: ffd6050832069f626c1f55492f0a1898137f6aa4
prerequisite-patch-id: 25f0b3ea5219dfd0676bdf22466453f2bf5dd5ea
-- 
2.53.0

