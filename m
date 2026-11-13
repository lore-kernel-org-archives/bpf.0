Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587125;
	b=vBVXUldAxGUuk/h+Va1HhUTo9EKLAQ24UL5oJZ8WEYRQ5pUS4TKLv5Ydq7fGk5WDAofH
	 WGIn/AV7bAO6UKBAMh1GaaXz7EYz6zYPvE7dlpsuhZircWVpJPbHvRb1upMK2AJNYdJuK
	 6jdYcS8lqm2XLinx2XhyGVSyNFlCnWobszzMFt9f8FEwAAQ4aDsjJo0tYag3Mp2sCQEgJ
	 uK+rlT/ny6EO1V6s/XLAcFPFUH5N3Z6nasoqqbstaZ8QbpYRnJyMFkPai/pOHxhB1+iF2
	 sjz4I6YURppI0vctLIxSYe7svCw2TELycud4+LdkQPoI3EPj0zFzt1c42dxL1eXHFXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587125;
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
	bh=k6lMaVH3XXaIgCJo+YeBMFiXd6GKBN56hXOO6X+mM2w=;
	b=zIs/Lu7+tNe3FET4stE/FrYPmiw62RkrEBga3bBMR++o5FMY1N1Ymd9GHJdOXLPwdFDy
	 DyQnjnNR8ccLLuWtlp8ZbV+pLnPVgtz49cbAJCqC9wF+osaz/3Dm1CP9qhbjk/3qWhn0V
	 oEkUnTFPtlUK3+ywAMROeFTFgupRRdj7b55/DlM5WqWZir35/PBIIbUuP/pWLTA9jREEZ
	 //nxPZBrDuc1Nm1MoIiRdUYzq3Dsx/L0hpBNCp+1A2qUmNZaZfYy6Yx2fVKCDojcLS7Qc
	 Ac1bmMg79zRgX2agiabkjfHh8saYkWw2hOVlL/QU1MpgoFAIRYIZOcNoeSn5b4Gllog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QgcsQqNq;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FSRmaZjo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4268606A32E;
	Fri, 13 Nov 2026 16:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4268606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QgcsQqNq;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=FSRmaZjo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794587125; x=1826123125;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ams/f6UdHdsWc5EhO9wIdC1wRxUUBYVfXX5CkbFLvO0=;
  b=QgcsQqNqXofCGYRBNOYL+c7o9Sbm1VwpUa1pgXqdvPp5mAt9v/G9oCGQ
   VVPywgcw7d4L0eztnqbfpHdrVAW46Mk6Hn+K0mHoX2bpAuFCReKoYzDQ8
   EuuiU8OTxbi6m4+SBWmPLUsTN0JAYoRA6I7R+5gvj5XCtJdefv7Ka5GgE
   6FWx8rjrdD55ZOYfJK4X/vwsRia8CcPR8Z1HXREPTPN+oKK6BYOQ5ETRi
   4k4JXw+EoVwqIgqmTuqfyMX9Xq02wVIj6cG8D1wf2LRc9yRj8KUcBFQcD
   6Jw0b4EfR9orwtqtuAYL9nkwtKaIAT2HTboor2VZTjv9UvUovW2jW89OK
   Q==;
