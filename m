Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0763E45BE3
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780852214; cv=none; b=kI8QsDF/y8esXmPcrGOIGhdrLfExLkvAD4FNCgMEWpwnkO2Kbdj0F4Iy0Fj/RGSwH4g379dqMRYRGZLwiYRT2lYO64PTB21g0iWf+VmokWm2nKH1LEX/mCwk1Kiq0vsoxvGqUEP8DC+47/zcydWMigk4+K2JTETlZScT16AGABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780852214; c=relaxed/simple;
	bh=IPvwljyQZpDcct7pE20QDt1P9VTQ7sgAgBY3rD8eWII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WUsmUBfYkYz4NyZCcsqrf+0T2KfZj4b78TQuy3bURcNhIuqTzf2tIPzn4eBwbq2O203AYSu2SsOca2KmjlWcuYZT3EE6sA5IIhgm0XLh8uSJbjCmMT/D7ouzHABFp4FgVhn7rd2nBD4jUcJ3v6ZmPHpOoFTDt+F315zYwSyub0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUyAZTZT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUyAZTZT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf3781ca51so35233915ad.0
        for <bpf@vger.kernel.org>; Sun, 07 Jun 2026 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780852211; x=1781457011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoWrcAuat8IsrHrGyIVSC+v4fTVKv8rexkicE+h/qZI=;
        b=CUyAZTZTbJVElzgv3ot6uGDUhLp7rLTHr7lL4t/w27k9fLfHpQ6malpZ3XKJsaHl7w
         2DSVDZ5G7U9iY/oJIJa2JRF+6CoS8xiCKnHbcrcLhTd0Sf3OEuhttn/RsF5F3mPcU98n
         zOOa7R+UDfJ3X8wlrIlgBgnNMA8XSExt1Pk+RdqpDxLUeN3Nvq1tMFxgaEShtMxTLWcZ
         mMXiiLuUj0yHKjlNkzks5VdADdmwOr7LSs77cJ6iH/R6po6ERZGJ1OoZ3FM9phIIbMFR
         CLOrIvWvhOESPgRDSkqWDO5UjEXrzMHneMGK/70PhQcoZFXSzW/1JLluy5xTWMs14iTb
         EsdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780852211; x=1781457011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoWrcAuat8IsrHrGyIVSC+v4fTVKv8rexkicE+h/qZI=;
        b=oDGTborG0zrH8PefMOyAStdegjDBYcpF+ggBZG80J5h4eCWdc/xhVxxrNFdZFmnvFK
         BKtFHTzZfSVfYZjkA81x2YwygZ/XKR1lzSW3bqzuT5Bgo2+/v3W9yR98cgMGg9PviPx7
         TnR63smryJ+5XJrIw5yVyqyR9YYnEI0wPB+CZPYdn8VhJNK12FK6f/JdRqSl+xiBfihY
         GNfmc11JYwSBCYd7RzUivadxhSXU3VSuIPn7Dcj6wr88dGlBSjB6uW+RsXH9YJLADCfY
         v+K8PDWENPyaCnZDjYw23hF6XdVsUCeFWdDZK7n0qGJyaxyHZ3klsOrp9o1JlMv4aKPz
         aBaw==
X-Gm-Message-State: AOJu0YwGt7C630oHKC0lCOmXyjyTjT/aDk3uB0HmTXoW16rgonWNMSFX
	UlcQWuuMAY/Z+7HW6fNO8H5DmsqteSKg01PS4u5sERJWplmGPu0cxa9MInRWXrhyHUs=
