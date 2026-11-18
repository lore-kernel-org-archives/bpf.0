Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014507;
	b=T9l4c1qemYr67aa7Dwet5UR9SD7NYTDL27UJfJnduVel+YIjpL9S2NAMRR6ZWNI63Ewa
	 2cTjIqu9t3DrLfFgxJBlzY+N9fuXgGe3MokFQCNfO/2WJuEWMQNKxwA1yKqCTjqr4Ok/T
	 Vu1cTDubvvSelJ9Ytw1aKetHihOiw/qhvTmVlN7lqBQNuVUoaySThKBjmMwKCTQICqGpR
	 XHAEpraEF0yifDB0N3ImsvYV9ich56sKXcIblXziavKYThdxrCX099hSyz8ff7xpyf2hn
	 pYqWnux2cdd3CRGassr1WlMaOALWRPmq6m+7r4kLZjc9VeFUF5AVd9qvK8Wo5KUUbCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014507;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=IXp1PQ0ZNJxKwPwF3VU8BniYZW9I1KwvZI5t+Y9ypkM=;
	b=F3sY8rK55EKElsqlPulU6IC+jSU1HI7kUfVC90ccYmHybkFL/6DReJ4Qgpxey8Jp1/cG
	 v2g21qbOCF5qLePtZc2iS/gYa61fFKocc2cawr58po4W66W1VAYs2KWHD0p3TZimjS53x
	 8BQ1iI1dE2Jfg3VHL0ExFAQUxSFzAXxBOYstDgoSIQBZ2Uhnk0ufDjzeuaLeSdQAxOmpN
	 xzqO2Vy9v7RTo5C/m4WJQoluZwGOTQ/MvOBp+Mog/k5Iqa4l5IfeGQMaVai1+1yNBj538
	 GgqmwQYJwJTFNr/9bmxyQzuhl2ji91xMFgLLPuJZlRU6GhGkdiInWh2YgZtvm7JDmGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=MtIsfFVq;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=Q0aTTieC;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B2606A31C;
	Wed, 18 Nov 2026 15:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A09B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=MtIsfFVq;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=Q0aTTieC
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7YO7012192;
	Wed, 18 Nov 2026 16:07:39 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 72EE5120065;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXp1PQ0ZNJxKwPwF3VU8BniYZW9I1KwvZI5t+Y9ypkM=;
	b=MtIsfFVqokLTs+MjcV7pfLsLr6+pqjyXI5uLm3B4KBEzPl/XHzyV4Sd+mZiONg03p6pzMu
	LO4YRUJQvJcsq8Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXp1PQ0ZNJxKwPwF3VU8BniYZW9I1KwvZI5t+Y9ypkM=;
	b=Q0aTTieC9L4J4Gcv/7Gs/InoNH+1yGOUIyFR0kH/wlrmAe3uypHnM3E5TlNgfRYgQsRAbe
	QCJBvFROO1rkaLHYJ7G1ZenFLHmIf4TYYMkglX2mmA5yQzQuQep2raVaji5QZd8QfX9zOh
	m6hy0X0bpogjXUOMpJgdwRVFRKGLmpZ9Jrz6eo5KvfX2DUHkz/GjMDnRW/QUz5eAtKxXwf
	LdSkyEICVpdHoxQXG8rdIGj7oZUKMqe6Po9VTWkYirbw6LrPMU3FTbvBBIbaqQ9N2C0D3q
	dA2nvXABQiQb3C6d52bG5LV4W/XBqdmWf/4T5L+KSAJBnyILHVnZp/hw3nHYsQ==
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
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net v2 4/6] seg6: discard CHECKSUM_COMPLETE after the End.BPF program
Date: Wed, 18 Nov 2026 16:02:49 +0100
Message-Id: <20261118150251.65-5-andrea.mayer@uniroma2.it>
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

The End.BPF program can change the packet through the seg6 BPF helpers,
for instance the SRH Tag with bpf_lwt_seg6_store_bytes(). After the
program, seg6_bpf_has_valid_srh() can also rewrite the SRH Hdr Ext Len.

With CHECKSUM_COMPLETE, the program does not always update skb->csum for
the bytes it writes, and seg6_bpf_has_valid_srh() does not either. If the
packet is then delivered on the same node and skb->csum was computed in
software, for instance by conntrack, UDP can drop the packet as a checksum
error. With skb->csum computed by the device, TCP can instead log a
"hw csum failure", as if the device had computed a wrong skb->csum.

Discard CHECKSUM_COMPLETE with skb_checksum_complete_unset() after the
program, since input_action_end_bpf() does not know which bytes the program
changed. The checksum is then verified in software.

Found by manual code inspection and reproduced in a VM without kernel
changes or error injection: with skb->csum computed by a tc ct action, an
End.BPF program that writes the SRH Tag, followed by End.B6.Encaps and a
local End.DT6 SID, makes UDP drop the packet. With this patch, the packet
is delivered. Also tested against the srv6 selftests, the lwt_seg6local
BPF selftest, and with a ConnectX-6 Lx NIC (mlx5) that provides
CHECKSUM_COMPLETE.

Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 56c6be841e53..f7e1bbc6e9f9 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1661,6 +1661,12 @@ static int input_action_end_bpf(struct sk_buff *skb,
 		goto drop;
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
 
+	/* The program may have changed the packet and seg6_bpf_has_valid_srh()
+	 * may have rewritten the SRH Hdr Ext Len.
+	 * skb->csum may then no longer be the checksum of the full packet.
+	 */
+	skb_checksum_complete_unset(skb);
+
 	if (ret != BPF_REDIRECT)
 		seg6_lookup_nexthop(skb, NULL, 0);
 
-- 
2.43.0

