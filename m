Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3107A3148C1
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068902; cv=none; b=Kr4qCthxNe1iL2Y+Kxx2qL/Q/iW749OQZh6x9MXY8s9GgneTYlKhxVQMvB320bvKh8JoqlAHmYlYB11h88RnWUvxhHWhmvTdEcX4XHHBo4lQI/tfBVG+kHsju5aWM3G4xcGSngy5aXf+IGsXqsBs5lZN4sd7HYbVuZHekDKBnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068902; c=relaxed/simple;
	bh=HMRlS0Let/68w9OOEvba1qcpKrMuE75Li8eyGGAGkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aij71L6Z1AEf+LZzxJMf5bPaO7G5bSaz/L1Fy+pGbiNaqPk+VSQoMHv766y7ZbXL/BR9lNUMjuim6ZIUQBS3SnJpUO0L+WLLRaIOlJgplHmIXbiAIkae3OQkF0UofCss5ZYL7MWc6pCnYZ39L/aPJb4se4cnQwsDHAwKQlws9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkT4ZDO8; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkT4ZDO8"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so2000201a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 13:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770068900; x=1770673700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3bkWTyaLnMszPbw31nXzJPzmLRwndvqCUAVLWuq6DQ=;
        b=lkT4ZDO8wJz0VWoNu7qAZyr0mi7GxBfYV3++gKmQ7jcYTTJjDw5NAdKkms/iKqRgsa
         mybFyPXTaJnRR1gzLoVuxybmMQImK6kJwPsaBcc4nl/TAdLA2LkG8KN8rHSnkb5QHrLd
         PGVb4K28ahFchbuGanqozi6BxDzwTgxdyEXv37Shr1+A+6e4NFEtRe7kqd3OdF8cmbqo
         77zcxLYEkBWPtqV0nk75xaDKSgYT2wSkaA1QleUspt1sV4qXimMQ/jKqfT7qVHiMJ8KI
         SMIIjo2PqCkiHArzLF5cx7e0YhC8TpHwZfyVp0O3zx8sEfBWyZTHAHhK2kx1DXvYt1n/
         vXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770068900; x=1770673700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3bkWTyaLnMszPbw31nXzJPzmLRwndvqCUAVLWuq6DQ=;
        b=FVCgg0BNZImqhC1V3O23P6qLTn+UkYSW0bhZFs3zzgHAscdzF6iHEK4y4ceIoD288G
         IBNXFqAIku6rfBr3XrVewjMkvLKFvHGkqY0iACTEkzfVoc5EZmmaH7K4uDcUymxR3wfg
         VyRL4NV1H8gNob12R09Z4+xjnx+/M/IlWlpS2onP7AKwZQFHAKyjUqJPT1i3xaHX9G0c
         jwlj/UnPRhHJtMaJHLbdASO89YbfkJpT55rLqptrqDsrUxIZ4BdPlG78Nj7gbQ6kdT/t
         03Qw7rGAljBGk3wfGi7PmwCoyKBYeHHa+LT0ntt9DiNtUhhshE0HCutvWnJqH9kXi/O8
         2s/A==
X-Gm-Message-State: AOJu0YziqDGqRPrq1400AhcPTs91V7lviBRZTrXv38YFP4yePzSmSRRc
	YvpmMe3bxnX0/oQNZiX4xh4lt1/amuUUrLeK+5P1m3+uAKXk0RheDTp57zc9AQ==
X-Gm-Gg: AZuq6aIBEOUD13pg4rMZ0u1kqmMprAZ4lZdro6EuP9gmDSZBkzqQXb92GO7+N5yahRZ
	RJXvLtF0oF6opVQ+RQ3jAOEc3CJBmqYGthJHSFUofTTieq6CnYFGrlc9SKDIeN/AJV0mH8dGtn8
	9iqq/knP3sFot0YWm/649m1pgSvOaJ0VGG7TnsM5t6jpdOCGfzWmotqiGJNBHCKtA7VEx/alT43
	aRnMPj4SfFqvkfiqOuZw9eQzOt+jd0Da/GJ2PwDFim04Is9lnUOZfJGt4gBnxIgdoKE6JZr3LzK
	WaEMUbci5vN+FwUZMcKxWzjTnYYMgrjBHNKE7TNesdaldlu221Xyv88soC+3oLaJMjIUOpOKhlG
	o6E4m/hgStO6STEEpGjMXgI1fV5E47POVBOC2Kw5T5G2N0WpI5adb8lt97r5Shwlp7V7CWj9CYn
	QoLg==
