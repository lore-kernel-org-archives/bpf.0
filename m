Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D4F3B895F;
	Tue, 28 Jul 2026 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238395; cv=fail; b=bkIYsnw5y000maJi5x+GJ0P8hHBp4NDQchAR9s5tRjT3CkMNYVY7m+ir+sdVoyTNoIuLfaG7+iZpReKAj6EcTlmNMzWM0eFRDIBiobpLkw7NjT3q66/G+gniXom/Rnl4/mVDWFTnty1MEDc4bUCRJKFzX2IUk73B8Qr7LRjBXEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238395; c=relaxed/simple;
	bh=2ITPsGNiJL52rDKlSLzPh51FdxTmNk4S1Y/4nOpUnF0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=udXsQqXXvyELa409dnJSPYQJluoZXWIYbYC55VTb4AGFfLnv3WsOvk03vZLLVhflUodMsU0/BjlSusix/AtkXlf98kwNLKd4iPV3aReOnPQi3kNzadI5RErwyS2MhdFhC/mLL3l/mViOJjqTDgcS/R/ZUrYJsTK1l8M4nbtgiHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gy5KExyj; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gy5KExyj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785238392; x=1816774392;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2ITPsGNiJL52rDKlSLzPh51FdxTmNk4S1Y/4nOpUnF0=;
  b=Gy5KExyj1aIru2G5Xe0CIEBuwu9dRdZfT35jqkluQQbMhmqU/9f+pEs3
   RMgn+uSvTlYK5/r15oI7bzuyVl2d7GubuX9mDa5S59jBtE4GcPp46kcgM
   VfniAEVsZEymvOK/8vthEHMyvq2Zz1eP3Hflp79FZI7jgeis+t4kGN/wi
   7d10nFBFg/fHKpsjLDT6gAU+iG6voIjmZtNqju9aR0m31YOkKpEHhQhep
   mFh0dG2ifSOGvOY93xcGbafqKcgs/N3UlFnnfIMe7G1MmOnc49lvBDRGN
   m1BD8ihY1KePbJmDCS3vuIPruNbm/dNLVCVqiqIH1D48AWkG4hDZItVD4
   g==;
X-CSE-ConnectionGUID: IK/pJaX5QQaPAxpwXzNI6Q==
X-CSE-MsgGUID: okK84//nRnWBabHn9y4Kcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96480091"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="96480091"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 04:33:11 -0700
X-CSE-ConnectionGUID: BK435kRrTJiLyeV2Jv/w6g==
X-CSE-MsgGUID: 95uCaF+YQzKBkK5kn3AaCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; 
   d="scan'208";a="256333059"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 04:33:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 04:33:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 28 Jul 2026 04:33:09 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.61) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 28 Jul 2026 04:33:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrM8xOQIFkmRX6tsM0R1ywHcfV4s+S0L6WNUaihanDBisbvJstKihkI1tP7SQCAu+OSYBHsRBbpY251YrAeenohnviWyC5Np+F2l4o8bIjuYa4Vm9HTmoy5CLhUUqXmgYMv/iYseObFjmp/AV5kVv95UDwmz3DaSGlv2ZS6lPmA/UTGNXAynxjfofCAOk7GLEoYQMO3uQEzAmmdMvXgb1BxouJpCOjDDyQFQ4C6TeX2zxfqoMCJVgrXwh2CtiNCpN24wXRzRICScQxhPSVLKlFbwnMdfeYylHHUWXSG9yMtessPfTa1LYY8AFW1AN5b+jQUatWgcf8iModBcovTS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgmkqeNKN5C473EBDT8AzFTe7QMsk/gBU20//RVe/xM=;
 b=CebTJFZYT+X9yza3rnIXfT5ZAuV/il/MDVmm0KmE/Uac9C0eGOt9smVlrA9ayxZQRbhxoAdFzrnNMnB42z5qqmWjbVdE/hVIbuaO5uP/ZFcJlYLCqF0QOdXSXixlc6bMSrlVd2Bk9OcJco9G9zValvfqLW1t84bCHI1b9WBu00AjVjFT5rSspHUsOI8ZyWVbQIujLBpTyJlqHVKLHEFp3/JbiSp690W8PExgyciPtoJhYvWbZZ6K18HxwGRNbwM0bwvVOjGBrtjyXEKOznWrGEPlTEI9shTCqBycD6dSoRxddEKHVWNAUK5vFHIpj5AndwX3vwe+cCo6ChB/SMLXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Tue, 28 Jul 2026 11:33:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 11:33:05 +0000
