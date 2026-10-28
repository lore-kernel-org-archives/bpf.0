Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793185753;
	b=vDxAB+veO9PXibG5ysRSKBtnBPCTyOs8KWl0wwVhmVR/jsYbzUKs8Mvz1wzvrU+rnJl5
	 Q5KHs+ptD6RmoeG4ukTuAMmnCZCksw6iCSEfeEFy5uL/Q++/DfAJNTLAcKGp4EJUUbXqO
	 xrXmQXwt8bSszzrzWGobqjaqMQzQlfyvYQgSv3gDHFZul0TLdzaLWHAXmICKOugVsYFg0
	 M5H1byZtVXuNYn4eYRW5xX0NP06JxwzIvbSlQZU/RJxcLG6FFNbSGpZcqjzN/SHxiTub/
	 AWbZZF9QxGO/czWZci0j5qeS0bnk4PNkNrCDtjdkoLGIiAXo8C7Jm1hw40+fzamFzrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793185753;
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
	bh=6PD7tb8VYR4og3ubdSCjm3CpYB7Oa1u4CeePMjqVi6U=;
	b=FBR9hbekUbyLBjrFLliNWWlvxL9+SCozBD+pEEI92UdEQ6MjJhrfDYkYCtaldCxlepxO
	 wyOS6oHdX2m4YFJoaYxu5DJQi66ZIaoiudAF60nEJDaMYO5P3/tvTUud7q/03L0cwhwsn
	 3aLT1WBNPHEqUXFynmFm8dDlLHSlwwZi8vAg9jCEO3xs0ISrsGNmYqWWa49pA2tG2Z5zR
	 BzR8fefB5FgEHnIx8xJrzA4VywVuzqd0lVFYlMg7vsynGW8oyGS8RXzOee+oEoTYehBnW
	 VCYbVQ8khrVnxW3baUsL9pWPZrVcf8QSh1dbBU0OGjaqXD5ULUJ78XPjzsH9Dluucmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="NM/BdDy6";
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580E606A31F;
	Wed, 28 Oct 2026 11:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5580E606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NM/BdDy6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793185751; x=1824721751;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xCd65ZRLvtmcM8c8qZybZNVhlhGUMKQTOtvyyCJw3yM=;
  b=NM/BdDy6q8qLzsJqG6xpg5lElA+3KKoHdG5y325cU8d8Mn8bYp1iReNo
   AjYIq0/erDiUB73YUuCBkq/LF0CnnAFVk0BET63KP1sgJGxLAEryfXIU9
   26TSN/SuGpJ9pdZ88mv93pKVSadVvXWxwrxyUiN6quN7s7n6BnZvFE8RQ
   J472+Efl5AUewvrHlcKXyaQp3y+QXaNA56zDpJVQcZZRGgflgsNdHnEYO
   bezDTtJK+4QiMRUdg8bzdYXEOTn4wR1PPXKhncmM23uOqC7Mw1TTZcnW5
   vMf2iLlLjsi2zCcRxP6BmeC0ZInv71VRsENPAg2OAB1fAvReYpyKacVGu
   w==;
