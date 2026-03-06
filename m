Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA13739890F
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772824141; cv=none; b=ETWQB4ukHBtjCwCFSFZFRU+cmbbFu8FcpGnO8lIPGpAsvyIHw6RZFygG1TaxTClpdkTeCwBTLQ00h858L8TDR9qMmv+ucFFJpJwfsyRTke5SqaSVP6SX+zSK104gXmNtljpmeSU2A29SvkEolMa11FKgK4qMftHMVrlYRLTEaN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772824141; c=relaxed/simple;
	bh=0r9AhianaHhBaRi6Goikk6bbXXR/eOi6ITCxSqIKQTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pLFuz8QhzUY+LrqUprVVX/PYbVauk9zM2XopTlv6fQaSXuzGyyDIcnguzGNZhAf1EbR5/KthYJbaO+VdHb2x2xbC/3pkFIFI0M+kD+JsALH6Bgx2srDar9xw5Tr2eOTquipU9nt93CC1RMO7ajUd7bKym3oNr+olV0Qy7QSx89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrPX9Dvj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrPX9Dvj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89a1347051aso72200346d6.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772824139; x=1773428939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kraYytm7IB1Y9w4YBbwtt0Dp0Y2H+qeL6VwnbTaeLN4=;
        b=nrPX9DvjVS4ZUEXA4Jqfiv8NDJofOu6tzSIIwaX8Ybo0MhqJuPQ/1SxCX4fnYYJuOB
         ViLLWSkyz3fiihpWg1994Pk8zWI7qRjnyU1brWPgIdZjSICNW3zujG/kc4ZeO5qClp4O
         VKPed6LlnTXzWvKgXcYY5bDc7iMAFz6Ke/8WCnHrQMRxY4as4DES9DhlCtAdIegm5VqG
         0AyzzPevMEUtKnQNQoNGYgoO5vjaL8AAUd2UnhPbog3glxr23TEF1uY0iT82SWlTtx1v
         5sbsb/nspAT5JBbosb8FRk0f45Aq8hIhFDVOOe23Vrbv4ijdIHPCSoHESCx6bSK0j8YI
         5ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824139; x=1773428939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kraYytm7IB1Y9w4YBbwtt0Dp0Y2H+qeL6VwnbTaeLN4=;
        b=inCYFM/IMBCmrcLoTJFqwG9NYUc2IF+5eq4qwLoIBKzg8XlpC4RvpPFpKJuHYTn+KV
         /4Ds16c2E6WKJpbSjJaD/+dMTJ3rw2xNr0LDrCd3TIEWRPMURhLR8dUpm8suCTkPqhPe
         SJP9iti9jfhf7cshNJu4mP3/CX7nIN1nCoXtIj6aLsQEqi/xAjS2XJs4dsAuL5KI6Su1
         FYvBnvGjIql4fMmynFh8T/8Pf/QjbHTyc56uU+VVOF7TPPXX+fT7TScB3yO76sDR2D06
         SzFLkh/H2yjboyI/RkfId+qrYn3Cc0pBDXXiMOdJkZdlWvM6qcTpA7MXmlhA7c48pxWx
         3hYQ==
X-Gm-Message-State: AOJu0Yx9gfbzy07fKCc/v1CIQ57ISDkkcHvyO8QvjfeDdDjddJQZjs8x
	i5qv5wMNN+0b0JfOkFX2mu02d+BL6ivIVg2tAkuJplD3rZHEjQxubZhFfDbn0WO8
X-Gm-Gg: ATEYQzwZ9rr0UWJ2/BXKIYBsqsi/XD65XBV4Z57w8RxY50rD54JkMBcd5Il4UUMq7CB
	sq2x3PgUg+cwrUGAENGrRBOqP5wnfkeSXrK7cKBckiNKUR2NovAUQQejvrRXt7ad4Y+HzpJPi5U
	Re4z3HRGkZWNzXOppRBKxSdAs3Nz159BYxUvfoNof5hHBjTAPPekndXxAA2kH+z8Z9BVHZ/rEKF
	U2paBjHzn1eoTjLyaUYSswczUMlODc5xRNiUJvfLXN+3PMlywSIhZJDQaSwv9OpRasToA4i+kQE
	fnASqUGbxHEsq4g8DCa5Zq4LdI/iQ7En2IB6aKULY72lsvav9ZSio0lMUCJVe+UKehXZyAJieP9
	5fAKJ8mlDD2rN2ZPWQj85arG21d0HNFLCUmyfZoBNOPjC5oCBnREr8lOa55CkX8SMU2YRYHJcEf
	bnyfLDDgG52WYKfzME2r3Jr061ZNqiUv63oINxvAfjk2+Z
X-Received: by 2002:a05:6214:1d2b:b0:899:f0b1:732a with SMTP id 6a1803df08f44-89a30ad6ab4mr48120136d6.31.1772824138928;
        Fri, 06 Mar 2026 11:08:58 -0800 (PST)
Received: from 192-222-50-213.tail19a0b.ts.net ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a317187c0sm20322976d6.50.2026.03.06.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 11:08:58 -0800 (PST)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v2 2/2] selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend
Date: Fri,  6 Mar 2026 19:08:55 +0000
Message-Id: <20260306190855.937198-3-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306190855.937198-1-qguanni@gmail.com>
References: <20260306190855.937198-1-qguanni@gmail.com>
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

