Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5445372EF3
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791441215; cv=none; b=NqjPIjeCnS5VkDFND5GoXist1QhJk6yezP9kdcZUdsfVrB3NFfQwKWGJURStCrDBy0zPMdCC8PVlI1oLjnbpYjdX0u554NeGIVKE4ZITBWCRPn4wPecialNIjAiW71dUJ1W3N87FCXdkZrlCfJMsuEfb6vEFsOjNsfmO0cRPPCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791441215; c=relaxed/simple;
	bh=SmxwfKuSkXwbHAuEQg85wnMowGxQfoWoMM++hqt16LE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/tYPTJJW/dI+6tFCE2xYsf+fGjEJkqzcSMFijFapPsLbxN7CfxmfVhRzLC/fXby5t8oWQvJfIicVPyc0e0+8XYJvUmCsYbIOw/rfA5mdKkAiLu7GlhdFkWNW+DnWvTA2Hzw9RmBs92Yj5iNrkUH5R+HKjzHCydFpk1oImFdRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmgmCsvw; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmgmCsvw"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1467468eec.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 23:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791441213; x=1792046013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KnfktEVEVCx5++2AKvTOvY2xsIkoVgivGRXevXPcE2c=;
        b=VmgmCsvwTodqZfxaTq4qimL7b0cNmquMIS7+92eEsDnxIcko4AdM5eu54mL3uDxYjV
         yPtkySmJKo6KxdnXj04UpANBYihK6UicQSVr16vguy9fEtiMd0b2lVFb/PquLre5obOn
         HIdQE9KjHMa3iajfMj6SwreiPhA/taS4i51NEecRjfb10kPrpUCPRgJFVFSd9o7wjwee
         VJaCXMs6gcRYyQ9u/0xZ4l0eb5kvEs8MT0AOrKKBbT+nfjI49+j92lC8LAxDTDYtX7jP
         2mPzZoIPWsr+ZwtwCtLHKk21gjRgbfdwftBbqBKqORPw9MdVyhixX5r1m81xusCwS0Y6
         mz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791441213; x=1792046013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KnfktEVEVCx5++2AKvTOvY2xsIkoVgivGRXevXPcE2c=;
        b=AxIlADZRUN8RHpNUoYedwVQI+RaANZmLKt4jhBftlqn/z665vU/AsF91S285yYtywC
         tlh9ag4ibYwEbpOTvizSHdaqJl6yxzpuEISaZUYActDiduujP8jQQf3ZdvGktB36Xu1G
         GN6KH7Dx+h/IKNSvjHurlZrchMsb2bRWq1HKmYJsUj/hKgp9DrDHjs3lBUHNrE+pJRfN
         jZDAkTs3x5uIKCyqh1DtOKxE2wMWlnqoHMroYSQDqeNoV77+qGK16Ijv/mPEmCo+pNU2
         5HY8gHklDEwMBaYUcb19JfN8tIl8yqAmyCWrk/arvXnAkCr9H/jPzRW7lLBotq4SagDr
         VFig==
X-Gm-Message-State: AFq9FYJSY4KAVOpe9Zl4hP0k7Uf5sbNWJ5N+tODr8L2cXvW4IIUtNHJH
	TkWWGB7FA+ONaAbQsRiPIbOW1tMFzOw6WqMBaojnI9viDcR6dEK7DfkxUC7/pg3dIBA=
X-Gm-Gg: AYBFou2jWDdsq5qMe741lHqTB98OhcrbPssne+tKLvD6QOX1G5VaBhfngIMlbA+czMN
	4rL7VFoJpsM2JLiA6+Ijc0v+tiReLx0GkvNBSEOKx7vVItuRNA9ll2i0kxt1naN+bh1ZPoctjFG
	ki1y55GVDG/c3QtmnUuIOTqPBjnbqP7sEqUmAZIfNPbknCsfsgJOxKx6E9xrK3AXN0/8rV0u8XU
	nH2f0mzGCc2veaxhGQgYL4t+NaeuXYjk1gKvP/HrvMn1Guoy87CI9LE2apSd9ul74zMO44JvoY/
	7GPi0xhBHgnA5Z/d9pVFVZcO7p1sGGRtPJGq9C2UFWLujrtUYwSS/6fsx8lpsq94xwEi5VJqpkb
	kBO7uZ9epfBZJtL2rwvqsYsfBe/2fnVJCg+G4TPOeG2q/l8fKApgBAY/+4Ia+r8tDioOWgfjUZs
	6kTM2pBBbOgKcKbNIPLMQwEl8ngehYDQKp8xagXM2ydqtmlGIfm+nkhMKaLzsq8DhX+/Pq7gmV7
	qSfCmnrfzJagTkPeN0gig==
X-Received: by 2002:a05:693c:8115:b0:351:516f:7576 with SMTP id 5a478bee46e88-3515de8101bmr6128034eec.10.1791441212262;
        Wed, 07 Oct 2026 23:33:32 -0700 (PDT)
Received: from DESKTOP-31QBR7C ([103.120.166.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517853f29esm4230249eec.15.2026.10.07.23.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 23:33:31 -0700 (PDT)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH bpf-next] bpf: fix symmetric register-form NULL-pointer check in check_cond_jmp_op()
Date: Thu,  8 Oct 2026 12:33:22 +0600
Message-ID: <20261008063322.530-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
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

This causes the verifier to either reject a valid program that guards
via the reversed form, or -- if the check is a control dependency that
the verifier is expected to honour -- to silently miss enforcing the
null guard requirement.

Fix: add an 'else if' branch that mirrors the forward logic for the
symmetric operand order.  Like the forward BPF_X case, dst_reg (the
zero scalar) must be marked precise before nullness propagation since
the zero is a property of this execution path.

Commit 6aed0134d3cd ('bpf: Mark the zero register precise for a
register-form NULL check') introduced the precision marking for the
forward case and mentioned it also applies to BPF_X zero-register
comparisons; the symmetric case was overlooked there.

Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
 kernel/bpf/verifier.c                         |  20 +++
 .../selftests/bpf/prog_tests/verifier.c       |   3 +
 .../bpf/progs/verifier_null_ptr_symmetric.c   | 162 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 353bde9ae227..e4ae8f648162 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18248,6 +18248,26 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 				      opcode == BPF_JNE);
 		mark_ptr_or_null_regs(other_branch, insn->dst_reg,
 				      opcode == BPF_JEQ);
+	} else if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
+		   (opcode == BPF_JEQ || opcode == BPF_JNE) &&
+		   type_may_be_null(src_reg->type) &&
+		   bpf_register_is_null(dst_reg)) {
+		/* Symmetric case: src_reg is the nullable pointer, dst_reg is
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
index 000000000000..475aa3dc3bd2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_null_ptr_symmetric.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Verifier selftests for symmetric register-form NULL-pointer checks.
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

