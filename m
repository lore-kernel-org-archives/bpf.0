Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6D4D5997
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643520; cv=none; b=tKEEDUT+DCNtO83WToRfSUUBlzHicQJUC92282C1/maQx8dqrkBHd5r04vs2mQIvBMy5bNWQErm/7ZJuomIxjZqGmmwxx7qxjGuH2QRrkHRfQiQJ5ZjKEVOoZRjau08zR+HS0+gfRy1RcF234qmtF+jdIrz3aj+mHbGfWj9rR6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643520; c=relaxed/simple;
	bh=s1s5m3KVmgbK3ZOJo5RXqJIczOkmiw8/KV6fOEcHUhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhlJxDuXKEN/CKKkCuaON/P7PoLMsVI7jHnahEYc5cABzQ2fA2MkZFyyHJc/hEZoRAaGFgz7h5EhV5iU8GaF2/5LZH6HCaLgxDZb3SbqhEOifG9T+toAA0AGDHsxNdSBiXh8o3gQP4jlQmJ0KmVNVeegemCf4Aohi68pm2TCJMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i08D8qB3; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i08D8qB3"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so1284475e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643497; x=1790248297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8qw6q0NyzsB4Er2R4HBwsyLMKFd8QVGcLbW/ssKon0=;
        b=i08D8qB3wSKlYQgIl3L/YaBd9Cp7RCHDVLagpbDOub+A8wd9wy7raVfsAwysuxGefi
         n91rQ4vpa+DK/rUmA7DtT6nIQpEtBJvhAzlC+xXhu4pEOMXxIS7GXv6E2jCCHFEQOyLz
         bGUaVpsmaI1pOi5PzWapSEblziNQQWrdpCHs8UNeS7rMuOBe5AS4+QYBcRqEBFD3QtPV
         rZtLS2uwgfk16ogamwI/UMm/BfUtRvS0ItJuxqdt2YTkghH5ymDx1AiSyy72NGtGNnhQ
         30ydJ27uWNCRRRSzPghZ7VrYT+lX8lVo6dUN17xilquWmgKqjulJkxT1rJcGk4v7uEWu
         u/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643497; x=1790248297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e8qw6q0NyzsB4Er2R4HBwsyLMKFd8QVGcLbW/ssKon0=;
        b=Pkq7IrhVQcUxdhV3drqC7p053D5Dxeiydqvx1HoGOKH0ko/Yc6magYmOHv/IX8Resz
         DiagI9xoYLQj51uQFBL7xZRGvScIdDnffMcd340nm2V8d9nmKgeXQArlguaIR3T04RH8
         py8ZJBXU3f5NIlSZjbgEAjx1E1R2yQsKitV6NURjAi2BpfzaI+Iswl5nn11Ph70dMOnM
         PDL8tBgoRfZtxkP65W/bX+i5nxNC7LDkbPVut211bXetwmLqjJlD3uIhpV8MNJqWCR6x
         g38jQIVyA2kkY+UJI6Ba40IYkZbWZw7stpzAEPA4leVSYfibqUgdTZgoH/LlP2C52uNC
         xNCg==
X-Gm-Message-State: AFuF++ndP6ij/ZUBSB36rALSMeX0awUxYlEcZXlKXLmMNGJ8TizeyXjw
	47o4kcuMFuEHNwgANHT8ZsT0f73vDy5sDxudnCWMZ/J0t7xQ+h5PksPLiUSdOqeC
X-Gm-Gg: AYBFou1Zmh2k7YZdbeGnapuLUADu3ZlHaqebFP80ZRmSJqvbchL1C7WGGWHFbOZcWkg
	MIHN+FvfYhmeLSHVt6vZ9n2/kGZbI8AIRpJgcvguED95KR5/Wo7dmXnpUJetexMWERQDrNHcGz8
	L9tu5F3NbnGE/We/oXLQ5iFsN7OA8c1q2dAycGIvo+C/W28U3+FvTQ+NThWAbgqkTmG4NRYq7AX
	z58BGQF0TvHsreCRZ5fpWQuMX7gX2yVsbM4KJEccA7pjUX+Wwn/kiIh814eqHTfHcHnnn3LHGje
	ErniCU7HIxqlWofoqgSDX1rJP1G7YLzisAoTxrh/hj8TGIq8S0/i4UwqWp3dTghtFTBh9rCfbxp
	lsNBuqvmDKvoTve28BgBaGZsfHvSxlcHBVTSiWKzbWjN8c7r6xHYz40Evnc3TiyRRSFdnSMtJPO
	SOr2u8NbJpwMvUT64T3e8ICGyrZQwLgv3SUcBc82pLBR0Yb8MqnOZph9LCX1CtNuIbDXQoVvD+l
	L8maDclCGpl8Qe12PMmDTIWiLZJICCbpW6uoq3xIw8RUOuKAX+OB6iXWYasdAPTR+TQyl8Drqf4
	hhotwH2Zpaj6eriEwQF8Y0hseHdGUDY9QA6M+6qMdHNngwMD
X-Received: by 2002:a05:600c:1546:b0:49e:67bf:7e97 with SMTP id 5b1f17b1804b1-49ead86eb48mr77791955e9.10.1789643496781;
        Thu, 17 Sep 2026 04:11:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847eab65sm89330855e9.2.2026.09.17.04.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:36 -0700 (PDT)
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
Subject: [PATCH bpf v6 05/10] selftests/bpf: Test early in-kernel CO-RE relocation
Date: Thu, 17 Sep 2026 13:11:17 +0200
Message-ID: <20260917111127.3780880-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6414; i=memxor@gmail.com; h=from:subject; bh=s1s5m3KVmgbK3ZOJo5RXqJIczOkmiw8/KV6fOEcHUhs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qaSXXHXPzry+bFIQ7H4u446EUdXdFffzPRfI7Z63a rG6m/LkjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzk9huG/+EL3hxdZFnPz1j3 j/nyL3uN3Qs3RvjFLaiXaay7vjpXVZyR4d6XPV85gwt4D7F2fQ81rNK5IB3N0v3Kc0Huu/9ubW9 1uAE=
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

