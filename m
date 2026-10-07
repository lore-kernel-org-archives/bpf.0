Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6540BCA1;
	Wed,  7 Oct 2026 12:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375749; cv=fail; b=kX3dhOTVk5sGaNagjznJy4qLOhgZImc+TpPwB5HveDdB+qY/O06D8df6/OO/LqfXXxapJX2Jlynur9os9KELZuwQNWnsLfYWASK/evJoJ+yxsPuZDjE4Xpgb41TDv3XQYnACy2xhJkZLi4+ZQq5HfjmANHTbQY6TmMZGT/IGv5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375749; c=relaxed/simple;
	bh=ORcc+Wl7PLXld6yyom/nnUJtw40/yzDrpmfwC5lszdU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mK37Jlnovm0RnQBm7K3tb0hbGssxIwrc/NKg3v4as+GHTatCYEuH0VmValt+IlcobN2B1aqEdPVT3l4nn0+bgLFwBiqOZFutJBFHEPiNpleAb54u5YrAspyknpZuo0PyhNxWqR9FVUN36bY2GqA24iSfere+CReBZKRsO6XJxQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWA78/xo; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWA78/xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791375741; x=1822911741;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ORcc+Wl7PLXld6yyom/nnUJtw40/yzDrpmfwC5lszdU=;
  b=ZWA78/xo7e5TVTLwWUG2YQBHIamNQdbljKR72/6GhgYD+DW14EdX+2Na
   533w4BTIxFIsRj05vhh1T+XpJltJhCwCRcL1ntMnd9QOlqTdMioU80Xjj
   iael66DhMnHqs7GQX8rZo0T/QFu/7K/eUnWjk0Mh+esaX8cJ3i7Fr6rXI
   DLHbgLV/AEwkJ4WX1x+v4DLy3VDwJE7sbM9ioEPa13yoyyLSzi7dszYjX
   8dl9pSzyPRNgQT/0Xt94UgWEHFFbd12hucE6pPfLV/DGaK7UBipGllkdS
   HKBFX3VLmb4m27BwGGfio+iOxfbQSx/pg99BHtYCaIoltJSJ62Zw3Y21O
   Q==;
X-CSE-ConnectionGUID: gzxZC6qFSkGjIN9aJ94UzQ==
X-CSE-MsgGUID: +UJkq7V/TqOT3X9I5gA6xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="128145"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="128145"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 05:22:20 -0700
X-CSE-ConnectionGUID: llnLUSWISGqd7q/9jY2K4g==
X-CSE-MsgGUID: i+e2jDa7STOxHmttxV/tdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="153214"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 05:22:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 05:22:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 05:22:19 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.48) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 05:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WiPJSQs9UuuQ54J/Q9ryR5/33wDAE5xF221eWclQcSz44TbNbZn8uFKZ2RmyxJMQjwdne9OKAZbDkukspYYiHEd9J/KLAu7ybZujaI3bTp7iACp9hyBYxR18C3UKquEBNWzAzjivakZ8Eg8dmaLT20RbQu62ye0DJS+DuZrXQr2EGbvtIFeiuOdahQu+x+T0T40dzzD3zpy/NOdHEn8ZdPTumiSnkM6cGUcwO5zdOu5D/tThz0meaq+AjPJm9PHRUkkruWykRoLRarm4TmYhwST9i92m9XoKmp8/I7SQSIDMTxrU+VCHdwthW9XWxBR++1e90cauVva5JM5yZeZ27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a15fyXITLVMUFEFN3utMmerM+QKPWEsfxp/idR08zmc=;
 b=WRTZZ7k9fkEz+L2/ahUVZrSt32KlJmO26Jnz9pLwxLgLh6+CaOZI9A29/m3byiH6NZs9KdZ5PHBsK60zSG7WO+oyf0DKQEZlRLn2W+kT3p6G/C/9R36birlWUt5n7ldsmRNyxmtRbvKNcELLmKajgFda7Byt0SWOX84AnIcdqE4Mk/Yw5DyJ2cf7J90pYmKgVHTzq+08jo2B5WXNhMnjSMwaLahII9N8nMmQKbATxFgZydb8ID86jDyi3g1RGvsR3gBVAOeSZRJR8Q15L80/evPuIeP/HwTmW9ppd39V4jtwtNfRjud49KBCGKyZf4sofJu570zSHzBXH5pQ59zQ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BY1PR11MB8079.namprd11.prod.outlook.com (2603:10b6:a03:52e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Wed, 7 Oct
 2026 12:22:13 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 12:22:13 +0000
Date: Wed, 7 Oct 2026 14:22:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH net-next 00/13] selftests: net: migrate AF_XDP test suite
 over to net
