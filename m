Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7EC39A058
	for <bpf@vger.kernel.org>; Sat,  4 Jul 2026 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783156951; cv=none; b=E4fu7TEY/EX5pe/KzMm6avYRQNv0/2hNn4kd/BEf3VYq5HeRxFBVHRRGyrgNnQINFwek1nAOEu38o/t4PWdrVD4wQYpJku0qW+M1/sV4nGmncZFzuPr2At5uNjNhwgWSwVttO/3N3kzuZSXwtaJK4SIPQLshZvtJkn+aMK0eAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783156951; c=relaxed/simple;
	bh=TjVPCx6BVY0JzHDD6qXkRdiB19ETycmEaeTFJ/wPv5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZPHltA52e1WEdrTo1N35hBjWgt+wZfMRVpjeqfy6LegzN6D/X60lcoLkQ5VTM3Jzjs1Nivlqwh8JDrA2jiFJS/GOblJNZ8zHZryMGWB/UsrdWBGwbUoPhwQ86RAKgXNPjRhrPM56kca3YHDwwsLTatTZ2X5+aXNHBVeiUrTZtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE7cXpGV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE7cXpGV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso1425862b3a.0
        for <bpf@vger.kernel.org>; Sat, 04 Jul 2026 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783156949; x=1783761749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLXP2Bo7LMERVfH5vttQtBbuvmboIZR9vfAdIu9vkNY=;
        b=dE7cXpGViATIcg4/2t/aXX8cSfJ7mlLjouEaBZ5I649PUwoghPOnLd7f8YGcXUydc0
         wXQMi/Xgf+1Le3W0zHHeuKfwUjTvThBHyhnW90E1zS3rEVRJ18bpntQmn98IO9EOVxOy
         T4Uma0wIgET6m/IKutElU4N0DnbEwTMlwp20y7NcxAiafANteQbU8ROI7DDPIYBtdCex
         LaxOKiACunFiVoaDepUql+syJcG1E0LztQ6VH44YElv0MPwRNRG6kBjwCXKfTYTbbD4y
         bZ5ybysy3beM+KEwME/oAT2HChclzgvy+0nI2zOKo0ijxlW0pp7TyXeAXOok/iBtJ/ie
         Y87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783156949; x=1783761749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLXP2Bo7LMERVfH5vttQtBbuvmboIZR9vfAdIu9vkNY=;
        b=M+tFa+/aCSTpzYIhvQ/p9Gx9DHK7pwegYI1z27YyVDR5lF4mEtJ/vZuMF0eF737oni
         CtP+2uyFAjtRuBSiet02OfyEzQ++ogwFOO+/6MAb0HVGWJG3F6pZq+rmUMNZu9Mk8jVl
         oXtFtemN5N+SEv79QgKd0vM3TQKHAJuvYE0bH0tnVLgZR/SO5nMPV9i6xduoI8fQN5eP
         5Zn1joXb6lXIC+Ic8nBDo9xh0eK3OCTHRH4BgH1tQVJJUJBjH/8W1drysXynJd6lIodt
         0qabVzBL8E8z4LKTufM0d2YfiAFw1g42IRbrS9r3LXtW9IyZpmmhxuRQapBP+dqKfBl9
         H8PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TXD8UkSpNdxfVkhYErIaAk+kZy1/MdRVNfdJZVRk9KHcZuQUlyZxC/XOeDC/H7Te0KhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxmviSL5zsVhDC8JdAzKAXm5hXRqsYMFQbl/Sfpkd75on7fWz
	jdPu1Q1zrVGuNGT8OaJg3XfgMFoB0mEK36Ek/v11JfTKz+orM1kZERyB
