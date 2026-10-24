Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792800254;
	b=WPvz09jErRWPCey2jANlYqSbOuHLPKwL8iQuizQ2RJTRn8kIqkx5yckCggOcjKSAhjji
	 AcWk8Yl5Orpfq9rdR6nSFY/JbwU1xgMsLNP3faeh5uOnKOdo176QuJkzTi0qsdDKisjNu
	 XK+bStAQHvaosVzZPpqINga+u/ykbadeDzBDzUH9jYvZjJjcr5ZFAnTwbhDYouVrBmQp9
	 If22Cto6Sw+U3AdvMIiWF7Cpo41Z4RBXR35ynJ1YT84zn7HirCTAqnfKC6rH2414KtHNC
	 WrCoRgH1thueL7AlXBhPi9SSS/w4vqfEfoZeZfV2aUU2HaP6lKAUoZjFSszleJMwtHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792800254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=YudAej2MuPZV6ICeoDOZo5uY1hTI83OyHbBd+TN5H5Y=;
	b=1Yq5UUuGEvOHs/rbYwljmk2CJHuXR1Y3bgltQZq4LDRIk8M/N0fKtWszKfmbdtFiqgNz
	 6UJCGg6lbtZmmE4yJyJ+0hR3QuL2RkOHQ+hrwFFvm9Zm6hxgmvoHkjOBDTEnTOfNAoedF
	 0UCfB0rDCtiYiaYi+446Z7b3D2sav7IS9su7mRf0SJjorvgsEt8QB90cDA9hIllPbgEet
	 bjQlx9mfmum1D+9eq/QhneDwiBp83nPtqCfE3m9BvuprfJrGyOsJkwoofppS8lxhTSuNI
	 aQ3klbZDUYW5SW2dz7ai87BRUfZcScFgERhhAe2Sm52i+glI7pIR4qFQU7C0kbfJugQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUP7WoEC;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B6606A31B
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6B6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VUP7WoEC
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e95bd1c14cso11758565ad.2
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792800253; x=1793405053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YudAej2MuPZV6ICeoDOZo5uY1hTI83OyHbBd+TN5H5Y=;
        b=VUP7WoEC7N9wNJzTRHKAQO5mEvaQhtY00g1DX896iAVLH52ncOVEpR+X9XAOht3JiE
         hpaA6PrySyHRQ5S99NLawLwxdL7lh4Euc2YxAwHmb0OqJ+LNYE2yvzy5PLAvB6Op6SBk
         sjg4h8B0KqXw40cR30H4a+6S+NzxOaoOo1TA51QHK6Ks5MHLvL+Sg9Dmj9y4dmxpvMNN
         wBb57QDyJSoMPpzbJ0tce3r8r7ipJXUsUv5gsFNEZaakcwCRY/WW6MXX3fK8Pt/VYbTm
         NrBe3zG+GE5bSI4c5vCoLp6Qq6gDn/jDaPwXqUsvwX+uKuPiLfxilmTgeXnahjHQYKL2
         7b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792800253; x=1793405053;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YudAej2MuPZV6ICeoDOZo5uY1hTI83OyHbBd+TN5H5Y=;
        b=U9jOsGNcECNM/QZrS0Ks1hW1GllBwoSPUts54M/7oPnLWNYTLnpPjRtSzkIIfZ4CPz
         EDoNa+/hjiw9uMyOFAnJ4EJqz3CNn43fLyeuqtEpiyApCuvSl7Ie823vcCeimMl+tv4s
         BSl+lOoM0UKlkFD4tC5BblRA17wD5l0YkWGoztXe23+rZYz/wzge6IM8tZYduR1djlg6
         ohGkjdLnLLlC4M2ZFh4N1aL7jivMvopjEQSp0+F1NqWtgYWuN//eZ28PngpugyhbVwbJ
         Y0hrBc3URIud09DfPLmoWdfbLJpazp22PRXcdJtKIClH4tX3/0EB5mlMACZVWKs04b1Y
         xbTg==
X-Gm-Message-State: AFq9FYLqeUcp8exKg5POeg4KYxqnL3Vz6JqHrbYNHnm+Pn8byFQTOMMb
	FBlHiA8wmQrHy2UzFSyBs5DmGY+zTwi6/w5Ou1b6XDmWeB62uG6eELLLb5jXHQ==
X-Gm-Gg: AYBFou2KFrmSCzr2+JPiQ6NVpblGZfXk6OqN8BO4TM1bUNQlcKjekKLlHghJ+TEg7oY
	13FflUsbYwUZZfQdvqvA6ZgeIXy6rNpm+iOtDZ57ovgQTzQ5OronKJHbiiHqARHprVF3dtGpIor
	XX1N0WvcIl6fXQ/vRegr+5LRfr7VurTewe4zpPDc+G01cqu3mmLL7OxWEz2Z8OqaWImA9LCufIN
	dnmhfoIUV3rQ0GJZMygqefQ5Hft+oEpv5l7qJHQM9YzdA5jlndaUEbKqJx6o4u/78uTZelmbhv/
	QH655uhNkQUG5luFQxz2vjHz8IItQLIG2EHQltJm8BtUYPvdREfiILw1GNl2lsYfFW6rCWECZJD
	1IZsjhoxXCLGS0FEljKNYZrsI89hFSSEsdxprVB8ijMc3qwQYXwHr6hEOSk+G90Ujj+SzEPC//s
	4taXLWWo/dlBlWOb93vMvHhgyrNvnnwQcTAW9gndcg/Y1t71OiXcerGokEhxEZMEsSSLioUfNS5
	8KMpTnfWOHPDmBZcW4J5dvoa5ajqbd7UK64x5aBGQOqIOSVnVFaXSq3RwImKxV1jgzus6+i2/OE
	ooqd4qJcGGsxxysz2TE=
X-Received: by 2002:a17:90b:3812:b0:3ab:27f0:c90b with SMTP id 98e67ed59e1d1-3adeafc470cmr702551a91.53.1792800253105;
        Fri, 23 Oct 2026 17:04:13 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeba31797sm547433a91.1.2026.10.23.17.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 17:04:12 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 11/11] selftests/bpf: Restore stack pointer subrange pruning coverage
Date: Fri, 23 Oct 2026 17:03:53 -0700
Message-ID: <20261023-scev-simpler-clamp-v1-11-d43a07eda7af@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
References: <20261023-scev-simpler-clamp-v1-0-d43a07eda7af@gmail.com>
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
2.53.0
