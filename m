Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530358;
	b=0M4LMpQq2GyLq8HPZbgYbzRkFR/RBgPvDMZPH95E6Ojtboyyq5qMoFzoFSHdhpytuOW0
	 oFiqhKj6VqwDo3/yc3EO21+HUAhiQRA2ZsgoaevXsYlj+iVRqKIrS1M3WMVGkfw8BnPKd
	 kbORvn9etMAqMKu0aIwN09G8CwlXlMEbB7u9SnrP9pAFZvvLSeIseQQ+fEOn2aVXAb62Y
	 xlYaak0uKmFk/jzDf/fXeulY/OME7ZtVzDeGcAKK2wWOS3DMY3SwJyZuxVhNQJT20ZJdV
	 hWdp3Y9T0h5VLAQH6MpuCS3KYSAGo8MF9QK3eyjcWf/pgyyAvRjEcqN0Qk10l8r6q2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530358;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=h2pLve9CfbYUk4h9BNGefRcEfHbuM+avbXOhKVZvFdU=;
	b=1F413qNSnbgVA7pFenOFBvLmq5e+T1Uf4wz6OvkZ+/3/ypQSuFDuIZMW9wGIxBg/+lg5
	 Dq5RHcG7z4BSKcFqw4/IZDo2wwpImId2KKeK8x3nxzaODZ1kGLbuMR4g9Uha4YLt6A3Im
	 KKmDPfepuzpnhyYWMZKmv8YtOdtGh2Jx77n4wa1l2/M0tBFgEUXtCvKhX0zTBF30/2vvz
	 VlhNLUQBVrKo41savwsj5vXyMhZPNxgyn/a0BEqs4tpuacdWTzpXpI5t0sq2gOOfZFUgl
	 yCjmPVyeN9C6gwlBbV2MMWYzxalA+FRrLFUhatlv8Vv90dGI3Lvh/iCBoNwDA5MsNBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oWj94Es+;
	arc=none smtp.remote-ip=91.218.175.69
Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A16606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 14:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A16606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oWj94Es+
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wtciEf4k1Kp/fzHfdEXxKaqAhqAQ0xFfSaOuMZuKKiQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795530355; v=1; x=1796135155;
 b=oWj94Es+UZrjTPx0iYjnwSS2OgB3YOINseLV7PztbqWHNGsyighPuCIStvofjcSny1+YmqkA
 4I2KFQVfQvg9wzwDV8edtaerxiyEWLkAJo0ubnWi9kWf6aeCKq3mxCdygkH1LERwb3uPRGHyt8Y
 UbKgC7jAAyQA82xeIvr7FiKg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 55d229cec49dac67;
	Tue, 24 Nov 2026 14:25:55 +0000
X-Mizu-Trace-ID: 55d229cec49dac67
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Kenneth Lee <kennethbwlee@snu.ac.kr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Wang Zhan <wang.zhan@smartx.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	bpf@vger.kernel.org
Subject: [PATCH net v3] net: xdp: fix generic XDP on skbs without an Ethernet header
Date: Tue, 24 Nov 2026 22:25:39 +0800
Message-ID: <20261124142545.221584-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
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

Kenneth Lee reported a bug [1]:

  skb_vlan_push got skb with skb->data not at mac header (offset 14)
  WARNING: net/core/skbuff.c:6474 at skb_vlan_push+0x5ec/0x8a0
   ____bpf_skb_vlan_push net/core/filter.c:3239 [inline]
   bpf_skb_vlan_push+0x216/0x8b0 net/core/filter.c:3229
   bpf_prog_run_data_pointers+0x17c/0x240 include/linux/filter.h:917
   tcf_bpf_act+0x31c/0x940 net/sched/act_bpf.c:50
   tcf_action_exec+0x2c1/0x720 net/sched/act_api.c:1147
   tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
   tc_run+0x31c/0x5d0 net/core/dev.c:4411
   sch_handle_ingress net/core/dev.c:4486 [inline]
   __netif_receive_skb_core+0x141b/0x2ec0 net/core/dev.c:6054

bpf_prog_run_generic_xdp() reads xdp->data as an Ethernet header. On an
L3 device like sit0 there is none, so the "did the program change the
header" check compares garbage, and the fixup:

	__skb_push(skb, ETH_HLEN);
	skb->pkt_type = PACKET_HOST;
	skb->protocol = eth_type_trans(skb, skb->dev);

leaves mac_len == 0 with skb_mac_header(skb) == skb->data - ETH_HLEN.
tc ingress then can't get skb->data back onto the mac header.

XDP is Ethernet only, so refuse to attach a generic XDP program to a
device that is not ARPHRD_ETHER.

The one exception is lo. Its type is ARPHRD_LOOPBACK, but it uses
eth_header_ops and eth_type_trans() like any Ethernet device, so its
skbs do carry an Ethernet header. Generic XDP on lo works today and the
BPF selftests rely on it (xdp_attach, xdp_devmap_attach, check_mtu,
...), so keep allowing it.

Rejecting the attach is not enough on its own, dev->type can change
after the program is attached. An empty bond or team takes the type of
its first port, and TUNSETLINK lets a tun device change its type.
dev->hard_header_len is no help either, it is what the driver wants
reserved on TX and many Ethernet drivers make it larger than ETH_HLEN.
So also skip the program for skbs that have no ETH_HLEN sized mac
header.

[1]: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.ac.kr/

Fixes: 297249569932 ("net: fix generic XDP to handle if eth header was mangled")
Reported-by: Kenneth Lee <kennethbwlee@snu.ac.kr>
Closes: https://lore.kernel.org/bpf/20260812043643.808295-1-kennethbwlee@snu.ac.kr/
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
v2 -> v3:
 - Only handle skbs with an ETH_HLEN mac header in generic XDP. This
   also skips VLAN devices with reorder_hdr off.

v1 -> v2:
 - Generic XDP does not support L3 devices, as discussed on v1. Reject
   the attach and skip skbs without an Ethernet header, instead of
   running the program on them.
 - Target net instead of net-next.

v2: https://lore.kernel.org/netdev/20261123121540.275576-1-jiayuan.chen@linux.dev/
v1: https://lore.kernel.org/netdev/20260813113229.381136-1-jiayuan.chen@linux.dev/
---
 net/core/dev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a63f6b939f7..4a4e030d93b6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5844,6 +5844,10 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
 	if (skb_is_redirected(skb))
 		return XDP_PASS;
 
+	/* XDP is Ethernet only, skip skbs without an Ethernet header. */
+	if (skb->data - skb_mac_header(skb) != ETH_HLEN)
+		return XDP_PASS;
+
 	/* XDP packets must have sufficient headroom of XDP_PACKET_HEADROOM
 	 * bytes. This is the guarantee that also native XDP provides,
 	 * thus we need to do it here as well.
@@ -10869,6 +10873,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
 			NL_SET_ERR_MSG(extack, "XDP program already attached");
 			return -EBUSY;
 		}
+		/* lo is ARPHRD_LOOPBACK but uses Ethernet framing. */
+		if (mode == XDP_MODE_SKB && dev->type != ARPHRD_ETHER &&
+		    dev->type != ARPHRD_LOOPBACK) {
+			NL_SET_ERR_MSG(extack, "Generic XDP only supports Ethernet devices");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	/* don't call drivers if the effective program didn't change */
-- 
2.43.0

