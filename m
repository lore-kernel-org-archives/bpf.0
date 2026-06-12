Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD12C21F8
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781223491; cv=none; b=ZSMx9WegyRtyVddk8+4e5v27+VZmS+s9fVU50y+vVXtvKWunu4NYzdWmugulPbka9CmL1bumtN1zp0TrtfbJtx0Iu2oId0wcJi1DXbNAZ/hTShlLFpN77+cvy87wT7utLzoUxFjYjlM4GH2nUEjti4YWefpLFdxfwA2VEXatsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781223491; c=relaxed/simple;
	bh=ZslaLYxQHa+GtTpwzcyP8As5CSPlzvA8zBd+BqBNwmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NzoYAkxlP3NFtiSzILvc7uPafCH/4lGII6CMPn/XMtKDWb5q+9UfaR95i3BmdksLAzbxZZVh2aE+R5+ddSXz/SMWYIl3TDewR67v1cubp6vB4lHJP6oPHYvBLLACR9+2oouPCq6TDPPyL1C1tY5RLcgW0bEbXvh+NO2ffWXSVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpXqNNaH; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpXqNNaH"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84240b58211so291716b3a.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 17:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781223490; x=1781828290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgM6K4qg54GyuG6WtlnLYNp1auITGq1UJ9Qa6hTjpGQ=;
        b=IpXqNNaHcGvYxiy3OH6gsXRudK5EM9T65x1QYCON07c2FhOlShXMDb8Kw0zhs8lx6Q
         VU7sODK0dSqb97fehNyYM6zoiIJNO+WEpWnpSKDWlBg6a47MqFmnNpx19O2TYokhRT/o
         3CCtzxk1aVmpddOIMH2N1ezpHT+CVkRGA9/RVxJLL3Xfd+FDhipnDDp05XAKQsZ0OBxq
         17MzbmjJP3IqaALAw1YhiR0WG/CcfxQ6DzfNX4X6PetJkisZ99ox81Boec45CQzR785H
         8S1WNjENPyOHRmLj5qSyhWNVXPvZ0Us0IjtzQDc0R/2Mv5diDJmmRKTSlh8lioxb7B9B
         tBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781223490; x=1781828290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OgM6K4qg54GyuG6WtlnLYNp1auITGq1UJ9Qa6hTjpGQ=;
        b=cMsRc6G9NhKnq4amUCfSN1jXXfkRdKOK1af3o1i4PF+IcxQl/q/XjCY+/p9JFk0CT+
         lU7r2JxK//emM0bFViey3avQeVko02I4ceHiqSeGRMQg+KadNKYdcmP2AtLjTePZ/gT4
         hO2TpSxpGF0PG1F23/j23xe8hfmR/df6KIiDRc8XF+VPdOERHI948JT+b0mV9GjoprUh
         nQc7cCWYuQk6TtO1lkhKxucvStQtpTuGww084Wh8DaROi0HRXiKX/tahSmmyUW0jmAxp
         inwi70qmE10MDGBvbL5zvjEZWa3N1nOA7zc8BIczw6zAxVb5ED60WBhS0PuUjgq1TyJP
         9bqg==
X-Forwarded-Encrypted: i=1; AFNElJ8lIQ9wsd2UtcULe9HfKTLZepjxyu4ur/hv5h0hwqM0JS026k9XnY2Mj0+VOFLBkFSyA2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YymMyz8dhsqeFLdDJi5/da/dLHOYKpaGCQqkrJxlFsFwTI8UUxn
	dLvFAmLezW3p4aLNYUmqO9Zq1BFGZRRalLWqDqHf4Oeg8LYr0XBWAvTIJTAgJar7xqHc80E+HHY
	R1vJfFg==
X-Received: from pfbfj40.prod.google.com ([2002:a05:6a00:3a28:b0:842:3d2d:1e84])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1d0a:b0:842:57e8:1bdc
 with SMTP id d2e1a72fcca58-8434cd43ab3mr366513b3a.18.1781223489497; Thu, 11
 Jun 2026 17:18:09 -0700 (PDT)
