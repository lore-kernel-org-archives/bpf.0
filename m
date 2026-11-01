Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560093;
	b=0p1aNTYlGoNbMYfxzuOru43p/l20TVbFHCp56TSioEen7h9Yeho0BphTE1VxveGl6EvH
	 uR4sIBrJrqoXItPR4+vwcu+3TI8fcZ4rYFU1abyVdklcqP3laRBo6JheWlrk6nToXGfQY
	 IXkE5PYhI4+x6gPH3nFBtzjm/AQSx0i4CzYJBJi6UwTBJqOCFUx7hGoX5/2kt2uNP9fxx
	 tXlyO5ZL8PclwScSmeYFO46bB2XZYnIK3O4EwOLfre/G+ewNp+XAWgeyIpyxDyFb2kfCM
	 B2bsNSOb5924kjUd1/uhIqYEpod7RB/dJJAluKzxlkb/ZiQ9aKT7jQtzhpfkRxVH1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CsiluyGRakOaR5XR/iwOkpZ9F8Pt5DmMJ649bbsv0P4=;
	b=u30DplSPBzxbt56awGKmshKp4KSu5NBwxavUYWBoB5CoBNLrvRLfXPyaOizwRzZVSMIi
	 NlvFfR+lLelX0KJk8F1cxZbWOIzxDHxSlQGvW1qJIZF1wzcyw9Z7cFpMZjAsd8io63as6
	 PXiMA2J3LKHNTRZZt7osgFhzjuoXldCtZDOrbSp/atoxaXBc0z6KODDQ+kekw8WQFoYyz
	 TyzHBG03LIop4miYP1wdyDivGYTTyPp4ShO49aGMPs8sKXw42neyTxyPaVFKZFnHwLGc5
	 Tncz8pYTHgB4DQ15Gj3IuPLO2oGDnElrzsRrXJVDOesfc9FaFYhac4KVAX2dOTTdx8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XGGHCLEj;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595AC606A329
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 595AC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XGGHCLEj
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1003413b3a.0
        for <bpf@vger.kernel.org>; Sun, 01 Nov 2026 11:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560093; x=1794164893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsiluyGRakOaR5XR/iwOkpZ9F8Pt5DmMJ649bbsv0P4=;
        b=XGGHCLEjqJcDufkOqs+RvbqCq5XLi8S6oCqlP6KunTPsd9oZ3IA+EZRpWrOLWmP98w
         0T+ocJ9sDCKUNfXi9ItWj+xvu+r1SMmiVONGLgnN55ootrVhWgR9BgepzoKnecIF4Hh8
         oTpzshXzp6gl2KBwASn3ecwv7Qv3I1HwzJ3WvxqP1XgzZAHZ7Xmj2ag0q1UwaTxS0nL2
         ufktKe/94uuNxD9e/3vIDacWO8lgJi8XEwzFjQI6tjcn1qVGSwUIV4kq0tHhqKQAjRog
         JHza95DVpCxgEPNFD59bhAb/Z3KNYWQWJnMDUJgEbSZtmCzEX+8eftxSDUuyBjlJnXnK
         V77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560093; x=1794164893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsiluyGRakOaR5XR/iwOkpZ9F8Pt5DmMJ649bbsv0P4=;
        b=l8YjLGM39YxgxuzQ2OJXwsV32iNF5WCDI01zlELG4coxH6RMQPbKIyvG8gibaDVCEN
         roqWlh8LMJ1sndBic1VNoHbVyz79yhAtxRygeUP1J4XKo8ooYO0G1LY6HbbHo9YeD5YE
         CA4Nsk3mUBkWVm9hV5kvVnV1S7+T1fMM7/4oe6/2KK9g9T5RDikrvjNYVxaYYdqm59N6
         aSxy9V0UOG8WEwYva+AFl5cYrQJCuFH891DW9btyteKTUhNafcOVLI8yK5LsONFjuI0B
         3Tn91TlCaKOQO03wsxinDt+LqLeG1Ioqrm6KsfxEyUvuf4Qqb1uWCK1udgR9qbhrF/Kh
         Z1eQ==
X-Gm-Message-State: AFq9FYLqEf84cFs08JWaNhgHxaTfttwcmpWHElwQB5BY4Nt8D3E3OXU/
	FV399qZPs7jGRvMHNFHESJ51VajFj/BzyJJTpotYytBdBImCrmSdJEvKB3fWuw==
