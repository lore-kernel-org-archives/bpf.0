Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792614868;
	b=JYqvhLXiix5Ihu3UDdZj/FcWktNI+1ZvkfALav2Knk2RraW3EePwaxf8KKe15XXqkWaC
	 g3z0MBudDs4e/Yo9GCIu4FVgXFuuhUxEAlMblsFUjFaome8NW4DWJhE27JPMLfoNigp4l
	 A4q7nn+s9rzdYIxEir7pho2+4sZXiyUFXw3ZH4CKB8sEPf7A4+zHWjDUoL9wNtFzxYriz
	 E8c88XggE4GeK37UCHDo0V0NiD6kcieLOos8YyiuxcCxmRFHV8QA8g4DBE5SNJAFxUVVK
	 yo/DVkf2wP7yOTRmw/40ZqKHUca5oI+2zjKiwP5aLlCUMabOmygmj5ZMFAn3tsU/kGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614868;
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
	bh=p/9gvWa4TjEifvlHbztEFbJAi6uZestVYzsVYZJLaAc=;
	b=vQk33KxARtjzD+gfkYBawQcu+DAZ1tphgQRkQKBRkTPuRx4ANxHNTGsIZcJAawJIboX3
	 /1nIGvOTVegkQ99bOFFQ6vDA4fM7hRcIGX5bxj9elo+9Z41LG5tCQQiGt+QRRDKuVKljq
	 cvPoVJ5NgKE327pwbEVJAZA3uuBgFEwPVr2ZdZ+sC4P1zgk+wljgwuANoh1Z0TbgOAlFd
	 kvPCtan36PbkdqiwqUd1oFvaK9CTO5tCrPAPh5irCp9yxWt5UtYv0jc8jI/eOSUOu/KPd
	 GnLdgtAjFJBLPYg9bGku7bUAhFpPHvUkhseGh2XKqSxyDaSrLonaMdUWtNku4L/jlvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="F+C/dWz6";
	arc=fail smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB15606A319;
	Wed, 21 Oct 2026 20:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DB15606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=F+C/dWz6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792614866; x=1824150866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ALcaRgehmytl1AFNE+us2FYRKfQ1LQFxoQyGZREf34s=;
  b=F+C/dWz6Wu0tyIxsKPoGU/QKg+Bu1Vcl1073B32nCzwBKb4E/71L2OA+
   LKiD98O1nzGE8DhIACDp5Y4G5zH3EBjKJsxVDomoX+H90kfjziJDn9Zfg
   /CvIkcE23wqgzfwrxauXJ7hZYimDhnEThi5X9vQw/S94+saTUTrZ66zR5
   TOPbsziMrHiFHO6qbtKugcyZbZ/m6233DthYIJfUwogUJDOmnZjNid6rV
   shNY1BCM7amHi49Jr3mjnIKTLAbpBPgOl2762buceJ/XjTOTGsajsS+7A
   r6/pX3Fs9QOLQ8EzrlWEQrX8OHRPUGaxMDvmlWrzyoB4atypLi6khGvZ1
   g==;
