Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B02BEFF5;
	Tue, 30 Jun 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782808051; cv=fail; b=k9BgirjBZJAg6SHS1t1qJTgau3rR6BGbp2CGvFCsUWjbJzKvE74J4m0NZG6TluCZGG5UdBnZdJUWH7vTA/T8Xnuu5MDla5CH2Xpr5WhSE1vD0xY8o3x1E7HRzDVMn7kv//nSBsswk6QRCCPNC8qPktZsaU0dGZHEgH6+ST99vLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782808051; c=relaxed/simple;
	bh=/H+2GShxspy89OnrKH74iDJxOvl7eptDOJKkZ03wnjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dMsnSj7/e2Yhg/yyU2ngarzPaMLhH8AzQ4IvEOl/q3qJ272bbY+d6Hpr2g/fH4W5VMg1ocyOa8v6TQwkHMsxi9EPSJIapmDmakr/LtOsaa6t0acvVpKqZyveLZAqHlmTLUCT7tkbBYB08zzECZ5JBb3vIB3zLiAQRYPniLm4Ap8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lsIDVyZk; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lsIDVyZk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SP58UvRbL/J4APVsFyCRM4ncc+j7nQbtDe8buPK6XAvb3GZvA01jeYlVPybfbFriuPtR/K2WG1aqa0xTSrqIYAw80uOBwjCBTaVE2o2sAPuxo5bkp05esDthT28R47wFETsU4dwCo6QQMRRDxdggyll5L6BgJL/YZPLE8WXixs3QWMidm5txyKTqtOk9KJr9+crv98B2GqCUz7zRZaKIhMafBqvQUW9mCwIa3BXsKIYoGqmNJ5MVBO920KqQ0Cwy6nX+mzkAD6zGzg8tNTqSMMOHyb7Np+gsytObWxMjOQuRIolI3Gdwwz3Qx5N+xt/sBNOJ5swR0377kgJdSQAp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5xahSwill+hhVyLE+yyOjvZ97V3bVszpKazxZr3AO0=;
 b=LwwKw40a4fT0ur+8Xz6kF8HAGX9tv7DqvxjDrQNONDiRFh9GE22E6CZfLhdmPJuafZY1jbeFbc6YGChOpJT/I1VI8/6HIMO+GP4duromVWGmnNwM8BYzsCEhG2Z9J4NC++zZHcXaI6WVHtiGwmdmggc5SoZbQTKObhcGFenb6zpfzWLB/yVRcsRN+2GbV/wNF3uh7LlIxa2RiH1TKTcutLj37RQDtGchE3hjgxu3CJciEFomk6hGAochtEUWKmxbZKwuCjKpeyDp5+Rm0uNhtAvBKTULUowmeBSYN3g6Wv+Az9OmwUvGUJNhvHfwa+lRwrhtMyttWcPmc2MxxcAJFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5xahSwill+hhVyLE+yyOjvZ97V3bVszpKazxZr3AO0=;
 b=lsIDVyZkl9nkKt3QsH6GOX1IJCO8AQn0SMovYqoca1stJJH/IeFuEm71YPUpV4fASQfwEgE8fcJ5uM2KFKMKjArFDKuIXjsIZz+12O1a7Z0/Ez2HnI+HYYFeMcEB9fQe4bL9ELlq9YO+Dw3jbdPSJnMESFG5g3Q4Xg7G4gElCrfg3GkcN3FA4iEYizzPPFRGF5Bsn9ggaFrUts65d7Y01mJHzW8ykTPm+Md20aVKAs08J4FxOZeWm+zL5/EWc2uybTMn9N7wk/ReGrwX01psIJ24zkEDSVMZA/vrPfAccmmrhslektArDm3/VpRa4V1ZlknLOF3Qw4QIGjTfBJN/QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:27:26 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 08:27:25 +0000
Date: Tue, 30 Jun 2026 10:27:15 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2] tools/sched_ext: use btf_vlen() helper in compat.h
Message-ID: <akN947xV8nxj6g_x@gpd4>
References: <20260630031246.2618216-1-luoliang@kylinos.cn>
 <20260630081720.3081733-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630081720.3081733-1-luoliang@kylinos.cn>
