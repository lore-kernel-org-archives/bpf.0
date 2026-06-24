Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF282F531B
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782270363; cv=none; b=mygPyRs2/APGdrLKWkeuTWbqdD7EVWFDgRtnDG7A+ar+Hn4R8GR+moaTjGaageKJL6aiNC/opldqNews6+kAjThCvQamCACDUc79rzDKz8hPOX8Qec+ILRHq23euoI5SYpcuNz39obBhzpSrDMTthnZIzbzwobPfifXj+QkJA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782270363; c=relaxed/simple;
	bh=TjVPCx6BVY0JzHDD6qXkRdiB19ETycmEaeTFJ/wPv5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAIKXNLo8jVKDvESBTBOV7a8Gimx9OkFPUeDX98VEUj9UHfP2+JTT3IxXgjbA+FqC7l5NCnZKvPc+Zp4LbfEVZ5vcFziCHSwuNd2U5r/+pq7pmTXpoaxQY7MuV//BIaj67iwwUnzvUkV0DNDBdjRYekUUM+YQtt56LCtz9jGdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJkZz3wk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJkZz3wk"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf20f6be6bso3141195ad.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 20:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782270361; x=1782875161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLXP2Bo7LMERVfH5vttQtBbuvmboIZR9vfAdIu9vkNY=;
        b=VJkZz3wkMlEd9e5ixvBfbacilei11zlN/mf9e5cEX22cZb4LhTVWCwFoQ8BNCblmUR
         dnaUp4d48+mLez8gPIVhlbytXtViWm/V66XJR95336wtOS+umyJDlTJ27XOFhy3POagi
         y4focMu8dXUcyYiA2fqo/ju8A3PqBDNX6Mnay0/VNNZNOUReoYmKpKi3uHfv5tMpRU1E
         cVuXImwZ4SyOhPWx2q1KkwayB5adpuweG7kCN+zwAth9gGIwAVupXgLrH0kbkbYCxltT
         d+g3O+cL826Xa/vAO5cMuyr3M1Qa6TXmxZRBqSz4we/d6P5si+d1FWG7sGprtPVL3WCw
         THPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782270361; x=1782875161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aLXP2Bo7LMERVfH5vttQtBbuvmboIZR9vfAdIu9vkNY=;
        b=h6sKtJ42W8Hah9SrIPXtA9K8pie/uZ4Oz80tsVwmaUY8lyGMgq1+xUoP01Go/eb9XM
         AxOnLLNapoc+1EdahWEfG90J2Jim5oQrZHA/6jxJyiOJLz6myW+rUPnhR545jybUDlx/
         ywfPaHg55dlFe02hRsVlFVsVGePDNo/jdc+pD5Sos2rH40BrEpmu+MBzK/m1mVL3S1Y1
         HdxmAFb9NDRaQ/5Ctm8qQrbsjCskUzvglB4Z0ykJcHvMBCB0Eb4Sw7/ZQ+p0NtKLbjx+
         DRD5kQfA0Add1lR275qfYb3TN+Ywf2XLXCnNzEf/LzWN9papqH0/ZuOkTyXtFOS9BQap
         XuTg==
X-Forwarded-Encrypted: i=1; AHgh+RoxsimjvfSfKQmRMaTcpplxA+609At8KWFhWK9DM2sfbx+rDUTWMb5OQhrLBKuPTyj4x7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDg6HonexUuOD4UUCaR3ndj+TuCJxhUk2TkXOuxV96JqqmsY58
	OtpD+BdkLJfDZFKDmkdIzknpThevgJkC+1sECZi9Cdzf9sYwyvpKQrWs
X-Gm-Gg: AfdE7cm2+Q9UHntLiI04SR7nPN90JaIjWshCp6CCDnkq9VRw0uL8/TOr3jAk2rZ5G0R
	A5Owf8iP4wxWlWf8FxxxjbL/kRVQEMXqdksKF6Hqukatx65RaYOpgNJF98mgrxWbWQbc7kzFRcr
	iq5YvDHbh6KneBWMLV0C80KLruSMIMyZ9I7AwVY1A83YYp2exmPXdIZNy4IaeDPSyEGEC/8lav5
	RNu6OIHZzsudbfvLt+mihDSWIU9jPsU1C/eqe6+0KaJNXdDN3yv4k2fiZeA4T4oNgBhRWsa+rHe
	+gyImz/jRwtr+iooiTkGdGu4cmcHroIYpVSeTUnAOFpSwj1mFihnrUTnzazcFR80Cm+L3JBPcaN
	bFQ7OfKnQ/PTG+6mecpa/obj1xpOM/ofBhKmLT/oG+b54IXbwGRP2Ywk1fSQwMlRobDdR2oNzmq
	BYTOGWzAj6luCGTQvqC7Vvj8dTwVt13i7jaDtwwckjPqawA+EYl1a1zhvSAnsl
X-Received: by 2002:a17:902:e5ca:b0:2c2:75c4:4b0f with SMTP id d9443c01a7336-2c7e13bbc21mr16165635ad.2.1782270361332;
        Tue, 23 Jun 2026 20:06:01 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436d6c16sm122243995ad.23.2026.06.23.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 20:06:00 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
Date: Wed, 24 Jun 2026 08:35:29 +0530
Message-ID: <20260624030530.3342884-3-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
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

