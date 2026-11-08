Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794147681;
	b=NUmN2k6raTDsYw5l48qQ6y5KS5E/aeuIuWQqBiQMqgt5Nla9fFRaAhRnHhU9rZrgQn0f
	 QO9BW1pKbZwqDHTo3h7Ud8RJUSBc5iAEeNZj4bCzMSi65U9c1LNY6OWGtIab9KVNBBNb4
	 EhiMqlxSCxGDdtfGraOvPhcoQF0ikLulRDQIKi/iRZAKNnGiLCH9UAYUDGQmNWWnJNoPG
	 0Mdpq8xXITNxfVtj+K4FKc5HiRMYoGwWNp/HvCdgfpE1fD1qSG6CD2OyPxC18Gw3EvXZb
	 +KuEsZe5j48ihk2Gf2C7JOTOysaBRbV7UuylHtQztCZlrNGKwo46FOXYaD2fMp025lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147681;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/gyZSdNkOds5XJdGsOwuXGMcUPS9EdUu5kTJG3A5Y6I=;
	b=ZLFhD/TOESw6p5uAvIFmMZu4wLyvPNv1YopAM3i7YkN7t9wGlsoT+yzbMaXdiNcEi0xn
	 esaPN5DhA03AOLtjPZiIr1//rryCQGHC0GKuMJUgSvCf5UyrF2vV9A8Lr6y8BzIl/FnMD
	 +Jquaf950z1M91VsXQQQGuAmVvIIZawwoTHnZAujMVQT6y+GJqVrM+YAbk6y8JqD/qJ6O
	 XzO0oZE70V9qU2M4HFSnpYEOhW/isoSFneLjIZhpZBJgI40UYdZI9IloxnaiT7QIZHkqx
	 fiHcpiTlrGq4ea3QEvwsZPskAKtEbRLpJpdeLkHHQlV1gn7deMdDgfnxwLbM/A0uDjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eZeBJhaK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.10
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012010.outbound.protection.outlook.com [40.107.209.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B20606A31C;
	Sun,  8 Nov 2026 14:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68B20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eZeBJhaK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZJRiPS6az1Uj0BaeProKUrJmtVyLW/xawNaylCaFu/ptGQOrEHe+pJ7hNH8wXO/dv3cNvVT5xGVYk5tp2osAjGgfaAw7Wf0hoR8eYpWkq8Xmb7MVg+3XHeWCJScB4nPdSVc/T4GWcnyBPC111e3GJPnYaXPUvRN2xH7ox4pGgnSjrLSU2Yt5T66jL/cncq15y0JBlG0leODpqKmh67E4/O/Rto0XEHx8PoSSK17E7gLdF1nANx+u85rL2tjzllp7DQd+zQ9y1Eb6lYwTVZdTh4GPeqRIyRTWUWrDAA7y8MVRzPAcECJgLK2J/SssaxsvPrNdpjhFlmJtrDcEjdQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gyZSdNkOds5XJdGsOwuXGMcUPS9EdUu5kTJG3A5Y6I=;
 b=YI+y1RezQ+VjuVJHfPpAw2vXjOK1edwqlLxgcoYiw90XTGTjwhbXRuhU6q8FFIXHLHj3KBdC2ZlKt9uWHLIruhjIdAhQA2lNzPJMaXAMk4GOzNXl+rQ4+F5pA+QCCDVZp2AEY/RjTIQG8ltiMIAKlwrmdngJpJpG/8wp391eQfK2rv/22tuxzr6H5dzgnnEdvoNMGL+sKmH6RM9Q67BVegn29/H/uS7OeiuxIauBpOR+3DN+Zp+6ZIHgq6O//UYR3unbXncWeMfMDzKC8E7wYXtIPb5aJO0dcklVk+GOp03VM1Nll4LwUtBL4ONar1Hm/cQgDWZ3O1N6M3U0zSEd/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gyZSdNkOds5XJdGsOwuXGMcUPS9EdUu5kTJG3A5Y6I=;
 b=eZeBJhaKAPsu0XUiw/lqjJT2B6gwOaWwzEfRwXgZ3bZysCcxDpUE590nzEVn2wrGWwHYNu4CwobFTkybyB5M101oHiKTkve45+ZGKTts3JDaiZozA/QK9NSYe1qj/2gn1iZ8IMqsuG6w/oXqfDBHmUJPJN+fsTDYCZtSRMcKBF0XmNHTsgk2Ji9XZ3gab8kfEXOdHvzmY4faNvQOiNrpLU38QDV3fgAGUxuhGVN59I6UXhEyclQzbF+rXIbt6F7ruJRJqxcN118YQjLxVzN3hFgDZ3uDBxuWTriJBkIDh9aXBXOcDz8phWLMcJ+nUmSdAA3PuLEu5ncxxPkCtjBN9w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 14:21:18 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 14:21:18 +0000
Date: Sun, 8 Nov 2026 16:21:07 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Max Boone <mboone@akamai.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Donald Sharp <sharpd@nvidia.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Debabrata Banerjee <dbanerje@akamai.com>,
	Nick Hudson <nhudson@akamai.com>
Subject: Re: [PATCH net-next] net: lwtunnel: use GFP_KERNEL in build_state
 paths
Message-ID: <20261108142107.GA1230892@shredder>
References: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-build-state-use-gfp-kernel-v1-1-18084382f878@akamai.com>
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 05dce6fc-5be5-459c-2a1c-08df3da38df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|10067099003|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|56012099006|261021135927099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	pAnJeRdwDmDuLvYm6L9gdbnG1CLIY0IjQP+LX5R1VrQI1Y1ZMO1AAcQWx2VvsxK94P4kf5PZ4R7MpGqlw/oxj/42vmGs4dlTNJZZ0pEWAqGhrM/Z8PTyXJCl4OJInkr+9q0tx9nLFPHZclr1bd8a3XP6WaiLdflDqrcnIp+4JT3zMVvz1oJzFpFTXI5sA+aHL0LFu4y+2fpU0vPHtwM898lUSQEAjtBZtaSZyENkMBaYOqcaYZ923ynzp7j7cdA+2TsZ7y4WwZNch7GQlQkRa+UVO+iq+9/Z7kdDjtprwf1VICNG0R1e8MaAC/L/HqzjEN7I5eSzaa+vi6rzlcCNacG8nCOH3XF5jNGcLQNrVp/U3BXSguVbakZGAhpuEPNXCWGLaSWAhtebxVbL7DYtxSWsHePDfZMqh9mXGutn4Cr2NxPEDs0EUM8y7B9xoP7UtcAFVVoY46wmBr+a2abP9E4GJv6ZwxrmhFd/7T9D9ZWDUP0+GNXh0KASDTGvgTSuDh7lTwOp1PaV9nMG7E6M0SuyYSXbqyp1o2tUhAh1+szppQbdcUp5fA6I8a98uKjeV54+DtieLKCZxREp0qTqrjMPX2uUIDwcgflCfhTU8d3DMVH0hC2HD44hq1Alo+7fVxQPONsTUnZwIcUU+InTDfdFIBLgt0yQvV5IvBLzSK8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(56012099006)(261021135927099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H+voukbvMaevkQGMRyoCGaAa3zJu9+N8eBs6h5zv5SYjbz227IHDxtWT5ZkU?=
 =?us-ascii?Q?HvVaUK/TRS89FIItVetFwWHAuVqdVmSRIsZbbd1ANYZSQQzBmjii84wUjfLJ?=
 =?us-ascii?Q?0XIkMmwSbZwB7e/0/dHhjiZpyVlO1infJ/qvfd+1w4vbLH6fwPS5c1QtpB1a?=
 =?us-ascii?Q?BOMOtYxXal0O0dxfg5hiklzQRCaYvim5p5vRQ8zV9wwd+ohVLMuWThyv67Cn?=
 =?us-ascii?Q?pVn5Um7Ugdrhp7XbyN3a1b5o3wp86K8ld1ele5bdCjS9p5LuRvyzyfaScXFO?=
 =?us-ascii?Q?VITlS96wiClFCGVRQL0V7I9aqEmfCkj0xOI+sLDcffuTAdeJ5YU4q32dizbV?=
 =?us-ascii?Q?YtNsTGOWaJZXYmmquIOgEdl579PzBFBAmbeiNkcRVeYKSASf0sCGeEshLOPw?=
 =?us-ascii?Q?R7YBZtJkm617IrAyFu/zZWNys8mKs6v06nLOExI8xm743tR+LbjgSnAd9XRB?=
 =?us-ascii?Q?D82YTCCihhoG27PsjAZs9fbb6SF/9XmozJm2TaAm4l6XqTWbBUhkFKBq4uKz?=
 =?us-ascii?Q?n304dhVN+MKRQj9wqPwvGEs6UQyrOXJZw/dOJXZuOLmSGHzERKFSK3eS+EG3?=
 =?us-ascii?Q?U97dbvx/DclxZiiSvqlTQ4r3qfkJyGwI/r/fNKwa9mI0RqADCelIKCoiQ426?=
 =?us-ascii?Q?5+y99ynjJwxJiryopBBlN40dCOdUXNQqPnSdi3JkVvY42pXGknzHwwwJIGmP?=
 =?us-ascii?Q?E35fSvgE878wWEKbb08j+GAJfr8m5U0sSMpc7bcn8QrzgnbsHwwn/9Foii22?=
 =?us-ascii?Q?ItbuZlUXaZQqQYSGL8plDZ9XdyI7Qt7t4kYhgi4CIIBnbk+f2COUm7W7/zWl?=
 =?us-ascii?Q?Zl8zEUi19+n1zj4ToYu7LyKKCJS1aXnu/5Isz+etp9BQNdTyleWf4bk4Y4r9?=
 =?us-ascii?Q?5FubKEB/l46DWTITg4Mcmp3XI0+eWY9yfgceVx+HIUXwEtfm/t2KAHBDDtYD?=
 =?us-ascii?Q?HzR0oHnPbQl7iRHml2xZhvlttIW1nSXS/XPQrDoEjQgMMD/5+0JAGTrm2gmM?=
 =?us-ascii?Q?5Lbwk+ybAZkuUqM1yhUOR9ZIiQfGD9/SgbvhHtZyDCeSZ69ZjfTMybhvt95k?=
 =?us-ascii?Q?Xqg+Cn/K+wdlf+7xqUYOawyjboycEb0EY4e8joAWFPCnDkJ0LBFGCsqqHSs/?=
 =?us-ascii?Q?BSsXnr/1nhM+WcL14P4D7O1QKBfAD3TN9GVOr3NlPZf1hw6Ss6D7qT26pjMn?=
 =?us-ascii?Q?j3fCbNs6UWrEEz+4apBzM7o0a1I01w3DF/GOmvMCP4EVzKG5F9F7BjpkL6lx?=
 =?us-ascii?Q?Yw3etB4/XWkka6+02DjlXqklFcrfpNaZa1/CuF3482dKR8fpcA3WJMky14DB?=
 =?us-ascii?Q?ZpwBPEEiHJgyPUqtwQCU8scqH0Y3OVW+FSXw5aRrYta1QG27twqfdy0JYmZQ?=
 =?us-ascii?Q?+9XquVPyGX/t1S+uJaZ4HdxlSBl2rsuri+JGk4JVYlrLMYZu0LIrdjoqVJTk?=
 =?us-ascii?Q?ZIsejHBvL38Z/L4KnTjxJDAsEI/ekdpOlfh0kqgPiM3cQiZfxEXa8LDGvAmO?=
 =?us-ascii?Q?nHpttfE5ladi+3ZPed4QIhM4uH3YrjHUS4QDKuwQZgAI+RJzn1JSMH5+nyyO?=
 =?us-ascii?Q?bEWNyMRV4AQzzpHkVN2O+RUFDHBUChGk3RDd6oWZb9Of8Jv7lYRRqiL/O6yI?=
 =?us-ascii?Q?JcGS2wU7yKiOY0ZMQS2w6LPkbtkKUCxqEVN/+Vq0Ed/aMlKE2NewcyyJQYOl?=
 =?us-ascii?Q?s5ny5n4L9KGUrzh/JLPwS2ktA+9bET80eJPMzzWPC2r3SR6z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dce6fc-5be5-459c-2a1c-08df3da38df4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 14:21:18.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRhKtuxUbEzoUa+iqxOyPAuM58+7iRj8mZHfkbymkPbrlQ5MCj5Dprgyhwn3by0wAKUAFCn5uS1JMVGg3Bkkyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049

On Fri, Nov 06, 2026 at 12:40:55PM +0100, Max Boone wrote:
> Since 3d25eabbbf67 ("ip_tunnel: Add dst_cache support in lwtunnel_state
> of ip tunnel"), build_state runs outside RCU and all its callers can
> sleep, but paths still use GFP_ATOMIC.
> 
> For dst caches, that limits allocation to populated percpu pages. A
> large burst of SRv6 nexthops outruns the refill worker and will fail
> with -ENOMEM despite there being free memory:
> 
>   percpu: allocation failed, size=40 align=8 atomic=1, atomic alloc
> failed, no space left
> 
> Batching 20000 RTM_NEWNEXTHOP under QEMU gave 10-109 failures per run
> before, none after.
> 
> This commit converts the allocations reached through ops->build_state()
> and are called after the rcu_read_unlock():
> 
>   - ila_build_state(), ioam6_build_state(), rpl_build_state(),
>     seg6_build_state(): build_state ops
>   - bpf_parse_prog(): only called from bpf_build_state()
>   - lwtunnel_state_alloc(): only called from build_state ops (also
>     affects mpls, ip/ip6 tunnel, xfrmi and seg6_local)
> 
> Signed-off-by: Max Boone <mboone@akamai.com>
> Reviewed-by: Debabrata Banerjee <dbanerje@akamai.com>
> Reviewed-by: Nick Hudson <nhudson@akamai.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
