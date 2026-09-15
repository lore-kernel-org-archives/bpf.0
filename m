Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F77429CDA
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789489384; cv=none; b=k8NLB8Lan3WZ10iEWb1rmZB6qnDUDUBIbHJ0I55davHHxhrORpFDpe3MPXIBmSf+b8/Rfc6EbyJkwdq/dDhwiQXEqJL5ZTtE8FmISvMpnyA9AZvNKJHX+Whf6i4RV0fqjfDQzYkZmhUqx0iIpqR7gg28/6PmUYfmlW92wLstPAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789489384; c=relaxed/simple;
	bh=IJsJLlSktuaF0tBV2ZsqKpolNF3LGD5NxjJWzxSgTic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j58flGotlrjhXezsm1cUpRog1Mr4VMRshPJvkLisW6up05ZlB0svgeQd2kmoBn1faadivFAD7xHLl3LNn53AS4sm99FaAa7KxWgPU/VcojFBcxsoyE0+wWIQZHPVGKBr2AmovBnybhUfpyywqg2mpyuq7eYZflkRVo1hnhI2/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEJUTXfI; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEJUTXfI"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304784so3031104a12.3
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789489382; x=1790094182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPOKLwiFQ/gkntUWwPDLYOhFtvJ7wY7zwKphKiPPRVo=;
        b=gEJUTXfIwaH7QKDnXwzQFmZUSgfZKvDVVXqJr3eqeiJ+NdAhFkytO/DRY7GdqOFiuV
         BATsa3DnWUnBOdyb5CNm1djvJ4KXWlWHtBVMBSaDFUSsCU8iGtpw3oUPVilBRKnj54N1
         3skBizXHiPnLMOSvVswAYH1tUiPlsugISLi7Y/74ea/q7QS4Ymt0VZzhNYlKISU0qKK+
         RyM70YYalNfIoWf3WVQXo7iUFH2Kg2p4QiOuLqcLlJN5edQ4wDGAjBDH+q8RI7+RvbXV
         s3EVONicsxMU3PCLTLNv73J70W/85S7oQAC7BpYrbyVr+qbTo552sZYRu+KJVAkriVEo
         j/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789489382; x=1790094182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPOKLwiFQ/gkntUWwPDLYOhFtvJ7wY7zwKphKiPPRVo=;
        b=fEnyHnA3vjKMFJZtQ6EN6lxUsloVYfFV/AX1/qQ7GF+D6hWR2j6kmQH8s9ofwei5uk
         IV+1QZS9wHnX1omumwsFg4xSP85WQ0z22ot7wmIpOUKLgSIIqsP+RaRFspkeP9UX35v3
         XDKh6ET+RWsXEWfHIdAghytij8uwJ2l91hjie9NAQUochVwIQMLOiQ0hIzKFrCKAjH9S
         rUeWoaDuxIiQ+iM3cH1Qf66dQ6c9DMh4oUxsImD0W8QbS5mCTT2uXsPfxF5YpBhpnvuv
         1uPY8Mgq27EkMJjnp/TC6gRSRExEQlrfnbvbmZ30Fu/sQ7Z6CkTTJwSTx85vyVfeekLd
         0dwQ==
X-Gm-Message-State: AFuF++mUXCPswKt12lgkkG50VZnpxfqbo8d0MiRpuWgPk0IN+YWJg61R
	/2eeA4/Ohw7xFQM7CFgkOF5tgq4byMGmlacGHHsjisYFSr96/UixSuwtlYPk3q4/
