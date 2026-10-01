Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F15349D5
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866381; cv=none; b=po/eYtQgVwmm4eue8nrIBopkkCmEvCbJkrDPNotaSrjjsl9eQN5I/lxcTOvkU7yEqYAfbyDp68Zi087cjNGrHCv/6pGanH6Qts/+8b8hVM6uCR378U02iGD7Yz+PJioMIIzMopCe+ukWa1cTLw6xEOZlKJfegu2Qd6qZIIjymDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866381; c=relaxed/simple;
	bh=lAEsNBKrx0bcuMxRIE82PWZrMHX0a/4XTnE8sxsrRRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/7zFyAstf7gJEF0/mQQh1kMhZr2x0XYAyYhfbIHz+THbp605SIgR/bdEkW2Msi+CXr251Ty+yfESFns5IwTv4blm8ACWWg/khCjJwo0IJC0/7LL3DruUspXlWuHxYV/FTcq5FGMv7KH96CjlRsngqptwzuxy1sjuzrpWmXd968=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBO8D2Wk; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBO8D2Wk"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d9fdf798so11574985ad.0
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2026 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790866378; x=1791471178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WDMtU22BNB7sOKxg2YKxZH5wBvaVKe0CWzFbLkQpnds=;
        b=JBO8D2WkUzqGEARumOKmOyKG0X4h4Y01xSKoH/psbUQiIDI+Afm7+DDJWLzu5B+KLm
         1CgpMQvWCKH+nYUHwR6x893eP8+Y5WHP+zZZQV3ErKzA8iZnlRZmaMewaM3WzfoFRXRM
         G8M1gQshe0iJpfxRCzPRMYvbAu4hXv3mb8/QV7GgVWBD/h5aZWHmz0QTAygACoKmj1ue
         QSOmxuLBHRFG71Ihv3ZhXxRKtgDOxRfloJc+5WIP+PD5jUgdFhaaqUmf8/56J9sY2EAH
         UZcuCf+bo/JkRmo4LYl0d0VjSwvmMlEZ8G1CO8noxvO5Z2k3shHhBXAmNTYSBCInOGVn
         oQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790866378; x=1791471178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WDMtU22BNB7sOKxg2YKxZH5wBvaVKe0CWzFbLkQpnds=;
        b=nYZvo84mBepcn771Guw6qAmxMTv+HpMC/jlXiqvXEFpb1nAoBQF3x4nz9SbvKtNExn
         44necY85fDIQebjoTPXdA0uAx82qU7PbaN7MYjHgxcNxbK8OfCZIQRIVMkkpzKAENuEa
         dtAIIqzxJtCBpoZqxLx8Dfh+gZyVjTSJj4+vk30adccADw1aXGnpOSlzHP37pyYSEd/g
         doP9b9E1FsxCc/6WhHWg9td4k07JxzuDP28U1reGGZz7E9vuHafP03u8PT6rGnKfVfHI
         6AtD9DiYCqeky3ra7Cd6OMrKDZssel/4jb0hlsCKm6/16oqSbEcILMRBDygFD903J7qv
         qdRA==
X-Gm-Message-State: AFq9FYIIUQfFOsEi2RvQY0WCjLKfTQJ61ccxuol+sujLCIbF2VMbTgEM
	gIOG9oZTJOi+SBFzXpavfc0R3NLiOkLyFtPPMquunNWu5jBq488rCvGHsFvb+enz
X-Gm-Gg: AYBFou2Z/kjyJ/ZzAp1f4SJIocgMkbYVyLuti97RPthfmzjFOI1WyJw0P1xvvlahZce
	TUcsz2zdtXhe1uVN+ac0A9JKX9Yw32WqY4dMPKLgeXX5ptZfET7EYUGVMzGUjB/zAfjvp2QO7o0
	jdvXXi4XtgeQ1mi9dAzt/FwEEN0ygIhsRcJffVUW4aLPJZpEx6i7UZGsLepFlZrx6lYmVY1qsHt
	O/DOcgiHwIMzj5QH7TfFm6bL/CNKuEeKUtLDwHYAFsniXoIJXqfpTjx8I46ZwF96bKuiaGbvqTL
	AgwP4bSOcOLm2wG0CNoCqigKVRdGyPOIJnLyC6+CGfNFRkxAViCuTc0mid5+m0X4GH096o6+qLb
	EfGkMUJr28LQCq2/hL7tR1i/xJxz/IA4CuypXWVO85fRxrdIJJxmCMfbK+OHzzS0hs5pFpyUq7H
	8/PMHq4J1IXlLOtvlre4JSgYI+bZAcaBy7Y4Oz0nrMMVFhNi+7t4AOLkkgsWCQnuB4jYsyau1/B
	GZkvW4IvyenGYgvB5lWYGGa8rCXA1dEiuMnx+MqkKjwH+a04cnR5/Ftv8gYHl7d9hSCw4vTs0Xd
	ASIkHQj4ZwOJCYqaSbYc6OC88ShfQX0PRZGLGM5M80Vds3gE4fOlvX4=
