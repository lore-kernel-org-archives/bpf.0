Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795689010;
	b=cT5BbZE45qcg1cuwhm6pfLA+qBNTckaFw5PvpREax+LCdVVneXmOKBtiJjRT8dGaKxIm
	 drp28lqBjE6dCeirLgmY6sBgtGeCw/kLPWgSWJphqBXcdwNhT7jjSzX/2UDjwWR5BPp55
	 hQN7ktXnKBzIyOyze+vlnMX79kGzf2ei2ys2RcRKmYAm0pEWAxAkXL7w+uv1//ugtIIDq
	 CnUsNnJ9+xPtC2ujrDvHkj4QyqUGNVGFJutjoSuEUFO/aoBmOj9SWVLJqAZ70yiiVnXJU
	 OqEmo32ROogEK1iBuIRvaeCMYu1myk9CugDyF+sa5nsbTBx7m6R/TfKHwH8P31R7iNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689010;
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
	bh=I1ohKfVtOwQLqn2n+pwboXTDUrsSxODRAp+h1jV8CI8=;
	b=M2g2g7/BwaFgUiKImPPs9ce77Wt9Zj7pshgs2TMzLzC0bxMOrUZGGaApKjcExVXfzcyY
	 NxQ77IUnSr3GCWOEXueql89reSHP31/TNjABeRXZkuzZ6U4RgjTTZmEATOlNbbeGPMFhg
	 gFPQBlSCk5ommOKTlkvmehDHZ6QDNxbQ0kyFRy5lD6BaGUwRiN/PLsXYceMpWtOUpNRVu
	 xpJvvEeU6FZ/k9VctAnyrPsqitMk+xCQjCC7CwFTzHOhB1m43fRDit/mQnmhtSS6tEpNE
	 FQf2vxK3Pk5vvmwD0+kt58Lx/7L9Gj/Yn7Gvwl0Qnw110lL8wxkvTIxHj8WMV6mHKbg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HkXBVnGb;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bPkmmBh1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3B606A683;
	Thu, 26 Nov 2026 10:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F3B606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HkXBVnGb;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=bPkmmBh1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795689002; x=1827225002;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eZH6TcGsCQcHRzu1evejJ8A8EV5++jJD/pfKj58cCbM=;
  b=HkXBVnGbjLYfczctFUtWTCUkV0IK6yjvQ/tXfq0q9P9ZpZPsJjWvO/bp
   p9L/vxBphBH2pFYesxK0PWexpAr5itEOWDqIjwfTUJ8ZnH+CfcZpwzStw
   mMuT/9MMILv9RX59N6f171XM1tmwXSei0O/B4DqJMM5UTbxBaYsui/UwP
   /lv1Cb/QepOjAHl6H3KduWEljRGlZjIPsXLTH3UT4gMfQ05AwusKEuT3j
   ARFlodCC3p/LgqyZlfNbDk7xf7hh89vhK4YE9/U7/2xXiyffaT0Uwb70i
   qe1f+yytEU5ToQwviZdscsYpLM2Gv2uaeP2EtHh+IR8jMblK0GqQQhDDd
   g==;
