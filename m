Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E0388E49
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723244; cv=fail; b=aN/jeASrMPZXdoYC/M2feEGhtXzfoJ5BuDg+r/GudSJzHo13izFzauV941Rn7XDiUM4p2GVoWFy3ff6uqDlu/Fp5neSQXCkaVhFmlHZJSNOKHdl3gOZo+BUlO0fe0LEsyQ3lKgyaxN6vezhi5+iP3LtMhIHc2IEU6xRMp73sWBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723244; c=relaxed/simple;
	bh=fiv8bp27dzTRqXl0gg5gA297cYZVNMURh7ur7d4ldy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sUqBxKKYGMUuI1ii/FTcMdkGO2u42niDOJniILaQQFdYf4a+fWcqKvhd+e8nssINQN9mFmgym5m5qOGmXfc2neFXbARCHILRXggWRHBb93Pz7pjwxqy/xHF/FmbYC19iO+0XJsDQGn30DwZ2RhqU7jYNxWQnqXhBnv6YjI0vQx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hy8pBoVR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nkkS0e+w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hy8pBoVR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nkkS0e+w"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I3tjt61822061;
	Fri, 18 Sep 2026 09:20:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ivYr9X7e/d3UF8fvtlNN+1Bp3V89oEOrnaHTOmoSxgQ=; b=
	hy8pBoVRRu5+o7BdmDaF9C1eKvd8mJ84v6FcaCWADSNoimDabaLRr96VnzkqD2Vc
	bXv3rtJHe58YLvSMwoEqfQLDrc0Zd404/1csUljmK+WTIDt///ch6nagPJSLdS3t
	kPv2MKtoeVBHJDKlb/OXD/UCLtU18MsggkZkThdJtEzbgVPcAGOzzauRveswab0h
	E2zSdwguHBA49CtDJNg00BHzp8MOA2WUwxlU1xr2Luz/TVNCdJrE5E2+gc7XxV4r
	gTA5daK+Kh4mjusEZ234ThAiV8HRcwpBi2pgOliNJurETteR5BBiiggTJCACZhzS
	2N3eEZO2e8Wbau6mkWkQfw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmy9s16ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 09:20:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68I9K3Tp040746;
	Fri, 18 Sep 2026 09:20:08 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6dspta-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 09:20:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7JkTk+4f6t5gmG63lJWfUJQxEaVwW6QQupMZc8yWMANIn1uJZDtflj4+1aQZ/6Yuil7QnWL1TjfLHatqTJRuLc99TyoNL++1BL/lxh9OR+rVquiDPJlza/xCPqjXImnAOUjzLynETxGb1VK2MDxl2Yn53UTChadlvyiCCIyMjRSMiq1BFF4fTpzyZqm40BdGyzHxuGUDjKgiJw67bVaUdQMjHVMxmfQGnVt8RL5suCOpfqHksuTvT0mEXSmxnlxAZ47oVg5QpLeH0BDHRU8NcWscQi9EY7UjhilSw2lLvjRVWFACeoz17YI3r65QVQZOAfvnPSZs4UFyf2xGmuXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivYr9X7e/d3UF8fvtlNN+1Bp3V89oEOrnaHTOmoSxgQ=;
 b=eD6NDPWMG792Y4xgsecvRqJ8MfmRz9xM3ZVSSxsIeBT78zZJwO4tz8HYNq7rdZ4zbu0XjdftLij00itHKR8cYGWlRL0XaYjfQIUj6Kr3/hsGXOGmxiIbD74GeHWwtv6qRrvdIT4GrvNPieZmqsIMzQPzkBzDAB/uTLtSMI+ka0JPDeQ7hnjimu86r0o/3KhCHm+VGnplfscfqfqRfADOMx+n6918sTZxD3RR2Wshplf9fJxy5fDiQQSR9dVUBgiPh+FGm/4/9nmw/mnBjscsqSo3G+/Wx7ywXIUdGPqyw0QyHZST9kOzt3eLG/qLxDC/aGa9KFhgUqO3UqLGU4KCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivYr9X7e/d3UF8fvtlNN+1Bp3V89oEOrnaHTOmoSxgQ=;
 b=nkkS0e+wxu4wmXUToql/xQQ6XM9GCHFOC2Xc57g5agvwtFTY8e0cl35QHhpSarO5sIjhERQNknTlofnCjbOEVjyLlW0ltmDDGzYsu98ujIN3YN/cbokf8b7F23mxlQM5I0A52MgKnP+hrYilTGHkAoX5UJit2hK6nsyFajZWVc4=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by DM6PR10MB4187.namprd10.prod.outlook.com (2603:10b6:5:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 09:19:38 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%6]) with mapi id 15.21.0451.004; Fri, 18 Sep 2026
 09:19:38 +0000
