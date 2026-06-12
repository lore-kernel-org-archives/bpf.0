Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE731F98B
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226927; cv=none; b=M1tqqV1ssIF3dAWRYWvoK5iYAgoXNe4/s0xmxvlJIS3CvBZNHPHIHeJrTDmZQJ7LVNiq7Y2yUwiGV1ZleayJd1M4uOo9xvBX9EhZeSxsRmPuP83sBu7pfqbMR3XofVKLRtvKwtBBk25lnyoDZ+A+jQOM8FoNr9Iaytvd/PAWXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226927; c=relaxed/simple;
	bh=F+0f6GjAi0Omfa+PHFBC0H5zSWE02Vdv2b6Qqh1qNzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBPVFuV4m2xhKgMzd6ZeDf11KdDcaXZLa0Rk+NQ1K4Punc9kx3NqElKyVD9tP4COsZq5s30Va7d7Odz13AvHw0thK1zxf3MQ2BuLuS/cNtysCub89jsePxtuNDwGuN5WZh7IfPF+w3VYYYIKsEBDASziBBFKl9XgvcaDm/Hazic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7aaXMAW; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7aaXMAW"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-137ec563a95so463787c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226925; x=1781831725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ON+xkZIueelbq1KEBRaBWhyuYqrWXonUEPs0BXpVTfM=;
        b=K7aaXMAWT3Fe77QoHr1H9VmVSaAP6tWkuzAuLmOMKNJVIrKDyvoJ1DuqcQrby1hU/M
         r+1sx/dOZPXZdzaCIaIojFljypQ0pHLlZLQrhg5n8qBc8gXlBmVbKEAFZIcY56ZM3QQb
         kMFCsIGi/yqUSxu02YWW1gFLCRCrNXYxeVuJ/gLNiH0zL2Lj1SpzBld1xDYO861Kny+B
         YS0bOxD7fXVRoDl5tmZuwCvAO7usE55Qfu39jaYYteYSCT13+s27TNE4L9xqeLyRzFLr
         RYT1MUVfR/oEpyoeMVY+PYyj7PvHTBmUkXyslyPmLj9rqAacDyiak1x5ckAfgdRl+Kxg
         /T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226925; x=1781831725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ON+xkZIueelbq1KEBRaBWhyuYqrWXonUEPs0BXpVTfM=;
        b=X1mF60BSPhfyArI7PXm+0NPKG0JEsvGCpEezu79LvgkEaP6DaMrXlqGBt2pCJ+QaEA
         Bp42HolLhigkZ/PM7bocdqOqTVsBH7M9ZFlssWMm+F0owaVayb6R1EXd83TeeMtGldsk
         B4g2H40XOU38m41HODT3xqAk1f5/p9oa589XLmIkPneJ3QPaOODCJCFzbq8WMcB5mrxM
         paWr94+VlbDWWx5duuaIj5LPkEKW+aqTWUX0dNd32WkaJFb77jZGRiJk5gUFdJVUZmhY
         F8Ttzux/p+m7WIxsG9MwUVY5NSyysF4kMfN64sfRqvq8sCdURmVKn/7Zzlsczv3K2+xV
         hpKQ==
X-Gm-Message-State: AOJu0YxXtSkjmacxSBpYDsGLvIw8w0C9N3yNjRe41oTnsco6zi1xlL9V
	3Fnd6k6YZ/bi3R66LGcYEZLZUFpxl0099V6yhYtqSX+RhIoAQ2KQJK4z
