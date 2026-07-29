Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E45442B0C;
	Wed, 29 Jul 2026 09:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317787; cv=fail; b=eF90ak6r1zy7yCREzWmoTFSbPLRwSf1JiTldRrMGUpAIW86tWjUGqRzFkhypPHrFOQ0D4nyTB2Rji/1XQv4Rzh4NrJbWp5B2GHfLsnK2Jvdk+j1UWqrsnTt3QdX/ZjoeuIBbkLJRDUKUt3wZTyGymb6ICwIUkWpupJx7u+9jZ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317787; c=relaxed/simple;
	bh=m38ZtzJduYCKZR7FfZ2rbtNhhP5Er+h70OhxKRif4ec=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K+mmEQT9WmM6X7uDSp43o7I5f5Dasr5imbgH8GtElGhX9XH0Yn7+eBkLIeMySyupZe0pkA815APlhvtHnemSSZZByYm17FHbtsn2td+td92p4v+foXYR3WwE/xSqMCDJYJz6nunPmJ8ABJfD5+qCrtJp4VGqzfa96B7koC/vH2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/dVhAn1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/dVhAn1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785317786; x=1816853786;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=m38ZtzJduYCKZR7FfZ2rbtNhhP5Er+h70OhxKRif4ec=;
  b=g/dVhAn1gXKFMTPlm0vPQnhNWraxdYSyr5kSNHKl9252dwT0hLb7d7dw
   DhZR+qT1XmumKdFuvGaZuvZyUsC9WswAFhAhdPx0Jur+09Up2GMZJqIIE
   /p5Ub1ObGZ/kQ9/XgR12riRWa2Rg94mS1ZtppyCeNwnnxzxk0KCt/yOQ+
   RcW9girT0xvFXEtYk6VwsBX5eVJpNtOPx4GzWYdOITTFagiQRzqIeRe/J
   kiYvXNsuViEF9LVIu3zTx26Saodf/+lkeIqCT8q1k5BelwQf5kqylXj9r
   V7RYp6MorOH+1W4Uq/kqMI1U7v2iDzdhe+navVwhWF02On3gzLjEi9orj
   g==;
