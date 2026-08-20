Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871647F779;
	Thu, 20 Aug 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248407; cv=fail; b=a/VpZHV2eTR0KK5mpvFkMoqUbZYj8AxIvRuw3oBI05SMw+DVnxbilkz0QETaAQbFtOv1xSiserKTRyjBFK8IR43Wa3bZpWsqCINeyRYnnUxawiLFDBzJniQ0KnSy0R2CzhzNAXSpJzF5eT7+RWcsv7eJJWJ0NjfkioIq8y8emKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248407; c=relaxed/simple;
	bh=JilcGDqzLnpZZTGTvrSl+fgMA4Ikwl5pkmaazMeO3b0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yx7Bp6RMp7o3SUCYJ38IeQc4UrIgFCntAjB5W6Wc6HhOAX71cNbHkBnAjPpjBOlpuyxB5xLm6JnYSIcKccEg0y7s3LoKI+5iqhblV9qfeChZ+lrQa3l+57Hx4KL7q4sY4t+3NrZ5J26ggl79WDLF4PLNWOwI+qiF/jHAn4ZzqzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PDTyUz5P; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PDTyUz5P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787248406; x=1818784406;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JilcGDqzLnpZZTGTvrSl+fgMA4Ikwl5pkmaazMeO3b0=;
  b=PDTyUz5Plz5mC2q66zL1akgAmTbO8jIqlQUvJEzZVUxOcfSdmYx9fQas
   /QeW3Yd3wg1fNRyGNv+432jYknKx4d4AX4v2GAjV/UaI0Dlk1O37sztt6
   UsCaKWwSpj8yZ/V9NMpRYhiOkc7O/g+VDNg4lFLAPM2hHAFcYOuYvOAKy
   xGohysfFpoUkkNr7tsxdy7nszs97w+acyzPR/btrweIHNLJ+Lx37FDIq4
   cd47MtFdcoqmxtAj7PIkndNGTD3Rp5R+bRVWcMY3IafiDi7Hfqgu+6cyw
   jsaNYgDhIqgIHlybjF01QbXUiI4VgeEairBl8UAl/7zMAePWq4lZJvyeb
   w==;
X-CSE-ConnectionGUID: yif1bd3PSqizGPUq5Hi1vw==
X-CSE-MsgGUID: rICjFNboQX+trIJS10ttPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91664489"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="91664489"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 10:53:25 -0700
X-CSE-ConnectionGUID: HDDaoIHaTFGRXVJLE+sDqQ==
X-CSE-MsgGUID: znb9AyLZTsiwU9iaJy0Sxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="268043031"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 10:53:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 10:53:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 10:53:23 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.28) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 10:53:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz5Frsi+bcMnq6s3F7f2FzrRvULMHtH8oGuJWKvU1TTrt8HpqvXMT/6wJPjW4lONzvFeQhM+2ID1AF3tB+JMY+kz9No0gbLKs+fsVjvAf0xJY6J47FUuXpL4KdAUnN07syezg2pLQ5jczDbEmVUPYlGhyGl8u8kWzfyl3GC884dNmKMldTWLNg5aPzVZ/kX3C6BhQIKp3/ZZBPO1iMwRgq3t11Whdc6++aPi2rbli+ymD0IWRz3DOX7rIApXZOtctyyKeKehYDa+Y7RMvs2FcPW+8FI8wqiNlFgMptxhXq1FF6sisEnzprhGE7gPwjiteo4MeROnej+QMIELAOlQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSDLxRywgt4ro5jA247LpZcWz+RYTVnnHYkPZgRtN8I=;
 b=acyet1LGyVwVLqBBgSY8VPjJ467c2t2ZF0bROm2Lznly7uAUWYcct62FQJHu/DCSLHOMpnbxCRW/gcgOAipu2RlWAMC1/hEXcSzDUEZ1Mqq2meubd//hNo3wkQ23amXyMGeH7x2ZTI1ALo4xZE7LfK/XuiO10ZIR4WKps3GqbfPabuyy/OiifSIVc8UbBu4SMJlHfc0hA3nBA/0U6LOvPY88ax/ZeIc5KVuBHd6p4iPjYgYZ/AN5gta4Y9e8gzEfP7nU7kqHKhVVJ5Pkodg9wKyMMj74a3NLthB6thRUkAMMJ2HRwuUktVlY76BXBaIi+OqsHxaqqyitbK5oKSFtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Thu, 20 Aug 2026 17:53:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 17:53:09 +0000
