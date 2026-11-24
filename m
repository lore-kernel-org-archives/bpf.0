Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795564662;
	b=U+m/4bAk4V1ottUCVom0qNCNYX+akeUUScuMxCpWvg32HT0VTvZlcULeTGmGNzPAq8/P
	 i9DF1azuwIqW8nJF5OXvwFZp3G/p47/5jOQZC4glR+u5b+Rx8PWBL1/c8FJN6p9a2BFaP
	 wAw8k9oOyNYtwGPgDLkEfFn6y7/1GurA6BASBbPjJOCDYfF4P9ai7HyMLA4Zm/eg2r4rl
	 8SQoBxHR7dHaGqX4XSi+lw/TvJHl/ZB0zJ1zKFzJ3944NKPch/nR7hydix5Oj0lN7vimr
	 qw0kSLruJBSggO8eVGPCqbkX1+xmSZ8s8lTyq/FFK+qyUZmmOkfhnt65s2+DitoH/lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795564662;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=xflsaRVWDw/j7j7UccdvzcudLLakoQDeNNfP3M0KnZA=;
	b=Dsx7CUYQ5y8rDuYNwv6jVdwtvTl7FKdhKj1z7RK4pywAMdomALnM0mCH6BkDa3ByG4l2
	 uTSZZpZgfltggb1unlbcy5r5+7UJGp4oBNcCOqXwfiIHcw/RN1R2UiF93NL46Y6q/xmEy
	 Waoos3U6/QfyH/uAxosybTBs1CMvmIWMnN3MtPgHk1L879lXttIsWtNEbmOp3sOrzj1DD
	 45+SwzinBJLF5dhEAZcm+/gLFF0qRDJV46/QR3D3FmOkyhozhmi1YIivHTaDQmSIUrXFZ
	 TKweCSUxCy2Xs5XvscQdyG7IsY5YqaI26kuq3hfEXhB8wqMvhtuzOKDjVGfxoZTPMiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=m0LXNtcq;
	arc=none smtp.remote-ip=195.10.208.55
Received: from mout-b-110.mailbox.org (mout-b-110.mailbox.org [195.10.208.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5D606A33A;
	Tue, 24 Nov 2026 23:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E5D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=m0LXNtcq
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-110.mailbox.org (Postfix) with ESMTPS id 4jZ09R5LgBzNlvx;
	Wed, 25 Nov 2026 00:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795564651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xflsaRVWDw/j7j7UccdvzcudLLakoQDeNNfP3M0KnZA=;
	b=m0LXNtcq/2LbG2mD4m4VlkgfRKYFwbKS/LegkgV5FqAKEfNUnpXH6AYKH0aXmTdyE9b2+c
	gC1afL98daHcBi3pOUfh+7mqjbwj88WPe1LMzrhWLLeZKTGPwJx3fhhkHUktBAStTyMmjp
	J4mBpbHtO0hm7kJv1vSYwc43fP5nFs4FC6ur3FybafSu2uzX75vQBHLwPGpg79Dee3zK2a
	eb9PAHj6CN/3V+AlE3mqV1Ur6A9b9nR8wu7MKjx4feskHUoxBXG+lojxwUqxQeZPOgoPRB
	vQAq0RxWmF0yNes0CCba1hLUi2SV+0oDs+7IQht2dv8hzwi9Lw59H42sAK3pzw==
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
	Sven Auhagen <sven.auhagen@voleatech.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v5 0/6] igb: fix runtime PM resume issues
Date: Wed, 25 Nov 2026 00:57:15 +0100
Message-ID: <20261124235723.1135808-1-antonio@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jZ09R5LgBzNlvx

igb can be runtime suspended when the link goes down (with
power/control set to auto). Resuming it calls functions that need RTNL
without holding it (patches 2 and 4), XDP and XSK changes race with a
resume (patch 5), and devices that can't signal a wake-up are suspended
anyway, so their port stays down when the link comes back (patch 6).

Patch 1 fixes the XSK pool disable path when the device has fewer rings
than the stack has queues: a NULL dereference with VFs (a single Tx
queue on 82576), or after a fallback from MSI-X to MSI on resume. Patch
3 keeps such queues while they still have an XSK pool, so that the pool
can still be disabled.

Tested with the 82576 emulated by QEMU, including, with test-only hooks,
a runtime resume and a simulated system sleep (the suspend/resume
callbacks called directly, as the test kernel has no CONFIG_SUSPEND)
with the device forced to come back with MSI and a single queue.
Patches 1 and 3 were tested with a zero-copy AF_XDP socket: closing it
after enabling a VF oopses (queue 1, stock igb and v3) or warns and
leaks (queue 2, v4), and warns after a resume forced to use MSI (v4);
patch 5 by closing a socket and attaching an XDP program while runtime
suspended. Not tested: real hardware and PME wake-up, a real system
sleep, the MSI-X allocation failure itself, the window before the work
item runs, SR-IOV with runtime PM, and a device that can wake up. Not
run under KASAN.

Sashiko also found two pre-existing issues in the XSK queue disable/
enable paths (the Tx NAPI isn't stopped when Rx and Tx don't share a
vector; a failed buffer reallocation leaves the queue half torn down);
they will be fixed separately.

igc has the same issues (see the notes); Joe Damato offered to test on
igc, so its fix will be sent separately.

Changes in v5:
- new patch 3: keep the stack's Rx queues that still have an XSK pool
  (Janis)
- patch 4: cancel the work item before a suspend (Sashiko)
- new patch 5: resume the device before changing XDP or XSK settings
  (Sashiko)
- patch 6: check pci_dev_run_wake() when scheduling the suspend
  (Sashiko)

Changes in v4:
- patch 1: also handle queues with an Rx but no Tx ring, as with VFs:
  tear down the Rx ring and skip only the Tx part (Sashiko); subject
  changed from "don't disable rings ..." to "don't touch rings ..."

Changes in v3:
- new patch 1
- patch 2: set the real queue counts on system sleep resume and from a
  work item on runtime resume, and drop packets for queues the device
  doesn't have until then (Janis, Sashiko)
- patch 3 (now 4): link the NAPIs from the same work item

Changes in v2:
- patch 2 (v2 patch 1): keep setting the queue counts in __igb_open(),
  only skipping them on resume (Sashiko)
- mention the tested hardware in the commit messages

v4: https://lore.kernel.org/netdev/20261120210134.133238-1-antonio@mandelbit.com/
v3: https://lore.kernel.org/netdev/20261119140412.163202-1-antonio@mandelbit.com/
v2: https://lore.kernel.org/netdev/20261116153041.3002666-1-antonio@mandelbit.com/
v1: https://lore.kernel.org/netdev/20261113105835.3821433-1-antonio@mandelbit.com/

Antonio Quartulli (6):
  igb: don't touch rings that don't exist when disabling an XSK pool
  igb: fix RTNL assertion when resuming from runtime suspend
  igb: keep the stack's Rx queues that still have an XSK pool
  igb: link queues to NAPIs under RTNL after runtime resume
  igb: resume the device before changing XDP or XSK settings
  igb: only allow runtime PM if the device can wake up

 drivers/net/ethernet/intel/igb/igb.h      |   1 +
 drivers/net/ethernet/intel/igb/igb_main.c | 144 +++++++++++++++++-----
 drivers/net/ethernet/intel/igb/igb_xsk.c  |  37 ++++--
 3 files changed, 143 insertions(+), 39 deletions(-)

-- 
2.56.1

