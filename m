Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64ED3CE4A0
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241641; cv=none; b=PwwjohDWrI1HwxJh4Smg5Q/4ZSSiM48vlBATk3G4SpghNM99fCG88P2BhVguJaaAQAaTWD7/7qrSQbDpJFnYHIaCNgo+z/jl0vsU1rRx0bT8AcrBcprky2QFC5mvOGGsghGn6bDd9Bn5lAx9xGpgauHWeZzt8xgp74lk5CdbfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241641; c=relaxed/simple;
	bh=QKTL8wrGcjy+XROomaBzZZvPjePUhieERP66xMR+sYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ax8zF4sk0cILz1/iSnYnvE8af6A6p67zN8XfkpaOsoGgGcG00vVOYZ1b9XzcoWzNOa3nGD0t2fdgg+lbzOVla/1PK+wFU6LeM0uVpjOdxUWnoACjaBoBPDr/nMsSExh6HT7Xsp4hMngPiE5j21r8xZ25R0sYwQKJdCkKvFlkKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLpOBdXu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLpOBdXu"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab232cc803so32821955ad.3
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241639; x=1776846439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok+e9//EJiei5glTedFKtnKWpLWhK+RKH8MheLrU5Rs=;
        b=nLpOBdXuSWy+AHSX+nNyLuX/NAy+0dHucC7fhn+QeQ9tZTJGMuSN47Mp9BjCDGlZ3j
         s0FGAT5xY4af1aTC/+bjdW9PhgeeO5F33C/oPvnPC4wXIV4Whggg17iVWNOQFXYgvdfm
         GGqeXQegSZD/mGS6AuDEf4CD3m5atEFfS6C0jq3l0RhNx3p3dRh+r8bMVVF7YWcF/9ta
         tEf/VvBWr3114wrN7uQGD/zpPjDdbAm62MYXdesOzsrSOg9PYXyxeJQXOUWqi/NY1ZLB
         TnhOgxGEpQ8hrbxRPadTMH1RFOYJTt1omiwhC21wwE9hmfkHbTlgaeWftiLun8rpsSCF
         F66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241639; x=1776846439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok+e9//EJiei5glTedFKtnKWpLWhK+RKH8MheLrU5Rs=;
        b=AEC62BuR21aopri2UcdHHqXsK2/gFwlTrtn6vXs41eky1jUtuYHvC8gCovm4AJQCaa
         HPsiSY4BrNma5SBZDV4D2X50jSrW5iOyKaj6NEyW0Hs8O0ukBPZM5xusk/41qIgHCjXj
         OuV7VEcHMqdDlRjlDZus/YxQAAjjYh1nPicwOavfZPJBH6wtLfjr2+bCsKQEFB+bQzSv
         ZM2DMvPsAIhyzu2pjx3TaW6v3sUvCkAqozT0il02v5uZ3gIaxFRpljw3IE023tc/Xwl/
         cjUGcHPqRVjlGxvS9ir2osjM1ePdTsqk3zmQvbk9uMZ37q2v7zAwuG/gEbXl41HS3odq
         KsjQ==
X-Gm-Message-State: AOJu0YxNuPFdfDJsd3FYwbmr97IE+58unZK9SLvpvF+s7RYe6H5DEYzK
	92+Voxk1/7aEIV6MDcKfHH1n8lW1rC0HclZnqalMuNMZiJXt87hjEtJg
X-Gm-Gg: AeBDies5kyQJF2Zcu46Q9+I+los31jxqy9CYiksq/ukHYMY1QWqs98kEzRFu0Kj90Og
	o+8H+P7YBNDUYXvLQahlMO/m1lvFOmwBDUQ4rdiMVxv1oRTlRBA2wH2CeQG9SEiwXq4gAMPHk9Y
	k/DeKh1m2aPTzXrbklwd7z6XVPApynqSD2xBPC8PTUf0m2ak7JYtPygBGudu7cdqcRaVzG8TGK/
	j5f8QZxAPLC9JpEzCXY9tIgWZLn1mG3LNK8MVpAAjpLCm03WdHDkcflNu8iYH3oMvCKNjmUqFS4
	UpGeJKDUJRcJuHd/gGP0X4H1Nh2G0kaB6VPlTfi6M4K6AzfAQEQINhzQC+qvF+WOmbN2nQDnorS
	nKvteJG6XjRqUnibUQW0WneIgeVYaUyzw6o/rbtZbpCArGDhPeUjqJ1gB03nLckAbY9hi/U3OI1
	XMPYGZwyzacH3NgiGwI3kgzrpo8WQnTjohK1WzsgarhEoHcybchhsAR5/r/68xzoQTJYRXBPmXW
	r9CDR1Z
