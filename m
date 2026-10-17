Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F86DCE1;
	Sat, 17 Oct 2026 16:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792253089; cv=fail; b=sLgeq6JwMSjdSUCdabbHBNakijpXbcb/Djq/paewU3+zqIX1heA6owPB8gXGqXCCLW+qH+JoYuiReO8KLw5G81TuPInukkHjgP8s904NnsiS4+vPaBQ0tUd1OeIjfjXGjl03hUhFQVEDInRjaTAkphpLrC/piEADO+gugMlVAYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792253089; c=relaxed/simple;
	bh=0yQx6st0qcjS8LL3C7hh07nJPRYB6gWd5qSprg+pV8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKtTUNidLwuEMIfLA/q/EeZhmnpK7eg9tT915TB0pNMLH2W7sDq8Nc7cX0xeSyGq8YdKv0BRJOhJhiuKGQ6gEWjppbAifqCwyVJLuHqhSVoaGuYxg1lbh8sEK4akMQALBbbfa47VSsKCx9QxYgDfGw/J5ljVR9Tg+wbt3auUaIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJlRwMs+; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJlRwMs+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792253088; x=1823789088;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=0yQx6st0qcjS8LL3C7hh07nJPRYB6gWd5qSprg+pV8Q=;
  b=CJlRwMs+iY9SHy2uVaxNbBDHAzyWmy2gHTP4lNhHNlIb5h8TVPI5i02C
   MPhjcosnFg9zw8ts2f5w7RPMmA0Bj+jyfZ6K+kvm3s+qB/AN9+BD1Nmms
   LNXVon3avGF71NoUnHiyoHaKFDikA6NNc1cVZNeBgs6MTTLG1WCQMl1Hr
   f3/jsK6tySwBNzfUOXeZrb9GE86eJ++IpWifqkFdzr/BiAl8j+y72bR/u
   AQYtWlnCQugYd7Grm+Ly8PnsEM2aidENwQUeXFw7IA9UBC4xpOoAQTGGQ
   wMxM9KkZaBDXoS4y5Jo7BrBcA7lQhAiAfk76dH1xaGVtLJTQYJY0V+YF8
   w==;
