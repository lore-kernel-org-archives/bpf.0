Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208519;
	b=zCa3chFIV+rcD3yS2i6Qk2ke0FqZcz1hY+5jY2z12IrgZqYS5A3qEROIa7vWKQCw+sUV
	 MBmNaeYbT0XDCFdlHqIjiJ8Hqv723jC4gRC10RmLtrRzTG1NsTRuap6Gr4Qa54dVEb3Zp
	 0+BhzLNYsx0h9k3lDmIkTGrD1S0WQiVRotS/Jm2JgHSQRb6s6dnXcUy8c5wzS7sILUOIj
	 B8vIThfz1On9cGA23/OUmzR3AaMrHb/pEwP+I7Xc9AX5Uhw1d0iKolTQkoDhUUyFSK0y3
	 dQIO8ivbcrDTanslVgWSNQp04sVd8ILZBxOz0OOneiTGbTxjDpd1Xs0kwYEBrH2INSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208519;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=UjVL1Qc7n3db7V4lWVOqeGzt5DSdlZNSRU7y5NWVihM=;
	b=Qq1h2m6mNREDnDekcUT6YrpRxnltqsfqzaifJr209pLjQ0jFz7yrj3Utux4iQTXPSM9A
	 hyZpnKv1gzXot59hs6hU+c2zw/gL44iQ2TkZXdLUAW5bZDgJkyZOAGx1oA6Axi4o2JW/P
	 J/sHAopzrfyWiVwbrWpt648CCO8Y0eIV8NOw5Ix6M/LdgDF/pfR7I6sFO9QvEZ1oNN4uY
	 LvXS2K7KswYqhXxXWPjwRqrHmyVR0n3rKw2IxV2BrV9VrG7JkvNxnpybBMIk2lgniVbuf
	 c9pTMgFEk4ubEKVV/AP1WiM9pjYOJw09hwvK3lFAIAoPIuDlblmEg6z8OJRKHDzyDjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Ce7ciqjf;
	arc=none smtp.remote-ip=195.10.208.52
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5ED606A337;
	Fri, 20 Nov 2026 21:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5ED606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=Ce7ciqjf
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4jWSSM0z9CzLmBH;
	Fri, 20 Nov 2026 22:01:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795208499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UjVL1Qc7n3db7V4lWVOqeGzt5DSdlZNSRU7y5NWVihM=;
	b=Ce7ciqjfyhjpC07H4D/uYPabi8vFezYqLbmI+zeBhbPCprnlMvVTyRvSCR+sUjxAZ0KUXe
	SWfg9XkyoSNyjCkQnPQnh8O4tCFwYklndgR68fld1FEx4P+oX76TQMfDzX/Lua/XkLMCdD
	H0w6PZY/smfhtqySM+ApI+KFZzta/m6LYsT6GtMbZ/3FBrOTTHZ9AslXCefIL1yITG9egf
	G1eoplXSHFAD2Z0vh5g5lzDIvBLdaVJhr9weoDdsP/2GbQASdEFm1LSe78fMXH6aRKbeNE
	toSvBUVwMG1xF7KGPXncwUjUFjP+W0NFmj1GtOGNr8rF93j/6/CdhoowFligtg==
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
Subject: [PATCH net v4 0/4] igb: fix runtime PM resume issues
Date: Fri, 20 Nov 2026 22:01:28 +0100
Message-ID: <20261120210134.133238-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jWSSM0z9CzLmBH

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 2 and 3), and devices that can't signal a
wake-up are suspended anyway, so their port stays down when the link
comes back (patch 4). Patch 1 fixes the XSK pool disable path when the
device has fewer rings than the stack has queues: a NULL dereference
with VFs (a single Tx queue on 82576), or after a fallback from MSI-X to
MSI on resume.

Tested with the 82576 emulated by QEMU, including, with test-only hooks,
a runtime resume and a simulated system sleep (the suspend/resume
callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
with the device forced to come back with MSI and a single queue. Not
tested: real hardware and PME wake-up, a real system sleep, the MSI-X
allocation failure itself, the window before the work item runs, and
SR-IOV with runtime PM. Patch 1 was tested with a zero-copy AF_XDP socket
on queue 1: closing it after enabling a VF oopses in
igb_txrx_ring_disable() with stock igb and v3, not with v4, and the Rx
ring then no longer references the pool. Not run under KASAN.

igc has the same issues (see the notes); Joe Damato offered to test on
igc, so its fix will be sent separately.

Changes in v4:
- patch 1: also handle queues with an Rx but no Tx ring, as with VFs:
  tear down the Rx ring and skip only the Tx part (Sashiko); subject
  changed from "don't disable rings ..." to "don't touch rings ..."

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

v3: https://lore.kernel.org/netdev/20261119140412.163202-1-antonio@mandelbit.com/
v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (4):
  igb: don't touch rings that don't exist when disabling an XSK pool
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 96 +++++++++++++++++------
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 37 ++++++---
 3 files changed, 100 insertions(+), 34 deletions(-)

-- 
2.56.1

