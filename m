Received: from mta1.migadu.com (out-18.mta1.migadu.com [95.215.58.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFA36B907
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733090; cv=none; b=r+/O8ugK4Au3jWu7H835iQIXGiIHHknJxn6s/561zBKcXrKdb1bw+Jj5gWEktmEW0zmnbiNV7NERi1LNfrDVSZLki7AIntBVRfFv67lN7/Oj4MFFfg+c3DTEpoEV8c9NorHux4uz9v6OnL/3thivVhBuDmZ98nrc3FNXJC6xo4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733090; c=relaxed/simple;
	bh=qOFk/G/6vq5TjaCi32Irwnef+xgEl3KejhukT2/1lGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=InrgZsC5aDD86e2Bwj9C9hAXk7kFwky2zwALrEbOeRu/exMJ33CKU2zyOGPPg7fw1qGINga5f4s/TVmDzot6//1406siNqRHbpOXKjwcNBIL8wiTJl2PlBfK+m4A95KLekSQbGy8x7rHjyyat2ilocOB8WJNNlwmp6uORCaoNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G1tpEwcK; arc=none smtp.client-ip=95.215.58.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G1tpEwcK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qOFk/G/6vq5TjaCi32Irwnef+xgEl3KejhukT2/1lGQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790733085; v=1; x=1791337885;
 b=G1tpEwcKsptEvEEYy3jj4tRvodocg1lUqInST3qI7f0x64wBWZlE4AVaAWuIg3dKMKrXnRfd
 9QchpgmxOgD1oL+aJDGMcfarhuoY5w3uHCTRwvPEKugp7BB4pyEmrT3sRPUXU+sjOwSAEodXZg3
 EyiUfFOXI31wwG4A9CAAMEaE=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 366241183f6c242f;
	Wed, 30 Sep 2026 01:51:25 +0000
X-Mizu-Trace-ID: 366241183f6c242f
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 30 Sep 2026 09:50:57 +0800
Subject: [PATCH net-next v3 6/6] netlink: specs: rt-route: describe
 seg6-local attrs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ynl_rt_encap-v3-6-4106c21b9ee7@kylinos.cn>
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

Add SEG6 local actions enums, seg6-local-flv-ops flags.

Replace binary bpf/counters/flavors in seg6-local with
nested seg6-local-bpf, seg6-local-cnt and seg6-local-flv.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 93 ++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index afec0375661f..0260fca398d2 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -116,6 +116,45 @@ definitions:
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
+  -
+    name: seg6-local-flv-ops
+    type: flags
+    name-prefix: seg6_local_flv_op-
+    enum-name:
+    entries:
+      -
+        name: unspec
+      -
+        name: psp
+      -
+        name: usp
+      -
+        name: usd
+      -
+        name: next-csid
 
 sub-messages:
   -
@@ -490,6 +529,7 @@ attribute-sets:
       -
         name: action
         type: u32
+        enum: seg6-local-actions
       -
         name: srh
         type: binary
@@ -513,16 +553,19 @@ attribute-sets:
         type: u32
       -
         name: bpf
-        type: binary
+        type: nest
+        nested-attributes: seg6-local-bpf
       -
         name: vrftable
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
@@ -634,6 +677,50 @@ attribute-sets:
       -
         name: name
         type: string
+  -
+    name: seg6-local-bpf
+    name-prefix: seg6-local-bpf-
+    attr-max-name: seg6-local-bpf-prog-max
+    attributes:
+      -
+        name: prog
+        type: u32
+      -
+        name: prog-name
+        type: string
+        checks:
+          max-len: 256
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
+        enum: seg6-local-flv-ops
+        enum-as-flags: true
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

