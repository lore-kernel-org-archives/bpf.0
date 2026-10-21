Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596703;
	b=asagBWBLMGKZwUSl60lqDXfc1777Crhsv9SDP7OvU1azUvumSj/2D65rBSIrJjm3hnEB
	 tNUrhieBxRxhRpoiy8Jq+Cv87vW1dnSjVMcXDIT4KV+7zkp6etU9RNkWUZIsnb36gWZ++
	 oJISuVSJtHpOkTlfL264e4OjUDFjTAEtC0aeJzJM/doZRjiioyuleI8ge8R6vDxnpbOVn
	 1txFAWxWdn5jNbWQOWY/V98d0iKmWaZxqv8HKyH8gJ9jpedtdl5Uu5A4duKB8OMK6+NXW
	 PTeYhDgb7TDJ+uTqvuJFsfU0lWjXHnIvhhp7J7n1/SmC2E80TMjxQP+Eq5efK51zctQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596703;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mailer:X-Mutt-Fcc;
	bh=P5x+xWRNF+UIFjIhMundH52vjybNRXC4bSlmjM77Jdc=;
	b=m+T/AWUnHLxoBEG2+hhFx/3fiKA0KxsmJr5oHAW2bSomXRYHiXicjnzMvIM489kSsQjX
	 9blOQ36iks4J49q8eSSag1rBg0jhT8o5RkyidxGBHV9PDdp3svvBEaLoHjmRoiZ3uamlP
	 +h32i+ThRm82BcKK1uvA8+jx+DLJeUlksyhgNioA1lO4a88PA8YCxg/tOy5ADs6JR038w
	 sDgQgs7fTju69xfb9LqkiJ+RKumEcwac0R1lDUen1O4ZI9Cy/KIL+IqEvK4e4bsicJBQ+
	 PZo4P8rrn65ffipPpcxGzM9JQuDe8v1pdvcudTbIFJQv+OQejI29u2YOKoeKRf2c4MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aY16tzFx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KAztVmth;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432C2606A32F
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 432C2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aY16tzFx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KAztVmth
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792596702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=P5x+xWRNF+UIFjIhMundH52vjybNRXC4bSlmjM77Jdc=;
	b=aY16tzFx4V/L/Ux5//NcTrXaypm5PpdR5mXDmWbdQuTnbNUF/lk7r7dEoHRgzGmv5ceoID
	lKz6PbLFaA9Cgj7JAXDsOavJO7+OT0mfA43wARHkoBRiaA6B0u1sMcRnjLwDz78iXioS2H
	moupUycIoqZIbwSdGxugWo6IbTXxwwQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-X-UQqvPoNsKAyKqd6mXzbA-1; Wed, 21 Oct 2026 11:31:32 -0400
X-MC-Unique: X-UQqvPoNsKAyKqd6mXzbA-1
X-Mimecast-MFC-AGG-ID: X-UQqvPoNsKAyKqd6mXzbA_1792596691
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so789963f8f.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792596691; x=1793201491; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P5x+xWRNF+UIFjIhMundH52vjybNRXC4bSlmjM77Jdc=;
        b=KAztVmthULosqd0CBNeH78dN5286Kvsd9qt4Te1fGVFUr/K0swbRbnjnVq8gJi/kVH
         1/NOzyw5ljd+ZeeMtslo9v+FlO0cAGEjifjz0wSx0bP3hEg7jF8bstSnLip7dmAOVxXk
         4GlyWlDix0QxBLbXavj191WzPQW27KB3tHQ5QgcqUxIDr/zXbUxQWwwY1wjO16pekyAh
         UYQkYLrzHak7gVs5ICl7f0Ejr5Gn6Ppbx/SuBIyqXX5dX2GHQ7fObtfwVMiheMcbOZUD
         bxWImMLvVT+MIIMv3CSKk0Txytqxt/dehdhB+AUR/ZYDNOjj3DnQHdI4PiRaZ6HBx3KK
         /ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792596691; x=1793201491;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P5x+xWRNF+UIFjIhMundH52vjybNRXC4bSlmjM77Jdc=;
        b=LbcnUs8dGKev3QuDfSS9fMRuz0Iuh1Q1mtnW8K8KpTarhG7PwihEPW66crTDPZIRHu
         m5xki9pYWjwrpo9Y1KxQauAN2N4K89StXYZ+glAqfZqYVb8yeGoleAWxVGY7MND+s0sM
         HP5kKOvoffQn105u/jEPDf7rMYgSy293ahf7AHZO9vdnqSnZnfTZgFIV2qpSs8U9hpWN
         Pua6e4PZrBK02uXqREh88kUlJIlTBTBb6yzeUAycw+jExRTtZhFygT5lCQN62k2B4yuM
         1+0w8HTDGivpBXkE1iWaw8Bv+jYe5HjqlHeyENAzGpgaGNeSDPfQrQG9cUfnOEs4nb+R
         MUKw==
