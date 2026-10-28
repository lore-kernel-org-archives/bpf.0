Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178346;
	b=Hd5VClwJmhTuBimjg1JPxzGlQ2qA2kfvPqVi4ik/I40CzKTtcnlrFrl6q7bsh0NRCn2i
	 yJx588OhxZn86g2WcgXfmdX5sykyKDU/VL/DvXlATaI9I21NRvJ3884OrLiqNcvEFkOun
	 Ks6dRDYAHai08wokPSPcya1XZCMgt7Dx/LyxtK9BA40pn5x6rEyPQ2/a5PPVjJSnsyHtc
	 S1jFwgLpxdGyRzYDHrXVDZbVCqNTQwPsDKYfaiL35ShYornMN/hDhisdOWlUZZ5JXs4a/
	 0cgH5edDN9lFd/1NvzIUxrgPYatgQjHKdlQAXwlzN9ku1nPSEIGeSO43RRjLF0rE9sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178346;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:From:Subject:To:CC:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=VdfUE1zeNps++gPXOwSlr65lQOrURCAUIxELndnADvQ=;
	b=2jhr7sxaLtLKJRJzP0XWPPr6NRU8naizbi06YSUBluLUDG/7B0AtmBCIvDuKCHWNsMmM
	 aVogL7jTVA+qAv7gJxr5MRqac+BoPng9JwXDKwUHm/tHw9BBTfefIhiaEyAJpOrMBU91w
	 9OOT99FhRHLU9X7YBfHbqwdOa4rcZe3ub1GgyBjq+SN5Dn2nShhgUh4gHeRJz9Ooh9cP2
	 s7rXZX9PtJz5IFMWlncVAQVPD/PcDKEnDnuILSoa/Dffqn4vdoRC6psRK4ACjaiGeOoaf
	 4Bp6nl148ZcBkhoPOeJTl1yI3Ss+RxxZs8226rxUA+4iZqUUZBqsz1ncYdaE53SOjJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HbAcGTgr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.49
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013049.outbound.protection.outlook.com [40.107.162.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA200606A31A;
	Wed, 28 Oct 2026 09:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA200606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=HbAcGTgr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go/G/2XEorrPGPM56nScft9+d7KJddkqRqA+lRaIUltbp5Jytw+xx4oYQIE6PNGa1dLeO0GAhhSwR8t54BEDHKW84irB1pXRsHk+mO12I2/+ERb5qP5eDqXTZH5ZNxrvHC/rQa2DOZ9Ao+BbWfj6HsJ6h6SKRcoIkEsDt7FLcQdbmsBSng6LHhFMCXYkNWA69QxWa0jfbziGGBJXC/8jb0oGNQkgsBOSk3BqXt4Cj4HEGGlFX06xV+51h/Xm/GAppvYvmgbzmdu44Gdlzf2xFOr6z+iz+J169U8GgFkVpjOf/VGFY1DYZmWCAuNB5PovI+PThmTv1rRN0R7KxHz2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdfUE1zeNps++gPXOwSlr65lQOrURCAUIxELndnADvQ=;
 b=fbfRhaYbF6eSzyZEh1/1FNVQJd4uqbFAb3JnbRZQHN9aEiZn6fAGVZ/Cp0V0dEVhjAdJxi0oeDaFjTdXRTuNyGw48oxWxa/7WkdH64YQky7EVFZyUqNNxzpj9cGUdE37AXbePqFGbw7Nz7ksuxWb//ZK74m8sfIX2qxW+MWVmUHHI0MiPJq0pV/QH8VldRX+2AKodbKOQ/T6iKX6DWAWN2X5C3aVAY57BS95Ex80cS1ajvYNcGn49T2qPfop3+gS6sZhERzrQmd/+T6/ZCrDC2OWvCdtmU2lFU/3AME9tazyLIE3717Df75UKJqez/vFFsK/bNRnzHhWd6FWWp2EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdfUE1zeNps++gPXOwSlr65lQOrURCAUIxELndnADvQ=;
 b=HbAcGTgrxCWtehpKHY99bxOPf3lTD+J8LyTk25wemKyEAVNKbx+dVCR8r8FuGzTAFr9CrgY+UG3fcnd4nS856M6w45kT2uCodw9PQjo9EKPqEdZqpN/bZX5fPWn7m3P0iMSucnWK1hH5lZEdtGOaXZlSsWvad7GHTS+pYIg9TbimuZkjqnwTljf+FlSaFCiIFIBtVSjSkeiBw4LahqGv4B5KfAl3Ewhm42ZsIfjHrxoye2hfJTjWWipJ8lSaEINs/6dWJNQ7/f8/U6DlfkL1U7cbwNZ8f98DKdRFaEFdX85sBzFBI6pDJDxroqXQMBxlSr6wcug3FwYiINDzaSxlOA==
Received: from PA7P264CA0318.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::8)
 by DB9PR10MB8143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 09:05:36 +0000
