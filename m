Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F206442B23
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391826; cv=none; b=OwqUzqQ0cUU0dTteo7xZPyN1OvznCu04r9KE4GpFToBOzju5l8Cginh9DmwNHqpbCt1SpVFYi4n7LT4FuSGnsUPFEWzllWe1Hes9xpYrGPpP9tIUWo4yvcFoeyniiwscCTJ6OQvuLj5DLXqERif16kkAAlNdbbKBKIOcSQ4qxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391826; c=relaxed/simple;
	bh=uRSylaCg5R5r3YkPI+JRMVgc1IjxWaSwhAKv8y+npg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=El4JRfzgzeXAovydLzibI4dFeoDqBHyYYjiw/hv8z4VgbnjKZxpA9KPD3zrhE2WE/OwqJvG5S8TiLAAyBbgRXhZgHMaWDc1PsgiysRQG9ZXKaed5/8LRKEatfFcT9xP08IEQIfJGQFoXutWJnImNoPDsfJfuZUoQc0FoN5RIiDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bE1b4CBj; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE1b4CBj"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso14631925e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391823; x=1789996623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cR/7qNVtXDvU6/rgT1LxSP4uHUMLHK0iCADuUBSjZyA=;
        b=bE1b4CBj8pskkAWelP8XN+ePEH2okr26FxlvSbBeW/pmb8zaNNwjh95QtM4vgGXXev
         8b+mmKDU9hfhxx6SQAJ9f+COw2MZ7Vr7bx+0RZEQgMFG/ijbb2wwMFB8GCz/i55N6tFe
         YE2rnqo21GQnoeiDVhvKwfjODmMahAMHSX4iaGv5MGG7PlVO/4cwsvkVaIESWx+ILz7R
         z8YJ+xk7mEmtKHxDGyPP5uTs45wjlhW5kTMt9BKSIl96IHqBJz6OeVft39eo8dvRL/iq
         fo/pTMmry351V7WMkJCcbbdYZ5gZLucsiQY4KJmr3s7Ao6s0BVSdDM5m5TlA8cEljdte
         Ujpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391823; x=1789996623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cR/7qNVtXDvU6/rgT1LxSP4uHUMLHK0iCADuUBSjZyA=;
        b=pEbEb3/ZVUck8I86T8XA8MiiI+wdrD0IGGX6CAeJjwj/4aFV+OOIdeemjEUVrrKkwe
         kENy0uFG6d49ppioPHn1PysywBxCHyHxQYD7AS6bNy9dRQYehwb8e711lKDpkbr+Szzx
         bQ8AXlJa/krgBhT/nTNtAdb6NZ8SPP37WdVrf1KoOHRjseYp/VqzdMdEDsylMpR1yuk9
         HGQQWwl59PGdPmcoBBnaO0nDdHFcibII90H8F4JmlpLL0wADEUqA0n64mNIMvKVaSOdh
         Pcz0Qt/iVKpcF4HWFR+i2O2uOwTEyyoJvn3NyhJVjuWzpBLgVy7firKBncOz+Aq3nlms
         60uA==
X-Gm-Message-State: AFuF++m7UxRu3TOQo6/e2t4ipL0zcie1Pe9ci52VwI0Wryzu+pbPm3st
	wkNKo4T9DWWRkUhfN1vfCnAAbg7f7F5NGsUmrNxAAIsZKHQkvAIfHLyDpoq9nyCK
X-Gm-Gg: AYBFou074nrEExgeBmMVKVk1bGshif5BGzvED8sGnYCEtvu/A+VrpUThsHI7YMMv9KJ
	FEH/RwKxZVZ5a3rxamCcwjq+Mm36n1ZI1hDysE0M5Au/AQcphuCC65d3xMSnUGlI3vIgstIOR0X
	WSHHNZioU0il27IoSPwvMJFkjgybBI3creKol8wv56Pwpcwdvsz3ePooeiSahcKGdRh3Tt1fdkx
	586iK6SleMZFQHuNGbrHG8u8MUW9Pz9hODfHMnx2f1pORw0pTExZNOrMPQGCGaFFDpxdtAye17+
	C/HHyeOdydIMN6xa0ULBMQvV7vwtwtfUdUAeCE4iVdnM8WB97tTYOTVQagTcAS7FLTXjtUg2uo4
	2Ie3SBtBykNgJeZeOHH0Ruu9fPNVvctgat1+92dP3QLkJMBEz2ySYBIEJMbEEslo1yqZ470EI0v
	rUjAnVlBsZgnochcPqmv7eOYFevSRsa5GqBHepJUoat7FML4WTErEAIy5NBX5rH8LAoS6ozzj4N
	AOBubHiKkLe0HX9p1ykNlBsQcbKZtoirKqtIQfxNj4qtbgS1lqRAbc5nGqDTppg0NXPEp4x5tuv
	loD3dvNvjEWUvRPodfPJimFNIVN0788LLt2w8Q==
X-Received: by 2002:a05:600c:5490:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49e7a68c9c5mr59197285e9.16.1789391823067;
        Mon, 14 Sep 2026 06:17:03 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6c0cb676sm235289595e9.14.2026.09.14.06.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:02 -0700 (PDT)
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
Subject: [PATCH bpf v3 0/7] Misc bug fixes - part 5
Date: Mon, 14 Sep 2026 15:16:50 +0200
Message-ID: <20260914131701.2529725-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2960; i=memxor@gmail.com; h=from:subject; bh=uRSylaCg5R5r3YkPI+JRMVgc1IjxWaSwhAKv8y+npg4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv55xkalu2vPxaxrGA4/WyZR+vf1ULf7Fp3sNgE3heXO i92bVlZRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaimcvwh3sS10XTLMWJ7Dte LuSPfM5tt9Jar0yW+UOgqerU9H+N0owMPeZfcy9uv3yE/bdCbukimavTD7zNyfn39tDOwxMMbjy N4QEA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas. See commit
logs for details.

Changelog:
----------
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

Kumar Kartikeya Dwivedi (7):
  bpf: Make post-verification instruction rewrites killable
  bpf: Preserve packet pointer class displacement in regsafe()
  selftests/bpf: Test packet pointer class displacement pruning
  bpf: Restrict CO-RE poisoning to relocatable instructions
  selftests/bpf: Test CO-RE instruction poisoning restrictions
  bpf: Assign lock identity to callback map values
  selftests/bpf: Check callback map value lock identity

 include/linux/bpf_verifier.h                  |  24 +--
 kernel/bpf/core.c                             |  19 +-
 kernel/bpf/fixups.c                           |  24 ++-
 kernel/bpf/states.c                           |   9 +-
 kernel/bpf/verifier.c                         |  15 +-
 tools/lib/bpf/relo_core.c                     |  28 +--
 .../selftests/bpf/prog_tests/cb_refs.c        |   2 +-
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 168 ++++++++++++++++++
 .../selftests/bpf/prog_tests/spin_lock.c      |  33 +++-
 .../selftests/bpf/progs/test_spin_lock_fail.c | 167 ++++++++++++++++-
 .../progs/verifier_xdp_direct_packet_access.c |  35 ++++
 11 files changed, 477 insertions(+), 47 deletions(-)


base-commit: ee363e055895364039bf28348ff13c615afad4ba
-- 
2.53.0

