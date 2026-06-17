Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6136F399CE2
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781736472; cv=none; b=rcNl3CU8WpiW2E0oyjPnALHx9mykcELDQUqgy/FpT7kystIBl+QUwY6zG0D/zPtJEuIsE4wME6WGL7qAjpjhtlSiXxKBhJaE7LjwXmbcTJIdDScHTkT+os8NGPI9eQZjDcZQ0YfoTFJYBGaUXM9uBxc5wv3emLrJpMT6aY3L34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781736472; c=relaxed/simple;
	bh=vLiNZqRyXQyJ7JmQ+K5SRwDiqvM3D2fcqR+SHxprbkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGGga3p+BhmYx2oPfSUR41rGhNdnAClhBhSel8S0re0rMXWrCR711A7MqfUMtY9g057H0ZBNXONpN80dUrxJwHdQ1dLt8GwUA3xahEih2xSfoCRdZCnWioCMvQ6zx003Y5bIOeFINRdP4IhE6eyAksW0HLWVH/nIInw8elC+hAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgGRtpFu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgGRtpFu"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c68190ade4so11063405ad.0
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 15:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781736471; x=1782341271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8xesxQpAxdv66UTyIr8XNFGyaWsfxsftrAiKh8HnZU=;
        b=jgGRtpFuC/bBrg3ZqmnHl8dUcK303KO5FJVvrxYVh3gEI1i6/FF+tPYoMa3ZNQlcNk
         W7PFY1j4/H5YxkeUM2FT3/06K8oRm9faTVRi6cyqLBYA3Pen1xhGLGg+vVOsC6oGD85t
         ctp+vKb1k+ldEuzCUlGfAdlfzXw5D9mQKKEFmD/Jp0nnlGcS9AMTPzRTC+7idLvIK0iV
         etL7VwsS+aI3C2rxkinf+dDtDvS4ir/K4/rwUDFxF0twBxgkLfeDpxcLn+NP2iUyhrQr
         EHAO7Ex9yol+/M5JlzU/Zt//rE9m5Uba+uNtvuJFkwiKOfsqGk0IlS1q3567gnmEJhxj
         I2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781736471; x=1782341271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8xesxQpAxdv66UTyIr8XNFGyaWsfxsftrAiKh8HnZU=;
        b=gk0rvT7d+c712BV/Auy3KA1d3Z+UkiehFbkMDJNRBeNj1l8v2nHVrzEUVLr9ML0e5X
         d/MwgRG2PgFZneOfa3Q1aLI5/S93n4WqBpva8SME9HMK11vuA7e7kA3Lw8zCse6F0yt8
         thCiKr6QwADFSmpPdfC/kXq9ED5tdzd3a1mBl86WGViWevQCYOFx2XwyHRG6En8aFuz8
         dCqnr00VqUYd6svxMXFjvg1m6hxTcCEJbNBbZuj5K68qqzaQXnifWqsTHOINU+PiuCpm
         MwWy6zyb4Mj/A/r0+NbTr6Ll5tnelURC6A6MIFCq4zoDU9c/LlyH6hOyKZZ1C7qh7HcB
         Y6qg==
X-Forwarded-Encrypted: i=1; AFNElJ+cvfcRScptBIRmQDdmVX0dy1SIAPO+meWXxZ3jnjKULDQrlCUsRCsrrcqsyXvVCuqUOBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtJRsV+o29V5t1z8FtlCQr/GEIAUmycuG7sScZ2nR3D9FurRR
	JtVh/oFJeMWZZDsQAifEE2WYtd1Upr9XIbradnoqRwGtUTAzVhvIrRuM
X-Gm-Gg: AfdE7clEgvm+Rh2yNCB9LVATqRBpzradhzWhrHRVIg++MhaQysU8f8hg2MyGiXCte44
	DFdR7H8+T3e6pwp+QFl9P4wtDAz55ndrwrKmeqhk/T6JL6GrMrhf+sxe77adtYwAyGp1vTOBVjX
	5LvheWRxAjN+UUD/F9O9qqDQWrhIYsnQ8NkvcR0+OtR0e5G6dpJAKES/GrW9VrRCo2VZ8alK7yt
	SUwvivqlDUP1StLM8Kl7bveTJp5zavJdxxGIRuWpSMe33sndZaCy3Clpuq24BCCZIhJeP0A2Xi3
	2yEjSFzBDKd4cT+qMP9slTt0I5DEd6X5FTPL/oOb//k5YmjD8uriQkps85UL45xqUTYndvL+TG7
	nBczKxiXqBz35wQB8zlxf8mx4K0awL1/C7sHWTXF8pyZC0nOKdYjFYbIZtCkngTubUgkF4/N9aI
	vkLx/2X1VY03FSapSp9V0k4WQMZOeCgxOrN2QtuHgqNfSxqaWl+bMDF20d/8ZL
X-Received: by 2002:a17:903:19ee:b0:2c6:c9e0:2c17 with SMTP id d9443c01a7336-2c6de3f353emr10279325ad.8.1781736470712;
        Wed, 17 Jun 2026 15:47:50 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c433844a70sm170772265ad.84.2026.06.17.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 15:47:50 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: ameryhung@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	eddyz87@gmail.com,
	edumazet@google.com,
	emil@etsalapatis.com,
	eyal.birger@gmail.com,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuba@kernel.org,
	leon.hwang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rongtao@cestc.cn,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	toke@redhat.com,
	yatsenko@meta.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v3 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