X-CSE-ConnectionGUID: lJxwrvgfTU2nazalJEazoQ==
X-CSE-MsgGUID: QR0X9QGITKGlli5dGObrFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3299140"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3299140"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:25:20 -0800
X-CSE-ConnectionGUID: qZl5tVaWR0SvGHfGw0nG7w==
X-CSE-MsgGUID: DebKy9aZT4eFP/BuW9CC+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8803608"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:25:17 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:25:16 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:25:16 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.60)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:25:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjLtUBdw/4mUVysQick3uROZNdFYLOfe8KzVvYHbqCtlouPgRXhBtd6GvAAp4FO5a9hcBPhvVnSCzB8s7vNC4ALBELjVC98MGWNTHVVS1uWABRZGPzm9clI/tIFI3b8WGhPcg37ZJeCJwbJbQg4CxUE9eQ6ua+eO5pJ1wQDmGzzBTBPZSJa6gbXEY0D4rNCJ255XOOvST8GIfnoL4ClUabx8JtOrFXyquQr0JFZxXveEY+pEJVykDIZSe/e33yYgtH4RkNgv8phyI5WT0yw+hqZHNIHFn9V7KifBhXMK6MS4CVem3ST0UEG/4fxRnux9mA1TYgO1J0lAz7Ky7jOvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6lMaVH3XXaIgCJo+YeBMFiXd6GKBN56hXOO6X+mM2w=;
 b=uZUSwGWE8rQ7aHOCrwdv8aE5A5Xbm5TH3a9Ac0mpAYuMSHxqi1hyjHg1s0sa0mTcJycZi+f8jJeE3gGA3aE2bI9fSzfGE56E3quR2EY2F6TrhE2utFiOeVyOZkB7PPIlzGttZRvFmYLRAByB33FF/R+3GZyaMfnk+iXWk94o2UyEIarzHiKaDnRdMoNjFvYNgbprOsMa/AENeLaCaz6CrcHYyK/OmZZfGVgpfxSOYWiIV/BP+MK7Hw50szPNI9xDzl7Qtxf8MItnUNWgULqesfB0GNW2yvoSmyMXILq2b64RtXmMUpw6g4jOuZrpWdh4/SRW4i2qvDgkJg72RwT6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6lMaVH3XXaIgCJo+YeBMFiXd6GKBN56hXOO6X+mM2w=;
 b=FSRmaZjoFq8CrZB++kaTm7XeZRzQcpmqfjahykAHhLMM6e6kmHIKC0dsm1xqqrQo24zuJg/SN0hrhZVEQj/0bAr3t2i/NiIZwfL6kN/yyekXsLKCpbC83XFTylBi1irMZ+D9y/VGCfnQzM+lc8f0bovtiGh/VgHtxVraapPvL7Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH8PR11MB6705.namprd11.prod.outlook.com
 (2603:10b6:510:1c4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 16:24:08 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 16:24:08 +0000
Date: Fri, 13 Nov 2026 17:23:57 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <pabeni@redhat.com>,
	<tushar.vyavahare@intel.com>, <kerneljasonxing@gmail.com>,
	<bjorn@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 0/4] selftests: move the AF_XDP test suite
 from bpf to net
Message-ID: <avc5nTfMkRTqWXZs@boxer>
References: <20261109193048.1006986-1-maciej.fijalkowski@intel.com>
 <20261111155748.11b92b7b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111155748.11b92b7b@kernel.org>
