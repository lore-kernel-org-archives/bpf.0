Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A770345734
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 19:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777321; cv=none; b=IGYONfjRbXiMsMEudjhBmfI8yh4i1f/TtcicG5OKuW1bjPSyr2DnQMshqRFMgV32/agVf2YqGj0oENYCo+5lr6eHJJlkm2bWPc8GOAsG9WK4sgyDKYeAXamecgo68ThkCl3+alzJiXYUjSs46UbaBwrKo6MbbjiSh7m9Wyr1hYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777321; c=relaxed/simple;
	bh=2UD3KBpGY1LRxUE8oKvo0f1y4lNr8R8tppmnHX/CYuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lp+84t7rel+nZS6VEiEq//LPhLXXmTxbz4H05+H2Co2YOvIy4h5tXt8vYWBol4ZRS6RDhie7byFqZ/K1QWqa2XvAnVneFgb/Yuj3akGknfNHGs+U8QdDcNF8bl4wBaqs8rywZ5ignWGbzvGJl3vmPC8Imic4155xB4FrROlTrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+/n5Cb3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+/n5Cb3"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b611274bso3835837f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 12:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773777317; x=1774382117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pM5X9sApGQ9zaw5qHX+/M8sYx0ZU/nQZ4bT3CP7TFEo=;
        b=K+/n5Cb3iL3nHMYsAr+AYZNArwewa/T+YJohjrzF8D8UWIjdW/deK8KNCjLqXUIuxj
         H7CDfOEjql+ipAEP01P/uZOfK8kxfAcXul+h18hutjkBtj6DH60iEBoIupbPuY4dsfRd
         bgptf+LhdNEMIUUMvFTtL38u2gRghDYA1CeSaL5qy3mKxFvk+uQzDQpmosnBiYCDFZaK
         VzQ8TIGjumF+kBT5u5S4KRdHYzkuE1GAOCBA9GlA2JFhp0k55lUdlbo9WTFUgVIHVjLD
         4yR3tnGUxtdg7Xna1pE9yRi+moaUrOuhMJbM3TbBvNYVkTIeltg1OYxmQ2ykQoBk+PAN
         KkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773777317; x=1774382117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pM5X9sApGQ9zaw5qHX+/M8sYx0ZU/nQZ4bT3CP7TFEo=;
        b=H6/TIrJ5ZcLi9hxFivlj/CFo+f9iIH/dlsm6VW1pBV9xOq1NDkjf0oGXXz7vrSdpoX
         PVDZtqj4/1ROJaKo5opLcOKLwrbyLUi70B+Hmals6v6VB4GwkHaHHrIr9/cqrYLRQtEq
         cgyAjJDAda9VZx2R9AkcIC8zxRF268yqmig0cumDMSQJD8UHmUmQn+O+4FzLU4uBlejd
         2gEPky61BHeR2BmoanRQUXVxYH4h0PW2cXC3nJZIjlBVCDMMXAIZAi8rM7E7Fx5lzB60
         vk5R98tnQnDuq1MYdUxCdwml+1P5tNauZdz5a9TQUviXK7j7cJY9EGx3noTiWzhMuPwY
         Q22w==
X-Gm-Message-State: AOJu0Yzqp5Yi7MendTtUL59PLfZAES20z55DkmN5uAj8PqEEN/riEfbD
	ruDXhtWoe9wB2IOOlWP+WXFCE5jqUF7cQRol8WMwq5/Edu5CeAl/V4Bozemm1ns=
X-Gm-Gg: ATEYQzxmXljbe6CoWNa/zGwCmGc5lkX1cL8IjdlrRweartanfjR1Hq/XwmFLoStCvyV
	6IolphDYhEJ4e7lKmb4ta/uo2UwaWCUD4ApR/DSjOPJ6eWlpgWjW3UCYJ8VfdtvMm9+YgIN1izg
	pz7WO2hARz9JrcuS/PFuTZJEL+y6quD8tuE3Oqk80G2x4ANkRQB8s6aJOLVQYnwA2vuyXmstvUi
	SN8ikRq/iVq5l75FbLU5365psDPANtdmP/4aRmBeyVmA5ch5lsz6VBx6TlysnlPt2aK3HWtTYBD
	R0RS+v3lyyA3YOvkp/5986pMkOPwIPVQ4DAcdwaAD/GKBs9QEL0GEpMU6c/PxfBuKM6cwj4zU6j
	TPjFdBo2nys4XLTqvlFvqpGf2xrF3zM0SJZ9RO307oDyKCT+rZphxBr+6OFKq2ZxH4HSqNC8RbH
	GcdqWxSxiaoQXSyw==
