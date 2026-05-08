Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE2D2EBBB9;
	Fri,  8 May 2026 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233061; cv=fail; b=REzGGlmrgge5iLVKTDrSpk10p65x0gCxrgfopAUN1yzHIjllmg9HoE5rVCJZaHLdA7o4Czdu7Tm9zYlNTHpmSrmf+8NtdvmpPUblz9XPbl5Q3WdVu+aX7VSbuXLcCLsg58ncpXSFl0bw5K72q8sMt8ah2Vco6oaiPSBev7O2MpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233061; c=relaxed/simple;
	bh=m94agWOGkG2FLSvIxNm1JvYrfDAiFS+7LounjQewIe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pklpp67rfrieXvsxqjzxZeSRtUcCG6Hf8LK++b3t4eQpfN4z914lw+nTQ0ypcN7R13m9JHGas1kGTETLwqanftWgh6N5bRxI8rMOb+kW0UBOaeX7yGPR3gZT2QUv4AOUaKcaTAt5/bRGpZbNUZFjNffMGdcLK7VCuD7dDvND3W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRxNP1MP; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRxNP1MP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybzcq1NKMUI9AoOV7eOIzYa1tJCDR2iXmOl0ogXCOq+Nx7sL2eI3UywGbPaD7+lN/DdNbtggfF26tMYOopXXeSU+IY+AXew483+9qjp6tKMwhXj4+L63EQw4PTwnZrjBnc9jH7ULxnjfxo55BdQt/kJPJYYiyaldlEM/9xouUWL4ZRiCV6fB307s/aaSZm3drJQV9nIAcs0j0rnLL4X+ssXjLrLTfMwVLRYMNULrH1s95mts9lahhfvo5cOKCG3QHT3MBjA5ZWa1URr+IsKmO/G+R2flUO8M617biKj7hPehgYY+cyubsEuABsAYkXQHJbpHpkiSKWT+8Vy2Byo6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=989uCxh9H4SVhW6iCxd5ssUbirCvVCDF8hgKWM8C/u8=;
 b=ProuuIYJSLA85ie+8tzjHg/sg4S7W+O38cVuyVi0qw19WxecnH5ffuaC6EDLuhzit1/Rc04xHXPCNSmzGaqE3Q24r8scYvnFA/nFEmmOjNpZgv5tcUz5VIc83R74sj2FXClARYZW38x5zCX+8uzAjBDzH3pJiBmjD0TynN/KUe1u7hC4+uW27eYTmvk+URwUZLI3qObVnEqEQQel8Y+RXkXqeebQgpr+OK0+9kS771YKwNSoyeY61gF5w5dI07r/1I4gl2iCIR6qgbFow21V97UMVSaRixQt8H6i3SuADkEzaIvgIUtsLD5nSUkuV6sspy2dp+KiBB/zSRYnSe63Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=989uCxh9H4SVhW6iCxd5ssUbirCvVCDF8hgKWM8C/u8=;
 b=GRxNP1MPDHXWvfLaQB1s8lJw5kHK1NMC9e19euGZwNNv6D2in+WnVvX7SxHpadDwKnWjQoONzZeArkqC0MvxkrwyOFRjf/HDM5+x3dOq2VkwxjDjSO7MbO307XPQRu8IQy0tJJFy33W8gqMsonVoGxeXUWdwsVyTCYEIpx34Q/O1Azxe720j7SdeDU4y/KEhGZ3SNFHYqtzoDCypMmUjSbgilqy0Lr/AVv+AzczRh+b0XJNBGowX79bifXcKSuZVw8NDuu8tvwbP1yuDyMqCaI7j79j96AsaZIp9/B5cCsbRyMoMBaMbhnJbuomy6JNWUHcs24RMVKFk5z8rP40a6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:37:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 09:37:34 +0000
Date: Fri, 8 May 2026 11:37:23 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Qiliang Yuan <realwujing@gmail.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add scx_ai_numa scheduler example for AI
 workloads
