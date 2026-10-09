Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDCE4C6527
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542923; cv=none; b=ZW951enlin6ZcaKPFq4fnIJ3myvVEyxbDckbFqM8M1c1LgJZCEiOhiK2ZgMsKUfqbby2VlrZWpXjvcXp/jb1PqM4IuhjZX4LQ2dWIB/Pn0OGtKiZyAjRt+zrj03aSkH0Zel2qy9h/pyCJWqgLCmIeoQiumW3SUM0FYybZvJa7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542923; c=relaxed/simple;
	bh=aQ5ql/ThPqc2drDKd9KFjYHJkVZOeTQwOo2dvvwsRFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWWjb05gha9mLn0ejw0Mwq6T2gpzA/eoQDj0jEI2LeaI0IQwt9s+XJXbxPxRW214SVmkj88YlCRCnvgQeZeEpWh6F0UFNl/tvLKMwiOirL9LsN3HznD1FhKP9H1EZSFl1tFNQvcB4rR1BsfIFWPDURKXgWYRn4zIwkoWFK3pP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V88QzsCF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V88QzsCF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a813079a55so1037753a91.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542910; x=1792147710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FTsB4vQDpfYAfl/5GjpZskAviX+F9n59KtkOh4uxJ7s=;
        b=V88QzsCFLpEpVJb5LrMTVd9KqyEccr6xOEpi/7BGTJmGQqRe74WWTeNgusIoxmNXVP
         cS2gxCLmlSc4q9KbW6v1ZFhogVbeTcdxoHyfgpfpJTEb/74ejYEt9/2c4vZ2OQlLGgxG
         dqTUMgHWtYNN/SHexF0C/BdjpgoFmVhl41jzNxn5DmPrOeRaPcYBsIf3i2EMdYa6cRgH
         5bGdCi1fRVsglfmP8TjhqpGBWa3C7smMw/cXxpfU1B0iS9bJTzJac94kXcawaA7ZglXF
         5Jw1Q8Yq7zWo+YSO/zn5+/LX8/HCoKStzUqVi6hT2yH3+5SBB2FjHZ1Z+rREsVGMZ1Gx
         3b2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542910; x=1792147710;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FTsB4vQDpfYAfl/5GjpZskAviX+F9n59KtkOh4uxJ7s=;
        b=TR8O73+DFHolZaQ/RncPvirZBAoiHgatuqVBKuFSAzZTVqChWS7nrMERtrDoC8Lb+/
         qWLbEuLNxHvKWkFG5y2BGM9gFRtuzvrB1l9SXuwStCQPO8R4icP6yfGhcmh6sGfc7mf6
         behftpTTQcRuPvQQnJzSLYMRlg2ySTAULxsiH8KzjH21ufcS3wE6KHxeBPHA6VLPFarm
         Vba4AEQjpiTsv8K5efzr2v/B/Kk1ar115AxKOM6xhhYZ+x/79lOzKFWVM6KCqTy0xNoP
         1EpOehFIC4tcngROsju5/Q7xZK7WgPPGBiNsQoR/7vAnp0loUmdjbHtYrrDKDTAyW9X8
         t94A==
X-Gm-Message-State: AFq9FYIXTS0gxl//YtSJppm/vs7ZGPt9nG1RJ5LcJiW9crp5OF57W+n/
	JcvU1kKgPIO5X3pBDgl5QNvuPVDksJADisDh0YmsUSflL2Qs7+IcNP4JJEfyYFIU
X-Gm-Gg: AYBFou29hxBLN6TBwfBCKWYRmuDT3ts0g6tyOZEoVyyVkzklmPLiTx4IYlFt0VRMQL1
	ekc6kgUC7+yDVfnK1YxDAGn4jtw/A3XmzBcNlLxWFwf5Gw64UQcfjnRR+DpaeMcXmPMP/bg6CTp
	YRuObnWtF4Cmws/cGKdpRmN6uj86E4+kwTxT0BtS8LdVn0SNYM+XQ7u48gFrUkwJKQmq47dGzsT
	F3iuCL+JmwTJQI0XRVNoCjpA02O5OuptEYeMGLPF4Foq/+ti8AsBQjogFg5NxVJjNx7ij/AHbce
	Eepg7Wo5jyfs6vA3cUnVzhJCCnv+6iSewgzBdcnMRNh/2g17IUbA6HCQeTDsDIVQVSGiWwxm0SM
	+xy/HIJSprfLL7PM89g3FCEbRZp9cAq5w1R8XgN8j2Ya5MMxWJqlO8BNa9rrZwsQ1ypnkTOjOTL
	5XvWRYt16MDFy0o/0K/c+JqhDthQdjvoqbEPuRXYBOZp8FK3BKfdq/YNU/ojWO/mOki0W7PUtkl
	iyd3U9/b0S+TlM=
