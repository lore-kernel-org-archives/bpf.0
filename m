Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA33090F5;
	Fri, 24 Jul 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904600; cv=fail; b=HaFpXbmDPvDwc4v7XUHm2oLI/6beh5eHP9wwvhaQ7ly/VFlFW/KVhcP8XHcBXLMrOW+4xm9I3X/yveryDVGhrNS3JNSNG5wsD0t5ZuR37iZSUhTpRGXQfoRqiBxrwOF7dTW+35Gf+8wcHSQjv/Xtb+O+4KC/c0QtTMS7VSg/Zcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904600; c=relaxed/simple;
	bh=DIiEgR83anYqaLaC374XL+pGd45COhSb7qL5N8cDYY4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FlneBhNWZu5LqGH0CkCJlvNjL1kZzUZgWLVP/0KteefGhiBpmy2phJe/4aTj9vWCHVBFiGWwp2c3vALpoHoQeQ+XSd1dj6S9GfQ4I2Aww5h0x8aSl0KS3aJEPs9y8OsnWNQmIk1a/EU5STxmjpzwBL1M8XBuETLOhuOPKTdDndM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/RRKi+A; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/RRKi+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784904598; x=1816440598;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DIiEgR83anYqaLaC374XL+pGd45COhSb7qL5N8cDYY4=;
  b=k/RRKi+AI4OU7uPC8uL0JtevnbYvWYlMezdraKy6g1QLQKu8TMDV11vq
   r17sKsVgMF6IEQBdnRa1GsDeb0U/kNdQ4Azd5K5oyLRszb2tk5vSAwSZY
   WT9sC70dqhodHGu6ZY6Hws0pt4zVHIjnAbDZolvVfMoHxxnG0IyC2ACfi
   pOFS7Prp5pNjbI/XYzIc4wQXn6BAd69YAD+r3t9AUhxAfEMXsCjeKPAQG
   Ivq6K23CUndV+uNY7tVQ6qkXc3lY3buu91zMCUTlHiij0fYZ3CN60oFff
   oqQFEPCzC8z5Js6iGua3/D8nnqFZGaPJPVBq+kE5iz0UXVpZl9qmOL1lu
   g==;
X-CSE-ConnectionGUID: A1EIN4loSLOJRskcLzqYWA==
X-CSE-MsgGUID: 9sEucuZER1CLYtL9ax/DfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85423406"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="85423406"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:49:57 -0700
X-CSE-ConnectionGUID: ZJ0h9utmTAW0IrXngSRnow==
X-CSE-MsgGUID: i+x2QkVjSxelVHrvP91OpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="263718805"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:49:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 07:49:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 07:49:55 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.39) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 07:49:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4nuaFsa22TY6VzB9wRLIqDOoWWDiTRnJehixVwnSKaBSJS8IwecMzoVzsNTW+lFoiq0u705n1SKg4R02IXabBBx9J5oRi5ecTDsnP6iy4NnjA169LreK7u8zwr5f4rDiABoVNm3iA2vbEdrrPQvruQXOBE2VEPBZzOwGoSwsZDqvknqg8L+2N9CxwnF5eothvBJ7zlWhBoaIAPXJlIB7n/o+pS0VzCJPPz1mKMtTnFFNQ/mcfo8U34zAP0SJZAAFHMPjozXbyUEQwjxpuusmKCxNkRy8Kqok34STCg7agnQ8R5P64cRl0vh5U6i5Bnja5XqshcPL4KoRUTVdhhmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQCe9iy6EBFFG9plzdwcCUp45ODxw4XeJGFXAdHnDWw=;
 b=sel/qfcOAdUupOQ9WnWwnBcbjsS4R3MiDCRPg3BOzRzc3A2RTM0v+7g8c59BVA2ZfY98zQXQmBxMBBVYWYDLhzC87sjw/WmdG8ghbp9TPpWed9mdnNawj1yBIwLjtkV7DsE+qcOix4SMfDuqE5bX58TTIOHa3bdZJ3T043ijQKs/DVQhE9h7sRFjwaD+J8p8YsME5GRP+cdftYVnxMwDbk2h9348owYXbFduB4T4JBBgi8MMrSqcIkzAfz2jBaDA0pWYeSC/07ZtG9rKXj4jqSo4ckeX43o9IK6X/d4GcqW75vmsqOAXPgCgqQiXXaWgnIB87aCT8/wFeV4gmepQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 14:49:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 14:49:52 +0000
