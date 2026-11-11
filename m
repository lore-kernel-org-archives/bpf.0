Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367318;
	b=PVJH/2x6iySJ4UqMBrFqFvGJA+795sc9PMIoBHlk3b9gaQfa0q8drue0u/378XudARGR
	 7BD0c1o7YnTfKnHrUH+SVRSvhgeW3OwlMG/fxh7zhc5wIcSVmxl/AnU9hPtSbdthKn7Zj
	 V4dKQfabpRn5egfLoN0ACa8Af+Wmm0ByiaNayWzcrZanva1Qv9aUMjej/NKRCVwcUTlYg
	 tNl2vhjxZdH2n+0Xl7uMGzwbMc9XeXC3z8qup7yMLhjG6URxbzt9fUz+mEGZRPG7fjgRb
	 aqQBjT5O3XWXj7rfKnTNUyjytOFStPAyIXSdV4dJcU8YtwQwb0K5KHRVqmOK3Lb46EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Cbkg7m/iOR1aNdjTqRiCC3H1ik4TfAgb+sSh2QTc/OE=;
	b=EyMkd/6Lz+Dvvrt1Dn3L0CVALvA97n8jmnux80y8tK+jQcPCuFNgNFZDcjx4Xigq2uG8
	 tltwgfe1/fqY0fmE1qVa1etGEOyyoc8qnxLhUnH7gayt2y51sFV6xCep7yOWuxORNCeeK
	 oAEGjUP1bvEFthUcmF7xp8BORfW3SHJwosJj5o2uVM5P/53RCl0ZmFEP6poBwE2s6HnbP
	 28Ex2ImOPvnwobI2yN6O5j5NWscwf3kBkohOCHuKEF6OimiyJZkOXAo1QjemQY8o1XFhD
	 T2J9LJMGxC895OP8e1WrYDsvARd7lrtp+p3KDAY7fnInqjIunW0zNHxWyOkFMFfwjbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHEwGgRI;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389F860A2618
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 389F860A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JHEwGgRI
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36a315ed211so3063239eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 19:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367317; x=1794972117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cbkg7m/iOR1aNdjTqRiCC3H1ik4TfAgb+sSh2QTc/OE=;
        b=JHEwGgRIAr5i60SI2IrifCNsnwa9zoilr4PVo1vCD2gAhza9h1WnlYqnT5epPzpdVR
         FwiUaNl5lvfdrJ50aIhyBmahLr4XnhILy7J34zfXni/x3WISyy9TVz5pbgUram/+00TV
         ox/fmtbGEGNRUr3nwzgyYsIrckJBxQwXEwMVnou0K/VVY/dWIq+LeivIakaDLOkpNWeL
         S/4AHcsSfEGuVMajrFyz5IlRPWQJYX9gO4ET9sJePCl/d4Ow3hX98MDShb/i0ZL2WNkT
         1UoEWcVPPaPDYi1YU7B8cro796+4KorOVyRYNUBhswuRk6sRl4azptF4od9hcDp7vEbg
         ZyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367317; x=1794972117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cbkg7m/iOR1aNdjTqRiCC3H1ik4TfAgb+sSh2QTc/OE=;
        b=YumDjIN4HTn2tIlO+MOgJJxYLgDeL5ruiS5CpPIKJa3tpxgLkZQpr2dQXeP2GCY/Uk
         wkC6b61EQbO9UGq2e4fQ8NzEi9X/aFF7hwgSAxW9RbXqBFuV4qGtTUvatRIj09wfHBNG
         /NaPJOjFrRfTOzyu94sboMsl8bcASp/gIoA0lm0VW51vh69WOFfIJMboEF7do3ENxFSo
         CCGRjvgoA7PAGQzduCYG+82Vldb+/ReZ+1Qgxl2TquiIiAPJD5FtaxjjwF8yNhrFO0tA
         wMJ/z0lP+c7tiSFxxnNv98/RmNVaGK3GeIOZ9gXE/FYkfB7sjQy3f1wlUbQtZVgoMn4C
         mHeg==
X-Gm-Message-State: APuU4Z+CVHwcqcs0gws10YtANU1IrKWPzWfyEYZRlqpvmDVrt8gzkod0
	Wl6Zz42bZR1PHFnxkJ+QEE5gFOk3hzRbtNFvjs4CykG9S7citLGBR7SDlq3eUA==
