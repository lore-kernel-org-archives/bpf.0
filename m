Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEDC3B6C15;
	Mon, 27 Jul 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169146; cv=fail; b=V1zUGLHh+WkrVzkDHoAFGO8BOI58/F6CVl+N3vXmqQpA7OJUTpHWR7UAwmO4Eg5Z/t7GPU6clDT84H9jORBVy6aCoH210KFwC5i76Iguhs1RSd4pN+TcWbAWXsainoB6mKnbEvxNBw7+NE4TPWxlUdFRDbKV/OwO6Unp9htVCSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169146; c=relaxed/simple;
	bh=ssaWhxiwApD3cxZMgdi8Yn6F4yzKbESQoEVc8Rt7YW4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qeMWMiR8Yy2TFshufGmz0ZJC5iYi7DGVKcp+1GUAfp+8fzSLAI6qOc304FQsecwPAHdVH1jWQ1r4j18ShbI/E9iWlTtC2bOePyKfhen11lwi569AiVgpKrcmpmfdT5A2rpe0n1TNtc1GOaF93sbIa+w69l0IWb7D96OLXAdtxEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9QVa1Ar; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9QVa1Ar"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785169144; x=1816705144;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ssaWhxiwApD3cxZMgdi8Yn6F4yzKbESQoEVc8Rt7YW4=;
  b=Q9QVa1ArNt7KX11DalkJ7gwLnLtToQDBEKpDjbOz1EEa8k0HupmI58fz
   Hjy2z/SPMXj0z0ZB4NLT7eWjapkzz9XYJWOIDqWHtIZeVV1rSh3izZFSv
   gd7AP284C31/kYQKFmNGFZ7EXf2pQ68QgHfDAJormMOUD0ErA+DXRFXf7
   RUi+PtzCjLFD7rylQGMPK+Ckqm6Ope5TNeAecFf0yHBBX8j7499wHdmID
   0xSPtbXzdWlHRoC3ei2jiimupBfT7FVsnYDnVrZaQJ/gxA8NJ4m6Z0K3C
   GCTMK5P/VPt3kPwWUmEl5lFRtZMucb9QdkLaovGAxPjyz5dr9Y1wf1igX
   A==;
X-CSE-ConnectionGUID: F3emnd20Rs6p6VmJEJ1stg==
X-CSE-MsgGUID: Ism2wE79TKCTVXFiv4A4mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85930395"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="85930395"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 09:19:03 -0700
X-CSE-ConnectionGUID: coQWTLpeSBeZsLAUVh3sLQ==
X-CSE-MsgGUID: LJ0BNnMWS/Kl73p+H0wxtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="297672087"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 09:19:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 09:19:02 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 09:19:02 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 09:19:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vsRctnTeU2VOsk1V2470WvdJnCMjiHmP42h4jz/pBdCCMYhxOIV30D6GIVR0/eH+OmDYTYQ4ez4CHeBdeYK8xTDSg6+79sujwU9tyNX9DRCrIZA3bZXsMyAEurRXN+swuh7Qw5MW5sE3el+8mGNSN8czw6UDN0/2/WNcTiND2jyMwg1C3NDNwhwzf8WaNUKSugKRpE80ZlVuQvbsS9GoWtCzJL9++WBcgZiPN8VraM2K4h26DUfNO2UbfDGWjMoha7IL5wD+8/9nkJ5x6y4tOI+Iy+agfvo7fdAGgrHA4+gnabPajkhI/fhOX4XNnEHiz7Ktf5S+UxzplXOkH46fIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTCc+DZy0DZloMNJt6Y2Zkca4Ftn9FiPVH18UzO3d80=;
 b=Na+20Hnl81T2Equy+/7UIHtDidzncVcX5AZSv5jNoG7ITib2KSCVgUNy9CJa9bxV+HsB0dH2MKT7mlzVKpo7obNPmAKVRDfZYxGbPqHdCsrnB873WMAh8JZ0BGiIUhFWvARuSNSFaho4gU5O/27nWn45JBtd/yHGHkHu6vNNn1VIQeHN1bnoV4Keb06tUkO5N8pG1eB1ocoj64XPAOxq694m1oqxygOlokIWv9+UTTU0KJHUz+MEjPZiHREfVE+EhAt2lecgF40ohzwcAHZgnirPHwM28Z8mI/TSpO+xGGBhtnqTe9wHxG6BA9v2dPnSTfEKLvZRHr5flJJNepBYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 16:18:59 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 16:18:59 +0000
