Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD723CFF65
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791923748; cv=none; b=nJr0+JEwOHLOFv+fmIy5ivp5KjGlTi0XOAuqXqjVRuYDqL2i6flsn++BLnK8biT4/xNxKIPO8CAe0AXuF3xMuoV4E8e3YSumE9gb/eADR0z26zlJSwF5KwrRgnSkjk4L3eSmKkTcoXOtcWSm8h8EsAEefWFmR+NcXUN1sq8kqa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791923748; c=relaxed/simple;
	bh=jJkLoXcaXsj0xctC7jtURA2sKakwQ6b+J+tP2c2X3WE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FwfJjHfF2txDJIvU6YiarWKBdwgAtge1UETSm5aD39MWTEY5YcQoODoZ7ZLgYDHE05RHrnu4fZ9nZyu+uUX2iujYMEYVv2POP2cRC05b7fP6wauLb0AdP8yCsfKhYA0gf0/eR2VveKXaAzfmJBUmN11v9U4xOt7/8yeJrPwGkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UraZaH7G; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UraZaH7G"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-47b47de8b4cso2069469fac.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791923746; x=1792528546; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mdu7JDYg4pNMYKBbp9bk7b11wP54fdQOVT/LCjvbPgg=;
        b=UraZaH7G7mUXCiylaGKrN1v0WsILintqSbkEmssGsFhBcv4KJ5sWmvEOKPRyOavbK/
         PJOvEmmHfDEtyGbe+lPKSbYZ4MkKk1bxkZBjzpL2muXIhDO1TfX5w/PtUf4bpJBYFoba
         A//NoiEq9KxCXonmai6tRFR7bP3tclnc7saMj/N+nrx+mu9nwb5KRAunh6pYQvH905Gb
         vcwK0yC/dZ6Pbuxb2w+It0FH3rj4lXUqd3LgfPQ/Kh9Kz2LocwL8DgxTWkEYUAUZRWC9
         tUVwns0wI62GnYbwB+HyAEBhYf7nz5KrVbXutJRuKg7RfOtvipraSFc8hdcooxZr1Qse
         MoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791923746; x=1792528546;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mdu7JDYg4pNMYKBbp9bk7b11wP54fdQOVT/LCjvbPgg=;
        b=VsV6AmE/EPeM52c6SFpY1nJ5g2wDUjA3e4IBZBQi+aQlU5Bj9FiTAD8IDtLbKUz22Q
         FZh0rbEOqKMSPlCnfxJM4AY604Rv4njkk+TLUGebcsmyLGpU5L8jXIwYK2R6iattSlKw
         352Kn8+Ix1gZY7P7+B0O8+2brY2MVrxP31xIRr0SLRm0E7ExfAWrnUyp9bi/jobw0TXW
         ck291TQlsYGXTVY6fYmu6SvN1eHml6+abeHCC9WCean+4U2glsgF4kycCAnGbknv9Bf0
         Q2a2qzpvIYYsS/o0+VW6uWB9XSzXIV43MvsvSc4b5oCJptG4Su8T6Bcx2g5Pffyy7Kvp
         Xz7Q==
X-Forwarded-Encrypted: i=1; AKwUvByHI/8U3ixTY2iDiP4E0Dc0o7xw9NXoORwkIgLsnB3qeMraGV2C95sMOCQEmufeQXTKLLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVRZfQ40kHzbMCUbP4cniOVoiXwWJZft91pX7XoPgGYLq5Vu0C
	az0WKkSzAugr3U+dw5ApT2EntB/RcUPNSXC0wSeESGapN/zkKM7APhGR
