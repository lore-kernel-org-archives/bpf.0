Received: from mail-wm2-f7.google.com (mail-wm2-f7.google.com [74.125.225.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8561449B06
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242200; cv=none; b=CnkVUGjn8JLkIVwUjiCnShQLXPoIWBYequUl4H2Igr3bMKHc7Y/E+4m5Q2/beacPwKVgaPVYFgOT45gfhyusbbi/YqSU1LpCqFVpZ3PfalhU6GYIPNvBNnBKbYaTm2f/udJt3/vu3SthRuWqtcu+iaie70D6JiYKn8dFwK5bOTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242200; c=relaxed/simple;
	bh=z9SoyzBe2zOgXvOjzEhbpdsikzbx40if1WujuTr3rrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YreEw/xM225Cm04Tbu7l+ZxU0Lf2+aNAtqqs5e9UfPQqImvDKcEoO1GGmJE57bqnNhIGxf5WJrLk0Q+vwkBl/QS7e0UoHR8JoZfkB6UOoTShH/yMSt4dRfcknc37tptz2hHsptYYx58RrLT4P5yaR2thKaPgdO8Zq3/TbtDYwa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGZKUBHe; arc=none smtp.client-ip=74.125.225.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGZKUBHe"
Received: by mail-wm2-f7.google.com with SMTP id 5b1f17b1804b1-49fd76faff2so624625e9.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242196; x=1790846996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2vkIEoBAnyRVf/HngJ6jnughGYdc5yjITt8XvcUlVQM=;
        b=eGZKUBHe65LBlQSxbY2CRJ+rHWSB5C6S1civenphSgaHbBW6fX5ki0GJ5Yvt/68tjy
         Odbllzc2HQyyA2r8alMW0VJpluFhqV1ZO7pbE/eFcHr/2zrWxKKaiRbvR096CN3juRho
         P8YgttZ26fogANlUrRWxIyBfv+9fZpcDWTw9JeJ00I86+nD99iEka9AOCNAWYFr2xNUs
         TkRVU2E+OoB94kK4TssgBY5P5rvLCsrzuJC+sKfiszP5/tpYrVSoWODD7wAD1dHuUHqc
         d3k6HgIBaftvJeh623MCXSCHPXNc7x6U7j1ZPb8uYXiSN977i8R+Bm4IVEOXsuEM887g
         gFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242196; x=1790846996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2vkIEoBAnyRVf/HngJ6jnughGYdc5yjITt8XvcUlVQM=;
        b=mQIen8WgzbbPCKu4V6eO3K1anL1vY9cda2ANbLkgZP1tv+knPV1fnFtgfkkDuGlDMJ
         Z+arveqW9mT4hEtA0yW8OGbWQt4su9qWunz72w0Rjt4jGj8LyrPxH7B41s4ejyrmpu8Y
         bfg+q+7ip2smypPTCT45z3Alr9/PslSi8OJ238Uhzt2Mya/2Monwb8/WD1qMdacoBCp3
         acUvIBVvPvpXVHZa7ylWxHmiW+13KcaLhccxKeEITomwbHhRnQNZZ75KYnVVCrT+MzWG
         R1nv4/BZHwjIo32RNUq4ZfZrOUZD6fCxTbUye5Q53GG/NL/EjPTGhWArwyDkk2nceAEm
         E3dQ==
X-Gm-Message-State: AFuF++kY/ar0Xi0/5uphQhgzLaLgiS+PqPVs6zHrtKOSx8cstje9whZW
	9DUNwIAU8Aoi0uk73fi+732lQVVvAA5RI6cIFNY34ilcC+z40Q9E2P9jrcn43f7D
X-Gm-Gg: AYBFou3MsJGMKiWfSs3omdZCQ055S8Ag3BChRi3xOTC1NrYRcJ9hBD7dThZuBsE4ZIv
	zmuV0wyhGJdnHMa6suc46ncfw2FCKzGqkRXj7du/snRh/lFUpBTOSvOBSSkzi7J4axOvyTlkuX5
	RRBglLVbKkFBY3BTKkEKHK2VpRUaQICE2wRqekc4ej7KloiarbfXSi3+ihKa0UjjaZSV1TdYH0Q
	suIuYQkJKvLzdo618OoKmzU0IK6z7zzzHx/yYDl3EWhrokU43qD8ideWbXW5bSxetS6Iv1urY8/
	JNXbiNZFdfUWQQGcw0X585Pcas6g9MIk1tJ8d62TdYwhRdqVKbnUlsG+ETqizAjKSI8boNMR4sh
	26REGYcUuB0E4qrNF9cRVHXRIztK6tSahP9xuk8ttdGZ3+jvz/dnmBvWUVxwTGFYlN3eT097B7k
	zerhuRzvNtGQqZjf20eRE9UGEnZKKWWND7NRkmwekLN8LS2Vkik2bdbLUlzGEbtOzaTMTsvMMl2
	34iovImSd+u0U65EcFyuBq1q4U9+KJHM+gose4G4nFlnuHtDp2It9+wDVfWtvIUijjNrc0L4gSb
	otkvghtx+Lx+eNB5iPi5QqB9bvOyAdzi4rp8rQ==
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49fe66ca6f5mr33092775e9.0.1790242195817;
        Thu, 24 Sep 2026 02:29:55 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c50da7sm80856725e9.3.2026.09.24.02.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:29:55 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 7/7] selftests/bpf: Test Program Structure diagnostic context
Date: Thu, 24 Sep 2026 11:29:36 +0200
Message-ID: <20260924092941.3174809-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924092941.3174809-1-memxor@gmail.com>
References: <20260924092941.3174809-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9473; i=memxor@gmail.com; h=from:subject; bh=z9SoyzBe2zOgXvOjzEhbpdsikzbx40if1WujuTr3rrs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvL29wpM+sPHmWz9SxSTj2xkd95B3vrhSaLMzOtE/caT HqeWaXUUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgInwP2T4Z/6y6IvrLZO81AdR q1e5h318ftk4rOR4i6P/O7XIje/YvRj++5a3Me91iL1Sv7lq/Zywf9sfPWPxE+d/6fi+xeRxWUY NIwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise each corrected Program Structure report. Place a
missing-table gotox after another instruction so its attribution
differs from the subprogram start.

Add malformed subprogram layouts for a branch crossing a subprogram
boundary and a subprogram that falls through its end. Both cases carry
BTF line records and assert that their structured reports include the
corresponding source function and file.

Add a raw CO-RE case that targets a truncated final LD_IMM64 and assert
that it is rejected before relocation is applied.

Link: https://lore.kernel.org/bpf/cf2f420c2b21de440a7dc51b1565c0f06d4b539640ee5c03384e5d77bcfb5686@mail.kernel.org/
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 172 ++++++++++++------
 .../selftests/bpf/progs/verifier_cfg.c        |  40 ++++
 .../selftests/bpf/progs/verifier_gotox.c      |   2 +
 3 files changed, 156 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..035a7fe99937 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -14,64 +14,44 @@
 
 static char log[16 * 1024];
 
-/* Check that verifier rejects BPF program containing relocation
- * pointing to non-existent BTF type.
- */
-static void test_bad_local_id(void)
+struct test_btf {
+	struct btf_header hdr;
+	__u32 types[15];
+	char strings[128];
+};
+
+static struct test_btf raw_btf = {
+	.hdr = {
+		.magic = BTF_MAGIC,
+		.version = BTF_VERSION,
+		.hdr_len = sizeof(struct btf_header),
+		.type_off = 0,
+		.type_len = sizeof(raw_btf.types),
+		.str_off = offsetof(struct test_btf, strings) -
+			   offsetof(struct test_btf, types),
+		.str_len = sizeof(raw_btf.strings),
+	},
+	.types = {
+		BTF_PTR_ENC(0),					/* [1] void*  */
+		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),	/* [2] int    */
+		BTF_FUNC_PROTO_ENC(2, 1),			/* [3] int (*)(void*) */
+		BTF_FUNC_PROTO_ARG_ENC(8, 1),
+		BTF_FUNC_ENC(8, 3)			/* [4] FUNC 'foo' type_id=2   */
+	},
+	.strings = "\0int\0 0\0foo\0"
+};
+
+static int load_test_btf(void)
 {
-	struct test_btf {
-		struct btf_header hdr;
-		__u32 types[15];
-		char strings[128];
-	} raw_btf = {
-		.hdr = {
-			.magic = BTF_MAGIC,
-			.version = BTF_VERSION,
-			.hdr_len = sizeof(struct btf_header),
-			.type_off = 0,
-			.type_len = sizeof(raw_btf.types),
-			.str_off = offsetof(struct test_btf, strings) -
-				   offsetof(struct test_btf, types),
-			.str_len = sizeof(raw_btf.strings),
-		},
-		.types = {
-			BTF_PTR_ENC(0),					/* [1] void*  */
-			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),	/* [2] int    */
-			BTF_FUNC_PROTO_ENC(2, 1),			/* [3] int (*)(void*) */
-			BTF_FUNC_PROTO_ARG_ENC(8, 1),
-			BTF_FUNC_ENC(8, 3)			/* [4] FUNC 'foo' type_id=2   */
-		},
-		.strings = "\0int\0 0\0foo\0"
-	};
 	__u32 log_level = 1 | 2 | 4;
 	LIBBPF_OPTS(bpf_btf_load_opts, opts,
 		    .log_buf = log,
 		    .log_size = sizeof(log),
 		    .log_level = log_level,
 	);
