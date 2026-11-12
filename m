Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794484462;
	b=mTjGPyi/C2g6lgA0pcO5oWvTD+xasK1IHVD0o3FbD2XtVW4bLb45bJvnWOWmGPIgUKc2
	 UlLX1iTARQ18gcRYWkz9buQO/MdyPlxLfxYE+W+JC0aehUkt68PoSsYwwcgjKzbs2dOYV
	 c7l1IYIgsQzxZvtiJQJ0PJipIDQwELET1pffQwcI6dBdUBQRGNItBcLvnB+jXSh5evXwU
	 cTHNFrIeVTsXj/hn6KrKoe7L2XYqqjHi9B6sDA1jQjk1hiWwr1I+kNIH0mek2XFr888u/
	 zsI8fPbQLZQfskRPd1mUTI5VWniPiHcBPKmtMizc6rTMu7qkFA22aHIsoPpgAvcD1+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484462;
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
	bh=TyZllpxQxhxoMhGa0v8mtFSdWHoOIYTub22yT6LencM=;
	b=cLBSA9FYjN/C+bB4tcPHFYgqu3Ucp4837kvGUTVtJu04r1xYjqnWEO8+lPoI+iOji9ds
	 6ongB1nMPRDzVXqtf2z+L7W/0z6Bh0hp64mFmAriCxmJ+FBttxr30bWEpCwpfXpipWW70
	 vpT5Nd5Wgd2sshlh3KS+Hp/QzO2bTrbqH+CbxQUbOxMg7vy07vksdhdwIC6nK9uXhnnGg
	 ymbjV2b34QlfNiJ2z6bvBszC/Rba2Mll8SeyuMqLVwwJVn2d4t1nZqopM8wgS1LaA5dXE
	 K3MYXUKvuUnAUqV52zLu6r3KA1uQpocnwubcFPHySED6B8QMgGGlxyUT49M9QBA09zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HTknUSWA;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b="lzNME4/j";
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0768606A881;
	Thu, 12 Nov 2026 11:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0768606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HTknUSWA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=lzNME4/j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794484463; x=1826020463;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Fs3a7isEVrQZey7qPQlybCyp0sMCTitD2FwWSclQSVU=;
  b=HTknUSWAzUteAuTPI34zre42mFjYBPMTDTvMzpv4gc8hbDmWLOuId8Np
   zNovm/WYaOGX7sTfSNLPulW3RPCsoQq7aXxhiez2MkS7jt7kOLIDVxQkI
   pF46TWO0K7XbX+vTQLZkKqDFEsDIP942Y1IwkXMROr8PDbQDNure6zIMe
   IGkXwC1OEU4ZLm5d7pchIEn4S5SYkYBtApHdd2GQwTe+JdpHE+Vbpmhc3
   uaUksWLUrGyIZV18AyhOLGYpMqmiRpec7pXH5j1Gn5NTE2WyaRowlbdBe
   PRQwXDoFx9DnVfYDIPQcZD0Xqxy24L8kfqMdi/AoPNpEodnkXPQDuQy6V
   A==;
