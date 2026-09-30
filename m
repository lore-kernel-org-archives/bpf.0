Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5B3C871B
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795075; cv=none; b=e0h0cYwxJFN5LvzMF02suf31CLcJyymXe8yaWzmx9os2NbxpVcCQTUjxHgTgdXXmNao44b3MMBbAhHd4PHGjhvrue6w1UOYXLCMsLBWvRh2WP2ztpeNFGj6cUlgqsB1P7HgUClkH/Qai+1hfFO5gvP8Q46H7xPaOZAdcTexu2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795075; c=relaxed/simple;
	bh=raWkwG3ZqxTh+Ynsv+WaiOf9kGWnbx7HZG0atOgXbzk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y9pQ2LcUL/yU2GWaQZheM4Esoj/hjD1WMyVqzVMlQmrhnYuqdLngWVV0+E1JCoOW5rkTzm8pPLFF9+o1dV/etsys/J1qfEmKvQrSHf1S9MHYL4XTgj6Bk2G8FUZLMkZFfJJha6xBvREv/3l2ivaqxyhsWHmcxQpEQLh7fY/hrnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CvdGRJoL; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CvdGRJoL"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2df8484f12cso55314085ad.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790795072; x=1791399872; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EL+61CneWDUxIKYhoBlGzmB7blpKEZqd4Y2mtziLx1E=;
        b=CvdGRJoL3Ybke6oiT2aeFMcOKDi2fnUqETbA3BqjVP+TomaIvCZnAo42xD8saKIMQM
         h/CX9rLgBJwDCBcva3dRumIIKobKna4F8wZi+kQkXmZ2ydDaePp57SKtZA3GDN9AWJSW
         YMBUGvaMybJgvMLM5jKC2pkNYGEa10oxBdvJ3R2EwLX0kRT1mgQpLAZhS96pVa73gMJs
         u+Ddy6a+5smnGAcJ7417t3Kb+HhQPbtP35GpfuaibfDx76/MHaNPgYORcWzUHvZV1Ubf
         1/Nl61/V6DYtDD1QI/D3JWvMWEXnqhLMg39j62rizUkU8JYyzOJ6b7VXOC10GOL+ylmc
         RuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795072; x=1791399872;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EL+61CneWDUxIKYhoBlGzmB7blpKEZqd4Y2mtziLx1E=;
        b=D+nBaGNznTqnNc7o0ojzjLnpQorE0qtO+dFj6vbmInwvjmLYjvzSSWpPAJF8vNs5xv
         wHzVFeGlzPqSttphDuno8wUeF4Gxze244S6wt487YlgMK47dvapaqtWceSCXfRDShOWa
         NtA+vZCxzuF9+ajOFKCk1bWRKdFVFxTSy7bbu+Ei7ShnijCuTbgQTEVwvXnXMWaeeV7C
         WlJKZAevY4PUTI1fxEwxMhsj1QaH1tGnyFs61uedlUKo4JQDajQrniEss68aTZrnuCFG
         wpG4Wsc2qqvAKamYkjksE9P46knMJl2is8kMigCD1kO/rtcPqlm+ZcyUc0+09ro1iem8
         rvsw==
X-Forwarded-Encrypted: i=1; AKwUvBxT4dswtUwO5m8ecf2KDnSKSHAWaKpib6zRgBsXHyajPd1lsx2FIYYlzeLA9c+pLMtnOyw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqNqA29nDJR2sceDtXQn6gvWOTSwy9EtDwbD/3hSnawWnln28s
	lRcpRtYlD7k03smEhNpX3UhO4HarRK4KYoew9JpvOjygfRndRAnt9Peb+3MlCqdwNF9P/dw1LH7
	SIroPy7KNnD+wXihOG0TAZZZG8g==
X-Received: from pgvi18.prod.google.com ([2002:a65:61b2:0:b0:cc7:d128:5a50])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234a:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2e2e4bc8440mr19808285ad.64.1790795071550;
 Wed, 30 Sep 2026 12:04:31 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:04:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930190428.1130007-1-hramamurthy@google.com>
Subject: [PATCH net-next v9 00/12] gve: AdminQ mode related refactors
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

Changes in v9:
- Patch 1(Sashiko):
    - update commit message about gve_set_mtu to satisfy Sashiko
- Patch 6(Sashiko):
    - use netif_device_detach() in gve_recover() error path to block
      ethtool calls
    - cancel the PTP worker before releasing device resources and call
      gve_teardown_clock() only after the device has been reset.
    - use gve_open() to bring queues back up in gve_recover() holding
      onto the control plane on failure
    - update commit message
- v8: https://lore.kernel.org/netdev/20260924185316.2831077-1-hramamurthy@google.com/

Changes in v8:
- Patch 6(Sashiko):
    - call gve_queues_stop() directly in gve_queues_start() to handle XDP
      info unregistration
    - drop gve_queues_mem_remove() from gve_queues_start() and leave it to
      the caller; this moves a few function definitions around to avoid
      forward declarations
    - revert the gve_mgmnt_intr() behavior change from v7
    - handle the TOCTOU when checking for a pending reset
    - record all configurations in priv before sending an AQ command that
      can result in a reset
    - update the commit description regarding teardown-related resets
- Patch 8(Sashiko):
    - gate mgmt IRQ and notify block teardown on different conditions
    - move gve_teardown_notify_blocks() from gve_reset_device() to
      gve_teardown_device(), and tear down notify blocks as part of the
      device reset
    - don't set block->irq when tearing down notify blocks; instead guard
      the disable_irq() call in gve_remove_napi() on whether the IRQ was
      requested
- v7: https://lore.kernel.org/netdev/20260916165533.2187434-1-hramamurthy@google.com/

Changes in v7:
- All changes are in patch 6(Sashiko):
    - Return IRQ_HANDLED instead of IRQ_NONE in gve_mgmnt_intr()
    - disable service task instead of stats report task for gve_probe() error
    - cancel stats report in gve_free_stats_report()
    - extract gve_teardown_control_plane_resouces() and gve_adminq_free() into
      new gve_reset_device() to ensure the device reset is triggered before
      stopping queues
    - don't call gve_queues_stop() in the gve_close() error path since the
      gve_reset() takes care of that.
- v6: https://lore.kernel.org/netdev/20260909191136.3811892-1-hramamurthy@google.com/

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

 drivers/net/ethernet/google/gve/gve.h           |   87 +-
 drivers/net/ethernet/google/gve/gve_adminq.c    |  376 ++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h    |   30 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c   |    5 +-
 drivers/net/ethernet/google/gve/gve_flow_rule.c |   15 +-
 drivers/net/ethernet/google/gve/gve_main.c      | 1067 ++++++++++++-----------
 drivers/net/ethernet/google/gve/gve_utils.c     |    4 +-
 7 files changed, 975 insertions(+), 609 deletions(-)

-- 
2.56.0.rc1.310.g51773c2048-goog

