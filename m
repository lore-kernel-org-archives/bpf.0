Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3F374E5C
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700172; cv=none; b=u4NnMXjFAlLyE4+myNdt/BDZTkj7sKOa7/+XaVfQ2bbgLF7yhrQL74I2nJcCiEcMPJxKnCIRTTROkC18rbkPzWmdSi9+JRztJwGZWWCc/0cFs3WbhuPCZgaof24H5TmORuso2Kp7TrdHDg6TaiFHoLgw16kv39J9XhjsGv4g4Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700172; c=relaxed/simple;
	bh=TJUE0YZjr8qS29hN4Kb3HPMI9J1uBFgP4u2/cCl3Stc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7ZJn0kofD2MZgdTCC+RJVHOgYkFx8cBwPSWn2of5I4oJuBdnsMaZbbeDvjOCuJhd5NNdSu81NeqzHNmwZ2P2wI/f1FHYK7DDddoCf5dZsn1zGTD577hT1ROokxo8MEPn3eXRcBTl8trFtr3l3/6haxC0s+9MIvhHv9uf2NUJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSxB1vks; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSxB1vks"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c31ca77b4so5358122d50.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700165; x=1774304965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGzDBYrNGuehuWC5MjFuZIsLcoMWVRHHpRI2TFaYui0=;
        b=CSxB1vks59K2mlLAR1MKdMupabTmhEcuKJINmIA2TYDqYnQ50JdcBj/gm0X+1OJhNb
         aRO+VBDLXdEXmH4PRKChwqIVEcJsYqY2o0hNVjAGudZcNoVUZ7Ks4C3d770r2Q9MUYY4
         URRm244tZ4y1FS1udqfl3Aptvsj3koZG9cFV5gMfLMnew4n/9hZweANhGJnNJ7l1eU5T
         LvdpH9Z9JiYrW8jVMb7DUGaIyvWARbkELykizwBltzJKcQ57itdMU9xaqehFeB4Kd4GG
         lawhISLf1lBaK9JCYwIL+lOnX6CBmd4qlHUVMnBMhk4o88q2JxANfjMKXbq75ErOE4J6
         NL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700165; x=1774304965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UGzDBYrNGuehuWC5MjFuZIsLcoMWVRHHpRI2TFaYui0=;
        b=ZqipjNUlTrwcRViweyOH2fS09QcsX9DbFomErjHG4Y1Q1y63F08F7FVCfjmMneAEXI
         hyvbLockvNV58bZwSR2Zlj+sCkI7Zc5FKeISi5TwDCsOlqfLCdjaCe1pQYwf59JdL+HE
         Lj6FVvJq07hsscxS/tpM6SkpnHMpXKRy0YKmwzKNu3qQ6F/5I39P7noPlJ6H6jtQqEfc
         TF7nP4iAz76f61BjL9FYaZjIjknznavkk/Rov9IBFfIxnjpyEFAJVDWvdstAT1VVo4K9
         Xe+1V7Y2fF/5u4QwQICH5s7AdIugUMQD0Q4Lrt7zmLWeD+AoX5Mk4SY3IXhO4RSD7/X3
         kJuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRqXYDO6WIowt9Y4qsXGp91la1lEuX6+BwcckWid+0vFWzD946AdVSZ8MuqCwK0oNEVbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZfAlIoBLY4c951zwiIIZTpjuaUbC2TS6IOxP4b1rJLv8zTLF
	Tb4f6XxS/LujJeBDtvrv8IjMUZerfI2700l7WP8B6PSxlYjMetjhHyON
X-Gm-Gg: ATEYQzyJuPBn21t8iIuRqpj+EtdWrqQzYgkYpvHygYRjc5ODj1lFUhCTdyWBeSItWEK
	aDM+McfcN3V481/NEv5dkmj0yk0ksH8OL8YZ0Eql2JklDbyon8PsAPeJWgd85aHwRlssgp80xMA
	9IST6ftFX2zLzQAusSouR/C8jSQkyGA/tT41wEbWuFod3yk5EdZbJBCxwNUCQRSzgBPPYBxY4TF
	S+jpswjFzSGCyWAI4l5HBaqdxO4YYjba2hfvi1q0U7ZNgVsTeX3jvW0ofzbs/+3uZAQUefwCiCT
	a1uTCNy/VqMsfo0ahliRm2+cLjwh13UrpWKcIT3fqhXn8rYdX/PmpV+RTodFc2ydxxjNeh4UKiv
	LDEWUh9z021dccgkEgXIWUMZe6mnkm+Pk6os3yr+fKRbiklstUS3NeR0symlwgzcHoGtin87+cp
	OMbVN6qUZg66AzxEZBd+8Y
X-Received: by 2002:a05:690e:448d:b0:649:b943:2caa with SMTP id 956f58d0204a3-64e6309cf75mr11816353d50.59.1773700164998;
        Mon, 16 Mar 2026 15:29:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e65a5411dsm6391196d50.9.2026.03.16.15.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:24 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:16 -0700
Subject: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX test
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
In-Reply-To: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, 
 Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>, 
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests for devmem RX over a netkit device with a leased queue. This
is the same as the other devmem RX test except for ncdevmem executes in
a namespace, binds to a netkit, and skips the ethtool NIC configuration
steps (relying on the test runner for that setup).

The RX path is setup as the following:

 RX Path
 -------

 Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
   |                    |                     |                    |
   |--- TCP send ------>|                     |                    |
                        |-------------------->|                    |
                      dmabuf                  |--- BPF redirect -->|

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/Makefile    |   1 +
 .../testing/selftests/drivers/net/hw/nk_devmem.py  | 104 +++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 91df028abfc0..3cd68e06f592 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS = \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_devmem.py \
 	nk_netns.py \
 	pp_alloc_fail.py \
 	rss_api.py \
diff --git a/tools/testing/selftests/drivers/net/hw/nk_devmem.py b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
new file mode 100755
index 000000000000..0a66ff85db9d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_devmem.py
@@ -0,0 +1,104 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""Test devmem TCP through netkit with queue leasing."""
+
+import re
+from os import path
+from lib.py import ksft_run, ksft_exit, ksft_eq, KsftSkipEx
+from lib.py import NetDrvContEnv, NetNSEnter, EthtoolFamily, NetdevFamily
+from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
+
+
+def set_flow_rule(cfg):
+    """Insert an ethtool flow rule steering traffic to the leased queue."""
+    output = ethtool(
+        f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port}"
+        f" action {cfg.src_queue}"
+    ).stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
+def configure_nic(cfg):
+    """Common setup for devmem tests: channels, rings, RSS, queue lease."""
+    cfg.require_ipver('6')
+    ethnl = EthtoolFamily()
+
+    channels = ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 2:
+        raise KsftSkipEx(
+            'Test requires NETIF with at least 2 combined channels'
+        )
+
+    rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
+    orig_data_split = rings.get('tcp-data-split', 'unknown')
+
+    ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': min(64, rx_rings)})
+    defer(ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': orig_data_split,
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
+
+    cfg.src_queue = channels - 1
+    ethtool(f"-X {cfg.ifname} equal {cfg.src_queue}")
+    defer(ethtool, f"-X {cfg.ifname} default")
+
+    if hasattr(cfg, 'nk_queue'):
+        return
+
+    with NetNSEnter(str(cfg.netns)):
+        netdevnl = NetdevFamily()
+        lease_result = netdevnl.queue_create(
+            {
+                "ifindex": cfg.nk_guest_ifindex,
+                "type": "rx",
+                "lease": {
+                    "ifindex": cfg.ifindex,
+                    "queue": {"id": cfg.src_queue, "type": "rx"},
+                    "netns-id": 0,
+                },
+            }
+        )
+        cfg.nk_queue = lease_result['id']
+
+
+def test_devmem(cfg) -> None:
+    """Test devmem RX: send from remote, receive on netkit guest."""
+    configure_nic(cfg)
+
+    flow_rule_id = set_flow_rule(cfg)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+
+    rx_cmd = (f"ip netns exec {cfg.netns.name} {cfg.bin_local}"
+              f" -l -f {cfg._nk_guest_ifname} -s {cfg.nk_guest_ipv6}"
+              f" -p {cfg.port} -t {cfg.nk_queue} -q 1 -v 7 -n")
+    socat = f"socat -u - TCP6:[{cfg.nk_guest_ipv6}]:{cfg.port}"
+
+    with bkg(rx_cmd, exit_wait=True) as ncdevmem_rx:
+        wait_port_listen(cfg.port, proto="tcp", ns=cfg.netns)
+        cmd(f"yes $(echo -e \x01\x02\x03\x04\x05\x06) | head -c 1K"
+            f" | {socat}",
+            host=cfg.remote, shell=True)
+
+    ksft_eq(ncdevmem_rx.ret, 0)
+
+
+def main() -> None:
+    """Run netkit devmem tests."""
+    with NetDrvContEnv(__file__, rxqueues=2) as cfg:
+        cfg.bin_local = path.abspath(
+            path.dirname(__file__) + "/ncdevmem"
+        )
+        cfg.port = rand_port()
+        ksft_run([test_devmem], args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()

-- 
2.52.0

