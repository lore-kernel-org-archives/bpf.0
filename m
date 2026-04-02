Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B03D396575
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775122189; cv=none; b=tYfLGgW+jf5ystX0lC8rPxMi1y1TUPIr5U0YsO8iNgVC4+JlFkTzVcJMPY2V8++GbUSgBzPLVGIJ52GS0G5OMI5VqGn+WECA0Jpbecv+AMNBh4ge30eokWtxdKGxuwvtwjuctisF+Fq0UcIsb7N8TQWNtZYLYzfm4s3nN+tEb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775122189; c=relaxed/simple;
	bh=Buxvf59qjjVtmKoHCog1mKd4mCukPe+8B7PMgGdeOmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/AEt0NYoUzaKPcowDkNjl+nNLBg0rCoX0UKR05fD0RgmZRwE9Ux2kTCykYmA4kfne+RISb32Hq1MMg5OD3jcz0d1D7gtRpxg6xeSVhL3FVHzIv7hm37DVWR3DmLHGbrSkkiqEOWzfkFUYRMoVqYI40POXQbLK70FuHHR/COQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjpc+AYs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjpc+AYs"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso4099255ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 02:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775122179; x=1775726979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yir+ud2Xs/synbYWPMDRqrWyeeW26baq6LgZHsiUlTg=;
        b=Pjpc+AYse7twr0/1xu95rVch2vfhoeHCw7L7ESXbnFJjleX12d+2F8utOeLWEr+C59
         FHz2yuE3O00iNXAWDXxLPlz4YqG8PKra2iLfM3GXlu0+VwGo6tbb1OzRmPuePaRjoEvZ
         qAvwkZ0XmvIVN61oCI4fYy3anNhWJlYqCb6x8C2i8ry19vAr3HaDWcvXoJcjmPLMc8Ji
         IPr2GW/GIUBybjhX0yZJ+aneduitiyti+2xYtRQi4OeKspve2sZlolVcI75HGfbLEyFK
         2VgN0CaMU2/vJ/UGIPMzGpvmBuHxkxW8Vu7kIZfgEYrnEsGAU9xTyBcr+rc5EZ3jGwEh
         tz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775122179; x=1775726979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yir+ud2Xs/synbYWPMDRqrWyeeW26baq6LgZHsiUlTg=;
        b=R0UzvSr5LfIO2FCkvu/LywqMKIOtjGVqK35B6b4DYcxqXFcTbAn4d1dZQgOd41bDpD
         pU9lYPT1P54JJNdXbUFI5OZhj5pXJWMeLvreFqgjZGX0RaaKbo4Dptq4MAS2I4NrZU5D
         mqs89Xp+UZv7REdG75e4J4ZzJGp2TCP/LZ0u65SonTmVzvJlSvBZbXkDKXtw0la0JqW4
         gzKMm43R+6SM9xQuF3Q96uFoFHhQ17YndcLBU6TS2IUjadJpYBCLAcYsSgO5eF5F7URq
         HOHKzYdLZtFzx3obZ7dfdY2p/jo/QNUruvDQpB79VALcWbbFYZZIeTcarr+BIy/ekMyM
         nzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVksadZlefSI6Dzwh2ZlNkggv8f+ZfAikCTKtPzUbwnC/TKAyNUVioxnSglvlmKnkenTWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cuHrcYT+X3T6M6oU40lbDpa5p4u+G1MUK7Zv/jPixxjmUkQg
	3xKYAezXFRkShAJ8pcGb88c2AmH03DM79wYZK4xCvM71x0ZYhLPPh2Km
X-Gm-Gg: AeBDiet1C39IC4Sw778lXP+mEcnZrIhDXn5SGRUHsBvdcNM85LsMlAfIatv4bnwkAAh
	oXRvwIiWYr+sV44Fu+4gyE+HAABeo/vKO8LdMCDJOX27oRdE7RwxAPL06ZBiO6BETDyBWIAtPDw
	j4hc58eLBO7xJP0AWizPw+q4yI2TuBl9/sDboAbYA+TD+/ZNTshmyfxnlbFABFaWRCsuDvNOPX9
	5Ldc2n8m84kFaDxXFP6wZPAOM24TohLVEa6FXY0qohE3uAznT81nOCHsSeGgCRCPXM/vsZDCgDU
	/dvGiOAGWrmbEGuFDSbWpnAudWLM31izd3B+Ey35b49VSQGZhPLA9HNvdGCGwTOghD0Q2POJxxi
	GbH2XiLNKcovQAUXdUKUyNg5v4140xuZIj1BphCORsoIWp7WB/LlQ8ODY++lBgY+HUxJSqXQZhP
	rycW7zzfr4qDML5qm3wg6Px7oTfCL+nAa7ZBU=
X-Received: by 2002:a17:902:f642:b0:2ae:6192:8d78 with SMTP id d9443c01a7336-2b2758794damr25217525ad.1.1775122179080;
        Thu, 02 Apr 2026 02:29:39 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cada2sm21176705ad.71.2026.04.02.02.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:29:38 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf v3 2/2] selftests/bpf: add test for nullable PTR_TO_BUF access
Date: Thu,  2 Apr 2026 17:29:23 +0800
Message-ID: <20260402092923.38357-3-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402092923.38357-1-tpluszz77@gmail.com>
References: <20260402092923.38357-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iter_buf_null_fail.c with two tests:
  - iter_buf_null_deref: verifier must reject direct dereference of
    ctx->key (PTR_TO_BUF | PTR_MAYBE_NULL) without a null check
  - iter_buf_null_check_ok: verifier must accept dereference after
    an explicit null check

Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 .../selftests/bpf/progs/iter_buf_null_fail.c  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/iter_buf_null_fail.c

diff --git a/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
new file mode 100644
index 000000000000..963a4cfc33f3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/iter_buf_null_fail.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Qi Tang */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} hashmap SEC(".maps");
+
+/*
+ * Verify that the verifier rejects direct access to nullable PTR_TO_BUF
+ * (ctx->key) without a null check.  On the iterator stop callback,
+ * ctx->key is NULL, so unconditional access would be a NULL deref.
+ */
+SEC("iter/bpf_map_elem")
+__failure __msg("invalid mem access")
+int iter_buf_null_deref(struct bpf_iter__bpf_map_elem *ctx)
+{
+	/* ctx->key is PTR_TO_BUF | PTR_MAYBE_NULL | MEM_RDONLY.
+	 * Direct access without null check must be rejected.
+	 */
+	volatile __u32 v = *(__u32 *)ctx->key;
+
+	(void)v;
+	return 0;
+}
+
+/*
+ * Verify that access after a null check is still accepted.
+ */
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

