Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9F4DE716;
	Fri,  9 Oct 2026 13:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551634; cv=fail; b=UGjrZAhaeqNfM+YQFDgS1yERvjZXnOYiVZmDbieJugUtqViSJpU/w8HohR77eRDhx0b4XH5ZE5OiCzsb361Vhnxf151IkoJEBxzXEYmK/RA4ZrAQWENGQy0SyDU3VcqAnnwsdsqHWelg1TtLmbrv+ANiR9HDMItCTy0N3q0IcOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551634; c=relaxed/simple;
	bh=EHPO7WXA+lNttYYP9ukP0Tn1ORWmlurWGkBCMwnETYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eU/prlIA7KTc5PVdtul6Hc+3/KwFjidL10sodFAK4Bw80bzv7lo/jivFKP2MxRoxBlwGljM5e1POyifJ6GbF6R22nqLlVA5Er5ieNeD2pMHblsv9uK1E0qTBrN6BXdgnGs7iSU3mpfH3FjTODWjIosziRZuhHXkc8PeCMgngvXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHmi3bEc; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHmi3bEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791551625; x=1823087625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EHPO7WXA+lNttYYP9ukP0Tn1ORWmlurWGkBCMwnETYo=;
  b=CHmi3bEcQPTI5AvgQaURAwNqBqi4mTnQiknoIvEOEz7xTr5Ek0LVNGn3
   7ukxgs47GDSIn/6F0tXj8rSIsp7r2r6xo6utBfbq6aqB1cPS1ESNcQab/
   KdS0DaMsWGD5J+fmeEd5yGh+nQuHx0eoFLqI3Xol6tiaEagVZaxR7nmhn
   mAiHzMPZ/MZidTvKspkOaoatcYcQ2TOmOeeCeZf8J3D90QO6JiD22Cvp4
   GW+VbYypXDtYr65GDxwTj9s6zVNVOEdeRSzMa/kOsaZebkhxMtdAMFAyJ
   tR43eAEQ7e7b9T0oAJH3BSFy1u4anlORs0Ugwv+K+TeiFPLBQrLT7a1ZB
   w==;