Date: Thu, 20 Aug 2026 19:53:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kernelxing@tencent.com>, <davem@davemloft.net>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <andrii@kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
Message-ID: <aoc+/OW8Gy4ZOx+w@boxer>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
 <a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
 <20260820104419.050cbc44@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820104419.050cbc44@kernel.org>
X-ClientProxiedBy: TL0P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 4561c3d7-e449-4c9a-aceb-08defee3e548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|23010399003|4143699003|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hg+57ZPxbPUlx2jip49OMSXZNQeL9YQ2yhZBzCRpdr9iRyAC9PcLHKjFKztZJbllfH17EoYagWZSdxZ+LN0djuGb28iS0wZ7SH5B5vtEO32J/QkKcf1MT4DPcY+SNywhyUj4q+yWyiG0ELb39eWiGsys60GGML/9oCpuXFigL+PUBGn0V+7Pm5NLVx6CX1HEeP+pZU8Ga3v/BV50F8f/TvgPe1JhB4MrEaaLqS03jH8/VrHi2gjNTYfaEdsgO5AKX3XxVz7eV0hpoqAv6Woi3gr8SjItGOPoXiaRL+Q60b0wvnuUT7tiF3rBOpP1WUwDyz0LofZdKEP9VEDjrNCZMdpJ/hIrRRwspfM1qZviSmQRHobHWxbADuojk1IkiFF3mvAXYmbXQqczjWQJ+4unq4/RPE08DgtSSwMxbx+HoTlNoM91j6xoPxRvwe3oJJGXOTiDBMpWwa0lmoMiq8SS2/fbDhyXbNLjeaclWy4DS2k9tL28q+Pj5zzsI0iq9q5mDYZKoLK+YwyvRJdyQKBetJFqi50y4b1VpOnf2Bjp2LdUhAuovk5JcfteNtw1leHSpgrcUxMjQQ1xenN0ddODAzeW0pAHxzS0ljuOrEVq9SMI/dkSRqtNreTsJI9/6koEYgGN/5wkZ/JRWRTe4gmxI1ymEHaROoicOP7RGJd01Xg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(4143699003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhjbxmRR1RRukin75oZREGK77nXCKuchCZ2hvSXT1dKdCriDoBi9gwhkpmyG?=
 =?us-ascii?Q?hsM5q+HJ9kaPIt66glBDIBGQqT+zCpfaHf+pbI15HAw5ZWJrvjFeVltv9nAG?=
 =?us-ascii?Q?VlaCuOrWSGrGf0ZXUT+clUznlcNlASTn2Ze3Kf6o0nWlBI6zDOmZAs0asBo1?=
 =?us-ascii?Q?Y7hBcReN09C/TdmJ8Ky3eI020hNiynBpG70HZbAZ2XaTD0JnjLf+XXOC3r/7?=
 =?us-ascii?Q?1xwkYsFIUcRU3/0m9peddM4CvLAGmXIizsrwqZTxPSPeApSSJKm8TODsrNKE?=
 =?us-ascii?Q?7VRBQQ6L5xxsKQtV98orknpy4R+cln3H60/z3HVLgnlO8NRsAjYhGqUZahzl?=
 =?us-ascii?Q?gyQvm2QmLoyR2slswxzpwvosgz35B11ax4K/aD9EU/yl6Je9fgw9375unA6d?=
 =?us-ascii?Q?0a7arvACfUs8gIGGp4TTbnvwtazuo36syAo5Pzyb5HtDhY77pTyJJk7XPeaC?=
 =?us-ascii?Q?MxLTkkbgU58sljtRsPe1Ggswfgn6FkgIxHhYuzQ/ultAstBjg5XSoH4GrKUD?=
 =?us-ascii?Q?OETcgyGb1fjak5vutigJ1PODBtPw6+WBHLWS3Kc2DdffArj8vGrmKa1H8cir?=
 =?us-ascii?Q?9gSfw2sawhEyQV3KuWXhskXQD4rm6pEgRBf6skJHDSHgfkEu2HRHkpcysSPw?=
 =?us-ascii?Q?YfQnCNusxQwtl8ItjJilWp6de0xEV2K2ZOO1qGy6SOatnpm6HGopizcZCcGC?=
 =?us-ascii?Q?CxhUFdIPNXnTUj4bI0oBZSJrbJ1HvD6J/IoSngdZJ81E3kcTisH9TRhFjAMi?=
 =?us-ascii?Q?FGryAdmbkTZ8PaPtaN4SpOHhqizqOWRD47IrrAU1OhqXq69uZgUmif3z3LRZ?=
 =?us-ascii?Q?jvOETxyoWnTq8U4WcBpJ2ixow79HzaV1ddoA7Stz2yvV92VdgCr2X7gwzTB2?=
 =?us-ascii?Q?YryTW8ce4hgZe8ZeBqxYMWtPE3CqXbgGnjYOy7dTIDRI7kZJbqRrOM9GcA5S?=
 =?us-ascii?Q?CFNfLemwIw/9Xysinr+ZyY8jAs3MF3CVCay2s0znsUGbzAGUMH2nddsrXUlK?=
 =?us-ascii?Q?LwTV3x1Hwy8SyUAOKXAqCBq5n7Jz8WHuMGnCwpwZ1tpqMEZED1brL0I//8Gg?=
 =?us-ascii?Q?z1PrXP810XOO9unGMqZs574OoTuINP12yafIsXRZxg+LMXIoyx63swxLAIJg?=
 =?us-ascii?Q?qkhdPuistXmAjNxa6NnpmPYWKWG1uiU5h5/wFtv8uKhcNG1dr2ZZAWRNldvu?=
 =?us-ascii?Q?N/NbgLWR2nMAottpg78iv3dY41dMZcSgXBssoaFewffG+DBS60khpeFewLXR?=
 =?us-ascii?Q?g1Z+37bGgExgW34yvt8qAIghJTkchBpPXmXt/RqPBrfSel9n3mFXlnbh6jwf?=
 =?us-ascii?Q?LVN+2OPUxK+R9AW1D44ou1dxg0xUVk60KHzInRWvUj6+yS+PjABdNwM+0QMJ?=
 =?us-ascii?Q?wjbLOybeiFW0L2D6D3+ZRo1KsclDW+W+bYP2pOhwqvRZupggllGl9cP30WMP?=
 =?us-ascii?Q?lNPXvFfArj0sGOYa/Quhfe1Le14HawbmgeA38sF4H/eNw5FJWGhV9LEJMYh5?=
 =?us-ascii?Q?+F/5LkuvvRkYn9iIG1EB/GsB4dzmG47tNF/UAKD5VpffmMIr+eZcCjG2qd+G?=
 =?us-ascii?Q?Ipt+Eh5WhiazDnYQkJmKuHztnHmwuV+MQ9Rh5LHdfQKPS2qxcRhNaeAsiqQ0?=
 =?us-ascii?Q?X59S36RQuMoffUf/kAkcncr8NjJDxbSohbhUFjrj1L1Ktw5d+84VsOPEN5Im?=
 =?us-ascii?Q?HfFzxH5r9Jq6LEQEj8PSt8ePFSuN6h4j2T+D32AItLRh+V6tRkWc06kHu6YK?=
 =?us-ascii?Q?BCz6VZN0PEvTyXL9dn8v1eFuaAm6fdg=3D?=
X-Exchange-RoutingPolicyChecked: CJ+8UkQ6VLbTgbv0lEkr60EjXX/7dLIB7pE4vkZJlhIWLag157QhjWpo8kzNzx4TNH1zoAMSGapSRRFgjl1V37zA6Vy4DnoB9WxBwLAKGlUJoS/yjRpjeAR7gfCRoehWfgXA1lqNfH+QbVeWq3uS12JfRXeCSXa9CvYa79h/yzc7uBR9JSuChBysaJFpBmuLyHo+DClyTAJR8Eie16ij06rPFaWvw9FjsZcDmLMtyF1e+ILuwUF3HMcfJY8TS7k0W4rNS5Otn4ZlBT6mq5iYuhesv4mXOOJ/KclSNJX5PbpQeJh/Uy6nAf++m+YyN3oNYp1mnKZI0E668eMPiXinDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4561c3d7-e449-4c9a-aceb-08defee3e548
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 17:53:09.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUNl5k/KyMjAcBoIy7lhPH6YHREKNqyd5niXnaef3iBhywuOJ7zM1ap5FUf33eke3C1934nI2EOGhqlZ/l+wAiXvgnt7aGWBNsBW0vTHqoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com

On Thu, Aug 20, 2026 at 10:44:19AM -0700, Jakub Kicinski wrote:
> On Thu, 20 Aug 2026 11:35:53 +0200 Paolo Abeni wrote:
> > ## Form letter - net-next-closed
> 
> these are bpf patches. Tushar, tools/testing/selftests/bpf is BPF

But AF_XDP is now net target since some time. Should we move the test
suite out of bpf directory then?
