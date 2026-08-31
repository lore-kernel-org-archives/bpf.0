Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAB38C2A0;
	Mon, 31 Aug 2026 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195170; cv=fail; b=FxLyuHMB+buyjQSXobQ4XnGrBYqIAV9paHBXuJN1TGsxqcddYmSQlhYzYQUkzjdg9Wnvg8tEWK9z3Z/kaSVcyBR8a2bclP49+buKqLiBZVLkIjRPxC9WDAVhYTxwWmvlJxpcbv7/zIS7e/M7KiJMXGSQQtoH+ftfy+qGYS1vsT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195170; c=relaxed/simple;
	bh=qBNc+Iow19fXClWRtjQuD1dQjskVEWZuDgkbPoWn1S4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oOPVpBbYPjjVi2DfqM8Y86Vfy7rgz9/6Nd/J9m0uYSMpkV7Sfwsrk5rm6g4DprabtJx/d2Mtm5lneMO37nreKYMz16IB+phSRgiAOg96SGUpj2r9ELhnTCIjKPEi3H7cvXaJyorRh9PycPm7SExI5MK+0tmILuNRoT7EDvHaWTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lN14cRh9; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lN14cRh9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pm7djtQK8vS53u3LzvG4JN48KomGG+gWA1R2RQJa23nYoaj+p2aC0t9zQpA6pjwfFjj/CW00h2RvHaV9pVLjNdHUlX3cUMc48TikRaJ5hWf8U7rObjECi11tfEfIdK2lPp5jkIozljJPCtaUFpXIP3Ko1E8xXvv4hmHZ3ULIu290IpQqrZXObSqdm2watZp37C6JdqYgTXYTil1uLmyk7wwpE3yH5xltwmXw1AuYfDmRz0one1iyE37FKv4+LpVpmRWC4ehKbvgoOO3RZ4vstXUQ6cgmt03tPRaS+QlqFpMfZVX+3I6TzNIYgtVUKLBuy1DlJBrmMRarYeUJf65Mfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ3J70B67Sgvq/IpoCUrPynA+Nz7UEb2UTmBlQjCiaI=;
 b=seS71mU9W7lwB/qxyP0jpaLx15xjD45kk7ee2jcnevF2jgXwYUwk0f5i1ozF1IQcc7wX48qCacu1ASgvNwEUotmGgBlXBlzzrFxy8nzdVU7eVdQKQ/ML9lqqM4eU9KQ3y2xjZBmxE7PFOSTeb2oHU1Ga+8CTApaTMHXaHA0R+VBhlF8oMGsYtdFjm6qDCXG7/88LAiNUP0V3E/A9zj6yLR9K4LNs3swj/8sC+cbqCERuwa3LwFRncMqhKMTeY7PBPk9e5q4nRGi3jrwEmo4ika/lwE77rnT+4P4FIrj7e5ONCXQ9qdDp8GHt1taLXjmxUTh0nexuTJXfdG/K3yp3YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ3J70B67Sgvq/IpoCUrPynA+Nz7UEb2UTmBlQjCiaI=;
 b=lN14cRh9h9rt0opvmDgH+oNEVUYLWcOcfJeHUzh7tV+qj8eqCBod8S/rW+GFgnIO4OAKxrJJgxxjfCKLzcya1yKN3TFs4w5OuO65jFeYRwB4dZJrhYZ4qcudbXmVj3DlQaWrFRYweXeZRUUQ3cqxBD6QECjwG4cCgZBOJGrRwm7+R5EhpU2cYiQhj+5N1X9zef/jXR/5AezAOgKYv1DAZKgntP0Nb7ftTaKsy8R91yExMjLHBU5oaf2hjGxVvcb9h4upuSDrstJt5hzmYPodJtjk+KZCpr688kz8kX+adsTxUncnW0BiP1WB4sSX2/RO90oBLFLyEHIu+fIh5IaPUQ==
Received: from DU2PR04CA0222.eurprd04.prod.outlook.com (2603:10a6:10:2b1::17)
 by FRZPR07MB12364.eurprd07.prod.outlook.com (2603:10a6:d10:1cb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:52:43 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::20) by DU2PR04CA0222.outlook.office365.com
 (2603:10a6:10:2b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 16:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Mon, 31 Aug 2026 16:52:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0E40420118;
	Mon, 31 Aug 2026 19:52:41 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	stephen@networkplumber.org,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	kuniyu@google.com,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH net-next v9 0/2] Explicit TSO segment count
