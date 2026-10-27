Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793113601;
	b=sX9hGJFSeDdQBsOe9ycRoAeuvPu/Vwh/JmyOIrwg/JKl7yUIuqXymD+NamUzg0ko0zg4
	 oBsYvbFcOojM944io55Sur3Fz7fLfFLQV2Yy5uybVlKatXj10xXatAJVP/W6PCI+PL5ao
	 jWNHKqDKrjaYbE05i0PJiJN/awMnXT8cZOn5AEQe6/+AcO91AqHDk1SpNdQAvd24Y8Zuf
	 BMH1UvuhrO3ndcqU9MLfRIu1O5LpKXwdB3J6eluZA+twgnoeVWdPE2vLNdoZv4Dx2Q1qL
	 p2oJpbwdpbn540x3elQoh5JiEvW0R60/DUUw6yelYaoFtCsZzasie85ldL5t7gzp81g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113601;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8pEj/Eb9gK4LR4Hdf2/XaXfSy3bdbXfXotIqlH+HCUo=;
	b=GJkLEqr3lM53wRGakcUfV4UWtdbyNZT6dTrXfYgpr6XCqXjeTjtReIMkQN/W0K3AQZIh
	 zQtyzyFJsLNn7VTIbGzfrXMvDR+88gxFZlGvIWdm7ozZHfqDP575e2hXCwc2xhbfceCAH
	 /AVaJeJdH7/pGScSC5XcAniZd+VuePZMFXuz4Mt8zNnToyI9cuxmbiTQrxSzZ6m3SwO3W
	 D3kNcYQbQlFWTCP54I86T27mdfKuf6ORNt3TGVyfBfxxhkUm2tsSU2DFWYQ+SzcFQTHfs
	 KQTYihlThvFIC1iP5ZL5DprPP68Bk6AEPt1/hpArzFsPDQKt8X8cf7dnnPyt1hKO1jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TyVb89e7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.6
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E781606A31A;
	Tue, 27 Oct 2026 15:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E781606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TyVb89e7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrIgBs7fFYyr1Yan9BEoX5eLbNsFeRL7iEXoO33O1KMR5HV1qBPEfHkAqrm1OZWz+bPZXU1UiL4HSRMXJq2E9pRW6yail2ZRGTItYvdxJuEi38+PgSbfEvggh+jj2P69JlSgaWnIaDmfwF8prq8Dgsk4vTwdo3WCJgwUH5WJrFl+HzmoDflby8O5/RfuvNgscOjcUh17aWp10x27T8/JvKp3duxb2ADfbk2BJHk1E00gI4rQnPiWuxirtJaMJo+bEeM1ARdkXjzJ2en+kS6NtXIVTXNoyUcWzjcXldtzU1ATwcvcMsuRuE3eE2E40s76gEIHhU5ZxHN12q8cR5aH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pEj/Eb9gK4LR4Hdf2/XaXfSy3bdbXfXotIqlH+HCUo=;
 b=ENTYXOqUyfKxU1ycfljDvSsUp93J9pNtbEpyRs1dgg2LhopY1hW8enuqhKO67k+ouYUD7VgEVaG75EANPRiOb02uAtRJmRwm9cXFfGfcgP54iRJ8shq35Q7mqICX+kkhLGfLrzi0bdVnAdXMk7oBVWmm6zwHZOR2Q04RkkfhJc4Cj/cZAU3ZKdvITKHJUo0WLqt+99CnCgLeHS1I+PAKZX7dTzN9XTxN2POs9xwzW/ruqR9sL+nAP+kvWQ0JE+aATbyIhra7JhbuGIZL9RjPEpH6nDobekhV/mMZFmKWiSZ9X1XS6MOz458yiOT2CmkW9DdCsSXgK3lf7QgKOFX1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pEj/Eb9gK4LR4Hdf2/XaXfSy3bdbXfXotIqlH+HCUo=;
 b=TyVb89e77krzbKFMopd6b8QAE2UeaIQTOESTOjxy5qPC4HjxcJPC+o23baaNYXr9g6SqYs0L7yTx/eXEwqVJD96nvf6QEd1BMjs2dZmvgqrqEJp0EbdT4Rx6h+QB3yPTUl4zS6R76YU6vBqBtMyLBaTLOqlBxq29KHu7/w+ciERDKfkqCh8Ynjo3MFiWMBD0WHQPhR5GefbhYTAOvyjDnCQrsrEzj8Ja+SPJkUqZotnIjKsANpOu7XvkeUA0/8byrSwd3yOn1prF7a+EEzovYrXCq1QnXG/RIkRndqjJeH/BDQGCuMqoeHFhyH3tybRhrQEdnDqJkVehedUUxIF6sA==
Received: from OS6P279CA0071.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3f::19)
 by VI0PR10MB9252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.7; Tue, 27 Oct
 2026 15:06:35 +0000
