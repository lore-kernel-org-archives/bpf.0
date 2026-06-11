Received: from refb.tmes.trendmicro.com (refb.tmes.trendmicro.com [18.208.22.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC0314A9E
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.208.22.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207998; cv=fail; b=ai6lJtNKTSa0yHWuXdDRWH+a8SqP4mQG80+aQpDsA2Cw2PT7cBd9N45skX7RAUmiOLUmCnjBFy8AjNGI47Ds6pUgD24lhPP2urZBHoFD8woLQLjGL5rvHfeuvH7tSEDi1uQr2+mjOss2jjD1dXrq5HwPYRqmVpBlFZ7lPLH2YPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207998; c=relaxed/simple;
	bh=tgh2AxLKjfUVemX+CHOBzEaKe6AoO0Q6kfyDagkVU/8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Jf/i6liFWtIIVZn1zX+Mmb0Hjd6ztCp+tlHiv6NNL6ti3cD83DgyFuxrvrUQ+MtMCBTp7yu8AXMpnUVFoc1UGXwZpYwPxTufzgvkSMJt7yWTDN88KHpYoFohO8y59Q/3S/PQ1JBzNiHpVxggnlxoPTKCGPk+4JIsh2ai/6JBqa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com; spf=pass smtp.mailfrom=trendmicro.com; dkim=pass (2048-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b=AzAaj0av; arc=fail smtp.client-ip=18.208.22.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trendmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trendmicro.com header.i=@trendmicro.com header.b="AzAaj0av"
Received: from 52.101.201.15_.trendmicro.com (unknown [192.168.27.129])
	by refb.tmes.trendmicro.com (Postfix) with ESMTPS id 9751A109E6152
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:54:56 +0000 (UTC)
Received: from 52.101.201.15_.trendmicro.com (unknown [192.168.181.54])
	by repost01.tmes.trendmicro.com (Postfix) with SMTP id 2160E10000687;
	Thu, 11 Jun 2026 18:54:50 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1781204086.260000
X-TM-MAIL-UUID: d8484a8c-e8b9-41a5-ae01-1f9dd4e2d81e
Received: from PH7PR06CU001.outbound.protection.outlook.com (unknown [52.101.201.15])
	by repre01.tmes.trendmicro.com (Trend Micro Email Security) with ESMTPS id 3FB9D100002E2;
	Thu, 11 Jun 2026 18:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyILqZMs6MoVeVwoc+hMf6JUeXlpgKdTXOwJu8sV4mj3+XqfnGTJgXsTDzRAJJP+Xirq1qDeboXz58oqggGa7cYUqSv94TGjAbMt81lGIPFLg01JA+V8MtSxOLohYfG6BRMJNgcFfwitiiT/4KlClE6OWiBN81KTJysegL21EzTr5G4uHRmkYWbcTRyVJKqDCEqBA2811UKvNtHCS9h4YyD2W88EzAdbRsRASR0pJpyINnS8l61jmfu7RDkhs6EE18/pFxt8d0zqnTXgZSolmHoSPmHaIbTHZegm/7WTuMuDidgsmrSPMaWboQeJUbU03idmHmCoPN4AZvx6s3a9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMvsUwfNiIVQ1L+3UYA5t2IZvMZwRBDoorA0ak2P72k=;
 b=y1S+tLiY4RHoviFR9wm8RvmsZ6sdO3UMqnXAENnk2zvvq0s4t8UOQl4fxvOCW1d0/WwT1vb0KwDjPRTIvrTXw8EpAGtuFH00KyzOWH5hq5AGoR1u3gWsv2LdZs6ygG9G0Odjq0jRBVHjJs44f9RRuAMycuLh/pgCHWxwJmrKzWxtEKGE81FPfRZh/Q2JO6nD09fuasu671LWD+s3pBs5EZWS7wGSNMtV0nZE/SeUas5BNyl2XecCLjNFPeeLgCFszzQayoOiqkiSXfZ5Jwq0sSHuWcelx5qzOJwsA9rVtLN6v/92052k6AfEt5RunV8Qc2CoyQAHpfZ1OfTeiIgx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=trendmicro.com; dmarc=pass action=none
 header.from=trendmicro.com; dkim=pass header.d=trendmicro.com; arc=none
Received: from BYAPR01MB3830.prod.exchangelabs.com (2603:10b6:a02:83::21) by
 CO1PR01MB9083.prod.exchangelabs.com (2603:10b6:303:270::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.14; Thu, 11 Jun 2026 18:54:42 +0000
Received: from BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf]) by BYAPR01MB3830.prod.exchangelabs.com
 ([fe80::29c9:1f31:48fd:8ccf%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 18:54:42 +0000
From: "zdi-disclosures@trendmicro.com" <zdi-disclosures@trendmicro.com>
To: "security@kernel.org" <security@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"memxor@gmail.com" <memxor@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: ZDI-CAN-30691: New Vulnerability Report
Thread-Topic: ZDI-CAN-30691: New Vulnerability Report
Thread-Index: Adz5022OpeETXMZcSeiJCqYJYp8Lug==
Content-Class:
Date: Thu, 11 Jun 2026 18:54:37 +0000
Deferred-Delivery: Thu, 11 Jun 2026 18:54:01 +0000
Message-ID:
 <BYAPR01MB3830504E7213369CA6E82B27801B2@BYAPR01MB3830.prod.exchangelabs.com>
Accept-Language: en-US, es-ES
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ActionId=a8d7c9d1-4f48-4b69-a2ef-5e1d50d88fec;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_ContentBits=0;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Enabled=true;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Method=Privileged;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Name=Public
 Information - no
 protection;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SetDate=2026-06-11T18:52:27Z;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_SiteId=3e04753a-ae5b-42d4-a86d-d6f05460f9e4;MSIP_Label_fb50d67e-2428-41a1-85f0-bee73fd61572_Tag=10,
 0, 1, 1;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR01MB3830:EE_|CO1PR01MB9083:EE_
x-ms-office365-filtering-correlation-id: 0a071f24-26be-4173-ce29-08dec7eae5f5
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6049299003|921020|55112099003|56012099006|6133799003|11063799006|3023799007|38070700021|4053099003|18002099003;
x-microsoft-antispam-message-info:
 lC1eApKAgAvY1JUvvrX12nSUYmbSr1wmx1PWO+h9rIuKozagpRlaKyt2z4QxtL46gaoDpaAKD1kTkFGbzZGGGW7xvy7l1AwHFFZx+K6RjL46ktjScpJCj4rtlmEdj9zbxOvJQ39YpCr8ED5/skngTbIMLMnfnlcuWRnAwjRnuGgQPcAnlx1YhMGzjN2Wk1VTHnWt0H9SC04s1C+B1Mr1KeVkdDahnWw5AajXcDhK0moMKPgpZxTbewZlge9d3Qsz/RwsS2JKOIoHqPkzonR/TqKJTk5vyMh0+5mMm3y1mACrG2NcerFFqSeK+ZNEquRmVpFL4KaBb0QN7Wsf5Jnjxr7CM1G5ocw+TqK4KuKvsolOXrGMHyuSTJ7Qa8/32nu/85NIF0GpNWqLHBAVxHkhtVWY1xjXuds2N0GbmbfVJ+gbMJQeFf2osMXYS+sMq6VdEREfhj93TJUz0chj98AD1vrBs3oUSiUAADNSORRSikybRJ30LRDi/lehl2zSdd31tPQRh88gDE/d/ffad8ZYU1/CHQ9fbGd/Mo2UixLkepjVKsDaVPp2lrG7llhM26B54WCQc6ux4cckx79b5628YZsteLdCYEv2j3cDkQiztr6M1aF7NJynrH6SWAJPffMSevwYjZM4fXd6TGM3b7Fxn3hx5od3uIE5b6gLa1vl42U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB3830.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6049299003)(921020)(55112099003)(56012099006)(6133799003)(11063799006)(3023799007)(38070700021)(4053099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yM3YYLdHdmaHrHs3MtrM9rndVdJhiJlYRjJOb4LHvks6sD2O+RYK4w0gX2yu?=
 =?us-ascii?Q?IDXv2SgPkal9SvHyccnv6NEM3Igg6IxyX6MnJ/UAbzRKp9NYVQpVkOi/YEbW?=
 =?us-ascii?Q?/f7TwZuV2vRHfWIcutzHIFa1RaROL+tMhEbs1w/qXTP4sZbCQVwl8uVfXSAZ?=
 =?us-ascii?Q?xytLBwpKogSfe0sNVpEt4W0gXeLGmws4OIZNxBE+PqO4e6rXLvOvjMWWJHp4?=
 =?us-ascii?Q?t1ULc9/Wo8+WybTE+ytGMKcS276rSu2tlez5XwqSNAPDER9R7iA1PhwhTEOf?=
 =?us-ascii?Q?BQ3hpUnO7uqSQeFP1z1dUjPv0FoHf+QUBbHim/bIxmitc4rr/zkmltIliU1p?=
 =?us-ascii?Q?iCp0btUp/dDHJtyRoajz451HJjtHZTVVyLgYRNH8Te2V0iGFJl7JkywrFCpk?=
 =?us-ascii?Q?ZxCwb/pMyUtU+1cJvfHjmnAGuYpxf4dGtMJlF1hOq/ofZ/nZKMgb7uNbkeoB?=
 =?us-ascii?Q?P7kLLQKePyXYBsu/ybXKP1PAOOOIVnIwUUQXacvNbdXRDy/kmqp6v5YHNiCp?=
 =?us-ascii?Q?8blvLKnnwjn3KTlCog6BL7FOUMlFg8Dqcch4daK6H4w4TEKKp8o7wRTMPB96?=
 =?us-ascii?Q?nRKv86T9mp3vN0KXoTNdfofNX6nvHqxVSS4/DROSxXY/ObveDBxRwEofes81?=
 =?us-ascii?Q?hgbSPlHlFkj4yMbW/NWmE6tiT9FEslL6dc/Cyj6gNvOsXbecCP6tH0ojvau/?=
 =?us-ascii?Q?hJ6F4eNJD8AQWEeN8bPtBmzGChtoHCjCfIy6sO6CFiPid80dXcZ2jdojrYAg?=
 =?us-ascii?Q?LG2s/r87sTe92CwhmkiYrUlsbey3p3zTzL8+3rEPoZE8phmmevQsklJOM6+o?=
 =?us-ascii?Q?fX/xeOE5nHluO3aYK7NeW14zXjajXChLrJU7YhXtZvIbQoqiiwotrtopjbRW?=
 =?us-ascii?Q?pZqrT3XwIsWNgrQyh8ncDs9E+2WPzK2DRSTeUL9Lge+dDWJuL0Uki+7pDExe?=
 =?us-ascii?Q?/jCfgkSZL5LWV5e1zd0DG6vCtuGuQ0BfH8Qkf+DjzCjyj1DRERRBp8uhylDI?=
 =?us-ascii?Q?EDwTZ2i3LHOgCoH4iHbhnxxd37dkDOafxeDubUnDgNw9poQD4g8X5GyySttt?=
 =?us-ascii?Q?VwN5szu4bvM+T9pwh+dSZ7qCC2ksQD/IEmAgmugSaYQEJaIF1EVJ5R+pB4K/?=
 =?us-ascii?Q?w0P5m3ZjvtnGOzwS57YfauRSpunxKji/uPZVFCZyuuCzaJlevcgaOqOv0pb9?=
 =?us-ascii?Q?Fj3TbmpwYZgQgfTXaH7IRbLHMpWsgW37UCBszytf+3s1G4BoKKG/sV5LKlPH?=
 =?us-ascii?Q?zWYT6unIjMNciGHjFzT/TxirUplLzqwBEcbQ+9oclOD3nAAS+arSGHbuUQPV?=
 =?us-ascii?Q?aaUHBt6O8arLeTXrHII0nx4PmMQKZMDut1BfPCsg7KzjU0HUpLV3x5a2VDll?=
 =?us-ascii?Q?jojnXcWouNSu4bILRvCK3OI7dOhsgAOmEe4d9DgQT1dTzMRd8sGprsFxd7v5?=
 =?us-ascii?Q?lpHjyGMly8A/TF9QLhrhB0uj2xev952q8Dz7/3kKhIqTp8PRl4ghH1VWy/p9?=
 =?us-ascii?Q?AvR7h0eH1BGGgBv+fBY10pgay3vH5+oUIh+3Op5YdegNj6hYzAy7qpHHkf20?=
 =?us-ascii?Q?EkMS3BtfzFXy6bYmkgi0PY96jrV4C1f8lj8T+4Ftd6wbEEVoUEZKiR207TwL?=
 =?us-ascii?Q?eFWEq9e4zmATqtV8VqrlIQT7MmmVG4uiAsKCOuoefjqaQ28r+1KWe+Bu70p2?=
 =?us-ascii?Q?4kNF91jfdtiDWT34Orx0qiZKNKxC5/5l0zQ+QjnE+GGqNbk6jOp6DUw1NZjP?=
 =?us-ascii?Q?Ye/28xnveoStS9RPUViWURbJ6TmAlqQ=3D?=
Content-Type: multipart/mixed;
	boundary="_002_BYAPR01MB3830504E7213369CA6E82B27801B2BYAPR01MB3830prod_"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	PdI5Boyb/IrObnJP9Haq1zDOjUCYxMmWxBLyU9S0eQ1ZIoQ/LINITJYBTFeg9lImOlZBCQUKu2l/tFgGzFANkRGWTmnvgizN3FStjdVpfNkoZdp+8atkBB8qSe6br4EomDUoRHk6fgVYIwDe3g+Z9qVIJa3np1QC+hRMZu2SFhhGKR2zC9MdqanM4b8Tc8qo51LEoUmIdD/mcLbkKj/gw0mPdpoLi4GrPxc6ToDy0xd4JoXqeMLkOTU5yZ6DWTWl9aIFNHMJ8A+1jlZaMRVrTN3nfEcCaISJIJfUlgjsIZwyXXqFxU87TI+ygwPbClD4CpXnYiaY6JC5CAD49sD2Tw==
X-OriginatorOrg: trendmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3830.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a071f24-26be-4173-ce29-08dec7eae5f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2026 18:54:42.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3e04753a-ae5b-42d4-a86d-d6f05460f9e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UmpvHLSh24htrD9W5G+UOFpwPc6mFo1lOZciw1AVzzhG71MUUhdLkzvP+FpPja6nA2VHtWMZLsH51xBTDougLdkmpN+PPiXSDAn4M+GgmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB9083
X-TM-AS-ERS: 52.101.201.15-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.2.1014-30002.000
X-TMASE-Result: 10--29.067000-4.000000
X-TMASE-MatchedRID: +bMLnCulOEpyv0jrUI8Jl1Aqsqew0Xybiu6u4shZ+fG6jUphueflINLM
	Ba5kLuxGe1/RUzyLOhObBRRuRVA/NMbQSMYsggr9cJYFTsGzC5QWbtwMeTYKvKBK3DLMYz2EknN
	OUbZsW6KCXXAmmtkOwzaR/p3tBh9eSldd4cHL7vZBDuLQMfUY3bo2KXQsvVZSzmG9pmg8ncJHwP
	poS7xiTbv9XQTUPDqtmPUW81F0guAqzA0VXACAZldXI7Wvz55vRYNhzuZZjRDNRGwi6naVTrT/m
	6CuhGKx8Yf3qYhyqKPcUWdJGeBCJVGmRb4pm49KEjd0zg1XWGNz0ENWFJXGmummANIvngmRtHyE
	Pgw8ZA+HwJdQX/FrstP6YqVE16UBIhg63Ta4ijACbSrHC46rDnlrH/TkKCsRlIhi5GPAGeNA9Vz
	iTOAr0sARW2V5wpEsoQ7ZDaHxJw+one8pjZJzj7vR8IB1ZFH4HQEDQr0cj0Z4R1T0OF5teNajuE
	vVw3GHT+Ul+a4hTsOMTU4gI4hhSZCKEz0Us+te0pETrlpqkI+muS2h5T5tPpieW7ousOBENL+Bb
	yi+cY3ku2ig3X1RIcJ4Z/NyolfbtJXt7raqALi96tTPHi5PqSbE4NyCMIoryiAijCjuVj0oRzet
	OBI4fqXicGonyj1pj9SUI91UT+/JlgjfKPa9z0/Dqb97uFLauEKZe9OwaKwKEmq2HWwB6rcFkLQ
	w9z0Gv1vHODo997K55eaWlV4Z4wT3ICzoWRibeCo4x9FAmzW7/BkSrGh1lhKUUHDK9JouFRcDn5
	6XCKOo+qmgR/1HmPIawNVhBJbK2sJThVznAhRBaexKSVX9rjmoMBkrmuf/mCYM4MaoFU8QSZo0P
	rLGOp/7YDDOSj91l1TB1A2F1mKN4P4XksxlV3UDe0IPsA+jLQadl68VRZghOgGhokrt6aKT7omv
	XNSYhYBQjSdBRZ/dLTFJoq83sdn6VvkE3C9/OvT30G5nOJt+3BndfXUhXQ==
X-TMASE-XGENCLOUD: 05cdaad4-2ea7-4300-838f-fa5401a3205e-0-0-200-0
X-TM-Deliver-Signature: 09A843D474E51AD79EDC75537EC1276E
X-TM-Addin-Auth: pzLy3wbNu3rFJ8QN9DhCBr9l4OACPGXq4buyTNDN+ZwJ9utpf1DC3yYxMbN
	nWf7EhK2m3wT99wYVl5PXmnxGUp6L/FHCBUibdsrtuIw4aneK6+J5giRKpy6gua5fgg8ZzTLS5J
	45YhLM+gHOF/PHhD1JpGBWXgKYKrMS61lugCa5nmFb36sVl8MvU5/7yiSoJba7Vx8oCbCuYyT/s
	wqtRqRBpWFdyzI0oAVnjltC44/98bmQVnB3quNdnR5lYAs1yn2Br2srSbdWiGoa4povFOVgOPmm
	uA/0ynFWlvwB4XhttsX7gDubDhOKe0CjWjIs4iNxJM8VIHeDg2ADICEW7g==.Gt+LNLWAy34Q+I
	OQ2OM3oohn8Xo9tugXlIUuay9MutdJLhb4NnLSgP+uSpcE0Va6x85GsFw2SJwSndEHzHdu2Oavj
	ZoOpW7DhvnfDtD7K/2gqj7DfwyShHdK2db8YG1mOcZOp3TmwhMXNRbsLoSHWzRlpLKr0dmrE/vo
	vFWfZbAOZcs9I5+n+BPNRNLLwdn6IPXmtDYrtMwfDwRqs57/x82J+daihsBvL1cu9+MwAXsv5Bf
	6H5QPcYygDpvXEQQ8wtCyvoH5S4olervDeP/o+wOZGoezDrpgZjRVGb28KrVzg2jmelG/Wze7+H
	ilGqhQTREDpNdqEVok4Hs2zwdrVw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=trendmicro.com;
	s=TM-DKIM-202604108455; t=1781204090; x=1781376890;
	bh=tgh2AxLKjfUVemX+CHOBzEaKe6AoO0Q6kfyDagkVU/8=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From:To:
	 Date:Message-ID:Subject:Content-Type:Reply-To:List-Unsubscribe:
	 MIME-Version;
	b=AzAaj0avYCcH6gni1yWoD3CFYIQpLbXtVEPgiXKP+dbemNzJZMBzszIdNUqfK6Wa2
	 cHj5nxbgiPiu+a7KTpQjgVZDIRXL5yp6nXrQKBJy0x6rxNJ7g7X7wCq4aRCT/HtFTk
	 EIGP7HRDdpgt/JD/xeQm0liv9amaU13fdthtBYwi3vWxgBkDd1Wv9XGmZaR+8ODWXT
	 rxqWuqA8CpVYO4WYPw1jbW9eW9t4uJ7CP/vvwkHKB+cGKNr+awZCtuOlSH5bS/Jam1
	 WyDWrxgSqrdFP6gmIcNgiZ0EoMv1ecA8lrUYivnv4AK/MemHeHBHiOoCXp8useTf+i
	 P7Ni2q5lIItiA==

--_002_BYAPR01MB3830504E7213369CA6E82B27801B2BYAPR01MB3830prod_
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The attachment named ZDI-CAN-30691.zip could not be scanned for viruses b=
ecause it is a password protected file. 

If you are not expecting this email from the sender or if you are unsure =
if the email is legitimate or malicious, please send a feedback to Trend =
Micro InfoSec 911 email/web portal and attach the email sample .msg file =
format.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
ZDI-CAN-30691: Linux Kernel eBPF Integer Overflow Local Privilege Escalat=
ion Vulnerability

-- CVSS -----------------------------------------

8.2: AV:L/AC:L/PR:H/UI:N/S:C/C:H/I:H/A:H

-- ABSTRACT -------------------------------------

Trend Micro's Zero Day Initiative has identified a vulnerability affectin=
g the following products:
Linux - Kernel

-- VULNERABILITY DETAILS ------------------------
* Version tested: 7.1-rc4
* Platform tested: debian trixie

---

### Analysis

```
A signed 16-bit integer overflow in the Linux kernel's BPF verifier allow=
s a local attacker with `CAP_BPF` capability to corrupt the BPF JIT compi=
ler's internal state, achieving arbitrary kernel memory read/write and es=
calating privileges from an unprivileged user (`uid=3D1000`) to `root` (`=
uid=3D0`).
The vulnerability exists in the `may_goto` instruction fixup within `do_m=
isc_fixups()` in `kernel/bpf/verifier.c`. When the verifier rewrites `may=
_goto` instructions into multi-instruction patchlets, it computes a jump =
offset (`insn->off + 5`) without checking for `__s16` (signed 16-bit) ove=
rflow. Offsets in the range 32765\xe2\x80\x9332767 cause the result to wr=
ap negative, producing a corrupted `BPF_JEQ` instruction. The x86-64 JIT =
compiler processes this corrupted instruction and performs an out-of-boun=
ds array access, generating a deterministic backward jump to an attacker-=
controlled instruction. This creates a verifier state mismatch ( the veri=
fier believes a register holds zero, but at runtime it holds an attacker-=
controlled value) yielding an arbitrary out-of-bounds read/write primitiv=
e relative to a BPF map value.
Full exploit tested on 6.19.11 with KASLR, SMEP, SMAP
```

~~~C++
int bpf_do_misc_fixups(struct bpf_verifier_env *env)
{
...

                if (bpf_is_may_goto_insn(insn) && bpf_jit_supports_timed_=
may_goto()) {
                        int stack_off_cnt =3D -stack_depth - 16;

                        /*
                         * Two 8 byte slots, depth-16 stores the count, a=
nd
                         * depth-8 stores the start timestamp of the loop=
.
                         *
                         * The starting value of count is BPF_MAX_TIMED_L=
OOPS
                         * (0xffff).  Every iteration loads it and subs i=
t by 1,
                         * until the value becomes 0 in AX (thus, 1 in st=
ack),
                         * after which we call arch_bpf_timed_may_goto, w=
hich
                         * either sets AX to 0xffff to keep looping, or t=
o 0
                         * upon timeout. AX is then stored into the stack=
. In
                         * the next iteration, we either see 0 and break =
out, or
                         * continue iterating until the next time value i=
s 0
                         * after subtraction, rinse and repeat.
                         */
                        stack_depth_extra =3D 16;
                        insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX, B=
PF_REG_10, stack_off_cnt);
                        if (insn->off >=3D 0)
                                insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BPF_=
REG_AX, 0, insn->off + 5);       // integer overflow
                        else
                                insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BPF_=
REG_AX, 0, insn->off - 1);
...
                } else if (bpf_is_may_goto_insn(insn)) {
                        int stack_off =3D -stack_depth - 8;

                        stack_depth_extra =3D 8;
                        insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_AX, B=
PF_REG_10, stack_off);
                        if (insn->off >=3D 0)
                                insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BPF_=
REG_AX, 0, insn->off + 2);       // same pattern
                        else
                                insn_buf[1] =3D BPF_JMP_IMM(BPF_JEQ, BPF_=
REG_AX, 0, insn->off - 1);
...
```

The `insn->off` field is `__s16` (signed 16-bit, range -32768 to +32767).=
 The expression `insn->off + 5` is evaluated as `int` (32-bit), but the r=
esult is stored into the `.off` field of the new `BPF_JEQ` instruction, w=
hich is also `__s16`. When `insn->off >=3D 32763`, the sum exceeds `S16_M=
AX` (32767) and is silently truncated to a large negative value:
| `insn->off` | `insn->off + 5` | Stored as `__s16` |
|----------- |---------------|-------------------|
| 32765         | 32770               | -32766                      |
| 32766         | 32771               | -32765                      |
| 32767         | 32772               | -32764                      |


KASAN report
```
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: use-after-free in do_jit+0xb91b/0xbda0 /root/linux/arch/x86/n=
et/bpf_jit_comp.c:2609
Read of size 4 at addr ffff88805dda0010 by task kasan-trigger/9502
CPU: 1 UID: 0 PID: 9502 Comm: kasan-trigger Not tainted 7.1.0-rc4 #4 PREE=
MPT(lazy)
Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 19=
96), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack /root/linux/lib/dump_stack.c:94
 dump_stack_lvl+0x100/0x190 /root/linux/lib/dump_stack.c:120
 print_address_description /root/linux/mm/kasan/report.c:378
 print_report+0x139/0x4ad /root/linux/mm/kasan/report.c:482
 kasan_report+0xe4/0x1d0 /root/linux/mm/kasan/report.c:595
 do_jit+0xb91b/0xbda0 /root/linux/arch/x86/net/bpf_jit_comp.c:2609
 bpf_int_jit_compile+0x3fa/0x16f0 /root/linux/arch/x86/net/bpf_jit_comp.c=
