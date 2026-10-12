Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01234341660
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791812254; cv=none; b=cYfQ5dbD5brlurPqsaxxxBqiBf3f5P8wnnvv/WGYLYOvQixv5WPcHmCVsxpyek4BSnN9BIM/7hpATQxAlLfhplnl8vZ3ucQEf0uNo2cyt/pfRTPcPj9TPtsxvNCzsvkguuxeF0qsMuFEg+Tc7OiL/EU1t9qgBDKnpRfpsbv5p2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791812254; c=relaxed/simple;
	bh=NA0vvm1I0UBnht6GYHZO7WvbhLE4uQLKWCXCLGY72Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUFu2mh/VFNypS79967pP6iH7VmAesJWRnE1+UaMbFLTlxeng+Lx0J/Evng8AxPJp17KBlx53D/iArRhZKxoMlNYGpXtDUgWys88m6Ggg1WA80PbCsbNsWJIbhVT7aLtlDC9hDY8G89F0TcARfT/4/mnxScH3c9mDUEMxCTOWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIHr7XTC; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIHr7XTC"
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-8210db80578so761287a34.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791812251; x=1792417051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BD6Lx/GJm8UCws1aN7MZnuHlJQr+7evP6sC4Kx9yk/I=;
        b=jIHr7XTC88Uuuls2G6QggTnLmTD3lOP9+sB74g5AMmYE4Fh1Q/ZYkMlSdir+Gs08In
         UkHZEAPWAaEspypLGYEG6i1LYoavcz/UXW9pXjeAkGo2l/bw81iY6HUPyIVIdoFJuUqB
         /vIoym0vHmD1oe6sTcQls5ehaK6v6C1Gl50Kx1/6LtzKwLX+7JYhTSH1y+H3LkOyQ8pD
         AkyrCeFdEL16ZMPuPqoGf9aZyxOemC/uSxOHYCeZZZgQR+T6DiJ2qCklvM9QDzR+SHrk
         q+f4EiHbnv2L20ub8Ovkc+DcFIbmQXgSF2UercaEs6aFql/kpjW+5az27GT1QkSS7QzB
         1yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791812251; x=1792417051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BD6Lx/GJm8UCws1aN7MZnuHlJQr+7evP6sC4Kx9yk/I=;
        b=yRVD/349CIXqo1Gjq9blMAV1TbrCQx0zxCGRXn4pF4nLkNGz6nF8Rj1i4XQLZig/DY
         JKlL87HLFq2HZazbv6XL1R63DgV13JFMHov6pUCs/mQ55KLPxsbJTjWIU7C0OF3PO+pA
         seuF6L6yCkGUD2GRKHiLZHcgxtQTYGSGQT1HfVXIKrtgvX47YBXgCcRqgG8lgWcek3fA
         Dm4JgJtuMaXPpdnuj0vdz9F8ee+3GTpO2uLxwId+YcG8GbxUN6bdYJMjf/Tc6qYXe+fq
         qIZMgXIMBzpRxlxQamQvKvlMW98c4k3MSFB9EQaQrpYcOXfll8qsMNok5m98nJtMgzwD
         6d5A==
X-Gm-Message-State: AFq9FYI+Mw2W/5vTtwyeZxwbo7qV3jEzo4IfBv9mkqOAp9wGmC1TfzlF
	EECS5VQekUf08F3UEj28haKjHXzKPUgabuXWQ3+30Gym6tcC79sKvrfcWIH2IjvDo0Y=
X-Gm-Gg: AYBFou0F76bx1ayTwYHMnAKB8HJ4WXU37rlJ7anuXSF8wmmAdqEg+ACmpXm7TBt+3Aa
	WtvUpM9FBo17xXoIy2u44eBYhFF3INX14MkO9z4HA497JEO5uJ8uyTdpxp2JsTfgCeXE78XFeAP
	t9Cyio2eU8Kh+GX2bvLLRwa9+FBBZXgJorFwf6l7GOTLBqIaMlnxH4AHYGZrr/rjCNiJqA7Ydgt
	b3MlqrxUcVaFsl4psUZeXmvWdhfj0jgAbIlaoiBggx0Uu5XKltFLvP/m34tdEIAYFeEciScpX9m
	PqekVbrMFiwfxXxuhdNxmpXX8VLzo/pQasmO/sozM1M0v3NVtwLnFjU1Fds8vs/Jpy5bqTBLrFC
	g7fcLOmX3JLrd/JF5Imun4UPChCtgrkcNoDdP6BCbJbDd4G0sG15C9aWke8FqBLDxbn1MYrVNwL
	lI/quS2yN5hyYmdJ9ldGTouJbea61AsBGcmvLmYJ6AuIUKBCgv6FeyNsSp83apy6NDC1JM0vsiX
	48MC5PA8GM9HFdQIIGpVUxmOye8n14oAq6CabWzgy7L7mHrfsVnAD0U+8iVaN1L97RZ4IcseJZ7
	bSZcRbxTiKKZn0o=
