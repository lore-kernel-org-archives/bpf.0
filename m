Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546821FF23;
	Sat, 17 Oct 2026 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792251120; cv=fail; b=UfymM6NQXxsAfX66UGBey9YNVM4uXp7x8O2B3oQh0p9Sf2pof6j5lbYGUmfIXKhqmDI0JsJKZ9T9oGEr7eVKpHdjwxxoxPoU71Xkjzk8oBze2ltpH62i0WLQ+Qo9foFnJmrnBM32odkDyc7Y2vLVfiXje8WCnVV5oa1WDsxIplY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792251120; c=relaxed/simple;
	bh=e3mpeVfiXlsA6f/oDSnKb8HTWHSmN7Ri/KyjAxQwdSE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tWuJEZDVG1xMFwUFAltEyUVvsDiMgoK6pg8KO0k9GGAmdrMeaDlnDowKq2Ug0dIPVv86E2ZdvXg4i7CndobL0CcYpAZQx3FAm8qRU2/tDvi4roNbhO/Gb7JLUl/3sludD5YXEuM6b3d10/WAjsisCplz4qfAGkIG+eXTzQy9+1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDtDgPkV; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDtDgPkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792251119; x=1823787119;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=e3mpeVfiXlsA6f/oDSnKb8HTWHSmN7Ri/KyjAxQwdSE=;
  b=fDtDgPkVNqhndqz90+C44bZZFSpk23KGsmzI6M26/EmbX3jhq4yMpFTC
   6UACwLv3Y/hOR47slIrgoBIUxRUBfkmb0puuWMlPo8/ESYVlfIK+j0CHr
   H3bvZ4utRVab6zbig/RW3Jrrv6qn+3AC6A/f/R6qxuU/zEAxiVDVvNCFU
   oKP7n1S5uNoXUC9A0BOz+1rB192b+mScskmddGC9mGOHrIP6be7OuX2S/
   Q28HgEk0gZQlWPao5Zy7bOErVpihadhP6yqNQpAmvFTWhD4odUddVe7XH
   uvZROABtk3xQaz7DqCd+ju6TpKROP5efEKwKhuzy7tbzXbQXRDd8O2kYk
   g==;
X-CSE-ConnectionGUID: nCuuSmKPQmm3gabwXE9u+Q==
X-CSE-MsgGUID: HKxMjX6vRrCjnLgWwXf8Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1002254"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1002254"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 08:31:58 -0700
X-CSE-ConnectionGUID: 3qLreU9jRf23at8qNUIhvw==
X-CSE-MsgGUID: ND0KTbOSTOWfGRpccK+7Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2098075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 08:31:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 08:31:57 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 08:31:57 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 08:31:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfQMwYppVNjB9h8y7/CqtDlUCTS9FGJaOnfBEzbgEOsD/aRNvehrpLji+9vL6JqSBhXiRSwM+vzXkdI3TcAIa45/NMvEYWtQKy04BBLM2rVtyCPKlbrmk4IAbmRGDe1SZgTnROaXeUxxuXAoXMNHi77Pa6KYi1xK+0Suuo708PSaO8DBJGPcxC37EjEjQDoFDWzYGbXn0xOSBKEmnWDcmXrYzDmNjS0+cSJsW7blHbaRcsh2fCszE9OYo+MdRj0LwJr+gtuRTTY6+hMa4gfP5e5knx3u7p7j1Cy6L821HtrkclHqPmze4Sb0LRMTog2DSoSlkKiJLT2eyQzBdCUxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMV9Fp/iSivCUHm/zxPT1yMFSGy9GV5gPjBDOsM4ih8=;
 b=p1M0ro3DjHYYo1/3QzgGqGkZosbARpjIOltGW8TaO7K3aCV2XxsgJ1qgTS7xiolmFnWW2Ka/+WHx/WLCWDlKTJf9q4k+i/fQzFDwC0wNfQ5CESwQZXT5QvlCNPmMHLD8qllRs8JFq/aFKFni/i436KfWLx7dXDCy6cLnOnd3xV7plFvR7691KwEWtxUxu2QkPHqXvY9222Lmt0jwKc9f0ESowPvcpmgY9eQxLidAADEWzzPmGNt1zpwdfcpETFEw9ZKxwHLQ8P9gIbCSv9blQ+BiAwf89ruANKbkKvciuyzL81KkOx8HKJd099eTthDS0oW7yTCF0jPnuDoxfDFVTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 15:31:53 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 15:31:53 +0000
