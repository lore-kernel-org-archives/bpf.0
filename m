Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516060;
	b=of6VDffeUCNuxrEcJDcAoZ56cmd3c9uYeugd4vIb/goOwYivklVn+m1Qm4FbT0JH2xog
	 eNGuXOI9+kZRUO6hreeq+w1w6GzLwqCSWhfWU7zzXl3fBgwM1vQWfDayQn5/CVzcamRzi
	 xGewk49+AL2CYnpj3FrwYsV0NmyjLcE5tuRTGUbG1/f3lSc/HJ3feO9EWquRh7f7zP1Zi
	 HBldJVzvUC3+Z80suNF3SSHIr18CVHCNf4CJwv0z1nHr2XAoCBOIr0SwnI1cX2jpK3x33
	 edzPULAWgSUkZ/j5lhoL1UvBNtSUQiH1HQRmteVeDQyMAYhfmH6OHinsMBJr5GidHyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zBfHPQm249Nk34H3ial9k2D14gkrSdWuZNXZZV0acP0=;
	b=sA33VTenQFjQGvk7LD1IxY8RkO7b8dzkro+kuSBblZBYc1KXPvFR33lt+M85SGVvdDvc
	 NphhRuHSUtpH+n5bBAHZK22GY747NlWVMGA6WwV5xPXS1/NEouWWMXG3qiBDhuQRagYdM
	 Aqpl8mXxBPs1Qi6OxIPS9woBrcPnwTl4xRQy2OOWxZhurZpS8cG5ioKK/Y8DkWE+dkJFj
	 myJvhrz++z158DGndbH3aJe64vr26fiGBkvCKt/SUy7rTNCIqerbHOxl1zEiA8MtUMoPQ
	 JEE0K0dL2wCGm83Kj/mRfJQLmwf1m/+jRVCgu91FXwKF4BogQJUG+1qjmp9TcOq73sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HTDbjPzs;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E81606A885
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67E81606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HTDbjPzs
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ea5600c9cso4609296d6.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516059; x=1795120859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBfHPQm249Nk34H3ial9k2D14gkrSdWuZNXZZV0acP0=;
        b=HTDbjPzsR0O+SejXj3jVWZJAnIZg6UHQQTswJ38B6V30qlUr+RYGJQgBm3MqeWMhv7
         tJX0LYXplPWUSPUC65HFJfqomMyVFEFD0gByY5TYfLdUyYvQ3QIBNMBJ2gWwQri80LDZ
         4v8iXYbeC0RRJ/WrRdbK/d8cc75t23J+3dr7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516059; x=1795120859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBfHPQm249Nk34H3ial9k2D14gkrSdWuZNXZZV0acP0=;
        b=Gr+KUXHpxrpHRtxMANhW432re/ayOL8mYpDkoBF1bxm70sowlvOi1WXxsB8CCLdU5U
         snKzbpSAbPa4h9X+1ifv6PibqAYwvSXEYaue9TVcSYMUj8w2eDpy8JcNato1Yw8NMluN
         Y1GuSVgGg5A4/x74CE1fLf6AQq3ILMmIZJO8M+lhvdUbrvrjIGCnWUS4AhI6E5z26ZxR
         kMYaLyONZ6AIBiv13ihddBy4G+9a4Bptr/rtyI+kSSf5ujJQMO/8GkI0BCif9MPRuQHh
         EcaLZ41Picf3gum9ibTM6R0ExoN5l5c4pHtZOKJJSNiwPwo019MQ0vls3RJSIxeenPFC
         0CCw==
X-Forwarded-Encrypted: i=1; AL+hErFh/xjHVgMuNY9Q54cSrai+lscVbh7pZxwRT0150rHNEODgH9iMwy+O+bFRBwVjKsVsO3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PRf21PheBNHq0IfQWCC69RKwHCp8h8xRIVQxrS+Oqo5FQXAD2
	xP8RNLbAMd8tCHfpz94yLsGpQtVGoefTCLW2meLCYwM/B4fPdPTmaA3lV6CXtr3Zkw==
