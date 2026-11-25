Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795605571;
	b=5XJFG/sMjaen7OwxhyOkBrpRx6T1jyZTj1e3u+G3DMcsjS1EjwOa+0uzboIvu2+Zoh65
	 x5nUzD0xKGIgQtqP6gHrxdugCAS91ghdNQ40ohT0copAfmAwIhqJ5UTWAHOeAVgH86Iiu
	 jaHUksbIN7MzjRnJNvZQaxb+gGT6CyM+Zdv/3uVBxHslEpsNkauUDElUhMeFvxxpPqvUZ
	 TuYnhTlkKE8kI++cdGVTs5hTMrYNJposNegKdN9ZXJgjJodPIA/p+AYXvPhvDC3P0WzR0
	 3DoUSpWzqOdpHJ1aElWleSpre846Lcl81Y32iAw+qf3QeYfAsp0TI5t6/4qAGewYb5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605571;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=jqAdEY6Q+cDBooSie93b1bhlBW9h5hR2AmJN9EqnvG8=;
	b=Wagu91GPYyfxz0eH5Ncdks/ePH52QEwJHqC34oODKt3CpJuJ240Hh2Sbdcczu56lEp+O
	 K4XTqzzpHJoJgXVtr8ELoDllVO3wa7bpowsWzrB89+EUTVL5WGYotTRydWWLzxBFY4S7G
	 RlBkHtHxfmL+0pRD5Om8qPJDubgGMCOITIGOoMTQiSrRXb38L7kkz3sjV0OgAghws9VhB
	 kqkZF1zyoSkSAYmUsbMlzCfvOFsJaELd/5Bp23zKphF10TFRO0ka19R40DGmJj926l7g9
	 Rd++F8lIZ7zkOzQ7nrz/YvpZS26PO2YSxs/M03BuoaTFb8EXEOwd+Bbxcknn/ayYawg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P2tu2loW;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DLI1fpZv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E127606A321;
	Wed, 25 Nov 2026 11:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E127606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=P2tu2loW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=DLI1fpZv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795605571; x=1827141571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jqAdEY6Q+cDBooSie93b1bhlBW9h5hR2AmJN9EqnvG8=;
  b=P2tu2loWFCoZbX36APG/BUesizu2YlyI4CP5SGGjxCAPONOvG+xxfv8J
   DRTPUY4xcz2VMbzBwWuhk7PlEDRIwo9de9WuZNd+WAgzQTdopnVI1dRS+
   EdUFUXJLxx42wB3gk7Z6Ou9ZFr1xGtfTt9boMWBPi1nmg9KzXL91iCtdA
   fMAeUM3KZeBdNk1WzDEk1YxkIcxFUiEZbRRCR5Qytq9bJSn/Itw5pMwOj
   2P9j28XQhK72mUtzIG5XQkTnP+XZDkKlmc5KSK9zbIefCaXTWVn7tzjZN
   cw2NjnAG+aINYXohfnY/wSODp+6gi9HHKH5WKbZYvCv843AnRWaWNTHxG
   g==;
