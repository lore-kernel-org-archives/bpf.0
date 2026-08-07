Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069F37B40A
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122956; cv=none; b=bK73zmm50ooaaV6HNS49UQHycxEAAUYtA3svoq1Qahptd0dMZrjsgp497kyCQSValykpny6eQnZewqFVUjC6OvlGQorPtiESByMO+teMPJB2GmXUPdG2NebRuBP2GjFLHO4EL+RyZeDLGWvoamOZNAM5SPZgdESOCc3dQDz5Cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122956; c=relaxed/simple;
	bh=E9kvkrJDs0vUUYphvZhgFVMqXCcr8fID40Y0sH/hkoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOzhbYD31RiQm7Imyltd/dcx3Zg2SB7JLDP85P9bFuBGsVlnX4Rjlg6e86rNsA0t7CLBYkIeSO0jXQQrRGehi5EoJPWh3Bx3+6BwkWoUCtW8V7F3MMSjGTEY8zQeGeDBNhIycHsv3GanrhOY8AesxiILAxjpA6A4VLjxkT2fk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJK+EfCF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJK+EfCF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so12633965e9.3
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 10:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122951; x=1786727751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=LJK+EfCFj9RvVsSwthU8f3uW3i4FYAoIggEO9n5PIIDekQvsFSXdadlVuPPuuo1Nx9
         sx+bWSqzVirUgi+XHhLqwd1vrZaj4+vsJBWPcEy91cLlBFOQjmH3nzJm1YvURlrWWybv
         sMnF7xTI+nNXTXcXfRq/c9isa1U80CEdN8zcLYSLY/ljB+QFr96II+6tq6mLpgODyX9E
         o8QBqSbpHZaNEpf5TMmxxPrKz7rj7kmHSLYypEUQZ1500I/8IE9IMUwwBO6vbzVr4hjl
         mFCC8XxYxuVDNgVCp35Hn8IHbWI1u8blEgCA0w45rB8+6hq5A734bBRIjo8GOQN1Ji2A
         K1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122951; x=1786727751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=L2YM/to1+vpINEqaG6CjuQuntyHahdqynG76l/QtRU8AfdCDrTD6LWxRov4ibTpywU
         0IwRZYQx6fsm9ofI1BpQefISn3xrrtD6n79asRgxppqmsqIEjf/lwDD4TLb++Fl2kAvU
         SHxk+yr8oe5W69WXAmiAdWALAOAHYuKCcYPt4BdYx+hLe3+bxUTtfRDPP1jbtoyOZaqX
         9TosejDIeMGDgp8WT2k+lZB477X8108tDpsrstWtYqEcCNj75tJ5UG9fguc3wxZJZYoo
         8dWhVhmkIBPUMO+zFaTnKumZ5lvbtdLyqriWwkbhAQQ+BtKaExVf1bUxFWgoLNLO7LZL
         iuaQ==
X-Gm-Message-State: AOJu0Yxy2DjO7X2uF/q53Mw/SJBD5iqNi07DsSbz2Krc58GtcuH4ACHV
	DksE0PjzNZVbmTwQoB4kSu8L16xa26LQg+5tW1pXKPrscAZr8YejMtfdxd/deMFf08b1iw==
X-Gm-Gg: AR+sD11ifycTao1E2dbwgoi9NIhnKKZMvPi/kGptGOEMHBy4jfAtTuexw7O4MQb7YBC
	hc+mC29gZAtAAIdHODabUrtEKnZp/8lv3/YAvMCa1PWG06otLvRhWRe9hIyja+aebQu7o7nblJK
	wvqAijTXsizAINda7FRqECfE3Kg8sRa/EYO7p4i0MNbMPWtXzHWLUYf/jxCQ7cmbyLCuumuhsO/
	EPabIUv6cFo92nIL9Z1c59GQlqj77NNC3UaIOTonuoO6CLyB3Si5lJ7Ouvrz3LZww7uS4IU7sqD
	6J6LMQH7Uy6fb3aGVc5H8YANrnWdmE130nZBn5480bUvEM8Ae+atPzVfqoLOMCuSzaPz5/D46PH
	4J1rB7EXIIxO77eH66OzLsDe7vw2i+rLA6bShx+uGwVuIXVG3E1YyTUdgPU35YOzopy/XfMMG1G
	xNe4egprqpfRZs+sFsgv5aB6XuLxnGraiNLFDl5al20t5nGkooaD7IMGGfo2qbwbZhuDjWBmS3k
	Mal2QJCcpzYw+xTxCW0WgSH1uWtFBLsHfuw8d+FSnA1Aw==
X-Received: by 2002:a05:600c:22ca:b0:498:ee7:e40a with SMTP id 5b1f17b1804b1-4994e7d2c19mr267195035e9.16.1786122951196;
        Fri, 07 Aug 2026 10:15:51 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995d85b96csm27737425e9.2.2026.08.07.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:15:50 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Fri,  7 Aug 2026 17:15:31 +0000
Message-Id: <20260807171532.125149-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260807171532.125149-1-mahe.tardy@gmail.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf_ksock_send() kfunc eventually calls security_socket_sendmsg(),
thus creating a possible recursion if a program calling the kfunc is
attached on that specific hook. A filter is added on the kfunc
registration to prevent that at load time from the verifier. This test
exercises that the verifier will reject such program on that attach
point.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  |  6 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 36 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index 30e89d34d388..fb1a332eb3da 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -6,6 +6,7 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "ksock_lsm.skel.h"
+#include "ksock_lsm_verifier.skel.h"

 #define NS_TEST "ksock_lsm_ns"
 #define RECV_PORT 7777
@@ -125,3 +126,8 @@ void test_ksock_lsm(void)
 		SYS_NOFAIL("ip netns del %s >/dev/null 2>&1", NS_TEST);
 	ksock_lsm__destroy(skel);
 }
+
+void test_ksock_lsm_verifier(void)
+{
+	RUN_TESTS(ksock_lsm_verifier);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
new file mode 100644
index 000000000000..5b969e03b6d6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+char send_data[11] = "dummy data";
+
+SEC("lsm.s/socket_sendmsg")
+__description("bpf_ksock_send is rejected from socket_sendmsg LSM hook")
+__failure __msg("calling kernel function bpf_ksock_send is not allowed")
+int BPF_PROG(ksock_socket_sendmsg, struct socket *sock, struct msghdr *msg,
+	     int size, int ret)
+{
+	struct __ksock_ctx_value *v;
+	struct bpf_ksock *ks;
+
+	v = ksock_ctx_value_lookup();
+	if (!v)
+		return ret;
+
+	ks = bpf_kptr_xchg(&v->ctx, NULL);
+	if (!ks)
+		return ret;
+
+	bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+
+	return ret;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.34.1

