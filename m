Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792499029;
	b=jlbY1DS7tdKPGN9d4Rrb52B53F9NKrkoTYKSVp0HDk+CN+tRQnavdBpIb5T/jUd1yKxP
	 KYIe31tRqPGP2NAA78gW8IqyBhoRG5W4toGZvs4Ifnydio4nrlK7esOOEllYXj60i/5Vp
	 0xmjy5x893PMPttEsFjBU7vdLPHGOGZ4Erpzy9wQbjg0FOLoSlCdLM9PwUUaKXkS4saQ5
	 ZpSNJh+Q1CuIZMdy1gmVMB6bqQxyjRGl+subHrDc0ciqib2b/N9MR/QD7FtMJg6HYdTg0
	 mTihslb7fpm6LxeSJ9UTO2pa0UWiKvbQEy+cX0zqGN2LUn+1gdGG5mQhDxteKVmA2Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499029;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=SUmpn0YWfben16HueYaCdgctiiMX1O2o62ZdOTtfHmA=;
	b=2kKgqVnnUfar8aqUsmeJgdSr3cQHEsCC88UWyYSjMBBB7pah+QNSt/zgFx7MWG0fc/Bg
	 LRexBFJQkN7lV+IEksteUaDsj1Qu3wDhj3wCQjQ3TuYB0eHJK6ZrbfchdGzYSPao5GEZu
	 CPklcfdMprJ+k8OfRaDJKKJpqwLWMFpTlkeHUESAxzoLdjx+OuEhJDs0lWib0nXXkS/zL
	 2EFYNwzGceAGnyDkMwlJ9JWf2RGMyxoIKKkI+juNQJj5v7FKQpZ9ziNOBgqDV6HtvLQi4
	 ssvoREcwYJh0BcRDa7r2cwr7268L6anLkewRNpJ5oQb++gcK97b93UZ2Fxx2DN0T1OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BypD0Ohj;
	arc=fail smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795F606A31C;
	Tue, 20 Oct 2026 12:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7795F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BypD0Ohj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792499028; x=1824035028;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=blv4KYNE3tILYoLyYQlvfSBoFAeB3+11RWjFJv7Bmbk=;
  b=BypD0OhjqyyuNNywd7zUTm/G7wXOwr+nMfqvXXPe2376c766fsGKaWPY
   A2RLfPH7XbzBfaXqJeItrSl3rzy5Thvtv0arMlVr1b0djXUanfpXTN8NN
   yPSAi8ySx3GdbBJtxz5mpeNep2M51Ij1KZs+nqneLN7TL/m1C1PxlmucE
   9B2qWz1+hC3cBI6UUvwbs/OkSrjFLamjogywfKOca0vkFCu2/CDrU00PW
   Glb9mUyyf5FINJO/7aerHqqb1uEN1P3YydiLuXjvYJbAgc+Lu0XlP0XFi
   PA32zRfgz0q18Ru4gSY03+RwAIObR0X6Q4UX4uJFUuK6vgQJS6gTiFYOW
   A==;
X-CSE-ConnectionGUID: yF3ZhoBQTxCxWP4rk2DOXg==
X-CSE-MsgGUID: BffA5xfzQri0a0qiHKei/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1213098"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1213098"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 05:23:47 -0700
X-CSE-ConnectionGUID: Ueacf3LTTjaM9g6d0Mr7nw==
X-CSE-MsgGUID: LPK/t9SsQlWcrR3HcIdMjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3105259"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 05:23:47 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:23:46 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 20 Oct 2026 05:23:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.40) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 20 Oct 2026 05:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPzzwgTazmLAMxXdgWLf0T/a5E3cxS/leRG/U4ca8H4Pw7NV2CpmepGzV/NYZsK2u+9eK+yJPG2BjSK4aHp42YNU+Z6M74EQknP8IZZDBHjpFuNDWJoAJomYv5Cd9NIwBNmf7uGXDVmFmmbGPDzVL/YjR6LG1iEb+DDsmLpVeJby7uo1SH25Oi241s/VHHOULQmstogUH+zUOvTMGgX8TyZs8jXnlnOxGqor7y0iVkm7Gneik7uZkesq2Ht2DT3bGUbiNLzGBkfmDP0ln79k5CribdU87dErQHw2oBHgYf2OWZqgfuDhyIRWC0WQDBb81W31NEuxWVSmMSjSa4B5pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUmpn0YWfben16HueYaCdgctiiMX1O2o62ZdOTtfHmA=;
 b=EwRAX5pBKVF7NdomHoN9dIFHIpDUl8Tb5UwXlMcm409V01N6nTPxmsdtP3dOgscodCgzQK+9I119xIe+CjzWPqzqGvnvXDmu9TE/Ce2ptZx2NfVF4JGac3OGIrF0GPyhfohLJIsiIUFtnsugd6sN/XH91pr80SB9r6yJnHBBGW0+Xfw8rYn7wxJuQl4LuviKHGomkgVDKlnDGHpgWITxwlGUCW4BRVn55MmHRDT0bO0frGkXipbZ+ZBFxXLIDxoCIVd7p8jwZP1X1tGDCsklaiP5R0PKnN3UwC8Jz9bDNefUZP4ef19I/mbGMTnb7D8XMmGmxC08OuTD9/yAYO7wOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CO1PR11MB5185.namprd11.prod.outlook.com (2603:10b6:303:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Tue, 20 Oct
 2026 12:23:44 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::61e9:afe6:c2c0:722%4]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 12:23:43 +0000
