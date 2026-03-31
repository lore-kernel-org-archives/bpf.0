Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A82276058;
	Tue, 31 Mar 2026 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946796; cv=fail; b=VyZXwOzgBGCQhhftO7tst2OQOkNKlNNuc8PD/bl+d+pI+hemjLPvAJ2cbfd0jHlLKSYLGHLuMnrixxJAcXKrnwfLfrps7+FoznH80827V64t9rnRjNmsmWtLvK2Uyn3SxpVZHssqqcsbPrn60GtDiplnVWFvd46gCQiIrUBET3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946796; c=relaxed/simple;
	bh=9CRyaHIDZmLQablzBf1lP8ljId04hBpVGwjqUo8bjQw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UYTwDoaxCFCKleCAnA4Phc9lWV42Wg9e3pMH50MQfGKOP34RsabpFF0INJq3HIoYE5RvF31nyk9dPkrK1uCrXxCuVKk7m+oFWE2/VlkKZWcu43iRPnySql+XjXbu3XiCRYg2B4R0vbTj843yg453GFRnRMnNmCddHw4o4olY5RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fAuD73St; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fAuD73St"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774946792; x=1806482792;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=9CRyaHIDZmLQablzBf1lP8ljId04hBpVGwjqUo8bjQw=;
  b=fAuD73StAaZTo6xQqYbOMwLvlXl9eRHNfAsRwRqNSQih03Z145udbmIF
   oUJb4z+d+E9jNGmCtiNmtTgvDp9VEdAsmsf7AqJ7mHaaw3caoPKh3wQcd
   Y3ZcSC5F01ELsil3aKYNZMiFru0zIoagTNfdz43XpTedS3Mbfhf623o7Q
   OXl1Trj2FNlFxIIIGDqhuWlXK4H0ooS51Xp6Yad7dcFTPNARP04DefHQr
   aodUXeS2V+sFHk6x5Uea7g8z+3vwAkHtnAVJzZXwDODtYBC/YGhr2cTcI
   1ycDD7yK5YUAVe7/U04GcXIZXl13MfocT5fotZ0CHIxAEMNgb484vr7R8
   Q==;
X-CSE-ConnectionGUID: 2DoafonkSMaSj7ijQ2AhAw==
X-CSE-MsgGUID: N+zjeq9lR4ava3/xZubyWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76062643"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76062643"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:46:30 -0700
X-CSE-ConnectionGUID: +X6Cox+hSsKt9WxX/9d1AA==
X-CSE-MsgGUID: PXiy7jy1Q7GiQC3DjVhB6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="226269705"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 01:46:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:46:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 01:46:29 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 01:46:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gi+poWVKNF0BswyELZKUKkrO3nn5rCO1wVrzB3I+afxWn22OR2fmG9aQOv5J1/g4y79wHoLCpjdSvmvskOKy+UuRYPpFW8UclqP+bNeUg7PpSqQ0dCU8J3YaTZFqbculP5TeLtIaiOH8fV7Te1oMk4Aytrop0CmvMRK9gfcmOq6Tw/2XwQmOeEBjn36MJsEmwvBAwPF9Ce/PJx+UB2OElnnYS0Niphh0lo+vaeQVscvg+TOMlnLiPgGXjQtH+Iiee3GNiV7nIX0E4d6Kg5Oh34b1XlQTDZ6HsL8AiFG+basZAigtnnPN4rRKGUvMEZKNN3FKth/GljscFyt/WS46dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhAawhplh2zpR2WsrFr9Ija7wthIo1taE/WY5RstSfk=;
 b=IxX/ur8a0NXEUv0/i7v4ExDe9+x1n5yyp/InHVs/j/4ByyGJnMbm0uyw7L5ltM2H/1AlybXCkDUgNHZkFczuBgkJt1QYO92eNKVfv3eedUXwuk+/mu9hsS2HSWzGOMtetsdhSZ85g9Q3075sbhRBSDKa1qGGNpBVM7ivTpedY/5WF+ekNJXe+xx3Aox13Q70cmgimKnJ5+X4hTEDv2nIpWoHtxIRzozdl6AXL1ccC7365IdOp/R3X4rlIcl+ytWYfIpKz5N4bEcYfAT2PEsPzYAUwdgsqFWxA/61/TIg3PMoTXWh981DSsK2Hp/Y/RvsxAoLh8SLjI/TvlYpHmDs8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 08:46:24 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9769.006; Tue, 31 Mar 2026
 08:46:24 +0000
Date: Tue, 31 Mar 2026 16:46:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leo Yan <leo.yan@arm.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Quentin Monnet
	<qmo@kernel.org>, <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
	<eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Lorenz Bauer <lmb@isovalent.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	"Bill Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	"Arnaldo Carvalho de Melo" <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, "Ian Rogers" <irogers@google.com>, James Clark
	<james.clark@linaro.org>, Kees Cook <kees@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<llvm@lists.linux.dev>, Leo Yan <leo.yan@arm.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/6] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS
Message-ID: <202603311614.b25286d0-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260323-tools_build_fix_zero_init_bpf_only-v1-1-d1cfad2f4cd1@arm.com>
X-ClientProxiedBy: TP0P295CA0041.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::7)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM6PR11MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a97764-7b97-4a54-c4a5-08de8f01fcf7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2DlJVgDBmHwvjhtlCq1E7fCtq4DWT62cY8nW/ftcXAZabgqaH3ZlcDGpVxFJP+ocg9cjcNyadtHl78dKEP0qLc08vWvn2ZfzRbvOAxyCaFyp52B0KJVaTYhpuQ9TMPPsxeC3wlT6VtlcXeVYuQImvkp6DCSHell9/bHwhLKkcti42gu5MJ5vYRNuaNG1iKx6brSMhMWR4WkXeiK56U7IoLZFbqWsod+yG2uVLYjS+fsz4sDqe1CSiXh3Eazesot+dHxVgDRBKROMiL8tQORM8htmkvEAOgh3T2z9keUJqpT0vYMqvAmitNOvl33ByWJgiq0WQtkaSLZLF6EAO+iTeL8XldLeWoB/nwtCescGkWejMZtFrZ4zkgEy3LcN5MnbnsSTQ6zfDNgX3uPt3zaiPi5RapeayZ/tnQsdMMVUfkzbEbJeMrOPPm38MZnCIEPA3K6stOd3N/fQjHaLF9FY3sY4JHhp7C11RdA4QvKUFQGaRTR9l80MMJdlU0mQoDDDaA8MJku9wSqUID/GfHkizcLa62z2naiAj4YQmn9kJtSeXFGhJb9J3EgOwFF/R0E+pfQ4jew/STR4vhYl3Scl6pMRS0Abqdj7TlkvtFT7dNgftd2cBE+zCtKSixyDCVdUz7NYDEIJ6tMPDts4P4LYmizFUkAkEhL8tOJg+OPg9WlU0naDEd4MhF/mpTPYwHdZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69HdBNwDSdzWZWTc7EYeMxL1lFh7vKVP/0gsGRLnYMi79JD7i5VdGd7r6LnF?=
 =?us-ascii?Q?y/Mb4WbkEWM3dM3l7d7QzTjePLATWb3E7jL2GabtcGc4ZN5SUE2PDviBIo3F?=
 =?us-ascii?Q?vINx75riZzGTjrMzFJl6Mqv9DPiPqJEPJsOB2sT9Giizing/hLTiz7MpVbPo?=
 =?us-ascii?Q?wbRnJKsybWzsXBZIAlbD+L5aRDJMEtutzKciUUQdPj7vbq9Sc2uBIitg99bV?=
 =?us-ascii?Q?XBBYfcH4Byssl5AQ5bL1jBSvWDv+QQtsO6wIBv1TWFneEy2IEtkvg/dbFtGp?=
 =?us-ascii?Q?aBWoRoYlZwFS9bwTrmXJwUW/hT7rFFVPuJszII4+4CAFzkKsvDtIGQybeA3B?=
 =?us-ascii?Q?M5UwrP5j0fVGhYzoQSDy4lAim3I+qK8oB4JoKNk/8xxJetjzmRVqlPZPKRdu?=
 =?us-ascii?Q?lA9VrX3jx02T5MToulLjkQDL+/8zcoOwUxZk5vdw1B4tWR0eg/ydJtEKFEJL?=
 =?us-ascii?Q?sQkiii4Ysbe61UizJ9DXwyGvyXVEdAurro74ckfqRalx8SlCtRMg8FLfWCJ5?=
 =?us-ascii?Q?NZmgYqSPpwfKgzMkGZuMqqqrZlwS6M0jpX6HRT5+7xl8AizVBlXuduUllOMZ?=
 =?us-ascii?Q?XwNvQvZ2XvuUiPGGOlGmk3y4B4f1JWzRu2+sxlQc7WzIoPRBJnxXgfXBkjQt?=
 =?us-ascii?Q?3VSHZbkCKklDziBizBhvD0FB5uQKRfobt7WPZJ5vEiHBuTx9R9tvc91x+kuZ?=
 =?us-ascii?Q?X+45IGHlphOpZ+tG9DUGnWIOWszNwvFAkZdvGOmZW16o4+1huDaPNqeYTCsl?=
 =?us-ascii?Q?4z60RTdKPLFQ8+gF9rugPJO7xSilRIazTnwm0wVzuZK0SNV2ocRK9f0utgLo?=
 =?us-ascii?Q?aVmYzFLjrLePb3so+mz4//3yt7ib+3kKHOl+suM5VFTVzrNMNdsu75afyAKk?=
 =?us-ascii?Q?D48YxUhDVfw5PJLdarU59JXAiy0ptig4Q7s2qkHVFhK77gjiuSOSWwWfiY5C?=
 =?us-ascii?Q?a0WYoBroStGmrlJAHRb0FIyMu1S7/CwiJ4Gov3tUlB57C/fZrxnmJSOJ72Sk?=
 =?us-ascii?Q?ldM5pwEmEs34OLLkchPyl5QC6JpT7qSPCEzKrUkbZA74AUKaJE/Yqg+s39/n?=
 =?us-ascii?Q?HVQE7n+t6CvG2/KeyhaM3NzolzDBmXn7XXEXxjBxH7d10++ailk750NaOxUU?=
 =?us-ascii?Q?YuLnWfmLv2GHRJT3+x0qiNgtujRQYrGUU5nhVTSbiGCVVymSlEWw+h8K82Dc?=
 =?us-ascii?Q?GmRwabHWa8ifB5q/OcGfyJcpcO/B+HxKs/Q75nxka+expfwKhE3FwLuCDXSu?=
 =?us-ascii?Q?OJn+eX+s/hrnM66oUmoA1KyxwunZ/03jtDFKq8NUS3/fbDxdApTgcjLrc2As?=
 =?us-ascii?Q?RgsDfyojpg55KdlwOd3oSD85m299I61+kKay5cALRe2HyFcA3MlzaA9A+Sti?=
 =?us-ascii?Q?8ZkhTkKL0UsgQokj+PxYPWVWtPSmxctbhgp4CMWI6yH++jHUtM3nBkC/xnww?=
 =?us-ascii?Q?VUzXbz0t6EbEKvZxTYbbonLiNPP75dc/cH0RhLmADMGgqLsDXbopZbRE79BR?=
 =?us-ascii?Q?gThVpLZlbknfxTkotO43t3UfCtj6wNMsE4vB9Pxh+HCa6BJe8sIcNt/NIEZ9?=
 =?us-ascii?Q?KAdpmcj8O0jkS8XsuZkknw02k8KuFx8bojBLPYSksBUj/8xUC8FIErASylWt?=
 =?us-ascii?Q?BjsZzu0kdX8a6LSsHGYsxv7ksTJ02TItbG9CejebaNFKuuxFJteGDMAGtbMp?=
 =?us-ascii?Q?uJrffNohRJxN8xSQLx7/zvRFaXgZGWRv81f/n9hCixOlTDTFsDtYnMfvg9pE?=
 =?us-ascii?Q?QUSV6iwsQA=3D=3D?=
