Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487143;
	b=vRnlTHRdhwdAMfEN3WWprE3KhS1TM5YPKBdJ3aTuWqU8IzGd1CTQ5TDTXVPf6ngcfwPl
	 jnFhFI/aW4Wc/dXEp32yH7xpmc/eK87JBh64/x9m3qheG3YVirERHP5z1Ld7YM6WKwgb/
	 ykpMUqdE4dCJpFvmYfDJHiPyrmrUVGeX3pNdPyIFfN4cfhJhNzkjcuSfv4BLoHvYSPNHc
	 i7FqKd/Se4khikgF/Y9UuiKSUGPPdE4HzSTZDsI2BFSicllh7f8CcfarZbYgs3hSDmcG8
	 U8oohteLdyIAp4dp3sGGnAzug3Ebtu4p0t1mFa1j3WnjN3uBrRSQeeNkAPxDoWYmfRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487143;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=bK4w1yMKnR9FGJtFhRyJrL+d6EWl3MZqzIXWR3zmOmk=;
	b=2qdFrPSoNUkPe9cR6VQ4egDn84n3hk06MvI+WtJ8nXg6Z2/QL7ttGmczGFTaU71uhUhN
	 nbm1iuhhUiuLr4U8vXkiToFt82kApYj6rNnnEcwjNnBlj+bwZjLvqC0CVW6a8RR8tU9J4
	 Ag8RNsiESmmcQY7hGqNaO2n0rqrydqv2/urTnZ+1Fk+t7wOeYEK7qRqTkuprbW3XYK2A8
	 cGXvL7zWGG2UMXEfFnjYJMs7cdXH/QIJevA8aq346pq+fQZQAR5FS8R90d4gMlMXvggbk
	 4JfcpXTXhuF4sFxhTKjmokA/10PqcmeQJfEEu4LBY1D5B7Y2Xj2uAu17ywwzLkL9TCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=E3I7x+c5;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=t5RCtOui;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5A606A322;
	Sat, 31 Oct 2026 22:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1C5A606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=E3I7x+c5;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=t5RCtOui
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69VMpR8B021984;
	Sat, 31 Oct 2026 23:51:32 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 0AB62122954;
	Sat, 31 Oct 2026 23:51:12 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793487072; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK4w1yMKnR9FGJtFhRyJrL+d6EWl3MZqzIXWR3zmOmk=;
	b=E3I7x+c59ia0dZtEfqqS7U5qwtdUFli23Md1S/9PJARzagwdEN/t8Km0lPvTtlNS78lIDK
	/cfsGKlQyzn0fWBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793487072; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK4w1yMKnR9FGJtFhRyJrL+d6EWl3MZqzIXWR3zmOmk=;
	b=t5RCtOuijMPHSJV3sJrONmM3QJXHfz0CHdp2TcydULY2hXg05q6TvauETd6S2owMVJ5IUG
	vHkhC4D5fJuVyNW3J1wPDKSgt5ysCpNsRmz2jB45dOFshAaNmGiL2/sq8iUbB9TPHgCg86
	JzyNcJpw3qmGvfJ7f7rmPW3CfIb538zTV96Ij5pH0j/Zm2U1ltJRrUb3MVZ7uZ8GXVjLwk
	ERLiwjXVoF7b3gK/pfU3lJYOTKl8FwQivD09S1wLGdwT4RHuxWgeSs9NJmLddou1om8h9k
	6BseQknCFoS7757sQWc8GDE5X0l9wK/4N9UwbBRq1DR68stXUypC6yuMOq0dcw==
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
Subject: [PATCH net 5/6] seg6: account for the MAC header in skb checksum on L2 encapsulation
Date: Sat, 31 Oct 2026 23:50:32 +0100
Message-Id: <20261031225033.64-6-andrea.mayer@uniroma2.it>
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

In L2ENCAP and L2ENCAP_RED mode, seg6_do_srh() puts the MAC header back
in front of the frame with skb_push(), without adding it to skb->csum.
The encapsulation then calls skb_postpush_rcsum() only for the outer
headers. With CHECKSUM_COMPLETE the MAC header is missing from
skb->csum, which no longer covers the whole packet as required.

For a forwarded packet, ip6_forward() sets ip_summed to CHECKSUM_NONE with
skb_forward_csum(), and End.DX2 does the same before sending the frame.
When the packet is delivered on the same node, a raw socket with
IPV6_CHECKSUM still reads skb->csum. With skb->csum computed by the device,
the kernel can then log a "hw csum failure", as if the device had computed
a wrong skb->csum.

Use skb_push_rcsum(), which also calls skb_postpush_rcsum() for the MAC
header.

Found by manual code inspection of the skb->csum updates in the SRv6 code,
and observed in a VM without kernel changes or error injection: with
skb->csum computed by a tc ct action, a BPF tracing program on
ip6_forward() shows skb->csum missing the MAC header. With this patch,
skb->csum covers it. Also tested against the srv6 selftests, and with a
ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.

Fixes: 38ee7f2d4756 ("ipv6: sr: add support for encapsulation of L2 frames")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 0d39a38a5dd2..3821d8e1409e 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -456,7 +456,7 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 			return err;
 
 		skb_mac_header_rebuild(skb);
-		skb_push(skb, skb->mac_len);
+		skb_push_rcsum(skb, skb->mac_len);
 
 		if (tinfo->mode == SEG6_IPTUN_MODE_L2ENCAP)
 			err = __seg6_do_srh_encap(skb, tinfo->srh,
-- 
2.43.0

