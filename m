Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9032C3264DA;
	Mon, 28 Sep 2026 12:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597741; cv=fail; b=k2WrUMcnLbpVTUHDEDigRvu2eMuy2QUcYy/tc8qhkd8BZHjYc//g660ohNhjrAemCX4g7yTutmyct3WF2w4qSmb/2b2rnpN6PwiAeoO1Btx3C2WE/Z7kIP5LM3CY7eaWvZjzNvPnL0GhUSqOUNWUnFBoejpNXjbGFc9+OiBx1xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597741; c=relaxed/simple;
	bh=Bp9AsiTcgWv6uB6FkV93Y/qkRVhWe1qMjH8Np2s99NQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gmWTC4wiTtoPHGf0/cPztFbo40magcms5nYHnxX1yTg81Bt4DCeEH0DFnna2Lf/j6MfqItJDvjNY8z2P5wYVX7suIlzciJ+yAlbHoEOTDxXCGu3Hgh+hXcsO0XbN44KuKGs2xl7VdCyArYKIgCm418TSxbovFYx1psN8hxUQqjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mP63DARx; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mP63DARx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c7GlezqunsWO/uP+zQnnAuRD4gpykssQFkDHFf7cnM6ShhZ6iL/bWxkcnFjZjJo53IWG7sG+Ptb10OT5FltDilSmG416vENwmD8PKjF1oivxjhD6IswsuMqEFfdf2sjEbKFoCxOqk0V1MgjgZAPxio7RcTZfuVPp+saWqJyDPrV0CAY8euui2Oq2uEVByzZyGoY0pFSt2g2+niWwXAbQk8yMmuw65YKsR2cuLwdJmm5mtnBLGb/zeWcuSC7Rk+7i8cV3fcjmcWmJnP3bFvgAhPsJLf4VOx25tvITdr+a3s+QgJCVi/8niwGK/WP6u1OrsGnJR7MNSH9mpB0wX9Au+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWJGBl0spfyREv7iLaNU1REx/UGjzzjL2GiEkjcwQ1s=;
 b=cVsVOKz3vj4bBhmUs0M+z93ADbr62WuDwqc+jr5bTxXsb4tjwYFcVh2Ww6+006J0p2DKsRAOhVdsjcRPiTa8r57XaBbNsCICSw6xYYMghymvprN4qdhztYOjR8iVjDVKIQjATNKcEBo1g4UjpC5ACFhhBDS3jYJp10bBRKXDEY321aZZbpXhrIQzNiOAoYRApwgL+RR3XZMj7egY+0A9xYZraVxnS/okzFpgtpz6ATlyStWzVOq9BD/PfiAHICCQeGUr8/wfXlYz/GAuYPxsF2cDdG8brX5aYZzvT2KJwaFlwaHjg1Bdi0JolY0VEtgF2hVI27tkamIvgQWKYGi6HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWJGBl0spfyREv7iLaNU1REx/UGjzzjL2GiEkjcwQ1s=;
 b=mP63DARx1hwMNbxNACUYk6WdXc5MMvNw6yOVMU6a/P9S8kVjtP8UcBLRn6cSOXgZou2AdaVmI+yaybKlORVNyDYq4GgYJY5Gbu5Q0M31eQ1hV1QrLhZYsdRpqaK1fOCg739UzWxgGFHfYcMg9+Xi46WDaX5Iwkq4671w3hbmY+Sx67UjqUK5KGibLpVlH4ZvOSVsTZ/X+pkW2XeZzoWgk2PC7Kn2XbgACPPrCbda5yGZdPlBxfkxXWFsjRidROjeRx2z11H21n5s9pM72sQtkWHd/MQh/3vY8reqY/g2g9KUcn+BbHWboNUa3zEhh6MKK2pk/wkC2uQpi6N+U5NQiA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 12:15:36 +0000
