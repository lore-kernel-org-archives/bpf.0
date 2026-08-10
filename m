Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14673DAACF;
	Mon, 10 Aug 2026 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365951; cv=fail; b=lU5Wk8nd2dqpDL6oAd9dnCqJHxEYaFoViHtRqAewdXbM9KpATKxdvGNCjfGNIG2XigWOgEASArEIh+9jJqdrD61NVYuUl2APp2+AlOCOGw1mkTVAgjEK5B1WWUgvlkaKE3YI7TE+ukBz4iOi4VJACvEi3IcFII2uCHtN+a3MbRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365951; c=relaxed/simple;
	bh=lDeedrwpI3K6iKAJuE7Tw1k72dgIglgkUBZwN2/tK9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLlTKTkts73Gmlbu6+TUuqKlRdmCAVvCyRxWYiAXGdNCiVvLzCHNbJnUB3s2VfrPhL973GGaY4C50A4G00F6IemMnxpM3ru8CUYhNY/liRXfNV3WrzxQy94FxJy9KWNu7c86KC0HYlwk0IIvzRh7Topl9P+ljQB6Jc+HNKHg4x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E4EqUqeh; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E4EqUqeh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWJMHaiFDWO9wxvi9SonSkM/+mLzvkwaVoe4kG1RKl0s12PX+N6erPTkT7coDeurmH7oJajd4DAWdg4oVC/EknJihFj9uqdy7kIj6fSkK5ik7oy1hU499sAMXvPUUnryMOyMK4+XOtP7um++bOlmhr5z0uTG102kW5Lalk5sTyBm4fZZpel/gUuqBurfuO14+cARxJOjbr3NgmeuvyZALxf6C5sT7CM9LF2xdyrOs4zqjO43hUURMnXPFnfW8tNX/zxtdRUP2H+yLxCMcE4b8n24vlwZZCfpEg3KdAMnY0ajdZeL5JJOfijtPX0iABwYmQJYhQQzYhfvYabZupy5Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxiIj94A9+0hFqyrOFWADnQErx5xtsNhITVuHt86tP0=;
 b=isJB+sxA2ppb5lT/HTTgJrnj/rNJWb9XZcUEGgP/w7tve4MDtdldFTP3OyAG8gEmyPbacFDdzBm35n6B4DhjFb+I2WNWMCrMWTq01p/0oc45DB6KMhKpwI8Xvsw+Qa74RGjO5d+CZwCInoZKQPn1rv9fagpvdEedbZCSkUcCWDvd7jJNlacTSYmW2AAZXsFwlDY/TkzDJCyJAYbvv2rQ3Dmu/31R+WnaM2W2dVFj6SsoAaEps1xgw0Vt9rGcbt4CTRFEm+oJS1td4mthkWLZxML0obOzA73d795ZWCKm9aeUZ55HFQvjrc5yxUh8EK+LWRP2ft+NNnpPOaj4bQpXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxiIj94A9+0hFqyrOFWADnQErx5xtsNhITVuHt86tP0=;
 b=E4EqUqehdABayuNn2A3Sy2z387ZePQBouhyt41loyOKy6QLpMif4izs1WdKkoctIG3JVQliUuQ6QfaZcCGTg0GJn/Dl51TlROHLJnNINT2T3D1lhe3S99w2DQBZhS3jJOBIkDktl/6z0i/FLclgavhYnqKPPmvWDxIPlwAAk0TqPUjcTHP+WQJMYMtZ7gU8jl76Y/Is9TQFsEwHvRo/cpW9viAoFG2c/eBNtqWagLUI7ioNaCKAuKzXftnLgicJ5IIBO+WPr5qPZWEVFyNr9WcnTu8qLUVll7PIh0hRtr7Ui/ZrjiSpuK/PWJpoJMMwGtP1FAxxfNWzd4O21sCWYzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 12:45:42 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 12:45:42 +0000
Date: Mon, 10 Aug 2026 15:45:31 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
	razor@blackwall.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	dsahern@kernel.org, horms@kernel.org, yuehaibing@huawei.com,
	kuniyu@google.com, aleksander.lobakin@intel.com,
	maoyixie.tju@gmail.com, thorsten.blum@linux.dev, kees@kernel.org,
	kylebot@openai.com, vega@nebusec.ai
