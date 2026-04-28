Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF23A451F
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777416150; cv=none; b=Rsk1DJTp/r8UmOCf2KIef5bV4gQ0Kdw9a8zdpsMe7MRJlu360uoVL6PYFnleJlZEv3w+eklR886vX8+nappgL2jlQdjXn3rHgvNk7MXD2W5gSM/uMwSMK3qQAdT4W++lvmGbT9+aadu9rIJovo1dejNZMc7QfnJJeHxI8fd8sfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777416150; c=relaxed/simple;
	bh=vvD7ZVWeDph/PmXrgLs3xxE6chJh2m9PrzPft/75fXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9WcHGrD6I+UsEGBKe/5dLFK5gYJ+NXkPYjU7jlrrOCYXDzFgPVP9b0NnZTX6ekbpPzjaDCZfxG8ZPKkECZ5m9WgpRm9wi/cUubbY+bU+HvZ9F7lnYtbMT/rgus+nvU/tBvOQtxWnbN6ixWeJkucht9jjQ4ZHlzKnurHXeCuupY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvfjK8Dz; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvfjK8Dz"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651d692e833so12601673d50.3
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777416145; x=1778020945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inxNSTovjyLa8xw5MJR4WDKrVFR+ca5kQUy/85838Ic=;
        b=KvfjK8DzIfz8LKykKdKroR4ObY9Dy9Ejx+tPX4Y3wTsa5GqusCYy/qtt719Q6GDWBL
         1VbZ2xUhQa/yqL/nsjPTDM9leXgfrYnVUOHNKtzOKWtXI449vFzvWREMOzzm3THekhfp
         GX7guIvPfzTcyUV3BvbgB7NBr+pJf2wftDn9W3jntmu3i31puj6VvGyNls5uzYZdtFib
         KjkykqHeZ/4oC0zu3AVjHiS0hVToY0t4JCguv4P/aBSKFflqJKnsXxfH7cZ8gQYjJKrP
         fVnsYn5ViBOw46SaVyl71rHmwZMC+DzVfLdswuvLJomBsTUNHWd47zdKVan2o+YvO7rS
         ndxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777416145; x=1778020945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=inxNSTovjyLa8xw5MJR4WDKrVFR+ca5kQUy/85838Ic=;
        b=izRXhZ3RlGnFJcNMfEf3Whut21AFT0XP5vgKSYcmnitTi51STs++z/chzQ22q5jz8d
         NVFuzXMxkpk6VAmyCP7pa6yKsUQZVLdbUAbiRcHBRLon+HMv+dydh9SljBA4qhKG/4Be
         Dz0PIN2xlcIL8OP8UNT/EPn0fdVIiO0m6Trs46h4Uj+vvtknCppTfj3eHtrfzTdrAIH4
         vHlkzrFtW2G1bpu8E7AZFUQcNRAc1U6scWHKDgqVcuyUiHMN+DuGKVol27ClQDJaJL2M
         YQF9rMvZ6YCAxzoE2Yx/DLJTcRGXw7/oaIaQmyO/M0/jhWVVwp6I1eIunLUqLp+KgETz
         QGBw==
X-Forwarded-Encrypted: i=1; AFNElJ9WB2/LtvmNs5dKkCPbmZhv9JI3ifHE4HXfRF5NGXrEjOMbkFTLj+vgtFI0QxRtFPHMkiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4gqtD1cDxbJphhiQ9O4QQvnOTZm2Hsdr/1kj2jR8nRy8ZsNI
	oA6EEaDM8RUVNMFkk3qd4K4QeAIFyQcMc89UleBEDjwgYJIAXi1Fmh4j
X-Gm-Gg: AeBDievzt9Bs+whLLNMWNnembby3NdWf+loLiz+9xr+MSCWB0B2SCTPxbLzchRALlDY
	eGVSDvpKZQdoWMexKi6PK4SPpBfiGJA/hKkYO87BjOXWuQFPcSm44cNckYFTOClMQHjW+GW6uk8
	mmerYvbeBIco0k0+YwP7xQqEyXIJSAd0qA/f8AIk3+z/XdNRbRhlnJfP2TQEcsjjFltztpplo7j
	KZ/lgFqzRnVv5Jg8yOINmL5ru8gpHwiLySA+GktOUbXMU0JZd9PE2mixoZhVjq55TKhwR2qs80z
	AXkK6kTK+InGiehaqrFnnydAYVJOfp/50XtXrr0RWnGbHDqfyAkZO1OtBZtk94ktI6lWmSSUdL2
	EpLBUXowpX/NB7xk96Ch3RxykChjAX9p3Q0lar70L5ZUSLIxs1mKox0XVRoodifvO3yK83jlH9F
	QdjQOAlPJV171Ydz67fl8W6/yciwWHUr6Op+Gd3kXLEZw=
