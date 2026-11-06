Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=67.231.157.127
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793965641;
	b=og+fsDCrs5CUV61QJ57KhU/sXvXcr8B4dkve+oJSMuP6B02Qk5qv70A/swSKr8MXG49Z
	 QOd1n6aMwoBNoPnBIcCTE68rH3aWdTB3azCtBfJi4NckEthNkRu/2U961e3eerDnpQ/Rr
	 GTgwD79RJt/WMctAkccl78n9bRffdtTZ4xYaDDdB6tKmJhLEgkfC3JTddnhXJrh9ilcLZ
	 9Zpp9T+M2dSsYViTrI9tEc3NqZyacj+rJU/lDy4sIRLuI4ne6v6UDCbOrqBtkUe/D0Xft
	 k9sMcidjErIgw9YIeztX64VmQ6vxQGqh7TJ3CbwL8fjcPLSTRkbesC0PdylYrgd4ltw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965641;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:x-exchange-routingpolicychecked:
	 x-ms-exchange-crosstenant-authas:x-ms-exchange-crosstenant-authsource:
	 x-ms-exchange-crosstenant-network-message-id:
	 x-ms-exchange-crosstenant-originalarrivaltime:
	 x-ms-exchange-crosstenant-fromentityheader:
	 x-ms-exchange-crosstenant-id:x-ms-exchange-crosstenant-mailboxtype:
	 x-ms-exchange-crosstenant-userprincipalname:
	 x-ms-exchange-transport-crosstenantheadersstamped:Content-Type:
	 MIME-Version:X-OriginatorOrg:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CNIpzYRNuUBiypK7N0RS6f3aTKCZ3QfKzmyOKYo+QoQ=;
	b=Z2HcrT3EgbdBHkjBZIai8NgkhrTkkw0HYX8TFLO5bJsU6WNVcICtcJY00NXO5FwyoGDG
	 +U+7lqAGQJbFk8K7NuEHgvRnl75Cgh2pPeG5Sp4VEJV/GeNq8h0dpwSGVGK+ei8Oa9Jiw
	 2xNFeeHV6ktT5XjPD7AQjzkRkp9BME8pTzJy2rPDYLd752ruFvHtpntCLQrPTme6Hv2kC
	 yBeKEJNMEXsJlKzH2zeEwkyDoT01RrMHn8r3xAgrm+WbgBRoh3YrtfFHg9EBNqnPc2Vqc
	 hP+rkDEtRhboTSAo9WA25Wc7ORk7vHoIIBxMZnX81WsjDYNk/S8YbMl71dW7ywPg1EA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=akamai.com;
	spf=pass smtp.mailfrom=akamai.com;
	dkim=pass header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b=Qt1MUxcG;
	arc=fail smtp.remote-ip=67.231.157.127
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC9A606A923;
	Fri,  6 Nov 2026 11:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC9A606A923
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=akamai.com header.i=@akamai.com header.a=rsa-sha256 header.s=apr2026.eng header.b=Qt1MUxcG
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A64orWZ2990674;
	Fri, 6 Nov 2026 11:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=CNIpzYRNuUBiypK7N0RS6f
	3aTKCZ3QfKzmyOKYo+QoQ=; b=Qt1MUxcGTwyrrBzT1utP31roQQxiSxK7bO3qTE
	vjo0eMT8IEZvpXrlthZC03/IbqAr7W8Qdep830UgrJZr21t2veM12rEGEjsJ5zao
	sWPAR+v56TG/GW9RCLylLsU3oE2wKromXq4/jnn/rMgpLM1tnlHelzT3K9Sj51D3
	E2auwMcFWotaNdVzB6C5fXT6dbNeaPGUvdH2pgLztVbFywtcZUAgZKwfG/YlLAdw
	rsPXsG4LY2Fanr6G0UubzsZZYC3VJoOQPwPM9dHcko3ZPZDnJ6RHBzLc2FoosezS
	I0gI+kmH+Oz+NBBrqDuvlHTfWwNmY+7EvSBII8zya7jX5qjw==
Received: from prod-mail-ppoint8 (a72-247-45-34.deploy.static.akamaitechnologies.com [72.247.45.34] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4hrey5909h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:46:56 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint8.akamai.com [127.0.0.1])
	by prod-mail-ppoint8.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 6A6BZeCv027594;
	Fri, 6 Nov 2026 06:46:55 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.221])
	by prod-mail-ppoint8.akamai.com (PPS) with ESMTPS id 4hs3un4crp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 06:46:54 -0500 (EST)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 6 Nov 2026 03:46:54 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 6 Nov 2026 03:46:53 -0800
