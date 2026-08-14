Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E65349CF3;
	Fri, 14 Aug 2026 08:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696498; cv=fail; b=KopGYvj0E7zrU4OoE/dPXLQc4IuS6gZomfHRPgPAuSXk4QhGy/qxmBmFCdNfIfjGGqpRquGAJrTEMsSCfFwU0wk1El+QHNKl7vBZQJLf5+BcDxhZutlFNKih0nm2MR65+MtL+xQ1lQFFBzCj+2Hkj9gW0CXBImCGV1ODiKuCV/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696498; c=relaxed/simple;
	bh=oRtqvALtSpt6qS9Ds0peKbrrEPupIfTmZrPSJJmByVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AU9F9aBu5kWgEDnRkhznWbd9Ml4MmVuJ9oCeRItJkj3vSJLlFrtq340kWroL2fQHuRV2xBZcDC7ZAKWt/h6BD63yBadGIH2iGMAC67EIq/f+StOLP2W9R4/3BB22Z8oTRxa7mj+H57zGxySBR7XTzAkLfvOsDOroEfn8/zglWZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=b8jk/hUq; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="b8jk/hUq"
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7gXHX2613528;
	Fri, 14 Aug 2026 09:34:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=8iNew0x3IkBX70Iq7okGO3
	BTHTwkvKsdiucG3kKq+hM=; b=b8jk/hUq000UgRQoVO6gggcdifaoE/Bd7440FW
	qWrdLLBoCq4V9krIIQHWba2gGpE9EewA8st4V//OTsVqlL8cW5vtPCFulBwq370X
	mAfug7Dr95mlt3GiHMu6zGRcngL6OUeWR3nIs+6OQY9QTe+0qQICU0BBtZbr8hRG
	pg2U1h/ogiRVyhZ5gx3C8m9PssY2YxAv/pF/Q6fzrSu7U/KJ8lagfEiAUQAjVbYF
	/zk+csRLT+P85W1PJf3L2biRRi+wKnWUoZ3vS+m6n/dsXJIfL5a7BcBvOo4IwEv1
	ekcqEA24SZYMBB6pVdj7HemzC3EoFHLNaSiyKWiQmOjHo8Kg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4g1wnwrx7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:34:04 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8KS3n001271;
	Fri, 14 Aug 2026 04:34:03 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.40])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTPS id 4fwystqyp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 04:34:02 -0400 (EDT)