X-CSE-ConnectionGUID: W+bXARPrQC+FnFDxUy0TpQ==
X-CSE-MsgGUID: fskshyvXQLm+R/QgM0dvXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96277051"
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="96277051"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 02:36:25 -0700
X-CSE-ConnectionGUID: sJYw1LCIRzGqo+61YCWB5A==
X-CSE-MsgGUID: ZarJj2i3Qp+qzsnwhSiqSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,192,1779174000"; 
   d="scan'208";a="263764270"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 02:36:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 02:36:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 29 Jul 2026 02:36:24 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 29 Jul 2026 02:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHcDgITQmwmt153HEdlZ3AOecqAMQLOTPYZZSsebc7JpmXlOQQ1ktxVWKQbfk/FMzoll+1xjnGEiPfrWiP07zsNn6omWJYJYoDmxJh/4+8gjty8XLgRmvSe3/PjOjz2YAd/63r07OKvu8BDYuOw77QZxo62GmWLDV0cRV+mUsP/5sPqrtmkjokPdPD2o+GnK9iuQD5zr0jKHVAlksfXZVuJbET+xw+wv8YW2poGRoBLrpUThTBku/VZgovQ+iaFHUgrSlAi01nZ59xrAsdXku9VFR3vxlXsJ2tG2VCPFcWFOr9Z42XGeHmPQIDm7IVwlQDzJOQ0mIDTZ6p1M2mxC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjpmEYwi+DDrvc3xGWdHaorkvzgzIm9qy9MVgzIy0xI=;
 b=Bc9hzs87pQQKNjG6xZcqFH97d/8s0iZU8/QCaxzvk3FF8MdMgzhxS2sNzjmzl2yk3/BS6zM2vS/TbMkJWa5abUiBHeGMc156q0vkUEuNJef62XSNW0mYevy1UwoAGHPL9KwuoglOxaSVuYGRODqwa2wzP7KU1G/qiImkeflfTisfLbNU8TeUZK1Q9dplqaUGK4FYStC/OF/5xnX90T1RsifYDISdiGJwcJvjpdN3dEL95NmukXZGVTPbmgznLi8ePfeoQEwKVGH1Vmsu7GVDB400eHTUy2LKR/cHcKDojH3OvFOO+d7OExCqGcrxZ/Vl22Q842bxSiVaPOlwS5Rcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA0PR11MB7209.namprd11.prod.outlook.com (2603:10b6:208:441::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:36:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 09:36:16 +0000
Date: Wed, 29 Jul 2026 11:36:09 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>, <magnus.karlsson@intel.com>,
	<sdf@fomichev.me>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
Message-ID: <amnJiQHa9s5PtLek@boxer>
References: <20260725034246.192091-1-blbllhy@gmail.com>
 <amdJgi0V3YwWE7oL@boxer>
 <CAL+tcoA8KPn7z3p7KymQLT4apwcaCy1Yi8P0S5KD-f91jxmwhw@mail.gmail.com>
 <amiTZFpTTx7jHurQ@boxer>
 <CAL+tcoA5BV4kbvU5drKD8N4Hwg=gQ9z0oSa4UQtN=FaOtM3KRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoA5BV4kbvU5drKD8N4Hwg=gQ9z0oSa4UQtN=FaOtM3KRA@mail.gmail.com>
X-ClientProxiedBy: DB9PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::24) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA0PR11MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd8e736-4e39-4279-c6fe-08deed54d681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|56012099006|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DVbuLOANXxgYYUp249q3pLfyKODdZ5WWrvE0mVzn/mFBR3DnzwfzwUa5+f3+t0y4OE8ns++PnWc18B8fJ8FexswtUmK0yNBFHZjCGeNEf6hPdPQmN90+I0xZtC4hfVLBTbdFXgTEEVHJczQ/naS64znYE+9Bdu7nQrOMCBSlpfA+q3tcNrizpGqDWLlR+93ba4+2Sc4wRq41pkUbhmufVbCkJaMsELj2JsEEodPMq6jNVtHEFkrtLsHXyG279Wx8r6v2YLYkC7dtmi3zAAy3qwUelWhqdYgoD5IOvaeFuEl2tD9FOZDwZqzHYJuJ1xkASqyrmHKHlLBzeo1F+wze8Kq4gKa1XFJJGb8YgR99h7wn/C2hSjS18kXYq7yLXyf6kTlu2L0Q3YsPyonuuo8Xa1sOtOljK7OzokpSRxQBUKF0vDG7Uv+tKh5cl75BTNl3OphDVSU41HJKvmvZtspugNDbxiCH19HDhiwFaTnBMSp3G0M9KCX8nVBzbp8z2TVo0Ifz7qIqBIkHDhbYfTmxTzJDxSWHwLf13PoELYd6fxA/bvqsi7H1aEdsXcZFtOyKT3BbA2W3ywQ8ndiSerS9dUFiM3fmMzsicm6x93XQ9Wwkip2r0LxVvPgg7TbPbxh6E4RLjLijrEGnTVscKj3NHwp8zl5GRiivV9P5WWTwlfo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnh3MDdRTnF2OEJoa1ZyQVhNbHB2b2RNdFV2ZS9CQ09Uc1VmNmNtSzF0Njdm?=
 =?utf-8?B?NGJzWC80OHFqNHJTMFNnWDlrTXY5eGxhRjdQVDllUTBaRjRoRkF6UjRqQ01Z?=
 =?utf-8?B?ajJpL2lxZDZaK0RQWjFBSDlHZDk2WndCTDNzUlg1RUZ2QUVPQXQzakZQTm5n?=
 =?utf-8?B?azI3OHEvLzBKWXVPazJZQ3B6bGV0TnAzeER4UWV6UHFmdnNNaFlKcWlkbHlR?=
 =?utf-8?B?WEExQXpaS1NLWlM2U3JWaW1NNXRXZjFFdXI3aDMxVHlMdDBPTUNBM0tVZDFG?=
 =?utf-8?B?bG9kTElRb3QvdDNNKzFwaDdPNjNlOVVDK1l5SHJuY1JUalh2bk11MDRTSTM5?=
 =?utf-8?B?U2xxVGJldEJwbFdKQnF0RWVZVDdqVzVDUnNmbUVHek9RRitJTzd5cmVqVHMy?=
 =?utf-8?B?ZmZXTTlmWHJzN1dDbmtsU3UrazY2MlpnVDJtbjlOMmVwU3RjS0ZNNjZiUGJZ?=
 =?utf-8?B?QjVDb2l3VTAwVW5lSFU4T29FWlBRZU11bC84VEdscGJRWjQ3SlFNQU9xcUZu?=
 =?utf-8?B?ZE04NTlXbDMvWEdnR3hxazFsZk5rbnMzRUV6UysxR2ZWb1F4Mi9VN0Y1dFl4?=
 =?utf-8?B?T1h4NnJrN0ZDRTRnK1hQRTBlMXlHS3NaWUEzc0RSNm1UYlYvWTdnM2FCRmNo?=
 =?utf-8?B?QVdTai9VSTlPV1Q3eTZmQmJMWDFGU20vRnV1eUpiYng2djRrdHdCcnVLWkZZ?=
 =?utf-8?B?RWlTNUdndWg2YzZtMlFXbVJRZnpyL2dNRmRPNmU5UXVpU1R5TWhJYlU4U2Fh?=
 =?utf-8?B?VkFTZFRQRDRyeVVpeENCQXZNZDJRWHBHUEdTbVF1L3VkN091T1JyaWhSTDRB?=
 =?utf-8?B?UElqMHNGY0p3Y2tzeVo0ZEhXM0xZWUIwbWVFTjhJdmpXV0lFUVoxUDNHVDZX?=
 =?utf-8?B?UFhHT1VNSFFPeUNPaG1TYlZXaERoVDN1TENYZkh2cXNmdEloSTBtUEZiY3NB?=
 =?utf-8?B?NDR5SGdsdVlxZDBTRzVYaWNtUG9yckR5UnFUV05PTW4wMGVMa1BuZFlFVjNH?=
 =?utf-8?B?TUZwNXRSWWloWCtZUG1PYzhOR2M5dnJWUm1tckJ0V2N1L2M0aFgvRHFXM1BI?=
 =?utf-8?B?RnFQbzNrejFpM2FaYnVxTkljblR4emxOWWVvREFpd2RjNFp1UkdDQ2hVa3Bj?=
 =?utf-8?B?aU8zdHVwek9qOU42QWh2R2x4SjQ2VFhvTEtEaFFXS1orTnMwcko4RUZnQzlr?=
 =?utf-8?B?Sm9Ma2dCUGFseE9Pc3N5WkErRXFWbWQ0TlEvVTlLSXFQc1ZycnFYT2FrQkpF?=
 =?utf-8?B?WWtCMXVueTc2UlZJTnVEenh4Z1NCS25qVlVTRC9oZmJhQ2pZd253ZXRyNEh4?=
 =?utf-8?B?MHhWUHExdzRvRHFEMzZmRzZPd3NURlRrclBvdCtkeVF3SUh1Q3d6SVB1Q0Rr?=
 =?utf-8?B?Vnl0UXVxQ1p0MStsMWJ0bjBlVzMrbnQxOEhoSWRZTlB4TXozbjlaMVdEbTcr?=
 =?utf-8?B?M1dmbFpUYVBHZWZNTm5zSXFOdnBGQjN3aUx0ZW13S0FWcnA0bmRKcUtpVDJQ?=
 =?utf-8?B?ZmZPRkpCVEU2aW5Kd2ZyY0ZVbXlsbXNQRFU5UWRHT250YU9JV1FUK0phajJl?=
 =?utf-8?B?clVXYjJMUERCYW9tcGw0NnlvY1FaYlhvcFFsUHFDbXMxUVRCc0tVa3FOMjA5?=
 =?utf-8?B?NytocWRNaUhlVkVIRDZtYVkxSG41N2RBZEFBZXRocnk5dnhrMG5hd09CNERN?=
 =?utf-8?B?TjAzWXRKTXhIL240UFVDVEZmcGR3enl6aXp6Tk5aOC80S2o3VnBhMDhFVjVu?=
 =?utf-8?B?RmFwNFdSV3Bxa0d0Wmp5Q2tPQ3plc2V2THJKZmdpTkZkT0czamN4RTVKTytL?=
 =?utf-8?B?RS91WUJ1VVphMXR4K0o4b0pOUHk3Um45K3pBYVJOOG56ZzdKcGZGcGtKMnpp?=
 =?utf-8?B?MXNscmsrdVFYbWFqekF4eXIwekhxRkE4MktrKzFrUlNpRzM1V1FCY1BKdDR0?=
 =?utf-8?B?K3RUQU9uTzczMnFaZjBxSXJBcGRHNmI2YThralZkOWtta1NXa29oR2hCS1gw?=
 =?utf-8?B?d0pXd1JZWEhodFoyNjF5WHhTc05rcUdITFhSUzBIV0drVnRQWGlQZlB5U0Nt?=
 =?utf-8?B?dm4ycUsySkdEY3dJM0FXcnJSaHhDRmY2V0VPaVZFQ0hueUdaRGY1MzlCVWsv?=
 =?utf-8?B?WFJ5dS9ObitkOGtjbUJIVXovZVFsMHU4b1RQUjR6UTRTVnIwQzFYVUxseDdR?=
 =?utf-8?B?Z0oxK3pWd0szMUZIeW1pTjk1UHJRU2JVMElJMi9EOGdLTEFjbitkd2xzUDNL?=
 =?utf-8?B?Zy9xd005SUM2RjBpWGxNTkR0MVlWaktHaWdZZEtVUUJTSHEyYWloU2VEOHZw?=
 =?utf-8?B?MXQwbDdDcDNTazY2azByYkNUdUJsL0RiRkdqc0dpeUVUQW5ZcTRHT3oxMHl5?=
 =?utf-8?Q?XERlaeoSSNF7neJg=3D?=
