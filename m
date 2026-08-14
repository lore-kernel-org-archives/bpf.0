Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE234519A7;
	Fri, 14 Aug 2026 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696901; cv=fail; b=O7G5xuvftDonLzlV9MEfeDNYRbNjdUkE8eZFtzLOg2SkjW89WHzfZxI+xZWTKLejtLnqQ9wllVlUWvwjRU6onVad98XkohdsDzsHeUyiCFSG5cyti+Q7mGwpQbZjPcDoBv6cIete5yXSHko3Y+xtZLc5yBBJkA4He3zrkNHBhys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696901; c=relaxed/simple;
	bh=/ABMSzo1VaI2pjq743lpSXY48PKQgkI1iIvAE6Dgo0s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=raD/OSIs2B8FgG+GPlvstGX4/dEnJMcygG+mX3jEGsyTROtBHVpSlxHtnJ1RQITMa1cNYNo58pZxVDn6GSVQaELM8J5s1YQmrKYnDk65omI0ztY+pSWWEdhmi0Yd/+haDJNSNd6sPqDYS+fg6bzabypw1Aur3XR7s5i7RzmGBkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=hA0l40qr; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="hA0l40qr"
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
	by mx0a-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E7kgYR3986530;
	Fri, 14 Aug 2026 09:40:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=VrBbMjuv+b0mS7Y2El6oo/
	eaj5pH+fRTcVZHr1u1vIc=; b=hA0l40qrQ9/lWU6WXX5dkGnweYT743+rkNcblr
	jPG74hBspuPKJFRiuJ6KeTr6HpHmMXuzg9pv5ibyCUDvWuRhfRzHcbMrX4LAFGv8
	+iBsLK32CdmnZlDwNP/9bLqv4SIY6Rz48Lm0h5ZvuSod/7OB1CDFsscJ8Jyr8uDE
	v2UmbYYrSgPFagUmu2ojZxcy8+ZsWGy+SVxtEesq9c0KlX0LeiYPIrLzkcIsJArJ
	6toeMRI8KRvCnMpZIWCGOa8ltO5e4EbsxdSsxDEM7jv2wX2kE5n11YGNniP9qjmR
	ncmgMahR2q2irQ+p41rn9fXR19ETDOngI4ZG1hbTfQy71NxQ==
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
	by mx0a-00190b01.pphosted.com (PPS) with ESMTPS id 4g19waw3na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 09:40:43 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
	by prod-mail-ppoint4.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67E8Z9Pr009949;
	Fri, 14 Aug 2026 04:40:42 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint4.akamai.com (PPS) with ESMTPS id 4fwysv7jdj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 04:40:40 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 14 Aug 2026 01:40:40 -0700
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 14 Aug 2026 03:40:40 -0500
Received: from CH4PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 14 Aug 2026 03:40:40 -0500
Received: from MW4PR17MB4715.namprd17.prod.outlook.com (2603:10b6:303:108::16)
 by CH3PR17MB6569.namprd17.prod.outlook.com (2603:10b6:610:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 08:40:35 +0000
Received: from MW4PR17MB4715.namprd17.prod.outlook.com
 ([fe80::f5e4:82be:a01e:da25]) by MW4PR17MB4715.namprd17.prod.outlook.com
 ([fe80::f5e4:82be:a01e:da25%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:40:35 +0000
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
Subject: Re: [PATCH bpf-next v7 2/6] bpf: refactor masks for ADJ_ROOM flags
 and encap validation
Thread-Topic: [PATCH bpf-next v7 2/6] bpf: refactor masks for ADJ_ROOM flags
 and encap validation
Thread-Index: AQHdKjT/Bn0QDGTBV0WQQFhuO+qr+baaN4WAgAMFKQA=
Date: Fri, 14 Aug 2026 08:40:34 +0000
Message-ID: <16B1C103-0537-44A8-9BEA-2582C212EC2B@akamai.com>
References: <20260812083115.73100-3-nhudson@akamai.com>
 <3fca04caea0b155d2b15e0914622f905af892ba5e2ce0f75dc9d998f3fb2226d@mail.kernel.org>
In-Reply-To: <3fca04caea0b155d2b15e0914622f905af892ba5e2ce0f75dc9d998f3fb2226d@mail.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR17MB4715:EE_|CH3PR17MB6569:EE_
x-ms-office365-filtering-correlation-id: 1ffe2665-2a32-4a44-423f-08def9dfb565
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|7416014|6049299003|1800799024|23010399003|4013099003|4053099003|18002099003|22082099003|38070700021|8096899003|4143699003|56012099006|10067099003;
x-microsoft-antispam-message-info: 5ldoZz8LhRlQUiXeCFc2aKtgApjguYOQe/jq31XKvtFa1BAwHWK/0b5Q7CNKG129RbGN0Gd/0JOG9YlWb6cf8N2OKI1sOiNkjPN9DtBEiEPJV1wgXHFa5ib/4FrE2FqXXJB7FFrUbq60F5p3fdRShWIF0DQN4/8VKFjq+gIG1EmXZH0eKsJGDxY8xqaRHSBcuJq637iZg1CrJ15mPo2uMvX5GYMu07j2MFXjHzRF+EZfQU6Wr1bKkBgtyFoMRVaZlevVZP5ooikE3N8pDXw50M5OPlno0H70ajoYOPTdB0VEvyslwBR1/u/nE8jPKp5uto2/UoLncNzOdoX6g5jRBW6smZVTe1tTZPXGd9xcJc54RCnDwYI8p3HatOhGX1TVgv6609slG1wDOGUE1Sz7IaRgZjZEX0tlAqOYWvlBCJqFaQNVWLl5kxzCZb9ndlKkA1M3m3YYRiryIEds81W02U82vhL8Z+Yf/opwkkdXfN76kTPNmJ+f3CwmMdgL7cqElgzNUdKLmNTzxBpQ6D+uU2hc/cD9ITRCmCRyoQ/DslIotSOn43oQY0peY3W9GjJy539wZLtglVRDRWrzTQZY1ZNesQPkGUiDvhQb1iUAJXs1j0IH0FN/j5CputoBHTekjYsI1Q0/CbYPafxM0FIdFc4o0xGdBrVjK8W6IVnraJk1qcly1rCW0BLg2i7TADJyuxSTl2rneHtYdGjtM9FeQd4SS/fKnHG1fTsErQmNJhc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB4715.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(7416014)(6049299003)(1800799024)(23010399003)(4013099003)(4053099003)(18002099003)(22082099003)(38070700021)(8096899003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkhQTHJtNXYyU1dQSUY3TUxiVjJrU3duTDNlTC9paFdJNGRKNE00QlBnTjBQ?=
 =?utf-8?B?b0pWU1AyNW1SQTVMdFVlRWlCd1duYUZET2tBMjVJcXJaS0VxaE9DVlVqWTdK?=
 =?utf-8?B?WFY3UTVldGtnNGxGVFFWaVR4S015eWhocXI1K3NiY2o2VktvUTJidE01dkpw?=
 =?utf-8?B?S0hranh6THUrcENwUFd6RnNNQnFTbFpKSkdDREdJWFUrN0gydjgzRDVPcVVE?=
 =?utf-8?B?ZG5HU21iaEg1VXhYVFQxR1dORzN4emdPWGExN1Y2a2J1QlZwSEkvM1pXNUE3?=
 =?utf-8?B?NjI3WGhOekZVb2pGY3dpaUdhYy9SdGlEcklWeDZDYWViM0JQcTIvckdpSnJR?=
 =?utf-8?B?WnAwN2dXT1cxS3RHNnVZYmpkK1pxbXZMYklTaURwRTMwTGpNcEMvSHkyRlBh?=
 =?utf-8?B?ZDFRMDBVQkVYSFg2bnlaQ3BNc1VBU0FKRGphVStwYUNWZUM1WGtjNkdDWjRK?=
 =?utf-8?B?VlVObnRaTGlLTFU0V0NQbjlrWDlwc2h3Qk5CdHJ5TUdTL1ZSeEhqc3FlcExQ?=
 =?utf-8?B?cVloN25mQVNDVXdiTmtnV3VVdjllZDVrMWE5Zlp2czg2TFI2anNPa3k0aG1q?=
 =?utf-8?B?T2x3Vkhhc0pSdStPbXBmMExjRDdjV1c3MkJoSS8zQjNqZXAyWURkQkFnQWVl?=
 =?utf-8?B?SWwxdUZhU1MvSjJnamdtZEFTMGY2WFBVc0lFYnljczFhSGV2RDhIb25yZ1Fw?=
 =?utf-8?B?R25HZHBUd3F6VFJ6WVFhbWdMMnZadEprcWVCWldqVFdJUEhFSGs4d2JRYUxZ?=
 =?utf-8?B?OHUxSGwyblNCZi9QamxQWjZibmJrUWs5S0lrZkhkbGVaWnNIR0JHQTZDbjFP?=
 =?utf-8?B?YmNmenJOdzN5MGhJL1VvWmxCd2hIWndRSWw3aDdobFZEQVRIMERwVk1RcjRl?=
 =?utf-8?B?T3NqcjFpMy95enFESjdZTWhIVzJTZndNRW9rWW9KRm1LTjl2MXF2TGh4L3Ir?=
 =?utf-8?B?NUQ1QWZZQk1KWmhnT1lFMGkzVGNzTE0zdXNXRGhCbm12aUdJSjRPOW9yOVpR?=
 =?utf-8?B?bW9nbmpXbG5aSDRmUWlHbVQ3OEh4d1htRld5OWtqTno2SWZhMWMrV3k0Q005?=
 =?utf-8?B?RjNoVUF4M3ZHbE1SL1dlc2lacm1BSlFCRnp2QmJSTjR4ZjF1YXpIRFV4YXJU?=
 =?utf-8?B?RWVwQmdwaDRKMENCVWFuNzVhS1hWdFA3ZTFUdXV0NGVzRSs4eGp2eUtyU1Zw?=
 =?utf-8?B?SEZ0NlB2SjNNckY5UzBEQ1FSdis3MjJhMnd2M0FxYnAvZ01EV1FUS2xFK1k4?=
 =?utf-8?B?aXdDNWdpK2ZFeUtqY3o3NHVWcUhzc2tNZ0lvbjJCZWF5Y3VEVSt3QVdZWHFy?=
 =?utf-8?B?WitkUjJZZHZCb2xNTTh2ZHA5cE9ZeUM3L2RVWWRvbVdXK3IvZi81Q2hYb1FM?=
 =?utf-8?B?WlFNaEZxK0YwZy9xdVQ5QUFaYlhQMHQzbWFrVktqYmRkRVRNWk9Ma1V1OHpo?=
 =?utf-8?B?SnNQc0I5QW0wQnhFRUp6c3E0MEhxN2w1bWpOU2ZiNXN6ZTVqLzU0NWF0NmVN?=
 =?utf-8?B?dWdNSHVDZUJtOEQ1dVBvN1pQZUIrWG9iN1dURGw2RzQ4OUoyY2d5MmwzZXll?=
 =?utf-8?B?WnBIRVpEVENYY2pVdFpTNjI2YnNLL2EyQ2oyQnMxTDh4dWx3d2g4NjJtY3pK?=
 =?utf-8?B?QnZ5STk3K0UrMXpudnJIMWE0OUtuelpKRU5DYjVhZ25Ia0owalJ3QzN4UHNv?=
 =?utf-8?B?SnVaQ3FXajUzU2dSc2Fxb3JCdXk3cTZRSklUcHZuSGM1dk1jL0hMNWo3YmpK?=
 =?utf-8?B?WjBMWWN4djR0ZkRxUGZqT3FXUUQycCtJZmppQVBWZGVmQVArZjdOci9DVWs0?=
 =?utf-8?B?OS9vZmF6Z1o1ZHduaGVBRmJ1WEFyL3AxOGZmSU04WnFKTUp0M1F2NENaQXlC?=
 =?utf-8?B?NnVoVFB6ZGJQbzhjOG5KQWVSS05ad2hFTDhpUTY3UUc1RzhyNUF1UnJsOXRB?=
 =?utf-8?B?ZEJQMU5ocE5qTzFGSk1SOHEvb21lbytpTlc4TW80bm5sN1BTRm1paTRBcU9G?=
 =?utf-8?B?NHVwSTViYVZtV201bnV4RFdLMTNnN2ljeXF0ZUUvNXFvRGd5ZmJxQWhFTVc0?=
 =?utf-8?B?L2drRzlyVFJPdnkzNGROY1F6QlBjSnA1VXNpVWFrL3F0ckhlRWRCZTQ3K243?=
 =?utf-8?B?bHI5ak5sakFzWXVhRjhCZGZWcUlXZi82a0V2NFJnVlNMdHJnWXZWQ2hCd0s3?=
 =?utf-8?B?akV2dUVpeGFvRVpSeW85Sis1aUJzcUhVUy9Ic0EyYW93SXIyY2c5d2xOUDNa?=
 =?utf-8?B?MWtOTGJXVTQwR1N6N29Wdk9rQkRhWGRGVkNTU3FidWYxdjVaVFB0QmFMRVh6?=
 =?utf-8?B?WklSMnMvcGtxUjJFOG1YVkVncGFwc3BCdjB6TmtLSkpWMFNtRnVoWGozeWto?=
 =?utf-8?Q?aZKAK6pYGeB3g4C2m+PjAlaGvgtguanNTPZizFPpUOWJL?=
x-ms-exchange-antispam-messagedata-1: 235qt41EQ5m91Q==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGA2Gfp4SvnWrhDG+/9pijbdmNCpnpxKq2Ecrdt8/Yhlc6QejQDlXGgCQN46qeMs/DLEl8BONcTdud7vafjhxgpraZerrbnnaaBDOif9OhWZg7eP6dWboSZkF/Gl2vEVA9/bg805y7J6FAduqSsxvrQAq557NgFV/LQgFeAFqq5n4LPgp/d2nrkYslAk/l/D3y2EhgGtJ6jnB+vtAMusDeG8WGg9YAkr7EkklchUMRRehVhWGw4cMp9xpkLuSVoltVFNAo666CTy2tPrIcdPO/39GsIbsFQej5jXypa/IhagwuJQJXLR1ce+sovqeBUGdh73BFEq45tADP+c37CGBQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc8ZiZsxjRB5ZX3MxBiaosRO5MoPeg3lVEMIQjq8VO4=;
 b=xi9oeHj9tfY8oVz9e72K43sgvocpF+gu5KA8YjSfIKnDYgmY5eeWeOoc+HrksYRrUTm0kC2+H3xurQx3HF6u+odt1y8iogoSgtP9VKOom2HOlNc6zKk39PVGUBlMByChh9FZJ+ytVH1/whwMvlOXrJnWIBJk9JkzSEfBK7AcHRnbu8fJe3hNpGfXFqmZc8SHunbmoq8OERR4978e/ltAJwPgC5ZFXJu0iAU7zSxtAlA8n2ayJHITmYZrKUlpp4nxzgwNVtX1XguQKqrH9i4TvjbYmuXl8CfL5t3CFMveIHoupdAWrT2ixNg2jfHu0jdovGhXQJJWvadFYxz4Byx+oA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: QJqLRRCaTQAABbLCWDjsIDnEIXHHDhQzguJp2ZWSXo6Bh/IPSt1XcuRadkvZZjukL8kzwH4pzXWyXCSYJIwQgwUnUdvLeDybNtLNc1nYIaPxZcX5H61be5tpzEM+3FwqiYdQVGtlbqkIxaRq6I2bsos1gh2CCWPJ6ttIfuZHJ9KlVEPDe/+1+eYG/oU4BoG0/AZQUaJZamiCzBo7pY6IcY9fYRhyyn3bfECe7f+N2y8ZeAIkjcEKs5nUxsMw0eWU5cAAuR30P9fcuLGc5AGgs8UDPRyOJxpB891a4O+8HoBF6krG8qlciPwQzqNW+Sr/4N9ccYZaOqSf0vcZpDajzg==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR17MB4715.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 1ffe2665-2a32-4a44-423f-08def9dfb565
x-ms-exchange-crosstenant-originalarrivaltime: 14 Aug 2026 08:40:34.9417 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: og1Ic9bAijXA6nLJEqEjMg3M2s2R/Zaxm9Vi0mHG7xcRHHegNYR5X0bpsLQd1qJP3XahajkKzAtrloUm/c9Ayg==
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR17MB6569
Content-Type: multipart/signed;
	boundary="Apple-Mail=_BD5E4DD3-7434-4477-96CC-FD04E03477EF";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608140065
X-Proofpoint-ORIG-GUID: ZouCfp48HYYr3J_fCOEWzu041Nq9C9Wz
X-Authority-Analysis: v=2.4 cv=ebwNubEH c=1 sm=1 tr=0 ts=6a7ed48c cx=c_pps
 a=NaJOksh5yBwW9//Q5C/Ubg==:117 a=NaJOksh5yBwW9//Q5C/Ubg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=5uIk5skAYop0meUMGpPt:22
 a=VwQbUJbxAAAA:8 a=vva4OrSX13LlPEyilJ8A:9 a=QEXdDO2ut3YA:10
 a=U7u6gYCmvd8w0XX0ynoA:9 a=WX2fLfmELAhQyQ01:21 a=_W_S_7VecoQA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2NiBTYWx0ZWRfX7G/bg0tenxTS
 esUSZhN+b57oQfvp9qtrJYfIFl7dzWrpp9FTkatCNmxWDvgN4GTTdX60t08eZ7xE1UEnBpi2sUa
 455zZuwAStu0SpduR4u6xl0nxZLczQNf2rLdiUJ2Ga3RnRfLqoFYHUt/PoGnhaEQqA1lZlTP9Ys
 a4CAUxoDxqwDR9A5zwpOMS3qp+/2PrP3nY0dcLDLYON6asHSWAMhf22FIYSbk8o3J3H34znGp8X
 prOdirr58Qe4PnWUyy1U7Ybc1VIlec0Kz7vpLCTKhf+q+wsAypKxh0QH8wBaDu3TC9xLytd0xMg
 tPCkfLD5PWqTSW3m+WkNf82kKfv+aDzsIO9enL3lmuQeCy0cjcyzpqdlVl7sJncxKsKmIn/MNkP
 hto1GtK/5a6hcREFbysWlyuKQlzuKnrZ3sNOFB26iib1aJjRArzsOXP4AwD8PHeDeFK9BppvFRL
 UibpMffHEr23/UgzJ+A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2NiBTYWx0ZWRfX38jW6LLfxnwb
 e5Cn8sozDuBdL/Rkedwc77NYcUchqyKbpIAujsqF5zT4dPK7B0PS0Rov7edNYC0NRfF1ObHS8AA
 0yDh7HOooEOMKPLhk3rC2MDNPXfjj5k=
X-Proofpoint-GUID: ZouCfp48HYYr3J_fCOEWzu041Nq9C9Wz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608140066

--Apple-Mail=_BD5E4DD3-7434-4477-96CC-FD04E03477EF
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_525DAA1B-548B-4587-A3E2-AEBA2950829E"


--Apple-Mail=_525DAA1B-548B-4587-A3E2-AEBA2950829E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 12, 2026, at 11:33=E2=80=AFAM, bot+bpf-ci@kernel.org wrote:
>=20
>> bpf: refactor masks for ADJ_ROOM flags and encap validation
>>=20
>> Refactor the helper masks for bpf_skb_adjust_room() flags to simplify
>> validation logic and introduce:
>>=20
>> - BPF_F_ADJ_ROOM_ENCAP_MASK
>> - BPF_F_ADJ_ROOM_DECAP_MASK
>>=20
>> Refactor existing validation checks in bpf_skb_net_shrink()
>> and bpf_skb_adjust_room() to use the new masks (no behavior change).
>=20
> Does the subject line accurately describe what is being refactored?
>=20
> The subject claims the patch refactors "encap validation", but no =
encap
> validation is refactored anywhere in the diff. The only encap =
validation
> in this file is in bpf_skb_net_grow() (around the middle of filter.c),
> and it is untouched. It still open-codes the pairwise mutual-exclusion
> tests:
>=20
>    if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 &&
>        flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
>            return -EINVAL;
>    if (flags & BPF_F_ADJ_ROOM_ENCAP_L4_GRE &&
>        flags & BPF_F_ADJ_ROOM_ENCAP_L4_UDP)
>            return -EINVAL;
>=20
> The newly introduced BPF_F_ADJ_ROOM_ENCAP_MASK is never used in a
> validation expression. Its only consumer is the composition of
> BPF_F_ADJ_ROOM_MASK. This is still true at the tip of the series.
>=20
> The commit body itself only claims refactoring of bpf_skb_net_shrink()
> and bpf_skb_adjust_room(), so the subject, body and diff disagree.
>=20
> Could "and encap validation" be dropped from the subject (e.g. "bpf:
> refactor bpf_skb_adjust_room() flag masks"), or should =
bpf_skb_net_grow()'s
> encap checks be converted to the new mask in this patch?

In my view the suggested subject change is not worth a new series as
i) the current subject is not blatantly misleading.
ii) this patch does touch the ENCAP related masks


--Apple-Mail=_525DAA1B-548B-4587-A3E2-AEBA2950829E
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
class=3D"Apple-interchange-newline"><div><meta charset=3D"UTF-8"><div =
class=3D"Singleton"><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: 400; letter-spacing: normal; orphans: 2; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration-line: none; text-decoration-thickness: auto; =
text-decoration-style: solid;">bpf: refactor masks for ADJ_ROOM flags =
and encap validation<br><br>Refactor the helper masks for =
bpf_skb_adjust_room() flags to simplify<br>validation logic and =
introduce:<br><br>- BPF_F_ADJ_ROOM_ENCAP_MASK<br>- =
BPF_F_ADJ_ROOM_DECAP_MASK<br><br>Refactor existing validation checks in =
bpf_skb_net_shrink()<br>and bpf_skb_adjust_room() to use the new masks =
(no behavior change).<br></blockquote><br style=3D"caret-color: rgb(0, =
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
display: inline !important;">Does the subject line accurately describe =
what is being refactored?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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
display: inline !important;">The subject claims the patch refactors =
"encap validation", but no encap</span><br style=3D"caret-color: rgb(0, =
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
display: inline !important;">validation is refactored anywhere in the =
diff. The only encap validation</span><br style=3D"caret-color: rgb(0, =
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
display: inline !important;">in this file is in bpf_skb_net_grow() =
(around the middle of filter.c),</span><br style=3D"caret-color: rgb(0, =
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
display: inline !important;">and it is untouched. It still open-codes =
the pairwise mutual-exclusion</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
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
display: inline !important;">tests:</span><br style=3D"caret-color: =
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
display: inline !important;">&nbsp;&nbsp;&nbsp;if (flags &amp; =
BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 &amp;&amp;</span><br style=3D"caret-color: =
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
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flags &amp; =
BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
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
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;return -EINVAL;</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">&nbsp;&nbsp;&nbsp;if (flags &amp; =
BPF_F_ADJ_ROOM_ENCAP_L4_GRE &amp;&amp;</span><br style=3D"caret-color: =
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
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;flags &amp; =
BPF_F_ADJ_ROOM_ENCAP_L4_UDP)</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
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
display: inline =
!important;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;return -EINVAL;</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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
display: inline !important;">The newly introduced =
BPF_F_ADJ_ROOM_ENCAP_MASK is never used in a</span><br =
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
display: inline !important;">validation expression. Its only consumer is =
the composition of</span><br style=3D"caret-color: rgb(0, 0, 0); =
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
display: inline !important;">BPF_F_ADJ_ROOM_MASK. This is still true at =
the tip of the series.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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
display: inline !important;">The commit body itself only claims =
refactoring of bpf_skb_net_shrink()</span><br style=3D"caret-color: =
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
display: inline !important;">and bpf_skb_adjust_room(), so the subject, =
body and diff disagree.</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
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
display: inline !important;">Could "and encap validation" be dropped =
from the subject (e.g. "bpf:</span><br style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 12px; font-style: normal; =
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
display: inline !important;">refactor bpf_skb_adjust_room() flag =
masks"), or should bpf_skb_net_grow()'s</span><br style=3D"caret-color: =
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
display: inline !important;">encap checks be converted to the new mask =
in this patch?</span><br style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: 400; letter-spacing: normal; =
orphans: 2; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration-line: none; =
text-decoration-thickness: auto; text-decoration-style: =
solid;"></div></div></blockquote><br></div><div>In my view the suggested =
subject change is not worth a new series as</div><div>i) the current =
subject is not blatantly misleading.</div><div>ii) this patch does touch =
the ENCAP related masks</div><div><br></div></body></html>=

--Apple-Mail=_525DAA1B-548B-4587-A3E2-AEBA2950829E--

--Apple-Mail=_BD5E4DD3-7434-4477-96CC-FD04E03477EF
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MTQwODQwMjRa
MC8GCSqGSIb3DQEJBDEiBCBc+Q2pOgVmq0zBl2x40a8xgMcJnhIkeH4NFc5gTI6myzANBgkqhkiG
9w0BAQsFAASCAQBcsgqYMXCtiPkH5t/7OPY9Cy/KX0HGQ+3P4S4Laci4TNzAaSghjTDNs15m9PyI
s/77vO1JKRXg28sS/fq8zx49AiIj8bh3zmBwExS1XIzwxPvJCaW5LqYE1V9CC6KERUJLMqBtsHck
klhW8Ra48zazInGX8zHOn02jS6HWG0AUMsg9LI6wGvsBTMv7zHXWBMz4XvbAqNGGEHHzteqzoz5r
77IipGKjgvBxzaVsuIvUScjoczFrj8OFe9MvjKrpy1RW2W0xV8JU3qsTflcv209UCtwgFAwc3gHt
g2zmRjyHowjNsgofrt6sQflZOF7+bWAIo2MLGpYdKcLCExcqvbR3AAAAAAAA

--Apple-Mail=_BD5E4DD3-7434-4477-96CC-FD04E03477EF--