Message-ID: <asY5bpkHoqiX7rxk@boxer>
References: <20261001202124.692591-1-maciej.fijalkowski@intel.com>
 <asPlpJdawXNRAGAR@devvm7509.cco0.facebook.com>
 <asUzHc2Md9qu8Hx5@boxer>
 <asVwEyCK0NR4AwE9@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asVwEyCK0NR4AwE9@devvm7509.cco0.facebook.com>
X-ClientProxiedBy: WA1P291CA0013.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BY1PR11MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 732d8804-3aa2-478c-f3a8-08df246d9e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|11063799006|3023799007|10067099003|5023799004|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: lwGDmTBXvPnHRI6qc1Wxn1olrs0xhl6IEr9KfOKcoq68QFDrzlnzKVsT02R3/Otv3173BFTY9SgFLygNeqrS/E1o3JqMpnYd2If340u5gpcvTkd5ZUKlvAiUXCa6jNnc96SqXQYBa0UFxT4JsYujRl84j12Wpa+4Q2a+W7VUGtO15Vj0cXBUIEIL9xEAlrJpK/W6kT4oQ9dryLKPgeiDMD9ABATBuixWtucoHpD0OjVoNkkCHdgnF85H3ylLOH09+6kpmQlTT/rXDh10kvb/haMzclgF/QG7d4gkD5KLokHNUHSIkzq69MLkKzW7CyjvNXj/hutyu3PZfm16THhkeRgXywxuAkifzOk6ex7VzfU55M5D3ww0OIx4LMaoq0BsVXJGvT/ONJxc2HadMMRG3DvOOMLTyjtW5YDJ1ZfoV4KhlG7PbhW2VbYuWLlZKNTADFp903/oM9YbFYv9f2E00Ei0/ntm52OojmKlRreQRR5563OnIqmNfdHK2FfI6zxoM27M7ElgjHidjzNwB+yZJJ2QtcIcP8HrUytw4HYL4CjNqPxYoE8Oe3h0ljtpKNN7JviaRvLLZ9ZB6XL92L++EDQMb/NCmmG5znz9Rskr87Xb/ouCNucjBhsAb5rMLqqQR4sBeDq7ZJa8boJZEn6xEvs/zLolvbeQL71ngRGsViI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(11063799006)(3023799007)(10067099003)(5023799004)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u+pitJ5vhj0TIFJ9ucZGcyYm9UecpuubeyyT87CFMh6R3gdAPt8/WS0yjZMI?=
 =?us-ascii?Q?ghLZWiy8WSwdshm7IuS9Btq7vg0Fw7C+6fWBgrNttY01yaL7dS3ddzWCsEFY?=
 =?us-ascii?Q?0Z/ggZHMYN5YzrOk1xk35OjHrYXNX542m5RXUT64yy8hvdjWsvb4hG26FcJf?=
 =?us-ascii?Q?6AhJbjx/HG4B0EpZLQiWetSQ4AWyJUxLyQP5orEgC9dOwYGX36RTAG/KUQpn?=
 =?us-ascii?Q?lYTAUXBw+pRSIhZiKhksyOhwOMCDesloKN20+pynD3jatlY9qYy8KzLGGNbe?=
 =?us-ascii?Q?n0NDD/0qDLxerPNr68jeT3vuWc+k33hPPRZiDz5faso9g9cJAos2kxpZTppf?=
 =?us-ascii?Q?q/+rkDP/ZDq0WX1ltz+3bSvnge6Mm2Rd020aiFCGEO7YTmJeDvzzafUiVO+f?=
 =?us-ascii?Q?0xP3ulN7e/b+XiAneNNIUbPyXhCoZKCRKC4O3GoZ/kym5izICR0GNGkwp7ey?=
 =?us-ascii?Q?2NMGKDfxMklyBwBfn6xMsvwepdlxdQJWH+0WC4zXy4u38agbwzHuXtWyiZIo?=
 =?us-ascii?Q?Y7xVU0geEx4xcSIPd5VTlbahVogpC88ocrIkCi/n3q1RiFjR3tdl8H8/hXzH?=
 =?us-ascii?Q?ZWkr19EK+KheaawL0bpoaR5aV+1AeDaDk6Y5ImUbnC7LHUtn0EP9bp6lSbPv?=
 =?us-ascii?Q?5By/zMs071dwWZx2is7TdplA1DS1Yk6iBRm/JSBvbdIvuPd1bZoQDBlLWb9L?=
 =?us-ascii?Q?tcnK/Rax/RFfZ9D0RFN/je3ClA4MZvmt742SR+8ikULSlQpNj+ljNak1aclh?=
 =?us-ascii?Q?KmmrDxsu+58P2+PR8ohGk5b9gUIq/TA+vxvTL4wDFGOGs2/CsNblCllIaUTn?=
 =?us-ascii?Q?geKgJsGadn8XkwJX7tKOI2y+k3HzMnVpg/ps7m7ffugFmBdkXEm4wC8KXeuz?=
 =?us-ascii?Q?pf5tojJ14Rucnu1G1L6kUuL8xJlNTTCOEhFPIYeXtticH4M/dheFqHlMafn9?=
 =?us-ascii?Q?7bUenTP6iHiW8p7Euoi4H5v7XVxkbKZkdttHT5GTxGCLVg/tiq40Gmh+GLTF?=
 =?us-ascii?Q?4L07PHrGbdfxGqqMzGpbTdSK2gVxXIbIGBqdWJtMdFt5zOmYAzmo1bVV/yKU?=
 =?us-ascii?Q?eGigtmPeCdDKGpSVHj7KEZFd0vqm1hKOGrOLPsQIx5H5caEznPOtwQId7n3H?=
 =?us-ascii?Q?NDCSaKaicaB1zZ9fufvp1dI/Wk34eTkvxu/37MPeLSpaDsDPqDxWaU8Cxve2?=
 =?us-ascii?Q?ddJSuaZbo/X3+8psomXdHcZb8zoKPDRTL65Cj5+lZyAK8LnzF0lmF2E+Hxsa?=
 =?us-ascii?Q?rrZ8LHxAOrr7GX5imA8IkdOTuSOXFt5ySn+Q5nnltvMS+XpCiig2hIW71uI4?=
 =?us-ascii?Q?1cVQpuni5KHBPfEJvn/ORXnAIn3+Dr2oSHtYmzzs90AjA0iHcNyvEc4wo8g+?=
 =?us-ascii?Q?bsZRFJLOHDXeFhLFyLExiHA2FDvQqRQvfutzk8OM3GmrSXcd/2nYYUr3X/T5?=
 =?us-ascii?Q?DbnjjBmx+Mbx4lEpVWPvu5P2VGmLEbcl9h3CzGnWqB8Y4XmhUQAUjW9UrzK2?=
 =?us-ascii?Q?+8VMum3QRS0L99QgE79HjhPRN062dkpVif3rcM5BFUGERkhFqUWCJribnYgC?=
 =?us-ascii?Q?ZSw8RrVnuSfKEsRkM4ZcTmc9waMDSiflm1g3q2weK5i5dT9Ul2CL7O8ai2ZQ?=
 =?us-ascii?Q?9yraoSedy34RvmKwFDPLDq2i9xZp0Ddyoda61B0Kjh8/9EcE76iazvDprUJt?=
 =?us-ascii?Q?3O+dQSCUvqFFGFqXYHY+KZ3FfhqZslGXDWAKyqLbYnHbnJ0tTxovIs4hUgZ6?=
 =?us-ascii?Q?Dhiv/OjzVcXsEsvN5OvDyzHZbvERdmY=3D?=