Date: Tue, 20 Oct 2026 14:23:31 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Marcin Knap <Marcin.Knap@vecima.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, "Jesper Dangaard Brouer" <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, "jtollet@cisco.com"
	<jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <atddQ8qN/R1tU1fk@boxer>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
X-ClientProxiedBy: VIZP296CA0015.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::10) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
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
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CO1PR11MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 415f532f-5d78-4389-472d-08df2ea4fb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|260925021911599003|56012099006|260925021311599003|260925022911599003|4143699003|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: PA61MWxZ+0fgESBS/tIuF3iv7vxCB/gD96XX/SzPKTqqgc+pCQiC8v34v3QI0rNNPSh4JY4rtJEdvjqHowYsiD9YFxo+KRQMU85VB7HuxMtPnUGzv7eIBWOKk9QUQXLii/k0YSjHoiiTE+3+j5BdUJTLM8Po0hocNvZ7DyVkB8XXbSBLelVoYadwKtZHPkdW7onHKqzMQoOuKkK2FQvP4zqlA0LBQkQdQRK8cZ4sbtx3lRQ+vuIB31JzurFcnyDbyX/bO7pxp93K4eap5PY26+CqmPlz5PTmDontqubIJUkJfAHcDAM+AwRTgWGnKke6bBm+lYdj1hJTNVXvAtwR2a3U8MH5qWxgNw1VgwhwDxOPtaqB/tBgQbDuntF6uKu98RQSxuEUqYwQL6ojj/FawafAH6Ye/nm6EGaSWQeA8WFZhaV+olZuiCvXvxG+6XO9h8WShjJTNIbdzmXIlmv9w+WuXx0TebGvYknwCQKQO7gHdXv/OWX71sH6imjit+4yJEQkZWwVpbbmSSRHfRUW1cG9+EADMB8vu89zT59Aky/Pb0dXqJolsYXTw3usafNZPqFY/HVSQIf86sJRp1S3SIl/KtMSXzRyPG1g5pgOClcN7MpL+4VedeV9vLDW/QJb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(260925021911599003)(56012099006)(260925021311599003)(260925022911599003)(4143699003)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+EpWRIOxXt5aAmcYT6w1d8SRhYya0VQSGX80WybHJX0LXdTYMgr/2v/Dmcc?=
 =?us-ascii?Q?G8daax1xCu7HrXUhFIGmj0bXXsGrWF9d26DNkY2ljq26YUJDKrJl0ufGbRXY?=
 =?us-ascii?Q?4OCjU0LBnB25sdwNzCziYq6zBPxIAvuUhYlBjeofYkW/6EteDQZClifpXxkB?=
 =?us-ascii?Q?5amt4nIMJfqWKEv6fMpHdHd9H0dLqNr+vJgGSwWNdaRLINKt9VKR2pOgkAuM?=
 =?us-ascii?Q?27btHA6HSUxjagRjIIP4buorq/0ek7Kly6/gHSK5Lg6wQUwGnmdclP86CKmU?=
 =?us-ascii?Q?SMih20FF/h0/tR3UkWxxPz94aEarbltqODcq8A3utfvWvvjNpcEUy5k0pYeY?=
 =?us-ascii?Q?pq+rqvoYyFGGg2OEZaGuQE2BWdrAMSmm/GD48xUnFEo34y6QGd6chrWv3qIB?=
 =?us-ascii?Q?tI86Wi7uMG2PLoj+aBvSPb0FiQa/TyAxurFjdm+hin8YPd29g4Egs8mvMQRt?=
 =?us-ascii?Q?tq/kJ5d6o0GSS3uqjrwjeGJznwrfPbqLUm1Ee9nPJ9lU6Y9bzbUWyi/96dWm?=
 =?us-ascii?Q?2ta91dujxlo8WcNCUEDHeyYZA3LI445HdTg37QYRWS6NuFUDAj3eMoPc0R1T?=
 =?us-ascii?Q?PhA18k9ZL+Sy6GolCMdnrvfFF6FHEDxjW56vfZxuLC0rYJawwbaHz1A7f4Hi?=
 =?us-ascii?Q?uq6xOkmOewSh3aGVDwm6zNiK7LzC2+W0a9AdNUzaW9j+CmxVVspp5ke2oa1V?=
 =?us-ascii?Q?rMxKGsfWS3zcpneecYYvJoRyIG1XZaaXbDN8bSb3nhh/7YYql8+V/kBJFGdF?=
 =?us-ascii?Q?iY90PN0u/hJ8umi8qb4kTY1zMs2TTo7i6ufXgqE8bygFUgzvbi65w3iritbr?=
 =?us-ascii?Q?u08uKjFb0fIVvTa9PCFLflqB2KN3A0g4HFGUFO1qLHZUtNMMLPpHDWyzO2HZ?=
 =?us-ascii?Q?B5rIuYIZ+OoPeXvBWL1bgyxuQZY+uK8fUZvrd6U85jVAWzPuKzCa9AELM/Wb?=
 =?us-ascii?Q?J7ILWBCzpwB+JkI7l2ZEKwYt1oacS+bGb4RY60z9E9GZr5lTRFFbK8Kn9Zk1?=
 =?us-ascii?Q?LHw9OZwnoY0YO/zsQM25HrpnCLKDbiRlLT/KI+cbwiCIUub1b+b44HC/RypA?=
 =?us-ascii?Q?jLUl1ygxR6+heGzSwuIbV6xqPZHjMl7g2pakfYd3u/hJpgAOkFySULVO/qKX?=
 =?us-ascii?Q?AhLfLyxxRbaQHpR7fExV/ezb1sMCBWncuSw5SqHeEMCNmlrwXu9UlGK7Mg6m?=
 =?us-ascii?Q?T17WD3SbTpFydPS1KDD2QO1uC5Z/Qy4N/xgu8C2QeRGiJUgVRwx4BQMmxlgu?=
 =?us-ascii?Q?XJrlc8Y/zBkj89xjFRCX7FIvw0xEckiDz9GGkybKRgLXI+B2pGw8J9Wfpq5i?=
 =?us-ascii?Q?eXnPE+B33FdBdwqgFzNraWrVr2Ve12GkcZ3Jxet9bTjZwVxQViVUUYVaI8sT?=
 =?us-ascii?Q?34CFn+Ko7Ddo6McEkuuTVE0cDeCkRkK+5eSg2Y6eZj4NF57D/g2UdD9v7h5w?=
 =?us-ascii?Q?uxiqlRcmQ2U3pIzWxjTmcnYHokG7e8qe5F0PGKjPERDwF8rxdtMRGyQcpkAo?=
 =?us-ascii?Q?xAoQl6Spp8JmdMZPY/leLUlI7zJ+sT0Fxx3AenJvgqVgQFpSmO7o/vww+RUY?=
 =?us-ascii?Q?Gz93DWp/vErg3iHfm8jsPHHTy1m7CI3B374ybwOB/Zzh/w2wbreR6MusclDu?=
 =?us-ascii?Q?pXoZdV2RMWJ1eOT9ZFbnM4CnWnmj5CIOQ57fnoEwC1qI8MEOWz8JHchZQjip?=
 =?us-ascii?Q?oUJZdhpgnz/fu5PARXQVIi6DVfQ9ZJynOEGkx/IQHDF9zmQBTgDodUBOzMJG?=
 =?us-ascii?Q?P8I3ePFr+qEG3O+5ovMSqeL4HMOSR4Q=3D?=
