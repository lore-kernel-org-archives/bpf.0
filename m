Return-Path: <SRS0=YBMC=RZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6E8C10F00
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BE5218FC
	for <bpf@archiver.kernel.org>; Fri, 22 Mar 2019 01:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="chKkSSgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfCVByf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:54:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41132 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbfCVByd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Mar 2019 21:54:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so376897pfn.8
        for <bpf@vger.kernel.org>; Thu, 21 Mar 2019 18:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hG8oShaczFiMwtySta589DAQzLiTtbxSDoErT6xNgOo=;
        b=chKkSSgKHofx+4bLyj1OUyYn2sEycAQUlps61GsOJyXRGjDnkCeJiq+Coym0qL86ee
         CzlSu9HOhQNb0JI5uxAVxOOIHnEdiPSNxMJGjNw3hm+vH/5I3NsRhWBwWVNIxAvywRO0
         twX7xHPpxEMxVeH8xzlbTI9GzH+tFmdRVFMPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hG8oShaczFiMwtySta589DAQzLiTtbxSDoErT6xNgOo=;
        b=shuumX9fc7J8DPCEgGrvsoKaRcuXEJbI/DMN7rokc2nZ8XUEDG4B5vu0RD7okuqrLO
         V8aB2AgsWWvIMcO6IxG+u4VfgHspMJ7xZRMky3tDad0v4N/uhtg+LH9+nGtzbv9jsrx7
         eny0jc5Ultp0kfMIalB5I4S2KGO5i1ziQWv0vkFtUDAJcT2zRJME5cB+FZze+EvGh9dC
         VieBE4knAembKw5zI/bQDvUWRzxwtEki2HggXzThXPDkSFfAle50RJIb94CeO8WVD4nE
         SUEydPlRRDDFfUohusY0I7+yu7eA3dyHlfbYv/WcRkFLrbZjEdEJ7U6dOWl/5xN3y2KC
         UxMQ==
X-Gm-Message-State: APjAAAUJMiDlYmXfMblLqoVMRAOV5L6twoSSOMd7U553IpcGh5oghAQ3
        4hlGBGlyPYitwr5dlrW4ieg5uw==
X-Google-Smtp-Source: APXvYqxjVTU95B4rPyji52EDvS0L6JtHQkrOAqnG2INZMFL3vKqXRv59oZOTtvtkOGYnxpM3dTzqhQ==
X-Received: by 2002:a63:f850:: with SMTP id v16mr6340553pgj.448.1553219671498;
        Thu, 21 Mar 2019 18:54:31 -0700 (PDT)
Received: from localhost.localdomain ([157.120.241.186])
        by smtp.gmail.com with ESMTPSA id i10sm7161799pgs.26.2019.03.21.18.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 18:54:30 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     kafai@fb.com, Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 3/8] bpf: add skc_lookup_tcp helper
Date:   Fri, 22 Mar 2019 09:54:01 +0800
Message-Id: <20190322015406.26453-4-lmb@cloudflare.com>
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

Allow looking up a sock_common. This gives eBPF programs
access to timewait and request sockets.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/uapi/linux/bpf.h |  20 +++++-
 kernel/bpf/verifier.c    |   3 +-
 net/core/filter.c        | 144 +++++++++++++++++++++++++++++++++------
 3 files changed, 143 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 929c8e537a14..fab05317f5e7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2431,6 +2431,23 @@ union bpf_attr {
  *	Return
  *		A **struct bpf_sock** pointer on success, or **NULL** in
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
@@ -2531,7 +2548,8 @@ union bpf_attr {
 	FN(sk_fullsock),		\
 	FN(tcp_sock),			\
 	FN(skb_ecn_set_ce),		\
-	FN(get_listener_sock),
+	FN(get_listener_sock),		\
+	FN(skc_lookup_tcp),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a476e13201d6..dffeec3706ce 100644
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
index 647c63a7b25b..b6d83ba97621 100644
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
-static unsigned long
-__bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
-		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
-		u64 flags)
+static struct sock *
+__bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+		 struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
+		 u64 flags)
 {
 	struct sock *sk = NULL;
 	u8 family = AF_UNSPEC;
@@ -5192,15 +5192,27 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		put_net(net);
 	}
 
+out:
+	return sk;
+}
+
+static struct sock *
+__bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+		struct net *caller_net, u32 ifindex, u8 proto, u64 netns_id,
+		u64 flags)
+{
+	struct sock *sk = __bpf_skc_lookup(skb, tuple, len, caller_net,
+					   ifindex, proto, netns_id, flags);
+
 	if (sk)
 		sk = sk_to_full_sk(sk);
-out:
-	return (unsigned long) sk;
+
+	return sk;
 }
 
-static unsigned long
-bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
-	      u8 proto, u64 netns_id, u64 flags)
+static struct sock *
+bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+	       u8 proto, u64 netns_id, u64 flags)
 {
 	struct net *caller_net;
 	int ifindex;
@@ -5213,14 +5225,47 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		ifindex = 0;
 	}
 