:3796
 bpf_prog_jit_compile /root/linux/kernel/bpf/core.c:2550
 __bpf_prog_select_runtime+0x458/0xc30 /root/linux/kernel/bpf/core.c:2619
 bpf_check+0x1d40/0xab30 /root/linux/kernel/bpf/verifier.c:20174
 bpf_prog_load+0x189f/0x2b90 /root/linux/kernel/bpf/syscall.c:3082
 __sys_bpf+0x2310/0x4b90 /root/linux/kernel/bpf/syscall.c:6248
 __do_sys_bpf /root/linux/kernel/bpf/syscall.c:6361
 __se_sys_bpf /root/linux/kernel/bpf/syscall.c:6359
 __x64_sys_bpf+0x78/0xc0 /root/linux/kernel/bpf/syscall.c:6359
 do_syscall_x64 /root/linux/arch/x86/entry/syscall_64.c:63
 do_syscall_64+0xff/0xf80 /root/linux/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f /root/linux/arch/x86/entry/entr=
y_64.S:121
RIP: 0033:0x41e1ad
Code: 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 f0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdeb671b88 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f491c354010 RCX: 000000000041e1ad
RDX: 0000000000000098 RSI: 00007ffdeb671b90 RDI: 0000000000000005
RBP: 00007ffdeb671ce0 R08: 0000000000000000 R09: 0000800000000001
R10: 00000000000000c7 R11: 0000000000000246 R12: 00007ffdeb671d58
R13: 00007ffdeb671d68 R14: 0000000000000002 R15: 00000000004c5720
 </TASK>
