Received: from mta0.migadu.com (out-28.mta0.migadu.com [91.218.175.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E9C403AF8
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058860; cv=none; b=TZpyFgpP3uf/grKxx9NzRKnkOea7N1wW5qvdYhI8OvdnN+sl+Xytwme7XMFd5ob+HWNu/NlEasIsiSocowiO4+ZNsBcxWODkmqP7UobAvmialw3gbLtIUDUjrTHpNRBaYnYJA4/R5Gz1lW+ujQe0WXBGWrbnMWw//k/vl5edyYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058860; c=relaxed/simple;
	bh=F+pd4LFVDzl9LIzWsn7DcNffB+umM8Xu2NR168bApxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHku/mqMRtv5t40ihKpspxZXuUqL0OQLkxklK66SmE8TJDA9u5ipHpJsW+quFmtyIl/JVcIBSQkJ3NXOEcJbDRkFJjOW5U4PJU1uIAG/oY+IWM6Ey8X4m5kxPM2gWKXqMK5DfCklDKM7RjNkA680uSBjCkGWnWje7LDmVgtXM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qsP9+lrY; arc=none smtp.client-ip=91.218.175.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qsP9+lrY"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F+pd4LFVDzl9LIzWsn7DcNffB+umM8Xu2NR168bApxE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058852; v=1; x=1789663652;
 b=qsP9+lrYLQ3Iw9JcCPKy6Gz6UnUcmJ8gwhuojqJnyGAdMKJ4H2qNM2Ka5CEos0k22ugMCznR
 HduiUMM0yk+Kt8NiqHS5tSf8pFjcqb2Q/bUGBjnI6R/MnuZ4b9so8hac+29GIXU3UWR3OUCYLpZ
 jBSVgbs9jueIotagJIo9pYt0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 29e31eec917ca39b;
	Thu, 10 Sep 2026 16:47:31 +0000
X-Mizu-Trace-ID: 29e31eec917ca39b
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
Subject: [PATCH bpf-next v2 08/13] selftests/bpf: cover the low-32 link for sign-extending movs
Date: Thu, 10 Sep 2026 22:16:30 +0530
Message-ID: <20260910164635.459558-9-vineet.gupta@linux.dev>
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

Five programs, mirroring the zero-extending set:

 - sext_mov_wide_src: narrowing the source reaches the destination, and
   the value that arrives is sign-extended rather than zero-extended
 - sext_self_mov_keeps_link: r0 = (s32)r0 on an already-linked register
   stays in its set, the shape a sign-extended int return takes
 - sext_self_mov_no_link: the same mov on an unlinked register mints no id
 - sext_no_sync_when_base_has_delta: a delta on the base stops propagation
 - sext_no_sync_from_subreg_base: narrowing the link does not run
   backwards into the rest of the set
 - sext_kinds_reach_different_values: the same low half reaches -1 through
   a sign extension and 0xffffffff through a zero extension

Each guards a div by zero that is only unreachable if the propagation
happened, so losing the link is a verification failure rather than a test
that quietly stops checking anything.

The sign-extending mov is cpuv4, so the block needs a feature gate.
CAN_USE_MOVSX follows CAN_USE_GOTOL: the arch list, then clang 18 or
__BPF_FEATURE_MOVSX, so bpf-gcc gets the coverage too.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: was RFC 6/6.
 - fixed the backwards guard sashiko reported
 - CAN_USE_MOVSX so bpf-gcc builds these too
 - renamed as in 4/13

 tools/testing/selftests/bpf/progs/bpf_misc.h  |   8 +
 .../bpf/progs/verifier_linked_scalars.c       | 165 ++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index eb88d9ce6c34..45bfa02a5338 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -269,6 +269,14 @@
 #define CAN_USE_BPF_ST
 #endif
 
+#if (defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+     (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64) ||		\
+     defined(__TARGET_ARCH_arm) || defined(__TARGET_ARCH_s390) ||	\
+     defined(__TARGET_ARCH_loongarch)) &&				\
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX))
+#define CAN_USE_MOVSX
+#endif
+
 #if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
 	(defined(__TARGET_ARCH_arm64) ||				\
 	 defined(__TARGET_ARCH_x86) ||					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
index 65cb0efd268f..9d060d8b0c1f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
+++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
@@ -966,4 +966,169 @@ __naked void zext_mov_breaks_add_const_src(void)
 	: __clobber_all);
 }
 
