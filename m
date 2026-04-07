Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C0285CAE
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775537856; cv=none; b=M2gyLM9TwUE0JHafOh93hXQAYxhDiYHFK6ok0byaTTXPpYklMMLkx/1RGOp9ZNOMIG1DMvGICpPJ95j/huYCEg48lFpqyryi516sdIsU3/3mIUgjWB68jD+3OqWOjOdeSbIE+rcXq7eOuux4HNQkDsW32zZBbjqTl3wQsjGC1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775537856; c=relaxed/simple;
	bh=5QqVZrGHAOHNHUq/7fgURCe4SxcGSxNK/J/0xarHhh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUetd5SU9BPmzPu0gcMGDCOU9O8vDjVE8mbKZBoHwXyMK4Y33tW2vHRMimTtDrID1kXR1dSSST12ziudhj6ur1qfXKLf3UXE9r0xk5ubMR8ow0pdIVvegh8SGi47AiIyl5mOyjC1G0SSna4zMrNr2SzBVY2wtwXUCeaofMFP0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=dZcKDB1u; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="dZcKDB1u"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2086159b3a.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 21:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775537854; x=1776142654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgVPkspkEykXOmlR8vWvf5SW1kN9/SJrg9t5H+7mpYM=;
        b=dZcKDB1uAPFRv9OsSK6N4EeZlB4Bb2loLq96AW2wW/IxtWHZh2w6jg54Q+fgR4Hlm5
         WZX80gGUrDOpXqDevk1UZivFbCisr7RDWJ3PIOQH1GTUlaRah8jPUG2N81pPzxlCJn99
         mRu9P7GHpvF4IMnC1T5ouF9SQTnz2kd6DZds/leDFCXVeU0TIxKUZYpWAS3zqUZrNzZX
         m3WojSMPuVdCfIv/xQt5NBvcOsFCk6eE3virV1T+iGl3YiPd6+OWDjmKwSZfSvybulKd
         AZN9QcTwNBKpWsxkpYlTYQeg680VVFpU1Y+4+HBIyt/Pc1nTWdZMGCLquEDsTlhEYtFc
         n1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775537854; x=1776142654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgVPkspkEykXOmlR8vWvf5SW1kN9/SJrg9t5H+7mpYM=;
        b=S7OSBTvsDXeeWwm9coS+q7urLIrh3i7QNSElMGRDm8kNwXlkvPcygygT8w0HMoj3oq
         WBXOU/77kzuJBnD/pArf4gdUZVmipLO07jMpqcPfcpChI6/p+5KNXZhJRX2X9SA+2fsI
         JBAGeEMB9EglL4QNcFyjQnbifW7QcsQm13KprNJ8lJd/AtaHFC2FXX3aP55F+t1B8Dw4
         rU4utOvEq9S1lQJN2Ol8J+Rxxqb3skUdD1gfSaGJhMF58CNlMUtFPNA/+8K0iMTCi4W2
         yTOH7077FBtrbML7L45YIurXA+e9e/wvPLIIMW2Vi7uvVp8RANKm7OIO/2H/o3YjW971
         OEaw==
X-Gm-Message-State: AOJu0YzoWcyJypcZdEoxe0VDpq3TOw+Ujft79FhGquM73QedYAsXdgFj
	dtt8OBP7SOs4qyYKrdnkZjJQnqHA296EQv2rfW/Tum1rJhKSoADvuwb8Wf0lnmL/NqLI5+S0suz
	MHeQvckmrQg==
X-Gm-Gg: AeBDiesyW66CK8iW7dRK3sFd4UBk4ZXR12xwH2oRBlzO4pv4sKL5sfxQwj5c4f7xyPj
	9/+c1yzbDCR2cffXh1kGr2w9KlTbESh1vW7uEWzvRwhEUeWHJQuYfyBClg0O6hCGG3vOSEFPiDV
	nL/vv5ng2RckXHEZb84rCkhDQ5R5HrMoe2yZWOihhgRtAbsAtX/cYqwA29/lKMX1TQqq73VtDrC
	cAI9AUB9Sw5bozB0h/eM5Ax/+RHpcb+TJPLOWtRFaW5hSU6N3SFmMhz8417KaSRbVnC4TjzZeQQ
	TIZDvMiGg3QOaHIw32/r7tvUklSnVDonhRMjin20s2xVfcPHdK8tRubNy3c5pWhTWFbQP8dyscV
	tgSVtX5fV2OHt7A9K2935D6IBK2yY6bL3sp1SrGp6btjbXK45/VUp8ssyYQw7s07OHIgpLkQImZ
	h/Ip8UhjTP2vsl
X-Received: by 2002:a05:6a00:1405:b0:82c:e39d:b845 with SMTP id d2e1a72fcca58-82d0da3dd42mr13921986b3a.4.1775537854348;
        Mon, 06 Apr 2026 21:57:34 -0700 (PDT)
Received: from krios ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm16156807b3a.2.2026.04.06.21.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:57:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	memxor@gmail.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	song@kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on arena pointer addition
Date: Tue,  7 Apr 2026 00:57:22 -0400
Message-ID: <20260407045730.13359-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407045730.13359-1-emil@etsalapatis.com>
References: <20260407045730.13359-1-emil@etsalapatis.com>
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
 kernel/bpf/verifier.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..30bb71f90477 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16297,11 +16297,34 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
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
 
+		/* The compiler sometimes stores the result of a SCALAR/PTR_TO_ARENA
+		 * operation into the scalar register. Properly mark the result as
+		 * holding an arena pointer.
+		 */
+		if (dst_reg->type != PTR_TO_ARENA) {
+			/* Can't do arena arithmetic with non-scalars. */
+			if (dst_reg->type != SCALAR_VALUE) {
+				verbose(env, "R%d pointer %s arena prohibited\n",
+					insn->dst_reg,
+					bpf_alu_string[opcode >> 4]);
+				return -EACCES;
+			}
+
+			/* We have a SCALAR_PTR_TO_ARENA operation,
+			 * propagate the info to dst_reg. */
+			*dst_reg = *src_reg;
+		}
+
+
 		if (BPF_CLASS(insn->code) == BPF_ALU64)
 			/*
 			 * 32-bit operations zero upper bits automatically.
-- 
2.53.0

