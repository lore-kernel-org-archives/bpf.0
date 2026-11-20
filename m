Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795187222;
	b=QtJO/NKfwX/d0ZR/4AdHObseRZyP9UpuJAn0P1v/1TAbEQ9pM5WkVhgOIRX11y4ndGjO
	 tJhaNpdNjaAneyYvIr2s1zpzEA01v74rL8BcY2cPmhnRkOBHLTO1LDEredh0IuBtK3ZAd
	 yPIVIvMza0YWpz4Vsjxgm8jpHW+JKyImfYB9Qpj+4RFywRDAnYeYgL7ixe+vsYGdkjicO
	 v+GOqZwg/vxFmSPfoA8s18XXXl4AqB8b+KO2wrfcJosMJrma44zaDOez+60qkI48Ra17I
	 eDGgEcM8wTihOEkbeLKvkJSjGE5rHcvqh0r2mA/PTtZ981ef3fEv0NM/t7i0hJtAWjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
	b=hs2ki2trrHw8qlMtONM6fe9CJ3UpVtbZ+EupzplnbTlVPK59rnrrpOllNp8ZbC4hJ5Pa
	 H3QySget3+9m0gATjiGlFrmwjZej0/cFl4DBxhMQkE3TaLmLBJ6/Cd9ejyTyJ+2IroaIw
	 TmkjrniUKaivS/oFtHyjEGyJLAUZI3MYKtJMqdxKLRiul1tRq+GK/4ajTrfiI/WTobNyb
	 KF1pNwtbVcgN1/vWWuS0Q6Liv1ctLzwvKx3voiuOukoBPrDcriwxAg5NBZRi3Z6URm1IL
	 ZPlVqoepe1mD4iypclmzA+XATWqr9qDgsulsjzz60rMpfcC99xVbqqzAEb13gqkcUeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0bQoCqu7;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D907606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 15:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D907606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0bQoCqu7
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so1638662c88.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187221; x=1795792021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
        b=0bQoCqu7q7T4VRJfEcl6DHmTQUZfcAErx4Mut4fCBZtHuMa7mEvzTvUqd7GshdjA9p
         YXPVJ3LD/on+QupQJxU76ZwNSyckAKmqJMB02KDUkmL3kQUYbKw5uKbzBputxAbXSD2a
         UXcBe//Tj1Vy6TMbcVc+s9T+wNqHH6THQzOjfAN1KTeECfl6+pmsKf9nZoVWRP3mjg47
         MbLYR6xF58rAm5K9anV4K+yOzp0LwMEDoAUvxCbhQ/nol5XzfEoO0ttgU+4c1a9N7Qvd
         1XWomFeVN7FzjPwwOaKPpIiGp+U+PWBpDVAQHJEyhH2Irgl11tv553/jfKvT1lK8eF2p
         ZgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187221; x=1795792021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CwbjPZ+Sgw1ndd0ojkmOYPv2IF6fDVO7S7jEJJhl8w=;
        b=Oe3Gcqea5DPOcCtglQEnu/EPEz20bJRRmWrfQ14g25aarzNwbZdXnzwdoTSM/M0AbW
         u4SNbd5HCI0LC7II7uHTo6e6gCTgCe2NxomMjfTGj/l46nS3OmR0Odcn28bbaW5bK5ij
         F89QrHT2h3J4v7NCTN8ohrLLxpE3rJHpzL4uGRXAP0yPdbObZhLmWq7pcKHoOXia57Mp
         jBlpo1irWuIY92hgDEaly4x0Zv6FcxIbOzT4d+b6TQe0jH/yj9RH9WxPBTvjJT4UFnb2
         TT0UCnad0RsI5vlPHqlEEigZf3dbQY8EsqHJiMuFmxblUSXSNRZbZpMffpI4qDl0WAfV
         iVyQ==
X-Forwarded-Encrypted: i=1; AL+hErFDz2QIWQN8ds2uWUR2Nl7q5Ie3krYQTNoGtD01cR3Zha2ZxJRmLypxu8+TnKlKQ6JWrao=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nri93blSP1tpBby/EalMfDwYUdLyqdOG44dFnQGtBJcVdyjNz
	P5k3SVjiHdYHFq9n5c62tI5rXLAVE3GXJqXAdhg82pZ0i42T9/+4o7rB
