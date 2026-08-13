Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0142046B
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648085; cv=none; b=Aq3gV6pjwLc2J3lIVAEjZu/uU+h0rmYbVKgzCTjwja+xMFWOxe93oZAs3L/gIZrJrMxAS0r43nNrsIP6P2UKLm5pxPemK7KS3f72nbEOrz9gJEW4barPHyPjYprICPjiswQRMEZEWFCMZ0rQaqCcjXVFo3z98FgRcr5+jiHWrn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648085; c=relaxed/simple;
	bh=kLTVFMDG9ofr+3bjhE0y0sSg0uRIn9xxlak7gnmQOSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNrJ3G3R6EEHsJbwRgrisThF0F5OoVKOrk61a6xiSy+vBljdVAEE/pkrruts6LMxUkH1jP4t2KzjvXHotoH6c7Y9laVH3YPWWzYBFU5wUwCZUdlE8JOcoNc8PyXpOpWawRQJV8IrdHlW9tok0Y9P1sndoipylkyb+dwnusoF6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tt1gacwz; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tt1gacwz"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc80544c74so906945ad.0
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648081; x=1787252881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
        b=Tt1gacwzvYNhgvKEMIVhPp0eEy+LpQSOAUReTmrmg0XEWTXI5pbVcpz/yt6rbiJleK
         p+LtqQSY93dv89O2NQekFX4RQFMojAu8sdssy4JohlpgeI8Qbja1mf1Fs9Pl6Kta+HPl
         /8O+rC93PI5k7RPxGw/zkPXSjteN4F4IeBgy+pMC69LecwRDKsIwi3jeuCd+7mdbmVR4
         Iq1m86S95hC1/L7ayYvI9WAW7a45vER/a22zzRdrMEeaj55Hq5QwUJ4nje0TdENq3PCV
         YUdOSRcH8HIUZkNza7n/TlUdXB7mP6RLZjGYzvCyvigAMdZ/8tpRM6irnd1RjOk1rBCy
         H9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648081; x=1787252881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
        b=OM+75/kdNBFjqfDNv3AIsNmbCiiU4ilX7GrDjwNleEGOa9Lt5mwEJrkcJBiAYmKRLx
         Tiv/zvTXQM97jde62tCPE4gdAy4o3NmWFFEKFPZ3zquVVQZBlezoU3H/GjKHWiuVnHyt
         B7+50A4BgaLWeCDAJYm0Ns5SOTJxgk3Ef/E1iYWv+vB1UXLsZXYbUjG/j15TDn5duNI0
         h6u8j20Jr6ZtMqPCo4m35YSg8Hz/pRTCpFcfNBbKolYZC594AIBlXw5Z4ahg0FHL1QsY
         bd8y0t0hTs4QhQ3Pm0JN9w+yx/7dnD+eo/HbVFd19G1Li9B510jK+MQSEwsONVAdsc+y
         3KlA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+qThvOEpC5MEcugILzWTiwOYeNviKCK8PLAGIjvKMrCZdYXIWhPMDIb2Z+Cl6ZnpOyrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY1eMhORBSvQQiEcl7KtChcw2HFS7y7re6vlRAeowFpmG6M3yj
	/H5kYF/SxWfHNCrgjM3aksf2ojOBAXHFBU158rrxmJyWPAMmx0c8waBW
X-Gm-Gg: AR+sD10JkkoqvooUAbV09jVmQbZiyIoqOAn9v6jk+inKygAfxbJcFcR7qN+OLLidevE
	Rblcn7sajLLw63rgxQXDDbJnl+RbLyN6XcwtPczZfARHbLr4zfFPX7mB4PHIDPuP2VJ6N/gBjoL
	JCj56J+3pLgU2XaN+n+M7T4sA/lfgpx0lg6+glo8UAWEBvjF4fQQNGKnBYmfe8hzbpCg9RFIO62
	lQYl7MFWqutylJ49e3GbNiZKFvOLs5AJQOi2SclNuAHvcv2CfeKoxuTPsgVZnfjcYddravjN8qM
	bvxc/n04pop2+TFvwAOtAHxhnHrmPqpVlr90SAUzXChGC+4RhUaqJjdN2ba7QWDDA41Mb74JcUx
	d1YryoTJbf6O7z4UlYKdFibUfXkvKISlj+yaIWwShbpPO4BsMgyb76FbOIFVg5Maq2gYSHluf3K
	QBPIuOhujBWEaSLqryAGneRUt+kpPBPAZZkkGgL63K6N2eLBzgZ3iXnQ==
X-Received: by 2002:a17:903:1b66:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d3b0c43462mr1698315ad.10.1786648081499;
        Thu, 13 Aug 2026 12:08:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb78d20sm1310695ad.57.2026.08.13.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:08:00 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v2 0/3] xsk: pre-existing AF_XDP TX metadata fixes from Sashiko
Date: Thu, 13 Aug 2026 12:07:57 -0700
Message-ID: <20260813190800.222527-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few fixes to address pre-existing issues from Sashiko review.

Notes on the feedback from net-next v1 posting [0]:
- It correctly complains about ABI breakage for 32 bit systems, added
  an explanation why I think we unlikely to have any 32 bit users with
  launch time
- mlx5 batching (pre existing) - I think my point in the comment still
  stays (that we do not make it worse)
- stmmac recycled descriptors (pre existing) - seems valid but I don't feel
  confident sending a vibe-coded fix
- stmmac queueMaxSDU vs taprio offload - don't think this is real but
  we can fix separately later if it is (the existing issue with breaking
  xsk seems more real)

v2:
- target net, address clashiko feedback (mostly here and other commit
  descriptions)

0: from https://netdev-ai.bots.linux.dev/sashiko/#/message/20260810184753.135756-1-sdf%40fomichev.me

Stanislav Fomichev (3):
  xsk: align TX metadata layout across ABIs
  xsk: honor XDP_TX_METADATA in zero-copy path
  net: stmmac: skip queueMaxSDU check for AF_XDP

 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++-------
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 include/uapi/linux/if_xdp.h                   |  1 +
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 tools/include/uapi/linux/if_xdp.h             |  1 +
 9 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.53.0-Meta

