Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251804AEBED
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 23:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687956; cv=none; b=o2R3zt6LO1fKXhv/hLFsqt7tdLNQknG9Qhuw2XjUcMwly/N+DXRiJZgNrtucmeixqWmYvnuUjncb9cr9bQyG76Avu/161NiCxG8ZrxGHPqPafwlz4LmnZaNE+zbvSEuxgBE5cbrO1h/zDqz60JxL+zfy5SqwgdfvIF9loVO0jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687956; c=relaxed/simple;
	bh=mkinir+UBNk3vdzZNlkXbtuiHJwEYGpsMU23l99GGGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXvh1TvhWIiLxTCUyBFYEG5/jF7PC5cOPN71SPbdRzEry7wq5ORp8Kzil8q1Id9TGFSc9SvNxDKh+q6SuBfjzoI0kD1idIaF+HpGynLVAM3VybRktWyszzOQMQe7KA0255xG+ADd5esmIOqtGdTOLyum+1FMgVawNZR6XyGRrLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riPynZo/; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riPynZo/"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6e43b9d8so523535e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 16:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789687952; x=1790292752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gImmBOdJrOYNIrpSGZYGn1eRc49o08mPS0i9STKAYnM=;
        b=riPynZo/1AAIqhA4A3TCcKsy32J9yEZ4Zc2CpiEaCSBu6i5G9qI/40D990S5rNx4QJ
         xjHrnPPcsrcyue9dF7BM3MgtyvYYO5gY8PMnGedf3pnqcpV8OHJkTgh5z+YCLZX+7lUi
         rZJGy6ulGm2FqFoMnKVMpb6kcfB0QxFALifBihbKugtFARRei+yJuhrF0Qwh02ckGrdx
         5rScIbG1IRUapw6lK9AlW3GOxjZIrwDZpzvdK9a4FuOLKzAC6ZdHZLsnkLyh8NdG0u5U
         2hE6+cds1xLBzuBkltTNKH74msbHjxNdD50ehMvTcDBtq5aq2StzjAOX8+EOpjc6yKMf
         +Lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789687952; x=1790292752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gImmBOdJrOYNIrpSGZYGn1eRc49o08mPS0i9STKAYnM=;
        b=JM94dTzu7h6+I8UR+JMMyzaQQuOTfCdrJMflUVCV/EQ/dwa9Umw+2cAIwRIgwH70D6
         3pLPlQAA5X2Y5CE49P8Pnl0zItHd1sADsCrh0yqs1VhSxuX6sy6qaO3ErB+9fZQPm/oQ
         m68dYV9kpEOFtqZgFhANpIvUDXz4jOcQZe1Non/gTI7uYJjYfBNPHbVe7hP4aqohClRy
         My9EIIR4RFsyQ7b53Cozd4QPKXKa98Qo9EoJsI5ITL+hF0EV1gwR5xfbDAsWmUKXuIef
         HNoNb8PSm70Ta7xQRPjUM04+gZa6dQPAbSH5HOtJ5cfi8nlKLHzaCOPcpzKTZPz81XZd
         q19w==
X-Gm-Message-State: AFuF++nxZ5+nYJpSgTosumFzo8TOQ6nhqUYvZhQIck5SVcRv8zZYmxOG
	K+GEr2x0bUYqbXTFJEJqxwhjQFm4EMvSOcpkpvLnRmDEqHCb3WSfyNb0pYS1ScVd
X-Gm-Gg: AYBFou2W8vTQRrFnrhG44U1JRDxNHHp2IwcVqXEXy9Zz8L0t3/s/lx+atW7mWbBBUAF
	xGNH2V+KWtawWkDgeb6HK0RGbq5BAoQK4RjU65yK61IlsSMW0Y5cwsjIGV2xzrCyfwkhz/JS3Um
	TN75GopS0L5ZqTKeTpn9B3f3kL+eaZaDSnC4tP5GOcDZVtsx44/EsL6cT8vy/suA3bGgQoOF/5v
	8vuoeJTDaBDXwikRF2yFSzNbrkHPHdIu5UFkys08ZHcKnC4Y/6eDJ4255EVwNp8scRH9uGoXyyB
	JPDaXeOtMGFFcD89Vh50djDEbFOjXe1cDSI39a6oeam9gjIsfZVXtMy+clZm5sFto5bsqXfS5fq
	yXF5hpgBh9GU+Hpaqu8QJ26o8n1DXgcD5dLkpuk6Tj+ejBA69tafXYbrakoHrU5LG0+1IIALwl8
	ir2jH+zkUbBEOcwvzrT5/UdpyKrJmVep4ep/2KNkI1gN9LXuO1ZQs+Yn0dVUZ6JEMglUsm1Lq+H
	WPp4c2qEVdg7Z1c8YSSjybth/vVB3mgWwsJ1LRZff9jzD3oDZerVwHN7WS7BQ7POP5DXxVEJ0Tp
	Hphw7Cz7xxojBMR2sCY1sdZfouBT2bvd/KR6xg==
