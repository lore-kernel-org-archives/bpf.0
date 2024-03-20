Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2C785C76
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972315; cv=fail; b=JL4lELCUrnPY5n1UskQmWGJFOXq/Gdw6iCTLUk/fNoO3BYI4CMXqQ5qpBI71f6Fjna2trOxXGosycTy94QrdqKTq6o1OVsOMmWYffgb8Kr0TBHQewVYVD+fHPd4gJP07KJAdMRE1xHjPYJCIx2jNEDywC/nDbWKTrtIwpe++JMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972315; c=relaxed/simple;
	bh=1xKZ9aK8WeeuIRx1cufLLJS0bSlYPGEQqCdaPTgLeIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C1D4y4yYggMZHvl6olEDINDmM+x5FTfM51R9/OdImT+UAhmUckNhOJxTLs71wI3C/EGBgKh/38gwC+oMAYfm7J+/RVVKeM0j0MA3H9K1KzRlcpdMpn6YCsmai40FDtHw3oHNl03TfmjAjNO7hEk+gyHtPlviEF/gzvDjrxeEqgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.rutgers.edu; spf=none smtp.mailfrom=cs.rutgers.edu; dkim=pass (2048-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b=clll4ooo; arc=fail smtp.client-ip=40.107.220.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cs.rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.rutgers.edu header.i=@cs.rutgers.edu header.b="clll4ooo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h32nPE6FbmMHMpZsmdmqMH1bemjLHRX8PgRnFed6dyPf/CVBTUAqUoppYWQShza7g6UFQgCSF6qKPOr6VEaklLL0oQ+CzT6RvSenynTmtEWsyVgWFwNqOWY3Fh/MGTgkyl4JLJsmXDVRqnqp/o/m30FonYTQr4bIjI15PIl/+TB2gdkELa4FNdaab4rHQutkH0rXk2T9jXZoIA/RbSaOOl6O8ag+MypPqaWQMbtV7GA97/A+JYhDxlJ9POKzkrDo55Vv3dv8bPkXxgmczLG+dvJ9kiiBaYEkMM05jmXkCYTrr5UnXSvNr9S56atfvyMKLunDlQrCOZpFqtvURFDeEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xKZ9aK8WeeuIRx1cufLLJS0bSlYPGEQqCdaPTgLeIw=;
 b=m2UpX9VPbTZ/GJOLDwhLKyzTxFNPpFYZG0WTY6OToOVpxE8sEeN7pmGLKx1UUPAojiAAMhCKrM2Kyr7p7IYhI/TmVXuHbrC2fwGowyk2CywN0FzTy2QlqGsNbC2Ljbgh67I2RhRZmf0gueaBZxdrh7cKjMO2jH1HPs2C4KTd2U+3LMkIU/VWrh/3UkBSJJZrJ4JK6Tet+bqDCak8SxRk8Jz73KHypgYGojw6FCel0znEPmYRGPQSGDrMA4D20VN2jspJXaopVEDI9910ZfbbjmY6ORQZhxfbfgMRTEJeE/+uUCeCcZdFCEWgJmwI5FvRbTQ3Bmjpf5taujzDkH8Fmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.rutgers.edu; dmarc=pass action=none
 header.from=cs.rutgers.edu; dkim=pass header.d=cs.rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xKZ9aK8WeeuIRx1cufLLJS0bSlYPGEQqCdaPTgLeIw=;
 b=clll4oooAN2qu375/jCG6p4E/zNyZzu/poii87BVRwLDOmL6FHzXSTo39Gs7XGyivuH2XcfTxkgc9ygERzWYIITk1vWR+BXgNlNrkkS62EyZ6kTJyaWxXiLSIfTnx8Yvhu8LHsqDud5wfN6SI2g7NczH1iwoEpztQlF2IqZXCllauPkjk9+cgJT2JZ5a7D0AOorXzlUYy2VnwHagm26oipnyn8REf231cEv/dghMnNpoTl13OFoe5Jg28U9ETfoicU8NIkPTQT1J1d3+zzc6EqiGJiClWmNPPHm5cZj4ppHKOw7G0z/+xhg2O4tHSv1ID6OOc50NaNw+E26gvnHwTA==
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com (2603:10b6:a03:4c0::14)
 by SA3PR14MB7123.namprd14.prod.outlook.com (2603:10b6:806:2f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 22:05:07 +0000
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a]) by SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 22:05:07 +0000
From: Harishankar Vishwanathan <hv90@cs.rutgers.edu>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
CC: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paul Chaignon
	<paul@isovalent.com>, Daniel Borkmann <daniel@iogearbox.net>, Srinivas
 Narayana Ganapathy <sn624@cs.rutgers.edu>, Santosh Nagarakatte
	<sn349@cs.rutgers.edu>, Matan Shachnai <m.shachnai@rutgers.edu>