Subject: Re: [PATCH net v3 1/1] net: cap advertised IP tunnel headroom
Message-ID: <20260810124531.GA2704117@shredder>
References: <0ac01576f92412e8fa35cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ac01576f92412e8fa35cc3eb44336797a9d11d0.1786021595.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3e86ec-0c6b-408e-70e1-08def6dd48e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nunJjLJpwWhNFnt0uB+i7ROZSw/axqvkeZhDfShJ/hfHw6fUSi8EpZ+R0J6N1p0+0IW8YOF+maW+GZIb2cH3t7nhfqiGhEBoWN/CxD1woWLLs5jHYjhyZbSurqLzsbO90/O/PjFnULaAQLNm2swQqcY7tggJOkuiXMCKq3UU8icnALNySSJ0mv/blMd2TUaO3vMHqS3jzycHhrCcbtSOH+FOyAi+cVkth48QfFYIxj1jghU713hf0y9XhfMN2aM4bxZz6U60JjGxzjQ8QZALBzMVZqY+jMV7kgnTYvpj0VBRRycZ+cjnT92TRFujszX0TYlYiwfnkCcy+aKi0hokr3YNa8s1vEB4K4hkY3IzZYpFh9aLTw5INifdia2kdLqWJwk306YWNHLAGCCu6KoXRObSPgMjRv77Go4VBxRB2XYhxYPRrsDzxAJHt73rcumRgR10ss+1gsEKmkhcpOXI48KEru3WP36DMM+YcsvYVw6NH57JRQLKfboIpG46bUXOhgivWmPbZV02a98aB17rMio0WdbEQzJ8zlmvgE6J+LUxY6qihOQjM+AKAqoiYLr31iCaRNEbravHxXkL+NKOitLZ2OAeXsz0NIV6IBqhMnB++k3oGnt7BNHNwLXhGD/MvMWGglcTvsezVDXfCmPoPtSMiktjLsdTLW/kz/fK3Gk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IZg65Y9bT39M5ZsGAvHZWTkxgtHVW3dl8glc9EdrbgcgIucd7ff3zPe5D9u0?=
 =?us-ascii?Q?b+OjLNGhzL1/54aHmhO+o35MNB2m5BZmpgHwVD8VU1ze8Sct2UGvDxH81ZUP?=
 =?us-ascii?Q?CT7t5N/go0jcj3vfCO3BVeYDBhiMBBmxQ7omZck1HXWpEQK47KC644CD9rm2?=
 =?us-ascii?Q?8Rm4uERxCFdD+swn9J5il6AxvAVoElBdzxiiU0sZuTezF7q/pnXRzLLBleAL?=
 =?us-ascii?Q?OYMxJPNAlSIze1VD6rbkuBsxMeHot9U2vfOJOYUZSIvgPldbeOjruoZFdNR1?=
 =?us-ascii?Q?bEEZOQmd3zbzB/AkypDcskFkTve30O0ZiPBHLBmRLVthNRSWh8Uj3ma9WZ47?=
 =?us-ascii?Q?I64tGLmr4U3obk1UbMDtCk9XEU3VsQQohgNAKVAz9kta1Dj0T0skM1EeLOO+?=
 =?us-ascii?Q?QWJSIOmMvLjbs1Scyj8Gsiig1Wvx+XxE/F/dwZlriIqY6Oe/OzeGqEWZAn3N?=
 =?us-ascii?Q?RAmHMhSJ/XKLeOB+m6mOM8GQsFv9Bl3MoRUq/I0T7XMLDHq2SqvBec1EOq1h?=
 =?us-ascii?Q?AsaPnthzwhGdHgHxq6j2qbogz2ALiQgpeyP0J8/MuIa0eFMjClZ7NrjrdjVO?=
 =?us-ascii?Q?OIFa8YZVTK3Tz+OTffIynIKnLM2SL86zC1UztsR6H/WHQXdRno+f5ePPa78V?=
 =?us-ascii?Q?Ejy4d8dLZgKiEMQTGYUa5E5EUwGa3HzyO/mjwOGWNCrYZ/tqnev6ksDF3mwU?=
 =?us-ascii?Q?TwTSl06BbR/HyaiCfCIpJq3a12oPiS89P2m2+PrKs79/n/ovJDG2D3UA7OZ2?=
 =?us-ascii?Q?zD38OOQAv8Mii3uRMZHWR5O5c84kmZz8hVMttmlLOCzIXwwfhKGskm0S1xc6?=
 =?us-ascii?Q?6IiZekVRkP98TB5szs59v1Pk2+CUDQICkLp4b2yHRwI38ozMgGKJyue8c9r/?=
 =?us-ascii?Q?H6wJUNiDqm14OZuX/E5ebLxmZKQC45bnobcT1MgAYaxZVgelbQQzaP88n7op?=
 =?us-ascii?Q?tqwWxMtaPz06YMGIOBqW+N9o3EL36g4rE+xZWPMOOWJXAI0RmgRzTLb6OD7a?=
 =?us-ascii?Q?m3KaoqfzIRInj8qAA7M/s7JZ4MgT4spu94LEcpDET1I17Fa6St4wIbp3zywE?=
 =?us-ascii?Q?oXWKk7rdxZoTU8G7xoFCQDY/rSt5csMuWj5gl4C+8MosaIdGzCuLFJC++i2F?=
 =?us-ascii?Q?FobTidkm5j6SNi/jrJyLhFUiQXvSuF1qOIXOMVb8Ie9hy0I/2MNop7u41EHY?=
 =?us-ascii?Q?9OpzBNGw52XgwARjUxxyqDyW/UQBSAIllO9WMifCDvGvLCTrueqfxEBdK/WQ?=
 =?us-ascii?Q?Bamv96eB8qrJ6gFp0v345dqXsv2eCL0ZKGDoelibhF7EL3ET9dnkjhsmMi9d?=
 =?us-ascii?Q?nuKSzaq0S9frOyxhZi3C74D2JMOW/QNDsqPd5W7AxFRQ10+9wKgnywHyUhMk?=
 =?us-ascii?Q?pZDkHMU/eXjwQRioT4TA5m4YyHv8tzXu8ZB96Z32DEJbaMPV1MRBrtik+FNp?=
 =?us-ascii?Q?yM+/aEZEFk3rtc9HZzNyHuZ3Zy3RHNHyIie0iEp33ffhIvJmY2a02WsP/fCB?=
 =?us-ascii?Q?oU0vjz7Xc1BKuei5GHh+7aahYTWC12eKf/4vSn5yAT3gXGBpJjrlsMNkgQJn?=
 =?us-ascii?Q?MnesPhqoXJSAyuWoErBnfrumQ2YclhC7TS2Cz3ffN4ZP0AQKwUYKzWAQ9cET?=
 =?us-ascii?Q?1vsXKKoNRv9h8RHIL++puxlS9yZXzajfj1y6RyN7vR8N/NEBU005WP5Tl9BI?=
 =?us-ascii?Q?Qk1NbPdkxRVktNQ+2k0W9Z2oPv3MTZSZCJp8w/ERHozcc/Wx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3e86ec-0c6b-408e-70e1-08def6dd48e0
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 12:45:42.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omWVlwMf3eggaIR4PMpa0WJuchbSJXpr8tBArGVDjc0UT8YcMGg6Akkv3VZ8beKLvIBrhYhTBAZFC0eZEyoeQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

