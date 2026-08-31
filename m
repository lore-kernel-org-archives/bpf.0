Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E4F4E0849
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183583; cv=fail; b=tfOJXWFFGvYY4tufjE3MajW3JrFWHeAcSz92TIPProEWUWiLUJijyJxKZdFfrlqaqlgBNDFCAmYRoJuG6WJL/ypeosLoSrucdIZD6Ljci1apzf5Mpwdi7XpUE5gO3yBLjauws4fM/G+lampK6Ki4a1bWJM7Fp3UVxofr7SOfJB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183583; c=relaxed/simple;
	bh=Cbv+m/ahs/r9jLnVuJStTbc6mWeIqIO2HP1pW2JUOtA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kjJ7uT3IdjWb7HJq5DHHH6mkXjzpbse+/jVeOmbUgWkj2xWocvfjMTDMBPBQ2B7o5l7DBWT2XLlKMSJ7+RwYOmveQFtFgn39v4ENNIxn0auCXUX8E1Lp+Ird1gi3zt/xO1ylT/QK7MXEUwva70uFSw2vwmzZkjsgUPhvcZXYj3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+9qlFTy; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+9qlFTy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788183581; x=1819719581;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Cbv+m/ahs/r9jLnVuJStTbc6mWeIqIO2HP1pW2JUOtA=;
  b=l+9qlFTy2wH7/jzVhHVFthZf7i22/R0Fzl+v5cccilFS3eg5fBOhmPh4
   IXOQ03zlWAM2CY8PWVsC8Xn2jgXrv6O4MxQMe9nVMxfdBRhoHirtniJ+3
   4DARNYj5zlQmog9gryN9SYzBOFkgW/gWHV7JpNPclN67I0yKe8eQihvYV
   WFGJu7jLqKCY/L+/3UICNVZdWdjPfvel4NT1uBEL/TeoATO7yE7nrlcxq
   V+BMMnwUI6uF6oVHu9REotnHnOMkfcwU16hAvge4fS+gW6YVfD+DDH1uw
   iQO7iC5JK1XZXYGhayUvQjWPyeimfeWebVAdMIR+ytRjjUjYii1vm+6sI
   g==;
