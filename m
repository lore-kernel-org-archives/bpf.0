Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAAC34389D;
	Tue, 25 Aug 2026 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787637129; cv=fail; b=udemgWfvcU7X/5pjuqLpEdrrs/ZLrhScbGzBkQbOpd1/Yg3lMxleTDXWVxT8oWBCNPC6racsKK8EKB+eVsemqOFKfaprYFRrNai7c6NQX66zd3WQd4rTAFpn7BvhZl5zvmY9jRhbnbcz8mCWpI00QDEBGoU2HBBhfQR015xult4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787637129; c=relaxed/simple;
	bh=IrUIob51D1Juc9sBW77wICSK+FtYksjSzyUYM4qbYxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YXI1bqTMNmueL8WhoRb9jVKrFCe6C1TRCfXZrB27lIgLXBXoofdMUv8pTAgzpjKAdStKYtLDPhF1BANlaEMzHXoqx+n7wZjxtRLjbMVWjyTHSEbqy6c+9+xmPTvaf0q4PpVyNvt2O57pGPuPruQnY2921/mf0evHd0Lhlwlwtd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVT/G59G; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVT/G59G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LpU6KX9AGKF0Tr56I3weSl23PKL5kvyGsjpSDH1aE6TN//6QNkYe5GKXVpU7o0aK6iY1QSrDkBUlL89WhsvPFtAQfq+pzMsEQFYbDT/1rCjXFYp8kldzyROwlzu91mhvRwj18VHmqg9J0P0F9YVmNLFRKruK3CjTiZUuN0MAfrnYMN2vFjzF+qTzYaKDPhvASDtlbkATFrNRBUtBBRY0vDGE4lrkooJa64RK0nZejGkAcVKJuzhi6OL708Q/0+HIIZ2etJvmNcIQgK3lL+4YK7460mBPlhql5E8jl4ems9J2OqjZU+u+4RbTFAlvdLI5at8YmP8nn8dCWOvlbV03Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxAcs0YqUVqLT4vemcmHrfvUxc53l0rFGjflMsSIQzo=;
 b=tJYzlKlhwmExR4kCREP1FQu+9suijCOB0YvdjYHnTHYxdicY/ZBdsaX528173fyzF6XT+cQGPZN9u137Ih3Lcf4etFvJ5HOzTNI+lXxE9be+OAR4EAmA/JqALpPP4ILAvjFM+l7CfwBrTqGff6G1FsGP/owyUM1eH6JWDl48RIq53pk5pxt1VUF64IP9/lfIU8Ib7yL+jp2S8z0Bb5lKqiyQjOuBHr/zvaY69qIoADPOwVJgqG1E/S7eUt6mO464t21XbjQ6br53okqr7QniaZq0ZTWtb67GpeebCrPPTGCJcXdNruHDssVe2mWVnhrTMVLPPYkUlhpfCbIhOEmS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxAcs0YqUVqLT4vemcmHrfvUxc53l0rFGjflMsSIQzo=;
 b=XVT/G59G4u9iKUhZgYOLSaV3ZZ0PE+GIE4KhMdX4/IvCuBUDA1Wvf3ePVw01fPVRsbBSPcqbcUOe0PGN2pn/yy92JIvuyCZlt4EgNCNZ31vCepDJ4FLoMf5BCA6329mn2J/z6DfLLcKNWmT6FEsATNncynN9eO77ezQLi8cNfk5ILnHRWCJbWDqLSfzT9BMM+agycxyCJL2dky9RwnM4gpKp8HRDwS158f8y85LsLairfCbNFik/fVo4QxC/H/SDOKnLFmlq+sr2OGtO2uqPL0g03KmWdQnSLwVmTLxJn1FVKWiD6qjJ2mTFryDmmpiRwNA2XEEHTViJff49uwe9aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 05:52:02 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 05:52:02 +0000
