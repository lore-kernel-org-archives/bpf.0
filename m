Received: from mail-ej2-f11.google.com (mail-ej2-f11.google.com [74.125.228.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ADB415B6B
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355327; cv=none; b=QLPbRGHZvlo7Oz52KKarGtXprERNsN5KL5ezUDIRJ5nRPkWQxdLp4ZUA6F1cGTz2L+pjg7hLIXF6YLGJVTmP0YoPH39ohrfP+Srrxr1DxeIEnflmmsFfIJOrmerJGKVdkNlMKiPGNOuBAfo34ZSseLStxcx3aTlKDWxM4HicLqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355327; c=relaxed/simple;
	bh=T8NfEh9c79YoCuOAjgk3zbgG/8q2KzP78B3kkFetlb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvUGU9Sv9uztVqW9xL6lpIGOaABXJQL8FhNHzz63S3QqDARL5zH8abFqXun4GqevRyB7J2wcpUVgEgeF/UL9YQrSe25qaXKJnuk9NaOuHcNitfAgQOSignuRC4ZOqWXVRpiO5/PiW2/y/epbKcFu9sWRrS9qieTWuN/rtZc7jrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UuSX1plq; arc=none smtp.client-ip=74.125.228.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuSX1plq"
Received: by mail-ej2-f11.google.com with SMTP id a640c23a62f3a-c243d41dc07so79847066b.0
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 16:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787355323; x=1787960123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S5NgJGdcu8lrsElLmjBi9a0vHoYrop7nEZ+jACrpUO8=;
        b=UuSX1plqBp/2BboAUhSiznRL73VmswFhzWH5e4fsQYDeyzTu2OwbLdOphRnxzyCCti
         I6GwKvBfAcrilFaDbjH/tXbMAtAqxM5Uqo5h6MoW6CrKmBD64kI6Bdjr6fQ+K86mfGIP
         lWxSFbU4TUc2vOjaWWJdUwms/56nAtGi61L1L+4UWdXePORJd+TV7qoqJzfa10KQVM2t
         EKgxMvrjjY0JT7mWQFcJyDiG7h9Is3QIJEyIKIO13w813KsWtgA0XbB0ZOV24O7qnjhc
         iOmbd2Sb1bozg8b9aA9NdHUwhZoiatr5RTLxiBjwWX9R2hNxAApBZD46G94lwEJEjfJi
         stgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787355323; x=1787960123;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S5NgJGdcu8lrsElLmjBi9a0vHoYrop7nEZ+jACrpUO8=;
        b=BvL3j38X/kVtQk+v18ePLyoxrAb25xTqg5Lg2oCu2lRMG8cBhvgFjkP7gUpLz2y8hS
         5TkOvQ4cmMgggOIp7crOle8zDJ0ron4d5rE2PKcrIfuxhqxH9sV5qXBuRvH+Fh8kTStd
         fTRwglRSgcZTy7LWYn25MMSCEFj8KaCVFDvEczl3waqz02ZWSngDUnX9jO/1EMHSsQgX
         expbD9zM8dzh3lfFSoq93M3pELYZY611ZDnkEVDpDuwMF1WpsUVIKaT9z56wmkPJm/Yc
         eSqGZSWXv8r7mO8gjXFqP+2l6X5I6kkM32wXylbGdHF5xoZSfHBPCe4XxTud+yllaCVI
         NPRA==
X-Gm-Message-State: AFuF++mPDQkX1urS08nEfszdmrzrcBnGTXVUjy4N0aH/qizs+C0o+kwc
	ay81qboUoRALO+O5XEqOnC9W5MTk9l8bjicp/FjkKgtPm2ZzpSNZMg4mqnEnBr1J
X-Gm-Gg: AR+sD11A9gETyZh5vy6339a7o4xJTfpdIpt1wQ/L/5id5i5nh2JXGKbv+TFKEO565yI
	nGtLgmnptOiB7iSLjRmmenN4ahnNbfZMzX1ta6XEMmO5/pv6aOidA2Uus2PNPqqiRbKEu7CtU0Z
	OtMi7HNHjLgx1sByna98K1H7PeTpmrfPH3MnWEayi0S1wNdhAinVEa3+SWzyWVkypv4w9qFhFre
	frg7NpWO9uO3r/5XwHpdGIFzd/zt6hMH7abGX5s8WXgYXOd/2UGvYnM7fQm9EzwjDPWj/BPvqBc
	qrKQz292Wh3BvQXo5mQ+IN2Ph4quP8UcCcrNXFMnolcFAamqgbeuYEs7QJoobJ1dRIFttVf8Pqu
	BouxXmDsBHSx8Xd09POaqLspDJ/leTtWQiHJFXFz76J9CI6rhyfcfbpD19AGxyC02Kv7MM7ISXn
	HkSJPT0getG/cQQAZJCuIlrldfrtMlhKoKJFPxpgTwqqfB4ElhpuOo5rf3Idu16q9tlHkZKM7TW
	ZY0bEuCOINAO0dLdIIP0MbTulPXQNwF4xFQHD4yyf6CO5sDBORvT7u1qH60O+1uNxarvSakCgC2
	JSzAPFajItbVvLxFEIUGsV1VGwg=
X-Received: by 2002:a17:906:2481:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c246b4c5e33mr820722666b.24.1787355323356;
        Fri, 21 Aug 2026 16:35:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b59fsm58281066b.12.2026.08.21.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:35:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/14] bpf, riscv: Convert struct_ops arena arguments in the trampoline
Date: Sat, 22 Aug 2026 01:34:58 +0200
Message-ID: <20260821233516.3426127-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821233516.3426127-1-memxor@gmail.com>
References: <20260821233516.3426127-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5907; i=memxor@gmail.com; h=from:subject; bh=T8NfEh9c79YoCuOAjgk3zbgG/8q2KzP78B3kkFetlb8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavjQc+/0hKfe84lfsY/exh+bBHhXllsst/1p0Pmpx+9Y u/cuf92lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIH1jP8s1+2LeRI2IajUWcV vTSMt5d+uTpRdkXcae77C+sX7ha8LsXwT/Xq5Y5t5teOBQa+duL/sfLds98WsoYuAXs6tt4zUOd 6ywAA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A struct_ops callback receives native kernel addresses, while its BPF
program expects an arena pointer argument as a zero-extended 32-bit offset.
Convert arguments marked with BTF_FMODEL_ARENA_ARG while the trampoline
copies them into the BPF context.

bpf_tramp_arena_base() supplies the known base only for the single-program
indirect trampoline. Materialize its low 32 bits once in t2, subtract it
from each tagged argument through t1, and zero-extend the result before
storing it. For a nullable argument, preserve the full native pointer in t1
and branch over the variable-length subtraction sequence when it is NULL.

Walk the function model by argument while keeping a separate ABI slot
index. This keeps the arena flags aligned with the correct native register
or stack slot when an earlier argument occupies two slots, including the
case where a 16-byte argument straddles a7 and the stack. Registered and
stack-passed arena pointers use the same conversion helper.

bpf_tramp_arena_base() returns zero for tracing trampolines, so their
emitted argument-save sequence is unchanged. An indirect trampoline cannot
call the original function, which ensures a converted pointer never escapes
back into a native callback. Advertise the struct_ops capability
independently now that the reverse conversion is implemented.

Cc: Björn Töpel <bjorn@kernel.org>
Cc: Pu Lehui <pulehui@huawei.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/riscv/net/bpf_jit_comp64.c | 93 +++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index c97d13a3eae4..8db992a285f6 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -888,20 +888,75 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	return ret;
 }
 