X-Gm-Gg: AYBFou0UKuyMC4ucGMw1QxdoBZ0n0zJMwkfiAFqWDOKWJU85SVQRGNs274tci70irvG
	9aDEhgqtq7v7mMDQpAI4Yc79981LTxd8VTleO3jhzwJ4ME8ZAO927yUruJij+dhNX3xozz6KUI2
	ceO4ZdxsbEJ+gvaWVBGMWtTJcddC5cDBigcO08RZSLTdmKycTjtOCBG0VEjiyl/0VCgIHh7yc13
	1JhPuD3m2ioDJpzYGXByYAxKDnwSMpXM11iuawnTkgPWvhFE3YsuIPB3uPpdXPRJVucPROjc1Vd
	ay0dYWLWL0TDuaivfiFOP8h+dvv1xm3yDkqEym5OtIttozU0/66dxT3rp4kxfuf4pSQ85croxGk
	sBupjMuBIsgZJUvl3+5aPoihLmZ24QjyXFW/2YI1w6kTLixM81KOW8epfgOPhwBcfxzFveivS8r
	QTgE+qjmR7Z5EwyrYpqLkJzHPmb/YIJwQM2AWjm+zAQVE2Mvs2ImijV3OCnZ6u3glEDbwFGeO6N
	GhHWT241pm3AF8JWQf3tMydzluHhU2VkhwpZD7lqB/p4nbReTyUeX4EDlm3mX4grSYTSSAsXFiG
	lP3YGftPKDRbD0q++ZNt9hkCIOYl4V8+4NekfVT+0+DslgJBfY/pMvbuP9loU8I=
X-Received: by 2002:a05:693c:830b:b0:358:c5c9:2661 with SMTP id 5a478bee46e88-37686755b1amr1362827eec.10.1794367317128;
        Tue, 10 Nov 2026 19:21:57 -0800 (PST)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ad6f11csm9801896eec.0.2026.11.10.19.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:21:56 -0800 (PST)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: [RFC bpf-next v3 2/3] bpf: Add PPPoE encap/decap kfuncs
Date: Tue, 10 Nov 2026 22:21:40 -0500
Message-ID: <20261111032141.525444-3-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111032141.525444-1-thisseanzhang@gmail.com>
References: <20261111032141.525444-1-thisseanzhang@gmail.com>
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

Add bpf_skb_pppoe_encap() and bpf_skb_pppoe_decap() kfuncs so that a
TC BPF program can encapsulate an IPv4 or IPv6 packet into a PPPoE
session frame, and decapsulate one again:

	bpf_skb_pppoe_encap(skb, sid, flags);
	bpf_skb_pppoe_decap(skb, flags);

The kfuncs insert or remove the 8 byte PPPoE session header between
the MAC header and the network header, and update the skb metadata to
match: skb->protocol is set to ETH_P_PPP_SES on encapsulation, or
restored from the PPP protocol field on decapsulation, mac_len is
reset, and the GSO metadata is adjusted like bpf_skb_adjust_room()
does (gso_size, gso_segs, SKB_GSO_DODGY).

Both kfuncs accept BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size
unchanged and only recompute gso_segs, reusing the existing flag
instead of adding a new one; UDP GSO packets require it, as their
gso_size is the datagram size. Unknown flags are rejected.

Previously, a TC program could add or remove the header bytes
manually, but the skb would keep a stale skb->protocol: forwarded GSO
packets larger than the PPPoE MTU could not reach the PPPoE
segmentation path registered for ETH_P_PPP_SES and could be dropped.
bpf_skb_adjust_room() cannot be used for the decapsulation direction
either, because it only accepts ETH_P_IP or ETH_P_IPV6 in
skb->protocol.

The encap kfunc fills in the PPPoE header itself from the session id:
version 1, type 1, code 0, and the PPP protocol derived from
skb->protocol, mirroring what pppoe_xmit() writes. The ethertype of
the MAC header remains for the BPF program, like with the existing
BPF_F_ADJ_ROOM_ENCAP_* flags. skb->encapsulation is deliberately left
unset, like pppoe_xmit() does: PPPoE is not an IP tunnel, and setting
it would narrow the device features to hw_enc_features in
netif_skb_features(). The decap kfunc accepts only PPP_IP and PPP_IPV6
payloads and requires a full inner L3 header to remain.

The kfuncs are registered for SCHED_CLS and SCHED_ACT with the new
KF_CHANGES_PKT flag, so the verifier invalidates packet pointers after
a call, like it does for bpf_skb_adjust_room().