X-Exchange-RoutingPolicyChecked: j4ElLWpi1cA4j6wm6kJLZgMhYt8cUzjrACTulc6QT3ootJP9R/n+ZjlXaxMQ1u7NrK84Jwe9X3SeFB9A1YKJH4F1vsFXZqjXNZEqsTYz37cxFn3eSQgw3j6pPSBYVqC/IDjFimvWoxX7rwoUNEUcLPzDGb+AZOVnaUJuW+roIuW2wbKB5RV3vxKx7knzCtAQN1GmK0/JEHiq4ECXq42FVcnYoBPM2dLIuy63Qr9XjHtJINfbhZkkCLjfwDVwNJbl5frJqX9HdPblUCnT8aNv1PZUAu5mciRzIJob8fOdoUyFUgV2hevNTlkqAwg5dDMbcHiPjqG/TW8iYYMAG8ENRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a97764-7b97-4a54-c4a5-08de8f01fcf7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:46:23.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+O0yAJreIxWbxcWfUaxLrXzLpdVzO0AoR4NroddNc7oTGh1X6px2ofH5NNRZOL1aqTPnQWWQkzrqK4Wwva41w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "perf-sanity-tests.perf.make.fail" on:

commit: 8c5eeed210518013e32a716dc6981eaafe62cecc ("[PATCH 1/6] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS")
url: https://github.com/intel-lab-lkp/linux/commits/Leo-Yan/bpftool-Avoid-adding-EXTRA_CFLAGS-to-HOST_CFLAGS/20260324-002952
patch link: https://lore.kernel.org/all/20260323-tools_build_fix_zero_init_bpf_only-v1-1-d1cfad2f4cd1@arm.com/
patch subject: [PATCH 1/6] bpftool: Avoid adding EXTRA_CFLAGS to HOST_CFLAGS

in testcase: perf-sanity-tests
version: 
with following parameters:

	perf_compiler: gcc
	group: group-02



config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603311614.b25286d0-lkp@intel.com


gcc march setting is skylake
valid
make PERF failed



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260331/202603311614.b25286d0-lkp@intel.com


