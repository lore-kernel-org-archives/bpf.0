Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF540BCC4
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959810; cv=none; b=R+BCik/ClMN4LF0fUzx4t1yeYp5xTBwExIxlsUEdqkN0WM5Vv9fNN6yXlHOG1gSF+fh0V4Zk7dkUGaJASa/d7kMtqKiUGPoD+S24qrmBZgX8SiorgQ0Saw79J/COXAX3GR6nzwrwTxApGp7uvB6pBRMk7xsCwQZL8U10ozteDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959810; c=relaxed/simple;
	bh=kgylyCBj8V43N/Q+DHAMnBEDU+VQ5MR58Le0KsH/U2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XIfFhKTTxf+mJn0fwzXWMVfCq/PvEetuOn/fE/l+6KcJc86EkGQQP83nRuC/tNet6p4HJpr+OCLNEY0OJch3gm5c59m1hmIRR6YAzkPBhHIu/KY5n7BcSJDTaO+H4+aExWmtAt5L/Tv41iJuc31EC1IOjjBWLrbWr4Yys4Gg5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7m6MmXy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7m6MmXy"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc97653887so38060575ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 09:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959808; x=1784564608; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iT8VQGgqT5E7uE3mxAuv/2QgHMtujSibopugv+C9VV4=;
        b=j7m6MmXyW1YISV3zMXHXP4Ucibsci6v3pJs2sEZ3xJoQ2SixeFNFuwLhQ95pX5Y3A1
         +OOXzZ2uQhCQFaDgSxmdmauhntofDxhuDBV9K4Cgo2BOYdLS9USWAQgHbvWf+kWZjEYQ
         qsYRqARcPZEi6K6r0pd8rq63ClcLk0Fgram3GJAam2MLUi3qoY8lVTFvnfKIy8s+Dq9K
         8IXmVtcOnhINC1GHOTQ0EHjUXOKeDn9WvS3DDy9A+d3oNoD3cw6XOq2g+vh/yEckI/gA
         3lzANeR2WWpFdlFouqZxImOwE5L/wivFnOM1BqXbr8cjfgTJ6nS9Y7NGBfHb3EKuKHFK
         UNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959808; x=1784564608;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iT8VQGgqT5E7uE3mxAuv/2QgHMtujSibopugv+C9VV4=;
        b=LQH6aIBTEsccXnoR8DmDt92nFo+SaPcnYvKhwBD27xnQYJcqiXp6bmm6GRAMjtAgQR
         /2By2CrO5KWtvSTr1r+MCFSyO1i8Z0smGK1fOH7YBy1Zdycx8mAj9BI42Ns40iv0v9xc
         D/atjDTca45Rd4+BTPHegheizTTZythvegcSRsqvXr3qO05PEdYlI+m6/wuzL61soRmw
         qGqo20BFeOLVr8BTRyvmuG3bjA5ZV6hodDY78VUYt3IFzmrEgkvH6tWNQLsQBR0bYz+m
         ghj0bjaCCHmNMeWrI0f+XOW3wp1Q+1caKoXPvoOw+yWCIdSJjygznZrMgI1NHjA5euNw
         MopA==
X-Forwarded-Encrypted: i=1; AHgh+RpQqRfgybZVoSEde+tXHOzYYpJVwZvF1+kiK/Ofhz1q+HcnXhDvAZ/ME1XZDQyiYZn5K/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLE9ZReqDRvutOgkArUGnr2yYhUSU88+WDewHtmPV6OchbGFt
	D3OFMkf+2alZZkxaXWn6acRJA2g6/55cR0b1SsFZ7Y/aW9S2lhqdKexd
X-Gm-Gg: AfdE7cnvMhO599+WTHBDxO+v6Jbg5hMUepHWBdMVa+H6Ezrog9AxJIFuDwRgQYCPsTv
	erX98VfaTyWrycI8NZxZzUTf/cwpPj9GzILViSZbZlITzEF5+ZjUNdfZGFV1iTxtO/LShlsajQa
	F/jOi5Tu1dtShCRn5K6EDv5Td7JtGiHQ4pDpYR7vl20JzvEIFDffwsDXb2SSsJS2aFw52AfGCYT
	pp1S9YMyw8YbbHgCF4Ke+cB/weA3VX3kW9Ta5a00rVBWQGqJy44vYz+ztTwVccwCfRviszMDGIF
	+2mZBPCjKNJYlhF5G/ASogU+Dr3DMacgdMB8jorlnEsUiTS+UPeAzA/d88w+hqj931bAx6kJvZP
	02JtOMySggisA42HUcuYFeIAMJhlI7bL/XUIyy82samsum55wwHOHXRZ0pC0aJosjAJWHTIb2so
	MA+VBQk97zr6zjWgnOxpSkFeLznPPwdG/x4Bp0wWunSNXp6cAdqz+F75+5GXw=
