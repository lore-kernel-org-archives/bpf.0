Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6131476CD3;
	Thu,  8 Oct 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450200; cv=fail; b=QpYfcPhJwhSnG6q0w23YBKJctNtXwqAc6ByyzpZAdDxAIu/2jcM2b2jAx7HibzZdBexxu8ey+3+QnnRwL1KP7IEgzFVyXZtMk+lgWHNQBtm/SrMERtAjNpbsaTbt6yvDBw1OSfcwCp6eLkbGI5rNlYdPI5NPRdaeuSiBAgfoEAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450200; c=relaxed/simple;
	bh=v39xvYQm4bvsHVkEbavg1xum5/pPfCtt0K1MD5KDsYQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R47nKrD9VWTe3NaOMEoc2OABnmeNNf7bX+R6BnbOwKNQz/MsUWa6N2s2m0lkA7/KZbtJ8eSHDhsRzhfgQnajyqrGJWgR5LfLin2I+hsnuuALDJrhUGUIu9HD+Rmi2D0Gft0FKLjRLOhCJaEwnmgYPwF2oENjJxRDIbT9D7lSqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFyhEAzD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFyhEAzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791450197; x=1822986197;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v39xvYQm4bvsHVkEbavg1xum5/pPfCtt0K1MD5KDsYQ=;
  b=dFyhEAzDhPYqDenE2bGX5aYT2VPV7Nh0diqFaO2D1jotX7uWq+2DC3OX
   fcduBdUl9OEJNXSrwgXeKcJpoFDULyk5bwWaQ7AhIlt+/haUeMeX4zFUM
   2Jin0OLMvg5eR5NLo5QlUfxvvOLsxBTWUd9V8TFTa0kX3f1iktNp7lvtL
   ZVX+dGudCBdDnh0z1+dg5NR/r6stimbCRwxmxom8Mxj1+XhN0j21zt95D
   LBUVtGmS8fUoHGkBcieyrsCTQXxYjJCKE2O81RB1XrlAu+32sITBtrBHy
   xDjx8/i4knc7yhR00zhujSAVBMxAWmm9OAMc1bNZG4FAowwFCnhdo1A1c
   w==;
X-CSE-ConnectionGUID: mtusrtUSQmu+eMHFlyFnow==
X-CSE-MsgGUID: ShlVxKH4Q8GZMrogD+k2uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="121075"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="121075"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:03:07 -0700
X-CSE-ConnectionGUID: X4MbiKJqSZWXaqmao7M87g==
X-CSE-MsgGUID: OIgWMkRNT7O5Ypi4rY8Rmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="93152"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:03:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:03:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 02:03:06 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.43) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 02:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQDAQ84eFCWIdKd4L3VYJa9/VjWvgwcPWXtg1IF87R1GpNwHGxhWGi/kPqDtnUPFZDLx7OpRr91yl9pKiOs76s9W8YB4i661M9q6fT9Wx9KuiSd4DhR+9zUspoBRo67jKdQHjTZTCWUW08GjBfR1H9WFfYVPseAxFmQ/Gr0qATYrOk+FUIMElNZ4q9VARxuMYUcUGniT74B/Vuk1wDHrU+EU0yjvee+oQBoZdPQ/sRZznubbAgsRXgBaiqKCmmGNNaVb+GKu/JF5gOjy5yJ56c8S/mkp22UZsOhGakK7PEBxWbCRPu0HJHeOes5hDgHks+HqAKFJ5BQOCHlzh89B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGYppvX2R7prN6JJsRSE3FPt5uGUpH/I4VucFprXQcg=;
 b=GU16PT4WT/4854cq67bZBrBTrAjpexoCkh663URpKC5l6R/SmK523nZrufMlYq1YmJubMqRfiKwtw4CFCKoNZz8MLmGVJxj3ECwzXpBQby8iNdKht670BaK47Lj5iSTmwzMQBhRhHeoSk8z2SmXh19Zq1vl1a9dDew+HIgCKdidKM/zgScQpmhMlOL97Wpn8/uDDCmMpJfV9t6CVbHksMHbXnaj2/CkcyOTKSi/TybN7y4svTZz/pCI94nFlHwIar2xgcSrh3tF9Qz/w+2kcJpcxszONL+11dLZKqWoMMtFI3QbtcNp3WZvtHLvg6peJZEAo1uHgZ9e7wI0hf47Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CC6PR11MB515005.namprd11.prod.outlook.com (2603:10b6:170:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:02:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:02:57 +0000
Date: Thu, 8 Oct 2026 11:02:49 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Alexandre Torgue" <alexandre.torgue@foss.st.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"Stanislav Fomichev" <sdf@fomichev.me>, Song Yoong Siang
	<yoong.siang.song@intel.com>, Noor Azura Ahmad Tarmizi
	<noor.azura.ahmad.tarmizi@intel.com>, "Mohd Faizal Abdul Rahim"
	<faizal.abdul.rahim@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, <netdev@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2 2/2] net: stmmac: Stop Tx queue when
 (en|dis)abling XSK pools