X-Received: by 2002:a05:600c:83c6:b0:49f:bd3c:bc17 with SMTP id 5b1f17b1804b1-49fc572f20amr5553385e9.18.1789687952130;
        Thu, 17 Sep 2026 16:32:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf26c8dsm19081737f8f.14.2026.09.17.16.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 16:32:31 -0700 (PDT)
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
Subject: [PATCH bpf v7 05/10] selftests/bpf: Test early in-kernel CO-RE relocation
Date: Fri, 18 Sep 2026 01:32:13 +0200
Message-ID: <20260917233222.2542500-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917233222.2542500-1-memxor@gmail.com>
References: <20260917233222.2542500-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6376; i=memxor@gmail.com; h=from:subject; bh=mkinir+UBNk3vdzZNlkXbtuiHJwEYGpsMU23l99GGGw=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtNRebk23Kv/yVxzl40oTX4wjMeHeMV004/eXSKZVef9 S2rMJ7EjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAExEoIXhD+/kDZ13ok5vunVP +uJr5ieZsaENLJI58bqNNix6a9b+1WdkmLpqxoc7B++oGPR1S/pw217NsfbSK918tdLhsb7Phvt 7OAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a raw program load with CO-RE relocation metadata but no func_info or
line_info. Place the relocation in dead code and require the poisoning log,
proving that the kernel processes standalone CO-RE metadata instead of
silently skipping it.

Also give a subprogram a relocatable immediate as its terminal instruction.
Require the relocation's poisoning log before check_subprogs() rejects the
resulting fall-through. With the old ordering, check_subprogs() rejects the
original terminal instruction before CO-RE can emit the substitution log, so
the test continues to distinguish the ordering after relocation target
validation is tightened.

Submit a trailing ldimm64 first slot with CO-RE metadata and require the early
structural diagnostic. This exercises the check that protects relocation
processing instead of the later regular instruction validation.

Load the standalone instruction stream without relocation metadata first to
ensure that CO-RE processing causes its poisoning diagnostic. Encode the fixed
BTF metadata directly with the selftest BTF helpers.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..bb19e49dd87d 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -14,6 +14,138 @@
 
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
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_insn truncated_ldimm64[] = {
+		BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
+	};
+	int access_str_off = 51; /* offset of "0" */
+	int enum_id = 5;
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
+	if (test__start_subtest("before_subprog_validation")) {
+		prog_fd = load_core_relo_insns(btf_fd, subprog, ARRAY_SIZE(subprog), funcs, 2,
+					       enum_id, access_str_off, 2, true);
+		if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
+			goto cleanup;
+		ASSERT_HAS_SUBSTR(log, "substituting insn #2", "poison_log");
+		ASSERT_HAS_SUBSTR(log, "last insn is not an exit or jmp", "poisoned_load_log");
+	}
+
+	if (test__start_subtest("truncated_ldimm64")) {
+		prog_fd = load_core_relo_insns(btf_fd, truncated_ldimm64,
+					       ARRAY_SIZE(truncated_ldimm64), NULL, 0,
+					       enum_id, access_str_off, 0, true);
+		if (!ASSERT_LT(prog_fd, 0, "truncated_load"))
+			goto cleanup;
+		ASSERT_HAS_SUBSTR(log, "invalid bpf_ld_imm64 insn", "truncated_load_log");
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
@@ -120,6 +252,7 @@ static void test_bad_local_id(void)
 
 void test_core_reloc_raw(void)
 {
+	test_early_core_relo();
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
 }
-- 
2.53.0