Date: Fri, 12 Jun 2026 00:17:34 +0000
In-Reply-To: <20260612001803.23341-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612001803.23341-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612001803.23341-4-kuniyu@google.com>
Subject: [PATCH v1 bpf-next/net 3/5] bpf: Add bpf_skb_set_hwtstamp().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have some hosts where packets come from special hardware
and are provided directly to userspace, bypassing the kernel
networking stack.

When standard socket applications are run on these hosts,
a userspace proxy is required to mediate traffic between the
hardware and the applications.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     ^                               ^
  userspace   |     |                               |
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|  virtual interface  |<---'
  kernel     | |   skb   +---------------------+
  -----------| |-----------------------------------------------
              |
              v
       +------------+
       |  hardware  |
       +------------+

However, even though the hardware fully supports timestamping,
the HW timestamps are not directly accessible to the socket
applications because the skb is consumed/injected by the proxy.

For RX flow, let's add a kfunc to update skb_hwtstamps(skb)->hwtstamp
at tc/ingress.

With this kfunc, the proxy can carry the RX hardware timestamp
via encapsulated packets (e.g. in GENEVE option) and BPF prog
can extract it into skb_hwtstamps(skb)->hwtstamp at tc/ingress
of the virtual interface above.

            +---------+                 +----------------------+
            |  proxy  |                 |  socket application  |
            +---------+                 +----------------------+
              ^     | encap packets                 ^ recv payload
  userspace   |     |  w/ RX hwtstamp               |  w/ RX hwtstamp
  -----------| |-----------------------------------------------
             | |    |    +---------------------+    | skb
             | |    `--->|       geneve0       |----'
  kernel     | |   skb   +---------------------+
             | |             |             ^
             | |             v             |
             | |          +------------------+  extract RX hwtstamp
             | |          |  BPF@tc/ingress  |   and set it to skb
             | |          +------------------+
  -----------| |-----------------------------------------------
              |
              |
       +------------+
       |  hardware  |
       +------------+

This allows transparently proxying RX hardware timestamps to
the socket applications via SCM_TIMESTAMPING.

Note that bpf_skb_set_hwtstamp() calls skb_header_unclone() and
bpf_compute_data_pointers(), so it is marked as a packet-changing
kfunc.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/skbuff.h |  5 +++++
 kernel/bpf/verifier.c  |  9 ++++++++-
 net/core/filter.c      | 23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 115db8c44db2..b4ac1180f5a8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4701,6 +4701,11 @@ static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
 
 #endif /* !CONFIG_NETWORK_PHY_TIMESTAMPING */
 
+struct bpf_hwtstamp {
+	ktime_t hwtstamp;
+	u64 reserved;
+} __packed;
+
 /**
  * skb_complete_tx_timestamp() - deliver cloned skb with tx timestamps
  *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7fb88e1cd7c4..6b23577d001a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11191,6 +11191,7 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_skb_set_hwtstamp,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11283,6 +11284,11 @@ BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_stream_vprintk)
 BTF_ID(func, bpf_stream_print_stack)
+#ifdef CONFIG_NET
+BTF_ID(func, bpf_skb_set_hwtstamp)
+#else
+BTF_ID_UNUSED
+#endif
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
 {
@@ -11364,7 +11370,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp];
 }
 
 static enum kfunc_ptr_arg_type
diff --git a/net/core/filter.c b/net/core/filter.c
index acdc66aa4f27..ab7adef9c015 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12372,6 +12372,28 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
+				     struct bpf_hwtstamp *attrs, int attrs__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)s;
+
+	if (attrs__sz != sizeof(*attrs) || attrs->reserved)
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (skb_header_unclone(skb, GFP_ATOMIC))
+		return -ENOMEM;
+
+	skb_clear_tstamp(skb);
+	skb_hwtstamps(skb)->hwtstamp = attrs->hwtstamp;
+
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
 /**
  * bpf_xdp_pull_data() - Pull in non-linear xdp data.
  * @x: &xdp_md associated with the XDP buffer
@@ -12500,6 +12522,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_skb_set_hwtstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
-- 
2.54.0.1136.gdb2ca164c4-goog