X-Forwarded-Encrypted: i=1; AKwUvBzwoTSOxXNbTuY7aviJ0ZdD5ms83CQrMf/X5Qloq33Bi1XK6P0hPdFYMV9qtm8lCLTmvKs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGHMKO1hiR7sT2LkS841CO5bEIE2qqzIq0NYDX9cVzIMpZngR8
	x5IfYPwbGzo67NhHscFTnAlNIvkDbfxvp17pkcf8N97M/0J3mSulNM5EO2ALyPds5OB6aX9/iu2
	eRTKRM/NY0Ql+k+2UYBGFySXYpoqm5+z61hO7DZMEdcEa/QddgFfaIQ==
X-Gm-Gg: AYBFou1jFz5/+Qwf5l+OD0BP8T3sfxZd0G2O826wEHRH4hQvA0yn/x4qaQelHzy3xfs
	l/gNGr2qgXTqaDPj532Od4bX9+QTuvyk+vZZQHv1AyJTvyMd5GDwHukg3MsCCOJW58V5G/GjmqH
	Pv5PuHP8dZJBiw9wz0J+Rbpo9705VQ6W1eJJR0f0vDd2n5PmcP8lAShsQ5G3rnzZuObq5fBjezT
	vFn/aH65v9ezz5E5N3sY9JKdy7/v/ywOb/e/ei4Gj2w1ZrVBfe4Nb+g0VB8UQXJwC8Qe9d2GVdg
	nLtlpXmvfdjaSjRfyasrYA9m0rJROvGM2xacSg5tfCr9b1qO2CbJfTw3SaLyfrhThgk=
X-Received: by 2002:a5d:6f04:0:b0:48d:f72a:338c with SMTP id ffacd0b85a97d-48e264f8889mr5089858f8f.55.1792596690997;
        Wed, 21 Oct 2026 08:31:30 -0700 (PDT)
X-Received: by 2002:a5d:6f04:0:b0:48d:f72a:338c with SMTP id ffacd0b85a97d-48e264f8889mr5089763f8f.55.1792596690386;
        Wed, 21 Oct 2026 08:31:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e258213cesm6122348f8f.11.2026.10.21.08.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:31:27 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:31:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3] net: gso: validate transport header before computing
 segment length
Message-ID: <52b8bfe4ee848aff8ace47752352de486171d45f.1792596586.git.mst@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

If a TSO packet is processed in the stack before a transport
header was ever established, the TCP data offset is read through the
unset header offset, far outside the packet.

This was demonstrated by syzkaller, back when the input path did not
dissect such packets: a virtio net header supplying a malformed
network header was enough.  Qdisc length estimation has carried a
guard against exactly this since

commit a0dce8752193 ("net: Skip GSO length estimation if transport header is not set");

the GSO length validators never got one.

We used to, but we no longer allow such packets in: since

