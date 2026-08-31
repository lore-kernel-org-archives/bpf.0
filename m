Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A779A367B8F
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187622; cv=fail; b=ed5Fe5/VaFZafyPumvuKiixZhgLpZw67dGXoDVF7d+4nuNzQYxsI+flOXPAnh1K2Al7HX1qb3//MxYkkKZ+eW6XLEHVfcD+jH8ZJ4aFs31OEs17EA+PctUB54biRRp6pxK5Nk+8BGlL70jmBpzAItHwIJrRiL70M3zjvlRV3tKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187622; c=relaxed/simple;
	bh=BuUlwxdD07UwmhEaORgE5AVfLzjBxdO+az/ZY0dgNUY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kwsiRS+RTLR5nl3zBClD5OSjud8Am1KNCzIfnwavOZgZH5t1ZOg10sww45zhc5mkA0ngTcYVBmnr4tji+7Rnc2ZZ6DtwqoMyP3Dufak1e2qdsaAy2zBsAlnOHebFiliOGjCsc9ja1qFmiri7z6o1NLeUr7MLimHvrAIWzcoX4mY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IWB61SuH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gO5bUKo5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IWB61SuH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gO5bUKo5"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VDAgix021461;
	Mon, 31 Aug 2026 14:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WqjqaeCMrUsVL5lVWZUjdxChwtY/xIWqyv3R6AacOYw=; b=
	IWB61SuHalVuErrEPSfZM3hR61Ira9A+DOqFfMRUOr2rrztzvkpokYIbxw2rF/UM
	ZuofqSom6iYYBTylO0YH9Ya1J6JxNRxg7eAV8Oi5B7qAhE33GIOlqBNwq9TO2mjs
	tP5diLzfzejn5B4bvhZ7Ajbj2Ipr0NvhtVNqvLiOr85+SoOj3d38WT4yLI9Xj4ys
	9tDCX5jNd6jfbzimJzvuBawATLsEQlvYNHMQaieSW52UYSWGpMggY5f8ueItVVN5
	R6zbVhT7cIoAfKntQ3g4njgnwf3+E0yqkyLOkxR61FnC2G/0oOkZzu/0Qq8hdjWN
	2D3To0z5pvmf/HUoFjUoVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gbnubasdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:46:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEj7Xv019641;
	Mon, 31 Aug 2026 14:46:57 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gbnvd4jku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 14:46:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g83xxeXiO451eSLzB7eh6bwbWrG5P+5KWcp69OxPV8fWu1E7RlUXiL2FJsoHY/Bgzp8XIdPWJeRy7Jwrgo08RkLg2xHMVUexNyq4nwpbD+6CJp3UN6pBkpaP43PcnPPlcq33SBzG5ybXoJ+rhBD5hFdcgFTxlUhOGYfRSX5E7pR+uId3E5S2xS8g5hsE41WBhx55Q/OCMfddjwWOgiK3EK8+DkotoiOtiCUWXnzX98rAycHhRmIAMwES2Mz2aUjBsOpkYajAeD5HWaM3de/IjCp7ers93hqci6/OnLXWjs62tycdc+RXKc+yVLkuGj4G7nvPJCiX9y6GHwqt7CEVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqjqaeCMrUsVL5lVWZUjdxChwtY/xIWqyv3R6AacOYw=;
 b=CawPVLxD8PuU6I1cJg1vaKpMMLsHZ7IkY3O5lsmKQ3i74GWcDdoETtbXGU9VGwHrxk+fr9ev3VFTZ8U5pQGOEjF6anz6K0HTLSmYqoaAQYxEFuQYDQw3dAclBvzgQMjCSih9VYWgApfB1RMKuGdeXA4Y0HDm/zqyxHtZ4RYScKN+6TNWvfImbuJjw/glrGoKpO3py8f6er2+YlNK9pPRbbpqOMdrj4e2qL1azOfBcNUD4HZKJuzTo9M7WAssVUwA3NJTBWbRtwN+5jbPxJNw4xmgZ62TG0WKnmsBu5OqiWQy9GMre/+ILTfxLmirj8Yibod7dIFcWqDCQ80ByS9PqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqjqaeCMrUsVL5lVWZUjdxChwtY/xIWqyv3R6AacOYw=;
 b=gO5bUKo55C3VNJtVgAsmcQdjZerIsQygwXtcZpiZdp9rtVL4j7l86wmHteeHaTcvBnK9vgp/+tcWOxvUQjjqWhle391e7TyiRjpybV+eWQhPnaVq6e3KD9prP3pHA34EROcKDmWBcno2RLgUYvJimcE+fCAMi/MWu2WJT6/aZZ0=
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by SJ2PR10MB7112.namprd10.prod.outlook.com (2603:10b6:a03:4c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 14:46:53 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 14:46:53 +0000
Message-ID: <ccb5d732-90ef-4acb-b11d-75da7f1d21ce@oracle.com>
Date: Mon, 31 Aug 2026 15:46:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Fuyu Zhao <zhaofuyu@vivo.com>, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com
References: <20260831133809.1161-1-zhaofuyu@vivo.com>
 <20260831133809.1161-2-zhaofuyu@vivo.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260831133809.1161-2-zhaofuyu@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|SJ2PR10MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f2030d-3742-4885-a12a-08df076eb260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|18002099003|22082099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	b7r/9vXVdcxHmt4D+sEHVuu6/vUnpxTw+6tEN3FHGJDOmLKuG32kl7qNWbOzoQt5kZSoIbtr5xdcpIAWoGgHslKkZC6buQOCVh/COd2NBog0eTu+5HHKGJIKna0Ktj7fhu0FvE2jLSWFnYWaw1aRnVOx+wE9/3Z0+++TRKP9opc5NaJmoocbNHwSAXDpt1l9HNpa2Ufxt6Sq+wthRSBMOIgv5Ixo0BXxi39vixmqbOcjyUG47dOPAan63xfdVVMT+z2Qp77T2Z8SATZX29OpM/P1Z/Te43nF3NPSXElYFUUa53eIurcJz0W0GkZBNTsSekV6UeuYYOpK284U721kEQLim6Fcez8cgtrjpovWqFgl0KyRglGxUpW1OfjERxOvqobXr5t8sVWHBR3u1BgtWgPC0AvfwSu3tENpIJXTBgS9un0Bcer0eLfB54l6z12Cowi1pRkwVzlGulKjKDGqNAfsM+9aw7AFhXhO9qUp7vuGwHu5aNJcycrlA3NqIDLhczrvEupRweSNr+7prMhN1OFc7RW+iRjK0efllKfc3z+gL55Oy8HLfnT9crg+eZdrSTCXbbxyRO0rOQ+jMY2XqjxjXxq2Dbxuop7q7Pc1FlCBnA4YY1Mquqj7DNFTXLFF+QcyYW3f6CoW4D9IYipSLj6ymWWtyPLQanvyXxvdAqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlM0TnI5Y0x2MXhJdUphSkF2K0UzdUJvQmU3RVBwd1dZK1U3aSt3UC81VEto?=
 =?utf-8?B?YWQ5VEQyR080SllieFpQMWNIcktWRWp3UmVFVHg2U2ordkhrZ1lZWk15MWhq?=
 =?utf-8?B?d2hkdkUraUd4akgvcmR3VXFPWHlqb29ubkJrS25SSEdRRGdrQ3pxSzl5Wlgz?=
 =?utf-8?B?ZjdIdlhkK2RSRGlhNUxNTWdRRG95bjU0S21LQ1hFUDgxcFZmQ1hHUHBtcVpq?=
 =?utf-8?B?WnQxYlhhNC9QOVVZbllPVjhlMXFTZHRUc3c2NUdKeEovMmZ4Yzk5V1BTNFlJ?=
 =?utf-8?B?bFpvYkJkelJlMDBWWXY2bm5UbCs2UHpDQzdPVUg0N0V3SlBERE92WERaVHdq?=
 =?utf-8?B?NVRLUitMUzdicmxuanY4NWhCWSsvY1MvdkxMaC9ZSEFUMnYxV25UQ3NFWlRI?=
 =?utf-8?B?Y2trZWJNUitRRUtYOGM2bzlkTVpZb1lKT2xkR25aemZYRk93ZFdZb0ZCaEFt?=
 =?utf-8?B?VndsSktaV1hCUkw3ZGpZWkRRQWhLb25CU2d5RXBhSFJOd3haNFpOemNFSzMy?=
 =?utf-8?B?WUNzNVNqUGtCM2NnZDNuR3ZXbmhGVUdDRXo5WDU1S0VmL2tQRC9aRXRjbFEw?=
 =?utf-8?B?VzlURlVxVHoybmcyc2QvNklwQ3JHV1V4cW93VmhiZnZlNy9ReExSb0dybzVK?=
 =?utf-8?B?R25SWlZzd0pMR3dsSmtPcGYyREFhV2hLSHZRSUdGdkZMS00vNm5MYjdUdFBN?=
 =?utf-8?B?czRzWGVtQ2pEWCtCTXNDQU5BNEJwVnRyRTVYQ1llcDd4UmdvcjE0ZHJXSzNS?=
 =?utf-8?B?N2tZRXBUc1dvV1dGSXNMVXNNQTRBYjhTQVlBQVk2NVkyRnIyeWNzZXZiNk5w?=
 =?utf-8?B?U0tJSjFxV2hKWXZBSmtSdWR1UkF0KzJKVGlsWkZGL2IxOWRVWjJFVlNoTnNE?=
 =?utf-8?B?Y0xySzlHblc0TFlrdGIzZjZLL3lxaVBiQVdtUmpDRytaQmJtY1lteUVYeVd3?=
 =?utf-8?B?MUM2QmxSbWliNmpiZEJMSXhFemJ2eS9NVS8xWEJhSnBtZ2NON3Y5dmplMEx4?=
 =?utf-8?B?UzhmSXN5UlV2dGhQZlozeDdwaCt6QmIrWFpvSHBDcFdySHMvQTZ4SDcrNDgr?=
 =?utf-8?B?M3ZrS3pQazRQUFNkZ1V6eDRmd2ZuQVJZRXphZEEwZXJMZEFtRUhDb0VGSU1j?=
 =?utf-8?B?Q25MbnlNb3dGMFQzbDhjSVJjcXF1OW5wNG1uRytBS2FpTW1YTExjdS8xZnFq?=
 =?utf-8?B?cUVnUHVBRnl4aUFqaERrdXFSV3ZublQyRlZ0ZHVFNStDNWhsaWI3ZUE2enQ0?=
 =?utf-8?B?bXdYaStBMmZod3FlemovaEJncjBtaVVua1V1N2p0NDlnby9Fb1ZNQ1VrcDFY?=
 =?utf-8?B?TEtQT3NucWthTklja25jVS81MS9maHhJKzZhRTdyNTJod0hMVDZHUDB0OHF5?=
 =?utf-8?B?WVE0d00zejJCRHlEZDhRN01jS3J3Q0MvNzMxb0JGdTFOcitWdW5oQWVWOUFJ?=
 =?utf-8?B?RTJmQ2plSzRhejZiYnpySXVqNTRXTkozZHA2VFhNb3dDQnJlY3BVdi9sL1VU?=
 =?utf-8?B?S1FQZkJtRWxhK09lZ1dab1BnU2twNEJTT3FsUzBubW9sUjdoandtbnFzRVpB?=
 =?utf-8?B?YXI3Rlp4YlRTdmtYMWt6WHJDTXVxRG9wYlNyM3VobXpQRlhmRUVwUGZBKzRn?=
 =?utf-8?B?b3JPZnFkTjNoY3gvSEVER1U5ejd6THVjTTNSQjlmV2NLWkpLaU82WG1EbUpo?=
 =?utf-8?B?TW5RelZwOCsyMEhmZlJmVTU1NUlMb3NDOGtid0FiblBOaGhqMENEVWtQRUhj?=
 =?utf-8?B?U1EwYzhsS3J4TkRhTDRhOHBHS2RGQkcrVXIwS09Ld1RVaUtXUUF1YlpYT3Ns?=
 =?utf-8?B?a05RbFJpa2x4Z0Q5UWEzK1ZFaTZRLzBoZjNVdmZHazlZTkM3QXpnU29jWUxO?=
 =?utf-8?B?SEdSU1BZT0lFTHVuZUZLS0xXTlA3UFRYQnUyelprM0ZKZDhJR1piNldUSU9r?=
 =?utf-8?B?ZTVyUkRZZVZ3MDRBZHo1UXlsRmU2dXI5c2EwTlNBSitHMDZVN3VzSks3Qjdt?=
 =?utf-8?B?QkcvQ29TcFB3ekgxNGhsMlBMR2d3T3lOeTlnTHpHQ21TdUVNZURYbjJwVVJP?=
 =?utf-8?B?Z2hCUnNmVFR6RVdOblcwMlhEMkZWUTJUSmVuTWhZM3A5dEV5K0NGaWY1ZDJ0?=
 =?utf-8?B?ZDNyRjhTSXJVejRBL015V0d6RkxVa2JZY0Q2RUFYVjZIVHZxbGVyRmFoUklW?=
 =?utf-8?B?ZFdaYU5mT01QcnpvRkZqSmk2QlFCaHFheXc1bE1pem9OY3pkbDg4U2YzZnZa?=
 =?utf-8?B?ZzdjbzJYVnFvTFVZZk4vR1RKRlRVOWxVTEFFcEx3SUxpcFlKSG12M3Ewa3Bl?=
 =?utf-8?B?NklYdDBRSE1QZy9ZOU1KN0gzMkFJL1FieHREOVZsV3Bjemg5MUttUT09?=
X-Exchange-RoutingPolicyChecked:
	QEuYsXC5ujobwlenfhEc0uLxDnBd3166AymSTW2Dq0hqipzSUTRXgH4viCCOMBf2Pm7xJZMpuC9aeJVu+V1EpsI7rYw7K0DPgOrck71XslrUUBcm7lc7j7xMp4Y+Xx3RWCXjEO1U9Mw496hMgIoV9985ThZaXiKXGj/IcR64cIJikec7TUsyJVlZbE6CNn7k1a0E5XpqBMmszn8VfIrN1q/mXC4g3x3C7rrRPkXOCnghnf6QoJPSVxHBk1C/H5KZuQVuIUJX3Es/PBoS6wIh5WicHv2mRgF2I3GYHbtu8PjlZO7WYrA27x9v/D8W6TN7L1izfUgrhH23Jc4oBQFr5A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RT6u+XboXXRUDkE+r4h4/CDjzodNb+wHH1eABvodEAGlpaovMYMasGLLTB4hybXYTpAcveickBlyKR8pBC3MbBJ5RRjWbGw4+CjKhERM8GvzLUh6QxYmEDowMRyN808b2Z+LnJp2s/YBF7h7bVRcskkgOmQuQCQxNBHdL+vzI3/6ZkxMlcUku02ULdJs2f/3xR3wGcoLqTz0++prHfk57hbOyaVQMNWlA/dRO2QKxFg5JJmJftMQ91+jUd3B8pKBtkaz/U1+CUxARZaF0bZ8KT62rnRCiPBcNQawQDuhN12O78qr62WShooDVkCckTh6BheAeQ7A5OHQCJdU3yEpaoGS7QIO75OqjnVgLSb49OABqQ/AKYF9h3dHQtkuio3I9ijxJ2it8+A7lyUxrdnkD6YF4CyhhAvVdpifMLN3kfK0Q+iDYwrazCYSfKvruUm3aIxh26uVNyu3CinK+OhACBuMDcWTfQi9jni5InCqco1WJIyOQsTp2S6Upy4qGLGU1bLcgag5KUjkKicfflfuc9OjrhOknHavl3HYSMIlaibvEg3MtxtH8IqI6ADPntVIVWPg9FPWMRkwhEaKW5nSEFx5CbDergGr9KNxsaqiJSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f2030d-3742-4885-a12a-08df076eb260
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:46:53.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vo8FCaybggaZjUC3OfaDHehLRj0cwItnY1xTzkJHFTw+Xi60X0dpXfUWX9/Pr/HloKbY7liI/azt7a0OA62wyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608310127
X-Authority-Analysis: v=2.4 cv=QoJuG1yd c=1 sm=1 tr=0 ts=6a9593e2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=pGLkceISAAAA:8
 a=1WtWmnkvAAAA:8 a=_CfdQ4IUX0dWEPTybGcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1yVbCGJ0dEyrqfJ1rcQXdAD2Ndl8ikEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOCBTYWx0ZWRfXwy5fY7/Z003s
 2Rq+me+V6sEBPTSQsYMFzIIOz8Wu7UKjsScxsbj25OhO0lIsjM7A6gCNQe7HBl8ONYXDVktYuV8
 yNTLlfCSRHT7/G7B8iJnLyQycf63cu5Xy9s7gpdUSQYQaASwchR5a7TdbYcy4dcTp1INF/I2F8e
 4wikhmoN7p9SZ/AepH+VZAC0x/V6LAl1Iipnqm0BEjmg2oXE4rKOmQxZrdwGv9dxNEtlbnVrTA+
 QEHxGUtG3JEQ/ONYcpDowgQfFns7f1AqOMK1uEvJ68jrGgf6JADBgq+gTO6oSLIqy+vzpefDD6O
 aOMNiuBP3x/50quoRysjzkv7BiAH5xzKgNXgDQ4ffDm1z8mjpNwVZP42DcMy8f2f2jGacWIb50y
 kRmufzlCdtsjk8jL6MQ5SG0jlxEMV9yt+bPaOhgXlNs9O2uahYO0Vwd9E/vF+PmL98H+wG2Kuf6
 X10szBLXnLTedcHX9Fw==
X-Proofpoint-ORIG-GUID: 1yVbCGJ0dEyrqfJ1rcQXdAD2Ndl8ikEr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOCBTYWx0ZWRfX74IVERc1yFr5
 iIyUdGDhUq3WHka04K8YJnD1zmPd6+N4wXlK6RHOL9Xj6BCixe7q4PwJS4+roC+7gQEX6cGeFc9
 acKIDCE8h5bN3rEw7sP/iCWC08MhoBC0Tw4ItTam216UDM7ia+Ij



On 31/08/2026 14:38, Fuyu Zhao wrote:
> 
> Add btf_module_names and nr_btf_module_names fields to
> bpf_object_open_opts to support selective kernel module BTF loading.
> 
> With btf_module_names:
> - when provided, only the specified kernel module BTFs are loaded;
> - when an empty list is provided, no module BTFs are loaded;
> - when NULL, all module BTFs are loaded as before.
> 
> This avoids unnecessary module BTF loading and reduces BPF object
> loading time when only a subset of kernel module BTFs is needed.
> 
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
> ---
>  tools/lib/bpf/libbpf.c | 117 +++++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h |  24 ++++++++-
>  2 files changed, 140 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 514e4e9daa82..e19d0afd2592 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -779,6 +779,9 @@ struct bpf_object {
>  	char *token_path;
>  	int token_fd;
>  
> +	char **btf_module_names;
> +	size_t nr_btf_module_names;
> +
>  	char path[];
>  };
>  
> @@ -5803,6 +5806,103 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  	return 0;
>  }
>  
> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
> +{
> +	size_t i;
> +
> +	if (!obj->btf_module_names)
> +		return;
> +
> +	for (i = 0; i < obj->nr_btf_module_names; i++)
> +		zfree(&obj->btf_module_names[i]);
> +	zfree(&obj->btf_module_names);
> +	obj->nr_btf_module_names = 0;
> +}
> +
> +static int bpf_object_init_btf_module_names(struct bpf_object *obj,
> +					    const struct bpf_object_open_opts *opts)
> +{
> +	const char **names;
> +	size_t i, j, cnt;
> +	int err;
> +
> +	names = OPTS_GET(opts, btf_module_names, NULL);
> +	if (!names)
> +		return 0;
> +
> +	cnt = OPTS_GET(opts, nr_btf_module_names, 0);
> +
> +	/*
> +	 * Allocate one entry for an empty list to distinguish it from the
> +	 * default behavior.
> +	 */
> +	obj->btf_module_names = calloc(cnt ?: 1,
> +				       sizeof(*obj->btf_module_names));
> +	if (!obj->btf_module_names)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cnt; i++) {
> +		if (!names[i] || !names[i][0]) {
> +			pr_warn("invalid kernel module BTF name at index %zu\n", i);
> +			err = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		/*
> +		 * The list is expected to be small, so a simple nested scan is
> +		 * sufficient for duplicate detection.
> +		 */
> +		for (j = 0; j < i; j++) {
> +			if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
> +				pr_warn("duplicate kernel module BTF name '%s'\n",
> +					names[i]);
> +				err = -EINVAL;
> +				goto err_out;
> +			}
> +		}
> +
> +		obj->btf_module_names[i] = strdup(names[i]);
> +		if (!obj->btf_module_names[i]) {
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		obj->nr_btf_module_names++;
> +	}
> +	return 0;
> +
> +err_out:
> +	bpf_object_free_btf_module_names(obj);
> +	return err;
> +}
> +
> +static bool is_module_btf_needed(const struct bpf_object *obj, const char *name)
> +{
> +	size_t i;
> +
> +	if (!obj->btf_module_names)
> +		return true;
> +
> +	for (i = 0; i < obj->nr_btf_module_names; i++) {
> +		if (strcmp(obj->btf_module_names[i], name) == 0)
> +			return true;
> +	}
> +
> +	pr_debug("skipping module BTF '%s', not in btf_module_names\n", name);
> +	return false;
> +}
> +
> +static bool no_module_btfs_needed(const struct bpf_object *obj)
> +{
> +	return obj->btf_module_names && !obj->nr_btf_module_names;
> +}
> +
> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
> +{
> +	return obj->btf_module_names &&
> +	       obj->nr_btf_module_names == obj->btf_module_cnt;
> +}
> +
>  static int load_module_btfs(struct bpf_object *obj)
>  {
>  	struct bpf_btf_info info;
> @@ -5825,6 +5925,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>  		return 0;
>  
> +	if (no_module_btfs_needed(obj))
> +		return 0;
> +
>  	while (true) {
>  		err = bpf_btf_get_next_id(id, &id);
>  		if (err && errno == ENOENT)
> @@ -5867,6 +5970,11 @@ static int load_module_btfs(struct bpf_object *obj)
>  			continue;
>  		}
>  
> +		if (!is_module_btf_needed(obj, name)) {
> +			close(fd);
> +			continue;
> +		}
> +
>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>  		err = libbpf_get_error(btf);
>  		if (err) {
> @@ -5891,6 +5999,9 @@ static int load_module_btfs(struct bpf_object *obj)
>  			break;
>  		}
>  		obj->btf_module_cnt++;
> +
> +		if (all_needed_module_btfs_loaded(obj))
> +			break;
>  	}
>  

