Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99AB3BADBD;
	Thu, 16 Jul 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202767; cv=fail; b=Rw5acbFY8NAe8If3Y4AVTYgFPZoGKaX9RVGR6uSvQpxilwwe7BpwQPKIAu7gcBxxYKggK7OlCVQYiB4Slb4BZFqO4fUQzjua9pzOoq9v7TOWkiGi0HRQ1JuvZlNHhQoXkH89HQLY4X2lkVWFahgDQIBx1ulPHQl5aO98Vwcnliw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202767; c=relaxed/simple;
	bh=IC762+t7t74cfdjB44y+zowiWmcwrTpr39N3OSA6/zM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iPmeRfiuiuN6VdQP0a4c5FlRqAtf/WRPKIDY1T1yu6TRtfVAjiSPz3OMiqQU4tQLL5X8ckDznKRBs4KQ3NjZpuQKhIuRBpIRa6SSXycmDMYx+tfzZnQa52tftDwVG7nqcuGWlDcvzDrmpydG9IBznH4tLP1C+Dkrx9BC/ou5yYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NANWuP01; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NANWuP01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784202765; x=1815738765;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IC762+t7t74cfdjB44y+zowiWmcwrTpr39N3OSA6/zM=;
  b=NANWuP01ChzSj6J4MJdcW7Xv+f4BKfOpm3HbNeFnwsHt+cPGIRCRDxd4
   IsgkVlUAVM84w46m3tzdC59tYTJ6xurvdc+Yl3lhF00TiGupuwJ//53ig
   jAePFFJQVQ+Jctm0cna3WzmlIi0wxMc2hmuFAXjOqx35tKnyt/xchdEdH
   ozO44JioRbFpB8i+v4o70W9K1+EdQvaT6LRqlIxkKNaieZlsd/hVEPAys
   vSfU7gcZ8FnfnMppGRVXRT+TA4FYkBecURR3V0u6nXwA2FSh14U+0L2++
   vbk5ErS1Gd80udZkvC9fvP+6RewIjsQBUiKHSUq2OrU5nl/AHS0lLFoDp
   A==;
