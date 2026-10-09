Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676A52AF1D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520713; cv=none; b=EsRj9TzxuiqD3Bmb82bn5niI9fzjWYEkboy4PFIk8ovm+bfVSXHkvmLrgZMHx4af9a2aBIsSRw1smHHxU9bl7jTApO7P9p1deRQIoqDbe+0YH/Av687c1ppHE0bQZNXdqtjZIkKIfl6PPKRdjKFbgwKBlRziMZ8P/Jp6VPl0hqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520713; c=relaxed/simple;
	bh=5g5gIl5u9YgNWiOW4TxkVFMOsCxtPVKXc80IMPXkLK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yy8zO7cOEqz0higxuQAnGmJXrQsxvY2YA88bu4CHpUXwvpTxXQ0wUILXWLHqtsUWQVE8j6fxBguqBiCyMeXOV/V7xXQGYAg6dwdC3cRcdGFci1mO21n7Mya1jG1UumruXxqONg5DTIwRcbk+n5D/YSj1Q1qjpEuBnNaiBX75s8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU9XhL3K; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU9XhL3K"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33c2520ad38so8928304eec.1
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 21:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791520711; x=1792125511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ydb+QtVshdEzpknIdrfZtZk2qWGqfs6bPIvT8GNtRA=;
        b=HU9XhL3KBARmO7CQHoBSPPsXufHEaPWDsGGqLDoeHHbUjyx2lsD/wWC/Rh1LNp6ngh
         f/qTxt5FBy+9duPsj648Vs6II2z215lUp0aKmGoUMN+QwJiaI+d1MzPWcf/SPluLKruj
         kgnJ9FgoNv19RTRzSMjBXPsjNl2zkKdau5QLmFhKYWj2tp9EJzVreWi8PgVqABv6GoCv
         WAp0dG/ViGyj8DEtukHT2BoDjrrcoOhuHVqf/3s5LtPkKJKplTzNH+Xb3zHl8b4JVuMZ
         pK6rBBlN2/3RSb/LLQJy40Lb/HME/GkIB+eIp06D2RnfXgUOfkfHIceTCy3aiUg1J3mT
         indA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791520711; x=1792125511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ydb+QtVshdEzpknIdrfZtZk2qWGqfs6bPIvT8GNtRA=;
        b=UW+H01eRVhN/9WcI+rdr3Av6nYjgsMcVOj/7Pp5SwW/EhYekTJveaobwSBHpt+eeXL
         mHzIbt74yPa4b0L9tWDTRaLzjUWTn9OyLX0ihI+Ry44QK9U46k1cJLB6K4urd4aNO2AX
         ATYMVG4kV9RYD7BDlVHQKTGpXjNnCDjQD48Zfdj1HDWkVvRCDr/O4aQQ3O29F1vSZQ5Y
         +z+QUSNV2XREQj3ULZ8w8KKTk5knUjALxKdOMQAUkSM/nvS5B35elSzrSsWGB2B/CdyC
         ASfFeaOjWJAbXBDy+xthyLAbOTOuNTe/rYh80/jfPXbeNgGovNBokIdOwQdXFwsZJhmK
         tPyw==
X-Gm-Message-State: AFq9FYL8oroE+uu2CeSnow+06zv5WV1Aagl/RdNSKIQKZ+SjnDSGObIh
	b1A/fl9TFxZSefm+HYQJfk7v4465FptVTanHxFXhIPqf9kdy1dfGg+jLcna1pDUIVoA=
