Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8662E2472A2
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187529; cv=none; b=eHmZZsPMJZJwLt0EcyhkL+pC1885RE7MyvTge04knwRDKux1SqNonNhRyqa9Yw5/snokq4ajQbESxYxZ+DSKy+VeLhQofve+0yDQ1dKLzb38o/j0ayKjGpFnmQPijkIk0tqZSW8zvI5VCstFKJN2RWWIy96fzWEcE1zecD9s3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187529; c=relaxed/simple;
	bh=PFSBaHIkiNBlJm4NYMvzoYFScI8vDaS2AkdfHYZS6ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRUD2T6o6md5gcZowKvybBFtrR93qbizs+lxheyRUb6W2bqeoFpQWNUrur/8P1dIv9QjrtO76oavrNF5eZNVG2k+zaF7mCpBh2TpORtrOXtAgT1vQo1iCr8LfSiwo6kQrNjZG9rekX6fRMKslh8w/WpIKL58Lz+zwjbw8+SNzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5267siS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5267siS"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso887932a91.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775187528; x=1775792328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEgmFsj8gF0XD9kG+HS2VUBIH+kApaIshx+CSYEye9w=;
        b=h5267siSOpxrWHWLPs9GoIxx0cJS3J66BfETWTAL2rvd6azBJ2XMpjlD+a1i4JLbYR
         otrS4oUZsGN1u8UENxOIR0PYtAQJjdXg47O80s9MvOQAk5o0Tc6J5s5g/u2mXjpBUde6
         tLgwDKuqKcKMOTF4LgCH8GgJqKevCDyCE2sZybfhA8q43DXG6VMEez7GkMzR5YjQlZk4
         DHo62xhowweM5e1y22EojbKQ1/7+PKI1yPCFLbo3Ex0hMu2qklI7hzKuF652ORxHB/6C
         Lmto11esE+149KQzvUNJM2Ojk8z5ooQDcokhg71oVkh3mhpq6a3oZcLeM8oUOBF+awFc
         rEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775187528; x=1775792328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oEgmFsj8gF0XD9kG+HS2VUBIH+kApaIshx+CSYEye9w=;
        b=gH34CUuX1NMiFhOYA4t7adVHJJCKaIqsasstO4Li4aj5iTGvPcFrfocTzOP3F2aMsl
         eelIo+ompdAjwTZwcI1jyvWhaKTRoJz6Y/WUUCvtRZ+9PZxUVriNQnbGqsaPlcCaGJJW
         JheetuaQD+7zl2S5SUvL9ec7DWwC1kCx2Gahv0ItkfLyO5JHrzbov2jnr17T9Ykm/0s7
         Ea9IDoDjZhhwUhmmDAixrIZDy3nq08KcVdMCMxI+le1HDqeZzGTrMcfnPaEKk2mC305D
         HbMtYv1UmkqbeJABZk0jjZ22ywAQ6aso6pw05avSwU0Va+pvx4i9YmIKQMgZfRZ49AkU
         lsdw==
X-Forwarded-Encrypted: i=1; AJvYcCVU4q8f9ZOsVLbc+f5bbR780FtQyUeQLV3aHuH0z9SZAPdlLeQAv+RmHQOr9lzleIr0aUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2FWOxlXawcEMwvP3ylRCJbc66qmHVZjqd4xrkMQ269gQXnYtQ
	CrLwI5ugwGSMGUnIxYJSnflVTkzSljQdt5AiwxsTjc29mcwKjqyEEMvK
X-Gm-Gg: AeBDiev99Golk11T/Y86dAmD4AjpFnqxPHixgKW4ELvZubbKjaubb6Hs8FMo1pd3R9C
	tePKXDirzzF20B0OuZb5v3wnRD+QjC/dG/19OLCFk4MolA1VTEDjNUqRSRXQGkTOsffKAI4QxgJ
	Rz+MXxatyrJln7dpvj8+pKR+anicfRawSMXKAWKdnsXdoRcFhVkQ9zEgpUbzvVNp/ZrE+yOArTX
	ZGuArrn72MYl/luQvz5hSoWGseVK06vtpgNn//KzvxO6aVIQnqm+6eOfQq9YwXkhw0lJQLGNRA8
	pcBA54ISy+9NizPdQTP6/BJiNfnZsUIXoDrSX/y8xN5gExcBtB4lZoPi/dWpS82Fcd1AvhAbp+s
	2z0ShUkG+afUvOuq+9ACfshCG0IAPgv2rGos1/VXWDEnyv2ROfOqhps5vmnHvfvXYsTD5g/1FwT
	GmAoKInXazUKOkFB6oqMqjnlqvxtJC1XfPK1A=
X-Received: by 2002:a17:90b:314e:b0:35b:e551:90d2 with SMTP id 98e67ed59e1d1-35de69b28c7mr1125776a91.28.1775187527894;
        Thu, 02 Apr 2026 20:38:47 -0700 (PDT)
Received: from localhost.localdomain ([47.236.127.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659a218sm4172659a12.29.2026.04.02.20.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 20:38:47 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH bpf v4 2/2] selftests/bpf: add test for nullable PTR_TO_BUF access
Date: Fri,  3 Apr 2026 11:38:28 +0800
Message-ID: <20260403033828.18529-3-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403033828.18529-1-tpluszz77@gmail.com>
References: <20260403033828.18529-1-tpluszz77@gmail.com>
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

Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
 .../bpf/prog_tests/iter_buf_null_fail.c       |  9 ++++
 .../selftests/bpf/progs/iter_buf_null_fail.c  | 51 +++++++++++++++++++
 2 files changed, 60 insertions(+)
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

