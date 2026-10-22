Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792683873;
	b=XkzB8QRqKQqQVd2TS8rgA4Ue4tmFap+sEJdEqT59bQPeW4dP6gb7MHwPMUhmiesoFg1l
	 dtjauVW9FukQVWB2xg1lebobTxLG9ofyxAhVcmRtFMbfBHs2B8770i5XDvDmCgaMPny4w
	 Hh1q3hflGZ5CDKTLDU2pWbp+Gp8wVbcbdc4XWX1OtNsgi6B7iZ9CkqXV69tY/91939YEU
	 baBSjVO/S/L1Kjdx8Ov1qgELDbuoVg+ZSNS1ftLqyq3WzyRfw7EDa8EyhcjQ/bFee66tP
	 zCnV9MMyZfht3U5IjCvqG08PMCkXvByUoKVwWJ4ZTWT0IIS4O+J+BeVngyOP0S97tLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683873;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=UyyL12SZ8hudrx5tGpWwn7IT7JPVa5c4uAGSvYpzxtQ=;
	b=a+x+KL7ovTUpAhM+1bNCiADSYl+VlzoXDkqAlW/dedlsxKa1+frIEqgjRfv/16ciADbv
	 m6To3fZrIL5iXwv950KwUmNjj12u0t3b71SDnl7oU8tVQIdBFjuM4+Kk8Uktwf/Ds5n0t
	 FKOg50t4oPP5nsQyWecsCK44ktbyMMXMCbDGXOvl2X1Shhkrhpqbbqh+uzcjwrDxAQEMB
	 auxlyUH6FLDYAzU6EdIL9vwdbt2lIPB638OUQpa2aYktb4KaOpbJcqK3UgCQSvGHf0H+3
	 Bv8cQMTI0ne+oT+PJZC+ElRswN1vTsbL+7rZSgu5X3B8kN/6ZA9rH48QWy5fgLOk9DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TmmYSPAS;
	arc=fail smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D06606A31B;
	Thu, 22 Oct 2026 15:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D06606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TmmYSPAS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792683872; x=1824219872;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Bodg7u+YTmCXWa4lG+lYwqsHdmNChtgFJoxj/9GhLNM=;
  b=TmmYSPASWYUMfsfAy2nd3IgY5rKn38J9UZEjPT9+0UTwU2eyK1JBbOTI
   X4h+ac+eBKZZ/gvwjhcE5QSDBqTwKWxOyIYnhIrsw6n12mByoAAkQP1mM
   Um3aiLXpV04cJPAnpCCUbBZoFOpivgsz549NCNGCm430osGnK3AcPnTCl
   5VjB52lAVPSPkw/SI6qhzAOV5LkkUJJNyo3pPcVP6eWWIPyva/nm3cZzL
   yQCn5GE12z3yj653S/XFHKz0olfD+oMG3GwdLv+DvB54YEivoDieO6vpi
   HLXvsW7BaLhkvR74U6TNusvu8oYysCIz4U7YHXNDIhYqhZxjMVx46ATNn
   A==;
