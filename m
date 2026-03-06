Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835F36998E
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772765765; cv=none; b=rdGrdz3e5duwz1W1ciLdgMJrTrYJV3swPW8FeVWaOSjxYa0Y53bSRUYxIvm5bsYtx38WfeeGNsjC7HvcVlvEaL61sKvSp6fXfPK2bFb/OmQNqckQ8ecahSp6dMwNIUFbS0yTYG8EMeMhz6BS6UQrsFEhw68MEXF+RuO4sBfq5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772765765; c=relaxed/simple;
	bh=0r9AhianaHhBaRi6Goikk6bbXXR/eOi6ITCxSqIKQTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+Avs6/KSknKqsHA6zOOzGwiV3dx1fo3a79vqgTY8XIzk4fV996Cc79KVltyzjg6qdXpA4Ip36lay8x6/82rynuAti5twj8InAovwMzINhIf3l2ACXLcQWdghyX2hLTgYX3KpgdscJA918gTpXEI5LfLCNpR3rW1MixVvYAuu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqgfMzEN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqgfMzEN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso52914146d6.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 18:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772765762; x=1773370562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kraYytm7IB1Y9w4YBbwtt0Dp0Y2H+qeL6VwnbTaeLN4=;
        b=iqgfMzEN3QRShErbeUFFKeZxj3dMOT3nx2vo2KmI6WE//zGBIifszJpzZU6vW6jymD
         p7/OZ8b4VGpXouEAybf35/66kEJxYNk5D8AgL9Fx6rCxD7rm7C1FPDhUqN290zF414xS
         tWyYzoODz8T8X1e2HCUOh/IDf/6tMyr3NbkRxkLLVeP8XtM3O+jaZFJ3l4sgu6GmrDig
         9J+xlQNQmSWT/pgVjVrNNOUkGCqhaeYOJaS0OTJK5pa393l2+16rw4vlBTiuPNnyoKy0
         U40LKt54E+/xwJIHT28rDkwiLctLT7dvUg1BZGxzOw2cLyMt2T9sJR75E4oFVo2e6hm2
         XUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772765762; x=1773370562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kraYytm7IB1Y9w4YBbwtt0Dp0Y2H+qeL6VwnbTaeLN4=;
        b=KbNLRldgOwo+pQ3BrARRgDm16r4IESixEJBetgQx3IagaU0mNLrWKba0ws1yb8k9hr
         y0GRQap44lm4MEW5sOKdtrTmTUyyuxUI79gCVFO4+4DEjFslOMz7dv+XIXRsfKT3EsTw
         4alM+ILp5raKno3OFeZeYP0IWUH1s090l3THz/tK0idfAXrHd77aHJW940UNpuEpQff3
         xDb0uQAGf2/oz5S+KNGOzuM7/m+oE44wIcOHCxZ5SOwfdiPFXS07GKUoe19Rghz893zZ
         Rmae9nUHep87YWSaAoX7197uIt9CUagr052DRjP0KKbLmSoE1vyeHMbiu9bECYzBt9uy
         6rfA==
X-Gm-Message-State: AOJu0YyitGE8e8kOf9RfN45QjmHGXYAl6toaBTPwPqRV+3SPUMJyAJDw
	RSkpPDULgCCf6KRfEveYwetMif1ZfCZUGD6BaMvaM5DkI1dwAImH/npZRZ3QRCEb
X-Gm-Gg: ATEYQzwBrdwhrQCTJkZwtJBvvwe3re6bsSrV8yZbiYszvHZSu8/km35ugq+muGNLVRe
	3yxXHh54YPC7g02kOc4H4v/XXFMRj35QSIbqNiuDUQexJ+Ls1kZX/UZgE8a5DZBy9WjBqNRLWnP
	MEM2wdrG3h4XTQExL/sHRzWKg4VcqL610/f9YbN/X3nhyzo/nX+zExsqah8TL15Hh5+OJOCBlRc
	vSemt3eT51rue5FKhKI33zmQexrh+KJtTP/JhmSHE5+3lXJxcfLylOxjaSx/7SMB4DzJJH7D6XA
	jL6lafH31PHH2xQVRC8UOve7+GWlthhyy/9RSbkNn0CJ3pfaVgxW6lqkt9zl2PJXgopxusnAspx
	QogID2WjxuYY1M4ozuLugTVXCq/RUZCcS9vYUv7zhOV1PsaWvCOZ6OHAp7HvJX4c4/xjaH2iS9W
	tZ8fqxJ3vEOv3U2nGj+yUiLkgnVL57wgHrqwsgVCANXYcN
X-Received: by 2002:a05:6214:ac8:b0:89a:116b:e674 with SMTP id 6a1803df08f44-89a30a3cd05mr7409506d6.20.1772765761807;
        Thu, 05 Mar 2026 18:56:01 -0800 (PST)
Received: from 192-222-50-213.tail19a0b.ts.net ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140d9edsm1628806d6.7.2026.03.05.18.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:56:01 -0800 (PST)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v1 2/2] selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend
Date: Fri,  6 Mar 2026 02:56:00 +0000
Message-Id: <20260306025600.870163-3-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306025600.870163-1-qguanni@gmail.com>
References: <20260306025600.870163-1-qguanni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that signed 32-bit division and modulo operations
produce correct results when the dividend is INT_MIN (0x80000000).

These test the fix in the previous commit which replaced abs() with a
safe helper to avoid undefined behavior for S32_MIN.

Test cases:
  - SDIV32 INT_MIN / 2 = -1073741824 (imm and reg divisor)
  - SMOD32 INT_MIN % 2 = 0 (positive and negative divisor)

Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
---
 .../selftests/bpf/progs/verifier_sdiv.c       | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sdiv.c b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
index 148d2299e5b4..fd59d57e8e37 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sdiv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sdiv.c
@@ -1209,6 +1209,64 @@ __naked void smod32_ri_divisor_neg_1(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("SDIV32, INT_MIN divided by 2, imm")
+__success __success_unpriv __retval(-1073741824)
+__naked void sdiv32_int_min_div_2_imm(void)
+{
+	asm volatile ("					\
+	w0 = %[int_min];				\
+	w0 s/= 2;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SDIV32, INT_MIN divided by 2, reg")
+__success __success_unpriv __retval(-1073741824)
+__naked void sdiv32_int_min_div_2_reg(void)
+{
+	asm volatile ("					\
+	w0 = %[int_min];				\
+	w1 = 2;						\
+	w0 s/= w1;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, INT_MIN modulo 2, imm")
+__success __success_unpriv __retval(0)
+__naked void smod32_int_min_mod_2_imm(void)
+{
+	asm volatile ("					\
+	w0 = %[int_min];				\
+	w0 s%%= 2;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("SMOD32, INT_MIN modulo -2, imm")
+__success __success_unpriv __retval(0)
+__naked void smod32_int_min_mod_neg2_imm(void)
+{
+	asm volatile ("					\
+	w0 = %[int_min];				\
+	w0 s%%= -2;					\
+	exit;						\
+"	:
+	: __imm_const(int_min, INT_MIN)
+	: __clobber_all);
+}
+
+
 #else
 
 SEC("socket")
-- 
2.34.1

