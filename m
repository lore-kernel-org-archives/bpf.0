Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855711;
	b=E3jCz516D2/lAk59rRH5+t1lLvfuaXPCAoduPNVFdZH/997kb8/stzFJOARUqbuAjOl+
	 gTPIX5vwpuR5310CEzCUeZxjmzhJkOqs2sdLjsfdx0FylxK7H9S4EhM11lITPjQTk2qL/
	 cxK+Bh+gXYuJKoTQxsSsEbtjRCfFO2P4CtGbwzKdi6ne+UoZYQFaC/WUonEbJo5AdrWm4
	 hZ7YD69ieLLLz+1/FBtF0OcZ63PQ2610LwA3K5Clc7pZWjA0qN4JbxrG3HH1YIKzTJAfr
	 xnmAQRPywmpy4rj4OAmYj7WEHSGMBbawRevv3m85OSyDTYHvU5GoWreNiTqhar/4rCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0NNSEQiu8d3BGfuPK5/cURJLmmFBvQNMd85IM3WuinA=;
	b=5LTI7T0hWbyxMUatpf3NhvfnGv6cuV657U/beQSVe+2a9VxjZBh1ZA0Yt3s73nYdpNw1
	 4oUSZFQE50FbkdvTu2jlb3htyNNCTYSmez9uZ3kyzBipaf7BuPG6/S01XmK5EYKL5qwt7
	 OshlFzywEOFZnRtUK/PdOXNrHPHVtdzbOVvac7kCUWbyt5oMgnN1lC1BBwnXE+EFWLrBI
	 FG1trmQbhuO2TEER1wVkSAivWZQNPh7LVyIkI5z7sTYypHffr05LRraz4D1TQ1TCxheIQ
	 /WFBWX3WFAczmXoq5FL0Rm6SWUEtFI2qi8FN6tz743uLTXXx1nDf0E93SvXBV2dzBfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=giYiwlyL;
	arc=none smtp.remote-ip=209.85.222.47
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD5606A881
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 19:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3DD5606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=giYiwlyL
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-9906870a9baso2809319241.0
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794855709; x=1795460509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0NNSEQiu8d3BGfuPK5/cURJLmmFBvQNMd85IM3WuinA=;
        b=giYiwlyLN3tyOeMU668YlwGMuuimYIHzugsAt51s7G+bSobeChyFq+4hW27QNvJ2rQ
         XsbAurJyIzqfNozYD3hf4Pu2CkuAQTHffy1TBQhjk0g2ScUH478Rm8ijj7qU5woTHNlV
         cQobKJCHBmYCH7qkv51hWIX7BttzR+Ab7PZG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855709; x=1795460509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0NNSEQiu8d3BGfuPK5/cURJLmmFBvQNMd85IM3WuinA=;
        b=uIP//ropabgERf8FGNiViN8pT3AKVrGVt0IzyJpqN6SpK6jKul2r+HNeBVTLAJvKMg
         xFLl5VvNccyTGmUBFe6vKjNP+vhE/5CFlzz/Z9ap1T8RWqOwkpcR2e4Zva0ZbTaHhc3P
         OMAYT4HPiBuVllMxqflkNEWC2wFSjP5Ydge9fn4GlQdEiSHnErfA6OfsuFWgccbxMArY
         2yysf3qqRVOr4/U2seOJJECGi4tW2iTUXG/ynVpGmfmqrzoneg2rDOSbNZCjo0xPeCa+
         OmvGw7bpD7dNgJtTS1VqYyE9MJMtb6BDjNuAwawy+HC+2ZoumbIvKCwZK09AVnB5X+SA
         ZhYg==
X-Forwarded-Encrypted: i=1; AL+hErGyqICzhsJX7KcYxBxrp/By8HFR1k5CTw5px7TC097/RfFwpl6qQPn1Lc3A+UbXnZs+N1I=@vger.kernel.org
X-Gm-Message-State: APuU4Z+7igjQFnsDv3e9fa0MvRLF924xP7jKYybsmqLffBRTd0w8LyIH
	gmI4HGaFMi67PaADl/UGcl8wK+xNvv2++GC/bUc68JNgDhQPRPtORc94HqzUeieUUQ==
