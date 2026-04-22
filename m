Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE863A16B1
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829044; cv=none; b=Htf7X4QtGOVsCOhBjO9axkCz72pwWoiqZRKBs1GX/F+uGWbpQ5xqAwk1qL/rmYUBReAQHW9k1wWHe3MRv+YUTMYidR41WrbT1/JflioXLuyeubEw+nnjjgj8tJnbsuwFZvACURl50Zk+y+YSnnzMqIKElpOAhn50667jpzMbjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829044; c=relaxed/simple;
	bh=G7AWuS0ukX1iLsuT9JRXb50DmeYwXhl5ye+VH4MAchk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xh++5WFlpE3TFqbdoxP52G1ha741iI3hkM3/74Rx5uS0pNnfaGVrh88o9rnRPvDLz8loppHjEf3L0PuUIUWGeAOVagycutigOf9cHwr6rFBs0BPlkDqXp9pqtcsQT6LfiSbQ6FYQ9aPehoGHoX9a7jWCy6N5ay67vPUIiUFtQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1bngkr5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1bngkr5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cf636dac8so2103850b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829041; x=1777433841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWN2JZ+naXQZkXRKjOmRteQ2UzIkItmXJUEjeeSbwOE=;
        b=B1bngkr5pCaCurkfF5WO6KnP8WgfLibqPTALjOkhkTLPVQjJ16VILPNJPMG1qbDYvc
         09vsw87uFsQVjd9sR5TzPe1+25ucArCCL18QB1GC0+FuFXAorDeZQB2T7D+HaywLxJN2
         mJo+/cow9UrDQjfhjqq0AEBzkYlK8r0sjoR+2Er6C4pWlYxgl3CSApMJFRaWFuwtWvuw
         W5ztJS9gxZK6DbWDLqBGKx8tuu81s//6wiqZaWxnOmb33Xohraxczj+uxep3S5caYoZr
         9le36gZu6ho9hD2/kgQ/JRdKvgNrZsxY8q9XJ9ZFKyOas1A6yRjD6N4csCI4Z2bL4csy
         jJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829041; x=1777433841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YWN2JZ+naXQZkXRKjOmRteQ2UzIkItmXJUEjeeSbwOE=;
        b=lcPQ46fIXAlbRwp4iLPVIgrwpjH91M7UN3JHPH0AclnQZbkM5Rp959G0kYzFBSOmuF
         8VpLYeyu8SMpStgl9ndanuCOhYk7Z3t0MuMUf5xNRZH/bWTHe05iuk2/LBZ7lWY4BdD8
         /CZrgkd0GDhhGiFkeGJCwp+HM34AaXEMibZfbCu9qyq9RtSp0TsL6ZIDNgWU40wnnbtF
         En9W1FoZumcO+T9rFKjfbzXoyj4KkuKeFgzc/8wk8XdWKHdLx/ldnebEs4rb2t2swHyL
         UvbJTdkpvELwvUcTwa0eKNT4Cd2YL+wGCm3F0qAQcmypMlLquJnYFHWwNhaEiljygGzu
         FFlA==
X-Gm-Message-State: AOJu0YyHF7z3F5N/onVKjmZP1rpMKbyNnDWPOFhkHkizkeCI2/ZtJznC
	9feOUozaX9lZwhL7SoUJYid2TZ1gikdoNRYof/ToUjKSGt1VhKro1x8J
X-Gm-Gg: AeBDiet/T+KALOLQ8UZ3Q6wQWB8fiZmIgF3jW3saPVYrioi0aCMpM54deeiySimgCzE
	aTL5IWYUaB6kG/vvj6wQmW4QNAR6Ch3jihoDXo5kcdLbBx7agIoef+Nh0EXPxbbLJ1/JPLwm0ZB
	dQ403sOR4o0+IAF5JW1ngSIM280sIwa7IMWqR3ESscOqsyiKfc8biF8wyxECiUxz0kI/zayiQOy
	JlcLu6/54ve/RBKfmylz06VeP+lGlm8LOQ5S+GeDXaAOX4gNcfuUIJa9zuWnHBU8luf3VYr5Q7E
	0YZzK2BgIDsM03Glrr0PiJbFp9OoDiIcK8xqQ1/T3cFrCF0Q9iBh2ZfhK5EciSWuqKrReD3fWqT
	iz0cE2Ojw2vp4GYrA7D9Y7SAOZLk6qW5GPXpX7u/6InePF6IqE5HQwe5m5R7Kh8A52AJk9uZOUW
	+oll0WjeJpQHz995+OCA7USj3quGX5WvJ9MIsTOg7XMpqZJK3fFSL9JaAngfl6wYkOnNURTEI3J
	4P0k/3L
X-Received: by 2002:a05:6a00:4512:b0:82c:e1a0:3453 with SMTP id d2e1a72fcca58-82f8c8fc39amr20671254b3a.26.1776829041112;
        Tue, 21 Apr 2026 20:37:21 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:20 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Wed, 22 Apr 2026 11:36:47 +0800
Message-Id: <20260422033650.68457-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260422033650.68457-1-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix it by explicitly adding kfree_skb() before returning back to its
caller.

How to reproduce it in virtio_net:
1. the current skb is the first one (which means no frag and xs->skb is
   NULL) and users enable metadata feature.
2. xsk_skb_metadata() returns a error code.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
4. there is no chance to free this skb anymore.

Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 88ec6d2cbbcf..c49b58199d2f 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -741,8 +741,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		skb_reserve(skb, hr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				kfree_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3

