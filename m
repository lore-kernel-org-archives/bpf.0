Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500A11CBA;
	Sun, 19 Jul 2026 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784467331; cv=fail; b=MMSJbSrvqb+JAG2UCdczDcQJFxz+dlsCDsiL7CoohbfgsRjWf1rBJJF23WAnv0hr4F+wqQn9AzK7lsaYdZD0xmc6vJ8DoyHtnZxgxAErLeRoYiyH3xaTFBvSCIDpVMmxM0+oyB7EoudhmeDkpT5hIYeQzjo4gBoGoWF1T8tQ4/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784467331; c=relaxed/simple;
	bh=huYCgn5Njf8ESeb8DkIkcuoJ/dYcePo+AjyVY0W0Da8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tOGar5yuO5UBg2rl+L6GDya9T23vY05SMAVq9KCi/fuNc1DGJccEbaHvTIHTpEP+Upu9FmSBth7TZ5XXlMX+q6B+SlAXkuSMFJsDpDPiCAgJjsbDwE12ZuKe2zU8ctFv2sk1zqsSEJNSyuSJxeG1nluqUrHR6gpLnS2gtHAim30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFcEJNeV; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFcEJNeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784467328; x=1816003328;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=huYCgn5Njf8ESeb8DkIkcuoJ/dYcePo+AjyVY0W0Da8=;
  b=JFcEJNeVHvvunS3snBaQv0fV6XG41oEuTiUG6nJlZ/C9nk24/Ab+fxae
   seKWPYp2pQuErB/TYvTg1JR4sHGXfz+9LR5vrWv15XH/166dJEjOdM2pn
   Eufev6MKk43JHKyNHnumdJm3V6bO0nq0CrXn2lFUVZb1dWmFn1yYebf/V
   S23MTpylGU05bmtBIBkL/3bOACdDNZoImqdUPhRmOZTKAFJYyQajAWpuY
   3jwB7auf5hJ+DvuYkSqNbvQn0l2wroS721ND2JiFejhVlPKyh09hspbYH
   F9nJJiku69vDjTK5yNM7J+muotEQqJc5LV3Hz9LsWKce6roreA+hPZ9ME
   w==;
X-CSE-ConnectionGUID: GZDmf+9oQ5CF6lByAQ/1rw==
X-CSE-MsgGUID: g3V+8YCTTLqGq1iHyKgU+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85091974"
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="85091974"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:22:07 -0700
X-CSE-ConnectionGUID: kLJ6c22lRDmJtyaGZurdvQ==
X-CSE-MsgGUID: 2NKEXy02TiSFyXoaxOWplw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,172,1779174000"; 
   d="scan'208";a="261502368"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2026 06:22:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 06:22:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 19 Jul 2026 06:22:06 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 19 Jul 2026 06:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbU/Hlog8mShkXUFwnXz0MVRvBp4ykLnPCZ6oZqOp/U8/C1ute1CSqbCuJuwRJgs1iKKJ1C9riaMU+7RbJhXR4LmAvHBrV4A+yDx1y7/S4ns6S0qKyIdiFuIBbnzG2ZAKLLWYn/QoZZy1H0Bx9Rnuf+cPaBn7jIltRgkjbsb9UQXtvjt9+LjgXrUlNYQ1zqT/JwwIRklYS3djF9hl9BosiKrqxScrMQoyAiMnDqX2RIaxCcWY5Yj837x7dXaWMTHzQB5W/z7024kX3a99lwC/OtaGrIiYCIQdnw4Fz1aiqx7w8BxCfYgZdwpb6lm6c75Ik2I1ZfmBgxWiShvGUE5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkO4LsFVY0Of1ac0hiR9yCr9iHG/oDrAEy/VE9XUNlQ=;
 b=tyvdalwTA/lbHryeEdZjmqhST7zboWlaVRuyPwWpV6ZvctEziw3gFF8/UJwG7hrRaYbGEzaOr08CC0dhtQnq4fqIjA2OCeDHda2oyS2Nu3RCIjJv9TMSeOoSYV0oUQcn4524OyEeJQaXvjJzNf8mkAM52oPQap9zOoo2dyeWVXGDM0wdkYyhiCXT4oq+H3Uh7yYiOBcGHuPRbg9wG9TqyYvCECo86mYwufU6y52LUjUHN5BSaKD+jcSKtfcYewQi/wy3knSTh5+yK77wSqoOcWHYxlLsep3WF5WWawAs9XLqCk43mGjwiZUkwUqL5TA/KS6XYLqpxRyPkdpF9Q6Urw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB5012.namprd11.prod.outlook.com (2603:10b6:303:90::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.16; Sun, 19 Jul 2026 13:22:02 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.013; Sun, 19 Jul 2026
 13:22:02 +0000
Date: Sun, 19 Jul 2026 15:21:50 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net 4/6] xsk: reclaim invalid multi-buffer Tx descs in
 ZC path