X-CSE-ConnectionGUID: 7dBCeShKTDKHSlHl4xfpNw==
X-CSE-MsgGUID: rsVnYdviQSaKe5uqMiGLPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1020156"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1020156"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 09:04:47 -0700
X-CSE-ConnectionGUID: ooYtJJXHTciuFZh8xinD7Q==
X-CSE-MsgGUID: dfLtiX1jTjqNRBh04bjNDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2103781"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 09:04:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 09:04:45 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 09:04:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.26) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 09:04:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxkZhtQK6KQBeGsioXXOeFy/4l4tKhZ+OZwl5X7Ktj4P26T8iWKNjTra00vAAfzTa/2L73GBugKjc+414ICWuSkJ6l5LfOpKZFkfrO3oUg68uchQDqkW+KvVxesU8rB7rSk6/iuc2ehCrvuIEp4pfC9M8qD5laq58I8ZafpT/VNV4Kg3yKuD1Bszy0ccY8RLS44Q6YvO6UojI/fDkSLmelK/mnjoq5EJzDD4mc0ymMwEsIhBdDSX++eim8iC8xZsD2IhxoXjt2x7Rnk9Ux+tECSXrFHT5xUCL9t3EoGI9OO4oP+G7t1zGtpLhsZFcZJr9gPkd06atmr+BoWksx5QGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16IhsnFYFT6/q3sI4X0+83IGy8PtDs1JkJVDPNdTAjw=;
 b=H8S4BmmiTRRSuNiDUiFt5c8YWUZBMz6bNrWOxbK3VJwshRQsxF/Q+bGaxFw3sKJ3SIt4xVTMWQdzzTjFuGTscp7J4cIiit0Qp25wt1YSaOMbQoVdvLZqti0omnFCDiX1iQiPpxyGHDwR2aGmAuplshwu/1agtGCVlDBvYFXh8klzOSxV1A8OxeGUEbO6l3vtFQid6cYJZeBlBkrlGge9tlRVQH+Cgyyn+tZlAC738bPta7E/vS/qIp6vHnFj8lrQqQk0grQBI+/eaAcT1gCJesyeqGA45Y9GhFpR+G94z/iCopU6rQjneyDPAyHsJkovP4/aJyOue2bjGek8CFKU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB6672.namprd11.prod.outlook.com (2603:10b6:a03:44c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Sat, 17 Oct
 2026 16:04:39 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 16:04:39 +0000
Date: Sat, 17 Oct 2026 18:04:27 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
Message-ID: <atOci0KQ12KqkTLM@boxer>
References: <20261014184539.774708-10-maciej.fijalkowski@intel.com>
 <179220636838.434549.10005960398517216064@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179220636838.434549.10005960398517216064@kernel.org>
X-ClientProxiedBy: VIVP296CA0120.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 957bc788-e02a-40d6-6f98-08df2c6858dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|56012099006|4143699003|5023799004|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: v8Th59JM52NrswubIibHayCbAnImHsrBkztu89uH+8PGDrFjMaD4U3LLpmRsjGx/skobEAW323Mv/K554oWPtdLnIaJY/vJZSrCRblgMLe8x/D3sg+6OnPUUyBohp95+VUcp1/2UcuREudWEJKId53tfTdpTgQKe+P0Z64CA9kj6PQrZHQqrZwQRnwQUOfPP6M3zyRqh7MWPJgvCuSidBx4RsG6vUZP1h+1pIWVY0/zb9etGdY5WpjiwCXj2iFrrjC8axjs9jlYey3rcO8fRoMgengG3pP7oo7VfzSxgRRCwHhwworCIsO1zovVpRrNLer++kMrrZ+XfulZiy5Wb0KKCdBxyccFz365HUyqQWJWq9iDCvrYpOBL4vio7tjdbaVajly42eYn0GM+Kh7XZA99H1PiIDRZKANohLx0V0u5Y9vvsh20NeTvWTGsyqfR4TVP8/mtQFHQFge61fCREi8BgUmRl2AALY65SJ5XYRNkmZ5N24OcVsnBXasdsYMBUIbS12H9g0rKShIRKnvcC6zELPgyCleqx3G7iNP1GPebegMk2UqQyAR9oYloqFxL4oj121MTCjxe1GQzSIo7JF1HYCiJboVDQAhj2Lda4PO+NxUCQaaBP5odjtgcOEIfH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(4143699003)(5023799004)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxwMVJkcVJHMmRPT1FwTDJMcEJZU1VyUnlNVFI1SnpIUTVJRFM4TzY5Rk0y?=
 =?utf-8?B?bVVyaXRTbGhyVGdWZDNnNThsdzVDeUtjS2lwMm5YaUsxRG53QjhPSlUrT3Q0?=
 =?utf-8?B?QnNhVmR3MG9PMk5DbWV5eU9vamRwaEhKeXRJd2FaQnJNK3M5RGZQNjIrZFp4?=
 =?utf-8?B?Si9BcHBIUmljY2lHSWpOd0VpWmY3Uzc2K0pvTkZRMThyOGxyWTc4Z3VaOEpw?=
 =?utf-8?B?aGJyeDdXcGR6T0xsQVU3UzJuS000ZlhGOFFneDlzbjIya1RoQWpVb2VFdVpW?=
 =?utf-8?B?MHg4eTJ6QS9ncFZHdWl2bTZqdW5OaFgrRTVienRMNURaSXNKbUp4OFN4cHM4?=
 =?utf-8?B?ZFByemt5cCszSlNMZ1ZZT2Rsb3U3SS9iMjg1UUpyVktGRmtEQTFFOTMxOVQ3?=
 =?utf-8?B?N1hUanlrS04xMEdDWC9jYmpZVzZZcHNEU1dVWXIvSE9wM3ZnRDM4OCtSNUtm?=
 =?utf-8?B?cmlqNkR3aVBjM0RWWnkwSmxyK3lhUzMxcTFOV3JQbWlvclhCTzQzUFlGRXR3?=
 =?utf-8?B?bVM5ekluZHluSWlnelkzdzk5QWtyN20vZmo4Y1BtZ0RmcFhwdy80YkJadE5G?=
 =?utf-8?B?UitsdnpLTEZEam5tbHNQVzdraElMbjE4T2VNTDRNK2R0VGxHMDZ6S210SE1n?=
 =?utf-8?B?K3RFV0VxRE1JYTEyM0EwK1Bycm9mVmwwWTNZRGlGR2pHNkEzVmRFYzR6SWRl?=
 =?utf-8?B?STlQZm1ObFRQY2dhMytmaHJtNXJUVUtuZ3dZU2ZQT0dobFlXUWhpalVXVFZl?=
 =?utf-8?B?RWdSVm1tcVNBNjI0TVBxWG1sVTVYWGlyNjVUT2RWMVhsR2wyMlMya04ra211?=
 =?utf-8?B?TGV5TEN3NGg4ZWRrb21vWHcxM1pTV3YyVkNjU0J6aTltNSsyVjd4QXZCS2da?=
 =?utf-8?B?MVJMVmRnNjcvdWpRNnJYTVhDQXRvZzRSN21xVml4NUxFaUhsdDRsMGdzTWdE?=
 =?utf-8?B?V2Z5YmppL2VnYk9mQXVHZmc2aGVHNkM2ckxOM25POTdHaElpbVYxSGdjZ0Zr?=
 =?utf-8?B?N1dwd0MzYk5yVXIwRXpieFlONnI4YloxWUtKL1diRnBvUm14Ri9VdWxKWEtp?=
 =?utf-8?B?MEpYNHR1N1dsOGl2aThtUXN3Z3JBWWJyTUhsbXlqVTBEeURER01vVDcveDNa?=
 =?utf-8?B?bnd0a1JWK1FaaldKR0JjdkVBNVpWeEJxaWwrSkZCMmhOUnZzOG9XeFUxUVc5?=
 =?utf-8?B?S1Mxb1dwN3lFL3ZXYnB6WlBNaVh5UVgvZ1JMTzNqL2tySkZCTEc3Y3ZsbUxM?=
 =?utf-8?B?eGpCaEUvZllkb1lFZXFCbnpOQkdZUUVaeDVLL2tSYitTSXVKUERpL1lReENG?=
 =?utf-8?B?VzEyYWx3M3p4dnBuWW5sRkdYVndSYlEwZ3pIWTBGSkdaUVVoK21YM1JQZ0or?=
 =?utf-8?B?ZmFlRmltWUFFYlhWQjdEck15YXMxa2tRaEd1Z25sb2RFdEpDUUdIWVJQS3Qx?=
 =?utf-8?B?cVlJTFZMMCt1OFFOcnVpMmhpQ2VhZ0ZSc3d4QWM4dm5VMFg1aklXMitTN0hT?=
 =?utf-8?B?Lys3R2FERlhqZ3lCb3BlMEdmcWpXQWprQm9rQWtMQ2RZMTgyNDJxZUZCQnZB?=
 =?utf-8?B?ZkRCc1gxK01NaHkvVjVzN2syMFdIWXhUN0NtaUZabWxvQUV3OW54VlF0U1ZX?=
 =?utf-8?B?VmhXRnJvTFNyVlpqaDhzQ2VjaFpob0s3VEFKaVh4ZVN3c1IwYkgybDkxVUZy?=
 =?utf-8?B?amozOTNCUDBFWkpWclJ1Sy9MdU82cmZNYjIwdGMwQlZlYnlxeDk5dmk0eDUv?=
 =?utf-8?B?cTNSSVpoWDdNM1U1ZjVzUDZiWkhVZy9naWpXRG9rN0tkby9QK1JQdzIwUUpw?=
 =?utf-8?B?ZzUyVnFMeEJxMUxseVAxQnZ3OTg1L0oxZ1Q2WFdCaVpXNkRQd1k2Tmkrd1Ir?=
 =?utf-8?B?b252cUNBemp1U05lNzhubXd4N29DM3BqSmdVOXBWMy9lVVp1dW9Ga0F4M2dm?=
 =?utf-8?B?NVpJV2lYQzVDQUdrL0kxNFZKMFRuY1hkOEhPdlc0c0c5bTR5Um9BRDExVy9Y?=
 =?utf-8?B?RVR4ZStGbTcya3F5OEkwWkswSXZMUXBmdklGVFZrOHpJZUdVdWNJNExTM0th?=
 =?utf-8?B?UWlUc1BPUU1VK25QTkJHc01wOCtTYnFMaThuOHF3QXNBaDJIUjBKeHc0U21i?=
 =?utf-8?B?VTBBeGZNR1dIOWRiKzlacWlyb2s2Mkd1K1h0THJhTzZtbVo1S2FtZGs5MVR5?=
 =?utf-8?B?dHFtT0dRdVZrQlBQOEo2SzlJeDl5SExUc1FsM3FnbVBZRXVyZExJUDdtejBu?=
 =?utf-8?B?RWlhMytUK0JEQVRYUkkwWnFXZUlXWkJ3S0hJQ2c2ZXh6RjB3cUZIeGk4dXVQ?=
 =?utf-8?B?WmY3RWtZQ3oxZ2c5aHJZdkN1Ymg3ZmhhRHBGT21VRWxHTElKVnFHaHc2dFdj?=
 =?utf-8?Q?ok9E1Ddn/9groTu0=3D?=
X-Exchange-RoutingPolicyChecked: 5xYQfJ7zs1ksjPI1HZ1B84SWO64ISm/cDEqK8Rk3kCEtOoILymA5D3mwHcF37EL3TfQV2zcC9tC3RFhfTc5XMHPZ1Rn5rfhASR0/wQWC7i7WfW6q9iIUmmtyMh23FfNN/gR/8qWm1JsgVwx79cVbrAw6wjCESVuVoNwtteJt+aGe+xcCArB+M9CMTComOo9JD6zRhO3NDfE0FO+h+nFHuUsdHbXpiTB4fnG7kROmaOVOVwyfB+EiYUvt9Z54NEmQuytYhI9pPgZCENsQV7IYzZJ2wuoaGYf+H0ZqUmBtVEcQC9sStyhjDcenvn8Ac9h6pw1oiuOG5rwAdUQtdBnN5A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 957bc788-e02a-40d6-6f98-08df2c6858dd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 16:04:39.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5pbMC4QlL+gyp8M+iwir+6f20VnTQW1IFjvX9xEYVOzzZV2Swu1234m9pXyRC42sMzcysiLCTFI2T2H4avTqUze47r908jUepzf2lCw718=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6672
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 03:06:08AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 3 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] test_xsk.py main()
>   (tools/testing/selftests/net/test_xsk.py:123-136) raises…
> - [Medium] The commit message says test_xsk.py "leaves those [UNALIGNED]
>   cases out when it cannot reserve them".
> - [Medium] xsk_reserve_hugepages() (lib/py/xsk.py:15-25) raises
>   vm.nr_hugepages, which sizes the pool of the *default* huge page size.
> - [Low] xsk_wait_endpoint_exit()
>   (tools/testing/selftests/net/lib/py/xsk.py:44-58) kills xskxceiver…
> 
> --
> 
> selftests: xsk: run one test case per xskxceiver invocation
> 
> This replaces test_xsk.sh and xsk_prereqs.sh with test_xsk.py. The new
> script runs xskxceiver once per mode and case, each on a fresh veth pair,
> and reports every case as its own KTAP result. xskxceiver now requires -m
> and -t and runs exactly one case, and the shared huge page, busy-poll and
> endpoint wait helpers move to net/lib/py/xsk.py.
> 
> > diff --git a/tools/testing/selftests/net/lib/py/xsk.py b/tools/testing/selftests/net/lib/py/xsk.py
> > new file mode 100644
> > index 0000000000000..50985bcb5b80c
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/lib/py/xsk.py
> > @@ -0,0 +1,58 @@
> 
> [ ... ]
> 
> > +def xsk_reserve_hugepages(saved, host=None):
> > +    """Raise vm.nr_hugepages on host to what the UNALIGNED cases need, and
> > +    return whether it has that many. Add the count to restore to saved, a
> > +    list for xsk_release_hugepages()."""
> > +    have = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
> 
> [Severity: Medium]
> What happens here when vm.nr_hugepages can't be read or written?
> 
> cmd() is called with the default fail=True. A non-zero exit from sysctl
> raises CmdExitFailure, and a missing sysctl binary raises
> FileNotFoundError from Popen.

