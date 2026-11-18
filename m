Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795026193;
	b=PkTVoQd7JALSC6c2RSyqoP1pZpTvf4JMLqgKe6Dcfi9NxQxTeZpkXKB4eFuruS6FI7i8
	 DQVENLccSnvxaXu1JbAfLSG9oEOjtuIzxxKnO7tbWsU2xB3IW/TV9SKKJseE0ZTRifevP
	 LfsVdYbs+6EkGy0EaSiDY+Couz3wt1c6Y7JfTkuppGWShf9GlJnli+j7nlFtrDsKcOqo2
	 lN+dAmyv0et+ucHEGPq5RFZy8G9OiRtU9h7oVxqqrNYK7WzXRqzbITYttSX30/vS14C2f
	 OvDyOGSIJrB6NXiVAj4zNOCg+dprO9rfWKUttOY8UViliyTmIUMn0Jn0q5HLy03tpzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026193;
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
	bh=Yfx8gme7Utzh42maFjHgIunaQTt2uwHTnEo6K2ro080=;
	b=plpovv0n1LZS+41SV9kof8qPCmFUc6ICBAIPau4QlpelAMfHVC/WDhSWC9ng/lKQP4vb
	 28ow1zI9xNv8oZWpL3Hgre1xc1h+Z/gxnbYbHEIGTpWDrba5lqi28by8uYA/IsA7s8XFF
	 PkjB5dxdmciK6ynOeP0Wx/Upzfg5FTfwZaxjcV6zQ2yNzPD2eLbALe276ZZSTN0GVMSCJ
	 QfNKhosGozvA4d+QGGbf87LVC2G/3g2ew1m8NnzhMBFNi+yhtBRGbuO16e/crl0J5q0Sx
	 sWc66GZoIQeZqEtO0wztbYZg9eKUa0B7a2AWBEFTdGri/wLRW08tGGA4Gi1ga9wc9yQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="h3Yv3/pW";
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AWL5kndn;
	arc=fail smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7247F60A5BD2;
	Wed, 18 Nov 2026 18:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7247F60A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h3Yv3/pW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AWL5kndn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795026192; x=1826562192;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SjVcrAQ2svVAd97HrXdwBqNb/VzNAI+PxtGT5u+qcjQ=;
  b=h3Yv3/pWM0zioruDJcN1bejsPE7CHCnQUoLyAKe+eUxCGlGjPOrHpXfm
   WYyieF1jQKvzCp3xKWzX71ZnCuGJ9xIh9NVbB9RTwnBnb8PApeMMKe03R
   Lda/Q21s27D/AC/4S93c+Ni+qOfoDSIsPgKCsmn1QnhCNfviCzBP5/WjY
   2wpVoY7I4TwApgWFcIWyEl+vS3wdgYfJ/0V/or5f/HYEMHrthQfgLDD4O
   TEJVORETxMSQLN6aaVl1q/2qRNuO65BURxqhJB3ff2pLngVP3ggnlFtb2
   wBt5cm9xP1QxEizFN4Bo6M3n5nNYkBdbCNQmrI+6FgoemCzxsOE+tjWJo
   A==;
