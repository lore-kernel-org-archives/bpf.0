Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793089174;
	b=uThxRR37MvxyT0Kxw4b3SiMyxbygHcyBJkU1MTfohP1ZjSCQ/ii+Z8M7d4EPwWqhUZsl
	 kj1By1Acu4JNmHvWtHgxO4AbgzMg4O4qdQZNZ6V6IN1tFWqUOFmUPuCCE12tBbtzFKyS2
	 zvPzljTrdywnk705D5iBfzt2YRnzAOqAW7oGqmdMpmK3b7wm2x6CENTeFQ6BCzPMft8lJ
	 Sq0y26/OZfmxPpquj0tziRdydAG+2eT7u10G/LkysIYDbOEMXUD5NXSxVQJ1Ya0EsI+sD
	 2ZX3QuQ4F+jPDR1DQ4jnf5zIKF+ZIJNxFC4mFzQZ6wkAi9JWKSuvbr3vYcqTomcoXhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089174;
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
	bh=KQjj1CGn/w9dFAbHmXn1RINVeUIQ/FR2ffOF/GhrYHk=;
	b=XX/88eDxDIPSa2hSgB/Js0W7Tgu8dxdXm5RIDX00EsSKDIlpV+cz9Dar7Zk9MMxnzfFO
	 V8ocm9Yoxgrud83QcT566M5WBd8I7tIYWWkUaVklFfvyars1rWPqh4f9A8OuvUbKToRqt
	 xWVEqLCuzGjB48lg8nYxEzodKPfSWZTsZ9J6zUWqAVzWmgI0nAtQY0Yw1A+PYbkPFC/wY
	 8TeMrI71yghyVafRY59sIFvc6INdKFuTZnRdjI7p5M5SlDw+GSWCAwg+/f0ufKCc2Dyo8
	 /KJLupfxE0m/K72RVNSo64FYa4Q/X4iO32TFACRISFf78joRe0IxIy/q8ujAqWSAT3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vqbt2gSe;
	arc=fail smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71C6606A31A;
	Tue, 27 Oct 2026 08:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E71C6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Vqbt2gSe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089173; x=1824625173;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=38celaPPU/zWPBUwAeFE69dN7wI94BGufo4Em3cxBJQ=;
  b=Vqbt2gSeLWNa7nEp7jlhtsLxJ4t/lf2UW8n4hdmEXWVWCEngAI6fgiHu
   y6QuSMBYtreGv5Oxm4rjztAVoFDGa2wRXJ9JeGTKaBIL5wWcUbEaIWlgC
   s+XZgpdv+VvDnHPLJBVwfzg5AUYUOO1+5sZ0tpCOHK/7fipO5dWIfYmDH
   yJz8S8sssDQPgEtiP+r4rXZaGM+Q7gtoo+dXpWKJhkAvCO37lviqpAbDj
   UOIvRVlpl7ygu1cqufvBchFrohihYpA0jGerzelw34s/geR+ob2n5ggPC
   h+oDgHEp/CSY4Z665s3s/Zhwe8XshboQpClwJilSkPjImzEFC+ck0cTsd
   A==;
