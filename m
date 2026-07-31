Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A145A2A5
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524885; cv=none; b=eRmof+rMVw50/iDU2TgvZALjKGacWuFmqkhCy3M0fFM8jMxUnp3dmtwGZAHAGLvG130BpXQUuJO/hZSHu3fSlMsaQwdR2S4PY73x9ztYdSQY0TnVbwkOsT0Pdw+r1O9yndtmlXWb0ExLTAccmNu+54Hv5Y3YCiUCGUi0EHf+zAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524885; c=relaxed/simple;
	bh=aLmMO99wfWGjSDW0UrCXS0PPB67GG//5Y51ZtC9UAfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQiO6GHEk+VYmXGo7RsgewmMG7wlF7ABre8YRNXu/VOBgRSy/ST2ZihzsEmO1my3+1CxgfmwpXxe+Ok6cC7xaNPZ0JMavMYdfHx82ZwZeLgxpSDLPCGOCyCIPweBcdQwQWW6bnMVWc/Xvcft8xNIkW/Deiu3y1RvMt441LOX5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYjjDqGj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYjjDqGj"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso14042895ad.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785524883; x=1786129683; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sCoXjrn2BS/9vxSQx1zhAYQlwYdoCYKZyIirKzHzprE=;
        b=TYjjDqGjXkXCO8LMGasMBJl0kUY4Y5CpTp7NwwT3Ghrif7ql3sPAajkqOi5djuG4rd
         7HG9j0pqPLHpp3+6xx8Z9giSSSRw5TMTSpUcsF0Uiorko5w2e3VcQk2+I8tRI+RRhp2h
         k7AUYJcFxLDS3Yu/GmI2G5gJ1lYYE5OYLoPhUnASwmsBJ3j5WflS3W/InP8lCib6VkQl
         2MU4Rl5ZCUWw8ps15CafBvvQoXLAHe2nHSto5oVN4wAtTRUXLVodkXtgLZu2wNwyw1WH
         hJh4Ptdg+H3/WT1+2dHJBQXlBowj7rjlZhtTSb/bLB6pt5Wc1VWVvGvMHkli7hFd8vYk
         MaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524883; x=1786129683;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCoXjrn2BS/9vxSQx1zhAYQlwYdoCYKZyIirKzHzprE=;
        b=cCafVyYTsyaUEgTmB150oRe2QiRuxQQKcF7Dd+YiV90guCAFWWBBRh0gIcyQxhOwKR
         dfYhqZyQz+lT71NGKrmfOEWwDh0rHo0SxCduQinaUecy6lsNtcQX3sm52T9BZvNbXtxE
         OLh4pdVCGsE57Ymuwzpw73Nf6f8gBnqItICJfoRbSPpTim7OBmWKWnc1xi8yrCnRx9OM
         2Xhaq0pcqoyRk3qmBy8RTUAtn/wBRVzWPoEwhRZmb3z0FkcY7E859UR+kGwKyzOGjWgw
         UTlXeS8kpe5c/hcNau/LXxzWGW+CRErYDH78fmv4Wc2+XodzlbdCbIiaQWU52duxTNbC
         wCyg==
X-Gm-Message-State: AOJu0Yzm25q04oPMoDiF4YhBHCkOTNx9LfzLC696Mvh55RHAJjZwBzVL
	7p8QdOI7uJ7V2qXmEUE8K5WX9CMFnbvNr6E32kXGxdGQX/ZvgDR5oI96usKkxNIG
X-Gm-Gg: AR+sD13FlQpA2oUP7uFMduOq6i6/nBl8Ab3gqWyp+cEqn5qHhNDzrT4OXx6ilOz8oSr
	si4kKjk4gILsV8G7zwcET12jA8K/F+SYTQcBOo7kvRBD9Bm8UsmmwgMdCcWiUFAiDbUiRPAalWC
	jXZQCk9WHnUKnyC80nScSNbwpP97xPPurxX2NKE5o2CCH0BMtJGNby1890oIYz1t0OHAl+2k8wE
	jT5PNTicTens//QdsT81hS2IF4wruh6+qUp89qevGRIBGmmluBAZpHGfbaHJ0LE6nYysu2cHwZS
	8tTyv/DH8DiXvKO0+inTXNtssSyoo2ehA9b3OaBSMI2cyQD3wHd/hw7lSxgxl666GpLm4PWWRsY
	1WimKPqsGNkgqx6MsNnP+apWr0ER2zHpSSUp40F9NTfV1pr4Qdicz73Vln/RoZ/yefY1qBuyR2r
	tqWr0lev7gzmuhV7Je+UvReRx+HwVogEx8n1r2rKfXXmytRLLSd1/+f+16K6el6XIk4H4fDH74N
	yb+I81fAW2XTXbt2QiIMz33kFA2ZQOO7lIQnNpj7iqO