On Thu, Aug 06, 2026 at 09:21:52PM +0800, Zhiling Zou wrote:
> IP tunnel devices derive their advertised needed_headroom and, for IP6GRE
> devices with header_ops, hard_header_len from lower output devices. A stack
> of user-created devices can make the derived value larger than the 16-bit
> skb header offsets can represent. Once IP output reserves it, skb head
> expansion can wrap those offsets.
> 
> The runtime transmit path already caps a growing needed_headroom at 512.
> Apply the cap when configuration publishes headroom or header lengths
> derived from a lower output device.
> 
> Capping the advertised value is safe: IP tunnel transmit still expands the
> skb when the packet needs more headroom. A nonsensical stacked configuration
> can therefore incur an extra reallocation, but it cannot publish an unbounded
> reservation to upper layers.
> 
> Fixes: 1a37e412a022 ("net: Use 16bits for *_headers fields of struct skbuff")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
> changes in v3:
> - Split netkit handling into a separate follow-up.
> - Explain why capping advertised headroom is safe.
> - Use local variables for derived headroom.
> - v2 Link: https://lore.kernel.org/all/0ae4aa29223b89049727aec4d36f144bad41537e.1785476387.git.zhilinz@nebusec.ai/
> 
> changes in v2:
> - Move the fix from IP send paths to tunnel and netkit device control paths.
> - Cap advertised IP tunnel headroom at 512 and reject netkit headroom
>   values above that limit at device creation.
> - v1 Link: https://lore.kernel.org/all/0c6c64e9bbd71a0decc8504a384061e0e631be13.1785054561.git.zhilinz@nebusec.ai/
> 
>  include/net/ip_tunnels.h | 11 +++++++++--
>  net/ipv4/ip_tunnel.c     |  2 +-
>  net/ipv6/ip6_gre.c       | 10 ++++++----
>  net/ipv6/ip6_tunnel.c    |  7 +++++--
>  net/ipv6/sit.c           |  2 +-
>  5 files changed, 22 insertions(+), 10 deletions(-)
> 
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
> index b843116e9b703..cc757586be90a 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -1137,13 +1137,15 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
>  			return;
>  
>  		if (rt->dst.dev) {
> -			unsigned short dst_len = rt->dst.dev->hard_header_len +
> -						 t_hlen;
> +			unsigned int headroom;
> +
> +			headroom = rt->dst.dev->hard_header_len + t_hlen;
> +			headroom = ip_tunnel_limit_headroom(headroom);
>  
>  			if (t->dev->header_ops)
> -				dev->hard_header_len = dst_len;
> +				dev->hard_header_len = headroom;
>  			else
> -				dev->needed_headroom = dst_len;
> +				dev->needed_headroom = headroom;

There is a pre-existing issue here that results in the hardware header
length being accumulated over stacked devices and it should be fixed
before capping the headroom.

Commit 832ba596494b ("net: ip6_gre: set dev->hard_header_len when using
header_ops") is correct that when "header_ops->create is used,
dev->hard_header_len should reflect the length of the header created".

For ip6gretap and ip6erspan that's the Ethernet header (14 bytes). For
ip6gre tunnels without a remote (NBMA tunnels), that's what
ip6gre_header() is pushing: GRE header + possible FOU / GUE header +
outer IPv6 header.

So the problems are:

1. hard_header_len shouldn't include the hard_header_len of the lower
device. IOW, for NBMA tunnels it should be 't_hlen', not
'rt->dst.dev->hard_header_len + t_hlen'.

2. hard_header_len must not be changed for ip6gretap and ip6erspan which
have a fixed hardware header length (Ethernet header, 14 bytes).

Following diff should fix it. Please test with both locally generated
traffic and forwarded traffic out of an NBMA tunnel. This should be the
first patch in the series and it should blame commit 832ba596494b ("net:
ip6_gre: set dev->hard_header_len when using header_ops") and carry a
stable tag:

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b843116e9b70..70c171091020 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1137,13 +1137,8 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
 			return;
 
 		if (rt->dst.dev) {
-			unsigned short dst_len = rt->dst.dev->hard_header_len +
-						 t_hlen;
-
-			if (t->dev->header_ops)
-				dev->hard_header_len = dst_len;
-			else
-				dev->needed_headroom = dst_len;
+			dev->needed_headroom = rt->dst.dev->hard_header_len +
+					       t_hlen;
 
 			if (set_mtu) {
 				int mtu = rt->dst.dev->mtu - t_hlen;
@@ -1171,8 +1166,8 @@ static int ip6gre_calc_hlen(struct ip6_tnl *tunnel)
 
 	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
 
-	if (tunnel->dev->header_ops)
-		tunnel->dev->hard_header_len = LL_MAX_HEADER + t_hlen;
+	if (tunnel->dev->header_ops && tunnel->dev->type == ARPHRD_IP6GRE)
+		tunnel->dev->hard_header_len = t_hlen;
 	else
 		tunnel->dev->needed_headroom = LL_MAX_HEADER + t_hlen;

There is a pre-existing bug / assumption in the code that NBMA tunnels
don't change to point-to-point tunnels (and vice-versa), so the fix
ignores it as well.

>  
>  			if (set_mtu) {
>  				int mtu = rt->dst.dev->mtu - t_hlen;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index bf8e40af60b08..2c941acb081fa 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1522,8 +1522,11 @@ static void ip6_tnl_link_config(struct ip6_tnl *t)
>  			tdev = __dev_get_by_index(t->net, p->link);
>  
>  		if (tdev) {
> -			dev->needed_headroom = tdev->hard_header_len +
> -				tdev->needed_headroom + t_hlen;
> +			unsigned int headroom;
> +
> +			headroom = tdev->hard_header_len + tdev->needed_headroom;
> +			headroom += t_hlen;
> +			dev->needed_headroom = ip_tunnel_limit_headroom(headroom);
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