X-Gm-Gg: AYBFou1MHvuVjPtAwmEuWznej4f34hMqIHy5JBZxsQi8AnNLuhfv83Z9SU0oEzrPD7S
	RX6vjXVOY8+cZ6OAyYGa5jiYQ5h1wMp5V+qF7SRRB7fO5wMDhrh+A1gH1lC1YIr/jLRjljpJtcA
	AIrkFiqnrEWZF+9pLAVfBgjwFkuJNJ/BioglgXsukzYnwko0DM4/a5ghzJ1DL0g6EopJE1tXBnq
	a+WW1xgiCFRir0dE2IOEJU7IE2cGVf3pewlfsFuuARBGxQPDszhpzjiH7p5mHO3Y0lSIC0WxZY4
	tGw4khlcakTGC2kEB8E7RmYMtoCGtDOMDWYr80RYtxNtlp6QHSqkjVuKXsXyI5xyq5pVPksD7Xm
	IPXzQIkDZU6ieAWNQc5L0LTBA6K7FBO3tcVuC5//v7U3CMM+m/Q0M5NuHkRMxcVE0ruEwQQ8yku
	A0MuZ6CLA6F0kD89ZiX+iZ3My/SQt/mARmCOEXwB8b3ZB7uA38Yk3cXtMGRKirV3qntXA6KKRSD
	XxfUSia6B2qnBEfTRCpi0W5q35+WSVfmcTkdnHxt/mhs89H9HeDS3DJ5wxoRWdU2tlaCT8oIz9y
	nhaQZ0SU1dCQeorjH49KM2KqF9+UKv2NytiFN4WRGuEUkI8XO56QSiI/Diarn1OM6XzHV67KWSw
	=
X-Received: by 2002:a67:e111:0:b0:7d2:7654:86ac with SMTP id ada2fe7eead31-7d64d47658dmr3630335137.4.1794855709461;
        Mon, 16 Nov 2026 11:01:49 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d453casm91997386d6.10.2026.11.16.11.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:01:48 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	ipsec@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net-next v4 1/4] net: xfrm: interface: restore dst_orig on every xfrm interface
Date: Mon, 16 Nov 2026 14:01:38 -0500
Message-Id: <CORE-9NOG.v4.r0.20261116135311-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
References: <CORE-9NOG.v4.r0.20261116135311@mojatatu.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found while testing the dst release for the two producers that steer a
packet to another device, fixed later in this series. One of the consumers
of the metadata such a release installs is an xfrm interface, which
restores the original route before the xfrm lookup; the swap warned on the
metadata dst still installed in the skb, and only the collect_md arm
restored the route at all.

The issue:
An xfrm interface takes the if_id and the underlying device either from its
configuration or, in collect_md mode, from the xfrm metadata on the skb.
When that metadata also carries the route the packet arrived through,
xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup takes
the address family from it. skb_dst_set() expects the dst slot to be empty
for a reference counted dst and warns when it is not, so the route landed
over a metadata dst that was still there; a kernel built with
CONFIG_DEBUG_NET=y panics on the first packet that takes this path when
panic_on_warn is set.

Two more defects sit in the same place. An interface with a configured
if_id never restores the route: it takes the metadata dst as it is, whose
address family is AF_UNSPEC, so the lookup finds no policy and the packet
is dropped as a link failure instead of being transformed. And the restore
moved the route out of the metadata dst, which a clone of the skb shares,
so the clone that reached the interface first left the original packet with
nothing to restore.

The same slot overwrite is in the unstable helper a tc-bpf program uses to
attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_orig
and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
every invocation of the program, so the restore cannot keep anything in it.

The Fix:
Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
dst_clone() so the metadata dst keeps its own, and empty the counted slot
with skb_dst_drop() before the route is installed. The helper allocates a
metadata dst per skb instead of a per-cpu one, so the route it records
belongs to that skb and is released with it; the per-cpu allocation is no
longer used and goes away.

Conditions to recreate the bug:
A tc-bpf program that records the route as dst_orig with
bpf_skb_set_xfrm_info() is self-contained: the overwrite is in the helper,
so the first packet that calls it panics inside bpf_skb_set_xfrm_info() on
a CONFIG_DEBUG_NET=y build with panic_on_warn=1.

The netdev egress arm needs the rest of the series: it reaches the same
place once the dst release later in this series keeps the route, and the
interface takes if_id from the skb there, so it has to be the collect_md
shape:

    ip link add xf0 type xfrm external
    ip link set xf0 up
    ip neigh replace 10.20.0.1 lladdr 02:aa:00:00:00:ab \
            dev va nud permanent
    ip route add 10.20.0.1/32 dev va encap xfrm if_id 42
    nft add rule netdev t c fwd ip to 10.1.0.2 device xf0

Send one packet to 10.20.0.1. The kernel panics in xfrmi_xmit2() with the
metadata dst still installed while the route is put back.

