Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793364972;
	b=Lb0qSXp6WKGRT5u6hBvC7kDY3LAYKIB70AaS2PIVQhi8f7kN3h36EnpK5914IWRBZZAW
	 kqBiP+Xdu8F1hV9fjXR1W0mwK3bBwgq9JVRMRNmJwvhM94ScHxAKYD/9fuJV6uzIZYD9H
	 s5uAG4eB+8f77pAf6GgAL5juCzq6+LG3z1BeAjgceGpEa51Sipvy07UzlmfOfDGp18AnN
	 lMrje9AUrpbKUvERtXgkl61dEZfQjQMGMoy8oARRSvlinOMX0JanvdVxfu7c8xpEu717Z
	 piCIxTkIgZdh/0leJrrik46tJB1nCQ/ew2//d+PQfAP0VBXU528e7du6lp9b/aofU6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364972;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=ixnkw2YuQUO/qFTX3LTZgYc37xCfCj+bFadj1p65HqY=;
	b=OKNT37hsAnBiApH+lm4uKoiU1dskHV4YFy9WU0KNLftsNb3xteXJaxtr9LVX11jwP0Fa
	 wReYUZurciFyxC5LpXrOywsZSEo5J4+gpVwUlXCQ4UkRPANkr0ALXowrGymTED1G4d12o
	 DPZQzNuMSxwcmkSBREfOKtuPhcq8ZYKxAszrLH3DonU86YiPviVWVEUD4l1SAgadnksQd
	 VwfIMjNp62seWt95fdCVJ3JIkXSFao7C4qBipeP37czyy0IZrhKeqLOb2XLxeFZkzbBC1
	 z4X0QvlTFZ5T9TsNNqYvHkUrYRf56uLr3acSDwa8EA3b6WssQYSXN1BYDIVfmo00Y+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbZUbHIm;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD4606A31C;
	Fri, 30 Oct 2026 12:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EDD4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AbZUbHIm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793364971; x=1824900971;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nL/trGnPA8DATXw6SITcqpqV7kimCGqvjJaRFrGj7Iw=;
  b=AbZUbHImL9mu9/0wieRKrWamtLmOtk9o1GdvgFpoB/JSIIY3xd4KENxh
   lvZbzzPzCPHD0rYwLNpJTcp3IEn77I4vh4ILqNNlWIoCnRZbOmWycNilI
   LGtwKuVqJBoOXDe64XnYTLaLiiskvG06r2bWF+BMOhPIsPJVcYGORDHzq
   RwEXu5WWJ72ZSNxXIxhpcFT2mTyNIEGDG655Y+tEaNyCFzqeduI/r+/am
   ZP/jGeT1PLCVZhBgWANQ2t80Nr6Di8n/nm9fYEUEBA40NM2oJDggetozv
   e+Qi29mvcLYwSADMvgZBH/x80mNQaZ0JXT9+E+oCvx6vz3DTgWYdQpi3I
   g==;
