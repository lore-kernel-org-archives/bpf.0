Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FEE3195F9
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702280; cv=none; b=u+bEYfb8to5pEv0KhZFmpF3jcHw7ii3Mem8csVa/5+kvN8ufEwoAUe9l1/re7xyU1SdLb0JjA82WPoSkSYHWnpALBWICGvwKigL83ahSABd+PExJqWubFGyehjeAulYl53RITDR0RDcAacS8aWRGV8ftsM4WrL6oOQv6/GhItlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702280; c=relaxed/simple;
	bh=JtA7+KWTZI5IrlH11sJQg6KPWDI4/2tf6fBc2zdM8bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejMZV5H9xlJukbheJhPaDaoACtCN/Saa6qn+eYa0dDNi2pRqfvDhSobwoEbBpVn7Vy/c1gpcZMPVp/WGu/nc99sRGFcf0i+qv4hXsAcWLzPHz3vi1z3GaN3D5yOcdrijwA8S17ycGl5h4uJMDbn8pmVMfUObyrUuOYkh2VAWNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qITSPZBg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qITSPZBg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso20695475ad.3
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702278; x=1786307078; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YoxESrYKH532kdDMRu842kKI0hmGAo+SQlnBS2Xaedk=;
        b=qITSPZBgKQ3hB++cOdknRUhlyYsgeviF62DjWFuKdlhinCXGZMnVx/56+wfTqk7JhH
         J4qSFtrF4uCEHzI3GbS29/m5FVdCPjejjpebERgYh1mbSSD2rKjQcvw3qLfUqtoWSkJt
         wq4m9jdoD3R9zrSGeT19hwsDqgB/AZUOV8hf5UsdMu5V79b6E30CeD2Tg9Fyrv5mhcwD
         Jeq+uib6EiAW4Knne7qXTxs4w9/JxaV9VgRJuPg4AtH+9UurpeuRI7CjpzphgTNIDaNV
         ZQqn8p/6O7V2WV4/Oogg0/MpkRyMLRnRJ1BSlceBSaWrQ2Bv/FS/bqlR7olK/wp+4OHa
         HOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702278; x=1786307078;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoxESrYKH532kdDMRu842kKI0hmGAo+SQlnBS2Xaedk=;
        b=PczMpvwrljoT+S8qQk4UAjUonAXtZONIc/pcCZNF+tUVjifrC4a5lVtWpZyGPow6OL
         Fihpn3y0ZU+R35sczIT9CuHE7V4qp4C18U+Aav006lrF9pg5d2cMLb4SabDFJ/2YSaGA
         5Hbds8ZN+ZcrYnynH6dxioRPeOELjjM902dy+AkUXYXPFO9shrM6pB8NuOCMDtWvUHUR
         UEgmfxEbdvBlb5vqlgIMrEMzbL32Y83CKHJpgoKj0Sl3aLFrrM0yKg/Ld8+qeldJK4V8
         0hd6myBaGXZwwPitnj/xF1vr0yVeyuWCKopcAhJT0ebi9RgguwYgM1LqQAy15XWrZVaP
         YN7Q==
X-Gm-Message-State: AOJu0Yztu8GWDDYVzzXNG5mR0K9BDBrTgFXX4IHnn8TGX9dhsEqNPVz6
	AfkouN+oyBKvXdhpcO/9cGg1sQofQSfvERRwwcUpYuzIJ/UaZZnJNgFTmpUhGA==
X-Gm-Gg: AR+sD103ho6zHJAq7E1acId/ySpF4izmRqpKAUJSBxO7ClomJswSZoy+n98TJmeGB0h
	gvlMNjURG5l1ur9usmaDltyIIQNJXQ5tLMGvBM73Er5/caS5fAKXwM3cROjBURA2hpCgfLwZppB
	5Kdx7n1D1bcA2R7N5QmbP+f0LNH4m2K9jBwH8EgS2VbmdEeSJYSWW4yf3CsxaIa1jHDl+lQZt7g
	P+aplDLItscDDyy7ur/xatkasJ1dUdZlS3cZPPzcR0AQBzjX7W52k52BDXMX3yx8jpT0ykTA2dH
	/yb1dn9VyrvKEfWfLT2ZMv08wW4Z2gzfhzdQiRDI049Zr5GTJH7uLZeHIrvppEy36WzbVlTYbwp
	X9BoVFz7/TDxVACQ62S/xKmWv26bQsGK6nh/BHpEUFm5UybENGUszdKMOIS5m56KUJgMiI9A7MB
	TyH0sr7wBqY3vC582SO0a5jFIhMw2OFLz0t6KkuZIfaqlGL8GCocLeKMH19LEeoEt3mH1S1+wv9
	CgAkg==
