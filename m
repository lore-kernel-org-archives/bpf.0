Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F43AB47B
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649308; cv=none; b=S6ChJ8YCuGs4InqlNMJVoBqk9LHdrZdINoBm2XT2GJJKMubPjVCsBXHQTjf1xnQlaBVxHSpdu3yC3fRLAhMndFjSRmF2nRyDQYzNWvK3JzVtCpNmUmfmvlfAZQbQgMCEQwbt3HQmHMWwF2aKqJ+QRwRRtUpf8wgNgvONuywMHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649308; c=relaxed/simple;
	bh=G34wNr+bTMvhLKwSBazy8nS5WuVvlPQ953aMVsFAcW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i589QNLG9I6CcCExDR+D4cUcTeYVK6gmF26u9KrdQP6QMACJH86msoW+sA+IOrnzFqSI8Nei5+2NFF0ibsg0kfVgM1Wiu9tAlEeisBIYMFWpxyjP/12ZepSEh+TAYQBgs19ZVBswjYJVUduU1mtN2b9mXQysPj/tkuXF7cq9ugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EllROLWL; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EllROLWL"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9d265355so2558208a91.2
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 15:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781649306; x=1782254106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8WS9eUnOdGE40MAYeCLh5lZchkqMoOPHPc3FlSt+34=;
        b=EllROLWLcXX2rXOJeNoY5gyX4cjm941Ve4jf9ROiwiVF9IFhR8vdkRaAnu3JkCrav6
         YUT6QMBm5+WRgiSsPsgWMWw7JGGEvHwB2UZZcYfCWE8+FKhTLUqPFVSrCLHca9d87Tez
         xOasLGGFKwfnrxyiaRcejKeW8B/VawrnI7j0WNn8r6i0AU6+hhiC9CeSs4CLLtgYLKCj
         e5QMaDzS0PBpqVoJ5E0iq79lRlJ9P8Uwolw4uLRNspyU5bh2i+84IYtRW8Fa5rklXSzl
         JZlYmZgGTizwLjcrSyr5MTfci5ZcS5eg/pBGJKWPDal9bpVThIMAw/TCDCv97j3pQtBB
         fnAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781649306; x=1782254106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K8WS9eUnOdGE40MAYeCLh5lZchkqMoOPHPc3FlSt+34=;
        b=fZicfN4+6Dj0VNm+x7tIW/LyAkDjt7/0g08Gz9MBZR9e00LUKXqJ85a7OiUtV9S851
         IVrKR12MSJOMYAz70OWe6LT9weoxF3RiorvoubDCUlJLRoNgPqR746K693S6Risey8mq
         nnyJXIZ/M+I5RTgJBdjxRRSoX+w3I/x1NOEiDTxV/QlJBofkiKc/EW4pkFFMT+CZympK
         +BmGjZVMr+VJ8hCTEwyQzscu60sFDAzla2UTMCD8hcP99wE3GHTMoGl2LZVJKj1Ys9cv
         agMbkojh96xGg+sWVGpuymXxCY6b+q2x/Bv+pAv2Qwee3EOfi0p3RrSy6Q0GlcrA0Oz4
         r0Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/EV12P08fephc3vI/NdHUVjHCGzq4NI2Z3R3w/dzr/GzQl2t6uErQj9j7mzNOVjMBcO+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeWfv40X/Y3VuCTfWq57a/5JXmMfxrwr0lbMzFyTRBAVxSU7z
	Ds4KObdo21rOJkz53yppti0uVr5+ois+wSgXA93gS2C6mI4TpTf/uvEm