X-Gm-Gg: AfdE7clUe4XySBLj2D54xQ5IiFulqsWJ1K3D6UZgyZxUyJ84+d+ip87/npeiFOdRHsn
	E+wPikswdv1yTP2fGdQWyEXfKIOR1MUCwvNnP3ARKFhyS2Xc5G499Qk5MdkRpbJcJrVMFci444Q
	LshmxE1VjqbvX2BupF6bYgNaqa+VYZtB0HqJqYDWmUCdIWrzmI4WCNzwonBKqQV4i1FdSeerOuI
	VIsEiLy7scaGMdYjo2S/2eKJt4j64MGywyoWCAh77BP3ez+pWIcPjA6xgEZzh/cQqeudsI7bImR
	ANQZsRUKKS6QR94QnT1bNx4EOiL5ynbrag4Fn1gLGssxIf7oyiDMJZUAc1MXKwpLwcdoSdipYSz
	QUefktRx5P9dm8L8u+fkxi5EXB+sYawqaFfk0z9NfRcviaf/PGgNl0MhinsPWFF8mYVIoWncJK/
	fvNVBM9KbUTtfkO+TYZWG2feMoZZJqVBtyMTCiLcsR/MO44q9zt36JVFQJvA7v
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c08:fba4 with SMTP id adf61e73a8af0-3c03e589ab3mr2896960637.56.1783156949088;
        Sat, 04 Jul 2026 02:22:29 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc27ae7sm28006464eec.26.2026.07.04.02.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 02:22:28 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
Date: Sat,  4 Jul 2026 14:51:58 +0530
Message-ID: <20260704092159.1256823-3-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
References: <20260704092159.1256823-1-avinash.duduskar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BPF_FIB_LOOKUP_VLAN resolves a VLAN egress. The reverse is also
useful: an XDP program receiving a VLAN-tagged frame on a physical
device wants the lookup to behave as if the packet had arrived on the
corresponding VLAN subinterface, so iif-based policy routing and VRF
table selection use the right ingress.

Add BPF_FIB_LOOKUP_VLAN_INPUT. When set, params->h_vlan_proto and
params->h_vlan_TCI are read as an input VLAN tag and the matching VLAN
device of params->ifindex is resolved with __vlan_find_dev_deep_rcu().
The device must be up and in the same network namespace as
params->ifindex (a VLAN device can be moved to another netns while
registered on its parent; receive would deliver into that other
namespace, which a lookup here cannot represent). If params->ifindex
is itself a VLAN device, its inner (QinQ) subinterface is matched.
For a bond or team, a tag on a port matches no device and returns
NOT_FWDED; pass the master's ifindex.
The lookup then runs with the resolved device as the ingress;
params->ifindex itself is not modified on the input side. When the
resolved device is enslaved to a VRF, both the full lookup (via the
l3mdev rule) and BPF_FIB_LOOKUP_DIRECT (via l3mdev_fib_table_rcu())
select the VRF's table from the resolved ingress. That follows from
feeding the resolved device to the flow as the ingress
(fl4.flowi4_iif = dev->ifindex), which is what makes l3mdev resolve
the VRF master from the subinterface rather than from
params->ifindex.

The two failure classes get different treatment on purpose. A
h_vlan_proto other than 802.1Q/802.1ad is API misuse and returns
-EINVAL, since it would otherwise reach the WARN in vlan_proto_idx()
with a program-controlled value. An unmatched VID, a device that is
down, or one in another namespace is a data outcome and returns
BPF_FIB_LKUP_RET_NOT_FWDED, matching the DIRECT path when
fib_get_table() finds no table and mirroring real ingress, where the
receive path drops such frames. A VID of 0 (a priority tag) is looked
up literally and normally fails the same way; receive instead
processes such frames untagged, so callers should not set the flag for
priority tags. Proceeding on the physical device for any of these
would be fail-open for the policy-routing cases above.

The h_vlan fields share a union with tbid, so the flag cannot be
combined with BPF_FIB_LOOKUP_TBID. It describes ingress, so it also
cannot be combined with BPF_FIB_LOOKUP_OUTPUT. Both combinations
return -EINVAL; restricting now keeps a later relaxation backward
compatible. Combining with BPF_FIB_LOOKUP_VLAN is allowed: the tag is
consumed on the ingress side and the egress tag is written on
success.

Under !CONFIG_VLAN_8021Q the __vlan_find_dev_deep_rcu() stub returns
NULL, so every lookup with the flag returns NOT_FWDED, which is
correct since no VLAN device can exist.

