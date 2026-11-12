Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794485888;
	b=CyCRPp0uFNKdoLaHrrFyOn8L9BL4H5AOblBqZFQY4LjXktci1Hq8STRc+icxhu29ouGB
	 rJNySEGgkQ3CFhs8jStD9K3MxKLbmg7lMqSl+ZuYWm5+F1R+CNYS0NsraX1GjSVk8ZN7h
	 UJjQKgQ5oBqLulNsiSdiQfAYSZ4Ub2R2vCMKG0r0UASyCD4EzdVN7Pw1QFRb1wp7sxgTE
	 u+iuGrFJhZrl+9Ul2Xy/E7WQi1LLjGgHffVss1aYVWtA5Ol0YalW1jeCCWN5/vluWwsHd
	 zLKzcuM9ofiMsVDdR6+XXoGICDAFUgV8oKFpTaCuN3vBvEjGxNFzn8CYcI6CGTYZH7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485888;
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
	bh=nGSFsb5tCeV12a115Jv1Rrt62GTEPMO5YdB2wl6D6Tc=;
	b=TBeOLMGxaiBp0NSs+Mqlvw87fkgSggahX88gyMiPaFfb0VJov8b9Dov7+MILBxl+30GZ
	 oUvmzxJmBCLdQnjB1QxzSxRsgssr8Vnx/jYp5ZwqZZhnjB3z7f4Xp46DH6RqWN7t4sDYl
	 eobi0Jx6RoA3t/gV8N7mL4Qz2CLGRvuKAH1nEd/SLJ37XLUeP0V7RD4nVWg3Gbr7aXnIZ
	 dQ1sfNxIXqHykSrD1qTg8LNIGF23I8V7OxRfrJgzn2shdUbcXnX0fICghs6bZR1+nggxN
	 0gJnRBhZ+FmpsFqs0LkiFtxx4sPp2MCPf7w9hWa1uTRia6Yts+iUhXhqLEy/xDeK/NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0GwuEYh;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NGLxRHpb;
	arc=fail smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FD606A31C;
	Thu, 12 Nov 2026 12:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 583FD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0GwuEYh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NGLxRHpb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794485888; x=1826021888;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oScwrDMwY2vQdtKj6nzupia7fH/vOd/pISkBAuD2YP8=;
  b=i0GwuEYhRuWa2xSOWb9HwRT4CmiSc3MAKN/ZxV9XmFO+5bw2FpJOslHW
   ni0+vcHG0yMtHgbeTjINPW2WNE1xruOExhTJoI5asHzOaewFJWSE94G/7
   3kKj/cUaTcFzI5pZeEIvmpXw4rfa6yrXCD2n4yerIS9iYXJgHxPQOhL3i
   xoom7Mc09AoVxaAd8aO+8uf4gj9ZKj9G2kx5zxkPpx2XHJ4Pkvigfhuvj
   eOUHpoMW+mwR1eU2S9bl9fzu5Oz4aD+oura708xJY4TgfN6UmBwhfuONx
   nkfsbxZ4rQmBf54n7DJ+5VBPq8y2o3r9p1tYBIrT537QV9ZiTWNWGIDcG
   Q==;
