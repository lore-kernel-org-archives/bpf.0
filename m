Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337415665C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958328; cv=none; b=Bk7rrQSBiGVzGqGaXP9d4zhpo7eiUlguOCs909gekgNgmO6URlcScIrsKZPOD4zDST1VM1Uo2726y81zge+k+UsRwV62pbrnU4IOlCLrVeqRBO6n2Y7ea1m4Lp9JHaX3QXjZLcqhFp1AoyiDFt43801W8BeLzinPs9R0/IRUhp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958328; c=relaxed/simple;
	bh=gcNELYFOcFO2Eba4ZNdlLgil9eSf0lr44FLYfgcg+a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6vMI78AW5eAh2f1MoqUs5vSvhgo4edpkLrLU9WhZfwwlpY0NoJivIfUcSlpSlz/Tb2tpFWyTt4qTvW+J4ksfgwID18ZwRaiDtTuoN95gSaAxKFHVwH7PZv9zpEuSfneDr8uOk8shUjinLhlWK9xCT2LaR9qhy2SjuM7+5LaZe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ol9B3fda; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ol9B3fda"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so5842655e9.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958325; x=1790563125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hEzvr6nU+csO1cZct3+FKNe58iydsDIo9Dr7d5cc8A8=;
        b=Ol9B3fdax8sStz8bpAt7bUfskC66QPRkRnTQDNgfrsppXjYUzeHWsqmJ4sAVcSrILp
         qQE0M1osevhTs+/NVve2XiDy+KDty+Bkzl7n/Fb8fffw0H/T4WAVRKhipNHZzT/KrRdq
         eFXkHukHX5gdHgkRESb0ORCFbjRIzOU4Fd8RjqwyCMRmNroGAZ13vigCCYqBA1WBLGgW
         ZvScN78SiD/8SuD1yFIl5V6b28RqqIj6jfe9Vf5yHzJ+HkKciev+V0kvvAVMQF2vnddR
         x8yfgF4EfCyvzCD8tWe5xhReDYSdhJZu/6kXYUQe80HNMBj3RNggf4CxdAYPBGz2XT1h
         ZubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958325; x=1790563125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hEzvr6nU+csO1cZct3+FKNe58iydsDIo9Dr7d5cc8A8=;
        b=1bvQoh7XnfXJNfnNilVBsRmqV9vS6xCBdBk5RkYeT+k3nxOeRzmzMgkDwXnDADYs5P
         M0WGCZFDYfBzACnvfeelBlAD/m9oV0M8D5uGveqfcTRVocetQBydsAzLpe22TQgNvxv1
         CqAVZkVXGtvCzm2APyEoe4YlGbpI8Sh0Sz3wyOzOITnWAd4EEQJscVdYzszDZ1pSVIav
         SSREbdBSdX3QqvYVajkjxT9yM0yuUp24dpLq63nQdoqHlI2ab21KrmqxV/TNJTc8KIN8
         pgrJivg4xzQMW6Ayl4kzTp5Vx5e1XdtqDfZayqyGtx6ZqkLkewAE+mH6jgpHYODOEgmH
         ZVPg==
X-Gm-Message-State: AFuF++kF8Ji9vgqh+KS8I76aQSRbRH7ZO57sBGCcmzuhZ2uVm4aIG9Vh
	83ACJYD2bPBJ/QA/nLrgfSbhwtJc3nuo2Y34GdlUhkmS2yJ7zL4suwf1A2pNgPRN
