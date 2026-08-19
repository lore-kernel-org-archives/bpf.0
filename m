Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD7638E8CA
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 01:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101545; cv=none; b=dvorKNrODyo+5ijwEriX06h1g6AuKIIHeJAiZthnV3U0IwWp1Iw3R2BWhaAVH8AEbbMI12AGStn7vnB/WXgrv0NDrynt5b9oorMPKaJsRhuELW4fxIrZjndmgdXbe2ZYoeZoLtqzVTMUVH2ad1mbFbUP0+ZgGFY43YsEE20j0NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101545; c=relaxed/simple;
	bh=tu4O6ulqmyBR5DD3Tt+778kCw8H/W2Sagw2kCFDkBC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYj3tpKRxsMkpPB7ZWFxLMcSK6fEezepHuQk1K3wHoXQQTtHu6vXQYekahTTk2QUNvzZFjKXDt5+chtFEEziyEVrpUzwXzKXGKJTo2+8+sRNLFavovwSePFKDaTjiDaerNgXGiiTd66Sr46eXdo+LFCSWltj4rbQiqC6IBUCWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxmlevdu; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxmlevdu"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f0e5e36912so3955746d6.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787101542; x=1787706342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X5BInVFSx5KgDgWd5lPzsdKA/ib53KbJsd4rhxIrz68=;
        b=lxmlevduZ5v8Lfw1EeGpx9UQnH/hgOxcgh/o7DbxhZhM5HgnFuhoJaKzzGwxL+Veak
         zYhN37FqOIpdwqJ93vZcBAA+DCNA7FsNV4hkHL77YETahFoNYdbcxb/d5SEkKubG8G2h
         Aq9jFQutf6ABVEwALCPmcCRUal6M0Y5QwfvtkupD89Iw2vUul8b5orAjVS5VyxkHXbwy
         ag1nhP6JCqySvNoZiiz5Mh+F5tYfhBTR+W6e8Tcua1t2z0/G9DnCxhZD018SeHzDZGaB
         DqpbcBk1GMxjqaEE/s80W9SIP0fFAf9tuTBtbAx/TA+VxEZx+xmXmpok6GyG76k4VUSS
         fVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787101542; x=1787706342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X5BInVFSx5KgDgWd5lPzsdKA/ib53KbJsd4rhxIrz68=;
        b=kGSTN6XpG8++rooofBaBUWUHIyvsHzmwgGD4+wtto5RTBQvJX0n93EZ6oQzm5y/cEt
         pxmEMRzfNJ9/r7tMdTC5YIdoC6Dr9L/wp3utQpos3sBBo5vb4zOHy4HoRjEnEn1SM8Xh
         2aPSLBSJSOFh+wYMq3G4wLG/cLDScJadSKBwe9JgBLyDl0UpRuqKuvYCHjvY60GnwLyz
         wktLvQibGHGB6QgtFaAvx8iMKEzgQrbdeRXrjNtaFBin6/r96H2mGWjPvcmDbhbWXa0A
         xMVyQsOGCFNUzeGU5SWI5+FgLklntggksOaMovG4kcjHPwfHSXbCHuCY8j8Z2VNmyq/+
         AkGA==
X-Gm-Message-State: AOJu0YwWoGLn4wvoAvGloXjkEzlkQ1zRpctDyH3OHCUUWekQA9wu3AIk
	CiIUW8lBMmUD3WtnDU2CAEWsTGvCwc6h/NPHlgPnrewcCuwP7scxLAo+jRWUOQ==
X-Gm-Gg: AR+sD11fMnZDOl5170HDFO84pUlu7pZbd+RTf2LK8p5c4hhTUVfQHAfsyXrV93nHi/7
	eaEKSsggTDa1W9QsR1ZoyL1fZKRJKGjEBmZFU/oDxauvu/2eweAr+ZhKDtVbndZjN4/OB7GGITp
	6kOQxJqIeeGZngn1gDKGum5VlKHzEh7bYyv4d0KqHWpXFuQSQzArPOlrc5zrV6JhCDt8DDI2gVI
	/EREzSYuBoeq/VNC7MBKu78AUZwiWPNCqCOTuvUqFYicMLc+PqcXVUjwCfB7GJZPbGfpU68r4Wv
	wXf3AwXZvMr1MhD591Gp4qv081FcUH1W6vEz1VR9oJlgoXRngKNvfNMpkSf21V3zXGy78ekCbnT
	0mw3civ/P+jQefrN21T/V5rhWxRwe6Wgreu4hD5sCF6PyUDa/3NdFIfq2Kn5iBze1QvAcqUmPFE
	pEgjuaO65N4GuxQRde3XmRoL71uv4ZPXjFrtcorrJx2xCJzkw30hk/+d7WM/YL/tnmLxE7
X-Received: by 2002:a05:6214:469e:b0:90c:40ba:e64d with SMTP id 6a1803df08f44-90c5e7133b9mr11229766d6.8.1787101542483;
        Tue, 18 Aug 2026 18:05:42 -0700 (PDT)