X-CSE-ConnectionGUID: pRLXJm1SQz2LrnWLVoixfA==
X-CSE-MsgGUID: broPSBpnQJyGSu4TZAvB2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3365207"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3365207"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 03:54:21 -0800
X-CSE-ConnectionGUID: Mm6SdVmtSMG85NIsdUtxLw==
X-CSE-MsgGUID: EGs5c2OLSdeltETNweXgrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9077418"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 03:54:21 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 03:54:19 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 03:54:19 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 03:54:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S37sunVbWMyOHm82ANASfSwVfbT7ecVq9wOHUE1CGjd33AQeR8ZjfqNttlNxe67ynraLEOAr5l+aeEl+TxVBgemWnpWCbKP9Mds8YzKuw75RZOouzenkucDhe4OOc3FLLUkK8Ojaxz7985STClMJDrfQNlGqq4n07npo3rV0ZebnB6ur4EPztzp82CqNWfg3v0yh0+tmjqIbGtUGFyQpXknGLq4dq3lCmqDvxgi2cFnpCkKkMcFjuiNvbLfr7xdE/NhGE2d86GcKb0pRNSAB4nGTJVWBTHvKh05zWu0s6JerYpCClaLY+euzpS4xm+F/VRtpOhJcVeJSTbrJO+ocaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCpt7z4Mlgy4PsEB/sF+26KAEpbM/tNmg/b9Tz+BXt0=;
 b=rHBqRTJyODELy/hPV3TDLjCzxBidivoZKfc0H8I8Y+1jjyl2cf69/moXKu30Bi0oMPvp1ySWz9cXy6Y22Pqyr5P/nvjMsbLyNCkjl5RBprFOp1zyrtqyQanA+SnbnEgQS3JBEyUb0SolE815uIQhXN0f8P2eqzo9vxjIXY8ihZUoMXIDLlJqojk4bTnUepRig4YjnxO6EvUpWN+hp1+eMwFZlvsBDFWlsvZYK6HrIcQEzMFJ7yOirWBJED2lVa0aSjqw18NBUzx0FTEqS0T/NR1VB9oy79C99Hgpb5/ztXdnV3R46Ejq7AsjI0B8NCpQjSvA9uDGm1WBXTwj8eKEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCpt7z4Mlgy4PsEB/sF+26KAEpbM/tNmg/b9Tz+BXt0=;
 b=lzNME4/jt51hdmK8KR213z8mQcEmdgjH1JjFRqzQsGblnmdohQn5JheKrcdWyGvSeE/EgLl3zylfnFCqHccRiA3cFMBoNZ/Hlm2uWqE045NFBgY4C4j2uwWDhjqw6nBfzz3DTjwfMwcOvb+RU9H2RCvgFeRG1LNySIUUwnTr5Cw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CH3PR11MB8237.namprd11.prod.outlook.com
 (2603:10b6:610:154::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 11:54:16 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 11:54:16 +0000
Date: Thu, 12 Nov 2026 12:53:57 +0100
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
Subject: Re: [PATCH net-next v1 05/11] xsk: Install UMEM page pool providers
 in the core
Message-ID: <avWo1bY5MSN1XvHL@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-6-bjorn@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110102039.1002605-6-bjorn@kernel.org>
X-ClientProxiedBy: WA2P291CA0029.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::29) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CH3PR11MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 69240cbd-487e-4468-204b-08df40b3ad51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|4143699003|11063799006|56012099006|261022105027099003|261022075727099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8Dk0tK0fcmsAQ/wBFo3m+Y3sAid2uGk1jwYk+YnmcKp4RQ4CAakV36cL8+omAEtLzq8Cwjpixqu0FmVQSCZnT3Ks/4m2TQ6JrQmPlhYWsZxm31E2YpKukIjGeO3lnYmcMyQzIVSfRa7HFLS4RVSFHBwZt3e54gDNJGU7980aRs/fFMzALe5V3DThmcDWmGKdWv4T3YMAWKhpzfDiNlnT9H89tbqZGAqBwP/7FFpJbtpnuepCyagt1Nto4au8Twh2hEv8Xdlbykwgm9IWmQ/Pu+F2GQ9XbrgJwpSihDaj7wKq3Kt1wwzd8ABf7QoTfIbBqw5Tp4rwNSDzL/5YC8IKXlpGuJH57/khp6hq3JeBdfWJnNsyeXp6zJHZtxWQfFXW0WOVnC0ic3z7YhvhSw5ZxB5tHqm1BiX8Bn1s5jPi3UkU/dxJRlbF2gVasY1IUWarOHPHOXSqcoLPDVAnAzwf96mfEpuYUWpWjyAxObhSYSSbWMUJ5xemcNrtyAUAGAWouZif3Ab3Hb0eCTvglBfOQSwlTlBVXhLxiXQ+guOAXAVNEmCDh+52Q3mZlBer+MJweDbKBDfmzAjhZuZwiXaWcy3bcNOZwTnryOG7MnGebY+bEBeNBXmaQWbjF0x9dacNXYCDTg2iXjZQFlVnH0bwUptJE2oNWgxzGmKcYaeI3cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?j7C+8vJ6TU7ZV/9WNyLP3fOdnjOYBfVsZlsPF0mQ3nN2wPDUv8kP8gXZPL?=
 =?iso-8859-1?Q?hqoj7BM+VnMGKvjEylwBU7shzpVRHGfLNnP+F6A01V6bL+Pr6As7D6FHiy?=
 =?iso-8859-1?Q?HIRXRGGvd3qcngY5c8JeB1OLH6r0hGatUsdA/x6l+MypVIEI3W1jXKWXmc?=
 =?iso-8859-1?Q?/LIIeCg/II6d3MDmh2KuaAdy9lcixE91QxL8UfMSHYV2yQVayRR53hhq97?=
 =?iso-8859-1?Q?QxvjkwlnNKjWs9TMzu5CEUlUPOZhItPpvWw/QsV7yUMshPc1JyUtoSx8Xs?=
 =?iso-8859-1?Q?wa/IJugZExOK+wPwHVCX5SJIJbBmEofNYCDjfvSh/iuX6a00hKnSAvF9u6?=
 =?iso-8859-1?Q?hb8TWeHLadM9FkARPbtLrFc48ZQ+OSBXA/Gg/kuijeEaN/Oe+PlW/lCvnf?=
 =?iso-8859-1?Q?UFDOuJPvaZv9RJ5E2o0f1lB8H8c8sre1iSfigzwAjI60mEVqPN6OtLXHDb?=
 =?iso-8859-1?Q?AFBJM989/Qvkzk8DvCiuiK237HTEh3UdPYBjxiWef/vJ321S/j0eopvcBk?=
 =?iso-8859-1?Q?OGtQTuDleD2RKC4K7SGztrvn8cZgJLh9HgPxfjnvwHgA2Cu2K3DJxBuCMx?=
 =?iso-8859-1?Q?4LZ//ShHd/JSi2bjWQrE4an3SesiD41h/rU5hRnrBcYrxBlwojnrbPx7JU?=
 =?iso-8859-1?Q?F0edNnWQAAIFmFCwFLbLNwSBQ2ZoS+Cw+dhzyKtsYsSSTu3HwKsq9Yn/uI?=
 =?iso-8859-1?Q?WgoEY1r/NUf66fH6sxkTvMF8A9jWHDKESRC6helaqZDxir8PDc8AYe4Cfy?=
 =?iso-8859-1?Q?QUAD6HhXT/MhOpWEl/WUZDg6QdrPSDzNG8IaEgggbGXyqD0XuQURbNXh1s?=
 =?iso-8859-1?Q?aI6R8pBV6QXIVSxvPJddw9wuIGcnk4+FOmtv/IhXfiwimPDHnehhY1JjtV?=
 =?iso-8859-1?Q?2KcmosNzGA8XwNAjv/Zr6G7ub3ndK8V7dIaitjXv5VYwtCh3cf1GVMiuV4?=
 =?iso-8859-1?Q?0R3unVV1ZQvqyyA4zLj95EVCZOGsnXh5MFA0M6WyVdR26XJdVdbyxXkuz/?=
 =?iso-8859-1?Q?bfC56oQGvstw3hyNUOuE8bBsjKQsrqzxZ97r41G95iIYMI1ZJH25EfB0h3?=
 =?iso-8859-1?Q?aZxyWzWLypYCANMgIwEBIdHIiQVu/jIc9q30vabWkZko3aTPjoQY355wX3?=
 =?iso-8859-1?Q?Tv3jj9VQ3pSvCK9pn3jTb0nvziuL3AYeFuDCZKcn0pRTeB8HMvYdPwPDAD?=
 =?iso-8859-1?Q?AGdRplREr1t4GUQQoI3jC/pwDhLILrt+A2JcGG7ltjS5rOXLW9odfe9uUc?=
 =?iso-8859-1?Q?i+bTBhkZPzDOfL68cPFt1Ci1v6Jqed/2L0gTGDaccdfCz6/NDQC6xy/BKl?=
 =?iso-8859-1?Q?LnSCszPuALL+yDqeuXdexFAommkv9J4Z5AmecsBtzykKLMcbVKD8ujOPHS?=
 =?iso-8859-1?Q?l8twvAiAp+SfSCDZId18Eghh1hahOnSI2tOFZqvidaplaG7mbPKruCpa+G?=
 =?iso-8859-1?Q?P+ti8C65svakTQisrGyAFzd7KBnqwAZM+KtnOHVMzpOAI7ehDu6GY5Ye42?=
 =?iso-8859-1?Q?SaTLR9T449fB7Vq5hejsy19/WCq87yeQlUO8tj544w0aB/1MwDIFGMfi5f?=
 =?iso-8859-1?Q?VO+LU2mmKOkxHfaoHpz8qHUqiiA+aQnGx9/OMn/8OM9rtMGtDsz11iPMei?=
 =?iso-8859-1?Q?bLUi7MAKAt0OQkVsq8T2Xlt8HLh3b5HQT/ppNxemuwDjVAbxDBIDV0kyqe?=
 =?iso-8859-1?Q?qP8TH5vi2GTwYZJEg40tUmAIh5XD0vjlQzvvG4fNM9M0SY0u4eophIoYAM?=
 =?iso-8859-1?Q?8bdUSt7PXzWyW95e5t+cC6bGr0fX4vRWWBYQkhfG0PJ0CODb2hvuai9Jia?=
 =?iso-8859-1?Q?d2Mo+oTLOudTJa4NrSTJ8TFCJu4HxB8=3D?=
