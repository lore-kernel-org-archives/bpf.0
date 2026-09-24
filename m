Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0E47D452
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267536; cv=none; b=sZL9km4CdrUS/j8GITphrD29yqzjyzTtnc2zguKUgwjnwolGOv7zd1oyhaJyxDpsn1s15fVGFyehip3BIU4N1qF2XUUeVUq/0Zi6A3W4wbNCGFem0LnzPZG7JQM9Uc+uS6SVYgbUbNe8SDTdLQ08YPrDUS7lG+ca4CfK2w6EYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267536; c=relaxed/simple;
	bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ki5Lr/WQg9zrJMnwfePAKcNnbk6whhHtL22CD/gCBNaK/2F/PIaHWq3MU/s0erG6vbHysDua1EsbWYz+bQbB+n+of+zavkiiFA8H3xoZLuXauZAKkYUPbbmL+x5DgiSBMBUI8ZapBq4OO+z8aoPYNZAekpQifA6SYqtLnENPC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M33z41ep; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M33z41ep"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-486e4e15deaso1533f8f.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267533; x=1790872333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=M33z41epfmBnVYrsWyfa47rsgpX+hAweKYkzWhq0ol94R8cYs3H/Z1laCRpsP8Nwh0
         Z9KYAi6vQSzwr8+FLaLNaT/tAf+rACooqFVPvfLdC7atIzIngUVO1PlgN3w7kmDlBVry
         CZsoT9fGVUE4oApmlryk+ZeD5OSLogqWnPfcc9kWzrn01ZIOjXvz4lA91J1dUmnOUMdi
         WG3qJqlENYrXmi2a/bmXKdivObjZolVeF/IrUOdnlWGMcWT+Wfe2QPh0b4C9g7DQsbRm
         /LEwPfU87nX0oTlm5tIEPFQeP29ZbEuXt3sOnLQCvd+xlrt2xt+bCrUITaPIffTjEnIw
         du6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267533; x=1790872333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=pzSjHV5VsBcckWhfqeLXeDP4dedsX9CxgaqsJ9bH2NCgrx6YfGRtzgSBKXA7elJJ1F
         6+xFPSuwc+BMsT+LouSOLA1gZIL8mz7Gcd5aVNFNnUy+LsyBD+1UqYDiyBPPbQzI9Y6w
         61NK6hQM9sGNIb/yL8qwexR6gImhZph8FmEkUuBvn1LBXyitHfc9Yo9v0VToK/OjJCHi
         YDRC/4VNERI5XMiF2EIFDA3iMMDM/Aol14QSvSoSHvzUBO+LW1Z3LQog1AOuQUwY4bU6
         nSGDKc/4y9py4CxvOB4cy9xJZoJZL1QyJl96EBlEkJSnSWxcFE/sQE9UMD5hS/tGz5Sn
         CrRg==
X-Gm-Message-State: AFuF++mTjjWQZF+Wrz49VKBrMo/xDb0iVLtTFmOwTHDoKYfDgmAHPMCI
	ROjVIsWnRBZPHxWXyYYZ5FcjRAW2/WDftq1Uv43XVxymgsejDWHW2wwQXbyyNJ5p
X-Gm-Gg: AYBFou3KmqSDeZ4thopYEdp82EoKVE9Y7oPONLz+WDZM/hwsNecbaumGGZdm5EnZl7Z
	PzWpTnNxk/jYml3la61NoEsyV9RRR64L2Dpgo+gFKkwieFuhasQAhiCRKkRyucBGTtWwzibWstR
	XkvILd5ZgS8aJJ96kSJfxN0aJvMQWHvLZOJKqjtW6FnrN3a20ST4Hn2k1pDUN41NXXAhuaW0C7v
	JyS27M6JTe1c+wiVw4njEJpFRRxof21REBxDxAjF2YW7cx267WEsDggJ21phfR+A80p1jWXI5q/
	lFSCcniKfUn8nOqh36QyqJVVaPGhgVpZt/ktoiSxwddDGkTximk2DRK/yTDC5XJ/lKBMFoUwAHu
	08WSqlPblOBT/nkl9BPAXABcsa0tkkA7K0vFjTwCsr+AZXawv3gx39k/D4+WPwFdOPLubvbrtNb
	7oY6sLzc0GlrFvZm5bxvQKCu1figF1hQLP3kWaJP2C5DNpAkQONLFjuSFjr91HCJEejXVBlRWA8
	/A1iOBSaxaIqkdBYit0y1rBMy4hWn8wxp18j+xeQV12bnPRiOhcOJ3rE5OfsyZYw94f9O/jEcm+
	dpLpwnoFkhkhxRmYpfvJpDuGHPwFAQpXwseokw==