X-CSE-ConnectionGUID: FELhVRtdQMyQUseBzBbRHg==
X-CSE-MsgGUID: du9O1EagQcSMxYzhMV5nsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1233917"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1233917"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 13:34:25 -0700
X-CSE-ConnectionGUID: c4YAoQE0Slex9En7bs/+oA==
X-CSE-MsgGUID: cW0tpLdtRGmDqm5vvrWXxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3579342"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 13:34:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 13:34:25 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 13:34:25 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.2) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 13:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oxDWG/VosOvsTWDvug+9sWF3fHsDES19iVdoqpP+KHx7eTafi4kELaC252wWydoY+EZRCKL4uSER6NbscFXDQ1C2y4TRQ3ELQeA8RGnnFa3KGlGaCBJSc9KyF5x7QLGqGxiv79j3NgEOEAKqMXNMlv/pOlW+7SibwpF/PKDnkdXZYtaD1h3Ae2Ud+sFoQwSfY6PIQL+8FPLnN2tvqTaoRbL3k/V6eUihnMQWZgvi9gUxO06qik1ToxxT6IS5ONAbSchBvZ5M5gONLpeKa45e64a0+ElpcP0CwowI++O8MebAUAkmshYbiAXMFBYcoHXvBasvAFgUBgCHWe4fLnqW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/9gvWa4TjEifvlHbztEFbJAi6uZestVYzsVYZJLaAc=;
 b=t8FGFswOovB82g+QrmWLEtbi+aq0iRoyVIGimZRMGiKHZqvXf0PRVPwoethQ/LVp3qlZGSno7vcipGGxbufBqb+UkYeMPoJJ/AVXE60BImMbf0ULHroK0dQemCoA8igm77xA2MGFehd6u5FtbxEIV1jfzzqzrjMwlAGf8R61mM1gJFeDJTLunTt0jEH0A4rkVTG8Ph8lbBWCy1QvowrgDs4y1Jd3PsTCCh8FPG9tKFTduOMYsk9u/064A9uiZtC90+E//dSJ/Cs+CZuNlNWW42c49JD0m8hYFAwLI34rLQn9NkvWc5oDlZnBB7eelFjwadwrCkqrz7KMC8t95xABRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB8204.namprd11.prod.outlook.com (2603:10b6:8:17d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Wed, 21 Oct 2026 20:34:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 20:34:21 +0000
Date: Wed, 21 Oct 2026 22:34:06 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <bochaolucky@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan
	<shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <netdev@vger.kernel.org>, Alexis
 =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Tiezhu Yang <tiozhang@didiglobal.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v6 5/5] selftests/net: Move the XDP feature test
 to drivers/net/hw
Message-ID: <atkhvvxcDrzXwgb1@boxer>
References: <20261018-xdp-v5-send-20261008-v6-0-7336e1282ca3@gmail.com>
 <20261018-xdp-v5-send-20261008-v6-5-7336e1282ca3@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261018-xdp-v5-send-20261008-v6-5-7336e1282ca3@gmail.com>
