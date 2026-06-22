Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4C396B79
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 12:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129933; cv=none; b=M38S5fPZogHW/iaEoIORcUkCZzHCMkODO0vrcA64pJD2UhwzVopbIMz40qYD2gKAYzz09VqCNzCK/dCjTWQNw06TPMezy1r52NscdfJ9Vd0aeozGVBlrqU15O2oRF4qTYTb9iXbG1jv4bZ0L/A6yM9sV9AmoqsoyNNOSFATc/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129933; c=relaxed/simple;
	bh=EaT57APwDLbRDVSJpex3SzVfEaGvAq1jZhGocpW41BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gn10iYKKNuDaSrIvRwZqMxiANTOzTVNCoUqOZRCUsJbx/8Vj7qh51GTvA9yYvV3S2NHnjshLQWYXKUPNEW7hz6OMJ2g2chtMZo4bowhTwt/TE2Ou3tz1CZVerSN6ft13tFTnJ1I5DaU9wZw1EV451F83w5zfToMpEJurzweneIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=spbyP6t2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spbyP6t2"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49241896317so14861425e9.3
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782129930; x=1782734730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8wRHqN1v5qtDf6h6onUf5Z6NIMoxTDlFE+BkdNR4SQ=;
        b=spbyP6t2TlPgNaiUxKGEmnuszdXkI6En6ze96KNgO/4XOcDyFKtCZhFvqGMjtbuPsw
         Hvif41J1lUoMbiYXKoZwu6KFpdsxOWTpaJKjd3wD857KoZFTYxhfE+VA1dIS3+6y6PZh
         IvpnEtEhAcOGn6UbPjacPZrFpQVfI3QBaAKLXEehh6bEs656xL9Q1GFKTWRLvMYcMlK9
         h225Or+AfUyApFWglhINKuSV50L2RptQJ1Q4spZd0yX0taIYK2GxxXcDk+45epCP9Rhz
         ehnjv1MR/jdNfhniKQWaow7ms6VwfEntFbW7YvJqfrup5lX2b5Qo97I5cCCvU+oddWAp
         4VDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782129930; x=1782734730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a8wRHqN1v5qtDf6h6onUf5Z6NIMoxTDlFE+BkdNR4SQ=;
        b=HZvpJeuwHxYz8UwXzN75NUvB2foiUf1KMhCtOQfzwRibhsxZnPEHERgp+As0KOujyu
         ayyY28EaGbhDO2VLBzA2nQ9QcJ9Zuz21/RqzF7JuPL0RcMJSkmaJN3ZEnKaHMv1dgKpX
         MyFgWQCRFmezJJcRhXMTUREdyoCjFM2jvSo7v6MA2lg7MGj9xIdN9ZCMpGk4WNMenHeh
         kfUEYjkB0+oFi2yY+/dYdPYTyiWmL2L7EruLCq6ooKou43tguNd5zYA0D5ZEvf9eAX2l
         TevHxbRaatAtq2KnUs13nyHw9busohyo7yiXfZxXM2YDq+/YMUiXaEzmCfIRfW0hT8R7
         UKcg==
X-Gm-Message-State: AOJu0YxXGQyS/XKKYr57S3DOu53HitzX2scTmgIRLnCbv6O6O/g1KPON
	wJusk7ff8X6QJxgdB36aBYKRv+Ja0EHfMC30PhxxKs8GoCsnPyuGt/l/SQ1FR0xY
X-Gm-Gg: AfdE7cnJl/vNclNWuMxhShs4PGz8OLmBeIpcTy4D+JlpqoGss5i1XZzCi6E3S9Rr0G/
	phvqSQJbtxIg9R4ftdTHCafYs3NAB+mngzpzD2udUQC2Nop0b5jLV3qdfGKLqGTthwYcrJnXT7S
	T4V2yp+5DixEaaUSF5ckbzHpKs3h0C1FJ7yITRg539YoKRFipKHXJbFjNly9g8urQCVOhLddFpy
	ankRTqFsTJPuH1zaWRyJ9Z8vRqNQRINXLAvPFTeGc+NdMyOu99oCeXLtzD6AdvbMxzM+NCzQR1P
	Ia0X0XiFCtZpSJnid9+A7Rc2Cli48LM/nHLDaFQsPDjnNeDUCSCJsgQKBJ/tetR/HjHzNlvPxih
	l6jiLDzM+EKsDVsT8WTot534E4Z2ShSXXt/2huy3VKdpcdm7zxYPKjQDXyCCvNtB9kPbu9btF3m
	1cCbwNZXas+8SBK4m7
