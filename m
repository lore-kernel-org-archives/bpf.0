Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4928E0F;
	Tue,  6 Oct 2026 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308597; cv=fail; b=WivJEtB3X/iWKZyxXKF7jjuk0KeIlPquHi/KCH4BPkNbyA8ZOR7VCkwqiApZXSdDwKigMFp7bCE4aWA5M6UUgW/NZz4Q/xCILaaSGqSipb+P6Ou5RAHepo0V7llPPb8qAS/pCOzY4xRq2qRVHg7ZwPCTSq3Jzy5W0bpNPnYUEEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308597; c=relaxed/simple;
	bh=6yV95q2sGKgcJuMZnAug4jdY2X4ayZYd21cipLSDCCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fWgga7ix1fdl1ZIBoMPTol2QS69+PM5bfHE3auZ1k0akYVr5iJuDwbsy4GPCcCEO1TrxM/gNIKepYr1lk2mFFgJgc8iyA3V4yRCcKJ3bRoRtFLPU8LxHnrFqs7nxECnQdFy3dheJ/nLknfGtpfIlTZxlfYO22fazwUhIZ8mrRwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hr+oyTCL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hr+oyTCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791308596; x=1822844596;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6yV95q2sGKgcJuMZnAug4jdY2X4ayZYd21cipLSDCCU=;
  b=hr+oyTCLEfMmIz6wpl8KPRHBOYuHtKHUCzRquqcjqI5r1gmemjQ56fzc
   JrDeH+OYpdk8NJWcODFDUDpQ7amFVnyStcCajdSb21tXyRjv56V2B/JGP
   tVnagGGGlyowX/JfIKKfMKL2C/4OTx6FQtF9UUVDOmtq+47zOHEOFewqa
   AjYqn5j04kRNdRj9Wc28lTH/7WDsPaL1gYrJrHzbFVmBnG1wtqnFFJRHc
   npxHyL/x2J8Ji7htSJlvbH5c7VOMBlaxiI0nRFDHeYfV27CMZsmEtOq0M
   xYEXAJTIYDWyDlRKrFWUptkAtUXqFKkU97WqpMQ5xwA/zVgWfnxQDzG2W
   w==;
X-CSE-ConnectionGUID: 1c8Oqru3RhmwD0rNU6EtUA==
X-CSE-MsgGUID: MqkW73O9R/a2NpEU4CXRvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="63018"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="63018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:43:13 -0700
X-CSE-ConnectionGUID: 3MgPUxXRTpWdnt7+LOnsgg==
X-CSE-MsgGUID: xVdxLW3TRJuikScC68Uwmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280451206"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 10:43:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:43:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 10:43:09 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.26)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 10:43:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoTjIWLeH2PZiNPlg4nKQie5vXlKUZBLer/88phzlzRKWjRJCkZJi+QZFujrYSZQ7nEqu4TOe6akieWXhFepkTB2bPGrJoRGtxjX1cUnVh+LBM+mVPzPx+9OBl5AzWCyNj8GFV9JONAc1ThOuH9GpZ45qRXspSNed+SKhHvDOmRZVypbhGz92QV09WY3s3/Zm3/S1fkquKu/jSUCDKJWstneaxujzVv3mh5UcfVsXl+Fl2dcn58PFzduNizLiPh04xo0nQOGHrfLnsbMVCeAadZC40j4Rm6OONYNECw4NaUDLqrW5ZOAWuBzc9ZvsnEfFdpyxxJiSrSR2Bq4bZMTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKOcrqonha0Yy286hj2tbGUCqBOpXT2Sy7925rL5vO8=;
 b=a++qM4rq8qV/Bw03mRQnEICX+jqTvYykzRlNjZ0/fxCkSOCkpuS9lgvfGZHfdD+T0KBWnBO+PUFW66TJdA7tHU/LICaIR6ZCQJhSqq5avVh4yo/eXybYSQMRWQpiO/GXE9SMic1MsZ/tOzIPSvit4vPnE/65QEwLukUOlKnLylN2XWqPXazFzg0NtZ32p7arZtNeGvjqNVD9LJRon0gZOH+knDJNzuGkcnS+In4QMRATbPS0FkVpq3RHhctOA2CctgCG+2vKp4xIuTxIq1YTXrjo8Z9Rvp6QYin8RqtaewbIWZ2wnGG3+qwZeQD+ZUjBuzM8DoG8E1J+7m0V/230fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 17:43:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 17:43:05 +0000
