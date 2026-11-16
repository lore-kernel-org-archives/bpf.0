Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808678;
	b=Yht/Wnemv3Ep7Zk4xy7zGuVheWPn/pSejFcp+ikBEuciElC4JY691QnlW06sPvfcUdGR
	 8l5UH8BiiLGD7hA4uZBm+rMffpLNY/0k0kaTrjSauSCg+LQ0K1bFSLhdYb/SJL7KUxhb+
	 Bv6xPOZTMjm7woOOQVrhYnYgnHr2ky++QAVu5Nbc8bKsFG+HAsjBbUVlr5yP6Kl7CGxrz
	 OMH/9VCzWRSREynzWdMxAuN47O1FMPMPRFa4S+/Y1e6AUfJImp1S9YflfsScvTTyuxkFo
	 hzBJuPn6v514pSvWrlFOjvnqWHC5v9VGpO8IgrhMDwVhFMFLJRnMU6YPSFl4ZJ/v5cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Z4w4XKlevqyOP82yu5yapGmHLHHYnPpYJJEK2XLPQI=;
	b=sP/VNFHik97sb1WiiFtht/sro5ZIIuWnkHCYaNbZKE+D12leSKnL4Yiz6hXiB2zxzwhc
	 jiIHvbLIqjkuULVN7RJEes6EJ5mbKLgBfJo/VZHT7xysvRbMSVpt/kwiTcLwZA8Zq/sGN
	 15jyPjd+G+WM3VCaOiNT4B7uC7CKzrqpCI8Egyn+ceZxPUFAZl9qhmeCf+yql+AfwSwJ4
	 dcvfZE0WtMJBLnW1E5bsgUhvb1qCOchDvMxGB5dg3QyFsZ5kjqaEDOQRkeE4iswanR6JI
	 UvP/i6t6w4sVHW+7qwsG8LvqfjgBMpMBjLzaua2lHydeXM++uJhnqaGIjORtlABkk4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="FHz/sckh";
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E4606A32C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 05:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9E4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FHz/sckh
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b600fae14dso1333456b3a.2
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 21:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794808676; x=1795413476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Z4w4XKlevqyOP82yu5yapGmHLHHYnPpYJJEK2XLPQI=;
        b=FHz/sckhE2nCtTNY3XyckFs6SWXu8DRuwcip/kikF8G+FdlVPFrNvYKtqQ2Btbv3vq
         dD4M7C6yCrnC0L4BfB0Y/3gtni5To1xNZEdSB/0BRcZlTUQTlj8y/LATsig9hIUKjTaV
         +YUzjTsi4j8cdsb6O5BcLzgB/vs0ybx/pbhP8+1Pmd29dZEm0OeIosypzNB6Ju0qyDcZ
         epIUVkLdnjioBJkCZd03F4NFo/SNuipWCVvTuRS/tqcGOiIc934mvXrNgE1wnP476riL
         v14mRo2gnnhoVaofxybc6IEwWEAWwN03cdG7m6+RZRspNXE+CwKUhQx5SOmW6HpBulSM
         YjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794808676; x=1795413476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Z4w4XKlevqyOP82yu5yapGmHLHHYnPpYJJEK2XLPQI=;
        b=hB2r5+JPww9qqyxSpnTfOZi6+WJnGeLu5YiwiauUEA2rz4UEWqmtNpmhx8/y1968sy
         sFzVay1fpDwRHwQzCXdNivOzTBbCYnvfVUzjo/ZcdPPo2yNeEeZuCcOeUTrYKQdBSxwW
         eLDG12rpxJGHzmiJF6EWYe89wPP3wCDuVcHXgPARujst7D55F6XfRZc0P15rH+/dv9Qx
         uvn/TxBp59pGhw4AG/J1Ar3g8OI0h5B4s2ULb7k1j9u9qow0DUHWnBAKITOrAQ6zD4it
         qNpCR4vtAo847HqDEjxeKGCGB3mPZm1JchxFzpfiPQ9KWxBSMdWidVLWGNjVWCWwE7yk
         esTA==
X-Gm-Message-State: APuU4Z8bPyTJS3i8ISOIZeKCoSx013zj9vj/lWUh1UipL+aFIPyUXOBu
	mUg6KecNoiNR7gieqhQX8h/YC2aG5l/Xx8SvTqwXooKgihnV0VVbr/7F4gEKXg==
X-Gm-Gg: AYBFou1frbv3YCbLvRveJMruSLSGVn9l7lreJMSgvOcd9yaxRokDStGAk9tdgyhQ30g
	v1UFb/HtSf1NjXcVcJgTm388ZdAKibRjUwu/VLGggVAmNA+qYb6TfmGU2qsPcUHoBTMCdh/DA7l
	YHLd5XdTGxbm7/oV8ODrXt7cNR1ncGNOdtaOuQ4TnrVb1WMxKlOLpiAqiTWR1dr985W+AlpCRUI
	wS4TcUqnJ5QwZolVkvaJgOuU0RbE9uieS+okJn3E5MpPp6+ySlJZE7IvLTcWUwEXTevoMmaPJm0
	sFRdHz1sA2DJJduE9HnQeSZUQ1u1SEMrW1en+8NKjO0GJDT8awCB12wW5XN1mA7Wfd+4RymOMvI
	2wPBLl92I6RUyjFPEfbrX2bRcdMVqJj7nwZRVl0QpchjmTEdJ4I4c1ovqP1DyFUal7icehSzzSc
	2sZr1Khit9o674nv9zKfYy9CNwH5XExKqSV6fPhOyDEWl9Fy7N6ygn/qPmnnHqLyCkid98KXfKn
	Gb7zsflCzgMLpoGUpm6xWUaLeW+dw9vKMGLtgsKvq3SGhKwGP1iORqlnvM51DWf8kkDPb97qxPi
	kBXR4SysQlBUIL8qMi2xClCTZn7YjnrdYrsmhxSpxSu2uT7YsEQ22FlCP7Ar40gWisPpnFT39HD
	Na4xK1Uz+s0J/R7q1hLxT5svMOnfN/XN0Rf8lRK7jJb2ZJ5fzRAnRbw77dNEFESZD7p7o83JoSR
	0=
X-Received: by 2002:a05:6a21:6452:b0:3e2:117a:6307 with SMTP id adf61e73a8af0-3f7a75bef1emr6361278637.22.1794808675408;
        Sun, 15 Nov 2026 21:57:55 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18b4352sm3879187a12.24.2026.11.15.21.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:57:54 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 12/21] bpf: Relax jumps that patches push out of range
Date: Mon, 16 Nov 2026 05:56:29 +0000
Message-ID: <20261116055638.4171529-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A jump has 16 bits. Patches grow the code under it: inlined lookups,
checks of divisions, may_goto, guards of loops, constant blinding.
A verified program fails with -ERANGE: 2979 lookups under one branch
are enough.

Let bpf_patch_list_build() use gotol for such a jump:

  if r1 > r2 goto far    ->   if r1 > r2 goto +1
                              goto +1
                              gotol far

The same form works for may_goto and unwind_goto. An image where all
jumps fit does not change.

The passes do not compute offsets any more:
 - the last insn of a patch stands for the patched insn and keeps
   its target;
 - bpf_patch_list_jump() gives a target in the old image to an insn.

may_goto_off(), bpf_adj_moved_insn() and BPF_GUARD_NEAR go away. All
guards that leave a subprog share one 'r0 = 0; exit'.

x86-32, riscv32, parisc and sparc64 have no gotol in the JIT. They fail
on the unknown opcode, as they do when gotol is in the program. There
a guard that is more than 32K insns away from the end of its subprog
had its own exit and was JITed. It is not JITed now.

A jump to itself is a jump like any other. It goes to the start of its
patch: 'nospec; goto -1' in sanitized dead code is 'nospec; goto -2' now.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h                  |  11 +-
 kernel/bpf/core.c                             | 335 +++++++-----
 kernel/bpf/fixups.c                           | 502 +++++-------------
 .../{blinding_log.c => blinding_far_jump.c}   |  38 +-
 .../selftests/bpf/progs/verifier_and.c        |   2 +-
 .../selftests/bpf/progs/verifier_bounds.c     |  14 +-
 .../selftests/bpf/progs/verifier_movsx.c      |   4 +-
 .../selftests/bpf/progs/verifier_patch_list.c | 137 ++++-
 .../selftests/bpf/progs/verifier_unpriv.c     |   2 +-
 9 files changed, 475 insertions(+), 570 deletions(-)
 rename tools/testing/selftests/bpf/prog_tests/{blinding_log.c => blinding_far_jump.c} (51%)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 3b40f66894d9..28104dae5f08 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1208,6 +1208,10 @@ struct bpf_insn_patch {
 	u32 len;
 	u32 start;		/* first insn of the patch in bpf_patch_list.insns */
 	u32 target;		/* insn of the patch that jumps to 'off' land on */
+	u32 self;		/* insn of the patch that stands for insn 'off' */
+	u32 jmp;		/* 1 + insn of the patch that goes to insn 'jmp_to', 0 if none */
+	u32 jmp_to;
+	u32 jmp_back;		/* or to that many insns in front of the patch of it */
 	struct bpf_insn orig;	/* the replaced insn when the patch was queued */
 };
 