X-Exchange-RoutingPolicyChecked: AWoNXdSXpxVs5WPRtH7SV0hYsnlIZkhOVnfYaT9VEzfL3WyZ55hf+vvLAg4Z8Jb2u2NHb/va+q4PTyzsGW1tudPgIXMJglcBKkKA4ronLHGJTJCj0SN+k22iLYw+EHE88ViUjvziX0cA+x/lTRhZ0m31/V60zlnr8hvxuMgnOYpa/0dtW7An19HOJDY7epnM4659rzHHqpfEOzet2bvokp3VvlExKodnxI3ZvMIFnEsUrE+hIm9puGCPs6pNOHcosf28evc95cF19Re8A8jq3sk1o0O9bvdoFzu87fK/1qW0IK3R6Xfazj6diKwmMiT4uNaMahbs/Flwh5+zwBRt6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d8804-3aa2-478c-f3a8-08df246d9e1a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:22:13.5161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKswXczhv0gMXXixKceUe+bowjM6oXyk/G/AGxTBpjewYea4BDgoQ4B4HfM0Gpy80vEgETuHi4GoqJL80D4+dJbWnsFLK0TifxwJzGXXjRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8079
X-OriginatorOrg: intel.com

On Tue, Oct 06, 2026 at 03:04:08PM -0700, Stanislav Fomichev wrote:
> On 10/06, Maciej Fijalkowski wrote:
> > On Mon, Oct 05, 2026 at 11:06:52AM -0700, Stanislav Fomichev wrote:
> > > On 10/01, Maciej Fijalkowski wrote:

[...]

> > > > 
> > > > 
> > > > Known issues:
> > > > - Every case pays for process start-up, XDP attach and detach and, on
> > > >   hardware, its remote commands. We used to configure resources once
> > > >   and then execute the whole test suite; it doesn't seem to be
> > > >   CI-friendly and it is preferred to have each case's resource
> > > >   management separated; that on the other hand increases the
> > > >   execution time of the whole test suite.
> > > 
> > > [..]
> > > 
> > > > - The XDP programs redirect every packet, so the link under test must
> > > >   carry no other traffic. SSH and the control channel go to the
> > > >   REMOTE_ARGS host, which has to be reached over another link.
> > > 
> > > Will this work on NIPA?
> > 
> > Yeah good that you're bringing this up, I see NIPA has a e810 setup within
> > same machine which is not what i tested on my side. This means the
> > assumption/requirement of having isolated link under test has to be lifted
> > as e810 cards on NIPA will carry management traffic via same link. I'll
> > add XDP prog logic as you point out, thanks.
> > 
> > I also hit the ice bug after connecting interfaces within single machine
> > which was hiding from me throughout whole local testing, during RSS update
> > where we only want to touch indirection table, symmetric-xor hashing was
> > being turned on which caused later rss operations to fail; I'll post a fix
> > to iwl-net and include some heads-up to v2.
> > 
> > > 
> > > I took a quick pass, nothing pops us for me. The only thing I'm not sure
> > > is the bpftool dependency (whether we need to build it or there is
> > > something on the system).
> > 
> > We need it due to skeleton usage and other change was also utilizing it so
> > I thought it would be acceptable.
> 
> No, no, I'm not questioning the need, just not sure whether we need to build
> it in the selftest makefiles (like bpf selftests do) or it's ok to use
> the system one (if there is one).

We could build it within makefiles as a bootstrap. How about that? I am
not aware how much of an effort would be to provide system installs of
bpftool on CI runners, so maybe this smaller build would be acceptable?
