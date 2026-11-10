Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283074;
	b=M3zzMMvsR/AOPoCboSZEbM/BwIf6M2gonkzbUXNZsuxt6V65dYtFPeqaKzfSI7Iv/qNU
	 Ca9tFwr7ChD/otZ19nW0GEfTjqLGmOXwJxar9K+YNAxX58igB2bcADOuHw3peZQ/BaUD5
	 yu81nyEoUjQQsuSUxmctSCUEVPveBVwSNYlWvkjoebq97do7tcEcBLbLoDGsYJqEDjgSp
	 ++eF8hvZxKajkpqrd/vmu3dl+UKVfSt1Nt9bMh09NKJjVzJAqGKfWGdFM3+IxjETTkvSw
	 j9dEB7NoHPzFPy/HsFxvAvIl3YLiVQxGnLieyWb1hfPro4YMnYirI/dqIA9qoTXWdfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
	b=Q/For+U6jCEpSqJcB4S6gRWuoI+yVnGrFFGRq7lv3/0mW3WZK1a4nJ4xkkrS/VNHpMgr
	 u2eclFxB43r4JwbXb2eaUB79w4GNiG6D+B/YXTYQD4+He0Gl8ANlZKb53WIq6eIehiPJE
	 wdz1B76fe8ngdcBK0IJeExiw9ynO3Bs3W5DG49L+vl8UfoY5kdxWOqcZwoWI6LRhzvTKr
	 gPsvFyR6/zUu/Kw58tCL+whPOY3EKEzfxQZ3lc8n/ZYqDlz0p+p6vsUfrrCZWmS2RiqNC
	 CmCZVTN2d4D4Tf7h7y6fG6XZhWD+jDXVhR0nQz03sF2vuxexnnrIqOBWBWQA0bl5+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=etddmlQ6;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06BA60A2616
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E06BA60A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=etddmlQ6
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso321943a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283072; x=1794887872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
        b=etddmlQ6KTW8I4VyqGQQwFK1maal2K5cDxKZzGCvA0bRjj6YA+4PfYkgPOT1npnTCp
         oGBfMwDVwydCu6vtoX/7yhtFSYhsRcp2l++GiHrACzOXqvb0ebkuTkPjvwxioFijchuf
         AKYHPNS3nG3jbEsYP+UtsjNTrk+O2UcnhbwNEL6v1w84Ik/ZbQY8dfMNNY5cwbf8WJqb
         M/ERcXxPXD5DJX0jqzVwJIfFOS7Lb/pbdF/qZscva84xn8SnvZ6iGw61nA1B07M7J07s
         mtMDzy9v8Tdy9JexILCSI0pv+B0Z9wcHHbyQ+IOG/wUCk7re4jJi4wlNmxO8uimftAQP
         qc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283072; x=1794887872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x6UAY2B85t0xEciqSymh7Wj670TZwRf8zeEzMQKeumk=;
        b=d4VZfWBCfG8NW4A4uXIY1G0dQRIXPIux6Q53DZRpWrhEOyEqo/R+ew3jUFlmafi3I6
         DHja39Y3tt6kXbLDDzuEXdD7VTeswnfl8J6l99YSAjUrqLb7/c99i4udwI449nNRfxJL
         HNyoe1zDDaUd4yh/LCdPZcTy3s/GUVcdm85/gBZmcXraiLTPce5Aj3/c4CCYO7L6IVQr
         2tw4auoqxXsEzEQf9b3BObfkP82Q6brc093SZaG1xiKXpV0qIwg+DVinAgPtLSulzgTn
         VCfHEmequ/ptneoaooWxsFWiMVS6wvW03gQgwjp/BIipuVlpd6taNveCGluA8rwgvYnb
         1aSw==
X-Gm-Message-State: APuU4Z/k4jVrPFY8L4YrnOR/Hfq0puG/DKjIBESj503QTNt/deG8Orbh
	uBSMYc2p2SnrMn1zdVRjF+EaGHYhdCGGuUHirN3hnPikQdf7NuDE9E1uwAvxkDZMvlrU0lDuCUO
	ME2XEX38=
X-Gm-Gg: AYBFou1JUbriDm2uVCy7B2SUDXkKYprYp3olvvu7F/EFCrCeNNKONIyFRFlk4Aklq0j
	2c9NHgO67mkUiul68a/ZiJT8oIU/VMU5EXI6LLZUzvT5JFzSD5kUo7+kivEHFHAQ6olhFGyVUUt
	p6wzhwPKd4EVrCAws6oY0JY0Oh9epX5l/Uoly0p4bImlN6g8wdwjjBnvCzEnxn3hBPhtPM6VuTK
	DHjTLa5jXGG4WAojvmhdAZxvbzWEHvwx9aE1dzCk9dpwHaPVSG77hrgFPKgZ54fQtcwOGQbNwxa
	EVdNQ6TNcmZZ6dlvFjSWNYwwqeNpAqYiHqlZZxVH4IS28M/a4qj2OQnXaVKwL04/C7Iaw5nIa8n
	i1p7kYk3uuyK8we3vrMhN+/ZudkyuHP0/602jl4wykTK1BDO2GsWlIAQOC2LUE+nHMXU0DocD+c
	m+cDaJeKYh1CQfyNzXiTtQk8s/+8i9R6ohXEvgNSemBIu7xpeepcU5lIozXYDnB/YgJMZYfEZ7N
	dN5g9rYJcbUNFgCESAiBM/u4CzwjIgdIjFz/nf6vQr2JnNgRHFVFCB7iIfi3YFklmbfjNRiUh/c
	epY0nwfRWTBQwFD3E21kKBkVieu2sXK5yAxvEhm+luH8jNiV+2zzJ6WjHz56O8o=
