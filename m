Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560088;
	b=0UWv/r9mKgavX1a0Kb9t0oKg6gs4RlVzAorprRHzf3EdNdSDq2BrNluO0eP2ZxTWMepM
	 X3k0jwsrDMvmjfOvrKkxytzhYXt/t8Sup1Y7JW96tGZMOL3vcVwyegYahEO9A9CM9msQQ
	 U+I4bf2ga0L0+vDaFmKmwAkZTHBHSeKnVNAy75YXvelvGYXBLU6/gB0B6op5Cnzqu9oSj
	 VRR4jg9U9ICRxuH0MG89HcRW/qRFNz6+G008K2npEb+BUqsznowS4DSxGPhHsd6iFU0dj
	 kFic5CcAKjVuV3o/xtOYEXrNExH4I8HaHakhZakkVR4HmunAPAypjcphC+tagK7JbBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wkl7nbJjUYkjmR9GkvrhAr2KnFHGVn1sGfjd6swsByM=;
	b=FMI5E78nWHX+yHuVKcQlv+mcWH+rCTm9HO+4F5XVKDB3CDa8w4fodPd13L99zjFyaXy3
	 IEgY9L8oSjVMC6qULp2KGe5jDXA5kT5heW6vgtUqCQ7PbQozaSmpxNQvSCK/dAnSOqAQR
	 zO6CpIc3V8RgydG444hakn7ubLKxc5/n+WqwYGyMC0FozNUNIAA/G59w3IK+oGni51yhF
	 wzcZuT7hUJ1KdkQcwONcgvc0lhPN79gwPzs9AFTGvD6YwzF4OMnR/Qu//aww6hmHEi365
	 wGOvGQeozYe8kJK5XMsRaFddgbs3ArT38nTKbIiuIdUmAfXx2qsojkUXPvMrRkBFJ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xU+v0kN2;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFC606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98BFC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xU+v0kN2
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so964103b3a.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560087; x=1794164887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wkl7nbJjUYkjmR9GkvrhAr2KnFHGVn1sGfjd6swsByM=;
        b=xU+v0kN2urTTiE52q3c+Ez35BELEe2U80RHemX9c4pLzsbjGS7oXqwBObe25+6xEFH
         8cEtcJFlW29ZoaGfqejuyCMjAOtLRiZUcaILwxW1UUg8JDhNg315Pnww2RTUbw2b9P3+
         Ic3IlyfoWJeepZpM3u3umUTggMPgnZ+YI7LXziJilCD7O5Oxfx48Z9JaJ8wydMmFHxIs
         LcKbNkJvRxXLZZ4uS6FpWuXn7sqrQAhGZtomrZtSzce+eDggU7Ye3mWchhBs4morVF3s
         Fl7XoSZJz4tFsdoA9Tm9SUrJOOopPAWvxukTc0azkVmwDObsPYDYuMJ0mF7i/vLg1c9T
         HtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560087; x=1794164887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wkl7nbJjUYkjmR9GkvrhAr2KnFHGVn1sGfjd6swsByM=;
        b=n7nRBnbO3yD8JjaSZQqHOpC3jz0OxAVgbEIk6nBRuQzRwgnhFc35MtdNmrDKhHPLBu
         /Lb5gV7RWyh54Kb6ox+Bg4ZcxVZj+pvqUhX7AlC0nlsbuumH2t0h/lNZ4QRVCtc153FP
         98LltNAxFjnSC0+/i6xIJzNgL7TwgosjhqSbx4I1Xm+h4ks8sdXFgYG7lfBjYH052KF6
         MhAs8sSh3omsaJKfiWvbhIgVulB13idBwT9j5KDYhKAZ9bgiIWtpAITuLiVRTY+ktBVg
         vak14Gs1tHss+1WWj01yQsKJOZyZfvnBvSCkVEdIsknFsjSJEF8catQD6nzZ8PRtMEvx
         gEwg==
X-Gm-Message-State: APuU4Z8jxODed0iUYbRMifSwMsSNxUcE5D1N0E7OYVE4MaW2IJM8prPd
	Eiylhn75EQX9z1VdynaTWBFPlU8bakneA5fsEocUtx7yDRzWMTg8e7y2Wglzcw==