X-CSE-ConnectionGUID: vhVyYEF5Td6qxVe7hXHsZw==
X-CSE-MsgGUID: gSYWBBjWQBWVbr+D6m8gpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2027808"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2027808"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:56:09 -0700
X-CSE-ConnectionGUID: 2CM7Zg1PTzK9CImulj29AA==
X-CSE-MsgGUID: jcjyhNzNTVWhASpHa0DbNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5527957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:56:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 05:56:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 30 Oct 2026 05:56:08 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 05:56:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+XMmrvAE6PC2d0ZdA/xTAEYHv8P9dNQXAUOnrCiNXuDwoysQ40A/I64rxpuE6Fe1agSkjxzjQ646OqvaaXY2ooIvNaxnwSxyShnzFPZFHFp1lwYh14NdtKyaPARQayO58cKmBzONz0YCRedPjMN2hQTHzbjkbBKuE2klqRad8C43mjj++ndz/vLcBEkVFhdREKaJrQNZPLE5A7c6+7REu0n8WCMtxRSW7pGV4urXfWG+DJdyzvdm0+injuWgXanmtMo/nnxhxFPnpSv7UIqA6pKlCit3pTF914HC2O43OxP8VppwY4su7/gb9hDZblXNJcNYlw/qBbHRAqeyaRXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaqtrybplklUZX9BIgFdWdzOxYBiBwbBAdbjzVkdPYQ=;
 b=UfjCbraDrf5nNJbChNc5PZ4Nf+c1P1tD8v57xsGqhVj6Nuqo1TOu62lP2PkodOxBbXNT56ypFS81ItuXXmhgW460ny6VVZXeNEXqFgOA4ZuK9KpwCQiBiskdig64g7WpRe5dkEbV0Y1b24AFZXsbCvci4C1Hocy3wrVyLbCkat7kf5FVKbklEaJwh6ZFAK5JE8OswnD2P0EVjKUbjwPX1x0eAI+CTFb0wKSwIYx4ch4dKUCVGI8SonfdHsUDuukkl7PASGTSEkXt5e4oSHdnTVJ3Mf6DxaMEMb+kO4hCSAsYrnhEMmZ32NM6OhUMRZ5UC9Paztk/MPnwyPQL+QBlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA0PR11MB4749.namprd11.prod.outlook.com
 (2603:10b6:806:9a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Fri, 30 Oct
 2026 12:56:05 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 12:56:00 +0000
Date: Fri, 30 Oct 2026 13:55:47 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <marcin.knap@vecima.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, "Simon
 Horman" <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, <jtollet@cisco.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Joshua Washington
	<joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, "Sunil
 Goutham" <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <auST0y4PEYkdewpa@boxer>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
X-ClientProxiedBy: DU7P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:54e::33) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA0PR11MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 784cfde7-4153-428e-4711-08df368525ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|7416014|261026121527099003|261021135927099003|260925021311599003|260925022911599003|11063799006|261021121427099003|261021123027099003|56012099006|261009223027099003|261022105027099003|261022115727099003|260925021911599003|261022075727099003|18002099003|22082099003|261026140227099003|6133799003|10067099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: TvxoAis1nMu0APSzhjtF3pAerCAVBvpKbGLXGijCakCor9CSF5zuFk0DQyq2zKt+QJCMfIkdyF+MpSIzE4rzUxapB4rPHA4LGQxZVC5Nat6r42xod7imimfQCvt3fSpv/cMaydxCIvQA86tXvk78yqyAE/NtNTnD3HsOKONSkWLb773F7pdhh0L+pHmgtmbpqGh8s7G/xqqLP6YhXJYZ0HvaiSGZUKCa+upmEF4ivuZXc7yreqEr0ovek0NKFwQZQokVwuEpc1pc/xOqLvWj1oAgSkO+2LxDn5jkkxR3kuxwrcmXWtsdiej0lGB2ktsV9x6ayD7qxSRhRpA1+GBKyZAUGx7ej3S4iueb+lJ2rB9yWiovMOq7HUwuU8PwpvYd4e6Z62KBPD5fw2+54/fRqtXwtdN1gG9s69Lh16rDaAoBHl5640tIrrZkDhTVoKM4cCh6vHsPEbaIYcGNmkQr9Hw9CnMufA/ZNMNn0eLT9dYOLnDZy4Xees9Zn+TnXrvRMrIrI3UvwTI8lvDOQTiWphLXLys5HYoAhFXnBezYmD/ZxPAG9iMAJ0su38NwlYRKOemiIkok173sT5sIyR3pntC0QoyNAiflRx4be5UskVs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(7416014)(261026121527099003)(261021135927099003)(260925021311599003)(260925022911599003)(11063799006)(261021121427099003)(261021123027099003)(56012099006)(261009223027099003)(261022105027099003)(261022115727099003)(260925021911599003)(261022075727099003)(18002099003)(22082099003)(261026140227099003)(6133799003)(10067099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?OOhcwA0zSEhWQib1a/JkElRWy8T2AYSInnOw1eAIUIXLeYaXUPIlcYLzz1?=
 =?iso-8859-1?Q?lqZBHdIEHRUD5A9v+oE9d/CLD5BU8LCSnsZUHtDciI/Axnu+9TSvbIlMwh?=
 =?iso-8859-1?Q?Wjcz6mbv2VelgE+8bOrPlUbGfsvj1oc3Sm1SE5gtAdNciM9jA6E4MkOy+W?=
 =?iso-8859-1?Q?U35+KRxo2C+WENh3ojD7T72nwttpMLK4XjW9RGxavhHjc3sIZYcY2yne39?=
 =?iso-8859-1?Q?z6pmK9ZHjNapN+i+/qvgHunQbVkUlrzazKp10Mtw+ESauwB2h9KNKjZCfx?=
 =?iso-8859-1?Q?GrBvNjbqvxG2QxSndLYIZFbThxvvVT7bRk9M60Ve2AxKb5xWQ+CW2Ak88D?=
 =?iso-8859-1?Q?IO0/9JC8fxPwRziC5cAkQqUPJn1Nqh7SvYa36GWR9t7Z3+LuJbIqcYjyap?=
 =?iso-8859-1?Q?cQUv5uyo1cgQoZbSTZmf/+yU1O1bxA6jKu1l8wBMVtigzzmZdDtc0i+CYp?=
 =?iso-8859-1?Q?QuiLfntk+Fc8c0S4ZIA8tZ0/WaYlsSfYtD3xtqiSoeaftVFhkt0EgEy2yR?=
 =?iso-8859-1?Q?7mVCokuHkKMJF5Lggnjt1ztsjMDEag8fvbBYPnCw6NnLyx2OrJw5QoZMD3?=
 =?iso-8859-1?Q?W5G028NMVG+p6CAi66ZI6ROFuLdJ6/yWUVIU8+RbxKMlFs5sURnxqpwoW0?=
 =?iso-8859-1?Q?qwEUnnfK8Fc2HeHPTIWRmsKZPcnL5D9eNSDMnVj+TskaKFpvqh2SqZU1ys?=
 =?iso-8859-1?Q?wUkAeAr3KjAHUcXrI+BnkBIpLI03n+RCnDckY+OAdhW36Zky+UcZ4nuOgi?=
 =?iso-8859-1?Q?Z1iQrLjffutuS9luPnk8adTcnRQBxTZovk/T6JN1TB4zzNKsheu8S9EnUt?=
 =?iso-8859-1?Q?LJ4Sl11SSj9R9R/PAm2bhKsvwBMFOf3A20ONgvDuAwhVjwcwThI8wevy6V?=
 =?iso-8859-1?Q?pdt8KkQ0CuFlfbNmcNpyryUXb7pCJwCqrzddMus8S/vVdFzsdS9NaXQhG+?=
 =?iso-8859-1?Q?8HJUatxAQdRDPHyEaNf1QsmQZGKgy44MBGHdM6fAVz16aQWY9AfeaMnQc6?=
 =?iso-8859-1?Q?mo8jjL0SKxtArN2p8tUgxDBaX1U8RDMDyD0WvfhU/TgS9axIAiXP/LIWik?=
 =?iso-8859-1?Q?RPso7x8zzvnyEfBB9qztLpjqDKAh71Kz7La/7qQFNY5iX3mQvP9DHrPMgM?=
 =?iso-8859-1?Q?n17L8L0N628GtqDM5YIvbiGgzbOdcjxsgfCrj78aAxkHNPtL4KTK3LFL+j?=
 =?iso-8859-1?Q?BMog1UALwtmcWmq13VUz97NrW2QXxAbF49aqYvWrEikyhfiI0rleu1AUFV?=
 =?iso-8859-1?Q?92yWglBzZbkL4MEU1UV7IzwEyoEUQUdc01ZA7iZR3H34y7ltUQQFz7cYtw?=
 =?iso-8859-1?Q?GC25qKH0AmDz5mx9Ni0khQZ1Sh8OfWqlLqwCEDvx4S9Em4U+9KyztM4/qE?=
 =?iso-8859-1?Q?cZ7VByykdpBop4D4s7dI9snUoydTHOwpSuH4g2X+v5sfhBUwkn9YH+NIzx?=
 =?iso-8859-1?Q?ommvwfSlJ6c5wgeAU+S6ETZKIxlGVp3ImCF6R9kqGfA+1V6wAYIzwT/YSW?=
 =?iso-8859-1?Q?M8uv6DZneQrQmS6m34FVvv66yBS3VP/1jkz85PGVOCpx8e8dAGKoMFHyh/?=
 =?iso-8859-1?Q?pWuymCLOdxof2j9CXfLX1gi71TCGCR8zfCE1HzY6S0cETzbuQxb2BAOJBS?=
 =?iso-8859-1?Q?FtkMqJ9b9Kcb/DlwPJ3sVc1e+8oizoQH4mJDBNyWUPnXOp/wYZ3pMmfkbY?=
 =?iso-8859-1?Q?uWtqQbDoEWGpVPAQrYSe8b+cNBsyehWwjkl771hBEQIn4T4Fi1KMnxZGE9?=
 =?iso-8859-1?Q?K0wJOFCnQ0CNpMmU6ilgSGWhGSusXKjw5PRzE3YRb0Hz/fAJoU08DrvINq?=
 =?iso-8859-1?Q?hQXGDimChuncPuAC8nmKfHeNXkNpcd4=3D?=
X-Exchange-RoutingPolicyChecked: 5ZEdCrZrb7+/WPJaIp6Fke6ibuyNslBFLhKYuHUZfK/wxMkw8tdkA+xx4PzeaNvzUpyf1tDde5dNUNN14tT8zz7hFTxVy7M/b0kNR55ic8/ITZo2P1trN77GrCQYgea+fMvCT0Kw8Hy5Ga+cwIcloUD4EoO7XTN0mfdpeTs1R+LL2qw7t2za/pOwE00NWbmA3MyvPzaZ2lWC+RSIZLEoGOWHrBqhgJ5LzoJcR72D6Ndn1J5/EFgdBDplTduzQe2FHqEa6HG8srnJur+X3M/F2ACqEqgC4Doku6r+S1z/kBqKK25ObGmDXNbu8zZlyc8+3AE9YzYBhi/BeiiyqVtOqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 784cfde7-4153-428e-4711-08df368525ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 12:56:00.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OuEayyBqUMdgco90Ktz6f8H3ikhSaXtmgKT4vBHsvB6ajI8+3OIC68rXe4jTur6DzJhMqTv1wZUNIsvioXbQwLnJUT2NPISOKCT7Vp/STA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4749
X-OriginatorOrg: intel.com

On Fri, Oct 30, 2026 at 09:14:17AM +0100, Marcin Knap via B4 Relay wrote:
> From: Marcin Knap <marcin.knap@vecima.com>
> 
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
> 
> A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> most drivers rely on that: mlx5e treats the failure as XDP_DROP and
> releases the buffer when the Rx WQE is refilled, while i40e, ice,
> ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
> buffer is therefore freed twice. It gets reused for another Rx
> descriptor, the second free puts an in-use buffer back on the pool
> free list, and the same UMEM frame is later handed to user space
> twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
> -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
> after the core has freed it.
> 
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. A few drivers relied on the core freeing the buffer, so make them
> free it:
> 
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the already freed buffer. Free the buffer and
>   report it as consumed instead.
> 
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
> 
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> ---
> Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> The i40e and ice changes and the multi-buffer path are build-tested
> only, as I don't have that hardware available.
> ---
> Changes in v2:
> - Also free the buffer on zero-copy redirect failure in gve DQO and
>   octeontx2, which relied on the core freeing it (AI review).
> - Audited the remaining zero-copy drivers against Björn's table.
>   ixgbe and igb no longer run XDP on a freed buffer after
>   XDP_EXIT; making them drop and consume the descriptor (R2) is
>   left for a follow-up unless you prefer it in this patch.
> - Rebased on current bpf.
> - Link to v1: https://patch.msgid.link/20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com
> 
> To: Joshua Washington <joshwash@google.com>
> To: Harshitha Ramamurthy <hramamurthy@google.com>
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: "David S. Miller" <davem@davemloft.net>
> To: Eric Dumazet <edumazet@kernel.org>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Paolo Abeni <pabeni@redhat.com>
> To: Tony Nguyen <anthony.l.nguyen@intel.com>
> To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> To: Sunil Goutham <sgoutham@marvell.com>
> To: Geetha sowjanya <gakula@marvell.com>
> To: Ratheesh Kannoth <rkannoth@marvell.com>
> To: Subbaraya Sundeep <sbhatta@marvell.com>
> To: Bharat Bhushan <bbhushan2@marvell.com>
> To: Magnus Karlsson <magnus.karlsson@intel.com>
> To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: Simon Horman <horms@kernel.org>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Jesper Dangaard Brouer <hawk@kernel.org>
> To: John Fastabend <john.fastabend@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org
> Cc: bpf@vger.kernel.org
> ---
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c           |  4 +++-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c             |  1 +
>  drivers/net/ethernet/intel/ice/ice_xsk.c               |  1 +
>  drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  3 ++-
>  net/xdp/xsk.c                                          | 15 +++------------
>  5 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> index 82ed5e48b00a..cc544420df11 100644
> --- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
> @@ -686,8 +686,10 @@ static void gve_xsk_done_dqo(struct gve_priv *priv, struct gve_rx_ring *rx,
>  			goto err;
>  		break;
>  	case XDP_REDIRECT:
> -		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog)))
> +		if (unlikely(xdp_do_redirect(priv->dev, xdp, xprog))) {
> +			xsk_buff_free(xdp);
>  			goto err;
> +		}
>  		break;
>  	}
>  
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index 51a05ce4c7ce..a11ee1f3fa38 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -360,6 +360,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
>  		return;
>  
>  	if (xdp_res == I40E_XDP_EXIT) {
> +		xsk_buff_free(xdp_buff);
>  		*failure = true;
>  		return;
>  	}
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 0643017541c3..7c1dd4c87a71 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
>  		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
>  			xdp_xmit |= xdp_res;
>  		} else if (xdp_res == ICE_XDP_EXIT) {
> +			xsk_buff_free(first);

This seems to be enough to avoid double-free on non-need_wakeup case when
core was releasing the buffer.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

One nit is AF_XDP patches are routed via net/net-next since some time, but
I don't know if you have to resend or not.

>  			failure = true;
>  			first = NULL;
>  			break;
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index 90af9b9044aa..6d10c132f61c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -1555,7 +1555,8 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
>  				*need_xdp_flush = true;
>  				return true;
>  			}
> -			return false;
> +			xsk_buff_free(xsk_buff);
> +			return true;
>  		}
>  
>  		err = xdp_do_redirect(pfvf->netdev, &xdp, prog);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 781ba46eb152..89bac2feeff2 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	struct list_head *xskb_list;
>  	u32 contd = 0;
>  	u32 num_desc;
> -	int err;
>  
> -	if (likely(!frags)) {
> -		err = __xsk_rcv_zc(xs, xskb, len, contd);
> -		if (err)
> -			goto err;
> -		return 0;
> -	}
> +	if (likely(!frags))
> +		return __xsk_rcv_zc(xs, xskb, len, contd);
>  
>  	contd = XDP_PKT_CONTD;
>  	num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
>  	if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
>  		xs->rx_queue_full++;
> -		err = -ENOBUFS;
> -		goto err;
> +		return -ENOBUFS;
>  	}
>  
>  	__xsk_rcv_zc_safe(xs, xskb, len, contd);
> @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	}
>  
>  	return 0;
> -err:
> -	xsk_buff_free(xdp);
> -	return err;
>  }
>  
>  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> 
> ---
> base-commit: fb7bd3a2aad70a76232a7168a505386d0a1396af
> change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
> 
> Best regards,
> --  
> Marcin Knap <marcin.knap@vecima.com>
> 
> 
