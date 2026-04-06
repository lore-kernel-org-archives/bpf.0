Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053440DFD2
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775460437; cv=none; b=Ck1cix+F2Pk7Voy2+DRAo0g1DcfnggbaY7FaudfZGP/PaEdIvWsBKTI5mYbV7aJXpgiR6B8ZWrIfGrGI61t0wlzc/TCUmxmVClNon7g59g/oNCDGbMHoIBvLCEG8L2Bh648RsIMDfh5JJr709IsH6G/c+rIh/3TvaTRSqmjpHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775460437; c=relaxed/simple;
	bh=5xf2bbceAjrL9Kn0yXbZUdc9u2qLSvuJAqr0yCPb/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uv/kp3C5sKCRKZ7BZ+/gM93cNT6+MiB3crtXeiYIYAduhWfMxT6mCaxwVbSaOuKDRmcW6gQFu6a1FU7T96+zMe5QdfSeBZuVUc/agOtvH3hOLMcSfLcFYTwdaYGbOUepiBnwMhkKyvn0gXY16vIg+4HQGqtQtuyHgwj1dbcgQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=fhl4ULzz; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="fhl4ULzz"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso2209024a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1775460434; x=1776065234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/+l8xdJ81rnHVCDBCC4cOrkEDKbX4zpmL1qqNzt32Zg=;
        b=fhl4ULzzM3JxbZouxPkKN/7rTjYPN3YEpC3ZB6OYTyX4Eb7eWdz0InUBJR2eUpHwBT
         GM9n+s2IF8A8NQVlD4smGaMYzKRMZyryUeJCwH9cr5CXCNOTL/oJn/c2MLV5NJ8MsnH1
         iGWWSCazM5+HYYH5YwgAqQt4dCjkwGCzGeYbQMoF7dlr5z2fJvhglH6j6TV1NdLvJBFo
         lDoav5ssTuxyaOwadCG4QEu0zGH3Oqc/GNH96JjwPpBDcfKQKIAgOlVFn+FDSV0NbiPN
         HL4dLsekBNrbAKSdbSxN9NCMwQQgP6JUAzECK7g6yZZfhpa0F9avoVHZrnmph4zfBLF3
         BKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775460434; x=1776065234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+l8xdJ81rnHVCDBCC4cOrkEDKbX4zpmL1qqNzt32Zg=;
        b=XIXC9jAV/sXD3TWPpt7RHJrScUThZrPFG9GeOk/aO6vYJjKERml55NcdnpB2oR1spV
         IFTtFq5IqDOyZRJX1orTv7optWhMWVuxKecDnBqdgpJCkwEbW9SE+Boy2FL7ZoQqZU4C
         JsBfyx/ia5qbYKSqv86pdX32bI0tbUnf34YjHbLInHSszlHl6mqEIK+gIkxqpC+dtYRa
         ZdDs3jieK0pQi1ip2ekMTIlyNzqfb8Z3pdzylA1oCfPEj8FpCa+P3puok64Qz503UX4J
         3TV86E6Ud9NYGSWrw9BWBLivyw7dum6+nhgOkuVMCkuJxX29U3NleWtGAcsGKmPhqA7Y
         7jsA==
X-Forwarded-Encrypted: i=1; AJvYcCUegws9NHS1xpYIxkaVywY1tG+enFZb/+PO9SxwVMzaexsoxZIbV+rs4Upmyyb4ySb33VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Ar7eTMEqq0u7KslET50DGfk5dpD2G5rrgCPvLW7/YjYW+RZh
	FVnQO+HJKEGdYrhbY+L7Ow89RSUx2cMKNIrBiO306vlOv+5BEsajOut5qxHJ1ghcvPc=
X-Gm-Gg: AeBDieunqKrwWaWcbqhaegCBu8/lwRaQaCqm/sDXBqc8e8MHiYcHtfO6+QiiKzqQCaT
	QPJCER3qFgEDG8SXVxgJzoCY3qqEJYvAo/Q5Sko1vvDqTirAuc4DiFC09yXjqJB/Qpa+2q5oBW4
	chQ5nqBuoj9QcT8QLLaSSewB2woPAdotbdhIwR7xGyPvzWwIuPDrCTlwljZbMdXwk056ry8KEYX
	lFSKoEInAPoUI25qf7Xkg/5/8Dm8koru5a+xgqmmNyc02XplgoYfB8SuG5d1ELzNnow9l3PAG4S
	Vp76tN2jyMnrmHF5wV+nS7GZ4hdf1CyOeqRmuxReDJPZONzr8+2SAGzVpc1UdHfuq8xrFslFI3o
	f7pSYzm1exnJ4cl4z7TnAAyNHYoSXdQVJlEInqRH4HNCGgc6bJOOAIG0COql+ZTMd7vid7JifVz
	YNxshPdQOVGKKdyVDaevbB2ljoWii5u30TV5Et+MxCleOGOB3X3w==
