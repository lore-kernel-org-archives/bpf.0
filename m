Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EB1D416C
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775956744; cv=none; b=scb8XjBITJi+Kmlnd6QkhYIvAylBHI2wy154TfNp8dC1qkIGbv5P9Q81wpWrHcbXiWMFnyXH+59CX4b/dAag4WH+T6FD2YvD8OPeThjHsX73qCMtcK7Thh1XS3eEK/Q4iOiS1DuCCL6EfUyWc/sP0lUPKL6gk/sTiuGZb/DtqwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775956744; c=relaxed/simple;
	bh=VL1RV0quOoe7m6nvllTNiq715eBJ2KkgBdIY7h+Ycxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRnSz0vIWoXKBrP7TEcNahmiEBXRCaOxHRrurtjPtGYovr/neghknnO9a0/tW4KKRGFTfoR23rsTuY0m5u51dAP/MoP9x7/Mo0d24PonZfOlK1Z5fGfY+I2VBMnwCXb6FDFktR0n3C7XIgmaZLI43Ptm4Ph1+wDHvFr3g8FFKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=g5S/+P39; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="g5S/+P39"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adbfab4501so13388055ad.2
        for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775956742; x=1776561542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVJoo32h8IrUWktHypz7f+bZYtIHQ6+CipEeBMln2fs=;
        b=g5S/+P397TWCFYD8Tp3JON7zY4C3nCKGcoR9yehKJLVJC4qK4jS9D3NuQv5iQNWdwb
         f0PhwAXjxwAghv3P83UuidQjR2NeGp6oxlITjHP9OPYf1SN7iFfL7qMQYI9DvJJSw4zL
         YjT1VY5RIRlEJ8Hud8dTp9sq4RWqM0WqZxBbpqJ/HkpM4OW/CuL5+QF7KClA4qteXAnV
         4FG7m0Q30dGazY3Y0KknbMBAIJU4v/VOtjk+UwUETULJ3xU1gD2gKbUUlmvI1jTyo7ft
         ODKhxj+PGmfR9grDQ+wRPtk1kHI8I161YNRu1YclF9g1wPFB1TI0ViMx9FFpkGq6ig1A
         dhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775956742; x=1776561542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CVJoo32h8IrUWktHypz7f+bZYtIHQ6+CipEeBMln2fs=;
        b=ryz3sC6l05LhLk2d0DOgyHEoE9C2WewCBctqfWzrPK4CdrRNQvGHEAHL5ij0u3SNv8
         xh18Devx9JHoD553JY0eS2npqOpqy3R98cUwnr8HJIMY5vt87gvgnthcUa1OyciR+Za2
         95tl2q9zdj0pOY13cRHzMpaX5HH0QcLJlL8/RbfpP+66Y+9BoMlSvPDuG7e/op8IGLOH
         zgSQmjHsPXkrpmc3xXYecYU6qRe0EXO0yHS3F2Stswzs/bH158t8hhyapEmhGSZur7pT
         tkdK7Cde1SqX9y730tQzKXSXVAw5BFNBJ/7uY6Jm7gQxJxt57qR9wTM7QLKG7bsg9cym
         xQaw==
X-Gm-Message-State: AOJu0YwQ5LLbFnP0CsEBHoDMHr6E7A1ktc8phDSwrmCvdnfuuJE6MRog
	bMf3+Qj+ZG+ms5AbRgz2MHS6cU6oh4SWufQuE3DBRPzPyuNQNagPHJDg+8RsFgJEsyDA4YcIu2v
	1JmbcI/Q=
X-Gm-Gg: AeBDievX5ME73xF26I/G4JFX0P6jLZxBsfPGvoFgAwNfBunY5pg20aoNoe+/NpAaTWa
	u2D6GjHfKyNrtjh/V3TqQPDBOCpzE30czpa8UJS50fBNA6w3B3Muhefgyr1HYhv+U/XgY9X8Ada
	QFMXzQE42VrUaLm6/X8XEl+R3MxE1YKeq7hdtHFMdTasX4d1qD3CVqnt1V3s0Tzm4G8QO+b3Qse
	RS2qpWwPtvohVxXeDzGEwHkIHP71DNTr1sBC/SlR6A++B3know46L5GualGpF60fXq9Zia+Y6ba
	N0yN2wyzip+9Z2bR+TJttBM9LzHBhD1zqsJ/CbP1Z2dFzKGJn3sSdsueHvhG6ftlef2QMLkNtXs
	wCtAbWu9uGNjWptb/OFZPQvntTuwFQQtTrpMSCIuOaP32+H+eQIp32H/3bJHEHF20X+2pLxVhgl
	6jImdfDgXT+Kts
