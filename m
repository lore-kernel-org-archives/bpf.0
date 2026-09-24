Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8B4C10FB
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271893; cv=none; b=MhARUKtfK5QpBnEi8AK9OGOef0BG3uSDQlz5BH6YUIqvIQvbFAH7Cy0gdD3zKsrkajip+Wxbjv58agnlQHxY1ksnpY2pq1vK6Rpw6YcZ12P2cIR+GlbRdG5l6+O6pqJlTsL6g5UJ7gkDEGPKLsu76WRuEaKqN/dMtUEQJ0YM788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271893; c=relaxed/simple;
	bh=lENjvTcJ6jn6OOtjQT9OxyeXMbXMz3M/XL/BEeU1C48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nD5XqMmHdSQCxaSJO7UgGme71KK9UBU9EXNxU2N6uy+gigBaN+lhYla6F6h/GsBO2SCw22MkSyxuDANA8OZnwlfjLVtkWSdWmP6Afya3004VMZEsqEE6l0cY68yeB4KHmDnLK2mRRKtrmnJufDmIRMNE8B9XSnAmI22qcng/L04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5/ocFJo; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5/ocFJo"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4906fabf6deso130243fac.1
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271887; x=1790876687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrMqc8Q1NW4R8bM+PWgpFGuXOWv8RLSIAwP5mrNvnTc=;
        b=k5/ocFJo/TqwLLtij4rM8EDgk1dATiT5Fxr9mic6QuxyfVU9JyxzoHPFj6DZNL/REx
         KempqyQLQxYgqqt0DTDIXx45dc70oJZkfuYEwC2As6rNhLBQ8pfRwm66MUAqGrIIwiTt
         5TXgUEW5PicfDJFkpzqVfQxxirvAGuVcPSGVcS+VYRWN7W8cCNKLYZKNZIIArYkzfmv9
         ajETeCZWxQlnaF4x37F2zT4f3G0LVWbPpV/BNBd2W75RuDB6R7GFfz2oZzpUPzAAUb4m
         leM1LzkNkajv6631vxo6UAFQ6sEVGWE7edTZEkaQyH4LkY3Am+GFO2sdCAlq972csj1A
         SadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271887; x=1790876687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrMqc8Q1NW4R8bM+PWgpFGuXOWv8RLSIAwP5mrNvnTc=;
        b=bXdy+ZoHSOiG9SRPgmFZufLSwEdLurNQF1ed4br8VFaGjjkerQsW3H7amOZpw0THiW
         MAW+8H8bZYscJip+d7iychI5RO8Y6sGkqpnGLryYImsQuomIF29TW7WkHhQhCMJJUY0p
         KvKK+liFWyAmXKIeZpFX6D/5uoQcOVwai423fQQYP85krvLPCCj4D66nWW75mvm5+e1j
         gH3t9kggYlNU4LaWg/4cPredVVT7OppW7Jb/r6WUsZjH5uSlyGvs6gzgARVQnNFO0cQh
         Aygif0XTf2Xw75t2WEHJHXuZxmq0cFhRY5LjXm3sp3AEres09Ep5qzYim2cJBc3jqagL
         XgMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJBPvZtM+DFQy9fULCADviSTdi9RlKWXlsehuQKKh6JUh41E+BGbKmmcEierk9rlFKG9A=@vger.kernel.org
X-Gm-Message-State: AFuF++nrY5A7ZcA/lXY6LBBky/gR1w/CIdY6nP1SHjPu5vS09CY4cXCF
	YEqSPxlYrRj/I57ugqFBJTvng2joplITgK6n7/lLOo+IrQc9SRGQeWDo
X-Gm-Gg: AYBFou1mPKpLFXx0mLH9pFDIS7e+w1Md5DWsw4DQpi9yoGid/Dc9RFkOLJnAmHkHDOA
	at3Thd2y5lCJ5aZjVCbaBuk3op51RVRKNUDc5P73onHFxFZqeyGzev3C1aGXaX0ZwUDz/8W03/K
	Xlg7hIRs4b7h9v9ronC+yp/89vP1mRpDVgRrsa2jJJydPG1iBCP37HyF4E1SIpwJ1nVXGUSEkuv
	G1vB6j8dNU+CZcj1X/QRaBxPQltbQ1PjHRyJmKg6AlpJtaMiEHv7S1DOHqeuAFQkUFL0qjlUfwX
	5wDSM/kuReK3tMdkADD8dFfJLG87sroRCxJd/snuThBdylw7rHbQdSbuK3hBaFCdw0f2+kfYfaO
	GTW+vtYo+MrqShvQfC2+ho9H89KULl/nM5nHrwdOu1uV9knLP7n7ZxZW/5Uk21RM3yrkoL3qMUd
	YS7R0vMIKgOrW4q9JzA/OpeHANrlkNtWTcX5BebDoaFVvgvSovUCC9+uEDMWqH9cvcx7Snzg4YI
	VpOPp+37YqdFeO5D4++qfgdviFwWg/CclL+DFXd4Io1Qrm5j5xVqZhnYCMzT/14PCwD3UOtCNw2
	+19Piju7ks96pb6AEYc7WCE3vuCFLjeO+fLhSkzq1ttWcqSLEHlxySzDqokih6D0x7J9kn98Ki7
	KaU15JJj+vqgZe5jKRApruA==
