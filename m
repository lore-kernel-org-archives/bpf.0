Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DC4DB54C;
	Fri,  5 Jun 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661695; cv=none; b=Jo3Vd+NCA0efPIWbJXXP75yhvg5NRlrUvyVCtQjGAWZYaaWd7pv6iLIaG5RGeXAvCz8UI04GEFKYmN1QjVpEc1xN0Og8m1NafKu9kwWgYpfRIVIFwIaoS9qZz5NOTWOaymZWkpH0O0YStXVmdZirNutOwUJ87TUO1O5KU/jYjQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661695; c=relaxed/simple;
	bh=QfcWkFX0aw9kODXtrdl83KHWygAL51sgg7DFmeoPpA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C73qI63gK3VkbicTLL1QtyBYmoUuigsd7CROSmquhlXBJPsUyWPlL+N+jgj4rmB0Q98e201LHxCI00UXPR3gta0IcM0vqlw1ndhM4Fl9pV7T+aDe95qOsoVf2FuMPn1/dLzxXr0OusmI+e40Pnqc3LgHPXTqjrThyCI2oCG6tNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=jLNA9VLb; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="jLNA9VLb"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 8B76E2400A6;
	Fri, 05 Jun 2026 14:14:42 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 9DD8A240523;
	Fri,  5 Jun 2026 14:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780661680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKpKdUfC/92Xq2qHi0hhtk6ezo9Jr0HkrFUTxGRYJHg=;
	b=jLNA9VLb7prPkX+UKypcT1H0OtbrirBIsKmpVB9Ebv4LLKorhhIgPWHYNPEXvYaqSO5OBT
	p1pJ4/dhTuLRcjgN1r0Ic1D82wRjSxy5/OkDlMGmYXQBd7J5CJkFkyzIxbLps12eDLPMGT
	rzTahbwlz2EKOPTXvEtyTwSp9zDuZqKf3ytWHXUkSuGpiDYKD5SoZhbWyv061oMqMPZxSi
	tpxXwwhbQvUbGlaaRMYwIMsuuNOTrIttw2TMkPGnTE05sUGP9LLzEsOQa6MLLE7uZCM+e5
	XonhbZ1t0Ufqjf4Z+W/1UCfGbrPJZ/atkIwA7nnyvo5ntLRJ94ZLYV/Re2RyYQ==
Received: from Til-Notebook.meshlab (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 3C55624034E;
	Fri,  5 Jun 2026 14:14:37 +0200 (CEST)
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
Subject: [PATCH net v3 0/4] net: mvpp2: fix XDP RX buffer handling
Date: Fri,  5 Jun 2026 14:13:28 +0200
Message-ID: <20260605121332.147397-1-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602164635.62517-1-mail@tk154.de>
References: <20260602164635.62517-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: ece77d
X-Rspamd-UID: ab1666

This is v3 of the earlier XDP_PASS fix. The XDP_PASS change is
retained, and the series also fixes related RX/XDP buffer handling
issues found during review.

Tested with tools/testing/selftests/drivers/net/xdp.py on mvpp2
hardware.

---
v1: https://lore.kernel.org/all/20260524122334.1730451-1-mail@tk154.de/
v2: https://lore.kernel.org/all/20260602164635.62517-1-mail@tk154.de/

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

