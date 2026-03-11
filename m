Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120173563F8
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191480; cv=none; b=M8sxeEJ/M+8qhc8DsxH0fcpURVDHXnF9zLIfZ9U6ClxiMfGLle0gi39DB1os/lkJ/kinYEAv/rxrlHmpxg49HTSbQMyrVCodAWGi43mdW2wRqb8zQGPXptzCKKsxpTMM9YfVre30EBfQF+vFYuDcm3jNc4TIQz4FbdATEm6i504=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191480; c=relaxed/simple;
	bh=q8f1a4gXGGKKvQPoCZ2rgr6JaxaZfo/S6c2OO1Vglic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/4E1VrCtlscXAoJY2tbmtObnwHeUAung2RvZ+uhG4wIqyltMBXcDEkqcCT/i4uWwkQ2xvHTv1+cXynMjGwEMaD7d/N7+QppjIcRNVh1dU6nJ86DNhGYnH1zOCd+DBaoIIZvidRshb59w9lStpkKhRUncaROkW+oeKM3ykeRXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBQFRAkU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBQFRAkU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cd7aab92dfso55633485a.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 18:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773191478; x=1773796278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAagcjs0HxgpqQ+jMuWf95GjMH4Ngc1lHVd0VTgWFxE=;
        b=NBQFRAkUh3BSDW8g2pv7iq4mSzfTzw8SaQr9EqJt0CJfQhAaHWzY58eYxeoQGEJxjp
         PahrGa9TqBkMIV1e9WT1e/1raLgOkVCabx7EaslmwcZU4Jp/TCSzVIQoUg3fTXVuDPk7
         GtnRm5HOedp3hW9vBwA9OjOd4E7NQFn0wjKaCJKEFDo3T4+pGytH5WUQ2+W9nbcLetKn
         Y0XADVNREjAY7mlBlhGg1wJdjnpn+mGhEjcUbgFzGwx5p7FLbM2QP13F9+hv99tbvPbd
         Nv7+628cpOyy42VKRMYJvZ+/+3yUNZ4vlBO5A+hJdwI3YfnfiLtzwUxvww8FRIUy1X9T
         vD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773191478; x=1773796278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAagcjs0HxgpqQ+jMuWf95GjMH4Ngc1lHVd0VTgWFxE=;
        b=TQh3/xDnAhrQPF5dXBksyq69BzCeg1Vmgt5gsUXVnD4K7duDyfVtd9WILBtpw2Irmp
         FpRTTcbqLcW7r3aYbAqe/5q3CG81/wVveHZsvm9f51B2sLdLNBCfa5n+j5jWQGcoO+XZ
         GF61kDzpGx3OilG2OHPd79LanOBkocUqNMPs6tRYDF1kQR6HncOxHJFPJxvgllNN1bLA
         VTb1rLE3AyirtjEPtBq3aNl3cOpSJa1l6u80EjE+LQDEb4MR3cfvXOFkM1/Cmz4jLG84
         t4eYzg6W41j0SlVHtMKPW3+fMdkHH51xQDhkiijYxQOYms+0NEgV468/JuwFMxD/UFm1
         lvsw==
X-Gm-Message-State: AOJu0YxDMwSiR1bXtbxFli9ReikgkXKviJ+XLaepjuZds3LETFTNIXL8
	Kq1EnuzPjy6w39USkD5KIXocwzB1jtStSqM1uZMlRsUTIl6wjVa+WnjHVyuzY1N7
X-Gm-Gg: ATEYQzx4DbXBbV0/08zH1qNpMJOJu0D9FjGEtGdUWRJ5oieNLXJCNSyDcWMaib2Ye0x
	uDa9LaAnpoRbxOZ0NL+FxDyivjZeIAcHZeAZyLojdHXuNQN6JdJxcGerWvFtTANyJsowsmLWmfO
	0ftXQedHSLPTOrznuUONOlqhhpslw+dZVLu5otLZXNzDwoeC69hClV1+Mr4DvXzYJRgIV62mJmf
	5JAL1gKuL+oB2MoFZTsNNCNGcSYZBe5/Rwk/NqQBi24jEsi2OX+40hjRNr76rAs14f0BFPkvW8T
	VN8kd2JEe+1+BXTo7G3/ourxlCHAOQdhTaFqo8BKctD1ccH5zBUsXspnVjSQk8BIjCU/TqvckZp
	ZQHLoDR38F2mw8yYQ8QBAy1Wkzh5WCY8xZ9qd5QmEeaOWXMWAFaJATUGk4mC4W1I4oyISo+jBeu
	8t2lF/jye4T/zFUpfUHOHevXBdd9bYk10Apw==
X-Received: by 2002:a05:620a:444c:b0:8c8:e139:b08e with SMTP id af79cd13be357-8cd93c0ee82mr536662585a.33.1773191477953;
        Tue, 10 Mar 2026 18:11:17 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2148400sm36451685a.39.2026.03.10.18.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:11:17 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yonghong.song@linux.dev,
	jiayuan.chen@linux.dev,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v5 2/2] selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend
Date: Wed, 11 Mar 2026 01:11:16 +0000
Message-Id: <20260311011116.2108005-3-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311011116.2108005-1-qguanni@gmail.com>
References: <20260311011116.2108005-1-qguanni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that signed 32-bit division and modulo operations
produce correct results when the dividend is INT_MIN (0x80000000).

The bug fixed in the previous commit only affects the BPF interpreter
path. When JIT is enabled (the default on most architectures), the
native CPU division instruction produces the correct result and these
tests pass regardless. With bpf_jit_enable=0, the interpreter is used
and without the previous fix, INT_MIN / 2 incorrectly returns
0x40000000 instead of 0xC0000000 due to abs(S32_MIN) undefined
behavior, causing these tests to fail.

Test cases:
  - SDIV32 INT_MIN / 2 = -1073741824 (imm and reg divisor)
  - SMOD32 INT_MIN % 2 = 0 (positive and negative divisor)

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
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