X-CSE-ConnectionGUID: rKYK2oSPR0W0bCUrBfapBQ==
X-CSE-MsgGUID: CUmltD0iTrq/4HHUNRH5CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1686098"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1686098"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:19:32 -0700
X-CSE-ConnectionGUID: OV8Q7bgxSMmmuzu8RtNqNA==
X-CSE-MsgGUID: dtmjVc+dRd+SMBdvPXFGsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4997095"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:19:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 01:19:31 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 01:19:31 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.47) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 01:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvj83xZ1hpoPACgHmM7m4BfxYAsGdwl97zm1nJMAvlWkR2h6e19LHlRPn3vCiXzzYP7cilPw5qmveYvbKCQdPJdNLXJn8ZNk79q/odZWH+/nhjqOY/+odaSKMmTq4BvlOdkXQhAmWyZEbFXhDb/eH3SNJZ0qVp4m/P9s/s/L3Dydix8tQ/vNPphH+WiQ1BBE6nO43DRoowUS6a4jLW+i2ktPUaZ4KPjzi8FfUNVuEzd2ug/usskjkW/N1BYRn1q9Je6lM+4EUBRuQjO4zinwVrPuPjws5Cx+FAq3GYJPpume3NxUOE2qZreCV3QKeO7q29BY0V52aBmVuVW4qIsbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQjj1CGn/w9dFAbHmXn1RINVeUIQ/FR2ffOF/GhrYHk=;
 b=wtidjHolXKrl0fJWoBZYMYcCktJezGlzboP3PKxfQLldilF6GFunaL80t//WG9bH0LP1rCYQnW8ocyLHuqQ7qPcBkry+kTOWSCzeZOnk4TJqi4H/3n+EH2E6gCcIS7mASy0vhb6Pwc8jhHHBANysIc8dpekM+CtdDvJYExsQqFf/VkQjReRYn1IubxDIz5Yqsqp80XgMI+HjYByC+LyLl6Zy6Xqq5rIoy0tMHeYGzMwESJpM1oVDbRzfuFR41pRD2KGxs8iWW2ktKmPcHCvHHyRhnpD6dcdTZvCpzT4xBMiYxxQFvpp/jq+rHd2Ly9w/BZEyXpUThyanoror26u+kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LV2PR11MB6047.namprd11.prod.outlook.com
 (2603:10b6:408:179::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Tue, 27 Oct
 2026 08:19:25 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 08:19:25 +0000
Date: Tue, 27 Oct 2026 09:19:18 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Paul Moses <p@1g4.org>
CC: <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] igc: return XSK frame copies on XDP_TX failure
Message-ID: <auBehtniOJTRGfaD@boxer>
References: <20261023141317.3904442-1-p@1g4.org>
 <at+yluh1NVm78gn6@boxer>
 <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <HTx28-b95D5R6LIxwQGHksxNXb6wWbEOp6IGCfRU51shEKudZgRxqFylE-Ngqd3ufeFJGlo5VccF1yXfAVeWQlqpNoSMp5oxS8tlJNxH4h0=@1g4.org>
