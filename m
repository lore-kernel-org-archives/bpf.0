Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097068;
	b=iL+lL4iDRFEjsVUWCNCyzew/ngWmXjPRgvFEEsSbWHbyADzZU33NhP2DTKPKrsnR8ib2
	 4OO9DLMg9CB/2rAorfrvXZKGKbR88Mjg4dOZBrZxuxu2bJOrDyKEssvB17zbcO8MgxtOy
	 4rkG6UWG86commPiODLP/Ct5xaNhtwO65HcdicwFjew6ib7jYzdPk5RMKUeVCC3u57pDH
	 LTaRlCx7EWguwo1hA1eeADN4Vgitm5S1OKDt/1vTcJEGj+0qhLqlbsG1jsSCwyIayyrZb
	 sJM7mLNvdv2R3qo89ydaNtQJbEL01sFMHELBHRnKPn9lTkWGHIR5BzlqBsKYNBbrGkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097068;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=e6oXbuZroz8JuDwbf/JEPi4sUfj0w3WvHzrO0wj5gvg=;
	b=XpacpitZSsw2mC2/GPVKSlpMTXR3la3PTV6vaEBuxP2pfXbypfG3xZOw7L3KO7syDlIm
	 08B8FcR254Hw56HEKOb58iQRjpKPnzV8jJ1eq0QYZ/jFcj+YgtEocCQyna6IN2O6/TuAd
	 1Xci0mjzAp7WsQ1+4C1P64FL2rmUBQgLWDlRswRXlNJNdinSrpiuedOe9Lr5IJHhQprgx
	 Lj0dGlxptsmYuBfjsrGMGIS8EdKp4dp2qHiDzqy30mitm6HK6duAMCwOx0zKa236vJge/
	 ko1GqnirPu6K+nz+gd2DPOHkAnQ+aCuF1V3gLEnk/A2XVnhq4uWkSHnULGhcDDod0wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=v6VIYYlx;
	arc=none smtp.remote-ip=195.10.208.47
Received: from mout-b-107.mailbox.org (mout-b-107.mailbox.org [195.10.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA020606A325;
	Thu, 19 Nov 2026 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA020606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=v6VIYYlx
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-107.mailbox.org (Postfix) with ESMTPS id 4jVgFG4tGmz3xTD;
	Thu, 19 Nov 2026 15:04:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795097058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e6oXbuZroz8JuDwbf/JEPi4sUfj0w3WvHzrO0wj5gvg=;
	b=v6VIYYlxbXPZEfVMDV8/vAIwMqcOnpgLz3zLMoYTB996BZ1u3qCv4uLsdVvkybFcIgoK+y
	6zquKS72T1skKTK5QPxvPGZD1PuKs2TFyXz3hZl8Ag+GRqJEhNbfxpVvQkhs31+yIFKdKj
	2zVytGqlgb4pXBpTCNdfFbmlPev2nFEnwPGTpWF1w97njok9VfFbVG5QDIoptxiyviEhGb
	nE/pjwsvFaT/nd0ePCsbOWDPTKGiS+FtPedGJ/e+M3GL36koOjtAMouBU7Fyt3JHuZy9ET
	ika4xwQqFSxls5WdFIa687wcbQFMFldaoivvqWKJ4fQpxnkTFpT4h8YR/L9mNQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Janis Edvarts Lacis <janislacis06@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Joe Damato <joe@dama.to>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v3 0/4] igb: fix runtime PM resume issues
Date: Thu, 19 Nov 2026 15:04:06 +0100
Message-ID: <20261119140412.163202-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.56.1
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
X-Rspamd-Queue-Id: 4jVgFG4tGmz3xTD

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 2 and 3), and devices that can't signal a
wake-up are suspended anyway, so their port stays down when the link
comes back (patch 4). Patch 1 fixes a NULL dereference in the XSK pool
disable path when the stack has more queues than the device, which can
happen after a fallback from MSI-X to MSI on resume.

Tested with the 82576 emulated by QEMU, including, with test-only hooks,
a runtime resume and a simulated system sleep (the suspend/resume
callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
with the device forced to come back with MSI and a single queue. Not
tested: real hardware and PME wake-up, a real system sleep, the MSI-X
allocation failure itself, the window before the work item runs, and
SR-IOV.

igc has the same issues (see the notes); Joe Damato offered to test on
igc, so its fix will be sent separately.

Changes in v3:
- new patch 1
- patch 2: set the real queue counts on system sleep resume and from a
  work item on runtime resume, and drop packets for queues the device
  doesn't have until then (Janis, Sashiko)
- patch 3: link the NAPIs from the same work item

Changes in v2:
- patch 2 (v2 patch 1): keep setting the queue counts in __igb_open(),
  only skipping them on resume (Sashiko)
- mention the tested hardware in the commit messages

v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (4):
  igb: don't disable rings that don't exist when disabling an XSK pool
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 96 +++++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  7 +-
 3 files changed, 80 insertions(+), 24 deletions(-)

-- 
2.56.1

