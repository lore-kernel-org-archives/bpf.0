Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18E2383C75;
	Tue,  3 Mar 2026 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524277; cv=fail; b=QdAjp6D/umEUBku4qh5cF5Nfssp40uXENc9SHYA1xyA9Uml3IL3I751vnkQ2S2+lnPGtatJRZVmlI2mikRlgR2DypwB9RuNKPbVZVaRDFNKVH2cEsWV/8IP0szqyC88i8PUJA1ljFFy1DZD289x1BJU5R3kKEbxcEx3AiHFhFk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524277; c=relaxed/simple;
	bh=lHJd/JxNzoIFto9UcCMlNwTdTIV5zK/m1tdAOWERJHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kZGOJvzeuPDqmd7ktVoutN05ks/X/otVn44+llQrwESEbtIhnez4We55mVnHNJJ/aQHIoF1HwQH4tf8nHUrmHbViNDGss3sEHSoM+1p5pUbrSZ9R4gN0qDmAAtP/n21sTgP24Dl1xwqc1GiToJbFS68iGS4p91jvNXtAjjN0iTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dI6ASDPV; arc=fail smtp.client-ip=52.101.48.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dI6ASDPV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMH9Cc2VHzuKKQKu2Sk0dJjXTeebCEN+5EL+QYDHSrVHfVY6/vV8+J6Wko9BU2vHnifRj1MvwMcLBl4VZ0Pt4mBc7blEx+S/uIvETRfZFXAGGY8Lp4RoA2AC8parGTzaAUOfPHzS2sAcehULQJn8IlYVDkOlDJI9obxKzdgfcGlQpcpT+yO1aC9XYlCHk5b3C/f1ODxDipv5IefGq18SjZbety8Lg1z3vJRSHlY9jti2cE3EpWgsaQ/hJpTaRe4sE6oGSYDsGlr/Fo4xCiKf/8jfr59gNh1IzJYDqPYcloU1ckeroUgi8d348QZO2tLPaMmpIDcfsr3o0XuNsJRCbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26h+AJnjdlX+C2a4xxGl6HgAyARHh/bT+gYcQY0Fx6g=;
 b=yq3onoBVF/51lAoXckCTfhFID4v/nK7PotxShmZ3+WVYJ/Rs84AmT2RpUTd6tjMj0hIaMdbXrVVw44ga6Z3CDFn6EHoDvxS++7/ooTFjL+RcndL0ClX0vuvRp7v8LT5r5HLDqQxkvyq+pBCk5GKya5y621EEsd0IeYtuIY426BNV+dtjpOaRvCpYHVw4rvt5b0FMUlb3RPkTz7o4gc56tw8xviKqyxbxMCVAeo7CeE2u0JaOy+LAbkAepvo2ki6TMgi6tO19n61QIxoY62PJ5BTsFnJpj6FC4vav5Rfmhx15KPXNs4enDttWnOj0SEa3hvqEn09mH3ZKSYzWqYlhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26h+AJnjdlX+C2a4xxGl6HgAyARHh/bT+gYcQY0Fx6g=;
 b=dI6ASDPVs7CB6FJSy/wxdzN8vhgFf1Rnd00AwghEs5qhrTF0bYvx9VdifN5TXtmCHCrTYJhby+9WzQTLEJTMhwIduVWVMTaOtGYEyqQVQ5q78w50eeAQvMKbE75geU+zg+JdavvmLFCDTjXtZ6YdKb4KJJFs9c+RtbvECmaOHy3JB30U1razFGQUBJJCTXcVR8CDxWSV0OWhwMce11zDfyUovQcuFdEW9U5E7G0P0Uh4B0hO6QroGuFvjBJ2JSK9D10lAgLveXBGpcE3917+Bl+szKCKA4kQE35JeSQ3aaqO7LiGMMmIrG1s1GsyHIJK8GaCyXIpPD8A5qTXQmNA2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 07:51:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 07:51:07 +0000