X-CSE-ConnectionGUID: fEqxQytSQRqBVPF41f+aNA==
X-CSE-MsgGUID: vAy2uvlcQrOvl72DaaITVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3313282"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3313282"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 04:18:07 -0800
X-CSE-ConnectionGUID: 7d699Q+MTRyyv/Mn4a8Gtg==
X-CSE-MsgGUID: dJePKQfdRDSccQRkIifbug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8597729"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 04:18:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:18:05 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 04:18:05 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.65) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 04:18:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pI1WS4Jx/u2HQH5o+MRzXxR4maMQzyBw6Rl8j+f6IQk0QRvOoZ5r9GU3nc6AOaoYiukkZw54EvUoqrq+oDyUGt+J/k9g/w7UZC46vnWkJ4e8aL64Pz/QKwwH64gTlUV0tkKnP6GkJo0WDPx8ytg95W0pJn6P3CfTaOMWW378MkAddT3WExpCi2DIXd8WSAmNQH7epri527Ag9BMIKrAs5BGir34jqr39WpAlCjww8qr2tMdhBfNFX0rLEuUTJilhJnoBY9uPoZ9e5ykQ6l/v+NyRkH1gwBqnV3Uafmg7VgAvNiE65itzg3mWZMunO4YJmpBi7x3PbICV2PLeM6wryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70JxUuXTJPnRkSzNpzylxmCb5NM7FSflk87A9wf2syc=;
 b=cWUKJzA1DLWo5paP43jjpDEdGXasa2tymYVf9nkq4/+QogA7W+UOAz1MOto/7mE5byHhoEiIhraCoMCN2Ur+wuZOzorAJ2qVLkiVnEVWOGwQhT8VVbaIgrDWjRhY9hk1MGUx4uPrdbPKANcKa94G6f79lOkjlblY70cOTqFJwQ8H+Qo5ia+Cygplf5FJSdMhOXDAShycPCWGFwymef0NcU8MvQw7u7y/A13ou69xsP/aUqhogN8B+s0SJ5rIxO5fLvQSXKoJ50RyhGJzqzgp4fkqpJOTZ/IE4ytSKGczcJk0cTgUwn2aQKfw1jAvhyNXby/ndGaDrpPvKyTEWRgkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70JxUuXTJPnRkSzNpzylxmCb5NM7FSflk87A9wf2syc=;
 b=NGLxRHpbuT9c5Y1ML88eAisKrTBjKWXpZO4GEVzuvvCX7fdhlaImWijzlrd959WVFSLZ8SNg4GSyDnWKHLXRkwb8ET1gRaRs+PsPCaNv0v91vB5CFB2GBXdhbAUUYYYpG4aRBVhbU6etJjqqEAfP3YnAIdZ/+ll1LxPtEeUYQfY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by MW4PR11MB6861.namprd11.prod.outlook.com
 (2603:10b6:303:213::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 12:18:01 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:18:01 +0000
Date: Thu, 12 Nov 2026 13:17:47 +0100
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
Subject: Re: [PATCH net-next v1 07/11] xsk: Deliver provider chunks without
 copying
Message-ID: <avWua/xvHrUa5wUI@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-8-bjorn@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110102039.1002605-8-bjorn@kernel.org>
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|MW4PR11MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fe2868-84db-433c-7ea2-08df40b6fee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|261009223027099003|18002099003|261022075727099003|261022105027099003|261021121427099003|261021135927099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261021123027099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: RqVw8bESgUgzJLqH/8a1fBxjWE094MpOC2Oo+JU+tHqXA3foZJDfcxKXSD6T1QqOi5tM0sPlAmxj0PfONyuuvmNJKrUciEJzDws5cJeKIsO2vaK65+fmtsEFNp+a4Ac4Jw+CZJNh8xyQ/O/fNAMEvcCGJgTxkcXQsRe+3y2YnsqBDVlFeb3bGksIV0NoGVTb1RqhmsEhmGlxElrH1a14jEVXPmg3uTD62qqK1lBVzpqPqUPeTPC8To2eobj41A1p7sF2FeFL7WieMhmJASkWfP4A3xL/odebQW6OtkdzcXoKpWi4zzDGcZcVNRVS4wgKFrlyib/co25i7uedHmynRKrVCDv7YKD7ljRS0mxmzHQgBOta2HyQ2OsAt/CGSeiHESH3tbdF3oJi2D5l7GyNrj4giOEuwfCG708eIQts6dnR+W0Zv/EH8sIY340HmQmir0yUo7ulBW+PDUUGhkcnCEzZeLw9yf/umPhJYd/upOnwOP/e/UOcgyGfuosiD62So+Id6r60Ts3/vdBHUPa7HDADbFVKt/f5CEbETnVdUkdTIQyVKl/DLSG0LHJjxQni7/ZWoA5WZZ/tK5yEoHsIo+vt8FqMmD++vfdvduPAwM0A5daiJi7Y4tyAxWLo2kbZyFCk8T+Lo6VJ7GSPoWmBK1Ypc7R9cckMR+AJIYudkhQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021135927099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021123027099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CsaldlLtBSymbVh2zdtSzGpfGFbBkit3uuc2+eCE+QdO4+7KuhLBvxzF4Z?=
 =?iso-8859-1?Q?BVLTZ7GeN7v4b23nsfdXDG64BSuxrpubkOzs0ppFYZHlmtAY/+9oWGimyf?=
 =?iso-8859-1?Q?Q0zP1rmRohDpSUtz5nH1KhjUlmZA2U+NXAk/QALj7hH9Fu5RMu3J4rqoi9?=
 =?iso-8859-1?Q?993TcGWUKro0cis4FYnGQhLzFvdnuCcmWgDW/UQFeAr1TixRrKxAeFJccu?=
 =?iso-8859-1?Q?s2xo8Y6XU18TDa+yS4vY14MC16CySdLkQFRerPxDiXiOizjF70wJuQBajL?=
 =?iso-8859-1?Q?QnmYaUM1VZuKisxDzijzpTiLj0Tvc1qGpCuAXd9V2+OrBpx8mB42TYhm2h?=
 =?iso-8859-1?Q?dGCVr8Ehcrm8/JxL5Hd0SFuw6XX2rlO9+rlHyNMKu+4BAKKxHqwr+QBBqG?=
 =?iso-8859-1?Q?OWLGQcVM7RB7X9BlP79cKVB3/omXPuFDki+p6m8RIqtwXHPUNCYBWY48yF?=
 =?iso-8859-1?Q?5bEsCyrxH5guR1kMcb4Uf8Gj9a7Dh9Kn0WyzD2NVlWbYaegLX8BBmKO7EM?=
 =?iso-8859-1?Q?3NJ18/d/M4S/Hpa2zhzQfIZQG+3ZDaxNIVEexKVGmwL0MfkWsbLXD13srO?=
 =?iso-8859-1?Q?RHm6XR2uN7KQFkjuxkTzoW5naqOd2OvEazq8wNfQKNtSGWMAwmqS1ogoTF?=
 =?iso-8859-1?Q?/WO6w+fZpgfn/vCLF9HzWs0bYjYo1oYcnc2E2Rm9s15r4rJrXOEeIRl2LC?=
 =?iso-8859-1?Q?Ul6betVbkRnFatdgr1h+qO6+LIoXFLf6l11ZseDC5mDKS+OMSYhD5MWCkx?=
 =?iso-8859-1?Q?DYZCwhEiSthY5Cy66UtfsLljiZFt/iLNupnzyLMbzzWFu4nk9YK2jYVCI0?=
 =?iso-8859-1?Q?H5hHZWmEAwpaaDh6i2mhMT3EqLqJdNydui8JzfIpNQOlNhmUvT3c1ss63x?=
 =?iso-8859-1?Q?VbOv+i9p7X+chwCZCuRWWUZN+mQCQ0sEA1UQJVos38538Zhg1CCo2vC/s0?=
 =?iso-8859-1?Q?cHgwxiAcLk8uc1XVRwlGvMqoPo8CynoEab8FB8PsKQbP+ltvRksGhOIzZS?=
 =?iso-8859-1?Q?dmDr5aeWdp8jpbBlmB5YD1U6vE8bD3rzSSoP3ctZ3f8+e5un8BAGw+lpOM?=
 =?iso-8859-1?Q?5BfTcd31UZTr7gFaivYbFY1bTBWvivFSLmkgeJrgG1xZCV+GHYua0Klzu/?=
 =?iso-8859-1?Q?xwvkYlPPz6Urun+KGx9zdKliFINKzJBlLzhEZstY1HxZQJrdNNH8ipZC5Y?=
 =?iso-8859-1?Q?2N38AIVqiDqoHAmdNbKBDsDDVDGi+5Y3CC1s33SlUEKlrZY1BUHr1JDmci?=
 =?iso-8859-1?Q?cGMgIVc+2AyFPwvylcyYCqYM4WMx5QO9GU3u5yFlfclFDWVff0v4TIRWLi?=
 =?iso-8859-1?Q?717ba3/xuS25WP6ed2xEhhmx71DXPmg2d/tPzJaqjbhSmGcZ5lEOzLVI00?=
 =?iso-8859-1?Q?M0eobErDBgykuCU0A2x1+QUAvZSWnCbS6VXqF7DV/+5GiJl/oFJ649RAqg?=
 =?iso-8859-1?Q?YlpkDc02UEMNmo3KSjXIZCPjpiZTYsJtL9HGUjAajRswR89aa3GEKBOMPS?=
 =?iso-8859-1?Q?u47RLOIHc6UH6TimTfHHAP7XnDYLdZO293u5dskkWYaC4kMnP9lKB9IISv?=
 =?iso-8859-1?Q?HfZVCvtzi0WJQ5ZHA7+Ahjuw/UFaWkIsyEN8B0MXPRgL1wyGH8/Z8/FXG1?=
 =?iso-8859-1?Q?jwDEIeZ2cIcdL54ChtbhlvZSPKsdKE2pDYo8uVJUlpmMbIMBhV/qqo1Cqf?=
 =?iso-8859-1?Q?M0WNzFgqrr2IiQ3u3xIv73uaA3hvthmcxEyUJFdMilFM1NoDIzb/5ctL7X?=
 =?iso-8859-1?Q?nTdHtxyLnG64q01Y2PZxBDVKRf41ggG5wbPq6eV7fhtbmbC3TWBycYhqJz?=
 =?iso-8859-1?Q?3Hh17nKGjk78lPeeKTmQ24x6k+1nQDg=3D?=
X-Exchange-RoutingPolicyChecked: d1AiVtni1Z+3UsrAWDn1t9Pms6xRz+m62Lo4Odl4ekxE9YAGZQU+Nq5FGUuxgXg8FoL7QFI6Beb0uAln0TbwXlUnTFj63dKbxICbUyI1OKLT2iOVEkdPRPzeOijFkmheyKHtkULx53VHD1S8pyYQ4wuQ2k6RnuY1h8vP9v60vtBUL3JRhub90mOKq0og/GWUuM2D9ErE7udsVl2vWxcmaRgK/7hZEMT0uNZpoClUlJ4GsIQgDm0lXnFQaZTq0Bey28xyWCbETTuM0R4nbNUDcWSnn7OpBVa3fHhrZ1r9VuTqzs1SfsnOQph86RneQT9vtdLi50ISOrtYJ6RwJDNj9g==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fe2868-84db-433c-7ea2-08df40b6fee4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:18:01.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4W+AOx9CXFI3LpZVtqAX3GEtt9TK3tTIzB4TVEEGIISYgAsL6BXIJAAG5OTAhQ2z8btHapvdmigSXoo205vsIrDHc4HHJf2Y7piNUaQrrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

On Tue, Nov 10, 2026 at 11:20:28AM +0100, Björn Töpel wrote:
> A provider socket still receives through the copy path, which takes
> FILL entries without the provider's ownership checks: a chunk that a
> page pool holds could be handed out twice. No driver opts in yet.
> 
> Put packets whose buffers all belong to the socket's provider on the
> RX ring as they are, and copy others into chunks the provider claims.
> Only the queue NAPI may produce to such a socket, so generic XDP and
> CPUMAP redirects to it are dropped.
> 
> A device may place payload at chunk offset 0, as fbnic does, so only
> the first buffer of a packet keeps the UMEM headroom. Such buffers may
> be sent back as they are, so only descriptors with XDP_TX_METADATA
> need room for TX metadata in front.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  Documentation/networking/af_xdp.rst          |   6 +-
>  Documentation/networking/xsk-tx-metadata.rst |   3 +-
>  include/net/page_pool/memory_provider.h      |   2 +
>  net/core/page_pool.c                         |  34 +++-
>  net/xdp/xsk.c                                |  82 ++++++++-
>  net/xdp/xsk.h                                |   5 +
>  net/xdp/xsk_pp.c                             | 165 +++++++++++++++++++
>  net/xdp/xsk_queue.h                          |  18 +-
>  8 files changed, 304 insertions(+), 11 deletions(-)
> 

(...)

> +
>  static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
>  			  struct netdev_rx_queue *rxq)
>  {
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1bc42c8902f4..b9464b917a88 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -156,17 +156,24 @@ static inline bool xp_unused_options_set(u32 options)
>  	return options & ~(XDP_PKT_CONTD | XDP_TX_METADATA);
>  }
>  
> +static inline u32 xp_desc_meta_len(struct xsk_buff_pool *pool,
> +				   struct xdp_desc *desc)
> +{
> +	return desc->options & XDP_TX_METADATA ? pool->tx_metadata_len : 0;

How is it related to this patch? I know I trimmed, but I didn't see any
references above to tx_metadata_len, only some documentation bump.

Besides, the amount of branches introduced to existing hot path is
worrying. On next revision, could you provide numbers from xdpsock before
and after this set run on existing zc driver?

> +}
> +
>  static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  					    struct xdp_desc *desc)
>  {
> +	u32 meta = xp_desc_meta_len(pool, desc);
>  	u64 len = desc->len;
>  	u64 addr, offset;
>  
>  	if (!len)
>  		return false;
>  
> -	/* Can overflow if desc->addr < pool->tx_metadata_len */
> -	if (check_sub_overflow(desc->addr, pool->tx_metadata_len, &addr))
> +	/* Can overflow if desc->addr < meta */
> +	if (check_sub_overflow(desc->addr, meta, &addr))
>  		return false;
>  
>  	offset = addr & (pool->chunk_size - 1);
> @@ -176,7 +183,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  	 * (pool->chunk_size is ``u32``), @len is guaranteed
>  	 * to be <= ``U32_MAX``.
>  	 */
> -	if (offset + len + pool->tx_metadata_len > pool->chunk_size)
> +	if (offset + len + meta > pool->chunk_size)
>  		return false;
>  
>  	if (addr >= pool->addrs_cnt)
> @@ -191,6 +198,7 @@ static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>  static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>  					      struct xdp_desc *desc)
>  {
> +	u32 meta = xp_desc_meta_len(pool, desc);
>  	u64 len = desc->len;
>  	u64 addr, end;
>  
> @@ -198,13 +206,13 @@ static inline bool xp_unaligned_validate_desc(struct xsk_buff_pool *pool,
>  		return false;
>  
>  	/* Can't overflow: @len is guaranteed to be <= ``U32_MAX`` */
> -	len += pool->tx_metadata_len;
> +	len += meta;
>  	if (len > pool->chunk_size)
>  		return false;
>  
>  	/* Can overflow if desc->addr is close to 0 */
>  	if (check_sub_overflow(xp_unaligned_add_offset_to_addr(desc->addr),
> -			       pool->tx_metadata_len, &addr))
> +			       meta, &addr))
>  		return false;
>  
>  	if (addr >= pool->addrs_cnt)
> -- 
> 2.56.0
> 
