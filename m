Received: from iad-out-002.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-002.esa.us-east-1.outbound.mail-perimeter.amazon.com [13.216.54.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29D3B961F;
	Thu, 17 Sep 2026 04:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=13.216.54.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618157; cv=fail; b=GEQIsKEEa3atTThLBmIQ+z3FjvcYy3jGOFCfBBQqG/KDYlQUqC0wTuat2tdoxh+DY5TXzUK0HcxrBxCjtxJ3FYjzKw6eXlO6YbqWDB0wqrIzAYxi6ISVx6Nf9YOIC0T8C3i4EhU7pVMxM0BWo1yg4FuJ7t2OiZ6e+TKi7VjkiQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618157; c=relaxed/simple;
	bh=VF2OXf7OW9ll2iJ/L225R6B5xRWO3S40WLpINl4PY7s=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4dlLVCo0Ebjtn77QW5sdcChyz90e0wPYMvTeqa+Yk9bxd/EIF+wq12gXDgFuUmiYbU5o2roriHOmqNxRmNA99+qw2Blssk+dgBxl0Og9RfQj6Bi7fRHe6U2sp9XutGV08ZZK7ZutWINC+tm/juWmqd6jYtBUaG9IIg7RtV5A6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=D2rT0+X2; arc=fail smtp.client-ip=13.216.54.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="D2rT0+X2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1789618156; x=1821154156;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=VF2OXf7OW9ll2iJ/L225R6B5xRWO3S40WLpINl4PY7s=;
  b=D2rT0+X2k9/JJJmNRToEuOWluw1WnX3R8g6vyiBcIQjwtxgoCU7vScqF
   KGX6my21Vemq1lePSl7vJpnEEkK85wfyw2GS32W+Kul2Dv2NRnxeLocm+
   20hm8m79fgf4beyCXbdR7kOFVQx9bQSMT/kL5BuyQBLtAByops/EmmFd4
   AyjFl18M7StuLSx+Aj4M8qVhRRASQHsfc53b9ef5jhsBpynyEHgHEB0NM
   GXu/OlHMTqnvC2YpDmrd3jU8OcenFvyVI8Jn2I2JPhgZBcSzguOsZ0vDT
   izfDNTEwBHYIp8PMECC6SJKqqilaQHfa6XiaRD+Rn7FnSMVSOhgFc++tM
   w==;
X-CSE-ConnectionGUID: +zHEDCsHRhCh6D4rO1Eo1w==
X-CSE-MsgGUID: aRN85X7MSRSt8NnuPvGt9A==
X-IronPort-AV: E=Sophos;i="6.27,103,1787011200"; 
   d="scan'208";a="27548949"
Subject: Re: [PATCH bpf-next 1/1] bpf: btf: add btf=off boot parameter to disable and
 free vmlinux BTF
Thread-Topic: [PATCH bpf-next 1/1] bpf: btf: add btf=off boot parameter to disable and
 free vmlinux BTF
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-002.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 04:09:14 +0000
Received: from EX19MTAUEB002.ant.amazon.com [52.94.133.143:31955]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.61.84:2525] with esmtp (Farcaster)
 id cf79d1b4-24f2-4cd2-bc4b-a9a53c74cfa5; Thu, 17 Sep 2026 04:09:14 +0000 (UTC)
