Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A30C388E4E
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673722; cv=none; b=XPrTjkoD7C6yl566OwA+8c+3z+6m35EcXz7VvnUPKEotWRrdZ/v5+qDSahiXHJR010oyjeW+x/ZZ4rg7uQABCTFLHFSqjVN78ivC0CLs9OEbOkMBLJBttV/N4BbBXMvM3bwzbBaeHRycGN4/9VeFbKFDWPbnXp/DM7oG2f1peqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673722; c=relaxed/simple;
	bh=sfRxxFfc1RGLuuasaz3UMYIDIEEkVcAhXZPiwaIAuIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5YGSjC03dClIi9BxVkCr+UqLOfXnvVP89cmRUtlUeti9ZonyZaTuTTBm+xTMdLhIKs59GZqmOxSPz99OchzwO5hIJOy9Lmo+45BucxzWrww5PdDsDC00CrFyPsHwhcynRRLuARBYmhn4VRE+/yOYqHK/kRK7ApOiQlZ69IGeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeqlyQh6; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeqlyQh6"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c79467f124dso901385a12.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776673720; x=1777278520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMJnoak7v3dQCQqnIhJlr92vBmfJl26udBlaEN0uJnA=;
        b=IeqlyQh6gzttqXBwWk08CpU+r+O2vnQ6iW+e4mXDT5PioFBegjHUjNDHWqYlVhAkvl
         kUxEsSR/nWIA4mqJeSojcumutnTSe0epU/wSpFqylvBrgYEDfK13LqQsPODjgP7GTjCR
         1bH6IINHiYOcv7vsLomSR2SIg1ifONe3f2RrBduoe/k1FiwoUFaEPyYbrsqs0W/R0nXu
         g1NWaqJ2bhhtf+83X0QcG6MYwOca1mF+tKlC0qTt1tUUJ5vjPV+uY0ccIjFWDlSmOpdh
         KUxeoFmpZWEK4O1lRcaW75jaJUMOv5CU91u2ouBe1yN4aXu9WsDFCyElXh83UPC/Yn6A
         BMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776673720; x=1777278520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMJnoak7v3dQCQqnIhJlr92vBmfJl26udBlaEN0uJnA=;
        b=fMlnix5AkkzaMT1u91dHFslVIfWUIg7EJCk4doPf68XB70Dp73+msWy15y4IG5Ox0E
         YRwoo+2bOnAQ7M/uhu1Sp4ZcRA7nk6lZVsHyKEV6eEAGV+2O/nPf9biuZzftncQc9hkO
         tyNB/BL6zPMstMlnTbk4rEXoNtBI6UxZq0s2FVW2CDPPPPkkSl9SaQVUUnOq9fNHJhdr
         kjfqs/VpvbbSBwwY4RhzfgQtrpv+SyyiYbKDvtbRq5E+PphcYrThUxwSxTqZuwprZL+c
         ikpTTQ6MbQOjZqOJl8/VSRUsnLS9T+BuEAxLG7TPPTuuUS63x2YOcNfoRn8bBaLIJhKf
         YRYg==
X-Gm-Message-State: AOJu0YyHCpa1MXfMOusU5/lTW1RY2ovwVoo8XTtFsu6mcXjPg1iXiM+Z
	aTT+r1DL/eCukgyc/BvJk7H7c+fimIhDlNMgPSxyFbrTiX7wGNCLRSMw
X-Gm-Gg: AeBDies7h4oTlAlU5UQRwU5zMnFZjyOZp/pCjhchczRXV1PyazfilBhcoJEWM8tSNNT
	c+SKqVOQp0xjh4eIN5pzZGz2wGlIyHLbPhp43iFguJq7kqhmVjJd5pHfrE+jd3V96CNhK/WOSy+
	z2XbfFeQR1LT04ccAn/53WJvY7Fs7dqItlb3S6+iJClndDvmz/Aytq06Ay0yRA8xma6IGz889I3
	4iu5EWuzhhAlsKY8QXy5WQi0X9vWmBw/Zpb1FaRe2nIclXPWQqmTHKKRLwkG7vnxqvMhFCwpiWW
	+BdNhpvzcXDlCHAXZKcJfjgiNOKyiT0SJ4TuoM9FLBs0n/z4ltjPMjTJ2cjSEjWqjCLVyaCCnu+
	p7YAZrjlwD6C0idPtsQy27iS8FZk/xrm8W2D4vK1eDQv8gDVx0arxbaLDI7a038doZ74W9g1tU9
	o47xsGXOVEPBocnwMfhGWZjvMcnR6fxdHZOSuAqh/Rhg0+wyylTWsZc0fYZKQDwGmgiCWYSvALC
	YULfeJ1
X-Received: by 2002:a05:6300:2109:b0:39f:a42:924c with SMTP id adf61e73a8af0-3a08d6f1a1dmr13977547637.17.1776673720435;
        Mon, 20 Apr 2026 01:28:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c798b56a758sm1728010a12.18.2026.04.20.01.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 01:28:39 -0700 (PDT)
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
Subject: [PATCH net v2 5/8] xsk: avoid skb leak in XDP_TX_METADATA case
Date: Mon, 20 Apr 2026 16:28:02 +0800
Message-Id: <20260420082805.14844-6-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260420082805.14844-1-kerneljasonxing@gmail.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
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
index 614e7bd1252b..51f76e9d6ffd 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -749,8 +749,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
-			if (unlikely(err))
+			if (unlikely(err)) {
+				xsk_drop_untrans_skb(skb);
 				return ERR_PTR(err);
+			}
 		}
 	} else {
 		struct xsk_addrs *xsk_addr;
-- 
2.41.3

