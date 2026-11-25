Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795613702;
	b=aQ66KV4TbxIMc08+g9mP8wYZSXfkSEEg2T1iyWORBFGlMcupjKdM3+d1t7dxHMaAwsnE
	 ixFmJrvelkr3uuYBSmHP7gRGztbbD297pvt4ZVirC3c+s7rET2MK5eyS4g/O4pge9HGNq
	 8a+GvJufSswCGwriZEG16DN04Z/H/NbEQicQEMaiaS5nGaYU8oF1N3OgQbYySYhSMtV2d
	 X/pb2t21XwZC+ObkdYECyxv/m6HfN85478qWBWYOgncsygnREGOlAWIHC/UsA+CkmGdiC
	 C5w2M4rM9CyRO+xChtYX8Rc8alHxyNroubFziRd1v61OUnbEsSwRM4k7zLOdDmCaLMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613702;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=58xEIijBgH1E9bRDKn+zG3GgoFONDVGidyANTCpaKt0=;
	b=esFgfgnXBaqR/ypI3z4nMlbvrTjv2qyot9oOjekMAtBTO6YC5E2wuax04QuQSJglj0mL
	 GISGJvEx8Xy2BcFpuuDohU+vKG/V6H1JNO2GAb5FbHq7uVeXQUDhRs943vXhRXK8zAbNG
	 ZNxP+r7EwY1kRO7JB5FkSj3i/kAhXaSttWzf3p4uaif7CTvY1F6httsedtVLufNwtJ13o
	 AIYExChf9FArrrs1uHMgmwYR9E/eH491T0/6TaxI5MEWMPUs6v+MzyMLa0Bf3ZD8egnON
	 J5PfeLfpE5O2njC8PhIxQ+q5Xw9RSUebgFPO0HYKD5duaOrJWXXoYJN8xAVuvHNcesA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGg4hpY4;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mVESqJcM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375F606A326;
	Wed, 25 Nov 2026 13:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A375F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fGg4hpY4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mVESqJcM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795613702; x=1827149702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MkQFoAWTNljVPFbBz89FHgR3WJ4I7n/GOTsq1KHKhfs=;
  b=fGg4hpY4hzUdoj6E+Ua59V/QxsTf04h3APWuTZE2hO+R3hARI0gLUX8K
   qVcBbhSwv0nA16mLvY8/wiMY+IG5D/SzwEAitfjiu1ChvMtcNv+TYFAFd
   3ipyDE39zseMml+MLYVAEorMpEnE1FWS3mNPOxw6vw0SFesBWNWgarLwm
   EBCxnTGNLHCj9ipsFMY0i6hF0rf+FVDmXaQDLlniyhB//I370DXqWnkWv
   QcFAPZXFDSCvfrmxEV5HYj3CL7WcKXAbnT/5iXoZzFNILC6nsapeeygnm
   lAFQoEdN7PEN4+YPMFeUQ1zyiqrYfZlJUuOLGWFTNrtp38mzlDOUeRiuF
   A==;
