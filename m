Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D79472F78;
	Fri,  9 Oct 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549980; cv=fail; b=Sk9+I147LcOuFDNXQFHwPWrv66Ljqe50/IS0LI/5TzZOQbeV1pNb1h4gg/Cm2tpIV8xCLIMJJJK8IgeWWP1j042hWTNszs5NjcdiKRYYcismGeRiDYjyCA95Hf84rn3CVb9HGHCLfW4eqZke4QsUGZHXgLJWBKzsqMO95Y6oRqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549980; c=relaxed/simple;
	bh=+Sx3d3XhdzVMgz0oTIoaJp1iHlBdAgpfu4TzS21ZJGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RWjwzL0q9Fl4D3K3pFMAB52bDhymS61AxOb6GgHiba3Y1TSwsC5+1YkgYM8hiQds3I2N/4w4VJvH0TiBDE44IGaZat5D4ydH3be/RvrfZLBqdfCp2lbaQ0hcmbnHsgXozeJkueTWMP40YtklJfFl4XDtPvgqtW4TVCqjdaGak0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKFaVeL3; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKFaVeL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791549974; x=1823085974;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+Sx3d3XhdzVMgz0oTIoaJp1iHlBdAgpfu4TzS21ZJGY=;
  b=jKFaVeL3/CroQyA9ca1OLEGWGFTO+LOLXIjVLnk6KuKn5A0BM9Iru3AC
   gQHSFuEBjaSSHLsvynauJByhx/GVMmUqav1PHxKEf1Jmm9ZYwjNCxEIe1
   we/HaYqzr3pIX/5fE7NuEXgX9a86RictbUi8SarqcPWDrDKC4oTb88hpE
   JdT/ESe3LC13RAo2GoTMSUGqbV0zkETLwhRodfgQ2aOVh4utbS3Iw/HWh
   p458AGqq5HX3u5eZwAs3Y/ntKeVOzjN9piZsaogar0qKXWyxPdvocFJDA
   SFogYJWsGTA1lS2qG0cy9JKqwLbJurhqQ/aGbHqQTOrrokgvq39oAplax
   A==;
X-CSE-ConnectionGUID: sDdpy8fPTu2H7/clP1n+tw==
X-CSE-MsgGUID: W0f4YaX4TpyW3092WABFCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="359212"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="359212"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:46:13 -0700
X-CSE-ConnectionGUID: qRE33D5qTyaj7Vqi//rD6Q==
X-CSE-MsgGUID: Gc0066fkRR+3PRYYjQPQWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2129530"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 05:46:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:46:12 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 05:46:12 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.47) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 05:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBaUnlwkXL7g8TFF1U05oD1mE/ixUSsg/J+Ejn1fP9YqrrxE1CSiW745Na0It6B4+guiq7tkM+vLbuJHLOmQdBiDkJ1KybSEam7Sugjv+beL9Jt5p2b3RDUxdjCwqmj8cX5N71XN/MGzSD6Ue7NAM1qXhBl+OD6yUOkEYc7Wq6zcp9IG6OMg48hR8uUt8hiEQ0E/RSP3HvCovDbQfqMVHZzNjRxHev1BQPWy6Ls1y2wuaDICimiHxCVdnEd+8oFkv1jzQRQor9UkFRCtPrq5tQnYyO17JomkxvT9A9VfdxEfuXUSHGoJ2FK05oP2jPowoiYqL5utAw8SMzL/vUHTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idmuLttfdlMeLaaRQ3k3brygBBWLlFo5SbPlaD+rivA=;
 b=gzndbdJyljctWMb+On9oBx8DETHIaK/v7Cqh4A6y6TwOZhEeJyiTc3DOZTsMhoIvRrdv5GUR8SFAplqHpLvHRTe60OpXv6TAq2neFgpOJ8zTVDnCozqsWkH8mieY0Qczn4eTWmImGTOZteW2LhLZXsnq1eDN7kYEtuamcEDJzMXl8JWJjpdC+hBIQIaCR/oDtZFAQmex9PcKpB5LIfRDNdnG822O5+0rL7Xr1BJ8M9pc5o0AgfW+Mrvi0l9d45620I2lsNQrRXwASTnepe15MVOt+JnmLM1jAhIOpH5dzo/7St5Ig64g44reGAV6UTgOCTAlqevk0/aYteZ3VR8LBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB8013.namprd11.prod.outlook.com (2603:10b6:510:239::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.17; Fri, 9 Oct 2026 12:46:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 12:46:08 +0000
Date: Fri, 9 Oct 2026 14:46:02 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH v2 net-next 05/14] selftests: xsk: move the AF_XDP test
 suite to selftests/net