X-Gm-Gg: AYBFou3yPtCvYrLWNGu9c25q+vwAj++L+Qy+0JKeIfJIGt1hHysQf72oUn1kPItxgvd
	LLtF1WjwnDX7v5EvVfzsAdnK3S0/vGBfOWWetQPHERh9f1eNV+qkpntE8azSztvpdvzgP6dMifu
	LNwRr3M/Trp5gwF43ei4XzoqZp4lKYmnfaO4kGucBTXOtULBC0oMzDJuRYjO0LoYiuPlXdmDw6Z
	i17+mGvtbv3WzOrhkLPaaM+ghc/9uA/vzZkyAeVDpESJ4GKBIX+3lvV0kjb3yk6hG/AN5C0VLHo
	ZgpkH50X3Y7tXyl4r0UNzSsf2mizeSiLn0Z0eLKHHhZCwJYvWz7Ib3hyWJb688dg2WyCk4TXh0m
	X1hN8kEpp3QTXA2zX3mnNs6OQlfKL12ZzhD0PJZBtosS83AQxFoaBtMHYXkEBXl4y1W+dUbR9nq
	+4uJes/K5P3FFOmHgzygiSztExE80/IvgKnnymvNP3wPwO6ERKeT+Q8SCsT0+PcBnnbTR0Bwmm5
	4Ui9E3uMLzDYA6mN6ZN3Q==
X-Received: by 2002:a05:7300:bc9a:b0:346:7c2c:1d25 with SMTP id 5a478bee46e88-3537e27b99dmr1903404eec.41.1791520710945;
        Thu, 08 Oct 2026 21:38:30 -0700 (PDT)
Received: from DESKTOP-31QBR7C ([103.120.166.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca7133asm3543809eec.14.2026.10.08.21.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:38:30 -0700 (PDT)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf-next v4] bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
Date: Fri,  9 Oct 2026 10:38:19 +0600
Message-ID: <20261009043819.1208-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261008185349.494-1-rahadbhuiya2021@gmail.com>
References: <20261008185349.494-1-rahadbhuiya2021@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_cond_jmp_op() propagates PTR_MAYBE_NULL nullness through
mark_ptr_or_null_regs() when it detects a BPF_JEQ / BPF_JNE
comparison against zero.  The existing code handles only the
'forward' operand order:

  dst_reg = nullable pointer,  src_reg = known-zero scalar
  (e.g. 'if r0 == 0')

The symmetric case is left unhandled:

  dst_reg = known-zero scalar,  src_reg = nullable pointer
  (e.g. 'if r6 == r0' where r6 has been proven zero)

When the symmetric case occurs:
 - type_may_be_null(dst_reg->type) is false (dst is scalar zero)
 - The null-check block is skipped entirely
 - mark_ptr_or_null_regs() is never called for src_reg
 - src_reg retains PTR_MAYBE_NULL in both branches

Additionally, the early unprivileged-mode pointer-comparison guard
(line 18058) rejected any conditional jump where src_reg is a pointer
type, which would have made the new block unreachable for unprivileged
programs.  Comparing a nullable pointer against a register proven to
be zero is not a pointer leak -- it is semantically identical to the
already-permitted forward form 'if (r_nullable == 0)'.  Exempt the
symmetric null check from that guard.

Fix: add an 'else if' branch that mirrors the forward logic for the
symmetric operand order and extend the early guard to permit it.
Add corresponding symmetric JEQ, JNE, and negative non-zero dst test
cases into verifier_jeq_infer_not_null.c with __success_unpriv to
exercise both privileged and unprivileged paths.

Commit 6aed0134d3cd ('bpf: Mark the zero register precise for a
register-form NULL check') introduced the precision marking for the
forward case; the symmetric case was overlooked there.

Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 kernel/bpf/verifier.c                         | 40 ++++++++-
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 82 +++++++++++++++++++
 2 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 353bde9ae227..68b23d11766d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18057,9 +18057,22 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 		src_reg = &regs[insn->src_reg];
 		if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_reg)) &&
 		    is_pointer_value(env, insn->src_reg)) {
-			verbose(env, "R%d pointer comparison prohibited\n",
-				insn->src_reg);
-			return -EACCES;
+			/*
+			 * Symmetric NULL check: "if (r_zero == r_nullable)".
+			 * Comparing a nullable pointer against a register proven
+			 * to be zero is not a pointer leak -- it is the reversed
+			 * form of the already-permitted "if (r_nullable == 0)".
+			 * Permit it; reject every other src_reg pointer comparison.
+			 */
+			if (BPF_CLASS(insn->code) == BPF_JMP32 ||
+			    (BPF_OP(insn->code) != BPF_JEQ &&
+			     BPF_OP(insn->code) != BPF_JNE) ||
+			    !type_may_be_null(src_reg->type) ||
+			    !bpf_register_is_null(dst_reg)) {
+				verbose(env, "R%d pointer comparison prohibited\n",
+					insn->src_reg);
+				return -EACCES;
+			}
 		}
 
 		if (src_reg->type == PTR_TO_STACK)
