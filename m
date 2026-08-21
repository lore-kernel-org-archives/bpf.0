Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FF1E7C18
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355320; cv=none; b=T1+MYZKglyyOE52w2U+Gv//MXIR2fe84iSbNVB6oDhFgztfRhJBtqDmcFew42PlZhKnGnwmAuk0m53/uaiW6qrQjDuQOw3DJmTZ/zhlVZP1FS5d04L8c6H5HsZW+CxQGtJ3dMAlPhPzFvndSSkDoZY1C/SmnEVaI1D9x5/kf/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355320; c=relaxed/simple;
	bh=sLRjspWSH4fPAByrx24U57KBuR7i8nX61W9qcmZgFIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gIlA3MxcerARYoZ19iXq/HmpMuua2rTMNYjm9cRE4OyW3DjyYsg4aR0h2SILPSfki8m497Zc4h3WrQ13zt6opcK0kEpZrP20K81R8CYwi+DDxApJ15s9oYoUyeAhI9PxNdA3X/i3xMM/dfoqULSr7ZCfDlichAZ64hn7RZA869o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+fXYAzV; arc=none smtp.client-ip=74.125.228.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+fXYAzV"
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6a403027d38so791150a12.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355317; x=1787960117; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pG12fImG6Nj59O9r+b2ZI+aPL/B1FUmOVeFOV6rsDaw=;
        b=a+fXYAzVESh0GNdQ+JXerqJhM1AWN5UbmI+KRoLtuGqKa/XmxT1Z8Q2M89hE3Ka+2B
         mJ5LMEh4RjoltMNwR+8J7A84SsaBRcZ1z/vDuV0fBhqx8o9J6JSgNpzLAAJ9GEhrz3D8
         b5tkXmJIgpGVCsUH57HbPoVsdtWsC3afTcQGXfGhW+P1r9+jGoeEfRxt01ems8iCAm/b
         0bVdKeAb3wUalXoPdf9ou3677D1ZK5K7q9k+ZztQGxDixo6AI2/FAyOh0gyrLIqCRpDW
         s4/6gxqe07AAcAbrLn1vL8zsmfBX8H2J7/2v72k8JkP/RNIUHf9NrM0w/8aSPT8kpLC+
         IWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355317; x=1787960117;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pG12fImG6Nj59O9r+b2ZI+aPL/B1FUmOVeFOV6rsDaw=;
        b=B+ucaYlTdBZESZUuLaZ7sGhysEif3ov5Aser4xeuYu4WW75KAvxTYMJU5Gkw3r6aLf
         erZTZjFMZ7pZVbZ38EiYycHi+5OaJbeHmkWeNjcoVqQ2fuLQlKYqH9MOdcqA/vNADLWR
         cEPZEgcwgjTsw97V0lHVG3rXxb623qFFZhRHPhYxQhq+Vi8Tqsb2pSuVusdq3KyXRfyX
         4EGiA9uD6zws/krM86B34eY/41CDSGBQb4eazfPN+s7gWqIOKcfZYW2wwlWT/O+c/w4d
         1np7Iba4oB8a/2vzM9BldD9q/fgf5Rmkd4IPjq1FIrrtIADRXFZSrKvidA5nXZSoxjc3
         gdBA==
X-Gm-Message-State: AFuF++muCc+ql0XSaSDlzl9EgOG3joxE7/K2VAZSz1s/v729M5H9W5Xl
	tBqhP2mfGcMyqc6wTAHv3URAXPO3Khp+GvMSIjMgqQbIJtmQ66Ktjm6qlWxTgQ0T
X-Gm-Gg: AR+sD12BYCf1JrX2zVI0CDd+dspEXd8LFMAw9rTjmQTQ7PnlZ1j01i88n4H47pladsq
	K5SkxVtnU8ua1PDCoGMSwuFncHCv1Q0Fu/AkRt4Z1kKX16/u8Zn39gbJ7GsyOEY0LhxlWDibtGs
	taFpUaytAzojddCDHc1KXVgQ5ogo8zPq9CmTdcIOnE28z7iCH4jyva0lF2Fdoia2LxjYcxAoFrC
	afhKriOIUN8mtYHQ3nPfkmPS+its2m4P5Nn510CaiBNSZSq+oyQWyBx8fv1DTDTuqk3QSBx4XzY
	HGR3DupK11d4+Za6iEm4lYeWM30uv+AnNnfbRRyR5JjjuRRs3i0A4MncnxRxpzlS7QAMtdC0UOo
	ZpQB/yl08aUDIIBHQaXJ3mYLiP15wHBg9uR7uVll9llzktQgdtIRFSRQnIlQIoaTMJYCZn5JS3d
	VaSPqw9/Bk69WrHlrh+0MQEcDju/oMwgLZVbKtWIAegqNJI1uR0Lsvz8lh/iXnMoKX5nFhgbUvw
	4pnHROLkXW2kkF5AiCpni9o+A+TBTq933vGZjld/bwfu4WTzH7NIkJGl713KzWRoDg9iTdrQzhK
	HSSDLgnhMouFbfzuh0kmQW/Rg/M=
