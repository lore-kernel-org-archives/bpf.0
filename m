Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DE945D19F
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593700; cv=none; b=QLbH0DfJNVpjnD4IPj6jbrHiZH97YLeEkhdHuHYizETVXrup6uohcl8+769ohRFrVc4XoFj0L80S7aBVV61Ye87kB7G1wa5X7hVNX96usU61J+q7LpxLwwvJS/zFornk4iznk7WZ4/xjLYNWIHLpb5G/k1xY4R2U+IMrDwXwP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593700; c=relaxed/simple;
	bh=s1s5m3KVmgbK3ZOJo5RXqJIczOkmiw8/KV6fOEcHUhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBoMHG2LxRnrKynJBXYSm20Y6BIQx8MAuHdt0UaibKs1D35CkXA2TRWIUSYdgTQ6GSgk5J3iMzXimzahpyglaIEiT2YdphrWJT8aqCMJKU2e4ZddIqVDFe03SGlHL4+8EldGfjbn6SyRRrxkotbsKBynV8ucFUNeup112mprGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/Q0Lw9X; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/Q0Lw9X"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e66652cc3so715065e9.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593673; x=1790198473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8qw6q0NyzsB4Er2R4HBwsyLMKFd8QVGcLbW/ssKon0=;
        b=d/Q0Lw9X63+KTxCGMEMdCHU4xvmThT1A+/5s73zjJRyGkiQIC7BCkUBTSwBZCRPmh9
         F1An4tMGSkeCJxoegTCuhCGSi+1NMSZxUBdnz17JnMEzQXK89nbW57qqwq30mIDQQ6GE
         ivVLKZW8u/fNqFYmhZJ6VW8WbY3loOhLsdKVnwIYJZbL76+Ci5avOR7FQbT/Lp0CD/pH
         PB/8DL0W2gc8PF70eFQvY5ZWx7/hUt82pRmywODxHmH07ezNL8khqvRV5seo4o4OB8qT
         FOUj+f+Lhw1fbZ53dsfpARq4BXiqTMN3eEWMjfqUJ1itvFDzXKK6X53LdoJyfWfvJMmN
         rx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593673; x=1790198473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e8qw6q0NyzsB4Er2R4HBwsyLMKFd8QVGcLbW/ssKon0=;
        b=xCBgtp5leQXoJwy1ss5Xj2RY7jhUDrfcWOySP9u5BEvIbqwlbS3d0115wulRZmSHgl
         FTjKA3qhf8Dj/kr0E3Goc2nrE1+O3ia5byGiJKCMUDEnryXpYh2eqOYEEn35S17KiKDM
         vISrzsjh2s0tidH4KCd6CP32nasOI4P8DfFaDQiK7/FN+Ii6gIczYGW4KRGmBCabzQyq
         vUGfsW0ML2X/BIgupznRNP3fpVJHgY0GAfSmPjP3B0GkxtISMk9A8VS0YP9XxhyxUHit
         A5pGUm635erzmv4MhTHPdSwWxnZdxNcao0TNoHhDIfH9ybNDFCe5Nny9hdb2tElU8NlJ
         Xs3Q==
X-Gm-Message-State: AFuF++mqSmDJKoBi20UlCgnbVyRj9Khsgvy24DMAwMbXc6kUIMxtpsYn
	vsDU/oFmyHHwXdSPb30GE3Q0AgX63DmD4V2BObLHALoH91QeKDKaL8aXcTq3FMvV
