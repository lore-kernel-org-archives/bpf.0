Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46948443ABA
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136408; cv=none; b=Ul4zfNQHpOX+zoZocBcV4Ewo30aSt7oAjZz67BHrffGDQUipqOVolw/6royHDT/4zeF72s7aeI9zrLa905utMSR50LbkXNxEglCtvRVNdcibir6EUuGBJd10mCPyafSX/XnRtpN7HuhR6W1Ee6jXR/EUiTKxHar3vMjR6cEi/hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136408; c=relaxed/simple;
	bh=YGVayNgGLdrFK3B09wjZXi2o9VUV9Pe7FEsl0lxsdZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0FtfV7BKvKcplp+Wr7dyxjMkPALhE4+ou/+RoRoI43r2NVB1Y7xgYjZz9sqcRv/UOe9KlyfgKZj+CHNfkEFu0Jd0QSdxQtDfeqeKyLJqeakNrfTGNpYEFnBcK3pqXcmfNHY1POH3ocCsWDRTRcVhvAZW9rMhon3wXHj/D7OE3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+QGSzwn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+QGSzwn"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8485ef63b68so5851121b3a.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136406; x=1786741206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d9eHJZ9gdu14JA1y98SgYzVjOtwuXek1wzmX65Aqgtc=;
        b=T+QGSzwn6M/NxUkIZMdIeX3dAd8eIjZ5bgO0uEoUP+yYJajIvklQ4Zev/aHG5eiyCO
         ZuGhrlJI4P2LDDvPuZ++ZpWsLaamKYWNIN2V2uclG6bz9tnIHU03x1ccEA8Ffy3wxb/z
         67JvRXqrOfYwyTH0icg7YKAyP/44kMnKfyxahhebAfbfihHZBPlP63BcvDVG72BkMMAx
         cby37vps4z30pEzkDESsvAJU3+F3z3UPXS3875YCCr4vG2RVM888Jcolu8eLToLA8/bX
         dyr5aZ4y5XurUDdxQ8MGK5E2dcW033yb60Ry4AdqNRUvlMLCY12k1R2oE8VmZU0B8X2u
         TXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136406; x=1786741206;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9eHJZ9gdu14JA1y98SgYzVjOtwuXek1wzmX65Aqgtc=;
        b=TKKLx9/bgIdpf7g9wXMf+mtSJexOG8hh/6OGjfYscx++hVUPVb4gLBvSdHr58tt3+R
         2sdWvKJDHJmSgSJqYdnC7ihQVJDFcZrzhsbCNXPmK78psYo4mXkkVrCiZ3InAE7UWN9n
         MTcvpIkS2GKJpWc2iJsdGQ1Re/xirZPGTzmdIJVXH8CoPRfGy7ySoUdqMP9v7z9gV8GH
         ecn7B+37D+B17FhtRx5qW2EN5jR60MdQ3+chlXakg6gbGoFgLoBSroHWZ1teEGHLRLXT
         Mpvt/N8FDmTmZmug7bcUnT5dTyU3hzYIdQ9P0HJqik8ckNjVonGsVA2/witezvOQsAFz
         mvAw==
X-Gm-Message-State: AOJu0Yza1J116txU0aVqTdWEnziLE7zZln2pbIh6gPjkqgeudopfQeud
	1AYeqFZH+8njpi/2/Hs85zafL47v2ABDHU7RXsVmXM0BAcnaz7SJhqenJMHDPpvM
X-Gm-Gg: AR+sD11mo/Wh6SXijRBJe4aT2NfE1V+dvHZCiCDo98XYE0oHya/E0rtXWUfnveE10dZ
	xqJMZn65Ua3xvAIJyfbkhbKfJw1dkf+8XYnm/OiP/olp30IJ61hgokc6b+UibRdmrLy/TnOcY02
	w7FAYGfaOmNw5j61oZ35orYymPN+yefaSXuBcU0F150xN0MaTEZMKRZPzhf9/QNIdEFDAr7dXZO
	KB7RKNmEMXcs1sSrpsh2kylcVwVYlM9ieHr7/p9d3QWHCCNi9043asZfXCTlpd/hDZSnF3Nn5J6
	Os1P3cH/snw0bwHmUGLUFbX3tUYUSISFxeLGYH9dSunobAk7gbRCd5lTOYc92yYu47nSbYGYuxM
	pyIxdHXaQzFaelHqWrHWE4jRu6czR+EmueEGDbZEOi5IG9BqhIW83CvDcoYXmW3FXqz2SbQpRvq
	QQDsbg85sdP8Scta6u20rFdSTVsfvTJG9cggezJnmcCaaOtwc8KE+2kz+GK1i8qYis4rXk8gOUT
	ZSjGskv+lkOwKZkblWjLdgFiJDQOgLh+MIEivOS8lvWo30hdFOAfdRF
X-Received: by 2002:a05:6a20:7350:b0:3c3:f371:1ea9 with SMTP id adf61e73a8af0-3cb85df12fbmr29183947637.10.1786136406396;
        Fri, 07 Aug 2026 14:00:06 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.14.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:00:06 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v4 6/7] bpf: simplify the bpf_is_reg64()
