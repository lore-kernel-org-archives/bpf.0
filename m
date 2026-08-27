Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AB4749D1;
	Thu, 27 Aug 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840379; cv=fail; b=WtMumZ1yT6lviBAtAqEjF8II7s9pphbnfaYMdhcA4v7vP0L4ATwCEBYa5HI55i3mJJ7Q1GRZTrTDtjG8+8qTMNQcUYcqRo5F2zzn6LgEnZ2RTw3yTAcUfajszsVc2vpwh8cO+/j5ih0OcH7f087mIQ7cG11+wdxPWqTpDwYNDtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840379; c=relaxed/simple;
	bh=QQ8oEK/QCHK6wjoD8+anzSBUDaV7voAMkqTcqdrGkgk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBGdMhILtLhYh6VxmQPtmoN6LMXIMPfPwUdqOAdRny86qaqJjiI3421ePhw2lH4Qw7r4wD5WEFTbW5EF6qog1CNjW+gHc4xLCcMsirscIxNXOat95nV0sg5vHMKnh2mqJE/LEU4H0foSDfVSiOXtcsQ1W3tE/lAgJnMn4zfGHdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJuXQ18+; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJuXQ18+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787840375; x=1819376375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QQ8oEK/QCHK6wjoD8+anzSBUDaV7voAMkqTcqdrGkgk=;
  b=HJuXQ18+UuiJOd4WaPOKts1co1bBP7tFyvMC+/cnBkGXYW/QGZhv235O
   Ocb6iJsMgIuwNjSwxhNjZH8Wh229ewmXz4R+D4pSBARG8COcu91ZOXZLI
   S1N/KDqYQvz8EMwHjVV9jZatAScICjrpPgGirt0IYBKLwgLcOAJwot+cH
   g7NIDa7ReqB66DT+Mb5VeG1CC7eODzQaHIjmMWzdJ5FUZaHPl4nD+YXEY
   Mb+jDT+ha3I95lZQScgQwjzwhQX8gyqceR/czmfMq55v+Yx2Fwp46ECBz
   O4IwPzj2AhxsjYICmcy/Dir0m7JNd72iqA0GYTV7xqPpiqjovc+t+67Xe
   g==;
