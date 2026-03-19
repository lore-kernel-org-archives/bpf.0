Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893F29CB24
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928048; cv=fail; b=HDIdYIHWQXf9J+ROf5NgNt8/kQlikX3UIjkj5GAvMF1Z/iUxaFBsXbsFSYZ/da15ztCqTbK6RJnsBb4mxJ/i81MDmzK0YpnseLF1h/dv/S6syP52tWW8tzah+BgnS+ylaQwsysmefxmfS9DhI9E+XfwZqLk3ZobgMiELi/BoSWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928048; c=relaxed/simple;
	bh=K2i87QXk9GdFEomfq+mUc2WvNSH9rxyDIg7517RX8jo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o68aJndjYBlZPDro0rrfXMVRV0WduY7pEYskF0/Pfog98bNdEElP6w44+ciC3EhWCGvzfr6fihbZbUyuqJ5ygdAB37/Rwjp+FfA5vBEHXPIepqLEs9/QedQVRYjcncI0ZsTBskTi5Yw12tUD2oZkcQJi0jgihNeUGT4pGZq7Hy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kICtmCrb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CLGsTMMz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kICtmCrb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CLGsTMMz"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J3wd5p1073116;
	Thu, 19 Mar 2026 13:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PiukfW/A7/+UqbwX7GGkm5TUNAcnBUg9FJmPuycBW9s=; b=
	kICtmCrb6G1YPfBlf5kwmQ2ke1sOXuXcjt7D0pC8WXkRAtQCeesXlMGXAr7fWpPq
	AQlJns+eQ6m9QRUAIjb7mP7CNj5eKfRRA5fYRG38ghWO5LY739VF/RVfgW2lQYj8
	N1xtf6ZXpAJ8/8eBxvhbOBB7xKeCzzZg/uRK11mkOU8CAj8fbtudsFjJVjnYeWiL
	98crZZ1dnhjrvbRL2uFm+2YT10BWz80+z21g5XIdomk3THG/XSsFG97mrFc3I0in
	/ZnglwZJdD7d3rxUCVKpdUaA/PZep1u4yUpuZXZGNhxfkd1iCim05KIAMzSXwXd0
	JH+oQQPtOZ5di3to++h/Sw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf47t94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 13:47:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDQ2mP017791;
	Thu, 19 Mar 2026 13:47:22 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qhhn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 13:47:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6MYFgbfjoxXs1qtDC+F0EUrIH7QcOLlLvhQpiai9hDt0ZrvUekpJu9f4fQeTZxCQUONgaB3OXti+Hm82TOWvYHER6H5qnMlw5twS2GMcvRAiIDUTP3+8itQJhzLH9m2MbG2Iz4OWGa0D3Cqrm/JpilM5HWAp6rLXvS0897ABq0SZlKbil0qni4eNlRvaAcl1LWNoLPfF3ZY5zfN/pPyvHewfDI1RZV5Ry7uPf7LPQnR5Yd27wh6syS7JIee6/MtI7gbs7yHqHaY5roAydsZJU64ypIJW/SkCha+/5y2nlJnxJQrNN0gXgo9UioyrqxAYxvkkpl/iNxFGWFyyW+mCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PiukfW/A7/+UqbwX7GGkm5TUNAcnBUg9FJmPuycBW9s=;
 b=Ql4PjZO55xULzfCpBZ1k6gPkJjCVtJNQII8v4QydbLTe9vBgV0/u4PDMn5F7mw1+inkF6z0QM78tgo18la8xWFaZ932frKIQkchGgj5AUQT1sbSUGZF00G5SzjlRPrvDcgNbBLZQKeVgXhFOVTs70JYF5wDg0TB5m2dDw+di1xSvIYBuZ10CSijlR0clHfrgJ0ULSq+eArV4HyGI4fKbFU6qGHY7tXcDrRY82ZhiPMsnjLTUUM7Ohfl+NU+CdF7TU9Y2yW12ZTs3edLMcX1A+GaT56dAgqjetWA2zY923M5wh5yTmPs5X5KwimniwPr1vXMXnSDJM+kKHD1wAf5oqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiukfW/A7/+UqbwX7GGkm5TUNAcnBUg9FJmPuycBW9s=;
 b=CLGsTMMzQdD84o0Ea4DKLuCrgCqowNOeom5iQP9JHu8QDthpX6EoA8x7JEgdPoRVyz4fRiPFG38+u+O1ExMIp0T1m1aW5Cm16v94GR1hbHIM8rixD3t+SDP8BydcrIiN8HMoaZ5x/Er7clJIshrNYCr5J6yfayvY56Rbwh/gAGQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH0PR10MB7077.namprd10.prod.outlook.com (2603:10b6:510:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 13:47:17 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::8338:e9a:9e3c:dac3%5]) with mapi id 15.20.9723.019; Thu, 19 Mar 2026
 13:47:17 +0000
