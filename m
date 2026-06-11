Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93642B74B;
	Thu, 11 Jun 2026 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204274; cv=fail; b=tPp2nJtmLwNHtZYi/0LBFh6b6JkJwvLQcXYm/ImNM6IK2AyHQlaRjWyA5rNAwJWIlBZrP7E6iQ1HtSM5j03iVnNoaB9jT4f0ie0HVYCRj9Zj1gsh4kb/RyUxjhygQtpocy8AzTBwuyb2aYfMApoeVK9ZNrKtfoH7Qmm937WMfJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204274; c=relaxed/simple;
	bh=N/Q+LvKuVdOnq/I8CemD+jwmRfxD10c+VwS315ZV4as=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jarTXq2xo8R90BdmfpTIZKy0QQuisf/wzu+7/8gZJGaOV1fmjAVKMZ5en+SAFqvW58AMruTFkNNQ6EtlyFSirrtO+OgJyIoDFNxAPEvFcfHwqmii9eLzfzLEt+jhHN7iyjHwUHJWY0vXsIV2o1XVrPXUuduazsUnMOsgiPvmkdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=m1l2ljv5; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m1l2ljv5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APpshNWehy36kvBjtUIkXUH1WsvDLKQ+JpWqsqg7nJoS5rz9EK1a7E4R3IFZPtzG9jdFSGIGdcCSuAwPMu/cXif/j26KeJx8g7i0FAUN2p0JM7NbrpOQFNFJd80yHRGJa3dGPv6mhz2qSGN3r6vrMbB9A/mHdKMkKL0IvV9iEHlt8R9JOtuo0nUU0ga6Qo6X22W30/W+g0qdCP6Me9QLxS4qEpGQivXdjJkK4kATDKqtl0tWuJczr49zbHOchFdYwnQqHx/+jnCZYVHlAZpKcnqvyeOxN2OKobEDUZAPr0jiCOIAC6EXd2giuAfWRkN/7idL7rOQ/k8OYLQKD4CJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2pImc4D8sTpFiweu+no+tpdSqPLHxJwNSYKQhfepgU=;
 b=tkWcUBxXefGX8xVuNgsp5zK/OH/Pq2nSqdEcP1h2x7+f0DBuDm8f69A3aXD8Ii6Nf6TXglT6XrD7EE08JthNVqUPZFg3XPtT/P+PnWc2KH/KZUiYiVknxeFsvjf6WJjT6pV8AT0R/R1hct1Rd8dd+XKKG89PVJMJA9zhJuXNYDAntBramh2RqLpt5KJwZ29Wi0HW0d3yxD8ZsjNvuzBnGCiT+J6nOOXhhX1C1MSc86wQnVpPXEiYaP1WvWX+aZ129oXKn4WiwVzBJO4KfRPsX57CKsLP/vzT2XjXlwXwDXzGymN5XmsxPe+B7ozPtzxeYQZxruDowKMZyRo81d4NPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2pImc4D8sTpFiweu+no+tpdSqPLHxJwNSYKQhfepgU=;
 b=m1l2ljv5rFf90oPITgMtGMJLh6d/u0MMi1mfPaJ3eRUfjQ3fvmOpE4mljLbQpiQQbzfibvYMP1rfMxS3WnMMx12SsK3W/kvlPx12QG7Vi6SYxRIs3jM8XJ3aI9p3MQdpbUboDAleVLgRpim8xEk/zzEDt1ovMAU2T2mtvfO+SX4=
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by IA3PR10MB8274.namprd10.prod.outlook.com (2603:10b6:208:570::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 11 Jun
 2026 18:57:50 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::58) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Thu,
 11 Jun 2026 18:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Thu, 11 Jun 2026 18:57:50 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:57:49 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 13:57:49 -0500
Received: from fllvem-mr07.itg.ti.com (10.64.41.89) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 11 Jun 2026 13:57:49 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvem-mr07.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65BIvnNR652932;
	Thu, 11 Jun 2026 13:57:49 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.231.93])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 65BIvmdx013169;
	Thu, 11 Jun 2026 13:57:48 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <diogo.ivo@siemens.com>, <haokexin@gmail.com>,
	<vadim.fedorenko@linux.dev>, <devnexen@gmail.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <m-malladi@ti.com>, <sdf@fomichev.me>,
	<john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net 0/4] ICSSG XDP zero copy bug fixes