Message-ID: <asdcORsu7HNfAZBb@boxer>
References: <20261005-stmmac_xsk_crashes-v2-0-46c60cba6421@linutronix.de>
 <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261005-stmmac_xsk_crashes-v2-2-46c60cba6421@linutronix.de>
X-ClientProxiedBy: VI1PR04CA0109.eurprd04.prod.outlook.com
 (2603:10a6:803:64::44) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CC6PR11MB515005:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b453f9-de1c-4a30-76b2-08df251af254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Che2XpyusTK5LbHouAZJeXg5wRJuEgE+VsVjt0TnpgJDxw9/WcfNIEws7hlR0k8FludsdCOX4DRj7Sx6ISJ9u0KPCNIQcke89pgrPf2AohxEfRiU9PoCke0l+r5kykDO9Ro811M83OSCBfnRV2IJUGavS5PHvyCfbnFvowQA8bXZ4Y4N1KiCMgHNf1/Q5O9p3Y5JjgtAkCbKGy1gk6+whck7ue+9+GJ2VUrK9VpvuCcOmn9mviGJd+vjIuXD2pXDYjfAbJWiRlfvy/pdmTQnMu9pAOIkKq9xmgDOF/MuLOHzOrN6YVH+3qSkM/nwQA+7lPKK0c8rdhXywU5uz/zzh9n+ynpKZcITrpgH6BNP9VhgzVVDSTSMRF3JJ4ECB2BdQC6FRwFT0N+smNaaQFQmfYC+KUQjSKWlSnhygY4vljY5/umjf33Uh3ZsB/HB/bP3B5q3SxRliNgYksg+9SU4Nlup0k6tEcvNoJs6jjtAVZntlIQpk3C1mgi4iEr6QT1iUjHZn75v1yGKDD79JUrNafIL+ti2Tt3iR1mXO4WTU5CvuL1z5uOrIDBY6u6oHsokvGw2ieKG55gYGm2FrwCyvdjBQnBJCEOoPVmLIHEChGnFtwQ9DkZFSmdlCkxEeMYdhgTGWJ2+2niBAFKshOn7l2I9dVddMyyHUIIMbGFgiIU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kypsye0s/fM8cx+HRTgchB3plvvLTTNdR4Uqe592d6D8uHApl1jYFTAjg7Mx?=
 =?us-ascii?Q?WeLH3AtT4lMhZzyIFWQpsU6vKflcLMqCr1uTDHWa6+qsUZkSuKg3bEMdW12J?=
 =?us-ascii?Q?i6KCQe9yCa3VMW85a9PKuTQBemOqAtZl/yGnKlB0fu4QQSbFBkWQdhrIlj/+?=
 =?us-ascii?Q?0rle21ramvyGh7p0kZskBgRW2vr5SWch+aB8hIwk9s5awXZH8lld5tEcOym9?=
 =?us-ascii?Q?qMDnlm+mCl+EryinTbvEBdWeh1ZTnCOyWroLGWzHEfCBDCOUkyXPYAoDbFCq?=
 =?us-ascii?Q?rbV030l86K1yPg51D4BUFsH+qqpg8Mspb21mXwKOHdKHXozhFkRSGerWllrr?=
 =?us-ascii?Q?6IHkrbut8d2J1eMd3lCsxnzHnSq+dvgYtyH9VUSjbq4GJygRhr3hc8/4s0Wp?=
 =?us-ascii?Q?uK3YMZj5/21Q5PojBd9AmVrSQxpSYPX5N3JHZWg6WbmPjMBe5DE+/32bTXaO?=
 =?us-ascii?Q?Xa7i4vbidBL4RLTCZfW9J7cbSS5N45YPR1tHDmyiWvOZrF9BVep7J+3POA29?=
 =?us-ascii?Q?eUP5cYpZQx1uYChuP2vQvt7ffFDCBIobpEPhEH2bnzjtKd1WVdEkbCg5KAZC?=
 =?us-ascii?Q?gv/hxwwJh9X+I7pks08k2rcof7/SD7lTix+FrwnsYgI8W7LnBMwAelcR7mLC?=
 =?us-ascii?Q?ekkAiZUcoyjySDSAWKf/TZ6Y8sMU7y4MRTIEsIycJT19OWnhC1O/VZX/UKIz?=
 =?us-ascii?Q?0p/Fu38c+bn3j9nJ4pVQoV86w+qQUdJCRKPiLsdCpjNB3X6ATbZhYYMiSwqT?=
 =?us-ascii?Q?ZIB703QMPbSOZ9vubOXJ8TZDRs699b9QxB6ZQp1kDQHwhHvJpJn55UYP8b9O?=
 =?us-ascii?Q?stqij7J2UZVDqd8q0yaEByY7VK/+RZC67iud/UuDXLnf3NY3AJGrPU56M826?=
 =?us-ascii?Q?tGdnrOxImTr8C4MtMgCNMP1/qEnZ6WCCjvGWjyj6iUZ0g/YIk6ILmm861TTd?=
 =?us-ascii?Q?Gb4+Kp1DmQMyvs34eq8p3/cYNkiB2YxzbdGHl90oN1v0sc9cXhfzA5FU8D8Q?=
 =?us-ascii?Q?2fpr58fX2jCq6w9CSYFgs+Uqg8peGHHj+e6Pm9BvikH0U2rq0+YLElSOlT00?=
 =?us-ascii?Q?uDKyh9nO6VHiggP9Ip3WeX6qdJ2wpjyZSmT9DSIcwcevRYF9GJttmyG0XX2l?=
 =?us-ascii?Q?Ba3RqeZyaQaF2AhSVrl/TQCr3AO9nUhGgmx2nj8CmyjJxoZ0lG0Pkg6uUzBZ?=
 =?us-ascii?Q?yK3W2/+1FvR3NEhHhIIKEze+dORrxWpaoYZvhCHzXpPHgv8d1kk/Gsi3xcUi?=
 =?us-ascii?Q?JG/4Lao/O3E4geCRLJlth43WQW0rvZxcawz8mwx17/dNqCROLjNEjIyCobbB?=
 =?us-ascii?Q?knc74n+9D+kpKuBmnl5cZ7TplSQXBUPaFiUxleMLtHxEQXnFf6lUKcRBfhlV?=
 =?us-ascii?Q?dogDu7CU8TKpGaF+4SQUrcuRbZGBW6L+6sc5UZ1jqFl8Nwy+zMBaM8E74nlc?=
 =?us-ascii?Q?EKwx1DKVr+2IdHdt9On8vYGtLkcIcniRXYo4TWzHSQGfCpbTNVaRS+UD2/ux?=
 =?us-ascii?Q?92d/mhDXZmMiEVULfOm4sJxD460dbst9dOtLZbZSuJ+pjis6HYdYVqdSXd0v?=
 =?us-ascii?Q?o8U1HJL72BWgiG1xGiBmMNhi2Y40pXZgMqp1N7LluR3RBn7F++jAO7eAxT68?=
 =?us-ascii?Q?oD5r3VcBclNBDMVgEu6/nK1/urSDx0Y+u6gg3/a+KCqqGtcs5M8IROItAjlN?=
 =?us-ascii?Q?cJuez7UF/v5ojvD84o0aj1GLHv7w+rk7xre+gTonNUM25y1bs6FBZfixAU+L?=
 =?us-ascii?Q?EkWhFJrg643T8Vu1ZhcnRN/vsU4PZ2k=3D?=