X-Received: by 2002:a17:902:e790:b0:2df:90d4:7758 with SMTP id d9443c01a7336-2e2e499bfbdmr39905025ad.23.1790866378243;
        Thu, 01 Oct 2026 07:52:58 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30099c812sm12318065ad.15.2026.10.01.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:52:57 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 1/2] bpf: Fix packet range of pointers sharing an id
Date: Thu,  1 Oct 2026 14:52:54 +0000
Message-ID: <20261001145255.855630-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Since commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off
for pointers"), find_good_pkt_pointers() sets the range of all packet
pointers sharing an id from the umax of the compared pointer, and
check_packet_access() requires umax + off + size <= range.  That assumes
the umax of two such pointers differ by exactly their constant distance.
reg_bounds_sync() breaks it when var_off tightens one umax and not the
other:

	r4 &= 0x38
	if r4 > 50 goto exit     ; umax 50, var_off (0x0; 0x38)
	r5 = pkt + r4            ; umax 50
	r6 = r5
	r6 += 8                  ; umax 56, not 58

Comparing r6 with pkt_end sets the range to 56, and the valid 8-byte
load at r5 is rejected (50 + 8 > 56).  Comparing r5 sets it to 50, and
the out-of-bounds 1-byte load at r6 - 7, i.e. r5 + 1, is accepted
(56 - 7 + 1 <= 50).

Don't call reg_bounds_sync() on a packet pointer that keeps its id (a
constant was added or subtracted) or its range (an unknown non-negative
value was subtracted), so that var_off cannot tighten its umax.  Only
update the 32-bit bounds from var_off: reg_bounds_sanity_check() wants
them constant when the lower half of var_off is, e.g. for pkt + 8.

This relies on nothing else changing the 64-bit bounds of a packet
pointer, which holds today.

var_off of such a pointer is no longer narrowed by its bounds.  Adjust
three verifier_align expectations; the low bits, which the alignment
checks use, don't change.  veristat on the selftests shows no verdict
changes and +0.8% insns in test_cls_redirect_subprogs.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Assisted-by: LLM veristat
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                              | 10 +++++++++-
 tools/testing/selftests/bpf/progs/verifier_align.c |  6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1599bac1b..1546baa6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15780,7 +15780,15 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env, struct bpf_insn
 			"Tighten the scalar bounds before the arithmetic so the resulting pointer remains within the allowed range.");
 		return -EINVAL;
 	}
-	reg_bounds_sync(dst_reg);
+	/*
+	 * A packet pointer that keeps its id or range is checked against a
+	 * range set from the checked pointer's umax, so var_off must not tighten
+	 * its umax. r32 must still match var_off for reg_bounds_sanity_check().
+	 */
+	if (reg_is_pkt_pointer(dst_reg) && (known || dst_reg->range > 0))
+		__update_reg32_bounds(dst_reg);
+	else
+		reg_bounds_sync(dst_reg);
 	bounds_ret = sanitize_check_bounds(env, insn, dst_reg);
 	if (bounds_ret == -EACCES)
 		return bounds_ret;
diff --git a/tools/testing/selftests/bpf/progs/verifier_align.c b/tools/testing/selftests/bpf/progs/verifier_align.c
index 3e5268651..0083ef8b8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_align.c
+++ b/tools/testing/selftests/bpf/progs/verifier_align.c
@@ -284,7 +284,7 @@ __msg("26: {{.*}} R5=pkt(r=8,imm=14)")
  */
 __msg("28: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Constant is added to R5 again, setting reg->off to 18. */
-__msg("29: {{.*}} R5=pkt(id=3,{{[^)]*}}var_off=(0x2; 0x7fc)")
+__msg("29: {{.*}} R5=pkt(id=3,{{[^)]*}}var_off=(0x2; 0xffc)")
 /* And once more we add a variable; resulting {{[^)]*}}var_off
  * is still (4n), fixed offset is not changed.
  * Also, we create a new reg->id.
@@ -359,7 +359,7 @@ __msg("7: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
 __msg("8: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7fc)")
 /* Packet pointer has (4n+2) offset */
 __msg("11: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
-__msg("12: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc)")
+__msg("12: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc)")
 /* At the time the word size load is performed from R5,
  * its total fixed offset is NET_IP_ALIGN + reg->off (0)
  * which is 2.  Then the variable offset is (4n+2), so
@@ -375,7 +375,7 @@ __msg("17: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
  * another (4n+2).
  */
 __msg("19: {{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
-__msg("20: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc)")
+__msg("20: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x1ffc)")
 /* At the time the word size load is performed from R5,
  * its total fixed offset is NET_IP_ALIGN + reg->off (0)
  * which is 2.  Then the variable offset is (4n+2), so
-- 
2.55.0

