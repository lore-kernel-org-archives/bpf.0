Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85E425872
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633715; cv=fail; b=m8ywGhz+O2hDNxyb52Z4U/lpGDzi8G2G01ZhZynqzHzmfqx5QLY2C2K8Fef1RzfkVBq9HfpOP2Q6s5xt5ya90ZYWy5FYwxpEgEXBOu/qeCSOGQbisMlKLKwyqt3koHho8YvVWASVjTSAxI7gGJuSQKl85vvYMkRdoB4laGcpvIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633715; c=relaxed/simple;
	bh=NpST0nEPZ6vHW6ilre9Kt4xTqKQOw1kusJtdu/nRNac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jt+gDHna3LkhS1tkUPRvqjMIgJD8LR47JtOw3Cw4FkfJlCdNMvRv1Sz/O+hVPxrhEr/RlFH3jaA3gIeMZ76JYDn2K9aOfC+3OUqbuZBFLRzL7Q1bru8BoZILSN7ZjV1J84tB5p+VC+2Us8uBg+Vg9IOdWhB2O0b+YpZFVdotPTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GzCGFjf1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aRrq1wyG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GzCGFjf1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aRrq1wyG"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GM1twc385895;
	Thu, 17 Sep 2026 08:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=g1ZEc9JD1ru9KmhA3db/XNvwmWl056CCLoO80+6sFnU=; b=
	GzCGFjf1UXUlHiiRYWtT86aSNfWX/QYVjuJMA6FrCt2e9sFhq41e7tBbFez3TXFY
	tEdwzDeYlqOxaiX39u3dQendE4ZZbirt4QRvxZtOrgRCYBI4mAe/dfkzrmZvepl1
	TdqhPzSI1u76Ni4TWW3Z+89cmi6o7YBR2Xmva5WIyEOsfwNih/PhetFwA+RG9MiN
	CgB2sSAiaGqMfuScmQrVclc90H3BXjKXzRfq8qZM0bO9Kydigkpf1eJyAfwmL1GV
	r4tkI0na5htHTGxBAa9Pf8gSSd0m+c6dpZbZRhO8Hbzg8rlNbO9o/mdCvfqC2DOk
	nVM/g8+EDReQSuPvll1raQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxsbq3fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 08:27:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68H8PScc018553;
	Thu, 17 Sep 2026 08:27:56 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6rk5wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 08:27:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM0ywYIovXQnL65xasP6C4JkWXi/bFkFVBdQ1RpyX5scSHXXza/vVWQjDF0MGhI1UtCvpguhYQ2eO4nesjVdn+7DEbtexJCfrtcLicqP2KOHm2LaBcqQQH+ofYbzH0MoNWjLv7p7oKvsSGP48B6IwnJjuA5O5Yii/NK3PCEk97SGswGD2f3ezdAFGNw1WqIdcP63T0I3CF0q1EUyQ3VmODXuRFer5B2YsRXLTYQKZnDKCCVrrmu4shxigGiKGhgiqtFkr3NgqIzXQajwWXXkq0EiQQS27+P580+NvF2v1uYBLEaDb8Edf3FYEspxESRViho4FXc4pJrukrzSo7gwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1ZEc9JD1ru9KmhA3db/XNvwmWl056CCLoO80+6sFnU=;
 b=LJNq/L/n3G5DhL+C56US9/BSVHHMDWO+vZerB8peqLAyXV3p+PokbIhZy6GzPdoNe1phmP4FD516tCVRwNXPdG4zR8UaN240bAjLUrz7z1LYiRDCyyj36bByl/0cerRMMHBvSTqYbrjVhZD2080nmf5Lp8YypWbc4MhgKkFhPfedxsa3JcEJF4rfJvOUji5wyzCjQDu+tydh68iodGwDnFSphlcgonea7uiMDq/IuWRMEpb9SgBOn79zNz+qSM7xF13BnQ0f5/CQfIiSFFi2ksAozQHRknxvJ6AfrvdDHkU7/jABGIfKk6JWgYCq5CytzpBA5PBZC1PgpYWwamB8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1ZEc9JD1ru9KmhA3db/XNvwmWl056CCLoO80+6sFnU=;
 b=aRrq1wyGfbZjNtXUS795M+iS4yQ9Mu+qK2P7ZXI+UuxiSf3u+B1TgfGaBrPdbQJciOmlqiPJmL0cCOskZJMTK/igHB9m0mf+e8dBwxVR8tmcimoGRNCAczb81IYwQaEL5LZo0ACBWHvjdKCDcweIa+xOqj2UpcR4gV1CZvsB9qg=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by SJ0PR10MB6303.namprd10.prod.outlook.com (2603:10b6:a03:477::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Thu, 17 Sep
 2026 08:27:52 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 08:27:50 +0000
Message-ID: <0db440b3-f39c-41ee-bc77-4e3d2ef2b95a@oracle.com>
Date: Thu, 17 Sep 2026 09:27:42 +0100
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
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aqsTCF4uGmN5SlZD@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::14) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|SJ0PR10MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: ece2af1d-5873-4d5f-2d3f-08df14958fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|4143699003|6133799003|56012099006|18002099003|22082099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	NVpdjxCmuJkbLZLL3UiuJ4gl6cKv8uHv4g6efavCLgx8jPZK1Fks1r+dAtaLncisX19asNa65Ribff1PT/QwVG4PSqPrB4zGwANgCk4GHrzy2jokjuhUFszWw0M6hjluVAajzR/NqpfpHwvNcoTfmU9ENBBYAd0x+5w2gN4rJeP0kz/m7knl2c12+Gw3N6DN+GQsAPGSQTJY9KE3Zw+vvkXx8bMfKm8Na1qkfmiObQRNgW2Oik4vpriTlYb08t4Lzpe63ggLynmSZAFMnbLgZUA2Kkm3X2ShqsiMxnGcBJPihS8sYZaRFI3Yqfe0yRhUvB1OTTRwjCHv+mcqPYlLYvOm4qBWaM+Pva7LwtfqB4hFHgCMevY9LQFZduZMhx6wL0r6LMQsvDCt6Sv++8EvwZO7UzOoI2Ql7p5912WMJvWwDkFjjo1L7IM3PZ6qU+bAfNDhYHGrx8CQwvGJ1dtVBDbX53b+X0Ipxc1IDqyCRfaDH3/RL6wTzfwk/adNAauXyuNkVKou3H7qwBXDwUdD3CfRLpdv7AXeaYLkgz/7kappEsxzzmbIwwtWLNX3jI1VkhZWbvXvUll+w7Arfchenbfil5cvLGns3kAw2lts0JOnYi2VV9MtIdGXBdBPx9zo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elN6NkpOY3VwVm1KRWRZclVVZlFlS2M4RTJOL2VORTl5K0plb3NNM2IwRVBD?=
 =?utf-8?B?S0JIbit2UWtHWDZtNmdjSU9DSTk5UkpZbjFCZHpYVExueGlXN0pzMUovUGZB?=
 =?utf-8?B?aDVvQXVsT0FsTWpsbFkzZHRXazFraHUvbm9YOE9hZHFsSXErbWk1c0Jwdk8v?=
 =?utf-8?B?MnVNTEFHSUVJQnoyL1Rqejk4Nkl5LzFIaXQ3c09rOWN4Z2lkK1hmZURXQVFW?=
 =?utf-8?B?ekJLV1RJb01BMjAyVURwU0plMHNHd0Z1QlNYOHBibGJjSXFFMi9keWFxSkM0?=
 =?utf-8?B?cDkvbWF0ZWN4RWVNNjNXaVBsdTF6alZqWDRqMGRMeUJSRlBVMFRzYitqUEgr?=
 =?utf-8?B?emNyWVlhSGFSZkpibjdtY3dFQmlZVDUrRkJhS3BlWjMvM3ZlY01FeUdRZXc4?=
 =?utf-8?B?Q2RPQU1pTkFPMk9KY2pDKzlnQzJRU2J1NDNHTkZ1TEZ4L05nYldKeGh1dlhE?=
 =?utf-8?B?MDhhZjUxaFdabTA4V2xZSTNPSlp5VTM3dVBRRVd5TWRuQlg1UDA4WG9jLzhU?=
 =?utf-8?B?Z0lFdjZ2eFA2cGEyR3NNSzF4dUdqMnZPS0c5TWtsdE9Kdi9YREJ0S2ttYldK?=
 =?utf-8?B?OUZ6SnRzUFpHT2J5dUp1N1RGekV2bU1EOW1za2ZTVytxWVZHRnVQaVlTMW9p?=
 =?utf-8?B?em5mc0pONTZJa0VlOC9VSEZMd2IyNUFwWFkzbnhrS1dhRzRKYjlEOXRyNnEz?=
 =?utf-8?B?NUE3dlRGSjB2OW9KRFk2enhhSXpFSUVXTTNkKzZSYWFTWFMrajJPZWpQNGdS?=
 =?utf-8?B?bDRXc1NmQmZNd3Y3d1RJQ0ZSdkUwbWV6T1JXMG9JWkhGa3ZJZHhOT1YvZktv?=
 =?utf-8?B?bVQrL0ZuY0ZjVXI4Q24zZzI1S3ZwMU5CU0ZnOEVTbXlocVo4cEN6dHluV2di?=
 =?utf-8?B?Q0ZqVU1ERk9HRjVMc2ZCOE5paVNYU0ZOcURhbnVrNVlia29GdDE4VEFWS0FX?=
 =?utf-8?B?RE43ZG05eFJCN2VJcEY2QkN5OTdhVEwvSTBwY2FUZ25ZNVJJWDFaQ2tIbWRY?=
 =?utf-8?B?ZWtwSjFsY0dEbWxaaWhwNXJWQzM1NTZlSlpVZXNNVFU4Y25zaFNqdmI2RmFY?=
 =?utf-8?B?a3lOQ215WTB3bW84YUE1NGM4OUVjSFFNVk54RXlaM0JvUklhYkpOSVV5eDB1?=
 =?utf-8?B?bTYraGFORFVYend5cVo2azN1dFBzM1ZGbGxKOWsxb2wzUW41UkM4cnRkc3BJ?=
 =?utf-8?B?b2htR1JnbXRMV2hRS01kcys3TThhZTEreklmNVVuZktBN1A5cE9sYUhJSENv?=
 =?utf-8?B?Z1A5VHBreFFhUFlERGZ1dVR5b0szM0YzMkNEUXU4NzZ4WndZcUVaWGw2dXRJ?=
 =?utf-8?B?Mm9TK056QVNHS2h5c3dnM0lmV1ZvM1cycURpWExzcCsyZVArT0wzclptQ0xD?=
 =?utf-8?B?N2cxNmRKZXY5RUtHSWRFYld3N0t2eURuL0ZhMENNK2NsY2lxdzMvcTlaWlVq?=
 =?utf-8?B?Q051ZklHd3NtNzlNQjBtdnk0U1BBc0pFZ0lNWXcvVUxwRnczT0MrT1FDUjBN?=
 =?utf-8?B?ZW1RanBhM2hNL1lENTQ5KzY3NWJscXQ5eHpEa0p1U3JXeU5oV3JIMVlLeEt5?=
 =?utf-8?B?TVBpZmZRajFaclZZMldvZUd4dzI1cGpvSTJaNzlJWXBYVm9rRTZGYTljTWRn?=
 =?utf-8?B?b3NFK25NMituV2hLd01PWkFrMEY1T2h0d2RqNCs4ZkJWblBSWE5wQzlJYzV6?=
 =?utf-8?B?OGw1bWJySEFDZi91Slc5b1RERmdGRE1VMkZ2Qk15NnpKcmdPc0I0YStTOEJK?=
 =?utf-8?B?dG9FL1FyQ3dLZVFZSElHUGUwQjRBbVIxdmJ4VnVqbzlybVNrdUt2eVV3Z1Aw?=
 =?utf-8?B?NkV6ZkRKSXZITm9IODhTclF0T3NTeXZFY1FkSGMrQ0dyWnJ2emNYYkM3RmRO?=
 =?utf-8?B?T3BFVW1tcXFGRVVHZ2pFZlhIaGlmTlhWdjlhaFdMNVdWMDdtMjdXY1Q4M1pP?=
 =?utf-8?B?Y2VBZm5ERFFnUlNKeDdhWjZoS0RZT2xWWVlqUVN1VnA3ZCtNdENRU24xNmNB?=
 =?utf-8?B?NVIyQWtVQjdLMmJFd2xTMDFUWlp0dFJSTG0rcTE2bm1NalM0M1Y2QS9KL1hw?=
 =?utf-8?B?RStYRlV5cWhKY1JIc2JqejU1MjNDZHpMbFpkNllFeGlIeEVyNExDNWtXVlFF?=
 =?utf-8?B?VVkvZnRELzFoR0JSQnp5TWFQMHl4dmUyaTB3OEtRV281cEM4TjNBczlDUVlD?=
 =?utf-8?B?eHRzU3dYWWJxYUxHQ1RnTjVSY2s5VVNJL1hWTFpGZ3M3Um5rRXZ6RlVXbW0w?=
 =?utf-8?B?SldmSkNFLzFid2o4SEVMOEM4SjQyclNiK1VtNlkvbmVaSlZPUlZxazMvUFJx?=
 =?utf-8?B?RFIybDBsc0NnZVdJMGp6UGU4aHN3TWVQSWxtYmdGeVh2OCtPdm9uQT09?=
