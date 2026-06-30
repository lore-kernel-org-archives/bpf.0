Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCC32D0D4;
	Tue, 30 Jun 2026 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796447; cv=fail; b=q2Bu5sh03kWov7WOLIxyOutG+LS5ZrtkPnZbxaX6rWtK7H0M0Q9/z5FfDY/FrtYU3lgCu7tOdPTFB0jwPKYWspMowaCGjkzJ6IMV3lXr3nRWkltl6nexYxXDA8a8yBd0b+DAn6JALGdcXliw6ZNhJi83FCkYkssmTcY7Ru44Ttc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796447; c=relaxed/simple;
	bh=+WOfISRnCQdq7zytYLejxIMvomy00ZxExQgHwXooGH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kXroKgAFoXFQIaSGd6WdihZ/vejYK9UGtYs2Qk0vh9AJ/xRlKE5MKK2B9M7qWaFuWeB2oV2xnH46tqk5RH8D6mXbKFrHY2awLBYalKkllHnX0C2eZdzZLloZxB+HY7O0vokbZ7poiPem8uWCUu+MvPl8I7l00cjHyl2Dz2J8LLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZS7rP1S; arc=fail smtp.client-ip=52.101.57.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZS7rP1S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a9cZvQqzICrRzE47COBP4omFyW0YYKddCArNzoXK+qTT0mQKK4nyMeWpuwUaurcibPnUJ/e3pPgcH6jbtq13+IXfjISSeyCpU1bYMVjxwsOKuZt7W39cM27kHqtlWozymrKkga+1pOorRX5nlAwrF9lqhAHT1dxqHptiDrN3NemfD42++MZnl4gZcRJchTZ+DKs1ksSviYfVLUuMhWG1l2KRYnJta/tjCQJNNljMQVSh1fP4k1XP1PmDZf48lnTkwBJrIoogb9TxKBi/3fAPNv/T6iQwnjDHIuwhaHv2KvvH4flNvS1ZmDMm758au/7cX/gsVXww7J6SCrpBX/YS5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+/8QwxL//uLuCKLw4KthxOeIdXmrtb75bglkZaByFs=;
 b=UsbD2eZFDvNJZfojL19I8M2Uq2xPFuZGJMjL+MFsogaGLZkchHsWLzUjrraCdKbA4fFDPiz9N/D8pTHHrHubWkEqkg18L+vDqu2HBzDm3dU3HJa5W4MQe2xLll6nRb1Uo35Eo2vrmstVKAcM8FXgu2GEqt5dVT/WklEO8C//GmWJmML5/uAMgE7BWb/xqLk69M9sfOCNmns897U5Cy7axhwDaoGHK/G7PB+5gaiIELe1Gx5Uqu6A3HccLN5dKjTdxlbN7WnYiI+swUxtuCpVizDKumX8mrJjvcV7n2sC2wOiEcOS1qo6HFwGQlPbOIDKUyMnYPDiskYWGOK16cOHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+/8QwxL//uLuCKLw4KthxOeIdXmrtb75bglkZaByFs=;
 b=LZS7rP1SZ3ehm+Ww4iRpBbeIIF+OmdNvWpstHqTljm/gvRJzhV4CsDfV/IK+bXFfdu/iGkgh4eX6MlpoucpJCWTvnWDcw2qeyyaLErXqRl5JgIwxG5FbkaLLIPlTi51GS7POfZa3T3cEMThoWrj+iohxiJRRVcK/PZri/5uKs+B9LNphuu2tr7M+6BxBdwfxoyOoJaDMxDboqHbHIebPP6ZKwwM9287a/zgpUJeqKel5iTZbCti24HVcN5G8PyTnwfDuflS0niMial4VIQbfa58NW1YaKhr2ty3l1t2QwNXbS25GLRyanwibbURO5dbybpOwuIp0ZedSJMb5UlFiQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 05:14:00 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 05:13:59 +0000