Date: Tue, 28 Jul 2026 13:32:52 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, <magnus.karlsson@intel.com>,
	<sdf@fomichev.me>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
Message-ID: <amiTZFpTTx7jHurQ@boxer>
References: <20260725034246.192091-1-blbllhy@gmail.com>
 <amdJgi0V3YwWE7oL@boxer>
 <CAL+tcoA8KPn7z3p7KymQLT4apwcaCy1Yi8P0S5KD-f91jxmwhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA8KPn7z3p7KymQLT4apwcaCy1Yi8P0S5KD-f91jxmwhw@mail.gmail.com>
X-ClientProxiedBy: DU7P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 72649147-3409-4ce7-a699-08deec9bfd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|11063799006|10067099003|5023799004|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: L1Cpe+6CRbuX6BXcOY1E63xovqKUxihVwxLZavCf7ARcAc5nvHQRsmYCrb8QyBgMGoLw/iNPuARH4CKlAvSQS+nIz/o8EfEkwC8sccfZfkypoB/4JBrpa1O7c6f5qreiolMT5adKLv4yKNQoXdnb7AZO3/ud06KS0VOhac8nG/RX3Z+aKZTr44gV1MvW77b7d5SpC5FL3u7099aBSe/aEnb+f8BmG4FIduZT+LL+I+JXUUnipyhScVvBa+oTkKtDguGVKzen5+ARQ7tZocYpwX8qPt0VFneDs2/zLUm8Zo7wx/k52dytPYLpzneL1L+AQGmETBdnPOOa2cUtfkLeE99Ug8V8OHmBVAlQB6noT75JesHe3O5fWcBfHpD2hyrL7pgWL2bo7eQX87O/oD5UkV1oaBZ85GShIGf31FDTbMWWdZsNoLv00JPGYX1PmEjuNhouwYBAysYh6c/r/qxc5oqIF+mnMYPK3aqw70upY8ffyXiEvOM+2MqwFue9+sryAfejTjONCI77VyZGDa5/rfGStBIdGdbrxS/yydSQMifvqaHa99fq5g27Mn4RHoVh6exJ9gC0bjErOMVj4fEkFVJKj8QWyrimzVYTpNi5Rte/9yYGH6+sIfmIyp3ugZ1uuGNMZ9Svy/HZCquxWqsPbuzBdsHpwcHoy58/9YzVG8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(11063799006)(10067099003)(5023799004)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzBqbDlvTlFkSS9RQXZQV084K05LcHoyelNiQi9aU3o4Nk91UXNrckE3ZEpT?=
 =?utf-8?B?L3JOVlJ5MkZ6U3A3RFdmbXpRd0l0RTJoSmxHWjljTlluT3dwWWZtZkIrdXdO?=
 =?utf-8?B?RDZjRkhCa1FYUWxXaitXQSt5cHRxMnNZMjFvZDlLL0RmZ0JtcCswREQ3TWti?=
 =?utf-8?B?eFdObkF4ck9ydVFOSnkvRllpZHdYdExrczIwME45RmIxTTJDNWRTWWFoeUY0?=
 =?utf-8?B?RmVBNTlCejJaUkpKNXBQVWxYTHVvTmFaR2xscDVQRm1kc0Q3c1VBMklYb3h4?=
 =?utf-8?B?cHV1VG9FUDcrQ2Exc0Q1Tk4yWHFoa0p1MEgwMVNPVGt4c3hTUmZ5WEFmY0Vw?=
 =?utf-8?B?OVBzZXcyRXdhZlVsZVhGZ3haRFZGL1ZUbHV5T2ZvaEdEVUhsOXFOTTVTeGU3?=
 =?utf-8?B?elI3TGRRTjhZY0RyZmcxNFRuRExxaVFRUlZ5VUdiTDlWd3h0aTAyb21OeHJN?=
 =?utf-8?B?NFhQTUlBMjlGWnFWaUtOYUJEbmFEbjJCU3g3czV1bWJ0dWRBOUMrZFJ2K3pz?=
 =?utf-8?B?YllxYlVEVTMrZjVBOHNRUkVHcG1ReFZsdTF3U3FROEFib05yRis2OVlReDE3?=
 =?utf-8?B?cG1yblh4SkZLQ29YTnp6RTQ2MmtYanF5ekNMUUtYTHBtMUR0dVRtdXRxK0Fs?=
 =?utf-8?B?bmJXZ2dVMTI3YTZDeHg4dDlvUVljMVJHRVo4S0lqQ1hSUzFQL01OMFgwSTZS?=
 =?utf-8?B?czlURHNwbWgzWW43UUtDSmlJUHd5eXlYck5DRkFOc3VQN3YwTklqKzY5SGNY?=
 =?utf-8?B?L2U0MWdCVDhtaTllQnVDdy9IUG5uS2F3T21YNy90QnhyZ2tRS1VMc0Y5akZj?=
 =?utf-8?B?WGluaGRlRjFzZzRBTEg2KzJrUmNYWWNZZ09pSVNtb0l3T0VFcGpvVkN0Qi9m?=
 =?utf-8?B?SC96TDhDUFFMQU9SMU9MaVhLbVUrY0YrTklXOUhOdXhSanFhVXdGbGdwNnR3?=
 =?utf-8?B?VWtIMi9sVkZPUGVYaFlkcEpraDBCNTBLOUFDQ01KQmc5blhvUHA1VGlaamtG?=
 =?utf-8?B?WkxXU0d6RzAvc3N4Q09VT0xoS2g0Q1EwU3BiSE9wdW9PRkExZU1Tbmk3UERP?=
 =?utf-8?B?bHRQbEYydTJpUGFDNDd3TnpoT1lKUlFzaVJoeFlhN0ZHYTBsc0xtOUtmemgz?=
 =?utf-8?B?bTRmMVVZQkw2ayswRGFZQWZCNjFvUFYwSnJCVytTVkIxQ20rY2ZvR3lqYnNk?=
 =?utf-8?B?aVNxY05jRm9YU1BMUVJCTlpPSkZCOVRvUVZJNnV3bitKUXZmQ3BxWkxONlR6?=
 =?utf-8?B?aWM3WUN2T3BPQTEyNkUvSnVTR0d6bkNnRkF1T0hYUmo5bFE5R3ZoSmFPR0xn?=
 =?utf-8?B?TlZVNFNzeWJaMjZHTElHKzlaVWFmNUxleElwS0ZjMHA2R1J4L3hQL1M2L0JF?=
 =?utf-8?B?eEVhOVlLMG5VemdISWhYYjJHaHpsa2NHOHZxUm5lbHJYM1kxRWJHc3piWmR3?=
 =?utf-8?B?YVpmMFhSNHNvdmFITExCaXhGcUFSZFA0SWhWWHlkUmZlUVFmeXVFWmtmNC96?=
 =?utf-8?B?K0tobkJOeTlSaTlrMWRkR3A4M3V1RUtpMjZjUWEzb2daT3BJLzhsS21Vby9F?=
 =?utf-8?B?QkpYRnpDd3ZqTHlLTDZYZ3hldk02Nlpyd1JqaFFyMzMvSDVpWVBKZW1SWTFM?=
 =?utf-8?B?elJ1U1R2c2xPUXowc2Z2MFRteUJPUnpLOVlXK2Q5TVVMREdWbllueUZESVg2?=
 =?utf-8?B?T3Nwd296TTFwMWV2NzB6dWZldTMyVml6Y2xJWjR1WU5hM295enNqUUErbXNr?=
 =?utf-8?B?RmpJNzJ1a0Vzb3RpTHh3bkY5VnBvMVRWMHp3Y2tYR3JDOHJTMG0rWWlmb2ZF?=
 =?utf-8?B?Y2FIMFJCOW1oWE5hay9PRkhWc00rb0NYQ3FUZHBJajV2NElXOE0vTHpySzNW?=
 =?utf-8?B?UytHOEhud2JlK1IyM1IrOTNLaUx1VzAyb1VQSzgzbFhjTk9vNnQwVm1OMHZY?=
 =?utf-8?B?dUJXUVhjUG1UTExPS2wyTldkQ0pkTnA1bjBPMHRmMHBzb2V5ZEY3Y3JXNlYw?=
 =?utf-8?B?NDRMUERoMDRhclVYT3QxSlNONzhsRDIwNWZnMGhiUXZyQVBWakoyVUhJbnh6?=
 =?utf-8?B?VjY0L1FVelk0SWkxaXVxTHlUNEtXRmFMcW5STDJsQVhzYThQWXdqbkV1cm81?=
 =?utf-8?B?TURQNlVGU0N6dzBBSUZPM1hPdmgxQzZHK1F6aUc2UmJQNElNT3JEVnM3bU1J?=
 =?utf-8?B?c21Xdm9vZEZDalNsOGV4SzRGVWxtamRmNVFybEdvbTM2bWIxNUFoVURqYW1G?=
 =?utf-8?B?Zjc3SjQxdGhOL0QraElJTmRFQWsvUURKS3NLcjFzYXk1U2VMSCtUS3lrMnpO?=
 =?utf-8?B?dU43VGQvd3FDdG9FZzRuVHlDRm4zaVpETUtPNnNabDhHclhjcEhIVHBCSHhK?=
 =?utf-8?Q?jZDoEX2CVKHpdA/I=3D?=