X-Exchange-RoutingPolicyChecked: Ouv+PH0XASq/ReTc/xYXRV60GX/iZtA6/mXBKEZJ1X5dtDpOKp6fMKRkvWLZmo32vs79/VeFaMXZ2yK57NlSWDhD9ri7CScJaZyj9q3Es9tln4RE8syCeTcgaqXLwWnlI4oVb1OtPWczNtEWpv0PR/5hRU/mDFGRECPjLv/nBkjxnrenS1ULKqoi0XDABruX5PWVRCJLgAAV3kYNHZBO3m4PQj3UXttLKfL3gzOUJVlL5UQJpG5+GjXhjR9Uy1AoJpcm7B33BZCN586Binyw6QadMNCv1Srp3x1ozqy3zY28hAX9ia1e3fTS7SQ5d7ahKh2fGyU0QuO3VS5DwC0Kig==
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd8e736-4e39-4279-c6fe-08deed54d681
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:36:16.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rov26MjF6H/gwMGrQY3UiUj56tE8ns1dtCsp66OghCC/60lBLZz3WHDc45l0cNyXfSiMrwvdgEBxYv9PKPgtDzDHFVz/bJrq4l7YeQM0mKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7209
X-OriginatorOrg: intel.com

On Wed, Jul 29, 2026 at 08:37:54AM +0800, Jason Xing wrote:
> On Tue, Jul 28, 2026 at 7:33 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Tue, Jul 28, 2026 at 08:07:48AM +0800, Jason Xing wrote:
> > > Hi Maciej,
> > >
> > > On Mon, Jul 27, 2026 at 8:09 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Fri, Jul 24, 2026 at 11:42:46PM -0400, Cen Zhang (Microsoft) wrote:
> > > > > In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> > > > > loop without checking its return value. xsk_buff_can_alloc() only
> > > > > counts fill queue entries without validating their addresses, so it
> > > > > can succeed while xsk_buff_alloc() rejects all remaining entries and
> > > > > returns NULL.
> > > > >
> > > > >   Oops: general protection fault, probably for non-canonical address
> > > > >    0xdffffc0000000000
> > > > >   KASAN: null-ptr-deref in range
> > > > >    [0x0000000000000000-0x0000000000000007]
> > > > >   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
> > > > >   Call Trace:
> > > > >    xsk_generic_rcv+0x26d/0x5f0
> > > > >    xdp_do_generic_redirect+0x3c5/0xcf0
> > > > >    do_xdp_generic+0x92f/0xe70
> > > > >    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> > > > >
> > > > > Fix this with a two-stage transaction. First allocate and stage all
> > > > > buffers required for the packet, recycling all staged buffers with
> > > > > xsk_buff_free() if any allocation fails. Only after this stage
> > > > > succeeds, copy the data, reserve the RX descriptors, and release the
> > > > > buffers in an error-free loop.
> > > > >
> > > > > Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
> > > > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > > > Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> > >
> > > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> > >
> > > > > ---
> > > > > v2:
> > > > >  - Allocate all packet buffers before reserving RX descriptors.
> > > > >  - Recycle partially allocated buffers instead of only cancelling the
> > > > >   RX producer reservations.
> > > > > Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com
> > > > >
> > > > >  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
> > > > >  1 file changed, 26 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index f906d51b6699..383fc2b1de48 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> > > > >       u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
> > > > >       void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
> > > > >       u32 from_len, meta_len, rem, num_desc;
> > > > > -     struct xdp_buff_xsk *xskb;
> > > > > +     struct xdp_buff_xsk *xskb, *tmp;
> > > > >       struct xdp_buff *xsk_xdp;
> > > > > +     LIST_HEAD(xsk_buffs);
> > > > >       skb_frag_t *frag;
> > > > > +     u32 i;
> > > > >
> > > > >       from_len = xdp->data_end - copy_from;
> > > > >       meta_len = xdp->data - copy_from;
> > > > > @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> > > > >               frag =  &sinfo->frags[0];
> > > > >       }
> > > > >
> > > > > +     for (i = 0; i < num_desc; i++) {
> > > > > +             xsk_xdp = xsk_buff_alloc(xs->pool);
> > > > > +             if (!xsk_xdp)
> > > > > +                     goto err_alloc;
> > > > > +
> > > > > +             xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > > > > +             if (unlikely(!list_empty(&xskb->list_node)))
> > > > > +                     goto err_alloc;
> > > > > +             list_add_tail(&xskb->list_node, &xsk_buffs);
> > > >
> > > > could we use existing xsk_buff_add_frag() ?
> > > > then I presume xsk_buff_free() would understand list and walk through
> > > > xdp_buff's and free it ?
> > >
> > > Good suggestion, but xsk_buff_add_frag() will add more irrelevant
> > > stuff like nr_frags, xdp_frags_size, xdp_frags_truesize... They are
> > > all happening in the softirq context. Refactoring the helper would
> > > bring more work here.
> >
> > Fair enough, how about we meet in the halfway?
> >
> > Don't use xxx_add_frag but reuse pool's list. Reason I'm pushing for it is
> > xsk_buff_free() has been thought to consume multi-buffer xskb's, so all
> > the list-walking would be hidden and error path would only consist of a
> > single free() call.
> 
> It does make sense (reusing/developing common helpers is always a good
> way to go). Side note: maybe Cen needs to handle
> xdp_buff_set_frags_flag() to allow xsk_buff_free() freeing a list of
> nodes.

Yeah exactly this needs to be done on a 'head' xskb.

> 
> >
> > then the do/while loop while iterating could be using xsk_buff_add_frag()
> 
> But I don't get it. Sorry. Are you saying we still need to call
> xsk_buff_add_frag()?

Sorry i meant xsk_buff_get_frag() which would be peeeling off xskbs from
pool's xskb_list.

> 
> Thanks,
> Jason
> 
> >
> > >
> > > Honestly, I like the local array which seems simpler/cleaner to understand :)
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > I believe we could reuse pool's xskb_list instead of fabricating the
> > > > on-stack variant here.
> > > >
> > > > > +     }
> > > > > +
> > > > >       do {
> > > > >               u32 to_len = frame_size + meta_len;
> > > > >               u32 copied;
> > > > >
> > > > > -             xsk_xdp = xsk_buff_alloc(xs->pool);
> > > > > +             xskb = list_first_entry(&xsk_buffs, struct xdp_buff_xsk,
> > > > > +                                     list_node);
> > > > > +             list_del_init(&xskb->list_node);
> > > > > +             xsk_xdp = &xskb->xdp;
> > > > >               copy_to = xsk_xdp->data - meta_len;
> > > > >
> > > > >               copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
> > > > >               rem -= copied;
> > > > >
> > > > > -             xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > > > >               __xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> > > > >                                 rem ? XDP_PKT_CONTD : 0);
> > > > >               meta_len = 0;
> > > > >       } while (rem);
> > > > >
> > > > >       return 0;
> > > > > +
> > > > > +err_alloc:
> > > > > +     list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> > > > > +             list_del_init(&xskb->list_node);
> > > > > +             xsk_buff_free(&xskb->xdp);
> > > > > +     }
> > > > > +     xs->rx_dropped++;
> > > > > +     return -ENOMEM;
> > > > >  }
> > > > >
> > > > >  static bool xsk_tx_writeable(struct xdp_sock *xs)
> > > > > --
> > > > > 2.53.0
> > > > >
> > > >