X-CSE-ConnectionGUID: D3VMnQAUQu640TgPcBxCwA==
X-CSE-MsgGUID: PPn/+/UpTP6NM7VQjxPL2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4394627"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4394627"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:35:00 -0800
X-CSE-ConnectionGUID: mEBow+ylT9qBzqfglojTEA==
X-CSE-MsgGUID: fwdqxk/fRzysCIDLgsDTfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11678320"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:35:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 05:34:59 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 05:34:59 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 05:34:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5jll4W1ECF/4t+DH0ieVcwkGnQJ/SWJTAbUqAj+2Ka9wwLOECNlg5rLa5rvfPu0yWJxcQSAG7xX9bj6pjevvyOycPHwq1EXuXNCOqLA/qpCEJeUl312so3gzeX/30cpugTSHmFVUm/c3awCuqpbWNu0CfhbTd5PXr/7WYOi4H9IACMhncQe4lP8tYtaWLsP98awHCA0gjE8LyPQgHAKL5H0UoMQ6KWUIU9FsAVK9Y0zOnGW4+5MjYukxEULY5lqTgFsGK/uTpT58a2mdbi/FqCNuQLfnh+ExJ8b4iIw1HPNsVGexq7xv9fYtlHR8Y+G+Og5dE6cA9iNDLRIM3ee/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58xEIijBgH1E9bRDKn+zG3GgoFONDVGidyANTCpaKt0=;
 b=Td++/AzWjNssHqxPv/dQuMN2S3GVNdFE+3KnDZ5sCp56nIM1NksCRB8UggP/wyX6/nb3coJ71oYJNzaABLfxLSQuT27vbodntKzerS/lIB+QQiI7vlQZkVmNXyCoQt5TRJXYI5OTVfHx9CkEy2BuEcsNf1l31NhBG/bET39dR6Snk1QZ15ZZofWiPe9Mqcheep6/obWLY5YkqV2MR9B6UfluJZ+gAuIRf6AYovkfT+FJfFyFgs9hlkSh9KxfB7o8JzQC3kU3wNlGiyThwuK+3TgZVJUt7dX5ZmBl+bS4rQHt75iRx+KnXMXgO/ORQaMlnq7qr+nxMVfn88ecM+3UBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58xEIijBgH1E9bRDKn+zG3GgoFONDVGidyANTCpaKt0=;
 b=mVESqJcMVI3Qe6408g7uHoFd8szo/e0o1dHl8bmlgRU2xFBZUZsBA7WWNNTyva8M77O3k/VjSczh85fn2RqjjpacQpak5WUxSIuOw4HCuxDSi8xHgsupel1eFWmCILFy0DO7OfEClZB25t1JZtZkRg/yRTb/xtwx0fTFWGDywq4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CO1PR11MB5123.namprd11.prod.outlook.com
 (2603:10b6:303:94::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 13:34:56 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 13:34:56 +0000
Date: Wed, 25 Nov 2026 14:34:44 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kyuwon Cho <kyuwoncho18@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net v2] xsk: keep the charged page count when pinning a
 umem fails
