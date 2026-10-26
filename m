Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793043985;
	b=I5oypHnmAAM0YaZZ5hKaqTipOnyPJnT/AG9tsKMQ9PPa6MjMNee65icuPWIc4+GaBd1z
	 2hC/0EBEbDSumHpvEPrGAMEU8SnoMI7QcWFv5spP8RJnsrfLSXQwN4yS0nR38kRNwyiCB
	 ze6cwO2hn0X7Q6UxX9gBhzDrcyP5NJ1duTVjuPNUILWBJE/nWji3aYbjUsniC0efNBUKJ
	 1ZAWYpPaSKqFCl/8GrF5m58KXBwRuYn91BA0VlToqpf4uNF1q++S+xIyKMc4JwA+Pfz43
	 2O2RKBWGH2cgHEFpm/KANtandEtvdRkifyV+kwhCHlCS5hrjJQDDeSdaJBAQCQRY1Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793043985;
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
	bh=x2HYCAxIqU1rlFyBnfb3hfVSBTRBCxaFWfcj6vxzzqY=;
	b=zaz4lvK3AY9MwwiJiUdijhC1jUnotMniT+xOXm1GMsMaTDfvjLwty9Qm0Vgh360HSXDo
	 Ui2fJJd9Rw8aos2QX8hde2dKEsazH8DaS3QYqkr0LD0RlK72PtqCVdpI/h61bUOjqo4uL
	 a7yABZUabkdHuTYPEVheX3xYseOca8kRVYDdQn0jnfdVAoB2aovQtFJ2+rl3uD1EoqmU8
	 9LEmB1RCQYI1CL+1nUve1hRncq9IHbGZL4SAfymbDzR+Naumez0PMngvfG5/25CsK5K3F
	 0/bYiNarCx94viQv6JurdXIZu+8c0OJ4Bsp+cccrvuTTL8401l9lFoprmWyNlt4b/Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EBnGACxE;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED695606A31D;
	Mon, 26 Oct 2026 19:46:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED695606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EBnGACxE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793043983; x=1824579983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LTzsDjqupcT8mInwDmdDJQN7x4qXLVOJnV6tt3QQpLc=;
  b=EBnGACxEWAzogg78a/tEQ2Mx2rVogfFjEvNZ85vducRPsTVm3JgLl9Eb
   uctB5bGMwy2Zg5H6sopfpelBZ1pIv7DFuL7R2ClgC50+HkvRdaANdaRus
   8ejDiplw+GTFszJcrFKq0fiFS1jlewVyLeAm0yVZ+fU9zTFf/CYT/3xMT
   f5RP7ioWa7OAcI65jNpPCBL0OfJaL0/V7m04RoxnhNJg1HCMHlTJVHJED
   sNbRnATLf/rD+ahf2EEWuGWandAgvnkrv97Rekx+6XeT3bbmLKaWZ6m+5
   2KBc3tVSye0qVgUg11aQ7MNQNy8CMfUwoXkhlXtS+o3vDoulIl2oLOsiI
   g==;
