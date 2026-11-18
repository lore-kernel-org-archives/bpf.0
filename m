Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014514;
	b=S0vLn3xmK3dsEwBegEg8aoGtT5z8Si9yu0TI1vNAZkNQy0tlgpFaUjiAAtU/7CMiM1mk
	 pHEK+rF/ywLCpgayvZaV0Nv7qgu2bompYMNWUbOC5nyyXDh1eFDGSR9N/gxgn/hukW8+t
	 0flWp7u4jGYyGRXjF3wcxk4noO62IEzUqtt9JLilILR6PSyyY+iTHGAYkXxzKKrHm5iQU
	 n6aEpbH0suC8t6zv/GPYKL8mvFwjulH2nsteUOETrU6vgeBAzAj8my81h4uhFPRHgobxH
	 GpBNTaSQtjnCHPOT2KX3QOUcMcVTQygazp/W46Z9+KDv+fuiWCQwh0v+ILxjRwwi0FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014514;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=RIPd03u4yxwkDsmd17NHx4ShHRyaU/DFX1SDrq8mdvk=;
	b=qUV9/hXDrKbrFug/Y6L4+IEBMoiVKC5VfcYJSqeu22prnHcMeW2r+OGCNS9jC4PPWi9I
	 tRPFxoTlyZ3RBLiUAO5BMHU3ndA33Kz9LfkUuETpAVFAoVtAYh9mNwx6U8gUX1Gr0JBsk
	 T4eJwIys7Xh2hUfn26hhw+yTvCJtWfYMe3mcKenDTWUEDefvIgDSey+/bzS0LWNl875Sz
	 r82GMR2Tfp6Rxuar0VgCEafKxnXqSc6KoGn91o9fCmO8HutlIGsrBxtnwvoM8a3gRH8kW
	 qJbqk7htJCZVk8TNaGOGognEukgCVD9WDGgYSSfZVLL7RypE1XsgyRYwrE5RCUavx1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=w6xIoIsQ;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=pO41oc+f;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA13A60A263E;
	Wed, 18 Nov 2026 15:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA13A60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=w6xIoIsQ;
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=pO41oc+f
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 6AIF7Nwq012178;
	Wed, 18 Nov 2026 16:07:28 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 60CB8122957;
	Wed, 18 Nov 2026 16:07:30 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIPd03u4yxwkDsmd17NHx4ShHRyaU/DFX1SDrq8mdvk=;
	b=w6xIoIsQzt8w1hfY7N5yoBGzDPtwDMvHb9hplGJjZgF6IAKczorYlC3UTASsHm40+YP9+j
	+y8QlaGwUi/omODQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1795014450; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIPd03u4yxwkDsmd17NHx4ShHRyaU/DFX1SDrq8mdvk=;
	b=pO41oc+fWIFJx+Jt9xYtQsNhWfl+g4GHcwyG4f7mHGjdgttS5O1rFUxelq5eHoHwTmE0vs
	SH9/voOuIx4FOCSbnGFb8NG2UAVfb6mn5YTXQ8h7UCYEYUZac3cz7AsBkKnJTmYlG61W1R
	Oivfu8UyDvbC6MMeyupd3Cqp/sjzzcdq9dQlaFlbNgpN67PRpobozM/qus8G6nMjUOLUwu
	E3fyfx2z/se4bbsvyQrsjc7ocoDU7SxOPOEoMFyZa1BSLpLjAbAYvA4BpQwC2PxjvsB+e9
	r8axL8mIWKcxa9/qd+Vz+f14F57uN1IW3WND839j/42yXiioGwXGF2+TapB6Ow==
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
Subject: [PATCH net v2 3/6] seg6: update skb checksum when SRv6 behaviors advance to the next SID
Date: Wed, 18 Nov 2026 16:02:48 +0100
Message-Id: <20261118150251.65-4-andrea.mayer@uniroma2.it>
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

advance_nextseg() decrements Segments Left and writes the next segment into
the destination address, and seg6_next_csid_advance_arg() advances the
NEXT-C-SID argument in the destination address.
With CHECKSUM_COMPLETE, neither updates skb->csum for these changes. The
stale skb->csum is read when the packet is delivered on the same node, e.g.
through End.B6.Encaps towards a local End.DT6 SID.
As a consequence, when skb->csum is computed in software, for instance by
conntrack, UDP can drop the packet as a checksum error. With skb->csum
computed by the device, TCP can instead log a "hw csum failure", as if the
device had computed a wrong skb->csum.

Update skb->csum in both functions with update_csum_diff16() for the
destination address. advance_nextseg() also uses update_csum_diff4() for
Segments Left.

Depends on patch "seg6: fix skb checksum update helpers".

Found by manual code inspection while working on
commit 8ae3f4067ba4 ("seg6: ensure packet data is writable before modifying
SRH and IPv6 DA"), and reproduced in a VM without kernel changes or error
injection. A following commit adds a selftest that reproduces the problem
with a tc ct action. With this patch, the selftest passes for the
End.B6.Encaps and next-csid paths. Also tested against the srv6 selftests,
and with a ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.

Fixes: 140f04c33bbc ("ipv6: sr: implement several seg6local actions")
Fixes: 848f3c0d4769 ("seg6: add NEXT-C-SID support for SRv6 End behavior")
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 82207da08dfd..56c6be841e53 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -305,7 +305,9 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
 					   struct ipv6_sr_hdr *srh,
 					   enum skb_drop_reason *reason)
 {
+	struct in6_addr *daddr;
 	struct in6_addr *addr;
+	__be32 old;
 	int srhoff;
 	int wlen;
 
@@ -323,10 +325,19 @@ static struct ipv6_sr_hdr *advance_nextseg(struct sk_buff *skb,
 
 	/* skb_ensure_writable() may change skb pointers; evaluate srh again */
 	srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
+	daddr = &ipv6_hdr(skb)->daddr;
+	/* nexthdr, hdrlen, type and segments_left */
+	old = *(__be32 *)srh;
 
 	srh->segments_left--;
 	addr = srh->segments + srh->segments_left;
-	ipv6_hdr(skb)->daddr = *addr;
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE) {
+		update_csum_diff4(skb, old, *(__be32 *)srh);
+		update_csum_diff16(skb, (__be32 *)daddr, (__be32 *)addr);
+	}
+
+	*daddr = *addr;
 
 	return srh;
 }
@@ -441,11 +452,13 @@ seg6_next_csid_advance_arg(struct sk_buff *skb,
 	__u8 fnc_octects = seg6_flv_lcnode_func_octects(finfo);
 	__u8 blk_octects = seg6_flv_lcblock_octects(finfo);
 	struct in6_addr *addr;
+	struct in6_addr old;
 
 	if (unlikely(skb_ensure_writable(skb, sizeof(struct ipv6hdr))))
 		return SKB_DROP_REASON_NOMEM;
 
 	addr = &ipv6_hdr(skb)->daddr;
+	old = *addr;
 
 	/* advance DA.Argument */
 	memmove(&addr->s6_addr[blk_octects],
@@ -454,6 +467,9 @@ seg6_next_csid_advance_arg(struct sk_buff *skb,
 
 	memset(&addr->s6_addr[16 - fnc_octects], 0x00, fnc_octects);
 
+	if (skb->ip_summed == CHECKSUM_COMPLETE)
+		update_csum_diff16(skb, (__be32 *)&old, (__be32 *)addr);
+
 	return SKB_NOT_DROPPED_YET;
 }
 
-- 
2.43.0