X-Exchange-RoutingPolicyChecked:
	2tnW26VHXZw8ehq+NevePv5y42AFBTSYjfzzL1o581oFvCGyml722SOeV+Y/kx/fGTeRKQUr/63H9X/mqWqt0wu4/kDMAhBiuIbxtfLSgDKHqKqD+plq6xOk+82BcF8mvt7oUO+6mgFB6QayBeqPmiFGnZLY/dR31Eak/pa1dCyw95mlKcXOrxyE30X6RJEjIwuoug6fSCOq9Yi93LpJtfw2mHrxPj+dj76MHhhlglEjmHMV9V8SyhJSRIyPcDBiFecIXwQF75cI36AmRKhpwoZCzwq+lFCcIUR7ITgfJmnjKv8yNU04Z8agyS7oEg8cA84PzZ1sMKMVq8IUu1VMoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BYfYpjAwE4Kiw7y7BfW3lgTSXC89dHmDwe1/+8hZr8DdXZ5YgUS0dZa5BAgi7bpXiV561CZ4e9cvA+LdN6wX12IWU7EQLduGqNSKPG5a/2p2C2Pv7gLXNWDk/GLWdG1qz864U5tiD4TdfefwhPc4O9NFvNe78XVj9Rrmzv7Wpw5DE0l0wm2CWhm1DaHtcHC97ifsas9tq4tW8IVLeU+J3Ld5QJOHytQZiD7oB+y6dZE1I5qo66HOaB+pvHLTd0CW41CRKvh3WxYq5GQqISqu4vXD4oBz423cuFcDmCQMgOnqe4c9HH4K21KWQfHSUehu6REFdRxIq+J5KpwKrvAOwvEFk3RsmSoy7vX0/x+hu88KlEhZKjCfRUVpuGO3Ldsquai8DV/9IxDoImkd1kiC/t4Ot3L+jpV7BhZH0rkGr2PshRKz58qwNdj1Y2rOLtrYR1AB4ijOxxRHs4T56svuhV117KFyX+oOXO3TDM0ySde68swqS55UWJoGoLiHU6YokXSJ6/EC/BdAg1Xr1bbt4FmaekRPGfhz+4/R9GW5p5TVCMYMmGcCtedUrYsI1qLA0J2hnzQzPY4eSzbgqQmL6kZ4ZOuJMWY8Spym81aqFhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece2af1d-5873-4d5f-2d3f-08df14958fbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:27:50.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oayAKhtmkmroUGbwsKP/braAFdaNowApOBze8r3AuvsNj2vw0iLOPY5Y4eCGz5exAw6NDZwSbkMc04k9fYMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2609040000
 definitions=main-2609170114
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX3j78+TkIgcO5
 Y4nlQqL17cKSiWMPcnDCMAqwJF9qmWH5NZqJJ7Z36A5lXg4Ums02jKWUbO839BRyczGgUYSNhUF
 69Wejo4CtfTSIxULf0JLje+3r62wg/xMmd+zV6Qt6LjAeg51Rt+8BWMze3u2SYPNmyAiPlktB0c
 zzZkafsXqtRS1fcIfZu/H0+VG8JjkMORba34wGgcU5rV7dQlzwcY5QsZiyKyVQjgoCCkHvgnCTO
 0tQNh+IFHxGWVNKv8pskODcrl4GFgNWW0o/s6CipnbhCFizsPrW66Rf5cRmIQW9BH9T7DcTyD4t
 nfB57OmNGwVRBLPsuZCqR0UWr1PdZwxFaYoRjnGDLJe+SkYjZ8tlgnCKnm7N6cAFzeJSDaZ1duj
 LaGV73IPS45Yz4DXyTCtkmq2fGn2bu644w0sktQPLv78a0l8ORwyea64xZuHCrQXW6Z9yfsfUdW
 WAl9hsCdh8gXTWRqYBG9AVhLKnMvDai563sE7Fdc=