X-Gm-Gg: AfdE7cnzdJO67oz19Eq8g1ZcsFnfrOlsvL54KZ8ncpGYaA0pukbB46oJJZWGIcvOUn3
	Vm7xEcdewG6CaUehlZUzhwk/DrslKwBzARzMptJvm1c6KDlJePagmNBxKU9Ki/7BkoBD/qLRyiQ
	j3LLtnec0/0Ez5tEdKpUr1d4iKchrClv7gN3pDrnEij0OaCBTDTTxjgHgUfbseDboB1tNMUbK0e
	pJhJsgWprnSLor+P7gxo9OP9Oeja6tCIbzcIJFSRHWqlmJI2kH8VSURDqOacyrrcGbZY5s+/I/v
	FJ2foD0r+scxUgGmGYfuyonKv9l+Xxi5QW/Mz4Qnq8vHKaJ3n8S280KfTnqltmHGsGPSftIYUBq
	+nyhAaVwReVzVVZ97HQqbLsl60Qx9MvW3h5J28que6a/pNa71/Sh20didNTgAPhfNU5OvWHuzDz
	wmTqMTpJRwuFHoYjMOum3T+LrI3p4V5K7lMi7t+xtNFCw5LtK7MeG0vtAoNv2zM6b+6wLKP88=
X-Received: by 2002:a17:90b:558c:b0:36d:81b3:61a1 with SMTP id 98e67ed59e1d1-37c930d223cmr1329823a91.7.1781649305832;
        Tue, 16 Jun 2026 15:35:05 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c52092ee3sm4216898a91.0.2026.06.16.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:35:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/4] bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
