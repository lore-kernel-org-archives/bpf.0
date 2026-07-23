Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2643CE7F;
	Thu, 23 Jul 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784809152; cv=fail; b=FMwUnJytoSRbFm7CyccuiV/63js637u3UiQ2c36RnvkTP+BMoSjgb1e/eSsY2yDWtpTwGNbcdTGYDtS6Ny3vo2CGC8HaHk6SuD2gq87pXSiLdR5/vyyOJn+dQWEsj6jyMNeChzBAh4zAB7gVEKMlwvwnkQKT2/Ta9Lyv0ITsSjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784809152; c=relaxed/simple;
	bh=ThWqaZpKaKV+Kl7IcamuDB2iVKtXc8BSL63If12VnOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lLo1tE7/Cpr4Sf5yWMcEgvreCggjZvcqJYChf4xkB4p+7dZLNMIW4tErJQjcvr4McfQCaamCWH00KDU+wDh4Jt2lPgu0sqXy57Rp7DPE5WMBRFHAi0uCGwRTZghnE1gVgK0kw7PtruAjyN8xh5EA7EoL4ZWfOchlAmfgiIBYtTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gXQueCl7; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gXQueCl7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784809149; x=1816345149;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ThWqaZpKaKV+Kl7IcamuDB2iVKtXc8BSL63If12VnOQ=;
  b=gXQueCl72EPanLFWW10qGJlAlOG/0ERKs1e8ccszm0jD7vgB+mBCE29N
   9cpXx+QXxWnosC/tNsH7pbWIc43xX/Z8SaLFHYnn1QsphR/niM8gWZLIn
   xNAO4ZLFb2vjsjbZFmBrEYBsdsprAZtVHP0P17eiY5PFooyh1HdGGPhHw
   +PfLssWw5ixvl27ly0ejjCyeMOrPQabTfNoqUs1OlokQ2B/Y18bF+MBnO
   dmCQV/cgD7iZEB7tw+4WIFSr+Hn6FxbhWY337Dg7Zqa+EQhTz89BZOAiY
   Ewk10y/mZGw6+/mmXGdLKXiBaCCYWGH9BOBYUYL3bjflBFLqXmWFbJEn6
   Q==;
X-CSE-ConnectionGUID: PjStAPK5QFqRmbJsgpHGYg==
X-CSE-MsgGUID: UI6PQdBxRvCSWHxgTYbl/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85508886"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85508886"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 05:19:09 -0700
X-CSE-ConnectionGUID: eCWod+vQRh2IW//Vg5hdlw==
X-CSE-MsgGUID: 9OycRk0MTAWCj8zUNJuP/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="282908608"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 05:19:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 05:19:08 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 05:19:08 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 05:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vR2bRvbHykcbDNJ8Mhxlo3687nPxxJkACtoi6jiUuI66cNTk5vPhRQFP0wzgm5kGUWZakB2PqA88CChyZC3vsW7pSg8TOa5ghwUaMI5Qch9QR67z3WO48CvlbKv6S5MD//C5HxgrJ9J+G5i5/Ad4OV22kaVcFZwAYMnPW9cQ1fX/eFk1K3V3hm/GBxbGRREUCx5ULQ9qiePsqgI9E+V/zrdlDH7z4VdQqSvTi+u/86K5OhRpiHnBTGhLxEX1P0XN04Ul/eLtq8alJ2eDqJLniBxjU/9YlizYyE8BOBv+1gJzZpsO0QMtpOJELvza7Az/nwXqkf5OE67WipSkIn2tVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keM15jQZUdujIv3tTkDCB1/dsdvfaqIskIuhHzW6qfo=;
 b=GYRng+ErDH5BE7FqzK+hHndKAcHadciguOzOKKGuerw+eKTTEJkg/xTggxfLa+V4y6Piqg9ki9mRaz0tiR03tFFwvfDj4PR+TGwKX21D+ylCAhgkRBH/KLo21IWkyHygxwb3KjEv7ML6DsqJt/8n/YdWjeCAlifugF0ax0L/wDm85/JfIMfnX0/mGei1uI8HTmeILqCbmNSp+Y+UQRLTLEiKKpHgAlvF89aC0SO4ejOByVIRXrcuAiDl+no84ma4uA2cfLcL4lHWYOD6VZjUEpj4sH3aIlAEBgDM8RgxgjZgUPSPpGAj9QAS1CGpeeRyBerORknwxIz+E8yc7AeFTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 12:19:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 12:19:05 +0000
