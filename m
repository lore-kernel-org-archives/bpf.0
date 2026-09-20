Received: from mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B8F3F3273
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898855; cv=none; b=SXFQoX9sEmqZLbXn90PXjO2tCrFnudSJrqunT0VlB5OTgL9p/NjJlg2wxRtmnS5D+8Vsptn2VeBa24JQmZ6m74uURnsaZV3nlXTheoXorDtEMdHCxOZaxURDD6FkAlOifIi2XHV8Nf1allxn6Jegd5JE0uc8FWEKcLc/03P50lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898855; c=relaxed/simple;
	bh=r74M24yyCfstLi5sdyYdfj7aY4inWJJgNMM8Vg/Ti20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPREhG/JarfKIH9lzV7NqGceB0SGEYI1XCT2fHsxFSa6UHwmY3xbECu/0rF6LAsiScIjmv+PIK0aEXZS61WyuvC/i2mh8zdwvGQadkKtRP8YX5XJ9F4sC+D/IW5SLbWEc2K95rclTjjXy/TD2wqxB0M+kNbkYh/u4vB7j3RIYN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XA3ckq4z; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XA3ckq4z"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=r74M24yyCfstLi5sdyYdfj7aY4inWJJgNMM8Vg/Ti20=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789898850; v=1; x=1790503650;
 b=XA3ckq4za7PgX4Ve8VK70Bz9TSVkyKqkN1sgwWw0tlq/EAHm82T06gBCQegR8e5APPzXEqXR
 51yQb13ljw7jixyd8u1FSDosXRIQc5Pat+yodb46RDWWMoyQVkWCH6kziJEGmcTrzEcMNE4BEtX
 lJzsiC52M6bIuzVuu+NB7j0c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b7e704c66a0f4609;
	Sun, 20 Sep 2026 10:07:30 +0000
X-Mizu-Trace-ID: b7e704c66a0f4609
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Sun, 20 Sep 2026 18:06:41 +0800
Subject: [PATCH net-next v2 6/6] netlink: specs: rt-route: describe
 seg6-local actions, counters and flavors
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-ynl_rt_encap-v2-6-c664a3e726f6@kylinos.cn>
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

Add SEG6 local actions enum. Replace binary counters/flavors in seg6-local
with nested seg6-local-cnt and seg6-local-flv.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 59 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 4a3953c9e978..711c667bbc43 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -116,6 +116,29 @@ definitions:
       - rpl
       - ioam6
       - xfrm
+  -
+    name: seg6-local-actions
+    type: enum
+    name-prefix: seg6-local-action-
+    enum-name:
+    entries:
+      - unspec
+      - end
+      - end-x
+      - end-t
+      - end-dx2
+      - end-dx6
+      - end-dx4
+      - end-dt6
+      - end-dt4
+      - end-b6
+      - end-b6-encap
+      - end-bm
+      - end-s
+      - end-as
+      - end-am
+      - end-bpf
+      - end-dt46
 
 sub-messages:
   -
@@ -488,6 +511,7 @@ attribute-sets:
       -
         name: action
         type: u32
+        enum: seg6-local-actions
       -
         name: srh
         type: binary
@@ -518,10 +542,12 @@ attribute-sets:
         type: u32
       -
         name: counters
-        type: binary
+        type: nest
+        nested-attributes: seg6-local-cnt
       -
         name: flavors
-        type: binary
+        type: nest
+        nested-attributes: seg6-local-flv
   -
     name: rpl-iptunnel
     name-prefix: rpl-iptunnel-
@@ -633,6 +659,35 @@ attribute-sets:
       -
         name: name
         type: string
+  -
+    name: seg6-local-cnt
+    name-prefix: seg6-local-cnt-
+    attributes:
+      -
+        name: pad
+        type: pad
+      -
+        name: packets
+        type: u64
+      -
+        name: bytes
+        type: u64
+      -
+        name: errors
+        type: u64
+  -
+    name: seg6-local-flv
+    name-prefix: seg6-local-flv-
+    attributes:
+      -
+        name: operation
+        type: u32
+      -
+        name: lcblock-bits
+        type: u8
+      -
+        name: lcnode-fn-bits
+        type: u8
 
 operations:
   enum-model: directional

-- 
2.55.0

