Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CD3DCD85
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231775; cv=fail; b=rpkUSRIDWu9rVjZJBtGDSGfzuROcvuboehBqQ6cYa8EMTjhiS4Fop4re3Xt08pMiEBDOs73JfofYPS/pGCY023RYFTK8L0aLm7B4QUYTLIMdqtCZhk5n+Maefolx3OW+UGFN60V4dmtcntt/nYfBosni9eWPjbUTRaKq0hz9IuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231775; c=relaxed/simple;
	bh=MAfgZ1unHMe1Jh2G1mfOLCScyF8gxjBCjpdP0A6qPWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u0z99dT11epYBXWh1cRMmXzrx8vhO97nr+NuWLEaYAMYF8NSyaqiYUZdFyJliI1CTeCZbTWHRAVbw6yMVXnIvQgBajPV2p8g4XGsNn70dNh6B8PZMie26+xgs3Ke1VFkzbsZN+9V1pcfOdqP33faVA8JePWq/+gGgE3SDsWA6+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BYcQAoY+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IiRGrh+7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BYcQAoY+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IiRGrh+7"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62B8rhfp2641631;
	Wed, 11 Mar 2026 12:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LA1v20alPMahWaQ+7oLa9rlGd21u51p2rxXV3Q0YjJM=; b=
	BYcQAoY+3VZluIa0jsxV3tet4Y4Y17hl66IRf/S5SDGkhGlUugXD0+5peWWy6F5D
	AKD1GntQBOlBiEY22391QwNlSYBmxZiA36GTCv6NYARxFKJ1WD7tkEmmsgLuVLjF
	hyWSmtBRaU66dUXdzxPJFdgM+Ay4zWap4oYG+CioshrC8+blrB/sa5jAc5+9/q8J
	m5rlt5Mi2t6vQpxyozwIYtzV5ZVZWtOfRTXLDH8JReniufG/HLKqgCf9AQ+ccypT
	8YDzNSH+1B3pZStlags5z8gPxRrJIvMEUoSJ2F+By1Kpg6B7u/DU5F22XbsNiy9/
	Jl/mMr/1Y8zERhGZIs0Z5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu58x0958-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 12:22:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62BBqg8C020591;
	Wed, 11 Mar 2026 12:22:17 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4craffg0b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 12:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8CIWu9hltkXvtwjyLIR094Cq1/ODi/ZqMIu3iMh2bcyQPXft/nzKy/hRWbl6dg4LSWLjuOj/uqNIULbinAq99FuiT6PhHxh9uLpvfBEGwZZ/7mE+LYGo8kSC+Et1/6lFg4wNZdPHnPKiU7dTjrnju066BLTHEObfx1CLMLUwcQWjMkSEhk586tFFxJrn5LRMnRHRbn0Zkfx8xlHSS7OAS8Hv1Axy3RrEDRp0Z4n67b1oVbWTlTt1r1bF9G/0DXo2k2ZwtQYU3onZpnxThXbSJlWn2BWZvXNoqb3TrRz+3ChC85LfnsNPO99Jgaqrky6yIRiwmWcu/hUyAgPfJHWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LA1v20alPMahWaQ+7oLa9rlGd21u51p2rxXV3Q0YjJM=;
 b=c2Cna+t10htwYQ28K6TuwwAP+i3AD4+GsFnl54GJZ5qAdPnIqyhv+z2KGV8BMSu1V3CxwwFdE7AA4DGgkIIkZFcthvBeKtJ1ClfAMctVCToSE6MfM1hg1po1N7IvjM7vtzugLtQY1diuScuKl784UAZZ4UCM7ElQXFCJhDpNAAxaCrfda3UY+UzUs/pjQ36aA7ZH8sshGmz8tX5m2Feyw6YYGiwEF/gN9wsN5qGYXCjVW44bVRXaA6PzCSkqZVesgDERAKkg2go7j2ZspSIUrLkEfHuyOCycgGnU/wFvpTVqEYLh9D1+G6ZgS1sypels4vJKrfVvxdHFYybf7hoaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LA1v20alPMahWaQ+7oLa9rlGd21u51p2rxXV3Q0YjJM=;
 b=IiRGrh+7xSXi4S5tVJ5myxdJPxTJds8iiVFze3zpFdhZ3pfbKcSoDUMhrbUy/sSs19pyXk5vBxQ6+X4Ur2uM0vZBmMY0TfKAm2s6k34+LINk27akT+8Mi7yiwHZnsAY6dP803K3Jyap3PwE2s5yGHfdruhltZmF9V2deTURrrbk=
