Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A392126C03
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870473; cv=fail; b=X8FnGXc6hlkzfqC9gB6Sq5HnzBy09iCxFOG5fEg2yo/URyAtsa17ibSUya2gjaH6gevU6qTMTrpSDx5z/4gHggRL1uixqmpkAikCYJZ1+9prDl8WMmb9ZKHjBoYMyxBKWNMVs6E74y+2FgYM/sr8598t6Fb++d/0VCxSAu6H8Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870473; c=relaxed/simple;
	bh=r7MiG899zTECmronyeIPpFXnIPU0NJSIVdc0VQpWcto=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XYJpXl8wlPZ760ElAWjyn2Fd242IJ1r2FRLB/ftoEOWTNlWcDp+s9yqR71KCDo/NSV2kdAC/la2bln9ddAxWYcHqvujy97KEPGe6KaBNjzO4nbDlh01S8HZtIxjjpJW5GjkuDN6PaXMzw9oAjbpDmcU4avCn+UdgHZq70wghUJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aCYgkMLp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tEiPI+mC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aCYgkMLp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tEiPI+mC"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M8ZSr7055606;
	Wed, 22 Apr 2026 15:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WkaYzasQFPAGgVeusd/KP75QBR2XCN5+g/XNFDeUxVM=; b=
	aCYgkMLpzWIRbnzICy0qRoVFhwyFZWkpXpv6sd8qbM+7rQjjxQTfmTyDtv2E4TGT
	Xu8eCKcvUS32YhAwjY/KtaOAoFyXL/jCK2MfZMRIjlG/jEGdNLWhbliX2ywvY5cj
	xWo8erBMpIfDVScp2IfaZXzo7NGOptu4rZQouunVxmiUNF3Nl2iNVxNoxmX83pCC
	i/E2jkcCpn2g/SFRlDfJcl7xdziVbGIC3YE17OPjH46ogI/Sad27/Kvzc4hlC5QT
	bPxsANPlB9qZ/1SwIQZ4l6QC2rKkMi0C7i0ZOLacZlpdz7AfmjMC/6F+SZBEXMMC
	bplWuRJ+/gHq925jxOOzlQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dpenm1mpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 15:07:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63MF69aS029755;
	Wed, 22 Apr 2026 15:07:31 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012045.outbound.protection.outlook.com [40.93.195.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dpjjema0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 15:07:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dS1dtM8ZfZASLtAF8svcJboJnguCq00IVcEm4IrPKy5rVVHXYJP9Y2Np613H2eMZipsJLbEShP3lKCSXWN0jHOepEvApPEol3TCllF+UIy0motCMUs6SFbRHmxDAFRwsiS/dorDYN97dEIhKh+3axraLQR1lSDE72HqFEu+fCw0IHcqfzgi10iZIjpAXZL3qVWVTe8yOYIh3t4fi3ooqQxguZKGB/HwsyCzx+55/phiwFLvqqZDUnGW57/Xjp7SBqPUB5yFIZrr/4ZRc9PQvZisYg/dkiKM+8u2lFbWIL0w0FPRjThNpPUqZK8ummgl0u2QVM+D4qcS4e24ryIXysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkaYzasQFPAGgVeusd/KP75QBR2XCN5+g/XNFDeUxVM=;
 b=FXn/HSMSuJvN873KjCUbeEDt8rJoontlXL48IoR9Q0g3Dd42l/t3t90eKvRAIWRKI9jZawiCWUG46DV7irPMWmXh6sjDNxZAwv7NpqdfKz4wzddFhsnqUr2TE6Aw0nrUo1CrfDweNRjZnkLOWiQLe9vLjNpBc5xehGlhcsABZp+7jmmHjn4dE8hinr4xiELX7zsVMyBmPrHw5Kcs7NvGq/wC2bSHl8/keklALJQDiVsalGtDY3INo8PxgqTTDILYRGRWvfUutL2wCnAO49tRjLOH+/BDagpu/aihMGtOlMwpvPdQfiCNb+Bw4OMpStefl4DPT+rndP/h9EFkwgEHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkaYzasQFPAGgVeusd/KP75QBR2XCN5+g/XNFDeUxVM=;
 b=tEiPI+mCQ7TBgkEeZ0sAmIfPxDg2rHV5zJY/H5TiyXjU+9JArlm9Y1NqznMhPZLtNWpKHfM4hvRh+6bnD07bHEjMKBMfsL3sJs4pcO5GmSvdRvTF/hJI3ElesQeob1gWlQF+Nl8u/Ozz74Ad5/q6yZZOI3XH0NqjiWDbkvjhloY=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 15:07:26 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%3]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 15:07:26 +0000
