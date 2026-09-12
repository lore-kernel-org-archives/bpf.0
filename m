Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6553ACA5C
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236410; cv=none; b=LjPn9xc87ZXCiMfjFaxHkWMnu+QQ97D4L13qgOsG9WTrRiX3soMONqWiZDYe7K/RqYogaNFnewZQz2HuCcPktvOSlTK1rI0dWXqSgEPJvM29ivSfW5IdXu5/gwssdHz5tZA/lNwHbc/MC/0duoO7p6Y/tQDtvJctNJ0OxGOvG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236410; c=relaxed/simple;
	bh=/5jPAsRewIdGgu+LxuKzqOqmQ1yzsxrBGt667KiAUMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NK46FrcH0+/5LbMIiiQRahAmbe6GA42Dtztpumu70xGbjPGSo64eu6ASCzdk5GH6/3EfP9yTYhBIDdfxMvEmTMajmp7ZDA5Xe9scN13VqoHaVbOnXP0bWy8ZBwvskMcWug/drDn5N1qFJcf6xl0VdRlLrMhVbnqeiU6+9/c3fd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QteO3Z7B; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QteO3Z7B"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-936623c6dd3so320852785a.0
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789236408; x=1789841208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e24a776gn0DcMsvc/+/qG//5+4evMyX5zSw5dUPmVig=;
        b=QteO3Z7BnGo9wAhBI7p4BOAI3ow1qynU4Aiy2L/JIVMy4OrmdI3XvVtT2jiQ4dukBp
         cP57LazDDPy2N6BPa4HU+oLcNdqe6aGUP54cN5nU494yQIQWn9KuGDcfJuMAaLADjxbR
         v6TvgWFohZD9yY9+nozJ4q2c+qSWrO5Rj/HObLkPBA0NC/GP1VHnUGl6iwrLe/AslUZ7
         BR1Lb+MyCnIt8oMTwhJTVy3OQp7ij96b8C0M52ADlpoq+BypA6nNPzIKDGgalxsESCiZ
         3cPRiFK3XB+wl3wDbx2/wegiCvjlxjjx6gNeepZxJ4M5DDhUIjBrcw9PVWHGLHZD+elo
         oHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789236408; x=1789841208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e24a776gn0DcMsvc/+/qG//5+4evMyX5zSw5dUPmVig=;
        b=sV4D6XCmS6e4gp1EZ4x8IvIYpJOgOTNWnXn5CLaXID+pfLFaXtCT2UtdawdG4loo0X
         lqjIdVpsRN/Inm/Ok+OK0g/MYQ7aI2u03rSvQA5qdklqaMEht2i+YpB+HK3dukofGp5n
         PuAVkjIO25zfuV+ftJiLXiGu3slna5ivKO1Rt2sMfbf11MoTTSKgjRnKVHhWmbwDjMuM
         dV1MESqm56MBiwhm1zc+aiXwseEkKDNmzmX6MuoAqQuHdzPCCGqnxgKhMicS7dsq9kf/
         wn36A0l/KhsR0zyMT/X4k52Es9MrnP1NWA58jZaIK5zhIv6D+K9yjxtp08TAppL9Id8c
         pZWQ==
X-Forwarded-Encrypted: i=1; AKwUvBzfk2yT0BzcuOihBUfa59DOV5TaMPBNGXq2FxIgHL/wpBr82YiUO/xL4+Y6YObd8ZKItIA=@vger.kernel.org
X-Gm-Message-State: AFuF++mSvJ2zpYbh7fbm+5dWerkRGmf8HJmCgvKZ9Fd/10cwo5dZ1wqB
	YIQVdqPqx5Yco6YPSiSWF5cW/5ZMbQB06Tz7gMtujzPgEhOnCxJ89IdM