X-Proofpoint-GUID: Q6lDHHN40SQCYpMkz768XcNZlduJQJ72
X-Authority-Analysis: v=2.4 cv=dY0VTnXe c=1 sm=1 tr=0 ts=6aaba48d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22 a=El_hQXKkAAAA:20
 a=JeRbiGu04pyzA2JmygEA:9 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: Q6lDHHN40SQCYpMkz768XcNZlduJQJ72
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNSBTYWx0ZWRfX1uCeVjrkM4l/
 TqsoWNXeG8R4RrN8081+uvEZQrAmiXTXcabXqVdCfKKgOhFLmr6QbHaFM9k/gBQVhImvP9XY+qH
 VZq+ZT4PfZumsvDOxOG5rSG5m8IWYAI0Qz3roAeM73tWciNfALl+



On 16/09/2026 23:07, Jiri Olsa wrote:
> 
> On Wed, Sep 16, 2026 at 08:41:16AM +0100, Alan Maguire wrote:
>> In raw mode ensure we can dump new BTF kinds in normal/json format.
>> BTF_KIND_LOC_PARAMs are rendered as strings, for example a
>> const value of 0x2a and a dereference of r10 + 0x20:
>> 
>>   [12] LOC_PARAM '(anon)' size=4 flags=0x2 vlen=1 values='0x2a'
>>   [13] LOC_PARAM '(anon)' size=8 flags=0x38 vlen=2 values='*(r10 + 0x20)'
>> 
>> LOC_PROTOs render the associated values of each of their
>> LOC_PARAMs for easier readability:
>> 
>>   [14] LOC_PROTO '(anon)' vlen=2
>>   	type_id=12 value='r1'
>>   	type_id=13 value='*(r2 + 0x10)'
> 
> nit, AFAICT these are dwarf's registers numbers? could we output arch's register names?
>

thanks for taking a look Jiri! You're right they are DWARF register numbers alright;
the problem is to render them as arch register names we'd need to maintain per-arch
tables in bpftool, which seems like the wrong place to host those. I'd suggest instead
we augment pfunct [1] to support this; it already has an option to display inline expansions
from DWARF, so having a BTF-based expansion of inline sites there seems like it would
be a more natural fit, what do you think? Thanks!

Alan

[1] https://github.com/acmel/dwarves/blob/master/man-pages/pfunct.1

 
> jirka
> 

