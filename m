Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A83F12E5
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460672; cv=none; b=GuNAgFDTTBRiiWuRE5JnyqywK7pKsfyJ4WYgqgGkO3UA0atjj7jVA698uLpDCcl4shukeKCb7Ezg3krW+Xevnqb7+be6tsJxSBDNaNDR7lhqYKF9ukqOrNVgE255I9YwAwcxOICYWc/P9ZEEt5KaoWAq3KLSWFGFp1CzLYhLRFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460672; c=relaxed/simple;
	bh=VaSVSvGNOEyimvK4Anlo4Z8wexqycRFEXogcDwlR67A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JHRzt1XRRRpwJRifolwLj+uD4+/qcwrvZFiAL+2IOl5M+InQAFOCnaS/ivqTiYm4X5f3jRYTgrtNBC59N1eLN8VPwXnPJzb0isMLVexij/sdPdF6YRvsl1eCChAgKR6Izdy60gqQwEyFhNakj8mo+JdPHwxIoYve7DSGgvHECcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=AZ4vnQsL; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="AZ4vnQsL"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so6871a12.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789460669; x=1790065469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GkgxmHG570UDfiLBKnKDfBvipL+pxKJzUQX50Pt2PMw=;
        b=AZ4vnQsL3TZW1Wr28/Y1ZGo3lqhXyne4c2FxH5RPrRWpXnf4RhXTdVTCQyrWrBc/qC
         a73amykBPBR1Eujos0/9wua916z2PSj6QJPI87ixEhSGkmEaJSbG8YDZdCq3euW0uHxm
         ey2Op3MD3WsdT2wxaxAd5DZrUGTF2GRafXe7CtfOnmGR8p16N/0FiS6cCSKZCXu+rlUy
         UXKylnZi5RhRjz+Bubfv+xE2IadF0QzuWFimEs0LhFkp4dXFkqGWGm+VOZP0TnWLmxYo
         MtDWPVc+7igq6c0HhshNfVaki2pZtBneii4ByLLJjST6xpUeVrvUUCYj+tgNatL2JpDm
         3hyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789460669; x=1790065469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GkgxmHG570UDfiLBKnKDfBvipL+pxKJzUQX50Pt2PMw=;
        b=cf5fsS+53O7pT2ZK31ro38VD9y32xfSxxj7qB7VOFFTxFnL5bTXklqoDLwngoFBjul
         OE0nOL5DbXpg6yoRuCFa3n9ZVM2hKkYQaYL4xxIzOrU9/XHnpsQm1ZmWsDEtOfPAfSnq
         01MicH24MUtlyx8QnCvtiZbf+MovSRM6fmZsd7wjH9XoWPTAvnUN/RiX48xSBXswscor
         iA5yCH1qxzQJyypQx10WY0uLVFXMFPx/pdYr6jjj2et2dDuM+z1Jqt82vWezjIbU3KRF
         SwUc+Y5Mzj1ibRjlnQa26wWLgeSLMLQKWV7UmqEXWHuAXX9TXJstGiXQqg6IQzs+/ktM
         cg0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwqwHTNidvna8izQBy1/EYtgx4nJJEzdo4jeHG8xh7SXPM5IE0ZGzw4gHmDFIs3TtRZOEA=@vger.kernel.org
X-Gm-Message-State: AFuF++m2GIypr3oGdD3vdlNuo9+tuGLHHnpkZqAx3b0f/uph9U+cFKso
	bvNWtsX1AxXeks9fGJV5Ww1FT98IPOvamkmCDJ0FmppBl9+t007BeyVExa29g4oglk8I8dLtLc7
	1pouJKg==
