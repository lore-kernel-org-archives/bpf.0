Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B763CF1FD
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795989; cv=fail; b=qCQ6w8HAueX5o/bptZI8HZxBcosK2SUazYs6pRHCJmWFw/LHAjups97GNX/4bMHhElBKqIoqlgCyrAEXzOgW2TpKS3nsNBVyn6sUezJzQ2up3zCUYDkH6ywn8/PXsXjyy9xyIjvLr6FKU+UiTNCn6QGDfNMX4o4H0+6LDxD68/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795989; c=relaxed/simple;
	bh=JWotxJ53pO1ImJR+w7yv5GV6KlAcKaEhLwIeLa0d6fo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h4U74fkfNvGb1rfQhkWDeaWvlBAc7xA8Rz4T3lATtEeA5MDngml3tIPbxizMuIQtUwlSUtCqyboeg6G/iLAJiIzUlfSOs4adhVoXlzM75NU2ZQHzVLeWzMhIwVoiMFnDzX84DRn0e8rQjZ3mk3v3hWubqE7JVq9kr0QoFxeDJrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RUW3fFX3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KnHF6e9V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUW3fFX3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KnHF6e9V"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687DInQs1484217;
	Mon, 7 Sep 2026 15:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F98cyWh0TbnoIHA5M1FvKTi1Abe9XGVwNPRhHPwVWEI=; b=
	RUW3fFX3ovkOazea3zXxHv6P3Wh5HymVbezaPL80Sas3BUbj7fuk+mr7zpEK2+2D
	DB96N0JMYSSi6tF7QS79wLmnyERN+7S5I8AnquY/lEUYAMVZiIBvHEIreVxRXeOp
	x0JUvsMhYa8AlMq9spbus8L33RA9k177SG5XFI+wPBN4Lg25L2flVeR7kdlp9Q8T
	CptkFsRpRU2lyaAODeEoqr+z0JpktT9mjCyhFxX8dFX2IzFo9K2+TgMLmvRlRGtY
	kBaG9mGDGkUvwPX+Ig1jSGF1IuNGOAIL//jyNoXwc8ogIB8fXZnViL9TbQ87LYm8
	Q9GxFQjczJQi0YFQp7bxRQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbdet423-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Sep 2026 15:46:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 687FjvP8002572;
	Mon, 7 Sep 2026 15:46:16 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gh7atwwqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 07 Sep 2026 15:46:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPeyPjbG+TjQL2VX1NbsIUoTTtDNbP2mhqKaT/pXDibsyB0cy91CDju8C5jEU4VS8awVdXJU4qoKY8dmhYns4o8fl84nXKmg+PDyLOW84f6ylnf6AuFka76QBHxz7FDqTRuZf8OJ27olMLa1o3eK2KBguvhoVhXpZgeF1gsd1zmyQK9FVRQfZvb26AGoJR6/2mP7CM//QOklIv6GcvhkiczMv4H1bkOsKibOTFFeWOFxkZ7J2WQmH1u9uT9Rzs5QgSwwifISrrq644erM68zMKziFnIaswkz4gNFjyYvGpPmg2ttL9Ng46rs/aRgEArup52y/zHMrvSeSNXIGByCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F98cyWh0TbnoIHA5M1FvKTi1Abe9XGVwNPRhHPwVWEI=;
 b=HP+1H+bT4K5N92qGIivDxI34e81e3YgwUzIsszECD3Z4yw0V6Ew8kXxOLpPGTn8bOYxGcOCdO2vI3CxKKp+PflhytXqFuQW5Y7XNx4WqUX7HFpdVYEe/h0xNLePvbjGgDsr3C1dNK3BVJmox75jc6uFIC/O4OxS79H3M8bH0xM1f/eLSlwp7Fj+91vrQXry5PAV18d5OXf9g8nzNvoM9UpFh+XuuG9YyoYt86QVPgOGRcNISOYxLGINflT3AqfuNMJIslc91lnSMUjCyuRTyHh5xhbuibD9g4pM24U+wiEfVpnQpduyIO7Msp5KykP9y88yGbSMIKJMsScHxVbpxEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F98cyWh0TbnoIHA5M1FvKTi1Abe9XGVwNPRhHPwVWEI=;
 b=KnHF6e9VaEDmJhxH1gRlagCCgAJZbNYWJigf3nYz8lWkLDvX6uL82SfY/HqMgmexM5M4gklLNv7zCEDelhwrO65jBARCyb6VxlND/8i5z/wZyYwxk2xR3dG07dEqIcSugurFRgnoA1hqV9l7zRIK/2uZ6Jfm8stPMlG8UEqVoOA=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 15:45:17 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0406.002; Mon, 7 Sep 2026
 15:45:17 +0000