Fixed in v4:
the pool is the 2mb one in /sys/kernel/mm/hugepages/hugepages-2048kB,
read with fail=False, so a host without it only loses the UNALIGNED cases

However, seems we would need to audit rest of tests relying on hugepages
being present.

> 
> main() calls this before ksft_run(), so nothing turns the exception into
> a per-case result. The whole script dies with a traceback and prints no
> KTAP plan.
> 
> This can happen with CONFIG_HUGETLB_PAGE=n (the net selftests config
> doesn't enable it), with a read-only /proc/sys in a container, or when
> procps isn't installed. The old test_xsk.sh ran in all of these setups.
> 
> The commit message says test_xsk.py:
> 
>     "leaves those cases out when it cannot reserve them"
> 
> Here, though, a failed reservation aborts every case, not only the
> UNALIGNED ones. xskxceiver already handles missing huge pages by itself:
> 
> tools/testing/selftests/net/lib/xsk/test_xsk.c:detect_ifobj_caps() {
>     ...
> 	if (hugepages_present())
> 		ifobj_set_cap(ifobj, XSK_CAP_UNALIGNED);
>     ...
> }
> 
> Should failures here be caught and treated as "no huge pages"?
> 
> > +    if have >= NR_HUGEPAGES:
> > +        return True
> > +    cmd(f"sysctl -qw vm.nr_hugepages={NR_HUGEPAGES}", host=host)
> 
> [Severity: Medium]
> Does vm.nr_hugepages size the right pool for the UNALIGNED cases?
> 
> vm.nr_hugepages sets the pool for the default huge page size. The
> UNALIGNED UMEM always asks for 2MB pages:
> 
> tools/testing/selftests/net/lib/xsk/test_xsk.c:thread_common_ops() {
>     ...
> 	if (umem->unaligned_mode)
> 		mmap_flags |= MAP_HUGETLB | MAP_HUGE_2MB;
>     ...
> }

addressed in v4 by interfacing hugepages-2048kB

> 
> The xskxceiver probe passes MAP_HUGE_2MB as the mmap offset instead of in
> the flags, so it actually checks the default-size pool:
> 
> tools/testing/selftests/net/lib/xsk/test_xsk.c:hugepages_present() {
>     ...
> 	bufs = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE,
> 		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, MAP_HUGE_2MB);
>     ...
> }
> 
> Before this patch nothing filled the default pool, so on a typical host
> the probe failed and the UNALIGNED cases skipped.
> 
> Now the default pool is raised to 32. Take a setup where the default huge
> page size is not 2MB, such as s390 (1MB), ppc64 hash (16MB) or arm64 with
> a 16K granule (32MB). The probe passes and XSK_CAP_UNALIGNED is set. The
> real MAP_HUGE_2MB mmap then fails with EINVAL or ENOMEM.
> 
> Would those cases now fail where they used to skip?
> 
> Larger default sizes are a second concern: x86 with default_hugepagesz=1G,
> or arm64 with a 64K granule (512MB). There, nr_hugepages=32 also reserves
> 16-32GB for the run, and the UNALIGNED cases can't use any of it.
> 
> Is /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages the pool that
> should be raised here?
> 
> > +    saved.append((host, have))
> > +    got = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
> > +    return got >= NR_HUGEPAGES
> 
> [ ... ]
> 
> > +def xsk_wait_endpoint_exit(endpoint, label, timeout):
> > +    """Wait up to timeout seconds for xskxceiver to exit, kill it if it does
> > +    not, and return its exit code. Log its output, a KTAP stream of its own,
> > +    prefixed with label, only if it did not pass."""
> > +    try:
> > +        endpoint.process(terminate=False, fail=False, timeout=timeout)
> > +    except subprocess.TimeoutExpired:
> > +        endpoint.proc.kill()
> 
> [Severity: Low]
> Can xskxceiver be left running when something other than TimeoutExpired
> interrupts this wait?