X-CSE-ConnectionGUID: mRY01XtBSfaOORnJRYOG/g==
X-CSE-MsgGUID: zL2NOkqZSVi8x3S8KrxVSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1795170"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1795170"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 04:09:11 -0700
X-CSE-ConnectionGUID: neXZsLDUR0C8uA9nrd4Tew==
X-CSE-MsgGUID: Ec6zCP1vS9WS1cl8HQe2Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4845345"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 04:09:10 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 28 Oct 2026 04:09:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 28 Oct 2026 04:09:10 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.62)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 28 Oct 2026 04:09:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AghKL0JzXZwf2odGD6ZArYdk0pUt9+s8Ofo4+NNrf0lTLh9Gu4qlmJQ7I6YM03dA6gZAbVMYnroWSDZV+PDEVizJ8kftl0K7HeGoavKx1taCi1rGcoRIAOoni4mDT4OX76PBImF+6SKS1a3hdt5FteLt4kK6le9oB87xae6udbYZ1aTZ/sNaINWFYKBO+iw6Cen1jkB8Tus5nDkicPrYEVAPb5Hgto4zH8AaivRswPfBXYiUJVTUzMdF6/s2Ul1FW3YKFh/n/gqkcCeAdXsbbBxZrWgT7aSRerzQ3+8NSlMqE5j90mvQPrV2OpluUrpgrU5iRnB7LZkTwK+IdJWmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hXH2DN/nHMjZWMb7syCov5lrUpgv7mPTFPSxEEXzpc=;
 b=FTRHM/n+XyRWSAPiFZdWFELu2Phlht1Cw3lAGuTQlEscZHxfbBqRHXjj8j8v8cyLmPZsZGf6kF4C9iaID3uPeB4H3PMN61Y9Smm8nrYdt89d3VvjrhvnmaSMNBo8hHDAfjHAjory5TkwuNzhPqObCn+24+hfImcw/rh5EZD7QYvslByEYjhHVLhZnPqReqpQFOK4MVu8Zx4BAOQxMztIzWAXNjB3WEzvdMYbKhuuvmEsESUJp/DVhB6nUVON7sCsSssmDV1AGcnSZ4m14jfwf6KpmOHh0+k2wDPcUakthvYp8Mre6ZuUTWe0OmyDnCwSj0fXbD+yjiP+9/n2ZXhilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS6PR11MB943645.namprd11.prod.outlook.com
 (2603:10b6:8:499::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 11:09:07 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 11:09:07 +0000
Date: Wed, 28 Oct 2026 12:08:56 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Marcin Knap <Marcin.Knap@vecima.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, "jtollet@cisco.com" <jtollet@cisco.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <auHXyG7M0UGtia+j@boxer>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <atddQ8qN/R1tU1fk@boxer>
 <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <87ld7r6xqh.fsf@all.your.base.are.belong.to.us>
 <DS4PPFFD8A841C2FF8203BAD3C773A7784D806F2@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS4PPFFD8A841C2FF8203BAD3C773A7784D806F2@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
X-ClientProxiedBy: DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS6PR11MB943645:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f35ad3e-1eaa-4c85-7945-08df34e3e2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|11063799006|56012099006|4143699003|261009223027099003|10067099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2Je5J2LcrOYz5euiMpru6JCO/J2nsn18yfLucA2xtQa10YMprO742uYUKV3foDk6c9ZdZ+kAiGOV6ZPUHjIzjAwz/j28pl3SQ/8T4ZKo45LuS2y6dbdS7YW9FEyBSfhWPWqiCj7/RDFCR0CratUNBlKV8JCQNHZoqAUb/zeZ5PKFO6t8hWrwR+ebvJPDoIwnADwWQ/iu5W2ia/ede01fk2EjNwf+K0a3Xh983UgOyDH3LPJrZ9pdhaM9voCinfVEcn19pmyKyg9naGtcDkoaqVfn0smxwvZasIhee48wqUs+53WNTYVR/awVwrEpeCFVCLgR8yJvOl4vihk56xi+qR1SGiAUcW1PsvjC5z6NSkLXFTi177GHlFDcFixtt23Fy9zF3MeMTuGF0wHG4PvqmQMQhHz5xxMZc9uYvnmNQCHzjuGiiOzjHtiirVUPRoW98Hhad7F+mtVtoBawkD4TMu6inSxeFGTSXabM31MIVnprx8XGb3ZxFnChsA26qQ3yEi/q3bT8UzFsvRfl6d+uDhVRi9g8muJAUEAKkpB8U/HsrggpesyGw+rMjDHTKBpiVAkEz3+tvGPbNKbIRQJ9rd6RoQEjhrsPzbMCUOTop+/5y0k22mM0UzJTMGJduffu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(11063799006)(56012099006)(4143699003)(261009223027099003)(10067099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mv5D5wlsdHiRQ3dMtZs+8ZosC93YvwZLf/kiu21EKxjoDYodbB1YOQJRFl?=
 =?iso-8859-1?Q?M//F1XzAPGYzuWE3uq8h5owEUfR5JEuYX8i9aqx5Hphkyhr2vRUGH105x6?=
 =?iso-8859-1?Q?cz1K8Ti4xysyNFaa0Q83gFjMnZzvMdVQCIlllXGklyRxhF1JYtMzIcolpI?=
 =?iso-8859-1?Q?pzFWJ3h7gMmqysXETZNa9j8J1PfmICZdh3BNx8xQwLyKeYUUyTZuVJERST?=
 =?iso-8859-1?Q?0DegA1qCTNrXZa7CCuhsNJNNJOEDoehAoH9ilquCX4oJxvl8gQyiGH0lyj?=
 =?iso-8859-1?Q?eAXPNgNA7L9OKOTNEwPOtbE9P2Tb5XAle7/1gMoQGv3eOFM7YU8ea6HVGo?=
 =?iso-8859-1?Q?U5a4VdQJ/VidettmkOzM+/0798VcMpYDeqwzjmtkog9hs3R9e5f+TwnMxd?=
 =?iso-8859-1?Q?mVSqwom+4qmplFf8fgtdbEK7JcztwC4asgAgzuEMqWj88ZQ/bph2N+lsbg?=
 =?iso-8859-1?Q?4A7CSZymjqxKaQxDO0SlsL6jOS3P+E8OAeU/ukwTy8HZ9qPXq83fY1y/FK?=
 =?iso-8859-1?Q?VCZ6Gad8KJsXr01T/dh7VAyg63IoUYCVyHt0kfKM7VAkLvL3clHHzfNyGF?=
 =?iso-8859-1?Q?Jfv6iie9gi+tZu78yYdT8lXVtFGb2dbg/ElvX/XqSGmgQVmVCcBKeRGTmg?=
 =?iso-8859-1?Q?Sn7stb9AuGAi/QmPj3oJ1kUWprvONyw4cPqmGNoQ9xvBxItL9Y4DDYFqUj?=
 =?iso-8859-1?Q?EaHxH+DPA+O6q35wxslQfYaXgJT5N9TpVZpM2UAuz9dKM7p5jaDQqtIOZp?=
 =?iso-8859-1?Q?bMTWGVgT+Sqn9kYrcjMDivarE77AuI5jKBRuF8b8jFNWv6QY97+bcgySb3?=
 =?iso-8859-1?Q?mAi+lItx4v7EVbAgswGtP6I5yAx0grk7gtfdrZhBtgfbAXl2hhPqB6Yfyz?=
 =?iso-8859-1?Q?E6rBKAm2kv7AbLfcLUbOjQWd7BTa2+yYtIBVQAWJlUoYEl+C3xhZGLYnQK?=
 =?iso-8859-1?Q?ylf+BAdvVStuwQ3tb9V9kCgst5T1eMgCieHSkNvq6MZZRdobg1OTe3102M?=
 =?iso-8859-1?Q?B7OBV7ym0blpDZVrIhRo1FOBHbkuZmdrlChgzTocizTktp5ARczQQW4ePT?=
 =?iso-8859-1?Q?hZ3eJnN+evVaAn+R5mChZlGn3hCwFHKzdmadNQrnr4qxc6mm5ohK6NCTDV?=
 =?iso-8859-1?Q?JT1bIxyvxLgsiLjvowSoO9UXrlBuRJthyFGE9n0oCRevtUfSs7i1Rh67kW?=
 =?iso-8859-1?Q?E6QGeyU9yvYblSUQrNSVvVzlIdTojeEsEoSGvjtdHru8L+bC1hU8j/cayJ?=
 =?iso-8859-1?Q?Cwg3EJrr+EAqcsT8/Gp0uVdg530U7nBg989vWntBpXi7QfRdecS0dZ0fWN?=
 =?iso-8859-1?Q?7lnrUkxAZNkfTfJoRQRKmu5ab9bVuRuknJPzu/FkbKpQePOEIqf1AVPj5M?=
 =?iso-8859-1?Q?gGoilqpE7c/OZX1zVuv4O+DCyk21Zz5fNS6fQduwlVr/07MQRIcFVmqUwY?=
 =?iso-8859-1?Q?R4f4SiHWT39gEY2L8v+0HMGvW4j3Wq0Nu9WWdIkYnx6NDqxmG6vaK2RN9r?=
 =?iso-8859-1?Q?fzMusIPrkMCXdUnRz+atGf5mRM+UbiZgaFuFhm6kAsCOz8DkcUOg3DjdTC?=
 =?iso-8859-1?Q?TnlPglryGy7QqczQqNNL2RHPyclkprt+5tZNbrkKFWc/KRZCz+7ZICu1ec?=
 =?iso-8859-1?Q?ldHW3mIE6QuMOsRuqLPB14gZZHGK+l23kVcN4IfjzfpLt1RdUj4DIZzyTw?=
 =?iso-8859-1?Q?t9oKDPjhKWag5jqJGyIlT5hqO95kFpTZ7Jl5bmhy8yNHXdIixZcXKJOX/O?=
 =?iso-8859-1?Q?1Olsdx/efkm7NMy6JwQEEP0fiABlGDfnpaSX6F32F8R+6oM1GGl6kZS/WI?=
 =?iso-8859-1?Q?OywpuMiyYWMNgE96wyMWpdhTuHl8pB8=3D?=
X-Exchange-RoutingPolicyChecked: Gk5MG3RnfyVAGHQ/Ty1pvw+9TUAEYkETT4mdhFQiArpjCaww5qBpCVjwNbzpG4B0OrG5pW5AGsKLBhp674qIuwieR1B3+qFqn3YpNiixzAUyb95U3dKazwMjDsf2zrBYlnzp9pEiRIy+emfF9IJXxHl5M1q4K9+9f9fQtQbl9Hc72qxNSrH8mtkFszqDqpSZyX8VGSZxUF0b7k2DOuzUPGygOPKQQM61Ba9c8GSCOzw9brwuMVFK6p2vUgldWb8gJq1TsCoSpJEj3UPnerCDDlmKagQ2GJTg7rI/Bima6zKKeKes5sMjvf7d5Z0N/wrSHPH5OoJ/EgEWtNRV9ezmZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f35ad3e-1eaa-4c85-7945-08df34e3e2c7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 11:09:07.7823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ib2bsS6mMeIjMBkqtz6BQBXOC3s1nATu3jFyMOXqIdPbz06nOjpWWhrPcBO0yiAGYgf7WtyxQnKZMdPQGWjt/5RcLRqTABsUtQFrxrExVko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB943645
X-OriginatorOrg: intel.com

On Wed, Oct 28, 2026 at 08:40:06AM +0000, Marcin Knap wrote:
> > Marcin, FWIW, we'll discuss this topic on the office hours today [1].
> > Feel free to join! I added a link with suggested wording for a future
> > doc [2], and asked an LLM to audit the drivers [3].
> 
> > Björn
> 
> > [1] https://lore.kernel.org/netdev/aqPxxX9MeGmAqGy6@boxer/
> > [2] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2
> > [3] https://gist.github.com/fb-bjorn/181786547c4dd8182ba09e23cf394dbe
> 
> Sorry, for late answer, I couldn't join last week, I can join today if needed.
> I saw your audit which is very descriptive, that helps with understanding it.
> Thanks! As I understand you would like to fix the drivers ,which broke 
> the R2 handling considering RX Ring Full rule.
> I can send fix proposal for mlx5 driver. if so should I create another patch
> from scratch and link that conversation only?

I believe we agreed on making drivers responsible for releasing buff, so
full audit requires addressing existing -ENOBUFS-aware drivers (intel),
removing release from core and then teach rest of the drivers to handle
-ENOBUFS properly.

Basically this is what you initially proposed but with bigger driver
scope, but maybe for now stick to addressing drivers that Sashiko pointed
out (gve?).

Bjorn might be OoO today but this is what I had in my mind after the
meeting, without revisiting the links.

> 
> Regards,
> Marcin 
