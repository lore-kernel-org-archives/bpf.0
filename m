Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16882327C00
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375677; cv=none; b=B/xGaBKQ5c5JHtt2kbYAjG6K3PZEnl6zIfF2DQb5Svs6bWGINkFhagLW8d5BOk5Q8iM8UmYXRNrlY7/CyS0Zmrn6XQaAT370HE2/raVucwVX67vzIodkrG8BGfjsyNfKaEQT9123X5AIIQwdNBtmDuEhOu0pvYL4sZCClMcFYfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375677; c=relaxed/simple;
	bh=4XBejezJwJUWg3ebsSGgxMlB7tycHo/ivdoQZ42t6Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jtf7eftnBHG+LRyYYAy5rwRxW88P76o6jwe8EOyh5JLaY+XLMwhOEj9UGawMREaSW7yJfXuJmiBEm04+1lTUtIVnmnrKtOTp6yXLMwkrC6aa3gi/xgiGrVbzZfesGLQX03uHJhEOwjV253hhiClkNl/lr8JifiKSf0qme6ws/GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=DZlPyhiR; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="DZlPyhiR"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd3b29d5so126161c88.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 11:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781375675; x=1781980475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k/pxlb3nzhZvX5D10rXnPFy/NJtoITQ+9ZSRRvEAWA=;
        b=DZlPyhiRC9wivcDlTa32yBMRUH9EnJ/h432dzAdwb9wAyrDiDTGVyr7/reQkf0ltNm
         llFyHseB+QtaSNTLVqisZ1hnAF/TBtLlqve5J/bHeWwwpz2/emawsm494BjUJr1KfByP
         Q4/QgQFCe0OHGtVd7a80fUqUcPl6Ab8Fc3pfF05Dbg5aiLkkv0QX08psZYRrTUillGjr
         4pRdTje1oItsCjxh3/Lxry46S+ViXoOxZeuxIPrDTLfeV1jDfQ6BdCJR+F3yOXywX4Zt
         XXdF6uvruJBA1VaO5hUN+quROzrTQNnslPpWvdCrXnPsR0NPK6u2exoIp6IuWy/oyKAF
         Yc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781375675; x=1781980475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9k/pxlb3nzhZvX5D10rXnPFy/NJtoITQ+9ZSRRvEAWA=;
        b=p7RAvHvLSlja1VjEtXR1GjGULABT6+ryYlMit/fXj/DteU6zcF2VwHrKbPedtgo8sS
         diCNn+p/NvBJerZWGycrfUoe8njzXCgYLnSEzf9hymIMHUkkLuPCj+i5eg2fC7mGXamU
         Vp8kazTupwFi8nCKMfZpbIsT3nPQINd8foSSHAQagC+qseBunOIUro7+W7P29p84Bb+8
         5p6hLGIKD0hi38JdBrTQOiS+2aqS2shBNZvVo6cGHRIchjPIAz6lNK3I4FOoSGiNK6Ub
         8Pu8x7boTnfvmp7GKGwRiV5xL22kw6oUqyxDLupZ6li+HnnoJUSD0+gDxyxj4FIgHC3F
         97LQ==
X-Gm-Message-State: AOJu0YwneF1kd1HhCQyT5cbvmu/gswxmO+JF8fs3+gYqpX0yGYMjizDJ
	hH5pkfvHbIWBPNU8dI4+d4mMG2gMqKRrs3jkiKkNV2kQevhmlG4ZsD6f8yiE0xESHND02nbRaoV
	FrxIN
X-Gm-Gg: Acq92OE8GY5T6GoTPWagqenbp7q/OwkZJ8+dzOZ7OSZfE+K76wRY5lMZinUoPbzT1M0
	4MQv8WCeM8S2B8R/tTWLXtAR1J6zPe6ji2B9g4D8a90Aw7JNhKfbxa9CRkJr1uj2+crTukGtxJD
	F63g84VVd0q5M4+Gt9Ubk22bwtvOX1AMi6UJWF7dwn+sR1DTfVtlSzN/kcClV3CC2Yb871jUt0M
	pjtEFMcQJTzY0SKbWmrwIsugkpJHCdqYHSaEfTb+0IZdIZOZKFHz3A9OIJ/TMooxbjgGG7M5Hm0
	TYICdWYSoxj0ico7oT6wHAVV0sab0EXkaDyD7Wcq0Gsv6Bf+7nbHXhHrUPEv25YmP3P3sCgrks3
	a8DNNV6LjMeLK6xn4/qBhCGANDvUTUazYpoZkzNIs1mDk3XvfoCymaULJORIjhS2rkY3GYi6qC5
	TBfe5nI8/Hy4A=
X-Received: by 2002:a05:7300:7495:b0:304:c73b:79fd with SMTP id 5a478bee46e88-308200b9c28mr1937100eec.5.1781375675021;
        Sat, 13 Jun 2026 11:34:35 -0700 (PDT)
