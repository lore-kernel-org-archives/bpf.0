Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793106701;
	b=1TyF90fLthwdqLiqzCSgjghJhPi/2eunRFdTznsJlpXvNF9pt4fWydvzo7b/xHBPmE/q
	 A2ltlECPkxtRna7yF8rHiebMWE5iqCFUmAv9TVCppjMYLCGh1JAl9WX4dDW2c8pJlzDjt
	 zEe4b1FlWAsZ832ryEXVgkWgzT/I91Ff4nXEDCjNM1t+CljydywN/LNJN1cOANJBmRIws
	 +j7GbZkUfTrN7z1nSw1byQOTsktBDN1HeCwMEypAe0odinNdAr+VgWTg2s2YkPc30Uxbt
	 2buzuQ7Q4I/6M5nEQKBkhqq+eyeho2mjW92yK5/ok/dfv6quIDcfhjO95N2tHLiy4KA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106701;
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
	bh=DrEfA9EPvz/k0KVZWtWIHcYml3DmJ1oHWulhi91z2f8=;
	b=bSL2FC94vxBvWO9c5FYa9WjH4IbbJ1C4NkVcEMInLOW6Igbd4PbC9IcqFNe7ang4Ye1i
	 jUlFHwswplB8wR692ddC7lg0urEHorx8TAS6P4ZNv/jA5JVemhFQLpomJv4P2ICPffaXs
	 5tq9C74I9vEGPGfw3dZEmwRUrvxffE3SaDxJdSjaZUFAFDo/Rq9oNe2y9kMoY90djDRJW
	 WdAoFd2V/1dceFAsqKNGIHAiZjHgg5MW3WXqfsZAdYTfvCwrAs8mSXw8sJBKQ7cNyrrze
	 nziEXglL2K83yPjZjgc12rAuJLxEpn+aedfR3FU5CJN8tOGiMe2vo8plyFb0gozlhVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0uGN5Ye;
	arc=fail smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055F606A31A;
	Tue, 27 Oct 2026 13:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F055F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B0uGN5Ye
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793106700; x=1824642700;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=XskIaF5ktQty7rN64/2+9v+O2s1niC/FkrOPN4VAAPE=;
  b=B0uGN5YefIcfcGx51NKR9VwRwPIpv+YodBHnl/JkF7aVw+ixqYeAhXvg
   vA3aUAmzeKBvSAIOc/mh0m3aFMrgBfeZnlgw3Sie2uMu2X0+uz3d72uM9
   WKfx1h9t8Xv2qryCCit2d2PV8fOLf9u+0VXydCaRehB3y7iRN08Kqmm0n
   IHdqmeK1wtvP6hHrulcu+8vhsC9M2dTVD8jpYDUjPR6+X64+LHv/OcBET
   Dd/qM71RVHBwCS150o7YG5KbIs5Ti4jcLJmasVyP/zMd3FXofN96/cBFC
   H5LGwHZ1E+s9qT+SsqyxDPyy2MuLWU6g2LdJcmn4jyZBgmXtPuP/2XRnW
   g==;