@@ -1230,7 +1234,9 @@ struct bpf_patch_image {
 	u32 *new_off;
 	u32 *new_tgt;
 	u32 *new_linfo;
+	u32 *relaxed;		/* insn before patch_image_relax() -> insn after it */
 	u32 cnt;
+	u32 short_cnt;		/* insns before patch_image_relax() */
 	u32 new_cnt;
 	u32 nr_linfo;
 	s32 grow;
@@ -1256,7 +1262,8 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 u32 off);
 int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
-			    u32 off, const struct bpf_insn *insns, u32 cnt);
+			    u32 off, const struct bpf_insn *insns, u32 cnt, bool behind);
+void bpf_patch_list_jump(struct bpf_patch_list *pl, const struct bpf_insn *insn, u32 to, u32 back);
 void bpf_patch_list_release(struct bpf_patch_list *pl);
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img);
@@ -2266,6 +2273,8 @@ static inline void bpf_patch_list_free(struct bpf_verifier_env *env)
 }
 #endif
 int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off);
+int bpf_patch_list_append(struct bpf_verifier_env *env, u32 off,
+			  const struct bpf_insn *insns, u32 cnt);
 int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
 			  const struct bpf_insn *insns, u32 cnt);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3385df367b05..147261bf9e6d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -374,11 +374,7 @@ static int patch_list_reserve_insns(struct bpf_patch_list *pl, u32 cnt)
 	return 0;
 }
 
-/*
- * Extract the pc-relative operand of a jump, a subprog call or a ld_imm64 of a
- * subprog. gotox and a tail call pass for a jump to the next insn: nothing
- * reads their 'off'.
- */
+/* Extract the pc-relative operand of a jump, a subprog call or a ld_imm64 of a subprog. */
 static bool insn_get_rel(const struct bpf_insn *insn, s64 *rel, bool *is_imm)
 {
 	u8 code = insn->code;
@@ -389,7 +385,8 @@ static bool insn_get_rel(const struct bpf_insn *insn, s64 *rel, bool *is_imm)
 		return true;
 	}
 	if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
-	    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
+	    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT ||
+	    code == (BPF_JMP | BPF_TAIL_CALL) || code == (BPF_JMP | BPF_JA | BPF_X))
 		return false;
 
 	*is_imm = code == (BPF_JMP32 | BPF_JA);
@@ -397,21 +394,6 @@ static bool insn_get_rel(const struct bpf_insn *insn, s64 *rel, bool *is_imm)
 	return true;
 }
 
-/* Set the pc-relative operand that insn_get_rel() extracted. */
-static int insn_set_rel(struct bpf_insn *insn, s64 rel, bool is_imm)
-{
-	if (is_imm) {
-		if (rel < S32_MIN || rel > S32_MAX)
-			return -ERANGE;
-		insn->imm = rel;
-	} else {
-		if (rel < S16_MIN || rel > S16_MAX)
-			return -ERANGE;
-		insn->off = rel;
-	}
-	return 0;
-}
-
 /* Whether one of the 'len' insns of a patch in front of the last one jumps past it. */
 static bool patch_list_jumps_past(const struct bpf_insn *insns, u32 len)
 {
@@ -425,72 +407,53 @@ static bool patch_list_jumps_past(const struct bpf_insn *insns, u32 len)
 	return false;
 }
 
-/*
- * The 'len' insns of a patch were moved down by 'by' insns inside it. Keep
- * what they referred to in front of the patch, the same way as
- * bpf_adj_moved_insn() does: a call to the start of the patch, the old start
- * of a subprog, stays there, a jump to itself doesn't.
- */
-static int patch_list_move_down(struct bpf_insn *insns, u32 len, u32 by)
-{
-	bool is_imm, call;
-	s64 rel, tgt;
-	u32 k;
-	int err;
-
-	for (k = 0; k < len; k++) {
-		if (!insn_get_rel(&insns[k], &rel, &is_imm))
-			continue;
-		call = bpf_pseudo_func(&insns[k]) || bpf_pseudo_call(&insns[k]);
-		tgt = (s64)k + rel + 1;
-		if (tgt > 0 || (tgt == 0 && !call))
-			continue;
-		err = insn_set_rel(&insns[k], rel - by, is_imm);
-		if (err)
-			return err;
-	}
-	return 0;
-}
+#define NO_JUMP U32_MAX
 
 /*
- * insn is number 'idx' of the 'len' insns that replace insn 'off' of the old
- * image (an insn that isn't patched is its own patch of length 1). It lands
- * at 'pos' of the new image. 'new_off' maps the old image to the start of
- * each patch, which calls go to, 'new_tgt' to where jumps go.
+ * Where insn 'idx' of patch 'p' goes in the new image. Calls go to the start
+ * of a patch, img->new_off[], jumps to img->new_tgt[].
  */
-static int patch_list_adj_insn(struct bpf_insn *insn, const u32 *new_off,
-			       const u32 *new_tgt, u32 cnt, u32 off, u32 idx,
-			       u32 len, u32 pos)
+static int patch_insn_target(const struct bpf_patch_image *img, const struct bpf_insn_patch *p,
+			     const struct bpf_insn *insn, u32 idx, u32 *pos)
 {
-	bool is_imm, call;
+	bool is_imm, call = bpf_pseudo_func(insn) || bpf_pseudo_call(insn);
 	s64 rel, tgt;
 
+	*pos = NO_JUMP;
 	if (!insn_get_rel(insn, &rel, &is_imm))
 		return 0;
-	call = bpf_pseudo_func(insn) || bpf_pseudo_call(insn);
 
-	/* relative to the first insn of the patch */
-	tgt = (s64)idx + rel + 1;
-	if (tgt >= 0 && tgt < len)
-		return 0;
-
-	/* the patch pushed what follows 'off' down by len - 1 */
-	tgt = tgt < 0 ? off + tgt : off + tgt - len + 1;
-	if (tgt < 0 || tgt > cnt)
+	if (idx + 1 == p->jmp) {
+		tgt = p->jmp_to;
+	} else if (idx == p->self) {
+		tgt = p->off + rel + 1;
+	} else {
+		tgt = idx + rel + 1;
+		if (tgt < 0)
+			return -EFAULT;
+		*pos = img->new_off[p->off] + tgt;
+		if (tgt < p->len)
+			return 0;
+		/* the patch pushed what follows 'off' down by len - 1 */
+		tgt += (s64)p->off - p->len + 1;
+	}
+	if (tgt < 0 || tgt > img->cnt)
 		return -EFAULT;
 
-	rel = (s64)(call ? new_off : new_tgt)[tgt] - pos - 1;
-	return insn_set_rel(insn, rel, is_imm);
+	*pos = (call ? img->new_off : img->new_tgt)[tgt];
+	if (idx + 1 == p->jmp && p->jmp_back)
+		*pos = img->new_off[tgt] - p->jmp_back;
+	return 0;
 }
 
 /*
  * Queue the replacement of insn 'off' of 'prog' by 'patch[0..len)'. Patches
  * are queued in increasing order of 'off' and applied together, so a pass
- * keeps addressing insns by their index in 'prog'. Jumps in the patch that
- * leave it are relative to the patch placed at 'off'. Patching 'off' again
- * replaces the last insn of its patch, where the insn being patched went, and
- * the insns in front of it must not jump past it. Jumps of the new insns that
- * leave the patch are relative to the first of them, as for a first patch.
+ * keeps addressing insns by their index in 'prog'. The last insn of the patch
+ * stands for insn 'off': a copy of a jump or a call goes where it went. The
+ * others jump inside of the patch, ahead, or see bpf_patch_list_jump().
+ * Patching 'off' again replaces the last insn of its patch, and the insns in
+ * front of it must not jump past it.
  *
  * Return the copy of the last insn of the patch, which stays valid until the
  * next call.
@@ -505,18 +468,16 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 	int err;
 
 	if (p && off == p->off) {
-		if (WARN_ON_ONCE(patch_list_jumps_past(pl->insns + p->start, p->len)))
+		if (WARN_ON_ONCE(p->self != p->len - 1 ||
+				 patch_list_jumps_past(pl->insns + p->start, p->len)))
 			return ERR_PTR(-EFAULT);
 		err = patch_list_reserve_insns(pl, len - 1);
 		if (err)
 			return ERR_PTR(err);
 		/* the last patch is at the end of pl->insns */
 		memcpy(pl->insns + p->start + p->len - 1, patch, len * sizeof(*patch));
-		err = patch_list_move_down(pl->insns + p->start + p->len - 1, len,
-					   p->len - 1);
-		if (err)
-			return ERR_PTR(err);
 		p->len += len - 1;
+		p->self = p->len - 1;
 		pl->insn_cnt += len - 1;
 		return &pl->insns[p->start + p->len - 1];
 	}
@@ -526,11 +487,13 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 		return ERR_PTR(err);
 
 	p = &pl->patches[pl->cnt++];
-	p->off = off;
-	p->len = len;
-	p->target = 0;
-	p->start = pl->insn_cnt;
-	p->orig = prog->insnsi[off];
+	*p = (struct bpf_insn_patch){
+		.off = off,
+		.len = len,
+		.self = len - 1,
+		.start = pl->insn_cnt,
+		.orig = prog->insnsi[off],
+	};
 	memcpy(pl->insns + p->start, patch, len * sizeof(*patch));
 	pl->insn_cnt += len;
 
