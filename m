Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D7D7C085
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592742; cv=none; b=BEo8KID8jS5jq8Vvrs2OEZlDOC8HgVWsSg6RhWICV7i8bcx0Q/kIeN1qVge74AC4KX5mOrtNIDiVlzBvlhjWeP8RAwQAOvel1r2MLF8MM68IC6sO4MU7/QtvUIqMEEB9wIIS9mxYhbW5Cj98KSUDRlNCYlj2NxtQSpuebEeI5Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592742; c=relaxed/simple;
	bh=rCBAnMa2X7fiuBRmf946N8+2iHXidemXOv7C6Bc3PyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvkZ6O6q1Pxk+7tbUIeA3YDvCfzm9YV1Ygx4ouxJeBhgOt8vq/fY8SRXrzRnPYUUBB0hXu0yYWDq/m7excpjwwpM3XaT4wLpwgj2t4RVXEzr4wZ9Jx34VcRv1p65m5o2HwaDRbPkEBNIQYhpMNE0OoOsqPXNfp/s22JxAsuub+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CITUmOZU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CITUmOZU"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a458b6d9cfeso93144166b.2
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592739; x=1710197539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hfl/Y1CGjeULVzqRfxvVSVqXbrUox/b7pBNOx/gqXPU=;
        b=CITUmOZUmJ3YdXPxt4CcTuNn6JWiY7ktF8ZseOrbJ/lFcCB5VVi1/XHMVfC3tkFp4A
         3GxHDIXv76IG6scrqvFuYOEu4/d3O/RwlmaGHl/+LioD5y7z/Cvl3fQSZaY0DPo7YTqc
         g/U5L/m3uk2XEcq8fLSV+VZ1j7aWw9MzzXzJK21Zx3lpzOKBLulFqXkD31DEY+ZGZ4iI
         OsSfb8xbnGnFaXy3cPUF0nUTF1gPh2/+U9FJTGA69WLX4xnTSyd/TtLVNzQ7MdJnzMSg
         9kKXFybGzh/HHhYpRsNMT2WEY5j2sGs3qF4CMd/cKnyT/RCS7zaD0dIgty5vT5n07Vmv
         0x6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592739; x=1710197539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hfl/Y1CGjeULVzqRfxvVSVqXbrUox/b7pBNOx/gqXPU=;
        b=VPJnw4SN4xKUscg9C6op2479OqGlclx6/dJXIQroz8UCRU3S/8TcWvMAVh0zPsovfW
         9MkQa96f/oWhKZR0h7FJ12nZndmnVEFcUgqLcSkm82TTvJMkpH8RBOSv1kdYYqBGiNxV
         ngnZuczW+81mn8p83ULGVjYFs/kbtkWksvp1BXHoGNxFrB2hwVp5BNsTmf2Vp13fFOoE
         PdjShraVTnXOFO00HHXJrpUBN80ayrt+N6diLV18M+Sg7F99TwnbMhJEf+IMCrFYJIRN
         uVRzqzV74LXeSXylBktWVr9hLvtq19US1fvQ9xQZdbQz1KGp1oZgPkf/orFUWydm4KtC
         AJbQ==
X-Gm-Message-State: AOJu0YxR87iBs/YLhR1gw6sdNPk2s305TnU05HW9lvS3jK5ruBQW7k2M
	JIU9wUYFzzarngiOktBvvHqmOCubl5Jojauugoo0Gjy1L2gQ0UuG/5DTtF3C
X-Google-Smtp-Source: AGHT+IE6d01Sjb8vEFyWlJzGgOQwvh6px7e+us0tS7nq5V/CJkWNxiUzBeDl75DdbC1PRPBAFKKjIQ==
X-Received: by 2002:a17:906:3941:b0:a3f:ce8:1234 with SMTP id g1-20020a170906394100b00a3f0ce81234mr7166574eje.68.1709592738875;
        Mon, 04 Mar 2024 14:52:18 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:18 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 09/15] selftests/bpf: verify struct_ops autoload/autocreate sync
Date: Tue,  5 Mar 2024 00:51:50 +0200
Message-ID: <20240304225156.24765-10-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that autocreate flags of struct_ops map cause autoload of
struct_ops corresponding programs:
- when struct_ops program is referenced only from a map for which
  autocreate is set to false, that program should not be loaded;
- when struct_ops program with autoload == false is set to be used
  from a map with autocreate == true using shadow var,
  that program should be loaded;
