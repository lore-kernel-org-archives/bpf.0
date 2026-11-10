Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794314946;
	b=3Afc1ADODorEXUHfbG7pwsOHVSwBqpKHwHttmBqgOoXmNAYav5GoaWFKOD9aFZDtH6i8
	 SFbSamXcxNBW3s2CCT+TyqHT9XtHeNm1OL1nsZrDK64x4Lxx8Bxbvtk/ZirYkUh3WSa2q
	 E18UQAK1wFV/LKad7tlPkrxVz+O0YY/wZCMy/1H9ERzuxERM68ZbddpIuDDFoEvE8FyIw
	 nnd+yzuQXWvErx04vB4ndby85ALZikILBmHtn0zNuYVamfKrmWg2VUsUdCr9n0js9nbnc
	 tKrb4/2YF9NernmtfcWphWwl7ZgLbfRhLTJ+rfxVWZaIAbeWWryWaZ868txinqH2vTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314946;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=WPoCDC3i7iWrjJjwz82cqOF90WUWMi+Kg2putgbI+Mg=;
	b=dkfM4THKaJBsAQTrwPXG37i9sZG/EddT7znb33BBEcQTz13QY0zwr0JtoZ4at+YcVqCS
	 F/nC+Z2yUgQacDi6F2/TAbvEwO0HVjLKNHHx0pR3f/hX9m9tcvaxyb581oF2IFiDqP91Z
	 PhJupKMPrwmIXhueopOMACOift4+Xo3PTP6oUkKUAx5NMUhKHXODdGIXGNmD9DDntmv9+
	 7IyLt8LKCthMKZlo9FeiXVIwW9VFtEt/F7wN38es4kAdEMC6GmGnAU8N0sHUW7pQy104P
	 adlQifnvz7+NvyGmq5zv5D6Hza6bZaPoGQL00Wa8WkkDHVMFaQN6rs1KdGcB+IiD3NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ABt55f41;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194F606A31C;
	Tue, 10 Nov 2026 12:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F194F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ABt55f41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794314945; x=1825850945;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QbXH5xkRbKy+69yXORhjZf0wbIIkucAa4nlpdBS4dAE=;
  b=ABt55f41JvlUxj7cu+wcx1QBh2ghAjWRzNakp10//rbUuC/6jHmuvyv8
   5I7MomqtKvmFciMACpdm3U5IFtoXNmzxSwacrHcIbZ6hcG0RuCh87LVu0
   TYwPzZHAKidqsuLT+8u3w5M5Ck0RG6sua8RjFV0EHmviVN4HlzhbeRLO3
   HyWoAshdF87GlAp+UnYu97jyfeuJsT9ApPC0sxfYpy6eVINAB0JNZ0Ks3
   vC38M/48zwviyUdbGWODrIUi9+hx2W2uJa0KAej0hMySUedRSo/U7LZOZ
   MnTQnblx27k6FaMqW2KvE7J2/uCxbT5cY+ga6Iz3UTv+NDsdMJmBmPzs7
   w==;
X-CSE-ConnectionGUID: 5dSAFq/7R2i0cFRayFODnw==
X-CSE-MsgGUID: 0chByJQ4QBueHnKhZUySrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2940187"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2940187"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 04:49:04 -0800
X-CSE-ConnectionGUID: wZHQBZNzSF6Hd/EMfJeFFQ==
X-CSE-MsgGUID: 4TnhoMTVRGmdBDQH6HOwWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8146043"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 04:49:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 04:49:03 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 04:49:03 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 04:49:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eDbvqlIXosddCCgSJMwob3fOPVxQSi9p59EocSZ4FRJnOgfEJp3FTxZz5wvCzz8uGPeF0/okgOic5sTQOnrqrR6rrFKuTxTgzT8IyLZ86VdfXSdB3LyBJs/xGorNNsU2nlkUQGckZdLkKhinqd+EFMSYd52VhpLw3sKhIYaPDNzBRgHjW12pdDOnFgEqYdmQ9WWju8mMm6rS79xp2ixejRtmYYQfJCz5TRc0exTsUdDlxrkRN1heGTo+59nP8TC22yfJbUuY+x7VAqn4Gb6lr97khu7vEZBGb5/D8DOOICTpdOx3zeuo6VFA1csXcPbpGaXTQlEM5jOfCTSTVZrdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iA+of5QdqsHH5GGl+T/kHA9kQl2TMSScZhjHvoHCoI=;
 b=HjsY1zkAL77cNF0lBA4o7m4RGzK05UY2GDFK0jAIN2MxBj0+Gcf9oaN81VtGk4pnfgPjewvXZsCe/4i1kshtljnxZ6sp7ajI0i1/66qkYhuLmOmY82snIOFydB9QpFSGmMBAhACf3vAfT6QRj/U5G+EHMiNV3VvwfzI4A/3qprKi7fvqblVHcary73LTCr6NlYiKuf1yT/MijUbMzKnBmjGo+2cB26OylYlzUIWcg+jAMb3k8sYLADaQdlrkmK4Mvpjc3AfSJ8ydQA8NkUoywsPMPNmapMhxTPMKSs9fCuDofQkew1OvRB7ZrjS9QQg/bdu0/aHNcZhikzOjBXvYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DM3PPFCBDC4B878.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f4f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:48:59 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 12:48:59 +0000
