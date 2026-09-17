Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2F5395ADA
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643506; cv=none; b=oMGbDdWgXsbwOStQVWZbzs1oC6If8r/lql0oeXc0tLWjqSjJYn80AqDWo0CtLYbviUIZrhC+AtjbbxIWtwrdQXzyuEJIdpGpN773LucbqpcozL+k3/BfE4OijVg0meHxUwqke+O7agCa9nDKl8PD/6muO7lWFF4RPwijkC6py5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643506; c=relaxed/simple;
	bh=AhHvs/dfFSWvhZDEqpl1YEOx+3qJ7mSGDnhyPKqANoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s/jaHm3SRIvLqpxRecGEfRKmy31M/jf9YkPpyliPfki0HjwDA3pUWBsS7GqnZvqhzLhvmtp47F2gvDw03irNVwvW/wPZaoA9zZWaU7xVwZ1cU3jOz8zvev1LeeVAclTIrRAVz7anKDfn+A1bPbUaon2+1RwaFMO9z7MQRK0GNNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2hh8sfr; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2hh8sfr"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso2535185e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643489; x=1790248289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNTyS3U84khAdrTT+FD8bh4Quh4V9UZOA3zQRPTcXQM=;
        b=V2hh8sfrTt83sbhgczmFm4RfiqeEbAviq41inGUe9CxLMSXnlruxmrVNm+9CH3B+ag
         ZN+JYlcq5DcRfTwh+GCEivUZDISUewjxZK+75o5bfqR+o0dwHFDkEbzV9nhEuGD67I+f
         IgsmKG9FIBw2xE2BTxbqgrvkItMQLESCa2QBWMkwsFRFIgAoVOZTrWFRZNQ9pkoNCqjK
         /M9hbyNvwYZmDtl93fwrn7itkxYRAgj53kuu+OjPPkXG6if3Ty9N46Az+MFPps0+AZpM
         7WaQUk4ACrOsIs3URL3KZUvI7/6FdeDu3CXNBqT++i4cQffgO5mXzBIjLLxE5Oa9bhbG
         FJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643489; x=1790248289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNTyS3U84khAdrTT+FD8bh4Quh4V9UZOA3zQRPTcXQM=;
        b=ZWXWkhMSTFLVe9QFsNd7hRK0qzLko2dCkq8J2pbM6X8Uz8Ne3PJsZs1WNTvryykq1I
         jLaAIH9rRwDyQ9bMyaSxn5Rrjl0mjeMouaVr3+AcvIHu8MgBKjjLV2Oa9cwgCx2XPvfO
         YJKlzZu+9Ubx+sQc+ou33bS61JTsrBQwUlwWvbSkRkFCRokWZwLBLcCjkZ54DBiJAprg
         z0K/oiA4jr1V3VZEyY2EXowdTDdfLlYTDBWPctSinkGqwmd+HUXxU2vkkOpJjYTJiKSL
         /J6MKdQbji59rTgnd5Z9rqNHbsqpr3AFudqlm25ToVqkSp3lFO9VsLlm2TnvFF+3kBRP
         lUaQ==
X-Gm-Message-State: AFuF++mnaKULlspSzeBCMsQLrpG3NlzarKvtmpdfukb06UKw9g4a7oEU
	w7hy0Hyn4LW/hauUf3Mtsv5+cblkikpU0rhhPK3ZZhjaJ8i6az1TDSTd8FdVrYaK
X-Gm-Gg: AYBFou04tGMVwyfQ3wi3P/lnBBlGOXeUX6wJYMq8N6lHUBBfKMtWSUOpH7txvRJMwj2
	7EH1xLBlRmvlbFkTtd1kGqRssFtZOhvBqpQWHg85kbwNBuLJ4MStTD2rQ7k6aGEj0GwZgZEwnR8
	dPPLR/Q4/iycMkY1v28A3OWqQAL7hRVi7b+ictJKMfTu5ZdKq450/ZqwlkRjRzQxwWZixn0ZGYV
	6Jeg1lKTyqd4nskyaMpsOBGcWmLluoch2o78oUH/yGnZYhd95qUw4KIAzSaQEMtYfzJ4AqacPLq
	4iKN/NbogU2DJj0MrJAgmXdLGaw/fTsRNfcBdZsAvRsUysIBaVjQzM/7V0lww3Q1xxoBtOzyWfz
	uCfvj2215Fw3Ma7Zg1amPMon4EAeiyhgV9/rA/OMoYdJvXdbPPt7RSiU0L0Di9EmLrIQIvw6EPv
	B0zaYLed5is8jt64WssWbZckIK8DQ4Stq/e9ZB6B9ug/bgmg5kWNYAtYkqg0CG3gXLgAPebKWXv
	CBV0S5CYv5Q6qlQ0MxgBE+J/hGqKEAHj3iDYeZpkAbGAJtXIfY25ACVNWrBqJ5iP7dU4bC+Kgsc
	+SgVUUa91fyoZOQ+9UOTrCrdxPtFJocXB4o9Kg==
X-Received: by 2002:a05:600c:5489:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49eb7340a28mr96567515e9.16.1789643488511;
        Thu, 17 Sep 2026 04:11:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm69416955e9.0.2026.09.17.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v6 00/10] Misc bug fixes - part 5