X-ClientProxiedBy: VI5PEPF0000098B.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::80e) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ff211d-681e-44f9-d6d1-08df2fb2b03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|261021123027099003|261009223027099003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003|6133799003|3023799007|261021121427099003;
X-Microsoft-Antispam-Message-Info: HbdmOzOi/fmXMTlJw55kG124jGjDHSN01+YQ4Q69yr1CsSAYeJeqKubdAUOLNxKkaImy7+v8xWw6DBJA3TbXf2gJB07opHEmZjgZeZY4NQmWIz8vS5N9zhEAtznKtl1KIr2ZRQ7g3B4jXrrILA+ZA84QyZ+vLvtOW6ZlJJY85Pe2fcD5i2Uoy6i9vebQ/jS/XPp1cZWhM3UBYCe7H/pnVrMAU+tsYcZxjdV1cCFqUNsT22k7/WVw5Xc874H90LfstAuYtmdCjP27qZZdo1w39Nf6IXzzs1BakleoY9nfrp428iicGRbfuXEWycttf1u2ozlDuf5xTxHyP6BSKJX14GB0TqgQXbtGUstYiFRCkGANlZ7umPzwc5VEdZb+BM7bQFWAvY1zAotRdBQs+xg6kHPGi9KuHt071zxoMBVEvXVOiI4ObD9SIqbGtLTSUKSts4M2IWEhHgRxF6tHQRInf0yi2oMsDNdMjSJuH14213rmg5yP3E8JRtOiNEXBRkGmobEopno4J+Stf72D7nbrQ8ELLLNZ8JyyaRu93AzhG8med7DoUUmUsQsVny4yxNss1WuR1uQu7davCpSvoIQ4DN8hotfZ+A9mLo3DhAFQ1vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(261021123027099003)(261009223027099003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KO7cezpYDNcJn+bfbDqQ3tZeUntyhUMxNZph1R+WqzBynkOqNUzpuANNRXeV?=
 =?us-ascii?Q?US+lsFPKJqAomJoAEWsHlwwzsQAkBmrxe/Lq/vk6fegiiEmNjIFDpPYONxg9?=
 =?us-ascii?Q?X/OhaBOGtEXE6EDj5y7J9G3L7wjIO9zBthQHQGNKpsMWHqrL8rnk4egSHyEL?=
 =?us-ascii?Q?tR6CPxYM67ZJuMY08w2pQ7tw0VRaAqp0X3vk93xF9wQCb1SIiGjK5EhbSPA9?=
 =?us-ascii?Q?gPdcGv1k66BsrAbOI/lfa5JgdGk3GUVhLbrowWr4MhH8n/21GnPKJuUi+lbh?=
 =?us-ascii?Q?orSxGCkH3mctKGZELbcjVM4NGIkYj2VsRAanjDFYV2ToV6Do/ZWTGlANGMov?=
 =?us-ascii?Q?FFxzx9eaVbE8r11QzxsUk5JBKlRepz+TFF+slw1gD4lgtUfbNXTim6dArNPS?=
 =?us-ascii?Q?pmWlMhYYna/qaleUZbgLOxKjq5D+OYoNzHPcYY0XUKqYt/4ZX1XbTEYnb68b?=
 =?us-ascii?Q?2imgqeBa2hsJuC885DK5cKavB33oGiSJlWKKfJb6qkP4wrR3p3nu04aIiUkT?=
 =?us-ascii?Q?RLkYXpjE3/8YusRF4iBsO4TYH7Kya6x1JpY+DaEF6EAaY4zRIaHsEf0ii6+E?=
 =?us-ascii?Q?oSXffd9L7JosyseQ5iLEiz03MzsH1/r4wniB7QfIfkAYcs6aY6bTcTEtDsNS?=
 =?us-ascii?Q?mgFH29PFqMwk253iNs/71XhELp7J/fyn0/lVqcblr+3DfOgr7Yykz8eO3ohn?=
 =?us-ascii?Q?GDz2RAXGcm4TZdEB0aBru9nzP1HtqxdrIiHoT8fiJN5903FfeiY9hK3Dz54F?=
 =?us-ascii?Q?cWOLo4jaq4LHRlBurkMzdkcG7ykHKWt/UPfOtjvkiz6my6uwCh7Lfyy5YwuM?=
 =?us-ascii?Q?WlRLgHPKmmDKH9XMmBpDNmTC8gtMGdAjMSzf0mAmdRHvWhEYCBVTM6wjZ3N+?=
 =?us-ascii?Q?QVq245j61j76KG5bJMzmxtj43cf0ZipaJJ+e38LiJ5PAEnRuGy4PI2cIZhex?=
 =?us-ascii?Q?FFf4vG2xw6cHI8d1n5Xxg++MmC/vZhzbJzhVkJXUPjbdF40/elZnKIbIP7i6?=
 =?us-ascii?Q?HIsIKHmLvYbtZvm3codY2De4/E049U7Ye4QUQPGuLhfkj3L+gqiAEGkyO1OW?=
 =?us-ascii?Q?WUeSjYaVBzobipFy9hy8X3g6MSGW+aLjZkk4AwyDgzPwLO1Y4jFLDOcEBWew?=
 =?us-ascii?Q?EXvRVD77+7eJCsrVC3odQc2HDf79ob2poyG+KSSv+82pyKBDf0fEqJEIEfKe?=
 =?us-ascii?Q?coyhLki0dZ4KdQ580QtLIgx72Zt+hNdBImwP5tLAYP538nUV2lDnS9S/hWW6?=
 =?us-ascii?Q?Qk+MqbgbEZzdId7oYYx7ofeOJus+fNTPFSEAP4nDiAyZGPrMkDRhNG+QR988?=
 =?us-ascii?Q?0/4LMS0WxZpn1FrF6Q6da8dxJdFjfCoduVKyCCR6mREVW/Kty6XGzPTce0iY?=
 =?us-ascii?Q?hz/KRuR39gHmDtqsZHnv6p7zSK10ojWJxwOReYbDJ/DsESBu5t2P99DSnFCR?=
 =?us-ascii?Q?kCwHjphqyxZM8ITbtiIbLLWRqaxwUF5/AV3FE/4utKnORfEF+l8OdxfT5dKA?=
 =?us-ascii?Q?UUYa6nkmNZtbkp/OTqhs1oQFyhoiMsw0aiBMZN1HpViZf8tzvgKhz4rddCvJ?=
 =?us-ascii?Q?rDNY0ZPNjaU0G7T9wz3AUbmepDEI3pbdjpyepoAUpiWGi5kCdY8goG6cLTxF?=
 =?us-ascii?Q?/Tq/s5f7rfQP3FsY+r53tEvztH2JkDw5R7Pod9BczystphK5NaWXSNlmPyWa?=
 =?us-ascii?Q?tfZIq+aX8bt1P74/2Bqvi4VmdSJGsGlHkOezGy5VVteK2ODnifwJr6ofLl4x?=
 =?us-ascii?Q?tyl/sV2caDAPuFM08hzmFaoTi6icVb0=3D?=
X-Exchange-RoutingPolicyChecked: ROa4y82xzNKY/vsajduQbLgypR7sKYzbYzWYB1/q9hrlpnzPvBD2te/YRN05PC8JWttjYR3NAEbRGmT0Plw66UGhkjZ9EcZ27AwEKlyu+zyDRLw24m4mFrJJztSZqbzXZaF6shfefRoTV1hwSZladxEMiLkgdRhLBNP4XY9bssDjethKAVl4ApGf/5lZIGibH7/PwshX1huDxjwF9GVN0C4O4Eiusj01z26G5OR68YOAMKpjxZ8emkuiVxW/gM2gBq942eKgSEgHMuqbMqwPY3e4bL95Fw4TCaisrGAB4tVXecDzjE/k6la0nF02kMuXlaYUglrgMQ2/gn/yjEj+TA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ff211d-681e-44f9-d6d1-08df2fb2b03b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:34:21.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn+E1PSpT25oiaqytjD6hTu09L9t/hzqc5/BWTE3VOvne1ATbZ4jdSB6kyiA1GVXDla7F16vwTBcE/EpgujPxEYqF4TIua/Dw8waDV9qNs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8204
X-OriginatorOrg: intel.com

On Sun, Oct 18, 2026 at 10:05:54PM +0800, Bochao Cao via B4 Relay wrote:
> From: Bochao Cao <bochaolucky@gmail.com>
> 
> Replace the private-veth script with a NetDrvEpEnv test for a local DUT
> and remote tester. Build the helper with the shared BPF rules and
> installed kernel headers.
> 
> Compare detected and advertised features, wait for DUT readiness and
> bound the remote helper lifetime. Pass local commands and scp arguments
> as lists so paths containing spaces work.
> 
> Run veth XDP_TX when peer GRO or native XDP provides NAPI. Skip only
> when neither is present. Read GRO with ethtool without changing the
> peer configuration.

why is veth so special cased here? On my side [0] I added separate test
runners: selftests/net python runner runs test tool on veth pair and
selftests/drivers/net/hw is dedicated for HW-backed netdevs.

Because I assume the move of this tool is to open this up for running
against actual HW?

Also, seems two tools would be introducing similar functionality which is
a TCP control channel. Maybe we could commonize this? I'll ask LLM later
about it :P I have not looked into xdp_features C side.

Furthermore, we are gonna have a conflict with skeleton building
enablement within Makefile, but that's heads-up to maintainers.

[0]: https://lore.kernel.org/netdev/20261016174338.787135-1-maciej.fijalkowski@intel.com/
> 
> Tested the runner's skip, failure and pass paths on Ubuntu 6.8 with
> ethtool 5.16. With isolated veth modules, IPv4 and IPv6 probes receive
> 0/10 replies before the GRO-only XDP_TX flush fix and 10/10 after it.
> Existing peer XDP programs and offload settings are preserved. SSH
> deployment and execution from a path with spaces and a quote also pass.
> 
> Signed-off-by: Bochao Cao <bochaolucky@gmail.com>
> ---
>  tools/testing/selftests/bpf/.gitignore             |   1 -
>  tools/testing/selftests/bpf/Makefile               |   9 +-
>  tools/testing/selftests/bpf/test_xdp_features.sh   | 175 ---------------------
>  tools/testing/selftests/drivers/net/README.rst     |  19 +++
>  tools/testing/selftests/drivers/net/hw/.gitignore  |   3 +
>  tools/testing/selftests/drivers/net/hw/Makefile    |  15 +-
>  tools/testing/selftests/drivers/net/hw/config      |   3 +
>  .../net/hw/xdp_features.bpf.c}                     |   0
>  .../{bpf => drivers/net/hw}/xdp_features.c         |   2 +
>  .../{bpf => drivers/net/hw}/xdp_features.h         |   0
>  .../selftests/drivers/net/hw/xdp_features.py       | 146 +++++++++++++++++
>  .../selftests/drivers/net/lib/py/remote_ssh.py     |   2 +-
>  12 files changed, 189 insertions(+), 186 deletions(-)
> 