Date: Tue, 10 Nov 2026 13:48:51 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Slawomir Stepien <sst@poczta.fm>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@kernel.org>, "David S . Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "John
 Fastabend" <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Tianyi
 Gao" <tianyi@cloudflare.com>, Liang Chen <liangchen.linux@gmail.com>,
	"Yunsheng Lin" <linyunsheng@huawei.com>, "huangjie . albert"
	<huangjie.albert@bytedance.com>
Subject: Re: [PATCH RFC net-next v2 0/4] xdp: reuse generic skb XDP handling
 for veth
Message-ID: <avMSs9oopzc1SAnw@boxer>
References: <20261110101941.1059662-1-sst@poczta.fm>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110101941.1059662-1-sst@poczta.fm>
X-ClientProxiedBy: BE1P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:23::7) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DM3PPFCBDC4B878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d99240d-0ee3-41c1-836c-08df3f28fd4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|5023799004|11063799006|56012099006|260925022911599003|260925021911599003|260925021311599003|22082099003|18002099003|3023799007|10067099003|261102123227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: M1wnqbzC6hec9FlJhxJHkv2EcPz8MCDUlh7zSqPpMkiI+xqf96QqVHwwJu6kderq1os1VX7p62Gk1IE6+lvhtaIMP+PJDsXUXGykUSc1Is3TFsX21KhougEFk7dsMK+xvbCYlTMCkkK9ZE1k1UR1HmONhQSbQ7jpro8bWu1yhQDd763ZkNXZ3aBV4N4BgV2A0Wh1L5b6Hu9UH5RO08zyoSlApt7/mJbdCV1Vs3yXF3ZYeOS+HqHzXwrCbD354bPHNpfe2UlmI8om+FmCltEX8uKH5baneILmRdcnvOnw/+n4JxSZRhPz3I97Y109tlS1t5igjfxiHjPFLShq/0kSB/kL+LAaO98fQ/i+ORGQiBuyd5vVO45PsdAxAL6/Qpe4C0bWbqq59jZRtMp+5heMcu9jL32i5Nzb5aShBWfjwyg3KhLyLWRYXmMd3q8XVLgMgmCnXuDsXPi4Gd7R42XbZpTly4wJQVwaawxM7xsqWCawZI58gipIHHWgy5ma/V02iDMIUQx1z28rB8zJSXgl7hh0QfLsKrukaEDMCxxM9FR8LJRDwbb/y6m2PB7BQ/fYSQAXfPcyG21skNOsmAybZQxBiS1gx7PldZAU1yfPidekOiXdRQKAR2kaM2nJ9FTw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(5023799004)(11063799006)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(22082099003)(18002099003)(3023799007)(10067099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/yUSVBL1eEdqt7D3QZgT5a8ZIswVUzkn8P2mJHPje2H/EqFDbYlw+xFE1D?=
 =?iso-8859-1?Q?GR2UXORveQyOEnwxpslo0M0ib+5KS2PtFTh3Bxv9m5PFFgXrDudShvsEHM?=
 =?iso-8859-1?Q?s798xxSzQVRWCILpf8VfyYmeDNbULNYBoDbzJCMkVovn+JahjRMaBhoNHR?=
 =?iso-8859-1?Q?GkKOcZSl0R7DapfuzMbn6hLBPPJhqCbAtvno2gLIiSWOFzIzuXEtXHAL6e?=
 =?iso-8859-1?Q?pb6yMf226WjTfiJGcPTIy99phhRBYVyeZHMNMLmTUMWpbWitAUPSlJTcE6?=
 =?iso-8859-1?Q?1NlCYwhLBYukV7BpPL1RZqsM6TKLhmPaXD5AZdgLF0RnpZfyl7O2CpFA1N?=
 =?iso-8859-1?Q?kPUsmp7x/1gUdJVyBxeCy0Qt1qGW870l5pyd6dOJeKk8PJlHbj4J8gD1xA?=
 =?iso-8859-1?Q?0DOAlik/4k++U6z3jou0ahmwtIc6L2ihqd/9DHbiOkPm+TwxCbysTT4a9v?=
 =?iso-8859-1?Q?HZ0pGwsDUVwJg40WTuSjPg8C6ejt3fxayqTauiS20oDE6SEvx8hoox1ycC?=
 =?iso-8859-1?Q?cwu5GWR4s4IkTv6/DFAExUxWqMdGAwOJ324B6jqwMXXVngP5Uu6g36DLVq?=
 =?iso-8859-1?Q?Ldnalkr2Y+5pWqdDtabw2x3dNVg6rwosf7zy75MdPtp0qoZNUOw9S+HrSJ?=
 =?iso-8859-1?Q?91IjuIYCUDO8rdJcjBq7STEwq4rRTEdx6cpI0bobcJDyozHa8klBVNDsqS?=
 =?iso-8859-1?Q?3VWeG+TJvjpMpAypcn1vYxdqnk6iCx/Jn5g6b/B7X5/Slv89Flmms7Ryft?=
 =?iso-8859-1?Q?nz2sfxd4TNo0KAuOuwupRIojiGgkOp6GPx+kl9/bArhkWzhrFzbfZMhr4x?=
 =?iso-8859-1?Q?z9n93UmDesgKPbGeUt6Scsd1Ty0SNYnps0kHT+fygWL183DuF9mbYaGWbM?=
 =?iso-8859-1?Q?i42Gha4rJ3sdAeZTv+tURmmKp4HxhVezzrf7Khgoo0rOUNsxu6rrLMTN9J?=
 =?iso-8859-1?Q?JedWxQ/tOpVInPTOojUwhKGhe/3I8qybAP6AEgS8FEV+a1VCrx8mAciuTm?=
 =?iso-8859-1?Q?1xG9dl9D26CXmtxfl3jLtNu9ycFSHuo6aBgRMuWmcqdAIBAf4hjUgWDhq4?=
 =?iso-8859-1?Q?2RYGvEcEuScqbECXgZTpJ+6ZwxJu4JMcxPL3yxwx4fcuCxF+ZOQO13EXHj?=
 =?iso-8859-1?Q?WbEkTXmOBczKSUBqAJwVG/dY74aGx2USckKzE6Qj+C6ApOhebPj+NVV1Zb?=
 =?iso-8859-1?Q?Kmldf9R/Q0zPDi+BBa8bCMLmEUBUiyH6FzU7lyWhoQYPZaU2c1u3UPm65s?=
 =?iso-8859-1?Q?c2xl/64SdZ97mTKigS/fr5zObX5osMvGCG5+HRq1AJbt4HO6H/a7tXsTMt?=
 =?iso-8859-1?Q?W9b1mpgdrLlokBDn6TerfDhQU+4GkAn2b0ygzS6wAg+7LiXX9ajmGzErMj?=
 =?iso-8859-1?Q?ZJB02revcygaP/hxASn0+vRYzI1waeeoL+RoZ3G9sQXoxLPCjM7wqFsD20?=
 =?iso-8859-1?Q?6oADkEaRcKeeKZcSNmYXYN2ENbGWRUI9IkYP/SuTg4LNIO0BE7liD52bFJ?=
 =?iso-8859-1?Q?xTjk33aiBPMRGIrqFeWy5/rGUyhLcUtNshTOB7+FNwGcIPbQPteDoDoKua?=
 =?iso-8859-1?Q?av/HO/wQD8bqVdMHBCNYR72/gQZS6MogqA6QXA6Jg8drHjx8PVzr0tMsH7?=
 =?iso-8859-1?Q?RpDxXjTYXYU2ZKmAJb+U3w38q1p3YHRbUtVRwx4CmiSPz40d74imdAUx7B?=
 =?iso-8859-1?Q?9AWX6pn0MaqQ6mIVFSWSwehPQ6Kp0ylf1WPxL75z+oclNrxPny+Jo/hBVk?=
 =?iso-8859-1?Q?vL1XJmEGt+cOMj0SL62zS9Fnsgm754pKf1Gzpgc+403P/cD3ndjsGGdMUv?=
 =?iso-8859-1?Q?iSP2/ur1yWSGj9bekDxteLqjEfFzLCw=3D?=
X-Exchange-RoutingPolicyChecked: mGutJ3y+dK2mLFuYvgub05QKOVvUNJwhy22XIiEcHECiAE5HCoc5+APPOQ+v7RD9neuQrL/AkGNWXkf3vj0OPkBLDFem/eWD10O4No1RX1eoeo+GVv38lhKoFm4+I3CHG0+WdesGRhZVtIvHOC79WaV1fCHPiKoTE75FwMOCvYq/MPambuQtHE+6bkXtjYjR1BpybkQOaMXsHsFqMoQDi6OtfYHAsiGelMD+JPujIMrB86CQ2jEzH0fGLxZd+jM6AciCeu+0zcXtG/afOh1+XDGvRsnZP/xSvJOP2vLRbv3ttTjqUWwCXiBl/JE3FwSG+SqfUnM6p4suvIdVtWedDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d99240d-0ee3-41c1-836c-08df3f28fd4d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:48:59.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eswJGiMnlxYxyABid/xs1VDTXV7+6ym5OpNyic9O6qZSKdLSw6R3/5KuwsMT8X1BGlIcC4i8wHH3Qvf9ZpeQ8t866hZd1l9o+yax9/h/sDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 11:19:37AM +0100, Slawomir Stepien wrote:
> Hi,
> 
> this is v2 of Maciej's RFC [1], which makes veth run XDP on skb-backed
> packets through the generic skb XDP path instead of converting them
> into xdp_frames for XDP_TX and XDP_REDIRECT. The patches are Maciej's;
> I addressed the review of v1 and measured the performance, which was
> the main open question there. Changes I made are noted in [sst: ...]
> lines in each commit message.
> 
> The motivation is unchanged: veth pins the skb data with plain page
> references (veth_xdp_get()) to build an xdp_frame from an skb, and the
> rxq memory type it reports does not match memory that was copied into
> a page_pool, which makes the AF_XDP selftests splat when a program
> shrinks a multi-buffer packet. With this series, pages copied into
> veth's page_pool are recycled (0 rx_pp_recycle_released_ref, was
> ~4.8M/s in the benchmark below).
> 
> Dependencies
> ============
> 
> The series applies to net-next with these two net series applied
> first (prerequisite-patch-id below):
> 
>  - Tianyi Gao, "net: fix mac_len of skbs copied by generic XDP" (1/2)
>    [2]. Without it, cpumap redirect of skbs that veth copied drops
>    every packet once veth uses the generic path.
>  - Vladimir Oltean, "net: pass the XDP action to generic_xdp_tx() for
>    tracing" and "net: validate xmit skbs in generic_xdp_tx()" [3].
>    Patch 2/4 changes the same function.
> 
> Changes in v2
> =============
> 
> 1/4: MEM_TYPE_PAGE_POOL_OR_SHARED renamed to MEM_TYPE_MIXED (Björn);
>      comment on what the type means.
> 2/4: Rebased on Vladimir's series. The redirect callers in devmap and
>      filter still return success: generic_xdp_tx() frees and counts a
>      failed skb itself, so propagating the error would free it twice
>      (Björn asked why the error is not propagated).
> 3/4: One skb_needs_xdp_cow() predicate for generic XDP and veth
>      (shared, cloned, nonlinear or headroom too small) instead of a
>      per-caller callback and INDIRECT_CALL_2 (Jakub). The
>      skb_head_is_locked() check is gone, it would copy every locally
>      generated skb. Copies go to the caller's page_pool with
>      skb_pp_cow_data() also for programs without frags support (found
>      by the xdp_metadata selftest).
> 4/4: Commit message describes how XDP_TX/XDP_REDIRECT change for
>      skb-backed packets (Björn's table). A failed skb XDP_TX is counted
>      once, in the device's tx_dropped (Sashiko). veth sets
>      skb->mac_len before running generic XDP, as
>      __netif_receive_skb_core() does; without it cpumap redirect of
>      veth skbs is dropped.

That looks sane.
> 
> Performance
> ===========
> 
> QEMU/KVM, 8 vCPUs, minimal config without debug options. pktgen sends
> skbs into veth v0, the XDP program runs on the peer v1 (skb path).
> Packets/s delivered to the destination, median of 12 runs of 8 s over
> 4 alternating boots per kernel, 95% bootstrap confidence intervals
> within about +-2%. Base: v7.4-rc1+ (f66469d9905b) with the
> dependencies above.
> 
>                               64 B                      8000 B (3 frags)
>   XDP_TX                      4.49 -> 4.04 Mpps (-10%)  2.25 -> 1.87 (-17%)
>   REDIRECT devmap -> veth     4.30 -> 3.95 (-8%)        2.18 -> 1.81 (-17%)
>   REDIRECT cpumap             4.49 -> 4.47 (0%)         2.02 -> 2.27 (+12%)
>   XDP_DROP (native veth)      5.65 -> 5.42 (-4%)        2.82 -> 2.71 (-4%)
>   XDP_DROP (xdpgeneric)       5.63 -> 5.83 (+4%)        2.94 -> 3.00 (+2%)
> 
> (cpumap 8000 B base: base without Vladimir's series, which does not
> touch that path; 3 of the 12 runs of the other base kernel stalled.)
> 
> cpumap avoids the skb -> xdp_frame -> skb round trip. XDP_TX and
> devmap redirect to veth are slower for two reasons:
> 
>  - no bulking: one ndo_start_xmit() per skb instead of ndo_xdp_xmit()
>    with up to 16 frames;
>  - at 8000 B the receiving veth copies the packet a second time.
>    Before, it got an xdp_frame; now it gets an skb with frags, and
>    nonlinear skbs are always copied (kprobe on skb_pp_cow_data(): 1
>    copy per packet before, 2 after).
> 
> Vladimir's validation itself costs about 3% at 64 B on these two
> paths and nothing measurable elsewhere.
> 
> Questions
> =========
> 
>  - Is the XDP_TX/devmap regression acceptable for the simpler and
>    correct memory handling, or should it be fixed first? Options we
>    see: skb-list bulking in the generic TX path (Jesper measured +30%
>    with xmit_more), and not copying nonlinear skbs whose frags are
>    already page_pool pages. Raising veth's needed_headroom (Jesper)
>    only helps linear skbs from senders that honour it; pktgen skbs are
>    shared and always copied, so the benchmark above cannot show it.
>    We left all three for follow-ups.

Thanks for these tests, for some reason my local benchmarks were not
showing such differences and also xmit_more was not giving me much of a
bump.

The impact is noticeable I'd say. Could you see how xmit_more change would
affect the benchmarks?

>  - MEM_TYPE_MIXED vs. separate memory types per source (Jesper).
>  - The redirect semantics change in 4/4 (Björn).
> 
> Testing
> =======
> 
> Each commit builds with W=1 without new warnings, checkpatch --strict is
> clean. test_progs -t ns_xsk,xdp passes; test_xsk.sh shows the same DRV
> XDP_ADJUST_TAIL_GROW failures (also with busy poll) as without the
> series. Reproducers for shrinking frags in generic and veth XDP, XDP_TX
> of multi-buffer packets, devmap egress programs and bpf_prog_test_run
> after generic XDP on lo pass without kernel warnings.
> 
> The scripts, kernel configs and raw logs behind the numbers and tests
> above are in [4], with instructions to rerun them.
> 
> AI disclosure: the review changes, the tests and the benchmark were
> prepared with help from an AI coding assistant (Claude); I reviewed
> and tested all changes.
> 
> [1] https://lore.kernel.org/all/20260509084858.773921-1-maciej.fijalkowski@intel.com/
> [2] https://lore.kernel.org/all/20261103200036.65764-3-tianyi@cloudflare.com/
> [3] https://lore.kernel.org/all/20261030114753.185281-1-vladimir.oltean@nxp.com/
> [4] https://github.com/s-stepien/xdp-rfc
> 
> Thanks,
> Slawomir
> 
> Maciej Fijalkowski (4):
>   xdp: add mixed page_pool/page_shared memory type
>   xdp: return status from generic_xdp_tx()
>   xdp: split generic XDP skb handling
>   veth: use generic skb XDP handling
> 
>  drivers/net/veth.c        | 191 +++++++++-----------------------------
>  include/linux/netdevice.h |  33 ++++++-
>  include/net/xdp.h         |   1 +
>  net/core/dev.c            | 122 ++++++++++++++++++------
>  net/core/filter.c         |   7 ++
>  net/core/xdp.c            |  54 ++++++++++-
>  6 files changed, 222 insertions(+), 186 deletions(-)
> 
> 
> base-commit: fa5196392691051963726787944db872420dfa75
> prerequisite-patch-id: 7db3107f14b28c509845871045e6af93b7e267bc
> prerequisite-patch-id: 40350101232837c5a38ba1662825228d01734b39
> prerequisite-patch-id: 0b57f8c2a409470b1ddf8df747d906d5d3dbd9f3
> -- 
> 2.56.0
> 
