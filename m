Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C22D592F
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082640; cv=none; b=oWIOAJ30FH9WQn1xhv171ZgADKINKk4nsbTh04QRL8sk5KmXc575jgcCuO8QVbOYWWR2x87hcN9+vJUvNGyyeusyTHobCyM8Do5vD2dzo9F0a5yJgCX+Gnm0u2vmGO7t0ZX03RofgDAOi6SjJJjA9xvu51Jv/hsoQWU91RzDyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082640; c=relaxed/simple;
	bh=0r9AhianaHhBaRi6Goikk6bbXXR/eOi6ITCxSqIKQTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4b0mKFbKMTuTyf9tJFxy0NJVn2dYhqQr16MZac+1kx1mb+WYGf0AwPU543/+rU9WXP9t1+6ketN3JjWm+47E+kYInu8vJNoDGW0bV77AW3GOYk8MbZLinpIg9Xdey+LQw7mb0Z00mYhrxyS9sDRZdyqxz5a1wdZiVyvCwxdj3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSRy147y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSRy147y"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c70b5594f4so1220053585a.1
        for <bpf@vger.kernel.org>; Mon, 09 Mar 2026 11:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082638; x=1773687438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kraYytm7IB1Y9w4YBbwtt0Dp0Y2H+qeL6VwnbTaeLN4=;
        b=OSRy147yhjZZJr6S13zPNKQlgbOot3DJKq64F/tCuCpUdGSjlO4MPDgeUj2fjiVgIv
         lkYmtjazjRRTrQjM0ejE3+9zGZsdCHucrjzHLRYAucTJ9zLGKMsYNYy43k16xoe2ZC75
         98eWqTvzZGlVB2C8STCrl0KqLcerI0vYwwo/Ly5Vx0nTbkwufunE7R/MJrDDXCgBqgtm
         DuLXHmHtWFBGGTfrx4OcF20AQDpgomk3/FU/Tj2R2mbdN8PH2UBgBJzQ7Q0M6YGyZxzs
         5yLYctLJED8sXJC97h8o/eZEkjPbOAOi44xFNumuIxicfVc0kGepNqEcPv7UH0luwnUv
         TDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082638; x=1773687438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kraYytm7IB1Y9w4YBbwtt0Dp0Y2H+qeL6VwnbTaeLN4=;
        b=pT/ONZmIvJMXYJCkF+DPJsnHDUmCqsu/D3mXSdFOnpIbyC/7gGjF+qGIwQ33pA5UgU
         b77MUHzSuKO0CjAuTuZN2rLMlUnQsGD3eXrkRckEYRW6Bbof+lBrwNHxISn9EVzt3sZZ
         996F5onJvNhRZFsHG9HrrMIH0c5hodT/I+mBZEkIac40vg8csL7KYcWknOM65T1mV/sp
         VH7nCcQY/OpCJ7qyy2Yx3deFIGQ9ULzExaUxOdTwBHcl08t/A63mRi+H0gQzst39ReQq
         qt4tIw3mfNuU3+aefh1/dsTQ3tD0vyjuRowCcrXssrazYyDwjWoRVoFtNqf/rao6eQWg
         sfLA==
X-Gm-Message-State: AOJu0YwOYlUz6OFXCEQN92mWU+ypqImb8JOXaZxoqYiUKePhKoz6iSsl
	/a4EBPwJvAY21NtAe3fnj4Sebuajt68SBsJQBA7+4wEYDx6KJBTzuMh4i4vWLUvf
X-Gm-Gg: ATEYQzxS+GE0lIQbsfbTSf1MEVfn9kOEGpL8JKGQiWsk0pNgdBE5/R9KvIFYf/L+6Ay
	xJysBmm2Emda61hb8YFt9j0TvvJuGxHBODyqr5KbvosOzLnjPkCvDueLmLngWuelc3qezcma+CV
	DVYmwh6XQQ/xaOKY2y9tbmP/60ToEc3Oqf+ocRvQO6ruG+YJSy7vvGVrm/l5jR07Z4Ne6E53bcO
	uo0VQEbmnwijENaTfA9TTS4nnbpWA4CuJ8KZAmzkQWBQ/g/MiaemGnwPMYFMxLMowsehWsa+7lP
	UZP85dP+n0/u4zZOfyiJV76EmqokO8tO0kb+Uc8rzWVCQWGh/vyDv7UdUeeOXKKR2PGXgDMwU/f
	Cz0Yv7T4E2XBNKwMoOsL6z2FTQh219qnUK6HhzeyXTlqUMk6zGh7uIYhXUBOWIcoWj3UxFazqSL
	OpemsdYcP4gMjvNUzytwg5mUURXYSoSLJCPA==
X-Received: by 2002:a05:620a:470a:b0:8c7:109d:e9b3 with SMTP id af79cd13be357-8cd93bffbedmr82929085a.37.1773082638383;
        Mon, 09 Mar 2026 11:57:18 -0700 (PDT)
Received: from 192-222-50-213.ll.local ([192.222.50.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd90aae2c0sm117876185a.27.2026.03.09.11.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 11:57:18 -0700 (PDT)
From: Jenny Guanni Qu <qguanni@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	mykyta.yatsenko5@gmail.com,
	lkp@intel.com,
	Jenny Guanni Qu <qguanni@gmail.com>
Subject: [PATCH v3 2/2] selftests/bpf: Add tests for sdiv32/smod32 with INT_MIN dividend
Date: Mon,  9 Mar 2026 18:57:16 +0000
Message-Id: <20260309185716.717894-3-qguanni@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309185716.717894-1-qguanni@gmail.com>
References: <20260309185716.717894-1-qguanni@gmail.com>
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