X-ClientProxiedBy: ZR0P278CA0197.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af9d543-2c2d-4003-6633-08ded6816a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|6133799003|4143699003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZrGWp0Ba2UzCyKkWW+Se2ubiLAtmvpJNTelN5wu4jor2bwwBcvgWAZTiZeLFnGricyDriyock3e/mNRrZ+Wk6JiuGWiEalgFEZr0xLZJAo3FQ+tem926bbJJpJp3KJhkFbKo1mcsIE21S4SOoGt1jNnQI7cg+WDfkxDi5yoEEmForp72KPyvG4hIEAwvGNhRZ2y/r08OCOlkFFgu8Fky+vRbMTdjT3vGcJ+HyltBtCtOmlAf5ZhBaLrGcVpubdDtHqLilJoMwQOgcVGlOpf1LJPYnE2mqgeenc6hjf5682KLeAYYu5FIuJSnEmuYFiTjiOVBgrK3Z/86NJxJyBjJAofMjMKXMP44eKIPYhGEbCvV3AksscGQWG57V9lSTg/iONGIvm9ehC0G5EtzmD8pHfqjsNhkLMkrF2PMk7i/dlk1ZoDUpKtKTNBpJh57e1NzzPjeTzOlEcSuWZSJ3t67zkNh4gjz4l/WavDYWsPdkp5i4NUupVa1eRjI9K2bfywvZiP1VwYWRsqVbFHRP95jewIppz17ese/h5/9BNH3TvExaNNjvJYJymZeBbRirSfPBFfOjUI6cPvaJXiBEnl3bIiATc7bAjXemjDAUpbkFUPs655gnJN1cO+Btgkx8eyRkgGG5D/OA80uoEFeT4I018gwXKK30ZIupCuAJT4E6Zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(6133799003)(4143699003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?486xbBtliGNEla54pcvhlwmQLM9G21xIiWwvClreftX9ok9goNFrEhU+2Jii?=
 =?us-ascii?Q?unSvTfpRH3jiSfXnxc+soKE0bA908g0LTqYQi+dNKhH7KgQjqzfqHBnP2GHM?=
 =?us-ascii?Q?Luz0WxX+qRz5daMJruCsTiQpYejzBp5Pk7aezDs/WXQ5eUT9sszvfovx7N0o?=
 =?us-ascii?Q?G3Lj2TxtOj/tn1CkHy2poayl4l2LaalXrBGZ7TGia2PI5WSZ2efP/tb2W13S?=
 =?us-ascii?Q?U8gvm8P3YFN1QAI9eSjOvkUV2lYMfUEjJzRcMmGvgShHb/5COCpI7jMLlqOm?=
 =?us-ascii?Q?KK++Rxg6i5gZDzuHD3m4k4PCzVfGMc3PzDmG+0d6Lj0/ixhGDy2MrdHn/FE5?=
 =?us-ascii?Q?CZ3GHJrQXnMxunfNY4wWrhG908DNU2kzjY3mQtOUqq9zMawdkwGO551bjgTs?=
 =?us-ascii?Q?BfreHv9s/IB7SahQsCXdlhhJcPmTFXSiBBKkFqOGcCEdia3szwYMgYTPJWnK?=
 =?us-ascii?Q?eC7Vrf1P69jLPRXw7dONom/Ni7tkXdiTSrkYbopOJqVeOaCfRi7RXznD40Cb?=
 =?us-ascii?Q?WIuvoWQRbZbwsOgwCFIyDNF0yT+KNa3+8sNQ/+3cZyXU+X/2WWIeRZPy4Trb?=
 =?us-ascii?Q?X2utL9BTSfyEdcsRUWiIwFNBjUG/CRZq3sT8TXDLJT+qBjDo0gvJod1BasOD?=
 =?us-ascii?Q?fB89YDbYpMhYUgsy/uL73OY8uloc51G0DrI0EOdSdwKxZMWFmwLNkBPymyQT?=
 =?us-ascii?Q?xZMnFYw20tdArMuDerKm1rakprbLPVROh7V+sSOB7wixx/x+Al+3UthLPmKx?=
 =?us-ascii?Q?JcxTl5rlJi3ozELel4deAhQXHllyijgyRDEeBJxmHLgR4lxqIV9fQcwSjWLK?=
 =?us-ascii?Q?kttM2Hjqt1TeIqbnvnT6O7vhnPBlih+AJI6VsA+T3h4NMEdpd8cRfBMKYf+5?=
 =?us-ascii?Q?nkjvgj0EJ/ga9ORdG+8D9lxpOwoOD9mmEmfZPpfiC9iEXX26TKsC5eb6NhaE?=
 =?us-ascii?Q?HP9/c+tXTvC1m23aRpzlbokIStoCEShc+7yjjcBrGNrXpXOsexQlpMtzi/rU?=
 =?us-ascii?Q?g5uCgrdtPfywYGQefk8J4n0+OxWbvG3lZAkMPi9u4g+OoBs4Uk15tMkixMIc?=
 =?us-ascii?Q?tOAeJqYItAzWhr972IOCt1cmgFoahfQHX6JZ13/lVWqnQuYMQBmps7Roo9ME?=
 =?us-ascii?Q?3IFXz3EVP+0qiRJfOELpnU9wpoj9PEK1L4qVgjk5NSs4maia4jMdqnOrfkh2?=
 =?us-ascii?Q?8y0Weil4bEwE30uWMTreNpy7WemTo8/zIJSpe8sCfDTl0rBV7JQeHMOgISfp?=
 =?us-ascii?Q?gqRngH5SJSMdK17rnZJp79ZBPoDAQAF5HIuWceIlEBMQG7o/dKF3QQSicSg+?=
 =?us-ascii?Q?43xQTCoHiJuEz5qSXygxZxNC15+Dy+E3E6PtiyBhrdLRJ0hhFv8t5Cx1pc7w?=
 =?us-ascii?Q?MpheBIMBJ7gYSxkir+jI783co+gCF7lbhdzG6aQb3oa3pWpIppwpj/iJFbw0?=
 =?us-ascii?Q?5yiLLqdyFStqB9lyKIYTrQNcX7NXeYH5yzThW3nstomu8Ks0Mf7773Ld71PV?=
 =?us-ascii?Q?tlBw4FnN6msKX7MoCEEecKGBVmannj0DLkQrImKOHQ0m8trpsJt0qnGA53YM?=
 =?us-ascii?Q?oHph+34AdBso/HPIUAUD5b7c/wq2tjy+YdrVsFAOiDZKNPAoL8ylc3KjXTXu?=
 =?us-ascii?Q?1fqGZRL2ktu7gDIzseyRAwwkXwq1UDugAODHLRg1SnivTVnMRegwY3ydhyGr?=
 =?us-ascii?Q?LC+n3xeEz8e3mDWnOkxxB2YWsLnQ0PcjPvzXAO0rLRaL+IO70epmucoo8UOq?=
 =?us-ascii?Q?oE0aaItMrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af9d543-2c2d-4003-6633-08ded6816a58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 08:27:25.7928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujgpZ/tcCRyKRsUgeWuu4blZsRI0qrHnbidF3BwB+RXintmE6nn86fsojLpIiVWI7Kg/EyyUSMfvGXjXu88uUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075

On Tue, Jun 30, 2026 at 04:17:20PM +0800, luoliang@kylinos.cn wrote:
> From: luoliang <luoliang@kylinos.cn>
> 
> __COMPAT_read_enum() and __COMPAT_struct_has_field() open-code the
> vlen lookup via the raw BTF_INFO_VLEN(t->info) UAPI macro. libbpf
> exposes btf_vlen() for exactly this purpose; use it in the three
> call sites, matching the pattern in kernel/bpf/inode.c and
> tools/bpf/bpftool.
> 
> btf_vlen() returns __u32 (since commit cacd6729c0923, "libbpf:
> Adjust btf_vlen() to return a __u32", which expanded the BTF vlen
> field from 16 to 24 bits). Declare the loop counters as __u32 to
> match the return type, keeping the comparison as a plain
> '__u32 < __u32' and silencing the -Wsign-compare warnings.
> 
> No functional change.
> 
> Suggested-by: Andrea Righi <arighi@nvidia.com>
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>

Looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks!
-Andrea

> 
> ---
> 
> Changes in v2:
> - Correct the commit message: btf_vlen() returns __u32 (not __u16)
>   on mainline since cacd6729c0923. The v1 description was accurate
>   only on a v7.1 baseline. (Thanks to Sashiko AI review and Andrea
>   Righi for catching this.)
> - Declare the loop counters as __u32 to match btf_vlen()'s return
>   type, as suggested by Andrea Righi. This properly silences
>   -Wsign-compare on mainline.
> ---
>  tools/sched_ext/include/scx/compat.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index 602f07061ee3..23d9ef3e4c9d 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
> @@ -28,7 +28,7 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
>  	const struct btf_type *t;
>  	const char *n;
>  	s32 tid;
> -	int i;
> +	__u32 i;
>  
>  	__COMPAT_load_vmlinux_btf();
>  
> @@ -42,7 +42,7 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
>  	if (btf_is_enum(t)) {
>  		struct btf_enum *e = btf_enum(t);
>  
> -		for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
> +		for (i = 0; i < btf_vlen(t); i++) {
>  			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
>  			SCX_BUG_ON(!n, "btf__name_by_offset()");
>  			if (!strcmp(n, name)) {
> @@ -53,7 +53,7 @@ static inline bool __COMPAT_read_enum(const char *type, const char *name, u64 *v
>  	} else if (btf_is_enum64(t)) {
>  		struct btf_enum64 *e = btf_enum64(t);
>  
> -		for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
> +		for (i = 0; i < btf_vlen(t); i++) {
>  			n = btf__name_by_offset(__COMPAT_vmlinux_btf, e[i].name_off);
>  			SCX_BUG_ON(!n, "btf__name_by_offset()");
>  			if (!strcmp(n, name)) {
> @@ -85,7 +85,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
>  	const struct btf_member *m;
>  	const char *n;
>  	s32 tid;
> -	int i;
> +	__u32 i;
>  
>  	__COMPAT_load_vmlinux_btf();
>  	tid = btf__find_by_name_kind(__COMPAT_vmlinux_btf, type, BTF_KIND_STRUCT);
> @@ -97,7 +97,7 @@ static inline bool __COMPAT_struct_has_field(const char *type, const char *field
>  
>  	m = btf_members(t);
>  
> -	for (i = 0; i < BTF_INFO_VLEN(t->info); i++) {
> +	for (i = 0; i < btf_vlen(t); i++) {
>  		n = btf__name_by_offset(__COMPAT_vmlinux_btf, m[i].name_off);
>  		SCX_BUG_ON(!n, "btf__name_by_offset()");
>  			if (!strcmp(n, field))
> -- 
> 2.43.0
> 
