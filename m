Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D54D6C34
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643520; cv=none; b=KchXwkYN5aL3NfrPTmBTQGJHScuYQRIIpUMw1AsyBqKEUYcS32Qbo4FUKFI28gw7EiWFRuQVhEYUplKEHYEV1DGO6NPYXJyDv6sNEvOrd3hxUW9OK8B8gxvYAlGODcTYAXbgcgU7wpsYEnyAOrVdp5jEmVLua+FhpLXVuRsmrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643520; c=relaxed/simple;
	bh=5Gge4/kf3wuXooPZ47g+N8cibmEKDXxenitkizO/foE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXfHemgQmUfW8xDEW30V6s4STEwgNUQ/Tr29kpdvqRVt4phLhENygUub8KUoHYSZ+nHYxYTi1MOz9+jJb6PUutN0Kh3F6VXtDkpj8MbOl5CchC6287CzOC1/hCWLKtZlcJNO250jMG3GrP2bXK7XkaCgTfN+6N/SIU8GRtZg56U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2SwSM8n; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2SwSM8n"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso2665205e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643501; x=1790248301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zw6FxUREID0PCniCeTsRHMTD/jZ1i6ijXt3jNF/PRHc=;
        b=B2SwSM8nhyfVqHzM7McgGfjfG+bDDl4SqqBoj99t0tt9DQixQMQ1e4p3fk3EE14rpZ
         2WBxpred3LTiR556S5IDIHik5y50tBkVasLHqoxihqyD9dAM+swo+UlqOxCJo39ppbTK
         rr3z4gEzuU8PuoIdeNN1NWeLpK4v+F5NqM/HkK5TwYrfZNt8Sjw64EJyJTlA/8T8e1kY
         dju0BxRuNa80YylprdxQmy61kPz5UQk7pWgK2jINC8gTse72p4PfJwCw0ZE/Lnsc3yz8
         aMqYZiXHBuqq9jBJ/9qP+zz9WZVR/PYlQaJKAMHK/tOLhCnI1BJ2aLTeXE8iUXUYNEIj
         /ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643501; x=1790248301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zw6FxUREID0PCniCeTsRHMTD/jZ1i6ijXt3jNF/PRHc=;
        b=EidfAMccgB2KaLkoHBuoILpuZPaVsK4c5GIB11l8LnKHabQAWaI36TL5Zqn/GGmVC9
         m+hVD3hdeeKQsTtNzButDO1GhWoQrjVJO2Hl98nmnr64RNttj54dQbY/WlRcXVj8VQoS
         elsUdS89q2Nnb5LZtxk5X4QLluCkPZSoNrQ0Oua/AxJCHYgiVsLd5Nmx0K6Z3OAKlBVc
         ihJ0udp3zVpK4OWOFL/JITe53LEvgNpmd6enBXrGN+RIRBD9fjrbVe5dJ7WZKnlfz+e9
         Ov4CWo3iJPWVU0H0sCCEIK8G0nzSJJySfZZ8kGZh4CZ1EOlqourIJU7Sj5Yku3nI4sNE
         3nfA==
X-Gm-Message-State: AFuF++mY6PcyMclHL682e1KlYnP2ortrRzm0/wYe3KRXdaq7Ma0jYDnp
	X8NGGMeo588AjxkZMYU4mYzBvcEM6ZbzJviqtYt/m/K9y0YR+hGdiptSZzRc6MLB
X-Gm-Gg: AYBFou0WWAKi2Q+MHjODY14AqOhayyWo9s9mfE8IKz9SGv2lSUX+uVoD25naAD55zD2
	7q/hK9nvnJnO8/xi7+xHp1A0tRzjdAfZQUKDJItvK2Ww2GvvBMfgrOjOatbF6m6iGhagmqOw0sm
	gDviAjnhvYVXA8lcnNtqmDamlTU0OGziPsIrBBgaBWC715lZ5Xh3PttATN+TQtQ1PBaurtQmUB6
	+YwnzWvCTaCA1BQOVB+AVqBX3FBuLxlpohhv0Tcr/+68r/vNPmOQGTfkjTE0K17dEMxj1/xYlwM
	98DYDAeFo5oCRx4MHdyplRJ7jY5BbQmdMRc3ZWlLKVpd+a83Q4c3zr1M+J2uxFe7+Al+OwkBnk/
	L8grDMnKu8H181eQWyJRKiK3lKL4CTXIBOrlPzgMWnWMRlC5WN/PEh2XPcGwpbsA6CyQiBDr8iK
	1cN71EaWnsVWhoCIiDLfOefAhToDJ3ibT4vduls8naH+aIUnfTei+91d+x6q4Ot9nLWP/ue4GvQ
	xmyxsSpAudEwMWJFGYrbYd2HFg3D4/7OJX7uKeBZczJ2OlrqTLzC+ZKxiTx0NLxIpmeBLFB/27l
	HALCnMpMEhrdOTQPMRhql3pkIGVfD195hA4Zgg==
X-Received: by 2002:a05:600c:8b86:b0:49c:fff9:f684 with SMTP id 5b1f17b1804b1-49eb7320be4mr72638235e9.21.1789643500653;
        Thu, 17 Sep 2026 04:11:40 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27198sm14679278f8f.15.2026.09.17.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:39 -0700 (PDT)
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
Subject: [PATCH bpf v6 07/10] selftests/bpf: Test CO-RE instruction poisoning restrictions
Date: Thu, 17 Sep 2026 13:11:19 +0200
Message-ID: <20260917111127.3780880-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4517; i=memxor@gmail.com; h=from:subject; bh=5Gge4/kf3wuXooPZ47g+N8cibmEKDXxenitkizO/foE=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qeSPO786lDM+ubN+3oSzu17P7u+1sy6QW/1we9eGt VLTXjiqdpSyMIhxMciKKbKU/N/HZHyi8neg7TJumDmsTCBDGLg4BWAiq70YGXbb77j59/qJkz4O nHu+spY+PreYx/HXHGetsLipjnoV4h8ZGR7r7DN4u/Z0g1rZi6CpLzY9yjy6vHuV+csn7NGs5/Y v5+cHAA==
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

