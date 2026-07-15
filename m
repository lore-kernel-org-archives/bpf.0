Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E1400979
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142230; cv=fail; b=UJLZYBQdEaL9orjPVfSJ65u9Xil1AOZBrAIIcAmZgQc72pPmk8T7ZOklzIJrYuUEo50qiQtFk6bjuPox2221KaYukP/YjYw9zB7cP7hzkvTlsm2xVwcqseknjTBpEBcLCWod7yIWjL4XJraBEQ3kfL6G67GZ2g6SjbQuPHGsaYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142230; c=relaxed/simple;
	bh=CmK3sWJNi2555SR5dgLZPzm9EHfAWUXfisBFlAESHho=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jx9dzhAzAR4ewWYkKuaq+yTvG5uoOfZ0RhKr4yDjI8JkV+jdb4g7jyMX8KApqkL3EzsaHZ3vgUOcTtE8fAPe5QKVNfqqGzap5QZCLYW+1gcfHUZKn8wKLigLeePXTT0dSFjqtBr7/OLHinmWX4fYDmxwTMkJ6lOCUuBpScQ8sdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ja29iGNT; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ja29iGNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784142226; x=1815678226;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CmK3sWJNi2555SR5dgLZPzm9EHfAWUXfisBFlAESHho=;
  b=Ja29iGNThz2iMFjIHwZ+rNE0STHBsnWNOTTJCHp5V6vpbnTIn6l596su
   /JCgYFyMDF02dRue8p9YhDcE459ursw9saClEACK6K5wJm8gs45thseYr
   pcU+YGB6FecmD6NeGnjVw17F3LLXkxBokY+y2SKiJWnZMltzRN2aVGWgZ
   NGTDhFadCdodCzwKZ9JuYfUZcqwFAr0RenjE2fB/ajDEYkQT4TzsT/wx8
   fEsfgP1SH0Zu9bwu0BhXd61IUttdcBYF0p03QXR4otOgE/ESYSmaL2TJ+
   dqCAU7rMLsb1DZqGdp/GieDnSxXZlXC4ZRZuc5cNzSX5ENpu4suuKcQDf
   w==;