Date: Sat, 17 Oct 2026 17:31:41 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net-next 06/15] selftests: xsk: move the AF_XDP test
 suite to selftests/net
Message-ID: <atOU3fhtxfef6eCl@boxer>
References: <20261014184539.774708-7-maciej.fijalkowski@intel.com>
 <179220636618.434549.11404278084536397224@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179220636618.434549.11404278084536397224@kernel.org>
X-ClientProxiedBy: VIVP296CA0100.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: da93b27b-0659-4260-5993-08df2c63c532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|4143699003|11063799006|261009223027099003|18002099003|22082099003|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: S2uTJQWDb2ULBZptGaLO1UmN8LCgrYe2Fa/WW9c8rttU1Gp5SGUBIYKGtPHECUuqmyTaxV5VDRx6z4+VzmQO5liPDLHPcIOWVrtvLEBIFaNhxFFm1U9S/4AqydTEpkkkvFPbmUh7XyxOcZReThoJ1NKgBUSrSnkYqJ8WsZhnWwUCOLdYXPsc0slCx84Z22VSSBtXiqUByKBeEXRTGYCnX2ymOCnNPmMXPag1b7N+uHoETTGRJ1XmpS969Cs7CygtsZrwu03D/IDKclRYj+eSDQ+sBEnypvlmI+Qh+dslj7BhWRIPD7z8muwa6Pvhn8TXIT+RSW3swJh3ZJOYXC4P500U1HLFMROY20+Ba8qbKMUQ5dfrY0PH02E+YekO/OlIfPtfezwnwxxvywmt+RjTKouFezafb6BXEKynRjYExcBr0hHcst5O++tXP6s4nZlDtaV7crp80gGukPAhkrqRAq2rjF0Q42E8V+pZxcAMqd5kc57q2Y7lGFCtRZc28BjGvbvSLP7sgfuQv1dTpmGclK03EU+k/y06DU9Kj2DWcP9pOcTy1XTI7o2mS38B7aQo0oteelvXIL5wuhWyQzEk1gvKigrnhOgc7wYQwzRrq5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdmQ29XSnNpZUhDQWRkL3lVTGhqVWZDMU1XY1huaHp6Y1RKeDlha2NlY2Fp?=
 =?utf-8?B?QkNyMmdhVHVlZXRUdm0rRmYrL3hEZmdmV2VUMlVUQmhsbTdWNXdOWFMzOGQx?=
 =?utf-8?B?TTk5MC9QdmVac3Fzc2VhcDhBM1o2VTUxYWxXZlVmMXhIQVg2NWJqbWw1ZXpw?=
 =?utf-8?B?N1RIWnBrdHRrSTJUMThZbC9GMUtpbzBzelhTZzYrOFVPL1U5TllsR0tjQ090?=
 =?utf-8?B?OVl4dEkzUnNXUTc5Tm5DRmtjWWhvWUtyNjlSc2pDU3poSlpmN1crWDdSN3BY?=
 =?utf-8?B?bjV6T2MvV0RMYldIdFQ1OEY0bjdaN0VaS0hGY0pzTVpkQ2FCK0trU2dxR25y?=
 =?utf-8?B?UXJKNzBEK1R4dXVySGtab0dYeityMVlBRzd3L2NnSHpoSTNnaHlQRGI3YlpM?=
 =?utf-8?B?QzlTWGtVTW1UUy91dEJHd1JtVWVndERYUG5PS0U2Z0VNZCtRVjNzd0w5cFFH?=
 =?utf-8?B?QURnQVR0U01xYXRFNk1CdkozVE56KzRFVm1XS21jZzN5NmVqdWlESlNoOXd1?=
 =?utf-8?B?dlphQkcrazFFcUFEcFhUbTY1RWZiK1lDOVZQV1B3Ylk3cEZXdWQxY3ZWYXlD?=
 =?utf-8?B?cVNad3N4VG1XUGgzSFZ1SHVYTTdYMHA4UGRQOTk2SUR2M2lzZitxNEdOSU5R?=
 =?utf-8?B?S2tUNWN6STFTT29ncWw1MHR4L29YeWdaOG9BNHhla2ZHZldNdjlMSHFiRUlW?=
 =?utf-8?B?eWZBZkdGV2FKalRHUWZQbE4xbkI0cFh3NU5nQk5YRUdzQmNKQXFOZ2F6ekUr?=
 =?utf-8?B?NGV5S2w5N1J6aklRRDBFUzJuNExXTkJnN0Zvd3RGY2t2QVRkNHh3ZmFNTkFV?=
 =?utf-8?B?cHFSWmYxOVBMdFZxWE5hb3dIaUZ1TUVsS3VPaXlqNG5IT0xPalZFN2d0Qk9w?=
 =?utf-8?B?UHA0YzBGMVVtTXd3SmpoOTIrNmdlMEw3a2o0dlFSbi82OFFkQklCbm1jY3VJ?=
 =?utf-8?B?YldhL2l2OExrRCtzM1VFdUF0NXRTVTZsTFQrSFB3MTdqMFdvVUEzR2YrbWR3?=
 =?utf-8?B?NndVYmZPMFV1Vmhvb3hvUGFvdzNET0VHTmxZeFQwVkxvNWQxYWUza1FXcXBW?=
 =?utf-8?B?RjV1WDU2SWo4ZUc1YTFBd0xiblFZQjVkRXc1bUV3T0lrRkYzcHZzbFhhN0xD?=
 =?utf-8?B?dW1HdFVXTHl1TDU5WGh5TkdncXMwRmp0WlRWSkpSbkJBNEZwMms2elBDU3ov?=
 =?utf-8?B?ZmZKL3lVN05wTnNrOGpUQXVNVkE2Q01sN2VrTmFHSFZkQTBPVXJVelVsY1FT?=
 =?utf-8?B?aW1SNkp3M3JYWDU0MjF5ZU8wRE4vUHRUaDZ6OVlmSE55anBtRDdPRDZaS2lv?=
 =?utf-8?B?NmpXYnVDNWczc0tFSFl4T0NOQmZQMDM5ZDZnTU15Qk80M29IdHRhOEU0MHpR?=
 =?utf-8?B?bGNmU21hNmM5QVNzTGp0UThvNDhTZXZ2U1pkUDg4aUdrVzRaOWwvczZwdTM2?=
 =?utf-8?B?YkNNcFNETHByeTFZY09zMUZmcTRzTzZjOTRnNHNPRzQxcnViRUxTSU9QTnV5?=
 =?utf-8?B?RXdVRmxodkh2R0NWM0h3MWtBa3F2b2ZrZG84SjRQOUtMeWIyWU1lU0xnR0VE?=
 =?utf-8?B?QXhmbElieS94S2JIRGVSN283UzBXMUNSQXlwcGFSekJEcG01SXArQ0pFVzNH?=
 =?utf-8?B?aTBFUVZ4WHNqVVJ6NzQ1Yys1c1BrNWVoWkkyYmJaY3FyQVRhVFdtZ1FNcDEr?=
 =?utf-8?B?Q3o0bDh6UXowSmEvODA3eXY4dzdqUzRPM3F2ZklGQUUrS1FNbXZocHRqN3hO?=
 =?utf-8?B?WUZVRDBXVlJBU0Y3dGEvYVZwS2ppMExwTnhTbWhFd0Y3RFNOMDdmcFZnOHZk?=
 =?utf-8?B?TXZGTEdhcU8vSmVTRDVWRTZMcjBmdThLanNEK04rTXVvOGc4VjR6YTdoSEh0?=
 =?utf-8?B?L285elRyT2JRUXF4YWdOOEpldDhlNU9aTi9TaFN1VFZSKzd1TDk1dnZzeEZV?=
 =?utf-8?B?eXFoKzBFZnN3aUY5N1hGcWo3Z3lyUDYrMkV3aDdLQzhDV2o0UGZId1hEMW9N?=
 =?utf-8?B?UzdMOU15ZVpCQjBSbk5ZcUY2ZEdVMkRVUS91RWozMkdaZkk1akNZWHo0RTlE?=
 =?utf-8?B?dkRYN1dJa1V5WWQwalY0Sy9nMkt0WVRzTkx2S0hXUnZMZFFuc1FnNEQ1YzVC?=
 =?utf-8?B?U2NLNFNxNWduaDJURURCZ3lnRFdXamoxVWlVUXB5eXQ4Nks4bkhSYW9aT3ox?=
 =?utf-8?B?S2hYSk9GanR4ODV2UmN1QjVDdVZzMnYraE1ERkZTaXAvTlZSQ0dUWTNidkRx?=
 =?utf-8?B?Y2ozQisvYWVnRWgzTmFhSzc3dWJhdEZvbGNKL0NmYmFFR2RuNGhtdkhxNzl1?=
 =?utf-8?B?YXY2UlE3eWU1bzlhRG9VN09jeStZRU9vVTdWcVhNZk9sS0h0ejQzaDNPNDhj?=
 =?utf-8?Q?HKZ8yEuYt//k04DU=3D?=
