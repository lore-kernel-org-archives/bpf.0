Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795606106;
	b=QURbr3Y2yTpd7BzKBwWA6dh3HhpWHynqcdh6FXBljLELmX2jZIsOYET9oZXBw1/VjT4j
	 LRwI06jsBLLPpuQeHc3RetExrVRkwX+DXGZnB3g1S9Prt8haP96MMQ61xoDahKDQhQsUD
	 PPWB4hRIL4WfVz89ectNURkJaxrIDs05scecBhlWUh3LOa7RP1pPE4dvF6okuv7oI1534
	 K3/HHqBXDjpZ+dUscpivwwlEWnkfLCzzs80AssNG46lktqXruWGHOAAwnBHRcTeyxai3f
	 QhTSHarDliSws5HiyNAR6lhnOrAqn0yqa2FJNrp4r6wGK6SSwheSXYy9bPryI6oUoOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606106;
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
	bh=DAUdIKaPr+Y5CODkYJjDBIyasdmYkwdTHGBr04WAwgU=;
	b=xyuwWNAz8dpuq3k6mfr5Ug2IWQm3ACWfQUXF2K89hKq44QKJyd9FvfHwv5Qxp3iYozLo
	 P7j7NBXPeQP4veeznNHlH+oji4QsH5DrmXKbyUInikGmqGWJuQq5M7ULG2p7qabC0S8aw
	 JZ2oErUnMyGdxoQSOR5GdBa6Ea7CZtWQmYDw6g+vLDqTs1bZpScvDrweVHz89VCW/fWaz
	 qdtQspNXXaKs4Bn96CQSHD62GgYdUgZt4SATzBkQt07Fp+GgV5n7YaOxZ0k+3MArHVwdC
	 SsGa1j2AtblpkQQhXuiAvqXaRKp2yhzmPd4FEcCwsqwNqhYpGyHbLgz3hUuQU8UIsmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2+EoHyg;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=T0QBJsQg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90415606A323;
	Wed, 25 Nov 2026 11:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90415606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2+EoHyg;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=T0QBJsQg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795606106; x=1827142106;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=owx8oitJ/5fGu/doN1LAjFf7yQl9M/tBJWHFFAe2HdI=;
  b=m2+EoHygq9F1ybYQkE+VC/qbMSkBC0dDrOU/TOWbvTfyd3Sx67DQ/IB7
   Qbsz8io0tgyw9bEUTVUps1kfLLw9EG8qeYSeAoBZIDpBBMQPF/EKgunrA
   N5maAagVbCTf4qpBo2CnBE/RDt8yWF+GkFMkeiXkZqeqD4mSmrFguy3t4
   X/u0I0QxgLVie6XcdvxOaSizfbne6WHYuq0FU+vMMpUA+vgOS0ebsTQNt
   l/Ep8F4KhPrXuA/DCBy3Cvqvx1x+fY5Op7QVj+Ls+s08XnEEK59uMsDgr
   sTSbb+dt3CmBjM9LOBYSkllJ6TM+JssiazV8Gu929KSI9pRwFfzgBncX/
   A==;
