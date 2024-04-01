Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E9F748E
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 22:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712010667; cv=none; b=TvoFjrrSEvRRFh92bW8e4CxB2irKEn0hOsiN2bJ9hj5/TgYFTKTSUQHD8IB7lVpmHj2Ci016sR8erTdIOYBX7lRYhxfYTBv91xJrFA6s4bacwnx5ybhJ9R7NlcW8WyrvU1vhlI0HJTdHUqELqUj7E9mWl3cPD39n7Bvey6nq9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712010667; c=relaxed/simple;
	bh=aTh+v8HytePw5FDk8VEohwLw+yK1hfUfLnv6aeWErRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hzJQGmDe6wsz8RKoEbSQgr7Z3mGxpaxnDHqOXuG3zcYb24jcYk2gqp63mPrUFnVkeKFisQuSQDKnsupgZPt4KQlStxuWrZd5hY1ctnQuzklOY3WeUeDgEB7fEI3kAEh70DcTwqlvUFyed+3/22Xty8wuqfYvslj0F6q79dSbVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/JEogq1; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/JEogq1"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a480985625so3051223eaf.0
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712010665; x=1712615465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVx1cA7H/jY/lpUDOEdDbSQiZ1XlbmiZUilWHBLmejU=;
        b=R/JEogq1Sm5SFGAPyyysJoUfsTdF1/gRbt/59TqmgFBoylJ+cJ9orfwkXZK7acFd41
         C7NiAB9QQ+fEEq2gvi8iEGQWdz5eAV6NsddzDLmkWWcO03GwjWgXox1Z2SHRYBoQvFnT
         T3pWoH+X/HV7APMioDSQb1EXHKw3bApnKWpy1IqN8McBhxqrGjOdIU8UyH7RtXf4BpBr
         epUvNVa1q1Kb/VW+wqrSLbz4v2Xrpqf77ZZNi8SG9KzNt3I2pRzrVOxSGGPUbphWxQdL
         coqXoi7QCXTQqt4rP+wH3xhhTOkJ782h5oekxjjzB4Uc8Qsz1ACE4E+N307EIH8tD80N
         YN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712010665; x=1712615465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVx1cA7H/jY/lpUDOEdDbSQiZ1XlbmiZUilWHBLmejU=;
        b=OxfRcmA8TfALqIzsCUJQZQwCtmBkhLUqy/negyHbgX51nA2HjC4CttSysRMYd3uVLS
         gvmDuknFR6fhDLxs+feRFDnLF7QVcCxyIhnFIR3VlEA5VoB/LEJFZl5S0QwHHyNDNql9
         Hh18Iao9AaQ5BGeH9E1QjT1NvZBq4WaJfvyMzINk9rzZvx88rN0OyshFqKXL/lpl1k3F
         wsEfuEP/kkIX3UUeIxcJFcdXg1dx9NUalagsTJnTq4IPj+nfZLLL7y4TbDPBhe907WDk
         Epqa2cyCLnOJvELUaiO5DiQNxWra9xaHFjA3S+Y1Sy/wcZvyoI3lrfNCbc5EvPYbmhnt
         oHVA==
X-Gm-Message-State: AOJu0YxigT76a74spFcHiF0VdwVQhzIz/KjLRnx+C6l0AVO3FlhboOwC
	rjxuF9jcJEesIaWcB/HwPcZMPVoW4U4QTDYEcJYw87xipyYzDLYtXxS/GDcL
X-Google-Smtp-Source: AGHT+IFcRc20/+YVX+vhF+BxAXImtMaUxHZaacm3GYK/Hi0eNAf4o6KlgqpGkO9y+xsCMiodYCCuDg==
X-Received: by 2002:a05:6820:2715:b0:5a5:21df:7eef with SMTP id db21-20020a056820271500b005a521df7eefmr10116420oob.2.1712010664964;
        Mon, 01 Apr 2024 15:31:04 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:769d:e8e1:4c99:3e97])
        by smtp.gmail.com with ESMTPSA id ck19-20020a056820229300b005a1cfb2f4b0sm2462534oob.48.2024.04.01.15.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:31:04 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Make sure libbpf doesn't enforce the signature of a func pointer.
Date: Mon,  1 Apr 2024 15:30:58 -0700
Message-Id: <20240401223058.1503400-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier in the kernel checks the signatures of struct_ops
operators. Libbpf should not verify it in order to allow flexibility in
loading different implementations of an operator with different signatures
to try to comply with the kernel, even if the signature defined in the BPF
programs does not match with the implementations and the kernel.

This feature enables user space applications to manage the variations
between different versions of the kernel by attempting various
implementations of an operator.

This is a follow-up of the commit c911fc61a7ce ("libbpf: Skip zeroed or
null fields if not found in the kernel type.")

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 24 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   | 13 ++++++++++
 2 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 098776d00ab4..7cf2b9ddd3e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -138,11 +138,35 @@ static void test_struct_ops_not_zeroed(void)
 	struct_ops_module__destroy(skel);
 }
 
+/* The signature of an implementation might not match the signature of the
+ * function pointer prototype defined in the BPF program. This mismatch
+ * should be allowed as long as the behavior of the operator program
+ * adheres to the signature in the kernel. Libbpf should not enforce the
+ * signature; rather, let the kernel verifier handle the enforcement.
+ */
+static void test_struct_ops_incompatible(void)
+{
+	struct struct_ops_module *skel;
+	struct bpf_link *link;
+
+	skel = struct_ops_module__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_incompatible);
+	if (ASSERT_OK_PTR(link, "attach_struct_ops"))
+		bpf_link__destroy(link);
+
+	struct_ops_module__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
 		test_struct_ops_load();
 	if (test__start_subtest("test_struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
+	if (test__start_subtest("test_struct_ops_incompatible"))
+		test_struct_ops_incompatible();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 86e1e50c5531..63b065dae002 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -68,3 +68,16 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
 	.test_1 = (void *)test_1,
 	.test_2 = (void *)test_2_v2,
 };
+
+struct bpf_testmod_ops___incompatible {
+	int (*test_1)(void);
+	void (*test_2)(int *a);
+	int data;
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___incompatible testmod_incompatible = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2,
+	.data = 3,
+};
-- 
2.34.1

