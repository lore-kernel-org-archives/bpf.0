Received: from mail-oi2-f7.google.com (mail-oi2-f7.google.com [74.125.231.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC54F390B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416141; cv=none; b=GCaJ2CcRw2THXIQ0Lzk7H1jLatCyV7OuSt2paq/DasxzZlM/Pko/IbCqMbTmMsvGMejRK+0eqFqvxQZxv0E/UMEyyItKBJDBbiexwwyw61Bl/gQYlYF6Aj7riDE18kxEU4ynzjNH9FcsMU68dV/jOcPcdyQg96lNTnXT9ig/ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416141; c=relaxed/simple;
	bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS3OBRbZfnpv+UL3rW9N50K2uhDdhVsvWRGMeB0fMHYQYKMVXvsbaG9LEMDdDxzFvucxU0zUadZdRG0S2T+tgFEMd2nDLTqU2MU9rGkiRgUeNLdU7G3US37Jn7+TOy1QepWiIwWq9OHwQI4ESTsDdMtwGlNQ8u0dSxNRnM4edSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HudxJgY/; arc=none smtp.client-ip=74.125.231.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HudxJgY/"
Received: by mail-oi2-f7.google.com with SMTP id 5614622812f47-4b39374fab5so814632b6e.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792416138; x=1793020938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=HudxJgY/MziJxU+TUO9NKBleJu3HCg+T8ZbpJgBzlWBEZCQP/0wVVhL2w5xR16w5/D
         jM3ab8JuoJM6ZmLe31pNUPM3XcP/LwYeLoKNhp7yzNdCqco++m3E0so0qNLMRmXgTMzH
         qRDhN13+MWAyv5lo5VPe5nP+0txS2bThZVE0YvA6YV3UZA7CCe8WD5Ootf9qaeN0t/JT
         83Tc3EuUWLp+LagQCaiOEQ19yAjYupnftZUy+v0sq+CcVH6sUCZ4hJddPJRCBsrDwyh0
         1oE993NuEZI9cWyD6cNMDhdpn/74/0Yp7U9eniHtwmhFmlK1jA+qTrtTuGoPZDb3iD3J
         0A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792416138; x=1793020938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=lL9PhG4wk97r3qzU11OoH0nJnPgVOOmdfxBrvU9LvGLyLJpPhkF23hiQgzj7MN8TNy
         mRXMr0VviTkWJi5oMFtLIo93DBcXbkr3Q+/lcv9H1OPSCcHkkUJg6XQQT5jwwCZR9XCC
         x9GzihPVvsA9g6CZns8bUGXz9PxYZ/qKSsFY8bi9svkcEIYu7wl5hXfgmHkaFjxqx+tW
         mkCweOVu7gaONApqWFiBaplUKNwMBdNk2wKmjj/7nMNfCN2wRuMi8soIZt5OW/javMNt
         Cnqh8Dk0xTwt0R134NwJl3DUsvsPhRy9xQ4YqoxwtQUxv0AbuT43Db+3b3wOhGjrbZKQ
         clmA==
X-Gm-Message-State: AFq9FYJGV0ZgrsgU74lDS35W7oN2uN7sGWYERkOZztbhS7FhmAq/oeqb
	p2nSrg8s81AJ3jkPewUWwXoccY+qBgZ5mVQ3qw/UF3Beqd7nBfBxWaNFp596VtRHD6U=
X-Gm-Gg: AYBFou36YzerKGbRVY9AnpzLei7S2lETTpyAkHswNxSh1+rpC4JmTn9p7bTmzDsXeyY
	xv8TGKL/cKQ9fvbeUgrGo2Hr0Nay9erC0JcPcNE2XEVRYQ2KHL66EJIBd0huO2eYYpTJkmZvdtD
	dtk59Lk1uPLyX88rfEajLMLaswq2ipppnudN6ShDnonlQ2TwLuatuzlglxTs3MjRHpf2rUUDsvS
	xykrPcVaTZxxkY8Jc8aOoAJO44yLeZeNvQuiBDLl9rcCJ7LmjAWn57p7tU83xTxoH0ct0+fDEx5
	2LQbpebNRqpvx3Vq6BJUmUkShQ8Bj2373EY/pO6r+FxPeH+bOp2Z7ANm/7ImAC6r7LAs7+OOIWz
	ybbIE+dlrJKA+T54ZMx75EmWYSNtfiSr44sA9TnNeoE6C6l5JwdEIlo/yoWda8GvNFPKgh5KFZC
	qbJEzOu9FmCzfuwLiyTk29CiiNEhvVC1OfV0Zt1TwV8c+ul+o1C38gknEfS0DDzb/EE6QY5cjtP
	N5dm/1bXRihYvQvjxjupvNQqkprU/QEEUv7BhK9iucmlmIhmoaJXBTlhFyuYJ6nWq8NzKzhWVdk
	EoeE
X-Received: by 2002:a05:6808:c226:b0:4e7:d180:7719 with SMTP id 5614622812f47-53cd20a427bmr6033718b6e.42.1792416138563;
        Mon, 19 Oct 2026 06:22:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-54216a94c00sm3597169b6e.0.2026.10.19.06.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:22:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 04/16] selftests/bpf: Clone a program that calls a module kfunc
Date: Mon, 19 Oct 2026 15:21:46 +0200
Message-ID: <20261019132203.3034698-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019132203.3034698-1-memxor@gmail.com>
References: <20261019132203.3034698-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject; bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuaxBHNoweVS/LF1aVPey74de7A5rbeI9ucajcYcbGvnHpk T0tPRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbynIOR4Uf0gTvdbncYJXqLdRUKMp Yb5sQsWbPqwX5/U/nAivshVxn+56271Hf73zy7hwEbbyfvV38yc8b5qQ82x5xkefPIjPlkOR8A
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