@@ -541,19 +504,11 @@ struct bpf_insn *__bpf_patch_list_add(struct bpf_patch_list *pl,
 int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 u32 off)
 {
-	struct bpf_insn_patch *p;
-	int err;
+	int err = patch_list_reserve_patch(pl);
 
-	err = patch_list_reserve_patch(pl);
 	if (err)
 		return err;
-
-	p = &pl->patches[pl->cnt++];
-	p->off = off;
-	p->len = 0;
-	p->target = 0;
-	p->start = pl->insn_cnt;
-	p->orig = prog->insnsi[off];
+	pl->patches[pl->cnt++] = (struct bpf_insn_patch){ .off = off };
 	return 0;
 }
 
@@ -564,24 +519,20 @@ int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
  * at the first inserted insn. Inserting in front of a queued patch puts the
  * insns in front of it. 'off' is the start of a subprog, so nothing falls
  * through to the inserted insns.
+ * Or queue them to go 'behind' insn 'off'. That is the last patch of 'off'.
  */
 int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
-			    u32 off, const struct bpf_insn *insns, u32 cnt)
+			    u32 off, const struct bpf_insn *insns, u32 cnt, bool behind)
 {
 	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
+	struct bpf_insn *insn;
 	int err;
 
 	if (!p || off != p->off) {
-		err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, 1);
-		if (err)
-			return err;
-		p = &pl->patches[pl->cnt++];
-		p->off = off;
-		p->len = 1;
-		p->target = 0;
-		p->start = pl->insn_cnt;
-		p->orig = prog->insnsi[off];
-		pl->insns[pl->insn_cnt++] = p->orig;
+		insn = __bpf_patch_list_add(pl, prog, off, &prog->insnsi[off], 1);
+		if (IS_ERR(insn))
+			return PTR_ERR(insn);
+		p = &pl->patches[pl->cnt - 1];
 	}
 
 	err = patch_list_reserve_insns(pl, cnt);
@@ -589,18 +540,36 @@ int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *pr
 		return err;
 
 	/* the last patch is at the end of pl->insns */
-	err = patch_list_move_down(pl->insns + p->start, p->len, cnt);
-	if (err)
-		return err;
-	memmove(pl->insns + p->start + cnt, pl->insns + p->start,
-		p->len * sizeof(*insns));
-	memcpy(pl->insns + p->start, insns, cnt * sizeof(*insns));
+	insn = pl->insns + p->start;
+	if (behind) {
+		insn += p->len;
+	} else {
+		memmove(insn + cnt, insn, p->len * sizeof(*insns));
+		p->target += cnt;
+		p->self += cnt;
+		p->jmp += p->jmp ? cnt : 0;
+	}
+	memcpy(insn, insns, cnt * sizeof(*insns));
 	p->len += cnt;
-	p->target += cnt;
 	pl->insn_cnt += cnt;
 	return 0;
 }
 
+/*
+ * 'insn' of the last patch goes to insn 'to' of the old image, however far that is.
+ * With 'back' it goes to the last insns of the patch of insn 'to - 1'.
+ * A patch has one such jump.
+ */
+void bpf_patch_list_jump(struct bpf_patch_list *pl, const struct bpf_insn *insn, u32 to, u32 back)
+{
+	struct bpf_insn_patch *p = &pl->patches[pl->cnt - 1];
+
+	WARN_ON_ONCE(p->jmp);
+	p->jmp = insn - &pl->insns[p->start] + 1;
+	p->jmp_to = to;
+	p->jmp_back = back;
+}
+
 void bpf_patch_list_release(struct bpf_patch_list *pl)
 {
 	kvfree(pl->patches);
@@ -640,19 +609,100 @@ static int patch_image_map_linfo(struct bpf_patch_image *img, const struct bpf_p
 	return 0;
 }
 
+static bool is_short_jump(const struct bpf_insn *insn)
+{
+	bool is_imm;
+	s64 rel;
+
+	return insn_get_rel(insn, &rel, &is_imm) && !is_imm;
+}
+
+/*
+ * Some jump is out of its 16-bit range. 'tgt' has the targets of all jumps.
+ *
+ *   goto far          ->  gotol far
+ *
+ *   if r1 > r2        ->  if r1 > r2 goto +1     also may_goto, unwind_goto
+ *      goto far           goto +1
+ *                         gotol far
+ *
+ * That moves the targets of other jumps away. One pass is enough: take each
+ * jump for far that would be far with all jumps that it goes over relaxed.
+ */
+static int patch_image_relax(struct bpf_patch_image *img, u32 *tgt)
+{
+	u32 cnt = img->new_cnt, pos, to, lo, hi, n, *map;
+	unsigned long *far __free(kvfree) = NULL;
+	struct bpf_insn *insns = img->insns;
+
+	far = kvcalloc(BITS_TO_LONGS(cnt), sizeof(long), BPF_VERIFIER_GFP);
+	map = img->relaxed = kvmalloc_array(cnt + 1, sizeof(u32), BPF_VERIFIER_GFP);
+	if (!far || !map)
+		return -ENOMEM;
+
+	for (pos = 0, n = 0; pos <= cnt; pos++) {
+		map[pos] = pos + n;
+		n += pos < cnt && is_short_jump(&insns[pos]) ? 2 : 0;
+	}
+	for (pos = 0; pos < cnt; pos++) {
+		if (!is_short_jump(&insns[pos]))
+			continue;
+		lo = min(pos, tgt[pos]);
+		hi = max(pos + 1, tgt[pos]);
+		if (map[hi] - map[lo] <= S16_MAX)
+			continue;
+		if (insns[pos].code == (BPF_JMP | BPF_JA))
+			insns[pos] = BPF_JMP32_A(0);
+		else
+			__set_bit(pos, far);
+	}
+	for (pos = 0, n = 0; pos <= cnt; pos++) {
+		map[pos] = pos + n;
+		n += pos < cnt && test_bit(pos, far) ? 2 : 0;
+	}
+
+	/* like kvmalloc(): the size of a prog fits into 32 bits */
+	if (map[cnt] > INT_MAX / sizeof(*insns))
+		return -ENOMEM;
+	insns = kvrealloc(insns, array_size(map[cnt], sizeof(*insns)), BPF_VERIFIER_GFP);
+	if (!insns)
+		return -ENOMEM;
+	img->insns = insns;
+	for (pos = cnt; pos--;) {
+		to = map[pos];
+		insns[to] = insns[pos];
+		if (!test_bit(pos, far))
+			continue;
+		insns[to].off = 1;
+		insns[to + 1] = BPF_JMP_A(1);
+		insns[to + 2] = BPF_JMP32_A(map[tgt[pos]] - to - 3);
+		tgt[pos] = NO_JUMP;
+	}
+	for (pos = 0; pos <= img->cnt; pos++) {
+		img->new_off[pos] = map[img->new_off[pos]];
+		img->new_tgt[pos] = map[img->new_tgt[pos]];
+	}
+	img->grow += map[cnt] - cnt;
+	img->new_cnt = map[cnt];
+	return 0;
+}
+
 /*
  * Build the image of 'prog' with the queued patches applied in img->insns,
  * without touching 'prog'. img->new_off[] maps each old insn to the start of
  * its patch, img->new_tgt[] to where jumps to it land, both map a removed insn
  * to the next one that stays. img->new_linfo[] is there when insns are
- * removed, see patch_image_map_linfo(). On -ERANGE, img->bad is the old insn
- * whose jump got out of range. No list has both removed and inserted insns.
+ * removed, see patch_image_map_linfo(). On -EFAULT, img->bad is the old insn
+ * whose jump is wrong. No list has both removed and inserted insns.
  */
 int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			 struct bpf_patch_image *img)
 {
-	u32 cnt = prog->len, i, k, n;
+	u32 cnt = prog->len, i, k, n, pos, *map;
+	u32 *tgt __free(kvfree) = NULL;
+	bool far = false;
 	int err;
+	s64 rel;
 
 	memset(img, 0, sizeof(*img));
 	img->cnt = cnt;
@@ -670,7 +720,7 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 			img->grow += pl->patches[k++].len - 1;
 		}
 	}