X-Gm-Gg: AYBFou3JQXmevfRcTsYsFnLEndw6VBozuzdAyk5XpWeFi1Rh9JFwK8L6Y9LtSZoMY95
	KuHs+seQvu6g/c4jawvAHX7B+L++KzWzEwZvGxIj0TB95XawS1wXpCL41XnT7JyVny/3cFkpNma
	zgQygeBezQgE5wWR/Kob0mlCvi9sxsIDtaLXWElkVMj8W2kBI5d4ne0wM9/JFvKFRssDNG0q+/p
	D/X8YQ+7CK4C7XhLGKXz2Lzxd2jbYlYK6sMXMCiEyqpTz7fRR7nzrGtdMRjRPNRwnV1zCRIPkEl
	VZ5op2C3nYJDuQPMToCJBfAYH7+0M8E8OGB4w7BMqVGGeBOspsPQ4ceGhRuotauNCFlRyvt2K/X
	ZFvXyZTpvDoreHqISC1fFLp/Y06ac6AuTN3XGdk2caOSYQCeDeEtle+8E+RaT/70MWmz40p3g7H
	hwsCixtytE4AcNLiUKaDq34HAKM+2/pd9oqUrSr2xaMOXzAu8h6gOAmyHBmS0k6Q0ahoq+XvcHz
	huk3rHAFn84nkRutvUtmmsh8VQU4d8/g8KB3PLnN59+0eMRC2yUbPg=
X-Received: by 2002:a05:6a20:3952:b0:3d8:f78a:9349 with SMTP id adf61e73a8af0-3db4064eb17mr16688134637.13.1789489381937;
        Tue, 15 Sep 2026 09:23:01 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50aa988e2sm208232a12.1.2026.09.15.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:23:01 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: Mingpei CAO <caomingpei@gmail.com>,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test local struct_ops bitfield rejection
Date: Tue, 15 Sep 2026 16:22:37 +0000
Message-ID: <20260915162252.473044-3-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915162252.473044-1-caomingpei@gmail.com>
References: <20260915162252.473044-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a local struct_ops type with a bitfield absent from the corresponding
kernel BTF type. Verify that libbpf returns -ENOTSUP and emits the local
bitfield diagnostic.

Keep the existing all-zero scalar test as the compatibility control.

Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 32 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |  7 ++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 75a0dea511b3f..03f86abafeb7c 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -150,6 +150,36 @@ static void test_struct_ops_not_zeroed(void)
 	struct_ops_module__destroy(skel);
 }
 
+static void test_struct_ops_local_bitfield(void)
+{
+	struct struct_ops_module *skel;
+	char *log = NULL;
+	int err;
+
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_local_bitfield"))
+		return;
+
+	bpf_map__set_autocreate(skel->maps.testmod_zeroed, false);
+	err = bpf_map__set_autocreate(skel->maps.testmod_local_bitfield, true);
+	if (!ASSERT_OK(err, "enable_local_bitfield_map"))
+		goto cleanup;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+	err = struct_ops_module__load(skel);
+	log = stop_libbpf_log_capture();
+	if (!ASSERT_EQ(err, -ENOTSUP, "struct_ops_module_load_local_bitfield"))
+		goto cleanup;
+	ASSERT_HAS_SUBSTR(log,
+			  "local bitfield extra_bitfield is not supported",
+			  "local_bitfield_rejection_log");
+
+cleanup:
+	free(log);
+	struct_ops_module__destroy(skel);
+}
+
 /* The signature of an implementation might not match the signature of the
  * function pointer prototype defined in the BPF program. This mismatch
  * should be allowed as long as the behavior of the operator program
@@ -304,6 +334,8 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_load();
 	if (test__start_subtest("struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
+	if (test__start_subtest("struct_ops_local_bitfield"))
+		test_struct_ops_local_bitfield();
 	if (test__start_subtest("struct_ops_incompatible"))
 		test_struct_ops_incompatible();
 	if (test__start_subtest("struct_ops_null_out_cb"))
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 71c420c3a5a6c..f221bfdbddabf 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -76,6 +76,13 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
 	.zeroed_op = (void *)zeroed_op,
 };
 
+struct bpf_testmod_ops___local_bitfield {
+	unsigned int extra_bitfield:31;
+};
+
+SEC("?.struct_ops.link")
+struct bpf_testmod_ops___local_bitfield testmod_local_bitfield;
+
 struct bpf_testmod_ops___incompatible {
 	int (*test_1)(void);
 	void (*test_2)(int *a);
-- 
2.43.0

