Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717357;
	b=s9EnywRmS6BbZrkLm3qNJa3XTfLLGzK61vrMUSB7YGGUJRBWgEvZpGnFyRpZ+8h/IXa1
	 M1IHiYq+ZqdxmBPhTrEobLmfWb5lQJxoyQaTqV0nML5rx/kLbnfeWXHZ8ZITsLkQNxVEE
	 O1ZOmHYXgZljr8H6ItnUaK9EKX5R7WR+XdgjI0fto9Y9qTryu++aw672NAXyXRqhZ8JkX
	 7Xn2tj1RKfIF/amDLykybqZcWwxjE5203laztRCIJWgFoWfZkkyH0098qTbyVjKgHnyVM
	 JnXxDkqmKFr+r/2JUTAyh7A3widvKKYU5bydexqHcIQFikaTFAKztzaea3M3wELi0aQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717357;
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
	bh=HCfY/JCS7lnmkyTjx32RALhxvuEYEcZ7jBMapam718w=;
	b=hB/zEUo28BKZZQyTlKMduRGcSUKb+FvqAqRMAIPYh4atP4Ei4OXfXf+QlDsOgrscdLga
	 UTvCAmWTqXVHLtPlBPJo1vGv/yBMNKb7/st7dr3qBdSmhKRT473Tka/AbRMmx9RmejHrO
	 ROmfAplBaXX/0b/T+h3cN0bI60hDKdlXjKLw+L6NDy7oKM0OANeqX4S0w9skJPqMEeZeq
	 4LzYCbrugbvd5hDBWrAYSQcMgfSzTXSj0ATR3afe6uooMZHZWZ+1bHNuTeI/KoI/Mw+FM
	 Nbd3u63Ddwu2D1h+VbT6LaJYMZehYH4rwAp7FQLWC8j5EnMkEs2RSoost2skfPWCzvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XOLpSRLi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.6
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEE6606A332;
	Tue,  3 Nov 2026 14:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BEE6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=XOLpSRLi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIBWfOiyrULu9IGcJXo5fQPjKNXcwQmuTdNW8aZ9ypezJkQDblqjC+aLukLKl21Iy9WYSvt1++4mogh2Mb9du44Kfc41xoecCB/SjP3mO2QYcaWgl8fxEiw+dw4JZBEMRmDMStPsmUWGqr+EwTl96u2YcYOMZRmJXZnepvaH0ImBRfu3FkfmgG0wJ0SZ3celZ65W2YFcR4UM7qYVui3oK5GTa1nWrc9qRa5AH5Na97TTCe11a16O2rXjuchVWm6VVmW1KQMrG2gJsz0is1bjCqRXqIIq/+DqVI69yN4XCPJbpunW5jGzj1D9yLIbGx9R7CRWLWlwYHO9hi/gyhPMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCfY/JCS7lnmkyTjx32RALhxvuEYEcZ7jBMapam718w=;
 b=ZTmvNOkWxeqe15AxFrsxr7F1JrJVduvLw04Pmlzz1O0zvBYTjRxjILOzBLPV//aIAgz4DhpimJHpnMUb26W13Ie8nt2YcGNOhH6YEtS+Lqft99Id9dLpWuyWXgbmMaZMLcTnT4+4fwiZftoqbwPq/gsnsl+Y2tRez9LP4nmjWXuebyLtTtkomd+AyCc0pD+mGemVx1BJ5eIcC2XFtqAXUhjIaHtU3SS/vejBenroQBmWfdBtRM2ewOhO6He1mFsyYkOSzFe6UhiA0CUfH82ialbJjVcyWb4x/h9nUdpUyuR+H5fIvxoKu8BMlIPxwTfR0buKUqxcOEUY5z6vzomy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCfY/JCS7lnmkyTjx32RALhxvuEYEcZ7jBMapam718w=;
 b=XOLpSRLi3UMpYluL9S+2Xkc/UeZ+u/qDl/gIylxVjaBnsCPpL4bUii1Hdsz43zbHcYb0QV3tG/gfjACzFOZweXE1+4RwImhWf820RX1kmkVVwlYQkklpcr0zuSa2rHOktfYOUaYmElPkQ5Of+mNH/ycSvfEP3hoxPXnOgtyRLexSpTfO0TmwGKPgOUcYAak7uOkflhzOvgCewNpNjimOtzEH0c8yjvtuE7M44EpZkuKWQgLKHbovJNENnPDUrKaSOSEi1IIkYiG/JU6TML3PortLFzawNjlobv9KjCiYjDqbpIQgT9RTX8mWP6qU9luUt5xs5X/nNG8jYcp/92H0QQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:49:07 +0000
Received: from SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544]) by SN7PR12MB7954.namprd12.prod.outlook.com
 ([fe80::2567:531c:cdb8:f544%3]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 14:49:07 +0000
Date: Tue, 3 Nov 2026 16:48:57 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dsahern@kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] ipv6: Check the Home Address option again before its
 address is used