X-Exchange-RoutingPolicyChecked: FKQIWzhaXjM6Hw6EWd3QfJ7fTZwUXIUDY2oThdROY/G9eoUFcHT1cg70kpq0hh78k1chagqsWc3k2UpHF7B8jq+hbQV7xaGEUD+qGryL81av8CfgDxIf++cj8LxBfzW8IiGWnzHWJ/nNb56Ig7dPVrTw3owihj7nqAr8XplvbCIqcor36pBvxjShPrdM8ZfzRxf6fgXGGmQkQWkbpyPG5fwKFJ1jYQVLSxjK8lv0mbmg+TAmp7xb7Wt1vX17NFSQ0gFA1gt3zc1iKbu9DxtvlcWCqs0c4gWAU6zw6qbdbu2waDSygUi4AOob2Hfdmxlv3SWYmKtiysvk5UHd+qo3Fg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b453f9-de1c-4a30-76b2-08df251af254
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:02:57.6067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9U1mKKf8MOpY5Ag7oZNajewUxEvtUdOet3b4v/M9q2Qi04mIT9MPnlUNMOpQLIK2L6/KBdBAFJOK9BPCAg3uUYh/G3SJjE4fdjvPxQ6c6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR11MB515005
X-OriginatorOrg: intel.com

On Mon, Oct 05, 2026 at 09:09:33AM +0200, Kurt Kanzenbach wrote:
> When enabling or disabling XSK pools in parallel to Tx traffic, kernel
> crashes occur. For VLAN tagged frames that happens in stmmac_xmit() ->
> dwmac4_set_vlan_tag() and for normal frames in stmmac_xmit() ->
> dwmac4_set_addr(). Both of these functions access the Tx DMA descriptors.
> 
> The XDP pool (en|dis)ablement frees and reallocates the Tx DMA resources:
> 
>  stmmac_disable_tx_queue:
>    __free_dma_tx_desc_resources
> 
>  stmmac_enable_tx_queue:
>    __alloc_dma_tx_desc_resources
>    __init_dma_tx_desc_rings
> 
> NAPI is disabled during that allocation window, but the Tx queue is not
> stopped. Therefore, add the stopping of the Tx queue during the enabling
> and disabling of XSK pools. Update trans_start when stopping the queue
> to avoid spurious watchdog timeouts.
> 
> The issue can be easily reproduced by:
> 
>  1. Run iperf
>  2. Run application which opens an AF_XDP/ZC socket
> 
> Fixes: 132c32ee5bc0 ("net: stmmac: Add TX via XDP zero-copy socket")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0..883bd3fe8089 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -6,6 +6,16 @@
>  #include "stmmac.h"
>  #include "stmmac_xdp.h"
>  
> +static void stmmac_xdp_stop_tx_queue(struct stmmac_priv *priv, u16 queue)
> +{
> +	struct netdev_queue *nq = netdev_get_tx_queue(priv->dev, queue);
> +
> +	__netif_tx_lock_bh(nq);
> +	txq_trans_cond_update(nq);
> +	netif_tx_stop_queue(nq);
> +	__netif_tx_unlock_bh(nq);
> +}
> +
>  static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  				  struct xsk_buff_pool *pool, u16 queue)
>  {
> @@ -36,6 +46,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  	if (need_update) {
>  		napi_disable(&ch->rx_napi);
>  		napi_disable(&ch->tx_napi);
> +		stmmac_xdp_stop_tx_queue(priv, queue);

FWIW you can look at what I did at ice driver (ice_qp_dis()) where I used
a bigger hammer here; I think updating trans_start is kinda a workaround.

https://lore.kernel.org/netdev/20240708221416.625850-1-anthony.l.nguyen@intel.com/

>  		stmmac_disable_rx_queue(priv, queue);
>  		stmmac_disable_tx_queue(priv, queue);
>  	}
> @@ -46,6 +57,7 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  		stmmac_enable_rx_queue(priv, queue);
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rxtx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
>  
>  		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
>  		if (err)
> @@ -73,6 +85,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
>  
>  	if (need_update) {
>  		napi_disable(&ch->rxtx_napi);
> +		stmmac_xdp_stop_tx_queue(priv, queue);
>  		stmmac_disable_rx_queue(priv, queue);
>  		stmmac_disable_tx_queue(priv, queue);
>  		synchronize_rcu();
> @@ -87,6 +100,7 @@ static int stmmac_xdp_disable_pool(struct stmmac_priv *priv, u16 queue)
>  		stmmac_enable_tx_queue(priv, queue);
>  		napi_enable(&ch->rx_napi);
>  		napi_enable(&ch->tx_napi);
> +		netif_tx_wake_queue(netdev_get_tx_queue(priv->dev, queue));
>  	}
>  
>  	return 0;
> 
> -- 
> 2.47.3
> 
> 