X-Received: by 2002:a17:90b:4b:b0:3a7:96d:feaf with SMTP id 98e67ed59e1d1-3ab3a9a0c59mr838629a91.16.1791542909643;
        Fri, 09 Oct 2026 03:48:29 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 15/51] bpf: expose bpf_rev_opcode() and bpf_flip_opcode()
Date: Fri,  9 Oct 2026 03:47:33 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-15-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Expose the existing helpers verifier.c:rev_opcode() and
verifier.c:flip_opcode() as bpf_rev_opcode() and bpf_flip_opcode()
and declare them in bpf_verifier.h. The helpers are used by SCEV
logic while analyzing loop conditions.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |  3 +++
 kernel/bpf/verifier.c        | 16 +++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0422d4a1be01..5ec9495d42b1 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1875,4 +1875,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
 
+int bpf_flip_opcode(u32 opcode);
+u8 bpf_rev_opcode(u8 opcode);
+
 #endif /* _LINUX_BPF_VERIFIER_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 50cb564be9f7..e317cdae749e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17333,8 +17333,6 @@ static void find_good_pkt_pointers(struct bpf_verifier_state *vstate,
 
 static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state *reg2,
 				u8 opcode, bool is_jmp32);
-static u8 rev_opcode(u8 opcode);
-
 /*
  * Learn more information about live branches by simulating refinement on both branches.
  * regs_refine_cond_op() is sound, so producing ill-formed register bounds for the branch means
@@ -17343,7 +17341,7 @@ static u8 rev_opcode(u8 opcode);
 static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8 opcode, bool is_jmp32)
 {
 	/* Fallthrough (FALSE) branch */
-	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opcode), is_jmp32);
+	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, bpf_rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(&env->false_reg1);
 	reg_bounds_sync(&env->false_reg2);
 	/*
@@ -17529,7 +17527,7 @@ static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_s
 	return simulate_both_branches_taken(env, opcode, is_jmp32);
 }
 
-static int flip_opcode(u32 opcode)
+int bpf_flip_opcode(u32 opcode)
 {
 	/* How can we transform "a <op> b" into "b <op> a"? */
 	static const u8 opcode_flip[16] = {
@@ -17560,7 +17558,7 @@ static int is_pkt_ptr_branch_taken(struct bpf_reg_state *dst_reg,
 		pkt = dst_reg;
 	} else if (dst_reg->type == PTR_TO_PACKET_END) {
 		pkt = src_reg;
-		opcode = flip_opcode(opcode);
+		opcode = bpf_flip_opcode(opcode);
 	} else {
 		return -1;
 	}
@@ -17615,7 +17613,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 
 		/* arrange that reg2 is a scalar, and reg1 is a pointer */
 		if (!is_reg_const(reg2, is_jmp32)) {
-			opcode = flip_opcode(opcode);
+			opcode = bpf_flip_opcode(opcode);
 			swap(reg1, reg2);
 		}
 		/* and ensure that reg2 is a constant */
@@ -17649,7 +17647,7 @@ static int is_branch_taken(struct bpf_verifier_env *env, struct bpf_reg_state *r
 /* Opcode that corresponds to a *false* branch condition.
  * E.g., if r1 < r2, then reverse (false) condition is r1 >= r2
  */
-static u8 rev_opcode(u8 opcode)
+u8 bpf_rev_opcode(u8 opcode)
 {
 	switch (opcode) {
 	case BPF_JEQ:		return BPF_JNE;
@@ -17684,7 +17682,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	case BPF_JGT:
 	case BPF_JSGE:
 	case BPF_JSGT:
-		opcode = flip_opcode(opcode);
+		opcode = bpf_flip_opcode(opcode);
 		swap(reg1, reg2);
 		break;
 	default:
@@ -17751,7 +17749,7 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
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
