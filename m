Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8D41837E
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121130; cv=none; b=SIItUFVljCseEM9qJA1TXlhmBqbjIEDHQKVFqEtk9RoZf/Bug+WdKOaEbN+Pac8R8LD7jqotwBy0Wid0FfEngnOMoaFbE+KgmZcsGNV3SuhmugfIsG796/M06vvYgWG6qct8O3o9aSqEIpnhPP1MwiNAQojEUIgKuC0ge0YuxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121130; c=relaxed/simple;
	bh=1r8gfB2D2pICR769w9WSeZ2oIKrIqQA5x1rPlb4jVnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxnkruliSYHsUlx1poJrGa1NtZc4KQsndBbpp7vFY1OC3JncNByuaQImpFTWxVHGWZAzr8xQg1FBdl5zrxNEhnlDcdY02HctVHqMFKNzsTDFEzzwIyLxDzCR7z2AI95lKfm+a26AJXBF6b7xpdC4wyzVbete4KjIPhfP41rrwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlJcSxFq; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlJcSxFq"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc4c3304833so222861a12.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121128; x=1791725928; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ylUh233xJVAsndPybAUOY/Lj+9FGAbXjDr7tg3yOFJI=;
        b=XlJcSxFqb8gog4OBzisDBe2KPxq3sW+EqdBDUjWzvDDBTUVIQB1o4DOM7ama0s/Klk
         EIaB1PmuW5cDeplBKt7abAie/gF44vHUaJ0BlPJTbq+4w1C2CJXGT5sI5yu3kcJlxl58
         VYvDkMDCc3UmHbceNAZOIRXmXmx8TnxHqtlsh3GOVou/jPM2TFRJdqoKU5Z1dTg+yc5d
         bN6sMOqH4k3rBPAfBN0sJ1K9gemwIomo39OSHks/HA4m6ciXn1W2UvG4QKE2atH9o9d5
         M47DNwNjnXEpcqy1w3yRgNED5Seqre5HxIvQUHJ0gNwugEBlvLPw5Roxp5LHcML4bt++
         6MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121128; x=1791725928;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylUh233xJVAsndPybAUOY/Lj+9FGAbXjDr7tg3yOFJI=;
        b=IxRIxw+kCq2zZqQgdz/qRq5X4mh8rkbWHNVzZc6zyQMzXDbTt3iMk7feHHkuh1rK+4
         XmmRbnDvtE/3THK9bUJdoWf8C6b145tzsa82M5QU9PyCU3ubttFytmg7hkfyzQ8jaH/c
         79xyTZO6JCf80UoE4avSw+rnpp8DXd4RlJ4MPjcXn8bFbJ4S2IofndLUfkd0KsJ05NTK
         4XkY809wuwJ2jxTMB6P4Vwe09SwzfdaNZ/VhB+Eid862KxI7d0Bq//DfH3STn94wdrNM
         dKkPELOtPlphQJ1L1+uRwpbAH01J3TijDMltXdO52YASttfDRV1tgub6VqGQq9/bbLGT
         +Zyw==
X-Gm-Message-State: AFuF++kHdQVKsy+1RUpQM8RphFjiKd9fK17MVmTG9/k+o9JkSXGO/HS0
	BJ5V5kK7MtYedScohOF/0OqJbtfN6l1u8Wlvq0btEOgeU4iH9siY1i4x3aOaig==
X-Gm-Gg: AYBFou2CMX/tDWvbwjJJuEgAkv3fMK+0sWgqlYmEcsJ6cY4RVPCgr4vtNMyYqBRESW+
	MPMgYquBmUeOcl4ZYTxOh+GhdgP0c5hzOqBe0u4ZX7Bn8Ef15PNo1H71BlipVv0TNhrVLG3kgfl
	8EzjrSNQutvsxBCKjY9VrBHcTNO5h68KT82GQIb1BHFx4GxGVJlsB7s133N6aDP3wYeEEMWkNIC
	yR3tZZzCoYjZMQocTOoCfC1vydtOnTb3CRsb8M32ZQSvp/93L90ew/xyW8xGAqcWnOfNpxT9Qx0
	vsoBKccW05P/Jjgku79cQsnhZaql9/Ax3VMZSE1eDVXq44/qw9qPwhe0/AJ69c98M0OyRVpCyKY
	teDmwdts75YicDG8W5xyMpZsFlvg00KuRsHEIHyJC3wxfbaUBRdIppOE0MSyyhgNps0n0W2115K
	dMzcLI+RBJLDPainiBWC/WCarud9PWg+kKtJ8YAhlIJtL0CTFPCi45eCGmZTHmiteCmT71gmFUK
	RLcdVIdejbmhx0=
