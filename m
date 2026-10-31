Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487142;
	b=d2kMmZWeK2YT630b3gGAVayZljrBFY7mTXZFgfhRns2GSyZYa6zljlJbH1zRdZ0RmkCg
	 EhKs4K192IANp4QEjlaA8G+zN1ypGlnrNYb+IaSCmfNT+baLDkKYLLAPIMA+hbYJnUJDo
	 CoeU2Yel6iSlEsFefOn+pzII6MIXokMm+v8xx9GRsqIU8ATjqZWHxDUu8Q8VJqv/TNaab
	 C9R5OdteAwGcw7EIduravbkMmvqgDFkJVaKoQG2mPHdiZaZJmGnwLX1n5FghM+pcn2XRA
	 SuN9vhrDea4KFZwqUEVz4zrbqNrNyeVkghhg+DXLRau8ApSDM9hDsPYSQpSLi34MEsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=lY5rZikPuT99XWMY8+HAaXAbjrVFlbn2PfEKSg7534A=;
	b=uvG6j5fBuqqRhvb3yQyUONpiRY0zaDiIWfqEO4RpmHOARe7QlBMXhOSWzn2/36XyEVyu
	 CIHcn01XL9KthY4ICGd0QS5M13CC2ThhpWySJvpynro5w75YJeis1cyk7nC8xL4tz3vEZ
	 vazC1DTb+CxXacJ91SnvVzioj+JNi44JNMaE22/r4Jicfy8rrVxvKQ2L67wSZXAirF57V
	 M950+ASZOrCWaI7iFltGtw7rhdHvMVRPY1MDk4QRfu4OM2Sri37MDSrR0Je7yGXzvglPY
	 J2XgBC3gj/Do94OKFpOqYOfAI/wIWCgQCzmy502AfW2retfmpjUnFoaZhNaNJj5T22Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b="wk/kgJ5L";
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=QQf0V8tn;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B48606A320;
	Sat, 31 Oct 2026 22:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33B48606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=wk/kgJ5L;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=QQf0V8tn
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69VMpGEY021943;
	Sat, 31 Oct 2026 23:51:21 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id BFEE5122930;
	Sat, 31 Oct 2026 23:51:11 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793487071; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lY5rZikPuT99XWMY8+HAaXAbjrVFlbn2PfEKSg7534A=;
	b=wk/kgJ5Lfa99YS1CGkBrbF29C18xo0epH2XHFb4Z0kWP6JNVUNpyPziqYWTpjqVGqEmPsF
	XEn1tK4JshccOKAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793487071; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lY5rZikPuT99XWMY8+HAaXAbjrVFlbn2PfEKSg7534A=;
	b=QQf0V8tn4PqQ89cc/HfsFAOC69VKLW3naWTIqTX+kKmQbMQFwqtu/G5WDluI0inSxrnUHx
	fStit+e4IhTu0xa3xTyXw970AHOLO0jZ/UUgZn0K8/YvL7Y42nuNEv3vw0C0F74XSYd7Sr
	8IkPwOFFbDf0jJR0KgSw6nAnPkaCEwmOTkQ8N7Oo8+SgZkJ0x6iNZSZvw/3LVNvx1bEG0D
	nzsxujt4wORkoMnWq7xmicz5GygJFL54droOyOS6siUJp8dKXIf/MvD6kaEmpIbKyh+g/M
	zZ3AWXphEq2CUBWjKetmtZU76vbAUtnm5xnRVmnJNAHDsBBotK9Ij0VyrcbEvQ==
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
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Andrea Mayer <andrea@common-net.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net 2/6] seg6: update skb checksum when ipv6_srh_rcv() decrements the Hop Limit
Date: Sat, 31 Oct 2026 23:50:29 +0100
Message-Id: <20261031225033.64-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261031225033.64-1-andrea.mayer@uniroma2.it>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
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
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/exthdrs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 96c8402a27a5..9d3ba310065a 100644
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

