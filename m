Received: from mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8EE46D2C0
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447880; cv=none; b=lEGkvc1m5ucTOaRlijaonpwyfiHpM2iU2DR+s65hXiwKQKyIGaanJcwrnF1uV2LygvqPIrTYed3m15d2ZX0faZem41HY+XhcRRyLmVo3oGuHaBv+zvexqZxOUfMyxdhg5E7hOO5wfsgOvQtaHSNF2vJcMJXabqLld3ZxvH4u29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447880; c=relaxed/simple;
	bh=NTRyTxRHG8F0/m6wgWwuN6NdB1Ih3Hf+reCm0hfOExo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPpLCCCMgW1Jk+Wp9t8sewoykV/ALLH2G9lrtjDakBEVA6obhch3Om6N6QW+FoMg61dqSxIP4Dh1SrXIEYWUPD31J+r/4KB77GB+6oO8o6zSjNZ6zrLTlKIz1cVZ4BqfLS45O6ToVOOfpgh6X2X0yNP4LJtzk3VtpXQ8a5qf4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G/eKUEyw; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G/eKUEyw"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NTRyTxRHG8F0/m6wgWwuN6NdB1Ih3Hf+reCm0hfOExo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791447876; v=1; x=1792052676;
 b=G/eKUEyw9FprIJ4gpszTeYh6V3YxtEY6EOpb18BKuQnF7EWGRi8FcnHPU8dLS+Hm/kPdKHd8
 gtEIiPWkUj4eIJffJ4gGnJVPxKK3GiRFPSoa0W2s2gwKFMmAu/VDdrTVHD3ajw5PR4rypAVLroj
 Dvb+7e9U5DWLwUpwmAL5LKf0=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 3bc7d44c8e0f29c1;
	Thu, 08 Oct 2026 08:24:36 +0000
X-Mizu-Trace-ID: 3bc7d44c8e0f29c1
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 16:24:04 +0800
Subject: [PATCH net-next v4 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ynl_rt_encap-v4-4-4ed2ccf7f949@kylinos.cn>
References: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
In-Reply-To: <20261008-ynl_rt_encap-v4-0-4ed2ccf7f949@kylinos.cn>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

Replace binary opts in lwtunnel-ip and lwtunnel-ip6 with a nested
lwtunnel-ip-opts set. Add attribute sets for geneve, vxlan, and erspan
IP options to match linux/lwtunnel.h.

Note the kernel encodes LWTUNNEL_IP_OPTS_GENEVE differently for requests
vs dumps. On the request path, the kernel iterates and reads one
CLASS/TYPE/DATA triplet per geneve option. On the dump path, the kernel
opens only one nested geneve option and writes a CLASS/TYPE/DATA triplet
for every option within it. Before there is a proper way to handle it,
I will just omit geneve options and use binary for it.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
For sashiko:

We don't need to add linux/lwtunnel.h for lwtunnel-ip-opts,
lwtunnel-ip-opt-vxlan and lwtunnel-ip-opt-erspan since the parent
one lwtunnel-ip already include it.
---
 Documentation/netlink/specs/rt-route.yaml | 45 +++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index dc842a786794..ea6711292c9b 100644
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
@@ -444,7 +445,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: seg6-iptunnel
     name-prefix: seg6-iptunnel-
@@ -562,6 +564,45 @@ attribute-sets:
       -
         name: link
         type: u32
+  -
+    name: lwtunnel-ip-opts
+    name-prefix: lwtunnel-ip-opts-
+    attributes:
+      -
+        name: geneve
+        type: binary
+      -
+        name: vxlan
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-vxlan
+      -
+        name: erspan
+        type: nest
+        nested-attributes: lwtunnel-ip-opt-erspan
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

