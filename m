Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2E344C518;
	Wed, 16 Sep 2026 07:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789544070; cv=fail; b=jJ2qt4nuQ5JKo3scp2FjDo63q5Fb7jB0HwNZOSjkhw0jFJSuMTn9Z0kEogp1V1745uToupixA0ZPzJiVl0r1p+EW+R8Av+LJLRMKsint/YEgphNdAJ9sF4WU/LMsNC+TA2vK6wf7GiO+aJ1pTOacUQ0oCZ9MCoIEZw77ZUdy9hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789544070; c=relaxed/simple;
	bh=g4t8tWezjTMABtFTvbAEnW2GJFp95z7L0Iv0NbrDFbU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IVSCb4XNtIJ1SpdpbUixERAdF2quXRMJBqLmaCdGFbhuBQWpErHJQ6KY8BHY1BjfZQDnjC0oxvqahU0nkg2zFsPLP8XwL3bDetlCHSVFcaLvrjLaQu5sI7LdfN+s6VQT7M2GzX5snlvLhCq0rKWdEQOOsj2vALklLIWMbrsI+TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CU/K6fTH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UhdGUxej; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CU/K6fTH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UhdGUxej"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLWdvV622953;
	Wed, 16 Sep 2026 07:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3DoWV72EX1fGnefEYSWP4MRYPQ7jNOVdTtso1OWnh6o=; b=
	CU/K6fTHTpu0KsU7AtXChKGhVVq/R9MdA195vqTKv6R1n0mSpd5ZdTKROBTGD5mT
	FlZNXxExkLe3xs0TNs/ktm8tOMmJTEhmuZ0kqRA8WqdZUbzxc5VrVkI1cjro+aPp
	ECnYSIcC0ieLklwrjFp2VocX8szUpt01d8Y+aBkj/849eB8ytdJp8xRo2wZZsrz7
	pEDgs4swizgN5Df3vV1hXbJx29JFy9oecrS0f9eJFo8R82dKU1NaT+Du5NjVAavi
	kvoEILqqhIgpQMKick9g8JqJlHD/WNyxCC6btjexij4P1bJ4LiZdeYL0soNXD4BV
	1NdtlJ634wWQEyVbhh0vog==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmwh1n4g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 07:33:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68G7VDcx037721;
	Wed, 16 Sep 2026 07:33:52 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013035.outbound.protection.outlook.com [40.107.201.35])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6q1ngc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:33:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IeJ8DaMNlGRIk0ftSDPfB13sGH7P03lzsI68RxevHjuYkGLdE54xOtkyf8f6FAS9TX8RGOk3vo6hqinwlhz4LvjHH2YI5Zy1yySwEU4E6RvQBS5YBVoJXlFd7ffgeyjJLEFo4kcSm6Wf94y3jQTtNkxE4sOt0Yy42d+8B1NbWn0T7A89sbEUfqmhax/exbYuDQlqFo5NmOyf1RWzyNIfwNsmDc5PlqnDWo4X6nK0iSl7wLAVy8ZwfNLdppryCnETpx4z4vSX9viVl/d3H1cx8cBzGL5XRj0wCYrFhBn9DaRlHg/b1gKWTufJauhKaDzcynZl+nnmytVij2c98fxvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DoWV72EX1fGnefEYSWP4MRYPQ7jNOVdTtso1OWnh6o=;
 b=x0HCYme5sN01CfRPY1fcr58rsrTtxX8bsohRZVETrKtesabx4Hg6T7pqpzFF3JYVTJypC+xI1BqS74dOnc42IdGEw4zNrdv7vCthM0bEi7YulCLukV5czF9BhyZoYftNeE4qm3aUIxHaJCNYkQEdyAYUo889yiQjGnqk+dN4g1P8C6xNdYEGJj3L/qWuVoboibw0NXq+T3kTmSgh937TCuQZIKnEMquAPcZAijJBj9qPAdu+6RT4eRihHWeD6o4m3hSdG4YQibs/jGRzX09utz7X0FseCKjcOf+Inq9F0v4nPPIFDugkHbPkpW65xOC4v4C8QfL4h4dGaen/XZIMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DoWV72EX1fGnefEYSWP4MRYPQ7jNOVdTtso1OWnh6o=;
 b=UhdGUxejvg+VgeJsgsM27FUxyLCBduHE4IWfpgB9McESKsEy2nD0gXKFB8fYR86CgRdS43DjtL3CCQd2y5Ijvc0y+zvhGRNsLNrrVfctzpx5+0w9xCKrNzhv54KozbLuQPVLBlpcJQHwtO4uryke4VVcytJniIyMCk+ObJypCNc=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CHAPR10MB997697.namprd10.prod.outlook.com (2603:10b6:610:2f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 07:33:47 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 07:33:47 +0000
Message-ID: <bd56c5cb-fe35-4ce6-91b1-d83fad7c422f@oracle.com>
Date: Wed, 16 Sep 2026 08:33:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 03/18] libbpf: Support moving permuted BTF
 types into split BTF
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, jolsa@kernel.org, ihor.solodrai@linux.dev,
        yonghong.song@linux.dev, song@kernel.org, qmo@kernel.org,
        martin.lau@linux.dev, memxor@gmail.com, emil@etsalapatis.com,
        mcgrof@kernel.org, petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org,
        bpf@vger.kernel.org, nathan@kernel.org, nsc@kernel.org, arnd@arndb.de,
        puranjay@kernel.org, yatsenko@meta.com, atenart@kernel.org,
        ojeda@kernel.org, linux-modules@vger.kernel.org
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-4-alan.maguire@oracle.com>
 <98c9c5838b50871b3a138d2104450774268644b3.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <98c9c5838b50871b3a138d2104450774268644b3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CHAPR10MB997697:EE_
