Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E53515CB
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783298; cv=none; b=ZTW60KSjzThxhnv9FHogc+TYYh6KGbOCV/dj3dDN4wFXfoEJZClnFvvU1g4MV1hRNdQm0u6PghqhWdxCCSavxGep8gCFcXZzn8YU3pke5CH67bsPKM0yQf1EItWN593z8g3GDNNQCcKc+y/xI/IvBxaB0voVI8ZxA+3vy7799aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783298; c=relaxed/simple;
	bh=33Og9ZUziEIo5ayapRM8vUaAI76YaNBkn/FjzjQ2qGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR1ggw1rXbp/SOz8StZTb2vaRwdUSQm5pIx6LV2CY8ATat15NJOwSnImeIIOkkedZBWkFrb61GjDDYIqItVK2BJ63K/mjSrp6uOqJ535iiPaY74tSechK1mr00psiTAGcuHu0SxdQm4W+O/j/46nkDfa66v/IIAdKCpLZA0qmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiVH7VUa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiVH7VUa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so2195055ad.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783297; x=1785388097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+an97NpBkJDiDuLW6LUHwPW7vcdKkQPcj8vrVzPQes=;
        b=JiVH7VUasGPzXXBubkYdgst4Sn/eSNlFYKAY/KEhVpjif2BM1y9Ge645gNsM1/NviO
         DpeihnOCSML0/7uXIDoER4M+G8QrwBgZAbK57GZx3U29hX35SAe28l20PZ/qkdtp2hg3
         Taip0TERuISBmCy/ko8oTSXsjT6CMPEibXn/znO/jwer1tHjvpEvfndtHCQbACT/uvQJ
         sY16sj7Wqx2FG3rh2ZVZhPruOI5XWU68ybisGorZKJ542v7UR9LXPveyalyD7p0HILJ3
         GQgHmqhFnNTQNKuuShziDVunEagY5WE+ZFqlGEm3NFGX5gKVzVG1Y7ygtFgQpnPdot6k
         q3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783297; x=1785388097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b+an97NpBkJDiDuLW6LUHwPW7vcdKkQPcj8vrVzPQes=;
        b=rFgII329CK6UyphKLdQvr4OiIYH+zZBoNsPaJidQ8thp2FFFJgAydPITw4MwV/cotY
         d/vuNWYEaHQkHDGVrY946blTEslGf63n6noTq9YD2u1db7vCHv/oWeE8Es928LiH1dAU
         dMiadWvY0/HtxBjXWkGMu77OaKPWJ5pkGW0Gg2J3M1rkMVn2RLT4XfSkkGN3Z4EEw2XI
         bS3ZxuZOO/9G6N16dVYCdGNasfRU7eJLxannltVpaz7c7bRgc+ucUtmMyh1+J+G/jMN0
         nf27GqjdHAv6XEe9VO6BJyulBG4QkDlik7SSMrRJ84GTrcXTihv2pKroCq74CqGrkGXH
         V7Wg==
X-Gm-Message-State: AOJu0Yz1GiSfKkNc/YIhv9IhZS71MXcAQzsKp/TNPkuvqqoVDk+4BNB7
	aPoMNJ8jI8mnCgPoJ8wkotJ1ps77sB3GERAOjJAHkWa2mYWBiiZvFIQWnR/lYA==
X-Gm-Gg: AR+sD11csYb1GYsBO3tyOEGx9KSdZch/98KgJYoio+e8/xhPWNaVSTU3y2mJzLExX6z
	Rk1KIpxFJVW3FS1bqa4lr+bRnvfL3nwEclx3fJGx85j/+7GgTJY/5BCsgDl/9fwfEx+QU4/eOif
	1oR6VhWxeQOK8FMfaA8CTLAjQUXW7SPBHI32wx09wfj/kjplInbvHwD8Dla8Pm0oBBRTiLB8kpe
	KX2ts+vfUFmXExmpY7QEosZzBTw451SqgIhrRyDV4rIZ3GhrNhb3AVLyKCKNnTw4vvOe3iNN5W4
	fOdMyU0YffRxSwYmNiRup9ZXJGIkCVjZ7R2q20oxlV1Z0OFy6GyZ/d8IJ7W+xKfW2/QjDiwGFFs
	S5vbJA9xCqpd1IYCpNPUlFDxVRyErkP4uP+PfxEjSYp2XEWMxdwUwCmoGrlhFPuyRMP0=
X-Received: by 2002:a17:903:1aeb:b0:2ca:660:b1d with SMTP id d9443c01a7336-2cfa6b73ba7mr20813085ad.11.1784783296763;
        Wed, 22 Jul 2026 22:08:16 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e9066sm26428745ad.43.2026.07.22.22.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:16 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 06/18] selftests/bpf: Add tests for helper and kfunc mem+size arguments
Date: Wed, 22 Jul 2026 22:07:54 -0700
Message-ID: <20260723050806.1158442-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure the return of map-of-maps lookup cannot be passed to nullable
memory buffer argument for helper and kfunc.

- mapofmaps_value_as_kfunc_mem_buf: an un-narrowed (possibly-NULL)
  map-of-maps value must not be usable as bpf_dynptr_slice()'s __nullable
  buffer. mark_ptr_not_null_reg() converts such a value to
  CONST_PTR_TO_MAP; without it check_map_access() would let the program
  read the inner map descriptor as raw bytes.

- mapofmaps_value_as_helper_mem_buf: the same map-of-maps value passed to
  a nullable helper mem argument (bpf_csum_diff()) must be rejected too,
  guarding that helper and kfunc arguments are checked the same way.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_mem_size_reg.c         | 60 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index be97f6887f0e..a81faa709dd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -67,6 +67,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_may_goto_1.skel.h"
 #include "verifier_may_goto_2.skel.h"
+#include "verifier_mem_size_reg.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
@@ -221,6 +222,7 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
+void test_verifier_mem_size_reg(void)         { RUN(verifier_mem_size_reg); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_mul(void)                  { RUN(verifier_mul); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
new file mode 100644
index 000000000000..78a9ad22b10d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct inner_map {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} inner_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__array(values, struct inner_map);
+} outer_map SEC(".maps") = {
+	.values = { [0] = &inner_map },
+};
+
+/* An un-narrowed map-of-maps value must be rejected as a __nullable kfunc mem buffer */
+SEC("?tc")
+__failure
+int mapofmaps_value_as_kfunc_mem_buf(struct __sk_buff *skb)
+{
+	struct bpf_dynptr dptr;
+	__u32 key = 0;
+	void *inner;
+	char *p;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_NULL */
+
+	bpf_dynptr_from_skb(skb, 0, &dptr);
+	/* pass the un-narrowed map-of-maps value as the scratch buffer */
+	p = bpf_dynptr_slice(&dptr, 0, inner, 8);
+	if (p)
+		return p[0];
+	return 0;
+}
+
+/* An un-narrowed map-of-maps value must be rejected as a PTR_MAYBE_NULL helper mem buffer */
+SEC("?tc")
+__failure
+int mapofmaps_value_as_helper_mem_buf(struct __sk_buff *skb)
+{
+	__u32 key = 0;
+	void *inner;
+
+	inner = bpf_map_lookup_elem(&outer_map, &key);
+	/* intentionally NOT NULL-checked: reg stays PTR_TO_MAP_VALUE_OR_NULL */
+
+	/* @from is a nullable read-only mem+size arg; outer value_size is 4 */
+	return bpf_csum_diff(inner, 4, NULL, 0, 0) + skb->len;
+}
-- 
2.52.0

