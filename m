Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF9257459
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 01:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548710; cv=none; b=R81rGM9TOA27D+iN9HIt0w5rDpx20lTjJG6uk/543c6agJi5S7nRC5gJe//JDJwO1LuP4slBp3jHUWnjJfGB4oZW7rXNRKy8RLbCrFMxkgSISYS04v2jevN59MzlcvoJDcFCZyHL+X5Lu3Wg0lTJRjsSVEgqAggQy0rhQVSDinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548710; c=relaxed/simple;
	bh=NIFxo58WU7UBXQHue+Nqgz11CnJWJPb56dm0ByE+m28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ECli0zq40oK4l2c8sGoMfyNsykk/+1kHOKv4uf3+YXYSn0t1tp0CShitr3wkucuKxzodZog46z0/uOdjxh0m0NwtVXBtcDapicJa4g1lNHgWeaaq2DWLmVx6oJLcLovXT4+fogdmF33zWHaa9SUXd90ckd2/pvcQfSUN4uU1FD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s4HZMEfY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4HZMEfY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7b37d84a6b3so48875067b3.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 18:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778548703; x=1779153503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRfnkF5KMv3rIjUaPyvMS+cs72A3bTtl7ISDWE3Dd4I=;
        b=s4HZMEfYo8ce0AIKjG+AOPyBenF/E7+VcVWrV4i7JoCTkQqk0k81CMSaTdzTk0vjaJ
         dhJk/OzPq6a7DFKUkIKclqJaj+Y+wTyt0xDtQ/FlnV2izdQnJC95I9Gbp1+TuUb/SJoQ
         C//n0Baj/e6kltrCmqyA3+eOXTv+SXRwjoMEQ6EZpijo8Ptkq876qLLW9iF5KVgvaFl/
         HTm4kfYOdumk0MZqw7/2+VW52Grjvl7UIY0XVfSMDuKGvGbKe6/uxWeeydYE06r/5xTo
         4yIgc+bnEMkZcoLqORg8xeYlPrZbyTFLHrtAP4+C5PWXQT4aOzpq9v4X00Ms607d4tLY
         8Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778548703; x=1779153503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RRfnkF5KMv3rIjUaPyvMS+cs72A3bTtl7ISDWE3Dd4I=;
        b=WtOT4mgLEs/XpzRS+eGVlRNieap0VmiaU1f9OlQ/+xpNuOGgmllXFXFhPqIqjHcv6E
         nWDEeI6pr72A90W7Lgumz2hirG5ARVFsS6mUyprF8cNQAqnz/Jrwfbr/5j+CmMPdkwQI
         mHodo0PilKk/TEpwrE0jZVa5OL0Bh4uPzGbKEhg9tNfqO4nrxDUZGZBDxoUqletpb/Z+
         CWaknqnWXXIGYRupz2WLxM5mm2jXBbxwOQpgiiTZRo0jFNC8hEjm5ybCczLWGGMfSbZw
         cPFd9ftCxIeRtDN2pnYw+bveejMS5fg7bso5a3OmGvytBU04tSUGPKdo4kp2kh9xA3jc
         7kkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QKB7w9FZ8Dl1GINASTzlgjeODzpRCJapqRTGyhmkTvKDRv8ocValKzcYYLsfffKJEz+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMJbKU7yZcM7x9NNwG0eDgmjYdc4toxI6LmeECGtSoFuESKqL
	8e/wHW325On87vQ2YSfYOYL796VuQNw7+nhUQOxbT976/koTTqy/TIC7
X-Gm-Gg: Acq92OFsA/ENBXtXGysndYrR5WIYeosjkpvK1QATmMpeYEj6R4opm0alVTVjFMxvXMS
	Eg2vd/rxo3Zr8WxHgdjJLvlQQl6hzOlUY4oQ6bJwqG/ipnQZmDg9l2dps/d4AmL0gIqvPtjK4pU
	A7hYxhTBEXoVnpGvW0yEMsBvbZAkViE4GH1OHjBsbMFnsIPM4i+Ll1Ykg5Fwb47N8rPcYg0RXMH
	OMF5sPDP0mN/ykyoEXejYAOwtx0qnpWGo51goXoC+ErataGY5D4En2oPL4DgBNhqPQTztf5BTvX
	yjQ2Lbej2jV6MULwUu0OzWIwDH8hJbBXON9X8xqv+yCVkLOAHQG0HsAuVnwn2qI/4H4yi1tvvVG
	E8/vz3FEb8MLN7wwXVNKo2EM44AybVsGYUKVNmmLRAGwfeFJPpv67ZfotED0n6vlp/kVbOdXY8a
	Q7sM1JukG79u9fglI+SwHv0Q==
X-Received: by 2002:a05:690c:6989:b0:7bd:a6ea:c508 with SMTP id 00721157ae682-7c104dab240mr107891457b3.24.1778548702816;
        Mon, 11 May 2026 18:18:22 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665274ffsm159673107b3.6.2026.05.11.18.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 18:18:22 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 11 May 2026 18:18:01 -0700
