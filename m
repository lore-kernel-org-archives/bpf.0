Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794483457;
	b=L66uX3GV9mgsvS75dcWvoBPViGx6bJNRKuDWH+VmRckPQydQ4ODRhx6t0OXHKdyWAIYP
	 Ho0UbfeN/vlQJnNu8Iyi65upZigotYTzRqnKx1o1YWaea24BqoTG4R6BdYk/vH0gWm10v
	 4+M49nNO1WceYfRw4bC6rSyMngUGletf9kzNvOG2TLbrxn4hr1ld/A03++vvCFWxgTJgA
	 Y+/MbdoLbhgGPskdFuRXg4YJu9YR8kQCS+Xhrlsv8MCyT4NIgISfo+IOlASqgzi9lCS2c
	 ftctJUAI65cvCQw+8qEoKRsEuT18J78C+V5qrFtHuSk+S9CVhnNgNgqn7fJie6z1bUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483457;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
	bh=k4ed6QMvFNOnPu/vkqmqNHvvfKBKsFOoVFPymLVlqls=;
	b=0oqgJAHzodN2ENKvqhMPaYPrEPC9aYoANGFLiZDedOCJ2tA1tBa4yf2ZavfJvJm5fvwD
	 4IGGXFMYZ6FdzuOz7npUOIG465iong1Za9qd9kqoqwQ0/KbhK3382MQFSLqnireGdZZNk
	 JN40CwcAYrfl/Okun5evc1xOuxccF6xAGphKG1VgiP7Hcs7Ew3JWzvZqFrr65V328FJ0w
	 lacck8fGLrcEHLWZ95m7XY1Om6zk0TVIeLyDvoZq2kZEbpnRTLD9tRGWvOuydJflpUIAW
	 4dK260egYxa+T6a0J8c2RUHlJ45rT6D5ZxBPdEC9kjRjpTpnE+DbErNIklyFcHXvulQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=azsJd1WP;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ke4eSZ47;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A49606A321;
	Thu, 12 Nov 2026 11:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02A49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=azsJd1WP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ke4eSZ47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794483456; x=1826019456;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vH7lBVr5NdRTZRSPwu9tZEtPQx7Rl3GrMKfrNGe9Jjw=;
  b=azsJd1WPUF/1WHp7wHMHj77Tv6s4YlTN+sfNLfp7eT5OCmUFaBSUA8yF
   2F3l6gd++YfrgzwGA3uPZ9elZ2oIG6AA+CdYwYAZJhrjMkQu9FCT6Dsf7
   VqSfwGRp9VlYhgtqQfPmtMxiUwcC7bj/3uTtaOQburPWpsT/mtuR1QgV8
   OSHntPTuZ8C0EH6HHm4J/ebi7m/+dMXJnX30aQJUar0LAnUpcEvOye7NU
   YYbamyX2YcYssA9LOB+0WwpXfNdeK3PPFRuYns+eoJqImcFF+SEvXOnX7
   KJgWwTmMCyIREM4MRfZkpByuDAyn+yjOoWuHz1H/hjFJ8FH89cWPvYQUw
   g==;
