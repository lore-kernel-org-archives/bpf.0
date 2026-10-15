Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF0847D460
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050334; cv=none; b=eCExk+GSYaEEz9my2R8EA81G3C63zvatHJiMBq/GyrE28XXO8oy2BdqM267qdX9AoBeL4prGD6OtMEmvlfwWPbxrO9hGQfc0dZ4fBedtEd4lVSRmiuq8qdN25okaxXRC3Uh63OFoSDB1zr/47uRkvXLpPDPCG+W2u8omftvWsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050334; c=relaxed/simple;
	bh=wkvWUApSrQrFBFKMdGdp4vLL5y0nqDGM2AWyGgExVyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKLFq97SnllWVcN2WVUu479I0d5rFAf2hmRy7PwgJQJrqquLO9/xSQe/V8RPjHKKaE2nNErAZEabXNCnubns4VsEuAVDcmjSUc4z3hk965Fb3eU3Fc0WlBzva3zf8sjISMMoYkgQUvv7GJOHzXFtdfjNkkfcuU7Sjj3oFOStpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=j63pX+y1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="j63pX+y1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso558929a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 00:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792050330; x=1792655130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
        b=j63pX+y1gpTYCgmNlQIjjscQcWfhLW5zwPwhMz7+2aWllpx0pVaEx6nOqGMfP8HSYo
         tbkoG+ticRj5owflRxLSad8IkJQwRko2r3sl1I5nnH793Uv09Yg3bEjUthzbAg31U8W7
         kUAXmMigAC6dDBHq1LrkI3DWZSViwKmjwzOv5h2RUYNOV4NzXewK6+wIhWod0OINFxa9
         SThqwTQyiYwH5oK05mL3tOxdZ9MayvWE9dOL/rBnl02fGEpWE8CpowBTJL7oG7d7MSBw
         2b5GKDrjkgdG4XwZWWe9dczmRjfyVXaZLvhdnYuK11bdnDV3oDv8kiMZRwYRfOUbg52+
         JScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050330; x=1792655130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tn7PQz7YO2FDXiLMjVOvk9Md6NqVD6EXEzozd8X+sL4=;
        b=VUcOPoXLgRoFcQTOi+cXWPZ0QEC/QNbKi7m15FDdE4sACNdWtL/N66LnlTmTYs0sOv
         KhDqnUaM9S+O2sDwDvUCBp5t51iHXwflFljyC6Ri/TuYpHLhJ4up+3gdUswlnOc4R0v4
         BvD+yBlpNECNXeQD4oP8GG8AWCCmm3vzXZ9ud0A7J7fwJ4av3tHjqDt1FSsHc5E2Oa/P
         bn8gKOrG5CDqBaPM2v824Db4hrbFC/CjZT5UU77Iyv5ptuTc/FBeQjJZayoBJgCjStrx
         O9oOYvhlYKkWM6MTctDEQc2DMp1rHKEHcixV20Qyv63iNkf2w6ZQZCLamuIUnTMGEdvC
         8yAg==
X-Forwarded-Encrypted: i=1; AKwUvBw3irA7H/+BXZHn3jOzTC6cvSYc1dGwYZWZSVTNKU0t6WLYIv5vtM2ozAgJZYtBpDO+GwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJuhZh/BWqq7eYDJCyrchU/9SxnvU2MTpt3qNzuX4y7ap9QGOXA
	KjBaNeCmSVOHza1y/WnJ2TL0BJv5v4Ddi0js+CR4ZYWKe4cCD4fUEUERwugZrWMwDa7T
X-Gm-Gg: AYBFou3z9g96u1Hst2ezMhhlgtfI4sDE1D2jlrwvSROKBJ6d/JwMK/iIzHLelSUB+cG
	8jkNlKqKhH/OmCgKIlJ9abNb0viTAqFfKe4GdY/gmXKlhMucd7+z+H5Z0yhFHU/IwxvS5er7Tbi
	uV4AyXYWcgJXbX6dq2EKDbx1wLNWeoTLqE7ORdp4DlkLIiQZSvzgxqMkMSObMgQfBZ+HvRB4WuE
	Hs4zX1wRv0BNIqm648TkU/zHcCx4jF0uky5qDuUZOyl8gD1biANGWMeLhQOen/XASDuv4GjNaio
	HZdpx2zChtA9uC/1I9nrOa/IjQuEqWvqOarnk4h4rAGLX6ds4xQqJSp9L3OZWMQuy9JXILmEATX
	B7xcTRJwgBtsGFVyU+uL+5ywXHGh/8QNnsXxVgIgZKnGED0eHOvohJ6sF/R9OWqJSZhDTizSKFT
	Z31UuEmYlxZ7gHTvTdzA6+mHp+klrXejEl6grzT3Gp/lyevGQLJVEnb+ZNiZN70xhT1NizmI8Cl
	0htVArBKGgvWVTBafkFkdHZOaygWA==
X-Received: by 2002:a17:90b:3b4f:b0:3ac:a7ee:6780 with SMTP id 98e67ed59e1d1-3aca7ef2dd1mr318175a91.66.1792050330377;
        Thu, 15 Oct 2026 00:45:30 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93849da5sm1636831a91.4.2026.10.15.00.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:28 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netfilter-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	intel-wired-lan@lists.osuosl.org,
	bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kaber@trash.net,
	jengelh@medozas.de,
	andrew+netdev@lunn.ch,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	willemb@google.com,
	alice.kernel@fastmail.im,
	eilaimemedsnaimel@gmail.com,
	imv4bel@gmail.com,
	shiming.cheng@mediatek.com,
	sd@queasysnail.net,
	vega@nebusec.ai,
	root@tr0jan.top,
	zihanx@nebusec.ai
Subject: [PATCH nf v8 3/3] netfilter: nf_dup: prevent TTL and hop-limit underflow
Date: Thu, 15 Oct 2026 07:43:09 +0000
Message-ID: <3db2db978957de74be13ba48cc16c5e0829003e3.1792048855.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1792048855.git.zihanx@nebusec.ai>
References: <cover.1792048855.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPv4 and IPv6 duplication helpers decrement TTL or hop limit for
copies processed at PRE_ROUTING or LOCAL_IN. Stop duplicating when the
value is at or below one, before a subsequent decrement can wrap.

Fixes: e281b19897dc ("netfilter: xtables: inclusion of xt_TEE")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/netfilter/nf_dup_ipv4.c | 3 +++
 net/ipv6/netfilter/nf_dup_ipv6.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 9a773502f10a..5f9d6c473fb0 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -56,6 +56,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
+	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_LOCAL_IN) &&
+	    ip_hdr(skb)->ttl <= 1)
+		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
 	 * the original skb, which should continue on its way as if nothing has
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 6da3102b7c1b..5095f9623001 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -50,6 +50,9 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	local_bh_disable();
 	if (current->in_nf_duplicate)
 		goto out;
+	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_LOCAL_IN) &&
+	    ipv6_hdr(skb)->hop_limit <= 1)
+		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
 		goto out;
-- 
2.43.0

