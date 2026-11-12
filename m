Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516072;
	b=ssRyFKQuEtKn1NgsO48PxNZ0K9uLJymcatUg/IaWTTZT7d3zlNIk/BElNlrHABJac7Gk
	 DGmiwNkucY8s3HJOPGib4Ni2vU8qONh0qLqxO0QdmaIilbT+m5HLqMRKSth3LRx+ncbsS
	 gos2G7djjSiSPxItlkbJYcf4lt6yAZ/YiQOhjjeXf1lE1BCSI2OBSPUieSKtwZJO65Jet
	 g7rme8Nu51Af3+RcB70r4/tHtS8wwvqDSO1wxz32CyeSu52hnedJ0mx3jMADr+zXi5L5x
	 IxBXuM/Ad5CmReEBftOmMGiI7mLJI44HrKJjeADP8KHuE1eWVUNSYSO9XEPMqpnW2AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xXKJrbALur9qe5R1OS4jb0FmQE/KqmF7j3A3hmQEcbY=;
	b=pcFtfFfpbdtJHWYjLoCJ9D57EQ1HQ7mhh6eI0bq3dlq3sfg/wZl3WhVXRg1hSNDOmZKj
	 AfIKVPi1Y6HcU1W5dEc4bnwAQcYymZWrGCmaanWUmL/vyfkXzxH6T1JvgD4ltdMj/c9eq
	 QtkoO09JoYAWGhSeERv77dKTZnfISbX1KbuH6YtOy5B3PCqHcu2rnp1MQSaoZ8damfPpP
	 PZmiXmKpO1RB7509srj7vBrWkDPBXv0ZsHwYfKn7ky2Bq1rzzvUhprjqMe71szXughByc
	 2NVXg6uxxlmRClJdrQCchPqikEImo1lF0xPMURyNVDS7Xictx7oRMQo+tTqp+H0jKbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=oq6IFftj;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24333606A327
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24333606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=oq6IFftj
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91ecd81cd67so3262056d6.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516071; x=1795120871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xXKJrbALur9qe5R1OS4jb0FmQE/KqmF7j3A3hmQEcbY=;
        b=oq6IFftjyrFUryFH45jbu50E1yaW9IoYXs4KxMPfykjuuxi2t5A0nX7Vx2jL5itsC3
         sXgMemAuKhbSOPFcZ3RVAC7kZ0YHy1r9r5DLs7SyBxBTuwg28OOwDBaQNGU8CsJa/4y2
         gXah5wBuAisxvrKdRzgNznqtRWBlHauCNwPIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516071; x=1795120871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xXKJrbALur9qe5R1OS4jb0FmQE/KqmF7j3A3hmQEcbY=;
        b=eVoJlJ+J9HnUKFnt4Km31HWC2whTp+okOuLOuD8Ym2GAQEx6Xn6UQmyI5p/RzWM2V4
         80QoI+IcNR/M+b0JHLpnBcwNGQiafkiJPUWOexPFc0+rEC/bq5Ox4/Z6WgCImN1nVNgX
         ZOWiHTzKZDvzy88B8MzuYzOPhOo4GZ8/VqO/lnrdlA59fVA0ykvVrTH4szZSsDnPz3Of
         lapHkCh9QPS14pAJlv8VjB0Bv7ewW9k1GqZWA/c7HObpmLWDdtxvmt9MNHlSJSn5ZBVY
         3XLj2uzu3ArB8bdMeOeDYrPfqMZ8yyQBduybJ7YXkzgQc0REs6rIybd960YikMuHZK6p
         JXHA==
X-Forwarded-Encrypted: i=1; AL+hErETJgbaGJmeCo+kqIM3+5una2PKu/3xarEs5IKUeDAR6vt7D4wDZ4oycxq+6TJZb/fxde8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9k/Ym/WlyMfJTklkMe93uepe/Ukn9BEPx9N9SrHWkhE68JYnOb
	qkgwwkb7tKVWeI5qWy+ApFMN0w+rhBYhGj4KmRkpOlmIefmS5lx7ys10K6tuoUc+qw==
