Return-Path: <SRS0=wUMJ=RW=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6726C10F03
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F09420857
	for <bpf@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="y8lCd6am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfCSKVe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36535 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfCSKVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so15859097wrd.3
        for <bpf@vger.kernel.org>; Tue, 19 Mar 2019 03:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g+AbFDLwemusv49YvI5Cm0dgmRSPNyWb6u9wXCJ6qr8=;
        b=y8lCd6amdcgLkVsJejYZIQP4C9aU6kt5rZLOE9B1Ff418pUz61Ri/NUfWQAZSXsY0T
         9xZfDVmeKsoNkEpsvA22gRs1cOYIlVkrelTE/BsuJXvLkbb2+T0bJvS3mtNyYaVSaPNe
         vW/MNa4czT7aThVK+zySED8m31TCIqwSUKhDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g+AbFDLwemusv49YvI5Cm0dgmRSPNyWb6u9wXCJ6qr8=;
        b=t9E7fMtxyR0d0Qf+heHkJqH3nNn0W2UNDdgPglxGH78WVtTifcX/FY0dwVPmnKjLLl
         juUh5juATZv5mFuCvhJ12virpgFXoVp5iBuNTjKdL1JOSxFxpqakWr4rGYkU/qibdrGK
         jLzA1nCvFpVTQ5DcvyazxvqYPOheY+sj+feZTMmBqNsr3RMVR4pKoo7u1MhyKZ1MtQZZ
         +l4cUsAQtN3kCwiY4D+d7nYnOqZNS9f1A9GmRAVuizVvJwU73nAfZZs/zby7ZU8Yo+an
         jlm5N638fZ/S06+Yx83aIbo0LnVsBsjdJZc6grous/QZtKUxfcdCfTDJGJBqvYJ+hu5w
         wSoA==
X-Gm-Message-State: APjAAAWMZbzHw4ICjWgeLEufM9tDOpL8GnMpazgRt122UCsO3yxMVFML
        cQ9U4ybh0a0KlIKSlGUwgnJa/yThcFY+q+3T
X-Google-Smtp-Source: APXvYqwcQMBjwt7uD2JEBAYaW8EbmlrN9MnmSa5AyJu5Wa6ck5ZTppYCV2fb+gwhk4clupz2rJ0jNA==
X-Received: by 2002:adf:f10c:: with SMTP id r12mr15896739wro.216.1552990889549;
        Tue, 19 Mar 2019 03:21:29 -0700 (PDT)
Received: from localhost.localdomain ([217.138.62.245])
        by smtp.gmail.com with ESMTPSA id q2sm27895781wrd.46.2019.03.19.03.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH v2 3/8] bpf: add skc_lookup_tcp helper
Date:   Tue, 19 Mar 2019 10:20:58 +0000
Message-Id: <20190319102103.7380-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190319102103.7380-1-lmb@cloudflare.com>
References: <20190222095057.9442-1-lmb@cloudflare.com>
 <20190319102103.7380-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow looking up a sock_common. This gives eBPF programs
access to timewait and request sockets.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/uapi/linux/bpf.h |  20 ++++++-
 kernel/bpf/verifier.c    |   3 +-
 net/core/filter.c        | 113 +++++++++++++++++++++++++++++++++++----
 3 files changed, 124 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 983b25cb608d..8e4f8276942a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2374,6 +2374,23 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or NULL in
  *		case of failure.
+ *
+ * struct bpf_sock *bpf_skc_lookup_tcp(void *ctx, struct bpf_sock_tuple *tuple, u32 tuple_size, u64 netns, u64 flags)
+ *	Description
+ *		Look for TCP socket matching *tuple*, optionally in a child
+ *		network namespace *netns*. The return value must be checked,
+ *		and if non-**NULL**, released via **bpf_sk_release**\ ().
+ *
+ *		This function is identical to bpf_sk_lookup_tcp, except that it
+ *		also returns timewait or request sockets. Use bpf_sk_fullsock
+ *		or bpf_tcp_socket to access the full structure.
+ *
+ *		This helper is available only if the kernel was compiled with
+ *		**CONFIG_NET** configuration option.
+ *	Return
+ *		Pointer to **struct bpf_sock**, or **NULL** in case of failure.
+ *		For sockets with reuseport option, the **struct bpf_sock**
+ *		result is from **reuse->socks**\ [] using the hash of the tuple.
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2474,7 +2491,8 @@ union bpf_attr {
 	FN(sk_fullsock),		\
 	FN(tcp_sock),			\
 	FN(skb_ecn_set_ce),		\
-	FN(get_listener_sock),
+	FN(get_listener_sock),		\
+	FN(skc_lookup_tcp),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f60d9df4e00a..94420942af32 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -369,7 +369,8 @@ static bool is_release_function(enum bpf_func_id func_id)
 static bool is_acquire_function(enum bpf_func_id func_id)
 {
 	return func_id == BPF_FUNC_sk_lookup_tcp ||
-		func_id == BPF_FUNC_sk_lookup_udp;
+		func_id == BPF_FUNC_sk_lookup_udp ||
+		func_id == BPF_FUNC_skc_lookup_tcp;
 }
 
 static bool is_ptr_cast_function(enum bpf_func_id func_id)
diff --git a/net/core/filter.c b/net/core/filter.c
index f879791ea53f..f5210773cfd8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5156,15 +5156,15 @@ static struct sock *sk_lookup(struct net *net, struct bpf_sock_tuple *tuple,
 	return sk;
 }
 
-/* bpf_sk_lookup performs the core lookup for different types of sockets,
+/* bpf_skc_lookup performs the core lookup for different types of sockets,
  * taking a reference on the socket if it doesn't have the flag SOCK_RCU_FREE.
  * Returns the socket as an 'unsigned long' to simplify the casting in the
  * callers to satisfy BPF_CALL declarations.
  */
 static unsigned long
-__bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
-		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		u64 flags)
+__bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+		 struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
+		 u64 flags)
 {
 	struct sock *sk = NULL;
 	u8 family = AF_UNSPEC;
@@ -5192,15 +5192,28 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		put_net(net);
 	}
 
