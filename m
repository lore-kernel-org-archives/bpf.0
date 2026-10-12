Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D1421EFB
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806687; cv=none; b=oF76GYwLRgej3XI7n4lI2pVfNNPwfeBSItE0FwQWRmuaMrdSUrF8GGSV6fo0dcmjf7fBz/qdiYVESitDEXbUe6A2dRjnY0oOKAYIVIBZttwCmQysxNfh7AUimZu+4UliM1aJBSJ3YWIOsZ8e8ZXO6R2wID1BWFD5a6MN1UArTik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806687; c=relaxed/simple;
	bh=GKuNG7l9OxY2iWSagwHzMkiUC0u2XtA1gq+I5Pvevu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WdWLOgHo7aNRL81kPTXA5JPB+b9RoTBt1XfvY+JKI1s+uX1hkUyUXiPs1AWbfrS6xpd1ZR7CPmwaol5Gs1M1gMqzv/A49ux9bcMLLkK/x8W3/VjCQuIBFzL1aETOX7UFBKOqw0j4owqHewAf0Lx7/09YTabvIcfnZ29UFywDqOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoTtFHOR; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoTtFHOR"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4af173320f9so1037235b6e.2
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806685; x=1792411485; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YLoFk8ZNgH0gWK/445CWsD3PptLXhPGeZtskXg4vEiM=;
        b=qoTtFHORoBYic0fpSQBOZN89ce0MAwjZ6pvjUYmSWaD5AFpOyDvsi6WrtWuB+oiLnw
         +wZiDiJNtsdnPRIdKx1RA0P9opaCQpE+6eDJhr76d4emM+LtkzEjbTWqhyg8JgY1382U
         Wu5FtAemEIaVIKjSa9djioYA2rX21WuctHS2QvKw+6cGGrD1B4y3ITO3aepr1AMqoQwr
         zXN+FrrMhHvur3vfV3l25i+p6sctUVMWrvzoW9Ssfk80/mxM2/7BnwlhkGX11IBph3y+
         L+vAj3gHBFVNqBIAh1w4CBEGmy6hT7jkvZqxLXRukcBsacFPdc9BsIqvVK4p1TBxRIit
         jsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806685; x=1792411485;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YLoFk8ZNgH0gWK/445CWsD3PptLXhPGeZtskXg4vEiM=;
        b=VONaCRC9yqVPiTjch0zXBrKrbssgPxvAkZmWCyed0n3COR9jKEfxfjX7q9jdzmQySh
         HzrWxB8+T8RbuVQ0+EBdT+NirPYWPf7aLFfPkEpF/pYa8drPxGWCkjVABJR4ZgyxBnMM
         F8YlYW+UfpqhtUWGfmY9rJOwWyh3Y02snV4lRQH9fBknNkiinPLCySFBUGmWRG/vhU8K
         4KPs/Y4um8FOt3sfDl3K71cqEI4Y5HH10Y0PIVKHhp620WKJfergJmMaA2samDPTBDSy
         JndilbeH13gnC2qicZWBdZbYGjTt0GF805FM7+H55OThT/0D8IAjcvEjgRvMPmnjGRjE
         oYgA==
X-Forwarded-Encrypted: i=1; AKwUvBx3SemAIF/UUq40xL0YAjWf3KwAyZY7N8x6e5sAxpI04+hCsqnWRVolYHcH8Lpx9/gMl0Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYIX+6lpKAlYooKp08/0+/GEB6YWH6MK+Y4aWOaGLMpzOTH1AeVN
	klb5FizJyHbODwg/62+TQUeRy6R31fFGRSNLO0/pAHsGucjyR4gUL+9s
