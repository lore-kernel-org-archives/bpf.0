Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC8530675C;
	Fri, 24 Jul 2026 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899105; cv=fail; b=D4kNV9JQQEG9psH6FwYV9x/fm6bUM6HKQ90Qlr+sZYrEBqogg8HQtT1S2mEJZyW+idpZQRCtylQUXq5l3/At1M/lCSOUkXxcXh37vXy6hci78G+EhvZJTCrhHycdifwxR8SpOHAsIiBBMx3GsrOj4og8Xps2ni8B/vMfwktcCtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899105; c=relaxed/simple;
	bh=prS6CFYNNAX5orIWftYw82fFMAsgg3l7AGtzaKm8B2M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qEGhEVMHql/bJdWKjejQTob4NQxL0tS4avMb7g8ifMMdPIeFW0qgWXZ0evi5sfq9p6AcnZ/nsBk73G4ZPpPWJpXfTNNzHIRxGNriah1J8CojELiYKH+M9x1F+FfUpGAUZN/8W+8N2gogEJ6BT2TQbH2G22P0Rr61pE8U/Q9tVSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNG6olpd; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNG6olpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784899103; x=1816435103;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=prS6CFYNNAX5orIWftYw82fFMAsgg3l7AGtzaKm8B2M=;
  b=DNG6olpdcJ3t/Jsk0ckHLJjfZVQi3tuWOFWiE1g8G9+2mYCwzyZmKyN1
   o0ozfh7UlluyQi0Yxh5z/l5gVFzEjKi5t6JWGydU6pH76Rb1GkmSwdICB
   V5kz55cH/RDqBjseYaEmMzL89MiKbm4NxgMzm3WIIvBgiNAkWf++D+yYD
   yhRsUnoPjKujI2rDyKEmMsA4gR+jeNDZkoX8u4c/6XvdRBFS/cQGrZze+
   8/OIg7epWgtXI9bisNzR6s9RWwJNF2vc02bkHRstmq44hbGE2nYtYki8W
   sij2ksIhMtC27Fk+vdA4Q9ehxD/lnIUU+DaZmM1qp8SFsbiibtMbaM/Hy
   w==;
X-CSE-ConnectionGUID: x+rnEakZQOuNwITPCIg+6g==
X-CSE-MsgGUID: 7WbxGDoHSzGoFvG2bg68ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="97080005"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="97080005"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 06:18:22 -0700
X-CSE-ConnectionGUID: qk7aCnr+QvGeJDyJmXuYiQ==
X-CSE-MsgGUID: 6/4RuICgRQiSbhIckyLMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="282013313"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 06:17:54 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 06:17:53 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 06:17:53 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.67) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 06:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUG0FtA1lp0bWve8dMs2J7vf1ZVd8PBLs0HDmwgtB6BVHFLp2JeoojKEST8a8BTXrhEcSJnH65Apb/Lm2qSmjfduh6ykMBLSxs00EdcP0Kh6d+iU/gW9lhk6MfKVKhiiTmCSDxj2KsAmrX5QdCuya+jOYCE5dVoXrcGEsQcMJH9ygFr7H9PcS8s2oVhXUKgL7LQq5T8l9SadTzyTOhPI2O9juzxO3i2ndr8LN2zOMOnjJbWlTX4/ZDHhfxXrznzi1ujvwf7z44X3OFwTc7SkbqGY8yxv1oPHwXORxnd6UDS/VcvdabxyijPHuPlbS72wttZlaheSfqRKhkPTE6Xv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/cPj0pHJJ8gZYT5zSwFuSLGb8O9ta8fTj/c9HcNzrE=;
 b=PMCZYPouED9ovI/i9DdbvX2h35b8u5iMAbaxYXZCU8yphO4DqP8tRNV7+/ODNy7KcFFKuQW5DKd7W25Uxv+bzBhhC9l6SRXjAisffNnfeIpHx/xa2eiP8cN4LCS+3cBCsbtqvnvKKKaDmVIGDzEUzNnD7SvCRCbIIwEF/SLR2YGrDiqQj81u+WcmozTb+toZeej/dHr0YWSuht0o47z8Ak9O07A+1YkZnAx1451q72Sq2m+YG1bV7iBYCU4XroJCgwNKAoDIfy2qjYATSBAjU+IrqV/UwHN+wdI7KbvkxB1Nt5qCfHMmMipTrTeBaXnjW+2khMUD7kn28RCGmQHGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 13:17:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 13:17:44 +0000
