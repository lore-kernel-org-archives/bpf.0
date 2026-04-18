Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8056472
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 04:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488241; cv=none; b=a/SXTN96r+7/CCsSekpAMesTKTWa8SdWx+iimMfdNtTpc/lr2CVnB+DdM1OZralEjpBNXVGiL+aA1wO5J1KDLJVRL6J4yiNdF3wzYJrgiKNJmbjLu+9fQT/ZKh6fsQ3JNBpdSBlpc3lnwJyJ7ccj6MHRpoTmuIYwoE3/o0IyL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488241; c=relaxed/simple;
	bh=dScuvfHSx2J0xfD/1KNmlZxr1BZbYBHGYWf1vTYdj10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtpMz7Epv4S/FkcnHIthzUHd84aArYTSS1D8wDafpjRorfdpAbL9tQCsWMnrY4X5VlWwgS5f8z6eTS9r17dYjb6UMudj6lEK38PUdGpzQeXLRe01OU2V07cT1vYFGbvLFFMk/Pam2lb/O1lHIHBRrkhKyBr86IRt88ln3Pcx1bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGVGQEx4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGVGQEx4"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35e576110adso955151a91.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 21:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776488239; x=1777093039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwiOwC2HPJ2+KxMqshI4D9/LD5MVKo0WgUCuW5jJwyY=;
        b=LGVGQEx4gVZZvaDwnhujW+jHILDV0EzApvg72okn5LBQUAvy9X0P9c/fwmV+bGEf5M
         z0ioM/eOVzZG4WXbGxxjDP5GlQs9R6l6j0lwREQxKAsamChw5kofGzddZjJ02rMOi0EW
         hu1xtIcczQ6jIrbAhga6FU47O/VYsaVqVAGc9k8xRl1XRQd1u1WY9IkK7AoHmKodIjxn
         b4+3UJ5/tk+EXdkvFRYuYWvyicfqgB1jTBcvAp2jVqeTuYCqj31fZfSdzKD6V/hTIQ8D
         T8LxG1SwDCKMEhaAPOusMeMnkNbhfCqUlkb9oBuVWdJF3ghwm8gXkQw7745NsO8P+InN
         hc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488239; x=1777093039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwiOwC2HPJ2+KxMqshI4D9/LD5MVKo0WgUCuW5jJwyY=;
        b=nhYvtI5ydBOc339szTbS9dgRzUKSE2wYpqXyng4eat33eP0GLCKYDrKJJjw3IRs3H/
         mTa8g/7uhF/1/0t/2DPZJd6MR1OXSG96XQN2k+SiMNsyLbhW7tVlKdcJMcF1/CyaXeGR
         eCFJ+6T/9SX+mPUq1/DcKZ8b7s83n8wBxaFXYElj92d8Lg21vY+cJxei98DVqwo4MhV2
         m03zmGC8NMXU9ZZ10XyU2Rcyz7A8DX60h/5KVQcIBAgBlU68BCgkalGN5xBLMaBxWwbS
         Wvraxed+vfyXVESWFJtY9Gf3Gv/mlmYG9MIDKA3/SQzUMBTCdiCHrS3wqLEeWsBFDp+5
         Oweg==
X-Gm-Message-State: AOJu0YwKKJAXTID2qc20Rb3vSQvldYvnw7hyV7PV1g0DCO0wv8jQ4Rmj
	0UoC9v8pdyP31BNJJ+UGsWN89pO755FpGSf8PJWKdLChDeLjoDixDjmr
X-Gm-Gg: AeBDietYGYWozi6qm3lEk2UnbYVnbgHfCiM8fDY6m5pkt/XbbphbM34GcchuJ8yH6Bk
	kSxT442lQkKo1tbzGMW0EaffaibVE3o4p9VvK/i8b+LdYVGDHO+61n0k15qTr8eFPJHWywj6dP5
	wu+vJGqH0diGSqtdaNqf3T+DL18bgc/q1iCf9qB0VIRvl0/+rB5npQogUTQAd346r1+kqmCcCtd
	YOMRuXUGL28q/cPYd18yTDSSTv2ToyIYdRYqLjwvnyYXIlKVdVUk9VVnv7otZyHMmualMjPqfQT
	xnZAX+y7El9jMd0+2svxc+VmAg15R1WkmcPssSSGxYaajQxn07DQ1oSfRK/G10utJ3QH+Of2vP/
	mqb6qhYCLhKFTIGdyRQDeodyYhLIJSgy+RHmd9XutjCBPLhylXI/N28W1ghH8jWS0BsfUj/aZ86
	HFZ1HX6xY1kqdxRHcR4Y4OC+ED11Ea5g3hMLt1k5oSYXx8evZvopiTvb/NmqhPChP1czigE92pN
	pXWnnpLGVKCQna+Fd+Y
X-Received: by 2002:a17:90b:2e4e:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-36140204c56mr4522874a91.7.1776488239269;
        Fri, 17 Apr 2026 21:57:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([2408:8207:1924:8520:35f1:286f:2ada:eed0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a92asm3502377a91.10.2026.04.17.21.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:57:18 -0700 (PDT)
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net 2/4] xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
Date: Sat, 18 Apr 2026 12:56:42 +0800
Message-Id: <20260418045644.28612-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260418045644.28612-1-kerneljasonxing@gmail.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
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
1. the current skb is the first one (which means xs->skb is NULL) and
   hit the limit MAX_SKB_FRAGS.
2. xsk_build_skb_zerocopy() returns -EOVERFLOW.
3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'. This
   is why bug can be triggered.
4. there is no chance to free this skb anymore.

Note that if in this case the xs->skb is not NULL, xsk_build_skb() will
call xsk_drop_skb(xs->skb) to do the right thing.

Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 8fcde34aec7b..5d3dbb118730 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -778,8 +778,11 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	addr = buffer - pool->addrs;
 
 	for (copied = 0, i = skb_shinfo(skb)->nr_frags; copied < len; i++) {
-		if (unlikely(i >= MAX_SKB_FRAGS))
+		if (unlikely(i >= MAX_SKB_FRAGS)) {
+			if (!xs->skb)
+				kfree_skb(skb);
 			return ERR_PTR(-EOVERFLOW);
+		}
 
 		page = pool->umem->pgs[addr >> PAGE_SHIFT];
 		get_page(page);
-- 
2.41.3