X-Exchange-RoutingPolicyChecked: iW04w+l8BlvJTLc4e02FyJqxudqRcwW7+C3wzPo6cwXmZGCeAgvu0RE1uDvC3jqVfPCCCaID2CvlH+Gy86fTlpkn8Ha5tpWe3KEq7tA6Lvr2RX+dHuYquRAanQ1H3fPTdCkOKx7T/+6oyj9niypAblEXEW1SC+ix5caU8wQy5cHkEIJhAKvt6iNt0VJcjkMHxNh6eaMsXYm36nrWYwjhYK4pg6/NDGa1t0iLf0x8tilUK19sXg/Tv0urG1upjGfAWOxY1iwIaIFVbWFZJLeB3AZrJnHU7jjRssad1wrEFYawkBbFOwQABWmPTVz5qKX/a6HOfWpUHQ3R2qWbPurk6g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 415f532f-5d78-4389-472d-08df2ea4fb62
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 12:23:43.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDS4y4z4wK2jcydrRcPpSEAJsVa0y/efmu20L/qgT547iicoXkSVpSZ9GGt8YjvyO9CSJZnGSUYqvetNE0oW/xuNs8P+kM8anfmLhQ6Ga1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5185
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 07:00:47AM +0000, Marcin Knap wrote:
> > Sashiko report shows that drivers are rather inconsistent here
> Yes I missed it, I am working on fixes.