Message-ID: <27dd39a0-71bd-4cff-8e72-6aa45df57dff@intel.com>
Date: Fri, 24 Jul 2026 15:16:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
To: Stanislav Fomichev <sdf.kernel@gmail.com>
CC: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, <magnus.karlsson@intel.com>,
	<maciej.fijalkowski@intel.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <c3de7856-d9d1-4bb8-ba4a-a7f967c767ae@intel.com>
 <amJL48yvoEcOLcHw@devvm7509.cco0.facebook.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <amJL48yvoEcOLcHw@devvm7509.cco0.facebook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P250CA0014.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::19) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 02098c61-e82d-4ef4-95a6-08dee985f270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CXvkntnYmkBHWaSz5XI+ENBv0hH6V/dxGaCLsv/WjweAIlDy31kgFPzEGF6fq1EqTV7fZn5UCgdHuJ6hqzGp23RzixTiozsq1lbFCjPy0MDClZCpGjYgdMgc1YN3nXxzf7+Eyk93FN/AYECm1Fcb+jmH6Go+iqCsqj7DgPeNrG+iwgoqbjf2DMNoX5sUxqudA17s+ro+StJTZWH5d7cS9PYopvR7PHh5FwWWHUfVJJVrWkjVJd3S+hkCIb0gVn63ZHwfiG+5wu4AUHrbLMRV3XTsZiH6zVIYsH7zw/OLv5DRty4x5xe8ZPpp+qQVUF5gSE7hEIG8eUuhwvu59qRY4jhkUvuulRhVZR00fg//7DzB6MTt3b0YNDeCtjEFFk6IF7OXRKXP3XPHEHOXKmWMVGEg7sMgYDfIhxYtahK+E3fjaNRPU9iz+UhqTB+5IXL3vn5P+pc7s02oqBFmThK8REAaV9HDZtPwCMObhYFFLKJHT3wgpI16nqyEKG26BHNwfgPpxP3exB+Q+2pqwcIKtca8QAz0/vV/eMKHTPLvrNlhpz9j+dF39OY0ArFUZRezlS0HGiW+HEeNo9OqH099Hd56uUw9asizTutetATZgG8svGcDQgcha8P+i7+z+zSKXta1VvDvX2f1rrme0Tr5XiwZiUq39qLYyCOBrQfyO5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2IyS2lYT2dzWWxmWkQ4VjVnQ056S0lJUXo4WHlJVndmV3JVM0dxS2VqOFla?=
 =?utf-8?B?N1l5ajdxZi9kVVd3ZjNZdFZ5T3NkR3NINldLR0ZmWG9LVkt4N0hFbWcwS3Ez?=
 =?utf-8?B?d1A5bS8wMzJkNWVpdjlqQ3kvV2dXRHJJd3BkSDNZZUZ4cE5VL2NHZjRGWWpJ?=
 =?utf-8?B?TWxrOXoxbFN6VHdBY3hNNWtsQnVQZE1pU0loQUR3clpxdDlnMWdTVFJRNmV0?=
 =?utf-8?B?SzAvYzBTQUFmT2huU3lPVzJZcDMzUFVXQUhXQlBmRi9tRmEzdnpxbUd1cHBP?=
 =?utf-8?B?SWlpVkFuTVRiSjBSdytQbWZxNFp6d1VKM2hBRGY4dVZFYUpKZlpqdm8yYWcw?=
 =?utf-8?B?cmxvWUt2bVpOdVd6emp1a2FqZFVuS2tueEwydVNDWmI4VGFWeEFkWWNDNlBG?=
 =?utf-8?B?dHd6Y3NaWlVneFBuUnB4NndZcU5tMjUwZUxCbFFTdkMybW1VcGdVL1lmK2lM?=
 =?utf-8?B?N0RLckZqTFZrak1zZXdKZGw2dUZKY1M4UGZqQnFUTFRVL1FWKzIwV09FazZW?=
 =?utf-8?B?eWcxaGtoQVpvYk1xOTM0NVdJVW12bEgwT1puS2dYcUJUL1UvWllPcG5hbXpi?=
 =?utf-8?B?d1N5a01DbXhHQ2JWWklxdDRPbEpZcWF2UGZQMWZOZnJFUU9OdmJzbktmZnc0?=
 =?utf-8?B?Ylk3bUNqaFRGMk1QNXZuWmdSUUsvbXU0V1hSWnd0VzJsWjVzUkhRY1JyeFZk?=
 =?utf-8?B?dm5yZWJDZFVIZUYyeEdIYWIrT1E5WjZRazh5a0tidlVMUUN5ZENad0Q3L3dS?=
 =?utf-8?B?QzJjckhrUEZyanFRd0l2c2gybjRxV3V1Y0ZnU3lBaEJURFJvVCtRTmFsbnl1?=
 =?utf-8?B?NGY4U1ZOeGFOamV1SHRRVzJkcENtUmhVRUo5RFJtSldac2JIejgweU16KzM3?=
 =?utf-8?B?Yi9Zb09BMzY3b2ZkbWx4ZnlTMTl6Z3p3Y1pIQ3Z4ZXJBYVYwQ2l3Tmh3R3Nj?=
 =?utf-8?B?MjIxenRTb212c2FMeHpxZTI1aVIzUjRnL2JEaytxMldKS3ZEOERtb244YUc4?=
 =?utf-8?B?ekNNZVlreHUzRlYrN0RmVTF3TUtlNE5NUThhaXlHK1k3WGV1MG0vQ3ZkZ1k1?=
 =?utf-8?B?SngvUDNLamtGdWVGQWZRZEc5OTBTd3p6ZmgzdTBWdTVGbGU3WXdVRFp1QW5B?=
 =?utf-8?B?VzhDU0tTOFdyOTBjTWlVcVh1SERrOW5xWmhOTHRaZlBHY3ZwUFJLTDVOR2VF?=
 =?utf-8?B?QUhrRERxQzBQVmFUYlZETlZmcjNSRFlYUTM4VmdQYTh6VEpjcGhRSzBJbHBi?=
 =?utf-8?B?U2kzYXpGT2ZUdjZZOVBMV1RGZDNGMDVJKy8vUFVBMGY1WUg4RmRUV0VrS0ZZ?=
 =?utf-8?B?M1RHWDBWZE1HTG9yNldjRDh2czl3TldVSkdwaitEWURUOHJGQi9OMlVuL2sw?=
 =?utf-8?B?c2RKSEYwQ0xHZ1g0YU0wZ210YnpLZ2VFTnlmTEMrT2hXdVhjcytjTkV0akxC?=
 =?utf-8?B?cTZUSTdYa0hoMnNQOThCNHpROVZmeEhZMGcyYkFDTkYwTCtjV05neXhZb1JQ?=
 =?utf-8?B?aUg3eHF2K0Y4NFVVTFdtMUZoRlM3RDFDUXdTdTFyQlc3WjRiS1BTMjl1VWta?=
 =?utf-8?B?UUFjNXFiY3hQMXhOR1Z5NGNRLzJwRjhOeGFYMS9OTWY3UFZGVWFoL1ZycnpF?=
 =?utf-8?B?RFF1aSsza3ZHTkluVFU1elJJRXRrK0ptMytXdzk5R1BmTjNXUkl0enB5Vkp0?=
 =?utf-8?B?WUczY0dGS2VmTzJhTERybUJQSExkdUliUEs3YTlweVJRNkVIdTJlRnRwZ2Zh?=
 =?utf-8?B?WS9NQ05WcFNjNXhxSmsya1gzekNKVk1hVXFweEZNb0p6UzBiYjFwWHpjVDdh?=
 =?utf-8?B?OXJkOVZuV0lUdkRJS25PVXgrWUpDVEJFeDI5Vmx0Z0J6OVpRbHNrdW8vdzYw?=
 =?utf-8?B?b2wxUWlHaHNad2VZMjBwMUZLSWtkYzNDcEIzSkRGTjVMNThyS3ZWNnR2Rm9W?=
 =?utf-8?B?cHZ4aUIwQmtxY1N3WlRPNVVyanVIWTlUdkJCMWtTYkpMK0lOTWN3UEYyczI5?=
 =?utf-8?B?dWhlWGZLWWRUcEtFNno0VkJIRktTWC9IZk1CTVY0bWFpRncxUCtXZisvSXIx?=
 =?utf-8?B?WktRZk9wdHYzVHE1R3U0V1krNHhJRzNoanVEeXBMNEg5U3BzV0dTRldGRmRL?=
 =?utf-8?B?cW5xTnRJa2VldFdIYmxBRVpOL0xxRE96WHczZGxVMzVscnV2ZktkL0JHS2s0?=
 =?utf-8?B?VCtqVnY5ZVJuZVZuNW45b1dwYkZ3NFpVUytscmp2OUdldTVJSWZpRlpvRjV6?=
 =?utf-8?B?aHFrZnhjejVnTzVyZHpMY1BjdDhhd25KMldENU1UK05pbWtadXdZMVdVRy9q?=
 =?utf-8?B?Yi9RMGlSejQxRHRZYU1tME5xaG02dVA2ZVdJclQ4aU1DcGZNM2J3bUN0aFBH?=
 =?utf-8?Q?SiiHDEYw3qa+c+jw=3D?=