Subject: Re: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Thread-Topic: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Thread-Index: AQHaekEEXwavwD8qdEOBFYtheIwylLFAg+IAgACs5AA=
Date: Wed, 20 Mar 2024 22:05:07 +0000
Message-ID: <15F3ABD9-F8D7-48FA-9684-318DE4205B1C@cs.rutgers.edu>
References:
 <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
 <ja4tftcecd2ozyn55333vi52ixcwxlvk4tc7qbrqb4k56fy54g@okqt4dnxantj>
In-Reply-To: <ja4tftcecd2ozyn55333vi52ixcwxlvk4tc7qbrqb4k56fy54g@okqt4dnxantj>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs.rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR14MB6501:EE_|SA3PR14MB7123:EE_
x-ms-office365-filtering-correlation-id: 217155be-c3a8-4568-ed4e-08dc4929cd99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OuCEDm1n2q0efX2GmNVQrNaI/iRk6D84DkrSVRmPevxIpelYdjczCAtiSB0ikSUpHnZuPAPROslaUfiRiJy4W+AqLWljPVMw/dAvAscampi/VWmPaOsf9e8SI3QTvD7u+urSndmtCFYp8gFBjvhP8dDFfGbTp+r3PqJsXCkcUIfqys8gahNt0IJYWg3eoks1JhpGcWVn3NeoZx9y9JBHr+HRPlSyHWbhq1rJk0ldS4s/ejmXKJ/0WKyUHKg84+xB4CSzyCgisW6otm0iYAJ1GkGLqzuPMLsxC1IVeQSwlJiK64JpDOHXTmzsRZ95Y+xMky9uwBHa1G05HOIXWkXnXLD1zrGWwYw2KoWZ/YwoP2JWe0UhG5YryQXdmCFTXv+Jn5J+3RmKpCn60caLgB11bRlSPFDXmgH0h5yIRhcuglrqSZ5CGyckNH2R9d4vAvCdI3ASbtz+l9p2NFNyrIGOuleKguuX30m6XDJtdcnfGJvK4n9ZGi01aLIUd/XDLKZLlu5TE3hcRdFfregHUWxXDECIF/hGA4v5uA+niKajntYCi3zFdV+aXfDJ3TEpWjjdoYq8mDtY9/Ji+dHJ3qS6FPttyZU3sh4y1ANWgTq8zW5/bpYw4k5lXDk+GbD193mKn6WfyO5nBB0UCgohw39dZvuq4566+F15HpqSrqerDV0u/nzVmR/lxznGCocBiCU8sCSs+V3sb9PORM9xqHvbk6I8CLx71YZXJdM2I/AsS8U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR14MB6501.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aC9INFdXQlRpeFNaVU5KVTFwbEo2M1lkOEcva25CTDRGdTU1cUZKcC9LNEFX?=
 =?utf-8?B?bHZqWlNhcWx2cnhLeGFpNzZpR2M4VUtCTVl5MWFuWUpTWVJ3WUZNYnlmSzJJ?=
 =?utf-8?B?VFhJZXFoUGVZck1WdEpGQXFXWG9CNlRiMzVjOXhCZWpKanNEL1RMZ0UvSFE3?=
 =?utf-8?B?YnAwY0FFMnYxWnNSTDJsWDVsaXlaSWlBTk81Y1licWI5NHprWTBTUHZkMlY3?=
 =?utf-8?B?T0lkMEl1YWk5VVlmaUxCZ2J3N1BYN1Nic2p2ZXl5cVlNcW9TY1ljUjNKNmwr?=
 =?utf-8?B?RW9aV0FFcVFucXVPbGo5OE91THpPK1lKWiszaGZwekRFdEJLWnZlM28rbXNn?=
 =?utf-8?B?UEtpT3BnRkFUMDVuMmcwdlJlODZNZ1UxNzBWSFZ5K0ptbG5NMWFiL2xXWmMr?=
 =?utf-8?B?VzFpUUJkbFowcE12RXg1UVpEVkVtaFd6TFArWk9XMDhKVzFwSUV2UE1odUxW?=
 =?utf-8?B?ZXZXZXY3S1JaS3dJaW5xZERGT21oNVBSTmo4clZDRitZSkptUXVWUWNSaC9W?=
 =?utf-8?B?K3loQUhHMzFnRzdyZVpuV2o2T1VLZG1GOFZqbGo0dFEwcmlrbmZXWHhYck5n?=
 =?utf-8?B?QVQyRndEWU84a04vZVBZS3FSUytqVk5SbWRLaVQ2by9GSEpzUjhYUE9wTjIy?=
 =?utf-8?B?UmlWV1dQdnV5L2FMWTRUZUhwb3FuQVpIN1oremkyYnV6VGxFaVIzZUc4S3Rv?=
 =?utf-8?B?RktmVWozd1E3TUo4bktEOUtTd0V6S2JuUkwySVhvbktXNFRUSS9CeFVMaW9C?=
 =?utf-8?B?czdReURtc1pYbWVkcVlXdFR4SjVXZUtYeEs0eWFRQ29vZmpMbHVtcFdOUlZ3?=
 =?utf-8?B?dzhUOUVwOHdRZjY0aW1lbFVPazBiSVp3RjFZTmswNHV0bnBab3pCRGx5R1J5?=
 =?utf-8?B?M0dYQXpzcGhnTDlYUzhsNWZmWmdKZGRNVnFVL1p3dHY3bGN1V0crQ3RaY1FR?=
 =?utf-8?B?MnQvTFBTWFZDd3c1MGtGTktpMVF2bWlRWkFheUs2TkUwTWxCVmEyRHBzMG5n?=
 =?utf-8?B?YUV3QXUyQ2ora0RUTmxwdjE4MmtOa0g1Qk50b3BVT2RjMEpyejhQSDBFbWpt?=
 =?utf-8?B?Q3JoVURmdTZBQTdvOEFOeDgyQzRkckJ1OXUyOEhSeGl3N1BRSGQwUFgyRmNz?=
 =?utf-8?B?YmJzRFd1ekk2MGpyVWVpR05mcXBrWW92aExWZ0k2UDdzbmU1aTBLOGJTV0JJ?=
 =?utf-8?B?V1ByMzJIOFBkTVdIYlhwazcyQTdZZEpoejRJVC9pY2pPZlNpNjB4WFVtWjd1?=
 =?utf-8?B?OVE0V2VTTys5M0w1WUVGQnFKeUlCZkdjNE9LK2VlbHRIb0VjaGI4SUtJeGMz?=
 =?utf-8?B?UmlFdlgvc3FoK2REdnhBaVZvMmxES3VaUExjL1hReHlrSHplNXB3S0toZUVv?=
 =?utf-8?B?NmxMTlFxVWxobm1IME1mSms0bFFTbS8wT1k4aE9lb0plR1hTMlRpOEtiNDRs?=
 =?utf-8?B?OVNyVjJ3TlFZM2FaNW5zSDlMNGlOcWhEcWdtNFoxcUphR3pVeDFTS3FHUC91?=
 =?utf-8?B?QWR5aDRCcmduZGd2UnBreG5WUWgzVzZuR0pONUVhcmJkUHlZNTZ5SjNHZGc3?=
 =?utf-8?B?c0lvcStyTktJLzhHNHJqRnM1YkQwRlFzeHR1bDI3VzdvNlpUb09NN0Z0Vnlm?=
 =?utf-8?B?VlBWcW16TnQ4ZVNDQ3Z5eGVld2JxTTZhT1Z2dEJkTVpvWWtvcXZLT0lKSnpF?=
 =?utf-8?B?TzdzSmd4bUtXeFZLVkdBUlpBT1dlanN1MjhLTkpGcmxTUXNlTE9MZDFtUlps?=
 =?utf-8?B?WnhNaSswNlpBZzNCcFJGZlV2MDhvQjZxRGd1UmZjN0ViMnI1d0FPdFJPWmRI?=
 =?utf-8?B?b0NGY09nZzNObkRzZE8rYjEyTzVGTE1KNDlqNlBnMVFIMTgxYnpQT2xtcjZm?=
 =?utf-8?B?czcyK1Z6VE8yMFFIYmQyZG8vS3U5UTFsdnJTT1hOZnorbXVkdE9WTms0Z3g3?=
 =?utf-8?B?UWZzVGFmcXZyeWk0OVlhU2kyZ011bngyejBQb3MxT3paaEs0Ulg4ZkkxZHdH?=
 =?utf-8?B?VDRHdWVrWmpQZksvekhBUHpmeFRUTVUwM081dmhJZmZsZUQrVTJ5RXJDSlc0?=
 =?utf-8?B?VVhpbXBqNTZkd1l6NzFNSWRtSHBtT3lIaDY5a09yUFJwSUlaQjMyWVlmMGdw?=
 =?utf-8?Q?RqQss3G5eowC2RwsS/IYCsEMK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A14A410B4EDE54DA1E6819294DC8300@namprd14.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 217155be-c3a8-4568-ed4e-08dc4929cd99
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 22:05:07.1091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eiP8fq9uwAlX6V9Jtm9J8C0kzN7OiZshkODfCvpOF3vVQPR2wUXLVQPwub2eDIJSnmVXcnPXIIeY+4Pz/cgjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR14MB7123

