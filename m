Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E0940D59E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390960; cv=none; b=sFdUAZtNmjZPkCGmQrc4MqnamRa1D1cyPiNU6Uakxdv8BOvjP6qGPjjFhD4JcXbZ3dYD/MlIGJYePXaIFGaelfks9LWZb5IZLbhYhIS4DNQH0EqCWwIN9XEv0xyO8gdLE99JICDpQ8mJfqpiDgNaMZxW31xq9299U878XXXUg8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390960; c=relaxed/simple;
	bh=mBGGbUnHaBPZ8pdYtaa0x1Q6F4i0OojXHM/laGEULY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXikCFmYgbPhyc3/A+1FpRxmSkNkPcExDPK08ukkV0VShHuIr8Y2AY44BWGB1LSNHxhSHJnIVl3e1kckUO3Zjkmg225c63H8ox4DTqVKhWNbTGFjv71aklk5p0lYVymLv8zeYwzwF2y5qi0XxU8jlR4nkhSXibNqxAD8R6Fnolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mv6/rtyw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mv6/rtyw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso3613066b.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390947; x=1786995747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lkr1vFJIkyhno/UkUAQp7w4u73WRJzZ2tehGeX/lslo=;
        b=mv6/rtywV8CHhPJWdfIkU61GxZiieDRmhXBdzKm7Vqe7/yHkac8cGsaVwMlrk1DOPE
         Avjxj+T4Nt8dYatYMW+kUFp5w81k0eLU7zchoMHINfCYuKAIng/SdYM/peu5rytG02m4
         CSEaFIq+cwLE3Uq3WfjkLH3KlxgR18RtAZ5TV39MyQVOUhov3+Mgppc8AAI/n8z34CCi
         Yye57AibjBRuRnUN8dAXJmzTLJbZYkFBthtCkL8+yL/EfHGZc3PxtGm3dLWsq1+vMwVc
         EHILb9sHt0Sja8G56f691E/NBlAOPY4wkSCnaaAVe38jll00KDW9FKMLwQZq1ou5BVVk
         gdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390947; x=1786995747;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lkr1vFJIkyhno/UkUAQp7w4u73WRJzZ2tehGeX/lslo=;
        b=owu7fQ7QCFFVEJFkwlG97LYDz/4bkcZppruRklELwnIhOQr8Vf0psBN4+VODt7r0uc
         8BcoqoJR1iGhNBgmUsT9dZqLKyGvlOwEp2q7wCI2ZjxA6h4RL0OCs79g94AXEZ8e0rrk
         /xDsLnEoWcG4z7O+3JxvK2L6S/kXion3Lp61QULxkR8ioJsB7MUNNfROmEs8vBsFjMBI
         /newDMG7bokOwXJ2ifn0zxPItGSFYes7zcIuyv6xXIA5TpPez00aIYA2L/Z8Z6QgtR06
         PsD4rE5nNPbNosWz23459xxQfymKjYzaCUJQc30LSJrpbLK7AJ1jCgQVoQgTTk8tGtIi
         w7pA==
X-Forwarded-Encrypted: i=1; AHgh+RoLzGI8Kzo50gcICnJ3RjFDC/HBPE11/laQvIhreisYvImbwwSbbhJDG+4+BCuMUYs17Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX/AMIcx4xG9l25km9yrJJ6pz1gS9yosO//NbXEZ70qDYPX1fh
	YioMg2ySYsqmWhq8JbLNsyYiJeviOlrhZNPYX0Bwd2Oz1DIvwOrJFnFt
X-Gm-Gg: AR+sD11sdchXdmFpf2/WKDrG6B/5rks9Pujtj/IGF9bn4KKQMIzF2qVa8cWkIKVvVZ3
	7BFEfchK08bRPO1wSEP16G8Li8rnVhMdDRYRZX4ZD1PCvn3pZn3biGo+w1XZaDqQvsGfmdUNkmm
	nDjOSEv1Q5YsQ0GcKsdUf+6MiXcKPqqa8RHb2q4SAAQLpxfumv4YQeLhb9ToZaYx9q8JIPouOty
	1Z3axMpQkn0KcidYVne/TDMbZ/kllBPKPmbodWJfzL7jzXAsEA58agNUq0EII+ywL7b2+vJz0Pt
	nA4WFO9fDoulG54V08dqiAAEslyDROloWYviKbtm+RoVOzhl4GZ7jqIUF8vpjjnXWjJyNIQzMQ1
	fa+25LRvn6m4t9A5DOFOAnFWq6JEp4kTDMG+H4jwi3P/C0sSlU6EAdJooA4iiQPEsuAnNZbcBvz
	xDs2MvKX41Bm+iIlH7dINw3rq39cifEYIRfUP/mbbeaZTYvuOnTcN0Z6sSB7l0bdRl