Date: Mon, 27 Jul 2026 18:18:48 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Joshua Washington <joshwash@google.com>
CC: <netdev@vger.kernel.org>, Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, Tim Hostetler
	<thostet@google.com>, Ankit Garg <nktgrg@google.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] gve: use xdp_build_skb methods for
 XDP_PASS case
Message-ID: <ameE6MiPiI3T54OR@soc-5CG4396X81.clients.intel.com>
References: <20260722221634.186886-1-joshwash@google.com>
 <20260722221634.186886-2-joshwash@google.com>
 <CALuQH+UFf2oWTnrSK6mW4+PAqPTyfwJ55Zr8hNF5MTPC9KX2wA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALuQH+UFf2oWTnrSK6mW4+PAqPTyfwJ55Zr8hNF5MTPC9KX2wA@mail.gmail.com>
X-ClientProxiedBy: AS4PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::6) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|MW3PR11MB4620:EE_
X-MS-Office365-Filtering-Correlation-Id: 076ac6b7-6f47-4c53-5344-08deebfac3c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|7416014|10067099003|4143699003|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: l3mI112T+Ga85SGjb79RDQStmg/nkgCjo415DE4ptC8C73wX60Ga2E7tDJARyD1rQPkhkx71IdGokiLZ5T2sEcDWMmGVeKNHEoYpOLf90qwdKvx4gCX38aVj3iPYTLXSmLsVeMPqJ4kG3BzlQLDBGKCgQMCkJwq1PiEvIDPDzOUUucXVzaFqxVpUm7hDMbz73ZrXZKzqMDLcGjawtVwqU5Lg9tOdSWT/eg6Q0chFYsYGMKmaGZHP/7zVSX5S9HscL5pDFbEuLZ3gqD9EoFLxb6kg0yMNipIRUupykaLabVMln3+WSL5eUdh5M35x8lD3XVo5Bn/lyo52Lse+x9DGd2FanItyqzEEIQLglNRMgaw4HkNzR18Tc1es0Me1J1saMZVB7zHFcQqmMexWMubjlVlzRHNB1VLMTT8bABWTICaW3KG2IqW8Ebybd+SbWqKU7rKG9Ln6ICinzSmFaEfKORuzUE/1w59GBAcK6hXogczRDr99DNMvejR4ynOLstk/FLjB3AnTrLxzLkxS/cKbs8Tm3vy8VZ4pXlsW3NLCKYEmHnEx1GjCUaoKoNwSRF5CJjhxnQWjVnBDZBib2LSqF22tlGacOdglU0iw0WSCAU09vJiB9aLpWc8rsk+gaf0RUILh7ZJX+kYXZGeVQeWye4PpTjO1wslveoajP7qWsZI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(7416014)(10067099003)(4143699003)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhtM21yeE1iZDRhZlc2Ry9pbmQ3NmdQRHNjcDJ6b1NzZDNqTlNRUzRtYi9t?=
 =?utf-8?B?RWZSYVFMVi9kd1BDME5vci9mUzllTDQ4SUxIV0E5N0NBdWsrcFdnRVAvM1Jw?=
 =?utf-8?B?MnIvSjVXVHgxZmNFaFpYdlNET3RVWkI2ay9udXQ1bFJ5UGxHaFd6Mm1OWWF3?=
 =?utf-8?B?VnBnZkdkTWVWS2J2NC9CNk56OU8razZEd3lONElSM2tYSis2dWdiRkQwSEw4?=
 =?utf-8?B?Y1JJMy96RUlESy92bkhPR1BtL004MlByS2ZETFlBcEFqT2cva2JyVW5lNU80?=
 =?utf-8?B?WnE2ejlRbnpIQXpxQXJST3JrYWh4bFpLbEdzV1NIU2RpVDJUbUZHUkxlVlJw?=
 =?utf-8?B?SDEwY0ZZU21sOWZwdi9uZFgvVmxPL1R0elpnVEFxRnV6eVNzYzYxODZnWVRq?=
 =?utf-8?B?Wmo5VHBWUW1Ic2tob1BwVG9iTkRDTTRBUVp5U2FMcXJFRGZzRmFoTVZHYzJ2?=
 =?utf-8?B?NmdaL012M1JGUFBTdXNJK21CSHR4d0RLOXpHZzdzZDJPRGpOT2NQdlZiL2ZH?=
 =?utf-8?B?WkszL2F1ek9PeWNWSncwNUJYZjN5VXIzc1NlM0Zucnc0QStXSmtZeXJxcVIv?=
 =?utf-8?B?akQwaWR1STZ0NmtSM01TbW9UMEp1Z2hhRkx1K1dseUUxRXNhU3NnM1FzV044?=
 =?utf-8?B?WFVuclVnMFpCUEZWLzFPbzRNNVRyTzYxdzQwcVdsRVFXT0ZaQjlXZ0FqaXdn?=
 =?utf-8?B?VFZ1d25MbVI3QS94bkYvd29oYXVwdGtMRGtKZ045TkU3Y1d4elRyTDc5VHBl?=
 =?utf-8?B?ZU1iYjRlMU9jRGpFbnp0L0htNGp4RU1QaDFFb2RMdzZXRW9OVy9YQ0FuOXNJ?=
 =?utf-8?B?NlZqdlh0ckZicXpKckdwRTdFS2l2SXFCSVhSU2d6VmtzVERqTFowWCtMOW43?=
 =?utf-8?B?a2J0bTNUdysxUVp5cXFUQmZFZTBiYmhTNnQ0SndyUlJmWUNUc2Y1MDhpeGxj?=
 =?utf-8?B?cFBBakVTWUpQM3NLeUxtbS92b3VXNVB4bDJhL0VweHJzQ09JK3hTcmJSQURL?=
 =?utf-8?B?dEhXSlc4TUQ2TXQwb3pBVDBoSlJ4YjIxeTVzNWViV0V0SEJPV0FuOSttbWUy?=
 =?utf-8?B?dnBlUndaODBEYnZ1R0hvbHp1R2lFcTNsZE1iZkV2VFFLc3V3b1Izb3lua0hC?=
 =?utf-8?B?aUpBZWlpMHMrQllWN05OTmV3d2pCQ0dBbGpaU2J5MXZ1dndYT3E5Q09JcjdP?=
 =?utf-8?B?elZwZjZ4WFhhSlVPaEJtUm40UzBpNVR5NEtFSzRieGRuRnlBYWlha1VIVDY0?=
 =?utf-8?B?eXJYK3NUQUhuTWl2T3JMODBTdHdkTjdXT3ZLazh0ZUR6ZFo2ZWtyMjUzaHdM?=
 =?utf-8?B?U1RKUC82dEZlVzRkYTdyNjBhRHlOKzc5dllxOTExcVhLZUNaV3gxQThzWnI0?=
 =?utf-8?B?NGVlVGMvclhQeWh5WG81VE1qdVd6VDNLcmVZbGpxV04rUjZrUGR1TkJqdTRU?=
 =?utf-8?B?L1ZFaCtXdGJEV3hWbndiQmZLcUZLVEhqUFZEWkVOU2lQUy9Vc1V5elQ3bnlv?=
 =?utf-8?B?eEJDYkhmWnYxR2pXS2ZiK0c0MXNyVC9IdGdvMTBoOGM4SlpUNTl2TnlYeEZr?=
 =?utf-8?B?ZExTUlhyVG1aUmhIVER5VjVPMnAvelFSSGx1eW5nRHpVaWJMRExnd0hQS3ov?=
 =?utf-8?B?bUtWRHpnajNSaVpDZkw3WGxjSjBIaW5RR0sya1ppZnkya2J3cGxldEhpc2ZR?=
 =?utf-8?B?UVIvSzJTS0FaMlIxRzRRM3N0Tm9wTXIwSTkvUCtLMFVmaXp5S29Tb2dwQVQ2?=
 =?utf-8?B?YUhQMjdHdVY1WXNMUFY1Q29GU0RqdUd3cXhMUjcrZElUZHo5ZXVTd1gvSkhG?=
 =?utf-8?B?WGs1MkJlSVBmdHk4dUswZG5kVDRZdEtQOWRQWHBjU3lTYW1iYUY3Y3BYVlVP?=
 =?utf-8?B?UTF0ZVhtRWlzWTRXWXhBTHNoaWZ6bTg1MFRITlFhNDBTU1lXMnNjZVJBUUVG?=
 =?utf-8?B?Q3RxUlFLSmpBMGhySE96SkpPaVZoQXRWd1ZJR3o2cGJYWlc1M0kxa2twLzhH?=
 =?utf-8?B?ZVhPaCs1Z29uQy95aGpkemk4SHZweWVnK0lFdDd6K3Z1bk1LU281L21nMVh2?=
 =?utf-8?B?WkxOUEpJa3RSczdqRElXTmRSN3pHblRwelF4VmdmelU3dnh5VlVyMjY3anoz?=
 =?utf-8?B?aVFVNTFGZnI5RUMyeDZWais4SXBjdWt6L2xFQkhNdWg2a1lkcFN2WjN0a3cv?=
 =?utf-8?B?YTdKSjdkSmtHYWRyYmp3emIwUVhpcGZXYmlpYlNJVXNKOFQzOU04T3hJczkz?=
 =?utf-8?B?MFBzSStmSzg4U0NZWnk3RE1sUXA3ZGcvaWFjKzErTTdydzRubnYvWEFTNnhQ?=
 =?utf-8?B?bFhZRVM3cC8xZDNiRlVwNDRaaGtkNkRKYjJjdWpLYUUrKzRDTHJIQXNpQUpm?=
 =?utf-8?Q?jntBplyy4IGov+vE3gZB96mMtWES+YaSX0XDgu17fLNoG?=
