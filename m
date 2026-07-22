Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7943C04A
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758605; cv=none; b=F3X32GgCluzw/vOjKcz8/CHOnOvm0fB09O7+p8D8aoZuICfv5GCOPoSoRjaHViS4/duvwGekospD5OeaosjjCN/lX3bN3XBJ35FxJFjg1AsurCnaPIDmHRt8eFBxNnbtWpkzVns2OfrAY2l+r4MsnUiyln7lgXzqcSMgsjsqqVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758605; c=relaxed/simple;
	bh=pmLr6Q0wrxaoiG0HC4cecGXvH0Y1btBIoJOHP4vTW9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pS2L0HbtpHp9QboHxOFmxrw/vhbHHmVwOxfy4pMn2Rn4em8kss/OqS0s+rcGxkxS3Yu4HGAw13EhdrqNZc2KX42r9DAcIGZzUOWwTKNnNFD4CJr9fnPEa7MVIDzstT5v06V5O1qLJg59zFxcZy7JvzuUv24d4pppXAyE6GW8TAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZd9F1ko; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZd9F1ko"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e01a62d99so3225751b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758604; x=1785363404; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nKju/xiraPUjvnNIoptLAwkfAEYgVko7uXam/THvrCc=;
        b=PZd9F1koYhqdsVZtSzYENZf+OqmR/jW7O+s12PSSvdxJBmILnRcZG5vmeSc08BXzhw
         a+CvaCM9s1LpFNv2p6IAxI6Wh8dQz2Aw3X9L9i2kEjg+t9SondbIeyU3hi/Gbx/XpctX
         FCLUnYsS02tjfcnV+h5v3izCVliUUYaPv/5LWxYD4ecsAyN+swcVezxcoLsmBREIoaJB
         SX/agzTKDIgvDR5X1wrEJIXpMwbJ3LQ8P5G8bHLowniD57esvj1AdmqI5AQtiuEtHdRf
         3Hq56dIVq+I4F4LNnXG3p9ipGrHWsPfeDtfwfuZzCGL9EwABvEUTGd62ByiHza/ahZnz
         Gj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758604; x=1785363404;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKju/xiraPUjvnNIoptLAwkfAEYgVko7uXam/THvrCc=;
        b=DUR+USimRjPqYbvGa8mhEdPo3/kX81V67/b5jDW7djBaHnpvVqJsNnrx5PMianH7f2
         YAKy4HCGOvlOztl+0ZUyWZBTqFU+cIOM4yHmxerli9gEfIFCOcEWBbccfvb4hPujrUS3
         Lrd5sbNYpR0GKCwKBXlTUKjLKSB2LY76pqb2tI5UKF9ZXfAkyqnh1Q+eTMisAB6SHH4u
         Va7ISRlIJHpKWPk0YgKQKkpMl6FtY34m9k2n6DBoPr6KUdQmoqfBVt8E3t4zRENYwYeF
         zlN+GErITX/+ohVQxFr8e+kQ1HMndFCMpqUe32bCNHPygVsaoEjkXaR+SydOGTtqvj28
         Zmpw==
X-Forwarded-Encrypted: i=1; AHgh+Rq63RMf1ztGQu2WfaCWhPR/GAmafgyyx8+7t88lhiJYLgNaNM1EyfsC7pZ6+g9Ui84kK38=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/dOSKLpzQivYW0VPrw8+venxnH5+buYdcXh0X23QhsiX0//V
	h61URPp2v0jj8+enMkzJEp+ZfeNop7qu5VIdZkWcaRjgcsObZqjH+1+0wwBJ1jrWc5BEkHiJAhC
	TUsTB8d5UoWVRNg==
X-Received: from pfbde7.prod.google.com ([2002:a05:6a00:4687:b0:848:401c:994])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:cc9:b0:847:99b4:d011 with SMTP id d2e1a72fcca58-84e2c19f3e3mr648344b3a.39.1784758603545;
 Wed, 22 Jul 2026 15:16:43 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:16:34 -0700
In-Reply-To: <20260722221634.186886-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260722221634.186886-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722221634.186886-3-joshwash@google.com>
Subject: [PATCH net-next v3 2/2] gve: add XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
exposes support for the XDP RX timestamping metadata operation in the DQ
RDA mode. While the operation works on its own, the intent was to enable
XDP metadata support for the queue format as a whole along with it.
Currently bpf_xdp_adjust_meta fails because meta_valid is set to false.
This change updates xdp_buff preparation to set meta_valid to true, so
metadata can be fully used by XDP programs.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v3:
  - bfp -> bpf
v2:
  - Fix referenced commit in description
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 907a0c15bf30..329a2585489b 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -882,7 +882,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
-				 buf_len, false);
+				 buf_len, true);
 		gve_xdp.gve = priv;
 		gve_xdp.compl_desc = compl_desc;
 
-- 
2.55.0.229.g6434b31f56-goog

