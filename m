Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C22C385D7B;
	Sat, 17 Oct 2026 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258875; cv=fail; b=mNS3UHnkp0APudk5+LxeFBw8JDawbdbdA4iwBpfBXJoxGWr9x3RO9ynRUmQbxZlxeJpHWWcW83L15NWk9XF5WQcHGHkvlpwa5kb4jTBfXPZ6BW6RfkN4JJPOZ9YF3ERohQ2K8M839q4zOPZDeR9z0oA6Vwx7FEsQWIITUiQHbFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258875; c=relaxed/simple;
	bh=N/bN9eyrxEUE7cG3EcmfMp3fUUjMq3/uoWoYShIzlAQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Vd38VeUdEfA3RATH62m4KMD6DEoyOcikn4TRfCVHwhaxCnSyWrGpMc+aoImqJkeBlr2oLWWEHvcBUkXelAb5LRedvoXq1poOYzHCis6b3ZzL4T9XpwalhdAI5IkmjRrLvzCPvjFDtZL9EIzTJUQZKEbWlANaFNyzLi4Zwq3kAOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKoAHNAB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKoAHNAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792258872; x=1823794872;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=N/bN9eyrxEUE7cG3EcmfMp3fUUjMq3/uoWoYShIzlAQ=;
  b=PKoAHNABVCNOEKp9nVB3dlAhs5BhK9H3NMM+So8Cd9Dgc7Vq+vQEtKss
   xeVwCpOKu/HwpBPTcHXSSYlnccLabXjuf/GzobMf901LwcnY1Bkkq++H2
   Q7ewdxNJgoyJRqK1OdFsh9/USfRrCWWSBeRePFGo11jekswb0qab/4GDv
   xbyVLz2hOBcZwjJvutaunm/zHyJOKUd7sPoYT1dbESY+0tDj9Rp/Nr755
   TT2zebM2yvitCHBLqZrIW/pqZGHz47nWnwZwbwqM8VcBFzk/8zN6a8Y7a
   3H3OjjI5uZeT1q2NIHi2M4LcLVMI7HzdOssZXBCsuCuywswkVKTbTeb3i
   g==;
X-CSE-ConnectionGUID: y6/FYK14R9SDEPP3DbfUcw==
X-CSE-MsgGUID: T9hlXBfWSLit+EKdzNdy8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1014977"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1014977"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 10:41:11 -0700
X-CSE-ConnectionGUID: HRS/Mrc0TdWTs9tcHPQOyA==
X-CSE-MsgGUID: TowqRnAKTzaGKDNY82NB5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2187472"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 10:41:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 10:41:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 10:41:10 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.61) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 10:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0iR+RbjDu1JXIMebnq7JPRBC8e4T0EW7hcijxa3cr4QJEXlYhjKRs68JlIxE2c/Y8CITAH8e+yR9VHhfZGyNGFpCqZMPSmIim3viryArLY4Wn2WVGLUzGx+nOuaeKJfeUjG3bEhPoQGTmneZdGIJcKyl0vAYjHfZihZJT8+iHhlg7Ev9OZ4zNYIBLLn/3TKPa9mo/zdfVerJY4DOVSAPYjBhonlqqIMno4hB3tUnJLU3oUlZPOkX30bc0tS7nNZgY3s+WwIAVelfByqcWh5zfzBrhR+ujZeXasPWCg1q3/PmFh4CUpeaASW/ZdqTnVbga8pLSsUyp9QQbYwlMaKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xme2zOMWFZZhZ8XIiQz8bgmDKMFddc3JZ9F7gaSnsY=;
 b=lAIfP3xDyKUkYjw9istffaP8PH5hxt2p4a6EYncbdDe8GUy6VpIm+0kwJljPwQM22e+YM8UVFcOh0RLj8QfCpm+KteEvNgD3FF4uLuO+FNFWVYbCgUQFl1JwvBKMm1b0m1cRQbAeGQ3y1S2jrzp4rXSx3cCmuLmaypNPLxIFnoV0mmMHRIQylJHfMkI0a2n8RukRPU2xIAcyI9ZZqm58ubIbMthx5d1S0z4sVkV+fwXRYxXo9tTkbHFn6y2iadc2YR0buIatfxcnrh9dkvMNtEF689wqdpc9y7cUD9ESa9jtdnyOYXlWPPY3VlU3nFPhIJf7AsJjtQviFxoyUIS1RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4616.namprd11.prod.outlook.com (2603:10b6:208:26f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Sat, 17 Oct
 2026 17:41:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 17:41:06 +0000
Date: Sat, 17 Oct 2026 19:40:54 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net-next 11/15] selftests: xsk: add a hardware mode to
 xskxceiver
