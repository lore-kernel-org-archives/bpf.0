Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB8363C6C
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 02:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183141; cv=none; b=p/QmEd2ZEUqRhRD7QCL/nxtCadmqEwI9CsH+R1LjwA6vP2xCvTR6ZCicAKRZur2X9ieTkh9QACMdbBOu558aSLQwqKGn4pBf2GOVRmxhP+c2C7LPXKMUkq7jLC7P3LTbI3B648Phy05exDUIU3JjQsNY1INihlLGgUpeGrFWPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183141; c=relaxed/simple;
	bh=f3glByHm07cnjQ+4bttPB+IrOQ+nmH6ASvuIW+jHlgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppM2f2Sq4GST0ZlrP2zTeva79uXecJKCh99HlatRQtpEsRrllQyBovItH7ACgKMTM/ZikR1KwNYBicutw1XBizCPx20z23qyqmxLw5orAmY+LsI3Mf2ydZQMZN7L4toxoKPjQbaxB6qMW/s/hNseTqEKRKVXuf73WSUw3+1KbwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXJYR9Pn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXJYR9Pn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso54729015ad.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 19:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183138; x=1782787938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sw5hFTdxntHea0NFQ2qVKZmLTnPbzDIESjvIhkmV/NE=;
        b=SXJYR9PnUdRRQQa1AHWsjK5foc5SwpokWsYbuIXx/eSPiYlUrZUmSlLf1soN+NwfJS
         ir5BDBdMxoIIdEjJiny9uD2kJA24BVA69f3N/XPwGOiwuqQTr487rLhNjrPNpaewpfON
         3vwYjCYtKoZltH5RWInerLQadFLNhHyGFh0rjeXMOzg9Nkj55yGMO1FZr/rWwIfqMuf3
         eyJUJxfKqabzAYIxpfAi/nlskVaHU3KRDLKWKjKxuP/Nr57hj7hRGpxLc6bHR/8prvoz
         bB5dVGZoN1SwM4uoA92rl3p0eZ+tNt0FgredKw69a4papLcqpo4XzZcVohYOw/ORYJr9
         N2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183138; x=1782787938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sw5hFTdxntHea0NFQ2qVKZmLTnPbzDIESjvIhkmV/NE=;
        b=OzUdhWRuSasWkWjao9OqLqXzLY9eFVVmoHsuCpUkBcKuNmp/pTl6nI2NYA+tcXQ+8q
         rzRdSn4hp0qUWLWqDUev0vNHhPfLKoK6d96j3gvNb1lf7aXsT4NQ/Trik5KdsaQ5Aj0h
         whsSsF5aeUpj2EIatKdERe/81GvalbHFJf1SCGtrwSCDzUqmEbVThzW+7UIx4LJ6hBp0
         sTbdh98ovM9zyWOhyqTsLfPajGi5VXRKF2nmQAwrM32hgXZKepbgZM+mic0hHzHq54R2
         Fk66j5WTaR8oal5XHqTKk1IIqidRyONih1tKIhO2dApL7B+JEzhOkF21t/PHMzSiSWCv
         YP4A==
X-Forwarded-Encrypted: i=1; AHgh+RrEIEDWWU5jI4OQWpvENIhWlDOuxrwQXKlbE+/Gs2O+qTN2BWPAcpgRrnC5fvu8w7Y1Sww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYZZHLcSLc+ntLenOZ9iPW4Yg/bwJOuAi1IzEWdiBWS0KOqdh
	4EMJ0VEn20ml+bFTJdkqAmW+3n0Np2XSQcjwj8iVH9V01k2tDxDQ7dgL
X-Gm-Gg: AfdE7ck+N47nVz1nP9oE490zfI5Qcp16GDmOPx/ZG0qsfQSNc4Sq1Aw4G/tzxvljiNt
	K+YvGGDVH9Y/lFGoujtc8qCx23C+nzYRWafjCxP7wKkUTVlNmxrIy33w9dL/c+NWHAH2kb1jcqN
	5dUTEWbAnZLi4VaNXx4W2mdkY+VYG6opOTnl4lsm9t6dQAmXzeuMBjm3IpBI8fW3kBjAJBl1if9
	CLWNOaiBs1vLL2c5WQYIBY4eEgJ1z6kQnhBLu4VxWiA6giEIKFU89dii81M0hrtNiB2Wl6ee6mr
	jS3V+qx07lCB9DJIHKQvBfTP8tMxz1Hfliumxrezcc8uSeSat7dxsUdDfCLIJtfbASJw1Fx0Gq9
	9EvqIS/bOMV8ppmyb80viobhJxUk76YGlje1O0Bazun7rE3FkEou2XaND9GsbIDDdyKmKZu2kTZ
	xCVXacPh2ynCZkDE5eo6FeCsxNFIH7eG/QBi7pYZ1OIxhTdnkD85hezatIZA25
X-Received: by 2002:a17:902:c94c:b0:2c0:dd75:e834 with SMTP id d9443c01a7336-2c7c758bd87mr12314455ad.5.1782183138133;
        Mon, 22 Jun 2026 19:52:18 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm102704625ad.39.2026.06.22.19.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:52:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/3] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
Date: Tue, 23 Jun 2026 08:21:46 +0530
Message-ID: <20260623025147.1001664-3-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
References: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
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
Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 include/uapi/linux/bpf.h       | 21 ++++++++++-
 net/core/filter.c              | 66 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 21 ++++++++++-
 3 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8d0058d88eb2..46a1443534bd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3552,6 +3552,22 @@ union bpf_attr {
  *			are written only on success; other output fields keep
  *			the helper's existing behaviour, so a frag-needed result
  *			still reports the route mtu in *params*->mtu_result.
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
@@ -7348,6 +7364,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7418,7 +7435,9 @@ struct bpf_fib_lookup {
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
index 8345295d84de..fc603cc36ce9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6228,6 +6228,25 @@ static int bpf_fib_set_fwd_params(struct net_device *dev,
 
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
@@ -6401,6 +6432,14 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
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
@@ -6409,7 +6448,12 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
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
@@ -6525,7 +6569,19 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
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
@@ -6533,7 +6589,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	switch (params->family) {
@@ -6572,7 +6628,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	if (params->tot_len)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8d0058d88eb2..46a1443534bd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3552,6 +3552,22 @@ union bpf_attr {
  *			are written only on success; other output fields keep
  *			the helper's existing behaviour, so a frag-needed result
  *			still reports the route mtu in *params*->mtu_result.
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
@@ -7348,6 +7364,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7418,7 +7435,9 @@ struct bpf_fib_lookup {
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