Date: Tue, 3 Mar 2026 08:50:54 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	shuah@kernel.org, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev, zhaomengmeng@kylinos.cn
Subject: Re: [PATCH 0/3] tools/sched_ext: fix compilation issues
Message-ID: <aaaS3jirvQudUR4x@gpd4>
References: <20260303072317.76035-1-zhaomzhao@126.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303072317.76035-1-zhaomzhao@126.com>
X-ClientProxiedBy: ZR0P278CA0201.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: c350f4e2-1c8c-4cfb-82c2-08de78f9a0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	lSOOV44dhScGBz3sqsxpw6mfqBLHugD0NWhS2eFSzUYhj/ggtMMQzQzYTqkHm5midPoURtQNE50YDycN2gdTN0xLKxtOQ0DzYyfX1gllMDIyT8WuyM1oCHJtPO5oQsPbpl5wEHlDi6S1WBW02pa4juUrWqhj+ZD/nDBf3LVFmV/tdBcyuwQ3RhuoVIVAETUCrBnqQdEN5kWFQH8c+npfBpYfThJUp5CHyrpzQjjVJpw3+IrzFZjim4nJiqm8AZmCAmFb6E5mqteXDx9s5F46IQSZGVjlWIJiGWPFoerj6ygQMpmw+79V4bnoBql58N97NZP3IZfc0KdLDkBKhJVblYkLCsTeBy63885xjUs4zeD6lMpXfQP5UmDCKCr4ywFdwZIBaToYm1uRhkAqYq/A4V1pOCnTB0RcR9kl8ozJDXYtRmJQLkzf7Jal6RCPOSCDC91Mc9b9dKt2uO6eTS4yw2s3hHTu/ner7Vlbe6wZILVQTMUeP0xTaAkIbGURPFZHOfsaq2pBMWtnIpazOGo3XdFAT8Q4qKKrwJlofB3TUQUI8e5hFmuV2EjpUsomXTAA76W1/7R15xK7LrlC4vFOj4zFAyFVkOuTTBDf3VW3S6sM9zPV1cqhkZbuxpZlpXdfI6qbLgoq8zD7Ole6NnGmb34q6AUe6ac8apenDo1yj4WxDvq5mrnlrNme7pVTyO3fpld0CjXfrAByWoCqDXGHdEXkX77PPvW4UgHyShbQ/DQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gCKc7kjEUVe+lb6OpvUr0hyBtyui/cv5bV2wjYE4wnbsXIlRl+m6WoVOqSb8?=
 =?us-ascii?Q?X7h8YVxV+vG3STQtZwuw0nJyOmy8bWVoyhcXrdVmrPMgNbgFI527GQ0/6J/j?=
 =?us-ascii?Q?xp9q0J+FyrV4bfiUd5LtXtsgfJ+wU5PdjMLB3aagKTTPjrp4ibADpFCygOnK?=
 =?us-ascii?Q?tFFw5pqdFP+ObN+W3HIv/+WKbPN4Cc3NhM0SV7ltTd3uLrKeqiy58s9vekK5?=
 =?us-ascii?Q?NizouEabMe+Qx5rmowJ+nrXilxo1bJGztQiof9605CswNRjxGMbkoUIEoGOJ?=
 =?us-ascii?Q?hsad5o8JjMuVcSNlPXinalw5OPOs93xj8aVLjhtZC23z9eE/MY1K8/Qccl8i?=
 =?us-ascii?Q?4tBUJwC+4clS8iiDVywtsyC2wW8+SpAh/lFFopfbsHMjuizfnKySwHCWsn/r?=
 =?us-ascii?Q?HTck/irIrOjfarcXogLn4JuawrvfMqLFtAF240mhzoZojLnDa/kjYxU+eTCG?=
 =?us-ascii?Q?tTZpgCFqKxyRkiZWuMd+lnLig8MhYYVeF3LAyppvOrnFZqsCDzrlcUp9IQlP?=
 =?us-ascii?Q?OzE+z4+XjqEUcc5TNcVJmFSwBK4xjQ18Uypw6CqqcyU8AlqV0plM2JKDQPWR?=
 =?us-ascii?Q?2jx194/Wz/dWmLla1fujat+fh2Tnm9IBHqs2/O6xvWgvTeUKK+9Znw5O2Iop?=
 =?us-ascii?Q?ySJWhFy9gdPiayekeoVDAJYdyXjv55s1OPr9pzQCwIkLoHbHSbt5IWQKE38m?=
 =?us-ascii?Q?vC1tYVgojw0pCAnd1fF5cGaKSwFRDZYU3D6tTOPXp39206ggubuGmPBvcGS3?=
 =?us-ascii?Q?a6kAeQ9EJzIk1qTtMrF7VSrbG6gNjd0KJBdKjT8k8wRzAHMO+o4UUWYO1B82?=
 =?us-ascii?Q?Ex4HO6+qFEK7wmD1+ZTmJzAODJnowGSW+/eKeYk3NITkT3M41jWZHGugL5se?=
 =?us-ascii?Q?B72Falwr639aPrV/MQk7Fm1X1+6RWGwLCSEx0/kW0UDTRPYcWcBi0uu6dQjY?=
 =?us-ascii?Q?dCCyZsTDFHi3T5P+clojgI3S8PRVNae/Ue0I6B68nZXM+LvNLikNeZA5/v4v?=
 =?us-ascii?Q?urYCJMPHIpIyqvnh/HW3oxH1BcECInLt0XaN2eeEEBIM+GbhBTJVdS60INks?=
 =?us-ascii?Q?sIxMwYJcgCEwCp9552AKYS4875ArbFyHTxhhGre4Q25ev6AZ0CDnSea+pzp2?=
 =?us-ascii?Q?bBaSwt7N7OFmQs6SR3amOH5OHAKMAtE7LYeM+9MoLSgjTVQ8bgPvip582Vgv?=
 =?us-ascii?Q?YUHIt9MXd8ojeGZbRBdvMj9m6Aube04KuSViauIMAESa8Izbptk9PTK7VT7C?=
 =?us-ascii?Q?0DeXUnvsjbDvclOSZ6miOiohT0C5arQPDT6sOKN8P04SqzsaAmfJnBEdWuEg?=
 =?us-ascii?Q?CscDPlrMOui/UgiAu5kT/n6M3pbV0u0E4Sp5Uc8R/23LfJYFrQFj70jUcSh/?=
 =?us-ascii?Q?MF5YxCMpyoJ4ithPLHjaAfoRL/3RKCVltjrTbrC+hWU+EibBf64B5Dd+1CqB?=
 =?us-ascii?Q?Fp3+ZSMj6FnB17laNUN4D+/Ty2AzxDeWOIKl8+d5MRxBddYboCDZHcxbsIxq?=
 =?us-ascii?Q?mM3her8SDDPbBsU0unDhYefhgETpTa6NY8jJZ5DTTQuYOmKBgoo5YboMy/eq?=
 =?us-ascii?Q?c03yrImJ8mcSSwuAiMY6HNkougiZ/OtdJhz7mEzxv1+oqrxcsuhcHiLuh2H6?=
 =?us-ascii?Q?qokWjBJfUQx0Q3jduhN7aPF7MrLQOFsijnrd98UhSq7UF5dp//+9ANmT8CC9?=
 =?us-ascii?Q?m0XuRPq71NujSxEJ5ofKUarRGNJ5CCe65rzMD41eqvvnVrRtOYAXrjwydakT?=
 =?us-ascii?Q?v8KQJ8cE4g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c350f4e2-1c8c-4cfb-82c2-08de78f9a0bf
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 07:51:07.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEVB+xpOzV+ffYfBOwM3JPjE0OXhpcQhk87dudhy4H4VOPI5AR71bZj6WwPA0VSwmjtAcd8H6WsjYnG7/miojQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

On Tue, Mar 03, 2026 at 03:23:14PM +0800, Zhao Mengmeng wrote:
> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
> 
> This series addresses compilation issues in the sched_ext (scx)
> tooling and selftests when using Clang 17.
> 
> 1. Add -fms-extensions flags to scheduler and selftests to avoid build
> warning like "declaration does not declare anything"
> 2. Use signed div for peek_dsq.bpf.c to avoid clang 17 crash.

I confirm this removes the annoying warnings and these options are used in
other BPF selftests as well, so looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks!
-Andrea

> 
> Zhao Mengmeng (3):
>   tools/sched_ext: Add -fms-extensions to bpf build flags
>   selftests/sched_ext: Add -fms-extensions to bpf build flags
>   selftests/sched_ext: Fix peek_dsq.bpf.c compile error for clang 17
> 
>  tools/sched_ext/Makefile                         | 2 ++
>  tools/testing/selftests/sched_ext/Makefile       | 2 ++
>  tools/testing/selftests/sched_ext/peek_dsq.bpf.c | 4 ++--
>  3 files changed, 6 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0
> 