+#ifdef CAN_USE_MOVSX
+
+/*
+ * A 32-bit sign extension keeps the low 32 bits, so narrowing the source
+ * reaches the destination the same way it does for a zero extension. The high
+ * half follows the sign, so the value seen here is negative.
+ */
+SEC("socket")
+__success
+__naked void sext_mov_wide_src(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* forms the link */		\
+	if w6 != -1 goto 1f;	/* narrows r6, propagates to r7 */ \
+	if r7 == -1 goto 1f;	/* sign-extended, not 0xffffffff */ \
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
+ * r0 = (s32)r0 is how a sign-extended int return lands. src and dst are the
+ * same register, but r0 is already linked, so there is a set for it to stay
+ * in and the narrowing still propagates.
+ */
+SEC("socket")
+__success
+__naked void sext_self_mov_keeps_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = r6;		/* r6, r7 linked */		\
+	r7 = (s32)r7;		/* self-mov, keeps the id */	\
+	if w6 != -1 goto 1f;	/* narrows r6, propagates to r7 */ \
+	if r7 == -1 goto 1f;					\
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
+ * The same self-mov on an unlinked register has nothing to link to, so it
+ * must not mint an id that would leave r6 describing itself.
+ */
+SEC("socket")
+__success __log_level(2)
+/* an id would print as R6=scalar(id=N.lo32sx,smin=... */
+__msg("(bf) r6 = (s32)r6 {{.*}} R6=scalar(smin=")
+__naked void sext_self_mov_no_link(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 ^= 0;		/* drop the id */		\
+	r6 = (s32)r6;		/* forms no link */		\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A delta on the branch register is not modelled together with a low-32
+ * link, so the propagation is skipped rather than guessed at.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_no_sync_when_base_has_delta(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* forms the link */		\
+	r8 = r6;						\
+	r8 += 3;		/* delta on the branch reg */	\
+	if r8 != 3 goto 1f;	/* must not propagate to r7 */	\
+	if r7 == 0 goto 1f;					\
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
+ * ... and with the link as the branch register the propagation must not run
+ * backwards: a ->subreg register knows nothing about the base's high half, so
+ * narrowing it must leave the rest of the set alone. Were the guard missing,
+ * r8 would be rebuilt as r7 + 3 == 2, treating r7 as if it were the base.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__naked void sext_no_sync_from_subreg_base(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r7 = (s32)r6;		/* forms the link */		\
+	r8 = r6;						\
+	r8 += 3;		/* delta on r8 */		\
+	if r7 != -1 goto 1f;	/* must not propagate to r8 */	\
+	if r8 == 2 goto 1f;	/* taken only if r8 wrongly narrowed */	\
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
+ * The two kinds rebuild the high half differently: the same low half reaches
+ * -1 through a sign extension and 0xffffffff through a zero extension, so only
+ * one path clears the guard. As above this checks the outcome -- the differing
+ * ranges keep the states apart on their own.
+ */
+SEC("socket")
+__failure __msg("div by zero")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void sext_kinds_reach_different_values(void)
+{
+	asm volatile ("						\
+	call %[bpf_get_prandom_u32];				\
+	r6 = r0;						\
+	r6 &= 1;						\
+	if r6 >= 1 goto 2f;					\
+	/* explored first: r7 is a sign-extended link of r8 */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	r7 = (s32)r8;						\
+	goto 1f;						\
+2:								\
+	/* runtime path: r7 is a zero-extended link of r8 */	\
+	call %[bpf_get_prandom_u32];				\
+	r8 = r0;						\
+	w7 = w8;						\
+1:								\
+	if w8 != -1 goto 3f;					\
+	if r7 == -1 goto 3f;	/* only the sign-extended path */ \
+	r0 /= 0;						\
+3:								\
+	r0 = 0;							\
+	exit;							\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#endif /* CAN_USE_MOVSX */
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0-Meta