X-Received: by 2002:a17:90b:384e:b0:35c:d01:d3dc with SMTP id 98e67ed59e1d1-35de68ec479mr10327576a91.18.1775460433873;
        Mon, 06 Apr 2026 00:27:13 -0700 (PDT)
Received: from bms-ytl-d1-app-10-251-178-27 ([147.136.157.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd367bf24sm12920937a91.9.2026.04.06.00.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 00:27:13 -0700 (PDT)
From: Leon Hwang <leon.huangfu@shopee.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Leon Hwang <leon.huangfu@shopee.com>,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH net-next v2] selftests/drivers/net: Add an xdp test to xdp.py
Date: Mon,  6 Apr 2026 15:26:54 +0800
Message-ID: <20260406072655.368173-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "bpf: Disallow freplace on XDP with mismatched xdp_has_frags values" [1],
this XDP test is suggested to add to xdp.py.

1. Verify the failure of updating frag-capable prog with non-frag-capable
   prog, when the frag-capable prog attaches to mtu=9k driver.

The test has been verified against Mellanox CX6 and Intel 82599ES NICs.

With dropping other tests, here is the test log.

 # ethtool -i eth0
 driver: mlx5_core
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..1
 ok 1 xdp.test_xdp_native_update_mb_to_sb
 # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

 # ethtool -i eth0
 driver: ixgbe
 version: 6.19.0-061900-generic

 # NETIF=eth0 python3 xdp.py
 TAP version 13
 1..1
 # CMD: ip  link set dev eth0 xdpdrv obj /path/to/tools/testing/selftests/net/lib/xdp_dummy.bpf.o sec xdp.frags
 #   EXIT: 2
 #   STDERR: RTNETLINK answers: Invalid argument
 ok 1 xdp.test_xdp_native_update_mb_to_sb # SKIP device does not support multi-buffer XDP
 # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0

Links:
[1] https://lore.kernel.org/bpf/20260326124205.1a3bb825@kernel.org/

Cc: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.huangfu@shopee.com>
---
v1 -> v2:
- Update the category in subject from selftests/net to selftests/drivers/net.
- Drop _exec_cmd helper.
- Recover the original MTU using cfg.dev['mtu'] (per Kuba).
- Drop the unnecessary shell=True arg (per Kuba).
- Print error using ksft_pr (per Kuba).
- Drop the sb_to_mb case (per Kuba).
- Skip test when device supports sb XDP with mtu 9000 (per Kuba,Gemini/sashiko).
v1: https://lore.kernel.org/netdev/20260401052746.314667-1-leon.huangfu@shopee.com/
---
 tools/testing/selftests/drivers/net/xdp.py | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/xdp.py b/tools/testing/selftests/drivers/net/xdp.py
index d86446569f89..864ca4097b87 100755
--- a/tools/testing/selftests/drivers/net/xdp.py
+++ b/tools/testing/selftests/drivers/net/xdp.py
@@ -13,7 +13,7 @@ from enum import Enum
 
 from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_ge, ksft_ne, ksft_pr
 from lib.py import KsftNamedVariant, ksft_variants
-from lib.py import KsftFailEx, NetDrvEpEnv
+from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import bkg, cmd, rand_port, wait_port_listen
 from lib.py import ip, defer
@@ -693,6 +693,31 @@ def test_xdp_native_qstats(cfg, act):
             ksft_ge(after['tx-packets'], before['tx-packets'])
 
 
+def test_xdp_native_update_mb_to_sb(cfg):
+    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
+    mtu = 9000
+
+    ip(f"link set dev {cfg.ifname} mtu {mtu}")
+    defer(ip, f"link set dev {cfg.ifname} mtu {cfg.dev['mtu']} xdpdrv off")
+
+    attach = cmd(f"ip link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp", fail=False)
+    if attach.ret == 0:
+        raise KsftSkipEx(f"device supports single-buffer XDP with mtu {mtu}")
+
+    attach = cmd(f"ip link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp.frags", fail=False)
+    if attach.ret != 0:
+        ksft_pr(attach)
+        raise KsftSkipEx("device does not support multi-buffer XDP")
+
+    # Verify updating mb -> mb program works.
+    cmd(f"ip -force link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp.frags")
+
+    # Verify updating mb -> sb program does not work.
+    update = cmd(f"ip -force link set dev {cfg.ifname} xdpdrv obj {obj} sec xdp", fail=False)
+    if update.ret == 0:
+        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")
+
+
 def main():
     """
     Main function to execute the XDP tests.
@@ -718,6 +743,7 @@ def main():
                 test_xdp_native_adjst_head_grow_data,
                 test_xdp_native_adjst_head_shrnk_data,
                 test_xdp_native_qstats,
+                test_xdp_native_update_mb_to_sb,
             ],
             args=(cfg,))
     ksft_exit()
-- 
2.53.0

