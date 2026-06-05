Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86111481255
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646246; cv=none; b=YUFHQI3S40FYoBinvy7PPnesHGlIUtb5BAuCHtpecq//b5WlDDEbtoeRP3yG5qdmSGPjrkJ1QTE2a719vX2zIsKEwu6jveICwM2Vak3kGuEgR6P/IbmsR0SUtucOpmQZgIt5lddt+ebESWXvbYwzx19wtMtya6Csu15mthSggP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646246; c=relaxed/simple;
	bh=FyoT6jElRNhZ/XR8me8pCu8SF+rmD4dgSDPDQvZXrZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TGxQ+kXSM2q5UBzigQAV75YLzlq6D/v2ZXzR5bc5i56WYjvJJV0eRh9lXTG0MIb3UlIM2get3DUZfYzlzcqBksHZ5oc2wdNH8XlXbw9ITInTi2e2aEUL7jpXpZGcfcndk4wsQo2Ls4MBVZZhBPP05Zz2PZ6Ze6pKYizsXyrTXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRoFk0pz; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRoFk0pz"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36da8439078so1486039a91.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 00:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780646243; x=1781251043; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ypRXmfNw4AH7NGaRxQ71Nt3S+wAEO8XxXRpJWlgrK/o=;
        b=LRoFk0pzEXlI9g+wQcOHkWJgIJz/lZ+546mIf56y3vR0op0BpXZ2K37D5dGWNj2SzJ
         d3GzsLACru+w6jau1Nzo/VmfH3cDbyt+RMi3Kift9Tl0MN+6414a+DzCpYURezCuHQt+
         72psawsisQ5YnBHMhhm5bYdknDAz4Oa3dplQeQe/+FC57402ZEFeOcOsq33CEuThRTGe
         q7VJrxGIXM5oH0PG4IPENZ3kTSRQYyW4mHyvFMDzgzsx/anS7khK9AuFRvA5wVrBism5
         IOn6CPM8jwouDQRoV7/2ui5ZKMtLJfGDGQgWrtlqUxW2NvP+G09ghB1UNGhl4T5i/Xpc
         FrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780646243; x=1781251043;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypRXmfNw4AH7NGaRxQ71Nt3S+wAEO8XxXRpJWlgrK/o=;
        b=g/Ui2W4XXTgUX0f7dFYmB9loo9xGxDJA5AuLbcELeDcqenGWXWpBuCYNMU4qvM1Syr
         k/cuKNgxZ6tv8Tl8ltfxRM40TwG3qvsQ3t9ET+iPE7cCjkq7UwcDPgfYmG4weqjNCuoj
         NDhrelvZqOU9khIggTR4MkMG2fCH86JqD0wCi+v79pA+SOXv8VKTzyXzUBAsgUHvGRHb
         vECNLcRZ3qV0RxcZOPBWUk1X3EUQ4xqGMDS9x3u2Qk0PV9FLacRST76aqwvSwbiuJHht
         TRBdkZD6Z50Egz+oRth4VPgJ183hUFeE2BDXPJwrznMFxpid8QkJTYdoZ8ZY90ltQPz+
         9V+g==
X-Forwarded-Encrypted: i=1; AFNElJ8vFd+ePsgHlmcYLJOzcdFWROj5JXuoj12yX3Ms3CGkeeGTjMYpjQN6mlY7ZjI4yYJkxs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEgpyWYQPxzZhF3x+/4LiYNP++EPbCC0rPqm5cAGJ7W6TCye8b
	32Atbq8sVP6VzB4aNwO3yY5BdOywmpfkxQz8AgHyhlpvAw4EeCKX/WZo
X-Gm-Gg: Acq92OElq3zGhCYJ0gGMrjl0TEfHxsabf2/SnT/BdvQX1+buO8x5SLOHb7Q0IQBKpHj
	dsK9wxQuUPugSX4TaSqoud/HccwuBT9pTrdTlcCYZ1WaaSv65LEOEyL6gghVdmi9uJurk7mexJk
	ULR6S06VwbB8FClBX2CIbMGnk2/uPw3UI+7svnQyV0aVrERabSxn9DPfjubxDJH3Q4bwxVcAxxy
	mA0/VEAJij9VNlkFaoDhN4d80zbSisFKcr6p/rQYA5PxKUVS5QnzsxFpMMTe7u4Ucr6X0dPbXQZ
	LuTxuSQ5EpwRHaTi8PNtnYCIJFXIDc8ZxJA2mfSeKxzxcZSHjR7Khk/Eac/WepPQ3Zu/VjCkZTv
	P6/A/amnq0d113tPjuBOFhmJK+VkLFi23MRHt1XxiVuonieBgiJmbTF0bz3uldhAdtHcHsemK71
	Hu5AdMf0CU+gwoLe9JNCyf7XoW3WQbdZgopfaWT7z8XcIeZAV8ZwyxLEeu7vljJdVk4bhJA+DVJ
	w==
X-Received: by 2002:a17:90b:3512:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-370ee82fa3cmr2367318a91.1.1780646242679;
        Fri, 05 Jun 2026 00:57:22 -0700 (PDT)