-	return __bpf_sk_lookup(skb, tuple, len, caller_net, ifindex,
-			      proto, netns_id, flags);
+	return __bpf_skc_lookup(skb, tuple, len, caller_net, ifindex, proto,
+				netns_id, flags);
 }
 
+static struct sock *
+bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
+	      u8 proto, u64 netns_id, u64 flags)
+{
+	struct sock *sk = bpf_skc_lookup(skb, tuple, len, proto, netns_id,
+					 flags);
+
+	if (sk)
+		sk = sk_to_full_sk(sk);
+
+	return sk;
+}
+
+BPF_CALL_5(bpf_skc_lookup_tcp, struct sk_buff *, skb,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)bpf_skc_lookup(skb, tuple, len, IPPROTO_TCP,
+					     netns_id, flags);
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
-	return bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP, netns_id, flags);
+	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_TCP,
+					    netns_id, flags);
 }
 
 static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
@@ -5238,7 +5283,8 @@ static const struct bpf_func_proto bpf_sk_lookup_tcp_proto = {
 BPF_CALL_5(bpf_sk_lookup_udp, struct sk_buff *, skb,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	return bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP, netns_id, flags);
+	return (unsigned long)bpf_sk_lookup(skb, tuple, len, IPPROTO_UDP,
+					    netns_id, flags);
 }
 
 static const struct bpf_func_proto bpf_sk_lookup_udp_proto = {
@@ -5273,8 +5319,9 @@ BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
 	struct net *caller_net = dev_net(ctx->rxq->dev);
 	int ifindex = ctx->rxq->dev->ifindex;
 
-	return __bpf_sk_lookup(NULL, tuple, len, caller_net, ifindex,
-			      IPPROTO_UDP, netns_id, flags);
+	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
+					      ifindex, IPPROTO_UDP, netns_id,
+					      flags);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
@@ -5289,14 +5336,38 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_udp_proto = {
 	.arg5_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
+	   struct bpf_sock_tuple *, tuple, u32, len, u32, netns_id, u64, flags)
+{
+	struct net *caller_net = dev_net(ctx->rxq->dev);
+	int ifindex = ctx->rxq->dev->ifindex;
+
+	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len, caller_net,
+					       ifindex, IPPROTO_TCP, netns_id,
+					       flags);
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
 	struct net *caller_net = dev_net(ctx->rxq->dev);
 	int ifindex = ctx->rxq->dev->ifindex;
 
-	return __bpf_sk_lookup(NULL, tuple, len, caller_net, ifindex,
-			      IPPROTO_TCP, netns_id, flags);
+	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
+					      ifindex, IPPROTO_TCP, netns_id,
+					      flags);
 }
 
 static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
@@ -5311,11 +5382,31 @@ static const struct bpf_func_proto bpf_xdp_sk_lookup_tcp_proto = {
 	.arg5_type      = ARG_ANYTHING,
 };
 
+BPF_CALL_5(bpf_sock_addr_skc_lookup_tcp, struct bpf_sock_addr_kern *, ctx,
+	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
+{
+	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len,
+					       sock_net(ctx->sk), 0,
+					       IPPROTO_TCP, netns_id, flags);
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
-	return __bpf_sk_lookup(NULL, tuple, len, sock_net(ctx->sk), 0,
-			       IPPROTO_TCP, netns_id, flags);
+	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
+					      sock_net(ctx->sk), 0, IPPROTO_TCP,
+					      netns_id, flags);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
@@ -5332,8 +5423,9 @@ static const struct bpf_func_proto bpf_sock_addr_sk_lookup_tcp_proto = {
 BPF_CALL_5(bpf_sock_addr_sk_lookup_udp, struct bpf_sock_addr_kern *, ctx,
 	   struct bpf_sock_tuple *, tuple, u32, len, u64, netns_id, u64, flags)
 {
-	return __bpf_sk_lookup(NULL, tuple, len, sock_net(ctx->sk), 0,
-			       IPPROTO_UDP, netns_id, flags);
+	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len,
+					      sock_net(ctx->sk), 0, IPPROTO_UDP,
+					      netns_id, flags);
 }
 
 static const struct bpf_func_proto bpf_sock_addr_sk_lookup_udp_proto = {
@@ -5586,6 +5678,8 @@ sock_addr_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_sock_addr_sk_lookup_udp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_sock_addr_skc_lookup_tcp_proto;
 #endif /* CONFIG_INET */
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5719,6 +5813,8 @@ tc_cls_act_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_tcp_sock_proto;
 	case BPF_FUNC_get_listener_sock:
 		return &bpf_get_listener_sock_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_skc_lookup_tcp_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5754,6 +5850,8 @@ xdp_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_xdp_sk_lookup_tcp_proto;
 	case BPF_FUNC_sk_release:
 		return &bpf_sk_release_proto;
+	case BPF_FUNC_skc_lookup_tcp:
+		return &bpf_xdp_skc_lookup_tcp_proto;
 #endif
 	default:
 		return bpf_base_func_proto(func_id);
@@ -5846,6 +5944,8 @@ sk_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
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