X-CSE-ConnectionGUID: bg7ir6ebSMaj868145+KsA==
X-CSE-MsgGUID: 7ySyqQPLSxmiic9msRvqpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84835430"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84835430"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 12:03:42 -0700
X-CSE-ConnectionGUID: 6rgv8a/qSKKKDPgfLzoLwg==
X-CSE-MsgGUID: Qn8DH/HIRimeZZfuvbJNKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="253663528"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 12:03:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 12:03:41 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 12:03:41 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.35) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 12:03:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFgFVlqtlaE9LXFYWwr+XTpbtBJ1HjNjgDKm2P+tQroK7HifaZ1vxPmwNqogcprv4maMlgqR81EWk9DdcpWYooPhwenmxAtY0Ijk6dhq0Es+XioHvaQVs0pHd8T1bxqZtx0+OJPCqt+LtnNH/1Cmy77gUrfqk1iwXhwjlqIw1FwZT5nB219za3TVjgWPxDfPnLYfTI1ZEj5ek186xSA5b7tRWavzgHhmAY+h81Y+RhtKz0aZik1rb36DXaHhwc7kEy1/WUva6lyefnK218A9ylI9XJ0QpzxHbe6egRJWfdjd4ecVOP6gxKph2DYhJWqXPEwZaVl146XbFuMIBPjaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9L91sCzZJxwAEfGWupEud77Pbv7qHLkedT/XAkck7zQ=;
 b=FA3zAss7HexGv3XV0frgoSjTUFCgOjVMbMVdjlw0/ShoOG8g2DAMuenJPb3L965DTog2lLesjG0i5dieOxCwLQB5sJr0P09Td0gKxGWLpxIMU5efKWjpFEIm59j/SpFFTKXM6bPmG3T33trF+Xeoftig8AH8a9nMGveNnYiT0bKfsBDDXu7QB9v1AvTGmv9X68UGLw9A26tWtRoa8e+V61td8/uFpb47VKSpm40tgnh1cI77ROfQtkkEN98vCltTGpX642lFKjW2pTDnjvSj/WJdDBf9cVRSBpqtpVDEv7TOi99THrzDFWSi2OMBJmZAnmGlvB49x5GgtCI8JnaymA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA4PR11MB8915.namprd11.prod.outlook.com (2603:10b6:208:560::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 19:03:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 19:03:39 +0000
Date: Wed, 15 Jul 2026 21:03:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx descs in
 ZC path
Message-ID: <alfZhv2zQlzBPwm+@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-5-maciej.fijalkowski@intel.com>
 <20260715140845.8638A1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715140845.8638A1F00A3A@smtp.kernel.org>
X-ClientProxiedBy: WA1PEPF00005B7B.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::613) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA4PR11MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeb5123-b774-465a-e37e-08dee2a3c80a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: mhYpBAKa33yHuppAGdBiq9i/NcrUQ61YGeYBh9t4LR5lb+M4QbPn5KpuBQ88Pqz4BnquRyRIE7yWvtLNmrmzqHUG91JlIS0l5sTWrTd8ojV/awo9X8QgTJW9UDzbGzHa0xLhvjiLwOaECXzyTg44KW3gh8f1XdEVk6KrEZlCD4PxZ1nriLOtN9hEKiTnP2vXmKJcAce0DKG8CcofVaOvJE5kle32SkbSKcUGLiRw3650Tx08XLEVjNQFaYUPUuSHHWamqp0FbrAV5At+5pky6Nb47LyWY9gr/m2gbjRQ33SaDFYmh5Ubr9XGyJhZ/NmV5Eft6G2abnKMrdZbSV6RUic7zMQfiGRMlFgHmojbglm7UWCJ4bdV2wGKqVRNN7CIsEBeowS850GiNclxt5cI3aFJcu3NkJF2pxW2zwJsI0ioYewGwCqKRuBC0s9Anvdsug140e9vjc854vSlXkf4D6lYyHrQcuaB7N7KWnRmEnN7njas2xWwzjSxyllp5FGHuIHfXxGXWqcWRZtQ4WkaaEGjRCrexeLw4ZJXa94igIgC0bAbW6cZ5joheJ50h9vDJm/LPMHxcihx82xa/Y1tQ4Rdf2vh8ddtBrl6J6BwdCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ODeWO+gV8IIvxb6dnHs36Z+6BbQmsEc3RiviC9YtfMp1l7uPSyI8FzyEb+?=
 =?iso-8859-1?Q?OQw9T+ACHa9yIDX+a6i7xoOb1a4plpyYR8i+wc67ASEbATIjBbw2wyPKaD?=
 =?iso-8859-1?Q?LD/sTxxUERZthRjaB0VNcruD+cH8C6U0+67Pf1q9HBARA9vX5oIBvifXVK?=
 =?iso-8859-1?Q?DMmrdWb9nw/1Cw4a70zjvMCin8Hip7EgVudjkeLOu8xXSivFMWZC/INw4z?=
 =?iso-8859-1?Q?uwYEQ0ENbVR2XXa3cmNHGXKgmpk59JwDafshXlPbpSLc8Q8OBBc7RXkTQx?=
 =?iso-8859-1?Q?AthD2KWNDRjvqa5rQ+t7IZg7u6rmQrGyGQ/88l18W1qSdTSJR3cM3CXC4t?=
 =?iso-8859-1?Q?wcdS3LJEfyuOOUaRSLxDQPjkjnngXE0B4vTc1A8JTA5jC9mZ5dCywoQNFx?=
 =?iso-8859-1?Q?fZprm3y1tc/kXFhEyA9HsQLpUapbqVU363mYQka/LDhSq0SiNYb+jCcGGy?=
 =?iso-8859-1?Q?Eic9B7PePIRdQJ90uCXdUlh41tX+aTBbHb7bGYtRqcOWm5bET4WVQX+Cc4?=
 =?iso-8859-1?Q?5bjB37J98naB5D+odXhR7faluTpDTApyP0ucLDIg5ynklsMfgomcKb7Ul0?=
 =?iso-8859-1?Q?GcNZpF3GgnY1pzURzrCFIGZ5801vq7zdImKcwQPw4l5HKjmUP1CHYxKOuM?=
 =?iso-8859-1?Q?7aQpATv8rE7TqXTpGx6FflZmO/Wn4TibzTB6s6inRuxwWm58Nmx1fCJEz9?=
 =?iso-8859-1?Q?FEBe4YyXmnjH01s4Pl6Np6NyV8D3hoPJT0pGcpGc1mOEy/UIBjWdWRUC4h?=
 =?iso-8859-1?Q?hTvE1Rm3BMsMl3vK/SO6yTWMlO2dakc9rV8lxPRjQrRS/ln7ayg6iQWE2+?=
 =?iso-8859-1?Q?c2her5R8wyfYmnaZhF63wbce+kp4/VF6Qgb9AEbi6WPL8mRNlBIsLJLTSK?=
 =?iso-8859-1?Q?lbuF+CRCeAmGxBrvUGJ0JWgAGxgsbrDYRtmZDEE0djmhnJAU7U9DX51KP8?=
 =?iso-8859-1?Q?JTMtoMmsdIniD+mj9PoOt+CJzm6wNE+NkHe+270hp4z8b/OHmPhxrL0sp6?=
 =?iso-8859-1?Q?xoynevrjTX79P30K3BoTxY4gOq2L5rsVtgVcMELxTyigeOssNy9fGtpD3V?=
 =?iso-8859-1?Q?jQDqkQB7Kn9uGmxLSFLorzI656oqrGZozd9tSaC+ae6BCtAORveJmYU6nb?=
 =?iso-8859-1?Q?66Y/WEAXD2Dx7sOUacHsMH5JoUV1BT+wlqeVIVbGhha5wLXKxriUYhoMoT?=
 =?iso-8859-1?Q?M/m5h5ovWm9SUFpAjRt+LQv3k1qDIMZMvyFpt12vmMBphsnu+VxGPQwmH2?=
 =?iso-8859-1?Q?1uVRa3ZnsUShxSF0v7F6zkZdKXqesSjZwXlRiUt/Yinx1ks6F06w9cgWkO?=
 =?iso-8859-1?Q?V90cT3DjQwTV5L0L4+q5z4QtKf0VIX9BzDOWCOh0Vuf6y+y/Gt228hzKt+?=
 =?iso-8859-1?Q?abrfc0UCsAkH/mAVICJ/p2TDI0xZBjs7rHI0mHV07kN/zDGm2padXPdy9H?=
 =?iso-8859-1?Q?/oK21rdQ73BSsxQIE75buSQe0kgaztjiOV/3NS/FzJ3kTVUnuPL0/oWm/X?=
 =?iso-8859-1?Q?kBKkTQmaVrOWNnnDht783JdCeWfwhtZXuxNhsay4pvV9XnCF2nr9cJdsqw?=
 =?iso-8859-1?Q?4yC+G1WdiLZEmu45G/euSzgu2/Lr1ztFUhuTHyQ+7JU9PoKGjRZ2OYE9Vy?=
 =?iso-8859-1?Q?EwvCN1KIrWKIhb4fVIWClt4MRLEEXBRc9dvA+BS+Q4KI3JqxOvGbKcgSWH?=
 =?iso-8859-1?Q?/E/cZh9f96LKmUWdJFXci2ypejYrrXhnXHzKhApc1Z1s+evoBFoFocMAkT?=
 =?iso-8859-1?Q?Fm0I0/QpO3+lcaJMKqbK4zWcAbN+8ywHLSRiUcCHO1p3gLJEyl3MGRX9eP?=
 =?iso-8859-1?Q?RzD4Ip++S6rEKZjh6G7iHuKnrhsPh10=3D?=