- when struct_ops program is not referenced from any map object load
  should fail.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 32 ++++++++++++++
 .../bpf/prog_tests/struct_ops_autocreate.c    | 43 +++++++++++++++++--
 .../selftests/bpf/progs/bad_struct_ops2.c     | 14 ++++++
 .../bpf/progs/struct_ops_autocreate2.c        | 32 ++++++++++++++
 4 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops2.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
index 9f5dbefa0dd9..6a707213e46b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "bad_struct_ops.skel.h"
+#include "bad_struct_ops2.skel.h"
 
 static void invalid_prog_reuse(void)
 {
@@ -28,8 +29,39 @@ static void invalid_prog_reuse(void)
 	bad_struct_ops__destroy(skel);
 }
 
+static void unused_program(void)
+{
+	struct bad_struct_ops2 *skel;
+	char *log = NULL;
+	int err;
+
+	skel = bad_struct_ops2__open();
+	if (!ASSERT_OK_PTR(skel, "bad_struct_ops2__open"))
+		return;
+
+	/* struct_ops programs not referenced from any maps are open
+	 * with autoload set to true.
+	 */
+	ASSERT_TRUE(bpf_program__autoload(skel->progs.foo), "foo autoload == true");
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+
+	err = bad_struct_ops2__load(skel);
+	ASSERT_ERR(err, "bad_struct_ops2__load should fail");
+	log = stop_libbpf_log_capture();
+	ASSERT_HAS_SUBSTR(log, "prog 'foo': failed to load",
+			  "message about 'foo' failing to load");
+
+cleanup:
+	free(log);
+	bad_struct_ops2__destroy(skel);
+}
+
 void test_bad_struct_ops(void)
 {
 	if (test__start_subtest("invalid_prog_reuse"))
 		invalid_prog_reuse();
+	if (test__start_subtest("unused_program"))
+		unused_program();
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
index 883f938d518c..35910cbb9ca4 100644
--- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -2,6 +2,7 @@
 
 #include <test_progs.h>
 #include "struct_ops_autocreate.skel.h"
+#include "struct_ops_autocreate2.skel.h"
 
 static void cant_load_full_object(void)
 {
@@ -43,10 +44,6 @@ static void can_load_partial_object(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
 		return;
 
-	err = bpf_program__set_autoload(skel->progs.test_2, false);
-	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
-		goto cleanup;
-
 	err = bpf_map__set_autocreate(skel->maps.testmod_2, false);
 	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
 		goto cleanup;
@@ -67,10 +64,48 @@ static void can_load_partial_object(void)
 	struct_ops_autocreate__destroy(skel);
 }
 
+/* Swap test_mod1->test_1 program from 'bar' to 'foo' using shadow vars.
+ * test_mod1 load should enable autoload for 'foo'.
+ */
+static void autoload_and_shadow_vars(void)
+{
+	struct struct_ops_autocreate2 *skel = NULL;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_autocreate2__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
+		return;
+
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.foo), "foo default autoload");
+	ASSERT_FALSE(bpf_program__autoload(skel->progs.bar), "bar default autoload");
+
+	/* loading map testmod_1 would switch foo's autoload to true */
+	skel->struct_ops.testmod_1->test_1 = skel->progs.foo;
+
+	err = struct_ops_autocreate2__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto cleanup;
+
+	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
+	err = ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	struct_ops_autocreate2__destroy(skel);
+}
+
 void test_struct_ops_autocreate(void)
 {
 	if (test__start_subtest("cant_load_full_object"))
 		cant_load_full_object();
 	if (test__start_subtest("can_load_partial_object"))
 		can_load_partial_object();
+	if (test__start_subtest("autoload_and_shadow_vars"))
+		autoload_and_shadow_vars();
 }
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops2.c b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
new file mode 100644
index 000000000000..64a95f6be86d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops2.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+/* This is an unused struct_ops program, it lacks corresponding
+ * struct_ops map, which provides attachment information.
+ * W/o additional configuration attempt to load such
+ * BPF object file would fail.
+ */
+SEC("struct_ops/foo")
+void foo(void) {}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c b/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
new file mode 100644
index 000000000000..6049d9c902d3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate2.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_result = 0;
+
+SEC("?struct_ops/test_1")
+int BPF_PROG(foo)
+{
+	test_1_result = 42;
+	return 0;
+}
+
+SEC("?struct_ops/test_1")
+int BPF_PROG(bar)
+{
+	test_1_result = 24;
+	return 0;
+}
+
+struct bpf_testmod_ops {
+	int (*test_1)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)bar
+};
-- 
2.43.0

