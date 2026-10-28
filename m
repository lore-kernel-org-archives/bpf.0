Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179163;
	b=NbKHv3ajr8y+mZKU5LDDmZjjYJDKRWYYP+NTWTO1hH1QsN0+4sYzKeZoTSv8h6VILxUa
	 bgRxEj6fnOsPR6mTJl3ex6Rh0/hfa7UV3P8IBUtkJn6y3Tsd8sNwPG8cIiFfjB8XerfSY
	 HnDE2FXZGS+KJTtlDua7C2GHrUdN86pMZe5LsLhT5HC6VQiRXdZOOnWKc5d0ul8ZA9gx0
	 Qx5Kt0tRrq33UwQnx81MYgnlJCc/ZR82wf/MQoHV8zGmMxm3h9Rfh9R2D0T02OswGDRVo
	 8EadgKqBsTVtm3TOtDSOQZP50BYLymUE65mADZgE6yDjZD4ilUrA4JaXb85kpZfNS1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
	b=mlPAncs7fRDoLF9SqmcaAY3P3754nLP226JVRHyBXlRbTsxkqaa9SkhD7mHHZRNStNOJ
	 rtRBH1Bw1g50YjKhwtLyrTZDbo9SnK6s1/YaHWY3qVh+Nn4todMGET1foHlErNEHivhLU
	 l8ZrrAOK3EeJ9NSn6dkmmwjzfujRyxIvX49QGM1ixeq9l0yxO0mMUB9C/TES2z27ewe0Q
	 YPjUn/28xiztx+EKOauoO+sQ/RXjeYp2xTTkgvDS6UieemVKFu6sNLvmR1Vx2qeI5Knzz
	 qW22D1JJuVk5TJl4TLANPVBmzEsGpjS0eechc8UlCb0P4Id2hYhyMWRfmRQSijgd2Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jEPXtPoY;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAF606A31E
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 09:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DECAF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jEPXtPoY
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c60e30054so8354306d6.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793179162; x=1793783962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
        b=jEPXtPoYHiaqzc8VKI6X2ReBPMPGM90QICrWEY1QCN7K/LrTc9Dj5NP7xx/fnkQ4TF
         96fP5MvhTbrzw+m7TP5vxPRvAiZokKRAfkJ03tmxYWhpkRhvkKvxKkLR63mZwY9jcYBr
         VKs2jQVv92sAEzf9fgoq0uEdelHI4THJJeNPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793179162; x=1793783962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4XCHXI/FWHj7MU3SgLB6xjThlzF9v+ynDOkqKImHCD0=;
        b=hdD97R7KS1FJn7J+pOZLukiNEhGhBryqaNNPOkjx6w3kyCchl3ipRoaL2RWsu8uu76
         ieTkfsYQegKPnz6jkVablxh66DmhwSrij5vH7Lw17k1N5Gi88wzI01niXaZkjOFCZNC6
         GCUaEu3HBlvir7KWgDLv41TpQ+JHKyJ7U3g76f6lKnP162twFc9xg5LHNi5IeZl9Vr5u
         KictW1T1QZyAzzha9AewJ5KaEkpeukWJR68RQDZORVKbPon4JCk2jHmvTpktbCddpXJY
         hDUZyyH4udYKrjqx7UBdleL1UlyPnlY+gYOMfcIVrxJFImjGYgMLN7evKbhp9jyPDwQr
         KD8g==
X-Forwarded-Encrypted: i=1; AKwUvByNpd6gPTgs7osf45keQ8XBMa/lZDL1mIQiqSXK5FawdwoOENNF4BedkH3unuNYKUH04ho=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNMwRP0w9PoXAc4s57ieDqr+HR+zLGrTqWdTBeIArtBpCYK7I1
	8buHmzpyG6U/x+lTG6HC6P3y2UW0Gl9mwh9fMr9K8sxdKImEuAKmEakt3tfh9zywCg==
X-Gm-Gg: AYBFou1Oe/y+uuEViRjrr4CohQ4r21tKblLMsdfeHE9jCRQ/vtos7u/Uf/r//8bG6n5
	xT1IMsDHs+bl01bgcq35qY/evnS3D33Mx+M54AEC78BuNbweJ0RAeIMJkwqyPEXUn2cnbbac68A
	JtSh7wQpq0RVJwd5PYiYCF7CRT++eHYOsS03R0vMNhwm9VLDL0ovP0uoArw1aj0oktqJDkpkODJ
	1RZsYkJ7bDRzuOfeiesb1htJz8K+/v8Gmh3sBsPO/npMnwvoK8XYZiTyCXGoaqLmmJ5/Ejntf1j
	HQ/Wh9Yqs0XsYjvUSEZ3iNYZywEiqqmKMqd9eDtowa8XQKg19qSqNz0rxx4b4N70ZhZF2NQuBtw
	VsjEjeQzAtlI+5RhYOK/lFG2yNvgcwrRFwWc4vVsXOz4uQcymlzy7RPf9CrRIKVDX6Rpr/Js2vW
	D0l95izO82qvPz7d4UsjbjHBuwR8Yww7w9CPvu6PvgytYlWBydosy4KDHjTamvtjh5UmoxAVtin
	H1/YFTdxKtK9HZEKEPX/naVCV3FXdCK8HtrT5jSGWapw9OaNpN4HgrYwSEK2OsNcMcuTpq7o3ex
	GCoAmz7wQcAi9Eg/GY+DfjCIKOkJ98z9Pw/z78oGhb5SYXD5+hSwzoBu0rbttiOPd28TYiVOZ2Y
	1BpGb9aLkWrne2jw=
X-Received: by 2002:a05:6214:5c0a:b0:919:557c:f0a1 with SMTP id 6a1803df08f44-91c7d1a0992mr27886216d6.24.1793179161578;
        Wed, 28 Oct 2026 02:19:21 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c50e10sm126822716d6.25.2026.10.28.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:19:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Eric Dumazet <edumazet@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
Date: Wed, 28 Oct 2026 05:19:16 -0400
Message-Id: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue:
This is a follow-up to the short link-layer header fixes[Link].  After
vlan pop_eth, a privileged SCHED_ACT BPF program can call
bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().

__bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
only that mac_header < network_header.  It does not check that the MAC
header is long enough or that it is linear.

A SCHED_ACT BPF program can do:

    bpf_skb_change_head(skb, 1, 0);
    bpf_redirect_neigh(lo, NULL, 0, 0);

after vlan pop_eth.  The skb then has mac_len == 1 and only one byte of
linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
__skb_pull():

    kernel BUG at include/linux/skbuff.h:2839
    RIP: skb_pull+0xc5/0x100
    Call Trace: skb_do_redirect -> ...

The Fix:
Drop skbs whose MAC header is shorter than ETH_HLEN, and use
pskb_may_pull() to ensure the Ethernet header is linear before reading or
pulling it.  Re-read ethh after pskb_may_pull(), which may reallocate
skb->head.

Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/core/filter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..4d344ec09736 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
+	struct ethhdr *ethh;
 
 	if (unlikely(skb->mac_header >= skb->network_header))
 		goto out;
+	if (unlikely(skb->mac_len < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
+		goto out;
+	ethh = eth_hdr(skb);
 	bpf_push_mac_rcsum(skb);
 	if (is_multicast_ether_addr(ethh->h_dest))
 		goto out;
-- 
2.43.0

