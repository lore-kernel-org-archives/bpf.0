Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BD339150A
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781390910; cv=none; b=tP2gSiEKR/l5oQHR55RfOqR4YoxwQ+Heph3MAxC3DpLFZ85ygW6RbVv/5qSAwAuXW9gNUSmI8KvHRqNAH381GkEZ8WrKnSgr+SniyCHPqgRd7i/gfSSBTOi85Rled7gu0WuZpOB3shciWEJKGaxxum8OYVnqixI9MRDdsomKefc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781390910; c=relaxed/simple;
	bh=NLx6TeB2vlOSsdxlhBofVWC0UOabBBbX+han/NT/Nf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AKHBIwA3gSMYEmtemrDIVFyf6t5MZMWpvKpn0KRco3GY2L0YYwAv2clUYomCTU/05lGr2nudcsUjOtJmB7a9KbquUcCkkHRkP6tSFa00t+1foaEzTM1Y3Iz3eQEEK9FRLS6z0UTRX+SHhfn7VkZE711j/VSRfh7UBd88i9sFjGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vj9jMosf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vj9jMosf"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423f424d5bso1566277b3a.3
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781390909; x=1781995709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJod3x/IL3GNwFVM7mQb0ayO5y8WezHfu26XlSHnWXE=;
        b=vj9jMosfGQlY64keT7MH8tmvQUx2GJErygNzWiSMM37XZ5pyneBlfAa9yzfm0w9U1J
         pBitWJ8jUFG+LWmT6chniO2NQaiEtpo0l35lAVAs9jzdkg7R3yrI73zL4w6/AgJ3NxUr
         imvTDG4xnmjYcFp4gwMBPrvW7CLQsmRTA8DPQlzQWpCVC7+3fI7udOKNU0yUEpLb/5YN
         2NdqWeSCa2QXPaOqfuOzc9jrAvXo8C9M5no0hgibtGpDF7Y5wugTBve1IlQwPxqhr9z/
         F4d/VZLh5FMeZZPA7ghFMioSldm3EgPlAMBUt4dgY0gtx0OEo7lltD2Ae0usaZYG9aTa
         zHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781390909; x=1781995709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJod3x/IL3GNwFVM7mQb0ayO5y8WezHfu26XlSHnWXE=;
        b=TA4JWz8CDzLMi4DZ//muIxXRVNnYpcYPNgZ8c0Qxs2rR6GHFoUBBkE7WfDCWMZZkU5
         QlXNtelabyUCMcztF1GjLMCyUUE9lST52eaUuaijEhTso9iKlDUg+JfiUWOrthamgpTH
         EwF78gsYSE5EcFevgt5QwzpLYSKt5S0vxWN3KdAG42SGvFyFYHwA2ow204bZBUAN6e6Q
         X6jgN6Uam7+yLFJSp1SaY5b/0MlZ5Pm3HydluG/T6oBNkalBRSCi7e7/7fYAVI+uf08t
         UCqUtFG4wzshyr/oSmTVgMJmDMATuBkmWxajVHSNoIF1Ak+4zI+BgEhxWlwyN4JEMS1g
         uvcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1e2MWDpUvGYHOA405rGY+7X7S44Bm1zOvaOmoYbMT0Q52cOPsVZiWo6R7TAbWcfdfNyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFjT5p3lhM+TKw1IA60KQ+WrjCBJgkrXOvFEhHnb41bF9IBrmn
	tvkoIunxatXnXaq/R9MGSKsEfjzIhU2niBHCHF3Tj/k/IttaX5SrRFlzWHkg75G96v1iE1SDZaY
	NfRGCrw==
X-Received: from pfbhj1.prod.google.com ([2002:a05:6a00:8701:b0:835:425b:d4d8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12df:b0:82f:2b0:2809
 with SMTP id d2e1a72fcca58-844e19383afmr5269851b3a.1.1781390908634; Sat, 13
 Jun 2026 15:48:28 -0700 (PDT)
Date: Sat, 13 Jun 2026 22:48:06 +0000
In-Reply-To: <20260613224823.2399535-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613224823.2399535-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613224823.2399535-3-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 2/4] bpf: Add bpf_skb_set_hwtstamp().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
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
              ^     | encap packet                  ^ recv payload
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
              | RX packet w/ RX hwtstamp
       +------------+
       |  hardware  |
       +------------+

This allows transparently proxying RX hardware timestamps to
the socket applications via SCM_TIMESTAMPING.

Note that bpf_skb_set_hwtstamp() calls skb_unclone() and
bpf_compute_data_pointers(), so it is marked as a packet-changing
kfunc.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2:
  * Remove __packed and use unnamed bit-field in struct
    bpf_hwtstamp (Alexei Starovoitov)
  * Use skb_unclone() instead of skb_heaeder_clone() (Sashiko)
---
 include/linux/skbuff.h |  5 +++++
 kernel/bpf/verifier.c  |  9 ++++++++-
 net/core/filter.c      | 25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..e0aa190565af 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4698,6 +4698,11 @@ static inline bool skb_defer_rx_timestamp(struct sk_buff *skb)
 
 #endif /* !CONFIG_NETWORK_PHY_TIMESTAMPING */
 
+struct bpf_hwtstamp {
+	ktime_t hwtstamp;
+	u64 :64;
+};
+
 /**
  * skb_complete_tx_timestamp() - deliver cloned skb with tx timestamps
  *
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eb46a81a8c51..e29edc101cb1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11045,6 +11045,7 @@ enum special_kfunc_type {
 	KF_bpf_session_is_return,
 	KF_bpf_stream_vprintk,
 	KF_bpf_stream_print_stack,
+	KF_bpf_skb_set_hwtstamp,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -11142,6 +11143,11 @@ BTF_ID_UNUSED
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
@@ -11224,7 +11230,8 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 
 bool bpf_is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data] ||
+	       meta->func_id == special_kfunc_list[KF_bpf_skb_set_hwtstamp];
 }
 
 static enum kfunc_ptr_arg_type
diff --git a/net/core/filter.c b/net/core/filter.c
index 823c62481dbf..bd8c9a7b7505 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12372,6 +12372,30 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 	return 0;
 }
 
+__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
+				     struct bpf_hwtstamp *attrs, int attrs__sz)
+{
+	int defined_sz = offsetofend(struct bpf_hwtstamp, hwtstamp);
+	struct sk_buff *skb = (struct sk_buff *)s;
+
+	if (attrs__sz != sizeof(*attrs) ||
+	    memchr_inv((char *)attrs + defined_sz, 0, sizeof(u64)))
+		return -EINVAL;
+
+	if (!skb_at_tc_ingress(skb))
+		return -EINVAL;
+
+	if (skb_unclone(skb, GFP_ATOMIC))
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
@@ -12500,6 +12524,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_sock_addr)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sched_cls)
 BTF_ID_FLAGS(func, bpf_sk_assign_tcp_reqsk)
+BTF_ID_FLAGS(func, bpf_skb_set_hwtstamp)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sched_cls)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
-- 
2.54.0.1136.gdb2ca164c4-goog

