Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB743BDD3;
	Thu, 23 Jul 2026 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802865; cv=fail; b=pw2AdJRrgbjPGElcx/9Wt2cd03FBaeB1yHmflGenTdYOK2Q08LWbEjLy+My/gahb8TCHK6YHg+wgBwIKCMHSOoZqcEQl1MT9H7+OmfnHTl0vmPb1fcfSvcyOpj3ybNVZ31V0o1u80AUZ+bQbRbOumbdvMLqRw6m14vtevSYWdBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802865; c=relaxed/simple;
	bh=q+I4MP0SCnd/TnpKR95f+9bGikHkauf1IaY8IEjTn+0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5BQtP/W7grYorjJLTh9CJzGGd+SrPfVnHgZgvbmRG0t5neb4iHaKTGn4XAr9E2YzHKk9K6AcQdrVkgr9AW/kDSddIuqTzLL1NtFy+PuuQ9+AK3ff+XdteDHt36zbEa/usKMefkGcGpo9bTw6hUFahoVmzVfPJxYaSeymRkvZ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NvD4H289; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvD4H289"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784802863; x=1816338863;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=q+I4MP0SCnd/TnpKR95f+9bGikHkauf1IaY8IEjTn+0=;
  b=NvD4H28988/oYSt+a7mNzxmYoqPVkc0mI5GUc+49ufkew0mmHONumQzt
   bt1tBvims7VC4k8tHKDPU1p0YFtZS4YI3Si6yOSwpaDs8Vjm5zM4z+2JB
   0HjnsDWZVgfdT5tja12s0GAg3Mpx6GqfhZzTdpyb7OHCvw2CJWB0kPtkd
   bCY2sKRElPlORjC7Hi8Znwbe0tsRAnO/C+oRHbe+ng+RhTHZuOX4lU8nK
   y6nO1LIaA+j77CD6CUXbcBMJcobuJ8tDrJMnewDIAFWAeEUuCm2kkcxgp
   p3Nn159WtlxPk8w+y6lbn/4gCkldTsmkJQnlft6MEcjYjcurlUddCmd5A
   Q==;
X-CSE-ConnectionGUID: rVDmiVfjQXmBMiFLI7mixA==
X-CSE-MsgGUID: l7HLvqHzRbCqDoD73M1Juw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85327931"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85327931"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:34:22 -0700
X-CSE-ConnectionGUID: AT53O3iYQzObuvjWtJIMlA==
X-CSE-MsgGUID: FTRhoBOCTIOKOFUuPsWx4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="281684762"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 03:34:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:34:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:34:21 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:34:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDl04W5HQQA/ZkYFQpX6XjJeT6oz1wHi6MkixEUB5d/cQcooUGm26J1AlDnxR6Q8WRkq12giJU9J3FHQaGiqWIy6EqRYQw4SNfSmBtogmgpXjQboZ7dPoBwDW42LzbgiSFt97s0JQP4eA72bl8vZ691u6o1ppd1N2nq6bDNHgum/Sb273hQva7ZRqdG4t56mJp3BP1uoO3fJ4tVpZqnx3qybPnOdji2RO1yQqffhD/yhBJYCECzsld2pqISJVuy/UYXNTrTezT+hgaDD7KCyzEdeh2hvpmTtJt1iCn3lw7eJTq7NaQGJ/lG7V92F9BS0dNtPHp9iFCVuUqly/+yv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwfxrgMs0gPKZvlXdckW7mayh5kuZttS3kBT8tMdI3A=;
 b=wxXybjgflQboS/c2grQ+WWRDQCrj71O/9tpg7rbf3b3GYMdJ7BcwD9ccvxCvomLbkePeIjVy6nG1xXcNpDBbjs7AwKshm3lM3mYSVF39kZ9A4R/NSrkSgme+6gwkkY2Sc8xJcDnoAcWUqiMt53r9UJmFbkV+TRekNSFCVaGWaSnI+jDBQqOtnStzd+L40FR6P296Xm8UM0qJ4QVCauNuZ+gvd2q1NE/ntjNksP15msb+jwmeoH3sMF4XCqgXb7y7BD7vkoVC4/waOQxpbnztQWRRM8JMQYNPK+WY2ckmS0ZBluxyDjKNV8fUB+ner8crVk3yrsA0eJW2Q3IXuPeF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:34:18 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 10:34:17 +0000
