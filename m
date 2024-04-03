Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B933224D4
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712147905; cv=fail; b=jA07xr7JIwBZY2hydmMzDD1e0Jdm9zpIVqQMdv7cHcdPnBWDUcH3qjRIdVA9NI/P3zs8bv0qkgcNzjp8732rJZK/hUFBXGUVJxOH7PhpgSIMhJbNeDcgJe98UTqj3/mYE3la+r7UYeGpeztNg25iMlMe7XfVF2x51A/ToyYM6hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712147905; c=relaxed/simple;
	bh=vxUgYjT89qH8RVuGSjhODZp33OrPK1B5I1q9BLEDx5g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ve2WIaQTMmb40JQKek8XEp/pefNqPpSdy0IvEdogUhqIjW89PqUZAw4HjV69+cHks28mMAzqivKZ6YhnEmHevqSQcgcWwlenUndiEoQf750T/ITecCaTG361E2wGnVLXwjKdPld46bynvxE/FvIcYW4BkgriQZz5L2oMyaHaemg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cCMEmJPB; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCMEmJPB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712147903; x=1743683903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vxUgYjT89qH8RVuGSjhODZp33OrPK1B5I1q9BLEDx5g=;
  b=cCMEmJPB7C5gL/MGa0s40S9sR8s1JN6Gzg37kh0ClcrkEDtLB71ru+sZ
   pOkEmsAg9hbprBzfQl05E0wESYC0i0D8IGdP9JGEweyQeRt4/+Z7LFaUk
   YFpjFAkRSPcrfTozLw/ZskxbFHpbtNgp9QDyBIpHOS8pzAkRzcwCGr76u
   KaZANpPzTiwKhsVINPvkEo+BOi26zik+5MRcphFF97aVP0oFUCwvSoQuL
   GTto57YkZumw+blGjMv9JUnRSNYqf60yw0AzmTlUZzcvXBMpIDXK9rwTO
   cz7Rk/JjggwMZaeADJ385HYQdgLKvDdQYmJDM67QHVk0/Hb6BEITDvJoo
   g==;