Message-ID: <alzPbtHWgy97oeBv@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-5-maciej.fijalkowski@intel.com>
 <CAL+tcoDyygM5XiVhHrmYrZTnZN6QSD0dN9mMPZmZYPtikssYxw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDyygM5XiVhHrmYrZTnZN6QSD0dN9mMPZmZYPtikssYxw@mail.gmail.com>
X-ClientProxiedBy: WA3PEPF0000051E.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::674) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: e53af0e5-16a4-4af5-cf6e-08dee598b853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 5b3jV2YoqAXAgaaDLEW2scPU+fo2E/0lGCHLyTQl49Elp4lTh35QJQRwV7gD1xpQTUqASUxY16JMvNxMw7hkwwrG8B1abe5W3HgSoChJB+9D/IN1CsPoM4qefgsuqoqlDaE33aXlkJOFbtTvBXx/erwsPX5pbDvWkelmlXzZioK1wztq46PTFwdyO40fSjrp9d/YkrM9o4CT1MYILaBg5kuV+s5K5cQt4HALQmxyvuJ1C4WW4g5PoHrfMU2pH4vo1WdoJDET+YGMMbE1wmSfbof+76WZjcEX6K88X1WCg2zbeRqOMC16fck5BbCobm+1ixgi7Cz3wpIKXXo8hGWcCe4X6G+Ksm/XWfq2mWryX9kuFTKenUU3FA8+81DvTW2H29oXeyr3LBkLfNLIsHp1rasGTOPYygN9jWrkYUY63vjXT61n15pNCdQtbA2U56Y0Uroje/v/A+ANNY1GkT5+aOCTnxrxxUnnIflFSLAnlpbr0DzVkPxCzarL4DY5MtqivFh2+qzGXYF+2xOhr1fevM23CwsBY80lmp7TW1fLwGvaN4Mufekg9MD2p/qTsoKz7hDqLtuoPII6KRdLaWOmMSnKum0U7eV4//yxTnQvs7yyJVbXcw3SfKHrT+uJwAMSRl9Avg+8/H4hzr5eikDumsTNkBwZerGebTXMzND4Fq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjJRSW9yYXBSMTdjR01CQUk3R1J0T0ZtUk53R2NtRDA1V1lTRGNnbWRUSUg3?=
 =?utf-8?B?bnQ3cThpQlVEQURBeUNnM2s5QUc5VERXbXR0czduMm11MlVwcGZSNHJiaFRJ?=
 =?utf-8?B?T1RqSVhEWDZEdGxsNXZDcWVzT2x5WE1ob3EwUjdtYWlqSTZVc3F0OGVTTTRq?=
 =?utf-8?B?akdnTFd1cXBvMjVrcWd3MTArdCt4VURySUVoYzdzazFaTFR2dm9WMnk3OHBi?=
 =?utf-8?B?ME40aHk4eVRLRm5DcXFKL01LOXY0cVBPQzhpbjBsMkU1TTRTdWl2eGU1SytO?=
 =?utf-8?B?N1BTbUhGQ3JrUnkwZ1hOSVFBS09iYzdJd1J5U0paNkxEZEpDUlA3MUdFeC9v?=
 =?utf-8?B?aitLYll3aU14UW1QeWlyeWdGT05JUDVmbTVQcUNNdytQUDVSVGF2YXFFWHVJ?=
 =?utf-8?B?cFJobzRLb29QbXJBMk5FWk1uczJQL29xWnowMFJhNVZ4dVVKbFUrUFBaR2VW?=
 =?utf-8?B?aHVQYW91SUI4dXMxMTF1bHZkb3piYncxeGcrZ3VudGQwUTRqbWpFMEorMVAr?=
 =?utf-8?B?K3p1ZjFDTzZoN3pRR04xMUdnZU9xUTJDM3luYWRseWQ2WUFDUW02ZzJXM2pQ?=
 =?utf-8?B?eGI2SlIxTlNZSnEwdVRpa1BsdWtXSkh1WHo3dmdqajdMVTIxZWhraWFVTkNk?=
 =?utf-8?B?L0ZIVm16SFNQNnY3cHlkaVZBU3FwbUI4MUhMcDFaczQ0a3BjY3huTWdqRTh6?=
 =?utf-8?B?a2h5MEdhc240WS9qOGtuMGJBTWR4U3Y0WUV3UEQzWjFzNGdKVyt1RlNVWEJM?=
 =?utf-8?B?Um5NdWs0ZERRY2NHMVpOM2NpQUIwekF5N3ZpNk1nc0pmWlZyMStSRzJWRlla?=
 =?utf-8?B?ZjRVRGZWZURNM1BscFJtaVp2VFZoek1xeUdTWFQvNnNyL2JodDgvaVBUN2tO?=
 =?utf-8?B?KzF1ZkZOcjIzN05vVlhmcHdvdDZ0NFBBU2JuTENUTkhoMExyd2xmU25xTU03?=
 =?utf-8?B?czNuU29JdER6ckZyR3NXRFJUUURGMUxKRkhsZ2NLelVsbm9SRXRsNG1hZEh2?=
 =?utf-8?B?amx3Sk96UkxNNnd0UUJjYmsxOFdGTGNzRWVJR1BobWl1ekVoQkltUnU3bkV2?=
 =?utf-8?B?dit1bHZPdTk2VXhVYWZkaUZ6ZXAzYnNDeDducGhUeXFLa0JPOEFHZVdWYUV1?=
 =?utf-8?B?anlTa0g3ZzlrU1UrNzJnK1JMc0VGVGdLNHk4NCtadENzdXMxNGl3Yk1hNnN6?=
 =?utf-8?B?S2xuNkFaNkxyZ0JxNTBvZUcvVjNsVFVCdWRsZm9mZzFPeDVMVjFDMTU1elI5?=
 =?utf-8?B?R3VJYmc0M1ZEamtZYWZiUmc4M0oyS2EyaWV6V21nTTdkNUNOYWdjczRldjl3?=
 =?utf-8?B?ZTNGQ20zWFdvTmhXQXpPditUSE1wYkpWUVk5azE1SDQ3ZzFzczc0WTE4NjFi?=
 =?utf-8?B?cU40dHV1c0I5dGFkRk11L0xPcGlPZnRBZndDbkhYRlh2Y0RNK0dIOXNXUFhW?=
 =?utf-8?B?SUxscTZhN2xIVnpuZEZQblpPY2ZQeDhiVk9LMnZZRlR4TzhYek80L3JXM2Qw?=
 =?utf-8?B?UVJDYVBmYmtWdkJJR1BwYXhRa1Vla1JzblZVRWx5bllvZ0xuNVpsWWxiOFBo?=
 =?utf-8?B?M05TTHVBUE1WcnN3THRITnRzTEdXQUFGVUdNL3VHV2Y2K0thSk9qRmtpb0p2?=
 =?utf-8?B?bkhTZXphSG9VRjdEOTlpemZFR25LVCs4eHFWNWRURHRIWm42TThmSHRaanl3?=
 =?utf-8?B?RERCNEl3aElvd1RlRFlUYTgxREtuckVQTXl3S2daZ2JwMEN1LzRJelI2YVpM?=
 =?utf-8?B?Y2dvRXd2aEpHbnEwbGQ4OWNwc3hJR3Bva2llU3pGbXQySVpBdThWOHoyZFJv?=
 =?utf-8?B?OG1Vd2owU2dJcnV2eGNucXVJOHdqY1N6b2liTVFhVHhFTmxVMVJ1TElsZFNG?=
 =?utf-8?B?L1JHV1oxRjRTaWtpVmM3Qm5zS0VWRytXZElDdW9JMm5rYTNGMk9BL1BMcXdE?=
 =?utf-8?B?czFtc1JtRG9Ub2k3TUw4cDRHUTBHUGRZaVcxNTBSUGJLZ1h0azhUaldsZUI5?=
 =?utf-8?B?Y0VOdTdVL3N4WDBQakphNktsc0R5RXo0b3pwdFBCL1FocGtRRWxuT1ZYdkxs?=
 =?utf-8?B?aWpHTmRPRE9RMUl1T3oxNmlDWHIvMHdDUjV2ajdFOGFPRk5Rd2E4bHlEQlpt?=
 =?utf-8?B?d2syV0JsRElOdG81VjM2TkgrZGNESk5HVStaMnBaZ0FwSEJxQU1qV3VVVi95?=
 =?utf-8?B?Y2l0TWl0OXpkeGVPUTJjczNUZGh3UW9CWlpUNFMxdWI2amdRVjVVWDNaUzZl?=
 =?utf-8?B?R0x3OFkxOHg2Q3JwbFBkRkQyT1BoR0U4aGZZQjYzM2lnWXg4WlVUWmhGT0hW?=
 =?utf-8?B?aTBNc0pKc1Y5cXNJd214MGl0T3lzVm9Hbko2NFZVQmQ5cExEUVBSMlJsUjZ6?=
 =?utf-8?Q?5YETE7gQD4eq+8po=3D?=
