Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560058;
	b=a5xr0QAUUu/K6lE3yVkpmJkHSX6BuUMyFdTeqRmFGs0jK+tjq9yulwWbP7aKDlhschlv
	 EPVFtfSxlN4Uq4v3aVNSP1Op2YjnYPHRRsESc6fuQjBlY5W+WNtIfjbCS/XpE0etnBzce
	 cXasxuhpISzAHUJSYu5qt0BakeI7xuRxYZYs9SrBlC8VfD9yPv65wo/LlJsA/VymFWrw/
	 XA52xXQQM1ohDt3Y9Cei76PGKcXTl+OQY4BCr1EmelvFd+eoF0e+3Td2ijXqRaayDwdu8
	 r/01FTXCB1dv2lceznRgwNBQ3pyu/lYKuu4RDkBiUF+4D2NCWAHYCezG1CND8kQDA7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560058;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7n8cUaqxFhQWXQkEgvZFG+kad+FLs0qFtiPFQN8FGS4=;
	b=R9DAOauo9dzs3o9n4ZGi6mVJ9ZvmUE+0wuVGu2/hFkXE1b3wwqnLCTkrpTUfZj895Hl4
	 InbwYsi1EBUlCBBBTH2ZiWh+ZmXInYNZ51EHqwWKi3SzBN+cVpObURX6RBRmwtcHt0796
	 YxfjMRVEPmmMk1RKqP0XTrz1Eamd369PFJeNiwjhbWRFuZ+cLJbvCwSAdwcZSkcaWmAZO
	 7qXnOTVnKTEjY7CzRePZUUV09IffsvK/LpMckmIq+hJZzK3o8L2yQ5AxpeHgpqUSHruow
	 j5AcdKPPHc/bMq2T37zv7uEquJ7EkX3Jdlmn3gdD2oob0H44/83rRoKhwDyGs3VwjfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E1YvriMw;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF3606A32E
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBCF3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E1YvriMw
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2004373a91.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560057; x=1794164857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7n8cUaqxFhQWXQkEgvZFG+kad+FLs0qFtiPFQN8FGS4=;
        b=E1YvriMwk7EJTn53X6lsRhsV7aCFxJMJVBOcJvk3YMFWZr52fCrTUqE0j7pGvW0Huu
         egtw/Oy6j6IFha95Pzx9y2JvLrK3Oc9Kn1WQ5Ki+8wsX/CNmjeJ97ZkHi2yNiVYSfoZb
         +PMI6ChC4QJRabYC7xEXfaQRDQ9VT5M8YiIsAUyJiGXW7/E2b+Jz+hSwzXDlhvV0pIrc
         vwhWb/dFdjk7h1sDdpiuJbgc4E1g8tB1xGuP6GHI2GucArI4n2tYtYgusH52EYqrvTJ+
         H/y13pr4k7hsShVILiC1vtlZjrsfbVPxCBwYAZemkvTz80oRkkdrhDm0kfVZz1M33dmb
         YlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560057; x=1794164857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7n8cUaqxFhQWXQkEgvZFG+kad+FLs0qFtiPFQN8FGS4=;
        b=ZUsK2SxMwKyrZwnaOfxUIYS7faCyFNo3OQ+y5jUWFxNujUPU+B67zxKVD0zibabQm9
         EaxLDLQ4XI+nZHKdRCROq1jdSHU54oUYjg7K8qS+ZjBMAPOYxg7TQ6qbNVVGbLiABLAv
         PYcSW2wuK1h8l0UHcL1dLAnPCC3CvIRPeOd9gE7I+K/UIiME5FjwdWLcO/RQxBzDb6NB
         mU8XT8wI2bs97ZC34vjwIctim8O3alSLePSZrmx4D3X1lB/q3MmibB8rDhWiZu7R4+Wl
         0QBMwAwT28A2Uml9d8P/B83fshw+QcJ09nasjj5i93spzHFZHhmKJxLjTu1KRglpJY/K
         Crkw==
X-Gm-Message-State: APuU4Z+cD/4vpD15uE01PCb7cvTJk2FzRbPp24R8EK5Y3ZYTahV6/X0w
	nwCirYNnYfJACKuZOslz6mg+aUz6POxu3Ug1mfMApGlIJxdBCfbVc9MJHxaHnw==
