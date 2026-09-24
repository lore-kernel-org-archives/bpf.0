Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4547F2F3;
	Thu, 24 Sep 2026 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260794; cv=fail; b=Gyf5q69uxbusiabrP31fTFsZgPB3FobifFiIchHHm/x/nIBbFUX0hZ3+HKZXwB/Ngk7/CTm3p1OrdmkAEDHP71BF+wUONeJzJXsWmzyfWavZDLfg60bvG351z/rjcAPimFuJtmG6PyTdd8TMbIBE8l+PJ5WtUA86qzn3XeQFhaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260794; c=relaxed/simple;
	bh=4vdCsWSRNO4fVUgpOSZ0Yt+hrGjvFLG+oumkkg2e2TI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=u2xMlEWrUAHhmWojpitbYeEo40IYRf/R7JdmfPbCRHRtWmJuG/EHsydLgpqB8ggyRiGbAsSDzkmH79mQ69julgXjnSNsiFqQLauoYwbOYe5XRqzDhrwUCBOEnq1nTKhqIjVIh/m+G2m5BVRK5jicBfupqkCAoX2wRoqdSMZF86I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ORIYgkxu; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ORIYgkxu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUpYN7V6DYgJVZNlrGZr1Pl6u1XF1rzPB0ff62IBfRVn0Y37Udb0358pDIyTWwP4Bh/IZCK6yLnclkq2dk0zJgRoGOt47WnsEOO+A2uqwd1GMBH+3RbWiPvSOT5gqIyOq1rfUseY70TVK1R9MMDTvMEYAfx3c2BKiIMTXp5jptfyDhlWqQE1FMn9WXKpWPx5pj7X3C4JJT1Y0a/WOZn1e/NnxyPmGAZe9/KJqbXyJdRI6RrK7ONyflcxi4nhh/OamFtP3TZ3Y35FVp2nEjK+4cKvvf+6ko1Q9eIX3YZ25FQQbzSBtjrA0XLjWuQNALon9c6KuDSK2/Qp/cAbCQYTrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLlc8iu00bylNsno0PaT0LGWN2O5yV3agOHdx44iCsw=;
 b=M2r7Je5wGQ4XJpPyO0sZkFIiY1k8E54OOosu5Fj5AobbGfppMTUJxD3cNqn0JlOHLQXTgSq+7g/Gjs2NQ8hoTrVwPI/Ui0I3ocdlO7LuO/vUo7RIlo8E6h12RXPHgwQqLUUeGtRuQYpNc6APi4jXjDzo6DxWSzJ+q4gVutdKdmw7cOlzHIB5FuNnSFK+5YhzVQH6vw0+bf7rr18kQJ3YJGreW/WrVDFJ9fw5iQMALrkeffTGkCZn45vrvuI93HJmutMKPQ66sUehbaMl5bEnXXCiGYV9rZGvOcKLGBK/ku5UC4Ny0Wv3ull0UmYQz5kDbdbkpyDwdGYk4ImhicUw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLlc8iu00bylNsno0PaT0LGWN2O5yV3agOHdx44iCsw=;
 b=ORIYgkxurbxTvLNUPdWsTifvrePWxrcnWStavxSlqjdbcSXnEsgWQe47GdBXQpMRv4XGyLQMDOUzSpdfk0XaRvJninGvHYMJkuHnQfHp9FCMnjbv0zzAfFCmW1NxdcDKShGikLiJOdnY5SZSoqy84WxHg6CY/3EL2daRVfZfUhrW51sW5/Yv1VOCfub01eT7UaTXHAsxHWGV5pNT9UcQNuI+mc+at5DmT2fbeK7hU0ir+DyQ0NTQdoxNBnYaEkn7W9WUtrfMSwi+/5qv3bD27FKMZJ671dJaz3ODsa9zPGqv2SZ2cbX4ZILvIlpW+sDVrSw7i3uxON33l0juvLAIzg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 24 Sep
 2026 14:39:46 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0428.018; Thu, 24 Sep 2026
 14:39:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] sched_ext: Update scx_dispatch_dequeue() comments
From: Andrea Righi <arighi@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com, bpf@vger.kernel.org, bsegall@google.com, 
 changwoo@igalia.com, dietmar.eggemann@arm.com, etsal@meta.com, 
 juri.lelli@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
 mgorman@suse.de, mingo@redhat.com, peterz@infradead.org, 
 rostedt@goodmis.org, sched-ext@lists.linux.dev, tj@kernel.org, 
 vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com, 
 yphbchou0911@gmail.com
