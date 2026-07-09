Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B313769FA
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608557; cv=none; b=NfC1/NH1qSx/pW/s1kBg9Yqjn4ODAyYdfK1ab7XfsXfWfux+356zuYP79C821CAg8oa4ybUg1qk36dMmMSuwQMkaffjJgxVMKPacwru097T0cX8k3Y6alYgckDm5ZnBaVlDtI6SKFbmJzbak02K0SgXIpHpBUhhWDf/zxCrKqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608557; c=relaxed/simple;
	bh=ZRFhpPUtEW8B4kUm7ia+hrYUQRCVnSj6Ua1MmfP0hjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSv4/pUfyNyTNwxe+EskPedFrhOoNQ2a0wuyiBMNz6GUlaWUYJ3sRmyhErOzVcBmx/UnL4skbznsNl0tfdaS18G3YfaBvH4SmWuY8zPpKMKDr6wuhAzzQA1HJunCh3N0xLKidTnBbXZGsZXkeHhzfkNHKbF57swLW4z1pu212FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYA8oM0q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYA8oM0q"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so15338755e9.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608553; x=1784213353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ca30GWBimSiK84bMP03NLphqnI2ZnfW4HWnsucbkbvA=;
        b=kYA8oM0q+6squSpMX5GXqOXfw/HC2NqqB+6ASg7aunlY0ThvECpk3JlMEFcz9Bygv/
         PVgbxjRcM6qSRSuiLrmTnk7wQgLLJhvyIGxR9GutX3nEnfqfypjuaBO/59oM8zbOPZUK
         Sr7r7KFI9BQtrRAFgqTWoPy7MNo1fSVI9IVdyIzTkw8bg+QuP0uv79yVjOqV1N0TKqce
         h5Vc/TTQ3SwdHazLkl8l7BePu+Fv+BgncGGOj7W/jKNZHPPpO4hlXUbSD+3LmGBKUDZB
         y79zK5P0ZrW6KFlL43EMeNm1OdP/53MCjCu+6g1oEoxwxKMBN28GTQZ6TLK6EfKdSa31
         Pn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608553; x=1784213353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ca30GWBimSiK84bMP03NLphqnI2ZnfW4HWnsucbkbvA=;
        b=PxSfO6pr4xKdF2Rw2zXDnwNf50sla1uun+TiTiXuG6bZ1lfJ4KjJqG2GLGbnvfOvPX
         aoGKF2uf1NeMEeQnHkUuN2sb1OUwGQ9wPUGHSUFESnKw0X3N2LuFYkBd3TCmDghMU4Tg
         XMX9aVw3g8k2HgumF8LFIOcvHS7zgPtjaSyIiqlBJLYPfQhukyPh8dywgC0lrB+KaV8B
         sY77DKFFFP9Ls5qhW8uhpWm5cFxysX3fmHLBMWsqdZWgI/KqkYBgnHEzKB7PlsgpXHfL
         uXk6BrEKmNQqQG5u4EXtcSSBwGgWrWvhaGe5vhYCrF5T4V69tS2QA9k8OlloDLUf8VvN
         q74Q==
X-Gm-Message-State: AOJu0YxnS3sO+FhSlb4XZpsz35oNk2o2h7kNKCfZn8fXgVbYu7/xJVsi
	ZTFErq39tX9hHIYA6X/yFCgChmyB1ajg+5hms3nNp8S2NFgDEBmAM8CtnfJg4yFMT/Y=
X-Gm-Gg: AfdE7ckIildyu06Jtqma3ITXAdwYvrZ5Z/pp10uvnozIdRT3n7U0U1jIqH7MA5QKkl7
	jENGXeXDyclZoSghGTwiIgD7FEKN0hbRavw6mi084eLVnL/2YtLkGGS2YBQqTRPxLh121eXAqAy
	Cnd49UALKN72H3Yd/vFa4ar8pOou4xDHKwQXz/Lb8WSVNdViju4ctxXmq5i2t/5BeSpgJVZuB1p
	8zBau+zaH4AVdY8+Pt7esfjimwdZdd3Q9mNK2sg+9Fn6q09SrbtkABcuefYNwnOarLzU99f/Ed0
	cZhQbxv1bN7ujVEOFxLWcBQMvkOKxgJxBXttjBJUMA3hF2zHlJMrO1jz29y54FMc0QQaD/DMric
	UTbvLe4d1t8WwvxVbfiTSVNxEA4THMD60wnzWO0YY6cKa18NevWt0YPXYPT/+a8OqF5EAsIFLK/
	72YsVS9P8Bp4a6dUDw/2MDLXxZMX0AxoOZ4eNek7qUdnVlvHctrmeapZUwig==
X-Received: by 2002:a05:600c:4f8b:b0:493:bb4d:4dfe with SMTP id 5b1f17b1804b1-493e68ddce0mr78828435e9.23.1783608553221;
        Thu, 09 Jul 2026 07:49:13 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:12 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 1/5] bpf: add bpf_icmp_send kfunc
Date: Thu,  9 Jul 2026 14:48:56 +0000
Message-Id: <20260709144900.245904-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Tetragon to provide improved feedback
(in contrast to just dropping packets) to east-west traffic when blocked
by policies using cgroup_skb programs.

This reuses concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still let the packet pass
  (SK_PASS from the cgroup_skb progs for example) and the current skb
  need to stay untouched (cgroup_skb hooks only allow read-only skb
  payload).
* We protect against recursion since the kfunc, by generating an ICMP
  error message, could retrigger the BPF prog that invoked it.

Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
The interface accepts a type parameter to facilitate future extension to
other ICMP control message types.

For normal cgroup_skb paths, the skb dst route should already be set.
However, bpf_prog_test_run_skb can create synthetic IPv4/IPv6 skbs
without an attached route. In that case, icmp_send returns early, and
the kfunc would otherwise report success despite no ICMP reply being
sent. This check also reject metadata dsts, which are not valid struct
rtable instances. While IPv6 would stricly require only rejecting
metadata dsts, same check is applied for API consistency.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4f5cbcac3e78..e4697036c67b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,9 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>
+#include <net/ip6_route.h>

 #include "dev.h"

@@ -12548,6 +12551,83 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+/**
+ * bpf_icmp_send - Send an ICMP control message
+ * @skb_ctx: Packet that triggered the control message
+ * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
+ * @code: ICMP code (0-15 except ICMP_FRAG_NEEDED for IPv4, 0-6 for IPv6)
+ *
+ * Sends an ICMP control message in response to the packet. The original packet
+ * is cloned before sending the ICMP message, so the BPF program can still let
+ * the packet pass if desired.
+ *
+ * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
+ * supported.
+ *
+ * Return: 0 on success (send attempt), negative error code on failure:
+ *         -EBUSY: Recursion detected
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ *         -EOPNOTSUPP: Unsupported ICMP type
+ *         -EINVAL: Invalid code parameter
+ *         -ENETUNREACH: No usable route/dst for the ICMP reply
+ *         -ENOMEM: Memory allocation failed
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
+	if (!skb_valid_dst(skb))
+		return -ENETUNREACH;
+
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP): {
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH ||
+		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		memset(IPCB(nskb), 0, sizeof(*IPCB(nskb)));
+		icmp_send(nskb, type, code, 0);
+		consume_skb(nskb);
+		break;
+	}
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
+		memset(IP6CB(nskb), 0, sizeof(*IP6CB(nskb)));
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
@@ -12590,6 +12670,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12620,6 +12704,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12641,6 +12730,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1