Message-ID: <f2b3e9c5-c896-45d6-bcda-58c9634f61ab@oracle.com>
Date: Wed, 22 Apr 2026 16:07:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: Fix type size overflow in
 btf_type_size_unknown
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, andrii@kernel.org,
        ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, memxor@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        bpf@vger.kernel.org, sashiko <sashiko-bot@kernel.org>
References: <20260422103206.533695-1-alan.maguire@oracle.com>
 <c2e8527a-0cae-47a5-8c43-2ae2c08bc1ab@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <c2e8527a-0cae-47a5-8c43-2ae2c08bc1ab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0382.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::20) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e52c940-f0bd-4cc8-b42b-08dea080d90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4UNDteC8HAc0a5NNMawhRTIQ/HFkpVbdgv0bXYmVXqGzaXzSrw+++quecGz5NPypoFS1boHYOUduDcY8gkSQyKc42yQ6+30HsPrG9KLOxGflTgxQAdBAfkI3LcAYNhLWGCz9liekVfMwuyBeDqjN9LJRAtmsnAXn9LAYmc9S37gdjRZwHwiiIV7IuR2AgwwzSaFWjh0HR5DwMChKxrjGkLzgYtr9igHBz7qVSlgFS0XP6NlnKVtrB5gW7JuK2XwtzsNuJ5TU5yk4/Vm8/9XvgrMNV4OkI7WIhcdtY0fDeoZZq+lQ9Z2nl2xEOfLR+sZt5tjhK+00yl7JOY21fTnuCUSdPP2lEK2hcIlHH64amSH5HQhHwCwmB99sF8C75LWDgJxknQ/DNkSzqdiDzCjFYmvwyTy+5LLymwIPVwKU1gvk9ysA9KPoK77SPdTsV5t1zHW7Q9DG4S8ecPj/ZlwSSaVKZhWxN+Uqvc5YrS9VuGYSdOazvowEcw5foCUEiPn2/A58NcOpiPoDxEIzpfOnxlTNX80+uCHHTsUCJ8QRrfCYCC63b+aM89kDBlUR1PdQa64Yg4U3itwsH+icuFOuHsSPvhDO12Prd9s0ls7HLm6RSYaGIm1oAYQ0KpWwRphhuNiv2Zt5MRwtCf1KAdIIr/y2cpJE/xSAjdHx6Lyq3U3rxuqWY2RXur760Bey+D1RSS9hM8cQtCI18dcsYppzFERq306mIfNKcki35sG3sRfnmeSQ9hCYlAUr9844LoFV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WStkMWExSnFMTGtJbVZ1dWpISktHWDNaOUM5ZDRHY3hkYm43dExRYXY2dmN6?=
 =?utf-8?B?ZmVtSWtJMnRKZHlxM3pwbnREQ1o3VnNXL1RGdXVGQzQzYVlmRUN1REU5ZUVG?=
 =?utf-8?B?bTlKZDRIRGNONkpTYitjeEU2ckt6R3RRMy8rTGovMW5zck8vY3MwUnBua0ht?=
 =?utf-8?B?Y2IwbitEbzBucmdkQmZYVE9LQWFsR2pMY1lpTlVscjZicVFqVndGdWxuamFl?=
 =?utf-8?B?TWFGckw4eDFnOFh2UUtFVzh0bHJUME1ZdHdDZkpuRFN4ZDBuejU0djJOTGpi?=
 =?utf-8?B?QjJiS0h1bzRabTBrQ0FMY01GSHZ2MEJXN3FCUTdmOGhCaWZMSXh5NWNCWUFu?=
 =?utf-8?B?dkNSQWNmZmdmcWhKeE5EMjdSVVFsNzRmUXVaM09TdXJ0dzVCbk5qU3FuT2w4?=
 =?utf-8?B?d0hYaTUxRzhuU1JIOGdSODJwL0xHVm5SVklOWWwzdHd3dTg2ZkIwR2Jhc2pk?=
 =?utf-8?B?VmQ1RmxCR041Y3RUb3gxOGRnSVZKRGJ2aE03U0R6SGE1c1E2bXIxWTcycUc2?=
 =?utf-8?B?c2srZVcvMjZ6MzRSNC81TGVZcHdxeFdCMEdQV1JtRVpoSFJjczVQSjdmREdW?=
 =?utf-8?B?U0IyZWdFLzY4SDcrZ1l3dXhJM1l3NXNzUk9RTllLKzRzTmlybGdyVnpTdXlN?=
 =?utf-8?B?Zkp3WWdjbFBLK1lpbVhFVVFvUHRGQVdFQmhjbGNTUzUvb3RzMGVwV0Z6RklF?=
 =?utf-8?B?NnFLNmczQUhEVzdWbWN1QXdRUDlNUjg0b3liTGh5djBmV2Y4bW5GWWM2TlNV?=
 =?utf-8?B?VXBZMWVaOGhKZmV1TWtDY3laOC9sdWpFODZHOEF0T21HL1F6OEhHVE1ibEUv?=
 =?utf-8?B?TUhOSnZtN0hyOS84UC9ySmVVVGI5MnlMdUNSUGtrNzZaYm1COXpQOW50ZUMx?=
 =?utf-8?B?UVhQNzBvMDdqbDR6c1BjSjVUcjczeFFhRWxDM2VDYVk0UEhrQ1Rya0lOdjNK?=
 =?utf-8?B?c2Nqd3dtakVZaC9rU1pndGk1aDJKd1dKSG1IdHhud3dwM3gzS0w4VUVuNmxm?=
 =?utf-8?B?cE52cUxhZUdGcjRaTUY3UGJ3SjgwRmZpVmtSaDU0YS8zRzdaZDFxc3lUM3o0?=
 =?utf-8?B?RkphMytlWEMva2ZpaUFOMDJVVS94b3B4R2RhZWxGTFRkNERud2M0SXZOVkkv?=
 =?utf-8?B?b1cvN3hXQVc0NFhYaFNVTkJuTXdyL0VsT21TZ0RFSDMzVGVEVUhxWG9QSXZa?=
 =?utf-8?B?QlZKUWkyMDNvYXNRVk5kdG1HS0hJK3plUC8xeEt2a0RKRnJSdDFPb3h3V2tT?=
 =?utf-8?B?emRwdk5tM2VKNVYvU3c1ZUIvOGYrc010L0FiTXVYNisxbkFxYlZFWXVuS0l0?=
 =?utf-8?B?YU5iSjJKcnNLRWdZUXd3allrck1KRWJ0Nnc1OVI5RFdhaXlPZDYrOGM1NFIw?=
 =?utf-8?B?eENYVFRVWStXZTV0UC9lUU5aalIrUzlrcXRvbHZYSjlMR1czZFRyMDQ0NWlT?=
 =?utf-8?B?R1MrS3JaWC9YUzJDUVF0MUkwMzdRV20zTElYOUpndjdQNHBwZmFTTlRtMEJI?=
 =?utf-8?B?THNBVlZVMzI5b1pzOU5tZU9adnJjajVoRkFMT0dvR1BvdisvN1BNb01PRmI2?=
 =?utf-8?B?dVdkTmZwV0Z1RjJVWTE1T3J2T3Nud0VmTkJ5d2dNcG1jYVJscVBsQUJ2VGt1?=
 =?utf-8?B?MjZEVXJhMUsySlBLNlFUTXFSTVI4ZnRhR0l6OVhVV21NakMwWFRBKzhmdkVI?=
 =?utf-8?B?U3NlTHl4VnBKOFB2eXg2ekxvK3U3anZUblBGdVYzRTFwZ1IyTUhXRjArd1Ju?=
 =?utf-8?B?b2ZNaXhLZEkyOGFDVzArY0QyUjRmOXM3cHZVRE5CRFFDU2FUbGt1OFM3NE5t?=
 =?utf-8?B?Nm1VVGdmeWlDODI4c2ZFUnh2RUhmSi9MbkNTL1REMlF6U2ZsOWdjSWIxS2I2?=
 =?utf-8?B?Y2JFK0ozWlFuWEJOSkMvK3hNN2psZGlOVXk1ZHZJT2J5UXIvb1YxSTNjSSs5?=
 =?utf-8?B?YW5lQU1zK3paZDQ1VUMxRUpvNExSZ0V0NksxdzdWUHg5L0FYYzZkYXNOeUF4?=
 =?utf-8?B?c3JWR3BYYjFaMG10ZHVwREJXamJCT2dvYTRhUjFRV0NUOWd1OVRsT2hzV3ZO?=
 =?utf-8?B?QnRwYVJqTHNoOVhoQ2J0UHBEaGNUQ09ZWEpkMEllb0ROeXFmb1FiS2xmTTdU?=
 =?utf-8?B?MWdmbnd5SHBLRFdzZUhnL3p6VlVURnk4RFU5YmVDZnFqSm9OT1c1aGlpT0Z1?=
 =?utf-8?B?TWlyaGVzeHB5RXdkb09Weno4SWJjaDRlb2pSQ01ueFJmM3dXaFZuY01YWnli?=
 =?utf-8?B?NnRTYVh4WUFvWkxzZzdWNFN3cGoxUTZ3VDUxZzJBUTViQWppa3FXQlpZclBy?=
 =?utf-8?B?bUFjOFphNUsraS9LQU55WkdxSllkbldXVWFveW9Ka1Z4aitpNFUvUT09?=