[...]

> diff --git a/tools/testing/selftests/drivers/net/hw/xdp_features.py b/tools/testing/selftests/drivers/net/hw/xdp_features.py
> new file mode 100755
> index 0000000000000..dda114033b8ab
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/xdp_features.py
> @@ -0,0 +1,146 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""Check that a device's advertised XDP features match its behavior."""
> +
> +import ipaddress
> +from pathlib import Path
> +import re
> +import shlex
> +
> +from lib.py import bkg, cmd, ethtool, ip, ksft_eq, ksft_exit, ksft_run
> +from lib.py import KsftFailEx, KsftSkipEx, NetDrvEpEnv
> +
> +
> +ANSI_ESCAPE = re.compile(r"\x1b\[[0-9;]*m")
> +RESULT = re.compile(
> +    r"Feature .*: \[(NOT )?DETECTED\]\[(NOT )?ADVERTISED\]"
> +)
> +
> +
> +def mapped_address(address):
> +    """Return an IPv6 or IPv4-mapped IPv6 address for xdp_features."""
> +    address = ipaddress.ip_address(address)
> +    if address.version == 4:
> +        return f"::ffff:{address}"
> +    return str(address)

does it have to computed every time or could we store this once at main
within cfg's built-in dict like we do for binary paths?

> +
> +
> +def feature_command(binary, feature, dut_addr, tester_addr, ifname,
> +                    tester=False):
> +    """Build the helper command with the configured endpoint addresses."""
> +    args = [str(binary)]
> +    if tester:
> +        args.append("-t")
> +    args += ["-f", feature, "-D", dut_addr]
> +    if tester:
> +        args += ["-C", dut_addr]
> +    args += ["-T", tester_addr, ifname]
> +    return args
> +
> +
> +def run_feature(cfg, feature, ipver):
> +    """Run one feature with bounded helper lifetimes and verify its result."""
> +    cfg.require_cmd("timeout", local=False, remote=True)

