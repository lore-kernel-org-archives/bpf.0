Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F641A57C
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355330; cv=none; b=u2orca8RQOqIEKfPtfG88fu3YEjs33By1P1JF/cuuFCaP103ggONy3IKVg2sna26VYfzmMkLXyz2ssQ8GhtG1ImGOEjRXI1SPRwnWcvJ9+GLp3meFFyQOUmq2OGp1N+wyS6njHcHl7Sa7PhK/Sj/0CbLiXjgOBaPEzDkcVqmvCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355330; c=relaxed/simple;
	bh=qjkq/RKvfQFb5T2Pfu1JjyNX+d8ZYpYpSnYPuVk1C6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1ZoP2BisWW+ujpNIMIWYlhQtsbIdQFOalLBmv+QCpJtLQP4Vrqjh3stg1wOSKW+K/Lfgg/AqynV1wRCRgjj13pVgKWn++RCgQ4W51/JOEJmxcp6Cj3fHt6O3q5z0vwlToemIJ7GbOWDHBBU7HZ5ifxyQNP/zRPuBV+sBH6HAG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RK9stOCa; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RK9stOCa"
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-c169ae1cb26so533697666b.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355327; x=1787960127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsdIc3hnlne8J62NRXp5hsbRZHH0Xv0mW/mlqC+EQzg=;
        b=RK9stOCaXCwK6WrmzacSCrrkrbhZThZCG+LkXmWviMS1t4b6mN9RGfWGU/Hth718UY
         XGTW2X4dXe7zj2v8Nq0Ai1vmv+OM7wbLitTqSbrFh6q6bvzc8TIKAm+DBeWby+wij80J
         6Uh+MlG0LCda+0d/vXxPJ/28571KxS/+0Afv8C4GUiC2vQd3GrwwIQ7//pJAh3rOEfEh
         VL51np/dw/8kUx8fyHXUMlHO5FWO+/bpZgpdE9YiQpQcfcmnx1zr122OnoQ3VbIhxRVg
         TBd9yoJ1ew7raQe09L/f3ADUMRpdSx+fVAojnMkd+2r8/S9m+g11SEoJHSyRVi3DtJH3
         ACiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355327; x=1787960127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsdIc3hnlne8J62NRXp5hsbRZHH0Xv0mW/mlqC+EQzg=;
        b=RtuFS1g2K5Mt+TuAa30e4tNLf+PVpRSAEC8Upq5gSKkcUD28NXstZgJ/K1bQb3AKZB
         iF6Ofp8p1XU84qZ1dmkeed9CapkJOF0Nlqw/5xNdBuJQxpUglZ+B0adRnPyqcMxwSRFV
         U+2MG4Hz98/4fBNljOaHKrBb5+O77t972IML9soor1qKgEf1d54aCQFR5bOgI4NHD5lw
         +GkXLlZiqX/3mR4x+wteOsCbbNg0D94vzKNeriMm7jW5+prUvVUAVEnLDlPVoESJAa4r
         B3jQSYmWmCcDf59obVmB6Wft8c2ooPvIl1UmDWjWkm9CuPDAQjwE3fxJ0NIHsVoeOih/
         F/FA==
X-Gm-Message-State: AFuF++nsDKnk4S8OOfDQrTGISyM1+u3+YRheakbwCQ+i/HKUlg6A7emF
	GaF7GSmAFOx/AlCDV2+5o9IL9XiOwzoWeOVAA1tDThzppLN8qXZfbFyb1f+ChUJk
X-Gm-Gg: AR+sD12Wtgidsj+J4tz35TKrCwvOGr7cH4Ogj/Q2yMdt5OG9WQ06odbpNRVp8zxWchS
	7YGTk3QxD00mmyShHvLHj+8F25WzEvusvLVnlMjOxRQzqhF8ukvwYv10EWi7Wty193rdGMpB2U+
	KR5ayOAlfLtyw8gTbfHj7hzvnDKO3yRy8ZhgObGRQYbKI8Q+rxzbOw3nrZ5QydsqLIwvIZ49A8A
	DBv8rcC1BVCm7AlfkzCwbIfGg6i6Bd9RdtstKieL2YYKR99Nn5SwAqx4TyYc8Ji5k/uIJQu0D4k
	cVujwoRJGnBgtvRyo19FS1CG8V1tjgkg8LhZYrLfq1Wcf3Q5PECGJw8YAVG/05uZtdEw+mNJ7P8
	D62Zb+3knJ/NvEJwLOH7Y1mXmw3/QW3FNqRXxm3O4xpurEqm3dwlmiVnTJeCAG9fraKpCZscK+p
	sBqsrUa9C+cM+ZzHpFos8DgKtHqiRoXpvPNDXdbV1obPRBsM4gIN/JoGy/2GB8TwIzFnYaSewKy
	gytHI2nbGEMYS6ijDe11OvpxMlhMeYAjnscFcHhjcrd3V+VKPU7h0Hk7z6/PWIKPzJ+qlYbES1v
	a6ma/3Ib45lMVDGAcDTDdwodOPU=
X-Received: by 2002:a17:907:d641:b0:c12:8a:7d7b with SMTP id a640c23a62f3a-c244d45ad42mr1532828866b.1.1787355326524;
        Fri, 21 Aug 2026 16:35:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b161sm50248866b.11.2026.08.21.16.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/14] bpf, s390: Convert struct_ops arena arguments
