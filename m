Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89746E006;
	Fri, 11 Sep 2026 12:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129180; cv=fail; b=jtPVCNgOWPypqQoPvR5qMQPEhylyRWmSUwWX6unCnMorivOtq9Hnj6xIJBd7Xnmtb83yYqm0jY2PE/xmWxrUlgiyhcreJuYAsuI9QyTm9/SU8s7MgTcvDzr9ackFXjlmtz0wnDNwxwHxkJKfE/bR7knFr/AZa6tAUqIUUhxuATE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129180; c=relaxed/simple;
	bh=w2xaXfcwBVN/wkbQuo0hNB8E1QdY4zElje1Mih9a/vE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=gn4KdSu9zE8j2VvmYGbgD181R0RfYcg0YVcZ/HCSSsP4iFldu1+jQuLkIytyEpZ6V43PDN3ksKxl/l5jmHTY6HyN9vnLuxrdhBlzZVP6uYSKWLBX1HZjdm95pn6XgeIOJ55KtzEKR8TAFdpdaYiuCRC60+CYFpEGYUkZnQ7hJ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIHYiY3n; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIHYiY3n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789129175; x=1820665175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w2xaXfcwBVN/wkbQuo0hNB8E1QdY4zElje1Mih9a/vE=;
  b=KIHYiY3nwfp4atzUQIP/biGmcle70N3Yg0E2NBI0t7ucF7UPIH9eIa8J
   IcHxg2GiNJfjNGZk86Kfg8RQuuxazD8QlPt7E0S0nwvwUOR2Iu7dQnB4A
   D6CWa/WQXvKELRmDXWy8OqPkvOwbDljInLZzIfH4ZTqbJ47xJVyjxhcNi
   fOz0fyPH/yse9Q/FrgIJslfUrOJgbeXwNciaSND71zrC20lLeQc4yyLtj
   7RAO7b3hlAVmzXn6nNi4IeZcl9FQxcLL+/gKMnIpR7GvecNRteuI4A5aj
   ZsvJsH6iiJICKT+O9fQdba4GmaEIR5lqLvLzATs1GCyVvJPLNq4/A23Fl
   A==;
X-CSE-ConnectionGUID: pIApi/NrTZCqKTFasN4nrQ==
X-CSE-MsgGUID: /3t8jf0ySbeHoYSolviobg==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100253899"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="100253899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 05:19:31 -0700
X-CSE-ConnectionGUID: +QF57FxGRdqurCrUvG7Kzw==
X-CSE-MsgGUID: 94khLlHwTmmzAqFmHKHISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="270530759"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 05:19:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 05:19:30 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 11 Sep 2026 05:19:30 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.36) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 05:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rc65kzunv0fSI9aaI/D3X5WDUnJ8MTlTdJd470W5peGSjuHIOrsk0GZTkVz+25Hl0cwVMlG3tgUqx+rEf3sp8cDAKSt0iZurcLD0QmYQBjAFmu1gG+RPppAalegAYHBZAPE2NtiVPwmd6KaYXYhejt5O8WBXp89gA1BSoIvlYsqTidlVFALhxoMB6t3OIY+XBZ0JzxaW4Pk5QBicBXLQbdleqUP+AGNkGKBUcJ95hppPtIBDzZnYnr5K88YM6cVmGMoAKk9H1DOce1PIJdklpb/8/1zLBPVon7Ys2iYtxEpLYNIPdZfCTUKX+jRSqlOwkZmAnQVyyPQFcJfN+taaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2xaXfcwBVN/wkbQuo0hNB8E1QdY4zElje1Mih9a/vE=;
 b=flklzMXsXcTMrPf70eonQRit9KBXeRCGe2NedWob+QfqIX6g/27zEW4zRa03fDB6MccGFBmIutQgSXExPa4p0YH5ektgMUPjUpq2ZbgG2Cf/4Y2kYkZm/nhW+9bEBt0OBMSsidXXzVACg34UOfHW7qPSEuNiNIYa+QgCrZc6REIhH7Y4MgthbzJjUftRwyhHn9fQmPlYEiDdAEHw1SAk/Q2Uv//K6BFwje5XvncbB1R1sV9g5vnVaTG0OCPDJAiwZXl8oJWHNqG5zu9DOfguqmMPS4CzwA+dmqLBX294WxH9QBWR3G/6Ww1YJgGrC1EN4uLFLYKTKU5Qp5QB1S3kTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7889.namprd11.prod.outlook.com (2603:10b6:208:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 12:19:28 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0382.014; Fri, 11 Sep 2026
 12:19:28 +0000
