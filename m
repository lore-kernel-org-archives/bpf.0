Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28B43933F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626997; cv=none; b=actn1UIs+h3Kryj7NxmjQoF85Rq9Oc17jFDzaAIXrrYFDP4W8+40iAl4UWOmzeveMMzKRTpXXCm4kJ/So5Jr+erJFuOjZNc9BpPp/kKlEhX993bCZOp95zD7y8WX67QRMBqMFW3AiMbJ/M5rqj99GxHprY5WVBbEp7tVzH8iyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626997; c=relaxed/simple;
	bh=aikSuubhuRBRklJlpWq3zTZA6ZWmLVtU9b81OoFlDPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBDA3vSa2RDXpOGTfxd08bzMyP8p887taGTKELLIDMItIpTDrNuGpeI8k8LXFV06ICWnSRhoIbotLa9FEO96ZIMcAoqTg3OP6ixKIPRnJVKznQJsJ0FWi70i80kw7eFOZMcASMGXoyqZV/R9DzUSAN7gsQFlemIegcK93rGG8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KkFZ6s+x; arc=none smtp.client-ip=91.218.175.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KkFZ6s+x"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=aikSuubhuRBRklJlpWq3zTZA6ZWmLVtU9b81OoFlDPE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789626993; v=1; x=1790231793;
 b=KkFZ6s+xsJZpcGHDfhbVqjstzMaqF1Kcf9AnmCqm6ueEWktV/Dv448pjzbpAPU2S1f67vfYZ
 OQxxYXT8TDZHquUIzdOWE0rCNqsXuVdP1w3RY107b4c85lyRQsXTwXihR88EPu/HggLL4BadAhq
 YGNei0oLcl3X94yQJIUaJLMM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 98acb50523c55b4f;
	Thu, 17 Sep 2026 06:36:33 +0000
X-Mizu-Trace-ID: 98acb50523c55b4f
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 17 Sep 2026 14:35:37 +0800
Subject: [PATCH net-next 5/6] netlink: specs: rt-route: describe lwt BPF
 program options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-ynl_rt_encap-v1-5-fbbe6e680571@kylinos.cn>
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

Replace binary BPF attributes with a nested lwt-bpf-prog to support
lwt bpf prog options.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 Documentation/netlink/specs/rt-route.yaml | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 6030d7cb8d0d..5e9537f7dfad 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -463,13 +463,16 @@ attribute-sets:
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
@@ -503,7 +506,8 @@ attribute-sets:
         type: u32
       -
         name: bpf
-        type: binary
+        type: nest
+        nested-attributes: lwt-bpf-prog
       -
         name: vrftable
         type: u32
@@ -610,6 +614,16 @@ attribute-sets:
       -
         name: hwid
         type: u8
+  -
+    name: lwt-bpf-prog
+    name-prefix: lwt-bpf-prog-
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

