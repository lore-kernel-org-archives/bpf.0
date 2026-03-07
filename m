Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F03803C0
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865892; cv=none; b=CtWJswNAtuiErYlzCGDh9aasNtDjaVczQYqHS9zWgKCb9T8AR7DZI9xCr6Nh15znPh2jppYHeTg7m/Omb5liBU8t1Qt/pLXCSEHIfcRM3A7bT8zBno4OMf/u1MswCd5ywn+UwrkEFB29h5VUNG2Q4lYoHgee8k4tkeIzJzZl0sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865892; c=relaxed/simple;
	bh=zuuLkMVe7SZA3iVK1lFQ85Qdn04qV/iB4YX77NjzDew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnP07Rzwmrhyr1IdfxRudOsDXoRt4miNfHXAlp9lHB4txtd92R0QHX9L3zyBaiqKPs2BpmcRWfkkskuG4a3Sbxnrd+4EZ3DFVZdmSctieS2leVAshqmLh/jPJHSvArF+nOThVAgwF6hiO5CRW8CEdu2h9PnqWVBJnAbh5UmZxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfKPoTDc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfKPoTDc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae46b9c70dso27114085ad.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865891; x=1773470691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrFe5Hs5AFhr9NmcFMmLTsMPxRNuGf96D5IxwXuuxe8=;
        b=FfKPoTDcJhcs8dC7z0M0kdKGF3K2MGA9wyeB8dNpcZlEu3YnzuUhDcHFUEQrrZLwqV
         asCMm4rgNEGMzkKnlwVKUhO58q66BFbox1y6rXYQbyQRNtYwDNCSSca5wowO03Am6fHA
         XMLn6bv6Xg6ZHmz582HVTAi+cXwNWAKVgVGaYl5m/8hu9Z2EqoJP8ZwCoiUS3Jg0kgN5
         YxrO3TJnAGn6L092oqANZ1JGSZwqlt6sEwfsLxJxHLTdOdXh7/ByJ1HtvL97vZNySX4E
         lJG72U3LKLcjlNNz0naq2VZJPBm0Cocx+d4N4z5Rd6YG24HjgCx16De/dfdYApJAoFq9
         I7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865891; x=1773470691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UrFe5Hs5AFhr9NmcFMmLTsMPxRNuGf96D5IxwXuuxe8=;
        b=IV48ZgCP6hsiyXNVpj6AmVVbTldla5TuXG5d8y+3Sauqb8CZhBS5BWC2TCtIYAoF7E
         QthYhMEkcf8Lzp/ZzuPxMB8bgK77J/zoNVbNBVkRJBqYr00ek8LX/tEE/0p4FNwZ+qM2
         ZvnluwciIWQXHWzwofjm7N8dUjKqXFUwv3LSziOzf711sPVXr80JmNglc4fOccbRZqLy
         4nmS8OauCrxLk36reHB6nx5UGVr4DK0qMRgZ5ZCFPTbxCkoabW+G1OW2LE50LaLzOWYJ
         d/Q6/AtiM0ACV6ZITaUikvogDil6Fexp+oQ6XaiDGX/BevJbM8cZLSAUkX0HRNtvzNYh
         XdTQ==
X-Gm-Message-State: AOJu0Yx0JIaGbhwrHb194YLSnZ4LGkv84o8QIDor9wJUjrXcOM9X7ODV
	ajGccw2eGzVH9AwvZGHrv+dn9d6OzlPyfLd7p0X5TZkzCm0RvUBJgiNB3bHjJA==
X-Gm-Gg: ATEYQzzJDAgvVWsx1LFUfQ9xABYAPhm8D6cKOoEKz22USbf9QQ9ugaZzDabolKzkkv9
	rZRUGfMEx4eJj3HJhW6SNDJTQVa2FT6dIHbHXMMFD1tGgtzMqBarYy65HZ1dOX1jPh/9OavqCzx
	t+8z1kUe0qJuOPW6MDi8fHmc8Y9vZztmFCPMTvqZ6JaNYJtaOf79U5C0OJqxyYZyZH531rkShy8
	QN37dUXritsfp90eTHhKyfeHTG8iE0HV6xmN2t4CiurYLAm6fYx+gnWh9sOWFiCLzBizT1zk6vL
	rP92mAaOq6caw5gdRVVIXARq4WUu/tvwiQUnIY55hQ7KW/xZkgskQZOOz5/QUvDAYTp5e8SODkC
	Qph39QdYrPfk/9WUF1O1SIROijANhTGaALlcJ1TDfHhGsT658772axL6EMsvJfnvy7H0ItrE1j7
	r0p9PNUnFQ+w==
X-Received: by 2002:a17:903:2a83:b0:2ae:4af7:d1d4 with SMTP id d9443c01a7336-2ae75c86497mr94936815ad.29.1772865890798;
        Fri, 06 Mar 2026 22:44:50 -0800 (PST)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9ad26sm52114455ad.28.2026.03.06.22.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:50 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 09/11] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Fri,  6 Mar 2026 22:44:37 -0800
Message-ID: <20260307064439.3247440-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
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
index 000000000000..565dea13bde8
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
+static __noinline int free_skb(struct sk_buff *skb)
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