-	img->new_cnt = cnt + img->grow;
+	img->short_cnt = img->new_cnt = cnt + img->grow;
 
 	if (img->del && prog->aux->nr_linfo) {
 		err = patch_image_map_linfo(img, prog);
@@ -679,34 +729,53 @@ int bpf_patch_list_build(const struct bpf_patch_list *pl, const struct bpf_prog
 	}
 
 	img->insns = kvmalloc_array(img->new_cnt, sizeof(*img->insns), BPF_VERIFIER_GFP);
-	if (!img->insns)
+	tgt = kvmalloc_array(img->new_cnt, sizeof(*tgt), BPF_VERIFIER_GFP);
+	if (!img->insns || !tgt)
 		return -ENOMEM;
 
-	for (i = 0, k = 0; i < cnt; i++) {
+	for (i = 0, k = 0, pos = 0; i < cnt; i++) {
+		struct bpf_insn_patch none = { .off = i, .len = 1 };
 		const struct bpf_insn *src = &prog->insnsi[i];
-		u32 len = 1, pos = img->new_off[i];
+		const struct bpf_insn_patch *p = &none;
 
 		if (k < pl->cnt && pl->patches[k].off == i) {
-			src = &pl->insns[pl->patches[k].start];
-			len = pl->patches[k++].len;
+			p = &pl->patches[k++];
+			src = &pl->insns[p->start];
 		}
 
-		for (n = 0; n < len; n++) {
-			img->insns[pos + n] = src[n];
-			err = patch_list_adj_insn(&img->insns[pos + n], img->new_off,
-						  img->new_tgt, cnt, i, n, len, pos + n);
+		for (n = 0; n < p->len; n++, pos++) {
+			img->insns[pos] = src[n];
+			err = patch_insn_target(img, p, &src[n], n, &tgt[pos]);
 			if (err) {
 				img->bad = i;
 				return err;
 			}
+			rel = (s64)tgt[pos] - pos - 1;
+			far |= is_short_jump(&src[n]) && rel != (s16)rel;
 		}
 	}
+
+	err = far ? patch_image_relax(img, tgt) : 0;
+	if (err)
+		return err;
+
+	for (i = 0, map = img->relaxed; i < img->short_cnt; i++) {
+		if (tgt[i] == NO_JUMP)
+			continue;
+		pos = map ? map[i] : i;
+		rel = (s64)(map ? map[tgt[i]] : tgt[i]) - pos - 1;
+		if (is_short_jump(&img->insns[pos]))
+			img->insns[pos].off = rel;
+		else
+			img->insns[pos].imm = rel;
+	}
 	return 0;
 }
 
 void bpf_patch_image_free(struct bpf_patch_image *img)
 {
 	kvfree(img->insns);
+	kvfree(img->relaxed);
 	kvfree(img->new_linfo);
 	kvfree(img->new_tgt);
 	kvfree(img->new_off);
@@ -1576,7 +1645,6 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 {
 	struct bpf_insn *to = to_buff;
 	u32 imm_rnd = get_random_u32();
-	int off;
 
 	BUILD_BUG_ON(BPF_REG_PARAMS + 3 != MAX_BPF_JIT_REG);
 	BUILD_BUG_ON(BPF_REG_ARENA_SP + 2 != MAX_BPF_JIT_REG);
@@ -1649,15 +1717,9 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 	case BPF_JMP | BPF_JSGE | BPF_K:
 	case BPF_JMP | BPF_JSLE | BPF_K:
 	case BPF_JMP | BPF_JSET | BPF_K:
-		/* Accommodate for extra offset in case of a backjump. */
-		off = from->off;
-		if (off < 0)
-			off -= 2;
-		if (off < S16_MIN)
-			return -ERANGE;
 		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_JMP_REG(from->code, from->dst_reg, BPF_REG_AX, off);
+		*to++ = BPF_JMP_REG(from->code, from->dst_reg, BPF_REG_AX, from->off);
 		break;
 
 	case BPF_JMP32 | BPF_JEQ  | BPF_K:
@@ -1671,16 +1733,9 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 	case BPF_JMP32 | BPF_JSGE | BPF_K:
 	case BPF_JMP32 | BPF_JSLE | BPF_K:
 	case BPF_JMP32 | BPF_JSET | BPF_K:
-		/* Accommodate for extra offset in case of a backjump. */
-		off = from->off;
-		if (off < 0)
-			off -= 2;
-		if (off < S16_MIN)
-			return -ERANGE;
 		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
-		*to++ = BPF_JMP32_REG(from->code, from->dst_reg, BPF_REG_AX,
-				      off);
+		*to++ = BPF_JMP32_REG(from->code, from->dst_reg, BPF_REG_AX, from->off);
 		break;
 
 	case BPF_LD | BPF_IMM | BPF_DW:
@@ -1880,10 +1935,6 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 		if (!rewritten)
 			continue;
 
-		if (rewritten < 0) {
-			err = rewritten;
-			break;
-		}
 		last = env ? bpf_patch_list_add(env, i, insn_buff, rewritten) :
 			     __bpf_patch_list_add(&pl, clone, i, insn_buff, rewritten);
 		if (IS_ERR(last)) {
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index e05d767ab71e..3daa419f75a9 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -198,7 +198,6 @@ struct bpf_insn *bpf_patch_list_add(struct bpf_verifier_env *env, u32 off,
 		return insn;
 	}
 
-	/* -ERANGE takes a second patch with a 16-bit jump back out of it: no pass has one */
 	return __bpf_patch_list_add(pl, env->prog, off, patch, len);
 }
 
@@ -218,13 +217,11 @@ int bpf_patch_list_del(struct bpf_verifier_env *env, u32 off)
 	return __bpf_patch_list_del(pl, env->prog, off);
 }
 
-/* Queue insns to go in front of insn 'off', see __bpf_patch_list_insert(). */
-int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
-			  const struct bpf_insn *insns, u32 cnt)
+static int patch_list_insert(struct bpf_verifier_env *env, u32 off,
+			     const struct bpf_insn *insns, u32 cnt, bool behind)
 {
 	struct bpf_patch_list *pl = &env->patch_list;
 	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
-	int err;
 
 	if (bpf_must_abort())
 		return -EINTR;
@@ -234,11 +231,21 @@ int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
 			    env, "insns inserted at %u out of order", off))
 		return -EFAULT;
 
-	err = __bpf_patch_list_insert(pl, env->prog, off, insns, cnt);
-	if (err == -ERANGE)
-		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-			env->insn_aux_data[off].orig_idx);
-	return err;
+	return __bpf_patch_list_insert(pl, env->prog, off, insns, cnt, behind);
+}
+
+/* Queue insns to go in front of insn 'off', see __bpf_patch_list_insert(). */
+int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
+			  const struct bpf_insn *insns, u32 cnt)
+{
+	return patch_list_insert(env, off, insns, cnt, false);
+}
+
+/* Queue insns to go behind insn 'off', which does not fall through. They are not dead code. */
+int bpf_patch_list_append(struct bpf_verifier_env *env, u32 off,
+			  const struct bpf_insn *insns, u32 cnt)
+{
+	return patch_list_insert(env, off, insns, cnt, true);
 }
 
 void bpf_patch_list_free(struct bpf_verifier_env *env)
