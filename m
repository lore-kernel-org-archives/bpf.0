Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B974AEE2
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573680; cv=none; b=IRuEPxZIPlsPAyStdGOALFZcGKOEje4twyvdCTBZWutVYcfgBZGNpdh+17PIm2l2tHnxcCarrfKCqqpk0kXy3fxNXm6BkBnrdAGFV9t32pI5dPV6np592V3I93J785YuAQRxsDEVi24OZr/NlnJVCWUzKvwLVMBCP0AhUQoFQjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573680; c=relaxed/simple;
	bh=AwxLupIt2BmepkAUp2LdB4nomF+wbPjJ8xcKlQf9WD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5w/t7PaXWGo4Fq76FhUzk/4piXeeggYcqU0V68MmIGgxXrnAApJyDbMo3XB99i0EUpvchmpNbpONA5XrGYNapFWFwfJhPOfGDWaGw/H4Df1PeKg1mUwxGuotJ1X75j8ElWoK+V7D1567UykOIUmFigRREthy4rt5WuT6BjtH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFK0x8EK; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFK0x8EK"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76cce85bd9so1885521a12.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573678; x=1776178478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXzZHHfnZlsWhHKejBKYXg/anr1Lvjvzk+lC/QUfMJU=;
        b=MFK0x8EKQ+ypy7QVYKP2tKyJagzo/BoHmzXqw7GyGuU8EEg8BffSdYQcAJ8HloGrqz
         0JapUZeD3q5/vCN8Cq57ck6Ju9JedrDU617ZzW3XH43Zi5vFoEaqH5TjqkBspX0NAkxp
         K/9XndzogymTFi/YluPuHdnG/aKVs4nZCqojzA1noxoAlZ6Owk7w84Pd3YOMRkoWginy
         wf0vPOD7W+2sAHSlv6nPW46JNiZ9yqHVYmJcsILfP4K6t/M35cYuCkF01+VWG1cyiYaG
         Bvd8Xlgc2HC9iiNfvQxFayP6KWVFtd9nTT1IcDu9iAmmFN1hSus43FG5KMYcCkA+DUNW
         taQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573678; x=1776178478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXzZHHfnZlsWhHKejBKYXg/anr1Lvjvzk+lC/QUfMJU=;
        b=bbt9ab/+FZBw6sTZPliW8MR7sdPOESmP9yAiuA+NMHKeTtP9vXd0zInFg36ZP5nByv
         AM9faIYbssv1zOwlbioTUbq3/vbqgKend19fkc2Yl53BPc29fdhjeSEgi9yyQj/s/xZv
         hGqHQBa4BkJzlJh2Z3wxIjFPzWC0h1FPJ9ZOggZa/OYHQWb9d+4quJGhb0COw9/sDnCH
         GuMqzAB3eUUgx5buhnrMdp7uKG6ZUD5fSsZfsLUCR6ba3T3rsxgPWEemngjvtXl7ZPiD
         jB3jdye+pkyu2fmCssmuUruow37bRoP5xGxHYHA4wpJTMjFTF1SseUNj6PAW3m968FJJ
         Qtpw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIrksSSEDcRjZ69w2nygOhbRoDvo76A9RbFsCCy3Ue+mAOj068M96KIU1xoMLFewt/sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKZH9gJ3iX9V+fecWwOrL/s8KMKDFXVCY95cdu2pIHzmff/f2G
	7SVvnIxTubbwE5e8RTlFFAT7kOBsEX7Q6m1VV7BOf15/VIZQ1Pr7nJ0x
X-Gm-Gg: AeBDievn/lSEX6NutXPHDYDsP5XoLCzMpTjSVsi3DwZilQTKWLUPLOcBrxZtVBRT/Sh
	qadvj09JGAFk+hIDciXMrlahGafDHd1DP3bVpcDfhrYfkNziB0Z0OSuxDzJMq2oO8YIJTMosaHk
	xolLHS/HB6LjEDT9QBrm+7ZxG/Y/U84oOGC+qHMH2CylfYQpRa/iPnQr/HeyqKPJKks8x7t6tqa
	A2VpG2htOEoNIpHXFAq7lgpYpE5ijr0rnPL1puv5PvE0xHJg7wh3NFn5VPFkMiX1RpRbMyU/O2S
	pX5KeDTzu16euSBQ1+FTaLDquAMa8Of6yQaqXt7O8OiY7jTDFl7W73VTIKUS4zyCpLUJxCiL3ep
	fAVieOsWwNawnhWk+5Bxe77G+S64lPSO6eQKY06LigA59RcN9thlqVNeSI2RhzL/K/utya8ggFh
	/kjuXz3ujD6n3Kkb+E94zQfhXfuv1MjobUo5E=
X-Received: by 2002:a05:6a21:3387:b0:39f:2b9e:e486 with SMTP id adf61e73a8af0-39f2f172c0dmr16465423637.58.1775573678023;
        Tue, 07 Apr 2026 07:54:38 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6476a81sm15755650a12.7.2026.04.07.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:54:37 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: add test for nullable PTR_TO_BUF access
Date: Tue,  7 Apr 2026 22:54:21 +0800
Message-ID: <20260407145421.4315-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iter_buf_null_fail with two tests and a test runner:
  - iter_buf_null_deref: verifier must reject direct dereference of
    ctx->key (PTR_TO_BUF | PTR_MAYBE_NULL) without a null check
  - iter_buf_null_check_ok: verifier must accept dereference after
    an explicit null check

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 .../bpf/prog_tests/iter_buf_null_fail.c       |  9 +++++
 .../selftests/bpf/progs/iter_buf_null_fail.c  | 39 +++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
 create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c b/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
new file mode 100644
index 000000000000..ea97787b870d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/iter_buf_null_fail.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "iter_buf_null_fail.skel.h"
+
+void test_iter_buf_null_fail(void)
+{
+	RUN_TESTS(iter_buf_null_fail);
+}
diff --git a/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
new file mode 100644
index 000000000000..3daad40515e6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Qi Tang */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* Verify that the verifier rejects direct access to nullable PTR_TO_BUF. */
+SEC("iter/bpf_map_elem")
+__failure __msg("invalid mem access")
+int iter_buf_null_deref(struct bpf_iter__bpf_map_elem *ctx)
+{
+	/*
+	 * ctx->key is PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY.
+	 * Direct access without null check must be rejected.
+	 */
+	volatile __u32 v = *(__u32 *)ctx->key;
+
+	(void)v;
+	return 0;
+}
+
+/* Verify that access after a null check is still accepted. */
+SEC("iter/bpf_map_elem")
+__success
+int iter_buf_null_check_ok(struct bpf_iter__bpf_map_elem *ctx)
+{
+	__u32 *key = ctx->key;
+
+	if (!key)
+		return 0;
+
+	volatile __u32 v = *key;
+
+	(void)v;
+	return 0;
+}
-- 
2.43.0