X-Received: by 2002:a05:6402:4489:b0:6b5:8200:5008 with SMTP id 4fb4d7f45d1cf-6b756b229f1mr1030422a12.45.1794283072341;
        Mon, 09 Nov 2026 19:57:52 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:51 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 09/15] xdp: add the skb-ext-pass XDP feature and warn without it
Date: Tue, 10 Nov 2026 03:57:07 +0000
Message-ID: <aec6f3eaaab68e0fa7e4d7ee24695602f08503e3.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
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

On XDP_PASS, only drivers that call xdp_skb_ext_to_skb() set the skb
fields from the skb core extension area. Other drivers silently ignore
the stored values.

Add the XDP feature NETDEV_XDP_ACT_SKB_EXT_PASS ("skb-ext-pass") for
such drivers. veth sets it, and ice sets it in a later patch. User
space reads it with netdev netlink, and an XDP program reads
xdp->rxq->dev->xdp_features after bpf_cast_to_kern_ctx().

On a native XDP device without the feature, bpf_prog_run_xdp() warns
once on XDP_PASS with stored values, like bpf_warn_invalid_xdp_action().
For a packet without stored values, this adds one check of xdp->flags.
Programs on cpumap and devmap are skipped, because the skb is built
later from the xdp_frame.

BPF_PROG_RUN with BPF_F_TEST_XDP_LIVE_FRAMES builds the skb from the
xdp_frame and sets the stored values. It still warns when its
ingress_ifindex names a native XDP device without the feature, because the
check only looks at the device features.

Update the veth and bond feature checks in the xdp_do_redirect and
xdp_bonding selftests.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 Documentation/netlink/specs/netdev.yaml       |  5 ++++
 drivers/net/veth.c                            |  3 ++-
 include/net/xdp.h                             |  6 +++++
 include/uapi/linux/netdev.h                   |  6 ++++-
 net/core/xdp.c                                | 24 +++++++++++++++++++
 tools/include/uapi/linux/netdev.h             |  6 ++++-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |  8 +++----
 .../bpf/prog_tests/xdp_do_redirect.c          |  8 +++----
 8 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 4303593e5003..7979b1ad38c7 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -50,6 +50,11 @@ definitions:
         doc: >-
           This feature informs if netdev implements non-linear XDP buffer
           support in ndo_xdp_xmit callback.
+      -
+        name: skb-ext-pass
+        doc: >-
+          This feature informs if netdev sets the skb fields from the skb
+          core extension area when it builds the skb after XDP_PASS.
   -
     type: flags
     name: xdp-rx-metadata
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3eca92d3dc60..b402f8ed5096 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1304,7 +1304,8 @@ static void veth_set_xdp_features(struct net_device *dev)
 		struct veth_priv *priv_peer = netdev_priv(peer);
 		xdp_features_t val = NETDEV_XDP_ACT_BASIC |
 				     NETDEV_XDP_ACT_REDIRECT |
-				     NETDEV_XDP_ACT_RX_SG;
+				     NETDEV_XDP_ACT_RX_SG |
+				     NETDEV_XDP_ACT_SKB_EXT_PASS;
 
 		if (priv_peer->_xdp_prog || veth_gro_requested(peer))
 			val |= NETDEV_XDP_ACT_NDO_XMIT |
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 7c9a812b6e86..7148e8ef00e1 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -509,6 +509,8 @@ static __always_inline void *xdp_skb_ext_end(const struct xdp_buff *xdp)
 }
 
 void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext);
+void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
+			   const struct xdp_buff *xdp);
 
 void __xdp_return(netmem_ref netmem, enum xdp_mem_type mem_type,
 		  bool napi_direct, struct xdp_buff *xdp);
@@ -771,6 +773,10 @@ static __always_inline u32 bpf_prog_run_xdp(const struct bpf_prog *prog,
 			act = xdp_master_redirect(xdp);
 	}
 
