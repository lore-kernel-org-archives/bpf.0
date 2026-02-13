Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1423EA83
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771009048; cv=fail; b=DzQIShTlR1p+uaeYEmHYYCjslvgnXl5oZ3GfpM1xpQMoakyvzR5KRMVvfjF9WBtr+FmK6HcgmeqNNjkpMyiw0kkBGJNtUpG5QaqGivTAjOwF4BBNNdqvbbSIlVl1vgpf2+afLN2zGiaCbGeabkVyscSGNEjmeVh7+1AP9R/hyRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771009048; c=relaxed/simple;
	bh=ZA0M6Y6X+hB2Llvc8tkgQ77MTlDphZ2dkmXaB3E0gtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H0Rt1qPlfVxScQWFlLY0LIorquHTUyRHa/iULJJd4T40s3e2uNqsZVCKuKHQoEOUxDASboYbnrKfhfAL6CMEfO/e6fuyoIUUT2Sjv2JmrI2UZay9GLTFEdSrQ5RyiIDDsK2/GFj/bTlltQntnB6Yyq2B6/AIamcfQOD31pkbUP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=By75hB0f; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="By75hB0f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaZWT31qalDiiBnVJvK1pwZvJeDG1R2o+mgsdvm7qtKacS8K49wQwvmMEfHxMPrOT+IeJKt4f4WLIT0PO7LrUZVjmunmr6ddFjWefkt2HacMeotNTiiOPs1+zwmWwcF49MHwfBrcf34uvJ83umO+96K+0/HOO42iVa2A5zcVlYlrIFYnh+IKuAADluUUOBWqnG19DJbVmjpDD6lLwPXD9HQF+htYSxTj0TXL4yEPsKTphpBRgHAOCDbi6wMe+Fp9hWyYTq0Dfb68MCgF9IuBAKjT9t00UioJ+DKh7bY+0BAxzAzWsoZd2+ulHVLONZBrQ4M7Q8JM53RvhS3pmGthag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBn+HO34+X13fGV063QZi2/wdY4lHxYT9m8mWQL5vLg=;
 b=d9bTCxLvo5F9STvFD+zah3mt100BH3XG5NsEv9GNISp/py7YscVYE2DELYC3Q9zUyUyap6pupI/AjdXfvuxy3+me9fKI/YoJ4Ko13LqrvHg8e6FzgfzDB0l2O8hEtYEjH6F8plbjjltirCnUaouEinNr/tUjDHsplNBUZlULcgZXqWaVDQbMQ108jb1tNypuD+2BldTSZkMY6JI7S9UKbcEdJ8jk5YfeUCXj7unSm37iXCOXotK2qCWU089iGqu2pPHhjaspVJg8d05y8W+zQQwgoRD0Tlx8yNs8AUq26fmTlUBNZ/QwLAir2xIV+Rm5dBCSeGwsmtgWdWy0KMIG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBn+HO34+X13fGV063QZi2/wdY4lHxYT9m8mWQL5vLg=;
 b=By75hB0f5SMzg37cwBkHg/Pc5889FqJg6UHcSjtcuu27A/lJRtTh6HsJ17stcQILm5EY6zUDaseVVYsFcP90w7pJtTc87658qm3HAjho2UHRHJ9YMj/UK3lupcQw9l0Hhx4x4awS40a0AMG79Vu+GgOY0pvgS9x5HOYno0tc4A/E/uULAN53jkRw6dwaK7R9tkBRflBdq54r3x0PGtg6wi+mUrDr3UlcndI8B7PU6SThXnIOJM67IDw3rb46ckasH31w5GihG1Yh0yYAPrU2Y3tH/naU/5p3aqoQyOst2CGNtJ5NGwt8lEejvtGVaj43zDQuP9ET5FYuIP5IaU3xsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6811.namprd12.prod.outlook.com (2603:10b6:510:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 18:57:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9611.013; Fri, 13 Feb 2026
 18:57:21 +0000
Date: Fri, 13 Feb 2026 19:57:14 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Changwoo Min <changwoo@igalia.com>, David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v1] selftests/sched_ext: Fix rt_stall flaky failure
Message-ID: <aY90Cva68Tyoo1nr@gpd4>
References: <20260213182136.1388270-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260213182136.1388270-1-ihor.solodrai@linux.dev>
X-ClientProxiedBy: MI1P293CA0025.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: 107a5dac-5265-4229-e875-08de6b31b753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2tPQTdVb3dIL05lbE1HVndxdUFHbldkK1hueWdQd2VzSHJWakIvUUpCQnVV?=
 =?utf-8?B?TGdiTnBHT0tOR2JyZFpuRlNnY0NBRDNRMlZuekhUREpaMklvUFVKWkdobXlF?=
 =?utf-8?B?NE1LL21EYlJ6QitaVlQyYVRLMERUQndYS0x6V2lYVGJRTkFybjR6dFVDR1Ry?=
 =?utf-8?B?cDU2TVJURVIwQXo5Nm5GMzJKSWtFNU1wbERPWEZySXIzbWM3YnZpSUZTeWlx?=
 =?utf-8?B?QVkzU0N0cWREOWFuM0FQckdJcGdzT3NacDFMZVJtZ3hRZ0QvcHNVcDZ1cEIr?=
 =?utf-8?B?RHBsZFZLR2IvSXhnN2Z1MHl1VTgyUGl6RzR3UHM3ZHlVb3lNL3RsU205Qlhv?=
 =?utf-8?B?UmVjejFJeGN6TmNYODNsY1crN1JUMVdtRXJZK1VjSmU4aG5keC96QnZPWWNm?=
 =?utf-8?B?a1RlT2MxVkp2OURpY2oxL1RuTS9OTlhDcGorNEVEdnkrb3ZTWnVZNnRLZEZO?=
 =?utf-8?B?OWxhYjdVWnpoTGpRczZWWmwvTlhaNTJ5MjczVEZsTjdXQjBoZHhLTG9lbHhZ?=
 =?utf-8?B?UlhZN2ZQMkxSc1Q0Q2FrL1lRdXRiSWtIanBwY0prOENDK0hBMlpyd0JhK3JS?=
 =?utf-8?B?VGpldG9OVS9OWEhqSjA3akdNTDBCd2JBRUYrMDFSNEt1UmRkU3cvL1pxTWFB?=
 =?utf-8?B?MWdvV1lxbGV3dGdBNDlWOXhIRVdKNDhxdDY5anliUm5yaURmckJTdW1uZG5m?=
 =?utf-8?B?WHdQY0dUQ2ZpSDJWaFNEbU80YUt3Y2pBTTFzNldkRlk0dXpDVXBaL1E2Nmc5?=
 =?utf-8?B?ZCtqWmZyOERIbiswUUwzNmh1ZHl3TXhYdHlsL2M0SjVQSTdjQlVjTzVwc2Vw?=
 =?utf-8?B?bTZzMStWZEtnZ0kyWUlKL0J1eHFXYjV5c3JULzRIMVdjY1RxNWtoVllKRGpz?=
 =?utf-8?B?N3FBQnVXY0pudzluTC9QaVhxQ3dqa3ZCZ0JsOW5MVGxpeWUyb0V0bGRlb1Uw?=
 =?utf-8?B?K0Z5bjVTSWpwdXR4elUwQWlkeGRaOFkzdEdlYk1IQzc4OUZ1bko3cjlGTGJ2?=
 =?utf-8?B?aldBZlhkV1NFNVNMU2greE16cjU0NVlWK1h5ZlBEZjE0amNpQmRMMmtXOURP?=
 =?utf-8?B?UVhOak1iOVAvUVdYbUJSVnFkQnJia1FkVHBoMlpNbDFDcXJSMHhIUWYvYmUz?=
 =?utf-8?B?UUJxUm1EZFVpTGR4KzZ0NTg0RW92Qjl1MTBLQVVETmdiVUVpVW9kNTZzeGty?=
 =?utf-8?B?blEwZnlRRGVMV2hRU01tN3UyZy8wd3dyWGZkMnZobjRIb1YyeCtKMjB0WmFH?=
 =?utf-8?B?WEYzQUhpd1RNTnFOS3VqMlJWcnRtTXhNNEVZSXBTaDUvRmNrVXFEVXlONFpD?=
 =?utf-8?B?V012Q3NMZ2V2SzVBYXNaTzBGTVVTWjNNdng1T24xMm1zWXpMSlBrS3M0ZnpT?=
 =?utf-8?B?UzRuZURSTnUwUzZPdDJTc2xpQ20zZHg5bkFiKzZsY1VPNmN5NS9BL0JTbDZa?=
 =?utf-8?B?VmJkVXhLekJuaDFNajhjeWJmVEZURXZDZExEMGM2cW1RNU54b0REN0Z4L09W?=
 =?utf-8?B?TExmUTYxY1NGR0ExV0NsOGtnRnBOM3RUZDZSNnVSSVlpRklYS0VCcUl5Slpq?=
 =?utf-8?B?UDJaK05rZUd0M1BKd2RCeHdsM25YdEt0Skt5dHhJVHJGZngyalFyQWUzZTVP?=
 =?utf-8?B?VDNZdzZDNy9EbEVjZlFTUzRBQmNZd3JWSHVSV05DdkVXTS9SU0VIWDhhcExC?=
 =?utf-8?B?UVRWcmNORkZvNDFzOXNvYlJ0Tklvb3FiOHc0Vnl3clFiNWtjbFh5aG1zMVdQ?=
 =?utf-8?B?UnNnQWhKWmdRcE8wbERwZ1VVMlpUUlhFdVNoeURHL2dWQXNXcStMcTkxMUV4?=
 =?utf-8?B?VHZFek9DL3lRSG5KNk5iRFF3d3pXMURXMDl4aU1QSWx1NGdJRGJiNENBQzNn?=
 =?utf-8?B?TktlZ2tRKzBqK2JmR2NMclllTlhDNyt3U3liYnJDWUpaZUJpckFYZDRhSlZk?=
 =?utf-8?B?TTBJWFhWcnlqamtOYmRVdG1hbE1vdTgzam9zS21WRzZ3bzRvQ29UZGpVeXor?=
 =?utf-8?B?b0t0RjA5eFhsdzAxL3F5TEZJbTV1bDBUL3lINDRIYlkzSEVsaDhaTk1ab1Jt?=
 =?utf-8?B?S1dJQ1FYVk5lRitjSFpQaFlyYnU1QTlvZHRBLzMvSmVsaUt3RGlYR1diVmc2?=
 =?utf-8?Q?2hO8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnMreHdCRzdqWThrYUoyK3cyUlFFd3MxTTNNZHQwSGQ3T0k4V3VVdmJxY1RS?=
 =?utf-8?B?NXJhNTQ4akV4SHN3TUFpMXYvUDlXZ0RJOWZJNmJWMFMxYWhRcnpnK2dWdVFz?=
 =?utf-8?B?dU9ONlVSU25uY3g5d2pqbXB0blJ5bTZqOXE0ZFB1UWROdWV2WW9SM2YydW1o?=
 =?utf-8?B?cW9tVEVtaXlFa3hkbXdCeWw1TWgxdWNhK2dwVkxUenlOaGZRUlE0ZnJTb01S?=
 =?utf-8?B?ZzVMQjZjb0g0dmROck9wa00rdDRzNWNyUGdubkM4Rk1tMVJRYXFsQjR5bm10?=
 =?utf-8?B?QUtBUTlRUzkrZENDdXlROFZNa2JtK3V3L2RPa3MzN1NuKzJEdFVjL3gydUQ5?=
 =?utf-8?B?cS9rOHRoOWtuOGIzVkhwVzVGMXpEM3Nzay9RMG54R2xOOC81NHE1UVZEa2tt?=
 =?utf-8?B?REpTQk84TmlaRms4dGFEVHM0Szg3R3VWZFM1ZTBpemxMR2tqMXFUUnhlWWZ5?=
 =?utf-8?B?N3I0azNWc2xEei8xY1Z0Q0VzclUxM1FKS0FSUlJXMHA3THVVaExZQzVwaXRJ?=
 =?utf-8?B?VmpRZ1lYby91UFppcUhpUm5OVXRTUVVZcXhjYUkzekkwbXVnaHdSUmlqQ2Jn?=
 =?utf-8?B?QlU1MTZkbHFPbDA2WjBmL1JXNlQ1TnZFa1I3cEtJWkZVVHlaTk5YMnVmeU5Y?=
 =?utf-8?B?Qm9FVVRTTzNkUUtFWDJBZ1BmMVd6bTZZVnNOazBhZVA3TVh3VDhsNU9vNGsy?=
 =?utf-8?B?M0dzTFdHd0wyUWtmUkFaNm9HYysyRG9UNklHNEJ4SHhBT0tLdnVGNWZMZEpm?=
 =?utf-8?B?Z3E3eDFKVGhncERydldIbVRFTWxWMTRwMXRhcHMvejE1SkRnM1VKM0dvM0hV?=
 =?utf-8?B?YjdlZlRuK2ZjSHk3RzNmbDlSRmxEZld6YkwyakduUzJvQkxmTnZueEJ3b0Rv?=
 =?utf-8?B?VU9rdWNmeW5WN0F0cHFCWnhkYXQ1b3BvdktRaHRlVnRkbFZSREZJVU5rU014?=
 =?utf-8?B?MlN5MVVOUHhNVFB2WmtwUHNBTUFtSExLYjg2QmpCd0E3OGUwNDFEOXRRaytK?=
 =?utf-8?B?bkFiVlpVQW1FM3V3N3l1cC9lU0paVUh3QWlkWW9iTndRWGhJRmxuYi9zNUlN?=
 =?utf-8?B?QW9zVno2UlJ3Wm1yalh3b1o5N0pUS05Tbzd6dkFUbHlIMGxYTWw3dU9FTGps?=
 =?utf-8?B?YStod1FzTkFYNnpLWkVLS1NtSE52bGtINlgzRDV6dzVIaGw0cEM2T0tZNkFs?=
 =?utf-8?B?OTF6a2E1UE40Mk43QlBiamE0QlBPb25xWnpKNGlXMjdjT3VIajVIYk5uVGFy?=
 =?utf-8?B?c080c3U3YWJncXBwa08ydXFIYnJaNDRQWmpnWTg0d1paMjhDLytpMXdySUox?=
 =?utf-8?B?QWN1VlRMY1l2L0M1MGhhdGNnbStSSnkvZEJqSGpDQ2hCTzJyV0pHeDZ2aWlp?=
 =?utf-8?B?SXcwa0hYeXpjY1pSdzl5UzE5dWNBYW1CUmpzZGNJWkNtcU9HUkI2cnkzUms3?=
 =?utf-8?B?bk1UVVZsbjh1NVFWdVRkZldua3IrdkR1c09zSFJndTg1Wlp6aG5XQzU1ekM1?=
 =?utf-8?B?UmJVMmNTQjRSaEM4eTVjWEJwZ1g5dEV6OENGUlU4R3Q0bzZGalpHV00rK1Fk?=
 =?utf-8?B?V1FCaE4rMjl1bDhCL2FBeXdPSVdRNk1PdkZLcnlhTXptRS9UVXFhRWRodlp0?=
 =?utf-8?B?aWJGVnJXc2JSdnZXUlF2aWFBOGwyZ1A1NUgrenVtbWdQYnZraGdvTnl1ZWFy?=
 =?utf-8?B?ZmxRbmJ5ZUdvdnZxTHJsbTMycFB3MEF1UlhQaHN6cjlrQ3RJN1ZwWGNnK1RX?=
 =?utf-8?B?UGpWZ1VUY2drUllob0lWZDVQWTlVRCsrNU9CZytRKyt3MFdpUGtlaG1uejE1?=
 =?utf-8?B?MWJtbFh6dDFPTXpnZUNhU1hZSENvRmpOcnlPQ2g3NlVIbFRSMEdxa24yNWJr?=
 =?utf-8?B?MnJnQW9ER3dNZElrMWFNRVJ1M2pRdERhU2xUSU5rQnJWanA0b2JDTHRORzNh?=
 =?utf-8?B?NHMyV2VFc3VYRGxvemV5R09lMjVrbjRPOXFiRHIvMVlPUk5Wc1Y3Y0hraElF?=
 =?utf-8?B?Vkg0K3hIYWlvNWZIdlRkSGxGdmpPeEJqWWhRUW5PRy9xeEE4VTlMWEs1VlMv?=
 =?utf-8?B?UHo5c0VuOW9Ua0tmQ01sLzRRNU5hcVhCYllNamU4YXExNjE2anQxcTFXekJD?=
 =?utf-8?B?emwwcEIvcUlDMmNTUU15M2ovTFpRR1hiVWpTOWdFRWpudXE5ZG1QWndyYytU?=
 =?utf-8?B?VmJRK29sNDRTWDFncldnNnBDc0U0TkJHUWtQTGliOC9qTi9WRHJrcnhDZFNL?=
 =?utf-8?B?YkNOVXhoc1NEbDZvODBQZ2t6RThWMFJ2NUhPZzR6UGNFMDVZZmFqVGh2aWFN?=
 =?utf-8?Q?rgZk7By7iyW4soEe0B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107a5dac-5265-4229-e875-08de6b31b753
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 18:57:21.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtSX8HtEjy8kmdTzO2yhyCnHAXOovE/xj+34RLoChDx1LfAKGvjbbvV0cuthhPaY04P6HppTGPDP5OpIm8kCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6811

