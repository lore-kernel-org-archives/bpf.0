Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B33B7749;
	Tue,  6 Oct 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791279885; cv=none; b=Qi8utk+Tbews51k/9C9L7H3BbfnvLRZ/qgjuze5uK3IbgqwgsfOdn4+uya647K5x+zXoifYifswfPbDm47xhe09ArcFviZKfsrKRVi8yCN2kumUUbWTjJNq4h8WvoHoPxo8LLB2sA86ivw0Ayn15ujl6rUp/6Vq+zcolcVKOLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791279885; c=relaxed/simple;
	bh=s1XN43Qdq0vfhCTPJIkE7ukE415vgVTGv3RtzO0n8Uk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WJEhTP2WjIoCfDw1hR0X8SL1FDq82lk2jj6oF+OwRP7yX83AvlI/U27AG6bEne5issulLsh7m4X2V0sktBMZLXGq+VgX30vhLWdTGmxSORA9ZXfOnphxh3xOpe75gWwGDKP6dahKjucCb21AczAcp4ciKHrFInnzCJOiBmYIiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MXj/0EQ3; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MXj/0EQ3"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6969KVsk2336332;
	Tue, 6 Oct 2026 02:44:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ZudzhDqsn879cUqXo3kZwFs
	fQF+6jZvsti2Np4v+ZU8=; b=MXj/0EQ3Ze8Vl1Fd0GhS4Fgus+Wrwsw4gLLr2Mo
	0LEP/G3I4OZt5asfLqelM27vYP36jqoxll60getnLgxcNojFE6sLBJIqdguFCwN7
	9ODPy7es52Wo9eN4C3pcR5jPVYK/7Q4fkayrGHh+2yg54Si8YSzJCGIoq3jbmkRt
	5BmMiAulcuxa4hF43K3Zp9Nai49T0+oVhFYeaRSDhm9HVVjQLcDCUenbH1AhbQhI
	/anVtUwGvfNaoCnV6ROviOPFmTOweVkKo/pvL4mr2wmz9NgAvBdH1KOwiaMxDrLS
	P3HF6IBGlrPyTVhCcBfDKtWtim3xhUUTVMJWCTaWmENfTGg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4h4x94r3b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 02:44:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 6 Oct 2026 02:44:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 6 Oct 2026 02:44:15 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CB28B3F70A3;
	Tue,  6 Oct 2026 02:44:08 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@kernel.org>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v19 net-next 0/2] octeontx2: mqprio bandwidth offload for NIX TX schedulers
Date: Tue, 6 Oct 2026 15:13:55 +0530
Message-ID: <20261006094357.840823-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DrjDa2/+ c=1 sm=1 tr=0 ts=6ac4c2f0 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=34kHFVwJR3ABkaf1n5AA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: pk4F8-OrXoQ22ZF4SwBbzquxlpnDedlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfXwSbDmOeWRwbe
 0NQ2ftCJEsYOizw9U3mbt7jb9n0l8dnJgCSZbR5G9VpLohl9sfgTHLR3JIM7ziD0Ua5/YWx4HHc
 DSU1rGz4yl0WcpDScF+c8bB+wxzNYfSG/PLY/UHmsVGUWWFu8XE6betGVUJGqY7f6zQWbgZjzrW
 4odqbpaVtdbZXjiFCfbuaJaNxvOk1SyKQPDJj3F/SDJoZ7ZSB7l25isJ3BJ7MuyC7NJqh7TpoKT
 L1JR3ppFihsuza/pbPbFG1qDxH1uYP+H9IlzyBf86pWoNuUcpq7B7yzJnBCE3dn5nTCAdkPHRVu
 qJllUb6WgptwVsfxP8B6fhn3tavybhHPPhK93D4S1V2IsNiLzi8cnqoAH4LSrSAuhXlrcLIqs9O
 DLz2kZhZ+XzW+eJzwfSdEwmfK8r1B5InOIT1hK1uzA2v8qBcHiQ0TYjZAVTvXR/SHk4ru37RFPU
 t8z0wqbV5iyyL/zUC8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAzOCBTYWx0ZWRfX+02hCey3JjT0
 ha5t7Sy14tVGPPTyNSDcqIfo9af1gQvCY8apL1LgTf7I6RVDJcCMTP/JtmEjypUEslpPLCJtWA0
 leplRmbUpI9+5JrT2SPaBIbhKRTCcEI=
