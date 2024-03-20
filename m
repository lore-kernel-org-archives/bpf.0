Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2107.outbound.protection.outlook.com [40.107.94.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50A4F8B2
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971595; cv=fail; b=ZmDLG8vMOzOdhBT4TxwHvwwppaAGuS66vIKopRaUaoqHvyjwvXHYxEBe9pPde1MplLWb4/Sh9NcYipTztKtSG/U4MyflVCxKmpXcOHR9Ry8RYWlYokJL6J2sogriVn5IOgShNOqhpa/Y0tSJ/KqUaAxihpa4D7s7yi7QqnI4Ka8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971595; c=relaxed/simple;
	bh=rDm9+Ai3vRAMKzr0v5Adv/ZUUibVU14EuvM/svJLhZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e+nY9P95oar4UIB+U1ymUkFoGjbhVM/wM3am0O3YWfyPTy3rxB4iOhDHvV0YU2cEkvMg628l81qqIjzPNcKS+9pmchgmVtTFxkpTId3UoyaDW43kqWuilvq6ltd1ETnFFVjo9mn3nq3bdS+Jm29I1qZe8PJCD/YFYE99LEj6dOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.rutgers.edu; spf=none smtp.mailfrom=cs.rutgers.edu; dkim=pass (2048-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b=krUrCKn+; arc=fail smtp.client-ip=40.107.94.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cs.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b="krUrCKn+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMNWn49UqZCMAYgQ+55eAjBXm32/uOPMTq6D0xpaeBHmhaT2VqmPbQ7Bxnexfnt1VnDGHali3HiWQ/qokIl9ZS8JMfyznd3bOm+b+Vp/YIUcbvHiOVEdV0tM2Ou22wWd/TxBSQBMeS6OffduVJKIKXXwMDa2vcv54YKfVEF1mNanCUMeI7JSFe6S5IbctPdHvSv72jpDLgcsGHHUDWbpsZSFOBgwjmWpESvL5xMOZjVEHTiEi45W0Ogvr5yP7MMh0tQHzmb3fz8SrI3AiaXbODwQHZSfApQBgipV6vhRyf5L3BCvVps12OGHV65G2katLxJn4EtxkkQllTojado4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDm9+Ai3vRAMKzr0v5Adv/ZUUibVU14EuvM/svJLhZY=;
 b=lOGkrZiV9/nlrGkLcTmO88czRmBK30+c94NrmN435h/6i7akr7hTJUj+yS7GgMlkLgKVlG37gvV5RDt6OB3YI7l46WC3HUElapdDf+kJlSEGkkNsOV/Lbk4ffPHJIt+pNt6r+jgqrVEzoNVQGMUdAj4QRaM1xvIjxxsKkSPs1Vg5dKui6Q+HprAd2qU33daBVeryYipP4l+jnA5OvpL4q7P4l8l4CEjSJOO8+QugmV9Zus6LqKM7lvpJ/FuF0EUHPtyc4UMfi52Qvx2BJVxDTYiFyzhyF0YvPJyGhQJYBtzKhlGP9lXLfyZ8GHEhDTMTjwqgq4NS67B3clmwTOerKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.rutgers.edu; dmarc=pass action=none
 header.from=cs.rutgers.edu; dkim=pass header.d=cs.rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDm9+Ai3vRAMKzr0v5Adv/ZUUibVU14EuvM/svJLhZY=;
 b=krUrCKn+uJrMlEQNN+o4Jn4LREGawRnza2Fu7WNr1ngkpYLfhuAgHFK9HN/5v0jvO/wiHqJ5KbZ2AV00Q3mJEUDeVwMDxL1J43nGBftbbcgFwSMAH1NX6GFILTJ5Y79LCqh+7nXZdlg0AEI4aZHVFt8l9YzqnPXZ1apU7LBRPaEPcu9bLAWw8wlWUwMkE25njfqhc/UCdgCBuOnyAmipkJQqE22kr6qXyxMUz7HxKGmbsopQTV5JEu0+p6GJK2YYgpsFX5RB+JNEJLPXQJJTxuybZbxurLSR3g+AthgIIl/Snpi9INvHbAP9/iO5q99pG8DXflkLapASWXApphRCcQ==
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com (2603:10b6:a03:4c0::14)
 by BY5PR14MB3336.namprd14.prod.outlook.com (2603:10b6:a03:1e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 21:53:04 +0000
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a]) by SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 21:53:04 +0000
From: Harishankar Vishwanathan <hv90@cs.rutgers.edu>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paul Chaignon
	<paul@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, Srinivas
 Narayana Ganapathy <sn624@cs.rutgers.edu>, Santosh Nagarakatte
	<sn349@cs.rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Thread-Topic: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Thread-Index: AQHaekEEXwavwD8qdEOBFYtheIwylLFAH3WAgAEN9IA=
Date: Wed, 20 Mar 2024 21:53:04 +0000
Message-ID: <748D4E59-9E81-4BEA-9B1C-B7DBA16E53E3@cs.rutgers.edu>
References:
 <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
 <CAADnVQKN5Hk7CHgDBg3JtPoeYXoTNFoXCWp_u-2YP9dN7juavg@mail.gmail.com>
In-Reply-To:
 <CAADnVQKN5Hk7CHgDBg3JtPoeYXoTNFoXCWp_u-2YP9dN7juavg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs.rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR14MB6501:EE_|BY5PR14MB3336:EE_
x-ms-office365-filtering-correlation-id: cb1f9831-04cd-4b31-1677-08dc49281e9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 akUVEV/p6aE6RtMF2m3vGhZoNbseSueMmhfvE9oM6tKNb304swQ4aVtImQztF21tBjwiVDprlLEn/iy9HNKpu2IvUQHwfQkrNgKkjaRvlwa74t9gw9u5Nj7gFid11A1yq5jrOIdUp81pADg2RNqAwaD+gIA6+qdfoWA/95W42vauuPILztgTydOk+ThRjFQlV4C4AhL7np/eIJ37Jxyqt7y9Xeaen7vuquIbw3ix7UsGxLChViPKFKUoWBNDYBnRuEfikdQca7sSKiEnpwzGnbr3dQejU+u3QLxoTkf+abvV+Hyn7LsexDKTwh86IEwqgolpE1sSEy3w6eMysbZqwffuXLXcPkhc+OKKCEuFUBHDms2s7fHt41tlBIiMHimYAcc7LoZ/AEIHCZKeByZwAOrVPpTBKwjS7Td09asg47JamzycJCnli3ZfiO0gdiwQLerAGKBYFhyS7sNGagJlGdEk3PV3XUkqE2AhKrSMdj+OFDlMN7u76hWRu50DWNpHZxLUZTVj8kBlIf9y6zy1ykrXnqczmQ/wQjlucN5UWe074uUgHmCpuIQdQTXUsrYq2y4XFP7Fzva3Qcr1VUutosFeYVOIXEoOSo7QB0kFv/OyNpbKjnRI10eDR55K4PJ0/tnw1JzApD99XpnJM4zX9NBFn9EsbfQClDaB3yrZWWJt0DCxo3z7Y0NQY1v6Q5TqDoL9NfbL54vojx+5Y1YoqBvPpSlCU9Z1IJVeTVzafdY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR14MB6501.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2c0cGdOdzR4enoyczFiQjVaY0FEQ2JlWTVxNmZpRElNU0ZFcFY0dUZPVWUx?=
 =?utf-8?B?RytPdkJBUFYya1JRMURJOFNmdlpvQzZDZGJvRFRHYzdFWEVrVk4xalBQS2pC?=
 =?utf-8?B?ZXREM0YyclRhT1hXcFNWajd2YXNkWmIrSjE5cHhzR1lLMU1ZSVFuZGd1QUlS?=
 =?utf-8?B?SFJ6RlhMZ0lSaStWYzVoOEp5dWxYTWtlQktra3hNTlFETmYyeTUwd0wwZ2w4?=
 =?utf-8?B?bFRsd2grNmk0dCtjRVJ1eUE3ZHkwWEpUR3pTcEZzSk9CNGZpdS9MSGFncDhU?=
 =?utf-8?B?UTNEc2U0RWp0UVpxcTlTVmtOYnRlVTNJVEtEQkRiUTZZcExIVnZ4bDNJNkh0?=
 =?utf-8?B?L1Rnb3FkdmpNYVJraDZ1Z2pXNW5WRWUwQzRBUkxYNmNtY3gvRjlHYWFZcXVM?=
 =?utf-8?B?bFoxK3M0Zkh4VVVweTYrV1E3d0RGSHZQRmNOTm0yRW1Ea1RPWDhiR3U2Q0k3?=
 =?utf-8?B?YXIwdWNPWm44NDNpdEQ2bmlRQ3lrYzRCVEMvT0ZjMWZ2Yld2RGJJR3VWdVRB?=
 =?utf-8?B?UzQwa25RVDZQektFaVY4cXdPTnNDam1Wc1c2MkFINXEyTGVRVFpocUQ2TFJX?=
 =?utf-8?B?SHp2b2VFcWFqN2pFWGlzaFN1Ukx0dWlFTWRPd3R3cExMR3k2cElZWjJkdkNO?=
 =?utf-8?B?ZmJoNDl4V3BXRXdaOWlmdDY2OWwwQVJ5NStKa3JIbXowSHlCSXNUN21aOVNo?=
 =?utf-8?B?aXdkcU0vbU5HamNRSitONGVHbVRpYW4rd2dKeXFKNVQya0FoTWYwNVpvK0Uw?=
 =?utf-8?B?SUVPN3NPaGZUYUk5N0FJVWVuSDNISzIwbWF0eXVCM3kwdXpMUDVYcEZ4dEZU?=
 =?utf-8?B?MENvYXVnNkdra2VlKzc5amczVHpNNzFYTkRZRnh4WGNuTDA1NkU2Q0IwMmVI?=
 =?utf-8?B?NEZQT292SDdIVGREdEZKZVAwejIwWDB3Q0dKMkZFZjhLQ1JSZWxObjZ6TFpE?=
 =?utf-8?B?YlVKc05jeWMyR0o1ajZCdVo3RTFRcENvUzd6VkZYazhnbWNCZjZoaFEzMjRr?=
 =?utf-8?B?aHk2a2Y5bVU1alNoME5iaHBCK09hV0VuQWsyYXE5aHlZK0V5ZGpSK3U3cHFS?=
 =?utf-8?B?TzdqUjRzRUxiL3NOTzcvOHRDNW44bS9aREI2QVVIUzJHQ3lLTGVNWFYvT0li?=
 =?utf-8?B?Z1c3TXhqN3JXVjBsdjFWOEVNMGYzNFFKRVBGamlzTCtEYXFaZTlrY3RaUmd4?=
 =?utf-8?B?eGVPci9tdjZVSXRsb0ZLNjh2YytqVUFUOHN2WTZJcmFYTmh5T3ErMS8rUFhL?=
 =?utf-8?B?dGdOYXVNcmZaVlhmd2k1elQyeHlhWjh0OXR6bVJwanljQ09wem0wdnpUTTJP?=
 =?utf-8?B?MVoveHh4SkxsRDNNZkJzU01BNkNlakQ3VG1YUGhXMkZSOTcxc1hPUTJGNjY4?=
 =?utf-8?B?akNDa0hvNzJTU2ZobDVzTWlGSnJpb0ZpdHJnZUhvbHBMYm1BMUltZkdiSWQ5?=
 =?utf-8?B?bVY1RU5PTjJUOTdDUGFoMGdhWENjMkc3NU13bG1tYzgwMjJxdi9NM2VhOEVE?=
 =?utf-8?B?OVgwRWRZSzNEQmJxUmloMmhZRjdhSGRtZnliZVFtL0pidTNqMTUySmU5OGZH?=
 =?utf-8?B?eU1iREswaU8xZVhpMTZpYWlHanNlSWlYMWZJd1ZBN1FZcGV5UGR4RW4rVE9T?=
 =?utf-8?B?aUJRUitPeFJZR0NZUTBCRDJva0xSS2g2cVhZVDBnb1ZtWC9xelQvN0c0VVdJ?=
 =?utf-8?B?d1MwbG5QTnUrRnYvNnRaMjBNT25DNHlVdkxOZTNJQ1JTYUxMMHBiWFB2cm1i?=
 =?utf-8?B?aEZKSDM1WWpvQnJJNnNDM00wdDNnWVBSb1JWb2NqZ3Exa0M5NmV2elA5TTBU?=
 =?utf-8?B?ZUl5M3ZuTmFFbVhNTXN6U0V1OUEyd3NUc2hRd3NmMFh4cVZELzdYMWFGUUkz?=
 =?utf-8?B?cHg4WTBWc09Cbmg5NGlnSWwzZmk3Q0JVc243YVVsUTNXc2QwWlRQd3FIN2Nx?=
 =?utf-8?B?dFEvS1pyaENYK0hHV0UwQW5UMm4vQXhSNGNyQ3ZNQVAxMkRydGlVNnRyckxn?=
 =?utf-8?B?UG44NWdva0Q4MHR4dGRQNWN2ZU5uQWY4TzN1MDlVZk1ubzdjTUhnL040eGxB?=
 =?utf-8?B?SEt4Ym5qSVhSejRjYVpRbCthRzZsN1JENkFpMW9GQ2Nuc2tyRHhnanNOMEtW?=
 =?utf-8?Q?AMIqaAxjv0YFBWGRgm4k9JNVG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EBB8CF3827BBC49904C1C4698C3A053@namprd14.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR14MB6501.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1f9831-04cd-4b31-1677-08dc49281e9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 21:53:04.0370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mq42fH6bpr79A2tSfpr3hvOY8RTf3t53zOQaOT5A6kLkbjQYWmF7luoYI+GAI7NaNkxOaMYwV68IQdxQxBFdWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3336

DQoNCj4gT24gTWFyIDIwLCAyMDI0LCBhdCAxOjQ24oCvQU0sIEFsZXhlaSBTdGFyb3ZvaXRvdiA8
YWxleGVpLnN0YXJvdm9pdG92QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPiBNYXliZSBzZW5kIGEg
cGF0Y2ggdG8gcmVmYWN0b3IgcmVnc19yZWZpbmVfY29uZF9vcCgpIHRvIGF2b2lkIHRoYXQgZ290
bz8NCj4gY2FzZSBCUEZfSkdFOi4uLg0KPiBjYW4gYmUgbW92ZWQgYmVmb3JlIHRoZSBtYWluIHN3
aXRjaCBhcyBhbm90aGVyIHN3aXRjaA0KPiB0aGF0IGZsaXBzIG9wY29kZS4NCg0KU291bmRzIGdv
b2QhIEkgd2lsbCBzZW5kIHRoYXQgcGF0Y2gu