Date: Fri, 24 Jul 2026 16:49:41 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<horms@kernel.org>, <bjorn@kernel.org>, <kerneljasonxing@gmail.com>,
	<kernelxing@tencent.com>
Subject: Re: [PATCH v4 net 4/6] xsk: reclaim invalid Tx descriptors in ZC
 batch path
Message-ID: <amN7hSwJZquAYv+Y@boxer>
References: <20260719135609.147823-5-maciej.fijalkowski@intel.com>
 <20260723162947.747377-1-kuba@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260723162947.747377-1-kuba@kernel.org>
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: e38ce6b4-aa5b-4ac1-aa91-08dee992d197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|4143699003|11063799006|56012099006|5023799004|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: GhUU0bIbs62pAp5Cr3afwgmweNolvXsKMK/P9R/0+ZlsK5H5D5CTme7zUmLvyDjRCgGAsIGSCPcK5Uau+AtU7HsuQLM60auiJf1mJQu3PAawtWqrmPw6vyg4ktnhG8qtJiAp0Mwwzr0UxUehW/09TX3LIVV+8KMhM4sDGjanp9ELSeFRg6N2gbnBntH5HYrqgRvEWOW4zPP1+RAKpj2s3Ep7IWt9ZbYo3458/Qh8A2byovUONi96h3D1aDcoRYpp44bFyJfcCEza+p//h48/BrSsTVG00YK+Kn/L0oPewOMB3xThBOVT/7FSVA3BBDiGOud4zZ5DS9E0K3RbUZfCzbGBTMZR4O+sviW2OaeTNvzj6xav8WGSvZs6BAgI3c52bJUdPdVm1YSitE+tB89K1J0PwUP46VXmPhY/Wemr6auocXAV1r5aXLGRAeDDLKjt4sGBX4ddDl7w9QZwTWn7x86O0C+ltUujOFvrcjnRdYrM4au/HbkIGZ8NfmDqSrrj1FrHiSByVWRoek/dn+nN2HG7cy15iFm4o1cWW7lpmVXM3jLBBszBXatj8HiMN1MVPjPW5t6ACD1nE+Uey6v4o4bmv8VrzbxdjHwNx4ievNMS198EdwypFEqh2xH3XLAgqZWqGLG+mJPgsHEVhop6lmCVTImLrNUcMRsK+25Q0ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JYI6lmdtUF28wKxImbNeWZmyktJ8lkHRXKOmgtL1JMp3xJ4hDk3E+IxtVA+g?=
 =?us-ascii?Q?2iWhmSEVabYjKaG3nJekhJc/7EYLg5CZSR7rwObaO5yFmap0QeHFemnJHzuA?=
 =?us-ascii?Q?oxYnOtaIyeNfsBlTCSuCvhFWW25oESXtyGkcPP+h2d0xzMeBVJE/J8LakiNA?=
 =?us-ascii?Q?s1q+YYeadwNASiIdyuL6b4PbfY18FlCUcc9rHkkjpEcSjHuOtLk3RNkQVCZA?=
 =?us-ascii?Q?/uFm5kxX6Sl0BGw/ZdZ27iOqscUv2ZQQezh6uAg2iXc40s0+4vgebBQvk2wo?=
 =?us-ascii?Q?be4D469cbVTnP28PMoJrj9/p2VLqtJWTDS7bvX1ZEzAiWjWX1MoMTtRrB9jN?=
 =?us-ascii?Q?3gUv5DlWEMSeDbcj6qOKPLzXOrJz8W23HyBprSFX2I1vlvcRIiITn6CywOEw?=
 =?us-ascii?Q?iXXN2dJYxw2f6mZ8LxhUbibb+z7wgcKlNGrd+I1jmpeHUTuJTg4PE9py1WWk?=
 =?us-ascii?Q?mZiA2zHM5vRxlSCzKLH9QeEkIN92ASL0SWNQh1bqUVPTduFggg0rlLeROh8i?=
 =?us-ascii?Q?zvCyP0S9+zaZBf9AhJP9p5FDRv6NCyPlq7wsCMeGuPZjM8tsB0xESTOMSoUS?=
 =?us-ascii?Q?ajQltubeaVPDT5e92GLQ5Q+57t06MhDbyQGfskgLg3osH/6bc/RT5veQOeYO?=
 =?us-ascii?Q?TsBDjmI7SeaLQWqjc8AN1dbJqZ4tT8ld9cY2Uv5zNe8MLcW31kIIMoC++5Vc?=
 =?us-ascii?Q?mBbAXtpQYd8An7hMijhnRaBiECR2247p34pU57lQhGKd+mlKwGLUeI3ej4Sg?=
 =?us-ascii?Q?lYZL3JakD+QCFf43+UeJi0xQ5BqDoUY6RIpQp+8qHjWbHr4tdVQZ+jF+NQmz?=
 =?us-ascii?Q?CoinbWmCW5qPl+jOpDRF0vnsLktEf4ozRrK5CoWCqUyjAYrlru1hpGFm7cOU?=
 =?us-ascii?Q?ssJFHSzThGv33cTS7Ug9G1JD/frcgCFWsEf5Qub5JD4x0c6Pi0m+4tz0CnSH?=
 =?us-ascii?Q?qjT84kv55m6kXGk/3lDWiyORNf3hCOfeYV7ntn+mweGM/ZQhXBjgotBMt+Lz?=
 =?us-ascii?Q?Hhei7Ct+w4MeXetZxifQ83TjMrFPJm+fEVcvK/miZi6c+/1lXMUPE3SvOgqu?=
 =?us-ascii?Q?GTY0Tb7X+UgXCJzn+8hQFSV2RVAqOL+EBU0V08K1oe2wDUX9iz1dsxI7OMbw?=
 =?us-ascii?Q?McXctFF+N6SM7RxMpZNi1Y1jXTh2MXmiohrbdE0nt3TQTKU+IKaJfaMYC7iS?=
 =?us-ascii?Q?01P1zQv5B0ITbhk49ANTKJzydnkZXo+fHrHivoFda6g/l6+udpWKHnCkVE+C?=
 =?us-ascii?Q?AJCo6rZvLDDIAv2eg8otn+Me5uzdwydrcHBxTBqsuuamy2W90ADup6tdpI5S?=
 =?us-ascii?Q?yzi9c0VcuZdVHcKP0pJy5x+Vu1nyH2Beye6vg2m9chvRiJ2O9o6LNjD82iyq?=
 =?us-ascii?Q?8kz16V1/l8CFto/HIzdbDlggv+/CY5DgdhRDIC5tjlDZ7DflHcTLlfZQv6EM?=
 =?us-ascii?Q?d0FBhX6A5ZL+WSPzE6pXHIjsfG6vOwRhOpplXfBMGh54B13TDOntojfn0+5M?=
 =?us-ascii?Q?3WJ6nUCkeBp7fHOr71YE7WmeyUffj0yCQCQ/uSxGPcaEoV96Gk9eOVRu27Pu?=
 =?us-ascii?Q?NgpCD8H81OteJNX7fZPuNPwhkW1KBPqRT6fBh+QpajMMog0mIH0NZTW/5vJM?=
 =?us-ascii?Q?g5W4cTTMMLygT9ULF/pVxXVyp3/RcyeDg6z+892Kx1J0WArKp6yfzD9CTckh?=
 =?us-ascii?Q?jLYpWrOcA7t4OweC4e1NZx9HMnY7Xr5QJl6ZvDF92789kup5ScyDThL0OfMo?=
 =?us-ascii?Q?jrG37lrMcW6taBT2hsaYOxBjPYCq5+s=3D?=
