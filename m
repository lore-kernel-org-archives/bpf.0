Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B43AE707
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385414; cv=none; b=L4I8JJkT5k02wFJbWsjGeqfJBFiMSYjdOAwFmdJv7KhNd0U5097Gu0UbCvz/VMBf3dXeoGnEe+q4xY2NU7dw/aUHM3vWTXPPL9LNp9bSH8Hmg8GMrJyA6jpzzQujRG9zB/KxN+6To7AEJb1JoZrpxgv++fabSLW5960+TJnXkRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385414; c=relaxed/simple;
	bh=pGrPvigNQomTZg+yIiWmTRGVWTpeIzulMWGMercaVgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHmwtZXumJJ0Xkr/l+c7l09lERoqGYQLZ/kxAa/OMNF0j+HxWVkVpH+Pa8ecUVaDdCqcWzgn/BVGZ8UYSafyZORpfEW6mCLrc6Vw4hhMhC8OWAIdlwx2VAuEjZNhG4KXJXA2QHVZGE9kYlHBI/OMXn1/eS8Wh1FXJlssAJHdkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mimX07OL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mimX07OL"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4924593f45dso24784015e9.1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385409; x=1782990209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rinWcAerH3qNMotm0IPYw3JUA24H1mMr9Uz3XuEExc=;
        b=mimX07OL+2Jzk//KcbM4fSAH5VfBuGmvUpAaw34MlSYuUfPe0SHjSCnq0vEgggoNzx
         YEIwM7SDyogtBtNoc0qFaKT0yiBSPDuWSpENZE9NhBl5Wy45Fyp/b7MVPGWXilONc0Vo
         FoiLkPJo+HOP8qEVWEWdbHTfD8yUhkewQh5sBMbvQ1v+nPMWspEDxfZg6SoqwhL94lAm
         6iLjRY8xElUmHiYUHO4lmyFgiCwqri8ZH/Ylf6+QJ26jAYJcJNp5eyNTIx2GAS/Qi02y
         e8CXtVDUD54kIiILnlQxw/QeVA3LCr7TA9fKq5wQxxoP+tiIYY6Z9Nz0LzOA0G4+X6Yx
         ycZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385409; x=1782990209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6rinWcAerH3qNMotm0IPYw3JUA24H1mMr9Uz3XuEExc=;
        b=iIZ1lb/SvkvqxqEC7ZBm75ZUqGUmK2KdaugQUhXOOBrs9/YrixwQVsHowk8JE3vaf+
         w7AaH2ZovKr6EHfyvo3CyELHhQGcCHfsoU0zMJutD9kD9A4VPmV8gL2J5+uKMpCuupb+
         Ta8Je3I/81rzt89DU4VhdktLtozKC+KcEFyPjkjihhzHhzk6UeaE0Fj4PSMioUIE9AlT
         Pk4gtgi1moJ0UHtSDeuAbVC8a7aSPRSuu5CnIZtPCpPjz2aYM8dmmXw+M78Y2qaM90IA
         TlL+CKk9tix0V/RqV3jOoc1W3gCYCaUKLql/pFr3Ampe+j171l+Pyon7cmr2P5sZvYtl
         vGMg==
X-Gm-Message-State: AOJu0Yw3oaMJpUVjRrBx5LrfV8aPdPCtT2qAjzigANSXFmlraVnpyqxs
	w6jl6SVWEoIwWiUmxD0k6l59bu+mTLJzOp7P+vcZP1oGYzfgKTbaDmoPfCj6hv2ZDeo=
X-Gm-Gg: AfdE7clk4dSipvs/roo6QLITq7iBWjuwt3ouNc0OrjCF87JBfc4iCCItAq1sPLWMaTG
	D1YIN8nwpuN0vtkCYa2CfFgbgL4f14jru52rTn5vm6AW8UgY6Vgi7ue/K2rxbnJIWg27zxM4fbE
	7zpsug7+wUPmJtneDfXhhxV6c86LiydhCMbo1UyDpyM/549U91wG2CH1PdH60phQsyEcqcyIBx6
	VOCeURqDhjkdb4Etn2t0ykBLd7WA0Hckd17aguKZa7CgO2b0gBF4YtAQNesiVd4orNpTELwHaVO
	F/ep6uQGFvPbhexxols40S+45fT++HHYsp0wlAsffQEdplJf93z6vKF2sDW/VfP90f2ssUcYc6B
	+ooTPU4go1yvhfn3iXqBRXIqQXCMuf+5r1kkBpB6HyCHYzUjaNSPmiRJYp8JSc3TP1OhOmDNVh2
	0hlEv8wu+4j9z+t/sX
X-Received: by 2002:a05:600c:4747:b0:492:40f4:9fab with SMTP id 5b1f17b1804b1-49266889b4amr26167985e9.29.1782385408815;
        Thu, 25 Jun 2026 04:03:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:28 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 1/5] bpf: add bpf_icmp_send kfunc
Date: Thu, 25 Jun 2026 11:03:17 +0000
Message-Id: <20260625110321.28236-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625110321.28236-1-mahe.tardy@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
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
However, bpf_prog_test_run_skb can create synthetic IPv4 skbs without an
attached route. In that case, icmp_send returns early, and the kfunc
would otherwise report success despite no ICMP reply being sent. The
check also rejects metadata dsts, which are not valid struct rtable
instances. For IPv6, reject metadata dsts only: icmpv6_send can reach
icmp6_dev, where skb_rt6_info treats any non-NULL skb dst as a struct
rt6_info, which is not valid for metadata_dst.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..0a0191586b44 100644
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

@@ -12546,6 +12549,88 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
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
+	switch (skb->protocol) {
+#if IS_ENABLED(CONFIG_INET)
+	case htons(ETH_P_IP): {
+		if (type != ICMP_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > NR_ICMP_UNREACH ||
+		    code == ICMP_FRAG_NEEDED) /* needs a valid next-hop MTU */
+			return -EINVAL;
+
+		/* icmp_send expects skb_dst to be a real rtable. */
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
+		/* icmpv6_send may treat skb_dst as rt6_info. */
+		if (skb_metadata_dst(skb))
+			return -ENETUNREACH;
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
@@ -12588,6 +12673,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12618,6 +12707,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12639,6 +12733,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
--
2.34.1