X-CSE-ConnectionGUID: bKh6C24ISqaW+Pa5ZRLFbA==
X-CSE-MsgGUID: Xjm4L9fLQfisfw71fgSloA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88546435"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88546435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 07:19:32 -0700
X-CSE-ConnectionGUID: LIuKzvc/ScScQM9/esS8pg==
X-CSE-MsgGUID: nnzz37gMTJKitKTdjA83NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="269830797"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 07:19:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 07:19:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 07:19:32 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 07:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDpYIziH2kmqlcai/nyNXgC3VMlRqb/s4ja8q3H7p6LejsOOqfsZ/sTyaKMIOY0a7mgcV75NuaGkli4Jhpo/7l0rIy4M+PoSLGH2ppnc2u+z01BwHr42VUMCwERwbncF2+u9w1jpxV7v34m2o7ps/DQpImzJqLmlvEUqCX8114Ht7yAbEuFRQ61GjvQduexR7iHxR02vi3qzxZRzsEft6oscxHcn1VU007+OuqqjasAPomNz7YaIEkcfSga9lHE2PezOd8X+Lm2x+t3ym+EhWseUwmeFg8GLbzhheYcQ/mSrgv57hTm3Ua6iPOTzDa1M4eiKwUDYzj6+ibvHZouEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT4fTxYMJcsaC0zthdt8fNN9stGDGVl6l2h6OJV/ATc=;
 b=Komug04gjT+olSfsZNXBa37qQ8Irf54SuwxsoETpanHC15eEvLV4F6VJq+yF+opzEq96fFTgO3njemtczqxWxe/jKP+dzge/zrYd6gaw8pt18jZEqEH7gZs6jN3N2wa1EbNh42K8ZkLDSDH827uTwvk7OEN/Vv7dVCmNGU4O5JEsMFz5GY6U2u9n5Wlaa205pTeT8xTSFgjBsrdYlbwEsIuQMcajztOBQgwv3SpigVB0STjzsdEn9F6bVjEwAFLPSc8nkHoFyEInvacuK5Pvrq/H5n4h5w16E+lfyW5tDExU3gG0MvB5pSxJb3zo5L2xrmpqFgZefXi7EOsRu/FHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BY1PR11MB8031.namprd11.prod.outlook.com (2603:10b6:a03:529::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Thu, 27 Aug
 2026 14:19:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:19:21 +0000
Date: Thu, 27 Aug 2026 16:19:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Tushar Vyavahare
	<tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<kernelxing@tencent.com>, <davem@davemloft.net>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>, <andrii@kernel.org>,
	<bpf@vger.kernel.org>, <bjorn@kernel.org>
Subject: Re: [PATCH net-next v3 0/4] selftests/xsk: improve shared-UMEM
 coverage
Message-ID: <apBHXkxgq3XNEEy4@boxer>
References: <20260819024443.781764-1-tushar.vyavahare@intel.com>
 <a602a1f6-e279-4c7c-86df-1bd0ef244fd0@redhat.com>
 <20260820104419.050cbc44@kernel.org>
 <aoc+/OW8Gy4ZOx+w@boxer>
 <20260820142920.6c96ec67@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260820142920.6c96ec67@kernel.org>
X-ClientProxiedBy: AM8P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BY1PR11MB8031:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c1d75f-a7f2-4f35-4c29-08df0446303e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|56012099006|4143699003|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AOwFfZSo0JOpD35x8wp8JgbIy4/ybr5d/G6xFyceZ3o1tL+2l+RUAuDMijopQ7BLeo61OvlZKF7GjIal8Fg3ONjFU6vpWRo/2rNONPgMMTNxaoot+j0fIaWdjSjtzhYF8523QIaXxEO40J25t+AJR1SL+/s8rCVbCCmIBwM2Q3suE+FSUBquovOwHe7g5Md313IqTIBOUqVQqqcd4lnoyD0Kbn4M4AT/eJ2ejGhx/6d/B0JK/YN6b7CNJ/Ym81nHAx2VOUv/drr/ioAMFHoMQGGtvs5fO4kgjLvOMiYupeG7tR5lWkvqnfY9GjyYn0Vufp4XSHKIaH06cCTKQWwuOQfAYm5QfBym0JzrqMi+yI3ZmPlLQSF/t8+DvE9BYGWPMmC5Kn059HczugNsFLpqWZzG73kMh12e4pmUxUqLRlnJyfQS9gDjOSEDDm442cJmY3Ryj5LXD/lTTiNHDnl6A9NKrAkoUaZV0VaNNFGspDIAQyMa2TKkS1JC825NqaA2KbGErhEBuuwgA1RycxTYFcQYnYWwT2pvm4KWeiVN1AgsnhlmRO48XMOZtKr4Rc8LAkz9BdiMjyNrG0BFyPwQIrFKaTmttXQd6Xnr7/itCdmn29hhuh29bC3mVPF1aCiXxoyJcgNJ++Q6J/l8Q5oWmGMIeldck+N+qfcSd7cXxv4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(4143699003)(6133799003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qx86e30FpsET7cTnBuwfNfXHPOdEB1HYb2JrKMeOVQWPIaFSnaPETVz0N7TL?=
 =?us-ascii?Q?iGXeRKWTRzapjlSiX/Uf41jblWKA0L25RwZG+MTIq5yFwZULYENm7T0lFaWU?=
 =?us-ascii?Q?0sXxqguJfeclmIbVRyHR9GWqfVHE4pRBYrD15Z7rN+dDFuoKrx8/qwx2CsJx?=
 =?us-ascii?Q?uPLZR1PKI6q5aCA7mSqnD4gg9fGG8y2IeAWpnYCwsJG3ls8RswE3Y4ifU84G?=
 =?us-ascii?Q?eIo3DP4la/zaTPoxd6kTFoTed+ZuutnITJzs7an+PUpGV26/OYNwJY+uWC4a?=
 =?us-ascii?Q?36oU7Mm4z4czxzHweqXwITLJv1+c7HfayXDI3Tat9pSjADo7d7PUqIPuQLZs?=
 =?us-ascii?Q?fUfDVZbO7GhqIUyxyWkDVVjtcGAAi1TlXQa34GL9hoahXAIEFuy1Jkm0CIHr?=
 =?us-ascii?Q?W/6K4FM6VLDAFgje2TjXyBYAvjeJyt8hifGe0uEo5gj9T6fY7VAOi+8+Cmmp?=
 =?us-ascii?Q?pK+b/9t2gPGRSkw4pq5IxP3eb/xhxm8VbbNamoNzo1iexej8EL/8Povbjhi4?=
 =?us-ascii?Q?2FSZWPZhlaaox1CvzqCo+cgvowzdCVg/pnyw2pj6kgFLoBXQxQA8uNmh0RIZ?=
 =?us-ascii?Q?bDjnZuWjOOwxzVdgiDLGjniLiu2ybbmgNAcwBy6uzvGyLNz3jgVX1ELnswHa?=
 =?us-ascii?Q?XFpY51IPJ+vsFE6QNFmgJHSG1bv5X6MAUShSal437BgZ5GuXGCu7fpgQ494Y?=
 =?us-ascii?Q?hVP/aQOv8CpCH/dDGFKDEGUeKb7ghZn7e9Fs2+gDrziiABJYnqJ4aTk4QzUg?=
 =?us-ascii?Q?3DHE11EX+E73CP7MhW0C/MgpHLsGujpDbK9u8hwqUqM+20AInA3ShxnnXEtv?=
 =?us-ascii?Q?w8FHk9WcR2f2HcHMe9MDikzfJ4Qm6OAoVO6nvmT6vFC7J15fJ8vRtxB5wums?=
 =?us-ascii?Q?I9oEaC5UuY0P+KF9QcTzCTrLuwZjkP3iPvcSSI/5gzhwxdjsUUowBT9a4OJi?=
 =?us-ascii?Q?4t0gP2mfzjXQdLmMXmOQCyfECzGYThD8uzhJVVKDXwqhAJ0KoZfL3Tcnk98k?=
 =?us-ascii?Q?xe24hHjqAHPQj2jnIgarkQ1oIMC6jMOtgTVrxNbzz5LnhFyG1VBN07K4II8w?=
 =?us-ascii?Q?bDM5Yri/rw3+f2cPj7v40vOSgYpET35OWP9m1rs/OkrFWER73v7NWxNBLKdj?=
 =?us-ascii?Q?L9WIDUBbf2Wa9yaA3L4VPCgQsoBNvceOW5Fd0JeE4EcBcwgVuxA5s5j/O5Iy?=
 =?us-ascii?Q?6o6a9ontGgxPj6J/oAOnJGRv1ACm+2BtU7KLP6PzJGKKhfSwQfB6uB/Mn6vK?=
 =?us-ascii?Q?mS/t+lxyPA2qAcXk7vWo6i6ANJ3pWrQqr4rPOqAZ5up9KPAs7MOe4ESPktX5?=
 =?us-ascii?Q?wIkLa+LVwpgJwwl3sMS90ELE6RZc/VJbypWsZDQddrkbpWy4/abwNs93KZ80?=
 =?us-ascii?Q?/SVyGlOEadHOaesWILAM3Umb0VJtASTpWIlN6aVvzEidBcy4v0+qg32EIkik?=
 =?us-ascii?Q?zXW5SAZs1Iw16aY2Boz0fU8lgoUc3pmhK5HlvgmCUd2aZycz6Y61YGrb9ZEi?=
 =?us-ascii?Q?AH6HN1WwT+e4nTxxsPPecXQVDG2koAUOhhwD7EqY02T2WnHYiQCUlOry05v0?=
 =?us-ascii?Q?voFJdUmU953sX9iWwf5ZkO+0qVcW19w/NtIxocR+4BP6FwXW67NV4DUp9U0w?=
 =?us-ascii?Q?cTu/L5bNJpuQovDABuyVhNXxefwnENzDhIsi/SNpX2pepGpgPkXDSuFoPrhn?=
 =?us-ascii?Q?89/clNEFmfKRdd+CIjszP+TcokT7hnZjCV17PXQBzAxCjTRjhpOU1PJKEbkF?=
 =?us-ascii?Q?CZyQpBt8JrMMZfDiId4Z+eF43EzDwH4=3D?=
X-Exchange-RoutingPolicyChecked: a6kZIpsgBYvX/ZKLN++Cu2D+vGBF8UIBCU9twTKZXkdds9uFZE98c3ACN9nbX+hemTnRNVAf6kvXFbcKgLFwvFD2oy6kLFzwuF5qK+Z28pse98nlTpO2b9DqcHWN69ht4v/j7iZ7k/MS8kGus8kkjzyTMQJY61OlYIiUj9X0blwQvX76u9YoO9aW5dXpW9X+U0znd56+mjDtQu1lInh/JhPSCO1v9oL3AGQz5c5CtJ5WA8Kh9W8OhE1uBeAw95w90YyS9YPt1+yoXFluSkMnf116W/egdfU1btQwq0T0Sp2tb0qM7x4sS0ScC1+atSBV3eQzPYUw1O6MVyaxiSU0/Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c1d75f-a7f2-4f35-4c29-08df0446303e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:19:21.4944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JJHjjhXjmxof/AzyKX/cRgR8Z53/GMlC0iglMYQJOx9pevoyFuE2aODOkfIJfanAbPwku+EpXLKr/vU3x3YpFzN3BzTxINjAFDwwsDjORM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8031
X-OriginatorOrg: intel.com

On Thu, Aug 20, 2026 at 02:29:20PM -0700, Jakub Kicinski wrote:
> On Thu, 20 Aug 2026 19:53:00 +0200 Maciej Fijalkowski wrote:
> > On Thu, Aug 20, 2026 at 10:44:19AM -0700, Jakub Kicinski wrote:
> > > On Thu, 20 Aug 2026 11:35:53 +0200 Paolo Abeni wrote:  
> > > > ## Form letter - net-next-closed  
> > > 
> > > these are bpf patches. Tushar, tools/testing/selftests/bpf is BPF  
> > 
> > But AF_XDP is now net target since some time. Should we move the test
> > suite out of bpf directory then?
> 
> True.. but until the move happens it feels a little awkward
> taking pure ksft/bpf patches via net-next?

CC: Bjorn

We had a talk about potential next steps and what would take to get this
test suite executed against HW tests. tl;dr version is that some of the
work is needed to adjust it from infrastructure POV as currently
xskxceiver runs as a single process with two separate threads and what
Bjorn was saying we will rather be needing two standalone processes that
could be used on DUT and packet generator.

Overall we want the xskxceiver's data path logic be reused. LMK if I
missed something.