X-Exchange-RoutingPolicyChecked: J/3o2sKLdthwGQmCl9pk4++PHb+caUhGNx7phlLp2y5wUWUrtbWWzbXTXnz/shdlnPPl3aywKcQ816/AcWLkbcV2QxcC96r21omQ32GqYY0xu+Iwd5XzgGImlpTgDOSPvIC5J8PiMZqlvCBdiX2wTo9ib1Lobz34c0TwF3HpQXziEQQcU4gGLA1asWy21xJnhKkkhCJVNvH7ELJS//kKQgWLS5C0eT852ibA1/cqnDBf/GnYJKG308r2b9VBqKAfuQyK6QvQjiq4d71Vet7gVP+5SfiogicecANfQ1hkWMDRKS64+58EVwkpOt4Ki6/ck0ZjHgvv0cKsd97kKaXMaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 72649147-3409-4ce7-a699-08deec9bfd69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:33:05.0451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o43hq0O/LpWWbQfBMUt0+hY28MTU4ue2B4Mp4FrKng98g0Vay4HRkxK3Yu8uM+JrD5kvhFjUdGyFjenc6zYBmFvSUUL/EHZ3eNriOMTEXCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-OriginatorOrg: intel.com

On Tue, Jul 28, 2026 at 08:07:48AM +0800, Jason Xing wrote:
> Hi Maciej,
> 
> On Mon, Jul 27, 2026 at 8:09 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Fri, Jul 24, 2026 at 11:42:46PM -0400, Cen Zhang (Microsoft) wrote:
> > > In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> > > loop without checking its return value. xsk_buff_can_alloc() only
> > > counts fill queue entries without validating their addresses, so it
> > > can succeed while xsk_buff_alloc() rejects all remaining entries and
> > > returns NULL.
> > >
> > >   Oops: general protection fault, probably for non-canonical address
> > >    0xdffffc0000000000
> > >   KASAN: null-ptr-deref in range
> > >    [0x0000000000000000-0x0000000000000007]
> > >   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
> > >   Call Trace:
> > >    xsk_generic_rcv+0x26d/0x5f0
> > >    xdp_do_generic_redirect+0x3c5/0xcf0
> > >    do_xdp_generic+0x92f/0xe70
> > >    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> > >
> > > Fix this with a two-stage transaction. First allocate and stage all
> > > buffers required for the packet, recycling all staged buffers with
> > > xsk_buff_free() if any allocation fails. Only after this stage
> > > succeeds, copy the data, reserve the RX descriptors, and release the
> > > buffers in an error-free loop.
> > >
> > > Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
> > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> > > ---
> > > v2:
> > >  - Allocate all packet buffers before reserving RX descriptors.
> > >  - Recycle partially allocated buffers instead of only cancelling the
> > >   RX producer reservations.
> > > Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com
> > >
> > >  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
> > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index f906d51b6699..383fc2b1de48 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> > >       u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
> > >       void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
> > >       u32 from_len, meta_len, rem, num_desc;
> > > -     struct xdp_buff_xsk *xskb;
> > > +     struct xdp_buff_xsk *xskb, *tmp;
> > >       struct xdp_buff *xsk_xdp;
> > > +     LIST_HEAD(xsk_buffs);
> > >       skb_frag_t *frag;
> > > +     u32 i;
> > >
> > >       from_len = xdp->data_end - copy_from;
> > >       meta_len = xdp->data - copy_from;
> > > @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> > >               frag =  &sinfo->frags[0];
> > >       }
> > >
> > > +     for (i = 0; i < num_desc; i++) {
> > > +             xsk_xdp = xsk_buff_alloc(xs->pool);
> > > +             if (!xsk_xdp)
> > > +                     goto err_alloc;
> > > +
> > > +             xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > > +             if (unlikely(!list_empty(&xskb->list_node)))
> > > +                     goto err_alloc;
> > > +             list_add_tail(&xskb->list_node, &xsk_buffs);
> >
> > could we use existing xsk_buff_add_frag() ?
> > then I presume xsk_buff_free() would understand list and walk through
> > xdp_buff's and free it ?
> 
> Good suggestion, but xsk_buff_add_frag() will add more irrelevant
> stuff like nr_frags, xdp_frags_size, xdp_frags_truesize... They are
> all happening in the softirq context. Refactoring the helper would
> bring more work here.

Fair enough, how about we meet in the halfway?

Don't use xxx_add_frag but reuse pool's list. Reason I'm pushing for it is
xsk_buff_free() has been thought to consume multi-buffer xskb's, so all
the list-walking would be hidden and error path would only consist of a
single free() call.

then the do/while loop while iterating could be using xsk_buff_add_frag()

> 
> Honestly, I like the local array which seems simpler/cleaner to understand :)
> 
> Thanks,
> Jason
> 
> >
> > I believe we could reuse pool's xskb_list instead of fabricating the
> > on-stack variant here.
> >
> > > +     }
> > > +
> > >       do {
> > >               u32 to_len = frame_size + meta_len;
> > >               u32 copied;
> > >
> > > -             xsk_xdp = xsk_buff_alloc(xs->pool);
> > > +             xskb = list_first_entry(&xsk_buffs, struct xdp_buff_xsk,
> > > +                                     list_node);
> > > +             list_del_init(&xskb->list_node);
> > > +             xsk_xdp = &xskb->xdp;
> > >               copy_to = xsk_xdp->data - meta_len;
> > >
> > >               copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
> > >               rem -= copied;
> > >
> > > -             xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > >               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> > >                                 rem ? XDP_PKT_CONTD : 0);
> > >               meta_len = 0;
> > >       } while (rem);
> > >
> > >       return 0;
> > > +
> > > +err_alloc:
> > > +     list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> > > +             list_del_init(&xskb->list_node);
> > > +             xsk_buff_free(&xskb->xdp);
> > > +     }
> > > +     xs->rx_dropped++;
> > > +     return -ENOMEM;
> > >  }
> > >
> > >  static bool xsk_tx_writeable(struct xdp_sock *xs)
> > > --
> > > 2.53.0
> > >
> >