X-Gm-Gg: AYBFou2pnD3XBAVsjoHdgfqUM5kpMJiUl2v33ev9QZHdNHxvOK5cvhco0a3LvkYT3Lz
	dssoj+ExUypLPRbMIF40LgMacTk2jH2G2zTvjFNGyEH9hB7I5cYUj0BkXM7nsRO23tW3WTfF4cc
	xPxiCqgWaURAbcm9e2gFOBVcipbmhT+dtjFrjeBHxAuYfhG6wIbZnprstsLGVdSJztf8bGTG8fI
	l/B100EIXuxLBAzI27xZ9UlzzDsOzCS3FyYKk028tj5XjP1A9JHpkZoAQs7FCtHVkV0gTUnJHmu
	GRVbNJemdb2XmXXqL9HeTuICPhbQtmfUY/KwzOnoVNhbSyW+AnI1q3ZWA/CWpc/EBrvRzuH25nT
	DvodM87FIfo6CKsmUYq4iUj3F45pOMK0xyGKd5RFdf2L+8Lzpu9pAvXWxnhsuya3ywBE1tVJcvG
	jKgWbNtJotuK3WYIirVw5Uc8G7BAfMwKnTsL6DIw7y7vGPFdP+UEh9yh9CC6WPN62Vl3PAGEaID
	eS4Ccm22HKptNx8LgdvGQQ3nkFSj+MHaJib+6HE++px3Wm5XhrY1vtG
X-Received: by 2002:a05:6a20:244e:b0:3d1:be60:281b with SMTP id adf61e73a8af0-3dd5285001fmr315141637.15.1789460668846;
        Tue, 15 Sep 2026 01:24:28 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365bb6ba0sm29374866c88.15.2026.09.15.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:24:28 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jakub@cloudflare.com,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH net] net: bcmgenet: restore the hardware filters on open
Date: Tue, 15 Sep 2026 01:24:24 -0700
Message-ID: <20260915082426.703892-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolai Buchwitz <nb@tipi-net.de>

bcmgenet_hfb_init() runs INIT_LIST_HEAD() on priv->rxnfc_list, which drops
every rule off the list, and bcmgenet_open() calls it on each ifup. Every
rule the user configured is silently lost:

  # ethtool -N eth0 flow-type ether dst $MAC action 0
  Added rule with ID 0
  # ethtool -n eth0 | grep -c Filter:
  1
  # ip link set eth0 down && ip link set eth0 up
  # ethtool -n eth0 | grep -c Filter:
  0

Initialise the lists once at probe and restore the rules on open, as
bcmgenet_resume() already does.

Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20260913190052.939955-1-nb@tipi-net.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index a2305e6428d1..b916080f4ff1 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -749,8 +749,17 @@ static void bcmgenet_hfb_init(struct bcmgenet_priv *priv)
 		INIT_LIST_HEAD(&priv->rxnfc_rules[i].list);
 		priv->rxnfc_rules[i].state = BCMGENET_RXNFC_STATE_UNUSED;
 	}
+}
+
+static void bcmgenet_hfb_restore(struct bcmgenet_priv *priv)
+{
+	struct bcmgenet_rxnfc_rule *rule;
 
 	bcmgenet_hfb_clear(priv);
+
+	list_for_each_entry(rule, &priv->rxnfc_list, list)
+		if (rule->state != BCMGENET_RXNFC_STATE_UNUSED)
+			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 }
 
 static int bcmgenet_begin(struct net_device *dev)
@@ -3376,8 +3385,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
-	/* HFB init */
-	bcmgenet_hfb_init(priv);
+	/* Restore the filters, the MAC was reset above */
+	bcmgenet_hfb_restore(priv);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv, true);
@@ -4075,6 +4084,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 
 	/* Mii wait queue */
 	init_waitqueue_head(&priv->wq);
+	bcmgenet_hfb_init(priv);
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
@@ -4272,10 +4282,7 @@ static int bcmgenet_resume(struct device *d)
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
 	/* Restore hardware filters */
-	bcmgenet_hfb_clear(priv);
-	list_for_each_entry(rule, &priv->rxnfc_list, list)
-		if (rule->state != BCMGENET_RXNFC_STATE_UNUSED)
-			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
+	bcmgenet_hfb_restore(priv);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv, false);
-- 
2.43.0