X-Gm-Gg: Acq92OEp+k994+7YRRvy009D4rWviSdwHQp6S/rQ7MkqhK6QKvvsZ5o1vpNj3pEW32+
	utC+IDeD2cFJUeoqI0zlo6QA/9hzdELWfi1JAbnzMPM/GARByac3xbyOxocXzz9Je8CQmKRNx29
	yWmj2r84mM4beXPfnfftL9UXn3Nwfyqu5VD2GQzO8QnAS01Afhk+mV/2/DtonYO57yFen/5zsa6
	QvNSUB/v/zVAqHkfB7cFVxsjh35IKqm+FSNBAZ6y1nItGo11YUtLFew7CmK9wR4DBI+dC3NQmAl
	lxsVKbIJfZ3R95uIHOwB0oqQKoGZ/DV03RixxXViUrK5tS5NfGKunWEBkTN5IoeBGuS/45WhEKl
	BwjL2yiVQnxHu15L3pHtPXrXrCSq8BwYy5pVB/Zpk/MKvzuyy+7YEhaXoIA9phTINwQ0Salwo3B
	FpFWQfsK9u8iOA72fVaQwqgBfyAbUK9IRPtIEE9BUG+6m8EEXzcJkP
X-Received: by 2002:a17:903:11d0:b0:2c0:a711:534 with SMTP id d9443c01a7336-2c1e7e589b6mr142658535ad.13.1780852211012;
        Sun, 07 Jun 2026 10:10:11 -0700 (PDT)