Received: from CY3PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 6 Nov 2026 05:46:53 -0600
Received: from SA0PR17MB4425.namprd17.prod.outlook.com (2603:10b6:806:e9::9)
 by SA1PR17MB5586.namprd17.prod.outlook.com (2603:10b6:806:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:46:51 +0000
Received: from SA0PR17MB4425.namprd17.prod.outlook.com
 ([fe80::c1e6:e808:82f7:1edb]) by SA0PR17MB4425.namprd17.prod.outlook.com
 ([fe80::c1e6:e808:82f7:1edb%5]) with mapi id 15.21.0592.007; Fri, 6 Nov 2026
 11:46:51 +0000
From: "Boone, Max" <mboone@akamai.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        David Ahern
	<dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
        Justin Iurman
	<justin.iurman@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
CC: Donald Sharp <sharpd@nvidia.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Banerjee, Debabrata" <dbanerje@akamai.com>,
        "Hudson, Nick"
	<nhudson@akamai.com>
Subject: Re: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
Thread-Topic: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
Thread-Index: AQHdbeO6L5qbSp20SUOxk5pJVhlkHbcg7TEA
Date: Fri, 6 Nov 2026 11:46:51 +0000
Message-ID: <4D64C0AF-BB65-4EE6-85A7-27C6FD3B25A6@akamai.com>
References: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
In-Reply-To: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=akamai.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4425:EE_|SA1PR17MB5586:EE_
x-ms-office365-filtering-correlation-id: 5c627789-1bca-45f8-37f2-08df3bfba5b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6049299003|7416014|18002099003|22082099003|6133799003|10067099003|3023799007|4053099003|38070700021|261102123227099003|261028144727099003|261026140227099003|261021135927099003|261021121427099003|261021123027099003|261022075727099003|261022105027099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info: O+Jvlk04teebwcHqAmOYZU/qUMVDJfz5/X9W2Vtwrrhlbg4ThDtyLDzMdT4tnjCfc1aFB0TPc7ZoWzPB09ibsJUOVhkfJIf3FxnqwvbIB6J9MM+3gym90ikLcZ+OTLPqzYAR19G0m5GtM0Wo5bEZciq/YJT2uFob6tVVmUo+/cdHan8PkFAYpIV1BZgvnzGbfLBtNJgpOXL3/MGMuoP0yV82TUncnSDYaU2D0Dy56Qw1T5zzr7oebSZIdGYM4hFZck1iwMyO+gx442jnUR7Mz9yaRFv5WrVz2B+nRBhtlu5ytWP1WXikT8gRc42Zw+hrpz/7Rvbm2mpDlJ0uvFu1k7tojPYGySXoLRFdhcTGTiMODVEatDhTOezb9q0Bm5eLT0VcwqYlo8SjaStmGYlPdvQahBObykUIup724hYKVoog9tOJPYoi7wbdewcDwwHEu/UQWCHoN0FKtHsOqh6LNqsEmNGPm8jeNfmXsRO8zIE2ZosgBivnBg0BKYR37dH1itlKeqEFZBETqYP9CG5y4s13c611pNQ6UGrM3MPKvRASyHZmYOccVwQcqh+Lck2C/BAMx1fHFRhq6LfWTOJAbxP9kmKYs0q4AR6MIX0rkcShcCpawufl1UP8a2LngQqL2rknQRGFCkmNph2E6O/STOjH8jhZRgcC9LFcJWJPZ52Kr0RbgzmnhbrD0BIhGNWnoed9iU6WyWexEXP5SQavafMnhOaKbEJvzU2lOafC13Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR17MB4425.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6049299003)(7416014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(4053099003)(38070700021)(261102123227099003)(261028144727099003)(261026140227099003)(261021135927099003)(261021121427099003)(261021123027099003)(261022075727099003)(261022105027099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVVSVHRqdFFoOEVkMnRSdTkyN0tCZXFWc0hFd2N5NGpBendnejJocU9UVXhk?=
 =?utf-8?B?MmYzbnd3ckU2UXVPVGU3bXV3aTFYSWVCT2FOblJaakkzRUM1MW9jczdFcU5q?=
 =?utf-8?B?UERqVlRpNmRUUU1aay9kVGdPckE2K1IwMEZKWGFNSjFmWEowVjFvbkRSaHhK?=
 =?utf-8?B?SXpzb3lLVXFkdlNqckc5OWVyMGhnTDRpcVRjWHZtTGYycXBzM1hQdjUvUGRl?=
 =?utf-8?B?MWc4OE95TFdlSUlsTERqWDZYZmE3eGhPY0IxU0dpUVE5VjJTemNnZmdTVkY0?=
 =?utf-8?B?a3pyZGtRdmZWR0NXYlg5VDhCZi9sRU96amNBVFowdXV0OUtsQ092SUx1RlBM?=
 =?utf-8?B?Wnkzdkl4dHQ0N0VOcXIyUTBrNlZhSlRqOEFiUTJrT3NCdEJOdmdzNkJQOEZs?=
 =?utf-8?B?a2xVNzI1YlcyUXBJSlkvUGk1ZTBudHNIUWcvblhSUllGZldXMEdUb0Fydmw4?=
 =?utf-8?B?NVFoVUJKSW1FcitEaGRkMlREdWc3aisrUEVjclhCMGVwSVhjZGJpNjR0Qmo2?=
 =?utf-8?B?NUh1dC84V2FmY1VqTVE1ZUJsY1hXNEYrVmxkMUtVS3pmaGVwNDBZeXFRRTlp?=
 =?utf-8?B?a01EYnpaMGoxMHdra2JoQ1ZxZ2N3cW9qU3BNMDFsODBvdzFmUWhGOTg2TEty?=
 =?utf-8?B?Z25qZUxVRGJHdUNnY2s0OENUVDhFcjV5N0R3eUk1S01zcUpOL29qcGlIVXJp?=
 =?utf-8?B?WUFwSnV6LzkyczF1ZkRtV1k1c2UwS09NWi9MVzB6T0t2TmtBLzU0TkprelFD?=
 =?utf-8?B?Q2N0cGRRZzk0L3MyeXQ1a2JxQ1J0aGJmQUVYa2F0bnIrMDZmTnEyUVE4T3VN?=
 =?utf-8?B?V0NCWmJaZUhSRUZDNWRtZ0RuT2J5R2tuSUg1MXA5QW1tekdyc1hsYkh1bE1I?=
 =?utf-8?B?RGx4MW9UcXk4bC9WUzR5QnkwblFkWmNGWWNQKzFaSDNoT0s2Z2tteG9wa1kz?=
 =?utf-8?B?SmtOckxBQ3BmOWFQQzdTejBlYnVQbWkwdUJoM1BDMkU0d3BmMnVWVVN2SmJx?=
 =?utf-8?B?OWdaQjUyOE13R0tWT0c2WnlNbzZHdnAzbVI2a1FCMVJpek5ReTAvdXlUaExw?=
 =?utf-8?B?bUJGckVPQ3kyZFlTYSszWHB2eGlVU1h4VlVOdnJxS1pFV0x1TXQxbVJ4eVZP?=
 =?utf-8?B?b0dEcE9xczlQNGxETEI5SHJ0c0xyZXpwWGZUNXhJdXFGbDczYkEzNXdQSVZP?=
 =?utf-8?B?R0pBS0ZtSnZRdGxTdlZEZk9RSkZFV1VEdjlydFNjTUw1Y0FKSjdaNnFDRkpw?=
 =?utf-8?B?RjdZcEFoaTR0UC92U0hCb1QwZzVSTHZJVU16R205WWxCTG5QTi9taHR4K1kv?=
 =?utf-8?B?SFBrTmtOdjJRZWdJdklRR1Z3aERIdkZTcmtYREZranJ6UUZvUHFtZmhoUTRa?=
 =?utf-8?B?ZzZ0WEN0cmc0M0xDbmR6MGcvNmdwUHo0aHBKWnhMRTVlOVE4dWVrYkhSajEx?=
 =?utf-8?B?YUdmd1hmRXdYcEtqNXdQbFRyQzZsNmp3TXorUk5PYjJET1NqUjYvM3BKeWtD?=
 =?utf-8?B?VmtXMm90WitSU3cvTUxUR285d2dneDdOTnNmckZRb2gvN0UzWUVuSG4yNWhl?=
 =?utf-8?B?Q1M4N0hnTEFLbTF2ZmVOR2JSZUkxaEV4YVpzQ3RrNmU2SEZwMzdFWGRBbTQv?=
 =?utf-8?B?alUzcDhVVnVrYjJIUnZhbFVkaGxaaUNIZGpYS1k1U0hLQml4RjFvU2tTWGZD?=
 =?utf-8?B?eGg1OEFxVlNlcXJ2eTMydGJ0MDFWaUc3eXh1dU10Ym9RUUR2K3A0L2FYWEl1?=
 =?utf-8?B?ekNJZ0ZRQnZpdkdrbFk1d0RMclF0eHdvSllPTU12WUxjUjJPRjRUQnU3RmFq?=
 =?utf-8?B?WFdad2xHZndWYUZnY2oydWcxMXNkWVZkeFp0T2tCMkRjek82Q0F6SnY5elBp?=
 =?utf-8?B?aUFma0ZESStvR0diVFk1bkMzZnlNTm1mNmtML0VXNzdwTnFjY3MrbHZIWlBu?=
 =?utf-8?B?RDhvcEQyM241WWVOUE43eHhlNGZaN1ZRbzdueklwYzlnKzVIMkFUbW1ZejJw?=
 =?utf-8?B?NzZwYnlNR1B1RFQ0VG9OOGdxL0luTHRaMnNZemlYaGVZdW1wRjd1NllMcXkv?=
 =?utf-8?B?VWxoTjVmSy9QK3lxTFlxTHhoRWswMHhSZXM4Q1Njc2g5ZDBGWUdUWjY1SjZH?=
 =?utf-8?B?bEtoS3VEelBPNDd6ZlphaDZuRXUvUHJvVWlMNEQrOC85RUJ2MExBck9TeEhp?=
 =?utf-8?B?ZjVpcC96VlU2bmJ1MEwvUTVoNVlVelRxd2JLMjRPR3ljSDljc2NvS1RTMVpQ?=
 =?utf-8?B?SlNrNjVQRG5rMWVaSkNXdC9TLy90TWhaYjU1d0xML1RCa3cvUkN6L3RLUHNp?=
 =?utf-8?Q?7qTCu+6sIJatVtKWbX?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbD9kYmKtsiNQQEavANx2sGhIVMrt5jRZ29EiqpxCflrwz5TW/G6FqVK4fSNDnJVAOCB7o5JsA0J214HpUxfan3qscHSdk/4g7tPbLspSGVaGbZB4z3yEv7n5E7n/+YHdG2gJeO+vvvTpLBLoGAMQ215/3AR8NQP+YxvLdalzPWQO/WIWRfxMGp1zoYuGwEJEKdzj24lIsvjACvED/Z47AId0HeIAKQXcsA5eaykAMXYwM5E88iDdyMOOwf1ax70ciKlSZ4eKlCvEYpoELR8tZxHK6laQIEpCUH2V9n12XwuLr4uAPTFJABUYQ+EIwoFlofdHOt3z99lvSUt4ApI5A==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeDVnAWw9U7RJXGrggpa96pDjo6SMxiLVuvjD1v9nbY=;
 b=KpSeVRG3iK6t6w76r/c8wC0Tq87P6Y7Km9d1t5Vsq6rvfeZvXuZ45tO4m7KvRFclqYQjHvvjqkXk7q6X2/OkGX1sw5QGOAx9lZDY10YiBHDWGdKb4o0RNsSGN9RcoLQAUn+H5Eb0NVfgFyvv5w3QtOtgmgfktq4o+UluODrOYrnGgjF3vRIQXDMgmtEB2uA3kvrIKffSRvZ8KfFoqP+PqDZ9/FKtk++vXwoDNeBBVMTf1CJpWMZYq9wlG9YN1YP57GysK65kV402XLCbsT6WrnKNM1p6egADBDmyfgwKK24VRpNXtdJMeMzPJE23pUJqjjrWL0n3SywXntS8BMR4pg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: fdOr8mPSp3Kf2hxIwQH5vzMk+gJIQWqHf1VCODdiMs1lK13edoaPt8o445VPsLTpYE7h1Z+RxEVahsg9fysQkji9f7BD6D5jn4zppYNDFxCCulB5L3W3a7yRhQ8kZO4jmptGqYoYoCn2vqmY6sQz5u5nGa+4/7hTkEN91CItPt92mjhzOYSQsiR46p74n5sAgGdsushkCItVxJEspkabFeCBA+Km8DoXNs+WOhj+WFYR/7T59/9gYDDi8egz9HHYiMGVQS4aCEF69iRlubV4YABDSGxkWDQTQZfCMGU69kDbVxzFNnA3mjtnHjWCCtyF5zMZePiVfrtKG89Ii/AzVQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4425.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 5c627789-1bca-45f8-37f2-08df3bfba5b0
x-ms-exchange-crosstenant-originalarrivaltime: 06 Nov 2026 11:46:51.2019 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: pF7021RMYiI5Y/y7Pig1XmBr3Ugh4rHioJDZoJZ9bXxbK9NQfwnhsZ5dz0yssldV0VorIivUfML/sW2HsW+aGA==
x-ms-exchange-transport-crosstenantheadersstamped: SA1PR17MB5586
Content-Type: multipart/signed;
	boundary="Apple-Mail=_462A6295-1095-473B-9E12-2C480CD822E3";
	protocol="application/pkcs7-signature"; micalg=sha-256
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2611040000
 definitions=main-2611060046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX9PpeCbcsNFQ9
 mG9YrRD0ZtT2zyjDmGExcPgKGwi84AinSUjLdw/e2NJjppP6x/LqVg18p729iN6ks4TXqL4WuAX
 D1cPfvg90EYcLLDftRAPR9zSa0K/1k3VZXON3prRlrhBf7BHPsir7giG2fg4iiusxNDfpO/U2RS
 h8MbAJ2116v4qiexkDnim5nTDO/zECflMMS/bTjOialhPd9u0LRDGakThHwwJBkOOUhhuscysO5
 wBijtGaWuBd0Oarj9jc71LDwj4teOTXdBa2zHVA6WTDLv5FrNHx+tnDFL6rHZ94q8B85G1CN/q9
 AeLQsb3yDFF7ao8Yi4yEiY8PrgMWMcBTvTrDGfmmQ0DYD04CF9mPW8VVHTAMaVbAVbqDcVRc9D8
 vtjklCkjmSAu0eqml2FGevnB+CGXnfLTpl77B3DfrUAaSS5+/e7RKZbGAZRC2YYhWU0LZ6gyxom
 pFMbv1NPIyqd2M+DSyg==
X-Authority-Analysis: v=2.4 cv=Q/NHcI2a c=1 sm=1 tr=0 ts=6aedbe31 cx=c_pps
 a=YfDTZII5gR69fLX6qI1EXA==:117 a=YfDTZII5gR69fLX6qI1EXA==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=VcQvXEo1OZcA_IiPcy3B:22
 a=X7Ea-ya5AAAA:8 a=V4VkV9ZmlyihwH-8zJsA:9 a=QEXdDO2ut3YA:10
 a=sn4RexjSgPGoxUB2B5YA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-GUID: wVLA3EBS30mJjvlTvTY8Ujwf50YzOhFR
X-Proofpoint-ORIG-GUID: wVLA3EBS30mJjvlTvTY8Ujwf50YzOhFR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NiBTYWx0ZWRfX6SOrhIW2Ow0J
 fD5zzhwErSeGZTxzK7NU6HpbL/2olJSiqTWeukeVosWkLionwC1rbNyFUwJJg/RIgMW9m0pF3C/
 0AWLhRuWFOhCHH0YBH75j279y+dbRiw=
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11957
 signatures=596817
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060046

--Apple-Mail=_462A6295-1095-473B-9E12-2C480CD822E3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Ran on a VM with 4 vCPUs, CONFIG_PROVE_LOCKING, CONFIG_PROVE_RCU
and CONFIG_DEBUG_ATOMIC_SLEEP and iproute2 5.15.0.

Lockdep before test:

    lock-classes:                          784 [max: 8192]
    debug_locks:                             1

Commands ran:

  ip link add lwt0 type dummy
  ip link set lwt0 up
  ip -6 addr add fc00::1/64 dev lwt0 nodad
  ip addr add 192.0.2.1/24 dev lwt0

  # ip6_route_add -> fib6_nh_init -> seg6_build_state
  ip -6 route add fc00:1::/64 encap seg6 mode encap \
      segs fc00:ffff::2,fc00:ffff::3 dev lwt0

  # fib_create_info -> fib_nh_init -> seg6_build_state
  ip route add 198.51.100.0/24 encap seg6 mode encap \
      segs fc00:ffff::2,fc00:ffff::3 dev lwt0

  # ip6_route_multipath_add
  ip -6 route add fc00:2::/64 \
      nexthop via fc00::2 encap seg6 mode encap segs fc00:ffff::4 dev =
lwt0 \
      nexthop via fc00::3 encap seg6 mode encap segs fc00:ffff::5 dev =
lwt0

  # fib_table_delete -> fib_nh_match -> fib_encap_match
  ip route del 198.51.100.0/24 encap seg6 mode encap \
      segs fc00:ffff::2,fc00:ffff::3 dev lwt0

  # rtm_new_nexthop -> nh_create_ipv4 -> fib_nh_init -> seg6_build_state
  ip nexthop add id 1 encap seg6 mode encap \
      segs fc00:ffff::2,fc00:ffff::3 dev lwt0
  ip route add 203.0.113.0/24 nhid 1

  # rtm_new_nexthop -> nh_create_ipv6 -> fib6_nh_init -> =
seg6_build_state
  ip -6 nexthop add id 2 encap seg6 mode encap \
      segs fc00:ffff::2,fc00:ffff::3 dev lwt0
  ip -6 route add fc00:3::/64 nhid 2

All commands succeeded:

    # ip nexthop show
    id 1  encap seg6 mode encap segs 2 [ fc00:ffff::2 fc00:ffff::3 ] dev =
lwt0 scope host
    id 2  encap seg6 mode encap segs 2 [ fc00:ffff::2 fc00:ffff::3 ] dev =
lwt0 scope link
    # ip -6 route show
    fc00::/64 dev lwt0 proto kernel metric 256 pref medium
    fc00:1::/64  encap seg6 mode encap segs 2 [ fc00:ffff::2 =
fc00:ffff::3 ] dev lwt0 metric 1024 pref medium
    fc00:2::/64 metric 1024 pref medium
            nexthop  encap seg6 mode encap segs 1 [ fc00:ffff::4 ] via =
fc00::2 dev lwt0 weight 1
            nexthop  encap seg6 mode encap segs 1 [ fc00:ffff::5 ] via =
fc00::3 dev lwt0 weight 1
    fc00:3::/64 nhid 2  encap seg6 mode encap segs 2 [ fc00:ffff::2 =
fc00:ffff::3 ] dev lwt0 metric 1024 pref medium
    fe80::/64 dev lwt0 proto kernel metric 256 pref medium

Burst test:

  seq 3 20002 | sed "s/.*/nexthop add id & encap seg6 mode encap \
      segs fc00:ffff::2 dev lwt0/" > /tmp/batch
  ip -6 -force -batch /tmp/batch

    nexthops present: 20002 (expected 20002), ENOMEM failures: 0

Kernel messages grep for RCU splats:

  dmesg | grep -E 'BUG: sleeping function|suspicious RCU usage|Illegal
      context switch|possible circular locking|inconsistent lock
      state|WARNING:|BUG:|percpu: allocation failed'

    (no matches)

Lockdep state after test:

    debug_locks:                             1

Reran the same test with rcu_read_lock() around ops->build_state() in
lwtunnel_build_state().

First "ip -6 route add" triggered "suspicious RCU usage=E2=80=9D and a =
sleeping
function from invalid context BUG from seg6_build_state -> __kmalloc,
debug_locks dropped to 0.

> On Nov 6, 2026, at 12:40=E2=80=AFPM, Max Boone <mboone@akamai.com> =
wrote:
>=20
> Since 3d25eabbbf67 ("ip_tunnel: Add dst_cache support in =
lwtunnel_state
> of ip tunnel"), build_state runs outside RCU and all its callers can
> sleep, but paths still use GFP_ATOMIC.
>=20
> For dst caches, that limits allocation to populated percpu pages. A
> large burst of SRv6 nexthops outruns the refill worker and will fail
> with -ENOMEM despite there being free memory:
>=20
>  percpu: allocation failed, size=3D40 align=3D8 atomic=3D1, atomic =
alloc
> failed, no space left
>=20
> Batching 20000 RTM_NEWNEXTHOP under QEMU gave 10-109 failures per run
> before, none after.
>=20
> This commit converts the allocations reached through =
ops->build_state()
> and are called after the rcu_read_unlock():
>=20
>  - ila_build_state(), ioam6_build_state(), rpl_build_state(),
>    seg6_build_state(): build_state ops
>  - bpf_parse_prog(): only called from bpf_build_state()
>  - lwtunnel_state_alloc(): only called from build_state ops (also
>    affects mpls, ip/ip6 tunnel, xfrmi and seg6_local)
>=20
> Signed-off-by: Max Boone <mboone@akamai.com>
> Reviewed-by: Debabrata Banerjee <dbanerje@akamai.com>
> Reviewed-by: Nick Hudson <nhudson@akamai.com>
> ---
> net/core/lwt_bpf.c        | 2 +-
> net/core/lwtunnel.c       | 2 +-
> net/ipv6/ila/ila_lwt.c    | 2 +-
> net/ipv6/ioam6_iptunnel.c | 2 +-
> net/ipv6/rpl_iptunnel.c   | 2 +-
> net/ipv6/seg6_iptunnel.c  | 4 ++--
> 6 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
> index da49364ec63d..6d1059ff0c49 100644
> --- a/net/core/lwt_bpf.c
> +++ b/net/core/lwt_bpf.c
> @@ -359,7 +359,7 @@ static int bpf_parse_prog(struct nlattr *attr, =
struct bpf_lwt_prog *prog,
> if (!tb[LWT_BPF_PROG_FD] || !tb[LWT_BPF_PROG_NAME])
> return -EINVAL;
>=20
> - prog->name =3D nla_memdup(tb[LWT_BPF_PROG_NAME], GFP_ATOMIC);
> + prog->name =3D nla_memdup(tb[LWT_BPF_PROG_NAME], GFP_KERNEL);
> if (!prog->name)
> return -ENOMEM;
>=20
> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index 8223c44f10c8..f2f4d1ace0e9 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -70,7 +70,7 @@ struct lwtunnel_state *lwtunnel_state_alloc(int =
encap_len)
> {
> struct lwtunnel_state *lws;
>=20
> - lws =3D kzalloc(sizeof(*lws) + encap_len, GFP_ATOMIC);
> + lws =3D kzalloc(sizeof(*lws) + encap_len, GFP_KERNEL);
>=20
> return lws;
> }
> diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
> index 7bb9edc5c28c..01fd78a232e7 100644
> --- a/net/ipv6/ila/ila_lwt.c
> +++ b/net/ipv6/ila/ila_lwt.c
> @@ -228,7 +228,7 @@ static int ila_build_state(struct net *net, struct =
nlattr *nla,
> return -ENOMEM;
>=20
> ilwt =3D ila_lwt_lwtunnel(newts);
> - ret =3D dst_cache_init(&ilwt->dst_cache, GFP_ATOMIC);
> + ret =3D dst_cache_init(&ilwt->dst_cache, GFP_KERNEL);
> if (ret) {
> kfree(newts);
> return ret;
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index cfb2c41634a0..3093446ad89a 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -166,7 +166,7 @@ static int ioam6_build_state(struct net *net, =
struct nlattr *nla,
> return -ENOMEM;
>=20
> ilwt =3D ioam6_lwt_state(lwt);
> - err =3D dst_cache_init(&ilwt->cache, GFP_ATOMIC);
> + err =3D dst_cache_init(&ilwt->cache, GFP_KERNEL);
> if (err)
> goto free_lwt;
>=20
> diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
> index 4e10adcd70e8..838ede10a79d 100644
> --- a/net/ipv6/rpl_iptunnel.c
> +++ b/net/ipv6/rpl_iptunnel.c
> @@ -102,7 +102,7 @@ static int rpl_build_state(struct net *net, struct =
nlattr *nla,
>=20
> rlwt =3D rpl_lwt_lwtunnel(newts);
>=20
> - err =3D dst_cache_init(&rlwt->cache, GFP_ATOMIC);
> + err =3D dst_cache_init(&rlwt->cache, GFP_KERNEL);
> if (err) {
> kfree(newts);
> return err;
> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
> index 0d39a38a5dd2..7c64680e4632 100644
> --- a/net/ipv6/seg6_iptunnel.c
> +++ b/net/ipv6/seg6_iptunnel.c
> @@ -833,11 +833,11 @@ static int seg6_build_state(struct net *net, =
struct nlattr *nla,
>=20
> slwt =3D seg6_lwt_lwtunnel(newts);
>=20
> - err =3D dst_cache_init(&slwt->cache_input, GFP_ATOMIC);
> + err =3D dst_cache_init(&slwt->cache_input, GFP_KERNEL);
> if (err)
> goto err_free_newts;
>=20
> - err =3D dst_cache_init(&slwt->cache_output, GFP_ATOMIC);
> + err =3D dst_cache_init(&slwt->cache_output, GFP_KERNEL);
> if (err)
> goto err_destroy_input;
>=20
>=20
> ---
> base-commit: 0822d2fe38262e8b55c5ea55c970022bca8dd2a9
> change-id: 20261105-build-state-use-gfp-kernel-c3598d190bfb
>=20
> Best regards,
> --=20
> Max Boone <mboone@akamai.com>
>=20


--Apple-Mail=_462A6295-1095-473B-9E12-2C480CD822E3
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCcow
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFITCCBMig
AwIBAgITFwALOJfLRtbGzZc1dwABAAs4lzAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI1MDgyODA3NTYy
OVoXDTI3MDgyODA3NTYyOVowTjEZMBcGA1UECxMQTWFjQm9vayBQcm8tNDZZVDEPMA0GA1UEAxMG
bWJvb25lMSAwHgYJKoZIhvcNAQkBFhFtYm9vbmVAYWthbWFpLmNvbTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAOX+npfSrX/rwhOySq6aejQMUVslPFpNvXdEnmMlnEjR95gq0Ygp+wQc
Sde+JGBpGHsPMzHT1Nd3V1acm4cW1WB1aRqJOMfSLifg6SLkq2EM9WsftEiA1G4BT4UP0PFZY2Os
6TXvebAuVg6LwhB417rEJ2kuS/DKpiG8trAVDR6Uy9vbSMBp6iIewBc9r0CjW8l1zgRr+uQpXEUP
mF2BV0l3Qo5r0nhPqTWR9oAX4/oTqnhbEhQ3tOFYTjzO1K9DdzX8mVggVSZz/M0v0gtkZVvO4B1t
3Sh+1lla5eMY4hlVHW1/FKqMe4EMXmDH7goTEuXPpelJiNRdBh7ud7xNNFUCAwEAAaOCAsowggLG
MAsGA1UdDwQEAwIHgDApBgNVHSUEIjAgBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcKAwQw
HQYDVR0OBBYEFO0y/xWMpkyOUMuNKmuzNtjXpdtRMEQGA1UdEQQ9MDugJgYKKwYBBAGCNxQCA6AY
DBZtYm9vbmVAY29ycC5ha2FtYWkuY29tgRFtYm9vbmVAYWthbWFpLmNvbTAfBgNVHSMEGDAWgBS2
N+ieDVUAjPmykf1ahsljEXmtXDCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2FrYW1haWNybC5h
a2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybIY8aHR0cDovL2FrYW1haWNybC5kZncwMS5j
b3JwLmFrYW1haS5jb20vQWthbWFpQ2xpZW50Q0EoMSkuY3JsMIHIBggrBgEFBQcBAQSBuzCBuDA9
BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEp
LmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFrYW1haS5jb20v
QWthbWFpQ2xpZW50Q0EoMSkuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFpb2NzcC5ha2Ft
YWkuY29tL29jc3AwOwYJKwYBBAGCNxUHBC4wLAYkKwYBBAGCNxUIgs7lOoe41C2BhYsHouMhhtIP
gUmFpcMQmtV/AgFkAgFTMDUGCSsGAQQBgjcVCgQoMCYwCgYIKwYBBQUHAwIwCgYIKwYBBQUHAwQw
DAYKKwYBBAGCNwoDBDBEBgkqhkiG9w0BCQ8ENzA1MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0D
BAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcwCgYIKoZIzj0EAwIDRwAwRAIgD5UL4MI1RXeg64RR
kifZAeItCnkZ4ecrqSEGpLcXV+ICIAdB9vZdM1WGxtag0rlqG0j0FBrCWixC0cdHNpFrqNx/MYIB
6TCCAeUCAQEwUzA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMT
DkFrYW1haUNsaWVudENBAhMXAAs4l8tG1sbNlzV3AAEACziXMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYxMTA2MTE0NjQwWjAvBgkq
hkiG9w0BCQQxIgQghewZJ/ME4IjcFSbMYg2TnOyKruXLc3dbEAhkhJ0ubX8wDQYJKoZIhvcNAQEL
BQAEggEAcs0pt52gqpZVh8wIlavSdvlYK592SAB0Faym0jJuUrfaIkwyO7eoZhwJmgNIMFSUIAJa
X9zJRQyJ0w/YQXmJplwwB39TY/Mm8luRiEllRNwY7Cn8mZMfuah2mJBxqURhd2CMFG9w9KTyRVQe
zLLEozE9co2gBjeX16FS90S9lYikVjpmT8NV25w4h8oiLHeddyEQeafb+bn1+GJFO7X/vAkK+jAy
0/0ySsobfTnDwWVDguTBviLnmKgQdlfMMO2RWqFt4lghL0ev/HMaQF0kKfLK4KhCeY+NJu/7XmB+
oZStCkDOgzt0TcudBNpX1nlk9r16Qfv5elgvOk9/d40S6wAAAAAAAA==

--Apple-Mail=_462A6295-1095-473B-9E12-2C480CD822E3--