X-CSE-ConnectionGUID: W/RdWv3NQAeapzoullJFQQ==
X-CSE-MsgGUID: ifTmeuTNRFGnJTKus32QEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3842203"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3842203"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:23:11 -0800
X-CSE-ConnectionGUID: ASr1WO3RSXiHLPHfUKHT2g==
X-CSE-MsgGUID: 5tvcO26yTumTuAFE6M99yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="11952437"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 10:23:11 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:23:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 10:23:10 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 10:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFzVjliMvEUPCKR2vUk+FeMiDVrmLn70sv+XcuABpejOK+eA6Wk3Ros29SM/9N4VzzaTsmEVeerFA89s7w6Lh0dgVpYmZTHRxjW7mVfEzdLqwpmAPugUBsN2H9r7y/j3Dcmu7LYeE5E/J5K3f8crYBiTToW0rGSiqV2myaRJFJ4/H3GOoY49iybVvJ+BNynyA7n0FmVybpbSvD0FZaVdAl9B8mpu265u1iRNrCRx2YHqxrlhG+Cn47aIG3S4SYWn8+bjIU0i9dkMOL1xcZ1lexZwanuEt4bfQlcHSK02ZB6yDb4dBwEjulfoLfTKMgJAfiSHZQiyDlDI7bxBuN9cXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqRZzkjsrxDJEKXSBKvERao+Xu0T7idZU5DXzgDcvUg=;
 b=FtEjma/NFnunqPQ4jDktfuav6J/iHoOorqAC9dQ99wD2milLD63+JJm4e3TUby0oQVQ4Jf8OEJGcBFszWLljf1Ahs43yg0Zd1loVN9xlEdUob21FOdtY5S+MxxXqo0w/ZBmbS9fvd9PssPpMCXj16yOUhogr5jr3jPCzhnVGXhfP8RfJM8Yk+SAAXgkF1Y56VoO1X3UWvrBCUZm0oMJ9TJ1YiuQL/SyJtMBjNAx45LExpUrhPdcf932sloPXIDK26n6Hza5gQowiMfCJxfPYyWxuxWT8CFirTdXbE04RvwSWG/7Y0vgK1w+T6rNyv6Z5588H59U/bAyi7TkdcqEZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqRZzkjsrxDJEKXSBKvERao+Xu0T7idZU5DXzgDcvUg=;
 b=AWL5kndnS41u8N+aAgkXl5NlsThf7WsCFhNNYVTgA2y5yvJOPaadj90746CHhkGsEyc2xHPa7sv+r8ZqXS+XeA21MImQmbivnPIHi2mjUkT4K5CrwnWgmBebqdpO73Kqvr0pb8Umk7Q9fENai/sxYzuTjpTsgAY0lk9G/tYqPO4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by CY8PR11MB6913.namprd11.prod.outlook.com
 (2603:10b6:930:5b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:23:06 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 18:23:06 +0000
Date: Wed, 18 Nov 2026 19:22:57 +0100
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
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Jason Xing
	<kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, "Joshua
 Washington" <joshwash@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>
Subject: Re: [PATCH net v5] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <av3tAd5kTyxfmo1S@boxer>
References: <20261113-xsk-zc-rx-double-free-v5-1-6ead3af4d131@vecima.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261113-xsk-zc-rx-double-free-v5-1-6ead3af4d131@vecima.com>
X-ClientProxiedBy: DU7P250CA0023.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:54f::11) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|CY8PR11MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: b89072d6-532c-4b6f-dedf-08df45a0fd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|6133799003|22082099003|18002099003|261009223027099003|56012099006|260925022911599003|11063799006|260925021311599003|260925021911599003|261026121527099003|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261021121427099003|261022105027099003|261021135927099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: 94VWOI+fjCbpBDzv+cxnM1/7+IuRcU16FXpt5HViTNk/IlzNS4psp660QExGyJIDQ5ON6hqbp5gHK189faSILfOECeBNZnAp9cZKa5nbVbcHmRgrXz+HELl9JYizOFrQqH7kdQnZVmSTWB1+1w+fgxM4pSwr4FBHOKyke4NRYnr0R2+DX9/vZUFV3j55hiMHmmaWkTEqOc1iPGWNArlVq7qe9LTFJ4muMz/ZBLVIZYDXxATd2ckdSMENIFGGWLs8WV51j43zsvxFZ9xuD5FSNTbKCOv3g+z0sxWxfF+AzZDh4ALNm3NzQ4hTVIBnRFXAtIluCsm/Z14xXSGTMplyXirllpXNAfBmeCIwXAlm/hanfRs/WSm4Qgr3Na5YIanvJ5ojllFxZKqWSlJAGaQDlEWJrSnQ5Ojm61Pm1lwmuw2D86uzSB4hPY9/VpsTPkMimwYsCgrFMjGm5JHC6qFJLrSsd8tMdskKg+3jsVgP3VrayPl9TwXhK75L1iLwPq7ne5dy7zg3N0nCmSUgag5eGSdf/hGsaeN144iJ+M1EPGJpVDM9cjn2Scv4wjQgVG3SnPI/y4htARvodenoqq0x2OLcVMeYopX8eRBdd6PFny1+Y+143s2sK9wr1gBzoVGG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(260925022911599003)(11063799006)(260925021311599003)(260925021911599003)(261026121527099003)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261021121427099003)(261022105027099003)(261021135927099003)(261021123027099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XVVdColpW50j7e8brx077lZEQGzziNCMOZZ6Yg1qpoyVNS6VHzxEXo6+pz?=
 =?iso-8859-1?Q?Um3RjuAGcjU5/o9nhWIeq0TerqETBOINGmyy0aJ72L/l0gWsoxHbqVYeiJ?=
 =?iso-8859-1?Q?UJPOPNHHfrZJP+8jV0wYtMy0OYYaWfJBvRlPwN0nMJGWk38V5v4MrqR9BD?=
 =?iso-8859-1?Q?KhaNbo5eX2dtWzUIY5u+Wxs8iQRe2+XHSaSFnngitRDQ0TgqXhlUQaGO4a?=
 =?iso-8859-1?Q?S2PSZfd4+EzwAOO7hCvEb5l5t4sHulz4OLsz4RmiI21z5TGfky6fVL3MWQ?=
 =?iso-8859-1?Q?G/owlzALejEKw6fV+f9jZYoff9I/Qr+tWGevoXxyqL4sPFzHfQX8vrLf94?=
 =?iso-8859-1?Q?oA8cGVxG+hqrEubPDn+sR3xt8J/BXdoK3ybxbg0KmZgdhPlnyG+XOH3dMU?=
 =?iso-8859-1?Q?i13teNcXHOTMsGTbgJuQjmiz5om3CRQBJSnr32ygMYXY1zdkaOcfCbujiA?=
 =?iso-8859-1?Q?4IKH/Npxcd+v+qhKe9NwVEdbVyT9ajY5o0+M3s+qq/35MT8t/yveS5Jipq?=
 =?iso-8859-1?Q?vXlo32PStL0KaYQm8fMe0kxsYdVxDs26y/IW+3WGvwdDP4W/jTvT33O/HU?=
 =?iso-8859-1?Q?jENdcWnmyT95obI1ZTgG/fZ6EFHHR2v+DYDLhqaVJbzeTVeb6tWp+p7Q8K?=
 =?iso-8859-1?Q?lKZfmajmhKarUJ+HmSvoDqEnfaW41O/MnGXJoOG4RSLp/plgWFV9vgxC06?=
 =?iso-8859-1?Q?tozLAEHRoK7eNlZp9RxLjc/xoYsRJ3CcdvFmoQh3VoZCGQMcF3Ss8o+OMD?=
 =?iso-8859-1?Q?iNPNu4XvGyC8CGl9wAfOaxYTfCzJIKqXFfyyG0HAsnNP8Il/UcwegReSuj?=
 =?iso-8859-1?Q?JGZOoU1UWHX6SZX6xjnZTn4rj6kobeq3AMR9xvu2t4xc9yy8LFRXNXvZNs?=
 =?iso-8859-1?Q?wNaG3B1uAg9o7GzY9MPSPiYPA7871liZxYgFooficnkC9HQYTEe7WcWIc/?=
 =?iso-8859-1?Q?v5S7sdzqxayTkD77WvlVM8FIFpCPPsxdT18q7SCPGKTWO9QlD6v60xQ9a2?=
 =?iso-8859-1?Q?x81dfd88bualcMjXN4j0uYTYJOe6KSMn8bxNLSvcs0YN99lBYm8UE3kpGx?=
 =?iso-8859-1?Q?T3SW0eGI1e2u/ZDI3MM3cdeIBUuzcR6iueIaMRqyd82R9JdQy4WejpGnHV?=
 =?iso-8859-1?Q?8Z+KRBIv1k84TlqAK4sr073JHs/DhhaZYOC/nfFtErlXV+kYya+AzWAwTR?=
 =?iso-8859-1?Q?y9WnWHgcMGwlyHgwd9r6BSNIY5PGve1wnexnXDHbL1fbTmcFI9A0okV7r9?=
 =?iso-8859-1?Q?81jtdjWQwy6EBM3EGW5iOUeaD+sB2UYYj07FBinp6TilY6xb1v2AJD5IW2?=
 =?iso-8859-1?Q?uWkPFnd7liVPGjkMSJN1OKvq0zXFA02HkjnxoZj10k7yVoOp7CkkfJciT2?=
 =?iso-8859-1?Q?30Snc93t4J6kVYwvaVjbdVL5oag4soZeap/eVQRqbQQMn4hqJO1yXagy37?=
 =?iso-8859-1?Q?csfybekcvlgIEHbearzBF5r6Q9dGC8iX9vSmuimqF1QrvV7SZU0zyT7dMr?=
 =?iso-8859-1?Q?21+bDJ+sPLE+WV0dkcd8p+qbilQiDyPrH/FHe5COA6pSVX5DMpNTlcW64K?=
 =?iso-8859-1?Q?BnvOo6KlTysrk6lRR5dxhnPmXK1o41wFbZXp2XJfHbU1gjEoQspk4QU8Yn?=
 =?iso-8859-1?Q?9bnSsJxe1PCvnQ91QPtzlWib/93pBFQCA3y/C5jK8gIjncLy6ntpHkveBy?=
 =?iso-8859-1?Q?uBHEwy4CQxOsTBrQJf3hd2ujDuj3wW+H9agpYK5IYXHQc+Ash2RNCLATsi?=
 =?iso-8859-1?Q?gI4tBgV7J0bres66Q9F3I6MyWqODFev5G/qCeQgH9DM5p/rq7mo0wUQiA2?=
 =?iso-8859-1?Q?27p3TRNPCwqnx4EvO6lwNuIBSDTGAY8=3D?=
X-Exchange-RoutingPolicyChecked: UEsaIsXYbEp+hJupskxKw6neZaTAE1WHjmfhbTom+XWq7+2mF44TNMXwJLdCMbKy4TNP5Yt1Lt7eaDaFZVh2TFvo5dOjttD21F/Iiw6eTs0Dzg2ZIqf9H2jOrOqbh6mbO9mGkRuE2dLua/8dLOLD+GyXcDEVoYSN8CcwBPX7BFqdBduSndkYqdx05lCVwWlFIjq9LGiA6wTvNuVKHfSSOHgxowRl/+DmqYp39I1GLZWbJOJksbflhR8bRF7pNGZ45UUYO/L+AJRrfPhpfOfjdYxf3sc7VEoEaLxEY3TnV/wdeMk4/cMPPhPlY12XPO61JfJsJEd+ABlD79iD6ubi2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: b89072d6-532c-4b6f-dedf-08df45a0fd75
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:23:06.1081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rvOn+p8McWIFcpldQvdhrt9BE+Li8zL4DGgwudXcthMhwm324m1rDc7SyJfZJywdZPJm5z4dWuCSF5oLL8IOTtENNOs65+HFrKmvOhrdXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-OriginatorOrg: intel.com

On Fri, Nov 13, 2026 at 03:27:52PM +0100, Marcin Knap via B4 Relay wrote:
> From: Marcin Knap <marcin.knap@vecima.com>
> 
> When an XDP program redirects a zero-copy buffer to an XSK and the
> socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
> -ENOBUFS to xdp_do_redirect().
> 
> A failed xdp_do_redirect() leaves the buffer owned by the caller, so
> the driver releases it as well. That is harmless when the driver frees
> it right away, as i40e, ice, igc, stmmac, idpf and most others do:
> xp_free() ignores a buffer that is already on the pool free list. It
> breaks when the driver releases or uses the buffer later, after it may
> have been reallocated:
> 
> - mlx5e treats the failure as XDP_DROP and releases the buffer when
>   the Rx WQE is refilled. By then the buffer can be in use for another
>   Rx descriptor, so an in-use buffer goes back on the free list and the
>   same UMEM frame is later handed to user space twice. With striding
>   RQ this also ended in a NULL pointer dereference in
>   mlx5e_post_rx_wqes().
> - ixgbe keeps the buffer in the ring on its need_wakeup -ENOBUFS
>   (XDP_EXIT) path and runs XDP on it again on the next poll.
> - dpaa2 hands the buffer back to its hardware pool while it is also on
>   the pool free list.
> - octeontx2 returns false on a failed redirect, so the caller goes on
>   to build an skb from the freed buffer.
> 
> Leave the buffer with the caller on both the single-buffer and the
> multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
> do. Make the drivers that relied on the core freeing the buffer free
> it themselves:
> 
> - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
> - gve DQO counts the redirect error without freeing the buffer.
> - octeontx2 now frees the buffer and reports it as consumed.
> 
> This covers redirects to an XSKMAP. A zero-copy buffer redirected to a
> devmap, a cpumap or an ifindex is copied by
> xdp_convert_zc_to_xdp_frame(), which frees it before
> __xdp_do_redirect_frame() can still fail. The driver then releases it
> a second time, and the copied page leaks. That path is not changed
> here. It can be fixed separately in xdp_do_redirect(): copy the buffer
> without freeing it, free it only once the frame has been queued, and
> free the copy on failure. xdp_convert_zc_to_xdp_frame() itself has to
> keep freeing the buffer, because its XDP_TX users rely on that.

As discussed with Jakub, I'll take this over, now that Marcin is off and
will address the paragraph above so we fix broken behavior once for all...
until something next pops up ;)