X-Exchange-RoutingPolicyChecked: aKgX/WWH9Jf2tzWmXk/NE8SIDhXjKbjkOCTiVJY6wvFB5dBlg2jUl2GQ5ygjEiuKRP2WA/iXCyQVtCRksKWb1h1v/UC3XT+/NreaLcWdgIDBM97boqwl6ydNceU61y5BU2QXmRe7tRtQJ91YaZBVfALMy9YMKbN5ThbSAV8xVvEXLAtpUTJEl8fwBNWWWuF8pHdmOow66mmIBzXBjCmmdS4yfRHhvH0N0kcOWpvzNFvtx7Ro5zBOdVCtb65rgv3QK+HODPTc3y9HD4l4typfB75yzkuBs2vb+3HMERl1d5VzAUytamp89n+m9QjJrEKo2w3SmOAd7Gtexxf57sZYlQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: da93b27b-0659-4260-5993-08df2c63c532
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 15:31:53.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6ynA4KAuSzpNok/7EfG9tfO9REoVPXnN3MkSmvZjrkEcp+GD2KKh3SCd5lBtIGUI8BWhk0ztW/XOeu3Amy/G5uRE4KcLwOPwTkBTBE7QdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 03:06:06AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Undisclosed relicensing.
> - [Low] In tools/testing/selftests/net/lib/Makefile, the xskxceiver
>   binary is only removed by `make clean` when bpftool happens to work at…
> 
> --
> 
> selftests: xsk: move the AF_XDP test suite to selftests/net
> 
> This commit moves the xskxceiver engine, the xsk userspace library, the
> test definitions and the XDP program from selftests/bpf to
> selftests/net/lib/xsk. It also moves test_xsk.sh and xsk_prereqs.sh to
> selftests/net, and net/lib now builds xskxceiver only when a working
> bpftool is found. The two ethtool ring helpers move from
> bpf/network_helpers.c into xsk.c.
> 
> > diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
> > index ff83603397d06..c26088da04892 100644
> > --- a/tools/testing/selftests/net/lib/Makefile
> > +++ b/tools/testing/selftests/net/lib/Makefile
> > @@ -5,6 +5,15 @@ CFLAGS += -I../../../../../usr/include/ $(KHDR_INCLUDES)
> >  # Additional include paths needed by kselftest.h
> >  CFLAGS += -I../../
> >  
> > +# xskxceiver needs a working bpftool to generate its skeleton
> > +BPFTOOL ?= bpftool
> > +HAS_BPFTOOL := $(shell $(BPFTOOL) version >/dev/null 2>&1 && echo y)
> > +ifeq ($(HAS_BPFTOOL),y)
> > +COND_GEN_FILES += xskxceiver
> > +else
> > +$(warning excluding xskxceiver, bpftool not installed or not working)
> > +endif
> > +
> 
> [ ... ]
> 
> > @@ -13,6 +22,7 @@ TEST_FILES := \
> >  
> >  TEST_GEN_FILES := \
> >  	$(patsubst %.c,%.o,$(wildcard *.bpf.c)) \
> > +	$(COND_GEN_FILES) \
> >  	csum \
> >  	gro \
> >  	xdp_helper \
> > @@ -23,3 +33,28 @@ TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
> 
> [ ... ]
> 
> > +$(OUTPUT)/xskxceiver: $(XSK_SOURCES) $(XSK_HEADERS) $(XSK_SKEL) $(BPFOBJ)
> > +	$(call msg,CC,,$@)
> > +	$(Q)$(CC) -I$(top_srcdir)/tools/include $(CFLAGS) -I$(OUTPUT) \
> > +		-I$(SCRATCH_DIR)/include \
> > +		$(XSK_SOURCES) $(BPFOBJ) $(LDLIBS) $(XSK_LDLIBS) -o $@
> > +
> > +EXTRA_CLEAN += $(XSK_BPF_OBJ) $(XSK_SKEL)
> 
> [Severity: Low]
> Will make clean leave lib/xskxceiver behind if bpftool can't be used
> when clean runs?
> 
> HAS_BPFTOOL is evaluated when the Makefile is parsed. xskxceiver only
> ends up in TEST_GEN_FILES if "$(BPFTOOL) version" succeeds during that
> same make invocation.
> 
> The clean target in lib.mk removes:
> 
> 	$(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES) $(EXTRA_CLEAN)
> 
> Here EXTRA_CLEAN only lists the .bpf.o and the skeleton.
> 
> Say the binary was built with a working bpftool, and make clean later
> runs where bpftool doesn't work. That can happen with a different PATH,
> a BPFTOOL= override, or a cross environment. The intermediates get
> removed, but $(OUTPUT)/xskxceiver stays.
> 
> test_xsk.sh only checks:
> 
> 	if [ ! -x "./${XSKOBJ}" ]; then
> 
> So it would run the stale binary instead of skipping.