X-Exchange-RoutingPolicyChecked:
	DleEhf4TnAVMxBod+v279+WnZerAK8nPhs9f+U0mFMMWR6O20rxzWV3jKfvP6xaOSwQufDRoyw/o9X92876TzhnH4aDTLPY5OZCD/uJs92U4LTrAICLJXtX8btwqpSEgV4WaspiEgzHyCauTFBS+bJ1hhbkbpaL7KT1i0nwkc++9xpH7cR3I0TQza9vjY3k3U0KrlNhp5L0WtYEYHYyndZy4t2gBfVYvyQgv6EzbQm4u+DuMMyPlqFL6Kwzp1IKoJF7p1vnxQsOOwUY7V7n+jYzJ9r6MGFJw503icKeCppMZYiItGrmUaZLEt6tLT5IjB77Mwjd6C1AOiwPaYJ/XOQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wePF2TrTpAj8tQ1QoC0IjjLrNLHggVPSe2AYu0FSZgoSIutj06LuD6vNOoOTBrQjlNgYGs6CF4DB8pgx6xk3dJzVluNuKeThczaji+y7w+p4lBx7+7kNipRwRrFO4dpVhmylPly7Az38lQE9+++fsRbChz03EpfYuZ/n2Rmua1P+IOlS0XyBGVqsyh1QJhqBnFPZpLC073iqb2cAITWDxkCSx8lPbieLuQ5LUxE/EZMNZeuIgDYWewOWQrxc1HC+WUEtfACJ+z2B1Ho+kjXl9ZE/+XybGb1XdtcWatTWUq8Lh3AuE4BnVq6TgNLAdQB0YazVWGyVJCSf50d+hSgafFD4YB3wUjnVC+L50E3aZkJZJHtLO0JZ7bHGRjAcxEFXN3fmvtucOyYZVTFwEZExlo79qcZ28j/chq2/0obPPXKRJJl1wJNPTz86eZy/CexL430SwO6TrLIzq3e+DV/sDcgajvevB8g4YzpwfO6b60KPMtTj40Knum6/ueigJf5O8PkDTAwadt8r79q0Lm0x2YwB7YCRyhDAKXh+TMgX0bmHQ1q0NqYgVjdRsZ2u6SdSoKI8KktDFaXjnbMZ4dRGQmAEfw52M6UVGCTUthkIZeU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e52c940-f0bd-4cc8-b42b-08dea080d90c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:07:26.2618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oxCozfc4Z5N01C+RSxmLeRBWmP8eEok/LxrZ8i6a5B5tE4yyh5T5HgiqOfY+OMFLuV+Kdp8ekJPADDFX3Y4hEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2604220146