X-Gm-Gg: AYBFou2Gjz1j8rCdkXiH2m4BRmFEZERD4UPf6pQghQ0ei+2zZu0bZGRsIRm3OOseKQx
	nXeRQJqRNeHhIYrPI9QrvFxkKJtm7X3ViZKP9VE8YYQnBZ6IutLYrv5y36N9Lej2DmHAq0oWmER
	9Tn3dEHQK3AK6BG5oU8KkHR3Q3I1WdtrzvsKOu/Lbnq8zYfm7lHRbL5GzEqJD/6H3KOSuVx/p6E
	nNTJW7Z2mAkDZEpYQG99VfxcHjt4QqfXvwvp6hWEOKxZ9Fdg/9yR7agL4yZY1ZOdn5FtafNpXuo
	irDix/8WFPWyZLp/uxoJZkY05XrOQWmK/+v2NANPClG5t/sPtm1/rsjjINSrZpBp9iI/t6XixLw
	RUsHBI5ntJt2Vo2NPG7sSbCWA81SUm1BSjQP/1AotIFz5n4kidxvHtR5Rf87z9gZ3Cb1SW6apAE
	Ez9uDBQ+E0FpPiGPlTW1WFvXtjS1DN/ITGyf51Rd317Exkg5jCD5NdSXSSqscVccqU7gPjI9zcJ
	jnOqpQQRk/LVbjMrwbQJKHb0cMjLbxLkCEYUTPbiIKKQpK5QTGVs+ekysNHgjA60nTVZ7d1/SAN
	UaMuNj24fjSvNUvSOsurpZG7VNSvusH2O0Jyw+ZSdAEij0tS/8VumXRqb7iAl34f9slw19CK4/I
	=
X-Received: by 2002:a05:6214:2f93:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91f2425d524mr7292946d6.28.1794516059296;
        Thu, 12 Nov 2026 12:40:59 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:40:58 -0800 (PST)
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
Subject: [PATCH net-next v2 1/4] net: xfrm: interface: restore dst_orig on every xfrm interface
Date: Thu, 12 Nov 2026 15:40:46 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
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
bpf_skb_set_xfrm_info() and redirects the packet to an xfrm interface is
the shortest way to hit the overwrite. A netdev egress fwd rule that steers
a packet routed with an xfrm encapsulation into an interface reaches the
same place once the dst release earlier in this series keeps the route:

    ip link add xf0 type xfrm if_id 42
    ip link set xf0 up
    ip neigh replace 10.20.0.1 lladdr 02:aa:00:00:00:ab \
            dev va nud permanent
    ip route add 10.20.0.1/32 dev va encap xfrm if_id 42
    nft add rule netdev t c fwd ip to 10.1.0.2 device xf0

Send one packet to 10.20.0.1. With CONFIG_DEBUG_NET=y and panic_on_warn=1
the kernel panics in xfrmi_xmit() with the metadata dst still installed
while the route is put back. The interface with the configured if_id drops
the packet as a link failure without consulting the outbound policy, and a
clone made after the metadata was attached consumes the route before the
original packet arrives.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/xfrm.h             |  2 --
 net/core/filter.c              |  8 --------
 net/xfrm/xfrm_interface_bpf.c  | 16 +++++-----------
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++++----------
 4 files changed, 17 insertions(+), 31 deletions(-)

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
index 9b8d5191c4ba..2d574ae52c4b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6353,14 +6353,6 @@ static const struct bpf_func_proto bpf_bind_proto = {
 
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
index 5ea15037ebd1..8e83c624b774 100644
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
 
@@ -86,7 +79,8 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	skb_dst_force(skb);
 	info->dst_orig = skb_dst(skb);
 
-	dst_hold((struct dst_entry *)md_dst);
+	/* The allocated dst owns one reference, handed to the skb here. */
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