Date: Sat, 22 Aug 2026 01:35:00 +0200
Message-ID: <20260821233516.3426127-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5324; i=memxor@gmail.com; h=from:subject; bh=qjkq/RKvfQFb5T2Pfu1JjyNX+d8ZYpYpSnYPuVk1C6M=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQW+JzJnJSY8mJsqtur0vju+1p1jktE9RP08vdoxMP RrsqMjTUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlcX8jwV6ZZavdHQZOnCv4l X64tYbFdbaVj3xruXMoRtcCXa6/MIYb/gSuYLmw+nhxr6pNyRE304spI7skip43XO27pzvqU7pz MBAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A struct_ops callback receives a native kernel arena address, while its BPF
program expects the corresponding zero-extended 32-bit arena offset in the
ctx. The s390 trampoline currently copies native arguments verbatim, so it
cannot support callbacks whose stub marks an argument with __arena.

Obtain the arena base for the single-program indirect trampoline and
convert each tagged argument while copying it into the BPF ctx. Test a
nullable source as a full 64-bit kernel pointer, subtract the low 32 bits
of kern_vm_start, and zero-extend the result. This preserves NULL and
provides the register form required by arena loads.

Keep the native argument index separate from the BPF ctx slot index. The
former selects r2-r6 or one caller stack slot per s390 ABI argument, while
the latter still expands 16-byte arguments to two slots. This also converts
arena pointers passed after the fifth argument without shifting later
values.

bpf_tramp_arena_base() returns a base only for an indirect struct_ops
trampoline. Assert the incompatible flag combinations so converted
arguments can never be passed back to the original kernel function, and
advertise the struct_ops-specific arena argument capability.

Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/s390/net/bpf_jit_comp.c | 69 ++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 20b6e53999b3..964f1ad82637 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2607,6 +2607,34 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 	EMIT6_IMM(0xc00d0000, dst_reg, val);
 }
 
+/*
+ * Convert an arena kernel address into the arena pointer form on its way
+ * into the BPF ctx, dst = (u32)(src - kern_vm_start). A nullable arg
+ * preserves NULL, tested on the full 64-bit kernel pointer. The 32-bit
+ * subtraction followed by zero-extension keeps the upper half clear.
+ */
+static void emit_arena_arg_conv(struct bpf_jit *jit, int dst, int src,
+				bool nullable, u32 base_lo)
+{
+	if (dst != src) {
+		/* lgr %dst,%src */
+		EMIT4(0xb9040000, dst, src);
+	}
+	if (nullable) {
+		/* ltgr %dst,%dst */
+		EMIT4(0xb9020000, dst, dst);
+		/* brc 8,1f */
+		EMIT4_PCREL_RIC(0xa7040000, 8, jit->prg + 16);
+	}
+	/* llilf %w1,base_lo */
+	EMIT6_IMM(0xc00f0000, REG_W1, base_lo);
+	/* sr %dst,%w1 */
+	EMIT2(0x1b00, dst, REG_W1);
+	/* llgfr %dst,%dst */
+	EMIT4(0xb9160000, dst, dst);
+	/* 1: */
+}
+
 static void emit_store_stack_imm64(struct bpf_jit *jit, int tmp_reg, int stack_off, u64 imm)
 {
 	load_imm64(jit, tmp_reg, imm);
@@ -2740,6 +2768,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int cookie_cnt, cookie_off, fsession_cnt;
 	struct bpf_jit *jit = &tjit->common;
 	int arg, bpf_arg_off;
+	u64 arena_base;
 	u64 func_meta;
 	int i, j;
 
@@ -2749,6 +2778,16 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (nr_stack_args > MAX_NR_STACK_ARGS)
 		return -ENOTSUPP;
 
+	/*
+	 * F_INDIRECT is only compatible with F_RET_FENTRY_RET. Arena conversion
+	 * relies on the indirect trampoline never calling the original function
+	 * with converted arguments.
+	 */
+	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
+		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
+
+	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
+
 	/* Return to %r14 in the struct_ops case. */
 	if (flags & BPF_TRAMP_F_INDIRECT)
 		flags |= BPF_TRAMP_F_SKIP_FRAME;
@@ -2829,14 +2868,33 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			      (i - MAX_NR_REG_ARGS) * sizeof(u64);
 		bpf_arg_off = tjit->bpf_args_off + j * sizeof(u64);
 		if (m->arg_size[i] <= 8) {
-			if (i < MAX_NR_REG_ARGS)
+			bool arena_arg = arena_base &&
+					 (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
+			bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
+
+			if (arena_arg) {
+				if (i < MAX_NR_REG_ARGS) {
+					emit_arena_arg_conv(jit, REG_W0, arg, nullable,
+							    (u32)arena_base);
+				} else {
+					/* lg %w0,arg(%r15) */
+					EMIT6_DISP_LH(0xe3000000, 0x0004, REG_W0,
+						      REG_0, REG_15, arg);
+					emit_arena_arg_conv(jit, REG_W0, REG_W0,
+							    nullable, (u32)arena_base);
+				}
+				/* stg %w0,bpf_arg_off(%r15) */
+				EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0,
+						      REG_0, REG_15, bpf_arg_off);
+			} else if (i < MAX_NR_REG_ARGS) {
 				/* stg %arg,bpf_arg_off(%r15) */
 				EMIT6_DISP_LH(0xe3000000, 0x0024, arg,
-					      REG_0, REG_15, bpf_arg_off);
-			else
+						      REG_0, REG_15, bpf_arg_off);
+			} else {
 				/* mvc bpf_arg_off(8,%r15),arg(%r15) */
 				_EMIT6(0xd207f000 | bpf_arg_off,
 				       0xf000 | arg);
+			}
 			j += 1;
 		} else {
 			if (i < MAX_NR_REG_ARGS) {
@@ -3092,6 +3150,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_struct_ops_args(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
-- 
2.53.0