X-CSE-ConnectionGUID: xrsVCMdGTn6hAHBr3mtWjA==
X-CSE-MsgGUID: uqkG6EzgRs2rEAz6gvMpAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4546291"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4546291"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 02:30:01 -0800
X-CSE-ConnectionGUID: ICIhEWHtSm++WX6IQ5S0Yw==
X-CSE-MsgGUID: NHYS9fQXQXOMSqNZGRxIVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12140566"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 02:30:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 02:30:00 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 02:30:00 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 02:30:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgSJiU3qHWd/iy4f/I6YKO1eeLD20JJFPu596lJg7WGpXVCN683u9LePWtRJHBBkeu6BhFH1gj632Qed+hnkx+wQiBAY4V858ckiz4RtkuJi7b31GimQN5HRpYyen6RM0rpOs7IrTJATE2f3REx0fc0qFcuUA0obmfvJTSM2/Oi9mSTMIZfZf/Hx2lFmhPU3V7G1+K13h9hRoiSYa+vPRTTrmySYWgPvOJLUjDV7TJb9boJ2ug/nqYMAAxZSq2huG+oiFsYEcVj7FSEDXIZFENmrp/kjULFSYHce8QBoafRzH0syRH4/iijDRgtYHNbh/r3mR1ZaRF4Zdq+9vhwFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1ohKfVtOwQLqn2n+pwboXTDUrsSxODRAp+h1jV8CI8=;
 b=xYSO/Q96WWS3BTrlEAapx3PA9L6UoskiKtOZ550mvNfTcve9VK3hFUz1jnk99sUoV9jjonHMEz+jWCS1Zk0baqQHuf1nni+sTVzd7byNkz2VVrt2PIuq1BruiTd6vyF2PQAVsYe2dWCotd7XezJdZhF0IR4GAbii0nwRkKJawu64rPTW45dp197MbthEGg3wivKyPDn1IZWVk+ddJe3vcVGQxXNaUpEYtLsOYoWxddtpj9PcjhQ+cNIZXFQ81WEk+uzElR0AeT1GVkd7Qt5KL5G1s+CKjPHPh6wkxWV0oJTiHV0aYVcc6W/bdIHbX91iRZjPlB1YKwI2jkcKNdTwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1ohKfVtOwQLqn2n+pwboXTDUrsSxODRAp+h1jV8CI8=;
 b=bPkmmBh1YuPWaPCfzHy7hAcODrGkKtybq76PhALO4/NEzIsXGGCLjqBKFqx57erdpOeVYdcOLjqVuWUO33rmOQBGfe/r/EnzAuexOXmRuECOtfeMot7T0fGZ+00gVWsFulvIqOvG/mUVj95Ldk4eFUIh0sGoxo9CtzdqPty64k8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SJ5PPF8F93806F5.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::845) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 10:29:58 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 10:29:57 +0000
Date: Thu, 26 Nov 2026 11:29:51 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kyuwon Cho <kyuwoncho18@gmail.com>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Willem de
 Bruijn" <willemb@google.com>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH net v3] xsk: keep the charged page count when pinning a
 umem fails