Date: Thu, 23 Jul 2026 14:18:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Cen Zhang <blbllhy@gmail.com>
CC: Stanislav Fomichev <sdf.kernel@gmail.com>, <magnus.karlsson@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <sdf@fomichev.me>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Message-ID: <amIGs3ek+0vOp5cd@boxer>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <amHuIvHN1zY4wYpt@boxer>
 <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e82cb2-cbe1-4f2a-878a-08dee8b496d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Kq+TmvUljIYAAzU9HMvZ6adTPrjGyFFeKpc93P0tylvqLG2F9Leu8O6ov1fKDKSBNhPUW7aRtD9GhPROKKPmwFOfq+PlesFCRuJNbMeAsYcenQuG4kuMUv/MhhBOWkYVwNvRu0dlhv2336vHmQir0m5qtQuuny65QNm4NI/a3nraZfcFoBptBx+5esMJFRHcpbICevUZOcMSj4TYKF3LkZ95ylQm4S/dSLGxDaAG9hzwl87hn/S4keCgHEJPmgHiVkPSXeiRS8IMIe5IoLidlayGDzLA/eQXUhRiuv7ZjyXgsip9wfctKXKXyb5gpSK6gy5rqX73KBk+/+MWBWSVxK90rVGk0a4NGaB7Z1OCHkyWnHe1y9KXSLSyHuD2+rEqpRO0IEf1Ys6DxAYIdjrxK+/WPiYolI61OOA2cXsjunygPt1ugStx9QtwejQE9aa/tHWiJyylNhvaRGWmkbDLdhT2fnhEulML5rRUzYQKmw1C5ulsX7Dr4PhwjYXo+9xTcHl88jBErVeW+VeIvMZvaubC+HINFvk8XM/8xr7zKNVV2Uz+H3pR4gUgsc+4K9P8uf8fAJGnkibVAC/xd139qwELc/vBhBqRvwg0jPn0Fc9a3njx//V05puksC1u8W16EnXeg7Q4ZjMjMsFaLlu6IOuIoWXidXOBckXViM8JJDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MLsmxLxQYZgnNq5e/vBQtL9h9+gurHJz5G8T2hm7vqKL1LbrTVhMLjR7wrgB?=
 =?us-ascii?Q?ynIC5C/a73dNHMSRdkVzG/l4gAJ8EP8ReUNVZN/oFHMmc11HeaQa7LZ+ukMi?=
 =?us-ascii?Q?dF1bDhufZZV0qSTfea38McaKgfg/YtS7trqweFQBNpIc6iMpYyvEd+o9yU4V?=
 =?us-ascii?Q?v5IDy5w1VieBtE8Yw0oVrRcOtfHJp4XNnQ/d1SU+eLddRWtot3fJVuzh9fA5?=
 =?us-ascii?Q?foOf3XVtl6k+hHyfx2IBjYwfF8289lqnrbu6wGNofQZuEYEL0qQMhWHhbVQr?=
 =?us-ascii?Q?ShLganBtuS4kEFGjDaUmdwyC/jnn2CxYGc/bO3QxvVU1rvyWku6UafxSTKJC?=
 =?us-ascii?Q?/nt48WhRtG47LHdGuxObFbpNDLq2FPM3KabAmPII0w1qsdbCPrcQRSKr97bc?=
 =?us-ascii?Q?50y+kqOYODZMqGu7gWB5wgK+so3yEjNOj9FKWFAEEbQXZky+BlVJjEruIYCA?=
 =?us-ascii?Q?vfwC4bzg5+/RlCdr/K954sZlX4zIyDZKR2xv4xbXhVIsexHcA7qnz8iSmq2p?=
 =?us-ascii?Q?vKhCWMB/PeiHffbIxmdbCFncVjtoUn4Rk4o47PZ/8i1WCym2taL4Cii+wA5l?=
 =?us-ascii?Q?4BPFuXDSDJt6rkYCaJfAh/bKNHZxH7Ty9cN4B13mTimA7FeW6o9uPpu4/uBK?=
 =?us-ascii?Q?82zhdmEbK/FQ/YBVYRrbol8e8FzWXvduiT1ArsfU1Ig+WCe9P9KerpZVHvRi?=
 =?us-ascii?Q?/wcKi9yL0PFVbZ/xrlQrT3Ol4ABK/VDvw737AiBz/t4HdZUEHR7uRTOcUshV?=
 =?us-ascii?Q?eM/drK6ZG4qyKj9wS8SVWeABvwlctzck8UvMHaCzdtIMwGpNPN3Ds+0WXqf4?=
 =?us-ascii?Q?pRnwE4FFIKLCaWG/knHTA6LFadMlR1g6YpsaHHhUtrZjYsXT81Rozdg45AM4?=
 =?us-ascii?Q?XESb1FeUJt9jPLoq+JObcwl3QqmLzJvbpUN6LRQtb/xVU/Sw5yFKynZvykFW?=
 =?us-ascii?Q?Tav/3n9RvYc1ejoknWCDlknC2Nq5IhSX/SrjP6C+2qBUjHljMdqnpJEmdE2z?=
 =?us-ascii?Q?KrZ6PKdguiRiMfv7cTF9va132Rb/RwdvAZPkJqSSbU0lC6PTHuQkELHDiUeL?=
 =?us-ascii?Q?0i6WisumdmLOVEvVxRVio6vnBhf5GiBUUsc+7SEHLrrDuBXX2/6RXYEge8nw?=
 =?us-ascii?Q?0fhQhcJJh/P8AnMqxa2ui1PChUTi06yjpyaki4ebxYVoS3+mjjXhIIcFkdsM?=
 =?us-ascii?Q?VDJSde/k0uk8LysLm4WHZEF/GncI9wPB+BUGN2bR3S3WF1GUmHlzT0A10kfl?=
 =?us-ascii?Q?J3KW7Jmunck+1m3z+4n3bX3zqnbQewOas3MGOEi+ur6zB6rOBhWVtvSvpHDA?=
 =?us-ascii?Q?phTggZ4wd9+xFE7Z4eGcJf2r6DcNT5izDqWFI+sLZw/5BllwqTbNjjf7SL7x?=
 =?us-ascii?Q?B2a3tUZ4kMro4cijYo+gv0PlnvrMQRswnuhD8KJsbSXpOGm5iI6bJMnaeXx2?=
 =?us-ascii?Q?V6EBPvc/ue6/ju4u5oh2RMDboekx9Vuank+XY86nuQWCcLRbplBwiYnrtLY/?=
 =?us-ascii?Q?q3bHQ1SxQU4Ma0mWDqFyNe/3oxYaQ4qDnsdWgA+to7h3r0woQqjETZVtOMpD?=
 =?us-ascii?Q?4jm/gNWpzfOy1ML4KOtYZkqItK+Cx9xAl8CWS32CHLxqcO26b/fLm7uXMHoF?=
 =?us-ascii?Q?DXPDc7N5SIAEv0JVE6Y7950n15b2zGFaL5cgoV4ljNS6GHkkew/egfalQnJr?=
 =?us-ascii?Q?1x0ZWMPHUDjs8gbMuqT8WXrfBgPYSJ6Fu5JMTzyYzCbRFWpXiZPcJ8h3aDNL?=
 =?us-ascii?Q?88jCpa3pHVzmkV5SkC/TTq5/4XH+je4=3D?=