DQpPbiBNYXIgMjAsIDIwMjQsIGF0IDc6NDbigK9BTSwgU2h1bmctSHNpIFl1IDxzaHVuZy1oc2ku
eXVAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4+IGZvbGxvd2luZyBhc3N1bXB0aW9uczogd2Ugb25s
eSBjb25zaWRlciBwYXJ0cyBvZiB0aGUgdmVyaWZpZXIgY29uY2VybmVkIHdpdGgNCj4+IHJhbmdl
IGFuYWx5c2lzICh0aGF0IGlzLCB0aGUgcGFydCB0aGF0IHVwZGF0ZXMgdS9zbWluLCB1L3NtYXgs
IGFuZCB0bnVtcyBpbg0KPj4gYnBmX3JlZ19zdGF0ZSksIHdlIG9ubHkgY29uc2lkZXIgc2NhbGFy
IHR5cGVzIChTQ0FMQVJfVkFMVUUpIGluIGJwZiByZWdpc3RlcnMsDQo+PiB3ZSBhc3N1bWUgQWdu
aSdzIHRyYW5zbGF0aW9uIG9mIHRoZSB2ZXJpZmllcidzIEMgY29kZSB0byBsb2dpYyAoU01UKSBp
cyBjb3JyZWN0Lg0KPiANCj4gUTogbG9va2luZyBhdCBSRUFETUUgaW4gQWduaSdzIHJlcG8gYm90
aCB0aGUgNjQtYml0IGFuZCAzMi1iaXQgdS9zbWluDQo+IHUvc21heCBnZXRzIHZlcmlmaWVkLCBp
cyB0aGF0IHJpZ2h0Pw0KDQpZZXMsIHRoYXTigJlzIGNvcnJlY3QuIEFnbmkgdmVyaWZpZXMgdGhl
IHJhbmdlIHRyYWNraW5nIGluIHUzMi9zMzIgbWluL21heCwgDQp1NjQvczY0IG1pbi9tYXgsIGFu
ZCB0bnVtcy4gDQoNCg==