X-CSE-ConnectionGUID: 9FpG42a1QAmgIA+/wNBiJw==
X-CSE-MsgGUID: Ar/I7zvTTo6xYGwzkI0U6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1700587"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1700587"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:11:39 -0700
X-CSE-ConnectionGUID: 1EGA1ps0QfOWgkjAj/f0HQ==
X-CSE-MsgGUID: jGeLuHEdRl60c2W68sn0hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6416663"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 06:11:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:11:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 06:11:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 06:11:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuDAYVrwdbTr5ElUu2ox6op5OGTQA6eYrEyf9wz5I7zw9K2rs3DxsbEXUr3Yelofor6twja02jGq+Ncvez8DunAq6PUhKRaRlbHO8s41PCwS2OYLaAz8N3+j2d5H51DmjAIhnffCfSabphVqqugxENCTeBUaNxm+sAHwiHKIgYM0c7teUTmNn/L8FN3I5GZ7olCvBA+rlErAqtL4Ql4bg0v/M1hft5EziKOwWvt4jEmlcFfdENMf9nRJEjx8z0QpW+EJI8zzRV3alv3rQGS7f7bPSuJcanFGmVeIl+1prouSrR03J9abaiEvLODho3z10DAyytIAOZ/Q6dygsCEfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrEfA9EPvz/k0KVZWtWIHcYml3DmJ1oHWulhi91z2f8=;
 b=yY7QMLqXpMFs2bjYKHgAl/ClK7owdsuJI8upRSDrky8JRj6+g/bWkKj8FLhff7oOQlp73IIBq63ErY4iUztVRGHPo66b1EKWttrjExWfmxqAkKNWE7aUtTy99FQp2h+5L7ZCjt4A1WwQtq+iwHcUBc1pvFUlirgVV30MCe+w7Qykf+XAkPvIlq0U537HDuFfwbOjKTQBzhn3XDGaFIZrxVjpb5n1i/eov52c7EVrNizhGO1AzriADmdrl4PSDghWQhs3AazImOzLMq9ElcKBx4qwOR+4mocMqEYc7kn7a8Sw9IEUl0Dn6ylL/nhaurpHw/T3ubC9kCVssB5cYXvJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA3PR11MB9463.namprd11.prod.outlook.com
 (2603:10b6:806:45e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 13:11:36 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 13:11:35 +0000
Date: Tue, 27 Oct 2026 14:11:24 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <vega@nebusec.ai>, <bjorn@kernel.org>
Subject: Re: [PATCH net 1/1] xsk: validate consumer ring producer index
Message-ID: <auCi4nDJ1eiGx5hC@boxer>
References: <cover.1792654486.git.zhilinz@nebusec.ai>
 <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d2b51708a3ada3b12b986224ee8340ca7ef5b3be.1792654486.git.zhilinz@nebusec.ai>
X-ClientProxiedBy: DU7P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:552::19) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA3PR11MB9463:EE_
X-MS-Office365-Filtering-Correlation-Id: d1678210-9ab9-45ce-d7fb-08df342bd436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|13003099007|261026140227099003|4143699003|11063799006|5023799004|56012099006|261026121527099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Bx3niPIiNXj53fcMQHW3mGje/3TYUC0Bwv61LouLF0sCadGQxVpigZXHzBnpaHrf+ujLLOfRG19f392XhoNdNi8HAxUTlwbcqN+TAxK9FIdXo0oaKITdrcUqzXmnnL6RHEjpsonmXpagoCkLJQcPZ98jpinlRQ2f6KLfEIpL9eMToHvqvW4hje79HRsRg0kg0DV29AiYY/Q+EO2B6/jylDGrDYmIpbT9WezLThPIcUURLEp7G10U3QRZxAE8SBbgdj/d0ZRO2i9XGjgotrilGcMRzFdyEDjjfwLncAJuvgXv7H8QolzDVw0C0kHcEYwOTrkmYu14NNXHE+qlqte/0uUTgUAmcwWOYY4fM6++lf43z+uEjbx9LQIjfCnQmOHrTMm+TUgpg0B1VMmGNFDK3LQigb1CeFeNmyox//xbqiPK8CJVbqVP8MrxiU8k/n5N6SdyZW9DPIocrpokS9qzCvq+bww1p/tO10v05skuJV3v5rc8LXW4XPBzHXf8bXaLqhS6CO/GtGCd3lhxZ0oib8jaf5eGi8NBsVDieTkDvnx/zHujD+19m/IcqSyILP4+buIS25LPraSbnSyv1tzOAdgkpr3eAa55z/PFaT4GMyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(13003099007)(261026140227099003)(4143699003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNI61M0rphAYBDAoeHF1hHeEGtpBe+DCjLbhnyddG4ye+Vh1dcfprEPnYwAH?=
 =?us-ascii?Q?R7v3fLSFvwc9AhqkaqZxABI6gWqwxTUqizbFTyuvnwLShTiGGaM6inIBnHP3?=
 =?us-ascii?Q?gye4QJxUtFNcSmGvx8FlXy7iOSfmnTtcEdlFG3SIoCOho5i954YoVVxdmfC/?=
 =?us-ascii?Q?5diO4pEXKBgHhU1lJ7mlvm4KCsMZ/mH3qTy/3fbMMDJvMbAIRCtDCg4AeRk6?=
 =?us-ascii?Q?QZSBKtcmVZHny33W6BdUj4a8DEUa5BPY2+cQ6ktww48Tnrcg4lmp3qwSpARn?=
 =?us-ascii?Q?uzHvB2GmuoW/k7f2jkarYlN8ITyFQ7C+3lFtuGxMYy18v4z2ZWWMm+us06CI?=
 =?us-ascii?Q?PynufHOwOmipEmuRpG9fyTIn2R7besJp7JwF2Dgbnfn/2HdlFOr3YmmI86wx?=
 =?us-ascii?Q?OyNhyOEuua5HX5dGrPyzK1xbUcXdqxh8Xnldisn3ag+jXL+japQXjVfiT00r?=
 =?us-ascii?Q?CIeVIrU0riPQ6D6aIyKg+0xph8XgSeo3Glby9HFwfVY2GFtPRjoWGz+aKK+w?=
 =?us-ascii?Q?nVUNo7uMW1XvF4lNjxoUvb4ckNirxu/HCGzgEARcl0pfG4TU2mihp6z/MFD/?=
 =?us-ascii?Q?5xcAvTXWgukNTjZzQnybXbFLwt6pAkY1yyNWY+A4QTunSnl5rqCPGQ7T5AIj?=
 =?us-ascii?Q?dLHnASIQ9QB7wvKLoeS0UMivkmR1er6a5Dp+sJMlbcD3yeXZRX2Qt2yAKg/x?=
 =?us-ascii?Q?lheXyHROy8eOxm10PeR7z3mXX5tM/cCMUSJQ1fspSuTpEKZyx9KRUG/4swU1?=
 =?us-ascii?Q?q8G0cKsjxAKPkgYuC22Pc5u09GmNZ7vUmiLVJZ+ZSBeCFCyMoxO7ahbQoXhR?=
 =?us-ascii?Q?Ap1AVF+s4TpESJiTguLiGd5G/buguQ9ixrDgvpGONcXks9q8HFf2tjM3jJrA?=
 =?us-ascii?Q?b8klo2aBu4+hvg90vcLe/1duviMfPRaTom+z2a77Vtqbcl1gPbGeQZmBS8Dv?=
 =?us-ascii?Q?vxwJdSeAu9FdK+gOjQj6+Xct4qbJnVp7vrxE5UEJACJe/OhgF0SlaGyIMsB2?=
 =?us-ascii?Q?Do8W45pSgeAFXCW3hS5mEjUILttnK8vvi9ObtMFiXgv7k0mEawbOQIAVUYQz?=
 =?us-ascii?Q?TKg/xkzFj643tObJKOhDIF+JnWCKX6IATGxn16mF4lJielizd5+PFtB4djAm?=
 =?us-ascii?Q?Yt/oJgS0f1bVTgra9udoOvfeoLypIGj7LBgTGO7665y/+1llGiQyi0zTU68l?=
 =?us-ascii?Q?eNtSGA1aTn2mDKQ/ccVSm5dNeHCVj7sa6eI1U9SwiDR2rRen2TZrMFsnKX+u?=
 =?us-ascii?Q?lj3xNXvYA3ZpEsi4d7oSa4Te9PESFRlnqNyCsRsvnXwpe1wkyNpeqiajUCqw?=
 =?us-ascii?Q?6JfKeRnZGEP64feGtPav/lTi3WP/eZnFA80fnhzZvoviDJNmogaUaUMYvKIU?=
 =?us-ascii?Q?2fbW7jDKvAPQ7GUoER9j9s0eQCEEFOuxO5hNF1wvahrzh6apa2Kah0rIzYfh?=
 =?us-ascii?Q?epQog+2CKn49m6raMly2g3yi6wqFiyXuTTDUSV+tFy7cQj+Qi2V+wBPJFhy/?=
 =?us-ascii?Q?kyzjFKDUXJYkhyCrLDNflvVtpUYEFDVpDHphBC+D88PBpw3AV98gp9xFjB7a?=
 =?us-ascii?Q?VWpZVCp9cpcLZZ77iXyWfIIV4C+TZYtA8YwZG196miMEfHQabpwZIiNuR90z?=
 =?us-ascii?Q?R8/8LXXElM9RGSOU6YFBZJ85pUD5jJUrXc4i/R/804KV24+YEU8M+A6gNu0a?=
 =?us-ascii?Q?JuG40uTZPjgwCvQzyvVwys1wpH2aggTlqK7xS0qrJfJ9mnQYt7y7kcypqabU?=
 =?us-ascii?Q?WYyfgNOa8dHpvGUQOyyJalDIp+RLoTM=3D?=
