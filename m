Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130438735D
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783404517; cv=none; b=fGqaOYu+VSjqLpnhmapszHspW5AErK7M6yr9uSZAPDy3kcpgDasUqUz+ElUroeOfwoAFaL3BMZS83SqlgOPJTJE3DBY+NdRes6p/5+2v6UQHUwvEseF9fDjK7Y27Cz83Yxjt3biSRwt7Pjj6cfU5nqEA5R0Puz/+AjxU8nZ+/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783404517; c=relaxed/simple;
	bh=FzKeTeF8JA+KsfuZhglVYUhLx5S0Q2O5ea+96KMWWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2BNgZKvijbOH47QktXY4FYzREPe8jek34LD/c58JTbdkc2Eyag9wFTXlB38XUHG0I6BhN75DnRYM7DG16vsR0P+daYG8hPDJYs93B022CNBGRolJ+ul1x6Hk311xN/M9jmbApkHBDY4tUjQXziEPFEVcDPrGmmYXuZp/u6LS8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4slBhf4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4slBhf4"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso3918835a91.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783404515; x=1784009315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGJwch6uaoT+4VIjlzymTYDaLAmgt0JW6oLszFG1Jaw=;
        b=O4slBhf4SBpISChcLjVfaZaiPonijKx0sReRXzWA5V58Ez3amlN5XskP9yFbzZjYjT
         6dg9PxEBvXABnwiE4lP9YD8iyhbwdDoO5wVeJ2tvSHt4lKpXZssaU2LP1F4F012wVwIS
         ku9kgJXEyJBZFSowYj3cZ4NSeQc3veWfl/rACWN/4FEG/NUInMtu16+9IG9S/lIPv8dV
         5oa2DhmmSV7GfOKLAQgYJvCIvc8CKi8s3zHNcOYmHnKRUEMh6De2cxZpRmve8nw3RqdC
         94gLRcckrkMaAlNw2kvVFkFGJ4a68tEDcm1cfCv+HZSLtYFtD4mZXwm8StD98MtRYvck
         zVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404515; x=1784009315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGJwch6uaoT+4VIjlzymTYDaLAmgt0JW6oLszFG1Jaw=;
        b=ePLpCDs/3mUSUCcAYS7eqjZORI3jdrio8jPSTcSS8xN7v5NF9PX1KSzXcO3yU8nvCc
         /bgp5wGTrviV18CJn4311tnRYjrW+prDroqkdU1lXYZz1CqC4P1KZQibkyVp2M3mhpVJ
         4PqSkFwRyHUFboIk1KQZXqDrGjCEq0MHMOncXmB4+KPewUVkOT45zCuJPPNdaUvhnwNV
         Pv4cyeP2vN5vzLNWYwO2ViAeJuYdOPLWYMn2UxM+q5I35+rOySD3Fnpnp7IFcTIt0sWB
         hBGcigV6VBssrcT60Sdepgs4zugOugBCFY+lQ+1Sd41revI0UisBqWCF/0VkCqfEvNdO
         qthQ==
X-Gm-Message-State: AOJu0YzbSBp+nv088XLyKH+tkxPifvyAYlDSGoQXVztwfgLLqOHll808
	Dh0fxmAkgzPhFgS1eHM3oj1tkkv+XjkEp2DTAsy0kyw7WNa6HI0FiOBQoaNBk30eTOtQrg==
X-Gm-Gg: AfdE7cnt+z0WJsiW1d1ir3JHnsNCaJt0MXnG3WkXvruZ/OT17JkaBApBzGKX/uzw1aI
	IMWisSGU1s2Ks0si4Nc/rRx2BFyn6TnxQFeqJolQJdsSOgX3HjoLGjdo7+GZNpWfsc5TphPtmaH
	zrCKdbLpaL1ZDOLODDcabqq7zWIsDa7j5oGHLNF95iRA1RC67UJjNamYQ0Reh047wqCGWdt0Dnw
	enIcnsw3Bx0oQfV2U+0lOcHf9NHznOmoeweqeIh7vAi8b1HyeITyvf3yaDyiN/Z10P2HYhNROm2
	sATmi+lNsxjz0Xi2QDuOMSP+9cHkClTwoeQBsqvZJiUmV26cgAU3WP0lMZV9syW9KfDKEvEOcAk
	XWRneU/EQksRS+GoD+FlsHfRmESXBmxwFP9z7x1F6u1SlMcMFJxSnE4dJHOm8dxLYBWZ2r13WrY
	5pi6YNz6urFMrgQ0EgStBPjvJTllNsKn9yVWyKq6tyr547knWUPEM29zN8F0JVZz92SLMDbrNYE
	K/sAkVbEj3n5eb6KqrpnKcb/nMq1bfNf5cKc3eGrBUR