fixed in v4

> 
> ksft_run() installs a SIGTERM handler that raises KsftTerminate:
> 
> tools/testing/selftests/net/lib/py/ksft.py:_ksft_intr() {
>     ...
>     if term_cnt == 1:
>         raise KsftTerminate()
>     ...
> }
> 
> During a case, the main thread is almost always blocked in
> endpoint.process() here. If the runner sends SIGTERM to the Python
> process, KsftTerminate passes through this function and the child is
> never killed.
> 
> ksft_run() then runs the deferred "ip link del". That removes the veth
> pair while xskxceiver still has its sockets and XDP program bound, and
> the script exits with the child orphaned.
> 
> The child is started by _start() with cmd(background=True). The bkg()
> context manager would terminate it on any exception.
> 
> Would a try/finally, or bkg(), be a better fit here?
> 
> > +        endpoint.process(terminate=False, fail=False)
> > +        ksft_pr(f"killed after {timeout}s", line_pfx=f"{label}|")
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/net/test_xsk.py b/tools/testing/selftests/net/test_xsk.py
> > new file mode 100755
> > index 0000000000000..acfdba55fbae8
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/test_xsk.py
> > @@ -0,0 +1,140 @@
> 
> [ ... ]
> 
> > +def main():
> > +    # ksft_run() exits on -l and -h before main() restores the huge pages.
> > +    if "-l" in sys.argv or "-h" in sys.argv:
> > +        sys.exit(f"{sys.argv[0]}: -l and -h are not supported")
> > +    if not XSK_BIN.exists():
> > +        print(f"1..0 # SKIP {XSK_BIN} was not built")
> > +        sys.exit(SKIP_CODE)
> > +    saved_hugepages = []
> > +    hugepages = xsk_reserve_hugepages(saved_hugepages)
> > +    cases = _get_cases(hugepages)
> > +    ksft_run([ksft_variants(cases)(test_xsk),
> > +              ksft_variants(cases)(test_xsk_busy_poll)])
> > +    xsk_release_hugepages(saved_hugepages)
> 
> [Severity: Medium]
> Is the huge page count restored on every exit path?