X-Received: by 2002:a05:6830:700f:b0:82a:db0e:9a1d with SMTP id 46e09a7af769-83097e59647mr10020440a34.28.1791812250875;
        Mon, 12 Oct 2026 06:37:30 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303a60c458sm10824658a34.26.2026.10.12.06.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 06:37:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 04/10] selftests/bpf: Test __nullable pointer members
Date: Mon, 12 Oct 2026 15:37:01 +0200
Message-ID: <20261012133711.4030594-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012133711.4030594-1-memxor@gmail.com>
References: <20261012133711.4030594-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10084; h=from:subject; bh=NA0vvm1I0UBnht6GYHZO7WvbhLE4uQLKWCXCLGY72Mc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevMw7XHGcPOZCUdbFl23X7ClOOXHgqJqXxur3ksPPM6t/Mt j1l9HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZjIuwCG/4Fn9d3CzvQxvNVhfjutIs N5s+KyvK2vTidNyLnvWL2rrYfhf+S5a29UTNgFrL6XbYxtcZW8Zjq77MO9E0zsxgIH+1V9OAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add a struct_ops member to bpf_testmod whose argument struct carries two
task pointers, one plain and one __nullable, both made trusted through a
__safe_trusted alias of the struct in the module BTF, and a kfunc that
calls the member once with the nullable pointer unset and once set.

The callback acquires the plain pointer as is and the nullable one only
after a check, driven through the kfunc from a syscall program. The
failure case passes the nullable pointer to bpf_task_acquire() unchecked
and is rejected as possibly NULL.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_nullable.c | 43 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_nullable.c | 45 +++++++++++++++++++
 .../bpf/progs/struct_ops_nullable_fail.c      | 28 ++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 33 ++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.h    | 15 +++++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 6 files changed, 165 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