Message-ID: <ed2c60f3-05c2-49ca-b2ed-54da7b904e23@oracle.com>
Date: Thu, 19 Mar 2026 13:47:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Enforce definition order for __msg macros
 in BPF tests
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>, cupertinomiranda@gmail.com
References: <20260305130035.192080-1-cupertino.miranda@oracle.com>
 <b073da2be883cf8f22a9a4c5f2dfa112d75d68f9.camel@gmail.com>
 <499f79da-eef7-4495-bcda-bca6c90c6f4c@oracle.com>
Content-Language: en-US
In-Reply-To: <499f79da-eef7-4495-bcda-bca6c90c6f4c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::7) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH0PR10MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: c5462c66-693f-4366-6485-08de85be086a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4s+jsEbn5O5xhliDoyfhwJWSqNsb972SpyAXSiYscZbS8wOpvtQPeSgPddqsfjgi4qwX/Tlqoq1TzVikwPmQSiqMIr2ckmOVL1K2NBMQj1H1s6mQaObspRQDsaMvIpuplLsjQTuo+wx0Af88FHI0y146ll1p7K05JLI7mOXPXRJe0SujQgQ0yDh2hlyjPQMQ+PYh6d5nsiXQ6OSrfxYhZ0wwBjy5q+gYcZtde6bYHXfvedBOlamyAwSx9dyZkTN0t9iMR/nzzDtxaZPvYpcdxqC7TQ0bma+yC5lfI5rq8qN0oSIAZ7DMFjXCWMAxx3Go+m8UT+v+x2UiWm3/8CnwiEqAvn0Dm+si6AJTft3GMVjRMz/hXI6eZzMXMdRiaawX5JV71lMAGvNE/fn/RV0kzVTTOU9uVgWJaj3v3pIYeHXJFMOSvlxlA51xHVG7muVmmz+ogpGsoL6H0foL9Sr8x+9mslFwZpZOz9nUNBhIdhwVlCT7jCoU4D2QmyvWq9P7Jx0pgpi9mEPdEUeoOzxqWqv9g/3FQlHyAIHZNrlfvZTxlPpj0wsoENzmc2xyi6phhhchgql80u61ooi6FpKr8/Pi4hmX1IcjcdbDUbc/MJiG2e6NpLWeu2vC348gza6HE3smYXZV0rh05xNfpYvn8PfNtrkE/pL1iav9wsh1K6JRtVMovDs4e8ttlXjb8V9DU398YxIkS0dqpqeI5q7w26Labq3/TJ7Skp3BB29+5l0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFpEaGxkaXlMZUczb2x2VDRkTW1uQTFIL05oTWYzR2lYT21NeFREekYra213?=
 =?utf-8?B?SmlmdUR2anpjRHRMemFHTE4xeTFZc21qRVVPY2ZvajZNeUN0MjhKV0VjTmhN?=
 =?utf-8?B?RlQ4WHdtbjB1RXp0V3JhTlJSaVlnNkoraWROVjh0RkFwK0h5cXlTeWhPaWdj?=
 =?utf-8?B?bGFoOGdDTGdIWSs0Q3hCUUVjUUpCMkxoMjF2Si9KL3V5WTJFdytDV09hSzZH?=
 =?utf-8?B?QklZdmFNcWwwclU1MWtUZTlabHZNUklhMWJIdndtK1o5czZtTitoZ0tUc2VW?=
 =?utf-8?B?b3dLK0R0eEJ0Y0gxbFA0WFJEcFkvZE1Rcm1HeHo5STFubmZlZ2RsN09XeVlo?=
 =?utf-8?B?OWV1TWZlK285WnA3djVKSlJYL2JPcGZMUCtsdlkxUTdTZktQTVFYN2lab1dQ?=
 =?utf-8?B?c2VkYjcyNXNRK3RIdTVBaGhydTkrTm50bkxhZmx3UGp1bHBIVzhsREZDM3dZ?=
 =?utf-8?B?NUJpVURsNUlhV1JTUk9sR3dMaUZhSVNiSTRwV25IMUxKSkpEZFhXUG5BTHU5?=
 =?utf-8?B?WWdrbWJ3cVBiSFlLNmVZMldOTFdnaW1VaFE2ZXVVS3hjaVVKRnpyRGU4Qlhr?=
 =?utf-8?B?QTVtZk1KTFFxNVUzTkpGS0xCSFRpQjkwRjJ3T01QOWtGdnVFSlA2VEhSOEVF?=
 =?utf-8?B?eEhvZzNZTFdab1RBSDlweHFSMUcrOWNhc2tOTTBDNGhESWw5ZW54SEtPdEh1?=
 =?utf-8?B?TEJRY3YyY2hERGQ0aFhKMDdocm94WXo2dEdoclk5VXZoQUdmZXV5YXZGcW1n?=
 =?utf-8?B?RHcyc1B5MmZnaDd4bXJlZE5WemlzS3BhV0gwV0Y5bXVrWlB6RE5EZ0ZSK2N4?=
 =?utf-8?B?d254RFhNdkhWdGM5SE01dlFSYWNuWWliYzJ0TzJ4c3p4a3FDRm5GcnVlZngr?=
 =?utf-8?B?K2pKQUxCVUF2TFRVNXRCbkpVWExKdUt2MERKWVhHZi85ei9NWlRqZmRYd0ZS?=
 =?utf-8?B?Tm5kQmFtN0s5L0ZWd2lBUTBwaGtPS2Jxc2VEMnRWVVdScUNCaGNpcHU4UktI?=
 =?utf-8?B?dDc0MXEzSEV2eVh5RkFCSWkrUm5zRHMzSHJhL1dINGd3VFh6WE5yNUw3MXFZ?=
 =?utf-8?B?MkRTeGRuZ2xkeEt6c2hpL1BQeUg4dGNzNHZHZDB5OFZkQXdCdjdBNE1sMzZF?=
 =?utf-8?B?MkdGSnJKdG1UNjlCM2taZ3UzTWpFTXFwUWtuM0U2Rm43dVhFSnNDemZhelR4?=
 =?utf-8?B?Z3k1cmZTaGM2UmxUd08vR3VucGJaMnpBQ3FZa00vckhqSTR6dEJWbmRVZzJs?=
 =?utf-8?B?VHFEVk4rVEg5Yzloc3ZYWWpiYUZ3eEFCUS9pUHBoU3U4dFRPNHVQSGhKQmtR?=
 =?utf-8?B?eE12WDdhenJVRXhNQlNnNHQyS0pRNCs4U0R6N3Z4eDJBY3VlTk9mL0o1RTVR?=
 =?utf-8?B?YjMySndBaWFFand4T2JOVlVtYThEeXlzb1E5NW4vZGlqVkZQMEIwbkdYSDVj?=
 =?utf-8?B?SS8rL2k4UkFmUk9odlRwRTJhWlNsYlkyMnRJY1ZKNnFEcHBPZGczYUw3OGcz?=
 =?utf-8?B?c3Bya2Z0dUc5TU1oNlQ0R2VaTG5SNlZobnUxQkNQSUNTZWNzM1Z5bmNrelEv?=
 =?utf-8?B?R09oSnh3WmY2NG1SbGQ3UGw5bU9aUGRaWUkwQjVpMFgwUUV6Q0ppWGdlMUFx?=
 =?utf-8?B?bmdkVW9DemxUSGVtcWRlQ0hvcTdXYlRtRDhBeFVienlUOHZOZXk4TUp2dnFt?=
 =?utf-8?B?bEZBcXBsZk53bEcvVmtNaHlGQ3F5NHFub1dBM3h1UFlWeXJCQ1ZlZERvN0RB?=
 =?utf-8?B?V2F6cjZ6SVdzN2lrdUJkQkx5aGsrSEdzS2RkYnVEK1R2U2I1b1h4aU5PTU1L?=
 =?utf-8?B?aDBybEpXc1RFdG15anFMbHVKRXUzSFlCNEd3Z2NKZlgzdVYrN2EwVzl4TGU1?=
 =?utf-8?B?RHM3OU8wc0RFNzVvZzVKaU1odmE4TnZYenhtLzB4S2tEMFNtYmgyUzljRGNM?=
 =?utf-8?B?V0wrcXRtckdlNGZnOEsyQm9zbzB6Z3cyMkRYVUwzQ0ZYZGtDNEFqWEE1L3lm?=
 =?utf-8?B?VitjSldxK3gydCtBRVNlNXU2RGF3cjBTMGdDRy9oczVsVlVNNFpmTGpubW80?=
 =?utf-8?B?UHpNN2JLSGx3a0drSmtVbExvTVBsdm45TUZUSDZDRTVOOTl0R0VxNnRTNEFC?=
 =?utf-8?B?ZWlHRjN0Yjlkb1ZhanE4UHVQcFlOQ2htdCtUTHRpRTMwUjBkZTM3UXBnWjZn?=
 =?utf-8?B?YkVOVldER2hSSU9FekEvTS9xQUk2eUdVdm1VWFVOc3RXUUtILzBRM1U3M3VT?=
 =?utf-8?B?NmEzUXpuYUtHMmdyMmxKbk1ZYjRlcUhWR2RhRDRLYVVEQWxoR3FqdG1FMUQ0?=
 =?utf-8?B?ajVyVkFwT1R1aGtvNlhYNUxiQVVvVzBrd1dKdHhWdUZPUUpHQ1NIWlFzWkl0?=
 =?utf-8?Q?YsnoQj6hfISJvLn0=3D?=
