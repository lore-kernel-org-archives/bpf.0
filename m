Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794498264;
	b=iHY4biMXwlJXVgGEw/MTD50SQiJt6KRqNpJ5dibeFG5m2Hix1BFSugVx2hUaUZpiwzoz
	 +E27jS8MStr+ntWaG0je7NvmgsK2opUeaILYacXcD94aGhyerQ/mfsFPpG6Zw1eusc+QS
	 wR1MptoHPsJV5fwlgsS934jsXRJrSe3Nmzpd2glAAWuMizbYIcUBXcLByhb5S8WUgTG+z
	 gkgUgap7nmM4/rqQAgGnYZ3XYqI9IrNs3VxhHMFIiq2RS62tvuyFQw/CposXzbftr5Nfm
	 56iHTtHJ2wEY2u83RL89nl/6z2qVsn3y2wI/J9Nv9xQw67JJEDaecTUbTz0wFypu0sw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498264;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=USOLvdBPZlPu7A4HqSy2CzQxbsgWYFJQMIpzxcfNnuQ=;
	b=gZCvOCiI831Uyy3k6C70btsOR61SlaHyJwQTeL1MQXhaNf4Wkl1vWtOW+jvE5FijxDWQ
	 hfNssJKeVXWTqYcrPx/K4AtLWAN6gSJMzlqcr+s1coBoRaCdk5cAbcrxIXiAYsL+u/eGd
	 w49cN5FTksw9KN5lM5ElWhFdCM/FLpeaInrkv/7NPTe0A5JDPOTdB0QhRIgdQnTnUmPw3
	 k5p8QxzUNowLKZVyRQgEtBEwvooI3NAnUCX7zQlG3NWq8JWjtC9djC+srwGVdV435f05U
	 xfQz7KrH8fez+AYfuCfI+uRGry0cqAD+wQqy8bWhfneHWxjtN/0lBEQPvYS9JCZtAhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gh93Fhjj;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OA2fMXt4;
	arc=fail smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA60606A321;
	Thu, 12 Nov 2026 15:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA60606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gh93Fhjj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=OA2fMXt4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794498264; x=1826034264;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=8cLvVOjqvi5gQeXbTZkFw2B7JRh06DPjOacwpEzYz34=;
  b=gh93FhjjCpXLSeaqEngJDuB0y8wQgQ5xVvcHJ1Mm46HT9dHbOerQK1jr
   tTp3BYH4Bjk2kc1uFUYzfizeS+RG8VqSkxlRxNQmAV2rppt79VRugk+pw
   lfStLf1N/RmT1MNxCSrDn5hXXDbPz33hknLiVoZ6yXB+1/EP2/FePpsbR
   B2W6hLEVUZMzW+pZRQ62srtWMpj9u+8bRG4vdxWtakrv5ooNIUzqb8EHU
   5dM+Fdb0owsZ7IhHIn7pNOHx2B7dLJgRrGmCrj5dQEy9nPrY4/zTGvXSb
   Q8Q5vZ6clu+6xl9w1Eje3SJHbbu1+s2v9yqFfLHsDy5ar4hUghRvZzyAV
   Q==;
