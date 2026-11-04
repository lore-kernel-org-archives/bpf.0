Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760841;
	b=vQbYz1GNWsHLUSMlFdpCbohpC/lfLBa2/i/jp4wh6DD2d72lF5WcyKZ59U7ck9d3e7IG
	 Do8ZJYD0hzIj+rdys5OqMUKjCg9HRbS1MHBujQvJkzCqqkbOwYZa2BrUHkBfeaB/sx20L
	 3mfUpqPWvTH8K6uYW+zqAFuY1Z5fypHTsoWWLbi+8VSw6yuxjeYK3q7QAKXm3xoraiA9d
	 pDqDhdJ7Y8en0NkgOqWOOBCXld1BW0RQ3irZzCdwsC5jTeGSkjpzeVGd80MOoewC/OHAO
	 /YmkMqfPWQuACYJ+WKFvLLG02JbRmz7yB9tNTLnsj3hamo5kdPVzw0MhX3/jdwBBB3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760841;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=jzmVWeq1lSBWa8Rr6CPhlOXR2wYECd9HVUtHXs5F7uU=;
	b=H4L/HcKBmBdMDmXuGsqilowKa0g4szCoyN7JUNJyUlLKSUxGUR6Q9Yo3tbOsovPjYhNW
	 n+V0gfFG6R56v4vNtGPfYQiCC08a+ezSsj91ASs9fC/yVT06QlLydZv9RW4boFhmGJY1U
	 WT3o4NoLbdF6Yawc1z5MbgUxAAkqBs9rGkKTmV45hUEMu1NN1BXbHiQmAPh1OZNuRy/lI
	 D9Rt0Fd8BWL3u6zR4eJJW20iDJJUTiAfsMfl4n+zQlIbLdUUPk4vNT4u4gvSLxYVhcGaZ
	 /zy6Qg3cc3f/DEXS1GB9cXV2/nVoQnZE5JW8Ns6E7nKSqkUe6b66QzcJVEFRx/aHvGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F11606A33B;
	Wed,  4 Nov 2026 02:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F11606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAnUfstnupq7uQ+AA--.42219S2;
	Wed, 04 Nov 2026 10:53:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] net: stmmac: unwind the XSK pool when the initial wakeup fails
Date: Wed,  4 Nov 2026 02:53:42 +0000
Message-Id: <20261104025342.1527441-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:qwCowAAnUfstnupq7uQ+AA--.42219S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryUKFyUJw4rKw18Zw4Utwb_yoW8Ary3pw
	47Aa4YkrykXF1xAa1DXw40vFyavayxt3yUWw1xG3ySvF4Sg3ySqFyFqFWjqF1xWrWkWF13
	tr4vkr1DCFn8ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14
	v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lFIxGxcIE
	c7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l42xK82
	IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr
	0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bM
	3kNUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQBA2rqY+TkOwAAsS

stmmac_xdp_enable_pool() maps the XSK pool, reconfigures the queue for
zero-copy and only then wakes the RX NAPI. If that wakeup fails, for
example because the carrier dropped while the queue was being
reinitialized, the function returns an error without unmapping the
pool or restoring the queue. The mapping and its netdev reference are
then leaked, and the queue keeps a pointer to a pool that the caller is
about to destroy.

Roll the queue back to its non-zero-copy state through
stmmac_xdp_disable_pool(), which also drops the DMA mapping.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 9af9e0cb366c..4b18f03dddc9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -6,6 +6,8 @@
 #include "stmmac.h"
 #include "stmmac_xdp.h"
 
+static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue);
+
 static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 				  struct xsk_buff_pool *pool, u16 queue)
 {
@@ -48,8 +50,10 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
 		napi_enable(&ch->rxtx_napi);
 
 		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
-		if (err)
+		if (err) {
+			stmmac_xdp_disable_pool(priv, queue);
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.34.1

