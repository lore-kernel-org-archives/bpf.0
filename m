Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB62D5937;
	Tue, 18 Aug 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063209; cv=fail; b=oSlcZ+08VngAXTNVn33Bm9UqSWAA/dsHr4vUBAOd8GOKBL0Vu43mDQi5L7IBDkCz+NB/Eu5cukfUMkBHP0PEG6RG4HA3wTkx01KfGNfBQszggCaIDcKPrX/raykpKUI7blw2Jfg/JND1CiVEXUccGOWyfn5X0fzXXqnSdzt/mNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063209; c=relaxed/simple;
	bh=NKjxRLQqrpduo2e6jr927+DVuX2QLWqzpQFvn+KXcFc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YGdCYfMC6ESVQZQh/g8YWX4dlae0DNzuo3c/rk+HPhKXAB3aCf46jXg4MUnZFv8+JotaMQIbSO2N1kyIdv8X49V6kMm/Rr1AuA0AyYKau6d8/ZkoJBIhfAwNGleNr7y24jzv8DbBANo/2WKY7ksPdZixISSRgPny9KwZnTSqWqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcpk/2rw; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcpk/2rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787063207; x=1818599207;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NKjxRLQqrpduo2e6jr927+DVuX2QLWqzpQFvn+KXcFc=;
  b=fcpk/2rwF3XJzHDAiMyP8yhz7DsaW2Kt5Kphs6GvC1yezxoaPBrN1OpJ
   62qU8Iu4wK0f9y9Q1Us9E3KeiS2ectz+lCpv9aizGW92nRCWrUuLDRd3X
   zgSih4j4ifKecyxJ09BIjSEMPobpwV+G0Hi3kpXcOP7CU3L80LgdBOnSr
   CLmJON8KG/b8B2v1Ry8lJCYYYaAXfEeyddb3DD/izPR8x5jOjfU0Z1/s3
   oFM1IEfokhBOB/whEINxWujOpEoK6fFdROo7ZxDeESBiee2ewAw12Apip
   4VYtgN/ZiPC7nPNNuU4ZArf2xQfEwhhGjDrzZGcnwj7PlMGqkAI6/2hqR
   w==;