X-CSE-ConnectionGUID: oVlo5gC/RxOporVkL+Q05w==
X-CSE-MsgGUID: KRW2Wn/fRH+UhSy1c1mO8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3186693"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3186693"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:44:08 -0800
X-CSE-ConnectionGUID: QZsXoWFIRUSge9h3gewDYA==
X-CSE-MsgGUID: 4w6qX1HDRYOlZvS/7TBqkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8512821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:44:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 07:44:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 07:44:07 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 07:44:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxc+zMjaj7rHYMRxOc5b4oaqVxFD+Wd8Oa+Tt2cRvFNXsFRRywVy5kjw+lHt4QSSxTKSanTRYV3w54F8OGpzYFpcGHGUM8xqvVLLNun53baYg711Evu2iu4qq49yA3gPvJK1gNhJTBp2phOJPVFXsI9yKZWqbn0yu8u+nfC3sPKGTFf3G5MHPy4gnNV2By84kueTfxY9PYSgopD/UKJvTraardIEawBqC2q9/pbAn1s/1KLjt4Vhjua62xbTCzeyCdvdAE0Wvz1nJEAUB1rlmdLWkCS1tRoO3NoXpUxFL3x1MRUsBjR8D1VGnejG2ubvR28gkbd6k2jQyH2UyJrRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmH1wKO2MgfO/vMNePvLTvZcq1VG3UGElq/p/3MDXMQ=;
 b=HEsuFrL6bS3WGHlUZ6/g6kAeMtCVkqpDjhj/2qTGJ2KJEvY40IsiJRdw0W62NDlyVkkD9YIUVO4XnUjRqrgneUyhRFlHBE2xVN+GTKmtWA/eFCe+VWu4imhowP8N7jhQ7QK5HDKjI3VGhKo9L1yiiUlo0yiUh8ebO0KSIovG56H8o/6lPaG2PT0fDx+n4QXMwAuH4lJGiuo0dbuJTCs69SxEHaqOSJDCnMTyIKPpfng81lx5Tj+9gCV0K+dI80Ok3s/w+/CVrOP6OXHdSQTlWq2Q9akbEstWCHB2mKCv5/9iQ3N2NrV8acOoI6DE+em96qlZdKvY+FU02nDly7a4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmH1wKO2MgfO/vMNePvLTvZcq1VG3UGElq/p/3MDXMQ=;
 b=OA2fMXt4/wFZviQSugKw7V2SJanGVhTWDmloa1xba6r0fp6rK5lI0gleeqbDe+u3NyfKxihJEL9R8FegfWXy8/MPXMJfKBpSalwuxbd2EI8CoTGUMiBek+vyZtgU64zyE/paNbGecQsRrEVKdqo5uuboiS5BHAlQZZtg6uPouAU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LV0PR11MB793350.namprd11.prod.outlook.com
 (2603:10b6:408:602::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:44:03 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 15:44:03 +0000
Date: Thu, 12 Nov 2026 16:43:47 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kernel-team@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Pavel Begunkov
	<asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii Nakryiko
	<andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<io-uring@vger.kernel.org>, Mina Almasry <almasrymina@google.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
	<bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Wei
	<dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stuart Clark
	<stuclar@meta.com>
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
Message-ID: <avXeswRldufJ8Nor@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
 <avWo1bY5MSN1XvHL@boxer>
 <874idmrtq8.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874idmrtq8.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VIVP296CA0049.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:353::17) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LV0PR11MB793350:EE_