Received: from MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e]) by MW6PR12MB7086.namprd12.prod.outlook.com
 ([fe80::4eb8:7fcb:fe8d:e95e%5]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 12:15:36 +0000
Message-ID: <2d2f2ef3-1d96-4ee6-b765-b61f214c57b1@nvidia.com>
Date: Mon, 28 Sep 2026 15:15:31 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix AF_XDP TX timestamp teardown NULL
 dereference
To: prathameshdeshpande7@gmail.com, tariqt@nvidia.com
Cc: saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com, sdf@fomichev.me,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20260926165402.5902-1-prathameshdeshpande7@gmail.com>
Content-Language: en-US
From: Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20260926165402.5902-1-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::17) To MW6PR12MB7086.namprd12.prod.outlook.com
 (2603:10b6:303:238::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9fa137-a9a8-41e7-d169-08df1d5a33f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8UKTQlUFhEp/uahYTjPZr9f6Pm90TaJ4kUVcy2x/lbpkm7gtnOb/PvLf+kgyQtIfWWDKgNw+/xF0CtCu14e2fmm6/BzUgB1Do5JlmZFKbPQCzPCu2NoYsLDfQApaiexNBuSIScZOzL2SMCMOykbnMPkKqAlEeSIaaIMiuj2xDM7jL9qWN62g13xcb40T+7rrzYkHXZscFPXtYRfFBgKXS0DlKphLi6QXOPZMLoLcQ8CY42B7/T2smg+/pP1OE2sFYqLw9Wzl5diWewk7hJzsL0o8HM2wpvMwsOm04F5gbXPei1nwQYxrVIaw80vsgxujXQvi7ztT87vWzMB6Z+v22fn5BjJppRN+YY229Ja5lYV7Ja/O3NDr94Y4ij5XeJy/IBHHIRYS1eDs2PPZOT7ynKLuye3i07empLsAkpyNynPHkC3KH+Fx/nMfRqPc3pxdYX0WCV0K5oJpYARlaLefs0sxR6v+F8lAWzBQOLdYAx2FJLtyS4FEemhIh0mfwrCNQvTiNELTfjKKXz8DXLOwsNOFlrneVFLWp+OPzyEW0VuPNUCJchWV1nzWGVer5icNPMzhB/cnM/Ff9uyVju8YWDdn/Calvq/0bTyjTM2tsB1ZwxLK+Fn8YbA8ioRNJpB45uUN4pmfhuJbDGJBgfFRCF0Nze1UXcoMUQYuEJHWOV4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB7086.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHlzVm11U2Y5M09rNDJUcmcrTHRyRmVMYzczNnRxazJvYk5EREFaenFraSt1?=
 =?utf-8?B?QWlGSWNuSzlDUXZrQWNpQ1FJM3dsWWQ4cWo1elZvVmtHMFdmNkl1Vkk0VE96?=
 =?utf-8?B?d0p5akZJdHlidkZIVzJXMTFVWjNPOFcxZUgxb2pNUFJud1dodGdPU2ZJbTBS?=
 =?utf-8?B?WHc4RzRvM1JYZk1KVEQ4OWlLUWJlRExMbTc0K1RyaGFMQzl6OE5hNXhTNUFx?=
 =?utf-8?B?QXF0QXp0VVV5aWFUUTN2a2VjRnQyanZCUm9UNG40Ty9yb3ExTVUzN0d4SU0w?=
 =?utf-8?B?MjhCcTUxZHpBSnVQelgwbHh4OE1qc25UM2tOVC9sL0pEYy9uaG01anJoK3VK?=
 =?utf-8?B?eXNSZHpEakZqK25Qays2czl4aHhJc2pKNDNnVlpQb3F0cVYvd1dSUlZNVFY4?=
 =?utf-8?B?ZWphSGtjZ0pTUGdpaUFCbHd3WGt6MDdxR201Y3QyY0oxNGhEM2FDTXFGZXQ2?=
 =?utf-8?B?Qkp2akhyM1RONDRuL1JITk5FMy8rSnhycU1abU12UTJLb2JqQS92bzlWbVdB?=
 =?utf-8?B?Y0Y0eElyVlRUaWVvcUJNTmtKVGV6WHd5aVZYTGFvT2hmSTQwN25tbGJhZjhC?=
 =?utf-8?B?WFVlUkdqdStZT0NTQ1VJYUQzbGEvaVJ1ZEUybjhyTkdMRy9uK3N2RSthSmR2?=
 =?utf-8?B?NHI1L1VVOGJTQVNjRDF1V3VTb3cyTFNOTEgxL2Z0a29NVU5kb0JsMG13NkI2?=
 =?utf-8?B?dTZqL3Y5MzA5dDJsMkdLVS9iT0dyRm9FcExQRVd6UVAvd094ajhmWThlb2pi?=
 =?utf-8?B?M2xuTGRyM0pmV1NBZUVsSE4vckFxWGtLU0N0SlRlbUFGenovZkpqNGRNako0?=
 =?utf-8?B?RUxES3VHdjA5a2RXend4MVJrSjZ6Mks3ZERDMnViNFJXWU1JUmEvY1VHSTFR?=
 =?utf-8?B?bWhWTllXaHZUdUwyeGZ1STFXVzZUTjVSU0FSSG5EdGNhYWgxcDhHdjZWUWU5?=
 =?utf-8?B?Q0JxVjYxQ0sxS1ZpTnI0MGJ1ZUNxemJTRXFidFg2cGNiQTBLLzRHSDBsWS8r?=
 =?utf-8?B?WFA1c3Y2N0FHZGx5RjNGd2cybjRNTGswdDVPRW9PVURkaG16RmNqNkV4NXE1?=
 =?utf-8?B?WmxiZlUzRjJJekgxdGRkT2lhc3VPcXl6aHZmVDZheGcxSGFLSlNWQktOUkta?=
 =?utf-8?B?VGREYVFjQ2lXZGQrQ2VEdzdzYlNWa0Z6ZFpTYUE3RmlrNEprZ2hEeUJ0VU5v?=
 =?utf-8?B?RkhlMVJCbzM3bXI1andLYWJkMVBxcXd3cWNLOWlMWFhNZlJkRk41cEpOMXRY?=
 =?utf-8?B?Y3JDcDQ5UU1DamlCNmNUOGtDTklMT0ZpTkpMM1BocEVnZDM5bjBPWFNtYlN6?=
 =?utf-8?B?bnhoZFBUU2Q3ZTREbEdSYkRGK0VFa2RJZTdQUDNwUWlrZUtyNVF0MlhaZ3JB?=
 =?utf-8?B?Rkg1blU2YWM4ZVptVXcxVHFhc3VMNHA4MnRjTDRRaXR3clBRM1RyRW1ZU3FC?=
 =?utf-8?B?S0ZHUHBsZitIMzFBTnJXTnd0QStOLzhTWCt3dmNEY0NpYjcxMnhreVNHbWFh?=
 =?utf-8?B?UHU0RVlBK29IcFlCOU0zWXIxQU9jdmlWV2ZmZHd4TmdYYmFKL1FBZEd2OTAw?=
 =?utf-8?B?TC9UYmYwZytLbE5aeit5bzVZUFdqaDh2c1ZNSks1TklXbUJTYTV0dHVOVVVW?=
 =?utf-8?B?Y1Q5UHRmcEVwb0tIZldyUTBXWnJzZXNFdXdKcFZuN0ZoZU9tSDI0a3ZlYzRE?=
 =?utf-8?B?UUN2WkplWWNvTU9HU09HRCsrTWdZVkJ0cHN3Qjd6bDJJbmF1UC8yRHpRQXJC?=
 =?utf-8?B?RU9TS1lxY09pMkZXc2tsUkNVODIvUndzZnpYK05lZDZuUnlzSGdibTQ1QjlR?=
 =?utf-8?B?Y2F4Umt1VVB1aVhCeVRJWHkzb3lkMVNBcVNrSEl4TTlDd0ltRUkvT0U4M2RP?=
 =?utf-8?B?MnJ5UkVJVGtpOURMUnhhQ0VEdUg5N2x0VG9BYTRoRDZWUTFXT2FSeUZrZ2du?=
 =?utf-8?B?MEJsNVJtb2liL3VPemlDZldkK2JtYWtKR1duM3JtOEJuVEdqMnNldWRxWmlv?=
 =?utf-8?B?b0pwV2htNHZkaU54TGFwRSs0eTAzNVVUUi8wOG16bk9vQU1DYS9YSkFKRmRR?=
 =?utf-8?B?c1BPZi8rY0NKZFJhOVJBNEtzUXNTbG5sS0doeDVURWh0Y2w3bVczVUxGWlZJ?=
 =?utf-8?B?UWVFWnVNSXdjanZZTHpjQUZsSWp1VlUvSGJnMElQVVdYNCsrRlZxdWgyMWh5?=
 =?utf-8?B?VllyS3MrS3UyVFp5dXJXdXNEamZaSXhlR0UzRFRHSDVLR1hlcFlpTE5DdEVw?=
 =?utf-8?B?SkJqK05UU0JhbXVTMFQvQy93TEoyRm81ZlNmTStIU0VSWmxFTVJCSlp3QUh6?=
 =?utf-8?Q?thp6nkXXutIFljTTc4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9fa137-a9a8-41e7-d169-08df1d5a33f3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB7086.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 12:15:36.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uauXwu4WGpBx1Ow3R4iqpMdnQfSLb8Uw+gNESamfUTZJ4CjR/L54dafE2WqrzjILRPx9yJUpujDwPt/+aKtyfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737



On 26/09/2026 19:53, prathameshdeshpande7@gmail.com wrote:
> From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> 
> During XSK TX queue teardown, outstanding descriptors are completed
> without a CQE. If one requested a TX timestamp, the completion path
> passes that NULL CQE to mlx5e_xsk_fill_timestamp(), which dereferences
> it.
> 
> Return zero when no CQE is available, indicating that teardown did not
> produce a TX timestamp.
> 
> Fixes: ec706a860eba ("net/mlx5e: Implement AF_XDP TX timestamp and checksum offload")
> 
> Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 77ea51bfbaae..2cca20e1b9b7 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -293,6 +293,9 @@ static u64 mlx5e_xsk_fill_timestamp(void *_priv)
>   	struct mlx5e_xsk_tx_complete *priv = _priv;
>   	u64 ts;
>   
> +	if (!priv->cqe)
> +		return 0;
> +
>   	ts = get_cqe_ts(priv->cqe);
>   
>   	if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(priv->cq->mdev))


Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Thanks.