Message-ID: <f22d3b93-65b5-4b06-9af8-99d0e65eb33b@oracle.com>
Date: Mon, 7 Sep 2026 16:45:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Test array element comparison in
 BTF dedup
To: Mingpei CAO <caomingpei@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, eddyz87@gmail.com
References: <CABzjXVz3iBuump-pXFkefZ5v+2uu4fG61zqRyWD4xmz3PuBycw@mail.gmail.com>
 <20260907131021.34343-1-caomingpei@gmail.com>
 <20260907131021.34343-3-caomingpei@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260907131021.34343-3-caomingpei@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::11) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|PH0PR10MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c3239b-adde-45f0-df6c-08df0cf7036a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	XezGa/tBsRgrkHmw7Iv92iS8RxB5QM2B+ABpWADDP53k2xwe6CAuD0UA8Ev3KXvHwoLWPLz8WCeASylLB7qqHVtomv/umse2Yms5K/ckpStDELhUWnVpDpxYneaX7B23I/rhAVObZ7ILiHvj49KLiOgqlaFEiGh+X/BA335UmDi85qKg0xBJ1+6kkgPewEIAu6lKalyl0QoOVoZkdjWkiHbJM9AZhHpURv0IbkX5+fFrDzPBammjn/QJL3RQ0SeWpPIkrX0b/Nay9GuyNK+UnhDPIUWkh/SrtZF9DLHkbF/dyW/Yp75rva6iIlIV29DrlmTMaScOPIOQx7z6u/4nngC8zc4xmFRXUTCAyijBm0xk8XmoIi8lj5PEUFH6rI0yu1Lz3yEFHFJ5tRD/zHI6dvy43wkP0CC9fDM+3uVXravk78Vqw5xxqPTjBY24pQbrZ3H3y3uRbExHYCg1gkoaMtLxxxrm1pAjto9I0G420XOzl5QcNLn+4C/rh6M+fFZOW2EBowUBAWWqE9G7tRHHwJX6RuMC6RJlwhWtEv9pjxCanM7vhIKIqQD5iqVkYxoYEDYc8wF8TKbD49ugJGWbjkrS54LtRr60wkC7iDfFiDsPV4TslhkUlmR7L9IhJZSkGL38O/XBGgEUOIrL/kvxeYrJnDS2DgIOKpm/91oldgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEVCZDNxcTRPTzJzTG9YWDE5TEFOTGo1TTRFREMydkRNSXZJZ0R6ejlvYXhI?=
 =?utf-8?B?bUdjdG1IbE5yeEpPYk14cS94UDU2cy94c3E2eXowVUw0VzJPL1R0VlF3aU04?=
 =?utf-8?B?dmFEZ3dobHN0QzlydThQc1V4Vm11eDViRTdqbmlZSHdPN2plSmwxSjVtWWRj?=
 =?utf-8?B?dmtWOHp1SlBBcGVyNEJzM0RxTWZVVXRwcmhTaGhGcXpJcnhjRFExZmRFd3FT?=
 =?utf-8?B?OEgrTDd1WXJqdEJDQ0dyb2NxMEI1QzhzaEtVZFdaU2JKR2F4Y2hmdURoeUFT?=
 =?utf-8?B?cDhxRjBmdlAwTEh5VjFiMFhKWWx2UTJKamlyOWdrNjREYVBXNEtBL1ZWSGMx?=
 =?utf-8?B?WFQ0VHRmL0ZCbGw3SmVPYm9JUk1qWnByZHVHKy92NTBJQXd4RnJwTWcwZE1J?=
 =?utf-8?B?VzAvRk5VRlp3THpEMlYvK1pzWnBVZXd1ZCsyRkEzSCs2czFVLy84VkhjMDhw?=
 =?utf-8?B?N1pqdUNwZjQ0WnF2dGYzOVM5bEVBSitOTEdObFlOUXRWOFRPTDV2MDBzbFM0?=
 =?utf-8?B?bklndHcvb09GZ2NpK3FFTnBVTkdsSUkwRkQyZWNJYjQzTXFSSEl6dGJhOFNn?=
 =?utf-8?B?TFR4ZVlWM0ZYNWpDd2thd0k2LzRQR3hsb09XdTdueHF5bjZQZ2NJNWd3dnEv?=
 =?utf-8?B?N0JPeWxEMzRnT3BzUzBBTFlMdWtzL1d1Y2lzNjM4bmdYK1RZYVo3UjlqdkdX?=
 =?utf-8?B?SjA0dk9KRGVvZm04WTRRdTRsQnVIK3lHUmRDUXBiR094WExtSjl3K1JablJH?=
 =?utf-8?B?SDRhRUUwMGQwTFpwNHJxWFJKQ1pCbGtJbFBqTk9Md25iWGdaSTBJZUJyZCth?=
 =?utf-8?B?Uy9xNE03aWgzcnB3bHFnd3R1YVN4OUNETVhVd09PL1J4TUNzbXhzbHRjZzI4?=
 =?utf-8?B?Z3BLY2hNdjR1YUNCS2VYZlE4S1hqZGZGWWNNd2JESjUwVnZqSDZoemN3eVov?=
 =?utf-8?B?RTBvTFN0Ky9VWUFlN2U5amJJbXVhT2N4bTN6a3FNZjM3bnluQVljZStLd3hG?=
 =?utf-8?B?eVZhWmdRTXBhKzJxb05vaUxuYW9USXkzWDk2TEx0dUtxUEkzV00ycUZsOVlN?=
 =?utf-8?B?ZXYvVTN1bkZ3VmRtMlBmTEFranVmemhXdnRHZGdUTmprK3BsM0ttbFVRQjJ6?=
 =?utf-8?B?T2RYdHZ5N003QmFPTEtEclQvcllRYVRYRERkVjVyVmUwZG9mbUVWUFVDR3dl?=
 =?utf-8?B?ODRNWFRCanJDYkdzM0xmME95aTdHUVg5T3FQcVdNYStlVWZDeHJsc01PbU00?=
 =?utf-8?B?Y050QzZRRTNGK1ZDN21tMHd5S1FNNkwwTkFKMkZrR2YvaXdNVjZqMVRvT1dF?=
 =?utf-8?B?ZnduRURSSmdIM1Jxc0dNTEhDN1FtcjY3K0Fya1VrZ09IdmhDYWhySk5sT3R0?=
 =?utf-8?B?VDVIQitzNkV1Wk9PaTlKYzRnSmMxVHA4T3o1eTRpVUNvREJJcktjRWdXYW1M?=
 =?utf-8?B?NW9jb1NHSnRSeFQ4VEFxS0IrbDc5dXExWGx2MTNtMEJOWUNOQWdTdStjcjdp?=
 =?utf-8?B?d0lBeTRTd3dsSytHRWVnRDkwV3VWZ0RybGY1YUdwKzJraDdycHFrUS90VWpE?=
 =?utf-8?B?c1YyUmFBSVYrd0JVQzFXUHkzRHZJdThsTWI3N2VrZGhHbndrY0ZyRzNHdXVX?=
 =?utf-8?B?bGl0Y3VHcmFjQXlMNThDOHZwaTdqdFdrVWFsaEdnaWV4djB4azh3RS9Sam1D?=
 =?utf-8?B?VFpMVGRsZzFtQjlJMzlsMGJCSWgxT3hZazhrUlJLVmkrTVBuOVNPOFFZcUNp?=
 =?utf-8?B?enhENkVOSGkyZTdXbElJTWEwTFBhOCtGMzRSRGpiOEtpWmtXTVJSK25TODZa?=
 =?utf-8?B?TkNmdVZ5K2xNanFwcUozOHVMa1pXT0hWUmRyWGYrQmQ2clZWSU52UnhPUVhJ?=
 =?utf-8?B?d3kvZjgrQjFnUThNOHZ5M0NqeFVBeTNydVVhNlZqek0zQUZYTERrK2ZvTnpt?=
 =?utf-8?B?OWpSK2NXeVdQNkdKOWxNMWFsTE84MkNLYkJTdHhrVDNPWXZuZVhHR2NIMXNK?=
 =?utf-8?B?ZGU4RUYvdjJneWRVdzd2a0JRWVVSQ1dRUjUyUXpxR3MxeXlSMUtQY0pyQTJT?=
 =?utf-8?B?bm1ZMkR1M1dkSDVlVXI1V0VMUHFqMitnQUhlaHp4T0Fhb1hWUFNxazBqaTI1?=
 =?utf-8?B?dzMyL3JqRTZrYkMvV283UlhZR1RxckNmb3dQclFidVg1VEJBV0RlY1FXSHdJ?=
 =?utf-8?B?UUk1K0Y4QnJpd2JmVXpnbktiOGVXOGZ2cUJYUGhRckM2bmVRZU02WjdqWVZE?=
 =?utf-8?B?RlJUVTFBSnhqcHUxSEJROUJoNVBYdndHMkE1RlozVG1JNitEWk9wdEpjYjhl?=
 =?utf-8?B?dHA5NFQwVWd3RW02clI5TnBJOHhjT0owMlkrWnI3eTRkOGFuUkM4dz09?=
