Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738048642E
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162439; cv=none; b=G6Bl/0+PkEQAKbfP+e2mN2xrTXecWIP2ZwUyHyWRh4Cr16VxunNWjnkDauwGtEbwNjOI7fOo37PUjkxO5oTOVqC4AJMt4MBwxMWzdV8rIDyttGsRwW3GzHztES9fAdDEH6sqTmyWyMhfWVJCQ1w0wswedU1O3FOLcMUwOPLOHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162439; c=relaxed/simple;
	bh=IWB+cbvxBldSdWrEOxLvkQCXUWd+bHotGsjaP4R+oH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+dI6t8c2d+kkQhz8Mbyca61BaqMjAmFvgGDSpF9zS5DCzuDZUkY9fgCWwoLWgjO07c8F+KBIPBK2JBACHcLk8sInq94qGmjCvQer52FESpcg6wKysmvlDAIcLnxOmJrYxOvrzZSRuaoFL3AA0FSKX03t9CeRB0iaVmSF0kNfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1afA1+N; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1afA1+N"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a00745cfcso2665785a.2
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789162435; x=1789767235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OV9D4q5YUye7Q1vIF9rdT+FmHjwXYwylKYDxv971ac0=;
        b=s1afA1+Nh/fV4+gGA6CqndLK2SISNZd9EwcvK1RkyCSdS9pF+Jlt9zAwX247rwgL75
         0IzRb0/cByFW1HWbNWrgF92HCqKhF4fT3qikXg8bNYzIZTUdIyL6GZHv3AEECgNsIu5a
         soAM3/0y8r8alN+tylS4UXWeKVUodfum6IepdITxJfcK639iS3KCTI2Zwv0eFdjxCKkA
         JgiCePhLKolXUAwjvLy1ElboYv5dDql5ymi/UY96C0zqEjkFyd1U8b96nWNDLyES1l1z
         7EHF9rEdNIqJ5FndsiZe/JKa/ZQdk1mNtbepCaoIzSYk4bBMhLvpmzFy8SwsDHs19Bsz
         RyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789162435; x=1789767235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OV9D4q5YUye7Q1vIF9rdT+FmHjwXYwylKYDxv971ac0=;
        b=ZSHmL/mowvuTkuSPvMZtNvg3VR2lJK5QCz/aX2jG5MQZ4K/3XQjoVN62fwutX7ae8r
         bEF9r0ZEMeYsf3B/FgNsBevFB5gTKiH/i5mowslOYdyJ/8dhul/BBo4RvOf9KTOIzEKA
         yeMfNbDAHxmSYC8lLeJvDUvLGMC1Iy2SVupqiZTmKPnmgOFToKBY4rv3Xz8rdfbd7KA2
         vNFQQU1LPYZuNHmTLKKfP/10Bo1RpxGHqBRFdDDXLGl34fTFKyBtT37iyakw4kUSSY/V
         OIFW9ktkO+gKyd+UfUQB63aW6p8ry7MiBGtFk1tX5EwQbA86r6JlIY5oE2bDyKYtJ6mH
         9l9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwxNsTtFm6pdfNCStkLBRD8a95+w022GKvqmejO/GB9myb2Mcc1TREmx2DGX9dykv9wKZ8=@vger.kernel.org
X-Gm-Message-State: AFuF++mg7tDUvqNyFQzMGIlIP+aUagtL1MeRRlV9bg+K1KrZPWLtYAiA
	VrT4yFBvIciXN0QSP+If/JRZsIR/H176/ah7h0WhbflrQQvI+SETTRnu
X-Gm-Gg: AYBFou2BcFvaWPwiE2khltvkdK3uM2E1GWUK3zw227qQM+Mt9/Chi8YARAYfU7Z3K50
	l5dYQvYlnV2v4+BoWX5mHtautIA30IIAYKQ1bYUQ+pkmp9ElwbDqzGxaRiONqpBG3BWHR0Wdq8A
	ynT9BOC5DSKeOXZwxL32PB8ujpY0C9SGONPS7JINkvIT9TMb0B1w5llQLmk5ysOPsk7vKm/GEaX
	kimIh2mos4Nxr4+P0HlYv4ELYuaDmO3WQzt9BT+Av+PtN7dU0UYDbIN7qwST75oR9zxhG5gmUrG
	i2bW8TfaSx4LxVuH71+ODBBIKMPSF4uyGhf1Flpv7Q7u78v7xJrGVxcittAgD+nKjaUcVbtoQSb
	Lqq2o/dr5WQWM81FiVTS2l2EVHXCo1kxSv7SDwnlw+ibBHQkjJs47N9CRHC3ez6Shm8tW/VH6+B
	a72v1qvhBO/vFKq21VrlH/t01Akma+cJjWm7FsCQDuhZU2jYFa2IPYlatXcko4eknO
X-Received: by 2002:a05:620a:444c:b0:939:d913:9a74 with SMTP id af79cd13be357-93a03939ffbmr20881785a.46.1789162434800;
        Fri, 11 Sep 2026 14:33:54 -0700 (PDT)
Received: from Turin ([187.15.143.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f496598sm30170196d6.35.2026.09.11.14.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:33:54 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: tsbogend@alpha.franken.de,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	johan.almbladh@anyfinetworks.com,
	paulburton@kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	philmd@oss.qualcomm.com
Subject: [PATCH bpf-next v4 1/3] bpf, mips: Factor out div/mod emission helpers
Date: Fri, 11 Sep 2026 17:33:38 -0400
Message-ID: <20260911213340.3767930-2-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911213340.3767930-1-main.kalliope@gmail.com>
References: <20260911213340.3767930-1-main.kalliope@gmail.com>
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
index 6ee4abe6a1f..320180330fb 100644
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
index fa7e9aa37f4..2520e1db7ab 100644
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
