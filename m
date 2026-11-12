Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527434;
	b=ISqSXytQV/RsLoOBxuGaA07IyeoYisl8/g2hNs54p8p1hZ7RqUoPCFI8h4tUo8duajTK
	 +wx3M4E66ezjvpI7QEiDumizZnPtZrkNZhV5ojiRzVltC6G0OP3yFRT4yqlGUTIPFkiTl
	 NKjGO8LygSFviI9xaIYx2xanftnoiBA0lhkqcejdL1ZXvsoRrCxh8+YNTSCELPIWxrGWS
	 9p+m2a+9Ox2V6OpTiP2csCI1iicsQrny9UX9s8qrsfBogdnCVK1SOoVzff8B+Eifzr7Td
	 IqILZ7jovo+TpauUj9V2LSNsPC8VUuA/MGfTlb1L79Wc1lrm15I0fK7EI8zXlGGfAHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EudAvXyZApkHGTMnPSVknUFuPN2G5AVaFWBCjrbLR3U=;
	b=t4mOHsDVOIzddm9l9Q5+8rbxrAq6NgqRoubA6WH0jZgxfmA+I5TvxgFULtIzi9BVGBIa
	 QvP5D8kOgUGptCsjv/iMQUnofYHnOi1AYK3/9/x5pH9dz0Jxk+Zqxx5zqkX4BflNK/w7p
	 kgVFqHGYVWExZi7TF6u+MIl0U+Mer9x+Y57GL9BBAYir0Bw+8brSw8E8j3BxDtqy4mSxw
	 uwY/9MYLuiK2+Lvi/j1skHmKn27smThTE2FdqOdVdw3U6dtNRIoOR+YvQxK3jQBD/Aks+
	 bWZhfcEnVzZQv7OdLu6Md/Oq2TJXspXC8zQkHL/BWrvIdd/kci4LMS+/fWECIr1rSdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWoQsCZx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB07606A327;
	Thu, 12 Nov 2026 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWoQsCZx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9D91F000C4;
	Thu, 12 Nov 2026 23:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527433;
	bh=EudAvXyZApkHGTMnPSVknUFuPN2G5AVaFWBCjrbLR3U=;
	h=From:To:Cc:Subject:Date;
	b=KWoQsCZxLI2bV8n8RJDVP5uVYQOXOpjVhFh3maR+tDfYfbMB82E4egBMN7jxPZB7e
	 32etNX0UyubNopXt5DEiivg2bE/owVzx4xNAQtUkL6hCDWa70yABn2WNO1tUssXwh0
	 Tlm1AjCE0xiclwUsVkRlJO+GuLoFYBv0kgRivT94LbkagAeXDsR3f/H1R6c8E1Q3EV
	 U/nwR/6j+9T6akYSg/Zg4d0zJf404eJtQWzVXcu+tJRFOnEWFHM9L4tyfb7Z9bKE4n
	 k5vaRn6IoWCKTVPlwJMvhsBxZlYUTQq5Q5brZn4CswCjASqMChfBpH9tJc9mBboGFs
	 El7mezXTw6sLg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jv@jvosburgh.net,
	haiyangz@microsoft.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] net: make xdp config checks effective vs netif_xdp_propagate()
Date: Thu, 12 Nov 2026 15:50:22 -0800
Message-ID: <20261112235027.4072149-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bonding (and netvsc) try to auto-propagate XDP programs down
to their lower devices. These programs were installed directly
with .ndo_bpf and not recorded in struct net_device of the lowers.
This makes all the config checks for features incompatible with XDP
ineffective - HDS, memory providers etc. use dev_xdp_prog_count()
and do not call down to the driver to ask it whether it has XDP
installed.

Record the state appropriately. dev_xdp_prog_count() will now
"see" the propagated programs.

The issue was discovered when reworking HW-GRO and XDP interactions.
I was trying to make sure HW-GRO is reliably disabled with XDP,
and discovered we have a way to bypass all checks with bonding.
Not treating this as a fix since it's admin-only self-inflicted
damage that nobody is reporting being bothered by in real life.

Jakub Kicinski (5):
  net: don't safety-check device features for XDP uninstall
  net: move dev_xdp_set_link() and dev_xdp_set_prog() up
  net: record XDP programs propagated to lower devices
  selftests/bpf: check XDP attach on a nested bond slave
  selftests/bpf: check replacing and detaching XDP on a bond through a
    link

 .../networking/net_cachelines/net_device.rst  |   1 +
 include/linux/netdevice.h                     |   7 +
 drivers/net/bonding/bond_main.c               |   4 +-
 drivers/net/hyperv/netvsc_bpf.c               |   2 +-
 drivers/net/hyperv/netvsc_drv.c               |   5 +-
 net/core/dev.c                                | 133 ++++++++++++------
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 120 +++++++++++++++-
 7 files changed, 224 insertions(+), 48 deletions(-)

-- 
2.56.0

