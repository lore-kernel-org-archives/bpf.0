Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010053.outbound.protection.outlook.com [52.101.69.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7048EBF7;
	Fri, 14 Aug 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728656; cv=fail; b=fKtGSk1tg2ginJ606eUPLRMjcs5gG9zy1I99nH4amYe4CWwCAFsGT6IjyKU90JPt/sfcYl5Sub8O8fjP/PjpYC0s0MuyRSjXApBHNfXLa2I4m4p/bw2SbV5Spe1cXKGPuFElbmT3KcmKZG9/Up2Q6k6/sZoqXlwY9HzS7xgzN+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728656; c=relaxed/simple;
	bh=ZV6B+KrMFtNFfyQ/kwd8qJx/1MvHBXvx/GnO+HQnw7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E9xXvt2ExBI4/Vifc1QDTl2j7O4Rk02xlkUurTSD5uJg7SjoFHnAk2yWDlCVz1ty5q6YCdWFd1EAyPo/hHWi+iw7cwcjY8N7+zcov2yQ+myfqKVW7YnIN+zAR2plRJMOVo/yuN3RgOurE+RQU4LNnrXKYhCTn+zCY9WaBNxoKJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Bxpk/Rog; arc=fail smtp.client-ip=52.101.69.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Bxpk/Rog"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z823Cbhniy1PK7+Yz5gxWdjEOxXHsIP0BoA+HHkB0Ox+m820m/S9W7zT3YvUPt2TRF1Gbe2GbNRwM4CGRfBxKAxgSkmCT0LnF0ZZli3n+pUfvTxrLOtvlnBxAaWdcJsG7IvXtrxRC0YQeDtxpB4aIReWW86J7dpZztStm1daniwI4Hh977VcxTZYMvaniY/nSrtd8sTuOTeNx8xoj/Ea+yq4wq/hSC4c0se8NoEF6yn6LujZCNKmdvKCOTDwBDeUqJu+qhERSINlGw1Oy1LF5thsgxc5CJVfliZ6EuIQl6XHrjhD095+8+0VM0SrfuQKw+x99Cf2O2Es4lnv+Zy/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW1K3o/DxTEJcZZNxTSXA79SY51ZfehKOe8fy8RaHI4=;
 b=IYowF20RtIcb0/0mN5SordoZIFWoJ7kDbxzzHF4nYtuAWW8AxSxSfIBiMth20g5HtEsaM5a/bA5eEuUf0A/zu6JHkcl8NHWOiiHbN4BrwBB7WQeehP9SNFo9uaNRc06uKP+6lmhqXCRP+XH9LVVDgSu+03dWTXklHBBr08BRa/E1RG508qxcNJ75w+6MY8XTgTSgJpdab3dXP0u/bGATp1f8Uaju6QhN52Rsx9wdA/oX5CAvx+0nDwtr40eCgSmc7Ru99Lsl9ogv8owunkf3Nbe9uiyIwuej6DqAz0qCTeZ2iQnA51mES3rXH4o288bs3AiOZnnUvlglvDh/lYW8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.84) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QW1K3o/DxTEJcZZNxTSXA79SY51ZfehKOe8fy8RaHI4=;
 b=Bxpk/Rog/2HRzOqrYxO8SwP4Ns5uWR/XvW5svUQ8uHdOjiwC+ZCE4ZBX55cDcm6yeVg7S6e+h5Dt3xZial0fiabmUaaq1jVlWGycjcNqRCorpewNX6fxOQGBQ+iJRHrSBwJZk1RVMtKYh48zmVdlCP3PrfItz9aAarg1XYYdDoiO0f2H3PR1yrsMX5mBvfpZT9e2Skkn0W0WrG43lGuN1fd+cm5uZMeJ1QRhhQYthUfRmxDZ6ewMYALQKW3ng/1h1+lmnHYjqNgcmoAS7WOvfCBVthjgWG3QYcMmGnPa/kMQ51yfRjHehslC/407B1kPIwY1uVf5bAjZCk4VwKa4tg==
