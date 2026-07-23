Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AA047CA9F;
	Thu, 23 Jul 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784819876; cv=fail; b=N5gQjpFj9C4OTvf3m94tQZrtjJg2w9Ke5QkjvkhQMLNPZHEnch9wsb9nIVgigowHybVJyGd/1XFrY5QJuwGcj9VbHwZ869x18cp1EBJwSg2/4r9U1riJMPYbJTPbfGIJLi/W74u5AYAT2JTMn2Ayif5MukF0mc0Luu1QVV6/wYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784819876; c=relaxed/simple;
	bh=1KARSC4slizjAj76YD4kn+7tjIAmi5iZC3sDLPBCe9E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OsVtG5DryJbuoJBy2qcI6sddbPcWjTUj14RuFhH+qRPE2e0zqI0XnY85iWjmKHLvk9D293NNDIyqSLx8cfqpA898M4wNee5VydizKpwmshrSCQ4zPf4N08j8VUoZpKN4P906zgwPaegGt9OWIeMntj0OzLC2n8y6j7+MTAWWTZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAIxnVX9; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAIxnVX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784819874; x=1816355874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1KARSC4slizjAj76YD4kn+7tjIAmi5iZC3sDLPBCe9E=;
  b=PAIxnVX9UEqmBSxonARli/21i8UbzqkpeIB3RqqOZoJvKLTUuI4y3Fg4
   m9Pzt7dquoOCuw/KfqnyVwEaitVraGQ84WBiszQjBHisHn6E9gbanArGV
   nvj0h38lJY6e0uATmwjV1wqoCZHfzphbQAwBCksZm/aVPjauuKWc/9Ut1
   YpzSB2m3RiPq2MRa7yk9IzbJN08mq6BZWZImuyd+jbYZk4lQFKYKQF6Pi
   gnaLKFpacem7pzgMgPyKebYgN7RT541XMWZ9guXZdTNQjYz8ws3ZyTEte
   lvk7Sl/VAA0NZyZPm++jd3HheyGTBiynjpnsZ5xmjTw9mjzhBskcBKC9R
   Q==;
X-CSE-ConnectionGUID: eEUNltIHS3W1/fM5KX3F6w==
X-CSE-MsgGUID: deWrLDe2R3OzxtfkaJ5uXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85670653"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85670653"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 08:17:52 -0700
X-CSE-ConnectionGUID: 8Td0ytKnRrG8jdz/gAHs/w==
X-CSE-MsgGUID: zE2Lt6toQr6WJI9z149QYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="252128069"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 08:17:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 08:17:51 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 08:17:51 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.71) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 08:17:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQwUjiVT0OoEikcaMJz5gJ/h6Sts2t9sgZ2pAuC1LNUU748vBdGtk8M3HLOJ9QNmWjHUg5ywgda5fk+OXqJ7y18Ik1JhI9pU+h3MAOo0lQ0NSypsjyQxkZblRqExkmNjl4SR8ZxKV5XHmZM2guKSmsDZPTBiccYqpkiL5nGjlMUtSIfRStSLolGYHRbOQTiSNOBudesUGR9AA0gELZoOzfD2/OQ1R6Wg4x/CzKjxz8HOECBNc8Fdt6zm0HN5g+53unJBmLkT8NwB8blE0vt8GDjz92q8VSvMpi/jxDTUbBNjuYla6558uJOs/DYX5nLPJwyZImQjKhxtSPNHdkl3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqo8h53YyMlQfGXUq+yPReFchUKmhu7B4Jy+lWZ/oo0=;
 b=sKXLVHC0EzxEBBPU9qAuoWKcshkXIJBipJZx4MttK/NgoQC73wdCv/bA7xgpGnM9E092vtI0zNrREhRielVpvt/PzNE332sFBVWWSNG7POQaJak2EN0fT6Uo/yS5QSxS8XAGyYS8B4FM8JnWLUa35+NVwdUCtckgjMyREdqjYsGBFfO/I3Jq8Jne0HxJr2l0GEkuqf++0U39s8qJ0yfauhbP1rhSfOO0ZAGBLi/osNfBDQVyeTVZmuW+xRnK/dndOnniJqCwoF9vC/RyoTbxmCnTrfeoAlzsg/PKuJTzIjDNReQohbqZI8VYr8XHYkzlJE8lWetM3lnQLOmpc+BA1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 15:17:47 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 15:17:46 +0000