Date: Thu, 23 Jul 2026 12:34:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, <magnus.karlsson@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Message-ID: <amHuIvHN1zY4wYpt@boxer>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
X-ClientProxiedBy: VIVP296CA0102.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH2PR11MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: b83dfb37-ea18-4ce4-811c-08dee8a5f2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Bn0Snaf4tQPz/sNdciz24m+HXxHqyiErQJKIf8LEW9FxnnLk/nwSIOh98euGL5+sGE3tTlZbJwFQZbKBPmYu/6hq3urMB5lXfYXUYGwtZaBprbC8kSIwmyQkYeRaZ6jAlSh+E1VV1pyjwmiHNceVyPM4pQCC5CVskAHlihBMexjIcJZZOjOuwRpOOV/8FyPDOzthzl37mDCjUWNoGRT/MMpynb5PMm7injc1Ue4eSr+JF9WaUiUt7y4m9jm3BKezDzSx3JdjD0Lgu54A3BunfzYdsPmwgUHTShoUZIp/Q65ri2hbd5wXdC7Jmi17Mysg3qpktUzsNDD9JyFv6fUOq7SunEUndB+4xbW6L40ptGbFaQ/lspm5AO7FuhuarOblPdYk0oC5+iH2xSs4dEHNnWCep8FFUTKNU7EgEcK1/1M7+zfYp9rNKvV2BKCbNTNU73E5qc7H6MADXP93ycg3Gh4gRdPSuhXtftuZOML9W9tFYIFDNN15Ral+azfXoMWLeWsJjEIr9QtaKyiiRB7O/arlSYiNo8seDuqIlX8dlRIntUC2cM1snNXzkvoqP9jvJ2HkZWiPqQVOkO4miSmTpdy10VvZfnX3kr1/R93obAEGZpLx5oD9KASHjvCcqFluypHgk/GqiJQDAX34agLBjuv2IwvSVlx9BvQbb3GUMbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l4g8e8GpgkZfHKAD9w+D8xU17h1JdJmQMK/iZ/S6FakEGMO1slBMlLkq+3Db?=
 =?us-ascii?Q?8cuHsxZOe6w5sMzGIQMWTyKZIALc0Jec1yOhPC/TigMQ1EyWDvRzcq61MXRM?=
 =?us-ascii?Q?T2r9vqwykkpQgplYg+hUCLac6JYsBH0lhBpQ+b5SUIrZOlRUrRXw0jdcQgtw?=
 =?us-ascii?Q?KtgRL6b7favgSbrZYexQHi8kwBa1mvB3NRWkfkLMyD/MqXUyWYAa8zsKdWRR?=
 =?us-ascii?Q?8DPat5TE49fUZVYv+xVJ3R4uIw7IBLlymtqkTrJf95D3BpIPf/13lWhCslCL?=
 =?us-ascii?Q?Khrnlo4QOUNOqlv+1whIjcUnVSQoeKt66vcZPiuhz4L580NdSq94MaclGyqw?=
 =?us-ascii?Q?K/ZpSPulYCKwhVVkmMJk6NG/uVhWu7FTfe97hzYZQo0gHnMaHcWb4gs2vKPz?=
 =?us-ascii?Q?1JMTeitQiiKH+r+luQo4XCXqsg/GY0QAa7wIjYixT0HIh51iehBtODgIWkI9?=
 =?us-ascii?Q?sTqEC19Jdw+0j8eRmn8nl0+8zU/d7thoXuZxkEmhIaC7Ii86CAGqqNv9H9ce?=
 =?us-ascii?Q?DRF1as7ttpF77+CnpqtmS5jvt7eaUHyoIJ8Bp+pcShYuVvjw9tUtmjf8QoCW?=
 =?us-ascii?Q?+3BTtEKd/C9yheGfPJ6jlsk75S3LRTSRLoxlsKxv05TDnjQ28bMLiCJPB1kS?=
 =?us-ascii?Q?cq9uem2kgBUb6rnWD5ZyxWF/glDdrWrpxyLhs2OEWlNZ8A2hlCNaHIMSqLmi?=
 =?us-ascii?Q?Xm/8N0Zjo9xhZ5i+nHq1CKCrNte/FJYTtsSRvnO67UsBE4Tue7tET1jZ8kAi?=
 =?us-ascii?Q?Gb2rGwswBZ2WG+5jAvhgw2M6oCXn+BF2kmbFCKN47vEC64oMIcYSF1a6/lPV?=
 =?us-ascii?Q?NdmYckSq/mBqh70CL+81aXz/fDFOzyjhefAeiqqRhLbgpwyHYf5TNSC9rgbg?=
 =?us-ascii?Q?Y1p1RZQ14I2ignUEHWtxtSDPZShPqm2SESOjt9w3UckfuwPI8FhBC6/xorbw?=
 =?us-ascii?Q?iyIDS33OsKO9S4hD1MvDYfgfVqZTou7LTc15KGUvtfPtN5kKUDxaxfQ+lzWG?=
 =?us-ascii?Q?zE8Z2JC4jVRx7paKKGf26c6rQzoIXyEg27SVZfb0CQgkIfwcQBLgqO4ZQ5wU?=
 =?us-ascii?Q?8LUUhrGKoEA10Bjd4rvzmMrC+mXzvETamxRGXgPcFT5++5fTsb0yXSAHRLS5?=
 =?us-ascii?Q?hkU/otBX8iX2yyuVYAPM4OEB96S4MZEQbAOZdGciQ52zKPJEB9w/mMxzlKmC?=
 =?us-ascii?Q?3rwTs7WDCEo2loN0kMZnMO3ssB6VIrHRpph0vWEZ67T7sf30e6L9U0AUvyLk?=
 =?us-ascii?Q?/BtqHP9Zs1RBeOUoxeltWcVtidLlum8aVQEfcRKf84hNUtFVaLQn4mVIjAHZ?=
 =?us-ascii?Q?urMpwij2ovdZyMygeM62UCho+EpKWto5g3yEsyYCJS0mvQ3lgxyB16xnQRsg?=
 =?us-ascii?Q?0He7h4xEXt8oiutCEZE0rqvTn33mAtD54OMZJA/P09ygEtp+bxwX3jc3xvAN?=
 =?us-ascii?Q?P2g4x08GaMqIJewoTmZ9x58uQQk+NtGntxamr01JmE9aVT4rbYOFw7elVrSN?=
 =?us-ascii?Q?cAvelfycLUknK38H2u9Dix9FM/QLl+RwDCrY9CLzI6l/+4eVXaBWqhy3tdBQ?=
 =?us-ascii?Q?2ifywjwBIGbA/a46jnPZ7r5O36cQ4nR2wiErfbQzk4ue6GOkDFGk762AVsxO?=
 =?us-ascii?Q?hDjI9tdjjrqS5EoKpQu5EJRdEwNe/nBC1OZ0rdsBtonciTmWZU8jW/uBwLh1?=
 =?us-ascii?Q?9TrAQir18N1T59lrN8JCvWur7oTLJzNMpRIcUM3H3FGvq/ig6iceAXk0BD+n?=
 =?us-ascii?Q?pp+20r7ubs7W5H2DafsTeFbhhzw0P34=3D?=