X-ClientProxiedBy: DB8P191CA0022.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::32) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LV2PR11MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: cd921a30-1940-4547-2ba8-08df340302f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|261026121527099003|11063799006|56012099006|4143699003|10067099003|261009223027099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: s30dZaxcypXNGrBBcmhm/TJXP19ng/2UoJ7ztNvOL6+0N26MX+yEVOgmGdChpZavES89SJhuEGKWUdyaHYmdGDrAGVZpjeTfrwJqV8FU0/bYlzIDAVIW5nV2VUhUqhri85I8Jd2IQL2/U89N2nNj9rfYB6/tCgMJrG4cjvQN+1baB+/rz8jM0dO+il9wD2IC7HRILgyPOSh9wrmHoOBP7VgpMkxGTTOSkkbEvtfLeo+ylvyS+qxypi3zfbqiEDDiEyZj8TXnniNVj4/fa/cZGNrK4TgvcpnYIWB2i5wbJ1AVHA8ex9b9wv+rvs4jq/xnBsMD2b5I7pMFlY82TJ174Dox5Q7HqEm3x01aZUydAqOsClbIh0AT604dyJnQf8iJxmRsPSjk/Eo98gzUQeXwOpajKcQKqwV8jOfK8B9nRoKsp5XNm19CmwVyOaC8qpOzWUFDW/N8tsH2AOfpTaU4/HW7P5IG56fF95em8J7OE9mNa9fB6gYgVgurQsrTAv3jy6vWbHk8ikxH8NMaqO1O5bHWPf9eE72UqDkOnb6qk5saaFhAfZ8I2NZu9lM8Rc9fmLM2WPHoMtORpvwzfA3+Gjsn61TDnztpMMcqOagC8UjdINsKxSIanqP3tywTNrFU/2ZQp1vG0PFDJgWyknUOAzTkRyoUXqwj2QHRh9/ezXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(261026121527099003)(11063799006)(56012099006)(4143699003)(10067099003)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vebKL6TvCj9F5S+S6HSnVebTxAG55SyL31FOIxxAX58zLqsPSvk27vwEOVQz?=
 =?us-ascii?Q?Dniw3zqaF7hZxUNfGHde+KEHgAlODEhc6+qy18wiLIZwzeIU53t4jMSCOAou?=
 =?us-ascii?Q?11ATvfQdY+Jyjckhs0eUcxkGscay72U60keM9tnxbWNns/zv8E+m4PKxQPHt?=
 =?us-ascii?Q?bD6+2k5L5/rG9fNpPRPPKxZLMlCZS5EBI9Kb3LPSjf9qhJBHyM/WncgfNwdf?=
 =?us-ascii?Q?rLj17wAcuOJEarXuSlHcuHUYZDvzKT+38uTVtYDfHpV2Iz2WvgUaQ1Ba6Ccz?=
 =?us-ascii?Q?045iD5a2A9w0vbnHKxxnVUtkjhA9bVmjx1Xi7g4XnhmjY5P0Gk1mPGd1PRSi?=
 =?us-ascii?Q?yDUKA01lKxScFqAkE8rPIIZ4LvS9Xxnbvadq/kYzcHCCsUxzUXz3AwPCocqA?=
 =?us-ascii?Q?JV26hEUxu4+NnItW0NT2o/eR+7nAydjeOCt74X3QGz6uoBKSjzaWu7ur9WWj?=
 =?us-ascii?Q?KDt83Edb1Vk2bHavPQjI0km5P9q72oZqSjjb4c3ELQKWj6wxzLGLzE24E8eV?=
 =?us-ascii?Q?iytiUJJ8oIUUx/yaix1JuXmzFjZPiUOcfk0Ag248JxwW7tmjEPNrQSFj6APl?=
 =?us-ascii?Q?5mrO4AOPci2Z5ExjtwJ/P0MzLw5EQzidbGa0Zn7NV6f2szMXWNQyTtZzel7k?=
 =?us-ascii?Q?3Zrq/g8etIvvUQ2bnUE9fNx/dbEfshx6s4p0RG0nWALprZ5FqoXN+sXyWtgy?=
 =?us-ascii?Q?OOVjZSpc4zsfmBqluzG4evqb16VWzHGK+OPSVCk41NuCncs8D4CTASvDXod4?=
 =?us-ascii?Q?KAjbYHjo5ULnugC4JrNwcDUPl4fDqnKUGctb9NPjLEWCF/zv2lU+0k9T1/Eu?=
 =?us-ascii?Q?Tqs38tFC4LI0NxbEn57Vrh6DB7ADzgxeXw+ueIjdIadkTziovKmNC+J6K6pr?=
 =?us-ascii?Q?zU95PNXHIG1lBwb+G9v/LNrBQvPykybLgGUcsZNbUKKeFacGPLJiBKnDTUvC?=
 =?us-ascii?Q?HUikK4JyyBkcap0e/vrMWkrLbyaT7bjqDyA5DWQ84JhLvnYhDZQTX/CGgiRj?=
 =?us-ascii?Q?erP+T0M+x4BI+7NNBtXbfD51ah5SIvnZUOWbBofh96V6EjPNo+Ua1YLBRzQY?=
 =?us-ascii?Q?a2EF612L/19M6+9v5nGRqyV2VjM9xjumHoAD89ghKik9M0iUeoRIiel5gBNO?=
 =?us-ascii?Q?DT8vRRHA2Yj1u+YE7/K0pLAGNWw0AEh+nzcYA00JL9t85DMj7900aKqK/yy8?=
 =?us-ascii?Q?YQQYu+latA46WS8iYFHHwS8aTkTI4yOpvpXtwaT2yGb+m7St76golQH9aCwp?=
 =?us-ascii?Q?1Pjn35ZS2f2ZRt7Cvbn+e3Q3N7l5PlXW073rKp+pvsSiOn/sCCOsCZuEpK3p?=
 =?us-ascii?Q?hgO6trOjMjKINLKa4QQZ9jDfuZC7cSeBcakekrKb+ASO9U/FK3y/Cl7LZO0H?=
 =?us-ascii?Q?BgG+D6ZinH301OMR62+wbvg2Fsj4cnOkHO3Cq/IhC9+XLuzCfCNY83EMX48n?=
 =?us-ascii?Q?rSXGBa2qIZHRaBd6oMi1myUPvvNIwd9K5w60IeKqLkxpjwOHDVuhIm/GfX/w?=
 =?us-ascii?Q?Rb1sP6PTJqKFlss00lbnANn6LTwUfBzeDRgFuZL0MI4qXtHgHe+wvYfjP86H?=
 =?us-ascii?Q?w9NC9t04du4XyiphBrYWpG7KTUDuKmUjw4wUT+3UyWHLwztaRxgIUm8QpSq2?=
 =?us-ascii?Q?zg80B42E2T3SdrPv1j8OQdNrmIUUPn4TrmzLKHYZlkYBgnIEkiYEerNaGozc?=
 =?us-ascii?Q?iGGto/m+FTYgzUl404t+yHvZLxuFcm6z96/oqppMCM/KCIu9+ixpRkmSZmxe?=
 =?us-ascii?Q?0Fv/5gvQcJUKUpdvonIdB1A83JYzbGk=3D?=
