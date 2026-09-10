Received: from mta0.migadu.com (out-45.mta0.migadu.com [91.218.175.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B603E377AB4
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058872; cv=none; b=kN2U7gU5Tlaw0QxCxn34rQy0UTqFyTPQ5zgc7n9OFPRNwh6Dtx7n1iSJnylMuALuZi/DGAwXvfFyTbeeKSJOnD+gQFSOtROvfEbXWqQ0LNb0tLDBc6m8UEMDTI4imW6r1CcJe6rrmzolpp0dUA1FTi18zaVG/oRZnT4+90WAx8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058872; c=relaxed/simple;
	bh=GS8eAaa+t8Q/6CXhV0Ju/1mP6N+mvNFoKi/CMt2gzac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J4Y9fS1zwRHmxWGwm184gD6xfASEZ0D4Rvq8wqx0PjLNQDtU2RgH4M74B8lo6aVI4evzxIeXj0qMhxSViOlCy0nPaLHUNwjI5gY2yhJBJ8YSknmTrfjxzWLtABPslFHF0It+Oh8ngAAVXjicft21dyZo1zRlMWcuCd8YgBYPdNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aCUpaTLn; arc=none smtp.client-ip=91.218.175.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aCUpaTLn"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GS8eAaa+t8Q/6CXhV0Ju/1mP6N+mvNFoKi/CMt2gzac=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058860; v=1; x=1789663660;
 b=aCUpaTLnGFz4QHt+ns2P+KfYizkLSf+VQfuOpkMHPU+09Jw5FxLOkyrnx3GxCyV+rdpPUeBZ
 4q8iqTui5uovUzSpWfDJ16o6rHNo4oyccM8BhyFhYRqFSsC+tFjXXVMlTGO/ObnxdFqj0Uk8RU/
 jaonoalb6SLuEk27oT5Trzog=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c6509f25ec2fa41e;
	Thu, 10 Sep 2026 16:47:40 +0000
X-Mizu-Trace-ID: c6509f25ec2fa41e
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 10/13] selftests/bpf: cover the low-32 link for narrowing stack fills
Date: Thu, 10 Sep 2026 22:16:32 +0530
Message-ID: <20260910164635.459558-11-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five programs, following the mov set:

 - zext_fill_narrow_from_wide_spill: narrowing the spilled value reaches
   the filled register
 - sext_fill_narrow_from_wide_spill: the same for a sign-extending fill,
   and the value that arrives is sign-extended
 - zext_fill_full_width_keeps_full_link: a full-width fill is a plain
   64-bit equality and must keep propagating as before
 - zext_fill_byte_forms_no_link: a sub-word fill is below the low-32
   model, so no link is formed
 - fill_kinds_reach_different_values: the same, for the two fill kinds off
   one slot

The first two are the ones that pin the new behaviour: disabling link
formation in the fill arm makes both fail. The other three are guards
against the feature applying where it should not, and hold either way.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new, with 9/13.
 .../bpf/progs/verifier_linked_scalars.c       | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 9d060d8b0c1f..e8a44e7579c8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -966,6 +966,88 @@ __naked void zext_mov_breaks_add_const_src(void)
 	: __clobber_all);
 }
 
+/*
+ * A narrowing fill keeps only the slot's low 32 bits, so a later narrowing of
+ * the spilled value must still reach the filled register. Same relation as a
+ * 32-bit mov from a wide source, with the stack slot as the base.
+ */
+SEC("socket")
+__success
+__naked void zext_fill_narrow_from_wide_spill(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
+	r2 = *(u32 *)(r10 - 8);	/* narrowing fill, forms the link */ \
+	if w6 != 0 goto 1f;	/* narrows r6, propagates to r2 */ \
+	if r2 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A full-width fill of a wide slot is a plain 64-bit equality, not a low-32
+ * link, so it must keep propagating exactly as before.
+ */
+SEC("socket")
+__success
+__naked void zext_fill_full_width_keeps_full_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;						\
+	*(u64 *)(r10 - 8) = r6;					\
+	r2 = *(u64 *)(r10 - 8);	/* no narrowing */		\
+	if r6 != 0 goto 1f;					\
+	if r2 == 0 goto 1f;					\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A sub-word fill is below the low-32 model, so no link is formed and the
+ * relation is dropped as before.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void zext_fill_byte_forms_no_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;						\
+	*(u64 *)(r10 - 8) = r6;					\
+	r2 = *(u8 *)(r10 - 8);	/* 1-byte fill: no link */	\
+	if w6 != 0 goto 1f;					\
+	if r2 == 0 goto 1f;	/* not deduced */		\
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #ifdef CAN_USE_MOVSX
 
 /*
@@ -1129,6 +1211,68 @@ __naked void sext_kinds_reach_different_values(void)
 	: __clobber_all);
 }
 
+/*
+ * The sign-extending counterpart: the filled register is the sign extension of
+ * the slot's low 32 bits, so a narrowing of those bits arrives sign-extended.
+ */
+SEC("socket")
+__success
+__naked void sext_fill_narrow_from_wide_spill(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r6 |= r0;		/* r6 = full 64-bit unknown */	\
+	*(u64 *)(r10 - 8) = r6;	/* slot linked to r6 */		\
+	r2 = *(s32 *)(r10 - 8);	/* narrowing sx fill */		\
+	if w6 != -1 goto 1f;	/* narrows r6, propagates to r2 */ \
+	if r2 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
+	r0 /= 0;						\
+1:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * The same, for the two fill kinds off one slot.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void fill_kinds_reach_different_values(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 &= 1;						\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	call %[bpf_get_prandom_u32];				\
+	r0 <<= 32;						\
+	r8 |= r0;						\
+	*(u64 *)(r10 - 8) = r8;					\
+	if r6 >= 1 goto 2f;					\
+	r2 = *(s32 *)(r10 - 8);	/* sign-extending fill */	\
+	goto 1f;						\
+2:								\
+	r2 = *(u32 *)(r10 - 8);	/* zero-extending fill */	\
+1:								\
+	if w8 != -1 goto 3f;					\
+	if r2 == -1 goto 3f;	/* only the sign-extending path */ \
+	r0 /= 0;						\
+3:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 #endif /* CAN_USE_MOVSX */
 
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

