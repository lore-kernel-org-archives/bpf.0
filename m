Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAE46984B
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790933878; cv=none; b=FDhO6P4U70s7cREPCXnTpKbSnRPM64sV6kRJnLe8RMZDtmElCEzJaP/O3w9N7Y4z6Jcb++GLtHKJumSkx/BNeA1Kx5IRZqUNXdwhE/hALUHRlvKHwlHqSTqrkfGU3eibJzUOblxhBui1iZ0O2Ra4XtRkvoXRXpEkw7/qzTpikZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790933878; c=relaxed/simple;
	bh=hjF1q/PDr1VQ0SPNZf0NPwSIXcy1o4xnqnjNXR191U4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaymUzCKc7KaWw4vSYmBm+xErgfpHg7q+jV3RK5l+Dcmga/COdWfAvhB/nlMAhH9w5eGhfW3wWUN1Eo+sYVjBG2spD8/AX0s8m8GHHNUauyY7v7umfd2fxM3ovpE29b4PrA5I+HLgUtXqb0WcM0E+Anxug+ostd0S8qZzD0VbrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzcLMoIa; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzcLMoIa"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so1666628f8f.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 02:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790933874; x=1791538674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M5QrEyABJxz7lLZTosebsLhjA907lQYGcfHczXhztQI=;
        b=NzcLMoIaS2TakaqV4TEOI7q8NKcSKw8OxmsF4ECzNwjSYSNFRoJpcuehyyGcwLcj00
         8fO9udxY5sgsk8qnVroPHPzW/w9+1Vfa1yk33437iAWVufgh89kTd0/askhlQSQufgKJ
         TGxm7g8ofU4y1B0EAu/SS+Mikfpj0JK7Z4SHbLfq0AR7oJNg6fNt3BhpgCQ6iNORow2d
         2an/hL7VudjGDNhNpEaQnw9Jo3SxwzMIqlOqbltCHwYIHRF69DV+i3Nh3X/b7nRuiU9H
         mP9ZXEmIFr51xD0aeN9JVCI4JVs4lxmblwsEl6FhjFKPdhR/RQGnD9GCv/E/F5oZeKXv
         vN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790933874; x=1791538674;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5QrEyABJxz7lLZTosebsLhjA907lQYGcfHczXhztQI=;
        b=t3STAm2FkfInzTVeSxnVXLHrfhDtjLs7hSN+26dK3MwW+TeAKguN5HMXtGm0xmVple
         uCBhRKD0py0LbeumdUVSPq2lsdEwhbv8Y5KnYf8SfGOq5mcRmuXK5nfoNTEbF9JazdLG
         MQmMmrjR84k+ko7guyiJV1LP9sYnUeuD1lqpA8F3Hwyt2nrOWycsi9+bM1j8vj2NWU74
         P+OpN5AzzXCpD0ybkT+Sqq0fIWO6hmGbEbGiH6rl6LNwm5N5RMtbIlWEsJymgjErSidd
         FUDw2gur0eOVRHc9VosixTvY0TV+VqtqBB/r3ih0VRNL9GvGapWjHC7Y+TzYGQb6JQFa
         VTIQ==
X-Gm-Message-State: AFq9FYICCg6KhJy77MYvZx0DSlvPKl3nxMoEiRo2uQCBYNzOBJK2WrBj
	V3OXDJ4096T7XLBy+MDOEirEhdEJBe/tAOPy+QvxIHqdctAAhhabgnas
X-Gm-Gg: AYBFou133cI71b9WbYY6/2HorqoSk9uOWB3idxW2LD1MTOFrZpcE5kkBfBhur4WRd9+
	f+KL2MCY6dECZhzbvo+Q+Gw5gzV5i9n0R9z8UCmq4g0R40nikqsbyUaT/JgFXTSJCCLtjSffdaG
	AlcxXcxwEyySuavhcF0kXqUaH3vcl8Ss9/MkCBwTcBVwGACqDgU3tE50qRhynQhA7PS3KkFjE62
	TtwMjIB1VOx/QH63YazmYvQZLodtLhXhZGDxgg5Xk4o8MpQyiUa+pQ+xOXl2Q6wbzOlf4I1PmJw
	FzTg8/OFaJMI3/v/uUtOpor/dE0cxHoHwl8yemiDI2/W18S7ufxBkIkf2oatdiSU5f6fL580ssc
	RXGgauxkTHOg5ZdheqG/5VefrtIkVgV073a73vyD6OiBGyEiVMB8Q23QOwWem2rJ6yZhB8p/XL6
	KHuUIe6o39+6AUVtSMnYYKa4A9HvQTiJFJIA9hgtZadmfDy4XxaMGZphbQihUHwg93mtdXYFRzT
	z8EKd+zdEC5psWryG54F+0bugxAd9VXBFs=