Message-ID: <c3de7856-d9d1-4bb8-ba4a-a7f967c767ae@intel.com>
Date: Thu, 23 Jul 2026 17:16:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::14) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|SA0PR11MB4717:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e4232f8-1faa-4bab-609e-08dee8cd8d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JRkG2LvDPe9Za5yBZlBDllw3OvTa2JNZWs9Kuv4o5PI5+7FQQDz011H1li0NpJSYOMnqA+LZpVyQ0DFQ1U/1MYMR/4lx1xTSswH1PZBpgMF1u19rfpaHM+4xQK+LlVnmo4dN0xe8w0BkrSoV9B+Xh0BJrGbOcp3o3J+YkmPo+12BgGsBgW2jqJX0ZG8QWX/kVlCgiyW29RHLN04ZZMM80/k9i6krwEVf4cHaG6ic3RnaVO78lsEeIG4h/1cjx7usS4sUYycIR0CwcR3YrlIsM0yVTxzVYYLuVIeGPaVi7JXJllmv7vlIekqLRL8FbjQ9OYy6xDknZBMPryo6kq2HBCLBDVc6rgrXcOMBpMnouglXNVH98S7telTX2ehQw7H4qUaC3bYhZkEERQUlEYg0+RTZ0+1IFFTVqFtTyz9oJpSFZCZUQj+pmig/aSxMPSze2tZX/9Uyw75Fj1kmDiUkABik5vhBoGedmCEcUO8rGXuDMu6vOPIDV3eNFT0tE/ApnzH+0DjdnkNM18V4L3Se3knfoBvOZmAgAzeNyCiGMpE8g/Y939CMlLgjK0xacH1d5C2vFNOOny4pqfnqrnoClw7FRs8j1qlK5txSeN6TEvmcyU/dV/8kCxP2/cQxOmPXx/xM+9Nl9PiHGZSa8G2PUY537PzaW8rC/oCIag3jcTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpOSGJEVWg2Uzd2d3diMHdzT0E1aHBjdmo4cS9scEFWMHQ0WW1uaXdSVEJU?=
 =?utf-8?B?OTdOYWVvMEZDbHBxT3NobFNtaW94WW5ScXBIUUo4b2pscW1zakx5SDFGRUpJ?=
 =?utf-8?B?bHk3V25IY0FHcmFKTmdyM3VlWnE3V3haVlhVVktDMS9YTmZLYVJJR2U0QkxN?=
 =?utf-8?B?OWlzc0ZZNVVYajlBa0pmclRqUmE5VFRWZ3NhVXIwWS9wNlVaUHF0cSszd0RX?=
 =?utf-8?B?N1d3ZTNqWlhWVGprMVlITHVCVXlEeDZ1Q0xYMy9yZE10NHp1ZlhGcDg1U2Zv?=
 =?utf-8?B?a0tWNFZIcUhVMXE0WFVQcFRrTkwxek9MeXJma0dhaVlQL25wdkFIS0M4OWh2?=
 =?utf-8?B?MUgzV0ExRm84Mkx1U1k4cTFLaUl4aWFwNXVJVW9SZTUvYVEzMHVvQ29KckpU?=
 =?utf-8?B?WE5aTWpmZ1FMTFB0TVIxZUppakcvOEQ0eWJ0YWtwank4U1RuTU5HamZCL1cx?=
 =?utf-8?B?QUloRW5YdllITnYzM1ZGNnFYcUI1dU9haWF3WXF5QmxBdXZPWFNKSVg0Mjho?=
 =?utf-8?B?TExyOHRzSzBTeWp5d1VSNlV6ZjNYRW9GNksyY3BXbmFIanI2ZFZQRzNlWFNE?=
 =?utf-8?B?QmkvWkJ5elhHb0pscTVnVDBvWjJXRjFNanBQZ2FKQTFJem16M1RVRFVaQkN5?=
 =?utf-8?B?cmN5aWorWlJSZm81dURFRzVrWWV3VzZYUElFRUZqcnY0QnN6SU40UUEyeFJ3?=
 =?utf-8?B?SDNrRlEzTlZzTEVDWmtlMEF5TjA2a0ZIa0p2ZHB3dklqZGRGR2hjSjMvdTNx?=
 =?utf-8?B?OUUxZFNVTUsrdDR3ZGN1aUFKTXIwN0ZvUC9nWHIvQk43a2oraGd6WjMwY2hZ?=
 =?utf-8?B?TDVGdEdqT0QrZ0NWMHp2amtCVlVzNFhRTUJoMWVSZnBCa3BTNVRrWlp5TUdT?=
 =?utf-8?B?YS9FMHVBVWQ2YlZUU243UFNNdXlQdE5rSHNxUHAxWlpnTnpzV0h0UWRpSmw3?=
 =?utf-8?B?WWxnZ0FKUUtBUVk1QXkwWS9MZWJKb2ZFaVFReDJWZ0JCVjZ0ZGNMMGVOREp6?=
 =?utf-8?B?MldFV0RpUXRhQ1J3VllJWS9xWHdPOVlSWDRmMGRsQUpaaDJiVDhteS9mMk0x?=
 =?utf-8?B?RmJsZHdTREQvejA3Q0N2M3NrYnBTOHI0a0pFS3o0S2FRNWdERGE0b0hPWXl4?=
 =?utf-8?B?SGpySStzMHZ5elY0eGhXTi9WWkJWY0U2QmYwM0ZTWFZ6cHNheHAwZmJ3UmlP?=
 =?utf-8?B?WUtWaHNTcENIaklpZmJ0SlVjS0hrbmJvQ3B6VTVoOTJyMXF5TndUT3pXcStH?=
 =?utf-8?B?ZEwrT3BaOXNYYlI5NG1OSWRiQ3o3Sm9Md3MvZEhLb3RyeVNGTk1XbTZuUys4?=
 =?utf-8?B?RzZ6THlCaFlOZnVzeTYxVW1sQXZwS2RENDJVM3Z3YXlkdWxYNHNEZEQ5WTNS?=
 =?utf-8?B?a2FpYVhGVUpDSGExVjNIdG5ibUJxbGFjaGhuNG9SdmFJWFRhSmw2U2ltRTRT?=
 =?utf-8?B?cWoyS2tZdDZ0emt0cWl3QUhYUDhNdnVYanJidWpzWHl5a3NDZkx5OHZtZEUy?=
 =?utf-8?B?ZEhOdkN1dlJCNExtMlJuTzdQV0w4VkthL21zaVVIVVNoS0EwVHJsZ0RoRUJC?=
 =?utf-8?B?OFFyREFTczdYOW9KUS8wQUpjWmtRb1MydGRZKzY2ZEk1WXhMNCsvYzRRS2E3?=
 =?utf-8?B?NExFZmxDd3NqK3E5eDVlai9tYVc4QXl5a3Q0Y1lkRVFwbFZaVmtxWlN1aEly?=
 =?utf-8?B?RkNlUzdaQnNtbCsxaVJmZnNycWdDMGoxVVZCUnNTOGV5a2dZTkdLcktJQnhk?=
 =?utf-8?B?cDY4VXJhL3B5bURaZGVGMVozZFNBY21ZOGJiRUhPNEZvWHpqcVRLdnNtYzZU?=
 =?utf-8?B?dCtLUjRYcHBhK3RuVnlMRWJXN1l4bFRwQzJGUXZQdEZBQkhJeHZpeU81bW1t?=
 =?utf-8?B?M0RBS01vMjJvWEE2MnRMd1l3bWtSUk5NdGZ2YWUrR2xzRitZR1ZraE1sMWN6?=
 =?utf-8?B?bm1iZXp2WEhySi9XMTZyYTkyL25OVnZhTS9zRUNPaVN5OFdtbndJR3g3TW1u?=
 =?utf-8?B?bzJrampneEN6a1ZqTno2bHNmdmtlSGgwaGxSbmRPb25BeXVDNkhTb2E3WmU3?=
 =?utf-8?B?WW1Vd1Y4blpnaTR0U2JIUGtpVkFyNmhtekgzSnJrMVdZbGM2WkFVYkRVejFk?=
 =?utf-8?B?Qm9NRW1QMEpaUXlxWmdjblljYjloMlBEaExvYVg4WnV6SGJHMWZDd1dOYTN0?=
 =?utf-8?B?dDlSOE12MHc1bkhaMmNEaE1tZlpXdStxYk0zWGxwdFlpbWpzYVd3cTh0Zy9C?=
 =?utf-8?B?dEV4QTJCUE1Ud0ZrQnhzNk5Tb256UE5wdTE5R2xKbWZuSzZHMGVFNm03MThh?=
 =?utf-8?B?TzRpdkFFcEJ0MXMzblJhS0d0Vk0zQURTSXhkY2oySGtGMDc0Nk9YSDc1OXhp?=
 =?utf-8?Q?Pa8L0Z2XD4rRZz3A=3D?=