X-Gm-Gg: AYBFou33eyR+KUyZ15lU5gIVw6xRH0SUIjNaAONGare3CtBVSga3lowm+XTOVM0BSAW
	uhX9uy+uISl/JqMzSIZ4LLCtM3hiaRjyQFK228GqmWn5ExLe1bv2vIayna1yUDGU5P81dgcYbcD
	sbRlfujDYTOVdkJwjHKeMHo6a6sTaTE69djPaFEOt3uCscfUdPl1167/w9JWNS/eO5qWgs1hDX+
	edeFcgcKVLK5LSWFK6efzQgBJwq4pLhZmtm581dcmh6RAj4hv5ed30lAPa8XBj9NB7d6gzFloyy
	CvwkN1nf29AbpxnJ8OCEfk5X76VB0c37czNMHMbTN2r4UQre/PR5Ha1UQ/fEblDeSfUd3ZsueYV
	sFMo8j2tiVIfdRTOEe1O1Q9VgZlACSbm9C54/Por5pPj5iaSn5/u2Pr4K/EMbA4Umyz3+ZtANma
	pst93L5zum+IUfesgU/anbtUL112eAlaRsH5CWCMm1h0KSNa002LU9dSvtznh4SByjQOIZDujrB
	RMEkf4PCVIEluhEgO2AkDndvC1HoBXwZnuoJH7EdHZiA6bBqJk4813i8pz6fRlg03XpoBsjO+OJ
	YgHXRj8s8fEJe6gxtMJbidSsaVdcH0IjBALYzw==
X-Received: by 2002:a05:600c:1e24:b0:49c:fc6e:a3d2 with SMTP id 5b1f17b1804b1-49fc574f74bmr124769285e9.17.1789958324756;
        Sun, 20 Sep 2026 19:38:44 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc56eff84sm218263475e9.1.2026.09.20.19.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 00/11] Fix generic __uninit kfunc output buffers
Date: Mon, 21 Sep 2026 04:38:24 +0200
Message-ID: <20260921023843.411943-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6611; i=memxor@gmail.com; h=from:subject; bh=gcNELYFOcFO2Eba4ZNdlLgil9eSf0lr44FLYfgcg+a0=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvD9I3Pqh0WC9cmbPRL39PTsPxF1rV5Fd6Srw6k/G3dW RZ9mK+to5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNZv5uR4VueYMDHV0V17g3t lS86S6qTP7bK7zFQvbznw4K8J/nzZBl+s3T+7nLTm9c48+CEefm/3ybcyeIWvS+/N1Yqc4VWvyA bDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Generic __uninit kfunc arguments are output buffers. Stack liveness treats
them as writes, but argument checking still requires readable contents and
does not record definite initialization after the call. Check these
arguments as write-only and record privileged output initialization after
validating all inputs, including inputs that alias an output.

Following Eduard's rework, helpers and kfuncs record generic outputs in the
same argument-checking path after type resolution. Generated kfunc
prototypes now mark generic buffers with MEM_WRITE, so __uninit buffers are
checked as write-only ahead of the fix while ordinary buffers stay
read/write.

The final two patches derive memory access from MEM_WRITE and MEM_UNINIT
alone, so input/output helpers such as bpf_check_mtu() require read as
well as write permission without a new prototype field, and add the
permission tests.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20260918052906.12226-1-memxor@gmail.com

 * Check __uninit kfunc outputs as write-only and mark generated kfunc
   buffers MEM_WRITE, replacing the kfunc-specific access override. (Amery)
 * Derive memory access from MEM_WRITE and MEM_UNINIT after relaxing the
   MEM_UNINIT contract, so partial-output helpers keep write-only map
   destinations while input/output helpers gain read checks. (Eduard, Amery,
   Sashiko)
 * Move the helper read-access fix and its permission tests after the
   MEM_UNINIT relaxation, and drop its Fixes tag: it only closes a
   write-only map permission gap for input/output helpers.
 * Reuse the raw-memory predicate after type resolution and clarify how
   argument ordering affects output tracking. (Eduard, BPF CI)
 * Keep prospective struct-output counting separate from raw-memory checks.
 * Clarify the __uninit buffer contract and privilege rules. (BPF CI, Eduard)
 * Add read-only FIB rejection and partial-output write-only map coverage.
   (BPF CI)
 * Carry Eduard's Acked-by on the generic __uninit fix.
 * Allow partial initialization for all generic MEM_UNINIT buffers and
   annotate partial-output helpers with MEM_UNINIT. (Eduard)
 * Preserve per-byte initialization and prior stack liveness for generic
   outputs when uninitialized stack reads are not allowed. (Eduard)
 * Retain output classification when variable sizes disable raw mode.
 * Cover stricter readback rules for full-writing helpers and kfuncs.
 * Retain helper-argument fallback coverage using map_update_elem inputs.

