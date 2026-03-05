Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413A1C68F;
	Thu,  5 Mar 2026 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694209; cv=fail; b=Z9spgY2xPtMvE5fx+kXQzX7u9EPbX7ImfhC/WJ990uywoOZP04Xp3+rfxZxbGN467EXXbRTuKMGL9F46Ksje+wNLiyUoz1HWy8EoMaXzsY3Vkq1OLDR6+ogJUG0nl9x83oAdGXIc0WUzNUAfaZQXKLVnzy5XTVFVjO4/l2Y3GoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694209; c=relaxed/simple;
	bh=LCjCspAIJZ3+Oymrd11A8AEvbblEGKXyvHGi/1naQDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qg4TzTSH23oIbhvU6f42C1hfHwhgfW0McDZxSjx/LF3J2HA25pRRwGzsXOUG8UVjpCtiX1y+QZ1Qeps3wAcS/KaYjKHpGirPw4YugKkXzuJTNyEHJoISgOpOf1T3cPjdaYbZzTw8plLmNwSPCEpa5fyfVKAjL+HGOylfqnlnM/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MRRSPUjP; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MRRSPUjP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdE/mXNW3IGbd2r9vFC1WfKQJ8CoD88ntuclfwQRpQbjJgLaMqt9sUWyraSDPq1fL4tlYE9hFDz5pBqqwnV09cv4inLsKO1WwwXqW+JlP53eVUBVZHQIKO+FVMQ8JdcI8jWW+YvcxiIojwm4pw1bHENgH/7DSAyh8ddftLWwh7+Ewiv9OOuGxsfxcsStwMsj+oxAFxJ9btYpfsw5B66KvfKpSC7kPlI1otrGuqY8QL3C5maE+STcvVgPSpCvQrtJHT/GQZ0WElFMrkw9m7NTALNKcG5KZ5cqZ5/Nwyw5T3KPgXyBoTbfplSKTMeLkn6uFYP3jy1ODestxnQ4fBrIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7x/Iz93DbplPNuD9tUgrIBZ0N3jey6qdlnoJjKkCTY=;
 b=vx9yS4IIQQUuc40GpnzKp79yuijVd1LA57Rr1Hie5AofVZlQ7r7jW3pg+HzvMS1dUEHVHWVOJHLxMbfMS6B4BGB1Es2aZ4T2beFvJeHeOv/MQRrSyzN7LnT9Dv2X+CBLTCKP0P5fWeEfNi0ZOGA3QYFPkeB39+vAcvLqYtaIcoD5mVuAtlilj992TMd4hJCJzFkp8v092qpl7mBmT3/Ic3xi0NKr02EULU7VFwCa9EUL8b939gIxajmhZIVxbxByCBHC8dxEahxmLs743X/A2W1Rj16idjlYsPOoEpuD0KhUF3k4o8ZW6JzYDD6mJwZN2qghR/QJBVxI5FGqHb+oXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7x/Iz93DbplPNuD9tUgrIBZ0N3jey6qdlnoJjKkCTY=;
 b=MRRSPUjP/vV9N50bDSPOzYfbl+IWKcrRAcJw0pcBBmI6thj5tJyl1UNPIGYjxkRpHBqCcSmiZtppZzhQ6y4geldVH/1kKGOT90cY+VeNsLYARpP1hu9qU1eXRZ7fMAlznfkCveH7YPcu9Z4HXdlB64+HouPBlRfMss3+ykBIEM52LlBKRjvBQvL42ldY43GrjtKYJVyupO13FZrkhV67/9Y6HZ2mwEZoebjzsxkAw7Vq6lmMtGOn2apacrYjwl2TqUp9T3Fp/SjTDTad37I/VfWFuckoCymCZ6E5PlnV6K8aWsjk8+4YN6UTJRwis8z25NCFZiCyLmQ4kZ4NDc6KwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 07:03:25 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 07:03:24 +0000
Date: Thu, 5 Mar 2026 08:03:21 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Prevent invalid u32 bounds in
 __reg32_deduce_bounds()
