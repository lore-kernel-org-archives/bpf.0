Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F113403E89;
	Fri,  9 Oct 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550387; cv=fail; b=bHOrj0ky52aBrLb/l2RGvS/IH0e7K2wPCCPYtsAahFRyMtxZ7JFVVZhyUW4z6pQT6yE3T172jKhc8irUF+I102AjyLSAyIY9qrZexA45En/1KKgsxrX+z4weReJXzb8vhSBE/uHEwes+BxSMFYgTaPctbnVr4GaJtSDnFQ/8DgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550387; c=relaxed/simple;
	bh=zDM9rnAcFN57UQ1mRfcg6QY9/g/TmpO4vQA5X55SjMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bM/cDT2jC6Xaa4LxWsT1VIg/pc5TWbRHaBUtAd1LgjG/QhTYL4BQocz4IK+KNnvrAqsJHyXrWU4f6jMi+7pyfGMGZvRaV+PwrgBowQPp82jnIAYFt2623OY14VsC27qrChCPLsitDqYoDsIf6D8+gf8sBABMZzWkPek9iGv8Rzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhuf43GK; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhuf43GK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791550385; x=1823086385;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=zDM9rnAcFN57UQ1mRfcg6QY9/g/TmpO4vQA5X55SjMs=;
  b=nhuf43GK6ydIWxTicHfVEwQI02eRslHEAMak7X+DRWIKWcdPIe96Dlaj
   LZC3i/UF0evvzyZ7Puo7Uq/86hi+blI/YJZvQB/BM/d/Rg1z7i883+kIH
   4Ba4D2jjJf5vWDgY9BAxYRwTDQ9cmrUDoeuQ9Zm68O+vzKDFWZFAL2aAI
   K+ds+OQCa8SbtBICSv6PKqIaEnVFmsrxDbdiWRpYs0gAt1h8xWNhhjohK
   pVE9ZrE6n300aL/fORbD1kZzHppLOXVeS/iUrsZrzZx2JXCUkZpj7EfbQ
   aT2tbyaHoKpkqHPbLXosGmI9WCaKtcYhcwuwn/od3oJZOwDfqApHiL+K3
   A==;
X-CSE-ConnectionGUID: ic+4OiaeStaUpxBJtgddGg==
X-CSE-MsgGUID: IL401PK1StKIhzfZBsmt7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="339703"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="339703"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:53:04 -0700
X-CSE-ConnectionGUID: o3KZUbCPSNq8Y04No6YTfg==
X-CSE-MsgGUID: imrXDX1+TaqptTlVjssrBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="765788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:53:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:53:03 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 05:53:03 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrM7526UAbj8thQBRWQBia8amdVnnlPmjSz/NKWmCoEDxoDnorrqunXs9FQ+mmkpfDRhCL6bbeftb2AHfoTFuDJR2lvKX3oqQTx1HkZI/u9ImMAu5MwYrK6OmtK9nK5QPy9HcF75QHrFug0FAH4pU3exHWAneDNf48iorgUHKPhE6EbRgHlh2ogsbqpkjq0qa/+2JfhVhHQqcB8BAnSWb1eUCeb6HFpztg0LJp1VjehqAKso0aAyxU9ZeLFQ6YX3FktVCEjBg96DEn9IzOFhkEbNo33wdSqnRufMABKGntiMMphknGJ3QKFU7kbTIus+VEc/cFFY9P5G8ckPVz6t+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4tsg22GbmHGOKE8KXoyooAWToLGZKdmQV54BEdJtQA=;
 b=x4GTZsUwEDaspZGfwGmPyBfnjGpCNBUWpr0+8G/aZg/qHLnsHc5AI9BVVhAdSOc9qe3ET4QVJ+Z5cexnd5Sq2mW4QnuvloYMLzav/ILgAc8ZcNoaBMu0K4TqNmG9g0KVz5QhLxeKrZoYtQFFX6W2t3I38ST/lrDtXjttvjDstIhuU6IvSyngTwX2YalkGsNlQExQbjTSqIoeq6CcmWPGU3Eiyh1wqsXVpADxzO4OSpPwmbFYCp2Uk0wNjCMBcpt0BunQMGEgBqTuRFx7StDLLxLorJ2QvUPaXo6daBUNVDMtzhNU3jxOTD6nHGWoo0SFSjPCJ5eP2Vvyrwl53sSETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 12:53:00 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 12:53:00 +0000
