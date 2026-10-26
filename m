Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057931;
	b=RB3WR7/jfUF7h78DFlmhOCrfZnQ+bngV+OK0BPN5kRcz5nNda7Rr1jUqRtZy4r0LaTck
	 wcwBTB81fHltglHhx0nA75gFT5awXqIJneFzAU1+HZ/F65wP8d9iousqpUgADj+4WG5CT
	 Gay9xGIMmd6SwjUIQyOZQMF/qwP0++MZiI9J73w+6ctR1CVCXdfeTe7+3hnsRteIZi6ep
	 6sl38tSCIyKNYUwAhvcjImMLjVj8mVX3VcWkWKK3hpmbXF03GKJq9f2/nESyVdN4nteXS
	 iAv7tBF19iXXk6qXMvJn9iUFJiaZRI9X2JzTX47lxcmNCn8OQec8nlKKPfLXSnxinjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MiyoOEDIy6UwCAKNpLsQRRitB38C0qV+MqJRsMVax6g=;
	b=KIl2dBr4HtIQcTgXwdMxflLAtnCf0FzOqcjx3Vc9XpXdThlX+F931GeEiVw0ZU5JlSHs
	 Gy+z/pv3Q475MHG+TmEASj1LqKoO1TZ4TwEoVPhKZSzE/tUL6zlmB4SxzRnFLpx/p8cHA
	 xUD8YdBhEL0B1+BDOZEUYRmsPM6Jyx7QwJp99Fne1vGcH2vbsWtNTJGj9GQL21MKaphA2
	 dP39QmcaIBaMhYtQIHEYSl1dLAz42QzTP6hbbqbhBw2HMYi9rPDT17ftaJODUDhBnW1RP
	 dwUBQlqCRPKH+5k3Kl27W37GkFo6+d9jyVfvrsvtuiB9p7SShO284QrvPGkYJwyStow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jt9vG3gN;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA3606A31D
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 23:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95DA3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jt9vG3gN
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e940d5d2beso13530275ad.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793057930; x=1793662730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MiyoOEDIy6UwCAKNpLsQRRitB38C0qV+MqJRsMVax6g=;
        b=Jt9vG3gNORD5Gr4tKkaKSxLR5kmu5rBKpRKlj77Ub05WDJO6aAtKwzhGDycr+awR/1
         QU3cXOD63USUR1Xl/fsWCiMwJLr2PevazUriWkgbI0Zi7dPKma6swxxtWDPPjUdTDLwn
         gDVhMeSE0XfWlt/rWNv0PvtFFbUPhYVVZffTPukaM/BWIlwfMeHOngwJcHPDrKlJuu69
         1Hkaf+epzSQ5kL0u+qbP5hHqcvkMyYZrcrgTcEl7ggEgkMEv10hpt13w5HDe4V+eAZzb
         udcdUgWVmxdcHyXZEFTN9JJ6HTCADxkh6tibXdvktiVLOmHodB0eZwCVg9h0JN5oxrtw
         l43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793057930; x=1793662730;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MiyoOEDIy6UwCAKNpLsQRRitB38C0qV+MqJRsMVax6g=;
        b=dCFbYbgArOZ9boSFzyrCQ5QHTCBWXNV/o4pFyh5sEIKe7t6LNH1Fq9ZsrSMH5OoOWN
         vry0BzHCF77ZiwTzojUVVjsN7xesacPvQP0IXmDdepifOLLvGvWziPKxGK1pvsAxYEhN
         1Y7jmgOV/e2QuwFDTACkNfTZLBufXHPqTlN8/XEYrL+nVsS8fqAhZYVjzlTOjek/KLeo
         0DS60wDzVr4EXfInHLp+DxO0a0od9FBdrmdJh/Ej3kN7NR9YLLyuAY2zMETRG1x4tRf9
         mjD/QwQyhDgaCnLznUn2VCUy7Vl8ewTN+IsrOpyM9E1VmmE0J5e1OAA0Oql3Ktj+5mz8
         vXxw==
X-Gm-Message-State: AFq9FYKAYxKEl5IfVVKU+eL/NkWY9ZGMtgydIxYObOg6iWgb+ZsrPT6v
	TRVFpVZ9ZZp21NMRpCO0mDagtbvI2NDm3/4UugqNGBBqZke8aDr01t78ZYzFCQ==