X-CSE-ConnectionGUID: quLtWvgqRhy6YFIh7ISTyw==
X-CSE-MsgGUID: fqmRs7plSquve/AMLC7d+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="255654"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="255654"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:13:44 -0700
X-CSE-ConnectionGUID: vmnXIsYOT1CEqJXUmPLd2g==
X-CSE-MsgGUID: QdAZTh1KSa2+BxVGRMUJHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="267981"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:13:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 06:13:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 06:13:43 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 06:13:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNtJ87JgBA1E9fMB8iV/lVFyLbRIFy+Oa0pVF9I6UDzDwVmhaSnDmI8MZ/hSWu9SCLoOhmbEltyKpXFlNjRT+h9af/RnJGzNllbSNdPghyLV3WDAy5B03K2lGGiT7eJZlWum1I7JzH9eo6LzN0irAaZEs7Nc8WoKC6cA+YWKw1xAurNwi2Mg/10fHvQrLKJWZNCTVcRW6SyTxBonHmgs08ZGaG6mNP2yJ95bVoXfZFt5hykbnJJCI9RzCUDXEMZU8TIM8y3snWJJnzR/upf3nXRU42h0vOXqlGJW2dTKLu6HSQ4+SAAGRNpO1cvjEo5m4NW+VsiK/pMPRSDjKDS1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHp1ryvCTCS9X6QB2Y5N2jZyb++YiyGftWuv4DTkJ/Q=;
 b=rvz8tpH/H/G461UC5TxmM1Z87uvclfMVv9KSU7FWOMCCu9oU7AWcC5LUz3WPymjqgIqL1fE2U190oniEtykAkg+KXHXF7gO7t6tD7ZNOGH3xomINtATzrTu2p6UrxpLAFiJ4MxkGnGjNXoSSYyoUUAeCRK3j8xwz+GSoeYxjfHb+oUdLt8v6AiUgjWF3pAGCZ69syvjLO+OmEiI9p9+0/653/1tGDOL6TVLNKrFms/GgCpj8muKXThV94gj1bj7vAIxn9bHK6OdQs0uKZYhWnWCjQvqH4XYroXJ43hx5vr/UjcBBlTt+GUIOWz7vKdg0wyS2adqOR4Kz2v6GI5xFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV2PR11MB480600.namprd11.prod.outlook.com (2603:10b6:408:40f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 13:13:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 13:13:41 +0000
Date: Fri, 9 Oct 2026 15:13:30 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v2 net-next 13/14] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
Message-ID: <asjoeic0XKyFV/NB@boxer>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-14-maciej.fijalkowski@intel.com>
 <20261008143710.02cfcbf8@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261008143710.02cfcbf8@kernel.org>
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV2PR11MB480600:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df60ba2-cadd-4309-ba67-08df2607233e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: hGiMk5c+Okx6sVdYd49z4BZh9dzs/izP/zP7ccOa3Gg0+py/z2wACCHFZEbGHuf1s8ilyn7ohK2PmbHE1VdoNEDHWjPI05VudKFV1IpqPjgcacStTEi0GdAYUjf2rDBdJuu6MY63A5TxR+E+yzmKcLT7h+qDZd/pyCy0OZsxo4BLJPxVkTs209RXrvK9xhAn0krItaiOaWTKUYRXpljvBeU2KAG0yhVTCP/5pycQq5z4CuPu0yX3epQaVKGfZq3bIVGICnwi5JD5nbETkOR+G5nE2Pb1YDVcajUFPncO5wwyzPWK2hSppGrr+hmMN2WPndYJjo+eZA6xfboxA6i6q2g/WBIpYttNc3sAgOYhuPkqxy1QnENym87HslehgDxPUV2AaaOkVmIoOBWHRl1MdFPmsi4XUCxxkC5loQO/BJdm4GKa/27YXthtN0H8NDVRo83gUlBFvAaK74jpF98QtqRC+OLQEYCNMguH26sjnLGEbdcYznJTUEesgUEj99swooaX1b5F7zrX/Ixe8aKiieQ86A4PkIwuSaRW5oYB/RwrX8Py+ZkQ7lFB7Os8LNR0X80M+jgvqIT9hYMj+2Ns5/jhXoSSikg//Vyc5g/RgbhbP/uDfYYN2dvIolvdFDquX05kablkWPaTESNTh52sFNP2JeE7FidfnPVN2t4oVH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8R4kg0yCF12mRAlpiFxfms0k0AokeYtHrjS+8uA375qc0XRq2H012n4C2PL/?=
 =?us-ascii?Q?HxqWmi3beu2V7jkQFdzwvbexs5UPUVbrEk1q8m6gNYzKYRgvu1frvLMv8rS1?=
 =?us-ascii?Q?c10W4dJ30VwL66lwXsFvq7xP5HYhMh0f802nMTA4BAG3qfa3frW+ADTRwzDh?=
 =?us-ascii?Q?AHbwq2S6Rl68oZcD8t9luA2Ubtwvk5lE3MTSC6Mx1rkAwmgC98QIFzSXW7TS?=
 =?us-ascii?Q?k+Cr8lrLVIr34T4p95SLsnUI0BcwJipWTkEd57VCku7ikX/+BO+V7QaC7yQB?=
 =?us-ascii?Q?2xPp270sFPP5I0R8TadoE4TfNoQ78sokALQ/Qpfg2VqeWRdvsMXjz0QWkb9w?=
 =?us-ascii?Q?osUVKcyeKto8iyGbJEokL4htQig5tMS6Sr1nvXVeRgoa7qv/QlSQAmFLm/Fm?=
 =?us-ascii?Q?qHgd/IEkKtEwaPDIK0aOfB+rUaaHvGTtZItLDgm4zimtN2rJ6QYYzyGlCajQ?=
 =?us-ascii?Q?1C2lZk+RAPvnVlX1cJhFd/VhnrVlQzVaxoHHBPn4WCJGRhU5qpmniZylO8OZ?=
 =?us-ascii?Q?6qkwHbcRrdtRjOSZTwsIGknTDavnWCZ53hwJVX8X/9/JSi4fPCWnANkAKDgV?=
 =?us-ascii?Q?pADZZRJu1rip1WMtp5REVI2gw2XbIe4ge2oqmPdmuRpWWM9tmQP5w6fCL2Gf?=
 =?us-ascii?Q?QBKcx4ZMGYPt31QCmquVRwHs9Esn8rgm0W2drTKyw6gRwInEIU8UXPohnLW/?=
 =?us-ascii?Q?FY2htvdu6gyVg07zpBTxRmaNejoo1D+7Nl10/1yuJkzhyKjS2/gu6tpnt/g3?=
 =?us-ascii?Q?CuZL1TVdAqF7oWNGg7LDXFNIFanM/IEjs8UO6MNbm/JJba79SG9ggGnCHY2q?=
 =?us-ascii?Q?xZRYpHePagZbOGZHSdkkRZ7lAuHAKw8dZatzf4FUzqog+gCPmcXIcRKGavoH?=
 =?us-ascii?Q?9F9CldrGZG+8tPTK2lNtrCx8+W9be7rrslPSTjDt9GeIcF8ASQGglyR6KfCl?=
 =?us-ascii?Q?WybaR7Pw4NIbgtFLmb6pjWqW9ukFcI5d4HpvuEdEiwxCzFpE67LJoDZgPn+3?=
 =?us-ascii?Q?dDRR0MgMs/VpR20KXp81ED3dpOkmkjZQFNEA39QC50IHTZLBUpj2QRO/V/nX?=
 =?us-ascii?Q?m157lnpdW9Orvq46OsMsn/8pKS5F8RCBwnRrsjTUo4+2rhmbp2PbmazrkHoo?=
 =?us-ascii?Q?o3vhiDzEoENX7s/6QFCTG+PCv4jgRIXE3aW6moVmeJ5Cpythkg9yD3OKTt+f?=
 =?us-ascii?Q?hs4j+nxOefnW3nTyzYT97+e/LG7NDtPrIGS202DLphmrLw1irSH+W7TddpjO?=
 =?us-ascii?Q?phJ/WD/yW2y7vR2cB6sZqAnz11IL+nMkZh0VDSaK6c+0218aJN5YfWmOhenM?=
 =?us-ascii?Q?EKnKGIJd/AhW5KCc7BHkYX7+3z5SIxHL/QBkdTw+QZxW1xPLlLsTMjhgjEGR?=
 =?us-ascii?Q?dmh380yVbN5zxJf8z5Jch7ygNZKiekNN+S4/pTqTyOFKiBc9K3PB0MnlynM5?=
 =?us-ascii?Q?BtbFduNgDGXJYbe6skEqm2R93V5Z+BgEWa5Dc59rDKP/OvrC8CkoHAT7++gn?=
 =?us-ascii?Q?NMbCrMnMuega8RcYPfxaSgOMxE72ueAE+pBuQbUafZgqQk8/5aWRHyR9RHeH?=
 =?us-ascii?Q?t1KkjSuxu286hgdeGgOh54bZS8S+2QOijrdtUxukh/FwSquaok3LekERXaM0?=
 =?us-ascii?Q?0EQ/zhppXXIyelIeH46/mvzs/t3obES3XeYLVgOy0O6dPZdE+ssBTTRRc7Mm?=
 =?us-ascii?Q?hcvUIAtE+AWCr/8j+bWZhnEiodtKshs1sdiXD2EriOhVRwIN8QVZCT7q9hzB?=
 =?us-ascii?Q?nz6v0XqYksFMXtJPMvCYB5ECmy86crs=3D?=