X-CSE-ConnectionGUID: cVQfzjtbRpS1KZvV0jq7nw==
X-CSE-MsgGUID: KwVL6q1ZSnaKbHNdb7dPgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1621849"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1621849"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:46:21 -0700
X-CSE-ConnectionGUID: cKys1Bb8SpSe1Mjly/6qkw==
X-CSE-MsgGUID: N/aX90LmRUy7r8J7ziMwtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4335010"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 12:46:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 12:46:20 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 26 Oct 2026 12:46:20 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 26 Oct 2026 12:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1T8svtPRqokHSmOn3GaAUatS/rB1saYqdH/nPC9L+7Z1S57lwCSdfh+dybUdzwYe4yFdRkJm480FLK1AB59ilk7i0cAW1Q8zl9gAXhfT5yUC42Xj3FgYbrCZxNepd0weCqz5rAod6rvtx0BPeBtm+VUzug5egZsYJlIwz+BChAsN+HQtLqwfrqC/qPgA21JqFqUjwl+uGyyxibmgdMtGze/OAoHoF7+bpoKGY7ijJ7QVm5iRrredavpwHgs+zSrtKgh/j9/FtyYEOMuuxch+W55Upodsjqql9ekR9IRedZi2aw4WsBdboCqVg6IkpZTSHceyfS1fKlj3Ib5uzQSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2HYCAxIqU1rlFyBnfb3hfVSBTRBCxaFWfcj6vxzzqY=;
 b=RMEanmkrYQxIPf9kO5x4xns10ac1L2JuIwtzA1TfS4AYQHi/WkPVr0OdG0or8iF/hNek0MNY1i9yVgjVuiWMQ0F5hLy+XmEYYzFQb6ZegBx9V8kp9yV7etW0vyse6gstyBcybyT2IeEntpzWbj4XbhRyq0/95RlrRP7iXxi/b+XPbbe0TVv6P/3MBIDori/cm89Ibx5EGYJNZJZKcx+p7og9ciLAoNPJ9oa9lOn00YSK3rNLkHtZo0T+L59kI6zN+GFuhMZR6Hc6X01CxYnV1eSznMxHFGWlO3JzHbBDiylqMrZDriXOJIHuhGTanTvWtM6r4RPCe8eSXjhUVOvhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS6PR11MB065147.namprd11.prod.outlook.com
 (2603:10b6:8:52a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 19:46:18 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 19:46:18 +0000
Date: Mon, 26 Oct 2026 20:46:06 +0100
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
Message-ID: <at+t/jHczGvyXKRN@boxer>
References: <20261025065154.2037149-1-p@1g4.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261025065154.2037149-1-p@1g4.org>
X-ClientProxiedBy: DB8PR06CA0039.eurprd06.prod.outlook.com
 (2603:10a6:10:120::13) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS6PR11MB065147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b508b73-6447-455f-f2d6-08df3399cd7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|366016|1800799024|376014|261009223027099003|261021135927099003|261022105027099003|261021123027099003|261022075727099003|261022113327099003|261021121427099003|10067099003|56012099006|261026121527099003|6133799003|22082099003|18002099003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: U3vm1Gu8nR8FWnkYhcbDDyyRCgNXyxSasA6Bq96Bda26PBXuytHJlh2L77N71dowr/9ZkDUYvMBGHuRUwNvnyMtb5uiRIwtbrfGbE4JcT607cHanl7JsVSRz8wjKWmWSfMOHSDPfLJo1fsSdnyy9uW5w7UQy6hw7kSM5H8g8l7n0T+mXfzkThEfBVJDmnD5ZU+ywXLyD1MvC9jkiqofTxR2P9eXprH1AdVdhgTVJN0EgoW+OX2GO+CnOPMRmJ8hoLiNJtXH5Wjqs7To+MwtJzj5KAg3PYImc8ADr91Cnm7X85yE2bXxdw9C+LgSXSz2n6cKGgQg5IqijxSrjAzrSHODIqqTM5HHs5cO950F/E0HT81qQ645WkfsZYi5rA8ubyOTZjy7PGnufn6Y897L+YA3TAZixM4eS4bUTa3ztaU790Gj9tfzMEdAEpUhOYPud1FDw0K6vzkGpZyyDSNbsBHdMaRQjPKskari1jZJ/JaTpfSttF1JMfvO5OxXzPw7B6swFSzarapVuYbtCSzus0MFpNSxqj+cH70VRfNYgR76RZlqiqKm08kNNU67eGJ4e2G02+B6pPFv8ZRqrsJloWO/O6R/pvqz1aw5zWulJVvYgz/pboTzbVv7A84i3tKGpJhUxGf4LtzR1JL5blekUN21+coT9Jln8cFTYUmqSi6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(1800799024)(376014)(261009223027099003)(261021135927099003)(261022105027099003)(261021123027099003)(261022075727099003)(261022113327099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(6133799003)(22082099003)(18002099003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NE06uODX9zO6gOMSWhq0xd8EcBkFCm5sSQ3pE3wQnL4CPgvMFxHlwW182n5h?=
 =?us-ascii?Q?DIOtQ/KBM/k+z0UjXtRSMeGvGIKMPOnKPoKt5Oe4TxUAN3f45xTudt5SmRTT?=
 =?us-ascii?Q?wOot2C1RicohI02ZpgC6sMpFtkaATEqnjYNV7W2s8VtGu8jEZ6udrDa/XgZ5?=
 =?us-ascii?Q?N7/VwrNNHFKAM6U+iqghJGxyr3+JYnM06TXXrhcutd6dK+kvQvehcZk+6Oxt?=
 =?us-ascii?Q?2w84SdjA25B48CpYiBj2jZ7o0nGdNHZazSxEPhGkBi9nNUTO4Bi5gD9uWFgY?=
 =?us-ascii?Q?NHkYFHbvGaiSYD7mzrXpzC3ADUumgO5v4kWPWHosTA1m8OXDlH+QZPL12YHR?=
 =?us-ascii?Q?VK/y2Zj+pEsz1OzHncX2VlSv1H91T/s4dU6enfdYonSncutzRBRNbQrx0njT?=
 =?us-ascii?Q?02vF4QwG0rHKVWZJ2VFGRbFpplTAmuvctinf5DjyBzY1oY1tNRc6A6oZGLZL?=
 =?us-ascii?Q?46OYUyhruB1UQ03z1g+wMYECzQTtW4bKlsOFF5BHpGtcXZkQJYTm2nvkUXkh?=
 =?us-ascii?Q?FBy1+Uxf30d/8idn1fozOfCwHUr1EPZ/K2omohYwDxUslcNtoCaqk+z1uRam?=
 =?us-ascii?Q?0JYQij+eRnZv1khx34kQWdnFRDbtQMnqF8loTlu/RDhbRBHolDlZSbGOSq6/?=
 =?us-ascii?Q?qTQDAvzEkcVqEZzM/qg3/117woRrxn6Tw5LAs+7GsobR7McObv5VrNH9vG0I?=
 =?us-ascii?Q?SjpzZl+FRtV7/CVLSHprRB63xYwlh2Ud0AVYDN3ZpqpcvS5SUuVMjDrZ8dLV?=
 =?us-ascii?Q?/X8akbRHKI4EUXIQERzqrwvQDhQrXoVAGOQ0sgl62JY/Jl8xol3BYTNRMhYc?=
 =?us-ascii?Q?uhVHEqmTlnwyPwX6QCsEWEurYrH1bfQuoq1ihiHOBgWOfm9/jVcztIqMeQQ/?=
 =?us-ascii?Q?HKDnUv0luceKsgHzXQVE5zAlHCc2RbCsCG4ZcIR18xyvyUEcToZ/zDgQ2dFC?=
 =?us-ascii?Q?jXKVJY1k3EEfiBmDtlz6TIJrvWh2zG7gcyx0bn7ScTbc0B1gX3Jh+UIp4fxC?=
 =?us-ascii?Q?yHwVtM7oLKji5/yK6r8JO93UScVmEzgAI3kLo/+TbXz7RZ4Ip/2bZKBseFCx?=
 =?us-ascii?Q?3tQAYzqtch/SZcITBK9l501QA0mk7zCM7eYKn5wGgfrzfoYQvz6t2Ucyl/lx?=
 =?us-ascii?Q?f4OcdX6bTXq1mwQ15WZNjkLSbKQdgoqEWfwuU9VbHC2e4Va4LGdOUGz7crNk?=
 =?us-ascii?Q?zRtu3VabAO7dPSrLPpDJig75vMtIt0/2ft+6mG/356SFqb/y1v9i2gHJbm/I?=
 =?us-ascii?Q?ZD4QzUQyUgTtid/VP7UbZtmHAve/K+gOAqtcjfWpcYHm59i3sHhBpEa8MsqK?=
 =?us-ascii?Q?zklYgpr31u9AxFSOjmzd7UfdDH/37UE+9MZBSGPqAgknIh7+cH5idVt63t6K?=
 =?us-ascii?Q?yOMje+c6pYB7ycMH8HnYrWT8Bxmg0ZgZq0zqdwgNC9wimvSIILHmu/9ueKq0?=
 =?us-ascii?Q?PXqEdpaydcq8WxGfoHmIq0AX3kZhDzeXXyZhGvBuLICheX8/49czNOH80j0Q?=
 =?us-ascii?Q?Uc8BQXannP0TphMgbdi7NhSmx1MnunyHEUOGsqYTgqXD1iiRj1KGtdH1DJOE?=
 =?us-ascii?Q?EOsSCIEs2dTWTR1EsW5qICN5qpumtbDM7HWG909Vc68Z1PS/XfiSUVdzhEyN?=
 =?us-ascii?Q?HE3QiqweMukaCYtyThCzT6GkZwN0mn6+KUvdzA60gV6HAG+5zGGt88FoyKiE?=
 =?us-ascii?Q?/mQAmp5JOoI+HDDgtRNGlLQD7Egn+ipFICqCJpfz0AIiNTHXF/m6wkxfjYDZ?=
 =?us-ascii?Q?oDhtrhGX8Ub8hVmuYYZYqCpaXfpwZrM=3D?=
X-Exchange-RoutingPolicyChecked: TT6KXpjlvxfl4gTvBh83PHcPsDbS0z+ixBNypo0Mlkd/+hzFpqOyfMDzLf3q2TnXj3ZnePbull/DCbE8UKPVcvc4BmcKifgryi2M7c5vZVebr5a/8pYTmN5xr/52hTH6nnSHoAt5WoXnJnt2TeB2CAsJ/j5ocgf4JHkio0Q27QSCWnfZUcbL9fzpx4qZ+us8ymSZEOuKB4bfJwZiwyNgT4yThvYtMs+c1LPMNCfidlo2oO4YD1AqVbLW6Ext88YcPlbKYaXjDs9xhMjWRRhn1j7oI5WF8i0YT1F3o7sr+Te4ilpBFlRWtqG+NNh8gtAFvkI5Oqw3Mn/cFNv2UtbsQQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b508b73-6447-455f-f2d6-08df3399cd7d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 19:46:18.1605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyAIm2Zm7Fy+BsNBmMHqg1R7NN5p7gL26VD4JBqv5cU+SUpSAYZb16PCOt2K8AUTri1u68WJWpAf22m40u+IfXJEoKrLemHEHAjS7hZBm8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB065147
X-OriginatorOrg: intel.com

On Sun, Oct 25, 2026 at 06:52:06AM +0000, Paul Moses wrote:
> TSIP remains set on continuation descriptors, but the inline timestamp
> header exists only in the first buffer. Stripping it from every
> descriptor truncates split frames and can underflow short buffers.
> 
> skb ownership cannot identify frame boundaries when XDP consumes the
> first buffer or AF_XDP uses zero-copy.
> 
> Track rx_in_frame per ring and update it as descriptors are consumed.
> Strip timestamps only from first buffers, reject unsupported split
> frames before XDP and drain continuations. Account discarded
> descriptors against NAPI work without counting successful RX.
> 
> Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
> Fixes: 26575105d6ed ("igc: Add initial XDP support")
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
> - This supersedes "igc: only strip RX timestamp header from first buffer"
>   following feedback from Simon Horman, Maciej Fijalkowski and Sashiko.
> 
> Changes:
> - track frame boundaries independently of skb ownership
> - guard timestamp stripping and drain unsupported split frames
> - cover the AF_XDP zero-copy RX path
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 87 ++++++++++++++++-------
>  2 files changed, 64 insertions(+), 24 deletions(-)

Hi Paul,

I think this implementation went off track. We should make sure we *never*
enter data path for XDP/AF_XDP multi-buffer scenario until we add real
support to it within this driver. Now you sorta handle fragmented packets
in data path.

I tried to argue with bot reports that it hallucinated for
igc_clean_rx_irq() content (which was concise and to the point) and agreed
the AF_XDP should *not* be exposed to any fragmented traffic, which should
be addressed on HW RX ring configuration side, not within data path.

Also this should have been a v3 with a link to previous revisions so we
could keep track what has been changing between versions.

Here's something that would address ZC fragmentation issue. Could you give
it a spin on your side as I don't currently have igc in my setup handy.


From a3edec7db135f13a567565a652da5cc850505f7f Mon Sep 17 00:00:00 2001
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Mon, 26 Oct 2026 15:00:00 +0100
Subject: [PATCH net] igc: fix AF_XDP receive buffer size for 2K UMEM chunks

SRRCTL.BSIZEPKT has a granularity of 1 KiB. With a 2 KiB UMEM
chunk and the default XDP headroom, xsk_pool_get_rx_frame_size()
returns 1792. Programming this value truncates the hardware receive
buffer size to 1 KiB, even though an MTU-sized frame fits in the
usable UMEM area.

XDP on igc is limited to MTU 1500, so configure a 2 KiB receive
buffer for XSK rings. Limit RLPML to the maximum supported Ethernet
frame size while XDP is attached, regardless of PAGE_SIZE, to avoid
oversized frames spanning descriptors or exceeding the usable UMEM
space.

RLPML is currently programmed from igc_set_rx_mode(), which can run
without RTNL, for example on an IPv6 multicast join, and could then
use a stale XDP state. RLPML does not depend on the address lists.
Program it from igc_setup_rctl() instead, next to RCTL.LPE, and from
igc_xdp_set_prog() while the rings are disabled. This avoids
netif_addr_lock_bh() usage.

Validate that the XSK frame size accommodates a maximum-size frame
with two VLAN tags, FCS and the optional inline RX timestamp. Check
against the maximum supported XDP MTU, rather than the current MTU,
which can change after the socket is bound.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/igc/igc.h      |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c | 33 +++++++++++++++++------
 drivers/net/ethernet/intel/igc/igc_xdp.c  | 11 +++++---
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 17f213cc93e4..ad1062f8531a 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -765,6 +765,7 @@ static inline s32 igc_read_phy_reg(struct igc_hw *hw, u32 offset, u16 *data)
 	return -EOPNOTSUPP;
 }
 
+void igc_set_rlpml(struct igc_adapter *adapter);
 void igc_reinit_locked(struct igc_adapter *);
 struct igc_nfc_rule *igc_get_nfc_rule(struct igc_adapter *adapter,
 				      u32 location);
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..38a5702647f4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 	ring->next_to_clean = 0;
 	ring->next_to_use = 0;
 
+	/* igc's XDP limits MTU to 1500; all XSK RX buffers can use 2kb;
+	 * RLPML limits the receive length to fit after UMEM headroom.
+	 */
 	if (ring->xsk_pool)
-		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
+		buf_size = IGC_RXBUFFER_2048;
 	else if (ring_uses_large_buffer(ring))
 		buf_size = IGC_RXBUFFER_3072;
 	else
@@ -830,6 +833,25 @@ static void igc_setup_mrqc(struct igc_adapter *adapter)
 	wr32(IGC_MRQC, mrqc);
 }
 
+void igc_set_rlpml(struct igc_adapter *adapter)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 rlpml = MAX_JUMBO_FRAME_SIZE;
+
+#if (PAGE_SIZE < 8192)
+	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
+		rlpml = IGC_MAX_FRAME_BUILD_SKB;
+#endif
+	/* igc's XDP currently does not support jumbo frames. Limit the
+	 * accepted packet size regardless of PAGE_SIZE so it fits in a 2kb
+	 * XSK chunk.
+	 */
+	if (igc_xdp_is_enabled(adapter))
+		rlpml = ETH_FRAME_LEN + VLAN_HLEN * 2 + ETH_FCS_LEN;
+
+	wr32(IGC_RLPML, rlpml);
+}
+
 /**
  * igc_setup_rctl - configure the receive control registers
  * @adapter: Board private structure
@@ -874,6 +896,7 @@ static void igc_setup_rctl(struct igc_adapter *adapter)
 			  IGC_RCTL_CFIEN); /* Disable VLAN CFIEN Filter */
 	}
 
