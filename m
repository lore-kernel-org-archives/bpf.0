Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525319C54E;
	Tue,  4 Aug 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785844379; cv=fail; b=gjs8/JeSYSo843xDHMKfgUOZP58Ihr+ekHCSa98KT3dLa+eXFGLIPSfommCU3iNb+7GGPHkrX9X3hu/C9pqSA8AWdglr0cdAuya3CibLUKCL2LpQgy3yDajQZGIH5VYA36hqEdNWZ/0bCSg8Y/EGpLAGpoamVo/sfoDtWXpQ1Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785844379; c=relaxed/simple;
	bh=UqtC69FrRcSryO0l9l8pfE6V/V4iGgSEVn9vXUd4OUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UijDMJHks/IwdoW0EhKTtD5Y0ogLoz2DNPHBplWr/ib5DNEqPdhV9AAHOxde3pdveWRm7i0ECHCRO4EyPso4xpjbt2cJ2g9EgH8kIi1ZLk/EJYODxxlI2az10lJFEBMSJgAQ4ogsxGLzLuphszShr2TZcgixtZIsWRMd7HnvgYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NqjgNk56; arc=fail smtp.client-ip=52.101.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NqjgNk56"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVlEP6NH8bgox2NsowUJ6xJHqJ4pfgeq6T/PIwrvdIIpL0RjOQiPerMwscPPAUA/3W2gRg6XMTvTS2xW3vRGjZnX2sDzmWX6rnlUrX419c/gJOi4/KYIjsU7IHDmtySyac4ZIhPa7UGKqz96IZlIJE0NDQZyP5OXoo/6julaUNxpuT0MN+7EsIh439qp4MZFKSWMEQvz0NS1rPKQrEIPONlWeS/wIULEROL9ozihPq4JEo0uV470AsWlz+iQ5CC+Rw6B4pYUj4xRaIg1m9A2Is7pk+UUKD4hdGYi9BuWcJ+UQu+PlC7h5gEsCWOeEicTVnZ7G2Q3L5CtBjL5PfUe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUm/B+0l7qUjsXmbif29s2UHr6ugzw2C/kLM/LgTZms=;
 b=X5DrhaFWWERVrBf8smzpJG6AyaahswQimxim64TtO9op29XL8z/CJgGexpx5QDogxRZDV462g3QpoGxjznjrm8U6mmNGNpTr76J2V5PK3yrrYys+5JSgieqWaQp6lSLlm2QZR7AhZZ6CX+ndd4OmyiqqSdPgC7nF/20qRCZCZtCY30vF6SgGgsmVJ9Rp9ZMbwnp/PzscAfmy7Dn621LySqbVgTwpYqCCP+yCOTT4SDKAclaTFcXZnndqgLXapKVgZSLjf+J2fauxZuGmFDl32HX85mmrSgfZCaAMNxZhCnr7sqgolS9WLbRk9bzs0YZMYdKs0z/UR+Y2nFp7Y0GK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUm/B+0l7qUjsXmbif29s2UHr6ugzw2C/kLM/LgTZms=;
 b=NqjgNk567osHl16SInSUT5938YFUyn8ZRt5To6uQkstDgu2t7Fj6DrynpIYnAcioO4lQ73RAYH4bm8XdWX4Ih/klol4R0uRrGMugrkMGCbVrNsWbFf2dj3oC1P55AMoV04YVSBo712vwnYuub9APkfaDTyly3eSzGFu0EIk+fjDmKftdtDzE/IELJEiZSjJONkcJIqSd79rtXVnJ29VWZh+h2g06nWxLVOFXCaCwSmtfjtqpmrfeK3xxY/bC8ucbZZL13ktNDYj05tNH3EtOyAmY31KHKRvZYiUGLzuO81qVzd6A4kPSLcN66fkCRFUjWxi2GFg7VQzRiZemv46qPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:52:50 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 11:52:50 +0000
Date: Tue, 4 Aug 2026 14:52:40 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
	razor@blackwall.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, horms@kernel.org, yuehaibing@huawei.com,
	kuniyu@google.com, aleksander.lobakin@intel.com,
	maoyixie.tju@gmail.com, thorsten.blum@linux.dev, kees@kernel.org,
	vega@nebusec.ai