Date: Fri, 11 Sep 2026 14:19:17 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev@vger.kernel.org>
CC: <bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <bjorn@kernel.org>,
	<sdf@fomichev.me>
Subject: [ANN] AF_XDP office hours
Message-ID: <aqPxxX9MeGmAqGy6@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: DUZPR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c901cf-18f2-4aff-848c-08df0ffeec98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: E8gfVQiAHsPIhu759s01LE90ToYMmnBFZD3oVAHrsUOCPzmm2wDpk6iTJDECuraQKP/HgzWJgUncOpZ8wbSJqleuJhc86QdZBoEa2gtluoiBWoZZwFjNVE73z90kSU2wJRcJ8AnfNNByRzzqBhmB4j3UyhBD6jdN0K97BTVaGgy34mgKfM46drke+AiKQJYgA6ZQ7pS8ZYnEjqgrxIF6JhDQrWhJpAEGA8Pogtd70FWn18MVg+xn1bONRbAG2cARsKkh3sMAI+/fGP5UsvNzFJDIZtNMr3HqqzEwP3E2deNSulVlgxvUziRzCQtqygSGcVwtPq+LtenFMBHUiHLkqFT25whQCwkaU9agWP6rxUiF46tWeSbKssJ2f6U8cVJR+UgR8EZI8vZalCa8Za1tWESEfSA/30sB0Qg68JwQMnMx+PhiWwg4TbOpbrY2qKk0YY70Vi4dXFHB937CSAMtkgsInzJg4NCGq5IN9Z0LPocAxqRswP/bpttHC1EL96O9uLIyLAy2W+fL3aeUH0T1ssQCs1PttawCHPZv4u8hU/0Xc2hlI3Vd0BVhl2KMAQ3nktcIyNXVqFfs2diduoGV0MatmPlEANf9XL6IzFyrbF1nQG+IJjZzsMUtxtGrd3mQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9nf3v7J0cOhLamSn5lQf47UMc6LFzYXGmpB3uDWWMB1kYDLnbzs9TCIA4Hz?=
 =?us-ascii?Q?KY0rBBaOrYkrlWw4ySiNArhkVNM1MNHwAsCam3IRnJ7rBLvK/ei4decW0eMw?=
 =?us-ascii?Q?mfgGPsmAY5sQI9LY4CF34xEGB8PZunIHf0FTXY8Kk2yCB0p/+8NHNvLfJW76?=
 =?us-ascii?Q?IHpTdilCpmXYS0TeHIhmN68eiP0EYCESJu9EaPDAwGHLPiIjB2B+r/631eHc?=
 =?us-ascii?Q?S69pUKrs4aB/+E0+0e/XMdjaFqLy3qcRiM52pS9X8U51iniNfoJZv0xPwXMn?=
 =?us-ascii?Q?5l+TLA1hA+Z/eYqpKqaXi6Mt9XSx7kPmlpVEdaRW6n4N0JJnhSgULKgvEgwz?=
 =?us-ascii?Q?GzzBFzB+pe3mVNYSk3KGpQImPfm5T5vlHjuvJhlHwAMy5sIkLH886cg5mBb8?=
 =?us-ascii?Q?eGYbX55D4bTDyecWxMc2nqYKGWBDKW3RYTPfHBTQqkYst0FHWfVUqjkNrKfx?=
 =?us-ascii?Q?0x8HFXqtY6scfTky5QDI/XdMiVUxZsr36SiPSdX/O319H1FFVIPjEMSmSlwW?=
 =?us-ascii?Q?+yjIcXthFmnwy6uQ0fl96gErzTccy8IVd97al9inYpm2VtINr3ugVXtsTiXb?=
 =?us-ascii?Q?DYLsdNck6Z9EYmL3DxbCr5WELXMpCsP76mMHRrmsnNrG1i5UDRUcyM2T0TkW?=
 =?us-ascii?Q?UVWX5nLXHQNXALNJ7OZv4svTgISmDnP87m1BEuUiFm0w48vNTvFb+oDu2mr+?=
 =?us-ascii?Q?LmYYs/hFuF6L3TPus3ZobNsqqJF8tdJQd4ghPgVGhMVl0MiIRyGQ+t4qhjtG?=
 =?us-ascii?Q?i8na4Ni+Eiy4FF92MMhij1E28vcKn9vjFmGlEoXoh/Uzu3hdxYoGGlvPZzWR?=
 =?us-ascii?Q?yNrWbPTLW0SKCDBsLtIZOm4+DDIIq4CevjQo3s3m3kXF+UUzBPqL3YtQAo4e?=
 =?us-ascii?Q?8ux41DJ4vcTif0GypnbQbcZtfczBssi6k8bBeAWwU8tuJ9GjwYbs97481lS8?=
 =?us-ascii?Q?OHap4mvqfhXS3cXiG1mOphPP/VGmEEqkoj9AeA7x5Arad6jS6Dhlbr8gcvs9?=
 =?us-ascii?Q?kOIGNY/lj8GJuPSPP5FMWrNDNuz1u20j6W2cW9BcHmjfehzNL//oRyfcPXd1?=
 =?us-ascii?Q?THFQY72h3A2VQliEI05Ac6PE940kFx861v2RZy7/KV89ioHhi3YnQBoKTtK5?=
 =?us-ascii?Q?pvIL8FvgSRnXoeNov8evXsBR81FNg98cKSNu2+awfq86UIPjfMkH4nWw2J+E?=
 =?us-ascii?Q?MupoQa8R8K7IlwOjttyVu94Rd0aqhYjjeFuiF7agiTCySOfTfP1z0P9zgNib?=
 =?us-ascii?Q?eG4f1LUeLmsjPnnWv1fwXbosOZVcj8rL/2QPKNvv8ELOBFHeC8FXy/PRO48a?=
 =?us-ascii?Q?/BjIOv+DfazS2w7sRDnNNPWSVVxVd5+cwl7JaH/qZoBVmpN3Ewy0O2WqhpEV?=
 =?us-ascii?Q?bd1zMyH+XydKNIUiOscxHjF+VMYB2BN0C6xpbj8LmOOfwjx53TMGRidtQUUF?=
 =?us-ascii?Q?Rdo7KTmz+BdXLXnS7Brb/a2+cNut08ei/vb2Qe4L95lSkGnscv2jCgeTSHFs?=
 =?us-ascii?Q?jSo92ftbyvLD1W/pmQ/9EQWrD8ipjp5IFqjUlZFC8ODV5dLGhH3mjCDHbfjz?=
 =?us-ascii?Q?UK8h9KUmJS+yIXO8jLw/ovoenxmitMM49a8ZdlofwN4ptm0s471kID4/J6xv?=
 =?us-ascii?Q?t5KG6jYpf7sOzI4ldiwtkokQQIip5f7WwB+Ah4SNaPbg/4G1FPWU8NVn4PZ5?=
 =?us-ascii?Q?NFmZoi3SSeRWBN7viqrxIW8ZRAOJu9sDYp8lucevs42EdjDzdIgFdmaAI88L?=
 =?us-ascii?Q?T6ZumU8ERyBZD/VTpqQiU6zSEIs5c+s=3D?=