X-Gm-Gg: AYBFou3OpDi1RG8QeRWuayZCAih5K7TAvaF0RM4fnxGCumQnAeiyS+xFfaK3BvCXC8W
	YFR5Rv+YhdNFJqofgI5YuV75SgShA29+S2uzx2hTb/8PhmdwPDRllOUEsqcTSFL3zVEcChZUoH9
	piJXmDeqGhOfsylJYrKf3qICRIV+Evb1/fEqixxvOoTW6wdYnEjESAB3K6L1HxE9qSA1yC9knaH
	ASPcJmsww4N1jGdp9mbvfm20911aEkdbPAzbtKd8321uKd3VjoRF+vV4/cjd8FrZGDouVx1fPXx
	Avb7vXU8p6n++dt3bo40X6CwTyFzI9Wd8UKfLuSsLGo6WucgtTOpYYQzF+vTQCrLK2Z+otoZ9hj
	OW7ac4Mg307CYoFF31nJGukVkyUj0eh31CUCIQhBjkovuznMGOxntxdOK5WuPb2aI4NIm3MiSKW
	AXKv1XtizdGHGhXSdBmZndMCZ0MaRzzqhkxviN8mUUdm3AJr5zH0pYXWGYbcIVJMUhB9KO1xFkv
	ULmi0ePJdXwZDMmpN3UvF9tSYiZ0LrSNZH1fSy7cCh1hqOVqbRlm420H1PrAv3pY4zw3jfyrylr
	xaavFjfbkiHvj7sUSjaI9UqMlHKjyTU4EDBoUSvxvo9YjbtNfiYGmCH5/PICl8J0FZJANOkQRan
	TolOCoiLP
X-Received: by 2002:a05:7022:f907:b0:1b2:558a:d781 with SMTP id a92af1059eb24-1b5567b5788mr2642760c88.5.1795187220737;
        Fri, 20 Nov 2026 07:07:00 -0800 (PST)
Received: from IN01-9QQVVV3.CAMNWK.COM ([171.76.82.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm7844902c88.12.2026.11.20.07.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:07:00 -0800 (PST)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>
Subject: [PATCH iwl-next 2/2] ice: wait for one RCU grace period when destroying XDP rings
Date: Fri, 20 Nov 2026 15:05:27 +0000
Message-ID: <20261120150527.14649-3-shital.gandhi45@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120150527.14649-1-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
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

ice_destroy_xdp_rings() calls synchronize_rcu() for every XDP Tx ring
before freeing it. num_xdp_txq is sized to the number of CPUs, so on a
large machine detaching an XDP program or rebuilding the VSI waits for
well over a hundred back-to-back grace periods.

The wait makes sure in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls
have left the ring. Both return early when ICE_VSI_DOWN is set.
ice_xdp_setup_prog() takes the VSI down before destroying the rings,
and ice_vsi_decfg() runs on release or rebuild after the VSI has been
closed, so a single grace period before the loop covers all rings. Do
that, and use synchronize_net() as ice_qp_dis() already does since
commit 405d9999aa0b ("ice: replace synchronize_rcu with
synchronize_net").

Signed-off-by: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 47c6798c9..ed5103e8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2802,12 +2802,16 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 	}
 	mutex_unlock(&pf->avail_q_mutex);
 
+	/* Let in-progress ndo_xdp_xmit and ndo_xsk_wakeup calls finish before
+	 * the rings they may be using are freed. The VSI is down at this
+	 * point, so one grace period is enough for all rings.
+	 */
+	synchronize_net();
+
 	ice_for_each_xdp_txq(vsi, i)
 		if (vsi->xdp_rings[i]) {
-			if (vsi->xdp_rings[i]->desc) {
-				synchronize_rcu();
+			if (vsi->xdp_rings[i]->desc)
 				ice_free_tx_ring(vsi->xdp_rings[i]);
-			}
 			kfree_rcu(vsi->xdp_rings[i]->ring_stats, rcu);
 			vsi->xdp_rings[i]->ring_stats = NULL;
 			kfree_rcu(vsi->xdp_rings[i], rcu);
-- 
2.53.0