X-CSE-ConnectionGUID: G16pjzkrSBWB4SVq6XjJmw==
X-CSE-MsgGUID: dTtHF7sBTeisUERaj9EGRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3166829"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3166829"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 03:37:35 -0800
X-CSE-ConnectionGUID: fOc+GPxnSIuvoV6ZXvrS2Q==
X-CSE-MsgGUID: q+ooiWN0ShOc3mAQ2ppU3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8805921"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 03:37:34 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 03:37:33 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 03:37:33 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 03:37:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYX7eqiNQWEkh5UkRUZU1b8M7YocnPtD61j7S5YNAQUvm64vx7LAO12K7tOWShjtOKAJELv7yku6Jjq1r0cPiOiIE50VDPm6U3HaFAw1xyCuw9jWYFcFdK2Ui4IRyFnFZfsIX02ts+M+7CyY3dANH2TxRWwxLR6NiwQtmxRo5UibmWupZrMCPpCgmxNRMCMw0Ndcd+SnF/qRFkqouWIohFZP8i4stCx9zkc+IY4lqiavm/qDyjMVL8F2xQW1ek8q0LbgLMRCexMAYCPNNDn/C9vIsVavfCaa4R0MeIcRjl1/Otgn8DbxuTWi1CELGHJHbaq6/xlH8BgY1KUGwPOpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8sbA7r/XuBPSFMjeR3Yu45+8yuUK+BueDp/dvrBjUc=;
 b=j7fR39bvhBgh2dj61pRcgpL7YPQnFGbpiAvJBIlxeZTLm4jbWASc+wdH6C7KeAOIgoo/CBTdos2TaU4JCumqvBsMSg+w41hRSzzckSQliM++tY3QkJJUcCQmbZsovFBSrzo8sYVlebVaUYs51nQm9Ar2uINY0vS3GLKRc06a7fVGC1xgbxJeK5DfCXGCgwmSiXe9NXZaJ8IkVna5Sak/92vYPoU57qgDgJAEV+JpHT0DK4gL6qaMFYimWMXJ8H/cNfJqMYgq7EoMfx5CRmFJxmTNtYQ5+RO6zePrNGVrU2Z/lGu8fEKbNN3KuN8Y+S0oqmqIcHPeSlQ4TcpyELgWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8sbA7r/XuBPSFMjeR3Yu45+8yuUK+BueDp/dvrBjUc=;
 b=ke4eSZ47DBeAzuC9LBN8NgeSENwjidjT//zby2erVSbiEqN+izvDm+4dRxQGPGMvS0tUolwjU71CWHuGHqLsnSwUPfooBpjxo/Jf9MZQdwnefhJr57BXM3lQDQeYr2D3AR/msGCLxHjX9c+J3m/wsdH0opP34HWD7tZyw9tDHoM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CH3PR11MB8707.namprd11.prod.outlook.com
 (2603:10b6:610:1bf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 11:37:23 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:37:23 +0000
Date: Thu, 12 Nov 2026 12:37:09 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kernel-team@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Pavel Begunkov
	<asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii Nakryiko
	<andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<io-uring@vger.kernel.org>, Mina Almasry <almasrymina@google.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
	<bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Wei
	<dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stuart Clark
	<stuclar@meta.com>
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
Message-ID: <avWk5as19fvZoEJA@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110102039.1002605-12-bjorn@kernel.org>
X-ClientProxiedBy: BE1P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::22) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CH3PR11MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ff3b9e-c5dc-46ee-4c26-08df40b151dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|366016|376014|18002099003|22082099003|6133799003|10067099003|11063799006|5023799004|261021121427099003|56012099006|261021123027099003|261009223027099003|261021135927099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|4143699003|261022105027099003|260925021911599003|261026121527099003|260925021311599003|260925022911599003;
X-Microsoft-Antispam-Message-Info: a8IrIIfcTuP0xW/s7+Lrh6BiIPmagedPuaREGwTL2qtf+AFiu3iirKOCT8xK5+XlC+1TPzFTtz9J4N29ggb0LNqD9c8onjF9Xt1fkX9CwNqdcCHHQ0+wZO2g+yBOW6AIEjRVJPXjjLiFMD65Osk2zn2bZzUki94oAS4ZwwknPXVnkeIk3HWcLObdM6krvdYVEGW1drDnb4sC/a5QCJBeO8EQc/17Y2sKMmI1xtnJoTZT7VKLmSkgU+Y1+SoitddyuzFWZenZhcDJM2iON1cS1pMTE+WKTF/DtO1qNodElnVbxZFc6d+KwRvw6HHj6i//9eDJn4c1eMU81ITh03khzhVe7kaIerX0dGIwiu3iwzNgE2E5rgETYy+Z5cmfI8Fs3D5Oz3Gq3GKhqkS+N6ILHT9tVU8nH5fXZSwKR4GcgbZzZ5ZXY1UJJAFaReBCutUZQ0T8T588m75wHAutmRoZPoo1a+XwFgWNLVcpRn3dd819PI+Ye/tbz5dygBHkDiXZW5336tOSubBybtn8SK1INa3ARjXxB+3pqADohytCYqpjNNkkjiDTyjxOLh/2K9VQmoY2Omm/tT21+8qj4r3yJ2Fwe/rb50Xv/bQjEgl8kGKo+V8eplI610tXnzBu/vFkVUPp8gO+TqAeIiqXBKkBe97DOecj7ssB8WbpcQ8gifU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(5023799004)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(261021135927099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(4143699003)(261022105027099003)(260925021911599003)(261026121527099003)(260925021311599003)(260925022911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KfUp/tWRBcjAVAxBRL2hV9c2te2BtmfkmmYpnxTRQYWkl4AObCoFmlBs+A?=
 =?iso-8859-1?Q?F6PsAu7S4eBdL+aT9uWf8C1jttpl/03z7H4vZXt0ODtynwF0vTGqSrqIPx?=
 =?iso-8859-1?Q?/lBxJvPedtZ7Yq9u8+P5fe4I37Sv7VaRXbpvsB/4Qev2yjuKLAueqYdCBF?=
 =?iso-8859-1?Q?JWTBCKDlBGMcPVX10pNhTCUxTLKSJwCkuGklnI2ZjDQH2Z2Hw8f1nngBr6?=
 =?iso-8859-1?Q?CjvzROiPp32102zmgCq5o+70gjarEXQWH97NfekfuO2ofNzeVYSGiVjvJb?=
 =?iso-8859-1?Q?ARhYTspqEUvkWk3/rF5Logd2g9xLC47efRHwoTu/RiQGTijRUmfdT4wzTm?=
 =?iso-8859-1?Q?LyqxlGqvpxbO3R9TvkDqjZFq/NAMt9+cuopbEp5uU9SlVLvm8LvojOMSvv?=
 =?iso-8859-1?Q?f9meWkUScRFpjbEy319thpCi1I/MQwePpJpY1E9yXCsxBgz+RNqic9LUcq?=
 =?iso-8859-1?Q?OIRkM5kv3tN65L92JHYdLI+ax3zm56ULYX6zLoxCKF9Qqne94BaWjWoWbP?=
 =?iso-8859-1?Q?dlyzS7Z+9nmCEgsUJALDhEvSlJSCsNgTOpBB3WcpYAjp231iKhmXm36drI?=
 =?iso-8859-1?Q?NuE2DqXd3+IU8Y8y/QgWPjgM8UWNSYW7/f6UE2/aXOahdN3lpVbgJZsjVZ?=
 =?iso-8859-1?Q?cuMG11YAsrTKS50VjIntJ4PqzpQ8yw90HPQXD2v8HYh5YOpkPsIKBBBXv4?=
 =?iso-8859-1?Q?DhupwucriEXgcD5yj7yWNI2qqtQKjg5dem4eWXtfZimTuu9F56Y7e7Jryg?=
 =?iso-8859-1?Q?7tUGNcVSFEt2FQIom4EhKGOYorillRsPTqtgmoyNkt6uKMVDjni4EIvgc1?=
 =?iso-8859-1?Q?4u0gMdHCxei9rOYekDN9/A9x9GwcYevXPMlWQyaJdwMvKZ1XQY54TLgIbe?=
 =?iso-8859-1?Q?ch9vb0OyP6nFbQJrPC6/TCXedoyL4oblk4tJlxagFKOaRJi33VKRZda/q2?=
 =?iso-8859-1?Q?2svj8YKU6IAG3+jY4eh1eSH9FjDlF2KnA3oftcSlfAPO5dxGCScu/OAq+z?=
 =?iso-8859-1?Q?lisp3nd5uTN4ttaS3igstq8PvHCGYrl+1B01YXuYcARcf2HAH7P/NqPc3t?=
 =?iso-8859-1?Q?1MDmiMo9VwaRWPQAaJft5s940lXDzEY/5v6d1MYQQhKa2HYReYvvFTTGOI?=
 =?iso-8859-1?Q?MyOj0LftujTHbzcLgjxDCTozroM57H9aG3g76Z9xYimr47FgXgULzq478Z?=
 =?iso-8859-1?Q?4cMpNjtRHmToYzivO3mnW2riQsDpIFL92FwvMCx18JF7RCUc0lk6Gyc8em?=
 =?iso-8859-1?Q?5xPE+6IRSNj+37NGkSi2wkwPDTrcRo1ZK4txFEKMd313wd0kbAAFvHKelq?=
 =?iso-8859-1?Q?zRklTTnI1nT8U/1ZuwEQ8RGEbC/ZncNoEYHgKGDIRGuXdVX47uCE/kZl5y?=
 =?iso-8859-1?Q?Tu1uVL9nGdewjjE5TT7S1HYn6/uKhCN6Eau2nYxCIlbAkwHyMEvdkU07Li?=
 =?iso-8859-1?Q?ZqiGnF1zgIfb+oMxkqoZ77ymsw+p4pBI6eADGPJGVaxDnqdtFCRT/Wi5OL?=
 =?iso-8859-1?Q?AqQjaH6oAZ1Ifv33JdHzTt4jKrcQklRBr9nzbPGRIL3qWA3ZfJ9OqWBn8n?=
 =?iso-8859-1?Q?bd9gQtESZQ2Ucb8axOslXYPSgaxwTs8JAJiheQdkowR+rmSDlu98Ymu2XJ?=
 =?iso-8859-1?Q?GQd2iLGOnwOw5+Rw42PXYOfZ7EiX4r3I1oiKfGiSS5c/q3pk30uCq5fuBZ?=
 =?iso-8859-1?Q?RN8gGuX2ClLxB1BAlJK01bcvlRXanSN2JeWNs3Q1qLbJ3YLsuYfQ1Jzcqj?=
 =?iso-8859-1?Q?0+Xs++rnzKbccgcFc8hmizArNhYjNcW+YeW09CQ1shFmAptOIoDZ80D+4O?=
 =?iso-8859-1?Q?JBoL+p6q2XFqxaLhy4EzUNbmAKAslxI=3D?=
