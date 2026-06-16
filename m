Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6D3AB47B
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649299; cv=none; b=ntHB3MymAjaNSavhs+P6FfXY7SQwIkNgbJ2i57Rv8zxidaFP4gj5/EryzUae754qvfHJ9Os5pnK6joYQ8QtyxelJkrFk8AKIks8AqX74jzTonp8vLUUSi6j1NOvhKcuhODzwd6o6bag4TJH8378yoe/xTcTNX6O0eDHM6Ak4mMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649299; c=relaxed/simple;
	bh=7xyAmC8A/FetCZVCGs6N3DKsL4AXzTKThgU/dJfEWY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y/6YUUUhgxatTgmbcn0n72FdVp60q27FZhI3yoHYVsEwQAach1qN8hKPsChU3+WYxQ7pfK18sr5NtjXrY3XyLYVQAODbVjUVIW2lfdeRXGaxHjOL358rGrq05afin78S36z3KAJIG8EQXrge/4abP5nd9gl0Q4eh6HzjcxQjwYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOC8TASP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOC8TASP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so90442a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 15:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649297; x=1782254097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAH7Q/vAklBT0L04kWqOUQpmhl4v8vjdk/FvGvrzeyk=;
        b=FOC8TASPhRxBfOSnj2mFduSe81MHLysCLViAY2yaDOKfzsJ5v4wiBxiN++5ubB4QO+
         SNFMiArgNh1nkw/JJWOshDg27zTi9e+ULQ17XAcgyNKJKbFV1cfbLN74HNJwE81lR7VL
         p+kwVLIVnwO98QyxmiCFRpEPcm5GoZ1a+rOYbYbt99241mnFkT/TfRJDdZnN2FtowPA7
         0CIGKVzsixkSUmJ/0t726NHR4WdgemFHdjkGZcZln/SeJF0f3ORL10QyenHFOkUMvTNC
         s2jkTA64fuwWpTQlXjDUe8cskJqyppqeC5x9tUeDbbXoLIVoH9sf6r8VFVZywYcwiTI+
         cRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649297; x=1782254097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UAH7Q/vAklBT0L04kWqOUQpmhl4v8vjdk/FvGvrzeyk=;
        b=ccGSy+gyki+oYkJOYdAS0ntjHnr1ouBqyx6n1DidVKjF4PExgNva2dMUh/mP9NpONX
         8Um8sx/ZbP/ALYvtkoZ33Kjhf1j/46TTmbGpCOboEBKohagDMt0SUtR6s//KQyBfd7nR
         fdOQ/fxBkDmxek+0uVR2BQSutUy4T2EbsXuwVmnPdsPdzzaYK8IACzImcpcsYda6zhEu
         8a8cFWklp6kzkv9BRlG6l9G6tv5S1d+JtNsXAgpFElg7ahcOkKjNc1WTYkPB4vJoZ/DV
         lAUIvRVJu5/UwdshuCe+dL/BTW4ytuUit+E7R18ktFDGkd7Umj7ajosf9LCjHSfrHuMW
         /N/w==
X-Forwarded-Encrypted: i=1; AFNElJ/t1NXu2uYetYEZUrvp0zkwiEFkjpiUALnuMMU3n6f3tY94XAEHZjIL2BbWSW/RSvenDYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKqV6NtGSVFqlWhk2fp0r6fiG9Hk1mOBjZpWo/2Oi3bYnTsrb
	fGwdNwlksOWPqkzZXt/RMTxf5silMSx+QnF2BkwfjhF/3Iwqq0g46Ldi
