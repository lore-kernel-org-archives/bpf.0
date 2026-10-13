Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA93A543A;
	Tue, 13 Oct 2026 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881863; cv=none; b=t26mTCKiZKf/NdUQmCbiOU8GkMd9hMn4oTr3TjKDM88tOK7hDSdPXF3SOC3xQefWDvLQ5JpTHpQno33QHuH7B/lLWIVGtG3+ihAmVBfK/muKZVkE0CPKPlNGjDJCkdgjhM73Gt36yr5wAqDnddiwoOYtxngEp9fMkobqzr1cGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881863; c=relaxed/simple;
	bh=CJEEIqpACuIRcRLiZUMuBW41XuRJdTBazEuzD89d7Lc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i3yORchj+jOkwiwOASB0h1JH8Uvxr3vjnBCQqnBeBHBxGfq0pocdaTnbXwnyU8jSdxTpG6UsyYO8OlnHqGyZ6eeYKmS7U2LibJaMMXB/cQ+0HgJVHYiTUGSducbGUzxH7PzzL2JOZwJKpTKpn2zNYk0cRdETobKr/Q4y4FHfsR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yOv9XWPP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4m6K7bij; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yOv9XWPP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4m6K7bij"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791881852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioo3zz6ybzUQhsoHYp3TI/YOLZkzSDQ0WAna1QgIXKU=;
	b=yOv9XWPPfyfNEad/sBQUOkieqwuv/v2cNnZ36xgjUUxIGQj07g+fi4iojnjdrlvIoPvGKB
	dwfDWjR4qeDyEVK1wJn3ky8cE4OSH2AOkz7G2tweNOgTHZgPvzIlrkVyE56dQPYQrLes6c
	ph33yeLko8FpEJU4S3p/cAaQ6iiJai9NXfIx3y6lVGF7/8l0RDeqNsnwsx72THqVqkHWil
	1irgWPgxbNrko80l6M0Cbkbi5wi70TFyZ07/Z3IOcvRXQpue4RhbIFr/KTVpT9GP7/HJyF
	rKo9lqYYpHC+H2LFkQQTD0hPtYFfBMg926i8wF7ge/So6vf43UCWCCfuxClwzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791881852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ioo3zz6ybzUQhsoHYp3TI/YOLZkzSDQ0WAna1QgIXKU=;
	b=4m6K7bijpU4XpEGYiiNh8qIj3FJGH5a+jfA3mcrs0o5sBwxGND6vU/E++zvhQuIw2c06rs
	7ZNa/Z7VRvT2RFAg==
Subject: [PATCH net v3 0/2] net: stmmac: Fix XSK crashes on stm32mp2
Date: Tue, 13 Oct 2026 10:57:20 +0200
Message-Id: <20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHDyzWoC/22NQQ6CMBBFr0K6tqYtpURX3sMYUsogVSmmUwiGc
 HcLGheGzSR/8v97E0HwFpAck4l4GCzazsWQ7hJiGu2uQG0VMxFMKHbgkmJoW22KEe+F8RobQMq
 ZzvNacanLjMTh00NtxxV6Jg4CuXye2Jc3MGHBLbXGYuj8a1UPfC1/LdmWZeCUUeAyy9La1PGeH
 tb1wXfOjvsKVskgfhjO2DZGRIxURjFTaiUF/8fM8/wGvWtemRYBAAA=
X-Change-ID: 20260914-stmmac_xsk_crashes-10a77f614ab5
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Song Yoong Siang <yoong.siang.song@intel.com>, 
 Mohd Faizal Abdul Rahim <faizal.abdul.rahim@intel.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=CJEEIqpACuIRcRLiZUMuBW41XuRJdTBazEuzD89d7Lc=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqzfJ7gqh+ZYzD/9byvCaoITq4zivwjF0GJNMMD
 nDPnDGo/b6JAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCas3yewAKCRDBk9HyqkZz
 govQEACu8VTwfsodIPlWueZ9EX6bnvrRJluq5JkUXvHjxXzNyApvrLgLAkfxhj3zx+j3U4SfO4x
 x/kekOOt05JwoMPkd6WAlCRvXBfC4uxgSECj+KP3g2aBoY2UL4OaSeyOXszH10f5cv79TM1mHsA
 TflXaTGs02FU79gMAcVEM8o7Z4boR0os0r38l41nuoqEZlAS7bMWzeJ1IEUtX60FZQU5HCBTSEj
 20e3Eax5jd6eA81PvkB1LmDF3I09g5eK6z76g2IKWt8v8JwcML8cHMVOD2zIktvrbgAI7ELvzBB
 5gcwHUuyQJa++IMWyC6QRfhXqLTdL93BxkAYGU4L144c6x9+5klwceomm0EcvRaQ4DRW4PYZToZ
 9LpD8F3iXwjTKP78f/52hgpjDE33PEElxvL702MZrcsxETxuBesZHhNYRL9XYa5tbLHqgDl3YKt
 DvjGlIs8HRac3iZtywMiLS5SSx7X1qM5AaE+FceQRUnaoe5yInm+opiiyAvgqLJd96Baj+/jUgz
 YzoaFugzP3Bu0lnuWPkEfRd+db26u8F2EoG3oSqYto9HvFlWIy0Y1KY2fUGiTGfKcynnbteEtsS
 VVPG9NZ04Me3v/ePUlIOcHKBlaD8wVSG/+IW5q39EZgOHIb7bra5waClnW04OLiHzosAwNiy7NR
 quarUVcQXVuAVyg==
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

[1] - https://lore.kernel.org/all/20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de/

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v3:
- Remove txq_trans_cond_update() (Maciej)
- Add queue stop check for XDP TX etc. (Nicolai)
- Add tags (Nicolai and Maxime)
- Link to v2: https://patch.msgid.link/20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de

Changes in v2:
- Remove RFC. No comments.
- Link to v1: https://patch.msgid.link/20260915-stmmac_xsk_crashes-v1-0-e14553fcf553@linutronix.de

---
Kurt Kanzenbach (2):
      net: stmmac: Disable NAPI before stopping Tx queues in stmmac_xdp_release()
      net: stmmac: Stop Tx queue when (en|dis)abling XSK pools

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 +++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 13 +++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)
---
base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
change-id: 20260914-stmmac_xsk_crashes-10a77f614ab5

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>

