Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44713DDAA
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761479; cv=none; b=h4GELt9npF4KfsqvsDQL6LI8DYPotGPUdzhDhFtgqUkMngSq0JogqR7S9KP3h02gSDKjIinMFBqop9uxFQZUqMaW+Mdxir6gi2S29/Jk9rZKU8BfCa3xMsfSIf6/1qdASyBBiApA3NQxVfPl947/Vn/jsUVVoFUs/TMS4Yi+kL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761479; c=relaxed/simple;
	bh=VoXeMu5vERJEUjNyjuAO0hxbL4rdbkY2AFltVsbJEYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmY9lYqOvexiRAPY4Yov0pHMlkyqtsUycFsLGhjtYvoW3yfRAuLnFpM6MTVq40aEoxPsZO+7QCcx41qMnFGCZDywuNn3Kn8iJ+7BbIUWwgWn5zXjvCc8cdnm6elcazgwqgf8/HnupWhsg3pbLMRcbtg4N30U5kXSAuudkGpBiPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEGiYVIX; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEGiYVIX"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4955e5274cdso3106025e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 05:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785761476; x=1786366276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYFO9hz745bvDOoCpASaTvO7Bycd1mLZV3k9MTWt/lM=;
        b=ZEGiYVIXgJJzvaFKAZK1J4Qycv/W2OuG5bGTjMeCgVU6/MqiO+KAWBXZ8NZJaRKOT1
         KYRwSermcqsaOtxiagaBHF1Rg2ohPCyc/rAv/1Z+LgsKMW/zRuTzEUBaxBvLRqkoITBx
         jEnVG+5wgaQA7R5KWLihOqywS/JkslaPLEXre93Bhc1yVMLMaKsl6g6gzr1UFhmasg94
         E81cX+8VRgrBx8l24G4BCJ1xX7rVp68hqSn5J8AoXnOmerhy48a2gnUhtASlSxT1bTRG
         O6YZIJ9JRbXu0e9/QQGbEQRT7hYZ/BI+HXYgwd3bLo9Yrf3X+KtlJmkNIGWvZMDbi1Jz
         yQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785761476; x=1786366276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYFO9hz745bvDOoCpASaTvO7Bycd1mLZV3k9MTWt/lM=;
        b=nccPmV8uHK/CNm2aXgbBvm3jACUEtHOMPqbG107yTVm6VZ2YKsUwZGSKDGHQBGH8P5
         MxCF3VPB7Cpg+YkDTnv/v7N9Df2LVt0CUL2VZlWAsNp2YjmKbgbjkfOGBrb5Xq0B9M4V
         bi9p6nd1XM+v0o8Cyzzvqfr6P99kH0PBjPZe757xz6EqOffurVBwXFm3E2yKOSML38LZ
         cUFdbfzMazgqMSIogdGPPq26NVgOj4b7RLbMH3IuegrI72VnWTsS18TS9cQ7UP8KR3J8
         fvpwvxBa6PxBLuC0fxja81Hns8bQvERFKnuZ+h1usoaBp3uG9zvnY622l926hC3VpPrF
         JfUQ==
X-Gm-Message-State: AOJu0Yzsz+4mSI+7X1vJ1OaAWDwEoLBHmSUC3XytEMi1iEBswsUHSGN+
	9+VHVFDeJF2vTDv76IeEY31DaYVgq1MR5j+opb9+v5BvR/t8oXmT8u9x+bFadhMV
X-Gm-Gg: AR+sD10SnlnPv4kyQsVEqTzO3EQVmavHd+BPn12vod9qhsv+mLkBcmQy51ZakMbEh3S
	jW4OeUPoiuWE3eJiy7kXHXzG4S4c943OPDke50RrmYKpsLH6OKdsp4xcokvNZhHn1OpmWMUE4gx
	wpQdk520ELNI4A2xMQcxjShg9tttYRLTEESLJtVAhWXlHdYpF9n3+txqB7ld+BAhtChooHoO4w/
	o/g5vphuFLcIyvVsTcMXaqju+son61huf2LYKKoiUxQypieU383LoopMxs1hWVojE3wNVRvLXzu
	83k5NyQbuTpd864ceEP2ya2GTyQX/J79uEMb1ESPpHghkTq0BsJLtWNOHSKgZd4HBPVa6IlDzRE
	dr+8Zk2AFwCsTUj/kjP0gOhRwCwupGylBSfKmZ9UXgw+VeVQO54svgUyqqiRGa3T3EEa9BgJkPA
	aVV0RACPPxc4Paj4r0WAWy0G3vYViQNKiNdWZ5si18+GsvlzVttFP0L/NtCXD2g4ZdMaknmhkrL
	ONsFln0eaeMGo2yC9jnDpj2zUtVgXztugq5V3vVJAyZLLgkQrDG1ow/vjDes/IglcnEhUBB3IfN
	pHN+eR0p3+5JMMU14ymHlijyLYE=
X-Received: by 2002:a05:600c:840f:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-4980c6507e7mr201512535e9.14.1785761476144;
        Mon, 03 Aug 2026 05:51:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b21e66sm204413825e9.0.2026.08.03.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 05:51:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/9] Add arena argument support to kfuncs and struct_ops
Date: Mon,  3 Aug 2026 14:51:01 +0200
Message-ID: <20260803125115.2264733-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173; i=memxor@gmail.com; h=from:subject; bh=VoXeMu5vERJEUjNyjuAO0hxbL4rdbkY2AFltVsbJEYA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIaugb+MdTe76ojVroxj7M9J2zprVesPTrk7Te8ac20p3t zLe+/aio5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNRd2NkuO+xiL+yOyP394a1 Z7miDfasnrm7f073/SaZhYYqFpevGzAyzO8+s3BXZjJfdtrrmlsGCwNf28Q3KZzglLLI3bVRfB4 DAwA=
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
v2 -> v3
v2: https://lore.kernel.org/bpf/20260726013105.3689867-1-memxor@gmail.com

 * Rebase onto current bpf-next to resolve conflicts.

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
 kernel/bpf/verifier.c                         |  63 ++++-
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
 19 files changed, 1062 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c


base-commit: 60781269e26c786de2bb93fb1e697a5c32ccee48
-- 
2.53.0