X-MS-Office365-Filtering-Correlation-Id: 4300e263-175d-4231-1c04-08df13c4d813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	7GUJsPusIq3DXVyhccM5+RH/M0qch08aO0gpzhy/4XadQagHddTvjnuaPNhv7W2e4gT4wY5A+zAvJkEJMoRI6qItzAu1pCmpkn5vVIxusOs+kc6GAEsvIWTj6+dLQ83eaKxbkekiVcjSRHBd8uObD1APuzsGrtFQYZcVqdxlktdMNoPUdj/KPJL91OVJloLe9kolios+BsZI4OsbAIsL1Q3gu7Hhm3RTUcWqY6njAt86yvKHLD0yz441mBxzE760jI+x3FR4HKLas858fzZrkjBFwIrc1smRplPiC7Seumljbn1AH0V7AE0uwsBuL+jS/oZpsFoEftJLsPPWG3v+zK4ELoE/7FiD9uDRqH1fPYUSTg5arrZZFmIt2uu027kUMZ2lL3Lq0Qsia90EryxoueBOpvAX3b/cw64K4Jfy7V/3pGBZsdCH845OqFXZx6Xt1AvaDcNED6fvLUymXAgMzRE27aQnonUwBX0jgOaOkZPyHr98Su5VnvPeVSyqwNHnbJ3sKfZAwy7o83sDaYsS6za8mOy6PbBY2pmo0uQ/QXSXEX5oICSxXKe2sCqEyeQEh7nTdjbmQaMvWGBVAFGDxffCpzPB5vJHmCZWZC9sauMTAMquiK7YwOoLm4koGlvHRuBQQ/3jvSqkQwKwu5ekGHNdclsL+iqE/RDDFzS1K7I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjh2c2t3TTFHRk5xWmtQcmloeDBUd1JUeDN0dmlmb3JaZklXbnh2WXBoQ3FE?=
 =?utf-8?B?Mi94Slh5cURFTDNXUW1wRFJzS0N0cFh3dlNubk9CV24vdzBjQ2VvYlkxelg5?=
 =?utf-8?B?NnNENXA4STloWWlEVmQvbE1Bb1U5Yllubm9WZGJXK0ZxRVBGV29xTmJ0ZjhP?=
 =?utf-8?B?NUFFTkIxcm9OMmhOMEpndWZyejVWU1Y5OE8zRVFuQkpNdmxVckdYUHR3QjFN?=
 =?utf-8?B?aHQ3bHY5OEZ5aXFBSUI0eE1hbVJvLzZEd3JjalhDbXdEakJNd1g2c2FFaDFh?=
 =?utf-8?B?NkNJd1N0a0RMVzd2WFJaTnVqbFR1NG85TU0zdFlxeWdDUHpjaGxzV2J4NGxv?=
 =?utf-8?B?c0huQkJPNjM3eS9kL3JXcHBjWG1HN3pnenBQTEtrU3NGQ0dRQUJuN0ZEVVAz?=
 =?utf-8?B?NDhCS05JYTJtcEZ4MlRoc1hWRTZOVlBsNFpTYUNRdXNwYkdyakhIYkkxYkR1?=
 =?utf-8?B?OHdlUVNZblh6cXc2V2xmS2xmTEFuZVl5YTBJOUxKdmFzYUNsVStjejJidlA3?=
 =?utf-8?B?ZW9YNXZmVWVOU1FBdXhOTUJoaUdWUnBBTWM2V2I4T2pEY1hqb2xEVno0RXpy?=
 =?utf-8?B?eitSQzdDV1gyWnNPbFdVWWxESlk3djBNU05PbTZITGl4N2dZSXNvT3E0S0wv?=
 =?utf-8?B?Z01vY2I0ZmN2akpXT3hiK01QKzBxcHQ4UVF6VXlZSU40bDZQUXExZmJMaHRx?=
 =?utf-8?B?TGlRMlFMSE1VK0RmNVZINnpQbEhsREpNUjRCOXAxSHpGUDdrZnFraGdkVG9u?=
 =?utf-8?B?TlFHN0xVS25pZmFSYzJuYjFuTEl1ZVh6cmxUa0tsSUFEUVZESlhveVZJd1pj?=
 =?utf-8?B?TElsc1FWOGdDVENDeXAzNDBteHFXbVBKRzQ1RlNiMk82aUIyS2lQeitjM0Qr?=
 =?utf-8?B?MjdQSkZDT1QyZURiVEhUSGdSRTJBU3ppbjNMUzB4TXVTZzkzMHROekxyL0JS?=
 =?utf-8?B?cXI3OG4yL1ZJWGdWMWRNZmF0WTlObFhPQUZGMGtmWUpjZFdyd2dOaXZtRkg4?=
 =?utf-8?B?a1NSRGNaMTNLekZTR2ZReUVQQUVOQ1hYanZxVjd2MWRhYy9Pdk1sUlJ0Y2NC?=
 =?utf-8?B?VVpmNnFnN25uR3NDeVErZDFwNWpsa0FNb0Qvd0FpcGJ4WEhadlBsek1jZlo1?=
 =?utf-8?B?Z3gxMExKM244cHV2Z1RVTmxYQUY5cEFTbzUxVWFOMmtBQ2E3cG1iNjYxYmZv?=
 =?utf-8?B?bzFpZlFiT1JhRjQ4LzRXOTRFeERpUjdHWDBHUHJ2Nm5wa1ZwRmthTXBwaFll?=
 =?utf-8?B?eTd4WjQ3cG5Rc0JQK0wwUkhxRC9LcTh5VWFCcGF4QlNweVdRWm1oUXNkKy9V?=
 =?utf-8?B?eG15SE96aEdYbEdjVFBUZFVZUlhEcHFJRUxMcnF2Tnk3ZVY1eUtuMGxYNUM2?=
 =?utf-8?B?S2N2dTlsT1B6d3hRd1grRVA1SUZOVzNmOU4rUmtDdWZYWWV4K3ZRK3E5ZXEy?=
 =?utf-8?B?TEZrOENRYTZCckt4ZjVDOVNhcGhtM2pQZGtNSkVNdWVydDZ2RlM2aktKREdv?=
 =?utf-8?B?bzVDanFkZ1gzSnhBN0dmUndnaTFtV2JnNU5IQy9KR3VuSUZhdnlJdWNZbmY2?=
 =?utf-8?B?MndMRm5pdThQNHR6TlRqRTVHeE5yc3huWWdGREZGUmRML05idU5MOWpMbWhl?=
 =?utf-8?B?bHN2MWdRM1NyUWF2alVnZHZoQlB3TEp2Q3g1MDlENFFRYnZpaGhHN3FtWS9H?=
 =?utf-8?B?N0xyQW0yM1YyVXozTHFOZmJQUVFVMTV1UTNqMjQxUU5xb2dDUENqQ1ltM1J6?=
 =?utf-8?B?OWtJcGp4SXJjclZrVmVYTC9HeFFpL3RlelAvdjU0VnNFUnpXRmd3cmxhbk5L?=
 =?utf-8?B?RUVqNGJKNHNkRkR0VTlIelJIWjNwWWJ1V1oyZUQybTFVN0h6TERQSFNwRWV1?=
 =?utf-8?B?M2YzcmdxY0ZZVk4xY2FuNkNXV2h6ZG9YR2F3SjFqcjMxdGJhYkxSU2NRY3g0?=
 =?utf-8?B?TzhiWXRPVjdWbXpYZHpOdEtMVEp4L3pVTC92ZUJBNmZWV0g4dG5RUGU3dFl3?=
 =?utf-8?B?ZGNudHhqS0VYTVdINkhmTDg0UFBkZHpzVXptQUo2UVoyTUIydFhlUTVEVzJu?=
 =?utf-8?B?NEdkTWFOY05uaXpKTzRHQ1RUUGhvb2dkcXlyN3g5YnRUNEFQdFUzeGhGRU1U?=
 =?utf-8?B?U1RuUVA4VnBVcjZLT1JrRUY4Y1NZVHExelNKRzJTR0luQXZOMENxZnE5YjBS?=
 =?utf-8?B?WHNLQVNLdHREMEZqcmdkY2Y5WXl1ZFV3NFN0TW9lUmVLeWg2U0d5cmpKWnp6?=
 =?utf-8?B?ZkorbWpWejBmYTA3ZXlNRW91WCt4UVhBMy9RWHZqclllVEFvOUlkeVozK2k4?=
 =?utf-8?B?WDlNNlZIcFo5VU9kLzFlMXB5N0RSTzJMaTFjN041ZmlWZGVvNjBnZz09?=