@@ -255,20 +262,24 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 			       const struct bpf_insn_aux_data *old,
 			       struct bpf_insn_aux_data *slot)
 {
-	struct bpf_insn_aux_data *last = slot + p->len - 1;
+	struct bpf_insn_aux_data *last = slot + p->self;
 	struct bpf_insn *orig = &p->orig;
 	u32 i;
 
+	memset(slot, 0, sizeof(*slot) * p->len);
 	*last = *old;
 	/* Recompute zext_dst: the last insn of the patch need not be the patched one. */
-	last->zext_dst = bpf_insn_def32(prog, &patch[p->len - 1]) >= 0;
-	memset(slot, 0, sizeof(*slot) * (p->len - 1));
+	last->zext_dst = bpf_insn_def32(prog, &patch[p->self]) >= 0;
 
-	for (i = 0; i < p->len - 1; i++) {
+	for (i = 0; i < p->len; i++) {
+		if (i == p->self)
+			continue;
 		/* Expand the seen count of the patched insn to the patch. */
-		slot[i].seen = last->seen;
+		slot[i].seen = last->seen ?: i > p->self;
 		/* messages name the insn of the original program */
 		slot[i].orig_idx = last->orig_idx;
+		/* for may_goto in front of the insn, see bpf_insert_loop_guards() */
+		slot[i].live_regs_before = last->live_regs_before;
 		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
 		/*
 		 * A copy of the patched insn keeps its marking. Any other
@@ -288,12 +299,12 @@ static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
 	 * systematically mark it for non-stack access if it is not the patched
 	 * insn, otherwise keep the original marking.
 	 */
-	if (bpf_is_mem_insn(&patch[p->len - 1]) &&
-	    memcmp(&patch[p->len - 1], orig, sizeof(*orig)))
+	if (bpf_is_mem_insn(&patch[p->self]) &&
+	    memcmp(&patch[p->self], orig, sizeof(*orig)))
 		last->non_stack_access = true;
 
 	/* indirect jumps to the replaced insn land on p->target */
-	if (last->indirect_target && p->target != p->len - 1) {
+	if (last->indirect_target && p->target != p->self) {
 		slot[p->target].indirect_target = 1;
 		last->indirect_target = 0;
 	}
@@ -325,6 +336,28 @@ static void patch_list_drop_removed(struct bpf_verifier_env *env)
 	}
 }
 
+/*
+ * Make room for the insns that patch_image_relax() added.
+ * A jump to dead code is dead code, see bpf_opt_hard_wire_dead_code_branches().
+ */
+static void patch_list_relax_aux(const struct bpf_patch_image *img, struct bpf_insn_aux_data *data)
+{
+	const u32 *map = img->relaxed;
+	u32 i, k, to;
+
+	for (i = img->short_cnt; i--;)
+		data[map[i]] = data[i];
+	for (i = 0; i < img->short_cnt; i++) {
+		for (k = map[i] + 1; k < map[i + 1]; k++) {
+			to = k + 1 + bpf_jmp_offset(&img->insns[k]);
+			data[k] = (struct bpf_insn_aux_data){
+				.orig_idx = data[map[i]].orig_idx,
+				.seen = data[map[i]].seen ? data[to].seen : 0,
+			};
+		}
+	}
+}
+
 /* Fill 'data', the aux data of the new image, from the aux data of the old one. */
 static void patch_list_remap_aux(struct bpf_verifier_env *env,
 				 const struct bpf_patch_image *img,
@@ -332,22 +365,24 @@ static void patch_list_remap_aux(struct bpf_verifier_env *env,
 {
 	struct bpf_patch_list *pl = &env->patch_list;
 	struct bpf_insn_patch *p;
-	u32 i, k, end;
+	u32 i, k, end, pos;
 
-	for (i = 0, k = 0; i < img->cnt; i = end) {
+	for (i = 0, k = 0, pos = 0; i < img->cnt; i = end) {
 		if (k < pl->cnt && pl->patches[k].off == i) {
 			p = &pl->patches[k++];
 			if (p->len)
 				patch_list_adj_aux(env->prog, p, &pl->insns[p->start],
-						   &env->insn_aux_data[i],
-						   &data[img->new_off[i]]);
+						   &env->insn_aux_data[i], &data[pos]);
+			pos += p->len;
 			end = i + 1;
 			continue;
 		}
 		end = k < pl->cnt ? pl->patches[k].off : img->cnt;
-		memcpy(data + img->new_off[i], env->insn_aux_data + i,
-		       sizeof(*data) * (end - i));
+		memcpy(data + pos, env->insn_aux_data + i, sizeof(*data) * (end - i));
+		pos += end - i;
 	}
+	if (img->relaxed)
+		patch_list_relax_aux(img, data);
 	vfree(env->insn_aux_data);
 	env->insn_aux_data = data;
 	env->insn_aux_data_len = img->new_cnt;
@@ -494,11 +529,6 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 		goto out;
 
 	err = bpf_patch_list_build(pl, prog, &img);
-	if (err == -ERANGE) {
-		verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-			env->insn_aux_data[img.bad].orig_idx);
-		goto out;
-	}
 	if (verifier_bug_if(err == -EFAULT, env, "insn %u jumps out of the program",
 			    img.bad))
 		goto out;
@@ -535,52 +565,6 @@ int bpf_patch_list_commit(struct bpf_verifier_env *env)
 	return err;
 }
 
-/*
- * insn was moved down by delta insns inside its own patch. Operands relative
- * to the pc that point in front of the old position did not move with it.
- */
-static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
-{
-	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
-	s64 off = insn->imm, off_min = S32_MIN;
-	bool is_imm = true;
-
-	if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
-		/* subprog that started at the old position starts with the patch */
-		if (off >= 0)
-			return 0;
-	} else if ((class == BPF_JMP || class == BPF_JMP32) &&
-		   op != BPF_CALL && op != BPF_EXIT) {
-		if (insn->code != (BPF_JMP32 | BPF_JA)) {
-			off = insn->off;
-			off_min = S16_MIN;
-			is_imm = false;
-		}
-		/* jump to itself stays */
-		if (off >= -1)
-			return 0;
-	} else {
-		return 0;
-	}
-
-	off -= delta;
-	if (off < off_min)
-		return -ERANGE;
-	if (is_imm)
-		insn->imm = off;
-	else
-		insn->off = off;
-	return 0;
-}
-
-static bool jumps_to_itself(const struct bpf_insn *insn)
-{
-	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
-
-	return (class == BPF_JMP || class == BPF_JMP32) && op != BPF_CALL && op != BPF_EXIT &&
-	       insn->code != (BPF_JMP32 | BPF_JA) && insn->off == -1;
-}
-
 /* How a subprog leaves when it is out of budget, see push_budget_exit() */
 static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf_subprog_info *sub)
 {
@@ -591,205 +575,62 @@ static struct bpf_insn budget_exit_insn(struct bpf_verifier_env *env, struct bpf
 	return BPF_RAW_INSN(BPF_JMP | BPF_EXIT, 0, BPF_UNWIND_EXIT, 0, 0);
 }
 
-/*
- * may_goto has 16 bits for the offset, and what is between it and its target is going
- * to grow: may_goto itself becomes 10 insns, 14 when it has to save a register.
- */
-#define BPF_GUARD_NEAR	2048
-
-static bool guard_leaves_subprog(const struct bpf_insn_aux_data *aux)
-{
-	return aux->loop_guard && !aux->guard_no_unwind;
-}
-
-/*
- * 'r0 = 0; exit' behind the last insn of the subprog, for all its guards that are near.
- * Returns the number of insns that are going to be added.
- */
-static int append_budget_exit(struct bpf_verifier_env *env, int s)
-{
-	struct bpf_subprog_info *sub = &env->subprog_info[s];
-	int last = (sub + 1)->start - 1, n = 0, i;
-	struct bpf_insn buf[4], *insn;
-
-	for (i = max_t(int, sub->start, last + 1 - BPF_GUARD_NEAR); i <= last; i++)
-		if (guard_leaves_subprog(&env->insn_aux_data[i]))
-			break;
-	if (i > last)
-		return 0;
-
-	buf[n++] = env->prog->insnsi[last];
-	buf[n++] = BPF_MOV64_IMM(BPF_REG_0, 0);
-	if (bpf_ret_reg_pair(env, s))
-		buf[n++] = BPF_MOV64_IMM(BPF_REG_2, 0);
-	buf[n++] = budget_exit_insn(env, sub);
-	insn = bpf_patch_list_add(env, last, buf, n);
-	return IS_ERR(insn) ? PTR_ERR(insn) : n - 1;
-}
-
 /*
  * Add may_goto in front of the insns that the main pass marked, see
  * check_loop_guard(). It verified the edge from the insn to where may_goto goes.
+ *
+ *	may_goto to		or	may_goto leave		see push_budget_exit()
+ *	insn				insn
+ *					...
+ *					last insn of the subprog
+ *				leave:	r0 = 0
+ *					exit
+ *
+ * bpf_do_misc_fixups() keeps the address of the count of may_goto in a register that is
+ * dead at the may_goto. What is live in front of the insn is live in front of its guard.
+ * Nothing else is:
+ *  - The guard of a jump goes where the jump goes.
+ *  - What is live where the guard at the head of a loop goes is live at the head,
+ *    see bpf_head_guard_target().
+ *  - On the way out of the subprog R0, and R2 of a pair, are set to 0.
  */
 int bpf_insert_loop_guards(struct bpf_verifier_env *env)
 {
+	struct bpf_insn patch[2] = { BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 0, 0) };
+	struct bpf_insn leave[3] = { BPF_MOV64_IMM(BPF_REG_0, 0) };
 	struct bpf_insn_aux_data *aux = env->insn_aux_data;
-	int len = env->prog->len, i, r, s, to, n, jmp, err = 0;
-	struct bpf_insn *patch, *insn;
-	int *target, *leave, *moved;
-	bool indirect;
-	u16 *zero;
-	s64 off;
-
-	for (i = 0; i < len; i++)
-		if (aux[i].loop_guard)
-			break;
-	if (i == len)
-		return 0;
-
-	/*
-	 * Where the subprog has 'r0 = 0; exit', 0 if it has none. And how far that moved
-	 * the subprog: guard_to is from the time before.
-	 */
-	leave = kvcalloc(2 * env->subprog_cnt, sizeof(int), BPF_VERIFIER_GFP);
-	if (!leave)
-		return -ENOMEM;
-	moved = leave + env->subprog_cnt;
-	for (s = 0; s < env->subprog_cnt && !err; s++) {
-		leave[s] = append_budget_exit(env, s);
-		if (leave[s] < 0)
-			err = leave[s];
-	}
-	/* A guard cannot jump into a patch that is in the list: 'r0 = 0' has no index yet. */
-	err = err ?: bpf_patch_list_commit(env);
-	if (err) {
-		kvfree(leave);
-		return err;
-	}
-	aux = env->insn_aux_data;
-	len = env->prog->len;
-	for (s = 0, n = 0; s < env->subprog_cnt; s++) {
-		moved[s] = n;
-		n += leave[s];
-		if (!leave[s])
-			continue;
-		i = env->subprog_info[s + 1].start;
-		leave[s] = i - leave[s];
-		/*
-		 * The list gives what is known about an insn to the last insn of its patch,
-		 * but for indirect_target. Here the original insn is the first one.
-		 */
-		indirect = aux[leave[s] - 1].indirect_target;
-		swap(aux[leave[s] - 1], aux[i - 1]);
-		aux[leave[s] - 1].indirect_target = indirect;
-		aux[i - 1].indirect_target = false;
-		/* the last insn may be dead code */
-		while (--i >= leave[s])
-			aux[i].seen = 1;
-	}
-
-	/* where the guard of the insn goes */
-	target = kvcalloc(len, sizeof(int), BPF_VERIFIER_GFP);
-	zero = kvcalloc(len, sizeof(u16), BPF_VERIFIER_GFP);
-	patch = kvcalloc(8, sizeof(*patch), BPF_VERIFIER_GFP);
-	if (!target || !zero || !patch) {
-		err = -ENOMEM;
-		goto out;
-	}
-	for (i = 0; i < len; i++) {
-		s = bpf_find_containing_subprog(env, i) - env->subprog_info;
-		target[i] = aux[i].loop_guard ? aux[i].guard_to + moved[s] : -1;
-		if (guard_leaves_subprog(&aux[i])) {
-			/* see push_budget_exit() */
-			if (leave[s] && leave[s] - i <= BPF_GUARD_NEAR) {
-				target[i] = leave[s];
-			} else {
-				target[i] = -2;
-				zero[i] = BIT(BPF_REG_0);
-				if (bpf_ret_reg_pair(env, s))
-					zero[i] |= BIT(BPF_REG_2);
-			}
-		}
-	}
-
-	for (i = 0; i < len; i++) {
-		to = target[i];
-		if (to == -1)
-			continue;
-		/*
-		 *	may_goto to		or	may_goto +1
-		 *	insn				goto +N
-		 *					r0 = 0, ...
-		 *					exit
-		 *					insn
-		 */
-		n = 0;
-		if (zero[i]) {
-			patch[n++] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 1, 0);
-			patch[n++] = BPF_JMP_A(hweight16(zero[i]) + 1);
-			for (r = BPF_REG_0; r < BPF_REG_FP; r++)
-				if (zero[i] & BIT(r))
-					patch[n++] = BPF_MOV64_IMM(r, 0);
-		}
-		jmp = n++;
-		/* What is behind moves with this patch. The other patches are not there yet. */
-		if (to == -2)
-			off = 0;
-		else if (to > i)
-			off = to - i + n - jmp - 1;
-		else
-			off = to - (i + jmp) - 1;
-		if (off > S16_MAX || off < S16_MIN) {
-			verbose(env, "exit of the loop is too far from insn %d for may_goto\n", i);
-			err = -ERANGE;
-			break;
-		}
-		patch[jmp] = BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, off, 0);
-		if (to == -2)
-			patch[jmp] = budget_exit_insn(env, bpf_find_containing_subprog(env, i));
-		patch[n] = env->prog->insnsi[i];
-		/* A jump to itself is a back edge. It goes through may_goto like the others. */
-		if (jumps_to_itself(&patch[n]))
-			patch[n].off -= n;
-		else
-			err = bpf_adj_moved_insn(&patch[n], n);
-		if (err) {
-			verbose(env, "insn %d cannot be patched due to 16-bit range\n", i);
-			break;
-		}
-		n++;
-		insn = bpf_patch_list_add(env, i, patch, n);
-		if (IS_ERR(insn)) {
-			err = PTR_ERR(insn);
-			break;
+	struct bpf_subprog_info *sub;
+	struct bpf_insn *insn;
+	int i, s, n, err;
+	bool leaves;
+
+	for (s = 0; s < env->subprog_cnt; s++) {
+		sub = &env->subprog_info[s];
+		n = bpf_ret_reg_pair(env, s) ? 3 : 2;
+		leaves = false;
+		for (i = sub->start; i < sub[1].start; i++) {
+			if (!aux[i].loop_guard)
+				continue;
+			/* A jump to itself is a back edge. It goes through may_goto too. */
+			patch[1] = env->prog->insnsi[i];
+			insn = bpf_patch_list_add(env, i, patch, 2);
+			if (IS_ERR(insn))
+				return PTR_ERR(insn);
+			if (aux[i].guard_no_unwind)
+				bpf_patch_list_jump(&env->patch_list, insn - 1, aux[i].guard_to, 0);
+			else
+				bpf_patch_list_jump(&env->patch_list, insn - 1, sub[1].start, n);
+			leaves |= !aux[i].guard_no_unwind;
 		}
-	}
-	err = err ?: bpf_patch_list_commit(env);
-	if (err)
-		goto out;
-	/*
-	 * bpf_do_misc_fixups() keeps the address of the count of may_goto in a register that is
-	 * dead at the may_goto. A new insn has no live_regs_before: all registers would be dead.
-	 * What is live in front of the insn is live in front of its guard. Nothing else is:
-	 *  - The guard of a jump goes where the jump goes.
-	 *  - What is live where the guard at the head of a loop goes is live at the head,
-	 *    see bpf_head_guard_target().
-	 *  - On the way out of the subprog R0, and R2 of a pair, are set to 0.
-	 */
-	aux = env->insn_aux_data;
-	for (i = 0, n = 0; i < len; i++) {
-		if (target[i] == -1)
+		if (!leaves)
 			continue;
-		r = zero[i] ? 3 + hweight16(zero[i]) : 1;
-		aux[i + n].live_regs_before = aux[i + n + r].live_regs_before;
-		n += r;
+		leave[1] = BPF_MOV64_IMM(BPF_REG_2, 0);
+		leave[n - 1] = budget_exit_insn(env, sub);
+		err = bpf_patch_list_append(env, i - 1, leave, n);
+		if (err)
+			return err;
 	}
-out:
-	kvfree(leave);
-	kvfree(target);
-	kvfree(zero);
-	kvfree(patch);
-	return err;
+	return bpf_patch_list_commit(env);
 }
 
 /*
@@ -1530,13 +1371,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			struct bpf_insn *patch = insn_buf;
 
 			*patch++ = BPF_ST_NOSPEC();
-			*patch = *insn;
-			ret = bpf_adj_moved_insn(patch++, 1);
-			if (ret) {
-				verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-					env->insn_aux_data[i].orig_idx);
-				return ret;
-			}
+			*patch++ = *insn;
 			cnt = patch - insn_buf;
 			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
 			if (IS_ERR(insn))
@@ -2262,12 +2097,10 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env)
 	return err;
 }
 
-/* The function requires that first instruction in 'patch' is insnsi[prog->len - 1] */
 static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *patch, int len)
 {
 	struct bpf_subprog_info *info = env->subprog_info;
 	int err, cnt = env->subprog_cnt;
-	struct bpf_insn *last;
 	struct bpf_prog *prog;
 
 	/* We only reserve one slot for hidden subprogs in subprog_info. */
@@ -2275,19 +2108,13 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 		verifier_bug(env, "only one hidden subprog supported");
 		return -EFAULT;
 	}