X-Exchange-RoutingPolicyChecked: qhEe0LeSreX7WCiqjfakFn+MCr4piqkZA/VilqFCE8dknBIdFX9G6Pn/60cXseY6Xyi0pXXWj3QVWkKVz7FQ5tSzLdURgRVSL6pUuWMTOzOC/bdevH1mLVFj97eJdcsaaKZNCFCCLniT27B0cdrTCcvc1qMSCgY7+JiisbcvKhWsuKZtvWUKFtFstB66AMJITZuaiY8q0rOFKI/bRNol8VxzsZt0jKtmsCYcOvBwcSSjpTDYfxQN06lrtmySljWcIoE/1vu4t269bCS1Y9n5ja8vAzVKCYmkSGCwzCPsCgvViWBJNkcF9JQ19Ch0Mh6hTYheBiRSsxu3yuwNxy/n3w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c901cf-18f2-4aff-848c-08df0ffeec98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:19:28.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBm57I1eFzaJtzRPgUT4zmsg/qdJ0lcSLBRqqDEIsH+fG3m+usdShLP4qv2pE/U9mR4Wvq1uDIqjT0Eh4WNSkGAGP5OWbhHY0nupdTnj9i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7889
X-OriginatorOrg: intel.com

Hi!

We feel that there are efforts on various sides related to AF_XDP
development so we thought it would be nice to have a mechanism to have
cross-company syncs or discussions.

Therefore, let us introduce AF_XDP office hours. Plan is to have a meeting
every Wednesday 9am pacific time. Similar to what BPF did, we're gonna
have a public spreadsheet where people can put topics for discussions:

https://docs.google.com/spreadsheets/d/16GL6AbdjDyT81cJ3-qUnYvFxqO-RlhtYTS68bfQQDbw/

At this point we are planning to meet even though agenda is empty for
given week, this might change in a future.


Thanks,
Maciej