Received: from t14.. ([2001:5a8:47ec:d700:7881:81f1:548c:e2d3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm9181543eec.4.2026.06.13.11.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 11:34:34 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH v1 bpf-next 1/2] bpf: Support BPF_F_INGRESS with bpf_redirect_peer
Date: Sat, 13 Jun 2026 11:34:05 -0700
Message-ID: <20260613183424.1198073-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613183424.1198073-1-jordan@jrife.io>
References: <20260613183424.1198073-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have several use cases where a pod injects traffic into the datapath
of another so that the traffic appears to have originated from that
pod. One such use case is a synthetic flow generator which injects
synthetic traffic into a pod's datapath to enable dynamic probing and
debugging. Another is a transparent proxy where connections originating
from one pod are redirected towards another which proxies that
connection. The new connection is bound to the IP of the original pod
using IP_TRANSPARENT and its traffic is injected into that pod's
datapath and handled as if it had originated there. This can be used for
mTLS, etc.

We use bpf_redirect(BPF_F_INGRESS) to direct traffic leaving the proxy,
flow generator, etc. towards the target pod, ensuring that eBPF programs
that are meant to intercept traffic leaving that pod are executed.
However, this doesn't work with netkit.

With netkit, an ingress redirection from proxy to workload skips eBPF
programs that are meant to intercept traffic leaving the pod, since they
reside on the netkit peer device. One workaround is to attach the
same program to both the netkit peer device and the TCX ingress hook for
the netkit pair's primary interface, but

a) This seems hacky and we need to be careful not to run the same
   program twice for the same skb in cases where we want to pass that
   traffic to the host stack.
b) We're trying to keep the proxy redirection / traffic injection
   systems as modular and separated from Cilium as possible, the system
   that manages netkit setup and core eBPF programming.

It would be handy if instead we could redirect traffic directly from
one netkit peer device to another. This patch proposes an extension
to bpf_redirect_peer to allow us to do just that.

With this patch, the BPF_F_INGRESS flag tells bpf_redirect_peer to emit
the skb in the egress direction of the target interface's peer device
While the main use case is netkit, I suppose you could also use this
mode with veth as well if, e.g., there were some eBPF programs attached
to that side of the veth pair that needed to intercept traffic.

 +---------------------------------------------------------------------+
 | +-------------------------+         6. bpf_redirect_neigh(eth0)     |
 | | pod (10.244.0.10)       |           ------------------------      |
 | |                         |          |                        |     |
 | |              +--------+ |          |      +---------+       |     |
 | | 1. packet -->|        | |          |      |         |       |     |
 | |    leaves ^  | netkit |<===========|======| netkit  |       |     |
 | |           |  | peer   |=======(eBPF)=====>| primary |       |     |
 | |           |  |        | |          |      |         |       |     |
 | |           |  +--------+ |          |      +---------+       |     |
 | |           |             |          | 2. bpf_redirect        v     |
 | +-----------|-------------+          |___________________   +-------|
 |             |                                            |  | eth0  |
 |             | 5. bpf_redirect_peer(BPF_F_INGRESS)        |  +-------|
 |             |________________________                    |          |
 | +-------------------------+          |                   |          |
 | | proxy (10.244.0.11)     |          |                   |          |
 | | IP_TRANSPARENT          |          |                   |          |
 | |              +--------+ |          |      +---------+  |          |
 | | 3. packet <--|        | |          |      |         |<--          |
 | |    enters    | netkit |<===========|======| netkit  |             |
 | |    [proxy]   | peer   |=======(eBPF)=====>| primary |             |
 | | 4. packet -->|        | |                 |         |             |
 | |    leaves    +--------+ |                 +---------+             |
 | |    sip=10.244.0.10      |                                         |
 | +-------------------------+                                         |
 +---------------------------------------------------------------------+

Using the proxy use case as an example, in step 5 we would redirect
traffic leaving the proxy towards the pod's peer device using
bpf_redirect_peer(BPF_F_INGRESS).

As a bonus, since the skb doesn't have to go through the backlog queue
it can take full advantage of netkit's performance benefits. I set up a
test where outgoing iperf3 traffic is injected into the datapath of
another pod using either bpf_redirect_peer(BPF_F_INGRESS) or
bpf_redirect(BPF_F_INGRESS). I used Cilium's eBPF host routing mode
which skips the host stack and uses BPF redirect helpers to do all the
routing.

  (net.ipv4.tcp_congestion_control=cubic,mtu=1500,100GiB link,Cilium
   eBPF host routing mode)