Date: Thu, 17 Sep 2026 13:11:12 +0200
Message-ID: <20260917111127.3780880-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4919; i=memxor@gmail.com; h=from:subject; bh=AhHvs/dfFSWvhZDEqpl1YEOx+3qJ7mSGDnhyPKqANoc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qcQXtRzLZp6dZympO2/nt3zBcvHrFz+dnrZw1SRWr r7XsZ/vdJSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAir34wMvT9fm+252qH3lqG qhwflX01Xz4am5+dOH154iF5r/NiT1QZGd7FPakp6Lbd+Mjyp3eNbkbetPTXi/1ub2M9pPrx+5x SBUYA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Changelog:
----------
v5 -> v6
v5: https://lore.kernel.org/bpf/20260916212102.597335-1-memxor@gmail.com

 * Rebase on bpf/master.

v4 -> v5
v4: https://lore.kernel.org/bpf/20260914222514.1635018-1-memxor@gmail.com

 * Reject a terminal ldimm64 before in-kernel CO-RE relocation and add
   focused verifier coverage. (Eduard)
 * Bound truncated ldimm64 relocations in libbpf's relocation loop and
   retain resolved and unresolved regression coverage. (Eduard, BPF CI)
 * Encode the early CO-RE test BTF with the BTF_* helpers and fold the
   standalone follow-up into its owning patch. (Eduard)
 * Use one fixed instruction stream for CO-RE poison tests without a
   conditional program length. (Eduard)
 * Drop final selftest commit.
 * Trim callback lock identity selftests to the mismatched-value cases.
   (Eduard)

v3 -> v4
v3: https://lore.kernel.org/bpf/20260914131701.2529725-1-memxor@gmail.com

 * Return interrupted main-program JIT compilation through ERR_PTR()
   instead of an output parameter. (Eduard)
 * Apply in-kernel CO-RE relocations before subprogram discovery and
   validation, while keeping func_info and line_info validation after
   layout discovery. (Andrii, Alexei)
 * Keep relocation-target hardening as a separate patch and diagnose
   invalid register-source ALU targets. (Alexei, Eduard, BPF CI)
 * Extract CO-RE poisoning into a returning helper so validated
   instruction cases can propagate its status directly. (Andrii)
 * Restore the existing inner-map UID comment wording. (Eduard)
 * Add bounds checking and selftests for truncated ldimm64 CO-RE
   relocations. (Sashiko)

v2 -> v3
v2: https://lore.kernel.org/bpf/20260905083418.3723623-1-memxor@gmail.com

 * Propagate cancellation from constant blinding through both JIT fallback
   paths instead of rechecking fatal signals in bpf_check(). (Eduard)
 * Preserve packet-pointer displacement by comparing range bases, without
   extending the generic ID map. Veristat showed identical verdicts and
   successful-program instruction/state counts across 2773 loads. (Eduard,
   Alexei)
 * Reduce the packet pruning regression to 20 instructions and force state
   checkpoints. (Alexei, BPF CI)
 * Reject unsupported CO-RE poisoning targets in the shared relocation
   code instead of adding a CFG fall-through check. (Alexei)
 * Cover unsupported poison targets and supported relocations in dead code,
   including both halves of ldimm64.
 * Assign callback value IDs unconditionally and compare inner-map lookup
   IDs through check_ids(); explain the bug with a small program. (Eduard)
 * Move map_uid beside the other IDs and shrink frameno to preserve the
   register state size, keeping the existing memcmp() ranges.
 * Consolidate callback tests into the existing spinlock tests and reuse
   their map fixtures. Retain one-element and nested locking controls, and
   check nonzero IDs in timer, workqueue, and task-work callbacks. Clarify
   the inner-map lookup test description. (BPF CI)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260905070003.3193366-1-memxor@gmail.com

 * Address inner map corner case for callback map value patch.
 * Drop patch 2 since the test can be flaky.

Kumar Kartikeya Dwivedi (10):
  bpf: Make post-verification instruction rewrites killable
  bpf: Preserve packet pointer class displacement in regsafe()
  selftests/bpf: Test packet pointer class displacement pruning
  bpf: Apply CO-RE relocations before subprogram validation
  selftests/bpf: Test early in-kernel CO-RE relocation
  bpf: Restrict CO-RE poisoning to relocatable instructions
  selftests/bpf: Test CO-RE instruction poisoning restrictions
  bpf: Assign lock identity to callback map values
  selftests/bpf: Check callback map value lock identity
  libbpf: Reject truncated ldimm64 CO-RE relocations

 include/linux/bpf_verifier.h                  |  26 +--
 kernel/bpf/check_btf.c                        |  12 +-
 kernel/bpf/core.c                             |  21 +-
 kernel/bpf/fixups.c                           |  24 ++-
 kernel/bpf/states.c                           |   9 +-
 kernel/bpf/verifier.c                         |  25 ++-
 tools/lib/bpf/libbpf.c                        |   7 +
 tools/lib/bpf/relo_core.c                     |  58 +++---
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 183 ++++++++++++++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |   2 +
 .../selftests/bpf/progs/test_spin_lock_fail.c |  67 ++++++-
 .../progs/verifier_xdp_direct_packet_access.c |  35 ++++
 .../testing/selftests/bpf/verifier/ld_imm64.c |   8 +
 14 files changed, 416 insertions(+), 63 deletions(-)


base-commit: 8d9eae69170e6d780da07408fc6471f877cf65e5
-- 
2.53.0