Message-ID: <af2u03T-pyvoDgYK@gpd4>
References: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
 <af2XRpaX_rFh_GI9@gpd4>
 <26f2d829-1083-4cff-b737-a3701c7ddd85@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26f2d829-1083-4cff-b737-a3701c7ddd85@arm.com>
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 4accf06e-c100-4edc-7e10-08deace56eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LMIcaXN1YEA9aVZxd30ZVKp3JDfc/w2VjlmsdPu7BQrgdQfmksmw3xJI3FgVgQk8VYfWHHxcOqA6jsHsP6QxIJTHQhcHQ3rc3gKTR+ie2B4+vcd4hYwwFTPd+1D7adLA133wizY41CRHWbkubf9UXgZokQNCFJAciJtDdMRTHmN6XDiSc2cNaVVOhpnTFrkuFU2kUdkVEo9DIjHP9DBoVsub/I0C9h3Z9K7DtTP8hKzN9aywW39jN/qFZ0P35ekr1r6Z7BVWe8/jX0x4ADl9VUlqiCVp/yNyn0YCxXTECNLkFyw09gdyPHZWJcwwqHpRt+JawwI7aSXkhOvF8r/N+p9diKH8yQs31rv1b0Lz929AmVKyTg/BKgjUHxz7OXXxFF1TEeNlic9lZ2moUbd+TImRrOQSvu6X5zI9baXQwHlCdipliIvOvsi2B7GErGxhH7HJ9FhTyC6DXOfAfQoph52YHu1Z6SJplHnUxE16zPz4uXUSRNSFPxdcp9BBBf0Gu1PY3C309RelG17PlNGDX284Vxt57HtzewO0q3bChcxhiGs/c/lnxQ1wda43UZiSwQPayZ996L294wP5tiqWiKthb1s7PFdxlDmI2fc3rEl8a1CLaXRRvyIt7ocsFdVrxzvv65EJulMvIjKU6qxyzds7y+DEtyosfAnLdbhzKr9JWBOg6mV28r3g/Mrw77T4od2Mil7P9aZZqjz59yfygA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vgiD5Pn3uZCZ1aeKupykZU4ZfiRsmvERAcNXYFbYTnRq3BYrLRsgxqVvdtLD?=
 =?us-ascii?Q?iHLey/2kY3LZneVN96EVSI3+8lqdTW3Ki77Kv5KcnxytuzQcrGBG6J5ModB8?=
 =?us-ascii?Q?bhZ26jhgkzSHuBhbz0cTCKLTZTrziL2cxEdwpQbA8sZhBA5lY3TP4TcZxY/x?=
 =?us-ascii?Q?bGmMLZGsx/YgXqsruqngee2Ry7eJJagAR+a3TZwTw24ieC26+6ywxF3OX9rz?=
 =?us-ascii?Q?pG1Xv9arGyuCup0vZ0HOW0UIMZX2njajSqRdG+8FKCMWLTa94mHXGGmjVhru?=
 =?us-ascii?Q?NBTj6Ijn64M+VV+ciZxmRK447zzYbhrQentB+nfaIBkO0E84DbOC1SjxaTp2?=
 =?us-ascii?Q?vtdlwPWPicbHKn7/1jcdqh5+i+hq9rLisVLhjtNAViYDET89uH+9DAtit03M?=
 =?us-ascii?Q?iNtKNxva8YzCG6uAtxUYQ/j+hqrDUYPDm9FSeffwKea4njbMdOQLY/Y6b3pG?=
 =?us-ascii?Q?Kp/1n0bf2G3z/xT19ONonHsbVGDB3q+thQO61e7xb446d3DQk5/4Mki4DJy2?=
 =?us-ascii?Q?aHYXWTFSNkqWxTjCsf4oyIyZZbYnqUa+sC5yizQ3oQvqbYqr1Tt3Z83BfJO4?=
 =?us-ascii?Q?WMAlHgYPzT53SvP1uaHya+Lugq933rbcYiGC1MsLXmEQfflwmTFxP/CCRukE?=
 =?us-ascii?Q?U4t8L6uQPR2vmA97gNoe6k/zXSYTj1JM1Wv35P4DpuW0+IYKGm5TW40SSY5L?=
 =?us-ascii?Q?ACy4rHgfEqhe1oPltIyLBK2sHD3LSRuPxIxc/W0uZptBKMktH9+JdahAV8PS?=
 =?us-ascii?Q?YJUuTtjBfa0zHRQfjRfFPZ5nh+ZsRqIr9nbc1PzR2EsDKtNwSS9yXEavaI/I?=
 =?us-ascii?Q?K15SaedIyezwVqpx87R96KlX+FLfV8hOgeuGCRFPLA6utkTRAR4SwRulB+0A?=
 =?us-ascii?Q?GSg1TsY7uM3cMb9iqsFKxT8ApLA+MuwcTBVMnPHlXkl6qvMmoMAfHNslzdQ0?=
 =?us-ascii?Q?6B0KjQF8SGFyhJ+NoEQIiVcGvJXu7+UKXvBTBjWlvCSYaumHkf9vQtQFCprn?=
 =?us-ascii?Q?NrklYQh00bAsQKeMHpmLi5x56feh0Bykg1wt4mgegb5pRHnoVQ1Tbpdj4qGp?=
 =?us-ascii?Q?ShCzomVRvsmjRBRPJm1LZ1fdanNKzOY//AT5NEYDU4/fL+G3E5xiT2V/Caeg?=
 =?us-ascii?Q?HmoPic34GxAg3WR+RGKEY/lzNdxDhWSMKhfdBUnXVV2fLa1r/4AyxIWLA74X?=
 =?us-ascii?Q?Dav0JREl0m1HbD1T92na/uu0amZKS122HXEWUI5yKQ6BengLtwKf7PukcrIU?=
 =?us-ascii?Q?vDjNoZSNRwq/UDvdxysh4/Rw8kiQsYLQbAKaRriWyQb0wOnyiXwy5/OSmVBv?=
 =?us-ascii?Q?c5OBabOStp5kVd6OH30cTPdRlQTBRM+/eXeDBBSpu85Uwkcvctn49PWzLUQp?=
 =?us-ascii?Q?LwW+hYPJteZMPcXxKh6T2PNI1g2gJg751KCqNRvXUinD9tmAu1F9GbfkheiC?=
 =?us-ascii?Q?zubTzHyg6BE8MwT4T1JpyjiNWa5/F84yXBT/9ia/4XtWr8hy8rZ7RR8dP+tv?=
 =?us-ascii?Q?LQKw8sLD99xA1kWSnaFl7/8XWL2H7sFY5LfuKKur2uDFKKrBpLBixSFtilgV?=
 =?us-ascii?Q?hE0cybllb/2Xbk49RjrSH31siAuP6g2jEcTG6AKNL2p1c1QKKR5/PAZmfGOG?=
 =?us-ascii?Q?20lILZRba0rOVluocwJgxsop4galvVS1OsJ9koRx9VazbcZUYULGnsCQ8kK3?=
 =?us-ascii?Q?+A+pWWrh5ND3WD2M5afnmZ0oJ1xtuYRwdxdJvH3HwnMJzm6RVjBLlkQXRIn1?=
 =?us-ascii?Q?SwDXhKF/Zg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4accf06e-c100-4edc-7e10-08deace56eed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:37:34.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47YDt/JKNyKT73Mpl+6CCqRJDBQ0q1xSMku+7NZZe4oY+e4AtsAsz2KKQiL36kWQ+01sbyl+uVux34s7us4kQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876