X-Exchange-RoutingPolicyChecked: dhYTpVlTDaqv6RUC4aJ6DwFsgQf16n2VJxrZ+1dvd/UpkEf+Ut6AxI1OUYDMQX6d+43lOxqPGZeX67au6hn16fr9PdZy8EH51CjXU8P1pMLKOmx2WbvmQBN8F1XG3a1cdTAghJ9lAGxqR3/A8WYD9XeMFQr8imEoFI6nj8bFQQ+XYIZemG9XPZX4JMW5regbjjn2U4RcVLcq7PS7fqIf7WEXgsm2A41YjD0vK9O3u4OiIsKE6TcQftgR4jSVUUaUv1WkVB2Rsz53CZWXOfLUCsUPUq/XLz/qShsJN/zuN79a3qOEDMIf+MDXBtEjpz4/mZCLt10kfcSljC5kPfr8jw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02098c61-e82d-4ef4-95a6-08dee985f270
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 13:17:44.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0JmNqxUqc7/bF3Qz0LGsUyfu44uCi51+RpYEIipUsDzD8TXJ7j1lB+/ncyJvje4216alm6opLFp847rV3S6POjZmwW0gA4LpywVhAjniqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

From: Stanislav Fomichev <sdf.kernel@gmail.com>
Date: Thu, 23 Jul 2026 10:15:15 -0700

