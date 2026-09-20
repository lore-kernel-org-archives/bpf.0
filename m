Received: from mta1.migadu.com (out-113.mta1.migadu.com [95.215.58.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0263E5EF2
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898813; cv=none; b=D9fP+z9TEhPf9lCCzryvSUBBJ3a2nDNmIMcZuwrjwOR5bSr7GJJGPtFK/6XzYdFNztBH7YK7/tFNAXx+fk4c2k+SLoURb9oRJQgDe8T7e354h4de+6kJ+g3zxgNRe2NbSSmC7bNF2aZWuGM0eun6h1rpXuw1pXVWhEjsU0gLToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898813; c=relaxed/simple;
	bh=m13fKBwXp2ZBVg4n/AP/jBHBQzFloS0fFjdHVVMILEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNz42mQiw07srYXW0OSHKRvpAd7E6HNGD6vRqN8Obq8eVTgCxbnlVXoQ0686i80pm9OZ/YPagEmBqf7Xr7DIxXIU9lt1TkW4rieRN2iM/SPcCR7K7YNbxVf/jOFMgBw2MzOoSI+DkcOi61hYIGcX9KdMOOu+UXMjHk2wjGFFs+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xaoB+JLb; arc=none smtp.client-ip=95.215.58.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xaoB+JLb"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m13fKBwXp2ZBVg4n/AP/jBHBQzFloS0fFjdHVVMILEY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789898809; v=1; x=1790503609;
 b=xaoB+JLbs+0lkcTe344psiarBTr35gEWti5qpejMTlgegtlCo3xkN71Rq2QLUbMGbLJJY2jz
 b14otQJbK0wtkuKLGB3hvToALvONot0XFoOPyKDxD7z2HowFYJAmqlahJXLEtvbBropgH3ADfui
 /tsFnZ2ZufIdZs1zfeEUWRg8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 38af924592db46e3;
	Sun, 20 Sep 2026 10:06:49 +0000
X-Mizu-Trace-ID: 38af924592db46e3
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Sun, 20 Sep 2026 18:06:36 +0800
Subject: [PATCH net-next v2 1/6] net: lwtunnel: change encap fill order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260920-ynl_rt_encap-v2-1-c664a3e726f6@kylinos.cn>
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

When decoding sub‑messages, YNL tries to fetch the "selector" (encap‑type)
first. However, lwtunnel fills encap‑payload data first, which causes YNL
to fail decoding the lwtunnel encap message.

Fixing this inside YNL would be complex, so change the order in the kernel
and emit encap_type first.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 net/core/lwtunnel.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index b01a395d9a96..8223c44f10c8 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -231,7 +231,7 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
 {
 	const struct lwtunnel_encap_ops *ops;
 	struct nlattr *nest;
-	int ret;
+	int ret = 0;
 
 	if (!lwtstate)
 		return 0;
@@ -240,30 +240,31 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct lwtunnel_state *lwtstate,
 	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
 		return 0;
 
-	nest = nla_nest_start_noflag(skb, encap_attr);
-	if (!nest)
-		return -EMSGSIZE;
-
-	ret = -EOPNOTSUPP;
 	rcu_read_lock();
+
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->fill_encap))
-		ret = ops->fill_encap(skb, lwtstate);
-	rcu_read_unlock();
+	if (unlikely(!ops || !ops->fill_encap))
+		goto unlock_out;
 
-	if (ret)
-		goto nla_put_failure;
-	nla_nest_end(skb, nest);
 	ret = nla_put_u16(skb, encap_type_attr, lwtstate->type);
 	if (ret)
-		goto nla_put_failure;
+		goto unlock_out;
 
-	return 0;
+	nest = nla_nest_start_noflag(skb, encap_attr);
+	if (!nest) {
+		ret = -EMSGSIZE;
+		goto unlock_out;
+	}
 
-nla_put_failure:
-	nla_nest_cancel(skb, nest);
+	ret = ops->fill_encap(skb, lwtstate);
+	if (ret)
+		nla_nest_cancel(skb, nest);
+	else
+		nla_nest_end(skb, nest);
 
-	return (ret == -EOPNOTSUPP ? 0 : ret);
+unlock_out:
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL_GPL(lwtunnel_fill_encap);
 

-- 
2.55.0

