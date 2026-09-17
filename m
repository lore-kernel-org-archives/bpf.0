Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55444443C0F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626991; cv=none; b=A8/7zL0cnPEhvLoYEunREyz/kddWvbeqUcu5+lAKQ9zhIYcCbZvI8URvGDMy3/t0QorrHINtsqmzwgx0QPhsjaLwKeP30QFp1xzAdnEIv2IWcwtQ1lF+MlXtXQb0wMR1jTnW2Hf9prXpsOkKukl8hXzuEsCNNJgojp8bRD9Cy3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626991; c=relaxed/simple;
	bh=J+NNm1pkPjP+txuYq6Ee+FpmL9x8Jg1gXQIPtzOYHxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQ9BpAFLOez1a5SFGV1Qd8+aEnRReBeXMdCrLb8C5k18dAIYAvmKhZIC4dBBMPjmxJeJ7qBzveKXIbj0/JFp0+JBt3Wee+4KuRYvg8vM9M7fl2yrYYAwCmNvSZpN3/335XXko7OybkYPovagsGVVil3v+kITEJ1TWrvArm9Ed60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bVen5T5M; arc=none smtp.client-ip=91.218.175.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bVen5T5M"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J+NNm1pkPjP+txuYq6Ee+FpmL9x8Jg1gXQIPtzOYHxc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789626988; v=1; x=1790231788;
 b=bVen5T5MwhNIE70pH/09dG4zg43UDb9xB07jTj7maPv8TgDIQtBv4sMGLwFCxdK2kHOHNJyl
 3klXUh9g2P21CyI1SsrizHHnmo+J81EqUQj/ExNnXxkQ+OaNPZFQONxhdXDpeMpow85wHOrJUu+
 d+dc5loMpqzurv0tiGyd6AOs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9b6067e378413a3e;
	Thu, 17 Sep 2026 06:36:28 +0000
X-Mizu-Trace-ID: 9b6067e378413a3e
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 17 Sep 2026 14:35:36 +0800
Subject: [PATCH net-next 4/6] netlink: specs: rt-route: describe lwtunnel
 IP options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ynl_rt_encap-v1-4-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
In-Reply-To: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
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
 Documentation/netlink/specs/rt-route.yaml | 59 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 0e236da140dc..6030d7cb8d0d 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -375,7 +375,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: ila-attrs
     name-prefix: ila-attr-
@@ -438,7 +439,8 @@ attribute-sets:
         type: pad
       -
         name: opts
-        type: binary  # lwtunnel ip nest options
+        type: nest
+        nested-attributes: lwtunnel-ip-opts
   -
     name: seg6-iptunnel
     name-prefix: seg6-iptunnel-
@@ -555,6 +557,59 @@ attribute-sets:
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

