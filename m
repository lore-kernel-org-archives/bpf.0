Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794022484;
	b=xJNqZfgbHtJNgS+mO4FUKQ7NCdUtoev8AiX1aicY6T+QmC84zxG0L/RxJCgW4Bg0X1jJ
	 IYJr80t3jjq3CFUksB39zbQXpZR3CCCGeegXjSzYY7FjQkJz4+4dwMoKho6B099Bc8f6t
	 f5XnHV/tqSVI57qs+n4KdG7cE0CMAhzdtIB+k2PzAwXqn3z39H7FJo4jYx5q8czq+knY1
	 ltHCFIscM/kJ92NXh2Oop5LdSCUVEbr8ogprqEezfA0Nhc+zwEyblN11B5mgdWiZEsoBy
	 xVmpxmbbTjKs19eBFkFFwK3ElVKyz/Myu6dMeiu+gy1gAyrzjdW4lyTVrudSNUBDjJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794022484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RrV5iqN0VATzlL9Eoq00NFZhRYz4qlgHoomWQEo1jXw=;
	b=GsCGyUvGwwJtX5RTewRKBOk0sZq/HrE30EhnfvLcEUGypMUkb0wc9K7W2RU5ONHhJHGK
	 RAVtuQKEiE7KSiCtf3PIJlnFq4DU5auPKngdwILMN5H+3fC3yon6oaLWz/ZzAps/jmwWX
	 oOr//G1oX8RLgC3QJfvKb7WplgSeF0DlvY+pOQlGfVmIzfsme+Yfffl4f2stY3w9girRh
	 N+H3+lzyob/EKEubza9ku98n9IRwfAbepN3YE1q09Pz7COsrjF0/1QT12W+soRSz6SaG/
	 EEdiegbG6agDnCTCWrU6aiWKDDqaddXd7h/i7rBMZaq7tg7raKFTb5gR+s0NjJByb6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=KlfMre+Z;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED882606A339
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 03:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED882606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=KlfMre+Z
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d30639709so164213766b.0
        for <bpf@vger.kernel.org>; Fri, 06 Nov 2026 19:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794022481; x=1794627281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RrV5iqN0VATzlL9Eoq00NFZhRYz4qlgHoomWQEo1jXw=;
        b=KlfMre+Z7nZjGpdNNmAPYVnUnKeDa/tY8JSsFzeVfl6aMAVYrLnVC3du54uvFKSS9c
         P8J4+HTghaSxCZIsjLlI/EkKBQKWp0Q9y1scjI9Gcwy9B8MiRrgRQDVkLehJCDxphYVB
         PxZxHDH+4F1fjxkly/VAdKsj8XMZKIIu/0QzDTmIOJvfof0X86ZgFFC255Ge5EjNWDhs
         nOarth4F32zcMsyIgMPCIQf3HDLEixgCHGwPlEmvjpsOvNRy/eZzFPucwYw/2C52CyaM
         EMv2Z4NlrC3ayy1Asf+0xf66clln+V8I7XEGPheqMLf6YYl+j7wbBk2Pf49mO7sEZa8N
         9TTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794022481; x=1794627281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RrV5iqN0VATzlL9Eoq00NFZhRYz4qlgHoomWQEo1jXw=;
        b=OAZYPFWS17Vh3xOsndmingTc5iv4AahdwfSv3nm37qaSp1kwjdsbZef0FWY3xQe663
         c37bER5aqlFPBlvH3VAl5Sfywo6gyE4OLSgRMtaKhQeQQGr6YM/JBeHA03nH9fXHjrFG
         sesw+pjDwM7XEaxy2HjlYCRA2C2wlZ4/NC8hCVeVj3pZW1yJhOlE5M2smErxHLC39HV5
         9lQjiDi+79gTderPAW+Ajod/SHtTh8Ll7cbJZb4mrWfleeHY6TTJmkZRMcETk88jV0yH
         lX5blDpy9rr6je4C/aeqlUE5sJHMt5f63TTsvnx20vCm2kqZRqR+ROwWvxz9ln6w8N0R
         T0vg==
