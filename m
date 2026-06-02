Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20023387371;
	Tue,  2 Jun 2026 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419310; cv=none; b=sEUqk+tpLc56oOrgMMIXLfIONdkPP4g5wVC0xXAPF/vWBKLzPKVZJti1EUXxtFj/VmL3pqXTKX8AJ3zIahU6IzwyGq8A1Mgbc0SyHamaCMwFpmHBAytY8k69ReRZs/S1TzGiyq6MZjBgJft2X5bm/ZRNNsiwQtdgvUpn2Xg7H+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419310; c=relaxed/simple;
	bh=qnqfPPzl8yVNLiEqR4t3HOE3aRMUA7iDzMEw7jiq8e8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QN/69W/lJwDucxkNp5jQf3D1DlS8uaSkRtDOkeq07+g81za/+tq6qiS2AOSmtw8dPEwv/KPEZtS0ABMHKRXjUhQuUtSXua/cJaHt3hXVLsGQUeGi9+GsIspHY7DDsoncP4bslBcdE4tM/hMyzX+uc9+nBVGKAbwHwh6kNv4wM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=WcgKU5SM; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="WcgKU5SM"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id C486F2408DE;
	Tue, 02 Jun 2026 18:47:05 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id D8A93240102;
	Tue,  2 Jun 2026 18:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780418823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2hef6S3M+brgMzf/Zf6OJyNEhKKdc11RtVH6UQ+ns0s=;
	b=WcgKU5SMdeqPvS6K8WM/ZKWQzPocPr1vTqQZb52H8ud8eA0KYde0GGmv+8EjRRkvdwYUKy
	lK9BYbwgjWz2P+fLoiH88/kbeZqmn1U/zldWAIQl8Euo8nh723TRl+bunGSVBKoKpgBnjK
	bh9/mnCSiwgqGRKyZ8Z55nShZNreBlWDMxYgzCx7/yw9qjth/jgwl/fUHapiaiuqyyTfDv
	qebcsI1knUMd5LUreyUypRKxbYKWaA95hmu2U4vCK9fw14kLDdExbAHDbH0XnQ6WKWnsXY
	Hmdb+TjSi2P0xiyNQBmIVz76bRU23HdpscjOdWAB6l4Uki3W7LQDN0WZ4AwygA==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 03A45240025;
	Tue,  2 Jun 2026 18:46:59 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Matteo Croce <mcroce@redhat.com>,
	Sven Auhagen <sven.auhagen@voleatech.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v2 0/4] net: mvpp2: fix XDP RX buffer handling
Date: Tue,  2 Jun 2026 18:46:31 +0200
Message-ID: <20260602164635.62517-1-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: d13f0f
X-Rspamd-UID: fae65b

This is v2 of the earlier XDP_PASS fix. The XDP_PASS change is retained,
and the series now also fixes related RX/XDP buffer handling issues found
during review.

---
v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/

Changes in v2:
- Fixed RX DMA sync range to account for RX headroom.
- Limited XDP frame size to the actual RX buffer size.
- Fixed refill error paths so retired buffers are not returned to BM.

Til Kaiser (4):
  net: mvpp2: sync RX data at the hardware packet offset
  net: mvpp2: limit XDP frame size to the RX buffer
  net: mvpp2: do not return retired RX buffers to BM
  net: mvpp2: build skb from XDP-adjusted data on XDP_PASS

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 38 ++++++++++++-------
 1 file changed, 25 insertions(+), 13 deletions(-)

-- 
2.54.0