Date: Tue, 30 Jun 2026 07:13:51 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: use btf_vlen() helper in compat.h
Message-ID: <akNQjzejJOdtDYnQ@gpd4>
References: <20260630031246.2618216-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630031246.2618216-1-luoliang@kylinos.cn>
X-ClientProxiedBy: MI2PEPF00000B7E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::412) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d0dfa5d-4eb6-479e-8c86-08ded666646a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|22082099003|18002099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	f7t6WCXaQD1Dorm4uQSUd4fNOa2hBeay2m8yMZpDo/dygGYbnHQNsBrbshbX2a3eX2y7My5fydpsS6HrcACyZT0apOwd0rO78bag/msKS1nUJBlR5rTz+h8iagzVrlSHnobN1myiS4htjJUCSe2SJFmpXExpSvF1Bu4HZHVm9dhShPF/5rCSmXNrKPu02elkb/5UTfHG7YKE6Q3HGpaFc+iiJGSmnFzHYscHz2uMCzaEhThNXmhxQcn9N7W38iRixCgp1sPoEjcGz0bxMnzFrUTMztifIh9qqZYDcL0wg6ACwkTQ1ecaJnP9y0ht3cAkRlfnuhw+oR9/+nTOu4dYSWoJagdRWAnB4Flu3PsWoJ93/pevy5ZfljgWx+rumKMuM1vGF+Lx2GmSUT4hp/gUSBl4Nyhms9nqgQfPi5+lsuB+dxK+XtnfsggFb4u9KiNHr4UVVl6lzzmX581xXnNIel0aV88PIZm7IAmqSf6Rb3WzZ0O/o3g5Quz9iy7I2wT9DIYGgG3/x75CVchMTupfKQSas4Ja6j6tH28nujJJyotb3KSOrPakPR30XmrgNRX4Kf3tjmdFLs1HPU7OFchlrFuVZ/9C9g7NtH39PPqCSmCqbOI0HXk/tY/U57oUFyohTx4XwW30RxIF1mZWQxqCHmzwkvZiHygpRwwgr/bscIk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M/tjT1SqWpJJLugGEA4WG94IpGBqbxhgLHR7uAxNDuXZ1bK8/McAm0ezlgBB?=
 =?us-ascii?Q?kyENVul2yBDXRYL96/5lDmkIERoCLW9GEyPT14dCf1xd0AWR+e18WNvAevqF?=
 =?us-ascii?Q?wfYw+ckecu1HZwpGAx3qHMD6wUbtuedQqx/tH8rscvw99MwK7BXYXqm62Wv8?=
 =?us-ascii?Q?o8ZiaUShBJ8kpPtMQ4GNm32bbq50TyNrBDS4dansqK4s6qBk3U4XwyaKgSCw?=
 =?us-ascii?Q?UKy6I+5woMzDAjzlrCJ9W5Fr0VoDEG8/lKQrm2TSjetA+s9TzLnY9GkJoeiM?=
 =?us-ascii?Q?sC0AA0Lh2Gq3UOunXEr3enCkp8S1Vwq/jNmpRfXcRLknF0EOO0B7zYj2anQl?=
 =?us-ascii?Q?rUu/0abTGn1aAxRPBvaos8A9KJxo4cpjjYgR3CGJXX/sKefqOZhJo1W/nD4+?=
 =?us-ascii?Q?ebwZixmzzxys6Ferpgnqa2KKKth1/Jt8ax93oJPPXBUdiyrvHICE5qcTkZJW?=
 =?us-ascii?Q?nCD3GP+zCsbf3e7Hp1vD0HbiEqXFvyCtLaJ5Cot/5kDV2mjDPEEHpFFRPxmI?=
 =?us-ascii?Q?gjJEJb6I81AYTIynBsp6ILnnY3FTwtklxaWldOPBEKg75lLa6YxSpuafUvUq?=
 =?us-ascii?Q?96R7deGA30J5KH8H1ooin+bVvYQhbX6Xred2dXcFQ9ZhhsQJh1Y6P39oIhH5?=
 =?us-ascii?Q?5K9wsz4u7bZsm9yx50MnJAun7+QN8oZfo3quBCxAEocWdmuwHRJHE1hJzUwC?=
 =?us-ascii?Q?naNrFeliiSIC0bA4AcBkEkQkIoFtRrlX1OsMvl11Z2J9e8nAPtz3HSPj4IDK?=
 =?us-ascii?Q?q34A/LHotE2NCXkTKV2fWx+66LzZzbM0pucvTSILQj4f95No2/uY5d87HgIX?=
 =?us-ascii?Q?B6K1PoOpiwkUwZpJva5Sbh91Ag6ZoJ0rvvTkHB69tTs35/FfLi9K7DS+i6p6?=
 =?us-ascii?Q?LW6K4gEwwXUFaUfHqhMynXCWA9GezpqmwiF/QPSxPkMY0rroJU/52g73wKGt?=
 =?us-ascii?Q?9f6QGsCZa4Y3tdLhhA6fDqdawE8c/2OjENnlwHYfjp5Wa5zDFphtO7vv4cWg?=
 =?us-ascii?Q?kqE6nEmc+ewk0nCLLA+BToA2Qt/eGvl01jt8A1IhuaS9tQ/tFO9w3+M4dOeU?=
 =?us-ascii?Q?jFdCeg1QKv+fkWi0lrHhnL/TJpq5y2FmUk86QHzHbIeWcRcK6jPT4YwMPmGc?=
 =?us-ascii?Q?S3yif29qHIzL5pVCtxH6s+E3v2ilMqUZPTWF0SLt9ab88oF2svFUoUr2rIh7?=
 =?us-ascii?Q?bfSkS/Q/82OibOYNf2K6RuoWVpDGo1GwkzhlTKGPt53+JUiTCDw/ZgKgzGdD?=
 =?us-ascii?Q?nSvdQY3+bol4uC2pkXamNQVjoLNCTUxcfNjmdqdxxDx8HscpGHC4K2LF/FeH?=
 =?us-ascii?Q?XAf0SMrsqPsDGxeHXGCMuSstOcGCdUCMmCbRKKpf4Yfr3NDU7y76T8gn5C1c?=
 =?us-ascii?Q?CSmsdBa0dvjdFgF9+zdQ2fucq+LI0mNJ0kYjEJESgk1+RxmeFozc2GZwgLgg?=
 =?us-ascii?Q?wV6FYgm/94J5MmxVQjM8FMnmZu3RJVfaQTD/gVQOoF7ME1VI79KXvFeP4Qk4?=
 =?us-ascii?Q?wpSf1wSVsQuC73Mr//i1/0q+rAcAsYCB3E3u+GZ0fnwsGSXXfDzKwKWVJVvk?=
 =?us-ascii?Q?9lqKlpNX1kpTj5ekwCqEeVcBbq/LIPPNhzXYRnZiroKDR2to3ovT8uHrOl0g?=
 =?us-ascii?Q?IUwzcBPOgYD4evoiWNIU8x4hNYxcNpeQGiS9zQJn3CGXPs1oTutq6nOBlRH+?=
 =?us-ascii?Q?+b/w0OdEdliQCinyD7LmLENS5P1RNN46QAJ/HyjtTK3WAncjMl/aVG/v0hbw?=
 =?us-ascii?Q?2GiNqSRsqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0dfa5d-4eb6-479e-8c86-08ded666646a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:13:59.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7jc6mCjCusqeEILtqZTo3Fu9F3061+1Op1KdtmNa7fmYqolY800i4XhA4UCwr1TyClqWQZd8hX63Z4XRhvbJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865