X-Exchange-RoutingPolicyChecked:
	jPlnLDe4tRwKnwh+SJfxG+SMSdRCp9WvWJHsAA7egZqRqyYEJjOWrEILh3ACUOjcpIrwiwjC9krtaxVLOBDFGxWn33F2+m7ZptVL4gIszphDdjbq7ZPMGTSMiFhR4DY2H52QToMpZkPQdjW6+hb1ZTKeTacaKSXTZR0YUwBeKX19/RmVf0LQwp8XQ1JI4a7NhBsJRqTfBofQmbbXmQDfH4fME2OInMFzUkjEdFcv0iMwH8UFdhm7elUTSf29qxedys54JVoQEh81dkzJmgYGI6FwmYrkIReaQkCbu6gW/sJuYTDtFKOUZLJPruhaRP11zBOqKYqrG7TGncqq4HCeuw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zgGWjufjSC5TcmJaW2l9xTVnzcqypyB+KgepryOeUkFWFVosT2Uiho5Qr67EpZT1GsyFF5HmqnVpZJG3HfS8B7cWPLWB0gjwKGgrdYdzzOaynPNvftSIWtoU9AAZgX8+w2lDAHccZij8r6YwJG6/u98ITHDf2m+jZ8nUH/IwSZ5jwvM9MF0mgMtVN90ZSf+GQf2buoAcDDNUkFeqXnBqQCe+4LoRsy5M7WwzULNtj0JLMRBzcgWBbZMOEjkRPlxLVvVBmx9BrrVmOH2BqxJRhbox99peZuZsbBsRtXnj25pu67L4i8IoQcUsTMNDLG8aem9SRpD+ar+vKum4pXTCn0sd7K+Ts2BeXe3poecJS3uK4uj4iRcGEf58tFuh90gthPZGT1EjSqVMeXNAUHISpBmE0b8bIUvNx8TtAc/Vj7y8mD5Q8oDTZC/weWyFMgoGVusJKixb65lhueAY74pCP+ts7Nlz9xmZVUeSh2KUUYb6UOk2AJNAmwbTT4Kv4xsuYJlKudb4xRIWl4EVsAUmUX0D3XC2ADtMgw4eZ5klolQboYimsWWXZgGEKilSwaQoYUjn72JNAvTXMObvvE513WUbk0VrTp8xcYT+8LimfTg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4300e263-175d-4231-1c04-08df13c4d813
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 07:33:47.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Avndg7W8RH9Yc5aWgw1oRqt31nD5rq1b2CtI+ENB4XbA7c7rjAWzQRUeybm9rqEwqRvWPhh3+pfmToEnKhPHxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2609040000
 definitions=main-2609160096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDA5NyBTYWx0ZWRfX0fNU6KMSBmSm
 yEXrtz/IShPTqNvoiYUAl9QArj4hm+33qcdsrkpkdYTiqFvMzIJqP0B9qIe0MlUKKmVyHk0FJIh
 WauHyiivZ2xx1RW4dieX+w9e/KMUdwCbvXEwiL1zlz2OCpULp9Z/mrqZNYsJfAilxu/ZByRma/K
 RnN3Ubd0bBCF30lZ2tZ9OlheaexskSQihnXtWwNUcwA6oQX8L8kXTXBTMr+OWdQJE64VtbzUUrH
 ymcJqSvpOdw890wV+ZHiOFu3vCqzO5DCY1j0kdjJi4mXgnaNJTCxr64cxAweo/UckdVM4+hDXoo
 akNUm3pH4mfyyD3eMmcOF2XBDwpRgWrF3tyDad6DfU2rkuItn+Wrk+YIfHJJyIB7K9tyDSMOW6O
 C8aVW7ieNqjM0G0pbnWnBtCvOjBeKDSFwBXh0CksiXUwJoEvglaL0jmgSScLI3pqHUSnVD3Gkub
 0hw4quMlP0Pl/nW/mcYY5xy/qYFor1y8iTZOPrk0=
