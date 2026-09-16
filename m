Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248E748A2BE
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593705; cv=none; b=mz7A93DH2XrriL5T+DgRegEr6AEpph/gSSgWeg97iYQOUU3yq7ORF8QnTJjrBy0C64BUp8kbJg7odzzSHkDVDva1UjGh2L5euK8xMPLMqH+H8GOnMdgywUw1aR85zxV99tErmGtSI2qiqbWmQtxgyHU/27hNZRdquVZRS1pmmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593705; c=relaxed/simple;
	bh=+QIc50qlqJrXmsRTPADH116UQyzI0fAPllh2VibX0IE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bT3lPK0H2bwujrYDmUgdDswOolOFT6Zv1tAgquH7KG6BFy9cacHfTRucmxue26DmN9AsJ+LvwAQuf56KzTk/Ln0kHScyU4t01fjx1X9WrCBEgAT4/8KqBtaLNVpdQWrAyb8taGsGPFwAH5RpVCCQrwekVsBPlqK5M7VTNIOiZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUDDaqxH; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUDDaqxH"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so755545e9.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593665; x=1790198465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHILoY87q4BXqx7HwFNeoQMkAz1Kq7aHs+QpR6RGrWw=;
        b=CUDDaqxHd4yJL5RnGveZLlO5BLBcHAxRVSSpIKh0nuJsJzy0YF6JserOOsssZu3wp6
         aXfoR1RHvry1BNSsWL2XYHsogeZWG9rZgHCCvQEn25DkBVJo39AK6uHiE5O3iWLoTkD1
         JxN3BpPBUDyK7A55YJNxY3jacu7aPcDiaKFa40hr4Gvx6hCUvI9f3rAjozu1ewq1+jtu
         ZGA4pSiOo6ps40StML/8Bn0Bm5tZ/iHSuwhor+gsYkQucLW2dy7H4761M8ywLjDduomE
         FPPGr6doUAMh21VrJ13mzvMe2gU4lThOyUSVMmDALmRAfz4lvXCkxThOMe/lDKjmq3gm
         EQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593665; x=1790198465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHILoY87q4BXqx7HwFNeoQMkAz1Kq7aHs+QpR6RGrWw=;
        b=lw022yvQUQ9hR14jTYKmyaTK8H3RR79uSitaYTF8+unQZxtEE9hmXRA5iAgv7jn8/Q
         bsJTF/fENjcLsG1Z/iRdSwiTCqaUSBoOuOKoGgUy3O5eWgiGWtknnM4QB1i6qOs3kn9I
         wN8QI5t1c4blVhl12RT7iWJAoYm4/AT38ic9/qFthV/+k5AQxNAVmDRiVtqilEjsf9dA
         NQvolnPx0cM5/qPN8pYG+tHMNeasZJubO6tQiSIRGmF7FPcg3OkY5tK7/2h9OG6FrjfW
         ZlQsk1BUjH3miMziGy4fJh24LXM3KOoNiL0+TIyCFbY+iER1ATbxgUmsbgbRJjb/u9h4
         2XBQ==
X-Gm-Message-State: AFuF++kl0qScrHUihD0omrbBMFCiM+hH83dXxPYYb74Pa9wjhM58rRZ2
	ScThs7NXQWg6d2v4LioAu6favXJvONmwueYK7DYftmdnNYlHZobdfSDSD9AUIbZK
X-Gm-Gg: AYBFou1GNX5aOFu0sEDshOqMjq+fvfH15DMsZAvEsQTWS6Tkx1UEaL33Ov9HGfKamFy
	BcxrUhETkDOBL4Bf82wUdQBAyAuGPtmNQ1sxPYdc8UllNMScSReqfe+Gw2iI5znUkvdoBOXggVp
	Yu/I5VGnGnUEk07r050YlX1X19KU0cGLA0nUdvWiFXhaYzzbZJMUfEgEXj0CwNMMLaMzsLhit14
	ZEpks+bsn1IjUI2wzMYEdXFRZ3a8U06SLJXjTpukrJoRm90gc7HuL9d1bbTJLkvApCtAjHf23Dk
	SzXxYvg3u1uJX5oo8JNrTu7XxTSPN9lmgC1lxzyNTl69dRGzrKX9gI5pS74TXLWigTDS9cN+12n
	BBlQ3J3H4lOvk9peIhRYWG1IyL4bu02XtlZCsuZ3SnPwn9mU8NivuZCkBICeM8kEzItCMDHnjy+
	VlRFDB4yJ0eugN7Q5EKynj1UoD6tBUfK77ii5n8JESdkYPSeVccAafsayLpDzyIaMSjt3f8reSj
	muEK6AooblngGkH4ikn/KAURkEixUiISIpTCi1yMto+op5JwtB48oxgjPiGmykF6xae+nahGjkF
	z0vH1Az7X1RRxRUvPctuvo1DDjzqJMhz8xcQ1w==
X-Received: by 2002:a05:600c:1d0d:b0:499:900c:9c69 with SMTP id 5b1f17b1804b1-49eb72f3835mr48693705e9.9.1789593664382;
        Wed, 16 Sep 2026 14:21:04 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbbd83e39sm46708435e9.4.2026.09.16.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:03 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 00/10] Misc bug fixes - part 5
Date: Wed, 16 Sep 2026 23:20:47 +0200
Message-ID: <20260916212102.597335-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4805; i=memxor@gmail.com; h=from:subject; bh=+QIc50qlqJrXmsRTPADH116UQyzI0fAPllh2VibX0IE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h0ziSWPO/bcDn5YfvG/Dyf9597UT1UfmZT8MdLXN+ rL5iMaZjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExE/QYjw7tAPsufzBfYhQ4L OzWZcifnN2RWve1ZW3rms3xqSOnrdob/7qddbOZcE/0YVauoOaGnYP6lwrz3RjmbVRY/z8mLtbF gBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Changelog:
----------
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


base-commit: ee363e055895364039bf28348ff13c615afad4ba
-- 
2.53.0