X-Received: by 2002:a17:903:24e:b0:2a7:aa9e:fb51 with SMTP id d9443c01a7336-2a8d9a5717cmr123752425ad.46.1770068900308;
        Mon, 02 Feb 2026 13:48:20 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eef68sm163859815ad.16.2026.02.02.13.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 13:48:19 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v1 3/4] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Mon,  2 Feb 2026 13:48:16 -0800
Message-ID: <20260202214817.2853236-3-ameryhung@gmail.com>
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

Make sure the verifier invalidates the dynptr and dynptr slice derived
from an skb after the skb is freed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 36 ++++++++++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 62 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 68 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 64 +++++++++++++++++
 4 files changed, 230 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..ec5b346138c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -8,6 +8,9 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 #include "bpf_qdisc_fail__incompl_ops.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -156,6 +159,33 @@ static void test_incompl_ops(void)
 	bpf_qdisc_fail__incompl_ops__destroy(skel);
 }
 
+static void test_invalid_dynptr(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr__destroy(skel);
+}
+
+static void test_invalid_dynptr_slice(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr_slice *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr_slice__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr_slice__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr_slice__destroy(skel);
+}
+
+static void test_invalid_dynptr_cross_frame(void)
+{
+	struct bpf_qdisc_fail__invalid_dynptr_cross_frame *skel;
+
+	skel = bpf_qdisc_fail__invalid_dynptr_cross_frame__open_and_load();
+	if (!ASSERT_ERR_PTR(skel, "bpf_qdisc_fail__invalid_dynptr_cross_frame__open_and_load"))
+		bpf_qdisc_fail__invalid_dynptr_cross_frame__destroy(skel);
+}
+
 static int get_default_qdisc(char *qdisc_name)
 {
 	FILE *f;
@@ -223,6 +253,12 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	if (test__start_subtest("invalid_dynptr"))
+		test_invalid_dynptr();
+	if (test__start_subtest("invalid_dynptr_slice"))
+		test_invalid_dynptr_slice();
+	if (test__start_subtest("invalid_dynptr_cross_frame"))
+		test_invalid_dynptr_cross_frame();
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
new file mode 100644
index 000000000000..2e76470bc261
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
@@ -0,0 +1,62 @@
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
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	proto = hdr->h_proto;
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
new file mode 100644
index 000000000000..936bf4bc79bf
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -0,0 +1,68 @@
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
+static int free_skb(struct sk_buff *skb)
+{
+	bpf_kfree_skb(skb);
+	return 0;
+}
+
+SEC("struct_ops")
+int BPF_PROG(bpf_qdisc_test_enqueue, struct sk_buff *skb, struct Qdisc *sch,
+	     struct bpf_sk_buff_ptr *to_free)
+{
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr)
+		return NET_XMIT_DROP;
+
+	free_skb(skb);
+
+	proto = hdr->h_proto;
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
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
new file mode 100644
index 000000000000..95e8c070a37d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
@@ -0,0 +1,64 @@
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
+	struct bpf_dynptr ptr;
+	struct ethhdr *hdr;
+
+	bpf_dynptr_from_skb((struct __sk_buff *)skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice(&ptr, 0, NULL, sizeof(*hdr));
+	if (!hdr) {
+		bpf_qdisc_skb_drop(skb, to_free);
+		return NET_XMIT_DROP;
+	}
+
+	bpf_qdisc_skb_drop(skb, to_free);
+
+	proto = hdr->h_proto;
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
-- 
2.47.3