X-Exchange-RoutingPolicyChecked: Hpbyxn3+qIT56ZtCqJ3bIY9EaQgbgapN4fMPrVnPTNJxRyAaQ+z73RU1YkzNENZ60j36tquJsZW7O/hHCeszWOcZG1RL7OceMMcMOfSy0SOinDRp4l9xm/Ga4uHxtA6vYStlhkEsiTYB1lfk/MstL2i7qv9+qDKZFbLmXx4Lx4QdQcrXCRiH8AOXGeGP9N5sucIi2UvrhXJVVCN1Ft0H3iz11w3mXg1smchllzGFDcvsfjcEZjraH/R4nJsW6ksvgpHbL4tbCgwh799WYMBZOMssR/k63GigEk+suKxQVf1NAuErPLxA3O7v5MM2X2rgxU4CE9hGKlNxV7cD4OJlNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e53af0e5-16a4-4af5-cf6e-08dee598b853
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 13:22:02.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAkWHexzkF6i+ghBH0qXRQn1od317CVIBuqy5CaqbgX3PJ5JdUPD3fpFFeFVBSzKeBQ29g3tq5kWUhww8Obgx3haCJkOdfTbjE3J0EYCK+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5012
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 11:58:24PM +0200, Jason Xing wrote:
> On Tue, Jul 14, 2026 at 4:08 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > The zero-copy Tx batch parser stops when it encounters an invalid
> > descriptor. If this happens after one or more continuation descriptors,
> > the Tx consumer can be advanced past fragments that are neither submitted
> > to the driver nor returned to userspace through the completion ring.
> >
> > A similar problem occurs when a packet exceeds xdp_zc_max_segs. The
> > descriptors consumed up to the limit are released without completion, and
> > the remaining continuation descriptors can subsequently be interpreted
> > as the beginning of another packet.
> >
> > Parse Tx batches in packet units and distinguish descriptors belonging to
> > complete valid packets from descriptors consumed while draining an
> > invalid or oversized packet. Return the former to the driver and append
> > the latter to the CQ address area so userspace can reclaim their UMEM
> > frames.
> >
> > Once draining starts, continue until the packet's end-of-packet
> > descriptor is consumed. Preserve the drain state on the socket when EOP
> > has not yet been supplied, so draining can continue during a later call.
> > Leave incomplete but otherwise valid packets on the Tx ring. Keep the
> > existing handling of standalone invalid descriptors unchanged.
> >
> > Shared-UMEM pools using multi-buffer Tx also need packet-framed parsing.
> > Walk their Tx sockets one packet at a time, preserving the existing
> > per-socket fairness scheme, instead of using the legacy one-descriptor
> > fallback. Keep that fallback for shared pools that do not use
> > multi-buffer Tx. Since the drain state is maintained per socket and both
> > the singular and shared paths can resume an interrupted drain, changing
> > the socket list from singular to shared requires no special bind-time
> > transition.
> >
> > CQ entries are positional, and drivers may complete only part of the Tx
> > work returned by xsk_tx_peek_release_desc_batch(). Therefore, reclaim-only
> > entries cannot be published immediately when earlier driver-visible
> > descriptors are still outstanding.
> >
> > Track the number of driver-visible CQ entries preceding the reclaim
> > entries. Let xsk_tx_completed() publish partial real Tx completions, and
> > publish the reclaim entries only after every earlier Tx descriptor has
> > completed. Complete a reclaim-only batch immediately when there is no
> > driver-visible work in front of it, and prevent another Tx batch from
> > being appended while reclaim entries remain pending.
> >
> > Also cap batch processing by the size of the pool's temporary descriptor
> > array, as Tx rings belonging to sockets sharing a UMEM may have different
> > sizes.
> >
> > This ensures that every descriptor consumed as part of an invalid
> > multi-buffer packet is eventually returned to userspace without exposing
> > the dropped packet to the driver or violating CQ completion ordering.
> >
> > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Thanks for working on this big patch! It's not easy to fix it in a
> simpler way, I think. And I didn't observe any obvious performance
> impact by xdpsock.
> 
> Overall, it looks good to me except for a few minor points:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> > ---
> >  include/net/xsk_buff_pool.h |   3 +
> >  net/xdp/xsk.c               | 192 ++++++++++++++++++++++++++++++++----
> >  net/xdp/xsk_buff_pool.c     |   1 +
> >  net/xdp/xsk_queue.h         |  76 ++++++++++----
> >  4 files changed, 232 insertions(+), 40 deletions(-)
> >
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index f5e737a83055..2bb1d122b1bc 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -78,6 +78,9 @@ struct xsk_buff_pool {
> >         u32 chunk_size;
> >         u32 chunk_shift;
> >         u32 frame_len;
> > +       u32 tx_descs_nentries;
> > +       u32 reclaim_descs;
> > +       u32 tx_zc_pending_descs;
> >         u32 xdp_zc_max_segs;
> >         u8 tx_metadata_len; /* inherited from umem */
> >         u8 cached_need_wakeup;
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 385a3f4a1b32..2909a0ec6837 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -499,6 +499,23 @@ void __xsk_map_flush(struct list_head *flush_list)
> >
> >  void xsk_tx_completed(struct xsk_buff_pool *pool, u32 nb_entries)
> >  {
> > +       u32 reclaim_descs = READ_ONCE(pool->reclaim_descs);
> > +
> > +       if (unlikely(reclaim_descs)) {
> 
> Just a side note: it might impact the performance because new descs
> need to wait for the existing descs to be completed if there are
> reclaim descs.

That is a tradeoff for dealing with this corner case i'd say.

> 
> > +               u32 pending_descs = READ_ONCE(pool->tx_zc_pending_descs);
> > +
> > +               if (nb_entries < pending_descs) {
> > +                       WRITE_ONCE(pool->tx_zc_pending_descs,
> > +                                  pending_descs - nb_entries);
> > +                       xskq_prod_submit_n(pool->cq, nb_entries);
> > +                       return;
> > +               }
> > +
> > +               WRITE_ONCE(pool->tx_zc_pending_descs, 0);
> > +               nb_entries += reclaim_descs;
> > +               WRITE_ONCE(pool->reclaim_descs, 0);
> > +       }
> > +
> >         xskq_prod_submit_n(pool->cq, nb_entries);
> >  }
> >  EXPORT_SYMBOL(xsk_tx_completed);
> > @@ -574,24 +591,162 @@ static u32 xsk_tx_peek_release_fallback(struct xsk_buff_pool *pool, u32 max_entr
> >         return nb_pkts;
> >  }
> >
> > +static void xsk_tx_commit_batch(struct xsk_buff_pool *pool,
> > +                               struct xsk_tx_batch *batch)
> > +{
> > +       u32 nb_descs = xsk_tx_batch_cq_descs(batch);
> > +       u32 cq_cached_prod;
> > +
> > +       if (!nb_descs)
> > +               return;
> > +
> > +       cq_cached_prod = pool->cq->cached_prod;
> > +       xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_descs);
> > +
> > +       if (unlikely(batch->reclaim_descs)) {
> > +               u32 cq_pending_descs;
> > +
> > +               /* CQ is positional. Descriptors already written but not
> > +                * submitted must complete before any reclaim-only descriptors
> > +                * appended below.
> > +                */
> > +               cq_pending_descs = cq_cached_prod - xskq_get_prod(pool->cq);
> > +
> > +               WRITE_ONCE(pool->tx_zc_pending_descs,
> > +                          batch->tx_descs + cq_pending_descs);
> > +               WRITE_ONCE(pool->reclaim_descs, batch->reclaim_descs);
> > +               if (unlikely(!pool->tx_zc_pending_descs))
> > +                       xsk_tx_completed(pool, 0);
> > +       }
> > +}
> > +
> > +static struct xsk_tx_batch
> > +__xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> > +                                struct xdp_desc *descs, u32 max_descs)
> > +{
> > +       struct xsk_tx_batch batch = {};
> > +       u32 entries;
> > +
> > +       entries = xskq_cons_nb_entries(xs->tx, max_descs);
> > +       if (!entries)
> > +               return batch;
> > +
> > +       batch = xskq_cons_read_desc_batch(xs, pool, descs, max_descs);
> > +       if (!xsk_tx_batch_cq_descs(&batch)) {
> > +               xs->tx->queue_empty_descs++;
> > +               if (batch.consumed_descs) {
> > +                       __xskq_cons_release(xs->tx);
> > +                       xs->sk.sk_write_space(&xs->sk);
> > +               }
> > +               return batch;
> > +       }
> > +
> > +       __xskq_cons_release(xs->tx);
> > +       xs->sk.sk_write_space(&xs->sk);
> > +       return batch;
> > +}
> > +
> > +static struct xsk_tx_batch
> > +xsk_tx_peek_release_shared_desc_batch(struct xsk_buff_pool *pool, u32 max_descs)
> > +{
> > +       u32 cq_descs_before, cq_descs_after;
> > +       struct xsk_tx_batch sum_batch = {};
> > +       bool budget_exhausted;
> > +       u32 per_socket_budget;
> > +       struct xdp_sock *xs;
> > +
> > +       /* The fairness quota must allow one maximum-sized valid packet. */
> > +       per_socket_budget = max_t(u32, MAX_PER_SOCKET_BUDGET,
> > +                                 pool->xdp_zc_max_segs);
> > +
> > +again:
> > +       budget_exhausted = false;
> > +       cq_descs_before = xsk_tx_batch_cq_descs(&sum_batch);
> > +       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list) {
> > +               u32 budget, budget_left, offset, remaining;
> > +               struct xsk_tx_batch curr_batch;
> > +
> > +               /* Once reclaim-only descriptors have been appended to the CQ
> > +                * address area, do not append driver-visible Tx descriptors
> > +                * from another socket after them. xsk_tx_completed() relies on
> > +                * all driver-visible descriptors preceding all reclaim-only
> > +                * descriptors in CQ order.
> > +                */
> > +               if (sum_batch.reclaim_descs)
> > +                       break;
> > +
> > +               /* be gentle when playing with pool->tx_descs */
> 
> Minor nit: seems unneeded comment?

this has been my helper/reminder that we need to respect already consumed
space at tx_descs array; i can remove it

> 
> > +               offset = xsk_tx_batch_cq_descs(&sum_batch);
> > +               if (offset >= max_descs)
> > +                       break;
> > +
> > +               if (xs->tx_budget_spent >= per_socket_budget) {
> > +                       if (xskq_cons_nb_entries(xs->tx, 1))
> > +                               budget_exhausted = true;
> > +                       continue;
> > +               }
> > +
> > +               budget_left = per_socket_budget - xs->tx_budget_spent;
> > +               remaining = max_descs - offset;
> > +               budget = min(remaining, budget_left);
> > +
> > +               curr_batch = __xsk_tx_peek_release_desc_batch(pool, xs,
> > +                                                             pool->tx_descs + offset,
> > +                                                             budget);
> > +               if (!xsk_tx_batch_cq_descs(&curr_batch)) {
> > +                       if (curr_batch.budget_limited && budget_left < remaining)
> > +                               budget_exhausted = true;
> > +                       xs->tx_budget_spent += curr_batch.consumed_descs;
> > +                       continue;
> > +               }
> > +
> > +               xs->tx_budget_spent += curr_batch.consumed_descs;
> > +               sum_batch.tx_descs += curr_batch.tx_descs;
> 
> No need to use '+' here because of the previous reclaim_descs check.

hmm correct!

> 
> > +               sum_batch.reclaim_descs += curr_batch.reclaim_descs;
> > +       }
> > +
> > +       cq_descs_after = xsk_tx_batch_cq_descs(&sum_batch);
> > +
> > +       if (sum_batch.reclaim_descs || cq_descs_after >= max_descs)
> > +               return sum_batch;
> > +
> > +       /* Continue filling the batch while this pass made progress */
> > +       if (cq_descs_before != cq_descs_after)
> > +               goto again;
> > +
> > +       if (!budget_exhausted)
> > +               return sum_batch;
> > +
> > +       list_for_each_entry_rcu(xs, &pool->xsk_tx_list, tx_list)
> > +               xs->tx_budget_spent = 0;
> > +       goto again;
> > +}
> > +
> >  u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
> >  {
> > +       struct xsk_tx_batch batch = {};
> >         struct xdp_sock *xs;
> > +       bool umem_shared;
> >
> >         rcu_read_lock();
> > -       if (!list_is_singular(&pool->xsk_tx_list)) {
> > -               /* Fallback to the non-batched version */
> > -               rcu_read_unlock();
> > -               return xsk_tx_peek_release_fallback(pool, nb_pkts);
> > -       }
> > +       if (unlikely(READ_ONCE(pool->reclaim_descs)))
> > +               goto out;
> >
> > -       xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock, tx_list);
> > -       if (!xs) {
> > -               nb_pkts = 0;
> > +       xs = list_first_or_null_rcu(&pool->xsk_tx_list, struct xdp_sock,
> > +                                   tx_list);
> > +       if (!xs)
> >                 goto out;
> > -       }
> >
> > -       nb_pkts = xskq_cons_nb_entries(xs->tx, nb_pkts);
> > +       nb_pkts = min(nb_pkts, pool->tx_descs_nentries);
> > +       if (!nb_pkts)
> > +               goto out;
> > +
> > +       umem_shared = !list_is_singular(&pool->xsk_tx_list);
> > +
> > +       if (umem_shared && !(pool->umem->flags & XDP_UMEM_SG_FLAG)) {
> > +               rcu_read_unlock();
> > +               return xsk_tx_peek_release_fallback(pool, nb_pkts);
> > +       }
> >
> >         /* This is the backpressure mechanism for the Tx path. Try to
> >          * reserve space in the completion queue for all packets, but
> > @@ -603,19 +758,16 @@ u32 xsk_tx_peek_release_desc_batch(struct xsk_buff_pool *pool, u32 nb_pkts)
> >         if (!nb_pkts)
> >                 goto out;
> >
> > -       nb_pkts = xskq_cons_read_desc_batch(xs->tx, pool, nb_pkts);
> > -       if (!nb_pkts) {
> > -               xs->tx->queue_empty_descs++;
> > -               goto out;
> > -       }
> > -
> > -       __xskq_cons_release(xs->tx);
> > -       xskq_prod_write_addr_batch(pool->cq, pool->tx_descs, nb_pkts);
> > -       xs->sk.sk_write_space(&xs->sk);
> > +       batch = umem_shared ?
> > +               xsk_tx_peek_release_shared_desc_batch(pool, nb_pkts) :
> > +               __xsk_tx_peek_release_desc_batch(pool, xs,
> > +                                                pool->tx_descs,
> > +                                                nb_pkts);
> > +       xsk_tx_commit_batch(pool, &batch);
> >
> >  out:
> >         rcu_read_unlock();
> > -       return nb_pkts;
> > +       return batch.tx_descs;
> >  }
> >  EXPORT_SYMBOL(xsk_tx_peek_release_desc_batch);
> >
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 12c9fb29af05..a4089480b22b 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -51,6 +51,7 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> >         if (!pool->tx_descs)
> >                 return -ENOMEM;
> >
> > +       pool->tx_descs_nentries = nentries;
> >         return 0;
> >  }
> >
> > diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
> > index 3e3fbb73d23e..a15ff1929db6 100644
> > --- a/net/xdp/xsk_queue.h
> > +++ b/net/xdp/xsk_queue.h
> > @@ -58,6 +58,18 @@ struct parsed_desc {
> >         u32 valid;
> >  };
> >
> > +struct xsk_tx_batch {
> > +       u32 tx_descs;
> > +       u32 reclaim_descs;
> > +       u32 consumed_descs;
> > +       bool budget_limited;
> > +};
> > +
> > +static inline u32 xsk_tx_batch_cq_descs(const struct xsk_tx_batch *batch)
> > +{
> > +       return batch->tx_descs + batch->reclaim_descs;
> > +}
> > +
> >  /* The structure of the shared state of the rings are a simple
> >   * circular buffer, as outlined in
> >   * Documentation/core-api/circular-buffers.rst. For the Rx and
> > @@ -263,17 +275,18 @@ static inline void parse_desc(struct xsk_queue *q, struct xsk_buff_pool *pool,
> >         parsed->mb = xp_mb_desc(desc);
> >  }
> >
> > -static inline
> > -u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> > -                             u32 max)
> > +static inline struct xsk_tx_batch
> > +xskq_cons_read_desc_batch(struct xdp_sock *xs, struct xsk_buff_pool *pool,
> > +                         struct xdp_desc *descs, u32 max)
> >  {
> > -       u32 cached_cons = q->cached_cons, nb_entries = 0;
> > -       struct xdp_desc *descs = pool->tx_descs;
> > -       u32 total_descs = 0, nr_frags = 0;
> > +       bool drain = READ_ONCE(xs->drain_cont);
> > +       u32 cached_cons, nb_entries = 0, released;
> > +       struct xsk_tx_batch batch = {};
> > +       struct xsk_queue *q = xs->tx;
> > +       u32 nr_frags = 0;
> > +
> > +       cached_cons = q->cached_cons;
> >
> > -       /* track first entry, if stumble upon *any* invalid descriptor, rewind
> > -        * current packet that consists of frags and stop the processing
> > -        */
> >         while (cached_cons != q->cached_prod && nb_entries < max) {
> >                 struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
> >                 u32 idx = cached_cons & q->ring_mask;
> > @@ -282,26 +295,49 @@ u32 xskq_cons_read_desc_batch(struct xsk_queue *q, struct xsk_buff_pool *pool,
> >                 descs[nb_entries] = ring->desc[idx];
> >                 cached_cons++;
> >                 parse_desc(q, pool, &descs[nb_entries], &parsed);
> > -               if (unlikely(!parsed.valid))
> > -                       break;
> > +               if (unlikely(!parsed.valid)) {
> > +                       if (!drain && !nr_frags && !parsed.mb)
> 
> I understand you're fixing the mb problem here. But I'm wondering if
> it still has a problem in the non mb case because the single invalid
> packet (mb ==0, nr_frags == 0, drain == 0) that isn't published in CQ
> cannot be tracked by application?
> 
> My thinking is to just remove the above line in this patch. Or I can
> cook a follow-up patch to fix this specific problem?

Good catch - seems I got too focused at mb case and now we have a bit of
misbehave as invalid mb descs are cq produced and standalone not.

I'm gonna address this and align standalone descs (in generic xmit as
well) that are invalid so they are also cq published, not silently wiped
out from tx ring only.

Thanks! sending v4.

> 
> Thanks,
> Jason
> 
> > +                               break;
> > +
> > +                       drain = true;
> > +               }
> > +
> > +               nr_frags++;
> > +               nb_entries++;
> >
> >                 if (likely(!parsed.mb)) {
> > -                       total_descs += (nr_frags + 1);
> > -                       nr_frags = 0;
> > -               } else {
> > -                       nr_frags++;
> > -                       if (nr_frags == pool->xdp_zc_max_segs) {
> > +                       if (unlikely(drain)) {
> > +                               batch.reclaim_descs = nr_frags;
> > +                               WRITE_ONCE(xs->drain_cont, false);
> >                                 nr_frags = 0;
> >                                 break;
> >                         }
> > +
> > +                       batch.tx_descs += nr_frags;
> > +                       nr_frags = 0;
> > +                       continue;
> > +               }
> > +
> > +               if (nr_frags == pool->xdp_zc_max_segs)
> > +                       drain = true;
> > +       }
> > +
> > +       if (nr_frags) {
> > +               if (drain) {
> > +                       batch.reclaim_descs = nr_frags;
> > +                       WRITE_ONCE(xs->drain_cont, true);
> > +               } else {
> > +                       if (nb_entries == max)
> > +                               batch.budget_limited = true;
> > +                       cached_cons -= nr_frags;
> >                 }
> > -               nb_entries++;
> >         }
> >
> > -       cached_cons -= nr_frags;
> > +       released = cached_cons - q->cached_cons;
> >         /* Release valid plus any invalid entries */
> > -       xskq_cons_release_n(q, cached_cons - q->cached_cons);
> > -       return total_descs;
> > +       xskq_cons_release_n(q, released);
> > +       batch.consumed_descs = released;
> > +       return batch;
> >  }
> >
> >  /* Functions for consumers */
> > --
> > 2.43.0
> >
> 