Date: Thu, 18 Jun 2026 04:17:27 +0530
Message-ID: <20260617224729.1428662-2-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
References: <20260617224729.1428662-1-avinash.duduskar@gmail.com>
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
result still reports the route mtu in params->mtu_result.

On the skb path without tot_len the deferred mtu check is done against
the resolved egress device. To keep that the VLAN device rather than
the parent after the swap, bpf_ipv4_fib_lookup()/bpf_ipv6_fib_lookup()
hand the FIB-result device back to the caller; the XDP path always
runs the route-mtu check and passes NULL. When the flag is not set,
behaviour is unchanged: h_vlan_proto and h_vlan_TCI are zeroed and
ifindex is left at the FIB result.

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
 include/uapi/linux/bpf.h       | 22 +++++++++++-
 net/core/filter.c              | 61 +++++++++++++++++++++++-----------
 tools/include/uapi/linux/bpf.h | 22 +++++++++++-
 3 files changed, 84 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 89b36de5fdbb..f1ac9266a2ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3532,6 +3532,21 @@ union bpf_attr {
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
+ *			parent's. Only the immediate parent is resolved (QinQ is
+ *			not supported), and the swap is skipped if the parent is
+ *			in a different namespace. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7342,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7393,7 +7409,11 @@ struct bpf_fib_lookup {
 
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
index 2e96b4b847ce..27e4792f11e9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6201,10 +6201,26 @@ static const struct bpf_func_proto bpf_skb_get_xfrm_state_proto = {
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
+	if ((flags & BPF_FIB_LOOKUP_VLAN) && is_vlan_dev(dev)) {
+		struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
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
 
@@ -6214,7 +6230,8 @@ static int bpf_fib_set_fwd_params(struct bpf_fib_lookup *params, u32 mtu)
 
 #if IS_ENABLED(CONFIG_INET)
 static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
-			       u32 flags, bool check_mtu)
+			       u32 flags, bool check_mtu,
+			       struct net_device **fwd_dev)
 {
 	struct neighbour *neigh = NULL;
 	struct fib_nh_common *nhc;
@@ -6347,13 +6364,16 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	if (fwd_dev)
+		*fwd_dev = dev;
+	return bpf_fib_set_fwd_params(dev, params, flags, mtu);
 }
 #endif
 
 #if IS_ENABLED(CONFIG_IPV6)
 static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
-			       u32 flags, bool check_mtu)
+			       u32 flags, bool check_mtu,
+			       struct net_device **fwd_dev)
 {
 	struct in6_addr *src = (struct in6_addr *) params->ipv6_src;
 	struct in6_addr *dst = (struct in6_addr *) params->ipv6_dst;
@@ -6486,13 +6506,16 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	memcpy(params->smac, dev->dev_addr, ETH_ALEN);
 
 set_fwd_params:
-	return bpf_fib_set_fwd_params(params, mtu);
+	if (fwd_dev)
+		*fwd_dev = dev;
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
@@ -6507,12 +6530,12 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
 		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
-					   flags, true);
+					   flags, true, NULL);
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
 		return bpf_ipv6_fib_lookup(dev_net(ctx->rxq->dev), params,
-					   flags, true);
+					   flags, true, NULL);
 #endif
 	}
 	return -EAFNOSUPPORT;
@@ -6532,6 +6555,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
 	struct net *net = dev_net(skb->dev);
+	struct net_device *fwd_dev = NULL;
 	int rc = -EAFNOSUPPORT;
 	bool check_mtu = false;
 
@@ -6547,29 +6571,28 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	switch (params->family) {
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
-		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu);
+		rc = bpf_ipv4_fib_lookup(net, params, flags, check_mtu,
+					 &fwd_dev);
 		break;
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		rc = bpf_ipv6_fib_lookup(net, params, flags, check_mtu);
+		rc = bpf_ipv6_fib_lookup(net, params, flags, check_mtu,
+					 &fwd_dev);
 		break;
 #endif
 	}
 
 	if (rc == BPF_FIB_LKUP_RET_SUCCESS && !check_mtu) {
-		struct net_device *dev;
-
-		/* When tot_len isn't provided by user, check skb
-		 * against MTU of FIB lookup resulting net_device
+		/*
+		 * Without tot_len, check the skb against the FIB result
+		 * device's MTU, which BPF_FIB_LOOKUP_VLAN keeps as the VLAN
+		 * device even though params->ifindex was swapped to the parent.
 		 */
-		dev = dev_get_by_index_rcu(net, params->ifindex);
-		if (unlikely(!dev))
-			return -ENODEV;
-		if (!is_skb_forwardable(dev, skb))
+		if (!is_skb_forwardable(fwd_dev, skb))
 			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
 
-		params->mtu_result = dev->mtu; /* union with tot_len */
+		params->mtu_result = fwd_dev->mtu; /* union with tot_len */
 	}
 
 	return rc;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 89b36de5fdbb..f1ac9266a2ab 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3532,6 +3532,21 @@ union bpf_attr {
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
+ *			parent's. Only the immediate parent is resolved (QinQ is
+ *			not supported), and the swap is skipped if the parent is
+ *			in a different namespace. The swap and the vlan fields
+ *			are written only on success; other output fields keep
+ *			the helper's existing behaviour, so a frag-needed result
+ *			still reports the route mtu in *params*->mtu_result.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7327,6 +7342,7 @@ enum {
 	BPF_FIB_LOOKUP_TBID    = (1U << 3),
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
+	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
 };
 
 enum {
@@ -7393,7 +7409,11 @@ struct bpf_fib_lookup {
 
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

