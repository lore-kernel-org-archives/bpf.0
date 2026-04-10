Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4813DB652
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838659; cv=none; b=SkTN13YTbvO54uwwSK/u2ErKe7u9syEZXUkZ8OnREDvY48uQ3ql9b2ZFojxusKcH9rESPXinIG+NcgQzKroxJX7NtPDwtduMDgEnsQ5rz1L3TF1m9wumYv7tejXPwVcvXkcGD6u1KMSNHKIKo/sDkDyHLvX18GAQb3WgMM4kxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838659; c=relaxed/simple;
	bh=kJXZmPFZu7kBp+MlzopRC595CR8Z0vTZX+T0v6ahPLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbt75LsrpIAzlTGn/bfmaIgqBWCyKLP9aFQu6yqYFTtp0Ni4+2e+RMNnT7gJwAdtkqfBQxErnE37klq0FmLifPNh4eAyURMvMXwrHjyWF17cJolPcq1aXGg3kZ7WePCdM47pSf9jDVG9gm0Jpnt8nTkUXlY+CiqYkX4xbf2tdpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=S51yE9Yf; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="S51yE9Yf"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2d64c756111so830180eec.1
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775838658; x=1776443458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/48P/84sTUnmEaBLFoOKoklEY1N2/FykToVynFDa8qc=;
        b=S51yE9Yf1OjFFnlm07etIlnjvF+L9BneNQPLDhxYrB+x3WfGgy8pUarmrK/qpfNXF1
         rw6uJicmIOo1pvdWCokLPNEN10QUE5TEPA9a7y1seVZu92mklj7a9UXvZSRlTbczFLac
         ZkSbcl2ny56Aqsob/9p3P2tPvDj/d2/8GQ1Ci5RPWFQid82Kc3K7nte8bBinEPOCIikK
         qQoSIhPni+1ub+Vv25YV+4OLKoB1i/UdZKTlC2dxlGfBf1PCU2C3pFqCwbbf+RopBj4m
         Bt0I7EVbu2EmaREnYV2Kvd3FEz6KZdY5X8G3L7PD4VIDFy4knaezjtUrbiDDi2DplfLY
         WBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838658; x=1776443458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/48P/84sTUnmEaBLFoOKoklEY1N2/FykToVynFDa8qc=;
        b=A89VFiu+pu/+Lj/uy1ai97LXgaZ91nXdvpu9+tkeow00aawtuGn4VCJYBcsGMocx9i
         vIbH46nNG+yE3rutQz3vwg33KA8mUXTsVDG8ZGMM2voXs5GTrt7AHuaT9TxSi1XhCtI2
         Jyz2tKss6kMUjETtHXGt62JKx85Lfcfjhe/7ut+E35D4w+OhP15yF6zS+o+cVKDxpInK
         Zg8TXN6ZoFxQ/UQ2w/AwnyYp3Ye57W+BLGqGLxQ00SnN03eimSS6g1JjaoKmQvLjknWg
         a5GXuPM+DVHYYLEm3Wyvy01os7R6RHUVBldtuyrnpO7C8amNaqCczgdnQeSA/bVjBLMA
         ttMA==
X-Gm-Message-State: AOJu0Yx+F7NBKWM4BVWTivqweezqgXZbXQUG46/6KzQQ5ZQm2fOebNl8
	jeWcenWFB0fU8OO2WN2Ii0eiIJmHhp9lkCP/gVxBDQPifVMv72m3PjvJKBogvUEENyUUZXaPsfC
	4hWjuZBo=
X-Gm-Gg: AeBDiesBOlsT6sKa/pLMOcV8tuYDnZAEqQi7WblPaFVqBoJfzk/jkm9HaKHSrt6DEyl
	AFXBbVL/WnmrAKyz7MjPLw7XGz1gNjLokG+5ifU8mH/Jv+b7q4q0VYbn3r18N9V7Dfvj028B3aj
	LheSx2bwztd880IULHYhTpTnah3dHyJdEHWj2VaOVHJx8FZq9bOtL4BGI4Py0FOpkKAdVlnu401
	JXdbM8pKYW6lW06/CD8rLezuA59RLviSU7NblLk0xe7Aj+aa6L0L3muRFSOwI+HZHXO4NDNX7cd
	DXMrHyMuMaihfVj8XJg+y2T0beJVYWJuLkoetLWuewx3BZFn1DElOKJcSqCnzmJyYy6E4FbkfJV
	TzxpHJuYD7jXtTIMA2SLk2pxpO/PsNboRQl1bv3dWnN+jcmytICQAEUDBxKZeGvO9P7zQYfVwUV
	Kvv8pODkaPE/u8/cbZkXs=
X-Received: by 2002:a05:7301:4586:b0:2c5:220c:5673 with SMTP id 5a478bee46e88-2d586380bf9mr2136914eec.5.1775838657657;
        Fri, 10 Apr 2026 09:30:57 -0700 (PDT)
Received: from krios.corp.tfbnw.net ([2620:10d:c090:600::6eaf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm5642619eec.3.2026.04.10.09.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:30:57 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
Date: Fri, 10 Apr 2026 12:30:33 -0400
Message-ID: <20260410163041.8063-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163041.8063-1-emil@etsalapatis.com>
References: <20260410163041.8063-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The compiler sometimes stores the result of a PTR_TO_ARENA + SCALAR
addition into the scalar register rather than the pointer register.
Handle this case by upgrading the destination scalar register to
PTR_TO_ARENA, matching the existing handling when the destination is
already PTR_TO_ARENA.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
Acked-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 594260c1f382..30c3e26aae96 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16641,11 +16641,32 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	int err;
 
 	dst_reg = &regs[insn->dst_reg];
-	src_reg = NULL;
+	if (BPF_SRC(insn->code) == BPF_X)
+		src_reg = &regs[insn->src_reg];
+	else
+		src_reg = NULL;
 
-	if (dst_reg->type == PTR_TO_ARENA) {
+	/* Case where at least one operand is an arena. */
+	if (dst_reg->type == PTR_TO_ARENA || (src_reg && src_reg->type == PTR_TO_ARENA)) {
 		struct bpf_insn_aux_data *aux = cur_aux(env);
 
+		if (dst_reg->type != PTR_TO_ARENA) {
+			/* Can't do arena arithmetic with non-scalars. */
+			if (dst_reg->type != SCALAR_VALUE) {
+				verbose(env, "R%d %s R%d: Invalid operation between "
+						"bpf_reg_state types %s and %s\n",
+					insn->dst_reg,
+					bpf_alu_string[opcode >> 4],
+					insn->src_reg,
+					reg_type_str(env, dst_reg->type),
+					reg_type_str(env, src_reg->type));
+				return -EACCES;
+			}
+
+			*dst_reg = *src_reg;
+			dst_reg->subreg_def = env->insn_idx + 1;
+		}
+
 		if (BPF_CLASS(insn->code) == BPF_ALU64)
 			/*
 			 * 32-bit operations zero upper bits automatically.
-- 
2.53.0