-	/*
-	 * We're not patching any existing instruction, just appending the new
-	 * ones for the hidden subprog.
-	 */
-	last = bpf_patch_list_add(env, env->prog->len - 1, patch, len);
-	if (IS_ERR(last))
-		return PTR_ERR(last);
-	err = bpf_patch_list_commit(env);
+	err = bpf_patch_list_append(env, env->prog->len - 1, patch, len) ?:
+	      bpf_patch_list_commit(env);
 	if (err)
 		return err;
 	prog = env->prog;
 	info[cnt + 1].start = info[cnt].start;
-	info[cnt].start = prog->len - len + 1;
+	info[cnt].start = prog->len - len;
 	/* The patch ends with the exit. */
 	info[cnt].exit_idx = prog->len - 1;
 	env->subprog_cnt++;
@@ -2295,44 +2122,17 @@ static int add_hidden_subprog(struct bpf_verifier_env *env, struct bpf_insn *pat
 	return 0;
 }
 
-/*
- * Expand may_goto: load the count from the stack, jump to the target of
- * may_goto when it is zero, then the tail that updates the count.
- * 'off' is the offset of may_goto, 'reach' how far it jumps once the patches
- * queued so far are applied, see may_goto_off().
- * Use gotol when 'reach' is too far for 16-bit offset of a conditional jump.
- */
-static int may_goto_expand(struct bpf_insn *insn_buf, int off, int reach,
-			   int stack_off, const struct bpf_insn *tail, int tail_cnt)
-{
-	int cnt = 0;
-
-	/* Forward jump has to step over the tail */
-	off = off >= 0 ? off + tail_cnt : off - 1;
-	reach = reach >= 0 ? reach + tail_cnt : reach - 1;
-
-	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
-	if (reach == (s16)reach) {
-		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
-	} else {
-		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
-		insn_buf[cnt++] = BPF_JMP32_A(off >= 0 ? off : off - 1);
-	}
-	memcpy(insn_buf + cnt, tail, tail_cnt * sizeof(*tail));
-	return cnt + tail_cnt;
-}
-
 /*
  * Timed may_goto. All may_goto of a prog use one count and one timestamp: per-cpu memory of the
  * prog, set in the first insns of the main prog, and by the callers of async callbacks.
  * @reg holds the address. It is a register that is dead at the may_goto, or R0 that is saved at
- * @save_off in the stack. See may_goto_expand() for @off and @reach.
+ * @save_off in the stack. @jmp is the insn that goes where may_goto goes.
  */
-static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off, int reach,
+static int may_goto_expand_timed(struct bpf_insn *insn_buf, int *jmp,
 				 struct bpf_timed_may_goto __percpu *tmg, int reg, int save_off)
 {
 	struct bpf_insn ld_tmg[] = { BPF_LD_IMM64(reg, (__force unsigned long)tmg) };
-	int cnt = 0, jmp, tail_cnt = save_off ? 6 : 5;
+	int cnt = 0;
 
 	if (save_off)
 		insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_10, reg, save_off);
