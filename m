Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89C385D82
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136403; cv=none; b=aXNcB+hrsIbb1P6ZhYjuszBXkL7qJHymlgjVknEKPoSw+gTAXW3E/+vrVZO6gJOxP20IGrxhvmtNZaF9zHk0ypMBlsBgUukO7JZjTO7XKTrQSIll85edBTbuqxYb84PjqV8zUJvSZ2CteYH6qoktSXkgfJEVfwD44NSqzssb4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136403; c=relaxed/simple;
	bh=v+eE1A8EJsyFDDvqHBFb0mBN25QRbdMe9U/0gWlOpwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mLt/DP1s5vPxvpySN3X6KkBou38X+donhr2dqPAVJ/PtomsC05+lEEOwIQtts0iCgZNtNIylaK9CerG3k1t751hxs9Wydmm9eg8PVgQu1LtB4hMRKnM3LS8sA7nMpgWHFYPbbuRDZsUE6pxnmmzuWs0IL75VGpIW2ALMjktkLrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHcXK6+C; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHcXK6+C"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso3129693a91.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136402; x=1786741202; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5BeGCtWlDtvU5m7crsFbBexFgqGR3AZH5aryi3WIrJ0=;
        b=oHcXK6+CMcdTnJA0Pod3ms9smRoXiVzutSEGDFiyuLhOq9f8ADJ8SWxfB+joj2N6hM
         pIFFMNcKfEoUoA+ehEwJ1ev3Im1oknPRUGxsGgd6dKpMf48HYL+1wtLauFBSkGKhTuy0
         UEyKn3krZzQDGZBn1k/oHF5LPHo/KGYPWvmQiS4srJqydSyEbasAk5T1nAFXVv5/mqsx
         wmDfIQt6Lf+KjbOVyiFEILfn0ExM28UPAagKMJdLWYEAa1qNdxcsVqr5ZAUfdXz56uUn
         xiIrDKt+6SE8I8gPqT6A+yG06FYG4gyPUr3hSIjap73K5m8JDtATd7iTz0zFW9Ffl+LN
         OJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136402; x=1786741202;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5BeGCtWlDtvU5m7crsFbBexFgqGR3AZH5aryi3WIrJ0=;
        b=CF74Xfu91M00LCUeAHcxD9e7jSGATbTtFb3yCtfC/pq+FzVtcVqWmlKcfaVhP2ZL7I
         l0SGfSHZlneyyIW8eAIDvT2d+EkU7syUCXT9YtVWnE2RQ3YOw2ZyqWGnZrnvDZdVcChk
         LJRYRmkNvLqv0rk81gh+5NRQbUHO+3m7YOhDD444mqCCPkv2JigI1VXY6v48MUpWW7sJ
         8dZKYfr3JNGESNVKPyxmyh9Bfbd5NDdxj0IblACbfqqOXdV2Ny/zzaolVIRBIFLsJXYe
         UoQiSOIemJOqhaNBZP2Oz8mUQDnvlvT/emrLNl2PeGKd/++rcTbAPLjS2IGMthG2D/0I
         BPMA==
X-Gm-Message-State: AOJu0YzJXXmqbDy1PrXiwhUDCGlp7KOP2wnAn0m0wBeuEOSvlR57ZG+w
	gRcc7B24T17UnBAcmACkkzHqiAbCcyzdmRpS8sZZMGATp9NrlRfcJ+ABFdYgwRVw
X-Gm-Gg: AR+sD139JoiC/By3fyT4dnXpv6C1KfsZiT5dcFxpYhCmf6QCczWUBggM0UiMuTcV/h/
	acVsj4j/L202DsXEo2yfeHJRm41EOoTOjtxDbnY0p57D3Z3n4quOS2hO67km4BC3UgK5aSFmL/q
	BnjxcHNrO6WP2goE7qx11xIacA8hzUvAt4IvoZU1mRHENYU5BtHBk7jQ8UkvQMKAj7ROibUgTXr
	R9B5K15E0kXXvQmvEZNAz3BMfChi1FeBqWtspFG1eUU/uhfO7Pmx8CJ6y0bocDjvU5OTV8/epnC
	dAQZrYf3xbmx5Mzq88LkHiGIyKv2UjsxQWcI0QmWr1MuCoAnqKGTn8xpszYALpwG47TqVLTD4OS
	9Rr/GmbWcq8DUM37eFmFNKNfqVcNprq70SM/J8Q2EjZKOJT6MvU3OuUSnCzoqrDk7PyNq3LWGrN
	flnF7jIuL+EDkbYexMqNl3Adtkxz/2q6BbLAI8DlBjzqHV+ka/+CDGrTWpS2DasA2tm8YOr2/Q8
	ZBJpR7wszPm8ECY6j+C2X5USseB2j/NliqlUrVPuiDG