> On 07/23, Alexander Lobakin wrote:
>> From: Stanislav Fomichev <sdf.kernel@gmail.com>
>> Date: Wed, 22 Jul 2026 10:55:17 -0700
>>
>>> On 07/22, Cen Zhang (Microsoft) wrote:
>>>> There is no metadata length check before accessing struct xsk_tx_metadata
>>>> fields in both xdp_umem_reg() (registration) and
>>>> xsk_buff_valid_tx_metadata() (runtime).  Thus, an invalid small
>>>> tx_metadata_len (e.g. 8 bytes) passes registration and later causes an
>>>> out-of-bounds read when xsk_skb_metadata() accesses fields beyond the
>>>> declared metadata region.
>>
>> [...]
>>
>>> @@ -773,7 +773,7 @@ struct xdp_desc_ctx xp_raw_get_ctx(const struct xsk_buff_pool *pool, u64 addr)
>>>  	addr = __xp_raw_get_addr(pool, addr);
>>>  
>>>  	ret.dma = __xp_raw_get_dma(pool, addr);
>>> -	ret.meta = __xsk_buff_get_metadata(pool, __xp_raw_get_data(pool, addr));
>>> +	xsk_buff_read_metadata(pool, addr, &ret.meta);
>>
>> That effectively disables some micro-optimizations that were the reason
>> I created this helper -- __xp_raw_get_data() is inline, while
>> xsk_buff_read_metadata() uses the external version, probably some other
>> stuff (note the underscored __xsk_buff_get_metadata()) =\ This function
>> expanded to have no external calls on clang -O2, with this patch I'm not
>> sure it would.
> 
> Any better ideas on how to solve it? I can convert all non libeth stuff
> to these new xsk_buff_read_metadata helpers and keep xp_raw_get_ctx
> to you? Will that work?

Sure, I can take a look.

Do you want me to pick this patch as a base or you'd like to send a new rev?

Thanks,
Olek

 