Message-ID: <atOzJh0xuXP3fiw0@boxer>
References: <20261014184539.774708-12-maciej.fijalkowski@intel.com>
 <179220636945.434549.3726298644003511435@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179220636945.434549.3726298644003511435@kernel.org>
X-ClientProxiedBy: WA2PEPF000008AF.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::657) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: f607f207-01bc-4c1d-fbe6-08df2c75d237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|17002099007|10067099003|3023799007|4143699003|261009221227099003|261009223027099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 7/v05hjXAWgVCb+KsUcOCqS73jo7v7FuNbp7HsC4sZ7r7tMRhhfk4fGAjhzQixC18TA6i0i9AgstFwzWMV//9hs95xewszSBLbmluBAgSZoKi31/0tsXAInfkntotwwYOwlhkVnt86X0EqnUGlmyARLwp13dmfnu8ZQ0JUYM++Q2Ddp5q0yA7m52rb+in2zduFrVskG+R/rTvyz/BiHTLbX6R7NOI88oPDe/CI1yUao3b2BlK2FXe/VdMiXiyFSdJnCGpdwDfygLKaqUKTHh8C+JF+mstLflwiULyO7F/d+mq3krObfJI0KYNKjeL++WHwmDkMY6BW8/tIReKgwuMZU3rXb2EhuOn0CHMfsA6LmPaMyPii9zEvrDVdp5/NWrNexjs6F/urMn37+Fn95lB2rZ7zbHW65ZNK3T0me0Ch6aFlzFGyyu86455hOtmQKJRihAfa9GfUyTD/NMPJ3+SWuxMjM8PAhawdRypZXauO4hNqshj+D5wNHaFcAdIrNr9lHeqOgIDhYuq3lUPEWW7RYbGn6hx5ZwRibBvnVbHMfzUCt3iprdYTfoJtBh3y4mgMXXKn1UMCy25VagwcIxesIPg2U5PX+Por51pNH//WE68uKik7g/I2KUW/sLLCui
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(17002099007)(10067099003)(3023799007)(4143699003)(261009221227099003)(261009223027099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdFbkRGeDlQUFBsNmQ5WWMvdytiamEyOC8ycTVoVTRTZXlxNldjb2VzQkFJ?=
 =?utf-8?B?LzlqMkorRDQ4RURhV3MwYkhNb3VyNDRzWTJhRGtubDh2UHFJdHlmejhFM2E5?=
 =?utf-8?B?bHJQRVdsTWNxZVRyREZMR290Sm9ZcWExYTZtc0FQU2JPQTJyQTk1c1dIUC9M?=
 =?utf-8?B?MFJISEpOeW56WWlzY2xLbzE1YjZ4dG9SMEs4MW9RNGl3Q3hIdXNzQmVCWUdh?=
 =?utf-8?B?ZW5ZSTdjWUo4MmVKVzAwSE9haERXUlZxaUh0Nm96VG1YMmhoT1RmOGJZN0dh?=
 =?utf-8?B?My96dkRQMjl4MWJJSFI3TnVmc24zOVNMUlNoUFo1ZGhzNlNhc2tzUWFrQVpL?=
 =?utf-8?B?TDBuNE82cVBEK1lmck5tUURhUmgrZDZ6RzhLTFhXT09meC9PWWU4V3hYV1gr?=
 =?utf-8?B?VVZIUHJqTzkzd1VVWk5yOEtNKytzM3RRZmJrcm81UWZzbkV2aWpXS3RQdEFk?=
 =?utf-8?B?cGRZZWVsaFNJQ3JZd0FDYWZLSVVsOEQyUk5NMkhlL3doNUgwdFUxVnlFS1Vn?=
 =?utf-8?B?ejBhdTAxM3FuZmhZek01bnJheWdQbVkvaDM3OFAxaFJqM0REK0VheDA4czJk?=
 =?utf-8?B?MUVRWG5SWDYrYVFybFg0aENoUVhxZzZLSS9IU2c4M3lqUjBLei90MU1DU1lB?=
 =?utf-8?B?MkF3WDFuTkFVWkdNZFpxOTd6SDFUYTU3aTBaQnYzdmlSS2RuaUFOUTF6NmQz?=
 =?utf-8?B?bUh3MTdRYzAvajRpOEs4bnVpV01XR1E2K1ZYNHhneUMyRnptNG9HN3k2ekQz?=
 =?utf-8?B?Z3V6WllGNzQyMDNaMTBYQlVuS29KTEMrQS83NEd1TUxHRy83MXcxb3dxL1lO?=
 =?utf-8?B?OVIxcWVuaWJUWlBFdEU0MnVicnhEMlVXVmFpK2t0SXh0SjBMeCtGUUYxa2to?=
 =?utf-8?B?VERrMFNRc21iZElFU3E2TTVRQ3FyUHRtc09ENHJzOC8ra09oMDd0RGx3aWJ0?=
 =?utf-8?B?VTdQZnpkaUpUYmpoaVNOVmNVTFVqR05ISjJPRWp5K1dxS3JvREZtRWVmUUZS?=
 =?utf-8?B?ZEw3aHZJNjBOZk1qaXRYamZOVk04Q2R3clNQaUo0ZHJLT3RVdGRLbGFyeStn?=
 =?utf-8?B?NldOVjhocENlM3orVHE4cEZ2QzhXcEZMdW9nR2JNUzZYTTc1d3pZaTdSclhu?=
 =?utf-8?B?QnVhQUVldzhDcmdFdk9TYTdFZzd3REpBZEI1aDZUcFFsV29rV1FtZXdhYnp1?=
 =?utf-8?B?WkxGSkdRN2hNT0lWWVRXY3BWNTNiK2hYME5aV2trSkdrcnBrNDl5VWhJUUFh?=
 =?utf-8?B?STU5NUdHR050KzU1a2dwN1RScjNQN0tJWnZoWEZzL05GNWNhK0FxV2R1NXRn?=
 =?utf-8?B?MndYTmx2bHc0c24wdUdiYzJRZzRoM2JRL1BTanltQVQrTitMMkFHMm9XSE5x?=
 =?utf-8?B?UWNxQTVwZ2d3MWRyZG0ydkZNZGtsZE00bkkvdHJLeWxlUmllUzdhd2xNYXBY?=
 =?utf-8?B?TlpXYWRXSkZSVVRoREJiN3ZQaWJGTTFoZnhXak5nZTRmU2FEVmxyNWNweFYw?=
 =?utf-8?B?dzN1WDRlbVNrTjRUcGpzVnJzWjZQMDhDdkZyMkEwUytrckNka0RJZFg2L0dv?=
 =?utf-8?B?SzV4L0diOG1JZjNCVHo1dGhFcTBlbzBNdzBhSmxGUDQ1QnNybklkdytxSnA5?=
 =?utf-8?B?ZnhRQUFMYkhYMkh4aTdRSEJNbEtXbDUxN2NQbjJQVTJUajhkc3ZUQXJFN3li?=
 =?utf-8?B?TXIzSU5LK0hRQUV5R1hDbjkzcml3NlRzblc1WkZ3Z1BkV1dPalpJUGEzRENR?=
 =?utf-8?B?S1AvUnZjaUhwTXk4ZXVzNU9Sc2x4MHZrb21abXJGTWNBWS9pQWxFckdldkpO?=
 =?utf-8?B?T0lncGxvTTNocXFGUC80TEFrSlBIc29RZmhzYnhZZzJrUTB0UUR5WnYrWXVT?=
 =?utf-8?B?N1BpZU5mbFhyc2g4N3p6Q2J6U0RPYU9jMENpeit6Q245OFlXU1cyYXh0ZHF4?=
 =?utf-8?B?WElNWHJoMERoMSsrS0UwdTgxdWs5eDVqbDUzcEt5M0oyOFVEVDJzYnh5YmRo?=
 =?utf-8?B?eGIyZkZ5MmVCb1RVMDdEU3dkNEEyRFpjbk8rNzlSdm9pZkR5VUg2RUZHMVg0?=
 =?utf-8?B?eUozQ2hWZzFuOEVXVVkvM1NvTCt1WmNobzJ1NDVUMFdIa2M0RVlLbDlaVWNk?=
 =?utf-8?B?cmVPMGZCVFRpbUZ3a3BvVjdqMVNxTXdrQkxaamlvZVNKb0REb3ZMNDRRVkhV?=
 =?utf-8?B?UmltL1lKNExubmRmaUdOakllRXlFUStsVENaTjhUOUMzNkRPYmNrOHRmODNS?=
 =?utf-8?B?NkFFNmJTT3NyMDRUVDN0UDBydVl5TFFJckg4VWxFbW1hdy9QZGxKcHRVWElw?=
 =?utf-8?B?RWdtemZ4dFdreHpVdHVsaVZTRndvcmVCUDlSRzFwQnBUNjFjVkZaNUhsTDRG?=
 =?utf-8?Q?7RoYjM5O3SIHqC5c=3D?=
X-Exchange-RoutingPolicyChecked: R9dagSpfeG7/NJXZl/Ai5zX5E2yzcrQ/VHpWGoS2zAXwWWzbtNtd0AQoY9FoHGMQ6SVXFmx/1MrNXwsGX1rtGFfdGzpxUtKbxmVW2CokpC0fOexT6WP02HNGEyNsJaxdpQUX6hKB1iXmOfH9A3CHdFbqlYekxV6YcrPztrAzJj8wEyU10KZNu97leRswg48cbqW7tDDIjxIKFPTFCw7QMRtadtozsp1CETLeXFsS7btUB8uC52fbadHBdnaYEPMTPCmMFLYeuMKykJ+b3sdEqW7ziNRqKdGWeb02HrfmdF1SJWafTI1mPk1R2VM2b+NqFK7X75yxHL6s2VjYJrcKZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f607f207-01bc-4c1d-fbe6-08df2c75d237
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 17:41:06.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruDr9mDl/waSYVTpnP7YvzOWND2YCwgLyj+V6fWGCLf2Q+ogI4R32purPz/OH30OdSeVvEUz3TF61QTPZ5F2Rh598SjUtqNnXDAZW77eAGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4616
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 03:06:09AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 7 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 4
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] A hardware SKB-mode endpoint still gates every multi-buffer
>   case on XSK_CAP_MBUF.
> - [Medium] The comment in wait_link_up() says 'Each endpoint makes its
>   changes before it is ready', but the TX endpoint creates its UMEM and…
> - [Medium] cleanup_iface() in xskxceiver.c now fails the endpoint when
>   xsk_set_mtu() cannot restore orig_mtu, but it still ignores the return…
> - [Low] At this commit, hardware mode switches the test frames to
>   UDP/IPv4, but the XDP programs (xsk_def_prog, xsk_xdp_drop,…
> - [Low] testapp_too_many_frags() builds the stream from
>   max_frags_override no matter which mode the local TX endpoint runs in.
> - [Low] parse_command_line() rejects --listen and --max-frags without
>   --hw, but it silently accepts --udp-src, --udp-dst, --udp-port and…
> - [Low] In hardware mode, sync_endpoints() exchanges READY and then each
>   endpoint calls wait_link_up() on its own interface only, once.
> 
> --
> 
> selftests: xsk: add a hardware mode to xskxceiver
> 
> This commit adds a --hw mode to xskxceiver. In this mode,
> drivers/net/hw/xsk.py can run AF_XDP cases between a zero-copy DUT and an
> SKB-mode remote over a physical link, using UDP/IPv4 frames between the
> real MACs. It also adds --queue, --listen and --max-frags, waits for the
> link after endpoint synchronization, defaults cases to ETH_DATA_LEN, and
> restores the original MTU in cleanup_iface().
> 
> > diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> > index f67a32c0260a3..a280956d53f4a 100644
> > --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> > +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> 
> [ ... ]
> 
> > @@ -84,11 +97,72 @@ static void write_payload(void *dest, u32 pkt_nb, u32 start, u32 size)
> 
> [ ... ]
> 
> >  	memcpy(eth_hdr->h_dest, xsk->dst_mac, ETH_ALEN);
> >  	memcpy(eth_hdr->h_source, xsk->src_mac, ETH_ALEN);
> > -	eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
> > +	if (!udp_packets) {
> > +		eth_hdr->h_proto = htons(ETH_P_LOOPBACK);
> > +		return;
> > +	}
> > +
> > +	eth_hdr->h_proto = htons(ETH_P_IP);
> 
> [Severity: Low]
> At this commit hardware mode sends UDP/IPv4 test frames, but xsk_def_prog,
> xsk_xdp_drop and xsk_xdp_populate_metadata in xsk_xdp_progs.bpf.c still act
> on every frame received on the queue:
> 
>     return bpf_redirect_map(&xsk, 0, XDP_DROP);
> 
> On a physical link, could non-test traffic such as IPv6 ND/MLD or LLDP
> reach the socket on the bound queue? Could it also shift drop_idx or the
> metadata count?
> 
> This is resolved later in the series. The commit "selftests: xsk: pass
> non-test traffic to the stack in hardware mode" adds is_test_packet(), and
> xsk.py adds ntuple steering. drivers/net/hw/xsk.py does not exist yet at
> this commit, so no runner can hit the gap here.
> 
> [ ... ]
> 
> > @@ -1703,14 +1829,36 @@ static int testapp_validate_rx_endpoint(struct test_spec *test,
> 
> [ ... ]
> 
> > +/* An MTU or XDP change can reset a NIC, which takes the link down on both
> > + * hosts. Each endpoint makes its changes before it is ready, so once both are,
> > + * wait for the local link before any traffic.
> > + */
> 
> [Severity: Medium]
> Does this hold for the TX endpoint? worker_testapp_validate_tx() runs the
> barrier first, and only creates the UMEM and the XDP_ZEROCOPY socket after
> it:
> 
> worker_testapp_validate_tx()
>   sync_endpoints()
>     xsk_peer_ready()
>     wait_link_up()
>   testapp_validate_tx_endpoint()
>     thread_common_ops()
>       xsk_configure()
>         xsk_socket__create()
>     send_pkts()
> 
> The RX side binds in testapp_prepare_rx_endpoint() before sync_endpoints(),
> so only the TX bind happens after the barrier.

corrected comment in v4

> 
> On some zero-copy drivers the pool setup restarts the interface. For
> example, dpaa2_xsk_enable_pool() in dpaa2-xsk.c does:
> 
> 	up = netif_running(dev);
> 	if (up)
> 		dev_close(dev);
> 	...
> 	if (up)
> 		dev_open(dev, NULL);
> 
> dpaa2 advertises NETDEV_XDP_ACT_XSK_ZEROCOPY. Can send_pkts() then
> transmit while the carrier is still coming back? That would lose the
> frames and leave RX to hit the 20s timeout in hardware TX-role cases. The
> code is the same at the end of the series.
> 
> > +static int wait_link_up(struct test_spec *test)
> 
> [ ... ]
> 
> >  static int sync_endpoints(struct test_spec *test)
> >  {
> >  	int err = xsk_peer_ready(ctrl_peer);
> >  
> > -	if (err)
> > +	if (err) {
> >  		ksft_print_msg("Endpoint synchronization failed at step %u: %d (%s)\n",
> >  			       test->current_step, err, strerror(-err));
> > -	return err;
> > +		return err;
> > +	}
> > +	return hw_test ? wait_link_up(test) : 0;
> 
> [Severity: Low]
> Each endpoint checks only its own interface here, and nothing comes after
> the link check. TX goes into send_pkts() as soon as its own ETHTOOL_GLINK
> reads up, and pacing_tx_sync() does not block. xsk_wait_link_up() returns
> on the first sample that reads up:
> 
> 		if (err || edata.data)
> 			return err;
> 
> Suppose the RX host's driver applies an MTU, XDP or ring change through an
> asynchronous reset, and the link drops only after READY was delivered.
> Could TX then act on a stale up state and transmit into the reset?
> 
> At the end of the series the control connection runs over the tested link.
> That covers drivers that reset synchronously, which is what ice, i40e,
> mlx5, igb and ixgbe do. No mainline driver with an asynchronous reset was
> identified, so this may only be theoretical.
> 
> [ ... ]
> 
> > @@ -2284,7 +2444,9 @@ int testapp_too_many_frags(struct test_spec *test)
> >  	u32 max_frags, i;
> >  	int ret = TEST_FAILURE;
> >  
> > -	if (test->mode == TEST_MODE_ZC) {
> > +	if (max_frags_override) {
> > +		max_frags = max_frags_override;
> > +	} else if (test->mode == TEST_MODE_ZC) {
> 
> [Severity: Low]
> The override replaces the limit no matter which mode the transmitting
> endpoint runs in. If the SKB-mode remote were TX with the DUT's zero-copy
> limit, wouldn't the copy-mode TX path send the "too many" packet anyway?
> 
> At the end of the series TOO_MANY_FRAGS is listed only in hw_tx_tests[].
> xsk.py always runs it with the zero-copy DUT as TX, so the mismatch does
> not appear reachable there. Would a short comment noting that assumption
> next to the override help?
> 
> [ ... ]
> 
> > @@ -2378,6 +2540,7 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
> >  	if (query_opts.feature_flags & NETDEV_XDP_ACT_RX_SG)
> >  		ifobj_set_cap(ifobj, XSK_CAP_MBUF);
> >  	if (query_opts.feature_flags & NETDEV_XDP_ACT_XSK_ZEROCOPY) {
> > +		ifobj_set_cap(ifobj, XSK_CAP_ZC_ADVERTISED);
> 
> [Severity: Medium]
> A hardware SKB-mode endpoint still gates every multi-buffer case on
> XSK_CAP_MBUF. That cap comes from the native driver NETDEV_XDP_ACT_RX_SG
> flag, queried with XDP_FLAGS_DRV_MODE. In __testapp_validate_traffic():
> 
> 	mbuf_cap = test->mode == TEST_MODE_ZC ? XSK_CAP_MBUF_ZC :
> 						XSK_CAP_MBUF;
> 
> 	if (!ifobj_has_cap(ifobj1, mbuf_cap) ||
> 	    (ifobj2 && !ifobj_has_cap(ifobj2, mbuf_cap))) {
> 		...
> 		return TEST_SKIP;
> 	}
> 
> Generic XDP does not need native RX_SG for xdp.frags programs.
> netif_receive_generic_xdp() handles non-linear skbs through
> skb_cow_data_for_xdp().
> 
> Take a remote NIC that does not set NETDEV_XDP_ACT_RX_SG, such as igb, igc
> or ixgbe. The remote then skips SEND_RECEIVE_9K_PACKETS, UNALIGNED_9K,
> XDP_METADATA_COPY_MULTI_BUFF, the ADJUST_TAIL_*_MULTI_BUFF and
> *_INV_DESC_MULTI_BUFF cases, and TOO_MANY_FRAGS. The zero-copy DUT checks
> XSK_CAP_MBUF_ZC instead and continues.
> 
> Does the DUT then fail in sync_endpoints() once the remote closes the
> control channel? At the end of the series xsk.py reports this one-sided
> skip as SKIP, so multi-buffer coverage is lost whenever the remote is a
> non-SG NIC.
> 
> The commit message says:
> 
>     - a hardware endpoint probes only the mode it runs in, taking zero-copy
>       support from NETDEV_XDP_ACT_XSK_ZEROCOPY
> 
> Should XSK_CAP_MBUF follow the same rule for an SKB-mode endpoint?

I assume this implies mixed NICs setup, say ice<->mlx5. mlx5 supports
RX_SG but not ZC_MBUF, so mbuf cases for ice as DUT will run.

I view this as corner case of funky setup, better to be addressed but
again it is rather minor, I haven't seen in netdev CI a setup which would
be currently offended by this.

> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> > index 769718cad8cd7..7044822f23c0a 100644
> > --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> > +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> 
> [ ... ]
> 
> > @@ -306,6 +378,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> >  	    !*opt_peer_host || !opt_peer_port || opt_run_test == RUN_ALL_TESTS ||
> >  	    opt_mode == TEST_MODE_ALL)
> >  		print_usage(argv);
> > +	if (opt_hw && (!opt_udp_src || !opt_udp_dst || !opt_udp_port || !opt_peer_mac))
> > +		print_usage(argv);
> > +	if ((opt_listen || opt_max_frags) && !opt_hw)
> > +		print_usage(argv);
> >  }
> 
> [Severity: Low]
> This isn't a bug, but --udp-src, --udp-dst, --udp-port and --peer-mac are
> accepted without --hw and then silently ignored. main() calls
> xsk_set_udp_packet_format() only under opt_hw, and setup_peer() copies
> opt_peer_mac only under opt_hw.
> 
> Should these options be rejected without --hw, like --listen and
> --max-frags are? print_usage() also describes them as if they always apply.
> 
> [ ... ]
> 
> > @@ -401,8 +487,16 @@ static void cleanup_iface(struct ifobject *ifobj)
> >  		xsk_detach_xdp_program(ifobj->ifindex,
> >  				       ifobj->mode == TEST_MODE_SKB ?
> >  				       XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE);
> > +	/* After the detach, as an attached program can cap the MTU. */
> > +	if (ifobj->dev_mtu != ifobj->orig_mtu) {
> > +		err = xsk_set_mtu(ifobj->ifindex, ifobj->orig_mtu);
> > +		if (err)
> > +			ksft_print_msg("Failed to restore MTU %d on %s\n",
> > +				       ifobj->orig_mtu, ifobj->ifname);
> > +	}
> >  unload:
> >  	xsk_unload_xdp_programs(ifobj);
> > +	return err;
> >  }
> 
> [Severity: Medium]
> A failed MTU restore now fails the endpoint. The ring restore just above
> this hunk still ignores its return value:
> 
> 	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
> 		hw_ring_size_reset(ifobj);
> 
> set_hw_ring_size() can fail with a non-EBUSY error, or after the EBUSY
> retries run out. In that case hw_ring_size_reset() keeps the changed sizes
> for a later reset. No later reset happens, because the process exits, and
> the endpoint still reports PASS.
> 
> This patch makes that more likely. __test_spec_init() now resets rings on
> any local ifobj, and testapp_hw_sw_max_ring_size() now sets the receiver's
> rx_pending to rx_max_pending. The final xsk.py relies on the endpoints to
> restore ring sizes.
> 
> Can a failed restore leave the NIC with enlarged rings? The next run's
> detect_ifobj_caps() would then record those as set_ring.default_tx and
> set_ring.default_rx. Should the result of hw_ring_size_reset() also feed
> err here?

In v4 the runner sets and restores the rings, not xskxceiver, including
when an endpoint is killed.

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
