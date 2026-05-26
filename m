Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9987370D68
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809850; cv=none; b=m/eOdfwTYZ2BaSkd4+9DYTNtCbcpUCJGQ15NNMdodqT4UP14LrLKrH4Is8sC6NNIsx1vp8KAHKnWtov4AQXLckaSVkZ84fU9WcDHyL+I+Hto5zPMOH/WVo4uldu/Gt4ZFHvZ0ARiWEoLzV42SkBwWUpQzX/g+xgt/GHJWKQ1gKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809850; c=relaxed/simple;
	bh=ptAcbdL+kbSV77PwAIenMJPVCzFvL2ZNvMdRmmkcDP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WRkwEX9gl7ipbFiPY/3fM3mo2l3+3j4SIe8jaxuuwQS6DV5hRtOVDCkl81XjE1YFW3QxBOz+0IwFuuGnqmg5gYzcI9eJG1Irld+Yu5Z2WJFPkaG5vKPCPJWYoPI220tw3GwCwOq0qKS4BoXu2dwnWOWw5ikQ91BY93gnYSZ5NxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s7Mbfpp4; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7Mbfpp4"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4905529b933so24013115e9.0
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 08:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809847; x=1780414647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wC2miNKigvo1STo6UwYOiI6JNb7uTzCPY971tAbbVuA=;
        b=s7Mbfpp4PwdowE6XvAfT5RR0ZO6wpibcHMWY9DUictBEs3MAQqEevg6DBp8tb+kSQ+
         6T7PPnZGi+zMiku2r5imO26nRgnI0SByAhkx2TbE+N9OkbjhhnvH9ThHfojhwkAaDOd6
         jEHYBelWN+vGlXFX9YPfbsyYHVq+V8FqDdSTbptqxMKhFU7koyjiePwXzXSDQ+J3wcZu
         axegW80C6r7Zt7sMeuf84ktbcKBLHf3BwXtkr1VSl2rqGSKqFMf5rcZO6pChBb7N4KG4
         p/HhdjB9wgIr+/itX/kJOoBOXYTFfXIeRKYOlxPRBq9VN/1ooLKEYmDjB+3ckxj0nQqr
         0Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809847; x=1780414647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wC2miNKigvo1STo6UwYOiI6JNb7uTzCPY971tAbbVuA=;
        b=OWIn9nUFOd/3G49wa7MykdH4av4NDjqydGe3/FX7ygrhBWZA/XdPB9mVUL9xkYA+BZ
         YSQmKcFQ+1rQjTlhgZrKqmOWwFaChzEvCbTzHs3SLymn6KTrdJTqiOT3kPe6xLzTCQQO
         erPaZP8vGCFwUkh8VqmywehG6A50yk0SjtgTcRJnT3nVEXdlaksNy653ZZeynmK4p65h
         TYK/VpOvTAA6V4C9/aXBLLsm6Pw+OCLZW5UzZUG/ZEC+qolZwtLZ8ia6QIiQ06aYDuzh
         Xn5sttbQrp4zAaL80Adylxe9KHHjME0/QzPLp0+ATx8wa7BNc+vPaJTf44BBFuYZc1Im
         DKlg==
X-Gm-Message-State: AOJu0YzaM6THPH+LH20twzpLoKy1qpWDuKn4dysPFAReQobWKQ5C44qD
	xbp93sM7HX7Eklice2rdSqTrEvSlH4b3ZOBRe/YRNsfKfj2YjQ6CD9jJyz/FfkDv
X-Gm-Gg: Acq92OElnivyUztTa1lI8ODR4KwCcyJ42L5065CXbKQpPXqN4P/yQNdwOQ+5guEJcnf
	CG3TN0bNABcmoL/xBXxqD2wOmDzYHpXwi5Z29p+SuhCWy57xCe3KoYkwGiAaxjosDvAjnVq7D//
	AYCsgsqKz7tYPvxqY2L7Ls+462P+v/xxPdao6ZOLb86FKG8/avOm4H6H4ovmpQxLGc0kVrxoBv4
	R5P14q7DaK6gr/nNI91YlqdL4p6bLcROoWKnTaOTiAbMdenj/e1VeiNEC51ii3b96oUjrw2cL7X
	7jgH7tGVwkhoqUbyGqIzPD0gKGPsrLi9K0QX4DBAYhBmZeltQP5Uy0EDlhdDhm4hUvVl6ppjjW7
	GyKzVWm8SRrcBCTgVbhlcPK72xT4ohLBTnXpyh4+eTkpDEkpuQNV/NOCTvjgJmQlxND5K7PFT7c
	MWYyQli1RV3mr+dvb3e3pOk5AbCRaqNJjfoH3exw==
X-Received: by 2002:a05:600d:6413:20b0:48a:9540:1a3a with SMTP id 5b1f17b1804b1-49042495183mr242111015e9.8.1779809847009;
        Tue, 26 May 2026 08:37:27 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:26 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 3/7] bpf: add bpf_icmp_send kfunc
Date: Tue, 26 May 2026 15:37:04 +0000
Message-Id: <20260526153708.279717-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526153708.279717-1-mahe.tardy@gmail.com>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
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

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..6db0bdd71c6f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,8 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>

 #include "dev.h"

@@ -12464,6 +12466,101 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
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
@@ -12506,6 +12603,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12536,6 +12637,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12557,6 +12663,9 @@ static int __init bpf_kfunc_init(void)
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

