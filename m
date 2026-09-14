Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0A472F75
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391835; cv=none; b=P0Jtrfnlodn8xjQjRwI1FSfAqZQdiE27T2XNSHPcKqoczKJ0VEHfVKhWEbrFOMvCBcitNWvQUnQJuEMcyrL4wS+QI88ARcXo++EbODYpXfg0AvRWjKfeB4DyhaMKlH8zghe1g45hY8HjDFffrIh70Dk8gi1FXt13yKAcI9Nmums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391835; c=relaxed/simple;
	bh=JmjMMt+B1k+IeyI+vsHf95qjeMr6nrWcWaaAWSScEcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7MsxVXCHQa+A87bV74cG2tTPDU3lrsE1XNZGq5iq9IEM/k59BRik3jgJaJpz+DsPeHYsMeYr8CFfBUVb1q2RC3p59U6vFJAJvBSNfN3frnFb+VMm5HMecpmsmov9IdggW9VzkVdz2OE/oC6M4B6GOHNehg7E5qVCAjCPra5eG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcXAplQi; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcXAplQi"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e7b06acb8so1568985e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391832; x=1789996632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h6LDcJSxMACiTpAMPHZ3A3qzFLPHs+hHs682wKOgX/A=;
        b=dcXAplQi86liV417czNsoqiidyOSS1AbJkbWzDPORVl/MURHsj+6KR0AZUsxEze5do
         +kF/6HSIJaWh+jNQfxRXKGbT0cyWLBKXcwjgFoTLsJlJ6rxp7S8TcBClDQT6RQrnPk4W
         KWeUSxioOkOrOOvUcvdqsL6qC3e5JyU+am1WJjPrVfSkHMe0VfTzCW9/fIP+cDef4ver
         Q8y4oTZ0B/9gnqnJAiPyiilzEnHwzbmdi/42AHT0f1HWJ+TexDbg0W7l5xBfwhk3IHe2
         zDFMC7ffUmADOhqb6QNKCEpwOJXox35wnkzVHxFaCazk3HoZWWN2cURkfAzfty5f98fh
         gFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391832; x=1789996632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h6LDcJSxMACiTpAMPHZ3A3qzFLPHs+hHs682wKOgX/A=;
        b=Zz5evKg24BTWsgbMrjxOww/LzpcbQegnu1AYQqHEEYpL0iX4oti7LNUzOSZ/gv/cjS
         BGghiCL5kHPzJNaLNhhk4Av0PRBKAxWtzeOOWPwBS9v8NI0Nsjz4osDiPgUvuC9azQAZ
         pL3ZBiW4cTvN7jggpqhT9JwwLcZQvig5lu1xnd7n1UhUIntjSUaYzhCK81gbuCuDVX4C
         p/MXo2YQoN0bPw2Frxas0GGcsDbQoYZimzifyTYsLLZEIbhLFZOJf/bjgQTppaVugHhS
         Gnso8nxxxTiOMg+ZNrC4hrnGzp5dYv7UCj2zXEhZlTySaAEc/XBWa90kZHsLgviUqS+J
         uVzw==
X-Gm-Message-State: AFuF++mQehRRZdxOly5xfDNJl1NDML1VkF+14dG2s7opDoQVLFxfoF1e
	2TRShF6mDsVcAZE8CzV8kC+MBUS5bks0zYgXBu8tArzWwBzSk5ey8uFU/HeqhHoc