I was looking at the selftest in patch 2 and was a bit confused as to why
specifying just "nonexistent_module" in the module list was a way to test 
the scenario where we fail to specify a module that is needed ("bpf_testmod"
in that case). I think I see the answer here - we don't look at the module
count and check it against the number we asked for after the loop completes.
In the case of "nonexistent_module" our obj->btf_module_cnt is 0. Since 
all_needed_module_btfs_loaded() will evaluate to false in that case,
we keep iterating over BTF ids.

On loop exit shouldn't we check obj->btf_module_cnt in the case we asked
for specific modules, and make sure it matches the requested number?
  
>  	if (err) {
> @@ -8508,6 +8619,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>  		}
>  	}
>  
> +	err = bpf_object_init_btf_module_names(obj, opts);
> +	if (err)
> +		goto out;
> +
>  	err = bpf_object__elf_init(obj);
>  	err = err ? : bpf_object__elf_collect(obj);
>  	err = err ? : bpf_object__collect_externs(obj);
> @@ -9629,6 +9744,8 @@ void bpf_object__close(struct bpf_object *obj)
>  		close(obj->jumptable_maps[i].fd);
>  	zfree(&obj->jumptable_maps);
>  
> +	bpf_object_free_btf_module_names(obj);
> +
>  	free(obj);
>  }
>  
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad571540..1cabf7e46554 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>  	 */
>  	const char *bpf_token_path;
> +	/*
> +	 * Optional list of kernel module names whose BTFs should be loaded.
> +	 * nr_btf_module_names specifies the number of entries in
> +	 * btf_module_names.
> +	 *
> +	 * With btf_module_names:
> +	 * - when provided, only the BTFs of the specified modules are loaded;
> +	 * - when an empty list is provided, no module BTFs are loaded;
> +	 * - when NULL, all module BTFs are loaded as before.
> +	 *
> +	 * The list must contain valid, non-empty module names and must not
> +	 * contain duplicate entries; otherwise -EINVAL is returned.
> +	 *
> +	 * This affects:
> +	 * - BPF CO-RE relocations against types defined in modules;
> +	 * - BTF-based resolution of attach targets;
> +	 * - module-qualified tracing multi-attach targets;
> +	 * - struct_ops kernel type resolution;
> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
> +	 */
> +	const char **btf_module_names;
> +	size_t nr_btf_module_names;
>  
>  	size_t :0;
>  };
> -#define bpf_object_open_opts__last_field bpf_token_path
> +#define bpf_object_open_opts__last_field nr_btf_module_names
>  
>  /**
>   * @brief **bpf_object__open()** creates a bpf_object by opening
> -- 
> 2.34.1
> 

