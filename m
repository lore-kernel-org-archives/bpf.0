Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A7E3B05BD;
	Fri, 25 Sep 2026 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355744; cv=fail; b=GIUNs3URLKsAJMgDlEHgHGw4tiRSLZiZfMl8rIimagHAndt5AomQn6EI1JtGituz6IRpdX7Mip9FypoXzCA5ArkbvnVHFu9b0Vol1Cq87Fscp5qkCAym5zG6QtcnPMjBp0I1kWAs2Ah70z2Fc2xKvlBzadU5PhUAnWnSKzKODLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355744; c=relaxed/simple;
	bh=AnamDZ82V55cplG65p9SoA8UcrBn9gWUaBZbDnlRWdY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N1IcXkc+I3TGGh7BSfn3+XsBxp1t9NQpqy1LDbVABjJWPArbILtm8/8B1nhFM4yCFCR4tRKwj1MJf09Wobu6Ju+AMWJyybwwpGSrdg37mUgk7vHGjhARtuSwN4OF2riL8+kElyU27sLBarTji5CEAEmt+jBEIKBoQKEOTgpy7BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ajhssZC7; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ajhssZC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790355739; x=1821891739;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=AnamDZ82V55cplG65p9SoA8UcrBn9gWUaBZbDnlRWdY=;
  b=ajhssZC7xdRP+qM9HCv1+gOkZIbknxncmLLzUsi8cf32QMUc4pqvXR/+
   SW/k9yvr6jbfaiqfmm0AUOg7d82TT0FbPyZO9bi5BUsyEzMIHXI/xMhl9
   ky5iGFQtxqWUw7XXe6lpHHMetNtwoRIur6GSmSBPnOPMSuKyvw+TrQjfY
   Y8wDJkIBCi7hoLLwCkvLfXCo6wbNO2D7M4CqN6YOnVKYxUs2/iRSJFlsH
   mof45Q+DWP1wbyO4JN9/FmpG3iornwkmQKz1o/n4lU6dbuH+AvwhW1mTB
   seYyDI5UcE/iFDubzYDqeyGiu7ORGXxO2+i5W9nUgVo3QU+uPmmNOoiSy
   g==;
