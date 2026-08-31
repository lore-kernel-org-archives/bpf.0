Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56D3314A1;
	Mon, 31 Aug 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181867; cv=none; b=fLJLlwuLQNsd/qe3gJsvpYJrRe3Z2ODTijbWDVe8DZbQvW/d3Kw5EGJmg856X+5mJstMzeZzAGp+gEq79rzquDx90R0nMUJiSl+5RyHCgTWyePYPdVRQxdP3hTWvJpLpdexnJybag9cX1AaXxLSRKMY1zojCF/uX1Tj0bI7uwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181867; c=relaxed/simple;
	bh=L263YCRQbRJuwPI85uN2CwZGOEKPOQYE86PpU/uWoG4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l8XeLi+55LfZHqhOZdAjmMpSPMZgJDYUkASn0RajxdN2sbbKaGtf8Kx9nFCfY6LJwGJSmcPgbu6KxepZpld5FhYNGXxHDAaC4U32/d7bZvHiKovtjs3+iDAonfemA2GefP4fLcBUKCguDaH7RWqf0l4/bHQ91YZGdIwU47WOcZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MQ3Sy/bG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MQ3Sy/bG"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBBjNY536782;
	Mon, 31 Aug 2026 06:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=XbQdqAX54r/8rX0BrtKTbsz
	NuH2BR4o+T1l2B2ynFo0=; b=MQ3Sy/bGkANYP1+TrJF9tSow4tXJ0CXyvElFS8I
	VYRtQq0ET0PC8RNZKcGlgCZqFNXXWW2+tiuJUgBc7XxlXqU8sn3bufYoo/uk/pHZ
	Mt/y/0ARLvh3T6b4ykLaJsYBLQpwpzpSzK5gv+FPa73vOkzv2Y8f5W6elWd+AA25
	K2Gx+m2ayQdTgPGcI0DJV7biWjZ4naqRLk9dOl/0gDCuJm3VdD7s/1ZBd3NbZBZN
	CWycQaFiw14en6AUbg/GGGHc3e9MxHfToTvZsJJMK4dRFrhGKf6NOfOXytEqSnPn
	plWRjCK7PKbG3s6pH7CV+5sjS8mb02KOu2JY6MB5+1DigDg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gckp8jep7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:10:32 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:10:31 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:10:31 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6329B3F7089;
	Mon, 31 Aug 2026 06:10:26 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <edumazet@google.com>, <hawk@kernel.org>,
        <horms@kernel.org>, <jhs@mojatatu.com>, <jiri@resnulli.us>,
        <john.fastabend@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>,
        Ratheesh Kannoth
	<rkannoth@marvell.com>
Subject: [PATCH v10 net-next 0/2] octeontx2-pf: mqprio bandwidth offload for NIX TX schedulers
Date: Mon, 31 Aug 2026 18:40:11 +0530
Message-ID: <20260831131014.2639581-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNCBTYWx0ZWRfX9BJdfqNMBfTe
 sW4UXE5MafOldMj/QfirMsJgtppHuE1xR4IjOqtBDOfpzswL0Twj4fPlg2t6k3alujW/CdolTzg
 JdH/b51cf2ymOxNoAxL7ArVPg+K+A7cgQ9GPsjF7ZkBm9Xr9YKDac33+TOYEA+9U2LhtoTBxD2k
 rghG4srzqMeXKfZM/xXbmyIHEN9vCctfxxYX5UwP3Yypqluwai++Pl4yYQqfx2ctyywfhVKu8T/
 dv9HZRNAcs6DQKFhiDTqegMgrBqlS9T1IJ4aTCLtPwJFlQpEXF0AbI6m2IhWhkUccuaAtnFQrtE
 8YUIijmAFx9to3r9djtXk+nW2JEIYv4dQMC8xQ/dESoYLiuKI207Dwh+yJ3E9qM/vVkrksZ4oQS
 3eY/Jz5nl0izYY8UN8altJWyyDdTqlWHqC+MLcdlrTfBZU11e8G/oP22afIVK55t2lMN4ShlSmc
 wX8ESjJgyHEAHuyZZmQ==
X-Proofpoint-GUID: JP7GND6UNhSNZWUfISyE5TXLaT5uGLmw
X-Proofpoint-ORIG-GUID: JP7GND6UNhSNZWUfISyE5TXLaT5uGLmw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNCBTYWx0ZWRfX3NliO13DpWmu
 z4VPERy2PcTZnPUCAC4uEmISxi9mZpXb6V5NOKGr2RPg3r3sRbCf7XcP6DnCQSmtPVUnLuRLt5m
 HaxalccJqN5Yj6Abwdjqh3yjRtM6jRs=
X-Authority-Analysis: v=2.4 cv=GLk41ONK c=1 sm=1 tr=0 ts=6a957d48 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=c92rfblmAAAA:8 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=C2uUxsRbeo5h9OizJ8YA:9 a=GvGzcOZaWPEFPQC_NcjD:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

This series adds hardware offload for channel-mode mqprio with
TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2 PF devices. Each
non-QoS transmit queue is shaped by programming MDQ CIR/PIR on the NIX TX
scheduler. When bandwidth offload is enabled, the driver allocates one
SMQ per queue, parents every MDQ under TL4[0], and applies each traffic
class min/max rate to the queue(s) in that class. The TX scheduler
hierarchy is reprogrammed through ndo_stop()/ndo_open() on every mqprio
add, replace, or delete.

Patch 1 is required for patch 2. The octeontx2 driver tracks committed
mqprio configuration in snapshots keyed by the owning qdisc handle. That
handle is needed to implement two behaviours that patch 2 relies on:

  * tc qdisc replace installs the new mqprio and runs its offload setup
    before tearing down the replaced instance. Without the handle, the
    driver cannot tell a stale disable callback from the replaced qdisc
    apart from teardown of the active configuration, and may clear
    hardware shapers or netdev TC state while the new mqprio is being
    committed.

  * When replace fails after partial programming, the driver rolls back
    from the previous snapshot. Matching setup and teardown callbacks to
    the same qdisc instance requires the handle passed through the core
    mqprio offload path.

Patch 1 extends struct tc_mqprio_qopt_offload with that handle and fills
it from mqprio_enable_offload() and mqprio_disable_offload(). Patch 2
consumes it in the octeontx2 PF mqprio offload path.

The driver rejects offload unless the interface is running and the
device supports CIR+PIR shaping. Per-TC rates are rejected when a
traffic class spans more than one queue, and concurrent PFC, XDP, or SDP
rep use is blocked. Ethtool channel count changes are blocked while mqprio
bandwidth offload is active.

Ratheesh Kannoth (2):
  net/sched: mqprio: pass qdisc handle to offload drivers
  octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers

 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   6 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 145 +++-
 .../marvell/octeontx2/nic/otx2_common.h       |  27 +
 .../marvell/octeontx2/nic/otx2_dcbnl.c        |   6 +
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   8 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  13 +
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  | 696 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/nic/qos.c  |   3 +
 include/net/pkt_sched.h                       |   1 +
 net/sched/sch_mqprio.c                        |   5 +-
 10 files changed, 907 insertions(+), 3 deletions(-)

---

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