X-Gm-Gg: AYBFou18s841EUDAEOEdrDpEDL3AnSh+yBJhJuNtC4gQvDQnL5PTdi7QO1fYSff+q+8
	el1Fq6UeGLcp0GLk/z1ktc9ilNUrUFuvp00PjhQyc9J51r2nvIsOj5JhJYQMH1UZpCJJ8zvnrHA
	hsxJRKjHqPxkT60UhSuM7XEcbHrFBxeQWpuu4KMuUrKi2vvklUUwTilWYK8Oxzj+uGyNUgqBxN3
	DUKiJHk7PbYo9uWUGIWJrxCozGUf5lO8Lt/nK9nJ3Rux68F4aEAwOnsk+N36FKuPOlqitHT4T6S
	uGapkc70lCnGc7A+tir7TlJ9hnH95uaQmYvPR3Thzfer1FJOW6C/3j/g5GdChU/saYizsObL4wX
	8SNHVUjHywgNYQdMXDmM8heGFTQgZlnSkc+gdrjIr+sJueNxJIFtRZA/i60YoyfocDUiYPuHflp
	eekQxj4bt0NS21IWMMBoNpURoyBxVE9e+gqJP4kVkZD3tpn8MsFKfJvWQBubGhnyh/8f2kZVWEm
	/0QVQH1Aw4uCrCWRpITnbAYTd6xP7B2JztwsGLdlJ7q6A2ALCLkeqTlA888paY/srhG2XbjwZnl
	lPeQZCyg/zU/js8jD6UZuEITJFnERrUpNn1384N+wRsE+2q0XfZM1yXNJP3FzTC34ARAqmnwrIX
	+o3iHBTLuMJ+7ydsbrhXY
X-Received: by 2002:ad4:5764:0:b0:91e:93df:7968 with SMTP id 6a1803df08f44-91f2427df7dmr8048966d6.58.1794516065405;
        Thu, 12 Nov 2026 12:41:05 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:41:04 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v2 4/4] bpf: drop the stale dst when redirecting to an explicit nexthop
Date: Thu, 12 Nov 2026 15:40:49 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
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

This is a followup of the review of the teql arp-queue fix as reported
by Sashiko.

The issue:
__bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() install a dst for
the redirect target only when the program lets the helper do the FIB
lookup. With BPF_F_NEXTHOP the program supplies the nexthop, the lookup is
skipped, and whatever dst the packet arrived with stays attached while
bpf_out_neigh_v{4,6}() switch skb->dev to the target device. If that
device's neighbour is incomplete the packet is parked on its arp_queue with
the original route's dst; draining the queue re-looks the neighbour up from
that dst and builds the frame with the original device's link-layer header,
then transmits it on the target device.

The Fix:
Release the dst when the nexthop is supplied. That branch never consults
the route dst, so nothing that describes the route is lost, and the queue
drain keeps the target device's parking neighbour.

The release goes through skb_dst_drop_keep_metadata(), so encapsulation
parameters a route carries are handed over to a metadata dst instead of
being lost, and a metadata dst already on the packet is left in place. Both
wrappers take their existing drop path when that copy cannot be allocated,
so a packet is never sent with the stale route.

Conditions to recreate the bug:
Two network namespaces, A (10.10.0.1/24) and B (10.1.0.1/24) in one, their
veth peers in the other with only A's peer addressed (10.10.0.2/24) so B's
nexthop cannot be resolved by ARP. Resolve A's neighbour for 10.10.0.2 as
permanent and attach a cls_bpf egress program to A, with vb the index of B:

    struct bpf_redir_neigh nh = { .nh_family = AF_INET,
                                  .ipv4_nh = htonl(0x0a010002) };

    return bpf_redirect_neigh(vb, &nh, sizeof(nh), 0);

Send one packet to 10.10.0.2. It is parked on B's incomplete neighbour
for 10.1.0.2; once that neighbour becomes valid the frame leaves B
carrying A's source address and A's neighbour as the destination.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com
Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mojatatu.com/
Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1 -> v2:
- Do not drop a dst that is not a route, and keep the encapsulation
  parameters a route carries: the release goes through a helper that moves
  them onto a metadata dst first (new 2/4), and a copy that cannot be
  allocated drops the packet instead of sending it with the stale route.

 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2d574ae52c4b..4980fb8db299 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 		skb_dst_set(skb, dst);
 	} else if (nh->nh_family != AF_INET6) {
 		goto out_drop;
+	} else if (!skb_dst_drop_keep_metadata(skb)) {
+		goto out_drop;
 	}
 
 	err = bpf_out_neigh_v6(net, skb, dev, nh);
@@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 
 		skb_dst_drop(skb);
 		skb_dst_set(skb, &rt->dst);
+	} else if (!skb_dst_drop_keep_metadata(skb)) {
+		goto out_drop;
 	}
 
 	err = bpf_out_neigh_v4(net, skb, dev, nh);
-- 
2.43.0

