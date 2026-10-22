Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652505;
	b=PtlPqe2rNxPx4q4rzvUg8uhXg3uJXcXO779i7H0iKBL/4lntWK6Dk51E+EzKfOYOZzcf
	 9/HLybPsbycnbYNlaBmAfGxKIARpf+FoBcVp87LxtfTlCAZnSqYQb8KH07aX5TbEN6Md0
	 EytCADbS8424tw3GYR5C1VHrm9l2z2WuG7xj6zw1Bcd+oPShlcrPayjLSLW4KGUwiN635
	 XXLMXQ8ot8DLKp9nF4aW1tD4j7eHO2aj1j2uLwgSSuyvSCXkuxYri+ugAaB7/mi+DnU96
	 lh+1d15NkEKUGpPllyIriWM0xSGJbu6P1xhydAC3IdpgpYgpdnX9hdRIpVvVZUp0xRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652505;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Developer-Signature:
	 X-Developer-Key;
	bh=yl5Q0Yhg+88xllrX1kMC1NiLLtnuA2INxcGfBrE9LpI=;
	b=nVQN69lV1itx7thWf2xl0w6xklIWs48X7oYiDYEYJAt0Qd/deGgCzVUDWtwCxfqiGlaG
	 CchSWeI9q6B+/7cxFHdshCZcI1K0n7AHTZxv7YXlS6/p8M76NBYHBbSLYUvtXpbQ1KLeT
	 ktUqLkQQXsMpQ5vlt8H1nJHPnkJAxE23FqgOWFrgA2yGsWqkE7eXF8G5MUhrcpv7/sRwY
	 aRT9EY4qcE6Yqzqf2huBPePxAuZIQw5E0LLx31HT7kvVZNImjjB+tAGX/rsbWokOiRWfM
	 6vqmNs+YSSRTRvTH+CZD923A4IC42nC+boZDKUKtRIfabmweG+0U3mv3/RbS7Svuk9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dbA+IJmf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qa9LZRM6;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20F606A319;
	Thu, 22 Oct 2026 07:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E20F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dbA+IJmf;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qa9LZRM6
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792652501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yl5Q0Yhg+88xllrX1kMC1NiLLtnuA2INxcGfBrE9LpI=;
	b=dbA+IJmf4k/suoYUrdFptKfzRxSbhEQ7jZiVFdAZ6TrwiDGUw/zysfnHprKtLDoICu+cqD
	QDWSNiooTP7H5zHoTzA70qVJqnNxH6qviwSQNJtQY2rLGr7S+do91ST07Jg/pHYar0NyBj
	23BEz/BeroANW/o3lEENWh4+KAEW0v63NPL7PAY0SY0IKdolkDB9A6/nQ42oyJZCs1l814
	7dlh1dFFW5doJyRWY5x6VajgmcH1PMJR969bEsowy2ffj/h6pQtiZWz7LSOlipczZgVgmr
	T0Js6QFB2s1gjTiiqr+qrIi+awuIvziaNfNioRNB88zGE8w6rKxwoVeb+u0LZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792652501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yl5Q0Yhg+88xllrX1kMC1NiLLtnuA2INxcGfBrE9LpI=;
	b=qa9LZRM6NfQ+MtC/BIOnd6FjneUzpjrFH4DtdbEfuigupMVXcShC/XHmcHLoyn+yJZmVc5
	1c9R5IhTdN9JcECw==
Subject: [PATCH net-next v4 0/2] net: stmmac: Fix XSK crashes on stm32mp2
Date: Thu, 22 Oct 2026 09:01:33 +0200
Message-Id: <20261022-stmmac_xsk_crashes-v4-0-15c0c750bb96@linutronix.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM602WoC/23PwWrDMAwG4FcpPs9DcmyX7rT3GKM4rrx4W5xhu
 SEj5N3nZKWMkYtASPp+NAumHInF02EWmcbIcUi10Q8H4TuX3kjGS+2FAmXhhFpy6XvnzxN/nH1
 23BFLBHc8BovatUbUw69MIU4b+iISFZloKuL1d8LX9p18Wc11t4tchvy95Y+4XdyizF7UiBIko
 TamCT7U+vwZ07XkIcXp8UJbyKjuDALsM6oy2noLvnVWK9xjmj8MNrtMUxkDwdf/T+CC+s8sy/I
 DJI/I+GIBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=CKFc4YQcze+zKieJAJ02zDARwoapA5QsLlCRMkFAJKs=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBq2bTU0TnmPz9H28QeFJNjxPJy7hEvZVJVduAF8
 frD8w3LjDqJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCatm01AAKCRDBk9HyqkZz
 gqs8D/9rsgS5BD242m5ZHhGynFavy7JQfGNQfvZ3z1nmCZlHSHejvOrfg9VAGHLluF5QRYGdMFi
 PQxC/pJSTTx6/zSz6KGftJn3qcF5/WkgJcrVv/thIiUJ+m2ISMerEo1cMSMlwvty3vVe7oJRGbm
 LHPg1dmpcNveiC84UEzwNR5zXS3Z8O4470wGb8xLmhwjm43peFl+9BP6fB231GUB5ziiryJfP/o
 ShKvGaafWmD720C3xxO5to3TH6Wa6MZI1ZNm24IsoV5pBrozo1vazD7poYtzRBQxPtSDmFvF4O+
 q71OgXu5AfB6MCOpwO12nNMwDlkeMX7CqPx+cGN6cGgPd0HsSXJq1MZXPNyBKTXD4riNBlhBaAE
 pQz1YsKxxpx9ZNjFnWtsqz6s/qGAykH16wmH8QX2znKkifInbcu4PiJvuSArqArvde8PFNjy4g4
 y3pUSIBM/j5ZGleWKW+RGFxIjzSFMYtoW5WzwE9wdI3MYwVPgrjleYaMv9K8oFuOy/EBa2zEgD/
 dILFswFrE0iOL80LKZVf3PlLe/QKcTLo1OOozzdczDXJfQR3elt993JICMT1XNHjj+U99XPswBl
 49uma5Gb1G5BCuKihUCLsFFl1kGkFkZc3W0oDT0VRQxn2iAcNpfOn+qrtytx78vMZe81kQw1+zH
 hEEgvslF6u/md7w==
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
Changes in v4:
- Rebase to net-next (Jakub)
- Add tags (Nicolai)
- Link to v3: https://patch.msgid.link/20261013-stmmac_xsk_crashes-v3-0-50fca7790af2@linutronix.de

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
base-commit: f71ff7d406523748bfb8236830c7eaa6a308aaa1
change-id: 20260914-stmmac_xsk_crashes-10a77f614ab5

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>