Received: from usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) by
 usma1ex-dag5mb1.msg.corp.akamai.com (172.27.91.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 14 Aug 2026 01:34:01 -0700
Received: from BL2PR08CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge1.msg.corp.akamai.com (172.27.91.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 14 Aug 2026 04:34:01 -0400
Received: from MW4PR17MB4715.namprd17.prod.outlook.com (2603:10b6:303:108::16)
 by CH3PR17MB6340.namprd17.prod.outlook.com (2603:10b6:610:14f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 08:33:58 +0000
Received: from MW4PR17MB4715.namprd17.prod.outlook.com
 ([fe80::f5e4:82be:a01e:da25]) by MW4PR17MB4715.namprd17.prod.outlook.com
 ([fe80::f5e4:82be:a01e:da25%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:33:58 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "willemb@google.com" <willemb@google.com>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "Tottenham, Max"
	<mtottenh@akamai.com>,
        "Glasgall, Anna" <aglasgal@akamai.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org"
	<ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "memxor@gmail.com"
	<memxor@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        "clm@meta.com" <clm@meta.com>,
        "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v7 5/6] bpf: clear decap state on skb_adjust_room
 shrink path
Thread-Topic: [PATCH bpf-next v7 5/6] bpf: clear decap state on
 skb_adjust_room shrink path
Thread-Index: AQHdKjURTO/RCmHYfE63Y3/jXpUSxbaaN4eAgAMDToA=
Date: Fri, 14 Aug 2026 08:33:57 +0000
Message-ID: <133E046B-F0E2-4B01-BAF6-87A75CF4A4A5@akamai.com>
References: <20260812083115.73100-6-nhudson@akamai.com>
 <088eba49857b5cab3fce1b0b917ece4594464be28c7ec4c1e0a551089f1a81a7@mail.kernel.org>
In-Reply-To: <088eba49857b5cab3fce1b0b917ece4594464be28c7ec4c1e0a551089f1a81a7@mail.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR17MB4715:EE_|CH3PR17MB6340:EE_
x-ms-office365-filtering-correlation-id: 1dc0ac30-6d71-4737-885c-08def9dec8d3
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|23010399003|6049299003|38070700021|4013099003|4053099003|56012099006|10067099003|4143699003|22082099003|8096899003|18002099003;
x-microsoft-antispam-message-info: FLskbIv4X+oUuli/VWx1xuNCBl+vcM/Bcd9/5gtEO/Q3S3QLxJMcIoqIMph7KvQz3nDRr4OD8/URcVQxGgCSIfNFBX4roPfbRflfXII1RZJXzX1s0MLLMa+P0ZMWZSjuVHjT302wN0TwoZu5fHxj16/cvpce1zXTyZZnpCSg2/750sYT49ioQ1s+s41Wo5dmJmRrs/+x3IDWfx/t2dRsiAwN5LSySeQaTdvSlOLz/BDdKiB7ewcgIoMzbP+jsiKvvy2nZOhEZcPDVT2H+60d4EsbIUVjzbafh4l2XBiejkXI91Ushx58ug0TbAYfeZWL1U8qtMcmRc9SRoUCwLQoIHn40Y04AfIY8fVXA/2qyai4/D9IiJsBMnyuZTuwy3LTdOBvX6cDr9pI4TKle9/GCDmmctWSCaqpUzM+yEjqhklQelprA+Jx6RpA6dXRBi06B1dpDjm6RCv3TcC3S6gsBVicdUm0LAzJkctz5YE8XVGy245eVXDYBnlat4vAC4whCqlXH8YKnHkqqCvcBguDg2EFBQihN9Tk2kvHWsVgNbmxeSa+SEMhcbcpmiACNWpFf9CJj1dVUs3yZe8+b9IsrwMsZQx4ZzzYoKDBorCWlNyUDPCRRuV3T4aSBeWhPIEd2IXz9hrmeWWwdHQLD9FVqUw4oWcKyknT6g8uQxnvK2qHwa2VK7LAneDLVG0zIM8Ka6yvsnt4SUurxRK7fKR9Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB4715.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(23010399003)(6049299003)(38070700021)(4013099003)(4053099003)(56012099006)(10067099003)(4143699003)(22082099003)(8096899003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0pYQ0FHU2lJV01FZ2tIbVpxcTMzZDk2RzNLbTN6MGJJYUl4OUVDUUl0VDNv?=
 =?utf-8?B?YXA0dlllTjFodXlpNVpGK3NaSnkwT2ZTTllSTkRLK2RKdDBpaThWQjl1dGo2?=
 =?utf-8?B?ejh0V3dja2NNdUV1dEFoUENUcXZST2N1UGY3SjZHU3VtWS9WYXkvd2RCL1N4?=
 =?utf-8?B?MXdiL1ZvY3FPYTFkczI2MjE3cGNvZllRNzcrZmdzOFpVT0lwVVVhN1JGMG1P?=
 =?utf-8?B?MWhOdW1PcnRXSUpiQ1ZYRnJwbDJhU0dtd2NOM0VEV1NhdENDcC9ZZ1B1emNI?=
 =?utf-8?B?UVcwSkozSEI4cmxtdjgvZW1hN2V4clVjaktpRHhpUzRNNDZrd2NvNVVnNGpB?=
 =?utf-8?B?aGREb1g5TklzdnRSLy9TRzVJcW11MHNmaGxBK212ZGVaSkpPSjdqdmdROUlT?=
 =?utf-8?B?d2lzUENkcW80QXUzajJxNFRFWTZwOUhJV2dmRkhBakcxbU5FVndLK0FxZW56?=
 =?utf-8?B?RmdMZW85SnFkS1VxeHgydzZ5R0drelpLYWZJclV3bHk2WWpKUjhibEt0bXdC?=
 =?utf-8?B?aGtxdkNaT3lTb0RPR2FwQ085L3JXb2xwcDgvRDhRVUxrQ0FYWlByRWJITzVj?=
 =?utf-8?B?SzFUQzAxeTV3VVVOOU1vOEFaTjhqZ2YxNWRVc0N0a1FFMERLZzVOODhQa2pD?=
 =?utf-8?B?OTUvVm1YYkR3RlNFYnJUT2lWQ1hUZ0NNUlZPbndPYlpQV1g1aG9OSTA2RE1Y?=
 =?utf-8?B?SnBtVi9QdE9CRUs3SXdocXNmWlJscjJ0cWkzYmIySktIenczTWRQTGZNNHdY?=
 =?utf-8?B?anBURjhhTjJSWFU1cXpvSkVEZjFwQXBaK1QvVDJ6YktTa3Q2ZEpUN2JTK2Q5?=
 =?utf-8?B?TEN1T3NsSGlEWWkxTjZwTUh2MGxLSlpXOFp5eTFETVdjaStFL1FXM08zVk9M?=
 =?utf-8?B?R09vZzdDcFRyQ1U1NXJxeW53R3BvTUlOTDE3OG83cHdRN0VKc2NibHJXbTlR?=
 =?utf-8?B?ZHdEVWJwRGxqY1NNdCt4alRyL3prZjZyT01KMXQ2aUZHZFhLSWpyMEl3TkJP?=
 =?utf-8?B?WnR3bHpRbTk0NkJuMU9qdmNhTi9pYmllZFN5dXNWNCtJZEZ6ZEtYTVVMSEgy?=
 =?utf-8?B?aEp6RHhLeVRqSm5iKzVsS0EyaHBIVWlYVVVnd212c1lUWThaMngwUVdiZGFZ?=
 =?utf-8?B?WnFnWHBkWlQ5RWdUQjlIeWtqdkpaN1RRRTZQT1JZVzFYcjcwUEFkQUJrNXBS?=
 =?utf-8?B?bjN2MXZnZk1mdnlHMEhlWVVaSG1XZCtwM25BMkUwSnRETDcya2RJZElKYWdN?=
 =?utf-8?B?SnRCcUozRWd6TWpFMHI0QWJrWGxOakU5VmtmM1dxVUYzYUtsWXdKT3AxMHpn?=
 =?utf-8?B?YjZDclpmb2RRa2EwTDVBZ2FFSWJwdUNmWU9CYWpNc2lsK1lsTnBlTFM5Sk5N?=
 =?utf-8?B?dzhIbXFxcXBrRHhEMWhQQjhZQkd1QzYzUjFyUWtMOWFTd0xvL1BmbW9iU21x?=
 =?utf-8?B?V09pSERJZ2wxem8wS2ZYdFNWSnIweFhvMVRJN28vV1A5Q2x1R2FoVzY4d0xa?=
 =?utf-8?B?Qk02K0ZEb1BhOTFoNWNTK0tSN0M4WHhjbnUrbjVicGkxMHphQzFydTV6YkZz?=
 =?utf-8?B?V24zR2JYdEVRZlZCcGRlRDlOdXo2c3lzdzBIaUFGTWp0UU9aMDVla0krSlNk?=
 =?utf-8?B?a3VJODNFRkdoYTRHUWhkTVIyajlGbUppUUNIbmt5aHRUdDVlRkp1THkzOWJ5?=
 =?utf-8?B?OGlnZ3Vrc1pXMGEzSWxCUXI4MER2ZVVRcVczdk12L1RkbHNhSUJUdkZTS1lx?=
 =?utf-8?B?eExqcVZVZnFiWW9NNlVkVzc2VWRzSmwvM0NWLzZobUcrajU0V1ZXSC9IMTNW?=
 =?utf-8?B?b0JDbm9NcU4wUkFNN0NMbTdjZUxDbTh6cnAzT3ZtV0ZncDltT0RzdzN6NEl0?=
 =?utf-8?B?WUhMYnZPUTI2SVlGSHdldXJFOFNTNm55R0RRdDRYWjdaV0F5M2hFMVdYa0x5?=
 =?utf-8?B?NDVjNzh2Q3hJck5OVFNsd0szb2IxbS9JVGx0L2E2MHBsWHRlMjJuNWdiSzJM?=
 =?utf-8?B?NlNkTlVhSFMyek50MEVUam15YjdLZlZPZ1JSVDk1dEZ4M1k3TW5qTHpyMVMv?=
 =?utf-8?B?bCtWeVo3alR2Q3d0dll3Nko5dWk4bUF2QTRlZnozaUtPYmhMWkZCVmtOSjlL?=
 =?utf-8?B?QmVrcjdsOXVLdEx4cWRvY0ZrS0xhTHhFUkwwRlNNbGFxVGJpMFpNbi9GWFVL?=
 =?utf-8?B?eHR5OEdPbUpSU29hM3FQYTZqMlZxUmE3TmprbXMxRTMrMEUxdTQyYnFjS0Vi?=
 =?utf-8?B?OERxcjBXWlJYelpwWGxhYmVYMCt1ZEI1d3ZCOU4yZ20wV3Zqb0tUR054elFR?=
 =?utf-8?B?S1VBZ0F3dHpTYmNLb3lxcTR4Sy82YVJYaEdNY0NZSituRHg1bTFCZmJrNXEz?=
 =?utf-8?Q?EfwtXjFpUSHFMJEz7zjKou0NwzZKmhazsFgK9wxbyvXCW?=
x-ms-exchange-antispam-messagedata-1: JXf2KBhGyKbXhg==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U82S+fVpQOFapLpS2tcxrSoemMGYPA0muvN/JqCVerkMp0abU6uOqq0iSyPgrCkO1mlIB0LUeHEIsp5rtgaahwm8DwaQI2NUCgdKfz9CJODD4zmBSJkeGHtnLhXPBYUbD3YBKY1YiLaZ5fw2YLTYFG7EPyl0zxWKA++YVgEFIvX3mJlvY4jjcnntOn1BtQHQG12C/M9iz2Ee2Mva3vKtVofHAquLnlPKmnT1sVrujRKss0vdclFtlKaXh5YfUpGJdrazaN+aK0F9wxgm04iXe7GYzdsLS5VXiPATPbowou1ogwgLxLfOUnvpHRooffmF9gwgo0BJ7Vl1RfEWmw/Iqg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcbJFtF5dQvRRjcqSm645Aq+Ip0vs1KdNzOyjcAj5Y4=;
 b=nTfOkAUFjxoMJe0W6psZjDllkLZDFh9tFveM6KttxJZPz8SD915y6Bf8+UaZQuwrozMBERtkWzg/Mmc1sfglLS3X884ySUifVp51WQxyWK0ce+XobFXfp8JQlKpomhQUvNYhWlVxZYdWBVIVWvIvzx0+vwHlfhVX0MXiakn6Ar4k0Ffts48kZgRyeaZZ+mtxgQI1L4pP1jQsIEQK2z4G9jRDnRmRndPEBSEkZynfFDCOlQBd0FY7F7bvsjl4yzpgRfsc9dmz62aZyXSYdQoanvZTl5taQYP0Bk70d6Z9ofvf2a4iQvNK1pKswYlXTQGbmr/HfqC9RGQfkE7TThzK3w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: hhHgF75uJbCvytqv/A1My/YwZD3AgnVE+NiA2Hjfh8TPCPA+4G5vOn1jr39wuc5GxD4w6N5ojS9yU2XWmSNsukTZLUobkye5g2qvMX2xDniPvavlugprMy/H6/oGHrJkRqMyqlyZO95ls0Nm6oIcvMobKwSvQsYyx5guitqkavbjRWNXW+iHp55N9ZnOCv7Q2Dj4/UEBEOz6+ANvVnPpxWh3831L26Y+qsK+ytEX4gTUn3Y7SpuVbFGoGh2jdfYex07deyouOnktzKBbFaG0N80fTzXnzINWZG7h/gXOC0CpSW/Hh8p+btdHgG1e3IKDGOHtjv13waAhqfsmhitvEA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR17MB4715.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 1dc0ac30-6d71-4737-885c-08def9dec8d3
x-ms-exchange-crosstenant-originalarrivaltime: 14 Aug 2026 08:33:58.0115 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: fyeD58AZL5/Yj34g3jg+tclfz8pVD+sADYJBPKrHsTcpwERx9I2OWOy7TV/a/pyj/NTIPvq4jCfDe1WtdIjPzA==
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR17MB6340
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_42C33818-9221-445E-9DFE-243AA9145AF8";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608140063
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NSBTYWx0ZWRfX6bis7Wf+9X7k
 qf14jsAEzP0KgVfngmTlm/gONsULMycQrEUOI574U3wLk9H501+2PkNaalu5oWIpQGfuk5Tr1k0
 hkAy+VsB44+cn4GgOaeOK7Kneq7WcBs=
X-Proofpoint-GUID: dMnTRZrl-NY9e1RwFxCTKAa3apxbh_s_
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a7ed2fd cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=VcQvXEo1OZcA_IiPcy3B:22
 a=VwQbUJbxAAAA:8 a=pGuzRioCS_fxppSSSkgA:9 a=QEXdDO2ut3YA:10
 a=-Q28iAj3uYSuaO0e:21 a=_W_S_7VecoQA:10 a=AFjXZ4jOnrXPHJpauwwA:9
 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NSBTYWx0ZWRfXyI/5FUWH/tfb
 Rp7OQn05KmQksZYzg5Kge31Inogm5rdSfLT9ZUODvePC18Eki0uiC5dBfBgrdUowW2JZUQtVfo+
 Ku1kDJkQR15OV1aUFbbNBeA2UdYZ+Su7YUr3b5MFzBJNdNfjsC48kTRwF2kzhgOFAuo1BHxZpMF
 GBxNfpXd+mn3E/iSz9KJ6HP8kjvuKUobxF18Brk3kIf19Z0QWhDsoqyT9GFv+vAl4FrM3G1ugaw
 gtvMFHi7NxkPCMno15D5X0qIVlAbS6I87b5hhbRJUnhA72MiwNTgJaysIm7IRepW76uPZU+JhJG
 Cs5Ro4xuTn/cxeNPvYWvcNK3Znor6y4kDNuqZvs4dccG/yCmhldf2klVMg9m8qtvUVpploQCWfB
 RfPLjwXlpVlUlYhL0bmfoYiBQmbXVFvn3CHWsrHRzjp5ty4W1Di0OelhiiaBRZKlD5HoTZ5YJpf
 OqsRBf4J/Ti3VTAvYxA==
X-Proofpoint-ORIG-GUID: dMnTRZrl-NY9e1RwFxCTKAa3apxbh_s_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608140065

--Apple-Mail=_42C33818-9221-445E-9DFE-243AA9145AF8
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_938C8B4F-9637-4450-B241-12C6288F2655"


--Apple-Mail=_938C8B4F-9637-4450-B241-12C6288F2655
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 12, 2026, at 11:33=E2=80=AFAM, bot+bpf-ci@kernel.org wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
>> On shrink in bpf_skb_adjust_room(), apply decapsulation state updates
>> according to BPF_F_ADJ_ROOM_DECAP_* flags.
>>=20
>> For GSO skbs, clear only the tunnel gso_type bits that correspond to =
the
>> requested decap layer:
>> - DECAP_L4_UDP: SKB_GSO_UDP_TUNNEL{,_CSUM}
>> - DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}
>> - DECAP_IPXIP4: SKB_GSO_IPXIP4
>> - DECAP_IPXIP6: SKB_GSO_IPXIP6
>>=20
>> Then clear skb->encapsulation only if no tunnel GSO bits remain, =
keeping
>> encapsulation set for cases such as ESP-in-UDP where tunnel state =
remains.
>>=20
>> For non-GSO skbs, there are no tunnel GSO bits to consult, so clear
>> skb->encapsulation directly when DECAP_L4_* or DECAP_IPXIP_* flags =
are set.
>>=20
>> This keeps decap state handling consistent between GSO and non-GSO =
packets.
>=20
> This looks like a bug fix for the DECAP flags added in commit =
0e08a219f910.
> That commit added the BPF_F_ADJ_ROOM_DECAP_* flags and documented that =
they
> would clear GSO state and encapsulation flags, but the behavior was =
never
> implemented in the code. This commit implements that documented =
behavior.
>=20
> Should this include:
>=20
>  Fixes: 0e08a219f910 ("bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for =
tunnel decapsulation")
>=20

The 0e08a219f910 commit only introduces the flags and their =
documentation. The subsequent patches in this series implement the =
documented behavior. The split is intentional to aid human review, so no =
Fixes tag is needed here.=

--Apple-Mail=_938C8B4F-9637-4450-B241-12C6288F2655
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br =
id=3D"lineBreakAtBeginningOfMessage"><div><br><blockquote =
type=3D"cite"><div>On Aug 12, 2026, at 11:33=E2=80=AFAM, =
bot+bpf-ci@kernel.org wrote:</div><br =
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">!------------------------------------------------------------=
-------|</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;This Message Is =46rom an External =
Sender</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;This message came from outside your =
organization.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline =
!important;">|------------------------------------------------------------=
-------!</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;"><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-line: =
none; text-decoration-thickness: auto; text-decoration-style: solid;">On =
shrink in bpf_skb_adjust_room(), apply decapsulation state =
updates<br>according to BPF_F_ADJ_ROOM_DECAP_* flags.<br><br>For GSO =
skbs, clear only the tunnel gso_type bits that correspond to =
the<br>requested decap layer:<br>- DECAP_L4_UDP: =
SKB_GSO_UDP_TUNNEL{,_CSUM}<br>- DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}<br>- =
DECAP_IPXIP4: SKB_GSO_IPXIP4<br>- DECAP_IPXIP6: =
SKB_GSO_IPXIP6<br><br>Then clear skb-&gt;encapsulation only if no tunnel =
GSO bits remain, keeping<br>encapsulation set for cases such as =
ESP-in-UDP where tunnel state remains.<br><br>For non-GSO skbs, there =
are no tunnel GSO bits to consult, so clear<br>skb-&gt;encapsulation =
directly when DECAP_L4_* or DECAP_IPXIP_* flags are set.<br><br>This =
keeps decap state handling consistent between GSO and non-GSO =
packets.<br></blockquote><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">This looks like a bug fix for the DECAP =
flags added in commit 0e08a219f910.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">That commit added the =
BPF_F_ADJ_ROOM_DECAP_* flags and documented that they</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">would clear GSO state and encapsulation =
flags, but the behavior was never</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">implemented in the code. This commit =
implements that documented behavior.</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Should this include:</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">&nbsp;Fixes: 0e08a219f910 ("bpf: add =
BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation")</span><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: solid;"><br =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant-caps: normal; font-weight: 400; =
letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></blockquote><div><br></div><div>The 0e08a219f910 commit =
only introduces the flags and their documentation. The subsequent =
patches in this series implement the documented behavior. The split is =
intentional to aid human review, so no Fixes tag is needed =
here.</div></div></body></html>=

--Apple-Mail=_938C8B4F-9637-4450-B241-12C6288F2655--

--Apple-Mail=_42C33818-9221-445E-9DFE-243AA9145AF8
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
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
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MTQwODMzNDda
MC8GCSqGSIb3DQEJBDEiBCASv2SHWVZ74LvVUisQQYCgAw+M0W2H98QTsnpIv/kX/TANBgkqhkiG
9w0BAQsFAASCAQC+O+oFwLDye+rHWUvmEXn+fMMhnODkUWsEi3MgLKPZh5q6dwvyEWofE+SEamw/
lvu1hpg51oeqZp+GqJomRv8je7/yhVQGgdLomOFJg30+N18iH2wh80uzSoUG6ICdnIX3CCerngxx
ZQDXfl2rbVD9xat4gI0/Wtb68XJF/T/TTsH/KTpoG2151bvRRSuGCdhTmefoWAinftpS15YcTKCl
JZpNZZ9xKX+WeBJd/Br/Cb9Wc/Jkp0fEyBj4hiNpCoXXbwi3piQoU3lK2VVxKwPBnBXfVoP9QEkX
JQkU483uQgAyYzUQqY8B9sTo5BUb+/YHXq3QhXOhQuoekgKdQav+AAAAAAAA

--Apple-Mail=_42C33818-9221-445E-9DFE-243AA9145AF8--