X-Received: by 2002:a05:600c:1548:b0:492:48dc:3d0d with SMTP id 5b1f17b1804b1-49248dc3e0amr147076885e9.12.1782129929529;
        Mon, 22 Jun 2026 05:05:29 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm491083105e9.0.2026.06.22.05.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:05:29 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	kuba@kernel.org,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	yonghong.song@linux.dev,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v8 3/7] bpf: add bpf_icmp_send kfunc
Date: Mon, 22 Jun 2026 12:05:11 +0000
Message-Id: <20260622120515.137082-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622120515.137082-1-mahe.tardy@gmail.com>
References: <20260622120515.137082-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Tetragon to provide improved feedback
(in contrast to just dropping packets) to east-west traffic when blocked
by policies using cgroup_skb programs. We also extend this kfunc to tc
program as a convenience.

This reuses concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still let the packet pass
  (SK_PASS from the cgroup_skb progs for example) and the current skb
  need to stay untouched (cgroup_skb hooks only allow read-only skb
  payload).
* We protect against recursion since the kfunc, by generating an ICMP
  error message, could retrigger the BPF prog that invoked it.

For now, we support cgroup_skb and tc program types. For cgroup_skb and
tc egress, almost everything should be good. However for tc ingress:
- packet will not be routed yet: need to set the net device for
  icmp_send, thus the call to ip[6]_route_reply_fill_dst.
- fragments could trigger hook: icmp_send will only reply to fragment 0.
- ensure the ip headers is linearized before processing, and zero out
  the SKB control block after cloning to prevent icmp_send()/icmpv6_send()
  from misinterpreting garbage data as IP options.

Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
The interface accepts a type parameter to facilitate future extension to
other ICMP control message types.

Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..fc69a14650e4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,8 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>

 #include "dev.h"

@@ -12546,6 +12548,101 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+/**
+ * bpf_icmp_send - Send an ICMP control message
+ * @skb_ctx: Packet that triggered the control message
+ * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
+ * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
+ *
+ * Sends an ICMP control message in response to the packet. The original packet
+ * is cloned before sending the ICMP message, so the BPF program can still let
+ * the packet pass if desired.
+ *
+ * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
+ * supported.
+ *
+ * Return: 0 on success, negative error code on failure:
+ *         -EINVAL: Invalid code parameter
+ *         -EBADMSG: Packet too short or malformed
+ *         -ENOMEM: Memory allocation failed
+ *         -EBUSY: Recursion detected
+ *         -EHOSTUNREACH: Routing failed
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ *         -EOPNOTSUPP: Unsupported ICMP type
+ */
+__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct sk_buff *nskb;
+	struct sock *sk;
+
+	sk = skb_to_full_sk(skb);
+	if (sk && sk->sk_kern_sock &&
+	    (sk->sk_protocol == IPPROTO_ICMP || sk->sk_protocol == IPPROTO_ICMPV6))
+		return -EBUSY;
+
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP):
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!pskb_network_may_pull(nskb, sizeof(struct iphdr))) {
+			kfree_skb(nskb);
+			return -EBADMSG;
+		}
+
+		if (!skb_dst(nskb) && ip_route_reply_fill_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
+
+		icmp_send(nskb, type, code, 0);
+		consume_skb(nskb);
+		break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (type != ICMPV6_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!pskb_network_may_pull(nskb, sizeof(struct ipv6hdr))) {
+			kfree_skb(nskb);
+			return -EBADMSG;
+		}
+
+		if (!skb_dst(nskb) && ip6_route_reply_fill_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		memset(IP6CB(nskb), 0, sizeof(struct inet6_skb_parm));
+
+		icmpv6_send(nskb, type, code, 0);
+		consume_skb(nskb);
+		break;
+#endif
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();

 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12588,6 +12685,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12618,6 +12719,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
 	.set = &bpf_kfunc_check_set_sock_ops,
 };

+static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_icmp_send,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -12639,6 +12745,9 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_icmp_send);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1