@@ -2343,19 +2143,9 @@ static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off, int reach,
 	if (save_off) {
 		insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
 		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, reg, BPF_REG_10, save_off);
-		jmp = cnt++;
-		insn_buf[jmp] = BPF_JMP32_A(off >= 0 ? off + tail_cnt : off - jmp);
-	} else {
-		jmp = cnt;
-		off = off >= 0 ? off + tail_cnt : off - jmp;
-		reach = reach >= 0 ? reach + tail_cnt : reach - jmp;
-		if (reach == (s16)reach) {
-			insn_buf[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, off);
-		} else {
-			insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 1);
-			insn_buf[cnt++] = BPF_JMP32_A(off >= 0 ? off : off - 1);
-		}
 	}
+	*jmp = cnt;
+	insn_buf[cnt++] = save_off ? BPF_JMP32_A(0) : BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 0);
 	insn_buf[cnt++] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
 	insn_buf[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
 	/* AX is the argument and the return value */
@@ -2367,27 +2157,6 @@ static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off, int reach,
 	return cnt;
 }
 
-/*
- * The offset of may_goto at 'idx' once the patches queued in front are applied.
- * The patches that a forward may_goto jumps over aren't queued yet, so its
- * offset stays as it is.
- */
-static int may_goto_off(struct bpf_verifier_env *env, const struct bpf_insn *insn,
-			u32 idx)
-{
-	struct bpf_patch_list *pl = &env->patch_list;
-	u32 tgt = idx + insn->off + 1;
-	int off = insn->off;
-	u32 k = pl->cnt;
-
-	if (off >= 0)
-		return off;
-	/* all queued patches are in front of idx */
-	while (k > 0 && pl->patches[k - 1].off >= tgt)
-		off -= pl->patches[--k].len - 1;
-	return off;
-}
-
 #ifdef CONFIG_64BIT
 struct bpf_div_magic {
 	u64 m;		/* multiplier, sign extended for signed division */
@@ -2599,7 +2368,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	if (env->seen_exception && !env->exception_callback_subprog) {
 		struct bpf_insn *patch = insn_buf;
 
-		*patch++ = env->prog->insnsi[insn_cnt - 1];
 		*patch++ = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*patch++ = BPF_EXIT_INSN();
 		ret = add_hidden_subprog(env, insn_buf, patch - insn_buf);
@@ -2846,7 +2614,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 		if (bpf_is_may_goto_insn(insn) && timed_may_goto) {
 			u16 live = env->insn_aux_data[i].live_regs_before;
-			int reg, save_off = 0;
+			int reg, jmp, save_off = 0, to = i + insn->off + 1;
 
 			/* a register that is dead here holds the address of the count */
 			for (reg = BPF_REG_0; reg <= BPF_REG_9; reg++)
@@ -2865,28 +2633,26 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				prog->aux->timed_may_goto = tmg;
 			}
 			prog->jit_required = 1;
-			cnt = may_goto_expand_timed(insn_buf, insn->off, may_goto_off(env, insn, i),
-						    tmg, reg, save_off);
+			cnt = may_goto_expand_timed(insn_buf, &jmp, tmg, reg, save_off);
 
 			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
 			if (IS_ERR(insn))
 				return PTR_ERR(insn);
+			bpf_patch_list_jump(&env->patch_list, insn - (cnt - 1 - jmp), to, 0);
 			goto next_insn;
 		} else if (bpf_is_may_goto_insn(insn)) {
-			int stack_off = -stack_depth - 8;
-			struct bpf_insn tail[] = {
-				BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1),
-				BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off),
-			};
+			int stack_off = -stack_depth - 8, to = i + insn->off + 1;
 
 			stack_depth_extra = 8;
-			cnt = may_goto_expand(insn_buf, insn->off,
-					      may_goto_off(env, insn, i),
-					      stack_off, tail, ARRAY_SIZE(tail));
+			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off);
+			insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, 0);
+			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
+			insn_buf[3] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off);
 
-			insn = bpf_patch_list_add(env, i, insn_buf, cnt);
+			insn = bpf_patch_list_add(env, i, insn_buf, 4);
 			if (IS_ERR(insn))
 				return PTR_ERR(insn);
+			bpf_patch_list_jump(&env->patch_list, insn - 2, to, 0);
 			goto next_insn;
 		}
 
@@ -3521,9 +3287,7 @@ static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
 	int reg_loop_ctx = BPF_REG_8;
 
 	struct bpf_insn *insn_buf = env->insn_buf;
-	u32 callback_start;
 	struct bpf_insn *last;
-	s32 callback_offset;
 	u32 cnt = 0;
 
 	/* This represents an inlined version of bpf_iter.c:bpf_loop,
@@ -3565,19 +3329,13 @@ static int inline_bpf_loop(struct bpf_verifier_env *env, int position,
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_10, r7_offset);
 	insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_10, r8_offset);
 
-	/*
-	 * Note: insn_buf[12] is the BPF_CALL_REL instruction. Jumps and calls
-	 * out of a patch are relative to the patch placed at 'position': its
-	 * 'cnt' insns push what is behind 'position' down by cnt - 1.
-	 */
-	callback_start = env->subprog_info[callback_subprogno].start;
-	callback_offset = callback_start - position;
-	if (callback_start > position)
-		callback_offset += cnt - 1;
-	insn_buf[12].imm = callback_offset - 12 - 1;
-
 	last = bpf_patch_list_add(env, position, insn_buf, cnt);
-	return PTR_ERR_OR_ZERO(last);
+	if (IS_ERR(last))
+		return PTR_ERR(last);
+	/* insn_buf[12] is the BPF_CALL_REL instruction */
+	bpf_patch_list_jump(&env->patch_list, last - (cnt - 1 - 12),
+			    env->subprog_info[callback_subprogno].start, 0);
+	return 0;
 }
 
 static bool is_bpf_loop_call(struct bpf_insn *insn)
diff --git a/tools/testing/selftests/bpf/prog_tests/blinding_log.c b/tools/testing/selftests/bpf/prog_tests/blinding_far_jump.c
similarity index 51%
rename from tools/testing/selftests/bpf/prog_tests/blinding_log.c
rename to tools/testing/selftests/bpf/prog_tests/blinding_far_jump.c
index 658a8494dae5..0b3e09864b32 100644
--- a/tools/testing/selftests/bpf/prog_tests/blinding_log.c
+++ b/tools/testing/selftests/bpf/prog_tests/blinding_far_jump.c
@@ -1,24 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
-/* The verifier log of a prog whose constants are blinded */
+/* A far jump in a prog whose constants are blinded */
 
 #include <test_progs.h>
 #include <linux/filter.h>
 #include "sysctl_helpers.h"
 
 #define NR_CONSTS 11000
-#define LOG_SIZE 65536
 
 /*
  * A prog of one function gets its constants blinded when its runtime is
  * selected. Each 'r0 += 1' becomes 3 insns, which pushes the jump over them
  * out of its 16-bit range. Serial, because it sets bpf_jit_harden.
  */
-void serial_test_blinding_log(void)
+void serial_test_blinding_far_jump(void)
 {
 	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
-	LIBBPF_OPTS(bpf_prog_load_opts, opts);
+	char old[16] = {}, pkt[64] = {};
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = pkt, .data_size_in = sizeof(pkt));
 	struct bpf_insn *insns;
-	char old[16] = {}, *log;
 	int i, cnt = 0, fd;
 
 	if (!is_jit_enabled()) {
@@ -28,32 +27,25 @@ void serial_test_blinding_log(void)
 	}
 
 	insns = calloc(NR_CONSTS + 3, sizeof(*insns));
-	log = calloc(1, LOG_SIZE);
-	if (!ASSERT_OK_PTR(insns, "insns") || !ASSERT_OK_PTR(log, "log"))
-		goto out;
+	if (!ASSERT_OK_PTR(insns, "insns"))
+		return;
 
-	insns[cnt++] = BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32);
-	insns[cnt++] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, NR_CONSTS);
+	/* mark is 0 */
+	insns[cnt++] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, offsetof(struct __sk_buff, mark));
+	insns[cnt++] = BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, NR_CONSTS);
 	for (i = 0; i < NR_CONSTS; i++)
 		insns[cnt++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
 	insns[cnt++] = BPF_EXIT_INSN();
 
-	opts.log_buf = log;
-	opts.log_size = LOG_SIZE;
-	/* log stats only: level 1 logs each insn, which wraps the buffer */
-	opts.log_level = 4;
 	if (sysctl_set_or_fail(harden, old, "2"))
 		goto out;
-	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, cnt, &opts);
+	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, cnt, NULL);
 	sysctl_set_or_fail(harden, NULL, old);
-	/* don't mind whether the interpreter takes the prog or the load fails */
-	if (fd >= 0)
-		close(fd);
-
-	/* expect the message about the jump in the log and in log_true_size */
-	ASSERT_HAS_SUBSTR(log, "cannot be patched due to 16-bit range", "log");
-	ASSERT_EQ(opts.log_true_size, strlen(log) + 1, "log_true_size");
+	if (!ASSERT_OK_FD(fd, "load"))
+		goto out;
+	if (ASSERT_OK(bpf_prog_test_run_opts(fd, &opts), "run"))
+		ASSERT_EQ(opts.retval, NR_CONSTS, "retval");
+	close(fd);
 out:
 	free(insns);