X-Received: by 2002:a05:6a21:110:b0:3c0:9c19:65a5 with SMTP id adf61e73a8af0-3c110a207a1mr10937024637.61.1783959807561;
        Mon, 13 Jul 2026 09:23:27 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([160.30.85.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm25769471c88.0.2026.07.13.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:23:26 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v7 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Mon, 13 Jul 2026 21:53:03 +0530
Message-ID: <20260713162305.1237211-2-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
References: <20260713162305.1237211-1-avinash.duduskar@gmail.com>
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
and not vlan_dev_real_dev(), which walks to the bottom of a stack. When
the immediate parent is not a real device in the same namespace, the
lookup returns BPF_FIB_LKUP_RET_VLAN_FAILURE and leaves params->ifindex
at the input. This covers a stacked VLAN (QinQ), where the immediate
parent is itself a VLAN device and one h_vlan_proto/h_vlan_TCI pair
cannot describe two tags, and a parent in another network namespace (a
VLAN device can be moved while its parent stays), whose ifindex would
be meaningless in the caller's namespace. A program that wants the
VLAN device's own ifindex re-issues the lookup, with a re-initialized
params, without BPF_FIB_LOOKUP_VLAN, so the unreducible case stays
distinct from a physical egress. That distinction matters for XDP: a
program cannot xmit on a VLAN device, so a success carrying the VLAN
ifindex would make it redirect to a device with no ndo_xdp_xmit and
drop the frame at xdp_do_flush(). The swap and the vlan fields are
written only on the reduce path; other output fields keep their
existing behaviour, so a frag-needed result still reports the route
mtu in params->mtu_result.

BPF_FIB_LOOKUP_VLAN is only useful to XDP, which cannot redirect to a
VLAN device. A tc program can redirect to the VLAN device directly, so
bpf_skb_fib_lookup() rejects the flag with -EINVAL; bpf_xdp_fib_lookup()
accepts it. When the flag is not set, behaviour is unchanged:
h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the FIB
result.

The new block is compiled only under CONFIG_VLAN_8021Q since
vlan_dev_priv() is not defined otherwise; without that config
is_vlan_dev() is constant false and the flag is accepted but never
acts. That is safe because no VLAN device can exist there, so every
egress is already physical.

This lets an XDP redirect target the physical device and learn the
tag to push in a single lookup, which xdp-forward's optional VLAN
mode (xdp-project/xdp-tools#504) wants from the kernel side.

The helper's input semantics are unchanged; the reverse direction
(supplying a tag as lookup input) is added in the following patch.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Acked-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
v6 -> v7:
- uapi doc: repeating the lookup after BPF_FIB_LKUP_RET_VLAN_FAILURE
  needs a re-initialized params, since output fields overwrite the
  inputs they share storage with; commit message aligned

 include/uapi/linux/bpf.h       | 33 ++++++++++++++++++++++++++++++++-
 net/core/filter.c              | 33 +++++++++++++++++++++++++++++----
 tools/include/uapi/linux/bpf.h | 33 ++++++++++++++++++++++++++++++++-
 3 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..4ce1491e4ea6 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3532,6 +3532,31 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. *params*->h_vlan_TCI carries the VID
+ *			only, with PCP and DEI bits zero; a consumer wanting to
+ *			set egress priority writes PCP itself. *params*->smac is
+ *			the VLAN device's own address, which can differ from the
+ *			parent's. Only the immediate parent is resolved; if it
+ *			is itself a VLAN device (QinQ) or in another namespace,
+ *			the egress cannot be reduced to a physical device plus
+ *			one tag and the lookup returns
+ *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
+ *			left at the input. To obtain the VLAN device's own
+ *			ifindex, repeat the lookup without
+ *			**BPF_FIB_LOOKUP_VLAN**, re-initializing *params*
+ *			first: output fields overwrite the inputs they share
+ *			storage with. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
+ *			This flag is only valid for XDP programs; tc programs
+ *			receive -EINVAL since they can redirect to the VLAN
+ *			device directly.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7352,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7340,6 +7366,7 @@ enum {
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
 	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
+	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
 };
 
 struct bpf_fib_lookup {
@@ -7393,7 +7420,11 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/*
+			 * output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
diff --git a/net/core/filter.c b/net/core/filter.c
index 2e96b4b847ce..b5a45485a54b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6201,10 +6201,29 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
 #endif
 
 #if IS_ENABLED(CONFIG_INET) || IS_ENABLED(CONFIG_IPV6)
-static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
+static int bpf_fib_set_fwd_params(struct net_device *dev,
+				  struct bpf_fib_lookup *params,
+				  u32 flags, u32 mtu, u32 in_ifindex)
 {
 	params->h_vlan_TCI = 0;
 	params->h_vlan_proto = 0;
+
+#if IS_ENABLED(CONFIG_VLAN_8021Q)
+	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+		if (!is_vlan_dev(real_dev) &&
+		    net_eq(dev_net(real_dev), dev_net(dev))) {
+			params->h_vlan_proto = vlan_dev_vlan_proto(dev);
+			params->h_vlan_TCI = htons(vlan_dev_vlan_id(dev));
+			params->ifindex = real_dev->ifindex;
+		} else {
+			params->ifindex = in_ifindex;
+			return BPF_FIB_LKUP_RET_VLAN_FAILURE;
+		}
+	}
+#endif
+
 	if (mtu)
 		params->mtu_result = mtu; /* union with tot_len */
 
@@ -6216,6 +6235,7 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 			       u32 flags, bool check_mtu)
 {
+	u32 in_ifindex = params->ifindex;
 	struct neighbour *neigh = NULL;
 	struct fib_nh_common *nhc;
 	struct in_device *in_dev;
@@ -6347,7 +6367,7 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
 }
 #endif
 
@@ -6357,6 +6377,7 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 {
 	struct in6_addr *src = (struct in6_addr *) params->ipv6_src;
 	struct in6_addr *dst = (struct in6_addr *) params->ipv6_dst;
+	u32 in_ifindex = params->ifindex;
 	struct fib6_result res = {};
 	struct neighbour *neigh;
 	struct net_device *dev;
@@ -6486,13 +6507,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu, in_ifindex);
 }
 #endif
 
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
-			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK)
+			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
+			     BPF_FIB_LOOKUP_VLAN)
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
@@ -6541,6 +6563,9 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (flags & ~BPF_FIB_LOOKUP_MASK)
 		return -EINVAL;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN)