X-Exchange-RoutingPolicyChecked: acfd8dNnzVKS50m71lxx5bJgKPOp+SjCkD7wSQYql/6djHG/Jo6mrSd9OjZSrWI/1i5/dL0KHd0y1cZDmFdmUwEicqkjjrXhApGLRMWZ0ctAoME33wXbGjGKw0lVnoBySlEv2ApJuvu1QEcSKMfVUUmF/1LpbGT//serXYWrHfdqUGiMXnaJtFQ3dUsZtyVvTha79Gdj96DCE/VbrBKGJ3ne09VRgLkBSG+RHYVPqIcG1Pg+HH0OLsjaIdDsfPjzEqJFDbccDjdBicFQx43zvrWt4rs9DLufUc65GQl6mRvu0ZwinkszQR7jEliqk0Ko7ccVkXi4bYpVR6GPlOSJsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd921a30-1940-4547-2ba8-08df340302f7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 08:19:24.9969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81bs7LX+wtxGepNtAlUp6Zz2TD2P/3Y2Jf0KjN8jC5EpAo6/aPITT2JpG5+9/DSe8JPswuH8N7xN4YWVlyN74jPvXCm/X33cSYARJuLSQiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6047
X-OriginatorOrg: intel.com

On Mon, Oct 26, 2026 at 10:18:03PM +0000, Paul Moses wrote:
> On Monday, October 26th, 2026 at 3:07 PM, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> 
> > On Fri, Oct 23, 2026 at 02:13:42PM +0000, Paul Moses wrote:
> > > Converting an XSK buffer to an XDP frame allocates a page and returns
> > > the original buffer to its pool. If the TX ring is full or DMA mapping
> > > fails, igc_xdp_xmit_back() returns an error without freeing the copy.
> > > The RX cleaner cannot release it, so the page leaks.
> > >
> > > Return the copied frame on TX failure. Save the RX memory type before
> > > conversion so native frames remain RX-owned on failure.
> > >
> > > Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paul Moses <p@1g4.org>
> > > ---
> > > Tested on Intel I225-V with baseline and patched kernels. Physical
> > > pause-frame backpressure caused 46 leaked copies on the baseline.
> > > With the fix, all 72 rejected copies were returned once and freed,
> > > and all 192 copies were accounted for.
> > >
> > >  drivers/net/ethernet/intel/igc/igc_main.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index 1fb5f3cbe93c..39263fd04aa9 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -2487,6 +2487,7 @@ struct igc_ring *igc_get_tx_ring(struct igc_adapter *adapter, int cpu)
> > >
> > >  static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
> > >  {
> > > +	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
> > 
> > small nit is we require a concept called RCT (reverse christmas tree)
> > which makes you to order variable declarations from longest line to
> > shortest.
> > 
> > >  	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
> > >  	int cpu = smp_processor_id();
> > >  	struct netdev_queue *nq;
> > > @@ -2504,6 +2505,10 @@ static int igc_xdp_xmit_back(struct igc_adapter *adapter, struct xdp_buff *xdp)
> > >  	txq_trans_cond_update(nq);
> > >  	res = igc_xdp_init_tx_descriptor(ring, xdpf);
> > >  	__netif_tx_unlock(nq);
> > > +
> > > +	if (res && mem_type == MEM_TYPE_XSK_BUFF_POOL)
> > > +		xdp_return_frame(xdpf);
> > 
> > Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > 
> > > +
> > >  	return res;
> > >  }
> > >
> > > --
> > > 2.56.GIT
> > >
> > >
> > >
> > 
> 
> Never know what to do in these cases, order matters here, so
> do I touch more lines to move the assignment down below?

	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+	enum xdp_mem_type mem_type = xdp->rxq->mem.type;
	int cpu = smp_processor_id();
	struct netdev_queue *nq;

this would satisfy the RCT rule.
