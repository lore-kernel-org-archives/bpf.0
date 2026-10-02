Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D473FE652
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945270; cv=none; b=JBTF1wC/tg23OQWAD6Tlm1303GQW3NT70nFt9wCEUTxCseBGVx0In1cx8WbWBwiCU0xOlE6RoQ202oyHroZUjRqV5AG3ZkhdId//mIQxBj8vFqo+/UxcNZLc0cxxn12ViL7xZA7Fe3dL+gC0r4HREGm6LsDD6dOy7b2w02XnSvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945270; c=relaxed/simple;
	bh=aNsMuW9LWAtwi5Majz9HVye9zzaDSNXwhBUiGzj9a3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRLtBWjRfHPruskD6FR9CAlMYFllQEboiD5O4pEaKiop3ile2b4x8SFOeg3jI6oFDhS7amJYJwIz2o+fbY7F4t1Vwl4pu0sHiAO9MaTDLMQ85mbXZoIphiyJJa6Pu4PVLqMgjsXDsf5LPcLBzCYKeQRFsxvjiR5Z1sSSNst89/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWJmq+sB; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWJmq+sB"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86212a185dcso5146873b3a.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945269; x=1791550069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mJmzYd7EZrRhhX/EIRvB1q9kkmEogRgfA3+31RM0mkg=;
        b=hWJmq+sBKocmCCJQsNa8gFkWxNxzKtebFI0F030NAJ7RoY66sbdoz6VpJLsv1S9NX7
         DljYQVBS+lApKU/2EuimvntjA99G4hSo2Kzky4s0eXIvfW00uJ1STcEArrEx4/WkwDOo
         05I+glminRRwiYVRODFxeXwnGuYgQaJ4tvU9eJXYjq+JRr2MilsOa1gC4Yj+32YllsEB
         9/6eUUxsQjweh+3Ck/QGg5Cj6Unveo9bd3BY4pn4Zbr93YxXwkPiFpxxwhJ6C2hJRNlx
         5F7L3diqx0KFbEpJUScVFd3mgiP5SsTyipTBIrceyO6eja9vMigOFkCuqS9soTXgvgm8
         e7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945269; x=1791550069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mJmzYd7EZrRhhX/EIRvB1q9kkmEogRgfA3+31RM0mkg=;
        b=VfGDZ0OzEKCZ6omyn5Qe44izhFupYmyjlBOgv0GvKk5n0+7tm827GmRLYbiPX2nyUc
         43kWIbemNLsS4EOQa2S6EwdHl/kcGxAbiyXFEBT+yJtAiP1rjHs+TTUSCBNV6eBPEkf0
         QWQo0gUiiE24gpZZuzG46MOha6RihP454l/aJnW4/Aywz5P6fLSIr86b04C9yadEfcTO
         egteAYHDZ/atPl4TEgA3yT5B6ge9yqWYb7mvZgO9lj7JJsmqtQcaqX6hNOpmgFGLO8Up
         lCiIAgPlZo75tz960oF0W9HDBx8t6VWE9K7IaHbfG7ywb9k+zXdFBgtiv4zO44NL7mAt
         Nt9Q==
X-Gm-Message-State: AFuF++kbZLqcechLBcWkYG9kk6iJNeV+qUEfdr+O6z8UzdYS3UM7TOSw
	ZCdKq/NEurPtWvSPI+ypE+HbPwCoAS0VD415+3vTy33Mokzo/vlYY70npJXK3WQX0yU=
X-Gm-Gg: AYBFou0k7f2Kj5yGwsovSnlLgdNR4Z1mQbNYX9RhlQtAtOxkdVHO8osm2vSSte7Pj4f
	HSQHRYpb0JMv1mDb7tATLPtULSlWIkOYZDuJyA3u5nFnHEFEPoLoV+D8C3EhOru19iNvDSsWvoY
	EyBjtHICYrNP8RS/4d6FRRBD0sOezcxPKU0RN2lQzEsFVJqaehysiRuMBfS8wyfLGTzaROhLWyS
	szhVg4P6JQTHTmNXM5BamNQEb3bAsYPxlKiksPt46ytebbfcEK8bDkXRbZUWt9Y34ARcMQ9W5xL
	f2C1152ybUXwKTSsbL9RN5eDwIs4q5O8c5hIi5bS1N7OFf0yWs8AZYpOr7VULAdFceM1rAdZ0rt
	nKnq+lcUDeFs9FDYgeRM8I0LMZLWlWIXbuU1blihD2ksM3ObdEzcuzX34A8tgAPCArRWOVh2/yH
	rJYhIykoZrSUtnDbcG/oBEP631kDwIEQJLQF5/OW2jBhXM0kPU5/ZssURxMhQFqoXRw7K1k5s7j
	MsmXT9NOjcDA+KU9cREsFN/GYh9rLmIczlG6jn9d2qbKmZeb4ROdkNfxMOu6VUvJ/jSSCjZ2pYN
	lXFbb3qlvTdxbD+MFk+WRa9LKu9OUG+mqWvqnDfuEOsKcTikRSF9IQ==
