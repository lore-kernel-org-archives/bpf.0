Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1D43A4503
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 03:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829038; cv=none; b=Pe5QVIXkgZcsgvNnvumyzh0Uxq2RWHb4NX0PQtzJczCpPY3r6sOGtPC2rMCLIbJ73yahwb3wUn/YbNp5AQxPzHJZpbkTnZosKLL7S1jeyBKUeUlGm4t1uFhdLwxQC9o/fr10ckKOtWvA/f0xY2X5Rt/rpNnblRQCIu4ed2s9dHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829038; c=relaxed/simple;
	bh=iptCJ/bHKRj1fMFQE+A5aKdO5Z99CRwurcu7O1XGAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jBazccuwkGvo2oyW50WSZkLCP7fOYsfSiFq/B/OXiwo8Rqa5iXCOaUV1H4zDCVQ0e0gEsuEBxv8owFnCAnttpCN7u5hyKpCoyuT3WTIteiKfh4rYRyjFpAIBk40Sp+7ss+oAWOjwdA9PBoNoLIykZ9OCNnfFQEm5vf+Nh1au3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBKVPhoc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBKVPhoc"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82f351ca23cso2466053b3a.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 20:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829037; x=1777433837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5FNK2dMAt1AUCbwembDz3q9hbJSbopjTGmkhaK/v7M=;
        b=aBKVPhocvp/3B/zZFwdh3D7S11kDoao5ILRc/A+cbTjyFo45Rb7YlkB+oj4PLxiLPj
         9Ra6uVx5KI7mrExvJTvv5f+90Dmj90ZSUqSEpfiZBEVxKfN2drL16dx20OfPEXE6Yu3I
         WuRNZfYkcecQpYKIUR1caTG+9fE+bpMz8auLFEFkQOZRdm3uudWcHfYyU5CosDgIc91+
         Y53WUbYRJPjpf+WtKTEUapqyxzTuoU6hHtIn4mxPMozuj4fVr96rWIkPeSAn2qeIyfYh
         W4YH28uVrHv9ClmeHv+GMGOJ70BmQt741ANwBXBHE6nJX7D/BpcEeIxw2+RfuyIRbcAY
         dhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829037; x=1777433837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5FNK2dMAt1AUCbwembDz3q9hbJSbopjTGmkhaK/v7M=;
        b=auSpdorJvxWyc+iOTITjK9sD8iRXerfkmZWdjbJcSdXwmIR7zluyT4KOKf2aVc/sa8
         TB4bkdcEdQph1mKUmqTaB+njwXQFAwAsJaid/W/Hge27/QIIGHQ/DiOgKyJ3nEb+7i+Z
         ATw3NE7A8NnXLNp8J6LavU/Ccaxp/ukFxbJR7PqzoeA/N7P2nFKT4aOh/3n0m+QesdZz
         28MUa0obQ/i5FMnfyBG2SuTS+keEjs8jEKi4VxKt2EObzWUzzKan3m736abP78TW6BOO
         b9wt8uUC9c0BDcibotS+Imiiowfj1J4V+V8KyAM3YreqbV5+9rTgUvucnx3/TIsYEx9L
         rJeg==
X-Gm-Message-State: AOJu0YxO7kPx4LnlSLwiWHXoIIOyBBuhXl4FtLRaJcMAICTImhm/1jmF
	9Clzbc4zSD27yQF1GYiCbq1Xwoesqobk7TJ62Vu+N2RrsXa4ZaFhbOK5
X-Gm-Gg: AeBDiest5Xu7e8kF1Kg4XHTvrm7sbRQs4Qhr3yuR8qdFH6xeS15ZaXGWKMqH1/svTOJ
	bVEjxTpEvevwukDa1lD/omqOpJMA7IFFZA9pgvmtCSoO1LXvMM6YV3P3cOA5HhT6rLSO+9HGxi5
	eE2xItsflP99/D9gdowqvAArLntUGcMR8Vn+qCLPjiIcjrspISa7dVE8XhMn64hPwOS+Sk9so2x
	R73Er2Dka8kF9cAN5LbU79Eivzy8YZRAZSYWdqYCwFNBTs+aKvA6ZNIoqTfembX0HAvJ0Zvg+yR
	DFlycvhTmPQaqQlK+1Mx844WPOzJia75DxN2zWLvZ9HL7rHv4qKc2WEqW18k5XWmHpFqdB0TmCQ
	vUf6MuvzQ6nsoz/g3YFEdsHC8wGurMBE5PiS/yxCwdfo1oepzOEJB4v6pAwk+cFMRBbcAfr6IJ4
	OfokTIQWKh6FvChiXdTTTyj2Kt2fe0E3p083rMvxr0FItVK2JGV5glCNZ2A+6V7q5+pxl7RO48k
	XErvbvEMjUFUAMwIGo=
X-Received: by 2002:a05:6a00:2311:b0:82c:dd31:b83d with SMTP id d2e1a72fcca58-82f8c936e47mr22442349b3a.38.1776829036722;
        Tue, 21 Apr 2026 20:37:16 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:37:16 -0700 (PDT)
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
Subject: [PATCH net v3 4/8] xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
Date: Wed, 22 Apr 2026 11:36:46 +0800
Message-Id: <20260422033650.68457-5-kerneljasonxing@gmail.com>
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

Once xsk_skb_init_misc() has been called on an skb, its destructor is
set to xsk_destruct_skb(), which submits the descriptor address(es) to
the completion queue and advances the CQ producer. If such an skb is
subsequently freed via kfree_skb() along an error path - before the
skb has ever been handed to the driver - the destructor still runs and
submits a bogus, half-initialized address to the CQ.

Postpone the init phase when we believe the allocation of first frag is
successfully completed. Before this init, skb can be safely freed by
kfree_skb().

Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.kernel.org/
Fixes: c30d084960cf ("xsk: avoid overwriting skb fields for multi-buffer traffic")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index d23d1b14b8b4..88ec6d2cbbcf 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -739,8 +739,6 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 			return ERR_PTR(err);
 
 		skb_reserve(skb, hr);
-
-		xsk_skb_init_misc(skb, xs, desc->addr);
 		if (desc->options & XDP_TX_METADATA) {
 			err = xsk_skb_metadata(skb, buffer, desc, pool, hr);
 			if (unlikely(err))
@@ -834,7 +832,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 			if (unlikely(err))
 				goto free_err;
 
-			xsk_skb_init_misc(skb, xs, desc->addr);
 			if (desc->options & XDP_TX_METADATA) {
 				err = xsk_skb_metadata(skb, buffer, desc,
 						       xs->pool, hr);
@@ -884,6 +881,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		}
 	}
 
+	if (!xs->skb)
+		xsk_skb_init_misc(skb, xs, desc->addr);
 	xsk_inc_num_desc(skb);
 
 	return skb;
-- 
2.41.3

