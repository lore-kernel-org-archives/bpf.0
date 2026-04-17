Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF8390207;
	Fri, 17 Apr 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776426296; cv=fail; b=HcKzGiKm56JK8n5iM/HuepJfxsj50jAay7FvkS9oKOOVUXv8lsTQBobdZwY+Bz8TJrNK/BZuHVz3fnBumFFGIgTbzUyt6MrORMD8vmn5Cn/+Kzx6hr7a0SZRqreHBr/elaWjtG7O+GiJjI7a6Urrlc5Xs6RquCHWEwShjLXjMpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776426296; c=relaxed/simple;
	bh=/gVs8K8nTa0NtqJP0UEX2RTrus0m1PWEqus6hfNWsjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTfF8whPreEhFuMcpQSU6ogDDg5f+wf5rhxYEXLfiJbGQYOb9cjIUYv6brLZksnrJ4CQZVRpbqwSD27tffdgHRmAgOUzs+E/cvupyHUw1TSDCQhKM1xFZPpAxcck3+48EvGhDJpc8UBna7fMO/nTcCtNVhjLANe0/5KpXNE56hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=h+wqgNZg; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="h+wqgNZg"
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
	by m0409410.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 63H7qLF33757023;
	Fri, 17 Apr 2026 12:44:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=jan2016.eng; bh=PNxIk82mb14gXfP5JiBqsH
	WuIV1vpszoJFFj2plFTss=; b=h+wqgNZgF2m8aXq9lCUD4psGm2zhIHeGU9vtMb
	HMiD2Gk7PLVdHGx08c9whXoY1AR7DrhtTLvYaiJE0X38tcKampEV8Ecso9O3y+/d
	+W2fiQgxaJrlBzusVzbRkpcAIeX5JXrX8irQ4gM919jmTlmPD77U+GAk65uQqt16
	g0mQlOK7xkfzwyaMHcprlbGrTY3vjuG1FLtCgdK5ex7MZr1NktNOEkUOLyT3hg4Z
	Kg/4G7v+cRczG5ub7v0O10Na/XHReAoCYnnsQEtg2ljevJb87WV3K4yJrDhn+Jff
	+1Ty60wvQCJDt7wXqHfHMDtu86eKJF89D5YS4yRzBz5/qS3Q==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 4dg177evjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 12:44:46 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 63HBfeal006557;
	Fri, 17 Apr 2026 07:44:45 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.221])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4dj2x5c3s0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 07:44:45 -0400 (EDT)
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag5mb4.msg.corp.akamai.com (172.27.50.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 17 Apr 2026 04:44:44 -0700
Received: from DS2PR08CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 17 Apr 2026 06:44:44 -0500
Received: from IA1PR17MB6075.namprd17.prod.outlook.com (2603:10b6:208:3ad::12)
 by IA1PR17MB6076.namprd17.prod.outlook.com (2603:10b6:208:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 11:44:42 +0000
Received: from IA1PR17MB6075.namprd17.prod.outlook.com
 ([fe80::51e3:f458:da2a:4433]) by IA1PR17MB6075.namprd17.prod.outlook.com
 ([fe80::51e3:f458:da2a:4433%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 11:44:42 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: name the enum for
 BPF_FUNC_skb_adjust_room flags
Thread-Topic: [PATCH bpf-next v4 1/6] bpf: name the enum for
 BPF_FUNC_skb_adjust_room flags
Thread-Index: AQHczXZgpihCy5OCZUG0GujphV0eXbXhdVCAgABHpQCAAWc5gA==
Date: Fri, 17 Apr 2026 11:44:42 +0000
Message-ID: <98A92F48-8784-479F-ACC4-87EA20559DA7@akamai.com>
References: <20260416075514.927101-2-nhudson@akamai.com>
 <20260416100225.178D6C2BCAF@smtp.kernel.org>
 <DHUN7O2WOLPC.107WH88I4E15I@gmail.com>
In-Reply-To: <DHUN7O2WOLPC.107WH88I4E15I@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR17MB6075:EE_|IA1PR17MB6076:EE_
x-ms-office365-filtering-correlation-id: 101d0bb3-1ad0-4213-8074-08de9c76b6f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|6049299003|38070700021|4053099003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 7Pmt/6B3Ymwpb3DjJYokeOWBdECrcboV+graShCAE+Mwqzozjje7TWc6NNqtQL+gO+0vMPoVLbazU2yZWqlj/l5py6fr5G+GoReFhzAv0Y+2uhexBNo/ggm8sB0wiyBd8A++CWnmfP4AgpHJbhr/bN626nbN0hpxVqBf7yB/TtXZpwEG7pdq8Ul6vHqtVs2Yv3MpDY7x/jiP5FnUZ00vZs8Jd7ZrshXLzb5gKgYvwaO3Ge5TYkBlxLQzmJC2q2CA0/nQItKZUhDe1tVDmmNSEiWf7E+vaP3s0bm1C2W/MY3kTOF0Xcel3GhwLoVK76a1wcWzPCRYgDNyyDxkQNro41bEzXNwc1vUpxzOnVLgxlFlSi8a+1iDVNUyw8dcTCYQ6vpQFX3wUgdsVymQu8GDGaYo02sPhUKjXG/qd73DUk7P7NLmcsWRQnrqBgv7soikke9PVDvAimJcA3mRdHkteiPm/FGmuouX7lxeriWIdxhYj51LAUd/iXbDLDiYz5RZBCVvmLxnf+KopjTt0XtrXbduDIZlyURYqqFwAR57RPZw81HUi4mBTWsMerX3xCa9ZMPq80beAES65nec9nSJvdTrUvNAewlTVMHct9XdMJyqpP0VVZspJtK8/JzRFS2LsAqkMZwI+bzT4gkl8JZggkcmsSZtgNtNrkl4kLcpbi+FbAqMLsvmcjIeXzipLQZkXkzjt1fRQ6ylD9H0YTWK1xh1zItow5ylNszDe90QEjLTyg4408SRDYq3qGbXyt8gET0Y0oQ6c9n1k49DapvEecY3ytZcTY71W5prgtV6Slk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR17MB6075.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(6049299003)(38070700021)(4053099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y21kQndxaU1QM25IZmZUd0Z5YktUakFGZ3ZWL2dFbjgrdzVDRDFWSWNsWnFi?=
 =?utf-8?B?NVhWd1paUHoyVm1WWitWV1c1RDhUNktGN0NpRnAxblJlNjczbWlSSFhGQWp3?=
 =?utf-8?B?NEU3SmdRM01neUQ1SThxM2s0RW40KzZsUjAxT1dPS2dVdTlWblBOaUZqR1p2?=
 =?utf-8?B?eDlaaEkrWXNHalRUdm1BT3BYSUs3Y3F0ZnFkUnBkaTgyRjRMR09MdzhjTk40?=
 =?utf-8?B?T3VHRmZLTzIrYVhxZ21NZWR0SlZmcGFjTkg4bjN6MGN0cmpzNzNQNXIrYllK?=
 =?utf-8?B?b0ZIeWRGVXZQczNzalJJd2wwVDAzNm1nRFJJaStsR3NEWUtjeWFJTEdQVDYy?=
 =?utf-8?B?K29MMHZDSElRZmlsOFU2ZTNKeTEvWVpVbXRYbWREZWlLL1lyRFpwb2JadmNW?=
 =?utf-8?B?ZndXdVh1eTFSU1YrUEQyYTFXejdJRi84ZEdTckdqNWNXdFhHVzF0RnRGOUJ0?=
 =?utf-8?B?c0VOb1lYZjBBdVJpVlVKRTBzYTR3a2FEUnQzcW9kcGExSkpRa3A2SU1WQXZQ?=
 =?utf-8?B?WWt4Rlo3VnhiSW1CcVVIRUE2QWNHYTBOcHNoeE5PQzcvOHNVYlBNMWFsL09m?=
 =?utf-8?B?QmhVQStSbU55aTFkOE81c1ZUZHNFOUlyRCtYM0E0KzZTV0UvbVhnaDB5eFJk?=
 =?utf-8?B?cEs2T29UNHBabGpvNWJlclBwaGZJOEJCS3hWSW9lQkJBKzQ3cHBMUngzOHFm?=
 =?utf-8?B?TExJRmRkM1pPdDlmOXlIMlNTVnRQdC9zZ3hWWXVXeDJibnpKdnU0Q1RmRlVZ?=
 =?utf-8?B?dlJZRHNnS29MVWs4WlgvWS91czVreXhtMko3b0c0QWVDTHN4bjBMRXZ0Vnoy?=
 =?utf-8?B?eHROaUthZk5sb0xnbUtGMU5ubFRyaW04RnhFMFZzRnFvbk05ejZMQ3IxRTNu?=
 =?utf-8?B?VG4rdEpHa24xSnNwRTgwZUFmbS9DOGdiTEd6R2RKNVpZdHpRZ1VQcGh6TTVW?=
 =?utf-8?B?VmJKM2JZUVkzaENEWDBWMUJ0QWllL0N0VmFOS3U2SGRFOWJhRHlaUVBjQ0ZI?=
 =?utf-8?B?b3FoUWxlOW1IRDRLMWdrVmZDdnZSY3R3SVZudFlqOFBETGkxOHArN0hheVN4?=
 =?utf-8?B?ZytOR1E0MFFrOGtHeEpYbmFDVkhZZ3EzbFF4aFhqZWdoNFc1V3BneGVFR0Ro?=
 =?utf-8?B?SkU1SlhNRk5ENVVPS2cvNitiTTVIQWw0ZzcxWERJSDZESUQzTzlSazRQUjFJ?=
 =?utf-8?B?ZXRVQTFKVno4VTBhYjNNNTJxa0pGRnA4SUIxOFRMdHlqTHhwakZoNElSU0hN?=
 =?utf-8?B?em5acDRGUzcycUJCREdKaWVkK245RVRQK0JXYVFaSVE3VHA4aFJCdVF3UUNq?=
 =?utf-8?B?eFJna0VQQjd4N2VIMVFJNk9FQ2RlR2pMNzB2NVViWWc4bTlkRDZaTUMyZndI?=
 =?utf-8?B?Qnpma3JXZkhlOXUwUW9MK0Q5UWNFMUVZblBFTVArdXZGd2VMUnF2dC85VHBj?=
 =?utf-8?B?c1g4ZVRKK2tBYmRxQjZtYnFZY2RPT05hSlZZWmsrSnVlK3dxTG4yZTYrbEdu?=
 =?utf-8?B?QWttMmhMY2RIQWRnZWs3bHdMdXdTc3NSd1JSU0FnUmd1MFBaeGQxajhuRzkz?=
 =?utf-8?B?OEVFY0pUNUR2a0xScHFLdkEyMFZWbDVyNEx4WUJtVzBZSUZKbDFpc3ZoaFBU?=
 =?utf-8?B?T3V1eUd0WUI0OVptVHNQUnV0VGZXRXhVTS82NDhlcit2L2lDZ1l2ZnYwckV0?=
 =?utf-8?B?dzBDZVlDUHo5bXNWa2hLeFA3OFkvTXZGM0dRdjc3enZQV29mU3RXRytUYUEz?=
 =?utf-8?B?MnJwVFNoeXJsdXFCLytqQTFxRnN2cjJ4Nzl1akhwbmZkR3pZZlNGWGJkUHcx?=
 =?utf-8?B?TlVHZktWbnF2Q2ZiOWkxcGVveXNXUUN0bUpPRGRjRXdXbnRhY0p4NGJ0N1No?=
 =?utf-8?B?czhsQVVENU1tMFR4Q29OVU4rWWQvOVYvdjJjYzRoeWNjMHhtWTZiQktreVpS?=
 =?utf-8?B?bDVNTTRxa2IvcUd6MFpZMjk0eXJOZTdZeHJzTnkvVm56dWtac1NVM1NrQmVn?=
 =?utf-8?B?bmJaR3BmYmI1ZVNnTFh4TUdiQnRZZXRsVjhnWlZtem1wNkE3WUlzZVNrUXNN?=
 =?utf-8?B?T0h6RmZUTUV1MTMybm9iSXFmUjFpNnEvby9TUFJNMjZ2dmJKK0xiMUU3c0xB?=
 =?utf-8?B?a3VZV3FoazEzaDRBWVFtTFg4T3NsWXZsUXg1K3B1T2dseFlvRkRQVkdtbWxK?=
 =?utf-8?B?T1BtWnhGSnhBbnA1TUVYSGpTditMSGdFQXNVQ0tEMXprektBS2FaKzVScE1u?=
 =?utf-8?B?ejR3UG12NEZyYmxGREN5Z2ZkYzBEOTdLM0huQWpwYnMwQldpVU1Sb3BNQVgy?=
 =?utf-8?B?K1RFSmViYWozR1ZKTThmMktObWhtZENhVVNmWkNRTkFTL0JCZDBvcUoxU1BQ?=
 =?utf-8?Q?ZBchL/85EUjYPi78YQoL2qk2geyKEuW00Gjp49eD7lAqQ?=
x-ms-exchange-antispam-messagedata-1: T7mtmRZ0UMXCyQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQ7JOasbk8Hbi/ksTfRxZFivTDCkAUJf1VkrbS+FtSD26yDnSGb/PstdCIe7fwtpBCu9MEnUJeHPS8scOEl0jToTcYCg/e51EA/EsBz8ssAbTxp9DLE9Pdk+u65wacVuN+81qnbDdEHEYpZfD9n0ZsDihf5mvisp8isVD9SoxTPOAiIGHrcR9bI8tDjd8xy++33ZmlbBJiFsqA4o4Ox6bddrnJJ40Scf1BpfVweXBCUZ0U768GTuBBm4nD1Gesavh0w2dO/wNwtnNwKo8u3gAZmuyA4IwxpT+RlyF19fCqo4Q4bbhYxuj3P5pjBaCCpGmTbFe+/L0K/WDFu8iWBSLg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GclI9HNJjqsEd+hgZmtHzWXIEarVB656KWjvYIfW2Mc=;
 b=fAOYJCEEFZbL422nz1yG+5D59QigU3mykA/cYI+fSl2NPpWicQi/bnCbb6BalzwHEvGHq3KLhIqQk/qpNW3JZsa63DQUlpdimCOIZIRQIAVDmc8N8h6MOr24XMD4Lna4LjUVPbrN0bZZ/x6dXRnnrNYnU0sOdFzmLMd60d+ojplfx+nAd9tR5T/BxHye/3CfJNDUH+xL2Wg7ktMhbAK+ngz/4xrm+qlyU4kKRxfCwJiTBCj0qyaU0i8THnmylWuwaPGVOBjgu3MO/Z6hL12boIt4fzAABSu3cb3/ZkZyx5oPYh8OBQyqkai2mZvaMOIOfzAOW2MFH2PUmU1jtneTNQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: o8ZknIqfxA2JOO7KnEVcdbggB6yg5oekmPplDNkTmVhzfV+859oaQo/FeD5pWQ2wR7i0EJWgtqcOXIIL6n9SziN+N2KDBvRTQo0xay9IiRe+tN0DC1wfqacm7NSzQKaIqd7mhMgRP9kFknf5lp41ALjgEBY+aMwC00Hsx+nva/Lt5wvYcI69IXZGN2NFTK4CWDn+UpwzG4GHjwwG/PfEl5Hb6ZvsPmJFW+5T0/2oDm58zdc7q+jFU3gIKf/JaddUyLw/zMZ3ri+xgZcdlp4tFkHTTTVq09DJm7Wg9rB29ZnrwEIA3ygdtNwV6Jgd/2zofLXtmEwMwKvo7x0ubDQgZw==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: IA1PR17MB6075.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 101d0bb3-1ad0-4213-8074-08de9c76b6f2
x-ms-exchange-crosstenant-originalarrivaltime: 17 Apr 2026 11:44:42.2131 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: gccFr+dIDufYvgIdRb+M0rMiQZVz5FnzDd5CUL5vgTuPu7kXgqGlKxThqhABZJWr4Upwjhr47PdAHnN6Uu51FQ==
x-ms-exchange-transport-crosstenantheadersstamped: IA1PR17MB6076
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_193D7BB8-4867-4DBD-B321-4FB2A25B133E";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604170118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDExNyBTYWx0ZWRfX9xoKTvFzh7Sc
 1TfXdba1652BEu5oVD275pmQmjCz+kWqDD51YIY7BJuvA0Gk58l6waxBbMOXpb7zWvIoDOzwSq2
 rNOCB2qfetde9vz3jAi0OwR19CVkQ3Lc6Ndx19G5x6k3d42Qx0X4rqH8jlly04UrvfJerOFl/xd
 ZSwtjrXLForNYrUM/X6o//4AzTlPK+tvPMZ4UqZD7NOqAkVYj5u3599KITZ2ok6ZRAYQ4WuQfFY
 a3XkUwn7GdgeOO1H1cGgP5FoFD6t4pljZXo2Zo0tB7C2n5xwSEaDvRXVkbT2wDnxVfdQqSD+ii2
 228zeOa4Fv55AZ7fqCbjQ0z4wNNvvCdqGQH4O3NEzvMzxTj5XcIVQv58wyhnfzQtYpf8XfhoFbz
 h5u+JSEsJwvXQIGqx0dOygxz/zo2QHysI24swb5WKZp4zG6LlBi2OGBhevCngjqIWumT6gGQ/4u
 /Hw5wT4Hf5IJI51+XyA==
X-Authority-Analysis: v=2.4 cv=f8V4wuyM c=1 sm=1 tr=0 ts=69e21d2f cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=KDzEjHMMTas96-nIEKpj:22
 a=pGLkceISAAAA:8 a=X7Ea-ya5AAAA:8 a=9nHrlnqbnjsX-zf4HxUA:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-ORIG-GUID: xQ4rOmh9c5qsvxOUe84S-K1alqucnKyE
X-Proofpoint-GUID: xQ4rOmh9c5qsvxOUe84S-K1alqucnKyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604170117

--Apple-Mail=_193D7BB8-4867-4DBD-B321-4FB2A25B133E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Apr 16, 2026, at 3:18=E2=80=AFPM, Alexei Starovoitov =
<alexei.starovoitov@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On Thu Apr 16, 2026 at 3:02 AM PDT, sashiko-bot wrote:
>> Sashiko AI review found 1 potential issue(s):
>> - [Medium] The newly named `enum bpf_adj_room_flags` will not be =
emitted into the kernel's BTF, rendering the intended CO-RE lookups =
non-functional.
>> --
>>=20
>> commit d9be60117de7ebbae2642c8a29e31a5aa11ff502
>> Author: Nick Hudson <nhudson@akamai.com>
>>=20
>> bpf: name the enum for BPF_FUNC_skb_adjust_room flags
>>=20
>> This commit names the previously anonymous enum for =
BPF_FUNC_skb_adjust_room
>> flags to bpf_adj_room_flags. The stated goal is to enable CO-RE =
lookups in
>> BPF programs.
>>=20
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index c8d400b7680a8..bc4b25eb72ce5 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -6209,7 +6209,7 @@ enum {
>>> };
>>>=20
>>> /* BPF_FUNC_skb_adjust_room flags. */
>>> -enum {
>>> +enum bpf_adj_room_flags {
>>=20
>> Since this enum is only declared in the UAPI header and never =
actually used as
>> a variable, parameter, or struct field type in the kernel C code, =
will the
>> compiler generate DWARF debug information for it?
>>=20
>> If it is omitted from the DWARF info, pahole will not emit it into =
the
>> vmlinux BTF. This causes libbpf CO-RE checks for these values to =
silently
>> evaluate to false regardless of the kernel version, which seems to =
defeat the
>> purpose of this patch.
>>=20
>> Does the kernel need to explicitly force the emission of this type =
into the
>> target BTF, for example by using BTF_TYPE_EMIT(enum =
bpf_adj_room_flags) in a
>> compiled C file?
>=20
> Nick,
>=20
> take bots feedback with a grain of salt.
> I suspect the bot is wrong here, but do you homework.
>=20
Thanks.

I guess it depends on tools?

$ ./tools/bpf/bpftool/bpftool  btf dump file vmlinux format c | grep -A =
10 'enum bpf_adj_room_flags'
enum bpf_adj_room_flags {
	BPF_F_ADJ_ROOM_FIXED_GSO =3D 1,
	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4 =3D 2,
	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6 =3D 4,
	BPF_F_ADJ_ROOM_ENCAP_L4_GRE =3D 8,
	BPF_F_ADJ_ROOM_ENCAP_L4_UDP =3D 16,
	BPF_F_ADJ_ROOM_NO_CSUM_RESET =3D 32,
	BPF_F_ADJ_ROOM_ENCAP_L2_ETH =3D 64,
	BPF_F_ADJ_ROOM_DECAP_L3_IPV4 =3D 128,
	BPF_F_ADJ_ROOM_DECAP_L3_IPV6 =3D 256,
	BPF_F_ADJ_ROOM_DECAP_L4_GRE =3D 512,
$


--Apple-Mail=_193D7BB8-4867-4DBD-B321-4FB2A25B133E
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA0MTcxMTQ0MzFa
MC8GCSqGSIb3DQEJBDEiBCDt79zgX+r6fHBcJf2AofKV0H1z6SldhIwpmJ37vPxlrDANBgkqhkiG
9w0BAQsFAASCAQCzvCxe/jueOkPmz5YdoLZwdkmnsc5X/HNz3wYUmLjd1cdX8n8fV1HfA9l8Acm4
So5FlCsOY9AYMzgpsGED29PGH6AG/thoPEW18UN2BTEFH6TMNPBIDXaYvFTpyJTmx/Sc9VUfe+WA
CB1k5/Y2Y4gcX/XtZSdoERsPJ7jCPKdmiOVo8hfFM5lxPh1xitXEkP4QciTKZYSPXLYnIj9VWzQL
HJObWYNCXEpV7n6VMNQoZN/NXyRcNPjX5zIVOEd7D1DLW9RF+Jq5agyh63rBdMztnQrxq+DIAn0C
/tJvz/nP6Jni3zIde6V4fggharNaFjpE5zdCVSA6YEkb503q/B3pAAAAAAAA

--Apple-Mail=_193D7BB8-4867-4DBD-B321-4FB2A25B133E--
