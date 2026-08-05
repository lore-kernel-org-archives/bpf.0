Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A8305678
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892527; cv=none; b=aeTooDK47CwN7HOg9EQEXQqwW/Q8VG96MKrK25kULAYyo6VDst5t+VGLGicza77rhdxkyRKgY4/YMQ9zcUzRL+T+pPPi56Cja07m+BUts+slc477tGcLLWeLQPOpD7r0+0U9pfcu6XMhu9fX4vQxG+1hSF5ZS78pU1y1xO6ix4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892527; c=relaxed/simple;
	bh=RScFQPo0w8ITS96ViKIn1UtuxH9MPPFlw6+pyK/2iuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4mTU8xRj2TgUJI2QAXgvCKRhMQC9S/IElJ0VZaqeNih02UExSmE8WGC650ZMR8oE4Js8FY5fUV46kAfIqpb3LjSHhhbeOJ8TUQbAKq6uu2LID/iEu6bjOEDxmJh90VxNRZL1lw0bAeLZsrZItkvgYTMhzrdyxaeuSdmTc3k6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnLEvggj; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnLEvggj"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so1606005e9.0
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785892524; x=1786497324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUdIS1qHJzu5FG60kHexouzPHXpYbJkSTk0QgcriWMc=;
        b=BnLEvggj8dBI1rf+O80BP7/yei5T/yo0pGtD/aZfl/HFnYWZ4+Mqx+Zj/bDWESEXHM
         VXXR5Bdlz1Rx/MTBBTLCuxX4wlLPxiOtyTknUZq3dqRiWstZnONHsjwGHinqwc95+84r
         IvrQTH7fwl/80gdVm+k4W6JCV4pEs/BzIsEQ6xIvkzJgyCF9yGp9jYZ3VEUvvuundnwf
         dcP3CpbvMPWaysHgSLBWhzigxh+KRUKIofmqFgWAksy+aiPz2xpUpfg2x78ModThFA8O
         FYzn3s0RkHOdoMHKcPZdAfB+Zn+CNUdlIk1yEfYYIA7M9FOW8R483zSCwgDQLvT8bYKu
         Raaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785892524; x=1786497324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUdIS1qHJzu5FG60kHexouzPHXpYbJkSTk0QgcriWMc=;
        b=peVkxeGyeW7RPy5CzWqGD13DHWeEl4Aj16I+GlE1SW85wiFTa2cA2cqjHwXq/gisxO
         ZqvlLMIhjO2anypB6eitQi9Eh6f/XQzd/PFYFO7Kql5ZZRM9lOMsNsyl4TfD6Jx2+wMK
         ckpsQnxSYhmwEt2JqsXVzWDwqe1phkpu8o3SvzC9kkd2+qAlt28BZ+DTCytNwTAi8uQH
         uMDGoDVyEQB1givyCd3JVHa8jFqWQNOoG0cjA+0w1JSkj2YobVBzklkaxep/TVcUxjmV
         8Cx72Sil72icr5kxqgBWpaya2MQeOtSRUJqe/FjhsRbsOYD7pK0AiISv+/YAhxXWu+GZ
         I7pg==
X-Gm-Message-State: AOJu0Yzd3keBIM30Hm6Xt9JPNN55qcrt3y3aAmwKbmgus6S8ZJIRaeyu
	j1oUIGJM9bH+Lu1Keom0XjRA5vsqHhmUHpRuGsIDEac7wWDoynYp1Z/SA3j1sJTE
X-Gm-Gg: AR+sD13G/CjRbR+Q3MT0n21Z23V/piOrsxuMFnVXrIhvvLA+ClnXaDIh/5/WOrEk+ON
	N83ZL/8WO5P4Mm3iPQMUGXfEtOOvGB0oOldIAWM39/y93pRc39T8cTvAdkCGJXMC/p27AgQnT+W
	KVYpEDgF+8B0MRNOQfaV8NvQ5ecBPt9vX+ArCSe9jvgSdF95gp1zA1wXpcyK0Jy37R7H7+sUS7S
	5oJYw11pa2XUHK48q6Nev9k9AyKgmVCxPPeMp+rTTNfTCBSUETTU28mhFNYRD5FLfA2tgnW3KPC
	amtXVMBsbxhMkkIY2a9cKq4TPyalItZFbV2/wOC3/MggEXRSG2o+90hlYamnavk80dCUlXXBmg/
	puSztElHDjaiYaoGn/ztsTe6++4PtPKKZ/EItj+kPI+6M5l8FzpBPpcgsqgAFmV/Yu4O9MmLIIr
	euUjLhx+yz8gDebXKpm3O2ej8zb+jsZyL4n4xtMoUTx+sL9Z9eNVu51l7Uun3nArHVCejYd1MqW
	NGVS6SBhjUm7cjG16spEPsr6FeuEnOHMzupfPXHtut0b11RSRKlEHxXHP88nsR0ebahy++V6n/J
	BLEIbwQwh9rr9WVO7ijbzdVcbHa/hdtLPKT/Rg==
X-Received: by 2002:a05:600c:6dd7:b0:498:28b:1025 with SMTP id 5b1f17b1804b1-4994e7a7d1fmr20304055e9.5.1785892523658;
        Tue, 04 Aug 2026 18:15:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fd4c33sm123427295e9.8.2026.08.04.18.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:15:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 5/6] selftests/bpf: Test stack depth stats without BTF subprog names
Date: Wed,  5 Aug 2026 03:15:13 +0200
Message-ID: <20260805011517.1717238-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805011517.1717238-1-memxor@gmail.com>
References: <20260805011517.1717238-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1982; i=memxor@gmail.com; h=from:subject; bh=RScFQPo0w8ITS96ViKIn1UtuxH9MPPFlw6+pyK/2iuM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauoz813H6vbvyf2bLtjJm323/xCYneJQ8CPzR5JSybfz ZT5kbOto5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABNhamJkuH2/dxVnuHXT9Avb pdvel0V58PXv452/Re7VnV06Pzi5/BkZZrX0uEUueuwdyNNcwulneHPpz8Mf7xuY93Pbz+ZS6Wx iAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Test the per-program insns_own, insns_total, and stack depth statistics
emitted when BTF function info does not provide subprogram names. Check
that the subprog 0 main record and static-subprogram records use
<unknown>.

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
index 8cd626e04551..d1bc884e44b8 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -1091,7 +1091,17 @@
 	/* stack_main=32, stack_A=256, stack_B=64
 	 * and max(main+A, main+A+B) < 512
 	 */
-	.result = ACCEPT,
+	.result = VERBOSE_ACCEPT,
+	.errstr = "stack depth max 352\t"
+		  "subprog 0 (<unknown>) main insns_own \t"
+		  " insns_total \t"
+		  " stack 32\t"
+		  "subprog 1 (<unknown>) static insns_own \t"
+		  " insns_total \t"
+		  " stack 256\t"
+		  "subprog 2 (<unknown>) static insns_own \t"
+		  " insns_total \t"
+		  " stack 64",
 },
 {
 	"calls: stack depth check using three frames. test2",
-- 
2.53.0