fixed in v4, Bjorn pointed out bunch of things left uncleaned (including
hugepages) at exit/exception path at hw runner and i also addressed the
veth side (here).

> 
> The commit message says test_xsk.py "restores the count when it ends" and
> that "ksft_run() exits on -l and -h before the count is restored, so
> test_xsk.py rejects both".
> 
> The argv check only matches the exact tokens "-l" and "-h". Also,
> xsk_release_hugepages() is not in a finally block. That leaves several
> paths that exit after the sysctl has been raised.
> 
> Any unknown option makes _KsftArgs exit. That includes --help and the old
> test_xsk.sh options -m, -v and -d:
> 
> tools/testing/selftests/net/lib/py/ksft.py:_KsftArgs.__init__() {
>     ...
>         try:
>             opts, _ = getopt.getopt(sys.argv[1:], 'hlt:T:')
>         except getopt.GetoptError as e:
>             print(e, file=sys.stderr)
>             sys.exit(1)
>     ...
> }
> 
> getopt also accepts grouped short options, so -lt 'test_xsk.drv_*' or -hl
> gets past the argv check. It then reaches the sys.exit(0) for -h in
> _KsftArgs, or this one in _ksft_generate_test_cases():
> 
>     if cli_args.list_tests:
>         for _, _, name in test_cases:
>             print(name)
>         sys.exit(0)
> 
> _get_cases() also runs "xskxceiver -l" through cmd() with fail=True. A
> CmdExitFailure there, or a Ctrl-C before ksft_run(), escapes main() the
> same way.
> 
> In each case the raised vm.nr_hugepages stays on the host after the
> script exits.
> 
> SystemExit is an exception, so a try/finally around everything after
> xsk_reserve_hugepages() would cover all of these paths, plain -l and -h
> included. Would that remove the need to reject -l and -h at all?
> 
> > +    ksft_exit()
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