X-Received: by 2002:a17:902:c40c:b0:2cf:c6f2:6083 with SMTP id d9443c01a7336-2d0523bd68bmr73395215ad.33.1785702278301;
        Sun, 02 Aug 2026 13:24:38 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea128sm28590865ad.40.2026.08.02.13.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:24:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 4/5] bpf: simplify the bpf_is_reg64()
Date: Sun,  2 Aug 2026 13:24:20 -0700
Message-ID: <20260802-static-zext-v3-4-3456b2604574@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
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
 include/linux/bpf_verifier.h |  1 -
 kernel/bpf/fixups.c          | 51 ++++++++++++++++++++++---
 kernel/bpf/verifier.c        | 90 --------------------------------------------
 3 files changed, 45 insertions(+), 97 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 956243547446..39b0db2a4f17 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1626,7 +1626,6 @@ struct bpf_kfunc_desc_tab {
 };
 
 /* Functions exported from verifier.c, used by fixups.c */
-bool bpf_is_reg64(struct bpf_insn *insn, u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t);
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
 bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6125598d16a8..7b3510d46b37 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -44,6 +44,49 @@ static int insn_def_regno(const struct bpf_insn *insn)
 	}
 }
 
+/*
+ * For use only in combination with insn_def_regno() >= 0.
+ * Returns TRUE if the destination register operates on 64-bit,
+ * otherwise return FALSE.
+ */
+static bool bpf_is_reg64(struct bpf_insn *insn)
+{
+	u8 class = BPF_CLASS(insn->code);
+	u8 mode = BPF_MODE(insn->code);
+	u8 size = BPF_SIZE(insn->code);
+	u8 op = BPF_OP(insn->code);
+	bool mode_mem;
+
+	/* subregister endiness swap */
+	if ((class == BPF_ALU || class == BPF_ALU64) && op == BPF_END && insn->imm != 64)
+		return false;
+
+	/* w0 += 1 */
+	if (class == BPF_ALU && op != BPF_END)
+		return false;
+
+	/* cast from as(1) to as(0), PTR_TO_ARENA is 32-bit */
+	if (insn->code == (BPF_ALU64 | BPF_MOV | BPF_X) &&
+	    insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1)
+		return false;
+
+	/* non 64-bit, non signed extended loads */
+	mode_mem = mode == BPF_MEM || mode == BPF_PROBE_MEM || mode == BPF_PROBE_MEM32;
+	if (class == BPF_LDX && mode_mem && size != BPF_DW)
+		return false;
+
+	/* atomics, see insn_def_regno() */
+	if (class == BPF_STX && size != BPF_DW)
+		return false;
+
+	/* both LD_IND and LD_ABS return 32-bit data. */
+	if (class == BPF_LD && (mode == BPF_IND || mode == BPF_ABS))
+		return false;
+
+	/* Conservatively return true at default. */
+	return true;
+}
+
 /*
  * Return the 32-bit subregister defined by INSN, or -1 if INSN does not
  * explicitly define a 32-bit value.
@@ -52,7 +95,7 @@ int bpf_insn_def32(struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
-	if (dst_reg < 0 || bpf_is_reg64(insn, dst_reg, NULL, DST_OP))
+	if (dst_reg < 0 || bpf_is_reg64(insn))
 		return -1;
 
 	return dst_reg;
@@ -619,11 +662,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			if (load_reg == -1)
 				continue;
 
-			/* NOTE: arg "reg" (the fourth one) is only used for
-			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
-			 *       here.
-			 */
-			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
+			if (bpf_is_reg64(&insn)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e51cf5238f60..45d4c0a00a5d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3027,96 +3027,6 @@ static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
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
 static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *regs, u32 regno,
 			   enum bpf_reg_arg_type t)
 {

-- 
2.53.0
