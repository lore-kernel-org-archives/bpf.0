Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D5C49BD74;
	Fri, 25 Sep 2026 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340420; cv=fail; b=VFeWw4abNRmdgJlmNgCJNuyiWzPV1lhuYsMTUACnsogrvYQZI/5Mzga5noKtu74ZEhXGxKK9gMzMMsDHE+fXnL5cxHpu0Yoqhs70yvQc9bVkLSm5RKg94+exc+dvnvj1rxOFOv5l8OJy4RrWwDJ79bZH2KjAWq3aZLs8alstT3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340420; c=relaxed/simple;
	bh=W4j6RHyIcOmx2s3nhwIX0Yoc17xL5Kca8bJE1I9cKNc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WcP6suWX2f6FeOYcHTN+QANBmatpq5on4MmRL3EfB4XsBnU1BgsrfAhmiqJBiaHXzj7RwUCpt12erlRY/+6f0Ug90dnqBbye7/xzO3JW+coXi7rU+NJ6N019RhEAi7WhVd6lTuGrR2Qiw91t0wPYM6fs1rQneTDpT3gah2k8vzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdL5KMLh; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdL5KMLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790340417; x=1821876417;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=W4j6RHyIcOmx2s3nhwIX0Yoc17xL5Kca8bJE1I9cKNc=;
  b=UdL5KMLhnQHtwGzLFBkl/espWlJ/od/gNq2C+Rp0oanHfwbTjcp/dUoB
   FCQAsD/ma5K0+8RcZRF5EFc/NwbFfG68XVqI1/k3IAmM7gt/HvktFBvP7
   i/OjuROJt8Kibr7DsQ4s892o8FPr2635lVIfcK8W/vLgII3yJUVTkSPiv
   YCq6RFSkQBUFuUoBd3s3Jk1NEvCJQ3jCW0tPBL9p1TlwDNfE7TkrI6ZUH
   dkxXLnLOfHAC46Qq21AVKERaP2xZDkSSns6N8Zs+zB6okGU25xlI/sbCX
   SuCyhd+KLOObgjSOgrlAWTFobW3Vv5YbOU98bZJV5QXNRRo5pukGldNmX
   w==;
X-CSE-ConnectionGUID: A0I0RDdeQNyNyoDCBZObkg==
X-CSE-MsgGUID: /5LluWPGQQidpyvFETC11w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="94942218"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="94942218"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 05:46:57 -0700
X-CSE-ConnectionGUID: xZ9f3dOBQRaPeKnm1M6xFQ==
X-CSE-MsgGUID: c/C6l+syRY+dUuiLbNA3uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="272904561"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 05:46:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:46:56 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 05:46:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.1) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 05:46:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejyiMILHIjCz1H3rbD1hBtqWvmHKPNSvWs5/0zxWzr6JMw9pjmDbRaxHRPCrwcPo0dkRxKvbZ47y8V8A4hzjU7N1OomXiVdRmcgLITXjnmWZRNUlASYnT/pyNS1Cozj3F7lOp74yBti1UBsm820YEu6YJoeL+UIsgRnDazLeQ+k9DYEgU5AFqsVDcTmY9E2eefUdhXMaUOM6tmCpR6d6s/XQsDs4XRQkvrelM55lEfYM0FIPxr4/vBtjswkPu87eF07vptuAFWyeOghj0Mrxf605vfdvIGWhsnz3gvLS0P38IA3YjbD5RzJlZH8fpZTYHXWIAb4KFxAUPxe/fDWAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOoJVZOMD0LH7eYU6g02TqxC3scySwM/4ykz98kymtw=;
 b=VVkspmLrK/Sh1EtkT9hLUg0grK8Bz/zI+Ro3qbJMPdMHVDZ0lTcpibaDISt82U32ZnCs0F72YXFadpTfz0Dd2bINFq91vMw7OAtKTNks3h/BLZFcCMRTF+dFAMfRfmBodGjsGZfo15W5OptTsOdRxHimmUqJaZjH4RwPZKQnQFab4sbjWhyeeV2IddydhWlQ8qVGFgCLs4RvTMlHl4zFHVSWD0bmTM0UiHHkPFmi9Z+P+mCvxcEekiMx/g91KHOSbRR9X8ZnDURj3NQ3nOVQq4mHernA8NV2loUK5BIl850S74DkjlsC+F3UAopf+o6HA8q6bRuZHhMWOLsARqlMew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 12:46:53 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 12:46:52 +0000
Date: Fri, 25 Sep 2026 14:46:44 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <zhaochenguang@kylinos.cn>,
	<magnus.karlsson@intel.com>, <jacob.e.keller@intel.com>,
	<przemyslaw.kitszel@intel.com>, <jbrandeb@kernel.org>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
Message-ID: <arZtNCWXQMA5Pm+/@boxer>
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
 <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
 <b5e4e86b-356b-4ec8-b6c9-e5ef6a3b2d50@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5e4e86b-356b-4ec8-b6c9-e5ef6a3b2d50@redhat.com>
