Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266570;
	b=IeL1nFhE9buULjNsdVxdDi/FVRGofXhTrokHdP2HUzj9pUHATZpMBPNYPgY29n4EoesR
	 LMTOD6CC5ZJgFk+/hLqd0BvA3ySa74Fq8n6DGhOWKiCgOC+hv1eCeaQ90Q/LqgA31WICv
	 GOtRkCNwvYBuwTx4+ue2mpnVJ3xLvYBm3MAtrecfxYf/6KR6H9oMak+R/fUXcUNn/PUMf
	 Qrnd98Emhz3d7XYA6t7CV4JTzAit5TbsjL4a/1iJ9sCVsWlMU/OlrF277/syGA2njwCE8
	 dt8e0kL0cZxUW8Rn9oM+IKUrkbwaPxhVsDXxsrHIyM4rm6oYXLcJMgVCaOHe5g+1ijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hzOUhhpV11demFlh59Tft/tHrYohYb0/kBzwZWpxs64=;
	b=Z8+TiMemZv9W7+HfCYu7yomA537Xdhrsb8gYLVX9k/ciHmSgZYkfQThO+X/SSZRAGl9S
	 MEI2/ly2Zzu3pqtD+Jx50yNkquWzDAtOqBwBOG17mHoX/pfFkjMSrIVKfD/OzLrb1lswW
	 3QuaL8rVxao1ZNRSIqQ0jZUoDAla+nyZJiuRU93cAVZEOrxxjOxzJXa/oKbDY4y26doZL
	 zZ8gbptxw//7GRhXG/L+TrCrRd6RBanIS5gkDrTMpIepfBJEZNyCrHwwEZSyU/eVdgu3U
	 SYQ41Li8Bqqwd2FBBNGtTY9h6M4KiOHG1lftSuREZgcO8ybV7GS+2aEfNMsw04Qdr/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="ly/wfBfW";
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A689606A31E
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 09:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A689606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=ly/wfBfW
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67583c777abso601538d50.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 02:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793266568; x=1793871368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzOUhhpV11demFlh59Tft/tHrYohYb0/kBzwZWpxs64=;
        b=ly/wfBfWMVEzWxCgsqsaGeWG9kaAy9McsBcfGXzxZ6JEl4eZFJztoAYNbUYnAtnQdT
         kwWj7GOIxz1UP3KhSEJRd6XI+FjCMz661R7ylsTSIcQJPZejEfal/SKCX4Bx62Pdko/+
         VX1mxT1xyAN6+sr3cOmLuDZrea2OHjRNdCFhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266568; x=1793871368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzOUhhpV11demFlh59Tft/tHrYohYb0/kBzwZWpxs64=;
        b=BcO63xxCfG73XwEWK84HrOBpDJNPEAv6LN44Cw3cG+JSepWwj/7oYnuSFOfkzVzKSA
         x2UD3ybJY915OQ66Wqob2uI188VF7oPgaMAst+VSubDDT5713rMnEJNt2pFiNLvL/zj7
         ePCg9XWI6VhVht8ETt0IWGEplSdNrhcYV9bnAr8SZZzYjqnKKqAb5HRYmbg/xgNCN//m
         bbq5FeDV59NoqVH9CUDhZHjnfxlozAIW6cQIZQ+SfPYLvZWOtRZhrLiEh34aa8Nf63kp
         ypt+kwrykdUfej7NtgvGbL+xWxBP6Y7Lx0I2cYNbvCj9cbmfnjSOG9+PlYcu3dYhGaHU
         5Jcw==
X-Forwarded-Encrypted: i=1; AKwUvBzlPL5FjTKd1JJdTD2PeCITv2wxkE67QDojtVYvE84qKMyL9dhdOnaiSK2sIrJtfpnVOrM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKWoJ5dWBzaG35yatGW1trBdzTZr18C6pDQLFjnUewRdVzvWRO1
	w1W4SoZHMl7nTweyo2tV3JayKCyzfSSG4mSRvqWEYdzo6PrsbP3wZB+dIlsFb8B6iA==