X-Received: by 2002:a05:6000:430b:b0:487:27f6:a4e2 with SMTP id ffacd0b85a97d-488716bbf9dmr5892407f8f.50.1790267532724;
        Thu, 24 Sep 2026 09:32:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a84221bsm114282f8f.36.2026.09.24.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:32:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 14/18] selftests/bpf: Add load conditions on the program stack limit
Date: Thu, 24 Sep 2026 18:31:28 +0200
Message-ID: <20260924163144.1945455-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924163144.1945455-1-memxor@gmail.com>
References: <20260924163144.1945455-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6297; i=memxor@gmail.com; h=from:subject; bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur79sbX6/x7Fxz8D2TBneA6r1D75x6Zu7pTJoc7H1Z5 90k6X0+HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI/wsMfyU/33nWcu7pjsCK rpKFWV6KW7feVJ8WvGMnt9yT7qMRP9YwMpycwXe/zWbtydvl6Xszuv7we3i3p99N15y28qrWYv2 S/ewA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The stack a program may use will depend on the JIT: 2 KiB where the JIT
declares support for large stacks, 512 bytes elsewhere and for
interpreted programs. Tests that probe the limit therefore need to know
which one is in force. Add __load_if_large_stack() and
__load_if_no_large_stack() to test_loader, analogous to the JIT load
conditions, backed by a one-time probe that loads a program storing at
fp-2048. The probe caches only the verifier's verdict on that store: a
load that fails for another reason, such as a missing capability, is
reported and probed again on the next call.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  3 ++
 tools/testing/selftests/bpf/test_loader.c     | 24 +++++++++++
 tools/testing/selftests/bpf/testing_helpers.c | 41 +++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  1 +
 4 files changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 2ced1d751ace..f3dbc3b59bff 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -175,6 +175,9 @@
 #define __prepare_priv		__test_tag("test_prepare_priv")
 #define __load_if_JITed()	__test_tag("load_mode=jited")
 #define __load_if_no_JITed()	__test_tag("load_mode=no_jited")
+/* Whether programs may use more than 512 bytes of stack on this kernel and JIT */
+#define __load_if_large_stack()		__test_tag("stack_mode=large")
+#define __load_if_no_large_stack()	__test_tag("stack_mode=small")
 #define __stderr(msg)		__test_tag("test_expect_stderr=" msg)
 #define __stderr_unpriv(msg)	__test_tag("test_expect_stderr_unpriv=" msg)
 #define __stdout(msg)		__test_tag("test_expect_stdout=" msg)
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index a6e3fcc1079c..25eeb1c1248b 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -45,6 +45,11 @@ enum load_mode {
 	NO_JITED	= 1 << 1,
 };
 