The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88805dda=
0000 pfn:0x5dda0
flags: 0x4fff00000000000(node=3D1|zone=3D1|lastcpupid=3D0x7ff)
page_type: f0(buddy)
raw: 04fff00000000000 ffffea00017e2c08 ffffea0001739c08 0000000000000000
raw: ffff88805dda0000 0000000000000004 00000000f0000000 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(=
__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 919=
7, tgid 9197 (nfsrahead), ts 55630335105, free_ts 55917187582
 set_page_owner /root/linux/./include/linux/page_owner.h:32
 post_alloc_hook+0x123/0x170 /root/linux/mm/page_alloc.c:1858
 prep_new_page /root/linux/mm/page_alloc.c:1866
 get_page_from_freelist+0x1104/0x3020 /root/linux/mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x263/0x2bc0 /root/linux/mm/page_alloc.c:522=
6
 alloc_slab_page /root/linux/mm/slub.c:3278
 allocate_slab /root/linux/mm/slub.c:3467
 new_slab+0xa6/0x690 /root/linux/mm/slub.c:3525
 refill_objects+0x271/0x420 /root/linux/mm/slub.c:7271
 refill_sheaf /root/linux/mm/slub.c:2816
 __pcs_replace_empty_main+0x373/0x630 /root/linux/mm/slub.c:4651
 alloc_from_pcs /root/linux/mm/slub.c:4749
 slab_alloc_node /root/linux/mm/slub.c:4883
 __do_kmalloc_node /root/linux/mm/slub.c:5294
 __kmalloc_noprof+0x66d/0x830 /root/linux/mm/slub.c:5307
 kmalloc_noprof /root/linux/./include/linux/slab.h:954
 tomoyo_realpath_from_path+0xb6/0x690 /root/linux/security/tomoyo/realpat=
h.c:251
 tomoyo_get_realpath /root/linux/security/tomoyo/file.c:151
 tomoyo_path_perm+0x270/0x440 /root/linux/security/tomoyo/file.c:827
 security_inode_getattr+0x116/0x280 /root/linux/security/security.c:1895
 vfs_getattr /root/linux/fs/stat.c:259
 vfs_statx_path /root/linux/fs/stat.c:299
 vfs_statx+0x119/0x3e0 /root/linux/fs/stat.c:356
 vfs_fstatat+0x77/0xe0 /root/linux/fs/stat.c:373
 __do_sys_newfstatat+0x9d/0x120 /root/linux/fs/stat.c:538
 do_syscall_x64 /root/linux/arch/x86/entry/syscall_64.c:63
 do_syscall_64+0xff/0xf80 /root/linux/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f /root/linux/arch/x86/entry/entr=
y_64.S:121
page last free pid 9208 tgid 9208 stack trace:
 reset_page_owner /root/linux/./include/linux/page_owner.h:25
 __free_pages_prepare /root/linux/mm/page_alloc.c:1402
 __free_frozen_pages+0x729/0x1040 /root/linux/mm/page_alloc.c:2943
 qlink_free /root/linux/mm/kasan/quarantine.c:163
 qlist_free_all+0x47/0xf0 /root/linux/mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x19a/0x240 /root/linux/mm/kasan/quarantine.c:28=
6
 __kasan_slab_alloc+0x6a/0x90 /root/linux/mm/kasan/common.c:350
 kasan_slab_alloc /root/linux/./include/linux/kasan.h:253
 slab_post_alloc_hook /root/linux/mm/slub.c:4569
 slab_alloc_node /root/linux/mm/slub.c:4898
 kmem_cache_alloc_noprof+0x23d/0x6d0 /root/linux/mm/slub.c:4905
 vm_area_alloc+0x1f/0x160 /root/linux/mm/vma_init.c:32
 __mmap_new_vma /root/linux/mm/vma.c:2547
 __mmap_region+0x1076/0x2c40 /root/linux/mm/vma.c:2771
 mmap_region+0x313/0x5e0 /root/linux/mm/vma.c:2857
 do_mmap+0xca6/0x13a0 /root/linux/mm/mmap.c:560
 vm_mmap_pgoff+0x295/0x460 /root/linux/mm/util.c:581
 ksys_mmap_pgoff+0x30a/0x560 /root/linux/mm/mmap.c:606
 __do_sys_mmap /root/linux/arch/x86/kernel/sys_x86_64.c:89
 __se_sys_mmap /root/linux/arch/x86/kernel/sys_x86_64.c:82
 __x64_sys_mmap+0x110/0x1d0 /root/linux/arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 /root/linux/arch/x86/entry/syscall_64.c:63
 do_syscall_64+0xff/0xf80 /root/linux/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f /root/linux/arch/x86/entry/entr=
y_64.S:121
Memory state around the buggy address:
 ffff88805dd9ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88805dd9ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805dda0000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                         ^
 ffff88805dda0080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88805dda0100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
```



Here is reproduce steps
```
gcc -O2 -static -o ebpf-001-modprobe-lpe ebpf-001-modprobe-lpe.c
gcc -O2 -static -o getroot getroot.c

Run in QEMU VM:
# Launch VM with all mitigations enabled
./run-vm-mitigations.sh

# Inside VM, as uid=3D1000 with CAP_BPF:
./ebpf-001-modprobe-lpe
```

Here is exploit output (from confirmed test run):
```
[*] uid=3D1000 euid=3D1000 pid=3D75

[Stage 1] Verifying may_goto __s16 overflow...
  [+] Vulnerability CONFIRMED

[Stage 2] KASLR bypass: leaking bpf_map->ops...
  array_map_ops (runtime): 0xffffffff8fe25140
  modprobe_path (computed): 0xffffffff90548800
  [+] KASLR DEFEATED

[Stage 3] Recovering map_value kernel address...
  [+] Confirmed: -144 and -136 both =3D 0xffffa14ec0ecac98 (list_head)
  [+] map_value kernel address: 0xffffa14ec0ecad28

[Stage 4] Overwriting kernel data targets...
  [4a] modprobe_path @ 0xffffffff90548800
       [+] modprobe_path overwritten
  [4b] core_pattern  @ 0xffffffff9057fb80
       [+] core_pattern overwritten

[Stage 5] Triggering privilege escalation...
      uid=3D0(root) gid=3D0
  [+] /tmp/rootsh created (mode=3D04755 uid=3D0)

  \xe2\x96\x88\xe2\x96\x88 PRIVILEGE ESCALATION SUCCESSFUL \xe2\x96\x88\x=
e2\x96\x88

[*] Before: uid=3D1000 euid=3D1000
[getroot] Before setuid: uid=3D1000 euid=3D0 gid=3D1000
[getroot] After setuid:  uid=3D0 euid=3D0 gid=3D0
~ #
```


-- CREDIT ---------------------------------------
This vulnerability was discovered by:
Giuseppe Caruso working with TrendAI Zero Day Initiative
-- FURTHER DETAILS ------------------------------

Supporting files:


If supporting files were contained with this report they are provided wit=
hin a password protected ZIP file. The password is the ZDI candidate numb=
er in the form: ZDI-CAN-XXXX where XXXX is the ID number.

Please confirm receipt of this report. We expect all vendors to remediate=
 ZDI vulnerabilities within 120 days of the reported date. If you are rea=
dy to release a patch at any point leading up to the deadline, please coo=
rdinate with us so that we may release our advisory detailing the issue. =
If the 120-day deadline is reached and no patch has been made available w=
e will release a limited public advisory with our own mitigations, so tha=
t the public can protect themselves in the absence of a patch. Please kee=
p us updated regarding the status of this issue and feel free to contact =
us at any time:

Zero Day Initiative
zdi-disclosures@trendmicro.com

The PGP key used for all ZDI vendor communications is available from:

  http://www.zerodayinitiative.com/documents/disclosures-pgp-key.asc

-- INFORMATION ABOUT THE ZDI --------------------
Established by TippingPoint and acquired by Trend Micro, the Zero Day Ini=
tiative (ZDI) neither re-sells vulnerability details nor exploit code. In=
stead, upon notifying the affected product vendor, the ZDI provides its T=
rend Micro TippingPoint customers with zero day protection through its in=
trusion prevention technology. Explicit details regarding the specifics o=
f the vulnerability are not exposed to any parties until an official vend=
or patch is publicly available.

Please contact us for further details or refer to:

  http://www.zerodayinitiative.com

-- DISCLOSURE POLICY ----------------------------

Our vulnerability disclosure policy is available online at:

  http://www.zerodayinitiative.com/advisories/disclosure_policy/
    

TREND MICRO EMAIL NOTICE
The information contained in this email and any attachments is confidenti=
al
and may be subject to copyright or other intellectual property protection=
.
If you are not the intended recipient, you are not authorized to use or
disclose this information, and we request that you notify us by reply mai=
l or
telephone and delete the original message from your mail system.
For details about what personal information we collect and why, please se=
e our Privacy Notice on our website at: [ https://www.trendmicro.com/priv=
acy]

--_002_BYAPR01MB3830504E7213369CA6E82B27801B2BYAPR01MB3830prod_
Content-Type: application/x-zip-compressed; name="ZDI-CAN-30691.zip"
Content-Description: ZDI-CAN-30691.zip
Content-Disposition: attachment; filename="ZDI-CAN-30691.zip"; size=8910;
	creation-date="Thu, 11 Jun 2026 18:38:31 GMT";
	modification-date="Thu, 11 Jun 2026 18:54:37 GMT"
Content-Transfer-Encoding: base64

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
AAAAAAMAAwAHAQAAsSEAAAAA

--_002_BYAPR01MB3830504E7213369CA6E82B27801B2BYAPR01MB3830prod_--