X-Forwarded-Encrypted: i=1; AKwUvBzDd6tHwPnFGEZqU2Vr1jv6KPb2zH1mFIHmtka5G4V4z54R776HxWrMbyANfgc61dqBsXs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CZJnrfUhqYCH8Yq2YFabeJd+lP8D/NTpmnkddzsPbcZKBDU5L
	ignZASFbdKwPjyxiYYNApQ+L9G1NZ+M6iGmuQDlnhv97L4Cbc6KOat9lLmPbSV2Nos0=
X-Gm-Gg: AYBFou3Pr7a1xZ5K75wDf8KCMjflPda3JOA7MQFoVnKgWohA+5ykCsItAQtDX7NPU3S
	yM5umm5m1S30mIGI/hPQzkxgpJkgT7YvRsjz5hBez7zhAq7ecMwCW6ZjmDxEB2KBhAx/5h8caD9
	tjLZZIqxpf0JsbDGaduS2s7UfUnm0l7rqRomkk/vwJB0ysjKwR416A1OzH3Ms38rglXp7XlJERy
	89SzD6IJi8lDOJxTeQemYVrYXkRFeKl0NukltII5xjMt5T8yJYbRwpWKaR6XdnM1ACRDCAnPlaE
	t0YiszsCf4hoMFvAwAZG68sFQYGWKapD6nlBS6UimLdiWLHTRHMir9qTKfiB+at6HbNRMLjG8bX
	/bOVcXUNapJfvuqfbM0ptnRNXNCAKaGsc+POV/6eOyduYsTiVH5MMvewJr8IiP6Z8yjOqHVlqIv
	s/XQy4AE2A66vOmg4O03auz6EI3+5GIGGeaMBv5Zz5pKZ5k9Upw6dF/8SWvK3qR/8DHOillK9A+
	UAcBjJUJPhDVU0i3k5vFid1X2Jd2x/cqt8CEr2FJuuSrd72M76K8CQ0qHe4UPzmcF6F1h0fBZmm
	HtFfdlVFovHXgiV/K26LWXoh71ecQGxLWkwkmMX7zz8Ps+mfXsYS2Gz5wKsx8KM=
X-Received: by 2002:a17:906:9f92:b0:c3f:dce3:20c5 with SMTP id a640c23a62f3a-c4d34c9a760mr362334466b.44.1794022481458;
        Fri, 06 Nov 2026 19:34:41 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3562e00dsm121104166b.21.2026.11.06.19.34.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:34:40 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Keogh <dkeogh@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Woodhouse <dwmw2@infradead.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Nimrod Oren <noren@nvidia.com>,
	Alasdair McWilliam <alasdair@mcwilliam.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Danielle Ratson <danieller@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com,
	nh-open-source@amazon.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next 2/8] net: reserve extra TX headroom for local egress
Date: Sat,  7 Nov 2026 03:34:21 +0000
Message-ID: <4b2f20b9a7bcca58fced690d20916efab55ad31a.1794020868.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794020868.git.tianyi@cloudflare.com>
References: <cover.1794020868.git.tianyi@cloudflare.com>
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

From: David Keogh <dkeogh@amazon.com>

Use LL_ALLOC_SPACE() and LL_ALLOC_SPACE_EX() instead of
LL_RESERVED_SPACE() and LL_RESERVED_SPACE_EX() where the stack allocates
packets on behalf of a local sender and sizes them for the output
device:

 - __ip_append_data() and __ip6_append_data(), covering UDP, ICMP,
   ping and raw sockets without IP_HDRINCL;
 - raw_send_hdrinc() and rawv6_send_hdrinc();
 - the three AF_PACKET transmit paths;
 - AF_XDP copy mode, which open-codes its own calculation from
   needed_headroom and now uses netdev_tx_alloc_headroom().

These are the main paths where a packet's headroom is decided by the
device's advertised requirement and nothing else. Adding the
administrator's extra reservation here means such packets reach the TC
egress hook with room for additional headers already in place.

Paths that check an existing packet against LL_RESERVED_SPACE() and
expand it on demand, such as ip_finish_output2() and the tunnel
transmit functions, are deliberately left alone. Using the larger value
there would force a reallocation of every packet that lacks the full
extra reservation, including TCP segments that already have enough
room for the headers an egress program actually pushes.

ip_do_fragment() and ip6_fragment() are also left alone. They use the
same value to check the headroom of existing fragments and to size new
ones. A larger value would send more packets to the slow path, which
copies them. A local sender's fragments normally come from
__ip_append_data() or __ip6_append_data().

