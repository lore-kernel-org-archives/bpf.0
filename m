Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561C5A0ACB
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202984; cv=none; b=qBo27RBTipNp3PqJbOmjyJYJCtmO9Deh8fPKhoFbKDE3n/hSIgnpTV+O9n3bdKU5znfQSq5t3fMJNCeWPatHYg7YYJdxbIivzVADtKSCodpGPM0sUuxnvN0zniYT8q01ezY26sp1ARe10NaUVtbyZuOfQfAkWsVwZ8+NeZwnq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202984; c=relaxed/simple;
	bh=ziUwrCFRUxuBRCEynhMeoORg002VmKh0DcZoA/iaRmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wmxa25PgCBRVexPxTKZUdeOAD7+wdMUm6zBYuvwgUqxE/+2eOe85hRP4Uuqrb0KnKCgg0fei9m6dJEBpoo/P0rFrcriGqKyzEsoBvH//ejWP+vq6Dd4VjjiSuw0iNN9zf/7ef9ySwYqn3nm3RUWxP/3v39tWLrWwTbU18qdNHgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ1vdXbB; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ1vdXbB"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a1676000so911395a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202978; x=1790807778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nfzBapFtMu1/UY4ChBEJn5OQXUt4PTrom7FavQN92BM=;
        b=mQ1vdXbBz6Ls852Kw3TSIP7Cmr3Mn4CxMcq+OlQynrEItQgiv6X6dXbvhwj1ixrtK5
         UUKVVKkeM3e3JD8TYV7YjMQE+0o/esVyZYDkuV2yxJsgcaxN4u3mx1Xw1cPtDGVuj/23
         YSDahA2YWKP2KmzI2eHaSx1nhwB88SXaklHLiKZ9A62vB0/hZaUJjgUV+wbRg0caLFCY
         VM6EjFBY2DzsXCguLefM4/Mjur8yGeBokfzFqYv9zG58clBapQ78wP0fZ/Xj5qsPyNnG
         6PzQpjUblJyN9IY834XnazkjQRVJDRA2kyEwwUwglUPyclRO5iRu4UR1q1WyrGq5IRT7
         SA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202978; x=1790807778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nfzBapFtMu1/UY4ChBEJn5OQXUt4PTrom7FavQN92BM=;
        b=l4q4FaA9k5hcwWDTnyB41C5zUXdLb9B4lSoeceMCiS4LOLdQtdOPfJleQ03wpFBaws
         xoOeuCrZX1hv6aQx1GGFqu4mfxwo6Pa6ZAr4x44CSvVleNzdkJGjZ2sZmIZxKCd+Ib9Z
         kiy4V0Z26DXDcuKqJmy+SYdmLCL9VgNq0aqcWChnZ8Eh8HEsFbKdffOOTWOgA0yRQsK7
         EAbD1sE1qgVsATc7wm/0UVSVQQslVi3Gm+VnTtiGQQDVoDwW6tKM78xzNtOqGfXPTMJZ
         TaDCo5L5nyDRMozRkUsSqK4XEBPcoarKkyQwDEVXeqx+VjuoUlLZmliCILeOP4pHIaw7
         FahQ==
X-Gm-Message-State: AFuF++l5N+EnzbqQ6TUe7akUwjzT+t4Fimc308V2y/AbDKzApuYUKlCm
	8Yg1GllyWfdKCOdwPW/gQYxTp/ZtNX3tgGxx/zGrW+Vb8rzQuRwfXz0Ky/T4Fw==
X-Gm-Gg: AYBFou01Jl1wTj8trnoJ+lm/4WONE0TaSHAl34CxgbH9qdo/KtZkU/977u8ZLaGnrzw
	Oteqctru+UZpHLhoslBN/5+oE64Tn64HdIars+ZbWUkl6YJBMEyXKaY+bhvXbWNmypEEDnkJKcu
	MKmQKdHZ3U5BOvUj7crm13Xmw2sQPAxOdZCmqCM1CteuR2MGHRpVy6kninsdCPHvymaKQnR/akm
	W8ZBOZpxTVsgHJv99683XO4OyNOTv6iDR9VRqYKKc+Hrt0uHONFXHgcH4c0HAeNRz8mfjs2M7jR
	qbbOu7BA9rHsRsUsA+SR0STShmGjCk9IFBrAm7YK+RByDIZi+zTPwAn+JC8xN5cfA2ZJ+ZZ5Sib
	rupG6d2Od1+fG2MpOuY8Szr+7JA3LKofDioztg5vw2WB9N58jc4PyiD81b8MIVN+MMpzeK+NPB5
	OXaj4yp5S5BlkaNzZlBHxzTUzmrNF66llfvcODy+h24lOPEaD7WR8LsGQNS/LrbqSAQoD3qzeC4
	gte9ylKrFOjAtfUZPdeDnlcD8Wifs51VGlODkZNVVTsZ370AToQP+G7V+gWE2JPnOn4vkfjWkKE
	RGIJvITrbULwRwEBhZIkhxQF6XfJdLLBP0xvBRyrAlSwLz7sTOyu4A==
X-Received: by 2002:a17:90b:2241:b0:39e:6a81:f34c with SMTP id 98e67ed59e1d1-3a098bb6416mr487568a91.38.1790202978149;
        Wed, 23 Sep 2026 15:36:18 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09773a515sm1104288a91.15.2026.09.23.15.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:36:17 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 7/8] selftests/bpf: Adjust tests to widened loops
