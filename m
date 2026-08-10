Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC0439F7E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387676; cv=none; b=jZLxhI4FzaWamwVIzfsnk2L8C/AW+PlbBS0TTutySyeYtOFCfsYI3HqVcd8LXIogxBdGej8M8vFGi/aVlWayNCIzf5EDd6Z5ZAxzia4T/FRTN/GruQTymuzwzlhpwK3ZExpBEg5yeBoDdfZgwMDpx5YAxa8dnb+xeNKnD+gjZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387676; c=relaxed/simple;
	bh=x0QsXYnYa8Y8GiWNms+Noz+9KVQO46lMTo5YQMfvmJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZqNcIMtwi3EK+fkexg5aT86zVzlnhcc9On3KOa1Bjbc/xuA3lfv5cRiiOoo3EilEhZaMOHZPXWI/qdiEx+MIv6R+/UUDEVAIW8tqoNatFdkFLymX4ZdIeNFF8ZfIiTC3bQXyLst5HgrnO9eCoV3dr4gCcfP8HjyAa0HmdCVqtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/9BWBF4; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/9BWBF4"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca034c989e2so1225631a12.0
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786387674; x=1786992474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
        b=e/9BWBF4ZeTaqLUqsEBNK4tfCva1JyzfOeJ8VCbeRT2eVn88TiLrqMY3lFT6fGDjvf
         ZUGumvmG8t56mlRr5M7Qu/Yb45SxpQIqm9wKdFRaB5W0UrSyahKIuucm2nSVvgDhu5DC
         +2VoNpdgCSBf/BsDeek3mdvTLFN3ozpFpFz8jFk4/eu3lLshlmukGxPBQkhXLrk0e67H
         GVNM4zPQFYPaquk9yzq5MRvm3Yte+4C2jyAUaxbhZZu+NOHBMdDJy6f00l9bM9Yz+tEv
         7/O/ygkKvBrld6qw1ITeOS4CY4REWxK+BpfiOSOKlHU4dHfSqWxLYfJ+ZCizztAFvye0
         RiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786387674; x=1786992474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bAxJNp2NmtcJDSfK/A8JjF0qJRtyo/oUMnpIAtF1l8=;
        b=EojUt9EzSJSpiEfC118xFHSvfXNJxW6INtieJTfvm0fYU3oxMLN7R2w0f44E6KOZ/u
         lRUSHO7Q0I0qHqKvU4K0A6macQ1Iu/eWYrc/zzZw6FZIc7eCBraCqk1xsvtt0+v91Ry+
         Pa73ijzdzpGlpaKK+ML2OKvDYmdpenrFsuaRSF4YbHGwByJgpfltnK268JsmFjzm+RRd
         35j6Sc/vvkxkW4zMij2oUeUVVaXARd4aWpLO3j+tBMU8STIrFbL8bz9HAsR82LAOQkPf
         QL6fKzu9Y49EdChT9GevCdArmAZJRDakRT4jTBeLLARyTOYwYjNm7en59hlLqscSW1Sf
         42TA==
X-Forwarded-Encrypted: i=1; AHgh+RqsPyI5CqClfh7s9M3+RKBkyJTkR7x7b1A9lxPTV39JpPj0y2HqziqFFpOxmsIn9lEgzJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1UwapbcPAnbDE+Npi/5Sa4z+qlfCy+uc1G8nIkUH7hxhKMNw
	xV1dWxPCYit5pEb/IctCmNpRWXcuUzjV7GitenbrDUzhaapbZYybnG7t
X-Gm-Gg: AR+sD10EQpXTQJMcdCqeOBE462E8bMKFYYruBfM3Az/hZXWrAaDFOftvCbMcNdl4z10
	mRTQ5Cw16xsfmBiD+YHwFK+WWk2KFYe4KfxIaPpeoT7qYGHqIHTwNFZUwejkZosVr5lVykrSoLj
	MX42sCB2W6XIWZJJRImS0o8zX679P8Ph9D9KKYchmQXjL6XTSztH+6kXSSTrXEiYncsjjR9YPUI
	BAAaenKv7qzJgllNpy+vEJIrFwjCtOfR6/bO1QAtNkhUkFHTysDXvBd0fyTamB5go7msSjk23If
	RyhtLedIg2zA6z2Y1ciJ2Gkhhc0HagOOUlJInxRER8cfvJ5B0N/Q/8Acnz8kISIu9Ivc41lBfSr
	32u5h3V2BK3x+PM1VNUF5upIuxoOU2Jp8gkfzJW7C+/6GSI3IiGkFvuIWAs+UzSvLObFI8o6Fc0
	wfxM3uZC/f0MXCQt+5THJ12SBpWd6A+B5gJr7iOV4GLnzxS6u5M0Aizg==
X-Received: by 2002:a05:6a00:3987:b0:837:e9cc:d46e with SMTP id d2e1a72fcca58-84f9c965aacmr3341745b3a.21.1786387674437;
        Mon, 10 Aug 2026 11:47:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51d88dsm4244979b3a.29.2026.08.10.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:47:54 -0700 (PDT)
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
	alice.kernel@fastmail.im,
	dtatulea@nvidia.com,
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
Subject: [PATCH net-next 0/3] xsk: pre-existing AF_XDP TX metadata fixes from Sashiko
Date: Mon, 10 Aug 2026 11:47:50 -0700
Message-ID: <20260810184753.135756-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few fixes to address pre-existing issues from Sashiko review.

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