Received: from DESKTOP-MUHC17F.lan ([188.253.121.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f9ed6csm155375265ad.31.2026.06.07.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:10:10 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org
Subject: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal tracking fixes
Date: Mon,  8 Jun 2026 01:09:55 +0800
Message-ID: <20260607170959.823755-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series backports two BPF verifier scalar range-tracking fixes to
6.6.y and adds a selftest. It fixes a verifier state-pruning issue where
an impossible linked-scalar path can be kept while the real success path is
pruned.

The issue is verifier scalar state tracking, not helper-specific behavior.
A helper return value in r0 and another scalar can become linked by scalar
id on one branch. If the verifier does not preserve the not-equal fact on
the right branch edge, a later check can let it explore an impossible
continuation, narrow the linked scalar to the wrong value, and prune the
real success path against an earlier cached state. The program is accepted
by the verifier but then reports the wrong branch outcome at runtime.

The original visible failure was found in Rust-generated eBPF around helper
calls. Rust match lowering can keep a helper return value and a scalar
filled through a by-reference helper argument in the same enum-style control
flow. That makes it easy for the verifier-visible scalar values to become
linked by scalar id.

The relevant verifier-log bytecode from the original fexit reproducer is
below. The later instructions only store r7 into a map so user space can
observe which branch the verifier kept.

  15: (85) call bpf_get_func_ret#184    ; R0_w=scalar() fp-8_w=mmmmmmmm
  16: (79) r7 = *(u64 *)(r10 -8)        ; R7_w=scalar() R10=fp0
  17: (15) if r0 == 0x0 goto pc+1       ; R0_w=scalar()
  18: (bf) r7 = r0                      ; R0=scalar(id=1) R7=scalar(id=1)
  19: (55) if r0 != 0x0 goto pc+6       ; R0=0
  20: (67) r7 <<= 32                    ; R7_w=0
  21: (77) r7 >>= 32                    ; R7_w=0
  22: (b7) r1 = 1                       ; R1_w=1
  23: (55) if r7 != 0xf goto pc+1

The failure mechanism is:

  1. The program checks "if r0 == 0". The jump target is the success path,
     and the fallthrough path is the failure path and should imply r0 != 0.

  2. On affected kernels, the verifier does not record that r0 != 0 fact for
     the fallthrough path. The following "r7 = r0" then gives r0 and r7 the
     same scalar id while both are still treated as possibly zero.

  3. At the later "if r0 != 0" check, the verifier still thinks r0 may be
     zero, so it explores the fallthrough path of that JNE. That path means
     r0 == 0, and because r7 shares the same scalar id, r7 is narrowed to
     zero as well. This is an impossible path: it came from the earlier
     failure path that should have implied r0 != 0.

  4. That impossible continuation reaches the return-value comparison with
     r7 == 0 and can make the verifier keep only the wrong branch. When the
     real success path is analyzed later, state pruning considers it safe
     against the earlier cached verifier state, so the real continuation is
     not explored.

The relevant pruning point is that regsafe()/states_equal() accepted the
real success-path state against an earlier cached state where r0 was an
imprecise scalar and r7 constraints were loose enough to cover the current
r7.

After confirming the mechanism, I used a reproducer with the same verifier
state shape, now captured by the selftest, as the test case for git bisect.
The bisect started from the affected 6.7.y behavior and the fixed v6.8
behavior, and narrowed the fix to the v6.7..v6.8 window. It identified the
upstream fix as:

  d028f87517d6775dccff4ddbca2740826f9e53f1
  bpf: make the verifier tracks the "not equal" for regs

For 6.6.y and older stable verifier code, applying d028f87517d6 alone is
not sufficient. The verifier also needs the range-preservation semantics
from:

  9e314f5d8682e1fe6ac214fb34580a238b6fd3c4
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic

Without that semantic prerequisite, the old range-combining logic can still
discard the refined bounds after the verifier learns them.

The new selftest uses bpf_skb_load_bytes() only to create a helper status in
r0 and run through the normal tc test-run path. It reproduces the verifier
state shape without requiring fexit attach or bpf_get_func_ret().

I would like this fix to be applied to the supported 6.6.y, 6.1.y,
5.15.y, and 5.10.y stable trees. This v2 targets 6.6.y first for stable
ordering. The same issue is also reproducible on 6.1.y, 5.15.y, and
5.10.y, but those trees need separate older-layout adaptations.

Targeted BPF selftest/reproducer results are:

  For 5.10.y and 5.15.y, I used the same minimized reproducer bytecode in
  QEMU because those trees still use the older test_verifier framework.

  v5.10.258:                         FAIL
  v5.10.258 + equivalent backport:   PASS
  v5.15.209:                         FAIL
  v5.15.209 + equivalent backport:   PASS
  v6.1.91:                         FAIL
  v6.1.91 + RFC backport series:   PASS
  v6.6.142:                        FAIL
  v6.6.142 + this series:          PASS
  v6.7.12:                         FAIL
  v6.8:                            PASS

I also checked bpf-next: bpf-next passes even when the d028f87517d6 JNE
refinement is reverted, because newer kernels also have the later
4bf79f9be434e ("bpf: Track equal scalars history on per-instruction level")
precision-tracking change. I did not use 4bf79f9be434e as the stable
backport base because it is a broader jmp_history/precision-tracking change
for linked scalars. For 6.6.y this series keeps the smaller stable backport
path that directly follows the bisected fix: preserve scalar bounds after
conditional refinement, then add the not-equal range refinement in the older
reg_set_min_max() layout.

Changes since RFC v1:
  - drop RFC;
  - state the intended stable targets and keep 6.6.y first for stable
    ordering;
  - add a BPF selftest covering the failure;
  - add 5.10.y and 5.15.y reproducer validation;
  - document why Rust-generated eBPF can naturally create this state shape;
  - note the later 4bf79f9be434e precision-tracking reason why bpf-next can
    pass independently.

RFC v1:
  https://lore.kernel.org/r/20260601180400.1381736-1-jt26wzz@gmail.com/

Thanks to Shung-Hsi Yu for reviewing the RFC, pointing out that 6.6.y
should be handled first for stable ordering, and noting that bpf-next is
also protected by the later 4bf79f9be434e ("bpf: Track equal scalars
history on per-instruction level") precision-tracking change.

Zhenzhong Wu (3):
  bpf: drop knowledge-losing __reg_combine_{32,64}_into_{64,32} logic
  bpf: make the verifier tracks the "not equal" for regs
  selftests/bpf: add helper retval linked scalar pruning test

 kernel/bpf/verifier.c                         | 92 ++++++++-----------
 .../selftests/bpf/progs/verifier_reg_equal.c  | 35 +++++++
 2 files changed, 75 insertions(+), 52 deletions(-)

base-commit: 924b4a879cbb75aef37c160b955b92f6894b11a4
-- 
2.43.0