commit 44378d02c5aa ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()")

the virtio net input path dissects all GSO packets.

But as a defence in depth measure, let's also check before we read: if
the TCP header is unset or outside the linear data, report the packet
as not fitting.  What happens to it then is up to the caller: the IP
output path segments in software, a forwarder answers with an ICMP
error, policers apply their exceed action.

No unprivileged path is known to produce one - IP input resets the
transport header to the parsed position, local delivery pulls data
exactly to it, and tunnel decapsulation clears it altogether - but a tc
BPF program can leave one behind through bpf_skb_adjust_room().

Found by code inspection.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Notes (changelog):
    v2->v3:
        address Willem's review: fix commit reference style in the log,
        say the packet is reported as not fitting instead of dropped,
        reject the ~0U sentinel in skb_inner_transport_header_was_set(),
        rename skb_gso_transport_header_ok() to skb_tso_transport_header_ok(),
        check the outer transport header as well when encapsulated,
        fix declaration order
        move the check to skbuff.h as skb_transport_header_linear()
    v1->v2:
        address Willem's comments, in particular, teach
        skb_gso_network_seglen() to return a negative error, and
        propagate through callers
        keep the offset signed and check for sign

 include/linux/skbuff.h | 30 +++++++++++++++++
 net/core/gso.c         | 75 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f0..6f33c014e568 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3041,6 +3041,13 @@ static inline bool skb_inner_network_header_was_set(const struct sk_buff *skb)
 	return skb->inner_network_header > 0;
 }
 
+static inline bool skb_inner_transport_header_was_set(const struct sk_buff *skb)
+{
+	typeof(skb->inner_transport_header) th = skb->inner_transport_header;
+
+	return th > 0 && th != (typeof(th))~0U;
+}
+
 static inline unsigned char *skb_inner_mac_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->inner_mac_header;
@@ -3250,6 +3257,29 @@ static inline int skb_transport_offset(const struct sk_buff *skb)
 	return skb_transport_header(skb) - skb->data;
 }
 
+/* Is the (inner) transport header, as specified by
+ * skb->transport_header/inner_transport_header, in the linear data?
+ */
+static inline bool skb_transport_header_linear(const struct sk_buff *skb,
+					       unsigned int hlen)
+{
+	int thoff;
+
+	if (!skb_transport_header_was_set(skb))
+		return false;
+
+	if (skb->encapsulation) {
+		if (!skb_inner_transport_header_was_set(skb))
+			return false;
+
+		thoff = skb_inner_transport_offset(skb);
+	} else {
+		thoff = skb_transport_offset(skb);
+	}
+
+	return thoff >= 0 && thoff + hlen <= skb_headlen(skb);
+}
+
 static inline u32 skb_network_header_len(const struct sk_buff *skb)
 {
 	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
diff --git a/net/core/gso.c b/net/core/gso.c
index e96ef6350064..204ab9d08c18 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -131,6 +131,22 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(__skb_gso_segment);
 
+/*
+ * TSO processing (but not UDP/SCTP GSO, which uses fixed header
+ * sizes) reads the TCP header as specified by
+ * skb->transport_header/inner_transport_header.  Make sure it is
+ * there to read.
+ */
+static bool skb_tso_transport_header_ok(const struct sk_buff *skb)
+{
+	const struct skb_shared_info *shinfo = skb_shinfo(skb);
+
+	if (unlikely(!(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))))
+		return true;
+
+	return skb_transport_header_linear(skb, sizeof(struct tcphdr));
+}
+
 /**
  * skb_gso_transport_seglen - Return length of individual segments of a gso packet
  *
@@ -140,12 +156,18 @@ EXPORT_SYMBOL(__skb_gso_segment);
  * individual segments, including Layer4 headers (TCP/UDP).
  *
  * The MAC/L2 or network (IP, IPv6) headers are not accounted for.
+ *
+ * Return: the length, or a negative errno if the TCP header is not
+ * there to read.
  */