X-Received: by 2002:a17:907:1ca7:b0:c1c:4adc:31a9 with SMTP id a640c23a62f3a-c2039e3fe56mr2139790766b.28.1786390947146;
        Mon, 10 Aug 2026 12:42:27 -0700 (PDT)
Received: from TurinLinux.. ([187.15.140.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6f414sm430309066b.17.2026.08.10.12.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:42:26 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	tsbogend@alpha.franken.de,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	philmd@oss.qualcomm.com,
	bpf@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] bpf, mips: Factor out div/mod emission helpers
Date: Mon, 10 Aug 2026 15:42:13 -0400
Message-Id: <20260810194215.3754591-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260810194215.3754591-1-main.kalliope@gmail.com>
References: <20260810194215.3754591-1-main.kalliope@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Factor MIPS32 and MIPS64 division and modulo emission out of
emit_alu_r() and emit_alu_r64(). This prepares the JITs to select signed
or unsigned opcodes without duplicating the R6 and pre-R6 handling.

No functional change intended.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp.c   | 36 ++++++++++++++++++++++------------
 arch/mips/net/bpf_jit_comp64.c | 36 ++++++++++++++++++++++------------
 2 files changed, 48 insertions(+), 24 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index 6ee4abe6a1f7..320180330fb3 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -338,6 +338,28 @@ void emit_alu_i(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 	clobber_reg(ctx, dst);
 }
 
+/* ALU division operation (32-bit) */
+static void emit_div(struct jit_context *ctx, u8 dst, u8 src)
+{
+	if (cpu_has_mips32r6) {
+		emit(ctx, divu_r6, dst, dst, src);
+	} else {
+		emit(ctx, divu, dst, src);
+		emit(ctx, mflo, dst);
+	}
+}
+
+/* ALU modulo operation (32-bit) */
+static void emit_mod(struct jit_context *ctx, u8 dst, u8 src)
+{
+	if (cpu_has_mips32r6) {
+		emit(ctx, modu, dst, dst, src);
+	} else {
+		emit(ctx, divu, dst, src);
+		emit(ctx, mfhi, dst);
+	}
+}
+
 /* ALU register operation (32-bit) */
 void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 {
@@ -385,21 +407,11 @@ void emit_alu_r(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		if (cpu_has_mips32r6) {
-			emit(ctx, divu_r6, dst, dst, src);
-		} else {
-			emit(ctx, divu, dst, src);
-			emit(ctx, mflo, dst);
-		}
+		emit_div(ctx, dst, src);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		if (cpu_has_mips32r6) {
-			emit(ctx, modu, dst, dst, src);
-		} else {
-			emit(ctx, divu, dst, src);
-			emit(ctx, mfhi, dst);
-		}
+		emit_mod(ctx, dst, src);
 		break;
 	}
 	clobber_reg(ctx, dst);
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index fa7e9aa37f49..2520e1db7ab7 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -197,6 +197,28 @@ static void emit_alu_i64(struct jit_context *ctx, u8 dst, s32 imm, u8 op)
 	clobber_reg(ctx, dst);
 }
 
+/* ALU division operation (64-bit) */
+static void emit_div64(struct jit_context *ctx, u8 dst, u8 src)
+{
+	if (cpu_has_mips64r6) {
+		emit(ctx, ddivu_r6, dst, dst, src);
+	} else {
+		emit(ctx, ddivu, dst, src);
+		emit(ctx, mflo, dst);
+	}
+}
+
+/* ALU modulo operation (64-bit) */
+static void emit_mod64(struct jit_context *ctx, u8 dst, u8 src)
+{
+	if (cpu_has_mips64r6) {
+		emit(ctx, dmodu, dst, dst, src);
+	} else {
+		emit(ctx, ddivu, dst, src);
+		emit(ctx, mfhi, dst);
+	}
+}
+
 /* ALU register operation (64-bit) */
 static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 {
@@ -235,21 +257,11 @@ static void emit_alu_r64(struct jit_context *ctx, u8 dst, u8 src, u8 op)
 		break;
 	/* dst = dst / src */
 	case BPF_DIV:
-		if (cpu_has_mips64r6) {
-			emit(ctx, ddivu_r6, dst, dst, src);
-		} else {
-			emit(ctx, ddivu, dst, src);
-			emit(ctx, mflo, dst);
-		}
+		emit_div64(ctx, dst, src);
 		break;
 	/* dst = dst % src */
 	case BPF_MOD:
-		if (cpu_has_mips64r6) {
-			emit(ctx, dmodu, dst, dst, src);
-		} else {
-			emit(ctx, ddivu, dst, src);
-			emit(ctx, mfhi, dst);
-		}
+		emit_mod64(ctx, dst, src);
 		break;
 	default:
 		/* Width-generic operations */