X-CSE-ConnectionGUID: JcsqfSiJTPSv4IPyrdhe3Q==
X-CSE-MsgGUID: 98GYkjvGT+u97QA0XZ9Wlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88761424"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="88761424"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 04:52:45 -0700
X-CSE-ConnectionGUID: JkPPtqnwRXmse6l+XWH66w==
X-CSE-MsgGUID: /+YQQKfhTjaYHn4Xa0a3kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="280921167"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 04:52:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:52:43 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 04:52:43 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 04:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/6pLhHmJQ/FJLC5E7qPB2acunnOc+hx8ImX0wTRdaw18UIHgz+4g+Ep15mZz70gm0QnFgBNKzWq1Y6jtfgK25f+IX19muJVFwoK51/U40nCYXlhvgS/IugDr8A8eoFJaUFVl6WxUMYbPsthYrpgwfygWpcdUpbg79lpvew3rRXmr/8u+tO1Uq9nyHwZWbKgix2Uu9TZ3WrCJVDuIU7YHUFUAj/vJ873W33p4kZCO9U6NSmVGKyAn0RUZP/M1W34NuiYOcAYaxNBt7lPFn3X8/2pjRigGKzajdNr44FFF/eNxw141cuu8k+w6usFwB3D0ooKvh3YcnX7mKXPIpXdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjzMMqCcZ8Mv9ZGwSdbCJ4p5JUy1MEjIhAsw9uHYaqM=;
 b=Wwmy3m2hYcg0vKmjSxq1AZy4X/jNa2uCYp3axsYfG6e2OnamiEgw4K0mVvbUcAHwktTe14SC+WWH4YY3b9Wv9fKmu/4YJOrdNAJEbt+fDsoCO7e8KgNuYaYoYIKttdbeb0leD4rQ07L+FSaF+vkkitq5Xpuzc8SyEzTJ13+Y3iByRBr5V+coByduVUtClXjqPMzrFwODUAhmGjacR+4BL2qClxV+ysEEUgiMyvG/9eo38NCCk8tU0ax5b+e8y6VAgOGmj1tJIR7kxfiYvy2TkeX53YHMkgYHdeFB8lASHF4Ok7EcLBN0Y+A8TgzxwcBECoCrA0hUd1Vkxf8wfFEC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6688.namprd11.prod.outlook.com (2603:10b6:806:25b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:52:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 11:52:34 +0000
Date: Thu, 16 Jul 2026 13:52:23 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>, Jason Xing
	<kernelxing@tencent.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
Message-ID: <aljF91Tx804Lcwyx@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-2-maciej.fijalkowski@intel.com>
 <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
 <ali/sIjljiNm9RmI@boxer>
 <CAL+tcoBGJDC-Kx=qvxoQtd4BUPCDBv00Gta1SOvejx9nNvVo3w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBGJDC-Kx=qvxoQtd4BUPCDBv00Gta1SOvejx9nNvVo3w@mail.gmail.com>
X-ClientProxiedBy: WA2PEPF000008A4.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::655) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 00a1638f-3a69-424c-1155-08dee330b9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|4143699003|6133799003|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: l1pCva/tdpjQVNAyvGk8oUxNxw1E/AQmvHs9kXwtsy28XH2ePWt4Td26h3G4G23rATKyiplgh9hocJiGrO95KoQkYYOIopahZqNAlhHNeKT0zZpPN2wXakgDcpzX54QJIYF+gX6wFOuxN/Gr9lEnXk3yUv138gE7ixh4m1suT/DbQuIxIOKYUDHF+5vTO94uAiRTHBeKDe9Q5PZqtzbY6ZyRDt7s3yW5yOOLSkN9VyBZLAEQ4ekSfn2rWNk6YKCd5d777gpI+UnCHmYJggR1XBRIDDpBpViSRUr+hv4/alsnHzwAUEyhMeiyVMR+XceJ0t5yJ4OjjMTmAXkCoF7ifM8jeYvVdVS+emZtL6ljVoS2YCizN0sDY++LYmEAQw0fikKmT05g9pZXEH2dMUa4F40F+dSjCUtGxjdfBGqB8rGmYdyrpPKOGw2wrc/6QpyVY76b7IVgvzEv/EN43F6P7ZYoZe/f2Ug3oV8zwE8YLEsnKB500Q3K3o43/4BuL6GwJP5NXjNWu7BBOqjAFf/6sTQKIX3v79s2TzLgrFTsPkNAFMVcF5Zj3OR1fB6Paf7ANA8KWQD/G/Qa/sldbj7qHDBVtqWiT+ZzZW76lf+GEnpipRawzq0KTVUkDw9TXiy+GKJ8i5Qsq7w3m+y4He1kqFe72JRpt/SaJAOhq3tFWck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDlpSURLQ3ROMVo2a29kejhaWEtlNkVRWTZaQlROUTgwNGs2TmZlMXBPRUY1?=
 =?utf-8?B?Y2JxWkwxRXYyaWhhZmQrd0czdkVkTStXbEJRV1J2QTFBbEx5Qy9SU3FZQXhh?=
 =?utf-8?B?bzliRFlidWllNnlZTGtqTGJkUGY0WWNBSVZxQ256UFVTRk0zWU9HNDlSWUtN?=
 =?utf-8?B?OElUazVoS21SMldOcExSWTBuVEFBd1MxaEZTLzNEZnFJWXMvNk1UbnR6Mm94?=
 =?utf-8?B?aExBWU5hRnp4VFFaV0dyL0orYjdzeVF0SmNZY3BCYkc4L2pkcXoydkFhZ3ha?=
 =?utf-8?B?RHhwY2lEMml2ZmVzbWFmamZXNmVJTGxtL0o3WG5pTVQycFErM0VwNEVvaXB2?=
 =?utf-8?B?cjNvUFlKRmNvNkJhcmtGRmNjbS9OK2syWnQvQ25adnNCTS9kNlpIODg3MGU3?=
 =?utf-8?B?VkgwK3hSVVlpY1cwM2grOGVmQ2xPc09TdU52NWI3MDkyY2FsWHpUaUJMQWYw?=
 =?utf-8?B?WXZ4c041WjVZQ2U1Y0dVMURBT1lmTVZybmZkaFN2Z2J1VWdaR0xYMHNyL3RD?=
 =?utf-8?B?Q1NRR1VQejdJc0lTU1hXWlZJQi9UVDYxQmJwbVF6NWRtNWRRL2FiOXIxcWlt?=
 =?utf-8?B?dmhTYjFESjN0SEpLclduZkgrT1VHQ0dpa0lxUktSYnUzNGJDZDcyaGhEdnhM?=
 =?utf-8?B?czJFYmJsZmpMRElOemhoVkhCNkRobUovQW0rekcyb0J0dnBYVXY2bjZQY1JW?=
 =?utf-8?B?OUpGYjEwUDFIeVRCZUxtWFlVczNkZW0zVmZ5MWlzaEZqNHpDRUdkaWpmeHVw?=
 =?utf-8?B?WlE3WE1XRGdyYzlkQ1c3b09aaUxYTDc0aURCWVcrTDBmbURUdVpBU3EzZzBu?=
 =?utf-8?B?eFR5TmRIUjY2bmdIYVRVWks3dXEzRzVVWlp4R3JXczJVZ1p1UmwwQWVpSGl4?=
 =?utf-8?B?bkdmRHpJbU1ETy9MQmRWYlp4V0p5NHI1b3dQQ1NZekVIV1kwSTVhY0MrZWwr?=
 =?utf-8?B?Qkg0WmNqV1FqSC9LTmU4RnNGNHMyU3I3VWIxM2tNNlVleUJCNkgyU0swRWY3?=
 =?utf-8?B?Yy9BWjA4UTV2S1dDbGJlSjNIdTB3cGN5c1VqM0kveGNQNDd3V3Nvb1NBZTZw?=
 =?utf-8?B?ZFdkalQrZXVxZ0hvczc3ZUM0a1VMYWJhSUxHblNHTytSNHFBT21nbzBLL0VF?=
 =?utf-8?B?Umt6VUQxQkIyZ0xBMjB3QXVXektzNVRuaW95b1ZyK1diRklJeG9NUlk5RHc1?=
 =?utf-8?B?TGhCVXBkemFEeWFGMWc2Ym9FaytBTU50NkxqTXFNQU9wOVZGYWVBbGtnOFNB?=
 =?utf-8?B?MnJpTEFJak5SRXpJZDNMRm9HM1RzWEJwbHNoNjRrWTVRUWt2bDFRNmJCSHRE?=
 =?utf-8?B?UDZiVmF4M2I1N1oxVHJvR3d6Vk9hNTFra3orY3RxU0NZeU0wK215YUNPVXpr?=
 =?utf-8?B?L3o1U3RiRkdjOWtwcDlCcEJWSGI0UG5kdjZvTHVXejF2L3N3QVFmZE8zMzFt?=
 =?utf-8?B?bGNjVVhVVVo4QTJSNTlRd3pYenhWaUhWbmNsSWpkYWhIUmpPQ1phVEhES1Rp?=
 =?utf-8?B?R3QzQVJTekFNVkJ4Mk1DSUIrNU9NSkJFQ3hCRG52V05Sd2RsVkYxOFJ0OHA4?=
 =?utf-8?B?OS9NZDNkdzl3V2x5Q2VSendGb3Q3NmVjTHkvY3FIeTJMUGtrUUFKckdvcSt5?=
 =?utf-8?B?TlFtY3lvd0RWczJ1WnBkM2JFUmluTDhCQXI1Sm1tL3NXTjRZNkFmVUt1bE5K?=
 =?utf-8?B?dFVFUE9LQ3V3Sk01YXlaYkhQeHFmL3UreVFyS1lHdC9mdmRXK0NWRlA5L0VE?=
 =?utf-8?B?MFNrTVlLSnp0NE43Y1JOOHQwK216TTRnMWlTbURWTWt5bmlKbjJkL3dLQmNI?=
 =?utf-8?B?V1ZZVnhyaVhGV1F2T2IxdXBxN2xzVEpKalBoOUd0Q2pJTnFUK3dJVHFudmRI?=
 =?utf-8?B?dkFpaGZjb01JWDZ4VjhEYXdtSlpna21lSFUxYjBBeFNZZHlvSzJnYjlBa2dF?=
 =?utf-8?B?QXI3aHRpWVNRVWpCcExXay9LYkxBRk5SeGZlNzBZUFdNc1AwY1FpUzdaSWY2?=
 =?utf-8?B?V1JJWmd4Ti9WcXptaW9TT01WVlV0c0o0bUpYWDl2WDFkdkNGRThPS2hhRUhZ?=
 =?utf-8?B?NE8vK3ZmeG1jSGRHRThSYzFKRzd3NitaSXYxTWV6dEhpUmNwUFlUbVZXcVQz?=
 =?utf-8?B?VTBjQXp0QkwrM0N2RW1YZEtLR052MUZ2d0g2UXhtYTNlR010R01za2dTVEJR?=
 =?utf-8?B?YUliczJjV0NsSDh2djJmcXNtTUhUWG5KcTVNeHdlZFBWUkZRdUJzNk1SWHk3?=
 =?utf-8?B?Z0tJL095aitoZmM0eXlmRUhUck1qc3FKUSs3N2tpYmgvdTFNZW96RnpLYWJn?=
 =?utf-8?B?YlJhUE1OUDVQNWxmdXlObUovUFlmdUpqekQvT3lwOUJ6UUpYUE05ZWxFemNY?=
 =?utf-8?Q?YFlwB28H6an3XOc4=3D?=