X-Exchange-RoutingPolicyChecked:
	fuvTI4XlsubRadWJsqtrvniyjpCtDmhH+gUB0u5vAEDMh6FhH9Jqr1frV9+Xf2alg+ohWRc3N6tVrVI3MCK5kHO3Ynvf7M24814kLjmgrkO6NEmNcr6HzEtJUCUo0GU+PzlsFteYOenSyCbHQ8CdXJy9mp6aog3jUN3mI2ERO8ejC8mgIWdngacWKqN+gREjjhXvrXlajehj3vbUv7f9UC0aPjVByBPGdv6uCMLhTrkE/fxMz/T79CQtKFaCqeedaNcMc+vvKjhvl+bvpgRhdjH9JfaIhV2iydL9270X8RfYQFJmDdZDdKSWGWAsegNXaEpE9nDzfFEe14p6QmpuXQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ooMgKJspL9+fHmkKp8Z4fbtxeA4F0YL4NTzZ8L9tGCaA6U1HpGDe39XlJiUo6Kgzr874IVnkhsDb1u8j96TyLvfF3LTqn4HZCdip9p6Fa55vq8HNCj0a1OlwEJQrUYzzMaCIH9McUqG3hBe1nLQQxqr81lbhBiSeVbIhOoXyWbji4OlgmPoSPLv0E2Vw5NGrDHFGQ+MTzD4uEuzo52KWkFzZLVf6Hr7ykMU4H49+qTeKfifWnueg/6TkiYPCflx9danRZR1PSif1AZMEr1TrxC0UopeMkH3CZFZULZLsG0jhMlMztBTmYDIag2KU7Bp5h8L+79uDNuO6oI+HyGPwEyOhDQMs1uVgHKhs1ckNKubEGiIQrsPUu4UJ5+nxTonc8Bg4fgGOIYc7vTcnlbORMzc4Fdmt7TthpWM86J4KRiosfFgpeZLpizmywk+6kUu3BFT7QVvJFGbWCAKpzwJKKsaX4j+k1HZXXT6yG3IhQb3xxSybekhKDlaNUJmNMIIM2Th6JAAzOnOu/7jCTszfKDmDTNDcgkgsSvOcU+Ow7cMIxflWgacNj+f9EaDFREAgTdZwiw6BTUUjeWpMOaoi8eH/U8Ob1pjygQM8xetupoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c3239b-adde-45f0-df6c-08df0cf7036a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:45:17.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moluviDGT03ge0QpSbMKgOfab9IXCu1O3OB0h4sO63tOfLNHX6aQnVr8IBQMRciIFVQ2Gwrmi7yRHWCJSBR5VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_04,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2609070175
