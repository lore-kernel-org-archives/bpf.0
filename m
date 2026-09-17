Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0F3BFAFA
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789666440; cv=fail; b=UK5vozg0Ea1FpPD5YLbHKorLRLoZS4W6QArg4SrfbbBCDbhH3QtRxvKvGBWtgEQhTOzuL2GztqzJc8d/ivIKMtvVMi1RlEWtlMq9fgxfVzsj2Mqlif+lgIjoLXD/oMeI5K/R9CY3sWU021xbRkXu9b8BN2m8urtpHMqdSN/7Ga0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789666440; c=relaxed/simple;
	bh=PnnVDAzhUphwU7dgTdUK/J9dEFVB5dmO4XzkB0H7qhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrOojeBlspN0wEtR++QedxSRzxhQ+hTvzpxbOf5KOatanEAn2QOXTTtbzQLUDu9FtjioGjr+akpS4MvVRMkUBLdp4ME47ydeoCpSsVpUKuRzAaIDSoEpMi2tMOii+p7jOKPJWZjruQ9nUpe0ZVwiIeew/JFcPW+LqDtTaT5plQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GCen+GLG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SEfensH3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GCen+GLG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SEfensH3"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH0tuk923345;
	Thu, 17 Sep 2026 17:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ikag4B5wYqEZlYHV/il3QL5LJ8n5JxCbRUZ9lqqZpbI=; b=
	GCen+GLGlV9wsaR8RLRMwXrySJ9VOKJ5QkHcDJ7l7QjEb7/tQWalEPoQzv+0vzWU
	Y3urXWmxHjkjrsmjIgLAy1hHJVDbbR4hjYffS+PNjmPZk8RBjmiHqBBSCNS1xjJw
	hL9QqQfkrDCo09/VWBUQ2dyh3rrrJp26YGFB6WQVKoCBzi5gvO4OVE8jAu9J9yga
	RxrPsqh/P2wX8g+ONHwdSEwbopfVKGQhQto/5FApezit0Zkmz3vZVQL1/0AHmCYP
	CBOTbwnnr+DkzlBxxABdcJgD10rc1T+T/mG3lbPWU9m97iflIogVMnldt0jU1MOu
	vemkLW8sZf+MY+lAKow55A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gmxm7g2sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 17:33:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68HHUNvu026286;
	Thu, 17 Sep 2026 17:33:08 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4gmw6sfvk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Sep 2026 17:33:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZtlJABkxRSOX/ts1IYxGqVDwdQUOWDIUNnN+my7R2a5mkmTsVFsyqFNBWR8aWvFaVj0BqHk+BOekeAvcENI85jiiht20FCnw6CPlV50ifasyNe5rXa8aSRtaPW2uWcQecxo6gJY3jcma4eW5xDI+jteorE/N8Sjl0rDGHJM2OApqdUuXO7uBzNpk/KTSiJtZH52hBVdJpCWFtSGq6dO39OFLH6h+7FMjrFEDY5AqgnlOZHs7jmgjwj88+vKoxw7lh1SXOZ7MGaZKaEZPhfLawODdwRKqNo1wHbq1um8M0KCWFnMgE1nKoBvVlNd/4KjuacVvq62PguWD9xrl1212g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikag4B5wYqEZlYHV/il3QL5LJ8n5JxCbRUZ9lqqZpbI=;
 b=QkLBgs+oFwc6JRwmpDH0rMwnNlme/2jJsr102PfwC0yRXy+TfNP9zyO8YbHpf3vyFDsdAn9WZZb5XG7EvQ8uyl5cVi8xohV3aeXs0XQ80mVBXshYmhnHNv7fWnnGzVRTHp7paAMWmNyknjGyZW2rI6gLy5oTkZ0vivJPrZuIPTpZYZhb2ZCIDgsX9dYecz+CA61TcPQ1FZ7bFhY7D0srIf9zZEz/R4koJOZSmtIbWbsRzskhgviDP7QkVJSAIbkunxgYcIclTr5Bz/4Ru1nTNcUFNLlgdOU0m1HRTpBlualME7aPCVgcew7m5S2WHlqX+yyoHObzDynN0Wfn1FEPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikag4B5wYqEZlYHV/il3QL5LJ8n5JxCbRUZ9lqqZpbI=;
 b=SEfensH3kg9KILHa+HQ63cUCEM9O7cos4fUz3HbIiZDB/mds1xLIMw6qBzWFs+GAP/HqZ6Eroe+dcPdumX0RIU7FvkLR52D5Tcibw0jeLSe87BeCjh1wjn56cOME+T/KG2QuJU+ce+Z1GPHgO7fHdXUecffIuwtNRKeSiNKhiQI=
