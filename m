Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90385274B3B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483677; cv=none; b=eo5u/sKQE8MiaA76LEaCOEwDvLl5x3imSKJHEuBHCrqvWMtslDBhYTEX4WYCZmDL2T4OXDSmbW1B5rdnL07eoQyDdLCLSvw62fZ7UnWrwkwvm6RiIQQoRBnHJD3r7Jz/GKAjwt4lUdKqqCXHldklfHwhSqXff4ojxYMRk/cIEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483677; c=relaxed/simple;
	bh=FzKeTeF8JA+KsfuZhglVYUhLx5S0Q2O5ea+96KMWWzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbT95wlx2Ak/vhjGDEIM+l28coV83BPc1Ux0CHEdaIyJbbxq6do5sct8biRz+nEhm/TjnSxDieI0KsSOvW6bzMOPThfIWsb3c8Dhgr5iPfZbZMHIkqrLGzx3NM7J511s3sPWWc4MKa+DJxbYFAD3FWqVWtLb3ZIlEysLeR8KOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgtJHMDc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgtJHMDc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381891a9525so306419a91.3
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783483676; x=1784088476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VGJwch6uaoT+4VIjlzymTYDaLAmgt0JW6oLszFG1Jaw=;
        b=CgtJHMDcrFVIvpHnz8B+kqjJ2yXpOBR0aBfeT+aw3IZZCEdBDNXW4Ma2YW2MUejmNx
         Fy+23++tAMsNhYDU88KQzycAs39i/MCWGbyNX0X3MVRjrJHGUwRW1RAV0N0/SH4dALr9
         5895RVTLO4cBfRaoYMAyHHfVr4io6HA3vLiTfZWioRo5DrleRp0mk7b04QmSVNZYs4mR
         PWqkzO3sAATpi0TIB3OhatI1hyfz29HdLWaVcnfFyN0NqkG1cKtM+kwJ8apBd5hYPYF3
         ZNAuOAFKxuBZDQ5JB4L4EgKxbDhk15XGn1AJLLN3ZX94c8dY1QfnmpGnGk1Bi5F6gXJB
         p6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783483676; x=1784088476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VGJwch6uaoT+4VIjlzymTYDaLAmgt0JW6oLszFG1Jaw=;
        b=d9mfGbrR/P5+wkJA3k2LwH66rL40zB4D0NjdxJNVtnPHTYJe7Oh1tQDG5Fsw2pJmw7
         xxLNLw/0V5Gm87UMG1/86UNMcaNxFCT1wwagDrJq5uV00mej4QqXAjycNghJlHgOQHba
         034KMinPRyF9kgxj8T9gF7T01X5OjH6LXM+lv+k3tRGU7/WjJ7x8XGlH9GuP14aJV34R
         T15qJdbvV4tsJlDs97j/yAWnnaV6hM5pvEx9UzC2rLBzfWbCC+l+U24dd6qRPk8YlNZx
         uaqg6ooD+n4TP7voq1y3kI2muQ99StnYeO0BD2DLg2wWqTcFshPy40peM7YlXnjh4Ger
         QrnA==
X-Gm-Message-State: AOJu0Yw9HzE42ivWP+zqABaS8hNbiTW0M+mq6T7acMbEMmJ3VDAasNVw
	kwkqvg/ApoR1iaqXvVAjL/aWeu2CeJUHiI5dxwY80VNQS0jmpfvswmk+d3HH+wkdLrf47g==
X-Gm-Gg: AfdE7cmVsolW1mTqVojRKHFvPtMnqmEbRV3giMw6aMe0vYxcLT5gcDKSkUbA01S54ng
	l4FyES4dxKkWrzCyPcKOFaA9gfGCSVKMZiwE2+Nkxi6hvTNfsbMn+q9d+4a5c5it2qYmri42LWS
	bKffrnMuQy6z7dEN5xCfudaU8EPKFbNdEf7w3jMB5MQt3hiuxdKUj2V4UoXNb1gSM0/tUv8DF8W
	EU96rpTShEmVU5yw5HfnCjYRqkZ23dHcZ2CmtUs85IVGrmmbAbccp2274wB1QNIMDrH9O/cENbp
	BhjYqqGXCZHFuWTjdgTtXDhs7lzjNuGBuy0Q2N+6WSVEvx1FARSr+ub5cMOz5NZQpq+aYdCjNFt
	VaOVJTMvSTCLGsnFMWp/VBqw+AJgUUNxgNYakq1kqIWnMni3ggaL15lEl5HIpE99WQju7cufbnz
	3O2oV9UNCYBRhQY6bCauOuD62QYqJ5zYTo1mgK8uGh2FoUkvJJpkwiuHgi55zkXrbeJmcSnSYob
	Gf42F5R2vx2fwNNKwddah7J+SUgKaXriw==
X-Received: by 2002:a17:90b:2f06:b0:381:50ab:1594 with SMTP id 98e67ed59e1d1-3894120590amr862773a91.27.1783483675857;
        Tue, 07 Jul 2026 21:07:55 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.tailf6b5e0.ts.net ([24.4.24.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm4198982eec.9.2026.07.07.21.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:07:55 -0700 (PDT)
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
	shung-hsi.yu@suse.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: Cover negative raw_tp writable buffer offsets
Date: Tue,  7 Jul 2026 21:07:15 -0700
Message-ID: <20260708040715.116680-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708040715.116680-1-sun.jian.kdev@gmail.com>
References: <20260708040715.116680-1-sun.jian.kdev@gmail.com>
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