X-Received: by 2002:a05:6a20:4312:b0:398:9923:749f with SMTP id adf61e73a8af0-39fe3d1f64cmr8665322637.20.1775956741854;
        Sat, 11 Apr 2026 18:19:01 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79216ffa72sm6569310a12.6.2026.04.11.18.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 18:19:01 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
Date: Sat, 11 Apr 2026 21:18:49 -0400
Message-ID: <20260412011857.3387-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412011857.3387-1-emil@etsalapatis.com>
References: <20260412011857.3387-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler sometimes stores the result of a PTR_TO_ARENA and  SCALAR
operation into the scalar register rather than the pointer register.
Handle this case by upgrading the destination scalar register to
PTR_TO_ARENA, matching the existing handling when the destination is
already PTR_TO_ARENA.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the verifier.")
---
 kernel/bpf/verifier.c | 73 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c1135d373e2..1aa60199fa2e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16640,6 +16640,59 @@ static int adjust_scalar_min_max_vals(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* At least one source instruction register is a PTR_TO_ARENA. */
+static int adjust_ptr_to_arena_vals(struct bpf_verifier_env *env,
+		struct bpf_insn *insn, struct bpf_reg_state *dst_reg,
+		struct bpf_reg_state *src_reg)
+{
+	struct bpf_insn_aux_data *aux = cur_aux(env);
+	u8 opcode = BPF_OP(insn->code);
+
+	/*
+	 * If it's an instruction with an imm operand, we know it's valid
+	 * because we checked in the caller if the destination is
+	 * an arena.
+	 */
+	if (!src_reg)
+		goto valid;
+
+	/* Ensure both operands is either PTR_TO_ARENA or SCALAR_VALUE. */
+
+	if (dst_reg->type != PTR_TO_ARENA && dst_reg->type != SCALAR_VALUE)
+		goto error;
+
+	if (src_reg->type != PTR_TO_ARENA && src_reg->type != SCALAR_VALUE)
+		goto error;
+
+	/* If dst_reg wasn't a PTR_TO_ARENA, it is now. */
+	if (dst_reg->type != PTR_TO_ARENA)
+		*dst_reg = *src_reg;
+
+valid:
+	dst_reg->subreg_def = env->insn_idx + 1;
+
+	if (BPF_CLASS(insn->code) == BPF_ALU64)
+		/*
+		 * 32-bit operations zero upper bits automatically.
+		 * 64-bit operations need to be converted to 32.
+		 */
+		aux->needs_zext = true;
+
+	/* Any arithmetic operations are allowed on arena pointers */
+	return 0;
+
+error:
+	verbose(env, "R%d %s R%d: Invalid operation between "
+			"bpf_reg_state types %s and %s\n",
+		insn->dst_reg,
+		bpf_alu_string[opcode >> 4],
+		insn->src_reg,
+		reg_type_str(env, dst_reg->type),
+		reg_type_str(env, src_reg->type));
+
+	return -EACCES;
+}
+
 /* Handles ALU ops other than BPF_END, BPF_NEG and BPF_MOV: computes new min/max
  * and var_off.
  */
@@ -16655,21 +16708,13 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	int err;
 
 	dst_reg = &regs[insn->dst_reg];
-	src_reg = NULL;
-
-	if (dst_reg->type == PTR_TO_ARENA) {
-		struct bpf_insn_aux_data *aux = cur_aux(env);
-
-		if (BPF_CLASS(insn->code) == BPF_ALU64)
-			/*
-			 * 32-bit operations zero upper bits automatically.
-			 * 64-bit operations need to be converted to 32.
-			 */
-			aux->needs_zext = true;
+	if (BPF_SRC(insn->code) == BPF_X)
+		src_reg = &regs[insn->src_reg];
+	else
+		src_reg = NULL;
 
-		/* Any arithmetic operations are allowed on arena pointers */
-		return 0;
-	}
+	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA))
+		return adjust_ptr_to_arena_vals(env, insn, dst_reg, src_reg);
 
 	if (dst_reg->type != SCALAR_VALUE)
 		ptr_reg = dst_reg;
-- 
2.53.0