X-Exchange-RoutingPolicyChecked: V7asdiiRHji26BSjJOWT8V1YaF9YOIY97TfSrB/OUelgbisWvwr1AY5Xcr/cRIx7q/88n1EJSnYqZFs0Nb+ez+ipGrTAu7tWY3klCRIWUmR1OtlaChkgDhVkxIovirtoDcVj6C0o+LAYbah9nNH6afa9j759mfiFUyn4mVL1G/Mtgr/cN9SN7vJrz85g2fX4TRdj5IKAICg4vSXRwfy2ltk8jXJhjTt+taMphLrVOCo6L7U+uenRcGNyAW601tdwOYaz4DeL/Q6NM88pysLDI4GB2FzK0poVZRHVGIzhWhzIfjTRK0XkGjAau8L6HJ9g+Kq0wGW+EZGFKfjCwuY+hw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df60ba2-cadd-4309-ba67-08df2607233e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:13:40.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JSBle/TEGqFuTHQH7NKuntXOsdw5mYVLtyS+9RYgf6WVHwPCS0b14CqIj24stNdEPDyI6BwsyKIrYlmu8aV898cML67nDlCSI7Nk+m7Io10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB480600
X-OriginatorOrg: intel.com

On Thu, Oct 08, 2026 at 02:37:10PM -0700, Jakub Kicinski wrote:
> On Thu,  8 Oct 2026 13:49:08 +0200 Maciej Fijalkowski wrote:
> > +XSK_BIN = (Path(__file__).parent / "../../../net/lib/xskxceiver").resolve()
> 
> cfg.test_dir ? Please don't reinvent the wheel