X-Exchange-RoutingPolicyChecked: FeRmzXFjTLQCpN7rhfIe6NQHDab7rRY3au6y8snBXty4/S32bQExpBpeaY0rfttVYC4AbQnL/dOlGmf2vUl60QCNNgXOj5SoluvbZsfJeo7Cz4oL51ZrQ9ArRPwqS0qJleIkVJ1XxMfRXfYBVjZxV5vbV0w7AjBPgqs5IZhIjlRlpW7tVXDasfZt9ST68WNz8JxigYMNnicS07e8kv2Bata3BGfO8Lg9Ibxf5mw3UkRTjWOiURqnQqARhMme2OG3rGkF0/HDY9UvYgOcTdHIoYmeUGXShlEp/QTIMeA13IIyDU7/iSeS1IeiL1KA2nYWJr8d1hz4U+sZtWlsc7snsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e38ce6b4-aa5b-4ac1-aa91-08dee992d197
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 14:49:52.6675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THb7IZmFTYEzHrK9p9HIMoD9kcb7YrHpBDZoENKSG530DtdO9ynLg39qizVWbQ+r+lpG9Uen4NYfueaJhvv2IUlV25p7SuSCMqPOZAgJ6EE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 09:29:47AM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Ok, see inline. All the 'high' issues are IMHO not valid.
Mediums seem to not be show-stoppers. Two other patch responses land in
the same category I'd say.

