Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2581DA0E1
	for <bpf@vger.kernel.org>; Wed, 20 May 2026 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779255442; cv=fail; b=Fg62qoTn2IZjase83kKAOIAzyjTP9bA/E/SdAIsgD4j+SJo+4EjD+ri4J2cmxDOAZC18VgwO4PsDo7tdx4H5GuX9qxxAb3F0o10T4mVigSu2kOByPj8Bfg16tP1vq2qn/YC2pqFMsLxIdI2sjfg1g+Os/dfrk09LN7rt73FhhLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779255442; c=relaxed/simple;
	bh=Uppq7gxSuUaEYZi1441Pen+JUvAVEzpDaE/Vro4ZVNM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PjyBSVNbjUt7wez4kiqjGXws01mpJn4PL54UNeGl0OxHuhR6kcpNwQqTa0+pfQrMRF7ECq891M1HoiiQt8rAJFcLEMsVNMt1+5ANFUJHko9GDl7VBuiRUX6wlQmLUnORQ6TuG/geMD8ukr2wJph1UE9wXmn4XroTIdqGYqvVQfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5JOPvwG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5JOPvwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779255440; x=1810791440;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Uppq7gxSuUaEYZi1441Pen+JUvAVEzpDaE/Vro4ZVNM=;
  b=k5JOPvwGf+7dDd2zY9b566wmhOlBN7dGRgwKnsqihpSZyRci6WzDAaTg
   RGsAsO+C4yd3or8yOwovYrVeqlBT8zb4dK6hv2E1mXtYkn+wkfBqDnD11
   bYOTmaHlAb7HbhCTIr9oXQe9Lkiq2MmQTzR94yQKRrP2NzMtTaAA/8yCw
   i5v0RONA/7eCsxuhGmTgbRj8uhP33qa9vK/D2aUpxgkjAWfcdmyo0VbJ0
   w4k1W8W1zbuqcq46Y/2AGfUBMIYJdoLQxQkOIsV7cS+Z5Jaqq+ohXsTO9
   0emMaCzTLv5E1hNl8QxCleCvaos6tgQdcv7RZMvWb//FOVwXvTnvhNffR
   g==;