X-Exchange-RoutingPolicyChecked: Kv2Pf/hZAf02iVOaXh5j1q1qLbuagLhsmuDWPDUz63PnKVNqlc4IbcBmWTI2K7sx7jPRWy5eRYEy3ETlu7tunNI+QNQBrbO+4h4Uzriy4McPWSyVf9IKjylb1ND5csIOpocP2V1wzlh4/6TFMuuSiOXG+OLVMXTmqauSYPBTTP3s002g4uFAXXKPVaeexb7TOrQzUdm5I3L5sAXA8S/zdp32sq1pOi0A1YgVXY4r04bOV3dlHO/TP6+4VRwniDpPYVeMbH/IPtV+4gkOIQdbVNz/7t3eYZvf8bk2C1AXK5if1smZNdxrgPapMHqbLaaBiLEywk4c8ZDWJIYtVambbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1678210-9ab9-45ce-d7fb-08df342bd436
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 13:11:35.9571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDuQN/TyjLXdkJ9ZwrQC5AxM8/L8OT5OsGpFSfW+wFpeqCpZY8wUNzryMGEz5IG/CUhpt+B4ekEgSKIiz6riTtuB8QpKUwiB3ZMjxNvoMVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB9463
X-OriginatorOrg: intel.com

On Thu, Oct 22, 2026 at 03:58:18PM +0800, Zhiling Zou wrote:
> __xskq_cons_peek() trusts the userspace-controlled producer index without
> checking that the producer-consumer distance fits in the ring. In
> __xp_alloc(), an invalid fill descriptor is consumed one at a time until
> the cached producer is reached. A one-entry ring with an invalid address
> and a forged producer index can therefore keep the kernel in this loop
> for billions of iterations in receive context.
> 
> Treat producer values beyond the ring capacity as an empty queue. This
> bounds the consumer to the userspace-provided ring size and prevents the
> long loop.
> 
> Fixes: c5ed924b54c8 ("xsk: Simplify the consumer ring access functions")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://bugtracker.nebusec.ai/f/13760
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/xdp/xsk_queue.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1bc42c8902f4b..315b656534749 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue *q)
>  {
>  	/* Refresh the local pointer */
>  	q->cached_prod = smp_load_acquire(&q->ring->producer);  /* C, matches B */
> +	/* A malformed producer must not make us consume beyond the ring. */
> +	if (q->cached_prod - q->cached_cons > q->nentries)
> +		q->cached_prod = q->cached_cons;
>  }
>  
>  static inline void xskq_cons_get_entries(struct xsk_queue *q)

