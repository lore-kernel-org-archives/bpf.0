Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D453CDBD3
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687959; cv=none; b=DJo0V3s84lHhF0fSUmdCYHqm3NgT+kDcO1WjaWdtSodeu3neGTx2XUgsKMbuJLviwEijSqLomV6WkoMRnL1VHGSQuRjZ1QqyfKzd4kNfvt7oA54s16jiK3UgLniOUr5JZyHpLBPPIvzQthCt6Q37ug3Jx98Wd6CEZW1VoMCnMIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687959; c=relaxed/simple;
	bh=FcwEJc/uf1TvUWgbnIhIy+oeJW81d1P69Of1HRGFLvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FR5JWdeqhssTDPyVdPXKDMwHOJUvU9bIW/movjK+P4/jR4QSZNA5Wtfgu3yEc21QE8xjwSKM+ytZBOjlOMPRay7LhY16z8yBR/nvKNrdSiMk7J5uaRxJgRbuwOjRXAFFcY1j4qdoUyp7652aVvGbFRPFhb+UwJKiXgng/Ha8vrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpE2Gbq4; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpE2Gbq4"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48437576531so36928f8f.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687955; x=1790292755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7cl32tFXRO4/hDsj75WgEnCjAEmjUTCCrcG11S8/x64=;
        b=WpE2Gbq47u8v8loP2gD5UB+8mN3xEskUmwmlfbYTkghw7vib7DnyVDwYdpDquwpzPf
         Vt+LNECAxVXVYVTbRxTD8U19FBIGn2WJGnUCTZPbSSkfCTUL1vxxL+cvVTCrAz+o0xaV
         KNiGBhS6elOxdfTGyE+owbAZCVJAM0l78Ag7deNKocvfH+ynYTj67RR1L9i1rzvTuVgc
         E7LiEY/puLx2R2x7EfdNd5s6IyT4XaONUNFcZBKNjHLcwkfJ/yzx7Gu36fvvdARhKaUu
         Ie0+nLN4rweJUA2cVWwxfWGtSWZl6mLfzab4f4O5HAab1RaCgm0isLTJsyiPPbTAG4Ff
         Pgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687955; x=1790292755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7cl32tFXRO4/hDsj75WgEnCjAEmjUTCCrcG11S8/x64=;
        b=dACYdw8MKWWagEHJXXlcmWjWYnCWBBT5kjsF4An97e4GWoCltV8mZ7QDZ+T8QEFtq8
         M5BAlgYUMZBVGF7x70NMbJ88+F5u9FA9ur8K/HPcY9B791U5FIM4zfOJNj9AY3gVzMPm
         9R2Ki2j9BbeB4cfkvCmt1+pF9Zn0KliFOdGZ5cx5cvK1Q0y9givHVRZpbBMQGlVpP56g
         7Z2WVoLL5hJJMj2CG4pmRAewCBNN6rgSARcfQrqgfDDBC+k7gIdtxPY4CyvePNkoaZ2W
         1S15TCEZ0OSQV060PFFUxXlyAISnnplPlOaLyJH8Kx4Rmzp+gCzcS8ujPuGSULI2PKeM
         m79g==
X-Gm-Message-State: AFuF++kkVqoZQtwKeIWF8ixDfH1kIOtnHtST8rlJ4u1V4Qj4KQ0gszXh
	y4SrXEo8m1uqy0CTF9SP/3zQNZjBmtTbWXvIGfuRnluFC0q8fueBbasGfVZ66hCj
X-Gm-Gg: AYBFou0NEXYgI+RslmOZL5WqUcrjsMY5RDuCXQcktASyxdw5H7djSl6as5avr86fPa2
	nErdb4o2BP/tM7JqK9JAYIodWjqtPIjCsWOli7tkiq7/isxC7vmNjIYe80o8RxudO1kkfVarG98
	8ZXiPEyMluIBXvuYXJ1AF9aySWpBZJHVQ+ZJF18N3IEN5foRBGPLccbpsEz0d1l1GUyCpYKnIFE
	qgUtXTLNtbtmpnK1hEXYQZPD1KywuB8xNp7a4BF5RSTtCqETxUatvbSWOpOXgLmInstzOfPISBF
	Zb6hRRgXAbYXrS55rzVqEMA1NKLMlTlaBWz4r1aY0quisN+M0hAadSHllCZ59tzxcTgvK4SsmKw
	3XWdGp6nz+m/pplAQsf4J6dpVU24u6vwG/pLsPUlFn81vZ1YsnSTqok9dOnvQTzZ0AvcmGJSNiq
	+8FaVpWV/pYZTACqyc/OfVfsDLfEBCFuG79tkMp9X3zdXvKsKW4eD39LWIBVIx7+G7X6L8f0+DT
	EC5fgeC9aQsYYLkGU73KuBOc/425Giv0Jd9zIO3E4jzw1I6mHSrPZNPm1QXna2vASeDRpWIjPVp
	IHckV35AuglbIjlUT64sQO1dIQooNds6AM4luQ==
X-Received: by 2002:adf:e003:0:20b0:487:1f81:e4b8 with SMTP id ffacd0b85a97d-4871f81e579mr10878f8f.20.1789687955276;
        Thu, 17 Sep 2026 16:32:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf4161fsm17807767f8f.34.2026.09.17.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:34 -0700 (PDT)
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
Subject: [PATCH bpf v7 07/10] selftests/bpf: Test CO-RE instruction poisoning restrictions
Date: Fri, 18 Sep 2026 01:32:15 +0200
Message-ID: <20260917233222.2542500-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4430; i=memxor@gmail.com; h=from:subject; bh=FcwEJc/uf1TvUWgbnIhIy+oeJW81d1P69Of1HRGFLvA=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRdYbTa6P9jpSs6NXaZZ4CS+zDj35aeee0rTPAX+6E rXe/UzoKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwES2SDAyPN7+kunwKz2mOq/4 jQUy3/0tduv/WFwkHpnTxdsd9n2XDSNDV/RD14p6369qj6TOyE5ZoGX6m/2N9vptViu+9Yl8viD JBAA=
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
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index bb19e49dd87d..51f42b02a267 100644
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
@@ -97,7 +119,7 @@ static void test_early_core_relo(void)
 	};
 	int access_str_off = 51; /* offset of "0" */
 	int enum_id = 5;
-	int btf_fd, prog_fd = -1;
+	int btf_fd, prog_fd = -1, i;
 
 	btf_fd = bpf_btf_load(&raw_btf, sizeof(raw_btf), NULL);
 	if (!ASSERT_GE(btf_fd, 0, "btf_load"))
@@ -136,6 +158,43 @@ static void test_early_core_relo(void)
 		ASSERT_HAS_SUBSTR(log, "invalid bpf_ld_imm64 insn", "truncated_load_log");
 	}
 
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
+	}
+
 cleanup:
 	if (env.verbosity > VERBOSE_NORMAL && log[0]) {
 		printf("-------- program load log start --------\n");
-- 
2.53.0