X-Gm-Gg: AYBFou1gZD7fBpL0EYzQVfeEBFZ5SslPcxfSEGReGzYuEuoO6eQoX1zG6k1aq2esGxB
	aMBP4Ayf8m3VBTpBYh6XE+bAIEmPTkIoSwbdyIfrs151osBDxGSt6ijqFnhb+QWHQnu1IJ8AfmZ
	vURLaRvOx800H/57WbBizxYKwlgQxHmm8rgXXJ7zj1KL12hlZKwyFTM8D/9rWADHRf4jwEuaxdm
	eVXZBwVF2xMALjjxemelEmc/WSYgF3K0IjK1Gcvrl6fF8HIUnlHxOrdhCxfO3fJahGmNtJqDHqT
	gjeTLPMT7A5dfL8FAkEgzFKImC9MryXE76xQO2ScoQaer7ji2nTtQhRLbdUvdPYTPpuHMt2+ojy
	1I3BMryHpN9qitKAtDxVDrP8JZ1GMpXaDPSP6TgcX2RSPhCfYgELuBrZwFpepxI+5pf0qUEkMGs
	tWFdYMQEzObmsjyCM+F4/xcUgOvFCpa7aVhmp33NRKhoEB2FIl6eQ7ZPFEd2yhLlk+nClR
X-Received: by 2002:a05:6808:2206:b0:4f8:4a95:9969 with SMTP id 5614622812f47-50c4e681aeemr8213477b6e.15.1791806685325;
        Mon, 12 Oct 2026 05:04:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1815fd26sm11497645b6e.10.2026.10.12.05.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:04:44 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next v2 0/4] eth: mpnic: add basic netdev statistics
Date: Mon, 12 Oct 2026 05:04:33 -0700
Message-Id: <20261012-mpnic-counters3-v2-0-8afba81c2d5a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANHMzGoC/2WNyw6CMBBFf4XM2jGlRR6u/A/DAocRJpGWtJVgC
 P9uQ9y5PDm5524Q2AsHuGYbeF4kiLMJ9CkDGjs7MEqfGLTSZa6Uxmm2QkjubSP7YLBXdV2bR1O
 aSkNazZ6fsh7FO1iOaHmN0CYzSojOf46rJT/8r9r8VZccFVY9VWVREF2Uug1TJ68zuQnafd+/5
 Iww8bgAAAA=
To: Alexander Duyck <alexanderduyck@fb.com>, 
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
X-Mailer: b4 0.13.0

Add basic netdev statistics and report them via ndo_get_stats64 and
netdev_stat_ops.

Track per queue netdev statistics such as Tx/Rx: packets, bytes, drops,
etc. The driver keeps per-queue state for statistics that is updated
mostly from the NAPI poll and ndo_start_xmit paths. The stats are made
available through the usual driver APIs.

When the netif is transitioned down, the per-queue stat counters are
folded into a global per-device set of counters, and then when the netif
is brought back up, the per-queue counters start counting again from 0.

Extra care is needed for implementing ndo_get_stats64 since the instance
lock is not taken. When ndo_get_stats64 races against ndo_stop and
ndo_open, the reader can attempt to read per-queue stats while the queue
count is changing. To deal with this, the writer publishes the
aggregated base stats and the active queue counts in a single RCU
versioned object.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Changes in v2:
- eth: mpnic: count packets, bytes, and drops per ring
  - count Rx frames dropped by the driver in rx_packets and rx_bytes
  - disable BH instead of preemption around the Tx flush stats update
- Link to v1: https://lore.kernel.org/r/20261009-mpnic-counters3-v1-0-7dc7644cc500@gmail.com

---
Daniel Zahka (4):
      eth: mpnic: count packets, bytes, and drops per ring
      eth: mpnic: report per-queue stats
      eth: mpnic: count Tx queue stops and wakes
      eth: mpnic: count Rx allocation failures

 drivers/net/ethernet/meta/mpnic/mpnic_netdev.c | 182 ++++++++++++++++++++++++
 drivers/net/ethernet/meta/mpnic/mpnic_netdev.h |  29 ++++
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.c   | 183 ++++++++++++++++++++++---
 drivers/net/ethernet/meta/mpnic/mpnic_txrx.h   |  30 ++++
 4 files changed, 406 insertions(+), 18 deletions(-)
---
base-commit: d8674294aefef02266c4d47ad10131f1bffbe534
change-id: 20261002-mpnic-counters3-d08883b96372

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>