Message-ID: <20261103144857.GA1215661@shredder>
References: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102064922.2636027-1-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: TL0P290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::19) To SN7PR12MB7954.namprd12.prod.outlook.com
 (2603:10b6:806:344::7)
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
X-MS-TrafficTypeDiagnostic: SN7PR12MB7954:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5134582d-1461-484f-4e39-08df39b99c91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|56012099006|261102123227099003|10067099003|261022105027099003|261021123027099003|261021121427099003|11063799006|5023799004|261026121527099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	x/0RJcB33HanLOWr3C/q8PqK1i75RTvSUYIPmTzS0qdcmhgT4eaffPvJ63XzuOy7wSIsDIvoeBWRI92UTfDj8Y+tq5vxhZIfxPwlTHD52kbrvZv6g5CnuDY+LgKwy9BAsFLZVzSWlfZjpu5GeB/SriFvxgzDKMb5pMdR1p+bkRSY5fSIl2LjbjyugcqySZnh1UOht+BjR9WLpn+HBo3MMqQEzXI/MHk7JRakzoNh7/ejJz1co3G1ftyEAmeU9tg6a5qr6VMBD9BK3Ble4gkULJofGxYqG0h4X5KwyZSmWRPd1BFqvs5wuvUcqUQSdpFpzUF8uGY5nuJYfJA/iuyh9lHvB5CVCjUtX+gQqQAsU4iom/II4aZNGbIgdp9+N8ICuLwQP34aQtmEB2hDlgkEKCI0iBrn5lb0BZ/ElLAovh9/XFKFICQC8TRiKDP9WpDkl4eKn3jQay35TAx8Sb7+u+S4yHK9Zc3cKQpZ3M15LLgFh591CUSycu7j/cWhD51ArrjZgtwke1hfZdoVeztqSFdUCwTcFzc0NCIZhfDFyhgPexfOAPkoXqEivvrROK7mGKVB0ZLQ2/ZQ03N1zym9/zN2xsLjXOUTHeoqkyaFnw6pgB1yrCHK+RlUdKjZL+MbOtTn/GAubsu3SsnCmYgmtlm9xwlFpwWuaExs4MmnPm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7954.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(261102123227099003)(10067099003)(261022105027099003)(261021123027099003)(261021121427099003)(11063799006)(5023799004)(261026121527099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TGofVyEiKGYWFzAkB2RrgTn0cvmrRGHYpVTQqru4CrvuznwbU4/nzehzIQ/c?=
 =?us-ascii?Q?p+kqtBgtiyzuCcG9KqDYdtAHKUUFeSyXzFcJHHJ4giJRHGs1FCeUMK8TBNEl?=
 =?us-ascii?Q?kDH4V8b4HM+qfSGdHqGZVsADeaJaECYiWjYeOkajGgrSvzJxdBUnt16f1XQW?=
 =?us-ascii?Q?DdK9gNcig/lOfn+gY1x1zxVKlajvnECPR7wWRf4jO0MzDxMYAur1ISOaLvbx?=
 =?us-ascii?Q?tpMlGrzokafYcyUDbaQid6npqUULWG3Cq6a7UUcM1Oo2LZGMpPw1SG2It/42?=
 =?us-ascii?Q?RoZDVjX6YG64wNoMadd+jSgpZXsm0c1yXS8K/fAYtHsk+K97/WgFB9MmvT8d?=
 =?us-ascii?Q?8Y4IvCO0cSe2hS/r9EieoP+Il6NVt0erPrB/WylAg9B806hpdfLsN+y56spw?=
 =?us-ascii?Q?9VkMyd+ehW3xj2dNCWkeHpzdYIH7mcPrniES0gdKI0eOd33yzsYzvU3eLQem?=
 =?us-ascii?Q?Cdv7Tk5xytNqPKUTVOrOutrzxz4mshdWDYIkVOwUdmiuxBqk5oW2xeIIUCHs?=
 =?us-ascii?Q?TInfFV3L/8xgCBN5XfxMBGqmtvTsUHUF8Rml4eVumBFUpcvDV+fVAhu+CwEY?=
 =?us-ascii?Q?E57Nh0Uuo1kM4oEJhSs04lKPM6r+u2QIhWkVfpuzJIK5UIYNbSsg80iSA7EA?=
 =?us-ascii?Q?phdPJdFsPAz9WkM3Uh8AnV792l5t4vZB4HHGEmrY5dfTEdFATWWWXqMQS1np?=
 =?us-ascii?Q?NyyhMuvDoXTTWyWp+IhAKarAUX8m7hVm9Fe8BjkAUWO4KmOnZoAliJ+wtSip?=
 =?us-ascii?Q?ywG0k6O0wa9pRmz1mNhJJc3YLjCy5HwZtWV3szSphmLNayZI7g2t7PLPnUYE?=
 =?us-ascii?Q?hxdL4/dPvMT8Riwv8ohtPbrY3VPo+WywDSRMVqWdapJu9z6LXR0JJBrZKBT8?=
 =?us-ascii?Q?k5O76pq8huJfyJE9icbwocrhV/GcJfIokKHLJZ8ejhVG9WcnLwwn7uLlgC3N?=
 =?us-ascii?Q?uossIGutVQr7QLyVoDrEhB9UeNE38bY7iHnSz76HyHC4wTe/68hfts49tiGb?=
 =?us-ascii?Q?V+5DR4Z8Jm/8brlBar7c8eT7xP7EMQuVyW+OKVIi+elsdyWROGKUq+FPBAi/?=
 =?us-ascii?Q?t4o6He9mHKGqMVwU5nbYIQWVH7KOAEGxD+HwC0ZVqBdFMoRjcsKLmyCePRv9?=
 =?us-ascii?Q?ezk+StN6tYvmlrww1U9OHaTrl6/o4tHQeW2TuD5Tqg7yx/5pp8EIv5xKs3Nc?=
 =?us-ascii?Q?Apj3GOjcWLnrBGFiSmNN8/VacbJxzZ8K+6BEuAnP06Ta2Wj5BaPhKJ/NrTCs?=
 =?us-ascii?Q?q+QjOIzPZF5VLTY6x4Fz/32mJU4o228o2g8HXIhtvonPzFf94Vk5Wf78Zvq9?=
 =?us-ascii?Q?CrJ1WfkcLJcJddeYP5uqtPCEARmOhY7yqzJpHKXJunek5i26xY1GDVtnnkv0?=
 =?us-ascii?Q?sjCwqX2ClKZvzIOCAzD8IRurbN2c/oF0PmvPqmQ7wDDpt+xTdbZs7H7i1fu8?=
 =?us-ascii?Q?mrUJUeQXC7F440QAZg7iwODNLA2WodtzmuuAUw9LeXz9CXzmkpsyTXnXBgGj?=
 =?us-ascii?Q?1QHrSGZZ4BPjqszL68kSkHd7kRH3GdSC50uhaIlhW4j3H1yrfMutnc3mHtYt?=
 =?us-ascii?Q?FTRF8jcbK6ksToPLWaLb+8H2xaOP5xjmQFozvksqchwW1J6g3q6vKboZWmsK?=
 =?us-ascii?Q?igSRqFr3v5148+i5jhgdjZDZhl+jqsDeqM2KdFbDG8Kvl62xDGjYoNmDpoFf?=
 =?us-ascii?Q?RkLUwQz4Rh1GfvQS75t84HTFYD+8P0bd1oBv+4Fvj1ITpl1l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5134582d-1461-484f-4e39-08df39b99c91
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:49:07.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtZ9Z9Q1ACTplPVmdKEyoWBRJsSRWGMp/MiXOwVfe3wDLHI5AYuSYaLXYPLrmSuccU0hW+0hPt8AWsN0qn6pGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

On Mon, Nov 02, 2026 at 06:49:22AM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> ipv6_dest_hao() checks the Home Address option and sets IP6CB(skb)->dsthao
> to the offset of the destination options header. Later mip6_addr_swap() and
> mip6_destopt_reject() call ipv6_find_tlv() with that offset and use the 16
> address bytes. They assume that the same header is still there.
> 
> But the seg6 and ioam6 lwtunnels, the End.B6 actions, ipv6_rpl_srh_rcv()
> and BPF lwt progs move or rewrite the IPv6 headers and keep IP6CB(skb).
> Then ipv6_find_tlv() parses other bytes. It returns when the type matches,
> before it checks that the option is inside the header. Nobody checks the
> length of the option again. Thus mip6_addr_swap() can write after the data
> of the skb. mip6_destopt_reject() can copy that memory to an xfrm report.
> 
> In ipv6_find_tlv(), check the length of an option before its type. The
> returned option is then inside the header, and the header is inside the
> linear data. In both callers, ignore an option with a length other than 16,
> as if ipv6_find_tlv() found none. Then the ICMPv6 error goes to the source
> address of the IPv6 header, and the xfrm report has no XFRMA_COADDR
> attribute. Nothing changes for a header that ip6_parse_tlv() accepted and
> that is still in its place. For the other callers an incomplete option is
> now absent:
> 
>  - ip6_find_1stfragopt() and mip6_rthdr_offset() can return another offset
>    for the fragment header or the xfrm header, also in a forwarded packet.
>  - calipso_skbuff_optptr() returns NULL. netlbl_skbuff_getattr() and
>    netlbl_cache_add() then see no option. calipso_skbuff_delattr() returns
>    0 and the packet continues unchanged. Today it returns -EINVAL and
>    SELinux drops the packet. It already returns 0 when an earlier option is
>    incomplete. The receiver drops such a header in ip6_parse_tlv().
> 
> The code that moves the headers still does not reset the offset or the
> other fields of IP6CB(skb). If the bytes there look like a header with a
> Home Address option of length 16, both callers still use its address.
> 
> The first tag also covers ipv6_find_tlv(), because its early return did no
> harm before mip6_addr_swap(). The second tag is for mip6_destopt_reject().
> 
> Fixes: 793832361fe7 ("[IPV6] MIP6: Revert address to send ICMPv6 error.")
> Fixes: 70182ed23d25 ("[IPV6] MIP6: Report to user-space when home address option is rejected.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