X-Exchange-RoutingPolicyChecked: Ztkwndtl5Mm907bCprgBuYicUfCGHVnc2vx34ygTalPbsvmzopHGtjY9l2uol8cFCvcVoMuZH808tIdIgpYfEsyjVmggp0x/FRz3Lz7+dLyifDR75GSuy55GWJzLncqyWbRCEtVmHR+sZjRw73d/Qwopxvbcq8GJoT+NtCXdr2XzAtrnnxQz6ZLnsHX95YVFcj0lL35G+CoEQMfQYQXdYEiemDCToRRUT6+KPNdMLHQEMkdCmra5nUwNDB/qnZBBP/ZNapJz1vCAynwQDA/zx2V4G++qgM+x2aQXFxDCvgvJXJp1vnF+aQVKbqUOPhvsFpaPrz9NR/bKBAu+9GSvAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b83dfb37-ea18-4ce4-811c-08dee8a5f2df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:34:17.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUUNQVZTqjzo06lElHtS5FaIVooDRExlHRvz4ZxIVmxUIQSgx2uzNhuECK15by9Jc6Iey08uVNvSN6g+6LgaSBmoOWXEii5HLUL+trjbHjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 10:55:17AM -0700, Stanislav Fomichev wrote:
> On 07/22, Cen Zhang (Microsoft) wrote:
> > There is no metadata length check before accessing struct xsk_tx_metadata
> > fields in both xdp_umem_reg() (registration) and
> > xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
> > tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
> > out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
> > declared metadata region.
> > 
> > KASAN reports this as:
> > 
> >   BUG: KASAN: vmalloc-out-of-bounds in xsk_skb_metadata+0x4b2/0x500
> >   Read of size 8 at addr ffffc90000f11000 by task exploit/148
> > 
> >   xsk_skb_metadata (net/xdp/xsk.c:837)
> >   xsk_build_skb (net/xdp/xsk.c)
> >   __xsk_generic_xmit (net/xdp/xsk.c)
> >   xsk_sendmsg (net/xdp/xsk.c)
> > 
> > Fixing at registration time would break backward compatibility with older
> > userspace applications, so apply a runtime length check in
> > xsk_buff_valid_tx_metadata() that validates tx_metadata_len against the
> > fields required by the enabled flags.
> > 
> > Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Link: https://lore.kernel.org/all/20260720155210.34229-1-blbllhy@gmail.com/
> > Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> > ---
> > V2:
> >  - Change to runtime per-flag length check as suggested by Stanislav.
> 
> Hmm, the AI review points out another set of TOCTOU issues :-/ I wonder
> whether want to go all in and rewrite the users to have a copy
> of metadata? Something like the following below, build tested only,
> any issues with that?