-static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
+static int skb_gso_transport_seglen(const struct sk_buff *skb)
 {
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	unsigned int thlen = 0;
 
+	if (unlikely(!skb_tso_transport_header_ok(skb)))
+		return -EINVAL;
+
 	if (skb->encapsulation) {
 		thlen = skb_inner_transport_header(skb) -
 			skb_transport_header(skb);
@@ -175,13 +197,21 @@ static unsigned int skb_gso_transport_seglen(const struct sk_buff *skb)
  * individual segments, including Layer3 (IP, IPv6) and L4 headers (TCP/UDP).
  *
  * The MAC/L2 header is not accounted for.
+ *
+ * Return: the length, or a negative errno if the TCP header is not
+ * there to read.
  */
-static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
+static int skb_gso_network_seglen(const struct sk_buff *skb)
 {
-	unsigned int hdr_len = skb_transport_header(skb) -
-			       skb_network_header(skb);
+	int tlen = skb_gso_transport_seglen(skb);
+	unsigned int hdr_len;
 
-	return hdr_len + skb_gso_transport_seglen(skb);
+	if (tlen < 0)
+		return tlen;
+
+	hdr_len = skb_transport_header(skb) - skb_network_header(skb);
+
+	return hdr_len + tlen;
 }
 
 /**
@@ -192,12 +222,21 @@ static unsigned int skb_gso_network_seglen(const struct sk_buff *skb)
  * skb_gso_mac_seglen is used to determine the real size of the
  * individual segments, including MAC/L2, Layer3 (IP, IPv6) and L4
  * headers (TCP/UDP).
+ *
+ * Return: the length, or a negative errno if the TCP header is not
+ * there to read.
  */
-static unsigned int skb_gso_mac_seglen(const struct sk_buff *skb)
+static int skb_gso_mac_seglen(const struct sk_buff *skb)
 {
-	unsigned int hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+	int tlen = skb_gso_transport_seglen(skb);
+	unsigned int hdr_len;
 
-	return hdr_len + skb_gso_transport_seglen(skb);
+	if (tlen < 0)
+		return tlen;
+
+	hdr_len = skb_transport_header(skb) - skb_mac_header(skb);
+
+	return hdr_len + tlen;
 }
 
 /**
@@ -250,10 +289,18 @@ static inline bool skb_gso_size_check(const struct sk_buff *skb,
  * skb_gso_validate_network_len validates if a given skb will fit a
  * wanted MTU once split. It considers L3 headers, L4 headers, and the
  * payload.
+ *
+ * Return: Whether the skb will fit.  Also false if the TCP header
+ * is not there to read.
  */
 bool skb_gso_validate_network_len(const struct sk_buff *skb, unsigned int mtu)
 {
-	return skb_gso_size_check(skb, skb_gso_network_seglen(skb), mtu);
+	int seg_len = skb_gso_network_seglen(skb);
+
+	if (seg_len < 0)
+		return false;
+
+	return skb_gso_size_check(skb, seg_len, mtu);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
 
@@ -265,10 +312,18 @@ EXPORT_SYMBOL_GPL(skb_gso_validate_network_len);
  *
  * skb_gso_validate_mac_len validates if a given skb will fit a wanted
  * length once split, including L2, L3 and L4 headers and the payload.
+ *
+ * Return: Whether the skb will fit.  Also false if the TCP header
+ * is not there to read.
  */
 bool skb_gso_validate_mac_len(const struct sk_buff *skb, unsigned int len)
 {
-	return skb_gso_size_check(skb, skb_gso_mac_seglen(skb), len);
+	int seg_len = skb_gso_mac_seglen(skb);
+
+	if (seg_len < 0)
+		return false;
+
+	return skb_gso_size_check(skb, seg_len, len);
 }
 EXPORT_SYMBOL_GPL(skb_gso_validate_mac_len);
 
-- 
MST