X-Gm-Gg: AYBFou0fVAKUxwg2fmkQ4exJ6rOgmTPCAl226Vuuy8NKDo+xGdrW7E4N+i1HPmBIGzR
	zMAmJI8JPp08zZtWCLtdWfUmz+5YwqM/GXEdYNqv/6Xnq1jddkPUis24vYS1S0drMRL/DlgsTqE
	DJN9JBjHA3/jTUZddUDOQphGRfWjzcRkKzuUU4a8U8QOTC/92rs9s3YMSQRuLypPHO4Fms9JEZI
	oOxCSBxF8pBF/F8d8ZiDqnAWlT6PBuiIvOQGrUZZugu/wyvjAfoMytt5RgU5pT1ekm/Lq8LIEXP
	42N2NG7yWl1Q5GF27N3d+Q2bF3m1/a+9xUFyR0XBIoCZq6NVUTX7Wxzgd13cxeuTnWP5lyylyFH
	zc+WX8r7f7TZCL43uVC1EAPGqA13RlTt/ASguLLC0yDOgOxZVA7aZ0IfmWMuj84NruhdmnD8Slg
	++OMgg2o1rQKfsPEIxbxi65Gqeg6ad8CGp0pv1bm94wG8GCxM7Xfhljz1BnYcGLoj9Rh1qMSPcY
	w9hRKuys4PLVoWRGoS1c4sY9dxU2U0HhfjqoFPTLRzaHAOLGhIazX4xagybMO8gz7l5GA/Fbc6S
	lYi5z6/aceqol6luKZMPW6mjTjROgW53OUpvVpv0eeEoXN1n9a+fwvigi6QeLCx2HlXFJ1NN
X-Received: by 2002:a17:90b:5186:b0:3ac:d39d:ee4f with SMTP id 98e67ed59e1d1-3adeb0fbb1emr6127766a91.44.1793057929905;
        Mon, 26 Oct 2026 16:38:49 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40455eb5sm1167437a91.12.2026.10.26.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 16:38:49 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 11/11] selftests/bpf: Restore stack pointer subrange pruning coverage
Date: Mon, 26 Oct 2026 16:38:31 -0700
Message-ID: <20261026-scev-simpler-clamp-v2-11-f373aec9825f@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
References: <20261026-scev-simpler-clamp-v2-0-f373aec9825f@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After the clamping changes, r7 returns to the header with [-72, -16]
instead of the narrower [-64, -16], so the test no longer checks subrange
pruning. Assign an invariant fp-16 pointer to r7 in the loop, giving r7 an
ANY SCEV that is not clamped and restoring strict-subrange coverage.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_stack_ptr.c       | 27 +++++++++++++---------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
index dc176f407c36..e6a9021b197b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_ptr.c
@@ -588,32 +588,37 @@ __naked void stack_check_size_512_with_may_goto(void)
 
 /*
  * Verify that old PTR_TO_STACK state is considered a super-set of
- * new PTR_TO_STACK state when new variable range is a sub-range
- * of the old range, e.g. old [-72, -16] vs new [-64, -16].
+ * new PTR_TO_STACK state when the new offset is within the old range,
+ * e.g. old [-72, -16] vs new {-16}.
  */
 SEC("socket")
 __success
 __log_level(2)
 __flag(BPF_F_TEST_STATE_FREQ)
 /*
- * r7 is widened to [-72, -16] at the loop header (insn 3),
- * the loop body sees [-64, -8] after 'r7 += 8'
+ * r7 is widened to [-72, -16] at the loop header (insn 5),
+ * the loop body sees [-64, -8] after 'r7 += 8'.
  */
-__msg("loop header at 3, widening r7 to -72..-16 step 8")
+__msg("loop header at 5, widening r7 to -72..-16 step 1")
 __msg("R7=fp(smin=smin32=-64,smax=smax32=-8")
-/* back-edge state is clamped to the widened range and pruned at the header */
-__msg("loop header at 3, clamping r7 to -72..-16 step 8")
-__msg("from 5 to 3: safe")
-__msg("processed 9 insns")
+/* 'r7 = r8' sets r7 to fp-16; its ANY SCEV is not clamped. */
+__msg("R7=fp-16 R8=fp-16 loop_stack=5")
+__not_msg("clamping r7")
+/* back-edge state is pruned because {-16} is within [-72, -16]. */
+__msg("from 8 to 5: safe")
+__msg("processed 12 insns")
 __naked void stack_ptr_subrange_in_loop(void)
 {
 	asm volatile ("					\
 	r7 = r10;					\
 	r7 += -72;					\
+	r8 = r10;					\
+	r8 += -16;					\
 	r6 = 0;						\
-	r7 += 8;					\
+1:	r7 += 8;					\
+	r7 = r8;					\
 	r6 += 1;					\
-	if r6 < 8 goto -3;				\
+	if r6 < 8 goto 1b;				\
 	r0 = 0;						\
 	exit;						\
 "	::: __clobber_all);

-- 
2.56.0