X-Received: by 2002:a05:6a20:3d19:b0:3c3:dce5:b1a0 with SMTP id adf61e73a8af0-3c92a93cc60mr872729637.64.1785524883203;
        Fri, 31 Jul 2026 12:08:03 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm4815801c88.3.2026.07.31.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:08:02 -0700 (PDT)
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
	gimm78064@gmail.com
Subject: [PATCH bpf-next 4/5] bpf: simplify the bpf_is_reg64() signature
Date: Fri, 31 Jul 2026 12:07:45 -0700
Message-ID: <20260731-static-zext-v1-4-98a4dc73e94b@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After the previous commit this function is only used in a context
where destination register's property is queried.
Hence, simplify the function by removing the 'regno' and 't'
parameters.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  2 +-
 kernel/bpf/fixups.c          |  4 ++--
 kernel/bpf/verifier.c        | 39 +++++++--------------------------------
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 66f506535cbd..321ebd308d38 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1628,7 +1628,7 @@ struct bpf_kfunc_desc_tab {
 };
 
 /* Functions exported from verifier.c, used by fixups.c */
-bool bpf_is_reg64(struct bpf_insn *insn, u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t);
+bool bpf_is_reg64(struct bpf_insn *insn);
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len);
 void bpf_mark_subprog_exc_cb(struct bpf_verifier_env *env, int subprog);
 bool bpf_allow_tail_call_in_subprogs(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 6125598d16a8..73ab95573f60 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -52,7 +52,7 @@ int bpf_insn_def32(struct bpf_insn *insn)
 {
 	int dst_reg = insn_def_regno(insn);
 
-	if (dst_reg < 0 || bpf_is_reg64(insn, dst_reg, NULL, DST_OP))
+	if (dst_reg < 0 || bpf_is_reg64(insn))
 		return -1;
 
 	return dst_reg;
@@ -623,7 +623,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 			 *       BPF_STX + SRC_OP, so it is safe to pass NULL
 			 *       here.
 			 */
-			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
+			if (bpf_is_reg64(&insn)) {
 				if (class == BPF_LD &&
 				    BPF_MODE(code) == BPF_IMM)
 					i++;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0709dded013e..d5b6fef1ad89 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3028,11 +3028,10 @@ static void mark_stack_slots_scratched(struct bpf_verifier_env *env,
 }
 
 /* This function is supposed to be used by the following 32-bit optimization
- * code only. It returns TRUE if the source or destination register operates
- * on 64-bit, otherwise return FALSE.
+ * code only. It returns TRUE if the destination register operates on 64-bit,
+ * otherwise return FALSE.
  */
-bool bpf_is_reg64(struct bpf_insn *insn,
-	      u32 regno, struct bpf_reg_state *reg, enum bpf_reg_arg_type t)
+bool bpf_is_reg64(struct bpf_insn *insn)
 {
 	u8 code, class, op;
 
@@ -3053,11 +3052,6 @@ bool bpf_is_reg64(struct bpf_insn *insn,
 			 */
 			if (insn->src_reg == BPF_PSEUDO_CALL)
 				return false;
-			/* Helper call will reach here because of arg type
-			 * check, conservatively return TRUE.
-			 */
-			if (t == SRC_OP)
-				return true;
 
 			return false;
 		}
@@ -3073,22 +3067,11 @@ bool bpf_is_reg64(struct bpf_insn *insn,
 	if (class == BPF_ALU || class == BPF_JMP32)
 		return false;
 
-	if (class == BPF_LDX) {
-		if (t != SRC_OP)
-			return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
-		/* LDX source must be ptr. */
-		return true;
-	}
+	if (class == BPF_LDX)
+		return BPF_SIZE(code) == BPF_DW || BPF_MODE(code) == BPF_MEMSX;
 
-	if (class == BPF_STX) {
-		/* BPF_STX (including atomic variants) has one or more source
-		 * operands, one of which is a ptr. Check whether the caller is
-		 * asking about it.
-		 */
-		if (t == SRC_OP && reg->type != SCALAR_VALUE)
-			return true;
+	if (class == BPF_STX)
 		return BPF_SIZE(code) == BPF_DW;
-	}
 
 	if (class == BPF_LD) {
 		u8 mode = BPF_MODE(code);
@@ -3098,15 +3081,7 @@ bool bpf_is_reg64(struct bpf_insn *insn,
 			return true;
 
 		/* Both LD_IND and LD_ABS return 32-bit data. */
-		if (t != SRC_OP)
-			return  false;
-
-		/* Implicit ctx ptr. */
-		if (regno == BPF_REG_6)
-			return true;
-
-		/* Explicit source could be any width. */
-		return true;
+		return false;
 	}
 
 	if (class == BPF_ST)

-- 
2.55.0