X-Gm-Gg: AYBFou0iCNuGpKXiyCswvwXBn0QwQOXmRDNYaloHR1/116Vst4a0KaO1kvXHss6NMte
	UEgkr4jjl50gcfOvYR8Lr44rPJRBvXpXelVyh6rMSV346jjb7A7k7GkOLVPOpcyVFz3tB/QwIyM
	nvTRjEN0DW7V3cZUAI2iJYtxO3wSa/vX+xWgJEx0s8TGc61WS1nOwSXSfKdobUpDpUzIBLLiqOw
	2G9H0Tlc3wKOjge/uHNObqoTtFUben+DUeyxBxLj4eaWq/dbcu4Bs2AXHj1dZ7mlJeEVGamu4st
	gP4cg48CyaK8AEdSgqxjZknezZy08WaoF20ASgT4miwaXVNqYTL8O96p4e3SlMDy/NXU7tX45G0
	eh9Bj8BykqBS4mdT/jbVtiC1oVh21e1MzhopbcCuwGu0Cvx6zLyFeNm0irQ17oA1xUBouK6bRL/
	lg8qFVykcRQKhX7KckN9t3Ef70OBT4AUDbnQTklzvMsG0J+BdPWwtVWMshP7izdh66R1q41l4pM
	tOkR/Opvaz4HirRxyc8DGNZWc+lT07PXDIn3L+iuylOsbv8AxjVZCjeOeh0eptKUsccvMARdzAe
	09+XSDvAL0pwmYRmyw1p/BnymF4PjB5Q7wo8EJeBvWneguY3CF94YVgGUat8EYfC9tZJ4IGw2WX
	cNOK7Y3bhUg4PWbQmSuoGoSK717/GpWrQMnKd/4S1tP8ZqPNxoap7Mv9MapJcYuNo028PJCb0m0
	PZ4W1Tg5+xQ7y+YmW++9M=
X-Received: by 2002:a17:90b:3ec7:b0:3ac:7406:b49 with SMTP id 98e67ed59e1d1-3ae896d7a1cmr4261108a91.15.1793560057197;
        Sun, 01 Nov 2026 11:07:37 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm15312573a91.8.2026.11.01.11.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:07:36 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 20/27] bpf: Move the MAC header in bpf_lwt_seg6_adjust_srh()
Date: Sun,  1 Nov 2026 19:05:28 +0000
Message-ID: <20261101190535.1454146-21-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

bpf_skb_net_hdr_push() and bpf_skb_net_hdr_pop() change skb->data and
skb->mac_header by len. That is correct in a tc prog, where skb->data is
the MAC header. But bpf_lwt_seg6_adjust_srh() calls them in an End.BPF
prog, where skb->data is the network header. The MAC header does not move:

  before push  |       free       | MAC header   | IPv6 | SRH | payload
               ^ head             ^ mac_header   ^ data
  today        |       free       | MAC h| IPv6 | SRH   + len | payload
               ^ head     ^ mac_header   ^ data
  this patch   |   free   | MAC header   | IPv6 | SRH   + len | payload
               ^ head     ^ mac_header   ^ data

Users of skb_mac_header() get incorrect bytes until __dev_queue_xmit() sets
skb->mac_header again. skb_cow_head() reserves only len bytes. Thus the
16-bit offset skb->mac_header can wrap. A push also changes the "not set"
value. In both cases skb_mac_header() points after the skb.

Move the MAC header too. Pass len + skb->mac_len to skb_cow_head(). Keep
the "not set" value. The second Fixes tag is for this case. Since that
commit an End.BPF prog can get an skb with skb->mac_header not set.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Fixes: 20a081b7984c ("seg6: add VRF support for SRv6 End.DT6 behavior")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index d634850a38c7..482f8132d9ca 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7159,6 +7159,7 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
+	bool mac_set = skb_mac_header_was_set(skb);
 	struct ipv6_sr_hdr *srh = srh_state->srh;
 	void *srh_end, *srh_tlvs, *ptr;
 	struct ipv6hdr *hdr;
@@ -7184,20 +7185,38 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff *, skb, u32, offset,
 	if (unlikely(len > (U8_MAX << 3) - srh_state->hdrlen))
 		return -EFAULT;
 
+	/*
+	 * skb->data is the network header here. The MAC header is in front of
+	 * it, so bpf_skb_net_hdr_push() and bpf_skb_net_hdr_pop() do not move
+	 * it with the other headers.
+	 */
 	if (len > 0) {
-		ret = skb_cow_head(skb, len);
+		ret = skb_cow_head(skb, len + skb->mac_len);
 		if (unlikely(ret < 0))
 			return ret;
 
+		/* The push can write over the MAC header, so move it first. */
+		if (mac_set)
+			memmove(skb->data - len - skb->mac_len,
+				skb_mac_header(skb), skb->mac_len);
 		ret = bpf_skb_net_hdr_push(skb, offset, len);
 	} else {
 		ret = bpf_skb_net_hdr_pop(skb, offset, -1 * len);
+		/* The pop has added -len to skb->mac_header. */
+		if (likely(!ret) && mac_set)
+			memmove(skb->data - skb->mac_len,
+				skb_mac_header(skb) + len, skb->mac_len);
 	}
 
 	bpf_compute_data_pointers(skb);
 	if (unlikely(ret < 0))
 		return ret;
 
+	if (mac_set)
+		skb_set_mac_header(skb, -skb->mac_len);
+	else
+		skb_unset_mac_header(skb);
+
 	hdr = (struct ipv6hdr *)skb->data;
 	hdr->payload_len = htons(skb->len - sizeof(struct ipv6hdr));
 
-- 
2.55.0

