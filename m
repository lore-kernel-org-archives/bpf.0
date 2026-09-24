Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3924A841D
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269090; cv=none; b=awpBTmmMMm/8oiyObI49IrJWDlT0Dr8l4Y1pbcpk+mE7QQjjYt3Cye81vz3v2BV0gcqvi7UU2fSrEAskE1ygJXaU60LW2D3aeD0LcS4VeZWficEwalv+nOC4vZ6w5OmUXfdl+feb4294mlOopsU2mEfw9YKrwSf3qy/KX0YJlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269090; c=relaxed/simple;
	bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHyICnKS4Emo7qdY2c4XGDAViglbn3ENz3VjvITX4EW61mKI+ZkF6poUy8ukxjTlZOjBEHeN2XGC7Gitg1+gGPWKu1HqdvIY1ksq72x6gJ/NhDRTWA0lvSFVAXxOTX3wdPETC0fcXKdFFIMXMk3mEvcDQx9yj4Sj0Qtjl2T8iIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GhHbfZXd; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhHbfZXd"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49e8361492fso302095e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269087; x=1790873887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=GhHbfZXdnENBeZ8/QAUAXp8PB+wZ7LeglKjXH1cSJas6+hZ7LyQlJ46a/XEwlJSG7l
         Zbe+K8bc3LsKoaEKQKlUsZtFU+Ja0neumAiu4Ckd0YGJPe2vlVBSD6f1B/yS/fXHgk0e
         JEvvKfR7vO2N2Ct3Vaz2/HUwkmNPwCk3EGQw1o4/fvtzzKgwENeRKju8ICLdhKcXAIW5
         NZWBU4FOHA6q3HKzsjHdZRZLrPR4JlkiosAwYyiynVMH3GRBgm7VZmlLHEI2kit0fyFW
         D5vO8mI27SFaOERlxA8GM3xXwqoYA/mrY1za4Cr/QJW/+vPMQ7yMVjJTR8xIyrDkqBs4
         Lu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269087; x=1790873887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=qqd5AOZt4WB1AxzKdpXNPyjUpFESFGwO7ZwrLUofQV9Ma+6aOe9uIUsQAMh2nR0t2r
         Wp97zjmPGD41zNoAq4s6k4eOmLt8aPGg2hdnh6XA3/vXS0yZRMabWpTYhTy8dbkTPHn1
         OLYom0YXkYin+/zdAcy5SO6YWTxjX7qy8313SjKQK2+MNMjEZ87T0e0HovMIgx67B9cn
         Q7yejgS/N+F2oAcbFK6BcX1bxPIpYDk6/in1GV9XkFqPrp0YknLVqwHguPwAtunlIfDn
         LcwsnmrOZnkeRu5CZzLD7NYGh5tva01RozHx7YznFCKPZKnJzx4+mK8EADyTpI7aK/4E
         xTrw==
X-Gm-Message-State: AFuF++lVowq0udzyGvq2edVLpWo7cbDjIDFui2KDdUGYtLPmicNGDn0N
	Wh/nJcyB8JvTH9nfuycNFpEBqVOq7UBgdHXD7VYJluVgOGuo+Tgpk9tuVnB5PZbM
X-Gm-Gg: AYBFou3anAA5ygu8yGYPbMgeAM1YCyiYR81g+ARvMrqEp6a5/Bn8uJUvybdUpgp4jfT
	/CaJVP47xQbE8H0x8c7wCdacstV9luWJPMMs9krjrUVZPIqNXlZTWI12Q1RbAKh7+FBu0+QV4Pg
	2oGeacEpITl1Kn65UaryjQdJXn/HE7OToFl9yxStXEnqNKSVM1YaLEgAaO131s+x7uqpfRuXEK4
	RPlXanqGzHYnYwuPW8WNqGXdZwLrS5NUwE47KMyqXzAQ6B0uNsucv80D1w7E2CbJ75/WimdWeCt
	TAMwG99d0RNaqUUlJ5eXKXrxyxFOaBhJk8PSGFa9mwQLxdhT8zDpeKkhRhGx4n1Ygt+t6L6sHWX
	oIy0xCDFN/5Yd07pGhYpI5YftQPKb8w80oPSCWspDg3ek1luhOMNWTjaTB+heVB8oyJ6wrLSvqr
	3o5rM+glX73as8qwx9W/AOnu3JI2Ck7v0tE4SH5RZQzhBZkNituj7Yj5LdAu5r4SstdVtwiJJ7a
	YVkVhqFMclpjUuTDf4tpjlshz4CVKt5oAS4CwqteG3v7roU3c2BH/c0W4qE2Ya+zWGK36D3wnw2
	M9p074mpQkceIGg0Sy/YE/ph0u8RWrI5FkcTAAE=
X-Received: by 2002:a05:600c:4e49:b0:49d:1cc7:5ec3 with SMTP id 5b1f17b1804b1-49fe66d456cmr49821445e9.9.1790269086767;
        Thu, 24 Sep 2026 09:58:06 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5e07bdcsm73202925e9.15.2026.09.24.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:58:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 14/18] selftests/bpf: Add load conditions on the program stack limit
Date: Thu, 24 Sep 2026 18:57:15 +0200
Message-ID: <20260924165740.2146806-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924165740.2146806-1-memxor@gmail.com>
References: <20260924165740.2146806-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6297; i=memxor@gmail.com; h=from:subject; bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtraPGNr9d4dq45+J5JgztA9d6hd049M/d0Jk0O9r6s8 26S9D6fjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzEiIPhv6tQc6B+9+v7AvoZ d9nXCzy7eO5o1Lbth8t7CzQsxKwz5jIyzPZ+7LB+XmhhavGLwjWrd8m9N89N3Nzu5FZk37FfxXc HMwA=
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

