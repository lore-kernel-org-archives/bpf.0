Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69694ED198
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012388; cv=none; b=O/d48i5aLx4SqmEE0zFLEX6hPrkUgX79dWYvinvZgPcQsuo5ISsXhX7RkppT32zoE46szCih1TTVGYmz4h17rBKtIlrElmUimzH6uoF3tNbZucQ2v3odizPrP3uZ/rJMW5BA59LO0KH9ryTrsGaNQjMFdVA8a+pQljfUBvIYpm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012388; c=relaxed/simple;
	bh=U5EKdWBIbiSJU1dP09Omb4q7Mq8wk1havQycrFwGi+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/vV9kD2Y8j1TTJnIhgXfG79pjIwhFrzBHa6YMDE7mV17Q1b0tSv44rStL7WgzVZuK3IrYDi+jOdXyxlZKHbf+KXfGMxq+v0/E/JnOUtWqKjC4q3s8INUQS0tmB0SAMewtlc8u/r/qq1/RTQ8Yb2w8xmGGEEYqmF6F75HJJQIfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXTAaKPs; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXTAaKPs"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so2569234a12.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790012386; x=1790617186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5FIqOvJ37TsMdMZxbiL8+8z7eHOaHEabZWsoVStaOQ=;
        b=jXTAaKPs74N5povwGroOLXHnRCwicKLScjR/cOolkBqb0m1nMJUoAhXmrw/kUfxa8q
         tEj+K80ADjNfAiv/6Yu/CO9K3RsiMflhgwZyy5iw0eQmxQBlKISNecdxLJdc2Rx8yW8c
         86xKSWxWw37D0bOiMWTBqBWz+HedZZWEZBfxntJAzHmwKpMjJ10uKAXGsMxWrN5ISctA
         nWW/GxMrlv9OsBAnBqliBj6HrwDtFfU9VnaIS59SIb0soR2lseF+wap1lDdjyuqWEBWa
         Te45lDBiTH+veIaFvwaWEdI5Dr15KUqsedSC/q7laSnBcO2gs+vXnH3f72NF5SDdshgO
         t32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790012386; x=1790617186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w5FIqOvJ37TsMdMZxbiL8+8z7eHOaHEabZWsoVStaOQ=;
        b=XHAYmGu9HLQ7d52S019OmP/j+qWpI7N8hdnXp36E5HUlHQ/mi5bzsjRir9nwpbsbrZ
         epoXZjPO1Yrz9cPxw3oSnPZsKvsoIuA2/VP/IWviBf8dt0BPn7FqPSkrHPQQ6ZxHwmAE
         trjMhPB8L8mPTYjiHy+cVUeyBldkwZDDsfdsLxi3b8ETF3yvZaNFbW4dBrVBAEE9RenX
         WAU7GpEfxgz85kkVYVpnyQpUnP5DxFAS9eFViyRMIlN9910yEUYVcAHphInsXc6GzCw1
         dgvy6sxLgut7jdsTtYB76rAn73MSXqjDHnY3tozBXpG3Co+AQ3axUOghfyLFhlRzwQ/o
         6Sxw==
X-Gm-Message-State: AFuF++mOBf4m7mWZmk95ww40nWnw/+s6lXl6kYbLgZFPcHY0j12G+WM1
	JYCjocfaElO25QGUKW2Ki6C3lqeRHBgPylGN3L17uIOPRuKMEyb5Wwc/
X-Gm-Gg: AYBFou0Jc/w/I47QDzJK7F5l7l8EfXiND6GIVphk/jK1RGewNVaRB5gB8q7UNFMlwwo
	qMIJmfuQEu6MYnYDIQOyRJNz7ix+FNDmJv55aZpCHKjuWbROOoOqFVtH9b8fmx+lPymz2/UIJ1N
	bXTXpmt2s9FL5xOqcCHbPc/SPUfdgrr6kuOQIIcifZAi4kNW8eLs5lj84p3J5gTVlj9uQD7hE4c
	Wfdj7R3iKwzwfayBM8K4AG6NW8XhmRtC4k3fMMnFYrn3BvT95IhuAkUV6a29RBfnE3oftVUdDSd
	8IBpVyiAksM74LSKQMRKS0HNGAsQyts/bEk4Wu/sgs6J92XVKhY8rzkAoGp8+ckwYLST4owbfWh
	pTJmzE/Gq8KaMVAWFkF5pIu79wL8YbFfgTwe6B2f3hWP6L3wGwOjOppOSDnH3IpTbKNgXzxpxzR
	/GpSU9b0VqObWWf6VY4rBN9LinRGgLPSp9ySyCHTbLnSXBEosPEjPnQtcg0Rj6MSQGuKbUvUrMe
	5/Z58nTjss6HjQtAtlk3lqfxQ87oEYE
