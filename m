Received: from mail-wm2-f4.google.com (mail-wm2-f4.google.com [74.125.225.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CFE3DDAE9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963872; cv=none; b=GQrCfx7gzwrJq8qM3AG2VUTYJijsShRUcdlryt9n/5nAhx4iqiddT0jw8jf/a43PpzBoWYI5w1omC5UAMrmZRFrpxIDdzq3pQZOGwa7pEPpPpkVe4WI3G60v/URcF7HmkID7Zs+pub2ho3bkEz0eyk84PPHRbWyLvoVexG9xc7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963872; c=relaxed/simple;
	bh=YHqCDhuNOu3GmScf1tO/kVtxYwRuvbhEjdBpN8//kiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syNbanm/sKKtujM6wt3frd0vJzNJmSVW92wR/E7JniJgtsHkQMzTUijsDljeIEaxPUW/+WLZPSRPbuSFoVS2BU3988aRdefKrJFl3EPnry5Clx5+lYe6nR0ktsTrGDFaskBkiXngm5GKP6O7TjqXaX6sG8HLNLMYxTzVST2pVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcWnI4Hv; arc=none smtp.client-ip=74.125.225.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcWnI4Hv"
Received: by mail-wm2-f4.google.com with SMTP id 5b1f17b1804b1-4955f00e593so3291545e9.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963869; x=1786568669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fw9HT5GniyoJOjmHTWy+qnm1gsRMsIV1NdjplcGBJyA=;
        b=TcWnI4Hv04Sa6bRKmiDuCBlSZyebHd97mXR2J1kqHunR1OdsaFIZu1UCNKS+h8zTyu
         HL99+UR58YT0RTMuldPc+cVg8Hqd2/g8tTaZfVfBPadGqb8Bz6Zkw0ivLObsqBHdNivx
         VUF/NcxoR/2jPCVz94vuutFZvxzxHKKptjerIdZVZ+agVOnEPQuLJ/ekM+Wkwv/kj699
         hrnE9S9pJYN4ImRASBIna9xbdghCwCj4sUNw/OJa31rwF6FhM9coDxFxFC3cD+LpQtLW
         ILQ2/K2U2K+e7RHuXljfDiYU51f1rkOqVX49TYm14GhXtVfIz6oCFQ/ZxHcPhHhn9LJO
         klxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963869; x=1786568669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fw9HT5GniyoJOjmHTWy+qnm1gsRMsIV1NdjplcGBJyA=;
        b=smdavSwO9YlYHJ3nL7hY0FK9hMxiyPx3m/nk+J41o+xGfiRVVwldhzOtx4wQNGQUcI
         plHjHmjyX6ZU6dFW2hvuYRulEdGqSJ/mJryIqoRsMVzNd0D5uns4hgxafTkqs/8FN65/
         JxwOT7YExDsb0TrlZ7TS8/NnOE/Uc0QPr8inQAIVZvfp+mMsI7vSX4v+U/NmV/ocM4G2
         2Ta9gv/z7qhbGIX+nxOVegtLHFJVwP+10unMSiTlhpSkQqgiKvNnCtKHYqYdtmGUAibX
         PM/sdqbCME4K3gc4YGzFmvlFjJaMH3HwracGG8I9JUQmFdPPE9i/Q+oXtdW9MTWJPhfi
         B5aw==
X-Gm-Message-State: AOJu0Yz7NgdzM1y7le2Nc9ppWQtknwf9Gna6f2jcBiTFs/ApmLqvM+0r
	mE0NwAUTmkfizg4Pebp0dXgibAsrvahjWpVcR/Nv73KCXKPXimYHnRX1fzdUN8oV
X-Gm-Gg: AR+sD10cLGa/cZ7bA0uwgdFGgcZMAEzc9DMW3snAzTE7InHuMlAn2SwdDWqEDaLqI4s
	7suScnEIt+iaPCMGqI8g0jZ4QTwq72DYgN6C2GuolHGRJMgh2pxh2jwIiK++QeCvoRBjFNxe8C1
	+zV8PezjSkLA4jeYucdmaL1H04MOlu83LsrcLO9SyfBvgYiRju1hSimxPCRSJfXj2gvztT6YTsj
	YKlATll0yLLyJLP+Am2uOS1DgJYwfaJ0x2aD5IrRMQfjSUbQ24iQUgcBiYiLNuO/m8YqUoieo16
	N1Yjwo3mbVc7KWjEAj3bkwkDAtvpZ+vwEHjRQAyp9BfAC9kXOsFVAhNKW3OEc4gBAuZaguGIvBW
	EoaMT6hkyvJ45PHCxduubeOEj7z8sJ972oXjL+5VYvtN9goK4aAaijUGeAH+ZwHEM316KIIP7B7
	/G5G1Nf8Y0Q4zIjdb/qZs1c1dPDKOOOGWUEv//1gMt8zaiTzZaqVN2zv3jPIdidz8lRE3WyZCug
	oNZcOkez8GgWXFyUVuJeOY9vE8aLu4gur/5zHygoeFNV9oXjJm7xMb9mYnM3VuOzWJv8p/tYokv
	loWAic1TJaWZ9If8NxLJsylvefk=
X-Received: by 2002:a05:600c:8b75:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-4994e70a6eamr157945655e9.1.1785963868885;
        Wed, 05 Aug 2026 14:04:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49954206d7fsm8263775e9.3.2026.08.05.14.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 00/13] Add arena argument support to kfuncs and struct_ops
Date: Wed,  5 Aug 2026 23:04:11 +0200
Message-ID: <20260805210427.3218326-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4395; i=memxor@gmail.com; h=from:subject; bh=YHqCDhuNOu3GmScf1tO/kVtxYwRuvbhEjdBpN8//kiw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40aRfvVdT/xYE8AoejuJhTdTn4HFZceNo1euOVXPnd h8xSbzaUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInoVTL8r3682SZf//Bzv7pv pz76SrFVZZvZTb4a66Yewbv/wLvjYgz/VC/aN4fMmXh1rY/wU71DC+8vf+u2Ln7nt8aXD0ovCbb 58QEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

This is a continuation of patches in [0], with mostly minor changes and
reordering. The motivation is covered in that link. A major change is
moving to two tags (__arena and __arena__nullable) and moving the changes
to JIT to emit more optimized sequences.

Please see commit logs for details.

  [0]: https://lore.kernel.org/bpf/20260713024414.3759854-1-tj@kernel.org

Changelog:
----------
v3 -> v4
v3: https://lore.kernel.org/bpf/20260803125115.2264733-1-memxor@gmail.com

 * Rename __arena_nullable to __arena__nullable and prioritize the
   composite suffix over __nullable during argument classification.
   (Sashiko, Eduard)
 * Resolve instructions before collecting subprograms and kfuncs so kfunc
   prototype validation can use associated arena state.
 * Move the arena kfunc and JIT-sequence test entry points into
   prog_tests/verifier.c. (Eduard)
 * Match the generated L0 target and call in nullable JIT assertions.
   (Eduard)
 * Route arena kfunc validation through the common argument-checking path.
   (Amery)
 * Reuse btf_func_model argument flags for struct_ops arena arguments
   instead of maintaining separate trampoline slot metadata. (Eduard)
 * Check the generic-trampoline arena argument invariant at link time and
   warn once on violations. (Eduard)
 * Reject tracing attachments to struct_ops programs with arena context
   arguments whose indirect trampolines convert the pointers. (Sashiko)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260726013105.3689867-1-memxor@gmail.com

 * Rebase onto current bpf-next to resolve conflicts.

v1 -> v2
v1: https://lore.kernel.org/bpf/20260715220052.1590783-1-memxor@gmail.com

 * Fix documentation to only mention x86 for now. (Sashiko)
 * Move arg bitmap from insn_aux_data to kfunc descriptor. (Eduard)

Kumar Kartikeya Dwivedi (4):
  bpf: Rename 'early' BTF checking as a preparation phase
  bpf: Split subprogram and kfunc collection
  bpf: Collect kfuncs after resolving program resources
  bpf: Reject tracing progs for struct_ops with arena args

Tejun Heo (9):
  bpf: Support __arena and __arena__nullable kfunc argument suffixes
  bpf: Support __arena and __arena__nullable on struct_ops arguments
  bpf, x86: JIT __arena kfunc argument rebasing
  bpf, x86: Convert struct_ops arena arguments in the trampoline
  selftests/bpf: Add kfunc __arena and __arena__nullable argument tests
  selftests/bpf: Add JIT-sequence tests for __arena kfunc arguments
  selftests/bpf: Add struct_ops __arena and __arena__nullable argument
    tests
  bpf, x86: Fix stack-passed arguments for indirect trampolines
  selftests/bpf: Test stack-passed struct_ops arena arguments

 Documentation/bpf/kfuncs.rst                  |  39 +++
 arch/x86/net/bpf_jit_comp.c                   | 122 +++++++-
 include/linux/bpf.h                           |  16 ++
 include/linux/bpf_verifier.h                  |   4 +-
 include/linux/filter.h                        |   1 +
 kernel/bpf/bpf_struct_ops.c                   |  52 +++-
 kernel/bpf/btf.c                              |  28 +-
 kernel/bpf/check_btf.c                        |  14 +-
 kernel/bpf/core.c                             |   5 +
 kernel/bpf/trampoline.c                       |  37 +++
 kernel/bpf/verifier.c                         | 141 ++++++++--
 .../bpf/prog_tests/test_struct_ops_arena.c    |  74 +++++
 .../selftests/bpf/prog_tests/verifier.c       |  11 +
 .../testing/selftests/bpf/progs/arena_kfunc.c | 260 ++++++++++++++++++
 .../selftests/bpf/progs/arena_kfunc_jit.c     |  98 +++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 115 ++++++++
 .../bpf/progs/struct_ops_arena_fail.c         |  20 ++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  95 +++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |   6 +
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  13 +
 20 files changed, 1092 insertions(+), 59 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_arena_fail.c


base-commit: 11c1e836710dcba03e50454a4eedfdbaf8d3050e
-- 
2.53.0