Signed-off-by: David Keogh <dkeogh@amazon.com>
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 net/ipv4/ip_output.c   | 2 +-
 net/ipv4/raw.c         | 2 +-
 net/ipv6/ip6_output.c  | 2 +-
 net/ipv6/raw.c         | 2 +-
 net/packet/af_packet.c | 6 +++---
 net/xdp/xsk.c          | 6 ++++--
 6 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 3396f177a18d..bf718b8f6f1d 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -988,7 +988,7 @@ static int __ip_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP_MAX_MTU : cork->fragsize;
 	paged = !!cork->gso_size;
 
-	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
+	hh_len = LL_ALLOC_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct iphdr) + (opt ? opt->optlen : 0);
 	maxfraglen = ((mtu - fragheaderlen) & ~7) + fragheaderlen;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 9d01006d8189..a1e72e634d0e 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -355,7 +355,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
 	if (flags&MSG_PROBE)
 		goto out;
 
-	hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	hlen = LL_ALLOC_SPACE(rt->dst.dev);
 	tlen = rt->dst.dev->needed_tailroom;
 	skb = sock_alloc_send_skb(sk,
 				  length + hlen + tlen + 15,
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 25fe0ba98b1a..a3626d5f0d11 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1490,7 +1490,7 @@ static int __ip6_append_data(struct sock *sk,
 	mtu = cork->gso_size ? IP6_MAX_MTU : cork->fragsize;
 	orig_mtu = mtu;
 
-	hh_len = LL_RESERVED_SPACE(rt->dst.dev);
+	hh_len = LL_ALLOC_SPACE(rt->dst.dev);
 
 	fragheaderlen = sizeof(struct ipv6hdr) + rt->rt6i_nfheader_len +
 			(opt ? opt->opt_nflen : 0);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index bdea825434ea..06459685ec61 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -601,7 +601,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	struct sk_buff *skb;
 	int err;
 	struct rt6_info *rt = dst_rt6_info(*dstp);
-	int hlen = LL_RESERVED_SPACE(rt->dst.dev);
+	int hlen = LL_ALLOC_SPACE(rt->dst.dev);
 	int tlen = rt->dst.dev->needed_tailroom;
 
 	if (length > rt->dst.dev->mtu) {
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8250e6a791f6..8800da612880 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2032,7 +2032,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
 		goto out_unlock;
 
 	if (!skb) {
-		size_t reserved = LL_RESERVED_SPACE_EX(dev, hard_header_len);
+		size_t reserved = LL_ALLOC_SPACE_EX(dev, hard_header_len);
 		int tlen = dev->needed_tailroom;
 		unsigned int hhlen = dev->header_ops ? hard_header_len : 0;
 
@@ -2860,7 +2860,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 			goto tpacket_error;
 
 		status = TP_STATUS_SEND_REQUEST;
-		hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
+		hlen = LL_ALLOC_SPACE_EX(dev, hard_header_len);
 		tlen = dev->needed_tailroom;
 		if (vnet_hdr_sz) {
 			data += vnet_hdr_sz;
@@ -3087,7 +3087,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 		goto out_unlock;
 
 	err = -ENOBUFS;
-	hlen = LL_RESERVED_SPACE_EX(dev, hard_header_len);
+	hlen = LL_ALLOC_SPACE_EX(dev, hard_header_len);
 	tlen = dev->needed_tailroom;
 	linear = __virtio16_to_cpu(vio_le(), vnet_hdr.hdr_len);
 	linear = max(linear, min_t(int, len, hard_header_len));
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 781ba46eb152..3ee8ad3fd155 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1045,7 +1045,8 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	buffer = xsk_buff_raw_get_data(pool, addr);
 
 	if (!skb) {
-		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
+		hr = max(NET_SKB_PAD,
+			 L1_CACHE_ALIGN(netdev_tx_alloc_headroom(xs->dev)));
 
 		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
 		if (unlikely(!skb))
@@ -1128,7 +1129,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		len = desc->len;
 
 		if (!skb) {
-			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
+			hr = max(NET_SKB_PAD,
+				 L1_CACHE_ALIGN(netdev_tx_alloc_headroom(dev)));
 			tr = dev->needed_tailroom;
 			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
 			if (unlikely(!skb))
-- 
2.56.0

