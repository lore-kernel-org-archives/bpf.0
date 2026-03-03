Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010014.outbound.protection.outlook.com [52.103.73.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56919375F6C
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510523; cv=fail; b=FpV1YdbHhUkHoyi9UQVEZ9oaA3/5+0oTBrKKjbfpTvyzp73cOR6bE69bQDr91t13f15RLV1v9T1WsgF+VpSaCfz5erJg6Ez4xTFcSE4cqwrk2YOzJUFfZ4SLEfl4+mYMqUct8gPCcJFcZZGaJUzWFobIsL5diRQULfHSOLshMZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510523; c=relaxed/simple;
	bh=f3Ba9P93V3ob21EnHsULIoLSBioUPQNuuvZu3nRhsz4=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UzvlFRDrzGkl8QmjXt8UUYlvYClqCKxiKYb0OgRp6YAqTLQvkJhywB/24Zna4b8iylBI9Way6jX5phloRgy38xzhhwcf8rCwr70kROSIQ3UMsRuBA/V9TN/mRY2jaSKR204I3NGfGUmbfRAIuoFr2ytThq+t3mxD95fsaj2K5BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PEVvYq3U; arc=fail smtp.client-ip=52.103.73.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PEVvYq3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCw9OrtE8IRNP0QyCw0wIxtXliU3XqnwS7rhyx95QrPQHVs1savT+JPhL+rCP4VnPzXWQL+tWV4Hvz5tvSSaRxt0CTpjd3YkluSLgXhwKLKgiBGH3u0b5AiF9MwmlVCL8Wx4Q+XoG1kWlWTsjKVLOkHuhVL28cWTr35Sj6jFB2/GMe8X7xyzym6ZgMvk3VwjQAzovGqq3IFQZEYOXZz7SpyHMvPIGi9lh7dzAovRFxZxA59j5K+H3ClO49dZyINQa0xxTpO17Wnt0RYDSDHnydyP4NJoX3ktKQAx7cc+l1+H00TPoDuo4WTDiICvMNOolmQ30LS7eKFSj4fhRV2x1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAfw3QgWXaRTjZWo4LUdhUawKSEqQxA/qmV9T5JPDN8=;
 b=BtWmq3b0xq1stsJuKmJnSyf7Z7ypSZcXIthHamTbRtrZ3gJkTx83L1uITi4zz9cNoyx7i6yDYQK432/Egh/5r4FQU23WXoSp5ZKXSn0IsUQEGPPQb4mUvvTn34g/0hOSoFiyypjDSY2gj3wajZkS95j7umE/LoW5hlLj8KgRMEoVqChvvyEQB77qFeMRhZCYXud1G77PYrNqqf3IVXpGh+yjY6o9Lhb6J4TY/GBSbd4/gGHQbMsoyX2VCGGdlOaXv/T4gWSYAwhW4ZlSBuvkJFFddy5BQxDIc36o9uMjg6YmF0uYcPyVOXyYwIJFEgGv1NP2iaZz+3JeuPB4RxfETA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAfw3QgWXaRTjZWo4LUdhUawKSEqQxA/qmV9T5JPDN8=;
 b=PEVvYq3U+Ia7cLoBQIGyKc5xLaSdfK3GtMPLueVqUeKbbNk+cmfFedPAa7fQ65uzfKOj12h1zIghaCG2kDyFGbY5+Mwg5dvGjy0kVrkw+gRxDdAwnEsX3vkA1P4y+HqzzSnIqBUxuv8dEJgbmsftdK/vm3cZKEUcZSdDAz/+sT3qsG2POvqFP8cjgYUOKWOV1GgR3OKO40pdj5IZ53ivnDKA8KWOs7CTzJnkaLNBpNDqrhJyjW1EwyuqrO7qOXoc7H0L5TlNpSZTEA3WrpZJWk8zz9xzbJwEJm66XOX+QqPwHWi2LlVMse1kxVpl3xk+pf//4d5tim84+0igEQvoXw==
Received: from SY7PR01MB10924.ausprd01.prod.outlook.com (2603:10c6:10:337::22)
 by SY4PR01MB6282.ausprd01.prod.outlook.com (2603:10c6:10:ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 04:01:55 +0000
Received: from SY7PR01MB10924.ausprd01.prod.outlook.com
 ([fe80::ea4e:596c:c03c:ab48]) by SY7PR01MB10924.ausprd01.prod.outlook.com
 ([fe80::ea4e:596c:c03c:ab48%6]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 04:01:55 +0000
Message-ID:
 <SY7PR01MB10924FF95363746C25CDE4A29EC7FA@SY7PR01MB10924.ausprd01.prod.outlook.com>
Date: Tue, 3 Mar 2026 12:01:49 +0800
User-Agent: Mozilla Thunderbird
From: Yazhou Tang <tangyazhou518@outlook.com>
Subject: Re: PROBLEM: verifier.c - invalid scalar IDs after byte swaps
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Guillaume Laporte <glapt.pro@outlook.com>
Cc: "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Tianci Cao <ziye@zju.edu.cn>,
 Shenghao Yuan <shenghaoyuan0928@163.com>
References: <AMBPR06MB108683CFEB1CB8D9E02FC95ECF17EA@AMBPR06MB10868.eurprd06.prod.outlook.com>
 <CAADnVQJQhOkyPxFSrr_qoyDZUYdaT88g2xZa5+0UCvV4Ufb79w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAADnVQJQhOkyPxFSrr_qoyDZUYdaT88g2xZa5+0UCvV4Ufb79w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SY7PR01MB10924.ausprd01.prod.outlook.com
 (2603:10c6:10:337::22)
X-Microsoft-Original-Message-ID:
 <403641ee-6840-4347-b8c3-e0dc3e3295c3@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7PR01MB10924:EE_|SY4PR01MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bf428d-ae69-455d-d920-08de78d99bc1
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KPDHK5IscaBpQ6i7hZ/p/QyeFr06PQpYQjAmv4aVvAwk9CU8IrsJBqaYAsagmmCTETtsC7q1Xzl7eqQYkMx/ZSTbvIh9E6qds2BZiHuy/srfgS3/tm/LZnO6JzxuUq361kq4A/4kWfBUKoScHGkP3G9nohga5gcqeHr3TwVx4irwWtCllB4lAbT2hvBfM9T12Yn0lVyqAlHsqSVWTVGNJBtYO/qvtqivYHEs/OOGyLNTqMV+AsLgz4e0bSbowcee1GZKnB3cO276+v3/nVfis4Z9Ngk6BSQRjCvQK9v+iyzFRt+WADmaYHqaDY1PoWNhSr/KfZ4PHbeNmHhHMw2d1AConf4D9mAlygVMe83R0zO9fUbEpSkRwKDvbTcscgSvK3ELEO7GAj3IGdFP8mwDAVmyMava8ZjQ0mgLEShy8ENloTmFwBy//uYMW05vLGpL7fWraRChl+OepvGKkoz14qfaOmfzTJ1UMvXLS1sp5Q2gAyplx4Ql2VxgOszLmv2L2BdDwl9AVQcfI0upZU8jZD2jQcJl0dabFZl5EzMqkJJua2kwQGVKjjArWSVI/U+aEk+LTZ/0XhG8D7TxbmwOd8mBnQzFI1fWT/ulztA+iBswLE4TzyT2/A6pjJsy1CFc00L8DfoFtzo6vhAsKWF1aLPyaz9F91hw9qSvhidBHsTkeCvc3U/vovf/jx/IffdhWdUHPO0DMYFzDdBQcwMEYon3WrYN5UEdF86aIkU1Rg3ASi1ZZ6bHIu765h+wEfiDad5L9C0TBid+tTiO865Ud1UlXrpmj1BEVVDGQ/Ng0lwmN1Nh/gxuJ2ajML3jxzCRGWKyUXzetwaixGdYBS+OVH0KUv8TyGhAcvJBAA+ksHfpA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|41001999006|8060799015|15080799012|19110799012|5072599009|461199028|6090799003|10035399007|4302099013|440099028|3412199025|26104999006|1602099012|40105399003|53005399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vjd4VDRRd1UzbTlVRXpicURsbWhDeGJPWVRNZlNkYkRLRTNnbDdRRTd4ZGNG?=
 =?utf-8?B?emhPZEdDU0N1dTREb0l2TzdBMWZQc3RwL3B2SHh6UHlCeUVDeHhBTWxlZlU3?=
 =?utf-8?B?RlVzckpSeU81TTRSR21RT0dZekdqK2QzMWYwYzdKakhRUDFwSkgwdkFiSVFG?=
 =?utf-8?B?eVdLWUh5YmhOM2VnS01RV1AvUkdiOHBRVU8zSDN6ZFA2VHlmeVZPUmRCbDRw?=
 =?utf-8?B?UlI5aXI5WHphMFFCc2lYUXA4SllsSDliVkYya1hSbXdpbW9BdFRsVnRIRXBq?=
 =?utf-8?B?ZysvNTJFVGNjT3VyWnpveVgvaTROL0tXU3Q1UWRtajd6VU1lZU51NVh2ZGlF?=
 =?utf-8?B?N3RvZW5IdVJidnl3SkR5YXBZd3lKN1pyWmtqcnlORDFQaS85bkxkMyszS2pO?=
 =?utf-8?B?aHNmUXFPQk5FNDhIRy9jemhVeHJoVmhIL1ZLZFk4TmtnbmZKb244N3R5ZGJS?=
 =?utf-8?B?SmsrVklab1U1TjRUcHhoL0pUUk91S1B5OXNUTE0vckVnZHBOdlhxUkhKdDA5?=
 =?utf-8?B?S3lueTVkTm9pNThKVnFOdTcrbXNhYVJYYUhPSnNIVHQvNHhGQlEyL1JMeG8z?=
 =?utf-8?B?S0dmakpwMVV4OUw0TFluRHJZblM5ZDMxMEE2S2NmTnFUNkZDWWhUbDF4Mmoy?=
 =?utf-8?B?bjRPeHpRUEdQUEZINkh0T1Y3K3pWSUEyaytTc0pUY3NuZm95cVFOT0xyLy9Q?=
 =?utf-8?B?WGMvRXhVYUFwTll4Q1g5WUhSZTh5Vm1zb3Jiais4VE5abnJiUUNodVRGVGM1?=
 =?utf-8?B?WmwzWlpJOGVHY2xoOVU3NnhLRXlCMWVsTE0vUU1qRm11ZHM0U2J0R2RKR0FZ?=
 =?utf-8?B?M0pHT1AvcnZEaFUvcVZIeXJLWjhFYm9qNmRwRFdXMGc2UjgzOHVPa3g4dEsy?=
 =?utf-8?B?MXlpcnowalhwY3E1bUlqbnFKTWdVR1FSejR3RG1SSm5KRjhPclVJRk9XRGRj?=
 =?utf-8?B?UTZ0Q3RoVHBPNlBPT1p4K25CTFcvc0x6MXU4WlNvRnJWTldIcnd4TDhVaFEy?=
 =?utf-8?B?V1Fpajc1NklXYzduZmQ0SzVZRUZSU2plc2lkUFR1cUUrTDQwZ1prZW4xZXVq?=
 =?utf-8?B?eUZJSlJ6ZW5DcDh1SnR5amFYTExmN0RRWGN1c3V0NkhLa1daTkQvb0dFb2Y4?=
 =?utf-8?B?dkVlTEk1d1IrMGMyRkNRSXJJWUwzN0FScStqbDBlZmtISzJVc09XRkRIMTdM?=
 =?utf-8?B?My9QSWRYWklTL3pwQXQyVCt6cy9HaytqMGdXamFpV3c3cCtFR0Q2K2FRc2Ir?=
 =?utf-8?B?cENzbDRIc09nc1kxSlJib1NkL2J2cGdGdldkUmxyS25RMUpVR29FQTRZbmt3?=
 =?utf-8?B?T3hxeVhQR2xhc0pKREFqVTRnL0UrWHF3WTJrSDF1UlJGa2U1Wmp4SGoyK2kx?=
 =?utf-8?B?RHdsWGNFak51MnlCZmdRVlJhVFdxaExvZTQxWkFsT1ZyMzVjMWg0U3NodmpB?=
 =?utf-8?B?ZGIvaVpXbkhjejFaclNqTFpLNm56NGdsUGhIMUVBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXNSSHJyUXdVSCtxeEU1aFBWS2s3WnRyazNPM0psNnJxQ3hvWi90bk5PTmRo?=
 =?utf-8?B?dTRCZi9aTmJyUjhwQWI3SEpxR0hPeDFiNW5EZDVsbEdZWGZ4Qyt4SlAzL25X?=
 =?utf-8?B?a2pYQzFRU0Q0M1U3ZVRidHBScGlPQ25ZMDBjNDEzQUVLRGxrWitFRyt6Um5U?=
 =?utf-8?B?MTFZUXRHRXBjemdEWC9HRzNXaWlrbWVjSW9aUXkwaHhuMEVzdmYzWmd1U1ht?=
 =?utf-8?B?Skl4SVUyamF5OTdacExpUUZkL2ViVFZZbTFvb2MxeGRFTEtXeitVSitDRmkv?=
 =?utf-8?B?NHcwbldGSE9uOVZoOEZTb1U2NW4wanNBYzJTV2dkOXhUNlZQbFA2Vm1qaW1v?=
 =?utf-8?B?K2dLY3M0dnl4TkJOOHZVN1dLMzVRQ3dObFg3d3pGRzFnQXVOdmFFSUpOWG95?=
 =?utf-8?B?Wk0rTUJvVEdsZjBWNHNLMURPRVhoWWNDck1TbEorRmk4QUtzbU41RWt0bXRL?=
 =?utf-8?B?dmd5akFHL3kvblUyOGZXNXRwSTVRUUdXcUZPSFovdnM4akJ3dUxUOW1XOWdm?=
 =?utf-8?B?Q1UrcEZKRm92b1hoTG5XRkcrb2w4VHIwanY3azlGUXozVG1IdTZMQ3V2bGJy?=
 =?utf-8?B?RlNXanl2aTV6U0h3NlduMDdpS0lzcHdRUG9uUElBeFNYeGhFSnFuVzRPTFNE?=
 =?utf-8?B?b0d4cU1WdDVoVTNjUHR4NzF5ZlM3S2F5VFgwMFVHeUVpMUFkenpUeUpIZi9r?=
 =?utf-8?B?SlFWSzlBZDZRNHoveGpPRk93Vm11TklPcStIdEtZaDFjMmZpdC9Id1JMdzY5?=
 =?utf-8?B?OHNsRkgvZ1dtaksxUkluMUgxWm9hVWFTenRDYUVVTE9ZVjJua1N1ZVBrUCtF?=
 =?utf-8?B?azFON250bmZ1Ui9VYVdkbjdXaTdEVGJWOVZtMHQ5TjNQRnFXeGpKY3J3QlZq?=
 =?utf-8?B?SkJPTnpXYWpxZDRIaWpDWWVPaGR1MWlRcXdvZWQwV20zWWFEM0FhNWFIU0NO?=
 =?utf-8?B?blBJaUN6NzcwMUpmTHFVaFprUFVBREwxamRlVmJCQXU5MDlsK2tDNkpIU2M1?=
 =?utf-8?B?cEMxRTdTdjNHRnliVHd4a3pRbmFGcU1lMDVCMHFmc3IvQ2c0VW8vTy82djRj?=
 =?utf-8?B?aDRsemJUWGx3VEl5bkwweldsY0hpR2dweCtUNnNJci9qcFpoY0hFbVFBVFd4?=
 =?utf-8?B?OUFiQ00vUUVYSGdxeFhKMVpUNEpxZHJnN3ZTbmFoeEZJVms2TGRXUFdsWGJK?=
 =?utf-8?B?cno2R3REOWNaMkNRMDZRRUwxVC9HcWtCTmpyNXFnZHN6MStxbkpOcExLSjk5?=
 =?utf-8?B?dm04QnlGNkpJMXlQcFlDUFo5U0NqSmg2ZVpWUlM5OTBWRDc1YkQ0VVBmcTJy?=
 =?utf-8?B?Q2lRbThqZHhaUW5qOHgvcGlEQWV1U1RzV2ZOa0w3bi9QejhIVXJIbXJLV2xj?=
 =?utf-8?B?MHdaR25mOE1RMHBKa1Q4NStyZkFKQmlTaEtLbGRPNG12TzVJQS9VYVVib0I0?=
 =?utf-8?B?NEZCZzdhTExnN2JyZlpyNFVtVitzblkzVkoybXg2REZDUk14QUNXajNWem5k?=
 =?utf-8?B?UnJJdFBMNWxXcmVhQUY1eDhITUFVMXptdnpRTmZuNWovelpwUEg4Y1l2WE9w?=
 =?utf-8?B?aGFGMUxTNGFQY1ZGY1lOSW5NTG1tVG5Ld09QWXB0ZEIzUDFTYjA0MzZnZyt3?=
 =?utf-8?B?bm9oSldCejU2YVFCVUlJbDkrcUtEYmsxYVJxeFBnY3R4UEh4UGlBRHNmTTJ3?=
 =?utf-8?B?UmFzbVRqVkFyVzBuSkh3RzBiem9ZNnErUElCZjA5aVBYSXdiY21NUTgwSzBj?=
 =?utf-8?B?OWVQK2Zrdmk2ci9pSVFwbXBkUzcvd2Q1bXNTR3llM2RxRTE5Wk5OdUwydCtR?=
 =?utf-8?B?U0dqR01kNzhGL205RjVLWnpCbkJ4Rldrc0lhMURsei9RSjNlYVNsT09vcmoz?=
 =?utf-8?Q?w0sNbSgOAiqK6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bf428d-ae69-455d-d920-08de78d99bc1
X-MS-Exchange-CrossTenant-AuthSource: SY7PR01MB10924.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 04:01:55.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB6282

Hi Alexei and Guillaume,

Thanks for the bug report. We have already located the root cause.

The reason is that BPF_END and BPF_NEG are the *only* operations that
perform value tracking while bypassing the standard `dst_reg->id = 0`
reset logic [1]. While BPF_NEG handles this bypass by manually clearing
the register ID via `__mark_reg_known` [2], we unfortunately missed
this manual reset step for BPF_END in our previous patch [3].

We will send out a patch shortly to fix this by adopting the same manual
reset approach used for BPF_NEG. We might also consider refactoring
this code path later to make it less error-prone.

[1] https://elixir.bootlin.com/linux/v6.19.3/source/kernel/bpf/verifier.c#L15743
[2] https://elixir.bootlin.com/linux/v6.19.3/source/kernel/bpf/verifier.c#L15557
[3] https://lore.kernel.org/bpf/20260204111503.77871-2-ziye@zju.edu.cn/

Best,

Yazhou

On 3/3/26 9:08 AM, Alexei Starovoitov wrote:
> Tianci,
> 
> please take a look.
> 
> On Mon, Mar 2, 2026 at 10:11 AM Guillaume Laporte <glapt.pro@outlook.com> wrote:
>>
>> Hi BPF maintainers,
>>
>> I believe there is a verifier bug that manifests when a program performs a
>> byte-swap (BPF_ALU | BPF_END | BPF_TO_BE) on a value that was previously copied
>> elsewhere. In such a scenario, the verifier can incorrectly assume the two
>> values are the same (share the same ID), and can then narrow the value of the
>> untouched copy in a way that does not make sense after the byte-swap.
>>
>> I can reliably reproduce the issue starting with commit 9d21199 "bpf: Add
>> bitwise tracking for BPF_END", so only the 7.0 release candidates seem to be
>> affected; not kernel 6.19.
>>
>> Below is a minimal reproducer program that demonstrates the issue:
>>
>> struct bpf_insn prog[] = {
>>      /* call bpf_ktime_get_ns */
>>      { .code = BPF_JMP | BPF_CALL,
>>        .imm = BPF_FUNC_ktime_get_ns },
>>
>>      /* r1 = r0 */
>>      { .code = BPF_ALU64 | BPF_MOV | BPF_X,
>>        .dst_reg = BPF_REG_1, .src_reg = BPF_REG_0 },
>>
>>      /* r0 = be16 r0 <- the bug is triggered here */
>>      { .code = BPF_ALU | BPF_END | BPF_TO_BE,
>>        .dst_reg = BPF_REG_0, .imm = 16 },
>>
>>      /* if r0 != 0x1 goto pc+0 */
>>      { .code = BPF_JMP | BPF_JNE | BPF_K,
>>        .dst_reg = BPF_REG_0, .imm = 1, .off = 0 },
>>
>>      /* exit */
>>      { .code = BPF_JMP | BPF_EXIT,
>>        .imm = 0 },
>> };
>>
>> When I load this program (as a BPF_PROG_TYPE_SOCKET_FILTER), the verifier
>> appears to keep the original scalar ID for the destination register, which can
>> lead to incorrect verification (R1 is assumed to be 0x1 when its actual value is
>> 0x100). Here is the relevant part of the associated verifier log:
>>
>> 0: R1=ctx() R10=fp0
>> 0: (85) call bpf_ktime_get_ns#5       ; R0=scalar()
>> 1: (bf) r1 = r0                       ; R0=scalar(id=1) R1=scalar(id=1)
>> 2: (dc) r0 = be16 r0                  ; R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff))
>> 3: (55) if r0 != 0x1 goto pc+0        ; R0=1 R1=1
>> 4: (95) exit
>>
>> from 3 to 4: R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R10=fp0
>> 4: R0=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R1=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=0xffff,var_off=(0x0; 0xffff)) R10=fp0
>> 4: (95) exit
>>
>> Thank you for your time and for your work on the BPF subsystem.
>>
>> Best regards,
>>
>> Guillaume Laporte