ok I can convert from global var and base this on cfg.net_lib_dir. This
was done in this ugly form as list of test cases was generated without
creating an instance of NetDrvEpEnv.

> 
> > +XSK_CASES = XSK_BIN.parent / "xsk/test_xsk_case_defs.h"
> 
> > +def _hardware_cases():
> > +    defs = XSK_CASES.read_text()
> > +    entries = re.findall(r"(?m)^XSK_TEST_CASE\((\w+),\s*\w+,\s*([^)]+)\)", defs)
> > +    if not entries or len(entries) != defs.count("XSK_TEST_CASE("):
> > +        raise KsftFailEx(f"cannot parse {XSK_CASES}")
> > +    variants = []
> > +    for test_id, (name, hw) in enumerate(entries):
> > +        flags = {flag.strip() for flag in hw.split("|")}
> > +        if not flags <= {"0", "XSK_HW_RX", "XSK_HW_TX"}:
> > +            raise KsftFailEx(f"invalid hardware directions for {name}: {hw}")
> > +        variants += [KsftNamedVariant(f"{d}_{name.lower()}", name, d, test_id)
> > +                     for d in ("rx", "tx") if f"XSK_HW_{d.upper()}" in flags]
> > +    return variants
> 
> ?? Just list them, don't over optimize for de-duplication
> it's obviously all LLM generated now.

Looks nasty but it spits out a test case in correlation with direction we
will be testing. I wrote in cover letter that, speaking in AF_XDP ZC ice,
SEND_RECEIVE in XSK_HW_RX would focus on testing ice_clean_rx_irq_zc() and
analogously this same case in Tx direction would be testing ice_xmit_zc().

Some tests are only Rx or Tx, some don't define these flags.

> 
> > +def _netns_remote(cfg):
> > +    return cfg.env.get("REMOTE_TYPE") == "netns"
> 
> You shouldn't have to care, please don't break the abstractions
> 
> > +def _control_addr(cfg):
> > +    """An SSH remote is reached over its management link. A netns remote is
> > +    reached only over the tested link, where the XDP programs pass the
> > +    control connection to the stack."""
> > +    if _netns_remote(cfg):
> > +        return cfg.remote_addr_v["4"]
> > +    return cfg.remote.name.rpartition("@")[2]
> 
> Suspicious? Not sure why you need this. No existing test does
> something like this

I'll try to simplify the noise behind setup variables, these mostly come
from my intial local setup where I had issues on remote host, sorry about
that. Also as you say test code should not be special casing what remote
type comes from net.config.

> 
> > +def _root_cmd(command, host=None, sudo=False, **kwargs):
> > +    if sudo:
> > +        command = "sudo -n " + command
> > +    return cmd(command, host=host, **kwargs)
> 
> No hacks like this please, all networking tests can assume root
> 
> > +def _remote_binary(cfg, local_binary):
> > +    binary = cfg.env.get("XSK_REMOTE_BIN")
> 
> Why this variable? Just assume the binary in tree is the one we need?
> 
> > +    if not binary:
> > +        return cfg.remote.deploy(local_binary)
> > +    if cfg.env.get("REMOTE_TYPE") != "ssh":
> > +        raise KsftSkipEx("XSK_REMOTE_BIN requires the SSH remote backend")
> > +    if cfg.env.get("XSK_REMOTE_DEPLOY", "1") == "0":
> > +        result = cmd(f"test -x {shlex.quote(binary)}", host=cfg.remote,
> > +                     fail=False)
> > +        if result.ret:
> > +            raise KsftSkipEx(f"remote xskxceiver is not executable: {binary}")
> > +        return binary
> > +    upload = binary + ".upload"
> > +    cmd(["scp", "-q", str(local_binary), f"{cfg.remote.name}:{upload}"],
> > +        shell=False)
> > +    cmd(f"mv -f {shlex.quote(upload)} {shlex.quote(binary)}",
> > +        host=cfg.remote)
> 
> Why any of these hacks/complexity? I think you need a better LLM and
> point it at the existing tests. Weird stuff going on here :(