Message-ID: <aakqucg4vcujVwif@gpd4>
References: <20260220190736.230329-1-arighi@nvidia.com>
 <e8cc28373cd122f041a71f5818e41b7e3e4cffa2.camel@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8cc28373cd122f041a71f5818e41b7e3e4cffa2.camel@gmail.com>
X-ClientProxiedBy: MI2P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 630e3009-2b02-431e-4670-08de7a854b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	1IZkHejJ7693DGS32nDB64oaZZKnCOWcDOL9kTS07zoZAZ2eFtuwccJB8SWm4BrOawrPz5aH+ilXb/ufKpx0+neViEoRj0Eetlwz96WGBNfLADE1xzXqHbZpKKQFR8Nloweou+uH/Yok0QM2JrED0TpXs4gPSlc640WetHPCOxQhoWa2kaL2BGqF7Hig0NhtDCMgOlXA56BPGpqBFunUvcTCoS1YN0JV9aLwW9zTwEjdXl2nTf/VetAovesMTYaUh9Gf6jpc/g5RgHkpLp8twEnsEX/GY+7Q34sL4ttQ7Ak4TikhNMzImwZFkSe0yMbGNm07NVVUUjRPMA9WOx13Hskd3hMk/u+SRRr8NuapeU4adeRQRSJ4YLeGymAh1zRB3sHgAk8QX7Xt9XPxACDRkCmVjrjBLFzOaEaYP8QnfWY5yU6h0Bhlww+LP7P10FHtKl92Ca1WPumWJczTD+56F3z0NmZ0T4PACR0JhKGYxm1AtKTZMbJX8/NAI+TlLy0TWHBZEZiJXVmB0AGR875z3+6/7/0BZ0O2lICILYkpC/MHddVRhc8NLn7ZXNNzkP/oqbiiAidgvEARQ/ziCOOONM3LMU8Rs+q4CSswNvMywP4Qke7A2Eo7cIgdM+yJUJfU3eyPQa8+IRul0xNnQnRQgUi+dPKFtL29DbPB+hggBH+1Ds22GOPGqY2RVAEebJjrNB8tlCC31I0qOvFKqnf1QYPItUf8Tn4cgVJpxgL9WfwbgrIdEls/BhLi3HNk5q8n
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFweCqqa1TUgfBGFoqLvM3WDzN0tZzm2tk09Aqi7Olo/Opn7AzZOCBJiFy+D?=
 =?us-ascii?Q?htG8l62PE8iBwobsDKBbZ7yWyIpt/JQdSz9n7C2PExO6ejAdX4TbgUqnKVqG?=
 =?us-ascii?Q?obFHxfrwN3xLnxbJVIwkUcX+UG3ZkWbxKoIQF9SFy9noOOno/wjRhKE+vcSl?=
 =?us-ascii?Q?tT0jPIwBgONlMFF4rxjmAI0bArK5lUpwrXBlbSDIt2nzr9viBAGY5dIKKtjL?=
 =?us-ascii?Q?6hOyiKEy6p0oFKHX56tEF5cfiqbq/KLTf92E0wbRkfJJTnWFsOyVJgELJlti?=
 =?us-ascii?Q?MPJTFVnCrQO0ntVGuGrSoEw0WOlupnwtag9bc6EphpLHocDGsrbEeRQYUTfb?=
 =?us-ascii?Q?tfVhQN/XLtxy5RQ4zYWG1/S4qaZ8l5MaElQZFW7aGyCvezlxWB8JWVyjGAzJ?=
 =?us-ascii?Q?3D32n5a+DF29Yy35IPIXn1jd0LPlsitoxGjNmIeXXZHatXFQDPLHsho3E8mH?=
 =?us-ascii?Q?NXIQIaw2CZtTZFBsDO8Sm8OkKvoImcicxSDBE7oWn7+SgUCs5/HZ8PuHo0Kq?=
 =?us-ascii?Q?XykCYdMSy4d15uHgizDgYs0aNHESiDjXobH4SCCUjZYTnyaJoL/vD76l9ST2?=
 =?us-ascii?Q?C/jlhnR0UBZd7pjHOR7zNnZwr7COkkUdQb+1NXleKTBoHn1G58Q7bcoOdLHH?=
 =?us-ascii?Q?moyrhkI9ytGlUp0HFZ/wjOixDja5lxsn+wL0Iff1SUdHiTAa4x0e2GIM5e5O?=
 =?us-ascii?Q?BTszqqEgIvtDV3Ueig2Zgw9DdguFFYRGYBVLioQp1WKRefj06DEmYmv7e+fj?=
 =?us-ascii?Q?sNDmhEdKyK8eVe0oDKYNjGaxefP2ybVI6dNUGwGyWFgVIb9dlXn2PQqrnsNQ?=
 =?us-ascii?Q?1MQJSCh9P9k/4AV28Bk24gH2eueKQkYXSG5/53FA1Aq1NAC4tq6vgTwOUUVp?=
 =?us-ascii?Q?2ZVTlEzNPvPwXOSCRejzy3DEViEhoG0nR9CeZNTqrCpAjvBD/m88DS7gSnKF?=
 =?us-ascii?Q?N68ZdPfobe71ZqMUZdUmU4rSJPUBffHjMOlsK/0DRGUiBWHaxaxxjZf2EuRq?=
 =?us-ascii?Q?sZp9CrQdcVfWBwKrHP19A4d+LdpiZt/ScO/LvsH4Asek+2Fn9WJb+nOrXYpf?=
 =?us-ascii?Q?oI9svLUtVD2Y73W7lM1Ru4A+54IXWGmBcp4XYO9p2rEc4vUA9ICTlgZWN/ru?=
 =?us-ascii?Q?/Hh2cZEW4Q2q7sz1SrO/mfYdox1SOb9ZZjeps/+9J1zYLD7pkhO7w+ef1N0D?=
 =?us-ascii?Q?RLcYZY55OH/6I6F2rgtATaIsDmKJLtu6cX684FzRA04tzZur14lY0oyVLGFC?=
 =?us-ascii?Q?/HUkUbZnLfGgex88+etuxztn8wQuFQaaBhE5L1RQDklGnbLut+lV9+JFEBI1?=
 =?us-ascii?Q?1tbHc2UBCPwWQ0DlpqKMHLBsQePPjd3tcXRyQSLV0At4XFQp2n+Y3Efz6Kxt?=
 =?us-ascii?Q?En+XKcWt9mHaqGcRFg0+4UrnZkXszHh2FekgeJa9ax0U9DIxQ2v5vyIGXpET?=
 =?us-ascii?Q?+6X90BW+vuWIRuw//fpQG5/OPdmsSpI8aCnhH1l46rgGyujDMsuhHwB3YPyX?=
 =?us-ascii?Q?XobzTQODwa9R0a6zlBG//cKY3+2nTS9A05No1O9TyAi5IwwUlPQD6GoCyxSY?=
 =?us-ascii?Q?ZX5iH1v9n7TNjYbc9ZYHiMYlNknECcDfymLIENQHUk5RQU3AvdPlqqjoIiBc?=
 =?us-ascii?Q?3CTEeW9QwZx1Pb6DXVB0/AOg/MC4JXXFgn77MN8gJPA3UqfUxWsdNjquKqxX?=
 =?us-ascii?Q?sZS/z9BW8JveJLB1YEW85ts7kKh9LAiKLcvFuRo0bGQpzt2QV/rYjEPZPx9m?=
 =?us-ascii?Q?VLGvByAwGA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 630e3009-2b02-431e-4670-08de7a854b3a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 07:03:24.7044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kl/5j5A+86YM+/++IaKVWfCizxvTYJRsLTi2pG0J+IZK1XBZZupbhYqml2+oEgZFaDaOIA2tQUnsCNYRqaQIhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939