Date: Fri, 9 Oct 2026 14:52:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH v2 net-next 12/14] selftests: xsk: share test case
 definitions with hardware runner
Message-ID: <asjjpY78fcsKspr+@boxer>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-13-maciej.fijalkowski@intel.com>
 <875wzbqdh7.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875wzbqdh7.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VI1PR06CA0191.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::48) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BL3PR11MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab30568-f5ee-4378-a837-08df26043fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZqfOskC9XktclQ1bJg1Q/gVOL8A4cn53P0Nt7NGlzhrha6VOX6QbZg5BoPwIBFwckDPUJmUksdU24PoPqOANCxALAP0xmYczv4KZu2NMf+FCiSjwzoUgsSSJjsELxaHyVxAhn9tS7QgFweQefQNsARkJZXMGIsfIdppFiXFqIaupHBrWpCE9a4XWLKQHny5Q5d09MAhVX5DyxIt6zwcjbyY0ExqGdUz7i/Sft+9eJ5wpFxGFcEyoG9gZ91fF27EWFW+6KbTrsu3V669YkJ/l0XV9OsYk+q/JpqXv1+yVsLbNEGeFCabqcH+KU7wMyNt/5r7S9TBEavylNR5avsq591AnfPxmUlZNpgyhYgjpNog9waAvQCwYahrM229KHhnhEAbegbJzb+F56KQC0FAN+lssdEIJHCmIE8c/tN2/qAGWjetstEB23nDZT4Tmj9sHORYy9urwi389XBnfj69lP1rr2lBLRLrWilzHlnPbvoDU7bOp4i9i8x8ZBVjdQtZBtRd7lsE1aAA0A5AoDaMGeE/skhd+6XxFDvIR41VsEnyC1JHXHlZgN6e10DZOxfHpChCz+r9A/nK5WlI9MYGsTSYKBbAXRSlfMQvLWeNqWg/9EdKhFFwiHIiqQ7v/2qAELZwoHD50mXQM7uz/pRDJERv0ddwUqpP+d6C6wa39t2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7fmRVOhBMM2agnq4+u9YAcY2hcN9R1KsHfkCBaskHknZl4+M9MCxv7HRrD?=
 =?iso-8859-1?Q?ChEir94X2nlb++R9v+gCG4x0MHlIFuw5kWFs8bn1QAcdU4IPhuVjLyMS2C?=
 =?iso-8859-1?Q?s1BWja7f6U1MGv2u8xOrm8AZY+wwbR2AO19x1OghNFG2oLiw0ZueHNTYcE?=
 =?iso-8859-1?Q?qsN+2KA+m//bc6GnyU55RPFyFt3EHtEujdhhxpv7X6VGlwE20EuFehltTJ?=
 =?iso-8859-1?Q?iDOaJXP6GDv3nPNYD5xbispTS95K7x2q6fgLUE3eEfGxu9S8VrYoZPU2+P?=
 =?iso-8859-1?Q?pez+2wry5MtkDBkcPGkN1vxqMPV6OsTugZXO9jhoAH93Bd0Wp9w4Xb1fdP?=
 =?iso-8859-1?Q?NZWXQ+tHQquo7abimOoyJ3viTP14mHBUUk8bEKpSNXa6jzIkirjCopeJhB?=
 =?iso-8859-1?Q?5brKRgOE547l0mHu3cB9EncVsTZq4CNAbenoX6/JivReJtNX9ouXs+1Vdt?=
 =?iso-8859-1?Q?ylLs+x5Jc+fwvT/qxqBOl7gP2OUZmuEHHKzMSdvXbRSicizchIuO8Do2Do?=
 =?iso-8859-1?Q?USX94Z3bEVIcjrbzjBRklO0UD6FLyMVZbL5j/TGCP/hhrXzujpW2bmKilJ?=
 =?iso-8859-1?Q?fSvKayvErOd+W3tSnuffMaXg1OvdG8CacLp1uxvYbBtNObRfbRxJYnQZ6W?=
 =?iso-8859-1?Q?8XWioXyZxTBZFw/QCpn5BH9y+Su1V9oZPTwb0W4GV8/yVFXgaBHDUsfAVV?=
 =?iso-8859-1?Q?1X/HXFrslmQ0M+5totj3wFf501DZpxtoRXY7NYBIJ1pO/tegMGKQMXIVkI?=
 =?iso-8859-1?Q?BFY1J/CxwBFQj8hS3t/VQZuQqaVKH9ELW6HKSJpuXVsJHzGB2jLxZgBrLL?=
 =?iso-8859-1?Q?IiuhS0BZfgNwvcXvlt6sGGljJPkWho72+oSMLL9AN2CxsNwo3u38fGs2yi?=
 =?iso-8859-1?Q?6h9ftGhTxFf3O3GgMgtzTGQzONiDHFR/5flIYzL3fc6XNnMKj6xcQfsZe4?=
 =?iso-8859-1?Q?SrtKS3cBcJel491Ee1Z1xQoU87Zg7WGHRdBrzFbEUH24dy60fxldlEamD6?=
 =?iso-8859-1?Q?9Wv8CRD4Oy/ZmN7H8+i4CF/EhIIRg02zxKMEVNV5X7FJW/w5XaMICB+vfU?=
 =?iso-8859-1?Q?h0CQ7cSmWMDhQ1aVzJbhSuZEoOcod40Huh+mPTCCjvBGFTJAt35cVH8IqW?=
 =?iso-8859-1?Q?mQRDH8emP3k8jDwop5zIMyRY/wAtYVOsjqAjoJX3q++9NcBbJI0HCfYA7k?=
 =?iso-8859-1?Q?pUWRUBUHqpdhZMuHL0SuD+hQ8p9akBKypzp8zP98oLHRo/0b9yps/YI9qF?=
 =?iso-8859-1?Q?9EOiaHmjlZW73nRkk3WSko89wH5cr4CK9SMyKw24ILWa24a+Vg174G19CV?=
 =?iso-8859-1?Q?iHGzUu+/cPMmq4i3f2DqyrPpnHr4dZg4XIGwD7IIhbU/dxFFFiRYz14TbX?=
 =?iso-8859-1?Q?rHtJIMfjmrAaFIEVlyAaMY+s/r8RaNOaFbsJ3ONkOaI8qdFiROsuw/34tT?=
 =?iso-8859-1?Q?twwmIFPOzbPA1TZc7IoQXek5hUIAQ4qiNCK0Q0088uM7aX8sV7LCCt/F6u?=
 =?iso-8859-1?Q?VZWqaKTKOi/S8Xc00XXEImBlDMghTv2RWf2TWdtVWvfHwT0/0fmA6L3NSx?=
 =?iso-8859-1?Q?CO3fPAa+39eEq3qvwCNh6jDeZawxik62dJmX1jc8StCQG6Wcnj6f++i73O?=
 =?iso-8859-1?Q?ORmq6Kb0w7cWwN/M8DuXMC1syKRo95uhadATor4AU198dMzPtMBJmjLatz?=
 =?iso-8859-1?Q?/YU8mJU/vhAKFHA2A72A2yfRvKYPTVWTTiV/m073MTx61P49QdZKyR8aRN?=
 =?iso-8859-1?Q?ZgKQ6pJaxMIbVsjG0HZVu/welChSeZQJVKZdNldtRmBPRgATUYa0274hm0?=
 =?iso-8859-1?Q?yP7XJ1DB0Z2jhkQ1fJzlpng5PcLCe2k=3D?=