v3 -> v4
v3: https://lore.kernel.org/bpf/20260916192805.3991983-1-memxor@gmail.com

 * Record helper and kfunc outputs after type resolution. (Eduard, Amery)
 * Derive generic memory access from flags for helpers and kfuncs. (Eduard)
 * Fix MEM_WRITE read checks separately and add permission tests. (Eduard)
 * Remove the output-count validator in the multiple-output extension.
   (Amery)
 * Clarify argument-slot naming and move its accessor into the fix. (BPF CI)
 * Add the unaligned header and order the new test registrations. (BPF CI)
 * Shorten the kfunc fix description while retaining its rationale. (BPF CI)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260916160821.3157543-1-memxor@gmail.com

 * Reuse check_raw_mode_ok() after kfunc prototype generation, including
   struct outputs resolved to generic memory later. (Amery)
 * Remove the now-redundant kfunc output-count check in the multiple-output
   extension and simplify the helper validator.
 * Leave the stack-passed output uninitialized so the reduced-capability
   test detects missing __uninit handling. (Sashiko)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260915141004.1196460-1-memxor@gmail.com

 * Separate the single-output fix and tests from multiple-output support
   and its tests; reduce coverage to focused cases. (Eduard)
 * Skip inactive output slots before looking up argument register state.
   (Sashiko, Amery)
 * Separate sysctl restrictions from mitigation-related test skips.
   (BPF CI)
 * Use an int-width initialization store in the alias test for big-endian
   targets. (BPF CI)
 * Centralize conversion from argument numbers to slots. (Eduard)
 * Share clear access-mode selection between fixed-size and sized arguments.
   (Amery)
 * Clarify the opt-in prepare/load capability boundary and retain the
   reduced-capability alias rejection test. (Eduard)


Eduard Zingerman (3):
  bpf: Record raw memory arguments during argument checking
  bpf: Check read access for helper input/output buffers
  selftests/bpf: Cover helper memory access permissions

Kumar Kartikeya Dwivedi (8):
  selftests/bpf: Allow privileged preparation for capability tests
  bpf: Check __uninit kfunc output buffers as write-only
  bpf: Fix generic __uninit kfunc output buffers
  selftests/bpf: Cover generic __uninit output initialization
  bpf: Support multiple __uninit kfunc output arguments
  selftests/bpf: Cover __uninit kfunc output argument slots
  bpf: Preserve stack initialization for generic output buffers
  selftests/bpf: Cover generic output stack initialization

 Documentation/bpf/kfuncs.rst                  |  27 +-
 include/linux/bpf.h                           |   5 +-
 include/linux/bpf_verifier.h                  |  13 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/helpers.c                          |   2 +-
 kernel/bpf/verifier.c                         | 167 +++++----
 kernel/trace/bpf_trace.c                      |   6 +-
 .../selftests/bpf/prog_tests/verifier.c       |   4 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
 .../progs/verifier_helper_access_var_len.c    | 332 ++++++++++++++++++
 .../bpf/progs/verifier_kfunc_uninit.c         | 236 +++++++++++++
 .../bpf/progs/verifier_kfunc_uninit_multi.c   | 113 ++++++
 .../selftests/bpf/progs/verifier_live_stack.c |  33 +-
 .../selftests/bpf/progs/verifier_mtu.c        |  88 +++++
 .../selftests/bpf/progs/verifier_raw_stack.c  |   4 +
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  52 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   8 +
 tools/testing/selftests/bpf/test_loader.c     |  48 ++-
 tools/testing/selftests/bpf/unpriv_helpers.c  |  16 +-
 tools/testing/selftests/bpf/unpriv_helpers.h  |   2 +
 20 files changed, 1046 insertions(+), 121 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c


base-commit: b99f71407ce529ba01a9392f477522d2e76c6613
-- 
2.53.0