X-Received: by 2002:a05:690e:d5c:b0:654:1261:8b50 with SMTP id 956f58d0204a3-65beed80fecmr4987018d50.19.1777416145443;
        Tue, 28 Apr 2026 15:42:25 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:27::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff4fe796sm326550d50.7.2026.04.28.15.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:42:25 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 28 Apr 2026 15:42:07 -0700
Subject: [PATCH net-next 10/11] selftests: drv-net: add primary_rx_redirect
 support to NetDrvContEnv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tcp-dm-netkit-v1-10-719280eba4d2@meta.com>
References: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
In-Reply-To: <20260428-tcp-dm-netkit-v1-0-719280eba4d2@meta.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, 
 Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Joshua Washington <joshwash@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

When sending from a namespace that has access to a netkit device with a
leased queue, the nk primary in the host namespace needs to redirect its
RX to the physical device. This patch adds that redirection bpf program
and teaches the harness to install it.

Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
interface.  The program redirects non-ICMPv6 IPv6 packets to the
physical NIC via bpf_redirect_neigh(), with the physical ifindex
configured via the .bss map.

Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
other BPF attachment methods can use it.

Also add an IPv6 host route on the remote endpoint for the netkit guest
IP via the physical NIC address, so the remote can send packets that
traverse the redirect path to the guest.

Assisted-by: Claude Code:claude-sonnet-4-6
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    | 41 +++++++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  | 67 ++++++++++++++++++----
 2 files changed, 96 insertions(+), 12 deletions(-)

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
index 24ce122abd9c..d569d01ef791 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -336,15 +336,17 @@ class NetDrvContEnv(NetDrvEpEnv):
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
+        self._remote_route_added = False
         self._old_fwd = None
         self._old_accept_ra = None
 
@@ -396,8 +398,14 @@ class NetDrvContEnv(NetDrvEpEnv):
 
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
@@ -406,6 +414,11 @@ class NetDrvContEnv(NetDrvEpEnv):
             cmd(f"tc qdisc del dev {self.ifname} clsact")
             self._tc_clsact_added = False
 
+        if self._remote_route_added:
+            cmd(f"ip -6 route del {self.nk_guest_ipv6}/128",
+                host=self.remote, fail=False)
+            self._remote_route_added = False
+
         if self._nk_host_ifname:
             cmd(f"ip link del dev {self._nk_host_ifname}")
             self._nk_host_ifname = None
@@ -459,6 +472,9 @@ class NetDrvContEnv(NetDrvEpEnv):
         ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self._nk_guest_ifname} nodad", ns=self.netns)
         ip(f"-6 route add default via fe80::1 dev {self._nk_guest_ifname}", ns=self.netns)
 
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via {self.addr_v['6']}", host=self.remote)
+        self._remote_route_added = True
+
     def _tc_ensure_clsact(self):
         qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
         for q in qdisc:
@@ -476,6 +492,15 @@ class NetDrvContEnv(NetDrvEpEnv):
                 return (bpf['pref'], bpf['options']['prog']['id'])
         raise Exception("Failed to get BPF prog ID")
 
+    def _find_bss_map_id(self, prog_id):
+        """Find the .bss map ID for a loaded BPF program."""
+        prog_info = bpftool(f"prog show id {prog_id}", json=True)
+        for map_id in prog_info.get("map_ids", []):
+            map_info = bpftool(f"map show id {map_id}", json=True)
+            if map_info.get("name", "").endswith("bss"):
+                return map_id
+        raise Exception(f"Failed to find .bss map for prog {prog_id}")
+
     def _attach_bpf(self):
         bpf_obj = self.test_dir / "nk_forward.bpf.o"
         if not bpf_obj.exists():
@@ -487,17 +512,7 @@ class NetDrvContEnv(NetDrvEpEnv):
         self._tc_attached = True
 
         (self._bpf_prog_pref, self._bpf_prog_id) = self._get_bpf_prog_ids()
-        prog_info = bpftool(f"prog show id {self._bpf_prog_id}", json=True)
-        map_ids = prog_info.get("map_ids", [])
-
-        bss_map_id = None
-        for map_id in map_ids:
-            map_info = bpftool(f"map show id {map_id}", json=True)
-            if map_info.get("name").endswith("bss"):
-                bss_map_id = map_id
-
-        if bss_map_id is None:
-            raise Exception("Failed to find .bss map")
+        bss_map_id = self._find_bss_map_id(self._bpf_prog_id)
 
         ipv6_addr = ipaddress.IPv6Address(self.ipv6_prefix)
         ipv6_bytes = ipv6_addr.packed
@@ -505,3 +520,31 @@ class NetDrvContEnv(NetDrvEpEnv):
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

