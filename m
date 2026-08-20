Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673E449B3B;
	Thu, 20 Aug 2026 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.157.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231979; cv=fail; b=bSRL9Y5Wx6DH5+R34nqsG1JODM2LND9u7ZxmlthgnPAtDhFNVNf2L3dyUfg/8Z4gz9uNRUkWmoyZtDoXq88/97AOxRifYw5vE85pQZaiJktbpkXGeRmdLGsJU2N7ye2LsqgUkmFG2QDHuBQWn9Xt1Nc963G3ajVtksqyvGvwZZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231979; c=relaxed/simple;
	bh=uAezajojyCMK7qtswjTAeeTkn/ivj3JZfJxP98rdDw0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FSvdH8cfLLj9gCB5bUxfwDYxNgZypwBE0TxpwPpAesvg8IDL5Zth6jIel3QXG3DrkTQtR39yOvSFGk9mNzkXNMcpeM07a5pbeITvHGEd5nCEKaRJFGlzCZXcY0ZLH9u8Whgde8h043LHGisWmbmlPme1gJsPlACVs6vHqiqF+Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=l7Z0NXLR; arc=fail smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="l7Z0NXLR"
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K75Sep3866648;
	Thu, 20 Aug 2026 14:19:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=X0UchAwStADM+4R70Fvmkw
	1ffIQjwlgXGRHyAWSF50M=; b=l7Z0NXLRng02t+lW3lUpmJzLt4UyAgj9dQeSX+
	trfKXo5FW68ibujigPQ0Z977XePCWAPCTktvwJc+zCS7wzj6lpDpa2vumb7Ksk2c
	DWrtZsxRp2vJ8ARvEtxjYU0Xr7OWIwCbFGz57m8pO2o/84iWxcxlzNeAqXB9ClnT
	11xe2YXMpC0IE2Hm8cCkRn5zTbkkSPAMKcln/p9KhRIrD/wSejBpIvjSry1dPOb6
	xqkHlbfdnqrZIgjVH8/Kp+KlPaky750ESEILXT3UJzhnPewf1czbEhQDdCcyPyO7
	utg8EO95BW5f15yfC2ir43br0X4YkPrhOaX21Zk3KuXcX3hg==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4g4yetj5bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 14:19:05 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67KD58Y0030648;
	Thu, 20 Aug 2026 09:19:04 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.220])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4g2kex4jhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 09:19:03 -0400 (EDT)
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 20 Aug 2026 06:19:02 -0700
Received: from DM5PR08CU004.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 20 Aug 2026 06:19:02 -0700
Received: from MW4PR17MB4715.namprd17.prod.outlook.com (2603:10b6:303:108::16)
 by CH0PR17MB6936.namprd17.prod.outlook.com (2603:10b6:610:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 13:19:00 +0000
Received: from MW4PR17MB4715.namprd17.prod.outlook.com
 ([fe80::f5e4:82be:a01e:da25]) by MW4PR17MB4715.namprd17.prod.outlook.com
 ([fe80::f5e4:82be:a01e:da25%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 13:19:00 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Daniel
 Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Eduard Zingerman" <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi
	<memxor@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel state
 without false-pass gaps
Thread-Topic: [PATCH] selftests/bpf: tc_tunnel - validate decap tunnel state
 without false-pass gaps
Thread-Index: AQHdLwmO1g7jt3ZHxku0bLrgWnyx/7al5uwAgAEH4IA=
Date: Thu, 20 Aug 2026 13:19:00 +0000
Message-ID: <99BA57F4-2872-4080-BBD0-97CA203461FA@akamai.com>
References: <20260818120308.623905-1-nhudson@akamai.com>
 <DKT8R9H3SX3Z.2PW8ZOHVZ5QFN@etsalapatis.com>
In-Reply-To: <DKT8R9H3SX3Z.2PW8ZOHVZ5QFN@etsalapatis.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR17MB4715:EE_|CH0PR17MB6936:EE_
x-ms-office365-filtering-correlation-id: e6b705c0-6edc-4ce9-6210-08defebd98e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|23010399003|6049299003|366016|4053099003|18002099003|22082099003|38070700021|6133799003|56012099006|10067099003|5023799004|4143699003;
x-microsoft-antispam-message-info: h6OVJy49LDzOSI11kzSIpBw4qxuXMB2INKjLA8snws9O//VJaef6JcEwDkWTAfraNn8J3WQnT5QnnRkvY519wqt2X5SW80aoNpkBeXgGO4SxJlH0L1cCDBKH/suSHAYBJNcio9OiwoWvUIFkXtQ7xyTltH7hfWgNUsw3tzc71xyP6qdve/R/fhkVXGygFcuS3rBYfwmwfyHtYH46ZNkkaFzT661XI1RwS6Gzp0QmVyIaO4bQP0GcLaYKAzhAJR058E6DePgDi8M4hALcc8c0I8mb7yPZGU5A+UgGb8WLViiAgA6hn+knkryqVeAKnQWWVgI3SttQUd04I33rTrFVy4Ixq5ZGm7Znixmv1sHUjK8D4aFzym5UIC5BNH5aFCdyKxtR1LrLMZDA/owEAK7bzbmcNux79ILJWqdX2xGPhtRiBNOLmt/Fsg03jtsfS3/tupUY7OS+CFTWA18ISn9F/O81CEbQgl8CoTjVFdnMXMuo9JS+eg5pFFbodHxHDo8FUkkZS69neMzB9YEl3yMEz0aXOjUaqd2dV3yd+xP4RzoOuF0HtJyRr52Aax0kUM6BybvV1zqFYNfLpFI/1cbXr95WP1tNIjyNBRN1qJd7xqXo0hKTMnQ1T9jipoU5hNcI0W1wR1ZfpDwLigx8X+XJ+WRShXCS901T3XEj9jQ8oolV8fmkEiH11GWgiwDynbI0zM8a2Gq0nCOs3EF6oby7vcPqmNjKG6lHEkJuUILvx90=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR17MB4715.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(23010399003)(6049299003)(366016)(4053099003)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006)(10067099003)(5023799004)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N280dHErZ2hoZmRxb3VxeG1vWWRZNFg4b0VGbVpWOUg4cGV1SEdySmZaWVc5?=
 =?utf-8?B?VGNyTi9mRWtXQXlzVXphSVVrdkh4b3lDWnJUUzFGYitmdUFYeVZHUzdRamcv?=
 =?utf-8?B?TzZqK0xFZmswM1FHNmMzRmNGMEJxRk5uZ2s0UFh1VjZ6SjhtRVFpUDh0TDZB?=
 =?utf-8?B?aHVyaVpGam4yenMyRDc3ME5vM3NvcGVTTkxRSG1mb0dhbzhrRW1IMTE0NE5m?=
 =?utf-8?B?R0hFSmQrM0dOeC9uMXJlbFhrbWVPZGxCeXNTdnEydDJTV2dhRVNvQlZqK3Jh?=
 =?utf-8?B?cjdIRzc1bW5tdzhWYlhsRlUvSW9TQ3BMOWxGSG90aHNONWtuQm9XZUxnNjJN?=
 =?utf-8?B?RnBaa0RYU3FTSVZnV0xjQmxyWEpZSzMvK1ZRWGRMY3BxT2FlWHROYURVUTdu?=
 =?utf-8?B?UFB2VmRVbDBIbFk1WHBPdEFlMk5VcnE0azJBekVBUTRzN3VvT256dU9sZG9X?=
 =?utf-8?B?UmRiYVFmR1o3dEZsMXZBSnQ0VGlHY25BcWFiaFBaMFRDNUZmWDA5dFZOWldJ?=
 =?utf-8?B?cndtZXNSaGo1SHdQd0dwZ09EdHJ3anBTWTVweGtTdm03eXpwWGRYYWUzWVB5?=
 =?utf-8?B?bkNxTEZhNXZCWFZqeXJndXVpeWZmMlAzTHUxZUJTUEFFYlZBVHlIbkdaQkRY?=
 =?utf-8?B?VDYyK1ljUTc4R2FHd2ZMV0RscU4wcUxFdTV1clpNUGx0UjUzbkFrUHRWSkFx?=
 =?utf-8?B?YTQ1RnNrSVZDeVlJRkdabzVtTzBBL29hd0UyNm1WREhPWTNoU1NVbmY2U0hK?=
 =?utf-8?B?c0RVU0xkMU5TZDloNzBOK0kyVkVXSVBxQzBjQnNpN2taWnl4aTcrS1hONy9D?=
 =?utf-8?B?dXU0TTRnTk5jVk91eDQ5WGJjKzdra0ZnMVB3WHlzcmlJTnIrMm1wMjFFWGdU?=
 =?utf-8?B?NExobk1pellaRHo3K29UTXN0YU5SM1gzd2pnaWdkTkdtL0NOSEM0THBTVHFY?=
 =?utf-8?B?cHJqUDdsMUJER0RJY2cwNzM0NFU0SmdhcnpKVER5SzJXdFQ5ZlVJSEtUVENs?=
 =?utf-8?B?T3gwb2p1U0Y1UXJYNWZtS3V1aG0vVkV5dncrL1dlbEVGUjltbjF3ZkY5SjZF?=
 =?utf-8?B?ZlZXUmRDWUJwcURpUGl2RDFZUFFJVEF0U05sVUZqc3hCZjM3K3l5bVBzMEtH?=
 =?utf-8?B?TmJMZVUzaitRQnpObmdzY1dQOVNOMEZmMng4dFE3SmZkbFJLbm1XU1g2MjMx?=
 =?utf-8?B?eTlSV0Vpa0NSKzI5M1RYekQ1YVFoTTdUcUVPcE5BTUZadXlyMFZVZnFVUFhk?=
 =?utf-8?B?TittNncrZlN4dWFBd1g3eEdlbmJkM0hEMENJUkdpRk5NanptWU03NUVLVzJz?=
 =?utf-8?B?VnZad2dPbkFQb29pSGx0clJYeUZOWlorZmcwUVo1OHF0YkRONlY3bEd4dENk?=
 =?utf-8?B?VlpNbkU3YVM0WDVkZU1DeGJFSVg0OGhxMHJBQ0MrUTAyUUZrcnhWTHJ4cTMz?=
 =?utf-8?B?WVAyTVFrL01ya2JKcm1xZFNMMjU2SG9hZGxFekVGY3lNVXJvSXBYSENla2xI?=
 =?utf-8?B?ODFrSXgwbG9QK2lMdTV2eVRneG1kOUpNbjVnZDhwQ0JhZSsvVTZLZmNkY0Jr?=
 =?utf-8?B?NG9xRnROT2xLMXdLZ2RqUDFRNHAyVlRFeXZSSFpjRHFUUmY0Rm5PdVFMU1Rw?=
 =?utf-8?B?eDFWQ0pFb0o4WWlSMHBrR0VaZVFnSVk4OG5VcTl6Q2s2N0xMMExEeE1TWHBQ?=
 =?utf-8?B?Z2pmMUZXQk1uVnRGME1BMUNBRTZ5WXdtTTJiSDRDQTBLa1BqNmNmMHYrYStF?=
 =?utf-8?B?ZGVlL2trSndCUUxjTEV0NjBSY3JzV2p6cGlzdlluZHJIYXczN1VGU2EzT3gw?=
 =?utf-8?B?MzVhdWZwQ2c1dCtoY2JiTnQxOXVoWVZEcmxLd00wdk16WHUrWmFDa3JvY2Er?=
 =?utf-8?B?WU94Y1VoRUVSMmlXRTZ1WWh3b24ycnBQZGN5OUdRWTUxREYwZU1zTGhUTmxv?=
 =?utf-8?B?dHB3RmFpVStxQUtsUDZRS1NnTWloeVRjQkJMUEM5NGlSeGUvOThNV1BONDR6?=
 =?utf-8?B?dER2c0J1UEdyZ2lIZ3N3SFVxNERvdzMwcFd3eWdHeDRCYXpLMHJwaTVFcTBo?=
 =?utf-8?B?ZzlwalEvMUZzelJ1dUxEQUdEck9LY2ZZZHNveWFDVUNiTERSUUwxWGhNdjIv?=
 =?utf-8?B?QUl4YkVGNzVKakNaVWRHSkxrcDJsWUFkNkpOUzdud1JLVGM5bFpxd0N2bkNs?=
 =?utf-8?B?c0RFejFmRzY1M0dXWTdNbEJQakpqN2V1UTJyOWowWXF6Z3BMSitaY09VUmVw?=
 =?utf-8?B?cHZTNkxMUExyQzZlYkxSemU4aVFFNWx0UjFXQ0tNMC93OWVVNmJXZlZZaCt3?=
 =?utf-8?B?S1dWQXFMNG4zc1hMb1c4K3hMZjZqZTh5NUFSb295MkhlaS9PZGRSZ3J5c1V3?=
 =?utf-8?Q?xAkMaeD68eGmaf9odL32HyVrA9iVhkLN2d3hOIU/qaCDn?=
x-ms-exchange-antispam-messagedata-1: wcBJwFH6THumTQ==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC6nNkqitdLlarw5B8CNyh5taP9en5KUbbrYQcwtVbelan6yusQQLy3l9BFzuzGPXQliLu2f3l4vd6zMov9dEQXLLex+74WSKNQzzHPDaoNiM1/rA3TL5Ow47Pinrt4nfEJAmPXHV+baJn8wQpOrWpqfBioBDoUEoaEZIfcaVtTXy0lPiWRc8Cj3V1Z6w+f1i4e4U032oWmmQ4A739Rq4+uch0etjxS/6SqXpdtEWri+ZARqdkazXZ8izhYkQjDVctCDAQ0i5cYT5ehapb2AicTqq0Py8FLxLMQsoIZM73ZMMqohFkmV7YmLtfRPOyTCvmdCCtixBvBPPETSIfKLAQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZSjNeFztleNYAbdagyNQXvqoyemREKhn+KBMl+E394=;
 b=Q+ECElW9AZtkb9RjmOeKz7Zoxfn3ZEA+VFqW1D4Z+f1SbzehjIZZZqVUyk5mobX3wUOrC08tIn7tilTfBUtGgSR6gsMGTXeJT6Q6yLRHqNUP+2TM4f57NzwGtiievCaChmfCvlsr9/dY5CEua0KmLnqcaS61hVvzXgO3WMD8GYfOYg/y60jhEWwPDayzj4hk1/H+R3knS5jPozOMImq50z4c0dDfTLFk1H0oiAbIKhNKSjTHviBzPO1fh9GrTSEYj7jvJ5DmDSutYhiTfzuUyf9kpwLE7QekdtIeZpDYo155pqGol7pKE8MduLZFR6IMn+5JjFHvJVOI6JfbcJ+qAA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: WuyBzn0SJGKytOmGEbs7g/xBO8EJ5D5boQg+s/xEuRKhX3Howt5CTS6jU/BpgsFcaSUyhkEfmP7P7F1mD2oRoGf9VdIonQuR8rOTnbAZYB93E7XiEriDFsaEIeW59gj+XWx2+ue5zU2wipXsGXmxJ1w3XFAnG/ElPpAd9Sip58mYs1SbV9aZWgzURmnV/aPeypbJGVOiTCp4hz2m5OZOinxaKjrR0kgOMePX8WlsYLpmU8JzRtimIZLmyeD7EtykEVLPPTXN+qdIboaQbfzCXsgQuXzQJx+9U9q5PTcHZZQTxKLJob0b3YmOAI48MFfkncksSUN9OCSRX6c0UeUokA==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR17MB4715.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e6b705c0-6edc-4ce9-6210-08defebd98e8
x-ms-exchange-crosstenant-originalarrivaltime: 20 Aug 2026 13:19:00.0399 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: QKEUoHTedOP+tLjcAxze7RfpygBDXm1V21VN0nYd5jbU1Niq/MfTgEZ9FQgnvnmJKgkM2wLQJG+bf0sgaWI/aw==
x-ms-exchange-transport-crosstenantheadersstamped: CH0PR17MB6936
x-originatororg: akamai.com
Content-Type: multipart/signed;
	boundary="Apple-Mail=_4347EB15-43D6-4589-B06B-E1073827589E";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608200098
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA5OSBTYWx0ZWRfXyouV+3ctF6jq
 KSkNZurK+nCbk/fipWzN32ZOxSn0pY5e18nPIrGE0gvO78qM/uOvWZnvGcYdZC16zma6J0eCdan
 mhR2cGzUYPUJShn+euy56FY+UFNNokI=
X-Proofpoint-GUID: AmYA7WRNL0FhLqlYEnJKchcljgjArzPz
X-Proofpoint-ORIG-GUID: AmYA7WRNL0FhLqlYEnJKchcljgjArzPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA5OSBTYWx0ZWRfX7HGcvpxoB2Q0
 IxaFGROb1LSpf/perd3MrrtU0PDeB//GDo2YGZZj00lpkqmjrEbnL9S49Mk817TtzCzWBtvnqtI
 h6iWh4lPz9aVrlAMnx5Y16+7xSQJWhB55qbUIh8utM4mC5rT7v38ZHpYVTVdluuCWg81/sWTQW5
 0bwnTN9uCpqwobcetvbYAd5z0Sg5A6KzHyu0DBkuAiZaVG9sx9WPxazxe6WCJDIbNQnJbSf263k
 K6KFlrlxkBE7KHYDx1QxzRkdLivtT4RTyrWILaerePaHmzuSVXLEP+wmVk6Edn+EFeoqIr1GHfE
 KOaEPO7cVRpv/teZBo/2pprsZj3YG4m6vsKcG1VlTPaauNX3cGF5VHBvE2r6amWksDEVZRiJXvQ
 kR37m5Iw6B7mMVmL69uC6Muq7FcePZCUU71HVjUT5cHwJ1tipCCsuk2woR8YWYDoRc0OZE7jD/B
 AQeaUzf5BcLHWo+O+xg==
X-Authority-Analysis: v=2.4 cv=VN/tWdPX c=1 sm=1 tr=0 ts=6a86feca cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=VcQvXEo1OZcA_IiPcy3B:22
 a=CWErhr8FAAAA:8 a=X7Ea-ya5AAAA:8 a=G1whcwAzDW0ehOAuODEA:9 a=QEXdDO2ut3YA:10
 a=Jvk-B8Yci6yZuavSY3wA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
 a=I-g_0vLIplkVOQ0FYkeP:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608200099

--Apple-Mail=_4347EB15-43D6-4589-B06B-E1073827589E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 19, 2026, at 10:34=E2=80=AFPM, Emil Tsalapatis =
<emil@etsalapatis.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is =46rom an External Sender
>  This message came from outside your organization.
> |-------------------------------------------------------------------!
>=20
> On Tue Aug 18, 2026 at 8:03 AM EDT, Nick Hudson wrote:
>> This follow-up tightens the selftest to guard against false passes in
>> GSO decap validation.
>>=20
>> It validates the expected post-decap state for both GSO and non-GSO
>> packets: expected tunnel gso_type bits must be cleared and
>> skb->encapsulation must match the remaining tunnel state.
>>=20
>> It also adds explicit assertions that the decap validation path was
>> executed, including the large-send phase for GSO-marked subtests, and
>> asserts that the large-send marker is reset after the send.
>>=20
>> This keeps the tc_tunnel decap checks meaningful and avoids =
false-pass
>> regressions without over-constraining behavior across tunnel modes.
>>=20
>> Signed-off-by: Nick Hudson <nhudson@akamai.com>
>> ---
>> .../selftests/bpf/prog_tests/test_tc_tunnel.c | 33 =
+++++++++++++++----
>> .../selftests/bpf/progs/test_tc_tunnel.c      | 19 +++++++++++
>> 2 files changed, 46 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c =
b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
>> index 67ba27d69347..08d7d90f7772 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_tc_tunnel.c
>> @@ -206,7 +206,7 @@ static void disconnect_client_from_server(struct =
subtest_cfg *cfg,
>> 	free(conn);
>> }
>>=20
>> -static int send_and_test_data(struct subtest_cfg *cfg)
>> +static int send_and_test_data(struct subtest_cfg *cfg, struct =
test_tc_tunnel *skel)
>> {
>> 	struct connection *conn;
>> 	int err, res =3D -1;
>> @@ -215,6 +215,7 @@ static int send_and_test_data(struct subtest_cfg =
*cfg)
>> 	if (!ASSERT_OK_PTR(conn, "connect to server"))
>> 		return -1;
>>=20
>> +	skel->bss->decap_expect_large_send =3D 0;
>> 	err =3D send(conn->client_fd, tx_buffer, DEFAULT_TEST_DATA_SIZE, =
0);
>> 	if (!ASSERT_EQ(err, DEFAULT_TEST_DATA_SIZE, "send data from =
client"))
>> 		goto end;
>> @@ -226,14 +227,17 @@ static int send_and_test_data(struct =
subtest_cfg *cfg)
>> 		goto end;
>> 	}
>>=20
>> +	skel->bss->decap_expect_large_send =3D 1;
>> 	err =3D send(conn->client_fd, tx_buffer, GSO_TEST_DATA_SIZE, 0);
>> 	if (!ASSERT_EQ(err, GSO_TEST_DATA_SIZE, "send (large) data from =
client"))
>> 		goto end;
>> 	if (check_server_rx_data(cfg, conn, DEFAULT_TEST_DATA_SIZE))
>> 		goto end;
>> +	skel->bss->decap_expect_large_send =3D 0;
>>=20
>> 	res =3D 0;
>> end:
>> +	skel->bss->decap_expect_large_send =3D 0;
>> 	disconnect_client_from_server(cfg, conn);
>> 	return res;
>> }
>> @@ -374,10 +378,15 @@ static int configure_ebpf_decapsulation(struct =
subtest_cfg *cfg)
>> 	return ret;
>> }
>>=20
>> -static void run_test(struct subtest_cfg *cfg)
>> +static void run_test(struct subtest_cfg *cfg, struct test_tc_tunnel =
*skel)
>> {
>> 	struct nstoken *nstoken;
>>=20
>> +	skel->bss->decap_validation_seen =3D 0;
>> +	skel->bss->decap_gso_validation_seen =3D 0;
>=20
> Sashiko points out correctly that gso_validation_seen is never =
checked.
> Can we assert it with the others?
>=20

Yeah, I=E2=80=99m fixing this and removing

    decap_{large_send_validation_seen,expect_large_send}


> The CI bot's point on the other hand doesn't matter that much imo, the
> assert for the config variable is good in case we ever add any other
> subtests.

Which point, sorry?=20

>=20
> pw-bot: cr
>=20
>> +	skel->bss->decap_large_send_validation_seen =3D 0;
>> +	skel->bss->decap_expect_large_send =3D 0;
>> +
>> 	if (!ASSERT_OK(run_server(cfg), "run server"))
>> 		return;
>>=20
>> @@ -386,7 +395,7 @@ static void run_test(struct subtest_cfg *cfg)
>> 		goto fail;
>>=20
>> 	/* Basic communication must work */
>> -	if (!ASSERT_OK(send_and_test_data(cfg), "connect without any =
encap"))
>> +	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect without =
any encap"))
>> 		goto fail;
>>=20
>> 	/* Attach encapsulation program to client */
>> @@ -398,7 +407,7 @@ static void run_test(struct subtest_cfg *cfg)
>> 		if (!ASSERT_OK(configure_kernel_decapsulation(cfg),
>> 					"configure kernel =
decapsulation"))
>> 			goto fail;
>> -		if (!ASSERT_OK(send_and_test_data(cfg),
>> +		if (!ASSERT_OK(send_and_test_data(cfg, skel),
>> 			       "connect with encap prog and kern =
decap"))
>> 			goto fail;
>> 	}
>> @@ -406,7 +415,18 @@ static void run_test(struct subtest_cfg *cfg)
>> 	/* Replace kernel decapsulation with BPF decapsulation, test =
must pass */
>> 	if (!ASSERT_OK(configure_ebpf_decapsulation(cfg), "configure =
ebpf decapsulation"))
>> 		goto fail;
>> -	ASSERT_OK(send_and_test_data(cfg), "connect with encap and decap =
progs");
>> +	if (!ASSERT_OK(send_and_test_data(cfg, skel), "connect with =
encap and decap progs"))
>> +		goto fail;
>> +	if (!ASSERT_NEQ(skel->bss->decap_validation_seen, 0,
>> +			"decap validation executed"))
>> +		goto fail;
>> +	if (!ASSERT_EQ(skel->bss->decap_expect_large_send, 0,
>> +		       "decap large-send marker reset"))
>> +		goto fail;
>> +	if (cfg->test_gso) {
>> +		ASSERT_NEQ(skel->bss->decap_large_send_validation_seen, =
0,
>> +			   "decap validation executed for large send");
>> +	}
>>=20
>> fail:
>> 	close_netns(nstoken);
>> @@ -438,6 +458,7 @@ static int setup(void)
>> 	SYS(fail_close_ns_client, "ip link add %s type veth peer name =
%s",
>> 	    "veth1 mtu 1500 netns " CLIENT_NS " address " =
MAC_ADDR_VETH1,
>> 	    "veth2 mtu 1500 netns " SERVER_NS " address " =
MAC_ADDR_VETH2);
>> +	SYS(fail_close_ns_client, "ethtool -K veth1 tso off");
>> 	SYS(fail_close_ns_client, "ip link set veth1 up");
>> 	nstoken_server =3D open_netns(SERVER_NS);
>> 	if (!ASSERT_OK_PTR(nstoken_server, "open server ns"))
>> @@ -701,7 +722,7 @@ void test_tc_tunnel(void)
>> 		if (ret < 0 || !test__start_subtest(cfg->name))
>> 			continue;
>> 		if (subtest_setup(skel, cfg) =3D=3D 0)
>> -			run_test(cfg);
>> +			run_test(cfg, skel);
>> 		subtest_cleanup(cfg);
>> 	}
>> 	cleanup();
>> diff --git a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c =
b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
>> index 853bca962910..e9bd1c9781f7 100644
>> --- a/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
>> +++ b/tools/testing/selftests/bpf/progs/test_tc_tunnel.c
>> @@ -16,6 +16,11 @@ static const int cfg_port =3D 8000;
>>=20
>> static const int cfg_udp_src =3D 20000;
>>=20
>> +__u64 decap_validation_seen;
>> +__u64 decap_gso_validation_seen;
>> +__u64 decap_large_send_validation_seen;
>> +__u32 decap_expect_large_send;
>> +
>> #define ETH_P_MPLS_UC	0x8847
>> #define ETH_P_TEB	0x6558
>>=20
>> @@ -690,7 +695,21 @@ static int decap_internal(struct __sk_buff *skb, =
int off, int len, char proto,
>>=20
>> 	kskb =3D bpf_cast_to_kern_ctx(skb);
>> 	shinfo =3D bpf_core_cast(kskb->head + kskb->end, struct =
skb_shared_info);
>> +
>> +	if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
>> +		     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
>> +		decap_validation_seen++;
>> +
>> +	if ((flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
>> +		      BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) &&
>> +	    decap_expect_large_send)
>> +		decap_large_send_validation_seen++;
>> +
>> 	if (shinfo->gso_size) {
>> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
>> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
>> +			decap_gso_validation_seen++;
>> +
>> 		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
>> 		    (shinfo->gso_type & SKB_GSO_UDP_TUNNEL_MASK))
>> 			return TC_ACT_SHOT;
>=20


--Apple-Mail=_4347EB15-43D6-4589-B06B-E1073827589E
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
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MjAxMzE4NDla
MC8GCSqGSIb3DQEJBDEiBCAgYdcyYM9Bg8/9xKe4EpXwLenqAxG1uz258i4OKEXVhzANBgkqhkiG
9w0BAQsFAASCAQACpOHL/nNB5o9v4uOAMfqjeH5w1St45srCwskxzw/hLkOnLHYUObLG/17ejCYE
ecWQoRPs3fXhNDn5gESyuFZZZdrcTQYodqqpLCMtJRw93Vin53JRXoeWc3jnDPOAKIR32K7i5pIg
kk9GnBpQYzvCGJQ/GnkN44jXXxAnkVVTkl/QGkghOGZcOeA0OipMc/UlUAm+E/S/pkDCS7AbMdb0
FIcQVMoYdfm4fDP6d4uo/5StqcdupDIqiEF/V88JymoXPfpeKc18ovlvBXfd00hekCASylBpw7/q
PtH6vvavClyjI5eDcRb3lkVj8HPFdtSwvhzjdFzZ+bDpRx1hpjiqAAAAAAAA

--Apple-Mail=_4347EB15-43D6-4589-B06B-E1073827589E--