Date: Mon, 31 Aug 2026 18:52:28 +0200
Message-Id: <20260831165230.2696893-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8E:EE_|FRZPR07MB12364:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b963b2-2e24-4dc6-3beb-08df07804686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|82310400026|7416014|1800799024|921020|6133799003|56012099006|10067099003|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info:
	D2Di7x6k0lu8LKnXmzxvsS+49e9bJZyTqsyO0Rl/Oz7WaFJl0Si1pCI1Q/vTSpc0Tk8aOzYjdUdohJuicd5+gOCAhhaZCKhJ8FEm9i/fTs0SsTru/fjUUbatKLGdrsrwDrb//b7uxae8KKTuvc4G6A6Evc627jiIVa0fN5MJ2PGns3IXVO75BhzfVa5yIvmiaJu9whCOyYqDKMxOMIAlELpMpUFq7lvijeWJtKPxDrzATTu2Vh+FrJ9UnAWKbYFinYw5OUiEkn7NYKh9m11k/vjGDiZmDZwmT2elUikeUM5gC99+jkvZz/RvAFK4M4zxpPvcI23RqnT1fydESaENcBCl05ejrfBL6OLMs2ETMhqY/Fuw96uBfY/jvzDBqbf6daaPbZY0/f70sdQyPF30uVrFbpeWQVO3IOSyEDhjCeITVTBHrSGaTWKJz9gp7iVN2lJO9hYo2oxCpySGWfd7o9R7xxWlsrhSHPMB0Rc4Tl1+sMW+/O83yZSviLFqcnMTY7W/0hEK4TxQL3S44IkwrUAlsk1uIzo9BH3eHua9gCCI4hR6/7i05NpqCf9DDte/KOXfQajysxFepaLAlo5at8ql6HFNlBdCp32TXcMvGVp3LGHxtIKHYrGE/GW1rINbxsPJNHFaQkh4vc7Mi3ZBtLB+Wjt54Lq6urTHllzHIGeyRlSMMtQ7KMiFQOvbkw63x7N1dGSYuY+A/lz675a7LQPcuVEZ187N3C5+G4X7gobIC2yM7p85j//VbNaxmptd
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(7416014)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4IB/8i2I5yQVZY0H5Bl0uua/jus0gIRaXUVhoBOhZeIzk7CM6Y5eKqnhOMerVV4zWNuca+tUOn4y4Ot1x624XNl0l7X1fq17qo8i/UQ10Si6unn3ci2ACKceScnXIrh6ooY/wJzWldoD/rbe3/AKGNBmuK9W0WgtHX9iWR+U+m3liIVLaRtqVa6wYoa+D1gywqQKxJDePXtcA7KYDzz5ZYpoSN6PKc3R3ch9weGSlrmkY2fkwpxZTNo9+cOhTwJs05DTmaxHiaSolrwF16hckCW4yDPR/ugayMhDY0E3qk3AUFvxMXKCdsGL6aikfHBnlGuzCfAgsg/hGDoibE3wkGxuWAqe2tLLT3ERja7C39o2ZHIfBnbN8VoUztSMk8EtDJc4CqN6dDpgCCFNabIjbl1iZC8HiXECPXUgQMqKArOI+/+YapDOchFf4POIJwUX
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:52:42.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b963b2-2e24-4dc6-3beb-08df07804686
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR07MB12364

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

This series replaces the existing min_tso_segs() congestion control
callback with a new tso_segs() callback that allows congestion control
algorithms to provide an explicit TSO segment count for each data burst.

To support BPF congestion controls, the series also exposes
tcp_tso_autosize() as a BPF kfunc, allowing BPF implementations to
reuse the kernel TSO autosizing logic while implementing custom
tso_segs() callbacks.

Changes since v8:
- Remove deprecated flag on bbr_min_tso_segs()

Thanks,
Chia-Yu

---
Chia-Yu Chang (2):
  tcp: Replace min_tso_segs() with tso_segs() CC callback
  bpf: make tcp_tso_autosize() available to BPF congestion controls

 include/net/tcp.h                             | 15 ++++++++--
 net/ipv4/bpf_tcp_ca.c                         |  5 ++--
 net/ipv4/tcp_bbr.c                            | 13 +++++++--
 net/ipv4/tcp_output.c                         | 28 ++++++++++++-------
 .../selftests/bpf/progs/tcp_ca_kfunc.c        |  8 +++---
 5 files changed, 48 insertions(+), 21 deletions(-)

-- 
2.34.1