X-MS-Exchange-AntiSpam-MessageData-1: Dfb9jz73zt26qmiMdOVPxZcGf3MtCU3/vBU=
X-Exchange-RoutingPolicyChecked: UteFEK+E2o+oVVQLPR6loLxVYwguUO2dagbYyYHXXVfHux96z+vXGpXSV/HgtIEDMqW5N+i0zYvG8r2MItsaqDmfmcng5BbKDWGWDwenmESWP2WOIDClkclKPR9l+ox0JTOw1utcf8tPm2sEZtBDNAYlldbWtn9Pb+6A805qX5Gy6jQT2LdrdtB39zTPmmcTyZxDHwk+yH18A4JIYXmvEhZXAL2IAA8u5eoSNk/TLpiHw7wZjgX5j4d1SxlZmBwRlyM6JejPUBSPq2TbANpDHfoMNqBsT6Db+oMlqBrmkcDfplPOzlKaA+Fo82u+eMxJ7rCLY9WI6rRUx9nM0OM/sA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 076ac6b7-6f47-4c53-5344-08deebfac3c0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 16:18:59.3839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jksvw1zIWMDECuzsNxmdp8c3V8IsOo50EyK4c57l9DjClxPkkUD5GYYD1S4Yb273T7dtLTBBXgnsc02fAjj7DldK668Bz5o3o+WcqhSJ98c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