X-CSE-ConnectionGUID: jLZiLMWsQIiyw8Mj78WUQQ==
X-CSE-MsgGUID: pQlclCGkTAKl3XbNY/F24A==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88613681"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88613681"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:39:40 -0700
X-CSE-ConnectionGUID: WMF7ZARxTUqZt9uULpaUSg==
X-CSE-MsgGUID: WjA5oA4xSiSc6f43nEWASA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="267469690"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 06:39:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:39:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 06:39:39 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 06:39:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh6jAxCUgFNZl8DK+OLT8ZizHOwbAZUBI+sMx5uxOG06IV9UJ1BEN09HMF1JyBtHsFxV1Ja1hEzZfTQuvBNP/RiMkxEL9H5OcB/H80rHCfXw6JTc/C33il1zcXsnLsR1nshwW8crHKLUQsD9HeZzLjLS/oEB5DafZNeNP7xrPwFAZoR/egxmhnCZcfuuSHBlfJkCjWsatgHVD5LLhMa5e7L+oi3iu4mtSjnDYTvnRUrPpi/WL4uCJsNHTeCE5268VBgpLwyhMwlifExQAWn8o/A4oZjyAqlpl74jXdXWvL/jiQgq39YbobPQ/sUrLaFAewEw1NJXFMabO9kVGPkNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgNcmMPlCSbRtAoppIk3Z8z5Jnh8q+G5mzHJth5OO2c=;
 b=gBLhdbwdCIB9P9POOfOuIH4PySDHEeGKXdf/7uxYSNduYrr6w4WUOkmsH8Bd/ElzwNiIDEjZLKPkAiI4YTz/0U5tOU1xxUBR3ZHyNaLsPOD/9Dc/j/FLTABaETAxOjQgkEaVbWG1SUD7AbWpKR9S7lYhRVqOpsTgxVezmKQuWsGiI0GXsHOjyaHfNLUZk6IGiGLFDwESXwMm9Dsrbu3yJcGaZotJxVjMC7nMNKGhzirY1eJD8v5sAs150F/E6MIijf0lAhAjScW+5GqxwjX/odMtUvNUZ+tVgHJx1RhutQhq/YzU5+MH4hA1UtBBdma/p4DS4tVzZaY5nKzWDDK4aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB4547.namprd11.prod.outlook.com (2603:10b6:5:2a1::19)
 by LV4PR11MB9491.namprd11.prod.outlook.com (2603:10b6:408:2de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 13:39:38 +0000
Received: from DM6PR11MB4547.namprd11.prod.outlook.com
 ([fe80::b0dd:d6f:a43:a04f]) by DM6PR11MB4547.namprd11.prod.outlook.com
 ([fe80::b0dd:d6f:a43:a04f%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:39:38 +0000
Date: Mon, 31 Aug 2026 15:39:28 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
CC: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/4] bpftool: Set BPF_F_XDP_DEV_BOUND_ONLY
 flag non-destructively
Message-ID: <apWEEK72d3sCySif@soc-5CG4396X81.clients.intel.com>
References: <20260831132648.65843-1-toke@redhat.com>
 <20260831132648.65843-3-toke@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260831132648.65843-3-toke@redhat.com>
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To DM6PR11MB4547.namprd11.prod.outlook.com
 (2603:10b6:5:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB4547:EE_|LV4PR11MB9491:EE_
X-MS-Office365-Filtering-Correlation-Id: f57718c6-e087-4071-9296-08df07654cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|23010399003|366016|56012099006|10067099003|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eWF8omri3S5BRefAn9zRsoSACjU+AzEDee4vZIiFEP1D7bgkxU5XJeyqTf5AGLnAOXEsgIMtkc4CaPXKie9Pg6oIl2WM4WxkrzkX6OwhYScHmhfH2q6V25aYYd9pNUekWRkor7zlQmD8OwI3kaodQ1E2mQcKiozwLfiOhnKl9czJCF1DHr0TBGHYOYpSNIL16QETf6chSJAFa+OdjLMBx80ceV4QOcxFecg/n0pDaXqBfBhtEBzfu/Qk6NyubC5Ks+vA7wgKi/Pa5jivxuQ9+ed7ePbJzqqnQK7fuJ8UVcyAG0KpSepGiD26QwN/GWtwZDrwmqaQVznjtb30tFXjF/VxY2D6EbtOwHYiCRoXpK8OXBTa5ah3w8K+r7P8GxVDc0O7S/QaQqKZGcCPnuBTknGaKKraiMB0xJAABwPuxTMpxOYr/CYnZ/G6PoQxJVnCJUF6UHERXUsF1eFNrBO+SXeV7ocxFdhLILfYBtq4/X7zivHoT07gZHm8YoHBfwhl+P/STZM+bnI4N3d06dzpkyzSLXmmXbT5wzRyI4WHxMF2cs88ORBdXbXJhr4PVSz6Ncy8RHseLNtLvNq5h9e6m8lraSNGhNQxZw0Rg24uoeS+fimM45k9VVrp8r0dprhxSmxhluC2QWuCqT1olK5Y92LrHxxyyAcD3pCmpjnvu6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4547.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zwiNmAeBJ4rcTvoDs/xjgoxM1RpvMO1s+r4wn+HtanvBf175ZwbN6NUFVE?=
 =?iso-8859-1?Q?2MMa4TLDB0vq9wI/RTZgw9hjorf5sgXV2ovaE06Wxv1lxY7emWzjCagk3b?=
 =?iso-8859-1?Q?r1sTEV4cI3Q3SKcfYmR/2Df+/YvtvJPwuCPDngwvGiQYSRVQF5nSFN6e60?=
 =?iso-8859-1?Q?n9pXQnt9W4SK7GarlAFk0E8pznkUiPt5Q95HnCIuk9Aha+nfR1NphKtwlN?=
 =?iso-8859-1?Q?OYkr79S5RkZSQHVrDl061hTKLAZ4jSfXAIvfPGDOlEbUNZQuXLc+yXMEmh?=
 =?iso-8859-1?Q?DUzsVW9Frn3hT5/lHKX1iMhJjaE8FvRLgAhbtOvjpruZkhkKTVPAo27Bme?=
 =?iso-8859-1?Q?RIAFXYGj3B0zWJVX5ogRnq/bgJhHkfs80XCjuIqTEoaLNqJxjtffr1EbeJ?=
 =?iso-8859-1?Q?KpoU9sWvavk5b2E88KE4OekyjLdvBM/5fuj+1p/O0plUsYLRsxU+Uzs2Zg?=
 =?iso-8859-1?Q?RPaflp1pwIejNSkO+awmuVOaiY7By6kLxtIt61bnu1yZwhVJgOE00Fc9zb?=
 =?iso-8859-1?Q?Q1lddwS6+BzNc4wCyfnuEMDLbtRYn60doHL2rI9OlCsKFBYqPDlCbKRw1e?=
 =?iso-8859-1?Q?T61jNLvqyXABKFr7tCQBrolBBHPIb91W1ppVUtHpKqYhMADaYaBuS4wW2E?=
 =?iso-8859-1?Q?xH8QDYlT4zMFIFY6b0Qm04uCSOZ+9dzFiKlvuSQ8incF1Di8ZASEQhwHwz?=
 =?iso-8859-1?Q?yDYmGUEnxR3+Iiy9M5ZuFLgV1sfpfsZem0B0yNJ6Gv72SipLT8sOUovLhm?=
 =?iso-8859-1?Q?TUJlqIeAlGVnpupDXvKkQ4Q8U8Q8321aO/ND0bYLHfFtyTU4zxtIVLqFMb?=
 =?iso-8859-1?Q?6tGKXWgoDJqWZeQUxhslJ7mqXfFokjmajr18oNBLdQXKA+Ov9BEpUH7sOb?=
 =?iso-8859-1?Q?/fgEn/dZt/96GqHnYnKBUyeujH5PlH38jDVT8+cm7DEY2b88ko46i7H3dQ?=
 =?iso-8859-1?Q?5mIq5zW8B+zcl31qOoiFT5pkVug2RUueCv7C3beSDDBJOBsKaEs+XTa/wy?=
 =?iso-8859-1?Q?izlV3EM5I6mtt2kjeek+tVAPQ/9RD+1fZQycU9iNfE3TTickPAiLW4s1sK?=
 =?iso-8859-1?Q?b6ks1NoEUaQ6XbmxFj6ybevB78H9Ts5KSlr6ucD1RPoKFLu00qMX1kxGKI?=
 =?iso-8859-1?Q?Dkbx78hYX+ZatvJYDDp93eE5wx9MNG81+pKHiSbppl/uvfOiZBJXFscMhS?=
 =?iso-8859-1?Q?vW2v9v+3Hc1dKGw7AlJgcVE+98NSLo9NaR7/0nhlumgZIrWBkBZRk30aM1?=
 =?iso-8859-1?Q?SkQX0woCe5VXO8/mcApuMR29KoSlupEbQr7uVUqRCIkqnSRiV9mun8E5nQ?=
 =?iso-8859-1?Q?yvfbCOkjTAwSSricxlwc9BMnX2hbQJ8jM3k2gh7X7IWAtpqlxWkXkBdXPB?=
 =?iso-8859-1?Q?E6DKJBZRgPHX4zOENRkRA/hiaSK118oibc6rM03QedheVvYstWMmiZSa+h?=
 =?iso-8859-1?Q?70a0lB5sO+IV6McyJVJ4NtzkM8XSI7KSQ33XeekOYPLSs64xvk7yIMJkfj?=
 =?iso-8859-1?Q?MPnTsxjIuw4H/1xPhHM47GMBBGPxUZMYsGM/tZ7y6QLmnNM99RKYvUYm43?=
 =?iso-8859-1?Q?N9g/VVyMQ5JXeEro/8VBjAg3q79x28bYbNvl/Vm9B+CJSpyXLHBrgnw+5B?=
 =?iso-8859-1?Q?zqG5HEbPKAOciw2KI4LFn+reEN0Ajtb/zaAguxL233l3ZICdshwV8CwKKc?=
 =?iso-8859-1?Q?tnPJvtg0YZAzXKQ1vjLSlF4nmWQBsxei+P1iwLDeSAO4AjA5CwUsgYTOAl?=
 =?iso-8859-1?Q?xBECrzd6YGbxuEkCtLoRUGiyYzyizBiZ3dtcRvlWcXO2T1DslpB0UJbluE?=
 =?iso-8859-1?Q?euPMS+sExSxRf1ig8OzyH5nWs6ShB11anX4kzIuCxcVzOybZybkM9Ln/UB?=
 =?iso-8859-1?Q?WN?=
X-MS-Exchange-AntiSpam-MessageData-1: yQH55f5VmzR7ChB8uZF/h42SvIHP1YITE9I=
X-Exchange-RoutingPolicyChecked: eRczzxJY77ExLhdbdkomWlgRXABJIvAAGocGN8yF2rgkP8TlhdcXwE3QThDAhl0QPDURiPUq6TT0hmPXJB5PKNUcla95q1OxvBhyCrdvqfwJrpmRM4c8VvybNbwTz6cvBMIbtmesdI6IzD8BgOyV4TMHfDnSNy4HY6o7sA7IkkADhdbUuDX9B7N45lrRC2vucf5ofgylqfAZTnoMY0A2jR71hAikBYDE14eCfC49QF7i8oQyy5J98hurzFDtnP1uOrI9yYJBuKovwec/bozyokxbuinBoczAbErBILB9URP3CeX9IdcAta9FbCejz6BSrbRi9MONu+p0jQ6qKl9UPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f57718c6-e087-4071-9296-08df07654cef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4547.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 13:39:37.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nkj1+/Iazubjf/Od0XUd03pOGLZlAIbIs/QRGE8JlhiYeUv/fi6w58NNIvFjTOJSby3MtQNQFqT9Dz1+ZXlwmTPXKI7dXTGtiVi+mPxycZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9491
X-OriginatorOrg: intel.com

On Mon, Aug 31, 2026 at 03:26:43PM +0200, Toke Høiland-Jørgensen wrote:
> When setting the XDP hints ifname, bpftool would set the
> BPF_F_XDP_DEV_BOUND_ONLY without looking at the existing program flags,
> overriding any other flag values. Change this to set the flag value
> non-destructively by OR'ing it with the existing flags.
> 
> Fixes: f46392ee3dec ("bpftool: Specify XDP Hints ifname when loading program")
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a9f730d407a9..8c2f9255b36d 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  		}
>  
>  		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
> -			bpf_program__set_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
> +			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
>  			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
>  		} else {
>  			bpf_program__set_ifindex(pos, offload_ifindex);
> -- 
> 2.55.0
> 
