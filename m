Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF61EC43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42BA20854
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FJk4iUWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfCNLk4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:40:56 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38965 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfCNLkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 07:40:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id p8so5480382wrq.6
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2019 04:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gyK/PkSegBIjjZpcjF19cUDm0qFzK2tDR74S1Ry6qfo=;
        b=FJk4iUWFNN2+zWXIQ/Q7qOrNf+VxKWxAQAkBqCTlUhstVQKUbu2yTuQkvGH1c068ba
         JoGjnv+Y8JMpCDtWrekLkA4occb8D0jNRB3BRiqmW2NucwTw3BZqIK1gogImpmKrX5cI
         kZGkbb4/v6+PI6wIjzRGaR/nAQQ00yJazjx/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gyK/PkSegBIjjZpcjF19cUDm0qFzK2tDR74S1Ry6qfo=;
        b=pMh9Y3hIEhDWCrxeEz1uBJ+We4LqeJv1CZbgfaHpHSTyjZJaJLEZZEQTX5+ILzbaem
         k6eT6tHufEsQGSuUFk/Uiea74VHM5EyMZZ8ubSp9fQltSATXT87aDS042SIRCMfSldrN
         m1cGV5sdq1sxapitoBKxhgZuniSwmyZS7Xe0ZkujAxiEsHNI85hNqc44QSoLVPkOjCu6
         2QYG1vQ5KX2sG0d4rIYAxdsSrLIYM8z81bq1d0B5ZTZxC0tlqU0QtRTNpa7M7kpwKb6q
         MMBD1KXY9YWREXr41v8qbsHCML3FA6vdx4jzsunRoOFu4crhS73l8Kei0AowGSOlqzS2
         jLVg==
X-Gm-Message-State: APjAAAU9kxFJ3+0KLb0qDxRxkuFhgp7FY7D7ru4aisxhVZfmSdEbh9TX
        Ykf6pQ4wq6kYpBAG73AHQ55LTw==
X-Google-Smtp-Source: APXvYqxKdPyGGxlYiA2VvhSz07eq/HjF6ygyggZvAbK7cYsp0zzkoku48/cjX0UTHE4Id6n7Ng412A==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr11248948wrq.189.1552563639711;
        Thu, 14 Mar 2019 04:40:39 -0700 (PDT)
Received: from antares.lan (5.8.9.5.4.5.2.4.f.f.6.d.4.1.5.8.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:8514:d6ff:4254:5985])
        by smtp.gmail.com with ESMTPSA id a9sm1804017wmb.30.2019.03.14.04.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:40:38 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, theojulienne@github.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 4/8] bpf: add helper to check for a valid SYN cookie
Date:   Thu, 14 Mar 2019 11:39:50 +0000
Message-Id: <20190314113954.10210-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190314113954.10210-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190314113954.10210-1-lmb@cloudflare.com>
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
index 8e4f8276942a..587d7a3295bf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2391,6 +2391,21 @@ union bpf_attr {
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
@@ -2492,7 +2507,8 @@ union bpf_attr {
 	FN(tcp_sock),			\
 	FN(skb_ecn_set_ce),		\
 	FN(get_listener_sock),		\
-	FN(skc_lookup_tcp),
+	FN(skc_lookup_tcp),		\
+	FN(tcp_check_syncookie),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/net/core/filter.c b/net/core/filter.c
index f5210773cfd8..45a46fbe4ee0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5546,6 +5546,74 @@ static const struct bpf_func_proto bpf_skb_ecn_set_ce_proto = {
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
@@ -5808,6 +5876,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skc_lookup_tcp:
 		return &bpf_skc_lookup_tcp_proto;
+	case BPF_FUNC_tcp_check_syncookie:
+		return &bpf_tcp_check_syncookie_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5845,6 +5915,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