X-Gm-Gg: AYBFou3HZg7EUyi3454Ta4mnXW/o9ydSmIITsyqEObYA11OGQiCPp3dP+zdiP7IpLQE
	qXAHSwm9O0rIEbqEMzG5vkSo0ieII1tRdOpDp9xS2jPLrfDOGJHb2MFsnMfKBav7t/Hb0tidCNd
	1VBODG6yFEYx6N16aPULApJlrVUOW+H12TD451EQnJ82FK26MpD8HYIzf8kB7KCz+9UDDevMF/s
	H5IHqeHS6xM0705Q88npXBwoqRsNdOzsz8Ukf0o/To747iAPmbxqqSo404AueIF95e86Swx9tRR
	sMOc5tyU/C1C49z+V0KNxZ3QU+quKdSdvJCJZ3FZ1EZ3LWSzLcNIARYRxOQQTNf+CENy+FkZwSF
	Vl1UA1VjSddust0nV+5i0rL9NZmvupOfPcn2v/l5dWeBwg7C4gFKGRfnWsmITeF6UJnM94t5RHk
	DMoHk+3rEb5/pK+6E6hVGyWT9LFTGTy1VOUIk2eKpq99g/W1pW8Xru/8vbHkiFBLTrK37wfbVeq
	wB8jfR4FgcwmmRAUp4k0UtbmZqAS5P37CgHIo3ZJWcJFpNBIr0FU6QSOyUKXwlvlMrvSHY5kuTT
	eih4NBudhODOt5go0WxQth61ex1MNDKn2aTuXkXqclhbG3RCznyj5/h5fE4fQ7M9ExpFo+BlMZE
	FT8ojObZIH2m9LwI=
X-Received: by 2002:a05:690e:1909:b0:677:b7c3:12c3 with SMTP id 956f58d0204a3-67a8d22eb63mr1824691d50.29.1793266568197;
        Thu, 29 Oct 2026 02:36:08 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a7a0c31cfsm3058873d50.9.2026.10.29.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:36:07 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Eric Dumazet <edumazet@kernel.org>,
	bpf@vger.kernel.org,
	bot+bpf-ci@kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v2] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
Date: Thu, 29 Oct 2026 05:36:03 -0400
Message-Id: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

The issue:
This is a follow-up to the short link-layer header fixes from Eric.
After vlan pop_eth, a privileged SCHED_ACT BPF program can call
bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().

__bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
only that mac_header < network_header.  It does not check that the MAC
header is long enough or that it is linear.

A SCHED_ACT BPF program can do:

    bpf_skb_change_head(skb, 1, 0);
    bpf_redirect_neigh(lo, NULL, 0, 0);

after vlan pop_eth.  The skb then has mac_len == 1 and only one byte of
linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
__skb_pull():

    kernel BUG at include/linux/skbuff.h:2839
    RIP: skb_pull+0xc5/0x100
    Call Trace: skb_do_redirect -> ...

The Fix:
Use skb_mac_header_len(), i.e. network_header - mac_header, rather than
skb->mac_len.  mac_len is zero for locally generated tc egress and netkit
packets, while skb_mac_header_len() still rejects the one-byte header
produced by pop_eth + bpf_skb_change_head(skb, 1, 0).

Also use pskb_may_pull() to ensure the Ethernet header is linear before
reading or pulling it, and re-read ethh afterwards since pskb_may_pull()
may reallocate skb->head.

Add egress coverage to tc_redirect_neigh: the existing test only attaches
redirect_neigh at ingress, where mac_len is populated.

Conditions to recreate the bug:
On x86-64 with 4 KiB pages, enable CONFIG_PACKET, CONFIG_BPF_SYSCALL,
CONFIG_NET_SCH_INGRESS, CONFIG_NET_CLS_MATCHALL, CONFIG_NET_ACT_VLAN and
CONFIG_NET_ACT_BPF.  Run as root with BPF loading, network administration
and raw-packet privileges.  Bring lo up and attach a SCHED_ACT program
that calls bpf_skb_change_head(skb, 1, 0), then returns
bpf_redirect_neigh(skb->ifindex, NULL, 0, 0):

  ip link set lo up
  tc qdisc add dev lo clsact
  tc filter add dev lo egress matchall action vlan pop_eth pipe \
      action bpf object-file neigh_chghead.o section action