Received: from ZR1PEPF0000E45D.eurprd04.prod.outlook.com
 (2603:10a6:102:395:cafe::2) by PA7P264CA0318.outlook.office365.com
 (2603:10a6:102:395::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 09:05:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E45D.mail.protection.outlook.com (10.167.241.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 09:05:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 28 Oct
 2026 10:05:57 +0100
Received: from [10.48.86.230] (10.48.86.230) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 28 Oct
 2026 10:05:31 +0100
Message-ID: <30f98ff0-decb-4d08-ac80-5c225aea1418@foss.st.com>
Date: Wed, 28 Oct 2026 10:05:30 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Subject: Re: [PATCH 0/1] net: stmmac: descriptor management issue during PM
 sequence
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Alexandre
 Torgue" <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Lorenzo Bianconi
	<lorenzo.bianconi@oss.qualcomm.com>, Christophe Roullier
	<christophe.roullier@foss.st.com>, Ding Hui <dinghui1111@163.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20261027150556.51209-1-thomas.bourgoin@foss.st.com>
 <8a1547bb-cc42-465b-8a8a-d4790cd0867f@bootlin.com>
Content-Language: en-US
In-Reply-To: <8a1547bb-cc42-465b-8a8a-d4790cd0867f@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E45D:EE_|DB9PR10MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: c1990eab-59bd-4500-ef69-08df34d2a142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|921020|4143699003|5023799004|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	ZADUkWtd7lS67exZMtr0OqVWeVNMvBZgFu4+kjjCFUD+qPdZnUmLp1/GHLtH0q+ms+rxcZSBH/okxreT4GhbD/KEFdjXiwEg5+vymg5189U9Mu/WsCUyEF9btI5SnDgXOEnG/57k5igffWakVGle6i1tQNe1UV6tI+QfFmYCVjJq5u6IH1me3NJlBpfPlACF8czHxWWoX8HHfc2A1Ks5SG+ym0Rsaxbz9rK6sfQdX5f1V6KbfLVn3tlSdoXkDZ078RZ50Di+Q7oGISOBN/OjSPyqiClJyF1UnzGP6oAiTAdwP5dOxLPK2HY/n/wGW6+60TrU04Sd3GwwHLX1W7ppSnZeHC/Oqr9CHOipndG2rOruIRAQf58xv4b6xGiuHbxnwKvHKXfQwRS/YKGpPJ0ozUtJPm6NwWx0W0WHLhK81hqo6RL9SvLsA6jrkjrrwIIvjNDOdQUS9ow7UHnlw7vktG0TqVXiGEVnSOWphjVDa14YvZ7qeupZZu1K8n9KuYrHXwAjPaFQTm2A1zug03wfZG+09RuGOkjkEOPiwNwJiGvWphm/a+1B7LiTfPf2hbcvnMrHQZBJidwjEW+2eHWOWsya4GZXd1HIMevL1qyodT8OtDzbEJYdCKwpgydO5sIugbyzNGX4iIxCbYJWDiau3k2Uk6j12uUHah1beQrBRqWKGmVc49PRdOKv/vyh++MkxyVBGf947JGiLyMObx8HLw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4OG3EicmgpXmIRTtcnk+/Dgxyq4kyp34y2n35XFCzGwfrGvhAvDRndYMrAItMedgoUrIvU/p7vut8eT3fCjmHTFLVgSNKdqD+MA1LwvDoIkBTq15H3GYzikS6jhdsySiT/b8B/nqC9pK+6zRbcfg5lIDNnpSPuwUSMYjYSh6FYyWFs0fbv8zrstVj4BSzKoH96s/G/PWXlbT44Fh5ULMaiFNu9e7zNlF+ge7plCkanrQktndw/0ME1f6aaRUKCfRNk8HKYaTSzbTcEbZc6hEDjLbVIwSiStRe+MIZwxPJlN38FHZ4zFaF+sgiPPYreKDUaZhGIjAF7BqoZPTCCsMZjXFU9sU0YdEzI6st/42Iz6qqEWKNLf2lDj4497tTzuetUZu0+ThSZBQDUpui7r+893qIZCJJ7L4dBgGTxetuWpMN8Go4H6lhCiVgJb1hmQo
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:05:36.2930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1990eab-59bd-4500-ef69-08df34d2a142
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E45D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8143

> Hi Thomas,
> 
> On 10/27/26 16:05, Thomas Bourgoin wrote:
>> Hello,
>>
>> During low power sequence on STM32MP21 we sometimes observe out of range access
>> to the DDR by the GMAC ethernet. I managed to narrow down the issue to the
>> resume sequence of the RX descriptors with the function
>> stmmac_clear_descriptors().
>>
>> On resume, stmmac_clear_descriptors() returns RX descriptors to the DMA
>> without restoring their buffer addresses. On DWMAC4, the DMA will
>> therefore consider a descriptor for the application as one for the DMA.
>> This can lead to illegal access from the DMA anywhere.
>> On STM32MP21 the DMA address bus is 40 bits, thus the extended status from the
>> write-back descriptor is read as an high address by the DMA. DMA will then try
>> to write in the DDR at 0x100000000 whereas on STM32MP215f-dk DDR is only 2Gb
>> from 0x8000 0000 to 0xffff ffff and nothing is mapped at 0x100000000.
>> All the other SoCs of the STM32MP1x or STM32MP2x are using a GMAC with a 32bits
>> DMA address, so I do not have illegal attemps.
>>
>> To fix this, I propose to reconstruct the RX descriptors that have been used by
>> the DMA but not forwarded to the NAPI function stmmac_rx() before suspend.
>>
>> I'm not used to this driver especially the xsk management and zero copy part.
>> Since this driver is used by a lot of plateforms I'm open to all suggestions.
>>
>> This V1 propose to reuse stmmac_init_rx_buffers() but maybe using
>> stmmac_refill() would better fit the issue. From what I read, I could not call
>> stmmac_refill() as rx_q->cur_rx is only updated in stmmac_rx(), so
>> stmmac_rx_dirty() returns 0.
> 
> 
> 

Hi Maxime

> Thanks for the series :) However it looks like this is already being 
 > addressed by
> Ding Hui's series (currently in V5) :
>
> https://lore.kernel.org/r/20261025100636.613670-1-dinghui1111@163.com
>
> Can you take a look and maybe provide some reviews/tested-by tags ?

Thanks, for the sharing. I guess I'm not the first to have the issue :)

At first glance, the v5 seems really close to the solution I proposed 
(update init descriptor function to factorize some code so it can be 
used during resume to reconstruct the descriptors that have been used by 
the GMAC DMA).

I'll take a closer look at the series, I'll try to test on 
STM32MP215F-DK but I'm not sure of what I can do.

Do you think, this patch is a candidate for LTS ?

Regards,

Thomas


