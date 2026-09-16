Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B43F548577
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577747; cv=none; b=q4hUfl/LMRKNYjVgUVV8mx14ReOMrxFetLo68bkMlfSyWqApGGr7MdhlauGJbnIXtk0Xlopp675wA4v9/t+/xEtFAaG1XAKfUmBko891Uv08V5kB6KXfIOXCLHxqiXH7c470kEp8/b2zq3vA0Ao1FOYzLUN6DhcTakXR4Uag3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577747; c=relaxed/simple;
	bh=kcSN+BGt08y0TBQmKmzxsTvtl5zyqxhcMvNRCZk3Ips=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BOcU0yUJY8hyUrawZoDQDQEo5SzLSkvqTy0TYaX6HxPbVRABcZd+guX2vLEEy62t5S1soMHW8k+a70Azo0o+ShZVTgYpnmxPOPR0mhLjRc45J26RC4fnQmxMC5H1YW4+ale4Dz1nKpr03vjeAu5/z5rB1nIY2lzzIJeLCoF//bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2W0EImj; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2W0EImj"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so4501228a91.0
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789577738; x=1790182538; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T2X3zZpC9TvpFJ2Xn+2Y8rh+KR7KcuZlbQgdZqsIOD8=;
        b=M2W0EImjSp8jQh8W7lm0/QFzaUt4paGIbHYFt+YHJbQ5jvu338t1fNw35RQTuiFWZ9
         rCb4XgepYqgauJVSYPnrIXh8mhmvtnjfgm5GyZoDqCtDGyhiGQUU9f6m7ya/euGMfygp
         63dJb3ORPd5OPwn2pCa052v/FnZ71HnQis6uDmuSezW48dw8/RoiAm55+1m5Qb/XCmYu
         1YZCU8YOacwGGgXKvQteqXOXtOmNicIcoPeYKXMsSoP20KnFvqspCQRpdL+OfNsS8r6v
         /KF74YXV+rnxNeJ7Xsjht5II90AR2/aBL3EzWa9j8EX5UaNaX3a18BLTVSLuM48Ocm/w
         CGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577738; x=1790182538;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T2X3zZpC9TvpFJ2Xn+2Y8rh+KR7KcuZlbQgdZqsIOD8=;
        b=i7cJKXoI175UurhBkfEib6vmm32NJf4t9u1ZGP5j/OMV/6kJjyE9RSKCj5gnmYh8ZM
         ri+MlL+fLMdcV3VrzYDWb4X5moucPqOo30ZiwzfpZnVumw+QPPNcUZ3rpEJ6opRmw6Fs
         iGqhJ9s6G4N13xvYtVQYcfo/tba0kF3Yqjen4h7HuuaVBxA8Bp5JjrFpV1/vQbn7rCR0
         A39U+/wS9wVzwMEOl41BH4fvSHKQbK2Y3LhuXd1sdnJA7UWpj8VdJkqBjlMqeXgXXUN8
         EYYfU8YyaX2aerRXLp0LkPXEBlMQyGgYTp11ywgbPwW5UWDmkly3AXh45k5fAocp8RIC
         lfuA==
X-Forwarded-Encrypted: i=1; AKwUvBw/tuqpJJUSO7WIVa4nOwe9qKqDFOB1xtyQvBJpxfiS7+3WH3bzDRxcM/FVQeJNfOk4ZDY=@vger.kernel.org
X-Gm-Message-State: AFuF++k4CIwMkGmDA7Oty82lXwZowHskZCtXwZk1sZ/5rDNv9GDfQpqT
	H2bDsM+qdn4Wwx8/4ae4aob6xX5ysQAK+6H56euQARA6YJlfqgC2PBojxHAaevEsYdn2VDSjRRl
	1aK9T75NLienjC6VZmnqOb6jMxQ==
X-Received: from pjqo5.prod.google.com ([2002:a17:90a:ac05:b0:39b:272c:665b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f4c:b0:39d:fcbe:c1ae with SMTP id 98e67ed59e1d1-39e1e521399mr7138447a91.23.1789577738194;
 Wed, 16 Sep 2026 09:55:38 -0700 (PDT)
Date: Wed, 16 Sep 2026 16:55:21 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260916165533.2187434-1-hramamurthy@google.com>
Subject: [PATCH net-next v7 00/12] gve: AdminQ mode related refactors
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

 drivers/net/ethernet/google/gve/gve.h         |  87 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 380 ++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  30 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 894 +++++++++---------
 6 files changed, 883 insertions(+), 528 deletions(-)

-- 
2.55.0.1032.g73a4cd73de-goog

