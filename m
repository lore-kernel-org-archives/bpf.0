Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737966;
	b=jMqyTMeDe2rFqSne1f0N/0tQotVusrWCk4O+4Gthxzf+KAHfQuCooos+ahxDvopjkF6D
	 KT2oqJS3LrzspuLQa4DQVzWruqft4QYRaOTL9Ex0ao2O24NjkvWD1SvxC1AflULD8NLw6
	 M++G2ZSg1JkrcaJc3wNuhh9nyN5VpaevFTk0CNzXMf+Axa4ykWFqPYwFj/kUM7vHFuJNK
	 f1QmyaQghcErJu6QT6Yjug3En04J6VSP+PEG5D7KHN3/5ikQZmZ1p3SSfBuJlbNdxk+pi
	 wzK7jHuudQxWRFy2HHztcoPwxi5/YL4Z1sxRodA21yKU5t0b5go90QKuU7ert/8IyVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7/GM6+U/65nqtViXkrPAxR1Old8xs3zW47itheeRLoo=;
	b=QDw86uFrMKZUzoHl89uwJpts2AsO6gPTbvABM/hgZUACmUj5mUIQw27Y8abdrmOfVuF6
	 NKYzN7iAEUVRRzgN4x032BNur2Rssojpj7i5kRz/6NznKOByCtoLPEUA1SWKrcrUAQRxJ
	 q4KiQius5QAQMMcZ/+oTXUlmDHGbM8Md9Rzllkr3wZ9wBwkf4XOiTnruyI5vHkbl8QfQA
	 0w/D1vss0hDwO1g4E4CCgtNIiiIRKI+vjx6Pviv/Ho60NrObwhNywcyZ41ULACl6ElbSa
	 LZqgh+astTIm6aEjktVgig4XS3DfkSbV5q+JwKHEDXK3aSJ68MMUto2mVKRzWKidpBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rFt8QNoA;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703C606A31E
	for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 10:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1703C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=rFt8QNoA
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-94959217274so330096885a.0
        for <bpf@vger.kernel.org>; Sun, 15 Nov 2026 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794737965; x=1795342765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/GM6+U/65nqtViXkrPAxR1Old8xs3zW47itheeRLoo=;
        b=rFt8QNoAMS5qTe3CN8yYf54nuToMLRcweBvu28VjEblmU6azUP6a1b7a8pl4EN0EMS
         fmp2uxDiC9Sk12HFqImZMlBlUmUOZQMEVu/jsQborx0seX1uwBQ5AQ05MByTq2ylGwaI
         3TyxjFBp2cqOnjzrIkkat+SZZXbo7CVWKiRB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794737965; x=1795342765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/GM6+U/65nqtViXkrPAxR1Old8xs3zW47itheeRLoo=;
        b=LaAAY71BoZ+LFbjq+fvohkREPZSAJczSZrsBE+cfb/XMLagdJ7oRwfsIJ/+efLFo+X
         mNB+VHGzpSUxkk6duv0ZTbZLsRwRE+8N8mwzMd9/6GezQPTmG2FcII3Zq8Oacwt7XVmI
         3FLv23u7nODoi05RO4IywFNC6bGJHwJRzSpgDDk4dc0wm3alyEqO8IqRctg/w1LOIr2n
         oXGombAKUx82bECecUNkqTJ3YL8+hk3TPhMt5//81Te1MZUrvOl7YTW93fMrrgJW4GOs
         iI3bLBd3Cv06heKBvChsDtoNc/GFNGGyCOs8OdC+t0yGMt8It7YCjmjjzEdKVZVsTqXv
         M2aQ==
X-Forwarded-Encrypted: i=1; AL+hErGD6Q2H4BbXXNqsc8/E/T0jhkJgKv9MLderpJZ5Nz6DtZm1pb4wMXRek9djsl3hs4mGjxY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YTUBssiioeV0Fxwgz1O9BENrJjGhVId1P/n+X1uWwPyIenOz6
	qKVLP5wO5UGjVgutX408q0WPknbkIFmh6fqeaZK/kQczWdSXjHU5Rgidryu3lnucOw==
X-Gm-Gg: AYBFou3DseD7aQIqUCitlG38UJudX5M7BWvHugobETKo8bkdCYbmKA5nkte9APPJ+gU
	3t8yivmXxwGiVdAxjKcvHk77Hk2kO/rHhCWmdLpb6+GKz6km4GNQYkJ2AJ3HSFWbnYwDLgVf00G
	SIU8brnLmbbThmIUxQmuV4qteRzhehNaFS2k65se82O9172kb3N4AO7p2RCMsEXpkPUS8Br1zTi
	CIela36Va7V/msNOM98p9U2YrD/vGaL3TYr8bOht1L/gVcoUmHwPUbcix2EvfYA0vZv8sbqr0PR
	J6SWNKLd/gMDHWAlA9htifMvN9M8TL94OxQo/DMyOUM4goL5/W2UskeY2EEy8EkciNmcm6X0G+b
	S+nAyHOD3zgsrfrYN3txznRyI07Lumla6sJtTVF+AfmgctqE2/4GTAMekn59jlaA5Z7nnCyMbDR
	bxfYX9CavBogB5rb7rNtOQxInovJqYS4WnvQsISZp5d2rhYyRHOr9f1XdagU/eMJqYPvC1ZUANE
	Dw6ovpk6+4WQr6Q4Ild+RgAyNx3KJRAZR9a2NUVq4gI4hQiJ49ZbAF6sQxu4U0zbuOacYkOVhuh
	QxKRh8z4j/o57iWcGQjiYLRiX6cmcRnRaZaQ2h0SK3zrVQHXwKrbAq4SIuwyQL2HGBRCujaZMkW
	s
X-Received: by 2002:a05:620a:410e:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-9494bcaf24cmr1224410885a.81.1794737964950;
        Sun, 15 Nov 2026 02:19:24 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c6025f5sm592337085a.5.2026.11.15.02.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 02:19:24 -0800 (PST)
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
Subject: [PATCH net-next v3 4/4] bpf: drop the stale dst when redirecting to an explicit nexthop
Date: Sun, 15 Nov 2026 05:19:11 -0500
Message-Id: <CORE-9NOG.v3.r0.20261115050625-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com>
References: <CORE-9NOG.v3.r0.20261115050625@mojatatu.com>
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
 net/core/filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index bd98d29ed7f8..ae5346d6abd2 100644
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