X-Gm-Gg: AYBFou2pnOdFnhkxCTluaZIVpcicdzkog11x+fujOAHmA2Pjibm94ou9f5wGomj/IHE
	PgGhRMsJeZysI4759FtV084iSO65Hv8mZdr9uSHfeBIFZMmknFe1ns4gRMOn/ooV1AQZUgUmuIL
	b7KpZEPNyI6Gn7UcEIJRtzYf4+kVQakHd5nCWllwIUBG58tSJRwh4Rkdtx9pO8EEEg6GQi90wOi
	83mCtD5IIYPOxegK5qqlMlak7uKWKEn2zpVIlXKtnFW2jPPiw6C2ylXxTxbdvTLkMXtHLhIBEpI
	gdSbE4WT/tR8LAb7UcrfXLUwke9QzVFZqb79RIC2NpgMUd+PLIidNrAS02nxDtHerWo0laXX92t
	B/EqjVdPGct5OUufwRM/fy8MDesOr9i27ozVDpHjZmbD1UV8fkMDeADKTeC9aXgdhN0K5ymyF4q
	W30KV1eFQF/gGSPEnjiyCathqwV/WItXxX23PL1584Yod7UM71xiUgkI/nKLktUUhg+Kz6lR+xb
	miU/6PhecT/c6+eEKpOqPTU/Fa76swL6oEX5hQ5sfO262v3+S2fxVGjJzjzzvkLNYViehhbKswA
	W1RBOqlsZtabfPD5QqDZQhT5TVB3t8KKfK8IRg==
X-Received: by 2002:a05:600c:1907:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-49eb73143c7mr48698375e9.1.1789593672467;
        Wed, 16 Sep 2026 14:21:12 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27df9sm9632417f8f.19.2026.09.16.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:12 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 05/10] selftests/bpf: Test early in-kernel CO-RE relocation
Date: Wed, 16 Sep 2026 23:20:52 +0200
Message-ID: <20260916212102.597335-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6414; i=memxor@gmail.com; h=from:subject; bh=s1s5m3KVmgbK3ZOJo5RXqJIczOkmiw8/KV6fOEcHUhs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h9xLrrpnZ15fNikIdj+XcUfCqOruivv5ngvkds9bt VjdTXlyRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACZSkcDI0KKf9JDLP+Xhv+JP CyQXxOS1nD9sZlttrf7uyWKB53ulvRgZlk+p2C6nuEfPyWvBSZUSI46zvy+sWrWFQ73c7+3KCM6 3fAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a raw program load with CO-RE relocation metadata but no func_info or
line_info. Place the relocation in dead code and require the poisoning log,
proving that the kernel processes standalone CO-RE metadata instead of
silently skipping it.

Also poison a subprogram's terminal exit and require check_subprogs() to
reject the resulting fall-through. This confirms that in-kernel CO-RE runs
before the verifier validates the subprogram layout and before later CFG
consumers rely on it.

Load both instruction streams without relocation metadata first to ensure
that CO-RE processing causes the rejection and diagnostic. Encode the fixed
BTF metadata directly with the selftest BTF helpers.

Add a verifier case whose instruction stream ends after the first ldimm64
slot to cover the early structural check that protects relocation processing.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 124 ++++++++++++++++++
 .../testing/selftests/bpf/verifier/ld_imm64.c |   8 ++
 2 files changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..ee267289fd88 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -14,6 +14,129 @@
 
 static char log[16 * 1024];
 