X-Exchange-RoutingPolicyChecked: FRE68qc2tYf95VP9anbMv3Jlp3vWurPnKcJD1MQBtl7Pz3aGbz81WRCtuIOfjRBMBR9xmN+P2m0xpU2NvKpINfi24yuo/jH/+G6+ntXitADzNxSqdRtHQ1q9WnIyoPfUDjdLpWPKDi6+pames1UV9KGflQYZSDDcMPq4PYRJL0EBP5JXbpQrc4i3vbN6A06F4lk6vTQ9QHd3C/AHGdUavfsvx44NlPn9rSYhU4tu3sN/w32MdTRShb053ToQHfbR8PjFdWV2dit+6YE6ny+KF72mr/h4SaKKMkDLOyF4v2cSVggsw2g4vm2fOhzyzD3cYl5kJLBh6LBT7YYEvVXEgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 69240cbd-487e-4468-204b-08df40b3ad51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 11:54:16.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3m4LmN5htm90zNGIjcP+Naq2ubxOJFadxdJMwadUGmzLzNd65sWGY1+ts+ymi1oZTki99wlSg2jp0IZzkDAjyRl2RI8E2GklvWe9sZaGic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8237
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 11:20:26AM +0100, Björn Töpel wrote:
> A page_pool driver should not need its own AF_XDP setup. When it sets
> netdev_queue_mgmt_ops.xsk_page_pool, a zero-copy bind installs the
> UMEM provider through the queue API, as devmem and io_uring do. The
> driver only judges the chunk size, headroom and multi-buffer mode
> against its MTU and XDP program, in XDP_VALIDATE_XSK_POOL; MTU and
> program changes of a bound device get the same check. The UMEM
> headroom belongs to the socket, so the queue gets it as rx_headroom,
> next to rx_page_size.
> 
> After a queue restart, the core checks that the new page pools took
> the provider. A readable provider must back the header pool, where an
> unsplit packet lands, so pools declare the buffers they supply in
> rx_roles. The old queue's pools carry the same provider during the
> check, so a per-queue generation, mp_gen, tells the new ones apart.
> 
> Generic XDP runs outside the queue NAPI, so it cannot feed the socket.
> 
> The provider needs no xdp_buff_xsk per chunk. The buffer pool
> allocates them only for copy mode and driver zero copy, which saves
> 128 bytes per chunk.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/linux/netdevice.h     |   8 ++
>  include/net/netdev_queues.h   |  12 ++
>  include/net/netdev_rx_queue.h |   2 +
>  include/net/page_pool/types.h |  12 ++
>  include/net/xdp_sock.h        |   4 +
>  include/net/xdp_sock_drv.h    |  45 +++++++
>  include/net/xsk_buff_pool.h   |   3 +
>  net/core/dev.c                |  16 +++
>  net/core/netdev_config.c      |   2 +
>  net/core/netdev_rx_queue.c    |   9 +-
>  net/core/page_pool.c          |   6 +-
>  net/core/page_pool_user.c     |  25 ++--
>  net/xdp/xsk.h                 |   7 +-
>  net/xdp/xsk_buff_pool.c       |  69 ++++++++---
>  net/xdp/xsk_pp.c              | 221 ++++++++++++++++++++++++++++++++++
>  15 files changed, 410 insertions(+), 31 deletions(-)
> 