Subject: [PATCH net-next v4 7/8] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tcp-dm-netkit-v4-7-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
In-Reply-To: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
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
 Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
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
Cc: dw@davidwei.uk, sdf.kernel@gmail.com, mohsin.bashr@gmail.com, 
 willemb@google.com, jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, 
 wang.yaxin@zte.com.cn, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
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
interface. The program redirects non-ICMPv6 IPv6 packets to the physical
NIC via bpf_redirect_neigh(), with the physical ifindex configured via
the .bss map. ICMPv6 is left on the host's netkit primary so IPv6
neighbor discovery still work locally.

Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
other BPF attachment methods can use it.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- nk_primary_rx_redirect.bpf.c: add header includes to avoid hardcoding
  values
- update commit message explaining why ICMP is passed through
- env.py: re-use _tc_ensure_clsact() (had to add ifname paramater)
- env.py: gate the remote IPv6 host route install on primary_rx_redirect
  by moving it from _setup_ns() into _attach_primary_rx_redirect_bpf()
---
 .../drivers/net/hw/nk_primary_rx_redirect.bpf.c    | 39 +++++++++
 tools/testing/selftests/drivers/net/lib/py/env.py  | 93 +++++++++++++++++-----
 2 files changed, 114 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
new file mode 100644
index 000000000000..46ff494b23de
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_primary_rx_redirect.bpf.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ipv6.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
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
index 409b41922245..af8e1de8ed7b 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -336,15 +336,18 @@ class NetDrvContEnv(NetDrvEpEnv):
               +---------------+
     """
 
-    def __init__(self, src_path, rxqueues=1, **kwargs):
+    def __init__(self, src_path, rxqueues=1, primary_rx_redirect=False, **kwargs):
         self.netns = None
         self._nk_host_ifname = None
         self.nk_guest_ifname = None
         self._tc_clsact_added = False
         self._tc_attached = False
+        self._primary_rx_redirect_attached = False
+        self._primary_rx_redirect_clsact_added = False
         self._bpf_prog_pref = None
         self._bpf_prog_id = None
         self._init_ns_attached = False
+        self._remote_route_added = False
         self._old_fwd = None
         self._old_accept_ra = None
 
@@ -396,8 +399,18 @@ class NetDrvContEnv(NetDrvEpEnv):
 
         self._setup_ns()
         self._attach_bpf()
+        if primary_rx_redirect:
+            self._attach_primary_rx_redirect_bpf()
 
     def __del__(self):
+        if self._primary_rx_redirect_attached:
+            cmd(f"tc filter del dev {self._nk_host_ifname} ingress", fail=False)
+            self._primary_rx_redirect_attached = False
+
+        if self._primary_rx_redirect_clsact_added:
+            cmd(f"tc qdisc del dev {self._nk_host_ifname} clsact", fail=False)
+            self._primary_rx_redirect_clsact_added = False
+
         if self._tc_attached:
             cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}")
             self._tc_attached = False
@@ -406,6 +419,11 @@ class NetDrvContEnv(NetDrvEpEnv):
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
@@ -459,13 +477,19 @@ class NetDrvContEnv(NetDrvEpEnv):
         ip(f"-6 addr add {self.nk_guest_ipv6}/64 dev {self.nk_guest_ifname} nodad", ns=self.netns)
         ip(f"-6 route add default via fe80::1 dev {self.nk_guest_ifname}", ns=self.netns)
 
-    def _tc_ensure_clsact(self):
-        qdisc = json.loads(cmd(f"tc -j qdisc show dev {self.ifname}").stdout)
+    def _tc_ensure_clsact(self, ifname=None):
+        """Ensure a clsact qdisc exists on @ifname.
+
+        Returns True if this call added the qdisc, otherwise returns False.
+        """
+        if ifname is None:
+            ifname = self.ifname
+        qdisc = json.loads(cmd(f"tc -j qdisc show dev {ifname}").stdout)
         for q in qdisc:
             if q['kind'] == 'clsact':
-                return
-        cmd(f"tc qdisc add dev {self.ifname} clsact")
-        self._tc_clsact_added = True
+                return False
+        cmd(f"tc qdisc add dev {ifname} clsact")
+        return True
 
     def _get_bpf_prog_ids(self):
         filters = json.loads(cmd(f"tc -j filter show dev {self.ifname} ingress").stdout)
@@ -476,28 +500,28 @@ class NetDrvContEnv(NetDrvEpEnv):
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
             raise KsftSkipEx("BPF prog not found")
 
-        self._tc_ensure_clsact()
+        if self._tc_ensure_clsact():
+            self._tc_clsact_added = True
         cmd(f"tc filter add dev {self.ifname} ingress bpf obj {bpf_obj}"
             " sec tc/ingress direct-action")
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
@@ -505,3 +529,36 @@ class NetDrvContEnv(NetDrvEpEnv):
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
+        if self._tc_ensure_clsact(self._nk_host_ifname):
+            self._primary_rx_redirect_clsact_added = True
+        cmd(f"tc filter add dev {self._nk_host_ifname} ingress"
+            f" bpf obj {bpf_obj} sec tc/ingress direct-action")
+        self._primary_rx_redirect_attached = True
+
+        ip(f"-6 route add {self.nk_guest_ipv6}/128 via {self.addr_v['6']}",
+           host=self.remote)
+        self._remote_route_added = True
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
2.53.0-Meta