Date: Fri,  7 Aug 2026 13:59:35 -0700
Message-ID: <20260807-static-zext-v4-6-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After the previous commit bpf_is_reg64() is only used in a context
where destination register's property is queried, and only for
instructions for which insn_def_regno() >= 0.
Hence, simplify the function by:
- removing unused parameters;
- removing code paths considering BPF_JMP{,32} instructions;
- streamlining the condition expressions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c | 110 +++++++++++++---------------------------------------
 1 file changed, 27 insertions(+), 83 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 447c54828cb9..661e2d13a604 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -64,95 +64,43 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	}
 }
 
-/* This function is supposed to be used by the zero extension optimization
- * code only. It returns TRUE if the source or destination register operates
- * on 64-bit, otherwise return FALSE.
+/*
+ * For use only in combination with insn_def_regno() >= 0.
+ * Returns TRUE if the destination register operates on 64-bit,
+ * otherwise return FALSE.
  */
-static bool bpf_is_reg64(struct bpf_prog *prog, struct bpf_insn *insn,
-			 u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
+static bool bpf_is_reg64(struct bpf_prog *prog, struct bpf_insn *insn)
 {
-	u8 code, class, op;
-
-	code = insn->code;
-	class = BPF_CLASS(code);
-	op = BPF_OP(code);
-	if (class == BPF_JMP) {
-		/* BPF_EXIT for "main" will reach here. Return TRUE
-		 * conservatively.
-		 */
-		if (op == BPF_EXIT)
-			return true;
-		if (op == BPF_CALL) {
-			/* BPF to BPF call will reach here because of marking
-			 * caller saved clobber with DST_OP_NO_MARK for which we
-			 * don't care the register def because they are anyway
-			 * marked as NOT_INIT already.
-			 */
-			if (insn->src_reg == BPF_PSEUDO_CALL)
-				return false;
-			/* Helper call will reach here because of arg type
-			 * check, conservatively return TRUE.
-			 */
-			if (t == SRC_OP)
-				return true;
-
-			return false;
-		}
-	}
+	u8 class = BPF_CLASS(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	u8 size = BPF_SIZE(insn->code);
+	u8 op = BPF_OP(insn->code);
+	bool mode_mem;
+
+	/* subregister endiness swap */
+	if ((class == BPF_ALU || class == BPF_ALU64) && op == BPF_END && insn->imm != 64)
+		return false;
 
-	if (class == BPF_ALU64 && op == BPF_END && (insn->imm == 16 || insn->imm == 32))
+	/* w0 += 1 */
+	if (class == BPF_ALU && op != BPF_END)
 		return false;
 
 	/* address space casts converted to BPF_ALU, see bpf_do_misc_fixups() */
 	if (is_addr_space_cast32(prog, insn))
 		return false;
 
-	if (class == BPF_ALU64 || class == BPF_JMP ||
-	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
-		return true;
-
-	if (class == BPF_ALU || class == BPF_JMP32)
+	/* non 64-bit, non signed extended loads */
+	mode_mem = mode == BPF_MEM || mode == BPF_PROBE_MEM || mode == BPF_PROBE_MEM32;
+	if (class == BPF_LDX && mode_mem && size != BPF_DW)
 		return false;
 
-	if (class == BPF_LDX) {
-		if (t != SRC_OP)
-			return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
-		/* LDX source must be ptr. */
-		return true;
-	}
-
-	if (class == BPF_STX) {
-		/* BPF_STX (including atomic variants) has one or more source
-		 * operands, one of which is a ptr. Check whether the caller is
-		 * asking about it.
-		 */
-		if (t == SRC_OP && reg->type != SCALAR_VALUE)
-			return true;
-		return BPF_SIZE(code) == BPF_DW;
-	}
-
-	if (class == BPF_LD) {
-		u8 mode = BPF_MODE(code);
-
-		/* LD_IMM64 */
-		if (mode == BPF_IMM)
-			return true;
-
-		/* Both LD_IND and LD_ABS return 32-bit data. */
-		if (t != SRC_OP)
-			return  false;
-
-		/* Implicit ctx ptr. */
-		if (regno == BPF_REG_6)
-			return true;
-
-		/* Explicit source could be any width. */
-		return true;
-	}
+	/* atomics, see insn_def_regno() */
+	if (class == BPF_STX && size != BPF_DW)
+		return false;
 
-	if (class == BPF_ST)
-		/* The only source register for BPF_ST is a ptr. */
-		return true;
+	/* both LD_IND and LD_ABS return 32-bit data. */
+	if (class == BPF_LD && (mode == BPF_IND || mode == BPF_ABS))
+		return false;
 
 	/* Conservatively return true at default. */
 	return true;
@@ -166,7 +114,7 @@ int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
-	if (dst_reg < 0 || bpf_is_reg64(prog, insn, dst_reg, NULL, DST_OP))
+	if (dst_reg < 0 || bpf_is_reg64(prog, insn))
 		return -1;
 
 	return dst_reg;
@@ -733,11 +681,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			if (load_reg == -1)
 				continue;
 
-			/* NOTE: arg "reg" (the fourth one) is only used for
-			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
-			 *       here.
-			 */
-			if (bpf_is_reg64(env->prog, &insn, load_reg, NULL, DST_OP)) {
+			if (bpf_is_reg64(env->prog, &insn)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;

-- 
2.55.0