Suggested-by: Toke Høiland-Jørgensen <toke@redhat.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 21 ++++++++++-
 net/core/filter.c              | 66 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 21 ++++++++++-
 3 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e00f0392e728..d4218954c50f 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3555,6 +3555,22 @@ union bpf_attr {
  *			This flag is only valid for XDP programs; tc programs
  *			receive -EINVAL since they can redirect to the VLAN
  *			device directly.
+ *		**BPF_FIB_LOOKUP_VLAN_INPUT**
+ *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
+ *			as an input VLAN tag and run the lookup as if ingress
+ *			had happened on the VLAN subinterface carrying that tag
+ *			on *params*->ifindex. The VID is the low 12 bits of
+ *			*params*->h_vlan_TCI; *params*->h_vlan_proto must be
+ *			ETH_P_8021Q or ETH_P_8021AD in network byte order, else
+ *			**-EINVAL**. If *params*->ifindex is itself a VLAN
+ *			device, its inner (QinQ) subinterface is matched; for a
+ *			bond or team, pass the master's ifindex. An unmatched
+ *			tag, a down device, or one in another namespace returns
+ *			**BPF_FIB_LKUP_RET_NOT_FWDED**, mirroring real ingress.
+ *			A VID of 0 is looked up literally, so do not set this
+ *			flag for priority-tagged frames. Cannot be combined with
+ *			**BPF_FIB_LOOKUP_TBID** or **BPF_FIB_LOOKUP_OUTPUT**
+ *			(returns **-EINVAL**).
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7351,6 +7367,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7421,7 +7438,9 @@ struct bpf_fib_lookup {
 			/*
 			 * output with BPF_FIB_LOOKUP_VLAN: set from the
 			 * resolved egress VLAN device (see the flag); zeroed
-			 * on other successful lookups.
+			 * on other successful lookups. input with
+			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
+			 * the lookup by.
 			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
diff --git a/net/core/filter.c b/net/core/filter.c
index b5a45485a54b..0ea362fa4287 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6229,6 +6229,25 @@ static int bpf_fib_set_fwd_params(struct net_device *dev,
 
 	return 0;
 }
+
+static struct net_device *bpf_fib_vlan_input_dev(struct net_device *dev,
+						 const struct bpf_fib_lookup *params)
+{
+	__be16 proto = params->h_vlan_proto;
+	struct net_device *vlan_dev;
+	u16 vid;
+
+	if (proto != htons(ETH_P_8021Q) && proto != htons(ETH_P_8021AD))
+		return ERR_PTR(-EINVAL);
+
+	vid = ntohs(params->h_vlan_TCI) & VLAN_VID_MASK;
+	vlan_dev = __vlan_find_dev_deep_rcu(dev, proto, vid);
+	if (!vlan_dev || !(vlan_dev->flags & IFF_UP) ||
+	    !net_eq(dev_net(vlan_dev), dev_net(dev)))
+		return NULL;
+
+	return vlan_dev;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_INET)
@@ -6249,6 +6268,14 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (unlikely(!dev))
 		return -ENODEV;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		dev = bpf_fib_vlan_input_dev(dev, params);
+		if (IS_ERR(dev))
+			return PTR_ERR(dev);
+		if (!dev)
+			return BPF_FIB_LKUP_RET_NOT_FWDED;
+	}
+
 	/* verify forwarding is enabled on this interface */
 	in_dev = __in_dev_get_rcu(dev);
 	if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
@@ -6258,7 +6285,11 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl4.flowi4_iif = 1;
 		fl4.flowi4_oif = params->ifindex;
 	} else {
-		fl4.flowi4_iif = params->ifindex;
+		/*
+		 * dev->ifindex, not params->ifindex: VLAN_INPUT may have
+		 * resolved dev to a subinterface above.
+		 */
+		fl4.flowi4_iif = dev->ifindex;
 		fl4.flowi4_oif = 0;
 	}
 	fl4.flowi4_dscp = inet_dsfield_to_dscp(params->tos);
@@ -6395,6 +6426,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (unlikely(!dev))
 		return -ENODEV;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		dev = bpf_fib_vlan_input_dev(dev, params);
+		if (IS_ERR(dev))
+			return PTR_ERR(dev);
+		if (!dev)
+			return BPF_FIB_LKUP_RET_NOT_FWDED;
+	}
+
 	idev = __in6_dev_get_safely(dev);
 	if (unlikely(!idev || !READ_ONCE(idev->cnf.forwarding)))
 		return BPF_FIB_LKUP_RET_FWD_DISABLED;