are there any cases where timeout would not be available on the system?
even if it needs to be kept it feels to me like a pull out candidate onto
main() and skip the whole test suite once, not per each test case.

> +    probe = cmd([str(cfg.xdp_features), "-q", cfg.ifname],
> +                fail=False)
> +    if probe.ret == 4:
> +        raise KsftSkipEx(f"{cfg.ifname} does not advertise native XDP")
> +    if probe.ret:
> +        raise KsftFailEx(f"Unable to query XDP support: {probe}")
> +    if feature == "XDP_TX":
> +        link = ip(f"-d link show dev {cfg.ifname}", json=True)[0]
> +        if link.get("linkinfo", {}).get("info_kind") == "veth":
> +            peer = ip(f"-d link show dev {cfg.remote_ifname}", json=True,
> +                      host=cfg.remote)[0]
> +            if peer.get("xdp", {}).get("mode") != 1:
> +                cfg.require_cmd("ethtool", local=False, remote=True)
> +                features = ethtool(f"-k {cfg.remote_ifname}", host=cfg.remote)

isn't the proper way to utilize ethtool commands is to do:
cfg.ethnl = EthtoolFamily()

Also this feels like it should be within veth runner and scoped at
test_xdp_tx()

> +                gro = re.search(r"^generic-receive-offload: (on|off)"
> +                                r"(?: \[fixed\])?$", features.stdout, re.M)
> +                if not gro:
> +                    raise KsftFailEx("Unable to query peer GRO state")
> +                # The peer needs NAPI to receive XDP frames.
> +                if gro.group(1) == "off":
> +                    raise KsftSkipEx("veth XDP_TX needs peer GRO or an "
> +                                     "existing peer native XDP program")
> +    if not cfg.addr_v[ipver]:
> +        ipver = "4" if ipver == "6" else "6"
> +    cfg.require_ipver(ipver)
> +    dut_addr = mapped_address(cfg.addr_v[ipver])
> +    tester_addr = mapped_address(cfg.remote_addr_v[ipver])
> +
> +    dut_cmd = feature_command(cfg.xdp_features, feature, dut_addr,
> +                              tester_addr, cfg.ifname)
> +    tester_cmd = feature_command(cfg.remote_xdp_features, feature, dut_addr,
> +                                 tester_addr, cfg.remote_ifname, tester=True)
> +
> +    with bkg(dut_cmd, exit_wait=True, ksft_ready=True):
> +        # Bound the remote process itself, not just the local SSH wait.
> +        remote_cmd = shlex.join(["timeout", "--signal=TERM", "--kill-after=5",
> +                                 "90"] + tester_cmd)
> +        result = cmd(remote_cmd,
> +                     host=cfg.remote, timeout=100)
> +
> +    output = ANSI_ESCAPE.sub("", result.stdout)
> +    match = RESULT.search(output)
> +    if not match:
> +        raise KsftFailEx(f"Unable to parse xdp_features output: {output}")
> +
> +    detected = match.group(1) is None
> +    advertised = match.group(2) is None
> +    ksft_eq(detected, advertised,
> +            comment=f"{feature}: detected and advertised support")
> +
> +
> +def test_xdp_pass(cfg):
> +    """Check XDP_PASS detection against the advertised capability."""
> +    run_feature(cfg, "XDP_PASS", "6")
> +
> +
> +def test_xdp_drop(cfg):
> +    """Check XDP_DROP detection against the advertised capability."""
> +    run_feature(cfg, "XDP_DROP", "4")
> +
> +
> +def test_xdp_aborted(cfg):
> +    """Check XDP_ABORTED detection against the advertised capability."""
> +    run_feature(cfg, "XDP_ABORTED", "6")
> +
> +
> +def test_xdp_tx(cfg):
> +    """Check XDP_TX detection against the advertised capability."""
> +    run_feature(cfg, "XDP_TX", "4")
> +
> +
> +def test_xdp_redirect(cfg):
> +    """Check XDP_REDIRECT detection against the advertised capability."""
> +    run_feature(cfg, "XDP_REDIRECT", "6")
> +
> +
> +def test_xdp_ndo_xmit(cfg):
> +    """Check XDP_NDO_XMIT detection against the advertised capability."""
> +    run_feature(cfg, "XDP_NDO_XMIT", "4")

