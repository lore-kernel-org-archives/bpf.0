Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595625;
	b=HBr7J+3tQaDmJiF1JtIvy+6c24IFCua/6MRsnb73ewQNjZcyS9je9mseS/7mkCILDpWH
	 xyXvCSK5uwcUQtaUlJTPj5d5rGY/wCwv0bhUu7H538w3Ssggi6nDTcwg2DdO/RQFG/Epj
	 6UEa1cYa/CbAytt+lfksnD8ePQ+WCBOX51BhI3dTUuOLLJDfISAWCAx1Io6w6nI9qYx48
	 UQv1GolaVUNRdG4qDZoaJKErvG2qka6/7C2sD0rJ9S5YsSLsT0lxoMoJiM/jIsCIX2AS9
	 ge6rmqNLoPkknun7YR38ldM/MOb3pymqdWQcCAx6GMjkJoH9HW+2ELfv0o9W6gIA1+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595625;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mailer:X-Mutt-Fcc;
	bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
	b=Xc1g4hA8SwZynQj8q6J+CUwVuqAhInO7dU4/LiTnSqSlewo8DbD3pv+uPvXwrE5BxuSw
	 GLgYJfOoUoWEqcTWgw0021KaLU+LbJ5Ab7Fjt0lGq3qnekxYQbV/zTIluhc5yN6+anvfN
	 y1yBqOtZOHXArF8O78R362AinR+y2PiA78YefWRwzEIzY//EjQW+1cC8rmKwGdWBRC6qV
	 bRE5KnISgitm/KPmtlrmlZ3cjI/ReLi7hZDvl2ZJptMPCLBvdmdKxts6i4HnxVw/dO9GL
	 Anu58Dfr3n6xrD/ZCerSHUJu713cjtUmnAnipdCrIUZ5dabKX0jvR2FLsfeqyJJYyKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q0heT1MH;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lA125dKp;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E10606A324
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 15:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q0heT1MH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lA125dKp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792595624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
	b=Q0heT1MHOpvzD80tOlcazVYKTdfY1KJ65kvZbAgp/KWz3GxYedkwNVArNd3FjZyByXWunw
	YaAmpF5ZTc9AIX34LbFXewIWDI+VK36KuXGICgQt324g4FzslKw/Nr4oRGYJNp1lBQJH1B
	8+Y6QCzRcSR5Ial0aMV1mJfyuSIT1UU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-t1EzIsEwOlq8dwoRyFHX-g-1; Wed, 21 Oct 2026 15:13:42 +0000
X-MC-Unique: t1EzIsEwOlq8dwoRyFHX-g-1
X-Mimecast-MFC-AGG-ID: t1EzIsEwOlq8dwoRyFHX-g_1792595622
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b1bbf8dbe9so1056430a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792595622; x=1793200422; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
        b=lA125dKpTF48B05jQLljtTOtDyrp0VwXaJgZI5jbIK+K4fYZcZmd0l0bI/hOnwNpQO
         WIDdKWk8WKRKIDF7YiTE2O3XuomKb54jGE52xxLbGGBkdbvXxUOSESXA/dyj0qHuWxhs
         7mqVFOK2o1H8JCQzMoORMIWvPz+6ErB4KCOWcwiCyYY+fRaMsHP/VUU2YQfseaU6o2Bu
         einyLwsxZeqQM/CX9U1UI9AsLokCOTavYW0cyiiwsDJkku3JdFHvsDneWHNAtqUJMjfG
         /ZxdjMZZdMSsWzHCmSQz7JhiKtpiZJZSFYiSth0Y3T9eypqrWwA1NmVSPIfEgmGb2/4U
         bpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792595622; x=1793200422;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCOfg1rZWMUgTb5ZTU+yOGOcFfR8PsoLRApHT5roxNo=;
        b=MomC71UDbT8WZ3nLkK8nnflmGnMfppxgJFgrt8mQRrLgsikJ97G6Xq+jxQA25y2YH4
         IAQtRSaotW2jjdkI7YNcpRtVSOQ7P05mSlcqKdcQT8Tr4lPSpbOf8FhXnqWi5xXHZu0d
         bGJhknrrjN4HuA/PyZ5CSUXay477aM6JaA21NPr6XC5/Ca8A1R88juuBj8DsJtiGcmbZ
         CebFyUoQ/MGQgopfQo4xqQ09zSqpCSIyfCahcR3N7n1TaS80rd/Hd7Olnr/YqbENnZBs
         LBWCGJaVcgm02pLy89+lUKFc1Qo9OMdyUSF4xWtwC47WwptegdwOxDGZSMeQ5bQJfi0h
         wFEA==
X-Forwarded-Encrypted: i=1; AKwUvBwk7ZVida2JIe9lTn1ghAe2ciNymxQdNCRZsuUGl5P8FKWm2A82ZLzvHmfTvDbKfSH1s+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjFk+X0o7wPlle0XsgESMdhsQlparORwzQxFHrGYIWQql/DCji
	BSAnR/wdbuOYzGnLM8hGMUNNuqvovVSv66TdaNgvPJMsSpBzo/mYe+1Lv52HUkQzQvDWFqunG0C
	zQzIfvRvvoKzeWkAAuVS70vz6qP3uA75dpZyWu9DNPQJmFZZEERZv3Q==
X-Gm-Gg: AYBFou1w0OLLlzhOYNYj0aOBt8yDM34BfpgvwVgJQRYW97QlPXTM8uOhta3Q++3P+Bp
	GBJx19nMYbXR2hoNee4jrhv9Y+1XbdqVs6Jb2vb3bQc7fjxrujOkcW3Ti2sKj9dDvfHFLMq98ZV
	nHyNp5uTd3bf9kHz0cTCagCh+UpHpG5CDAIKo1r8lhYzILlnXeEFBg7wGxApusSxY1hFmxm6ulx
	YJmnXwtLnuhCW0wC0NjNIhXBsDhzb5sfLD39ESTcqmu1BfovDm/pd5MFLzuz5oSOLrRRqQpGY/Z
	KxD/QtzYmFX4CVk3M07QmuHPNWlnb+XopWHUid/0w6mgCNEk9UsWLMQZj6loCTFYezU=
X-Received: by 2002:a05:6402:3244:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b408ee9f92mr1327646a12.38.1792595621509;
        Wed, 21 Oct 2026 08:13:41 -0700 (PDT)
X-Received: by 2002:a05:6402:3244:b0:6b1:c6fa:c45c with SMTP id 4fb4d7f45d1cf-6b408ee9f92mr1327622a12.38.1792595620934;
        Wed, 21 Oct 2026 08:13:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2581f15esm6499835f8f.20.2026.10.21.08.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 08:13:39 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:13:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3] net: gso: validate transport header before computing
 segment length
Message-ID: <52b8bfe4ee848aff8ace47752352de486171d45f.1792595507.git.mst@redhat.com>
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
BPF program can leave one behind through bpf_skb_adjust_room().  The
comparison is free, so let's not rely on enumerating producers.

Found by code review.

Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
Cc: Willem de Bruijn <willemb@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
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

