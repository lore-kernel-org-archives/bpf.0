Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A3387569
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865893; cv=none; b=JZWP6ZVTzNNMyVz7Zj0l46KdztInAsqnuE8vCnNnmN+Mps9j8t2X3md44MVKY0NBiklKGTwXpg2Wg/CsjREOgS0cOpy5C9ug7uHmqBwUHbXduh2X8pSEYxrU+twnAEYU5FAMd+6ouy0EmyQN1YmSI+X/mRPvux2YbyCmK9s677Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865893; c=relaxed/simple;
	bh=sRBNZON7oW9WvFwOdR9auvkrhzjheeJQcj/mDu/ihqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxGvMcJIugp9d0teZCg3Te+AzUdAYyJRj30BxD5BMXJkkVlIEc4ssuFwCrn0C4tpr6VlXDGYX3guLIWitC05Gi3Y9iTJbXHyjrh8ntI6iDHBbdfl5rzMJm3Uexb4u4sRflh7wfTRzbyNKOA3eGNrqlINuKBJatyRJ9Om6f76Ago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2BoyeEh; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2BoyeEh"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e2355739dso4098437a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865892; x=1773470692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=b2BoyeEhv30iw/NQeg6eaiMy5WD7tokLTzK5c+EETZfmJmy3hiIki03BdXzjfa/WZ2
         ZkFuU96TomQP3+hqGMEA0C5yNq1Q8EQg9+Bfl2vCmstR8cd7nmdkB9vKEtHcnM3jl0HZ
         eqNUarN/Afv5aHA0JAOhaG/dXVcTL4+zQarGXEyKlhe+SmNl1hqJtFF5VzdnnX4eVsP9
         /+Imu5H2FCP3UANli42QLxejB8+9tT2vtSUAlA3hf8P5OPrHcmPnr5w0wiG1jQdBJTx/
         8r8i0omfYIMoI9FyAYb0p6PEVa2umxuKyewf9Wi9OwrBfbo3nt8a4enjYS6976ytIbbU
         xBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865892; x=1773470692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANJntNTEBOQFcB1rB+a7FIJxQ8XZz4gzzWECmu7M+1M=;
        b=iVF92843dqnjD3n6uooEF4xzyzMUAQHc4OgNOd8Khk6fKNRsfz3uOv/JWGX+51P6XU
         i1mE+3tfvJV3LpCpbq+fbuq+TksaIJ+Nwew3v8Hu1zoqRDqmefbrVrBm86Cb9rpURxjk
         hXaStFYmnt1Gy/uiGgWcnFg7OMNHQE8W43QyTzilHU2wz8wOxA/ghwkD7beCN3MIZFWY
         OcWIRL79+g03Jlnr//uIAqVBQgztH+8fIKSYBJw2KPH4qeJzWILkwlpqjxCyRGV/Ky2p
         MkDrotGzF2urN5URlm9QFsBh0U6K+GvoOHYEmE2z4H/N5u39wY+XOxv87OqYCknFC76+
         Z4RQ==
X-Gm-Message-State: AOJu0YwAUSc/oxzepmfUkHHsXwKi6LyJAiG70Q4x8P7oJNlBEWNps8SA
	9PUkrLMMqm1L7TKcKPm8fVRb52IXMFZ+NfKSzmFPgdkZBQzjKMBiUzYK4GFSqQ==
X-Gm-Gg: ATEYQzxWxrdV0Z/YKu2PtrKHR5Y+mctxJzQGXF3yM7DUsAvhsDeAxPDvmZkvCVQ5QEO
	70nri5hXuZucxXgQ9ZtiP6DTUdITkNZMgW8nkPQ5MKTAHYW488cRXCb6pyDYzrr8W0X3jUWKQ/3
	3E05z2ppj4nWjN7G85lOBNP6WG5OAA2Mmgjz8oS31iTABaIHinHYbyw2fThGjcDRqrGD0hdbERy
	Xex2KYAuy58QFu+Lf703iONsw8ihADlM8xSgfuMbxV546lwwCkVn7l6m0l/udAMvCLHoj2xPoEG
	eBoDO79hzeq2Xkdg6KTm6qiHqW8tVxVX556Ra/OykR8oTJP5vFxfAHj9jTtm2ibKnZyx7fFgLJL
	wvWRlEDYUgOtmHrMY3m+xGy3ba3Fz0f7CpaDsr3jylePflW8TneedXM29FeyVawyv9v9mBTdVT0
	uuyQT8lQKh+e/ZVQ==
X-Received: by 2002:a17:903:320b:b0:2ae:456d:b843 with SMTP id d9443c01a7336-2ae824914demr56158905ad.48.1772865891698;
        Fri, 06 Mar 2026 22:44:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f770ffsm54938275ad.45.2026.03.06.22.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:51 -0800 (PST)
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
Subject: [RFC PATCH bpf-next v2 10/11] selftests/bpf: Test using slice after invalidating dynptr clone
Date: Fri,  6 Mar 2026 22:44:38 -0800
Message-ID: <20260307064439.3247440-11-ameryhung@gmail.com>
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