X-Gm-Gg: AYBFou3hrQu4IABQBhat/cCWmKkoaKl1/G18VuKJ08ueVkPHLqM2oTfgWiTN6/azNaU
	/ft1J7eWFuFZgUodZ93/adhuqwvug+p2jb0/Ubd7hZNIdmd9MaljrFGKt/0AJk58kz+i6IQVnq1
	yyuXgC74MMfyS/AkMnPO7mhIfM7hOThQ0CqbBxKRn7lRibjLjJK+Szfka+9mXApuaJ/XcsxPo1B
	0zPk8xIIS6qQns/rf3ECVBru3YH++qWdYQaQk/IphF3+4tK+mHRuzcVvXn7TMYE/tGR+CwzuTl+
	CV62vB4IC8OJEYVmfGsozDE7+lEfNGakL79ZU8Tjk/qgpRCAbd36fZf5VNkN9EcQlVdBnsFykO3
	rJn6VeVzixbVDIZAKzJ/tl15fO+S0b5r+rJg9D/4LJJa1NiTwu6funFMcpXtfOp2pOJ5+AYjbFJ
	9U/Tj8FGEBXucI0cyyH2rCsbtV3tZqngMoFtECAkvnnaKQmyhH3szecWLCNoV54rPIUfHxuGK2y
	dshQk52X3pJg0fvxujHMkRgp7gKtLwO47arc+0NU6a53MWsMOWsJd2mcQpDVRwZbG5jclWPCDKW
	QOw3v39pvTBaCHCYhqw1DXCGaB9Vt/i8K8Z0hA==
X-Received: by 2002:a05:600c:3585:b0:49d:99:1d98 with SMTP id 5b1f17b1804b1-49e7a669264mr37078665e9.9.1789391831497;
        Mon, 14 Sep 2026 06:17:11 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7a29826fsm60726975e9.4.2026.09.14.06.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:11 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 5/7] selftests/bpf: Test CO-RE instruction poisoning restrictions
Date: Mon, 14 Sep 2026 15:16:55 +0200
Message-ID: <20260914131701.2529725-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131701.2529725-1-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7509; i=memxor@gmail.com; h=from:subject; bh=JmjMMt+B1k+IeyI+vsHf95qjeMr6nrWcWaaAWSScEcE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv555lvnjKGHQ74HlbontD+cVGd4dOr643ZD0X499x9r Xv7rUl8RykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYyQYPhn+ar5S2zrU22OT7d 5TI3xcpixjSvKv0bkkGP+BjbMxdMW8TIsO2/hFW+T8DDMk4u03vvg2euybhyVq43jtvXf/EU8Yv V/AA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add raw CO-RE relocations that fail to resolve their target enum value.
Check that a relocation targeting a subprogram's terminal exit fails at
the relocation step, before poisoning can create cross-subprogram
fall-through.

Also place each supported and unsupported instruction class in dead code.
Unsupported targets must fail relocation even when unreachable. Supported
ALU immediates, memory accesses, and ldimm64 instructions must still be
poisoned and removed as dead code, allowing the program to load. Check
that both halves of ldimm64 are poisoned.