Hi Eduard,

On Wed, Mar 04, 2026 at 11:23:13AM -0800, Eduard Zingerman wrote:
> On Fri, 2026-02-20 at 20:07 +0100, Andrea Righi wrote:
> > When refining register bounds, __reg32_deduce_bounds can derive u32
> > min/max from 64-bit or s32 bounds and assign them with max_t/min_t.
> > 
> > If the existing u32 range and the derived range do not overlap (e.g.,
> > u64 says [0, 1] while u32 was [2, 2] from an earlier path), the
> > intersection is empty and the new u32_min_value can end up greater than
> > u32_max_value, triggering the following warning:
> > 
> >   verifier bug: REG INVARIANTS VIOLATION (false_reg1): range bounds violation
> >     u64=[0x0, 0x1] s64=[0x0, 0x1] u32=[0x3, 0x1] s32=[0x0, 0x1] var_off=(0x0, 0x1)
> >   WARNING: kernel/bpf/verifier.c:2742 at reg_bounds_sanity_check
> >   Call Trace:
> >     reg_bounds_sanity_check+0xbc/0x1e0
> >     reg_set_min_max+0x1a2/0x1f0
> >     check_cond_jmp_op+0x5d2/0x1980
> >     do_check_common+0x2b0f/0x3410
> >     do_check_subprogs+0xcd/0x180
> >     bpf_check+0x33fe/0x3850
> >     bpf_prog_load+0x7d7/0xee0
> >     __sys_bpf+0xea2/0x2e30
> > 
> > This was triggered by the scx CI while loading the scx_layered sched_ext
> > scheduler [1].
> > 
> > Fix by only applying the derived u32 bounds when the resulting range is
> > valid (u32_min <= u32_max).
> > 
> > [1] https://github.com/sched-ext/scx/pull/3349
> > 
> > Fixes: c1efab6468fd5 ("bpf: derive subreg bounds from full bounds when upper 32 bits are constant")
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> 
> Hi Andrea,
> 
> Sorry for delayed response.
> 
> Currently the assumption is that all ranges/tnum tracked as a part of
> a register state are valid, and I don't think we'd like to sidestep
> this assumption. Eventually is_scalar_branch_taken() and
> adjust_scalar_min_max_vals() should be unified to avoid possibility
> for mismatch between is_scalar_branch_taken() predictions (when it
> assumes that some branch can be taken by failing to predict jump)
> and adjust_scalar_min_max_vals() adjustments (when it infers that in
> fact register state is empty for the branch).
> 
> As it turns out, the problem you report is a bit easier to fix.
> After minimizing the failing file with Emil's help I derived the
> following test case that captures the problem:
> 
> SEC("socket")
> __success
> __flag(BPF_F_TEST_REG_INVARIANTS)
> __naked void signed_unsined_intersection32(void *ctx)
> {
> 	asm volatile("			\
> 	call %[bpf_get_prandom_u32];	\
> 	w0 &= 0xffffffff;		\
> 	if w0 < 0x3 goto 1f;		\ /* on fall-through u32 range [3..U32_MAX] */
> 	if w0 s> 0x1 goto 1f;		\ /* on fall-through s32 range [S32_MIN..1] *
> 	if w0 s< 0x0 goto 1f;		\ /* the above ranges can be narrowed to [S32_MIN..-1] */
> 	r10 = 0;			\ /* meaning that condition can be predicted, */
> 1:	exit;				\ /* but verifier is not smart enough at the moment. */
> "	:
> 	: __imm(bpf_get_prandom_u32)
> 	: __clobber_all);
> }
> 
> This branch has verifier modifications making it smart enough to
> process this case: https://github.com/eddyz87/bpf/tree/cnum-sync-bounds .
> With some additional verification: https://github.com/eddyz87/cnum-verif .
> I'm working towards submitting the fix, need to decide on what to do
> with reg_bounds.c, as this test is now not smart enough.

I see, yeah, my approach is more of a defensive fix, the right
architectural fix is to make the verifier smart enough to never produce
this inconsistent state, which is what your branch is doing IIUC. So feel
free to ignore this patch once you land the proper fix.

Thanks,
-Andrea