X-Received: by 2002:a05:6000:2c03:b0:48b:30c:b425 with SMTP id ffacd0b85a97d-48b127411d8mr3947819f8f.21.1790933874088;
        Fri, 02 Oct 2026 02:37:54 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f04f8sm4286042f8f.9.2026.10.02.02.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:37:53 -0700 (PDT)
Date: Fri, 2 Oct 2026 10:37:52 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 0/2] octeontx2: mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20261002103752.006a7648@pumpkin>
In-Reply-To: <20260929022915.2704627-1-rkannoth@marvell.com>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 07:59:13 +0530
Ratheesh Kannoth <rkannoth@marvell.com> wrote:

> This series adds hardware offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2/cn10k PF and VF RVU
> netdevices. Each non-QoS transmit queue is shaped by programming MDQ CIR/PIR
> on the NIX TX scheduler. When bandwidth offload is active, the driver
> allocates one SMQ per queue, parents every MDQ under TL4[0], and maps each
> traffic class min/max rate to the queue(s) in that class.
> 
> The NIX TX scheduler hierarchy cannot be reprogrammed live today, so
> mqprio add, replace, delete, and failed-replace rollback rebuild it by
> bouncing the netdev through ndo_stop()/ndo_open(). That intentionally
> drops in-flight traffic on each change. otx2_mqprio_restart_netdev() clears
> __LINK_STATE_START before ndo_stop() and does not call
> dev_deactivate()/dev_activate(); carrier and TX queues are restored after
> ndo_open() via the normal link-event path when the link is up. Cache the
> active rates and restore MDQ shapers from otx2_mqprio_up() during ndo_open();
> fail closed if restoration fails, leaving ndo_open() unsuccessful and the
> interface administratively down.
> 
> Track mqprio configuration in mq_offload_snap snapshots (TC layout and
> rates). On tc qdisc replace, stage the new configuration while keeping
> the previous snapshot for rollback: failed setup restores the old
> snapshot via netdev restart when the interface is running, successful
> graft is recorded through TC_ROOT_GRAFT, and teardown of the replaced
> qdisc instance commits the staged snapshot without tearing down the live
> offload.
> 
> Patch 1 converts PF/VF and representor flag access to atomic bitops.
> Patch 2 depends on it for safe OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP
> updates on asynchronous mbox paths and during the mqprio netdev bounce.

Can't you just move those two flags to a separate structure member?
In at least one place the code separately clears one and sets the other.
That makes me think it should a a three-valued state not two bits.

That would save all the expensive locked operations.

David