PPPoE GRO/GSO support must be built in or loaded before this path is
used; loading pppoe.ko is left to user space.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 net/core/filter.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9..3d9143552 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -47,6 +47,8 @@
 #include <linux/ratelimit.h>
 #include <linux/seccomp.h>
 #include <linux/if_vlan.h>
+#include <linux/if_pppox.h>
+#include <linux/ppp_defs.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <net/sch_generic.h>
@@ -12919,6 +12921,184 @@ __bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
 	return 0;
 }
 
+/**
+ * bpf_skb_pppoe_encap() - Encapsulate an IPv4 or IPv6 packet in a
+ * PPPoE session header.
+ *
+ * Insert an 8 byte PPPoE session header, made of the 6 byte session
+ * header plus the 2 byte PPP protocol field, between the MAC header
+ * and the network header, and fill it in for the given session id.
+ * skb->protocol is set to ETH_P_PPP_SES so the skb reaches the PPPoE
+ * GRO/GSO support; the ethertype of the MAC header is left to the BPF
+ * program.
+ *
+ * A packet whose VLAN tag is still present in the packet data is
+ * rejected, as skb->protocol is then the VLAN ethertype.
+ *
+ * On GSO skbs, gso_size is reduced by the size of the inserted header
+ * and gso_segs is recomputed, like bpf_skb_adjust_room() does. With
+ * BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is left unchanged and only
+ * gso_segs is recomputed; UDP GSO packets require this, as their
+ * gso_size is the datagram size.
+ *
+ * A call to this kfunc changes packet data. Therefore, at load time,
+ * all checks on pointers previously done by the verifier are
+ * invalidated and must be performed again, if the kfunc is used in
+ * combination with direct packet access.
+ *
+ * Parameters:
+ * @skb_ctx: Pointer to ctx (__sk_buff) in TC program. Cannot be NULL
+ * @sid: PPPoE session id, in network byte order
+ * @flags: BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size unchanged
+ *
+ * Return:
+ * * %0          - success
+ * * %-EINVAL    - unknown flags
+ * * %-ENOTSUPP  - skb->protocol is neither ETH_P_IP nor ETH_P_IPV6, the
+ *                 new length would exceed the maximum skb length, or the
+ *                 GSO metadata cannot be adjusted
+ * * %-ENOMEM    - the skb head could not be expanded
+ */
+__bpf_kfunc int bpf_skb_pppoe_encap(struct __sk_buff *skb_ctx, __be16 sid,
+				    u64 flags)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct pppoe_hdr *ph;
+	u16 ppp_proto;
+	u32 off;
+	int ret;
+
+	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
+		return -EINVAL;
+
+	if (skb->protocol != htons(ETH_P_IP) &&
+	    skb->protocol != htons(ETH_P_IPV6))
+		return -ENOTSUPP;
+
+	if (skb->len + PPPOE_SES_HLEN > BPF_SKB_MAX_LEN && !skb_is_gso(skb))
+		return -ENOTSUPP;
+
+	off = skb_mac_header_len(skb);
+
+	ret = bpf_skb_net_grow(skb, off, PPPOE_SES_HLEN, flags);
+	if (ret < 0)
+		return ret;
+
+	if (skb->protocol == htons(ETH_P_IP))
+		ppp_proto = PPP_IP;
+	else
+		ppp_proto = PPP_IPV6;
+
+	ph = (struct pppoe_hdr *)(skb->data + off);
+	ph->ver = 1;
+	ph->type = 1;
+	ph->code = 0;
+	ph->sid = sid;
+	ph->length = htons(skb->len - off - sizeof(*ph));
+	put_unaligned_be16(ppp_proto, (u8 *)ph + sizeof(*ph));
+
+	skb->protocol = htons(ETH_P_PPP_SES);
+	skb_reset_mac_len(skb);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	__skb_reset_checksum_unnecessary(skb);
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
+/**
+ * bpf_skb_pppoe_decap() - Remove the PPPoE session header from a
+ * packet.
+ *
+ * Remove the 8 byte PPPoE session header between the MAC header and
+ * the network header. skb->protocol is restored from the PPP protocol
+ * field; a payload with any other PPP protocol is rejected. The
+ * ethertype of the MAC header is left to the BPF program.
+ *
+ * A packet whose VLAN tag is still present in the packet data is
+ * rejected, as skb->protocol is then the VLAN ethertype.
+ *
+ * On GSO skbs, gso_size is increased by the size of the removed
+ * header and gso_segs is recomputed, like bpf_skb_adjust_room() does.
+ * With BPF_F_ADJ_ROOM_FIXED_GSO, gso_size is left unchanged and only
+ * gso_segs is recomputed.
+ *
+ * A call to this kfunc changes packet data. Therefore, at load time,
+ * all checks on pointers previously done by the verifier are
+ * invalidated and must be performed again, if the kfunc is used in
+ * combination with direct packet access.
+ *
+ * Parameters:
+ * @skb_ctx: Pointer to ctx (__sk_buff) in TC program. Cannot be NULL
+ * @flags: BPF_F_ADJ_ROOM_FIXED_GSO to leave gso_size unchanged
+ *
+ * Return:
+ * * %0          - success
+ * * %-ENOTSUPP  - skb->protocol is not ETH_P_PPP_SES, or the PPP
+ *                 protocol is neither PPP_IP nor PPP_IPV6
+ * * %-EINVAL    - unknown flags, the packet is shorter than the PPPoE
+ *                 session header, or no full L3 header would remain
+ *                 after decapsulation
+ * * %-ENOMEM    - the header is not linearly accessible
+ */
+__bpf_kfunc int bpf_skb_pppoe_decap(struct __sk_buff *skb_ctx, u64 flags)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	__be16 inner_proto;
+	u32 inner_len, off;
+	u16 ppp_proto;
+	int ret;
+
+	if (flags & ~BPF_F_ADJ_ROOM_FIXED_GSO)
+		return -EINVAL;
+
+	if (skb->protocol != htons(ETH_P_PPP_SES))
+		return -ENOTSUPP;
+
+	off = skb_mac_header_len(skb);
+
+	if (skb->len < off + PPPOE_SES_HLEN)
+		return -EINVAL;
+
+	if (!pskb_may_pull(skb, off + PPPOE_SES_HLEN))
+		return -ENOMEM;
+
+	ppp_proto = get_unaligned_be16(skb->data + off +
+				       sizeof(struct pppoe_hdr));
+	switch (ppp_proto) {
+	case PPP_IP:
+		inner_proto = htons(ETH_P_IP);
+		inner_len = sizeof(struct iphdr);
+		break;
+	case PPP_IPV6:
+		inner_proto = htons(ETH_P_IPV6);
+		inner_len = sizeof(struct ipv6hdr);
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	/* A full inner L3 header must remain after decapsulation. */
+	if (skb->len - off - PPPOE_SES_HLEN < inner_len)
+		return -EINVAL;
+
+	ret = bpf_skb_net_shrink(skb, off, PPPOE_SES_HLEN, flags);
+	if (ret < 0)
+		return ret;
+
+	skb->protocol = inner_proto;
+	skb_reset_mac_len(skb);
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
+	__skb_reset_checksum_unnecessary(skb);
+	bpf_compute_data_pointers(skb);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
@@ -12965,6 +13145,11 @@ BTF_KFUNCS_START(bpf_kfunc_check_set_icmp_send)
 BTF_ID_FLAGS(func, bpf_icmp_send)
 BTF_KFUNCS_END(bpf_kfunc_check_set_icmp_send)
 
+BTF_KFUNCS_START(bpf_kfunc_check_set_skb_pppoe)
+BTF_ID_FLAGS(func, bpf_skb_pppoe_encap, KF_CHANGES_PKT)
+BTF_ID_FLAGS(func, bpf_skb_pppoe_decap, KF_CHANGES_PKT)
+BTF_KFUNCS_END(bpf_kfunc_check_set_skb_pppoe)
+
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
 	.owner = THIS_MODULE,
 	.set = &bpf_kfunc_check_set_skb,
@@ -13000,6 +13185,11 @@ static const struct btf_kfunc_id_set bpf_kfunc_set_icmp_send = {
 	.set = &bpf_kfunc_check_set_icmp_send,
 };
 
+static const struct btf_kfunc_id_set bpf_kfunc_set_skb_pppoe = {
+	.owner = THIS_MODULE,
+	.set = &bpf_kfunc_check_set_skb_pppoe,
+};
+
 static int __init bpf_kfunc_init(void)
 {
 	int ret;
@@ -13023,6 +13213,8 @@ static int __init bpf_kfunc_init(void)
 					       &bpf_kfunc_set_sock_addr);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_tcp_reqsk);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &bpf_kfunc_set_icmp_send);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_pppoe);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_pppoe);
 	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SOCK_OPS, &bpf_kfunc_set_sock_ops);
 }
 late_initcall(bpf_kfunc_init);
-- 
2.47.3

