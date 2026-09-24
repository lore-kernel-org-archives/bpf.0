Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C394C14E1
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271883; cv=none; b=kYYhgARjTRd06AMz+dssAcKiSmAd4zd0FiXUnNh1+uuTCyhC1SOI1BvN2XjmlHA4lQDmMDaKLp/upanf9CozXzr6rlJf4BVMMvW0nZFwMiTSNNNTP+cPk/VcovxHRPQSBFlT+S0V5TMcETux1mR+24nU8ByCvb1hMWwOCDMQ+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271883; c=relaxed/simple;
	bh=EId7v+8XiBo2FxyZ2w4d0mqcmBRsGz4tp4tug+vwTNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YfYbJgAQyKXtmyMi/52CfOF5ybwDhtNghZR75gb76bvNKyGtU1MqG868DNrrBDimabqOowMyphIDKF04VmP7VI5QNVZ5wlUWP1IMy23ixyArDCBIzSFWr+B7WX8GYcePl0K3hl69qnt4Z9xeOSHIX9NShoA/KGOjx4xPInaBtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFK0Boqp; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFK0Boqp"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6c2613d8157so64338eaf.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271879; x=1790876679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OEghkHUpo4gQbia4h9dJFITq6F4ApiAV1KakWPfNYGM=;
        b=AFK0BoqpBF757nntZz8wzfEi2PMvUXoMJCuiPRud8Y8aciXxs+u2c7UfdsMKh9G/OE
         QM6W2snWp8pY8pnpACaX9pd4lfKayjwTTkBP+1Jo3sxyVOoxfT9ZzNI9wVtuu5cKOa9e
         2ry6kUKAlptiYw3rL7h9WgZW2223wSTGSpfy/6vPB4Xn+DIRHYBO1FlRpHHI1ud6Raim
         +aUtHpGL7N8quAZlY68c8b1XB5rc/PRHfFs03iCDwWdXHDtLhisEt1VLPcju+vZ8Dl+4
         9PIUoJTsmHSJbce3a0UPkfWjjHqgIWnsEL9j4ZR4SXbrnEC4nX52ig7frbJC4+rD1pRs
         R3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271879; x=1790876679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OEghkHUpo4gQbia4h9dJFITq6F4ApiAV1KakWPfNYGM=;
        b=Hl8N7LQTXhSXAtuLNfT9ClFaVz3oaVnESOwyIt2gRDjMeNAhhT75/umcraGBnHOB1R
         8HVliHr7MDFqORPTFIGXHUS6blD8ZGspdC0qwWBlD/RE2H3bx77leZjSJZJ6A77zgOtS
         BL/Tp0W9ohPnUrYP2rCufKEhOfl5m3p3EK+bYl7zmPrJCdhqtVbWEOx8N3U7O90FXPeb
         trv7fQ8lfEf3kDHyV6Cq8O6fXGDDyUgy+Rlh6eCuhEYfit0tQPnFKmJx/QtCl+fXK0bi
         NH8m07s5OOq8YB4crDhA/eXL/+ZGGrHr+kgxEWA7IEJFnt2ZHApycfWqVCJt102cSuZK
         xZrQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5o45I7Za60jK6nMygFX7K4sRfiqxkPVSAN5CosCos5tbK0T4OeopqyV+YP7wwmNjc3XQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nC0B1RsexKojjZwFqXy0uKdTEvgK1nrJEJNOS+syGK5GdgHwHB
	dHKzIGfXxd7FkpISonIQx1nIk+jz8WCysLor41fIVY0alXp/aksc8Lia
X-Gm-Gg: AYBFou2Cc4+q61Nfiy33KyITzmqmj+7kIxi2BJE032uj3qatcNvWqaldFoCtiQg+CE3
	gOznQmdNyyjI2eUHES9gpVR8hzbMYZC1lMxhFwYs9fqpNE60DZhnAPSczGW+UtRPHX0zkSVe1GF
	xLde+zgJhL+yySPKfGNxjamdp8MFdKVnk60EH4RERPagyQPa7BScGDws4DZGN+P7hxv6fOV3uAb
	Kliq0LVN6sNhTzPXs+psCjMQq6acDhRB+tB7zWrUMJAP9rKBX2UpqnuhIsa8onJ4KpyjskpSK8u
	QL8bR/ONEBjXPT5SY23h/JGcdZg+H1FyYF/AGoxVh3Yj4g0x/0cAmLma0Kkb7jzvWvCow8jLtIx
	/s/l6EAl1PRFawgiPy0rdUuIjptkD1KKgHGxH4CxJ2ORLu2TKGzlBE9c/f/ELXg72umFmj6TKYB
	DhwNbAJLdhEoT8a433JUJC9eGExjf3nb9q6vuHQAt0/gC2RG6ouoshfI1UlKqyav7B0gtZMxYDY
	QzJZFHQ9o8F6p9otyI0zNhuQj1vls6qjRqTu8cmpmjiyQZC1TXizN1SRzTHX3Q/xkd1ZA4yaru6
	qDRc2TV7OugCgNBTxNwAT8TuIFRPqU2j09h7BjP8sPqZOp+BfRrjFJNnfhIA7XD0AEVno/W8Mw9
	6fC9dLR1xYHi+eyw5axs8Iw==
X-Received: by 2002:a05:6820:c96:b0:6cd:3fdb:fa65 with SMTP id 006d021491bc7-6d441c7d08amr2671632eaf.80.1790271878870;
        Thu, 24 Sep 2026 10:44:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:32 -0600
Subject: [PATCH net v3 02/10] net: phylink: allow stopping a suspended
 instance
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-2-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