X-CSE-ConnectionGUID: jTBh1E/aQwmOLkPO7W36LA==
X-CSE-MsgGUID: VLr9w9LjRZiZ4l1839JkHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4469874"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4469874"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:19:23 -0800
X-CSE-ConnectionGUID: 47H/zZWHRzmxbQ96vLiYvw==
X-CSE-MsgGUID: qs/Nmyq0TqaSfCxINe+K0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11967543"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:19:23 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:19:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 03:19:22 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:19:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKj5Yo8/UuUPcQlR790HYub0nW4injg5TauMJ78ebNH7z9TCoFI5jFXnuE9KejXo97WchgwdZ8Bn1zN6NCO7NgYU5DhdpEjL1LsLjIbwyUFBBOb+bXwD8T3xpeHWRKTZhLXV4tqAn6AAItKpTbEtcEtp4p/u4aSvbjXw69TTFxwsqxSE6AowzKy1wBDyiF3YqE8ng61CX5RQjkXmiK7soKlsYxA9Ea3XueVi86ImhbyJpQapG6+6CStCV/WEX3RBbToB7Eh2tU7adBcTqIwgjR7p9Y1Xs63M07iDPK3OGFZ3xUYa+NrKPcejDWwkwaoAwz2Ke7TrqUnSupquHMrqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqAdEY6Q+cDBooSie93b1bhlBW9h5hR2AmJN9EqnvG8=;
 b=tdbI1fk1YiQWVl23g1ePsSLL7buWal1uZRFYOk04V02zCQ0EPNFUVRcLH8QWMvRZTI8G0HifZM6u8EQWZ4XJw+tIZAP2JB+rJKkcqliwPiOmtmPpAx7I/VZOClST49ZTnpwRZMu0RCupfhyNczrxYp/4k2QcpMK+g6i8g9Ik5G7RA3U4i9Y4mL3iK97hplz2ej1MsoFEMWC48O6X8wKcqICGRl0LUhTb25EMrODWUfhcZ86m4z/xv1piGCKLuDMiHWodNEJEVNLxNEKhD1oQxm2K+vVy2j43ehyiml0Q1/Yo40beApbxaXe6EnF//YAIk9goHXesPGCbmiqW5hUTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqAdEY6Q+cDBooSie93b1bhlBW9h5hR2AmJN9EqnvG8=;
 b=DLI1fpZvvSNQuUBMjpIRi0OxiYYGcY0OqDU0WFY+QuwCiFx+AH+xBndXzwvtYYi4ilhz80vUnPRQO8slufL2ds3tFh8BNhmgtgyuYLx5/xxUm5P28/Bm54y0szbfRMvk7CuOGK7uCb2vCKxGuEGZb+JDpG+SBc+f0HaggC4F740=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 11:18:48 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 11:18:48 +0000
Message-ID: <986da710-26af-43a2-8166-bc81f5997ad4@intel.com>
Date: Wed, 25 Nov 2026 12:17:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
To: Tianyi Gao <tianyi@cloudflare.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Alice Michael
	<alice.michael@intel.com>, "Eric Joyner" <eric.joyner@intel.com>, Jesse
 Brandeburg <jbrandeb@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <bpf@vger.kernel.org>,
	<kernel-team@cloudflare.com>, <tianyi.gao@linux.dev>