X-Exchange-RoutingPolicyChecked: S1EQcxN2BGz16WZyZrOAKeUv3oXuB4qyx/wzkEqL74XXmOwVyiEDTNJWBEMhuHZvpZ9pHkTssTPh3NcRy8c+EMJe0SYTBXNawM/nOAqlHclpHot1iisMPdkR5g7TtHgyYLVARlaeGOg77L3SLegc2tpfMl8n+465R1NYX015zHzAtlMqr6ybY90O/MC0dYINV8RP3E8syUaDM7UCoggBXvx+8NNLAk7TatnpSmjxrXv7PqLf6Re80I8rKQfkRb4ocrWygqXUwKxIlF+LNzixSGDGi/Sl9eQ3h3AZuZuG06c0Qpi2Pcr+/Gv0XT/FbgGbxP4DIiYPWbdUcT+F8lL7OQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeb5123-b774-465a-e37e-08dee2a3c80a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 19:03:39.7568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8G4IntdIKBtTHSQ1J/awyYizoCcBA/aXEt5Xws8HUG0ybB+IiByLvm9sg8QPgAb3H8CDG6QONEvet6zzficMsz/MagXYaFJ8ueLwjrWjzno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8915
X-OriginatorOrg: intel.com

On Wed, Jul 15, 2026 at 02:08:45PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Processing an invalid descriptor or draining an invalid multi-buffer packet at the beginning of a Tx batch stalls the Tx queue.
> --