@@ -18248,6 +18261,27 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				      opcode == BPF_JNE);
 		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
 				      opcode == BPF_JEQ);
+	} else if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
+		   (opcode == BPF_JEQ || opcode == BPF_JNE) &&
+		   type_may_be_null(src_reg->type) &&
+		   bpf_register_is_null(dst_reg)) {
+		/*
+		 * Symmetric case: src_reg is the nullable pointer, dst_reg is
+		 * a register whose value is known to be zero.  This arises when
+		 * the programmer writes the comparison in reversed operand order,
+		 * e.g. "if (0 == map_val)" or "if (r0 == map_val)" where r0 has
+		 * been proven zero by the verifier.
+		 *
+		 * The zero is a property of this execution path, so dst_reg
+		 * must be marked precise before we propagate nullness.
+		 */
+		err = mark_chain_precision(env, insn->dst_reg);
+		if (err)
+			return err;
+		mark_ptr_or_null_regs(this_branch, insn->src_reg,
+				      opcode == BPF_JNE);
+		mark_ptr_or_null_regs(other_branch, insn->src_reg,
+				      opcode == BPF_JEQ);
 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg],
 					   this_branch, other_branch) &&
 		   is_pointer_value(env, insn->dst_reg)) {
diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index 3c789c565b18..ee2e9374969d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -273,6 +273,88 @@ __naked void jne_reg_reg_null_check(void)
         : __clobber_all);
 }
 
+/* Symmetric case: dst_reg is known 0, src_reg is nullable pointer.
+ * "if (r1 == r0) goto 1f;" (reversed operand order).
+ * Verify that non-nullness is propagated to src_reg in the non-null branch.
+ */
+SEC("socket")
+__description("null check: symmetric form (dst 0 reg, src nullable) JEQ")
+__success __success_unpriv
+__retval(0)
+__naked void jeq_reg_reg_null_check_symmetric(void)
+{
+	asm volatile ("					\
+	*(u32*)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	r1 = 0;						\
+	/* r1 is known 0, r0 is nullable ptr */		\
+	if r1 == r0 goto 1f;				\
+	r0 = *(u32*)(r0 + 0);				\
+1:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
+/* Symmetric case with JNE: "if (r1 != r0) goto 1f;"
+ * Taken branch: r0 is non-null. Fall-through: r0 is null.
+ */
+SEC("socket")
+__description("null check: symmetric form (dst 0 reg, src nullable) JNE")
+__success __success_unpriv
+__retval(0)
+__naked void jne_reg_reg_null_check_symmetric(void)
+{
+	asm volatile ("					\
+	*(u32*)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	r1 = 0;						\
+	if r1 != r0 goto 1f;				\
+	goto 2f;					\
+1:	r0 = *(u32*)(r0 + 0);				\
+2:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
+/* Negative test: dst_reg is a non-zero scalar (r1 = 1).
+ * "if (r1 == r0)" must NOT be treated as a null check.
+ * Dereference must fail because r0 remains nullable.
+ */
+SEC("socket")
+__description("null check: symmetric form with non-zero dst must not elide null check")
+__failure
+__msg("R0 invalid mem access 'map_value_or_null'")
+__naked void null_check_symmetric_nonzero_dst_rejected(void)
+{
+	asm volatile ("					\
+	*(u32*)(r10 - 8) = 0;				\
+	r1 = %[map_hash] ll;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	call %[bpf_map_lookup_elem];			\
+	r1 = 1;						\
+	if r1 == r0 goto 1f;				\
+	r0 = *(u32*)(r0 + 0);				\
+1:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
 /*
  * A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
  * PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
-- 
2.55.0.windows.3

