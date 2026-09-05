Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845EA1D63E4
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597272; cv=none; b=GzvIRUKmTIJNeHHNj24kVb0vV+gUx5ZlUiz5CkVv4nqzpAFotlziAyPesck2Rj2L9Pedu9cWD1DjdbgoRewi6yqPZS+F9jGH/Y8+XUe9btLGN8mtjXVCT5kKgK1XhoDz9wUrFR18DCI793W8o8kPCSTDw0HR0zha/A7vqwzRtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597272; c=relaxed/simple;
	bh=gLoRNwTBM64w2+2OOE6+Fgx87ufkxTeefRPsghjEqAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4vZpyMIyPfx2xK3xNGAyaFKxUkvwbHbUmmnJD5Cj1MRL40vynnCgw5k/S43WX7YOXoVaIPlKkGMHiRgnfhJcRgclnRpa2WzU2QW96bsvVC8rgYUpsLodVQRtsdz+IkvIfb6Z0fxKT1RdhM9A+YoDFQO53DQop0Wd+gmGRxWE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1WnBI2X; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1WnBI2X"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-482dd2e92ebso388823f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597268; x=1789202068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ue9JU3bNLaOsolZpdAaaApR24a5+ISFSUyidiDRrX6w=;
        b=F1WnBI2XPph8IsBSk390I0A2IyqGMNr9YJvue+CrSVOIT1JPDUu3KbEzDjFjkBz10N
         ODrUp69pYFxQJx63OwWnfG8UMHBam1OGXY5teYvOiCJPP3xl8wFi+yQThv7OZTb+fBlE
         RxDUE+jVeiKunYR8IuK+W9XT3GPUmV6Sft6baO0cWQuUB08qJYqGUZh+UowIF716woSz
         woOahXuYU17kTkzUZiE+RmDsdxMINpBP+c4HezDhOpLfkqJGGcQsUQ8CTHzcZ2+e8PM9
         46LKBNfHZnbbsunH/eSW4iqYZXSfBV7vTQE5FRO9rBDamAsS5HwyF3PTqJXqMunbgY85
         20bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597268; x=1789202068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ue9JU3bNLaOsolZpdAaaApR24a5+ISFSUyidiDRrX6w=;
        b=FzKlVkl0M6VGfK8vV4tZiw3dJN8Bd8bJHhhVdgXW2519wmAm+BsCkvOUHKXBRP31BG
         ZxoR401JenNEGFBwgcuxdrutMWktWrw1S6RYoQq1bGv4c5Bh+JyYAX2su0b88Nd8/3z9
         tUvOPTue+aPOOBhKhNzY0In47MHgNYJqWbeRaEOeuRQdmREaJ3XCH5VG+urFrsN4vL+q
         RRdkB0bvgg8uWC4F7GBFSY9upZ1WqQMQlMlKmYXYF9STVRuewUH5zZNMomtacsp+Vssc
         LKEBwOZrGaFQws4gdGsv5IQLhj48XRntfKzu3P7M/86hchkIz+2WdJ1xv/FCc0Hw9GeO
         8iFA==
X-Gm-Message-State: AFuF++l+uU1EVjtBj4c13pBSIz+hvrm6stolDHg0O/QhL7FryKBPOXct
	0PnCpscHOBTdB0t4OA/o26/bSh8+EUcvpxagP9z1aIWdOW9DV/4I7TOEmd2a4pZo
X-Gm-Gg: AYBFou2K1Nolzn/fdB4z9x4xzsiNSXaO0ZdlY2NryML3Md01cxaBED5q4yS0H2zsy0+
	CF+MGIsmbMUHGZYj1gv4mzQ2RaRpdsYiFDy1yzHcau/IFoHjXezYo+2ag5PXXddT1J1721Dhgbu
	0317kHMQebgHvQ0yjr3sAprnKcbSYJb/Qmt2Iiyr3qpLC/dp+ynvgncxMiggpUJwwioyfZmLE4D
	loRRmbLXapoz8XPgo5Z0Di/hTg/xpU4DDVr/Bi2/rcT8Kn4QEbBdaxj7xxzag6IQr2sIcfZD1tS
	pJ2vDAzbYelj2/ZFeJ1NNNRuHvZhW2W2r3OayB+P8ERkOc8kTBW1jJLNGPdS39AapHZdfznk05R
	NRB/S1xhpIypm1DbSm2vGcbQBuUyakkAs6yEgfiRuIAHx1RyIYhIEO1lnXN8ftoc9zEi2btr66k
	MCKOpoIBsdi2mMjNb7FA71nnFT8ppySbS1aEDKtTiT8tM9m6Fkjqub3K1fjXwbergjt1NDFUwwz
	m5E5iwSXHufPGcm3qFOXM76kFVg8Tuvf2gzXsNB5xZggfH35lSYyWXf/rDrmQGIdpKestJIm7Le
	NboyxWd3c7dFL5TfHWpPVUNtBMgrRHn4IBzy6H0=
X-Received: by 2002:a05:600c:4e45:b0:49c:f504:2af5 with SMTP id 5b1f17b1804b1-49cf81dc3ecmr123162845e9.1.1788597268348;
        Sat, 05 Sep 2026 01:34:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6023d6sm214882385e9.8.2026.09.05.01.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:27 -0700 (PDT)
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
Subject: [PATCH bpf v2 5/7] selftests/bpf: Test poisoned subprogram terminator
Date: Sat,  5 Sep 2026 10:34:13 +0200
Message-ID: <20260905083418.3723623-6-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5002; i=memxor@gmail.com; h=from:subject; bh=gLoRNwTBM64w2+2OOE6+Fgx87ufkxTeefRPsghjEqAs=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pYJve5w2PEy6zFku4BypfjKIrdaqNdQpbHH5qtwzf xrWXz7WUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgImEOjP8L+MW0Z939YAc1zur 4OywzDL1sOpN6XusZnomG+vOi/urx8gwf/ayQkW5zavNDQPFFe4JtG2xVXwasPcdq5jLvb/xLDV cAA==
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

