Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A23859CB
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874492; cv=none; b=gdgbwKO6V5X6nGsEUj00Axbl6Y1mxBcY5vgsF+vVTivm6cz58xi2KAdengUqDbG4662UA9/4rfOFkKne+sb03lxtgRuGF7Ndxr9/0pp8O9pV6KwJfnNnZSHOhHXvzaz/NWhDBXaka73mWe6zGGRAS3x+20e4nDV3SnYl2h7/7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874492; c=relaxed/simple;
	bh=t+ZUmqoTH3x9Mn//33uyptsML5AnT0/zwKO2l5MZSXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Py6ZO81u10NSKZk6oC812P9DD04NCgsZf+3AcOarTYY7N3vOttDAh22GDJYaHurR23RoIgm5JyLpcWn80cSOY3cY08yw24jV8mCg1QREmnNwQWzjgxOjNuxEfa1QN4T0cHSd4Mm+EIbqob6/u+rrOW0TgXc0cMQ3qgUsBJbOH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxwLbyZq; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxwLbyZq"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so1201475e9.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874479; x=1779479279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ0cSS4RdFV6r4NLPn5LOcakIXUD8UWjhByF8idLuIA=;
        b=lxwLbyZqAWillvJnid4dEf1kvZfPfR8o4Vv2Uew5n84j9IWcmXITlemG2ef61ddeKY
         ocvHCSoZAN50+gYa52OKqex0lEwMUyFzyQPaE9oQgxFSQRYZxmug2jXt4JpZnUX4DgzG
         dr2RfFMkjg2IEJRAcEhhpDG+i9ICSKHddO5IoMJgrcWMcA9eFDJcAOs/GDGrYwhx2jDp
         rkonLvUkz4YQNA9TaGGXi92hzZiPG60Im7QuQLmrU4THxotvjm4jx8uId0S5wPuVvf7l
         7N2G7e+wlYcGB+zVo08YbcjjPRCccV5lDUBOz0+URr4px5oNzNIbOmaMuolP8Jo9CaOC
         tvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874479; x=1779479279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZ0cSS4RdFV6r4NLPn5LOcakIXUD8UWjhByF8idLuIA=;
        b=MNpitfQopUdH+rIKqw1VnDBQ2N0cYeleXtDWgRVgnpyzxka7KXWNfe/snkIIv4U8u9
         ijGUOLFr7JH6p4yg62cfTxod2lr73+eciYAQhUSTEBim5Si7rTWol0m4IqIGBgY157Zh
         rjEKGbC4dBlGYXqGgpCfhmjsivBN4QUGt1uEwGG8xuWF6TDdspXjfZw89JP8598kNSH5
         L5Wort2I59O0dAdQkJtOWnMyekqUBkIeJKI7y/BEMqJI8PCTdDjH4/Emz1cuYUIzfMkW
         5JTHAw+xyAGDA9UOK+YXGMmcOumR47AgHdB35U77yoHHwX17VmEG5nRwmdlQWtsDir40
         WaXg==
X-Gm-Message-State: AOJu0YzV+Q+y9TMSRShIf70nHUufL6nNCCzttrfSVKmwaoRR/qhIGviO
	HCojOgx3vpCqx31KR4q1XP+/M3jaE7hSj7zjYBWEpOSbF+wSO3kVNXS+gjMfS707
X-Gm-Gg: Acq92OHe+4ydufQqiUoTtnX06hraTCnvym4TVprzWGDi8R368kqEDUun3Zp+0Zuilj4
	3+wpCsZ3sWNlLrsgrxtEfKsoEgMjQh3Ewo+jAYui1Vqz+37qGTFpj9tP+SV1qAaomRX2zjdVBWa
	m5zIEkYaJrX5quBo0BNRa5K7hid+XvnCFYXOt0SkPio5ohEyYZFv0Yr1mXicQg1cv28LetDxhqM
	3PETSK8PmXyS+rm4sH5UBeUFSANByUvJz6R12C/VatD9GSz2CPrij4vGc45lQMmMP+0dMUtJcNR
	lA9fPiakHuMszyaorZTmZ2e+0gCh8UTHYohpbjNu+1DdK0fyUX7geTZWu/VQguBiv6gI59zsA3+
	nzFyo6spQ6lwCWc152rylBps5Ls3Kgk4m0gJW6x4JCcL0dZWSnGFh5dIPwDNYnPmbskixItPV/Y
	qPqop4f7jhdruG/a/mpNF03KR1LsBM3IddmHRyE7IQmi13N5+Y
