Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB78C49EC54
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424730; cv=none; b=pJUZ+XZ0vl0/TYDzm2Gw2ragEWak173gbZ3OxfXTF+6Cvrv8tV9tVsdsrKbUKAj4HeOEdcCh756al8dMp8zg3n0lckxTJBGqgCZMwLDTuMVlvChQczhBcP9D/G1uxXMJNtP00WrT7r+fGSK8tuOwYbX8y98rbBifgsWKOhLO0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424730; c=relaxed/simple;
	bh=LN68Xugm8Ez5lTssx2Gtz244URn4f6+vzc7flOkWGQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBG6pL6/40aPZxZwv2xZflLTY+iskoUw0CpnAm8pckzQ1H5A4J3UPpXhw/DFRoopG+QkTT8S01KA9apnYQdSbd2c3c770dKzinaqUY/Jp2hWeepKumrnHHHaf3JC/qP7dpjhLVcQY0p7JQDLbJZV64P9iKnak3z10E17QQZdb6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFeMobOM; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFeMobOM"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e1bf3f18so443774f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424727; x=1790029527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKVsV9PZc2EXabV0Awjavwit8yTFJgBe6LoACpohjcY=;
        b=GFeMobOMI/9CS75A1GO7vAdePpKG5e0ELmtzIDFpdFVBEC+iDvNEx7CuPEQ4vjFqQC
         eQBouDmPrvGq/nE40pke/ILV6fnkUYMPXyc2mz4QjxJeWMv/D77qcjr2Do8FFYktEzwc
         zIAb8xO9AY68XRXuFWzz+jpccMv1gN5GU0knocQ4QkQSrRt5WUyci/UmRSTeRxLIuQiH
         1xUBAya5ZoPvqXqU/Ylpcd9AmUJtaw4AobdCTWwNje5TsAd59lc7IHuUwMU02DApmXVa
         jtpBx1w3ZBSvbbBUBErXhgHKVgBFcC0n3yhpVNZ9WNPZe98JOlOrT9FirXIKliaI/dFq
         DO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424727; x=1790029527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKVsV9PZc2EXabV0Awjavwit8yTFJgBe6LoACpohjcY=;
        b=D5xKKaCclU6DW6PS7/Fag2ixwVYGUO6Py+JbSr6lBS1jS6GWpaM1+CpN0TSxA52FW1
         UuBbSqzj9uzwMiAmX22grrTx/nBtI86Uq4Rp5t3STR8QZUqkQnCx9mJhjqGI6bfpuCzG
         qeytwyQvbjXoNaikVDvaWpjaiY2gml9XcGjRrBU04ee50o9R+PuecUt7HCg+ombhqSd5
         Ow4imydP6G8jsVE/EKMk3TwUo1R7gFuZMwBDnVJty0axhCwOacHC2xt292X6EpZ7L+UR
         /KniO4UN8hM6q6uGKY7N7SPgdgDOaP+j2YKrKSKUonNJ9z6IDCKd8Fk1sCsL/xikL0v7
         Nr3A==
X-Gm-Message-State: AFuF++n5GWfEbN7W+gqF5F8w2XisOwYATvUG490FatPlaqNSwyCnMrAR
	Hz0BBD2R/DB33UtMA57jRAd/Wbdsd8LtGpUr3UvzqNWMvYZLVc1cyICCMBdFHtiUTHY=
X-Gm-Gg: AYBFou1Xmdo3FPjPNEn0xxtjswCkPe2zPf97nzU3oTGdoNKuzMOM0cbjy8eFR+pEloA
	4dolRQfHn2P4TJct6wjGr4ART633MS43tM3zpD7BNmopBcaJPgxcMopsCf+rYlTjcJTBG1H0V4U
	uc4tQLknKHKLuw+AAvPlrxW4Gn3b16kaf0hJDMlSOaDzqLIYsjRL2MukEs6FtjTngO6vjp5G2bY
	8xGiz93fJkFRq5XX6zAOqr4/nWythMYgPMT6BcyX4astX0vweyZ7OCArLVXL283UHNRRxsqptKv
	v6Gau3/sJzzxqv7gFXATwsIYhaDFwd9OOoPI0vVWZAKkBikWZQUtIuw/lnr4QJdvtZ9j/XLt8IL
	jhhkvV1VME+593phuRo3y9CvYw8d7ZoJlgHFI1+y+aFpFQp6me+QzvqAkQSp388AyPYB3NUYYV0
	6k2gfW88OeTu1EhjmQGpdf1oNkMN+l49p6w5EbLZsKc1I04HNrrgp1URzPLGntLFxVBaeKml6/Q
	L71Am1R21wGpALocNtjbb48PPvwkB90WrrS9uxE+Xro4d42s6yY21l/qP3rUfbTp8WjIMMpW204
	xD4lbrNntgDzeb0TZtcItRpnajQCkQgXnXeIzg==