+enum stack_mode {
+	LARGE_STACK	= 1 << 0,
+	SMALL_STACK	= 1 << 1,
+};
+
 struct test_subspec {
 	char *name;
 	char *description;
@@ -70,6 +75,7 @@ struct test_spec {
 	int mode_mask;
 	int arch_mask;
 	int load_mask;
+	int stack_mask;
 	int linear_sz;
 	const char *skip_reason;
 	bool prepare_priv;
@@ -425,6 +431,7 @@ static int parse_test_spec(struct test_loader *tester,
 	int err = 0;
 	u32 arch_mask = 0;
 	u32 load_mask = 0;
+	u32 stack_mask = 0;
 	struct btf *btf;
 	enum arch arch;
 
@@ -620,6 +627,16 @@ static int parse_test_spec(struct test_loader *tester,
 				err = -EINVAL;
 				goto cleanup;
 			}
+		} else if ((val = str_has_pfx(s, "stack_mode="))) {
+			if (strcmp(val, "large") == 0) {
+				stack_mask = LARGE_STACK;
+			} else if (strcmp(val, "small") == 0) {
+				stack_mask = SMALL_STACK;
+			} else {
+				PRINT_FAIL("bad stack spec: '%s'", val);
+				err = -EINVAL;
+				goto cleanup;
+			}
 		} else if ((msg = str_has_pfx(s, "test_expect_stderr="))) {
 			err = push_disasm_msg(msg, &stderr_on_next_line,
 					      &spec->priv.stderr);
@@ -659,6 +676,7 @@ static int parse_test_spec(struct test_loader *tester,
 
 	spec->arch_mask = arch_mask ?: -1;
 	spec->load_mask = load_mask ?: (JITED | NO_JITED);
+	spec->stack_mask = stack_mask ?: (LARGE_STACK | SMALL_STACK);
 
 	if (spec->mode_mask == 0)
 		spec->mode_mask = PRIV;
@@ -1331,6 +1349,7 @@ void run_subtest(struct test_loader *tester,
 {
 	struct test_subspec *subspec = unpriv ? &spec->unpriv : &spec->priv;
 	int current_runtime = is_jit_enabled() ? JITED : NO_JITED;
+	int current_stack = is_large_stack_supported() ? LARGE_STACK : SMALL_STACK;
 	struct bpf_program *tprog = NULL, *tprog_iter;
 	struct bpf_link *link, *links[32] = {};
 	struct test_spec *spec_iter;
@@ -1360,6 +1379,11 @@ void run_subtest(struct test_loader *tester,
 		return;
 	}
 
+	if ((current_stack & spec->stack_mask) == 0) {
+		test__skip();
+		return;
+	}
+
 	if (unpriv) {
 		if (!can_execute_unpriv(tester, spec)) {
 			test__skip();
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d1d60451c5bc..47fe61a1ebff 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -517,6 +517,47 @@ bool is_jit_enabled(void)
 	return enabled;
 }
 
+/*
+ * Whether the kernel accepts a program using more than 512 bytes of stack,
+ * which depends on the JIT in use. Probed once with a program that stores
+ * at the 2 KiB depth. Only the verifier's verdict on that store is cached:
+ * a load that fails for another reason, such as a missing capability, is
+ * reported and probed again on the next call.
+ */
+bool is_large_stack_supported(void)
+{
+	static int supported = -1;
+	struct bpf_insn insns[] = {
+		BPF_ST_MEM(BPF_DW, BPF_REG_10, -2048, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	char log[1024] = {};
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.log_buf = log,
+		.log_size = sizeof(log),
+		.log_level = 1,
+	);
+	int fd;
+
+	if (supported >= 0)
+		return supported;
+
+	fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns, ARRAY_SIZE(insns),
+			   &opts);
+	if (fd >= 0) {
+		close(fd);
+		supported = 1;
+	} else if (strstr(log, "invalid write to stack")) {
+		supported = 0;
+	} else {
+		fprintf(stderr, "%s: probe failed with errno %d, assuming 512 bytes:\n%s",
+			__func__, errno, log);
+		return false;
+	}
+	return supported;
+}
+
 int stack_mprotect(void)
 {
 	void *buf;
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 1c58a2f08b64..f1505108e26a 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -59,6 +59,7 @@ struct bpf_insn;
 int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
 bool is_jit_enabled(void);
+bool is_large_stack_supported(void);
 int stack_mprotect(void);
 
 /* Runs diff(1) on mismatch */
-- 
2.53.0

