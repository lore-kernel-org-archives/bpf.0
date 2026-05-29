Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33736167E
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019395; cv=none; b=WCtgHYgHbUd+Zat67TPxlpX6lDnb1X0Exx5WJpPH5rPz5R4QU8mSgzlJ/oBCormf/NDIzt4GsdLUxOGjA/OvwkxZ86c74qyWC2Kp6HfZwyVmMWXh02irIjZ2kUfPV3sEWWydlnTKRMHwbXBgp8EhWAMZYfEDW2dW8TeN/svrfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019395; c=relaxed/simple;
	bh=NYneCGKnQ7LIXs3sXUH6hETaPgBJYuTPlhVQmYHmrDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bG+Q77DiwDw7zEe6+Uu3Ug5E3LnnB9rHFfdtaV+T9fCjHuQ8Id1tJff+AbsjViVr+mYO5zFsK740/k20cA+5mEk+LuKIh/ngZ0SQky2gt9nfqCQlWZg0CKCH3rHY6ttWT3LEvVul8c9U06I/89YN+iAuAwal4DiYr6q+vErFDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0AHkQ3X; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0AHkQ3X"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b88b76318so752030a91.2
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780019391; x=1780624191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwqwlPBf3FCjAT186yXbJ+Yd55pNjiN+lHpC4X7ZKbE=;
        b=G0AHkQ3XAVO7jwvhSxIHSkgpD4NkTrGob/LrEinZSPwKr2iZnR/1/uo5QTUedGK+E6
         LBBfCsebRBh6eeAaC3YYT0PuXAuiYE+34T6sbn8sOVumqRCKG7+QoyIUYSUmw78Z8m8/
         UFlDIfvA7ZomVPSQNPO/5/sCsBAcCDuy4hTGZ4M/a4n3CXHcPyq1hbS/5dE+H9bx4gAf
         BbYC0rgfC1JsDN4xpC3iiL8MBMfNsoU1ETYDhGEqx/IF+ebfPegaRD2RFVnoXkMRZU8B
         JaYiPazeIsglxli5kvgynZeGk8nC5Qi5ptuu7x7uVz/3a49rM0izZsnRyEXIdTEgZptG
         7PUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780019391; x=1780624191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwqwlPBf3FCjAT186yXbJ+Yd55pNjiN+lHpC4X7ZKbE=;
        b=Cl4Eh0aDEUQNpLgApn7Xmi8S2A39sZbbJFJBt++OAUy+i7W0SmdeN689hpn6R3s4CQ
         +TglQqXSe3z5c0KkHwbSB8NNCn34191QpXhOJ9GAoQ/NLNR+iiVek7dw4DTNh5MdFZyO
         LlAdQPsGyzgDcTdBg3w8Pvo8014j6flxq80DMQdSeyUrsF5hk+lJ677k7c0HdRtuAypo
         FGJ1EAhYr4IXRwHqcBUvtPcMGAOYjBBJwR3qYqeZlcsnSW24Ft7Xj7Fdu60SzHUu4hZ9
         lc9utcSJMOF1O8bvBTeu1JzPj2hioepTr7VcW4+IrM/klBUnyZx/YD//lQgSWN/BWkNv
         qSdA==
X-Gm-Message-State: AOJu0YwTni3BWsODCTBEVbLVNfZYgV+modv67Dh49zb8OqyNkfQVW2ui
	Htv+Q49zQbBDlhsS3dTtI4MG+Ds2rPUfD3t9aMjJIkzmiMGPk8vHIEcHezO+Gg==
X-Gm-Gg: Acq92OHnbed8QoJmfwJ9Z2XoXMO5I6xcb4sV7wIL8rL9M3DSkvnkdR2b2SPZroVhGjU
	IaVcCyXIisYRTE4C6IlkhFSjcWSHNmmdXqBMDfIISFANk9eHqZmHQ+Teh9iE7K6bw5TlOie89zy
	27ndMORe+AUNwf++ZSbmVycQzXlJmsTQT9hw39IdXIC1tmOSjnFZBwekz1sfSED8jzEhg0ThurH
	iGSgfxdR4uMGAwLMsAoPo6sOTiA5J4pyDOUfQ8za0gi1N/rNf9z7xG4KYBAB/u0wJFAcV3K+e+B
	HvQjGTLslkkpifCTYxKuPSYNg9VZPuMoK+JdHe0LNZm9anJZd3FSeJ9dOvZhldfOOQBT5tVflhf
	PVYOUF8+Jak6LhS5XeA2V7eNUmh5RAJk5RRijZ22qQzDcaTB1NJ7EHp8RSeJIpNb7bx3Yzqc8Lu
	ndIfm919DeHrh1mZUfjiwNz398
X-Received: by 2002:a17:903:2392:b0:2bf:2015:5b94 with SMTP id d9443c01a7336-2bf20533a7dmr10834045ad.3.1780019391190;
        Thu, 28 May 2026 18:49:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a1ee6esm918775ad.33.2026.05.28.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 18:49:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 11/13] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Thu, 28 May 2026 18:49:34 -0700
Message-ID: <20260529014936.2811085-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529014936.2811085-1-ameryhung@gmail.com>
References: <20260529014936.2811085-1-ameryhung@gmail.com>
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
 .../selftests/bpf/prog_tests/bpf_qdisc.c      |  8 ++
 ..._qdisc_dynptr_use_after_invalidate_clone.c | 74 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 730357cd0c9a..77f1c0550c9b 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -8,6 +8,10 @@
 #include "bpf_qdisc_fifo.skel.h"
 #include "bpf_qdisc_fq.skel.h"
 #include "bpf_qdisc_fail__incompl_ops.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_slice.skel.h"
+#include "bpf_qdisc_fail__invalid_dynptr_cross_frame.skel.h"
+#include "bpf_qdisc_dynptr_use_after_invalidate_clone.skel.h"
 
 #define LO_IFINDEX 1
 
@@ -223,6 +227,10 @@ void test_ns_bpf_qdisc(void)
 		test_qdisc_attach_to_non_root();
 	if (test__start_subtest("incompl_ops"))
 		test_incompl_ops();
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_cross_frame);
+	RUN_TESTS(bpf_qdisc_fail__invalid_dynptr_slice);
+	RUN_TESTS(bpf_qdisc_dynptr_use_after_invalidate_clone);
 }
 
 void serial_test_bpf_qdisc_default(void)
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
new file mode 100644
index 000000000000..ac626cfa2a98
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_dynptr_use_after_invalidate_clone.c
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
+SEC("struct_ops")
+__success
+int BPF_PROG(dynptr_use_after_invalidate_clone, struct sk_buff *skb, struct Qdisc *sch,
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
+	.enqueue   = (void *)dynptr_use_after_invalidate_clone,
+	.dequeue   = (void *)bpf_qdisc_test_dequeue,
+	.init      = (void *)bpf_qdisc_test_init,
+	.reset     = (void *)bpf_qdisc_test_reset,
+	.destroy   = (void *)bpf_qdisc_test_destroy,
+	.id        = "bpf_qdisc_test",
+};
-- 
2.53.0-Meta