X-Gm-Gg: AYBFou1uYmVAYmxSolSdCJ7yOuQPHtucdBbl9qJC0PA69hOtQtHVGLJ4fkPcEV7V9fZ
	lqMrx3oT/I43Ca+bj8RmIXp+3tB/yJ/NESm8d9XMaOvey2wmRzSUNek68uYqpWQGA2/IYkXPTVe
	0ihK9XH6nwInE0R80nqmCJPSx2UQmUd3DEdCkvGQkkyqTaOMtjIV1FvjOtQFTH6KJli1KhY+YsT
	pw5WtzJoX9zDGVtff5unQPK7u0EmgFRJ+wG1cL8StEOfOZX5nP9FV0QFV+rib8aw60YyFExwYIx
	cjykxta7bxvFjSfVLydQRJ75Va6WBaTGTamqHGnu5NbsY3t9YG0AMNN6dhVraaMluArThMMlNu1
	v1Ifp+4n08CpbabrSr/W3gNt0SBw2pKipCCCNATWo4WcgnNMEhcOLhgHeNvEoWwVm4SsocU5/6B
	ab/0kWoJ8FVGIsYYdhY+QJVAmYSbSkKuQRCeab1xqJLwH5QR0Ini80pD+RcbNcRHotZNRYZX6Y0
	Hg/+Zi/0/tH2kffk8lhV+znO4Eqg+rR9CwZJqiNeUA6UWlD5QBgB3O5azm6HlAGQKUVq3Ivnbcn
	8EQBimZaC89KocrsozeZWFEOUSSLAS7qmvsCe5vH5N8TekMQo322SIf/hnF9orZqzOs/LLrJ9yh
	bonKPb/hS3EyIqqVIOI4o
X-Received: by 2002:a05:6871:54b:b0:48f:e25e:e203 with SMTP id 586e51a60fabf-4a2a89f4067mr11899379fac.52.1791923745657;
        Tue, 13 Oct 2026 13:35:45 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6df871f44sm596045fac.1.2026.10.13.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:35:45 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 13 Oct 2026 14:35:42 -0600
Subject: [PATCH net] net: stmmac: avoid duplicate XSK TX completions
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-submit-stmmac-xsk-tx-completion-v1-v1-1-f21b9d098e62@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWN0QrCMAxFf2Xk2UA7YU5/RXzoaqZR240mjsLYv
 xv18Ry4564gVJgETs0KhRYWnrKB3zUQ7yHfCPlqDK1rO++cR3kPiRVFUwoRqzxRK8YpzS9S2+L
 ise8PnRvDcfBuDxaaC41cfydnyKRw+UtLPSjqNw/b9gFVMlp9iwAAAA==
X-Change-ID: 20261001-submit-stmmac-xsk-tx-completion-v1-88760fa9b103
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

stmmac_tx_clean() reports completed AF_XDP TX descriptors through
xsk_tx_completed(), but leaves their buffer type as STMMAC_TXBUF_T_XSK_TX.
The slots retain that type until they are reused for another buffer type.

On interface close or XDP teardown, dma_free_tx_skbufs() walks the entire
TX ring, not just the dirty_tx..cur_tx range. stmmac_free_tx_buffer()
counts the stale XSK_TX slots again, causing xsk_tx_completed() to advance
the completion-ring producer for buffers that have already been returned.
This publishes completion entries without matching outstanding TX
reservations and corrupts completion accounting for a socket which stays
bound across the teardown.

Reset the XSK buffer type after counting the completion in both
stmmac_tx_clean() and stmmac_free_tx_buffer(). XSK TX slots have a NULL
skb pointer and no per-slot DMA mapping, so the SKB type represents an
empty slot. Pending XSK descriptors keep their type until they are
completed or released, and a released slot can no longer be counted
again by a later cleanup.

Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Assisted-by: Codex:gpt-6-astra
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b837e8e27a35..1527e03711cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1742,8 +1742,10 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 		tx_q->xdpf[i] = NULL;
 	}
 
-	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX)
+	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX) {
 		tx_q->xsk_frames_done++;
+		tx_q->tx_skbuff_dma[i].buf_type = STMMAC_TXBUF_T_SKB;
+	}
 
 	if (tx_q->tx_skbuff[i] &&
 	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
@@ -2926,8 +2928,11 @@ static int stmmac_tx_clean(struct stmmac_priv *priv, int budget, u32 queue,
 			tx_q->xdpf[entry] = NULL;
 		}
 
-		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XSK_TX)
+		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_XSK_TX) {
 			tx_q->xsk_frames_done++;
+			/* Teardown must not count this slot again. */
+			tx_q->tx_skbuff_dma[entry].buf_type = STMMAC_TXBUF_T_SKB;
+		}
 
 		if (tx_q->tx_skbuff_dma[entry].buf_type == STMMAC_TXBUF_T_SKB) {
 			if (likely(skb)) {

---
base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
change-id: 20261001-submit-stmmac-xsk-tx-completion-v1-88760fa9b103

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

