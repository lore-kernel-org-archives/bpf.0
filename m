Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184E36B067
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 07:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788591631; cv=none; b=PCGxZ3XxUVbpaNS1wM8rOZgEksHXxF8IQXDmy9k6XEYFTRo7fyr1mh56Xh7ytkVfu1eQ7q80NKDSg2rfGm3NTEysKf4Awp/yzP8tCxVde2X24+rIKpMx1fHCWK3ENDRiTqLECICHjKV3lA9PMa19UTDJyKl0GpfH1xSGXAaF718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788591631; c=relaxed/simple;
	bh=gLoRNwTBM64w2+2OOE6+Fgx87ufkxTeefRPsghjEqAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IN2YgbzBHj5f57RJbgdxWqypLtf+4fhwAJKLY3jrG+GCp3Jy4A6GiPQwNHADCPzONcaDqgR4h82pPOynH5ec1JyTNgPBb6bdsB66YG7op9CjUhHINY92PCl7wqFU/6/mwfvsbRZcnhmDxUNAwQYVDTzHYlvXW7/TmRRvMSdS8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4QKzmZ8; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4QKzmZ8"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso7940495e9.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 00:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788591614; x=1789196414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ue9JU3bNLaOsolZpdAaaApR24a5+ISFSUyidiDRrX6w=;
        b=M4QKzmZ8Ls0z79LqUg7eDnIyq0PTCv8o+revbn/Lp3INTPKm3yBFp9zWRxFTvufyYB
         szXLRFDAf8U6pIbx4SFMRmgSkstxSeTVOzGpaH796Nz/kj4B+SjZaD+R0fEhsul1lfPD
         wdUFbfbOBZa/nwBpZN/1QQlEntsDgNfuOvOqZts634j8i4qicCj87vjT1yQcGGZ+UvvC
         YI7hypBEoGarWIKkbKSo9IS+lly7+9zODu5XQ3KSxfVfTjUpnc3djZ3j/+0d0LbxviTB
         /hhGTNaxP6p6SAQmS48kyQpcshxEq4PhV9JH4TsL9R9B3IcN1CdJI5yDFtMKjntemU4z
         G20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788591614; x=1789196414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ue9JU3bNLaOsolZpdAaaApR24a5+ISFSUyidiDRrX6w=;
        b=EqnUH24ji4SnyB+PMWl3u6s/pm/sSN0yeKa1rm8cV23/It/cXTQ+tQ7UKR+2/4YmZt
         Fs47RqXDPPwfdZmZp27xueErtWBAlt/Acv/8SwZyuJAbXWPLErW6l/Sq3wG9gAV5yt6+
         2Z8I1FjcJrlrSWAiRgLCeyNtwKqXwI00ik6WoDK7LN6utspDFJP0CY+sItFtQWRaHua1
         f5iZCT4KRCsSI/tn9AIa2P79ZVS3Y3LRTPSHvVGjKhnXrHIXXNWWkpX0uho5e+4XU0+k
         qkH71tguFDTKaL1xACGAeoPxS47Fm50acx5jFOANmAmWOMFJImO8Le9WOoQqpy/uNTx8
         jotQ==
X-Gm-Message-State: AFuF++m1wWuFHNEVLE4XMw8a/Xw6QM/9sjfRLWAhzgoOppG14oEhXjx/
	BrSO38FLsAT6+VI5Db50djUrLJcoGmeBgfyYGiaifF0U6P41/YasLiqbiOcYl0eF
X-Gm-Gg: AYBFou2VXd8t0hGi2go/ji776zQO9IWeFFbJsZCahtzn4sfZ0DLhDIXOl2v8+Io9bsD
	ExEwSnfUN1VhE9FMseMSyay/nczT9lPoY84nsRLgYqUv0sjSn1H9Pa7zKB+lbFLlnKs/dH+Aoh6
	SrW+V7zUoVbRsHW7+RG9XYs/FVIKUIdGh8hbS2kxiEUO6SCRy7XjwvD2w29U9/qGzV541qh56FH
	KurxYMgVwg1q71voQ5Krm3Om7gEhydBr/BKNQmx8p1nxSFEN4uMXJwCbedXHzOcyClPMNzvJP/B
	9NvQSE78cnjWlwIfoJGLB6r4rLD1c06AoSZllBKf8eCAOAmktayxoIWjG5GdW6RnuQeXWvw+4Oj
	L39xdMYSCtQHN8pIBnoXNWlLjFm3JGLX8JGFiKLUScS43KgKnzvEjjqHTqt0oVNEiLB5PBdaFgJ
	NVscEdQb+2iNAVXfnTS3Ji+6XU5IY/YoJQrNIbnGIIeV+UFGCIBc3FQBA+doRX9FImLgjKmJmN3
	1x/cAPM8MTSGA4akh/ohdqfIAXzl2h6rO5eVelxQulKqNSMAM2POO0+xm2P2OW14/a0wJ8VXtDW
	SQC0ebJuhPa8k9CqbTOXyzEb3mc=
