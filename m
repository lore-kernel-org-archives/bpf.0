Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699C49E5FA
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789424727; cv=none; b=cPo74pNCoK3GexC3J6gaj55zGgojesCerOYFS8E3oubv72f1XzmBEKYOag7+5/grtWHMtsQoztznl/MfhtpUyop5jwJ0xqaFeg1E1XQBBeZxbkmdru5nhSR3S0sRhNRBOc9q5IzZwWBsok8EOqrVGO0uJk4xxPOa+ikBXYHru+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789424727; c=relaxed/simple;
	bh=sPPlAO2GpP6ZT11W4B6oE0Ekzhisk6AHjjJsYcpc9qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyXYysBWLKPJAYA8IEj3/9MLvjBdRWdN4X/x1SL3+qzbFlslbf/6POPGKy4Az9aWyz8xZ7+cwR+33FgXmgkryf48csPaXhiA5liWsrWacPV+fNmoIky8UF4SStxReaUmxR37vyfIVXUgPieXYICSpkVuYiRLiXRo4liRWBnP9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vs3p22FT; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vs3p22FT"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49b0dd21eb8so10435865e9.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 15:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789424724; x=1790029524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KiLZyFd7UW53t616wY9h0QJ+tml8IQNAz9spCuinTx8=;
        b=Vs3p22FTTCCZNpFgCEicYPMZE2Bz9XUVZXWXQBtPbXyMOFHnVZrP/4P2IuNx5pEG4f
         AiDsYp3qXxrdpHHNrQ+/QQvH5PDupc/SuSdGFiyp6VRZPUGE2M1F4hfAC17hbqq+7kPj
         D7OwQm/Gm8nF9ZPVMKFc0MgBzag1LoLnIQPScSN0NN0g3HQTfvAIaNmtdM3kDIqBzFnV
         +TiFgirirSSzBexMCTU808HQJGDy0U6ufkMGziP5lC/rocKM1XKSaTE3PloQ17Xu2OEb
         jTgIoksrRMR6YemGr3SSy1TxWMRvtNyeKKR5SdC/iALus+3h0IwPrGlCGfiL+1Mmvi73
         Yn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789424724; x=1790029524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KiLZyFd7UW53t616wY9h0QJ+tml8IQNAz9spCuinTx8=;
        b=0QKfQtGi/ZknctqRmLZPNJzgF0pjjtobcVPNlmh8VuK7rwdWjQFMRJj+tWfu/uJgtL
         c4s1CD5i9xK1u41eho3vkfs/lkjNFFcK29wXTiES1mTRMGodKfkYfH4jYBUfcRefUQDM
         7iOm/mbtdO57+QVunwRd1rDKMZo8Us6nRksriFJZmUSE9w5QQtC2dKPhOBxYkneGRt68
         DHv5GtY7GfB99iO8Y7Jp/DRoV9K+UV7C7EStk/b85/S3wcGxU/yJkixhogZnTMd17K0X
         ARNnsfgjTB2TIHQGKkben8oZyusEQQU1Un8FT862tLnS2/+wqVTqAkrvj6GaaAdTHe09
         BZ9Q==
X-Gm-Message-State: AFuF++ldYJ7UjjvUOtg6t7zf/X3o2dXPTtcyInhebiuk9/O4vrpmIcQu
	QDGXL+1A9PXqYXFxRzzoeoJCsYAm7VUWOEJaPAdu6UJ1BpybaGCNRd/tDbEZnVpOtUo=
X-Gm-Gg: AYBFou1eKxj4qQzd5CvJjtXQPBsouHMuGdBsyo9Y1IySX1+CyWxNWb6hy39GghAWtdH
	Sl35PS1VSo5KoCfmF0Ea8gXCvtAM/UuRcf5bQxSAWc+OGMH7GfjiTF3Y4R0TFrdsMRluYAZC5+v
	v1lV1We99iyMXaiECCJTlRxp67JS+l2rpNNjxBdlswoCs2zNTg/gV0XZ0CHiceVREOWWm+HsPXl
	8BWOaNtEoHwSQnUFQW5cRmp02EjW9MfqlkmNcWzBXUkmYnZbp7nHHj1J9ftohpJPJy/ESA+jei7
	/fz7UKfsnWMF9K/vFjKfoIYeGPUD3gFk7vcmzripE2zSw086jwPWIoJSx3rTsp57hLaCHTeZpWN
	3vok2l/N/cVcnUukoUfncL9CrFAOeFdlHvYZQjMQ5QX3TQkvUMP89Vof9WuYcSQ+fOMvnn9erRC
	f923RCU3IXcWG+kDkXTVYIWKvE1Ys52gidW00FY14iORQjEGFkzeF47NOrOgTN8eMg1DUwoPblg
	9VQ30QwHol1kgIbJ2V9QVqS4GCNuuBiEpej/8s6ua7voQC2GQyJHkIrBKWEy3KfXjl77A/BTDwG
	5CsTxLd8J0utrE6wsKBJxn7DNlL9KQ4O0JTxUA==
X-Received: by 2002:a05:600c:470a:b0:49c:fea3:8633 with SMTP id 5b1f17b1804b1-49e7a677427mr53722155e9.24.1789424723663;
        Mon, 14 Sep 2026 15:25:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6a8d5asm19427095e9.9.2026.09.14.15.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:25:23 -0700 (PDT)
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
Subject: [PATCH bpf v4 05/11] selftests/bpf: Test early in-kernel CO-RE relocation
Date: Tue, 15 Sep 2026 00:25:02 +0200
Message-ID: <20260914222514.1635018-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914222514.1635018-1-memxor@gmail.com>
References: <20260914222514.1635018-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5801; i=memxor@gmail.com; h=from:subject; bh=sPPlAO2GpP6ZT11W4B6oE0Ekzhisk6AHjjJsYcpc9qQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtFiZ5c0l399u3rhVpv/N75KP+0/I8V/SJTjGrTFE24P 2bllN7oKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwERuWjP8s7s5M0FmErf2vueM JpuOepZ8fsWgoFmWJPBmqW/vN/cT3IwMu+ef8ZRUCXvFwlzyOONpu6Y144mtE3u23Dz368XD7Lr v3AA=
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
that CO-RE processing causes the rejection and diagnostic.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..6fdeba6d7eaa 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -14,6 +14,133 @@
 
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
+	struct bpf_func_info funcs[2];
+	const void *raw_btf;
+	struct btf *btf;
+	__u32 raw_btf_size;
+	int access_str_off, btf_fd = -1, enum_id;
+	int int_id, main_id, prog_fd = -1, proto_id, sub_id;
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
+	btf__free(btf);
+}
+
 /* Check that verifier rejects BPF program containing relocation
  * pointing to non-existent BTF type.
  */
@@ -120,6 +247,7 @@ static void test_bad_local_id(void)
 
 void test_core_reloc_raw(void)
 {
+	test_early_core_relo();
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
 }
-- 
2.53.0

