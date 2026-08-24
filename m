Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8C468C3D;
	Mon, 24 Aug 2026 16:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787589111; cv=fail; b=ITUsQwA5SYuRQcmfEAH42iP7MsIHf+8mcG3DObvKK0Zt0BSETlTPql3zA9RaQ96pMdg+43c1KM7NQNvBFZSlm6bVI84LGyAU6f2RzXjl2LFTefQQ0ziG+QNKRgpd60Ush6pjGNPP7Ty6EIozK6RkrBJBKP0Ylhdf0DES3sO1k3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787589111; c=relaxed/simple;
	bh=D0vWe7BNS12uXu+D/Had0O6Rzq8u1Rd00LQV4sPfjYY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LWcWT4R5WXIvqq6ZbKuYiAhwGdGpeIsLkxn/hCCDCWdH1ZvI+EzM3f9h6h7Hx1iHPVeOqlzKCR1ASqt1riNWrqnOWkaYSZh8yr7+iFppxWZxiCr4KuMgk4601KpRbJNFUH3gLWXax8B5vE3BrwP4mtPw0hpFDVV0aUds0DDZp64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=k73onpR9; arc=fail smtp.client-ip=52.101.69.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="k73onpR9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZwpqOYkEUVzqEQOphhBkAofgoS/IR7oS67CTxYX1nLhUuxReIYPfX/sXGV0WxeDHpQUINPxTH/dtXIrF2rAZxduh925hyiUWAfPGTOE1/BxQVlq4gCZv50BpigeTBE9xfTDnpLhA6C6RG7cvjO7TMcQYiHUNVemDaxi/9trpTvXY6NZmO65a3UMZhZmEKhoRjlqZ9fjbesW1/zYDDAB13BZcvr2rMqPQSJRD97LXODvlXz9zVbfGfTK3GczGwslC0zBeff6Zva21XDLCDppHja31rtkbcKhROWcc7Cwug918Tw/yHLd2brED+JzCwwQNoc4gcmlDhYO92fPoXNayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMfgLW6zcdfUUR6v/CPw5TpN5mJqsE0iIUVTtRKhknA=;
 b=YfYxT6Xie8itDPmWly+IL+Nw0AQC64AlwSfLcl4dXfLOVmEQ7mWeGw29ptWW/Ofnd4N/fmSYykGOB1+oy5CjXip2HxIhQM/Sh830xsPDkbSDj/4sHOuxIi1LJeh491teCzPp6bpmSMhKf+SVOfk2gYZmBXAVeDS+PSM+Q5+HP2pMlLCJPCZ9d5XiAXmDFU8ZWHgTE/vG0a47i2u4uP98D1IDmiqZzTIUXmDku0opdqYKMIOBdk/7ZSKYuy8wd1ZIlPhpX8+MxZliKtjYekBcexiQPFvmxLe0DG9P4aUEUBTBQtDU5nqwFXVM1hoVOvXEYA5aummdVsBIc26iZjCZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.85) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMfgLW6zcdfUUR6v/CPw5TpN5mJqsE0iIUVTtRKhknA=;
 b=k73onpR9saYEeY9AtxCnIMekmJjWo5KVr10uEWcLRd8RvpzwUT+kfzTjJv0aPxS8OQRJvtBuUGFLcVMVMpTmNqdgrIOFnggyVgERom2GOg1WXL3bVMT7PSpUiiLRSiL2F3nvPILVfCehycPGrQaDKnP7DO+FEWi/on1RKZuNJfgUXEW+ehq6s73IG2FLESQkQcvnvfI0HsCzHRksbjqWzyIz9hup9nRu72i4WtI9rQwGUYVfHqWUKj+sNj/tg9eP8Fjt7f9xJk3I4ISsK+SiUH9s/P/eYqL90LVuDvixngVtVRGU9xX+InwJr3GBB6fENhfVouNSDWk5VA9izuu8vw==
