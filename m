Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5F19B5B1
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170372; cv=none; b=BTsgvkcRn6jtSES3QwzMgyr8XhEDCCLdNG3gaU4dqth9yrsWbPfRN4J9AVFo0bbqhY7qiAucAayll3/5nezMzU7MQbxG0w1bN1kLZW8/AwEbxtDSG+6b48ye4junigzC5/Dt98HE7UGwPdRAxCwW1WVKw7LiobSAbUEdt011/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170372; c=relaxed/simple;
	bh=BwBnH+YRIO2HRClWBvNsj06TxoSuqtCyGyf/CaRrEpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtOrCL5ikRMhxX3+iH8LhihNKgdMU5AVp2uZbqZNowQf7e4MB9IEoku/ruajKaLh0eHCQSS/HW3DUQtiC7GtMKEIxwngNS07ZrLFd0c0uZ/etHDBzhQfV2sHnHHSwlE6xSaiCDyhaTh/8O414mpC2E0R4E2H/DT3uSgkBhsP+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZVyKXXF; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZVyKXXF"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-4994d67d2e7so927885e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 23:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170369; x=1786775169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I+pA8jpp7ePJ+BHMCZrXjj76k17Myh3dnJBEhVwTI1k=;
        b=qZVyKXXFwRqS6S/vpbj6lyrBqj1bVU7OTl/TjnKZ5pNv9OE/UFqYqIbgsZBL15WIr6
         Z6eYY9d5QcDkXseFqzPqUTvNBPU17ZTwWH1ukmLchtaA2G/bPQt4sFlWUKPPkbtWBExk
         QqpIh7Bo+hBwqeRW3AvBRtJIELx+bwOdxQJLCR0i4o4CDcCtJEXwnHyZPLHujM+8w2ZB
         fMGIDFUogCRShub/zGuri424Ga2+1rNZMSAtAuQaHADEMsNOQJc5uKQAwkbgXHID0M9C
         8jdaEeKKE+NG878BPZErZpxuGp+7e4R50KwRmnu8ksq5lCsclD/wgyZm1MCy/1HL8Ije
         Vz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170369; x=1786775169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I+pA8jpp7ePJ+BHMCZrXjj76k17Myh3dnJBEhVwTI1k=;
        b=Cbwf3Zx9mcwEyq6A0cJzYqfa+k6N346SXfaOmHtoCYLk+G/vwkCCCqx4+DEy6oarit
         o0gy6wDxaOVkSpXlPrpFUVWxN0HoYz7HzNZoKzDW9d3CMQoMTyGA5PYiGEHvRiCG0TLo
         Pe2yBb2j2/YjUlcYMel95QVrPhGJRwfi8ZqyT7nlIwt2p7Xa5rRYD6r+DisMo0mEU2x4
         kmgBbpD7emJYkKzojScAV8+HIUPM9mBvjfXJJKMoW1BcLczDwwa8j9E7r6b5BniJZ8qY
         SbRSD0+KGFRnK616Olk/V7H0K/OJUOu3PACkNyTS9JQx19v5v59MyCFV2XhYGiJC1hC6
         AnYg==
X-Gm-Message-State: AOJu0Yxh39VKahNbnbIDHefvgwGmu+WpeezEaOV5UR57RW5JZPgRYQNv
	X+zaeqFT/NIC+P4rwXX5xX318wZSf1wF3yvCzD0D0BGOyAo/T98sL+XxsDWAEZsm3nY=
X-Gm-Gg: AR+sD13Gx9Dtnc+s8HrtyU5hh6pkyPlaT5XoYQ2dDS9UFSssqtaG4QMDGxn9IRkvIqg
	1KB1CFxpWOLddCEh8zc8mCTKKnNUCaxCvYAZUw9Phihv9hpxu9CDOr9a970LfVqHI9+5Oy++5QY
	RK5tT4AsV/tiz6T58n1g7U5A9Jazf1LUbUz+LeqS9E2PuBRAmIADtEMFulWA3c68sdTFgrnVCxT
	O4K5rShjGwAoVL86lzPnGGeCV56OujdlLUG/XxxammhKvpYykEc/Weep+yIIT5W860rRjzbwdhj
	Gh3yHDVsh5FGabb0VYBfzQ/WtJCNI9bWAHfMZ22B+fDD34Cn4/DX03oPKqZffKvIxAyMCyunVge
	ZNVYxPlhkl7Ph2cr4PlEeRGaCT89dwMoNjMEgCHq7v3BNMkxSIGj7EP+mXjVQMQr9IMrMm8b+P2
	StW/Uic1bMovujHHek/ohPtOq7D7XwlFaMh9YHtpGxE2P7mZ9e3cO0/7CZTJjQEtoG600nPMVse
	VyrKITPdJw8Et9JB0arLLCIOti6UjSSCBQ2iCWOB1kPzKGkRTvkfxVWrwdC4SjtUXDXiAtLdRyG
	d8+Of57DOVQywijo7KCRRsZfw+w=
X-Received: by 2002:a05:600c:3b93:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-4996193de3fmr60624305e9.2.1786170368800;
        Fri, 07 Aug 2026 23:26:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f0230sm96122995e9.6.2026.08.07.23.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:26:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v7 5/6] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Sat,  8 Aug 2026 08:25:57 +0200
Message-ID: <20260808062601.1070988-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808062601.1070988-1-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1985; i=memxor@gmail.com; h=from:subject; bh=BwBnH+YRIO2HRClWBvNsj06TxoSuqtCyGyf/CaRrEpE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIavs9O0rokXZCelfNmySmv1aKfJk3/f2CbOlrz97LJHN8 GfForuvO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRZ7mMDBvVDbi2sYe3O1hn mzwNr7z2dfKFWVFhtwO2TcnNOrRtiTDD/3zjVact3vH2TJmQc/KBVUpNUUbSl7x5x8VvVCbZPWL +wggA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the per-program insns_self, insns_total, and stack depth statistics
emitted when BTF function info does not provide subprogram names. Check that
the subprog 0 main record and static-subprogram records use <unknown>.

Make VERBOSE_ACCEPT request verifier statistics so the raw-insn test can
validate the output without a test-specific log level.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/test_verifier.c  |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index a8ae03c57bba..bffb7360434c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1560,7 +1560,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
 
 	opts.expected_attach_type = test->expected_attach_type;
 	if (expected_ret == VERBOSE_ACCEPT)
-		opts.log_level = 2;
+		opts.log_level = 2 | 4;
 	else if (verbose)
 		opts.log_level = verif_log_level | 4; /* force stats */
 	else
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8cd626e04551..eb6e3baef412 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,17 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth max 352\t"
+		  "subprog 0 (<unknown>) main insns_self \t"
+		  " insns_total \t"
+		  " stack 32\t"
+		  "subprog 1 (<unknown>) static insns_self \t"
+		  " insns_total \t"
+		  " stack 256\t"
+		  "subprog 2 (<unknown>) static insns_self \t"
+		  " insns_total \t"
+		  " stack 64",
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