Message-ID: <asjiChSGMlD5Xo/I@boxer>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008114909.734364-6-maciej.fijalkowski@intel.com>
 <87qzhzqg0d.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzhzqg0d.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: WA2P291CA0041.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB8013:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b340ed9-5ce9-40e8-7d64-08df26034a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: n2WhHTWNM1LHOTQjMykDBLeUy7WYqHqrWqnYF3O3BFEoGgmnUqcnrcSEEEYcd+TV0fnwbgN0SJ2S0jdJj7usdXONq8PkqWaEzG4laYC+LeQvhyGhm+VUJZS55f9jFozTuAwlOjoD+5GVJy+8VQvK5p/CI3SZ2TQliLrBy1NktdarypaJXCBpQaJBhFt8UeySNVzcD4iVOIgoEuUCkYRM0LdIpFFwmyUWEyGex9y3spvKmmiHPmsKU4PhjEhyqE/M5YYs5Oo28mUCjgx4lCDAqx6GiU13D2MSUAuDb/fC5SzkyYiISZ95W7wpTri9L+1jaZgxrW8FLPglpzft45tb0yhiLa0ttn54KaKbfhrZ8a6DzPb5Ql8Sbpyfg4hEto7J45+aPxJiC52cPfkQUbmU0DwxDokCvp0EK0kPXEco+zXPJ8ARiO49S8DdoaGOfHu4T/RAvYXlfmYuiTkl/mxlufQT3Od965QQjOf/u3Pi1gyrt6l3QtsmtwYyfA11KAaxFhK+PtiJhnsmfCMsG5NZbJmE+S66B1lzT31R56y8GhUFyz9F7d6L1GofD07aq6NZ/hE3nhWNLCiYpVMDNMq/T3JA2ddRtgbTd9A1N/uLL/7DjbGJvGHppBtakJLC5p3Mph1ODxcX93DOGaJPp6vtR/6f3NPfJdgTJOm0z5gysbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Gpxf9vUh9V1rdwdydqWq4bDj0tRNRE4VrjiBa5P8fhj1emG9Byuy8nXN45?=
 =?iso-8859-1?Q?knAkzRDnN8751baeqan1L5otIE92bfOhN0K/qKIk5ezKMJcrVxS+JpS+3F?=
 =?iso-8859-1?Q?O2HIkQxqB2lho1s/ykcGq6hlhAYGlEXia7Cc6AZs51V2Tk3m5L14UcRnFP?=
 =?iso-8859-1?Q?1rIbTvmtVqH/cIjoRiegx6PA5o/D7ysrae4f3DQu+Xwc02p9/bYSwunmlG?=
 =?iso-8859-1?Q?EZLi/Zux0poeny6E4hIx7uk74zbHZimFJoxtRd9QO/IC9Vgkv/IkzrRG6G?=
 =?iso-8859-1?Q?GIztEgHthtQ+sV0MP3RvGjc6eX2XiqGNiYYlv/dGC9ntCihbfRPBWM8y/+?=
 =?iso-8859-1?Q?dlAvOwHXmqAV6oQZTklxsiBCImRMLrLIZ9HEgVhdrgZnf+p/5FmVdo2w7X?=
 =?iso-8859-1?Q?tjXBuDvZ1JRajXlGeB9ZyftrqmjB5mSR6C/oa2Ob6sJUizvuAvPt7KgSs4?=
 =?iso-8859-1?Q?XhfbV56FbLGDE5rZycZ46rjzyBDzMXvy3/3IVMkMxz1d9/9mRbzKeu0IfH?=
 =?iso-8859-1?Q?8MIO9pUSOENYDScmiaK9o/tl3moX3+ZtVc4barjE3M+XrgzRESW7OSsAWY?=
 =?iso-8859-1?Q?FHRhuaRhJcdr1R2TpJKhIfNJJcqj99a30de4p8eXpFharrv3COVpTPHrVt?=
 =?iso-8859-1?Q?G83JKoEAd1/a0uW0WdT4nUvj2At6mooWpLMOo8yMDHOIW3NOI89mxHZ0L+?=
 =?iso-8859-1?Q?wNWZvkYJStJUC4EzFOZbZlsHIO1oWcCKzT7r1N1NrBPHXoSm92CmO83HSB?=
 =?iso-8859-1?Q?z07aN7jb9ZvtBMk56YVcoaWJdfnLfnv4APYyUpvS5hbdj4JjLMQxgGLVCt?=
 =?iso-8859-1?Q?wITk59ZR3se+Xusvn6NR7lwpsc+X4/QTGZWkgN+zL1Hj0LjENjyLE97xNo?=
 =?iso-8859-1?Q?Yt7ROaqf221/0deMSJqUnz0ovehDle86bUSKuqFnfk503uRwI2IqHnPmuT?=
 =?iso-8859-1?Q?RGKumiDXympLbtpwA43zRl51dkPeU/jDcWntM9odIJWJOBB4vG4epzOigA?=
 =?iso-8859-1?Q?air0WN1Sla5lMdyJSfhsDL48EpTlk1Y/Nq/dWNnMwB/L7NRzvGha781h4D?=
 =?iso-8859-1?Q?oDidqnXW00C4Tkzr+mOkukTH3XdfOHF+grAHmQjmr+DBwVyCuNK7xSvIKk?=
 =?iso-8859-1?Q?7kCom100FUBqIMJBHzy7I8O74jrO4ZDNBufl0sVHLzlaqs8jiUmiVJr0ES?=
 =?iso-8859-1?Q?t9+fSuEXYzZI5xs0Q+W1QoF4Juvq4qJo+KmLTXkYzWNw0FF47BW+p2/+2z?=
 =?iso-8859-1?Q?Akp9GuWpzWEx8JfyBvgC5O1SZfwpzUY5RbKRPoDrUTYhGo05Tl5Q19VpvN?=
 =?iso-8859-1?Q?d8IDYYimEDC1bSLC3g41JxfbZ9h6DrbbACifhPlEGLPwpt8ioyBVjJNFTK?=
 =?iso-8859-1?Q?DgYeB0mmGrtCREfHH+6XDTbehd7DZOkDTEbV7wIUDQcGSQ70euUpShQv1Q?=
 =?iso-8859-1?Q?BOBBxvC8llp+NQEbClToNCF2iVg2hIy1pibdN3eX2oebbgaSPB5jlhlqRw?=
 =?iso-8859-1?Q?EWWXaq1+YpihoAEKdd96aT3YjzfAjzAFFZdy9JytKmOwsKA1+wnlugNsdH?=
 =?iso-8859-1?Q?+kIrd/UuKihTfLKyNR7gUM75ryh3R5CO7e15CRAfnv4XbLsDQcQlfBiGdw?=
 =?iso-8859-1?Q?Rg0f52/ac7Ci5JOJZqq8FVyCPqspBCPQCb9jfLzfVl/17DlbvoenknAiop?=
 =?iso-8859-1?Q?0m3GwA2zNoV0E2KseFaUtfQVzzEKOytHuUHoVKqnLZR4VyqqU2AYZWWqGi?=
 =?iso-8859-1?Q?nLRcawFvUS62xba/6L/A2Y0Ta6Hl0AFusj1MnSy9Hlg2x9vkV+hHswHtcJ?=
 =?iso-8859-1?Q?5Y//PC3qgxIpiYCEkYQUFpvovD2uWK8=3D?=
