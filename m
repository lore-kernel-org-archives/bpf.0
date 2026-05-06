Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843AC481A8C
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077658; cv=none; b=RG5QDGUbWosfKUrIMSweSKggBlV5iR03v1Ofhtkbh4H4//C3/DWjYkwRtny1XtuWqmqzTp7tlKvHLFXxZ/7PfIyk9DIzN1m21nzrA8p+emlV2Jyc9MW051dOqc2encNo3O9tv73u2dUDr6/8v+I+hDx1h/ON5QDaANffwRYbWk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077658; c=relaxed/simple;
	bh=jO5QKXIAM6PNo/nvV83Y9iBnQ9iO3saYkOlgfxs7aWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9VwYAuMnE1CQ9t7CvxxQBTv37Ef2ImTO7AQFR40IoHbKxCB8PEWPeZfwYIkk1308Wu4ecW4sa2OFck2RAd63azaYQqBVjs6/NkrRtlLIGgO0WYV52jN7XR1ZiVPomBX16tFa91B1GE2csEBreW4pTfJw6y4FXthsSxDSXr43To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ol0ruqzO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol0ruqzO"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d4f78fc9f6so700024785a.3
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077649; x=1778682449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zraHj7RfOg9+EqIZWjiOOf7hlvWoRxLiS+I5CrsZ1s=;
        b=ol0ruqzO1Ak8z3KdFqoDVG9s/ZYfqSUvAGH8gp7jj9os82EjowWW5d+UDCggix8jES
         5Qm4upKvg5Sl+LgLubE0+h7F/89wSHkseoSvRukT+xk3nf0HoZwS7YPsIs741IUyCguT
         aYjPYbskhVGQNl2jPs8Dh36yFdiEDOh6QeZzqqicSpXRGlj1w9c3bRvi2Thavywjy7fQ
         hLOHwk8L62OhnRpTMczRJfoR9L1s5GNeUeOjd8xW2SirN0vGEfqiL9jqdrnGxnJ3PZqh
         kVKA07oVlNa7GXoCqH6TjGLKV1scs9AlgEwoftfURnPZ4IsT8kGCkPhva9tFGddi+aBq
         uSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077649; x=1778682449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4zraHj7RfOg9+EqIZWjiOOf7hlvWoRxLiS+I5CrsZ1s=;
        b=Lf2yzszUEbCC+wkA7LDwVfXJ8Qf93HUMmcXVAhVxUMd+kt/29hB1wZBUGoaEuznmaK
         arSvk1VmgVbpZ4Q4943sH12PBAKnppa3QTe3OUrvpn2rzwXCenitKKXaisq1dbQ3UY/z
         qdQdkDgiA3UBxtqGlZ9MFXP7eCEViBatmAX8/vLXfR8joX+phRqJ79riWzYwiHWLaipf
         suwLAqONQwnb+mOqHT8Aioj7knRFPE9SszNnUZRl7Xrud59LQabPdYjtwtYSm/Pyzca2
         6qRqvcQmwNEz/jVbhhp3+Vfpl5dDt3BL0o15Dxh/47qpwyKxRwbninMdvwFDNW/pC3Ni
         mlyg==
X-Gm-Message-State: AOJu0YwDgvfDWYRHgDn30i6j47nwY3dojg7EAVS/yLK1j+rYlTEwmESs
	9b3hCWtqPLvw45FeRVNFAX4wpMucl5EP0YHwQTTyEoly2tP8LO14o/wr099Pznphets=
X-Gm-Gg: AeBDievdq8hBaE54ZhJNphm26bnGDq7wTa5AgzhCi6LQoP6rxRtJ9xL0Bq7c3JhzhZb
	extjKqDhbyk7WLEGOIcSg4xMW7mRpXhj+fBZwLju1Z1CrV3sgS8W9AwAGb5mEB7dojCUSh7qEaY
	MtR8YlvqCsRgqKcq3B63W5IvW1Pe1MWQBmhhyByhU1XYbFAyr7BVwyMFuzDbS+ffGn/XHOvj58S
	FXoNtOI52a2C50Lf7bcxzib2fz8Vuh1/9ii0O2ZnD2p/HpCy6rv0uSdiIKU90QlUwZXEG3/idr8
	/dDuNWBow45NW1+rxkHmyYb8d5haVROMi9LaSWc7ybLxyFmmk5WSW+/ugfXmJZkz9b09ldQ7Iog
	X9tC1FmxyFqXu7kfUGGazPmCu3R2LR29gNB0Z7wvc7KTFH0erapDEBF4ptA/8wdUcoEK7MktpuQ
	Utm+yh204+Dy1aUBlBgtnaIqXnNtc=
X-Received: by 2002:a05:6214:44a1:b0:8ac:b70c:8a9b with SMTP id 6a1803df08f44-8bc45942c05mr49044156d6.44.1778077648728;
        Wed, 06 May 2026 07:27:28 -0700 (PDT)
Received: from localhost ([2a03:2880:f800:30::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5397be9ccsm181015696d6.19.2026.05.06.07.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/12] selftests/bpf: Test using dynptr after freeing the underlying object
Date: Wed,  6 May 2026 07:27:06 -0700
Message-ID: <20260506142709.2298255-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  6 ++
 .../progs/bpf_qdisc_fail__invalid_dynptr.c    | 68 +++++++++++++++++
 ...f_qdisc_fail__invalid_dynptr_cross_frame.c | 74 +++++++++++++++++++
 .../bpf_qdisc_fail__invalid_dynptr_slice.c    | 70 ++++++++++++++++++
 4 files changed, 218 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..65277c8fc887 100644
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
 
@@ -223,6 +226,9 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
new file mode 100644
index 000000000000..1d96f7987a3f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+__failure __msg("Expected an initialized dynptr as R1")
+int BPF_PROG(invalid_dynptr, struct sk_buff *skb, struct Qdisc *sch,
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
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)invalid_dynptr,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
new file mode 100644
index 000000000000..2e23b8593af9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_cross_frame.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
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
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_cross_frame, struct sk_buff *skb, struct Qdisc *sch,
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
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)invalid_dynptr_cross_frame,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
new file mode 100644
index 000000000000..731216c4e45a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__invalid_dynptr_slice.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include "bpf_experimental.h"
+#include "bpf_qdisc_common.h"
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+int proto;
+
+SEC("struct_ops")
+__failure __msg("invalid mem access 'scalar'")
+int BPF_PROG(invalid_dynptr_slice, struct sk_buff *skb, struct Qdisc *sch,
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
+__auxiliary
+struct sk_buff *BPF_PROG(bpf_qdisc_test_dequeue, struct Qdisc *sch)
+{
+	return NULL;
+}
+
+SEC("struct_ops")
+__auxiliary
+int BPF_PROG(bpf_qdisc_test_init, struct Qdisc *sch, struct nlattr *opt,
+	     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_reset, struct Qdisc *sch)
+{
+}
+
+SEC("struct_ops")
+__auxiliary
+void BPF_PROG(bpf_qdisc_test_destroy, struct Qdisc *sch)
+{
+}
+
+SEC(".struct_ops")
+struct Qdisc_ops test = {
+	.enqueue   = (void *)invalid_dynptr_slice,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.52.0