Send an untagged ETH_P_IP frame of ETH_HLEN + 8192 bytes through an
AF_PACKET/SOCK_RAW socket bound to lo, without PACKET_VNET_HDR or
PACKET_QDISC_BYPASS.  Use a unicast destination MAC.  The sender's skb
has a 14-byte linear Ethernet prefix and a fragmented payload; pop_eth
removes that prefix and change_head restores only one linear byte.
The unfixed neighbor redirect then tries to pull 14 bytes and BUGs.

Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Reported-by: BPF CI <bot+bpf-ci@kernel.org>
Link: https://lore.kernel.org/all/2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org/
Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2:
- use skb_mac_header_len() instead of mac_len; mac_len is zero for
  locally generated tc egress and netkit packets (BPF CI)
- add tc-egress coverage to tc_redirect_neigh
- document the nonlinear AF_PACKET reproduction conditions

 net/core/filter.c                             |  6 ++++-
 .../selftests/bpf/prog_tests/tc_redirect.c    | 26 +++++++++++++++++++
 .../selftests/bpf/progs/test_tc_neigh.c       | 10 +++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2..4925f3e355d4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
+	struct ethhdr *ethh;
 
 	if (unlikely(skb->mac_header >= skb->network_header))
 		goto out;
+	if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
+		goto out;
+	ethh = eth_hdr(skb);
 	bpf_push_mac_rcsum(skb);
 	if (is_multicast_ether_addr(ethh->h_dest))
 		goto out;
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index af8968b89ad7..829f84fb64a3 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -407,6 +407,26 @@ static int netns_load_bpf(const struct bpf_program *src_prog,
 	return -1;
 }
 
+static int netns_load_egress_bpf(const struct bpf_program *prog,
+				 const char *ns, int ifindex)
+{
+	LIBBPF_OPTS(bpf_tc_hook, qdisc);
+	struct nstoken *nstoken;
+	int err;
+
+	nstoken = open_netns(ns);
+	if (!ASSERT_OK_PTR(nstoken, "setns egress"))
+		return -1;
+
+	QDISC_CLSACT_CREATE(&qdisc, ifindex);
+	XGRESS_FILTER_ADD(&qdisc, BPF_TC_EGRESS, prog, 0);
+	close_netns(nstoken);
+	return 0;
+fail:
+	close_netns(nstoken);
+	return -1;
+}
+
 static struct bpf_link *netns_attach_nk(const char *ns, int ifindex,
 					struct bpf_program *prog)
 {
@@ -1055,6 +1075,12 @@ static void test_tc_redirect_neigh(struct netns_setup_result *setup_result)
 			   skel->progs.tc_chk, setup_result))
 		goto done;
 
+	if (netns_load_egress_bpf(skel->progs.tc_egress, NS_SRC,
+				  setup_result->ifindex_src) ||
+	    netns_load_egress_bpf(skel->progs.tc_egress, NS_DST,
+				  setup_result->ifindex_dst))
+		goto done;
+
 	if (!ASSERT_OK(set_forwarding(false), "disable forwarding"))
 		goto done;
 
diff --git a/tools/testing/selftests/bpf/progs/test_tc_neigh.c b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
index de15155f2609..e0b6c14a3935 100644
--- a/tools/testing/selftests/bpf/progs/test_tc_neigh.c
+++ b/tools/testing/selftests/bpf/progs/test_tc_neigh.c
@@ -133,4 +133,14 @@ int tc_src(struct __sk_buff *skb)
 	return bpf_redirect_neigh(IFINDEX_DST, NULL, 0, 0);
 }
 
+SEC("tc")
+int tc_egress(struct __sk_buff *skb)
+{
+	if (skb->mark)
+		return TC_ACT_OK;
+
+	skb->mark = 1;
+	return bpf_redirect_neigh(skb->ifindex, NULL, 0, 0);
+}
+
 char __license[] SEC("license") = "GPL";
-- 
2.43.0