Hi Ihor,

On Fri, Feb 13, 2026 at 10:21:36AM -0800, Ihor Solodrai wrote:
> The rt_stall test measures the runtime ratio between an EXT and an RT
> task pinned to the same CPU, verifying that the deadline server prevents
> RT tasks from starving SCHED_EXT tasks. It expects the EXT task to get
> at least 4% of CPU time.
> 
> The test is flaky because sched_stress_test() calls sleep(RUN_TIME)
> immediately after fork(), without waiting for the RT child to complete
> its setup (set_affinity + set_sched). If the RT child experiences
> scheduling latency before completing setup, that delay eats into the
> measurement window: the RT child runs for less than RUN_TIME seconds,
> and the EXT task's measured ratio drops below the 4% threshold.
> 
> For example, in the failing CI run [1]:
>   EXT=0.140s RT=4.750s total=4.890s (expected ~5.0s)
>   ratio=2.86% < 4% → FAIL
> 
> The 110ms gap (5.0 - 4.89) corresponds to the RT child's setup time
> being counted inside the measurement window, during which fewer
> deadline server ticks fire for the EXT task.
> 
> Fix by using pipes to synchronize: each child signals the parent after
> completing its setup, and the parent waits for both signals before
> starting sleep(RUN_TIME). This ensures the measurement window only
> counts time when both tasks are fully configured and competing.
> 
> [1] https://github.com/kernel-patches/bpf/actions/runs/21961895809/job/63442490449
> 
> Fixes: be621a76341c ("selftests/sched_ext: Add test for sched_ext dl_server")
> Assisted-by: claude-opus-4-6-v1
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

