Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823006;
	b=AYkhTcENuSGolQZkmPMcc7J/MU2EggFmJ914BT7kuc2xyoBMsN5j+WrXi+STYmByFtTs
	 w3g2oCBRJKqZCWPcfEUdwoo6whXVeuvT5gW3WYRL1IK6asH4fVFRCw/yexiDKUTkqiQnz
	 hK0Me/Vucl9AEamyy1/us1bOU9/OGwAouQFrk9HkTiKzyPPnnsGZsXlcYYZU3OhtxNNnR
	 ymha+cHdV+ysxkQF3gSSiW277BeH55h7+D6pMy8Pvm8ec6Df8EORFN2xwPg70m2C4zMrW
	 h6hmTsFOhtnOgdZ8nrUn0A8YPokV6s9GoxCM5zQTxULxlbiECOqkWSJjFplDyHb+TJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
	b=r5Q0AnCXLlxG3JvVp/xLYaYZfRBwM+3DaxyhJW7JuLTu996xAa1xJodkR7WvFcj/2UCT
	 Jyf3MnD1zZGPhWsQO60WyoSsfTqYSVFUOHmjvNYcU5I1nSdRgnHC9f+DAe4LH3IpfZqsn
	 4nh+8OWYp7g1QORV6ZpV8aoMjjFYx658xYKEUcjRCGCMPYaAqgg/s15tI8Chqbbenqktn
	 v54FZCCMRnL1VhRpjctgGwq469uyVIcRqydHvJwlV/N5ovjEyZloGgWYy0PNrJfbQVCdK
	 Go0FFJzXtMca5qoDjb1uK+q/wAGSVWYfUmbB8JceasIAIpUPCAicU7hoKTaB7madNMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAmB6tB5;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524DE6070F37
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 20:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524DE6070F37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pAmB6tB5
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso10183475e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793823005; x=1794427805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
        b=pAmB6tB5L5Q0sXbpgw5MAvTI4uEVXOApuJPbfWOIyoio0S+Pk3ev+Xx+LtSaVDmZTb
         UtFs6xBq+HXY5ygUQ+qI7ayP+uN7rCJtM8Qo9UVtZesPJVPeKvFlcvws5jR2/iHFxv8Y
         veQ4oIX5N8YmBuVrhiXgkHYskpbffM0MwfPIRXC7NJyGDG5PAu/N2qWJVRrIBA6aDEf6
         liZndmGbC429jfE5e+Md/TpWVIyFUGja7Frb7Z1IKMKT4ruePVenI36Bw6OzDbXmKqlY
         AfTex7dzu322hFIm/ozi7mn3h55E6OP8ewbasszG/05oRQBr6/fSrgczdbozEEt+dWBj
         iLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823005; x=1794427805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbB/h7OcDLTENZAMlqrgPHDqleGuLS+XSh/+4bmYjVo=;
        b=XYjbDGpnFEHEdjfuSQXQAKT1ro7IgEogMdyowL8BI8AGkc7Ferzxm/njvwtVHHgZ1b
         gzNlXffX4MyaOe6x7dPHCW7WLjVRvgDD3bTJVmaQOOiEfag1pQONW+Lz4/xjd3brwLrj
         mCo9Lyqz4fpH5qz1mvpDmA6bs3FfwL1SZ3ey1mgL3rD9G87gFsnBFk63bqjqAzu6cYN+
         /gHF/hK7s9fPHTB8BSHTAzYLLi8Kc3FxI+fDpomzt0mP7EA0RdkA+j9SL2M/js58bHti
         lHw/J7gP5JnIBAAMM5MaUb5qWQ0haJF5fJoHC+VVv4BZXuACjFsy+gwhncwgTW7kbZg+
         fojA==
X-Forwarded-Encrypted: i=1; AKwUvBxP41+xFlzebKF7Hx1qBaDbZ+m0F5Xe1/4PKdjtHic6L5OexiLGd9JI4O7jdJ9VCprTCRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z88tmUzSsoz5t4JNb8+M002rzZg6y8h3oCXb3FoeJMmAIipImSH
	cJERd+IUNUVVgTXVJKQwglt3q2X9MYf7VBhOKfO5AVwOJIvzO8GXpcdA