> ---
> xsk: reclaim invalid Tx descriptors in ZC batch path
> 
> This change parses ZC Tx batches in packet units so that descriptors
> belonging to invalid or oversize packets are appended to the CQ address
> area for userspace reclaim instead of being silently consumed. New
> per-pool state (reclaim_descs, tx_zc_pending_descs) sequences reclaim
> publication against outstanding driver-visible Tx completions.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> 
> > diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> > index 50d92084a49c..cc3f0d16b28f 100644
> > --- a/Documentation/networking/af_xdp.rst
> > +++ b/Documentation/networking/af_xdp.rst
> > @@ -504,21 +506,25 @@ will be treated as an invalid descriptor.
> >  These are the semantics for producing packets onto AF_XDP Tx ring
> >  consisting of multiple frames:
> >  
> > -* When an invalid descriptor is found, all the other
> > -  descriptors/frames of this packet are marked as invalid and not
> > -  completed. The next descriptor is treated as the start of a new
> > -  packet, even if this was not the intent (because we cannot guess
> > -  the intent). As before, if your program is producing invalid
> > -  descriptors you have a bug that must be fixed.
> > +* When an invalid descriptor is found, the complete packet is treated as
> > +  invalid. The kernel consumes descriptors through the descriptor marking
> > +  the end of the packet and returns all their frame addresses through the
> > +  COMPLETION ring. A standalone invalid descriptor is treated as a
> > +  one-descriptor invalid packet. The descriptor following the end of the
> > +  invalid packet is treated as the start of a new packet. As before, if
> > +  your program is producing invalid descriptors you have a bug that must
> > +  be fixed. Rejected descriptors are reported in the ``tx_invalid_descs``
> > +  statistic.
> 
> [Medium]
> Is the "Rejected descriptors are reported in the tx_invalid_descs
> statistic" claim accurate for the oversize case?
> 
> Looking at xskq_cons_read_desc_batch(), the xdp_zc_max_segs overflow path
> sets drain based on nr_frags alone:
> 
>     if (nr_frags == pool->xdp_zc_max_segs)
>         drain = true;
> 
> Every individual descriptor in the oversize packet passed
> xskq_cons_is_valid_desc(), so invalid_descs (bumped only from that
> per-descriptor helper) is never incremented in this path.
> 
> Should the documentation distinguish the oversize case, or should the
> oversize drain also increment tx_invalid_descs so the documented
> observability signal matches reality?
> 
> > @@ -504,21 +506,25 @@ will be treated as an invalid descriptor.
> >  * For copy mode, the maximum supported number of frames in a packet is
> > -  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all
> > -  descriptors accumulated so far are dropped and treated as
> > -  invalid. To produce an application that will work on any system
> > -  regardless of this config setting, limit the number of frags to 18,
> > -  as the minimum value of the config is 17.
> > +  equal to CONFIG_MAX_SKB_FRAGS + 1. If it is exceeded, all descriptors
> > +  through the end of the oversized packet are consumed, treated as invalid,
> > +  and their frame addresses are returned through the COMPLETION ring. To
> > +  produce an application that will work on any system regardless of this
> > +  config setting, limit the number of frags to 18, as the minimum value of
> > +  the config is 17.
> 
> [ ... ]
> 
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index f5e737a83055..2bb1d122b1bc 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -78,6 +78,9 @@ struct xsk_buff_pool {
> >  	u32 chunk_size;
> >  	u32 chunk_shift;
> >  	u32 frame_len;
> > +	u32 tx_descs_nentries;
> > +	u32 reclaim_descs;
> > +	u32 tx_zc_pending_descs;
> >  	u32 xdp_zc_max_segs;
> 
> [High]
> How are pool->reclaim_descs and pool->tx_zc_pending_descs unwound when
> the Tx path stops without producing further completions?
> 
> The gate in xsk_tx_peek_release_desc_batch() is:
> 
>     if (unlikely(READ_ONCE(pool->reclaim_descs)))
>         goto out;
> 
> The only place these two fields are cleared is xsk_tx_completed() when
> enough driver-visible completions arrive. What happens if:
> 
>     - the netdev is brought down via ndo_stop mid-flight,
>     - the socket unbinds/closes while reclaim_descs is nonzero,
>     - the ZC driver resets and drops in-flight descriptors,
>     - link goes down and the pending Tx never completes?

These cases are covered via xsk_notifier and/or xp_disable_drv_zc where
eventually we hit ZC driver that will release pending descs holding umem
addrs via xsk_tx_completed(), see ice_xsk_clean_xdp_ring().

> 
> In each of these cases xsk_tx_completed() is never called with the
> outstanding count, pool->reclaim_descs stays nonzero forever, and every
> subsequent xsk_tx_peek_release_desc_batch() early-returns. The reclaim
> CQ slots that xskq_prod_write_addr_batch() has already written are never
> made visible to userspace because the CQ producer is never advanced.
> 
> In a shared-UMEM pool, one socket tearing down mid-drain would block ZC
> batch Tx for every peer socket on that pool. There does not seem to be
> any teardown path (xsk_release, xp_disable_drv_zc/xp_enable_drv_zc,
> driver rebind) that zeroes these new fields.

No. If mid-drain means we did not hit EOP desc in current batch, there are
two cases:
- no descs given to HW, but reclaim_descs != 0 -> this is published to CQ
  immediately via xsk_tx_completed(pool, 0); in xsk_tx_commit_batch()
- tx_zc_pending_descs != 0, reclaim_descs != 0 -> reclaim descs will be
  published after HW is done with tx_zc_pending_descs and once Tx irq is
  cleaned, which will call xsk_tx_completed() for us.

> 
> Similarly, xs->drain_cont is per-socket state that can persist across
> close. If the socket goes away mid-drain, is anything expected to reset
> the pool-level counters that were set on its behalf?
> 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 091792d1d82d..f906d51b6699 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -499,6 +499,23 @@ void __xsk_map_flush(struct list_head *flush_list)
> >  
> >  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
> >  {
> > +	u32 reclaim_descs = READ_ONCE(pool->reclaim_descs);
> > +
> > +	if (unlikely(reclaim_descs)) {
> > +		u32 pending_descs = READ_ONCE(pool->tx_zc_pending_descs);
> > +
> > +		if (nb_entries < pending_descs) {
> > +			WRITE_ONCE(pool->tx_zc_pending_descs,
> > +				   pending_descs - nb_entries);
> > +			xskq_prod_submit_n(pool->cq, nb_entries);
> > +			return;
> > +		}
> > +
> > +		WRITE_ONCE(pool->tx_zc_pending_descs, 0);
> > +		nb_entries += reclaim_descs;
> > +		WRITE_ONCE(pool->reclaim_descs, 0);
> > +	}
> > +
> >  	xskq_prod_submit_n(pool->cq, nb_entries);
> >  }
> >  EXPORT_SYMBOL(xsk_tx_completed);
> 
> [High]
> Is memory ordering between reclaim_descs and tx_zc_pending_descs
> sufficient here?
> 
> The writer in xsk_tx_commit_batch() publishes tx_zc_pending_descs first,
> then reclaim_descs:
> 
>     WRITE_ONCE(pool->tx_zc_pending_descs,
>                batch->tx_descs + cq_pending_descs);
>     WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);
> 
> The reader here loads reclaim_descs first, then tx_zc_pending_descs.
> WRITE_ONCE / READ_ONCE prevent tearing and compiler reordering but do
> not emit CPU barriers.
> 
> On weakly-ordered architectures, if the reader observes
> reclaim_descs != 0 but a stale tx_zc_pending_descs == 0, the
> 
>     if (nb_entries < pending_descs)
> 
> branch is skipped, reclaim_descs is added to nb_entries, and the CQ is
> advanced past the driver-visible Tx slots that were supposed to precede
> the reclaim entries. This is the ordering the commit message says the
> new fields exist to enforce ("CQ is positional. Descriptors already
> written but not submitted must complete before any reclaim-only
> descriptors appended below").
> 
> Should the flag store use smp_store_release() paired with an
> smp_load_acquire() on the reader, or an explicit smp_wmb/smp_rmb between
> the two fields on each side?
> 
> [High]
> Is this sequence safe against concurrent xsk_tx_completed() callers on
> the same pool?

All of that regarding barriers and concurrency does not make sense. Single
NAPI instance serializes pool operations. Shared pool is only when sockets
are attached to same <netdev, qid> tuple. Therefore we can not have a
situation where CPU0 is in write side (xsk_tx_commit_batch()) and CPU1 is
at clean side (xsk_tx_completed()) at the same time.

Way more nasty issues would occur if stuff raised above would indeed be
valid...

> 
>     reclaim_descs = READ_ONCE(pool->reclaim_descs);
>     if (unlikely(reclaim_descs)) {
>         ...
>         WRITE_ONCE(pool->tx_zc_pending_descs, 0);
>         nb_entries += reclaim_descs;
>         WRITE_ONCE(pool->reclaim_descs, 0);
>     }
> 
> xsk_tx_completed() is EXPORT_SYMBOL and called by several drivers
> (i40e, ice, ixgbe, mlx5, virtio_net, gve, ...). virtio_net in
> particular can invoke it from more than one context.
> 
> If two callers both READ_ONCE(reclaim_descs) = R, both take the reclaim
> branch, and both add R to their local nb_entries before clearing
> reclaim_descs, do they not together publish 2*R reclaim entries on the
> CQ, releasing the same UMEM frame addresses to userspace twice?
> 
> The existing CQ producer paths (xsk_cq_reserve_locked /
> xsk_cq_cancel_locked) already take pool->cq->cq_cached_prod_lock
> precisely because the CQ can be produced from multiple contexts. Should
> the new RMW on reclaim_descs / tx_zc_pending_descs extend that lock
> coverage, or use an atomic RMW / cmpxchg?
> 
> > @@ -574,24 +591,157 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entr
> >  	return nb_pkts;
> >  }
> >  
> > +static void xsk_tx_commit_batch(struct xsk_buff_pool *pool,
> > +				struct xsk_tx_batch *batch)
> > +{
> > +	u32 nb_descs = xsk_tx_batch_cq_descs(batch);
> > +	u32 cq_cached_prod;
> > +
> > +	if (!nb_descs)
> > +		return;
> > +
> > +	cq_cached_prod = pool->cq->cached_prod;
> > +	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
> > +
> > +	if (unlikely(batch->reclaim_descs)) {
> > +		u32 cq_pending_descs;
> > +
> > +		/* CQ is positional. Descriptors already written but not
> > +		 * submitted must complete before any reclaim-only descriptors
> > +		 * appended below.
> > +		 */
> > +		cq_pending_descs = cq_cached_prod - xskq_get_prod(pool->cq);
> > +
> > +		WRITE_ONCE(pool->tx_zc_pending_descs,
> > +			   batch->tx_descs + cq_pending_descs);
> > +		WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);
> > +		if (unlikely(!pool->tx_zc_pending_descs))
> > +			xsk_tx_completed(pool, 0);
> > +	}
> > +}
> > +
> > +static struct xsk_tx_batch
> > +__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> > +				 struct xdp_desc *descs, u32 max_descs)
> > +{
> > +	struct xsk_tx_batch batch = {};
> > +	u32 entries;
> > +
> > +	entries = xskq_cons_nb_entries(xs->tx, max_descs);
> > +	if (!entries)
> > +		return batch;
> > +
> > +	batch = xskq_cons_read_desc_batch(xs, pool, descs, max_descs);
> > +	if (!xsk_tx_batch_cq_descs(&batch)) {
> > +		xs->tx->queue_empty_descs++;
> > +	} else {
> > +		__xskq_cons_release(xs->tx);
> > +		xs->sk.sk_write_space(&xs->sk);
> > +	}
> > +	return batch;
> > +}
> 
> [Medium]
> Is queue_empty_descs the right counter to bump when the batch returned
> zero because of the budget_limited path?
> 
> xskq_cons_read_desc_batch() can return
> 
>     batch = { tx_descs = 0, reclaim_descs = 0, budget_limited = true }
> 
> when it reads descriptors mid-packet, hits nb_entries == max before the
> end-of-packet descriptor, and rewinds cached_cons. In that case the
> queue is not empty; the caller was just out of budget. Should this case
> be distinguished from a truly-empty consumer queue for the userspace
> statistic?
> 
> > @@ -603,19 +753,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
> > [ ... ]
> > +	batch = umem_shared ?
> > +		xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) :
> > +		__xsk_tx_peek_release_desc_batch(pool, xs,
> > +						 pool->tx_descs,
> > +						 nb_pkts);
> > +	xsk_tx_commit_batch(pool, &batch);
> 
> [High]
> xsk_tx_peek_release_desc_batch() checks pool->reclaim_descs under only
> rcu_read_lock():
> 
>     if (unlikely(READ_ONCE(pool->reclaim_descs)))
>         goto out;
> 
> and xsk_tx_commit_batch() later overwrites both fields unconditionally
> with WRITE_ONCE. If two producers pass the gating check concurrently
> (the batch API is not documented as single-threaded, and the pre-existing
> shared-UMEM CQ producer paths already require cq_cached_prod_lock), can
> one batch's pending-drain accounting silently overwrite the other's,
> causing reclaim entries to be published before the driver-visible
> descriptors from the other batch have completed?