Received: from CPH1EPF0000052B.eurprd05.prod.outlook.com
 (2603:10a6:e10:3f:cafe::2b) by OS6P279CA0071.outlook.office365.com
 (2603:10a6:e10:3f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 27 Oct 2026 15:06:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000052B.mail.protection.outlook.com (10.167.241.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 15:06:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 27 Oct
 2026 16:06:58 +0100
Received: from localhost (10.48.86.230) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 27 Oct
 2026 16:06:34 +0100
From: Thomas Bourgoin <thomas.bourgoin@foss.st.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Lorenzo Bianconi
	<lorenzo.bianconi@oss.qualcomm.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Subject: [PATCH 0/1] net: stmmac: descriptor management issue during PM sequence
Date: Tue, 27 Oct 2026 16:05:55 +0100
Message-ID: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
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
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000052B:EE_|VI0PR10MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: 442827d1-4b2c-4cfd-8193-08df343be4a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|1800799024|376014|18002099003|921020|11063799006|5023799004|56012099006|261026140227099003|261026121527099003|10067099003|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	Q8AOGHb524WH0dgoK0YGR25JcXOow18yuFWG9efVU+w8yx8qec5WQMWzerS7vlgWbkiVRp0a2X5XK4tEMs0FLy1k/TwuGDbT2jEEQlGES7d592atW/gymqr6FxNN5y+CCUN4R6gKhJOcEnkUXYV15UcxOzrONyk1v5iMB+rvawRNV3ureEf9fF0f7ovA2Yu9b+RSYz/zTnbKXew3xNfj4+ZQsm6RIuV4OIFYDRzjUGf54R1zEN7rb6HWTUp+kataBK0dwOHcnn1ZENEw4Go7ftk8AN8mw5+8CRhTiYcva5dg5FVaDnzwz3JI3MSScuMhmXeaJXpaSZk5ZG6Luch/3G3byiYPGOm7+FgbsyuEQA9UKf2h+J+xmuVJ7xc0FoepYn/rKbduNV3uQMtALZVV9TOFzQBY1ZuZNfhDwA+OZC8NdjudOPSyV6BJYwcisls+Urdu+IRn6eElH0tm4nq1puvxRA2zCsp/fiN2p9dLXiVEx1PvVkGNPqehoetLII2r4P1qun/M7eEf4soT32mHGgIKJPzIMTfDzD+ogPavgPEZ/3+uqjh60UForNC9BFchCiifTADBW266kv3kiYWmmGoMmnJxiNMblDS7TJtD1mA4O0NuQbSmdDLI+pYFLcOxVikCeVAloDwIO65Rh8FqdF4R+1UGQHL9+x3BHO4r7aXnwzY1W74Gn2/6Ce9lQ6m0ovaLgeaWYNPeA+T98GoR2ib8im8SMbJA+D+aPi+/8jwqWRkQfzogzmYd3+AVs0V8
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(1800799024)(376014)(18002099003)(921020)(11063799006)(5023799004)(56012099006)(261026140227099003)(261026121527099003)(10067099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eBwz9OtJIdMLBgL6Vilmmm9SLSWHQave8m1/oEJ4emEKj77E39FZQSHBaxQNXU51sEQJdGaW8K0mKrAhd7kMf/rLnIkEG+oXdm8Pi+v70MaEIrttPEneltk6Glz0tA4xb2Uv81fI3Mh0Bv4+unnvCSlSE/mJfSyrZSgCmNEVPgQaEzOQ2S+XVwnkTzolG5fw1XaLA5QxaaQAr6cUPmVzQUNuhR2E5HVTKntPgBal4DNunE0dHyHcwjGp4NyBH5/1UuBoGtbPYWZr0j5j44/EpsBYms+61l7UHsbHhlY31nGNpwcjC7mLTYMvnv9+Bs086+JmpmX5AM9eJrFH1Epvd2aM02tv00CPngWqaoh24TgWMBaP99fuNWGB7qrPhVHBeJr/Ks9qgvWYYYZLP7Bs0t+aushYNo+AQ8dxc8TQSU6pvEUY7v6rPtbuIbU6AjCQ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:06:35.2643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 442827d1-4b2c-4cfd-8193-08df343be4a3
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000052B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9252

Hello,

During low power sequence on STM32MP21 we sometimes observe out of range access
to the DDR by the GMAC ethernet. I managed to narrow down the issue to the
resume sequence of the RX descriptors with the function
stmmac_clear_descriptors().

On resume, stmmac_clear_descriptors() returns RX descriptors to the DMA
without restoring their buffer addresses. On DWMAC4, the DMA will
therefore consider a descriptor for the application as one for the DMA.
This can lead to illegal access from the DMA anywhere.
On STM32MP21 the DMA address bus is 40 bits, thus the extended status from the
write-back descriptor is read as an high address by the DMA. DMA will then try
to write in the DDR at 0x100000000 whereas on STM32MP215f-dk DDR is only 2Gb
from 0x8000 0000 to 0xffff ffff and nothing is mapped at 0x100000000.
All the other SoCs of the STM32MP1x or STM32MP2x are using a GMAC with a 32bits
DMA address, so I do not have illegal attemps.

To fix this, I propose to reconstruct the RX descriptors that have been used by
the DMA but not forwarded to the NAPI function stmmac_rx() before suspend.

I'm not used to this driver especially the xsk management and zero copy part.
Since this driver is used by a lot of plateforms I'm open to all suggestions.

This V1 propose to reuse stmmac_init_rx_buffers() but maybe using
stmmac_refill() would better fit the issue. From what I read, I could not call
stmmac_refill() as rx_q->cur_rx is only updated in stmmac_rx(), so
stmmac_rx_dirty() returns 0.

Thomas Bourgoin (1):
  net: stmmac: rebuild RX descriptors before restarting DMA on resume

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 86 +++++++++++++++----
 1 file changed, 68 insertions(+), 18 deletions(-)

-- 
2.43.0

