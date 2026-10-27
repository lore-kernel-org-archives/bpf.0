Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793089448;
	b=EZf2L06cF3V4iF92e8Yetq0L3WfGLsJ9Remu2U37tF/2MNIeluPBB4wzyZW41izeIxtD
	 RernC9JuldWpj16GKFDL5CX/HMJ5X1XbfdgtNpjMKfJ+7qFria56yh8TrjPMexC75Tt0L
	 sGWDt/Lj8GPaQ5VAQurZSfGFQEyHpzm3l8IDXVxbkcdTClnj1SvGFD694uAv3kf2HTBSw
	 zZgygxqfvkc9fCJ/OdtngmBdmJEROneWz+IIHXVsJaAzpUNjRZHDPXfksgw3nQyALHWYI
	 OQHvbmZf1Zfq6iVosG5otRULOwAtqXAtt1alWZrKTgahIUFMaPE4W/eLSlaveUo/2ow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089448;
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
	bh=QXXE2PW4jM89KHNNxpQyrj2jwppWXIxN1uY2SQAY4AY=;
	b=5MDEBRTAyG/uOBM9OQJK/+epHlHLxJJ2nKaYa3lSIT0h1BwFoX04hAvEwS8IgKSWYvcN
	 AsXNLBHKhIzSUFHyuH69Cntc7gLr55ZGpWDFaiy0JvqSnVImAK5iF9lFS6dUZovyLQqBn
	 4beyGdQjnuSsyhcSnueSUgM8tSRe3JKWmeYlXfTFK7O6LZK2wqRUyLKe9UN742BcG6WDB
	 dxEGNaupNK1ZKL8VedsGhHZhTMWk6FUeeo9jgCLzrsQNpIqPyzsiKCwPJsqHtCbLOe8g8
	 JG209ZEh0pkmVgqQIZswGWHkmqFJ2g874X8I6yxL0OOKuHaO1cgKEYyuqUWdvfGZ+VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="X3OWH/iu";
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C6606A31B;
	Tue, 27 Oct 2026 08:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A35C6606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X3OWH/iu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089448; x=1824625448;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aOt31QE36zuiZuyZDrw3EcQjQDJxvXP5dEKzHUVMloI=;
  b=X3OWH/iu7mPooGyzaBW/7LtgFRFW6cMTVcAcyRlB7QzdFDTZ0k4zWoT/
   J3OZHwi3s/F2Zuv58l5S1oh2hyT16oZTQC6EU32ZhvX40J7wPjVJR3ydM
   8+vEMz1i3gV1BkOSUhcTHpezSrSSx+4b59G+VDmi01VX7AkBlkM/0p68+
   tcDDAfFKR/0WeGKYCdfr3PMbOTZniPu9YHdcrrrf7o6pEtrcjcjgXUS+O
   bM3ePS7AddyZNaRw+NplHrl/Nk46D9Tq3J+0hN7Sd4DAN8fldr/zr3uml
   jJsf0A/JwkbHBxjXHjlcaSxEO+v3p1rdT7gK9QK2aNB1Lr4zMqukaNQKM
   Q==;
X-CSE-ConnectionGUID: Mc6P0o0VRuqdlcs59xRpyg==
X-CSE-MsgGUID: 9Zrk9zleRJiFI/E8zZOXfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1776942"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1776942"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:24:07 -0700
X-CSE-ConnectionGUID: RL68A9STT++a5wH4WBdSGA==
X-CSE-MsgGUID: qUVNWtD1QImp9gjsTNLqjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4442833"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:24:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 01:24:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 01:24:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.62) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 01:24:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zw57/VlbU9L4WSJRu89NyHdxdVIPemOGNmpGuBcACJLLrJVDHX33iZNE6ml1fpxekfYshg9dWOoJ4EIXLHvkG3ctWBvK2M8Ttz6vmwvbHtTCeHpumPl8/3vV7J2cMulk/fCyk3snnA5xxvtPMiufkj5D8ffic+c1IM8V0fwGDeH9dR2FuoXW9ZBS+8gmlHXvOZUV3qCGqDWt+nZdw6LVqa3k+X/Q0YEzMfvFlHzPUTWSycuyDEkr0qm8x+zNwEHAMpMemeeYJA+XhIATsxtbzl2FO6hFWtqx2Cpwi/NvJVS107dGIc+8FxLz008QRSJR4Nk6Vj+ehY7l28BeGGqekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXXE2PW4jM89KHNNxpQyrj2jwppWXIxN1uY2SQAY4AY=;
 b=Sv8r8lacAPAp6IXh7AhCdSsHCsya4Mh5cBgatC/J5GzNuu0utq9seSDeGNJzDu13nwuPpB0R48q2orPpF0JYk88+IfNtgXkZSeli3OQRm0Q/4IpmmWInFM80zQHmOkOiAkaQK/YOgdNnOFAbxeWf7KA4b7YgsIPtAp092i0wbvcXoRlkqtw23mA7HE3hm9QzALh4yA+Lh4a+Thb3nzYC6f04KssuLaQPLjggKfkMQDJQ4SQvO+zdXhXht99TeIKhFSD6WJ4uiGLPcxbeIX7HIIRAuXO75Powk4F4qLNy+T7FCH3Aa57e3TaKTWFKbZCTKJRwdHisHeV4w8syfPtccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by IA3PR11MB9181.namprd11.prod.outlook.com
 (2603:10b6:208:571::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 08:24:04 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:24:04 +0000
Date: Tue, 27 Oct 2026 09:23:57 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <vedang.patel@intel.com>, <jithu.joseph@intel.com>,
	<andre.guedes@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net] igc: track rx frame boundaries independent of skbs