X-Gm-Gg: AYBFou0ZE1ze6yEX1UH3N4uFFFiiTVWhgI8lAp9jTzJPpevwOovYDyOSNR4Ytq537Fi
	H4rw+b/q5hCxPyB19WOStqj8VMZA7h9X7npR+/qjLjF3BH6IzBxTzsTwqRa+YZ0tNmBCzPFsZvl
	eP1BWdBIlv9TosO4Dnu86YO3bQdQvycR31PxFPcZIw6YljqV/9OP2ZtISYn8NnTyYYHJh4lEsXK
	go5uUb8ar45g0kR4Tdf3tkEzFchFTV2glEdmgwRukEzCpsBsP/iK3O2uwPSgPmEO08FR2Nb/8i3
	Ody/t4JGLb0cMbSnbXXNq3Nyik1iZSwvr2GiyR0dCzNYecrOGBqRYWgW2B7L1FAizSLRRU92qS3
	NqDTcEW6GRPd0qmogBS7Vs3mR2JTkgZqeqxSaY5TlPK/4QO+j4oIIhOYX9RhN7Rc1LuYPlS6JxW
	QaUkGR0VhQUANQo7TpKQWfBzlmXJDPogugQr7UFIJeAfGicyPix9hLzfaJKNoCS+JP
X-Received: by 2002:a05:620a:394b:b0:939:5d22:d1f0 with SMTP id af79cd13be357-939d7e3fec6mr1881656785a.2.1789236407716;
        Sat, 12 Sep 2026 11:06:47 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e8080404sm551110185a.28.2026.09.12.11.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 11:06:47 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf, mips: Add BPF_MEMSX support to the JITs
Date: Sat, 12 Sep 2026 14:06:43 -0400
Message-ID: <20260912180643.1426488-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS JITs reject BPF_MEMSX loads, preventing programs that use them
from running where JIT compilation is required.

Codex-assisted analysis of public test output identified the missing
MEMSX support.

Add signed byte, half-word and word loads using lb, lh and lw. On
MIPS64 these produce the full result. On MIPS32, propagate the loaded
word's sign into the high word after the required load delay. Keep
signed loads separate from ordinary loads, which can clear the high
word in the load-delay slot.

Suggested-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Assisted-by: Codex:gpt-6
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
Changes in v2:
- Keep unsigned LDX and signed LDSX as separate complete emitters.
- Drop the helper-only preparatory patch from v1.

This patch depends on SDIV/SMOD v4 and MOVSX v3, in that order.
Enabling MEMSX lets mixed programs reach JIT execution, so their
signed arithmetic and register moves must also be implemented.

https://lore.kernel.org/bpf/20260911213340.3767930-1-main.kalliope@gmail.com/
https://lore.kernel.org/bpf/20260912041220.444715-1-main.kalliope@gmail.com/

I ran the full test_bpf suite on both the prerequisite stack and this patch
under QEMU Malta, using little-endian MIPS32 R2 and MIPS64 R2. An out-of-tree
fixture strengthens the signed/unsigned load comparisons and adds negative
and sign-clear loads with dst == src. All five MEMSX tests move from JIT
rejection to passing: MIPS32 goes from 1050/14 to 1055/9 pass/fail, and
MIPS64 from 1049/14 to 1054/9. The remaining failures are 8 BSWAP and
1 JMP32_JA cases. No other test verdict changes.

Additional test_bpf fixtures passed on MIPS32 R2 big-endian and
MIPS64 R2 little-endian, covering signed boundaries, aliasing,
R6-R9 preservation across a helper call, and large signed offsets.
JIT disassembly confirmed the load and register-save sequences.
These tests exercise the JIT directly, bypassing the verifier.

Earlier comparisons covered MIPS32 R1/R2/R6 and MIPS64 R2 in both byte
orders, plus MIPS64 R6 little-endian. Those results predate this rebase;
the signed-load emitters and their delay/clobber helpers are identical.
No physical hardware or MIPS I CPU was tested.

Link to v1:
https://lore.kernel.org/bpf/20260821024640.1601299-1-main.kalliope@gmail.com/

 arch/mips/net/bpf_jit_comp32.c | 29 +++++++++++++++++++++++++++++
 arch/mips/net/bpf_jit_comp64.c | 26 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 8f1ab851863fc9aaa4a107dcd3633c5f51f219ea..f72cd21eb5ccbb6eaba15439958c12eb072b3900 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -757,6 +757,29 @@ static void emit_ldx(struct jit_context *ctx,
 	clobber_reg64(ctx, dst);
 }
 
