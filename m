Received: from mta0.migadu.com (out-147.mta0.migadu.com [91.218.175.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AB362153
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733070; cv=none; b=rLQxK6inQ9WcrfORyHjEdD08PmnspWEzmhjB24TEbTAM/pOQBbnUZcrqAq1BntECSnn3niOFjMhhQ/aKB5kbmBFamJgfQm1rPoniib/Ah93QrDX8Es5xfwHIYub4rmn89Asc4L0dCud68fZHYas5zsurI5ZaAAR8FY0Q0ymatZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733070; c=relaxed/simple;
	bh=CmSE3J2AY3c3WgRbkDwOwbC2g9/ph6TF0R7e86CvP0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8PkKcIdbojEG/41u4KJjfaHVgCWHnpuXiBmYFHMQjChsys5lTndHWcSN9U1HJQNHg+vCQ3DSke1X4YjF+iNBOwtfw+cWNPtxImUI23fqxU8WWnLzf8QcGKSi4MRy4tGSoN8AyPMeoCK+BNe9yci15BV9SI2/g5jiduUxAzRODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rq1DhbUq; arc=none smtp.client-ip=91.218.175.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rq1DhbUq"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CmSE3J2AY3c3WgRbkDwOwbC2g9/ph6TF0R7e86CvP0M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790733066; v=1; x=1791337866;
 b=Rq1DhbUqyaFBm236LDrOhgCZWFfbyVDs2T8QPNLf3LaPQ/9F/IYTLBjg1zdkY8j/PObg4Qva
 MMfqU4HOHn/hltpHsFUgky/dD5JfHTKHB5TxO6AFJKn5glVhbakdU5nF4KrUm9bShFsuIfbsnAE
 t/qx+LtuaIAz1P1EdrhHGa1c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 70858a35b66a46a2;
	Wed, 30 Sep 2026 01:51:06 +0000
X-Mizu-Trace-ID: 70858a35b66a46a2
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 30 Sep 2026 09:50:52 +0800
Subject: [PATCH net-next v3 1/6] net: lwtunnel: change encap fill order
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-ynl_rt_encap-v3-1-4106c21b9ee7@kylinos.cn>
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

I plan to add lwtunnel encap attributes to the YNL rt-route.yaml spec.
When decoding submessages, YNL expects to read the "selector" (encap-type)
first. Currently lwtunnel writes the encap payload first, which makes YNL
fail to parse the lwtunnel encap message.

Fixing this within YNL itself would be complicated. Instead, reorder the
netlink attributes in the kernel to output encap_type first.

This is a preparatory change for the upcoming rt-route spec updates.

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

