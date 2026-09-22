Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864355C334;
	Tue, 22 Sep 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093173; cv=fail; b=DePdUT3At1tSd+jjyYHI63n9Ab4St3qT0+Cym++eOCgFnU/Jgz3/auSVpRpkWDQ6WLsQfxvpuWo6mLXuzbKFdImNh2pd/b6kwguGGPFGjjb+tKfc2KeOMu5BP3Yc993resmPAW69Wj2p8MTSsIlId0X5uYVUR370o25FFZHAfdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093173; c=relaxed/simple;
	bh=Sjmnfzbo6Vbe6ObdtDWBs9c4t72S2ZCLMULdq00Nm7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XvmHn7h5sM+WrzVfu2CwN20LxeoN/heK3xoEJA+n+HadHlTPqn9cOdxwzeUziTUFIIfGQCB0FJNz9io0S00yd6yKc/LkhsWVcpFgILMw6l7fSdMGY3YR9RofXCkm/kJ3XLLJxSfyzKXqbXugbSUiIN1PDw/KN/l3Y2seAstnQ2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNcIrrFA; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNcIrrFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790093170; x=1821629170;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Sjmnfzbo6Vbe6ObdtDWBs9c4t72S2ZCLMULdq00Nm7M=;
  b=JNcIrrFAcDiXRcjZmWsdOklVTsdp9tBoax8WhwpaYk5L0E/XuNT96UVI
   jCLlpzNrelYF8Tes4ergpnYUvhnHoK1+SqTmU3zWWizZJQUubDCT1UZNK
   uLbMl1bkeGcX77lAa+u3bR6QIz5lwI7oH8n9ux8stnlXHyQ3fDhxMmUTB
   q5NshdtspVlOHp68Yp3A7B3taj2IxyNPsQ23och8fE/XRl83eVrSDzoJQ
   vtU4CgvnxIamqOgUImz2eB7hgyS0eHg7KOtlTbhrk8jS9EWYVIggqPjTi
   4d63zF8rNWS7y23JzeAIl51unhQnNAwdcX95+q9kw3p9TKMFpV/rLUpvH
   g==;