X-Received: by 2002:a05:6a21:e08c:b0:3de:59fe:d71c with SMTP id adf61e73a8af0-3e0bd2286d7mr9806908637.60.1791121128497;
        Sun, 04 Oct 2026 06:38:48 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:47 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 12/43] bpf: expose comparison opcode transformations
Date: Sun,  4 Oct 2026 06:37:54 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-12-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Expose the existing helpers as bpf_rev_opcode() and bpf_flip_opcode()
and declare them in bpf_verifier.h. The helpers are used by SCEV
logic while analyzing loop conditions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 16 +++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 79ca8b28a83a..4371fb3405ac 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1872,4 +1872,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
 
+int bpf_flip_opcode(u32 opcode);
+u8 bpf_rev_opcode(u8 opcode);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 98e64a138921..4dd71bf7c1d9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17231,8 +17231,6 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 
 static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
 				u8 opcode, bool is_jmp32);
-static u8 rev_opcode(u8 opcode);
-
 /*
  * Learn more information about live branches by simulating refinement on both branches.
  * regs_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
@@ -17241,7 +17239,7 @@ static u8 rev_opcode(u8 opcode);
 static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
 {
 	/* Fallthrough (FALSE) branch */
-	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
+	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, bpf_rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(&env->false_reg1);
 	reg_bounds_sync(&env->false_reg2);
 	/*
@@ -17427,7 +17425,7 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
 	return simulate_both_branches_taken(env, opcode, is_jmp32);
 }
 
-static int flip_opcode(u32 opcode)
+int bpf_flip_opcode(u32 opcode)
 {
 	/* How can we transform "a <op> b" into "b <op> a"? */
 	static const u8 opcode_flip[16] = {
@@ -17458,7 +17456,7 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
 		pkt = dst_reg;
 	} else if (dst_reg->type == PTR_TO_PACKET_END) {
 		pkt = src_reg;
-		opcode = flip_opcode(opcode);
+		opcode = bpf_flip_opcode(opcode);
 	} else {
 		return -1;
 	}
@@ -17513,7 +17511,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 
 		/* arrange that reg2 is a scalar, and reg1 is a pointer */
 		if (!is_reg_const(reg2, is_jmp32)) {
-			opcode = flip_opcode(opcode);
+			opcode = bpf_flip_opcode(opcode);
 			swap(reg1, reg2);
 		}
 		/* and ensure that reg2 is a constant */
@@ -17547,7 +17545,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 /* Opcode that corresponds to a *false* branch condition.
  * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
  */
-static u8 rev_opcode(u8 opcode)
+u8 bpf_rev_opcode(u8 opcode)
 {
 	switch (opcode) {
 	case BPF_JEQ:		return BPF_JNE;
@@ -17582,7 +17580,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	case BPF_JGT:
 	case BPF_JSGE:
 	case BPF_JSGT:
-		opcode = flip_opcode(opcode);
+		opcode = bpf_flip_opcode(opcode);
 		swap(reg1, reg2);
 		break;
 	default:
@@ -17649,7 +17647,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 			reg1->var_off = tnum_or(reg1->var_off, tnum_const(val));
 		}
 		break;
-	case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see rev_opcode() */
+	case BPF_JSET | BPF_X: /* reverse of BPF_JSET, see bpf_rev_opcode() */
 		if (!is_reg_const(reg2, is_jmp32))
 			swap(reg1, reg2);
 		if (!is_reg_const(reg2, is_jmp32))

-- 
2.53.0