Stale binary is still a valid xskxceiver...test_xsk.sh is later gone so
this check is not something we should worry about.

However, adding it to EXTRA_CLEAN would not hurt, as a follow-up. Maybe we
should audit also other binaries (iou-zcrx) while at it.

> 
> Would it work to add $(OUTPUT)/xskxceiver to EXTRA_CLEAN
> unconditionally? The same Makefile logic is still there at the end of
> the series.
> 
> > diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/net/lib/xsk/xsk.c
> > similarity index 95%
> > rename from tools/testing/selftests/bpf/xsk.c
> > rename to tools/testing/selftests/net/lib/xsk/xsk.c
> > index 25d568abf0f20..6bd32caf5d085 100644
> > --- a/tools/testing/selftests/bpf/xsk.c
> > +++ b/tools/testing/selftests/net/lib/xsk/xsk.c
> 
> [ ... ]
> 
> > @@ -779,3 +778,51 @@ void xsk_socket__delete(struct xsk_socket *xsk)
> >  		close(xsk->fd);
> >  	free(xsk);
> >  }
> > +
> > +int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
> > +{
> 
> [Severity: Medium]
> Does this move change the licence of these helpers?
> 
> get_hw_ring_size() and set_hw_ring_size() come from
> tools/testing/selftests/bpf/network_helpers.c, which has:
> 
> 	// SPDX-License-Identifier: GPL-2.0-only
> 
> xsk.c starts with:
> 
> 	// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> 
> Tushar Vyavahare added both helpers in commits 90a695c3d31e1c and
> bee3a7b0762422 under GPL-2.0-only. After the move they are unchanged,
> but they now sit in a file that offers its contents under LGPL-2.1 or
> BSD-2-Clause, with no per-function licence note.
> 
> The commit message only says "Move the two ethtool ring helpers from
> network_helpers into xsk.c". It doesn't mention the licence change, and
> there is no Ack from the original author. This is still true at the end
> of the series.
> 
> Could the helpers go into one of the GPL-2.0 files in the same
> directory instead, such as test_xsk.c or xskxceiver.c? If they need to
> stay in xsk.c, could the relicensing be stated explicitly, with an Ack
> from the copyright holder?

libbpf was at latter dual license AFAIR, I did not pay much attention that
apparently network_helpers.c had it different.

If Tushar would insist as original author I could fixup licenses, but I
don't see it as a show-stopper.

> 
> > +	struct ifreq ifr = {0};
> > +	int sockfd, err;
> 
> [ ... ]
> 
> > +int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param)
> > +{
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