X-Exchange-RoutingPolicyChecked: MjRBFBSWoQsqVoTZWHqW98WKOfEwJupEvPXZKnlVTLpjZ17rGrNPJmpF1knt4BsugpsPNby9Gk2IvUSn+lISURWME64dqzGHpIbngD0RhnL8lkpAbqTMxasSEA6u5rOtv9YBvqd8iE+oj1BLJq/ji6NQSPuW7Bi8SnrSl8k9miW3HLa4mJVhklaDA/W9uZP4mxgPg7bd2+7LOy5+x9fcvLxr+UgvMx4R7Lv7Dj6eGGCm4ImDwaCKfA402TnJRGDgxRIDn4Mud7cu6bR12NDlt8btwc9pA2klomPhujjzedn4DVAmu306YOytui83FoQk1pu5XZfIdLnXWMOzUV1e0Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e82cb2-cbe1-4f2a-878a-08dee8b496d5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 12:19:05.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uj/JY2Yi5Ru8GLjtiI6smlHD1WFb+JqsT2AvlCenxvQQZgAq+ZyR+d/6eBVh4dlrugPO1iJySdPGnlDlxOilRIndkvdPrJqESQG2O42BuRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6395
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 08:06:10AM -0400, Cen Zhang wrote:
> On Wed, Jul 22, 2026 at 10:55:17AM -0700, Stanislav Fomichev wrote:
> > Hmm, the AI review points out another set of TOCTOU issues :-/ I wonder
> > whether want to go all in and rewrite the users to have a copy
> > of metadata? Something like the following below, build tested only,
> > any issues with that?
> 
> I applied your proposed patch and tested it against my local reproducer
> -- the bug is gone.
> 
> > Maybe you want to take ownership of this patch and run the proposed
> > resolution against internal AI review?
> 
> Please go ahead and carry this forward. Happy to help test further
> if needed.

Let's see whether Stan is ok with that, you can get credit via
Reported-by: tag or you can continue working on this, that was only a
suggestion, so I hope you did not find it offensive.