X-Exchange-RoutingPolicyChecked: C5do+Vgsa5nZrqsgke9D8NhwRO1WnBMxqKt0nOYPQCGSZ/EXQE/7w8zR97uBxrULCFsw+1JwaDT5brVaSTDVvFChzq1jPF6jUv5ArUaAQqZAvhWJ5PKn+En1a6dx//EYMXQZw4ANkVNJePJWsaDBVMcdp7Yx+Pvu04OdI8yF3DUcR9dIIJZRGVfJFsYMsri5t3rrh6By3reIhPrddoi1yJhBTjzm/yDXMrG4/EvnJq/POSL/jlkLhCPEgmYAxKo8gMXjiNDrVEHM0yoEdYPJMZkeweIOitT1BFgtgKI5CdoNA8TCCL6m4Nb1JXMty+wRMEw867hn/a1wotLjm2SMzg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a1638f-3a69-424c-1155-08dee330b9b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:52:34.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iko1/FE8DGCMnTF68IafnUuQ5i3JGs2qzsUFDOdapBsdtUaDJExoo+gH00YwVNjzmEscOrQFsmmia1Vz+YaRb4aqEh3/0UP51A7APmCrGDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6688
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 01:42:28PM +0200, Jason Xing wrote:
> On Thu, Jul 16, 2026 at 1:25 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Jul 16, 2026 at 01:22:24PM +0200, Jason Xing wrote:
> > > On Tue, Jul 14, 2026 at 4:08 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch is inspired by the check[1] from sashiko. It says when
> > > > overflow happens, the address of cq to be published is invalid.
> > > > Actually the severer thing is the whole process of publishing the
> > > > address of cq in this particular case is not right: it should truely
> > > > publish the address and advance the cached_prod in cq as long as it
> > > > reads descriptors from txq.
> > > >
> > > > The following is the full analysis.
> > > > xsk_drop_skb() is called in three places, which all discard a partially
> > > > built multi-buffer skb:
> > > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_FRAGS
> > > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor in
> > > >    the TX ring prevents the partial packet from completing
> > > > 3) xsk_release(): socket close while xs->skb holds an incomplete packet
> > > >
> > > > In all three cases, the TX descriptors for the already-processed frags
> > > > have been consumed from the TX ring (xskq_cons_release), and CQ slots
> > > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb()
> > > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Since
> > > > the buffer addresses never appear in the completion queue, userspace
> > > > permanently loses track of these buffers.
> > > >
> > > > Fix this by letting consume_skb() trigger the existing xsk_destruct_skb
> > > > destructor, which already submits buffer addresses to the CQ via
> > > > xsk_cq_submit_addr_locked().
> > > >
> > > > Note that cancelling the descriptors back to the TX ring (via
> > > > xskq_cons_cancel_n) is not a appropriate option because an oversized
> > > > packet that always exceeds MAX_SKB_FRAGS would be retried indefinitely,
> > > > which is an obviously deadlock bug in the TX path.
> > > >
> > > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > > overflow check so that the current descriptor's address is recorded
> > > > before a potential -EOVERFLOW jump to free_err, consistent with the
> > > > zerocopy path in xsk_build_skb_zerocopy().
> > > >
> > > > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.kernel.org/
> > > >
> > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > Maciej, maybe your tag is missing here?
> >
> > IIRC this has been taken as-is from your patchset. The next one has been
> > touched in few ways and I included my co-developed tag there.
> 
> Yep, I mean maybe you can simply drop your reviewed-by or acked-by tag
> here if you approve.

I see. I am not sure what are principles for such cases, I could assume
that if I include this as a sender then it implies my ack on such change.
Anyways I can just:

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

BTW now I reminded myself I dropped Stan's tags in whole set. I think it
was of changes on 4/6, otherwise I don't have other excuse.

So Jason if you bump at Stan somewhere in the netdevconf's hallway could
you ask him to re-ack it if it still works for him?

> 
> Thanks,
> Jason
> 
> >
> > >
> > > Thanks,
> > > Jason