-	struct bpf_insn insns[] = {
-		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	struct bpf_func_info funcs[] = {
-		{
-			.insn_off = 0,
-			.type_id = 4,
-		}
-	};
-	struct bpf_core_relo relos[] = {
-		{
-			.insn_off = 0,		/* patch first instruction (r0 = 0) */
-			.type_id = 100500,	/* !!! this type id does not exist */
-			.access_str_off = 6,	/* offset of "0" */
-			.kind = BPF_CORE_TYPE_ID_LOCAL,
-		}
-	};
-	union bpf_attr attr;
-	int saved_errno;
-	int prog_fd = -1;
-	int btf_fd = -1;
+	int saved_errno, btf_fd;
 
+	log[0] = 0;
 	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), &opts);
 	saved_errno = errno;
 	if (btf_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
@@ -79,18 +59,30 @@ static void test_bad_local_id(void)
 		printf("%s", log);
 		printf("-------- BTF load log end ----------\n");
 	}
-	if (btf_fd < 0) {
+	if (btf_fd < 0)
 		PRINT_FAIL("bpf_btf_load() failed, errno=%d\n", saved_errno);
-		return;
-	}
+	return btf_fd;
+}
+
+static int load_test_prog(int btf_fd, struct bpf_insn *insns, size_t insn_cnt,
+			  struct bpf_core_relo *relos, size_t relo_cnt)
+{
+	struct bpf_func_info funcs[] = {
+		{
+			.insn_off = 0,
+			.type_id = 4,
+		}
+	};
+	__u32 log_level = 1 | 2 | 4;
+	union bpf_attr attr = {};
+	int prog_fd;
 
 	log[0] = 0;
-	memset(&attr, 0, sizeof(attr));
 	attr.prog_btf_fd = btf_fd;
 	attr.prog_type = BPF_TRACE_RAW_TP;
 	attr.license = (__u64)"GPL";
-	attr.insns = (__u64)&insns;
-	attr.insn_cnt = sizeof(insns) / sizeof(*insns);
+	attr.insns = (__u64)insns;
+	attr.insn_cnt = insn_cnt;
 	attr.log_buf = (__u64)log;
 	attr.log_size = sizeof(log);
 	attr.log_level = log_level;
@@ -98,15 +90,43 @@ static void test_bad_local_id(void)
 	attr.func_info_cnt = sizeof(funcs) / sizeof(*funcs);
 	attr.func_info_rec_size = sizeof(*funcs);
 	attr.core_relos = (__u64)relos;
-	attr.core_relo_cnt = sizeof(relos) / sizeof(*relos);
+	attr.core_relo_cnt = relo_cnt;
 	attr.core_relo_rec_size = sizeof(*relos);
 	prog_fd = sys_bpf_prog_load(&attr, sizeof(attr), 1);
-	saved_errno = errno;
 	if (prog_fd < 0 || env.verbosity > VERBOSE_NORMAL) {
 		printf("-------- program load log start --------\n");
 		printf("%s", log);
 		printf("-------- program load log end ----------\n");
 	}
+	return prog_fd;
+}
+
+/* Check that verifier rejects BPF program containing relocation
+ * pointing to non-existent BTF type.
+ */
+static void test_bad_local_id(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_core_relo relos[] = {
+		{
+			.insn_off = 0,		/* patch first instruction (r0 = 0) */
+			.type_id = 100500,	/* !!! this type id does not exist */
+			.access_str_off = 6,	/* offset of "0" */
+			.kind = BPF_CORE_TYPE_ID_LOCAL,
+		}
+	};
+	int prog_fd = -1;
+	int btf_fd = -1;
+
+	btf_fd = load_test_btf();
+	if (btf_fd < 0)
+		return;
+
+	prog_fd = load_test_prog(btf_fd, insns, ARRAY_SIZE(insns),
+				 relos, ARRAY_SIZE(relos));
 	if (prog_fd >= 0) {
 		PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
 		goto out;
@@ -118,8 +138,44 @@ static void test_bad_local_id(void)
 	close(btf_fd);
 }
 
+static void test_truncated_ldimm64(void)
+{
+	struct bpf_insn insns[] = {
+		BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_0, 0, 0, 0),
+	};
+	struct bpf_core_relo relos[] = {
+		{
+			.insn_off = 0,
+			.type_id = 2,
+			.access_str_off = 6,
+			.kind = BPF_CORE_TYPE_ID_LOCAL,
+		}
+	};
+	int prog_fd = -1;
+	int btf_fd = -1;
+
+	btf_fd = load_test_btf();
+	if (btf_fd < 0)
+		return;
+
+	prog_fd = load_test_prog(btf_fd, insns, ARRAY_SIZE(insns),
+				 relos, ARRAY_SIZE(relos));
+	if (prog_fd >= 0) {
+		PRINT_FAIL("sys_bpf_prog_load() expected to fail\n");
+		goto out;
+	}
+	ASSERT_HAS_SUBSTR(log, "core_relo[0] targets truncated bpf_ld_imm64 insn",
+			  "program load log");
+
+out:
+	close(prog_fd);
+	close(btf_fd);
+}
+
 void test_core_reloc_raw(void)
 {
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
+	if (test__start_subtest("truncated_ldimm64"))
+		test_truncated_ldimm64();
 }
