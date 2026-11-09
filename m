Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794195178;
	b=ZwGPtjpdD3RiL483vQ/5FgnyuhFGL/O0gTII7NTOZxnGP9Uoi4WJQo5dYquqYEirLvXV
	 +Yd96O/hz1eZxHW9RhBYSUDCaNkwLUxKsSkeWmMVs4obneKBobzLfLYwlh6fLvkqwarhW
	 O096N4WwoETsQQtuJgwG/vErzX7xnco8ul5y0xGf+92es1WziQXVOBlKAaYUrxfp4U3iy
	 An+RsiP3iWVHrywEwW/H4D+onyPPx0mu+6PqeCBrzHJhu63HgIPee5HjC5iY0wPjZHRCU
	 qdgpOk7iAKJeTuk6ZV0DtbgnET78jJmrFRtMrXjLR+vXazGMSZkGbbs10gemuTwwI3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794195178;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version;
	bh=zOMbTruz7AdjxBpgRfO0FeQq6w3i/Lg0lFT7TOfzRv0=;
	b=YuapF+6Tla4lYhJG82XMZyy8wu1NDYKCasvJAMOK3D0C3Gicg8ezaOU/UqZOGyMK2ENK
	 msLAeOTO2of8JveyLGSAZGzvIhYsxl15roVg8VOd5SoVlu90TxEdQqlNEM8/KHPQgpTPa
	 NTEvP4HNODXItglsp/o0JjpfzCgW+YL6xcZ2iwQJeVnzOAV2MdHz946xlo/CBwgh8HMsV
	 n9MXKnnRgWhhjLX4GWoQXSCZ6/h+xHD9q6lXXdNTMFWLGxYjZqdFAJYfktBFrGItNJJXX
	 UVOt6C4SZAKHBGD0llvW8KWnU4mCzuPTTs0N/+ELyfPehPeb1hbQ5SnQJ3D9tzYio3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=marvell.com;
	spf=pass smtp.mailfrom=marvell.com;
	dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=lRtxrAoy;
	arc=none smtp.remote-ip=67.231.156.173
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF28E606A31C;
	Mon,  9 Nov 2026 03:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF28E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=lRtxrAoy
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JD0i3377793;
	Sun, 8 Nov 2026 19:32:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=zOMbTruz7AdjxBpgRfO0FeQ
	q6w3i/Lg0lFT7TOfzRv0=; b=lRtxrAoyoAPF1pth/x9a12GQJgYWa53AEniSOG3
	WgiODf9RkNB3QKsCKKaofj4lpmtkXAqUGTe+xdlRNm8/+oPAqQiwyAOm50CxiGcs
	CxxIvi9NZeKo4qPyR7Uqye7TPD6djHT9JGnYPUgTAi+tYuoBRLNameSyhx5pskcI
	PBw/uU5M45pnsLY9l+X6fUGHMlj9A1HcEoaEco5RDi6khfAzxs4Fgc5ecZKd0nPq
	OyZYxlkQVEqIdJ69UgbnpkYoqi+agxU5683T38oxIH9i7kQetbBR3b4qFVn8hGRQ
	qqDCTil45sP6Dc3ygI5HPLcnDz99wW+Gc1dq00Lz0E+Rimg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ht4cnmjq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Nov 2026 19:32:16 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 8 Nov 2026 19:32:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 8 Nov 2026 19:32:15 -0800
Received: from localhost.localdomain (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 634693F7094;
	Sun,  8 Nov 2026 19:32:11 -0800 (PST)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@kernel.org>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v21 net-next 0/2] octeontx2: mqprio bandwidth offload for NIX TX schedulers
Date: Mon, 9 Nov 2026 09:01:51 +0530
Message-ID: <20261109033154.2161803-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
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
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HpDjiETS c=1 sm=1 tr=0 ts=6af13ec0 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=WiP3EOUlVtzYxeA2Qx8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX80mSDAIeDibu
 supvVPDNg15sRAYZNvHuH8jtQpv2zG3//U6qNNBmNBtG50hwV2ena9CvuszDrKgmr3+1Foi0ULQ
 2CzPK7Jv1t6am81FT7e2Lg2hgpQv0Rg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX6hIIC5Ibl2so
 ImR5wwV/lqmL5Lz4aBakH1bHeqoJeOLDAAxkat4vQ1maEOIuPy1vn51aivKdBNEyzocpfDNrT0X
 VtfIuK2e6HUinps5r5F7ACl4yuAvOaEabe8tRG3l5rY5Tgw0XzgaJCc9ZV8ygcdR74uKNMKgTbV
 lYBkl2n9JAuz04M5LAwfYG11rPcYpDQtIz0MVMG6ACj9jTXfKC6TGPL5AI1n3SPLyxXwPWstNgt
 3fjoBM1Au1G/X3ZNH147WETX6z6qo3+8KlMJuZhgsPPX/5wmuJXjEsbtbqJkTsNIo1EtPP6RdEY
 XdvhjhkZRz2lNr1Euqq7siG8RDKUbA5Bei8Z9QPTwGdly2NfsizihiTkau1i9fyUFFpZMW8KYY4
 POp5o/0WzdOj8lkoGuUoyaq+wDzv3/zzsHqmJObcMD9jCqR3dKBAjfKRyYQR7Ok8fw1tavF1PpS
 2sLZjvTwdPBfuwV63bQ==
X-Proofpoint-GUID: t2bK018mjzqEL5oxaFwmSA1HMDPV5PVn
X-Proofpoint-ORIG-GUID: t2bK018mjzqEL5oxaFwmSA1HMDPV5PVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_02,2026-11-06_01,2025-10-01_01

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
v20 -> v21: Resend
	https://lore.kernel.org/netdev/20261014023431.1775238-1-rkannoth@marvell.com/

v19 -> v20: Addressed sashiko and Paolo comments on v19.
- Fix the deferred netdev_tc_work use-after-free on removal: set
  defer_tc_work under rtnl_lock() in otx2_shutdown_tc_mqprio() (the work is
  only queued from ndo_setup_tc() with RTNL held) and run cancel_work_sync()
  after rtnl_unlock(); drop the lockless early check in the work handler.
- Always release mqprio software state in otx2_mqprio_down() when clearing
  the hardware shapers fails (the core cannot veto qdisc teardown); the
  following netdev restart reallocates the TX scheduler and drops any stale
  shaper. The error is still reported to the user.
- Drop the ethtool -L check that rejected TX queue reduction while
  old_mq_snap/cur_mq_snap exist; it blocked channel changes forever after
  an mqprio qdisc was deleted. Channel changes remain blocked while mqprio
  offload is active.
- Warn when tearing down an offloaded mqprio clears the TC layout installed
  by a replacing software taprio root qdisc.
- Say "bringing interface down" in the error printed when ndo_open() fails
  during an mqprio restart, and correct the netif_close()/dev_close()
  comment; drop the "in-flight traffic will be dropped" wording from the
  restart debug message.
	https://lore.kernel.org/netdev/20261006094357.840823-1-rkannoth@marvell.com/

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