Load every program without relocations first to ensure that rejection is
caused by the relocation rather than the original instruction stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..158b3e2e3f5f 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -14,6 +14,173 @@
 
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
+static void test_poisoned_insns(void)
+{
+	static const struct {
+		const char *name;
+		struct bpf_insn insns[2];
+		bool relocatable;
+	} tests[] = {
+		{ "poison_exit", { BPF_EXIT_INSN() } },
+		{ "poison_ja", { BPF_JMP_A(1) } },
+		{ "poison_jmp", { BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1) } },
+		{ "poison_jmp32", { BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 0, 1) } },
+		{ "poison_call", { BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32) } },
+		{ "poison_alu_reg", { BPF_MOV32_REG(BPF_REG_0, BPF_REG_1) } },
+		{ "poison_alu64_reg", { BPF_MOV64_REG(BPF_REG_0, BPF_REG_1) } },
+		{ "poison_ld_abs", { BPF_LD_ABS(BPF_W, 0) } },
+		{ "poison_alu_imm", { BPF_MOV32_IMM(BPF_REG_0, 0) }, true },
+		{ "poison_alu64_imm", { BPF_MOV64_IMM(BPF_REG_0, 0) }, true },
+		{ "poison_ldx", { BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0) }, true },
+		{ "poison_st", { BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0) }, true },
+		{ "poison_stx", { BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4) }, true },
+		{ "poison_ldimm64", { BPF_LD_IMM64(BPF_REG_0, 0) }, true },
+	};
+	struct bpf_func_info funcs[2];
+	struct bpf_insn subprog[] = {
+		BPF_CALL_REL(2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	const void *raw_btf;
+	struct btf *btf;
+	__u32 raw_btf_size;
+	int access_str_off, btf_fd = -1, enum_id;
+	int int_id, main_id, prog_fd = -1, proto_id, sub_id, i;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
+		return;
+	int_id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_GT(int_id, 0, "add_int"))
+		goto cleanup;
+	proto_id = btf__add_func_proto(btf, int_id);
+	if (!ASSERT_GT(proto_id, 0, "add_func_proto"))
+		goto cleanup;
+	main_id = btf__add_func(btf, "main_fn", BTF_FUNC_STATIC, proto_id);
+	if (!ASSERT_GT(main_id, 0, "add_main_func"))
+		goto cleanup;
+	sub_id = btf__add_func(btf, "sub_fn", BTF_FUNC_STATIC, proto_id);
+	if (!ASSERT_GT(sub_id, 0, "add_sub_func"))
+		goto cleanup;
+	enum_id = btf__add_enum(btf, "core_relo_poison_missing", 4);
+	if (!ASSERT_GT(enum_id, 0, "add_enum") ||
+	    !ASSERT_OK(btf__add_enum_value(btf, "value", 0), "add_enum_value"))
+		goto cleanup;
+	access_str_off = btf__add_str(btf, "0");
+	if (!ASSERT_GT(access_str_off, 0, "add_access_str"))
+		goto cleanup;
+
+	raw_btf = btf__raw_data(btf, &raw_btf_size);
+	if (!ASSERT_OK_PTR(raw_btf, "raw_btf"))
+		goto cleanup;
+	btf_fd = bpf_btf_load(raw_btf, raw_btf_size, NULL);
+	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
+		goto cleanup;
+	funcs[0] = (struct bpf_func_info) { .insn_off = 0, .type_id = main_id };
+	funcs[1] = (struct bpf_func_info) { .insn_off = 3, .type_id = sub_id };
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
+		ASSERT_HAS_SUBSTR(log, "trying to relocate unrecognized insn #2",
+				  "poisoned_load_log");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		struct bpf_insn insns[] = {
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 2),
+			tests[i].insns[0],
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		};
+		int insn_cnt = ARRAY_SIZE(insns);
+
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		if (insns[2].code == (BPF_LD | BPF_DW | BPF_IMM)) {
+			insns[3] = tests[i].insns[1];
+		} else {
+			insns[1].off = 1;
+			insns[4] = BPF_EXIT_INSN();
+			insn_cnt--;
+		}
+		prog_fd = load_core_relo_insns(btf_fd, insns, insn_cnt, funcs, 1,
+					       enum_id, access_str_off, 2, false);
+		if (!ASSERT_GE(prog_fd, 0, "control_load"))
+			goto cleanup;
+		close(prog_fd);
+		prog_fd = load_core_relo_insns(btf_fd, insns, insn_cnt, funcs, 1,
+					       enum_id, access_str_off, 2, true);
+		if (tests[i].relocatable) {
+			ASSERT_GE(prog_fd, 0, "dead_poison_load");
+			ASSERT_HAS_SUBSTR(log, "substituting insn #2", "poison_log");
+			if (insns[2].code == (BPF_LD | BPF_DW | BPF_IMM))
+				ASSERT_HAS_SUBSTR(log, "substituting insn #3", "poison_ldimm64_log");
+		} else {
+			ASSERT_LT(prog_fd, 0, "invalid_poison_load");
+			ASSERT_NULL(strstr(log, "substituting insn"), "invalid_poison_log");
+		}
+		close(prog_fd);
+		prog_fd = -1;
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
+	btf__free(btf);
+}
+
 /* Check that verifier rejects BPF program containing relocation
  * pointing to non-existent BTF type.
  */
@@ -120,6 +287,7 @@ static void test_bad_local_id(void)
 
 void test_core_reloc_raw(void)
 {
+	test_poisoned_insns();
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
 }
-- 
2.53.0

