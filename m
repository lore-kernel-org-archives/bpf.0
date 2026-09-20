Received: from mta1.migadu.com (out-142.mta1.migadu.com [95.215.58.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE13E5EC2
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898840; cv=none; b=dMNrWtqmRCAtwLu2mIBS85Wt6Papibk5n2d/a3VcNZwWEj6iHrKpONGlUNZF+lysm1RyWj94hfx7hzZ68p7zot8oM61H3xsyYrD9LMVbbUawz/ldmv3fBZEJHRWNIlf2QI/0kVSz0ia5qbOdylIElZEHKGh8mxMVrifMiKRGWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898840; c=relaxed/simple;
	bh=SkOhf961FvRa1o4KrMZv9A+hJDOSCRZN5mUh5n/AvQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3NXDxq5NJbD351zU5LPVB6QVyajWh8fxv1uGpDZWplZLeQK/xHkzDP3Ms0vqRHxHZ2TY1QeaYDAfGV/1pBWiLkw3rFfdNoLvpxfX2ZjrtpLWbu5kZQ54k9P24NNAH9b7a2Tv6JDJ3keCtNmnMCrnzSLaTjmPCxmvvj+kFc+gNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gDdiXhnB; arc=none smtp.client-ip=95.215.58.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gDdiXhnB"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SkOhf961FvRa1o4KrMZv9A+hJDOSCRZN5mUh5n/AvQ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789898836; v=1; x=1790503636;
 b=gDdiXhnBsCOTjIDY1YaIzfTA9IfkJAYlxG6P59nCmDklVYGgYTAO7BiciM/2JqCOF2edGvo2
 GbK+//Nfofa859STofpkFyhCr46d83FS4HHRrzBySlEeVwcfRvge48tifmtr1EnsxwEMKvS4fpa
 qxb8nfxoZ8z2t9Ro6AmUj6PY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 34cfc2c7803b15d4;
	Sun, 20 Sep 2026 10:07:16 +0000
X-Mizu-Trace-ID: 34cfc2c7803b15d4
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Sun, 20 Sep 2026 18:06:39 +0800
Subject: [PATCH net-next v2 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-ynl_rt_encap-v2-4-c664a3e726f6@kylinos.cn>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
In-Reply-To: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Replace binary opts in lwtunnel-ip and lwtunnel-ip6 with a nested
lwtunnel-ip-opts set. Add attribute sets for geneve, vxlan, and erspan
IP options to match linux/lwtunnel.h.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 62 ++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 86fc52f856bf..4b12a8a58652 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -377,7 +377,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: ila-attrs
     name-prefix: ila-attr-
@@ -442,7 +443,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: seg6-iptunnel
     name-prefix: seg6-iptunnel-
@@ -560,6 +562,62 @@ attribute-sets:
       -
         name: link
         type: u32
+  -
+    name: lwtunnel-ip-opts
+    name-prefix: lwtunnel-ip-opts-
+    attributes:
+      -
+        name: geneve
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-geneve
+      -
+        name: vxlan
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-vxlan
+      -
+        name: erspan
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-erspan
+  -
+    name: lwtunnel-ip-opt-geneve
+    name-prefix: lwtunnel-ip-opt-geneve-
+    attributes:
+      -
+        name: class
+        type: u16
+        byte-order: big-endian
+      -
+        name: type
+        type: u8
+      -
+        name: data
+        type: binary
+        checks:
+          max-len: 127
+  -
+    name: lwtunnel-ip-opt-vxlan
+    name-prefix: lwtunnel-ip-opt-vxlan-
+    attributes:
+      -
+        name: gbp
+        type: u32
+  -
+    name: lwtunnel-ip-opt-erspan
+    name-prefix: lwtunnel-ip-opt-erspan-
+    attributes:
+      -
+        name: ver
+        type: u8
+      -
+        name: index
+        type: u32
+        byte-order: big-endian
+      -
+        name: dir
+        type: u8
+      -
+        name: hwid
+        type: u8
 
 operations:
   enum-model: directional

-- 
2.55.0

