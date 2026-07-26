Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603126B95B
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029469; cv=none; b=PpdOvqceJHcAko9XqQTOeVyNy4p6+T2n+0eeD6qD899+V23sURibW/CezyESbdpGB2neT896bizMsibKYRghu7R7Ou9SJERO3iCABNEKTyuKcHDe+HMz19g1NKdUP8tHtXNxG+qdnkV9w7gro599WNxS0XJJZw5s5gnZBr8M1Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029469; c=relaxed/simple;
	bh=y95feeClIu0AyYFQxIV7Y92kU4CjBtIoseV+WXvOVx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZkcuJaNZ/WqhK+19OLiRBGx3JMPcsA2Vit3CB0xD/MoQ//rsaOeGhAtuTum6ADj+mSn6nqjNBNLW3t0oxFGk4RtwRSBPbexWv1ubPesC9Ur+e0WtSh7QERsp3ovvs/OndPCYePTMqGzAq4E2zNM6U5Lhfka4qI/Pt5vZUI5YuHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwNduPHM; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwNduPHM"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f8e9b1c37so324035f8f.0
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029466; x=1785634266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GP/RZEooZf5Xh5gCdZvpbx7yIyaj5paBJaJxOHuGUpQ=;
        b=pwNduPHM2zXJXgGftnuZqHGOJ35+ikfDrBtbNJM7yZPGC2nTCPUYmwaz5VyFPAr2B/
         Bwk57mzJXa89V4kO7MB96jVZuP45QJ+iTLbLWQfQHX17Mex7GP8lQi0cXFkMrktMOE4w
         pU+L7tDmcPTqnAw/vFab+dY3+gq1QWWN1w0wLcXSMeuFcdYhi+y96tf+Av0w8y/yoTvQ
         tx00W2EOG5zleRNFLrE/cuVI1LjCXGnlUK+kGe4TP7+2CIQtzyYU2Ipqsy2b8JDoAgxF
         zsdiCNJlqHpDwj3ARMj5798eCZMn4oH6zOaN3Fjm57IKRwPOLnHVMvKt/N64lVmMHlSZ
         c+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029466; x=1785634266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GP/RZEooZf5Xh5gCdZvpbx7yIyaj5paBJaJxOHuGUpQ=;
        b=D1HyKu7uSC0tOLuE6m2rA+13nWhNmmkqGNpyYh4s8H8mst92rQVg9jrILdUVnFNqNr
         /I8LSUkDWEniqTV+/6rZG9GTOCJorS/Oj/jrJGi3hm382KDJv3Ymk9p0GA7prd4mHz8i
         g0ja94+om8ku2cngif/Pq9ymkj2CRiXJGUGXu8hIWmsdKXuS9KDdf1Sh0PmzZ85Zp2ED
         ZSaicel7r9RQ+SYmrE3c6PpArdl0PUtYqlv7NwWdlTBuA+qYbx4jVtZ5c5lTgjN/cL6B
         Xont5m8R4TLY4cbPTR96ubjff4yzMf9XEtIMDjFxpqRWMd5zJtiC19+o+Z5+nyxvHIV/
         91sQ==
X-Gm-Message-State: AOJu0Yy7Kwb8PdNf+bs2lScMkKnuSlp/xQc8TKsAvxnBoLUJlCqvoDNO
	9WMQ+1U844ENG92n842YGvWtTqLkwnI+AJrztq+Fu1QvkDhtMdUH3D953vD6Ih4k
