Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F25747ACC3;
	Tue, 15 Sep 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462528; cv=none; b=pnFiQvjhVzEO87v3HEPLj7kkQmo7KkKaGJpWl8q+nQjQafDm/mFNxQYd7dprzbhYwsn1xtj4PftSu59Sa26zbhRrtwp/pAZkEYmcmsYCh0/6TZAnl//ocYG99jugu7AuZN/JLBaJw1ww+tgSOCDP6nQYkJYfff2DhGKvTAYmiHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462528; c=relaxed/simple;
	bh=9XXEozCK3dRnlsfkPr55NurlMImrFl9on9S4pzoI+s0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r7a+9y+kYM/+RxO7Yvvv2WgAIaEOhNz+5l0U71MbeIKnS8kA07Ahx/OV4DRCPaBQnO397OwolIkbQpfNiqLlSvL9McZGqwrTp7xSxk6br8pQ2KE77e1GCPSkmQ5afY8U5T87mR18KTxEyE9veElB1PhBPlOKxef3Yr8oaOvHIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WA9n6n7T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkRsOVxn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WA9n6n7T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkRsOVxn"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789462524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kz2evdFDdQHXA8nX4bX8y9CwHJFuZrEM5kHt+0SRwUI=;
	b=WA9n6n7T8oQoAK/VqPeBqKBQX9eFqxoj6f0/fRQJ850oQxRP+SZCljLYGS+gcV7+8i2Ot4
	iu8wvRkpPIfrYiVC9M9EWr+oefNjsRAbnsTzcErLgU1VsJ5Ls3o3wrNSODfXim2LEC1QzU
	AA+f2KCYg9naRk1c9CiLd2AG6yptB8p9DSEMmGuAbseQhHQJrzVvRkr+HeoLKVxgfxpUak
	X1WAYCwBZPEpGLet+lJQTl7mEgN7E1M7D3fXlyj4fHcJgR65ZrrOfWSPQHvClIZ1Q/TH8e
	HMXUnVVzZhQFe5ZunpkIMuJF8uOTOWdSdaQlhbOULyCCxV2teARNhPgi/R4DBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789462524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kz2evdFDdQHXA8nX4bX8y9CwHJFuZrEM5kHt+0SRwUI=;
	b=xkRsOVxn7E4PztgHnpY1sS8KLFNmvMFUbkI+5aSPemomlkiXPIiQOPftEavTFRhYEWdbIS
	NxgL7k/x2Uw+QLAA==
Subject: [PATCH RFC net 0/2] net: stmmac: Fix XSK crashes on stm32mp2
Date: Tue, 15 Sep 2026 10:55:04 +0200
Message-Id: <20260915-stmmac_xsk_crashes-v1-0-e14553fcf553@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOgHqWoC/yWMQQqDMBAAvxL23EAiVrHXQh/Qq4is6arbYizZt
 Aji3xvtcRhmVhAKTAIXtUKgLwvPPoE9KXAj+oE0PxJDZrLCVDbXEqcJXbvIq3UBZSTR1mBZ9oX
 NsTtDCt+Bel6OaQ3321V5itD8hXy6J7m4L2Hbfk6Ds0d/AAAA
X-Change-ID: 20260914-stmmac_xsk_crashes-10a77f614ab5
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Noor Azura Ahmad Tarmizi <noor.azura.ahmad.tarmizi@intel.com>, 
 Mohd Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=9XXEozCK3dRnlsfkPr55NurlMImrFl9on9S4pzoI+s0=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqqQf7uveF9O0ZOtmy346HcxuhlVkuzl8l6zEKz
 tiehjPD7m2JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCaqkH+wAKCRDBk9HyqkZz
 gtivEACXpYLQiXXKS7umNljH9n8tu5CLNKvakkzwLWy7TOGSmJ5DOGAReyyTLakGIzhUy7vySot
 zuYsTUDCYGge/xhxyI/odDU7/ulXTu0cgvFDOmy+Oh8cYxO77EwMdzRwN0f+NS5r76dmc12pP58
 F3+YHlFQzLIok+8lAk242XVPuvnrUSGPU5hQnrZl3i07zwr9TJUAXjfUb/PMC5jy2stE2Y61b9d
 9V+l45Dl94zCT8ILPjFUQRwnN87XDMHa3gauOwLPD0ofeJzhLVCPDbFvR31q09rarr/BL16U5pE
 WDpJsb/RzGpD4BR54zcy4yD9BwgyJ8//z9Uyc2B2Q5tyiS6fsVoF3ika7HP1SQp1+RLZ1QiGIcX
 D0WEZzhadtoV+sSxW0g1TrOwXuE6CAMej1An9ggM/EvHGW1Yzd8P5kT5GvoxzvW3itKbdV9MgEj
 rtsYPS1VSCwqRbcZenvXZehdhlMcTKxCoUBQqwgI7jEnMc4/Q/K6EU+3/HVIah3kQxjy6vQSxHv
 7YFLAH03tThHRayYRpkfb4TF0gXloSRwhR3clrZSRJUaN/jUsTRKhnsBBR4rcev3jJ8+Zg31ucs
 iVBHtq3B6tDwyKrvvlDgTEaSc5BTvtoPyXjeuONTWJ4RV8riEN14Rl1M6oVSarLm+ZqXJeqg/zZ
 9hEsTS3Mw6nZI6A==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Hi,

while looking at the TBS thingy [1], I've noticed kernel crashes. That
happens when opening or closing an AF_XDP/ZC socket while parallel Tx
traffic is going on.

So far, I see two issues:

 - Patch #1: stmmac_xdp_release() seems to have the teardown order wrong
 - Patch #2: stmmac_xdp_(en|dis)able_pool() does not stop the Tx queue
   at all

The kernel crashes can be reproduced instantly on the stm32mp2 like this:

 - Run iperf3
 - Run application which opens an AF_XDP/ZC socket

RFC: Hopefully someone with a clue about the stmmac driver can take a
look.

[1] - https://lore.kernel.org/all/20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de/

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Kurt Kanzenbach (2):
      net: stmmac: Disable NAPI before stopping Tx queues in stmmac_xdp_release()
      net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 14 ++++++++++++++
 2 files changed, 17 insertions(+), 3 deletions(-)
---
base-commit: 23ca4ddc4fce2c233a49e9fd34d4b5b02bd7324e
change-id: 20260914-stmmac_xsk_crashes-10a77f614ab5

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>

