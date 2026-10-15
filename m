Received: from mail-oo2-f11.google.com (mail-oo2-f11.google.com [74.125.231.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47B04A841E
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 23:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107707; cv=none; b=iH0aPkBcWzIL6MMgrX84Ko3lPi3qBI8lfuLYaclSxyQXNmJ84N2DHiVd2RYPp7OcwS6mgkei0wQCV+OKQX7+mMxk23c/4XH6ZjaD8g6aIW2MDKVXnog2PNRuZ7A5emfcgMAHIKLUMEBGI6lu5P1/PYf/GctdymR5pnuupM3+9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107707; c=relaxed/simple;
	bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhLLIzzSpyvYYr0SHF3uN9SNOO5BbWSx7aEdhgp2G9pcJajDQj0tkZVmLZWeZUoKtqgI/kd11WeBB2zo8uXl5jD+jzjAC9u4a+uKJrPPFJlSR/fwITcC9PyeVB8a4/oVlx6XsAAIunnUT3PqCFaeBSDmwG9lTXj+jTW8eMZjbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFXb1vFI; arc=none smtp.client-ip=74.125.231.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFXb1vFI"
Received: by mail-oo2-f11.google.com with SMTP id 46e09a7af769-828c0b569f6so1024867a34.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 16:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107705; x=1792712505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=EFXb1vFIvhDuD1BCULzNwiCxFKp6OHEewq8Byg+3c21z+hWTK9OL/k/u3MY5aIjVvo
         uk0SAj/NeVAUUHTwbU5rzfUbRmZNjjq/8lLjkJ757gIZm4zOwpZ0VxUpAhy35q9lv2bg
         38QkbuONr7gk07VwnoFSIt4NSbdcO8DDIW4jrKIGQBPad8pCTaGSOLIIJgQ0LfTyP5fW
         PfZFs/MywhcVI08anJqI491XjXtkEi/FLJeieXMkgn2wtdxXg8nJbpTsezR2mTPF+fdR
         nCWFIa4Aals3alqX5vz33//pdcrP9ndZuHd1/z4V2zp6qvnv7uhYVUPzYOEw03geIU+g
         86mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107705; x=1792712505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Le+JqdNhGZ7FITF3Cabx9gvL5qFNvU6cAFx7z8aQg4c=;
        b=1hQed6KOr/xo9UdfHjV4o0+qIRK9j9MgZvnfr9zYLMDQeqPJ7U9q+PixxLaw3J7j5y
         dfNbDjGkPh6IU4WOD2c+Q+Wb40t/IBFzud3w0HoDIOdJY3Wo3/oG4R25VVHza+1QyIT7
         OC21Jtaq69qJ1ck3W1mKkxb66ijg/hTMzmJr1VBC3haB8D5PUznaZRNr9FiImneB1bNJ
         2JyQJlTUT58q73FeXp48Gpl/PPp3QiDPRgIEm2L4XxcYnS4W+mvi9ddqD72ZUaLJBiPy
         yrygZa4v/rr8gsChLSD2gjze/9RlCc93o+CxaRQuiSRoF5I5sYbXtBjw437uqfda8E1Y
         2UjA==
X-Gm-Message-State: AFq9FYI7yKmpe8oQiu2UrVgvIBrSDozwy0liggEUl2ZN8OJ+/oqzEEbq
	gNVsoaHsd1X8sI7SsYiAU1F3CefV8iPmKt3iDIFIO0WBt1PLqg7ggUlvOTBKQhWRQ2M=
X-Gm-Gg: AYBFou0Uo4wxeuyUoc2wInzAcrx4KlKuafFRms4I0fCMenfp8HqdcDkznUtlzi0NnBJ
	C/kMggr56HHuaNE6g12D942BEAtZzXT8ZnvzsZe0pN0TN4fa6Uq0GyXLv9NvODlLlVymvbkgn9b
	vyVHCptAKtkU2wg2s25dBOGvk222gY4JcJP9jKsnZomv2HXAdqaeGtqHuWceiaeTKMzd0zojpNn
	qTYmCtuEEJipl7eXivJ8ytiUBOcYHkAFKdQaIU0KNfvHvEAG8Jippy7+FJICUOcf7eKNiRgSHSY
	SYaxKMGSrTjOSR0kOyJpTbexbte+R2l6xt2gao8vhzDVyqNQEog2mNQMTcVXYIntd79Maz1lpbM
	WzREzvY2+u8TS5Vw6jNhqpXSKWebQsEtFocAb+pWLyQEWQKF0CGxdlcuF2Um16w07ekrdfpuRVj
	Aj2jnDdOY/Ircln/KngZFjhGMsSUU/biDQiou70eXxj4XTug2xEiQgxiBg5IPnwIp2OfLGjcOVU
	szPihS14ITqaapzSW0JULgoPE0d57cTVqHUQMguwaJHm/hN50BGiiLBzneG3UHYqdYySeJF0vJ5
	Dn7cdNw=
X-Received: by 2002:a05:6830:3494:b0:81e:b506:592d with SMTP id 46e09a7af769-83097e59453mr17879526a34.27.1792107705547;
        Thu, 15 Oct 2026 16:41:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a4a01f87sm423931a34.4.2026.10.15.16.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:41:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 04/15] selftests/bpf: Clone a program that calls a module kfunc
Date: Fri, 16 Oct 2026 01:41:10 +0200
Message-ID: <20261015234125.3152346-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234125.3152346-1-memxor@gmail.com>
References: <20261015234125.3152346-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; h=from:subject; bh=ut2kzaiRvkH38BjwAeA1ltAiR0RHURyaSXCiA2GMOr8=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeti3CvNoweVS/LF1aVPey74de7A5rbeI9ucajcYcbGvnHpk T0tPRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACaSfJPhn9F3pnbdv95HX+06ZHv3wG LHrYETp2RIGvzYs8Yo5iLXlccM/5MlP8i9vCrI7ryQj8Wsvn+h5KJN0X/dnx3dOveTnsqhBm4A
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

