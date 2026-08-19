Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495BB285060
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 01:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787101540; cv=none; b=fXzhc5P5cH/J9dWFHxk6AgDUMxiv8cjq3mhmWeZnvV9/xjhf+Em/RE4Jm51f+CyShZPG1XS0174FUXtDHMPuPjbuBPTIRMKPEdEKEnYaVxZH5ncO/m7QOQW01ATE4Zexn9awJz/l1/ABwOCMseY+bHAfb1tINwm8Z3XVZ3ZMgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787101540; c=relaxed/simple;
	bh=UqrwUJeUkzsTv0rDMTVViGd15AGpV8soyywstDQ4sY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJcKxEpxIe33ikI32lOgYG9AzEudc1BP9at4W1CXI+bjh2gkq1B50ZaN9AAqasi4e+HDyhTFHhNYetoV6CR+mDukcs0Q80JmH1FtRM5XXFFb9KtGaaptxXABum94SkzNb89n5HJh7PhRkS5n3SGfZ4fvyn6Qmcdw4vmrdKPjEvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCNzjaAI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCNzjaAI"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so5223136d6.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 18:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787101537; x=1787706337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BLpEIzo5KtbJPDaJel4+Tkmj18nNDZ6vMDMBW3wK2ws=;
        b=pCNzjaAIIbzocXsHi1QV0qx2E+I7/gBg+EEcWnJY90nzPnWwuXXIoc4yspL8uCjuE3
         25iH5UPJ1g2RfCXqcDy4BzxbdZSy2qpyY7rWzzQZ0HYEXPI/UUyBc0coa62PAMhtXSKu
         kLh8P4LLcFAzKZ1OUIeoZsP2bbRjbMrkseJUrCoZH4Pn1UnoVjNu6TBKydoU2Fff7lPr
         nO404ASC+12AVgZZjI4r/Ts77UfLGxZEtecdZbNEA1zyNqXSwyU6ku/2KNwIg1eRP6Cx
         TMyhoqK7qAbYjoY1BDwQmc/yxPPMscNhvfA6y9LrxC+gUBuN/Ua7YShUWh+xA84z9av/
         MmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787101537; x=1787706337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BLpEIzo5KtbJPDaJel4+Tkmj18nNDZ6vMDMBW3wK2ws=;
        b=QMS8FtoVeCCPMUk6E45sZa2DCFlbO77tn1QAEFNP/RgcrNRJzW02Nyj7enZeFpVnpw
         B3cXaibIjv4bzbvv4qs50Q+iocCsTm2QydPM6YMot/ILgAr3Ba5FbNfhs1iRGbsSBywG
         uOEdogbfHjPGXnpcIOkZ4hMSBpa1xcQEye/ZaMLQq1LH0LHnKCWahSL7Mfgjfqilv20J
         O11ZRhCJgOFRVItdKwMEbanXpE/6Jpy+MCuJ6U3Dfdm/Vr/o0rLWpKYfFSZbVzy6aN8t
         AVht9PNIPe2Crk0uCmlQsfN2VA2Q6lH9Ps73Tt7wtc2zceyT7qPKRTj1TEAmNGvbkoWU
         Qqcw==
X-Gm-Message-State: AOJu0YyKrR13kRJ3+Jupr4tYoeJ3OKRFCwAWR3lcOLQQjn5TZs+92V/3
	qUWho0n044JoQ3XTgFU26Z/JbFaFqCSEkPWX2Ayaf3YBlMNZVpPRaegkSQOwdA==
X-Gm-Gg: AR+sD11NW9yu0GkUYtW0PxqKq2dFb1vJ0LnCUsa4RueCDJ82ZC0isbbEa9NKdL78Lq8
	4sbdK8jRHFX4bNpoeZGaKEMFZDGJcetXnjGIOX7iEPi05dEQDVQc4Ns+wK/3/fYaffnvvNroweq
	0nBZw1SQfUs2Okatoe4euAz8XrubITDDfePE3Ea/ASVoeM3Je8QCA6gydIVtLJah5etUPyPvP+g
	BGqRAHrFhVqRdKq7xDNO+1H9XMnbocwyr8Y6QsvYymxOhOqmCukt5OHw7IEPjBkMKWSUBkfktr2
	RpL56OCrQeesq+oF0nA3ezmOymVkDFi+e5F+NpKZKBRo66XBITXSj+zXxLZvQkrkgwbyO3fcxw/
	LgKOvEU8pq45qcjtuKRs63W5LR+ocSfgR3HSrV+RdFgMxDB51EkyCjbX2KN1dJhDybNhVoJBw6C
	/ohNc3fq2fUbYGukIKmikN61BcD3ByXvtT9uMfR6vRmPkBs4s4n25aUd8jcA==
