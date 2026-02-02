Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694D3164D6
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 21:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068904; cv=none; b=YjaEPEuT3WpPHcFyMOXJkPhR42VAxM1H+WU8QAZWNinHPv+7qjdT1ytBHT7xeF7bGJ3JCqcoSo0BMV47w2mbixl0FRWCz5KByBq5PLJe31bVZwPwgrWHodQIikeh8dU/EKUB8Ayi1mVYH+mP/bvG0FwwpLEbpanYT0SvwKtSN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068904; c=relaxed/simple;
	bh=sRBNZON7oW9WvFwOdR9auvkrhzjheeJQcj/mDu/ihqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQaFkWgwli9EqjJeGKQDHYVs5MONUMVeecNriENp6Na/6H8XMT+kqPQ/Sp2SvYEo8y6rQxOzflv7lhfDTlwZQntld5cXbCmHy/AnqFhzBWD1LvTCyCNMuHvQs0UzmAF6fRVHZkKCacD8ienU/chuX+/R6o8QtcK57dZ10rHZMbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeppS5uA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeppS5uA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0c20ee83dso45446355ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 13:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068902; x=1770673702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=YeppS5uAw3jhHpDKJknWloGd/eXhdD2AtVLcVCKVV91MOfPrYQNtHFNJi41CFhb5Sp
         STiiWqbUWTVVs1vz5EdA5V6OBrHhqv0IunHjByQiA0jO77HdPU4RVd8jzcSX1ejUjIOP
         2alfJ55sTgLIv6rumGwSG/4Et1BVRooWM/ZIU0TRrax003DsI+oXY5RXxlTY0uHBBzD9
         aHz+WgPr6cXPgTPLm3EGmiPfHCUn8gA/HyRyIaGhS4ry/fsC9pS2h3+0foUQjbLqscnN
         0aBOBsesJgWFoJ0DvYMzQMH1PDF4haE6E3HJk4MiwWqAK9gcelwx/3POl9tWiviRNSQa
         znpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068902; x=1770673702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=ZW05/j++WoMzRvNhKSsASECvIJVVmXfbvRQKRrnCMm4T3pwK4tbnyMBqjjOoEwIEjn
         cYBw/kxYGV5LGQ3jZxtPbQ2pcsBQiaWHlv1paOfPMjxDC+sxOwyUNAAX8AHXIKEB1S3/
         USkcOerRKsZOb74Ew4rdD4qCAdXEo05QtF6mgSp8V05Vd95ORCPJopaMRi3WJztP8wiH
         dUGwkozPUwMQcivNNecLHMCdfiIZRzaHIBq2w0XPiSXKeiYxXl1Fdj8JKu5AuUQXRm8M
         n4XQZUx8viXLIdyvdBUAdRC4p6o1z78T7TAAc8rQsbPue4LtidQU6EJSmc4NRc3CMq3P
         sMBg==
X-Gm-Message-State: AOJu0YzlLQE9yCLtvTphb9jHIqgYP8KYx0fE+35O5pJ/BCYraLkZ5Kog
	PGmY34pOQwRR0ElOyO2cbHsJqhBBvo9cXugGb3bqMv5qtITdFwrzIwN/Bm58RA==
X-Gm-Gg: AZuq6aLbu+hIXJec+MrFvy6W2LR8Dl9HALMViB5vBd0jSlO49L/IMir6jJyYTVm2Ksw
	KPlQRZ1ypxUkGOs/M8+ma2o0MscuDRDA5Wqv6wiFJlU8AjB01rkPyTacHHHnh3u6jfKOb/HZcOW
	4bux5AFViGg3kX3LwoLRMiFn+D8aniEnF1LzLXP4b/6mtTRn/h9bD+hXv/Bonhyiaxl05X3+PTI
	oJiuGt5NanVV93JnKM5QaZkmr651WGxwsJwyVsZV02aog0KEhoXYARWu6auo14cjXVRKiI3c0Ha
	iW0KZA59xJxic0GDaOBaX/fZT5krCqcHvvA+aOtvyTOsxs9z4rzyn8EK8DbXPDg5Grja5S9S/po
	H4uJsd1iL6UrtahoFCOkdpR8r2BJ0doZtIphO9mBGhblbGJqHsKW7NsHxdZW+B2OoxsxaQSzQB8
	St4dhf09z0XFf0
X-Received: by 2002:a17:903:8c6:b0:2a7:a6b1:4f8d with SMTP id d9443c01a7336-2a8d9931d2emr146281985ad.40.1770068901718;
        Mon, 02 Feb 2026 13:48:21 -0800 (PST)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8b47f4717sm147463335ad.18.2026.02.02.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:21 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 4/4] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Mon,  2 Feb 2026 13:48:17 -0800
Message-ID: <20260202214817.2853236-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260202214817.2853236-1-ameryhung@gmail.com>
References: <20260202214817.2853236-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent object of a cloned dynptr is skb not the original dynptr.
Invalidate the original dynptr should not prevent the program from
using the slice derived from the cloned dynptr.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 14 ++++
 .../bpf/progs/bpf_qdisc_dynptr_clone.c        | 69 +++++++++++++++++++
 2 files changed, 83 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index ec5b346138c5..ba14738c509b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -11,6 +11,7 @@
 #include "bpf_qdisc_fail__invalid_dynptr.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
 #include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -186,6 +187,17 @@ static void test_invalid_dynptr_cross_frame(void)
 		bpf_qdisc_fail__invalid_dynptr_cross_frame__destroy(skel);
 }
 
+static void test_dynptr_clone(void)
+{
+	struct bpf_qdisc_dynptr_clone *skel;
+
+	skel = bpf_qdisc_dynptr_clone__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "bpf_qdisc_dynptr_clone__open_and_load"))
+		return;
+
+	bpf_qdisc_dynptr_clone__destroy(skel);
+}
+
 static int get_default_qdisc(char *qdisc_name)
 {
 	FILE *f;
@@ -259,6 +271,8 @@ void test_ns_bpf_qdisc(void)
 		test_invalid_dynptr_slice();
 	if (test__start_subtest("invalid_dynptr_cross_frame"))
 		test_invalid_dynptr_cross_frame();
+	if (test__start_subtest("dynptr_clone"))
+		test_dynptr_clone();
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c
new file mode 100644
index 000000000000..f23581e19da1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_clone.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr, ptr_clone;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_dynptr_clone(&ptr, &ptr_clone);
+
+	hdr = bpf_dynptr_slice(&ptr_clone, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	*(int *)&ptr = 0;
+
+	proto = hdr->h_proto;
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	return NET_XMIT_DROP;
+}
+
+SEC("struct_ops")
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)bpf_qdisc_test_enqueue,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
+
-- 
2.47.3

