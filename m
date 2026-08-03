Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB6427F94
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 18:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785782794; cv=none; b=VNsVFXcx2+phOQnIc+4BA+g2UbnStemJqBvTAX9scN4WBzjxfYvdY5tLXL6bvCzuk4FYD8CNdx8XOUB/q2Z+5qdqUiiisjEs8doCj4adVRK+bEzcyD0zXP40dP1KZEDvl3Ka9pYk4CeRmCl3x2Ifxnqtwih6FsWKodkZXSj1h5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785782794; c=relaxed/simple;
	bh=qdnMi5UKmgwLH3Yxi/4yylk2ifjbYPC1D6DDNsZGTnE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gB3S4u6hIGWhjGIWFXvTkGMV8XivjaaqmWARg4QrhVzbzTnv2MddthlFuisrPK5v0Z+p1Un9684NzM0BY2XMSROxhR3WexuUkp8Jz2NDmcfal0WrOPyqQkN8pd5Q9toH6Wdv4UHsmOuPrndV3XU9M/tEpFwSbV2gdjNff7Y/hW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fN+gSSww; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN+gSSww"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb835525b10so4999826a12.2
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785782793; x=1786387593; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v2GbAn1mai/t41mi3VJpzRReRyT0xUGHdjiq3a6bBNg=;
        b=fN+gSSwwaznRreLjWz0RFNxG/wuY2FiYwSTL1bvm6edZUXQztTWpEvPhvvPxUm8Gia
         4mpvvivS6Pso/muyH/RLHVJSevK0YjikEER4j1OnNq2JFk6PANegTo5WZCkgbW39zFSN
         88nOcEfY2UUwrFBvQiT8uzYbdWJggk4JOA4EqC5c5EouZw+getrWvt4veFOTl2B8W60W
         J98SVJDmpftpT7FcbNkBizme2ZCpTn2YyQEirbaFy8vXJxVGbN5g9KIpnyC/4ejOVjV7
         M1c8zUu6yai0Zb2FDTEjYqprXCrOToZkgIgKOSq1NqwzKlGbd2/eYee3dRk3twUTjVdh
         HLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785782793; x=1786387593;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v2GbAn1mai/t41mi3VJpzRReRyT0xUGHdjiq3a6bBNg=;
        b=TiniR9x/GpLGeUcS9do+CoT5YaQbEKO4YUzOqFeWtwZWh8/8Odk0MuONMN+kRDQhc3
         FqzEIelN74j2nkSBIN0fQNwVeaoMDnk9bysgmR+wdgAx599hRor0kfdB2AG3p63bhjbp
         08/6brp1N08aIm9DyIZeKDlBGQZDpGL80yhKYEcynQXQm4UsyDPnE9kCzLM7aYuyYpxo
         UgnWsvKuAHETOnWgSoWDQQRskPglQH1J5O51MpJ6SZUtInvK771cxRzOSNxNmAXvivGk
         uWHu5wXSkhprm1mvEElWxHvQEj/+J68Of8sMTYlBLpinQRP7u6WdspNJ1T4wwHnAlIe1
         uyug==
X-Forwarded-Encrypted: i=1; AHgh+RoUPwWbvlkdAfbTwJbHYRwl85ynleWi/ncSbnA1LV87e4/vyVSdnY+IVkpfogAEzOIMZw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw266a+Jj64s8PHVGAFn/RwJY61sSFetF7RehbvqxZu1IMjRQna
	BleMVSfpEX8cDg2Jnh6afLQ5rgSXncj3Qki3Hlmk2P8HwnDqmWW8M73+2PsCFNr2AEPggQLFtbl
	pbewUzY/Ay3D8Xs/BB4uzXH0PQQ==
X-Received: from pglg5.prod.google.com ([2002:a63:1105:0:b0:cbe:408a:5061])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4cc5:b0:3c3:a140:938a with SMTP id adf61e73a8af0-3c92a83766emr10702634637.45.1785782792425;
 Mon, 03 Aug 2026 11:46:32 -0700 (PDT)
Date: Mon,  3 Aug 2026 18:46:15 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260803184630.3813311-1-hramamurthy@google.com>
Subject: [PATCH net-next v3 00/15] gve: AdminQ mode related refactors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This series is preparing the driver for the addition of a new control
plane mode(MailboxQ) by commonizing and reusing as much code as possible.
MailboxQ is a new control plane infrastructure which uses mailbox queues.
This is a new control plane to communicate with the device when the driver
is running on bare-metal instances as well as newer versions of the device.

This series contains 2 main changes to the gve driver's existing control
plane(AdminQ):
1) refactor some initialization/teardown path methods to make it work for
   both control planes.
2) add gve_ctrl_ops structure to the driver for various control plane
   operations

The refactors are mainly around the init, reset and recover paths so that
functionalities could be moved into the control ops like 'set_num_queues',
'set_num_ntfy_blks' etc.

This patch series only sets the control ops for AdminQ mode. This is
intended as a preparation for adding MailboxQ mode in upcoming series
which will add the new control plane infrastructure and then introduce
the corresponding control ops for MailboxQ mode.

The entire list of future patches can be found here for reference:
https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/

Changes in v3:
- Fix driver compatibility verification in the reset and recovery paths (patches 2, 8).
- Mark gve_adminq_get_device_properties() with __maybe_unused ahead of its usage (patch 7).
- Refine error handling and resource cleanup in reset, probe, and queue creation paths (patches 8, 9, 11, 14).
- Keep IRQ doorbell allocation/release in control plane resource helpers (patch 12).
- Minor fixes: fix TOCTOU issue for link speed, correct kdoc comments, and remove redundant teardown calls (patches 4, 11, 15). 
- v2: https://lore.kernel.org/netdev/20260602235900.3050782-1-hramamurthy@google.com/

Changes in v2:
- Rebased against latest net-next to resolve apply failure for patch 5
- Fixed a few typos in commit messages of patch 9 and 14
- Fixed a kdoc warning in patch 9
- v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy@google.com/

Harshitha Ramamurthy (9):
  gve: don't pass in unused parameter to gve_adminq_free
  gve: refactor initialization with helper functions
  gve: add a few helper functions to set device properties
  gve: add struct gve_device_info to hold device properties
  gve: introduce control plane operations structure
  gve: introduce ctrl ops to set vectors and Qs
  gve: introduce gve_adminq_get_device_properties()
  gve: refactor gve_init_priv for reset path
  gve: add ctrl ops to for queue operations

Joshua Washington (6):
  gve: simplify reset logic
  gve: add gve_ctrl_ops for gve initialization/teardown sequences
  gve: split up notify block allocation and setup paths
  gve: introduce new methods to handle IRQ doorbells
  gve: setup and teardown management interrupts
  gve: add link status/speed ctrl ops

 drivers/net/ethernet/google/gve/gve.h         |  88 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 432 ++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
 drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 936 +++++++++---------
 7 files changed, 947 insertions(+), 556 deletions(-)

-- 
2.55.0.571.g244d577d93-goog