Maybe you want to take ownership of this patch and run the proposed
resolution against internal AI review?

> 
> (xsk_tx_metadata_to_compl (!meta) check is still buggy? not sure)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 17f213cc93e4..94f2a32917d2 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -604,7 +604,7 @@ struct igc_xdp_buff {
>  
>  struct igc_metadata_request {
>  	struct igc_tx_buffer *tx_buffer;
> -	struct xsk_tx_metadata *meta;
> +	struct xsk_tx_metadata meta;
>  	struct igc_ring *tx_ring;
>  	u32 cmd_type;
>  	u16 used_desc;
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index e6e9441fc3d4..ec51a5b1051d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2961,7 +2961,7 @@ static void igc_xsk_request_timestamp(void *_priv)
>  		 * metadata area. It is the location to store the value of
>  		 * tx hardware timestamp.
>  		 */
> -		xsk_tx_metadata_to_compl(meta_req->meta, &tstamp->xsk_meta);
> +		xsk_tx_metadata_to_compl(&meta_req->meta, &tstamp->xsk_meta);
>  
>  		/* Set timestamp bit based on the _TSTAMP(_X) bit. */
>  		tx_flags |= tstamp->flags;
> @@ -3059,7 +3059,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  	 */
>  	while (budget >= 4 && xsk_tx_peek_desc(pool, &xdp_desc)) {
>  		struct igc_metadata_request meta_req;
> -		struct xsk_tx_metadata *meta = NULL;
> +		struct xsk_tx_metadata meta = {};
>  		struct igc_tx_buffer *bi;
>  		u32 olinfo_status;
>  		dma_addr_t dma;
> @@ -3071,7 +3071,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
>  
>  		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
> -		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
> +		xsk_buff_read_metadata(pool, xdp_desc.addr, &meta);
>  		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
>  		bi = &ring->tx_buffer_info[ntu];
>  
> @@ -3079,7 +3079,7 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		meta_req.tx_buffer = bi;
>  		meta_req.meta = meta;
>  		meta_req.used_desc = 0;
> -		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
> +		xsk_tx_metadata_request(&meta, &igc_xsk_tx_metadata_ops,
>  					&meta_req);
>  
>  		/* xsk_tx_metadata_request() may have updated next_to_use */
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> index 8aeab4b21035..1721a0a9220a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/tx.c
> @@ -66,7 +66,7 @@ static void mlx5e_xsk_tx_post_err(struct mlx5e_xdpsq *sq,
>  bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>  {
>  	struct xsk_buff_pool *pool = sq->xsk_pool;
> -	struct xsk_tx_metadata *meta = NULL;
> +	struct xsk_tx_metadata meta = {};
>  	union mlx5e_xdp_info xdpi;
>  	bool work_done = true;
>  	bool flush = false;
> @@ -99,13 +99,13 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>  		xdptxd.dma_addr = xsk_buff_raw_get_dma(pool, desc.addr);
>  		xdptxd.data = xsk_buff_raw_get_data(pool, desc.addr);
>  		xdptxd.len = desc.len;
> -		meta = xsk_buff_get_metadata(pool, desc.addr);
> +		xsk_buff_read_metadata(pool, desc.addr, &meta);
>  
>  		xsk_buff_raw_dma_sync_for_device(pool, xdptxd.dma_addr, xdptxd.len);
>  
>  		ret = INDIRECT_CALL_2(sq->xmit_xdp_frame, mlx5e_xmit_xdp_frame_mpwqe,
>  				      mlx5e_xmit_xdp_frame, sq, &xdptxd,
> -				      check_result, meta);
> +				      check_result, &meta);
>  		if (unlikely(!ret)) {
>  			if (sq->mpwqe.wqe)
>  				mlx5e_xdp_mpwqe_complete(sq);
> @@ -116,7 +116,7 @@ bool mlx5e_xsk_tx(struct mlx5e_xdpsq *sq, unsigned int budget)
>  			if (xp_tx_metadata_enabled(sq->xsk_pool)) {
>  				struct xsk_tx_metadata_compl compl;
>  
> -				xsk_tx_metadata_to_compl(meta, &compl);
> +				xsk_tx_metadata_to_compl(&meta, &compl);
>  				XSK_TX_COMPL_FITS(void *);
>  
>  				mlx5e_xdpi_fifo_push(&sq->db.xdpi_fifo,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 562d20830b94..217134559d41 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2707,7 +2707,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  
>  	for (; budget > 0; budget--) {
>  		struct stmmac_metadata_request meta_req;
> -		struct xsk_tx_metadata *meta = NULL;
> +		struct xsk_tx_metadata meta = {};
>  		dma_addr_t dma_addr;
>  		bool set_ic;
>  
> @@ -2732,7 +2732,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  
>  		tx_desc = stmmac_get_tx_desc(priv, tx_q, entry);
>  		dma_addr = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
> -		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
> +		xsk_buff_read_metadata(pool, xdp_desc.addr, &meta);
>  		xsk_buff_raw_dma_sync_for_device(pool, dma_addr, xdp_desc.len);
>  
>  		/* To return XDP buffer to XSK pool, we simple call
> @@ -2761,7 +2761,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  		meta_req.set_ic = &set_ic;
>  		meta_req.tbs = tx_q->tbs;
>  		meta_req.edesc = &tx_q->dma_entx[entry];
> -		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
> +		xsk_tx_metadata_request(&meta, &stmmac_xsk_tx_metadata_ops,
>  					&meta_req);
>  		if (set_ic) {
>  			tx_q->tx_count_frames = 0;
> @@ -2775,7 +2775,7 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  
>  		stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
>  
> -		xsk_tx_metadata_to_compl(meta,
> +		xsk_tx_metadata_to_compl(&meta,
>  					 &tx_q->tx_skbuff_dma[entry].xsk_meta);
>  
>  		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx, priv->dma_conf.dma_tx_size);
> diff --git a/include/net/libeth/xsk.h b/include/net/libeth/xsk.h
> index 82b5d21aae87..e2fa6bf6b1b3 100644
> --- a/include/net/libeth/xsk.h
> +++ b/include/net/libeth/xsk.h
> @@ -205,7 +205,7 @@ __libeth_xsk_xmit_fill_buf_md(const struct xdp_desc *xdesc,
>  	BUILD_BUG_ON(!__builtin_constant_p(tmo == libeth_xsktmo));
>  	tmo = tmo == libeth_xsktmo ? &__libeth_xsktmo : tmo;
>  
> -	xsk_tx_metadata_request(ctx.meta, tmo, &desc);
> +	xsk_tx_metadata_request(&ctx.meta, tmo, &desc);
>  
>  	return desc;
>  }
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index ebac60a3d8a1..eb2645a88934 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -163,7 +163,7 @@ static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
>  					   const struct xsk_tx_metadata_ops *ops,
>  					   void *priv)
>  {
> -	if (!meta)
> +	if (!meta || !meta->flags)
>  		return;
>  
>  	if (ops->tmo_request_launch_time)
> diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> index 46797645a0c2..925c25bad57c 100644
> --- a/include/net/xdp_sock_drv.h
> +++ b/include/net/xdp_sock_drv.h
> @@ -259,31 +259,42 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
>  		XDP_TXMD_FLAGS_LAUNCH_TIME | \
>  	0)
>  
> -static inline bool
> -xsk_buff_valid_tx_metadata(const struct xsk_tx_metadata *meta)
> +static inline int
> +xsk_buff_read_tx_metadata(const struct xsk_buff_pool *pool,
> +			  void *data,
> +			  struct xsk_tx_metadata *meta)
>  {
> -	return !(meta->flags & ~XDP_TXMD_FLAGS_VALID);
> -}
> -
> -static inline struct xsk_tx_metadata *
> -__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
> -{
> -	struct xsk_tx_metadata *meta;
> +	struct xsk_tx_metadata *p;
> +	u64 flags = 0;
>  
>  	if (!pool->tx_metadata_len)
> -		return NULL;
> +		return 0;
> +
> +	/* covers flags, XDP_TXMD_FLAGS_CHECKSUM & XDP_TXMD_FLAGS_TIMESTAMP */
> +	if (unlikely(pool->tx_metadata_len < 16))
> +		return -EINVAL;
> +
> +	p = data - pool->tx_metadata_len;
> +	flags = READ_ONCE(p->flags);
> +
> +	if (flags & ~XDP_TXMD_FLAGS_VALID)
> +		return -EINVAL;
>  
> -	meta = data - pool->tx_metadata_len;
> -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> -		return NULL; /* no way to signal the error to the user */
> +	if (flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> +		if (pool->tx_metadata_len < offsetofend(struct xsk_tx_metadata, request.launch_time))
> +			return -EINVAL;
>  
> -	return meta;
> +	memcpy(meta, p, min(pool->tx_metadata_len, sizeof(struct xsk_tx_metadata)));
> +	meta->flags = flags;
> +	return 0;
>  }
>  
> -static inline struct xsk_tx_metadata *
> -xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> +static inline void xsk_buff_read_metadata(const struct xsk_buff_pool *pool,
> +					  u64 addr,
> +					  struct xsk_tx_metadata *meta)
>  {
> -	return __xsk_buff_get_metadata(pool, xp_raw_get_data(pool, addr));
> +	if (xsk_buff_read_tx_metadata(pool, xp_raw_get_data(pool, addr), meta) < 0)
> +		meta->flags = 0;
>  }
>  
>  static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
> @@ -469,21 +480,18 @@ xsk_buff_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
>  	return (struct xdp_desc_ctx){ };
>  }
>  
> -static inline bool xsk_buff_valid_tx_metadata(struct xsk_tx_metadata *meta)
> +static inline int
> +xsk_buff_read_tx_metadata(const struct xsk_buff_pool *pool,
> +			  void *data,
> +			  struct xsk_tx_metadata *meta)
>  {
>  	return false;
>  }
>  
> -static inline struct xsk_tx_metadata *
> -__xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
> -{
> -	return NULL;
> -}
> -
> -static inline struct xsk_tx_metadata *
> -xsk_buff_get_metadata(struct xsk_buff_pool *pool, u64 addr)
> +static inline void xsk_buff_read_metadata(const struct xsk_buff_pool *pool,
> +					  u64 addr,
> +					  struct xsk_tx_metadata *meta)
>  {
> -	return NULL;
>  }
>  
>  static inline void xsk_buff_dma_sync_for_cpu(struct xdp_buff *xdp)
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index ccb3b350001f..71992b9e680d 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -141,12 +141,12 @@ void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
>  struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
>  u32 xp_alloc_batch(struct xsk_buff_pool *pool, struct xdp_buff **xdp, u32 max);
>  bool xp_can_alloc(struct xsk_buff_pool *pool, u32 count);
> -void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr);
> +void *xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr);
>  dma_addr_t xp_raw_get_dma(struct xsk_buff_pool *pool, u64 addr);
>  
>  struct xdp_desc_ctx {
>  	dma_addr_t dma;
> -	struct xsk_tx_metadata *meta;
> +	struct xsk_tx_metadata meta;
>  };
>  
>  struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index b970f30ea9b9..dbe4ddae30e8 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -802,19 +802,17 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  			    struct xdp_desc *desc, struct xsk_buff_pool *pool,
>  			    u32 hr)
>  {
> -	struct xsk_tx_metadata *meta = NULL;
> +	struct xsk_tx_metadata meta = {};
>  	u16 csum_start, csum_offset;
> +	int ret;
>  
> -	if (unlikely(pool->tx_metadata_len == 0))
> -		return -EINVAL;
> -
> -	meta = buffer - pool->tx_metadata_len;
> -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> -		return -EINVAL;
> +	ret = xsk_buff_read_tx_metadata(pool, buffer, &meta);
> +	if (ret < 0)
> +		return ret;
>  
> -	if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> -		csum_start = READ_ONCE(meta->request.csum_start);
> -		csum_offset = READ_ONCE(meta->request.csum_offset);
> +	if (meta.flags & XDP_TXMD_FLAGS_CHECKSUM) {
> +		csum_start = READ_ONCE(meta.request.csum_start);
> +		csum_offset = READ_ONCE(meta.request.csum_offset);
>  
>  		if (unlikely(csum_start + csum_offset +
>  			     sizeof(__sum16) > desc->len))
> @@ -833,9 +831,9 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
>  		}
>  	}
>  
> -	if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> -		skb->skb_mstamp_ns = meta->request.launch_time;
> -	xsk_tx_metadata_to_compl(meta, &skb_shinfo(skb)->xsk_meta);
> +	if (meta.flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
> +		skb->skb_mstamp_ns = meta.request.launch_time;
> +	xsk_tx_metadata_to_compl(&meta, &skb_shinfo(skb)->xsk_meta);
>  
>  	return 0;
>  }
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 1f28a9641571..c9f05835e433 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -735,7 +735,7 @@ static void *__xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr)
>  	return pool->addrs + addr;
>  }
>  
> -void *xp_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
> +void *xp_raw_get_data(const struct xsk_buff_pool *pool, u64 addr)
>  {
>  	return __xp_raw_get_data(pool, __xp_raw_get_addr(pool, addr));
>  }
> @@ -773,7 +773,7 @@ struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
>  	addr = __xp_raw_get_addr(pool, addr);
>  
>  	ret.dma = __xp_raw_get_dma(pool, addr);
> -	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
> +	xsk_buff_read_metadata(pool, addr, &ret.meta);
>  
>  	return ret;
>  }