X-Received: by 2002:a17:90b:5292:b0:381:23d5:693f with SMTP id 98e67ed59e1d1-3875806236fmr4033079a91.28.1783404515039;
        Mon, 06 Jul 2026 23:08:35 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm4101507eec.4.2026.07.06.23.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:08:34 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	mmullins@fb.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Cover negative raw_tp writable buffer offsets
Date: Mon,  6 Jul 2026 23:08:04 -0700
Message-ID: <20260707060804.93561-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707060804.93561-1-sun.jian.kdev@gmail.com>
References: <20260707060804.93561-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add raw tracepoint writable coverage for buffer accesses involving
negative constant pointer adjustments.

The verifier case checks that a negative effective offset is rejected.
The attach-time case adds incremental coverage beyond the existing nbd
test and the verifier rejection case: it uses a negative var_off and a
positive instruction offset whose effective offset remains non-negative.
This exercises the checked access_end accounting path and verifies that
the resulting max_tp_access is still checked against nbd_send_request's
writable size at attach time.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../raw_tp_writable_reject_nbd_invalid.c      | 58 +++++++++++--------
 .../bpf/progs/verifier_raw_tp_writable.c      | 16 +++++
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
index 216b0dfac0fe..efe4cad47b28 100644
--- a/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
@@ -4,12 +4,31 @@
 #include <linux/nbd.h>
 #include "bpf_util.h"
 
-void test_raw_tp_writable_reject_nbd_invalid(void)
+static void check_nbd_attach_reject(const char *name,
+				    const struct bpf_insn *program, size_t prog_len)
 {
-	__u32 duration = 0;
+	LIBBPF_OPTS(bpf_prog_load_opts, opts);
 	char error[4096];
-	int bpf_fd = -1, tp_fd = -1;
+	int bpf_fd, tp_fd;
+
+	opts.log_level = 2;
+	opts.log_buf = error;
+	opts.log_size = sizeof(error);
+
+	bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
+			       program, prog_len, &opts);
+	if (!ASSERT_GE(bpf_fd, 0, "prog_load"))
+		return;
+
+	tp_fd = bpf_raw_tracepoint_open("nbd_send_request", bpf_fd);
+	if (!ASSERT_LT(tp_fd, 0, name))
+		close(tp_fd);
+
+	close(bpf_fd);
+}
 
+void test_raw_tp_writable_reject_nbd_invalid(void)
+{
 	const struct bpf_insn program[] = {
 		/* r6 is our tp buffer */
 		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
@@ -19,25 +38,18 @@ void test_raw_tp_writable_reject_nbd_invalid(void)
 		BPF_EXIT_INSN(),
 	};
 
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.log_level = 2,
-		.log_buf = error,
-		.log_size = sizeof(error),
-	);
-
-	bpf_fd = bpf_prog_load(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, NULL, "GPL v2",
-			       program, ARRAY_SIZE(program),
-			       &opts);
-	if (CHECK(bpf_fd < 0, "bpf_raw_tracepoint_writable load",
-		  "failed: %d errno %d\n", bpf_fd, errno))
-		return;
-
-	tp_fd = bpf_raw_tracepoint_open("nbd_send_request", bpf_fd);
-	if (CHECK(tp_fd >= 0, "bpf_raw_tracepoint_writable open",
-		  "erroneously succeeded\n"))
-		goto out_bpffd;
+	const struct bpf_insn negative_var_off_program[] = {
+		BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
+		/* make var_off negative, but keep the effective access offset non-negative */
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, -8),
+		/* one byte beyond the end of the nbd_request struct */
+		BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_6,
+			    sizeof(struct nbd_request) + 8),
+		BPF_EXIT_INSN(),
+	};
 
-	close(tp_fd);
-out_bpffd:
-	close(bpf_fd);
+	check_nbd_attach_reject("nbd_invalid", program, ARRAY_SIZE(program));
+	check_nbd_attach_reject("nbd_invalid_negative_var_off",
+				negative_var_off_program,
+				ARRAY_SIZE(negative_var_off_program));
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c b/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
index 14a0172e2141..4055a6443bc2 100644
--- a/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
+++ b/tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c
@@ -47,4 +47,20 @@ l0_%=:	/* shift the buffer pointer to a variable location */\
 	: __clobber_all);
 }
 
+SEC("raw_tracepoint.w")
+__description("raw_tracepoint_writable: reject negative const offset")
+__failure
+__msg("invalid negative tracepoint buffer offset")
+__naked void tracepoint_writable_reject_negative_const_offset(void)
+{
+	asm volatile ("					\
+	r6 = *(u64 *)(r1 + 0);				\
+	r6 += -8;					\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	:
+	:
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

