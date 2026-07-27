Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B84390987
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169202; cv=none; b=jzbyu2gawNrGD34h3OqW8V1NKD1ZLV6kfwwWE2wRfUHOFSIIga9i9GmjF3OOyK1MBX2e/7kWSaklWhje6U5ZMRG2YciQfzBsuy+k24DneuxtvvQkDSuw4wiX6rFjPrQmICb1JFbZ/Fm2607h0t0zklQxg2YplqDpPex5+A7bFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169202; c=relaxed/simple;
	bh=uvWfaDTwPIsxFITsDU605dsZowdF2q8743gpbMsSmvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYxraGn8B38av9D/1tQ2NE4pW1kZSszEE75rEeTwu8HRgc0yl0oylbBgs67asSi2CI3lb8Qrf1WMnFrSHN/8WtpTDkGXIajlJ0NcwF4/P9Ut/YjPbNQgY1hXjM4DsPM6cYgb0zdzepv6Q4wNHkDTLSo0DDCGXf8QfRuFyQzz89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhY27fMY; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhY27fMY"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ca4f02483cso3110455ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 09:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785169200; x=1785774000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBHchiXE2dARhW+lF5cUbUC3sGgHoglb/2VvCgkoEgQ=;
        b=RhY27fMYIYue75ma2GJbsWRhGiUIpA2WeKgyWxt3xWETp2F1mNl+L1WLF72yKzIzw1
         9ajaOKAkM56OsJYNNgkKw6FM3lPHD6RVXQLfTfAN4zyXY74ii93tUMoBUWCvSFTZp1WF
         d4rnm2N8k9kGZfI3SDQrLnCOZuPMBbXGYOsWLD3pjy26bv5biKZtTaLq7IUA40mlddN8
         MzdnYWhjaBgYqozmII7DvKfxco9uzd4db1+iUhZYpou+FwWfPAK+992WK9L7zUEReUPW
         dQ9hDJmGR1XtMmKAZ8K40aFKqo5hZ42c8XUd5P1QS3ULrLlgK48+aykvyotubM5clDdC
         vjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169200; x=1785774000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBHchiXE2dARhW+lF5cUbUC3sGgHoglb/2VvCgkoEgQ=;
        b=He3VYrRkvu47ZLy9mUqgtIe40S1pzzAV4BoFxzZ8eoWDc7u3JymPE2127CMLmBYZkD
         7L5Sdqx3YHN48UlKHHUvUujjSZIugs9ZymJVrFpJhgHvu+5I7JXwL9/62KQEFHx9yelC
         j7uVWhsqkrfv/9+mO/eNtpf2FaPbbpPpIDC86FOInM7b5C0kXUzUqVwmyPUtzs1NZfNs
         u7S9DJpL8SHpidbFn7iYcYbMVFrbmi31tU90gseKN1YDqn7YI4cCSNIon3BxlcLuBheM
         svt6z+tssbXtOzqsd3ktMokFhnLEdk1A2joA9SDnKD9JtMxTSTfttA4dL15vXqN9O/ho
         hZAg==
X-Forwarded-Encrypted: i=1; AHgh+RpgiY4fQY67a+6fEBk7qc6t8ee+D7/vjCT+bhpi4jBQvBj8WpKgqqH0IX+htlc9+YQtuoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMnDzAnZYeFm97U7GEOYrCX+vN3ykyXdy4FShzzO1ysxaT+gk6
	WEh2VRIil7+oV3WWypanA2iRokf3/Gy04+QGTSWBMLgjdUgNIpG8vnvt
X-Gm-Gg: AR+sD13HbmJz5iRlAToZ5n9fcU4GJvEZWKn2kTfuIxGoT0TN/vddjq6WJwaTNVG5NUs
	s+XBzgAMqSdq6GqZlMoaKm7AECMYwqOfaZqiXV9xdBLEY/FBR31vEE74nnjWIR8sINSHw7owVXh
	YaZr3L1ueLe8bOAGh7CtsaEtKM7hraMPfRvmWa0w+BwKH0vDNLCYz06L5zTeDr+/RFxcILBOHh8
	o2CiQlYHXVn7YPTk3l4Nbx6R2AsTfxLnkbwMRFcX2ese0JinMCIbSmAkedfmhYhXDWXQBvFJVHe
	JAxckHj2NXECH8G+ixlb+QRjDp1f5fPk5Sv+zUue9z17Fc0qtkRbeFqnAVibidrlwOPasAiM6EP
	Ihp5Yfrq4u3qMX8qz0lPqNi5CLw0/C6Bd8JtDzz/6YL04VSn35z9UtJCRXpmTZ2Jkf5Trwg==
X-Received: by 2002:a17:903:9ce:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2d00e7f7ca8mr978145ad.11.1785169200191;
        Mon, 27 Jul 2026 09:20:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5c7678sm38144985ad.18.2026.07.27.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:19:59 -0700 (PDT)
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
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	witu@nvidia.com,
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
	yoong.siang.song@intel.com,
	martin.lau@kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	leon@kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Subject: [PATCH net 0/6] xsk: harden TX metadata validation against races
Date: Mon, 27 Jul 2026 09:19:53 -0700
Message-ID: <20260727161959.885642-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cen Zhang reported a KASAN out-of-bounds read when AF_XDP is configured
with a TX metadata area smaller than struct xsk_tx_metadata. The metadata
is also shared with user space, so reading its flags more than once can
produce inconsistent validation and processing decisions.

Require enough space for the flags and one request field, validate the
launch-time field against the configured metadata length, and use one
snapshot of the flags while processing each request. Carry the validated
decision through completion handling so later user-space changes cannot
enable an unrequested completion timestamp.

Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://lore.kernel.org/netdev/20260720155210.34229-1-blbllhy@gmail.com/

Stanislav Fomichev (6):
  xsk: require at least 16 bytes of TX metadata
  xsk: pass TX metadata pointer by reference
  xsk: clear metadata pointer when no timestamp is requested
  xsk: validate launch-time metadata size
  xsk: move xsk_tx_metadata_request() to xdp_sock_drv.h
  xsk: validate metadata when processing requests

 drivers/net/ethernet/intel/igc/igc_main.c     |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 15 ++--
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  4 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 +-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock.h                        | 45 ++---------
 include/net/xdp_sock_drv.h                    | 77 ++++++++++++++++---
 net/xdp/xdp_umem.c                            |  2 +
 net/xdp/xsk.c                                 | 11 ++-
 net/xdp/xsk_buff_pool.c                       |  6 +-
 12 files changed, 101 insertions(+), 71 deletions(-)

-- 
2.53.0-Meta