-	if (sk)
-		sk = sk_to_full_sk(sk);
 out:
 	return (unsigned long) sk;
 }
 
 static unsigned long
-bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
-	      u8 proto, u64 netns_id, u64 flags)
+__bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
+		u64 flags)
+{
+	struct sock *sk;
+
+	sk = (struct sock *)__bpf_skc_lookup(skb, tuple, len, caller_net,
+					    ifindex, proto, netns_id, flags);
+	if (sk)
+		sk = sk_to_full_sk(sk);
+
+	return (unsigned long)sk;
+}
+
+static unsigned long
+bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+	       u8 proto, u64 netns_id, u64 flags)
 {
 	struct net *caller_net;
 	int ifindex;
@@ -5213,10 +5226,42 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		ifindex = 0;
 	}
 
-	return __bpf_sk_lookup(skb, tuple, len, caller_net, ifindex,
-			      proto, netns_id, flags);
+	return __bpf_skc_lookup(skb, tuple, len, caller_net, ifindex,
+				proto, netns_id, flags);
 }
 
+static unsigned long
+bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+	      u8 proto, u64 netns_id, u64 flags)
+{
+	struct sock *sk;
+
+	sk = (struct sock *)bpf_skc_lookup(skb, tuple, len, proto, netns_id,
+					  flags);
+	if (sk)
+		sk = sk_to_full_sk(sk);
+
+	return (unsigned long)sk;
+}
+
+BPF_CALL_5(bpf_skc_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return bpf_skc_lookup(skb, tuple, len, IPPROTO_TCP, netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_skc_lookup_tcp_proto = {
+	.func		= bpf_skc_lookup_tcp,
+	.gpl_only	= false,
+	.pkt_access	= true,
+	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_5(bpf_sk_lookup_tcp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
@@ -5289,6 +5334,28 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.arg5_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
+	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
+{
+	struct net *caller_net = dev_net(ctx->rxq->dev);
+	int ifindex = ctx->rxq->dev->ifindex;
+
+	return __bpf_skc_lookup(NULL, tuple, len, caller_net, ifindex,
+				IPPROTO_TCP, netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_xdp_skc_lookup_tcp_proto = {
+	.func           = bpf_xdp_skc_lookup_tcp,
+	.gpl_only       = false,
+	.pkt_access     = true,
+	.ret_type       = RET_PTR_TO_SOCK_COMMON_OR_NULL,
+	.arg1_type      = ARG_PTR_TO_CTX,
+	.arg2_type      = ARG_PTR_TO_MEM,
+	.arg3_type      = ARG_CONST_SIZE,
+	.arg4_type      = ARG_ANYTHING,
+	.arg5_type      = ARG_ANYTHING,
+};
+
 BPF_CALL_5(bpf_xdp_sk_lookup_tcp, struct xdp_buff *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
 {
@@ -5311,6 +5378,24 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.arg5_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_sock_addr_skc_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return __bpf_skc_lookup(NULL, tuple, len, sock_net(ctx->sk), 0,
+				IPPROTO_TCP, netns_id, flags);
+}
+
+static const struct bpf_func_proto bpf_sock_addr_skc_lookup_tcp_proto = {
+	.func		= bpf_sock_addr_skc_lookup_tcp,
+	.gpl_only	= false,
+	.ret_type	= RET_PTR_TO_SOCK_COMMON_OR_NULL,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+	.arg4_type	= ARG_ANYTHING,
+	.arg5_type	= ARG_ANYTHING,
+};
+
 BPF_CALL_5(bpf_sock_addr_sk_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
@@ -5586,6 +5671,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_addr_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_sock_addr_skc_lookup_tcp_proto;
 #endif /* CONFIG_INET */
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5719,6 +5806,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_tcp_sock_proto;
 	case BPF_FUNC_get_listener_sock:
 		return &bpf_get_listener_sock_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_skc_lookup_tcp_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5754,6 +5843,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_xdp_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_xdp_skc_lookup_tcp_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5846,6 +5937,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_skc_lookup_tcp_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
-- 
2.19.1