@@ -6403,7 +6442,12 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl6.flowi6_iif = 1;
 		oif = fl6.flowi6_oif = params->ifindex;
 	} else {
-		oif = fl6.flowi6_iif = params->ifindex;
+		/*
+		 * dev->ifindex, not params->ifindex: VLAN_INPUT may have
+		 * resolved dev to a subinterface above.
+		 */
+		oif = dev->ifindex;
+		fl6.flowi6_iif = oif;
 		fl6.flowi6_oif = 0;
 		strict = RT6_LOOKUP_F_HAS_SADDR;
 	}
@@ -6514,7 +6558,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 #define BPF_FIB_LOOKUP_MASK (BPF_FIB_LOOKUP_DIRECT | BPF_FIB_LOOKUP_OUTPUT | \
 			     BPF_FIB_LOOKUP_SKIP_NEIGH | BPF_FIB_LOOKUP_TBID | \
 			     BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_MARK | \
-			     BPF_FIB_LOOKUP_VLAN)
+			     BPF_FIB_LOOKUP_VLAN | BPF_FIB_LOOKUP_VLAN_INPUT)
+
+static bool bpf_fib_lookup_flags_ok(u32 flags)
+{
+	if (flags & ~BPF_FIB_LOOKUP_MASK)
+		return false;
+
+	if ((flags & BPF_FIB_LOOKUP_VLAN_INPUT) &&
+	    (flags & (BPF_FIB_LOOKUP_TBID | BPF_FIB_LOOKUP_OUTPUT)))
+		return false;
+
+	return true;
+}
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
@@ -6522,7 +6578,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	switch (params->family) {
@@ -6560,7 +6616,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	if (flags & BPF_FIB_LOOKUP_VLAN)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e00f0392e728..d4218954c50f 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3555,6 +3555,22 @@ union bpf_attr {
  *			This flag is only valid for XDP programs; tc programs
  *			receive -EINVAL since they can redirect to the VLAN
  *			device directly.
+ *		**BPF_FIB_LOOKUP_VLAN_INPUT**
+ *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
+ *			as an input VLAN tag and run the lookup as if ingress
+ *			had happened on the VLAN subinterface carrying that tag
+ *			on *params*->ifindex. The VID is the low 12 bits of
+ *			*params*->h_vlan_TCI; *params*->h_vlan_proto must be
+ *			ETH_P_8021Q or ETH_P_8021AD in network byte order, else
+ *			**-EINVAL**. If *params*->ifindex is itself a VLAN
+ *			device, its inner (QinQ) subinterface is matched; for a
+ *			bond or team, pass the master's ifindex. An unmatched
+ *			tag, a down device, or one in another namespace returns
+ *			**BPF_FIB_LKUP_RET_NOT_FWDED**, mirroring real ingress.
+ *			A VID of 0 is looked up literally, so do not set this
+ *			flag for priority-tagged frames. Cannot be combined with
+ *			**BPF_FIB_LOOKUP_TBID** or **BPF_FIB_LOOKUP_OUTPUT**
+ *			(returns **-EINVAL**).
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7351,6 +7367,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7421,7 +7438,9 @@ struct bpf_fib_lookup {
 			/*
 			 * output with BPF_FIB_LOOKUP_VLAN: set from the
 			 * resolved egress VLAN device (see the flag); zeroed
-			 * on other successful lookups.
+			 * on other successful lookups. input with
+			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
+			 * the lookup by.
 			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
-- 
2.54.0