-static void store_args(int nr_arg_slots, int args_off, int stack_args_off,
+/*
+ * Convert an arena kernel address into the arena pointer form on its way
+ * into the BPF ctx, dst = (u32)(src - kern_vm_start). A nullable arg
+ * preserves NULL, tested on the full 64-bit kernel pointer. The final
+ * zero-extension makes the stored value satisfy the JIT invariant for arena
+ * pointer registers.
+ */
+static void emit_arena_arg_conv(u8 dst, u8 src, bool nullable, u8 base,
+				struct rv_jit_context *ctx)
+{
+	int branch_off = 0;
+
+	if (nullable) {
+		if (dst != src)
+			emit_mv(dst, src, ctx);
+		branch_off = ctx->ninsns;
+		/* Patched below once the variable-length conversion is emitted. */
+		emit(rv_nop(), ctx);
+		src = dst;
+	}
+
+	emit_sub(dst, src, base, ctx);
+	emit_zextw(dst, dst, ctx);
+
+	if (nullable && ctx->insns) {
+		u32 insn = rv_beq(dst, RV_REG_ZERO, ctx->ninsns - branch_off);
+
+		*(u32 *)(ctx->insns + branch_off) = insn;
+	}
+}
+
+static void store_args(const struct btf_func_model *m, int args_off,
+		       int stack_args_off, u64 arena_base,
 		       struct rv_jit_context *ctx)
 {
-	int i;
+	int i, j, slot = 0;
 
-	for (i = 0; i < nr_arg_slots; i++) {
-		if (i < RV_MAX_REG_ARGS) {
-			emit_sd(RV_REG_FP, -args_off, RV_REG_A0 + i, ctx);
-		} else {
-			emit_ld(RV_REG_T1, stack_args_off +
-				(i - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
-			emit_sd(RV_REG_FP, -args_off, RV_REG_T1, ctx);
+	/* Only the low 32 bits of the base take part in the subtraction. */
+	if (arena_base)
+		emit_imm(RV_REG_T2, (s32)(u32)arena_base, ctx);
+
+	/*
+	 * Walk arguments and slots together so a 16-byte argument consumes two
+	 * ABI locations before the flags for the following argument are used.
+	 */
+	for (i = 0; i < m->nr_args; i++) {
+		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
+		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
+		int slots = round_up(m->arg_size[i], 8) / 8;
+
+		for (j = 0; j < slots; j++, slot++) {
+			u8 src;
+
+			if (slot < RV_MAX_REG_ARGS) {
+				src = RV_REG_A0 + slot;
+			} else {
+				emit_ld(RV_REG_T1, stack_args_off +
+					(slot - RV_MAX_REG_ARGS) * 8, RV_REG_FP, ctx);
+				src = RV_REG_T1;
+			}
+
+			if (arena_arg) {
+				emit_arena_arg_conv(RV_REG_T1, src, nullable,
+						    RV_REG_T2, ctx);
+				src = RV_REG_T1;
+			}
+			emit_sd(RV_REG_FP, -args_off, src, ctx);
+			args_off -= 8;
 		}
-		args_off -= 8;
 	}
 }
 
@@ -1039,9 +1094,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	bool is_struct_ops = is_struct_ops_tramp(fentry);
 	void *orig_call = func_addr;
 	bool save_ret;
+	u64 arena_base;
 	u64 func_meta;
 	u32 insn;
 
+	/*
+	 * F_INDIRECT is only compatible with F_RET_FENTRY_RET. In particular,
+	 * an indirect trampoline never calls the original function with the
+	 * arena arguments converted into their BPF representation.
+	 */
+	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
+		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
+
+	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
+
 	/* Two types of generated trampoline stack layout:
 	 *
 	 * 1. trampoline called from function entry
@@ -1189,7 +1255,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 * SP, which the trampoline keeps as FP. The fentry path pushes the
 	 * parent frame first, so its incoming stack arguments start at FP + 16.
 	 */
-	store_args(nr_arg_slots, args_off, is_struct_ops ? 0 : 16, ctx);
+	store_args(m, args_off, is_struct_ops ? 0 : 16, arena_base, ctx);
 
 	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all session cookies' value */
@@ -2172,6 +2238,11 @@ bool bpf_jit_supports_arena_kfunc_args(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_struct_ops_args(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
-- 
2.53.0