Clashiko says the proposed fix is not sufficient, see [0].

I am leaning towards Bjorn's suggestion to return NULL for invalid desc, which
would imply that the endless loop is pointless and could be removed from
__xp_alloc().

Thanks,
MF

[0]:
--- Patch [1]: [PATCH net 1/1] xsk: validate consumer ring producer index ---
commit f0f4eea504a1aeac9437d0c1f025a159991b7029
Author: Zhiling Zou <zhilinz@nebusec.ai>

xsk: validate consumer ring producer index

This commit adds a check to __xskq_cons_peek(). If the producer index is
more than nentries ahead of the cached consumer, the queue is treated as
empty. The goal is to stop __xp_alloc() from skipping invalid fill ring
descriptors for billions of iterations in receive context.

Link: https://bugtracker.nebusec.ai/f/13760

> diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> index 1bc42c8902f4..315b65653474 100644
> --- a/net/xdp/xsk_queue.h
> +++ b/net/xdp/xsk_queue.h
> @@ -344,6 +344,9 @@ static inline void __xskq_cons_peek(struct xsk_queue *q)
>  {
>  	/* Refresh the local pointer */
>  	q->cached_prod = smp_load_acquire(&q->ring->producer);  /* C, matches B */
> +	/* A malformed producer must not make us consume beyond the ring. */
> +	if (q->cached_prod - q->cached_cons > q->nentries)
> +		q->cached_prod = q->cached_cons;
>  }

