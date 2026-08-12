Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADE360EE1;
	Wed, 12 Aug 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563290; cv=fail; b=H4Ltu+9Mbh5vtDI/taY2mUOmlQO0AQRV0NXFntQhnUhDO554SmClhYvIhyOJEc9XBZcEQAeWBVKghje1q25BjXdcI5rleuJX2R5o86jRcQuaG9mQrcDKCRbyxbQt36TXN4KBxBx5FJQ3nyGYf+Q+D0RqD0R3DlzcA2FIbMr5bgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563290; c=relaxed/simple;
	bh=zK/f3cfsFQPtwhNNZ5bINhcySxKw8K2BLVrDNL5tsjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bas6TLOS7HqSs4YHvm6P1RJ1P7v5BtTxMsBIyATs/hX7HZJtz9iFGKz2bMvNXopMAHO1//oTr7Mzgv58tTLev9q4y1YlduUZq6BQK4gyC9RGLXlv71U6+1J/0Aa7rRjri/aNVNjke5Ut59VK7dvzeRyMfb48UOAsEoWCmp0y2j0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfzwLUAO; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfzwLUAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786563288; x=1818099288;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zK/f3cfsFQPtwhNNZ5bINhcySxKw8K2BLVrDNL5tsjY=;
  b=TfzwLUAOjItp62gWXUdZtqw/pKygda7Za74DcfcYCTxZv5TGJRuJaEpk
   WOSotifVejuQLcLngqtsvt6BII9jDGB/NffC0UFeG0pwy5EhQb1OyAb1Y
   j6ia68g/xQDezxJZiKGUpHe4GRW3i8gh07yVGQv5FBgLC6yrRUHp4MnnG
   urmOZDHT5oEGJVne11KEHbr3zaWnkz6Yd1WMZt8UoSLeFbEGBuLQ/XFSB
   duofikgRlavpK1T9iSk+JweiPT3eIlODiEXXlS40x3CAOTJ9DsJPV8/No
   e/DNQZMvMkhf5t/PSiJ7PwEXqA0tvsZi06BN9Yx3kJwJ3iLykm9HKJb3f
   A==;
X-CSE-ConnectionGUID: o4YOxWenQBC2OeaVrZsOvA==
X-CSE-MsgGUID: ymlAgVYLSiO0n/Zo5o1Sjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97476756"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="97476756"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 12:34:47 -0700
X-CSE-ConnectionGUID: 9LBE6EfxS2SKdpyrJktr+w==
X-CSE-MsgGUID: wGGY9xFiS4G3mZYld+n1sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="293671356"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 12:34:48 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 12:34:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 12:34:46 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.26) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 12:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFJ/HoQXlXM4sPUxJ0ilQW8/ek4Avh/T9inDFbZ9C2PdNrHH2bEP2HOqc6MinTsEW6iCSdPUz+FJB/vM9EZVBmv8NSOIXX82QVPC2YVu5IRlRfg4v8MRmN0p9rXHlWa3/TQmkV4xwt8ZcW8TuA/KXy/GidOqHb2OanVw+ShQEs6aWokcM8aTwcKSW2NUjHcr1SzgsZ1zd/m/Tq+Kw/Ppfm4Ihh0IFbZBg2CcV9mGzmzU5/GsFxxrONzcF0eMqfK3/RF9z77/psY7CR4LgndL51nYHaTlHeFzVqJZ0ykebLPd039qZVUazMvCn52bnZqOdx2eBdFBPGVVp9nACIo1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zK/f3cfsFQPtwhNNZ5bINhcySxKw8K2BLVrDNL5tsjY=;
 b=L+KyMQPODaFd3nl78oanmscQS46P2gx+CwM8ERn8cFsVaEJ5lIwyG+Wh6kUM+v1xL2Rpwp0Sl0dfpx2B31HBBXHImUNP9nJaYHZ14dQpnvjfHX9WYnJmfnZIKn55bPZheYBPS+bE53pb55zn8TYrmiIRsqXa92IStIgXr8ATxCmt2MHWX15m/xTuGHbZMu056VuCmGjrsnsdOlI7l5SDl/SnQaR2j6Sx/uMbuE2l9QtYzCaXjSBCgK9UKhKYReQJxhgAoyPuUGRKZDAw38gwIsq9YBWeR2t5PMg/huSMzee868wCRZPBDlRS3xzwuNhzoY9GgGiS+5IEzGluLNSfMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6771.namprd11.prod.outlook.com (2603:10b6:510:1b5::20)
 by LVUPR11MB9785.namprd11.prod.outlook.com (2603:10b6:408:39c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 19:34:44 +0000
Received: from PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4]) by PH7PR11MB6771.namprd11.prod.outlook.com
 ([fe80::effa:162e:c9c9:a1b4%4]) with mapi id 15.21.0315.014; Wed, 12 Aug 2026
 19:34:44 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "shuah@kernel.org" <shuah@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"pjw@kernel.org" <pjw@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "x86@kernel.org" <x86@kernel.org>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "bill.roberts@arm.com"
	<bill.roberts@arm.com>, "alex@ghiti.fr" <alex@ghiti.fr>, "tglx@kernel.org"
	<tglx@kernel.org>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] selftests/x86: add generic prctl shadow stack test
