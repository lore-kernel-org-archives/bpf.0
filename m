Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE26A34CCE
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442671; cv=none; b=tgTG9WD6W5NmnD2WI7OCN86tEqHpfrknkR3FEcnKHTVCbuYEwp/5faK2Cla+IJbtUHKI85f07FLjZj0ZNMjVJfLXCHVwRQmeRtYhjDsAzgSZcirD81WFWKUGrgI0cz/t1FFAzkfZcuA9ySqKp9x7cqOH2Yo9WkDkCIwdBc8KMec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442671; c=relaxed/simple;
	bh=pWKokQveCiZbUe2sMg1Olkwm+yJszlcQb3hA5hJfLbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g44GOxDH2B0MceG5haDJSIcFpa4xCuD9Q1RweeO619WleIKFsdic2JZCzUQAlD8UqkJcVxZO9Vpo8YaFsOUzuwhqsFFssjwG3RH4I9vX1aFT/CSfPnVeaJvJSelDmvytEL+L+sE56v5C+cxCaQQXU/Bbk2yWOP5T1szyaN+3Hzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsWQtZMM; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsWQtZMM"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-351775aa1c0so785284eec.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 23:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791442669; x=1792047469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHxj18iBrbJZyyhcrQCRwEUvWf0wl6fSDmLmfCTWWJE=;
        b=RsWQtZMM0RSZZNqDCfAY8Ugvh9IBOad0kKaHQAYMIPyM4wHlRcklietmzSYVJe9IJX
         uHdNS2NRgWCh70NiVIpuma0skjKgcHRuGNsU7uTf0xHibsSMWY1Xx08Z6RqDKE8Uq4ca
         JsnQoFrpgUE5glRrIb2QQgSh7WF5i1aPxoG8cmp0cekNvcqf7Yice9lfsvdqxvGjuwU1
         0IPJhaaYbxH+255KO4SGOgsAZCbpr3oPOkoIjBSxOldxGS4SToHvnL8HRamw/d7D+4pT
         5FpZt4Jc/krk5MmjjWiOfzlLU0a0ctdeRI2ErEUImiZvgiMAA+4fWLmnRYHVm9NyYQHX
         6SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442669; x=1792047469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHxj18iBrbJZyyhcrQCRwEUvWf0wl6fSDmLmfCTWWJE=;
        b=XYB5Z5acYUr23XVFnqhX7IBTHUVV4rFCd9oUa16tIJckzPuW6wtgVaBza+wjsZdn+I
         pizXoGXKRLkqoJcO6Z2Brx6dxk004SaoZ5qnbLOf2n4rX9KXBul4RxsLzmL1Re+GDepj
         0rhxNlL3hBzPFkn48SDk4yd7YufJMrDXFMQ0RQ5dr/9i1jOgYgXlUI7pCeKyzErUNzeM
         H13TTAl0+Rl+rgslp1YJlFfaKoteU3979GbySLPqLJQL5qaNjGcxUpfh33AXkj6jY5Vg
         G7j1PPoI9uB36Yzocifiw6c/OkuOOsgi0hBkCK+8Dbf6mASJ/pRcXutYdQiDFkcgeFAO
         9Pig==
X-Gm-Message-State: AFuF++nK6dJMxPt3LYDunxcMJ+IfxMdGJdxrXGfZNnVGGUOVMaZPkByr
	14sRmYw1NMN+GDOk1SQntnZwoEWC/Akm55o96XlAHOnYmGJnZPSjhP0UcjOCDa6nYVM=
X-Gm-Gg: AYBFou3PntB5F9szj1hITR8qmsFdqYeZvYY5OZzqrPqUKviYZV1U+9DYRX92X71aXCJ
	ebuooOku9megPZ5jAXKul36HCUdQ6NoU3upz5TvVJhdNs7H7nZYS8u1ovv7tKpQxjApaggIQy79
	C8ymJUSuLhQtZVLrntMqXcb5ASoPfhsmrFSqqrHm3Tw82M/Kdc3bJlDaLO6aQWq+BG5iANJPe6b
	cNRRQ5H1zg41ZI55gWdFHakhrq9P/S9wt9Yucm5O+uFvhn2JtQnSaWY6TZWyvTGguK3IzLlj6rb
	G3v0G6Cg4XGa1Tg30+VUjGQ2MyR1+YYCCLQNHZpQ3CR3c1SsaQKt+7v1admLYBsuhEOAPhS7orG
	nJ4dAY7P1oukC46lcixElQEgqYgMn1sy7Q1Tf1HzECXZzy7j0UeyfYaX167rrv6ZPhsF2VGXTz+
	aAIcLkQuT2lMnGMk4DwN52tGppI6X0knFnMW6EU0g4w3YygcHPRMLmNwGjrKh9GpeOnuzrQHTIm
	7eW0Irw2crY92fO6xTbhw==
X-Received: by 2002:a05:701b:21c7:b0:148:722b:7cbc with SMTP id a92af1059eb24-162044bfe56mr4976301c88.14.1791442668490;
        Wed, 07 Oct 2026 23:57:48 -0700 (PDT)
Received: from DESKTOP-31QBR7C ([103.120.166.82])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1636849ce68sm8102857c88.21.2026.10.07.23.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:57:47 -0700 (PDT)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf-next v2] bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
Date: Thu,  8 Oct 2026 12:57:38 +0600
Message-ID: <20261008065738.1093-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261008063322.530-1-rahadbhuiya2021@gmail.com>
References: <20261008063322.530-1-rahadbhuiya2021@gmail.com>
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