X-Received: by 2002:a05:600d:4452:20b0:493:f140:c3fb with SMTP id 5b1f17b1804b1-49cf81f1542mr149132155e9.7.1788591613713;
        Sat, 05 Sep 2026 00:00:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm13050174f8f.25.2026.09.05.00.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 00:00:13 -0700 (PDT)
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
Subject: [PATCH bpf v1 6/8] selftests/bpf: Test poisoned subprogram terminator
Date: Sat,  5 Sep 2026 08:59:57 +0200
Message-ID: <20260905070003.3193366-7-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905070003.3193366-1-memxor@gmail.com>
References: <20260905070003.3193366-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5002; i=memxor@gmail.com; h=from:subject; bh=gLoRNwTBM64w2+2OOE6+Fgx87ufkxTeefRPsghjEqAs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv23uXf9jhteJh0mbNcwDlS/WQQW61Va6hT2OLyVbln/ jSsv3yso5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPR38LIcNn13vsVcnrt3810 zpRqn92yalZDedLz/g/xn1Y0eZpWWDD8M0j0fL/02TNGoVNzlnlZmqjH5v59VLz3fcuxXImojOx 3jAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a raw CO-RE test with two subprograms and a relocation that targets
the first subprogram's terminal exit. Resolving the relocation fails and
poisons the exit into a call instruction.

Verify that the original program loads without the relocation, and that
the poisoned program is rejected while constructing the CFG due to its
cross-subprogram fall-through edge. On an unfixed kernel the verifier
instead reaches the invalid call after traversing the malformed CFG.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/core_reloc_raw.c | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
index a18d3680fb16..c350fbb95845 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
@@ -14,6 +14,117 @@
 
 static char log[16 * 1024];
 
+static int load_core_relo_subprog(int btf_fd, int main_id, int sub_id,
+				  int enum_id, int access_str_off, bool relocate)
+{
+	struct bpf_insn insns[] = {
+		BPF_CALL_REL(2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	struct bpf_func_info funcs[] = {
+		{ .insn_off = 0, .type_id = main_id },
+		{ .insn_off = 3, .type_id = sub_id },
+	};
+	struct bpf_core_relo relo = {
+		.insn_off = 2 * sizeof(struct bpf_insn),
+		.type_id = enum_id,
+		.access_str_off = access_str_off,
+		.kind = BPF_CORE_ENUMVAL_VALUE,
+	};
+	union bpf_attr attr = {
+		.prog_type = BPF_PROG_TYPE_SOCKET_FILTER,
+		.insn_cnt = ARRAY_SIZE(insns),
+		.insns = (__u64)insns,
+		.license = (__u64)"GPL",
+		.log_buf = (__u64)log,
+		.log_size = sizeof(log),
+		.log_level = 1,
+		.prog_btf_fd = btf_fd,
+		.func_info_rec_size = sizeof(struct bpf_func_info),
+		.func_info = (__u64)funcs,
+		.func_info_cnt = ARRAY_SIZE(funcs),
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
+static void test_poisoned_subprog_terminator(void)
+{
+	const void *raw_btf;
+	struct btf *btf = NULL;
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
+	enum_id = btf__add_enum(btf, "core_relo_subprog_poison_missing", 4);
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
+
+	/* The same two-subprogram program is valid before the relocation. */
+	prog_fd = load_core_relo_subprog(btf_fd, main_id, sub_id, enum_id,
+					 access_str_off, false);
+	if (!ASSERT_GE(prog_fd, 0, "control_load"))
+		goto cleanup;
+	close(prog_fd);
+	prog_fd = -1;
+
+	/*
+	 * Poison the first subprogram's terminal exit. The verifier must reject
+	 * the resulting control flow across the subprogram boundary in the CFG.
+	 */
+	prog_fd = load_core_relo_subprog(btf_fd, main_id, sub_id, enum_id,
+					 access_str_off, true);
+	if (!ASSERT_LT(prog_fd, 0, "poisoned_load"))
+		goto cleanup;
+	ASSERT_HAS_SUBSTR(log, "fall-through out of subprog from insn 2 to 3",
+			  "poisoned_load_log");
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
@@ -120,6 +231,8 @@ static void test_bad_local_id(void)
 
 void test_core_reloc_raw(void)
 {
+	if (test__start_subtest("poisoned_subprog_terminator"))
+		test_poisoned_subprog_terminator();
 	if (test__start_subtest("bad_local_id"))
 		test_bad_local_id();
 }
-- 
2.53.0