Received: from Turin ([187.15.143.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f29065bsm2398716d6.24.2026.08.18.18.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:05:42 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org,
	tsbogend@alpha.franken.de,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC bpf-next 2/2] bpf, mips: Add support for BPF_MOVSX in the JITs
Date: Tue, 18 Aug 2026 21:05:23 -0400
Message-ID: <20260819010523.1057789-3-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819010523.1057789-1-main.kalliope@gmail.com>
References: <20260819010523.1057789-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MIPS32 and MIPS64 JITs lower register BPF_MOVSX instructions as
ordinary moves because their register-move paths do not interpret
insn->off. Negative low-width values therefore retain incorrect upper
bits.

Teach the register-move helpers to sign-extend the BPF-defined MOVSX
widths: 8 and 16 for ALU32, and 8, 16, and 32 for ALU64. Propagate the
sign into the MIPS32 high word for ALU64, while retaining the existing
verifier-managed zero extension for ALU32.

Keep the verifier-inserted zero-extension move on its dedicated path
and interpret the raw offset within the MOV helpers.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 50 ++++++++++++++++++++++++++++------
 arch/mips/net/bpf_jit_comp64.c | 46 +++++++++++++++++++++++++------
 2 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index bfe73b023983e..66ade9d77638d 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -190,20 +190,52 @@ static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
 	}
 }
 
-/* Register move operation (32-bit) */
+/* Register move operation (32-bit), optionally with sign extension */
 static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
-			 const u8 src[])
+			 const u8 src[], s16 off)
 {
-	emit_mov_r(ctx, lo(dst), lo(src));
+	switch (off) {
+	case 8:
+		emit(ctx, sll, lo(dst), lo(src), 24);
+		emit(ctx, sra, lo(dst), lo(dst), 24);
+		clobber_reg(ctx, lo(dst));
+		break;
+	case 16:
+		emit(ctx, sll, lo(dst), lo(src), 16);
+		emit(ctx, sra, lo(dst), lo(dst), 16);
+		clobber_reg(ctx, lo(dst));
+		break;
+	default:
+		emit_mov_r(ctx, lo(dst), lo(src));
+		break;
+	}
 	emit_zext_ver(ctx, dst);
 }
 
-/* Register move operation (64-bit) */
+/* Register move operation (64-bit), optionally with sign extension */
 static void emit_mov_r64(struct jit_context *ctx, const u8 dst[],
-			 const u8 src[])
+			 const u8 src[], s16 off)
 {
-	emit_mov_r(ctx, lo(dst), lo(src));
-	emit_mov_r(ctx, hi(dst), hi(src));
+	switch (off) {
+	case 8:
+		emit(ctx, sll, lo(dst), lo(src), 24);
+		emit(ctx, sra, lo(dst), lo(dst), 24);
+		break;
+	case 16:
+		emit(ctx, sll, lo(dst), lo(src), 16);
+		emit(ctx, sra, lo(dst), lo(dst), 16);
+		break;
+	case 32:
+		emit(ctx, move, lo(dst), lo(src));
+		break;
+	default:
+		emit_mov_r(ctx, lo(dst), lo(src));
+		emit_mov_r(ctx, hi(dst), hi(src));
+		return;
+	}
+	clobber_reg(ctx, lo(dst));
+	emit(ctx, sra, hi(dst), lo(dst), 31);
+	clobber_reg(ctx, hi(dst));
 }
 
 /* Load delay slot, if ISA mandates it */
@@ -1501,7 +1533,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
 		} else {
-			emit_mov_r32(ctx, dst, src);
+			emit_mov_r32(ctx, dst, src, off);
 		}
 		break;
 	/* dst = -dst */
@@ -1570,7 +1602,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r64(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src, off);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index 45fee6f6b87e9..31f73f50caf5d 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -120,17 +120,47 @@ static void emit_zext_ver(struct jit_context *ctx, u8 dst)
 		emit_zext(ctx, dst);
 }
 
-/* Register move operation (32-bit) */
-static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src)
+/* Register move operation (32-bit), optionally with sign extension */
+static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
-	emit_mov_r(ctx, dst, src);
+	switch (off) {
+	case 8:
+		emit(ctx, dsll32, dst, src, 24);
+		emit(ctx, dsra32, dst, dst, 24);
+		clobber_reg(ctx, dst);
+		break;
+	case 16:
+		emit(ctx, dsll32, dst, src, 16);
+		emit(ctx, dsra32, dst, dst, 16);
+		clobber_reg(ctx, dst);
+		break;
+	default:
+		emit_mov_r(ctx, dst, src);
+		break;
+	}
 	emit_zext_ver(ctx, dst);
 }
 
-/* Register move operation (64-bit) */
-static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src)
+/* Register move operation (64-bit), optionally with sign extension */
+static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src, s16 off)
 {
-	emit_mov_r(ctx, dst, src);
+	switch (off) {
+	case 8:
+		emit(ctx, dsll32, dst, src, 24);
+		emit(ctx, dsra32, dst, dst, 24);
+		break;
+	case 16:
+		emit(ctx, dsll32, dst, src, 16);
+		emit(ctx, dsra32, dst, dst, 16);
+		break;
+	case 32:
+		emit(ctx, sll, dst, src, 0);
+		break;
+	default:
+		emit_mov_r(ctx, dst, src);
+		return;
+	}
+	clobber_reg(ctx, dst);
 }
 
 /* dst = imm (64-bit) */
@@ -669,7 +699,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
 		} else {
-			emit_mov_r32(ctx, dst, src);
+			emit_mov_r32(ctx, dst, src, off);
 		}
 		break;
 	/* dst = -dst */
@@ -754,7 +784,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r64(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src, off);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