Date: Tue, 25 Aug 2026 07:51:57 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v3 0/2] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
Message-ID: <ao0tfbNNcs514WgU@gpd4>
References: <20260825023557.27881-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825023557.27881-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI1PEPF000008C7.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::429) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 772aabfd-2d7a-4983-1f65-08df026cfc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	We6G8qxfcbvtmo5i1Yn5/PO4L2rv2baY4qGia/eVLRdHZdT9FIciCpT0xl/etuo8qauAeei8rM1e/LafJv3dTsPpqB8sqab6HDVHqIWrPKEp/y/b/8AL/mEPuZQq7IA/DKuxptCdPVVNALLUYOATcRWxkBdv3s+CKjqG8u319YSy2TfpHgkKX1gICv2u08ocNrl68bGlAxU//ycsggOWJlDWAdHF4HeUKebplISHWx0Vy2z74bjdynlZ1OwtQVK4hj8rvWJ/SFTAwheKOynFurOjbNW8a7eLO5MYL4vtZbFnq1+hFwrUH+cOEASt1odL6N4vkaPOebIidnvNdxz1aYGwGMO9GSXgSZzxaCs87cVkcG7zm850KyyrYcDvbRY+HYEBj2wTHMTBnkdrPRv9SSD7YKE5pp17v4YVMnDLXgFXNAry4wm4hSv2+XeHsTv0xQWWF9HGJb9nA4MzcZnpYyLgV8YKS4yxmVFR4AXzwUUQLmF1/ccrGVuqwPQsnB2yka/y3npht5uE5wNfgA0dCmy9IHWzUtDQXuHCiLcbZinA2kOVMk2eBGj0jynzyMq5MaET2a3mZHqcc32RcYrpShp54qQ9arbWZP7+tVcQbWhJ/t9wJ2Mw5aVPztjoWzJs6QJvhzSiGPOAs2TcVMHq8zkxtCSqdzn00+pWAz5Myig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OMAXZ29+YTP2KsqnamrWhqoGw3bCtWcZolxfMEuwv03orho8cqGAWjnaPu9A?=
 =?us-ascii?Q?r+dQzdt8HURw8wj9JUnIvQEZfBUMIe1Or3hKfon+6kZErIKRSe39WXZ0TPbi?=
 =?us-ascii?Q?CwtTNl4RVv7Ds7XCdpHoqkqCOY/ZO3hdJ/WXdWdkOCd1zXFYS0Skhfk1gP38?=
 =?us-ascii?Q?7IMdb35vWs/WI6AO39eOZktbjwRhl8r7KWsIKaOmtWOGEPw6KlhyUvh/irEp?=
 =?us-ascii?Q?kZ5lswgYwBuXWG0dLiNWTvpvM0ECgq/CKXdXz4srwbt7Rdw3Vwx4V7KFz4WL?=
 =?us-ascii?Q?A5jaeYlrxreGlqWz/yzEWV4tNL33zOR1BpeuOrMjoeZKrzhd7hGhdv0or3hj?=
 =?us-ascii?Q?S4vAcxr+uIrsHgfY4/q/S9jt9geZWp8/cDsLRXBpcxGIWXCFSwxN78rMQJXJ?=
 =?us-ascii?Q?xU9T2n546H7iryImt6ImzhaeqyxhZUuGuGIN+3tNMAx9yMWjHk+8RJgWFifH?=
 =?us-ascii?Q?khTicvC+/g3ZczHiBcnTqh7GRMvhY7HFqjouOQmlFi5BM61I1tuufFq+UB9J?=
 =?us-ascii?Q?HgB0nxfulBBpzjtVozNsPAb7E/gfUOXA0nqpjDzbJssknoqusVC4BAj1aCqD?=
 =?us-ascii?Q?rwkF9djBfZ1iTSF64/vHN9FVzy+yYxc8VX9OjQ17WYt7mfx4FrzhREBWEz4r?=
 =?us-ascii?Q?cqlTMHOHezJd1hBsl1WcythjReH7nsp5GnY2QevM84ycvgmNHnkDyL0Fcure?=
 =?us-ascii?Q?PgRglTJkquXLiRymWT1TXrI3ZvysRztoMzpe0HCgLENGmBTosCmX4ZosZWou?=
 =?us-ascii?Q?F0Mn5KsRu+S40IpF6dcK1dTnTOpSmT0Kvuk4JDMtI2OwFSyugTv7n8x9xJMz?=
 =?us-ascii?Q?V75+eORf2T+xnWWtHwonHTk4YQb8XzKEeNmAA7oX6hnSQ1J0vKmJ+ZGDiknf?=
 =?us-ascii?Q?DI/YyrK55P158EOK9DIwFagECxZFWaWlTC/x3Kxkt/0NvKpOBPlXjJrKL7yu?=
 =?us-ascii?Q?6y5RWTmzOvK7gNoS6sO9xBc8Z728XTHhQlTwSfHo6o9XTjLPyLELPymVLUiN?=
 =?us-ascii?Q?SpXwinRD2pIaPX0LuxLyE+2fR7O2qXbRlhaSawhMxhXP4TQz8Dod/GmJ2tJW?=
 =?us-ascii?Q?aQkuikbL/dZz/h497vAC6ZrQIRvJyR3sRPuAJRO0/w4gdaf7u8ZB2aUbhjZ0?=
 =?us-ascii?Q?behjlCuMUMKDCFR62FYW+3DmUGoV7WbUQ6i2rEjRVjhqi46+jFJTAVhxuHHf?=
 =?us-ascii?Q?Fb0hGWpVlyeWK9kqQIWxFf/lhTWbmYlEl7Qu3qF+FgcfUtq6oPuPfVWOr5c+?=
 =?us-ascii?Q?aIomVMbwVxVheo2MiR7S+mHwpWXsRPkF2YC/MtKI/yzM3BLVQ8KgZNcQdTlA?=
 =?us-ascii?Q?bWz3JbiX5wpcF/k0zC+ounb8mLB+9C6KthhAJpk4eQE315yFLungZG6D3Bof?=
 =?us-ascii?Q?F/cPOIP6R5ni+I3L/Hnom8RROqwrdppYwFOzlZgVf6ZsyHYzRUsNscMiauqw?=
 =?us-ascii?Q?qE505FMQXjWsGDiy6aa3lVaBDmWR3oP9a5Atb9CNvauAZ+o6gqdzJTNsL1fR?=
 =?us-ascii?Q?dPcBymypuduTvRuP0YMUKtqVmmDEUw4/3ORg6caV9uaYAUFVKEuvpecieIQj?=
 =?us-ascii?Q?wbGkyWFoggx2Qv4Re/x9GFKyGlwFOHgbdMAUxVNpv+KRJ8i0jWto/JX37DEP?=
 =?us-ascii?Q?q29KzQ/G73PT+RwHsV6xa9YM8UFK6L6d8m6d0NFTIoig8d+jcW1dcSdFDb1y?=
 =?us-ascii?Q?Zg+WU3zC75vPs3c76u4SVa0TdzJ02iNP1B2yOewx/SYxfStF4bHeqyLaJwNi?=
 =?us-ascii?Q?2fmqXIxCpg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 772aabfd-2d7a-4983-1f65-08df026cfc3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 05:52:02.3994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfsVRxEm34KEbSKZT35MKBLWpgmYOVxryRafK2psUGww3CiM2JYLy7TrtOP/ZXQZMluc6IqVTwaPB/JZJBh9hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117