Date: Wed, 17 Jun 2026 04:04:25 +0530
Message-ID: <20260616223426.3568080-4-avinash.duduskar@gmail.com>
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
 include/uapi/linux/bpf.h       | 34 ++++++++++++++-
 net/core/filter.c              | 80 +++++++++++++++++++++++++++++++---
 tools/include/uapi/linux/bpf.h | 34 ++++++++++++++-
 3 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f77aa9472bf1..57e28da3336a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3552,6 +3552,35 @@ union bpf_attr {
  *			reports the route mtu in *params*->mtu_result, and on
  *			the tc path without tot_len the mtu check runs after
  *			the swap, against the parent device.
+ *		**BPF_FIB_LOOKUP_VLAN_INPUT**
+ *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
+ *			as an input VLAN tag (e.g. parsed from the packet) and
+ *			run the lookup as if ingress had happened on the VLAN
+ *			subinterface carrying that tag for *params*->ifindex,
+ *			rather than on *params*->ifindex itself. The VID is the
+ *			low 12 bits of *params*->h_vlan_TCI;
+ *			*params*->h_vlan_proto must be ETH_P_8021Q or
+ *			ETH_P_8021AD in network byte order (any other value
+ *			returns **-EINVAL**). The
+ *			subinterface is the one configured for that tag on
+ *			*params*->ifindex; if *params*->ifindex is itself a
+ *			VLAN device, its inner (QinQ) subinterface is matched.
+ *			For a bond or team, a tag on a port matches no
+ *			device and returns NOT_FWDED; pass the master's
+ *			ifindex.
+ *			If no matching subinterface exists, or it is not up,
+ *			or it was moved to another network namespace, the
+ *			lookup returns **BPF_FIB_LKUP_RET_NOT_FWDED**,
+ *			mirroring real ingress, which drops a frame whose tag
+ *			is unconfigured or whose VLAN device is down. A VID of
+ *			0 (a priority-tagged frame) is looked up literally like
+ *			any other VID; receive instead processes such frames
+ *			untagged on the device itself, so do not set this flag
+ *			for priority tags.
+ *			Cannot be combined with **BPF_FIB_LOOKUP_TBID** (both
+ *			use the same input fields) or **BPF_FIB_LOOKUP_OUTPUT**
+ *			(this flag is ingress-only); doing so returns
+ *			**-EINVAL**.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7348,6 +7377,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7416,7 +7446,9 @@ struct bpf_fib_lookup {
 		struct {
 			/* output with BPF_FIB_LOOKUP_VLAN: set from the
 			 * resolved egress VLAN device (see the flag); zeroed
-			 * on other successful lookups.
+			 * on other successful lookups. input with
+			 * BPF_FIB_LOOKUP_VLAN_INPUT: the VLAN tag to scope
+			 * the lookup by.
 			 */
 			__be16	h_vlan_proto;
 			__be16	h_vlan_TCI;
diff --git a/net/core/filter.c b/net/core/filter.c
index b37a12321fba..cfbdd842ce61 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6158,6 +6158,41 @@ static int bpf_fib_set_fwd_params(struct net_device *dev,
 
 	return 0;
 }
+
+/* With BPF_FIB_LOOKUP_VLAN_INPUT the caller passes the packet's VLAN tag in
+ * params->h_vlan_proto and params->h_vlan_TCI; the lookup is done as if
+ * ingress had happened on the matching VLAN subinterface of *dev. Resolve
+ * it and store it in *dev. params is not modified.
+ *
+ * A protocol other than 802.1Q/802.1AD is API misuse (it would otherwise
+ * reach the WARN in vlan_proto_idx()), so it is rejected with -EINVAL. An
+ * unmatched VID, a matching device that is down, or one that was moved
+ * to another netns (receive would deliver into that netns' stack, which
+ * a lookup here cannot represent) is a data outcome, reported as
+ * NOT_FWDED, the same way the DIRECT path reports a missing table. Under
+ * !CONFIG_VLAN_8021Q __vlan_find_dev_deep_rcu() returns NULL, so every
+ * call returns NOT_FWDED, which is correct since no subinterface can
+ * exist.
+ */
+static int bpf_fib_vlan_input_dev(struct net_device **dev,
+				  const struct bpf_fib_lookup *params)
+{
+	__be16 proto = params->h_vlan_proto;
+	struct net_device *vlan_dev;
+	u16 vid;
+
+	if (proto != htons(ETH_P_8021Q) && proto != htons(ETH_P_8021AD))
+		return -EINVAL;
+
+	vid = ntohs(params->h_vlan_TCI) & VLAN_VID_MASK;
+	vlan_dev = __vlan_find_dev_deep_rcu(*dev, proto, vid);
+	if (!vlan_dev || !(vlan_dev->flags & IFF_UP) ||
+	    !net_eq(dev_net(vlan_dev), dev_net(*dev)))
+		return BPF_FIB_LKUP_RET_NOT_FWDED;
+
+	*dev = vlan_dev;
+	return 0;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_INET)
@@ -6177,6 +6212,12 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (unlikely(!dev))
 		return -ENODEV;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		err = bpf_fib_vlan_input_dev(&dev, params);
+		if (err)
+			return err;
+	}
+
 	/* verify forwarding is enabled on this interface */
 	in_dev = __in_dev_get_rcu(dev);
 	if (unlikely(!in_dev || !IN_DEV_FORWARD(in_dev)))
@@ -6186,7 +6227,10 @@ static int bpf_ipv4_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl4.flowi4_iif = 1;
 		fl4.flowi4_oif = params->ifindex;
 	} else {
-		fl4.flowi4_iif = params->ifindex;
+		/* dev->ifindex, not params->ifindex: VLAN_INPUT may have
+		 * resolved dev to a subinterface above.
+		 */
+		fl4.flowi4_iif = dev->ifindex;
 		fl4.flowi4_oif = 0;
 	}
 	fl4.flowi4_dscp = inet_dsfield_to_dscp(params->tos);
@@ -6323,6 +6367,12 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 	if (unlikely(!dev))
 		return -ENODEV;
 
+	if (flags & BPF_FIB_LOOKUP_VLAN_INPUT) {
+		err = bpf_fib_vlan_input_dev(&dev, params);
+		if (err)
+			return err;
+	}
+
 	idev = __in6_dev_get_safely(dev);
 	if (unlikely(!idev || !READ_ONCE(idev->cnf.forwarding)))
 		return BPF_FIB_LKUP_RET_FWD_DISABLED;
@@ -6331,7 +6381,11 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
 		fl6.flowi6_iif = 1;
 		oif = fl6.flowi6_oif = params->ifindex;
 	} else {
-		oif = fl6.flowi6_iif = params->ifindex;
+		/* dev->ifindex, not params->ifindex: VLAN_INPUT may have
+		 * resolved dev to a subinterface above.
+		 */
+		oif = dev->ifindex;
+		fl6.flowi6_iif = oif;
 		fl6.flowi6_oif = 0;
 		strict = RT6_LOOKUP_F_HAS_SADDR;
 	}