Does this fully prevent the long loop described in the commit message? The
commit message says:

  Treat producer values beyond the ring capacity as an empty queue. This
  bounds the consumer to the userspace-provided ring size and prevents the
  long loop.

The new check limits each producer snapshot to nentries. Nothing limits the
total work done in a single __xp_alloc() call, though. When it hits invalid
descriptors, its loop only exits once the queue looks empty:

net/xdp/xsk_buff_pool.c:__xp_alloc() {
    ...
	for (;;) {
		if (!xskq_cons_peek_addr_unchecked(pool->fq, &addr)) {
			pool->fq->queue_empty_descs++;
			return NULL;
		}
		...
		if (!ok) {
			pool->fq->invalid_descs++;
			xskq_cons_release(pool->fq);
			continue;
		}
		break;
	}
    ...
}

When cached_cons catches up with cached_prod, the peek does not end the
scan. It publishes the consumer index and reloads the producer:

net/xdp/xsk_queue.h:xskq_cons_peek_addr_unchecked() {
	if (q->cached_prod == q->cached_cons)
		xskq_cons_get_entries(q);
	...
}

Here xskq_cons_get_entries() calls __xskq_cons_release(), which does a
smp_store_release() on ring->consumer, and then calls __xskq_cons_peek().

The loop is reached through __xsk_rcv()->xsk_buff_alloc()->xp_alloc()->
__xp_alloc(), or from a zero-copy driver's NAPI refill. There still seem to
be two ways to keep a CPU in it.

First, xsk_init_queue() only requires a non-zero power of two:

	if (entries == 0 || *queue || !is_power_of_2(entries))
		return -EINVAL;

So the fill ring can be very large, for example 2^26 u64 entries or more.
If such a ring is full of invalid addresses, one refresh still allows that
many iterations.

Second, a user thread can watch the published ring->consumer and set
producer = consumer + nentries / 2 each time. Each producer value the
kernel reads is then within nentries of cached_cons but never equal to it.
Every snapshot passes the new check, and the loop never sees an empty
queue.

xsk_create() only checks ns_capable(net->user_ns, CAP_NET_RAW). So can an
unprivileged user namespace with its own netns still cause soft lockups or
RCU stalls in softirq context?

Would a per-call budget on skipped invalid entries in __xp_alloc() work
better here? For example, it could return NULL after at most nentries
skips. The batched xp_alloc_new_from_fq() path already limits its work
with xskq_cons_nb_entries(pool->fq, max).

Could the commit message also be updated, so stable backporters don't
assume this change closes the soft lockup?