diff --git a/tools/testing/selftests/bpf/progs/verifier_cfg.c b/tools/testing/selftests/bpf/progs/verifier_cfg.c
index 3c3bb03e8217..a8396d4fd5f3 100644
--- a/tools/testing/selftests/bpf/progs/verifier_cfg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_cfg.c
@@ -56,6 +56,46 @@ __naked void out_of_range_jump2(void)
 "	::: __clobber_all);
 }
 
+static __naked __noinline __used int cross_subprog_target(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("jump across subprogram boundary")
+__failure __msg("jump out of range from insn 1")
+__msg("jump_across_subprog_boundary @ verifier_cfg.c")
+__naked void jump_across_subprog_boundary(void)
+{
+	asm volatile ("					\
+	call cross_subprog_target;			\
+	goto +1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+static __naked __noinline __used int fallthrough_subprog(void)
+{
+	asm volatile ("					\
+	r0 = 0;						\
+"	::: __clobber_all);
+}
+
+SEC("socket")
+__description("subprogram fallthrough")
+__failure __msg("last insn is not an exit or jmp")
+__msg("fallthrough_subprog @ verifier_cfg.c")
+__naked void subprog_fallthrough(void)
+{
+	asm volatile ("					\
+	call fallthrough_subprog;			\
+	exit;						\
+"	::: __clobber_all);
+}
+
 SEC("socket")
 __description("invalid DW LDSX instruction in diagnostics")
 __failure __msg("BUG_ldx_99")
diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
index 5b18c9a27717..a835a4871021 100644
--- a/tools/testing/selftests/bpf/progs/verifier_gotox.c
+++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
@@ -53,9 +53,11 @@ DEFINE_SIMPLE_JUMP_TABLE_PROG(reserved_field_non_zero_imm, BPF_REG_0, 0, 1, __fa
  */
 SEC("socket")
 __failure __msg("no jump tables found for subprog starting at 0")
+__msg(">>> 1 | (0d) gotox r0")
 __naked void jump_table_no_jump_table(void)
 {
 	asm volatile ("						\
+	r0 = 0;							\
 	.8byte %[gotox_r0];					\
 	r0 = 1;							\
 	exit;							\
-- 
2.53.0