X-Received: by 2002:a05:6870:d88f:b0:47c:f956:c7bd with SMTP id 586e51a60fabf-491e4e5f03emr3167632fac.3.1790271887477;
        Thu, 24 Sep 2026 10:44:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:37 -0600
Subject: [PATCH net v3 07/10] net: stmmac: account for failed live XDP
 reopening
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-7-c031e3f3a282@gmail.com>
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

The XDP-specific release/open pair bypasses the ordinary datapath
bookkeeping, and its caller ignores reopen errors. A failed allocation
therefore leaves the device marked running with NAPI disabled and rings
released. A later close disables NAPI again. An IRQ-request failure also
frees descriptors after starting DMA without first stopping it.

Detach and stop phylink while replacing the XDP datapath, update its
ownership state, and reattach only after successful reopening. Preserve
the existing PTP registration on success, but release it on failure so a
DOWN datapath has no residual PTP ownership. Drain transmitters and timer
producers after freeing IRQs which can restart TX queues, including on
the ordinary release path.

Keep the old program reference until the change has succeeded. On an
attach failure restore the old program and return the error, allowing the
core to release the proposed program. Program removal must still succeed
when the non-XDP datapath cannot restart: BPF link teardown cannot retain
the detached program. Leave the interface administratively up but detached
for an ordinary down/up recovery in either failure case.

Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 47 +++++++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 31 +++++++++++----
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ce598b575763..467f471874cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4314,12 +4314,10 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-/* Quiesce NAPI and transmit queues without releasing their resources. */
-static void stmmac_quiesce(struct stmmac_priv *priv)
+static void stmmac_stop_tx_queues(struct stmmac_priv *priv)
 {
 	u8 chan;
 
-	stmmac_disable_all_queues(priv);
 	netif_tx_disable(priv->dev);
 
 	/* A poll function can still arm a timer after napi_complete_done().
@@ -4332,6 +4330,13 @@ static void stmmac_quiesce(struct stmmac_priv *priv)
 		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 }
 
+/* Quiesce NAPI and transmit queues without releasing their resources. */
+static void stmmac_quiesce(struct stmmac_priv *priv)
+{
+	stmmac_disable_all_queues(priv);
+	stmmac_stop_tx_queues(priv);
+}
+
 static void __stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4350,6 +4355,9 @@ static void __stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
+	/* TX error IRQs can restart a queue after the first quiescence. */
+	stmmac_stop_tx_queues(priv);
+
 	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
 	stmmac_stop_all_dma(priv);
 
@@ -7244,19 +7252,15 @@ void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
 void stmmac_xdp_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u8 chan;
-
-	/* Ensure tx function is not running */
-	netif_tx_disable(dev);
 
-	/* Disable NAPI process */
-	stmmac_disable_all_queues(priv);
-
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
+	netif_device_detach(dev);
+	phylink_stop(priv->phylink);
+	stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+	stmmac_stop_tx_queues(priv);
 
 	/* Stop TX/RX DMA channels */
 	stmmac_stop_all_dma(priv);
@@ -7271,7 +7275,13 @@ void stmmac_xdp_release(struct net_device *dev)
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
-	netif_carrier_off(dev);
+
+	if (stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+
+	/* Keep PTP across the immediately following stmmac_xdp_open(). That
+	 * function releases it if reopening fails, before returning DOWN.
+	 */
 }
 
 int stmmac_xdp_open(struct net_device *dev)
@@ -7350,19 +7360,22 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
-	netif_carrier_on(dev);
-	netif_tx_start_all_queues(dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
+	phylink_start(priv->phylink);
+	netif_device_attach(dev);
 
 	return 0;
 
 irq_error:
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
+	stmmac_stop_tx_queues(priv);
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 
 init_error:
 	free_dma_desc_resources(priv, priv->dma_conf);
 dma_desc_error:
+	stmmac_release_ptp(priv);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 909219775507..7ecb7addd2ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -108,6 +108,7 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	struct bpf_prog *old_prog;
 	bool need_update;
 	bool if_running;
+	int ret;
 
 	if_running = priv->datapath == STMMAC_DATAPATH_RUNNING;
 
@@ -119,25 +120,41 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (!prog)
-		xdp_features_clear_redirect_target(dev);
-
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);
 
 	old_prog = xchg(&priv->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
 
 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
 
-	if (if_running && need_update)
-		stmmac_xdp_open(dev);
+	if (if_running && need_update) {
+		ret = stmmac_xdp_open(dev);
+		if (ret) {
+			netdev_err(dev, "failed reopening after XDP change: %pe; interface remains detached\n",
+				   ERR_PTR(ret));
+			if (prog) {
+				/* The core retains the old program on error and drops
+				 * the reference it passed for the proposed program.
+				 */
+				xchg(&priv->xdp_prog, old_prog);
+				priv->sph_active = priv->sph_capable && !old_prog;
+				return ret;
+			}
+			/* Uninstalling a BPF link must release its program even
+			 * if the non-XDP datapath cannot be restarted.
+			 */
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 	if (prog)
 		xdp_features_set_redirect_target(dev, false);
+	else
+		xdp_features_clear_redirect_target(dev);
 
 	return 0;
 }

-- 
2.53.0

