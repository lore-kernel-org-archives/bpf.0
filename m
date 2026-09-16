Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E6B4854F0
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593703; cv=none; b=O5O2i03jMT5pTJaooTLLtdSKiaeiuDMElygzTYY2nBtkPt8OuNlV4LxguCkyfMu5Lzt0q2LMqt8692SBx5iSiLt6iBdfZE9p0ItCe3tuBaju5QyBNdzWvFKaZtKU076f5gkXSjfQb1kNnLrZpLydv20F/PzSfDWxosVlaMhiF1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593703; c=relaxed/simple;
	bh=5Gge4/kf3wuXooPZ47g+N8cibmEKDXxenitkizO/foE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NA+v2nzQcQQKhDhBfhXJcGbXSCKbykS/5D6Co6bKiS+qXlEmEGQHyB8H8njv9CSJinzDFfr2dnYbBX7cbTHs1vvdvvo42ea0qGcMhU0cWCIoG9S1nlnptI0ZKbGljBBgvBlpKgbjztt4/WMfCBYl7C4ao15RsF1aXVCM0o3y/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sBILp7yY; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBILp7yY"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-4858866f7ffso39542f8f.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 14:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789593676; x=1790198476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zw6FxUREID0PCniCeTsRHMTD/jZ1i6ijXt3jNF/PRHc=;
        b=sBILp7yYFfY7ZnBcXq75HALZUtXeoJa3xWWSSbFw8X0RYVdQgLrW/2yAjUYDYTaUoT
         RwWRg2Uv6eQetF8PtngokDCbBSsASVq8OAj5DrgO8dSkp386U3R29CwXMy89BtPyb8C0
         icOenUS7WUlit0CNMGe/mPJYCD7VW4zhHzDy5UjURVX5knVF6NqZLwNdjQ+YPJhTYHVu
         GgQ03LQCLaIEBpJmpqrHXFdMG/zitQOLFkIzV1rCQ3QKsnVQW4kn34uXOYrCMF7dw8Yf
         spxfseqoi7uCXZGjHO226jGFAhNVJrzYj4VolBn3np/7sMY/AGFH4fpfU33qfFd0gNm4
         ZKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789593676; x=1790198476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zw6FxUREID0PCniCeTsRHMTD/jZ1i6ijXt3jNF/PRHc=;
        b=aWbMoH2+ih1fZUdXTtrcnYfYlPQWxY5ovyZw7wzwYH/IuEpvBHjHQMe7LC7toMPbhT
         3w3uoWpqebcEM876nNnbSq9w5fXskE1pd+wEu/CpLvj6oEoT/UXHkXz0qSjbRPg32Rkv
         xaqQiupr/t5ZMIx5YKBktE3uMNxIkSEJiG/htDmrFqOeQWZI/Gvn5/+f4aPYNYWdu/rh
         NMJjZ+hsrk1LJZFlxCQsZcKFoAAMll0+c1o+K+QHCJdnDC/KcCR3pZEjALyAIKYjt4o6
         vpHboB2OMAagfRAlCT45hjHtEXpN9tKyUj2bhpzBBvwudRU25BejysYX0+w7w4E0CiJu
         16cA==
X-Gm-Message-State: AFuF++mvcGVOlHi+U1oIm0wlKy+edTLARuyyhHUbnGSJlvkA/ZxnuexJ
	kACd4dHxd4/KtUOM3AQFe+MktH5j6oB6+iWCrks1iHkAF9F0qjiK7QdLscAM3hul
