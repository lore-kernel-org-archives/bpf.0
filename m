Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F4468C13
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786619175; cv=none; b=Ip8gZiG40ICb/Z9Jfn+AGp/UpO/RcTwDFDL4Q9InwoieHYNqBm9RON7Qz+oNHuidVjDEvYT0oHoFXgmZ2t+bse3LEI7ID/8ZlbyIi/qwJwpxMQ1w2LA3w6Hvv2SODPhIdYnwW0AxGkboyu8iDqLKs2ySIPXKOJNVJM44mCMSjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786619175; c=relaxed/simple;
	bh=SYyfPCQihWyjqkP7HqRGM5KXs9K9fTlaqZk5lYk96MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIyTGH+luAq2teH0hSaBAJrnc792nD1QBxzSI8D+rATmbr2s8rpGAim15VV2F9aW2ZcqpLkL13laSi1WCMNwsXgFBqY8H/FvMCwQafSdAixLoo7gtKDmoXruRlcPv7wihq25/VE2k/apFOA+o7RlhBIokWo3K1RNqwqSasW+C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRu4i0/N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRu4i0/N"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso18216285e9.3
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786619160; x=1787223960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UnabLq/zZlzT6flo8eoDxgMosyAhh+oBIBd+U1nxMSE=;
        b=MRu4i0/Nyrkp4QhjZCMgBkvmhoC+5gH/QzZf8MSC7aM8i+tUxqxhuJimVI2dTCHRPd
         xFk+pz8LKcb1wYqaMSZBQwFfiDRKiFuufvWgT65C4Tuij0ZXiD/ekLxNXiAwmdyBnb0w
         fu9yqKKTxYqbIwfiEgoXb4EBMuPkFW0Z6R96oLKd+xIqB2nOvLmZ/uJVHDfnVF/SUzKb
         QCGe36cy9GKsSC0NCaWTlFMWxjG7YohUIuzWMw+qLhLSpWOmNzY2izmV0+eZw5hiIBXE
         TTpUzNxPptE8rhMkdSxmDc+aGpXMUsEMf3oZ+OeAKfqizH2zItxP5YWQxY/IHKwL7F5R
         lV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786619160; x=1787223960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UnabLq/zZlzT6flo8eoDxgMosyAhh+oBIBd+U1nxMSE=;
        b=WrPF3So5MWWiobU0QYNEc8ZXlt3hjg9al8BVbW0ad9D2Kcj7PwSgTLZHA7gsHcJzIH
         wZb+Vlp67cPNLs6WGqBQh6bACrzC/v1eOSiMieG07KYfhyYqXwWwIhSIcAffFyBBVuk1
         5RWkpjT6Yw8T9sklTSvJ4BTrxEgbf4MBMlAy91XcJfLOPF8j25OSXjXUFjx2Qqmd3NCy
         xtQmesUrr3x2B3HLhAFdM51qq+onvZEGjPaeOoaP/m+pzPNhk9xl4LB/Kge2GiX7/w4e
         NDFvuqtTS6lZ7LEqujxMQ/STN6elwibDc73iZCFoRUbvhiPGAdPzErBf7N3W7EuPy2Rt
         iydQ==
X-Gm-Message-State: AOJu0YylBgdS2G8jg6xPu6EZgOb+QkhpmANV/VKeiUdnqAN64xLp1sK8
	QHPRdrhPbZ95eiS8ir0BcDAS3ozl+LJ6b9lIrWw3/WQm9wlnF3Q6tak8ejGR4KAPMvnYFQ==
X-Gm-Gg: AR+sD13V6MKP0PtOv7qKLOcFjvvRcRWcbwaOAlr3zIjqQnVkNvGu2TooX8yqhkhkDol
	jMVKHPr5T14CFLluxuI31x/MvTVRgAdPqvtVRRLXSZyU68QVcrNbJUOidCefdb81WemqeQYPqwD
	Jcq6sHI4k2fzyRB4w2V62aCZD8dBD2qj1dIyKviIFaTdKZL3zrWR89jyBWa+k3wO84a2qBlFnk1
	2T1cNqTKEl4OpGqjQaIkLkvLA1thRTlVcvBjT6X2V4DmBLgsaUxT+4rOIDT6as2pc1UwUxi91ND
	UlKqrKUYQWq55P4lIAWfvVivU5XVUraZ5+CKnH2bFzYZaCo75arR0ZttFqVhD0/p4U609lHu7bD
	4cqV779J86wCxs55ZCCnTLVk3qquoD3vj4HZp8YKGgxqTX5CjVXytTlRtTxi7L/LdOKymHs59nS
	ZWf1iMmBff3qfUacUdT9zXFn1iEkO3zyU0F5CcQrfyATzz8MHVByyqh5mmOD07JeojIqDk5UhD6
	i26T6wcCBSePDa6uTEaMmTXPd8lfzRiPA==
X-Received: by 2002:a05:600c:5492:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4998219b773mr55770445e9.3.1786619160050;
        Thu, 13 Aug 2026 04:06:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49982131261sm93841285e9.8.2026.08.13.04.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 04:05:59 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v7 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Thu, 13 Aug 2026 11:05:39 +0000
Message-Id: <20260813110540.103550-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813110540.103550-1-mahe.tardy@gmail.com>
References: <20260813110540.103550-1-mahe.tardy@gmail.com>
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  |  6 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 35 +++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock.c b/tools/testing/selftests/bpf/prog_tests/ksock.c
index 05d7b7424aee..dd6b167623d9 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock.c
@@ -6,6 +6,7 @@
 #include "test_progs.h"
 #include "network_helpers.h"
 #include "ksock_lsm.skel.h"
+#include "ksock_lsm_verifier.skel.h"

 #define NS_TEST "ksock_lsm_ns"
 #define RECV_PORT 7777
@@ -122,3 +123,8 @@ void test_ksock_lsm(void)
 	remove_netns(NS_TEST);
 	ksock_lsm__destroy(skel);
 }
+
+void test_ksock_lsm_verifier(void)
+{
+	RUN_TESTS(ksock_lsm_verifier);
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
new file mode 100644
index 000000000000..fd2ccfdb5802
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_lsm_verifier.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
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

