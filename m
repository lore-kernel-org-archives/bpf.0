Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986F41C6A;
	Fri, 11 Sep 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124179; cv=none; b=bSDu+5jw/O5CSYmC3NaJ6UEvqo372jFxBCZUjgHagpih57gp0PC/oQfGPR+6R8m1M8TGfyPtOKhUgeVm27AeVmB6lPTO+ezIphtRn0W3REpZhqZxBjkuQQGrXxvQA7AKlzTiHbHOy5r+MlS8kTHH7/xJ3ynpSbPD4i0spQacoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124179; c=relaxed/simple;
	bh=ccd5XcXKYsL+2AgAx552ENjUdUAjkgwvUd42kOX4FO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NZMOGUkeUEm2Da0D2t+JuUc0C0s9eHyMaVXmXNOB1FKryxgOF6q99RhQRyza28IIMTYnJtfY9wG6QaAgd54BC9R45TdD4N2f/pS3j76+v1uiFzaHcq0Ci6KlfjX1czXlW/jSgVa87HY7rc7Km3F2bLPN1SI4759ZM1W1z2+u0n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MVlliPIj; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MVlliPIj"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAooRq919477;
	Fri, 11 Sep 2026 03:55:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=E3WI/LBj/jyNky1eZ7wi5je
	rXNLJWRyC09VzPWhMjkc=; b=MVlliPIjNWkRvQvyAeIyNiTNMfQAYqKB+X7vKZh
	aIUdxtJyJ2w7RgHCkwBcielxNxIg0DN17KiBhazAsvB82TcLC34QUB5ah6d57XNc
	3j+SU76kG5O0Tpjl1ahKahumxNnqgYxq1Cvs27L64dzk3LcXl24uKpLlToHBctYT
	kXRD0taUYuEqVblRc0j1Qft82KpnuHEB0MVJLT6fuRc6i7QDZBCa5opT0jLCvevc
	9O7la86H0pOwnWxpEVmGprHW3WVXIVKtoSDbQmN0GZ1sYoLUraAiFZPALanWecus
	2T98emxGqpkNJTFmWw+rmDs3Dz3S05U04Qj7yeqp9ucCE6A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gmb958wa5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 03:55:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Sep 2026 03:55:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 11 Sep 2026 03:55:33 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id CDEFD5C68E9;
	Fri, 11 Sep 2026 03:55:28 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v15 net-next 0/2] octeontx2-pf: mqprio bandwidth offload for NIX TX schedulers
Date: Fri, 11 Sep 2026 16:25:19 +0530
Message-ID: <20260911105521.689565-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE1MyBTYWx0ZWRfX7Xg4XLo2wNGX
 VoUqiBIlYu+dP3htDXPfOpg5LLLqePEa4m2+EEwwrpt45pkXQKQXnS3C+DFuRWsa/4M+TkF9+hp
 omuZAyxNpJMoxLT0DSDXhhQCcHrRo7mzszX+evYf8ii1gME9E22nXjmMYxHnvtRfigeMMokRCyx
 45ZVnTfTYfNUGlVCCC2atE6KebcIXmcom9r8Mob5ITx5bbTQE3rzDGVnM8rmMVt1FV5KcmaxJWE
 PKOfdnZIUODwMy179tCOb6Seru6VHmGDkEJXDQc6kzqTj/euyb/1jFHdABLGs/kPhhafbh2OLmK
 gHUtp5m6sNkh7YC5bwvmMP6aZdf0fdrXVFQ4THQfVuy9EQBy9s4YPC3MZTF7xknIYRAnbmoPgEH
 uvMekgR+NQkYrUN3qMGpY9nCHZwiTtf79V/VTnV2tdl54Aff2LjxsJi7RKzc1TTeK/wrBlIPJoM
 Io07kBcDn6erEV0AITw==
X-Proofpoint-GUID: pgYzvEFFVLYfJNq_rI44UHp9euQRnzPR
X-Proofpoint-ORIG-GUID: pgYzvEFFVLYfJNq_rI44UHp9euQRnzPR
X-Authority-Analysis: v=2.4 cv=c6M+0h9l c=1 sm=1 tr=0 ts=6aa3de26 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=c92rfblmAAAA:8
 a=mw16rXp6IqdJ9hzCCQkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE1MyBTYWx0ZWRfX0pqKKSz6MWaq
 KQfGoOO+VCYmjzY3HcTTj/6SjA0hFpqhX35JcUCDxUjXVYeoSN34OsfkjgqMfIPwBSIj2ORl8gM
 Q3IG4gC4Ex7FsTZ86JoQ5iQVjuNsQgg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01

This series adds hardware offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2 PF devices. Each
non-QoS transmit queue is shaped by programming MDQ CIR/PIR on the NIX TX
scheduler. When bandwidth offload is active, the driver allocates one
SMQ per queue, parents every MDQ under TL4[0], and maps each traffic
class min/max rate to the queue(s) in that class.

The NIX TX scheduler hierarchy cannot be reprogrammed live today, so
mqprio add, replace, delete, and failed-replace rollback rebuild it by
bouncing the netdev through ndo_stop()/ndo_open(). That intentionally
drops in-flight traffic on each change. Before ndo_stop(), quiesce the
transmit path with dev_deactivate() so xmit cannot race queue teardown.
After a successful bounce on a running interface, reactivate TX queues
with dev_activate(). Cache the active rates and restore MDQ shapers from
otx2_mqprio_up() during ndo_open(); fail open if restoration fails.

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
advertises CIR+PIR support. Per-TC rates are rejected when a traffic class
spans more than one queue. Concurrent PFC, XDP, SDP rep, or HTB use is
blocked, and ethtool channel count changes are blocked while mqprio
bandwidth offload is active.

Ratheesh Kannoth (2):
  octeontx2: use atomic bitops for PF/VF and rep flags
  octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |   6 +-
 .../ethernet/marvell/octeontx2/nic/cn10k_ipsec.c   |   8 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 154 +++-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   | 100 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    |   6 +
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c  |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |  29 +-
 .../ethernet/marvell/octeontx2/nic/otx2_flows.c    |  34 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  94 +--
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   | 776 ++++++++++++++++++++-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  16 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c   |  10 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_xsk.c  |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |  11 +
 .../net/ethernet/marvell/octeontx2/nic/qos_sq.c    |   4 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.c   |  32 +-
 drivers/net/ethernet/marvell/octeontx2/nic/rep.h   |   3 +-
 17 files changed, 1138 insertions(+), 151 deletions(-)

---

v14 -> v15: Addressed sashiko comments.
- Split atomic PF/VF and representor flag access into a preparatory patch
  so mqprio netdev-restart and mbox paths can update OTX2_FLAG_INTF_DOWN
  and OTX2_FLAG_PORT_UP without data races on the shared flags word.
- Clear mqprio software state when hardware shaper teardown fails, warn,
  and still bounce the netdev on delete so offload does not remain stuck
  active after a mailbox error.
	https://lore.kernel.org/netdev/20260904031553.3196916-1-rkannoth@marvell.com/

v13 -> v14: Addressed sashiko comments.
- Quiesce TX with dev_deactivate() before ndo_stop() and dev_activate()
  after ndo_open() in otx2_mqprio_restart_netdev() to avoid xmit racing
  queue teardown.
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