Mixing copy and zero-copy mode here. Also see above.

> 
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 3e3fbb73d23e..1bc42c8902f4 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -263,17 +274,18 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
> >  	parsed->mb = xp_mb_desc(desc);
> >  }
> >  
> > -static inline
> > -u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> > -			      u32 max)
> > +static inline struct xsk_tx_batch
> > +xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *pool,
> > +			  struct xdp_desc *descs, u32 max)
> >  {
> [ ... ]
> >  		descs[nb_entries] = ring->desc[idx];
> >  		cached_cons++;
> >  		parse_desc(q, pool, &descs[nb_entries], &parsed);
> >  		if (unlikely(!parsed.valid))
> > -			break;
> > +			drain = true;
> > +
> > +		nr_frags++;
> > +		nb_entries++;
> 
> [Medium]
> descs[nb_entries] is populated from ring->desc[idx] before parse_desc()
> even for invalid descriptors, and xsk_tx_commit_batch() later writes
> descs[i].addr straight into the CQ via xskq_prod_write_addr_batch() for
> the reclaim range. No xp_aligned_validate_desc / xp_unaligned_validate_desc
> range check is applied to invalid-descriptor addr values before they
> appear on the CQ.

Invalid descs are now intentionally produced to CQ. That's the approach we
picked to avoid losing umem addresses that would cause potential buffer
starvation.

> 
> In XDP_SHARED_UMEM configurations where multiple sockets share a CQ, does
> this allow one socket to publish an arbitrary attacker-chosen 64-bit
> value into the shared CQ by submitting a single invalid Tx descriptor?
> 
> Downstream code that treats CQ entries as UMEM offsets (e.g. paths that
> feed them back through xp_raw_get_data on subsequent Tx) would then
> operate on that raw value. Prior semantics dropped invalid-descriptor
> addresses silently.
> 
> Should the reclaim CQ entry be sanitized (masked to a frame-aligned base
> or omitted) rather than published verbatim?
