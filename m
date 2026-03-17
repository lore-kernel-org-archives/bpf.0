Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52539337B81
	for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769187; cv=none; b=Q0+APHydq0wQTOopZF4dxqErCX0jRZ+xTIpdU33lSecMabcDprwItb9ARj/zk7ETLSi52rfJwf0yne6WbHMDVOqNMz6CToRDJLScDeeRhoqzZAtvFsQ/TRdoMoiN53QocWXYyx8MuOvcvYZpbzuKWvhZFJ98gXvAhhn5XdQXQBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769187; c=relaxed/simple;
	bh=xIhVWWsHKPpZKqHW3smVa6GmXV4GX5Igre6JBaJhxU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5xpAoyqOUwNAMBrz0U4I7LnfUheC+ybVMqIaWj/Bata8BA8SE1J28mZyEWNLZ4rgMM+ltBXmzWi2u6JoS0bciOl/NY30J4719HY8XhBw4bkmHGaky8aeHfHMelvi4NV3A/+YAV1us7ahhGGkZl9+ZqQ2pGr1+BLfJ1fh59J+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBrXz9dj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBrXz9dj"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b48ac2727so1385187f8f.3
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2026 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773769185; x=1774373985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CqPZhmgW4VEJI/ApENv7EPTsNG5OCKduXLH48if5EPU=;
        b=VBrXz9djTaRONRMGYl8uHcDPqaRLaXEg/DCwS+nAFkzOt4DJ5B0cZjuG4X1Loh7nGV
         xXBNzqe6c+YMBA76IaEvuqNOxs6KQrf73rPk1W7G7PNL/HvrW9pi1tMZGTjua0TYqsG+
         9bPsCawzB7RMyCeUXEqbGsSM8I35BeDzv1Fc4Rnd4AOFC7XGdTVjVrPUs5mtrPYnse9E
         SyBMhmmGqFwAfi1VExKK4qu9cTi3iRk5CiyImUhkzoqWUIPhMsS0qK8zhHcKezkvZTUq
         9LTIj/c35IpeYWzjXKWD7R2ZjkrqHDOBFFC2YB/CN0jqs1oDiJvPDwXdLb0F4CQCxkE1
         o27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773769185; x=1774373985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CqPZhmgW4VEJI/ApENv7EPTsNG5OCKduXLH48if5EPU=;
        b=WScdL6P4B6lvOkNpEyVH0FoOfbjcXX73NX19/rzcS3xuk5WHP7Sgofx6PotD5XArQS
         FhYew/W5Es4r41RYSvWC8Jllk7fBG44irrBTSRY+rAWYPCF/ceznSY8UDym5rPwxcIa/
         hRhM3/g1QuoDkiMcN2tPKJuoX/VapawRND4p4sgJ+yavneCoTiHpVnI1Kew68eO+dw8X
         NSFG3Txx3JL8/j7yj0Kk/TDDBHUaA7tqcHYmSWAi4JBpXoo/vKHwnQPnvMqMIoTLc8xF
         zi0lxP/smtG8GAYBe4u9/izcGG4s2bVvgmHQwei2sIKwZB4py7Bsz5elGp3960gFogik
         cOJA==
X-Gm-Message-State: AOJu0YzCUr9SNZ2og6Z/LMSEtkPE1CfmYk1abbXn/pH2811N47rVkRIj
	B9DwgPhI7ROMmgkvj64ZIFeozzPIha5BDdYoqY1/fazQngg3dWed84Xl
X-Gm-Gg: ATEYQzwEv2tfmtXoDx06B/PdoCN5XDjBWGZO2im8hq2H4RF0v4EkdoNYkDR1JKwnwrW
	Xqj2G+dVyRZxHyfG1qGx07AqrpFbLWodmhC453qgSoRs/u/GChizA0uudandPTSLrqybvrhMGzy
	EnHX9pnXFjQozZwV0xtIC1SBlxvYFh+TkF5I+30W7OIvDYcyttI2CIUJQP1HBMSVBOIV9o6xSpE
	YO58bK4ZdtYKgb5XGMdjz5HCTdFdzEyBXtPKmXNiOdc6Ikc7XTCVS2MRtZ2Oi2I5MadVvDWWH4d
	i1xqp8RihRUFRzlMVo7M88mc5huPnJSWu9MaFbFseukHT1yobeMkAFXYqqHzPhLIh+mIUbHjEqz
	lM7lxD+vfjdo6ZyyUpN5YpmMtq1BRPthc0aKDb54UYz+m7hTL4uxTLGtS1XHVrfI3q1PdMODoBI
	XD0xM4meNfXC9m