Why some are v4 and v6? I was told to be flexible and support both.
Why we map v4 to v6?

> +
> +
> +def main():
> +    """Deploy the helper and run the six feature checks."""
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.xdp_features = (Path(__file__).parent / "xdp_features").resolve()
> +        cfg.remote_xdp_features = cfg.remote.deploy(

maybe we could refer to these via bin_{local,remote} as other hw tests do?
but that's just a nit.

> +            cfg.xdp_features.as_posix()

what does as_posix() do and why is it needed here?

> +        )
> +
> +        ksft_run([
> +            test_xdp_pass,
> +            test_xdp_drop,
> +            test_xdp_aborted,
> +            test_xdp_tx,
> +            test_xdp_redirect,
> +            test_xdp_ndo_xmit,
> +        ], args=(cfg,))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> diff --git a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> index 924addde19a3e..5e2950a7c95fa 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/remote_ssh.py
> @@ -33,7 +33,7 @@ class Remote:
>          file_name = self._tmpdir + "/" + self._mktmp() + os.path.basename(what)
>  
>          if not os.path.isabs(what):
>              what = os.path.abspath(self.dir_path + "/" + what)
>  
> -        cmd(f"scp {what} {self.name}:{file_name}")
> +        cmd(["scp", what, f"{self.name}:{file_name}"])

agree with sashiko report this deserves to be a change on its own

>          return file_name
> 
> -- 
> Git-155)
> 
> 
> 
