Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED333B6F1
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 14:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789828748; cv=none; b=j/lduAadpM+j+DwX9XmGHr1DHGwv3N+XxZh+TZVmowvFnt1StDzwaDtGA1/Gz9Yia22ACfPYqZ86ZBPZOfKVyDrKigMLadRncNEwkkkyLkHoWO+Eguq+/Xh+p1JPidWOFJ5iviaU06l5Pvi3orGBx6isU+rU3KxSSO/3OWposXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789828748; c=relaxed/simple;
	bh=8qshW2SBsF+mneC5peJCCB0WVtFWPHXeNnAN5DnqVdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S13XBLbikIYXXQSNrYCwk5ZQmep+Mf6/9sqq0voGmJ7i5sXJWdfsHnoCJJfKAB3cQ8xyHPfT7/v1VvPA7Wg+GLV5mC0tE2A+ZtjLun3MRlbvLJA/0nVPmCSX2M+tOqhjfi0BlIvpLu3/UrzkTa6AbNi8o+1VW7UYdVqr4yUGJ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOtafYVK; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOtafYVK"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db18fe433fso14504955ad.2
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789828746; x=1790433546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g43Q1PLOpWagEyIVtUa+NG+AMJzkIawzi7JK4B163vM=;
        b=DOtafYVKoxyNQOUqqxB6L5GyICZXv4+SJHYutuadJsNKobdasSmsGji/DSDqu7fT90
         IFaLocW+Vs16R5apAoeHvCAFcUg4pM2uDZiCbl2AjV36pW9Csnfhi8bk88S3Y2auGdP/
         NQkfwCv2qs6xHOw05e428G51ulVGi7yy+t/QW3iPaz1JfN5qeJgR+kLGwBd5LDCHOvD4
         LPIy8+1Z/uPGUp9YuG6pIIlWMPnr2sPffLtSQs+X1VCcY+2Ux3Ab6I+OLHCo6Ve0vc0/
         Sh9xVv819vPYaeYfbslAWSkCIPxwUHwWx8mCOPrCL+J8UIQPniY+1hQw7jFKL2ce0aba
         nYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789828746; x=1790433546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g43Q1PLOpWagEyIVtUa+NG+AMJzkIawzi7JK4B163vM=;
        b=YSNwoV0x1uHpawcicPRmENLf7YPUViPXpdoWTy726tbsWAieA3bB4B+dJBkH/w9RU8
         OSqafzx3fVue4LjfC2sZDrOwPqgc8R7anov1I55o3OCmUME0sSTmo016CBjpB1Js5yd0
         hESkdanNc3+wuDyWYgaFMPbWE0zyLEedj7/ExnK8j87gOUBWK/W4Cm/JahyW5tiVn8pm
         Ilbx2RhPzSyoK8yuxIpWajwc/rqVrskrcj4Ks1v1QBRJpSvdaOuso+NhkD5L5H/kEK6P
         7kSPxxkAxLBLzAeFakOCnU6e2Lrq6j29zKZoHC1lI5GHIGFuwi4MIml8nhManDKhO5AV
         e+wg==
X-Forwarded-Encrypted: i=1; AKwUvByoqSUbb8j13uQzRONJ0nkAg/o8x44zBRb7Ju6J/grCFhMVSpOfQhzTGDrLE8sJaOIWayk=@vger.kernel.org
X-Gm-Message-State: AFuF++kqsjvDS4J3s4F5qb8R7UwR8HCj6VrjINm31iYldzIS8TOk54aL
	RcvI7DaXdWJGtpqWXRYGLsylijTYPUSNRJjaoKAMVaRDY+oSpTZdnj7Z
X-Gm-Gg: AYBFou2RaRqtAAnDXL7Tfl715Kbg9Ec3uz3JZNSANmidj6b4aUnzCX8uAN4+hcaiGm9
	1VlquNrqlLYPg6h6sW/oBipUpxSu7MGi4CspnEW1wi9j8pxbDBNNygh92f750yGPeg+qm5fbzwX
	wL7c9Kvt1tHF18BhEBGcZAx5l6N3+qUAAW5YcrU7nqkbkoQHnz1jkvId2ErT2ElPSoe96Lk+JAj
	8CiSb4hE0Zf++599Kmx78n+Gt+Uydnk8EenIs3rmQjzh1PYLvhiQ3mFK5eG+vwh07YLi/Ni2rYC
	/OGcAae5aDGxWGV7Vg8ThCZ4il7pEZ2TF3Nl2HyMZpFSHd4ScOdLAXuZp7cvUC96HDmkWlzsViD
	Ct0pL70UsRQ202nYdP67NHPJMb5Y2AWr4fBsMf2xcxgbQMDXJaGNkBWkrkfTmBA+6F8SARPynUn
	MzUmkHQm/GJiWxOxMYOFjSt0z9gskK3E3FmtAjgpKpe1ruFTyK6Y4Fh2zRmcD9Yf/Oan3j0ksXb
	Anbhx900YjqFnXIrp+TcoJdb6iJy4Yg/QNoS7oNqfc3IgGEqvjjdA/pgfG9LuEoaPjH+83Unuvl
	rICwku8Y72uQuzBuNfIjxNwXcrfnbOTtYk+TAU+aBQGhEcf/6g27rp3AsVY=
X-Received: by 2002:a17:903:4b2d:b0:2dd:c053:c20d with SMTP id d9443c01a7336-2ddc053c2e9mr42673535ad.41.1789828746100;
        Sat, 19 Sep 2026 07:39:06 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179ed79sm10711715ad.43.2026.09.19.07.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 07:39:04 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RFC net-next 5/9] net-timestamp: use pskb_copy to avoid polluting the orig skb's start time
Date: Sat, 19 Sep 2026 22:37:28 +0800
Message-Id: <20260919143732.11772-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260919143732.11772-1-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When BPF Timestamping V2 is active, start_time is stored in the
skb_shared_hwtstamps union alongside hwtstamp. In __skb_tstamp_tx(), the
!tsonly path uses skb_clone() to create the error-queue skb, which shares
skb_shared_info with the original.

If net timestamping feature and BPF timestamping v2 are both enabled,
When the driver reports a hardware TX timestamp, the subsequent write

    *skb_hwtstamps(skb) = *hwtstamps;

clobbers start_time on the retransmit-queue original through the shared
memory, corrupting the value seen by later BPF hooks and retransmissions.

Apply pskb_copy() instead of skb_clone() in this case. Then pskb_copy()
gives the error-queue skb its own skb_shared_info while still sharing
page frags.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/skbuff.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..44aeea713da7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5749,7 +5749,10 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 #endif
 			skb = alloc_skb(0, GFP_ATOMIC);
 	} else {
-		skb = skb_clone(orig_skb, GFP_ATOMIC);
+		if (static_branch_unlikely(&bpfts_v2_needed_key) && hwtstamps)
+			skb = pskb_copy(orig_skb, GFP_ATOMIC);
+		else
+			skb = skb_clone(orig_skb, GFP_ATOMIC);
 
 		if (skb_orphan_frags_rx(skb, GFP_ATOMIC)) {
 			kfree_skb(skb);
-- 
2.43.7

