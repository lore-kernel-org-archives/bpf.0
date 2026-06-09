Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11043AC0CE
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999348; cv=none; b=itz5UJ6PSTZgg6Dq8yLgQr9YNhb3k3ZI5aniwuz0gAgAC1Zzswfo47szbR4NcJlBybVsxMj7ZVyRcqhLxxSke4UaLmGYqyhpsja6Y5gOpRu4GYkFtoIT2mHZMGwIQ3FUrxoHQV71ZJE9DAuYOpBkFMiDjFlyh6aj/Bkslk7S3iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999348; c=relaxed/simple;
	bh=nzrDL90bsBsB7WBv1krwtYWNciI5KVTJUXqrlhwrMKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pOeB4Rf03uC9HuxuJK+1mcxNdH9H6Q0FO00fVXtc7WmLS6014UIYpsUV8ipkMXrdnSv+zy1WJ8FiDu9/93y6TcCGQ/WlKg6U6HLBZgtMUCX+PT21B/MEZ6E3mZAytBgkHWfAOlkT0DcJnY0AcFOJuf6bnIShTP47mi9LHlG5+lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz5V17dK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz5V17dK"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8589498839so2339444a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999346; x=1781604146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5QAVN7p+JjAGllf82nuL6xsG4iI4YYCey6nu5LA5pQ=;
        b=Wz5V17dKhlowDP4Ul5hWJA9qKji/zC23EReD2SoZjbpwMOVwEpam9c8URHo8RJAZEJ
         BvYgLIvQaBr7hQISlFPL7UajfM5hQvYD1iEa8t0vKImAHBxKrSmgHQrUfQoNDHVxDv2/
         4YMQVxIITDlBFS3y4MObYz+ZVD6msXfOpsgIYEYgnhyUSj5szUS65RPeRJN55MSzN6Dq
         PGPhY7Xxdo0xwmfkUW9JSUDk/JTxItIlhyvzJ9lnQaC2LTCut6VnFKxirWd5hFCaviJz
         6u8hM+AXXZH9sWdyy9pwADbSS0waopVEpPXhw0cU4wIXDDQM596a0oHNkMC6Lul6xRLC
         MvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999346; x=1781604146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5QAVN7p+JjAGllf82nuL6xsG4iI4YYCey6nu5LA5pQ=;
        b=jJht4rta/2fp+6n5AXgZuWUnq+Ri+bdj5mJ97vdy2DDrQGEVJwMb36WIkF26M5hWs7
         tY9lVGKxouXnIt5qKgnZYDF4BXjuDiLhgKSVOKYeAwXoPdepsb/KhTjYg88YCvSKc7HB
         4s5m/ZOFV8TD0kWpznDF30+dwcuY/bgeOc3daWZr/UScE8Zc/9llCGVMRTz+UpdJ8Gy2
         kKaAyDmxaqp+yuRf7HmiTD9nLiKi3LOoB7PHhzvJKcP/bFcLMf825wt7+FkAxuYJD/9t
         M5ttdyPOJPQbqs6tq7OWAH/8/Rsi+IsT4flnQyWUwY96tnz0vqYpWhHW2ZtiO4CrZe3H
         GOng==
X-Gm-Message-State: AOJu0YzRgfCTal3k3Th0a7ZDMV/lMX7QbnmsBPdvA52ZIfoDbx9/axFc
	3Tdn6ZjDkyJPhB7YpSfHN4kJp1fT3oUfvFK/Gdk72+KxKkgIhNJ117SR1olBs9L1oJ4=
