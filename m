Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714347;
	b=2yC455lKSlm5AqU0jgVrkoirc+0gU8i3xuZu3jvnD6JJFaFrYsBgnMneggRbSYnaoqXI
	 69o39xOE4zSmKKtvpasiTeGfZA14K1yzSdM2vwr/eUDgFG6Pkyrog02mIBUUShqjFht9j
	 dfhhC+VUsPAxs2vEGVhMuCNTbcfbZ1QqACFIcmwhslUmyIWY9XqfJJyWKiwIPSCDqA2EM
	 2QXCfd5+DF18NDv6aHhu0IDJAZinm+YcTEsnvU0yHQnADH86XdCWW2EZiLw+bb+EHdBhM
	 Y8oFgBP48qIpjo9l8G55pjSIoQa82XwJyhUZZ7QsPhaZvMaqLI5rKYrEUrzyjscgPyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714347;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HGUEFbhyMPHvtc3QryNaymed5lzjFNWIsxM5k1JO/oI=;
	b=bmJyJwalXtpl1NH4P84Ue+kpe9gIvaZUxNKt9PBnMrgCQIEtyA3TPEvI9u/WFZLtvJ+8
	 xKuudyljtr2Nh1qcErnzaAOxFSvPRraDEYl6i/DKfCVAP2SxD5Wg8ehDFt2PibkzpQLwJ
	 Hd/PPESfWjmR3RfDptSBcq3ZcwzBHgRCa1j/PcjVl3qWKmxV5pzYAIT9KW5ND+woOEiqL
	 2m5UjOs9ZATa1SKo92DA9rQlxHT5hRUpSsGoaXmUclG7NmeueJDF1QIhwC0jAV1hR4mOE
	 MQ5t9lzlm4lj/rR/MApkhF59/q5qzaRavKDQa5PUAYVX5V8a5W7JRn1CNMgIhcGxVkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=c0PHCRsS;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA72D606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 17:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA72D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=c0PHCRsS
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so44041975e9.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 09:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795714345; x=1796319145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HGUEFbhyMPHvtc3QryNaymed5lzjFNWIsxM5k1JO/oI=;
        b=c0PHCRsSqx+4QTbIaJGYJRjTvVGLARj7ZW3OeaMLrkbBYVJNw8GniuuESSJFDN8gyq
         ioHZsUkpS0wfAldrG2ANQTahQM3Bp2XGdSa6IpjmpBjHiCJz/gaBfU/QvhLQlOkneVLX
         XB7135vdtOWKBlYRDXNvQj9NW/HT3ecz//PpUkH6L9EkahndC/KWA98s/gw3m7eY2uLI
         Rz+WfMc83qk1meAdJaJCrtptlG88dzQnIf4rZERn1cM+A0NgZ5h8b/xjA6wjkQoB6n7P
         RKT9zmXNEGYdR1Hgr87cYPV/nEBs4Jigb2DbxiRvW4VtIQm+kw8Xs/HWRmEZ58AOZP3c
         klgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795714345; x=1796319145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGUEFbhyMPHvtc3QryNaymed5lzjFNWIsxM5k1JO/oI=;
        b=1BJIxV18XPwBxlJAEIRVqdCVI1/Ft7/fhwh7ZjLlthD3Nx6EBCTRbjnGzF0A6kmFP9
         H/sopqzAxWsSjONu2OWLeHZq/Gpvko0P6jpgH8mHzhscD61+1+HYkZc2saF5ll6gmfvN
         D1mGCeiGHvQw4XFnVz+FJ/a9YrYSJjnpFyaK7rhO4RoMHzetVzAEHdC699MARR9BZHKY
         tkR8QamylZ5e5NjWi0nt9jLRJwWPfvSqOsAZQkwy2e3BDYndFBQQfb6/1WxeBBrd36CN
         YEURTJ5E+CeNy+EWJ0Uij499jtBrNahyl71WC4OQT6bM2g9u8saN80lr/z3cPWmgaQL6
         2OsA==
X-Forwarded-Encrypted: i=1; AL+hErGWe4bDOb3XteM6F9chdc1SZfREgmHD79GBz5qlF3EGMQphxygJ9dVAno7nGydSAPqDBm4=@vger.kernel.org
X-Gm-Message-State: APuU4Z94hVodnYhvYUJAb8X+P6X28RPdcubZl+mZa70lCwwca1Lb13+d
	fBEVlcffz5VMt6p4dVE+0C1+6rW5JI62xEVTOi4tfLhHfxC0KfSuTagxfv7NaonSVWw=