X-Exchange-RoutingPolicyChecked: IDiy82/QfJywqqTeSxQIsqQo2ajHJGbd1/AwssPllq060zmL5/oCSYYwABrnV9ScxI8PGnZQBlYCzHZGU3v6HhjXr4EgkqSt6mX3M6JVDDDgQvl+48ApZVi2ysD2t0r6TXpxc1P3UHtaulgD/uDB0EaRqO6vW0LRuqY+4AYFHnziE1mSXshGOkXDl0xHtBSWgWaoaUP4dkkwgglh/YkWZ24xapnb+JsG4uKtLnfy1WAOVch4apoXOoTI5ili665dAyXW1Jo9ObdM8ZXumVWbyGDsBXzuRUPPmWqkkxBrv4CfV5lzcP7ZpRo5guQ91eWsMeuD+uGHfiWrp9kqA9KNEA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab30568-f5ee-4378-a837-08df26043fac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 12:53:00.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVwTFkM3eiZojLOFAgZrdaGiIQ9VyZVBKFz8djdLUYokYpxsCfZeFckCY6i+uia6M/WogZGobC5daJ6QxLI/gHDW6rw+uMEaI54AeJeZsjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 02:12:52PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Keep case names, functions, and hardware directions in an X-macro
> > header. The C test table keeps its order, so the test IDs do not
> > change. This allows the Python runner added by the next patch to read
> > the same definitions. Only the runner uses the hardware directions,
> > the DUT roles in which it runs a case; xskxceiver ignores them.
> >
> > Install the header with selftests so the Python runner can read it
> > from an installed tree.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  tools/testing/selftests/net/lib/Makefile      |  2 +-
> >  .../testing/selftests/net/lib/xsk/test_xsk.h  | 46 ++-------------
> >  .../net/lib/xsk/test_xsk_case_defs.h          | 57 +++++++++++++++++++
> >  3 files changed, 62 insertions(+), 43 deletions(-)
> >  create mode 100644 tools/testing/selftests/net/lib/xsk/test_xsk_case_defs.h
> >
> > diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> > index 066d011c478a..15353021cecf 100644
> > --- a/tools/testing/selftests/net/lib/Makefile
> > +++ b/tools/testing/selftests/net/lib/Makefile
> > @@ -28,7 +28,7 @@ TEST_GEN_FILES := \
> >  	xdp_helper \
> >  # end of TEST_GEN_FILES
> >  
> > -TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
> > +TEST_INCLUDES := $(wildcard py/*.py sh/*.sh) xsk/test_xsk_case_defs.h
> >  
> >  include ../../lib.mk
> >  
> > diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.h b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> > index c37423030eb6..e1ffd054c8f7 100644
> > --- a/tools/testing/selftests/net/lib/xsk/test_xsk.h
> > +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.h
> > @@ -309,48 +309,10 @@ int worker_testapp_validate_rx(struct test_spec *test);
> >  int worker_testapp_validate_tx(struct test_spec *test);
> >  
> >  static const struct test_spec tests[] = {
> > -	{.name = "SEND_RECEIVE", .test_func = testapp_send_receive},
> > -	{.name = "SEND_RECEIVE_2K_FRAME", .test_func = testapp_send_receive_2k_frame},
> > -	{.name = "SEND_RECEIVE_SINGLE_PKT", .test_func = testapp_single_pkt},
> > -	{.name = "POLL_RX", .test_func = testapp_poll_rx},
> > -	{.name = "POLL_TX", .test_func = testapp_poll_tx},
> > -	{.name = "POLL_RXQ_FULL", .test_func = testapp_poll_rxq_tmout},
> > -	{.name = "POLL_TXQ_FULL", .test_func = testapp_poll_txq_tmout},
> > -	{.name = "ALIGNED_INV_DESC", .test_func = testapp_aligned_inv_desc},
> > -	{.name = "ALIGNED_INV_DESC_2K_FRAME_SIZE", .test_func = testapp_aligned_inv_desc_2k_frame},
> > -	{.name = "UMEM_HEADROOM", .test_func = testapp_headroom},
> > -	{.name = "BIDIRECTIONAL", .test_func = testapp_bidirectional},
> > -	{.name = "STAT_RX_DROPPED", .test_func = testapp_stats_rx_dropped},
> > -	{.name = "STAT_TX_INVALID", .test_func = testapp_stats_tx_invalid_descs},
> > -	{.name = "STAT_RX_FULL", .test_func = testapp_stats_rx_full},
> > -	{.name = "STAT_FILL_EMPTY", .test_func = testapp_stats_fill_empty},
> > -	{.name = "XDP_PROG_CLEANUP", .test_func = testapp_xdp_prog_cleanup},
> > -	{.name = "XDP_DROP_HALF", .test_func = testapp_xdp_drop},
> > -	{.name = "XDP_SHARED_UMEM", .test_func = testapp_xdp_shared_umem},
> > -	{.name = "XDP_METADATA_COPY", .test_func = testapp_xdp_metadata},
> > -	{.name = "XDP_METADATA_COPY_MULTI_BUFF", .test_func = testapp_xdp_metadata_mb},
> > -	{.name = "ALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_aligned_inv_desc_mb},
> > -	{.name = "TOO_MANY_FRAGS", .test_func = testapp_too_many_frags},
> > -	{.name = "XDP_ADJUST_TAIL_SHRINK", .test_func = testapp_adjust_tail_shrink},
> > -	{.name = "TX_QUEUE_CONSUMER", .test_func = testapp_tx_queue_consumer},
> > -	/* Flaky tests */
> > -	{.name = "XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF", .test_func = testapp_adjust_tail_shrink_mb},
> > -	{.name = "XDP_ADJUST_TAIL_GROW", .test_func = testapp_adjust_tail_grow},
> > -	{.name = "XDP_ADJUST_TAIL_GROW_MULTI_BUFF", .test_func = testapp_adjust_tail_grow_mb},
> > -	{.name = "SEND_RECEIVE_9K_PACKETS", .test_func = testapp_send_receive_mb},
> > -	/* Tests with huge page dependency */
> > -	{.name = "SEND_RECEIVE_UNALIGNED", .test_func = testapp_send_receive_unaligned},
> > -	{.name = "UNALIGNED_INV_DESC", .test_func = testapp_unaligned_inv_desc},
> > -	{.name = "UNALIGNED_INV_DESC_4001_FRAME_SIZE",
> > -	 .test_func = testapp_unaligned_inv_desc_4001_frame},
> > -	{.name = "SEND_RECEIVE_UNALIGNED_9K_PACKETS",
> > -	 .test_func = testapp_send_receive_unaligned_mb},
> > -	{.name = "UNALIGNED_INV_DESC_MULTI_BUFF", .test_func = testapp_unaligned_inv_desc_mb},
> > -	/* Test with HW ring size dependency */
> > -	{.name = "HW_SW_MIN_RING_SIZE", .test_func = testapp_hw_sw_min_ring_size},
> > -	{.name = "HW_SW_MAX_RING_SIZE", .test_func = testapp_hw_sw_max_ring_size},
> > -	/* Too long test */
> > -	{.name = "TEARDOWN", .test_func = testapp_teardown},
> > +#define XSK_TEST_CASE(_name, _func, ...) \
> > +	{ .name = #_name, .test_func = _func },
> > +#include "test_xsk_case_defs.h"
> > +#undef XSK_TEST_CASE
> >  };
> 
> Hmm. Maybe not for this revision, but I'm getting a vibe that we're
> mixing reusable operations with test receipes.
> 
> Ideally the operations would reside in the C-code, and the recipes in
> Python...

Yeah this change was about adding new test cases within C-code and then
letting python side consume the up-to-date list. What you describe would
probably be something like testapp_send_receive() is the reusable op and
test cases would sit in python, prepping the stuff that is now being setup
within C routines.

That would of course pump up the diffstat, so up to You and drv-net
people.