X-CSE-ConnectionGUID: /avyXv8AT+m4cj0WvPk86g==
X-CSE-MsgGUID: Ux2HsZvNSAqMND07vqfkHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87574097"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87574097"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:26:46 -0700
X-CSE-ConnectionGUID: N2abPv95SZuHYXJcjHos+A==
X-CSE-MsgGUID: U1C5gvI2RKS7Vv+CeXzo3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="268753300"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 07:26:46 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 07:26:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 07:26:45 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.65) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 07:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwtAQKJdYgGBfO3tlYxf+kqCWmUme/bBFwflJz4+etuz6lzpxeFJDQm5OQMrss3ceFLvWfrEqAbP24tIOEureyMkRC53+bjVyHSdz5o5ugMjvHSKFaPEO5s1suuEbPC4yQfFaooxUsKqtKcD7ucfewST432E6M5qdKQPKKfUTUzOJsWCGd72WVF1mOdfxkfcWnmK9sRSL6V8PbRG/v46lXIBtw04wIco8YrMjL6+wKMjoCluZviAazYwcUEhHiZNC/L9s2IeCpxn84ZbB8wkiZxE7rqspAuIcNwuCIjqGxUYXlEQf9DHDDoVfskDC3zDHJ6eftWHTgNgudnkqL/eZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGzi9oHhz/+VScpcgmmIZn3gGO0u2zinx/AUPVcJU+0=;
 b=SH13D4MzBoLQ5SmCSWey1pyoOfQ/okjGprZQAOovj8Pt5JP+yb9kNCqrWW3ufWJbT2rn4D4OxRVLn9mU2SRD8sAijBGiCqiPiYm9mwojKdrZgCF6H8cD9hWsd5iTYJVGd2U+vPFZU789GLyqvzbMu36BB34DhnXYVjpENyemGLXPOpAw+bktuU0R27owqmyMrqn/KpF81Ss1Gd0y8N6WFAunGi+6IgMUJhAElnWXALwH3cz7m4zOUgYVIr6PFp0PKn5Z9Rbb4Z0JIkyM3Qt0VA2YbpPYHcr9ZmII1mKp7CGuILYDmx/6Iu5CVLb7T0849YR6oOeB1kc0YNYWbeYQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA3PR11MB160535.namprd11.prod.outlook.com (2603:10b6:806:594::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 14:26:42 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 14:26:41 +0000
Message-ID: <d9c3234b-99ac-430c-ab62-9b1412af3461@intel.com>
Date: Tue, 18 Aug 2026 16:22:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: xdp: don't assume an Ethernet header in
 generic XDP
To: Jiayuan Chen <jiayuan.chen@linux.dev>
CC: <netdev@vger.kernel.org>, Kenneth Lee <kennethbwlee@snu.ac.kr>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
	=?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Martin Willi
	<martin@strongswan.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20260813113229.381136-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260813113229.381136-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0238.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::9) To LV8PR11MB8722.namprd11.prod.outlook.com
 (2603:10b6:408:207::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA3PR11MB160535:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd6b98a-faf0-4e12-1eda-08defd34b82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lLufrl3oyhYAYWPVPt/E+FjFtl8zxL+qV0Pr0QelT2KnVYeLp4VeaojPXZCCGBaVdgw3ZwwHBLuINNGtkpmzHYT6JAT33/P0mxnmV0wYiArifSo2VgAykziuljf6/bjiK9SrBEIo8SqHHY9BYT5Jb/wQDKY6vGAeATxN4KLbWTWXNL2dDlXlUQ5vmrSSFbnDnSzgRpg8u8M0oSsA3p1kkiLnrHpdaBaGAq1Ek3KAaaaId8fUN1jph+sEr1DUk9uDDeWPlU/PUS18cSQWeEl9CvK+cPl3bLnExHLCxcxApdYrzOYOI2BB9osEun8r+pT4t4/EijMq1+qEhSydJ3gYOweQP3EOJSRe5ARO4hGp6UcU0pBatVxiCVachw43/dxDfY1xb8hkS9Ef0703g2uK80rbey+oFt9YIQWHzhhfknIK/h8sRiFPk1zxTJozPPoQY4tfSV/sNCn215Eg7FjfPYUUCBbxTZnw9PXaerehAO5YgfA4f2vtICBLgnsSk2c9n9mHv4noIqYANBd+L7Gq9Zef2A58DXo7xdmJZDLcdbLcGCv0lv2QzdphfWpr0mgPs4sU4muS2EgeZUfnCZady2Dbp6rwA4gqz7rOd+9/RPjdBMgJ/lO9NQq1UpFTnmo2/euKQBMNbblSSEYusboyjEbgCGlavaBt3b6JV4u02UQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V09GR1pBRDNDRFJQVmVaY3RaVHJLeXBJV3N5Q3llM2Uxd1hnSW9CZGFEZ2lu?=
 =?utf-8?B?NVlRbkdKUFFjK0F1bFBsK2Uya3BSd1VpMVpnZFdjQ2I1dFhrU2xyNkNROGE0?=
 =?utf-8?B?d1VwckRTQm9xdXh3NjlJbC9MVlcrMVlNN21GUHQ4VFFWQll4YkFQNFpnRGgw?=
 =?utf-8?B?cnp5RGpsbkh3c2Jpd05GSkVPVnJ2L21qK25qMkxvS1NmUEdwUmY5bDczYUVu?=
 =?utf-8?B?RmtmK1FNckxMUmt0US9NQk5Xb3hDcXkvYnhsQTAxcEgvVHpGcFV4VjVwdFpi?=
 =?utf-8?B?ZXdhaStLMnpScnlOeUw0RnJXOVRXUFJncXlSUHVZV2ZCSjloYm9NZDJnVjlU?=
 =?utf-8?B?SnpCeWM2SDdFUjdrQUZRNjFzYU1WU0dOcGJieVZQRzNXZUZBRzJxelJaUnRT?=
 =?utf-8?B?Z0czR29LQ3NMdStVYVkwWnZEUXBkaUxUbitrZ1ErczZ1SVp4NFJVQnJtT1FQ?=
 =?utf-8?B?eTA1ZTlQQ2ZsNUF4YmIzc0JlTnJnL3ZGalZwMFdad0Z6ZkFrTk5XZ2Y1QlRT?=
 =?utf-8?B?cXBVRC81aTBIT040eTZJZ01sdmFGNUtOUEZvVzZJYkVuL1FuZTRQMlhnWXBV?=
 =?utf-8?B?bzFGa1VPczk3NTl4cGVZWVE4Vk4rQ0tHOGRuVFgvdkd2cFlFT1FMQlY5MVA5?=
 =?utf-8?B?bmhuaU1JSFdEdDBlMWFUS1dyYWJaYk43RHo5TVlLOUJmaERTd2ErWUVnUlNi?=
 =?utf-8?B?U3ZnRGdqSkFaYXZKOW5WRlJ5KzFYa0ZmSmdrN28zVW5KK3UxdzhBQTQ2ZHBK?=
 =?utf-8?B?Q2tPcDZTTW9BVjZ5MEFBcDBaTHdzQ3NqQ09tMG5QT1d4c1c2bjJzTDV2dHZo?=
 =?utf-8?B?Zi83TFp5aSttamlYS1A0RTNnc1RwcEhSV0RuWndUam1LTGpDZVhraFlNRDM1?=
 =?utf-8?B?WFhWRm9HZ1FkSWdPN3AxZzg4YStXSTlROTlkdzZkYjZqOHFxWEtNTXF0UWNT?=
 =?utf-8?B?bkJUR0p1T2hESHFmZVR6VmZJVzAzT3BDdkxhRGJwV2RWMWg2alZDWXh3bDJs?=
 =?utf-8?B?UCtuaTlmM0dnelFUQ3hJdG5XR24yWVdzLzJVZFUxV0dQMGxxOURJMktRTHlI?=
 =?utf-8?B?QnVwRGNhV21jVUtDTnY4amQzS3ZrVjUyK0VSMWROODdoOHZNNXMyV2hzeUlD?=
 =?utf-8?B?YXVFbzhBcHlyRW5HNjNjOWl3Z1VEQWJVWmRiajQ1R2QxTGFvdnozZXRQaDRF?=
 =?utf-8?B?VEl0TXZacFRkZlZONzNRdWlSWFhwa0phTFdKeWtNZ1ZlN2oyQ0dlS3NaTmw5?=
 =?utf-8?B?Z2t5THlxZDJSdmRFNUd6V2I2UXU3bXZpV2dpc1hEdERYeEdldTJhanpuU3NG?=
 =?utf-8?B?WTVMVXpWY0pEak05Y0hCbE9IYS9HZjVzaGkyRUdRSDQvQ0dvcGliWjlEdjhS?=
 =?utf-8?B?TTNtaWE3QVUxeFVGcm1RRDhxQkI4bHlsYXZZM2J3SDVESGFZeFJtUlFTR081?=
 =?utf-8?B?MjBZSFRNK1BCNno5bFhzOS81M05OWGRreWJwT29hZVpJYW1zcUhYRTFvbHdw?=
 =?utf-8?B?R0lkS1p3SERqTUFSNll2VTlHOU1PV1gyMFV6RFRqNWtWdVE5SmUvb0Q2cUNk?=
 =?utf-8?B?Z3pQNUZqWndBVTc0eGh6N01jV0loSmFwWGdSRjNXRGV0ZzRzNW5tWUdySzRs?=
 =?utf-8?B?Sk1hbFpweHZub3RXQWdid1RSZ1NmWEhYbG90T1kxYi9XWVk0dFNDOGxMNEEy?=
 =?utf-8?B?dHRhcDBtdG5HM1daRE5qd3A1Yy9FdWlBWEtqUzFsYnUxQVk3Z0hEK3VkQVNS?=
 =?utf-8?B?VUV4dzdob2NuUE82TStIWUIza2tLeFJkWC96ZXUyd3Z1NEV0VkhLM05tQWhB?=
 =?utf-8?B?d3E1L2w3UWlxN2kwQ0FPaVF3bTUxYUFaZjVmcFAzTnI4ZDhycGE3TlhENDFm?=
 =?utf-8?B?WUVYNmp6alFwa09uam9yOVh1clgzMm1SNEhCNUtzVVh1UmF5a1gzWE5UOUpv?=
 =?utf-8?B?LzVweVh5MWxPNy9MZUttSHVqSVg5bVQ0Zk1oM29CTnJFRzgvU1BZOEVmZmcz?=
 =?utf-8?B?a2l3S2VBU0M3THh5T2c5NFBrNWtVSUxkUitBVWcwS3dOeWFOTzJMVGxWdHJD?=
 =?utf-8?B?cVNTYmk5TC9JQ09IU0xDNWZtZC8rc1BEYzJrVktxS2Ntc1NqbERaM2FYQXFk?=
 =?utf-8?B?QTNseitybHhtNVFZaG45VUExL2lVNWZycFdSNHFIQ3RrNzNSaVo5TVBIK3FK?=
 =?utf-8?B?N3hsMUU2YW5kS0ZxSVpYOXdWbXhQd2FmNVgzQkJzejY1TXJYUlNEbTlsclhp?=
 =?utf-8?B?UGlUZXI4NHh0S1dTb2NnU3lSbmdsRi95T2JUUUJhRlEzYVVlb3gyWEFYVGQz?=
 =?utf-8?B?OW1MUVVBU0NzQ3owaS9rVGtBUkR4UmdPMDZwcXVQczFPUzY3RlhjVG81azZM?=
 =?utf-8?Q?XOBEdkPZdCaUceK4=3D?=
X-Exchange-RoutingPolicyChecked: aKEOXXWtQscuASEb/AVhUagkN/5xvaUqvXbh8dUUgVVR7Pu9daXXrUYXyfFhyo1SqONnFEF4PveJvqIySI39+FmQHTRVbTVmculE7iM5KTtxu+ZOD9bCmELpppsUlnrtdecO1jHm/yNiFUxvaslsj7f7eq31Z8JBQDAI8q/ykDrrYyS6Q8W9TtLnw8qnvZSgzQ/XBNY30xT+mGPhF+aSayCPpScNlRiajiiQj3V31N8MuPPlhvgn3Mg1+sEt6jnWxH27vx5sXXlWFRDJ8mWHUtVVcG1ORQPfZ7BdbYi6fDdH4eD9s1JKK2yiRJYHjeAdXqWaexutigvScdI6PBHmAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd6b98a-faf0-4e12-1eda-08defd34b82c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 14:26:41.4442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdrnOXVJUWbj6sXx96pY6jJ9msDgEdvv1rNaSPdZYMc7Dz/KxOnVtewGNke7Wi9erP8zbalhS85vesWJrdL5Oi13WK1zigKosBNQ+DDWgD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB160535
X-OriginatorOrg: intel.com

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Thu, 13 Aug 2026 19:32:24 +0800

> Kenneth Lee reported a bug [1]:
> 
>   skb_vlan_push got skb with skb->data not at mac header (offset 14)
>   WARNING: net/core/skbuff.c:6474 at skb_vlan_push+0x5ec/0x8a0
>    ____bpf_skb_vlan_push net/core/filter.c:3239 [inline]
>    bpf_skb_vlan_push+0x216/0x8b0 net/core/filter.c:3229
>    bpf_prog_run_data_pointers+0x17c/0x240 include/linux/filter.h:917
>    tcf_bpf_act+0x31c/0x940 net/sched/act_bpf.c:50
>    tcf_action_exec+0x2c1/0x720 net/sched/act_api.c:1147
>    tcf_classify+0x6e4/0x1080 net/sched/cls_api.c:1860
>    tc_run+0x31c/0x5d0 net/core/dev.c:4411
>    sch_handle_ingress net/core/dev.c:4486 [inline]
>    __netif_receive_skb_core+0x141b/0x2ec0 net/core/dev.c:6054
> 
> bpf_prog_run_generic_xdp() just assumes xdp->data is an Ethernet header:
Most XDP programs expect Ethernet header at the beginning of a frame.
Unless you write a custom one which doesn't.
But then you may face that XDP_TX, XDP_REDIRECT won't work properly --
cpumap Rx, each .ndo_xdp_xmit() implementation -- all expect Ethernet
header at the beginning.

Thanks,
Olek
