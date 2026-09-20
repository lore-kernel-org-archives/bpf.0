Received: from mta1.migadu.com (out-150.mta1.migadu.com [95.215.58.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3041E3F44C0
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898846; cv=none; b=Nn8WTtIA7LaFODPZuxE6eVXt7Xhln0DYITJLNgDc2ooylmGDcCiQMrnRFgOYydL4xJdW7ergjF1j1A34uwTcJWqvhqTJVIog/p8Zws9la/hd5xKdhggUoauef9mH2nNGUXZFkxXZoqJr9UhxUUd+S3ETr0v6csfCMevF7CgFtIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898846; c=relaxed/simple;
	bh=mgJPAC3v5oZHApxysDsjs7UoU7Ogd9FRsEA5kIrL1JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmDa/sV8P7GyMzExj8oNPFaDQ6WAkFcY0R2N+bJlsZ1TnOT7p0Lkg6/acDsuZOGHiawd1SJlVygJKbogOSBV5lmXbhgtZw5RvPDRilw5XZoIeO6TZlzO2yS9Y8OCRjaAGOzEwi9JJt4G+AGc18lmAualzSDTB8D3iKPZohnXngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cS/8/f+t; arc=none smtp.client-ip=95.215.58.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cS/8/f+t"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mgJPAC3v5oZHApxysDsjs7UoU7Ogd9FRsEA5kIrL1JU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789898842; v=1; x=1790503642;
 b=cS/8/f+tSYJAOUrTLdNKvAdSTBUxXpScuYrWW+EMk2r6SakDLRMptxAnPuoaHZwDSW1pvBwk
 2PSw4dGcZctDe7UPZm35gDtr0FK1mWE4mj484+H2wi2MDlF5uQlXJ9kwRwOkro/Q1zU2x8O/YQY
 xGbUAADH67QRuu+92OqwWdKU=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 59605f08593950cb;
	Sun, 20 Sep 2026 10:07:22 +0000
X-Mizu-Trace-ID: 59605f08593950cb
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Sun, 20 Sep 2026 18:06:40 +0800
Subject: [PATCH net-next v2 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-ynl_rt_encap-v2-5-c664a3e726f6@kylinos.cn>
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

Replace binary BPF attributes with a nested lwt-bpf-prog to support
lwt bpf prog options.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 4b12a8a58652..4a3953c9e978 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -467,13 +467,16 @@ attribute-sets:
     attributes:
       -
         name: in
-        type: binary  # bpf prog
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: out
-        type: binary
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: xmit
-        type: binary
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: xmit-headroom
         type: u32
@@ -508,7 +511,8 @@ attribute-sets:
         type: u32
       -
         name: bpf
-        type: binary
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: vrftable
         type: u32
@@ -618,6 +622,17 @@ attribute-sets:
       -
         name: hwid
         type: u8
+  -
+    name: lwt-bpf-prog
+    name-prefix: lwt-bpf-prog-
+    header: linux/lwtunnel.h
+    attributes:
+      -
+        name: fd
+        type: u32
+      -
+        name: name
+        type: string
 
 operations:
   enum-model: directional

-- 
2.55.0