X-CSE-ConnectionGUID: DRjcpAdNRjiet9Bi4Xfepg==
X-CSE-MsgGUID: ZOvEv3mcRZei4rr+hmQmHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7237006"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7237006"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 05:38:22 -0700
X-CSE-ConnectionGUID: eQKdZfdFSWKlFzJ9cySwqw==
X-CSE-MsgGUID: CZUIE5fLQqO0NLWFSIR3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="49662093"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Apr 2024 05:38:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 05:38:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 05:38:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 05:38:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 05:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh+A1v/flGDBPDtzoT1qciJpQYcJvG0/Td0uhsam18T5aWcAVBtwKXgAgGZlqAaAqX3GrgpNpI0QL8tjA3w5EkCKBNp48zQDcFfG07aq3a8C75S57pkIxbLsB/z5MuLdbXbr96KJF/cDr5KM5DJ/331i+HzudchOdevgJyoXPvnmkv7OKca6RbmkgADXfZ3xUPNfNOgkDE+6oezuhWFzN2Mjw9+BzKyhEbXOHOZQA8Bzq21LgVSbpVfxjRulDwzcPVqalXZJg22iZD0Sy04rnf16pjtsXX7rSzD3SaMVpiBsQLM7LoIdT7VIUlC0J34OJYuPKAunf7Wv/ecfhRpbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwZ4lEKINUTTAVPTiH2Na56TUEtu4ybIHjRg7G50n7w=;
 b=GkbIAXsG+54Hz7xrUwqanml3gIOlhTiUaFvis+/n9nKowM44A7cbUv/QbVFYTuDwF4wfn5F8FfuTSDVOz/6Bcl9Kk7804keY6cBNvGnHnQ00bJ9mrDY/ygmP+myurOtgK+ACM6ZaoPa+5TamaqXf5e2HtFH69InHA3b1UFYlXto63Kqxnr4GDSERMA91iyeuC2VRX6SLHix+nLWeL1L/CbwLb4h6kgR77mVhbIn3TLf1POGj0Tc9EmkH3CfS32NhNaXvRiXLyKLh4xdofIP5DS5dP7Up89MQcX/EVcDPcev4rAp5mmp/tBiX73gS69dWpydVDuc5nWU3uQY4QtFenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6683.namprd11.prod.outlook.com (2603:10b6:510:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 3 Apr
 2024 12:38:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 12:38:18 +0000
Message-ID: <b3401889-732a-4058-b574-0207cf2bd481@intel.com>
Date: Wed, 3 Apr 2024 14:37:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: pack struct bpf_fib_lookup
To: Anton Protopopov <aspsk@isovalent.com>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>,
	<bpf@vger.kernel.org>
References: <20240403123303.1452184-1-aspsk@isovalent.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240403123303.1452184-1-aspsk@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0159.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xc4FlXeNl3W6t5aGlRiwPSYspKGLQFgFZiVfA+bZ1wO30xSuoHQ0yhOwpwQSQvhrXXeCsk9l5RsHH8avf4psxCW3t4CWaOnsod+0IKtV4HwoW5RxWBY/hzgswPeBIlJdEsWvo3u3TDp2nmOnUzLwluQw3E6mehmfED9OjB5FtKEyTyybsYmDHMikED9KfSlx0URKHoVH+GFz+NjGP5tiME5mAFMdgRtb13ulp4XxuumJBsxvwr3kejQ5OXTz59h1GclAZu+NOi35jYaaaybbW6+lxACl6lE05VLYdGvqEPA6OcxdDWGW8b0f3fDW9otufL5PK22Xg7oGJnme0+WyRTHnbS1YJh+jnbXIGSKvknHZsnin6/Bx4de7dqQS+pkETMhflOlyVJCbFod1KSgn8qhp/vQXhuAxrjREIx4B7zuCByh+9BTe8e+cp2F4dqn+a+f/D6uk+mtocweu2Q4x7kIq+mKb6+U6JT2ob5baQ0h3TamEt4TrOYg2T7TBQeaWirRAXGFXRX4zXCh36PLIT3SLVMi1PJ5K+kzQDcYdRRUIODnPUNE0hKAcbBUFLDqrPkP+x3WCqY25AWCI68/44B9Oee3Joy+Fnic3lr7h37E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlEvNXBjRXlJNjV4K3g3N25va1lzbllQOWZjZzM3N201aW9aaEowK2svTHJL?=
 =?utf-8?B?SkREKzlaRFZ2R1RKbmU3K1NhUyt3UXdFWnNoK2VwZXd1eGd3cll2a1F0dksx?=
 =?utf-8?B?NGQzM3ZyQjdIUXRkbDdmMmJ3bEJTU1JiNi8zVnFFVFN2d2l2c2xLNmxkNm1n?=
 =?utf-8?B?RkhZTEFGem55dHNDaTQ2dWFyVytYaHhYU3Z4dXpGWjlibGFPRHRzRmhwU1J5?=
 =?utf-8?B?bXdJdXo1ZWV6ZW00UUhRWElVeUhETzRLY0UvVzFpVUJjbjZQVDk0S3ZHclF5?=
 =?utf-8?B?TytLY2x0U2xmRHRCbHhlMW5MajBPT2MrRUE1Qm9taGpvdEFDZnFaVWpHNUFZ?=
 =?utf-8?B?bWFSUkE2OW5IZVZ0QlFvemtSdkE5R2NpVFQvcU5zWHVUUFF6TnJGWXQvTXV0?=
 =?utf-8?B?WmJSNEY4S1J5ckNodDE5WHNTMFgyRGlNOGtQaVJ6eHhleUZjMCt0eWMwblM4?=
 =?utf-8?B?NldPVHJRdjlGWGY0NVozUXFuZWFZb1I1M1FIcDJ4QUliWEFpdmFqVlViNUNF?=
 =?utf-8?B?SGttOEs1c1VKYWtidkd6bVN3Zjh1MFRtaU56RURlWis4MThJbkFQa0laVTcz?=
 =?utf-8?B?T0pUbVF1K2pYOFZVdFRKL3lORzRUSW9ZVXFXQnlzbEF1UkZhdmJ1aHJiUUNN?=
 =?utf-8?B?VnVIenE5S3E2M2t0T3Z5eUhuYkhNb243bEF3VWNZVFh5UnlWbmtwcFJnZGRQ?=
 =?utf-8?B?OVJOWDcvYTJodjhpOFhZc0FZUmVZVXg3My8vemYzeFNVUk1YVlJGemgwV011?=
 =?utf-8?B?Zzhsc096enF0WlZtUlNZQUlXNnp6bW1KOFF1bnNnbzlBdS9xVisvNlY1VCsv?=
 =?utf-8?B?REdPNDhCaCtXN0dzVk5lT0JVTjl2aUJYelZ0M2toQUlOUS82WWJzZlBhSTJ2?=
 =?utf-8?B?NklOejZBek0va2dQelljZU0xK0tEdGI1Z2ZMTGRqdXpJQ1ZwWEdYQXlleEpq?=
 =?utf-8?B?aTg1bDdGZHowL0l3Z3B6RnNPSmdVcHJiWVIySVJONkt2VnZaUHZGM0JlUFg3?=
 =?utf-8?B?djljaCs2ZUJRMlRQMk5uMFZqK2FFQjU5YjIvSzdhc2U3TzlENURlNFRZZGVD?=
 =?utf-8?B?S29PWjhEZ3dwRWJiNFFObUJuUENFNUxTV1IzNXM5eFhXSCtNTDlWdXo1SjJS?=
 =?utf-8?B?d1FQUUcyOXBLa2lkRzhFYmo1NGI0ZjZ1cFEvekhwWGY1ZjU1VGRIVjlRSXhW?=
 =?utf-8?B?K0IyU0dUTWtyTG9wMkVvMmNkYS9pMFYvalVGZXRPSDVRaDlJSDNYR1lFMVF4?=
 =?utf-8?B?TVBWTEt6S1EwUVd4RS9sWkZwV3JPeWdqcDlHNnVrckl5TjhGVEoxbUMyTzFv?=
 =?utf-8?B?MkFadW1lSmZYbTlXZkJHQ2RmdEJCV1BWUG9DWC9BRUwwQ2NsZFFuQ1ptODFQ?=
 =?utf-8?B?RCtWUit3NWZla0NXSWIyZ25zTnZucTZWNEVYbWR6Y25raEQ0dWhMTGduTnBK?=
 =?utf-8?B?ZEEyM25kc0JZK1JpeFJ4RXRTOEFDQ0FieVdrT3hYVXdYRmxhNGRWZzl0eERR?=
 =?utf-8?B?RU1KZjBtMHkzUFNrdUt6VlQ3VkRjNEE1SUdTMkJ4UEt1UVNQMDFDVDk3MWVL?=
 =?utf-8?B?UzhySElrRHlnbm1jY1BuSWxSYnE4aENCUjEya2RWYTVReE1Sc2hMZXpUWTMy?=
 =?utf-8?B?czRVWnhMWDhHdzJDUVlNNGdYM3J4b2pHWFpFQVZWUTlCa1NHSFMzS3JwYXh4?=
 =?utf-8?B?L3Z3UVJwSXVnNEUxaDZQY1FSQ1ZDOHFER2ZkZGkzcVh6T0xPVlFXZnZZUUFF?=
 =?utf-8?B?UTFweUdpMVpoMng0ckZVZVVjNDU1ZStKeWw4ZkQvNjVsS0haVmhSVGZadDZa?=
 =?utf-8?B?a083RDdtYlVsbklDT0x5V0p1UitSVlVhRzhLbVJFYm1ReGFtV3BJdU5uVGh0?=
 =?utf-8?B?TDhOaW1qaU5sNWRjUjBKK2NOMU1YVllFenZLZjc1emE0d3BlZzdKRTlRREFN?=
 =?utf-8?B?Rk4xbjJ0UFE5dmF5WGtHZjA2Ti83TDRGZ0F1OE83bkthNS84dzVwWjFiRDR3?=
 =?utf-8?B?TWo5YlI5K09HUTYwbkNJbndtTUN1WDdHeHhaRXFzT2RVakxPK3pWN3ZCQ1U1?=
 =?utf-8?B?c1NBb0ViRVJiQVJSVnZmbFlxeVpNT0FsUXFiM29hU2NhcXZmTU5aY1FhZHBy?=
 =?utf-8?B?by9JaDlNV3dhd0JWRVE0WUUzS1Z2QWRWcXRZRFd5aGpTRzFrOVBKRk1WNjVO?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a51490-956c-4fd6-92a9-08dc53daf06b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 12:38:18.2342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCc+sfF8oNXB4r6l64fUphyEEM2W/92hipVRs5VLHbxZxEF5S4QCTFUp/Slm+ZmSpRuyhX2GjD+3K6AMEKHx8LyhbBTU8HvYWI6p5gTZYL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6683
X-OriginatorOrg: intel.com

From: Anton Protopopov <aspsk@isovalent.com>
Date: Wed,  3 Apr 2024 14:33:03 +0200

> The struct bpf_fib_lookup is supposed to be of size 64. A recent commit
> 59b418c7063d ("bpf: Add a check for struct bpf_fib_lookup size") added
> a static assertion to check this property so that future changes to the
> structure will not accidentally break this assumption.
> 
> As it immediately turned out, on some 32-bit arm systems, when AEABI=n,
> the total size of the structure was equal to 68, see [1]. This happened
> because the bpf_fib_lookup structure contains a union of two 16-bit
> fields:
> 
>     union {
>             __u16 tot_len;
>             __u16 mtu_result;
>     };
> 
> which was supposed to compile to a 16-bit-aligned 16-bit field. On the
> aforementioned setups it was instead both aligned and padded to 32-bits.
> 
> Declare this inner union as __attribute__((packed, aligned(2))) such
> that it always is of size 2 and is aligned to 16 bits.
> 
>   [1] https://lore.kernel.org/all/CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com/#t
> 
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> ---
>  include/uapi/linux/bpf.h       | 2 +-
>  tools/include/uapi/linux/bpf.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 79c548276b6b..6fe9f11c8abe 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7157,7 +7157,7 @@ struct bpf_fib_lookup {
>  
>  		/* output: MTU value */
>  		__u16	mtu_result;
> -	};
> +	} __attribute__((packed, aligned(2)));
>  	/* input: L3 device index for lookup
>  	 * output: device index from FIB lookup
>  	 */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 79c548276b6b..6fe9f11c8abe 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7157,7 +7157,7 @@ struct bpf_fib_lookup {
>  
>  		/* output: MTU value */
>  		__u16	mtu_result;
> -	};
> +	} __attribute__((packed, aligned(2)));
>  	/* input: L3 device index for lookup
>  	 * output: device index from FIB lookup
>  	 */

Thanks,
Olek
