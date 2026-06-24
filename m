Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE083321BD
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327379; cv=none; b=nVcoreKyWYYaIBJT4mutbi413irIiwLC7AYTMyIBWT3Pp8Fz74ioFct4NHWobj8Nw5c9Hxg8ivxPaV+iOp9x/WTAQhsVBWfpA1ECQWRNaFtQ9bMikH9SbJVA1TnfLjNRvtk1sBFpgCrasJXuzm5QUwtQOvo8yoLUy6ATd42kPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327379; c=relaxed/simple;
	bh=nJPafP78NSf31msC5WWWuZGKqw1cNaJ/vqOlks5v//c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Csub7J1zvWBxEAJ0X66PK3eIruXHU102/tzMDH6tiDZX4XB1dLuJj1JpZ2GkxNuJZvLGOiPJMsnuv6n6KALeZxR8YtAwfu2fpvc1Ope4sSlbr71cfZxQEIdide3rbAVEgli72BNrvQ0ap295hUZYd/EKaLH8KAYBxE1BHt8DcQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qwHbee27; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwHbee27"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49249072f03so8255035e9.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327376; x=1782932176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HCEmnBQPBfQzydwCPqV97zRjl2Zy/uNPAQB5Q19WZ0=;
        b=qwHbee27BxGJn2MJ70GfipUaAsAuWDJVESJeuNEWuBj6UyyNM7QRkYHz7xrPbiaDm2
         OCY0SsXXAwkZTUcEEFUBw35uZ3qxWlAOPZHB8a/PJWGscMD/Yw52wKworvTnhVvYTL3P
         OeeZuSlfHT4SE1nb7jN4dTeyzQgPpRxhzuE1YDodr/CahOBtfApt/o7DM1TH6z+dq/NO
         DyXmfJr+Kiz4Bpvc0h5Fd416x7FgRVqveYp+NHXSdohX+Un4FrfIxxfRCVJvynC6el7X
         jEU3FIN53opQJF6N/VYCWKwK+FNG/t4AgOJahkfZxSnMHHGNQLs0uaVPLrjR/5ZMfP3M
         6Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327376; x=1782932176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HCEmnBQPBfQzydwCPqV97zRjl2Zy/uNPAQB5Q19WZ0=;
        b=XE327B+o3jMt/UArSHsPE8a5kZCeF6kKCRKqpERh08FOEdwK/wuNxRxJhMRsc5sB8q
         xipmfUoE3XWu9MQP1XjCuMOVc18RKl9i7SvPU/C9rFc/gSix4yU+w3V9+VrmpIwA81iR
         wBJYCfjxWQyqjXlJUtJwe8YfNzyXcxeRC//jZoFL/Fvs5iaI+BsLgxWDi924Vcnwut+O
         2+Kq1PLyF+yFqNt+GBY/4ds6TC6AWYBlIh3wQzOSbabb2HdtAvF1aQ50txx6AKfAWUWl
         65zNKTJJkubvTyj9yuPOi1JHtAYjTyfRYxhj0SL7P7pvcSauLTphuMNn6VJr/M2Fg+eF
         U+Og==
X-Gm-Message-State: AOJu0YxFPHAEhw5yVbt8oTw2DIpE+zWYtflAfRJPJq+kXA8HaxtLgOCs
	FsG12I6ZZNu39Nl+3Y+uoig8xC6SkWJNdBGzkVr+ZvDBVQjzIR+HGnJwy1YjKpvk
X-Gm-Gg: AfdE7ck2CoePSbEf7QBoeCBJ8sgcsYFamHfChzOm10ulRQ/V+WbS0DUSd7s1+TrmHaW
	TA9EeSDj4HbD7EYJewTYspcAP6g5+k1sRYxOFB+YyJTFxQT4dKGeiZ0xUhcfzZRg/f/25P2HLIP
	lxBMwI/u8itgg2ZLu0Fa0syihFdCjpBgWnZTzKv6e8+2EogNyoU0Va3Ob2745fwCne5atxKECqe
	x9OKEXi7lfqfS6/SejzDHn9mlkq41mc03o9xFcEbN+qoxricVkPyNtQzwC9PApUdv/ru/q+hBBM
	BUgdbXVdNHBHDmQ/SqsuhQafyR3UVHnc1MTAALnjYKe6QA+s5UieXy0K2uQmav0H87DAP7QtzHH
	3FcJTzHqrr/h6r+r4SxgAR6KZw7VNmTmwtE5W1pUUWerQWVO8i+T7qoHuVX77AAl5wPke0ijD8F
	o+7A/DceP4Xtm6993r
X-Received: by 2002:a05:600c:c494:b0:492:5a58:3c6a with SMTP id 5b1f17b1804b1-492608496d5mr65828075e9.5.1782327376359;
        Wed, 24 Jun 2026 11:56:16 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926417f0c7sm9847805e9.14.2026.06.24.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:56:15 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v9 1/5] bpf: add bpf_icmp_send kfunc
Date: Wed, 24 Jun 2026 18:55:50 +0000
Message-Id: <20260624185554.362555-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624185554.362555-1-mahe.tardy@gmail.com>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
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

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..f3aa494ed105 100644
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

@@ -12546,6 +12549,84 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
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
+ *         -ENETUNREACH: Unusable IPv4 route/dst attached to the skb
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
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP): {
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH ||
+		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
+			return -EINVAL;
+
+		/* icmp_send requires a rtable; test-run synthetic skbs lack one. */
+		if (!skb_valid_dst(skb))
+			return -ENETUNREACH;
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
@@ -12588,6 +12669,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12618,6 +12703,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12639,6 +12729,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1