X-Exchange-RoutingPolicyChecked: N0xKK1wsvCfgMj/wzcWLwRJgPGgoyjdailY+AEfNpcKjbgHqcvQcfEw4qdtBMToJZlrrNohVuxsRMMNVxlnMAt261C6/0YNqeHqmgquuU7WKMOywkO26RO2v2oXlwvrDzJlshUNe4sKePx5U220do9t89og0KqD1Hi8m5Sm2f6zy0oDtqJrJMN8zvXe9C3oohuY+mVX7zbUkheGHLsj202X7LpV93DJscVGuUS+QbTIv/+JISRCdC0smBfPclbq9Mylf+3T7hajCYlZ1CQvjAn+Fx4zfD4KLptIgzSmIp6oJiFMSPLveEUmSwVOTjjerH8DAdWkTGp251Cbp6WDpbA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff3b9e-c5dc-46ee-4c26-08df40b151dc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:37:23.7597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5n66HdJF4qsd+cSQ26ZbLU5S46kraMv9feXWM2fO7diRx1jM2KeYOo0LkfYBzASvpgGbUKwOjCYIZDo2xnGpUodNmMyvRSn6dGIAbyJoGhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 11:20:32AM +0100, Björn Töpel wrote:
> Header and payload rings share one provider page pool, so refills even
> them out, and a short pool does not starve one of them. Payload
> buffers start at chunk offset 0, and the UMEM headroom rules require
> headroom only in the first buffer. A chunk is one 4 KiB device page,
> also with larger kernel pages, so rings fed by the provider post one
> descriptor per chunk.
> 
> Socket TX shares the XDP TX ring and runs after RX: XDP_TX drops
> frames that do not fit, while socket descriptors can wait. The TX
> need_wakeup flag stays set, as for ice, since clearing it can miss the
> last wakeup.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/networking/af_xdp.rst           |  58 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  18 +
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 428 ++++++++++++++----
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  25 +-
>  4 files changed, 446 insertions(+), 83 deletions(-)
> 
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networking/af_xdp.rst
> index e73a0005e169..f152ae8812d1 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -346,6 +346,64 @@ Note that a UMEM can be shared between sockets on the same queue id
>  and device, as well as between queues on the same device and between
>  devices at the same time.
>  
> +Zero-copy through page pool
> +---------------------------
> +
> +Some drivers, for example fbnic, receive into the UMEM through a page
> +pool memory provider instead of their own allocator. The socket API
> +does not change: zero-copy mode is selected as before, and XDP_OPTIONS
> +reports it.
> +
> +The requirements are:
> +
> +* Aligned chunks of a size the driver supports, 4 KiB for fbnic.
> +* The queue id has an RX queue, also for a socket that only transmits.
> +  Such a socket needs the FILL and COMPLETION rings, like any other.
> +* The driver accepts the headroom, MTU and XDP program. fbnic accepts
> +  a UMEM headroom of 0, 128 or 256 bytes. An MTU larger than its header
> +  buffer needs XDP_USE_SG, and frags support in an XDP program. The
> +  first buffer of a larger frame may hold only its headers, and the
> +  other buffers start at offset 0 of their chunk. Such a frame can take
> +  one chunk more than in copy mode.
> +
> +If the device cannot do zero-copy for the socket, a bind with
> +XDP_ZEROCOPY fails with EOPNOTSUPP, while a bind without it falls back
> +to copy mode. MTU and XDP program changes that a bound socket cannot
> +handle are refused.
> +
> +Binding restarts the RX queue. The queue takes chunks from the FILL
> +ring and returns them on the RX ring. A FILL entry for a chunk that
> +the RX side still owns is dropped; TX chunks stay with userspace until
> +their completion, as before. XDP_PASS copies the packet. Redirects to
> +anything but a socket copy single-buffer packets and drop others. A
> +redirect to a socket of another queue fails, and generic XDP cannot
> +redirect to the socket.
> +
> +When the queue has no chunks left to post, RX waits for the FILL ring.
> +With XDP_USE_NEED_WAKEUP, the flag on the FILL ring stays set, and
> +userspace must call poll(), or recvfrom() with an RX ring or sendto()
> +with a TX ring, after it posts entries. Without the flag, the queue
> +polls the FILL ring, which costs CPU time while the ring is empty.
> +Post FILL entries before bind() if possible.
> +
> +A driver supports this mode when it:
> +
> +* uses netmem for header buffers and XDP_TX, and handles page pools
> +  whose buffers cannot be split (see page_pool_supports_frag()),
> +* selects the provider with PP_FLAG_MEM_PROVIDER and pp_rx_role for
> +  one page pool of each queue, and honours the rx_headroom queue
> +  configuration,
> +* calls page_pool_refill_done() after each refill,
> +* sends socket TX descriptors from the NAPI of the RX queue, with
> +  xsk_tx_peek_release_desc_batch() for the pool that xsk_rxq_pool()
> +  returns,
> +* advertises NETDEV_XDP_ACT_XSK_ZEROCOPY and xdp_zc_max_segs,
> +* checks the setup in XDP_VALIDATE_XSK_POOL, and sets xsk_page_pool
> +  in its netdev_queue_mgmt_ops.
> +
> +The core schedules that NAPI for RX and TX wakeups, so no
> +ndo_xsk_wakeup is needed.
> +
>  XDP_USE_NEED_WAKEUP bind flag
>  -----------------------------
>  
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index ae2585508690..8cb5b5b93c70 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -5,6 +5,7 @@
>  #include <linux/ipv6.h>
>  #include <linux/types.h>
>  #include <net/netdev_queues.h>
> +#include <net/xdp_sock_drv.h>
>  
>  #include "fbnic.h"
>  #include "fbnic_netdev.h"
> @@ -276,6 +277,7 @@ static int fbnic_set_mac(struct net_device *netdev, void *p)
>  static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
>  {
>  	struct fbnic_net *fbn = netdev_priv(dev);
> +	int err;
>  
>  	if (fbnic_check_split_frames(fbn->xdp_prog, new_mtu, fbn->hds_thresh)) {
>  		dev_err(&dev->dev,
> @@ -285,6 +287,13 @@ static int fbnic_change_mtu(struct net_device *dev, int new_mtu)
>  		return -EINVAL;
>  	}
>  
> +	err = xsk_validate_dev(dev, new_mtu, NULL, XDP_MODE_DRV, NULL);
> +	if (err) {
> +		dev_err(&dev->dev, "MTU %d does not fit a bound AF_XDP socket\n",
> +			new_mtu);
> +		return err;
> +	}
> +
>  	WRITE_ONCE(dev->mtu, new_mtu);
>  
>  	return 0;
> @@ -538,6 +547,13 @@ static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
>  {
>  	struct bpf_prog *prog = bpf->prog, *prev_prog;
>  	struct fbnic_net *fbn = netdev_priv(netdev);
> +	const struct xsk_rx_check *check;
> +
> +	if (bpf->command == XDP_VALIDATE_XSK_POOL) {

do you really need a separate command here? why not rely on existing
XDP_SETUP_XSK_POOL ?

here it doesn't look like things being validated are something unique that
you could not check during XDP_SETUP_XSK_POOL and XDP_SETUP_PROG.

Overall, +400 lines for zc pp-based support...not sure what I was
expecting and I know we need Tx side implementation.

However, I am wondering if better example for this change set would be the
driver that already supports pp *and* carries the separate ZC data path
(ekhm, see ice?). Then you could show case at least in diffstat how much
less work is needed for AF_XDP support.

> +		check = bpf->xsk_check.check;
> +		prog = check->prog ? : READ_ONCE(fbn->xdp_prog);
> +		return fbnic_xsk_validate(check, prog, bpf->xsk_check.extack);
> +	}
>  
>  	if (bpf->command != XDP_SETUP_PROG)
>  		return -EINVAL;
> @@ -825,6 +841,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>  	netdev->xdp_features = NETDEV_XDP_ACT_BASIC |
>  			       NETDEV_XDP_ACT_REDIRECT |
>  			       NETDEV_XDP_ACT_RX_SG;
> +	netdev->xdp_features |= NETDEV_XDP_ACT_XSK_ZEROCOPY;
> +	netdev->xdp_zc_max_segs = FBNIC_MAX_RX_BUFS;
>  
>  	netdev->min_mtu = IPV6_MIN_MTU;
>  	netdev->max_mtu = FBNIC_MAX_JUMBO_FRAME_SIZE - ETH_HLEN;
