Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E0605D9
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721950; cv=none; b=Cow3jzItA0R1nkJfX3wDqvXG/FeSzAZFAJeDG+/JfnIqGLr7uNTS4EvZL0r6/KujQMukR3VTmR4XP4Nbb+fdTHbm7CJSndAE45pVUH0IoTzCbJbZ3H3FfT9OYJ3DKZLeFDerDx42rXpkpnJ8XVXMaS7jSaJd1LC60norgYkptWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721950; c=relaxed/simple;
	bh=1iOMjIDBisCaf2/gUeBMwvH+IKTk0Wc9C91o2m9GN90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYXVO2OCFLYjVMvimSDDDOFCtR4TfE3KUeTsbckEiTedbaQqdC1anZ7foNvayeW+0Rvs6s/6YQfYd5b4vOtGlRofgHCWHAeBXigm066zn2ROtyb5/iGLIAGaB7WpuhCfokgUG2kPvEi1b8Q24r8l4xW+fMxS2c8DHBapd9Lmuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aU2+ZMgm; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aU2+ZMgm"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56715a6aa55so3979169a12.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721947; x=1710326747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MebKaQUWBNfrYV+FUUP3D2chpFGoR/EqlF1UJnbSX/k=;
        b=aU2+ZMgmxLxvjwDrEiD687XgrUpWgwcyYPzDsbsWyE7EhdvMTrF2SDfPnnxUlAJ7ls
         1KQj+NTXi63bdlpbH8vylAs5/2/gEGAdFnAN16GZoKpnvz6tobWmMXeY02coB87fC8ls
         Bc6pR5uJ6Qf9QibciOCzrDbMNsaDoIxFkAnr69+wcFbSumE91yJ9NTS0Gc275f3LbrIU
         QtZQ23RaU1aTVBUrvsXN7GZV5mglZL3XRGNUmrqNACSdo1UbjCe9Eitjlnvh/KObo128
         v2jDmvyxs4fU+cIWpYN2tQf0SazYCu/gbp7NSjaqKZlI++5a2sR1aklVqypLh+H/DH6K
         fK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721947; x=1710326747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MebKaQUWBNfrYV+FUUP3D2chpFGoR/EqlF1UJnbSX/k=;
        b=AbA/c9LM/6M48EaUreEEwQ6fYfkzsUf0d+O0bMylbkapN/9XSGCAc2EAttJuTaDPUx
         xhz0H/XUNfsqNt0JkHIltAKWeLKlFrM7E03wzkCBLFCROBbYtGBhM03eu4nxoqnbBMV0
         PZdWy1GSUOv5uI4PF/DnuB4t8R37UBwypnPODxGMhpnqaHhSZGiBlohNce+1VMJHPRW2
         HWc4AneWqagCuixgMqOF+bjMWPULzCnFX5rs/oScvbJM3hyngjQZ3gv5keSxRE1oGyeM
         jc80z7wW4fkP7UhFQMJ3ae/UrZ4eCQzMe1N4f4BR+kuI8HxEpVj5FD4OTkGd5L3yc18m
         /GNw==
X-Gm-Message-State: AOJu0YwNLXxkr50AZlLW4PM8VcPxd172HIMtEi4KN8w6wBl4MHLAFil2
	DXBeDaTdX/oBFoBz7KHaqHMPiX8s7e3u28TkaSzr2g04BJKCALqCSr4fXVW2
X-Google-Smtp-Source: AGHT+IGJG/xdUg0MmAPWeBgl/2SfgsCQpFECKzosr5WMkpNMisl3CkKRiwGT0sledZUDRftQUneivQ==
X-Received: by 2002:a17:906:27db:b0:a43:dd85:e171 with SMTP id k27-20020a17090627db00b00a43dd85e171mr9588561ejc.69.1709721947030;
        Wed, 06 Mar 2024 02:45:47 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:46 -0800 (PST)
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
Subject: [PATCH bpf-next v4 06/15] selftests/bpf: bad_struct_ops test
Date: Wed,  6 Mar 2024 12:45:20 +0200
Message-ID: <20240306104529.6453-7-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When loading struct_ops programs kernel requires BTF id of the
struct_ops type and member index for attachment point inside that
type. This makes impossible to use same BPF program in several
struct_ops maps that have different struct_ops type.
Check if libbpf rejects such BPF objects files.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +++
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 35 +++++++++++++++++++
 .../selftests/bpf/progs/bad_struct_ops.c      | 25 +++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index b9b488d6d53a..39ad96a18123 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -611,6 +611,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int bpf_dummy_reg2(void *kdata)
+{
+	struct bpf_testmod_ops2 *ops = kdata;
+
+	ops->test_1();
+	return 0;
+}
+
+static struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
+	.test_1 = bpf_testmod_test_1,
+};
+
+struct bpf_struct_ops bpf_testmod_ops2 = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg2,
+	.unreg = bpf_dummy_unreg,
+	.cfi_stubs = &__bpf_testmod_ops2,
+	.name = "bpf_testmod_ops2",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -622,6 +645,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 622d24e29d35..23fa1872ee67 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -89,4 +89,8 @@ struct bpf_testmod_ops {
 	int (*tramp_40)(int value);
 };
 
+struct bpf_testmod_ops2 {
+	int (*test_1)(void);
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
new file mode 100644
index 000000000000..9f5dbefa0dd9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bad_struct_ops.skel.h"
+
+static void invalid_prog_reuse(void)
+{
+	struct bad_struct_ops *skel;
+	char *log = NULL;
+	int err;
+
+	skel = bad_struct_ops__open();
+	if (!ASSERT_OK_PTR(skel, "bad_struct_ops__open"))
+		return;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+
+	err = bad_struct_ops__load(skel);
+	log = stop_libbpf_log_capture();
+	ASSERT_ERR(err, "bad_struct_ops__load should fail");
+	ASSERT_HAS_SUBSTR(log,
+		"struct_ops init_kern testmod_2 func ptr test_1: invalid reuse of prog test_1",
+		"expected init_kern message");
+
+cleanup:
+	free(log);
+	bad_struct_ops__destroy(skel);
+}
+
+void test_bad_struct_ops(void)
+{
+	if (test__start_subtest("invalid_prog_reuse"))
+		invalid_prog_reuse();
+}
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
new file mode 100644
index 000000000000..b7e175cd0af0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1) { return 0; }
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2) { return 0; }
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops2 testmod_2 = {
+	.test_1 = (void *)test_1
+};
-- 
2.43.0

