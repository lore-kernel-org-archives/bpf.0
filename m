Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1827552D2A1
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058844; cv=none; b=uDf9a+/irra9bFVMWucBbiB6dKuHnmyxVBeD2fz5VdjT5BOK0pLk/RhpFm3hsWUrGVp8ztr6KJnhB23tBCoS7/yQ9IMpR9VOi4uLPc12Ldj2gIR/mqQ3BlJVUHBbxjYI8RsGaduiGDTeHaRuaTsk9vbrHIwRgiNPa3JYsfxQDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058844; c=relaxed/simple;
	bh=p6Dv5uXyCx/XL3sMcXWjyxFbQ0++l2v/EGih7Qb9vXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBF4tV/qHeKGof8vvOpG++bLh5mz5jsnrzQUeR0NpFP8ychY91yMEGfq7DE6bElji1JqV8+X9shvMVfpL5YRuEZoXyeDkS0FYOuyEFTP2nQx1luxsJ6JaS3Q4g6fkxxxtQX/Wc4gbIHjszW84qjszpZI5Pj1kGNyWkMlMg9ol34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SHNa2Z4A; arc=none smtp.client-ip=91.218.175.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SHNa2Z4A"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p6Dv5uXyCx/XL3sMcXWjyxFbQ0++l2v/EGih7Qb9vXE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789058834; v=1; x=1789663634;
 b=SHNa2Z4Ahc7T7R5WB9IJUcbSsqkkIPV23aJCty9vCRIomS/KdNKOfeDAYwgs54BQRehZrIAi
 y1s8efc4MMyJQxhbk3tBtkwlfWfiG5a52jvw1PnzbzypWYyujVvu9E5LoDcOAN4FP/wawPOTTDf
 PR/KesLIaHUA/ZP3a8TUPEyI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c2c93a19055d0db4;
	Thu, 10 Sep 2026 16:47:14 +0000
X-Mizu-Trace-ID: c2c93a19055d0db4
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v2 05/13] bpf: keep the range across a sign extension that cannot change it
Date: Thu, 10 Sep 2026 22:16:27 +0530
Message-ID: <20260910164635.459558-6-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910164635.459558-1-vineet.gupta@linux.dev>
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coerce_reg_to_size_sx() decides whether a sign extension is lossless by
comparing the bits above the field in smin and smax:

	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
	if (top_smax_value != top_smin_value)
		goto out;

Equal high bits do imply the truncation is lossless, but the converse does
not hold. Whenever the range straddles zero the high bits necessarily
differ -- smin sign-extends to all ones, smax to all zeroes -- even when
every value in the range fits the field and (sN)v == v throughout. The
second gate, "both of s64_max/s64_min positive or negative", rejects the
same shape again for the same reason.

So a register holding an errno-or-zero value, [-4095, 0], comes out of r0
= (s32)r0 as the full [S32_MIN, S32_MAX] even though the instruction is a
no-op on it. The no_sext test at the call site does not help: it is an
unsigned check, so it only covers non-negative values that fit.

Test the range against the field directly and return early when it fits.
Sign extension is then the identity, so nothing needs updating -- which
also preserves var_off, where the existing path would have replaced known
bits with a coarse tnum_range().

This only tightens: the early return fires exactly where the value is
provably unchanged, and the cases the current tests do accept still take
the same path and produce the same bounds.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
v2: new. coerce_reg_to_size_sx() is fixed rather than special-cased,
which is what was asked on RFC 5/6; it removes the RFC's
call-then-overwrite at the mov site.

 kernel/bpf/verifier.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 58e788f53ae5..eb093194e2a3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5754,6 +5754,7 @@ static void set_sext64_default_val(struct bpf_reg_state *reg, int size)
 static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
 	s64 init_s64_max, init_s64_min, s64_max, s64_min, u64_cval;
+	s64 field_smin, field_smax;
 	u64 top_smax_value, top_smin_value;
 	u64 num_bits = size * 8;
 
@@ -5773,6 +5774,27 @@ static void coerce_reg_to_size_sx(struct bpf_reg_state *reg, int size)
 		return;
 	}
 
+	if (size == 1) {
+		field_smin = S8_MIN;
+		field_smax = S8_MAX;
+	} else if (size == 2) {
+		field_smin = S16_MIN;
+		field_smax = S16_MAX;
+	} else {
+		/* size == 4 */
+		field_smin = S32_MIN;
+		field_smax = S32_MAX;
+	}
+
+	/*
+	 * The range already fits the field, so (sN)v == v for every value the
+	 * register can hold and the sign extension changes nothing. The tests
+	 * below cannot reach this case once smin is negative: a negative smin
+	 * and a non-negative smax never share their high bits.
+	 */
+	if (reg_smin(reg) >= field_smin && reg_smax(reg) <= field_smax)
+		return;
+
 	top_smax_value = ((u64)reg_smax(reg) >> num_bits) << num_bits;
 	top_smin_value = ((u64)reg_smin(reg) >> num_bits) << num_bits;
 
-- 
2.53.0-Meta