On Tue, Aug 25, 2026 at 10:35:55AM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> This carries the initial cpu.idle state of a cgroup through
> ops.cgroup_init(), which was the only cpu controller knob whose
> initial value never reached the BPF scheduler. Patch 1 is the fix;
> patch 2 renames tg->scx.idle to tg->scx.sched_idle, suggested in
> review, as a separate cleanup.

This looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Changes since v2:
> 
> - rename the new field to sched_idle, as a bare "idle" reads as CPU
>   idle state in sched_ext (Tejun)
> - split the tg->scx.idle rename into 2/2 so 1/2 stays minimal for
>   stable backport
> - add the Fixes: tag (Andrea)
> - regenerate on top of current linux-next, which also resolves the CI
>   conflict reported against v2
> 
> v2: https://lore.kernel.org/r/20260824142817.568085-1-cui.tao@linux.dev
> v1: https://lore.kernel.org/r/20260824133954.561956-1-cui.tao@linux.dev
> 
> Tao Cui (2):
>   sched_ext: pass the initial cpu.idle state in scx_cgroup_init_args
>   sched_ext: rename tg->scx.idle to tg->scx.sched_idle
> 
>  include/linux/sched/ext.h   | 2 +-
>  kernel/sched/ext/ext.c      | 8 +++++---
>  kernel/sched/ext/internal.h | 3 +++
>  kernel/sched/ext/sub.c      | 2 ++
>  4 files changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.43.0
> 