pw-bot: cr

> 
> Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
> zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
> with the Rx ring. With this change no duplicate frames were seen with
> striding RQ on or off.
> 
> Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Reviewed-by: Björn Töpel <bjorn@kernel.org>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> Reviewed-by: Nitin Shetty J <nshettyj@marvell.com>
> Tested-by: Jerome Tollet <jtollet@cisco.com>
> Signed-off-by: Marcin Knap <marcin.knap@vecima.com>
> ---
> Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.
> The i40e and ice changes and the multi-buffer path are build-tested
> only, as I don't have that hardware available.
> ---
> Changes in v5:
> - Commit message only: describe the devmap/cpumap/ifindex redirect path
>   and how it can be fixed separately.
> - Link to v4: https://patch.msgid.link/20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com
> 
> Changes in v4:
> - Commit message only, no code changes (AI review):
>   - Drop igb from the drivers that rerun XDP after XDP_EXIT;
>     igb_run_xdp_zc() turns IGB_XDP_EXIT into IGB_XDP_CONSUMED.
>   - State that the fix covers XSKMAP redirects.
> - Link to v3: https://patch.msgid.link/20261104-xsk-zc-rx-double-free-v3-1-11a0c7ef1973@vecima.com
> 
> Changes in v3:
> - Target net instead of bpf (Maciej).
> - Reword the changelog only: drivers that free the buffer right away
>   are not affected; name the ones with a deferred release or reuse
>   after free (AI review). No code changes.
> - Collect Reviewed-by tags.
> - Link to v2: https://patch.msgid.link/20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com
> 
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