X-Received: by 2002:a05:6300:618d:b0:3dd:a196:69e4 with SMTP id adf61e73a8af0-3dda196784emr12197593637.63.1790012385816;
        Mon, 21 Sep 2026 10:39:45 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72af0955esm3986985a12.32.2026.09.21.10.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:39:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v4 1/2] bpf: clear stale IPv4 options after LWT encapsulation
Date: Tue, 22 Sep 2026 01:39:09 +0800
Message-ID: <20260921173910.90847-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921173910.90847-1-bestswngs@gmail.com>
References: <20260921173910.90847-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_lwt_push_ip_encap() rebases the network header after prepending an IP
header, but leaves IPCB(skb)->opt describing the inner IPv4 header. An
ingress LWT route can consequently make an ICMP error use stale option
offsets when constructing its reply.

Mark completed LWT IP encapsulation in the run's BPF network context and
clear stale metadata after bpf_prog_run_save_cb() restores the protocol
control block. For same-family IPv4 encapsulation, clear only the cached
options, as the IP tunnel transmit paths do. When the family changes,
reset the destination family's control block and initialize its ingress
interface, following seg6_do_srh_encap(). Save and restore the marker
around nested LWT runs.

Cc: stable@vger.kernel.org
Fixes: 52f278774e79 ("bpf: implement BPF_LWT_ENCAP_IP mode in bpf_lwt_push_encap")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 include/linux/filter.h |  1 +
 net/core/lwt_bpf.c     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 39decde7fc73..195898af9528 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -848,6 +848,7 @@ struct bpf_nh_params {
 #define BPF_RI_F_CPU_MAP_INIT	BIT(2)
 #define BPF_RI_F_DEV_MAP_INIT	BIT(3)
 #define BPF_RI_F_XSK_MAP_INIT	BIT(4)
+#define BPF_RI_F_LWT_IP_ENCAP	BIT(5)
 
 struct bpf_redirect_info {
 	u64 tgt_index;
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63d..88664382ca44 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -36,10 +36,30 @@ static inline struct bpf_lwt *bpf_lwt_lwtunnel(struct lwtunnel_state *lwt)
 #define NO_REDIRECT false
 #define CAN_REDIRECT true
 
+static void bpf_lwt_reset_cb(struct sk_buff *skb, __be16 orig_proto)
+{
+	if (skb->protocol == orig_proto) {
+		if (skb->protocol == htons(ETH_P_IP))
+			memset(&IPCB(skb)->opt, 0, sizeof(IPCB(skb)->opt));
+		return;
+	}
+
+	if (skb->protocol == htons(ETH_P_IP)) {
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = skb->skb_iif;
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
+		IP6CB(skb)->iif = skb->skb_iif;
+	}
+}
+
 static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 		       struct dst_entry *dst, bool can_redirect)
 {
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+	struct bpf_redirect_info *ri;
+	bool lwt_ip_encap, saved_lwt_ip_encap;
+	__be16 orig_proto = skb->protocol;
 	int ret;
 
 	/* Disabling BH is needed to protect per-CPU bpf_redirect_info between
@@ -47,8 +67,17 @@ static int run_lwt_bpf(struct sk_buff *skb, struct bpf_lwt_prog *lwt,
 	 */
 	local_bh_disable();
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+	ri = bpf_net_ctx_get_ri();
+	saved_lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
 	bpf_compute_data_pointers(skb);
 	ret = bpf_prog_run_save_cb(lwt->prog, skb);
+	lwt_ip_encap = ri->kern_flags & BPF_RI_F_LWT_IP_ENCAP;
+	ri->kern_flags &= ~BPF_RI_F_LWT_IP_ENCAP;
+	if (saved_lwt_ip_encap)
+		ri->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
+	if (lwt_ip_encap)
+		bpf_lwt_reset_cb(skb, orig_proto);
 
 	switch (ret) {
 	case BPF_OK:
@@ -668,6 +697,7 @@ int bpf_lwt_push_ip_encap(struct sk_buff *skb, void *hdr, u32 len, bool ingress)
 	} else {
 		skb->protocol = htons(ETH_P_IPV6);
 	}
+	bpf_net_ctx_get_ri()->kern_flags |= BPF_RI_F_LWT_IP_ENCAP;
 
 	if (skb_is_gso(skb))
 		return handle_gso_encap(skb, ipv4, len);
-- 
2.55.0