Message-ID: <f5167878-54e5-4b89-8ffa-bc48a96fc651@oracle.com>
Date: Fri, 18 Sep 2026 10:19:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Jiri Olsa <olsajiri@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net,
        ihor.solodrai@linux.dev, yonghong.song@linux.dev, song@kernel.org,
        qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
        puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com> <aqsTCF4uGmN5SlZD@krava>
 <0db440b3-f39c-41ee-bc77-4e3d2ef2b95a@oracle.com> <aqxi4p_xlBTSOtTf@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aqxi4p_xlBTSOtTf@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0034.eurprd04.prod.outlook.com
 (2603:10a6:10:234::9) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|DM6PR10MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c44386-6610-404a-f8f1-08df1565f685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|3023799007|10067099003|22082099003|56012099006|6133799003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Acs34Hq+fdINqErZw9SEGN51s3rKh94IAPAxIldgO+oTWAW8bXbwChMvZ3qyk6TaPlR77pbZW/afAvERdTJ0JqTe6TpMu2u+pRuauLQfB6IFfv8N0douTzoQZ18ZxOUyjlC/TV9UStmIY29WdZijFrYV50mdN77RWi64brO58awJhh6r9Fmx4Mz/5tmoQRv924Wkj8iO1dV4yFltPJezTZI9YH2sX3S9ui8eVUyIG2CppXrmh610z5nynfzzgfU2DLC+kJIj959LZ5ikiAnGtuIlA6cJ0Cin2+RK9baxmjrvZZyIvXPbMaYUEBGvBzM6+OU3iq/F5nwHytK3vD8S4mkYB4rEcdb4XGnUvBBFlhNu7a9PwwHSc9x4BZAPXQU9aRu4zgZPbeeNb8uskDzcBQNkU9Yxw/sqKaNfGFk10G9qClNbWj/C28i97Zkh9FtzmHlxt5XnlGbh4xy6sE09sIutvwdvr2zDT/wT5zpObxRBYi7ELvYf9y7yC7/aVDUgbVNw/gl61dJ8Qt4QU4G7C9msnVgMj/1wZjWoAFjjk4Ti8PuPrHvsKbCzo0qp6r+87VHzgTHVMnK9BdwpG6wJ9XM/CILPK7rXmwUvmGjj2egzxBjx8FbHMFoGVjBrbNmG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(3023799007)(10067099003)(22082099003)(56012099006)(6133799003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHk1dGcxNG90MGFGVGY2aktWeTh5VjdDU3NRNEZQeVRVV0dvNzhSZmtrSkRD?=
 =?utf-8?B?OXJjRUpxbjc3V3ZGQzhSZ052ZGZ2MlRvc0g4R0x1cVpIL1NyR205bWhvcWVl?=
 =?utf-8?B?WGY5NlptWExzOTJVaW5LalkrTllhUG05eExvYlV6c2pSWGsraitZTThpVGUz?=
 =?utf-8?B?RTBUbzAzbEJsbFozKzlqTnZNcnJqMzBzUmFiSlJlVk1vRUpURXEyZklIeHZk?=
 =?utf-8?B?d1VEUXpKRTk4dGdUZHM0TzhGVUJRd3NYcklPSUVLcitVRE9CNVNwa3kvUDE1?=
 =?utf-8?B?cVBGK2xjdEI2MGlOTjREL0dVMmJ5YTdxOGFUUSt2Q09uRXM5WDMwZVhzbk9V?=
 =?utf-8?B?YUYyUjRNRDErSXQwVEVzT09jbTV2Y1p1Q1BDQ2lCZi9IdkIzVUlTN3hIbHRE?=
 =?utf-8?B?R2RHT3Z1dXltYWN5RHA3bFVRb3VkRHh5KzV4cjRUdnMvSTBGTFFqNHZaT1pD?=
 =?utf-8?B?MEdwS1Fxd0xubHZ3Y0s0Sk1sNlZtdlk1SU9EeGlOR2NiOUtwVHAzVE1hZVM3?=
 =?utf-8?B?N0pGRU9JaTlpVmRpcXRNeHpHc1dEOHBGU2p5alFoSkZEQ0doWFU5L2JJcHVH?=
 =?utf-8?B?T0d4SDJXVU11ekltbk1KR3NXQzdFVkVZM0FHVVF0SFA1TjNRNGhPSGpsT1lY?=
 =?utf-8?B?SlBacnJvNnBWbFV2QmhEK203TDVhcjJKSmRldzdoUjhDMTVHTE91azJEMHRD?=
 =?utf-8?B?a3RBeXNxMHVReDBvTXpxUTFxVlkrdjlZMmxhWnRvNVo1N2VzQitTVWRZdzhF?=
 =?utf-8?B?L0FxYTFUeW9FWm1Cd2tmUkVGK2NLakJTV2R1dHdVVEtjTTIzQzhoZWdxQkMz?=
 =?utf-8?B?d2JwU3E1V3hldVZKaGIzekp5cFk1eFlDSGQ0WGRodlRiQTFjaE82eW5veDd0?=
 =?utf-8?B?a1lEcWNXUTg4WTF4NXJTTnNPSUtBTDY4c0tVMEFKcFlQbzNEcDFidEdFQ1d5?=
 =?utf-8?B?TERQaHo0YWdhRDNiYllpc3lWZ0dWODdpVXlNZ1RUOExSTlQyZzBuTDRTNVJ6?=
 =?utf-8?B?R0xOYytKR2lLd2FtdE5Od0tRVFVUM1BVMXM0S3JWMEE0THErSDVseFhJUFk4?=
 =?utf-8?B?bDdPTXcwNXpDcUduK2xTb1lUc2RKNzFmalJYN1R1Nld5WjBhOWxURlJlbVAz?=
 =?utf-8?B?YVVnYXltZ2haYkNpSGMxeFQya1Q4cHE0ZlhLUHBrQVBXZE5nQU1lSmY0OUox?=
 =?utf-8?B?clhkZXZUaFR1T0ZLY0NmWlluS2hOQThpMnBHZEg2ZjI3VmFwbXhJdWw5dVBn?=
 =?utf-8?B?b0JUcTRKZ3VGM0haeCthRnhOWlp3SkdzeCtOaW9wUUV2TU9XZWVkZkhJOWJo?=
 =?utf-8?B?NVE0MjZEaUlHTDdwY3dvSXNtLy9RdEI1RTFQTG8zcjk4cW95TkUxbTh0M3pZ?=
 =?utf-8?B?Nm5BMWhRYlpoWFZOYm5tN0xpaEl0aWc1S21mb2VLZG5BRkt5MzVOYlcxbldF?=
 =?utf-8?B?U1NRS2doVTV5b3RVR3k5Zk9taG1CSmQ0ZjlJZlErVHR6V2tIeitXd1B5dUpm?=
 =?utf-8?B?RHNSNXZqVTJ1dnc4UmdGWDVjTHNocVh1elQ4ZHVQSkFQb0crK2Z3bGppK3Bu?=
 =?utf-8?B?aENmcGNoQ01BbnpvanpKWXFKdkR6ZEJ4U0lvbS9hcGVkQ2c0eittZnJLTkhy?=
 =?utf-8?B?NW1LNGd0b2MyNUxxY2t0SytvSzZOdWtWMzFldjlWTzcwQWZjZnpkTUFkNk5C?=
 =?utf-8?B?SHFZeC91NVFoNFR1QnFJU0Npa1VGZkdGcnhYZnU5em9zTlVGVGpQdmIyOHIx?=
 =?utf-8?B?cXA3eHlJWDI3TENzOUVucjdHcFNrRjJDci83U2M0U1FxaWp2aitEcytVYUFC?=
 =?utf-8?B?WEREVC9Xc29QWTdwOExJeFRQRG4vTTNDZnQwR2U2Q0RpT2hrMVlUMzhtYVM2?=
 =?utf-8?B?T2pmY3l1L1ZYTFE0OFkrbmZ0bHZMNHFQM2xoVGNJdk1xb2Z0MUxtSnVIU0I1?=
 =?utf-8?B?Tzh0alFKQkZPTVprZ1UybFlEQmE1Q3lqM2U0bzRubUIwQW83RFR6STNLbDhv?=
 =?utf-8?B?TExtMHlBTzI3eUVTRWs3ODBpODV2QjZ4b2JnR2g2cUpvZGtvTG5FOGFTaGtk?=
 =?utf-8?B?RGpNaHFiQnVqRkc2cVlMQTVseUxaOUhpMXpKMXhVd2ZxRFlDNGttWG9XM1U5?=
 =?utf-8?B?RTd3cUZnRVAxSVc1WDZ2NWpQYnlIeHFLLzZJNXhSL0pQemhIeDNNM1pRK08z?=
 =?utf-8?B?bVpWL3BaVklaLzRsK2JkUWVlSG9IbnNHYzU2VmNMQnU3Ull1aTJVc0pjRGdr?=
 =?utf-8?B?cUovNzhsVUVyczh4NzYwRE52N3ZmR1Vxb01pWjFGQ3YrcWlLU2xDWlUxRXhV?=
 =?utf-8?B?TGNBMk5wb2FQajNLdXVUWnhLTFdweEtYVGRsQ3RiRTB4bm8zMXlQdz09?=
X-Exchange-RoutingPolicyChecked:
	hYbruH3w9rRq16p+a2pMNZHike4Md54snTbxLUJIq/h6XS9scnYLqXhsoubyR9jyWHrpMDWhqdXqNB+vIwj8FdONQ3BnGqBA9mSMRTIfiVyUypoiH1vQcnPcSH1VrN0MPemR62oevTVYQnH3yu6QxWEBdfAp9RTRpyoNqk20aq6FchVh5MNg5aEdD5UBcvOYtGLsz3FKzHhtNjbe/WXQkFlusDA5o/hQW6XHORueTfkEB9DTo15GwlGuDdjIXkNk8AKCrOXOg8NMnitjumqlKz3K4wHAiGwCwMbxxenasKW6MFIFUXGlfkiiG64tdnTUPrvUwnUq0YhuY+xnDWvzcQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jvoU6DQr7eQHXElYZzb3UpRcJNFbxmF7Mb4JLwaugjCuGA9WtGEtNCpjtYnBjK+9coXaOxU9dFD45Y9U1f3YRKWFEvcbbzyI+0vVvgTwPDPpmagUsIv4gzPiSypNxTdFn+dyARVtvnJr8C5Po9pPscsfanm0QfsZTogw9kyXKzT68hTaGg0nJcFcCpBB/aOqfv048KKd6repaiqyJOfXbAJZQrX43AmLPYhBjmK3kZ836PJwPUlQwR2IPkbXoIb1BXNkQecgejrx/uO893yfFs/L+haQNeFJZZ6l4XQCD4UjvkeTmacVB3TrT4EyE7E02B8e/5uUBt7MYvrBjkqisNOfBHSdgzCptmgWtBLTZuqyb1aj7c3Mbc4x4FbwfQhV4z0RUwuM5Wp2LzKzHytt5e8HK/4FAchxmqhauRliQDrfIYpj41GUQhtnSkbUW+DX/B+99XOHlRGdHZDjv+6jEHqMvoi4acibDRzzXR/s20n+FT10cKk8TYGGHGZNy9wnEJ3hQ0HRcQRHbQKX3Tf1Gjf/SD5ytxawXxDQsDKSV6NlhNoN7aS1vabXQZJ2DrQwGVKz9nyy5hf2jMuUu+ByrI/Ehj6fJ0xOdSeLIMsTCR8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c44386-6610-404a-f8f1-08df1565f685
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:19:38.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: osCfjFvRWpiQL/uhQJ1UScR53tlsXThqePIo7m3839nVD5xnerMJq/OX1uhU6iO7avIzdij0RvbSGtXUCo/lkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=920 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609180129
X-Proofpoint-ORIG-GUID: XfQyiT_Xs4vB0f4npR6_4iKBjWuZMbdq
X-Authority-Analysis: v=2.4 cv=MuvHeGae c=1 sm=1 tr=0 ts=6aad0249 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=El_hQXKkAAAA:20
 a=bITdrMly04YlefAL1UgA:9 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEyOCBTYWx0ZWRfX+hPixhnfad59
 GMbY14rlYdayLM48lkgnt9yjdQAw+vqpz4qTYLsf9WRdLBwX+k46lx1/EjovgXwIPUO4IyEPEE6
 K6O8cqbZlsLu1twQJVUZ0jIJkMDdWNzy0Se9jRo8lw5tz1ZQLT0C
X-Proofpoint-GUID: XfQyiT_Xs4vB0f4npR6_4iKBjWuZMbdq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEyOCBTYWx0ZWRfX9DH852Wir5IA
 sGrn49AHgaO9VciXf4x742JMQfTEgdieu8/8ngX8NFWrXeQ5L9+eOWd85jQVund/mQeca2MO6ji
 DI18+0Pexs0cxKWVlakQrO8Rn9O0U6Y9wEyPe+nBJYNSZKscG5fI+n29qUjsdwBQMWE9Fowh8Si
 u6L2RWOAXXfk4kbVH2mqED7Y2dq/aoPrUivaESiUQfCQLkpoHWT9n5nUMGAN7kAicMtwghRi9iv
 Dj+bUn3f5t7re0ouhrpuzxe+wnvx69tQyYWFg5poQgbOBkA9jSe7lKIUGvAkicrtmSqdQFwlS9K
 lZqSZmz5aXKsAy5j+yI9w45yNSuv4m0/oF7qE+M0GiPtHoGiIEKkWmBDAa+YYg48k1YkU5IECfH
 TaU9GbVIH9PmWw+kgn2L7dP/eqLRyXUQwAt7L7O1hW+znkfqFyl7xZob5VqnmDtV2KAYZ2drJEt
 DyK3krBKKKV5EQrC5XQ==

On 17/09/2026 23:00, Jiri Olsa wrote:
> On Thu, Sep 17, 2026 at 09:27:42AM +0100, Alan Maguire wrote:
>> 
>> 
>> On 16/09/2026 23:07, Jiri Olsa wrote:
>> > 
>> > On Wed, Sep 16, 2026 at 08:41:16AM +0100, Alan Maguire wrote:
>> >> In raw mode ensure we can dump new BTF kinds in normal/json format.
>> >> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
>> >> const value of 0x2a and a dereference of r10 + 0x20:
>> >> 
>> >>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
>> >>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
>> >> 
>> >> LOC_PROTOs render the associated values of each of their
>> >> LOC_PARAMs for easier readability:
>> >> 
>> >>   [14] LOC_PROTO '(anon)' vlen=2
>> >>   	type_id=12 value='r1'
>> >>   	type_id=13 value='*(r2 + 0x10)'
>> > 
>> > nit, AFAICT these are dwarf's registers numbers? could we output arch's register names?
>> >
>> 
>> thanks for taking a look Jiri! You're right they are DWARF register numbers alright;
>> the problem is to render them as arch register names we'd need to maintain per-arch
>> tables in bpftool, which seems like the wrong place to host those. I'd suggest instead
> 
> is it that bad? I guess it's just simple fixed table
> 
> not sure how useful that output is with dwarf registers, you'll need to convert
> it to arch regs anyway to make some sense of it.. we could save some tokens ;-)
>

Well it is a raw dump; to draw the analogy with functions, we don't we print a C
function prototype for a BTF_KIND_FUNC_PROTO; instead we print a set of BTF ids
that comprise the parameters. The problem with converting it is it then becomes
hard to relate the raw dump output back to what the BTF actually was, which is 
often what you want to know when you're doing a raw dump. Now that pfunct supports
split BTF I can roll support for printing per-site info including registers etc into
it as part of the pahole changes respin.

> jirka
> 
>> we augment pfunct [1] to support this; it already has an option to display inline expansions
>> from DWARF, so having a BTF-based expansion of inline sites there seems like it would
>> be a more natural fit, what do you think? Thanks!
>> 
>> Alan
>> 
>> [1] https://github.com/acmel/dwarves/blob/master/man-pages/pfunct.1
>> 
>>  
>> > jirka
>> > 
>> 
> 