X-Proofpoint-GUID: rLxT-nfi-nntjFsklydqIwfaSeRLeCfS
X-Proofpoint-ORIG-GUID: rLxT-nfi-nntjFsklydqIwfaSeRLeCfS
X-Authority-Analysis: v=2.4 cv=R94z39RX c=1 sm=1 tr=0 ts=6a9edc49 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=pGLkceISAAAA:8
 a=GC8tDegO99WLP5Imjj0A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12109
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE3NCBTYWx0ZWRfXyKZ2SThVtzRc
 XQRt5KREyJmhkbu6fDKJuwfOIutJ3G5uMzUGFGYHRksiF3vSVibHBrQAT+QG628GXwO1Opeq5NY
 kyIQYvfIggKjJ9fkvmWT/NXRc/epzlLHnnw+ZELEe/f50KwT4xXzwbHGpkkV6eHF8UylfbrbSka
 AIvMt3tg9b/koobivmTkETOhqGdGoTNLirBGaeV2fgU/TAvckaR1iixE+eMF8Zsvpp1xsJ/G3gJ
 5Htaa07uI94rSNKUwI2Axgzr9m6wkWBk5DVRq+RVYgY2Xy25YP+cYL8NMa58haw1SqKOm5eGLeP
 4vK5l/9Y6mt8vpc3/MoYjsXkiyKR1Oi3yQXQIy9tdDK+FhQeV6w7kapI2VL1cvY+v9XYwwrpa5l
 Lz/p2g8BJO07Zy3dF2kCYoEDhxfn96cOeFFQZ9F2pVGE2Hg5140cz6+7Lut4p+XnTRh51tmk0d+
 iByXr4EB4nJFNxwfSUZlEaqIhMMaShmCKn+D6ZZk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE3NCBTYWx0ZWRfX2MJ/f94oQgFs
 TnDc1kVlvmRq2znIU0Jb5fZEkdZb0GeKoE4az19veXXd4I6kXua26148+yjsZymInnTeWmFe136
 ys+3yMUolqkL8bSEHRj0KfUAc2bhjvtmhBWn/uMPssxl3PoSrq2U