-	free(log);
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_and.c b/tools/testing/selftests/bpf/progs/verifier_and.c
index fb64ea9928f1..8ef5f87a9766 100644
--- a/tools/testing/selftests/bpf/progs/verifier_and.c
+++ b/tools/testing/selftests/bpf/progs/verifier_and.c
@@ -90,7 +90,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if w0 < 0x1 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R1 !read_ok'` */
-__xlated_unpriv("goto pc-1") /* `r1 = *(u32*)(r1 + 512)`, sanitized dead code */
+__xlated_unpriv("goto pc-2") /* `r1 = *(u32*)(r1 + 512)`, sanitized dead code */
 __xlated_unpriv("r0 = 0")
 #endif
 __naked void known_subreg_with_unknown_reg(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index b39275b92e6a..9dc23611332e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -626,7 +626,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("exit")
 #endif
 __naked void _32bit_and_64bit_arithmetic_test1(void)
@@ -655,7 +655,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 invalid mem access 'scalar'` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("exit")
 #endif
 __naked void _32bit_and_64bit_arithmetic_test2(void)
@@ -709,7 +709,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if r1 != 0x0 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("r0 = 0")
 #endif
 __naked void reg_0_reg_xor_1(void)
@@ -742,7 +742,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if w1 != 0x0 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("r0 = 0")
 #endif
 __naked void reg32_0_reg32_xor_1(void)
@@ -775,7 +775,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if r1 > 0x0 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("r0 = 0")
 #endif
 __naked void reg_2_reg_xor_3(void)
@@ -862,7 +862,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if r1 >= 0x0 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("r0 = 0")
 #endif
 __naked void reg_0_reg_xor_3(void)
@@ -896,7 +896,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if w1 >= 0x0 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R0 min value is outside of the allowed memory range` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("r0 = 0")
 #endif
 __naked void reg32_0_reg32_xor_3(void)
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 6f90dac78fcd..44730109db5d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -437,7 +437,7 @@ __success_unpriv
 __xlated_unpriv("w0 = 0")
 __xlated_unpriv("exit")
 __xlated_unpriv("nospec") /* inserted to prevent `frame pointer is read only` */
-__xlated_unpriv("goto pc-1")
+__xlated_unpriv("goto pc-2")
 #endif
 __naked void mov64sx_s32_varoff_2(void)
 {
@@ -465,7 +465,7 @@ __success_unpriv
 __xlated_unpriv("w0 = 0")
 __xlated_unpriv("exit")
 __xlated_unpriv("nospec") /* inserted to prevent `frame pointer is read only` */
-__xlated_unpriv("goto pc-1")
+__xlated_unpriv("goto pc-2")
 #endif
 __naked void mov64sx_s32_varoff_3(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index aada57330ff2..445d3aed0a05 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -126,29 +126,123 @@ __naked void patch_list_may_goto(void)
 	: __clobber_all);
 }
 
-/*
- * The conditional jump skips 8200 divisions, which their patches turn into
- * 32800 insns, too far for its 16-bit offset.
- */
-SEC("raw_tp")
-__description("patch list: jump pushed out of range by patches")
-__failure __msg("insn 2 cannot be patched due to 16-bit range")
-__naked void patch_list_jump_out_of_range(void)
+/* the JITs that support gotol */
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	defined(__TARGET_ARCH_powerpc) || defined(__TARGET_ARCH_s390) || \
+	defined(__TARGET_ARCH_loongarch) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)
+
+/* The patches turn 8200 divisions into 32800 insns, too far for a 16-bit offset. */
+#define DIVS ".rept 8200; r7 /= r6; .endr;"
+
+/* len is not 0 and mark is 0, which the verifier doesn't know */
+#define FAR_JUMP(name, field)				\
+__naked void name(void)					\
+{							\
+	asm volatile (					\
+	"r6 = *(u32 *)(r1 + %[off]);"			\
+	"r7 = 1;"					\
+	"r0 = 1;"					\
+	"if r6 == 0 goto 0f;"				\
+	DIVS						\
+	"r0 = 2;"					\
+"0:	exit;"						\
+	:						\
+	: __imm_const(off, offsetof(struct __sk_buff, field)) \
+	: __clobber_all);				\
+}
+
+SEC("tc")
+__description("patch list: far jump, taken")
+__success __retval(1)
+__arch_x86_64
+__arch_arm64
+__xlated("3: if r6 == 0x0 goto pc+1")
+__xlated("4: goto pc+1")
+__xlated("5: gotol pc+32801")
+FAR_JUMP(patch_list_far_jump_taken, mark)
+
+SEC("tc")
+__description("patch list: far jump, not taken")
+__success __retval(2)
+FAR_JUMP(patch_list_far_jump_not_taken, len)
+
+/* The first jump is in range until the second one gets two more insns. */
+SEC("tc")
+__description("patch list: far jump over a far jump")
+__success __retval(1)
+__naked void patch_list_far_jump_over_far_jump(void)
 {
-	asm volatile ("					\
-	call %[bpf_get_prandom_u32];			\
-	r1 = r0;					\
-	if r0 == 0 goto 0f;				\
-	.rept 8200;					\
-	r0 /= r1;					\
-	.endr;						\
-0:	r0 = 0;						\
-	exit;						\
-"	:
-	: __imm(bpf_get_prandom_u32)
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[mark]);"
+	"r7 = 1;"
+	"r0 = 1;"
+	"if r6 == 0 goto 0f;"
+	"if r6 == 1 goto 1f;"
+	".rept 8191; r7 /= r6; .endr;"
+	"r0 = 2;"
+	"r0 = 2;"
+"0:	exit;"
+"1:	r0 = 3;"
+	"exit;"
+	:
+	: __imm_const(mark, offsetof(struct __sk_buff, mark))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("patch list: far goto, far jump back, far may_goto")
+__success __retval(3)
+__naked void patch_list_far_loop(void)
+{
+	asm volatile (
+	"r6 = *(u32 *)(r1 + %[len]);"
+	"r7 = 1;"
+	"r0 = 0;"
+	"goto 1f;"
+"0:	.8byte %[may_goto];"
+	DIVS
+	"r0 += 1;"
+"1:	if r0 < 3 goto 0b;"
+	"exit;"
+	:
+	: __imm_const(len, offsetof(struct __sk_buff, len)),
+	  __imm_insn(may_goto, BPF_RAW_INSN(BPF_JMP | BPF_JCOND, 0, 0, 8202, 0))
 	: __clobber_all);
 }
 
+/* The loop has no bound. The verifier adds may_goto at its head, the exit is far. */
+#define FAR_GUARD(name, off, expect)				\
+__naked __noinline __used static unsigned long name##_func(void) \
+{							\
+	asm volatile (					\
+"0:	call %[bpf_get_prandom_u32];"			\
+	"if r0 != 1 goto +1;"				\
+	"goto 0b;"					\
+	".rept 33000; r3 = 0; .endr;"			\
+	"if r0 != 2 goto +1;"				\
+	".8byte %[back];"				\
+	"r1 = %[far_data] ll;"				\
+	"r0 = *(u8 *)(r1 + " #off ");"			\
+	"exit;"						\
+	:						\
+	: __imm(bpf_get_prandom_u32),			\
+	  __imm_addr(far_data),				\
+	  __imm_insn(back, BPF_JMP32_A(-33005))		\
+	: __clobber_all);				\
+}							\
+SEC("tc") expect					\
+__naked void name(void)					\
+{							\
+	asm volatile ("call " #name "_func; exit;" ::: __clobber_all); \
+}
+
+char far_data[8] SEC(".data.far") = { [7] = 9 };
+
+FAR_GUARD(patch_list_far_guard, 7, __success __retval(9))
+FAR_GUARD(patch_list_far_guard_bad, 8, __failure __msg("invalid access to map value"))
+#endif
+
 /* the JITs that support gotox, as in verifier_gotox.c */
 #if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
 	defined(__TARGET_ARCH_powerpc) || \
@@ -220,8 +314,9 @@ __arch_arm64
 __success
 __xlated("12: if r6 != 0x0 goto pc-3")
 __xlated("...")
-__xlated("32783: if r13 != 0x0 goto pc+1")
-__xlated("32784: gotol pc-32773")
+__xlated("32783: if r13 == 0x0 goto pc+1")
+__xlated("32784: goto pc+1")
+__xlated("32785: gotol pc-32774")
 __naked void patch_list_may_goto_gotol(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index 62f998216d4b..7406e8a7d180 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -615,7 +615,7 @@ __retval(0)
 #ifdef SPEC_V1
 __xlated_unpriv("if r0 == 0x0 goto pc+2")
 __xlated_unpriv("nospec") /* inserted to prevent `R7 invalid mem access 'scalar'` */
-__xlated_unpriv("goto pc-1") /* sanitized dead code */
+__xlated_unpriv("goto pc-2") /* sanitized dead code */
 __xlated_unpriv("exit")
 #endif
 __naked void alu32_mov_u32_const(void)
-- 
2.55.0