X-Received: by 2002:a05:6402:428c:b0:6a1:f557:b818 with SMTP id 4fb4d7f45d1cf-6a582b77e16mr2305933a12.14.1787355317230;
        Fri, 21 Aug 2026 16:35:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0d5f70sm8939372a12.13.2026.08.21.16.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 00/14] Retire KF_ARENA_ARG kfunc flags
Date: Sat, 22 Aug 2026 01:34:54 +0200
Message-ID: <20260821233516.3426127-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3989; i=memxor@gmail.com; h=from:subject; bh=sLRjspWSH4fPAByrx24U57KBuR7i8nX61W9qcmZgFIc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQccz09v7Ncwe3GvUT/4XUfJJcJrRAb4Z4Qo+slta7 FdKfD3UUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInM28nI0HC70z0o9UXKJb/d VmbnT5vHLJCoe9B4V8XRQ9FxQYnDJ4a/IrN6dH0Lngd9OrDm6/atjJP2sZwqOJc6O2zCmSkNX9P CuAE=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

KF_ARENA_ARG1 and KF_ARENA_ARG2 duplicate the BTF argument-name suffix
mechanism and only cover the first two kfunc parameters. Retire the flags
from the kernel and resolve_btfids, and describe the arena allocation
kfunc arguments with __arena suffixes instead.

Suffix conversion makes the JIT responsible for translating the 32-bit
arena offset passed by BPF into a kernel address before the kfunc call.
Translate the address back inside the allocation kfuncs so the existing
arena helpers continue to receive lower-32-bit user addresses. Keep free
and reserve non-nullable: an arena starting at the 4 GiB boundary has a
valid first page whose lower 32 bits are zero.

Split the JIT capability hook because kfunc calls and struct_ops callbacks
perform opposite conversions at different boundaries. Add kfunc argument
rebasing to RISC-V, s390, LoongArch, and PowerPC64, and add the reverse
struct_ops conversion to RISC-V, s390, and LoongArch. RISC-V and LoongArch
also need independent fixes for stack-passed arguments in indirect
trampolines.

Extend the shared arena tests to every JIT advertising each capability and
update the conversion-specific expectations and large-arena coverage.

The resulting support now with these changes for __arena suffixes is:

  kfunc arguments:      x86-64, arm64, RISC-V, s390, LoongArch, PowerPC64
  struct_ops arguments: x86-64, arm64, RISC-V, s390, LoongArch

NOTE: The individual JIT patches are not tested by me, and need the acks
of individual JIT maintainers before they can be landed. However, to
truly retire this flag, these changes are necessary so that arena kfuncs
for page allocation and freeing remain functional on those architectures.

Kumar Kartikeya Dwivedi (14):
  bpf: Split arena kfunc and struct_ops JIT capabilities
  bpf, riscv: Fix stack-passed arguments for indirect trampolines
  bpf, riscv: JIT arena kfunc argument rebasing
  bpf, riscv: Convert struct_ops arena arguments in the trampoline
  bpf, s390: JIT arena kfunc argument rebasing
  bpf, s390: Convert struct_ops arena arguments
  bpf, loongarch: Fix stack arguments for indirect trampolines
  bpf, loongarch: JIT arena kfunc argument rebasing
  bpf, loongarch: Convert struct_ops arena arguments in trampolines
  bpf, powerpc: JIT arena kfunc argument rebasing
  bpf: Replace arena kfunc argument flags with suffixes
  resolve_btfids: Drop KF_ARENA_ARG flag support
  selftests/bpf: Exercise arena arguments on every capable JIT
  docs/bpf: Document split arena argument JIT capabilities

 Documentation/bpf/kfuncs.rst                  |  15 +-
 arch/arm64/net/bpf_jit_comp.c                 |   7 +-
 arch/loongarch/net/bpf_jit.c                  |  98 ++++++++++--
 arch/powerpc/net/bpf_jit_comp.c               |   5 +
 arch/powerpc/net/bpf_jit_comp64.c             |  18 ++-
 arch/riscv/net/bpf_jit_comp64.c               | 139 ++++++++++++++++--
 arch/s390/net/bpf_jit_comp.c                  | 118 ++++++++++++++-
 arch/x86/net/bpf_jit_comp.c                   |   7 +-
 include/linux/btf.h                           |   2 -
 include/linux/filter.h                        |   3 +-
 kernel/bpf/arena.c                            |  40 +++--
 kernel/bpf/core.c                             |   7 +-
 kernel/bpf/verifier.c                         |   4 +-
 tools/bpf/resolve_btfids/main.c               |  22 +--
 .../selftests/bpf/prog_tests/resolve_btfids.c |  22 +--
 .../bpf/prog_tests/test_struct_ops_arena.c    |  16 +-
 .../testing/selftests/bpf/progs/arena_kfunc.c |  36 +++++
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  16 +-
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
 .../selftests/bpf/progs/verifier_arena.c      |   6 +
 .../bpf/progs/verifier_arena_large.c          |   4 +-
 tools/testing/selftests/bpf/test_loader.c     |   5 +
 22 files changed, 487 insertions(+), 104 deletions(-)


base-commit: 669e4fa766000ae4137bb02eb22ce75ba78ad32d
-- 
2.53.0