On 07/09/2026 14:10, Mingpei CAO wrote:
> Exercise recursive array comparison with different and identical
> element definitions. Check that distinct containers remain separate
> and identical types are deduplicated, including their references.
> 
> The negative case fails before the fix and passes afterwards.
> The positive case passes both before and after the fix.
> 
> Assisted-by: LLM
> Signed-off-by: Mingpei CAO <caomingpei@gmail.com>

this test would be better placed in prog_tests/btf.c I think where there
are a number of other BTF dedup tests; something like the following
is roughly equivalent to what you have:

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 67b9015cbd98..1c4a46e2a64d 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -7062,6 +7062,94 @@ static struct btf_dedup_test dedup_tests[] = {
                BTF_STR_SEC("\0int\0long int"),
        },
 },
+{
+       .descr = "dedup: array element comparison",
+       .input = {
+               .raw_types = {
+                       /* signed int */
+                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4),
 /* [1] */
+                       /* unsigned int */
+                       BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),             
        /* [2] */
+                       /* signed int[1] */
+                       BTF_TYPE_ARRAY_ENC(1, 1, 1),                            
        /* [3] */
+                       /* duplicate signed int[1] */
+                       BTF_TYPE_ARRAY_ENC(1, 1, 1),                                    /* [4] */
+                       /* unsigned int[1] */
+                       BTF_TYPE_ARRAY_ENC(2, 2, 1),                                    /* [5] */
+                       /* struct s { signed int a[1]; signed int b[1]; } */
+                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),                              /* [6] */
+                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
+                       /* struct s { signed int a[1]; unsigned int b[1]; } */
+                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),                              /* [7] */
+                       BTF_MEMBER_ENC(NAME_NTH(4), 4, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(5), 5, 32),
+                       BTF_END_RAW,
+               },
+               BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
+       },
+       .expect = {
+               .raw_types = {
+                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+                       BTF_TYPE_INT_ENC(NAME_NTH(2), 0, 0, 32, 4),                     /* [2] */
+                       BTF_TYPE_ARRAY_ENC(1, 1, 1),                                    /* [3] */
+                       BTF_TYPE_ARRAY_ENC(2, 2, 1),                                    /* [4] */
+                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),                              /* [5] */
+                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(5), 3, 32),
+                       BTF_STRUCT_ENC(NAME_NTH(3), 2, 8),                              /* [6] */
+                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(5), 4, 32),
+                       BTF_END_RAW,
+               },
+               BTF_STR_SEC("\0int\0unsigned int\0s\0a\0b"),
+       },
+},
+{
+       .descr = "dedup: identical array element comparison",
+       .input = {
+               .raw_types = {
+                       /* int */
+                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+                       /* struct container { struct elem first[1]; struct elem second[1]; } */
+                       BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),                              /* [2] */
+                       BTF_MEMBER_ENC(NAME_NTH(3), 3, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 32),
+                       /* struct elem[1] */
+                       BTF_TYPE_ARRAY_ENC(4, 1, 1),                                    /* [3] */
+                       /* struct elem { int x; } */
+                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),                              /* [4] */
+                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+                       /* duplicate struct container */
+                       BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),                              /* [5] */
+                       BTF_MEMBER_ENC(NAME_NTH(3), 6, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(4), 7, 32),
+                       /* duplicate struct elem[1] */
+                       BTF_TYPE_ARRAY_ENC(8, 1, 1),                                    /* [6] */
+                       BTF_TYPE_ARRAY_ENC(9, 1, 1),                                    /* [7] */
+                       /* duplicate struct elem */
+                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),                              /* [8] */
+                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),                              /* [9] */
+                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+                       BTF_END_RAW,
+               },
+               BTF_STR_SEC("\0int\0container\0first\0second\0elem\0x"),
+       },
+       .expect = {
+               .raw_types = {
+                       BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, 32, 4), /* [1] */
+                       BTF_STRUCT_ENC(NAME_NTH(2), 2, 8),                              /* [2] */
+                       BTF_MEMBER_ENC(NAME_NTH(3), 3, 0),
+                       BTF_MEMBER_ENC(NAME_NTH(4), 3, 32),
+                       BTF_TYPE_ARRAY_ENC(4, 1, 1),                                    /* [3] */
+                       BTF_STRUCT_ENC(NAME_NTH(5), 1, 4),                              /* [4] */
+                       BTF_MEMBER_ENC(NAME_NTH(6), 1, 0),
+                       BTF_END_RAW,
+               },
+               BTF_STR_SEC("\0int\0container\0first\0second\0elem\0x"),
+       },
+},
 {
        .descr = "dedup: struct example #1",
        /*

> ---
>  .../selftests/bpf/prog_tests/btf_dedup.c      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_dedup.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dedup.c b/tools/testing/selftests/bpf/prog_tests/btf_dedup.c
> new file mode 100644
> index 000000000000..3e889c0bed53
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dedup.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_helpers.h"
> +
> +static void test_array_element_types(bool identical)
> +{
> +	struct btf *btf;
> +
> +	btf = btf__new_empty();
> +	if (!ASSERT_OK_PTR(btf, "btf_new"))
> +		return;
> +
> +	/*
> +	 * Comparing the first fields maps array [3] to [6]. The second
> +	 * fields reuse [3], requiring an identical-type check of [6]/[7].
> +	 * Place container [5] before its elements [8]/[9] so they still
> +	 * have distinct IDs when their definitions are compared.
> +	 */
> +	if (!ASSERT_EQ(btf__add_int(btf, "int", 4, BTF_INT_SIGNED), 1, "int") ||
> +	    !ASSERT_EQ(btf__add_struct(btf, "container", 8), 2, "container1") ||
> +	    !ASSERT_OK(btf__add_field(btf, "first", 3, 0, 0), "first1") ||
> +	    !ASSERT_OK(btf__add_field(btf, "second", 3, 32, 0), "second1") ||
> +	    !ASSERT_EQ(btf__add_array(btf, 1, 4, 1), 3, "array1") ||
> +	    !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 4, "elem1") ||
> +	    !ASSERT_OK(btf__add_field(btf, "x", 1, 0, 0), "elem1_field") ||
> +	    !ASSERT_EQ(btf__add_struct(btf, "container", 8), 5, "container2") ||
> +	    !ASSERT_OK(btf__add_field(btf, "first", 6, 0, 0), "first2") ||
> +	    !ASSERT_OK(btf__add_field(btf, "second", 7, 32, 0), "second2") ||
> +	    !ASSERT_EQ(btf__add_array(btf, 1, 8, 1), 6, "array2") ||
> +	    !ASSERT_EQ(btf__add_array(btf, 1, 9, 1), 7, "array3") ||
> +	    !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 8, "elem2") ||
> +	    !ASSERT_OK(btf__add_field(btf, "x", 1, 0, 0), "elem2_field") ||
> +	    !ASSERT_EQ(btf__add_struct(btf, "elem", 4), 9, "elem3") ||
> +	    !ASSERT_OK(btf__add_field(btf, identical ? "x" : "y", 1, 0, 0), "elem3_field"))
> +		goto out;
> +
> +	if (!ASSERT_OK(btf__dedup(btf, NULL), "dedup"))
> +		goto out;
> +
> +	/* Identical elements leave only the first four expected types. */
> +	btf_validate_raw(btf, identical ? 4 : 7, (const char *[]) {
> +		"[1] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED",
> +		"[2] STRUCT 'container' size=8 vlen=2\n"
> +		"\t'first' type_id=3 bits_offset=0\n"
> +		"\t'second' type_id=3 bits_offset=32",
> +		"[3] ARRAY '(anon)' type_id=4 index_type_id=1 nr_elems=1",
> +		"[4] STRUCT 'elem' size=4 vlen=1\n"
> +		"\t'x' type_id=1 bits_offset=0",
> +		"[5] STRUCT 'container' size=8 vlen=2\n"
> +		"\t'first' type_id=3 bits_offset=0\n"
> +		"\t'second' type_id=6 bits_offset=32",
> +		"[6] ARRAY '(anon)' type_id=7 index_type_id=1 nr_elems=1",
> +		"[7] STRUCT 'elem' size=4 vlen=1\n"
> +		"\t'y' type_id=1 bits_offset=0",
> +	});
> +
> +out:
> +	btf__free(btf);
> +}
> +
> +void test_btf_dedup(void)
> +{
> +	if (test__start_subtest("array_different_element_types"))
> +		test_array_element_types(false);
> +	if (test__start_subtest("array_identical_element_types"))
> +		test_array_element_types(true);
> +}