X-Gm-Gg: AfdE7ck2Gp9erGH4RpwR325zRLURb6LWyf/HiL8J7OimRT0kv+kdPy7ciq9yPU8Yxt2
	uYwZOqt3ez7pxWRamX6286SwOregW/WCtvOB9W5k8UXwZBjf7SivWfZvtszK/7rS6HgkmfQYP0b
	f32cjUh/lnlU53o0eoWiS2OAe7Gw5p4w6qghNL/Nl1IKEgIplTTotRKsB9MKD592d6aIC/JYIZV
	KY5GzC3/hUYBs7jIfqAlqu2ChRvtwKVvTuQk+WaYjTK/kpZf4NivowOucb4dHIxSkalLWZUi2hn
	s1zUf7fph172F4+bRVgq03IT2dJvshorhMjmMfvBvuVFWL7Q2QUMtwR7jZ9IrPSN0ZKmZfXt66M
	0kje4DFZLhSr4pikq0ZrmBVSRhvG/eY3I/0lwx94V8bPx0tcKpvM+BNvibB9QvSe7QAaG+DvbQ7
	al8R9bmNpU1bFXk4c+Yf7ElK3JTCbJs/Ihn1bu9qtvlXF70/SgpX2L+JpOZqfisNxihzo9CMY=
X-Received: by 2002:a17:90b:4a8e:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-37c9345e910mr1380886a91.11.1781649296796;
        Tue, 16 Jun 2026 15:34:56 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm4216898a91.0.2026.06.16.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:34:56 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 2/4] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Wed, 17 Jun 2026 04:04:24 +0530
Message-ID: <20260616223426.3568080-3-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
References: <20260616223426.3568080-1-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
from the fib result. When the egress is a VLAN device, the returned
ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
programs that want to forward the frame (e.g. xdp-forward) must
instead target the underlying physical device and push the VLAN tag
themselves. Today the program has no way to learn either the
underlying ifindex or the VLAN tag without maintaining its own
VLAN-to-ifindex map in userspace and refreshing it on netlink
events.

Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
result is a VLAN device whose immediate parent is a real (non-VLAN)
device in the same network namespace, populate the existing output
fields params->h_vlan_proto and params->h_vlan_TCI from the VLAN
device and replace params->ifindex with the parent's ifindex.
params->h_vlan_TCI carries the VID only, with PCP and DEI bits zero; a
consumer wanting to set egress priority writes PCP itself.
params->smac is the VLAN device's own address, which can differ from
the parent's.

Only the immediate parent is resolved, via vlan_dev_priv(dev)->real_dev
and not vlan_dev_real_dev(), which walks to the bottom of a stack. For a
stacked VLAN (QinQ) the immediate parent is itself a VLAN device; since
one h_vlan_proto/h_vlan_TCI pair cannot describe two tags, ifindex is
left unchanged and the vlan fields remain zero in that case. The swap
is also skipped when the parent lives in another network namespace (a
VLAN device can be moved while its parent stays), since its ifindex
would be meaningless or match an unrelated device in the caller's
namespace. The swap and the vlan fields are written only on success;
other output fields keep their existing behaviour, so a frag-needed
result still reports the route mtu in params->mtu_result. When the
flag is not set, behaviour is unchanged: h_vlan_proto and h_vlan_TCI
are zeroed and ifindex is left at the FIB result.

The new block is compiled only under CONFIG_VLAN_8021Q since
vlan_dev_priv() is not defined otherwise; without that config
is_vlan_dev() is constant false and the flag is accepted but never
acts.

