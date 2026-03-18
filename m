Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4C3D648C
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861901; cv=none; b=ReUOX4vObEJIt53Jwqh9ZyY+2R/xeBMgVWcJ9QHzC6OZvhE/POL1vZxaeHH70x9jlse0rVTMw5EdoNQDfDuHE/RRpIzq+Ney+Olo4fhqvPfsaZthX3QSsoZlhXYHNIGbCVyvJcirFFoVZ27sBkzDGVqcsJ/7nF7EiSFQ6c2tTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861901; c=relaxed/simple;
	bh=RkL+/fE7IQQEwdkd1VfiZdnuMPwzAVXxDtxGjK2oUWE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MF9HI9Y+At6q74CeXyuawc3I51OBYCDmIc3KnPjholvZHurZY1i/HQ3m2tO0fVLCzaH7Or7sC8zdZt8vPsk8FkGpsL12B2CcK2+wd7kJ88NvfhDxb3Il9P8+UqKvkh6tkhyeJgfgMB1vPsE1KFlETyWJfirhYhDWd+RDhS4WMAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKa7u9ou; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKa7u9ou"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a68acce26so194381b3a.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 12:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773861899; x=1774466699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jf0AumpnbQUluz6ikgKfKkdwe9GoN4gY1bq1mNWa/U0=;
        b=pKa7u9oucl8O6ZKUy3sBTv7QvyeshiyY9hCWq42W+qJ0ABU11LatRLPMrNT1pPQ0Js
         kS6OvvBz2Gtz7ach7IyOHDMSinJQ/oMfWk4Q3FxYru4E1oyVszQPZdpNw4R2ca3d+kUQ
         /6s+Dr5CRt0A7A5fM4vyB5BpVrq8BTJb3TDgM3B3/AO4v1uLZTLKOaf1igZ+8VC5rkQB
         cdU5HvYnfRWwVaD0BJ6HfZz7FM+I45gWgyQaecIn/CsNFEErrmM+UPEGphfDrv5wCFF6
         bUO+n8kn4bO5B/WxqSvq6W+1O/XdhCNjh6q5zlpR0DoxThp5HdPtKzdK/AfTQLRkc7/y
         DFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861899; x=1774466699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jf0AumpnbQUluz6ikgKfKkdwe9GoN4gY1bq1mNWa/U0=;
        b=Rg4yq/PhGZExasBEg//1Rkh8VNLPsTS7o+jqY1Y0utuVaQqGc2VNSsypSg7OIO1dvF
         LUskGgo0I1kl2DjupyIJPhu6ZHoDe42rW5XDtr/FzD8tVh5tQ92izHcLIuoPIvF1D/BW
         djKOKA972XejzBfcLtWnhf+KHj6r5a70oew93aYQ2KJqGMXQHijjrYbz5bebULG9f3h2
         Vvn6wXwupCYO+c0Eb1Kwn968/xDjylbhwBauNEI1O+NvoDhuxdD5qiChNOYtVVM52VCw
         Xfi3M7Es0WL9+ZmTTAe76Z+bH4qIgfXwqKBYst6u6bJddq64As1mvxlWDw7KcXSFWwsk
         V4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU5QqcOKucwFq8kASaKCE2UPIsk/Un2ke4lMj0Mwt9f0+sEjRLtOmTfznuSW0mzH4820XE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8+fNHqduP4K77AjD4TSwZswoou0fZeaqrgzafexwKFqhVpeE
	SUjAdf/sMMkVbtEhlTIYk9ytZWX8rt5NL/Bi1jOhm8apKcHRodoksZdIFDCXYzKE7kIly35nX/H
	4zDJdbLLC9XbL1g==
X-Received: from pfbbw25.prod.google.com ([2002:a05:6a00:4099:b0:824:9ab3:ebe8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:158c:b0:824:a1c9:8a30 with SMTP id d2e1a72fcca58-82a6acbec8bmr3409789b3a.23.1773861898553;
 Wed, 18 Mar 2026 12:24:58 -0700 (PDT)
Date: Wed, 18 Mar 2026 12:24:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260318192450.3400774-1-joshwash@google.com>
Subject: [PATCH net-next v2] gve: add XDP metadata support for DQ RDA
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
exposes support for the XDP RX timestamping metadata operation in the DQ
RDA mode. While the operation works on its own, the intent was to enable
XDP metadata support for the queue format as a whole along with it.
Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.
This change updates xdp_buff preparation to set meta_valid to true, so
metadata can be fully used by XDP programs.

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 7924dce719e2..48945b4b6766 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -877,7 +877,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 				 buf_state->page_info.page_address +
 				 buf_state->page_info.page_offset,
 				 buf_state->page_info.pad,
-				 buf_len, false);
+				 buf_len, true);
 		gve_xdp.gve = priv;
 		gve_xdp.compl_desc = compl_desc;
 
-- 
2.53.0.851.ga537e3e6e9-goog

