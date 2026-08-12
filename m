Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5204138D419
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552620; cv=none; b=qyenTCO9SqHNx8kvU44ip2NDU9gzBcjmQxIlciEFp0jssCiXv/u3m5hncOLYiPmiXDn/x8rFLipmGQ3VrAEOgcQu55eW/wdLRhsmVgY8ohDS3hZllM+KUYVzyVaALg8+Inm6JOADAKnvrW+3v6OpNPz0J7yqFk0/3UOGcYkVsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552620; c=relaxed/simple;
	bh=qFJTd1Pohw19wep66XSQur8wBgQEbrCcoIQrmJ2RYwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cs4zMrKjMdNu0FNuewW3rxRV+7+nA9fOOu8oIRJhQQPuPb577s5ubHyOfmPowShr3Yo1H3u+ybXW1b8aA9xhnvEpZGQ3Ty6u6dm6+8Bq8e2Q6na4hFRrfutWXVhkwYCvz1brMtlZ2JYyozR2wOlVMRIyFgqmsdFIDg+P1K42ssw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rNghMlrm; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rNghMlrm"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811f512167so1464174a91.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786552619; x=1787157419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S12B33otl+xs9aLy7HZkleNzMtJjJA/J8Sk9AZrxsWM=;
        b=rNghMlrmo5RBAg1o3dhWY+CcoVj996S+6akPZ8h+HzbO4t2LwC0hzzt6Z9a5KdliKo
         LK/3lty7rlcn2D0eJi750cFXC1c7RcfYFzBQmMcoDXq/a6Lxu0fxScyXzxmrOJG3R6J/
         bvM7wU+y4MWxqDN4aaAFddt8lsPqPxAv86jGKGeLzMefu2fRFVCEkql/SGXqpCItcQCS
         /lJUsXJ5smSnx2Wikdk6eF1a/byknFi/A8+Zh9B1te16pz346GZ/WlHwzlBhjdfWnh1I
         9N5sDW+rvNiMr2m3F9D/6kertnIvKYxJWM9iL+kfNYpDJ22QZf+917XhD4I4oBp5M/IQ
         7QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786552619; x=1787157419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S12B33otl+xs9aLy7HZkleNzMtJjJA/J8Sk9AZrxsWM=;
        b=PTU6p+tNxk3qtRg8q5n9jXsIZ3QMCcILrS2+UBGxzjLcGd8gMQnn6d0QrKEVWfwmIj
         R68x69NsKR7g/p059fFD9KQWfvQbYJGN29wxByMmNMdSOVjt21LbTUJU2tr8Q3Gzh4Xl
         2U5FpDNZ85BtBsh5Kk82K8zIRVxafsQMy0G6xqXCkvUEPTj8IglgH0jgCnU54wwKfa28
         b7uv8uusDideMv0El4bykVnTlZGfsBaDEx13A1SN9mz+N+7DsADverC0YqQfsLUUr0NN
         aQBW5J9GEp6780cs6nJjpkU1PPCAtO/uRep5LI/SqlewHaCBx0kV9QHJMr7OlheltMit
         ze2A==
X-Forwarded-Encrypted: i=1; AHgh+RqczHhzyl1lOBfSxtYDhzN2fgHTXTVBLyWVHbbp3Ix00btiIIzifU3p9NxVtalw3oQfc4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzabp8f3Uniq9h8iQLqBRdnEe3SwcYLYocQDkRY65A42BjZFhqt
	pR04q1gJb0sLCDtouBXi00Ze4f7Hj9HW7nfiGSKldxzDqaRE5XRI1AKykJbs1DbVU6em
X-Gm-Gg: AR+sD133Vq8q7rt3OOzw/W/l9fbs/9l3u8I29IUhSCN4OaQH8KIKhd1XNZkww88zlly
	HqMRqi72zkS/9sA4mX+1sNwXKjbDfLaE+unqBDt95qhISPnGRZwdBzveXsYUCLuLTejDAExIUGb
	CeCV/Cn/f9YakZgTTKluLmuJ+sZP71BUFQ/T/2+7fmEXY3Nk2c4Tiy+3Ua12yd9KgHSQ9xmwhqq
	MQ+zokoOvUAhNyog5+x2D7i7tUk5vfthm0KgiUhQur6REnCO2GgmHfChrtIlX2W4onVDBlGa0v5
	/4rjos2wkEJZ/d0nBZ1PnfoGVwWk2EQ8RsdTeytfvYyfpPeNDMcIL0KD8PtGwQR7OEpYfTrHzVb
	EQNcKPTFPY7gS23iCKmlgnBpf6RdNXA5zQ9hZ3Gc2CB/7ulGMj6aAjBP2QkWp5cdOJM2BY/KSGS
	OjK0+p03o2eBQC+SOicPH4xRk/92jAiuOt67kuYRGXnDwcR8qiyok3JheNbHg9a1f6OZ1yzjQnE
	uXV
X-Received: by 2002:a17:90b:1dc6:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-393013c4248mr8969661a91.2.1786552618585;
        Wed, 12 Aug 2026 09:36:58 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cd46314sm47499a91.6.2026.08.12.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:36:57 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ast@kernel.org,
	kafai@fb.com,
	joe@wand.net.nz,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v3 1/1] ip: orphan prefetched skbs before multicast forwarding
Date: Thu, 13 Aug 2026 00:36:38 +0800
Message-ID: <0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1786552223.git.zhilinz@nebusec.ai>
References: <cover.1786552223.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. Both address families can also prefetch a socket in UDP early demux.
In both paths (BPF and UDP early demux) a reference is not guaranteed to
be held on the socket.

When a multicast packet is not locally deliverable, IPv6 hands the
original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
original skb when local delivery is not needed. Either path can put the
skb on an unresolved multicast route queue or forward it after the
receive-side RCU section ends.

After the prefetched socket is destroyed, a later skb free invokes
sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
each non-local multicast forwarding path. Local delivery retains the
original skb; the existing skb_clone() calls provide multicast forwarding
with a socket-free clone.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v3:
- Describe UDP early demux consistently for both IPv4 and IPv6.
- Drop the IPv6-specific unicast-MAC discussion from the commit message.
- Leave the BPF-only TC redirect and bridge paths for a separate patchset.
- v2 Link: https://lore.kernel.org/all/f968f497251dedbd1263c322a7c4e3e1a727161d.1786023177.git.zhilinz@nebusec.ai/

changes in v2:
- Cover the IPv4 multicast forwarding path.
- Correct the IPv6 early-demux ordering and document the unicast-MAC
  PACKET_HOST condition used by the reproducer.
- Add the BPF socket-assignment and UDP early-demux Fixes tags.
- v1 Link: https://lore.kernel.org/all/02db4590d0161e31a789dcdfa8d1be1a3212ec2e.1785724784.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c      | 3 +++
 net/ipv6/ip6_input.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 1d9a4ac14fcef..e5f2b1c6150d2 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2213,6 +2213,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 8972863c93ee5..d332ec60f9150 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -622,6 +622,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.43.0