Received: from DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 17:33:05 +0000
Received: from DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622]) by DS7PR10MB4909.namprd10.prod.outlook.com
 ([fe80::3f78:c489:86a0:3622%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 17:33:05 +0000
Message-ID: <2f661066-caae-4ce2-8a6c-e07bbd4bc146@oracle.com>
Date: Thu, 17 Sep 2026 18:32:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump LOC_PARAM,
 LOC_PROTO and LOCSEC
To: Quentin Monnet <qmo@kernel.org>, ast@kernel.org, andrii@kernel.org,
        eddyz87@gmail.com, jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
        puranjay@kernel.org, yatsenko@meta.com
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-10-alan.maguire@oracle.com>
 <89767d7c-c622-42dc-a820-ead87ed3e2cf@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <89767d7c-c622-42dc-a820-ead87ed3e2cf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::9) To DS7PR10MB4909.namprd10.prod.outlook.com
 (2603:10b6:5:3b0::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4909:EE_|BN0PR10MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f46f343-7b4a-4605-f8ad-08df14e1bb32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	oU8FdtFBEpzHaDRPu+GBkWXh2xB9mS3y70aM4jgoBvKWxQbupEZPyxYdF7pcBKUQxQOskKpgOv8nP4QjaeN+2jhEMTmBTkv4IRYhVNXsGg84GArFTVp+4PZ2EekIzRAVHILKoIzDVNY1JHVU5g78zKmoKjOOld+KLGQZNS7ZhC3p3TIF5UZrbKQ1eKje2+fvI6gHhbTLFoDVDePs5AdyRrxJu08UA9CXLDoUx7PTKeKYHDSOH80j83oevXvvjihAIQ6zf8Tfpi+1XueTpp9tA/Je2WdxbQ1R3ADfVxOM5+mqSi+vZubrg1NqUib6LvDAPbVjGNv2pMaBI//oukzNPvwxvSQa2cl75dB1bOGmch2VYm6eP/nTXTBlRLNhUaZCQLibWYKXLy+SbGEibazHOl/c4nltfvDPxuklHrWvNyrLhhktFrFrywAsJzbbecuHmNu5dQBIQfoRGMrdkWwpz5hhmnry+aYvl64GkQ8qWpaHWi49vQRMs8XSBLtA8OmbN9EPkRBGqxo3tpfB7m9J1PvhPdWjsT0OE8Hmt7kLeRy+T9QyfLP1Tsc0huH5+Abkp7zyQP5sHPgWGh/8zecViKz8aMXugWdd41V/0ZKP+VU0hE4QYdOHdxIUFg3VYdalEO7KfFUJU8oDJU1feq1C2jE12EbZmON3+HVqT5x1PY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4909.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGRrbnJnOFYzdXpRRVZRbTBDSS9hMHJzVUVUdVRaclVJdlB1cFRXdFduSjZR?=
 =?utf-8?B?dTNIRlk0bmE1cEhsUGIyNUZRZmNtWGd0VXdJYm95T1ZtSFZ3ZVZmRmE4cGZ3?=
 =?utf-8?B?eXpxNjZwSGxvSXhyWllTOEVlS21QSWpFb1krbzVEYWkrM3FzY0ZZMU10OE1k?=
 =?utf-8?B?eXFPNFBodTlpY1h3dU4vRFdoQWRraVZsaVcxYUtBSjhHMXRhSENYa20reHVs?=
 =?utf-8?B?NUs5QUwvUncrWnFuZjh2UTRLSy9seXdBeDBlYlBwejk1RXNob2pFQmV6RFly?=
 =?utf-8?B?YjB5TnlMUW9oTHFUdnd4aGJvNkV1TXRTaGRuUlJqNjZKcmZGemMrelNlSWx4?=
 =?utf-8?B?ZzRRZkxJMitIZXNHUndVZ2tqMXp1RzFJeDJYeXk4SnhUNTZuSUxhUENQcis1?=
 =?utf-8?B?VlAyTzVkaEF0NVRybkVnbFNWREZTTHlBRmlJTmc3QTNiSUp5UitYNHd3M2Jr?=
 =?utf-8?B?WlVpZ29SMGN6Z0hZa1dIK0VqdWtpRHk3TGFYOUVLZzFUOEFRYW9TQ3RzM0VN?=
 =?utf-8?B?bmpiRnVSR09taW1FaWYyVytRZ205aEpaL040OUJGU2ZlQWJLQ3hYVEpSam5r?=
 =?utf-8?B?a2JaSElaQm16eFhRa2hoWW4weGRuS1NoQXg1aXhjbTFTbDYvU1p0V3VCcGZy?=
 =?utf-8?B?bkk2VjZHQXBzSmo5NkxRQlBIOTNDS1k0Rnl2M2JpZHVHcDhUQ0s5QUpiVGFQ?=
 =?utf-8?B?NU5scW5XTEdzdERoSkhsSEhidnBVdHR3ZTNuamFYTzJhRHFtQjVTZTM1VWpj?=
 =?utf-8?B?NmR1MCtjUEsyaHZzYi9qUnNMU2ZhUUdLbVVTUXROMjhMVzJBQXYzV2UwTW53?=
 =?utf-8?B?bG1Bb0puYzRQYmlvTE04YmRsRC9rcy82NEUxM0c3Z0FON3gyd0hFN2xYR25E?=
 =?utf-8?B?ZlRTQ0x1SmE3V2dPMFF4OERld1RJZ3Z1ZlpMeUV4emRDSWJCa3FFN2dZM0I1?=
 =?utf-8?B?UWttVjZqdUVZazlpWVpIYTRVeWpQcFV2VTdLN1lEYWFZVDJZbFNWUFBMR05W?=
 =?utf-8?B?WHRac1NFZWFuZ25KOElMdnJoSUphRCszWm16ZFVIbzlqVHZYZUp4QWNhdk1G?=
 =?utf-8?B?YnpLQ29QZ0xiWmtidkY2enpzcEZSZVJxc0VoVXFzQW0xdzhoK3RHMmwzV3dU?=
 =?utf-8?B?NFdKMkQxMStYaUY4MVdwblNJdE10SjdaOHB5Vkx3MnJVeTZUd1lsV0dhb3ll?=
 =?utf-8?B?bzdzNWxFdFVTM0VTamF0VmViMFBPNjhRS1dROTgyQ0xBNzA4NWNWbmMxTWNU?=
 =?utf-8?B?aFcvVk90MUhsUTAvWWczS3AvQnZpRFJ2eW9hZHFpK0cyUEtob0Q2VjVETzRz?=
 =?utf-8?B?aWpPZlV1dnFCWXp4eUNuUVhUaU9EN2Nrdm0rcFZyZ3hEV0RQQmdWZjFqLy9X?=
 =?utf-8?B?N0VJL0t1L0puZE9LaGt2clA4Y1JOZUpmdWJIWXdnS1Q0NEFXZ213TUpoQXJ3?=
 =?utf-8?B?SmJ0NHdFRTRJMDE2ZWhqNWhlMjdWOWdFSlB1Mlc2S2FuSnRpTEY5djZBSE01?=
 =?utf-8?B?S2YwMWZPMm5FUW9xeExuazJvK3AydkRYTE1WZ0hjbXpGVTRMZjJLUzF4d2lV?=
 =?utf-8?B?TWNpb1k0NE5ZdmFLR1I1Qk5iZHF6RGxDVWVuWTdFZkU3enZERHhPRG1uMW5j?=
 =?utf-8?B?RXk2em1LdXRhaVI5MmxIYUZodEJsWVF0cFViMlpvdGpTa0FNQ3hiZDFYYzM5?=
 =?utf-8?B?emQwdkxYWHRud2QvSGJjVC92a0FwYS9YazEzSktXN0JVQjk5eVhQajE0MDE0?=
 =?utf-8?B?Y1VXS2NqWWVLMlhkZTJlYnZzbzdMU3d5TzFVRm8wVU5tLzV3SHBMUnM1cGIr?=
 =?utf-8?B?ZERYZ2o0WmI1ZHltMEV2K0ljZ1BrZU9TUW5QVW80WlJoNy9oM2dnS3Bna1NU?=
 =?utf-8?B?NXVYT0xYZGd5b3NjT3ZFeDNKZUtpKzBWcG8zeWQyVEhQc21XdHJpNnhubWFx?=
 =?utf-8?B?TGhnWDNURHB6aktTMTdEMDRGUlZ5YXJXK2dMS0ozTVJJaXdTMkdHNE9GVmhO?=
 =?utf-8?B?UGVyQUVkay9vM3hESk51VEc0K3g4cFJCOFY0TTBQRERvd1JjQ2RzY2xObSto?=
 =?utf-8?B?cmp3cTBadk8vL3RjRHB0VndpNHJGemY4anIvb3F0NVpscDhFQUtyZzh0bklS?=
 =?utf-8?B?eHpkaUU0aGR4M2xmSVE2V3VkTTVHZ2xldFU4cnNGVWZJSmZKSlZDc1hoa1ZZ?=
 =?utf-8?B?OFg5V3JpNEVvb1M3TG5OS0xIMUdibm8vcVpQSE84Rm5OUUlIZVo4RjhVMWtW?=
 =?utf-8?B?dlYzTXZ2SHAxQ3FmckNUZXpuanAva2VvakFYS0luTXhGNmFOd2thODgyZ0V0?=
 =?utf-8?B?WTFWRGtueFJMeTV1clVxQ2p1TkZJSDcvZ3VLdUtaL3pxRjZKdXhmUT09?=
X-Exchange-RoutingPolicyChecked:
	PuSbdp+PVAcCHAEUq9NRfJZq2Tbrxz/GwHfEAT4Ri4XtPLVWk8txydSD/Bqgtw7A26KUmyFE1CgkH+fdzTwbJH3ERAJt0drpYLUbAlfGwAa4LjROAGKnoYymQ0+HobppW3wah2xkqZ9ZKGPAIkPRTtTdK67qzEExCVAKGWGS1UUTSLYtBaTxHW8fRd/iqNFBAcbv1TUfOwcKxDn1ngNXR/0LwrY0Vyto3jD8vG/SXjA3tPWKz+x89jPjzRrOpsbZ3DdSh3DCYXGYtyCXrJBilyHbVgcjwLcb58DmZCsns0XG+9UMiKWGbd0kGHDw2u6ZxigsNhl23DhUpa5j4FTR7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aFp0yJDn40ioues5/mqF2wLwWnz+ISO4bU1eBMrbqrYJ8Dl8D1UpftsitdiHxLIyrbwZnUfiD5bJacPvF4uPl6gi9/Zv7n1IbpibRZ8zNgjxASbY+9WgcK+wcXSFv1uNHJ1Zrf5hzT7H6nw2kM5ixpHG3V6zrHE4nOtqRP9PnPcdReiGE/dUKrA1//MNBkMSjz5oZv8g2j7mO+SDG8trm4x9Xz41Lf4yZG0hs7Onra5mDXRKl4jLKDzoxKWksUWc8sedUuS4wRMSp9RGfGHcbMQLAVrKdWMBTHSh7cmRnnoS6r24fj/EuqcnFrSooxRzAMw/nm7vwBr1k0EkxYdY2L3vpoUXkNB0iC8ouyoKpro/v5E0u20LwBGN5SnMQa1gXzBUfd/IDZhM8ijVkaQLlrdsbQM2jbcfLzxd284em6/+pO8mg+sX6rd5q29TZZjCzNET8GVDk41rwbLuziKYLXn9niPNdrJgiFRpiE2eH/tUWTgK7xxnE89+vmMIdkO2Rx8C+6pPs8HqDVN9Fm6J0VT3da+NCTWyoygPZLn7rKwyg6gGpEe0GQX9/xLrc5GA/QtBn/8nkyl1HfaziqUbypLCAyX1zwEoA+mwQ5+hnpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f46f343-7b4a-4605-f8ad-08df14e1bb32
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4909.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 17:33:05.4183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzyqsw/63oi0iKIBDBjHPQUYelHGH0h91g8j9Wp98X5qJo7ihrQ13KlWem1nnqGkaARIO9pZvTX8qM6r5fdr4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2609170249
X-Proofpoint-GUID: TbqgzghrAP30-8OiCAJhvELiw452Uv3h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfX8B66G2UKgpIF
 Vfox5aYYOOPTdg28P/7Qf43/yzEo/GKZjfvI3ZEoNgKCSETLycXG5t5VKcJ27PlX3/Rv39DD3XF
 Wx0I1MXnL+MOlmjCQCU2i9hyUqP1eMgMSeVLtVvMMuEc+llzy3K2UtnHZNbHWJuQeJvsSbPtuCK
 tHWc0pNsyC2gKoH3H6RRrklc0Qh9iYDJyqKYkZhGlw0ZhEwcs5FY8caHyocpaa7M9xf3lW4Vc+8
 8HJ6EAScPjocVBVk9Kh2DrhA4GEXAXGQgYAN6pEDGzb5m6kuXYYss6UCW1fu5AtaDVKKH8YwYVJ
 ikIUYw4hXJIpWsGXMkHIEtR2tnLzkberrkWSd+uTtjXhgfvy6Fzw1nu2v6OcJY62Kf85XzhJGFp
 PPlle+y6w/21gYRydz9E3OC/oNWIBdklpCeP9oKmWEKxmbNRuAOk1divomrpF4lRl4Vf54Dyuz4
 20OZAsLz6m/VY7LbkaxJhDN/T+Aj1wMl2JhEOiCQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfX6e7kglt7B3Ip
 VgcSShp+if7Wl+Maey+/chEqmGbWm7wqglqeW06tgGpq0+OmT8uEZRMtaG50ChaooV2Ji2OOxUM
 8ippsFtOTs6pWLAjF05mxv5zrJTdDA8gpvnWSrs5jS/fgE+JYJtD
X-Proofpoint-ORIG-GUID: TbqgzghrAP30-8OiCAJhvELiw452Uv3h
X-Authority-Analysis: v=2.4 cv=A/n5rKWG c=1 sm=1 tr=0 ts=6aac2455 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8
 a=k8p2YUJgWV_7gAfxYP8A:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12106

On 17/09/2026 17:06, Quentin Monnet wrote:
> 2026-09-16 08:41 UTC+0100 ~ Alan Maguire <alan.maguire@oracle.com>
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
>>
>> and LOCSEC shows function name associated with site:
>>
>>   [15] LOCSEC 'inline.text' vlen=1
>>   	name=foo func_type_id=5 loc_proto_type_id=14 offset=64
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/btf.c | 169 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 169 insertions(+)
>>
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index bbe8f9ea144f..5e0cb5862811 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -51,6 +51,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>>  	[BTF_KIND_DECL_TAG]	= "DECL_TAG",
>>  	[BTF_KIND_TYPE_TAG]	= "TYPE_TAG",
>>  	[BTF_KIND_ENUM64]	= "ENUM64",
>> +	[BTF_KIND_LOC_PARAM]	= "LOC_PARAM",
>> +	[BTF_KIND_LOC_PROTO]	= "LOC_PROTO",
>> +	[BTF_KIND_LOCSEC]	= "LOCSEC",
>>  };
>>  
>>  struct sort_datum {
>> @@ -117,6 +120,83 @@ static int btf_kind_safe(int kind)
>>  	return kind <= BTF_KIND_MAX ? kind : BTF_KIND_UNKN;
>>  }
>>  
>> +static void btf_loc_param_str(const struct btf_type *t, char *str, size_t sz)
>> +{
>> +	const struct btf_loc_param *p;
>> +	__u32 i = 0, vlen;
>> +	__u64 value;
>> +	bool negative = false;
>> +	char regs[32] = {};
>> +	char num[32] = {};
>> +	const char *op = "";
>> +
>> +	if (!t || !btf_is_loc_param(t)) {
>> +		snprintf(str, sz, "<invalid>");
>> +		return;
>> +	}
>> +
>> +	p = btf_loc_param(t);
>> +	vlen = btf_vlen(t);
>> +
>> +	if (p->flags & BTF_LOC_PARAM_REG) {
>> +		__u32 nregs = (p->flags == BTF_LOC_PARAM_REG) ? vlen : 1;
>> +
>> +		if (nregs > vlen) {
>> +			snprintf(str, sz, "?");
>> +			return;
>> +		}
>> +
>> +		switch (nregs) {
>> +		case 2:
>> +			snprintf(regs, sizeof(regs), "r%u, r%u",
>> +				 p->values[0], p->values[1]);
>> +			break;
>> +		case 1:
>> +			snprintf(regs, sizeof(regs), "r%u", p->values[0]);
>> +			break;
>> +		default:
>> +			snprintf(regs, sizeof(regs), "?");
>> +			break;
>> +		}
>> +		i += nregs;
>> +	}
>> +	if (p->flags & (BTF_LOC_PARAM_CONST|BTF_LOC_PARAM_OFFSET)) {
>> +		switch (vlen - i) {
>> +		case 1:
>> +			value = p->values[i];
>> +			break;
>> +		case 2:
>> +			value = ((__u64)p->values[i + 1] << 32) | p->values[i];
>> +			break;
>> +		default:
>> +			snprintf(num, sizeof(num), "?");
>> +			goto done;
>> +		}
>> +		if ((p->flags & BTF_LOC_PARAM_SIGNED) && t->size &&
>> +		    t->size <= sizeof(value)) {
>> +			__u32 bits = t->size * 8;
> 
> 
> Hi Alan, thanks!
> 
> In the case of BTF_LOC_PARAM_OFFSET, what do we need "negative" for
> exactly, is this supposed to be the sign for the parameter or for the
> associated offset? My understanding is that "t->size" refers to the
> parameter itself, not the offset, so we would pick the wrong bit if
> trying to find the sign for the offset? But I'm not sure I read it
> correctly.
> 

hi Quentin, great catch! This was a leftover from a previous iteration
where the sign of the size was used to connote whether the constant 
value is signed or not; we use the flags to identify that now so that
the size can be a valid (>= 0) size, so the negative size needs to go
away; will fix for v4.

> 
>> +
>> +			if (t->size < sizeof(value))
>> +				value &= (1ULL << bits) - 1;
>> +			negative = value & (1ULL << (bits - 1));
>> +			if (negative)
>> +				value = t->size == sizeof(value) ? -value :
>> +					(1ULL << bits) - value;
>> +		}
>> +		snprintf(num, sizeof(num), "0x%llx", (unsigned long long)value);
> 
> 
> Looking at the different existing flags and their docs, I see:
> 
> "a BTF_LOC_PARAM_ADDR|BTF_LOC_PARAM_CONST is an address that should be
> normalized with respect to kernel/module base address."
> 
> But I don't see the output accounting for BTF_LOC_PARAM_ADDR, is this
> expected or is that an omission?
>

In general an address will have both _CONST and _ADDR specified so it will
be captured by const display, but I should make that more explicit in the
code.
 
> [...]
> 
> Please also look at Sashiko and bpf-ci's reviews for patch 7.
>

Will do; thanks again!

Alan

 
> Thanks,
> Quentin