Message-ID: <awgKH2CvNzkpgMYE@boxer>
References: <179562059260.3381969.13546710565371160648@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179562059260.3381969.13546710565371160648@gmail.com>
X-ClientProxiedBy: DB7PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:10:36::42) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SJ5PPF8F93806F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 905bbc8d-53e4-4fcf-efa0-08df4ba83821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|10067099003|11063799006|5023799004|56012099006|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y7m23RggLOBYD0/vnWFCzYCqh0Ax13PkHFJCyiha6DPW5zJK1Bs5v69J/bqs1OfIXY41u80Yk4V87p055Eic0c1qqE5r57BsDudLtwqBfhlV8Ds7LWH1Zh1ed1M9fmqglNL4B7uCKGvsJJHAtcu/+g9s0pswbDUTtlInbKpCwnJKTTH6fIzm5kTzGSNVApFCaY/Ko2OURKCBcGdlNsDU5kuEDOsUeIGvzQOohmKKqZd/IUMXob92kzYEid9sAGK/Q5fWZbAwAdprk1Pqj/7Jb25M4K8PztQXdLWp6QimyAMzfM5TlcK4JxVARkBEcJju9U7e9khBA3szBss+QvRZhVowIrrYwEqBMbKbkrBL1K5ZsUiTJRYdwfFmiHHXGndewAagrTU9W+wUA2UOXbak6mOujQt7zWPoCNJVx83/Dfc5rjIC9fwloAu+YEOKrDk7nSgoSARcJZ/Vh++iEuIUT0gq3s6filvWQsXzrOVm1OGeJuiJvx5Sl1nL8ZgCaNA4ZA/0lg8jw9032ro4rAfRUCukMyMfAL1ZcqtfQjfIeTDOBtmV6o7T5F6sONOxJkmUHYMggD8+JmFEqwxbkSscyPa9lNn+Evfcnbql8Inmjr4PoHMdwuKcFtkjRxRIl1kB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fRwxSCf3oUuAIO+qNmv2slGVjC3vkNUMSdgCminRMBTA4cqlYWkax2ohPqK5?=
 =?us-ascii?Q?6lvv20BHJ1qfSxX89Xr+0rgOXnjOGwXwJVs+yOE8xIRjF12Yl4E+9OHJbXuu?=
 =?us-ascii?Q?T201Q7M05bigOK5od2GAbTs0GqsrcryhO+sGCWaOIbGv0kEj8agKl5s4TTaB?=
 =?us-ascii?Q?HhJyLK4DITD1psKzf5VG1/GrSrQm/QpELP5Fuh8Da14bp37d4exO3zNqv8aw?=
 =?us-ascii?Q?kqNeUSFFsnUvHp2DfXfjgbuuCgXb2a/a+0elrROI+8vQEmI5DjcgmRZ8yGv9?=
 =?us-ascii?Q?FNBm4zMiKPgSw8XKIos8C4UJ7oizFKLnhg5twB7kz3LGyBqOSGxxXH1TaZW6?=
 =?us-ascii?Q?qjr7YuArZcJZx+YVHDsoVgGEck4u4ClR91lKCxD8+P3zJwmf+WrDOrdfDmwZ?=
 =?us-ascii?Q?qeYCleegNpelDLjF3tYTw0CEUtVxbl/Jpw4vD15WdPC7cBUXQwT6YQclUG8L?=
 =?us-ascii?Q?PQmM0lIjBb/G4QSfaewCnlq9rgFswiFSiAZrhxEj9KNX9uxI74My9sWtTp/A?=
 =?us-ascii?Q?4mxBfAkVU+1e77o5AAQbBD3aJECkPsWPYH+uxMWehgpUdoBhXK7SrgdMCflt?=
 =?us-ascii?Q?IVEG0KzQKlPIGF2q6gGhSfO6jAW2xu0VZl2bQEhN5ehonzAXXOEUwN48DMCu?=
 =?us-ascii?Q?VVPelgQJPQN2FtxNE1QCZ+aprvsAstah8nA0x7BCSHVzczI3VwtO88z0tR2r?=
 =?us-ascii?Q?c0rj5GOBvY80ImJ7IQkSAl8a9wzZPoxMoDQFKYWXUzkI6gugLBpmgZr+rthZ?=
 =?us-ascii?Q?HJ3kQULePXpGYynFr9SfmZNLG7nZ6rZ7ONWQPY9JFfJAYDFeJ7Ahs0lsjVly?=
 =?us-ascii?Q?/FgtPBVVlayOcKnjZZ3doNOvLrSmZjWULDEQK4GvO/92GSJHRyI34SA9emZq?=
 =?us-ascii?Q?h1PXljuj8nx+/JKPiMFPjhj2OcCgqijZVa9DaxZd0NeMZLoMPnZ6g8WbJJIW?=
 =?us-ascii?Q?s93EQJN+tF5n6JLp8lMxEkKi3/Vde4w30raSEeZSAq/AVYcE/A1vvSofzsq7?=
 =?us-ascii?Q?eaDnf1DvfTG/1nrmtPVXLXT6+r+g4g+ST3suzBjoPpdF7UR1ELtPviMIF6j9?=
 =?us-ascii?Q?YPolBE9QAtvwFm48Iug/F2rWcEYCaVptYuFNuUdfHmr3poMkh68jizDbxiyf?=
 =?us-ascii?Q?wZZIcCswknBglLVDJBZh4kOlvNkqwZvy9jH74WTyR7g78nfH/oYmn+WhiFjj?=
 =?us-ascii?Q?Rbutr9oSHo68z8Gwv96ZpQy0NPDBIYZtoOzsBuRdsefnimpuEzYMrf/kNxQd?=
 =?us-ascii?Q?2N1HxtcdrtwtgItPoJQS+T/Bx8plAarqF4DoG/0+qdXbtSdLNS1FkqbSn418?=
 =?us-ascii?Q?MrdU/Yr2eU0W7/Oz2kjHoWG/1N0tsLfZ+sQEOrYOZqYYCNLdFifKKFyLb7+i?=
 =?us-ascii?Q?ZSgWLw9szOmev/S4UNOvhWNsK3Z3KPq97mZGnuwsWzj98+6yd8iTZw3wBPzc?=
 =?us-ascii?Q?0rqfADl1pvuNxhmriMUTOtvvKDEpuesclkJn8TAp2TkrH7lSl9TfPvjyrxt5?=
 =?us-ascii?Q?Ji0rVXoNbgFx+sdfAcyiD0eiVuYDX4jGsCDADaMYZVIllYVgX3K1jcBf82C2?=
 =?us-ascii?Q?erPQ4RliiO/fD39pyrRAak76MfTxm3+JYdtoS1dYt+0JJq9InDYrqiAyg+LV?=
 =?us-ascii?Q?j5+7wVHyw3RdM5LSwOfH2B4nDMPfr0N8Q8cCLrxn5yLeWKjYTA4ryo83DVHl?=
 =?us-ascii?Q?IprLqjlVsI4gbks9h/Gm+YiF70kj7Pmckw9RMFj5ZozBXXKufY8hZwAPRhzE?=
 =?us-ascii?Q?xYnfJLp/e63zGqs7UPeJlEPgCZZKbfY=3D?=