X-ClientProxiedBy: DUZPR01CA0075.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DS7PR11MB7905:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff16126-8e3f-4b58-734a-08df1b031201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|260925021311599003|4143699003|260925021911599003|56012099006|10067099003|11063799006|22082099003|18002099003|6133799003|260925022911599003|3023799007;
X-Microsoft-Antispam-Message-Info: oago0i/omJdwrA5NM0kyl/bK59TsobKJaOgttOac/fCZcdaw6qEyUmbFZPXDQt42ZzPf5KhRb5NFZmL3FnPiAxMem29PTS0DcvhehN/8q4CvA7K7LUl6Fmq89iJxTKRQktLvDwRANHWUJ2rnoaIRUxsSYhNLVccKzWcFS7/b1pEFhrMp/9gDm2oUXNI6hXgLBUxiy8G4XjRZAOmsfjyw9OE9yv1HS+hg29ZfotlWrUt+qymffwRcAXJs1Gi7Noa7JmsfBJKZF4wXSJHr/ZjfvD1k6vKvJShazFQ0as/U4bwFU1cvB07utUgg03Zb7D7X4ThYNV2wky/wyWVUzQirbOG7DqpikmltCRnFh7yurrGXixy+O4OmedCE95u0s+y1OPZ2KZKefjJBaugfGfEb20Lue0qSeoaUaVnO+9s9Bj4WMLPWTskERFLdfUK04m+8UpX8zmTmCUq+6+nY5mhOxHTJTkzfLrhQGY8xjbLM9Ow4OA7EuEL5Q+yyOq6G12p3DtZCdQE9cNgCF19aralboMt30sKrhaJrC4jphLCBdPnbGfP+AnQVZOpGpOEsGePs8f6snb/zEf4PS3C3X8xGhWm2T9MQM9T93SYJNv4URLVobaU6okjiLb/zjtDQarwym/dgjl/aNpTfIZJKf6SqHXX49OPU5s+duk26nVZ+OxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(260925021311599003)(4143699003)(260925021911599003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(6133799003)(260925022911599003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?abcbreNRFHPI+DV0x/UXL5I6T3TSs5lvgzD+dUDb4/UIZZomU3h5By3T30?=
 =?iso-8859-1?Q?idMpvyLoumZGnSHXfOrvjkUGNKvVR40JHHd/dZXNyexKDDKI9d+ZFmk/yb?=
 =?iso-8859-1?Q?59IDZlBdzWBeQ+H+DG0wWqcnm+7Q4RCBmZdsFCznKrCuePko7Z37ukXSpv?=
 =?iso-8859-1?Q?NDwVMVdUT2bGxFD0BVOquoLIzRnGHeWX1norPp76dr+i/PaEMKy603FwG+?=
 =?iso-8859-1?Q?cc4OSiJINwRY7BYFDD8jm4HHGdqkmji4GHoEs0CgG2+C9aJpotqY/dgb3u?=
 =?iso-8859-1?Q?qsVGo6yvg8tHhAjiSyOnjfLIsxvorywK9Su0ssHzN7ZXnyOTKyR6Xhfoyw?=
 =?iso-8859-1?Q?Z+7SkjQznXBDSN+o6/zmQsC0EniOKIT4Zu0ZHokWzWZW8Lt/jeev4cVPma?=
 =?iso-8859-1?Q?4A1weHjznrUEVeDxunT5XMobPzlJ57NZGyrPGyGH7iUa1iNyyaX3avnbeF?=
 =?iso-8859-1?Q?3XmLBQoySkAW4wlC1iMAGRhq3Db4/U/ZJeTgOSW19+u395RXxrgISKbub/?=
 =?iso-8859-1?Q?RVwPXNqY76iNh1WbRToLQDAcMpZtnIIEgYaqrzVMHncHsurA1+AgwMW//O?=
 =?iso-8859-1?Q?thitY6uEoSty6G8riddgWO1qAoPqJ6jqe6YXW6KE5zawIwJKLtMspqAlsV?=
 =?iso-8859-1?Q?TZf1UqJswfYgRCTMGHs4+JKk1NLfkUUM33Jc3fI1LjtTG0HFOk1mp9VcES?=
 =?iso-8859-1?Q?kifC3t88TiAuWdIVbeLZwWNKIGy+hpK4IHmQ/ULnCSaAlUUqhD4oKNL6XV?=
 =?iso-8859-1?Q?tiXiZxcvxth7h+VA6FfR7TztPim7bSC9dP1C7po+LR0CTX/mjzru83KkCn?=
 =?iso-8859-1?Q?S4NWpTee5zgk4xgkLZMqtOQsOq18233zXgxgiHPQkR9ZieITmBqaOq3bv0?=
 =?iso-8859-1?Q?MyLF2lgcXJ8ZC9bciLNS95KBOUHxNO57BQJwk2g9+fC4HwgPYHNqT03cTg?=
 =?iso-8859-1?Q?A5OE0Xve0agdPljgMd84hL8Ggf83yuJYrJ0KKKY4cUzOvhG+bFzx2Mpr94?=
 =?iso-8859-1?Q?ra7MZ0eJblGT9gNimMSz4eyORGGSQXTHfl0fT7fFAvA1M5a8qaJTmMwLkf?=
 =?iso-8859-1?Q?sefKUtLxxEsVKDYnI9oZa7Z39ubdNiosvcCqBUv/6AIgI5VK6qFeCJJfBe?=
 =?iso-8859-1?Q?xCcPtmSvjng8hzhggV/2ulkTygXxenHmvWMpLVAtFkh04JU/WOg4RR1/rg?=
 =?iso-8859-1?Q?lnBU3oPBVTktwknNU8rkSI3F5FIXmbGA9bSiw/2ghBCsKFSUhFTfkXiGn3?=
 =?iso-8859-1?Q?n2xODX6Vbhb63J4XPotutB8JF0y+aUQrYO+L50phckQlOfE7+mFljGZK3Y?=
 =?iso-8859-1?Q?5WNyjurtz8qDZx9xxETIo9tSx8rtXchke87txb3xskAv9zLrlnoi0RmAVe?=
 =?iso-8859-1?Q?HipRGxWB3EVy4283l89/Q9H93+RZyId81VmuIEp2tn8qjAJ4e6Nauly8+g?=
 =?iso-8859-1?Q?VtyoVfdIcmpHoeylbC9rjNdnk8205/EV/1mpk26jufvV/Nwiplu1ycxH7i?=
 =?iso-8859-1?Q?lwHA6v/mpqLnwnwoobbZlRnBeRmyj9tRUDk6QE6Y4yaJJ+rRyGewSJzgQl?=
 =?iso-8859-1?Q?ApKzO/T2BRMIjB5q6tNhzWS+Ha6Kt3vhuKoPYtFFHAGPHo+Rk2A1XmSKZ2?=
 =?iso-8859-1?Q?RP6OX2JeTsVGv5C1wWwO8ICF26d4ExThzAW+8FS6IomN4PiC7ENyW/rI0T?=
 =?iso-8859-1?Q?MQTkty9XmBvbF7nZnUHH2R1ZyoMEvxvcm7+tNYoZL3aJhWStKgWRLYzWza?=
 =?iso-8859-1?Q?qQKycRPiRglqgsPdIrEgXL9DzT229QSnUQZSMOc2bUHJBmSjk1vOAeFx+9?=
 =?iso-8859-1?Q?dtf3LmjbErq0igoOheU3iHPAxnjgtUk=3D?=
X-Exchange-RoutingPolicyChecked: JZULLWa4+n1Yku/znM237OoQqvq/j8Sh1F9wKOGpC0GpMWf0Ry+5uSu2zPQx0VFsAP5fypRriqtnhfMTNdtEMHSLpsjoccQJRiVjDAU3W8zObt8lsqPXX5pi5OJWZrGk/mKUHHrtMK6U5nlQoGw11e7/D6FHdvrfOQn/b2VFQ8ml8oHZ0DoRiSwL14ggRszDkmpnTuxS84b/DiNOUlGxlS0EVaR0BH4T3sKQbO1UQC0yOxflm9jVf8J3fQYlhktzK56sarpWd0TBjxSCc+UpTWojKnS61gsVSIAC3tuDizYpQWUP/225USyYUZ83jVzP2RjmGq6kTvG/WEZLGat5jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff16126-8e3f-4b58-734a-08df1b031201
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 12:46:52.8851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pt9+RMhYpHHpHn1DRKS+CKMIb7tqqwgy4n9NFtI6xU9S5pLlVIPP9gRMEU7KvjXb13iBqoISPNNQrMqkzUC5sNL/6ZNuSEtcM6rYwZsM7sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com

On Thu, Sep 24, 2026 at 01:25:14PM +0200, Paolo Abeni wrote:
> On 9/24/26 13:23, Paolo Abeni wrote:
> > On 9/18/26 23:24, Tony Nguyen wrote:
> > > Maciej fixes various issues with VSI setup, cleanup, and rebuild paths.
> > > Notably, keeping q_vector allocation synchronized with channel-count
> > > changes to prevent threaded NAPI reconfiguration failures.
> > > 
> > > Chenguang Zhao fixes AF_XDP multi-buffer handling by correctly copying
> > > and attaching fragments and cleaning up on allocation failure.
> > > 
> > > The following are changes since commit 46bc52d13594848023e681860df8700c8db14354:
> > >    ipv4: fib: fix data-race and stale genid check around nh->nh_saddr
> > > and are available in the git repository at:
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE
> > It looks like clashiko has found a few serious regressions, worth a respin.
> I almost forgot: please note that the current expectation is for you to
> address the clashiko comments on the ML.

Okay, there is a bunch of stuff that are reported at early stage of change
set which are later addressed - I thought bots are taking this into
consideration and therefore would skip it ?

Has the gemini LLM fell behind the others given that it reported no issues
whereas gpt/claude produced way too much of output ;)

From trying to fix one thing I'm about to be in a place where I have
refactored most of the rebuild path, which have been used without much of
a problem for (at least few) years.

It is what it is, but I have a mixed feelings for where we're at, not
mentioning where we're heading.

Maciej

> 
> /P
> 
