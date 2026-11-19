Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795102940;
	b=X1X+QHaqUhH6hJNB2KHnuq1QNu5um4XPi0BxWF0B24wCMS+sT7EgQeGERLafYK/bKGgj
	 Q4iXC3SW5VxZ7IUvXYNSj8OqlT5EK0Urz2c0vivxr1WOnqhtSlxHRaUL/Zhel4fpOet9x
	 h7OGypYy3jfEsJK80GqJWuVKVt8J9/p1IQMM1PvBro65byU6ekcTXv25/KXogX/tXlRg2
	 5UeZRd5mb76kJU8r8LnsJuSPaxl6Z1SdBUN+FsUnMlh36N2p6rFG6k/fY0Ctk39wtH+0G
	 PHX7HxhdiHqai8+2sUmtShk3D09nFRHMuhiIikM0V+mzGdtzCi5Xk6dsvRCz1riSHnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102940;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Fo11YqWATEwi7aN0cbsfXCh/hslVn2ife9rnfJv8SHs=;
	b=XcNQSMX8euT6dPFW2wlvtYQMogyZeuh/vauzfqkznlBdo9/vdv/gwihzQUu1Ou4mvOyT
	 AJ6hz1CZ8ZHlNK7LcTJcoWfgdfQkY6Sq0h0JohTlgEm5cpGp46DP4lgDgCETLeUAYFEhr
	 UWJnYcv2ULnrqerXzsiGlnBNTgN0bCnKCBS2Yi+10e0Ctv//BivqgY1IiU/V8NLUetwXY
	 mchlXfUYiLFaL9QAqfErORJ+JftkX5aDw7kZNrswtZmUw4/eH3E4THLL0ognnwg7P4MV6
	 5RlXQLQeInHj0xiIo9UP3HuG4eCiXm0bw27uPkD1//w7JOJLBgitpmA6odJa8aGBCqQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BwSQ+2hA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.69
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECA606A657;
	Thu, 19 Nov 2026 15:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91ECA606A657
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BwSQ+2hA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnrfXQiK/wH0rXAfuP7sP7i2rv1LW3U7kScUUGJdH/CuB6Di5bLPU1jB4Ffc0UxoeBAeaicQmAHz8kS7+2Q/zmy5QQJVRjDkssx2S35odcYZS8DXVV5RpvHmoDtSR0MjoV+dIFOpOjke8AhvgDC5MKiO0pqKgzT3fjf8J8QCF/hfX1d25Ci1MZ30tXxCoFWrr9lSdLsaLjE6UxfId5fwy+Fu+pkWeXVB9O2wokw3Nz91mRPz5KNvMUkHgaZR9qu5OOnofrYgOjKZgNC2UhCSMhxKkVx7XngJPiG80GS+mVZFC5Aw++qYY04+xnQ/ohtGoRWHLv+NhjFDktzvgX1ZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo11YqWATEwi7aN0cbsfXCh/hslVn2ife9rnfJv8SHs=;
 b=GWQYbE2wQA8H6EzpqTnMCA98JcHxhNjuzycd2QLyGXJZ7KzH2OO+W9TKZ06CnIWopW4QYeOF2qk+fj7cQTl5dJCYqEWe+Pcy95niN8B4Lhg3AvK0XoJNyN+OM4oAPReuaUUizK7NqNOCyfBSne1sFYu5Jbvslljw2x4hWZDpbXiV/tAZAgLNUWG+uX2AprivM5U143zuZvDvcqTD9x7wHBnX5/U6RIhV8CAJ6GDyzjV7yO5LCr3+LxG15vS+HOHpm9b+1b2E1enr8q+x9BQB4nDpKaXigwNZi+esiPRng0j3IY2M5RmXJVITkTeZJftlM0xCdPN7gE61c7J+XqxtTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo11YqWATEwi7aN0cbsfXCh/hslVn2ife9rnfJv8SHs=;
 b=BwSQ+2hAIweK77ZiWnMJo8dyI5lKKAMRyQAhqh8PgSW9GeIgdlke0WQPsrV6rJhpgCgbSCPqSsGhGLvVHM2zj+5i8XiWvxV6uh3UCb0hds1IJ9hBAbaOLhACpLYhV7F/oItWkM6fy7sx0UCHWD+Xbh4/jlMnQf6HE8pe5/S4bRGckxRIe003vZPS2lMUPUehCt5RxT5ev/qafW1OJWlKPKr/dGZSQu6Sziu4/btuyFocV/Q+IcpfPjlsUh9Nv3SJlC5qPTtoeb5oVACml4RIw3O4pFqCNdiBu+yJB5LUP5VES7PmP8KfDLlQ2Fbnkcb3t8k6IO8gxzb1A8T/gIU48Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22) by CH8PR12MB052106.namprd12.prod.outlook.com
 (2603:10b6:610:709::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 15:42:13 +0000
Received: from CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205]) by CHAPR12MB999248.namprd12.prod.outlook.com
 ([fe80::4972:8062:d74e:b205%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:42:12 +0000
Message-ID: <e3d1c5ff-110e-43d6-8211-9c107fb0bed0@nvidia.com>
Date: Thu, 19 Nov 2026 16:42:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] eth: mlx5e: drop the now-dead HW-GRO and LRO
 vs XDP handling
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 manishc@marvell.com, joshwash@google.com, hramamurthy@google.com,
 tariqt@nvidia.com, saeedm@nvidia.com, daniel@iogearbox.net, hawk@kernel.org,
 sdf@fomichev.me, willemb@google.com, przemyslaw.kitszel@intel.com,
 bpf@vger.kernel.org
References: <20261118232315.3593731-1-kuba@kernel.org>
 <20261118232315.3593731-6-kuba@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20261118232315.3593731-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
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
X-MS-TrafficTypeDiagnostic: CHAPR12MB999248:EE_|CH8PR12MB052106:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2cffc5-9226-4e98-ff5e-08df4653ae0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	CqJXbNH+5nRxWGYlmvunvotTnsCtm3u95vWwzBIINC3BCDuvf0h/ZFsH6umhvUsrQGadawQaibelGLPViXSCwcjFUccaKjHFg45BQlspQk510l/h40wlvv/Q6Ho1qAybJtu8mZFKUKRzU8SwrwJ5WskXkAhVXctqbT82h1uwgF4Y555vDsgVVIRFkH2/JyrYzGol50hu9vmdIRz8UGEJQ/nbajVN6ujCawNAltRbL5xEgnAJmKDRjCxYDc6jCQop1jXn2d6gI0CfSsABA1YEYs6nCasdzGm/3+W5HPI1p9DcFrkjfT6jA3d8iy5DfJPk7R4KBl65FbQ97CQOFkMKVh61BbfLpdGM57EJFR1CgZNcHBOwXz95kdsEYBIFihUlPEuckbuqCEEI0+vXyTItBsYApJvdm7VIvIKfmHDmOAbWtB2ZcW/KJ6g0W2N+sOkdSYwdzIyfXR0QCeP0eYav1S9OQpEnYPADJd/uVXXbuoimhdY/3QEab1mTjfX+d8ljmQUmyuKS+9R9NvRXgkd58zWu2NMoSIvsZUHzH1XDEOs2xBVoabAMAYSXRbBXeMxdCEj4rlJdWhcUa0ijjFNH8+tsWvk3z2NR50JmwVJMLqkor4fupkw6FRx6mnrqXu4O9TKOmN0rQib4NdDTbeRGDdlVzSBCyZV63adubWMO/EQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHAPR12MB999248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEpmV2VXV0hQZnZ6VXhKK3IrdTJNVjRpczdZOUFNSlA0UzRNTkRSbUVEczNm?=
 =?utf-8?B?UFNOMG9Qd2RqRnRnNWxxcDlVNytTeStIUHN4VjBUeHNSREh5WHMxcStLSVBO?=
 =?utf-8?B?ZjY0RFo3enJyTTN2eFgwRXM5dS9WcUM4WEJqRHRuVDdUd05yaWt5V09aRFFN?=
 =?utf-8?B?U1o5bHdYbnlXaGpkZDBrckFnWjJsTkJyWlZ2TW5VUFZDc1hpeUxVTUxjd1dV?=
 =?utf-8?B?dzZid2hHREFaRHlLKzB5Smtya1lPeXQ0Szg1N0R0aDBqNTR0OVJSc1E1bER4?=
 =?utf-8?B?czljcitobjhLNUZIQlAvaGwzQ0RmWTZxUnB6ZjRwZHJEaXNNTDAxNXRWSmtX?=
 =?utf-8?B?elNqd1pIT3ZGcU1XU09Mc1haZHJNY1hmQUU3ZnNCS0RMczNKSmJKSnlWdjFW?=
 =?utf-8?B?MkpZNW43N0FNN2xLc1dVZ1ZBS3Y2Q1JDM2wxUlFFazljN0x1Q0pMeml3UnNw?=
 =?utf-8?B?bXYzU0tBbGl6TDZZWlhITlN6cmZlVjI3SENORnZ0T1c2U0V2MUx3VkRUNkpH?=
 =?utf-8?B?MXdaVWNWVk5lV2Y2WE9aeDdiNWptVGVNR2dRZkRMM25LOHoxR1gxbTlRbGVi?=
 =?utf-8?B?eVNYeEw2cnRrNFJzNnRSSGVyNXg4TmcvaE5CbnRwUXhXMjBrOWxXMnlOV1lY?=
 =?utf-8?B?bXBPTEg2YVV4V1RjRk8xbkk4eUIzSmFUZHQzUkY0NW5sNmhuT2lyaGRSc3dF?=
 =?utf-8?B?cTV3YmxqVDhWQytaSGc3OUFUU2FKSkFlMWs2L2pSUzExaGM4WDBmTjdub2NI?=
 =?utf-8?B?WWliaFlLR3NjKzg5bXl4eFlKWVpJRGVtNnVvSHUwaU50ZkpRWEVXZVcyWUpu?=
 =?utf-8?B?Qmo1ZFkxamo4bkhnelJKSUdiQ1N4ZHd2cXdCbWlmVmJxMTZ1L2Rra1ExQjNv?=
 =?utf-8?B?Z0lOSVVKWFRxQlNsdTZ1SVpYYTJDaTBpTU5zNHY5MlFsVVQ3SFZHYkNoYUpK?=
 =?utf-8?B?Ly9CeTZMa2RCNnplNlhUaUFjOGNobUZzTjhrTkRlQkZLbXFIaTFiWWRGa2Fp?=
 =?utf-8?B?YkhWam9sMEFxOEhkakMva3JUQkFWc1JIS0RMS0JWMm1FS0Zxc1pVZHp0a21k?=
 =?utf-8?B?QVFpclRmN2s5aVVSRG9zR1F2ckY2aE1wcjJKQ1FaRFpaYkRnUnBpcGRlN0Jz?=
 =?utf-8?B?VjdtanBvRUg1Tk4xdFB5ajRCNWxqRkNuNm9HTjRabkpyVWcwUk1yNGVQdFpP?=
 =?utf-8?B?WFNIeTJ1c0JSUS9YMStwZ25XalZKdzdaZ0RWQXR6cTE4OHNIM2UxK3doTDZk?=
 =?utf-8?B?SlJ0ekRrcG1nNjJseDIyQ3FwYW9oaGl2dE1RMlJoS2RGbUJ3K2RteG8ydXRR?=
 =?utf-8?B?R1BkWUgxMUsySUlUdVBhVC9UbU5NejVISnBZM3pJdW9tdisxSjlyMnBDcG5N?=
 =?utf-8?B?djFWR1F3TUErd3NvUHVqeXdYamJmVkVuYXIreGt4RFUyZ0VETmg1Mk0yb2Zw?=
 =?utf-8?B?TzRERjY4YitFZk81SnlraGVwNVZ2ZWFoSHozNjMya0ZwTE44emZWM1E4MU1Q?=
 =?utf-8?B?QUQzdkhZczhJVE5iQVVqeSttTXZWa3JFQ05LSnN4Y1I0eUdKbERseWQraGp6?=
 =?utf-8?B?M2dmSjlUUnVvWmhhczlFTzVtdFFOajd2disyMXN4YmRRZmxORzNYUE50ZVFT?=
 =?utf-8?B?NEJPSzZWTkM2Zlc1ampIV3hnOGhoL1hRV05CZDJlMGVJbGZZeWY2ek9qckh0?=
 =?utf-8?B?aWtVL0l3NjFiNGxYZEVXcmxYVkY2U2laOWI1ekMzUDhESk9qZ0FQTENELy9T?=
 =?utf-8?B?dlRmck9tN3ZNSHJPazlmMm1VYjcxblhNc1ZSdkdQMTJSb2VhSnIydXpwSXkr?=
 =?utf-8?B?RzZQcCtWVUp1QWZOb0x0Tlk1amRKWUtKbHY5dkJkVUZleTFtc0RubGwzcElZ?=
 =?utf-8?B?Q0R6MXZxSk81Zk96dWRMVkhHVXhkdkpjNkszbGYzd25aZ2E0QkNaNk9tSHo2?=
 =?utf-8?B?ekpudW1aWUpMSTdveU02YlZUQkhSWDcvdHRaTHdZcUo4WndWdEMvVnJRM21X?=
 =?utf-8?B?RWE3VmY3K3cya3dnTmt4N0xqSTdsYVRlckx3dWF3NTF4bXhSdVdvWElZNkxM?=
 =?utf-8?B?L0N1R2lLR1JJcEoxUHEyWjV6dUZsY2FaZWpUdGJYVTVhalFEUThmQlJxUVVi?=
 =?utf-8?B?WDMzVk1qOURJa2ZUZmwwcEhObldmSFF5aThPbGt3VHFyTFRtRmxyY2t3dFlR?=
 =?utf-8?B?SUx0WG9relNFdnBDeTVJNDZCclVlcEpLaDZ3U1J1eC9HcWxoZHFxNVpmZ2Mx?=
 =?utf-8?B?Qnl6QjVIU1pmREVQdVhQUyt3K3JRMWhwSVVqdCtPSDBBRCtnOHZSOWZTVStE?=
 =?utf-8?B?YWNDU1RMeWlBQzRKYno0cW5zdjBaRGM5SHRlR1B6dlVwZDZuTFh0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2cffc5-9226-4e98-ff5e-08df4653ae0b
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:42:12.7549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4Pi4eG46EuT1YxhxlABuMhKzD97krB49VA2WBaCEW5B1J0jjxs6r6TsjimfvG01cy03W4PApGar9nTgG35MBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB052106

On 19.11.26 00:23, Jakub Kicinski wrote:
> The core clears HW-GRO and LRO before ndo_bpf runs and keeps them off
> for as long as a program is attached. mlx5e_fix_features() never sees
> either with params->xdp_prog set, and packet merge is always off by the
> time mlx5e_xdp_set() gets called, packet_merge.type only follows the two
> feature handlers. If tcp-data-split keeps HW-GRO on, the core refuses
> the attach with -EBUSY before calling the driver.
> 
> The AF_XDP check stays, the core doesn't know about XSK pools.
> 
> This does change user visible behavior: attaching XDP with HW-GRO or LRO
> on used to fail with -EINVAL and now succeeds with them turned off.
> 
Thanks for the cleanup!

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 ++-----------------
>  1 file changed, 3 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index d8563f863844..e462dfc725ae 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -4585,17 +4585,6 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
>  		}
>  	}
>  
> -	if (params->xdp_prog) {
> -		if (features & NETIF_F_LRO) {
> -			netdev_warn(netdev, "LRO is incompatible with XDP\n");
> -			features &= ~NETIF_F_LRO;
> -		}
> -		if (features & NETIF_F_GRO_HW) {
> -			netdev_warn(netdev, "HW GRO is incompatible with XDP\n");
> -			features &= ~NETIF_F_GRO_HW;
> -		}
> -	}
> -
>  	if (priv->xsk.refcnt) {
>  		if (features & NETIF_F_LRO) {
>  			netdev_warn(netdev, "LRO is incompatible with AF_XDP (%u XSKs are active)\n",
> @@ -5177,20 +5166,6 @@ static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
>  	queue_work(priv->wq, &priv->tx_timeout_work);
>  }
>  
> -static int mlx5e_xdp_allowed(struct net_device *netdev, struct mlx5_core_dev *mdev,
> -			     struct mlx5e_params *params)
> -{
> -	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
> -		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
> -		return -EINVAL;
> -	}
> -
> -	if (!mlx5e_params_validate_xdp(netdev, mdev, params))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  static void mlx5e_rq_replace_xdp_prog(struct mlx5e_rq *rq, struct bpf_prog *prog)
>  {
>  	struct bpf_prog *old_prog;
> @@ -5215,10 +5190,9 @@ static int mlx5e_xdp_set(struct net_device *netdev, struct bpf_prog *prog)
>  	new_params = priv->channels.params;
>  	new_params.xdp_prog = prog;
>  
> -	if (prog) {
> -		err = mlx5e_xdp_allowed(netdev, priv->mdev, &new_params);
> -		if (err)
> -			goto unlock;
> +	if (prog && !mlx5e_params_validate_xdp(netdev, priv->mdev, &new_params)) {
> +		err = -EINVAL;
> +		goto unlock;
>  	}
>  
>  	/* no need for full reset when exchanging programs */
There's a netdev_update_features() at the end of mlx5e_xdp_set(). It
doesn't seem necessary anyore.

Also, there's a check left in mlx5e_set_xdp_feature().

Thanks,
Dragos
