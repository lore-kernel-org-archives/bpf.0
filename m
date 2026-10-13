Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F283B27C3
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879625; cv=none; b=F6BngcDs+Pnyl4z/7CQDZvg7gISnApYSr85wONNeUmHjvEDoVerUTF6oUk+ctowmmxbuqlS2eg9MdLO+JXfSiFxEO0Hz5wxbJ6oqiIGser77DsJCb6FIUPgfI1zeDtNSrosnZ52DtGFPnqBUirECNV0oYV0Ekhx6JSXp9dHcX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879625; c=relaxed/simple;
	bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfqCHlBXYSzMqT7cnh9HcPjQniZ1rOQNMxyLgpbdIqfQMkuEB821YHJVioyX6kfHCEfMYvjqO2Am9U9Ee+99sD9YlG9uKuToU7s0iNJsy+Dr4nUCkz0murGbeT6pKf4V5bkTU85T6kyiHlnjDgltvZt5ZSYzNWJRXVYgNJtPB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsxhW7r0; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsxhW7r0"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-4753ef5108aso1087464fac.1
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791879622; x=1792484422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=OsxhW7r0fwSyQkj14MHJP6Kj/ygHp+KYJzdNuEZ7F5hB4F9EPNa9BMTRBQwG4HcJEn
         3IpUqZoEUFUlUVhq93+JiuPg8+jojQ/zh7XzkzW+eQjAXEhRSLM+ciSgT1XCwMvNioAI
         n4g5CEIw9yesxXKLeTBHrnKpFi0jkoO09hfP0TEUTwwpugfmEa53vu+EWo6LoxxneOwY
         O7ZWNa4VMLPWn8HFn//jgShZlZTehQotdShD7sy9wyjyY383B4QXkXulS9Nka7cspVxH
         TKQF8v4Ja1RYa4dOTHnGBXDhByhQwi7AoaRpdswBGoNvfa2sm8tBjAlA/c9l6M0ZmxKD
         2ABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791879622; x=1792484422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=WKwDv63Cz+n6LhG4rca5+oVPu8O9gIthX3+oSYXbg6QwsmtsMhreI2HodKsshJfS8B
         rEWMH4eNaBKBgRDQZvG/k5F7rce1ERlAhijNJ1H0fB9pFaa7TFmyf8A0uu3d8U+bABAb
         TJKUlFyhkZ4UiXYldaO/SxQuzlAZsu8kGtinAMja+2R0l5KPZe1H/lCmiU3m4ws/6nPe
         FiRdaT5/WYZJJTJbGBHauJLotbXowqhc+9UuC35LblSHr/rGMtIvs4dbMWt/5WYIlSNb
         1yxbYL/0NLNkFqgfjGjjd7Q0pslp0pyzIAjVPX5e9rwgzf49J/ZNH3cGrIa4to1jcKsV
         DLQA==
X-Gm-Message-State: AFq9FYLyzg+VQsOyyIml4EAIq6cZk5LzpE/UOWQu39qeN2+YCYjGHPNS
	I36+XuVat515gJKix/oOZ0XmMJf4tfWoOR3MvgLrCjoBrwDthAdZeKgmHLbUZQ6ir1o=
X-Gm-Gg: AYBFou1vtfNoxuUPlTpm4Yx1cwYsNJR7Nio1E0x3QtD2CbM5DAdyiG/g+FcBjb58qhA
	Zw5K5r0WNIiF13ivkUHXSSwWxIbyMuBCu79W4ZPSrqk9zUE5fa0iwyPXEELiT1omwD768vDP2WW
	pYcfEdZA9Khu2Xcj32KJZzWnfegxqGeFXJ4uXHHLZN8c/xfS/0ioyhPLEz/xPabAfJesVthZmNL
	K4x24cWtgaOgRngF2HIYcAQCVD5+L3Cu6hbFcoh1fp3xHTxOHHKzHwhTXXykooWu6vjGghY6+Xx
	edPKJJxEHX4rtB9jQw6Zy727WcvKyOw0AkUk6T/a0f0zi5+UspQYsdhah+VTriOVbfzFJCUs+cK
	QSgXJlEBw4NrBIDk4/REtIhLHlpIJsXpQVMSVpJ/KrSlGmN4RX0wbqt+KRT8xD0xvPujA958zpS
	FiZR4iepCbnJRS8bZs2E5ji69oyfeB+T7wgggAgQsIl1tt/4U5f049nQZjE8ETKV9fgrAap/chz
	rvzeskN6D80I0RHVEGV801P/oeTibOZ40iArZP8l4YuSCWvCuFJ0++GjIENj9lAJzILHcc6aktI
	n/75
X-Received: by 2002:a05:6870:16ee:b0:485:d1ab:7936 with SMTP id 586e51a60fabf-4a2a8865700mr10145152fac.23.1791879622512;
        Tue, 13 Oct 2026 01:20:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a7e58c0bsm12309002fac.0.2026.10.13.01.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:20:20 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 02/13] selftests/bpf: Clone a program that calls a module kfunc
Date: Tue, 13 Oct 2026 10:19:57 +0200
Message-ID: <20261013082012.1107446-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013082012.1107446-1-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject; bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIevsy3maRw8ql+SLq0uf9lzw69yBzW29R7Y51W4w4mJfOfXI npaejlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEwk5ynD//Co6CXXny644tg/697uAq uLcadWhZSGv35g0DZPWc7zdQ/DP1vN319kz7XN4L5y+JXHcisbrXgzjkumMvO5b291Edxfww4A
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