The pipe sync makes sense and should make the test more robust, so LGTM.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> 
> ---
> 
> BPF CI caught the failure, I fed the logs to Claude Code and this is
> what it came up with. I ran this 3 times on CI, and the failure didn't
> happen again. The change makes sense to me, although synchronization
> via pipes might be an overkill?
> 
> Please let me know if this is too sloppy, I'll try to refine.
> 
> Thanks!
> 
> ---
>  tools/testing/selftests/sched_ext/rt_stall.c | 49 ++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing/selftests/sched_ext/rt_stall.c
> index 015200f80f6e..ab772e336f86 100644
> --- a/tools/testing/selftests/sched_ext/rt_stall.c
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> @@ -23,6 +23,30 @@
>  #define CORE_ID		0	/* CPU to pin tasks to */
>  #define RUN_TIME        5	/* How long to run the test in seconds */
>  
> +/* Signal the parent that setup is complete by writing to a pipe */
> +static void signal_ready(int fd)
> +{
> +	char c = 1;
> +
> +	if (write(fd, &c, 1) != 1) {
> +		perror("write to ready pipe");
> +		exit(EXIT_FAILURE);
> +	}
> +	close(fd);
> +}
> +
> +/* Wait for a child to signal readiness via a pipe */
> +static void wait_ready(int fd)
> +{
> +	char c;
> +
> +	if (read(fd, &c, 1) != 1) {
> +		perror("read from ready pipe");
> +		exit(EXIT_FAILURE);
> +	}
> +	close(fd);
> +}
> +
>  /* Simple busy-wait function for test tasks */
>  static void process_func(void)
>  {
> @@ -122,14 +146,24 @@ static bool sched_stress_test(bool is_ext)
>  
>  	float ext_runtime, rt_runtime, actual_ratio;
>  	int ext_pid, rt_pid;
> +	int ext_ready[2], rt_ready[2];
>  
>  	ksft_print_header();
>  	ksft_set_plan(1);
>  
> +	if (pipe(ext_ready) || pipe(rt_ready)) {
> +		perror("pipe");
> +		ksft_exit_fail();
> +	}
> +
>  	/* Create and set up a EXT task */
>  	ext_pid = fork();
>  	if (ext_pid == 0) {
> +		close(ext_ready[0]);
> +		close(rt_ready[0]);
> +		close(rt_ready[1]);
>  		set_affinity(CORE_ID);
> +		signal_ready(ext_ready[1]);
>  		process_func();
>  		exit(0);
>  	} else if (ext_pid < 0) {
> @@ -140,8 +174,12 @@ static bool sched_stress_test(bool is_ext)
>  	/* Create an RT task */
>  	rt_pid = fork();
>  	if (rt_pid == 0) {
> +		close(ext_ready[0]);
> +		close(ext_ready[1]);
> +		close(rt_ready[0]);
>  		set_affinity(CORE_ID);
>  		set_sched(SCHED_FIFO, 50);
> +		signal_ready(rt_ready[1]);
>  		process_func();
>  		exit(0);
>  	} else if (rt_pid < 0) {
> @@ -149,6 +187,17 @@ static bool sched_stress_test(bool is_ext)
>  		ksft_exit_fail();
>  	}
>  
> +	/*
> +	 * Wait for both children to complete their setup (affinity and
> +	 * scheduling policy) before starting the measurement window.
> +	 * This prevents flaky failures caused by the RT child's setup
> +	 * time eating into the measurement period.
> +	 */
> +	close(ext_ready[1]);
> +	close(rt_ready[1]);
> +	wait_ready(ext_ready[0]);
> +	wait_ready(rt_ready[0]);
> +
>  	/* Let the processes run for the specified time */
>  	sleep(RUN_TIME);
>  
> -- 
> 2.53.0
> 