X-Received: by 2002:ac8:5a11:0:b0:52d:4ea9:b3d8 with SMTP id d75a77b69052e-52dd57bbf93mr11299101cf.3.1787101536904;
        Tue, 18 Aug 2026 18:05:36 -0700 (PDT)
Received: from Turin ([187.15.143.241])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f29065bsm2398716d6.24.2026.08.18.18.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 18:05:36 -0700 (PDT)
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
Subject: [RFC bpf-next 1/2] bpf, mips: Factor register moves into helpers
Date: Tue, 18 Aug 2026 21:05:22 -0400
Message-ID: <20260819010523.1057789-2-main.kalliope@gmail.com>
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

Both MIPS JITs currently lower register MOV instructions directly in
build_insn(), duplicating backend-specific handling for ALU32 and ALU64
destinations.

Introduce 32-bit and 64-bit register-move helpers in each backend and
route the existing MOV paths through them. Keep the verifier-inserted
zero-extension marker on its dedicated path, so this is a
behavior-preserving refactor.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nicholas Dudar <main.kalliope@gmail.com>
---
 arch/mips/net/bpf_jit_comp32.c | 22 ++++++++++++++++++----
 arch/mips/net/bpf_jit_comp64.c | 18 +++++++++++++++---
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/mips/net/bpf_jit_comp32.c b/arch/mips/net/bpf_jit_comp32.c
index 40a878b672f5d..bfe73b023983e 100644
--- a/arch/mips/net/bpf_jit_comp32.c
+++ b/arch/mips/net/bpf_jit_comp32.c
@@ -190,6 +190,22 @@ static void emit_zext_ver(struct jit_context *ctx, const u8 dst[])
 	}
 }
 
+/* Register move operation (32-bit) */
+static void emit_mov_r32(struct jit_context *ctx, const u8 dst[],
+			 const u8 src[])
+{
+	emit_mov_r(ctx, lo(dst), lo(src));
+	emit_zext_ver(ctx, dst);
+}
+
+/* Register move operation (64-bit) */
+static void emit_mov_r64(struct jit_context *ctx, const u8 dst[],
+			 const u8 src[])
+{
+	emit_mov_r(ctx, lo(dst), lo(src));
+	emit_mov_r(ctx, hi(dst), hi(src));
+}
+
 /* Load delay slot, if ISA mandates it */
 static void emit_load_delay(struct jit_context *ctx)
 {
@@ -1485,8 +1501,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_mov_i(ctx, hi(dst), 0);
 		} else {
-			emit_mov_r(ctx, lo(dst), lo(src));
-			emit_zext_ver(ctx, dst);
+			emit_mov_r32(ctx, dst, src);
 		}
 		break;
 	/* dst = -dst */
@@ -1555,8 +1570,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r(ctx, lo(dst), lo(src));
-		emit_mov_r(ctx, hi(dst), hi(src));
+		emit_mov_r64(ctx, dst, src);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
diff --git a/arch/mips/net/bpf_jit_comp64.c b/arch/mips/net/bpf_jit_comp64.c
index fa7e9aa37f498..45fee6f6b87e9 100644
--- a/arch/mips/net/bpf_jit_comp64.c
+++ b/arch/mips/net/bpf_jit_comp64.c
@@ -120,6 +120,19 @@ static void emit_zext_ver(struct jit_context *ctx, u8 dst)
 		emit_zext(ctx, dst);
 }
 
+/* Register move operation (32-bit) */
+static void emit_mov_r32(struct jit_context *ctx, u8 dst, u8 src)
+{
+	emit_mov_r(ctx, dst, src);
+	emit_zext_ver(ctx, dst);
+}
+
+/* Register move operation (64-bit) */
+static void emit_mov_r64(struct jit_context *ctx, u8 dst, u8 src)
+{
+	emit_mov_r(ctx, dst, src);
+}
+
 /* dst = imm (64-bit) */
 static void emit_mov_i64(struct jit_context *ctx, u8 dst, u64 imm64)
 {
@@ -656,8 +669,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 			/* Special mov32 for zext */
 			emit_zext(ctx, dst);
 		} else {
-			emit_mov_r(ctx, dst, src);
-			emit_zext_ver(ctx, dst);
+			emit_mov_r32(ctx, dst, src);
 		}
 		break;
 	/* dst = -dst */
@@ -742,7 +754,7 @@ int build_insn(const struct bpf_insn *insn, struct jit_context *ctx)
 		break;
 	/* dst = src (64-bit) */
 	case BPF_ALU64 | BPF_MOV | BPF_X:
-		emit_mov_r(ctx, dst, src);
+		emit_mov_r64(ctx, dst, src);
 		break;
 	/* dst = -dst (64-bit) */
 	case BPF_ALU64 | BPF_NEG:
