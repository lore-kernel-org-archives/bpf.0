Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F033644CE
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773700169; cv=none; b=Gt2gGeCNq31bJ85Dij0O7ELx8AvN8Ubt0UNpk3IscRXEYD7BkDrHCARzuhjNCVEnuj7s35XsP/LBjq4sD6M93ytgyITuhBAIcUO7MWAlcGOlQzSC9UZ8VJcH4zuCwADsSm6Ohu80eAUyPX5Zt6x1AIhq3JUDFteC1mZDoh8uetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773700169; c=relaxed/simple;
	bh=gPQdSLHqgxDCRlTaUp4gDb596s3Bu8ry/823mecq5og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bJMpkV6Sr5TLrr/c1f08boXycBxSU+97PI7vT5409d+ngxbjAACi/XPwUHyWgCYMz184damVNlMn0va1YAmUjs8WxnZgQicOfeJ+gz3LCSgig/OJsh0HTm/qj1pHfGeJrB79qbOcu7Ubj0YTmS6E7s/AUI/kFJccW1v2xmqDcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIHoMSei; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIHoMSei"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a3e2e64f4so10823557b3.1
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773700164; x=1774304964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYnevcqjsWNhoFXHuzMgmlhvEe4roXm2EbEcJEFKLu8=;
        b=AIHoMSeieDYr+bk4oEBBPZCcyzXRFm2aq8681FdDcs8TNwx4yWrhn1TxluOrsbwM2l
         Leptb2DSSpAa/bmQCnfy2QlyiqhkqDnFwis3t0TYLCKYLckc4w0bfU5zSLTx3EzqAwNw
         1jECWiEwiGTUjci0NwlcA+29RZNi65i51pU+JIJLSzzcfEHunbu16mGkJl0t1kyc7mqn
         4Y0qcapJCWSkgfQrEEoHjwKTMM5M8/OgLK1SWy8VbWkF9TQE+4HENFS9IPh2A58WOoJx
         6rwv6F1KmxQmop+Stn0red1lwOXHwTpi9+uzGsS4avpz1hD9/B10rv7tI9OwnMBAkts1
         IvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773700164; x=1774304964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYnevcqjsWNhoFXHuzMgmlhvEe4roXm2EbEcJEFKLu8=;
        b=akLPh7+ESyNNpAEbWvddNKoISrETGSeQWBpqYE+pvNx9sPMS02ojM5aNxOW1htjPkL
         P2+nTBdJC8OI8J1vTrME8STsOOMf1t1i7++7gy1xAN9O3oFm0x4f7FFz+iyrzEHMi2w9
         jG2Sortx4WxpVW+s6QBw1EYGXXEXG/VYKA/loumzblGL1LIFQc2+9jm+1EG7MHgIkCZP
         T0AbQworBnsakZRmVqoPS4TAW9WMO5A4NvJgyTNiS0RXvaN/b+X40YWFnDoBF0yJCeTF
         jT3YRdZjQdhn5n21sNunitdMiH7y1ZGDbLahudywEyt26eYqha0eoxbfHaagNXTv/TQG
         nuqg==
X-Forwarded-Encrypted: i=1; AJvYcCXx9NVdf47MCrzymeld/bTapmPAM/UnSLuAV6Qydx2AJTGOEHUSxKLXgzZU7NIiqQ3DtdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0kMSahjhZqocz1PqIUmg5YWl2CQyLzXha6I0ANqy7zYablRx
	76sZmjzUPhksWxrrKVj2PgT/gLrXka6ZA1WyHFHIOD5ZguMvJvMLCmtr
X-Gm-Gg: ATEYQzxfmFIaAlxY3qEmMGbFLHS2YyQ5WppzGMvB1ula3EO2Q85dKUKBmDUr3wYXkmp
	FUNoyUgfdjy5g+Epd4GAr4R8d5dvggLJdMLHKv2bb/ucOsRkVZYGv58fUYKMVOggS3OW+CIk3z5
	/n1ppAdxNRXAK6iLiilsPIuuMN7Lxh2HoT1lxsWoVVg1Sz8hOhSCYfnfBscVQmFxGjIpUCkf3tg
	K8fNi1gdzNwlHRkJCSBsWlvXnf1uGjMooxZ9+OIuY4e82k1ges75GkeotsK0Dbt8/YUa/aHYGb3
	z+0j1uIvTdCdJ6tqjGvtIXsYvmk/R/oR+VY5pjN18GGe6HsK90jDYoD8QZTLcpc5ACKdXGO+5IY
	Zm/2z8rFbGC+CGaY98UrcubVa3vaorR4GXfrp3pxhcctk+ZKFn70vG9IFu4/K0yFxx2bneEBVsC
	al3lIFRApopFKdj0geuvxd
X-Received: by 2002:a05:690c:201c:b0:79a:55f5:a3fa with SMTP id 00721157ae682-79a55f5ecabmr26736657b3.20.1773700164261;
        Mon, 16 Mar 2026 15:29:24 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee5757sm96813577b3.31.2026.03.16.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:29:24 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 16 Mar 2026 15:29:15 -0700
Subject: [PATCH net-next 4/6] selftests: drv-net: add primary RX redirect
 support to NetDrvContEnv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-4-b53c8cd72b23@meta.com>
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

Add a primary_rx_redirect parameter to NetDrvContEnv that enables a BPF
tc program (nk_primary_rx_redirect.bpf.c) on the primary netkit ingress.
This program redirects traffic to the physical NIC via
bpf_redirect_neigh(), while letting ICMPv6 through for neighbor
discovery.

This will be used by the devmem netkit TX tests where the nk peer is
sending to the nk primary for redirection to the physical NIC.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/drivers/net/hw/.gitignore  |  1 +
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    | 41 ++++++++++++++++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  | 39 +++++++++++++++++++-
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 46540468a775..3e5c51f8e1c7 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 iou-zcrx
 ncdevmem
+nk_primary_rx_redirect
 toeplitz
diff --git a/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
new file mode 100644
index 000000000000..fe3c127a4fd0
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+#define IPPROTO_ICMPV6 58
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+volatile __u32 phys_ifindex;
+
+SEC("tc/ingress")
+int nk_primary_rx_redirect(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct ethhdr *eth;
+	struct ipv6hdr *ip6h;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (eth->h_proto != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (ip6h->nexthdr == IPPROTO_ICMPV6)
+		return TC_ACT_OK;
+
+	return bpf_redirect_neigh(phys_ifindex, NULL, 0, 0);
+}
+
+char __license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index 08e90448f48d..e124b9c7c95c 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -327,12 +327,13 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, **kwargs):
+    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
         self._nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
+        self._primary_rx_redirect_attached = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
         self._init_ns_attached = False
@@ -387,8 +388,14 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         self._setup_ns()
         self._attach_bpf()
+        if primary_rx_redirect:
+            self._attach_primary_rx_redirect_bpf()
 
     def __del__(self):
+        if self._primary_rx_redirect_attached:
+            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            self._primary_rx_redirect_attached = False
+
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
             self._tc_attached = False
@@ -450,6 +457,8 @@ class NetDrvContEnv(NetDrvEpEnv):
         ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
         ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
 
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via {self.addr_v['6']}", host=self.remote)
+
     def _tc_ensure_clsact(self):
         qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
         for q in qdisc:
@@ -495,3 +504,31 @@ class NetDrvContEnv(NetDrvEpEnv):
         value = ipv6_bytes + ifindex_bytes
         value_hex = ' '.join(f'{b:02x}' for b in value)
         bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")
+
+    def _attach_primary_rx_redirect_bpf(self):
+        """Attach BPF redirect program on the primary netkit ingress."""
+        bpf_obj = self.test_dir / "nk_primary_rx_redirect.bpf.o"
+        if not bpf_obj.exists():
+            raise KsftSkipEx("Primary RX redirect BPF prog not found")
+
+        cmd(f"tc qdisc add dev {self._nk_host_ifname} clsact")
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+            f" bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._primary_rx_redirect_attached = True
+
+        filters = json.loads(
+            cmd(f"tc -j filter show dev {self._nk_host_ifname} ingress").stdout)
+        redirect_prog_id = None
+        for bpf in filters:
+            if 'options' not in bpf:
+                continue
+            if bpf['options']['bpf_name'].startswith('nk_primary_rx_redirect'):
+                redirect_prog_id = bpf['options']['prog']['id']
+                break
+        if redirect_prog_id is None:
+            raise Exception("Failed to get primary RX redirect BPF prog ID")
+
+        bss_map_id = self._find_bss_map_id(redirect_prog_id)
+        phys_ifindex_bytes = self.ifindex.to_bytes(4, byteorder='little')
+        value_hex = ' '.join(f'{b:02x}' for b in phys_ifindex_bytes)
+        bpftool(f"map update id {bss_map_id} key hex 00 00 00 00 value hex {value_hex}")

-- 
2.52.0

