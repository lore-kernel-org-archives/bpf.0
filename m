Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E013AB29E;
	Sun,  7 Jun 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840258; cv=none; b=dXCziG4lFXiNdgMDVHMlP0czjeaz2D+Sv396Q497OfqtWafla2BCIccWd2PqrI4RbE71KrjHY8b7h5nm9jmYi6/LCtrHrbFJb8STBJPXUOp9l6gcTtcZqmPcRzgJoISRkmUu5cEEAiK6IoQPyk0gidgc7fxZfniwHc3ZyBltYsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840258; c=relaxed/simple;
	bh=xVpGXQjW5z6eyU+GUxxWplVBYw1+nlCwHkms84d3DS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc4B9RGz7OohwKPx+6yFIvlV8DOHkBCgzp98ORsMBrAn+u4hnu9vRzId6VI3YeD5gWW+apTdo3jhJg6R3VOkrX5gyM3ecwyFc5XnngxYxJ61hdeWWhy4O1Ry+F0ZzBCO3uH3a8KFYn9G4hlq8eyp0+XZ1OUCtYB86yJagvkaBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=Evj2L04x; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="Evj2L04x"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id C9D02240937;
	Sun, 07 Jun 2026 15:50:44 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id DA251240263;
	Sun,  7 Jun 2026 15:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780840242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RY5vvpBdIrhlPmSwQt+qsx928b8LsAM9g3/uCePEky4=;
	b=Evj2L04xkrrFMzGrZeY+67ieB3ybNuXg1zAWRgDpU2UXzXShHpMThwlEc6uPikhiwsIjXj
	m4xamoPXTfgYXwBbjXjMtVP/NU7Zn1s1QhrmuJwLJ6OWCxpW2U1CMahJMTPdPQ7szaX7po
	0bPLrdt9cflGp9Sr5SaHrvtm4wWeMR4VplFXuiXtMyMaQBteYZFXifzc1djouJ9URKku7e
	wC/1DCPuAXTfco/JDqCtbO7bNZIeLS5/gqKZ/dGAivIxFdb0l8p2xt+5qwMKnzxRuaqcMz
	VmyI+ji0mapBeOUS7zJMmyBsQFglWdMPdrd0hmTmVINCHe2RnUtJlQleseCUEA==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:3300:7fdc:421c:b21a:ba71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 9D3BE240023;
	Sun,  7 Jun 2026 15:50:38 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@redhat.com,
	sven.auhagen@voleatech.de,
	lorenzo@kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v5 0/4] net: mvpp2: fix XDP RX buffer handling
Date: Sun,  7 Jun 2026 15:49:39 +0200
Message-ID: <20260607134943.21996-1-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 976ab9
X-Rspamd-UID: 8272ca

This is v5 of the earlier XDP_PASS fix. The XDP_PASS change is
retained, and the series also fixes related RX/XDP buffer handling
issues found during review.

Tested with tools/testing/selftests/drivers/net/xdp.py on mvpp2
hardware.

---
v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
v2: https://lore.kernel.org/all/20260602164635.62517-1-mail@tk154.de/
v3: https://lore.kernel.org/all/20260605121332.147397-1-mail@tk154.de/
v4: https://lore.kernel.org/all/20260605154457.163304-1-mail@tk154.de/

Changes in v5:
- Kept a separate page-pool recycle sync length for skb allocation
  failure, which must stay tied to the received buffer range.

Changes in v4:
- Reposted as a new independent thread, no code changes.

Changes in v3:
- Reworked RX refill failure handling to preserve BM pool depth by
  refilling before the current buffer is consumed by XDP or an skb.

Changes in v2:
- Fixed RX DMA sync range to account for RX headroom.
- Limited XDP frame size to the actual RX buffer size.
- Fixed refill error paths so retired buffers are not returned to BM.

Til Kaiser (4):
  net: mvpp2: sync RX data at the hardware packet offset
  net: mvpp2: limit XDP frame size to the RX buffer
  net: mvpp2: refill RX buffers before XDP or skb use
  net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 67 ++++++++++++-------
 1 file changed, 41 insertions(+), 26 deletions(-)

-- 
2.54.0

