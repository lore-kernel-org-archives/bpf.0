Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B81135C188
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106337; cv=none; b=eYNV8JbntngoWXaGuLJBEctDb/QEe9xYCPvEJ9l3ozOeNMT5eSEGlGs70468vqlFZMC7VQqqBXpzSuIvzvalKmlxlpfOzbr5YHqMS+1Qugg+t4YpIDLHNa5pBrp4amKbb0TaHXWtG+VZ2hvQMrX07S6GqG8+rHnZhcZq7VBhZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106337; c=relaxed/simple;
	bh=oXFFnejGHk/Us9X8QbZEfrbMAeIL5C+EUjXTvLy9Z00=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Jrf+Pm98cjenAzwt1QecjYZxAW+B2jkqW7o4N+wEEOy+/Xza4P+Jm2qVIDebXNzvJpUHdBF4OU//tcUT88jpR394S8ceFINPHMs/z6i7EtHNl+9xPYe+pj4zA15W4YfMKxo/xymr5/zz0scKMj6LqYG6TzqdfiYTUaGdwIKJ7Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b2Lx5vc1; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2Lx5vc1"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-85602449126so366782b3a.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106336; x=1790711136; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D+auiJXkML9Ew42TAOdwMIBsX1UWWb/LYGWGLP9hygw=;
        b=b2Lx5vc1tKUB6HtzMNgmFd+Nl4Vk4F+S8jLv46oMLTNIPybmE5RNXufWQfvZUH8hKI
         hZXV1dfLgwJoGGbqVQ8J3on0ykQmM2S1yMnPpo5KFLp24wz8pHExvtFdOq40/iOKgTAS
         AtcUaTen2Xvw9qFD6JgPOZ3Pvh0oSyzDXy3RDLnMBOisJSyETKwIGvYcM6PtoC2sewle
         VQfgBch4jUeJLNoFWFlepEp9qxV+rdK5v1aURUWS5qQSuRb9IXjbRDBPRyuL68bhUlJw
         zHgipEcYdZsKcozBM+u0els5wWfQ4yUAwN2kNeCRzb3A36piT+tGv3evr9c1wBymqcDq
         pfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106336; x=1790711136;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+auiJXkML9Ew42TAOdwMIBsX1UWWb/LYGWGLP9hygw=;
        b=vEtJcm5tV1Osz6ucMvGgzOUtxh1Qf3bOWMUknc41RpfZzjzyKGVWc+P8JVIxLO9EdM
         6BDRLcwTRMQyZQb1nH7b/wIUuU8/RxmX6b3TS7w4YJVT5iLLx3+CwZ1QgmFI1DLHR25x
         4qhXIFHLlEJ++cCztf/nUujQIfHSoMOv3EEbW2rFRRRF9EfMCwV53zDIPUMarnPXBtoE
         qpvZrj0rqDGjompKwnKkkCyc3pASyYV6M112/G5jYEkNfKpO6mie5v1sQSVy+FgmfDWI
         eqcdHluA9l4e59TgZpG0rWxcTtypMzR+l7HApJ6yA/KgShzfpZKb3U7IPeQbyAk69spD
         uiFw==
X-Forwarded-Encrypted: i=1; AKwUvBxXtgoaqxUy6VEA62EKGPdTdTQ1dzeGGrrvjyh3/dRGkX/M8ESM2S7w+//e1Wu/u7nwgU4=@vger.kernel.org
X-Gm-Message-State: AFuF++kH8bsEGYh8rBavvYhU0BiyO7n0F/29KSbkaUQflQPK5FFHNzTt
	UyqyxqCOWxQDTEJQuUU3NHL5FdB3yKPplk2eEYNs/F/ZcWvdZ6GBvnkiJKImcpyPCaLqEUJBoIK
	ezkOARDVpQ+3EDw==
X-Received: from pfbga25.prod.google.com ([2002:a05:6a00:6219:b0:872:9706:205a])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4612:b0:874:36c0:4d0e with SMTP id d2e1a72fcca58-87d1a5ae044mr628860b3a.8.1790106335585;
 Tue, 22 Sep 2026 12:45:35 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-1-joshwash@google.com>
Subject: [PATCH net v2 0/9] gve: various XDP fixes
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
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series includes a number of XDP-related fixes, both in the
control plane and the dataplane.

A summary of the changes:
1) fix an issue where XDP packets weren't being counted against NAPI
   budget
2) fix an issue where XSK buffers that have not been processed are
   leaked when disabling XSK pools
3) fix an XSK buffer leak when an RX error descriptor comes back from
   the hardware
4) fix a NULL dereference due to incorrect registration of XSK pools on
   queues not set up in XSK zero copy mode
5) fix a deadlock introduced by attempting to acquire the netdev lock
   after it has already been acquired
6) fix a racy NULL dereference due to DMA umapping the XSK pool before
   queues are fully stopped
7) fix potential data race on priv->xsk_pool when the field is set while
   NAPIs are enabled
8) attempt to register memory model in all cases when disabling XSK
   pools
9) clean xdp frames when tearing down DQO queues

---
v2:
- introduce 3 new patches (7, 8, 9) based on Sashiko feedback
- corrected stat counting for packets according work_done behavioral
  change (patch 1)

Eddie Phillips (1):
  gve: prevent XDP frame leak and corruption during DQO TX cleanup

Joshua Washington (8):
  gve: increment work_done for XDP and error packets
  gve: fix XSK buffer leak when rings are stopped
  gve: fix XSK buffer leak on error descriptor
  gve: don't register xsk pool on pre-existing queues in RDA mode
  gve: fix napi_disable deadlock when attempting to disable XSK pools
  gve: fix NULL dereference from premature XSK pool DMA unmap
  gve: disable NAPI when registering XSK pools in QPL mode
  gve: ensure XDP mem model is registered when disabling XSK pools

 drivers/net/ethernet/google/gve/gve_main.c   | 153 +++++++----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c |  31 ++-
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 256 +++++++++++++------
 3 files changed, 314 insertions(+), 126 deletions(-)

-- 
2.55.0.1082.g2b9226bbc0-goog