X-Received: by 2002:a05:6a21:b98:b0:3d3:ae50:97ce with SMTP id adf61e73a8af0-3e0bd01fbebmr2480782637.27.1790945268663;
        Fri, 02 Oct 2026 05:47:48 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c3a3003sm846132b3a.29.2026.10.02.05.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 11/15] selftests/bpf: Add tests for a variable that is smaller than its type
Date: Fri,  2 Oct 2026 12:47:10 +0000
Message-ID: <20261002124714.180012-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that a variable in DATASEC that is smaller than its type is not
printed when the map is read from bpffs and when bpftool dumps it.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/btf_rust.c       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_rust.c b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
index ce2b31087b59..daf777cadfda 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_rust.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_rust.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include <bpf/btf.h>
+#include "bpftool_helpers.h"
 
 #define FUNC_NAME "write_fmt<scx_simple::BpfStream>"
 #define KSYM_NAME "write_fmt_scx_simple__BpfStream_"
@@ -61,9 +62,81 @@ static void test_func_name(void)
 	btf__free(btf);
 }
 
+#define PIN_PATH "/sys/fs/bpf/btf_rust_piece"
+
+/*
+ * A piece of a static that LLVM split has the type of the whole static.
+ * It's the last variable in the section, so its type ends past the map value.
+ */
+static void test_piece(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int int_id, struct_id, var_id, piece_id, sec_id, map_fd = -1, key = 0;
+	__u32 value[2] = { 0x11111111, 0x22222222 };
+	char line[256] = {}, out[1024] = {};
+	struct btf *btf;
+	FILE *f = NULL;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf"))
+		return;
+	int_id = btf__add_int(btf, "u32", 4, 0);
+	ASSERT_GT(int_id, 0, "int");
+	struct_id = btf__add_struct(btf, "Whole", 8);
+	ASSERT_GT(struct_id, 0, "struct");
+	ASSERT_OK(btf__add_field(btf, "a", int_id, 0, 0), "field");
+	ASSERT_OK(btf__add_field(btf, "b", int_id, 32, 0), "field");
+	var_id = btf__add_var(btf, "CNT", BTF_VAR_STATIC, int_id);
+	ASSERT_GT(var_id, 0, "var");
+	piece_id = btf__add_var(btf, "WHOLE.1", BTF_VAR_STATIC, struct_id);
+	ASSERT_GT(piece_id, 0, "piece");
+	sec_id = btf__add_datasec(btf, ".bss", sizeof(value));
+	ASSERT_GT(sec_id, 0, "datasec");
+	ASSERT_OK(btf__add_datasec_var_info(btf, var_id, 0, 4), "var info");
+	ASSERT_OK(btf__add_datasec_var_info(btf, piece_id, 4, 4), "piece info");
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf load"))
+		goto out;
+
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_value_type_id = sec_id;
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, ".bss", sizeof(key), sizeof(value), 1, &opts);
+	if (!ASSERT_GE(map_fd, 0, "map create"))
+		goto out;
+	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, value, 0), "map update"))
+		goto out;
+
+	/* the variable is printed, the piece is not */
+	unlink(PIN_PATH);
+	if (!ASSERT_OK(bpf_obj_pin(map_fd, PIN_PATH), "pin"))
+		goto out;
+	f = fopen(PIN_PATH, "r");
+	if (!ASSERT_OK_PTR(f, "open"))
+		goto out;
+	while (fgets(line, sizeof(line), f) && line[0] == '#')
+		;
+	ASSERT_HAS_SUBSTR(line, "286331153", "var");
+	ASSERT_NULL(strstr(line, "572662306"), "piece");
+
+	/* the same for bpftool */
+	if (!ASSERT_OK(get_bpftool_command_output("map dump pinned " PIN_PATH, out, sizeof(out)),
+		       "bpftool"))
+		goto out;
+	ASSERT_HAS_SUBSTR(out, "CNT", "var");
+	ASSERT_NULL(strstr(out, "WHOLE.1"), "piece");
+out:
+	if (f)
+		fclose(f);
+	unlink(PIN_PATH);
+	if (map_fd >= 0)
+		close(map_fd);
+	btf__free(btf);
+}
+
 /* Serial: programs are not in kallsyms while another test sets bpf_jit_harden */
 void serial_test_btf_rust(void)
 {
 	if (test__start_subtest("func_name"))
 		test_func_name();
+	if (test__start_subtest("piece"))
+		test_piece();
 }
-- 
2.55.0

