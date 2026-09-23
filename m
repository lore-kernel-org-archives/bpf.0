Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54223332EA2;
	Wed, 23 Sep 2026 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133786; cv=none; b=AjUkQMG3GjK01V7y3xP9ejt8efSwJl5PgQeCl8zQ/WKLY2YaGc2Iuyxacz2t+sOI9aMNHfAv1v4hF7SutPkTwg+drBrJP1A3yPe8as/WOIwo2GO+2jChc/eBrPUFiAxCQwofN/Txp5Mna+AF/c6RgLu2tmts052NJmP8hFbB8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133786; c=relaxed/simple;
	bh=KHOvUyxMm6eE5hkbeRZb2vGECOmVCazpqYN1wFSFBSw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IHWTShdLKDamYWI7CrMv/luc4kL8twWRl8gO938Hh6PpwMoXi3//Y+YBXEm7OEpCGdDtGugKAxtCLEsgB24/8iLlvmZWg0iDOqtNM4Ibc9XgPxu7tHGhIgDsE8DUOEwpiXb068JkDk+ZDNruXTJwuYveUgv+RlOh0fcQYBvNEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SwvAM9O5; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SwvAM9O5"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIJdfO008753;
	Tue, 22 Sep 2026 20:22:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=EBSunQv0DHMxR6CfxyBQ0y/
	ba2Bu8TzvlOlfB321dM8=; b=SwvAM9O59C6v0lE/3V2BzFRXcxamT5bT6jhZwFI
	SS/poNgNRU0f12rbc9yQ3RMEdD3M1vRA51WJ/iuXyvBKDZC4b25oo+ubmF1L8yHy
	JXd2fcBWp6WigqXk/hqOtoXBr/apoyPHiK56nK5hwrFN0Fa7wS9Dl01o20BitgRq
	2IszKXltbBoMifR73HGFV7IQFBiKGPWTfyJjOUmQWYpQdWqgOu5jkgWBswq2uZiK
	eWIbIzUSwvNjwfNDIKuN72TbYc4Dm9xu4wKkiGhzwN1oobeQb3h/Gv9kOK8JrYDQ
	ezk94zTYZU6fdhL+edsSRweKytAlwDHJtg0ZLO0bmYinJxw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4guvwu3ctf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 20:22:34 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 20:22:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 20:22:34 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 693BC3F7043;
	Tue, 22 Sep 2026 20:22:29 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v17 net-next 0/2] octeontx2: mqprio bandwidth offload for NIX TX schedulers
Date: Wed, 23 Sep 2026 08:52:14 +0530
Message-ID: <20260923032217.1732753-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nn4fmZ1EKudiUSEevaHrKq9LJFRXGyl0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxMiBTYWx0ZWRfXxw7ksZ3mYiyX
 NXDENfvHN9sbIgqxBra/eyQBka02Vm7rhybRD+WxBmda1n2z/x5mUV2kW5lRA0rm6Bf6gx3stnw
 J7lMb8sXArjjcf/nyImjzATG4ZuGiA0=
X-Authority-Analysis: v=2.4 cv=b/UncdGx c=1 sm=1 tr=0 ts=6ab345fa cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=9QCjdkXzRtl80XweWQoA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxMiBTYWx0ZWRfX4bbE1C4Ji1w6
 uGIL33AIkp4W2gTDpLNnHT5UGOwcUA1cun1q1ltDpZ92pDIOfNOrnFA/YlUBgCk1GR1g1FjBTub
 cnop1JsmvPjnxZsKk5Kyniu9olJkYeRzze+IYi4qDw5e2Nvt1JdrjyD3VDhWsLMQU5+vTwtNNRs
 HE6//Mks/yITwiCN8KGyTuQJdFGERQHgI02TfsKTA/qPdOVITPB3Xs0n5uZF0t8aWVwrbiTfK/i
 Qh25se118E+poZb/zk0wVuvw0BFNLFwgbHJSNmzxb9S1MDigCB9xG4zRiTjahuY8loWN5ziu2Xr
 5BmbpZWbWVX7bCatizoUY/ZJiYoFV0PbhcxcGoPjseQWnzsgPkZZcZwVZhFoR/t7BtjXktD/G5n
 7xX6rWpYh0yIFv+ZcLJIxNlVFHFAmtovFTniyTeP2rq4zw0FMeNwSmgoWxIo1JPwMeytl3PRVLP
 zuYX/EMCuVbSkVFLZqQ==
X-Proofpoint-GUID: nn4fmZ1EKudiUSEevaHrKq9LJFRXGyl0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01

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
  octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

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