new file mode 100644
index 000000000000..fc52870782b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_nullable.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+
+#include "struct_ops_nullable.skel.h"
+#include "struct_ops_nullable_fail.skel.h"
+
+/*
+ * Attach a callback that gets a trusted and a trusted __nullable task pointer
+ * through its argument struct and drive it through the
+ * bpf_testmod_ops3_call_test_nullable() kfunc.
+ */
+static void nullable_member(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct struct_ops_nullable *skel;
+	struct bpf_link *link;
+	int err;
+
+	skel = struct_ops_nullable__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_nullable__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_nullable);
+	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.trigger), &topts);
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "trigger_retval");
+
+	bpf_link__destroy(link);
+out:
+	struct_ops_nullable__destroy(skel);
+}
+
+/* Serialized because it attaches the singleton bpf_testmod_ops3. */
+void serial_test_struct_ops_nullable(void)
+{
+	if (test__start_subtest("nullable_member"))
+		nullable_member();
+	RUN_TESTS(struct_ops_nullable_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
new file mode 100644
index 000000000000..387792924c09
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../test_kmods/bpf_testmod.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_nullable")
+int BPF_PROG(test_nullable_cb, struct bpf_testmod_nullable_args *args)
+{
+	struct task_struct *t;
+	int ret = 0;
+
+	/* trusted, so good for a kfunc as is */
+	t = bpf_task_acquire(args->task);
+	if (!t)
+		return -1;
+	bpf_task_release(t);
+
+	/* trusted but __nullable, so a check has to come first */
+	if (args->task_or_null) {
+		t = bpf_task_acquire(args->task_or_null);
+		if (!t)
+			return -1;
+		bpf_task_release(t);
+		ret = 1;
+	}
+	return ret;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable = {
+	.test_nullable = (void *)test_nullable_cb,
+};
+
+SEC("syscall")
+int trigger(void *ctx)
+{
+	/* one call without task_or_null, one with */
+	return bpf_testmod_ops3_call_test_nullable() != 2;
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
new file mode 100644
index 000000000000..c15b3a8c8d39
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_nullable_fail.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* The member is trusted, but __nullable, so it needs a check before the kfunc. */
+SEC("struct_ops/test_nullable")
+__failure __msg("Possibly NULL pointer passed to trusted")
+int BPF_PROG(unchecked_nullable, struct bpf_testmod_nullable_args *args)
+{
+	struct task_struct *t;
+
+	t = bpf_task_acquire(args->task_or_null);
+	if (t)
+		bpf_task_release(t);
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops3 testmod_nullable_fail = {
+	.test_nullable = (void *)unchecked_nullable,
+};
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index b4f0af2aeca4..0c0152885da3 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -460,6 +460,11 @@ static int bpf_testmod_ops3__test_arena_multislot(struct bpf_testmod_arena_pair
 	return 0;
 }
 
+static int bpf_testmod_ops3__test_nullable(struct bpf_testmod_nullable_args *args)
+{
+	return 0;
+}
+
 static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_1 = bpf_testmod_test_3,
 	.test_2 = bpf_testmod_test_4,
@@ -467,6 +472,7 @@ static struct bpf_testmod_ops3 __bpf_testmod_ops3 = {
 	.test_arena_nullable = bpf_testmod_ops3__test_arena_nullable,
 	.test_arena_stack = bpf_testmod_ops3__test_arena_stack,
 	.test_arena_multislot = bpf_testmod_ops3__test_arena_multislot,
+	.test_nullable = bpf_testmod_ops3__test_nullable,
 };
 
 static void bpf_testmod_test_struct_ops3(void)
@@ -507,6 +513,32 @@ __bpf_kfunc int bpf_testmod_ops3_call_test_arena_multislot(u64 *ptr__arena)
 	return st_ops3->test_arena_multislot(p, ptr__arena);
 }
 
+/*
+ * The members of struct bpf_testmod_nullable_args are trusted the way the
+ * verifier's BTF_TYPE_SAFE_TRUSTED() lists vmlinux members: through a struct
+ * of the same name with the __safe_trusted suffix in the BTF of the module.
+ */
+struct bpf_testmod_nullable_args__safe_trusted {
+	struct task_struct *task;
+	struct task_struct *task_or_null;
+};
+
+/*
+ * Call test_nullable() with @task_or_null unset, then set. The callback
+ * returns 1 when it found a task there, so the expected result is 2.
+ */
+__bpf_kfunc int bpf_testmod_ops3_call_test_nullable(void)
+{
+	struct bpf_testmod_nullable_args args = { .task = current };
+	int ret;
+
+	BTF_TYPE_EMIT(struct bpf_testmod_nullable_args__safe_trusted);
+
+	ret = st_ops3->test_nullable(&args);
+	args.task_or_null = current;
+	return ret | st_ops3->test_nullable(&args) << 1;
+}
+
 struct bpf_testmod_btf_type_tag_1 {
 	int a;
 };
@@ -926,6 +958,7 @@ BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_nullable)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_stack)
 BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_arena_multislot)
+BTF_ID_FLAGS(func, bpf_testmod_ops3_call_test_nullable)
 BTF_ID_FLAGS(func, bpf_kfunc_get_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_put_default_trusted_ptr_test);
 BTF_ID_FLAGS(func, bpf_kfunc_kasan_poison)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
index 2b12f81bf748..b905c35490eb 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.h
@@ -114,6 +114,19 @@ struct bpf_testmod_arena_pair {
 	u64 b;
 };
 
+/* The kernel defines the BPF pointer qualifiers, user space and BPF programs need them empty. */
+#ifndef __nullable
+#define __nullable
+#endif
+
+/* Arguments of test_nullable(), trusted through the __safe_trusted alias in the module */
+struct bpf_testmod_nullable_args {
+	/* never NULL */
+	struct task_struct *task;
+	/* NULL on the first call, set on the second */
+	struct task_struct __nullable *task_or_null;
+};
+
 struct bpf_testmod_ops3 {
 	int (*test_1)(void);
 	int (*test_2)(void);
@@ -125,6 +138,8 @@ struct bpf_testmod_ops3 {
 				u64 g, u64 h, u64 *ptr);
 	/* a multi-slot leading arg, so @ptr is not at the slot its arg index suggests */
 	int (*test_arena_multislot)(struct bpf_testmod_arena_pair p, u64 *ptr);
+	/* Used to test __nullable pointer members. */
+	int (*test_nullable)(struct bpf_testmod_nullable_args *args);
 };
 
 struct st_ops_args {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 67c02a421d13..d88c99109c31 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -218,6 +218,7 @@ int bpf_testmod_ops3_call_test_arena(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_nullable(__u64 *ptr__arena__nullable) __ksym;
 int bpf_testmod_ops3_call_test_arena_stack(__u64 *ptr__arena) __ksym;
 int bpf_testmod_ops3_call_test_arena_multislot(__u64 *ptr__arena) __ksym;
+int bpf_testmod_ops3_call_test_nullable(void) __ksym;
 
 __u64 bpf_kfunc_call_test1(struct sock *sk, __u32 a, __u64 b,
 				__u32 c, __u64 d) __ksym;
-- 
2.53.0-Meta