X-Gm-Gg: AR+sD131d96lzseJB5aY7RGykY9rV0HsA1TRwF7eb4ASwhVRsk5dIiOcMT4BwvYyZmj
	AHQyr9CTPag29RMme5G56VX2JGAyPTjLOGL+eDd4X6Ae9ywesGD7qHqAz1Un1+R2R0qK1Kq6fkI
	5eOO9NBWAF7fDeHwvRMkhdsYTPSFgpsAD9gOPoYBoz55PTf1YQ93JDVu8DPjwqAV1cllHdgnva8
	Jhl7bUI4BzqxBR2TxTvV2iJrceELG+aGwwUrbPIaslRlveyKLvyIHf1GqrS0TdRyfIrg21L1TY8
	ied3xrkTIqORi5d8MCcQECNuGD2BN6//Czq/YbubESckIhMvn5Aqzyj8XKsBF5N7m5yUaIvPDsw
	liMQwiOuuDH95ck8uYucqczfb6Xt5wgOU56AsL6HvuaQeijX0tc2LPBtrTQxjQ9PPXLiA6CfsT3
	kys8hAvJcSyoiatEyth+u8hrV8h+01gM04JK57Jnbm6Mnw0N8pGtcDr0lUUkvrsR+7gd/5JweYd
	Ou2YPwKsNUN6BuQl6UIqdllzzgkGVIT5KJ0MwwWLJYq
X-Received: by 2002:a05:6000:2484:b0:47f:7e8f:d62d with SMTP id ffacd0b85a97d-47f9fc8696fmr4747285f8f.10.1785029466078;
        Sat, 25 Jul 2026 18:31:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm37758470f8f.3.2026.07.25.18.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/9] Add arena argument support to kfuncs and struct_ops
Date: Sun, 26 Jul 2026 03:30:53 +0200
Message-ID: <20260726013105.3689867-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029; i=memxor@gmail.com; h=from:subject; bh=y95feeClIu0AyYFQxIV7Y92kU4CjBtIoseV+WXvOVx0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12aJIcF6u2cry/LZXpvKv7nL1HK/1b/36a/a/q19M1 DTXHXjTUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcPcrIsEUpqTf6zW9nKe0b ljc+fblgxLvuqWuP34Xqjdd5Oi/OTWT4Z/Jp/vIQf5ab7un5v9iu/Pyn8ooxYIq7W9i76bqHckN 3MgAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

This is a continuation of patches in [0], with mostly minor changes and
reordering. The motivation is covered in that link. A major change is
moving to two tags (__arena and __arena_nullable) and moving the changes
to JIT to emit more optimized sequences.

Please see commit logs for details.

  [0]: https://lore.kernel.org/bpf/20260713024414.3759854-1-tj@kernel.org

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260715220052.1590783-1-memxor@gmail.com

 * Fix documentation to only mention x86 for now. (Sashiko)
 * Move arg bitmap from insn_aux_data to kfunc descriptor. (Eduard)

Tejun Heo (9):
  bpf: Support __arena and __arena_nullable kfunc argument suffixes
  bpf: Support __arena and __arena_nullable on struct_ops arguments
  bpf, x86: JIT __arena kfunc argument rebasing
  bpf, x86: Convert struct_ops arena arguments in the trampoline
  selftests/bpf: Add kfunc __arena and __arena_nullable argument tests
  selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
  selftests/bpf: Add struct_ops __arena and __arena_nullable argument
    tests
  bpf, x86: Fix stack-passed arguments for indirect trampolines
  selftests/bpf: Test stack-passed struct_ops arena arguments

 Documentation/bpf/kfuncs.rst                  |  39 +++
 arch/x86/net/bpf_jit_comp.c                   | 129 ++++++++-
 include/linux/bpf.h                           |  25 ++
 include/linux/filter.h                        |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  34 ++-
 kernel/bpf/btf.c                              |  28 +-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/trampoline.c                       |  64 +++++
 kernel/bpf/verifier.c                         |  62 ++++-
 .../selftests/bpf/prog_tests/arena_kfunc.c    |  15 +
 .../bpf/prog_tests/arena_kfunc_jit.c          |  13 +
 .../bpf/prog_tests/test_struct_ops_arena.c    |  74 +++++
 .../testing/selftests/bpf/progs/arena_kfunc.c | 260 ++++++++++++++++++
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  96 +++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 115 ++++++++
 .../bpf/progs/struct_ops_arena_fail.c         |  20 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  95 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   6 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  13 +
 19 files changed, 1062 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c


base-commit: 4748a67f711188cbd64bc72c3df636f627858ed0
-- 
2.53.0