X-Gm-Gg: AYBFou3UJAMMdGkRG2IclzluNpMqCk2M43OR2ukbmQ5EGMkyV2gXe2M1bynpRvoA3HK
	xO9droTpMIdYzY8DXUnlS+bBAiankHKxHBBEYhhizuKVHcPnNY7hwKvTfjq/UID1VCxeDbdfLL1
	0EKaGlX/vKItxI8vTZLap7G7D0UKkeUy6pSue6ANFSDKsPFA+oNxPhvtUawuSmmQdlpdL9/1nXu
	SsQvstSIYo9JVMz723f8nDXZ9eOW4EPHjbNSnyhTh4vhiKggbzU8mu5yOJnwhdkLXNNO9H3lGyg
	gNERCj/wok55GMzqWQx7yDkEg5NDBH8Hdxi/DGg2YYuau7Q+BO1768acPpceek38c7T2fjt44Ju
	EoFDvSuzKkaqszUez1j+u9Y0JreHh5Ev/WOshSEjFpEaTlpRJtPiudAxWBxB008MZbVIKFY1wnJ
	C9T/9lCHm3MBDuCtvqANoofb1S/KefyWOW2o6ZB0ZwaHp7alZoNVNh5kk5+4spLe3s6qSxgzx0W
	klha6giZVw1dNZi0L7eU+p9hwwsniR8dC0e3klSlQdaE9muXxkKcXRGkIvJETePj/l/2A17JWD8
	C4T6OeU9bY6cEiwEG2fRhGe9HHczzRnEAl/n67F43IRb3LFiPhtHFOyXHi4Ick9DE7YZlcrrHft
	s0M2su+7ky1m50A1NF0BMloo8XeQVmus0cPT8FvMXLaxI2E97claPqCbWPtiqybu2TOnEORkoQs
	U=
X-Received: by 2002:a17:90b:1644:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae897c94ddmr6924519a91.47.1793560086712;
        Sun, 01 Nov 2026 11:08:06 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85d24261sm6408578a91.0.2026.11.01.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:08:06 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 25/27] bpf: Move the transport header with the moved headers
Date: Sun,  1 Nov 2026 19:05:33 +0000
Message-ID: <20261101190535.1454146-26-alexei.starovoitov@gmail.com>
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

bpf_skb_net_hdr_pop() removes len bytes at offset off.
bpf_skb_net_hdr_push() does the opposite.

           skb->data       off
  before   | A             | removed | B            |
  after              | A             | B            |
                     skb->data       off

mac_header and network_header move with A. transport_header moves only when
it is equal to network_header. inner_transport_header never moves. This is
correct only for a header in B. In bpf_lwt_seg6_adjust_srh()
transport_header is in A. bpf_skb_adjust_room() can remove both transport
headers. With an incorrect header offset, the stack can drop the skb or
read outside of it.

Also move transport_header with A when it is in A. Set it to offset off
when it is in the removed bytes. In BPF_ADJ_ROOM_MAC mode it is then equal
to network_header. Do not unset it, because skb_gso_validate_mac_len() uses
it without a check. After a removal, set inner_transport_header to off when
it is not in B and skb->encapsulation is set. A has only outer headers.

Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
Fixes: 868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 08168ea381c2..b5534dac9e6d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3402,9 +3402,25 @@ static int bpf_skb_generic_pop(struct sk_buff *skb, u32 off, u32 len)
 	return 0;
 }
 
+/*
+ * bpf_skb_net_hdr_push() inserts bytes at @off, bpf_skb_net_hdr_pop() removes
+ * bytes at @off. Both move the bytes in front of @off together with skb->data,
+ * and leave the rest of the packet where it is. Return true if the transport
+ * header is in the part that moves. A transport header that is equal to the
+ * network header stays equal to it.
+ */
+static bool bpf_skb_trans_hdr_moves(const struct sk_buff *skb, u32 off)
+{
+	if (skb->transport_header == skb->network_header)
+		return true;
+
+	return skb_transport_header_was_set(skb) &&
+	       (u32)skb_transport_offset(skb) < off;
+}
+
 static int bpf_skb_net_hdr_push(struct sk_buff *skb, u32 off, u32 len)
 {
-	bool trans_same = skb->transport_header == skb->network_header;
+	bool trans_moves = bpf_skb_trans_hdr_moves(skb, off);
 	int ret;
 
 	/* There's no need for __skb_push()/__skb_pull() pair to
@@ -3415,8 +3431,8 @@ static int bpf_skb_net_hdr_push(struct sk_buff *skb, u32 off, u32 len)
 	if (likely(!ret)) {
 		skb->mac_header -= len;
 		skb->network_header -= len;
-		if (trans_same)
-			skb->transport_header = skb->network_header;
+		if (trans_moves)
+			skb->transport_header -= len;
 	}
 
 	return ret;
@@ -3424,7 +3440,7 @@ static int bpf_skb_net_hdr_push(struct sk_buff *skb, u32 off, u32 len)
 
 static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 {
-	bool trans_same = skb->transport_header == skb->network_header;
+	bool trans_moves = bpf_skb_trans_hdr_moves(skb, off);
 	int ret;
 
 	/* Same here, __skb_push()/__skb_pull() pair not needed. */
@@ -3432,8 +3448,17 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 	if (likely(!ret)) {
 		skb->mac_header += len;
 		skb->network_header += len;
-		if (trans_same)
-			skb->transport_header = skb->network_header;
+		if (trans_moves) {
+			skb->transport_header += len;
+		} else if (skb_transport_header_was_set(skb) &&
+			   skb_transport_offset(skb) < (int)off) {
+			/* It was in the removed bytes or before skb->data. */
+			skb_set_transport_header(skb, off);
+		}
+		/* Do not leave the inner transport header in front of @off. */
+		if (skb->encapsulation &&
+		    skb_inner_transport_offset(skb) < (int)off)
+			skb_set_inner_transport_header(skb, off);
 	}
 
 	return ret;
-- 
2.55.0

