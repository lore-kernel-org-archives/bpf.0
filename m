Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF31218592;
	Mon, 28 Sep 2026 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635012; cv=none; b=UMuO475rlruveKkq8k5U9EvRlrs6L0Ew9kuSd3FKzAnpCavr0fEOl98MqrXADA72H99EmpFX5h2DqqV0ZBIPobf/rZmi3FRvC4qD0gdFSTZRh90AbWdvo9hx5rkWKgvl+MfmeLaRT2FyaEueNUHFqQczK15XauQEV4JZAPTJwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635012; c=relaxed/simple;
	bh=LIQanfSaxIUi6VLWl0d6XjTJHItjtvI8B2E1EnJoO1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXkBPDm45vBPBLKb9gSbJifd8Fbc3TynLaTNQIn54ePXeushNQ5Cr49mWGCuQYOp8xcB6ECDpn3XC1dv/icWeq55apQeLyuX9vEEwDpDgPYehT8ykB+R+Kbu+UnWQIpMY66CT8bsMJIJCaEumKo1+yFvlyDe5PECxfwGdQgWoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDxaocP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDxaocP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C99B1F000FF;
	Mon, 28 Sep 2026 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635010;
	bh=vPCBXO1kkq526fBpUwntrVU7Hx/cJtpw8iz8MwqJa8o=;
	h=From:To:Cc:Subject:Date;
	b=cDxaocP6RaNiTpZlCLr85bklliVWRVial2n80MrQop/bWMRNfgm+ihRu/6YsIh3QG
	 i7DoIZTNRNjtqU18poYIwUqFw7nwzTcPiR+rNifxz3PkAex2KuZ1vCSO8AgFI2pqcI
	 O5+KcGa1dmmLCZVrWl8HTC7JWnCbXB5Uo30/Mo4HkQW8yP7IsBCYDDEsY4OAY2i2CW
	 odYKwVlrqbRja7fRaWs0tQyH1jG2bp1Yxg5EuzdIKi02hhjCzMgkAlNcZn0C4DYWiy
	 VUPzF2nITdhZ1I6t009Ki7832lRw+CmFEw+9v/9JS2VUVzEYz9Uu0rCO6t1Nm06+N3
	 n3OC4Lbpfwq5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	hawk@kernel.org,
	sdf@fomichev.me,
	emil@etsalapatis.com,
	liuhangbin@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	aleksander.lobakin@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] net: fix a couple of problems with XDP and bonding
Date: Mon, 28 Sep 2026 15:36:43 -0700
Message-ID: <20260928223648.2739371-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I started looking at untangling XDP vs HW-GRO story because of mlx5.
mlx5 requires HW-GRO for HDS/memory providers. But generic XDP clears
HW-GRO enablement completely. This is annoying in NIPA but also,
from past experience with XDP changing ring geometry and IRQ mapping,
it will also be annoying in production.

My plan / hope is to make generic XDP attachment leave HW-GRO in wanted
features, that way it comes back after XDP is removed, making NIPA happy.
This also simplifies the drivers slightly, as they no longer have to
check XDP vs HW-GRO locally.

This is the most important part, I think - I would like to make
the claim that HW-GRO and XDP are incompatible (today). Most drivers
seem to agree, but IDPF allows XDP and HW-GRO to coexist. XDP can't
carry the GRO/GSO state so changing the packet or trying to send it
out would probably end badly. We should explicitly clear HW-GRO when
XDP is attached in the core, until we have an understanding of how
they would work together, and appropriate tests.

Please comment if you have opinion on the HW-GRO+XDP in general,
that said, this series is just prep around bonding. What I described
above will come next.

This series tries to shore up the gaps in XDP propagation.
bonding bypasses the XDP program accounting in net_device so all
the checks on control path trying to avoid enabling features
incompatible with XDP are moot (e.g. we can have XDP+memory providers).
First patch fixes the accounting (next 3 patches add tests).

Last patch makes us drop GSO packets if they reach XDP. I can't come
up with a clean way of stopping GRO from working on lower when upper
has generic XDP, so let's just drop the packets. I don't think
generic XDP is worth the effort, users can disable GRO themselves
if they really care.

All the issues here were discovered while working another series,
but they were reproduced and tested with the selftests included.

Jakub Kicinski (5):
  net: record XDP programs propagated to lower devices
  netdevsim: add ndo_xdp_xmit
  selftests: drv-net: check tcp-data-split against an already attached
    XDP
  selftests/bpf: check XDP attach on a nested bond slave
  net: drop GSO skbs instead of handing them to XDP

 include/linux/netdevice.h                     |   7 ++
 include/net/xdp.h                             |  16 +++
 drivers/net/bonding/bond_main.c               |   4 +-
 drivers/net/netdevsim/netdev.c                |  20 ++++
 drivers/net/veth.c                            |   3 +
 net/core/dev.c                                | 105 +++++++++++++-----
 .../selftests/bpf/prog_tests/xdp_bonding.c    |  18 ++-
 tools/testing/selftests/drivers/net/config    |   1 +
 tools/testing/selftests/drivers/net/hds.py    |  65 +++++++++++
 9 files changed, 206 insertions(+), 33 deletions(-)

-- 
2.55.0

