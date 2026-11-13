Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=129.217.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566836;
	b=KwcfOUQnCFlHg8jJaYzLetQvjSIYcuf8+qYgjknlW9fTECa+ufWA83nv6wXegvZv4j6q
	 MfezMT6GcuIyq6XkzNwInoMaz7SBN2eKKSS8TFhKr6bQWpm1Y0WzekIU4l4H2uJtmioqM
	 EocwBqeC1REyhBE7e6+gojgmsoo5QkLpyJVOwmhjAvna1Hj8ETdfZj5DrgC10TGXlfRXB
	 5qH57yFS/yAl8iPHsbC/y0qh2V4UHymyeZlQLYtFzq3veXOsKrJNmdWJMIPyZdfWyBE0k
	 cShHt6jXZYaGxAvXdvNWZRLxSaibrcMtnM0VVDonYs5vbbTpP+UCSAJmr7QyuN4JtSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566836;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=u7N7gzUgcX1sPQNzqNwIWSymEUYVbtkaHyjM8kbA+H8=;
	b=S7uX18WYNKxzfwk0otMmH5fPVCHzQfj/VLN1dhIfM0kaEDjfnzDK8Lskq2q5e1n+Utnv
	 tbM6X+XR1mwvcCxpJFRf+5OzcRYdQrquEZLI/6nAkx2XJSsnQaQBQjJkWgCKswhKLMpGA
	 f/HWBBpZ1hWbK942/eZ3mO3dIUEfsXR13jPgcsMmGEgbFTlk3TY2zTQNYGCjcGm5pJU7H
	 i0zqiBq9A8Rkh7jOwNKOC3JgiyoeFlkMgEuShC9WBwr6tN0X8Qhe1aNtku9Bqyhr7yQZ1
	 ZCxA4utApo1ItP58IboBji63snEQ6H3H/QyHT8DiR7mnFo6IIM3FO1cY+A0Q1JnYOVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-dortmund.de;
	spf=pass smtp.mailfrom=tu-dortmund.de;
	dkim=pass header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=cv+IaMjH;
	arc=none smtp.remote-ip=129.217.128.51
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C2606A327;
	Fri, 13 Nov 2026 10:47:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 251C2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=unimail header.b=cv+IaMjH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1794566812;
	bh=u7N7gzUgcX1sPQNzqNwIWSymEUYVbtkaHyjM8kbA+H8=;
	h=From:To:Cc:Subject:Date;
	b=cv+IaMjHed+ohWkas+CvLzCXa0I0FzUAyiVgU9kJ9MPuUoAXIBf24CYhstBYeoURt
	 dNZyWE2SuLgBtDC41xXfvjsj0EmPbpF1ZdGVlu55NjLssMk/f5qSg9A83L2JZy3pLq
	 0nuQe19MCM2j0ol4oCRHQMaYri2jwjTZCk3gdoew=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.174])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6ADAkoUn009632
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 11:46:50 +0100 (CET)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Toshiaki Makita <toshiaki.makita1@gmail.com>,
        =?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, simon.schippers@tu-dortmund.de,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] veth: fix txqs that are never woken after backpressure
Date: Fri, 13 Nov 2026 11:46:46 +0100
Message-ID: <20261113104648.225983-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
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

While debugging the veth BQL series [1], I found two ways in which a veth
txq that veth_xmit() stopped on a full ptr_ring is never woken again.

Patch 1 lets veth_poll() wake txqs beyond real_num_tx_queues, as a txq
stopped before a TX channel shrink is otherwise left stopped.

Patch 2 wakes the peer txq when NAPI is deleted, as veth_xmit() can stop
it after the last poll.

The reproducers are below the --- of each patch. Patch 1 reproduces
without changes to the kernel, patch 2 needs a debug-only udelay() to
widen the race window.

Claude Opus 5.5 was used heavily for this series, to find and reproduce
both bugs and to write the patches.

[1] https://lore.kernel.org/netdev/20260612083530.1650245-1-hawk@kernel.org/

Simon Schippers (2):
  veth: wake a stopped peer txq beyond real_num_tx_queues
  veth: wake the peer txq when deleting NAPI

 drivers/net/veth.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)


base-commit: ead6fa9a0ab194f02a2f36d634b193e9c5f9a1c6
-- 
2.43.0