Received: from AS9PR06CA0280.eurprd06.prod.outlook.com (2603:10a6:20b:45a::17)
 by FRRPR07MB12251.eurprd07.prod.outlook.com (2603:10a6:d10:1ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 16:31:43 +0000
Received: from AM2PEPF0001C710.eurprd05.prod.outlook.com
 (2603:10a6:20b:45a:cafe::44) by AS9PR06CA0280.outlook.office365.com
 (2603:10a6:20b:45a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 16:31:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.85)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.85 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.85; helo=fihe02smtplvp01.emea.nsn-net.net; pr=C
Received: from fihe02smtplvp01.emea.nsn-net.net (131.228.2.85) by
 AM2PEPF0001C710.mail.protection.outlook.com (10.167.16.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Mon, 24 Aug 2026 16:31:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe02smtplvp01.emea.nsn-net.net (Postfix) with ESMTP id 13AFA800009E;
	Mon, 24 Aug 2026 19:31:41 +0300 (EEST)
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
	vidhi_goel@apple.com,
	Mike_Rudolph@comcast.com,
	Jeff_Howe@comcast.com,
	srichard@netapp.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v8 net-next 0/2] Explicit TSO segment count
Date: Mon, 24 Aug 2026 18:31:37 +0200
Message-Id: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C710:EE_|FRRPR07MB12251:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4ebf24-4885-4ec3-8650-08df01fd2e92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|921020|6133799003|10067099003|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SpKz42wLnbJfAgMxffd++ILITGm5Cf47xWBmDPqaXXFk3PlRbB0BRz8hab6+8LLzVWwKQWnbIlVakGL4GgUivFq399vG2DQZu8taIJqqWx9ur0Tl4m1dSGdsavSWmlyG0omh+HmjbabGJZEn5LQCQLa6XInwE99fzTwzvXiiDMMLSFOnTGnJKB2J1aqt9PrKVDugIWEjPOvYDLxM21qFhA5xqECZ86HKjrHAzQ7jQeLOuBWCfmc7WvQokITBbaaYU8SeVJN25UNo3TuOOz8xMieEbJqIvWy6jRRubh51BgMy9OxRZ49vHEvo63OyogWpU9knDxYTTmWock8uOdK4LkCbmq+w9RbqS2rA3OFj0TynYJ0IMdPZ8BO5M99l57MK47LzP1fHFd6OMEPm4NrWysC+v/mGvpuYxi0C7eotF+zEEM0VRTnXoxgdw9QUKgyEDeDoTI/hZvThYdbCrd6pd3ITY3L8uMS1qtbzacLR5Hh1DeH20X0N9uRQWB7jOGC2D4Wdlu6CfJaZdUvWxq/O7uIToPKU55bJ7qq/qhlOjGU8CBPi48ta96xXOnynlfj7uWQ+H7CYzjFyfcvbTlKbWr5xqLOXRGBNo6NlA5WfBGshhx6klV9c4AzseDXqYiqMPah+F/7hjRDvQL7hjaQ4G3mGCHY/9fznZIycTlPn6n8p7r3f+eGWOTesn4Xxsv6k4lUIwX7J2yNxLiGjjWnpZZNlTl7VbLxh6YOFWOzEzn5Oel1Ejscu2NSzXtg2OIGj
X-Forefront-Antispam-Report:
	CIP:131.228.2.85;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe02smtplvp01.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vRwgCOApOTMSYqRcUV6zuua6bTJmbVqSXrnd9wNKIRw1B1ohKKwn6zMHI1YYZqSoN9wxkSV/2Xu8nLllOJPs2UZPdXz+rxf+G8YbdP6DxaUmijy5a+DkO13/Qzmk8ZSXDTj3sUnL/mO7xFCpS2ZEdhX8bngPrnBHomuh9+kEzrwAF6xGm4DEcc46JQMplJ7G33sh3ea9+dM/wqD8Xryd7QZ+2xyu5KANRENWL+8MOReG8/UYRgZdZ7vuXa1jC6K1etDCCig7eZx6OzVF80AbFFe0J4Jk4yhdn1NUDb7yFoCvcXVchIy4SyhRPylHDBxq1WBVotinWQ4ZQwMrP1cFiXR6sgh9aiA5rE0szGmNBG9aq8ypTQyfKzEkDTyp1mrswDcpsh37ajSzc2bee2wsbWkspQMmwYdhvtXiOiVh3Gw2E3UjcWV6TDcT4QKepSZh
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 16:31:42.8934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4ebf24-4885-4ec3-8650-08df01fd2e92
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.85];Helo=[fihe02smtplvp01.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C710.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR07MB12251

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

This series replaces the existing min_tso_segs() congestion control
callback with a new tso_segs() callback that allows congestion control
algorithms to provide an explicit TSO segment count for each data burst.
 
To support BPF congestion controls, the series also exposes
tcp_tso_autosize() as a BPF kfunc, allowing BPF implementations to
reuse the kernel TSO autosizing logic while implementing custom
tso_segs() callbacks.
 
Changes since v7:
- Deprecate bbr_min_tso_segs() kfunc instead of removing it
- Add bbr_tso_segs() kfunc
- Update tso_segs() callback documentation
- Sanitize min_tso_segs in tcp_tso_autosize()
- Return the sanitized min_tso_segs value when mss_now == 0
- Update commit messages
 
Thanks,
Chia-Yu

---
Chia-Yu Chang (2):
  tcp: Replace min_tso_segs() with tso_segs() CC callback
  bpf: make tcp_tso_autosize() available to BPF congestion controls

 include/net/tcp.h                             | 15 ++++++++--
 net/ipv4/bpf_tcp_ca.c                         |  5 ++--
 net/ipv4/tcp_bbr.c                            | 12 ++++++--
 net/ipv4/tcp_output.c                         | 28 ++++++++++++-------
 .../selftests/bpf/progs/tcp_ca_kfunc.c        |  8 +++---
 5 files changed, 48 insertions(+), 20 deletions(-)

-- 
2.34.1