X-Received: by 2002:a17:90b:2684:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-392821f55abmr2973187a91.1.1786136401407;
        Fri, 07 Aug 2026 14:00:01 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:00:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/7] bpf: move bpf_is_reg64() to fixups.c
Date: Fri,  7 Aug 2026 13:59:32 -0700
Message-ID: <20260807-static-zext-v4-3-b6c270013c77@gmail.com>
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

The following patches are going to remove bpf_is_reg64() users from
everywhere except fixups.c, and also make it dependent on functions
local to fixups.c. Move the function before hand to simplify the
review. Non functional change.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/fixups.c   | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c | 90 ---------------------------------------------------
 2 files changed, 90 insertions(+), 90 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 5f7843648189..d2ff416d7ad6 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -64,6 +64,96 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	}
 }
 
+/* This function is supposed to be used by the zero extension optimization
+ * code only. It returns TRUE if the source or destination register operates
+ * on 64-bit, otherwise return FALSE.
+ */
+bool bpf_is_reg64(struct bpf_insn *insn,
+		  u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
+{
+	u8 code, class, op;
+
+	code = insn->code;
+	class = BPF_CLASS(code);
+	op = BPF_OP(code);
+	if (class == BPF_JMP) {
+		/* BPF_EXIT for "main" will reach here. Return TRUE
+		 * conservatively.
+		 */
+		if (op == BPF_EXIT)
+			return true;
+		if (op == BPF_CALL) {
+			/* BPF to BPF call will reach here because of marking
+			 * caller saved clobber with DST_OP_NO_MARK for which we
+			 * don't care the register def because they are anyway
+			 * marked as NOT_INIT already.
+			 */
+			if (insn->src_reg == BPF_PSEUDO_CALL)
+				return false;
+			/* Helper call will reach here because of arg type
+			 * check, conservatively return TRUE.
+			 */
+			if (t == SRC_OP)
+				return true;
+
+			return false;
+		}
+	}
+
+	if (class == BPF_ALU64 && op == BPF_END && (insn->imm == 16 || insn->imm == 32))
+		return false;
+
+	if (class == BPF_ALU64 || class == BPF_JMP ||
+	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
+		return true;
+
+	if (class == BPF_ALU || class == BPF_JMP32)
+		return false;
+
+	if (class == BPF_LDX) {
+		if (t != SRC_OP)
+			return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
+		/* LDX source must be ptr. */
+		return true;
+	}
+
+	if (class == BPF_STX) {
+		/* BPF_STX (including atomic variants) has one or more source
+		 * operands, one of which is a ptr. Check whether the caller is
+		 * asking about it.
+		 */
+		if (t == SRC_OP && reg->type != SCALAR_VALUE)
+			return true;
+		return BPF_SIZE(code) == BPF_DW;
+	}
+
+	if (class == BPF_LD) {
+		u8 mode = BPF_MODE(code);
+
+		/* LD_IMM64 */
+		if (mode == BPF_IMM)
+			return true;
+
+		/* Both LD_IND and LD_ABS return 32-bit data. */
+		if (t != SRC_OP)
+			return  false;
+
+		/* Implicit ctx ptr. */
+		if (regno == BPF_REG_6)
+			return true;
+
+		/* Explicit source could be any width. */
+		return true;
+	}
+
+	if (class == BPF_ST)
+		/* The only source register for BPF_ST is a ptr. */
+		return true;
+
+	/* Conservatively return true at default. */
+	return true;
+}
+
 /* Return TRUE if INSN has defined any 32-bit value explicitly. */
 static bool insn_has_def32(struct bpf_insn *insn)
 {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a9358e04bbe2..784216d834af 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3058,96 +3058,6 @@ static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
 		mark_stack_slot_scratched(env, spi - i);
 }
 
-/* This function is supposed to be used by the following 32-bit optimization
- * code only. It returns TRUE if the source or destination register operates
- * on 64-bit, otherwise return FALSE.
- */
-bool bpf_is_reg64(struct bpf_insn *insn,
-	      u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
-{
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
-
-	if (class == BPF_ALU64 && op == BPF_END && (insn->imm == 16 || insn->imm == 32))
-		return false;
-
-	if (class == BPF_ALU64 || class == BPF_JMP ||
-	    (class == BPF_ALU && op == BPF_END && insn->imm == 64))
-		return true;
-
-	if (class == BPF_ALU || class == BPF_JMP32)
-		return false;
-
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
-
-	if (class == BPF_ST)
-		/* The only source register for BPF_ST is a ptr. */
-		return true;
-
-	/* Conservatively return true at default. */
-	return true;
-}
-
 static void mark_insn_zext(struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg)
 {

-- 
2.55.0