X-CSE-ConnectionGUID: +6ZUhffmRvGC4FBK/At4zg==
X-CSE-MsgGUID: I+VYZal9ToyEGU4ys9DvWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90734803"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90734803"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:06:09 -0700
X-CSE-ConnectionGUID: vWawStBsTYC3fTCq8TlgmQ==
X-CSE-MsgGUID: 5OB6W/OzQh6O+i7lXQJ9uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4273742"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 09:06:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:06:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 09:06:06 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 09:06:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyMRf9hNTyu9XQW0v/nyXwMdlWyYnRKS3mmA6mQ0Ke81NhhkO1iGPfxPgfhcw+IpYEBHM8aTmlDAmwTpvXnJ3hur9jYNkokCVExumYltPxVAZmB15L1j62z8E+dah/dT2esd93BemS6TinsuVJBLG0KIDbLP1eyfOTeBEIzmpVArnWjy7mj74+XVjk6Kzq51aNmUGnXfS0b2iG8a+RI5J73r2ZWGHSOX6Dyi1NpThVlf5lrTzFmvK3OOH9uBfTraDUlcO8UPCWf+EmU4ZUt4FFoiBMxq02hSqt2xL/2PL7huVUPjB4PcouvG8XJBOhJ0/IfehSqU6PUaY858AZZZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfvn2JeglkUYIOFrdN75Z7bKWsurbwx7ASJArl7ms1Y=;
 b=ZVhncHdqiYokDM3Ei5Ft8h0704jDQN8CYqFhBD5YE+KJScw7b0tY9FNRBS1eiiYixo5KISsKRqdTKQ3Ld6ZmBcu1oHkhreWN96Y9+UuJyuhCMdzaX6rS3zDKH4DO7jumAyk2UBV3III2Qg9Gn5yp09I9yjQxwgI2ZdqO4MPIFUFQcffS3Qx+3kwLMCaDHZDrEqTmOAuVYG9PmMX/uP60lpEfsHsT0U4oYbUCp1990JL+Tvzv+hFC0XdAPcycQwYBxucuFaUMotEAtqjirz2xMwHXuDmAq5hDpe0Vlc0qT0Ykzasyu8sjoH758A3FG4KPYl5+/OB8rHlsWHHcuRiO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS3PR11MB9623.namprd11.prod.outlook.com (2603:10b6:8:38e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.14; Tue, 22 Sep 2026 16:05:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 16:05:57 +0000
Date: Tue, 22 Sep 2026 18:05:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <netdev-bot+sashiko@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<bjorn@kernel.org>, <magnus.karlsson@intel.com>, <jonathan.lemon@gmail.com>,
	<sdf@fomichev.me>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>,
	<aleksander.lobakin@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	<syzbot+f16c1b285c9f63994eec@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
Message-ID: <arKm5gCaERk6MaGA@boxer>
References: <20260901083325.3445-1-kerneljasonxing@gmail.com>
 <178847847848.4131868.16090144540850507396@kernel.org>
 <CAL+tcoDpyG-Hy9mtDnLSGu0nvU_VDqTjs-k51r2+OPwVyHtABA@mail.gmail.com>
 <CAL+tcoC=w6j+1p8ovjbLxgb1QdL3ipic0nMOvX_9OJrspSQS2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoC=w6j+1p8ovjbLxgb1QdL3ipic0nMOvX_9OJrspSQS2Q@mail.gmail.com>
X-ClientProxiedBy: DU7PR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS3PR11MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: f635e93b-a5a6-4134-8e54-08df18c36351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|6133799003|18002099003|22082099003|3023799007|11063799006|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: fgRmb58NUTJjzF6mR0s2emEOY3zGOhyKVnY+4AVhwGI0ncTcudFjv8Sr3DKe17WKIzVvyJQ1W/GzaXFZtHC1//bJ4sX+AS+HoDmC1IWA+Pf9zybUD5IpF60Wwy2/n9rfsXmg/xmsk+wKeGSSjZDtlljxU9OLkHKyJ5CMraOA3lH7l+w2vV0zxeXEHkx8zErSc/gBDrkPpkEKSo4Tb4d1oaMB7sU4sLyIgNEvsjFxYi0n6xzqIUQoSR0SjxuipEuTQ1zm3QBfS2TBNCaPpIs8ssW4tHWU64BsQkWTd9xIUbmthgpcdtWvCUgDzKJx16Ev1h53j2TtVK9oYbCwg2n1ymD2DW8Fy2NVnLIMuy/h1deBJw7zTHQ0dRISI1NbPfJs1rOPozjVZwyx7qLu1Hsiv7YeMYmpVJHsdpkVQylsmjMwMM3Bbw4wS3vEEcm9nEFOHLzMykyx5Q+R+454TVfSn55+h/wOZCF5c30rgvLWEAsxVG+W3SvlZFb7FX9ddblnvOf/plfyZIAOVnZPPe9iZF3SVmZCpKTGTjmCet8enxAX8o+ys0i8aj/gB64TOBLvzB1XEgEZvLCsxhXsa1HT0lF3nhaJOSYsAsz1WnlMVeXVHVcpMIWwtY5/s4XhpbB3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(11063799006)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdMYjZxYm85R0VRcDdBUGZyaitOWDIzZ0VsWm8rMjNlVmpLS3o4MUFCWFNJ?=
 =?utf-8?B?NVpsMDBVKzVTYlBnbFFFVGVhRElnNHFGZWJlbFpER2pva0FHWGQ1R05tSWdO?=
 =?utf-8?B?d3ZDVHlhVHBRT1NjMVBQMFZCYlJvd0ZacmpXT3hoVkx2N2dQU1hlM0tERHA2?=
 =?utf-8?B?ZnY3YUtiQ3N5dVNwcUNtVEpPa2U3QlI2czNqUmozbkFPOFBOYlFwTlJiSmpo?=
 =?utf-8?B?ckEzS0pUakJSUU5Gc0k4ZFIvS2ZMUTBtTzY5RjVQSU4xc2RHUkZWMkQxK28w?=
 =?utf-8?B?eE5OVWFHNnpuaURXT1JxVDFtWWRiS3hwTms2MTY2bHVTM2ZRTWMyUW5ubVlz?=
 =?utf-8?B?REZ4Qi9jT3BUVWFkc25ZVFZCdVYyVjRhL3BIOUlsN1gvUE1qV0wzWnRFVW1n?=
 =?utf-8?B?a1I5Qm5nQkNRdzNGRXFiWnRMMExrMnBNbUVVaFpDL2NCKzlKQTAxNmY4Wld5?=
 =?utf-8?B?QVFJRHI0SG84UnhKckdwMW5uMVRRVHVDRkJUaXRlenplbFUybnZVTlBaZ1dk?=
 =?utf-8?B?THdjV08zcnRCT0o0YTdFNmkrN1I4cWlMc25qaGRFSjBJSXpnV01GMHMvbzRz?=
 =?utf-8?B?L3VzRjlHRmRpYzlQYld1WTd6QklwY2NKMXNJallSSjJLQi9iRHU5WEw2WHds?=
 =?utf-8?B?S1B4RWttOU0vVjVEUjdUa3VPUmVtdUsrU1NHd2FQaksrMUZYazRZMU9ldkpl?=
 =?utf-8?B?Ym4vYTZoQzhsWEJLU0NIeUg1dXc2MmxyaU5JOTVKNmRpd2NuSklDUEpqYmYx?=
 =?utf-8?B?T3JTa2ZzWDBIbWN3R3RYeEp5VC9tOHJrYWJMQmw2eUxYRzdaK3QyNXc4aGpw?=
 =?utf-8?B?c045VjN2cndZbGltTGtBeHQycks5WDZyeW9WV0QrZk9qRjEwYkdqVEVzMm9D?=
 =?utf-8?B?aE91SUpGb0E4b1VOajVGSG1uM1BmNmRCdUZOK3owNkpBd3BwcjJyUGFZSkJ1?=
 =?utf-8?B?OGVvQU04elg1TlppQnAxbEtwVnFCM2NBZzdhMzhFTWlJVkZENlc1UVJNODRs?=
 =?utf-8?B?dERWcFpnRmszamJGMVEzQUF3ZFIyOVc0cUR1TEJyV3ArRkVFZnVGaHR4RUc3?=
 =?utf-8?B?WGZqMzQ3SitUUlFtNW5lNmZnbENXa09xOVk4Qjc1ZnB4TjEyOXF6SGloai95?=
 =?utf-8?B?Nmx2eGQ3S3IwTU9sK2lCSWZIT0w1cHhKOUsrNDY4UG1PSDloWm9GRGNvMFhW?=
 =?utf-8?B?VFpUamllSWNXNFNwa1NqczhZV1B4b2k5Y3h3SzJmTkF0VjVuK0FXc24veWlS?=
 =?utf-8?B?ay9sbzlsYllkdUI4YnNlUDJINDVxT0JLeFJ4NG5ZN3hva1dGMWR6OWUwTmRr?=
 =?utf-8?B?ckpvcnZtSnRIQXpLM0FjRlVKblFDYVllSlI0bUF3V1gyM3FuK1kwQUhoZlJJ?=
 =?utf-8?B?YWUyVXVURWZtZnpTVTNpZFQ3QTRTTHhNYWNzbDE1VzZmZnZERklaRy80cHhB?=
 =?utf-8?B?ak9ERmF5L3BoS1lSODlZVjlON3lEcC9IQWZPRnNqZkdTSSttNjJ5bUh1RUF0?=
 =?utf-8?B?SVYva0t4aGNIa0Z6VmtVdWtjWFBWQXZDK2RKMWJBRTlyWnBUdHNFRWFiV3Zs?=
 =?utf-8?B?Y09saFZUS2FRMHVDRWtQcVZ3cy9nRDZFb05xaCtJTU5qQ0RkNFNpMlFNbEZk?=
 =?utf-8?B?aFU0R3NtWE9BRGw0QkwrWGxvQS92UmJmdlIrR0xDVE95OXBiYzdMOHBTZHll?=
 =?utf-8?B?RGdnd3JEM2ZwR1pYb2owTUlwRGFOSEUwSi9VVUhpK2VmaTlxaU9PK1dSZ3g5?=
 =?utf-8?B?Y2U5SVh6VytwTldzTFI0K1g1dWE3bEtwVVkxNGVLRE1oWTlONXBIU3dRUDJZ?=
 =?utf-8?B?NXhkbEdIbEh5N1Q3UWJDOUR3blRuMUMzVExQNjZVVHVCSnhiZXFjN2NFeFRr?=
 =?utf-8?B?TUhveHNUM01sR245RlFMQ3hQNlp2cW1FQzhaaWNiN2lacEwyTkVyOVFRcm1K?=
 =?utf-8?B?bFhMZ2VLd1hNS2NhOUwyWFlqM0RmWll5L2dXQ3E2R3o1L0hXdEMxR0ZGWmtU?=
 =?utf-8?B?VFFmTTBlSGhtSlVRZUQ5d1FHaHVmcW5oZGxvRU1jNzRNZ0tvZ2xlMENvS1Jy?=
 =?utf-8?B?a29jRmgrS1pSM0ZCNW1lalAwUU9nbDhRdlhqeDI1YkZZaFBpeXNTeFRjdkds?=
 =?utf-8?B?YkIvVkV3MERzVTZhQy9NcmxiU1NwcEw2Nzh3MkVwOTVCZHVGVmR0blZEcFAx?=
 =?utf-8?B?ZnpSOThTdTVycmk4VGRiMmdVaks3WW9qWGQ5WnVWRDdOVkNGRGM0aTIvOFEz?=
 =?utf-8?B?VXMyT1FBVlNOVXJwcW8xb3JlSGpLS1diY2NvdE5uMDd2cDJ5WnB2VWNJeTZ5?=
 =?utf-8?B?RlNodW1aeXVCUzQvWStJM0lwb0lsQ1dYanI3dHM0czRXa0ZVd3hHK052ZzQ2?=
 =?utf-8?Q?k7qPkiEA1nXBpfSg=3D?=
X-Exchange-RoutingPolicyChecked: M5ZjYTeJ9PCwX5TI5l4nY2t687QGzbAcROEs2wSSsDKyamM4iGa7heCf4qMKmc8+l+Ky5XNLFcSyrKHjrzKdfaCJL/pGLkTDlEWDrRwx0H1fID6G34WPaCPYuDVcuaDtH5JSfx7SiSb6YyIWEoqT+/oYq091fYVI/Q1xFIyCkeH5LQiPXFUsMwWFiCmhkXXTzJ/IFIfZDI/27ehvpYdvhtn3gTbr0cZ4NlxfD52d1L0Xz1owu5XohAp949pzv7Uw899WiLmbeLbwuuVXRy/XoJlZ5Pt5yE4hcPRH/eqn1icVs5r/GhpfESQavdDFjIR8OI1KNnaEzmSkxl1Rmgz0PA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f635e93b-a5a6-4134-8e54-08df18c36351
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 16:05:57.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKIAlFLPByD2Va1N8SyfTfLxVNi3oPxl+sx8ptL9oiTlWVcEEZFP1Vh0Q/JvpAAbIvRg5UabQLT6TYBlw56onbsCiEAg1DfoXmr5VzykYFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9623
X-OriginatorOrg: intel.com

On Fri, Sep 04, 2026 at 12:10:37PM +0800, Jason Xing wrote:
> On Fri, Sep 4, 2026 at 11:53 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Fri, Sep 4, 2026 at 7:34 AM <netdev-bot+sashiko@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential
> > > issue(s) to consider:
> > >
> > > Critical: 0 · High: 0 · Medium: 1 · Low: 0
> > >
> > > - [Medium] net/xdp/xsk.c: the new skb_reset_network_header(skb) in
> > >   xsk_skb_init_misc() (net/xdp/xsk.c:950) anchors the *network* header…
> > >
> > > --
> > >
> > > xsk: set network header on skb at generic transmit
> > >
> > > The XSK generic transmit path never reset the network header, so after
> > > skb_reserve(hr) the stored offset was left behind skb->data and
> > > skb_network_offset() returned -hr, which tripped the
> > > DEBUG_NET_WARN_ON_ONCE(len > INT_MAX) in pskb_may_pull_reason() when the
> > > skb reached a tunnel device. This adds skb_reset_network_header() in
> > > xsk_skb_init_misc() so the offset is 0.
> > >
> > > Closes: https://syzkaller.appspot.com/bug?extid=f16c1b285c9f63994eec
> > > Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@gmail.com/
> > >
> > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > index 33475b180ea6f..2077bb6299ca9 100644
> > > > --- a/net/xdp/xsk.c
> > > > +++ b/net/xdp/xsk.c
> > > > @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, struct xdp_sock *xs,
> > > >  {
> > > >       int err;
> > > >
> > > > +     skb_reset_network_header(skb);
> > > > +
> > >
> > > [Severity: Medium]
> > > The negative offset does look closed by this: xsk_skb_init_misc() runs
> > > after skb_reserve(hr) in xsk_build_skb() and xsk_build_skb_zerocopy(), so
> > > skb_network_offset() becomes 0. Two parts of the reasoning look off
> > > though.
> > >
> > > First, the commit message says:
> > >
> > >   "Note this anchors it at the start of the frame (L2 for an ethernet
> > >    device), which is the same convention AF_PACKET uses on TX."
> > >
> > > Is that what AF_PACKET does? packet_parse_headers() anchors the MAC
> > > header, not the network header:
> > >
> > > net/packet/af_packet.c:packet_parse_headers() {
> > >         /* On TX skb->data is the L2 header; anchor it for all socket types. */
> > >         skb_reset_mac_header(skb);
> > >
> > >         if ((!skb->protocol || skb->protocol == htons(ETH_P_ALL)) &&
> > >             sock->type == SOCK_RAW)
> > >                 skb->protocol = dev_parse_header_protocol(skb);
> > >         ...
> > > }
> >
> > I'm going to remove this part.
> >
> > >
> > > and packet_snd() for SOCK_RAW resets network_header before moving
> > > skb->data back over the hard header, so network_header stays at the L3
> > > boundary:
> > >
> > >         skb_reset_network_header(skb);
> > >         ...
> > >         } else if (reserve) {
> > >                 skb_reserve(skb, -reserve);
> > >
> > > So after this patch an AF_XDP skb differs from an AF_PACKET one by
> > > hard_header_len in network_header, and mac_header is still at the unset
> > > sentinel left by __finalize_skb_around(), i.e. skb_mac_header_was_set()
> > > is false.
> > >
> > > Second, the commit message says AF_PACKET "supports GSO/checksum
> > > offload; none of that applies here". Does checksum offload really not
> > > apply? xsk_skb_metadata() in the same file does:
> > >
> > > net/xdp/xsk.c:xsk_skb_metadata() {
> > >                 skb->csum_start = hr + csum_start;
> > >                 skb->csum_offset = csum_offset;
> > >                 skb->ip_summed = CHECKSUM_PARTIAL;
> > >
> > >                 if (unlikely(pool->tx_sw_csum)) {
> > >                         ...
> > >                         err = skb_checksum_help(skb);
> > >         ...
> > > }
> > >
> > > The software fallback only happens when the user opted in via
> > > XDP_UMEM_TX_SW_CSUM, so a CHECKSUM_PARTIAL AF_XDP skb does reach the
> > > driver through __dev_direct_xmit(), and drivers take the L2/L3 split
> > > from network_header:
> > >
> > > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_tx_csum() {
> > >         vlan_macip_lens = skb_checksum_start_offset(skb) -
> > >                           skb_network_offset(skb);
> > > no_csum:
> > >         /* vlan_macip_lens: MACLEN, VLAN tag */
> > >         vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
> > >         ...
> > > }
> >
> > After digging into the probing logic, I strongly feel that Jakub is
> > right to consider whether to add the probing logic.
> >
> > >
> > > With skb_network_offset() now 0 on an ethernet frame, does this program
> > > MACLEN == 0 and an IPLEN that swallows the ethernet header, so the NIC
> > > inserts a checksum derived from the wrong header layout?
> > >
> > > Would it make sense to also call skb_reset_mac_header() and place
> > > network_header at the real L3 boundary here? Alternatively, if the
> > > minimal reset is the intent, could the commit message describe
> >
> > The minimal reset doesn't help with the checksum problem mentioned above.
> >
> > Adding simple logic like resetting l2/l3 headers doesn't guarantee
> > that csum problem won't be triggered. Adding complete probing hurts
> > perfomance for sure.
> >
> > Maybe we can cook two patches:
> > 1. Fix the current bug syzbot reported as is.
> > 2. Fix offload logic by adding complete probing
> >
> > @Jakub, Maciej, Stan
> > Do we need a complex logic like af_packet to handle this?
> 
> Until now, it seems we've got three fixes in the queue:
> 1. reset mac header:
> https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/
> (commit 35fcde7f8deb "xsk: support for Tx")

Hi!

I'd keep this separate and focus on Eric's hint to fix the drivers so they
use skb_eth_hdr() consistently

> 2. reset network header like this patch. (commit 3914d88f7608 "xsk:
> Respect device's headroom and tailroom")

For packets without CHECKSUM_PARTIAL, resetting network_header should be
enough to fix the negative offset reported by syzbot.

For CHECKSUM_PARTIAL, however, I think we need to establish proper skb
header metadata. Existing drivers do rely on it. For example, i40e and ice
use both skb_network_header() and skb_transport_header() in their non-GSO
checksum offload paths, while ixgbe derives its offsets from
skb_network_offset() and skb_checksum_start_offset().

For Ethernet I would avoid depending on mac_header here. The frame can
also be non-linear with IFF_TX_SKB_NO_LINEAR, so using
skb_header_pointer() to inspect the Ethernet header and the fragment-safe
VLAN helpers looks more appropriate than dev_parse_header_protocol().

> 3. handle csum offload issue by adding probing code. (commit
> 48eb03dd2630 "xsk: Add TX ... checksum offload support")
> 
> Thanks,
> Jason
> 
> >
> > Thanks,
> > Jason
> >
> > > network_header as a placeholder and drop the claims about the AF_PACKET
> > > convention and the absence of checksum offload?
> > >
> > > --
> > > Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901083325.3445-1-kerneljasonxing%40gmail.com
