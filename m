Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A184A093F
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306641; cv=none; b=g9vGMnNuyZzIfSd2UkwOGWXkceJiq0jfPI2fiHGO3vEqTvTlfLl/O4L3VOa4Z868zQEJFlBR/4ub+k8pZnLa4zFJW4IofFdRLQ0jD4Oda5cbD1uzu/s9jDA8zm3Bd+ul3vdWJntzCY5E6LmRibpX50OYDfzQI29jxWB2hQiWFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306641; c=relaxed/simple;
	bh=LvUip6sg4zC8MHIDQcH+Q74Y1I2oBLSsqvHL1CWpu/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ljlyjCeu0JllzUFfcBT1I1+mfMrVIOtYzoxOUtSAQ9UJlfcwGHWulo9NmrTmvPn0KowMZsxgsY2WTM/SdX2sM8MssL1NQ3qm8yqukKm/NNS8cbb4lstxeHzTXWoCgzIDcQq+7qss8E5OxTHYkbWtwTsFfeo+s72XCLECjhgyzVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=b8OYYecO; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="b8OYYecO"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917a2800e83so38482826d6.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306640; x=1791911440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRSEhk/ukaPGF86WvMny5m3lspAeG/UVjcvU5kzCm7o=;
        b=b8OYYecOtG/8i5dvazzj0vmoFLeyzR5reQy5KVB8l9JQbt0dqq8XP1P1s7/0Zrt6yN
         WK5WL0gXqNCx52PakfPPWjv2Ze8blvJTXLIZMJc9KsetOaVlFo16XpiQf6twuCNUhUdQ
         90VO4pAhkZIPMcAZs2ZZ8aKpKR7q2UKMIu2djNtwTSAGVWsYeLmW0TEHAf0ppNlSDeyS
         +DQZ5mvqwnXdym2YpLbODcE8sr7stvYQs0M9dUScc49n5UN0Lwjx8/VMOpFh/8GivJr6
         7vpbkXdtiZRsGdohgdW2r7Kzm35SdzB9xTv25ax2IonGfAU4jA9OopwS1Y4m4tRuc3SV
         RKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306640; x=1791911440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IRSEhk/ukaPGF86WvMny5m3lspAeG/UVjcvU5kzCm7o=;
        b=RCckCoVSqTYLJKtoqjbDs54iw/U7IeBCRVA6YPPPvQnAWGEx9whPzlO/+KXJqztTQY
         5FVtd/KhkrsH2mCH50efJnBKjjZUU8kG0xOAks/l3BPceQ82e1J5K4ODGKjNxpM8eAF8
         zg1mswFQ9RP8rakeqWNWLJB3c/mwgQGqla/1qvymg5ph9/WrtNNJt5VYvDxZSbhqzVXq
         DzgvOdS4Mzyjb5K52iJG6+h2yAid9YCk/gfmgiSA36MBBtitzqhl/t3C9he7r9x9onBt
         dK/shUpaspZEN3U0rCQKcoNEazm7FGsbCouhBCXzHBfVW8Q4Bi/xMWLBt6Cf/w/akRM5
         MQZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzigmY59gWUwhfbkQvwLpQI3s3YCi2GHHC77t8czdfTDWF1U1beWW+SYJM4Dr334NaZC8U=@vger.kernel.org
X-Gm-Message-State: AFuF++l8LodMXyDjKpLzDJmm1NdK+p7ueZwWWNroa3GReH0YRWOf7i5k
	yn/bK/th7slcwdX7uqnHHnGSLZBBLyNZiOwmRLO4xpvKYhz0jFiA+Gfx7EkyRX9JYPtu67/KP5E
	GpzFk
X-Gm-Gg: AYBFou2W12L8H/hhnKGIPPtmPbLnCzfBjlUhi2PPkoAeX6b5CLOOqcduBR8RvOTaR9W
	wuZNB5dwdyxhdMwO1P2X8M6+XooB1GTFtTTJJiEViKfoYN+UX0GNRgUg7BDLfrIzPsKhDkyAAdv
	nbEMRfQbe4MHSxuclTteYb58KzSxVia5CC+7I8EZm3dVrYDQmZ+f1ZafvjJLOILbnmpONib1reo
	Aw8kkImicYz0fvgX8GYWjW7pQRzKtgB2u3mwGHIkshC5p9kLXIfdkpdR+EeYbC1u1wezyDRq98v
	GzKtpJ4Fyw1So5/XzYr+JvKUHHziJzua5TAM7iNVxT5O+Jp02i4TyGebelzIRV0v8i2zT8NZMvX
	UCLhkCUs5G1gW2+IuQrRMncZbQtfumKz8ICtInqwuiawvR6Cnb9/Dfvexb9jOQFJ/LAEOEGj4LG
	C1wXp9eB6EQGE3KjomIuqkBtGjfwLWHjBaAEBu7/IVpft2sy2PcY3RC/dWw49cbSNeKMWkPN/tU
	srsmBQtkH8/IVU=
X-Received: by 2002:a05:620a:6914:b0:93e:9808:b9e3 with SMTP id af79cd13be357-93e9808be3bmr95038885a.72.1791306639172;
        Tue, 06 Oct 2026 10:10:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0bd29b1sm117233516d6.34.2026.10.06.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:38 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:16 +0000
Subject: [PATCH net-next 1/9] net: skbuff: don't leave stale bytes in
 skb_copy_and_csum_bits()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-1-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=1482;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=LvUip6sg4zC8MHIDQcH+Q74Y1I2oBLSsqvHL1CWpu/c=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDmkAUy8kW3bakdV4LNq46AXJrMyBElWpcUZtAqWSXkkZAnpkvnxX0s6FBBSWcXGzGVtOhKQ1lX
 yTbXr2FmIgw4=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When skb_copy_and_csum_bits() reaches unreadable frags it returns 0
after copying only the linear part, and the rest of the caller's buffer
is left as it was.  The callers copy into a buffer that is about to go
out on the wire: an ICMP error quoting the offending packet, or a
driver's TX bounce buffer in skb_copy_and_csum_dev().  Neither buffer
is zeroed beforehand, so whatever was in memory there gets sent.

Zero the part of the buffer we didn't fill.  The checksum is already
wrong in this case, so the packet still gets dropped by the receiver,
it just doesn't carry anything it shouldn't.  Only zero for a positive
@len, a negative one from a broken caller must not turn into a huge
memset().

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5c4024a03e10..512ff9cfa269 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3633,8 +3633,12 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		pos	= copy;
 	}
 
-	if (!skb_frags_readable(skb))
+	if (!skb_frags_readable(skb)) {
+		/* Don't hand the caller a buffer with stale bytes in it. */
+		if (len > 0)
+			memset(to, 0, len);
 		return 0;
+	}
 
 	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 		int end;

-- 
2.55.0