X-Exchange-RoutingPolicyChecked: zoU9c+PpXQ580IYkLOd2NuaZ5rPhkDjvciQv2dKinYjJerWC9L6/iPd6WHHHiKRzKOoBTX/N3TOimqtv9I4Nk++Bs+P+sCBcTZPXR6f/R4ukF569Y5gMWyhFtBVS1cGj29xETTPDb/YEm8Eb+sDPdnsVsFkfpGpXEM41UzIqE+QAzCFWuA8V4/c8uMOnI6uLMebfcl7qPiZIzysoQ9GCeutI0Nlo86lywD/wyrInWAvcz9tRWXlR7O4rCAVExxV1Q0yLu1Bx07Vhz1SXY7M0usE0n1IMFbj1wS0igyt7HcPBFvqXY7o1MB9mMU5zuvM4nXMp8PKSDTKtPJ8UH/zhbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b340ed9-5ce9-40e8-7d64-08df26034a43
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 12:46:08.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BPwDfP/bkTiJ95sF1nlkn7O83rYvFTkw4xhGmRRv1yySQiXDI4I1S7P8tjxhFtIJoyWvRGcer81X83zLnEb0UFtA07paDpeU8/WjfJE0H/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8013
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 01:18:10PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > Move the xskxceiver engine, the AF_XDP userspace library, the test
> > definitions and the XDP program to net/lib/xsk, and the veth launcher
> > test_xsk.sh with its prerequisites script to selftests/net. A later
> > patch drives the same engine against real NICs from drivers/net/hw, and
> > net/lib is where both suites already take shared helpers from, so the
> > binary does not need a second copy.
> >
> > net/lib builds xskxceiver together with its XDP program and skeleton,
> > using the bpftool in PATH, and skips it with a warning when bpftool is
> > missing or does not run, so the rest of net/lib still builds.
> > selftests/net installs test_xsk.sh, which runs lib/xskxceiver.
> >
> > Like the rest of net/lib, xskxceiver builds against the installed uapi
> > headers rather than the tools/include/uapi copies that the bpf selftests
> > use. xskxceiver.c got min_t() only because the tools copy of
> > linux/netlink.h includes linux/kernel.h, so include linux/kernel.h
> > directly.
> >
> > Move the two ethtool ring helpers from network_helpers into xsk.c so the
> > engine no longer depends on network_helpers, and point the kselftest.h
> > include of test_xsk.h at the net/lib include path. The XDP program moves
> > unchanged. Its Ethernet header bound check compares pointers of distinct
> > types, so net/lib builds it with -Wno-compare-distinct-pointer-types, as
> > the bpf selftests do.
> >
> > xdp_hw_metadata and the test_progs xdp_metadata test keep using xsk.c
> > and xsk.h from their new location.
> >
> > Point the AF_XDP entry in MAINTAINERS at the new paths.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  Documentation/networking/af_xdp.rst           |  6 +--
> >  MAINTAINERS                                   |  3 +-
> >  tools/testing/selftests/bpf/.gitignore        |  1 -
> >  tools/testing/selftests/bpf/Makefile          | 29 +++++------
> >  tools/testing/selftests/bpf/network_helpers.c | 48 ------------------
> >  tools/testing/selftests/bpf/network_helpers.h |  2 -
> >  tools/testing/selftests/net/Makefile          |  2 +
> >  tools/testing/selftests/net/config            |  1 +
> >  tools/testing/selftests/net/lib/.gitignore    |  2 +
> >  tools/testing/selftests/net/lib/Makefile      | 34 +++++++++++++
> >  .../prog_tests => net/lib/xsk}/test_xsk.c     |  2 +-
> >  .../prog_tests => net/lib/xsk}/test_xsk.h     |  2 +-
> >  .../selftests/{bpf => net/lib/xsk}/xsk.c      | 49 ++++++++++++++++++-
> >  .../selftests/{bpf => net/lib/xsk}/xsk.h      |  4 ++
> >  .../{bpf => net/lib/xsk}/xsk_xdp_common.h     |  0
> >  .../lib/xsk/xsk_xdp_progs.bpf.c}              |  0
> >  .../{bpf => net/lib/xsk}/xskxceiver.c         |  7 +--
> >  .../{bpf => net/lib/xsk}/xskxceiver.h         |  0
> >  .../selftests/{bpf => net}/test_xsk.sh        |  0
> 
> I would not carry the test_xsk.sh over. Just do a Python variant, like
> the drivers/net/hw/xsk.py, but for net instead. Look at the the
> nk_lease.py pair for inspiration.
> 
> It's just a cogitive load switch between Python and bash. We're starting
> out fresh(ish) here.
> 
> The Python ksft world gives us a lot for free.

Plan was to move fast as you wanted + watch the code churn not to blow
off. I assume now it's better to take some time and do things right from
the start.

> 
> 
> Björn