X-Gm-Gg: AYBFou0jqu9ToWFVFLmMGJryRlo7TBgGlYnx+ukRPQZAHAZAHIRUWhukGGLYz32uS7l
	Qq/MivNF6xBp0WT08TF418QjX22gXGPSwQCpHqMlFRgwK3ARCLU6yLfIVTAwVN9kwoyJruLAe0I
	LHQdZTgCLFKBtyu5yGo2ZzsXXdRKuRxJbzAMyVNam8iCCi/eS47yfMT/GqCkqJmKpQzF951fv8X
	zK6TtzBQ+GDJ+IEJU9fSvk7ZdibH2s5Q3PFWxFwCHQo/NQP4zXl4Ko0Qpr/D7AMk6k3/KZTqmk1
	pyFGLQ7gojR4agEKKDEocLVpH/sYOiILazHz+X5B7wk71iUCs4c4fk3hl/mdKC4IW7LI35FRwuM
	DDsERyrluWD5R+ovwURFcPOgTSGh1pjV1lQ9dx3rptV/ULqHaDE4WwtFpY1kexyA1kFLLkvqZLl
	CI41wWjNgdlZqqZ+siUW9Ipp8SfpTQ6n9Vld+FeBwHcfDIMVFYjEvcf5F/vcbg0XMuX9Cyvy8dj
	VX0k0ls9bIPcTOqbqI16jhQMmoBc6RsOBqeH2hsP0kq5zIHkkiqx7H7xypcF7gD+0CYcuDf7tK9
	3erPZK+vJThXMhSuLhU6zfwyjAB8OY2stzxKNpI=
X-Received: by 2002:a05:6000:25c1:b0:485:8c17:976f with SMTP id ffacd0b85a97d-4870d26e337mr4983229f8f.49.1789593675746;
        Wed, 16 Sep 2026 14:21:15 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf33e01sm11024104f8f.23.2026.09.16.14.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 14:21:15 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 07/10] selftests/bpf: Test CO-RE instruction poisoning restrictions
Date: Wed, 16 Sep 2026 23:20:54 +0200
Message-ID: <20260916212102.597335-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916212102.597335-1-memxor@gmail.com>
References: <20260916212102.597335-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4517; i=memxor@gmail.com; h=from:subject; bh=5Gge4/kf3wuXooPZ47g+N8cibmEKDXxenitkizO/foE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWs1h/zHnV8dyhmf3Fk/b8LZXa9n9/faWRfIrX64vWvDW qlpLxxVO0pZGMS4GGTFFFlK/u9jMj5R+TvQdhk3zBxWJpAhDFycAjCRvcsYGa6kiWqk9x6+KrK/ W0ZFnrmWqyhEcp/MuwscTUu0NrxbuJ+R4UvG4+YF0/KvM3zhOR59J2bbVPUAbrPPMwrcTv6f/lo wnA0A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add raw CO-RE relocations that fail to resolve their target enum value.
Place each supported and unsupported instruction form in dead code.
Unsupported targets must fail relocation with a diagnostic even when they
are unreachable. Supported ALU immediates, memory accesses, and ldimm64
instructions must still be poisoned and removed as dead code, allowing the
program to load. Check that both halves of ldimm64 are poisoned.

Load every instruction stream without relocations first to ensure that
rejection is caused by the relocation rather than the original program.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 64 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index 10bda3ff80eb..95c1414df413 100644
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
 	struct test_btf {
 		struct btf_header hdr;
 		__u32 types[18];
@@ -93,7 +115,7 @@ static void test_early_core_relo(void)
 		BPF_EXIT_INSN(),
 	};
 	int access_str_off = 51, enum_id = 5;
-	int btf_fd, prog_fd = -1;
+	int btf_fd, prog_fd = -1, i;
 
 	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), NULL);
 	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
@@ -124,8 +146,44 @@ static void test_early_core_relo(void)
 					       enum_id, access_str_off, 2, true);
 		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
 			goto cleanup;
-		ASSERT_HAS_SUBSTR(log, "trying to relocate unrecognized insn #2",
-				  "poisoned_load_log");
+		ASSERT_HAS_SUBSTR(log, unrecognized, "poisoned_load_log");
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		struct bpf_insn insns[] = {
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 1),
+			tests[i].insns[0],
+			BPF_MOV64_IMM(BPF_REG_0, 0),
+			BPF_EXIT_INSN(),
+		};
+		bool is_ldimm64 = insns[2].code == (BPF_LD | BPF_DW | BPF_IMM);
+
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		if (is_ldimm64) {
+			insns[1].off = 2;
+			insns[3] = tests[i].insns[1];
+		}
+		prog_fd = load_core_relo_insns(btf_fd, insns, ARRAY_SIZE(insns), funcs, 1,
+					       enum_id, access_str_off, 2, false);
+		if (!ASSERT_GE(prog_fd, 0, "control_load"))
+			goto cleanup;
+		close(prog_fd);
+		prog_fd = load_core_relo_insns(btf_fd, insns, ARRAY_SIZE(insns), funcs, 1,
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