X-MS-Office365-Filtering-Correlation-Id: d5fdeb04-3d23-47c5-b412-08df40d3c6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|261009223027099003|11063799006|5023799004|56012099006|10067099003|4143699003|261102123227099003|261102130727099003|261022115727099003|261022113327099003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021135927099003|261021130227099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 5XSExVxopCE/7unK8ft38TFbBxLr2m+JEY2VHFnrmuHlS3YxKsgN7h4gb+sDTwdsZpl7+jRrlAUFc869X4qL+0i7a5mOOBiEjVEXMFIg1aO8NSVFrQr8c1WOEZ50KBUnQu30Id06hBRMFh+iQgoMQxHhgAPwEp2//qsX8+t4fbZuetnRnvv54WxSAXrTRMCYzh2mh4T2WnQjHPrD1PnZEijgvlS3vpB79+FRVJuzpcsHHLqQJ+6o57FuL0NYIsRCwmzjgls3E+O/YrFfBB7A3tQqvAFf98XYHpqrQilrp4gCN6ER8kpdOj5q4NR4UjH5qqsVUjXzqN4Evz0T24U7YajK0f4zm+cnFwpZ9YOgE74kfB6Mx1oWDbASWPZ2vxt+0enFnx9fhCFbji1IaEve4aweQYw4Qc7CtFFS9/dhmt5Mvwbafxo5/ZE7pBrDTM/b4gU12l0Xg3Q5g7Qp2RCQTOJvLkQU4wWIW3DM/dDMDYz6BF84YFXHzbY2WzFpUeJmKR3f+z3Czr/oi+x92IJ3UUAOpPf/WuFR1qgFhdZ8DVKae5wmZ3WNrh3r7H7kdYTIAsQOxNVh2RISIs9W4S9DTjD2g7Li5UmZDE9qJAk/L45M9kJUTs6XZ3mhdWaCpzPi1dGka0IQfuj5upFKDteTjgFoj3Lvu7WwzpypugwJXAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(5023799004)(56012099006)(10067099003)(4143699003)(261102123227099003)(261102130727099003)(261022115727099003)(261022113327099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021130227099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2829pav7tNybgd8rjsA/j4XXSb/43eVa3Z0wt3wCR+ZYzCOOc9Dicwl/3V?=
 =?iso-8859-1?Q?5tAlMnRVc6z7ZjrKeqN1apzaOkWOZio21o9gCjc6Oz0yg0LtV2BY4Qw8T2?=
 =?iso-8859-1?Q?I6X5zFtlnh6fD9EsckaFZbE32gpNmbejGSfNd2poPgbog627ov1zYAzTvl?=
 =?iso-8859-1?Q?tXpZaQ5qrsuQfj865HUHiYf65onP3lDkwVfqj2eRgyS+DB42Y8KqUt/WFf?=
 =?iso-8859-1?Q?JO853HNt8peXdMlH+HAmrEgwns+vMBEIhCgYGRC9XZe0zdUVqtxuX+itCM?=
 =?iso-8859-1?Q?GOwk11ZGkmkKz2OJ79VGtkQqJjdB3+Q9PcN7S8eb5KfO5loWAjHXE/xU7K?=
 =?iso-8859-1?Q?siiPkwiIhyC0NEc6LsC3hmwGdD7dFrTmEfBAV1dZnvH6lKF6U3MSYrGEip?=
 =?iso-8859-1?Q?c/pnXuUDaRmmJNSjJtDe1mfsGA6ZhsIPglghAjzsQxrnuKppawsGule7Sr?=
 =?iso-8859-1?Q?xrdkDcTprrmY1UTddlKNSzVX/DgVarIrJNAVbtU5zv6dqTLlebNo5KG5Ii?=
 =?iso-8859-1?Q?Q3M9yS8A27mvwfjlpUNspsgM/N1ghh4/Oso0HdCtbfhy/8Rwm952bxRtxp?=
 =?iso-8859-1?Q?dz8AfG2+o+fA2fK/7CzPWo2lGtM1Cgc9vG6CHRjmB1qZSwNRuykARF4LE3?=
 =?iso-8859-1?Q?e6apVcDv3gQTCRamQehb4cKOKeIGXyfx9qZ70OzXdoqBfhClonAz2Zb9rS?=
 =?iso-8859-1?Q?ZEXySTGH3iHICQ3TmHsyqDXjxy1KAvIHf1wdY6iMk67ve1iIL49/c6yN18?=
 =?iso-8859-1?Q?/fUFReau5MwmcZi1ymgAILhpS3MsVpBI1i1wsEMd7+eDKISj4yVIcUkq0I?=
 =?iso-8859-1?Q?ig3pQ3UxoteVx07YA50W2KHFyrn72dyJ75GYn5CuoVh8K7/qXdbz0reHuC?=
 =?iso-8859-1?Q?hfmwpyZIZ/+FWWhjxnRPB8Ejd29jaaE3x+FcC5hijWcRNKTrjfoQ9nQ5ma?=
 =?iso-8859-1?Q?dOCNFYpkT6jzHEFWbmBD5OCEUaB7HNTiTtH33oaoKc3a1ybppvLKGA3Oe2?=
 =?iso-8859-1?Q?ZNyIeVelOM2j66NgBVKhkGIxTHJUN+eFJPvEMYnomF2o9yHtOiz1sHHU5m?=
 =?iso-8859-1?Q?hIrmNdK/nSu13OXMTmhi18gPo5Zinx4AoGEYVklmuZjHz4W/Zl0e3ZaWpf?=
 =?iso-8859-1?Q?t78Me1Gnl1q8BbLLwBe+gHjPkkGzOYWthsAMpfk1nikb9yBi3nwbgJp+1M?=
 =?iso-8859-1?Q?i3hzevp29TgEZYhXHbKsoQCggRVPJc4HRxZHBQva2PVo1X4QV1GTKFqja9?=
 =?iso-8859-1?Q?tXraCsoTzRm2SUt+IeecG50kgblgeOEk7RKN72OHSf3oZJJfuy1Y85SOKZ?=
 =?iso-8859-1?Q?bj1+tDEfVfX2O4q+v3hjToF/6bpattCFWJ1l0sOfIvmXBdRz2s/L7Mj90b?=
 =?iso-8859-1?Q?If9s4Agwtl+vimRGoHLgIfFgsKdipkrSbblmkoK/dGGui6SSjQ7FfdymH1?=
 =?iso-8859-1?Q?q3Vg84zd/aQYD+/XcoBx0kBpiyEe8X3j9fi0Tu6h9exr2U6qe5x8mXEZ+e?=
 =?iso-8859-1?Q?91iuCqRov/SX4VBYmx1x02L2Vpj2sH97Gc+Ii6D8EoQgrKDmZ3+ltn05im?=
 =?iso-8859-1?Q?Ljrh7zHpy9KeT2RHcDthh1Dz588BR9mMajuuvqqQwGpmdAN+XV4ZDNxlwU?=
 =?iso-8859-1?Q?g6jziYlEaTxjjBukt0zg0zoqnOx7YuEW7jFuYqgaIeat8X/zJP/0Ajl2We?=
 =?iso-8859-1?Q?xSDVTcwjpyCNrVFnGDnNOMPtkuI6DmstUnT6bhZ1yYP0DscwQxLtLg8eDo?=
 =?iso-8859-1?Q?yt3xspv0qU9WhJetYOTvvjd6tB6RvNzCbXZKi4B4g5Ryj/3KdEwuwSp8+m?=
 =?iso-8859-1?Q?iZxEtLZsIisevsAHEE9DGK7iN378VAs=3D?=