An interface with a configured if_id shows its own defect without any
other patch: it drops the packet as a link failure without consulting the
outbound policy. And a clone made after the metadata was attached consumes
the route before the original packet arrives.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3 -> v4 (comment and commit-log change; no code change):
- Rewrite the conditions to recreate the bug around the two arms: the
  tc-bpf arm is self-contained, the netdev arm needs the rest of the
  series and a collect_md interface at the end of it.
- Expand the comment on the slot swap so it says what owns the reference
  that is cleared there, which metadata_dst_free() releases later. The
  comment sits inside the diff; no executable line changed. Considered
  comments from Sashiko (nipa).

 include/net/xfrm.h             |  2 --
 net/core/filter.c              |  8 --------
 net/xfrm/xfrm_interface_bpf.c  | 19 ++++++++-----------
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++++----------
 4 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 445223a8dc6f..1866e5a3b911 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2370,8 +2370,6 @@ static inline bool xfrm6_local_dontfrag(const struct sock *sk)
 #if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
     (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
 
-extern struct metadata_dst __percpu *xfrm_bpf_md_dst;
-
 int register_xfrm_interface_bpf(void);
 
 #else
diff --git a/net/core/filter.c b/net/core/filter.c
index f42ecfb5841f..bd98d29ed7f8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6354,14 +6354,6 @@ static const struct bpf_func_proto bpf_bind_proto = {
 
 #ifdef CONFIG_XFRM
 
-#if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
-    (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
-
-struct metadata_dst __percpu *xfrm_bpf_md_dst;
-EXPORT_SYMBOL_GPL(xfrm_bpf_md_dst);
-
-#endif
-
 BPF_CALL_5(bpf_skb_get_xfrm_state, struct sk_buff *, skb, u32, index,
 	   struct bpf_xfrm_state *, to, u32, size, u64, flags)
 {
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 5ea15037ebd1..7afbdbd11145 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -68,16 +68,9 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	if (unlikely(skb_metadata_dst(skb)))
 		return -EINVAL;
 
-	if (!xfrm_bpf_md_dst) {
-		struct metadata_dst __percpu *tmp;
-
-		tmp = metadata_dst_alloc_percpu(0, METADATA_XFRM, GFP_ATOMIC);
-		if (!tmp)
-			return -ENOMEM;
-		if (cmpxchg(&xfrm_bpf_md_dst, NULL, tmp))
-			metadata_dst_free_percpu(tmp);
-	}
-	md_dst = this_cpu_ptr(xfrm_bpf_md_dst);
+	md_dst = metadata_dst_alloc(0, METADATA_XFRM, GFP_ATOMIC);
+	if (unlikely(!md_dst))
+		return -ENOMEM;
 
 	info = &md_dst->u.xfrm_info;
 
@@ -86,7 +79,11 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	skb_dst_force(skb);
 	info->dst_orig = skb_dst(skb);
 
-	dst_hold((struct dst_entry *)md_dst);
+	/* The metadata dst releases dst_orig when it is freed, so the
+	 * reference the skb held is stolen rather than dropped. The dst
+	 * allocated above is handed to the skb with its single reference.
+	 */
+	skb_dstref_steal(skb);
 	skb_dst_set(skb, (struct dst_entry *)md_dst);
 	return 0;
 }
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 9835fbe63ccb..896180f8d171 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -423,6 +423,7 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
+	struct xfrm_md_info *md_info = skb_xfrm_md_info(skb);
 	struct xfrm_if *xi = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
@@ -433,25 +434,26 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	int mtu;
 
 	if (xi->p.collect_md) {
-		struct xfrm_md_info *md_info = skb_xfrm_md_info(skb);
-
 		if (unlikely(!md_info))
 			return -EINVAL;
 
 		if_id = md_info->if_id;
 		fl->flowi_oif = md_info->link;
-		if (md_info->dst_orig) {
-			struct dst_entry *tmp_dst = dst;
-
-			dst = md_info->dst_orig;
-			skb_dst_set(skb, dst);
-			md_info->dst_orig = NULL;
-			dst_release(tmp_dst);
-		}
 	} else {
 		if_id = xi->p.if_id;
 	}
 
+	/* The metadata dst carries the route the packet is still to be
+	 * transformed for, and the lookup below takes the address family from
+	 * the dst it is given. Put that route back, taking our own reference:
+	 * the metadata dst keeps its own, as a clone of this skb shares it.
+	 */
+	if (md_info && md_info->dst_orig) {
+		dst = dst_clone(md_info->dst_orig);
+		skb_dst_drop(skb);
+		skb_dst_set(skb, dst);
+	}
+
 	dst_hold(dst);
 	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, if_id);
 	if (IS_ERR(dst)) {
-- 
2.43.0