X-Gm-Gg: AYBFou2M9r92eFuFLX+7kX3Y+9nUDF4rdNm/32yYrZh8hzoFVI1sxQuT3JkFy9Qapad
	3K6Dyr6JZj9UlfFse7HiUXjQjdejLFobM885wtDa6221bsZSvUAWwx6lKCJFTQZB+BoAqxv3hhJ
	AmxYFXyP1Ur1m9OprKzpSqlbByQIWL/23MAeuZk2ijLjryf0QgAHIC1SpmUyttyQ33fGTAUTEQD
	nve8UVujQzx3cc5LJPlZ+C7NCU4OjAPxgP0GxA9njquGz/tJnuEvSQ5GJKFoyh+mR2TVmLJaqi6
	QVGUFZgw0xr9VyK9ZgFJzgKUGcwkOfafPVsh8aZG+hrj0+Dp4MXUwVoZA/B5eq9otXjSl6wDeNz
	V7QtxXRxb8i4oayxutQDYG9+6GrOArXYTC6Tue9h/Z+ews6AkIt7RWEnVi6rA9SxSnFQyh3OPpj
	jLBu8U2inalKL6sIFeX1y1OVW7xZc97WHUXXSE05DFNSyepCmwNYppkD3ng3wCmHwtyztnDbc9Y
	LXnng/dB+91ALsAY0heRHCKtfBn8+a2bhl622e1qAj97NQxVmzvv1gdSnqsO/+amXlqNIgWWXmS
	EzWl1DVbITIhu01IeQOpVAFR+0Uc9y5D4gEezfpDcHVA/TfsUW8IdKLRmW9uzlAhwwqQR2Hx6Zc
	8StJQXYUoB7Aze/Xnd8oEMWe0oTXQLRPbjiw+rt58jM31bbG1fS4sr2uwiRmL2vXHC/5YgrhonQ
	==
X-Received: by 2002:a05:6a00:44c9:b0:8a0:3ed7:93a2 with SMTP id d2e1a72fcca58-8a9bffd2a04mr6480051b3a.52.1793560092552;
        Sun, 01 Nov 2026 11:08:12 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada9ae2b7sm1197731b3a.51.2026.11.01.11.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:08:12 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf 26/27] bpf: Use the inner transport header after a decap
Date: Sun,  1 Nov 2026 19:05:34 +0000
Message-ID: <20261101190535.1454146-27-alexei.starovoitov@gmail.com>
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

If skb->encapsulation is set, qdisc_pkt_len_segs_init() reads the TCP
header of a GSO packet at skb->inner_transport_header. Otherwise it uses
skb->transport_header. A decap with BPF_F_ADJ_ROOM_DECAP_L4_{GRE,UDP}
removes the outer transport header. It clears skb->encapsulation if no
tunnel flag remains in gso_type. The result in BPF_ADJ_ROOM_MAC mode is:

  before  | MAC | outer IP | GRE | inner IP | TCP | payload
          transport_header ^                ^ inner_transport_header
  after                    | MAC | inner IP | TCP | payload
                transport_header ^          ^ inner_transport_header

Then qdisc_pkt_len_segs_init() reads the inner IP header as a TCP header.
Thus the kernel can drop a valid packet with SKB_DROP_REASON_SKB_BAD_GSO.

Copy skb->inner_transport_header to skb->transport_header when a decap
clears skb->encapsulation. Keep skb->transport_header if it is larger. This
occurs if nothing sets the inner field. At tc ingress nothing changes for
IPIP or GRO packets. Both fields are at the TCP header there.

Fixes: ec20dee2f2c4 ("bpf: Clear decap state on skb_adjust_room shrink path")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b5534dac9e6d..21fcdc7cd950 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3769,6 +3769,25 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	return 0;
 }
 
+/*
+ * Code that went by the inner transport header while skb->encapsulation was set
+ * goes by the transport header from now on. So take the inner one over, unless
+ * it is the smaller one, as it is if nobody has set it. Do not leave the result
+ * in front of @off, where the bytes were removed.
+ */
+static void bpf_skb_clear_encap(struct sk_buff *skb, u32 off)
+{
+	int thoff;
+
+	if (!skb->encapsulation)
+		return;
+
+	thoff = max(skb->inner_transport_header, skb->transport_header) -
+		skb_headroom(skb);
+	skb_set_transport_header(skb, max_t(int, thoff, off));
+	skb->encapsulation = 0;
+}
+
 static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 			      u64 flags)
 {
@@ -3850,8 +3869,7 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 						  SKB_GSO_IPXIP4 |
 						  SKB_GSO_IPXIP6 |
 						  SKB_GSO_ESP)))
-				if (skb->encapsulation)
-					skb->encapsulation = 0;
+				bpf_skb_clear_encap(skb, off);
 		}
 
 		/* Header must be checked, and gso_segs recomputed. */
@@ -3859,10 +3877,9 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 		shinfo->gso_segs = 0;
 	} else {
 		/* For non-GSO packets, clear encapsulation if decap flags are set */
-		if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
-			      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
-		    skb->encapsulation)
-			skb->encapsulation = 0;
+		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
+			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
+			bpf_skb_clear_encap(skb, off);
 	}
 
 	return 0;
-- 
2.55.0

