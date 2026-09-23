Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D675625E4
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190732; cv=none; b=HKVKmsJWhzFvC9kBMIjJzH2kuBVB5P4mVpRbduSm8FLG4RRBVQ6ORk1Ob/Xc7efykUPynA/r8ModzuEHDG7idSnStsrxU6qmeI/L27nzLY9mpFPwfAbYDgnT+LXtEu3STSAcM4i7dMRs59YGTdcV2jxcgwc+LEFyTMRQ8sl5cJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190732; c=relaxed/simple;
	bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X00Yrd8ox5puRZMunVERcn40pLFZMJd9Kn/vEhAivQ9mVO13DlCT/UpkfSGWRKM/IxNY7PPPe2zvr5x/t5qx3ig2neTxIrRy3hn8QRKCQ7ejgZZbDsEd54tZFGUaia95OB0EbR2qBWdkWIZ1KFUdkt9b+dXSa+Mwouv8YijJDwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/Ngy8fT; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/Ngy8fT"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so2638265e9.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790190728; x=1790795528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=G/Ngy8fTITRATaVhXGEu9sdt5RjNZVBm1FwBWV1GNXZwqTuQKadCUTy9qvb7QjUgmH
         cPnp0gUYkxnJHUtx/cb6nSK5cWNECrlF3c7VFVXoPicTJV/xVGsHx7vGDifXdDNfg1g+
         aIQJhqAWzmWbcDUDXfWa+aX0ktEEdfQHX/thebBHTm34W6pYtjA0JdAf8RNa+cZnOXn+
         wa9C9yoyrbIrnxD6gJiXEIi3pC8/4jf3xNExT6K+195UEcQxGkgbIYdel9Sn4zWWxu3A
         AzwmbXOr2s1PMN6WykdkOrfVzT2A2bZVHUIGtWzQt4KYazXgl4i4ptBQOws1TS66Y7LG
         quZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190728; x=1790795528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=GaiJFJAILTcmyVI2wYZsonj6QWpTYUG/X2NyqvSiPJCkURpCeqwgHRXDDkS1tHuphs
         fgLdgUATqFb6sn0QwoEWvnGEA62XEJjbp+KDlv5024E6w86yoPKmh/eTMiIkz+D1+oeN
         07E+zOBArsqmc8kngXvUkBpaxLICKbJayFrKzOPmCOYnaefTbAB4oNtWFa1bMIHhCZpw
         y/1/UayVLaQTJm04JE/nuMW6e5vTT5mT0vQ2LIsTFF1XIQfy3ksnyTcQrbkPIypI+eNX
         y3QvHXSyMB2YD1QHj1VGXVfKVhlpgndUKWgy0lZgvdrXhy7s9zNxYEP1vEeqnpClEdMK
         vZXA==
X-Gm-Message-State: AFuF++mCBJ2uBVQRWyjB2ovVFHRsW1MhsFaN3ZzH6qFcaDIxfnBV+XVN
	m2PQ9Ihp3AI6PUYUYsJ74XtSp2hd1gWe/SdTlifthTnk/s8SrWQGsF6iUEmttIjn
X-Gm-Gg: AYBFou1bqfJN4ZiTSsPOsqMadHyZVUSqVHQJoWhA6VwJLdy9Q3OKXINVd3QI7n+BHF0
	rEydAdGSvfn9DnECkQ800VVC1lvyrqjtD7lgf/POeBlfotOqzDumsNChtWKGBUm2aU58s0FdjDI
	BDkdarX0S2et3EqafcqaT7N+4rhyUUPmflBBKDkGiXrxCZVwpC7nK8mUavCitch4GYAYJMtbsMR
	0P243uLqHGI/J1cDC5AHfxfg/3QnfF/wtu4Hq3lhB5/9Fh8So9HXNX9euMxvTB1VVthAleRV8KB
	qb6M+SO7dV0wmidquA24yERgRPB57zhip+BXHtCcNSDvuaAbZQ5RUmkIcG1Fwn2HiyyemGNuSZz
	+rskM7JCqXRuZhzvXcNMUS6vIJT42Z0fSpxmOsMS/JngAQS0JLD3whR5srE61pYkLBHnECONvd/
	gpiyCINOuIwxly+9MKw4n+vVT1kBqDvpoZMsF566VqjCvdQhzcJCNrjFsO0tYGv7vDcOapvgTFF
	HVrFiWbSgtTMeZ1nmd1Isj6v0xa730LsJJXgclwmem842YsXq5bHq/V5p+MH6O9t4Gk/WyXnVa9
	XI01o+A2ZGrP4WKbEWy/fdY5ZBNlNUhDExXIBJeERQXn0jYY
X-Received: by 2002:a05:600c:4e12:b0:49c:fc6e:a3df with SMTP id 5b1f17b1804b1-49fe66f82d8mr2456225e9.30.1790190728191;
        Wed, 23 Sep 2026 12:12:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c288sm8005525e9.2.2026.09.23.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:12:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 14/18] selftests/bpf: Add load conditions on the program stack limit
Date: Wed, 23 Sep 2026 21:11:21 +0200
Message-ID: <20260923191139.2816206-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923191139.2816206-1-memxor@gmail.com>
References: <20260923191139.2816206-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6297; i=memxor@gmail.com; h=from:subject; bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWuL4o8bX6/x7Fxz8D2TBneA6r1D75x6Zu7pTJoc7H1Z5 90k6X0+HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI/hKGv9J3/z0y2D/T5ndN zW0jNt9ZR3cXvlgw2XiKdrsyp96M8q2MDDe+LJmrkWKr8LF0dsXzqs/infO3r6vMnf5Mg/H2YY2 A7zwA
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

