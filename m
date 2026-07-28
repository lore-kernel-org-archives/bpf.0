Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64453B71D8;
	Tue, 28 Jul 2026 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218381; cv=fail; b=dgb2Jr3cW9ixuT+iRmPqxloIVmvdcxxOAGU6qU9CAat1OWcD9iLVRStBH1DzgY+N0b81Z3Qx8BvPZDCx8x+qKiGuHKa3G/LvkwqvnIQqt6oG4NK2U3i2ESvMSscVrCL+XQX+18YUx8XHCnnHBVTvtfYRaHK2ZuvdymacJ/trBsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218381; c=relaxed/simple;
	bh=rYexvAW+9/Wl8otPb7WAJ2ferRoE7UnZ+30Q9sX4dz0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBqdL5HXTePGtygWwDWvXi63tz6FDsmyzNfvBQAePE4HzxNcI04M9EJj+tMPXcYE+j6tYR5U9rfLQcqV87JtyEEOG5tPwf8kA2C5mA0bivbgFME00LQWJmE3lZwrsHSqrqgVMPgR/Z7dO4QT9U1f2NiUj1lsioFR4HOEWN9+mFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n7SDe87T; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n7SDe87T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785218377; x=1816754377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rYexvAW+9/Wl8otPb7WAJ2ferRoE7UnZ+30Q9sX4dz0=;
  b=n7SDe87T2V5xOiZ16TzyZ4i1zLXPxLLFvuM6TJc1sn80E7DXBYpRs4xz
   cnJx48oWkJZmyP1hCte1N2twnd9iHkUgGpE7EIy1qjDsSD0LHAWoG6Sy+
   8wKbdR7jQyaJ728pxVBh0gyoIivmXcTIHK3z9kRuYnjC6B1WIbeO4cNV/
   jOn7O5EYKC5FLFwafdkCm9Fy2jts3wutN77po57UDSXn36s5ShNnQ9QpH
   6mPRd4eVobYyQewFYon7FpRlQpp7ywtyafKKYCnScwhlGov6o4Z/mhxjb
   zGPR4ThG1jzqUP+BVjSglqnn8fO2z4q6qcWIk9uR20AAQJb7sSL7wlLSd
   g==;