X-Gm-Gg: Acq92OHegrhm6XJBKEAwnA9yjeSzeDp1T7uU/kv1S55lADT/dxSJlzdwIdgvrsjZZcr
	qagsO9dxkVkxHwqz5pjVg9ayh0+SJfHV8M7hdRW+89q9TOGXLopVJvhptLyYgcUshC40021zJ9o
	/Wj8yzkqkJ49udZQtNSVT2JvQ1PjXUK0i1MsaUCfasCjtc++IQOCi+9tzBtepCgHUaBm/JMm0ng
	Uq9MSrWV5uxF3cGujiQ4PZ3/MtcMCTD4d4R6khKfTREhDXTN/fzmfypYt2mCCnwAMdZ4dMri59v
	aqmf+9xauCiHSwky0M/qu4smfkAvyPHURWBKTp6OYRMMGKrzn9fnvrTV3HIcu/lOWAe+jdyDSp2
	9aUjXCcjsKgrMuIEroFvxrznYlGBHrxpCTbjJTSF+bGme2yGpeLmslTEY0rd7pM8ngqQhqPdXhG
	MDbBsy7k8UOaokMg6c2Dsom4LVY6k7zZ61m2zyM4q6Q5kRzGFMQFR9X8N8JeA5+Hx12Q==
X-Received: by 2002:a05:7022:6baa:b0:137:fc94:9758 with SMTP id a92af1059eb24-1384cc8b831mr10992c88.19.1781226924868;
        Thu, 11 Jun 2026 18:15:24 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:24 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 5/5] selftests/bpf: set SO_BUSY_POLL from the tcp_splice sockops prog
Date: Thu, 11 Jun 2026 18:14:52 -0700
Message-ID: <20260612011452.134466-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set SO_BUSY_POLL (busy_poll_us) on each paired socket via
bpf_setsockopt() so the splice receiver busy-polls the ring instead of
parking - without net.core.busy_read or an application setsockopt.

The sock_ops prog runs for both the active and passive established
callbacks, so each endpoint sets its own socket. This is done before the
peer-not-found early return: pairing is asymmetric (only the second side
to establish finds a peer and calls bpf_sock_splice_pair), so setting it
only on the pairing side would leave the other end without busy-poll.
bpf_setsockopt acts on skops->sk; the peer sets itself on its own
callback. Busy polling is a receive-path optimization
(splice_busy_loop() in tcp_bpf_splice_recvmsg()); TCP is full-duplex so
both ends are receivers and both need it, which the per-endpoint setting
provides.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 .../selftests/bpf/progs/test_tcp_splice.c     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_tcp_splice.c b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
index 09c7f0f9e311..da43f00046c0 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_splice.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_splice.c
@@ -9,6 +9,13 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_endian.h>
 
+#ifndef SOL_SOCKET
+#define SOL_SOCKET 1
+#endif
+#ifndef SO_BUSY_POLL
+#define SO_BUSY_POLL 46
+#endif
+
 struct flow_key {
 	__u32	saddr;
 	__u32	daddr;
@@ -29,6 +36,8 @@ void *bpf_cast_to_kern_ctx(void *obj) __ksym;
 __u32 pair_ok;
 __u32 pair_other_err;
 
+__u32 busy_poll_us;
+
 /* IPv4 only: the verifier doesn't accept memcpy from sock_ops ctx
  * because it lowers to "ctx + reg" pointer arithmetic. IPv6 support
  * would need explicit field-by-field reads of local_ip6[i] /
@@ -71,6 +80,21 @@ int sockops_splice(struct bpf_sock_ops *skops)
 	if (skops->family != 2 /* AF_INET */)
 		return 0;
 
+	/* Enable busy-poll on this socket. Both endpoints run this callback,
+	 * so each sets its own socket; this must happen here, before the
+	 * peer-not-found early return below, because pairing is asymmetric -
+	 * only the second side to establish finds a peer and calls
+	 * bpf_sock_splice_pair. Setting it only on the pairing side would
+	 * leave the other side without busy-poll. bpf_setsockopt acts on
+	 * skops->sk only - there is no variant to set the peer - but the peer
+	 * sets itself when its own ESTABLISHED callback fires.
+	 */
+	if (busy_poll_us) {
+		int us = busy_poll_us;
+
+		bpf_setsockopt(skops, SOL_SOCKET, SO_BUSY_POLL, &us, sizeof(us));
+	}
+
 	mk_key(skops, &self_key, 0);
 	mk_key(skops, &peer_key, 1);
 
-- 
2.43.0