X-Exchange-RoutingPolicyChecked: KjUmuynRbodtboQfazsWD4oh+CMj92PU7nQGpC6auIxW2wfPaM+yr5Vsbdt5BcDKHcQkAG4tb9sf1Stq6voZ2+A5S3hCyq82WvgDIkU/5g2y4AoGUhQA/bzsaQV/mUK5gOC7jdeS+/tmLoiDSnI204GPKkNDGkrRtK9LY3zNUHmCKUKH4+yt74kQDrwcpKLAi2VaXbXrJBR5iZcVedpcn/M+2y6Zv0DoKNohpQraCiJkL0XrCJnO4arIjbbjlPIRdhkmhk923Yj5pWZwNekpRSj037Mgi6trCPNOzhkym/MFv+n298lomn/on1pLJVMjUhONVZry29Kc2258WR6huw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5fdeb04-3d23-47c5-b412-08df40d3c6ff
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:44:03.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: husHow4DwoRwNJsfT1lzfYtimX0LFUn+skbCQP/kkGPbxgrWfNps9kaYb/XMVN0Ov3YxN93r0fZvwu/w4uyTi6biED9lDqSO+UIuvu+Rst4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB793350
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 03:48:31PM +0100, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > On Tue, Nov 10, 2026 at 11:20:26AM +0100, Björn Töpel wrote:
> >> A page_pool driver should not need its own AF_XDP setup. When it sets
> >> netdev_queue_mgmt_ops.xsk_page_pool, a zero-copy bind installs the
> >> UMEM provider through the queue API, as devmem and io_uring do. The
> >> driver only judges the chunk size, headroom and multi-buffer mode
> >> against its MTU and XDP program, in XDP_VALIDATE_XSK_POOL; MTU and
> >> program changes of a bound device get the same check. The UMEM
> >> headroom belongs to the socket, so the queue gets it as rx_headroom,
> >> next to rx_page_size.
> >> 
> >> After a queue restart, the core checks that the new page pools took
> >> the provider. A readable provider must back the header pool, where an
> >> unsplit packet lands, so pools declare the buffers they supply in
> >> rx_roles. The old queue's pools carry the same provider during the
> >> check, so a per-queue generation, mp_gen, tells the new ones apart.
> >> 
> >> Generic XDP runs outside the queue NAPI, so it cannot feed the socket.
> >> 
> >> The provider needs no xdp_buff_xsk per chunk. The buffer pool
> >> allocates them only for copy mode and driver zero copy, which saves
> >> 128 bytes per chunk.
> >> 
> >> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> >> ---
> >>  include/linux/netdevice.h     |   8 ++
> >>  include/net/netdev_queues.h   |  12 ++
> >>  include/net/netdev_rx_queue.h |   2 +
> >>  include/net/page_pool/types.h |  12 ++
> >>  include/net/xdp_sock.h        |   4 +
> >>  include/net/xdp_sock_drv.h    |  45 +++++++
> >>  include/net/xsk_buff_pool.h   |   3 +
> >>  net/core/dev.c                |  16 +++
> >>  net/core/netdev_config.c      |   2 +
> >>  net/core/netdev_rx_queue.c    |   9 +-
> >>  net/core/page_pool.c          |   6 +-
> >>  net/core/page_pool_user.c     |  25 ++--
> >>  net/xdp/xsk.h                 |   7 +-
> >>  net/xdp/xsk_buff_pool.c       |  69 ++++++++---
> >>  net/xdp/xsk_pp.c              | 221 ++++++++++++++++++++++++++++++++++
> >>  15 files changed, 410 insertions(+), 31 deletions(-)
> >> 
> >
> > (...)
> >
> >> +
> >> +/**
> >> + * xsk_validate_dev - check AF_XDP page pool queues against a new setting
> >> + * @dev: device of the queues
> >> + * @mtu: MTU to check
> >> + * @prog: XDP program to check, or NULL for the current one
> >> + * @mode: XDP mode of @prog
> >> + * @extack: netlink extended ack
> >> + *
> >> + * Context: holds the instance lock of @dev, or RTNL for a device without it.
> >> + * Return: 0 if the driver accepts all queues of @dev that have an AF_XDP
> >> + * memory provider, or its error.
> >> + */
> >> +int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
> >> +		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
> >> +		     struct netlink_ext_ack *extack)
> >> +{
> >> +	struct netdev_rx_queue *rxq;
> >> +	struct xsk_pp *pp;
> >> +	unsigned int i;
> >> +	int err;
> >> +
> >> +	netdev_assert_locked_ops_compat(dev);
> >> +
> >> +	for (i = 0; i < dev->real_num_rx_queues; i++) {
> >> +		rxq = __netif_get_rx_queue(dev, i);
> >> +		if (rxq->mp_params.mp_ops != &xsk_pp_ops)
> >> +			continue;
> >> +
> >> +		/* Generic XDP runs outside the queue NAPI */
> >> +		if (mode == XDP_MODE_SKB) {
> >> +			NL_SET_ERR_MSG(extack,
> >> +				       "generic XDP cannot feed an AF_XDP page pool socket");
> >> +			return -EBUSY;
> >> +		}
> >> +
> >> +		pp = rxq->mp_params.mp_priv;
> >> +		err = xsk_pp_validate(dev, pp->pool, mtu, prog, extack);
> >> +		if (err)
> >> +			return err;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(xsk_validate_dev);
> >> +
> >> +/**
> >> + * xsk_rxq_pool - get the AF_XDP pool that provides memory to an RX queue
> >> + * @dev: device of the queue
> >> + * @queue_id: RX queue
> >> + *
> >> + * The pool stays valid while the queue that the caller allocates runs.
> >> + *
> >> + * Context: holds the instance lock of @dev.
> >> + * Return: the buffer pool, or NULL.
> >> + */
> >> +struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id)
> >> +{
> >> +	struct netdev_rx_queue *rxq;
> >> +	struct xsk_pp *pp;
> >> +
> >> +	netdev_assert_locked(dev);
> >> +
> >> +	if (queue_id >= dev->real_num_rx_queues)
> >> +		return NULL;
> >> +
> >> +	rxq = __netif_get_rx_queue(dev, queue_id);
> >> +	if (rxq->mp_params.mp_ops != &xsk_pp_ops)
> >> +		return NULL;
> >> +
> >> +	pp = rxq->mp_params.mp_priv;
> >> +	return pp->pool;
> >> +}
> >> +EXPORT_SYMBOL_GPL(xsk_rxq_pool);
> >> +
> >> +bool xsk_pp_supported(struct net_device *dev)
> >> +{
> >> +	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
> >> +
> >> +	return qops && qops->xsk_page_pool;
> >> +}
> >> +
> >> +/* Called with RTNL and the instance lock of @dev. On error, @pool->pp stays
> >> + * set if an old page pool still owns chunks; copy mode must not take the pool.
> >> + */
> >> +int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
> >> +		u16 queue_id)
> >> +{
> >> +	struct pp_memory_provider_params mp = { .mp_ops = &xsk_pp_ops };
> >> +	struct device *dma_dev;
> >> +	struct xsk_pp *pp;
> >> +	int err;
> >> +
> >> +	if (queue_id >= dev->real_num_rx_queues || pool->unaligned)
> >> +		return -EOPNOTSUPP;
> >> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK ||
> >> +	    (xsk_pool_uses_sg(pool) && dev->xdp_zc_max_segs == 1))
> >> +		return -EOPNOTSUPP;
> >
> > that is checked elsewhere, in xp_assign_dev() I assume.
> 
> Ah, yes! I'll do the common checks first in xp_assign_dev(), and branch
> after.
> 
> > Why there are skb mode checks?
> 
> (Note to self: I need to make some details/designs more obvious in the
> cover!)
> 
> Because the provider is turned on by the queue API at bind, not by an
> XDP program. This is a big difference. Once the socket is bound, the
> queue's page pool hands the device chunks from FILL, whatever program is
> attached: native, generic or none. A generic redirect would copy into a
> chunk taken from FILL behind the provider's back, and a provider pool
> doesn't have the heads that copy path needs. So 07 drops those
> redirects.
> 
> The checks make that visible (I hope): with a generic program attached,
> bind falls back to copy mode, where generic XDP works, and attaching one
> to a provider queue fails instead of dropping everything.

