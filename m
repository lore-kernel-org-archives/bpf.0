Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8F2DF134
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424719; cv=none; b=KaL8m6PCiYK3VrRGKm2o4I9e+jh/QLtBnkcAWG22GWrW5MThqdNDahDegRHf0KEvNi7KAiq9SnKWe+WTQT9IgDzPuQEhT2MqgWs2EUCLXQl0fa2f3vlL81jFJxoZ8rkUT7Xp+650aDcad9U7iJgOyWVKadPn/+iepIlCKQeTc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424719; c=relaxed/simple;
	bh=nRuEA55S6czfAU83es5FcdVtIONJ2sQJ0AODRz7vgpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2gheofi954G3JGKQouFC/Myz5t35j6cdd9c8r4pnzIepQ7J8LxrE0nbfk+ML8ckBR7hlFCkItG0TByl4JaUxfdlXl09eSuMdEEloRPqc4P7kxLCGLAiVIKgayHgbHZoTMMiqevZjWk3acZhEVf5qPRDM6wd+yYhuX1dS2aW6WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b60kVasb; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b60kVasb"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so8198585e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424715; x=1790029515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1V/k3KrlhwCl1l1wjSPgBuYbddbeAgBNZn2iNq6Dwzk=;
        b=b60kVasbuWEzNgkBiB75JJa6Yv47ut+wSOQ66dH8+nBYIH3SHdlx4Cx2flL3cbX64D
         T4rUS1K9AflWjtE60kZ+Rhr79A21zHap+uEt2UNSNb2d/ReM8xsy6rxmoAsfJIfh/4Mg
         1SURR9cEuKY0aVgC30C3yr0UIyUKFyd7DFVc2zTylQMs14J8jryohtJKYiNeuC0Q847y
         TKJY6Qhy595sJTqxEPC1ouKvoeZrhOKq+tUc7EpaEE3blFAFu75Zie6RwL4Gq5PLaLL3
         tAWxSOIOiEhU/QhQymMVyHy2W3Y9HORQ1ENknga8U6aIMKvh06nNzAcTUzPRVNeX9WPI
         pU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424715; x=1790029515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1V/k3KrlhwCl1l1wjSPgBuYbddbeAgBNZn2iNq6Dwzk=;
        b=Wfh9EvbVGyvMkRMHDqErUtetgNtBbO5l4EnR2gor3nwFtmgt7uxKRwyL4b28EAq2Xi
         /4KvQ4OGz2B4tskAYmcND9e9q8I8ra00eGgvLvIoexN2IWmrlCMnLPnW1MRVOdpVIslN
         OTT6dNB4fRxNAeHteAt0L6V4iKJGxX1ttKa4zIdtTeuruQiGJLBdhKxO3P87+irMn/Bo
         naAnEKlcsqTDOj+Qf9dv5YmYKE2ROZzlFC6IqoySnrDThLq1RPZp4arBLIm7+78Qqx4T
         Z33n9k8/ednVp9mvCjRba1Was50DiNfmsL72JRKiS6jDWiNdlypzgYY6co1v2QAfU17m
         qMtw==
X-Gm-Message-State: AFuF++npHgFSVdrdzIdp8jmxE3wCvzpKY3gTZFN2JYa7ugsq7OWq/CnE
	hv/Z3FwNwSWG+yfMssUoAb7Ev/kVP5FlBTZT/7TM9j47DzODR3TaS/UzzjMvTLg9ydM=
X-Gm-Gg: AYBFou2Xu+3kXTZ5Co/jGtPDkXPopnq1Ry9Op9DV38UGgOWLB8gl3tUTKqtZlHT6RPF
	D32B/3OQOtVKHmL1AFg7MeMq/ZBU4RjAz8YBXruiYq+djIZIB0jRhn75aMgj9+MSBIkhxr2Z01Z
	JOr3ZN0YQL0NKCz31dbi5Tsq5VLu1EQhPbkpa6DQR9uO06gOgrGVrJr8w87sUcZnWrNDa+lRkVf
	umsEjTTwNSdLfq3/wGwTRa67sggkoSWfieG4NPdtGVS5on918BBszs36M/tWK7Yp/HZEpCQ32if
	XeKsmfZ7nVRAQHrOS4GyZMxPrlo/ePdOh8x+S9bENoTHVHJnjORVZxfqQPPOSD18IjCWdhOBgws
	nc8GyMtyaCqNpKootnqEX+ZJq0JHIf3AbbiCuBVqXiw7/WZBVjB3Mhi8TFYLpkHBTmRO448gihF
	XieiwXz9JDKIcUoyeTpABVZo/2cxKraihtoM2uRAciha5dmr4cJ2nYMog6Mag1L8CJc+7onKsOz
	Xc/S+u5iI0zzuqaB1ok40FTJbzl23gL/YklSJ/OehmqN+CjvLX5G6+brv2gegliy4GCYIr+QQqm
	s1CsywHMBwzfJvx/zjJfG7q/sqOkUzVUXts2jQsfcwJy+LN4
X-Received: by 2002:a05:600c:3b0e:b0:49b:d03:8d3a with SMTP id 5b1f17b1804b1-49e7a64894amr54985575e9.11.1789424715326;
        Mon, 14 Sep 2026 15:25:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef735cesm10402425e9.6.2026.09.14.15.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:14 -0700 (PDT)
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
Subject: [PATCH bpf v4 00/11] Misc bug fixes - part 5
Date: Tue, 15 Sep 2026 00:24:57 +0200
Message-ID: <20260914222514.1635018-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4576; i=memxor@gmail.com; h=from:subject; bh=nRuEA55S6czfAU83es5FcdVtIONJ2sQJ0AODRz7vgpo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFic5+h823F1qFrHRhmuGtuMuT6f55lTs5FXUdu/ct7 7iSEPS9o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNpimRk2K9f+to0vWbbciFx xZUt62adbVI5JVllviqBXVvx9tS9sxgZvr6J375MLlzMP+jgUytL4zzvmZF7l4osS3rWvGJbrVE 9MwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (11):
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
  selftests/bpf: Add truncated CO-RE ldimm64 test

 include/linux/bpf.h                           |   2 +-
 include/linux/bpf_verifier.h                  |  26 +--
 kernel/bpf/btf.c                              |   6 +-
 kernel/bpf/check_btf.c                        |  14 +-
 kernel/bpf/core.c                             |  21 +-
 kernel/bpf/fixups.c                           |  24 ++-
 kernel/bpf/states.c                           |   9 +-
 kernel/bpf/verifier.c                         |  20 +-
 tools/lib/bpf/libbpf.c                        |   3 +-
 tools/lib/bpf/relo_core.c                     |  69 ++++---
 tools/lib/bpf/relo_core.h                     |   5 +-
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 192 ++++++++++++++++++
 .../prog_tests/core_reloc_truncated_ldimm64.c |  82 ++++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |  33 ++-
 .../bpf/progs/core_reloc_truncated_ldimm64.c  |  27 +++
 .../selftests/bpf/progs/test_spin_lock_fail.c | 167 ++++++++++++++-
 .../progs/verifier_xdp_direct_packet_access.c |  35 ++++
 18 files changed, 657 insertions(+), 80 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/core_reloc_truncated_ldimm64.c
 create mode 100644 tools/testing/selftests/bpf/progs/core_reloc_truncated_ldimm64.c


base-commit: ee363e055895364039bf28348ff13c615afad4ba
-- 
2.53.0