Received: from AM0PR10CA0044.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::24)
 by PR3PR07MB6971.eurprd07.prod.outlook.com (2603:10a6:102:5e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.5; Fri, 14 Aug
 2026 17:30:44 +0000
Received: from AMS1EPF00000048.eurprd04.prod.outlook.com
 (2603:10a6:20b:150:cafe::63) by AM0PR10CA0044.outlook.office365.com
 (2603:10a6:20b:150::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 17:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.84)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.84; helo=fihe01smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe01smtplvp01.emea.nsn-net.net (131.228.2.84) by
 AMS1EPF00000048.mail.protection.outlook.com (10.167.16.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 17:30:44 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe01smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 74F9C8000096;
	Fri, 14 Aug 2026 20:30:42 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
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
	kuba@kernel.org,
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
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 0/2] Explicit TSO segment count
Date: Fri, 14 Aug 2026 19:30:32 +0200
Message-Id: <20260814173034.749151-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000048:EE_|PR3PR07MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ccf979-5b3f-4558-84be-08defa29c542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|23010399003|82310400026|376014|36860700016|10067099003|56012099006|3023799007|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	Fo11J2xnzz4XwY3CUMCWTGJgeJvgvRkAo6uWWBDci09OGnvrRafu0KCjhIc+Dzp4Tbk5F1aofVheu8xlEa3XNUGfEJgUq9hS0eFHMuocoeOYn2qNB2fDJ2xmhFjsW/9Ta39PHY6jhSQHK05intBDJfNa+ZrOpu1c+WM1mSrjt/o8mgmKSyoGAiA/6rn7IG/v3xT3ixVjWsKNBX+9pQSLRCQ1lD3nGxnUkp0GnU44Z7LjYiE8V7GMqdGeHc4mYLBOC6SDB8YtAjRpW8tpgjvDEU3z661f3itpyJbWUw5JTexMSzzdVDO2jjNopVZEEo4OEuNahPDomGmE1QyVtO58ZzfBXU9gUgRc8YIPQvcXNClNCVksoyDyTZx1Aylka9xG6R4uhRaB4cITIO9FVTxcsfyO1hhgUi9QO2jJ6b7IwY4OBdsJPO68nhfSQW53953pLdPYiwOiLL7UW5NZpA7MoF8A2W/D3mnhm7ui4LEGkTStU/OEHzj53Vz50l9wjto1O1Y6xXevEsfKtfNAsbkhWH+FnrfdKR3Q2nIS1zkwiu1amegnR6pvGPQZrtkgYo7nAEBF1DA4ce82XoqwYEu3iWd2pabPATab+k0ymbO6A5XkFeA0NMLaKCgK+Xx1ywU8yRfleuAIecrf+LHDMUvwVMWO9U1OWMDHOp74t98FKDwNAz3qMHhOV2z0CtDktqmVzMXfjHzDBFQMEcJiC4v8xrJtR/9dTkguuHD1GA66dlhqf0Jjpyva3XTOfVudmFFg
X-Forefront-Antispam-Report:
	CIP:131.228.2.84;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe01smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(23010399003)(82310400026)(376014)(36860700016)(10067099003)(56012099006)(3023799007)(18002099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cmTftJwmUPY4M8yOyM7DFuAEkx9eULXITI6Ip1FHMbmkY13h3/AqguyTWNBgY1EjfLN3XTyZTwVnZxgCM3PnWYRhDboDAW+oOH0jkfrRkOUjbw8QRBKLhg146TuupZY55KMsV1EjpynhChqEiZw2MkE0rU6Hu2Lo9MW5jfcbwObcNeVSBeatmvOWNjjuz9xdtdnt9Gf6UAwHOqw9NGUDsNKCCYw8Z/Da3Qe8MSw5LKf8mfYQtgyFAz/YUsWTbXDVgh3Z3tm1nsGwBtcnDXuewbz/PgUqvbGOfWrf8orMwdjBFNhjWpehEuhMdq4iYhyfYDlNbgw0htFTy2RHeUCJDEEI1qlpIxV7xuhfP+RjymenEf5vq0w2aKjLjbTJyvM8OQe8e/dgN+GrilsR4NtoI5Skup57iwJN6VuTzF4CKY7FB44dW9AIYTcksWiIxXmc
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:30:44.2591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ccf979-5b3f-4558-84be-08defa29c542
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.84];Helo=[fihe01smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF00000048.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6971

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v7 explicit tso segment count series.
It replacece min_tso_segs() with tso_segs() CC callback and make
tcp_tso_autosize() available to BPF congestion controls.

Best regards,
Chia-Yu

---
Chia-Yu Chang (2):
  tcp: Replace min_tso_segs() with tso_segs() CC callback
  bpf: make tcp_tso_autosize() available to BPF congestion controls

 include/net/tcp.h                              | 12 ++++++++++--
 net/ipv4/bpf_tcp_ca.c                          |  5 +++--
 net/ipv4/tcp_bbr.c                             | 13 ++++++++++---
 net/ipv4/tcp_output.c                          | 18 +++++++++---------
 .../testing/selftests/bpf/progs/tcp_ca_kfunc.c | 16 ++++++++++++----
 5 files changed, 44 insertions(+), 20 deletions(-)

-- 
2.34.1