X-Exchange-RoutingPolicyChecked:
	s8DBCLy7RFo5GFGa/Va9VI1SYH80/rHtBvRB3f0GxA/ZPb5jRfvmqs/N3Z4FgxjM2L3cvNmT2KZvCbKSb5jUFLbEglTDuGr/ChlYg5UY6l11TC2lvq8hGeaT5wMvieGtcaFmZb0LolGlBj4n774whiS9aLG1zX0+nvYNCMdFV/Pt0w3CddAXqt1Wm6ePxcmhsHdvsVTlJs8W4acUVV2nyM3hcDh3tAZw6nen7m/4yz5osBygl11Doc06iWrxwQYtIaeVqgz/R5yN2WlkEboMLG3F6G4gIXlwf6ZN/aUHeYNEINIEyW9fVhbmhuWFo+uRxjEf5mM8NotaIf54/dU2Lw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BjEcS56iOXQClFh8AdBkOA7egJRXINYO4aGCIRNKG8n8x2ae8L1qmiIweTqZG3S9zOYjgd2ytHAhplHBe5urAD/sUw6D5xVyXg/8/wsuX9h8HpaTFyCDjF62mO7+n0llz4h+rSI4gPaO767kzEKIKLdW37JL3bj9sp6sTcQGg96zRN4+zyIHPVcHM6f340HhcG+WXNQBnv8Dp2D9Ol/zGcDYrA5UAvBwbw6ThmP/FUV2lIR2CYpy+IH0fQPTIqbC+GF09NrMl+T7/FNBXV4KUPfvqpPGWITsjMazbgRz9RaHCH+iYF/JAV81j8u4dan/mQlqZzAB6TLwPmMZKCYWq/FZD4bmM61Yz+L8goYqwb7If/ff/fSnvosi8kjBaFXXxK2vfb8iFiT3m2d4AnjMbIxNiJYJXtw3odi+brMEzZiAHk7ApV2ZyVl2Ai5l8fccZEG8oy7BrkkgqVka3uCBy/M3ZuPOJfNmb+0zjuWyYG/vViH2foV/MmMj/hx6K+gnmLF+BNV9ahPXaoqEgrU4EIPrply8QyRZHICpV18V9WVRhyXNSGnsuFMq+FCNyW6OyAGRvhVu6VD2NeuEhGipptRqJy9fAe+bGwVUWDu0GtA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5462c66-693f-4366-6485-08de85be086a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 13:47:17.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adfHnPmyj3tVn1U97fjgi+wFxWqAF7mD9GjeWGD7Cc6Px08e2+31vZQKjkhZb+ujtDhy9UEJY8FBrk+tXYuTQL+JKTLVWu9Ac1w+RpILwS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190109
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69bbfe6a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=c4JnAZV0I2ecPgkXfoUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12273
X-Proofpoint-GUID: YSESmVEx_6mJ5dPO01WhyzI4aLYHO-H8
X-Proofpoint-ORIG-GUID: YSESmVEx_6mJ5dPO01WhyzI4aLYHO-H8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEwOSBTYWx0ZWRfX7PZMJ5dsxKSd
 t6WUeXKnkAJSfH/wOxDviwV+MCIalrFHOsBFZLLP3CCy89RMwO6B32Hk9LjRKofBRKWplh0HBQn
 ENYH8m4xHB7NnTHU5cXe3beBd5jcOQiCwOnhHvYI/PwsXc8ctswlV1ww8t+Hg3llhkHLe/bkyna
 chF6MFoTnK/HE+HLIkpLKl1dB/wF2QMLN3j5KD+7vycK2bJeEhOBHTEgBKrd2TvU+vImLSxxTod
 TYd9MmznwebQYS5Dt3GUHAIH3SeCFuoFj/SWt2KimPjHGistJF6tjlBDT44kdJ0UqzIOHED4ecE
 iwhmuQB/XcXmxqnU/M7DlGXgz6h6Oqqvx+GSnuE2CMAqEpnTmDGFasy5Ehsq4U85OVzidL8CzEH
 B6F/PbiATLLzlQojV1qOJMw7Uoz20vDDJehxgYDhFDhOd/FP0OkEyFyyfGv8fZMoBHpmxV6eDl4
 mlp8/v9E7JE8VMSqQKj8gPVI2Pu0DgS1o+ni7JOk=