Date: Wed, 23 Sep 2026 22:35:53 +0000
Message-ID: <20260923223554.562379-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
References: <20260923223554.562379-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The loop that can exit, but is not known to, is accepted with may_goto
added to it. The tests that expect "infinite loop detected" or
"BPF program is too large" for such loop expect it to load:
 - verifier_cfg: conditional loop
 - verifier_movsx: MOV32SX, S8, var_off u32_max
 - verifier_search_pruning: short_loop1
 - verif_scale_loop3
 - test_verifier: "calls: conditional call 6". Don't run it, it takes
   may_goto 250ms to end it.

The loops that never exit are rejected as before.

verifier_precision/state_loop_first_last_equal: the loop converges on
the second trip. Checkpoint with first_idx == last_idx doesn't happen.
Expect mark_precise from the exit test of the first trip.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/bpf_verif_scale.c          |  4 +--
 .../selftests/bpf/progs/verifier_cfg.c        |  4 +--
 .../selftests/bpf/progs/verifier_movsx.c      |  2 +-
 .../selftests/bpf/progs/verifier_precision.c  | 29 ++++++++-----------
 .../bpf/progs/verifier_search_pruning.c       |  3 +-
 tools/testing/selftests/bpf/verifier/calls.c  |  5 ++--
 6 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 902a70d5afeb..2dc37090d7a4 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -154,9 +154,9 @@ void test_verif_scale_loop2()
 	scale_test("loop2.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
-void test_verif_scale_loop3_fail()
+void test_verif_scale_loop3()
 {
-	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, true /* fails */);
+	scale_test("loop3.bpf.o", BPF_PROG_TYPE_RAW_TRACEPOINT, false);
 }
 
 void test_verif_scale_loop4()
diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index 3c3bb03e8217..700eadf5d430 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -98,8 +98,8 @@ l0_%=:	r1 = r0;					\
 
 SEC("socket")
 __description("conditional loop")
-__failure __msg("infinite loop detected")
-__msg_unpriv("back-edge")
+__success
+__failure_unpriv __msg_unpriv("back-edge")
 __naked void conditional_loop(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 195b27a51224..280ccee33663 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -226,7 +226,7 @@ l0_%=:							\
 
 SEC("socket")
 __description("MOV32SX, S8, var_off u32_max")
-__failure __msg("infinite loop detected")
+__success
 __failure_unpriv __msg_unpriv("back-edge from insn 2 to 0")
 __naked void mov64sx_s32_varoff_1(void)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index f4459561bf39..88358586e796 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -152,22 +152,21 @@ __naked int bpf_store_release(void)
 SEC("?raw_tp")
 __success __log_level(2)
 /*
- * Without the bug fix there will be no history between "last_idx 3 first_idx 3"
- * and "parent state regs=" lines. "R0=6" parts are here to help anchor
- * expected log messages to the one specific mark_chain_precision operation.
- *
- * This is quite fragile: if verifier checkpointing heuristic changes, this
- * might need adjusting.
+ * The state is widened when it comes back to the loop head, so the exit test
+ * is decided only on the first trip around the loop. "R0=2" parts are here to
+ * help anchor expected log messages to that mark_chain_precision operation.
  */
-__msg("2: (07) r0 += 1                       ; R0=6")
+__msg("2: (07) r0 += 1                       ; R0=2")
 __msg("3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: last_idx 3 first_idx 3 subseq_idx -1")
+__msg("mark_precise: frame0: last_idx 3 first_idx 1 subseq_idx -1")
 __msg("mark_precise: frame0: regs=r0 stack= before 2: (07) r0 += 1")
 __msg("mark_precise: frame0: regs=r0 stack= before 1: (07) r0 += 1")
-__msg("mark_precise: frame0: regs=r0 stack= before 4: (05) goto pc-4")
-__msg("mark_precise: frame0: regs=r0 stack= before 3: (35) if r0 >= 0xa goto pc+1")
-__msg("mark_precise: frame0: parent state regs= stack=:  R0=P4")
-__msg("3: R0=6")
+__msg("mark_precise: frame0: parent state regs=r0 stack=:  R0=P0")
+__msg("mark_precise: frame0: last_idx 0 first_idx 0 subseq_idx 1")
+__msg("mark_precise: frame0: regs=r0 stack= before 0: (b7) r0 = 0")
+__msg("3: R0=2")
+__msg("loop head 1 widened, pass 1")
+__msg("1: safe")
 __naked int state_loop_first_last_equal(void)
 {
 	asm volatile (
@@ -175,11 +174,7 @@ __naked int state_loop_first_last_equal(void)
 	"l0_%=:"
 		"r0 += 1;"
 		"r0 += 1;"
-		/* every few iterations we'll have a checkpoint here with
-		 * first_idx == last_idx, potentially confusing precision
-		 * backtracking logic
-		 */
-		"if r0 >= 10 goto l1_%=;"	/* checkpoint + mark_precise */
+		"if r0 >= 10 goto l1_%=;"	/* mark_precise */
 		"goto l0_%=;"
 	"l1_%=:"
 		"exit;"
diff --git a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
index f40e57251e94..7098b44faafc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
+++ b/tools/testing/selftests/bpf/progs/verifier_search_pruning.c
@@ -341,8 +341,7 @@ l0_%=:	r1 = 42;					\
  * test would take a very long time to verify.
  */
 SEC("kprobe")
-__failure __log_level(4)
-__msg("BPF program is too large.")
+__success
 __naked void short_loop1(void)
 {
 	asm volatile (
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 8b94b87135bc..c7c501bfc660 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -559,8 +559,9 @@
 	BPF_EXIT_INSN(),
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-	.errstr = "infinite loop detected",
-	.result = REJECT,
+	/* may_goto ends the loop after 250ms, do not run it */
+	.result = ACCEPT,
+	.runs = -1,
 },
 {
 	"calls: using r0 returned by callee",
-- 
2.55.0

