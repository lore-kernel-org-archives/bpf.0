Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1E3B7777
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479480; cv=none; b=bTE8mxrhk0O8ZBNWbSuA1kgfzUQ//MY55n1z0v5TILsTGNu3Pccs4hZfFSn+ExkaloHepo9rA7ZMOG6HT8NuUefSX7DSoHT9ERPswtAlFA0iF9pdUEvFnqJjJXS9OppsW88+zqM2shyt4Lq6dmAkszg2zJS+UBi1r7t8TPNjciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479480; c=relaxed/simple;
	bh=3aBIeFzxjG5hLOVJxWC8DtcQqIoZzqgdSPM0MbUrphM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiPuohbhlraogBZWy+DeZ+OjIKXj0ZiIVD4o/uzRiLr3kxKt+Elu+KAEvCFirjOR5FlphKeDFY4iG6Us5B00XzAxgmEVXnuPoP3kAqnFYyji91gD4FsrmZJmLwQ6MGfCM7cK7TSxertlyNbkb6FyEKmOPyxQSY0zrEqtisk24yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiUenpzF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiUenpzF"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so1637536d6.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 19:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479478; x=1784084278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RGIUqyeZoqmDFWmO4W/wGNuga+EJTtkIgRxdOVhDU04=;
        b=eiUenpzFlT5fcVQlHrZ/RUhG1ygCmdmAxEr1r1yD47x3Bto48VQtIZtbn2t9ZMRHIE
         dIELj9rLiVFXEdOChEYenlTSQbpUNtCNcv10UEv7jewTG31jRuAAe3iy5T8J8GyPpx6K
         UXgBg2Ps/b4ObdlzYr2NYV9dXKrsxqbkp1sIFfgTqgy9VeS8asJSdElQX7yMjFRb4dYL
         c7akt82HuFBaJKrgsM8tkRVvpHHHPL6LD+ySp0Yhr9ChTq0VS8eeuSaiQCyIuDYsjqK1
         y+BRlT4u3xtAf2p6A2LimxBAX1HqtT4cBcA6WmowVVvk0tioc4gaQeX/C4VSLWxAf3Ws
         82og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479478; x=1784084278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RGIUqyeZoqmDFWmO4W/wGNuga+EJTtkIgRxdOVhDU04=;
        b=DZMwITnQ7/6t3KioZa/OePtUA7abRbYXQ9WJ1j/ntPCtzn89dRPXVXnkg1D0onXSfH
         i7oZi7fMqXV/XeYjb2jSWvpY6YM32DqyLmEJL0sGNiMHFCQ3RExRtHqobUkEyLyrt1Kt
         pkhUFheJktC6hDqpbnm9mzTOjhUlCQkx5JSConXBRDadZ5tdyetHNn4wbP7NqfqFVhUZ
         HZNxiv8FVMOb6O635ttX1Bxt9D3TClVetPjjnFJgVMWPUbOn6e3UwOK59+MTMC9sY/4K
         um+/07PTjAVPcQAFw0e7USU+1U6KxgQTZBtB2tYTydu2i/tP8yEJ0wCrGQ2WicQhWfcV
         DJ/g==
X-Gm-Message-State: AOJu0YzpxrrwHVYQl7K4AFY/qSvAp4ENpbDwWhBTEm0FfdyyJw599AdK
	FTFRjSExsyAuD9VcrQZ5NNLkv+xTSkvb3tSKvqgdEzm/Uz7lNhTHSjggL6b1ZQhdiP4=
X-Gm-Gg: AfdE7cmpjd1OAwEOdy+PJRQksOzuItAHM1/dFhM/KgGduztTzCj3m/BSjizc6GC0lNP
	zeQofY9vcMM4q1c/8lZ0HTjbtzJa3TEYrwqPDzdHYfgz0gpAOd69DMGF2Ghr3DXeWoyQ8Suh2Ht
	qMwJRpooKJi1MEimG1NgT/ez32eX7wUlsTmDxv4UEWpM9r8dJdMjDLPef8sNZHePAK/qJbFvfN6
	ESNpc1+gdhwu+zys3fmeVzWOdsdVvlqQ89lwELE8cmqo0WL/GSF15p5oYjGweqvzL4xvjzb3F0N
	d5Ad27uIKkxHggHsBOpkdFXkIyE/mcTQbPNLGN1JSgfjNhhkbB/p7K/UQrCHchCcw+m4oHeI5ov
	sYguqY8arAb24tLSR07B++3cPqbH2IZQODnkEQtvsgU1I5pe1JEeLTLa4WBuprWWn402P8JCJp6
	Zs2tARCVY39RPDlip4rWlyjoG7mRXNl/pyUKTCKNqnhTp2kiPc3gXKkgScyAG17zQPg6/fCW82z
	6BY50KPjSMcfAs=
X-Received: by 2002:a0c:f40f:0:b0:8f1:505c:1d2d with SMTP id 6a1803df08f44-8fea11c8be7mr8129896d6.14.1783479478388;
        Tue, 07 Jul 2026 19:57:58 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de83f8sm175762936d6.33.2026.07.07.19.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:57:58 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Add XDP dispatcher FineIBT regression test
Date: Tue,  7 Jul 2026 22:57:56 -0400
Message-ID: <f6df1bf381517f7ff6927d82de7680e7826adf94.1783479101.git.dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for the x86 BPF dispatcher's indirect-jump fallback
under FineIBT.

This test can crash the kernel on an unfixed FineIBT build and so should
be run in a VM.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 .../bpf/prog_tests/xdp_dispatcher_fineibt.c   | 47 +++++++++++++++++++
 .../bpf/progs/xdp_dispatcher_fineibt.c        | 18 +++++++
 2 files changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
 create mode 100644 tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
new file mode 100644
index 000000000000..2d3fc4034eb9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_dispatcher_fineibt.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 David Windsor */
+
+/*
+ * Regression test for the x86 BPF dispatcher's indirect-jump fallback
+ * under FineIBT.
+ *
+ * WARNING
+ * -------
+ *  This test can crash the kernel, thus should be run in a VM.
+ */
+#include <uapi/linux/if_link.h>
+#include <test_progs.h>
+#include <network_helpers.h>
+#include "xdp_dispatcher_fineibt.skel.h"
+
+#define IFINDEX_LO		1
+
+void test_xdp_dispatcher_fineibt(void)
+{
+	struct xdp_dispatcher_fineibt *skel;
+	int err, attached_fd, unattached_fd;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+	);
+
+	skel = xdp_dispatcher_fineibt__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+
+	attached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_attached);
+	unattached_fd = bpf_program__fd(skel->progs.xdp_dispatcher_unattached);
+
+	err = bpf_xdp_attach(IFINDEX_LO, attached_fd, XDP_FLAGS_SKB_MODE, NULL);
+	if (!ASSERT_OK(err, "attach_prog"))
+		goto out;
+
+	err = bpf_prog_test_run_opts(unattached_fd, &topts);
+	ASSERT_OK(err, "unattached_test_run");
+	ASSERT_EQ(topts.retval, XDP_PASS, "unattached_retval");
+
+	bpf_xdp_detach(IFINDEX_LO, XDP_FLAGS_SKB_MODE, NULL);
+out:
+	xdp_dispatcher_fineibt__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
new file mode 100644
index 000000000000..b49b84f01c8e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/xdp_dispatcher_fineibt.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 David Windsor */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+SEC("xdp")
+int xdp_dispatcher_attached(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+SEC("xdp")
+int xdp_dispatcher_unattached(struct xdp_md *ctx)
+{
+	return XDP_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

