Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BE7391828
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570415; cv=none; b=JAYWdgpGUE3e5WHtG35aMIpKEMbAdg6eDWZrrcgB9nXvGVT20531IodUiJSd3OKKg3Gu3GM1pyIlHp/+UiuK99zXFK0A/ae18qWIZoaCivomLjbZ5Uquss/N/amLYoR4jswMXCaHhShVwgFi/6HqaRXuA1AsTvxBAmE+niqNnVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570415; c=relaxed/simple;
	bh=sJJMi/JpuPlmqYyY6Qe9ql6nvcAqCirTIDETHB7ioCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq8uF/EcahDlXKX3BtqTjRc88lNuYqs1yN2g9Yssk3FZoglHziYWzsaInVLf/2zUdn21xpidBk8sgB2hFp15SRl/auYNlPAa1ykN1n/51qbQH5cvkQoY3WI+CwWdkw8RQbQY5sbUyDF5nf8SBf0vvB62FKOnU5zTbsumPq4e/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cb7OJYJA; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb7OJYJA"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so1876341a91.3
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570414; x=1786175214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mm3gUh70m2uWt0H0pFLLmVkJ9uC9Ik+qIMD7IZlCi/c=;
        b=cb7OJYJAwjxwNrR2ere8AdKehEG+tDgNch7Dn1ACISNvclR64w7V6RfcpDiONnwn6O
         6QoCxp8psResi55hvhvy9ODy6TVwRv+2uwhOva2JRzzSTs92q/83TTYMXBSYCOZgEOri
         vrJdkrqoY20QQyUX+Cc7RfbGeUlzWv5puimpDUmm0P+a8+xieZ6c6fTs/Ez1vuzp7DhV
         8KGp1spIqIiItAzjGw/THHJ372w602t9z3ddThk2WmWqylV87gphn5lUlBssNcOtyO8m
         rq65nNZSXxfEseEaiVcc/isnhRZHSl3ciDiNELCW7HBhqLPUGphaIddxsWY5qkvffyrl
         4LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570414; x=1786175214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mm3gUh70m2uWt0H0pFLLmVkJ9uC9Ik+qIMD7IZlCi/c=;
        b=P+WNB7/9+OvktyU4AmLuMb3OwDQc8tRXQ8hSrkaQwF0VGSjJmJyjcWwBHVRGSdCwas
         lAmmjofNUymxrFLabVthoLXewLEgH2bzvLBI3qG4MjW5hrkClsKAY3ZN5KR0sMJv6pEf
         Gx//4vJ4H5+YQhsouUcjLYZtdGRqcVKEqPVNwX2N0FPVbE33omvBHv2EEf7B2m/1wv1u
         /3QzyoFmPUf35v6ymtr8J1sg8zIYAhmmKDbIwX0nersWd+jGc9WqUxT/E5Bne6kDK2/G
         98EcvGxyiV5iuQX/fXZB7CQhGLF0nLouW8bBuSmICIxZFsew7Zv4/AX4iixHSHBsT3XU
         vytg==
X-Gm-Message-State: AOJu0YySwl1oZlLWUMRqFX8dXL6Rc63tnouG8CC0qsERNjiIFu/p55T3
	0tq7R0b6ZH+rvhoomRBv/Y7p9GCyfkn6CiJbm5/tZPwwCS1Nro6Rh9Zi4bguIA==
X-Gm-Gg: AR+sD11zI4XCeaZumSHMZIIyCU1uaN0VWS/4of/RToRVqHaCTt4gyeCGPgn0amkWPzA
	xSwm00nVrRk7witwezGniOal1cKH5Jq7aDz1Q9r9cNLPAkvEEFKlyA2nBv3ePnJT3yuDlRTUnwY
	DP+LLScH6WTcC5Nttd4E8R5f+IhoNNb2uUfoMxJH/4N53Umd3JWIBck92O74XVZCLJBWKgSEpJ5
	vo3Sv9Icb31BRfafrZp5EiGJVyfbL8PlRSIB2y2kWxE6Wxs0XeJiejU2du5bElZj/EIlW6lYRS1
	94L+net0MMzGsqP2DaMnlZcr4ybvQqpEAskB2u/6TyD7mJyIAtZ8RcUuSifDZ9ZJoMqnGweD4SW
	IR3UTCOLR7Ee4sWFEi9aHsxaT8oV+B+tl9ZlrSIh7fGEFHXF+oqIDw8T3/6z7iVifG9ZrgfCuXg
	KeknV6STOSFAdI6/ZmOL3Ek582HxJ6kK6clE4Xgcm8I9adruQkpQ==
X-Received: by 2002:a17:90b:1e41:b0:387:e0bb:57f8 with SMTP id 98e67ed59e1d1-38fbc5848fdmr2430937a91.41.1785570413763;
        Sat, 01 Aug 2026 00:46:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb29ca477sm1671298a91.8.2026.08.01.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 11/18] selftests/bpf: Test __szk precision with a NULL nullable buffer
Date: Sat,  1 Aug 2026 00:46:26 -0700
Message-ID: <20260801074633.1595644-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a nullable buffer is passed as NULL, check_mem_size_reg() is skipped,
so the __szk memory size must be marked precise through the scalar argument
path instead. Exercise this with bpf_dynptr_slice() and a NULL buffer.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../bpf/progs/verifier_mem_size_reg.c         | 28 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 41cd071d016a..b79bafca68f7 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -68,6 +68,7 @@
 #include "verifier_masking.skel.h"
 #include "verifier_may_goto_1.skel.h"
 #include "verifier_may_goto_2.skel.h"
+#include "verifier_mem_size_reg.skel.h"
 #include "verifier_meta_access.skel.h"
 #include "verifier_movsx.skel.h"
 #include "verifier_mtu.skel.h"
@@ -223,6 +224,7 @@ void test_verifier_map_ret_val(void)          { RUN(verifier_map_ret_val); }
 void test_verifier_masking(void)              { RUN(verifier_masking); }
 void test_verifier_may_goto_1(void)           { RUN(verifier_may_goto_1); }
 void test_verifier_may_goto_2(void)           { RUN(verifier_may_goto_2); }
+void test_verifier_mem_size_reg(void)         { RUN(verifier_mem_size_reg); }
 void test_verifier_meta_access(void)          { RUN(verifier_meta_access); }
 void test_verifier_movsx(void)                 { RUN(verifier_movsx); }
 void test_verifier_mul(void)                  { RUN(verifier_mul); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
new file mode 100644
index 000000000000..7e24706a764e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_mem_size_reg.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "bpf_kfuncs.h"
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * The __szk size of a kfunc memory/size pair must be marked precise even when
+ * the nullable buffer is passed as NULL.
+ */
+SEC("?tc")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r4 stack= before")
+int dynptr_slice_null_buf_size_precise(struct __sk_buff *skb)
+{
+	struct bpf_dynptr dptr;
+	char *p;
+
+	bpf_dynptr_from_skb(skb, 0, &dptr);
+
+	p = bpf_dynptr_slice(&dptr, 0, NULL, 8);
+	if (p)
+		return p[0];
+	return 0;
+}
-- 
2.52.0