+	igc_set_rlpml(adapter);
 	wr32(IGC_RCTL, rctl);
 }
 
@@ -4116,7 +4139,7 @@ static void igc_set_rx_mode(struct net_device *netdev)
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct igc_hw *hw = &adapter->hw;
-	u32 rctl = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
+	u32 rctl = 0;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -4146,12 +4169,6 @@ static void igc_set_rx_mode(struct net_device *netdev)
 	/* update state of unicast and multicast */
 	rctl |= rd32(IGC_RCTL) & ~(IGC_RCTL_UPE | IGC_RCTL_MPE);
 	wr32(IGC_RCTL, rctl);
-
-#if (PAGE_SIZE < 8192)
-	if (adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
-		rlpml = IGC_MAX_FRAME_BUILD_SKB;
-#endif
-	wr32(IGC_RLPML, rlpml);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/igc/igc_xdp.c b/drivers/net/ethernet/intel/igc/igc_xdp.c
index 9eb47b4beb06..a0f1ecb2ed5f 100644
--- a/drivers/net/ethernet/intel/igc/igc_xdp.c
+++ b/drivers/net/ethernet/intel/igc/igc_xdp.c
@@ -34,6 +34,8 @@ int igc_xdp_set_prog(struct igc_adapter *adapter, struct bpf_prog *prog,
 	}
 
 	old_prog = xchg(&adapter->xdp_prog, prog);
+	if (if_running && need_update)
+		igc_set_rlpml(adapter);
 	if (old_prog)
 		bpf_prog_put(old_prog);
 
@@ -69,11 +71,12 @@ static int igc_xdp_enable_pool(struct igc_adapter *adapter,
 		return -EINVAL;
 
 	frame_size = xsk_pool_get_rx_frame_size(pool);
-	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2) {
+	if (frame_size < ETH_FRAME_LEN + VLAN_HLEN * 2 +
+			 ETH_FCS_LEN + IGC_TS_HDR_LEN) {
 		/* When XDP is enabled, the driver doesn't support frames that
-		 * span over multiple buffers. To avoid that, we check if xsk
-		 * frame size is big enough to fit the max ethernet frame size
-		 * + vlan double tagging.
+		 * span multiple buffers. Check the maximum supported MTU, not
+		 * current MTU, as it may change while the pool is bound. Account
+		 * for double VLAN tags, FCS and inline RX timestamping.
 		 */
 		return -EOPNOTSUPP;
 	}
-- 
2.43.0


> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 17f213cc93e4..635d49701e62 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -198,6 +198,7 @@ struct igc_ring {
>  			struct igc_rx_packet_stats pkt_stats;
>  			struct u64_stats_sync rx_syncp;
>  			struct sk_buff *skb;
> +			bool rx_in_frame;
>  		};
>  	};
>  
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c..9ca5558c762c 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring)
>  		igc_clean_rx_ring_page_shared(ring);
>  
>  	clear_ring_uses_large_buffer(ring);
> +	ring->rx_in_frame = false;
>  
>  	ring->next_to_alloc = 0;
>  	ring->next_to_clean = 0;
> @@ -673,6 +674,7 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
>  	/* reset next-to- use/clean to place SW in sync with hardware */
>  	ring->next_to_clean = 0;
>  	ring->next_to_use = 0;
> +	ring->rx_in_frame = false;
>  
>  	if (ring->xsk_pool)
>  		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> @@ -2111,10 +2113,8 @@ static bool igc_can_reuse_rx_page(struct igc_rx_buffer *rx_buffer,
>   * @rx_ring: Rx ring being processed
>   * @rx_desc: Rx descriptor for current buffer
>   *
> - * This function updates next to clean.  If the buffer is an EOP buffer
> - * this function exits returning false, otherwise it will place the
> - * sk_buff in the next buffer to be chained and return true indicating
> - * that this is in fact a non-EOP buffer.
> + * Advance next to clean and retain frame position for the next descriptor.
> + * Return true if the consumed descriptor does not end the frame.
>   */
>  static bool igc_is_non_eop(struct igc_ring *rx_ring,
>  			   union igc_adv_rx_desc *rx_desc)
> @@ -2127,10 +2127,8 @@ static bool igc_is_non_eop(struct igc_ring *rx_ring,
>  
>  	prefetch(IGC_RX_DESC(rx_ring, ntc));
>  
> -	if (likely(igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)))
> -		return false;
> -
> -	return true;
> +	rx_ring->rx_in_frame = !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP);
> +	return unlikely(rx_ring->rx_in_frame);
>  }
>  
>  /**
> @@ -2601,7 +2599,7 @@ static void igc_update_rx_stats(struct igc_q_vector *q_vector,
>  
>  static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  {
> -	unsigned int total_bytes = 0, total_packets = 0;
> +	unsigned int total_bytes = 0, total_packets = 0, work_done = 0;
>  	struct igc_adapter *adapter = q_vector->adapter;
>  	struct igc_ring *rx_ring = q_vector->rx.ring;
>  	struct sk_buff *skb = rx_ring->skb;
> @@ -2609,13 +2607,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  	int xdp_status = 0, rx_buffer_pgcnt;
>  	int xdp_res = 0;
>  
> -	while (likely(total_packets < budget)) {
> +	while (likely(work_done < budget)) {
>  		struct igc_xdp_buff ctx = { .rx_ts = NULL };
> +		bool first = !rx_ring->rx_in_frame;
>  		struct igc_rx_buffer *rx_buffer;
>  		union igc_adv_rx_desc *rx_desc;
>  		unsigned int size, truesize;
>  		int pkt_offset = 0;
>  		void *pktbuf;
> +		bool tsip;
>  
>  		/* return some buffers to hardware, one at a time is too slow */
>  		if (cleaned_count >= IGC_RX_BUFFER_WRITE) {
> @@ -2635,21 +2635,34 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  		dma_rmb();
>  
>  		rx_buffer = igc_get_rx_buffer(rx_ring, size, &rx_buffer_pgcnt);
> +		tsip = first && igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP);
> +
> +		if ((!first && !skb) ||
> +		    (first && igc_xdp_is_enabled(adapter) &&
> +		     !igc_test_staterr(rx_desc, IGC_RXD_STAT_EOP)) ||
> +		    unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(rx_ring->netdev);
> +			xdp_res = IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
> +
>  		truesize = igc_get_rx_frame_truesize(rx_ring, size);
>  
>  		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
>  
> -		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (tsip) {
>  			ctx.rx_ts = pktbuf;
>  			pkt_offset = IGC_TS_HDR_LEN;
>  			size -= IGC_TS_HDR_LEN;
>  		}
>  
> -		if (igc_fpe_is_pmac_enabled(adapter) &&
> +		if (first && igc_fpe_is_pmac_enabled(adapter) &&
>  		    igc_fpe_handle_mpacket(adapter, rx_desc, size, pktbuf + pkt_offset)) {
>  			/* Advance the ring next-to-clean */
>  			igc_is_non_eop(rx_ring, rx_desc);
>  			cleaned_count++;
> +			work_done++;
>  			continue;
>  		}
>  
> @@ -2664,6 +2677,12 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  			xdp_res = igc_xdp_run_prog(adapter, &ctx.xdp);
>  		}
>  
> +		if (xdp_res) {
> +			total_bytes += size;
> +			total_packets++;
> +		}
> +
> +xdp_done:
>  		if (xdp_res) {
>  			switch (xdp_res) {
>  			case IGC_XDP_CONSUMED:
> @@ -2676,8 +2695,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  				break;
>  			}
>  
> -			total_packets++;
> -			total_bytes += size;
> +			work_done++;
>  		} else if (skb)
>  			igc_add_rx_frag(rx_ring, rx_buffer, skb, size);
>  		else if (ring_uses_build_skb(rx_ring))
> @@ -2700,8 +2718,15 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  		if (igc_is_non_eop(rx_ring, rx_desc))
>  			continue;
>  
> +		if (xdp_res) {
> +			skb = NULL;
> +			continue;
> +		}
> +
> +		work_done++;
> +
>  		/* verify the packet layout is correct */
> -		if (xdp_res || igc_cleanup_headers(rx_ring, rx_desc, skb)) {
> +		if (igc_cleanup_headers(rx_ring, rx_desc, skb)) {
>  			skb = NULL;
>  			continue;
>  		}
> @@ -2717,7 +2742,6 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  		/* reset skb pointer */
>  		skb = NULL;
>  
> -		/* update budget accounting */
>  		total_packets++;
>  	}
>  
> @@ -2732,7 +2756,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
>  	if (cleaned_count)
>  		igc_alloc_rx_buffers(rx_ring, cleaned_count);
>  
> -	return total_packets;
> +	return work_done;
>  }
>  
>  static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
> @@ -2797,10 +2821,10 @@ static struct igc_xdp_buff *xsk_buff_to_igc_ctx(struct xdp_buff *xdp)
>  
>  static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
>  {
> +	int total_bytes = 0, total_packets = 0, work_done = 0;
>  	struct igc_adapter *adapter = q_vector->adapter;
>  	struct igc_ring *ring = q_vector->rx.ring;
>  	u16 cleaned_count = igc_desc_unused(ring);
> -	int total_bytes = 0, total_packets = 0;
>  	u16 ntc = ring->next_to_clean;
>  	struct bpf_prog *prog;
>  	bool failure = false;
> @@ -2810,11 +2834,13 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
>  
>  	prog = READ_ONCE(adapter->xdp_prog);
>  
> -	while (likely(total_packets < budget)) {
> +	while (likely(work_done < budget)) {
> +		bool first = !ring->rx_in_frame;
>  		union igc_adv_rx_desc *desc;
>  		struct igc_rx_buffer *bi;
>  		struct igc_xdp_buff *ctx;
>  		unsigned int size;
> +		bool eop, tsip;
>  		int res;
>  
>  		desc = IGC_RX_DESC(ring, ntc);
> @@ -2829,11 +2855,20 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
>  		dma_rmb();
>  
>  		bi = &ring->rx_buffer_info[ntc];
> +		tsip = first && igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP);
> +		eop = igc_test_staterr(desc, IGC_RXD_STAT_EOP);
> +
> +		if (!first || !eop || unlikely(tsip && size < IGC_TS_HDR_LEN)) {
> +			if (first)
> +				dev_core_stats_rx_dropped_inc(ring->netdev);
> +			res = IGC_XDP_CONSUMED;
> +			goto xdp_done;
> +		}
>  
>  		ctx = xsk_buff_to_igc_ctx(bi->xdp);
>  		ctx->rx_desc = desc;
>  
> -		if (igc_test_staterr(desc, IGC_RXDADV_STAT_TSIP)) {
> +		if (tsip) {
>  			ctx->rx_ts = bi->xdp->data;
>  
>  			bi->xdp->data += IGC_TS_HDR_LEN;
> @@ -2851,6 +2886,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
>  		xsk_buff_dma_sync_for_cpu(bi->xdp);
>  
>  		res = __igc_xdp_run_prog(adapter, prog, bi->xdp);
> +		total_bytes += size;
> +		total_packets++;
> +
> +xdp_done:
>  		switch (res) {
>  		case IGC_XDP_PASS:
>  			igc_dispatch_skb_zc(q_vector, desc, ctx);
> @@ -2865,8 +2904,8 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
>  		}
>  
>  		bi->xdp = NULL;
> -		total_bytes += size;
> -		total_packets++;
> +		ring->rx_in_frame = !eop;
> +		work_done++;
>  		cleaned_count++;
>  		ntc++;
>  		if (ntc == ring->count)
> @@ -2889,10 +2928,10 @@ static int igc_clean_rx_irq_zc(struct igc_q_vector *q_vector, const int budget)
>  			xsk_set_rx_need_wakeup(ring->xsk_pool);
>  		else
>  			xsk_clear_rx_need_wakeup(ring->xsk_pool);
> -		return total_packets;
> +		return work_done;
>  	}
>  
> -	return failure ? budget : total_packets;
> +	return failure ? budget : work_done;
>  }
>  
>  static void igc_update_tx_stats(struct igc_q_vector *q_vector,
> 
