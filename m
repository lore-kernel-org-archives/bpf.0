Received: from mta1.migadu.com (out-234.mta1.migadu.com [95.215.58.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F0463B9B
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447863; cv=none; b=C9d0+USz15MKinXIwafPmj3ZknLg5zbSInW0RyMvKu7ipyvuK0L14zK9V87yMvEmpmmvXqSay7L+A/Rd2wsWxCT8uJL5I8qRib4VmRNx72+neTlZp7qQmwXT/lB/cSOxInU/SZBHya/y2n8nZWe5FaJLXBofbIJ071NW3U+zVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447863; c=relaxed/simple;
	bh=S0pg78/I7iufM56BvTHyFSwPs3wzvF8ceQnFaaDF9VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CS9E4yD42S+j9kzWLJIlopdgLgA4spvcs0hbyyLRJrOj1E5QEdAVLrdwxUeZPc8WSJIXeIxaM/R8FaBrtwe2nErZaLlcGlAKfMfkSWNrKKDxUIZXF527bKMd//QSm7XzPxad800bsVWcs0r3vaETiPkTjlNrDybFO324QTag4rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VQBTlEuG; arc=none smtp.client-ip=95.215.58.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VQBTlEuG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=S0pg78/I7iufM56BvTHyFSwPs3wzvF8ceQnFaaDF9VA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791447859; v=1; x=1792052659;
 b=VQBTlEuGhsun498QZmSiiCCaN25IMia9VrZN72Wuf3ra/m8kFJGghU/r23BGfN/xU6zGM6nR
 6EcHxmJkVsN8du2yoC1Jg1gdNo0+6lEfPrnXprBwq4BEU/xyTcxxyS4d5IWk9DkXBjVvIh3KuI8
 Q7qdkfO7uu2s7YQZ1SZb5xAg=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 39bdade1274ed362;
	Thu, 08 Oct 2026 08:24:18 +0000
X-Mizu-Trace-ID: 39bdade1274ed362
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Thu, 08 Oct 2026 16:24:01 +0800
Subject: [PATCH net-next v4 1/6] net: lwtunnel: change encap fill order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ynl_rt_encap-v4-1-4ed2ccf7f949@kylinos.cn>
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

I plan to add lwtunnel encap attributes to the YNL rt-route.yaml spec.
When decoding submessages, YNL expects to read the "selector" (encap-type)
first. Currently lwtunnel writes the encap payload first, which makes YNL
fail to parse the lwtunnel encap message.

Fixing this within YNL itself would be complicated. Instead, reorder the
netlink attributes in the kernel to output encap_type first.

This is a preparatory change for the upcoming rt-route spec updates.

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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

