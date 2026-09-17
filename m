Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552C43F081
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627003; cv=none; b=sZ/OWm7IWQ04uNmvpCic5HpAY617zyJr0biLADPIPnWLyuh5i6b0aBwsY8ahDpATJqdWNqhkwili5No0pRcHyaLwIhK29ts6ucFa/ug+pFvV/Ejg8S/0BOnVEspAwLsDko5NVkkfuxu+bJCkJxZxXJWPrVr7OU2WwQKQvPM8hTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627003; c=relaxed/simple;
	bh=y8Py39i/yspq4Bso5dXje7reSwruHUJQYifLxun11GQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7s0CJ5bdwVorzWQwlbUpU+wIvKJjO3dWEwpzvijploKHks3sdvmvhnaEPTCsELVEb8yzUVc3F9iCpM6YRwZHR1LS6ibWj2wUiYD3L6j7HSEFBGjmGqe/T8e3Lhm6mnlYTi0MgBgBIB9jp1dhsgE4diglHEz8W20dAD7uUSh6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AHrykdhX; arc=none smtp.client-ip=91.218.175.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AHrykdhX"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y8Py39i/yspq4Bso5dXje7reSwruHUJQYifLxun11GQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789627000; v=1; x=1790231800;
 b=AHrykdhXNs6lJD2reWT1qxcdYpumWCZlODVnQrfL8bzJdLVzA+abFtOawcWdhVvAVzAp/+w8
 SVHkbzZdV5PUybqy6Xnyw2pvQYOpHYU/EbufNGLX3iKAEFYJ7EBAP7ULZ3+T4DZazrgfUWYwtox
 ZSSHBzPr0WjEJNXRVcDygRBE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 79b33898e2639a0c;
	Thu, 17 Sep 2026 06:36:39 +0000
X-Mizu-Trace-ID: 79b33898e2639a0c
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 17 Sep 2026 14:35:38 +0800
Subject: [PATCH net-next 6/6] netlink: specs: rt-route: describe seg6-local
 actions, counters and flavors
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ynl_rt_encap-v1-6-fbbe6e680571@kylinos.cn>
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

Add SEG6 local actions enum. Replace binary counters/flavors in seg6-local
with nested seg6-local-cnt and seg6-local-flv.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 59 +++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 5e9537f7dfad..3929a877aa27 100644
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
@@ -484,6 +507,7 @@ attribute-sets:
       -
         name: action
         type: u32
+        enum: seg6-local-actions
       -
         name: srh
         type: binary
@@ -513,10 +537,12 @@ attribute-sets:
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
@@ -624,6 +650,35 @@ attribute-sets:
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