X-Received: by 2002:a05:6000:4a1b:b0:486:fcca:afd4 with SMTP id ffacd0b85a97d-48705a44d10mr2176921f8f.8.1789424726791;
        Mon, 14 Sep 2026 15:25:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea60sm29487928f8f.17.2026.09.14.15.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:26 -0700 (PDT)
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
Subject: [PATCH bpf v4 07/11] selftests/bpf: Test CO-RE instruction poisoning restrictions
Date: Tue, 15 Sep 2026 00:25:04 +0200
Message-ID: <20260914222514.1635018-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4803; i=memxor@gmail.com; h=from:subject; bh=LN68Xugm8Ez5lTssx2Gtz244URn4f6+vzc7flOkWGQg=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFib73cu3P1bP4MqRt17TKu1kHT1VYuPZ1KGt/WNvTv oteq+92lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKxTxgZVottXTN/T9Xz7Xvm yE9ZvXjTUrPlDz33Pb4398H9t0vvmNQzMtwQabYP43Kalaj24nJaqynvft3ZfjqnbzqI1/Mk5Is f4QcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add raw CO-RE relocations that fail to resolve their target enum value.
Place each supported and unsupported instruction form in dead code.
Unsupported targets must fail relocation with a diagnostic even when they
are unreachable. Supported ALU immediates, memory accesses, and ldimm64
instructions must still be poisoned and removed as dead code, allowing the
program to load. Check that both halves of ldimm64 are poisoned.

Update the subprogram terminator regression to require rejection at the
relocation step now that an exit is not accepted as a relocation target.
Load every program without relocations first to ensure that rejection is
caused by the relocation rather than the original instruction stream.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 68 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index 6fdeba6d7eaa..90f1ea85354d 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -50,6 +50,28 @@ static int load_core_relo_insns(int btf_fd, struct bpf_insn *insns, int insn_cnt
 
 static void test_early_core_relo(void)
 {
+	static const char unrecognized[] = "trying to relocate unrecognized insn #2";
+	static const struct {
+		const char *name;
+		struct bpf_insn insns[2];
+		const char *err_msg;
+	} tests[] = {
+		{ "poison_exit", { BPF_EXIT_INSN() }, unrecognized },
+		{ "poison_ja", { BPF_JMP_A(1) }, unrecognized },
+		{ "poison_jmp", { BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1) }, unrecognized },
+		{ "poison_jmp32", { BPF_JMP32_IMM(BPF_JEQ, BPF_REG_0, 0, 1) }, unrecognized },
+		{ "poison_call", { BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32) }, unrecognized },
+		{ "poison_alu_reg", { BPF_MOV32_REG(BPF_REG_0, BPF_REG_1) }, unrecognized },
+		{ "poison_alu64_reg", { BPF_MOV64_REG(BPF_REG_0, BPF_REG_1) }, unrecognized },
+		{ "poison_ld_abs", { BPF_LD_ABS(BPF_W, 0) },
+		  "insn #2 (LDIMM64) has unexpected form" },
+		{ "poison_alu_imm", { BPF_MOV32_IMM(BPF_REG_0, 0) } },
+		{ "poison_alu64_imm", { BPF_MOV64_IMM(BPF_REG_0, 0) } },
+		{ "poison_ldx", { BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_1, 0) } },
+		{ "poison_st", { BPF_ST_MEM(BPF_W, BPF_REG_10, -4, 0) } },
+		{ "poison_stx", { BPF_STX_MEM(BPF_W, BPF_REG_10, BPF_REG_0, -4) } },
+		{ "poison_ldimm64", { BPF_LD_IMM64(BPF_REG_0, 0) } },
+	};
 	struct bpf_insn core_only[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
 		BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
@@ -68,7 +90,7 @@ static void test_early_core_relo(void)
 	struct btf *btf;
 	__u32 raw_btf_size;
 	int access_str_off, btf_fd = -1, enum_id;
-	int int_id, main_id, prog_fd = -1, proto_id, sub_id;
+	int int_id, main_id, prog_fd = -1, proto_id, sub_id, i;
 
 	btf = btf__new_empty();
 	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
@@ -127,7 +149,49 @@ static void test_early_core_relo(void)
 					       enum_id, access_str_off, 2, true);
 		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
 			goto cleanup;
-		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_load_log");
+		ASSERT_HAS_SUBSTR(log, unrecognized, "poisoned_load_log");
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
+		bool is_ldimm64 = insns[2].code == (BPF_LD | BPF_DW | BPF_IMM);
+		int insn_cnt = ARRAY_SIZE(insns);
+
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		if (is_ldimm64) {
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
+		if (!tests[i].err_msg) {
+			ASSERT_GE(prog_fd, 0, "dead_poison_load");
+			ASSERT_HAS_SUBSTR(log, "substituting insn #2", "poison_log");
+			if (is_ldimm64)
+				ASSERT_HAS_SUBSTR(log, "substituting insn #3", "poison_ldimm64_log");
+		} else {
+			ASSERT_LT(prog_fd, 0, "invalid_poison_load");
+			ASSERT_HAS_SUBSTR(log, tests[i].err_msg, "invalid_poison_log");
+			ASSERT_NULL(strstr(log, "substituting insn"), "invalid_poison_substitution");
+		}
+		close(prog_fd);
+		prog_fd = -1;
 	}
 
 cleanup:
-- 
2.53.0