+	if (unlikely(xdp_buff_has_skb_ext(xdp)) && act == XDP_PASS &&
+	    !(xdp->rxq->dev->xdp_features & NETDEV_XDP_ACT_SKB_EXT_PASS))
+		xdp_skb_ext_warn_pass(prog, xdp);
+
 	return act;
 }
 #endif /* __LINUX_NET_XDP_H__ */
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 9026e0414fbe..a450e63cb941 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -25,6 +25,9 @@
  *   XDP buffer support in the driver napi callback.
  * @NETDEV_XDP_ACT_NDO_XMIT_SG: This feature informs if netdev implements
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
+ * @NETDEV_XDP_ACT_SKB_EXT_PASS: This feature informs if netdev sets the skb
+ *   fields from the skb core extension area when it builds the skb after
+ *   XDP_PASS.
  */
 enum netdev_xdp_act {
 	NETDEV_XDP_ACT_BASIC = 1,
@@ -34,9 +37,10 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_SKB_EXT_PASS = 128,
 
 	/* private: */
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = 255,
 };
 
 /**
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 9f311b3c0d2b..36d6bb38b719 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -1115,6 +1115,30 @@ void xdp_skb_ext_to_skb(struct sk_buff *skb, const struct xdp_skb_ext *ext)
 	}
 }
 
+/**
+ * xdp_skb_ext_warn_pass - Warn if XDP_PASS does not use the stored values.
+ * @prog: The XDP program that returned XDP_PASS.
+ * @xdp: The packet, with the XDP_FLAGS_HAS_SKB_EXT flag, on a device
+ *	 without NETDEV_XDP_ACT_SKB_EXT_PASS.
+ */
+void xdp_skb_ext_warn_pass(const struct bpf_prog *prog,
+			   const struct xdp_buff *xdp)
+{
+	const struct net_device *dev = xdp->rxq->dev;
+
+	/* The skb is built later from the xdp_frame */
+	if (prog->expected_attach_type == BPF_XDP_CPUMAP ||
+	    prog->expected_attach_type == BPF_XDP_DEVMAP)
+		return;
+	/* No native XDP, so only generic XDP or BPF_PROG_RUN runs on dev */
+	if (!(dev->xdp_features & NETDEV_XDP_ACT_BASIC))
+		return;
+
+	pr_warn_once("XDP_PASS on prog %s (id %u): dev %s has no skb-ext-pass XDP feature, the stored RX metadata is lost\n",
+		     prog->aux->name, prog->aux->id, dev->name);
+}
+EXPORT_SYMBOL_GPL(xdp_skb_ext_warn_pass);
+
 __bpf_kfunc_start_defs();
 
 /**
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 9026e0414fbe..a450e63cb941 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -25,6 +25,9 @@
  *   XDP buffer support in the driver napi callback.
  * @NETDEV_XDP_ACT_NDO_XMIT_SG: This feature informs if netdev implements
  *   non-linear XDP buffer support in ndo_xdp_xmit callback.
+ * @NETDEV_XDP_ACT_SKB_EXT_PASS: This feature informs if netdev sets the skb
+ *   fields from the skb core extension area when it builds the skb after
+ *   XDP_PASS.
  */
 enum netdev_xdp_act {
 	NETDEV_XDP_ACT_BASIC = 1,
@@ -34,9 +37,10 @@ enum netdev_xdp_act {
 	NETDEV_XDP_ACT_HW_OFFLOAD = 16,
 	NETDEV_XDP_ACT_RX_SG = 32,
 	NETDEV_XDP_ACT_NDO_XMIT_SG = 64,
+	NETDEV_XDP_ACT_SKB_EXT_PASS = 128,
 
 	/* private: */
-	NETDEV_XDP_ACT_MASK = 127,
+	NETDEV_XDP_ACT_MASK = 255,
 };
 
 /**
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index c42488e445c2..c61b01c58342 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -625,7 +625,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -646,7 +646,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_NDO_XMIT |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -663,7 +663,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	 */
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
@@ -678,7 +678,7 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_NDO_XMIT |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "bond query_opts.feature_flags"))
 		goto out;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
index dd34b0cc4b4e..e1cd3b951dac 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
@@ -170,7 +170,7 @@ void test_xdp_do_redirect(void)
 
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_src query_opts.feature_flags"))
 		goto out;
 
@@ -180,7 +180,7 @@ void test_xdp_do_redirect(void)
 
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-		       NETDEV_XDP_ACT_RX_SG,
+		       NETDEV_XDP_ACT_RX_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_dst query_opts.feature_flags"))
 		goto out;
 
@@ -195,7 +195,7 @@ void test_xdp_do_redirect(void)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_src query_opts.feature_flags gro on"))
 		goto out;
 
@@ -206,7 +206,7 @@ void test_xdp_do_redirect(void)
 	if (!ASSERT_EQ(query_opts.feature_flags,
 		       NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 		       NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-		       NETDEV_XDP_ACT_NDO_XMIT_SG,
+		       NETDEV_XDP_ACT_NDO_XMIT_SG | NETDEV_XDP_ACT_SKB_EXT_PASS,
 		       "veth_dst query_opts.feature_flags gro on"))
 		goto out;
 
-- 
2.56.0