X-Authority-Analysis: v=2.4 cv=FNUrAeos c=1 sm=1 tr=0 ts=69e8e434 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=4GBpODnjKXUChwH1eUIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE0NiBTYWx0ZWRfX32dU6Gond1Oz
 uJBQsPw01zRl/RAf9X9wkotYmkSCB1hYeiQT8KOPB1Rw8DBQjK3rINJuuQd2xDZTXqTpS5Fg16x
 rXHJk+UgQ07Hn9fiF3KpAFiipywUhoTIN0rb+O4e25qQr7bLqZmGQ2y9tBLb62u/wL7O6bYw0ob
 EnOtydM7Q/++ye1d+QdWF7QXSQk5J/oCRE5lw0KZZqLgeX85NHmUVLpAXjoIVZNQfQFpp0ilM0X
 S6XXpU3rA5k9+xSmYlxxooz5kf6PWBvrO++sciZs0vg/ePhPxWJSZxO9GF8lEqOzXlsFrhGwE2K
 UjKDCfgQ82x7zzwCpsVSWSGflORdAYwgj7kvIFuRvurFf4aVAGZLUGwLeopUxshYzbojDoEsWQn
 wIRn7S3VCtcD1oI+wapiBNhVT7LQIB6gjkGt61a0Ox6Rd702zdXfb2V1vOCU2Ur1DT/R0tg8rRq
 oaK/GdRkAoH8Gwna++w==