BASELINE [bpf_redirect(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>           eth0
  3. eth0        ==over network==>                         [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   231 GBytes  33.0 Gbits/sec  12060     sender
  [  5]   0.00-60.00  sec   230 GBytes  33.0 Gbits/sec            receiver

TEST [bpf_redirect_peer(BPF_F_INGRESS)]
  1. [iperf pod] ==bpf_redirect_peer([pod b], BPF_F_INGRESS)==> [pod b]
  2. [pod b]     ==bpf_redirect_neigh([eth0])==>                eth0
  3. eth0        ==over network==>                              [host b]

  [ ID] Interval           Transfer     Bitrate         Retr
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
  [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver

In this test, using bpf_redirect_peer(BPF_F_INGRESS) for the hop from
[iperf pod] to [pod b] led to ~18% more throughput compared to
bpf_redirect(BPF_F_INGRESS).

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 include/uapi/linux/bpf.h       | 16 +++++++++-------
 net/core/filter.c              | 14 ++++++++------
 tools/include/uapi/linux/bpf.h | 16 +++++++++-------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 11dd610fa5fa..dd0f2c3aea58 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5074,17 +5074,19 @@ union bpf_attr {
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*.
  * 		This helper is somewhat similar to **bpf_redirect**\ (), except
- * 		that the redirection happens to the *ifindex*' peer device and
- * 		the netns switch takes place from ingress to ingress without
- * 		going through the CPU's backlog queue.
+ * 		that the redirection happens to the *ifindex*' peer device. If
+ * 		*flags* is 0, the netns switch takes place from ingress to
+ * 		ingress without going through the CPU's backlog queue. If the
+ * 		**BPF_F_INGRESS** flag is provided then redirection happens in
+ * 		the egress direction of the peer device.
  *
  * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
  * 		the netns switch.
  *
- * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the
- * 		ingress hook and for veth and netkit target device types. The
- * 		peer device must reside in a different network namespace.
+ * 		If the *flags* argument is 0, the helper is currently only
+ * 		supported for tc BPF program types at the ingress hook and for
+ * 		veth and netkit target device types. The peer device must reside
+ * 		in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..c24fdf744f75 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2529,16 +2529,18 @@ int skb_do_redirect(struct sk_buff *skb)
 	if (unlikely(!dev))
 		goto out_drop;
 	if (flags & BPF_F_PEER) {
-		if (unlikely(!skb_at_tc_ingress(skb)))
-			goto out_drop;
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
 			     !(dev->flags & IFF_UP) ||
 			     net_eq(net, dev_net(dev))))
 			goto out_drop;
-		skb->dev = dev;
-		dev_sw_netstats_rx_add(dev, skb->len);
 		skb_scrub_packet(skb, false);
+		if (flags & BPF_F_INGRESS)
+			return __bpf_redirect(skb, dev, 0);
+		if (unlikely(!skb_at_tc_ingress(skb)))
+			goto out_drop;
+		dev_sw_netstats_rx_add(dev, skb->len);
+		skb->dev = dev;
 		return -EAGAIN;
 	}
 	return flags & BPF_F_NEIGH ?
@@ -2575,10 +2577,10 @@ BPF_CALL_2(bpf_redirect_peer, u32, ifindex, u64, flags)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
 
-	if (unlikely(flags))
+	if (unlikely(flags & ~BPF_F_INGRESS))
 		return TC_ACT_SHOT;
 
-	ri->flags = BPF_F_PEER;
+	ri->flags = BPF_F_PEER | flags;
 	ri->tgt_index = ifindex;
 
 	return TC_ACT_REDIRECT;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 11dd610fa5fa..dd0f2c3aea58 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5074,17 +5074,19 @@ union bpf_attr {
  * 	Description
  * 		Redirect the packet to another net device of index *ifindex*.
  * 		This helper is somewhat similar to **bpf_redirect**\ (), except
- * 		that the redirection happens to the *ifindex*' peer device and
- * 		the netns switch takes place from ingress to ingress without
- * 		going through the CPU's backlog queue.
+ * 		that the redirection happens to the *ifindex*' peer device. If
+ * 		*flags* is 0, the netns switch takes place from ingress to
+ * 		ingress without going through the CPU's backlog queue. If the
+ * 		**BPF_F_INGRESS** flag is provided then redirection happens in
+ * 		the egress direction of the peer device.
  *
  * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
  * 		the netns switch.
  *
- * 		The *flags* argument is reserved and must be 0. The helper is
- * 		currently only supported for tc BPF program types at the
- * 		ingress hook and for veth and netkit target device types. The
- * 		peer device must reside in a different network namespace.
+ * 		If the *flags* argument is 0, the helper is currently only
+ * 		supported for tc BPF program types at the ingress hook and for
+ * 		veth and netkit target device types. The peer device must reside
+ * 		in a different network namespace.
  * 	Return
  * 		The helper returns **TC_ACT_REDIRECT** on success or
  * 		**TC_ACT_SHOT** on error.
-- 
2.43.0

