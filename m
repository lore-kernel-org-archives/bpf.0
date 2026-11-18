Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014507;
	b=1hZ3YN0y3lxoP1Euchxs7pABYEnBT9ZOVLmwyDctVSGoeMoYyeDATZgaG7Df2Od98kTU
	 Pli5q7x7a2fqd8oK7PBXoRJ9z8lVkHKt4MQXfES5QxgWnJARPdmK5DAwLb/88XjYRt6lT
	 7UZ7PA+4yusX25mMmtErGgXDTY9wUOjJPvhU5lBNq3Wqlxldt3ZiQXWRs5hB+vnzg/yyD
	 GsoIrE4ibJpHsLrvZXqyqTOSiA2LN+4tztXJcGLsEpmqzWsD1zHse2ifVXuQXlrFh3D7D
	 tp8BmhlFxw0pm1Z2AwFYudnMfQjA3dTSqXR9utUE8XBxcRvISMTxQ3o94Yygqwi4hYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014507;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=aVn/ArHYS+F32rCgWBSVdfTDPd9m/hfMb2gLFN3Dy0E=;
	b=jKdWKLuS+MzKVUKxET0uxKC+lghjWTcVJdImmXiK5UI2ehAC4+EvWnLlQoGA/L2JZU9l
	 //cTuxRlG66Sfubpn4HJ+Ce6EmQq50vL/8Gf0UVPddf8t24DUHtRinpBVMAYdK7qsmfTr
	 lhEqffZnjBI1eWMtTIfdBbAhUj2V1tWQFfBpFQx5ihs1iOFIyKkMlW0fPtlm/hcZGJE+H
	 HKDsAQGXWclRaIetioDPoyxgJECFIPFJnjy7xd27pX27J8LhAvA9fcRXVn3o+u1X0DIgs
	 rZYiJV9cF/ow9fx6OD5MmoMZDf7unMo+0NzghV6ZsoMf5534X5heV+I5WzbbVqSZa/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=AUekIQLc;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=mf0AxqsC;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742BE606A32A;
	Wed, 18 Nov 2026 15:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 742BE606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=AUekIQLc;
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=mf0AxqsC
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7XdA012189;
	Wed, 18 Nov 2026 16:07:38 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 4DC55122956;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVn/ArHYS+F32rCgWBSVdfTDPd9m/hfMb2gLFN3Dy0E=;
	b=AUekIQLcSJQNBuvoTpqHqmUhJ57RHKMvaRGPm4lCFsIc70ZFz/4zv24iBN8GE2p1IfREXU
	RKhf194+CQSIY9DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aVn/ArHYS+F32rCgWBSVdfTDPd9m/hfMb2gLFN3Dy0E=;
	b=mf0AxqsCDB9mMSCbbr0uJd9NcqU4zfV7LyxoK70wR+lHtkp6OB7NFYNefKg7SsKMFicnFP
	g2aYZbc3+fUT+I8O4TpvUQtoS9CdnXQusz8Ie7753lNSmhDzWpc18y4PlWEchWwwNXRzRG
	BcSbLSVWlLBimhHnnb5HHFW3JYwzYr+GumrTe1xzEJSYLtKIj0C/R/zg3ml/1+zvTc8Yj1
	T1XG5szs/iMp4pQ32phxGDaMZB0s5ANs9Ov6yco2U/SIS+QnHuWtTBVB63ACiGrBDw178N
	z/jkxz4CVbY+yQL0IPBehg2Mf65lg8/oa2GnBBWYhVxr7ivePPQAvhgFMkl14A==
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        David Lebrun <david.lebrun@uclouvain.be>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mathieu Xhonneux <m.xhonneux@gmail.com>,
        David Lebrun <dlebrun@google.com>, Hangbin Liu <hangbin.liu@linux.dev>,
        Justin Iurman <justin.iurman@gmail.com>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        Hangbin Liu <liuhangbin@kylinos.cn>
Subject: [PATCH net v2 2/6] seg6: update skb checksum when ipv6_srh_rcv() decrements the Hop Limit
Date: Wed, 18 Nov 2026 16:02:47 +0100
Message-Id: <20261118150251.65-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118150251.65-1-andrea.mayer@uniroma2.it>
References: <20261118150251.65-1-andrea.mayer@uniroma2.it>
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
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

When the next segment is a local address, ipv6_srh_rcv() processes it
directly and also decrements the Hop Limit. With CHECKSUM_COMPLETE,
skb->csum is not updated for this change. If the packet is then delivered
on the same node and skb->csum was computed in software, for instance by
conntrack, UDP can drop the packet as a checksum error. With skb->csum
computed by the device, TCP can instead log a "hw csum failure", as if the
device had computed a wrong skb->csum.

Update skb->csum for the Hop Limit decrement with update_csum_diff4().

Depends on patch "seg6: fix skb checksum update helpers".

Found by manual code inspection, and reproduced in a VM without kernel
changes or error injection. A following commit adds a selftest that
reproduces the problem with a tc ct action. With this patch, the selftest
passes for the path with local SRH segments. Also tested against the srv6
selftests, and with a ConnectX-6 Lx NIC (mlx5) that provides
CHECKSUM_COMPLETE.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/exthdrs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index ccc549de3c8a..b8dff6a0bbc4 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -460,6 +460,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 	}
 
 	if (skb_dst_dev(skb)->flags & IFF_LOOPBACK) {
+		/* payload_len, nexthdr and hop_limit */
+		__be32 *hlim_word = (__be32 *)ipv6_hdr(skb) + 1;
+		__be32 old;
+
 		if (ipv6_hdr(skb)->hop_limit <= 1) {
 			__IP6_INC_STATS(net, idev, IPSTATS_MIB_INHDRERRORS);
 			icmpv6_send(skb, ICMPV6_TIME_EXCEED,
@@ -467,8 +471,12 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 			kfree_skb_reason(skb, SKB_DROP_REASON_IP_TTL_EXCEEDED);
 			return -1;
 		}
+		old = *hlim_word;
 		ipv6_hdr(skb)->hop_limit--;
 
+		if (skb->ip_summed == CHECKSUM_COMPLETE)
+			update_csum_diff4(skb, old, *hlim_word);
+
 		skb_pull(skb, skb_transport_offset(skb));
 		goto looped_back;
 	}
-- 
2.43.0