X-CSE-ConnectionGUID: s34ABGvuRBKSbC2DagmnBw==
X-CSE-MsgGUID: 9CISx7fgRfaArbpCyrzbcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="84920959"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="84920959"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 22:59:34 -0700
X-CSE-ConnectionGUID: DcX5EesIRvWoMoqNqrtlXw==
X-CSE-MsgGUID: ZX2yOBZuR6qB7HQCFoVQaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="255670577"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 22:59:34 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 22:59:33 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 22:59:33 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 22:59:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uI3uE5Xvl48+YjGYE7Td8DrMM4k4gtMwi3/v9w4K3psgfQQkWqiJG16evouSr6U7GSQZ5HsIqBtsYvxCHmPo8TcyhbjLkgVr/typ95vQ0Cbdg7lIO4LLYkOLJDkzM89vxWEmbjkr6fs6k0MQskjZHbnaMUAkz9Kp432l+blPzLk/fMnYxcjK7x16MOw1H8E9tWmFmOx2rgf/R2HI9hUeviDym490iKx6GtnJQT9vPVZFo5ZzM9T6ETmjnaJQkKgRLIgse66T70E3a6Sf2VK2UOkPPoNK4U/vmozF0CWfAebUxoRTtecFlWfb68Kn7yB+4uObeQ0etF1jnvp4k27M5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYexvAW+9/Wl8otPb7WAJ2ferRoE7UnZ+30Q9sX4dz0=;
 b=SCncafRwRfq5KumfN34YmtDiW+0KT4U+HsavL0cpXZ4gdp1vn/c7HZDZzWfkw/EIJWNjeOdqJkTmVgZvprH7aCoEg0+mz1OCWo2CVG2/0Cvz+Z/i5g1uQ9UUkS5WbEfOHSVwDjsMUAt/tsJutqpDaZyjGskgplt06n8xxbqbFwznsR1Yadnr5+ppe2nDqlzOPbsB67P4PjnSJBqMOw+oLFytVzrwKQkc7zetAP7IW2B8lAKs1NGWLCjE5LGnVHDkVK5F+3BSaIW8nFfFhEGyP9d1677IWIOEHd0RHedjzlLdsth+qsnJWyohxg1wQk6m+H9u8dJhoADif5BA7sSMug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN7PR11MB8028.namprd11.prod.outlook.com (2603:10b6:806:2df::7)
 by SA1PR11MB6807.namprd11.prod.outlook.com (2603:10b6:806:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:59:26 +0000
Received: from SN7PR11MB8028.namprd11.prod.outlook.com
 ([fe80::1731:75b0:1bb8:9b19]) by SN7PR11MB8028.namprd11.prod.outlook.com
 ([fe80::1731:75b0:1bb8:9b19%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 05:59:26 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>, "kernelxing@tencent.com" <kernelxing@tencent.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "Sarkar,
 Tirthendu" <tirthendu.sarkar@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>
Subject: RE: [PATCH net-next] selftests/xsk: decouple xskxceiver and xdp apps
 from test_progs objects
Thread-Topic: [PATCH net-next] selftests/xsk: decouple xskxceiver and xdp apps
 from test_progs objects
Thread-Index: AQHdFrvZxXoJAFFL2EiGsMmVZ9TR5raCAsQAgAB3ipA=
Date: Tue, 28 Jul 2026 05:59:26 +0000
Message-ID: <SN7PR11MB802801BF804AC81C1035F6758FCB2@SN7PR11MB8028.namprd11.prod.outlook.com>
References: <20260718134450.575758-1-tushar.vyavahare@intel.com>
 <CAEf4BzYRKO-h=7vhzVnV7Du3fVycZhDdAduUHMta9TxNXXY1+g@mail.gmail.com>
In-Reply-To: <CAEf4BzYRKO-h=7vhzVnV7Du3fVycZhDdAduUHMta9TxNXXY1+g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR11MB8028:EE_|SA1PR11MB6807:EE_
x-ms-office365-filtering-correlation-id: 00a31b4a-2b00-415b-376a-08deec6d6175
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: O71emiuRXhztmNE57SyEZ0lv70Fs9Yh+IxLLQKiylt7wrZKrIgZujDllL1F4Zn7Dw3WeON7mSWYQepUaxZZApvdtGgHrpOfPE5JMXg5/vG/Ez54p/TE8WXkOvmdzkIBl19Cddhx9qycow6lV/Dp0XX0HwUvOFBJELSQbbp2iZ8XY8CB0QoQ1Z0iuiTBFi0oapiQ7StG0vxn/ObL89AfqgmR/8d1qMHpzCDJmovtv2eTUHfT+BG0H4cgYPBC9h/NPq+f08C1ECS8qiay2KYBqAxPTUZFGcxrSUb6B9TlvABypY1yO1iNonn3mDf9skvsr5VQsWJExk+1K0lGAe1sqbvRmKSyawmwIATfveKFGaRqikVQpJYy0FDtmhbSjoIUzv1HZwJv6gx+kUYHrdBhC78caL+RwFm/6Q40H0e5Hht1ELigfSy7NGJ+IJaLAaA7hFinwOjDC1KB/DY222LYdsCqdcm27S/qZKj8fgIZK4dOzO8VrOrjl5GlvHhZUVgoGk0klgF1WLC8Jz4Uc6ULvY1z+RffD7US0JS+VQD53U0G1oSFyEBcNvJADWLwNuS5Ng+MA3mJxqINYr2fjOc73U51GXbZzv5BJTWbt5H8XxJs4Og8u86+p7w0uAlRBEDSBZWdZcqjNClAwjJYTBErFLY/wZkmAK7tEpz9ZdGRSv8pitKu4wFSiN3kOsGrsnBN2QfjSPAIrf2L/PwzIfTOUcNCatDEK/XBcuyKSt4uHwgA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB8028.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2N4bGx3UHlWbWZXa09hdTJHVWpSaSt0RzdtTHE4c3hCWW5YQ29sWU9idld2?=
 =?utf-8?B?eEJiSFRjcUdUWHczYk1LdVNOMmVtQmZKV2cwdHYrUTNXcE1hQ3VhYmRqQUFk?=
 =?utf-8?B?ZC9jYTJvc0IwOVg4c2dBM2dLYVd2VStrZmFaVFR5ZnBXelZFRDdUT1NQNmlv?=
 =?utf-8?B?QU1LWjAzaEp5OEpXU3hGTXlVRkVhT3dlaEh1NmlYdHdhWGpiOGlvYjNseXh0?=
 =?utf-8?B?OG9uNW1RSE1pcEdYMVowdmlLYktxVUEwVmlIUWxmZVlnOHFhcjVDRVZoU1Vm?=
 =?utf-8?B?SU1Ed1c4ZXRZclg0TEc2cFkrQW5FbXBPYmZHVU5kR2xVRWx2ZE92alNVUFB4?=
 =?utf-8?B?SmpubWFaN0F3Y2JMaEVxSkttZEttcG9hSVdodXBzVE0zMkd5eHI3VThOREpS?=
 =?utf-8?B?UXVBc1lQaTZhenFOa1V5S05zN1lZOStVMzU0R3B6ZkZxYmpwd24vR2RqMStx?=
 =?utf-8?B?Sk9RejZMYXZiSDd3NWxlcmQycnhOV3dDcXZ6eWJHSXdDUnVZbE5oTEpVMFlz?=
 =?utf-8?B?YzNrdlkvWkNCZU9rV2FLYzBIRUF3OUlBUmhkZGpXYXhSSzdONC93SWdHdGNm?=
 =?utf-8?B?ampYczlIbW43Sk9jdCtnak5BWHNaYjVCa2ZQQmxPblZoNWdaNVRIb1Rpb29P?=
 =?utf-8?B?aXhTUlBXK1JxWTFrRTErdlVRY1RUYlozc0hJSUpsaVlTUDFqanRDZFVweXZ0?=
 =?utf-8?B?bUlVTVQwdTRnVXpqdUpzK1VlOUhWbUdYMkM4dlgyb2Z2bjNpcExSakFWU2x5?=
 =?utf-8?B?L1BnNXNYaEZQNm50eWx4b25mV0s3UTk5WnZLdUV3T1RtNDhDRk1pNVdqcFBJ?=
 =?utf-8?B?OGVJSnN2OElzVWwyakhXVWdFaWFURGY1Mzk0SnlkZThwckpyNGxUTUFDWWNP?=
 =?utf-8?B?YVgrU0RJNUltS3hQWldDWG9jTi9UbTFpc1ZWVnBYWUU4Z0VKQTNaNUY3Y09h?=
 =?utf-8?B?MFB0Smw4aGJMRVdjdXZBV0NOVFJNRWZjV2dIZ1R3VlBCelpZYlJ3aDJkSXNY?=
 =?utf-8?B?dUFVMzFxbk11RU1Wd3IyeHQ5WjNhYVQ5Y2VJT3MxTnRDK2VqN1NodkVBQVFa?=
 =?utf-8?B?NGw0ZWw3UVpGcmVBZkVac1JpSW5UMy84bi9FRWlrM2ZCNVd3WnpNbTlOYjRk?=
 =?utf-8?B?ZmdKbFo2aHNCMjhXemRqK2k3Z2UxcGlkM1hweFhGZ3RFSWE3OTVEN3NZWWY4?=
 =?utf-8?B?UVc0RUpkdGxWN1RZVEpDN2NYS3VHcFhkZjNYZTF2QWlEME1HN3NLNlJNYjhY?=
 =?utf-8?B?Rk4wMHRDSnM5am1qKzhTUnNXQ2lIZlhsZEhVK01WWitPZWZKWE1tS0cyRGpW?=
 =?utf-8?B?TERuM0VmYmh0R1NMTTBEeHBQZ3NVaG85SUdxTzBacW14R3JqN3NWaGJUdmZ1?=
 =?utf-8?B?anNCYUdtNnlmemRROW9lTVlpeDFmN3FqNjR6NkJZRDJSVGdMd25EdjBXYnR2?=
 =?utf-8?B?QmtZL0RlbmcwNHJLTnN6ZEZyT1ZpNUNNbGRsUUNtVW1XQXNTSUUxUGx2Z2RR?=
 =?utf-8?B?eHdFbE9lcUtVdWw1SGFFTkdyKzMxUXkyZWJ3eW9iZEVmQ3dlOXF0ZmxXN0hQ?=
 =?utf-8?B?OGU4alExc29OL3BRWXFBemhDaEcrUTc3OVNrbGp5N1FGZncyQkF4QU9MQi9I?=
 =?utf-8?B?TG1aWjhOWGlIalh6Mk9MSEFhWk1pd2VneU80QnA5VHlmYWgvNDRaTlVzeFhv?=
 =?utf-8?B?ZGJsSTl3MHU4MEtheG1hU3VQUG9LdnJFLzcxa2k3R1dIL3hDZnNacjdRQmov?=
 =?utf-8?B?bmNCRUJIMzd2Mi9BNlVjWGlxUi9rd1Y4Zzgzbml1U3I2WDRxRGFZdUUyMUQy?=
 =?utf-8?B?Ny93bU9Rd2ZSbDFDNGI2dUlvMlMxRldQcG1ONnUvNW8xMFNnSUxqUFA2L1BB?=
 =?utf-8?B?dFlOM0Yyakhnck9kL2puWUlsek1OdWtHTjhuNnlBelRtaTAxNmRsS3k2Mk00?=
 =?utf-8?B?bHU0L2Y1RkFMeFhGeXpOcEFzdEtPdnpVbDhRRysweE16V0ZlbjRmc0dmUFVj?=
 =?utf-8?B?ZzFuKzg2bk4wVUZNcXBwdlhjWVhwMC9CZ29uOXZzQXlpNjlNdWNDaEcyTm04?=
 =?utf-8?B?c3Awcjcyci9meG1GaStxRlo2REZwakNtYzdtNXBsSURWbmVaMUk4Vy83VE5S?=
 =?utf-8?B?cldPWnVEK01yZS91bFAxdkVIcVBkMUxwL2JYckZjMWxzSVg2REQrdUh2N2dO?=
 =?utf-8?B?K1dlRG1XVndKRUdwRDBFaVp2R1FoM0wzVnhrSFhzdGVka2lHOFoyNk10MFl3?=
 =?utf-8?B?SzBkdktUT256bzE4YnZhTUlwaTVmQ3REMjVkeC85SzZrZ0lXNk9jSUt6cllF?=
 =?utf-8?B?dkd5dG5Wand0RzRCMUdYMnZVd1BqTmxlbEU3bjVaU1hhQWN3ODMxQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MCfoZ/PBWgdHuHsVmTrsjGuGmz2CubN7g0PAR0adNtGHavZtJE0cE6XSN363rnm3RBDdlZcisEZKwuT8pjDfKOZSuIIc/6ZU+ZrEdw4dV/q3rkXBekFFZuBfEmkr3wNtpSpIYIyBmn51dx88jP5zSEQgHpU4rLTxSQal3saHIu6E0+dpEi7jXwPHaUSyt3MRl+mcCKA1ZMOm05sTH1DQJqCx8G57vZiYNdl7SZJgtIX5ADmaMBKiUGiJH5LoybpJWlODjOY+buJukP2SHTKKC9YJY686plQmGJUySWf5gLnJDKFOrUZSn4mEyYe19hZFeYSgU+LfF4JC2lI4T2hjWw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB8028.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a31b4a-2b00-415b-376a-08deec6d6175
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2026 05:59:26.3431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RigUvW/mM55rogQTvmw2BymnWlcJkq7kCXdQYnc19BqSKFRSYeXgATsq0k3n/okJpRDuZgFMC17saRXUt4DxGU/bXOTCxfMhPR4PV4KeRPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6807
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmlpIE5ha3J5aWtv
IDxhbmRyaWkubmFrcnlpa29AZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDI4LCAy
MDI2IDQ6MDUgQU0NCj4gVG86IFZ5YXZhaGFyZSwgVHVzaGFyIDx0dXNoYXIudnlhdmFoYXJlQGlu
dGVsLmNvbT4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IEthcmxzc29uLCBNYWdudXMN
Cj4gPG1hZ251cy5rYXJsc3NvbkBpbnRlbC5jb20+OyBGaWphbGtvd3NraSwgTWFjaWVqDQo+IDxt
YWNpZWouZmlqYWxrb3dza2lAaW50ZWwuY29tPjsgc3Rmb21pY2hldkBnbWFpbC5jb207DQo+IGtl
cm5lbHhpbmdAdGVuY2VudC5jb207IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGt1YmFAa2VybmVsLm9y
ZzsNCj4gcGFiZW5pQHJlZGhhdC5jb207IGFzdEBrZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFyYm94
Lm5ldDsgU2Fya2FyLA0KPiBUaXJ0aGVuZHUgPHRpcnRoZW5kdS5zYXJrYXJAaW50ZWwuY29tPjsg
YnBmQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSBzZWxm
dGVzdHMveHNrOiBkZWNvdXBsZSB4c2t4Y2VpdmVyIGFuZCB4ZHAgYXBwcw0KPiBmcm9tIHRlc3Rf
cHJvZ3Mgb2JqZWN0cw0KPiANCj4gT24gU2F0LCBKdWwgMTgsIDIwMjYgYXQgNjo0NuKAr0FNIFR1
c2hhciBWeWF2YWhhcmUNCj4gPHR1c2hhci52eWF2YWhhcmVAaW50ZWwuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IEJ1aWxkIHhza3hjZWl2ZXIsIHhkcF9od19tZXRhZGF0YSwgYW5kIHhkcF9mZWF0dXJl
cyBmcm9tIGV4cGxpY2l0DQo+ID4gc291cmNlIGxpc3RzIGluc3RlYWQgb2YgcmV1c2luZyBoZWxw
ZXIgb2JqZWN0cyBwcm9kdWNlZCBieSB0ZXN0X3Byb2dzIHJ1bGVzLg0KPiA+DQo+ID4gUmV1c2lu
ZyBzaGFyZWQgb2JqZWN0cyBzdWNoIGFzIG5ldHdvcmtfaGVscGVycy5vIGFuZCB4c2subyBjYW4g
cHVsbCBpbg0KPiA+IHRlc3RfcHJvZ3Mtb25seSBkZXBlbmRlbmN5IGNoYWlucyBhbmQgdHJpZ2dl
ciB1bnJlbGF0ZWQgbGliYXJlbmENCj4gPiBidWlsZHMgd2hlbiBpbnZva2luZyBhIHNpbmdsZSB0
YXJnZXQuDQo+ID4NCj4gPiBLZWVwIHRoZXNlIHN0YW5kYWxvbmUgYmluYXJpZXMgc2VsZi1jb250
YWluZWQgc28gZWFjaCB0YXJnZXQgYnVpbGRzDQo+ID4gb25seSBpdHMgb3duIHJlcXVpcmVkIHNv
dXJjZXMgYW5kIEJQRiBza2VsZXRvbiBkZXBlbmRlbmNpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBUdXNoYXIgVnlhdmFoYXJlIDx0dXNoYXIudnlhdmFoYXJlQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlIHwgMjAgKysrKysr
KysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL01ha2VmaWxlDQo+ID4gYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZp
bGUNCj4gPiBpbmRleCBiNjQyZWU0ODllYTYuLmE2ZjBlZDEwY2NiNCAxMDA2NDQNCj4gPiAtLS0g
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUNCj4gPiArKysgYi90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUNCj4gPiBAQCAtOTM0LDE3ICs5MzQsMjcgQEAg
JChPVVRQVVQpL3Rlc3RfdmVyaWZpZXI6IHRlc3RfdmVyaWZpZXIuYw0KPiB2ZXJpZmllci90ZXN0
cy5oICQoQlBGT0JKKSB8ICQoT1VUUFVUKQ0KPiA+ICAgICAgICAgJChjYWxsIG1zZyxCSU5BUlks
LCRAKQ0KPiA+ICAgICAgICAgJChRKSQoQ0MpICQoQ0ZMQUdTKSAkKGZpbHRlciAlLmEgJS5vICUu
YywkXikgJChMRExJQlMpIC1vICRADQo+ID4NCj4gPiAtIyBJbmNsdWRlIGZpbmRfYml0LmMgdG8g
Y29tcGlsZSB4c2t4Y2VpdmVyLg0KPiA+IC1FWFRSQV9TUkMgOj0gJChUT09MU0RJUikvbGliL2Zp
bmRfYml0LmMgcHJvZ190ZXN0cy90ZXN0X3hzay5jDQo+ID4gcHJvZ190ZXN0cy90ZXN0X3hzay5o
DQo+ID4gLSQoT1VUUFVUKS94c2t4Y2VpdmVyOiAkKEVYVFJBX1NSQykgeHNreGNlaXZlci5jIHhz
a3hjZWl2ZXIuaA0KPiA+ICQoT1VUUFVUKS9uZXR3b3JrX2hlbHBlcnMubyAkKE9VVFBVVCkveHNr
Lm8NCj4gPiAkKE9VVFBVVCkveHNrX3hkcF9wcm9ncy5za2VsLmggJChCUEZPQkopIHwgJChPVVRQ
VVQpDQo+ID4gKyMgS2VlcCB4c2t4Y2VpdmVyIGluZGVwZW5kZW50IGZyb20gdGVzdF9wcm9ncyBv
YmplY3QgZGVwZW5kZW5jaWVzLg0KPiA+ICtYU0tYQ0VJVkVSX1NSQyA6PSB4c2t4Y2VpdmVyLmMg
eHNrLmMgbmV0d29ya19oZWxwZXJzLmMgXA0KPiA+ICsgICAgICAgICAgICAgICAgICQoVE9PTFNE
SVIpL2xpYi9maW5kX2JpdC5jIHByb2dfdGVzdHMvdGVzdF94c2suYw0KPiA+ICskKE9VVFBVVCkv
eHNreGNlaXZlcjogJChYU0tYQ0VJVkVSX1NSQykgeHNreGNlaXZlci5oIHhzay5oDQo+IG5ldHdv
cmtfaGVscGVycy5oIFwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICBwcm9nX3Rlc3Rz
L3Rlc3RfeHNrLmggdGVzdF9wcm9ncy5oIGJwZl91dGlsLmggXA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICQoT1VUUFVUKS94c2tfeGRwX3Byb2dzLnNrZWwuaCAkKEJQRk9CSikgfA0K
PiA+ICskKE9VVFBVVCkNCj4gPiAgICAgICAgICQoY2FsbCBtc2csQklOQVJZLCwkQCkNCj4gPiAg
ICAgICAgICQoUSkkKENDKSAkKENGTEFHUykgJChmaWx0ZXIgJS5hICUubyAlLmMsJF4pICQoTERM
SUJTKSAtbyAkQA0KPiA+DQo+ID4gLSQoT1VUUFVUKS94ZHBfaHdfbWV0YWRhdGE6IHhkcF9od19t
ZXRhZGF0YS5jDQo+ID4gJChPVVRQVVQpL25ldHdvcmtfaGVscGVycy5vICQoT1VUUFVUKS94c2su
bw0KPiA+ICQoT1VUUFVUKS94ZHBfaHdfbWV0YWRhdGEuc2tlbC5oIHwgJChPVVRQVVQpDQo+ID4g
K1hEUF9IV19NRVRBREFUQV9TUkMgOj0geGRwX2h3X21ldGFkYXRhLmMgeHNrLmMgbmV0d29ya19o
ZWxwZXJzLmMNCj4gXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAkKFRPT0xT
RElSKS9saWIvZmluZF9iaXQuYw0KPiA+ICskKE9VVFBVVCkveGRwX2h3X21ldGFkYXRhOiAkKFhE
UF9IV19NRVRBREFUQV9TUkMpDQo+IHhkcF9tZXRhZGF0YS5oIFwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICB4c2suaCBuZXR3b3JrX2hlbHBlcnMuaCB0ZXN0X3Byb2dzLmggYnBmX3V0
aWwuaCBcDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgJChPVVRQVVQpL3hkcF9od19t
ZXRhZGF0YS5za2VsLmggJChCUEZPQkopDQo+ID4gK3wgJChPVVRQVVQpDQo+ID4gICAgICAgICAk
KGNhbGwgbXNnLEJJTkFSWSwsJEApDQo+ID4gICAgICAgICAkKFEpJChDQykgJChDRkxBR1MpICQo
ZmlsdGVyICUuYSAlLm8gJS5jLCReKSAkKExETElCUykgLW8gJEANCj4gPg0KPiA+IC0kKE9VVFBV
VCkveGRwX2ZlYXR1cmVzOiB4ZHBfZmVhdHVyZXMuYyAkKE9VVFBVVCkvbmV0d29ya19oZWxwZXJz
Lm8NCj4gPiAkKE9VVFBVVCkveGRwX2ZlYXR1cmVzLnNrZWwuaCB8ICQoT1VUUFVUKQ0KPiA+ICtY
RFBfRkVBVFVSRVNfU1JDIDo9IHhkcF9mZWF0dXJlcy5jIG5ldHdvcmtfaGVscGVycy5jDQo+IA0K
PiBJJ20gbWlzc2luZyB0aGUgcG9pbnQgb2YgdGhlc2UgeHh4X1NSQyB2YXJpYWJsZXMsIGdpdmVu
IHlvdSB0aGVuIGdvIGFuZCBsaXN0IC5oDQo+IGZpbGVzIGV4cGxpY2l0bHkuLi4gSnVzdCBoYXZl
IGFuIGlubGluZSBsaXN0IG9mIGFsbCB0aGUgZGVwZW5kZW5jaWVzLCBtYXliZT8NCj4gDQo+IHB3
LWJvdDogY3INCj4gDQoNCkdvb2QgcG9pbnQsIHRoYW5rcy4NCg0KVGhlICpfU1JDIHZhcmlhYmxl
cyB3ZXJlIG9ubHkgZ3JvdXBpbmcgLmMgZmlsZXMsIGJ1dCBzaW5jZSB0aGV5IGFyZQ0Kc2luZ2xl
LXVzZSBhbmQgdGhlIHJlbWFpbmluZyBkZXBlbmRlbmNpZXMgc3RpbGwgbmVlZCB0byBiZSBsaXN0
ZWQNCmV4cGxpY2l0bHksIHRoZXkgZG9u4oCZdCBpbXByb3ZlIHJlYWRhYmlsaXR5IG11Y2guIEni
gJl2ZSBpbmxpbmUgdGhlDQpkZXBlbmRlbmNpZXMgZGlyZWN0bHkgaW4gdGhlIHJ1bGVzIGluIHYy
Lg0KDQo+IA0KPiA+ICskKE9VVFBVVCkveGRwX2ZlYXR1cmVzOiAkKFhEUF9GRUFUVVJFU19TUkMp
IHhkcF9mZWF0dXJlcy5oDQo+IG5ldHdvcmtfaGVscGVycy5oIFwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICB0ZXN0X3Byb2dzLmggYnBmX3V0aWwuaCAkKE9VVFBVVCkveGRwX2ZlYXR1
cmVzLnNrZWwuaCBcDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgJChCUEZPQkopIHwg
JChPVVRQVVQpDQo+ID4gICAgICAgICAkKGNhbGwgbXNnLEJJTkFSWSwsJEApDQo+ID4gICAgICAg
ICAkKFEpJChDQykgJChDRkxBR1MpICQoZmlsdGVyICUuYSAlLm8gJS5jLCReKSAkKExETElCUykg
LW8gJEANCj4gPg0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCj4gPg0K