X-ClientProxiedBy: DUZP191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::7) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH8PR11MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 0433e64b-7ff2-4ad1-c95e-08df41a28aec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|6133799003|4143699003|261022105027099003|11063799006|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261102123227099003|56012099006|261009223027099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info: d2vkgYQmps46WMjG1JE6DYMmNefGHFLNfMKkfiQFp4xUK8JQ/7GstKUqAOTDFE7txzsFzGOVB/MBkcXvjshK2bidJutkQ0FhzvByVr3kkJSmXfdEin13AN0AQORNPg6zsBigVr0u8ohdG7OtwZmKj8tCMJNTZnOhvAMV1ZheHxwiiJloEwVlROeLtvm8KkvgF4iESXuI8s9JxnODCznLW/LOwmS6v6NWOpNHT5GWFm+FUNmN5Ro9ZY7Bpb+1h4esUFAcE9QDUx8NcnkzVp5DJfko1oliohU+oMCbdohYVUjEUQ/d1uLcBeD0+fn1tu7CfM+NeI9PAAkMQsIOEHTC1CMRM6y9VqpqTJKBXdmfTDqgTiehf8hXFGFypDlKbVHVHznSHoxYCBp/tHUplypOtPR/qxNgZ6QSYR4YjoXt3r3Gi61zZrixgmuIIyYJ1clKHbetjznUpl6Vxfy4EXj0PkInuiNuogfGqjrMlbpARp6GIpQ+AwnII2VerGUmxkGpjcRURxnJlxH77de51JxCAjxpod+NXgY5QVK254CVuwOXO4RA4la77WjRG8ATichA9g2GuDIaPi2vIDuY8i1Zk3f5AFaKuJKl8sDoTe6BdoYzBtERyUUdbr/4JHfLuydX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(261022105027099003)(11063799006)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261102123227099003)(56012099006)(261009223027099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4Ap4JJzqFnz8NHVXgpLPoKSmtPgUK9TN6Tk4HUeNzoV72T7y+hsZFjWfGC5?=
 =?us-ascii?Q?r2Z+w3LnyLrpGdQu8zeXrtHual3Vk0tkezf8QLFBVftXfaa4XhWwMlZjkcxT?=
 =?us-ascii?Q?yracuRvvMyESDgz5soRmDuL+1iwd51+a1LU8skguq8fih4J6z+RaHmxOQ5qT?=
 =?us-ascii?Q?OtWQx/17akbwskceT635bt7+QpaWBnM19jqhaM4V+9oxpeZJPU4AcgMr1Syb?=
 =?us-ascii?Q?2uWF+Cfi+UIFqlLlz1JFRDR+vXwnglk6JxCrnl+BHLjMMBDCFvFlG8ZE1vzQ?=
 =?us-ascii?Q?Qvs6KnApMTTRqw1lwX80w/c9UU/fXWYpN7EaiwwIiAsKTNSe2o79en6B5dB3?=
 =?us-ascii?Q?7EFfUTWl4YsGSl35sOJDoQHGz+ks3iof0TLj6Mk3zX/QQ46MrH63RqAwgM/D?=
 =?us-ascii?Q?2n+NCaWx7xIEdGIfW2nqIfmaXhe+mFp1dvBK4JhLlu3bJtFpNzpT2M9gZSFY?=
 =?us-ascii?Q?GFHLH1vOKvZtP6rZeGEsH55Xxt8AChawXtqVxcakvwchISl2fopD87e5lh5L?=
 =?us-ascii?Q?h8mMSKS8JrczPhKARGL/mPQeryixfRRhhPeYkabaT2B4mgHbgBFzwSfbUxwe?=
 =?us-ascii?Q?EnnaXfrXPYEC/O8TwzfOR+h8dJjTRBUg7QFZpveb+m0K0o6VbU9Lad6Iz57y?=
 =?us-ascii?Q?lOfv46L2jlqKIyXu4pezstPWmlRJehm90sFIkvcWn/fsO0hlOtEPcJF3D+3b?=
 =?us-ascii?Q?wiVGyIZRHYuv3GTMtWIfjCYqEvExIrqkD03GomTUVozhRVHLSH9WT9OOHQpd?=
 =?us-ascii?Q?40JJia8wEkA+Qs1uD5TagBBQBAbM1i/JhxvKxtHBGCHpWwz+Q/BUwQO897L3?=
 =?us-ascii?Q?R/Q8ADCW4s/F6V5CPQ3N8oAnmGqPVX5ueL6s2RWKuISJl6+QGNB0gJU8Lcup?=
 =?us-ascii?Q?8b453iUF7IrBW/OvErqxtI9ovrt/6o2Zm0Qc/CfijyqjIiKIzPWExm+HBFTo?=
 =?us-ascii?Q?tUmm9vrTC2V/Uz1xNA9phGeKPGvmngq7t1cKz0Ln7ESXAj9nZNOkBKyltbDa?=
 =?us-ascii?Q?2zRgxvRFSbp1w+PlGypk9FwyIOd5K7ZyIO3WQdeu142VwMrxIQChBm7v81QA?=
 =?us-ascii?Q?AkGgTURyvFQdQC1GLMDUu3sKsCbaSs00z+m15MLy6YfbpPVuV6hDQBVUiLYE?=
 =?us-ascii?Q?UppIKrzUWXU/xSxohyBg/27QBa9EsIScXJaWe+2me4dINkE5D0JJUbLOemHz?=
 =?us-ascii?Q?+2M2u78Vrdf3FwR+qFFgZWXYOwgMftG+gxfjW/2YEPSZYAFWtOQd0jja+OR8?=
 =?us-ascii?Q?saVh4ga7uM3Ky+FPqiST6pV7b+rJhKtcTF1dF+gXjmCO2NLe271wHmefBOAK?=
 =?us-ascii?Q?Wv09lMRi0eJDXfJ7HLWQSOluZp7GNiL6r3YhNmbx1H3LoQgdLoE+1CX5DxOs?=
 =?us-ascii?Q?epTV+rKWUJ4++3os0eORUoPzbDpGbiuYKY6c9AfGTvOAP9SLHmqX8/e4oZ9I?=
 =?us-ascii?Q?BOwXFyclurCIvwsFN6O1Dw6AfE2MTbnEk8GPlWdEOGE2ADSfzClGJNnYPnk9?=
 =?us-ascii?Q?qoCC9Yi0g6wOm5CaOsUVLQC2xH1DEsQwiYvPm3y4EI6pgULccCvUyTZx/Tco?=
 =?us-ascii?Q?GUbJ6tA3zWm39UT4enZmHF+FOZgMoRL7CFHshzSOsegtisrWxyBIQ1J7FZyE?=
 =?us-ascii?Q?DiCM1UvM/bFBE8Q5UXMu3zYqQ91mov5eqJbO4p4GLxBzJHq61DkSOUHmAQaW?=
 =?us-ascii?Q?wrIMENux9hN3FCMCeSUW/HbTCOTmKo3AwipmBnOjKVo91jgLbjLEGCM1HHIS?=
 =?us-ascii?Q?VJ0cJw54dl6Xgu7sGvT4kJLwLcIa6gM=3D?=
X-Exchange-RoutingPolicyChecked: Gutr9FWz3nbicL0e/jeArgdBBIb/uRpYgBmZsXkGrSKvd5O39DHubNY/qDfuwHS2G016HvCHgi0yt4TjNrHNtgJ3hWTvKD0hOkyIXI13Kz3AtYL6jGaEeytkgpVFsAG4wNsMdJbW3A1FqW1TVB4QbdV2A7mmxcXFSMqwphlyEOnARPDVeCVq0iZRdHXpVyMAeoXGNIbTTwWCL2DYZIMB1v4ou4vbfwUj2llBJPYE9fbinpxRZHGU873snZjK6VeO7RnPeiOpshz5E2lv7HK1zUmKo9dwDVExddFivOi9k7V9NAf1lfgwkZhjx5fYfHVpAOTH9WZp0SMAMzE4YX9fDA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0433e64b-7ff2-4ad1-c95e-08df41a28aec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:24:08.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7FoDUiAw/hOhoL2XupUlmms4CDZonvdx6KOxJXpSsSH2XWpv0Rv0kezwYGoB1/qghQCrt7umVMEoW77lR63dKEFeZgFOQO/Z5x0gSvaMwoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6705
X-OriginatorOrg: intel.com

On Wed, Nov 11, 2026 at 03:57:48PM -0800, Jakub Kicinski wrote:
> On Mon,  9 Nov 2026 20:30:44 +0100 Maciej Fijalkowski wrote:
> > As the maintainers asked, this series is the first step of moving the
> > AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> > builds from its new location, without changing what the tests do. The
> > rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> > net" (v4) will follow on top of this move.
> 
> Close enough, but why did you skip CCing bpf@ :(

I used some previous xsk to/cc setup and given that we transferred to
netdev, I missed good old bpf ;(

Do you want me to re-spin with Alexei's ack or will you take it as is?

> 
> BPF folks, I made a tag for both of us to merge / pull to avoid
> Makefile conflicts in selftests, the original series is here:
> https://lore.kernel.org/all/20261109193048.1006986-1-maciej.fijalkowski@intel.com/
> PR text follows. Please LMK if / how you'd like to proceed.
> 
> The following changes since commit 7475ea8b58616b33c04afb976cf0fbaad9dd63fb:
> 
>   Linux 7.4-rc2 (2026-11-08 16:22:20 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git tags/bpf-net-xsk-move
> 
> for you to fetch changes up to d01fb5c8113055e3d1b7f573261ae6a30abf4e53:
> 
>   selftests: net: move xdp_hw_metadata from selftests/bpf (2026-11-11 15:50:02 -0800)
> 
> ----------------------------------------------------------------
> Maciej says:
> 
> As the maintainers asked, this series is the first step of moving the
> AF_XDP selftests from selftests/bpf to selftests/net: the code moves and
> builds from its new location, without changing what the tests do. The
> rework [0] posted as "selftests: net: migrate AF_XDP test suite over to
> net" (v4) will follow on top of this move.
> 
> Patch 1 drops the test_progs wrapper of the AF_XDP tests, patch 2 adds a
> generic BPF skeleton rule to net/bpf.mk, patch 3 moves xskxceiver, its
> library and test_xsk.sh to selftests/net, and patch 4 (new, not covered
> at [0]) moves xdp_hw_metadata, which is built from the same library.
> 
> The xdp_metadata test stays in test_progs: it covers BPF core
> behaviour, and moving it would mean rewriting it for the kselftest
> harness. It keeps using xsk.c from net/lib/xsk.
> 
> xskxceiver and xdp_hw_metadata are the first users of bpftool at build
> time in selftests/net. NIPA has bpftool, but 0-day and KernelCI build
> net without it, so both tools are skipped with a warning when bpftool
> is missing or does not run.
> 
> test_xsk.sh is installed but not run by run_tests, so NIPA does not pick
> it up: it runs every case, including flaky ones, and some cases leak
> page_pool pages after skb_pp_cow_data() in generic XDP mode on
> veth-based runs. Until a later step makes the suite fit for NIPA, no CI
> runs the AF_XDP tests. test_xsk.sh is being removed by [0] but it is
> kept here as there is no other feasible way to run the test suite (if
> needed) until we come up with an upstreamable Python runner.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> ----------------------------------------------------------------
> Maciej Fijalkowski (4):
>       selftests/bpf: drop the test_progs AF_XDP wrapper
>       selftests: net: add a generic rule for BPF skeletons
>       selftests: xsk: move the AF_XDP test suite to selftests/net
>       selftests: net: move xdp_hw_metadata from selftests/bpf
> 
>  Documentation/networking/af_xdp.rst                |   6 +-
>  Documentation/networking/xsk-tx-metadata.rst       |   2 +-
>  MAINTAINERS                                        |   4 +-
>  tools/testing/selftests/bpf/.gitignore             |   2 -
>  tools/testing/selftests/bpf/Makefile               |  29 +---
>  tools/testing/selftests/bpf/Makefile.buildvars     |   6 +-
>  tools/testing/selftests/bpf/network_helpers.c      |  48 ------
>  tools/testing/selftests/bpf/network_helpers.h      |   2 -
>  tools/testing/selftests/bpf/prog_tests/xsk.c       | 170 ---------------------
>  tools/testing/selftests/net/.gitignore             |   2 +
>  tools/testing/selftests/net/Makefile               |  22 +++
>  tools/testing/selftests/net/bpf.mk                 |  13 +-
>  tools/testing/selftests/net/config                 |   1 +
>  tools/testing/selftests/net/lib/.gitignore         |   2 +
>  tools/testing/selftests/net/lib/Makefile           |  25 +++
>  .../{bpf/prog_tests => net/lib/xsk}/test_xsk.c     |   2 +-
>  .../{bpf/prog_tests => net/lib/xsk}/test_xsk.h     |   5 +-
>  tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c |  49 +++++-
>  tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h |   4 +
>  .../{bpf => net/lib/xsk}/xsk_xdp_common.h          |   0
>  .../lib/xsk/xsk_xdp_progs.bpf.c}                   |   2 +-
>  .../selftests/{bpf => net/lib/xsk}/xskxceiver.c    |  17 +--
>  .../selftests/{bpf => net/lib/xsk}/xskxceiver.h    |   0
>  tools/testing/selftests/{bpf => net}/test_xsk.sh   |   5 +
>  .../xdp_hw_metadata.bpf.c}                         |  35 +++--
>  .../selftests/{bpf => net}/xdp_hw_metadata.c       |  81 +++++++++-
>  tools/testing/selftests/net/xdp_metadata.h         |  67 ++++++++
>  .../testing/selftests/{bpf => net}/xsk_prereqs.sh  |   2 +-
>  28 files changed, 309 insertions(+), 294 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/prog_tests/xsk.c
>  rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.c (99%)
>  rename tools/testing/selftests/{bpf/prog_tests => net/lib/xsk}/test_xsk.h (99%)
>  rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.c (95%)
>  rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk.h (97%)
>  rename tools/testing/selftests/{bpf => net/lib/xsk}/xsk_xdp_common.h (100%)
>  rename tools/testing/selftests/{bpf/progs/xsk_xdp_progs.c => net/lib/xsk/xsk_xdp_progs.bpf.c} (98%)
>  rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.c (96%)
>  rename tools/testing/selftests/{bpf => net/lib/xsk}/xskxceiver.h (100%)
>  rename tools/testing/selftests/{bpf => net}/test_xsk.sh (98%)
>  rename tools/testing/selftests/{bpf/progs/xdp_hw_metadata.c => net/xdp_hw_metadata.bpf.c} (75%)
>  rename tools/testing/selftests/{bpf => net}/xdp_hw_metadata.c (92%)
>  create mode 100644 tools/testing/selftests/net/xdp_metadata.h
>  rename tools/testing/selftests/{bpf => net}/xsk_prereqs.sh (98%)