References: <20261125095201.98279-1-tianyi@cloudflare.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20261125095201.98279-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA1PR11MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f49c837-2ef7-4c56-7888-08df4ae5e066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|11063799006|56012099006|261026140227099003|10067099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 6DSl1jpA3wLcCRtZIYnN68I3lYo3tyFg/Tg/w1d0sbFJmJPmeQoqYyK/T1FmHfFEohFN537pfQu52mmwUKnDdRWwyOgIYTF7dinq4WUJsf2TCc2zEu/6+DYJxo3JThhFGmQk2C2lxavDYGewpeSPWksvvOIVdi5+Z8U15k4I2enNHFtNXSGB1BISYz43g4+sb15s1yzRFiESJych5sbMGH2DDHF6Nz679kxxrR8NzMt/vHDgbcDbLAzGpgFwhcLSsh0BUJR94wwFZhINvUVwAMlIsH3Ow4YQxf9EWP6Abs2MyiCvVncKpe4MzDH4BLt0dqZZfMY6wL81qsgqPkX7KsOdLzpfk8etUYFNE7HSh6UqQPAJBnEvIbGIDDl9HEjPjA6zg4RfiIs4v42Vi0pnslRkjGN/sktIjHjQ3hjxzRs2/RSec/rwKVI4p4YlpCcY8RNKs/pAPvi3NCO1d+SpuretWbkQ3m5J1Ygdjif0ZlZfqbDSAiWQxljDtMO+OyaZrU2MDRhH3RWRu0E8Lz17fpGtPWtEHyk5rBcYK4SzEcdstGHWLIAFq7PGpcFd/as4Hqt42dB/MhUJTE1rKiWuU7pukScRNrcYURLS330z7MhV+P2UmQBRT+4aZWlMJRf5xWKlL+tEWcr/3ii8zeDeXPPqt0DGUCsoat5T768zFzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(261026140227099003)(10067099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJRcnArcEtITVFrSmFQMzFrUzdlVzh4SUd5aUc1S2VsNDAyQzNERHRLanI3?=
 =?utf-8?B?aHFkQStkaUoweEZUYis1WEl0THEwcEtlV3k0NXJJRzhTWGM4K2FQK25kNHZr?=
 =?utf-8?B?OGswV3lGb1llZFNXdjcvNFMyWi8vTmRxWjZzbGo1L0pUNDVubXFkeGE5WlF5?=
 =?utf-8?B?OWEydGZldGJqMWJTeVJsWWU2M0ZrMW91dUI5RGRxQjFmSUpRcXdXVkorWW51?=
 =?utf-8?B?N2ZCL1NyUjJRa0cvZWY5dkswQldUM2xEZE9vQWxQVS8xMHRFK2ZDaHdIS3Qr?=
 =?utf-8?B?SURiL3ordWl0Q3pkWXNMd3FDK0NvbytlWGxXaGxoTGlzNnJja3pVQ1BDVFhD?=
 =?utf-8?B?ZWcrTHJITmVLbmtRbVlwRkxSWFAvUjJRRExTSGc0Z3NhMGdSZlZNS25kSWdF?=
 =?utf-8?B?NFFQT0hhNnZnNEpGb1o1cCt3dnRiMUlrdDUrYURDMHB2OGlZb2pkNFpsSFg5?=
 =?utf-8?B?TkNodkNhRVY4VkVDSDJ5dFdCZ080cDBWeFM1MmNScnAxV2JKdnN6TUdDR3Zo?=
 =?utf-8?B?R2RrZjc1dFlxdU1kN2dkcXk2Sm1RVG9QbW8wdHgvd1hOQk9MejZQcDMyOVNM?=
 =?utf-8?B?c0tWcjlxVms3MEd0Zk4ydGR1WWRUK3Q4TlBFZFBLZWtjaTN2cTNienVsOWhK?=
 =?utf-8?B?YmxBWE1GZm1oQ0Fjdk1ocGc5dVAyTUd4amxkMnJ3Ri85ajdWdG1sWU5aZzBs?=
 =?utf-8?B?VlR2RGlGS3VJSWhnTkl3K1VvRUdLcS9FSER0T2VIeGtGZFU4S2pnNFZNclVj?=
 =?utf-8?B?bmVDODVZME9UalBwN1VtWDBtK1VrTyt6aWw5WXdadklIakJiemh0bjVFL1A1?=
 =?utf-8?B?MWF1TGVTTDNOaWxFZWxPU3RUWER3Umo1ZFNIR2ZWYU1KcnN5U3locG84dCtM?=
 =?utf-8?B?T2ZjSnRvQlVjTm9Mdmx0ODB6ckdSbFRsL0lXTFRnVGEvSktrS0ZqVU1ZemtM?=
 =?utf-8?B?bnJLTFJmQmRrVkpSZGw2YkxQODAvVHR5T0dnS0dWa1FIRXdpeGorOWdhcVdk?=
 =?utf-8?B?NWpTUmF5bi90RzUwdDR3dzZZWENTUGZWOVV6SUViMCtEdEc3c3BaMWkzQzFI?=
 =?utf-8?B?cEpSTTRqblZPUTdKT2J3c3NZRkE4cHhabUV0WW1SZmlGOG5WYWI0UC9BMzhm?=
 =?utf-8?B?dXBlTWpKZkZzNGFzdDMwYVZNSFJyakF0MCtRMEZuM0M1TjFxMERqRkcwMkor?=
 =?utf-8?B?eHo0V1JFazJOeWJFN2FlbDRTdXJxTjBrZVBIdFduMmo1M1hrYkZPMnpXNWk4?=
 =?utf-8?B?ZDA1RkVvR3V4Qk5icDZkMDd4c1I4QWNNQTl2cU1RV1doaW9HOGdXQ1hGVGdY?=
 =?utf-8?B?eFZ1cWFtMldrRVVKUGxsZWxSZjRLSWJnTHkrWlNDMjdqSEI0WGpyTHBuSTZt?=
 =?utf-8?B?YlBQU3ViZFBlSHNtSWhheThtVEhWWXlJRmw0TUN3c3NNOUt2NGxTK2VUVmNl?=
 =?utf-8?B?ZHI0Z1pkNVcwV0VUZ1l4K1pKa2R2TC9BM3hxdUlyYXFnT1dJN2Jwc3loVm1t?=
 =?utf-8?B?WG1FYUpXekRZeGxGUm4zeDZwR3JqWWh3ZUdIaFg4ZFEwTnBiZ3pwdktoRlAy?=
 =?utf-8?B?OWk4QWNXQkhoVm16cWxyQmNPVk1IME84SVBEUnpHV1VlenhtbWtZV0xHZWdt?=
 =?utf-8?B?QWovM00ycVFPcHBvM01pbjRNZ0pFQlorVU01MzRrS0FNcDhvMWYvTi8wYlEr?=
 =?utf-8?B?a05ac2JNNm1hZ1pEWmJGZFptdkFJUG1yNm5ucmtNUURhQVZ6dmNGNTdWMW9L?=
 =?utf-8?B?ZmIvOHVRUlBRZHh2ZHdrZVBMOU1mL0dGUEtpZUpOY29IK2ticlIrUXBuSGs1?=
 =?utf-8?B?enpvOEE5UFNNd2ZrUG5odmprandmZC9ZaW9qZWpaeGR1TU5pUmQwUnpNa3JW?=
 =?utf-8?B?amxlL1laQmRMVHZYTUQ2dHZpZVNqMCtlNzVSK3Q3SE0rUUpUQ09rbng5ZFor?=
 =?utf-8?B?Rm9oaCtQcDN2eXJmZyt5ck1TN2p4czFyOHA2U1dkL1k3dU9QQS9WdDd0YUVu?=
 =?utf-8?B?UFJaR2NDSm1taysvOTFnMHdIUmZKd2NlUXBBbHFCUjZMZG1oekVrcTR4bnNa?=
 =?utf-8?B?OGV1Z2MzQWI1d01oUEJTS2ZvWHF2QklUVmNLbGprK2hFdittQWlCa2RseUJh?=
 =?utf-8?B?UHZ2UzlVVUNLd2JqS0hmZ0ZUUG4rN1A2STJiTkxEM0xNajR5YXMvYStLOGRx?=
 =?utf-8?B?MTRLWEJHK2UzZkJGNEJWd3R5WHFZNDcwQXE4RDFYQTM2aG5XUXd4dGwzTmxy?=
 =?utf-8?B?RWpkd2tiM042TG9sZW5hOG00dWZmcVEyVVZFQ0ZSMThUYzU5dk92TTgvMmo5?=
 =?utf-8?B?VE11WTRIamcvcUlNZ3ZIZ1RDQm1iTHFKVUdHaExTUzBIa3JadW40cFowZVdP?=
 =?utf-8?Q?J99EtnBXgQvLnIxE=3D?=
X-Exchange-RoutingPolicyChecked: mt6G70by7VdwJzitOSxCkVwsAFjS916PHt0QDGqHc301MxSz5U5DFvWDau4hj9ZRl5ihGvFQz3rRR6BkcCURWofKnv0pMr4J1kZHLy72gqT3cQ3Gv8PMjXwHeeuojXLUfMDZfsKO81HCBHEXINc+2esKnUmnuGgrMFENF9k5MFuOuEweHMSri4hTS3nlG05/axz3V2ybFhDQzLoeQsmk2t1e7AONiE39TGpNKo8cuqUAEbnaj0I8YU4NM25GyGIGejVwoi3juPgV5F42X6CihoGv6hIJGlfg6Ceh/1qvpNL+Xg37uk/nEyMs5vwN/okiL2FnpxtpbEIdqwTCJ+XzLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f49c837-2ef7-4c56-7888-08df4ae5e066
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:18:48.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raK2DsCP7O/QnL2+geMiTZ3v6xgTVvyy4XXoz4LlNBgPaR2KtXvGFMrdyyfDerSD+8lPExmGX2cetL42cMOFvABwIEgNNktg+qZHmPG9C8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-OriginatorOrg: intel.com

From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 25 Nov 2026 09:52:01 +0000

> On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
> that the hardware computes over the received frame. If an XDP program
> changes the packet and returns XDP_PASS, that checksum no longer
> matches. The stack then checks the packet again in software and calls
> netdev_rx_csum_fault().

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
