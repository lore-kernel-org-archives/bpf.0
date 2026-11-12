Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498857;
	b=Qn6IfTP4O+byNT8amJs/+sN3L1evAjszfw452Nct5EhGoyn0PBYZND6P9LVHUgwUy5tj
	 3B2RyWPbmX1160agHEOncwy+YzlcwnRNV0wPysY9uUBucQvOnCosvKZGHu+JrTXQAU98y
	 BdDkayq6hKFix/s7ZjVrMBF8NZ6ZKA8mOSwXaAGm22deHRAK0IADpMR3ODYb1cEEGA3r2
	 fTwcealLT1iw36zKSuymwGkknwLxcImKTnGEDSGR7FaW0SOV5rMlC8s3mPIK3cHCzQ2If
	 PDRwMhOQ6LkV5Wz2HwUD7VmFjm06TXCFXUuXqMBxnqI/5m+IdnWs9yDgD6eL2kE+gSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+U8DmuT0uXrDU0a8DlNb1HzjgaXxLrgyI0JSrF2/wsg=;
	b=ItXAarRmyeV+z3mYwYpA4PM24ImygkSnGdiJjRba3j7oDDTzBw9wHQ+v9vVOhuvDuFed
	 p98uZLATPic/hBCB6A2UbTO/q1EdiIZb189WmgXJgRSSoy8K4jxXXIyVenbVWhNREhIBr
	 1APQ3D16pjQauFsSRwqcSQU3WVZdwcl6OuVdBF1/wi0jqSyW+uJvX9GXobXRscQbNXKL+
	 2AUiF/u1Vg16Jg0lncTN0XCg7gdKq1Q7ZHa2KqBVqXsqUi3n1UEmm8ANgR7Q3vucX2lDh
	 URT4oOlHVrbQpJ2OceCJIuax69vLnBEP0txb1JUGnn+1kLxR7d2VCYypt9cpaswanDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0x4Je2e;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC1606A31C
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 15:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60BC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S0x4Je2e
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so895552b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 07:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498856; x=1795103656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+U8DmuT0uXrDU0a8DlNb1HzjgaXxLrgyI0JSrF2/wsg=;
        b=S0x4Je2enLHesBY175oQkjmuhRMXih4vc8lbrhUhXFiuaTcJ+dEa4OK1AKfWdUhgv6
         F7Q3k7QA0Mu92By+ptSEAR7+0jvIRyi2n2rL8XyCCMvEXTlpydzsvegLAAet9sn39jtJ
         7kJpB2ehBBboTA4I6UxF6seysTsSbFV61xV65iwHM0RV7Oco0wwycbdNyJ1SmdFHZkT9
         g09zqGkscrLdfurdwHb+Has+pH0SLr2Sn2Z4+TuaZ/thfnlXAfP+oDRaZkmuV7FEuFPr
         D8kRUbMe1rNdbG31z8KObeDvg4ym/JQOmh4OYPvL3iKO9PmDu4fxGcMDy0iWcodvLEkE
         zQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498856; x=1795103656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+U8DmuT0uXrDU0a8DlNb1HzjgaXxLrgyI0JSrF2/wsg=;
        b=Si5KM19zPwiKu7Ldxbab1//9oCDhWLKjuPJXjE7FvoMTuiMfDYy19JJ+9zLzCGfRAW
         n5l6nsM2RGq8J9Aub+e+1FQGYyCY9funFZ32IluzjOyaHHYqN393NsYIL4T8K59giTeG
         Ov5OjY1YCwnqhGIwSiUm4/a7m7HfF0RN+dZd2q4+FZWBKOis5ZcKi4SGitnhSLWMuT7d
         P/9jZasnGEGIZ8zLYYzH/3Zlgk+mTa6s7Z0cM4LVGHvUhwOkgRgbPwCdinPELmvq5nVp
         05LzxD1D0oegLHeaW097sdWES1WMq2Jwr3jJyB8NwIcFv7tnDglBQmLF1cqN9G/+OHF7
         mmCg==
X-Gm-Message-State: APuU4Z8go0yKWXXrnUIXI0Su7/8daaBpGmEh3oER2dhohdNq/9am8ab5
	NPL30CfTrmZLT8FASgFc+NbBskFHNCFeJ2IhK84ILi2dAVN0v8yPGM5vO3C6Mg==
