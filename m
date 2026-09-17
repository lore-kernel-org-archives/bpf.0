Received: from mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CD426419
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789626972; cv=none; b=ibaC+bkpA6UPDdODMKLZ2jzgVAmNOp1j8eK6/V/nAZRf6snuB5CYQwZwGUXPt8fiBonG3fkaMfcKwOEuK4+rseAJHkjtIgcFvoCBp3zJr7cmRnB7Ml0mlbxPu6xIPD5m+/kwpqJPdI5j/5USssMNIdNgZHfjegGXRTvq9BpMbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789626972; c=relaxed/simple;
	bh=+TEUw+9bfsRkWHwf61os0Q82n+DPpaf+QTn7DrG2OyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7DtyYAP/dRo+ToB5tEdhA8qVWvXV3qyQBPbQRB7ZsdiNyMO0R4P5C27Buf8u+JzMWQYMhxS1RXzhao7/f+88WHZlEoUPGca3a6DLFyEe/L4Oley3pouzElZPqb8VHcaTn6vUK0z5UO3eZQCV3NVrOLP2W5eyw2Xfe5SyMbU8HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vyawrA3F; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vyawrA3F"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+TEUw+9bfsRkWHwf61os0Q82n+DPpaf+QTn7DrG2OyE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789626967; v=1; x=1790231767;
 b=vyawrA3Fpmfmy9CjRrpDLI7Tq92hFGpnom0UsijC23fTIQKtkg0iEKGFfuO6asQJPdS1eLUT
 N/9RsgLagcWDpu75XcYoRJ99pOYSyq/+NPeGIwhLc7CRN9gGPSzUwtONxU/BOLMbsNpbcnCuLHv
 wJUvFqjsZi7fai5OQCFGzOV4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d725fe4ac47aab61;
	Thu, 17 Sep 2026 06:36:07 +0000
X-Mizu-Trace-ID: d725fe4ac47aab61
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 17 Sep 2026 14:35:33 +0800
Subject: [PATCH net-next 1/6] net: lwtunnel: change encap fill order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260917-ynl_rt_encap-v1-1-fbbe6e680571@kylinos.cn>
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

When decoding sub‑messages, YNL tries to fetch the "selector" (encap‑type)
first. However, lwtunnel fills encap‑payload data first, which causes YNL
to fail decoding the lwtunnel encap message.

Fixing this inside YNL would be complex, so change the order in the kernel
and emit encap_type first.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 net/core/lwtunnel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index b01a395d9a96..f13dfa02e026 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -240,6 +240,10 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
 	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
 		return 0;
 
+	ret = nla_put_u16(skb, encap_type_attr, lwtstate->type);
+	if (ret)
+		return ret;
+
 	nest = nla_nest_start_noflag(skb, encap_attr);
 	if (!nest)
 		return -EMSGSIZE;
@@ -254,9 +258,6 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
 	if (ret)
 		goto nla_put_failure;
 	nla_nest_end(skb, nest);
-	ret = nla_put_u16(skb, encap_type_attr, lwtstate->type);
-	if (ret)
-		goto nla_put_failure;
 
 	return 0;
 

-- 
2.55.0