Date: Fri, 12 Jun 2026 00:27:40 +0530
Message-ID: <20260611185744.2498070-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|IA3PR10MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fdc76e4-b203-4059-7dc6-08dec7eb55c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|7416014|376014|82310400026|921020|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	WSvrIKKzhH0BfOXTmNFvbpverDdQbQ75WUq2jaNkbg0Lr/guk6gTI0ifOlmEiRZ7QWGbBymwDbaagtSWg+Iz8kax0Gbh+HUylz33phhOTGg1apWqeHG7AE1KA8TU6OmlZplO5yQIViGjePiAT76y0qUbr+HMUwJ2DUzMq7cARg/xmSEVk59Mj5S+OZMP3ulwH9rZEUBaDkmIY5Dwn/PRYi904dJqjEczjJGT6xmXVwmKOr0AfUvzqW5OIrsdXHum5k9ql4n3l9UZ47aFzNimcNST9e/lJ7rbgKCQtYhOAnxHQnbGrQvKKrMpC5yLQ4x7UgHIIagX8irf3ZtJYtXakIVgasimYRZpp9L6tBeXPmQn7AQeUueOf+wDsEtmu9HUUQUtVfjWx1OkSpiH29e9pF6VxWDr1nKIuT7hJrHlMrmG8MLBvqYLTbK5ApvrYWRSuaV7o6C1if/63TLb9mSgFGD6vYlDdbP5OD6MhndIUidJ1jF8SKf6IzZI/42GN135/6yaKZjalJVvrTnJv/+AmMOyTkCH25tt/Sq580Ilrsik7/yr54wVNdLRVjBnYQ3ft0KMHlnHdn4Uj0P2SsIXDBKgQoHdSayLgI1bpXFHSnxDS4MQBaUZse8btQ+hSacfjsm5s2tolyBPvbPZgvchGrF9CjwSiYw3ZdsOn9LWU93z2aDhY9XE+5Et91zShN/OnWEV7zeGk+iNA4AnceM3Me4Z0qfkI31ZrHqweSM5d8RuF3zKAtLkdIEeCb2wI9oz9Ssvj0RtyPpe6B34s0flwg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(376014)(82310400026)(921020)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m7TkflagbNFePcQ/V/IelM9RuqpBxKd5SdmRbAvIGm/qV6LqbqOpbvW9XZ8+J36htVq4XT363KE8F9p3teiAnkb6OLADRdrHg+QFyZZHuvCGiZ2GdvnOLtPK9JA0GA/Iz5Nr0w2qxJV8PFU8y8J5AvTWWvRFjPCGHPqzK3w6a3gnxqIxLpupBoqqephK8d1sB8j4T6Pm7HK8YQUfPqcnkFxBweFDMLlzANDCsHYmfCS/34CyYdWbtOe4TUAVY+BhYvLPK5yCGJ0Z4XQOGOXxRZkC83G2EadncJf7srozn7gWNG4qXd0ujdjqQnvxW52qPXkLCAy51FhKDMWtOeOs7l+7uqj1E/fz9r6IojGS+RoyB6z3f8EwUrZc4UZ135+KtvlDjmxADewgDt8XJEGawPe5T+ANKF7DX6s+MPApx5FflIUZab+3EoTwY3rRYQ/T
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 18:57:50.2370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fdc76e4-b203-4059-7dc6-08dec7eb55c6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8274

This patch series fixes bugs introduced while adding xdp
zero copy support in the icssg driver.

Patch 1/4: Fix wakeup handling for Rx when available CPPI
descriptor is zero
Patch 2,3/4: Fix destination tag in CPPI descriptor to enable
proper Tx xmit for HSR offload mode with XDP and zero copy
Patch 4/4: Fix Tx copy wakeup handling for XDP zero copy

Meghana Malladi (4):
  net: ti: icssg-prueth: Fix AF_XDP fill ring alloc and wakeup condition
  net: ti: icssg: Use undirected TX tag for native XDP in HSR offload
    mode
  net: ti: icssg: Use undirected TX tag for XDP zero copy in HSR offload
    mode
  net: ti: icssg: Fix XSK zero copy TX during application wakeup

 drivers/net/ethernet/ti/icssg/icssg_common.c | 62 +++++++++++++-------
 1 file changed, 41 insertions(+), 21 deletions(-)


base-commit: 29899ec61ac6fcc9d46f5f8d0b72117d9a676c2e
prerequisite-patch-id: ad8d47ed85a33f742a58e9f48e060303908493ba
-- 
2.43.0