Hi Christian,

On Fri, May 08, 2026 at 10:29:24AM +0100, Christian Loehle wrote:
> On 5/8/26 08:56, Andrea Righi wrote:
> > Hi Qiliang,
> > 
> > On Fri, May 08, 2026 at 03:51:35PM +0800, Qiliang Yuan wrote:
> >> Implement an AI-focused NUMA-aware scheduler that optimizes task dispatch for
> >> GPU-accelerated AI training. The scheduler maintains per-NUMA-node dispatch
> >> queues to preserve L3 cache warmth and minimize remote DRAM accesses that
> >> would stall GPU kernel launches waiting on CPU preprocessing.
> >>
> >> Key features:
> >> - Per-NUMA-node DSQs (dispatch queues) to maintain cache locality
> >> - Idle fast path that bypasses DSQ for minimum latency
> >> - Per-task NUMA affinity tracking to remember task placement
> >> - Work stealing across nodes to prevent starvation during load imbalance
> >>
> >> The BPF component (scx_ai_numa.bpf.c) implements the core scheduler
> >> callbacks, while the userspace loader (scx_ai_numa.c) detects NUMA
> >> topology, installs the BPF program, and reports per-node dispatch
> >> statistics every second.
> >>
> >> This scheduler is suitable for AI training workloads where GPU command
> >> launches depend on rapid CPU preprocessing with minimal scheduling latency.
> >>
> >> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> > 
> > I think this would be more appropriate for inclusion in
> > https://github.com/sched-ext/scx.
> 
> That repo no longer hosts C schedulers though, no?
> I guess it's trivial to convert this particular one to rust.

Correct, it shouldn't be too difficult to convert it to Rust and the scx repo
seems a better place for this scheduler.

In general, I think we don't want to add too many example schedulers in the
kernel, those in tools/sched_ext shouldn't be focused on production goals, they
are there to test certain specific sched_ext functionality and show how to use
the framework.

Thanks,
-Andrea
