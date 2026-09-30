Received: from mta0.migadu.com (out-159.mta0.migadu.com [91.218.175.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED7F365A19
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733079; cv=none; b=WbJtIRYKAkdtWFdDzi5o+Jyjha2UHwOlvCvVTp3pSRcobrak4DWsWTWMRYuY6wx+lWXODFWuWqPjmV5OzvqQvksfCR16U17jC+bUml2rQyZRnkAayWEZrFshkhdWvv+JjBzUj0B4/YT9cKLdV8LngLH1UAHffDKn2nBmURPYcNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733079; c=relaxed/simple;
	bh=pXJjBll2OksCs5v5RCJJTMUx8qjQjSpHCJHcrN4RUsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEnwbxZw9YrpR8JCjOEOlU0HyZ8NE+tk3eDI8aoOAkgDDDkaky77dXGe3PWEqQvMHNO337NcB/L5H+1ATkR9n3NzY41QbtnGCpJM7bw0t38pPSf9H89IsyMX4DOzuZpsjunH1fYeR2QnDKybTWvTZefXi2q4b/szcQKUJNWAGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ndznKV4c; arc=none smtp.client-ip=91.218.175.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ndznKV4c"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pXJjBll2OksCs5v5RCJJTMUx8qjQjSpHCJHcrN4RUsg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790733075; v=1; x=1791337875;
 b=ndznKV4cdORMQUM73aKvJlxiHIxbnHSoaODCN2mr/eQqyPv9J2Lm2B3ei67HcEzfnRh+R8+f
 6yIdXAFZLhX1DA8dexWcu5kgR2wrtG8FUGb5nHzzpcXdqiTrLJPWnmrHnvenNt4cKbTk831M0Az
 WMdSPybfr32qTBMdMraZ7Ux0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f637a1d4c6846851;
	Wed, 30 Sep 2026 01:51:15 +0000
X-Mizu-Trace-ID: f637a1d4c6846851
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 30 Sep 2026 09:50:54 +0800
Subject: [PATCH net-next v3 3/6] netlink: specs: rt-route: add lwtunnel
 encap sub-message support
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ynl_rt_encap-v3-3-4106c21b9ee7@kylinos.cn>
References: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
In-Reply-To: <20260930-ynl_rt_encap-v3-0-4106c21b9ee7@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Define encap-type enum (LWTUNNEL_ENCAP_*) and add encap-data sub-message
keyed by encap-type. Add tunnel attribute sets (mpls, ip, ila, ip6, seg6,
bpf, seg6-local, rpl, ioam6, xfrm). This spec update depends on the kernel
side encap-type/data reorder patch.

Keep some nested option attributes as binary in this patch to simplify
review; they will be converted in follow-up patches.

Also add the Makefile to include uapi headers. Note the lwtunnel.h
is guarded by _UAPI_LWTUNNEL_H_.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 287 +++++++++++++++++++++++++++++-
 tools/net/ynl/Makefile.deps               |   9 +-
 2 files changed, 294 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 253037ea5176..dc842a786794 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -99,6 +99,58 @@ definitions:
         name: ra-withdrawn
         doc: A Router Advertisement withdrew the route with a zero
           lifetime.
+  -
+    name: encap-type
+    type: enum
+    name-prefix: lwtunnel-encap-
+    enum-name:
+    entries:
+      - none
+      - mpls
+      - ip
+      - ila
+      - ip6
+      - seg6
+      - bpf
+      - seg6-local
+      - rpl
+      - ioam6
+      - xfrm
+
+sub-messages:
+  -
+    name: encap-data
+    formats:
+      -
+        value: mpls
+        attribute-set: mpls-iptunnel
+      -
+        value: ip
+        attribute-set: lwtunnel-ip
+      -
+        value: ila
+        attribute-set: ila-attrs
+      -
+        value: ip6
+        attribute-set: lwtunnel-ip6
+      -
+        value: seg6
+        attribute-set: seg6-iptunnel
+      -
+        value: bpf
+        attribute-set: lwt-bpf
+      -
+        value: seg6-local
+        attribute-set: seg6-local
+      -
+        value: rpl
+        attribute-set: rpl-iptunnel
+      -
+        value: ioam6
+        attribute-set: ioam6-iptunnel
+      -
+        value: xfrm
+        attribute-set: lwt-xfrm
 
 attribute-sets:
   -
@@ -174,9 +226,12 @@ attribute-sets:
       -
         name: encap-type
         type: u16
+        enum: encap-type
       -
         name: encap
-        type: binary  # tunnel specific nest
+        type: sub-message
+        sub-message: encap-data
+        selector: encap-type
       -
         name: expires
         type: u32
@@ -277,6 +332,236 @@ attribute-sets:
       -
         name: fastopen-no-cookie
         type: u32
+  -
+    name: mpls-iptunnel
+    name-prefix: mpls-iptunnel-
+    header: linux/mpls_iptunnel.h
+    attributes:
+      -
+        name: dst
+        type: binary
+      -
+        name: ttl
+        type: u8
+  -
+    name: lwtunnel-ip
+    name-prefix: lwtunnel-ip-
+    header: linux/lwtunnel.h
+    attributes:
+      -
+        name: id
+        type: u64
+        byte-order: big-endian
+      -
+        name: dst
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: src
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: ttl
+        type: u8
+      -
+        name: tos
+        type: u8
+      -
+        name: flags
+        type: u16
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: opts
+        type: binary  # lwtunnel ip nest options
+  -
+    name: ila-attrs
+    name-prefix: ila-attr-
+    header: linux/ila.h
+    attributes:
+      -
+        name: locator
+        type: u64
+        byte-order: big-endian
+      -
+        name: identifier
+        type: u64
+      -
+        name: locator-match
+        type: u64
+        byte-order: big-endian
+      -
+        name: ifindex
+        type: s32
+      -
+        name: dir
+        type: u32
+      -
+        name: pad
+        type: pad
+      -
+        name: csum-mode
+        type: u8
+      -
+        name: ident-type
+        type: u8
+      -
+        name: hook-type
+        type: u8
+  -
+    name: lwtunnel-ip6
+    name-prefix: lwtunnel-ip6-
+    header: linux/lwtunnel.h
+    attributes:
+      -
+        name: id
+        type: u64
+        byte-order: big-endian
+      -
+        name: dst
+        type: binary
+        display-hint: ipv6
+      -
+        name: src
+        type: binary
+        display-hint: ipv6
+      -
+        name: hoplimit
+        type: u8
+      -
+        name: tc
+        type: u8
+      -
+        name: flags
+        type: u16
+        byte-order: big-endian
+      -
+        name: pad
+        type: pad
+      -
+        name: opts
+        type: binary  # lwtunnel ip nest options
+  -
+    name: seg6-iptunnel
+    name-prefix: seg6-iptunnel-
+    header: linux/seg6_iptunnel.h
+    attributes:
+      -
+        name: srh
+        type: binary
+      -
+        name: src
+        type: binary
+        display-hint: ipv6
+      -
+        name: table
+        type: u32
+  -
+    name: lwt-bpf
+    name-prefix: lwt-bpf-
+    header: linux/lwtunnel.h
+    attributes:
+      -
+        name: in
+        type: binary  # bpf prog
+      -
+        name: out
+        type: binary
+      -
+        name: xmit
+        type: binary
+      -
+        name: xmit-headroom
+        type: u32
+  -
+    name: seg6-local
+    name-prefix: seg6-local-
+    header: linux/seg6_local.h
+    attributes:
+      -
+        name: action
+        type: u32
+      -
+        name: srh
+        type: binary
+      -
+        name: table
+        type: u32
+      -
+        name: nh4
+        type: u32
+        byte-order: big-endian
+        display-hint: ipv4
+      -
+        name: nh6
+        type: binary
+        display-hint: ipv6
+      -
+        name: iif
+        type: u32
+      -
+        name: oif
+        type: u32
+      -
+        name: bpf
+        type: binary
+      -
+        name: vrftable
+        type: u32
+      -
+        name: counters
+        type: binary
+      -
+        name: flavors
+        type: binary
+  -
+    name: rpl-iptunnel
+    name-prefix: rpl-iptunnel-
+    header: linux/rpl_iptunnel.h
+    attributes:
+      -
+        name: srh
+        type: binary
+  -
+    name: ioam6-iptunnel
+    name-prefix: ioam6-iptunnel-
+    header: linux/ioam6_iptunnel.h
+    attributes:
+      -
+        name: mode
+        type: u8
+      -
+        name: dst
+        type: binary
+        display-hint: ipv6
+      -
+        name: trace
+        type: binary
+      -
+        name: freq-k
+        type: u32
+      -
+        name: freq-n
+        type: u32
+      -
+        name: src
+        type: binary
+        display-hint: ipv6
+  -
+    name: lwt-xfrm
+    name-prefix: lwt-xfrm-
+    header: linux/lwtunnel.h
+    attributes:
+      -
+        name: if-id
+        type: u32
+      -
+        name: link
+        type: u32
 
 operations:
   enum-model: directional
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index 1e746e25e2bc..3eee34e0efcf 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -45,7 +45,14 @@ CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
 CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
-CFLAGS_rt-route:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h)
+CFLAGS_rt-route:=$(call get_hdr_inc,_LINUX_ILA_H,ila.h) \
+	$(call get_hdr_inc,_LINUX_IOAM6_IPTUNNEL_H,ioam6_iptunnel.h) \
+	$(call get_hdr_inc,_LINUX_MPLS_IPTUNNEL_H,mpls_iptunnel.h) \
+	$(call get_hdr_inc,_LINUX_RPL_IPTUNNEL_H,rpl_iptunnel.h) \
+	$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
+	$(call get_hdr_inc,_LINUX_SEG6_IPTUNNEL_H,seg6_iptunnel.h) \
+	$(call get_hdr_inc,_LINUX_SEG6_LOCAL_H,seg6_local.h) \
+	$(call get_hdr_inc,_LWTUNNEL_H_,lwtunnel.h)
 CFLAGS_rt-rule:=$(call get_hdr_inc,__LINUX_FIB_RULES_H,fib_rules.h)
 CFLAGS_tc:= $(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_PKT_SCHED_H,pkt_sched.h) \

-- 
2.55.0