Received: from CY5PR10MB6261.namprd10.prod.outlook.com (2603:10b6:930:43::22)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:22:14 +0000
Received: from CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884]) by CY5PR10MB6261.namprd10.prod.outlook.com
 ([fe80::f46a:ffe2:b67f:7884%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:22:13 +0000
Message-ID: <c04a0697-393d-41ec-ba2b-6b90f66097ae@oracle.com>
Date: Wed, 11 Mar 2026 12:21:59 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Gregory Bell <grbell@redhat.com>,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
References: <cover.1773170190.git.grbell@redhat.com>
 <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com>
 <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
 <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com>
 <CAMB2axMTkN5R3+JQL-2L0fWAqzOQOFOxp7+WKF4DLUF-FqgiPg@mail.gmail.com>
 <CAP01T75dDL5pud_NmCmEapw6p1cZss9LTfh6sBxdxYinVQTP5Q@mail.gmail.com>
 <aed1731e-986e-484e-bc16-682b025d26cf@linux.dev>
 <CAP01T741UV0TsvxxXRAT-zYjKoHwcpsr2bbMS-eFnxytcng7Kg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAP01T741UV0TsvxxXRAT-zYjKoHwcpsr2bbMS-eFnxytcng7Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0054.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5a::19) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6261:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: c2601b44-89f1-45ec-354a-08de7f68d352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	Fa/lg/+hDwN4Iaq7lN+SunmHusmpA0rcAAx5kIIePXYycRnBSE9k4gMmWGkhsviOTT8NoK7qYj9ClEgkLAXju5XX8bUHJUltxQ7woypsLpSgL9BdcwR/M1w2s2xvGT0xKff07YdsbzmKseDxuzSHYf4az2NRYHHQl5Pt9hxRpbASkkzTaFFygqpqgjdc2Lz3XRdHYe4WauTF6d4PFrycl0pAh7TWbD8Xyq3xhvRReieJ8DpWfsuUE7w73ITzlybwGoKvTYeqUgbQU06kebKzBEP44sKebFeDnm6bbnMAXKz8lEM0DJtWtHiJJroCV5CN07HG5TKTwKexIBfSmNk/+A/dX6ozx1NL8YK9HeFnlzm8dMwa426ZkPFgzre9TfmO0psQsun+5LVDh/AMZR+/fYXLd0LU/t99pRoBVvL0Q4g0V0qTEZdsHWgar8QEL/Q4GlDJPGIU7PdH0pThy5vKbAHwIZSdxoYxGpHqzjPq+Ip88fM1PU3IAwM6Fp9OJ+ljWbToo87U6KQalX3yRxoh3z6nln42P2Mr8jAuVNfbHTzEzH56LZ4Blmi79xYyIg0XpWWrqy6jECsUgn/7LvSDeePNrrvyywICPPfCtPoNhbPPJ6eCBVb/V2pVOYeuwuFAMfd3tN5vgQ/lPfTGI7wVH2Lyu7cX/PH3J9uGRWzwgO81+riuCjrm97Nv5rW38/Ye5OlwOTeA7wPS3LiVFMLmBWZjQq70WiEHswhn/NBZoXM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6261.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VsL2hQNElhT3FHN09IQkJyUElxcW1YeERHM0IrdG5oSWR2Q3B2bzh5ZGp5?=
 =?utf-8?B?WTFxQXpvUFFFSHl4azNHZTV5bGdHaVNBY0poempSWlVuQ09vWjJWOVhEaEQ5?=
 =?utf-8?B?a3JuS3I0VE5tRUNCRituU0JTK0ZPNTAzTTlJazVHeUtUUzhQU1JZNFYyU3c5?=
 =?utf-8?B?L29sOEVjOWQyeGc3YlFTNDV0bTJsRmZPMmR3TWF0M1dqOFk4SmNZZ2JncURB?=
 =?utf-8?B?a3dtaVVaSHdMZ0NLR0RRbHZacVFYckpJOUpkc3dkVG9yZElWZ2xOazV2L2xN?=
 =?utf-8?B?RXhhS2M3SG5FdEpIQmFaOEMzMnRlaFkyZWRxemdXOC9qU3Z1TUZidXZPNkpS?=
 =?utf-8?B?eEFySDlnblAxM3BOQjhlbTh2SXRmL2szaVNVdGJlQ0NxQmdoVW5tN09ya2Mx?=
 =?utf-8?B?WUI1MldlQ0NQUFJCQUNvQlR0S0VGYVduSHIvNkxQSDRmUFk0NVRCTmhtdENs?=
 =?utf-8?B?M24xRGg1MFBSa3p6U281VGlMUWsyRnNlQXh6YjhZWUZIWlhwZjhqT0VoTmZR?=
 =?utf-8?B?Rm8zU2JWdzJoZkQ4VHROL2YvZGxCYUdhQnFvcVdSazdrdGh3WjRTdkJoUEs4?=
 =?utf-8?B?cTRrK05KNUNxOFR5dGNVSG4wZDNkcEl4dU1BUWRiVThwRk9SV2kxNGJIdnhV?=
 =?utf-8?B?a1hUMHZJU3VUQ1EreXd4R2d4a2k2MUQ3Q0p3TG5CRURpdXdQVUkrZm51S21S?=
 =?utf-8?B?RXBKYkp3dXlvMGNCMzBiUmJvcHVxdGk5K3QwSWdxZStpaEpDeHFBb2JLNlgw?=
 =?utf-8?B?SmcwU0VUVDhoclVzeThMOHdwbWpJSDNzQTdLeWZaekdUaG5QNFoxbkJ0aWNO?=
 =?utf-8?B?MjArM3BkZThBeTNNVDhuajkrVEUvV2hnT3ZkK2Z0bkpJaFY0NTAyT1N2cnQ5?=
 =?utf-8?B?a1U5cUh2aWJVcXgvbUN1M0FHZ0J0RzZuOHl3akMyZzlPOCtHaDl2aVVPRU5k?=
 =?utf-8?B?T01LZ3VKcjRCdDZOL0FOdFZLbXRpSFZKRVhLZWIvRzVESlhBL09KUjJ2U2dz?=
 =?utf-8?B?a0RMZGFSTjBYTGxWNFlTL1h6OHM0SHRQQisweHVoaXhQWEx1dHdlZDJaQ3lL?=
 =?utf-8?B?ZUxwajVFYUxieENRa0NCcmh1YTIzU3hhL1lSUVByeVdVNG9ZbmcybUVBSHBB?=
 =?utf-8?B?eC9oRDB4S0ZxcHROUlc3OUxHYi9OUGVwSnU1WXFrUS9WN2s3dmwzcnc0dHJN?=
 =?utf-8?B?QlE1UEVNQ1VqRjA4WHVLVUNIUEdzVVdVWnAycWJGQkVaUG1IWThTSVdoSU9j?=
 =?utf-8?B?Z3BoNFZSaFJWUG5JTUphLythdzZLWGVRV2FoZ3JldHMyRHNHWTBDZHhqSFVn?=
 =?utf-8?B?NW9VS0tKS2hqNEIwdndSNTVhOVhSeDdleng0Qm1WNW02aDBrS2xUSkdQNjZz?=
 =?utf-8?B?cUJoN2FKOG1mV3YvVkRsb0M3OCt6K1NZSHJxVGVwdVFOcnA3WUJvbE1iNWdU?=
 =?utf-8?B?WFdqQlN4Q0hNU0xMRFpOaDhBM0RKUXJBOUdhaUgrdGx6UVhMT1BHY3pmejBQ?=
 =?utf-8?B?VWxINjdLT3VrUjFGeXlJN0lqQW5LUzFBZVpYOUpNYmVENENVTjRCQ1I5NnRi?=
 =?utf-8?B?RmN2U3o0ZURpMEhqeWZHOHhWMFpGUlJrMWVwYWd5NjVOQkNPQW1qV2J6bGlh?=
 =?utf-8?B?WjhyYUNsb3VMSGw1L3ozSlQ0VHBYNkJkaE52N3AzUjE2M0NiQkU2S0Z0RFdS?=
 =?utf-8?B?RFdQNVF6aExEWEJyVmswdlVla2hNT2lUV0Evd0ZMOEdOUUU0SUVQRHVBT3VT?=
 =?utf-8?B?OCtQQTdIbTdkWVBSc0EweTBnbmlNWEo3QjE5UlRFSUlHd1FOVTBMZUgxcmt1?=
 =?utf-8?B?TDJwN25pbFFtL3ptSTc3Ni9Tb2R1bDF5YzVhV2Rma2l2cVBkU0RvUkRDd3hj?=
 =?utf-8?B?S3FuRFNJVmZtbDBEZzRJZklQQ0lLLzZKMTFzM1VYYzJkeWJSY2V2YUltdm1m?=
 =?utf-8?B?bFRlcmdLTE5OaFZ3T1lRc3I0WGE0Z1FPKzZ0dlM4bndOVmQ2c1JSQmxMZDh1?=
 =?utf-8?B?VTBBU0M4WW1KTG5RQjRaM0M2T0xnVU1kbWhjMXZlRGxSbkdvbnJaUVc2MkdO?=
 =?utf-8?B?VXBUb3I1NExLTUhuVmI1cXJ1bXlGTHdnSDR2UWxubmZQbXpkQllrb0pRM3B3?=
 =?utf-8?B?Y1pSZ3lIeWI3cU02d0V3NkRBT0RvdXdNL1FzdHlsUHo4V0RUeVNCYXBpUURQ?=
 =?utf-8?B?REU4ai8rQVY0WG5reDRWRG9GbXNJZnFxaEdGcndaelFvYUljY09YU1F4SExj?=
 =?utf-8?B?QTY5OXRjWWhaMnNhWEFTUHdJR2VZNzRhdkp1N01jdkp0OS82YTUzRmo3YXU2?=
 =?utf-8?B?bERiaUpDMDN3VGtNMXJSUlFIRjlLOGJ2dW1CNFEwZkpHekpIa1R1UT09?=
X-Exchange-RoutingPolicyChecked:
	r2uaX4veqc6sbAY4TWTlwyUfJhMeY8tqKEkj7Z9Ynu6FENzJu76jl9nVKsJcaNQ3Qfse2o1SYsTen36ecVQVfBCHcwSb9KqocRJ4kdsuiWfQRtTu3jm2KRJqhNP0vE77moiTMHtoWPBPC+2OgVaphyahGDNsofpSrGMq5b0nSYGwYjKMVoCK/YxSC7ru12jAsS9ccRibRpQe7kG1jIeLgpx2M9QJlR7s1WwXnfoRohfBaD1EyphihwjNNgM3rHgesLSsHoRaeO4yA4dHsT6STjqyoMq3OoSxZQDniTfrXDTHgr4t6vrPJBi4gIvpDwdp4EFKYbXbaMUwSTKe4+LdLw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kx7Ts3vKBw5PLjwHWK40h79JTqjRSwvv+c+hhX1OSj6mA9ALbvObsh4mx8LlZ2iNfu5lMBozlSflM+bLOVMSLskvediihBmhaydZAuK1MVlCTWihzaERorcikqvyK5vnC4n5QXw1V1jwhXZxJJ/1tjYS0UxHxBP3f5p/TFIZWgDvSETgDe41UmFN5E/3QK1r8uomLJr3552kGcID7N6sYyfdhAO6bodDvGWJGzQogrz4TWGpbH982j9UJ+MvDyp284DU0R5aDjYTIGTT1l+wjGL+gaq9pYmaHJ3OAMXfEcLge/z1Qls7MM0Jk2NfIuji4e4VU3jaA+2opgXx+T+IqDFDaMdmULFBA0w7rylPVGEo4335zpTtUCNVDlYKCOfKMsqfxL7Raxy1i87nSQRDajB0ipoX43h9+05slM4afaqn/dhhNyxG006ZJPOKMAtZqEpDjz0PYrPCAhRAPA6rrXaGMPgid8G6A4KFiYwxlpjm9jC0TDSo1e3WlVT6XYsmJmq6WTDPO3F8yNwrNleRhmRnvQld3CfaQyc0Cl6Ood1NhwKsz3zn+H93Ukgjjw7XS0itHU1Mq+sVKW4XBQxNG5wCPOxNNgH53AtC5wa4F9U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2601b44-89f1-45ec-354a-08de7f68d352
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:22:13.6386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6QfS4+bMOtlH9Rwh1kNzMT1q7tDqwFfxdDt2QctEl0xrK01XYp3H2nFfGelepMFEQoyBy03P4nWngrVfIHAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110104
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEwNCBTYWx0ZWRfXyrkq1sHfvVpJ
 D1ysIusv9A1ly/DV/jlVsfJkBZRGduJxMcZoJB1mRXK1IR0qVysKUzQoeDzjqA33ZrzDRw5x7u1
 ZmxQwUP2sA/FZgdHob4XRxFXV7IAa3zZIjBOG8MRtMUt+3XFLOYGuoCN3/pXnWRtZ8GeILiQqjQ
 c0Ef6Nwszl/v2X9f6ZiFOwpV/HH4hFmbiICd+z7IjurbR92qQXAMCr92wNJqOTDAyyHpxnfAgul
 WWNEoOI9sR8icZHzVnS1HRoUx4mxsalAnypguYmfSWzKzB/7792kxSwWbICZw42fAlGEs4dPW89
 SAhiUX3mb2BCq/Mwyn9QHy8sFeE5km4830npEB8WTOxkxP6WV2NcfqE6gIYVcFkOshmw7nPqiNx
 0UsD2WSLQCECDhZCV27SGFStnUDDKxcxRllgWZMWZjBYO87p/VRG34tnURggReVMRsdvzpwKvdi
 siuMtQgpdh5AAWwkM7R/qVvpCb4o0Qp5NHN734PI=
X-Authority-Analysis: v=2.4 cv=f+RFxeyM c=1 sm=1 tr=0 ts=69b15e79 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=PxvYVDMP49MyINV_mVoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12272
X-Proofpoint-GUID: C38bTj7R4HpzXIDgnJEXESZW7DH2un8_
X-Proofpoint-ORIG-GUID: C38bTj7R4HpzXIDgnJEXESZW7DH2un8_

On 11/03/2026 09:30, Kumar Kartikeya Dwivedi wrote:
> On Wed, 11 Mar 2026 at 01:20, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>>
>> On 3/10/26 4:35 PM, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, 11 Mar 2026 at 00:17, Amery Hung <ameryhung@gmail.com> wrote:
>>>>
>>>> On Tue, Mar 10, 2026 at 3:48 PM Kumar Kartikeya Dwivedi
>>>> <memxor@gmail.com> wrote:
>>>>>
>>>>> On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Mar 10, 2026 at 2:41 PM Kumar Kartikeya Dwivedi
>>>>>> <memxor@gmail.com> wrote:
>>>>>>>
>>>>>>> On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrote:
>>>>>>>>
>>>>>>>> When running BPF struct_ops tests consecutively, the second test fails
>>>>>>>> because BTF object references take longer to be released while their
>>>>>>>> associated module is removed from btf_modules list immediately
>>>>>>>> during module unload. This creates a race condition where the second
>>>>>>>> test retrieves the cached BTF object but cannot find valid module
>>>>>>>> information, causing btf_try_get_module() to return NULL.
>>>>>>>>
>>>>>>>> Fix this by modifying MODULE_STATE_GOING handling to wait for
>>>>>>>> active BTF references to be released before completing module
>>>>>>>> cleanup. This ensures BTF objects are properly cleaned up from the
>>>>>>>> cache before their module metadata is removed, eliminating the timing
>>>>>>>> window that caused the race condition.
>>>>>>>>
>>>>>>>> Signed-off-by: Gregory Bell <grbell@redhat.com>
>>>>>>>> ---
>>>>>>>>   kernel/bpf/btf.c | 7 ++++++-
>>>>>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>>>>>>> index 09fcbb125155..81c9f46a7bb7 100644
>>>>>>>> --- a/kernel/bpf/btf.c
>>>>>>>> +++ b/kernel/bpf/btf.c
>>>>>>>> @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>>>>>>>                  list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
>>>>>>>>                          if (btf_mod->module != module)
>>>>>>>>                                  continue;
>>>>>>>> -
>>>>>>>> +                       unsigned int timeout = 1000;
>>>>>>>> +                       while (refcount_read(&btf_mod->btf->refcnt) > 1
>>>>>>>> +                       && timeout > 0 ) {
>>>>>>>> +                               msleep(1);
>>>>>>>> +                               timeout--;
>>>>>>>> +                       }
>>>>>>>
>>>>>>> This isn't the right way to address such issues. Your diagnosis is
>>>>>>> correct but fix is just papering over real problems.
>>>>>>
>>>>>> Second that the fix is not right.
>>
>> pw-bot: cr
>>
>>>>>>
>>>>>>>
>>>>>>> The better way would be to block the discovery of such BTFs once the
>>>>>>> module is unloaded.
>>>>>>> I.e. once we return to userspace after module unload, subsequent calls
>>>>>>> to obtain an fd for such BTFs should not succeed.
>>>>>>> If someone is racing to look it up while the unload happens, so be it,
>>>>>>> they will fail anyway.
>>>>>>>
>>>>>>> I would use a bool flag in struct btf, set it inside the critical
>>>>>>> section at this point with WRITE_ONCE, then test it early in
>>>>>>> bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
>>>>>>> condition.
>>>>>>> Using READ_ONCE of course.
>>>>>>> Also, we need to add it to btf_get_fd_by_id, so that once conversions
>>>>>>> from stale IDs to FDs don't succeed.
>>>>>>> Looking at load_module_btfs(), it already handles the ENOENT case when
>>>>>>> id lookup succeeds, but fd lookup fails.
>>>>>>> So for stale ids it should just skip over their errors if we return
>>>>>>> the same ENOENT as the refcount_inc_not_zero case.
>>>>>>> We will still report stale ids, but not allow their conversion.
>>>>>>> We could filter id lookup too but it will penalize the common code and
>>>>>>> we need extra radix tree lookup just for BTF case.
>>>>>>>
>>>>>>> For me locally, these changes seem to address the problem. I could
>>>>>>> send the fix, but if you would like to take a stab at the above
>>>>>>> change, please go ahead.
>>>>>>>
>>>>>>
>>>>>> I guess this is worth a fix because it makes btf_get_fd_by_id() less
>>>>>> likely to return to stale id. However, there is still a small window
>>>>>> between btf_get_fd_by_id() and btf_try_get_module() so struct_ops map
>>>>>> creation can still fail.
>>>>>
>>>>> That's fine, it means that module unload is happening in parallel, so
>>>>> it's racy and non-deterministic anyway.
>>>>> When the user controls the module unload though, they should not be
>>>>> getting stale BTF fds once module unload has returned to user space.
>>>>> At that point all associated artifacts shouldn't be discoverable.
>>>>>
>>>>>>
>>>>>> As for the solution, there already is btf_mod->flags. So maybe instead
>>>>>> of adding a bool, just test the flag?
>>>>>
>>>>> You mean struct btf instead of btf_mod? I don't see the flags field there.
>>>>> The btf_mod->flags won't work, it's already deleted and freed by this
>>>>> time, and requires us to go first from the BTF to the btf_mod.
>>>>> So it has to be in struct btf.
>>>>>
>>>>
>>>> I was thinking about updating btf_module->flags when handling
>>>> MODULE_STATE_GOING. Then btf_get_fd_by_id() can call
>>>> btf_try_get_module() to check flags if it's module BTF. If the module
>>>> is already freed then it returns -ENOENT.
>>>
>>> Hmm, interesting thought.
>>> I guess the only downside is that it's O(n) lookup under mutex, which
>>> can be costly with lots of modules, and always penalizes
>>> get_fd_by_id() for handling race.
>>> We also need to repeat it in bpf_core_find_cands and bpf_find_btf_id,
>>> where we may repeat it multiple times in the loop, so the cost is
>>> amplified.
>>>
>>
>> Is btf->id still needed somewhere after MODULE_STATE_GOING? Otherwise,
>> directly removing btf->id from btf_idr in btf_module_notify() should
>> stop the discovery.
> 
> I looked at this, I think we will need to reset the btf->id too.
> Otherwise while btf_free_id is idempotent (no-op on free id), the
> released id can be reused and if we don't guard btf_free_id in btf_put
> it will remove it for some other BTF initialized in the meantime.
> We can likely set a flag or something to skip it in btf_put(). As long
> as the module is holding a reference nothing else should do it.
> 

I wonder if it'd make sense to reduce the cost of btf -> module lookup so that
we could check the flag in contexts like btf_get_fd_by_id()? AI suggested reworking
btf_module lookup from a linked list to a pair of xarrays keyed by struct module *
and struct btf *, and it seems reasonable (testing it now). An easy win might be 
to get rid of the strcmp() to vmlinux in btf_is_module(), replacing it with the 
simpler predicate 

	btf->kernel_btf && btf->base_btf;

to reduce overhead of lots of btf_is_module() lookups. What do you think?
