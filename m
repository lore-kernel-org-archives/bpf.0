Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407439B974
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682715; cv=none; b=Pf5IYdVlhN7UjbYU5LsNM9y7nn/utRqVJZucQFj0n13YxoxXTmThGTv0MS2SVK5kwLDDyLih4TIT3bNB/UVFzij+LVGLctg9HKmwP5/JHfdcN+wcK3qQU8pPQKyuX2KUgjEzESku8TpINXJZffxZZqR6v86xQy3sPEHo3CFsNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682715; c=relaxed/simple;
	bh=tGFWlJ9Emn6lMayfM7X7YT7f2+X67E/6qliDHAALv6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H1t9oJLPKpP6NfomjB106A3uX6FIio6kY19L/veT6EzJ9Vi0X3b/La4tNpnPr232vNFs/yPdW5L83ajQueELPdunbPLJdoKMbAwfPg+3QHRHw2g9X5vr7ltZiIzasFEifPBO4kH2OGTpJV32xw0MX1z99Inc2XxeZ0VL8GRfFyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuwejd4m; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuwejd4m"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so7683975e9.0
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682712; x=1777287512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo1ra+dvGbFs6OJejHFLsiY9EUjfbBrgYOeoScEsTuc=;
        b=kuwejd4m+mq5a0aewiDuTaXsOZPk0oZtw4A9PqEl9cdOeyrCJulozNifgRHjgsakvg
         CZGT+PgRajEUScOTjIOmPqvTI1JSscnGehNWVDRog2tPhK+q9O+7Ybe9XOLneMZ9k4AQ
         oLyan1IdB6e6f4AYH1xLaFO6082Ts4FzhyyNaq7QgkH1TdtkKkbB3/IXVwHVdP/CWDVO
         rsb5tpeLWk+sYMEnorzbNNB56vyv+vDQfj76Q/AuWSx+9WnR5fYJowZryjZdCS+2CgVY
         huyGvi7YJlHxWHOMdv+TTs1tcHo/WZ2ZYGL3kKVRcEPF5l8dibk3daJXrBW+zD4bykei
         zt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682712; x=1777287512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xo1ra+dvGbFs6OJejHFLsiY9EUjfbBrgYOeoScEsTuc=;
        b=UEHjojE+Bj9krX6EHZuy8v4Gk6ZkwQlsEtTZpfvxgFYTBmOd/YS2iZPSzmrFMTGkyK
         5RkINgJ/5oIJJuoKdH44Rzj0d8u9tygi+dj+CdP9bYfGgF6qrCun810GGZjj076Mx/WC
         4BLW5t+x/bxnroqi9omJFQC2MICmpHFy1Yv4FqFq1wPAJgxURTUAEZxh4dZkwmX0ZutQ
         CpQowNFM/hvNuz2xVs7HMhxrHsj8MOEVHBtDn4+n2u0sfoFxKm9gI7QDOLpedZp1SoiW
         i4L3k1X2EudzQCcE4AfTtzOtw9RSQaMA1dRq2hrBps4LBIf73J6d8MIWbndMxCV6w6VG
         Lgcg==
X-Forwarded-Encrypted: i=1; AFNElJ9SknuwYbLqVhDtN2GmXzgTOIHwM0zqclkgcu3pag+DxFhOEmZ7yPF5idl+iQhc91KAD4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9qf9CfrEyJiCN7H83+UjfPMcHrZtfwZYQaUfViLj2f5lV0uqy
	/ceos7csRvaDGI5kTETQKQun6ZmlzuhComSDux6yAzeQ8zpd+kcroSRw
X-Gm-Gg: AeBDievyBBBxAKxfyyKWCLPCaOtDQYbccllU/eDXDG0Ln5wBF4vgnbCjyb7ne9GY44d
	qcz6Up6Z7ZJq2PLOnx671LF+D2ndlN1RgPbvZg1mXHOoTsodv5LDBSopFQMZafOyysYn/MNjO9g
	R5Kshc6Y0B/DXhV7zoOJ6ZiWa1gXGeOwr9QkTjhlrYmryGigpvvOAuaFXQZ6UJ4Q0geb1gm1A3u
	6zH2FKjmuRqmhCAPw2flFi8wKMwU3wzZi2kN4Z87E3xzUpOYCe23O/pS1onYO9uKGSxEJDbM7y+
	0z1zFdF0XuZSHDveM0IxFzZKMGa5/qi1FagTin1oBHA6QSgjJv95bPGAWdinGSSftVHJQaoKVsz
	jQ7hcDhl/siS37BUGBi7xff4Z/+ym1omoMZan1D8DGeFmjJPMZbIum50XnKQZNKzvqjqkmVGmFQ
	2w5yAzFPDL2kPSUETtJu0FoIpQADGumwCBDZA//w==
