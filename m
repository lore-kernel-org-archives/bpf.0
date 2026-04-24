Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81B3446DE
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009131; cv=none; b=jRWyj18xLdF7bK+7uk1lxdbOSr0vS2maDBVS4Uo0acUwQF385A9UNniIgzg8xiy3saNz0gqNnJ2iibEzZqKWztfhWdgmR+wCyprBw8XFuQuE+QfcDOjdwFbQ/FuZ5aSSg9y2x8GjbLpfd998iaCpGugZNRb2Bm1KoN8yMZl7sAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009131; c=relaxed/simple;
	bh=QlHxLHs/zNiflxHYOMrRfrLThP7TESwwU6fsCt73Bgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiK7D2QBJJiQ2ulNPl1GD+75S/oK/Sej8o74iHDUlSruh+y6xcTa02GACI16ibK98a9aDfrggBjod/4kXa6kCEpqoic4g1mToQQkblwNAXpqL9+S4G2EaGEk47bXVFvc1nRlULkH2Eo9vziqL4XuDDEKthw+cps8SD1nnLB+2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnO0dddw; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnO0dddw"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b0afa0210bso34397335ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009130; x=1777613930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OkuSZ9c9nRJYsSC9E9BSwtAFpuJY8D3j+20Y6r3eWo=;
        b=BnO0dddwL1gi+UAVGHFtzc1J6WML/ZEw4FtP7yVIEC7sWmVnG50844oDF7iKV5nfaE
         29wkSJIWy3W7T7MTOnjsMt0AjAdlJxmElqoxKJ9IXkGtf/w2nuGRxrzoUL3/IJApMNgX
         pw6wsSuubymL0SPKBHxtjkdcafMm1kYMO1lSG51KjUh7RcLnvt6XpsTNz3Zx8OiFzA9N
         ohnMoTr+rXyyL2AOKWJ2BTFfZFRTsE5MxFS4Zn1Dt20zc9zqjCxBcNtDXXJQfO5KfooO
         H0D+bmpvDJPhsFIgjh2PSJDOKP2y6tzOzSS5PQLnpzeHJ7AQ2RimAdodfLNCvxmORy8v
         9mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009130; x=1777613930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OkuSZ9c9nRJYsSC9E9BSwtAFpuJY8D3j+20Y6r3eWo=;
        b=c8U6Mf1/TkdEaN51ifclWcfhHvbAnVHSdYFG3lYwnyQVKd6GG0kEj3x8eH5y95iVhu
         rhmHDbn01934fWXz2+nkv0fHcqGWkzwv9YXRMMm8d/D3lMHocm08Quc9RTf5tanXJfo0
         69I1RiY4aJHqfbIK3SjwsEhPTmdIMgt2HzshmXgYH5ZL4X/O6kRo/04mkblSUm4VGdA5
         7MQFgcHb4oiWy9nsLEkenbiv4wCMgg85uCCK3cQuZ8MpDazaK4fhhm+ZY7C5BOg+acGr
         cCC/sMMzQ+4fXyS0U/zFPfINaBIjb3CoJgxYq9VkIX6/b2IpV10yDS6tX5p2+iUAAay+
         aUFQ==
X-Gm-Message-State: AOJu0YysH/Tylv40BtkuHu4GXDhiAVT9JsaiO89xr8xfbL+jIe+2GRCQ
	DLK4ATNv93LgqrvDaGxxJvsrWBh2vd/FVZyLAQ7n9UK+NFMw7+kb2GgM
X-Gm-Gg: AeBDiesE0JeLxtLrXEyD0Es6qQDldH2vKBox3yosAZuwH+ybc07Mu4Khtfl0pkImiX5
	1jCPhgJ4QU1w5t6QrITzNObRyLto3mCyuY4dab8zu1MoMVGLzNtOmyj4REd61Pod0Sa952YcoFA
	kVY4yBEJIkR3awRTa1WbOu4QfUO4DzjWNvQ+RCh38NcGoNRY9bQSqXpQifsx4I9/yWO2VfE5lQ7
	a36rk5y5OQyPUIShzCb26srtrBEeiANCAWniYjUUVxXR0+RVOFVi/OjA5ip3ak3PvjkpzOC6o1u
	r4tC+QseY8tAv8fu+shYhC9gEOnoENOD4sSNADI/I1gwb4QhCyDOjgQ1lja22Dw7/RcBC6OFHMu
	f/k09oidKdYzq1pw+sg3GV5EgV/Pys6xFC7vr8PsrEKmBx00p0DWVtACQ6GwUd4tTTON/KwhtsA
	geH1+bq1TWtahARy89pAM65lnVDqRc4w1Dfpm965gr2vYC4/jANysA1POwBNPCUWnH7e6zU20S9
	1rgTa00X4oOIKYbuV4Ml5QE+qHOgMWCWn2IWVWk
X-Received: by 2002:a17:903:2acc:b0:2b2:497e:3f6d with SMTP id d9443c01a7336-2b5f9e8cdb3mr295127255ad.8.1777009129888;
        Thu, 23 Apr 2026 22:38:49 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:49 -0700 (PDT)
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
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Fri, 24 Apr 2026 13:38:13 +0800
Message-Id: <20260424053816.27965-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
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
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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