X-Exchange-RoutingPolicyChecked: gmOYFHdafNrsqtWMAlaPodqlFJZtLdazV2Q8swiVmUGC8X+MM5vjKMMG93iU/nOwgs5aU6e7435UBP9+Z+qx7SZGJww9zy1eBPWNPi42w3emDOwbEZpZZYvQ7iZq/aBgjUo+x3+KrGxeUDheHHcsOaoEXsxDEkjd0YGg0giXwPKED/l0T4rfurrskTfINz84RiT2V0VPXyBxaWP5ljIL5hnfuTIMoW5IiU3cJ9sJ6BIu4rn6uHiTFW3UKlRBYyMwD048X4a8t1e6EpEi2QLaPHPlLqeJtSGqH1HfJToR4tng9ZizTaxsKIqxEXnUmAHdMGii/pvrwkA+SZEBYbPgQg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 905bbc8d-53e4-4fcf-efa0-08df4ba83821
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:29:57.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mk9VeF9ToFSc6iGRYAHvCj+mjgWdGMVJeJP027y8Cj/K1S1MSikMTCU3m+n/jUWLGwknFMX1/6iY4YHGGbQTUAtygTdEoD1moJHMXyXXQDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8F93806F5
X-OriginatorOrg: intel.com

On Thu, Nov 26, 2026 at 11:07:42AM +0900, Kyuwon Cho wrote:
> xdp_umem_reg() charges umem->npgs pages to the user's locked_vm before
> it pins the umem. When pin_user_pages() pins fewer pages than asked,
> xdp_umem_pin_pages() overwrites umem->npgs with the pinned count so that
> xdp_umem_unpin_pages() releases only those, and xdp_umem_unaccount_pages()
> then gives back only that many. The rest of the charge is never returned.
> 
> A short pin happens when the tail of the umem area is not mapped. With
> RLIMIT_MEMLOCK at 16 pages, three registrations of an 8-page area whose
> last 4 pages are unmapped leave the user able to register only 4 pages,
> for as long as the user has a process running.
> 
> Unpin the pinned pages directly and leave umem->npgs as charged.
> 
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260421172951.A7052C2BCB5@smtp.kernel.org/
> Signed-off-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> ---
> v3: simpler error path without @err, as Maciej suggested; Bjorn's
>     Reviewed-by is not carried over, as the code changed

Thanks for the follow-up!
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Regarding removing Bjorn's tag, please have some common sense here, I know
AI might be telling this to you but this change was nothing major.