In-Reply-To: <20260924130503.853919-1-usama.arif@linux.dev>
References: <20260924130503.853919-1-usama.arif@linux.dev>
Date: Thu, 24 Sep 2026 16:39:36 +0200
Message-Id: <179026077643.1922818.8200549737305665244.b4-review@b4>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SV0P279CA0069.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:f10:14::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: d9e39120-fe48-41b5-23b1-08df1a49adf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z03POJ4UuLFeW+ah1KRHgUrmjSqHduocveC/Hc+D8IiikGD4cxxmo8cno5nNfoEur4ybC81S9AoIlKMGwsQSZTskbVNd7X94Pz+mC2rrwBcRYhaJImwjYsRojiuC35N4JSisj+BWOX0URr4o67pdPvKU8cnZCu/sfaJ2APsHGbQEl1T0P57pxTFekyAQ0K7N6fi15SwUZIGH6dBkv38N4svGaiBgzqLoWnTwBZRrNLsV8nsI/pckhz7a/f8reedx28RhuaAHiucMNWwP8HqmzEI59LS2GK1lj152ssjfXFvrIGhJdNqO5DTtLVty+FRHDhWH3UROOcaZcNzMpNNW7gZ1ff0pt64gKuurJOoC8rpv/ajQtZwXwdXmVSYlXOAHhxL4RLZI3/ZyC5X5HLq9XAqO4b1HTMTDkm0JCzHZuw+wHYtedP67Cu1wuZL8UCXFEO7WA+MC2y5/BdY9hzizj+niz5h0nclTnEMjVA+pwRQykWXIpjgSsS9ud1v0ZPxt8+CISpyESs22eAsFnuMyXlP3TKuGxyN5WBN12sbiluXezyhF4EipatnOOJ1320o+jvzLxvAC/js85NVJB9/aNqPj6GuxBW/vIzZi5+9Jqw1/fDsDNdwehCM0ZLHCdhkVQSPI/qAsO0lj3Am3YkaCDw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtYamUrNDhldENsbHZ3VUhvZEV0dVNYNTZBbFNPZDArY2JNbjRrd01UU2JP?=
 =?utf-8?B?NzV5Q0VEOXN2YzV3VlNSTzlGVWMxTkZEUzVWdGZNRXBVMUxuQ25wMVRNSUx2?=
 =?utf-8?B?Sm16bmtBazdZMys0dkRDbmkzUlovS2NSL3R2QjZEMmpYNlU0TkR3dHg4OUJm?=
 =?utf-8?B?YjhQM0ZmZ2NPQ2xXTktXNzEvVkoyaXhBVW01V2tHdzRCR3ZrR3FlQWpnZ3k2?=
 =?utf-8?B?cnlmZ0hIWEtqUDdMS2ZudUN4MEZEcVlRZUtweDVjRFczb0k2alhHYlE1TTRk?=
 =?utf-8?B?ZGNXdExuU3hJNG10YXIvOHBWWWdQd3FpQzY0QjhOU1gveWROWkFQOVhLTHVz?=
 =?utf-8?B?Q0gzOEFsd2hUdlBNNkxSbno3a0lub2l5WENrYll4ZnMvaENsSVpsVjQyS0N0?=
 =?utf-8?B?SFAwYml0SFpoRGFoL29KNGJDalRaa3gxbnlaaVNtU1U2ZUVqeXBGam9Zd1JO?=
 =?utf-8?B?T29kYXhzSlozSWd1d2lIVFdPRWlOSEdzZXBIR29TbFJUbE9BK2M5WnhKRDYx?=
 =?utf-8?B?aVNxVUx0Y3lLb2NuNU5PbmtBQnRmb3E0dmQwaERJQzBQUFdybFN0YVplNjlo?=
 =?utf-8?B?c3JBN1YzU2JDWXZ3Yks2cFVxN0VPZDYvdTZzUEI0TE9MZG91MDlxRkNUR243?=
 =?utf-8?B?T3pnZE0wYkxDSHoyVkdVRG91UjZRRVM1RnVMdTVRNjROZytBaUdXclBlWGkx?=
 =?utf-8?B?R1NtZGFqZDI5bitLTG02dkpHaElhU0NKbS9ldTV2MENzdnppeHk4K09sQTEy?=
 =?utf-8?B?OFZEZUdpSHYyK0phRTgyb0Q1YlNVS1dTTDUvWWJlOGJoQUw2dWNmTlhhRTZ5?=
 =?utf-8?B?MzhDSXhqTEUzYnhEL3pOVEsrWExQa2J4anpkVUlwMUJLVmY0SUJuUGZLbUFZ?=
 =?utf-8?B?UEJXanRhbktsZTdFZ2VZRXZwUmQyT0RaVi93N2drSVlQT09aY0JHNGxFckdR?=
 =?utf-8?B?bEFPOTVkYVJUaXBCbFZKb29IQ3MySHducmdIKzFVZnp2MEdMTEt5M1lzMDBt?=
 =?utf-8?B?U1A5UnV2ckIrek0waUQrdGs2T2djQ1A0aG0yamZmTE5ZVUVCZjJzL1l3bHlQ?=
 =?utf-8?B?bGZIQ1VHU0U5UEdYdEZpRnNkY3dmdmxQRkdUS2J5cnJjUVVlUkFNb2xBNjZ6?=
 =?utf-8?B?ek5MU1FuVEM1YWt0bUtOZUhHZzFTcFNEQXZYb1ZGc2RYTTdpU0gxOFZnMUtY?=
 =?utf-8?B?Z1FBUFN5Wjh3Mk1waGg4c3Vzb2tZcUkvSjZoZnVHN0FFY0pwazdieUNiR05v?=
 =?utf-8?B?UzArZnNsZldhR05PNlpJWXNqSEhrLzQyWENDbHhhbmJaaG16Ry9md3NjVUc0?=
 =?utf-8?B?STJqTGtBNEljeDB2MFViak9vOVpEQVMxZ29XWUdaVmtFSDR5clRxT2w0R2RM?=
 =?utf-8?B?R0VYWVJ2VkYyQlBWbDRwbmtIeGlObmM2VmZSUk1mNisyVHhUWlRhTUxVL3lh?=
 =?utf-8?B?TzUrb2lwOTU1VWVhN3hRZUhxYUxCaEJQVllUaFpQdWpQS09MWW9Sc0dGSFZT?=
 =?utf-8?B?ZHE1MTQwMTJodTN2SWlaajVKTFQ1YXZLUXZWUUR0N0l0VUFTU3JSU2lMWlFv?=
 =?utf-8?B?SVhLd1ZoU0UwZXhqd2lQL2FZWHkxVzNubXRUUlJMTDJVcXBST1JOY1dEcWtR?=
 =?utf-8?B?QU1XVC9aRDlJUFhpWVZCVDFpWGxIV3ovMUZjUDRpODdMdWEvVmVpaFMrczJj?=
 =?utf-8?B?Rnk5QnNQOEI3SnZTR2loYWVGTmlzMVN5ZkU4dHgrL2F6bXBTV0RSS3R5ZkFm?=
 =?utf-8?B?Ymdxc0RMUVoxaE5RTVNPdWNHS2tLNFMvRzU5WXEvTHFKWnA4MnVzblNqSVJl?=
 =?utf-8?B?aXAyQ0xzTWtkeXM4Z3FzQmk0Z1g5MXQ4Y3BEdFFaQmpHcTZkU0NjZEgxcDl4?=
 =?utf-8?B?ZXB4eVBYVDF2aDN2Yys0NHQ1Q002NG1ic3lQRCttK1dTeHlxMnNxNGNhTUVi?=
 =?utf-8?B?ZWVicEdqUHZ3MmVCbVczZ2VTbjVlQjZYaDFiSmtYeTJSQms4amxHQVZzcHRP?=
 =?utf-8?B?dE9SNzBCcVJzTVFPNUp1OTg0T0xLc0tPNFN0WFU0YVgvWnJzTlpmdUZ6RjJO?=
 =?utf-8?B?T3lkNVRsODNkdVBnMS94U2J2b29BUE9ucWt5c1VzeCtIY0oxN2FLTEVKWDRQ?=
 =?utf-8?B?Ykw4N0MxK1RFQmxTd1VpeExIOFM2dVRvZStHVkE4Qm1uRlhJTkR3S3FBcG1Q?=
 =?utf-8?B?bFFVRE1PaW4vZ2dYVTljL2hsdlBpYzhxOWp6QVovQkFiVDA2ZTA5ZXZhSEpO?=
 =?utf-8?B?aW9iVEhMOU5pOUk5RzRZSVlkQ2FvZTZ6L2k0RmJjUDMzSERzbkVjbTg4YWV4?=
 =?utf-8?B?MUJjUkNIVmxRVWZiRW5yZVRFREQ4cXpVeDJ3eXJXenRKeDhnU2tJZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e39120-fe48-41b5-23b1-08df1a49adf4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 14:39:46.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIc7mOvqsY27QX8gmTtU6pgEiHT3qwvQL4m5WIbvk9GcH2ngGEGqjitS+O93edfybnnLeLaYaJv1Ute1wwlWxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

On Thu, 24 Sep 2026 06:05:03 -0700, Usama Arif <usama.arif@linux.dev> wrote:
> sched_ext: Update scx_dispatch_dequeue() comments

Reviewed-by: Andrea Righi <arighi@nvidia.com>

-- 
Andrea Righi <arighi@nvidia.com>