For these issues a single invalid descriptor will be reflected at
batch.consumed_descs and based on that global consumer pointer will be
updated so user space will see reclaimed descriptor. The stall could
happen tho if ZC Tx driver would be misbehaving with respect to wakeup
flag. I believe the correct semantics are:

- clear tx wakeup at the tx zc napi side entry
- do the processing (or not)
- set tx wakeup flag back at the exit

which tells us that i40e and ice need massage. Libeth got it right from
what I saw.

> 
> --- Patch [4]: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx descs in ZC path ---
> commit f71b54a29f7fa6021e0f05cf7b9e1dfd86287c21
> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> xsk: reclaim invalid multi-buffer Tx descs in ZC path
> 
> This commit updates the zero-copy Tx batch parser to process descriptors in
> packet units rather than individually. It ensures that descriptors belonging
> to invalid or oversized multi-buffer packets are properly drained and
> returned to the completion ring for reclamation without being sent to the
> driver.
> 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 385a3f4a1b320..2909a0ec68373 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> 
> [ ... ]
> 
> > @@ -603,19 +758,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
> >  	if (!nb_pkts)
> >  		goto out;
> >  
> > -	nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> > -	if (!nb_pkts) {
> > -		xs->tx->queue_empty_descs++;
> > -		goto out;
> > -	}
> > -
> > -	__xskq_cons_release(xs->tx);
> > -	xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
> > -	xs->sk.sk_write_space(&xs->sk);
> > +	batch = umem_shared ?
> > +		xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) :
> > +		__xsk_tx_peek_release_desc_batch(pool, xs,
> > +						 pool->tx_descs,
> > +						 nb_pkts);
> > +	xsk_tx_commit_batch(pool, &batch);
> >  
> >  out:
> >  	rcu_read_unlock();
> > -	return nb_pkts;
> > +	return batch.tx_descs;
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but returning 0 to the driver
> here from xsk_tx_peek_release_desc_batch when the batch consists solely of
> reclaimed descriptors signals that the Tx ring is empty.
> 
> Since user space typically waits for hardware completions before manually
> triggering sendmsg again, does returning 0 here result in a permanent
> Tx queue stall until an unrelated Rx packet arrives to trigger an interrupt?
> 
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 3e3fbb73d23e2..a15ff1929db62 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> 
> [ ... ]
> 
> > @@ -282,26 +295,49 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> >  		descs[nb_entries] = ring->desc[idx];
> >  		cached_cons++;
> >  		parse_desc(q, pool, &descs[nb_entries], &parsed);
> > -		if (unlikely(!parsed.valid))
> > -			break;
> > +		if (unlikely(!parsed.valid)) {
> > +			if (!drain && !nr_frags && !parsed.mb)
> > +				break;
> 
> [Severity: High]
> This is a pre-existing issue, but when xskq_cons_read_desc_batch encounters
> a standalone invalid descriptor at the very start of a batch, it breaks
> early out of this processing loop.
> 
> If no valid descriptors were accumulated yet, doesn't this result in
> returning an empty batch to the driver, causing NAPI polling to halt
> prematurely and stranding any subsequent valid packets on the ring?
> 
> > +
> > +			drain = true;
> > +		}
> > +
> > +		nr_frags++;
> > +		nb_entries++;
> >  
> >  		if (likely(!parsed.mb)) {
> > -			total_descs += (nr_frags + 1);
> > -			nr_frags = 0;
> > -		} else {
> > -			nr_frags++;
> > -			if (nr_frags == pool->xdp_zc_max_segs) {
> > +			if (unlikely(drain)) {
> > +				batch.reclaim_descs = nr_frags;
> > +				WRITE_ONCE(xs->drain_cont, false);
> >  				nr_frags = 0;
> >  				break;
> >  			}
> 
> [Severity: High]
> Similarly, this is a pre-existing issue, but breaking early here when
> finishing a drained packet will leave batch.tx_descs as 0 if no valid
> packets were seen first.
> 
> Could this stall the Tx queue, since no valid packets are submitted to the
> hardware to generate the Tx completion interrupts that user space needs
> to resume operation?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714140722.111645-1-maciej.fijalkowski@intel.com?part=4
