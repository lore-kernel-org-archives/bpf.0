Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010040EB91
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792186950; cv=none; b=VZT/o7xFgdaxekeZYDjLgsmuyoF4rcHTjAjBWCtF2vxpfsd5uwpPBNEJWfCQoEqiFwUn9PkJ77WECGeSkPbTOxUhXlZjKyyeNQJTwbQzZakifJ/9T+IAfcqZ04m5qopHGIHf+H4Td/1OXgC2noI/yQ6V5m30DbziKEVL44eIRW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792186950; c=relaxed/simple;
	bh=cRk62IXda5uswUNfWyJKtpQk+IUO0CMGpvz/RtOq/48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqW2y7dqRtDHOzwUSHFCGrCbJCcVICA13c84VyTps1XmjoS+FyTOqmvGEw9ACQcxZIQeKZ6CGshbpoLX6HNC3lcWXtmwDuJq/N0qbptLY8mS2tILwoHCQF2ZYOtCSYS3X2mNfnmvc+m3fxcHJd4vrEMAGApZKaV9LjcVcU35IfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TI9pjIOO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TI9pjIOO"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso218426f8f.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1792186946; x=1792791746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPEvAm5BD4qdGQ/byj1NqbzTLMKiUg8kVp/CFRsEQdc=;
        b=TI9pjIOOH8D/xZcai98/MNaAB4CkNadbDB4xQg8ITwsWOr2A8CXjUzH98u3fyInJ0W
         ZWhmMSQXhQlQ96RGeg7o189PHPKUDwWiZUxvZn+MdgX97GMLsM+TcWOiG58KmMeWOhW1
         KhKKOaJP5c3ywXBwimsZrJXuPHahIJX8fvmOdluLxRizyRKzdC5Yoc4t0GQN/IwOyybk
         VdXbN+umruHzAFVTQ532+G7FpClgaDLYmWJoXXQJA3kFd1UtNEIO9P+ouKueJpRAx/oV
         g16RDLoAFwJ2xpU47kUwFLKhuZBA+ecWwmlIa8dUooRGuTsW7J/HjmNqPLil6rjvlJYm
         5OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792186946; x=1792791746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPEvAm5BD4qdGQ/byj1NqbzTLMKiUg8kVp/CFRsEQdc=;
        b=C8BnkDA+zSqpmswUjE/fEHzELreIxSuquQhQS+0W34Eim2tHWY0cLESMCTEVRTej8k
         TYEqYBPoHBSQIYhtZfmEBJkwZ+cd83gaXGDjV+GyJiqG7zdiDRD2S8NjvrWo4jdndAAf
         Tu4aM1bbTVyQPnRW673ue/WHfwffejmFb1xVkc+9AaPIuswVrRTp6xzvC7fhO54HVESk
         Hx3po8ON0xtezUCmndK0OZZ+a3fh8//dtto7jO1DjlgiqRrUjLzVWT+K1rzFVLDsCDj3
         0hAq/8EBEjAcmIqvL8vF4yyaIXz9Hki1D5CovPbTcaqzbe6nmNxNP6244WEVZB1ZY0Zb
         5Q9g==
X-Forwarded-Encrypted: i=1; AKwUvByBAE2H8K+p6bU6G9XsT7U8vgaweUF/4gkMtqszknfTP8/YxSHgAzpsR+3i+l00T0joBLc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBXJa/PYLGieOPSGHRpG4S8Kj3yzcnEqwCUg248JbCZFEqmQuN
	+nPqE4BRFf33I+iG/fDP4hhltVC3hcGBK4OJ8WVd9wfkYUyfhkaBpQR0Q8lZV+Tcmyw=
X-Gm-Gg: AYBFou1QGLy5/syBSCbWSQHX73Xp9avTo/aWlD8g13IyuTeINclHdk4Et6s76vfrAQo
	ooSyvfEguNHsgNO1g10/EfqH19SLIZ9Xm+GwyE5LWBb38WNieAUFwwa7oD039eHX733462H08up
	4ydn0A72/4HVJpPVEfY76uxySbPzFgjpEH6n/H6HHW1GsIJyu3aAdU4nWP3LLh8crksoVCgiNRV
	y04I9TxEEGkO8eIQbfD064AihqFzb86Lq4HyggkD5TDye1gT2IIPu997uzGsh42vGT3yPQL0t7W
	WIUJmNfdquS+B7xQNa4QKGKxE3pJX4kRHbZ/OtAVbLPBOxq9qoA2gJZfzvkevHZNN20G9TMsXs5
	sNKmQRyLqBnBNpOTHzzRBYVLyHt9BGF1497PRz9kbWMu10Ug1cOnvynCVkep6mMbuST0sD18iYn
	KVQzLv29+zsgtjxckYQzuv4s4guPn5jOOJLK7SnBKJyelLXUtuaZnxVY/Ml0Rgm2pNjqOkZLLd6
	xq6+iEX+aXpOiKg7w==
X-Received: by 2002:a5d:53c6:0:b0:48e:37e:470f with SMTP id ffacd0b85a97d-48e07fbbe8cmr1143983f8f.51.1792186945722;
        Fri, 16 Oct 2026 14:42:25 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:ec8::179:190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8bb6sm7975417f8f.34.2026.10.16.14.42.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 14:42:24 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	bochaolucky@gmail.com,
	toshiaki.makita1@gmail.com,
	lorenzo@kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 1/2] veth: schedule the peer's NAPI after XDP_TX when only GRO is enabled
Date: Fri, 16 Oct 2026 22:42:16 +0100
Message-ID: <20261016214217.16942-2-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016214217.16942-1-tianyi@cloudflare.com>
References: <20261016214217.16942-1-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth_xdp_xmit() queues XDP_TX frames on the peer's ring if the peer has
NAPI. A peer with GRO enabled and no XDP program also has NAPI.

veth_xdp_flush() then schedules the peer's NAPI, but only if the peer's
xdp_prog is set, so for such a peer the frames are never processed.
Nothing else schedules that NAPI by default.

Once the ring is full, every XDP_TX frame is dropped, and so are the
skbs that veth_xmit() queues on the same ring.

Commit 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before
xmit of XDP frame") changed the check in veth_xdp_xmit() but not the one
in veth_xdp_flush(). Make veth_xdp_flush() check the napi pointer
instead of xdp_prog, as veth_xdp_xmit() does.

Fixes: 0e672f306a28 ("veth: check for NAPI instead of xdp_prog before xmit of XDP frame")
Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/veth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 643b97dc5245..9405ffac598a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -612,7 +612,7 @@ static void veth_xdp_flush(struct veth_rq *rq, struct veth_xdp_tx_bq *bq)
 	rcv_priv = netdev_priv(rcv);
 	rcv_rq = &rcv_priv->rq[veth_select_rxq(rcv)];
 	/* xdp_ring is initialized on receive side? */
-	if (unlikely(!rcu_access_pointer(rcv_rq->xdp_prog)))
+	if (unlikely(!rcu_access_pointer(rcv_rq->napi)))
 		goto out;
 
 	__veth_xdp_flush(rcv_rq);
-- 
2.55.0

