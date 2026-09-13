Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A02E738F
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311171; cv=none; b=jjAY0h8xbmNkPqjunrvDks1gRpW6G5KWJw0mrf+M0ksp0JtNcycmD5DeymnOJ0KqJw9udQ3aDqHrpQjV6JJ6uhIvOFAscKPGixoiHGQGjifKaW7JazpTg90L78CWA9P41JZOY1fYFzZz4BgCnBlbsQJUgqCdqEyfyRsgKfs1xzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311171; c=relaxed/simple;
	bh=ulE/mLCfcb4DRSXcN8WBGv5f3Ewt0agy7Tf0Fg8CSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1OHiSdNgEVG4JbCdt6ivO4WXGQ1v9g1Yrxdv/tAmcsqT/hYexoXnGvfYHrc5IYeXqMb4TPFPF+/JS3UlDfrO7uHg+NZv7rU4UlhaFby+0ejhGN0nYnbR2JcVtJSWUylFpWGs8bhr3C8emoJFAJ3crmLj1SKZBTruM9+bpVpHNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeI/Q14h; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeI/Q14h"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2dd6665a10fso470495ad.1
        for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 07:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311169; x=1789915969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsKpv3+BaMcACX8hkcqYc0OW8TZHEabpJamqq/toxj0=;
        b=ZeI/Q14hUUElXvnuDVYeQc779kuuX/0fa4bxoDGbEvXEthk1GW/nr20ykcCx+v6xfW
         naE6QiOezvrtL/1C1jP8fJA3bhr23UOys9q4MPUGCVVgx196CynMi59sQb9WyfeBXt6a
         lkJv20cMropETdXmci8akrDlGBTfnqOQzZouWaYOtsRsC6ZoJAzsA34iefsCBWcftH5f
         RXTQgCBmU3LR54g18ZNlrWOskTxqyM5YF+YQDdap8o5yDMBaEi9ijSbzrPKPyYh1RV1G
         N2CUGlfXZAcToX34DBB81lTJBvW4B9Lq0Zqn0mdNLNwUBj2fB66KyGg9S6/x2FeASgXv
         OKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311169; x=1789915969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LsKpv3+BaMcACX8hkcqYc0OW8TZHEabpJamqq/toxj0=;
        b=pmzgxbSDYgN/JEw2SrEmxPQO87tV7HWSluDwaqbbo1ffkWX9+z4n8wFMFjDWVKXpds
         VsNVMd/koCWFnkCwLxjkqT35zUq4zoh6hqR5e6fAZEWuRdLJQs++bK8DHZ1PHyWLa83e
         PqA65ClaXyMSs5u3deGZ5qqAVZsEw3OT/Oi8VoSz+uSrJZw9Mhzbh7DjI9sEkw7Fwz2M
         R4OtbL9adHPo0DVYEwMFsMAbqt/GF2dhSR7m3lvi81i+BNzjq2TOC3qvlxKtX7Cc/fMO
         2LyS/QYS75vI0eyhnNIdJXgpnMRnTuoPXwlW4Lbcg894Q7EXm3sC5Drm4YUb8iEZp8hv
         P03w==
X-Gm-Message-State: AFuF++lMUzv1b5DaiAVYgipenVx9ynBUY+nmy4QKIuPlGRjEdsnK0be3
	mYF4cDG7iY8P/486Jcs0c3026//0HQn9Myyj6Cn6pYgGnxEhUq/af60F7f9eGpYw
X-Gm-Gg: AYBFou2vkSp/wcHGTBXlqCvRs8Jcef1XW0kfWh8j7mMTfwAoxak4ALYUvRzJ+l2kdbC
	IZw1faMOV4zChsxdVGm67JN+NYsjv7c4wE5GxH7VgIEYYNVBJNGTMQlr5HuznYsi96SGCjmrISv
	cBxBE26hbuXuE6LwyGzh+b19EhuEVYDUTEl6uVQ3DuDuPrMT9o+G4pFSXRsDrMpC43QvTllDV8K
	85OlXzddQK9TablQfHBF4N3ZNDpC9teJU757SoBC3gEdjdPMYx7ks6HaeTznWND4vaHUfUdEjWT
	pst/GtzmjLHZctB38+n3BAeklqch5sI6G9BGp7aRRw23zbvPJ7aXsuSLIXBkopIP2vukGUbcfyp
	VfHNyB6MIFtXV01OtiAK9JG7f1SiAL/sjrLwNoisRixwlH5nvNsul5g2VEbLxR1l88Tl90uYb+a
	Dppn5S9+ziXbaaaOYFJJ1keG6ec5Yb+FOhW/FFI8GY6EW3wV+7BeOqKVBrSvQP1PLdTITUQWV/h
	u8xlEmCaRzDGR2BaFUfWQ7iCr0IFpHHpZ+3TFHZCpe6H9gqqGb5FVlTknp1i/5vRaM=
X-Received: by 2002:a17:90b:4cce:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39d9bec4d91mr24178737a91.10.1789311168629;
        Sun, 13 Sep 2026 07:52:48 -0700 (PDT)
