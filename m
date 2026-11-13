Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596191;
	b=RzgYLJQr+MUmkgCnvqXznM+5GowFmQPRksimGWIbDWQjiDhxzwJ2Qlhk59r+i0W3MzBj
	 uzBj9uO8Jg9o0LF+ZxKrEmp7ntD4a30yB6xU32+/jD545qPoZUA5W8Z5IAtabtB5snJo2
	 gKe75o5rxaeBUiMkhyk+jSc+YlTmW4xWjQOUFyWPIqatdG+pXCwqU7kGTkF3WWnJZW3z9
	 SL0/Iyab68wUnRAIxccMktjKeaiUld5FtQue9sgcIljwxHmoEl9bSf9Utdw/G7w3yiYZe
	 81VkhYEEaMOjy5wZ6exzoEu5fPbJH9qsX4lAZsYBa4Dgt9XOOOpLi4H6atcfDEBkARA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596191;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=g0ioZjHygxwZjnEMNPplVdcx1LXsFhIZuILyLp54kuw=;
	b=VjYBhOWGbBvz9tMZn/kNHkCY/ewz51+i2jvVbelUL5yENqdRvWExA1nw8x0MET4BwjZQ
	 +DkQ04tFs6X6xYispxlDAG4ww5H0JFU9OLlQJdyXpXig8+PqkJ8Jqf8ap8ugOu7pnWZl+
	 idFGhi6AqFjG7Pa0k9i0gvKXMfNC5DWN/kRQJE5gxroQjKi0Jhl7Ia6qKd3ov4aDMF1EH
	 9B15ns0xtPE0AU0IRz3OsEpDJv1DM6vId+ExByG+p+dqm8BYQA3Z3cdrJGiUyoStmS/is
	 RVeS9D6VNsVss5I7U8NrQlUveo54+V+e/EU2g0IV0R8j6ji7ySfOQryqAkhhqxmRfNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hbBX0fWc;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468A607107B;
	Fri, 13 Nov 2026 18:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8468A607107B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=hbBX0fWc
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFSaRb2006580;
	Fri, 13 Nov 2026 10:56:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	pps82601-s2048-2026-q3; bh=g0ioZjHygxwZjnEMNPplVdcx1LXsFhIZuILyL
	p54kuw=; b=hbBX0fWcl/fbq9z/VNbDm8yVk8j45/LDBG6hYrXQ7kVeNwra2Kby2
	p42sqhNkKW6Y62Vjoz0G3QYNsjHxbFWvvvYtVdMtFICSB5FyUsHpBa/8WqaczaOF
	S5kruvpQOgydrEekAgJrrc9Qop+SdOW5wBrnC1WC1VS3R/xOOz7Z5CA6n1bJo/u+
	MjMtJ7YzfAcinPefqQrzNcUTHPlx4Pmbwr0XWe8oQIPcH9ow5X/8Tw13d9C5GuwN
	72JCBfVQT/oUi5DZ5dlpCbcLN6kwxSWXO+t63nb5urrDVpl7fhBqZdQfHb4D1xDB
	G2vuJlwaj8u2Fb5MhVRNhsrRYqUz7XdlQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwj8cg3gn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 10:56:01 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1b::2d) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 18:56:00 +0000
From: Todd Freed <toddfreed@meta.com>
To: <netdev@vger.kernel.org>, <toddfreed@meta.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Wei Wang <weiwan@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko
	<jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        "Stanislav
 Fomichev" <sdf@fomichev.me>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "Boris
 Pismenny" <borisp@nvidia.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/3] bpf: don't redirect decrypted skbs from egress to ingress
Date: Fri, 13 Nov 2026 10:55:52 -0800
Message-ID: <20261113185553.171059-3-toddfreed@meta.com>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261113185553.171059-1-toddfreed@meta.com>
References: <20261113185553.171059-1-toddfreed@meta.com>
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
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX/dTB1AVLshkA
 CGPIhBRtZXaf2gNJMWgVKH1pY3JifbIvceaCqcMg8lQloY/S/fBVGaQHJpxmwrtkmMf8ZPGSYPE
 2RziXRF5pgt0UcYqO9aq2srPaqLMI/Ua9syFSB0yjmGvdbnCppRAF2O5tKX1JngWQZ5ofC+ZofF
 XfGrcaAn4wPkcZZvH+jOAQfjgElgjSA6dJmhOR3EnsK8UcCrVXNwWpBYjQ07ZmWSd/wXB1fm8jN
 Ncy5aeD6AimEK7UGZG3ZEcVsvVW7/2mfnhB+taBeKh4Vo2jJn8LyaQUYVFQqD7mO1BqCvJxuyF/
 TXfq0vWpsZUSNAtl1x0e67pXbv6M5bY9h1va6Q9Iz8LbMNHBnE+753UhblPrYLQLq+S6Eh26Nzn
 KCy+k/UbbsXA+WBYDLnDt2pdWpj6GT0Jtt9nhc+iv8WUnph/7cybtjbMFaNP1xjNKIqWBc0qjR9
 LeMVPER/yu5qLzCI/OQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA3NSBTYWx0ZWRfX4c5LPZ4kjzqR
 LWRm+Y6OYj1FkzEyaLxihkiK+/Exc9f/7cVKnH08ficSqYfPWky2lEvlt3l+SYEEHlGyUMEbDWq
 GadTnLjtnB5CEcZ4kTr7d7mj/uOUyfs=
X-Authority-Analysis: v=2.4 cv=DuvDa2/+ c=1 sm=1 tr=0 ts=6af75d41 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VabnemYjAAAA:8 a=jdngVG28WKp3NRxkfb0A:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: PsL5oux0oVFQlN2YOdeSOUujfH5u8__b
X-Proofpoint-ORIG-GUID: PsL5oux0oVFQlN2YOdeSOUujfH5u8__b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01

On transmit, skb->decrypted means that the device must encrypt the
packet, e.g. a packet of a kTLS or PSP device offload socket.

On receive, skb->decrypted means that the device decrypted the packet,
and kTLS device offload trusts it as such (tls_device_decrypted()).

bpf_redirect() and bpf_clone_redirect() with BPF_F_INGRESS send the
packet to a device's receive path with the bit still set, where it claims
to have been decrypted by the device, although it was never encrypted.

In addition, the redirect drops the metadata dst (skb_scrub_packet()),
which will hold the Tx association for socket-less PSP offload in the
net-next series "psp: introduce socket-less associations".

Drop decrypted skbs which bpf redirects from egress to ingress, as mirred
does since the previous patch.

Fixes: 414776621d10 ("net/tls: prevent skb_orphan() from leaking TLS plain text with offload")
Signed-off-by: Todd Freed <toddfreed@meta.com>
---
 net/core/filter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 946b07a17fce..defbef3a9f75 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2226,6 +2226,16 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect(struct sk_buff *skb, struct net_device *dev,
 			  u32 flags)
 {
+	/*
+	 * On transmit, decrypted asks the device to encrypt the packet. Sent
+	 * to ingress, the packet would read as decrypted by the device.
+	 */
+	if (unlikely((flags & BPF_F_INGRESS) && !skb_at_tc_ingress(skb) &&
+		     skb_is_decrypted(skb))) {
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	if (dev_is_mac_header_xmit(dev))
 		return __bpf_redirect_common(skb, dev, flags);
 	else
-- 
2.53.1-Meta

