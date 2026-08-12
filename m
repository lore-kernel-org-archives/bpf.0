Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954A481AAC
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549427; cv=none; b=Z6A0O+9QuhaxEyuVeMZ3KaO+1spRapmFrH6S2jphRHfUC71CBW+3bZC2dZpzrJMX7hQ0yS6uX1LZY89fyQeUk1t3d0W44JjYn3WOCHrT1lso/BXYHO8wKPlxSwxKv38MSrTX8SknfvV5sx6yAz97abZTuGXIkP2v8weii4nenaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549427; c=relaxed/simple;
	bh=YbX3LglyOuRM6yAuBB1Yh+n1QSZnqJHWbyAOKSdplDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uz4UKZxrEAAE9YqEGWZxJKgIkOvTGqU/TjhXHawK5ymW1XcUUhYhdyUU5YeBNzne4Jdnuld9IvXK997AgmpXalFquF858K1R6avCKued/JyY8QFnwjLgGdKT7aHoo/f120hgtPZj9d82ZMmgAh0JgmjIHdr7N9wzURcMdo3Hn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEF1fuk2; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEF1fuk2"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954dff6536so8730355e9.0
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 08:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786549424; x=1787154224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dm8Uo/T8I7vO0EZv2rPel7GL/yI5kjPMvyY1CmlpbLw=;
        b=LEF1fuk2f0lhUbKm1dObLBr5Hbt9upqdrkCd8+cS9fxcLMEPBAMdndp639bQmdE6Vf
         Sk2hXPkgUn84yBqdRIzkhmpWGtdPk9756FQCGJp+DmLO/Ao5hPMUPRE8cNkc/CACb2C3
         W3ANtiKSzBQkeqJ2SzRXJ7lfe3pQeAdMmRtrW97nOWgrkLVvAhvQa8sjRBEDZbV4p6qo
         WGU5eNIFHBv3ftMzKjhi8E6x1oSKZ2+lS7sIf5xUME4PiXrBYJD2RSo3cc/A7FSRBAXe
         ZKD47hz6LHhvVrcsJQUaId/GSXaKA8eQ8V2pTljoiDkbB21D/gwHflCZFJ7HEFEHEzkG
         2+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549424; x=1787154224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dm8Uo/T8I7vO0EZv2rPel7GL/yI5kjPMvyY1CmlpbLw=;
        b=JRA70RS3F1tHLFrfsDeK/O19qTOFPbcrO57GrNhgiYhhPpRnNU/JGqDt27ZpeqoTOo
         9039RSYw1Ci3oCwbsq9Sx/UU+V8ytd+lMQdjqVuJn3nmyoXTTFfVE2bEaFD4mf6eQXP8
         cfIMCSSmudu8g9SxhvL5eG3chnOPUOEO8ZgeVJp+Ih6K/4eSjS83Tl2lHvfhlBd6+dhl
         5SDtMaIQ3Rye+NCCsqO/r9NvYCnXb3OHGBQu/nv9Q7NBWrXWS0niXqtcyJerLIdYKq1M
         MSdvPl31Fq3qvyiYgL8Py21HLuJpXv1pkn0S5zLTLkWUaK27ZBfTDtozb39D6x6nsOR0
         eFiQ==
X-Gm-Message-State: AOJu0YwuPBOLNX6+vAnhS6o4gsRtav63bVc8CUBKRP9dSXDHZ/gOA3SB
	w22jFrnX2Om9Logpe1L9GrnBSiYO7vwmJ7OE6x3DJVHkqRpQCZ0tDN5g9IlwbdJJ/OyBrw==
X-Gm-Gg: AR+sD13lew03323V+mSw9yE/WMVMejzGjJ2b9t18WLlalqMl6LegmMrt9A8SPoLm00c
	NHpa9jrKyuishnBMG6ITIMTi9BN0U+DSqp7ZcHMjeE9uCgfsIoarNGCJfMRrF6nItjyl8qIUn2M
	e2r+fqAab5d2npBPTZuIaYvad/8ZMhWuT8YSOQ2W0dgA3KG7mmAa292HeQjIPx2zl4HcpqPnQNE
	KrWi4mavyYLsPrfDs9+Od7SGKHH9hPN9OoyToyqyICmdxD8/eVR8l9v7jluiPFNW2rWz7DDSvpQ
	sZChGFB1NAbKwdrOValpasz+0pgXgt5ZqMlcJ5sN90pQkA2bNuO3pepUiDOUtXZ3GfmQuWVSyvT
	A/3EhZXThGgKo3VbWlds1BgFo+zDZ9URg5LuV6y5kaCC21xdgLI5Fpb+tAL25YDlw2a3j6thWWc
	53XR5xZhcvopySHEJ/WIBcQDOZeNy7rpN+HHeHStsWnS6DqyA0qsd8cgYn6RFxinUa1WDH9JTAk
	ZRVa3cB+hQrTtV9UOQC8bQGE0gS3aKk6Q==
X-Received: by 2002:a05:600c:c178:b0:499:60bf:c6f7 with SMTP id 5b1f17b1804b1-4997c1487e9mr77025455e9.13.1786549423767;
        Wed, 12 Aug 2026 08:43:43 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997c939574sm51584985e9.1.2026.08.12.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:43:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 4/5] selftests/bpf: Test forbidden bpf_ksock_send() LSM attach
Date: Wed, 12 Aug 2026 15:43:27 +0000
Message-Id: <20260812154328.72834-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154328.72834-1-mahe.tardy@gmail.com>
References: <20260812154328.72834-1-mahe.tardy@gmail.com>
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
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/ksock.c  |  6 ++++
 .../selftests/bpf/progs/ksock_lsm_verifier.c  | 35 +++++++++++++++++++
 2 files changed, 41 insertions(+)
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

