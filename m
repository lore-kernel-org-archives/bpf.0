Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777726290
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 05:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786811; cv=none; b=VQN2K8JTdFCVlqTSrYDruKdwr02q+zTEPLC8ghnb32jbZuh+yeqLjBerDZ5PjTb4HLcZ7+BSuL4d0Ahr0G9PvC0v9SUOKnriSEQHFW7R+4G+UweRBIM0GwZwY9BConi8NfqJ9ptrANW3xuQi81pK1ZZsE08weagXA47xRezLais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786811; c=relaxed/simple;
	bh=GwG7ymq8g2X3WW/JsPxzi+zxYfwXmaZi9vO33XXr4TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfF5+jnvGVykjeP4IN9rqY6X7tV1Y/kyfdz/JJgvrlA0pnPC/1DSg7bWkoosgwMxfJyHeOO65p1UfIlNsKfD2Q6qpGYZjA4hUZypI560yPQvyb9869ajNQBBEnySJmSR2cQI2wt96SZ1A75wGFya3+/qsb9Kxg6Cy5p8P17nHtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFE20Bsh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFE20Bsh"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824a2888de5so35691b3a.0
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 21:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770786808; x=1771391608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWA9as32sewrKm6hrWoLe9SxPppDfcLRH+genZ10UVo=;
        b=WFE20BshroSzoN3G8S8M931/9L2o1PDGXMZPuqFfqVKqiwd3202l3D0SzuL9dpP1a3
         q55BOEORI0BJt3ycvVSCWyM+ACR0tvwRXeGgSaOxbEdc0es71lEk1SgpBYd+8c3hmA0U
         x8SbJZEQnVb7RQWhHZANipnVszLMw49bSU7jeRps2/ttKMTUPBFs+S2OojyHAvxlxbx+
         +TiGI0ekC7Zaz2GdMy7PQP6ECx5ro5Ppae54+gUIakACU+tdYEuOKSUbEhB1Judj0Ypq
         NcFwF+5NozFPefYD5paHW9Tzo+r8Lz9hPYGj6NJ4TWZeWLXXfAc6iLmmGik2LWuEHSYO
         VsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770786808; x=1771391608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWA9as32sewrKm6hrWoLe9SxPppDfcLRH+genZ10UVo=;
        b=UdfROLg9uPmdFdQudF0Nuz4mZr+YuuC7q8K7bXmOgDZczkN3L9jLBk/MtSPaFWsnBJ
         fWtgLG9b7M9u2D8PlW/+n/6mu0d0WjZk63tE79wwkjERGVYt4bkQs7fGxUqIVlMWTlcp
         H5OQnqUeGlzDuQ6Ws0zAzcEX5++k2X7tH0m3PzNUXEYzTbTtFAc9AXPZT6FAzQq65n3t
         vc5iuE1yhD/sHfvcL6BRd4tJq7FdHhjDVIcayQx0Dy0w/k2tA3WPsJ2abF7xLWwbDKMo
         KXJMPhqfT/RpETJeKl/kxhShWKXbXWFQZHcLMk4XIDTjfpJHQkETFYMXkyXvTwOYxa7S
         ZTmA==
X-Gm-Message-State: AOJu0YwNie3Xb7Uw/jE7YPODrYuQJwubEs3nTvxo+YJaZYMNSXnuFvxY
	zLroNlzVMgf3XyaWkDOXU6z63ru8qky5DY5bS3jEIL2eoTZzna4VYpntPSMb9w==
X-Gm-Gg: AZuq6aLEAqFILOFrs4cqDFqOt7UN5nJNLqzBBWZixbS7VDr3WMvCi+HIrOiFh39WkkO
	oivs65qnFHuTuGdagbCsVIRpbw9tfgYOL11Bm7IfNJoDm7arcrZ3XtGciy45KMdK50Ls8LPBIRz
	6lZT7U1qFaDG6f9yVQ22/QGveQ8aChAaizowCBVyLtcy5tw4qGJSB8lNjMBqYG3iuL1kMLu2YME
	8up2XorZqBodaJ0todzdcXH9Q8mr0/aTxkpsM97KYcnbt84JpIwg6WruUQlhNqElFPR2ojqKu0W
	pdNxqMt0fRP5sOeZY6I3giCMXOm7vuNzrsn6hwGjQzlP7n1skWBNAAGYfpQ75ZGTAszEZ/v+0OP
	o/3SrJjoKf0HBVOorVbIlFc9GgcnR5EMdkDSHOt8lD+B0n70+v1e4v+n5R7TLPBwJ/C/WVzCofC
	+COoGaZzdLPRk4X+7bshm3BpE8C/Brsyzycw0SzawPI/ACIfif
X-Received: by 2002:a05:6a21:730e:b0:366:14b0:4afe with SMTP id adf61e73a8af0-394158a2673mr4497822637.37.1770786807906;
        Tue, 10 Feb 2026 21:13:27 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e19500cc4sm727759a12.0.2026.02.10.21.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 21:13:27 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1] selftests/bpf: migrate align.c tests to test_loader framework
Date: Tue, 10 Feb 2026 21:13:10 -0800
Message-ID: <20260211051310.2782558-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on pointer tracking changes I found it necessary to
update expected log messages in align.c series of tests.
As a preliminary step, migrate these tests to test_loader framework.

The tests in question load BPF program and check if expected log is
produced, the log is specified as:

	.matches = {
		...
		{4, "R3", "32"},
		...
	}

Where:
- '4' is an *instruction number* (contrary to the field name in
  struct bpf_reg_match).
- 'R3' is the name of the register to check.
- '32' is the value expected for this register.

Mimic the same logic using __msg macro.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/align.c  | 712 ------------------
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_align.c      | 587 +++++++++++++++
 3 files changed, 589 insertions(+), 712 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/align.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_align.c

diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
deleted file mode 100644
index 24c509ce4e5b..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ /dev/null
@@ -1,712 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <test_progs.h>
-
-#define MAX_INSNS	512
-#define MAX_MATCHES	24
-
-struct bpf_reg_match {
-	unsigned int line;
-	const char *reg;
-	const char *match;
-};
-
-struct bpf_align_test {
-	const char *descr;
-	struct bpf_insn	insns[MAX_INSNS];
-	enum {
-		UNDEF,
-		ACCEPT,
-		REJECT
-	} result;
-	enum bpf_prog_type prog_type;
-	/* Matches must be in order of increasing line */
-	struct bpf_reg_match matches[MAX_MATCHES];
-};
-
-static struct bpf_align_test tests[] = {
-	/* Four tests of known constants.  These aren't staggeringly
-	 * interesting since we track exact values now.
-	 */
-	{
-		.descr = "mov",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_3, 2),
-			BPF_MOV64_IMM(BPF_REG_3, 4),
-			BPF_MOV64_IMM(BPF_REG_3, 8),
-			BPF_MOV64_IMM(BPF_REG_3, 16),
-			BPF_MOV64_IMM(BPF_REG_3, 32),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{0, "R1", "ctx()"},
-			{0, "R10", "fp0"},
-			{0, "R3", "2"},
-			{1, "R3", "4"},
-			{2, "R3", "8"},
-			{3, "R3", "16"},
-			{4, "R3", "32"},
-		},
-	},
-	{
-		.descr = "shift",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_3, 4),
-			BPF_MOV64_IMM(BPF_REG_4, 32),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{0, "R1", "ctx()"},
-			{0, "R10", "fp0"},
-			{0, "R3", "1"},
-			{1, "R3", "2"},
-			{2, "R3", "4"},
-			{3, "R3", "8"},
-			{4, "R3", "16"},
-			{5, "R3", "1"},
-			{6, "R4", "32"},
-			{7, "R4", "16"},
-			{8, "R4", "8"},
-			{9, "R4", "4"},
-			{10, "R4", "2"},
-		},
-	},
-	{
-		.descr = "addsub",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_3, 4),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 4),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 2),
-			BPF_MOV64_IMM(BPF_REG_4, 8),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 2),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{0, "R1", "ctx()"},
-			{0, "R10", "fp0"},
-			{0, "R3", "4"},
-			{1, "R3", "8"},
-			{2, "R3", "10"},
-			{3, "R4", "8"},
-			{4, "R4", "12"},
-			{5, "R4", "14"},
-		},
-	},
-	{
-		.descr = "mul",
-		.insns = {
-			BPF_MOV64_IMM(BPF_REG_3, 7),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, 2),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, 4),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{0, "R1", "ctx()"},
-			{0, "R10", "fp0"},
-			{0, "R3", "7"},
-			{1, "R3", "7"},
-			{2, "R3", "14"},
-			{3, "R3", "56"},
-		},
-	},
-
-	/* Tests using unknown values */
-#define PREP_PKT_POINTERS \
-	BPF_LDX_MEM(BPF_W, BPF_REG_2, BPF_REG_1, \
-		    offsetof(struct __sk_buff, data)), \
-	BPF_LDX_MEM(BPF_W, BPF_REG_3, BPF_REG_1, \
-		    offsetof(struct __sk_buff, data_end))
-
-#define LOAD_UNKNOWN(DST_REG) \
-	PREP_PKT_POINTERS, \
-	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2), \
-	BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 8), \
-	BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_0, 1), \
-	BPF_EXIT_INSN(), \
-	BPF_LDX_MEM(BPF_B, DST_REG, BPF_REG_2, 0)
-
-	{
-		.descr = "unknown shift",
-		.insns = {
-			LOAD_UNKNOWN(BPF_REG_3),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_3, 1),
-			LOAD_UNKNOWN(BPF_REG_4),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_4, 5),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_ALU64_IMM(BPF_RSH, BPF_REG_4, 1),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{6, "R0", "pkt(off=8,r=8)"},
-			{6, "R3", "var_off=(0x0; 0xff)"},
-			{7, "R3", "var_off=(0x0; 0x1fe)"},
-			{8, "R3", "var_off=(0x0; 0x3fc)"},
-			{9, "R3", "var_off=(0x0; 0x7f8)"},
-			{10, "R3", "var_off=(0x0; 0xff0)"},
-			{12, "R3", "pkt_end()"},
-			{17, "R4", "var_off=(0x0; 0xff)"},
-			{18, "R4", "var_off=(0x0; 0x1fe0)"},
-			{19, "R4", "var_off=(0x0; 0xff0)"},
-			{20, "R4", "var_off=(0x0; 0x7f8)"},
-			{21, "R4", "var_off=(0x0; 0x3fc)"},
-			{22, "R4", "var_off=(0x0; 0x1fe)"},
-		},
-	},
-	{
-		.descr = "unknown mul",
-		.insns = {
-			LOAD_UNKNOWN(BPF_REG_3),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_3),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 1),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_3),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 2),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_3),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 4),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_3),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 8),
-			BPF_ALU64_IMM(BPF_MUL, BPF_REG_4, 2),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{6, "R3", "var_off=(0x0; 0xff)"},
-			{7, "R4", "var_off=(0x0; 0xff)"},
-			{8, "R4", "var_off=(0x0; 0xff)"},
-			{9, "R4", "var_off=(0x0; 0xff)"},
-			{10, "R4", "var_off=(0x0; 0x1fe)"},
-			{11, "R4", "var_off=(0x0; 0xff)"},
-			{12, "R4", "var_off=(0x0; 0x3fc)"},
-			{13, "R4", "var_off=(0x0; 0xff)"},
-			{14, "R4", "var_off=(0x0; 0x7f8)"},
-			{15, "R4", "var_off=(0x0; 0xff0)"},
-		},
-	},
-	{
-		.descr = "packet const offset",
-		.insns = {
-			PREP_PKT_POINTERS,
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-
-			/* Skip over ethernet header.  */
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-
-			BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_5, 0),
-			BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_5, 1),
-			BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_5, 2),
-			BPF_LDX_MEM(BPF_B, BPF_REG_4, BPF_REG_5, 3),
-			BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_5, 0),
-			BPF_LDX_MEM(BPF_H, BPF_REG_4, BPF_REG_5, 2),
-			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
-
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			{2, "R5", "pkt(r=0)"},
-			{4, "R5", "pkt(off=14,r=0)"},
-			{5, "R4", "pkt(off=14,r=0)"},
-			{9, "R2", "pkt(r=18)"},
-			{10, "R5", "pkt(off=14,r=18)"},
-			{10, "R4", "var_off=(0x0; 0xff)"},
-			{13, "R4", "var_off=(0x0; 0xffff)"},
-			{14, "R4", "var_off=(0x0; 0xffff)"},
-		},
-	},
-	{
-		.descr = "packet variable offset",
-		.insns = {
-			LOAD_UNKNOWN(BPF_REG_6),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 2),
-
-			/* First, add a constant to the R5 packet pointer,
-			 * then a variable with a known alignment.
-			 */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
-
-			/* Now, test in the other direction.  Adding first
-			 * the variable offset to R5, then the constant.
-			 */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
-
-			/* Test multiple accumulations of unknown values
-			 * into a packet pointer.
-			 */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 4),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_5, 0),
-
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			/* Calculated offset in R6 has unknown value, but known
-			 * alignment of 4.
-			 */
-			{6, "R2", "pkt(r=8)"},
-			{7, "R6", "var_off=(0x0; 0x3fc)"},
-			/* Offset is added to packet pointer R5, resulting in
-			 * known fixed offset, and variable offset from R6.
-			 */
-			{11, "R5", "pkt(id=1,off=14,"},
-			/* At the time the word size load is performed from R5,
-			 * it's total offset is NET_IP_ALIGN + reg->off (0) +
-			 * reg->aux_off (14) which is 16.  Then the variable
-			 * offset is considered using reg->aux_off_align which
-			 * is 4 and meets the load's requirements.
-			 */
-			{15, "R4", "var_off=(0x0; 0x3fc)"},
-			{15, "R5", "var_off=(0x0; 0x3fc)"},
-			/* Variable offset is added to R5 packet pointer,
-			 * resulting in auxiliary alignment of 4. To avoid BPF
-			 * verifier's precision backtracking logging
-			 * interfering we also have a no-op R4 = R5
-			 * instruction to validate R5 state. We also check
-			 * that R4 is what it should be in such case.
-			 */
-			{18, "R4", "var_off=(0x0; 0x3fc)"},
-			{18, "R5", "var_off=(0x0; 0x3fc)"},
-			/* Constant offset is added to R5, resulting in
-			 * reg->off of 14.
-			 */
-			{19, "R5", "pkt(id=2,off=14,"},
-			/* At the time the word size load is performed from R5,
-			 * its total fixed offset is NET_IP_ALIGN + reg->off
-			 * (14) which is 16.  Then the variable offset is 4-byte
-			 * aligned, so the total offset is 4-byte aligned and
-			 * meets the load's requirements.
-			 */
-			{24, "R4", "var_off=(0x0; 0x3fc)"},
-			{24, "R5", "var_off=(0x0; 0x3fc)"},
-			/* Constant offset is added to R5 packet pointer,
-			 * resulting in reg->off value of 14.
-			 */
-			{26, "R5", "pkt(off=14,r=8)"},
-			/* Variable offset is added to R5, resulting in a
-			 * variable offset of (4n). See comment for insn #18
-			 * for R4 = R5 trick.
-			 */
-			{28, "R4", "var_off=(0x0; 0x3fc)"},
-			{28, "R5", "var_off=(0x0; 0x3fc)"},
-			/* Constant is added to R5 again, setting reg->off to 18. */
-			{29, "R5", "pkt(id=3,off=18,"},
-			/* And once more we add a variable; resulting var_off
-			 * is still (4n), fixed offset is not changed.
-			 * Also, we create a new reg->id.
-			 */
-			{31, "R4", "var_off=(0x0; 0x7fc)"},
-			{31, "R5", "var_off=(0x0; 0x7fc)"},
-			/* At the time the word size load is performed from R5,
-			 * its total fixed offset is NET_IP_ALIGN + reg->off (18)
-			 * which is 20.  Then the variable offset is (4n), so
-			 * the total offset is 4-byte aligned and meets the
-			 * load's requirements.
-			 */
-			{35, "R4", "var_off=(0x0; 0x7fc)"},
-			{35, "R5", "var_off=(0x0; 0x7fc)"},
-		},
-	},
-	{
-		.descr = "packet variable offset 2",
-		.insns = {
-			/* Create an unknown offset, (4n+2)-aligned */
-			LOAD_UNKNOWN(BPF_REG_6),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 2),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 14),
-			/* Add it to the packet pointer */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			/* Check bounds and perform a read */
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
-			/* Make a (4n) offset from the value we just read */
-			BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 0xff),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 2),
-			/* Add it to the packet pointer */
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			/* Check bounds and perform a read */
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			/* Calculated offset in R6 has unknown value, but known
-			 * alignment of 4.
-			 */
-			{6, "R2", "pkt(r=8)"},
-			{7, "R6", "var_off=(0x0; 0x3fc)"},
-			/* Adding 14 makes R6 be (4n+2) */
-			{8, "R6", "var_off=(0x2; 0x7fc)"},
-			/* Packet pointer has (4n+2) offset */
-			{11, "R5", "var_off=(0x2; 0x7fc)"},
-			{12, "R4", "var_off=(0x2; 0x7fc)"},
-			/* At the time the word size load is performed from R5,
-			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
-			 * which is 2.  Then the variable offset is (4n+2), so
-			 * the total offset is 4-byte aligned and meets the
-			 * load's requirements.
-			 */
-			{15, "R5", "var_off=(0x2; 0x7fc)"},
-			/* Newly read value in R6 was shifted left by 2, so has
-			 * known alignment of 4.
-			 */
-			{17, "R6", "var_off=(0x0; 0x3fc)"},
-			/* Added (4n) to packet pointer's (4n+2) var_off, giving
-			 * another (4n+2).
-			 */
-			{19, "R5", "var_off=(0x2; 0xffc)"},
-			{20, "R4", "var_off=(0x2; 0xffc)"},
-			/* At the time the word size load is performed from R5,
-			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
-			 * which is 2.  Then the variable offset is (4n+2), so
-			 * the total offset is 4-byte aligned and meets the
-			 * load's requirements.
-			 */
-			{23, "R5", "var_off=(0x2; 0xffc)"},
-		},
-	},
-	{
-		.descr = "dubious pointer arithmetic",
-		.insns = {
-			PREP_PKT_POINTERS,
-			BPF_MOV64_IMM(BPF_REG_0, 0),
-			/* (ptr - ptr) << 2 */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_3),
-			BPF_ALU64_REG(BPF_SUB, BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_5, 2),
-			/* We have a (4n) value.  Let's make a packet offset
-			 * out of it.  First add 14, to make it a (4n+2)
-			 */
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_5, 14),
-			/* Then make sure it's nonnegative */
-			BPF_JMP_IMM(BPF_JSGE, BPF_REG_5, 0, 1),
-			BPF_EXIT_INSN(),
-			/* Add it to packet pointer */
-			BPF_MOV64_REG(BPF_REG_6, BPF_REG_2),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_6, BPF_REG_5),
-			/* Check bounds and perform a read */
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_6),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_6, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.result = REJECT,
-		.matches = {
-			{3, "R5", "pkt_end()"},
-			/* (ptr - ptr) << 2 == unknown, (4n) */
-			{5, "R5", "var_off=(0x0; 0xfffffffffffffffc)"},
-			/* (4n) + 14 == (4n+2).  We blow our bounds, because
-			 * the add could overflow.
-			 */
-			{6, "R5", "var_off=(0x2; 0xfffffffffffffffc)"},
-			/* Checked s>=0 */
-			{9, "R5", "var_off=(0x2; 0x7ffffffffffffffc)"},
-			/* packet pointer + nonnegative (4n+2) */
-			{11, "R6", "var_off=(0x2; 0x7ffffffffffffffc)"},
-			{12, "R4", "var_off=(0x2; 0x7ffffffffffffffc)"},
-			/* NET_IP_ALIGN + (4n+2) == (4n), alignment is fine.
-			 * We checked the bounds, but it might have been able
-			 * to overflow if the packet pointer started in the
-			 * upper half of the address space.
-			 * So we did not get a 'range' on R6, and the access
-			 * attempt will fail.
-			 */
-			{15, "R6", "var_off=(0x2; 0x7ffffffffffffffc)"},
-		}
-	},
-	{
-		.descr = "variable subtraction",
-		.insns = {
-			/* Create an unknown offset, (4n+2)-aligned */
-			LOAD_UNKNOWN(BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_7, BPF_REG_6),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 2),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 14),
-			/* Create another unknown, (4n)-aligned, and subtract
-			 * it from the first one
-			 */
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_7, 2),
-			BPF_ALU64_REG(BPF_SUB, BPF_REG_6, BPF_REG_7),
-			/* Bounds-check the result */
-			BPF_JMP_IMM(BPF_JSGE, BPF_REG_6, 0, 1),
-			BPF_EXIT_INSN(),
-			/* Add it to the packet pointer */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_6),
-			/* Check bounds and perform a read */
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			/* Calculated offset in R6 has unknown value, but known
-			 * alignment of 4.
-			 */
-			{6, "R2", "pkt(r=8)"},
-			{8, "R6", "var_off=(0x0; 0x3fc)"},
-			/* Adding 14 makes R6 be (4n+2) */
-			{9, "R6", "var_off=(0x2; 0x7fc)"},
-			/* New unknown value in R7 is (4n) */
-			{10, "R7", "var_off=(0x0; 0x3fc)"},
-			/* Subtracting it from R6 blows our unsigned bounds */
-			{11, "R6", "var_off=(0x2; 0xfffffffffffffffc)"},
-			/* Checked s>= 0 */
-			{14, "R6", "var_off=(0x2; 0x7fc)"},
-			/* At the time the word size load is performed from R5,
-			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
-			 * which is 2.  Then the variable offset is (4n+2), so
-			 * the total offset is 4-byte aligned and meets the
-			 * load's requirements.
-			 */
-			{20, "R5", "var_off=(0x2; 0x7fc)"},
-		},
-	},
-	{
-		.descr = "pointer variable subtraction",
-		.insns = {
-			/* Create an unknown offset, (4n+2)-aligned and bounded
-			 * to [14,74]
-			 */
-			LOAD_UNKNOWN(BPF_REG_6),
-			BPF_MOV64_REG(BPF_REG_7, BPF_REG_6),
-			BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 0xf),
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_6, 2),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_6, 14),
-			/* Subtract it from the packet pointer */
-			BPF_MOV64_REG(BPF_REG_5, BPF_REG_2),
-			BPF_ALU64_REG(BPF_SUB, BPF_REG_5, BPF_REG_6),
-			/* Create another unknown, (4n)-aligned and >= 74.
-			 * That in fact means >= 76, since 74 % 4 == 2
-			 */
-			BPF_ALU64_IMM(BPF_LSH, BPF_REG_7, 2),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_7, 76),
-			/* Add it to the packet pointer */
-			BPF_ALU64_REG(BPF_ADD, BPF_REG_5, BPF_REG_7),
-			/* Check bounds and perform a read */
-			BPF_MOV64_REG(BPF_REG_4, BPF_REG_5),
-			BPF_ALU64_IMM(BPF_ADD, BPF_REG_4, 4),
-			BPF_JMP_REG(BPF_JGE, BPF_REG_3, BPF_REG_4, 1),
-			BPF_EXIT_INSN(),
-			BPF_LDX_MEM(BPF_W, BPF_REG_6, BPF_REG_5, 0),
-			BPF_EXIT_INSN(),
-		},
-		.prog_type = BPF_PROG_TYPE_SCHED_CLS,
-		.matches = {
-			/* Calculated offset in R6 has unknown value, but known
-			 * alignment of 4.
-			 */
-			{6, "R2", "pkt(r=8)"},
-			{9, "R6", "var_off=(0x0; 0x3c)"},
-			/* Adding 14 makes R6 be (4n+2) */
-			{10, "R6", "var_off=(0x2; 0x7c)"},
-			/* Subtracting from packet pointer overflows ubounds */
-			{13, "R5", "var_off=(0xffffffffffffff82; 0x7c)"},
-			/* New unknown value in R7 is (4n), >= 76 */
-			{14, "R7", "var_off=(0x0; 0x7fc)"},
-			/* Adding it to packet pointer gives nice bounds again */
-			{16, "R5", "var_off=(0x2; 0x7fc)"},
-			/* At the time the word size load is performed from R5,
-			 * its total fixed offset is NET_IP_ALIGN + reg->off (0)
-			 * which is 2.  Then the variable offset is (4n+2), so
-			 * the total offset is 4-byte aligned and meets the
-			 * load's requirements.
-			 */
-			{20, "R5", "var_off=(0x2; 0x7fc)"},
-		},
-	},
-};
-
-static int probe_filter_length(const struct bpf_insn *fp)
-{
-	int len;
-
-	for (len = MAX_INSNS - 1; len > 0; --len)
-		if (fp[len].code != 0 || fp[len].imm != 0)
-			break;
-	return len + 1;
-}
-
-static char bpf_vlog[32768];
-
-static int do_test_single(struct bpf_align_test *test)
-{
-	struct bpf_insn *prog = test->insns;
-	int prog_type = test->prog_type;
-	char bpf_vlog_copy[32768];
-	LIBBPF_OPTS(bpf_prog_load_opts, opts,
-		.prog_flags = BPF_F_STRICT_ALIGNMENT,
-		.log_buf = bpf_vlog,
-		.log_size = sizeof(bpf_vlog),
-		.log_level = 2,
-	);
-	const char *main_pass_start = "0: R1=ctx() R10=fp0";
-	const char *line_ptr;
-	int cur_line = -1;
-	int prog_len, i;
-	char *start;
-	int fd_prog;
-	int ret;
-
-	prog_len = probe_filter_length(prog);
-	fd_prog = bpf_prog_load(prog_type ? : BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL",
-				prog, prog_len, &opts);
-	if (fd_prog < 0 && test->result != REJECT) {
-		printf("Failed to load program.\n");
-		printf("%s", bpf_vlog);
-		ret = 1;
-	} else if (fd_prog >= 0 && test->result == REJECT) {
-		printf("Unexpected success to load!\n");
-		printf("%s", bpf_vlog);
-		ret = 1;
-		close(fd_prog);
-	} else {
-		ret = 0;
-		/* We make a local copy so that we can strtok() it */
-		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
-		start = strstr(bpf_vlog_copy, main_pass_start);
-		if (!start) {
-			ret = 1;
-			printf("Can't find initial line '%s'\n", main_pass_start);
-			goto out;
-		}
-		line_ptr = strtok(start, "\n");
-		for (i = 0; i < MAX_MATCHES; i++) {
-			struct bpf_reg_match m = test->matches[i];
-			const char *p;
-			int tmp;
-
-			if (!m.match)
-				break;
-			while (line_ptr) {
-				cur_line = -1;
-				sscanf(line_ptr, "%u: ", &cur_line);
-				if (cur_line == -1)
-					sscanf(line_ptr, "from %u to %u: ", &tmp, &cur_line);
-				if (cur_line == m.line)
-					break;
-				line_ptr = strtok(NULL, "\n");
-			}
-			if (!line_ptr) {
-				printf("Failed to find line %u for match: %s=%s\n",
-				       m.line, m.reg, m.match);
-				ret = 1;
-				printf("%s", bpf_vlog);
-				break;
-			}
-			/* Check the next line as well in case the previous line
-			 * did not have a corresponding bpf insn. Example:
-			 * func#0 @0
-			 * 0: R1=ctx() R10=fp0
-			 * 0: (b7) r3 = 2                 ; R3_w=2
-			 *
-			 * Sometimes it's actually two lines below, e.g. when
-			 * searching for "6: R3_w=scalar(umax=255,var_off=(0x0; 0xff))":
-			 *   from 4 to 6: R0_w=pkt(off=8,r=8) R1=ctx() R2_w=pkt(r=8) R3_w=pkt_end() R10=fp0
-			 *   6: R0_w=pkt(off=8,r=8) R1=ctx() R2_w=pkt(r=8) R3_w=pkt_end() R10=fp0
-			 *   6: (71) r3 = *(u8 *)(r2 +0)           ; R2_w=pkt(r=8) R3_w=scalar(umax=255,var_off=(0x0; 0xff))
-			 */
-			while (!(p = strstr(line_ptr, m.reg)) || !strstr(p, m.match)) {
-				cur_line = -1;
-				line_ptr = strtok(NULL, "\n");
-				sscanf(line_ptr ?: "", "%u: ", &cur_line);
-				if (!line_ptr || cur_line != m.line)
-					break;
-			}
-			if (cur_line != m.line || !line_ptr || !(p = strstr(line_ptr, m.reg)) || !strstr(p, m.match)) {
-				printf("Failed to find match %u: %s=%s\n", m.line, m.reg, m.match);
-				ret = 1;
-				printf("%s", bpf_vlog);
-				break;
-			}
-		}
-out:
-		if (fd_prog >= 0)
-			close(fd_prog);
-	}
-	return ret;
-}
-
-void test_align(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		struct bpf_align_test *test = &tests[i];
-
-		if (!test__start_subtest(test->descr))
-			continue;
-
-		ASSERT_OK(do_test_single(test), test->descr);
-	}
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 302286a80154..8cdfd74c95d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "cap_helpers.h"
+#include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
@@ -149,6 +150,7 @@ static void run_tests_aux(const char *skel_name,
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
+void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_align.c b/tools/testing/selftests/bpf/progs/verifier_align.c
new file mode 100644
index 000000000000..90362d61f1fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_align.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+/* Converted from tools/testing/selftests/bpf/prog_tests/align.c */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* Four tests of known constants.  These aren't staggeringly
+ * interesting since we track exact values now.
+ */
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+__msg("0: R1=ctx() R10=fp0")
+__msg("0: {{.*}} R3=2")
+__msg("1: {{.*}} R3=4")
+__msg("2: {{.*}} R3=8")
+__msg("3: {{.*}} R3=16")
+__msg("4: {{.*}} R3=32")
+__naked void mov(void)
+{
+	asm volatile ("					\
+	r3 = 2;						\
+	r3 = 4;						\
+	r3 = 8;						\
+	r3 = 16;					\
+	r3 = 32;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+__msg("0: R1=ctx() R10=fp0")
+__msg("0: {{.*}}R3=1")
+__msg("1: {{.*}}R3=2")
+__msg("2: {{.*}}R3=4")
+__msg("3: {{.*}}R3=8")
+__msg("4: {{.*}}R3=16")
+__msg("5: {{.*}}R3=1")
+__msg("6: {{.*}}R4=32")
+__msg("7: {{.*}}R4=16")
+__msg("8: {{.*}}R4=8")
+__msg("9: {{.*}}R4=4")
+__msg("10: {{.*}}R4=2")
+__naked void shift(void)
+{
+	asm volatile ("					\
+	r3 = 1;						\
+	r3 <<= 1;					\
+	r3 <<= 1;					\
+	r3 <<= 1;					\
+	r3 <<= 1;					\
+	r3 >>= 4;					\
+	r4 = 32;					\
+	r4 >>= 1;					\
+	r4 >>= 1;					\
+	r4 >>= 1;					\
+	r4 >>= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+__msg("0: R1=ctx() R10=fp0")
+__msg("0: {{.*}}R3=4")
+__msg("1: {{.*}}R3=8")
+__msg("2: {{.*}}R3=10")
+__msg("3: {{.*}}R4=8")
+__msg("4: {{.*}}R4=12")
+__msg("5: {{.*}}R4=14")
+__naked void addsub(void)
+{
+	asm volatile ("					\
+	r3 = 4;						\
+	r3 += 4;					\
+	r3 += 2;					\
+	r4 = 8;						\
+	r4 += 4;					\
+	r4 += 2;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+__msg("0: R1=ctx() R10=fp0")
+__msg("0: {{.*}}R3=7")
+__msg("1: {{.*}}R3=7")
+__msg("2: {{.*}}R3=14")
+__msg("3: {{.*}}R3=56")
+__naked void mul(void)
+{
+	asm volatile ("					\
+	r3 = 7;						\
+	r3 *= 1;					\
+	r3 *= 2;					\
+	r3 *= 4;					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/* Tests using unknown values */
+
+#define PREP_PKT_POINTERS				\
+	"r2 = *(u32*)(r1 + %[__sk_buff_data]);"		\
+	"r3 = *(u32*)(r1 + %[__sk_buff_data_end]);"
+
+#define __LOAD_UNKNOWN(DST_REG, LBL)			\
+	"r2 = *(u32*)(r1 + %[__sk_buff_data]);"		\
+	"r3 = *(u32*)(r1 + %[__sk_buff_data_end]);"	\
+	"r0 = r2;"					\
+	"r0 += 8;"					\
+	"if r3 >= r0 goto " LBL ";"			\
+	"exit;"						\
+LBL ":"							\
+	DST_REG " = *(u8*)(r2 + 0);"
+
+#define LOAD_UNKNOWN(DST_REG) __LOAD_UNKNOWN(DST_REG, "l99_%=")
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+__msg("6: R0=pkt(off=8,r=8)")
+__msg("6: {{.*}} R3={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("7: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x1fe)")
+__msg("8: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x3fc)")
+__msg("9: {{.*}} R3={{[^)]*}}var_off=(0x0; 0x7f8)")
+__msg("10: {{.*}} R3={{[^)]*}}var_off=(0x0; 0xff0)")
+__msg("12: {{.*}} R3=pkt_end()")
+__msg("17: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("18: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x1fe0)")
+__msg("19: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff0)")
+__msg("20: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x7f8)")
+__msg("21: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc)")
+__msg("22: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x1fe)")
+__naked void unknown_shift(void)
+{
+	asm volatile ("					\
+	" __LOAD_UNKNOWN("r3", "l99_%=") "		\
+	r3 <<= 1;					\
+	r3 <<= 1;					\
+	r3 <<= 1;					\
+	r3 <<= 1;					\
+	" __LOAD_UNKNOWN("r4", "l98_%=") "		\
+	r4 <<= 5;					\
+	r4 >>= 1;					\
+	r4 >>= 1;					\
+	r4 >>= 1;					\
+	r4 >>= 1;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+__msg("6: {{.*}} R3={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("7: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("8: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("9: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("10: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x1fe)")
+__msg("11: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("12: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc)")
+__msg("13: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff)")
+__msg("14: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x7f8)")
+__msg("15: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff0)")
+__naked void unknown_mul(void)
+{
+	asm volatile ("					\
+	" LOAD_UNKNOWN("r3") "				\
+	r4 = r3;					\
+	r4 *= 1;					\
+	r4 = r3;					\
+	r4 *= 2;					\
+	r4 = r3;					\
+	r4 *= 4;					\
+	r4 = r3;					\
+	r4 *= 8;					\
+	r4 *= 2;					\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__msg("2: {{.*}} R5=pkt(r=0)")
+__msg("4: {{.*}} R5=pkt(off=14,r=0)")
+__msg("5: {{.*}} R4=pkt(off=14,r=0)")
+__msg("9: {{.*}} R2=pkt(r=18)")
+__msg("10: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xff){{.*}} R5=pkt(off=14,r=18)")
+__msg("13: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xffff)")
+__msg("14: {{.*}} R4={{[^)]*}}var_off=(0x0; 0xffff)")
+__naked void packet_const_offset(void)
+{
+	asm volatile ("					\
+	" PREP_PKT_POINTERS "				\
+	r5 = r2;					\
+	r0 = 0;						\
+	/* Skip over ethernet header.  */		\
+	r5 += 14;					\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l0_%=;				\
+	exit;						\
+l0_%=:	r4 = *(u8*)(r5 + 0);				\
+	r4 = *(u8*)(r5 + 1);				\
+	r4 = *(u8*)(r5 + 2);				\
+	r4 = *(u8*)(r5 + 3);				\
+	r4 = *(u16*)(r5 + 0);				\
+	r4 = *(u16*)(r5 + 2);				\
+	r4 = *(u32*)(r5 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+/* Calculated offset in R6 has unknown value, but known
+ * alignment of 4.
+ */
+__msg("6: {{.*}} R2=pkt(r=8)")
+__msg("7: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Offset is added to packet pointer R5, resulting in
+ * known fixed offset, and variable offset from R6.
+ */
+__msg("11: {{.*}} R5=pkt(id=1,off=14,")
+/* At the time the word size load is performed from R5,
+ * it's total offset is NET_IP_ALIGN + reg->off (0) +
+ * reg->aux_off (14) which is 16.  Then the variable
+ * offset is considered using reg->aux_off_align which
+ * is 4 and meets the load's requirements.
+ */
+__msg("15: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Variable offset is added to R5 packet pointer,
+ * resulting in auxiliary alignment of 4. To avoid BPF
+ * verifier's precision backtracking logging
+ * interfering we also have a no-op R4 = R5
+ * instruction to validate R5 state. We also check
+ * that R4 is what it should be in such case.
+ */
+__msg("18: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Constant offset is added to R5, resulting in
+ * reg->off of 14.
+ */
+__msg("19: {{.*}} R5=pkt(id=2,off=14,")
+/* At the time the word size load is performed from R5,
+ * its total fixed offset is NET_IP_ALIGN + reg->off
+ * (14) which is 16.  Then the variable offset is 4-byte
+ * aligned, so the total offset is 4-byte aligned and
+ * meets the load's requirements.
+ */
+__msg("24: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Constant offset is added to R5 packet pointer,
+ * resulting in reg->off value of 14.
+ */
+__msg("26: {{.*}} R5=pkt(off=14,r=8)")
+/* Variable offset is added to R5, resulting in a
+ * variable offset of (4n). See comment for insn #18
+ * for R4 = R5 trick.
+ */
+__msg("28: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x3fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Constant is added to R5 again, setting reg->off to 18. */
+__msg("29: {{.*}} R5=pkt(id=3,off=18,")
+/* And once more we add a variable; resulting {{[^)]*}}var_off
+ * is still (4n), fixed offset is not changed.
+ * Also, we create a new reg->id.
+ */
+__msg("31: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x7fc)")
+/* At the time the word size load is performed from R5,
+ * its total fixed offset is NET_IP_ALIGN + reg->off (18)
+ * which is 20.  Then the variable offset is (4n), so
+ * the total offset is 4-byte aligned and meets the
+ * load's requirements.
+ */
+__msg("35: {{.*}} R4={{[^)]*}}var_off=(0x0; 0x7fc){{.*}} R5={{[^)]*}}var_off=(0x0; 0x7fc)")
+__naked void packet_variable_offset(void)
+{
+	asm volatile ("					\
+	" LOAD_UNKNOWN("r6") "				\
+	r6 <<= 2;					\
+	/* First, add a constant to the R5 packet pointer,\
+	 * then a variable with a known alignment.	\
+	 */						\
+	r5 = r2;					\
+	r5 += 14;					\
+	r5 += r6;					\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l0_%=;				\
+	exit;						\
+l0_%=:	r4 = *(u32*)(r5 + 0);				\
+	/* Now, test in the other direction.  Adding first\
+	 * the variable offset to R5, then the constant.\
+	 */						\
+	r5 = r2;					\
+	r5 += r6;					\
+	r4 = r5;					\
+	r5 += 14;					\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l1_%=;				\
+	exit;						\
+l1_%=:	r4 = *(u32*)(r5 + 0);				\
+	/* Test multiple accumulations of unknown values\
+	 * into a packet pointer.			\
+	 */						\
+	r5 = r2;					\
+	r5 += 14;					\
+	r5 += r6;					\
+	r4 = r5;					\
+	r5 += 4;					\
+	r5 += r6;					\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l2_%=;				\
+	exit;						\
+l2_%=:	r4 = *(u32*)(r5 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+/* Calculated offset in R6 has unknown value, but known
+ * alignment of 4.
+ */
+__msg("6: {{.*}} R2=pkt(r=8)")
+__msg("7: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Adding 14 makes R6 be (4n+2) */
+__msg("8: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7fc)")
+/* Packet pointer has (4n+2) offset */
+__msg("11: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+__msg("12: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7fc)")
+/* At the time the word size load is performed from R5,
+ * its total fixed offset is NET_IP_ALIGN + reg->off (0)
+ * which is 2.  Then the variable offset is (4n+2), so
+ * the total offset is 4-byte aligned and meets the
+ * load's requirements.
+ */
+__msg("15: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+/* Newly read value in R6 was shifted left by 2, so has
+ * known alignment of 4.
+ */
+__msg("17: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Added (4n) to packet pointer's (4n+2) {{[^)]*}}var_off, giving
+ * another (4n+2).
+ */
+__msg("19: {{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
+__msg("20: {{.*}} R4={{[^)]*}}var_off=(0x2; 0xffc)")
+/* At the time the word size load is performed from R5,
+ * its total fixed offset is NET_IP_ALIGN + reg->off (0)
+ * which is 2.  Then the variable offset is (4n+2), so
+ * the total offset is 4-byte aligned and meets the
+ * load's requirements.
+ */
+__msg("23: {{.*}} R5={{[^)]*}}var_off=(0x2; 0xffc)")
+__naked void packet_variable_offset_2(void)
+{
+	asm volatile ("					\
+	/* Create an unknown offset, (4n+2)-aligned */	\
+	" LOAD_UNKNOWN("r6") "			\
+	r6 <<= 2;					\
+	r6 += 14;					\
+	/* Add it to the packet pointer */		\
+	r5 = r2;					\
+	r5 += r6;					\
+	/* Check bounds and perform a read */		\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = *(u32*)(r5 + 0);				\
+	/* Make a (4n) offset from the value we just read */\
+	r6 &= 0xff;					\
+	r6 <<= 2;					\
+	/* Add it to the packet pointer */		\
+	r5 += r6;					\
+	/* Check bounds and perform a read */		\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l1_%=;				\
+	exit;						\
+l1_%=:	r6 = *(u32*)(r5 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __log_level(2)
+__msg("3: {{.*}} R5=pkt_end()")
+/* (ptr - ptr) << 2 == unknown, (4n) */
+__msg("5: {{.*}} R5={{[^)]*}}var_off=(0x0; 0xfffffffffffffffc)")
+/* (4n) + 14 == (4n+2).  We blow our bounds, because
+ * the add could overflow.
+ */
+__msg("6: {{.*}} R5={{[^)]*}}var_off=(0x2; 0xfffffffffffffffc)")
+/* Checked s>=0 */
+__msg("9: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
+/* packet pointer + nonnegative (4n+2) */
+__msg("11: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
+__msg("12: {{.*}} R4={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
+/* NET_IP_ALIGN + (4n+2) == (4n), alignment is fine.
+ * We checked the bounds, but it might have been able
+ * to overflow if the packet pointer started in the
+ * upper half of the address space.
+ * So we did not get a 'range' on R6, and the access
+ * attempt will fail.
+ */
+__msg("15: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7ffffffffffffffc)")
+__naked void dubious_pointer_arithmetic(void)
+{
+	asm volatile ("					\
+	" PREP_PKT_POINTERS "				\
+	r0 = 0;						\
+	/* (ptr - ptr) << 2 */				\
+	r5 = r3;					\
+	r5 -= r2;					\
+	r5 <<= 2;					\
+	/* We have a (4n) value.  Let's make a packet offset\
+	 * out of it.  First add 14, to make it a (4n+2)\
+	 */						\
+	r5 += 14;					\
+	/* Then make sure it's nonnegative */		\
+	if r5 s>= 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	/* Add it to packet pointer */			\
+	r6 = r2;					\
+	r6 += r5;					\
+	/* Check bounds and perform a read */		\
+	r4 = r6;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l1_%=;				\
+	exit;						\
+l1_%=:	r4 = *(u32*)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+/* Calculated offset in R6 has unknown value, but known
+ * alignment of 4.
+ */
+__msg("6: {{.*}} R2=pkt(r=8)")
+__msg("8: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Adding 14 makes R6 be (4n+2) */
+__msg("9: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7fc)")
+/* New unknown value in R7 is (4n) */
+__msg("10: {{.*}} R7={{[^)]*}}var_off=(0x0; 0x3fc)")
+/* Subtracting it from R6 blows our unsigned bounds */
+__msg("11: {{.*}} R6={{[^)]*}}var_off=(0x2; 0xfffffffffffffffc)")
+/* Checked s>= 0 */
+__msg("14: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7fc)")
+/* At the time the word size load is performed from R5,
+ * its total fixed offset is NET_IP_ALIGN + reg->off (0)
+ * which is 2.  Then the variable offset is (4n+2), so
+ * the total offset is 4-byte aligned and meets the
+ * load's requirements.
+ */
+__msg("20: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+__naked void variable_subtraction(void)
+{
+	asm volatile ("					\
+	/* Create an unknown offset, (4n+2)-aligned */	\
+	" LOAD_UNKNOWN("r6") "				\
+	r7 = r6;					\
+	r6 <<= 2;					\
+	r6 += 14;					\
+	/* Create another unknown, (4n)-aligned, and subtract\
+	 * it from the first one			\
+	 */						\
+	r7 <<= 2;					\
+	r6 -= r7;					\
+	/* Bounds-check the result */			\
+	if r6 s>= 0 goto l0_%=;				\
+	exit;						\
+l0_%=:	/* Add it to the packet pointer */		\
+	r5 = r2;					\
+	r5 += r6;					\
+	/* Check bounds and perform a read */		\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l1_%=;				\
+	exit;						\
+l1_%=:	r6 = *(u32*)(r5 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __log_level(2)
+__flag(BPF_F_ANY_ALIGNMENT)
+/* Calculated offset in R6 has unknown value, but known
+ * alignment of 4.
+ */
+__msg("6: {{.*}} R2=pkt(r=8)")
+__msg("9: {{.*}} R6={{[^)]*}}var_off=(0x0; 0x3c)")
+/* Adding 14 makes R6 be (4n+2) */
+__msg("10: {{.*}} R6={{[^)]*}}var_off=(0x2; 0x7c)")
+/* Subtracting from packet pointer overflows ubounds */
+__msg("13: R5={{[^)]*}}var_off=(0xffffffffffffff82; 0x7c)")
+/* New unknown value in R7 is (4n), >= 76 */
+__msg("14: {{.*}} R7={{[^)]*}}var_off=(0x0; 0x7fc)")
+/* Adding it to packet pointer gives nice bounds again */
+__msg("16: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+/* At the time the word size load is performed from R5,
+ * its total fixed offset is NET_IP_ALIGN + reg->off (0)
+ * which is 2.  Then the variable offset is (4n+2), so
+ * the total offset is 4-byte aligned and meets the
+ * load's requirements.
+ */
+__msg("20: {{.*}} R5={{[^)]*}}var_off=(0x2; 0x7fc)")
+__naked void pointer_variable_subtraction(void)
+{
+	asm volatile ("					\
+	/* Create an unknown offset, (4n+2)-aligned and bounded\
+	 * to [14,74]					\
+	 */						\
+	" LOAD_UNKNOWN("r6") "				\
+	r7 = r6;					\
+	r6 &= 0xf;					\
+	r6 <<= 2;					\
+	r6 += 14;					\
+	/* Subtract it from the packet pointer */	\
+	r5 = r2;					\
+	r5 -= r6;					\
+	/* Create another unknown, (4n)-aligned and >= 74.\
+	 * That in fact means >= 76, since 74 mod 4 == 2\
+	 */						\
+	r7 <<= 2;					\
+	r7 += 76;					\
+	/* Add it to the packet pointer */		\
+	r5 += r7;					\
+	/* Check bounds and perform a read */		\
+	r4 = r5;					\
+	r4 += 4;					\
+	if r3 >= r4 goto l0_%=;				\
+	exit;						\
+l0_%=:	r6 = *(u32*)(r5 + 0);				\
+	exit;						\
+"	:
+	: __imm_const(__sk_buff_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(__sk_buff_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.51.1

