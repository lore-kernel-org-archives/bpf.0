Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D893136D50D
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093554; cv=none; b=mdbxalTPbIAFqvIPNU8A/uSrA0FDbkjBISuDP+Dydop8Izsf2JNjp5AxuTq6JXkRKpKLpONcH+WdadRr5HSIfjJ5h7DVzZf+LIlobTzmwiZPrBDfZ6zetaXWdAvBtxZLTzK8OGlBx5gGkfGxGOX/UziL5mj/vO8AW/19DbJ1bu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093554; c=relaxed/simple;
	bh=904tRJigNTY9z7Ja1ow8Ptra0Ey4/uPHVE88X+oc0+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3sG9eM39e9z+mm0RZY5fiAxhXmRnq8fPb9Q5mbr/wXef9IG7D9kPziZCRyyS8YW4r1+oK9R8j0HJKS+X21BtXULloV/LpiBgpVDM5PbRfG6koXI3MEiptxZUHksVfZCUiknR/5DP6HxfltB8XMMyWUDKSqwgWyI/BiNJQSSL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chkLFrti; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chkLFrti"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd80f56b27so201773785a.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 14:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093552; x=1773698352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyMOmW6MOcG0GDsei76waXPmZLjMAteNNQhRjIZNAHA=;
        b=chkLFrtinfDbQLw/Zfm2Q54VDGLcsRAqTLOPZrN+BYffewXLaUrYMOf/Q0b0sGQONP
         O6EvScrEmJmKnRy4BQdSGQ0lhZVTeBCuY207f46zAULOzD9Gvkht8y2ayrQM9s3Y2lXY
         vBcRPpyCwAvgVT3aBbUOMvtkmOJqvctSkEAOncXKbMrAydNdmL0oniJcXmMacmlO+bJZ
         TUTxWNOpbW0YOCRyEIGDO2xA4BIjIIGh2iGruXOWEI8iRcwvpetzf4WZNZPlinA/kk9y
         DHrW+JL4/RTv75kyQGiEd4CvDLM1SLFRN4UX8iHF8Xl8dzzkop/lK3nHxxLqgpA0gXC8
         kgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093552; x=1773698352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyMOmW6MOcG0GDsei76waXPmZLjMAteNNQhRjIZNAHA=;
        b=OG9HdHXlxUdbbhwvTsgnStSPLM+p2NYjbqg6GHBbS2bZ1XKxnN1Sy5q21tPcaqeRzQ
         y3dC8+sQ6Dha6c7G6zgkMPCMIVYKlj2Xh7ijIFfJFAitYz2xNaPQWPGX6HBY4w08xwd6
         lI15HmRj/IJfmx8F9ktaDzPJkIUrJtyNIJ5IdL0gOmSeNI7ZjOqcCjQ/OolFuv/H8koh
         7jEGPcZdU8RUINkkx22arJ4+JMtxJEHQq/LfqUar9EVqxze4GUhAmVXpYf7w9lq4Vuuu
         3OibXCfqXZeDLy5UK24ftstlxt6iPeRce/dzsW3C9gh116ifZ0l3TarwAA6DXRYsy7fD
         hZnA==
X-Gm-Message-State: AOJu0Yx2ECay5pUWorE1ljmV307HIzzOdrX8v1BsVCDx/kncAWXKHH1m
	PH+6ewgeQvTCeE/KRiDHJM6+p5e/9px+p4Co84C4lQxp+Iiyejgl8PUPg0raggVH
X-Gm-Gg: ATEYQzyjX6ltphxXXGMPlGZr+lN/3v5ChEeca5Jj//tAKpnN2sLHdSTB05gS7Mccn2S
	+6CakoI+lyp+/8B2SeTqV1DA5nj7rMc1LkY5CXMyMqykOTEOQrB1Gbofr74WBnCaHTG+gubvaH/
	VPm4Dv53JyXoLKI5rryypxR5SOJoKyL4HUoXT7mmSWKDK7U1ogAQjv32eiLw4rIDI4nchV3YFL4
	7MZ8ad4jxeLJxr7D2JKg/5w3wSyCDZwPrhYnMunRdTo7moKxBE+2BhpdK0n2hKoguZRbIl5Rynd
	Ci2GcfSj09pQawXV8RQmZ7xDM7oFmP0Id4rbKXR6d/KemBP79im62DnJmrgkaiCfWVbnbqTLDeU
	E9M363S/LGiZE2by3wnaUi+KoOpTpwx6X84twRHNoOCy3+h5LfOpbMW88laZ/iU707mfOABuCCL
	kjk0Yo6RZ+bNPCBIwmSq8j5AUVz31blG0CaNDk+/6dIOpx
X-Received: by 2002:a05:6214:401d:b0:89a:59c:34c0 with SMTP id 6a1803df08f44-89a30a2b9eemr202711866d6.10.1773093551865;
        Mon, 09 Mar 2026 14:59:11 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c34a59sm6134856d6.45.2026.03.09.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:59:11 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	yonghong.song@linux.dev,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v4 2/2] selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend
Date: Mon,  9 Mar 2026 21:59:10 +0000
Message-Id: <20260309215910.4131143-3-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309215910.4131143-1-qguanni@gmail.com>
References: <20260309215910.4131143-1-qguanni@gmail.com>
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