Message-ID: <awbj9KBv3faEzMiZ@boxer>
References: <179556786851.2007362.7849536379916971930@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179556786851.2007362.7849536379916971930@gmail.com>
X-ClientProxiedBy: DBBPR09CA0033.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::36) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CO1PR11MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: 1875d94d-d415-47df-d899-08df4af8e532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|10067099003|56012099006|11063799006|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261021123027099003|261028144727099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LYTLvmeFdO7G5a3CxEFGYh5med4huRASpNXL2c+rtC70a25kPONLGFRy+ZPZycTXoGvE9h4/ZrPDOC/e62LrAgtz4OKJXA/U6J2e4klpWfqouGXEnD8JtL6dtJu9AhNxyl2chOHHynxrMHpKR/zPHrsS5cTDmVJ/IUh1hAe46IvGLTWAJzCTnGzN8MFjSr0yh8NJV33xrpGXbRk8w+3W/SFCWZGChTx6YTjpgId1GUkJvSg3CRcfDIN1k140m+LwnOChAcJuE5E25WQWl/T/gYBicsxz8V7FU30+iBHt1CyeEPRdMibvFCa22iIWpkmvipjsjUj/r72jt3WVhssT+Npc0O5OV1wwuCd7DgULS2c4v4XqssD5pUSU1KXb3/u40fpk00KJ9RWh/5y5CkfIQ9CbcJx5ARmmAhXrwmGoaX8FeraEREF0JMMDhKFmgL00s8YSdJC/6iKs9G7oqldlQSsG3i1UgvbDfDOPoTRMll588w7WI/0XC5LL8fWuvPPCbpmAkSP3AwW0GppSvDMbJ+dcdtIK32bew0MmClK7+btQT2KdIRspHYNoJ6DqOzg5+5uSp1amsWrUDpaov5lD3NFh7uzlMFGx0ThOlfUN2ZzfjMCQJew1bSF/81KDnv3p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261028144727099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R4UgAvXDoSxMsU9hGVXKBNN4Ux2KQ2+sSk3OnBRzHsJhYsgES6ZPElX/ILo5?=
 =?us-ascii?Q?5sRhvB9Ue9Cw6n7uteec7kzEQkMrYeP6EIluu4HpPFMfVsfcXq2JU0QAokCm?=
 =?us-ascii?Q?As6Do9KokoWJOyMubmkH41I8Z2tQlO2y00aWYJQl2VuKJYMylbCHf0oVe7XR?=
 =?us-ascii?Q?93zlBsPXWesuKAwpUx3rTmytqhJHUmBUB5XQyn0KPd1CUM8v90Q4GqFfwBXf?=
 =?us-ascii?Q?ubsWPuc3w4v9bAen/w+xMvT3SxjrH57qu/LFkijfpNsdklmPwUU8hSawKC08?=
 =?us-ascii?Q?J0xDlkBhZaZwgWhSLgy9klyTLech7BReo2cpbmXe+xfv33nJaqCh7DZxnMU1?=
 =?us-ascii?Q?1N18aSGaOiI3e3GFT+SGSUGonr1ELKA4a35Sb04MN5AhgCWWgjrhMEZ69RpJ?=
 =?us-ascii?Q?9fXYz23R8oplMUTKP6dEi2EXCpk54pII9kHufbbGdgfI+WHS4JKaZwIEwtmA?=
 =?us-ascii?Q?b6k+rW9Iyqof8IsFQCpoL/8WmehkfhwrF9iHNZxNE2QUWMa+UzU8PI983ly4?=
 =?us-ascii?Q?Hy15qzeLZP/ATIL53NjbUQosiFSXnchi10cYWsHwmxBCg5WVEoxthGtiShaS?=
 =?us-ascii?Q?cxJ9YHGVGePLGhDmljrtwKmIhlYDOSU/yie5y0Hx1ORQTWabN7nDE9tDVVew?=
 =?us-ascii?Q?x8mS4iQe32J3ANF8B5iYH80SD4z725lE0ogyvz9kFQNk73IWMCpOPfHiC4tA?=
 =?us-ascii?Q?383qwowh7QwojyuDt/ugPcbE4M9QjIaN1KMKDbYFHQz58Vl7ZWcQ7eUshlEN?=
 =?us-ascii?Q?SNJBlO9hzosAriD647UTmAyTPYRp3ZeVnN1hLhEnzs4FVAxxHwuY/azIrtFl?=
 =?us-ascii?Q?sTzX8BYqF9qnP9JcOXGKCMYjzxTz5+4k+MPBQP0kJ2KpQBxsoPLYUasE39P3?=
 =?us-ascii?Q?CxQCE9gAIHufD3vNRLnGfwGCHZOuHXULIGP5xRFMFLhC7bJ4G2GYj+nlRCzv?=
 =?us-ascii?Q?rQ4Zpyc/Ub0+xjrZGYusIh32+NTC1nhgC9HfI16DQ6HQflqawjUgVeocDxIn?=
 =?us-ascii?Q?vBnJOEQ0yPrsPXN9cfbPMEhpLYqYQbwXT1Oq9i47n5EOPS/0JgF1V9X2T5m6?=
 =?us-ascii?Q?WpUlNhKdFIY5Hz9OqvRsHCpW5qQ9w3LkmIuctOLlC08+JbzMZPSUCYGOR1aT?=
 =?us-ascii?Q?0QdX1A8+Q2/PBslRQA9BbuKiB3/GmTspmiBZRB0/mSZh6fmqyoOhSHZOPLSx?=
 =?us-ascii?Q?56P45oOVcj2/thSwZ1wSeuPGFeGBF/hoieCDuhij8YUlMGZGeC5F/5SnbzFl?=
 =?us-ascii?Q?VgBdYeuyD16FNzaPamPcfuZ4qsHrxTdZzZ4KWgePYPKCzC4PWZ7egw/qzpj/?=
 =?us-ascii?Q?j/Cnnl3lRvbWOPQrfyznsyt2XKF08z74FGDirMFUlP2Jr+TGcNtTQK1jreSr?=
 =?us-ascii?Q?kPIZunhc93NEABapLOSUHsca251jiKyL1X6wPeu5+WZUpUiRHl1bNtoEJFeb?=
 =?us-ascii?Q?WtkAaZ0ut2oN4h4t0H+VHzs2RMH/SbnoaPIJmmVfHsUb8u89FfcS0NgOdyTz?=
 =?us-ascii?Q?ma81h3l+WTNPZSl0QJmPRkhoMxyoANoYqatBXBWt201c8dkjvfLpgWO6LlkD?=
 =?us-ascii?Q?GUkGu2N4z/PwxxKtRlS66opNIm1U9wNMyKBhcU+w+XFssaaVPbLfZ6JeVZ+h?=
 =?us-ascii?Q?e52FiOVYrlrFvN2ppkIRduX2oVcVqf2F2JyVXhsF1MLAyLm7JP69NqJQHI6l?=
 =?us-ascii?Q?/KEk87CeRAVfoaHv10ulKk3c0o+Tqz1oxwi//Nez/r4cX8QfGJSQMDEsMsxK?=
 =?us-ascii?Q?sgi3V+yR5lV1QODpRi3eOUnHd9gocVw=3D?=
