Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B105AC10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8472F21902
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="v8Fnc6l+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfCVByf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38312 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfCVByf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id v1so350676pgi.5
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=647d2XQX1xKJXHMs2+p9ovw2MFzon72ABw+3AwRMJ/k=;
        b=v8Fnc6l+xW7Cjcb6zT6rGXWK15MJG4I4FcHNixWfWboG32kS9gOEpkRPkGvtZjJi9+
         YAKDbbPQ+45PjI9W6emjAe/P0QFqRhsiUDQvRqllQ4513rW2ecWMa6ryWpgAUbl5434S
         S7jBrEwCdvf/5hyLhy+Ff/3lKPIDh89TPjTrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=647d2XQX1xKJXHMs2+p9ovw2MFzon72ABw+3AwRMJ/k=;
        b=Ggoz6dDskagvGkCgup47pyNFIChRUOYfIi0a0JGchFj46S8C8MQZjJHXzrUbixVxRl
         4a7LYqA5QURLrkPUo1XCKFEulPaGnLxmm08nDnQSZZVkuC1x6L66V00+8hG5wijf37yl
         znkKjfG+8SdySvisHbA+epcE+PegvWA/+TC8QDCtbROItOFGdnXbm7/kHzOog2GtOP7l
         PvQaT069FWckU5oRdrbGsYkd036jG2dGQ7DBXT5S8NzXgU8E2SbJgUfh/Ip/Zu2/XzoD
         kLxkT/yQo8wmnfCdQHHWeHU9VTcl3N2yjCVjVDXzctDl4CpPb6hZbOFKaZJXr1eW4m4o
         tuuA==
X-Gm-Message-State: APjAAAVKHAe2S0MAxWupWCDjqHBEhTzMsfUj5qPcDi8+NMJjImuXC/pZ
        KQ91sZ5BWdRiHc4ex3y+LN4nJg==
X-Google-Smtp-Source: APXvYqwqfPvylTPPz6HKSHz/rzfQhPv5g5Rt5ySPkkrFeIqUYLXLgyEFP/2ENkww5JKEnbthiOWu2A==
X-Received: by 2002:a65:4342:: with SMTP id k2mr6469075pgq.445.1553219674064;
        Thu, 21 Mar 2019 18:54:34 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:33 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 4/8] bpf: add helper to check for a valid SYN cookie
Date:   Fri, 22 Mar 2019 09:54:02 +0800
Message-Id: <20190322015406.26453-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190322015406.26453-1-lmb@cloudflare.com>
References: <20190319102103.7380-1-lmb@cloudflare.com>
 <20190322015406.26453-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using bpf_skc_lookup_tcp it's possible to ascertain whether a packet
belongs to a known connection. However, there is one corner case: no
sockets are created if SYN cookies are active. This means that the final
ACK in the 3WHS is misclassified.

Using the helper, we can look up the listening socket via
bpf_skc_lookup_tcp and then check whether a packet is a valid SYN
cookie ACK.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/uapi/linux/bpf.h | 18 +++++++++-
 net/core/filter.c        | 72 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fab05317f5e7..3c04410137d9 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2448,6 +2448,21 @@ union bpf_attr {
  *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
  *		For sockets with reuseport option, the **struct bpf_sock**
  *		result is from **reuse->socks**\ [] using the hash of the tuple.
+ *
+ * int bpf_tcp_check_syncookie(struct bpf_sock *sk, void *iph, u32 iph_len, struct tcphdr *th, u32 th_len)
+ * 	Description
+ * 		Check whether iph and th contain a valid SYN cookie ACK for
+ * 		the listening socket in sk.
+ *
+ * 		iph points to the start of the IPv4 or IPv6 header, while
+ * 		iph_len contains sizeof(struct iphdr) or sizeof(struct ip6hdr).
+ *
+ * 		th points to the start of the TCP header, while th_len contains
+ * 		sizeof(struct tcphdr).
+ *
+ * 	Return
+ * 		0 if iph and th are a valid SYN cookie ACK, or a negative error
+ * 		otherwise.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2549,7 +2564,8 @@ union bpf_attr {
 	FN(tcp_sock),			\
 	FN(skb_ecn_set_ce),		\
 	FN(get_listener_sock),		\
-	FN(skc_lookup_tcp),
+	FN(skc_lookup_tcp),		\
+	FN(tcp_check_syncookie),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/net/core/filter.c b/net/core/filter.c
index b6d83ba97621..d2511fe46db3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5553,6 +5553,74 @@ static const struct bpf_func_proto bpf_skb_ecn_set_ce_proto = {
 	.ret_type       = RET_INTEGER,
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
+
+BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
+	   struct tcphdr *, th, u32, th_len)
+{
+#ifdef CONFIG_SYN_COOKIES
+	u32 cookie;
+	int ret;
+
+	if (unlikely(th_len < sizeof(*th)))
+		return -EINVAL;
+
+	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
+	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
+		return -EINVAL;
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_syncookies)
+		return -EINVAL;
+
+	if (!th->ack || th->rst || th->syn)
+		return -ENOENT;
+
+	if (tcp_synq_no_recent_overflow(sk))
+		return -ENOENT;
+
+	cookie = ntohl(th->ack_seq) - 1;
+
+	switch (sk->sk_family) {
+	case AF_INET:
+		if (unlikely(iph_len < sizeof(struct iphdr)))
+			return -EINVAL;
+
+		ret = __cookie_v4_check((struct iphdr *)iph, th, cookie);
+		break;
+
+#if IS_BUILTIN(CONFIG_IPV6)
+	case AF_INET6:
+		if (unlikely(iph_len < sizeof(struct ipv6hdr)))
+			return -EINVAL;
+
+		ret = __cookie_v6_check((struct ipv6hdr *)iph, th, cookie);
+		break;
+#endif /* CONFIG_IPV6 */
+
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	if (ret > 0)
+		return 0;
+
+	return -ENOENT;
+#else
+	return -ENOTSUPP;
+#endif
+}
+
+static const struct bpf_func_proto bpf_tcp_check_syncookie_proto = {
+	.func		= bpf_tcp_check_syncookie,
+	.gpl_only	= true,
+	.pkt_access	= true,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_SOCK_COMMON,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_PTR_TO_MEM,
+	.arg5_type	= ARG_CONST_SIZE,
+};
+
 #endif /* CONFIG_INET */
 
 bool bpf_helper_changes_pkt_data(void *func)
@@ -5815,6 +5883,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skc_lookup_tcp:
 		return &bpf_skc_lookup_tcp_proto;
+	case BPF_FUNC_tcp_check_syncookie:
+		return &bpf_tcp_check_syncookie_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5852,6 +5922,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_release_proto;
 	case BPF_FUNC_skc_lookup_tcp:
 		return &bpf_xdp_skc_lookup_tcp_proto;
+	case BPF_FUNC_tcp_check_syncookie:
+		return &bpf_tcp_check_syncookie_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
-- 
2.19.1