X-CSE-ConnectionGUID: qp1oUHgfRMGy4a8G4bTaMQ==
X-CSE-MsgGUID: WX4r/XoRRqKNF/Q3vR3d3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1337914"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1337914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:44:32 -0700
X-CSE-ConnectionGUID: qV9ITFSiQZqxWPEN6N5L5Q==
X-CSE-MsgGUID: 1td8/8NyTu2Eo4xonlXgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3333430"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:44:31 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:44:31 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 22 Oct 2026 08:44:31 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 22 Oct 2026 08:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdsV5ezDokII6jJREsVk8g8+mUIanpt5cKxST8rA/90U8RbZlCqon2/TaiALH304Y3qTKsnZHCvZ1+4pYjpGPGrbBU53KiZrFsTvz1z1tm3n+RWV//r7tgg+xVfC8JaDzbf/8S7t/oWRAw/O+OEJoxLuq6YrRckXJA7YMTYPooDrysr2aJN9FyUYtOi+8aqTYj5udisiW0n9ksBeHt5sTHvFdG6C1y5SXjHKIts7oe9sNcj7L5IzgcuDHpC/YUzQ9vC56GWtm+9p6915BAxl4kELUR/tncOm2n4yFMUjf+d3Qxkd46UOa5WEE1zrn2rol1E+SXF+sm8bXTOkkPPadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyyL12SZ8hudrx5tGpWwn7IT7JPVa5c4uAGSvYpzxtQ=;
 b=iSUyFMPYxGVw1ZA/8er/bZlRTPRtjfqLrlzurYeABslKtjkXtb2m5U/wkkMaaMXlwlDBKNkR3s3MgsSfte8MoGej79w0ep/UTliT1tfUhEpVZAKnJzH6ioKtUWbmB59aPs3lioNoY0l66FTXitxTsDG9VxxawRrfxpRe3me46aa1hoJ51yZ3xmhkw0JnS0IIyOaU5pctNATcRoCMZ1Y7uNAlcGPbg1HR/c8BC8FkXLxxuUVQIvtQe1iT1DP81NVDo0tK1e2PqzUkwjOnCyfeQui1zhAyGth5VRx1acAtHm7TPysvYbhw82+s+l27fRupj+KB/Tu/z7x9uP5NQCIdhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6503.namprd11.prod.outlook.com (2603:10b6:8:8c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Thu, 22 Oct 2026 15:44:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 15:44:25 +0000
Date: Thu, 22 Oct 2026 17:44:14 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v4 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
Message-ID: <atovTlRGERDYjB4q@boxer>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
 <20261016174338.787135-10-maciej.fijalkowski@intel.com>
 <20261021150145.65a22a61@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261021150145.65a22a61@kernel.org>
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b81382b-41f9-421e-355f-08df305359b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|261021121427099003|261009223027099003|10067099003|56012099006|3023799007|6133799003|261021135927099003|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: kjU5Ko80YmfYsik3FSsMQIpWoYUXZdpOqQOoBzGz6RstSqDvcFOOpinJ08Ag9wcvuFvU2JIjNr3zcVXF91+t66KeGA3xAw765nu5hLlzDuNnkUmG7SkFQcP++oEcP8apiKE3IZ6lWRYrC1kDJiE8AlzErfR2XSp02uDq1okkAwpPz519Rx0Ko8gfH2gkhZLK+azgkoMNwYTShV/G+PxF/hzQBi1iInJM5HBGOo8RfQVgwXfogAEkwM8u71gIF7B1WwWIIyI3B1+m9OtEIfottgQKn3nXDAjLWe8CwaOd84Iw9YFKqfNWw0/yPPLn5omTjTiMG2YbbnclWkepc13uf86OAXSsTnzX5K0g4khcdhQZqeoaKnHSqo5qQbd+5J0y+qFxzoHBl1FcceVueBISc5DY3kpvhE1Cl7LvKeoUatjxPcAZWKy0434OAY1HrXPQyIMgnrdjpXaPX9jM0uh6IIcvrhHlBScrpH/LwdKHwDm8E8yFdxJti7zh9buD0cfQMH40IDkWrj90Q6Q7dauqKStVgw6f6q3YOOWEB3Xo4+N6k9mLZ2KcGOYbmLlkO9FCTzNkghZgg5a0dN0krG4lUn/xVtmqGO81ynNtQnU6A0HbneFpoSl3tL/0xQ7ClBsoqqGyilIaNMRf3FYzn7ZNqvAMFIQO8fTOQVOdv09Pmx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261021121427099003)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(261021135927099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+ihGMJrFHFSbZ9OMMK7BLCRRCSoECFSb2utYYV+4P+2qQf+0A+sSn2I0hKQ?=
 =?us-ascii?Q?VdkGMKtXvApukIaRu0+0YKxDzRjq2/aOfdpJtQBBLzpchMKWlpH7ivI62nqL?=
 =?us-ascii?Q?gFF343o4HLFRZmTmpU/14Y9u2D0CjVJSz6kJhwDDTdjJmBeU6yax8uH8yiF1?=
 =?us-ascii?Q?FEjee4VFe3McYI4ntaYEwB3FLEI66Uk8MMJScqo1KTV70P3ZVYNdt7t+deGY?=
 =?us-ascii?Q?4O0yuaX1Zv/6RRXhi9Up2rTNIynwoMowEchBAZgyMCnZ3a5zMyHFEO9d94qh?=
 =?us-ascii?Q?ldOtrTOk13sysFOPOF4lLqGibKDTle88GHoRv4okLF3lc8lDF8kpfckA0fLO?=
 =?us-ascii?Q?bOUhT0+D+2LMesH3GeYwdKFBqco4P/zLQeRSybTJKrKP8kshDOn4d5lMOGUN?=
 =?us-ascii?Q?c2e1eRkuK17/QjKjXWImxIVMjoahIFKt6nMRbvvTiUpTpHyVH7Ul9CnETiFi?=
 =?us-ascii?Q?UYXe0TNHdFWepHfL+a96cefYvfixPUEvKOHj0/MkMVa+qV75Hk6nxSGip0Cf?=
 =?us-ascii?Q?lGq7P+Ixsg2PVmdljev8U3RXuE86XdP8Yaktv2rki1j09Rrp/YcYzAeZDHs5?=
 =?us-ascii?Q?4tHYYxG7tpo9yiBxGrMLFaWmRNEcEbEjk0PCxwf5JlP+kCchVHDjyq9W3VFT?=
 =?us-ascii?Q?k2yka+0J/drYs+8DXJz6S3KuNXhiYKswL9s416Xt8Vddr0t4WqtVYAJzwQMH?=
 =?us-ascii?Q?2O7Pg5AfDpxMUhmlYt76G9dsh7lIf7UynMYc589sGDf0kYql9ninao1RTAK6?=
 =?us-ascii?Q?fXB/hKTbCM/DGWA/sMJCvAjGLLhJqPgYNk9z8FhVaIPigNoIoeZ1nNd5wwqk?=
 =?us-ascii?Q?Krfbd27OD8fZdL/5+YNSWLngvdZDxM3qh9GJreCWMB85TLlT8itu36hLQvxT?=
 =?us-ascii?Q?/U/skqIkI8SDGGi0nBYjJADTCJBmbSL901J4/QLmb1q9/tImLf0X0nZrom03?=
 =?us-ascii?Q?GxS8MgFVYn+Xg5ATpSCHCIudMVTUaykPWe6EoVwV67ISrabohg2GZQd2q+wd?=
 =?us-ascii?Q?wSHEsejUYSNz6XACi+1mqX02BSBrcCgnmlyA1G6Q8d9JmVXY7ok3Cc8SS/SH?=
 =?us-ascii?Q?2mVld4scY2+7DrfurYGS8d9boYbS6ATNlkUHIxRQWf/YI41o4UPAgV3bP/7t?=
 =?us-ascii?Q?KwL5u+H8E4xbWprQrll/tll5G0Rd3dA3ORy0+qmGu1nkN7Cx7YVWGk0ZnB52?=
 =?us-ascii?Q?D8AtEayPN0ang3OUz5Sj49y5sGM8RpqRhuwV0OXFCVSRepoM/oX1m5/ZWNjt?=
 =?us-ascii?Q?G57axFZBA4IfXroScbl/1gykd/8Ah/ULjBTctKvu1QWof2+8vANq8rlKIzor?=
 =?us-ascii?Q?v9gfNXxl7vSdoHQdyLBdXtr0oRujjtVD55FbAnSqUAd0Cb49wck9warD7Qlz?=
 =?us-ascii?Q?drvEe9K1JTVU1qfFel3qLomvVh4BhD0L07HQtkfax9bP50KrUDZQ3ja3QOJf?=
 =?us-ascii?Q?jadixR+QZSfnZ7Do6chjOL0+6eywSgpUnveTN/FobNMsDlCbVwgHjD0InPhq?=
 =?us-ascii?Q?ILKkK/jyc01Sc0GHNQ8TtnqZApciBSrq7TlZgnYgH6clg71a8jvmYzEl8J/D?=
 =?us-ascii?Q?vNJKe5onFiVDxmsbAXSrXv20hdx3DnBWrCU99461g7bv9EHCxHlD6lMDURNz?=
 =?us-ascii?Q?0Q2fTxPExvsVycYGgF4/duehwJCRmy8msQTNUh6nvJ+fD57b0THp65rYzSBs?=
 =?us-ascii?Q?4qcZVstuSJRXndeeNpg0LOCjIasGuMGm28Ysi8qsQTJ/nLOJyYTqB+Xjt6F3?=
 =?us-ascii?Q?6/2GpZT/5BoL6i7BCf0mRWnALUOc/FM=3D?=
X-Exchange-RoutingPolicyChecked: WtJNTj7uU/Y2cOwDDul75GSpl+r1F47+n4dHNVOQdKWEG7OS79cplYTBimgRdBKiHlxWlLP6pG9xqyaJTcElqPNBuBACKWK8k0gwSNHJG/caxdCx0BqUXnIvnEYuE97evpsPfGhkzHvKNolPtq8c+zn9L2GXURYQiCgPke+kGoggTfAtxYcbp9zfQPodyfmHElpH28unikeVYS3IZcHRBuSSPNnduMDrGaaUGrkdwGX/Vzfk4Jrb68jQ6zarkH3kbEjzC0LAEuoH3JcCHFGb6kZYmnVZilynQIMkEyl5BqE0QdjRXt1A1zF/kZiXGoM47xpzGXB30UvrdJZSZJAuvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b81382b-41f9-421e-355f-08df305359b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 15:44:25.6605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbTDAqrApVPJCCpcSCvZQ3AxFURoGtz72Z5Q6osX8Gs1lCIHnZ1cq6yGKJlSChB2qQOS5wcFtamugMIPNtKmk6ZN1OD8RNOEfLGv3XMv3Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6503
X-OriginatorOrg: intel.com

On Wed, Oct 21, 2026 at 03:01:45PM -0700, Jakub Kicinski wrote:
> On Fri, 16 Oct 2026 19:43:32 +0200 Maciej Fijalkowski wrote:
> > Replace test_xsk.sh and xsk_prereqs.sh with test_xsk.py, which runs
> > xskxceiver once per mode and case, so that every case starts from a
> > fresh process and a crash fails only its own case. A single case is
> > also the unit that the next patch splits into RX and TX processes.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1fc9eaedd744..6985a42bc09c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -29784,6 +29784,7 @@ F:	include/uapi/linux/if_xdp.h
> >  F:	include/uapi/linux/xdp_diag.h
> >  F:	net/xdp/
> >  F:	tools/testing/selftests/net/*xsk*
> > +F:	tools/testing/selftests/net/lib/py/xsk.py
> >  F:	tools/testing/selftests/net/lib/xsk/
> 
> pylint has some complaints, about main(), I think?
> Could you make it clean?
> 
> > +++ b/tools/testing/selftests/net/lib/py/xsk.py
> 
> Really not loving the amount of "library" code added here.
> Do you need this just to run it over veth in net/ and over
> real HW in drivers/net/ ? Are the test cases very different?

Now that you bring this up, would be good to clarify expectations of this
work. The lib input is what veth and hw runners share to avoid code
repetition. The separation comes from a fact that we still want to cover
SKB and DRV modes (via veth at net/test_xsk.py) and ZC mode is covered by
drivers/net/hw/xsk.py.

My assumption was that would not hurt much to carry common code within lib
file. I might have been wrong tho.

> 
> I wonder if we could solve this by parameterizing the env
> class to use veth instead of netdevsim and then have unified tests?

Tell me more regarding the unified tests. Is that okay'ish to run
veth-based tests from drivers/net/hw ? I thought it was not and I shared
my insights on similar work which does the same kind of migration
(xdp_features bpf->drivers/net/hw) and it seemed to be heavily veth
dedicated - the bpf sh runner was basically veth based, but so does the
xskxceiver and I moved away from this after Bjorn's input (turned out to
be a good thing).

each runner can have single ksft_run() call, right? So, do you think
separate files for veth and hw runners is still okay?

In veth runner I don't even instantiate NetDrvEpEnv as I have veth pair
being created 'manually', however having a param similar to existing
netdevsim one would be nice and xdp-features set could benefit from that
as well. 

> 
> 
> > +def xsk_wait_endpoint_exit(endpoint, label, timeout):
> 
> odd, the existing cmd() / bkg() stuff doesn't work for you?
> It works for many other tests...

This has been mostly about grabbing output from failed cases, let me dig
and see if bkg() is indeed enough or if we could adjust it. Good point!

> -- 
> pw-bot: cr