+		return -EINVAL;
+
 	if (params->tot_len)
 		check_mtu = true;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 89b36de5fdbb..4ce1491e4ea6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3532,6 +3532,31 @@ union bpf_attr {
  *			Use the mark present in *params*->mark for the fib lookup.
  *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
  *			as it only has meaning for full lookups.
+ *		**BPF_FIB_LOOKUP_VLAN**
+ *			If the fib lookup resolves to a VLAN device whose
+ *			parent is a real (non-VLAN) device, set
+ *			*params*->h_vlan_proto and *params*->h_vlan_TCI from
+ *			the VLAN device and replace *params*->ifindex with the
+ *			parent's ifindex. *params*->h_vlan_TCI carries the VID
+ *			only, with PCP and DEI bits zero; a consumer wanting to
+ *			set egress priority writes PCP itself. *params*->smac is
+ *			the VLAN device's own address, which can differ from the
+ *			parent's. Only the immediate parent is resolved; if it
+ *			is itself a VLAN device (QinQ) or in another namespace,
+ *			the egress cannot be reduced to a physical device plus
+ *			one tag and the lookup returns
+ *			**BPF_FIB_LKUP_RET_VLAN_FAILURE** with *params*->ifindex
+ *			left at the input. To obtain the VLAN device's own
+ *			ifindex, repeat the lookup without
+ *			**BPF_FIB_LOOKUP_VLAN**, re-initializing *params*
+ *			first: output fields overwrite the inputs they share
+ *			storage with. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
+ *			This flag is only valid for XDP programs; tc programs
+ *			receive -EINVAL since they can redirect to the VLAN
+ *			device directly.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7352,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7340,6 +7366,7 @@ enum {
 	BPF_FIB_LKUP_RET_NO_NEIGH,     /* no neighbor entry for nh */
 	BPF_FIB_LKUP_RET_FRAG_NEEDED,  /* fragmentation required to fwd */
 	BPF_FIB_LKUP_RET_NO_SRC_ADDR,  /* failed to derive IP src addr */
+	BPF_FIB_LKUP_RET_VLAN_FAILURE, /* VLAN egress, parent unresolvable */
 };
 
 struct bpf_fib_lookup {
@@ -7393,7 +7420,11 @@ struct bpf_fib_lookup {
 
 	union {
 		struct {
-			/* output */
+			/*
+			 * output with BPF_FIB_LOOKUP_VLAN: set from the
+			 * resolved egress VLAN device (see the flag); zeroed
+			 * on other successful lookups.
+			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
 		};
-- 
2.54.0