+CC: cupertinomiranda@gmail.com

On 19-03-2026 1:45 PM, Cupertino Miranda wrote:
> Hi Eduard,
> 
> I might be mistaken, but as it is skip_dynamic_pfx is dropping the index 
> from the string that is passed to push_msg.
> This is the case since it is matching the '=' in its passed macros;
> 
>    #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
> 
> dropping the index and the other equal in the call to strchr(msg, '=').
> 
> I know the patch is rather bigger then perhaps minimally necessary but I 
> did not want to change the semantics of current implementation, except 
> the array ordering.
> 
> Did not really thought about string ordering it later, however, if I 
> think about it, I would personally prefer to order the array at the 
> push. Ordering later during a processing stage IMHO would obfuscate the 
> fact that the array is ordered by its index.
> 
> If we change skip_dynamic_pfx to also return the "<index>=" then we 
> could parse the string and insert it ordered in push_msg, not really 
> needing to wait for a later stage.
> 
> Anyway, up to you. If you think it is worth it, I can do that.
> 
> Cheers,
> Cupertino
> 
> On 18-03-2026 11:07 PM, Eduard Zingerman wrote:
>> On Thu, 2026-03-05 at 13:00 +0000, Cupertino Miranda wrote:
>>> Ensure that __msg macros, and similars, used for BPF test validation are
>>> processed in the order they are defined in the source code.
>>>
>>> Neither GCC nor the C standard defines the order in which function
>>> attributes are consumed. While Clang tends to preserve definition order,
>>> GCC may process them out of sequence. This inconsistency causes BPF
>>> tests with multiple __msg entries to fail when compiled with GCC.
>>>
>>> This patch fixes the test runner to explicitly sort or process these
>>> attributes to guarantee predictable matching behavior across different
>>> compilers.
>>>
>>> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
>>> Cc: David Faust  <david.faust@oracle.com>
>>> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
>>> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
>>> ---
>>
>> Looks like this patch fell through the cracks.
>>
>> It looks a bit intrusive, given the amount of places index has to be
>> passed through. An alternative would be to modify parse_test_spec()
>> such that it collects decl tag ids into the array first and then sorts
>> the array. It will have to use strverscmp() for comparator, though.
>> This way all the changes would be localized to a single function
>> collecting the array.
>>
>> Up to you if that is worth the hassle.
>>
>> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>>
>> [...]
> 
> 