Received: from u9dbb0cac493f51.ant.amazon.com ([50.35.61.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37133082519sm897559a91.1.2026.06.05.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 00:57:22 -0700 (PDT)
From: Carlos Fangmeier <carlos.fangmeier@gmail.com>
Date: Fri, 05 Jun 2026 00:56:35 -0700
Subject: [PATCH] net: stmmac: prevent kernel panic during XDP program and
 XSK pool transitions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-main-v1-1-aed15b1cf1af@gmail.com>
X-B4-Tracking: v=1; b=H4sIADKBImoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwMT3dzEzDzdNDPLNEtTM5NEc5MkJaDSgqLUtMwKsDHRsRB+cWlSVmp
 yCUivUm0tAMnGDJdoAAAA
X-Change-ID: 20260604-main-f69f9564a74b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Carlos Fangmeier <carlos.fangmeier@gmail.com>
X-Mailer: b4 0.15.2

stmmac_xdp_set_prog() tears down and rebuilds all DMA channels via
stmmac_xdp_release()/stmmac_xdp_open() without pausing the netdev
TX path. Similarly, stmmac_xdp_enable_pool() and
stmmac_xdp_disable_pool() reconfigure individual queue DMA rings
while TX remains active.

If the kernel transmits a frame during these windows — for example an
MLD report queued by the IPv6 stack — stmmac_xmit() calls
dwmac4_set_addr() against an MMIO register whose mapping has been
torn down, triggering a level-3 translation fault:

  Unable to handle kernel paging request at virtual address ffff8000840ec000
  pc : dwmac4_set_addr+0x8/0x18
  lr : stmmac_xmit+0x64c/0xb60
  Call trace:
   dwmac4_set_addr+0x8/0x18
   dev_hard_start_xmit+0xb0/0x220
   sch_direct_xmit+0x108/0x3f0
   __dev_queue_xmit+0x844/0xd00
   ip6_finish_output2+0x2d8/0x610
   mld_sendpack+0x180/0x2e0
   mld_ifc_work+0x1dc/0x480

The existing netif_tx_disable() in stmmac_xdp_release() is not
sufficient because stmmac_xdp_open() re-enables TX via
netif_tx_start_all_queues() before the caller regains control, leaving
a window where the freshly rebuilt rings can race with pending TX work.

Fix this by wrapping each reconfiguration path with
netif_tx_disable()/netif_tx_wake_all_queues():

 - stmmac_xdp_set_prog(): hold TX disabled across the full
   stmmac_xdp_release() + stmmac_xdp_open() sequence, only waking
   TX after stmmac_xdp_open() returns.

 - stmmac_xdp_enable_pool(): disable TX before tearing down the
   queue, re-enable after the queue is rebuilt and NAPI is active.

 - stmmac_xdp_disable_pool(): same pattern around the pool teardown
   and queue rebuild.

Tested on Cortex-A55 (stmmac/dwmac4, kernel 6.6.60) with AF_XDP
zero-copy and IPv6 active — no panics observed across repeated
XDP attach/detach and XSK pool setup/teardown cycles.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: Carlos Fangmeier <carlos.fangmeier@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index d7e4db7224b0..a6611aee687f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -34,6 +34,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
+		netif_tx_disable(priv->dev);
 		napi_disable(&ch->rx_napi);
 		napi_disable(&ch->tx_napi);
 		stmmac_disable_rx_queue(priv, queue);
@@ -46,6 +47,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 		stmmac_enable_rx_queue(priv, queue);
 		stmmac_enable_tx_queue(priv, queue);
 		napi_enable(&ch->rxtx_napi);
+		netif_tx_wake_all_queues(priv->dev);
 
 		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
 		if (err)
@@ -72,6 +74,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 	need_update = netif_running(priv->dev) && stmmac_xdp_is_enabled(priv);
 
 	if (need_update) {
+		netif_tx_disable(priv->dev);
 		napi_disable(&ch->rxtx_napi);
 		stmmac_disable_rx_queue(priv, queue);
 		stmmac_disable_tx_queue(priv, queue);
@@ -87,6 +90,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
 		stmmac_enable_tx_queue(priv, queue);
 		napi_enable(&ch->rx_napi);
 		napi_enable(&ch->tx_napi);
+		netif_tx_wake_all_queues(priv->dev);
 	}
 
 	return 0;
@@ -121,8 +125,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		xdp_features_clear_redirect_target(dev);
 
 	need_update = !!priv->xdp_prog != !!prog;
-	if (if_running && need_update)
+	if (if_running && need_update) {
+		netif_tx_disable(dev);
 		stmmac_xdp_release(dev);
+	}
 
 	old_prog = xchg(&priv->xdp_prog, prog);
 	if (old_prog)
@@ -131,8 +137,10 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
 
-	if (if_running && need_update)
+	if (if_running && need_update) {
 		stmmac_xdp_open(dev);
+		netif_tx_wake_all_queues(dev);
+	}
 
 	if (prog)
 		xdp_features_set_redirect_target(dev, false);

---
base-commit: 4aacf509e537a711fa71bca9f234e5eb6968850e
change-id: 20260604-main-f69f9564a74b

Best regards,
--  
Carlos Fangmeier <carlos.fangmeier@gmail.com>