X-Received: by 2002:a05:600c:4e55:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48fe60e510bmr78278755e9.5.1778874478798;
        Fri, 15 May 2026 12:47:58 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm77509945e9.2.2026.05.15.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:47:58 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 1/4] bpf: add bpf_icmp_send kfunc
Date: Fri, 15 May 2026 19:47:43 +0000
Message-Id: <20260515194746.50920-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515194746.50920-1-mahe.tardy@gmail.com>
References: <20260515194746.50920-1-mahe.tardy@gmail.com>
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
* Packet should be already routed, checksums are not computed or
  verified and IPv4 fragmentation is not checked early because
  cgroup_skb and tc programs are called later in the network stack
  compared to what netfilter could do.
* We protect against recursion since the kfunc, by generating an ICMP
  error message, could retrigger the BPF prog that invoked it.
* Additionally, we ensure the IP headers are linearized before
  processing with pskb_network_may_pull(), and zero out the SKB control
  block after cloning to prevent icmp_send()/icmpv6_send() from
  misinterpreting garbage data as IP options. This should be mostly for
  tc ingress progs.

Only ICMP_DEST_UNREACH and ICMPV6_DEST_UNREACH are currently supported.
The interface accepts a type parameter to facilitate future extension to
other ICMP control message types.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..a1fe20b45f29 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,8 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmpv6.h>
+#include <net/icmp.h>

 #include "dev.h"

@@ -12464,6 +12466,95 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
+
+/**
+ * bpf_icmp_send - Send an ICMP control message
+ * @skb: Packet that triggered the control message
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
+ * Recursion protection: If called from a context that would trigger recursion
+ * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
+ * re-entry.
+ *
+ * Return: 0 on success, negative error code on failure:
+ *         -EINVAL: Invalid code parameter
+ *         -EBADMSG: Packet too short or malformed
+ *         -ENOMEM: Memory allocation failed
+ *         -EBUSY: Recursion detected
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ *         -EOPNOTSUPP: Unsupported ICMP type
+ */
+__bpf_kfunc int bpf_icmp_send(struct __sk_buff *__skb, int type, int code)
+{
+	struct sk_buff *skb = (struct sk_buff *)__skb;
+	struct sk_buff *nskb;
+	bool *in_progress;
+
+	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
+	if (*in_progress)
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
+		if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
+			return -EBADMSG;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		memset(IPCB(nskb), 0, sizeof(struct inet_skb_parm));
+
+		*in_progress = true;
+		icmp_send(nskb, type, code, 0);
+		*in_progress = false;
+		kfree_skb(nskb);
+		break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (type != ICMPV6_DEST_UNREACH)
+			return -EOPNOTSUPP;
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		if (!pskb_network_may_pull(skb, sizeof(struct ipv6hdr)))
+			return -EBADMSG;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		memset(IP6CB(nskb), 0, sizeof(struct inet6_skb_parm));
+
+		*in_progress = true;
+		icmpv6_send(nskb, type, code, 0);
+		*in_progress = false;
+		kfree_skb(nskb);
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
@@ -12506,6 +12597,10 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)

+BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
+BTF_ID_FLAGS(func, bpf_icmp_send)
+BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -12536,6 +12631,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_sock_ops = {
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
@@ -12557,6 +12657,9 @@ static int __init bpf_kfunc_init(void)
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

