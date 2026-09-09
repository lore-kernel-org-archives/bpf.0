Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F5D357A4A
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981100; cv=none; b=G3wt3OPyukDiuKA5Ovrn//QxredMztFi+saWqPTaaDTNpj82CERtzHPYXjqyKD7ZfxMvwHUnX7SvrLSeHf3hjuHev5J4VXHBVL8u6rtTTQDEgpEZ8wCZWdQzn3bWrKjRfCx1LLb/KJl+zxaW5tmnFzttGKnh27wjpqUMMxl29GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981100; c=relaxed/simple;
	bh=1/xnnu591Pdp9yuovipzpNQsLPugxzWuJoSOIxa70hs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YwclV+82TF0xXzh/6e9lR4UNoRe+7m8ME0zKhs7xI2x39jL9gFhNOEguwHLifTdDm/NolACs7Ha3WvTtvdIitzVm+bcrZczG1MSMH/QGqRE0pwjD7VjCKwrX0utw/WKZwNoLDOzhwt/qT5drqa6PB44hPI78LTPJKRthhuAbOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHxCBd5I; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHxCBd5I"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b6416441eso7248029a91.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788981098; x=1789585898; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WBgvG785AfFM/VOj79CCPL3tGNM1lGOecSdx0YvOvuY=;
        b=mHxCBd5IWf54h/mf0Pg6KVWXCft/hTf2WJzG/+EHW8kEjWz0i4hu94GYWjKD4ZDp+w
         kpEmIcOflEHM7KY0noAQyr6NbRXsMPBpVdJsxt9+TSpkZz20fq3QihxwEg6cphdOvTAd
         xb2Am0sgy3MJzxvEQgj3d9FoKyWf9xjRmT+K+K4GibHetnJXvtrI9+DQacL3nvQJt4ML
         M729L+ZcI96KKry8xK9UV9gqDxvQ5qoIYBIxYarXLelkhSR7kLsJf41xi/UJZsXugeRh
         ROhkm/lz2FDTn22lQM3q7Q5aKbAaaIhV7Jrl3Ba25ZHBrvOa6AE2ragIKAd9mTLp6gam
         xjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981098; x=1789585898;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WBgvG785AfFM/VOj79CCPL3tGNM1lGOecSdx0YvOvuY=;
        b=SBK2MdsAuNCmKDRmz3nI6tSptm0ehu2i5SYPVIJhtX6CxXcnKc7EpJDBHw2E3Yn43S
         rfLdGHKqBL34PblKW34OqizWaQilqLoH8ARwUef8T3u+0KeHDFeEtykMuLZiur+H4akj
         ZQYwVI4uN4E+VPBTa4w+JCHbhyqPxUVFod83c1YqVyvOSSJD8gGKmxzGNxlOAFWbWOJ4
         j07XQBwVV8RgLW9LAiLnHsdSUEw/FeSoPuGSKTCJCOVnvt7gpCsfcX2Jmy2OXsdfSBh8
         mjN22VEp3D80P+3L7QSCdqLzWWdqUbue8E4BD5jnwWUItCXxnRCJtXoYD0PkYJ409Aq6
         7oAg==
X-Forwarded-Encrypted: i=1; AKwUvBxHcQBHhRUCo8/m3QEv6twKpTMzntSgrFvXNG1aj6JkmnlWpRxBG0Q4bikhLZbiyPWKuoc=@vger.kernel.org
X-Gm-Message-State: AFuF++kuLxTggV0s6vA9x/1EokCWviP+MfBO0cAMsvtmtHJLCjC3i8MQ
	Wm1X48BNZZsjlZ6I/aY05fy3sx6N8/1hy90yKIwSmVtzHDD9CmSNlltsbZz818yQWmwnT1rNYh+
	148aDHVhhL3jNF0hI0BiFsHboLw==
X-Received: from pjbcu10.prod.google.com ([2002:a17:90a:fa8a:b0:39d:63bc:3af])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b43:b0:398:ab03:95b2 with SMTP id 98e67ed59e1d1-39d709e5464mr3792495a91.10.1788981097465;
 Wed, 09 Sep 2026 12:11:37 -0700 (PDT)
Date: Wed,  9 Sep 2026 19:11:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909191136.3811892-1-hramamurthy@google.com>
Subject: [PATCH net-next v6 00/12] gve: AdminQ mode related refactors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com, 
	willemb@google.com, nktgrg@google.com, maolson@google.com, thostet@google.com, 
	jacob.e.keller@intel.com, debarghyak@google.com, kees@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	przemyslaw.kitszel@intel.com
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

Changes in v6:
- update commit message to be more consistent with code (patch 1,9 Sashiko)
- call out MTU validation change (patch 1, Sashiko)
- A few other Sashiko related fixes (error propagation in patch 2, drop double
  logging in patch 5, drop unintentional type conversion in patch 11)
- v5: https://lore.kernel.org/netdev/20260903215606.31633-1-hramamurthy@google.com/

Changes in v5:
- This series contains 12 patches since 3 patches from v4 were applied
- Picked up Przemek Kitszel's Reviewed-by tag
- Honor device provided default no. of Qs and max rx buffer size correctly (patch 1, Sashiko)
- drop unnecessary header files and __maybe_unused tag (patch 4, Sashiko)
- fix workqueue disable count, destroy rings before stopping Qs, stop queues in error path
  in gve_close, preserve ordering of gve_turndown->gve_destroy_rings->gve_queues_stop
  during close and reset (patch 6, Sashiko)
- drop double logging in all paths for queue creation/destruction (patch 11, Sashiko)
- v4: https://lore.kernel.org/netdev/20260814021406.3044324-1-hramamurthy@google.com/ 

Changes in v4:
- Reduce code churn by placing new functions directly in gve_adminq.c, introducing final tab spacing
  and using local variable (Przemek Kitszel)
- Fix kdoc formatting and drop spurious management interrupt(patch 9)
- Propagate release_db_resources naming change (patch 12)
- Remove double logging in destroy queues path (patch 14)
- v3: https://lore.kernel.org/netdev/20260803184630.3813311-1-hramamurthy@google.com/

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

Harshitha Ramamurthy (6):
  gve: add struct gve_device_info to hold device properties
  gve: introduce control plane operations structure
  gve: introduce ctrl ops to set vectors and Qs
  gve: introduce gve_adminq_get_device_properties()
  gve: refactor gve_init_priv for reset path
  gve: add ctrl ops for queue operations

Joshua Washington (6):
  gve: simplify reset logic
  gve: add gve_ctrl_ops for gve initialization/teardown sequences
  gve: split up notify block allocation and setup paths
  gve: introduce new methods to handle IRQ doorbells
  gve: setup and teardown management interrupts
  gve: add link status/speed ctrl ops

 drivers/net/ethernet/google/gve/gve.h         |  87 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 380 ++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  30 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 881 +++++++++---------
 6 files changed, 870 insertions(+), 528 deletions(-)

-- 
2.55.0.979.g7e5102b832-goog