Subject: Re: [PATCH net v2 1/1] net: cap advertised device headroom
Message-ID: <20260804115240.GA1035024@shredder>
References: <0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fe8e20-f396-49c3-5f21-08def21ee8e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|10067099003|11063799006|6133799003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	w7nYr3fefKiVRCIamt33nMKYf9Uk8Kc5zgsq7cxLVO3COzqxedhjoQFnXzAEgl4518Tem/m8ing9x5QzTKTC3MnXJ553oRtUvAqHrpL5UyIvDkHSRV0V+AjbZ8ixic1bMPTz81J1yFKmSPgt4SP07Yj4FD3oRA9MwD+izhktnyh5bKzYmVeZG16o5jDceBhcJ0AQ+lroRJIUDYlzuXg6ZLDaY2G7zzJFgd5+nxW3bg4v1MIKP6lS4Nj3GtZi+IEFHDR9TkqUtUmr/xa53F9WJmHwZlGjBDmYhCeHbClXSqemRk/+5uHXj4jQW9OADoEyP7n3hMap9BZwsOhWwSA1bCCCkNEjmX9KoU76F16JC0lFcAvcOtkoxBr7tCe65m3tbWozRfdRBVsA3PYshLW0/63sZo9JEuG2FGXPLFoVeUK6ulyqokMRMpAmj5HtxvcllVdgS4qCMLKa78ev1olt04cjY6SNDmH84wfbmqzSPtFBIBu/qLUBudlM3KBVjWzd3OgqmuaacUP/CdUE2xLodU/pFqL97DX9NFJeYAGcwp2o4nuOgYnjh+FLFDq+bWM26stKOP/qyBBzB45TVtkpCttYcTy7YkoD+5qpf/jvVbUIV7T/xhn1dTgXn8f3a+o3oPCpJHu9h9mtLCdwr2pHI4yoI0luxpD/3Xtf1IOb1fY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(10067099003)(11063799006)(6133799003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vt30IqbsQqvJ38JiAKRZhRd9f512PmdCRdBR3bVivqL1OYL9FohZYnYfRa+o?=
 =?us-ascii?Q?SIyrOJy86zq5HaPX1+a75IRPDNK0gNVk5RB4TDdMPoV1tekVZ/4hAaRWRPiT?=
 =?us-ascii?Q?GyrNkvNQe8hZTFbCoct1RO0XzTsoOGXsQHpCtLSkdlh7iulUCNuCpShQqw04?=
 =?us-ascii?Q?+xP+J9eSBE/qmQEAnrYutQCzcZ1BKNo5WWxk+Kv2j5Ts1nFBXJ3WyNE7tUdi?=
 =?us-ascii?Q?RSYLa8wYtbJmG88YUYPKHRZD61rc5DztKEhJ7W6w8tS/Fzw9c24trMyB8FP4?=
 =?us-ascii?Q?QJt0nT0mqA5igA+pWrPAm1GMhm4650QndM5Uc9OTR9I/pWskf00z2tkyziKp?=
 =?us-ascii?Q?9h/tJxw1UVN2Yc11DeW4Ao3ijM9L0JDanNpWRsW9GV9ui8MH2Kx0sUxw+b6m?=
 =?us-ascii?Q?p8kCH/OWNFNjfSFuYa7DAUNBoZy98I+AclGW3nDbDOCknerfo/uhvBBIxIIL?=
 =?us-ascii?Q?B2plNHK4iHO3mYm9lz+BhZcWifu4rixJiX3E0/2A+Ttu0ExL+juxrz6+s6mK?=
 =?us-ascii?Q?0+9YBx0Z4hbOJ547JQagv9WdDpVn1hfmidbNTeDsyIu3LIMpAlXX20XWL+Ri?=
 =?us-ascii?Q?c+bJvBIQ68DcfnV/lfhW1ljgwuyzxLK6T/zwCXMbqbEk40zUwIRJa/0lpuoL?=
 =?us-ascii?Q?sifHeb6GDr1Ls5kn/+LNZQhidodCao35hciPWnMr+K4itgy+OeDtg6jirint?=
 =?us-ascii?Q?oYdhfix/JaNvILlDw2M2F/uA7dunVeXJvUOp9HUnbGlbr8MFoFVqvZpBwRym?=
 =?us-ascii?Q?+BOZ6SFFkeJ+N8uuUygfqoUegh5BNZ0fSRNytCTIN8rLI9xDCOljLTCBxVkV?=
 =?us-ascii?Q?zbM4QIDiPBCo8Pyhx29NLPXCe1CM7YKqergOum9bqbG0gWUW09UfTmRQgRqo?=
 =?us-ascii?Q?8YpfJACctta7MZXeAi1U2zgTpobwjhehsM09YUHvFMqLAUWRBraDwsoLq8lp?=
 =?us-ascii?Q?nUEzGC69rrpFsoQF4HqUQdr0ekah5/qhhufdmJt8cpscXyBkZDiQu/sJLYtr?=
 =?us-ascii?Q?QuQ8oQwR2EQCGJPf1kXLliYayl6UehhUgNwSgdV3almDrxXUEbBWo4ku/Kwl?=
 =?us-ascii?Q?FSFOW9e/djeOnexyyUntDx50ESbYwMj5Qlutbiez+sB3r2MpPnYknKt5T6Ad?=
 =?us-ascii?Q?oQGOS0u/Y5Vce7StKEil2dvNdpu/7aCKXFFN+jlxD0fUbwzexaDR+XUX5ZX4?=
 =?us-ascii?Q?me9CxOL6pICKrYyO3msRMdll/srcicSkBEuVr9ZuNJiiBvAgpKBZZC72lSZY?=
 =?us-ascii?Q?vWLZl/sZ+RwgZVbPXHogIatceoz8malHmSM2D2jIiJCIpZADya4oU+a50DOX?=
 =?us-ascii?Q?JLVcCZcCU201O3+4eZpRWflTAsvTKOxIuqK/Wwdm4eDmTk6NoMwcKadRxuHX?=
 =?us-ascii?Q?+7mLM+JRQbSBIqSXdyXYnfgh8AEZIpU46ZnkduAy9ijphYqIup3enGQHbFbB?=
 =?us-ascii?Q?xbhbJJNGb2MlFVop/KYW00VFxqbiEfVsAnKYZ0I5I4Abe3mxHsM6VMrtLk5n?=
 =?us-ascii?Q?tSBVK9sjHX7JsZlIx9Q/xu8cC9JY1Dm0hNgJ46IN347s5Y4G96SFb4KAp1bO?=
 =?us-ascii?Q?Wy6UmCYZU9WVves/PbrwjbPyJXOSttrXmBYShpe64xqI2hHNnJmgwlTbBxJn?=
 =?us-ascii?Q?h7t7htFs4YTdlGcgYpIlqtoZOILWEZrx97rYjpxyBp3kTgligzrOwuam9c+v?=
 =?us-ascii?Q?nE03QYmi8N5NrPBFZyzCe7c6yZGJYbAjD7cOka8eyfHr37o/dMclduyb72LX?=
 =?us-ascii?Q?KRNKLi5k0A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fe8e20-f396-49c3-5f21-08def21ee8e8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:52:50.5390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n440ohB2OadWhadrcNxSXTQP9Oem+WXblZw7+47kvfWWjtdBPqADEpD3RFtQMmFeoOmClIh3MCOpr2hC4+ytsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168

On Fri, Jul 31, 2026 at 02:21:43PM +0800, Zhiling Zou wrote:
> IP tunnel and netkit devices can publish headroom values that are derived
> from user-created stacked devices or directly supplied netlink attributes.
> These values are later used by IP output paths when reserving link-layer
> space before storing skb header offsets, which are 16-bit fields.
> 
> The dynamic tunnel transmit path already caps growing needed_headroom at
> 512. Apply the same limit when tunnel link configuration publishes
> needed_headroom or hard_header_len from an underlying route, and reject
> netkit devices created with IFLA_NETKIT_HEADROOM above that value.

The netkit hunk should be a separate patch (it cannot blame 1a37e412a022
which came before it). The netkit maintainers might ask for a higher
ceiling than 512 bytes given that configurations that passed before will
be rejected now. Let's fix IP tunnels first and netkit afterwards.

> 
> Keep bogus device headroom out of the control path instead of checking
> every affected IP send path.

The commit message should explain why capping the headroom is safe. IP
tunnels still expand the headroom if it's not enough, so the cost is
only reallocation for nonsense configurations.

> 
> Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v2:
> - Move the fix from IP send paths to tunnel and netkit device control paths.
> - Cap advertised IP tunnel headroom at 512 and reject netkit headroom
>   values above that limit at device creation.
> - v1 Link: https://lore.kernel.org/all/0c6c64e9bbd71a0decc8504a384061e0e631be13.1785054561.git.zhilinz@nebusec.ai/
> 
>  drivers/net/netkit.c     |  5 ++++-
>  include/net/ip_tunnels.h | 11 +++++++++--
>  net/ipv4/ip_tunnel.c     |  2 +-
>  net/ipv6/ip6_gre.c       |  6 ++++--
>  net/ipv6/ip6_tunnel.c    |  5 +++--
>  net/ipv6/sit.c           |  2 +-
>  6 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index a3931cd821321..d8e9ce1c659d0 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -25,6 +25,8 @@
>  #define NETKIT_NUM_RX_QUEUES_REAL 1
>  #define NETKIT_NUM_TX_QUEUES_REAL 1
>  
> +#define NETKIT_HEADROOM_MAX 512
> +
>  struct netkit {
>  	__cacheline_group_begin(netkit_fastpath);
>  	struct net_device __rcu *peer;
> @@ -1244,7 +1246,8 @@ static const struct nla_policy netkit_policy[IFLA_NETKIT_MAX + 1] = {
>  	[IFLA_NETKIT_MODE]		= NLA_POLICY_MAX(NLA_U32, NETKIT_L3),
>  	[IFLA_NETKIT_POLICY]		= { .type = NLA_U32 },
>  	[IFLA_NETKIT_PEER_POLICY]	= { .type = NLA_U32 },
> -	[IFLA_NETKIT_HEADROOM]		= { .type = NLA_U16 },
> +	[IFLA_NETKIT_HEADROOM]		= NLA_POLICY_MAX(NLA_U16,
> +							 NETKIT_HEADROOM_MAX),
>  	[IFLA_NETKIT_TAILROOM]		= { .type = NLA_U16 },
>  	[IFLA_NETKIT_SCRUB]		= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
>  	[IFLA_NETKIT_PEER_SCRUB]	= NLA_POLICY_MAX(NLA_U32, NETKIT_SCRUB_DEFAULT),
> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index d708b66e55cda..85e3455cea259 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -629,8 +629,7 @@ struct metadata_dst *iptunnel_metadata_reply(struct metadata_dst *md,
>  int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
>  			  int headroom, bool reply);
>  
> -static inline void ip_tunnel_adj_headroom(struct net_device *dev,
> -					  unsigned int headroom)
> +static inline unsigned int ip_tunnel_limit_headroom(unsigned int headroom)
>  {
>  	/* we must cap headroom to some upperlimit, else pskb_expand_head
>  	 * will overflow header offsets in skb_headers_offset_update().
> @@ -640,6 +639,14 @@ static inline void ip_tunnel_adj_headroom(struct net_device *dev,
>  	if (headroom > max_allowed)
>  		headroom = max_allowed;
>  
> +	return headroom;
> +}
> +
> +static inline void ip_tunnel_adj_headroom(struct net_device *dev,
> +					  unsigned int headroom)
> +{
> +	headroom = ip_tunnel_limit_headroom(headroom);
> +
>  	if (headroom > READ_ONCE(dev->needed_headroom))
>  		WRITE_ONCE(dev->needed_headroom, headroom);
>  }
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 9d114bd575f92..5b1f180485d42 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -317,7 +317,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
>  		mtu = min(tdev->mtu, IP_MAX_MTU);
>  	}
>  
> -	dev->needed_headroom = t_hlen + hlen;
> +	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
>  	mtu -= t_hlen + (dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0);
>  
>  	if (mtu < IPV4_MIN_MTU)
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index b843116e9b703..04ac007ebcc87 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1137,8 +1137,10 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
>  			return;
>  
>  		if (rt->dst.dev) {
> -			unsigned short dst_len = rt->dst.dev->hard_header_len +
> -						 t_hlen;
> +			unsigned int dst_len;
> +
> +			dst_len = ip_tunnel_limit_headroom(rt->dst.dev->hard_header_len +
> +							   t_hlen);

You can use a local variable to avoid crossing the 80 chars limit.

>  
>  			if (t->dev->header_ops)
>  				dev->hard_header_len = dst_len;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index bf8e40af60b08..403995273cbae 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1522,8 +1522,9 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
>  			tdev = __dev_get_by_index(t->net, p->link);
>  
>  		if (tdev) {
> -			dev->needed_headroom = tdev->hard_header_len +
> -				tdev->needed_headroom + t_hlen;
> +			dev->needed_headroom = ip_tunnel_limit_headroom(tdev->hard_header_len +
> +									tdev->needed_headroom +
> +									t_hlen);

Likewise.

>  			mtu = min_t(unsigned int, tdev->mtu, IP6_MAX_MTU);
>  
>  			mtu = mtu - t_hlen;
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index a38b24fb83842..19b7fa8d1a2a0 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -1131,7 +1131,7 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
>  		WRITE_ONCE(dev->mtu, mtu);
>  		hlen = tdev->hard_header_len + tdev->needed_headroom;
>  	}
> -	dev->needed_headroom = t_hlen + hlen;
> +	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
>  }
>  
>  static void ipip6_tunnel_update(struct ip_tunnel *t,
> -- 
> 2.43.0