This lets an XDP redirect target the physical device and learn the
tag to push in a single lookup, which xdp-forward's optional VLAN
mode (xdp-project/xdp-tools#504) wants from the kernel side.

The helper's input semantics are unchanged; the reverse direction
(supplying a tag as lookup input) is added in the following patch.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 31 ++++++++++++++++++++++++++-
 net/core/filter.c              | 39 ++++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h | 31 ++++++++++++++++++++++++++-
 3 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..f77aa9472bf1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3527,6 +3527,31 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. This lets XDP programs that target
+ *			the underlying physical device (VLAN devices have no
+ *			XDP xmit) discover both the real egress ifindex and
+ *			the VLAN tag to push in one call. *params*->h_vlan_TCI
+ *			carries the VID only, with PCP and DEI bits zero; a
+ *			consumer wanting to set egress priority writes PCP
+ *			itself. *params*->smac is the VLAN device's own
+ *			address, which can differ from the parent's. Only the
+ *			immediate parent is resolved: for a stacked VLAN (QinQ)
+ *			the parent is itself a VLAN device, and since one tag
+ *			pair cannot describe two tags, *params*->ifindex is
+ *			left unchanged and the vlan fields remain zero. The
+ *			same applies when the parent is in another network
+ *			namespace, where its ifindex would be meaningless.
+ *			The swap and the vlan fields are written only on
+ *			success; other output fields keep the helper's
+ *			existing behaviour, so a frag-needed result still
+ *			reports the route mtu in *params*->mtu_result, and on
+ *			the tc path without tot_len the mtu check runs after
+ *			the swap, against the parent device.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7322,6 +7347,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/* output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
diff --git a/net/core/filter.c b/net/core/filter.c
index 6fa172cb1348..b37a12321fba 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6119,10 +6119,40 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #endif
 
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
-static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
+static int bpf_fib_set_fwd_params(struct net_device *dev,
+				  struct bpf_fib_lookup *params,
+				  u32 flags, u32 mtu)
 {
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
+
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	/* vlan_dev_priv() is only defined when 8021q is built in or as a
+	 * module; under !CONFIG_VLAN_8021Q is_vlan_dev() is constant false
+	 * so this would be dead, but it still has to compile.
+	 */
+	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+		/* Resolve the immediate parent only. For a stacked VLAN
+		 * (QinQ) the parent is itself a VLAN device, and a single
+		 * h_vlan_proto/h_vlan_TCI pair cannot describe both tags;
+		 * leave ifindex and the vlan fields untouched in that case
+		 * rather than report the lower device with only one tag.
+		 * The same applies when the parent lives in another netns
+		 * (a VLAN device can be moved while its parent stays):
+		 * its ifindex would be meaningless, or match an unrelated
+		 * device, in the caller's namespace.
+		 */
+		if (!is_vlan_dev(real_dev) &&
+		    net_eq(dev_net(real_dev), dev_net(dev))) {
+			params->h_vlan_proto = vlan_dev_vlan_proto(dev);
+			params->h_vlan_TCI = htons(vlan_dev_vlan_id(dev));
+			params->ifindex = real_dev->ifindex;
+		}
+	}
+#endif
+
 	if (mtu)
 		params->mtu_result = mtu; /* union with tot_len */
 
@@ -6266,7 +6296,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
@@ -6406,13 +6436,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
-			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
+			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
+			     BPF_FIB_LOOKUP_VLAN)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 11dd610fa5fa..f77aa9472bf1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3527,6 +3527,31 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. This lets XDP programs that target
+ *			the underlying physical device (VLAN devices have no
+ *			XDP xmit) discover both the real egress ifindex and
+ *			the VLAN tag to push in one call. *params*->h_vlan_TCI
+ *			carries the VID only, with PCP and DEI bits zero; a
+ *			consumer wanting to set egress priority writes PCP
+ *			itself. *params*->smac is the VLAN device's own
+ *			address, which can differ from the parent's. Only the
+ *			immediate parent is resolved: for a stacked VLAN (QinQ)
+ *			the parent is itself a VLAN device, and since one tag
+ *			pair cannot describe two tags, *params*->ifindex is
+ *			left unchanged and the vlan fields remain zero. The
+ *			same applies when the parent is in another network
+ *			namespace, where its ifindex would be meaningless.
+ *			The swap and the vlan fields are written only on
+ *			success; other output fields keep the helper's
+ *			existing behaviour, so a frag-needed result still
+ *			reports the route mtu in *params*->mtu_result, and on
+ *			the tc path without tot_len the mtu check runs after
+ *			the swap, against the parent device.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7322,6 +7347,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7388,7 +7414,10 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/* output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
-- 
2.54.0

