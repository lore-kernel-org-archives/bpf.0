Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487142;
	b=iNEqlO/IJ+ACQByLEcNMgjZhMYAucZ6iHjhR7+glCga3Fb6SO7g3ZDMhVLQgjdkNeF4E
	 jpNcQKnmURG+NdQYNGROKDSFHsfTlpKDyvbtYhiVl4yC5nd4ECYsqwPBKKQLqcy0OP5Yh
	 QBTaVyejikQ7O12dEJ/06ceI+MegVKvPpxoatejTcUf8qFWtzn32XUkPn03CFlUhNuvq2
	 BPPcrakFwk5ZbgAa0+asXpCFJr16eFb3uGD5G/14p9lNPZo1NVejOTSHLa3CMPEqUdG1W
	 QwF3587m/iA6Bkhcl1DW5tV2TnRfs87npKCIM3OesagFy+s4EkvaJB/rhmf71PrR+oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487142;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=YtcXc7aLOndtCVpRibayt2mWzlaxCsEW5ery43WlDls=;
	b=YCOK1LxrXIl/qSlEANutTkS+6+XUhvydIN/xqherrcK0KSQQlyFHmINYXGRcwu4cNOm9
	 iOfk5zGDosT1IUbU7ja/KmOQKy79cLQYv8Im+8CgkC6q+IE6kUDihlS9prSzkk/kJg+2r
	 1CVEojYgFi2PRtSKxmzVppgPjFVqWP5sjlij6h9y+J0HeJUucEcggbCW7gJoTX7Y6HBj0
	 G/0tq1A2pr9XL5o3XksIN8YYDzPpAQXXnmDzD0ACIObp2Byl8V4xFj5KscYTiU8VKLdTm
	 jzUyOML0DYJYUE64BpPV4w7TIlOEMsTQJ4khC4KkkHdnR+VIRArrkQLRcqyS53yMsuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=temperror header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=IR2DuHuu;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=aN2Jpu8p;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252D3606A31F;
	Sat, 31 Oct 2026 22:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 252D3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=IR2DuHuu;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=aN2Jpu8p
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69VMpGxJ021942;
	Sat, 31 Oct 2026 23:51:21 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id AD5E31228D4;
	Sat, 31 Oct 2026 23:51:11 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793487071; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtcXc7aLOndtCVpRibayt2mWzlaxCsEW5ery43WlDls=;
	b=IR2DuHuutlfeKKSfRFKKMkyfHerCF3SjU+TYJayX+AGn2IZhbfoSBE4ednONFnz716i+8X
	pxjbqG8GX8QQ3xCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793487071; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtcXc7aLOndtCVpRibayt2mWzlaxCsEW5ery43WlDls=;
	b=aN2Jpu8pGj1Wr+BvQH7769YJVM1ocom2NVnkUUN1cCd1fU0LfTpMJvp+CsrLNz04auny6R
	prY6GdsTICB/vJMC9+V8JJLu0QkEJj2LeCH/aiuYv40SWKVxmu4yy+gwcN4b1fAxnwYQJC
	cuA1SD+ceiOR+k4Z+OsV299mL1T7LcGA2NW2aNHLjAMZOcYGBuGNMkabuhQ9W/hc7PAw7M
	eSECgQ8+1ZW2x/Br4W+qDaLQfwnRAOL++7s94NFG6JH511TeeVIqmWHCkNZ8x+u571/pfA
	hys0Vn3xR0dBIYZxdZBy5RG9JlLCizX25sXtvMb5jYsQbnMuHfy/GlohFFGRuw==
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
Subject: [PATCH net 1/6] seg6: fix skb checksum update helpers
Date: Sat, 31 Oct 2026 23:50:28 +0100
Message-Id: <20261031225033.64-2-andrea.mayer@uniroma2.it>
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

With CHECKSUM_COMPLETE, ipv6_srh_rcv() updates skb->csum for the new
Segments Left and destination address through seg6_update_csum().
Replacing "from" with "to" in the packet must change skb->csum (C) to
C - from + to, but update_csum_diff4() and update_csum_diff16() compute:

  ~csum_partial({ ~from, to }, ~C) = ~(~C + ~from + to) = C + from - to

This does not affect packets forwarded by ip6_forward(), which sets
ip_summed to CHECKSUM_NONE. But when the packet is delivered on the same
node and skb->csum was computed in software, for instance by conntrack, UDP
can drop the packet as a checksum error. With skb->csum computed by the
device, TCP can instead log a "hw csum failure", as if the device had
computed a wrong skb->csum.

Fix update_csum_diff4() and update_csum_diff16() to compute C - from + to.

Found by manual code inspection, while checking that the skb->csum updates
in the SRv6 receive path are consistent. A following commit adds a selftest
that reproduces the problem with a tc ct action. The issue was confirmed in
a VM without kernel changes or error injection: with the rest of this
series and without this patch, that selftest fails, as UDP drops datagrams
as checksum errors. Also tested against the srv6 selftests, and with a
ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.

Fixes: 1ababeba4a21 ("ipv6: implement dataplane support for rthdr type 4 (Segment Routing Header)")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 include/net/seg6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/seg6.h b/include/net/seg6.h
index 82b3fbbcbb93..01d8034e48fc 100644
--- a/include/net/seg6.h
+++ b/include/net/seg6.h
@@ -19,7 +19,7 @@ static inline void update_csum_diff4(struct sk_buff *skb, __be32 from,
 {
 	__be32 diff[] = { ~from, to };
 
-	skb->csum = ~csum_partial((char *)diff, sizeof(diff), ~skb->csum);
+	skb->csum = csum_partial(diff, sizeof(diff), skb->csum);
 }
 
 static inline void update_csum_diff16(struct sk_buff *skb, __be32 *from,
@@ -30,7 +30,7 @@ static inline void update_csum_diff16(struct sk_buff *skb, __be32 *from,
 		to[0], to[1], to[2], to[3],
 	};
 
-	skb->csum = ~csum_partial((char *)diff, sizeof(diff), ~skb->csum);
+	skb->csum = csum_partial(diff, sizeof(diff), skb->csum);
 }
 
 struct seg6_pernet_data {
-- 
2.43.0