X-Gm-Gg: AZFdTZf3y04n5QQy1wZgNeb33CwlfZCdU35LMjgz4V+Kw8LX7L8zDIK/kwDdXWUTwvj
	dxaQYOUC4oDqzF6/gYCfmL0cTF/BiJgS5i68lYryPIDz4A3KP+QNO78yksA4IWYh/PHtERxXy/w
	iTGa1TZFsydRtAInedVvGGTdSluqdicg9T7dqrgUswSj0Xig7WgbH5ro4wN4Z8LiFQ+tKgfT2NK
	dz9G07QJERi00LBS0Gpd2WB/1rznEClCy1JDqSA2ho5EOnpgBHYsG6s2ZoAmRsY1eVLkN2C209F
	W+iVeqImeiCsALdLQWeZ/bLSHc6uDRKJgdkTzTKSVXm4sdeHXGBo6HaWHmYwMhdWOmbwBk8imdu
	FRXIjT7iXgVS37/yZfCnw0S70Y6zl0ggpcjpOV7c5qXXRF8aTk4fOe/v2EZDPnMD6fIG3/9kAEd
	Mk9oFvSEk19G4Uyn0rxsqs/Y4OkB6OeWngCYvu5ySBrd+3Uy5BSR/lW7lwj1kaSvCTBIRgdmfo7
	ah+TaCeyrQPa3ogTidVVwl6OVsGbta8+bnxI4/jW7A/23SU8A9QNiCg6BxDrK7DFkYCzbos7zcH
	H1kSrW/oCk0FgXctTc6YhhHbAM2roTdl/0+jAEccARZb6Utlkwc=
X-Received: by 2002:a05:600c:8b83:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4bb8880642cmr417929205e9.17.1795714344564;
        Thu, 26 Nov 2026 09:32:24 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4ab65cb41f4sm40608361f8f.7.2026.11.26.09.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 09:32:24 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Joe Stringer <joe@wand.net.nz>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Willem de Bruijn <willemb@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH net v2] net: keep skbs that carry a socket out of gro_cells gro
Date: Thu, 26 Nov 2026 19:30:34 +0200
Message-ID: <20261126173034.1860377-1-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
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

bpf_sk_assign at tc ingress holds a reference on a socket that isn't 
rcu freed such as an established tcp socket, until the receive path
steals it. ip_rcv_core keeps a prefetched socket so when the assigned
packet is an ipip, gre or esp packet the socket stays attached after
decap and their rx paths pass the skb to gro_cells_receive. A socket
that is rcu freed carries no reference, but if NFQUEUE queues the packet
__nf_queue takes one and switches the destructor to sock_edemux, so the
skb owns a reference when it reaches gro_cells_receive as well. GRO merges
skbs with the same skb->sk into one flow and clears skb->sk and
skb->destructor of each merged skb without calling the destructor so
every merged skb leaks a socket ref.

Send skbs that carry a socket to netif_rx instead as gro_cells_receive
already does for cloned skbs, where each skb is consumed on its own and
no ref is lost.

This also diverts sock_wfree skbs which GRO can merge when slow_gro
is set. They only get here via esp software GRO, e.g. from veth in
napi mode or netdevsim, and those lose GRO.

tun with IFF_NAPI passes sock_wfree skbs to GRO without slow_gro so
gro_cells could merge skbs from different tun queues and uncharge all of
their wmem from the aggregate's socket only.

skb->sk shares a cache line with skb->dev that is read at the start of
gro_cells_receive so the common case adds a single cheap test.

Reproduced with a tcx ingress program on a veth in a receiver netns with
an ipip tunnel which assigns an established tcp socket to ipip packets.
The sender sends 32 tcp segments of one flow inside ipip through a netem
slot qdisc so they are decapsulated in one batch and merged by gro.
Then the socket is closed and the receiver netns is deleted. The leaked
socket holds a ref on the netns so it is never torn down and its devices
are never unregistered:

Before:
  bpf_sk_assign() calls 32, sk_refcnt 32 after the burst
  receiver netns deleted, 30s later its veth peer still exists

After:
  bpf_sk_assign() calls 32, sk_refcnt 1 after the burst
  receiver netns deleted, its veth peer is gone

The problem was found during reviews of patches that add bpf_sk_assign
egress support.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Eric, I didn't add your reviewed-by as this is a different check.

v2: changed the check to skb->sk instead of skb_sk_is_prefetched (Sashiko)
    changed the commit message & subject to reflect it
    rebased and retested

v1: https://lore.kernel.org/netdev/20261121160204.4024204-1-razor@blackwall.org/

local Sashiko review says:
 [Severity: Medium]
 Does this regress GRO for sock_wfree-owned ESP packets?  A veth NAPI
 packet can retain its socket through ESP decapsulation and reach this
 branch.  netif_rx() then delivers the inner packet without another GRO
 pass, increasing receive-side work.

 Nik: That is understood and documented in the commit message.

CC: David S. Miller <davem@davemloft.net>
CC: Eric Dumazet <edumazet@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>
CC: Martin KaFai Lau <kafai@fb.com>
CC: Joe Stringer <joe@wand.net.nz>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Willem de Bruijn <willemb@google.com>
CC: bpf@vger.kernel.org

 net/core/gro_cells.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index 31352cac355c..4bb7316a8be3 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -26,7 +26,8 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk_buff *skb)
 
 	skb_unset_transport_header(skb);
 
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev) ||
+	    unlikely(skb->sk)) {
 		res = netif_rx(skb);
 		goto unlock;
 	}
-- 
2.47.3