> v2: https://lore.kernel.org/all/179556786851.2007362.7849536379916971930@gmail.com/
>     target net instead of bpf (Alexei)
> v1: https://lore.kernel.org/all/179552079829.1290967.12345053263834529704@gmail.com/
> 
> The issue was found by an LLM-guided test generator that we are
> developing as a research prototype; Sashiko had flagged the same leak
> in its review of an AUTOSEL backport. A reproducer, which runs as any
> user:
> 
> #define _GNU_SOURCE
> #include <errno.h>
> #include <linux/if_xdp.h>
> #include <sched.h>
> #include <stdio.h>
> #include <string.h>
> #include <sys/mman.h>
> #include <sys/resource.h>
> #include <sys/socket.h>
> #include <unistd.h>
> 
> static int reg(char *addr, long len)
> {
> 	struct xdp_umem_reg mr = {
> 		.addr = (unsigned long)addr, .len = len, .chunk_size = 2048,
> 	};
> 	int fd = socket(AF_XDP, SOCK_RAW, 0);
> 	int ret = setsockopt(fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr)) ? -errno : 0;
> 
> 	close(fd);
> 	return ret;
> }
> 
> int main(void)
> {
> 	long pg = sysconf(_SC_PAGESIZE);
> 	struct rlimit rl = { 16 * pg, 16 * pg };
> 	char *a;
> 
> 	/* no CAP_IPC_LOCK, CAP_NET_RAW for AF_XDP */
> 	if (unshare(CLONE_NEWUSER | CLONE_NEWNET) || setrlimit(RLIMIT_MEMLOCK, &rl))
> 		return perror("setup"), 1;
> 
> 	for (int i = 0; i < 3; i++) {
> 		/* 8 pages, the last 4 unmapped: pin_user_pages() pins 4 */
> 		a = mmap(NULL, 8 * pg, PROT_READ | PROT_WRITE,
> 			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> 		munmap(a + 4 * pg, 4 * pg);
> 		printf("short umem: %s\n", strerror(-reg(a, 8 * pg)));
> 		munmap(a, 4 * pg);
> 	}
> 
> 	a = mmap(NULL, 16 * pg, PROT_READ | PROT_WRITE,
> 		 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
> 	printf("16-page umem: %s\n", strerror(-reg(a, 16 * pg)));
> 	return 0;
> }
> 
> Without the patch, the 16-page registration fails with ENOBUFS: the
> three short ones leave 12 of the 16 pages charged. With it, it
> succeeds.
> 
> The patch was written with LLM assistance; we reviewed and tested it.
> 
>  net/xdp/xdp_umem.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
> index cd8643360eb3..ad72bd96905c 100644
> --- a/net/xdp/xdp_umem.c
> +++ b/net/xdp/xdp_umem.c
> @@ -95,7 +95,6 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
>  {
>  	unsigned int gup_flags = FOLL_WRITE;
>  	long npgs;
> -	int err;
>  
>  	umem->pgs = kvzalloc_objs(*umem->pgs, umem->npgs,
>  				  GFP_KERNEL | __GFP_NOWARN);
> @@ -107,23 +106,16 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
>  			      gup_flags | FOLL_LONGTERM, &umem->pgs[0]);
>  	mmap_read_unlock(current->mm);
>  
> -	if (npgs != umem->npgs) {
> -		if (npgs >= 0) {
> -			umem->npgs = npgs;
> -			err = -ENOMEM;
> -			goto out_pin;
> -		}
> -		err = npgs;
> -		goto out_pgs;
> -	}
> -	return 0;
> +	if (npgs == umem->npgs)
> +		return 0;
> +
> +	if (npgs > 0)
> +		unpin_user_pages(umem->pgs, npgs);
>  
> -out_pin:
> -	xdp_umem_unpin_pages(umem);
> -out_pgs:
>  	kvfree(umem->pgs);
>  	umem->pgs = NULL;
> -	return err;
> +
> +	return npgs < 0 ? npgs : -ENOMEM;
>  }
>  
>  static int xdp_umem_account_pages(struct xdp_umem *umem)
> -- 
> 2.43.0
> 
