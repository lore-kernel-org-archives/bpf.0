Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3730EF9B;
	Fri,  5 Jun 2026 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674323; cv=none; b=o4DVyU6o1TYjR1+Ak0JYzBTlBcfVNPS46EgtRNXXDnlnVXXOSVpQR6fxPmPwAMRJ87WfaAWouNxJr8QYA1DJrzWNakdTzvXut2VzIN5meTF22k6PTDbykysXGejx3iZ8VuR6kAM6n5bPo3VvNk6OkPp/PQd8xl6uJDXuMzth8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674323; c=relaxed/simple;
	bh=evstT5AQzuQfOFZzt57PgLgV9THIu2v86e82J+pbOFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9Id9iIcxPYoCF3O7lJgre20yMnrO/RErNtWN0iRnVXQlsQQpdA4Ecd44Bq3uAivC4NK6Dt+piQ9dA8etUjwcxXd59cZJC5iB6hDVkXyDpFMayDCWl52hCfmkPMoSVtQm86/YplShDRyn1P1Ccw5+CCVxgVP+W42mv5aKP6HiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=B52EyhIE; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="B52EyhIE"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 4EF53240069;
	Fri, 05 Jun 2026 17:45:17 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 6473E24016A;
	Fri,  5 Jun 2026 17:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780674315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VB2msiqAX8ETz7EG91isMk+QZv7d+BEDx4/Tb94VLdU=;
	b=B52EyhIESoOzi3SntjGZ5LN73Mz5LD9ytKA9nMX+G8UYcGD5rQ8VRFebiYlTSAx7/0gVnY
	wlrExgkEbYZLqAIy2at8Ba0CjIlN7z8fkc04S+SgLtYQpPEEblcbDgGMOyQ4yD3XmBNszM
	REbmgmOKaaLX4Cy0GgJV7qP8SrNM6xa28KpAgQvyitukww1YLfkJeAdIX0dlYcc9PY3CNP
	4ewQ5s7P0a4nMm9Ba7dXYYy+iuSSbyRJX9uIT0f2jvthWQNTIfJxWOxtWFy+tHOarhmzT+
	xwRdYupGji/24fpBT5kolDcSt1vLtM2TBjS7aGqbBAg1214zl4lvlymMkwUhHw==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 5F3FA240282;
	Fri,  5 Jun 2026 17:45:12 +0200 (CEST)
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
Subject: [PATCH net v4 0/4] net: mvpp2: fix XDP RX buffer handling
Date: Fri,  5 Jun 2026 17:44:53 +0200
Message-ID: <20260605154457.163304-1-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: dad915
X-Rspamd-UID: 97db6a

This is v4 of the earlier XDP_PASS fix. The XDP_PASS change is
retained, and the series also fixes related RX/XDP buffer handling
issues found during review.

Tested with tools/testing/selftests/drivers/net/xdp.py on mvpp2
hardware.

---
v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
v2: https://lore.kernel.org/all/20260602164635.62517-1-mail@tk154.de/

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

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 61 +++++++++++--------
 1 file changed, 36 insertions(+), 25 deletions(-)

-- 
2.54.0

