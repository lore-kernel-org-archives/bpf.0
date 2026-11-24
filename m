Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543179;
	b=4PLjVoRWOk3TK+GOm+nG6upKsEUQoV/WbxdL6vT3Y0I6UFf7QdU1bpGwAlVGQ0norQkb
	 6HfxP01ILxNd74UFrSMWaz79IkAKPOTD23n/GuB/YK6yRRX9ihdeirR8AM3k/KzRMDTMj
	 dsdhc7HdXGnSdByI6sIdVdYx6pEtiDP64k95dVA2WobnMjiPuWBOU5BfStMGHfXAD3jK+
	 77+hABMpt01VobMT/evZLtUwys6wy8b1QdjenWFUw3kOUIZ7xyCApfZ9yvT7vJbNFruVf
	 Y5x5UaWSINZPvhKn/4bn+sGA2ejXeF20anMAHL4EkttBanfWsl0TfgS59XxbvQ/rg/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uaTj/IgjFnkwmASVrKkLUw8romAE2cVY2R2st4Lr99E=;
	b=lS/74VAXZikg+tPUsFRo0BKX1J+8WhKDktD2RsvZzA/oxYP3E0x6Wdh15Hn/73QRVF4e
	 8Td1vGbWR4QLk1Hx2zXd4TdS9Ufg1Dc0yZx4bSmAUK35VJnpGv7nOU20rnM8vb9IpOyxI
	 3iNbXr2iTvqjX24L2qXc9s9DVjar3C64VWdE2t4diCRmNqX5pDXiMbfnPj9+1pI899tRh
	 /EO6jZBHzutfsdYpaOclZiQSg2KewclZ5qh5cSupSdSE1Fjs09S2aIYEM5Mzpynedo6TS
	 /o4yKy7K+WKqdUYYKgzwDTJ2V5EGmAamox+J3m483T+mEJAC+UirWMUA/3XFvzbptwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ablhK58t;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5D606A323
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2E5D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ablhK58t
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so5607284a12.3
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795543177; x=1796147977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uaTj/IgjFnkwmASVrKkLUw8romAE2cVY2R2st4Lr99E=;
        b=ablhK58t8MX2Gx9UkaoIkzL9AwdBhG+jhN7/JyA92ASWxcX3KuQRaPXU/sv2p/Doui
         LLdVv4w2HJP3jvDcSLlkR4x0f8lxYbu2Th76mnUvU/1//q548yfXfPf1y47o0t/nr213
         cx9qQE4fdbqjJTN3b7qTXmJQWEChes/ZHF7nVn3lPKUZO+BXU4yK5htEeRzA00bLNlbm
         Rexd5gkY+Z30hujxDUGmX6ycFjtvJwWguQ0qIa/LbA/5TLbclZWcNh3mZUtjFnPIx8fT
         JDnsdEg/PGybouR5+vOCHt8e5VCYcnhMNGBpMblnEPhIqr/ThraupuDOkUyqhAwu5NfE
         nKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543177; x=1796147977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uaTj/IgjFnkwmASVrKkLUw8romAE2cVY2R2st4Lr99E=;
        b=Hj+yZPRTRaavqXpWsFlQx3gkqZCYQj6PRrkgD2LNJ8RkIO5XMu91MhBZhd5Y6ilXxW
         z09sg0FwSriZTZUaTN8YZFU2KRjwVJe7ul9hj64Pxik1IWSfoh+HuVSTba3EIqrVqKI0
         EIRaWTpm182ryWqQCn3kKAcJm8/cKT0O71JgJwnAl/PBS8I0lr/fgzjs11E1SGNDl7up
         2Q/bw7WOahodKra5jMCojd6Acrg39FkwIbFOo3a9jmU7o4WThRBlXXXGC3kWCCtu6IzR
         yHC2g3WL+9AUNpQhTdRYViPFWZnt/83ERCn0MXyc87//9s/tK8s/oya/8B1ry91YQLkb
         xpnw==
X-Forwarded-Encrypted: i=1; AL+hErFiEOJGK9VAU66OsuVVTBKGJvfPY90Mlk/FXAOx4R/+c+Vul5Anhh27TVCiZB4LuMNR0a8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HUvMxtQXsHl2m+5rIkT82d06ofxTfVMMBPX/9PvftE7EkJnjM
	1xTWBUeYxN9KX9Jslvaoa6/0/oWC+CFOgWBtAJjBXKssa+III+61je0HmS8G6ntqsXA=