X-Received: by 2002:a17:903:3e29:b0:2b0:5ae9:ee4 with SMTP id d9443c01a7336-2b2d5975cfdmr145359945ad.5.1776241639176;
        Wed, 15 Apr 2026 01:27:19 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782a93c7sm12174215ad.62.2026.04.15.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:27:18 -0700 (PDT)
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
Subject: [PATCH RFC net-next v4 02/14] xsk: extend xsk_build_skb() to support passing an already allocated skb
Date: Wed, 15 Apr 2026 16:26:42 +0800
Message-Id: <20260415082654.21026-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260415082654.21026-1-kerneljasonxing@gmail.com>
References: <20260415082654.21026-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

To avoid reinvent the wheel, the patch provides a way to let batch
feature reuse xsk_build_skb() as the rest process of the whole
initialization just after the skb is allocated.

The original xsk_build_skb() itself allocates a new skb by calling
sock_alloc_send_skb whether in copy mode or zerocopy mode. Add a new
parameter allocated skb to let other callers to pass an already
allocated skb to support later xmit batch feature. It replaces the
previous allocation of memory function with a bulk one.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/xdp_sock.h |  3 +++
 net/xdp/xsk.c          | 23 ++++++++++++++++-------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index 965cab9a0465..90c709fd1239 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -133,6 +133,9 @@ int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
 int __xsk_map_redirect(struct xdp_sock *xs, struct xdp_buff *xdp);
 void __xsk_map_flush(struct list_head *flush_list);
 INDIRECT_CALLABLE_DECLARE(void xsk_destruct_skb(struct sk_buff *));
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc);
 
 /**
  *  xsk_tx_metadata_to_compl - Save enough relevant metadata information
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6122db8606fe..ecd5b9c424b8 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -718,6 +718,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
 }
 
 static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
+					      struct sk_buff *allocated_skb,
 					      struct xdp_desc *desc)
 {
 	struct xsk_buff_pool *pool = xs->pool;
@@ -734,7 +735,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	if (!skb) {
 		hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(xs->dev->needed_headroom));
 
-		skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		if (!allocated_skb)
+			skb = sock_alloc_send_skb(&xs->sk, hr, 1, &err);
+		else
+			skb = allocated_skb;
 		if (unlikely(!skb))
 			return ERR_PTR(err);
 
@@ -799,15 +803,16 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
 	return skb;
 }
 
-static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
-				     struct xdp_desc *desc)
+struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
+			      struct sk_buff *allocated_skb,
+			      struct xdp_desc *desc)
 {
 	struct net_device *dev = xs->dev;
 	struct sk_buff *skb = xs->skb;
 	int err;
 
 	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
-		skb = xsk_build_skb_zerocopy(xs, desc);
+		skb = xsk_build_skb_zerocopy(xs, allocated_skb, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			skb = NULL;
@@ -822,8 +827,12 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 
 		if (!skb) {
 			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
-			tr = dev->needed_tailroom;
-			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			if (!allocated_skb) {
+				tr = dev->needed_tailroom;
+				skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
+			} else {
+				skb = allocated_skb;
+			}
 			if (unlikely(!skb))
 				goto free_err;
 
@@ -943,7 +952,7 @@ static int __xsk_generic_xmit(struct sock *sk)
 			goto out;
 		}
 
-		skb = xsk_build_skb(xs, &desc);
+		skb = xsk_build_skb(xs, NULL, &desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 			if (err != -EOVERFLOW)
-- 
2.41.3