Commit 6aed0134d3cd ('bpf: Mark the zero register precise for a
register-form NULL check') introduced the precision marking for the
forward case; the symmetric case was overlooked there.

Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 kernel/bpf/verifier.c                         |  40 ++++-
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../bpf/progs/verifier_null_ptr_symmetric.c   | 163 ++++++++++++++++++
 3 files changed, 203 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c

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
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 460ad10ddc02..834ee5da9845 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -144,6 +144,7 @@
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
 #include "verifier_zext.skel.h"
+#include "verifier_null_ptr_symmetric.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -377,3 +378,5 @@ void test_verifier_value_ptr_arith(void)
 		      verifier_value_ptr_arith__elf_bytes,
 		      init_value_ptr_arith_maps);
 }
+
+void test_verifier_null_ptr_symmetric(void) { RUN(verifier_null_ptr_symmetric); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
new file mode 100644
index 000000000000..3adf28402d73
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verifier selftests for symmetric register-form NULL-pointer checks.
+ *
+ * The BPF verifier's check_cond_jmp_op() handles "if R == 0" NULL checks by
+ * calling mark_ptr_or_null_regs() to mark the nullable pointer as either safe
+ * or unknown in each branch.  Historically only the forward case was covered:
+ *   dst_reg = nullable pointer,  src_reg = known-zero scalar
+ * i.e. "if (map_val == 0)".
+ *
+ * The symmetric case was missing:
+ *   dst_reg = known-zero scalar, src_reg = nullable pointer
+ * i.e. "if (0 == map_val)" or "if (r0 == map_val)" where r0 is proven zero.
+ *
+ * Without the fix the verifier leaves src_reg as PTR_MAYBE_NULL in both
+ * branches, either rejecting a valid program or silently missing a required
+ * null check.  With the fix, nullness is propagated correctly in both
+ * directions.
+ */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sym_null_map SEC(".maps");
+
+/* ---- Forward case (already worked before the fix) ---- */
+
+/*
+ * "if (map_val == 0)" -- dst_reg holds the nullable pointer,
+ * src_reg is the literal-zero immediate (BPF_K).  Should be accepted.
+ */
+SEC("socket")
+__description("null check: forward form (dst nullable, imm 0) accepted")
+__success __retval(0)
+__naked void null_check_forward_imm(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[sym_null_map] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	/* r0 = nullable ptr; forward case: if (r0 == 0) */	\
+	if r0 == 0 goto exit;				\
+	/* r0 is non-null here -- safe to dereference */\
+	r1 = *(u32 *)(r0 + 0);				\
+exit:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(sym_null_map)
+	: __clobber_all);
+}
+
+/* ---- Symmetric case (required the new fix) ---- */
+
+/*
+ * "if (0 == map_val)" -- src_reg holds the nullable pointer,
+ * dst_reg is a register that the verifier has proven equals zero.
+ * Should be accepted; before the fix it was rejected because nullness
+ * was never propagated for src_reg.
+ */
+SEC("socket")
+__description("null check: symmetric form (src nullable, dst zero reg) accepted")
+__success __retval(0)
+__naked void null_check_symmetric_reg(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[sym_null_map] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	/* r0 = nullable ptr, r6 = known 0 */		\
+	r6 = 0;						\
+	/* Symmetric check: if (r6 == r0), i.e. dst=r6 (zero), src=r0 (nullable) */\
+	if r6 == r0 goto exit;				\
+	/* r0 is non-null here -- safe to dereference */\
+	r1 = *(u32 *)(r0 + 0);				\
+exit:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(sym_null_map)
+	: __clobber_all);
+}
+
+/*
+ * BPF_JNE symmetric form: "if (r6 != r0) goto use_r0;"
+ * In the fall-through branch r0 == r6 == 0, so it is null.
+ * In the taken branch r0 is non-null and safe to dereference.
+ */
+SEC("socket")
+__description("null check: symmetric JNE form (src nullable, dst zero reg) accepted")
+__success __retval(0)
+__naked void null_check_symmetric_jne(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[sym_null_map] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	r6 = 0;						\
+	/* if (r6 != r0) goto use_r0 */			\
+	if r6 != r0 goto use_r0;			\
+	/* fall-through: r0 is null here, just exit */	\
+	r0 = 0;						\
+	exit;						\
+use_r0:							\
+	/* r0 is non-null here -- safe to dereference */\
+	r1 = *(u32 *)(r0 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(sym_null_map)
+	: __clobber_all);
+}
+
+/*
+ * Negative test: src_reg is nullable, dst_reg is non-zero scalar.
+ * This must NOT be treated as a null check -- the verifier should
+ * still reject a dereference of r0 without a proper null guard.
+ */
+SEC("socket")
+__description("null check: symmetric form with non-zero dst must not elide null check")
+__failure __msg("R0 invalid mem access 'map_value_or_null'")
+__naked void null_check_symmetric_nonzero_dst_rejected(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r2 = r10;					\
+	r2 += -8;					\
+	r1 = %[sym_null_map] ll;			\
+	call %[bpf_map_lookup_elem];			\
+	/* r6 = 1 (non-zero) -- this is NOT a null check */\
+	r6 = 1;						\
+	if r6 == r0 goto skip;				\
+	/* r0 still PTR_MAYBE_NULL here, dereference must fail */\
+	r1 = *(u32 *)(r0 + 0);				\
+skip:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(sym_null_map)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0.windows.3