On Thu, Jul 23, 2026 at 08:39:47PM -0700, Joshua Washington wrote:
> On Wed, Jul 22, 2026 at 3:16 PM Joshua Washington <joshwash@google.com> wrote:
> >
> > Newer common methods have been introduced to construct SKBs in the
> > event of XDP_PASS because many drivers replicated very similar
> > functionality. Update GVE to use these common methods for copy mode and
> > zero-copy mode.
> >
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Joshua Washington <joshwash@google.com>
> > ---
> > v3:
> >   - Newly introduced. Ensures that XDP metadata is passed onto SKB in
> >     XDP_PASS case.
> > ---
> >  drivers/net/ethernet/google/gve/gve_rx_dqo.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >

[...]

> Sashiko says:
> ---
> [Severity: High]
> Does returning 0 here bypass the copy-on-demand safety check for XDP_PASS
> packets?
> 
> The gve_rx_should_trigger_copy_ondemand() check at the end of gve_rx_dqo()
> appears to be skipped. By bypassing this check, could the networking stack
> hold onto the QPL pages indefinitely?
> 
> This might drive used_buf_states_cnt to num_buf_states, exhausting the buffer
> pool and preventing new RX buffers from being posted to hardware, ultimately
> starving the RX ring.
> ---
> 
> DQ QPL doesn't have XDP support, so QPL pages are not in use.

Yes, given how gve_set_netdev_xdp_features() looks, this does seem like a false 
positive. Patch looks good to me.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