X-Gm-Gg: AYBFou34Tv6bNsu4DWliwgSUMGClaeG7Y580zuav/BIb2voTEK/3ycpJXsF8EhSWAeF
	20QFXU8NrpDe/R/j6Ux8EQGzlAaxWneAfYhuh+G7fWoWGEAU2yFk6s/nxQFGYkO8QRj38aVpSJL
	iw2BLSL39vc+k0aPbzOl8B6vt6L0qKXzn6fcn2QgoDpMCTSSuzntEACAX65c+tVX8i0phxuXCWg
	kBLS26/QSmSQXBORrwzWMBzHjJjVhNsadsvWFYIoUQJauXPImY0rjRSMTKBoL3nMUaYAvCOtrIL
	gL+dKbcf+D5w5YU65PUJycATfANX7M0C2zuLGn0ko0WzCaY/dygnfKdG2U/3FsAQxnl8PmVIU3L
	SHQCHQMU4A0NAT4DZx3+c4MysIb1yYvVuS3JThhMjow7/eM4lSMLWhaXyMjxDeSM2E+oNuMC7Sy
	+jO6+4dy3lVpev4yxfrEjBudL+aCUT3p3lcrZS6uLo9eaIOZHjfAAzBBxq/MIlpflzEjsuQvsez
	WMhYu7qTbDedXVSRAILrr1Z2nFbGMf0mLqExltISdUmQ8IrKdppFyAOftmdSUZCtykUDyG/gzss
	oJ1JmD4vCHVZy+l6djShnRtlWPoKlScnMnJkgf3lRaRx0qH9EqldDJEv8pY63hyltfDJF/wEg4/
	uYmz07Iu9YeMojpI8RnvkRgr5Y2SyjyPCtat2DcnI8wl+w3A=
X-Received: by 2002:a05:600c:6216:b0:4a3:5aea:21e5 with SMTP id 5b1f17b1804b1-4ac1737c533mr377961885e9.9.1793823004484;
        Wed, 04 Nov 2026 12:10:04 -0800 (PST)
Received: from center.jhjvjihww5qejoy14qwv1cc4td.frax.internal.cloudapp.net ([131.189.143.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56eb4da1esm15954045e9.6.2026.11.04.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:10:03 -0800 (PST)
From: Orgad Shaneh <orgads@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Hu <weh@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Muhammad Falak R Wani <falakreyaz@gmail.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>
Subject: Re: [PATCH net] net: mana: fix XDP_REDIRECT of pre-allocated RX buffers
Date: Wed,  4 Nov 2026 20:10:02 +0000
Message-ID: <20261104201002.2215474-1-orgads@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <autbwKmZPPWEj0Dq@boxer>
References: <20261102064324.806414-1-orgads@gmail.com> <autbwKmZPPWEj0Dq@boxer>
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

On Wed, Nov 04, 2026 at 05:22:24PM +0100, Maciej Fijalkowski wrote:
> On Mon, Nov 02, 2026 at 06:43:24AM +0000, Orgad Shaneh wrote:
[...]
> > -	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, pkt_len);
> > +	act = mana_run_xdp(ndev, rxq, &xdp, buf_va, from_pool, pkt_len);
>
> I wonder if it wouldn't be better to work with rxoob objects which seem to
> carry the from_pool setting?

Thanks for the review.

The rxoob no longer describes this buffer when XDP runs.
mana_process_one_rx_pkt() calls mana_refill_rx_oob() before
mana_rx_skb(), and the refill puts the new buffer into the same rxoob:

	*old_buf = rxoob->buf_va;
	*old_fp = rxoob->from_pool;

	rxoob->buf_va = va;
	...
	rxoob->from_pool = from_pool;

So by the time mana_run_xdp() runs, rxoob->from_pool is the flag of the
replacement buffer. The flag of the received buffer survives only as
old_fp, which is what mana_rx_skb() already gets as its from_pool
argument and uses to free the buffer on PASS/TX/DROP. The patch passes
that same value one call further down, to mana_run_xdp().

The two can differ. Refills come from the page pool (or from
xdp_save_va, which only holds non-pool buffers), so on the first pass
over a ring of pre-allocated buffers XDP gets a buffer with
from_pool == false while its rxoob already says true. That first pass
is exactly where the bug shows.

Using the rxoob would mean moving the refill after XDP, which changes
what happens when a refill fails: today the packet is dropped and its
buffer stays in the ring. I preferred not to touch that in a fix.

If you would rather mana_run_xdp() take something other than a bool,
I can pass the xdp_rxq_info to use instead, chosen in mana_rx_skb().

Orgad