X-Gm-Gg: AZFdTZdhjTDcuzDaEoUnUZ1HtyXVw+YlbzQoTnO55TqnvBIY36Ej0cj3XU7KCaZdA8g
	FzcZhl5We70jtX/9Y4ZeH+kATxsfaeKrjft7NWgBG33ae/9aMq5drXOO7gfjmBX44Wjlmu8aAXr
	IBNI7ZgUtwLENeGvR3c3xJeSpi3dG3ip+mc54iXlbR4SSV+nKYhYQfq5QOogH1KDThmlOEbtpi8
	mO0I5WJXFlm2qCvlWWFbTFObEClaIlVAGmc+G23yC7WspnkDEFncOMgR6/WH0tJngGxbnSUkpA1
	vJUiPL3qn3/JNRttcCK7X0CUN57L0/z3EoByvt4CLu18NOi+wnOTrSlUvkIzRarlQpomkbyW1di
	QqA2Yk3zUFULbRBXUHlindZPxFiOX3OqaCAq4u/HH9MWwyI3C72fURpAjdcIdBqkGRqCrt/ZFrS
	lqN5YRjAmBaIWdH+ySdNRAtVkxZuj6aE6Ctko/G6d3BAypKtDTct/biKcAbP7/WFNyzzbAlu1Uc
	QYYLPqVkD+xh5eixFD4NA13s+4h/BsGzgbqayufEu6xgDFqEyt+Vb1Hwgb16xNXDidhjiAW7rBM
	r58/W4/9J4tjxEeasgAf2QjyNE3gg1Aj/r4kDtr/0i8GliY=
X-Received: by 2002:a05:6402:2389:b0:6bb:1e07:2eae with SMTP id 4fb4d7f45d1cf-6bb1e073294mr273795a12.9.1795543177340;
        Tue, 24 Nov 2026 09:59:37 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba3711ad52sm7205762a12.35.2026.11.24.09.59.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:59:36 -0800 (PST)
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
	Stephen Hemminger <stephen@networkplumber.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"Remy D. Farley" <one-d-wide@protonmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Andy Roulin <aroulin@nvidia.com>,
	Anil Kaushik <anilkaushikwireless@gmail.com>,
	Demos Ra <demosthenes.ra@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Joe Damato <joe@dama.to>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Li RongQing <lirongqing@baidu.com>,
	Louis Scalbert <louis.scalbert@6wind.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Song Liu <song@kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Wang Zhan <wang.zhan@smartx.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Zhou Qiuyue <n0ps1edzz@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jeff Layton <jlayton@kernel.org>,
	Tianyi Gao <tianyi.gao@linux.dev>,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net-next v3 10/11] netlink: specs: rt-link: add veth attributes
Date: Tue, 24 Nov 2026 17:58:23 +0000
Message-ID: <20261124175824.60470-11-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124175824.60470-1-tianyi@cloudflare.com>
References: <20261124175824.60470-1-tianyi@cloudflare.com>
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

Describe the veth attributes in rt-link.yaml, so that YNL can set and
read them. The next patch uses them to test VETH_INFO_TX_EXTRA_HEADROOM.

YNL includes linux/veth.h from the source tree with get_hdr_inc, which
needs the source header guard to differ from the installed one. Prefix
the guard with _UAPI, as commit 8066e388be48 ("net: add UAPI to the
header guard in various network headers") did for other network
headers. headers_install strips the prefix, so the installed header does
not change.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
v3:
- Add the maximum of tx-extra-headroom (Sashiko).

v2:
- New patch.
---
 Documentation/netlink/specs/rt-link.yaml | 16 ++++++++++++++++
 include/uapi/linux/veth.h                |  4 ++--
 tools/net/ynl/Makefile.deps              |  3 ++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 81b58633911d..c7967a9b3cc6 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -2368,6 +2368,19 @@ attribute-sets:
         name: mode
         type: u8
         enum: ovpn-mode
+  -
+    name: linkinfo-veth-attrs
+    name-prefix: veth-info-
+    header: linux/veth.h
+    attributes:
+      -
+        name: peer
+        type: binary
+      -
+        name: tx-extra-headroom
+        type: uint
+        checks:
+          max: 512
 
 sub-messages:
   -
@@ -2427,6 +2440,9 @@ sub-messages:
       -
         value: ovpn
         attribute-set: linkinfo-ovpn-attrs
+      -
+        value: veth
+        attribute-set: linkinfo-veth-attrs
   -
     name: linkinfo-member-data-msg
     formats:
diff --git a/include/uapi/linux/veth.h b/include/uapi/linux/veth.h
index 04cb408e5b3a..d22a29b1bbb2 100644
--- a/include/uapi/linux/veth.h
+++ b/include/uapi/linux/veth.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef __NET_VETH_H_
-#define __NET_VETH_H_
+#ifndef _UAPI__NET_VETH_H_
+#define _UAPI__NET_VETH_H_
 
 enum {
 	VETH_INFO_UNSPEC,
diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f8850444d240..39abd83c014f 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -43,7 +43,8 @@ CFLAGS_psp:=$(call get_hdr_inc,_LINUX_PSP_H,psp.h)
 CFLAGS_rt-addr:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_IF_ADDR_H,if_addr.h)
 CFLAGS_rt-link:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
-	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h)
+	$(call get_hdr_inc,_LINUX_IF_LINK_H,if_link.h) \
+	$(call get_hdr_inc,__NET_VETH_H_,veth.h)
 CFLAGS_rt-neigh:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
 	$(call get_hdr_inc,__LINUX_NEIGHBOUR_H,neighbour.h)
 CFLAGS_rt-nexthop:=$(call get_hdr_inc,__LINUX_RTNETLINK_H,rtnetlink.h) \
-- 
2.56.0