Thread-Topic: [PATCH v2 2/2] selftests/x86: add generic prctl shadow stack
 test
Thread-Index: AQHdKn7SE+Xr2vVKf0C3DnrhuX9GuraatLkAgAAIkICAAA+hgIAAAVeA
Date: Wed, 12 Aug 2026 19:34:44 +0000
Message-ID: <6c130a2aefff7d5d0b455ddb1ce05cc369d5cfb2.camel@intel.com>
References: <20260812171940.1046116-1-bill.roberts@arm.com>
	 <20260812171940.1046116-2-bill.roberts@arm.com>
	 <c5d5c26c-eaa3-4fd3-891b-808b6efe3c25@arm.com>
	 <ca8465e2e006d31a4fc728707cb679f25a3fa7f2.camel@intel.com>
	 <b8c6b70c-4718-45d9-bd08-a837599868d4@arm.com>
In-Reply-To: <b8c6b70c-4718-45d9-bd08-a837599868d4@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6771:EE_|LVUPR11MB9785:EE_
x-ms-office365-filtering-correlation-id: d33e938c-c177-4267-0002-08def8a8c2d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|56012099006|11063799006|10067099003|22082099003|18002099003|4143699003|38070700021|921020;
x-microsoft-antispam-message-info: 15IOO5cDOXj9HHylXSM1QZJG9P4NUaOGOBnX5arzVEIMDJcWgbPtxDQUGMirnntYk0AdLHx0dRz31xdnhrxRHcwkT0DAERlhEKtUCHU0YZdtcuDtC3PVmgJG9zu05dZmgwJpTVVbpL5V+zQQ5n5RnNd/2bUd+fQjwj6r4q7r96sfueFaUX1/LhJHpS4yMzGEbzvMZCvwDeRnFO4wz0/mvXdVK7coFJNhQ+aKiYW61Jard+EY2XAI7krE2lQxBWgGJR7dE4dY0CHiWfEvu+bzakuutct2opO5rYIZzvA3N4tRkhyGrDH8xtEDEkvyABNJ3CC3GXmc1KAJm0TTf8z8AOKJvqlVeIudTcEprr208JB1+KG11/hA6zDtkVVqcst0M3g0XrKrfmwNlSsuWdLWHVppu8ptYhvJ1/pbSvQ+DJWPyad4fHxVRQZ0Xo9RN73QLuytoUqVFLoLXujYhgPBNHZVc+JfKAdNELL9C+HGPCMv+N/OCsXv3wNO5QJ5X1/RD1mS/SqZwmyLRyFdtXILyJp7dGLTE3nXsfDhCaf52bOZSdtTbmcB07OBcb/OYGJQANCZdl/i1H3a5rhMKD5NTkS+urSqw0FInDtubartZFZ4zDBTlZbJo+PBknMJMVICNMyI0fitmwsO9dXeq4i/2kWc67QzQBybjYrn64XHbpmzf/oaRa38iRmpC0a4hxqKNEPkjbbs3cgCkKrW2zGXeRzPMl9ZyKhdP3SYUTF0D9LC1eM4pa9F2DhWTi5Ag3+X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(4143699003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a01YcHI4VmZnQ3Jic2JZVVJNdmFmTlJ6YXVLeEZGN0xiME51YlMxdG5IQnZW?=
 =?utf-8?B?a2lNQ0dnaEs1WVc5dUVPOFdGblEyUFZQc2ZWb3VQVDl0d3k0NXhUWGtvZHVV?=
 =?utf-8?B?UkppekZRQzhTaElIbFowV3RhRVVTeUsvWWlSSVhWQ3laWjFTb2lQS3VZOWJK?=
 =?utf-8?B?SUpWWEUrL0tOcWhlNGk0UE9TRDhOZFFLQUh2aFI0Mk5Zc0pwOUZHaEJoYkVi?=
 =?utf-8?B?cndKRTVjNmhaNlh2b3JYaUJLU1Z6Yyt6SEEraWJpeFJXV0lkN0lScWhTeUVu?=
 =?utf-8?B?OHhpMnYzZnFaVFZncWQ3d2krQU51d2QyY2J5WGR4Q3lVMlZCT21tcm5SN0VO?=
 =?utf-8?B?bURsbVZIQnRxbFdLT3BYc0pCK0NyVVd1R0tMVDk3SmJydTk3YTlhVkh4WHd3?=
 =?utf-8?B?RnJsazlrNEM1RUJyVEFkYktYZ2lDT0dUSVQyQjNaRVhxTy8ycUx6QXA2V0pQ?=
 =?utf-8?B?c1QzaDhpbXJSQ1ZQRHB3cHVoSHRHRlN3d3ZvRUxHTERLNGQyclpXcmhHemV4?=
 =?utf-8?B?V1loMkE2VWEwTzhmbXhpWGNjRlhaek5rbFFQSzNlL3F5bVlsNk5EZ0w1dEor?=
 =?utf-8?B?SUlES20zT1VYNThHRE9PeTR2a29jMERUZUh6dUZkekQ2N05vaVVidTJpRTBL?=
 =?utf-8?B?S1BzanBoM2tBYVZsM2tkVXlnRkdFa3A3RmhrMUo4N0lSWG5mOWtkTVMyZmEw?=
 =?utf-8?B?bXdNR1UraXlwY3ZiSTFoMDVJTzk3THc0QWFxTi9KalQ4cTlBWXljdk9iLzdw?=
 =?utf-8?B?K28xSEU3ZFRPSkc2VVo0VGJOdlhlZk96QXZHazd0eUxMakdyaU9pVjFpSURq?=
 =?utf-8?B?OEsybkhkaDUvTzZWbXJYRXZwVVM2TzJ6ZkJIUTlzMHVhd21WWmhrMVlFQVJk?=
 =?utf-8?B?Qi9pNW9YR3VQcXhidmp1Z2JiQkxqNnMvMnh1eVlWaDNkVExVQ3lKZTk4VWlk?=
 =?utf-8?B?UGZBd3BZTUpnNUFhY084OXZ4d200SUp1WUNGZWF6SStuOVRlOU0rTXk3QUlk?=
 =?utf-8?B?Y043MmZmZHhESjNENU9WRGg5Ym1TQWk3NTBFWnRURHdVOURqNnd0T0xpSE9x?=
 =?utf-8?B?ZWtIUEQ5N1FKSmdmbkErRE8yeGhFTEJlajVCSUd3OFJnN2pteGYyYkdTOUVF?=
 =?utf-8?B?clA5ZXNqY1NkZVNnaXBlWmhYMmF1VmNKKzdPcGdPQ2czWFhoQlZ0QnRSdVlk?=
 =?utf-8?B?Q25DYTc5YmtWejBkUkp1Y0IybkwyT3dDbjQzRzRac1EyMHpQTURBU2hDbXBU?=
 =?utf-8?B?cFdVSDFmWndkZWpGVDZOZC9RZGVmMGlIUHYwdkVqUDkrTTBRVlBqS3hiRDJE?=
 =?utf-8?B?S0RKQm5JUVloRjJ3UXZpZFVLTHdZa0F5T1l2TEwvM2VrU0NhM1BMUkQrR2g4?=
 =?utf-8?B?Uit0MWpaajg3S3BLUTQvWnZ0eU5QZkFaQjN5Nk1zT1c2OUxBeldXTVMwT2hF?=
 =?utf-8?B?YTFQMTdBNVNzUWdmOWdNT1ZWZ25WWTJtMjVSUWtiSGFCd0ZZSHVhcHBuanFI?=
 =?utf-8?B?MWw5dzd3T1VGSzl4ZmVVd2crRzZEQzBMbnI3ancxTmZiai9VQUxJcnYzZlFh?=
 =?utf-8?B?OEZRVzB5S1dZRE04UnU0dXNHMW9uWUdNWDdMNDBIWTZrMkUwRitGV3BPTnFr?=
 =?utf-8?B?Q2VOMFgrbWVsbEo0TGREeEZHUjF6QW53VGMzRmwvNU53N1pDTUdzaFV1K2dn?=
 =?utf-8?B?QzU3aTl6NjY1QlErYUZzcG4xbUoxVDFucDZmSFFsY3RNcFliQWRsUEJiMWxo?=
 =?utf-8?B?WXpOb1pkdHUyZW9Dd2dKVHlYYm1jTE4rcDZkS1J4bkQ5RjVpWHp5dCtTKzYw?=
 =?utf-8?B?M2tqNUhUYllqR2VoZngyNmJabDZYUGxJbDViZlFIU0JrZGJYS0RkVmxadER2?=
 =?utf-8?B?RGYvcmE0SFRmUFYxNDJrRU1TcC9VU3o3K0FPTi9FLzRYTXk2Y1o0MytWRFMz?=
 =?utf-8?B?VVdrRCtYVEZNcjlXT2RFdFd3UDJoSTZLZlhiUkZNVU04eVM5NUtvUWc4ME1M?=
 =?utf-8?B?dk1nLzE2WC8vREdNVTJ3RnZWTnZHMmEwQVllcDdpbHJGTjN0QlNxMUJad29s?=
 =?utf-8?B?NG5MMlIzNUNrZFJRVkFTRkN6V0c0NkN4V21ZTUdXb2lZaFA0SVM4cVdZSmRy?=
 =?utf-8?B?clpIUitQTTc4WDYweklwYUdtT1orUiszd0MvUmovcjV1bW5JeDdqWEtOeFlW?=
 =?utf-8?B?VC9NWStsLytqMjhLMElMOWVhN1kzS1JPbGEwK1A3QjlRNEE2UkdWVldmS2lE?=
 =?utf-8?B?Z2ZRczdrV2QwN2hDSTJjTGVYL3ZYUlpXczFQcUhrUmFlTVRCalRvYU4xMGQw?=
 =?utf-8?B?cUIzVnF5NGowUjkrOXFiUCtZTExMcks1WnZqRklEVGZaOWVFWUp4akFzNll5?=
 =?utf-8?Q?PXTgzH364eyUN8Hk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EBD53EEE80B68419BA267C92BB43B56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Omlb4AueHbQWmBXynviy7Z1vXlIIVR38qpVUrsM8r/JwBq2YLr9KtwySWN/Y1MLvso6Pq4Kz8JZ3RFiaCUyGSoxOc2EyJaEG8vlm2k3pNmq36H/jqLfP/YYnZeTI3z0k0pobrjd5sffolm76ijovBokP8dz6Dn3vNGu3vqvlBQHBFljJm9Q+gdxFAZN72oGOcEkRmwUjyiIpbNqjMmFOmYE3pmGDBP79IBwNKml6CFAMwE4DPKO7epVg+SutaoGCaj9zoywsgO0NTHG8lOSvUYkYknYJmw4Jh3mdIW2uNwxZs+TeQ8Ycz6NFPKbqG6RgfGX3XHjnW+l1d2Rb1vCymg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33e938c-c177-4267-0002-08def8a8c2d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 19:34:44.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AowUoF2X4rdDuUwGFC+H9K8h7D2S0QdCzixGohLhe82EM6Rv6tYtZ2y6bY6tz856CNStGnk2SSsnTZndo0Bw/okHaTDaqi0I0/pM4gEQCUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9785
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDE0OjI5IC0wNTAwLCBCaWxsIFJvYmVydHMgd3JvdGU6DQo+
ID4gT24gV2VkLCAyMDI2LTA4LTEyIGF0IDEzOjAzIC0wNTAwLCBCaWxsIFJvYmVydHMgd3JvdGU6
DQo+ID4gPiA+ICt9DQo+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gTmFjaydpbmcgbXkgb3du
IHBhdGNoLCBTYXNoaWtvIGZvdW5kIGEgZmV3IHVzZWZ1bCB0aGluZ3MgdG8gZml4Lg0KPiA+IFBs
ZWFzZSB0cmltIHRoZSBtYWlscy4gVGhhdCB3YXMgYSBsb3Qgb2YgcXVvdGUgdG8gc2VhcmNoIHRo
cm91Z2guDQo+ID4gDQo+IFNvcnJ5IGVhY2ggb2YgdGhlIG1hbnkgY29tbXVuaXRpZXMgYWNyb3Nz
IG15IHdvcmxkIHdhbnQgaXQgZGlmZmVyZW50bHkuLi4NCj4gDQo+IEJ1dCwgSSB3b3VsZCB0YWtl
IGEgcmV2aWV3IHdoaWxlIEkgcmUtc3BpbiBwYXRjaCB2My4gSSBhbSBnb2luZyB0byBhZGQgDQo+
IGdldCBzdGF0dXMgYW5kIGxvY2sgdGVzdHMNCj4gdG8gY292ZXIgdGhvc2UgY2FzZXMgYXMgd2Vs
bCBhcyBmaXggdGhlIHNwZWxsaW5nIG1pc3Rha2UgaW4gcGF0Y2ggMidzIA0KPiBjb21taXQgbWVz
c2FnZSwgImNvbnNpc3RlbnkiLg0KPiBBcyB3ZWxsIGFzIGZpeCB0aGUgZm9yayBidWcgd2hlcmUg
LTEgY2FuIGJlIHVzZWQgaW4ga2lsbCBhbmQgc2VuZCB0aGUgDQo+IHNpZ25hbCB0byBldmVyeXRo
aW5nLg0KDQpPaCEgVGhlcmUgaXMgYW4gZXhpc3RpbmcgaXNzdWUuIFRoYW5rcyBpbiBhZHZhbmNl
Lg0K