Might be a dumb question but couldn't you forbid generic xdp attach if you
detect zc socket active on netdev? Or can't you have some deferring
mechanism like other drivers do? Or is it now not possible as decision at
that other drivers is done early at napi and here you don't really have a
way to distinguish it?

Another thought here - if user binds ZC socket and follows with generic
XDP prog, then i'd say something is wrong.

You generally *need* native xdp prog for resource bringup. I don't see why
we have to worry that much about generic hook, which probably lacks real
world use cases (sorry if I offended someone actually using it) ?

> 
> Driver ZC is different: ice and i40e use the pool only while a native
> program is attached, so with a generic one the queue runs on normal
> buffers, and the copy is the only FILL user.
> 
> > You sort of introduce totally separate control path and rx data path. It
> > is hard for me to buy onto the management burden of all this new code :(
> >
> > I believe we should break this up onto smaller chunks and don't try to
> > solve everything within a single set...or wil that not be possible?
> 
> Separate from driver ZC, yes, but not new: the provider binds the way
> devmem and io_uring zcrx do, netif_mp_open_rxq() and a queue restart,
> and the driver keeps its normal page pool RX path, with no ZC RX loop of
> its own. The cost moves into the AF_XDP core, and xsk_pp.c is real code,
> I know.
> 
> It can be split:
> 
> 1. preparation, no new behaviour: netmem frag addresses, the page pool
>    caps, fbnic's redirect and netmem patches, the TX metadata fix;
> 2. the provider for single-buffer packets, with fbnic, without the copy
>    fallback or fbnic's shared header/payload pool;
> 3. multi-buffer.
> 
> Not sure it would help much TBH.

1 as prep would be good, but I believe we were saying new ZC drivers are
supposed to include mbuf support from day 0. Otherwise it might be hard to
enforce this later.

> 
> The provider, its bind and the delivery need a driver to land, so 2 is
> the smallest set that does something. v2 also loses some things (but I'd
> like to keep the validate ndo_bpf), e.g. nr_pools and the duplicate
> checks. And I'm happy to look after xsk_pp.c. Would that work for you?
> 
> >> +	if (dev_xdp_prog_id(dev, XDP_MODE_SKB))
> >> +		return -EOPNOTSUPP;
> >> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
> >> +		return -EBUSY;
> >> +
> >> +	err = xsk_pp_validate(dev, pool, dev->mtu, NULL, NULL);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	dma_dev = netdev_queue_get_dma_dev(dev, queue_id, NETDEV_QUEUE_TYPE_RX);
> >> +	if (!dma_dev)
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	err = xp_dma_map(pool, dma_dev, XSK_PP_DMA_ATTR, pool->umem->pgs,
> >> +			 pool->umem->npgs);
> >> +	if (err)
> >> +		return err;
> >
> > Couldn't we have this part common across drivers wanting to do ZC?
> 
> It is: this is core code, and no provider driver maps UMEM itself;
> netdev_queue_get_dma_dev() gives the core the device, as for io_uring
> zcrx. Driver ZC could map in xp_assign_dev() too, but drivers differ in
> DMA device and attributes, so that's its own series.

I meant existing drivers do this on their side, idea was to make it common
before your set so that you could reuse existing code.

I am wondering what is the end goal here. If we would have enough of work
force (or tokens) and time and willpower, I assume we would have every
current xsk ZC driver converted to page_pool and finally orphan the
MEM_TYPE_XSK_BUFF_POOL.

That might not happen, so I feel like I sound like a sentinel, but current
code can't just be abandonded. Hence all these asks for code reuse, etc.

> 
> 
> Björn
> 