+/* Load operation with sign extension: dst = *(signed size *)(src + off) */
+static void emit_ldsx(struct jit_context *ctx,
+		      const u8 dst[], u8 src, s16 off, u8 size)
+{
+	switch (size) {
+	/* Load a byte */
+	case BPF_B:
+		emit(ctx, lb, lo(dst), off, src);
+		break;
+	/* Load a half word */
+	case BPF_H:
+		emit(ctx, lh, lo(dst), off, src);
+		break;
+	/* Load a word */
+	case BPF_W:
+		emit(ctx, lw, lo(dst), off, src);
+		break;
+	}
+	emit_load_delay(ctx);
+	emit(ctx, sra, hi(dst), lo(dst), 31);
+	clobber_reg64(ctx, dst);
+}
+
 /* Store operation: *(size *)(dst + off) = src */
 static void emit_stx(struct jit_context *ctx,
 		     const u8 dst, const u8 src[], s16 off, u8 size)
@@ -1728,6 +1751,12 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_LDX | BPF_MEM | BPF_DW:
 		emit_ldx(ctx, dst, lo(src), off, BPF_SIZE(code));
 		break;
+	/* LDSX: dst = *(signed size *)(src + off) */
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+		emit_ldsx(ctx, dst, lo(src), off, BPF_SIZE(code));
+		break;
 	/* ST: *(size *)(dst + off) = imm */
 	case BPF_ST | BPF_MEM | BPF_W:
 	case BPF_ST | BPF_MEM | BPF_H:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 4507841a922484cda126e57d52d6a2924ef33a72..7bba0d4b0b2c04a742dec6234e4c6e610532e132 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -431,6 +431,26 @@ static void emit_ldx(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 size)
 	clobber_reg(ctx, dst);
 }
 
+/* Load operation with sign extension: dst = *(signed size *)(src + off) */
+static void emit_ldsx(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 size)
+{
+	switch (size) {
+	/* Load a byte */
+	case BPF_B:
+		emit(ctx, lb, dst, off, src);
+		break;
+	/* Load a half word */
+	case BPF_H:
+		emit(ctx, lh, dst, off, src);
+		break;
+	/* Load a word */
+	case BPF_W:
+		emit(ctx, lw, dst, off, src);
+		break;
+	}
+	clobber_reg(ctx, dst);
+}
+
 /* Store operation: *(size *)(dst + off) = src */
 static void emit_stx(struct jit_context *ctx, u8 dst, u8 src, s16 off, u8 size)
 {
@@ -903,6 +923,12 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 	case BPF_LDX | BPF_MEM | BPF_DW:
 		emit_ldx(ctx, dst, src, off, BPF_SIZE(code));
 		break;
+	/* LDSX: dst = *(signed size *)(src + off) */
+	case BPF_LDX | BPF_MEMSX | BPF_W:
+	case BPF_LDX | BPF_MEMSX | BPF_H:
+	case BPF_LDX | BPF_MEMSX | BPF_B:
+		emit_ldsx(ctx, dst, src, off, BPF_SIZE(code));
+		break;
 	/* ST: *(size *)(dst + off) = imm */
 	case BPF_ST | BPF_MEM | BPF_W:
 	case BPF_ST | BPF_MEM | BPF_H:

base-commit: c1ff425d625eb2a4d2967e9889b85f202f24eb5d
prerequisite-patch-id: aa8ca3f50fc4b0160c5fdba43a92e4b7ec3f2e07
prerequisite-patch-id: 9f324d79755bae54c56ce6c90769acc8595c9ad6
prerequisite-patch-id: 35236f563c0536859077709d52b345b696e5c26e
prerequisite-patch-id: c0f282b0e57ecd60e9582fb1e89e4b3112ae7893
prerequisite-patch-id: 528eee53fa86686e7e69fa8a12c605b386381a33