X-Exchange-RoutingPolicyChecked: eHDu/Nseza7xLiCAP4XIN6RPw84eEYbeQuSelRH2kf8A+nW3+uQ21RVSSaGzE92y4qpJcIn2tMaCwsTr4i+ZhcarKjpFYF6Lw+H1nOHNhZewXbGOzDcOIqeklEAHRRN7hnWSt/Ayo88RNbO5rcbx+EuI6wGNb6KPng9i0mYIw8fGjnJrQRotrpRBbT/bubKKwpLT4gYxWZhdJCG0QYg/k7GjxauECn88VMYLzkd3Os7rxu/Yd0aUbpLAc73bUr8pK42VUwXHc7o8rPqS2MmACAkHUBOlaRILA3npo/ZAT6QdW0ePzbre+KD50woRooAJH7vEFThlXZmNeVrM2ko/WA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1875d94d-d415-47df-d899-08df4af8e532
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:34:56.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yC7xBk1thiQkp9oh85rzu6DOMbZkntg+/kZQ/cwHiTpWrFp8zkC5sxoaKfMZoNMCma46VrdpjCvZSlF1R0xYSaSs67QRB4eLI9g05hx2N7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com

On Wed, Nov 25, 2026 at 11:04:33AM +0900, Kyuwon Cho wrote:
> xdp_umem_reg() charges umem->npgs pages to the user's locked_vm before
> it pins the umem. When pin_user_pages() pins fewer pages than asked,
> xdp_umem_pin_pages() overwrites umem->npgs with the pinned count so that
> xdp_umem_unpin_pages() releases only those, and xdp_umem_unaccount_pages()
> then gives back only that many. The rest of the charge is never returned.
> 
> A short pin happens when the tail of the umem area is not mapped. With
> RLIMIT_MEMLOCK at 16 pages, three registrations of an 8-page area whose
> last 4 pages are unmapped leave the user able to register only 4 pages,
> for as long as the user has a process running.
> 
> Unpin the pinned pages directly and leave umem->npgs as charged.
> 
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260421172951.A7052C2BCB5@smtp.kernel.org/
> Signed-off-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> ---
> v2: target net instead of bpf (Alexei)
> v1: https://lore.kernel.org/all/179552079829.1290967.12345053263834529704@gmail.com/
> 
> The issue was found by an LLM-guided test generator that we are
> developing as a research prototype; Sashiko had flagged the same leak
> in its review of an AUTOSEL backport. A reproducer, which runs as any
> user:
> 
> #define _GNU_SOURCE
> #include <errno.h>
> #include <linux/if_xdp.h>
> #include <sched.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <unistd.h>
> 
> static int reg(char *addr, long len)
> {
> 	struct xdp_umem_reg mr = {
> 		.addr = (unsigned long)addr, .len = len, .chunk_size = 2048,
> 	};
> 	int fd = socket(AF_XDP, SOCK_RAW, 0);
> 	int ret = setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr)) ? -errno : 0;
> 
> 	close(fd);
> 	return ret;
> }
> 
> int main(void)
> {
> 	long pg = sysconf(_SC_PAGESIZE);
> 	struct rlimit rl = { 16 * pg, 16 * pg };
> 	char *a;
> 
> 	/* no CAP_IPC_LOCK, CAP_NET_RAW for AF_XDP */
> 	if (unshare(CLONE_NEWUSER | CLONE_NEWNET) || setrlimit(RLIMIT_MEMLOCK, &rl))
> 		return perror("setup"), 1;
> 
> 	for (int i = 0; i < 3; i++) {
> 		/* 8 pages, the last 4 unmapped: pin_user_pages() pins 4 */
> 		a = mmap(NULL, 8 * pg, PROT_READ | PROT_WRITE,
> 			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> 		munmap(a + 4 * pg, 4 * pg);
> 		printf("short umem: %s\n", strerror(-reg(a, 8 * pg)));
> 		munmap(a, 4 * pg);
> 	}
> 
> 	a = mmap(NULL, 16 * pg, PROT_READ | PROT_WRITE,
> 		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> 	printf("16-page umem: %s\n", strerror(-reg(a, 16 * pg)));
> 	return 0;
> }
> 
> Without the patch, the 16-page registration fails with ENOBUFS: the
> three short ones leave 12 of the 16 pages charged. With it, it
> succeeds.
> 
> The patch was written with LLM assistance; we reviewed and tested it.
> 
>  net/xdp/xdp_umem.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index cd8643360eb3..15ef424e2765 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -109,17 +109,14 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
>  
>  	if (npgs != umem->npgs) {
>  		if (npgs >= 0) {
> -			umem->npgs = npgs;
> -			err = -ENOMEM;
> -			goto out_pin;
> +			unpin_user_pages(umem->pgs, npgs);
> +			npgs = -ENOMEM;
>  		}
>  		err = npgs;
>  		goto out_pgs;
>  	}
>  	return 0;
>  
> -out_pin:
> -	xdp_umem_unpin_pages(umem);
>  out_pgs:
>  	kvfree(umem->pgs);
>  	umem->pgs = NULL;

do we still need @err? Would that be easier to read?

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -95,7 +95,6 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 {
 	unsigned int gup_flags = FOLL_WRITE;
 	long npgs;
-	int err;
 
 	umem->pgs = kvzalloc_objs(*umem->pgs, umem->npgs,
 				  GFP_KERNEL | __GFP_NOWARN);
@@ -107,23 +106,14 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 			      gup_flags | FOLL_LONGTERM, &umem->pgs[0]);
 	mmap_read_unlock(current->mm);
 
-	if (npgs != umem->npgs) {
-		if (npgs >= 0) {
-			umem->npgs = npgs;
-			err = -ENOMEM;
-			goto out_pin;
-		}
-		err = npgs;
-		goto out_pgs;
-	}
-	return 0;
+	if (npgs == umem->npgs)
+		return 0;
 
-out_pin:
-	xdp_umem_unpin_pages(umem);
-out_pgs:
+	if (npgs > 0)
+		unpin_user_pages(umem->pgs, npgs);
+
 	kvfree(umem->pgs);
 	umem->pgs = NULL;
-	return err;
+
+	return npgs < 0 ? npgs : -ENOMEM;
 }

> -- 
> 2.43.0
> 
> 