X-Received: by 2002:a5d:5848:0:b0:43b:3c06:c30a with SMTP id ffacd0b85a97d-43b527a95b5mr166463f8f.18.1773769184480;
        Tue, 17 Mar 2026 10:39:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51852a64sm892344f8f.14.2026.03.17.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:39:44 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 17 Mar 2026 10:39:23 -0700
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: Test bpf_program__clone()
 attach_btf_id override
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-veristat_prepare-v4-3-74193d4cc9d9@meta.com>
References: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
In-Reply-To: <20260317-veristat_prepare-v4-0-74193d4cc9d9@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773769179; l=4034;
 i=yatsenko@meta.com; s=20260220; h=from:subject:message-id;
 bh=pJSzCJ9YUgU4ttOTlnJ/v+4hGtDOBecXc4NF2InTQfw=;
 b=IquDSrG7K9wOGkYAcdd1d+8IRJie6deV4sh9N0RnS87q9w+51zPqS9jDjdCfhwCfr/+OrZ/BE
 ga3lNaotcCeC7xzXIUKmTxJ0JspIxGgqFTLYkWIbEMxF2W66GUVDcZC
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=QUfct6THKRRhwIGGKcldE2w7zXPci1gMPcF7qij1gwA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Add a test that verifies bpf_program__clone() respects caller-provided
attach_btf_id in bpf_prog_load_opts.

The BPF program has SEC("fentry/bpf_fentry_test1"). It is cloned twice
from the same prepared object: first with no opts, verifying the
callback resolves attach_btf_id from sec_name to bpf_fentry_test1;
then with attach_btf_id overridden to bpf_fentry_test2, verifying the
loaded program is actually attached to bpf_fentry_test2. Both results
are checked via bpf_prog_get_info_by_fd().

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 .../selftests/bpf/prog_tests/clone_attach_btf_id.c | 78 ++++++++++++++++++++++
 .../selftests/bpf/progs/clone_attach_btf_id.c      | 13 ++++
 2 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c b/tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c
new file mode 100644
index 000000000000..1c3e28e74606
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/clone_attach_btf_id.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta */
+#include <test_progs.h>
+#include "clone_attach_btf_id.skel.h"
+
+/*
+ * Test that bpf_program__clone() respects caller-provided attach_btf_id
+ * override via bpf_prog_load_opts.
+ *
+ * The BPF program has SEC("fentry/bpf_fentry_test1"). Clone it twice
+ * from the same prepared object: first with no opts (callback resolves
+ * attach_btf_id from sec_name), then with attach_btf_id overridden to
+ * bpf_fentry_test2. Verify each loaded program's attach_btf_id via
+ * bpf_prog_get_info_by_fd().
+ */
+
+static int get_prog_attach_btf_id(int prog_fd)
+{
+	struct bpf_prog_info info = {};
+	__u32 info_len = sizeof(info);
+	int err;
+
+	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
+	if (err)
+		return err;
+	return info.attach_btf_id;
+}
+
+void test_clone_attach_btf_id(void)
+{
+	struct clone_attach_btf_id *skel;
+	int fd1 = -1, fd2 = -1, err;
+	int btf_id_test1, btf_id_test2;
+
+	btf_id_test1 = libbpf_find_vmlinux_btf_id("bpf_fentry_test1", BPF_TRACE_FENTRY);
+	if (!ASSERT_GT(btf_id_test1, 0, "find_btf_id_test1"))
+		return;
+
+	btf_id_test2 = libbpf_find_vmlinux_btf_id("bpf_fentry_test2", BPF_TRACE_FENTRY);
+	if (!ASSERT_GT(btf_id_test2, 0, "find_btf_id_test2"))
+		return;
+
+	skel = clone_attach_btf_id__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "obj_prepare"))
+		goto out;
+
+	/* Clone with no opts — callback resolves BTF from sec_name */
+	fd1 = bpf_program__clone(skel->progs.fentry_handler, NULL);
+	if (!ASSERT_GE(fd1, 0, "clone_default"))
+		goto out;
+	ASSERT_EQ(get_prog_attach_btf_id(fd1), btf_id_test1,
+		  "attach_btf_id_default");
+
+	/*
+	 * Clone with attach_btf_id override pointing to a different
+	 * function. The BPF program never accesses arguments, so the
+	 * load succeeds regardless of signature mismatch.
+	 */
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		    .attach_btf_id = btf_id_test2,
+	);
+	fd2 = bpf_program__clone(skel->progs.fentry_handler, &opts);
+	if (!ASSERT_GE(fd2, 0, "clone_override"))
+		goto out;
+	ASSERT_EQ(get_prog_attach_btf_id(fd2), btf_id_test2,
+		  "attach_btf_id_override");
+
+out:
+	if (fd1 >= 0)
+		close(fd1);
+	if (fd2 >= 0)
+		close(fd2);
+	clone_attach_btf_id__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/clone_attach_btf_id.c b/tools/testing/selftests/bpf/progs/clone_attach_btf_id.c
new file mode 100644
index 000000000000..0ffa3ec3e1a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/clone_attach_btf_id.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(fentry_handler, int a)
+{
+	return 0;
+}

-- 
2.52.0

