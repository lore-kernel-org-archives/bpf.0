Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C4548C40F
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040569; cv=none; b=GczuESgukuRxEAHU54jqwTgfmLaWlDn1C9Q5f5riyoyx9mfojf6rDSJerwUgE6wVa2jzz5F/dGLBictRXwGbqvmwM1ILD8DwkobkdrWPjS3oB0NIPA1tug1pJMcTowNIpC5ivm5GO8yOtwp+PijMmlofrM+BrxivNEZ3gXbDhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040569; c=relaxed/simple;
	bh=E9kvkrJDs0vUUYphvZhgFVMqXCcr8fID40Y0sH/hkoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tBhWkZuccOUzN6yjZ230lDrYnM+0sZ0wgiPIsn2LQKzspLu+LstCRLGdcvWY/iNbiYTtBoekSnYRGwCDQ1IQArvbZaZv3dgsZhk7KDGBruIEiYp0J0cZOhmhj/RvcvVfiK1SVfyBNNz7K7E7KfaOU56WAnH0+4Q0IXOhK/UF/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCrGsItG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCrGsItG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso9818275e9.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786040566; x=1786645366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=VCrGsItGbwwc1FzJdBf7HLuHJvRU+BjL5hXJ7G/VECAJWnbntfJWWS/svTNo3V9uS2
         wgj+XwePGU/sxcUivirJk3uHK0BC4ZksSH1r1yXD6NsAffBZScVEKEu8GPQDkO8zIp95
         /aA1kXy3ks2pp6eAgTWM4kOMvFtaxmAmplZmVeHNh65tqQRTccfrT6sbl8k6jOTvGE5Z
         Fij9cRtHr9qzxS4lLKXZMV/Vhkv8Zblg7CiybmIEWpqpqPmR6ucnQWklteO50YTFRcXa
         zrDGqAVd52mtD5AG+3drSeO8tOK8bC1ZWK+buZTFToIh0PzTnrP+i5PB7IMzrGQ7bytd
         mo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040566; x=1786645366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b4a5tyJ8YEVwsB7RSmOWXC10B8IXeB7AlAmeqdvYGqA=;
        b=b2RhPp9NZQ6IPqnUX73zRr9DpyOI8Ns3WUSfLwK0pY8WvxZXLcpu5SJsGCKsdddREo
         X6tqX+RALey3Iq3pal7H5OneD09uX5d2ks1u86xeTVJvPpABIe3tduLoeAY5d/Tz98aH
         SXrEUV3qtaxS6pawj9aQqqtMpt82I5cdZzyvCiyH8jVoDPeMtYIUYZtodyYm4Yyp0QDY
         7MCxUjqhbWUehrmD4y6Yii+3qwnLvVVTrUy67TnNx5WBseXQ5WjZGuKcs4B+4IGov31q
         88a8Jb278Ezhmt4k8WskFqj6xt9cTe9UpEawE1cyg95LBbp84fIUQTibLqOURFW7dOVK
         4TgA==
X-Gm-Message-State: AOJu0Yxzcf+iSESYbLVMIwKENkPuK3yn/h8ioFHdDjIr3MP/nhVKgy/J
	LYSmS6/Kz+oBJ0zOncUQIA70ZC2c8pzCq8oMppKepM5uUlUeF/SVOtDQ7TrZcrkW7DKaiA==
X-Gm-Gg: AR+sD13Ul8h513a49wZJmKcuSAINSROeqWoKV3D2DlXlKXiKe7bPciyGvBLbA8DtCZT
	BfXlpvE3jPZRagAfrORXi+mqovfvDOmrPWr6YK10ua58UoqYWSbKWPWdGXbfyzRuJn3li2PbR7x
	paJDkWUTJqCOeocTF+dC6tOJvhG6tYFXsb3ymJ7xAWPUTkEz/DHlAV7bShs1RBjwYNCWo/hBdpv
	eKCARw4EyCA636XRfO0j0do580jRQ8ktClHNmC8UGoU6flsj1bkzFaRHbyOqGydrJgDKwBEEHyy
	WsQXPjItMLoZu/+4wX6MqiBElTmRsSpr6p9zmFYV+ND/gBemMzJU8awzQBgmyOzvmKMxKIy6RtQ
	oYthPktJxUsSZZKN2uRBsfTRDvgH7uaBcUOk3ZQRgteMsdmgnsHuQQZ8N92DsHq0IQPEuf2MUAJ
	lGWoT/d0ubmshuj/5aMbp+HGMfp3Z5hOpe+vd57J7MRfVGYlW9EQMPhb8BdHYAHzX/YQju/yhue
	2ht0DtpSbv4HCIXU90ryDNdIFDsq+V/1g==
X-Received: by 2002:a05:600c:c173:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-499553e1c83mr98177835e9.6.1786040566221;
        Thu, 06 Aug 2026 11:22:46 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995420bd1csm82214425e9.3.2026.08.06.11.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 11:22:45 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v4 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Thu,  6 Aug 2026 18:22:33 +0000
Message-Id: <20260806182234.380833-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806182234.380833-1-mahe.tardy@gmail.com>
References: <20260806182234.380833-1-mahe.tardy@gmail.com>
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