@@ -6443,7 +6497,23 @@ static int bpf_ipv6_fib_lookup(struct net *net, struct bpf_fib_lookup *params,
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
+	/* VLAN_INPUT reads h_vlan_proto/h_vlan_TCI, which alias tbid, so it
+	 * cannot be combined with TBID. It is also ingress-only, so it
+	 * cannot be combined with the egress-perspective OUTPUT flag.
+	 */
+	if ((flags & BPF_FIB_LOOKUP_VLAN_INPUT) &&
+	    (flags & (BPF_FIB_LOOKUP_TBID | BPF_FIB_LOOKUP_OUTPUT)))
+		return false;
+
+	return true;
+}
 
 BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
@@ -6451,7 +6521,7 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	switch (params->family) {
@@ -6489,7 +6559,7 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	if (plen < sizeof(*params))
 		return -EINVAL;
 
-	if (flags & ~BPF_FIB_LOOKUP_MASK)
+	if (!bpf_fib_lookup_flags_ok(flags))
 		return -EINVAL;
 
 	if (params->tot_len)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f77aa9472bf1..57e28da3336a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3552,6 +3552,35 @@ union bpf_attr {
  *			reports the route mtu in *params*->mtu_result, and on
  *			the tc path without tot_len the mtu check runs after
  *			the swap, against the parent device.
+ *		**BPF_FIB_LOOKUP_VLAN_INPUT**
+ *			Treat *params*->h_vlan_proto and *params*->h_vlan_TCI
+ *			as an input VLAN tag (e.g. parsed from the packet) and
+ *			run the lookup as if ingress had happened on the VLAN
+ *			subinterface carrying that tag for *params*->ifindex,
+ *			rather than on *params*->ifindex itself. The VID is the
+ *			low 12 bits of *params*->h_vlan_TCI;
+ *			*params*->h_vlan_proto must be ETH_P_8021Q or
+ *			ETH_P_8021AD in network byte order (any other value
+ *			returns **-EINVAL**). The
+ *			subinterface is the one configured for that tag on
+ *			*params*->ifindex; if *params*->ifindex is itself a
+ *			VLAN device, its inner (QinQ) subinterface is matched.
+ *			For a bond or team, a tag on a port matches no
+ *			device and returns NOT_FWDED; pass the master's
+ *			ifindex.
+ *			If no matching subinterface exists, or it is not up,
+ *			or it was moved to another network namespace, the
+ *			lookup returns **BPF_FIB_LKUP_RET_NOT_FWDED**,
+ *			mirroring real ingress, which drops a frame whose tag
+ *			is unconfigured or whose VLAN device is down. A VID of
+ *			0 (a priority-tagged frame) is looked up literally like
+ *			any other VID; receive instead processes such frames
+ *			untagged on the device itself, so do not set this flag
+ *			for priority tags.
+ *			Cannot be combined with **BPF_FIB_LOOKUP_TBID** (both
+ *			use the same input fields) or **BPF_FIB_LOOKUP_OUTPUT**
+ *			(this flag is ingress-only); doing so returns
+ *			**-EINVAL**.
  *
  *		*ctx* is either **struct xdp_md** for XDP programs or
  *		**struct sk_buff** tc cls_act programs.
@@ -7348,6 +7377,7 @@ enum {
 	BPF_FIB_LOOKUP_SRC     = (1U << 4),
 	BPF_FIB_LOOKUP_MARK    = (1U << 5),
 	BPF_FIB_LOOKUP_VLAN    = (1U << 6),
+	BPF_FIB_LOOKUP_VLAN_INPUT = (1U << 7),
 };
 
 enum {
@@ -7416,7 +7446,9 @@ struct bpf_fib_lookup {
 		struct {
 			/* output with BPF_FIB_LOOKUP_VLAN: set from the
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