[  148.405137][  T413] make PERF failed
[  148.405153][  T413] 
[  148.528240][  T413] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-cfl-e1/perf-sanity-tests-group-02-gcc-debian-13-x86_64-20250902.cgz-8c5eeed21051-20260329-11492-7bacvi-4.yaml&job_state=post_run -O /dev/null
[  148.528257][  T413] 
[  150.586474][  T413] kill 4535 vmstat --timestamp -n 1 
[  150.586489][  T413] 
[  150.610850][  T413] kill 4531 dmesg --follow --decode 
[  150.610863][  T413] 
[  150.643336][  T413] wait for background processes: 4546
[  150.643350][  T413] 
[  150.654389][  T413] monitor
[  150.654454][  T413] 
[  152.524272][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): warning: relocation against `__asan_option_detect_stack_use_after_return' in read-only section `.text'
[  152.524288][  T415] 
[  152.566201][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `ring_buffer_read_head':
[  152.566213][  T415] 
[  152.597937][  T415] libbpf.c:(.text+0xbd): undefined reference to `__asan_option_detect_stack_use_after_return'
[  152.598003][  T415] 
[  152.617766][  T415] /usr/bin/ld: libbpf.c:(.text+0xca): undefined reference to `__asan_stack_malloc_0'
[  152.617841][  T415] 
[  152.633067][  T415] /usr/bin/ld: libbpf.c:(.text+0x135): undefined reference to `__asan_report_store8'
[  152.633082][  T415] 
[  152.648998][  T415] /usr/bin/ld: libbpf.c:(.text+0x16c): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.649011][  T415] 
[  152.665327][  T415] /usr/bin/ld: libbpf.c:(.text+0x19b): undefined reference to `__ubsan_handle_pointer_overflow'
[  152.665340][  T415] 
[  152.685138][  T415] /usr/bin/ld: libbpf.c:(.text+0x229): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.685223][  T415] 
[  152.701584][  T415] /usr/bin/ld: libbpf.c:(.text+0x25d): undefined reference to `__asan_report_load1'
[  152.701596][  T415] 
[  152.717188][  T415] /usr/bin/ld: libbpf.c:(.text+0x280): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.717201][  T415] 
[  152.733842][  T415] /usr/bin/ld: libbpf.c:(.text+0x2b4): undefined reference to `__asan_report_store1'
[  152.733855][  T415] 
[  152.750145][  T415] /usr/bin/ld: libbpf.c:(.text+0x2e8): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.750158][  T415] 
[  152.767259][  T415] /usr/bin/ld: libbpf.c:(.text+0x31f): undefined reference to `__asan_report_load2'
[  152.767272][  T415] 
[  152.783448][  T415] /usr/bin/ld: libbpf.c:(.text+0x34f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.783461][  T415] 
[  152.805242][  T415] /usr/bin/ld: libbpf.c:(.text+0x386): undefined reference to `__asan_report_store2'
[  152.805264][  T415] 
[  152.830636][  T415] /usr/bin/ld: libbpf.c:(.text+0x3bb): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.830667][  T415] 
[  152.854098][  T415] /usr/bin/ld: libbpf.c:(.text+0x3f2): undefined reference to `__asan_report_load4'
[  152.854165][  T415] 
[  152.875025][  T415] /usr/bin/ld: libbpf.c:(.text+0x421): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.875102][  T415] 
[  152.892108][  T415] /usr/bin/ld: libbpf.c:(.text+0x458): undefined reference to `__asan_report_store4'
[  152.892121][  T415] 
[  152.908307][  T415] /usr/bin/ld: libbpf.c:(.text+0x48c): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.908321][  T415] 
[  152.925359][  T415] /usr/bin/ld: libbpf.c:(.text+0x4ad): undefined reference to `__asan_report_load8'
[  152.925372][  T415] 
[  152.941621][  T415] /usr/bin/ld: libbpf.c:(.text+0x4dc): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  152.941634][  T415] 
[  152.958881][  T415] /usr/bin/ld: libbpf.c:(.text+0x4fd): undefined reference to `__asan_report_store8'
[  152.958893][  T415] 
[  152.975314][  T415] /usr/bin/ld: libbpf.c:(.text+0x525): undefined reference to `__ubsan_handle_nonnull_arg'
[  152.975327][  T415] 
[  152.992213][  T415] /usr/bin/ld: libbpf.c:(.text+0x53b): undefined reference to `__ubsan_handle_nonnull_arg'
[  152.992225][  T415] 
[  153.008941][  T415] /usr/bin/ld: libbpf.c:(.text+0x574): undefined reference to `__asan_report_load8'
[  153.008953][  T415] 
[  153.027442][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `ring_buffer_write_tail':
[  153.027459][  T415] 
[  153.056398][  T415] libbpf.c:(.text+0x60c): undefined reference to `__asan_option_detect_stack_use_after_return'
[  153.056412][  T415] 
[  153.077091][  T415] /usr/bin/ld: libbpf.c:(.text+0x619): undefined reference to `__asan_stack_malloc_0'
[  153.077157][  T415] 
[  153.093563][  T415] /usr/bin/ld: libbpf.c:(.text+0x685): undefined reference to `__asan_report_store8'
[  153.093576][  T415] 
[  153.109942][  T415] /usr/bin/ld: libbpf.c:(.text+0x6be): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.109954][  T415] 
[  153.127345][  T415] /usr/bin/ld: libbpf.c:(.text+0x6ed): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.127358][  T415] 
[  153.144905][  T415] /usr/bin/ld: libbpf.c:(.text+0x77a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.144918][  T415] 
[  153.162260][  T415] /usr/bin/ld: libbpf.c:(.text+0x7ae): undefined reference to `__asan_report_load1'
[  153.162272][  T415] 
[  153.178623][  T415] /usr/bin/ld: libbpf.c:(.text+0x7d1): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.178635][  T415] 
[  153.195835][  T415] /usr/bin/ld: libbpf.c:(.text+0x805): undefined reference to `__asan_report_store1'
[  153.195848][  T415] 
[  153.212310][  T415] /usr/bin/ld: libbpf.c:(.text+0x839): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.212322][  T415] 
[  153.230822][  T415] /usr/bin/ld: libbpf.c:(.text+0x870): undefined reference to `__asan_report_load2'
[  153.230844][  T415] 
[  153.250191][  T415] /usr/bin/ld: libbpf.c:(.text+0x8a0): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.250204][  T415] 
[  153.273996][  T415] /usr/bin/ld: libbpf.c:(.text+0x8d7): undefined reference to `__asan_report_store2'
[  153.274078][  T415] 
[  153.297203][  T415] /usr/bin/ld: libbpf.c:(.text+0x90c): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.297280][  T415] 
[  153.315850][  T415] /usr/bin/ld: libbpf.c:(.text+0x943): undefined reference to `__asan_report_load4'
[  153.315862][  T415] 
[  153.332368][  T415] /usr/bin/ld: libbpf.c:(.text+0x972): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.332381][  T415] 
[  153.353127][  T415] /usr/bin/ld: libbpf.c:(.text+0x9a9): undefined reference to `__asan_report_store4'
[  153.353204][  T415] 
[  153.369725][  T415] /usr/bin/ld: libbpf.c:(.text+0x9dd): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.369738][  T415] 
[  153.390958][  T415] /usr/bin/ld: libbpf.c:(.text+0x9fe): undefined reference to `__asan_report_load8'
[  153.391034][  T415] 
[  153.407414][  T415] /usr/bin/ld: libbpf.c:(.text+0xa2d): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.407426][  T415] 
[  153.424708][  T415] /usr/bin/ld: libbpf.c:(.text+0xa4e): undefined reference to `__asan_report_store8'
[  153.424722][  T415] 
[  153.441033][  T415] /usr/bin/ld: libbpf.c:(.text+0xa76): undefined reference to `__ubsan_handle_nonnull_arg'
[  153.441046][  T415] 
[  153.458012][  T415] /usr/bin/ld: libbpf.c:(.text+0xa8c): undefined reference to `__ubsan_handle_nonnull_arg'
[  153.458024][  T415] 
[  153.474795][  T415] /usr/bin/ld: libbpf.c:(.text+0xac4): undefined reference to `__asan_report_load8'
[  153.474808][  T415] 
[  153.492885][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_kind':
[  153.492898][  T415] 
[  153.520374][  T415] libbpf.c:(.text+0xb3b): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.520387][  T415] 
[  153.536620][  T415] /usr/bin/ld: libbpf.c:(.text+0xb5f): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.536633][  T415] 
[  153.553800][  T415] /usr/bin/ld: libbpf.c:(.text+0xb9a): undefined reference to `__asan_report_load4'
[  153.553812][  T415] 
[  153.571695][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_vlen':
[  153.571708][  T415] 
[  153.602868][  T415] libbpf.c:(.text+0xbdd): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.602935][  T415] 
[  153.623604][  T415] /usr/bin/ld: libbpf.c:(.text+0xc01): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.623680][  T415] 
[  153.644939][  T415] /usr/bin/ld: libbpf.c:(.text+0xc3c): undefined reference to `__asan_report_load4'
[  153.645005][  T415] 
[  153.669856][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_kflag':
[  153.669869][  T415] 
[  153.701632][  T415] libbpf.c:(.text+0xc79): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.701696][  T415] 
[  153.722357][  T415] /usr/bin/ld: libbpf.c:(.text+0xc9d): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.722433][  T415] 
[  153.743349][  T415] /usr/bin/ld: libbpf.c:(.text+0xcd8): undefined reference to `__asan_report_load4'
[  153.743425][  T415] 
[  153.761840][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_int_encoding':
[  153.761855][  T415] 
[  153.790071][  T415] libbpf.c:(.text+0xff1): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.790083][  T415] 
[  153.806403][  T415] /usr/bin/ld: libbpf.c:(.text+0x101e): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.806416][  T415] 
[  153.823820][  T415] /usr/bin/ld: libbpf.c:(.text+0x1054): undefined reference to `__asan_report_load4'
[  153.823833][  T415] 
[  153.841973][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_int_bits':
[  153.841986][  T415] 
[  153.873985][  T415] libbpf.c:(.text+0x1095): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.874051][  T415] 
[  153.893178][  T415] /usr/bin/ld: libbpf.c:(.text+0x10c2): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  153.893191][  T415] 
[  153.910569][  T415] /usr/bin/ld: libbpf.c:(.text+0x10f8): undefined reference to `__asan_report_load4'
[  153.910582][  T415] 
[  153.935385][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_array':
[  153.935398][  T415] 
[  153.966668][  T415] libbpf.c:(.text+0x1130): undefined reference to `__ubsan_handle_pointer_overflow'
[  153.966733][  T415] 
[  153.991423][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_enum':
[  153.991435][  T415] 
[  154.022656][  T415] libbpf.c:(.text+0x116a): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.022732][  T415] 
[  154.040742][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_enum64':
[  154.040756][  T415] 
[  154.068478][  T415] libbpf.c:(.text+0x11a4): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.068491][  T415] 
[  154.086960][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_enum64_value':
[  154.086974][  T415] 
[  154.115361][  T415] libbpf.c:(.text+0x11e9): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.115373][  T415] 
[  154.131848][  T415] /usr/bin/ld: libbpf.c:(.text+0x1216): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  154.131861][  T415] 
[  154.155422][  T415] /usr/bin/ld: libbpf.c:(.text+0x124c): undefined reference to `__asan_report_load4'
[  154.155488][  T415] 
[  154.176858][  T415] /usr/bin/ld: libbpf.c:(.text+0x127b): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.176935][  T415] 
[  154.194544][  T415] /usr/bin/ld: libbpf.c:(.text+0x12a8): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  154.194556][  T415] 
[  154.212055][  T415] /usr/bin/ld: libbpf.c:(.text+0x12de): undefined reference to `__asan_report_load4'
[  154.212068][  T415] 
[  154.230118][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_members':
[  154.230131][  T415] 
[  154.257943][  T415] libbpf.c:(.text+0x131e): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.257955][  T415] 
[  154.276050][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_member_bit_offset':
[  154.276064][  T415] 
[  154.304796][  T415] libbpf.c:(.text+0x1385): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.304809][  T415] 
[  154.321294][  T415] /usr/bin/ld: libbpf.c:(.text+0x13d5): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  154.321307][  T415] 
[  154.338870][  T415] /usr/bin/ld: libbpf.c:(.text+0x13f9): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.338882][  T415] 
[  154.356326][  T415] /usr/bin/ld: libbpf.c:(.text+0x1434): undefined reference to `__asan_report_load4'
[  154.356339][  T415] 
[  154.372930][  T415] /usr/bin/ld: libbpf.c:(.text+0x146d): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  154.372943][  T415] 
[  154.390528][  T415] /usr/bin/ld: libbpf.c:(.text+0x1491): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.390541][  T415] 
[  154.407976][  T415] /usr/bin/ld: libbpf.c:(.text+0x14cc): undefined reference to `__asan_report_load4'
[  154.407988][  T415] 
[  154.426275][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_member_bitfield_size':
[  154.426288][  T415] 
[  154.455231][  T415] libbpf.c:(.text+0x1539): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.455243][  T415] 
[  154.471731][  T415] /usr/bin/ld: libbpf.c:(.text+0x1589): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  154.471744][  T415] 
[  154.489312][  T415] /usr/bin/ld: libbpf.c:(.text+0x15ad): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.489325][  T415] 
[  154.506778][  T415] /usr/bin/ld: libbpf.c:(.text+0x15e8): undefined reference to `__asan_report_load4'
[  154.506791][  T415] 
[  154.524860][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_params':
[  154.524874][  T415] 
[  154.552602][  T415] libbpf.c:(.text+0x1632): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.552615][  T415] 
[  154.570537][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_var':
[  154.570550][  T415] 
[  154.598006][  T415] libbpf.c:(.text+0x166c): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.598018][  T415] 
[  154.616091][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_var_secinfos':
[  154.616105][  T415] 
[  154.644362][  T415] libbpf.c:(.text+0x16a6): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.644375][  T415] 
[  154.662391][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `btf_decl_tag':
[  154.662404][  T415] 
[  154.696734][  T415] libbpf.c:(.text+0x16e0): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.696799][  T415] 
[  154.722075][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `str_has_sfx':
[  154.722088][  T415] 
[  154.754198][  T415] libbpf.c:(.text+0x1711): undefined reference to `__ubsan_handle_nonnull_arg'
[  154.754275][  T415] 
[  154.775171][  T415] /usr/bin/ld: libbpf.c:(.text+0x1737): undefined reference to `__ubsan_handle_nonnull_arg'
[  154.775257][  T415] 
[  154.799261][  T415] /usr/bin/ld: libbpf.c:(.text+0x1794): undefined reference to `__ubsan_handle_pointer_overflow'
[  154.799337][  T415] 
[  154.821855][  T415] /usr/bin/ld: libbpf.c:(.text+0x17b6): undefined reference to `__ubsan_handle_nonnull_arg'
[  154.821931][  T415] 
[  154.842879][  T415] /usr/bin/ld: libbpf.c:(.text+0x17cc): undefined reference to `__ubsan_handle_nonnull_arg'
[  154.842955][  T415] 
[  154.868783][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_reallocarray':
[  154.868796][  T415] 
[  154.901584][  T415] libbpf.c:(.text+0x180c): undefined reference to `__asan_option_detect_stack_use_after_return'
[  154.901660][  T415] 
[  154.919084][  T415] /usr/bin/ld: libbpf.c:(.text+0x1819): undefined reference to `__asan_stack_malloc_0'
[  154.919101][  T415] 
[  154.940103][  T415] /usr/bin/ld: libbpf.c:(.text+0x189c): undefined reference to `__asan_report_store8'
[  154.940170][  T415] 
[  154.956712][  T415] /usr/bin/ld: libbpf.c:(.text+0x18d6): undefined reference to `__asan_report_load8'
[  154.956726][  T415] 
[  154.981819][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_strlcpy':
[  154.981832][  T415] 
[  155.009977][  T415] libbpf.c:(.text+0x1993): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.009991][  T415] 
[  155.026498][  T415] /usr/bin/ld: libbpf.c:(.text+0x19d8): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.026517][  T415] 
[  155.044174][  T415] /usr/bin/ld: libbpf.c:(.text+0x1a04): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.044187][  T415] 
[  155.061609][  T415] /usr/bin/ld: libbpf.c:(.text+0x1a37): undefined reference to `__asan_report_load1'
[  155.061622][  T415] 
[  155.078150][  T415] /usr/bin/ld: libbpf.c:(.text+0x1a55): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.078162][  T415] 
[  155.095715][  T415] /usr/bin/ld: libbpf.c:(.text+0x1a88): undefined reference to `__asan_report_store1'
[  155.095728][  T415] 
[  155.112291][  T415] /usr/bin/ld: libbpf.c:(.text+0x1ad0): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.112303][  T415] 
[  155.129860][  T415] /usr/bin/ld: libbpf.c:(.text+0x1afc): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.129874][  T415] 
[  155.147289][  T415] /usr/bin/ld: libbpf.c:(.text+0x1b2f): undefined reference to `__asan_report_load1'
[  155.147302][  T415] 
[  155.163816][  T415] /usr/bin/ld: libbpf.c:(.text+0x1b6c): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.163829][  T415] 
[  155.181355][  T415] /usr/bin/ld: libbpf.c:(.text+0x1b98): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.181367][  T415] 
[  155.198729][  T415] /usr/bin/ld: libbpf.c:(.text+0x1bcb): undefined reference to `__asan_report_store1'
[  155.198742][  T415] 
[  155.217039][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_is_mem_zeroed':
[  155.217052][  T415] 
[  155.245627][  T415] libbpf.c:(.text+0x1c4a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.245639][  T415] 
[  155.261940][  T415] /usr/bin/ld: libbpf.c:(.text+0x1c7e): undefined reference to `__asan_report_load1'
[  155.261952][  T415] 
[  155.278472][  T415] /usr/bin/ld: libbpf.c:(.text+0x1cb4): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.278484][  T415] 
[  155.295947][  T415] /usr/bin/ld: libbpf.c:(.text+0x1ce1): undefined reference to `__ubsan_handle_sub_overflow'
[  155.295960][  T415] 
[  155.314772][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_validate_opts':
[  155.314785][  T415] 
[  155.343338][  T415] libbpf.c:(.text+0x1d89): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.343350][  T415] 
[  155.361307][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_err':
[  155.361320][  T415] 
[  155.388978][  T415] libbpf.c:(.text+0x1e20): undefined reference to `__ubsan_handle_negate_overflow'
[  155.388990][  T415] 
[  155.405327][  T415] /usr/bin/ld: libbpf.c:(.text+0x1e45): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.405339][  T415] 
[  155.422701][  T415] /usr/bin/ld: libbpf.c:(.text+0x1e7b): undefined reference to `__asan_report_store4'
[  155.422713][  T415] 
[  155.440936][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_err_errno':
[  155.440949][  T415] 
[  155.469235][  T415] libbpf.c:(.text+0x1ecd): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.469248][  T415] 
[  155.490277][  T415] /usr/bin/ld: libbpf.c:(.text+0x1f03): undefined reference to `__asan_report_load4'
[  155.490364][  T415] 
[  155.511531][  T415] /usr/bin/ld: libbpf.c:(.text+0x1f1f): undefined reference to `__ubsan_handle_negate_overflow'
[  155.511607][  T415] 
[  155.537462][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_err_ptr':
[  155.537475][  T415] 
[  155.565492][  T415] libbpf.c:(.text+0x1f63): undefined reference to `__ubsan_handle_negate_overflow'
[  155.565519][  T415] 
[  155.581812][  T415] /usr/bin/ld: libbpf.c:(.text+0x1f88): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.581825][  T415] 
[  155.599236][  T415] /usr/bin/ld: libbpf.c:(.text+0x1fbe): undefined reference to `__asan_report_store4'
[  155.599248][  T415] 
[  155.617359][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_ptr':
[  155.617373][  T415] 
[  155.645128][  T415] libbpf.c:(.text+0x2018): undefined reference to `__ubsan_handle_negate_overflow'
[  155.645140][  T415] 
[  155.661533][  T415] /usr/bin/ld: libbpf.c:(.text+0x2048): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.661545][  T415] 
[  155.678981][  T415] /usr/bin/ld: libbpf.c:(.text+0x207e): undefined reference to `__asan_report_store4'
[  155.678994][  T415] 
[  155.697130][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `str_is_empty':
[  155.697147][  T415] 
[  155.725078][  T415] libbpf.c:(.text+0x20d3): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.725090][  T415] 
[  155.745397][  T415] /usr/bin/ld: libbpf.c:(.text+0x2107): undefined reference to `__asan_report_load1'
[  155.745473][  T415] 
[  155.763705][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `is_ldimm64_insn':
[  155.763718][  T415] 
[  155.794401][  T415] libbpf.c:(.text+0x2157): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.794468][  T415] 
[  155.814758][  T415] /usr/bin/ld: libbpf.c:(.text+0x218b): undefined reference to `__asan_report_load1'
[  155.814834][  T415] 
[  155.840189][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_insn_bswap':
[  155.840202][  T415] 
[  155.868801][  T415] libbpf.c:(.text+0x21ce): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.868815][  T415] 
[  155.890278][  T415] /usr/bin/ld: libbpf.c:(.text+0x21f2): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.890354][  T415] 
[  155.908058][  T415] /usr/bin/ld: libbpf.c:(.text+0x222a): undefined reference to `__asan_report_load1'
[  155.908071][  T415] 
[  155.924787][  T415] /usr/bin/ld: libbpf.c:(.text+0x2260): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.924801][  T415] 
[  155.942327][  T415] /usr/bin/ld: libbpf.c:(.text+0x2284): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.942340][  T415] 
[  155.964902][  T415] /usr/bin/ld: libbpf.c:(.text+0x22b9): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  155.964989][  T415] 
[  155.987534][  T415] /usr/bin/ld: libbpf.c:(.text+0x22dd): undefined reference to `__ubsan_handle_pointer_overflow'
[  155.987600][  T415] 
[  156.005148][  T415] /usr/bin/ld: libbpf.c:(.text+0x2323): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.005160][  T415] 
[  156.022975][  T415] /usr/bin/ld: libbpf.c:(.text+0x2347): undefined reference to `__ubsan_handle_pointer_overflow'
[  156.022988][  T415] 
[  156.040831][  T415] /usr/bin/ld: libbpf.c:(.text+0x2384): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.040843][  T415] 
[  156.063600][  T415] /usr/bin/ld: libbpf.c:(.text+0x23a8): undefined reference to `__ubsan_handle_pointer_overflow'
[  156.063677][  T415] 
[  156.081294][  T415] /usr/bin/ld: libbpf.c:(.text+0x23e3): undefined reference to `__asan_report_load2'
[  156.081307][  T415] 
[  156.102458][  T415] /usr/bin/ld: libbpf.c:(.text+0x241f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.102547][  T415] 
[  156.126422][  T415] /usr/bin/ld: libbpf.c:(.text+0x2443): undefined reference to `__ubsan_handle_pointer_overflow'
[  156.126488][  T415] 
[  156.147342][  T415] /usr/bin/ld: libbpf.c:(.text+0x247e): undefined reference to `__asan_report_store2'
[  156.147408][  T415] 
[  156.164146][  T415] /usr/bin/ld: libbpf.c:(.text+0x24ae): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.164159][  T415] 
[  156.181779][  T415] /usr/bin/ld: libbpf.c:(.text+0x24d2): undefined reference to `__ubsan_handle_pointer_overflow'
[  156.181791][  T415] 
[  156.199324][  T415] /usr/bin/ld: libbpf.c:(.text+0x250d): undefined reference to `__asan_report_load4'
[  156.199337][  T415] 
[  156.216030][  T415] /usr/bin/ld: libbpf.c:(.text+0x2545): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.216043][  T415] 
[  156.233641][  T415] /usr/bin/ld: libbpf.c:(.text+0x2569): undefined reference to `__ubsan_handle_pointer_overflow'
[  156.233653][  T415] 
[  156.251085][  T415] /usr/bin/ld: libbpf.c:(.text+0x25a4): undefined reference to `__asan_report_store4'
[  156.251097][  T415] 
[  156.269407][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `ensure_good_fd':
[  156.269420][  T415] 
[  156.297466][  T415] libbpf.c:(.text+0x2647): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.297479][  T415] 
[  156.313924][  T415] /usr/bin/ld: libbpf.c:(.text+0x267d): undefined reference to `__asan_report_load4'
[  156.313936][  T415] 
[  156.330641][  T415] /usr/bin/ld: libbpf.c:(.text+0x26b9): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.330654][  T415] 
[  156.348336][  T415] /usr/bin/ld: libbpf.c:(.text+0x26ef): undefined reference to `__asan_report_store4'
[  156.348348][  T415] 
[  156.366289][  T415] /usr/bin/ld: libbpf.c:(.text+0x271e): undefined reference to `__ubsan_handle_negate_overflow'
[  156.366302][  T415] 
[  156.390689][  T415] /usr/bin/ld: libbpf.c:(.text+0x276d): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.390765][  T415] 
[  156.412242][  T415] /usr/bin/ld: libbpf.c:(.text+0x27a3): undefined reference to `__asan_report_store4'
[  156.412317][  T415] 
[  156.437610][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `reuse_fd':
[  156.437623][  T415] 
[  156.468672][  T415] libbpf.c:(.text+0x2865): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.468726][  T415] 
[  156.484963][  T415] /usr/bin/ld: libbpf.c:(.text+0x289b): undefined reference to `__asan_report_load4'
[  156.484976][  T415] 
[  156.506517][  T415] /usr/bin/ld: libbpf.c:(.text+0x28b7): undefined reference to `__ubsan_handle_negate_overflow'
[  156.506586][  T415] 
[  156.532290][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `__base_pr':
[  156.532303][  T415] 
[  156.563076][  T415] libbpf.c:(.text+0x2961): undefined reference to `__asan_report_load1'
[  156.563152][  T415] 
[  156.578555][  T415] /usr/bin/ld: libbpf.c:(.text+0x297e): undefined reference to `__ubsan_handle_load_invalid_value'
[  156.578567][  T415] 
[  156.596183][  T415] /usr/bin/ld: libbpf.c:(.text+0x29ab): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.596197][  T415] 
[  156.613255][  T415] /usr/bin/ld: libbpf.c:(.text+0x29dc): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.613267][  T415] 
[  156.630434][  T415] /usr/bin/ld: libbpf.c:(.text+0x2a1b): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.630447][  T415] 
[  156.647523][  T415] /usr/bin/ld: libbpf.c:(.text+0x2a5a): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.647535][  T415] 
[  156.664560][  T415] /usr/bin/ld: libbpf.c:(.text+0x2aa4): undefined reference to `__asan_report_load8'
[  156.664572][  T415] 
[  156.680959][  T415] /usr/bin/ld: libbpf.c:(.text+0x2abf): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.680972][  T415] 
[  156.698072][  T415] /usr/bin/ld: libbpf.c:(.text+0x2b1a): undefined reference to `__asan_report_load8'
[  156.698086][  T415] 
[  156.715406][  T415] /usr/bin/ld: libbpf.c:(.text+0x2b35): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.715419][  T415] 
[  156.733372][  T415] /usr/bin/ld: libbpf.c:(.text+0x2b4b): undefined reference to `__ubsan_handle_nonnull_arg'
[  156.733384][  T415] 
[  156.752840][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `libbpf_print':
[  156.752853][  T415] 
[  156.781727][  T415] (.text+0x2bfb): undefined reference to `__asan_option_detect_stack_use_after_return'
[  156.781739][  T415] 
[  156.798584][  T415] /usr/bin/ld: (.text+0x2c08): undefined reference to `__asan_stack_malloc_1'
[  156.798596][  T415] 
[  156.814997][  T415] /usr/bin/ld: (.text+0x2ca8): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.815010][  T415] 
[  156.840127][  T415] /usr/bin/ld: (.text+0x2cde): undefined reference to `__asan_report_load4'
[  156.840139][  T415] 
[  156.857976][  T415] /usr/bin/ld: (.text+0x2d57): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  156.857988][  T415] 
[  156.880906][  T415] /usr/bin/ld: (.text+0x2d8d): undefined reference to `__asan_report_store4'
[  156.880984][  T415] 
[  156.899682][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `pr_perm_msg':
[  156.899696][  T415] 
[  156.928079][  T415] libbpf.c:(.text+0x2e1f): undefined reference to `__asan_option_detect_stack_use_after_return'
[  156.928092][  T415] 
[  156.945553][  T415] /usr/bin/ld: libbpf.c:(.text+0x2e2c): undefined reference to `__asan_stack_malloc_2'
[  156.945566][  T415] 
[  156.962328][  T415] /usr/bin/ld: libbpf.c:(.text+0x2f04): undefined reference to `__asan_report_load8'
[  156.962341][  T415] 
[  156.978829][  T415] /usr/bin/ld: libbpf.c:(.text+0x2f39): undefined reference to `__asan_report_load8'
[  156.978842][  T415] 
[  156.995488][  T415] /usr/bin/ld: libbpf.c:(.text+0x2f9b): undefined reference to `__asan_report_load8'
[  156.995509][  T415] 
[  157.012336][  T415] /usr/bin/ld: libbpf.c:(.text+0x3039): undefined reference to `__asan_report_load8'
[  157.012349][  T415] 
[  157.031134][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_program__unload':
[  157.031147][  T415] 
[  157.059694][  T415] (.text+0x31bd): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.059707][  T415] 
[  157.075307][  T415] /usr/bin/ld: (.text+0x31e1): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.075319][  T415] 
[  157.092162][  T415] /usr/bin/ld: (.text+0x3214): undefined reference to `__asan_report_load4'
[  157.092184][  T415] 
[  157.108235][  T415] /usr/bin/ld: (.text+0x3247): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.108248][  T415] 
[  157.124793][  T415] /usr/bin/ld: (.text+0x326b): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.124805][  T415] 
[  157.141904][  T415] /usr/bin/ld: (.text+0x32a4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.141916][  T415] 
[  157.158851][  T415] /usr/bin/ld: (.text+0x32c8): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.158863][  T415] 
[  157.175891][  T415] /usr/bin/ld: (.text+0x32fb): undefined reference to `__asan_report_store4'
[  157.175904][  T415] 
[  157.192288][  T415] /usr/bin/ld: (.text+0x332e): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.192301][  T415] 
[  157.208834][  T415] /usr/bin/ld: (.text+0x3357): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.208846][  T415] 
[  157.225196][  T415] /usr/bin/ld: (.text+0x337e): undefined reference to `__asan_report_load8'
[  157.225209][  T415] 
[  157.240564][  T415] /usr/bin/ld: (.text+0x33b9): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.240582][  T415] 
[  157.257000][  T415] /usr/bin/ld: (.text+0x33e2): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.257013][  T415] 
[  157.273278][  T415] /usr/bin/ld: (.text+0x3409): undefined reference to `__asan_report_store8'
[  157.273291][  T415] 
[  157.288718][  T415] /usr/bin/ld: (.text+0x3440): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.288731][  T415] 
[  157.305120][  T415] /usr/bin/ld: (.text+0x3469): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.305132][  T415] 
[  157.321977][  T415] /usr/bin/ld: (.text+0x3491): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.321991][  T415] 
[  157.343876][  T415] /usr/bin/ld: (.text+0x34ba): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.343942][  T415] 
[  157.366088][  T415] /usr/bin/ld: (.text+0x34e1): undefined reference to `__asan_report_load8'
[  157.366165][  T415] 
[  157.386490][  T415] /usr/bin/ld: (.text+0x351c): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.386589][  T415] 
[  157.403976][  T415] /usr/bin/ld: (.text+0x3545): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.403989][  T415] 
[  157.425160][  T415] /usr/bin/ld: (.text+0x356c): undefined reference to `__asan_report_store8'
[  157.425249][  T415] 
[  157.447069][  T415] /usr/bin/ld: (.text+0x35a3): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.447157][  T415] 
[  157.468492][  T415] /usr/bin/ld: (.text+0x35cc): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.468531][  T415] 
[  157.489061][  T415] /usr/bin/ld: (.text+0x35f4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.489138][  T415] 
[  157.510557][  T415] /usr/bin/ld: (.text+0x361d): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.510623][  T415] 
[  157.530109][  T415] /usr/bin/ld: (.text+0x3644): undefined reference to `__asan_report_load8'
[  157.530196][  T415] 
[  157.550453][  T415] /usr/bin/ld: (.text+0x367f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.550529][  T415] 
[  157.570569][  T415] /usr/bin/ld: (.text+0x36a8): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.570645][  T415] 
[  157.591663][  T415] /usr/bin/ld: (.text+0x36cf): undefined reference to `__asan_report_store8'
[  157.591739][  T415] 
[  157.612455][  T415] /usr/bin/ld: (.text+0x3706): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.612570][  T415] 
[  157.629846][  T415] /usr/bin/ld: (.text+0x372f): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.629858][  T415] 
[  157.655470][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_program__exit':
[  157.655483][  T415] 
[  157.686920][  T415] libbpf.c:(.text+0x377f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.686996][  T415] 
[  157.706541][  T415] /usr/bin/ld: libbpf.c:(.text+0x37a0): undefined reference to `__asan_report_load8'
[  157.706617][  T415] 
[  157.727082][  T415] /usr/bin/ld: libbpf.c:(.text+0x37d7): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.727158][  T415] 
[  157.747866][  T415] /usr/bin/ld: libbpf.c:(.text+0x37f8): undefined reference to `__asan_report_store8'
[  157.747942][  T415] 
[  157.770016][  T415] /usr/bin/ld: libbpf.c:(.text+0x382b): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.770083][  T415] 
[  157.791593][  T415] /usr/bin/ld: libbpf.c:(.text+0x3853): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.791679][  T415] 
[  157.813207][  T415] /usr/bin/ld: libbpf.c:(.text+0x3877): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.813293][  T415] 
[  157.835226][  T415] /usr/bin/ld: libbpf.c:(.text+0x389c): undefined reference to `__asan_report_load8'
[  157.835292][  T415] 
[  157.855805][  T415] /usr/bin/ld: libbpf.c:(.text+0x38d4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.855882][  T415] 
[  157.877411][  T415] /usr/bin/ld: libbpf.c:(.text+0x38f8): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.877487][  T415] 
[  157.898245][  T415] /usr/bin/ld: libbpf.c:(.text+0x391d): undefined reference to `__asan_report_store8'
[  157.898318][  T415] 
[  157.921036][  T415] /usr/bin/ld: libbpf.c:(.text+0x3951): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.921122][  T415] 
[  157.945033][  T415] /usr/bin/ld: libbpf.c:(.text+0x3975): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.945109][  T415] 
[  157.968057][  T415] /usr/bin/ld: libbpf.c:(.text+0x399d): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  157.968124][  T415] 
[  157.992080][  T415] /usr/bin/ld: libbpf.c:(.text+0x39c1): undefined reference to `__ubsan_handle_pointer_overflow'
[  157.992156][  T415] 
[  158.014199][  T415] /usr/bin/ld: libbpf.c:(.text+0x39e6): undefined reference to `__asan_report_load8'
[  158.014265][  T415] 
[  158.034806][  T415] /usr/bin/ld: libbpf.c:(.text+0x3a1e): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.034873][  T415] 
[  158.057064][  T415] /usr/bin/ld: libbpf.c:(.text+0x3a42): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.057141][  T415] 
[  158.079816][  T415] /usr/bin/ld: libbpf.c:(.text+0x3a67): undefined reference to `__asan_report_store8'
[  158.079893][  T415] 
[  158.100596][  T415] /usr/bin/ld: libbpf.c:(.text+0x3a9b): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.100662][  T415] 
[  158.122619][  T415] /usr/bin/ld: libbpf.c:(.text+0x3abf): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.122685][  T415] 
[  158.147079][  T415] /usr/bin/ld: libbpf.c:(.text+0x3ae7): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.147155][  T415] 
[  158.170011][  T415] /usr/bin/ld: libbpf.c:(.text+0x3b0b): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.170086][  T415] 
[  158.193228][  T415] /usr/bin/ld: libbpf.c:(.text+0x3b30): undefined reference to `__asan_report_load8'
[  158.193315][  T415] 
[  158.215052][  T415] /usr/bin/ld: libbpf.c:(.text+0x3b68): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.215118][  T415] 
[  158.238002][  T415] /usr/bin/ld: libbpf.c:(.text+0x3b8c): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.238069][  T415] 
[  158.261294][  T415] /usr/bin/ld: libbpf.c:(.text+0x3bb1): undefined reference to `__asan_report_store8'
[  158.261402][  T415] 
[  158.279020][  T415] /usr/bin/ld: libbpf.c:(.text+0x3be5): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.279033][  T415] 
[  158.301155][  T415] /usr/bin/ld: libbpf.c:(.text+0x3c09): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.301233][  T415] 
[  158.322993][  T415] /usr/bin/ld: libbpf.c:(.text+0x3c31): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.323070][  T415] 
[  158.340776][  T415] /usr/bin/ld: libbpf.c:(.text+0x3c55): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.340788][  T415] 
[  158.364299][  T415] /usr/bin/ld: libbpf.c:(.text+0x3c88): undefined reference to `__asan_report_store4'
[  158.364375][  T415] 
[  158.385151][  T415] /usr/bin/ld: libbpf.c:(.text+0x3cbb): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.385217][  T415] 
[  158.406947][  T415] /usr/bin/ld: libbpf.c:(.text+0x3cdf): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.407013][  T415] 
[  158.428031][  T415] /usr/bin/ld: libbpf.c:(.text+0x3d04): undefined reference to `__asan_report_store8'
[  158.428098][  T415] 
[  158.450010][  T415] /usr/bin/ld: libbpf.c:(.text+0x3d38): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.450087][  T415] 
[  158.473025][  T415] /usr/bin/ld: libbpf.c:(.text+0x3d5c): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.473101][  T415] 
[  158.496315][  T415] /usr/bin/ld: libbpf.c:(.text+0x3d81): undefined reference to `__asan_report_store8'
[  158.496381][  T415] 
[  158.516368][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `insn_is_subprog_call':
[  158.516383][  T415] 
[  158.548781][  T415] libbpf.c:(.text+0x3dc6): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.548868][  T415] 
[  158.565764][  T415] /usr/bin/ld: libbpf.c:(.text+0x3dfa): undefined reference to `__asan_report_load1'
[  158.565776][  T415] 
[  158.589577][  T415] /usr/bin/ld: libbpf.c:(.text+0x3e38): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.589661][  T415] 
[  158.609483][  T415] /usr/bin/ld: libbpf.c:(.text+0x3e7a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.609497][  T415] 
[  158.634933][  T415] /usr/bin/ld: libbpf.c:(.text+0x3eb7): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.635019][  T415] 
[  158.659978][  T415] /usr/bin/ld: libbpf.c:(.text+0x3edb): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.660007][  T415] 
[  158.677796][  T415] /usr/bin/ld: libbpf.c:(.text+0x3f13): undefined reference to `__asan_report_load1'
[  158.677811][  T415] 
[  158.698986][  T415] /usr/bin/ld: libbpf.c:(.text+0x3f4e): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.699063][  T415] 
[  158.721112][  T415] /usr/bin/ld: libbpf.c:(.text+0x3f72): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.721198][  T415] 
[  158.743055][  T415] /usr/bin/ld: libbpf.c:(.text+0x3fad): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.743120][  T415] 
[  158.766112][  T415] /usr/bin/ld: libbpf.c:(.text+0x3fd1): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.766188][  T415] 
[  158.788253][  T415] /usr/bin/ld: libbpf.c:(.text+0x400c): undefined reference to `__asan_report_load2'
[  158.788330][  T415] 
[  158.813485][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `is_call_insn':
[  158.813498][  T415] 
[  158.846293][  T415] libbpf.c:(.text+0x405e): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.846368][  T415] 
[  158.866969][  T415] /usr/bin/ld: libbpf.c:(.text+0x4092): undefined reference to `__asan_report_load1'
[  158.867035][  T415] 
[  158.892392][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `insn_is_pseudo_func':
[  158.892409][  T415] 
[  158.924542][  T415] libbpf.c:(.text+0x40e8): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  158.924619][  T415] 
[  158.942974][  T415] /usr/bin/ld: libbpf.c:(.text+0x410c): undefined reference to `__ubsan_handle_pointer_overflow'
[  158.942988][  T415] 
[  158.965216][  T415] /usr/bin/ld: libbpf.c:(.text+0x4144): undefined reference to `__asan_report_load1'
[  158.965282][  T415] 
[  158.990495][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object__init_prog':
[  158.990515][  T415] 
[  159.022499][  T415] libbpf.c:(.text+0x41f9): undefined reference to `__ubsan_handle_nonnull_arg'
[  159.022576][  T415] 
[  159.042767][  T415] /usr/bin/ld: libbpf.c:(.text+0x4237): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.042833][  T415] 
[  159.064533][  T415] /usr/bin/ld: libbpf.c:(.text+0x425b): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.064610][  T415] 
[  159.083408][  T415] /usr/bin/ld: libbpf.c:(.text+0x4280): undefined reference to `__asan_report_store8'
[  159.083420][  T415] 
[  159.107079][  T415] /usr/bin/ld: libbpf.c:(.text+0x42b4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.107140][  T415] 
[  159.130035][  T415] /usr/bin/ld: libbpf.c:(.text+0x42d8): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.130111][  T415] 
[  159.148832][  T415] /usr/bin/ld: libbpf.c:(.text+0x42fd): undefined reference to `__asan_report_store8'
[  159.148846][  T415] 
[  159.169906][  T415] /usr/bin/ld: libbpf.c:(.text+0x433c): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.170002][  T415] 
[  159.191850][  T415] /usr/bin/ld: libbpf.c:(.text+0x4360): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.191916][  T415] 
[  159.212905][  T415] /usr/bin/ld: libbpf.c:(.text+0x4385): undefined reference to `__asan_report_store8'
[  159.212980][  T415] 
[  159.235109][  T415] /usr/bin/ld: libbpf.c:(.text+0x43c0): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.235174][  T415] 
[  159.258066][  T415] /usr/bin/ld: libbpf.c:(.text+0x43e4): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.258141][  T415] 
[  159.281336][  T415] /usr/bin/ld: libbpf.c:(.text+0x4409): undefined reference to `__asan_report_store8'
[  159.281412][  T415] 
[  159.305006][  T415] /usr/bin/ld: libbpf.c:(.text+0x4439): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.305077][  T415] 
[  159.327964][  T415] /usr/bin/ld: libbpf.c:(.text+0x445d): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.328040][  T415] 
[  159.352068][  T415] /usr/bin/ld: libbpf.c:(.text+0x448d): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.352145][  T415] 
[  159.374986][  T415] /usr/bin/ld: libbpf.c:(.text+0x44b1): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.375073][  T415] 
[  159.398305][  T415] /usr/bin/ld: libbpf.c:(.text+0x44d6): undefined reference to `__asan_report_store8'
[  159.398381][  T415] 
[  159.422033][  T415] /usr/bin/ld: libbpf.c:(.text+0x4506): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.422054][  T415] 
[  159.445047][  T415] /usr/bin/ld: libbpf.c:(.text+0x452d): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.445123][  T415] 
[  159.468285][  T415] /usr/bin/ld: libbpf.c:(.text+0x4560): undefined reference to `__asan_report_store4'
[  159.468371][  T415] 
[  159.492000][  T415] /usr/bin/ld: libbpf.c:(.text+0x4596): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.492020][  T415] 
[  159.515991][  T415] /usr/bin/ld: libbpf.c:(.text+0x45ba): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.516067][  T415] 
[  159.538288][  T415] /usr/bin/ld: libbpf.c:(.text+0x45ed): undefined reference to `__asan_report_store4'
[  159.538364][  T415] 
[  159.559140][  T415] /usr/bin/ld: libbpf.c:(.text+0x4620): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.559226][  T415] 
[  159.580939][  T415] /usr/bin/ld: libbpf.c:(.text+0x4649): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.581005][  T415] 
[  159.602013][  T415] /usr/bin/ld: libbpf.c:(.text+0x467e): undefined reference to `__asan_report_store4'
[  159.602088][  T415] 
[  159.624050][  T415] /usr/bin/ld: libbpf.c:(.text+0x46a7): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.624137][  T415] 
[  159.646280][  T415] /usr/bin/ld: libbpf.c:(.text+0x46db): undefined reference to `__asan_report_load1'
[  159.646356][  T415] 
[  159.666855][  T415] /usr/bin/ld: libbpf.c:(.text+0x4712): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.666931][  T415] 
[  159.688912][  T415] /usr/bin/ld: libbpf.c:(.text+0x4736): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.688988][  T415] 
[  159.709989][  T415] /usr/bin/ld: libbpf.c:(.text+0x476e): undefined reference to `__asan_report_store1'
[  159.710085][  T415] 
[  159.732089][  T415] /usr/bin/ld: libbpf.c:(.text+0x479a): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.732165][  T415] 
[  159.755710][  T415] /usr/bin/ld: libbpf.c:(.text+0x47cc): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.755806][  T415] 
[  159.779963][  T415] /usr/bin/ld: libbpf.c:(.text+0x47f0): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.780030][  T415] 
[  159.802306][  T415] /usr/bin/ld: libbpf.c:(.text+0x4828): undefined reference to `__asan_report_store1'
[  159.802371][  T415] 
[  159.826707][  T415] /usr/bin/ld: libbpf.c:(.text+0x4858): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.826719][  T415] 
[  159.844776][  T415] /usr/bin/ld: libbpf.c:(.text+0x487c): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.844789][  T415] 
[  159.862868][  T415] /usr/bin/ld: libbpf.c:(.text+0x48b4): undefined reference to `__asan_report_store1'
[  159.862881][  T415] 
[  159.886243][  T415] /usr/bin/ld: libbpf.c:(.text+0x48e4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.886329][  T415] 
[  159.910093][  T415] /usr/bin/ld: libbpf.c:(.text+0x490d): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.910159][  T415] 
[  159.932279][  T415] /usr/bin/ld: libbpf.c:(.text+0x4942): undefined reference to `__asan_report_load4'
[  159.932366][  T415] 
[  159.952970][  T415] /usr/bin/ld: libbpf.c:(.text+0x4974): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  159.953036][  T415] 
[  159.974696][  T415] /usr/bin/ld: libbpf.c:(.text+0x4998): undefined reference to `__ubsan_handle_pointer_overflow'
[  159.974762][  T415] 
[  159.995636][  T415] /usr/bin/ld: libbpf.c:(.text+0x49cb): undefined reference to `__asan_report_store4'
[  159.995722][  T415] 
[  160.017730][  T415] /usr/bin/ld: libbpf.c:(.text+0x49e8): undefined reference to `__ubsan_handle_nonnull_arg'
[  160.017817][  T415] 
[  160.039461][  T415] /usr/bin/ld: libbpf.c:(.text+0x4a1f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.039585][  T415] 
[  160.061268][  T415] /usr/bin/ld: libbpf.c:(.text+0x4a43): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.061355][  T415] 
[  160.082284][  T415] /usr/bin/ld: libbpf.c:(.text+0x4a68): undefined reference to `__asan_report_store8'
[  160.082360][  T415] 
[  160.103154][  T415] /usr/bin/ld: libbpf.c:(.text+0x4a98): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.103229][  T415] 
[  160.124908][  T415] /usr/bin/ld: libbpf.c:(.text+0x4abc): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.124984][  T415] 
[  160.147691][  T415] /usr/bin/ld: libbpf.c:(.text+0x4ae3): undefined reference to `__ubsan_handle_nonnull_arg'
[  160.147767][  T415] 
[  160.169958][  T415] /usr/bin/ld: libbpf.c:(.text+0x4b1a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.170045][  T415] 
[  160.191093][  T415] /usr/bin/ld: libbpf.c:(.text+0x4b3b): undefined reference to `__asan_report_store8'
[  160.191159][  T415] 
[  160.213044][  T415] /usr/bin/ld: libbpf.c:(.text+0x4b6a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.213120][  T415] 
[  160.236013][  T415] /usr/bin/ld: libbpf.c:(.text+0x4bb1): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.236090][  T415] 
[  160.260052][  T415] /usr/bin/ld: libbpf.c:(.text+0x4bd5): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.260128][  T415] 
[  160.282236][  T415] /usr/bin/ld: libbpf.c:(.text+0x4bfa): undefined reference to `__asan_report_store8'
[  160.282280][  T415] 
[  160.303046][  T415] /usr/bin/ld: libbpf.c:(.text+0x4c2a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.303112][  T415] 
[  160.324714][  T415] /usr/bin/ld: libbpf.c:(.text+0x4c4e): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.324780][  T415] 
[  160.346294][  T415] /usr/bin/ld: libbpf.c:(.text+0x4c87): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.346370][  T415] 
[  160.368133][  T415] /usr/bin/ld: libbpf.c:(.text+0x4cab): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.368209][  T415] 
[  160.390227][  T415] /usr/bin/ld: libbpf.c:(.text+0x4cd0): undefined reference to `__asan_report_load8'
[  160.390314][  T415] 
[  160.410678][  T415] /usr/bin/ld: libbpf.c:(.text+0x4cec): undefined reference to `__ubsan_handle_nonnull_arg'
[  160.410765][  T415] 
[  160.432757][  T415] /usr/bin/ld: libbpf.c:(.text+0x4d02): undefined reference to `__ubsan_handle_nonnull_arg'
[  160.432824][  T415] 
[  160.458663][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object__add_programs':
[  160.458676][  T415] 
[  160.491133][  T415] libbpf.c:(.text+0x4daa): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.491209][  T415] 
[  160.514023][  T415] /usr/bin/ld: libbpf.c:(.text+0x4dd3): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.514109][  T415] 
[  160.537213][  T415] /usr/bin/ld: libbpf.c:(.text+0x4dfa): undefined reference to `__asan_report_load8'
[  160.537289][  T415] 
[  160.559079][  T415] /usr/bin/ld: libbpf.c:(.text+0x4e31): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.559155][  T415] 
[  160.581248][  T415] /usr/bin/ld: libbpf.c:(.text+0x4e52): undefined reference to `__asan_report_load8'
[  160.581314][  T415] 
[  160.601972][  T415] /usr/bin/ld: libbpf.c:(.text+0x4e85): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.602049][  T415] 
[  160.623754][  T415] /usr/bin/ld: libbpf.c:(.text+0x4ea9): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.623830][  T415] 
[  160.644737][  T415] /usr/bin/ld: libbpf.c:(.text+0x4ece): undefined reference to `__asan_report_load8'
[  160.644813][  T415] 
[  160.667056][  T415] /usr/bin/ld: libbpf.c:(.text+0x4f02): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.667123][  T415] 
[  160.689982][  T415] /usr/bin/ld: libbpf.c:(.text+0x4f26): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.690059][  T415] 
[  160.713952][  T415] /usr/bin/ld: libbpf.c:(.text+0x4f4b): undefined reference to `__asan_report_load8'
[  160.714028][  T415] 
[  160.737047][  T415] /usr/bin/ld: libbpf.c:(.text+0x4f7f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.737135][  T415] 
[  160.761055][  T415] /usr/bin/ld: libbpf.c:(.text+0x4fa3): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.761121][  T415] 
[  160.783538][  T415] /usr/bin/ld: libbpf.c:(.text+0x4fc8): undefined reference to `__asan_report_load8'
LKP: ttyS0: 360: LKP: tbox cant [  160.783624][  T415] 
kexec and rebooting forcely
[  160.806398][  T415] /usr/bin/ld: libbpf.c:(.text+0x4ffb): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.806474][  T415] 
[  160.825009][  T415] /usr/bin/ld: libbpf.c:(.text+0x501f): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.825021][  T415] 
[  160.848419][  T415] /usr/bin/ld: libbpf.c:(.text+0x5044): undefined reference to `__asan_report_load8'
[  160.848496][  T415] 
[  160.869282][  T415] /usr/bin/ld: libbpf.c:(.text+0x50b1): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.869358][  T415] 
[  160.891437][  T415] /usr/bin/ld: libbpf.c:(.text+0x50d5): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.891542][  T415] 
[  160.909845][  T415] /usr/bin/ld: libbpf.c:(.text+0x5110): undefined reference to `__asan_report_load2'
[  160.909858][  T415] 
[  160.930648][  T415] /usr/bin/ld: libbpf.c:(.text+0x514f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.930724][  T415] 
[  160.955817][  T415] /usr/bin/ld: libbpf.c:(.text+0x5173): undefined reference to `__ubsan_handle_pointer_overflow'
[  160.955829][  T415] 
[  160.978642][  T415] /usr/bin/ld: libbpf.c:(.text+0x51ab): undefined reference to `__asan_report_load1'
[  160.978708][  T415] 
[  160.999829][  T415] /usr/bin/ld: libbpf.c:(.text+0x51ea): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  160.999905][  T415] 
[  161.019061][  T415] /usr/bin/ld: libbpf.c:(.text+0x520e): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.019076][  T415] 
[  161.041772][  T415] /usr/bin/ld: libbpf.c:(.text+0x5233): undefined reference to `__asan_report_load8'
[  161.041846][  T415] 
[  161.064540][  T415] /usr/bin/ld: libbpf.c:(.text+0x5267): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.064585][  T415] 
[  161.086415][  T415] /usr/bin/ld: libbpf.c:(.text+0x528b): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.086556][  T415] 
[  161.110343][  T415] /usr/bin/ld: libbpf.c:(.text+0x52b0): undefined reference to `__asan_report_load8'
[  161.110418][  T415] 
[  161.131155][  T415] /usr/bin/ld: libbpf.c:(.text+0x52e4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.131221][  T415] 
[  161.152179][  T415] /usr/bin/ld: libbpf.c:(.text+0x5313): undefined reference to `__asan_report_load4'
[  161.152255][  T415] 
[  161.174090][  T415] /usr/bin/ld: libbpf.c:(.text+0x53e7): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.174166][  T415] 
[  161.197290][  T415] /usr/bin/ld: libbpf.c:(.text+0x5410): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.197376][  T415] 
[  161.220222][  T415] /usr/bin/ld: libbpf.c:(.text+0x5445): undefined reference to `__asan_report_load4'
[  161.220288][  T415] 
[  161.242155][  T415] /usr/bin/ld: libbpf.c:(.text+0x5483): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.242242][  T415] 
[  161.265039][  T415] /usr/bin/ld: libbpf.c:(.text+0x54a7): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.265105][  T415] 
[  161.283818][  T415] /usr/bin/ld: libbpf.c:(.text+0x54df): undefined reference to `__asan_report_load1'
[  161.283832][  T415] 
[  161.304283][  T415] /usr/bin/ld: libbpf.c:(.text+0x559a): undefined reference to `__ubsan_handle_add_overflow'
[  161.304359][  T415] 
[  161.327040][  T415] /usr/bin/ld: libbpf.c:(.text+0x561a): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.327116][  T415] 
[  161.350065][  T415] /usr/bin/ld: libbpf.c:(.text+0x563e): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.350153][  T415] 
[  161.373305][  T415] /usr/bin/ld: libbpf.c:(.text+0x5663): undefined reference to `__asan_report_store8'
[  161.373381][  T415] 
[  161.390957][  T415] /usr/bin/ld: libbpf.c:(.text+0x56b4): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.390970][  T415] 
[  161.412869][  T415] /usr/bin/ld: libbpf.c:(.text+0x56f8): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.412956][  T415] 
[  161.434691][  T415] /usr/bin/ld: libbpf.c:(.text+0x5774): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.434790][  T415] 
[  161.456504][  T415] /usr/bin/ld: libbpf.c:(.text+0x5798): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.456571][  T415] 
[  161.477487][  T415] /usr/bin/ld: libbpf.c:(.text+0x57d0): undefined reference to `__asan_report_load1'
[  161.477563][  T415] 
[  161.498857][  T415] /usr/bin/ld: libbpf.c:(.text+0x580b): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.498923][  T415] 
[  161.521399][  T415] /usr/bin/ld: libbpf.c:(.text+0x582f): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.521465][  T415] 
[  161.540826][  T415] /usr/bin/ld: libbpf.c:(.text+0x5867): undefined reference to `__asan_report_store1'
[  161.540839][  T415] 
[  161.561620][  T415] /usr/bin/ld: libbpf.c:(.text+0x5897): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.561697][  T415] 
[  161.582674][  T415] /usr/bin/ld: libbpf.c:(.text+0x58d3): undefined reference to `__asan_report_load1'
[  161.582750][  T415] 
[  161.603592][  T415] /usr/bin/ld: libbpf.c:(.text+0x58f0): undefined reference to `__ubsan_handle_load_invalid_value'
[  161.603680][  T415] 
[  161.625509][  T415] /usr/bin/ld: libbpf.c:(.text+0x5925): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.625587][  T415] 
[  161.647272][  T415] /usr/bin/ld: libbpf.c:(.text+0x5949): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.647359][  T415] 
[  161.668277][  T415] /usr/bin/ld: libbpf.c:(.text+0x5981): undefined reference to `__asan_report_load1'
[  161.668343][  T415] 
[  161.690334][  T415] /usr/bin/ld: libbpf.c:(.text+0x59bc): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.690421][  T415] 
[  161.712040][  T415] /usr/bin/ld: libbpf.c:(.text+0x59e0): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.712106][  T415] 
[  161.735025][  T415] /usr/bin/ld: libbpf.c:(.text+0x5a1f): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.735100][  T415] 
[  161.759065][  T415] /usr/bin/ld: libbpf.c:(.text+0x5a43): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.759131][  T415] 
[  161.781329][  T415] /usr/bin/ld: libbpf.c:(.text+0x5a7b): undefined reference to `__asan_report_store1'
[  161.781416][  T415] 
[  161.801916][  T415] /usr/bin/ld: libbpf.c:(.text+0x5aa9): undefined reference to `__ubsan_handle_add_overflow'
[  161.801982][  T415] 
[  161.823366][  T415] /usr/bin/ld: libbpf.c:(.text+0x5ada): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.823432][  T415] 
[  161.845194][  T415] /usr/bin/ld: libbpf.c:(.text+0x5afe): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.845270][  T415] 
[  161.866244][  T415] /usr/bin/ld: libbpf.c:(.text+0x5b23): undefined reference to `__asan_report_store8'
[  161.866310][  T415] 
[  161.887308][  T415] /usr/bin/ld: libbpf.c:(.text+0x5b57): undefined reference to `__ubsan_handle_add_overflow'
[  161.887384][  T415] 
[  161.913490][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_object_bswap_progs':
[  161.913511][  T415] 
[  161.945832][  T415] libbpf.c:(.text+0x5ba9): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  161.945909][  T415] 
[  161.969134][  T415] /usr/bin/ld: libbpf.c:(.text+0x5bcd): undefined reference to `__ubsan_handle_pointer_overflow'
[  161.969211][  T415] 
[  161.992283][  T415] /usr/bin/ld: libbpf.c:(.text+0x5bf2): undefined reference to `__asan_report_load8'
[  161.992359][  T415] 
[  162.014123][  T415] /usr/bin/ld: libbpf.c:(.text+0x5c32): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  162.014197][  T415] 
[  162.033747][  T415] /usr/bin/ld: libbpf.c:(.text+0x5c56): undefined reference to `__ubsan_handle_pointer_overflow'
[  162.033761][  T415] 
[  162.053640][  T415] 
[  162.083135][  T415] 
[  162.127347][  T415] 
[  162.150780][  T415] 
Daily dpkg database backup timer[  162.173383][  T415] 
[  162.195766][  T415] 
[  162.220336][  T415] 
[  162.243163][  T415] 
[  162.267281][  T415] 
         Stoppin[  162.284349][  T413] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-cfl-e1/perf-sanity-tests-group-02-gcc-debian-13-x86_64-20250902.cgz-8c5eeed21051-20260329-11492-7bacvi-4.yaml&loadavg=3.26%201.29%200.48%202/249%207626&start_time=1774784935&end_time=1774784964&version=/lkp/lkp/.src-20260327-221558:81a0a028739c:4d59668523cd& -O /dev/null
[  162.284364][  T413] 
[  162.289404][  T415] /usr/bin/ld: libbpf.c:(.text+0x5e47): undefined reference to `__asan_report_load8'
[  162.331203][  T413] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-cfl-e1/perf-sanity-tests-group-02-gcc-debian-13-x86_64-20250902.cgz-8c5eeed21051-20260329-11492-7bacvi-4.yaml&job_state=failed -O /dev/null
[  162.335428][  T415] 
[  162.344746][  T413] 
[  162.374649][  T415] /usr/bin/ld: libbpf.c:(.text+0x5e80): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  162.380025][  T413] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-post-run?job_file=/lkp/jobs/scheduled/lkp-cfl-e1/perf-sanity-tests-group-02-gcc-debian-13-x86_64-20250902.cgz-8c5eeed21051-20260329-11492-7bacvi-4.yaml -O /dev/null
[  162.381353][  T415] 
[  162.391668][  T413] 
[  162.392551][  T413] LKP: stdout: 360: LKP: tbox cant kexec and rebooting forcely
[  162.419329][  T415] /usr/bin/ld: libbpf.c:(.text+0x5ea4): undefined reference to `__ubsan_handle_pointer_overflow'
[  162.420091][  T413] 
[  162.422327][  T415] 
[  162.432445][  T413] /usr/bin/wget -q --timeout=3600 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-wtmp?tbox_name=lkp-cfl-e1&tbox_state=rebooting_cant_kexec -O /dev/null
[  162.443208][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `find_member_by_offset':
[  162.448119][  T413] 
[  162.450076][  T415] 
[  162.451157][  T415] libbpf.c:(.text+0x5f3a): undefined reference to `__ubsan_handle_add_overflow'
[  162.523733][  T415] 
[  162.553880][  T415] 
[  162.632026][  T415] /usr/bin/ld: libbpf.c:(.text+0x6019): undefined reference to `__asan_report_load4'
[  162.632092][  T415] 
[  162.654114][  T415] /usr/bin/ld: libbpf.c:(.text+0x6044): undefined reference to `__ubsan_handle_nonnull_arg'
[  162.654190][  T415] 
[  162.689895][  T415] 
[  162.713441][  T415] /usr/bin/ld: libbpf.c:(.text+0x60c0): undefined reference to `__ubsan_handle_pointer_overflow'
[  162.713519][  T415] 
[  162.741714][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `find_struct_ops_kern_types':
[  162.741728][  T415] 
[  162.771064][  T415] libbpf.c:(.text+0x6134): undefined reference to `__asan_option_detect_stack_use_after_return'
[  162.771078][  T415] 
[  162.839076][  T415] /usr/bin/ld: libbpf.c:(.text+0x62f4): undefined reference to `__asan_report_load8'
[  162.839141][  T415] 
[  162.859750][  T415] 
[  162.895412][  T415] 
[  162.913949][  T415] /usr/bin/ld: libbpf.c:(.text+0x644a): undefined reference to `__ubsan_handle_pointer_overflow'
[  162.913961][  T415] 

[  162.957543][  T415] /usr/bin/ld: libbpf.c:(.text+0x64cd): undefined reference to `__ubsan_handle_pointer_overflow'
[  162.957616][  T415] 
[  162.981777][  T415] /usr/bin/ld: libbpf.c:(.text+0x6572): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  162.981863][  T415] 
[  163.003879][  T415] 
[  163.042710][  T415] /usr/bin/ld: libbpf.c:(.text+0x6615): undefined reference to `__asan_report_store4'
[  163.042723][  T415] 
[  163.122020][  T415] 
[  163.145244][  T415] 
[  163.182842][  T415] /usr/bin/ld: /usr/src/perf_selftests-x86_64-rhel-9.4-bpf-8c5eeed210518013e32a716dc6981eaafe62cecc/tools/perf/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a(libbpf-in.o): in function `bpf_map__is_struct_ops':
[  163.182855][  T415] 
[  163.233557][  T415] 
[  163.256117][  T415] 
[  163.275373][  T415] 
[  163.322962][  T415] /usr/bin/ld: libbpf.c:(.text+0x68d9): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.322975][  T415] 
[  163.360014][  T415] /usr/bin/ld: libbpf.c:(.text+0x6946): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.360027][  T415] 
[  163.396835][  T415] /usr/bin/ld: libbpf.c:(.text+0x69aa): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.396848][  T415] 
         Unmount[  163.437070][  T415] /usr/bin/ld: libbpf.c:(.text+0x6a18): undefined reference to `__ubsan_handle_add_overflow'
[  163.458703][  T415] /usr/bin/ld: libbpf.c:(.text+0x6a49): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  163.458716][  T415] 
[  163.476480][  T415] /usr/bin/ld: libbpf.c:(.text+0x6a6d): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.476493][  T415] 
1;39msystemd-update-done.service[  163.561638][  T415] 
[  163.585384][  T415] 
[  163.626893][  T415] /usr/bin/ld: libbpf.c:(.text+0x6b93): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.626905][  T415] 
[  163.648715][  T415] 
[  163.667787][  T415] /usr/bin/ld: libbpf.c:(.text+0x6bf1): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.667800][  T415] 
- Set Up Additional Binary Forma[  163.688851][  T415] 
[  163.711517][  T415] /usr/bin/ld: libbpf.c:(.text+0x6c6b): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  163.711586][  T415] 
[  163.733988][  T415] 
[  163.774878][  T415] /usr/bin/ld: libbpf.c:(.text+0x6d03): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.793622][  T415] 
[  163.816090][  T415] 
[  163.833969][  T415] /usr/bin/ld: libbpf.c:(.text+0x6d9a): undefined reference to `__asan_report_load8'
         Unmount[  163.833983][  T415] 
[  163.852400][  T415] 
[  163.877880][  T415] /usr/bin/ld: libbpf.c:(.text+0x6de9): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.877947][  T415] 
[  163.895327][ T7687] BTRFS info (device sda1): last unmount of filesystem 27546e8f-bd26-4135-882e-85e69f8333f6
[  163.929803][  T415] /usr/bin/ld: libbpf.c:(.text+0x6e43): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  163.929816][  T415] 
[  163.953319][  T415] /usr/bin/ld: libbpf.c:(.text+0x6e6c): undefined reference to `__ubsan_handle_pointer_overflow'
[  163.953386][  T415] 
[  163.977935][  T415] /usr/bin/ld: libbpf.c:(.text+0x6e93): undefined reference to `__asan_report_load8'
[  163.978012][  T415] 
[  164.019162][  T415] 
[  164.055708][  T415] /usr/bin/ld: libbpf.c:(.text+0x6f68): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  164.074240][  T415] 
[  164.135516][  T415] /usr/bin/ld: libbpf.c:(.text+0x7010): undefined reference to `__asan_report_load8'
[  164.135528][  T415] 
[  164.156789][  T415] 
[  164.194279][  T415] 
[  164.230764][  T415] /usr/bin/ld: libbpf.c:(.text+0x710b): undefined reference to `__ubsan_handle_add_overflow'
[  164.230778][  T415] 
[  164.268047][  T415] /usr/bin/ld: libbpf.c:(.text+0x7174): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  164.268060][  T415] 
[  164.304244][  T415] /usr/bin/ld: libbpf.c:(.text+0x71bd): undefined reference to `__asan_report_load8'
[  164.304256][  T415] 
[  164.339735][  T415] /usr/bin/ld: libbpf.c:(.text+0x722b): undefined reference to `__ubsan_handle_pointer_overflow'
[  164.339748][  T415] 
[  164.358343][  T415] /usr/bin/ld: libbpf.c:(.text+0x7263): undefined reference to `__asan_report_store1'
[  164.358365][  T415] 
[  164.375591][  T415] /usr/bin/ld: libbpf.c:(.text+0x7293): undefined reference to `__ubsan_handle_add_overflow'
[  164.375604][  T415] 
[  164.399401][  T415] /usr/bin/ld: libbpf.c:(.text+0x72c4): undefined reference to `__ubsan_handle_type_mismatch_v1'
[  164.399489][  T415] 
[  164.423479][  T415] /usr/bin/ld: libbpf.c:(.text+0x72e8): undefined reference to `__ubsan_handle_pointer_overflow'
[  164.423554][  T415] 
[  164.446897][  T415] /usr/bin/ld: libbpf.c:(.text+0x730d): undefined reference to `__asan_report_load8'
[  164.446910][  T415] 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