Please don't top-post on MLs and configure your mail client to wrap your
lines. Kernel people get triggered by this :P

> 
> > On mlx5 with striding RQ this also ended in a NULL pointer
> > dereference in mlx5e_post_rx_wqes(). 
> 
> So in my case I received kernel panic when I turned of striding rq off and the rx ring was full, but the panic itself was mitigated by the fixes from @Jerome Tollet in the mlx driver. I described the problem with linked fixes here:
> https://forums.developer.nvidia.com/t/ofed-backport-of-mainline-mlx5e-xsk-stale-buffer-release-fix-kernel-panic-in-mlx5e-post-rx-wqes/384752/5 
> But the real root cause is the problem I'm trying to fix.
> 
> > Did you verify this or is this rather a speculation? xp_free() protects
> > against double-free cases.
> 
> I verified this, the origin bug on our own was that we received the same UMEM frame several twice even we haven't push it to the ring, that was causing serious damages in our system, we need to add special detection duplicated frames after receiving frames on rx ring, when I removed this additional xdp free, the problem was gone.
> 
> 
> > Have you thought about massaging mlx driver instead of intel + core?
> > Even when that would be correct approach ixgbe would miss being addressed.
> 
> I was considering and I did as workaround, but IMO the final fix should be placed in the AF XDP, because there is inconsistency between different kind of errors, look at xsk_rcv_check() there isn't any freeing buffer, so why only ENOBUFS causes that? Maybe there is some reason that I don't know. Moreover, if I fix it only in mlx, the problem in the other driver at certain path will persist including Intel, only ZC with needs_wakup flag path is properly handled there. Yes ixgbe is my gap, I missed it and I can apply the patch there as well.  But eventually this is your call where to fix it, of course. 

ZC drivers are supposed to break processing and yield cpu to application
when xsk rxq gets full. We didn't want to expose particular packet
multiple times to XDP progs as that might confuse internal logic of progs.
Therefore we drop the packet in the core and let driver side know about
this via ENOBUFS return value.

Intel side needs fixing for non-need-wakeup case as you point out.

> 
> > A note to ourselves, we should write a section in the documentation
> > for AF_XDP that defines the expected driver behavior. There are very
> > likely more inconsistencies out there since this was never explicitly
> > specified anywhere
> 
> This is good point, some documented unification of behavor across happy path and different kind of errors would be nice.

+1 also, I assume rxq full case needs documentation.

Marcin, could you re-iterate why Jerome's fixes were not enough for you?
Would also be nice to align mlx-5 to -ENOBUFS case.

Thanks,
Maciej