Message-ID: <auBfnRqpsuF4B+J9@boxer>
References: <20261025065154.2037149-1-p@1g4.org>
 <at+t/jHczGvyXKRN@boxer>
 <XxgY3anjXL5MwVEpWmTA-tZLeDhfNvdTDJ3n_8jTLgnomanMs92AQS6-QHZyNzAi5tSQM4UDHEZyKs1sG39MrfHwma2BkaoxScclyny5KOw=@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <XxgY3anjXL5MwVEpWmTA-tZLeDhfNvdTDJ3n_8jTLgnomanMs92AQS6-QHZyNzAi5tSQM4UDHEZyKs1sG39MrfHwma2BkaoxScclyny5KOw=@1g4.org>
X-ClientProxiedBy: DUZPR01CA0281.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::9) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|IA3PR11MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 687b3e32-4a72-4ca6-6960-08df3403a972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|22082099003|18002099003|261026121527099003|56012099006|11063799006|4143699003|261021121427099003|10067099003|261021123027099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: aMQ23qkVNOcG1Jy9ZDqODSoZ3P7sQACXHlR41KuaMeGyTa1+7MzIevHbAHN154/oORS43Gqt3KvdS+iXG6DQ+IahSTp9m966R2ZHqngOB0tNjdHi0wo8+uUacZIpvIdFZCPItbEWbhhMhDuIhTP01+jE40k8t3TLQnmDHH3S5QtbVXpwllkNk4tNg8WiA3Em/HjygF9rBFeyi1HkXyWz61I9pRyBcc4auMDFq6K5dGMjftHx4w0T/+GRHfM4GRs99ShRRgOTk4OMvKX0wOhMAbG5dfhkx1XdTw4lfjUJnDj/LCJUUT8DQXdFPVZYb4vEFtdp/9QLKVSiw/5DG2ftonGEkHtv64ZCZZUKmVB8zHfLzDU/2pFGrZk/B5WV0C8rv7dYzMgi9CnTm5QybUXSTQN40mqibWzHbeetv5WXI0si+u/NOqlXZtb/Ut0P62YUWT4jgMc4bG44WnSiOsfyzDD6KNTj+Oiv6ROUMZP/A3E4S5Av9Hgt6fGNToTsVhx+qoPMgSOA2MeLUZg81/m/u7Sg6q12brdl307it2ujDis9SMf5YvPaeBf1T6RVRrVAcy/+giOzgVmhtTgv7cPJ5vbf7dqLVD9x34C0Xk1zeIzMNIgVP32iQJX1ivXxbPY5X3Fs0oPPw6Dc8zucqqtcWscGdIFYtujunDyXO7D7Hx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(261026121527099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261021123027099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qmGtO1Iutgy6ntiQV6Cbj2xlnR1H79MGoOGBObhuS/f5x2Xt+6e6pVlA1tmf?=
 =?us-ascii?Q?ouXjpq+uv8b2o24bzqFT68q6vFPjCQwIhLJpRBIMoI0r0OQo6Plqjg7D+RNe?=
 =?us-ascii?Q?GJqg1RtNm9NlV1Y4Es+OtRFeEzQ2UbuOXwMvSL9MzJq13FN/krFUX4voSqCl?=
 =?us-ascii?Q?T+rjiWDva+xzccXJcc5bC3p7B8pLcwM/ga05LqGiTiIaWvN4ek+3LfMYYK+b?=
 =?us-ascii?Q?9GmNzdwE1juU/pbiMphmt856yuNHIglNqmjoYTSMst2awK2z6oRDtzYNuTih?=
 =?us-ascii?Q?eutni2fC3hG2MWxk11BPUz6+BAslR4R2Kfxp5Hsc2SyyAfIZgTglrWNlFbY7?=
 =?us-ascii?Q?Ups4dGpATJrkqcXCDbaNyoOsD3Qh5KZECZxRKIif2e8jbpItFap3k7UHD9+b?=
 =?us-ascii?Q?01Xj7MUam32P5d7hNR/PeKAcIUqi3qM/+/HQcEVC04eckt3uuZuuo8rUymXy?=
 =?us-ascii?Q?TCRDBaXPWMOcYlNG8BNdKp4Pc/rCkDBps4eEurZtaQGYSEfzKL9t6uv2rDAS?=
 =?us-ascii?Q?lmtyv+B81NCl3/S7GnobTiUYkJlCjMl4camJPKRyUEooeLH13GkwHCEHGnfe?=
 =?us-ascii?Q?A+VfR830SQvZdHYo5NSPEqMsU5fS2D0DzvsXWTFqrEbidihHdOJL45aL2GGj?=
 =?us-ascii?Q?oOlune3BpCxKetYFJhsOAxvXYmsBbA69kQBa/HlFvgGaprOwXEaxMgKXG4XY?=
 =?us-ascii?Q?njzxfX7X6LOLq1hWfEYsZ/Fsv/sP2MqYQuUWxL+MljzUKF33MdA+Zvts1tKY?=
 =?us-ascii?Q?uxpFKafc/G44oD0/Jb9XPxFyMxZRvI0tmYPVh2KQcRgWAN1L9k1kncrw5ywJ?=
 =?us-ascii?Q?ZKCAlFZwrXnju71myV7PLufIfz5W+2ax9bhMdWgEb0s0GNn4K3/JTRMUW16M?=
 =?us-ascii?Q?YdRPMYEE0RiZKnR3qGPhWjSFfquu06QePxA5bNv/xxPFFF0DvV1iYieoKnY+?=
 =?us-ascii?Q?wPZCi2X+WV98JpdBn5yGitpDIgjSfGuNTbmWa6sBXi6WKHWhORzo8QCPZq9x?=
 =?us-ascii?Q?c4/OtJ67D5PezrklzxeLAIA3rzt4trT1qchXQe1OvsHOIbTT2k6AUpF+G6Yz?=
 =?us-ascii?Q?5uoxujhP8ZcfyTkTHfpiIriYrWlvgzpLFQaULjpD6HurJ5QN7G7orqsuo0Bt?=
 =?us-ascii?Q?hcqzgsixDf1cOjTbIcVdfdsDLQMXONb1GPIriUZQ+rRf+w02H3YCPlfi6Uwt?=
 =?us-ascii?Q?RceVAYAKhxWPM5cTsAjwOUN5uhUQd0CGp8a2tCJHRzGFhpLwQ1TNf4QovND0?=
 =?us-ascii?Q?bjl7UrIC1RXv9UEetSZ6ALGhgyz3a82plsX/9ABX9mrUic4qz8mCck0YX6MD?=
 =?us-ascii?Q?XLcvoyXU0mn7JcFxU/NDgD15za4lwBTx/CHLEQxDKB/2OLLe4TJjlBYcy8fC?=
 =?us-ascii?Q?lLeFbGswF8iaGuYxR9qs2vrMX1D+8h+A0MqH6aDML2KiaTkKw5PJQ1woWF7D?=
 =?us-ascii?Q?I1DOy+pPGbAHgf3+0Jw8ug/wgC/RFkWnEYQoBmA/BM3y4yGwudnfgAAABUnQ?=
 =?us-ascii?Q?oW+NIo9PTaVeqyRiWaRKsZJqFsrwOatLt44EyEwpuPou5qvWbIYcKQhSmL5M?=
 =?us-ascii?Q?pDHhg8ueljrF9jK89NlW0K2aHBUeWOq+7++t43A9T1vGc7jb62SBNjrIMik1?=
 =?us-ascii?Q?R4a32534H0WEhG5nano33BCh/9lnsYESLQZPD/egiAGzK+UBfo6p9v1tC4ZN?=
 =?us-ascii?Q?gh/yUrGGqnNkVNkgJ+gA1nXMQfS2AwPZyau8bYEe3M7CWZHpOroMrwN2h+Zg?=
 =?us-ascii?Q?HcxnLAcNZOqY8Js0yaBuZNsBBMLMJww=3D?=
X-Exchange-RoutingPolicyChecked: duWaQtPrfB5BrCJMsEt+eVMF2RsYVmO6FiRWMJg4ppeqolz5FfOT8jP1zFTukqfG8tRmCKBaDJp39n2Wr6aSBM6l2lR7nhvDMSCNw5Wzqc6aPq2Z7jVYM+m2Uhh3+vOYnf268cZ0jKFOZcyuKrw56ZCkB/zaErDXNyIwMn01ljGP4hgccRoTc0+22HINpn9pzdeok3Nx1+i2q52KjKW8lfIIcd1kG+sGX6JyckEEmstQ0jeHzvUfOX8tt2Of/bk2PXhNheA0BaklGhAjEk0JU9eJvAMW25HNmxPnJJnB2d6fpMzF7jpLGk9vFwgS/TifcSXFeegu+1FeXg1gwH5BEw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b3e32-4a72-4ca6-6960-08df3403a972
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:24:04.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Fspxl7K9LVFivmTxSGibZojjs63tqlVAUMziLHbeox1xvfIqDWNJM7ZUpQJgcF+nsj62xud7YZM1JN6wPoqRUjKG54IbKEHab6A3ORYFkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9181
X-OriginatorOrg: intel.com

On Mon, Oct 26, 2026 at 10:12:51PM +0000, Paul Moses wrote:
> 
> 
> 
> 
> On Monday, October 26th, 2026 at 2:46 PM, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Sun, Oct 25, 2026 at 06:52:06AM +0000, Paul Moses wrote:
> > > TSIP remains set on continuation descriptors, but the inline timestamp
> > > header exists only in the first buffer. Stripping it from every
> > > descriptor truncates split frames and can underflow short buffers.
> > >
> > > skb ownership cannot identify frame boundaries when XDP consumes the
> > > first buffer or AF_XDP uses zero-copy.
> > >
> > > Track rx_in_frame per ring and update it as descriptors are consumed.
> > > Strip timestamps only from first buffers, reject unsupported split
> > > frames before XDP and drain continuations. Account discarded
> > > descriptors against NAPI work without counting successful RX.
> > >
> > > Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> > > Fixes: 26575105d6ed ("igc: Add initial XDP support")
> > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moses <p@1g4.org>
> > > ---
> > > - This supersedes "igc: only strip RX timestamp header from first buffer"
> > >   following feedback from Simon Horman, Maciej Fijalkowski and Sashiko.
> > >
> > > Changes:
> > > - track frame boundaries independently of skb ownership
> > > - guard timestamp stripping and drain unsupported split frames
> > > - cover the AF_XDP zero-copy RX path
> > > ---
> > >  drivers/net/ethernet/intel/igc/igc.h      |  1 +
> > >  drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++-------
> > >  2 files changed, 64 insertions(+), 24 deletions(-)
> > 
> > Hi Paul,
> > 
> > I think this implementation went off track. We should make sure we *never*
> > enter data path for XDP/AF_XDP multi-buffer scenario until we add real
> > support to it within this driver. Now you sorta handle fragmented packets
> > in data path.
> > 
> > I tried to argue with bot reports that it hallucinated for
> > igc_clean_rx_irq() content (which was concise and to the point) and agreed
> > the AF_XDP should *not* be exposed to any fragmented traffic, which should
> > be addressed on HW RX ring configuration side, not within data path.
> > 
> > Also this should have been a v3 with a link to previous revisions so we
> > could keep track what has been changing between versions.
> > 
> > Here's something that would address ZC fragmentation issue. Could you give
> > it a spin on your side as I don't currently have igc in my setup handy.

[...]

> 
> Looks good to me, passes basic testing, and I would rather you/intel do this patch
> 
> For posterity, I did email Tony with handoff notes stating I'd rather not do the 
> xdp/xsk/af_xdp/fpe side of things, but hadn't heard back so I kept going. 

I think this was within the thread where AI hallucinated and I stepped in.
If you are not fed up yet you can take your v2 and the patch I added here
and send this as a change set. From my POV it would be better as you have
the HW to test this against and ironically my igc card went into
/dev/null's lab.

> 