Date: Tue, 6 Oct 2026 19:42:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH net-next 00/13] selftests: net: migrate AF_XDP test suite
 over to net
Message-ID: <asUzHc2Md9qu8Hx5@boxer>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <asPlpJdawXNRAGAR@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asPlpJdawXNRAGAR@devvm7509.cco0.facebook.com>
X-ClientProxiedBy: WA2P291CA0031.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c01427-e515-46a1-5b32-08df23d146fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|11063799006|4143699003|10067099003|3023799007|56012099006|6133799003|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 88lfRwNtJU8rbCARAxBKXeVo4FHgTqTWiTQ4WyfEbWB+C5X1CxceKwG1Iqe2qAOoqUIBdzfVgUrCEvNoH2Nw9RQLkEqDzGZtpEI1Vs8QLg6Hv5QQr+U0MQdSHX8UZdbynn/PLKNHAT+Ltb6c5kq2h/yd6KVjYn1c4nZh0oDRfL7pai+GsXtNsCnGzLhRisPpB/ohByNjX9wepNs7kbYYUkpOP+VVsFrDl+tK0jkMQjK2Bb0mg2h/7r85nDqUqTsiq4rxbpFETrvsJgzrYQXjlpxp+/Lkl9wTNLDGm/AyeeoBt1L+mvSmJ15P2Sb8umP5zj4xBTt1/aqSbQV78OiGla9mBl1ykE9v/eG3Xr/TnXqj9sGb3UlLf9LB+D9UKNged2KaRnZ2iXtnuUVSUishdvkv2ONpM2PBqUBJ473G+6xsjb5qMs62x3WA1CTaV+iHFK6ZIkyW6aQF85nwmPsUbhITpVl7TNcBuUrQe8uGfrN2DPX2MQwypPsNLurzjhqjf8E16sKovZCrQXgp1jIBMA1SD2KbnhlXbHIAAi/rUAEm7WA83mujrWlz/AdWkmtSrdPLAEFT6mSOOyCRkk3vnz0uveWuDbuK7Rjiq+WwbgLztMhAnS9tGFcRol8/s2hMDzShIqtJdhFfOHNoJYqJ3Q9INhsl0FeJcquWmysd55A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(11063799006)(4143699003)(10067099003)(3023799007)(56012099006)(6133799003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g54gJF/9vNDZM/WgKc8qZflKN0tQqKJjpvvScKVyfk/0ad67qGn2NMM2Nyoh?=
 =?us-ascii?Q?SXrPTpgbjXfeUbtAVHic+XArThWPrsowtmbw0Jf83dEZuF8SiP4n7fPQfCfZ?=
 =?us-ascii?Q?8qaZtfZok7ZsLDvhALYt0XcbRaf07VHfAqtCca9ZDnW0qa58JHYFiwBSNa8b?=
 =?us-ascii?Q?vmGUofyehNRdKlYtuwvTQQFhyInuCYeB9THdLDTKlsR/czb6SaxmNhY9Uigz?=
 =?us-ascii?Q?kKCpcIhYJnRKMI5f322LL6CWQ2tXhb2uHuOAPGfVH0dgwyBxLeb40Eb4oAdz?=
 =?us-ascii?Q?ojRDSbJ+jWnlXKu6mNbH/nixYfXV05cmf9148a0bJF2NhrLxsHllPqxSs1FV?=
 =?us-ascii?Q?SFOTUdl/EOjSD46SIz72M9ikKMYusFAv2iUJSOvbr5Pq+o1XZy+zIptfKOiK?=
 =?us-ascii?Q?vGEJi6Ns8Rg41ih9ofRyGMPEjxMSd3eeu4yisfvEVfKfJWulVIfWBTUbEnNe?=
 =?us-ascii?Q?AIP1qDpc5yEYd8Vou5cQoD1CzHmb4prrgw1DjYvygnQGCavP2Kucfuj3N/+r?=
 =?us-ascii?Q?8yB4i/mPt71cccRy2mkt7QzMaMUDDVvnsM9d3HYToBZbIyBz4D7DxDgfTVf4?=
 =?us-ascii?Q?9pPTkgEJ+10ZX1hL2ndK0cAH8xAuV3pqnpuCMScpsA9fgQTAwb58RuBvuf6N?=
 =?us-ascii?Q?eDlFECK1ZyJLZOtoelPnix7qc0liSw7ky8LgQeMDM0o1FoM+JkxjslQDCktg?=
 =?us-ascii?Q?TqrONEHDlHKWTgRXNBB7DCYzRsRxHdyyeEVoGg0qoDnd+LQEFgybLNAlEilj?=
 =?us-ascii?Q?i9dwCQ06aUHHieXmC26akoFiZCxxVXrOSB1QNOVXZB82hP7S7Fop0INJafHn?=
 =?us-ascii?Q?tdp9pJReU16TBuMBCW3a8NaoO8rbm1BHtWpU1GmgJbPywqXFImvsK6Gxu1CN?=
 =?us-ascii?Q?EC2B1u7lvkSdCRXpt9Jax+2IfSVeRLV4kupA5Fkf9I0d7uzNbtrk0VDQjpvE?=
 =?us-ascii?Q?h6gwEMZGYNMhsCn8IEfSftBsW7HoMaVZthQO4ECP493chcS0Nbr4KLuAwOdB?=
 =?us-ascii?Q?XXg4ldijVQ39N2+2J9EvyEtVe+APPljUpuCyl58qMZZ32hqyuhA2qolCwDfa?=
 =?us-ascii?Q?NuZPmg/RdoTgNGW9/GTC7IU9oTqHLKSQWDKepPWSLK9Ec8ZdoizAp4UIuPKt?=
 =?us-ascii?Q?OPDvyyHGn8isbYDFb9nJEhRifSy98h+EGEksVpuYzfM3nTyPGNSvXa9YuXD+?=
 =?us-ascii?Q?nm5Y7t19M84f9SfuMDYwZey9jFlW1wr/pRtH8kyqQGXBmVD/9zrbz15nQ+Ok?=
 =?us-ascii?Q?07+mF4W79uecR+ULWWyGgNOpEKseTwLrATDMvrKVHfbQecPD5IluoK5TcYdr?=
 =?us-ascii?Q?RfbY3d+q1TmdglpVnPwCSP9YjVlE23igdSyHXJVPpFT5VMf3B4dNFTDXIg1X?=
 =?us-ascii?Q?q4d8diyXrRdlTQ7z7N76wqzPivix1/KcgqdZO+LJYTGh9RAtRKHu8sd9kssT?=
 =?us-ascii?Q?lPSzd1Do6b+nww0/a4Zi0xEun8dkRIrK1cDsTPOatTOgd2+a69jFt/tlmc5C?=
 =?us-ascii?Q?JBHYgJlPwaexsjTJSbosjGeM1jTALu3SktUAHY7bm06xz4DNpkBBfo2B8v4C?=
 =?us-ascii?Q?RDK1Nvf7NZRAOYQPmBtC36KBBrKJwDhf7KMYvDO2Th+AjJdkXk5mlMBQRFUn?=
 =?us-ascii?Q?soyCaNp6ENc3+2YocfoFG+6gUzm37WgoqRqUuSj/Uopmj/rRxVwYGklKwSxP?=
 =?us-ascii?Q?E9Rs9LAzrEAQmj/M2B9g4fA0CqfnTsU07rZL+ayxSEK+FcmlshxieBLuK9rr?=
 =?us-ascii?Q?Yx8EqLt6jGz0JAHqPoHeohCdpd/WmkI=3D?=
X-Exchange-RoutingPolicyChecked: Sj797LtxUSdTCAmuMSnxCV9dL5P5jK6/jgw2+SFN1/pHQndW5dRwUdlbJvdDgIywCMn5xrTmeh8y5JrlesWOYi4jO1tRd+gt7KxhnbqAIYNZF7jHA6liYUR7lwQH+95aLkLIoePwQbfpGFH0+WhxjNzBdeN+rm8utSDgHP8y7und7FhqSH1G4lk2H/e6pTJBAHbX5vDU+t2bpjpt0zEO1ekQvR67Hucu/mFCd4mmMdoZHKVH0vCg0h9l1hzDx2HarzFMVa120ddr4In/iR7Km+weNMFB5tuFrjNMaQmgm0yCm3hXZLTs2V+64x1yMfLzXCRmJ2T1L6dnDbJ6Agn27g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c01427-e515-46a1-5b32-08df23d146fa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 17:43:05.8552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/bVKCkMf/7QYdHVCX9E/B4rldAz2unNHzsws75edCMiLjZzuGBESYS7PjZCUFm2m47M0gzFINX7BJkJqwcoMmM1CvlUF1gSKgRd99rc1Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
X-OriginatorOrg: intel.com

On Mon, Oct 05, 2026 at 11:06:52AM -0700, Stanislav Fomichev wrote:
> On 10/01, Maciej Fijalkowski wrote:
> > Hi,
> > 
> > This work moves the AF_XDP test suite over to selftests/net and adds
> > a hardware test on top of the python-based drv-net infrastructure.
> > Since a non-zero effort went into implementing xskxceiver's (not so
> > great testing app name) test cases, we did not want to completely
> > abandon it and start everything from scratch within different infra.
> > However, hooking it up to the networking CI will allow us to run
> > cyclic tests on real HW; before that, all of our HW tests were manual
> > local runs.
> > 
> > Tests were based on a process with two threads responsible for the RX
> > and TX paths, whereas the new infra expects two separate processes for
> > the DUT and remote side, where each side has either rx or tx role.
> > 
> > To satisfy this requirement, this series makes each xskxceiver endpoint
> > a process of its own, so that the RX and TX sides of a case can run on
> > different hosts, and adds drivers/net/hw/xsk.py, which runs the existing
> > test cases with the DUT in zero-copy mode against an SKB-mode xskxceiver
> > on a remote host. The veth test keeps its cases and moves with the
> > engine from selftests/bpf to selftests/net.
> > 
> > ZC tests used to expect a single NIC in loopback mode, with both
> > sockets on one of its queues sharing a UMEM. Now we step away from it:
> > the DUT and the remote are separate hosts, and an ntuple rule steers
> > the test traffic to the AF_XDP queue.
> > 
> > The remote endpoint is xskxceiver in SKB mode rather than a plain
> > socket, so both ends keep sharing the packet stream generation and
> > validation of the existing cases. This reduces the need for remote
> > interface being a NIC from narrow set of NICs that are AF_XDP ZC
> > capable.
> > 
> > This implies that during the test run only one side is actually
> > exercised, so let's introduce the concept of direction per test case.
> > For example, this means SEND_RECEIVE in XSK_HW_RX will test
> > ice_clean_rx_irq_zc() routine and in XSK_HW_TX the ice_xmit_zc().
> > 
> > BPF's 'test_progs -t xsk' is removed, as well as single interface mode,
> > which was used for ZC tests. BPF CI therefore no longer runs the
> > xskxceiver cases. test_xsk.sh is kept, as it is the only run that needs
> > no hardware and not all tests are currently covered by the HW test side.
> > We can decide whether to keep the delta test cases, drop them or somehow
> > enable within HW tests.
> > 
> > Thread-based approach had a pacing mechanism that was a simple in-flight
> > packet counter updated within critical section by both ends.
> > Process-based way now is going to do this pacing via xsk_peer.
> > 
> > xsk_peer, the control channel, carries three fixed-size messages: READY
> > is the barrier between steps, PROGRESS tells TX how many packets RX has
> > consumed so that TX does not overrun the RX UMEM, and ABORT stops the
> > peer after a failure.
> > 
> > test_xsk_case_defs.h lists each case with the DUT directions.
> > xskxceiver builds its test table from that file, and xsk.py parses it to
> > make the variants ksft_variants() named rx_<case> and tx_<case>, so -l,
> > -t and -T work as for any other test.
> > 
> > 
> > Patches 1-3 prepare the split. Patch 1 moves the endpoint work out of
> > the pthread entry points. Patches 2 and 3 drop the single-interface
> > loopback mode and the test_progs wrapper, which runs both endpoints as
> > threads of test_progs; neither can work with one endpoint per process.
> > Nothing else runs a subset of the cases, so patch 3 also merges the
> > cases that the wrapper left out into the main list.
> > 
> > Patch 4 adds a generic rule for BPF skeletons to net/bpf.mk, as Jakub
> > suggested in the review of the xdp_features move [0]; xskxceiver is
> > its first user. If that series lands first with the same rule, this
> > patch can be dropped.
> > 
> > Patch 5 moves the engine, its XDP program and the veth launcher to
> > selftests/net. xsk.py needs xskxceiver, and a drv-net test can only
> > rely on net/lib: the selftests build pulls net/lib in for net,
> > drivers/net and drivers/net/hw, while it skips selftests/bpf by
> > default. The veth test is software-only, so it goes to selftests/net,
> > as the drv-net README asks. selftests/bpf keeps building xsk.c from
> > its new place for xdp_hw_metadata and the xdp_metadata test.
> > 
> > Patches 6-9 split the engine. The interface capabilities move into one
> > struct, so that a process can mirror them for the endpoint it does not
> > own (6). main() is split into setup, run and cleanup (7). xskxceiver
> > runs one case per invocation, and test_xsk.sh owns the mode x case
> > matrix (8). Finally, the RX and TX endpoints become separate processes
> > that meet over a small TCP control channel (9).
> > 
> > Patch 10 adds the xskxceiver options that a two-host run needs.
> > Patch 11 moves the case list into test_xsk_case_defs.h, so that
> > xsk.py can read it as well, and patch 12 adds xsk.py on top of them.
> > Patch 13 documents both setups.
> > 
> > 
> > Tested with back-to-back ice NICs connected between separate hosts, with
> > following net.config:
> > 
> > NETIF=ens785f1np1
> > LOCAL_V4=192.168.100.1
> > REMOTE_V4=192.168.100.2
> > REMOTE_TYPE=ssh
> > REMOTE_ARGS=mfijalko@hostname
> > XSK_REMOTE_BIN=/home/mfijalko/bpf-next/tools/testing/selftests/drivers/net/hw/xskxceiver
> > XSK_REMOTE_SUDO=1
> > 
> > 
> > Known issues:
> > - Every case pays for process start-up, XDP attach and detach and, on
> >   hardware, its remote commands. We used to configure resources once
> >   and then execute the whole test suite; it doesn't seem to be
> >   CI-friendly and it is preferred to have each case's resource
> >   management separated; that on the other hand increases the
> >   execution time of the whole test suite.
> 
> [..]
> 
> > - The XDP programs redirect every packet, so the link under test must
> >   carry no other traffic. SSH and the control channel go to the
> >   REMOTE_ARGS host, which has to be reached over another link.
> 
> Will this work on NIPA?

Yeah good that you're bringing this up, I see NIPA has a e810 setup within
same machine which is not what i tested on my side. This means the
assumption/requirement of having isolated link under test has to be lifted
as e810 cards on NIPA will carry management traffic via same link. I'll
add XDP prog logic as you point out, thanks.

I also hit the ice bug after connecting interfaces within single machine
which was hiding from me throughout whole local testing, during RSS update
where we only want to touch indirection table, symmetric-xor hashing was
being turned on which caused later rss operations to fail; I'll post a fix
to iwl-net and include some heads-up to v2.

> 
> I took a quick pass, nothing pops us for me. The only thing I'm not sure
> is the bpftool dependency (whether we need to build it or there is
> something on the system).

We need it due to skeleton usage and other change was also utilizing it so
I thought it would be acceptable.

> It looks like NIPA failed to apply and run it,
> so maybe address 'redirect every packet' and rebase+repost? As long as
> it passes HW tests we should be good :-)