X-Received: by 2002:a05:6000:420a:b0:43b:514a:ec78 with SMTP id ffacd0b85a97d-43b5279c925mr976258f8f.1.1773777317034;
        Tue, 17 Mar 2026 12:55:17 -0700 (PDT)
Received: from jacks ([197.38.195.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51892234sm1570645f8f.24.2026.03.17.12.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:55:16 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	gregkh@linuxfoundation.org,
	Ibrahim Zein <ZeroXJacks@gmail.com>
Subject: [PATCH] bpf: verifier: fix integer wrap in regs_refine_cond_op() BPF_JNE case
Date: Tue, 17 Mar 2026 15:54:57 -0400
Message-ID: <20260317195457.1677928-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In regs_refine_cond_op(), the BPF_JNE case narrows register bounds
without guarding against wrap-around at type boundaries. When
umin_value equals U64_MAX, incrementing it wraps to 0, producing
an inconsistent bounds state (umin=0, umax=U64_MAX-1).

This can be triggered by constructing a register state where:
  r1 = unknown_byte | 0xFFFFFFFFFFFFFFFE
  -> var_off = (value=U64_MAX-1, mask=1)
  -> constrain with JGE U64_MAX -> umin=umax=U64_MAX, tnum non-const
  -> compare with BPF_JNE const=U64_MAX -> wrap occurs

The same issue exists for all {u,s}{min,max}{32,64} variants.
Add explicit boundary guards to prevent wrap-around in all cases.

Reported-by: Ibrahim Zein <ZeroXJacks@gmail.com>
Signed-off-by: Ibrahim Zein <ZeroXJacks@gmail.com>
---
 kernel/bpf/verifier.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17017,22 +17017,34 @@ static void regs_refine_cond_op(...)
 		if (is_jmp32) {
-			if (reg1->u32_min_value == (u32)val)
-				reg1->u32_min_value++;
-			if (reg1->u32_max_value == (u32)val)
-				reg1->u32_max_value--;
-			if (reg1->s32_min_value == (s32)val)
-				reg1->s32_min_value++;
-			if (reg1->s32_max_value == (s32)val)
-				reg1->s32_max_value--;
+			if (reg1->u32_min_value == (u32)val &&
+			    reg1->u32_min_value != U32_MAX)
+				reg1->u32_min_value++;
+			if (reg1->u32_max_value == (u32)val &&
+			    reg1->u32_max_value != 0)
+				reg1->u32_max_value--;
+			if (reg1->s32_min_value == (s32)val &&
+			    reg1->s32_min_value != S32_MAX)
+				reg1->s32_min_value++;
+			if (reg1->s32_max_value == (s32)val &&
+			    reg1->s32_max_value != S32_MIN)
+				reg1->s32_max_value--;
 		} else {
-			if (reg1->umin_value == (u64)val)
-				reg1->umin_value++;
-			if (reg1->umax_value == (u64)val)
-				reg1->umax_value--;
-			if (reg1->smin_value == (s64)val)
-				reg1->smin_value++;
-			if (reg1->smax_value == (s64)val)
-				reg1->smax_value--;
+			if (reg1->umin_value == (u64)val &&
+			    reg1->umin_value != U64_MAX)
+				reg1->umin_value++;
+			if (reg1->umax_value == (u64)val &&
+			    reg1->umax_value != 0)
+				reg1->umax_value--;
+			if (reg1->smin_value == (s64)val &&
+			    reg1->smin_value != S64_MAX)
+				reg1->smin_value++;
+			if (reg1->smax_value == (s64)val &&
+			    reg1->smax_value != S64_MIN)
+				reg1->smax_value--;
 		}
