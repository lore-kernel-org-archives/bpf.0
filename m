Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.80.4.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487141;
	b=I6voSkbjorhMapqapMg3QQJK+HSyWubVKsrebcDnwJPA1SGja60/l74Hd2a9mig7iPKi
	 rGoAEfK9OGuW+E4R9AafEs+yUMPGTFVpGxmUAuh1cj2vL/qULJ21zrn9IzSDdamrwsqDK
	 obLjDbbwWi03ltrifpntlZT1IO91FS6ogNHXb2Q5PWkmwYitOG8ZOzFl4OIJXsW2FVlNA
	 4jGL6lCyx0NwVYmEPRwBk0mfuNWXn6aSDvDdBsbse0nCtrcsmsufiXXDGnijgza44JmP3
	 PlFGqw3sktN/CflQtrmLWiqn0WqscX9G8XaBdDjrllSzBmeuUWjGmeChozZ9XZtfkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487141;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Virus-Scanned:
	 X-Virus-Status;
	bh=V8S7mRav071ig+pdoADGRJ11FK7siUO/ISnPNSD918g=;
	b=I5LXKuMT3x+8wnoxG++0vpiUrQ0denKYqUsBedor68z+kU26BnqzfPHT7ES6K3SyF22F
	 8QJsMPmO6NknZJUaID71xo0Y4W4t3xGUla1/zSH0QvBTwJvfhi/iad2bdxz36z7MmBVQ9
	 wftI8xfshb33aF5kgPuvkwW3e1V8XRkHBSCCcy3PWQYRzUCW8w4co9E0W1ocQdivb2ge1
	 s7iORhFxzzS+3Q21WXPwxPpvTmD4Tv6O3U4gowcdI9wWGsyiFeGsegK6yBKBXnp9vVYjK
	 3kpnG298+JsG3lk7uqgp/LRyb1KLADu0CSWqHEGFzfs7QQEt1WQVWn4dPu2x5I3MjDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniroma2.it;
	spf=pass smtp.mailfrom=uniroma2.it;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=2w6ziNFb;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=vIB+6lPD;
	arc=none smtp.remote-ip=160.80.4.37
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236F5606A31D;
	Sat, 31 Oct 2026 22:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 236F5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=uniroma2.it header.i=@uniroma2.it header.a=ed25519-sha256 header.s=ed201904 header.b=2w6ziNFb;
	dkim=pass (2048-bit key, unprotected) header.d=uniroma2.it header.i=@uniroma2.it header.a=rsa-sha256 header.s=rsa201904 header.b=vIB+6lPD
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 69VMpGqW021945;
	Sat, 31 Oct 2026 23:51:21 +0100
Received: from localhost.localdomain (unknown [160.80.105.87])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E8CF0122953;
	Sat, 31 Oct 2026 23:51:11 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1793487072; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8S7mRav071ig+pdoADGRJ11FK7siUO/ISnPNSD918g=;
	b=2w6ziNFbLdyL77eNSTlhd0ji0y1Gl23GdXM5so3RYRsl8m7rIekU0zeGmBER43HVppzJx3
	wHomMWvdkhun7EAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1793487072; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V8S7mRav071ig+pdoADGRJ11FK7siUO/ISnPNSD918g=;
	b=vIB+6lPDT+IU7Lhs889FKRKiV+a4OtEumS6DsVEtHXaaPHo5B41vMd72YpV6WsHSz6BYRx
	ON/XACN7JIjLztSpAeGYvmcfphdFkeb/qEBs5veFQ3fimK7XMcfrP/2QnfAB46j94Azavo
	2lIxS/TSeuWvspU7Y8bikx0wrmXw6XIJVLGAVyiiOhgvfM4hAFhkwy+Q/qpk3Rz6DAg53/
	qKCYSIfwVqd3gfL7/gATr22DE5fkKTXYkekLUCnBaiPjvBNKizKwGDC2gJaAWWcYBNoWfo
	MXYjIh73Al5/OuuF/269jbAQ/g/8PmwkgiCQC87htucJ1VBT88OXe8Zc9ZS1Jw==
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
Subject: [PATCH net 4/6] seg6: discard CHECKSUM_COMPLETE after the End.BPF program
Date: Sat, 31 Oct 2026 23:50:31 +0100
Message-Id: <20261031225033.64-5-andrea.mayer@uniroma2.it>
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
is delivered. Also tested against the lwt_seg6local BPF selftest, and with
a ConnectX-6 Lx NIC (mlx5) that provides CHECKSUM_COMPLETE.

Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 net/ipv6/seg6_local.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 57a82477ce3f..3045a351f4e9 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -1582,6 +1582,12 @@ static int input_action_end_bpf(struct sk_buff *skb,
 		goto drop;
 	}
 
+	/* The program may have changed the packet and seg6_bpf_has_valid_srh()
+	 * may rewrite the SRH Hdr Ext Len below.
+	 * skb->csum may then no longer be the checksum of the full packet.
+	 */
+	skb_checksum_complete_unset(skb);
+
 	if (srh_state->srh && !seg6_bpf_has_valid_srh(skb))
 		goto drop;
 	local_unlock_nested_bh(&seg6_bpf_srh_states.bh_lock);
-- 
2.43.0