X-Exchange-RoutingPolicyChecked: Cim+/GRV7JisVJQIWsyHPSAd93yunYULjWwLxbAyK+WeZN4gGaglMN1rPsOkFujahTAZmdfgjgKWTPfIa1Ctd0DhovK/Z7cP4MTJtFgkArH8xkKGN7Zt9vSr7a007V+3kNAPzPVw7wqe/+/aZpxZL0QpXxyjbsQNK500Az9LSKPYRvpBhrYKFBKwuxJL8lB6Ib0gp0m6C95BSc9CdOQrBXOPuCD5DUYAJizAAEvtw5SwqpfaMf/aFylHLrgtXoqWpso7UdF26ZO6dBqmvXN4xdwh9RUvjtI6CF/c/UYRtgsdknOGIrfDeqDUizfXOhWPDeUyyBxu0q07MZXvoMjdsQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e4232f8-1faa-4bab-609e-08dee8cd8d12
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 15:17:46.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 80J9z3sW2JXIoIaxBMJ0VmWTaOTAkIR/E/z6tFoLzhGrbII9xkaZh1wq6HbKfj5ZeUpRQ/2ihnCPPrTB+85aquv6MMcb4+MY7WT6sMZItrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com

From: Stanislav Fomichev <sdf.kernel@gmail.com>
Date: Wed, 22 Jul 2026 10:55:17 -0700

> On 07/22, Cen Zhang (Microsoft) wrote:
>> There is no metadata length check before accessing struct xsk_tx_metadata
>> fields in both xdp_umem_reg() (registration) and
>> xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
>> tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
>> out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
>> declared metadata region.

[...]

> @@ -773,7 +773,7 @@ struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
>  	addr = __xp_raw_get_addr(pool, addr);
>  
>  	ret.dma = __xp_raw_get_dma(pool, addr);
> -	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
> +	xsk_buff_read_metadata(pool, addr, &ret.meta);

That effectively disables some micro-optimizations that were the reason
I created this helper -- __xp_raw_get_data() is inline, while
xsk_buff_read_metadata() uses the external version, probably some other
stuff (note the underscored __xsk_buff_get_metadata()) =\ This function
expanded to have no external calls on clang -O2, with this patch I'm not
sure it would.

>  
>  	return ret;
>  }
Thanks,
Olek