X-Farcaster-Flow-ID: cf79d1b4-24f2-4cd2-bc4b-a9a53c74cfa5
Received: from EX19EXOUEA002.ant.amazon.com (10.252.134.207) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 17 Sep 2026 04:08:43 +0000
Received: from EX19EXOUEA001.ant.amazon.com (10.252.134.47) by
 EX19EXOUEA002.ant.amazon.com (10.252.134.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Thu, 17 Sep 2026 04:07:36 +0000
Received: from BN1PR07CU003.outbound.protection.outlook.com (10.252.135.199)
 by EX19EXOUEA001.ant.amazon.com (10.252.134.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46
 via Frontend Transport; Thu, 17 Sep 2026 04:07:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOcmxgbxEf2vVySex+TBfUuV37Z5AGa8pVvJ1VjwZDVJ8MJ9oRDS/WXd6jT8AihwKJRt1dZYM/i0NaArrtQQilCncI3lKgZtImiB9qk6dIL4NWVThjfAY7fqdQKu81c23my4zkwrfpIamLkqbAPD4mNMey902coBpRHE/hPgqecdxGT6ad41eQnv6E5xBnNQT/wd2cLW+NA+G2bt2jsHGn6lx4dRobgra9AHHNiepP8pO/f5Pp7hJ9qUcXUz53Tliq6rlTND5MLL9FvKQ9U4oc1onFXRdXRP4O7C+lBw9fZeLGyefVvpZDccO2yqhBlZQgImKAluQCNnOcZ3G/Tn1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VF2OXf7OW9ll2iJ/L225R6B5xRWO3S40WLpINl4PY7s=;
 b=iSztxMgQOslS3xWono6Kf/FHsiUs2o6WPdi2dYm/X5zHe5zotzzB75rYb4fV/zmfQkruwblhSVdezOJvBPAaTSfECPK8YdJHwrF2HhTperV39SbaIY1A9TkticQXRmirSuRM70cYEhV1qeApW492cgZoqa0DZIt6C4PX9mT3jw9OE76anOvyAKTTeft113V9XJh7DqEr0CkLSToOvvVqjazPIp37wPRhD6Dr4fvHwV11HNnIN2jRmcYVz4KtWCwvG+/x0Nw0w8mviaYPKHjRTb0/xoEUXMYUOSle0QdJfRpZJQZ6hfnZ9fG6cT5fAofOSlWe8DEaBEdZa0gZ7c7rtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.com; dmarc=pass action=none header.from=amazon.com;
 dkim=pass header.d=amazon.com; arc=none
Received: from MN2PR18MB2669.namprd18.prod.outlook.com (2603:10b6:208:10a::32)
 by SJ0PR18MB3817.namprd18.prod.outlook.com (2603:10b6:a03:2cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 17 Sep
 2026 04:07:34 +0000
Received: from MN2PR18MB2669.namprd18.prod.outlook.com
 ([fe80::7a22:7d4b:a619:1a8]) by MN2PR18MB2669.namprd18.prod.outlook.com
 ([fe80::7a22:7d4b:a619:1a8%5]) with mapi id 15.21.0382.014; Thu, 17 Sep 2026
 04:07:33 +0000
From: "Wang, Jay" <wanjay@amazon.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>
CC: "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Mohamed Abuelfotoh, Hazem"
	<abuehaze@amazon.com>, "Doebel, Bjoern" <doebel@amazon.de>,
	"jay.wang.upstream@gmail.com" <jay.wang.upstream@gmail.com>
Thread-Index: AQHdRkfPPs5hrVoBI0OIjl6KqnCeG7bRsjiA
Date: Thu, 17 Sep 2026 04:07:33 +0000
Message-ID: <C1DF89F9-B9F4-4FBC-9B94-E250AAAFEDA2@amazon.com>
References: <20260917000201.25581-1-wanjay@amazon.com>
 <20260917000201.25581-2-wanjay@amazon.com>
 <DLH7UY9PDSQP.2AXEGNH838JS0@gmail.com>
In-Reply-To: <DLH7UY9PDSQP.2AXEGNH838JS0@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.111.26071325
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR18MB2669:EE_|SJ0PR18MB3817:EE_
x-ms-office365-filtering-correlation-id: 5d576b5b-65a5-4cc6-ed54-08df14713370
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|38070700021|3023799007|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: 5LUlv9q91LNVbiB/Y89N+nJyqAhqm7A0mGFh7Tl7kmGILhWo2+hrsj+lZfBAawuxqZeiYxOleEmNYUGo1WKiWod37gwY4cJ76MG7Q/QYcc7AUWGPytS6GaWoQiBYWmEHvCEfufArxteDYO37i+objc9czDgnQHWACv+Pu56GOvOW+jF4vE7OmZNv5HO5OJtcFJXWwyh8dNeO6YKMfYFH9AbFMpFeFaXF18BSlSPOcuPzq5/hYDc4z7BdSBItnI5S/qRAvrzwUswOOqjKkG/PiXLg7iAI5kzntNuwS/sVu+Nuko9f9tBJW2J78JU3D4uBy17zseFtxV4uVNf3d74HiCouDXE5oDNelIvhb+wtqDtfN2sptHk7feKqAjvq/SXnLqtqr2lnlKv2LzXgdPFM852I8C/2V/HRSMIXwOvG5OV/gKSDvR29hWUmNajg+Rmc3sB+/lBitgH2f1v0JAr21pljAZYPKA7TLzfLLv7B0yoH3IggiOJ2mF2+St/eYjuOyF3JHw4G2wYasHuEiOMo4N+JSaRWK6+JzLpwVwPKSMeX4Qz1n1zD8V3Zht7NaZcObT8zj1w7aQVMJvfnkLENYZSfi2GZ5r7V5FaUn4IfGNXqTj92E1MMSx7XxcTU6e2LfBmjt3Z7K2+3C5gFygJCjY3b9cCgmIHD7xtb1AKoC+BTk7ObWHYQHB6Lx76rEW7Z6HnGmO64Tg98WkGINiLqXxGw73xd0yPmHYsrIrrYhi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR18MB2669.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(38070700021)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFhXd3V1b3FFWG1NSVhnVzF4M3FmNG9KR2ZTSEVmbDkxd0h4TjRwaGxmbTRO?=
 =?utf-8?B?a3RLZ29ZSExzbkQxUTQ0YlpWdm8xUlpXcnYxMFVlUFl4dGdGUlQrWTRMYWxq?=
 =?utf-8?B?MW1OcERsSjRIYjY0ampZUWxlL3IzaGJ4SHQ3TjYxdlgzenN4QWRLd3VSMjZF?=
 =?utf-8?B?Uml4cVFNbXBFSW85R21XK1d1ZGpHc0g5YW1LVWhMcWo3VFV4ajcySlBvdlg3?=
 =?utf-8?B?SjYxT09DNzNCK3lmdEpVYmV6bWt2S0tOYmtFWHY0T3gvTFdSV0srTURsbDVz?=
 =?utf-8?B?T0d4enJEeHJ6TzRtbXkwUkd5L3FYc2xiV3FUbVcyMnRkNERjbkQ5MGZnYTNJ?=
 =?utf-8?B?T1UyNk9vREZ4WWErK2FkMGRlTXl3SG1ZczRacitXc2toVUtKZFZsVStMeTIw?=
 =?utf-8?B?T2hHSWRQaWptbnRkZk5BaU9sMGN2ZktINXZTUW9kQllhNGlXeXhIbzQ5aWF2?=
 =?utf-8?B?VDVleE1rYmlrQ0RVRjBpU2crdVN3cmYxajRVaGlhR3BLWlRuOXIzazNhQkpY?=
 =?utf-8?B?MUh6RCtZbHNzbkdGZzJCSHRBdnZuN3RvZ0FoMFNlWUdRSFdLU1VEaW1RN3FU?=
 =?utf-8?B?MXFlS2IzeDFLL3c2TTNzREgwQUhQSWlkTDJrajhiRzhPdDRSelhYTzhpUVRw?=
 =?utf-8?B?alFmNFVoQjZ0Y0ZqWFhBdWRjclJuWm9wUS9RdkJIZzY1RU5UeVRtdVFZdyty?=
 =?utf-8?B?anVxTG9maSttT0Y0MTZlMjA0ODBkQUVrdllydWlycDhjNjl2dDNEamE0WHhp?=
 =?utf-8?B?VUh0SDNZL05YYkZMSlU2eUdjTm1keElJQmhYMy9KSWVpa3dsTGFLdGVLVEhh?=
 =?utf-8?B?S1ZBdkdFbVJUOXFZYzhxWk1NZUk2TVF0L21TNFJiUDJudDFDdUJ3NHM5UzMx?=
 =?utf-8?B?anR6aktLeDN2NUZ5TXE1dXVsMkxHNGI1Q2JRUmUyMlB4YzBVNjFXNFNoVG83?=
 =?utf-8?B?S3dzS3Yvd29Sd203VkhMNEZuNDZZd0xXS2dneTllMk5RVVNHUDVuNGdLSHly?=
 =?utf-8?B?Z1NBSGNvOFljQlV5am1jNlNSaWRkN3lwdnZWaG1aMFd5RWxCVkQzZlVLWHZy?=
 =?utf-8?B?UFE5ZnE1eUJyZjZ6R21XR2lrc3VEbWNqb05BQmhoYWxHek94MmZQaDVsZW5I?=
 =?utf-8?B?SWxjdUFPRzFEQzFFOHRaWDUxWE9DeDJVcWM4S1h6MDJ2Y0IydHFvS2t6L1A0?=
 =?utf-8?B?YWUzWVUzYkxVVEFCdU5iMGJTMnMwYXVoWUdTVDJLWFp1Nnk2M3lnTFEzT2RG?=
 =?utf-8?B?dDBMOVpkTzN2eWdkdThmcFdFd2tQeXBrakZjQnFmVDVnaTBFUEhTejB2a1ox?=
 =?utf-8?B?c1ZFWnFLOHNFMjVjTW1RdUhra2tRdTJpMVNSS0RBdkdtRXdsdThubW9Fa1N6?=
 =?utf-8?B?S1ZyenJoT1NtMUVsZkVKWjBpTXlBdFA4ZW10WlNIRjJqL1B1bXpNWEhvYU1p?=
 =?utf-8?B?Y3I0dDFJWTZFT3J5elIvaW1KTVNiLzVYVXdXMmRIVzRKeWx2N2NZSk04RFdW?=
 =?utf-8?B?NzQvU1ZLbjVBaFB1Wk8yTDFUMkpDWGc1ZFZIZmFTME9tSjM4MUVTZlZXRHhO?=
 =?utf-8?B?UjZuakFJUVVWY3Y4cWxFQ3dqVExNbGVuMTI2b1JDaHNGUXRTdUFMaUxCNG0v?=
 =?utf-8?B?MWdPTjNXRCtna1BvT1JxaVFZS08ya25BbnAySnN6R1c1dENWREZlN3VIaEhl?=
 =?utf-8?B?RG9UYk9hVjdvbEhxSU91aXlHUzdyemhKeVFSQWdJSXpZUFNEZ0w4VGRTOW5l?=
 =?utf-8?B?TVNCOFl4S3VnUmxEME80OE93d3lPaEN3TVJYVzZobmZ1dFkyMHhteTI1NW41?=
 =?utf-8?B?NmV4SnpiTlk2YTdCaGpnMldQdnJWVjBFVDJhVEZ5OXZqVkFUdy9OcHdRMEhI?=
 =?utf-8?B?Mmo5R0xDZE8wWnBnTmp3NEZBdmRnemEvKy9LNVF6YTE0SU9PaVhhcDJQYk9k?=
 =?utf-8?B?TFB2SmVLcnlVd3JrMDFFdVJEZ1ZIeWRHOW55Z1VDTVNUYktmV0R5WWc3aHE2?=
 =?utf-8?B?SEFsKzNibGNvL09uWktsbFNXZlN3cGpUTThiWk03bVBiNldtMDhGYTM1QnRp?=
 =?utf-8?B?ZWhscEl1UEs3cnBGVTJXUDZqTTBGODJjMk41cDZNdmh0K25FenZBamtuTEYw?=
 =?utf-8?B?OEtvMW9KWmxzRUJKZ2xJY2xaQUxBT0VtMjRkVE5PUFE2OHFLOW4zakhKRm1Y?=
 =?utf-8?B?YWljRXRTS0k4WkhlYXFYUG8zbW4yV1IyQWZwVk4vMmlvcEhxOUVnQzZWOVBP?=
 =?utf-8?B?WUZ0UVJnRGpYRjFpQWNLR3hYTGlkQkhNYU5jNElLRVkvWDNlWGNXa3VaUml3?=
 =?utf-8?B?M2RwYzRpNG02QWUwMU9QS2pBaEo5SERCRldMTkRZeSt5dmpBcXNTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66685E317559B340BA853D20D8C26A73@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bEa2FmEtfnv96EgBl7nNXN0Ul8ShpP5Art9OPDK+hvEucFvxqIaGspG14Rmbb5qJ8olP3MNbm4Ddn5t9TTtop5teHEZIRTVdHDx+S5+epd9H0aZmHVtzMLbNGjZeKJ/+C/vaKHH1C1sml9il3xEgoteqaFufkKUZUWCkI6XHXg7L8wslacRqEg60eeW4A3QnRMyrmAgCNbeHJESgFGwiSDAMTpoyjo2+RgLKH66yomB3KR5MhqW+XddHlcn/2gf8d5XtGa4JJxfR5SbkvZmomQMHBrLoJnusVWPuGma2razrz2X62GI2L5O++FMQd7tf6PchqHp/60nIMwmfOkKKbw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR18MB2669.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d576b5b-65a5-4cc6-ed54-08df14713370
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 04:07:33.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEy8o7Dj2hiNqpkdKRu4QaxIgWuNJ7pIidhW9EwFyoe/noasjyoXJvaqtMacj8XZNYZAhiEw43N29KObVg5DBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB3817
X-OriginatorOrg: amazon.com

PiBDb25zaWRlciB1c2luZyBBbGFuJ3MgYXBwcm9hY2ggYW5kIHN1cHBvcnQgQ09ORklHX0RFQlVH
X0lORk9fQlRGPW0NCg0KVGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbi4gV2XigJlsbCBleHBsb3Jl
IGhvdyB3ZSBjYW4gbWFrZSBDT05GSUdfREVCVUdfSU5GT19CVEY9bSBzdXBwb3J0YWJsZSBhbmQg
bWF5IHBvc3QgYSB2MiBwYXRjaCBsYXRlci4NCg0KQmVzdCwNCkpheQ0KDQrvu79PbiA5LzE2LzI2
LCA2OjU2IFBNLCAiQWxleGVpIFN0YXJvdm9pdG92IiA8YWxleGVpLnN0YXJvdm9pdG92QGdtYWls
LmNvbSA8bWFpbHRvOmFsZXhlaS5zdGFyb3ZvaXRvdkBnbWFpbC5jb20+PiB3cm90ZToNCg0KDQpD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
Y2FuIGNvbmZpcm0gdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KDQoN
Cg0KDQoNCg0KT24gVGh1LCBTZXAgMTcsIDIwMjYgYXQgMTI6MDIgQU0gSmF5IFdhbmcgPHdhbmph
eUBhbWF6b24uY29tIDxtYWlsdG86d2FuamF5QGFtYXpvbi5jb20+PiB3cm90ZToNCj4NCj4gQWRk
IGEgImJ0Zj1vZmYiIGVhcmx5IGJvb3QgcGFyYW1ldGVyLCBzaW1pbGFyIHRvIHRoZSBleGlzdGlu
ZyAic2VsaW51eD0wIg0KPiBwYXJhbWV0ZXIsIHNvIHVzZXJzIHdobyBkbyBub3Qgd2FudCBCVEYg
Y2FuIHR1cm4gaXQgb2ZmIGF0IGJvb3Q7IHRoZQ0KPiBzZWN0aW9uIGlzIHRoZW4gZnJlZWQgdG8g
c2F2ZSBtZW1vcnkuDQoNCg0KdGJoIEknbSBub3QgZXhjaXRlZCBhYm91dCBidGY9b2ZmLiBCVEYg
aXMgbm90IGRlYnVnIGluZm8gYW55bW9yZS4NCnNjaGVkX2V4dCwgYnBmLWxzbSAoc3lzdGVtZCB1
c2VzIGl0KSwgaGlkLWJwZiwgbW9zdCBvZiBiY2MvYnBmdHJhY2UNCnF1aWV0bHkgc3RvcCB3b3Jr
aW5nLCBhbmQgd2UnbGwgYmUgdGhlIG9uZXMgdHJpYWdpbmcgImxpYmJwZjogZmFpbGVkDQp0byBm
aW5kIHZhbGlkIGtlcm5lbCBCVEYiIHJlcG9ydHMgZnJvbSBwZW9wbGUgd2hvIGNvcHktcGFzdGVk
IGENCiJzYXZlIDVNQiIgdHVuaW5nIGd1aWRlLg0KVGhpcyBuZWVkcyBtb3JlIHRob3VnaHQuDQoN
Cg0KPiAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IHwgMTQgKysrDQo+IGFy
Y2gvYXJtNjQvbW0vbW11LmMgfCAxMDggKysrKysrKysrKysrKysrKystDQo+IGFyY2gveDg2L21t
L2luaXRfNjQuYyB8IDMwICsrKysrDQo+IGFyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgfCAy
OCArKysrLQ0KPiBpbmNsdWRlL2xpbnV4L2J0Zi5oIHwgOSArKw0KPiBrZXJuZWwvYnBmL2J0Zi5j
IHwgNTEgKysrKysrKystDQo+IGtlcm5lbC9icGYvc3lzZnNfYnRmLmMNCnwgNyArKw0KPiBrZXJu
ZWwvYnBmL3ZlcmlmaWVyLmMgfCAyICstDQoNCg0KVGhpcyBkb2Vzbid0IGFwcGx5IHRvIGJwZi1u
ZXh0Lg0KQ29uc2lkZXIgdXNpbmcgQWxhbidzIGFwcHJvYWNoIGFuZCBzdXBwb3J0IENPTkZJR19E
RUJVR19JTkZPX0JURj1tDQoNCg0KcHctYm90OiBjcg0KDQoNCg0K