X-Proofpoint-GUID: pk4F8-OrXoQ22ZF4SwBbzquxlpnDedlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_02,2026-10-05_01,2025-10-01_01

This series adds hardware offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2/cn10k PF and VF RVU
netdevices. Each non-QoS transmit queue is shaped by programming MDQ CIR/PIR
on the NIX TX scheduler. When bandwidth offload is active, the driver
allocates one SMQ per queue, parents every MDQ under TL4[0], and maps each
traffic class min/max rate to the queue(s) in that class.

The NIX TX scheduler hierarchy cannot be reprogrammed live today, so
mqprio add, replace, delete, and failed-replace rollback rebuild it by
bouncing the netdev through ndo_stop()/ndo_open(). That intentionally
drops in-flight traffic on each change. otx2_mqprio_restart_netdev() clears
__LINK_STATE_START before ndo_stop() and does not call
dev_deactivate()/dev_activate(); carrier and TX queues are restored after
ndo_open() via the normal link-event path when the link is up. Cache the
active rates and restore MDQ shapers from otx2_mqprio_up() during ndo_open();
fail closed if restoration fails, leaving ndo_open() unsuccessful and the
interface administratively down.

Track mqprio configuration in mq_offload_snap snapshots (TC layout and
rates). On tc qdisc replace, stage the new configuration while keeping
the previous snapshot for rollback: failed setup restores the old
snapshot via netdev restart when the interface is running, successful
graft is recorded through TC_ROOT_GRAFT, and teardown of the replaced
qdisc instance commits the staged snapshot without tearing down the live
offload.

Patch 1 converts PF/VF and representor flag access to atomic bitops.
Patch 2 depends on it for safe OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP
updates on asynchronous mbox paths and during the mqprio netdev bounce.

The driver rejects offload unless the interface is running and the device
advertises CIR+PIR support. PF and VF RVU netdevices share the same TC
offload path via ndo_setup_tc / otx2_open(); SDP representors are not
supported. Per-TC rates are rejected when a traffic class spans more than
one queue. Concurrent PFC, XDP, SDP rep, or HTB use is blocked, and ethtool
channel count changes are blocked while mqprio bandwidth offload is active.

Ratheesh Kannoth (2):
  octeontx2: use atomic bitops for PF/VF and rep flags
  octeontx2: add mqprio bandwidth offload for NIX TX schedulers

 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |   8 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 154 +++-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   | 107 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |   6 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  29 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  34 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  95 ++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 838 ++++++++++++++++++++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  16 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  10 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |  11 +
 .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  32 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h   |   3 +-
 16 files changed, 1203 insertions(+), 150 deletions(-)

---