X-CSE-ConnectionGUID: tZLbo2a9THOM31ktDJ7l0w==
X-CSE-MsgGUID: Vx840LX2TG+y00PDa5NLRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80321427"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80321427"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 22:37:20 -0700
X-CSE-ConnectionGUID: PHCsZ+FLTK2QzCmy1f6lPQ==
X-CSE-MsgGUID: mRs62/p/SPuaD7U57LDtIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239891740"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 22:37:20 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 22:37:19 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 22:37:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 22:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNLKSzrqdBpJFyMaEKN0dsc4llSW6AbRNTGoRVVpDQKyeAJCn1KV+rdwE8o+iUArPKB7tBC3Nd1YhMGTD8m3ENXXrNlSrT2rPoMPBuye8CpdgoczJK8IqWkeZK5cTuPz+c7gKqStU2hWbG8hlZC6GFOOwVSWf4j0JhAx5L2lce8fGw4BgQ9dqaggTOonKP6/r+Bn8sjBSdSHnZGuLELjlFbw2WjVExRDSkf3pPt/I3IWxgDyqQNxUu28VBXCbpPqZLg2SQOXQUBGjGIixwC33aEZjhL4XAfoviAbSPZSiThTfcCA1gvK8IDKLRwCNPnu1ojNi7FgN3H22Du3w6B97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPQ6IDBcjUmpIIfEZAFkpLMQXErVr+v55S064Ga9YnA=;
 b=TrWuIFSSrEuzy4I65LhCA3qtD4McXavfsayADcVdRFk3OE8/VUaZAN0nx2PdSvOr4ipM+DSK0S7BaqruSbyfZmXcps0A3VM5osZMFK3f2QL/fLB3VfH/Gm38AHw6JkPV0Ko6y/7hZuTnk47lUE7GVmj7wzue99HDxybGtboyXvBKWhqpv+tSdwIXYx+RVi8RPMxPwHP7l5x3K8zW6WzXgE+eCbyAZqmR9OdlB/DbYskhhcq/9+qZLnQ5/kyiXsEQK6n1lCMJPV4I3je6wkEIxck7lK5fBh3mo2VJAXTkrmx3mOJy7+1/hDvFT3XmCLNOUJxWfsUlrQQeEP8QIxuV6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH0PR11MB5299.namprd11.prod.outlook.com (2603:10b6:610:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 20 May
 2026 05:37:11 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0025.020; Wed, 20 May 2026
 05:37:11 +0000
Date: Wed, 20 May 2026 13:37:01 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Justin Suess <utilityemal77@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <bpf@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Use rcu_work in BTF teardown
Message-ID: <202605200724.c2adcd3c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260428201422.1518903-3-utilityemal77@gmail.com>
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH0PR11MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3a31cf-eed7-48b5-4848-08deb631d712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|3023799007|22082099003|56012099003|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: YFBPncIu0UOLKa2UoTO5Vb7DCGvfDZin+pJBWmC9Pc+fVSljq2qep0DP1y6vKGvF8Wmia/BLmAS1cmCXLegl32IUoCNnv3SnA48f0XrS72MXg5fyptbJ4/OQAez0YhOBHaLQG8LfVrO/s+CY1GabZlMSYODKE4ufgro69gxmKlZhmERBCqrIOu6ylzg+qFTt4K/ddpDxiuK2DehnW+tSFDszB75xG7t3G1MMerUzn3oi+u2EOSSzLRomOjgsMQlZaokTb23KEJGCV6hIM7wbK5DSJiJBQ5tDQyd5ua1OTEN5Ie4Z4tDNy59Uo4dN51bFv+wOhOdJbf0FGJ6bz/SHO+5Xbw1CLISJR1L/Uo1OD8R/rDzocjDay88vLrj/L6CUrxdqOCZxQwZw0lHa9O4IVF3lhV6lhEI2TjPcbsVCrETn1bWxxxu9Hw/p9YWMtbUkgrGGsU8xqFjvksAOZxJtCMXRPjLN2OuOeyqBs7qZgI7Xbqf4GU26+Lq9auezpzGSS8nKcZHTkryfhy2wzrf1HRafPfcsrvnjNezxtr4Tv1IzNPu9+fCqcQ+IBUY2iN3Yuslp1U253OMnAqqoLSTWM6GYQcxT2K5i7spKTBDE19Qj4/pWD1THpKlLm6D+0F0DrSH35hvGP3MjxGbYG5MZzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(22082099003)(56012099003)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gy9101DNbX3SF49wpNYPGAuhG3gtJVvuKZd1DsTlOgSjmhWi1/tyCErHcR54?=
 =?us-ascii?Q?X5K4bpsH/v5a1aJQ4brffYMeH1Np2fI8ytRWOgxApuJEmQOj0aF8ej26JJR6?=
 =?us-ascii?Q?XEq7wF1RApj7vDjNDwxZe5fxEBBZ6X9/0PRfQSO23+CWilxDaThHpnPt5FpQ?=
 =?us-ascii?Q?ejxpyGNP+klyMNb8qul6flQC5/42Ruoxwpvyvv3NV2SQPKfLqWOXJFWzYl7Z?=
 =?us-ascii?Q?kgqa6oWPNdtQVgjB2jV2oZ8LiajgdssNZmwc5hI2TYEpsRaKmpDnCN/0BlhO?=
 =?us-ascii?Q?2nwEhTRGWK0j0t/th3DpMJjEuWiOq0tMf7L7KRoE4jr9TLOwVgkcTBwPh/KB?=
 =?us-ascii?Q?OrMf8yNW8sWPUzs2aItKLwpWcFrqYo+PTj1kK4O9sH5+R35AkjNrvh/Sic5g?=
 =?us-ascii?Q?PaiMi6pX6Lgj2UCPhv5cVz7rxH59x5ZKhNBcOX4XqS2m6VRKBapIwb/WgZfO?=
 =?us-ascii?Q?IUZFGyndlK5EBqHeuQqrZcU4oT6VyJh0guYm3RtS52BizMAGw1d2F9jySAQT?=
 =?us-ascii?Q?vMTlbQBvi0vRDr6qkB+bJG1H/cQbLA4Mi2YtfvjRAFEECMu6iXWJvQeUmlN2?=
 =?us-ascii?Q?ntVVMXi+QFbsp19TOma91g0f4MInK3h0GGcn0/QUgMNOXkiWD8ueZAb/IVb/?=
 =?us-ascii?Q?NfFuEFZyxT/hKL89xVj0QhrlsOeZTLCCq5DTmPpIFVTcWcrSOMD0e9GLT/It?=
 =?us-ascii?Q?eZT9+yYiyXLd+JPPikRFqLH76UIpLjRogBQd24raCIzfBI2C5CQdHG1iucCS?=
 =?us-ascii?Q?lOuGqxxtSazzRBu1jXUPw75t7JC+cJo26OeAC8UTbiiBOWzA4PCZsvFhwRft?=
 =?us-ascii?Q?zikFQ9gaL8BP0ZTV9SuH//HjEX1OCyOQbwPx6fimEHQJbxYQG8o1myeTmRGu?=
 =?us-ascii?Q?uCyWHrgsXlUK3RwIhPMMCs99vdcCse0gZdYAzp6AGU5BR1zCdWFYkVkd7xcT?=
 =?us-ascii?Q?xhI1SS7yqikenrLWunpzp1R9IbClJNfJGs3H+wfJGZLdZkwjEBoy/WUOWgox?=
 =?us-ascii?Q?rZvhTREi2SWuCoWfI1ZJrg5+vkqjQPd5CgH4jesMemFHqEBEtF6Q8mizTqng?=
 =?us-ascii?Q?8rKAjMbzPKhIGX9zq4eXPg0uqji5zfcRhRXLImXW8+cfQyFlf5bAHF9GYa+C?=
 =?us-ascii?Q?Y08ZZ8Q4gbouQJWE98ZgYlFNrhmaOqYW5Obv5MCZHiV1q/Ll0xxWSWwekcc1?=
 =?us-ascii?Q?y7xlc9Nts4MNChSIVctWKm/kPINlAPkha0SdxdfCc0EwnSiA1JEVCjdrGdzc?=
 =?us-ascii?Q?APP0XnOkRijBW4NCTFN7WgpgGb3tFgyDWqQXV5jLhFax7fv69O7ZLu/bw/nw?=
 =?us-ascii?Q?vTjsa+QnvhfQlmplTwfukd8AP2ms2FW39b3bzPd/7eLje99Jqg1Jrn9jYV3w?=
 =?us-ascii?Q?1dL4CsAiXXO6wE0apyjEDJSX3pP6hILLhoVVnDQRwU3prS4wizmX917wthQV?=
 =?us-ascii?Q?yWZdP6rWH8JiwF/2oRcJJFeAP7yL+o4GDLfDFCHX+fgyi/XhRN/hRHszZah5?=
 =?us-ascii?Q?/0o0v5pFxs2I6hRnP7R9cyKsHvRZ8U8jD87CaGX3ZhVksIAMUSfQ3kXJwg1y?=
 =?us-ascii?Q?864eF/wPxZVaS5UrudJAzK0VqokHBaVETrtk8wfvvDqitWxCxrkwM1WwHxoH?=
 =?us-ascii?Q?vGezNu4W8B4mVD/EXhD0XSN5AdVM+mI8SntjrvO2hBEoHUPHNjWpDJa34tdT?=
 =?us-ascii?Q?vYPoJInJr1hMvd2OFm08HRtHfBBeTW4RksJvnN5elQMVgYO0TBiCO7lZMprj?=
 =?us-ascii?Q?VphiHm6OnA=3D=3D?=
X-Exchange-RoutingPolicyChecked: bBnqnzVUZZvLXGsnJhOqdnIRMyumHP8mQB8F7w5v0guBkDjupENWhv/iwiACXndETSpGXY0+xgLl68AFtYN7eekv+XTl78ZNkEE5Y2wQikHhoqFCCYgW1s8+MTyj7oL2YL3dpaQRXz+aNy5ijCWuz8QIMDFYVQ2XnB8aHhCvCrYuOntJp02rsz5WhHXlnK/BzJpeiMIYk7+li0kipbNiuRdQ5748+2QqDlhd+xGB0+o2ypc98tqgtMC9CHwq1i6HWOqYWmWSBFhBzd8QYCtfR6ew0E2SL4PfQ5DVIq9L+Le4wM3Rojc2cpQUq2QjMNQzEUoMGoGPB5327ySJvd/SPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3a31cf-eed7-48b5-4848-08deb631d712
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 05:37:11.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORLKyM7ZYbjNn/4i3aA6Io2iXjcjrkMJ1jj20vnb0A+1q2jPI0Ph/7DRDyHR56BzvaCovr1+9I4zjPaRvkxMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5299
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__flush_work" on:

commit: ce0e78544f0e36b457f7130aa69ed6787760c7b6 ("bpf: Use rcu_work in BTF teardown")
url: https://github.com/intel-lab-lkp/linux/commits/Justin-Suess/bpf-Limit-fields-used-in-btf_record_equal-comparisons/20260430-120417
patch link: https://lore.kernel.org/all/20260428201422.1518903-3-utilityemal77@gmail.com/
patch subject: [PATCH bpf-next 2/4] bpf: Use rcu_work in BTF teardown
in testcase: boot

config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605200724.c2adcd3c-lkp@intel.com



[  146.626030][  T116] BUG: KASAN: slab-use-after-free in __flush_work (workqueue.c:4315)
[  146.626925][  T116] Read of size 8 at addr ffff8882dde72080 by task udevd/116
[  146.627704][  T116]
[  146.628032][  T116] CPU: 1 UID: 0 PID: 116 Comm: udevd Not tainted 7.0.0+ #1 PREEMPT(full)
[  146.628041][  T116] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  146.628045][  T116] Call Trace:
[  146.628051][  T116]  <TASK>
[  146.628057][  T116]  dump_stack_lvl (dump_stack.c:94 dump_stack.c:120)
[  146.628071][  T116]  print_address_description+0x70/0x300
[  146.628079][  T116]  ? lock_acquire (trace/events/lock.h:24 (discriminator 21) locking/lockdep.c:5831 (discriminator 21))
[  146.628086][  T116]  ? __flush_work (workqueue.c:4315)
[  146.628093][  T116]  print_report (kasan/report.c:482)
[  146.628097][  T116]  ? __virt_addr_valid (linux/rcupdate.h:963 linux/mmzone.h:2279 x86/mm/physaddr.c:54)
[  146.628103][  T116]  ? __flush_work (workqueue.c:4315)
[  146.628107][  T116]  ? __flush_work (workqueue.c:4315)
[  146.628111][  T116]  kasan_report (kasan/report.c:595)
[  146.628120][  T116]  ? __flush_work (workqueue.c:4315)
[  146.628127][  T116]  __flush_work (workqueue.c:4315)
[  146.628133][  T116]  ? __pfx___flush_work (linux/rcupdate.h:867 (discriminator 7))
[  146.628138][  T116]  ? flush_rcu_work (workqueue.c:4412)
[  146.628142][  T116]  ? lock_release (locking/lockdep.c:5889 locking/lockdep.c:5875)
[  146.628146][  T116]  ? __mutex_unlock_slowpath (linux/instrumented.h:55 linux/atomic/atomic-instrumented.h:4480 locking/mutex.c:993)
[  146.628156][  T116]  ? __pfx___mutex_unlock_slowpath (usercopy_64.c:?)
[  146.628160][  T116]  ? trace_preempt_on (trace/events/preemptirq.h:53 (discriminator 21) trace/trace_preemptirq.c:120 (discriminator 21))
[  146.628167][  T116]  ? _find_next_bit (find_bit.c:157 (discriminator 2))
[  146.628175][  T116]  ? lock_is_held_type (locking/lockdep.c:5601 locking/lockdep.c:5940)
[  146.628182][  T116]  ? __might_resched (sched/core.c:9127 (discriminator 1))
[  146.628190][  T116]  flush_rcu_work (workqueue.c:4375 workqueue.c:4413)
[  146.628195][  T116]  btf_module_notify (bpf/btf.c:8454)
[  146.628212][  T116]  notifier_call_chain (notifier.c:85)
[  146.628220][  T116]  blocking_notifier_call_chain (notifier.c:380 notifier.c:368)
[  146.628227][  T116]  do_init_module (module/main.c:3202)
[  146.628238][  T116]  ? __pfx_do_init_module (trace/events/module.h:50 (discriminator 1))
[  146.628242][  T116]  ? load_module (module/main.c:2528 module/main.c:2523 module/main.c:3575)
[  146.628247][  T116]  ? kfree (linux/kasan.h:235 slub.c:2689 slub.c:6246 slub.c:6561)
[  146.628256][  T116]  load_module (module/main.c:3580)
[  146.628266][  T116]  ? __pfx_load_module (module/main.c:3020)
[  146.628272][  T116]  ? __pfx_kernel_read_file (??:?)
[  146.628278][  T116]  ? userfaultfd_unmap_complete (userfaultfd.c:864)
[  146.628286][  T116]  ? __pfx_generic_file_mmap_prepare (filemap.c:3995)
[  146.628296][  T116]  init_module_from_file (module/main.c:3777)
[  146.628302][  T116]  ? __pfx_init_module_from_file (module/main.c:3634)
[  146.628312][  T116]  ? idempotent_init_module (linux/spinlock.h:390 module/main.c:3688 module/main.c:3788)
[  146.628317][  T116]  ? rcu_is_watching (x86/include/asm/atomic.h:23 linux/atomic/atomic-arch-fallback.h:457 linux/context_tracking.h:128 rcu/tree.c:752)
[  146.628323][  T116]  ? trace_preempt_on (trace/events/preemptirq.h:53 (discriminator 21) trace/trace_preemptirq.c:120 (discriminator 21))
[  146.628327][  T116]  ? preempt_count_sub (sched/core.c:5873 (discriminator 2) sched/core.c:5870 (discriminator 2) sched/core.c:5892 (discriminator 2))
[  146.628334][  T116]  idempotent_init_module (module/main.c:3789)
[  146.628341][  T116]  ? __pfx_idempotent_init_module (module/main.c:3778)
[  146.628351][  T116]  ? security_capable (security.c:660 (discriminator 20))
[  146.628358][  T116]  __x64_sys_finit_module (module/main.c:3815 module/main.c:3799 module/main.c:3799)
[  146.628364][  T116]  do_syscall_64 (x86/entry/syscall_64.c:63 x86/entry/syscall_64.c:94)
[  146.628372][  T116]  ? trace_hardirqs_on_prepare (trace/trace_preemptirq.c:63 (discriminator 1) trace/trace_preemptirq.c:59 (discriminator 1))
[  146.628376][  T116]  ? do_syscall_64 (linux/irq-entry-common.h:285 (discriminator 1) linux/entry-common.h:330 (discriminator 1) x86/entry/syscall_64.c:100 (discriminator 1))
[  146.628380][  T116]  ? do_syscall_64 (linux/irq-entry-common.h:285 (discriminator 1) linux/entry-common.h:330 (discriminator 1) x86/entry/syscall_64.c:100 (discriminator 1))
[  146.628383][  T116]  ? exc_page_fault (x86/mm/fault.c:1474 x86/mm/fault.c:1527)
[  146.628387][  T116]  ? __lock_release+0x5d/0x1b0
[  146.628391][  T116]  ? handle_mm_fault (memory.c:6604 (discriminator 1) memory.c:6744 (discriminator 1))
[  146.628397][  T116]  ? exc_page_fault (x86/mm/fault.c:1474 x86/mm/fault.c:1527)
[  146.628401][  T116]  ? rcu_is_watching (x86/include/asm/atomic.h:23 linux/atomic/atomic-arch-fallback.h:457 linux/context_tracking.h:128 rcu/tree.c:752)
[  146.628405][  T116]  ? trace_preempt_on (trace/events/preemptirq.h:53 (discriminator 21) trace/trace_preemptirq.c:120 (discriminator 21))
[  146.628408][  T116]  ? do_syscall_64 (linux/randomize_kstack.h:58 x86/entry/syscall_64.c:92)
[  146.628412][  T116]  ? preempt_count_sub (sched/core.c:5873 (discriminator 2) sched/core.c:5870 (discriminator 2) sched/core.c:5892 (discriminator 2))
[  146.628417][  T116]  ? do_syscall_64 (linux/randomize_kstack.h:58 x86/entry/syscall_64.c:92)
[  146.628421][  T116]  ? irqentry_exit (linux/irq-entry-common.h:280 linux/irq-entry-common.h:325 entry/common.c:162)
[  146.628426][  T116]  entry_SYSCALL_64_after_hwframe (x86/entry/entry_64.S:121)
[  146.628432][  T116] RIP: 0033:0x7fa4ddc65b99
[  146.628439][  T116] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 12 0c 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	ret
  33:	48 8b 0d c7 12 0c 00 	mov    0xc12c7(%rip),%rcx        # 0xc1301
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	ret
   9:	48 8b 0d c7 12 0c 00 	mov    0xc12c7(%rip),%rcx        # 0xc12d7
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W
[  146.628444][  T116] RSP: 002b:00007ffe04c429e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  146.628450][  T116] RAX: ffffffffffffffda RBX: 00005645ffd83ba0 RCX: 00007fa4ddc65b99
[  146.628453][  T116] RDX: 0000000000000000 RSI: 00007fa4ddd3e1e3 RDI: 0000000000000007
[  146.628456][  T116] RBP: 0000000000000000 R08: 0000000000000000 R09: 00005645ffd83ba0
[  146.628459][  T116] R10: 0000000000000007 R11: 0000000000000246 R12: 00007fa4ddd3e1e3
[  146.628461][  T116] R13: 0000000000020000 R14: 00007ffe04c42ae0 R15: 0000000000000000
[  146.628469][  T116]  </TASK>
[  146.628471][  T116]
[  146.634074][  T123] ata2: found unknown device (class 0)
[  146.637503][  T116] Allocated by task 116:
[  146.637516][  T116]  kasan_save_stack (kasan/common.c:57)
[  146.637532][  T116]  kasan_save_track (kasan/common.c:78)
[  146.637537][  T116]  __kasan_kmalloc (kasan/common.c:398 kasan/common.c:415)
[  146.637542][  T116]  btf_parse_module (linux/slab.h:950 linux/slab.h:1188 bpf/btf.c:6493)
[  146.637549][  T116]  btf_module_notify (bpf/btf.c:8371)
[  146.637554][  T116]  notifier_call_chain (notifier.c:85)
[  146.637561][  T116]  blocking_notifier_call_chain_robust (notifier.c:120 notifier.c:345 notifier.c:333)
[  146.644370][  T123] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[  146.644393][  T116]  load_module (module/main.c:3357 module/main.c:3542)
[  146.700116][  T116]  init_module_from_file (module/main.c:3777)
[  146.705423][  T116]  idempotent_init_module (module/main.c:3789)
[  146.706087][  T116]  __x64_sys_finit_module (module/main.c:3815 module/main.c:3799 module/main.c:3799)
[  146.706706][  T116]  do_syscall_64 (x86/entry/syscall_64.c:63 x86/entry/syscall_64.c:94)
[  146.707263][  T116]  entry_SYSCALL_64_after_hwframe (x86/entry/entry_64.S:121)
[  146.713649][  T116]
[  146.713982][  T116] Freed by task 26:
[  146.714445][  T116]  kasan_save_stack (kasan/common.c:57)
[  146.715029][  T116]  kasan_save_track (kasan/common.c:78)
[  146.715582][  T116]  kasan_save_free_info (kasan/generic.c:584)
[  146.716161][  T116]  __kasan_slab_free (kasan/common.c:253 kasan/common.c:285)
[  146.721405][  T116]  kfree (linux/kasan.h:235 slub.c:2689 slub.c:6246 slub.c:6561)
[  146.721927][  T116]  process_one_work (workqueue.c:3302)
[  146.722483][  T116]  worker_thread (workqueue.c:3385 workqueue.c:3466)
[  146.723018][  T116]  kthread (kthread.c:436)
[  146.723505][  T116]  ret_from_fork (x86/kernel/process.c:158)
[  146.724036][  T116]  ret_from_fork_asm (x86/entry/entry_64.S:245)
[  146.724581][  T116]
[  146.724896][  T116] Last potentially related work creation:
[  146.725544][  T116]  kasan_save_stack (kasan/common.c:57)
[  146.726082][  T116]  kasan_record_aux_stack (kasan/generic.c:556)
[  146.726665][  T116]  insert_work (workqueue.c:2226)
[  146.727162][  T116]  __queue_work (workqueue.c:2381)
[  146.727687][  T116]  rcu_work_rcufn (workqueue.c:2649)
[  146.728204][  T116]  rcu_do_batch (rcu/tree.c:2617)
[  146.728763][  T116]  rcu_core (rcu/tree.c:2869)
[  146.729259][  T116]  handle_softirqs (softirq.c:622)
[  146.729810][  T116]  __irq_exit_rcu (softirq.c:656 softirq.c:496 softirq.c:735)
[  146.730337][  T116]  irq_exit_rcu ()
[  146.733532][  T116]  sysvec_apic_timer_interrupt+0x6d/0xb0
[  146.734178][  T116]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[  146.734850][  T116]
[  146.735169][  T116] Second to last potentially related work creation:
[  146.737858][  T116]  kasan_save_stack (kasan/common.c:57)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260520/202605200724.c2adcd3c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

