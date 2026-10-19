Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271CC444719
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380264; cv=none; b=qyGqb8ho23OnjcuWiDlnCKnUTCumb3iq7HICONhWZRUIgIkqn8yw8MmcnywoVUBuljiAWoPDQMk0DuAloHN2aBBKscTj+3ACQ/mUCkMWf8yix5BF654BZNBIHZ3D7DEMXgSfWGxGwps2Ft9PtoqUYlblAbM/0jYmoS3lS4fykOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380264; c=relaxed/simple;
	bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSkmaygVvxhRPMLrHV86IjhXGoH/SWpC7s5GiU2FLEduNNiBEyBXPNBnU69A0GyDXPHEsLgqsonz+zdzlyQgmxZcQ/TNYh15Vta5WmGkuS3889PymCaGlUnDVYjxWF0Ajo1dQ3CJDviyzc0M6eTyYhOLOcBpv4gM8Z6C1c5eKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks7zMgK/; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks7zMgK/"
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-462dec1c4c5so678059fac.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792380262; x=1792985062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=Ks7zMgK/5u4Df1KHnBNmzzwU9HQJRc3mcpi9KxBV8i1f1IhIJXViIBy13JQP91jcI5
         Uax+KFqTalRYtgtNyRhEy5jz0Cu6WiiQPT5g/f2M4F9lGqFyZZw0FLnJVLB0g6YcKt1p
         oOcs98Ls0m5+WrTmFl8EAWYT7U0g0bOwA/7st9fibm3nRo/vt9hFAFUz3oPCeMD6JYVq
         lJS0PfJiQKTr1qQ5S1Ly20CuYoMQvEQLZcVIiXMkVg1bMCKHUg2IVppwiQWljKbxyaIY
         osKWAxZirrN3+2QG/osvaIEcdM7zQSToSznUEjSv9Dc+zxxJSm22a6pQ6047n1dPpYMi
         VjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792380262; x=1792985062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=BRLfAPsrWTs7STEYJAjA8gm72/SR3FaeQgn1AGbN1lvj6gX1eJp0aPDufc6kRkVPlw
         JwamO5jM6QK6+J3X4W23GwPmrgA83p1a9fzCw1QuzNtsx+/zJeM2C/m3vae9yLhuLYl2
         PDLj72wYa/z7lQTy2eMoprTcOWlA2vs0XStfY3ngFNcNrhRVTF+RqXZ53SxvZdTNkXvE
         S/TxO5GfSrwIn2YzpYVlJ8tpNaAYAO5gYLqZArT7gH5yYQ3ukIPEvbQS2yUp2U96t3fH
         DKlDWS1w2XEBmDVw2sB6bQpJ+LDyDem33kUryTeZSPjLPwlMY0g73dts52cNRLc89aHe
         7LCw==
X-Gm-Message-State: AFq9FYKvU0nt7R7kR3Kd1uc815O1KaZiwYADWD5tY2qIiGKBjArTH6+C
	XfWHFiwmkyW8yNd5bhvSzCNNodEHO6LzA2u7PDULde1DSNrx0GaxHHELsL7r40lC5z8=
X-Gm-Gg: AYBFou2fFGwAYadI0/rQTHztrFVZNTFnFmJ7ifBC1J5/tR5q77odqbLpAS/Yx9fu+Hl
	Q7yB9sbl1k1r97MjR+ndNIPLBJM3uGgoFpwIqJ/IVXfVRelSMQeOHaoEBU+IWcl5K0CFcXwmQfM
	lCrT29Oip4pp31NPVAGsssSTJyb8s7hIDKAyMkdLY4mYCIz07qewDpiDJ5Avfdr+9fmJ/tPLGND
	AUKyibZg5/icWoW8rtkXCmj3JWF2N/rutZdv9o/oufOgsM2NUSzq35e+IKyJYWsd7xev/Wt3Lgo
	NqzLqzwsu8w6jdrxxJXQ/xFCE1MeS9prqZfPCmbxqou6oVSIVSfp6Kqkqwoe2kVAG4OfdAVhq4o
	q7lbtWnSXFXu4KQ8ujP2mCFsoqzqtSa2/Sm6ED4xzuL8ZL4zDNjq7at5OKy31YU+GScFQnFhrsw
	qULAK50DBFDwISLVYO3gpQvPH+2/XGveHS9MXEPiLpOC+O3ICu/e/knUrafQfSxEQj2fLl0PGOz
	bl7w5uuL07HdlhHuB7WMT8Ymvji/QtWcuj3VvawtFSXUf41FFlREYBeo5wl4B+j2UvWmN7UHysL
	C1f4
X-Received: by 2002:a05:6870:d621:b0:46a:ebcb:63bc with SMTP id 586e51a60fabf-4a7575e5e39mr5399806fac.3.1792380262003;
        Sun, 18 Oct 2026 20:24:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73adff016sm7608300fac.0.2026.10.18.20.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 20:24:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 04/16] selftests/bpf: Clone a program that calls a module kfunc
Date: Mon, 19 Oct 2026 05:23:44 +0200
Message-ID: <20261019032401.2302823-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019032401.2302823-1-memxor@gmail.com>
References: <20261019032401.2302823-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject; bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetqr67m0YPKJfni6tKnPRf8Ondgc1vvkW1OtRuMuNhXTj2y p6Wno5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABPJ/sXwT0f7Sf/+JRcSjrboLA0+92 HCwZ39XCX9+xcZnna/m7X0wg6Gf3onSr98WPvCxGD/xFeuCxZcuR9zX/zAJ6bpNdY37kZN3MYJAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Prepare an object whose program calls a kfunc of bpf_testmod and load
the program through bpf_program__clone(), the way veristat loads
programs. The module BTF fd sits in slot 1 of the fd_array of the
object and slot 0 is empty; the clone used to pass the fill index of
that array as fd_array_cnt, which made the kernel resolve slot 0 and
fail the load with "fd 0 is not pointing to valid bpf_map or btf".

Cc: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/prog_tests/clone_module_kfunc.c       | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c b/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
new file mode 100644
index 000000000000..fa6ccbaa7fd9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/clone_module_kfunc.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "kfunc_call_test.skel.h"
+
+/*
+ * bpf_program__clone() loads a program from a prepared object with the
+ * fd_array of the object, where module BTF fds start at slot 1 and slot 0 is
+ * empty. It used to pass the fill index of that array as fd_array_cnt, which
+ * made the kernel resolve slot 0 and fail the load.
+ */
+void test_clone_module_kfunc(void)
+{
+	struct kfunc_call_test *skel;
+	int err, fd;
+
+	skel = kfunc_call_test__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	err = bpf_object__prepare(skel->obj);
+	if (!ASSERT_OK(err, "prepare"))
+		goto out;
+
+	fd = bpf_program__clone(skel->progs.kfunc_call_test1, NULL);
+	if (ASSERT_GE(fd, 0, "clone"))
+		close(fd);
+out:
+	kfunc_call_test__destroy(skel);
+}
-- 
2.53.0-Meta