v18 -> v19: Addressed sashiko and review nits on v18.
- Gate mqprio netdev_tc_work with defer_tc_work: set the flag before
  cancel_work_sync() in otx2_shutdown_tc_mqprio() and skip scheduling or
  running the deferred TC restore work once teardown starts (Sashiko #1).
= Address Jakub comment.
- Clarify the otx2_mqprio_restart_netdev() comment on failed ndo_open():
  __LINK_STATE_START stays clear until open succeeds, so netif_running() is
  false on that path
	https://lore.kernel.org/netdev/20260929022915.2704627-1-rkannoth@marvell.com/

v17 -> v18: Addressed sashiko comments on v17.
- Commit staged mqprio replace snapshots when TC_ROOT_GRAFT is skipped
  because hw-tc-offload is off in netdev->features (!tc_can_offload()),
  instead of rolling back a replace that actually succeeded.
- Keep NETIF_F_HW_TC in netdev->hw_features only (PF and VF); gate mqprio
  setup/teardown on otx2_tc_can_offload() so hw-tc-offload stays opt-in via
  ethtool -K and flower/matchall are not pushed to ndo_setup_tc by default.
- Split TC shutdown around netdev unregister: cancel mqprio deferred work and
  free mqprio snapshots before unregister_netdev(), but destroy the TC flower
  flow list only after unregister so clsact teardown can still run
  otx2_tc_del_flow() and free MCAM/mcast/policer state.
- Reject ethtool -L TX queue reduction while mqprio offload snapshots remain,
  so a later replace rollback cannot restore stale per-queue rates past the
  current queue count.
- Clarify mqprio shaper and netdev-restart comments: ndo_open() may restore
  cached MDQ shapers via otx2_mqprio_up() before setup clears them, and a
  failed mqprio restart relies on OTX2_FLAG_INTF_DOWN so otx2_stop() returns
  early through netif_close(), not on skipping ndo_stop().
	https://lore.kernel.org/netdev/20260923032217.1732753-1-rkannoth@marvell.com/

v16 -> v17: Addressed sashiko comments on v16.
- Replace the per-bit otx2_sync_flags_from_rep() loop with a masked
  READ_ONCE/WRITE_ONCE publish of OTX2_REP_SYNC_FLAGS_MASK so lockless NAPI
  readers never observe torn PF/representor flag combinations.
- Evaluate mqprio.rate_limit and old_mq_snap inside rtnl_lock in
  otx2_mqprio_netdev_tc_work() so a concurrent qdisc delete cannot leave
  stale netdev TC mappings after offload teardown.
- Advertise NETIF_F_HW_TC in netdev->features (PF and VF) when TC flower
  offload is supported, so tc_can_offload() succeeds without ethtool -K
  hw-tc-offload on; move otx2_init_tc() before register_netdev() and fix
  probe/remove teardown ordering.
- Reject mqprio add when a software mqprio root is already installed
  (otx2_mqprio_keep_netdev_tc()) and defer netdev TC restore from a new
  fail_validate path on failed replace validation before any hardware
  change.
- Fix otx2_mqprio_max_rate_bytes_ps() to cap against the NIX TLX maximum
  rate instead of the burst-bucket size; use the 65536 byte HTB default
  burst when programming MDQ shapers; guard otx2_get_smq_idx() when
  txschq_cnt[NIX_TXSCH_LVL_SMQ] is zero after otx2_txschq_stop().
- Rename patch 2 to octeontx2: (driver-wide PF/VF offload, not PF-only).
	https://lore.kernel.org/netdev/20260918015906.1255204-1-rkannoth@marvell.com/

v15 -> v16: Addressed sashiko comments on v15 and aligned documentation with code.
- Sync representor flags through OTX2_FLAG_MAX in otx2_sync_flags_from_rep()
  instead of hard-coding OTX2_REP_VF_INITIALIZED as the loop bound.
- Drop the rvu_nix.c is_valid_txschq() ratelimited error print from the mqprio
  patch; remove the misplaced atomic-bitops and AF-debug paragraphs from the
  mqprio commit message (they belong to patch 1 or are out of scope).
- Extend mq_offload_snap to record prio_tc_map[] and mqprio rate flags; restore
  the full netdev TC layout (num_tc, queue ranges, and priority map) via
  otx2_mqprio_apply_snap_netdev() on rollback paths.
- Defer netdev TC restore on failed replace (otx2_mqprio_netdev_tc_work) so
  rollback survives mqprio_destroy() clearing dev->num_tc after setup errors
  once the core unwinds the failed qdisc instance.
- Stop calling dev_deactivate()/dev_activate() from otx2_mqprio_restart_netdev();
  bounce the interface with ndo_stop()/ndo_open() only and restore carrier
  through the normal link-event path after ndo_open(), avoiding qdisc
  reentrancy during tc replace graft.
- Preserve netdev TC mappings when tearing down an offloaded instance that is
  replaced by a software mqprio graft (otx2_mqprio_keep_netdev_tc()) instead
  of always calling netdev_set_num_tc(0) and breaking the live replacement.
- Return an error from otx2_mqprio_down() when clearing hardware shapers fails
  and keep offload software state, instead of v15's behaviour of clearing
  rate_limit while stale MDQ limits may remain programmed.
- Rebuild the TX scheduler via netdev restart in otx2_mqprio_restore_old() on
  a running interface after failed-replace rollback so partially applied MDQ
  shapers are not left running with mismatched software state.
- Clear txschq_cnt[] in otx2_txschq_stop() after freeing scheduler nodes so
  post-stop shaper mailbox operations do not consult stale counts.
- Document fail-closed ndo_open() when otx2_mqprio_up() cannot restore shapers,
  and that PF/VF RVU netdevices share the ndo_setup_tc / otx2_open() offload
  path (SDP representors remain unsupported); downgrade the mqprio restart
  notice to netdev_dbg().
	https://lore.kernel.org/netdev/20260911105521.689565-1-rkannoth@marvell.com/

v14 -> v15: Addressed sashiko comments.
- Split atomic PF/VF and representor flag access into a preparatory patch
  so mqprio netdev-restart and mbox paths can update OTX2_FLAG_INTF_DOWN
  and OTX2_FLAG_PORT_UP without data races on the shared flags word.
- Clear mqprio software state when hardware shaper teardown fails, warn,
  and still bounce the netdev on delete so offload does not remain stuck
  active after a mailbox error.
	https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marvell.com/

v13 -> v14: Addressed sashiko comments.
- Use atomic set_bit()/clear_bit() for OTX2_FLAG_INTF_DOWN and
  OTX2_FLAG_PORT_UP updates on netdev-restart and mbox paths.
- Block concurrent mqprio bandwidth offload and HTB shaping.
- Fail ndo_open() if otx2_mqprio_up() cannot restore MDQ shapers.
- Rebuild the TX scheduler via netdev restart in otx2_mqprio_restore_old()
  when rolling back a failed replace on a running interface.
- Return an error from otx2_mqprio_down() if clearing hardware shapers
  fails instead of clearing software state anyway.
	https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marvell.com/

v12 -> v13: Addressed sashiko comments.
	https://sashiko.dev/#/patchset/20260903023324.3078284-1-rkannoth%40marvell.com

v11 -> v12: Addressed sashiko comments.
	https://sashiko.dev/#/patchset/20260902015500.2985371-1-rkannoth%40marvell.com
v10 -> v11: Addressed sashiko comments.
	https://sashiko.dev/#/patchset/20260831131014.2639581-1-rkannoth%40marvell.com

v9 -> v10: Addressed sashiko/jacub comments.
	https://sashiko.dev/#/message/20260817032747.1765883-1-rkannoth%40marvell.com

v8 -> v9: Addressed Sashiko comments
	https://lore.kernel.org/netdev/aoJ6FhtWue0FHDQV@rkannoth-OptiPlex-7090/
v7 -> v8: Addressed Sashiko comments
	https://sashiko.dev/#/patchset/20260811085050.3212280-1-rkannoth%40marvell.com
v6 -> v7: Addressed Sashiko comments
	https://sashiko.dev/#/message/20260810034738.1786029-1-rkannoth%40marvell.com
v5 -> v6: Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260806095434.1144397-1-rkannoth@marvell.com/
v4 -> v5: Addressed sashiko comments
	https://sashiko.dev/#/patchset/20260803042724.3380209-1-rkannoth%40marvell.com
v3 -> v4: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260729105139.2302908-1-rkannoth@marvell.com/
v2 -> v3: Addressed sashiko comments
	https://lore.kernel.org/netdev/amnYX866mYx02cBe@rkannoth-OptiPlex-7090/T/#m67310cbec48b21c7720858ab3a1ea083a0f8dc10
v1 -> v2: Addressed sashiko comments
	https://lore.kernel.org/netdev/20260724075010.2665758-1-rkannoth@marvell.com/

--
2.43.0