X-CSE-ConnectionGUID: ZP662OzjQju1ts7HMY7Xdw==
X-CSE-MsgGUID: VUp24HqvRU2NsLYkP45UuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4383898"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4383898"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:27:56 -0800
X-CSE-ConnectionGUID: 224akFR6SCeBTCRFmrO4XQ==
X-CSE-MsgGUID: PaSpQfzcRLSJNxZLQ47zUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11737621"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:27:55 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:27:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 03:27:54 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:27:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmctSpGi8uR9zZyh0qRp/C9FTBT5/tCrD5THHjlRn47boElPPw856QhS58N6EC+v0zT2T8/TD33oGPmr66zWnNkM356OJ+jXEGsQN8Or04zwYGbDR1yGP9Y87uz6qcro6OUqiH1y2jB4Cczm+7K8PHKs1wd7p+IJhtR1/7Jfa8JzyAc+eBlJ49wTGd2rJ4dysSYILY3x+S8zva1fe/iCTwcFGjYR6w8xAf2fiAJHevI8CYPF1Mt2yquxncRIELwQhjqgIlo9gz830inZpuaOJFvEfccQ3AMFTstDW0NT8PKpF93PpJlV8mUAyT08VpjFnKDtWYjusvXoxcViqFro3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAUdIKaPr+Y5CODkYJjDBIyasdmYkwdTHGBr04WAwgU=;
 b=P0vS9KFQgKHp7aoh92IeYonNT8NzhhHDYy65KRaDJ+Z26H5PnAxoa6DxvQhO0TpCn8AU2CqrnIqU6e3cthQu2UnBUU0PvYSEQ5RYYH2GGffikpgLv4qhm2hw7l+wBSSmO0Kc+Lk8VuazXALWRvcqleQDkyMLUTYnyfnDHPMqrqeOiyeq9YUxFHW9lNWphxt97/w9UGDStuIpQW8irexliVCVj1hqqGit/ZSXzi4RsQpqf7X6WcZ4UmWAONm9ZDNaShY2SPXWCvNPLM+VNgirIk/1/+hSOVRrfbjGqIAWhjSguwtkRuOGGNvUAe/wMQ4tw15MerWvAl72ieO9fr7C/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAUdIKaPr+Y5CODkYJjDBIyasdmYkwdTHGBr04WAwgU=;
 b=T0QBJsQg2F5zs0+g2mNvf5roWQbs3ov5VpV+dpK/KY7A8787sI8GOVrsvJGm/OvF4pmAYcJ+ZxbXv78n/C01Sj3V4BEgQxVHJNKBm4ciuiZ1EVndOPic8e5Za37smYzCIoyXE0r+d9GCGx/SuFT3KbqHAD1UgCrdCioXfExb8a4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CH3PR11MB8564.namprd11.prod.outlook.com
 (2603:10b6:610:1b1::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 11:27:46 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 11:27:46 +0000
Date: Wed, 25 Nov 2026 12:27:39 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
	Alexander Duyck <alexander.duyck@gmail.com>, <bpf@vger.kernel.org>,
	<kernel-team@cloudflare.com>, <tianyi.gao@linux.dev>
Subject: Re: [PATCH net v2] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Message-ID: <awbGK9v4k3Fh4U+H@boxer>
References: <20261125095201.98279-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125095201.98279-1-tianyi@cloudflare.com>
X-ClientProxiedBy: DB7PR05CA0073.eurprd05.prod.outlook.com
 (2603:10a6:10:36::29) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CH3PR11MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 129a5164-3654-42b6-6bf8-08df4ae72162
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|261021121427099003|261026121527099003|261022075727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: BaLCIdtBNH7EvLgc+E1meNn3iGQZe9v2gASXJSYjI/meWEb/yoPaGroaPkqx3K3PNy/mODIC8Vj3b3ap6nd/KZg35DvWXC28RLJ96una6zxg3fd5t6iyLfgyjj1utaLRH2VXQwcA0+vZiACQfXX/gCJjnmXlddAYe20yz9GG2kro/qL5B7dY4Rk/4HwR2/AfUPvyKxJgWHa84uHsbB3NMeF8Z4mAxtP+EzmRXas1xTrfa+Cmy/y+EuzQ7xJDNsc1h1xXEBKM1S2X3bW0a77BCfB4vqkfymvJVA53rEwRZ+v4AsK2EECcNp4YgToByvdHx/48HUPkRomLurXBY4v7rM1pyzCS6WAiWGvG2esE4zX+HoZRWAG5+5KLWBY/nkl58tTNCn8FrvSSB2cv6UnQvBVN+dDEAtSW15M9gosVMPQg9sbvsrV2QD10n71JDoYmtp28Rrco96kjY83yXgqend0BCxvT51vuBv9CAHMdGgwfkcgD5Ufa1HJUj1CHBhlGYYK+Sz7zAUFrcXT5eYqTYLtaeR5WcEajGaPtxcUvryvoVARZElMJiMLXsXIddQB9C7pHjh9Rl/VUFnM36F+edKFT/zWXqnovRrKjpJvqoz2RvZfbyKLo3sijSCzIrP0M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(261021121427099003)(261026121527099003)(261022075727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6uznRYC4G/rZBqTrQ3KRjd8rDa4+jnQd1r/GrG4bzan/Vg5F3rodgacdf7tQ?=
 =?us-ascii?Q?lj5HSy5O0Sj0A0rIhFo09S8H97eYkJ+n1fesVbZGhre6+XtPTHj81DGviNZD?=
 =?us-ascii?Q?LM5PC+GvbbYsASV1gYO921nWROPOr6VvUaR8yq2BTJ1oOrbTV1WMaqJjKZyB?=
 =?us-ascii?Q?xQkoIgMTVnkCjWSvLlDUrZwD731YPcggUw2G3fO35PSkCKGcv5yMt8YwvEOo?=
 =?us-ascii?Q?SiYnlCs4LJH9AGhs7NZoJVyvekVnTFzP4PdnwtzA5LtTLyvczeIzHap3g0Yl?=
 =?us-ascii?Q?F54Ekzx4sMs+qTIqifD7Lthq4cweBZwAbS1Z3CWAGSWHD2UfymKgKAm8Sbjm?=
 =?us-ascii?Q?/vbh+F8SB1ZUGGxcgP8XOlNuvilcwdPU14iLAm+TYAersCisE9Id+h6eJRD2?=
 =?us-ascii?Q?S3V3w/hfhidxgUHZPO0g9bLdY/52QUVOB+EWiM9oGP/ZGXZaSxC5VcHTg3jo?=
 =?us-ascii?Q?y1PtEQNVTYUmJPE7I5S9UN8D+Fsj3XkFd7n6JgoNGXrVfaGSp/+ir2xrsIYk?=
 =?us-ascii?Q?VRrU0NPRwiW6Cr5wwOk02JFZNlW1PTEytLA1uMNFJKl9q7k3uQhDEPkNuT0o?=
 =?us-ascii?Q?MwprVwYJNUlab8cU3iKDATlQwTxEdop/OfpEMuZZvPBgqQ11RkzAHWLi+pfF?=
 =?us-ascii?Q?zJG3YMWRp9ugECGw20lt8G6cwxouanfm7MaDqBWqSjlWyP9SfyCchkBGsBRP?=
 =?us-ascii?Q?/gOr7jbmiztu0VPWrRLyuJgglNdPmdz7LMJbVxl6o7YnGgg47PaXMyPC35nf?=
 =?us-ascii?Q?2tNJ/lSsf0SNM7vHzU0roOkcjd2VPpgTfXzGykf70IChK6GWiPwkE1+NSBY0?=
 =?us-ascii?Q?oozDIlAHingB5IOBp4/0s/jMmkzdGETeT8covsV/ACbXZA5G4Uvt2+OewlUI?=
 =?us-ascii?Q?uHWFbNJ6KnuCI5+YDEQaz8y1dJwMY7c5AnWIrHSEHlT4fAusdNe/sPcmqoYw?=
 =?us-ascii?Q?MFg+UhkeAhCL8txB0vTR+j/HNIkSJZB52UsZeNbllP3qISMwshd9OWc8OcuA?=
 =?us-ascii?Q?Yy2vN+fHa8J3nNUlXIJmqNivI8aReDArjji90qVPPOupbff9Lj/9SSqE11gh?=
 =?us-ascii?Q?pCLFp4P4guBVK8U3zWDce5YtTsAYKS3O6OK2W202NZCa1FnFSNu9ICOnoZvI?=
 =?us-ascii?Q?3GOl1ol0L7RLkMiwYOLwotWaD7oHQn8xxBsNtEigjSB/jHYXigYQI6M0rOyu?=
 =?us-ascii?Q?Xm9d6IdvEsgpGJ2kjSBvNWbyLwYBlfwIcoiI2ySXtTw+lDkLueoEcDMD5Bz6?=
 =?us-ascii?Q?yuYsFlbs4xgKgs7XvDIjOv0lvIVVAbxybB9opKNLxSzs8Nimh21bbIdjbLDe?=
 =?us-ascii?Q?pnHD5Q6IFUEHUKrit03MX+XCsnSPUDrkN53wOnzSqO8zTsrOQO1VFIPYi/r1?=
 =?us-ascii?Q?LnTd4ctJMO4Pz+N06KYHqOG2rMEC7qMQrPao4jiZA1ya6tYarGxi73QqV6Ea?=
 =?us-ascii?Q?fMVHM4WCk4ssMmp2pEuCKXxcL0fOMdbKnX3S9mxw/6p4yHfDeVa4XdCk0Mz/?=
 =?us-ascii?Q?7gGWK/5oOgTM6dXlwB8SzSQs+CJ4GD2q9cALFmYbB0u+b3xXiky6wNstCaKn?=
 =?us-ascii?Q?awJtX/i+QtV1IC3AFTfdwBPp+iuhgz9zugbKju5udyVwC1B5QOpatd8hF2qz?=
 =?us-ascii?Q?MkMJpJ6kkd4pusBSTZ7Jcn6KMZvEmk+D4rLGggYss0cs3oaBCfQ121JPrSRl?=
 =?us-ascii?Q?lx9klGKt2M/j7nCYIwjuhg7pKMU+SQ1eB62+LVIWbuegqWr1XpnuLg+47YQh?=
 =?us-ascii?Q?MmqFAbwCiKjeyp5abnVnkndhPykSEyE=3D?=
X-Exchange-RoutingPolicyChecked: XOKDMzoataTmnD+VY+po3Kb2xfBP7Df8pSFp/GgSJbPCn6RnIfD4aEEV7kcOoZCLEB7tQECQibXw6rbdopA6VD7DdJrclOwYyKQQe/AgMB/Gij3FlwW3PYoqfxC0qx4gsuRaC2qIwBWbq/BtH+VuoI+cyLZNQ53cimtZciIvxcExI9nEza3L94ykjtjrbGGnOvhiM5LUd7jOqIwLUq30kmAgS7PbjmAf1cuRjzi3w41UYo4+EwD16KEGw3W2TQFa8AcnmK19E1/Ih7eS5zTs4D7DfKoLzkhEm5YvqrqPkFrtP4PrSNkIFIAWqrQQZk1zDA3y51Ritxl+4XVwe30h4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 129a5164-3654-42b6-6bf8-08df4ae72162
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:27:46.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNHasbVpy3CQCZtu74hYXx0KkMsJ9BZRb8I9sd0D/vzS8kc6MSwshfkMS7gomPelU6X87Otci1heF3wu/4x1UeD1oxWekIBgEcAqQosnLpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8564
X-OriginatorOrg: intel.com

> Changes in v2:
> - Set ICE_RX_FLAGS_RING_GCS in ice_vsi_cfg_rxq() instead of reading
>   rx_ring->xdp_prog for each packet in ice_rx_csum() (Alexander Duyck).
> - Log an info message when a program is attached on a port with GCS
>   (Alexander Duyck).
> - Drop the paragraph about the two reads of rx_ring->xdp_prog. It does
>   not apply any more.
> - Move the test results into the commit message.
> - Drop the Acked-by of Maciej Fijalkowski, because the code changed.

My ack was meant to say: let us get the behavior aligned to mlx5 and given
that there is pending work regarding checksum capabilities in XDP,
Alexander's concerns are meant to be addressed at -next kernel candidates.

If code has changed *so much* why have you kept the Suggested-by tag from
Jesse?

> - v1: https://lore.kernel.org/all/20261121012402.84848-1-tianyi@cloudflare.com/