If a network driver's system resume fails before phylink_resume(), the
network device can remain administratively up with phylink suspended.
Closing the interface then needs to terminate that suspended instance.
Calling phylink_resume() merely to make phylink_stop() work is not a safe
substitute: resume reconfigures the MAC and restarts link resolution,
although the driver has not successfully restored the MAC.

This is a missing suspend-to-stop transition, independent of the reason
hardware restoration failed. No MAC recovery policy belongs in phylink;
the driver still decides whether to retry resume or wait for an ordinary
administrative down/up cycle.

Without MAC Wake-on-LAN, phylink_suspend() has already called
phylink_stop(). Do not repeat PHY, SFP and PCS shutdown. However,
phylink_prepare_resume() may have powered that stopped PHY back up to
provide the receive clock for MAC reset. Suspend it again if WoL permits,
without repeating phy_stop() on a PHY which is already halted.

With MAC Wake-on-LAN, suspend deliberately
defers mac_link_down() and sets PHYLINK_DISABLE_MAC_WOL. Finish that
deferred link-down, drain resolution work and clear the WoL disable bit
while retaining PHYLINK_DISABLE_STOPPED. Otherwise a subsequent start
cannot resolve the link.

Also undo PHY speed control performed by phylink_suspend(). As Andrew
Lunn pointed out, phylink_start() does not restore the advertised speeds
that phylink_resume() normally restores. Track suspend-owned speed control
and restore the saved advertisement from either resume or suspended stop,
including when PHY shutdown has already completed.

An explicit driver speed-down request, such as stmmac's close-time power
saving, must remain in effect until its matching speed-up. Restore any
suspend-owned reduction before applying that request, so it cannot save
the reduced advertisement over the original one. The following stop must
not undo the driver's new reduction.

Document that a suspended instance can be stopped directly. This neither
resumes the PHY nor reconfigures or brings up the MAC.

Fixes: f97493657c63 ("net: phylink: add suspend/resume support")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/phylink.c | 51 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1bbcf46c8356..b7d30ca34031 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -78,6 +78,7 @@ struct phylink {
 
 	bool link_failed;
 	bool suspend_link_up;
+	bool suspend_speed_down;
 	bool force_major_config;
 	bool major_config_failed;
 	bool mac_supports_eee_ops;
@@ -2498,6 +2499,14 @@ void phylink_start(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_start);
 
+static void phylink_restore_suspend_speed(struct phylink *pl)
+{
+	if (pl->suspend_speed_down) {
+		phylink_speed_up(pl);
+		pl->suspend_speed_down = false;
+	}
+}
+
 /**
  * phylink_stop() - stop a phylink instance
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2509,11 +2518,30 @@ EXPORT_SYMBOL_GPL(phylink_start);
  *
  * This will synchronously bring down the link if the link is not already
  * down (in other words, it will trigger a mac_link_down() method call.)
+ * A suspended instance may be stopped without first calling phylink_resume().
+ * In particular, closing a device after a failed resume must not restart the
+ * link or reconfigure the MAC just to finish shutting it down.
+ * Any PHY advertisement reduced by phylink_suspend() is restored as part
+ * of this transition.
+ * If phylink_prepare_resume() powered up an already stopped PHY, suspend
+ * it again when Wake-on-LAN permits.
  */
 void phylink_stop(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
+	/* Also undo PHY speed control when terminating a suspended instance. */
+	phylink_restore_suspend_speed(pl);
+
+	if (test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state)) {
+		/* A failed MAC resume may have called phylink_prepare_resume()
+		 * and powered the stopped PHY back up to supply its RX clock.
+		 */
+		if (pl->phydev)
+			phy_suspend(pl->phydev);
+		return;
+	}
+
 	if (pl->sfp_bus)
 		sfp_upstream_stop(pl->sfp_bus);
 	if (pl->phydev)
@@ -2526,6 +2554,16 @@ void phylink_stop(struct phylink *pl)
 
 	phylink_run_resolve_and_disable(pl, PHYLINK_DISABLE_STOPPED);
 
+	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
+		/* Finish the link-down deferred by MAC WoL, without restarting. */
+		flush_work(&pl->resolve);
+		mutex_lock(&pl->state_mutex);
+		if (pl->suspend_link_up)
+			phylink_link_down(pl);
+		__clear_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state);
+		mutex_unlock(&pl->state_mutex);
+	}
+
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);
@@ -2657,8 +2695,10 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 		phylink_stop(pl);
 	}
 
-	if (phylink_phy_pm_speed_ctrl(pl))
+	if (phylink_phy_pm_speed_ctrl(pl)) {
 		phylink_speed_down(pl, false);
+		pl->suspend_speed_down = true;
+	}
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
@@ -2698,8 +2738,7 @@ void phylink_resume(struct phylink *pl)
 {
 	ASSERT_RTNL();
 
-	if (phylink_phy_pm_speed_ctrl(pl))
-		phylink_speed_up(pl);
+	phylink_restore_suspend_speed(pl);
 
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
@@ -3616,6 +3655,12 @@ int phylink_speed_down(struct phylink *pl, bool sync)
 
 	ASSERT_RTNL();
 
+	/* An explicit request takes over from suspend-time speed control.
+	 * Restore the original advertisement before saving it again, so a
+	 * repeated speed-down cannot replace it with the reduced advertisement.
+	 */
+	phylink_restore_suspend_speed(pl);
+
 	if (!pl->sfp_bus && pl->phydev)
 		ret = phy_speed_down(pl->phydev, sync);
 

-- 
2.53.0

