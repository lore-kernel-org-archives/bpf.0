Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72E743E487
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238398; cv=none; b=aToj/RNSvblzxWpwR5hsfZR9dUURqjWQmq3hnq0ee4R24Wv5NaGF0tIyfO7mIlsGrPvEYegEaPmiKt5zpTH6s/EHvY5Uvhl60sU3pb05wOoLLVaqSvXQXMBGFzNFC99I0IbepqmrKm18OzpPDJ1XhbHPi2jYhUv/7QuGCgezInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238398; c=relaxed/simple;
	bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4O2fqzC/0RPibnfJne0ljEp9478rWQBiNs5ILFcjLxW53AtcRydjpuMg2p3mQZifszLbIMME2xn/jIMhBPCmiB5/pQvPHh/uE/8dJa9nGo9EuAD8x/e+t46/3h672fiF5JaLpIWP786kKTTZJqDiSyew24kl9soTg+U9B0ovgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGtRpnlv; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGtRpnlv"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so6321845e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 01:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790238395; x=1790843195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=TGtRpnlvs5M1/Yl1w4Y3mi7yvBx9EfSFUkq04wepMCTVfUJaqKp5VBfn1WmZxKoAIi
         QI3YyBsA+HXTsSUrwae3ItsaNFJ4WsgErsyg9AEEvQhVV7WUMtbiW37mFd3xk7r8RSKs
         tKBINia1wzlnZwpwTMJnuWVk2REkgrahkj2lE92dMJrWeLaUv5/gOJvlBcppfzMkUeMn
         sIydDSzdOuqUOIeYE0UqeL2r3uU6eiIKpaA5RZbTd5Eoj5LXzMq86+eQfqh3+PId2r6q
         v9LvuaIxYsB5JVv4enePzS/yPQh9/qXJiE5OcdqhrDuud96+JgvcdkCTXbj78fsccSjb
         ynSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790238395; x=1790843195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZR0ugLKXWVt3Wd0kl+0FD2/mB9z6fVu7ANDQcj4+h0=;
        b=nJtUlRrZRQmrBrHzTycvZfHigsYUA+xPH9qS3xZzUgHIoQp81OTkViqQMRUloQNLzd
         zKcyh98iZpTBOeT12JMpqUc45jWtdbMpeNBRbuQ6qbpjjVhyd0LZJ47F7SPK3o2I0ov0
         NSk3GQCiE13Thal8RQv2jX0e+v5E/RIi5Tuz0OXsx7Au/ZcELs1azLPYbAeW05wUqkj+
         Kmp8b3FlJ/RIHygW8cotau3pSjgHnbPh0UOtyuOeaC6jyys3N4NEkpdfj4JEdSMWKSME
         sjBnSssjs10GnKNO7qmvA09kvukE0+JoYBaDyQSwr+J0tIQZVA5vih2ZbNG1TzRz9lWr
         foCA==
X-Gm-Message-State: AFuF++lcutdVSgaB9ypgza4vQcmqklzMOpwg65Ge1Kj8m08Rmao3J2hL
	sOVcC9z63P9+o9KTMBUYu+ezqtyGkXyyNqYJEKvuvYcnCE8UQb0ZsV1LF2PdvyZl
X-Gm-Gg: AYBFou15vdqUmqU7LfzgBF3oxyWxA2SUFLNRSCtW4Y4ekPjilnoiluzXyxio4ELgu+o
	PgdoLUCyKk12FkSCyUYM+lz4dNaoeYf8qmc/xQqFpP+QGJET1qoGyZsfwWhI8LIKpULwBx/21mL
	frjFUOWQvnghegRmLxPUj0xuCUSAr4v+F1XNFJ6CN+9JUZOgWqNHWM11gG/NiQ2eVXVEv2HBdwt
	Z5sH2M3p7anN4kcPYHKUI2+dpXX0VMpFIfHrYjuCzecZJp2MVLmgwVk9X9dVOVW2QgS4BqJd7uW
	fpU0mqPdJ5+GlfiKRC2o2DbQkptHPwnrnZwSGX/4p8vY3zg2nc2ExIY9EeU9dr7uQ2D9gK2k6kG
	gX8ag4qrvZ9b8v0prqt4+wDwvqPkg0DtCzWjBOVqz0zcsWf2OzswLvn7RSoZsq40ttSaIhEHEKZ
	6tvwAzjmkql0Tz0ohR6gztbiigzfEKYxsHxPL9j2d6F7uxeJa/jjd1chwAz41l8Xz/Z+y15uwQe
	tPLKk3k9GaUi0WKNe9LRzNALRP71v5MGqZ0zcjtx3nT1pZ6LKcLRpxuB6iPdnZsCN2FUXvt7SBE
	tFvX8VdTBu5a1QLXR8PI9ErpnCXPsKk0B1Ak4Q==
X-Received: by 2002:a05:600c:8b26:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fe66d83camr31272175e9.15.1790238394538;
        Thu, 24 Sep 2026 01:26:34 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm102490105e9.0.2026.09.24.01.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:26:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 14/18] selftests/bpf: Add load conditions on the program stack limit
Date: Thu, 24 Sep 2026 10:25:50 +0200
Message-ID: <20260924082607.2695649-15-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924082607.2695649-1-memxor@gmail.com>
References: <20260924082607.2695649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6297; i=memxor@gmail.com; h=from:subject; bh=SjnBPu0576uU4MH3+Alb4L6ywPPOos6QjPiuwYGQmfA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvLvdQbX6/x7Fxz8D2TBneA6r1D75x6Zu7pTJoc7H1Z5 90k6X0+HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjI0ZOMDA06J99uSotx2nRM c3P8eq0NLlW2XY5iycdNeWWSv165UMTw36+PfVXFefNJd+tLw9Jvmu8x3HLKutHmwPf6lX83zij 8yQcA
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

