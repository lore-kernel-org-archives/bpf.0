Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375854A6CCB
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106350; cv=none; b=QOzFMT+S3SyUaWYW45bl9YuII7WY9zR3HxOS6P5+Nh0+B3mM9WE0G2BQYzSN1wJawkHkeXyzAHsrwHgSirRwxyh1HZm8zC3w2WgCbiyXXTfYWFSLifdi5MGxmuknXXHN1e+hlW8y1SAGs0wLOB8RgiBWT61hiOPDox/XkDerII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106350; c=relaxed/simple;
	bh=UljtQ9XO6rbJkLCDeJXSzP2hU8m8OSu/SUn/z/6iVUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P5pA85//LItAobgJsPttCZYoOJyzzyDzm8q9YXywC4jzx3A1Rw53UtZpE6OSbIf9EApbNugm3pHJd3nCjnk68YU6KGUI6L8zgs8Kf5ZaJ2K7z5PyU7CiCDEyxv7DteriTwEmMJlEmZCv3wsUr0kpiOBuF/45J9tvdrLNrnV7nJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDKzk+Jz; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDKzk+Jz"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2dd753a52bbso3153175ad.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106342; x=1790711142; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWYEebvN53sOkHrhhlwZSz3/5d2DYKttJmC/W8rasEc=;
        b=vDKzk+JzBBTn6rAfjEqBMyPU2CXYQYNh/ugXqd8cMGmLPm1jN30z9cZYqEM9IJcpo8
         Hu8D7nZ3GFr85WwKsQXfhIBDDfr02V3PqsXNM2xnqbJzJcq6EsO5SOfLOjclN3dRO0Gi
         7morU4+CIzeCDD++Ned6Oj19jkgZQCYAX2JmICR/KjYYQFtskRSyjGIUbqh9Q00TypkD
         +pbPYJr52TPfLqP08nwLIWflBMDl2rECoIxmMbCH7tLq53NMvs0xKjdO1xIhArLftL/m
         wUQQUKwcAqQgN3KaIWzWKR33FZjfXECy6w8/f6JfrFwHQB3ofm7Z5PMtncbC6lphsT0U
         jOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106342; x=1790711142;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eWYEebvN53sOkHrhhlwZSz3/5d2DYKttJmC/W8rasEc=;
        b=K1cS5M0e8AKfSSDyXGHmIM6Bne/pEvGEykuHpLvs6k86JHBCs81LNEHfjoufW5C0iU
         SLRUJAn2SGIh4TpzrIcmfYGMU87EiYq1sAsuG9I5T5ZGV1EAvYD6HP0s/B5vUNbZnNst
         Phy11mRBhR1P9zN3vaoxIrSIFJUCaGB+sQEWoDaMU8o7AnCg9mijd0ElpiKZMCv0MNmv
         9wdAfaFgJh5RV8NPuDUpfKgFqNqyRn7ltiq6TsS1S/7m5MSx/zKhdoTUFRs8bGphtzwN
         7JQZ/q0H9rxEnWOHqoK/L91gqITwuUdU8LrCYz6t/hHWdbp0hd54UYUDoE4sz2JICz0Y
         b11g==
X-Forwarded-Encrypted: i=1; AKwUvBzScuZEAEmzTuqkg11pwCixgYz0+jVbBVWHg/gF5GopMTjSfknRQuGNZm6HBkP+eilDq88=@vger.kernel.org
X-Gm-Message-State: AFuF++nHXu6Y2JiMyRpArgDuuVWaIUt0n2NwVXXDpdhTmj3I+Xm+Qsw+
	/iy+K1J4jy/pXvOpbDffTzeNCa1nAXrH6mCuJ+TZUfBjUsTM817iPuyfmdWKFeTC06VExNPEUsv
	07gA33DopABE70w==
X-Received: from pgde21.prod.google.com ([2002:a05:6a02:315:b0:cc2:1a89:e586])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2fce:b0:39e:6c68:c77b with SMTP id 98e67ed59e1d1-3a07e6b5895mr430876a91.49.1790106342068;
 Tue, 22 Sep 2026 12:45:42 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:26 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-3-joshwash@google.com>
Subject: [PATCH net v2 2/9] gve: fix XSK buffer leak when rings are stopped
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

GVE does not free XSK buffers when resetting ring state as a part of
stopping queues. This causes all XSK buffers which are posted to the
NIC to be leaked.

Free XSK buffers attached to an allocated buf_state when stopping rings.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index c3f4a76b0fac..3a88b7e98b16 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -113,6 +113,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 				gve_free_to_page_pool(rx, bs, false);
 			else
 				gve_free_qpl_page_dqo(bs);
+
+			if (gve_buf_state_is_allocated(rx, bs) &&
+			    bs->xsk_buff) {
+				xsk_buff_free(bs->xsk_buff);
+				bs->xsk_buff = NULL;
+			}
 		}
 	}
 
-- 
2.55.0.1082.g2b9226bbc0-goog