X-Gm-Gg: AYBFou0eK30BaTjmxA+bwTHvnJXS8MdE6Dx4QF6ME8geUc70MwyVRklI497C8C7n4sb
	K90VzDv+yeAAL2DjHFyg79lk3T+WcmEI5tfWpbolxzacBF/BXbBNvom1xtnWZQ7e3E5Alo8uvFn
	Gzsu8oRhPl3Mhlf/qVjMBG7SGhK/Ci9BDjoh1HXkvm5Q0MU3ooxVZqboReuL12JNI2qWha927Y5
	/w8zJEXkVpwNIK5tenx5hO8VHTJPiybb8QWSoramrZnuJ/pCrWejF+Ga0E08+X1E0eJs9c6zOzO
	bF6vLwOEJfW6tLEJKJpD7bEHa4+TNqYVWGx5keX5VsZFnGBsH590DJhH65O3LBkSzHkBywyhbaZ
	vbpK5IQiH1acwzQgi9pIKLApIBUer36ZXdFN0BPu9JcBPAqOTikbVGU9QaGspBXzX6jDyxjIqiZ
	CG86BHOMiQOka7vC+totOTVfrfJzknVQIaMqCArTNA8xVnU7vWWoFhQ84vYp36wMM9cYZhfhB8O
	1JZm8NAmChKVYH8V/rRkfTiDtpaMefceoTlGFB2WWRqj9FRfmEfujm1t+wkX9fSAbib2js5oAME
	6FXN9xU4NsJQtGZD/I1YAjpJ93to7KIofxFfUiH6D33sHhqlj3Cw/oCKk8j+BDL56VDAAb97ab2
	rtUoerWdak1wUoFGLDOWOn49KQMIM+DvNLKUSLaXoLPs4vpE+ry9RvycfL2mQl+ATZUxCCGEYMM
	an0MWSTPxos95f8jb8qdF4
X-Received: by 2002:a05:6a21:a96:b0:3ed:b2b6:9bdc with SMTP id adf61e73a8af0-3f2fe7d20a4mr6269157637.54.1794498856305;
        Thu, 12 Nov 2026 07:54:16 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d7b37casm3152460a12.22.2026.11.12.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:54:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 06/12] selftests/bpf: Test a jump that compares two pointers
Date: Thu, 12 Nov 2026 15:53:31 +0000
Message-ID: <20261112155337.1040699-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
References: <20261112155337.1040699-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

is_branch_taken() decides 'ptr == 0' and 'ptr != 0' for a pointer that
can't be NULL. It finds the constant with is_reg_const(), which tests
the type of the register. Without that test the offset of a second
pointer, the constant 0, is taken for its value: 'if r6 != r0' on two
map values is always taken, and the code after the jump is not
verified.

is_reg_const() is scalar_is_const() and the test of the type now.
test_progs -t verifier and test_verifier don't notice if
is_branch_taken() calls the one where the other belongs. Add such
a jump.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/progs/verifier_jeq_infer_not_null.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
index 3c789c565b18..8acebb22f0d8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
+++ b/tools/testing/selftests/bpf/progs/verifier_jeq_infer_not_null.c
@@ -273,6 +273,39 @@ __naked void jne_reg_reg_null_check(void)
         : __clobber_all);
 }
 
+/*
+ * The offset of a pointer is the constant 0. That is not the value of the register: a jump that
+ * compares two pointers goes both ways.
+ */
+SEC("tc")
+__failure __msg("R1 invalid mem access 'scalar'")
+__naked void jne_of_two_map_values_goes_both_ways(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_hash] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r6 = r0;					\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[map_hash] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	if r6 != r0 goto l0_%=;				\
+	r1 = 0;						\
+	r0 = *(u64 *)(r1 + 0);				\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash)
+	: __clobber_all);
+}
+
 /*
  * A comparison between PTR_TO_MEM | MEM_RDONLY | PTR_UNTRUSTED and
  * PTR_TO_MAP_VALUE_OR_NULL should not infer that map pointer is not null.
-- 
2.55.0