> 
> The driver rejects offload unless the interface is running and the device
> advertises CIR+PIR support. PF and VF RVU netdevices share the same TC
> offload path via ndo_setup_tc / otx2_open(); SDP representors are not
> supported. Per-TC rates are rejected when a traffic class spans more than
> one queue. Concurrent PFC, XDP, SDP rep, or HTB use is blocked, and ethtool
> channel count changes are blocked while mqprio bandwidth offload is active.
> 
> Ratheesh Kannoth (2):
>   octeontx2: use atomic bitops for PF/VF and rep flags
>   octeontx2: add mqprio bandwidth offload for NIX TX schedulers
> 
>  .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |   8 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 154 +++-
>  .../ethernet/marvell/octeontx2/nic/otx2_common.h   | 107 ++-
>  .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |   6 +
>  .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   2 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  29 +-
>  .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  34 +-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  95 ++-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 838 ++++++++++++++++++++-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  16 +-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  10 +-
>  .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |   4 +-
>  drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |  11 +
>  .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |   4 +-
>  drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  32 +-
>  drivers/net/ethernet/marvell/octeontx2/nic/rep.h   |   3 +-
>  16 files changed, 1203 insertions(+), 150 deletions(-)
> 
> ---
> 
> v17 -> v18: Addressed sashiko comments on v17.
> - Commit staged mqprio replace snapshots when TC_ROOT_GRAFT is skipped
>   because hw-tc-offload is off in netdev->features (!tc_can_offload()),
>   instead of rolling back a replace that actually succeeded.
> - Keep NETIF_F_HW_TC in netdev->hw_features only (PF and VF); gate mqprio
>   setup/teardown on otx2_tc_can_offload() so hw-tc-offload stays opt-in via
>   ethtool -K and flower/matchall are not pushed to ndo_setup_tc by default.
> - Split TC shutdown around netdev unregister: cancel mqprio deferred work and
>   free mqprio snapshots before unregister_netdev(), but destroy the TC flower
>   flow list only after unregister so clsact teardown can still run
>   otx2_tc_del_flow() and free MCAM/mcast/policer state.
> - Reject ethtool -L TX queue reduction while mqprio offload snapshots remain,
>   so a later replace rollback cannot restore stale per-queue rates past the
>   current queue count.
> - Clarify mqprio shaper and netdev-restart comments: ndo_open() may restore
>   cached MDQ shapers via otx2_mqprio_up() before setup clears them, and a
>   failed mqprio restart relies on OTX2_FLAG_INTF_DOWN so otx2_stop() returns
>   early through netif_close(), not on skipping ndo_stop().
> 	https://lore.kernel.org/netdev/20260923032217.1732753-1-rkannoth@marvell.com/
> 
> v16 -> v17: Addressed sashiko comments on v16.
> - Replace the per-bit otx2_sync_flags_from_rep() loop with a masked
>   READ_ONCE/WRITE_ONCE publish of OTX2_REP_SYNC_FLAGS_MASK so lockless NAPI
>   readers never observe torn PF/representor flag combinations.
> - Evaluate mqprio.rate_limit and old_mq_snap inside rtnl_lock in
>   otx2_mqprio_netdev_tc_work() so a concurrent qdisc delete cannot leave
>   stale netdev TC mappings after offload teardown.
> - Advertise NETIF_F_HW_TC in netdev->features (PF and VF) when TC flower
>   offload is supported, so tc_can_offload() succeeds without ethtool -K
>   hw-tc-offload on; move otx2_init_tc() before register_netdev() and fix
>   probe/remove teardown ordering.
> - Reject mqprio add when a software mqprio root is already installed
>   (otx2_mqprio_keep_netdev_tc()) and defer netdev TC restore from a new
>   fail_validate path on failed replace validation before any hardware
>   change.
> - Fix otx2_mqprio_max_rate_bytes_ps() to cap against the NIX TLX maximum
>   rate instead of the burst-bucket size; use the 65536 byte HTB default
>   burst when programming MDQ shapers; guard otx2_get_smq_idx() when
>   txschq_cnt[NIX_TXSCH_LVL_SMQ] is zero after otx2_txschq_stop().
> - Rename patch 2 to octeontx2: (driver-wide PF/VF offload, not PF-only).
> 	https://lore.kernel.org/netdev/20260918015906.1255204-1-rkannoth@marvell.com/
> 
> v15 -> v16: Addressed sashiko comments on v15 and aligned documentation with code.
> - Sync representor flags through OTX2_FLAG_MAX in otx2_sync_flags_from_rep()
>   instead of hard-coding OTX2_REP_VF_INITIALIZED as the loop bound.
> - Drop the rvu_nix.c is_valid_txschq() ratelimited error print from the mqprio
>   patch; remove the misplaced atomic-bitops and AF-debug paragraphs from the
>   mqprio commit message (they belong to patch 1 or are out of scope).
> - Extend mq_offload_snap to record prio_tc_map[] and mqprio rate flags; restore
>   the full netdev TC layout (num_tc, queue ranges, and priority map) via
>   otx2_mqprio_apply_snap_netdev() on rollback paths.
> - Defer netdev TC restore on failed replace (otx2_mqprio_netdev_tc_work) so
>   rollback survives mqprio_destroy() clearing dev->num_tc after setup errors
>   once the core unwinds the failed qdisc instance.
> - Stop calling dev_deactivate()/dev_activate() from otx2_mqprio_restart_netdev();
>   bounce the interface with ndo_stop()/ndo_open() only and restore carrier
>   through the normal link-event path after ndo_open(), avoiding qdisc
>   reentrancy during tc replace graft.
> - Preserve netdev TC mappings when tearing down an offloaded instance that is
>   replaced by a software mqprio graft (otx2_mqprio_keep_netdev_tc()) instead
>   of always calling netdev_set_num_tc(0) and breaking the live replacement.
> - Return an error from otx2_mqprio_down() when clearing hardware shapers fails
>   and keep offload software state, instead of v15's behaviour of clearing
>   rate_limit while stale MDQ limits may remain programmed.
> - Rebuild the TX scheduler via netdev restart in otx2_mqprio_restore_old() on
>   a running interface after failed-replace rollback so partially applied MDQ
>   shapers are not left running with mismatched software state.
> - Clear txschq_cnt[] in otx2_txschq_stop() after freeing scheduler nodes so
>   post-stop shaper mailbox operations do not consult stale counts.
> - Document fail-closed ndo_open() when otx2_mqprio_up() cannot restore shapers,
>   and that PF/VF RVU netdevices share the ndo_setup_tc / otx2_open() offload
>   path (SDP representors remain unsupported); downgrade the mqprio restart
>   notice to netdev_dbg().
> 	https://lore.kernel.org/netdev/20260911105521.689565-1-rkannoth@marvell.com/
> 
> v14 -> v15: Addressed sashiko comments.
> - Split atomic PF/VF and representor flag access into a preparatory patch
>   so mqprio netdev-restart and mbox paths can update OTX2_FLAG_INTF_DOWN
>   and OTX2_FLAG_PORT_UP without data races on the shared flags word.
> - Clear mqprio software state when hardware shaper teardown fails, warn,
>   and still bounce the netdev on delete so offload does not remain stuck
>   active after a mailbox error.
> 	https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marvell.com/
> 
> v13 -> v14: Addressed sashiko comments.
> - Use atomic set_bit()/clear_bit() for OTX2_FLAG_INTF_DOWN and
>   OTX2_FLAG_PORT_UP updates on netdev-restart and mbox paths.
> - Block concurrent mqprio bandwidth offload and HTB shaping.
> - Fail ndo_open() if otx2_mqprio_up() cannot restore MDQ shapers.
> - Rebuild the TX scheduler via netdev restart in otx2_mqprio_restore_old()
>   when rolling back a failed replace on a running interface.
> - Return an error from otx2_mqprio_down() if clearing hardware shapers
>   fails instead of clearing software state anyway.
> 	https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marvell.com/
> 
> v12 -> v13: Addressed sashiko comments.
> 	https://sashiko.dev/#/patchset/20260903023324.3078284-1-rkannoth%40marvell.com
> 
> v11 -> v12: Addressed sashiko comments.
> 	https://sashiko.dev/#/patchset/20260902015500.2985371-1-rkannoth%40marvell.com
> v10 -> v11: Addressed sashiko comments.
> 	https://sashiko.dev/#/patchset/20260831131014.2639581-1-rkannoth%40marvell.com
> 
> v9 -> v10: Addressed sashiko/jacub comments.
> 	https://sashiko.dev/#/message/20260817032747.1765883-1-rkannoth%40marvell.com
> 
> v8 -> v9: Addressed Sashiko comments
> 	https://lore.kernel.org/netdev/aoJ6FhtWue0FHDQV@rkannoth-OptiPlex-7090/
> v7 -> v8: Addressed Sashiko comments
> 	https://sashiko.dev/#/patchset/20260811085050.3212280-1-rkannoth%40marvell.com
> v6 -> v7: Addressed Sashiko comments
> 	https://sashiko.dev/#/message/20260810034738.1786029-1-rkannoth%40marvell.com
> v5 -> v6: Addressed Sashiko comments
> 	https://lore.kernel.org/netdev/20260806095434.1144397-1-rkannoth@marvell.com/
> v4 -> v5: Addressed sashiko comments
> 	https://sashiko.dev/#/patchset/20260803042724.3380209-1-rkannoth%40marvell.com
> v3 -> v4: Addressed sashiko comments
> 	https://lore.kernel.org/netdev/20260729105139.2302908-1-rkannoth@marvell.com/
> v2 -> v3: Addressed sashiko comments
> 	https://lore.kernel.org/netdev/amnYX866mYx02cBe@rkannoth-OptiPlex-7090/T/#m67310cbec48b21c7720858ab3a1ea083a0f8dc10
> v1 -> v2: Addressed sashiko comments
> 	https://lore.kernel.org/netdev/20260724075010.2665758-1-rkannoth@marvell.com/
> 
> --
> 2.43.0
> 