X-Proofpoint-ORIG-GUID: MNkxU1JKI0TfFmfCRAmswsjjtkf1bnFB
X-Proofpoint-GUID: MNkxU1JKI0TfFmfCRAmswsjjtkf1bnFB
X-Authority-Analysis: v=2.4 cv=HPhWhYtv c=1 sm=1 tr=0 ts=6aaa4661 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=NEAV23lmAAAA:8
 a=yPCof4ZbAAAA:8 a=NgNP-luukT9tZliAkbsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:12107
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDA5NyBTYWx0ZWRfX2xPRseWE0x5X
 lEUC16qemJwSzw9elOUqZs3oFn7FcILfZvw/K5fOGg3sOwkTkgo9vJOZBB2iLgDrt/0DiiP2cEn
 LjT5NuA7bQ7iMIMKHQku4QLyAhEOChTHci/4zcbzeKLYDc6kmBcP

On 10/09/2026 10:37, Eduard Zingerman wrote:
> On Tue, 2026-09-01 at 17:57 +0100, Alan Maguire wrote:
>> Extend btf__permute() with an optional transfer mode.  Type-map entries
>> marked with BTF_PERMUTE_ID_TRANSFER are removed from the input BTF and
>> copied into a newly-created split BTF returned through
>> btf_permute_opts.transfer_btf.
>> 
>> While moving types, remap type IDs for both retained and transferred
>> types, preserving split-BTF references to the parent BTF where needed.
>> 
>> String handling has to be done carefully as we do not want to have
>> strings that only exist in the split BTF to impose a cost on the base.
>> Copy referenced strings locally first, compact the parent string table
>> after the moved types are gone, rebase split-string offsets, and compact
>> the split string table.  This leaves strings exclusively needed by moved
>> types in the split BTF while retaining shared strings in the parent.
>> This will be important later for function names of inline-only functions;
>> these should not take up space in base BTF but should have strings in
>> inline BTF only.
>> 
>> This all provides the support needed to place inline-only BTF
>> in a separate BTF section, which resolve_btfids will use later.
>> 
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> Assisted-by: Codex (GPT-5)
>> ---
> 
> Hi Alan,
> 
> What do you think about an alternative approach to permute and
> resolve_btfids changes described below?
> 
> Instead of specifying a permute mapping can just rebuild two BTFs from
> scratch: base BTF w/o LOC types and .BTF.inline BTF with LOC types only.
> This would give strings dedup / compaction for free and would not
> require further changes in libbpf.
> 
> Concretely, commit [1] (branch [2]) uses the following steps:
> - Traverse all types reachable from LOC_PARAM, LOC_PROTO, LOCSEC
>   entries and mark them as having LOC color.
> - Traverse all types reachable from the remaining types
>   and mark them as having MAIN or SHARED colors.
> - Create a new base BTF object and copy all MAIN/SHARED types there.
> - Create a new .BTF.inline object with base set to the new base BTF
>   object, and copy all LOC types there.
> 
> This seem to be on par with your current branch with regards to
> speed / memory usage:
> 
> │ Version                 │ Elapsed, mean ± SEM │ Peak RSS, mean │
> ├─────────────────────────┼─────────────────────┼────────────────┤
> │ Original permute        │ 338.8 ± 8.1 ms      │ 71.20 MiB      │
> │ Proposed                │ 284.1 ± 10.2 ms     │ 70.10 MiB      │
> 
> But seems a tad simpler in terms of implementation (~ -250 lines of code).
> 
> I also changed how LOC-only FUNC objects are identified, by using a
> generic type graph traversal utility function (btf_mark_reachable()).
> This is a bit less code and opens a possibility to move some more
> types to .BTF.inline:
> 
> │ Section     │ Before (bytes) │ After          │ Change   │
> ├─────────────┼────────────────┼────────────────┼──────────┤
> │ .BTF        │ 5,207,078      │ 5,047,510      │ −159,568 │
> │ .BTF.inline │ 9,867,471      │ 10,027,039     │ +159,568 │
> 
> This is the same change, but when allowed to move regular types from
> base to .BTF.inline, if those types are not used by base.
> 
> [1] https://github.com/eddyz87/bpf/commit/abe515962632ad51f8aa50e44354b88f80bbd606
> [2] https://github.com/eddyz87/bpf/tree/resolve-btf-ids-btf-inline
>     (tests commit is 100% slop, please ignore it).
> 

Thanks for doing this Eduard, it looks like a really neat solution! The permutation
approach - which is really a permute and a segmentation - felt a bit clunky and
doesn't feel like it belongs in libbpf really (it's a very specific problem).

I'll play around with this a bit more, and with your permission maybe we could
include it in the kbuild inline series? (I'm splitting up the work into the
libbpf/kernel location support needed for pahole, and a followup to add the
location info)

Thanks again!

Alan 