X-CSE-ConnectionGUID: odh1wC+aTKaEBokJzNwnsg==
X-CSE-MsgGUID: v9DYwh8UTyuf+Ack7jj86g==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90271813"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90271813"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 10:02:15 -0700
X-CSE-ConnectionGUID: wCHU0GWWQAGLhi0koMolEg==
X-CSE-MsgGUID: uuRUd8tVRmKSbOWHc8yduA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="277549669"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 10:02:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 10:02:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 10:02:13 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 10:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkBvh569FnGo+JNE0U2vv5QEtC3pt1nL0Ch8r7Lh07bjbNvbGIqOMtg5n6aCoM9QzhL0e8IKo71DkI8miXPcxa4AWOoNDux1tN/zAJEWzDdOr8RQjdySSeqfqwFr1uDgh1uvLW8QqJdiSGit8ol9JAuxRZxh1+P/4HWIpGgOQM7LglxoQKfVRkZtlBR+JrXDmRYdhze8/3DHU77PRJ9YV5I64U05Z7loA01Z+xfX2CMjErkkeXk1HC0itMtnEkvQkixXhNr1e2R/RvgE9BINa5fzilJNhIkterZD7GMg2SqzQgiRRdfoXuz+ieaqwwVZtbTvbpGU6b4urNEz4MwNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=marYjy301r+RWV9niKnBnvp+HpT2VWT7L6kC33uxODo=;
 b=S4yWpG0YokkQApILa4/w7JVvubp9R5uM0G8kWLdkcPF5vryfWHaC2nbi6fPAMzt5Kc5Fsv4BSWLn14vAw2RUjEMB8hsLjgNceUKqxa+pYl7p8nUucc01t8QLoTwQoH1rBvAH5lTtkNZ/HDPz47sTnP4/E3+WZFraHHH9kRXtMbFWDa6jJeTc3AZHe+57Fn3s3my7bMmANAnprNVDCHfgTsyspj225mVwb7zY6ObJEo+isyVu99O30nrurWLCC69gbValG8yw0epfyMdbta/LBG1XgoS7lRENCBFN+a5c2WAwZzpjWPtoNS7zi2oyRbfxxTUGPyAyNSPX74hpKiaOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA3PR11MB992399.namprd11.prod.outlook.com (2603:10b6:806:58b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 25 Sep
 2026 17:02:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 17:02:04 +0000
Date: Fri, 25 Sep 2026 18:59:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <zhaochenguang@kylinos.cn>,
	<magnus.karlsson@intel.com>, <jacob.e.keller@intel.com>,
	<przemyslaw.kitszel@intel.com>, <jbrandeb@kernel.org>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<bpf@vger.kernel.org>, <sunithax.d.mekala@intel.com>
Subject: Re: [PATCH net 4/8] i40e: avoid deadlock when calling
 unregister_netdev()
Message-ID: <araodXNEfD7JSnp5@boxer>
References: <20260918212458.550425-5-anthony.l.nguyen@intel.com>
 <179004067040.2160803.1559812086096525304@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179004067040.2160803.1559812086096525304@kernel.org>
X-ClientProxiedBy: DU7P251CA0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:551::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA3PR11MB992399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebbac77-d253-41b0-a2b8-08df1b26b95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|10067099003|18002099003|11063799006|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: upk2aNfAIwEZojwGef+ewsowulbz/osjv/V9PvdomwNq3utrVtEbWEwyi1rSPYbrPRoWWxZN/oKBtfYj39YEbi0NaEi5bQigDzbFaHoPH5dnRQDSQgs9/ugPojfN1lrDcFmJvF+BJz6J09JReAKBPS+T7sMWDp7Hzy98MqrYs579IGRX+vTLxXf+y9WlRtZKoze9CTz7Nlm7KpISGRxBpPIoz7Cu38Sy5/2PISSqX7sgwsEmeVGKNHY9MwGqPKy1aVxqLYE9ZLMKknQvOsGcuWSI/PYvmbaJVz4pfKph+aF6f2RGD4+Hk28YA6krmcJAYEAAJ1CW3I/+9+8kl4JPCcp4qikLwqbAmX7NB3RXW/tXQB82SU4M5wJb+v/Ym4ivBA/fdSGtxUraYgsOO+dmPua3XLme/PoKpsP1cY0Q5DbVykM90OMjPnwOzsrNdamrP3fgMqVbi8vibiS+ilLmZGcnRtrWCVvJ/e/3B269vN/B6EEkwOjWurHf3DfB5d21ix4DEDYEmoN4QGfRwK+7s69MngWeFMVdsPDMWG98HDdi93u4NrcOJJQkrcMd4MvcF/uQi9p6DZiJokD2MbZl+Q/oY0jLNThCH7LUVftwZpl6SSF6uBDSfO485FxLgT1i
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(10067099003)(18002099003)(11063799006)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T29CLzdURERaeEl6WG15aXRBMXNRSS9uZE9tSHhadFRsMTFFQWJncFp4Y2lo?=
 =?utf-8?B?TGU2dzNSaTlrc3JvVnVveHBKNXZEVVFQc0tUUnUvZC94R2NVQVRuTHFqM2ZX?=
 =?utf-8?B?NUxHTURwbi9XdDM4ZnljMnUrUlNOKzlhaVV5YkVBaUZnanBwNXR0alNzTTcx?=
 =?utf-8?B?dSs1SUNXUytCOFIrcnhoVjA0d2puZGE5NndnWitwQ21RdlI0c0ZkUHVpSVZN?=
 =?utf-8?B?TGxZOTJ0N3U2M0g0cmZnaDlnVzFDNG9RNzdTRCtsWUMvM29UWDRoZTIwL0J2?=
 =?utf-8?B?WUFNSmYwYnRwTTFjWmxtZi9UbzAxcXRBNnM1VWcwelIzbWU2NnU2L3U1QjFk?=
 =?utf-8?B?S1Ewc1FuK1VoOUpFZy8zdERadHVMd3ZFL0xRdWFRaTU1dThNRlc1SUlUSmVa?=
 =?utf-8?B?RmVMQjlOUmZsZkQwS0I0a2ZSZ2tidXQyekk2Z1habTEzWGFHTHUybEVlNVdx?=
 =?utf-8?B?UGM5QTNmKzBRdWNmVE9EeHdrdGhFZWpwMDgybTRvV2RZa082V0JZQm0xcE01?=
 =?utf-8?B?N1hmcUIySDM5TnNWdVEvaE1KUEJueEk1MS9FR2cyeE51R3VpaXBwQXRwek0y?=
 =?utf-8?B?aVNsRkZnRFUrM1hYazBMWU5ONlJMVVdHckhhclFMN2YwUjhQbHRMTFZiMG82?=
 =?utf-8?B?ckpkWlI4eDR3dDRmTWRKS0JkbG91SW9LanAvRFRabnZkckpNS3FqWUhVck5E?=
 =?utf-8?B?alRKOS9TTitaNkhqWUhUUGc1RFVYNjRSS2poVUlEMTJOSTcrMlBGbEwwamx3?=
 =?utf-8?B?ejhCQ2tzMGpkUEZFUmcxR3lBS0NpZnZGdU9VKzZIMDRqQlRxekpySUVZZjM0?=
 =?utf-8?B?TXU1T0Q5dlRCTk5ZQTJ2ZGwrZ0VXdEQ0Mkp3WUxHN3g3M3dXZU10MEw5N0Rr?=
 =?utf-8?B?NEpZVmY4U0VGTWRyN1FPT0pQNmJTUXVOSVlNdlAyQkM0bVNzelVUbW1NNFg3?=
 =?utf-8?B?bmg5b0V2dTd3bzNrVjlpTkFzU1JxbGpTNUpwMFdPT0tRa0g3QVd6Nlh2TmJs?=
 =?utf-8?B?dE9LS0Y4UkY5bEJIc1FXSVI3NnNiN2k0aWp5YWFyR3g2dE1uV09FYWVxbWtz?=
 =?utf-8?B?cmNoaDdYS1NJeTBwT04xeUhvS0hJSmZrM0crajE4Sms4aVlxQmx0MHMwMVh1?=
 =?utf-8?B?TWFjbFU1Rk5YZkVwcmcvZlpqVlk4TXBuWXNzcUZPdEJycHF1NFNTOWs3UnUr?=
 =?utf-8?B?TkYxejVFWTVwck9abzFJSWtnM0hhL1dZWExpTjlBV25KekowZkJOdzJsUnNm?=
 =?utf-8?B?RnljY0s5amQxU2xWWHgvOXp4WkVNZ1Q3bEV0TjcvZHpLODJDOVZEMXVzU2R1?=
 =?utf-8?B?T05VWlp0VXJYaktBVDhORVplU1ZKNml5NjVZTVB2Y1Y2YksrS1AwZW5tWXNI?=
 =?utf-8?B?ODJ0ZjBwZ0Q3Q002K2J4OEZBRm5KRldXMWo5ZjhOSkVhSDc3bmdGaFpYRW90?=
 =?utf-8?B?OGw3UHcvbkFzemZpUUlKVGE0cnk3R2puLzRNL0pNY2Iwc05OWmw5NTdRTGFs?=
 =?utf-8?B?Tll2bG44WlpSZExEQzdsMTdoTEdsM1lzN05oSHpRVnhhQllVdStVVzM5K1RZ?=
 =?utf-8?B?S1I1NHZWVWxJMDJNVkkvSmcvRHBibWg1QkZhVVN4cmVwVGh3bWpuSzl5SmNS?=
 =?utf-8?B?U1g5YXZPbmwzOGhFQjIwbTl6SVNHcGJLa3ZYMW9KczJxZ0FGeW8yQTFMMkQ0?=
 =?utf-8?B?cFAwSWlBYjVoazFTaDBYdG14cTYvRVQvQUJ3a1dOSFJwN0ttQXpkTkcrNTBX?=
 =?utf-8?B?ZHdERWo0U0ZxYUZJUGUxSzVxRlZORzlxWFM1Y2c1SFNYekJaZUFKNHlidS9J?=
 =?utf-8?B?UzlYak9uWldvSmJJc1h4TlFZMUZ3akVnWFpNNHlseDREY05HRGIva2k4MU5m?=
 =?utf-8?B?UHhKbVN4a2MvSHYxeDBCNDV2RGV6aWZLWGw0V3RLZHhRQUp5VmdMU2E1b2xV?=
 =?utf-8?B?Z05PN2M5RXQ1Ri90NEh6RndDRFk3dWZtQVhFbmNFYTZUeVZnZDJ5dVF6OFZm?=
 =?utf-8?B?S256Mlk5VFIwcWFWbVBQdUxaSERkbktkNWQvVVpEVkRXN01Cc3JrTnc1anFz?=
 =?utf-8?B?NER4emM2ZUtDSnNPNTFhMXVMZFl5V2YvNEtsR1dpMTlYVTlCVS9rSXFLRmdM?=
 =?utf-8?B?N2hMRTBWZmcxMktkNkx3TUZWSjcvR2RsYWV5SGkxeHV1bnBCeGVJZXVrdUEv?=
 =?utf-8?B?Y1VmQndWTUlSb1VkZkQvNndIemtRQUV5T1ozTmZnVnF5cW5QQmp3SWE2dm94?=
 =?utf-8?B?WVBoM3JtZUFFMWNRc1VBQ1dOdkM4OFRXZUtoMGZaOFVCK1pmQVFld2piQ0JR?=
 =?utf-8?B?QnVwNWMzQkFjTUJWeHdidTNJVHc0N0p3cm54a2owSUxLQ0hpN3YvM1Z5OWRJ?=
 =?utf-8?Q?ywW0Wj1ejlm/Tve8=3D?=
X-Exchange-RoutingPolicyChecked: gQPoNx+KaU0EyD2Sz0TThmBgltacusNxVqlhtSndIj65fA/UbQ3MM8XGYIuVazLFI05nGensJKTmbLQcynWlUi6MiM22VENK55jpvIQ7qe2Vi1bZFt0swavTIrbp7iNE0aHBZUd+chp8SH7rJOaIP3kmJP/DFNJTq3Ap+W3K3YekII/o18tE1N+M9xJ5Ev+bqbokst+Ukm3r6F1FhwSz5Bkx0svvaQtKTWnhApfT/PH3U/TyD8UT1xMDj+slM51/h93RXUcWp/YCmOLFXRAn6kj72X5y/2N7dsSPT0BoMnD3BaRNKH3hAysfIL6k7WqSlzfqWxyjTArQ3IZBk0GyHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebbac77-d253-41b0-a2b8-08df1b26b95c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 17:02:04.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSv78uCs/9nILbgqREY0yrmVcOYO6ipFCHJv/XcIUSldMiHg5VMwdTErmwt0JS8po1idPGLrDrF3t8xO236x4wTw8YqBs6fwJjCrFH1smak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB992399
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 01:31:10AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 (2) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Incomplete fix: the RTNL self-deadlock is only removed from the
>   i40e_vsi_reinit_setup() arm of i40e_setup_pf_switch().
> 
> Pre-existing issues:
> - [High] Dangling main-VSI references after a failed VSI reinit.
> - [Medium] NULL pointer dereference when the reinit unwind re-enters
>   ndo_stop after q_vectors/rings were released.
> - [Medium] Memory leak in the asymmetric unwind of
>   i40e_vsi_reinit_setup() as it exists at this commit: the two early…
> 
> --
> 
> i40e: avoid deadlock when calling unregister_netdev()
> 
> This adds a lock_acquired parameter to i40e_vsi_reinit_setup() so the
> err_netdev unwind uses unregister_netdevice() when RTNL is already held by
> the rebuild path, and unregister_netdev() otherwise. The caller in
> i40e_setup_pf_switch() forwards its own lock_acquired flag.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 65aa50330aac..5ea8731ece08 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> 
> [ ... ]

> [Severity: High]
> Should the other arm of this if/else get the same treatment? Both branches
> are entered with identical lock state:
> 
> i40e_rebuild() {
> 	...
> 	if (!lock_acquired)
> 		rtnl_lock();
> 	ret = i40e_setup_pf_switch(pf, reinit, true);
> 	...
> }
> 
> but i40e_vsi_setup() still takes RTNL itself, both on success:
> 
> 	ret = register_netdev(vsi->netdev);
> 	if (ret)
> 		goto err_dl_port;
> 	vsi->netdev_registered = true;
> 
> and on its unwind, which is the exact pattern this patch just replaced:
> 
> err_msix:
> 	if (vsi->netdev_registered) {
> 		vsi->netdev_registered = false;
> 		unregister_netdev(vsi->netdev);
> 		free_netdev(vsi->netdev);
> 		vsi->netdev = NULL;
> 	}
> 
> Can the !main_vsi branch be reached with RTNL held? The err_netdev path
> patched above ends in i40e_vsi_clear(), which sets pf->vsi[vsi->idx] = NULL
> and kfree()s the VSI without resetting pf->lan_vsi, so
> i40e_pf_get_main_vsi() returns NULL on the next reset. The following
> rebuild would then take:
> 
> 		if (!main_vsi)
> 			main_vsi = i40e_vsi_setup(pf, I40E_VSI_MAIN,
> 						  uplink_seid, 0);
> 
> with rtnl_mutex already held, and register_netdev() -> rtnl_lock() would
> self-deadlock on the non-recursive mutex, which is the failure mode this
> commit describes fixing.

seems i40e_vsi_setup needs the same teaching regarding lock being held

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