Received: from ubuntu2204.comp.polyu.edu.hk ([158.132.255.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm15543544a91.9.2026.09.13.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:52:48 -0700 (PDT)
From: Mingpei CAO <caomingpei@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	qmo@kernel.org,
	Mingpei CAO <caomingpei@gmail.com>
Subject: [PATCH bpf v2 3/3] selftests/bpf: Cover struct_ops bitfield and offset validation
Date: Sun, 13 Sep 2026 14:52:33 +0000
Message-ID: <20260913145233.1446643-4-caomingpei@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913145233.1446643-1-caomingpei@gmail.com>
References: <20260913145233.1446643-1-caomingpei@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two adjacent bitfield members between two non-bitfield members. Check
the size of the generated C structure and the offsets of both non-bitfield
members. Require libbpf to reject the first bitfield member and print the
expected message.

Move a non-bitfield member to the first byte after a four-byte local
struct_ops type. Require an -EINVAL result without a memory error.

Assisted-by: LLM
Signed-off-by: Mingpei CAO <caomingpei@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 91 ++++++++++++++++++-
 .../selftests/bpf/progs/struct_ops_module.c   | 17 ++++
 2 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 75a0dea511b3f..41029ebb22f01 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
 #include <test_progs.h>
+#include <bpf/btf.h>
 #include <time.h>
 
 #include <sys/epoll.h>
@@ -150,6 +151,91 @@ static void test_struct_ops_not_zeroed(void)
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
+	if (!ASSERT_EQ(offsetof(typeof(*skel->struct_ops.testmod_local_bitfield), data),
+		       0, "local_bitfield_data_offset") ||
+	    !ASSERT_EQ(offsetof(typeof(*skel->struct_ops.testmod_local_bitfield), onebyte),
+		       8, "local_bitfield_onebyte_offset"))
+		goto cleanup;
+	if (!ASSERT_EQ(sizeof(*skel->struct_ops.testmod_local_bitfield),
+		       bpf_map__value_size(skel->maps.testmod_local_bitfield),
+		       "local_bitfield_shadow_size"))
+		goto cleanup;
+
+	/* Normal fields around the unsupported bitfield remain accessible. */
+	skel->struct_ops.testmod_local_bitfield->data = 1;
+	skel->struct_ops.testmod_local_bitfield->onebyte = 1;
+
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
+	ASSERT_HAS_SUBSTR(log, "local bitfield extra_bitfield is not supported",
+			  "local_bitfield_rejection_log");
+
+cleanup:
+	free(log);
+	struct_ops_module__destroy(skel);
+}
+
+static void test_struct_ops_bad_member_offset(void)
+{
+	struct struct_ops_module *skel;
+	struct btf_member *member;
+	struct btf_type *type;
+	struct btf *btf;
+	char *log = NULL;
+	int err, type_id;
+
+	skel = struct_ops_module__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open_bad_offset"))
+		return;
+
+	btf = bpf_object__btf(skel->obj);
+	type_id = btf__find_by_name_kind(btf, "bpf_testmod_ops___bad_offset",
+					 BTF_KIND_STRUCT);
+	if (!ASSERT_GT(type_id, 0, "find_bad_offset_type"))
+		goto cleanup;
+	type = (struct btf_type *)btf__type_by_id(btf, type_id);
+	if (!ASSERT_OK_PTR(type, "get_bad_offset_type"))
+		goto cleanup;
+
+	member = btf_members(type);
+	member->offset = type->size * 8;
+
+	err = bpf_map__set_autocreate(skel->maps.testmod_bad_offset, true);
+	if (!ASSERT_OK(err, "enable_bad_offset_map"))
+		goto cleanup;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+	err = struct_ops_module__load(skel);
+	log = stop_libbpf_log_capture();
+	if (!ASSERT_EQ(err, -EINVAL, "struct_ops_module_load_bad_offset"))
+		goto cleanup;
+	ASSERT_HAS_SUBSTR(log, "member extra is outside the 4-byte local struct_ops type",
+			  "bad_offset_rejection_log");
+
+cleanup:
+	free(log);
+	struct_ops_module__destroy(skel);
+}
+
 /* The signature of an implementation might not match the signature of the
  * function pointer prototype defined in the BPF program. This mismatch
  * should be allowed as long as the behavior of the operator program
@@ -304,6 +390,10 @@ void serial_test_struct_ops_module(void)
 		test_struct_ops_load();
 	if (test__start_subtest("struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
+	if (test__start_subtest("struct_ops_local_bitfield"))
+		test_struct_ops_local_bitfield();
+	if (test__start_subtest("struct_ops_bad_member_offset"))
+		test_struct_ops_bad_member_offset();
 	if (test__start_subtest("struct_ops_incompatible"))
 		test_struct_ops_incompatible();
 	if (test__start_subtest("struct_ops_null_out_cb"))
@@ -314,4 +404,3 @@ void serial_test_struct_ops_module(void)
 		test_detach_link();
 	RUN_TESTS(unsupported_ops);
 }
-
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
index 71c420c3a5a6c..846b5a934dc83 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
@@ -76,6 +76,23 @@ struct bpf_testmod_ops___zeroed testmod_zeroed = {
 	.zeroed_op = (void *)zeroed_op,
 };
 
+struct bpf_testmod_ops___local_bitfield {
+	int data;
+	unsigned int extra_bitfield:31;
+	unsigned int extra_bitfield2:1;
+	char onebyte;
+};
+
+SEC("?.struct_ops.link")
+struct bpf_testmod_ops___local_bitfield testmod_local_bitfield;
+
+struct bpf_testmod_ops___bad_offset {
+	unsigned int extra;
+};
+
+SEC("?.struct_ops.link")
+struct bpf_testmod_ops___bad_offset testmod_bad_offset;
+
 struct bpf_testmod_ops___incompatible {
 	int (*test_1)(void);
 	void (*test_2)(int *a);
-- 
2.43.0
