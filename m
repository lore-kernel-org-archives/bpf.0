Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014512;
	b=MHlByVcVvKCLYOnUFbunEJSJRhfrKtNm2ul5OdE2+D/bCa5eIKg0c/teGNYW4X3bmGdL
	 vpMp2Yzu/QT0k2lTr0H7M4L6xUd+aumA50Is7hOnxZiaFhN8RNz2+o4dId/2fZPcSP73G
	 pe5BFiSBNTmCUOqGoxPU0UCp72PPZc1dTKVLFy9EwE7Y29xrbfaybEXCJPi2WsyzKxmfe
	 4IHISjuYHjXl7nIQhGCwOuFQiR+SV7NF34C4fS68ZjiRzDU/gLN1R7DKDX/wbsD3y3MJP
	 oDQZnMVF7yjFI56qygxp6g8L5wiZEUi7wUsz7rUi+ocVc2x6jEy6ps3JqGaHTdzKUiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014512;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=m1ZNuz2XvgTICjD4dKx1tmn+c6cIPSi7406A8Wc/VPk=;
	b=MBr8Jzf3yh70fKGvIDMObvVTesxYXmXH/R4WU17dXYesru7eufigvwGSh4WznvXKkxKe
	 3JgJ7tK8tG+WrwSMu9LDSSucsYnIhAJ52KWhvqCTlBYWljdB+eZxU/wEdxvSlm1qaUfZ7
	 55e7o1CCvIOzmMjzjarehDKcfRszrp8DsTo6Ko1Yu24B67wX26hSLyJXvtJ3XP0EDWzoB
	 yOhatGeIyPLZDPKtOfxiZgiKIr+CtoVEM0KwmIc+ebwZYRNdaC8OvVk5S6mf/rFWkqdgj
	 mq1ZmgQL1McQEzyyr5Xj98T8/bplEc0kfGWu/vgfoSxHUFJwxHkb+u1Q3m8MAVz0AkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=T7ufADa2;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=WQrK2KaO;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C448860A2604;
	Wed, 18 Nov 2026 15:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C448860A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=T7ufADa2;
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=WQrK2KaO
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7XIO012188;
	Wed, 18 Nov 2026 16:07:38 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 3CC7C122948;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1ZNuz2XvgTICjD4dKx1tmn+c6cIPSi7406A8Wc/VPk=;
	b=T7ufADa2hAC2G+d2pzvy15dKm1AFCZ2tQd1O6/kOGH5N6sfqcOmb4ZVqD1Q1gp8X8ke4AH
	wWnvvvH8p7R6p+DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1ZNuz2XvgTICjD4dKx1tmn+c6cIPSi7406A8Wc/VPk=;
	b=WQrK2KaOz/FAeQtDI2fCLwg08GSed24M4jMjys5Vr+kZ4r0HroePi4AgoYtYGOHGXPWTjT
	Q8tKPiE3nnng9I3ggXrj2zPIDDPI4Zmn+r3C1PhcsU1HzsrDueiSPyWAOc4PeNAREqJsMK
	vkIUmIKgusnbgp6Un6LYoGt94dwTd7vZef6Wmp8QuoSHASmg9bpMJiRlJKlTyij+EutHOs
	w/20YtIBifYkJoLMAtf6MmzTMXzo+qKg9oj1wYUh9l/i0sWJab79jbGDoBZ8nXXR4NNlxs
	4Rzn88ujfDE96wyxVM+jxpv/So5jR+SbFi3AKlSVYj+TmQ+aB3Eh8fC3qyJvSQ==
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
Subject: [PATCH net v2 1/6] seg6: fix skb checksum update helpers
Date: Wed, 18 Nov 2026 16:02:46 +0100
Message-Id: <20261118150251.65-2-andrea.mayer@uniroma2.it>
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
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
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

