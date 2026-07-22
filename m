Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4E3BADB2
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758600; cv=none; b=OgWUZXW6ysCbNepzxv0BuJRM2QN5xnNCd47JedUH5cS6nCHM10jMjKC7eZJEEWlZ8r2TnTfDXdk0ojJob4kPnpJXTF7Qcg7pV/CVVMi2PvuuXrtgF19iUi00Z2qWhwqj+oGR+lFPsvwSQogss0lkIQgNXRtY+muFcTdxiw8C3Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758600; c=relaxed/simple;
	bh=1Us5xGkBAJXwBwExy8cfS9g65Z2dRyMfwJTU8OTSbAA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dgcvK96OTGnHpUGaxJCWfPrdxfV+3EW6ncU9Sm41nUvO1rLbgO/eBF4ODG+hK5yz6i/56ntrFbrhtcuw2UodrkXlxejCVaaAOY/G4B8VH2B6imF42K72LnFEEHxzyqlMzyzviDJf3LgaVX4cvmEI2UM6iisAwGuepwOmhytEFfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=korRYhqx; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="korRYhqx"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a3514f912so18423859b3a.3
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784758599; x=1785363399; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NxbTcxXwuujoRQit/eAYaWnsgYP73zQK/sdfkRV8/Tw=;
        b=korRYhqxMmosDuRgMl2dQ+tYcEXhRdWeh8KOxAp0vW8+NHjdSt1312LxcEWIwae+vM
         uN8bx/5fztGqQKNaKevYJ26qeFcoLsNGNAJC6kKaQnBk0deGFyHP+aPWMBg+t7gJ+wCA
         2YVq9CF4uc4UvpnrE1M8Uf2tqjGjmSGVt+HAgudl9qO/wiT7V2P/C/+B+HmS41bYakLH
         g7tJ/Tajb4aWD1BgRHk4bzrIMPNeSqVznetArH2eRKEH84+eOD838xmbE1GMGATr9ACJ
         7+mpVyX83Fsa5ZQ1HfveSZ64eAiw/YTnijgsM0H7rZnSWxoPqTvy8P3eV3e0jA07zJ2h
         lPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758599; x=1785363399;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxbTcxXwuujoRQit/eAYaWnsgYP73zQK/sdfkRV8/Tw=;
        b=iUBXMZSamCVF0vZkx2wS5TSgCVGogQ7CPLw3K2OSQhwdU8L+Vyk8p5LPlNIqjiTrfV
         pVbzNN8BUgJrNEwMFZ9UzFTo3qgK4DGFj0qG1jP0LjUX4Lu2FT2p4pXL9IQx3jS6ZdeG
         ojWhUirKajAiTKGCXl0yc0dqE26vqiB9uXEpSmO62QhZV/XouZTsb06dGNKzFqDFjonr
         1veC4N814ZLxXNyIpSm0zwsHdHmCP9+E4bA43YUy2DU5zbddziAJL73qbvlgPjgwWEY7
         Q9XzydUWt2zqESD/rP4qoUSJWezTIhmc2VxKmhjUBpCa/jtPdznQkN0F4cOntPCcb4SZ
         dQpw==
X-Forwarded-Encrypted: i=1; AHgh+RpJapbG0RPDtVxV9QKRU25cgN75UdGN5xJ4JuwxCBs+2m5ryVSh/eROD4CXi/Oawg7e+3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqP4kQYOe3U2WhnMp88WmI+il4vsonLwKdTmi7bHVcIpRKqk1V
	9oneczDhVkvZ1mZIIyimQ49QT3Zw+k1O+sOfbw2uIyt9yXOMHGlJZotqUOoqlEih+1vSUTtPnfu
	V5eMdrlrK8sguTw==
X-Received: from pfem19.prod.google.com ([2002:a05:6a00:c093:b0:84e:101:e491])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cd6:b0:848:8619:c149 with SMTP id d2e1a72fcca58-84e2bbe8355mr790924b3a.2.1784758598470;
 Wed, 22 Jul 2026 15:16:38 -0700 (PDT)
Date: Wed, 22 Jul 2026 15:16:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260722221634.186886-1-joshwash@google.com>
Subject: [PATCH net-next v3 0/2] XDP metadata support for DQ RDA
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

This small series enables XDP metadata support in DQ RDA mode. While
space is reserved in the headroom for metadata and the DQ queue format
supports the xmo_rx_timestamp metadata operation, support for adjusting
the metadata and passing metadata along to SKBs was not actually
implemented.

v3:
  - Make use of xdp_build_skb methods to implicitly pass on metadata
    when constructing SKBs from XDP buffs.
  - v2: https://lore.kernel.org/netdev/20260318192450.3400774-1-joshwash@google.com/
v2:
  - Fix referenced commit hash
  - v1: https://lore.kernel.org/netdev/20260316230434.1398828-1-joshwash@google.com/

Joshua Washington (2):
  gve: use xdp_build_skb methods for XDP_PASS case
  gve: add XDP metadata support for DQ RDA

 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