+static int load_core_relo_insns(int btf_fd, struct bpf_insn *insns, int insn_cnt,
+				struct bpf_func_info *funcs, int func_cnt,
+				int enum_id, int access_str_off, int insn_idx,
+				bool relocate)
+{
+	struct bpf_core_relo relo = {
+		.insn_off = insn_idx * sizeof(struct bpf_insn),
+		.type_id = enum_id,
+		.access_str_off = access_str_off,
+		.kind = BPF_CORE_ENUMVAL_VALUE,
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+		.insn_cnt = insn_cnt,
+		.insns = (__u64)insns,
+		.license = (__u64)"GPL",
+		.log_buf = (__u64)log,
+		.log_size = sizeof(log),
+		.log_level = 2,
+		.prog_btf_fd = btf_fd,
+		.func_info_rec_size = sizeof(struct bpf_func_info),
+		.func_info = (__u64)funcs,
+		.func_info_cnt = func_cnt,
+	};
+
+	if (relocate) {
+		attr.core_relo_cnt = 1;
+		attr.core_relos = (__u64)&relo;
+		attr.core_relo_rec_size = sizeof(relo);
+	}
+	memset(log, 0, sizeof(log));
+	return sys_bpf_prog_load(&attr, sizeof(attr), 1);
+}
+
+static void test_early_core_relo(void)
+{
+	struct test_btf {
+		struct btf_header hdr;
+		__u32 types[18];
+		char strings[64];
+	} raw_btf = {
+		.hdr = {
+			.magic = BTF_MAGIC,
+			.version = BTF_VERSION,
+			.hdr_len = sizeof(struct btf_header),
+			.type_off = 0,
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct test_btf, strings) -
+				   offsetof(struct test_btf, types),
+			.str_len = sizeof(raw_btf.strings),
+		},
+		.types = {
+			BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4), /* [1] int */
+			BTF_FUNC_PROTO_ENC(1, 0),	/* [2] int (*)(void) */
+			BTF_FUNC_ENC(5, 2),		/* [3] main_fn */
+			BTF_FUNC_ENC(13, 2),		/* [4] sub_fn */
+			BTF_TYPE_ENC(20, BTF_INFO_ENC(BTF_KIND_ENUM, 0, 1), 4), /* [5] enum */
+			BTF_ENUM_ENC(45, 0),		/* value = 0 */
+		},
+		.strings = "\0int\0main_fn\0sub_fn\0core_relo_poison_missing\0value\0" "0",
+	};
+	struct bpf_func_info funcs[] = {
+		{ .insn_off = 0, .type_id = 3 },
+		{ .insn_off = 3, .type_id = 4 },
+	};
+	struct bpf_insn core_only[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_insn subprog[] = {
+		BPF_CALL_REL(2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int access_str_off = 51, enum_id = 5;
+	int btf_fd, prog_fd = -1;
+
+	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), NULL);
+	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
+		goto cleanup;
+
+	if (test__start_subtest("without_func_info")) {
+		prog_fd = load_core_relo_insns(btf_fd, core_only, ARRAY_SIZE(core_only), NULL, 0,
+					       enum_id, access_str_off, 2, false);
+		if (!ASSERT_GE(prog_fd, 0, "control_load"))
+			goto cleanup;
+		close(prog_fd);
+		prog_fd = load_core_relo_insns(btf_fd, core_only, ARRAY_SIZE(core_only), NULL, 0,
+					       enum_id, access_str_off, 2, true);
+		if (!ASSERT_GE(prog_fd, 0, "poisoned_load"))
+			goto cleanup;
+		ASSERT_HAS_SUBSTR(log, "substituting insn #2", "poison_log");
+		close(prog_fd);
+		prog_fd = -1;
+	}
+
+	if (test__start_subtest("poisoned_subprog_terminator")) {
+		prog_fd = load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog), funcs, 2,
+					       enum_id, access_str_off, 2, false);
+		if (!ASSERT_GE(prog_fd, 0, "control_load"))
+			goto cleanup;
+		close(prog_fd);
+		prog_fd = load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog), funcs, 2,
+					       enum_id, access_str_off, 2, true);
+		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
+			goto cleanup;
+		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_load_log");
+	}
+
+cleanup:
+	if (env.verbosity > VERBOSE_NORMAL && log[0]) {
+		printf("-------- program load log start --------\n");
+		printf("%s", log);
+		printf("-------- program load log end ----------\n");
+	}
+	close(prog_fd);
+	close(btf_fd);
+}
+
 /* Check that verifier rejects BPF program containing relocation
  * pointing to non-existent BTF type.
  */
@@ -120,6 +243,7 @@ static void test_bad_local_id(void)
 
 void test_core_reloc_raw(void)
 {
+	test_early_core_relo();
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
 }
diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
index 78f19c255f20..9ac732c142d0 100644
--- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
+++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
@@ -50,6 +50,14 @@
 	.errstr = "invalid bpf_ld_imm64 insn",
 	.result = REJECT,
 },
+{
+	"test5 ld_imm64: truncated",
+	.insns = {
+	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
+	},
+	.errstr = "invalid bpf_ld_imm64 insn",
+	.result = REJECT,
+},
 {
 	"test6 ld_imm64",
 	.insns = {
-- 
2.53.0

