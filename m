Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ED943B4A0
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121150; cv=none; b=YHgKn0MgHikVpymk/VSjgjf1+OW+12VP5r1wZkqb+U5tqjr05FVH+pqqgBlhm7+Of23bSkucCyFiKikHX9HNte64HltCmT/l3hGKaEtPO5sa6mfFI8O5UCt0kqpl2Cb4oNtanochX1IwEe03jEwGvKazsGw5FD3AwBGWgi0CwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121150; c=relaxed/simple;
	bh=ipS6otRBWE4qdqNUG7HBypsQhmPzpiqgxSRofHpaPK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXmCjLLjylSBiDKiGMgM2vIsym2/25703EKhu63lRyuXQNTyQbETwDyk2sYPWjX/4yf+4Ek3ElW110Q6KdezBWWVmntKY0YXN8kJ/zNR7fXAaO/CggFXZISPYYGM5sYpJS7xfuuuqYaCWoPhTOHwTwXcxh3t2XS93qHuXmMyGEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doKZFH/h; arc=none smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doKZFH/h"
Received: by mail-pz2-f36.google.com with SMTP id d2e1a72fcca58-88a9f57bd42so279704b3a.1
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121148; x=1791725948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OLtNlR+Smj3WVPL3U5SZw/LV/RXz8P/JjOqmbl0LWxU=;
        b=doKZFH/h5u0WBqsrUnDYlQRG8aq2xV0kCX2imf+RP3gp72pTQUA3JcM7i8gwL2gnM0
         XtZQljDDClNN9JT08WT6kuVdcm2d1PrqfAu2wJdgvverDz10T/wPyvnaN348WYFgi7aO
         fGbPk1/pv34wG/+OqAWENOg9SDbDt5WzR70r3s1n4lcboEPkfi27kybFF1URZ60yx8LY
         ISdkmIkGb5iLk0JeHtHf4TLAICucvDNKX+3jBcQEoceGPdN6U/3qWvV6d6VlnfoQlcp2
         bWiH1My1ErWJxGsEBh1VYJgBavHFu10kPoPqCORda5q0r3/yF3njSH4oK0G/o6FvNrSA
         EPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121148; x=1791725948;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLtNlR+Smj3WVPL3U5SZw/LV/RXz8P/JjOqmbl0LWxU=;
        b=CZvPaRzhOfrA3sJgFoPCx+uV45E9zxJRjeLbgoUu31+mof2EMnTu+6xLcGRCXyq2xx
         4HQCEYnhPoJw3UH7CPpwvqFAjdSnN6bv3+cH0/bIoLnX0r3liX/gOlFo0NSffoGs78N/
         BDjcEhY5Q0jGk1dDwiq8YkqFI2dBhUIBB+/pKiv4fJNYs3kbBcsUnsRl3eIfFci8n7sX
         1YzlnoUw3Uw20WY1ztNn57yxdaEr1ifEiiIUBspPwKGNUbmpgU0k2IdfI1TuB3qu9r73
         UwtDpIZPvajXPNHGB3T04xY/+GeoQwBqzfB0tn5ELGbJd0ajWvh502sdeh2sRhfRdX08
         Y5Xw==
X-Gm-Message-State: AFuF++nE/TYlEbrzACWhbBzbK+QKTwR93fvtOYball/GIirW6WwBwvG8
	GpYtjilpoYzFgDzPeza36AKVSEskH/ryyHoC18+/Zpy/zCtCEXwMTq67axf2Pg==
X-Gm-Gg: AYBFou38suvdXWXxgYeVZcNhbyHVy+4KyW1u6XqRGmmLPl6f8TvXYQB9rHuxjsJJKDL
	1DO3yC5KrzX4638bP9ezJS8Cs49nsZwVgZtuBXIWYOAJiuLMrAC5lQK5jUsCJi2Kh091M0eU+Oa
	1eUStGxCdE6vrsHmjk0aKVEfKKA7Obq/ozkjafFDvqFsdkMwB6wSqd7X7n9Lbycbt/Q5jcefTmt
	A93n929CFYu3rHhLHgxgbex9Z9wHn/QtdydBpLgELcpregAfDtRZcREjpmoer62JbO30iySd6xo
	lQPuriX5M4hQD2GmraaGIYHCG2ioSD5ySdkys3xJNFFd40cDQ2c7Ww9B0uWYfJH41Ttpsmw6aGv
	nMKskrecZ279QEPlJobj2gT3UQOjvUJCjSOngXEO5IOETRZfOqhh1zKriVYWSjxxMy1DhHS7AVH
	iNh+74f6M5QtZNO2knz/ITdEiTcozxURE1NoDzwCssr8e6Pr2S8SEUN63qPq07pnv60wHiaxeL7
	LAktirWOhRygLi0pCsEEh9ozA==
X-Received: by 2002:a05:6a21:6083:b0:3de:9569:8200 with SMTP id adf61e73a8af0-3e0bc9f2b0fmr8119600637.4.1791121147913;
        Sun, 04 Oct 2026 06:39:07 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:07 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 34/43] selftests/bpf: test for stack-pointer subrange pruning
Date: Sun,  4 Oct 2026 06:38:16 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-34-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Validate changes from:
"bpf: allow subrange relations for PTR_TO_STACK in regsafe()".
Add a test case that checks that a widened stack pointer with range
[-72, -16] is considered a superset of a stack pointer with range
[-64, -16].

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c       | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index 3e0bea9819ca..3e9d8fc606ae 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -586,4 +586,40 @@ __naked void stack_check_size_512_with_may_goto(void)
 }
 #endif
 
+/*
+ * Verify that old PTR_TO_STACK state is considered a super-set of
+ * new PTR_TO_STACK state when new variable range is a sub-range
+ * of the old range, e.g. old [-72, -16] vs new [-64, -16].
+ */
+SEC("socket")
+__success
+__log_level(2)
+__flag(BPF_F_TEST_STATE_FREQ)
+/*
+ * r7 is widened to [-72, -16] at the loop header (insn 3),
+ * the loop body sees [-64, -8] after 'r7 += 8'
+ */
+__msg("loop header at 3, widening r7 to -72..-16 step 8")
+__msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
+/*
+ * back-edge state is clamped to the remaining iterations and pruned
+ * at the header, because [-64, -16] is within the widened [-72, -16]
+ */
+__msg("loop header at 3, clamping r7 to -64..-16 step 8")
+__msg("from 5 to 3: safe")
+__msg("processed 9 insns")
+__naked void stack_ptr_subrange_in_loop(void)
+{
+	asm volatile ("					\
+	r7 = r10;					\
+	r7 += -72;					\
+	r6 = 0;						\
+	r7 += 8;					\
+	r6 += 1;					\
+	if r6 < 8 goto -3;				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