X-Proofpoint-GUID: X3eZupfQHZ7uIEiHHaU7wmtKRkpAZ1qQ
X-Proofpoint-ORIG-GUID: X3eZupfQHZ7uIEiHHaU7wmtKRkpAZ1qQ

On 22/04/2026 15:19, Mykyta Yatsenko wrote:
> On 4/22/26 11:32 AM, Alan Maguire wrote:
>> A layout section with a large elem_sz/vlen can lead to a 32-bit
>> overflow in btf_parse_type_sec() at the point where a large
>> type_size is added to the next_type [1]; a sufficiently large type_size
>> on a 32-bit system could lead to the bounds check
>>
>>     if (next_type + type_size > end_type)
>>
>> not triggering (since next_type + type_size wraps to a value low
>> in the 32-bit address space).  This would lead to a bad value for
>> next_type when we add the type size.  Avoid this by ensuring that
>> the type_size we return from btf_type_size_unknown() falls within
>> the range of <current type, end_type>.
>>
>> [1] https://lore.kernel.org/bpf/20260417170712.74E77C19425@smtp.kernel.org/
>>
>> Reported-by: sashiko <sashiko-bot@kernel.org>
>> Fixes: 2ecbe53e0e991 ("libbpf: Use layout to compute an unknown kind size")
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> Beginner question: how does targeting bpf tree helps libbpf patch, it's not available unless we sync to github and release a new libbpf version, isn't it?
> I would rebase this on bpf-next: it does not apply cleanly on bpf-next and dealing with conflicts for this change does not sound amazing.
> 

Sure, happy to do this if it makes things easier. In this case the bug did exist prior to
the vlen expansion work, but only for a short period of time. As I understand it bpf fixes
are resynced regularly with bpf-next, but that does require merging. In this case the merge should
be straightforward I think, but if maintainers would prefer a bpf-next-targeted patch I'll do that
instead. Thanks!

>>   tools/lib/bpf/btf.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index ceb57b46a878..d48ac5460d1d 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -420,9 +420,11 @@ static int btf_parse_layout_sec(struct btf *btf)
>>   static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t)
>>   {
>>       __u32 l_cnt = btf->hdr.layout_len / sizeof(struct btf_layout);
>> +    const void *end_type = btf->types_data + btf->hdr.type_len;
>>       struct btf_layout *l = btf->layout;
>>       __u16 vlen = btf_vlen(t);
>>       __u32 kind = btf_kind(t);
>> +    int type_size;
>>         /* Fall back to base BTF if needed as they share layout information */
>>       if (!l) {
>> @@ -448,7 +450,13 @@ static int btf_type_size_unknown(const struct btf *btf, const struct btf_type *t
>>           return -EINVAL;
>>       }
>>   -    return sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
>> +    type_size = sizeof(struct btf_type) + l[kind].info_sz + vlen * l[kind].elem_sz;
>> +    if ((size_t)type_size > (size_t)(end_type - (const void *)t)) {
>> +        pr_debug("Overflow in type size %d for kind %u\n",
>> +             type_size, kind);
>> +        return -EINVAL;
>> +    }
>> +    return type_size;
>>   }
>>     static int btf_type_size(const struct btf *btf, const struct btf_type *t)
> 

