Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69242989B5
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772844889; cv=none; b=Z5f4n/j0JUcegQhSux5TEu7Tj/b4YmvkD4GZYNe0Z0TCRH7trJyNn07MlBsDgXyOqlW5YCLC6XD+tLBOuAlqTnsCJahgvWcWvgJ7ViDppSgLeDIfH9R68XxoYTHGrPSiUK20jrfzVS63wHzhuz0pouvWUJ854dsRkK88oXA65Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772844889; c=relaxed/simple;
	bh=MNSiX7klnWwm6WN8k+bJVpVHtSwJ26dg94+oG6NLLn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCH4zeVaepXRApSfNIKQ5BP/J/vWktvEH4eb/K3riOktm0vN5w4RDq0tWuW7DB2bSYnKLlVyMe9wZdol3KEWIADcqwnkVNpA/kRAGrmZEiswBSNNgsDbzYmvluldy/Lw+uSIODENHt8QQT5odCAp71zJq2jLHpuvAlz5C5UCpwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chRa2+JP; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chRa2+JP"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b4520f6b32so11235945eec.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 16:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772844886; x=1773449686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+V9KBfTlp76EAIzbVbjLXzcwasGPdH85it56rXW30o=;
        b=chRa2+JPIFaWDN2U5kDzu+1j6gzZA0GC6fAOtrtdlAyLeAGNexnJoy9zfdiq4A1nYC
         g3dUaRmbCA4bAX7JfavZvCIq16YL7wwuQXo/RWkhbF4Af9PQ0nQqOSY8Tzrl4eQWKAuZ
         G0u9DS/waUjikDnYxcbrLQC/np8CUghYf+YeZNRwvLurM4+OrdDrBt1TPk+hGfkP0bJW
         EOoz92MBNl90ax44BewMl5q8QTpWyz9JpSUdUMZ591gw656oKyP4TXbMhe6iJUbpF/Bj
         BMwjbRfpu9JKHo8EFRIJDYHb3q72Y/XKAvq8d1FWs9wkfiT4bN09LTLAIypHLbdFWgWv
         oQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772844886; x=1773449686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+V9KBfTlp76EAIzbVbjLXzcwasGPdH85it56rXW30o=;
        b=JHk3iRZ5stGcVpFXTjEsU4GN/INaW/8ZBudlyka0/PXzP/s/WbhGABF0+7CgmxKrce
         0+O7yS90nVa5+0Lek8OylMt+0gOlkOB1nREjXNUkLrS30hMB4c6cbkqQrIlPlMLKRzSv
         ZZwofLwwrQM1MI6TlIavovc8bvANj7PlwzE160fk0ag2siOEPjX+6MpVECVTE0qirAiX
         2oH8gxqGFAwwZUoO9vYem4cD466mYKpF439UtotZ80iWHlIJWXOHdRQFy7KhL9BUVC8Y
         JluzQIXWiwLbehl6w5HeHv63xcoafoywGphTRMJ39s01Jrde5/vINpZCOCHBCjf5oS4L
         LmAQ==
X-Gm-Message-State: AOJu0YyX5FhUB6KDA92yskFs1FbCDcPObSDR77pchKU/rAz4TYPWbui2
	4BH0OjvkwnckeOIf1FqPyMT9ju2yQwIEWMq2EuB0Jk18ONcLyUqjYI3Gq2cHFZtn
X-Gm-Gg: ATEYQzzahYKub+UKWOeVSdjqb55zrSPzex0fzdTBW5svbE6jOW2f0mTHAut98aYenHm
	OP6JeCXsXaDyIOTBxYcuba2kxfgZL+zAlxhr/+o4Vs/qb7CWAaPDfGbJeMxy5JRxRDZmR6E13/M
	YsEfLGPUki043DNf2XtpUZfgjmpj12ciyr0n0HCRk7esGyHj3Y6KRrisEHr4/Cwqv1XMFC/4irI
	4HuSwcnQorDWyrLhX00yQbGOWFOsJbGfb10porz9/RJX1yzPzGgyKnfzz36sF74mxqI2Up7P6dH
	8IA0HxB3y9ffzJ92z+56LiaNZpvRlaL/J11+u2i1wJ2ox1GLFzd3qSKU2J5oL90v0w1kMBfTJI7
	6K3ImMs3ZpHfcZrNiY6i/ZetJV/oufw+0O5J28RxdJMMUoTRo1iXg5s1nPZ/YzfngkQwc3BklNP
	FIDN33V0VclAHQQFTTnNkf1+4b8DU2ZG9OUt2viyBMQCYMG1b34Eu7na2S7U7DP5NuXDhe4yfuW
	tL8Q/I=
X-Received: by 2002:a05:7301:608a:b0:2b0:52cc:fe69 with SMTP id 5a478bee46e88-2be4de8d810mr1584504eec.5.1772844886443;
        Fri, 06 Mar 2026 16:54:46 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::2:f62d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948390sm2235110eec.22.2026.03.06.16.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 16:54:46 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	paul.chaignon@gmail.com,
	emil@etsalapatis.com
Subject: [PATCH bpf v3 2/3] selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary
Date: Fri,  6 Mar 2026 16:54:25 -0800
Message-ID: <20260306-bpf-32-bit-range-overflow-v3-2-f7f67e060a6b@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
References: <20260306-bpf-32-bit-range-overflow-v3-0-f7f67e060a6b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Two test cases for signed/unsigned 32-bit bounds refinement
when s32 range crosses the sign boundary:
- s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
  s32 range tail before sign boundary overlaps with u32 range.
- s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
  s32 range head after the sign boundary overlaps with u32 range.

This covers both branches added in the __reg32_deduce_bounds().

Also, crossing_32_bit_signed_boundary_2() no longer triggers invariant
violations.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 39 +++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 97065a26cf70603c3e4b8d43d3a04248828398fc..e526315c718ad7e7905d95cc9b52b229cb12af39 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1148,7 +1148,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -2000,4 +2000,41 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case1(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
+	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
+	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
+	r10 = 0;			/* thus predicting the jump. */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case2(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3] */	\
+	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
+	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
+	if w0 <= 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
+	r10 = 0;			/* thus predicting the jump */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
