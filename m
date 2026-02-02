Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C73033C7
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061176; cv=none; b=V2324ziB0AkOs2SwKJzL1K9ARir3i3VxXR8cruNds5hT/Mb6VPcU844x0h1yb20FPXixW8GEnzXZzwM64Vme2ft/zhyUDY3t9ta3x1cgQxo7wAzSuYtQtsb/s4zp7EWvAt01g8LappgftAZGAmtQ+W7pgYHr7vozEmVjHK7YAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061176; c=relaxed/simple;
	bh=xMWjIBemj+ovDo71k/lbnlBBE9tZnK7oQzi8YhPuLhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lJ5pqoyzH7ogm2Kg8UE+vusiOGVlhA9IQYhMaGKokWkKsavTHx65W81cHhn51u/LnRwc+AAw0sir30E0zQ7VR8k4w6eoxCcv1xRCQitRvyIWR/XgCgyinhwCcxbE3/O0zwC6AXyuLigPoAILiLFT+XNyDQGV3Fm90qWGOHY07t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ua4YHtxG; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ua4YHtxG"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6124a9fb86so10455065a12.3
        for <bpf@vger.kernel.org>; Mon, 02 Feb 2026 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061174; x=1770665974; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TzUehqNS0ybAXqn2p+RtPCZdOa9cTlWsLGkT2lUzyqo=;
        b=Ua4YHtxGfXmxf+dAs7W3Drd1s7luodKyLWIEB/fHy5M3h2rBw7Qk8GTX3imgReKYDn
         1baKbuBLTumA9FNmONjXccdu/u8FLsBJxmPJVze976FqDXyfm6TmIZDYVdLYsxhKp11M
         wRfz92lmBv8WMbIn223fs4y9uSLoF+3RXB/ITCy5uona26Sf+n3SnpJT+srKUWYpyNSB
         k493PfpYgXRW5E49GM4u5SxRJMvi917kUYgPRCur+yev51zkhz2JB/dz9KG3mAi4/9vj
         j4N60B/zLQ8bedYrdeYMO+YHpLtzYmwwv0DlKdYBCsCE+lcKgrPW9OrOx7itM7BW05Iv
         Gdfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061174; x=1770665974;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzUehqNS0ybAXqn2p+RtPCZdOa9cTlWsLGkT2lUzyqo=;
        b=AHh//YprSlklzHndiwbMzPh5TWkR+LVRFiNDRsX3TpggdfydqYJWflwTj2d0ETHNzV
         l7UCmUvGAv9zr3p85u7kZuCPbN0t50dVqBCS0wC/ABMBGj9HAHL2Mw2PtrFYLhityW5V
         kezXyhG2AWhiDbfcM5dkrsqh5gZ/DKJn9dRDVPWPd7akU3Iaaym2hMpND06lgJcbpDf/
         Gjor4zzoa9IYWI8ZxHXtk7W4vdqhD44MGCrfpr6WXOXZymWRzHb1UKMCCrWqVG7LPJzZ
         fDl8znMzXVspSO7lsxL19ANrzKlg1Vi5guKDMUSoEHI65VhfWGt6+8ph50MgsvfDfZUm
         UhoA==
X-Forwarded-Encrypted: i=1; AJvYcCXUZ4ucKm99311hs4iCIJST3bU3Klnm2qdD5w1g2K5XNs889hdqHWZLT7Qxn7Eh7Po1qyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8nE+N48XQ2lucli5DtxGIrh4XwtVFlC2d5GM46YeZ1kGIM1d
	dD2XHxl/GxICqTmtjIdENgiS6YLbC+OB8eYydueBGGL9Lc/nBHwK29lctLbM5+ZvkFU2y3UgMcM
	Xp2NXP3Lu7er/t1p+RrF9moF5zA==
X-Received: from pgc3.prod.google.com ([2002:a05:6a02:2f83:b0:c66:ac3e:e707])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1446:b0:37e:7e93:99cf with SMTP id adf61e73a8af0-392e0100349mr11565062637.37.1770061174526;
 Mon, 02 Feb 2026 11:39:34 -0800 (PST)
Date: Mon,  2 Feb 2026 19:39:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202193925.3106272-1-hramamurthy@google.com>
Subject: [PATCH net 0/2] gve: Stats reporting fixes
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, ziweixiao@google.com, jordanrhee@google.com, 
	nktgrg@google.com, kuozhao@google.com, yangchun@google.com, 
	awogbemila@google.com, maolson@google.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.com, Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Max Yuan <maxyuan@google.com>

This series addresses two issues related to statistics in the gve driver.

The first patch fixes a memory corruption issue that occurs when resizing
the stats region during queue count changes. By allocating the maximum
possible size upfront and aligning offset calculations with the NIC,
we ensure stability and accuracy across reconfigurations.

The second patch fixes the 'rx_dropped' counter by removing allocation
failures and incorporating XDP transmit and redirect errors to provide
a more accurate representation of dropped packets.

Debarghya Kundu (1):
  gve: Fix stats report corruption on queue count change

Max Yuan (1):
  gve: Correct ethtool rx_dropped calculation

 drivers/net/ethernet/google/gve/gve_ethtool.c | 77 ++++++++++++++++++++++++++--------------
 drivers/net/ethernet/google/gve/gve_main.c    |  4 +--
 2 files changed, 53 insertions(+), 28 deletions(-)

-- 
2.53.0.rc1.225.gd81095ad13-goog