X-Received: by 2002:a05:600c:870e:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488fb84ffb8mr180290575e9.0.1776682711829;
        Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:31 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 3/6] bpf: add bpf_icmp_send_unreach kfunc
Date: Mon, 20 Apr 2026 10:58:13 +0000
Message-Id: <20260420105816.72168-4-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420105816.72168-1-mahe.tardy@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
 <20260420105816.72168-1-mahe.tardy@gmail.com>
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

This reuse concepts from netfilter reject target codepath with the
differences that:
* Packets are cloned since the BPF user can still let the packet pass
  (SK_PASS from the cgroup_skb progs for example) and the current skb
  need to stay untouched (cgroup_skb hooks only allow read-only skb
  payload). The kfunc set the dst of the cloned skb by using the saddr
  as the daddr and routing it.
* Checksums are not computed or verified and IPv4 fragmentation is not
  checked early (icmp_send will check).
* We protect against recursion since the kfunc, by generating an ICMP
  error message could retrigger the BPF prog that invoked it.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fcfcb72663ca..a6c3b9145c93 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -84,6 +84,10 @@
 #include <linux/un.h>
 #include <net/xdp_sock_drv.h>
 #include <net/inet_dscp.h>
+#include <linux/icmp.h>
+#include <net/icmp.h>
+#include <net/route.h>
+#include <net/ip6_route.h>

 #include "dev.h"

@@ -12423,6 +12427,86 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
 	return 0;
 }

+static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
+
+/**
+ * bpf_icmp_send_unreach - Send ICMP destination unreachable error
+ * @skb: Packet that triggered the error
+ * @code: ICMP unreachable code (0-15 for IPv4, 0-6 for IPv6)
+ *
+ * Sends an ICMP destination unreachable message in response to the
+ * packet. The original packet is cloned before sending the ICMP error,
+ * so the BPF program can still let the packet pass if desired.
+ *
+ * Recursion protection: If called from a context that would trigger
+ * recursion (e.g., root cgroup processing its own ICMP packets),
+ * returns -EBUSY on re-entry.
+ *
+ * Return: 0 on success, negative error code on failure:
+ *         -EINVAL: Invalid code parameter
+ *         -ENOMEM: Memory allocation failed
+ *         -EHOSTUNREACH: Routing lookup failed
+ *         -EBUSY: Recursion detected
+ *         -EPROTONOSUPPORT: Non-IP protocol
+ */
+__bpf_kfunc int bpf_icmp_send_unreach(struct __sk_buff *__skb, int code)
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
+		if (code < 0 || code > NR_ICMP_UNREACH)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!skb_dst(nskb) && ip_route_reply_fetch_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		*in_progress = true;
+		icmp_send(nskb, ICMP_DEST_UNREACH, code, 0);
+		*in_progress = false;
+		kfree_skb(nskb);
+		break;
+#endif
+#if IS_ENABLED(CONFIG_IPV6)
+	case htons(ETH_P_IPV6):
+		if (code < 0 || code > ICMPV6_REJECT_ROUTE)
+			return -EINVAL;
+
+		nskb = skb_clone(skb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+
+		if (!skb_dst(nskb) && ip6_route_reply_fetch_dst(nskb) < 0) {
+			kfree_skb(nskb);
+			return -EHOSTUNREACH;
+		}
+
+		*in_progress = true;
+		icmpv6_send(nskb, ICMPV6_DEST_UNREACH, code, 0);
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
@@ -12442,6 +12526,7 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,

 BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
 BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
+BTF_ID_FLAGS(func, bpf_icmp_send_unreach)
 BTF_KFUNCS_END(bpf_kfunc_check_set_skb)

 BTF_KFUNCS_START(bpf_kfunc_check_set_skb_meta)
--
2.34.1