Hi,

On Tue, Jun 30, 2026 at 11:12:46AM +0800, luoliang@kylinos.cn wrote:
> From: luoliang <luoliang@kylinos.cn>
> 
> __COMPAT_read_enum() and __COMPAT_struct_has_field() open-code the
> vlen lookup via the raw BTF_INFO_VLEN(t->info) UAPI macro, whose
> result type is __u32 (t->info is __u32 and 0xffff is promoted to
> unsigned). Comparing it against the int loop counter triggers
> -Wsign-compare in every example scheduler that includes compat.h.
> 
> libbpf already exposes btf_vlen() for exactly this purpose; it
> returns __u16, the natural width of the vlen field, and the usual
> integer promotions turn the 'int < __u16' comparison into a plain
> 'int < int' so the warning goes away without any cast. This matches
> the pattern already used in-kernel (e.g. kernel/bpf/inode.c) and in
> tools/bpf/bpftool. Replace the three open-coded lookups with
> btf_vlen(t). No functional change.

btf_vlen() currently returns __u32, not __u16. This changed in commit
cacd6729c092 ("libbpf: Adjust btf_vlen() to return a __u32"), because BTF vlen
was expanded to 24 bits. We should update the description to match this. And i
should be changed to __u32 for consistency.

With these changes:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>
> ---
>  tools/sched_ext/include/scx/compat.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
> index 039854c490d5..df5ca1ce20f6 100644
> --- a/tools/sched_ext/include/scx/compat.h
> +++ b/tools/sched_ext/include/scx/compat.h
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