X-Gm-Gg: Acq92OENLxwXzKzzTbvqNUgawcZiiZaX2gUbB9ZbXstmx36DR+8nQHYlYC/SZfPD+V4
	Y4LvtNIe9ULZkZlloS1rSdP5U+z2AdsRY8866VhtSeMBfluFVpVrgUNJZGJKVRq/h9CbznPYwnJ
	PzhHSI7gOQAo4nvqloerDhvM1dIEdbiNHchTZ1GQK4354ICNaT6MFZGvyL7rDbJP/Ih/Z/0hxj6
	A9gadp5f0iQaa581Yu67XCHFgwOsF5MZ/bW5oKoexNROKOPROtcjEGVXGoU16Vnh4/sGWOefbco
	sOmSyzOXlP1FZU0kAnulr1QDTfK8rrAJaazOO1yYFUB1m1OuifH0oNV3h4s9qsZ6Y1dPHAMEHWf
	Am+OGx7NkZeWEewCLWuHo0LLV4Ll8GpxyRkXNBxcZtfiSxeK8FjWWBPc29R1By2JJKe285df5pF
	tMSV72OI0RNFmDmesXt94IpX7hiMzCWlLJU82YOdSMBGZxWmDzeYkzW56ysGy2LuFen8bW+m8LP
	GIP92RvRkx0AQWE1RQnHwagIqai
X-Received: by 2002:a05:6a00:4407:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-842b0e84bbamr20569193b3a.20.1780999345960;
        Tue, 09 Jun 2026 03:02:25 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282378986sm21365151b3a.22.2026.06.09.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:02:25 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	liuhangbin@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
Date: Tue,  9 Jun 2026 18:02:14 +0800
Message-ID: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
skb to multiple devmap destinations. The cloned skb can share packet data
with other clones.

If the destination devmap entry has an egress XDP program, that program
can modify packet data. Such modifications can then be observed by other
clones sharing the same packet data.

This can be reproduced by strengthening xdp_veth_egress to configure a
different source MAC for each egress device and checking that store_mac_1/2
observe the MAC configured for their own egress devices. Without the fix,
the SKB_MODE subtest observes store_mac_1 receiving the MAC configured for
the next egress device.

Fix this by unsharing the cloned skb before running the devmap egress XDP
program. Limit the extra copy to destinations with an attached egress
program.

Tested with:
  ./test_progs -t xdp_veth_egress
  ./test_progs -t xdp_veth
  ./test_progs -t xdp

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/devmap.c                                 |  6 ++++++
 .../selftests/bpf/prog_tests/test_xdp_veth.c        | 13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..4ae65d44f9d6 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -730,6 +730,12 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 	if (!nskb)
 		return -ENOMEM;
 
+	if (dst->xdp_prog) {
+		nskb = skb_unshare(nskb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+	}
+
 	err = dev_map_generic_redirect(dst, nskb, xdp_prog);
 	if (unlikely(err)) {
 		consume_skb(nskb);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 3e98a1665936..52d79d5c5629 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -456,7 +456,11 @@ static void xdp_veth_egress(u32 flags)
 			.remote_flags = flags,
 		}
 	};
-	const char magic_mac[6] = { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};
+	const unsigned char egress_macs[VETH_PAIRS_COUNT][ETH_ALEN] = {
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x01 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x02 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x03 },
+	};
 	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
 	struct bpf_object *bpf_objs[VETH_EGRESS_SKEL_NB];
 	struct xdp_redirect_map *xdp_redirect_map;
@@ -512,7 +516,7 @@ static void xdp_veth_egress(u32 flags)
 						 &net_config, prog_cfg, i))
 			goto destroy_xdp_redirect_map;
 
-		err = bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
+		err = bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);
 		if (!ASSERT_OK(err, "bpf_map_update_elem"))
 			goto destroy_xdp_redirect_map;
 
@@ -531,13 +535,16 @@ static void xdp_veth_egress(u32 flags)
 
 	for (i = 0; i < 2; i++) {
 		u32 key = i;
+		__be64 expected = 0;
 		u64 res;
 
 		err = bpf_map_lookup_elem(res_map, &key, &res);
 		if (!ASSERT_OK(err, "get MAC res"))
 			goto destroy_xdp_redirect_map;
 
-		ASSERT_STRNEQ((const char *)&res, magic_mac, ETH_ALEN, "compare mac");
+		/* store_mac_1/2 run on the second/third remote veths. */
+		memcpy(&expected, egress_macs[i + 1], ETH_ALEN);
+		ASSERT_EQ(res, expected, "compare mac");
 	}
 
 destroy_xdp_redirect_map:
-- 
2.43.0