(...)

> +
> +/**
> + * xsk_validate_dev - check AF_XDP page pool queues against a new setting
> + * @dev: device of the queues
> + * @mtu: MTU to check
> + * @prog: XDP program to check, or NULL for the current one
> + * @mode: XDP mode of @prog
> + * @extack: netlink extended ack
> + *
> + * Context: holds the instance lock of @dev, or RTNL for a device without it.
> + * Return: 0 if the driver accepts all queues of @dev that have an AF_XDP
> + * memory provider, or its error.
> + */
> +int xsk_validate_dev(struct net_device *dev, unsigned int mtu,
> +		     struct bpf_prog *prog, enum bpf_xdp_mode mode,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct xsk_pp *pp;
> +	unsigned int i;
> +	int err;
> +
> +	netdev_assert_locked_ops_compat(dev);
> +
> +	for (i = 0; i < dev->real_num_rx_queues; i++) {
> +		rxq = __netif_get_rx_queue(dev, i);
> +		if (rxq->mp_params.mp_ops != &xsk_pp_ops)
> +			continue;
> +
> +		/* Generic XDP runs outside the queue NAPI */
> +		if (mode == XDP_MODE_SKB) {
> +			NL_SET_ERR_MSG(extack,
> +				       "generic XDP cannot feed an AF_XDP page pool socket");
> +			return -EBUSY;
> +		}
> +
> +		pp = rxq->mp_params.mp_priv;
> +		err = xsk_pp_validate(dev, pp->pool, mtu, prog, extack);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xsk_validate_dev);
> +
> +/**
> + * xsk_rxq_pool - get the AF_XDP pool that provides memory to an RX queue
> + * @dev: device of the queue
> + * @queue_id: RX queue
> + *
> + * The pool stays valid while the queue that the caller allocates runs.
> + *
> + * Context: holds the instance lock of @dev.
> + * Return: the buffer pool, or NULL.
> + */
> +struct xsk_buff_pool *xsk_rxq_pool(struct net_device *dev, u16 queue_id)
> +{
> +	struct netdev_rx_queue *rxq;
> +	struct xsk_pp *pp;
> +
> +	netdev_assert_locked(dev);
> +
> +	if (queue_id >= dev->real_num_rx_queues)
> +		return NULL;
> +
> +	rxq = __netif_get_rx_queue(dev, queue_id);
> +	if (rxq->mp_params.mp_ops != &xsk_pp_ops)
> +		return NULL;
> +
> +	pp = rxq->mp_params.mp_priv;
> +	return pp->pool;
> +}
> +EXPORT_SYMBOL_GPL(xsk_rxq_pool);
> +
> +bool xsk_pp_supported(struct net_device *dev)
> +{
> +	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
> +
> +	return qops && qops->xsk_page_pool;
> +}
> +
> +/* Called with RTNL and the instance lock of @dev. On error, @pool->pp stays
> + * set if an old page pool still owns chunks; copy mode must not take the pool.
> + */
> +int xsk_pp_bind(struct xsk_buff_pool *pool, struct net_device *dev,
> +		u16 queue_id)
> +{
> +	struct pp_memory_provider_params mp = { .mp_ops = &xsk_pp_ops };
> +	struct device *dma_dev;
> +	struct xsk_pp *pp;
> +	int err;
> +
> +	if (queue_id >= dev->real_num_rx_queues || pool->unaligned)
> +		return -EOPNOTSUPP;
> +	if ((dev->xdp_features & NETDEV_XDP_ACT_XSK) != NETDEV_XDP_ACT_XSK ||
> +	    (xsk_pool_uses_sg(pool) && dev->xdp_zc_max_segs == 1))
> +		return -EOPNOTSUPP;

that is checked elsewhere, in xp_assign_dev() I assume.

Why there are skb mode checks?

You sort of introduce totally separate control path and rx data path. It
is hard for me to buy onto the management burden of all this new code :(

I believe we should break this up onto smaller chunks and don't try to
solve everything within a single set...or wil that not be possible?

> +	if (dev_xdp_prog_id(dev, XDP_MODE_SKB))
> +		return -EOPNOTSUPP;
> +	if (!netif_all_mps_have_cap(dev, MP_CAP_READABLE))
> +		return -EBUSY;
> +
> +	err = xsk_pp_validate(dev, pool, dev->mtu, NULL, NULL);
> +	if (err)
> +		return err;
> +
> +	dma_dev = netdev_queue_get_dma_dev(dev, queue_id, NETDEV_QUEUE_TYPE_RX);
> +	if (!dma_dev)
> +		return -EOPNOTSUPP;
> +
> +	err = xp_dma_map(pool, dma_dev, XSK_PP_DMA_ATTR, pool->umem->pgs,
> +			 pool->umem->npgs);
> +	if (err)
> +		return err;

Couldn't we have this part common across drivers wanting to do ZC?

> +
> +	pp = xsk_pp_create(pool);
> +	if (IS_ERR(pp)) {
> +		xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
> +		return PTR_ERR(pp);
> +	}
> +
> +	mp.mp_priv = pp;
> +	mp.rx_page_size = pool->chunk_size;
> +	mp.rx_headroom = xsk_pool_get_headroom(pool);
> +	err = netif_mp_open_rxq(dev, queue_id, &mp, NULL);
> +	if (!err) {
> +		pp->rxq = __netif_get_rx_queue(dev, queue_id);
> +		pool->pp = pp;
> +		pool->xdp_zc_max_segs = dev->xdp_zc_max_segs;
> +		return 0;
> +	}
> +
> +	xp_dma_unmap(pool, XSK_PP_DMA_ATTR);
> +	/* Copy mode takes the chunks that the provider holds */
> +	if (!xp_alloc_heads(pool) && xsk_pp_abandon(pp))
> +		xsk_pp_put(pp);
> +	else
> +		pool->pp = pp;
> +
> +	return err;
> +}
> +
> +/* Called with RTNL and the instance lock of the device */
> +void xsk_pp_unbind(struct xsk_buff_pool *pool)
> +{
> +	struct xsk_pp *pp = pool->pp;
> +	struct pp_memory_provider_params mp = {
> +		.mp_ops = &xsk_pp_ops,
> +		.mp_priv = pp,
> +	};
> +
> +	/* Unregister removed the provider already */
> +	if (!pp->rxq)
> +		return;
> +
> +	netif_mp_close_rxq(pool->netdev, pool->queue_id, &mp);
> +	xsk_pp_detach(pp);
> +}
> -- 
> 2.56.0
> 