> 
> 
> ________________________________________
> From: Magnus Karlsson <magnus.karlsson@gmail.com>
> Sent: Tuesday, 20 October 2026 08:09
> To: Maciej Fijalkowski
> Cc: Marcin Knap; Tony Nguyen; Przemek Kitszel; Andrew Lunn; David S. Miller; Eric Dumazet; Jakub Kicinski; Paolo Abeni; Magnus Karlsson; Stanislav Fomichev; Simon Horman; Alexei Starovoitov; Daniel Borkmann; Jesper Dangaard Brouer; John Fastabend; jtollet@cisco.com; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
> 
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> [You don't often get email from magnus.karlsson@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Tue, 20 Oct 2026 at 00:14, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Mon, Oct 19, 2026 at 10:22:02AM +0200, Marcin Knap via B4 Relay wrote:
> > > From: Marcin Knap <marcin.knap@vecima.com>
> > >
> > > When an XDP program redirects a zero-copy buffer to an XSK and the
> > > socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> > > -ENOBUFS to xdp_do_redirect().
> > >
> > > A failed xdp_do_redirect() leaves the buffer owned by the caller, and
> > > drivers rely on that: mlx5e treats the failure as XDP_DROP and releases
> >
> > Sashiko report shows that drivers are rather inconsistent here
> 
> A note to ourselves, we should write a section in the documentation
> for AF_XDP that defines the expected driver behavior. There are very
> likely more inconsistencies out there since this was never explicitly
> specified anywhere.
> 
> > > the buffer when the Rx WQE is refilled, and i40e and ice free it on
> > > XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for
> > > another Rx descriptor, the second free puts an in-use buffer back on
> > > the pool free list, and the same UMEM frame is later handed to user
> > > space twice.
> >
> > Did you verify this or is this rather a speculation? xp_free() protects
> > against double-free cases.
> >
> > > On mlx5 with striding RQ this also ended in a NULL pointer
> > > dereference in mlx5e_post_rx_wqes().
> >
> > Please more info on this then.
> >
> > >
> > > Leave the buffer with the caller on both the single-buffer and the
> > > multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> > > do. i40e and ice relied on the core freeing the buffer on their
> > > need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.
> > >
> > > Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> > > zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> > > with the Rx ring. With this change no duplicate frames were seen with
> > > striding RQ on or off.
> >
> > Have you thought about massaging mlx driver instead of intel + core?
> > Even when that would be correct approach ixgbe would miss being addressed.
> >
> > >
> > > Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> > > Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> > > ---
> > > Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> > > The i40e and ice changes and the multi-buffer path are build-tested
> > > only, as I don't have that hardware available.
> > > ---
> > >  drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +
> > >  drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +
> > >  net/xdp/xsk.c                              | 15 +++------------
> > >  3 files changed, 5 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > index 9f47388eaba5..d32c7255f0b3 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> > > @@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
> > >               return;
> > >
> > >       if (xdp_res == I40E_XDP_EXIT) {
> > > +             xsk_buff_free(xdp_buff);
> > >               *failure = true;
> > >               return;
> > >       }
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > index 0643017541c3..7c1dd4c87a71 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > > @@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> > >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
> > >                       xdp_xmit |= xdp_res;
> > >               } else if (xdp_res == ICE_XDP_EXIT) {
> > > +                     xsk_buff_free(first);
> > >                       failure = true;
> > >                       first = NULL;
> > >                       break;
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 33475b180ea6..0edc160c660f 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> > >       struct list_head *xskb_list;
> > >       u32 contd = 0;
> > >       u32 num_desc;
> > > -     int err;
> > >
> > > -     if (likely(!frags)) {
> > > -             err = __xsk_rcv_zc(xs, xskb, len, contd);
> > > -             if (err)
> > > -                     goto err;
> > > -             return 0;
> > > -     }
> > > +     if (likely(!frags))
> > > +             return __xsk_rcv_zc(xs, xskb, len, contd);
> > >
> > >       contd = XDP_PKT_CONTD;
> > >       num_desc = xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;
> > >       if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {
> > >               xs->rx_queue_full++;
> > > -             err = -ENOBUFS;
> > > -             goto err;
> > > +             return -ENOBUFS;
> > >       }
> > >
> > >       __xsk_rcv_zc_safe(xs, xskb, len, contd);
> > > @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> > >       }
> > >
> > >       return 0;
> > > -err:
> > > -     xsk_buff_free(xdp);
> > > -     return err;
> > >  }
> > >
> > >  static void *xsk_copy_xdp_start(struct xdp_buff *from)
> > >
> > > ---
> > > base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc
> > > change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f
> > >
> > > Best regards,
> > > --
> > > Marcin Knap <marcin.knap@vecima.com>
> > >
> > >
> >
